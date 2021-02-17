library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity BCD_2_ASCII_Decoder is
	port(dataIn  : in  std_logic_vector(3 downto 0);
		  dataOut : out std_logic_vector(7 downto 0));
end BCD_2_ASCII_Decoder;

architecture behav of BCD_2_ASCII_Decoder is
	
begin  
	
	process(dataIn)
	begin
		case(dataIn) is
			when "0000" => 
				dataOut <= X"30"; -- 0
				
			when "0001" => 
				dataOut <= X"31"; -- 1
				
			when "0010" => 
				dataOut <= X"32"; -- 2
				
			when "0011" => 
				dataOut <= X"33"; -- 3
				
			when "0100" => 
				dataOut <= X"34"; -- 4
				
			when "0101" => 
				dataOut <= X"35"; -- 5
				
			when "0110" => 
				dataOut <= X"36"; -- 6
				
			when "0111" => 
				dataOut <= X"37"; -- 7
				
			when "1000" => 
				dataOut <= X"38"; -- 8
				
			when "1001" => 
				dataOut <= X"39"; -- 9
				
			when others =>
				dataOut <= X"20"; -- (space)
			
		end case;	
	end process;
		
end behav;