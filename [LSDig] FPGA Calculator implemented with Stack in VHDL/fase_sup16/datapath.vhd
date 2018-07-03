library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity datapath is
	port(clock            : in  std_logic;
		  reset            : in  std_logic;
		  SW               : in  std_logic_vector(1 downto 0);
	     KEY              : in  std_logic_vector(3 downto 1);
		  en_eliminarPos   : in  std_logic;
		  en_verPilha      : in  std_logic;
		  en_operando      : in  std_logic;
		  en_operador      : in  std_logic;
		  en_valOperando   : in  std_logic;
		  en_valOperador   : in  std_logic;
		  en_stackOperando : in  std_logic;
		  en_stackOperador : in  std_logic;
		  en_posOperando   : in  std_logic;
		  en_posOperador   : in  std_logic;
		  complete_pos     : out std_logic;
		  complete_calc    : out std_logic;
		  hasOperands      : out std_logic;
		  hasSpace         : out std_logic;
		  lcd_on           : out   std_logic;
		  lcd_blon         : out   std_logic;
		  lcd_rw           : out   std_logic;
		  lcd_en           : out   std_logic;
		  lcd_rs           : out   std_logic;
		  lcd_data         : inout std_logic_vector(7 downto 0);
		  LEDR             : out std_logic_vector(3 downto 0);
		  LEDG             : out std_logic_vector(0 downto 0));
		  
end datapath;

architecture behav of datapath is

	signal numero, numero_introd, numero_ram1, numero_ram2, calc_valOut1, calc_valOut2 : std_logic_vector(7 downto 0);
	signal uniOut, decOut, cenOut : std_logic_vector(4 downto 0);
	signal r_addr1, r_addr2, addr_cnt, viz_addr, calc_addrOut1, calc_addrOut2 : std_logic_vector(4 downto 0);
	signal s_errorCode1, op_code, op_code1, op_code2 : std_logic_vector(2 downto 0);
	signal en_ram, s_complete_calc, en_unidades_signed, en_dezenas_signed, en_centenas_signed, en_sinal_signed : std_logic;
	signal s_en_val, s_reset_operador, s_op_or_introd, en_posVal, s_overflow, s_divByZero, s_hasError, s_decrement, s_en_current_dec, s_en_viz_dec, en_insert_ram, s_ram_complete, calc_complete, s_hasSpace, s_hasOperands : std_logic;
	
	signal s_first_line, s_second_line : std_logic_vector(127 downto 0);
	signal s_num_uni, s_num_dec, s_num_cen, s_a_uni, s_a_dec, s_a_cen, s_b_uni, s_b_dec, s_b_cen, s_current_uni, s_current_dec, s_viz_uni, s_viz_dec: std_logic_vector(7 downto 0);
	signal s_errorCode2 : std_logic_vector(2 downto 0);
	signal s_num_sinal, s_a_sinal, s_b_sinal : std_logic;
	
	
begin

	------------------------------------------------
	--                   INPUT                    --
	------------------------------------------------

	introduzir_operando : entity work.introd_operandos(behav)
					port map(clock   => clock,
								reset   => reset,
								SW2     => SW(0),
								KEY     => KEY,
								enable  => en_operando,
								dataOut => numero_introd);
								
	s_reset_operador <= s_complete_calc or en_operando or en_verPilha; 
	-- s_reset_operador retorna o opCode interno do bloco introduzir_operador de volta a 000.
	-- Tal deve acontecer quando a operacao anterior acaba para que o utilizador possa ver 'SOMA' no LCD em vez de a ultima opcao escolhida
								
	introduzir_operador : entity work.introd_operadores(behav)
					port map(clock       => clock,
								reset       => reset,
								KEY         => KEY(1),
								enable      => en_operador,
								op_complete => s_reset_operador,
								dataOut     => op_code1);

	op_code <= s_errorCode1 when (s_hasError = '1') else "110" when (En_eliminarPos = '1') else "111" when (En_stackOperando = '1') else op_code1;
	-- op_code torna-se errorCode quando e necessario que seja impressa uma determinada mensagem de erro no LCD
   -- op_code torna-se 110 (operacao que elimina o valor de qualquer posicao da pilha) quando e ativado o estado correspondente a esta operacao
	-- op_code torna-se 111 (operacao insert) quando e necessario introduzir um novo operando no topo da pilha
	-- por defeito, op_code torna-se op_code1, a saida do bloco introduzir_operador
	
	s_en_val <= not (en_insert_ram or en_posVal);
	-- permite que a validacao de espaco na pilha e numero de operandos suficientes corra sempre a nao ser que esteja a ser efetuada uma operacao ou pos-validacao (bloco que mostra mensagens de erro)
	-- assim, evita-se que os valores de hasSpace e hasOperands mudem imediatamente apos uma operacao e que, portanto, seja mostrada uma mensagem de erro errada.
				
	validar_input : entity work.blocoValidacao(Behavioral)
					port map(clock          => clock,
								enable         => s_en_val,
								opCode         => op_code1,
								address        => addr_cnt,
								hasSpace       => s_hasSpace,
								hasOperands    => s_hasOperands);
								
	hasSpace <= s_hasSpace;
	hasOperands <= s_hasOperands;
								
	
	------------------------------------------------
	--                   PILHA                    --
	------------------------------------------------
	
	-- Escolher a que sinal ligar os address' de cada um dos dois portos de leitura da RAM consoante o estado atual
	-- Pode ser necessario ver qualquer posicao da pilha (bloco verPilha), ver o elemento que se quer remover, ou ver o topo da pilha
	r_addr1 <= viz_addr when (en_verPilha = '1') else calc_addrOut1 when (en_eliminarPos = '1') else std_logic_vector(unsigned(addr_cnt) - 1);
	r_addr2 <= calc_addrOut2 when (en_eliminarPos = '1') else std_logic_vector(unsigned(addr_cnt) - 2);
	
	-- RAM 16x8 com dois portos de leitura assincrona e dois portos de leitura sincrona
	-- Dois portos de leitura facilitam a leitura de dois operandos ao mesmo tempo, para que as operacoes sejam realizadas
	-- Dois portos de escrita facilitam as operacoes SWAP e DIV, em que e preciso escrever dois valores para a RAM em vez de apenas um
	pilha : entity work.RAM_16x8(Behavioral)
					port map(reset         => reset,
								current_addr  => addr_cnt,
								writeClk      => clock,
								writeEnable   => en_ram,
								writeData1    => calc_valOut1,
								writeAddress1 => calc_addrOut1,
								writeData2    => calc_valOut2,
								writeAddress2 => calc_addrOut2,
								readAddress1  => r_addr1,
								readData1     => numero_ram1,
								readAddress2  => r_addr2,
								readData2     => numero_ram2,
								complete      => s_ram_complete);
	
	------------------------------------------------
	--                  OPERAÇOES                 --
	------------------------------------------------
	
	complete_calc <= s_complete_calc;
	
	-- Bloco de visualizacao da pilha
	viz_pilha : entity work.VisualizacaoPilha(Behavioral)
					port map(enable     => en_verPilha,
								clk        => clock,
								reset      => reset,
								addressMax => addr_cnt,
								KEY        => KEY(3 downto 2),
								addressOut => viz_addr);
	
	-- Bloco de Calculo (ALU) e controlo da RAM
	calculadora : entity work.calculadora(Behavioral)
					port map(clock        => clock,
								enable       => en_insert_ram,
								complete_in  => s_ram_complete,
								reset        => reset,
								a            => numero_ram1,
								b            => numero_ram2,
								valIn        => numero_introd,
								opCode       => op_code,
								ext_address  => viz_addr,
								valOut1      => calc_valOut1,
								valOut2      => calc_valOut2,
								current_addr => addr_cnt,
								addrOut1     => calc_addrOut1,
								addrOut2     => calc_addrOut2,
								ram_enable   => en_ram,
								complete     => s_complete_calc,
								overflow     => s_overflow,
								divByZero    => s_divByZero);
								
	en_insert_ram <= en_stackOperador or en_stackOperando or en_eliminarPos;
	en_posVal <= en_posOperando or en_posOperador;
	s_op_or_introd <= '1' when (en_posOperando = '1') else '0'; -- toma valor '1' quando a operacao se trata de adicionar um operando e '0' quando se trata de adicionar operador e realizar a operacao
	
	-- Bloco que mostra erros durante x segundos
	pos_validacao : entity work.pos_validacao(behav)
					port map(clk          => clock,
								enable       => en_posVal,
								op_or_introd => s_op_or_introd,
								overflow     => s_overflow,
								divByZero    => s_divByZero,
								hasOperands  => s_hasOperands,
								hasSpace     => s_hasSpace,
								opCode       => s_errorCode1,
								complete     => complete_pos,
								errorCode    => s_errorCode2,
								LEDR         => LEDR,
								LEDG         => LEDG);
								
	------------------------------------------------
	--                  OUTPUT                    --
	------------------------------------------------
	
	-- escolher que numero se apresenta no LCD
	numero <= numero_introd when (en_operando = '1') else numero_ram1;
								
	-- Converte 'numero' para BCD em ASCII
	Introd_or_Viz : entity work.Signed_2_ASCII(behav)
					port map(dataIn => numero,
								uniOut => s_num_uni,
								decOut => s_num_dec,
								cenOut => s_num_cen,
								sinal => s_num_sinal);
								
	-- Converte 'numero_ram1' para BCD em ASCII
	operando_A : entity work.Signed_2_ASCII(behav)
					port map(dataIn => numero_ram1,
								uniOut => s_a_uni,
								decOut => s_a_dec,
								cenOut => s_a_cen,
								sinal => s_a_sinal);
	
   -- Converte 'numero_ram2' para BCD em ASCII
	operando_B : entity work.Signed_2_ASCII(behav)
					port map(dataIn => numero_ram2,
								uniOut => s_b_uni,
								decOut => s_b_dec,
								cenOut => s_b_cen,
								sinal => s_b_sinal);
								
	-- Converte o address do topo da pilha e o address da visualizaçao da pilha para BCD em ASCII
	current_and_viz : entity work.Address_2_ASCII(behav)
					port map(current_addr => addr_cnt,
								viz_addr => viz_addr,
								current_uni => s_current_uni,
								current_dec => s_current_dec,
								viz_uni => s_viz_uni,
								viz_dec => s_viz_dec);
								
	-- Em funçao do estado atual decide o que escrever nas linhas do LCD
	lcd_coder : entity work.lcd_coder(behav)
					port map(clk => clock,
								opCode => op_code,
								errorCode => s_errorCode2,
								en_operador => en_operador,
								en_operando => en_operando,
								en_verPilha => en_verPilha,
								en_posVal => en_posVal,
								num_sinal => s_num_sinal,
								a_sinal => s_a_sinal,
								b_sinal => s_b_sinal,
								num_uni => s_num_uni,
								num_dec => s_num_dec,
								num_cen => s_num_cen,
								current_uni => s_current_uni,
								current_dec => s_current_dec,
								viz_uni => s_viz_uni,
								viz_dec => s_viz_dec,
								a_uni => s_a_uni,
								a_dec => s_a_dec,
								a_cen => s_a_cen,
								b_uni => s_b_uni,
								b_dec => s_b_dec,
								b_cen => s_b_cen,
								first_line => s_first_line,
								second_line => s_second_line);
								
	-- controlador do LCD, atualiza as linhas do LCD
	-- adaptado de recursos existentes no e-learning
	lcd_updater : entity work.lcd_updater(behav)
					port map(clock_50 => clock,
								first_line => s_first_line,
								second_line => s_second_line,
								lcd_on => lcd_on,
								lcd_blon => lcd_blon,
								lcd_rw => lcd_rw,
								lcd_en => lcd_en,
								lcd_rs => lcd_rs,
								lcd_data => lcd_data);
	

end behav;