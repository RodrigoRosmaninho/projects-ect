library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Signed_2_BCD is
	port(dataIn : in  std_logic_vector(7 downto 0);
	     uniOut : out std_logic_vector(3 downto 0);
		  decOut : out std_logic_vector(3 downto 0);
		  cenOut : out std_logic_vector(3 downto 0);
		  sinal  : out std_logic);
end Signed_2_BCD;

architecture behav of Signed_2_BCD is

	signal data : unsigned(7 downto 0);
	
begin  
	
		data <= unsigned(not dataIn) + 1 when (dataIn(7) = '1') else unsigned(dataIn);
		
		sinal <= '1' when (dataIn(7) = '1') else '0';
		
		uniOut <= std_logic_vector((data rem 100) rem 10)(3 downto 0);
		decOut <= std_logic_vector((data rem 100) / 10)(3 downto 0);
		cenOut <= std_logic_vector(data / 100)(3 downto 0);
		
end behav;