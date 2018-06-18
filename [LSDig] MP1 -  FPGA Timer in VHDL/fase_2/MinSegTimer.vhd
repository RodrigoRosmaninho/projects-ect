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

	signal inputSegs    : integer := 0;
	signal isPaused     : std_logic := '0';
	
	signal s_output     : std_logic_vector(15 downto 0);
	
	signal s_clk        : std_logic;
	signal s_timerEnd   : std_logic;
	signal s_enable7Seg : std_logic;
	
	signal s_pause       : std_logic;
	signal s_reset       : std_logic;

begin

	s_pause <= not isPaused;
	s_reset <= not KEY(1);

	process(KEY(0))
	begin
		if(rising_edge(KEY(0))) then
			isPaused <= not isPaused;
		end if;
		
	end process;
	
	freq 	: entity work.freqDivider (Behavioral)
				generic map (div => 50000000)
				port map (clkIn => CLOCK_50,
							 clkOut => s_clk);
	
	counter : entity work.CounterDownBCD(Behav)
					port map(clk      => s_clk,
							   enable   => s_pause,
							   load     => s_reset,
							   input    => "0101100101011001",
								output   => s_output,
							   timerEnd => s_timerEnd);
							 
	LEDG(7) <= s_timerEnd;
							 
	LEDG(8) <= s_clk when (isPaused = '0' and s_timerEnd = '0') else '0' when (s_timerEnd = '1') else '1';
	
	s_enable7Seg <= s_clk when (s_timerEnd = '1') else '1';
							 
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