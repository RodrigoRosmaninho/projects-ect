library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity calculadora is
	port(clock                 : in  std_logic;
		  enable                : in  std_logic;
		  complete_in           : in  std_logic;
		  reset                 : in  std_logic;
		  a, b, valIn 	         : in  std_logic_vector(7 downto 0);
	     opCode                : in  std_logic_vector(2 downto 0);
		  ext_address           : in  std_logic_vector(4 downto 0);
	     valOut1, valOut2      : out std_logic_vector(7 downto 0);
		  current_addr          : out std_logic_vector(4 downto 0);
		  addrOut1, addrOut2    : out std_logic_vector(4 downto 0);
		  ram_enable            : out std_logic;
		  complete              : out std_logic;
		  overflow              : out std_logic;
		  divByZero             : out std_logic);
end calculadora;

architecture Behavioral of calculadora is

	signal s_a, s_b, s_temp : signed(7 downto 0);
	signal address : unsigned(4 downto 0) := to_unsigned(0,5);
	signal s_ext_address : unsigned(4 downto 0);
	signal s_overflow, s_divByZero, s_complete1, s_wait : std_logic := '0'; 
	
begin

	current_addr <= std_logic_vector(address);
	s_a <= signed(a); -- Primeiro operando
	s_b <= -signed(b) when opCode = "001" else signed(b); -- Para fazer a subtracao faz-se s_a + (-s_b) de forma a ser mais facil detetar overflow
	
	overflow <= s_overflow;
	divByZero <= s_divByZero;
			
	process(clock)
	begin
		if(rising_edge(clock)) then
			if(reset = '1') then
				s_complete1 <= '0';
				address <= to_unsigned(0,5);
			elsif(enable = '1' and s_complete1 = '0') then
				s_overflow <= '0';
				s_divByZero <= '0';
				
				case opCode is
					when "000" | "001" => -- SOMA e SUB
						s_temp <= s_a + s_b;
						s_wait <= '1';
						
						if(s_wait = '1') then
							valOut2 <= std_logic_vector(s_temp); -- valor que ficara no topo da pilha
							if ((s_a > 0 and s_b > 0 and s_temp < 0) or (s_a < 0 and s_b < 0 and s_temp > 0)) then 
								s_overflow <= '1';
							end if;
							valOut1 <= "00000000";
							addrOut1 <= std_logic_vector(unsigned(address) - 1);
							addrOut2 <= std_logic_vector(unsigned(address) - 2);
							address <= address - 1; -- decrementar o address pois foram removidos ambos os operandos e apenas foi inserido um valor (o resultado da operacao)
							ram_enable <= '1';
							s_complete1 <= '1';
							s_wait <= '0';
						end if;
			
					when "010" => -- MUL
						valOut2 <= std_logic_vector(s_a * s_b)(7 downto 0);
						valOut1 <= "00000000";
						addrOut1 <= std_logic_vector(unsigned(address) - 1);
						addrOut2 <= std_logic_vector(unsigned(address) - 2);
						address <= address - 1;
						ram_enable <= '1';
						s_complete1 <= '1';

			
					when "011" => -- DIV
						if(s_b = to_signed(0, 8)) then
							s_divByZero <= '1';
						else
							valOut1 <= std_logic_vector(s_a / s_b); -- valor que vai ficar no topo da pilha
							valOut2 <= std_logic_vector(s_a rem s_b); -- valor seguinte
							addrOut1 <= std_logic_vector(unsigned(address) - 1);
							addrOut2 <= std_logic_vector(unsigned(address) - 2);
							ram_enable <= '1';
						end if;
						s_complete1 <= '1';
						
					when "100" => -- DEL
						-- Serve para eliminar o valor no topo da pilha
						s_wait <= '1';
						if(address > 0 and s_wait <= '0') then
							address <= address - 1;
						end if;
						if(s_wait = '1') then
							s_complete1 <= '1';
							s_wait <= '0';
						end if;
			
					when "101" => -- SWAP
						valOut1 <= b;
						valOut2 <= a;
						addrOut1 <= std_logic_vector(unsigned(address) - 1);
						addrOut2 <= std_logic_vector(unsigned(address) - 2);
						ram_enable <= '1';
						s_complete1 <= '1';
						
					when "110" => -- SWAP (mas que aceita um valor de address externo)
						-- Usado para remover elementos em qualquer posicao da pilha
						-- Fazer operacoes de SWAP a partir da posicao inicial ate ao topo da pilha, incrementando o address usado a cada ciclo
						-- Desta forma, podemos, efetivamente, eliminar um valor da pilha
						if(address = to_unsigned(1,5)) then -- Se ja so existe um elemento na pilha, elimina-lo normalmente
							address <= to_unsigned(0,5);
							s_complete1 <= '1';
						elsif(address > 0) then
							s_wait <= '1';
							addrOut1 <= std_logic_vector(s_ext_address + 1);
							addrOut2 <= std_logic_vector(s_ext_address);
							if(s_wait = '1') then
								valOut1 <= b;
								valOut2 <= a;
								ram_enable <= '1';
								s_ext_address <= s_ext_address + 1;
								s_wait <= '0';
								if(s_ext_address = address) then
									address <= address - 1;
									s_complete1 <= '1';
									s_wait <= '0';
								end if;
							end if;
						else
							s_complete1 <= '1';
						end if;
						
						
					when "111" => -- INS 
						-- Serve para inserir um valor no topo da pilha
						valOut1 <= valIn;
						valOut2 <= a;
						addrOut1 <= std_logic_vector(unsigned(address));
						addrOut2 <= std_logic_vector(unsigned(address) - 1);
						address <= address + 1;
						ram_enable <= '1';
						s_complete1 <= '1';

					
					when others =>
						valOut1 <= "00000000";
						valOut2 <= "00000000";
						
				end case;
				
			elsif(enable = '1' and s_complete1 = '1') then
				if(complete_in = '1' or s_divByZero = '1' or opCode = "100" or opCode = "110") then
					-- Ativar sinal 'complete' se a operacao de escrita na RAM terminou (complete_in = '1') ou se ocorreu uma divisao por zero ou operacao DEL (pelo que nao foi preciso escrever na RAM)
					-- Se foi efetuada uma operacao SWAP com valores de address externos (opCode 110) nao e necessario esperar pela RAM nesta fase. Isso e feito durante a operacao
					ram_enable <= '0';
					complete <= '1';
				end if;
			elsif(enable = '0') then
				s_ext_address <= unsigned(ext_address);
				complete <= '0';
				s_complete1 <= '0';
				ram_enable <= '0';
				s_wait <= '0';
			end if;
		end if;
	end process;
	
end Behavioral;