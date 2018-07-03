library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity blocoValidacao is 
	port (clock          : in  std_logic;
	      enable         : in  std_logic;
			opCode         : in  std_logic_vector(2 downto 0);
	      address		   : in  std_logic_vector (4 downto 0);
	      hasSpace		   : out std_logic;
	      hasOperands	   : out std_logic);
end blocoValidacao;

architecture Behavioral of blocoValidacao is	
	
begin
	process(clock)
	begin
		if(rising_edge(clock)) then
			if(enable = '1') then
				if (unsigned(address) < 2) then
					if(opCode = "100" and address = "00001") then
						hasOperands <= '1';
					else
						hasOperands <= '0';
					end if;
					hasSpace <= '1';
				elsif (unsigned(address) = to_unsigned(16,5)) then
					hasOperands <= '1';
					hasSpace <= '0';
				else
					hasOperands <= '1';
					hasSpace <= '1';
				end if;
			end if;
		end if;
	end process;
	
end Behavioral;