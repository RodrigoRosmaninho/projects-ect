library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Address_2_ASCII is
	port(current_addr   : in  std_logic_vector(4 downto 0);
		  viz_addr       : in  std_logic_vector(4 downto 0);
		  current_uni, current_dec, viz_uni, viz_dec : out std_logic_vector(7 downto 0));
end Address_2_ASCII;

architecture behav of Address_2_ASCII is

	signal addr, viz : unsigned(4 downto 0);
	signal s_current_uni, s_current_dec, s_viz_uni, s_viz_dec : std_logic_vector(3 downto 0);
	
begin  
	
		addr <= unsigned(current_addr);
		viz <= unsigned(viz_addr) + 1;
		
		s_current_uni <= std_logic_vector(addr rem 10)(3 downto 0);
		s_current_dec <= std_logic_vector(addr / 10)(3 downto 0);
		
		s_viz_uni <= std_logic_vector(viz rem 10)(3 downto 0);
		s_viz_dec <= std_logic_vector(viz / 10)(3 downto 0);
		
		current_uni_ascii_decod : entity work.BCD_2_ASCII_Decoder(behav)
					port map(dataIn => s_current_uni,
								dataOut => current_uni);
										
		current_dec_ascii_decod : entity work.BCD_2_ASCII_Decoder(behav)
					port map(dataIn => s_current_dec,
								dataOut => current_dec);
										
		viz_uni_ascii_decod : entity work.BCD_2_ASCII_Decoder(behav)
					port map(dataIn => s_viz_uni,
								dataOut => viz_uni);
										
		viz_dec_ascii_decod : entity work.BCD_2_ASCII_Decoder(behav)
					port map(dataIn => s_viz_dec,
								dataOut => viz_dec);
		
end behav;