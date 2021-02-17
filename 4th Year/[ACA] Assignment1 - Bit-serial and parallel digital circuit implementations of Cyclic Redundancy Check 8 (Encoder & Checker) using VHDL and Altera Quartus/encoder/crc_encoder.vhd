-- Xor 2:1 Gate--
library ieee;
use ieee.std_logic_1164.all;

entity gateXor2 is
	port (x0, x1 : IN STD_LOGIC;
			y: OUT STD_LOGIC);
end gateXor2;

architecture logicFunction of gateXor2 is
begin
	y<= x0 xor x1;
end logicFunction;

-- Remainder --

library ieee;
use ieee.std_logic_1164.all;

entity remainderCalcBlk is
	port (a : IN STD_LOGIC_VECTOR (15 downto 0);
			x : OUT STD_LOGIC_VECTOR (7 downto 0));

end remainderCalcBlk;

architecture structure of remainderCalcBlk is
	signal l0out : STD_LOGIC_VECTOR (13 downto 0);
	signal l1out : STD_LOGIC_VECTOR (8 downto 0);
	signal l2out : STD_LOGIC_VECTOR (5 downto 0);
	component gateXor2
		port (x0,x1 : IN STD_LOGIC;
				y: OUT STD_LOGIC);
	end component;

begin
	
	--Level 0--
	l00: gateXor2 port map (a(0), a(12), l0out(0));
	l01: gateXor2 port map (a(1), a(3), l0out(1));
	l02: gateXor2 port map (a(2), a(14), l0out(2));
	l03: gateXor2 port map (a(4), a(6), l0out(3));
	l04: gateXor2 port map (a(7), a(8), l0out(4));
	l05: gateXor2 port map (a(9), a(10), l0out(5));
	l06: gateXor2 port map (a(11), a(15), l0out(6));
	l07: gateXor2 port map (a(6), a(13), l0out(7));
	l08: gateXor2 port map (a(3), a(5), l0out(8));
	l09: gateXor2 port map (a(0), a(1), l0out(9));
	l0a: gateXor2 port map (a(8), a(9), l0out(10));
	l0b: gateXor2 port map (a(4), a(13), l0out(11));
	l0c: gateXor2 port map (a(5), a(7), l0out(12));
	l0d: gateXor2 port map (a(3), a(15), l0out(13));
	
	--Level 1--
	l10: gateXor2 port map (l0out(2), l0out(5), l1out(0));
	l11: gateXor2 port map (l0out(1), a(5), l1out(1));
	l12: gateXor2 port map (l0out(4), l0out(5), l1out(2));
	l13: gateXor2 port map (l0out(0), l0out(6), l1out(3));
	l14: gateXor2 port map (l0out(4), a(11), l1out(4));
	l15: gateXor2 port map (l0out(9), l0out(11), l1out(5));
	l16: gateXor2 port map (l0out(10), a(2), l1out(6));
	l17: gateXor2 port map (l0out(0), l0out(3), l1out(7));
	l18: gateXor2 port map (l0out(12), l0out(13), l1out(8));
	
	--Level 2--
	l20: gateXor2 port map (l1out(0), l1out(1), x(4));
	l21: gateXor2 port map (l1out(1), l1out(2), l2out(0));
	l22: gateXor2 port map (l1out(0), l0out(3), l2out(1));
	l23: gateXor2 port map (l1out(3), l0out(1), l2out(2));
	l24: gateXor2 port map (l1out(5), l1out(6), x(3));
	l25: gateXor2 port map (l1out(2), l1out(3), l2out(3));
	l26: gateXor2 port map (l1out(6), l1out(7), l2out(4));
	l27: gateXor2 port map (l1out(5), l1out(8), l2out(5));
	
	--Level 3--
	l30: gateXor2 port map (l2out(0), l0out(7), x(6));
	l31: gateXor2 port map (l2out(1), l1out(4), x(7));
	l32: gateXor2 port map (l2out(1), l2out(2), x(2));
	l33: gateXor2 port map (l2out(3), l0out(8), x(0));
	l34: gateXor2 port map (l2out(4), l0out(12), x(5));
	l35: gateXor2 port map (l2out(5), a(6), x(1));
	
end structure;

--CRC Encoder--

library ieee;
use ieee.std_logic_1164.all;

entity crc_encoder is
	port ( dIn : IN STD_LOGIC_VECTOR (15 downto 0);
			 dOut : OUT STD_LOGIC_VECTOR (23 downto 0));			 
end crc_encoder;

architecture structure of crc_encoder is
	component remainderCalcBlk
		port ( a : IN STD_LOGIC_VECTOR (15 downto 0);
				 x : OUT STD_LOGIC_VECTOR (7 downto 0));
	end component;
begin	
	
	reminderBlk: remainderCalcBlk  port map (dIn (15 downto 0), dOut (7 downto 0));
	
	dOut (23 downto 8) <= dIn;
	
end structure;			


