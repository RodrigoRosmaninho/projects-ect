library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity AES128_TopLevelTb is
end AES128_TopLevelTb;

architecture Stimulus of AES128_TopLevelTb is 
  signal s_resetn, s_clk, s_finish : std_logic;
  signal s_key_in : std_logic_vector(127 downto 0);
  signal s_block_in : std_logic_vector(127 downto 0);
  signal s_enc : std_logic_vector(127 downto 0);
  
  component AES128_TopLevel
        port(   clk: in std_logic;
                resetn:     in std_logic;
                key_in:     in std_logic_vector(127 downto 0);
                block_in:   in std_logic_vector(127 downto 0);
                enc:        out std_logic_vector(127 downto 0);
                finish:     out std_logic
            );
  end component;

begin
  uut : AES128_TopLevel
        port map(clk    => s_clk,
                 resetn  => s_resetn,
                 key_in   => s_key_in,
                 block_in => s_block_in,
                 enc   => s_enc,
                 finish => s_finish);
                 
  clock_proc : process
  begin
    s_clk <= '0'; wait for 2 ns;
    s_clk <= '1'; wait for 2 ns;
  end process;
  
  stim_proc : process
    begin
    
      s_block_in    <= x"77034da442d1059e3090b973c80ec392";
      s_key_in      <= x"5cd5479f6e9817e9bb4d2d8638dcdd14";
      -- result: 89de503727a0bd9985ba53d1c1e16e01
      wait for 4 ns;
          
      s_resetn <= '1';
      wait for 400 ns;
      
      s_resetn <= '0';
      wait for 8 ns;
      
      s_block_in    <= x"00112233445566778899aabbccddeeff";
      s_key_in      <= x"000102030405060708090a0b0c0d0e0f";
      -- result: 69c4e0d86a7b0430d8cdb78070b4c55a
      wait for 4 ns;
      
      s_resetn <= '1';
      wait for 400 ns;
      
      s_resetn <= '0';
      wait;
      
    end process;
end Stimulus;