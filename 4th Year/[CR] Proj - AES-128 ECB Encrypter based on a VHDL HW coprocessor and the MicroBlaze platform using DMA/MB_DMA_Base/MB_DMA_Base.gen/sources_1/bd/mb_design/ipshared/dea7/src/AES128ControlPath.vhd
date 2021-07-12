library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity AES128ControlPath is
    port(   clk: in std_logic;
            clk_enable: in std_logic;
            reset: in std_logic;
            done_round: in std_logic;
            done_key_exp: in std_logic;
            key_exp_index: in std_logic_vector(1 downto 0);
            round_index: in std_logic_vector(3 downto 0);
            load_block: out std_logic;
            load_key: out std_logic;
            key_exp_count_enable: out std_logic;
            round_count_enable: out std_logic;
            key_exp_count_reset: out std_logic;
            round_count_reset: out std_logic;
            start_key_exp: out std_logic;
            start_round: out std_logic;
            finish: out std_logic);
end AES128ControlPath;

architecture Behavioral of AES128ControlPath is
    type TState is (RST, LOAD_AESKEY, LOAD_AESBLOCK, EXPAND_AESKEY, ROUND, DONE);
    signal currState, nextState : TState;
    
begin

sync_proc: process(clk)
    begin
        if rising_edge(clk) then
            if clk_enable = '1' then
                if reset = '1' then
                    currState <= RST;
                else
                    currState <= nextState;
                end if;
            end if;
        end if;
   end process;
   
   comb_proc: process(currState, done_key_exp, done_round)
   begin
        load_key <= '0';
        load_block <= '0';
        key_exp_count_enable <= '0';
        round_count_enable <= '0';
        key_exp_count_reset <= '0';
        round_count_reset <= '0';
        start_key_exp <= '0';
        start_round <= '0';
        finish <= '0';
        
        case currState is
            when RST =>
                round_count_reset <= '1';
                key_exp_count_reset <= '1';
                nextState <= LOAD_AESKEY;
            when LOAD_AESKEY =>
                load_key <= '1';
                nextState <= LOAD_AESBLOCK;
            when LOAD_AESBLOCK =>
                load_block <= '1';
                nextState <= EXPAND_AESKEY;
            when EXPAND_AESKEY =>
                start_key_exp <= '1';
                if done_key_exp = '1' then
                    nextState <= ROUND;
                else
                    nextState <= EXPAND_AESKEY;
                end if;
            when ROUND =>
                start_round <= '1';
                nextState <= EXPAND_AESKEY;                
                if done_round = '1' then
                    nextState <= DONE;
                end if;
            when DONE =>
                finish <= '1';
                nextState <= DONE;
            when others =>
                nextState <= RST;
        end case;
    end process;
end Behavioral;
