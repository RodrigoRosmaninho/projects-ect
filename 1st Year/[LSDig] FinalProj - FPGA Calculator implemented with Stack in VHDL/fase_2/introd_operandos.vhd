library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity introd_operandos is
	port(clock   : in  std_logic;
		  reset   : in  std_logic;
		  SW2     : in  std_logic;
	     KEY     : in  std_logic_vector(2 downto 0);
		  enable  : in  std_logic;
		  dataOut : out std_logic_vector(7 downto 0));
end introd_operandos;

architecture behav of introd_operandos is

	signal s_dataOut : signed(8 downto 0) := to_signed(0,9);
	signal s_uni, s_dec, s_cen : unsigned(3 downto 0);
	signal s_buttonClicked, s_keep : std_logic := '0';

begin

	process(clock, reset)
	begin
		if(reset = '1') then
			s_dataOut <= to_signed(0,9);
			s_keep <= '0';
			s_buttonClicked <= '0';
		elsif(rising_edge(clock)) then
			if(enable = '1') then
				if(s_keep = '1') then
					s_dataOut <= to_signed(0,9);
					s_keep <= '0';
				end if;
				
				-- Apenas se podem aceitar valores dentro da gama [-128, 127]
				-- Devido ao numero ser guardado em complemento para 2 em 8 bits
				
				if((KEY(0) = '1') and (s_buttonClicked = '0')) then
					if((s_dataOut + 1 > 128) or ((s_dataOut + 1 = 128) and (SW2 = '0'))) then
						s_dataOut <= to_signed(0,9);
						s_buttonClicked <= '1';
					else
						s_dataOut <= s_dataOut + to_signed(1,9);
						s_buttonClicked <= '1';
					end if;
			
				elsif((KEY(1) = '1') and (s_buttonClicked = '0')) then
					if((s_dataOut + 10 > 128) or ((s_dataOut + 10 = 128) and (SW2 = '0'))) then
						s_dataOut <= to_signed(0,9);
						s_buttonClicked <= '1';
					else
						s_dataOut <= s_dataOut + to_signed(10,9);
						s_buttonClicked <= '1';
					end if;
			
				elsif((KEY(2) = '1') and (s_buttonClicked = '0')) then
					if((s_dataOut + 100 > 128) or ((s_dataOut + 100 = 128) and (SW2 = '0'))) then
						s_dataOut <= to_signed(0,9);
						s_buttonClicked <= '1';
					else
						s_dataOut <= s_dataOut + to_signed(100,9);
						s_buttonClicked <= '1';
					end if;
				
				elsif(KEY = "000") then
					s_buttonClicked <= '0';
				end if;
				
			else
				s_keep <= '1';
			end if;
		end if;
	end process;
	
	dataOut <= std_logic_vector(-(s_dataOut(7 downto 0))) when (SW2 = '1') else std_logic_vector(s_dataOut(7 downto 0));

end behav;