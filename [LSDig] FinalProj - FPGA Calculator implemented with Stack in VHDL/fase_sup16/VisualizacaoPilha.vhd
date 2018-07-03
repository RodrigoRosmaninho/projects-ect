library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity VisualizacaoPilha is
	port (enable	  : in  std_logic;
	      clk	     : in  std_logic;
			reset      : in  std_logic;
	      addressMax : in  std_logic_vector (4 downto 0);
	      KEY	     : in  std_logic_vector (1 downto 0);
	      addressOut : out std_logic_vector (4 downto 0));
end VisualizacaoPilha;

architecture Behavioral of VisualizacaoPilha is
	signal s_count	: unsigned(4 downto 0) := to_unsigned(0,5);
	signal s_buttonClicked : std_logic := '0';
begin
	process (clk)
	begin
		if (rising_edge(clk)) then 
			if(reset = '1') then
				s_count <= to_unsigned(0,5);
				s_buttonClicked <= '0';
			elsif (enable = '1') then
				if (KEY(0) = '1' and s_buttonClicked = '0') then
					if ((s_count + 1) < unsigned(addressMax)) then
						s_count <= s_count + 1;
						s_buttonClicked <= '1';
					end if;
				elsif (KEY(1) = '1' and s_buttonClicked = '0') then
					if ((s_count) /= to_unsigned(0, 5)) then
						s_count <= s_count - 1;
						s_buttonClicked <= '1';
					end if;
				elsif(KEY = "00") then
					s_buttonClicked <= '0';
				end if;
			else
				s_count <= to_unsigned(0, 5);
			end if;
		end if;
	end process;
	addressOut <= std_logic_vector(s_count);
end Behavioral;