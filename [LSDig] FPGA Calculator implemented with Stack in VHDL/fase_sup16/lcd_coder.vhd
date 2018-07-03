library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity lcd_coder is
	port(clk                                                                   : in std_logic;
		  opCode                                                                : in std_logic_vector(2 downto 0);
		  errorCode                                                             : in std_logic_vector(2 downto 0);
	     en_operador, en_operando, en_verPilha, en_posVal                      : in std_logic;
		  num_sinal, a_sinal, b_sinal                                           : in std_logic;
		  num_uni, num_dec, num_cen, current_uni, current_dec, viz_uni, viz_dec : in std_logic_vector(7 downto 0);
		  a_uni, a_dec, a_cen, b_uni, b_dec, b_cen                              : in std_logic_vector(7 downto 0);
	     first_line, second_line                                               : out std_logic_vector(127 downto 0));
end lcd_coder;

architecture behav of lcd_coder is

	signal s_num_sinal, s_a_sinal, s_b_sinal, s_operador : std_logic_vector(7 downto 0);
	
begin

	s_num_sinal <= X"20" when (num_sinal = '0') else X"2D";
	s_a_sinal <= X"20" when (a_sinal = '0') else X"2D";
	s_b_sinal <= X"20" when (b_sinal = '0') else X"2D";

	process(clk)
	begin
	
		if(rising_edge(clk)) then
			if(en_verPilha = '1') then
				if(current_dec = X"30" and current_uni = X"30") then
					first_line <= X"50_6F_73_69_63_61_6F_20" & viz_dec & viz_uni & X"3A_20_23_23_23_23";
				else
					first_line <= X"50_6F_73_69_63_61_6F_20" & viz_dec & viz_uni & X"3A_20" & s_a_sinal & a_cen & a_dec & a_uni;
				end if;
				second_line <= X"4E_27_4F_70_65_72_61_6E_64_6F_73_3A_20" & current_dec & current_uni & X"20";
	
			elsif(en_operando = '1') then
				first_line <= X"49_6E_74_72_6F_64_75_7A_69_72_3A_20" & s_num_sinal & num_cen & num_dec & num_uni;
				second_line <= X"4E_27_4F_70_65_72_61_6E_64_6F_73_3A_20" & current_dec & current_uni & X"20";
			
			elsif(en_operador = '1') then
				if(current_dec = X"30" and current_uni = X"30") then
					second_line <= X"20_20_20_23_23_23_23_20" & s_operador & X"20_23_23_23_23_20_20";
				elsif(current_dec = X"30" and current_uni = X"31") then
					second_line <= X"20_20_20" & s_a_sinal & a_cen & a_dec & a_uni & X"20" & s_operador & X"20_23_23_23_23_20_20";
				else
					second_line <= X"20_20_20" & s_a_sinal & a_cen & a_dec & a_uni & X"20" & s_operador & X"20" & s_b_sinal & b_cen & b_dec & b_uni & X"20_20";
				end if;
			
				case opCode is
				
					when "000" => -- SOMA
						first_line <= X"20_4F_70_65_72_61_63_61_6F_3A_20_53_4F_4D_41_20";
						s_operador <= X"2B";
					
					when "001" => -- SUB
						first_line <= X"20_4F_70_65_72_61_63_61_6F_3A_20_53_55_42_20_20";
						s_operador <= X"2D";
						
					when "010" => -- MULT
						first_line <= X"20_4F_70_65_72_61_63_61_6F_3A_20_4D_55_4C_54_20";
						s_operador <= X"2A";
						
					when "011" => -- DIV
						first_line <= X"20_4F_70_65_72_61_63_61_6F_3A_20_44_49_56_20_20";
						s_operador <= X"2F";
						
					when "100" => -- DEL
						first_line <= X"20_4F_70_65_72_61_63_61_6F_3A_20_44_45_4C_20_20";
						if(current_dec = X"30" and current_uni = X"30") then
							second_line <= X"20_45_6C_69_6D_69_6E_61_72_3A_20_23_23_23_23_20";
						else
							second_line <= X"20_45_6C_69_6D_69_6E_61_72_3A_20" & s_a_sinal & a_cen & a_dec & a_uni & X"20";
						end if;
						
					when "101" => -- SWAP
						first_line <= X"20_4F_70_65_72_61_63_61_6F_3A_20_53_57_41_50_20";
						second_line <= X"20" & s_a_sinal & a_cen & a_dec & a_uni & X"20_53_57_41_50_20" & s_b_sinal & b_cen & b_dec & b_uni & X"20";
					
					when others =>
						first_line <= X"2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D";
						second_line <= X"2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D";
					
				end case;
						
				elsif(en_posVal = '1') then 
					
					case errorCode is
						when "000" => -- OVERFLOW
							first_line <= X"20_20_20_20_20_4F_63_6F_72_72_65_75_20_20_20_20";
							second_line <= x"20_20_20_20_6F_76_65_72_66_6C_6F_77_21_20_20_20";
							
						when "001" => -- POUCO ESPAÇO
							first_line <= X"20_20_20_20_20_20_45_72_72_6F_20_20_20_20_20_20";
							second_line <= x"20_20_20_50_69_6C_68_61_20_63_68_65_69_61_20_20";
							
						when "010" => -- POUCOS OPERANDOS
							first_line <= X"20_20_20_20_20_20_45_72_72_6F_20_20_20_20_20_20";
							second_line <= x"50_6F_75_63_6F_73_20_6F_70_65_72_61_6E_64_6F_73";
							
						when "011" => -- DIV POR ZERO
							first_line <= X"20_20_20_20_20_20_45_72_72_6F_20_20_20_20_20_20";
							second_line <= x"44_69_76_69_73_61_6F_20_70_6F_72_20_7A_65_72_6F";
							
						when others =>
							first_line <= X"2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D";
							second_line <= X"2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D_2D";
							
					end case;
				end if;
			end if;
	end process;
end behav;