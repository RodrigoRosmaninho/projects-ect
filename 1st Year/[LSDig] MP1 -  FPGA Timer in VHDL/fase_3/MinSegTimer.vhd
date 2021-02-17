library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity MinSegTimer is
	port(CLOCK_50 : in std_logic;
		  SW       : in std_logic_vector(15 downto 0);
		  KEY      : in std_logic_vector(1 downto 0);
		  HEX2     : out std_logic_vector(6 downto 0);
		  HEX3     : out std_logic_vector(6 downto 0);
		  HEX4     : out std_logic_vector(6 downto 0);
		  HEX5     : out std_logic_vector(6 downto 0);
		  LEDG     : out std_logic_vector(8 downto 7));
end MinSegTimer;

architecture Behav of MinSegTimer is

	signal isPaused      : std_logic := '0';
	signal s_output      : std_logic_vector(15 downto 0);
	signal s_clk         : std_logic;
	signal s_timerEnd    : std_logic;
	signal s_enable7Seg  : std_logic;
		
	signal s_loadTime1 : std_logic_vector(3 downto 0);
	signal s_loadTime2 : std_logic_vector(3 downto 0);
	signal s_loadTime3 : std_logic_vector(3 downto 0);
	signal s_loadTime4 : std_logic_vector(3 downto 0);
	
	signal s_pause       : std_logic;
	signal isInSetMode   : std_logic := '0';
	signal s_load        : std_logic := '1';
	signal s_counterOut  : std_logic_vector(15 downto 0);

begin

	process(KEY(0))
	begin
		if(rising_edge(KEY(0))) then
			isPaused <= not isPaused; -- Criar latch que guarde o estado da pausa. Inverter o estado sempre que se clicar em KEY(0)
		end if;
	end process;
	
	process(KEY(1))
	begin
		if(rising_edge(KEY(1))) then
			isInSetMode <= not isInSetMode;
		end if;
	end process;
	
	s_load  <= not KEY(1);
	s_pause <= '0' when (isInSetMode = '1' or isPaused = '1') else '1';
	
	checker : entity work.CheckInput(Behav)
				  port map(dataIn => SW,
							  MinDecOut => s_loadTime4,
							  MinUniOut => s_loadTime3,
							  SegDecOut => s_loadTime2,
							  SegUniOut => s_loadTime1);

	freq 	: entity work.freqDivider (Behavioral)
				generic map (div => 50000000)
				port map (clkIn => CLOCK_50,
							 clkOut => s_clk); -- Dividir a frequencia do clock da FPGA de 50MHz para 1Hz
	
	counter : entity work.CounterDownBCD(Behav)
					port map(clk      => s_clk,
							   enable   => s_pause,
							   load     => s_load,
							   input    => s_output,
							   output   => s_counterOut,
							   timerEnd => s_timerEnd);
								
	s_output <= (s_loadTime4 & s_loadTime3 & s_loadTime2 & s_loadTime1) when (isInSetMode = '1' or s_load = '1') else s_counterOut;
							 
	LEDG(7) <= s_timerEnd; -- Acender LEDR(0) quando o timer chegar ao fim
							 
	LEDG(8) <= s_clk when (s_pause = '1' and s_timerEnd = '0') else '0' when (s_timerEnd = '1') else '1'; -- Piscar LEDG(8) quando nao esta em pausa; Apagar quando o timer chegar ao fim; Ligar quando esta em pausa
	
	s_enable7Seg <= s_clk when (s_timerEnd = '1') else '1'; -- Piscar displays quando o timer chegar ao fim
							 
	bin7_MinDec	: entity work.Bin7SegDecoder(Behavioral)
							port map (enable   => s_enable7Seg,
										 binInput => s_output(15 downto 12),
										 decOut	 => HEX5(6 downto 0));
								
	bin7_MinUni	: entity work.Bin7SegDecoder(Behavioral)
							port map (enable   => s_enable7Seg,
										 binInput => s_output(11 downto 8),
										 decOut	 => HEX4(6 downto 0));
										 
	bin7_SegDec	: entity work.Bin7SegDecoder(Behavioral)
							port map (enable   => s_enable7Seg,
										 binInput => s_output(7 downto 4),
										 decOut	 => HEX3(6 downto 0));
										 
	bin7_SegUni	: entity work.Bin7SegDecoder(Behavioral)
							port map (enable   => s_enable7Seg,
										 binInput => s_output(3 downto 0),
										 decOut	 => HEX2(6 downto 0));	

end Behav;	