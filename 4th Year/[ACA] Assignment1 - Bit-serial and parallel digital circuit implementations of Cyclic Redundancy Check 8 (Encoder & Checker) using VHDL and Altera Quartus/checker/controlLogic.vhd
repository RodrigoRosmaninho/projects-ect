LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY simpleLogic;
USE simpleLogic.all;

ENTITY binCounter_5bit IS
  PORT (nGRst:  IN STD_LOGIC;
        endRst: IN STD_LOGIC;
        clk:    IN STD_LOGIC;
        c:     OUT STD_LOGIC_VECTOR (4 DOWNTO 0));
END binCounter_5bit;

ARCHITECTURE structure OF binCounter_5bit IS
  SIGNAL pD1, pD2, pD3: STD_LOGIC;
  SIGNAL iD1, iD2, iD3, iD4: STD_LOGIC;
  SIGNAL iQ0, iQ1, iQ2, iQ3, iQ4: STD_LOGIC;
  SIGNAL inQ0: STD_LOGIC;
  SIGNAL s_endRst, s_rst: STD_LOGIC;
  COMPONENT gateAnd2
    PORT (x1, x2: IN STD_LOGIC;
          y:      OUT STD_LOGIC);
  END COMPONENT;
  COMPONENT gateXor2
    PORT (x1, x2: IN STD_LOGIC;
          y:      OUT STD_LOGIC);
  END COMPONENT;
  COMPONENT flipFlopDPET
    PORT (clk, D:     IN STD_LOGIC;
          nSet, nRst: IN STD_LOGIC;
          Q, nQ:      OUT STD_LOGIC);
  END COMPONENT;
BEGIN
 
  -- garante que o estado 11000 e seguido do 00001 para nao perder o msb da proxima word
  ad0: gateAnd2  PORT MAP (nGRst, s_endRst, s_rst);
  ffR: flipFlopDPET PORT MAP (clk, endRst, s_endRst, '1', s_endRst);
  
  ad1: gateAnd2 PORT MAP (iQ0, iQ1, pD1);
  ad2: gateAnd2 PORT MAP (pD1, iQ2, pD2);
  ad3: gateAnd2 PORT MAP (pD2, iQ3, pD3);
  xr1: gateXor2 PORT MAP (iQ0, iQ1, iD1);
  xr2: gateXor2 PORT MAP (pD1, iQ2, iD2);
  xr3: gateXor2 PORT MAP (pD2, iQ3, iD3);
  xr4: gateXor2 PORT MAP (pD3, iQ4, iD4);
  ff0: flipFlopDPET PORT MAP (clk, inQ0, s_endRst, nGRst, iQ0, inQ0);
  ff1: flipFlopDPET PORT MAP (clk, iD1,  '1', s_rst, iQ1);
  ff2: flipFlopDPET PORT MAP (clk, iD2,  '1', s_rst, iQ2);
  ff3: flipFlopDPET PORT MAP (clk, iD3,  '1', s_rst, iQ3);
  ff4: flipFlopDPET PORT MAP (clk, iD4,  '1', s_rst, iQ4);
  c(0) <= iQ0;
  c(1) <= iQ1;
  c(2) <= iQ2;
  c(3) <= iQ3;
  c(4) <= iQ4;
END structure;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY controlUnit IS
  PORT (cnt:     IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		  endRst: OUT STD_LOGIC;
        dLoad:  OUT STD_LOGIC);
END controlUnit;

ARCHITECTURE structure OF controlUnit IS
  SIGNAL s_endRst : STD_LOGIC;
  COMPONENT gateAnd2
    PORT (x1, x2: IN STD_LOGIC;
          y:      OUT STD_LOGIC);
  END COMPONENT;
  COMPONENT gateXor2
    PORT (x1, x2: IN STD_LOGIC;
          y:      OUT STD_LOGIC);
  END COMPONENT;
  COMPONENT gateInv
    PORT (x:  IN STD_LOGIC;
          y: OUT STD_LOGIC);
  END COMPONENT;
BEGIN
  ad0: gateAnd2 PORT MAP (cnt(4), cnt(3), s_endRst);
  or0: gateXor2 PORT MAP (cnt(4), cnt(3), dLoad);
  inv: gateInv  PORT MAP (s_endRst, endRst);
END structure;
