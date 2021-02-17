library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity freqDivider is
	generic (div	: natural := 2);
	port (clkIn		: in std_logic;
			clkOut	: out std_logic);
end freqDivider;

architecture Behavioral of freqDivider is
	
	signal s_counter	: natural;
	signal s_halfWay	: natural  := (div/2)-1;
	
begin 
	process (clkIn)
	begin
		if (rising_edge (clkIn)) then
			if (s_counter = s_halfWay) then 
				clkOut 		<= '1';
				s_counter 	<= s_counter + 1;
			elsif (s_counter = div-1) then
				clkOut 		<= '0';
				s_counter 	<= 0;
			else 
				s_counter 	<= s_counter +1;
			end if;
		end if;
	end process;
end Behavioral;