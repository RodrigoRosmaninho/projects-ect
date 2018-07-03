library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity controlpath is
	port(clock            : in  std_logic;
		  SW               : in  std_logic_vector(3 downto 0);
	     KEY              : in  std_logic_vector(3 downto 0);
		  complete_pos     : in  std_logic;
		  complete_calc    : in  std_logic;
		  hasOperands      : in  std_logic;
		  hasSpace         : in  std_logic;
		  en_eliminarPos   : out std_logic;
		  en_verPilha      : out std_logic;
		  en_operando      : out std_logic;
		  en_operador      : out std_logic;
		  en_valOperando   : out std_logic;
		  en_valOperador   : out std_logic;
		  en_stackOperando : out std_logic;
		  en_stackOperador : out std_logic;
		  en_posOperando   : out std_logic;
		  en_posOperador   : out std_logic;
		  reset            : out std_logic);
end controlpath;

architecture fsm of controlpath is

	type Tstate is (ver_pilha, introd_num, introd_op, guardar_num, calcular_op, eliminar_pos, validar_num, validar_op, erro_num, erro_op);
	signal PS, NS: TState;
	
	signal s_button_clicked : std_logic := '0';

begin

	process(clock)
	begin
		if(rising_edge(clock)) then
			if(SW(3) = '1') then
				PS <= introd_num;
				reset <= '1';
			else
				PS <= NS;
				reset <= '0';
			end if;
		end if;
	end process;
	
	process(PS, SW, KEY, complete_calc, complete_pos, hasOperands, hasSpace)
	begin
	
		en_eliminarPos   <= '0';
		en_verPilha      <= '0';
		en_operando      <= '0';
		en_operador      <= '0';
		en_valOperando   <= '0';
		en_valOperador   <= '0';
		en_stackOperando <= '0';
		en_stackOperador <= '0';
		en_posOperando   <= '0';
		en_posOperador   <= '0'; 
	
		case PS is
		
			-- Estado de Visualizacao da Pilha
			when ver_pilha =>
				en_verPilha <= '1';
				if(SW(1) = '0') then
					if(SW(0) = '0') then
						NS <= introd_num;
					else
						NS <= introd_op;
					end if;
				elsif(KEY(1) = '1') then
					NS <= eliminar_pos;
				else
					NS <= ver_pilha;
				end if;
					
			-- Estado de Introducao de Operandos
			when introd_num =>
				en_operando <= '1';
				if(SW(1) = '1') then
					NS <= ver_pilha;
				elsif(SW(0) = '1') then
					NS <= introd_op;
				elsif(KEY(0) = '1') then
					NS <= validar_num;
				else
					NS <= introd_num;
				end if;
			
			-- Estado de Introducao de Operadores
			when introd_op =>
				en_operador <= '1';
				if(SW(1) = '1') then
					NS <= ver_pilha;
				elsif(SW(0) = '0') then
					NS <= introd_num;
				elsif(KEY(0) = '1') then
					NS <= validar_op;
				else
					NS <= introd_op;
				end if;
				
			-- Introduzir novo operando na RAM
			when guardar_num =>
				en_stackOperando <= '1';
				if(complete_calc = '1'  and KEY = "0000") then
					NS <= erro_num;
				else
					NS <= guardar_num;
				end if;
				
			when calcular_op =>
				en_stackOperador <= '1';
				if(complete_calc = '1' and KEY = "0000") then
					NS <= erro_op;
				else
					NS <= calcular_op;
				end if;
				
			when eliminar_pos =>
				en_eliminarPos <= '1';
				if(complete_calc = '1' and KEY = "0000") then
					NS <= ver_pilha;
				else
					NS <= eliminar_pos;
				end if;
				
			when validar_num =>
				en_valOperando <= '1';
				if(hasSpace = '0' and KEY = "0000") then
					NS <= erro_num;
				elsif(hasSpace = '1') then
					NS <= guardar_num;
				else
					NS <= validar_num;
				end if;
				
			when validar_op =>
				en_valOperador <= '1';
				if(hasOperands = '0' and KEY = "0000") then
					NS <= erro_op;
				elsif(hasOperands = '1') then
					NS <= calcular_op;
				else
					NS <= validar_op;
				end if;
				
			when erro_num =>
				en_posOperando <= '1';
				if(complete_pos = '1' and KEY = "0000") then
					NS <= introd_num;
				else
					NS <= erro_num;
				end if;
				
			when erro_op =>
				en_posOperador <= '1';
				if(complete_pos = '1' and KEY = "0000") then
					NS <= introd_op;
				else
					NS <= erro_op;
				end if;
				
			when others =>
				if(SW(1) = '0') then
					if(SW(0) = '0') then
						NS <= introd_num;
					else
						NS <= introd_op;
					end if;
				elsif(SW(1) = '1') then
					NS <= ver_pilha;
				end if;
			
			end case;
	end process;
end fsm;