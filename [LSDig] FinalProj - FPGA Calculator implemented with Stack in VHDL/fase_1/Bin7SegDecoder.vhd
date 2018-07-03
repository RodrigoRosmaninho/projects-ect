library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Bin7SegDecoder is
	port (enable   : in std_logic;
			binInput	: in std_logic_vector (4 downto 0);
			dataOut	: out std_logic_vector (6 downto 0));
end Bin7SegDecoder;

architecture Behavioral of Bin7SegDecoder is
begin
	dataOut  <= "1111111" when (enable = '0') else -- En = 0
					"1111001" when (binInput = "00001") else -- 1
					"0100100" when (binInput = "00010") else -- 2
					"0110000" when (binInput = "00011") else -- 3
					"0011001" when (binInput = "00100") else -- 4
					"0010010" when (binInput = "00101") else -- 5
					"0000010" when (binInput = "00110") else -- 6
					"1111000" when (binInput = "00111") else -- 7
					"0000000" when (binInput = "01000") else -- 8
					"0010000" when (binInput = "01001") else -- 9
					---------------------------------------------
					"0111111" when (binInput = "01010") else -- -
					"0010010" when (binInput = "01011") else -- S
					"1000000" when (binInput = "01100") else -- O
					"1001000" when (binInput = "01101") else -- M
					"0001000" when (binInput = "01110") else -- A
					"1000001" when (binInput = "01111") else -- U
					"0000011" when (binInput = "10000") else -- b
					"1000111" when (binInput = "10001") else -- L
					"0100001" when (binInput = "10010") else -- d
					"1111011" when (binInput = "10011") else -- i
					"0001100" when (binInput = "10100") else -- P
					"0000110" when (binInput = "10101") else -- E
					"1100011" when (binInput = "10111") else -- v
					"0001110" when (binInput = "11000") else -- F
					"0101111" when (binInput = "11001") else -- r
					"1000000";
end Behavioral;		