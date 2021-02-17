library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity CheckInput is
	port(dataIn    : in std_logic_vector(15 downto 0);
		  MinDecOut : out std_logic_vector(3 downto 0);
		  MinUniOut : out std_logic_vector(3 downto 0);
		  SegDecOut : out std_logic_vector(3 downto 0);
		  SegUniOut : out std_logic_vector(3 downto 0));
end CheckInput;

architecture Behav of CheckInput is
begin
	SegUniOut <= dataIn(3 downto 0)   when (unsigned(dataIn(3 downto 0))   <= 9) else "1001"; -- Unidades de Segundos
	SegDecOut <= dataIn(7 downto 4)   when (unsigned(dataIn(7 downto 4))   <= 5) else "0101"; -- Dezenas de Segundos
	MinUniOut <= dataIn(11 downto 8)  when (unsigned(dataIn(11 downto 8))  <= 9) else "1001"; -- Unidades de Minutos
	MinDecOut <= dataIn(15 downto 12) when (unsigned(dataIn(15 downto 12)) <= 5) else "0101"; -- Dezenas de Minutos
end Behav;