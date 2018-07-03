library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity opCodeDecoder is
	port(opCode  : in  std_logic_vector(2 downto 0);
		  HEX3    : out std_logic_vector(4 downto 0);
		  HEX2    : out std_logic_vector(4 downto 0);
		  HEX1    : out std_logic_vector(4 downto 0);
		  HEX0    : out std_logic_vector(4 downto 0);
		  en_hex3 : out std_logic;
		  en_hex2 : out std_logic;
		  en_hex1 : out std_logic;
		  en_hex0 : out std_logic);
end opCodeDecoder;

architecture behav of opCodeDecoder is
begin

	en_hex3 <= '1';
	en_hex2 <= '1';
	en_hex1 <= '1';
	
	HEX3  <= "01011" when (opCode = "000") else -- S (SOMA)
				"01011" when (opCode = "001") else -- S (SUB)
				"01101" when (opCode = "010") else -- M (MUL)
				"10010" when (opCode = "011") else -- d (DIV)
				"10010" when (opCode = "100") else -- d (DEL)
				"01011" when (opCode = "101") else -- S (SWAP)
				"01100" when (opCode = "110") else -- O (OvF)
				"10101" when (opCode = "111") else -- E (ERRO)
			   "01010";
				
	HEX2  <= "01100" when (opCode = "000") else -- O (SOMA)
				"01111" when (opCode = "001") else -- U (SUB)
				"01111" when (opCode = "010") else -- U (MUL)
				"10011" when (opCode = "011") else -- I (DIV)
				"10101" when (opCode = "100") else -- E (DEL)
				"01111" when (opCode = "101") else -- W (SWAP)
				"10111" when (opCode = "110") else -- v (OvF)
				"11001" when (opCode = "111") else -- R (ERRO)
			   "01010";
				
	HEX1  <= "01101" when (opCode = "000") else -- M (SOMA)
				"10000" when (opCode = "001") else -- b (SUB)
				"10001" when (opCode = "010") else -- L (MUL)
				"10111" when (opCode = "011") else -- v (DIV)
				"10001" when (opCode = "100") else -- L (DEL)
				"01110" when (opCode = "101") else -- A (SWAP)
				"11000" when (opCode = "110") else -- F (OvF)
				"11001" when (opCode = "111") else -- R (ERRO)
			   "01010";
				
	HEX0  <= "01110" when (opCode = "000") else -- A (SOMA)
				"10100" when (opCode = "101") else -- P (SWAP)
				"01100" when (opCode = "111") else -- O (ERRO)
			   "01010";
			
	en_hex0 <= '0' when (opCode = "001" or opCode = "010" or opCode = "011" or opCode = "100" or opCode = "110") else '1';
	
end behav;