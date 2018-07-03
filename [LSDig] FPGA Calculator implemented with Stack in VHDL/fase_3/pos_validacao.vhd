library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity pos_validacao is
	port(clk          : in  std_logic;
		  enable       : in  std_logic;
		  op_or_introd : in  std_logic;
		  overflow     : in  std_logic;
		  divByZero    : in  std_logic;
		  hasOperands  : in  std_logic;
		  hasSpace     : in  std_logic;
		  opCode       : out std_logic_vector(2 downto 0);
		  hasError     : out std_logic;
		  complete     : out std_logic;
		  LEDR         : out std_logic_vector(3 downto 0);
		  LEDG         : out std_logic_vector(0 downto 0));
end pos_validacao;

architecture behav of pos_validacao is

	signal enable_count, s_complete : std_logic := '0';
	signal count : unsigned(27 downto 0) := to_unsigned(0,28);
	signal max_count : unsigned(27 downto 0);

begin

	complete <= s_complete;
	
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(enable = '1' and s_complete = '0') then
				if(overflow = '1' and op_or_introd = '0') then
					max_count <= to_unsigned(150000000, 28); -- 3 segundos
					opCode <= "110";
					hasError <= '1';
					enable_count <= '1';
					LEDR(2) <= '1';
				elsif(hasSpace = '0' and op_or_introd = '1') then
					max_count <= to_unsigned(150000000, 28); -- 3 segundos
					opCode <= "111";
					enable_count <= '1';
					hasError <= '1';
					LEDR(0) <= '1';
				elsif((hasOperands = '0' and op_or_introd = '0')) then
					max_count <= to_unsigned(150000000, 28); -- 3 segundos
					opCode <= "111";
					enable_count <= '1';
					hasError <= '1';
					LEDR(1) <= '1';
				elsif(divByZero = '1' and op_or_introd = '0') then
					max_count <= to_unsigned(150000000, 28); -- 3 segundos
					opCode <= "111";
					enable_count <= '1';
					hasError <= '1';
					LEDR(3) <= '1';
				else
					max_count <= to_unsigned(16666666, 28); -- 0.33 segundos
					enable_count <= '1';
					hasError <= '0';
					LEDG <= "1";
				end if;
			else
				s_complete <= '0';
				hasError <= '0';
				enable_count <= '0';
				count <= to_unsigned(0,28);
				LEDR <= "0000";
				LEDG <= "0";
			end if;
		
			if(enable = '1' and enable_count = '1') then
				if(count < max_count) then
					count <= count + 1;
				else
					s_complete <= '1';
				end if;
			end if;
		end if;
	end process;

end behav;