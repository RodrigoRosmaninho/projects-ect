library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity CounterDownBCD is
	port(clk       : in  std_logic;
		  enable    : in  std_logic;
		  load      : in  std_logic;
		  input     : in  std_logic_vector(15 downto 0);
		  output    : out std_logic_vector(15 downto 0);
		  timerEnd  : out std_logic);
end CounterDownBCD;

architecture Behav of CounterDownBCD is

	signal MinDec : unsigned(3 downto 0) := "0101";
	signal MinUni : unsigned(3 downto 0) := "1001";
	signal SegDec : unsigned(3 downto 0) := "0101";
	signal SegUni : unsigned(3 downto 0) := "1001";

begin

	process(clk)
	begin
		if(load = '1') then
				MinDec <= unsigned(input(15 downto 12));
				MinUni <= unsigned(input(11 downto 8));
				SegDec <= unsigned(input(7 downto 4));
				SegUni <= unsigned(input(3 downto 0));
				timerEnd <= '0';
		elsif(rising_edge(clk)) then
			if(enable = '1') then
				if(SegUni = "0000") then
					if(SegDec = "0000") then
						if(MinUni = "0000") then
							if(MinDec = "0000") then
								timerEnd <= '1';
							else
								MinDec <= MinDec - 1;
								MinUni <= "1001";
								SegDec <= "0101";
								SegUni <= "1001";
								timerEnd <= '0';
							end if;
						else
							MinUni <= MinUni - 1;
							SegDec <= "0101";
							SegUni <= "1001";
							timerEnd <= '0';
							timerEnd <= '0';
						end if;
					else
						SegDec <= SegDec - 1;
						SegUni <= "1001";
						timerEnd <= '0';
					end if;
				else
					SegUni <= SegUni - 1;
					timerEnd <= '0';
				end if;
			end if;
		end if;
		
	output <= std_logic_vector(MinDec & MinUni & SegDec & SegUni);
	
	end process;
end Behav;