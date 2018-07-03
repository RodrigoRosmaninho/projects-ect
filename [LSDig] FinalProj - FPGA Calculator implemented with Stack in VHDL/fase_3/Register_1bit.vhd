library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Register_1bit is
	port(clk    : in std_logic;
		  input  : in std_logic;
		  output : out std_logic);
end Register_1bit;

architecture behav of Register_1bit is
begin

	process(clk)
	begin
		if(rising_edge(clk)) then
			output <= input;
		end if;
	end process;

end behav;