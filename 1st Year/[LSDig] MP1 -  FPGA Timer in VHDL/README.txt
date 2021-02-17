lsdig_mp_p3_88802_89264

Mini-Projeto no âmbito da U.C. de Laboratórios de Informática
Temporizador com start/pause e reset

Docente: Professor Auxiliar Manuel Violas

Autores: ----------------------------------------------------------------
Rodrigo Rosmaninho (88802) - MIECT, Turma P3  -> Realizou 50% do trabalho
Rita Amante        (89264) - MIECT, Turma P3  -> Realizou 50% do trabalho
-------------------------------------------------------------------------

Funcionamento: ----------------------------------------------------------

	O projeto utiliza o sinal CLOCK_50 da FPGA. Ou seja, um sinal de clock com 50MHz de frequência.
	No entanto, é necessário um sinal com 1Hz de frequncia, pelo que é utilizado um divisor de frequência (freqDivider.vhd) com um fator de 50.000.000

	Este sinal é ligado à entrada de clock do contador (CounterDownBCD.vhd) , que vai decrementando o tempo restante.
	Este bloco aceita input na forma de um vetor com 16 bits (4x4) correspondente à junção de todos os dígitos do tempo restante (mm:ss) em BCD (4 bits cada) e devolve um sinal análogo (16 bits em BCD) que corresponde ao tempo restante depois de ter sido, dependendo do estado da pausa, decrementado por 1 segundo.
	Para além disso, se o temporizador chegar a 00h00 ativa a saída termCount.
	O contador possui um enable que corresponde ao estado da pausa do temporizador e um reset assíncrono.
	
	A saída do contador é depois encaminhada diretamente para os LEDs no caso da FASE 1 ou é dividida em sinais de 4 bits que são ligados a Decoders de BCD para valores em binário utilizáveis por um display de 7 segmentos (Bin7SegDecoder.vhd). Neste caso, a saída destes decoders é finalmente encaminhada para os displays de 7 segmentos.

	 O estado da pausa é guardado num flip-flop. Quando se clica no botão de pausa é feita uma operação de TOGGLE ao valor do flip-flop. 

	Na FASE 3 é ainda utilizado o bloco CheckInput (CheckInput.vhd) para verificar se os valores introduzidos pelo utilizador não excedem o máximo. 

Utilização: -------------------------------------------------------------

	O temporizador começa automaticamente.
	Para fazer pausa ou resumir, clicar em KEY0.
	Para fazer reset (VER CADA UMA DAS FASES EM BAIXO), clicar em KEY1.

	A LEDG7 irá acender quando o temporizador acabar.
	A LEDG8 irá piscar sempre que o temporizador estiver em funcionamento. Se estiver em pausa, o LED fica aceso.


	***** FASE 1 *****
	
	O reset reverte o valor do temporizador para 59h59.
	O valor da contagem pode ser observado pelos LEDs vermelhos (LEDR) do LEDR15 ao LEDR0.
	Os valores encontram-se em BCD.

	LEDR15 a LEDR12 -> Dezenas de Minutos
	LEDR11 a LEDR8  -> Unidades de Minutos
	LEDR7  a LEDR4  -> Dezenas de Segundos
	LEDR3  a LEDR0  -> Unidades de Segundos

	Quando o temporizador acabar, os valores dos LEDs vermelhos vão piscar.


	***** FASE 2 *****
	
	O reset reverte o valor do temporizador para 59h59.
	O valor da contagem pode ser observado pelos displays de 7 segmentos (HEX) do HEX5 ao HEX2.
	Os valores encontram-se em BCD.

	HEX5 -> Dezenas de Minutos
	HEX4 -> Unidades de Minutos
	HEX3 -> Dezenas de Segundos
	HEX2 -> Unidades de Segundos

	Quando o temporizador acabar, os displays de 7 segmentos vão piscar.


	***** FASE 3 *****
	O temporizador começa automaticamente.
	Para fazer pausa ou resumir, clicar em KEY0.
	
	--- RESET ---
	Para fazer reset, clicar em KEY1.
	Quando o reset for iniciado, os displays de 7 segmentos passam a mostrar valores obtidos apartir dos switches (SW) da FPGA.
	Desta forma, o utilizador pode mudar as posições dos switches até que o valor mostrado nos displays seja o correto.
	Os valores são lidos em BCD.

	SW15 a SW12 -> Dezenas de Minutos
	SW11 a SW8  -> Unidades de Minutos
	SW7  a SW4  -> Dezenas de Segundos
	SW3  a SW0  -> Unidades de Segundos

	Se em qualquer grupo de SWs for introduzido um valor superior ao valor máximo permitido, o valor permanece no valor máximo.
	Para recomeçar o temporizador clica-se de novo em KEY1. O temporizador faz LOAD do valor e resume o seu funcionamento.
	------
	
	
	O valor da contagem pode ser observado pelos displays de 7 segmentos (HEX) do HEX5 ao HEX2.
	Os valores encontram-se em BCD.

	HEX5 -> Dezenas de Minutos
	HEX4 -> Unidades de Minutos
	HEX3 -> Dezenas de Segundos
	HEX2 -> Unidades de Segundos

	Quando o temporizador acabar, os displays de 7 segmentos vão piscar.

