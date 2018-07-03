library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Signed_2_BCD is
	port(enable         : in  std_logic;
	     dataIn         : in  std_logic_vector(7 downto 0);
		  current_addr   : in  std_logic_vector(4 downto 0);
		  viz_addr       : in  std_logic_vector(4 downto 0);
	     uniOut         : out std_logic_vector(4 downto 0);
		  decOut         : out std_logic_vector(4 downto 0);
		  cenOut         : out std_logic_vector(4 downto 0);
		  current_uni    : out std_logic_vector(4 downto 0);
		  current_dec    : out std_logic_vector(4 downto 0);
		  viz_uni        : out std_logic_vector(4 downto 0);
		  viz_dec        : out std_logic_vector(4 downto 0);
		  en_current_dec : out std_logic;
		  en_viz_dec     : out std_logic;
		  en_unidades    : out std_logic;
		  en_dezenas     : out std_logic;
		  en_centenas    : out std_logic;
		  en_sinal       : out std_logic);
end Signed_2_BCD;

architecture behav of Signed_2_BCD is

	signal data : unsigned(7 downto 0);
	signal addr, viz, s_current_dec, s_viz_dec : unsigned(4 downto 0);
	signal s_uniOut, s_decOut, s_cenOut : std_logic_vector(4 downto 0);
	
begin  
	
		data <= unsigned(not dataIn) + 1 when (dataIn(7) = '1') else unsigned(dataIn);
		addr <= unsigned(current_addr);
		viz <= unsigned(viz_addr) + 1;
		
		en_unidades <= '1';
		en_dezenas  <= '1';
		en_centenas <= '1';
		en_sinal <= '1' when (enable = '0') else '1' when (dataIn(7) = '1') else '0';
		
		s_uniOut <= std_logic_vector((data rem 100) rem 10)(4 downto 0);
		s_decOut <= std_logic_vector((data rem 100) / 10)(4 downto 0);
		s_cenOut <= std_logic_vector(data / 100)(4 downto 0);
		
		current_uni <= std_logic_vector(addr rem 10)(4 downto 0);
		s_current_dec <= addr / 10;
		current_dec <= std_logic_vector(s_current_dec)(4 downto 0);
		
		viz_uni <= std_logic_vector(viz rem 10)(4 downto 0);
		s_viz_dec <= viz / 10;
		viz_dec <= std_logic_vector(s_viz_dec)(4 downto 0);
		
		en_current_dec <= '1' when (s_current_dec > 0) else '0';
		en_viz_dec <= '1' when (s_viz_dec > 0) else '0';
		
		uniOut <= "01010" when (enable = '0') else s_uniOut;
		decOut <= "01010" when (enable = '0') else s_decOut;
		cenOut <= "01010" when (enable = '0') else s_cenOut;
		
end behav;