library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Signed_2_ASCII is
	port(dataIn : in  std_logic_vector(7 downto 0);
	     uniOut : out std_logic_vector(7 downto 0);
		  decOut : out std_logic_vector(7 downto 0);
		  cenOut : out std_logic_vector(7 downto 0);
		  sinal  : out std_logic);
end Signed_2_ASCII;

architecture behav of Signed_2_ASCII is

	signal s_uniOut, s_decOut, s_cenOut : std_logic_vector(3 downto 0);

begin

	signed_2_bcd : entity work.Signed_2_BCD(behav)
					port map(dataIn => dataIn,
								uniOut => s_uniOut,
								decOut => s_decOut,
								cenOut => s_cenOut,
								sinal => sinal);
								
	uni_ascii_decod : entity work.BCD_2_ASCII_Decoder(behav)
					port map(dataIn => s_uniOut,
								dataOut => uniOut);
										
	dec_ascii_decod : entity work.BCD_2_ASCII_Decoder(behav)
					port map(dataIn => s_decOut,
								dataOut => decOut);
										
	cen_ascii_decod : entity work.BCD_2_ASCII_Decoder(behav)
					port map(dataIn => s_cenOut,
								dataOut => cenOut);
										

end behav;