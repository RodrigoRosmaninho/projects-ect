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
		  complete_calc    : out std_logic;
		  hasOperands      : out std_logic;
		  hasSpace         : out std_logic;
		  HEX0             : out std_logic_vector(6 downto 0);
		  HEX1             : out std_logic_vector(6 downto 0);
		  HEX2             : out std_logic_vector(6 downto 0);
		  HEX3             : out std_logic_vector(6 downto 0);
		  HEX4             : out std_logic_vector(6 downto 0);
		  HEX5             : out std_logic_vector(6 downto 0);
		  HEX6             : out std_logic_vector(6 downto 0);
		  HEX7             : out std_logic_vector(6 downto 0));
		  
end datapath;

architecture behav of datapath is

	signal numero, numero_introd, numero_ram1, numero_ram2, calc_valOut1, calc_valOut2 : std_logic_vector(7 downto 0);
	signal uniOut, decOut, cenOut, hex3_op, hex2_op, hex1_op, hex0_op, hex3_val, hex2_val, hex1_val, hex0_val, s_current_uni, s_current_dec, s_viz_uni, s_viz_dec : std_logic_vector(4 downto 0);
	signal addr_cnt, r_addr1, r_addr2, viz_addr, calc_addrOut1, calc_addrOut2 : std_logic_vector(4 downto 0);
	signal s_errorCode, op_code, op_code1 : std_logic_vector(2 downto 0);
	signal en_ram, s_complete_calc, en_unidades_signed, en_dezenas_signed, en_centenas_signed, en_sinal_signed : std_logic;
	signal en_hex0_op, en_hex1_op, en_hex2_op, en_hex3_op, en_hex0, en_hex1, en_hex2, en_hex3, en_hex7, en_signed2bcd : std_logic;
	signal s_reset_operador, s_en_current_dec, s_en_viz_dec, en_insert_ram, s_ram_complete, s_hasSpace, s_hasOperands : std_logic;
	
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
								
	s_reset_operador <= s_complete_calc or en_operando or en_verPilha; -- s_reset_operador retorna o opCode interno do bloco introduzir_operador de volta a 000.
	-- Tal deve acontecer quando a operacao anterior acaba para que o utilizador possa ver 'SOMA' nos displays em vez de a ultima opcao escolhida
								
	introduzir_operador : entity work.introd_operadores(behav)
					port map(clock       => clock,
								reset       => reset,
								KEY         => KEY(1),
								enable      => en_operador,
								op_complete => s_reset_operador,
								dataOut     => op_code1);
								
	op_code <= "110" when (En_eliminarPos = '1') else "111" when (En_stackOperando = '1') else op_code1;
   -- op_code torna-se 110 (operacao que elimina o valor de qualquer posicao da pilha) quando e ativado o estado correspondente a esta operacao
	-- op_code torna-se 111 (operacao insert) quando e necessario introduzir um novo operando no topo da pilha
	-- por defeito, op_code torna-se op_code1, a saida do bloco introduzir_operador
	
	
	validar_input : entity work.blocoValidacao(Behavioral)
					port map(clock          => clock,
								enable         => '1',
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
	pilha : entity work.RAM_2x8(Behavioral)
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
								complete     => s_complete_calc);
								
	en_insert_ram <= en_stackOperador or en_stackOperando or en_eliminarPos;

	------------------------------------------------
	--                  OUTPUT                    --
	------------------------------------------------
								
	-- Transforma o opCode em palavras para os displays de 7 segmentos
	opCodeDecod : entity work.opCodeDecoder(behav)
					port map(opCode  => op_code,
								HEX3    => hex3_op,
								HEX2    => hex2_op,
								HEX1    => hex1_op,
								HEX0    => hex0_op,
								en_hex3 => en_hex3_op,
								en_hex2 => en_hex2_op,
								en_hex1 => en_hex1_op,
								en_hex0 => en_hex0_op);
	
	-- escolher que numero se apresenta nos displays
	numero <= numero_introd when (en_operando = '1') else numero_ram1; 
	en_signed2bcd <= '1' when ((en_operando = '1') or (en_verPilha = '1')) else '0';
								
	signed2bcd : entity work.Signed_2_BCD(behav)
					port map(enable         => en_signed2bcd,
								dataIn         => numero,
								current_addr   => addr_cnt,
								viz_addr       => viz_addr,
					         uniOut         => uniOut,
								decOut         => decOut,
								cenOut         => cenOut,
								current_uni    => s_current_uni,
								current_dec    => s_current_dec,
								viz_uni        => s_viz_uni,
								viz_dec        => s_viz_dec,
								en_current_dec => s_en_current_dec,
								en_viz_dec     => s_en_viz_dec,
 								en_unidades    => en_unidades_signed,
								en_dezenas     => en_dezenas_signed,
								en_centenas    => en_centenas_signed,
								en_sinal       => en_sinal_signed);
								
	hex0_val <= hex0_op when (en_operador = '1') else uniOut;
	hex1_val <= hex1_op when (en_operador = '1') else decOut;
	hex2_val <= hex2_op when (en_operador = '1') else cenOut;
	hex3_val <= hex3_op when (en_operador = '1') else "01010";
	
	en_hex0 <= en_hex0_op when (en_operador = '1') else en_unidades_signed;
	en_hex1 <= en_hex1_op when (en_operador = '1') else en_dezenas_signed;
	en_hex2 <= en_hex2_op when (en_operador = '1') else en_centenas_signed;
	en_hex3 <= en_hex3_op when (en_operador = '1') else en_sinal_signed;
	en_hex7 <= s_en_viz_dec when (en_verPilha = '1') else '0';
								
	hex0_decod : entity work.Bin7SegDecoder(Behavioral)
					port map(enable   => en_hex0,
					         binInput => hex0_val,
								dataOut  => HEX0);
								
	hex1_decod : entity work.Bin7SegDecoder(Behavioral)
					port map(enable   => en_hex1,
					         binInput => hex1_val,
								dataOut  => HEX1);
								
	hex2_decod : entity work.Bin7SegDecoder(Behavioral)
					port map(enable   => en_hex2,
					         binInput => hex2_val,
								dataOut  => HEX2);
								
	hex3_decod : entity work.Bin7SegDecoder(Behavioral)
					port map(enable   => en_hex3,
					         binInput => hex3_val,
								dataOut  => HEX3);
								
	hex4_decod : entity work.Bin7SegDecoder(Behavioral)
					port map(enable   => '1',
					         binInput => s_current_uni,
								dataOut  => HEX4);
								
	hex5_decod : entity work.Bin7SegDecoder(Behavioral)
					port map(enable   => s_en_current_dec,
					         binInput => s_current_dec,
								dataOut  => HEX5);
								
	hex6_decod : entity work.Bin7SegDecoder(Behavioral)
					port map(enable   => En_verPilha,
					         binInput => s_viz_uni,
								dataOut  => HEX6);
								
	hex7_decod : entity work.Bin7SegDecoder(Behavioral)
					port map(enable   => en_hex7,
					         binInput => s_viz_dec,
								dataOut  => HEX7);
	

end behav;