library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity introd_operadores is
	port(clock       : in  std_logic;
		  reset       : in  std_logic;
	     KEY         : in  std_logic;
		  enable      : in  std_logic;
		  op_complete : in  std_logic;
		  dataOut     : out std_logic_vector(2 downto 0));
end introd_operadores;

architecture behav of introd_operadores is

	signal s_dataOut : unsigned(2 downto 0) := to_unsigned(0,3);
	signal s_buttonClicked : std_logic := '0';

begin

	process(clock, reset)
	begin
		if(reset = '1') then
			s_dataOut <= to_unsigned(0,3);
			s_buttonClicked <= '0';
		elsif(rising_edge(clock)) then
			if(op_complete = '1') then
				s_dataOut <= to_unsigned(0,3);
				s_buttonClicked <= '0';
			elsif(enable = '1') then
				if((KEY = '1') and (s_buttonClicked = '0')) then
					if((s_dataOut + 1) = to_unsigned(6,3)) then
						s_dataOut <= to_unsigned(0,3);
						s_buttonClicked <= '1';
					else
						s_dataOut <= s_dataOut + 1;
						s_buttonClicked <= '1';
					end if;
				
				elsif(KEY = '0') then
					s_buttonClicked <= '0';
				end if;
			end if;
		end if;
	end process;
	
	dataOut <= std_logic_vector(s_dataOut);

end behav;