library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity AES128_TopLevel is
        port(   clk: in std_logic;
                resetn:     in std_logic;
                key_in:     in std_logic_vector(127 downto 0);
                block_in:   in std_logic_vector(127 downto 0);
                enc:        out std_logic_vector(127 downto 0);
                finish:     out std_logic
            );
end AES128_TopLevel;

architecture Behavioral of AES128_TopLevel is

signal s_done_round: std_logic := '0';
signal s_done_key_exp: std_logic := '0';
signal s_load_block: std_logic;
signal s_load_key: std_logic;
signal s_start_key_exp: std_logic;
signal s_start_round: std_logic;
signal s_last_round: std_logic := '0';
signal s_finish: std_logic;

signal s_count_round: integer range 0 to 9 := 0;
signal s_count_key_index: integer range 0 to 3 := 0;

signal s_count_round_vec : std_logic_vector(3 downto 0);
signal s_count_key_index_vec : std_logic_vector(1 downto 0);

signal s_count_round_enable : std_logic;
signal s_count_key_index_enable : std_logic;

signal s_count_round_reset : std_logic;
signal s_count_key_index_reset : std_logic;

signal s_reset : std_logic;

signal s_count_cycles : integer := 0;
signal s_count_cycles_vec : std_logic_vector(15 downto 0);

signal s_enc: std_logic_vector(127 downto 0);

begin

-- key expansion and round control counters
process(clk, s_count_round, s_count_round_enable, s_count_key_index_enable, s_count_key_index, s_start_round, s_start_key_exp)
begin
    if rising_edge(clk) then
        s_done_key_exp <= '0';
        
        if s_count_key_index_reset = '1' then
            s_count_key_index <= 0;
            s_last_round <= '0';
            s_done_round <= '0';
        end if;
        
        if s_count_round_reset = '1' then
            s_count_round <= 0;
        end if;
        
        if s_start_round = '1' then
            if s_count_round = 9 then
                s_done_round <= '1';
                s_count_round <= 0;
            else
                if s_count_round = 8 then
                    s_last_round <= '1';
                end if;
                s_count_round <= s_count_round + 1;
            end if;
        end if;
        
        if s_start_key_exp = '1' then
            if s_count_key_index = 3 then
                s_count_key_index <= 0;
            else
                s_count_key_index <= s_count_key_index + 1;
                if s_count_key_index = 2 then
                    s_done_key_exp <= '1';
                end if;
            end if;
        end if;
    end if;
end process;

s_count_round_vec <= std_logic_vector(to_unsigned(s_count_round, 4));
s_count_key_index_vec <= std_logic_vector(to_unsigned(s_count_key_index, 2));
s_count_cycles_vec <= std_logic_vector(to_unsigned(s_count_cycles, 16));

finish <= s_finish;

s_reset <= not resetn;

-- control path
cpath: entity work.AES128ControlPath(Behavioral)
        port map (  clk => clk,
                    reset => s_reset,
                    clk_enable => '1',
                    done_round => s_done_round,
                    done_key_exp => s_done_key_exp,
                    load_key => s_load_key,
                    load_block => s_load_block,
                    key_exp_index => s_count_key_index_vec,
                    round_index => s_count_round_vec,
                    key_exp_count_enable => s_count_key_index_enable,
                    round_count_enable => s_count_round_enable,
                    key_exp_count_reset => s_count_key_index_reset,
                    round_count_reset => s_count_round_reset,
                    start_key_exp => s_start_key_exp,
                    start_round => s_start_round,
                    finish => s_finish
                 );  

-- data path
dpath1: entity work.AES128Decoder(Behavioral)
        port map (  clk => clk,
                    reset => s_reset,
                    clk_enable => '1',
                    load_block => s_load_block,
                    load_key => s_load_key,
                    key_exp_index => s_count_key_index_vec,
                    round_index => s_count_round_vec,
                    start_key_exp => s_start_key_exp,
                    start_round => s_start_round,
                    last_round => s_last_round,
                    key_in => key_in,
                    blk_in => block_in,
                    enc => s_enc
                 );
enc <= s_enc;

end Behavioral;