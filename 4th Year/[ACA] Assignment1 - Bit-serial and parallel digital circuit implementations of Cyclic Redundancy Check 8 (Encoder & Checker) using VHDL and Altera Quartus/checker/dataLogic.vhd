LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY remainderStageCalculator IS
  PORT (a:     IN STD_LOGIC;
        dIn:   IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        dOut: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END remainderStageCalculator;

ARCHITECTURE structure OF remainderStageCalculator IS
  COMPONENT gateXor2
    PORT (x1, x2: IN STD_LOGIC;
          y: OUT STD_LOGIC);
  END COMPONENT;
BEGIN
  dOut(7) <= dIn(6);
  dOut(6) <= dIn(5);
  xor0: gateXor2 PORT MAP (dIn(4), dIn(7), dOut(5));
  dOut(4) <= dIn(3);
  xor1: gateXor2 PORT MAP (dIn(2), dIn(7), dOut(3));
  xor2: gateXor2 PORT MAP (dIn(1), dIn(7), dOut(2));
  xor3: gateXor2 PORT MAP (dIn(0), dIn(7), dOut(1));
  xor4: gateXor2 PORT MAP (a, dIn(7), dOut(0));
END structure;



LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY shiftLeftRegister_SIPOPL_8bit IS
  PORT (clk:     IN STD_LOGIC;
        dIn:     IN STD_LOGIC;
		  load:    IN STD_LOGIC;
		  nRst:     IN STD_LOGIC;
		  dLoadIn: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        dOut:   OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END shiftLeftRegister_SIPOPL_8bit;

ARCHITECTURE structure OF shiftLeftRegister_SIPOPL_8bit IS
  SIGNAL iD, iQ : STD_LOGIC_VECTOR (7 DOWNTO 0);
  COMPONENT mux2
    PORT (x1, x2, sel:  IN STD_LOGIC;
          y:           OUT STD_LOGIC);
  END COMPONENT;
  COMPONENT flipFlopDPET
    PORT (clk, D:     IN STD_LOGIC;
          nSet, nRst: IN STD_LOGIC;
          Q, nQ:      OUT STD_LOGIC);
  END COMPONENT;
BEGIN

  mux2_0: mux2 PORT MAP (dIn,   dLoadIn(0), load, iD(0));
  mux2_1: mux2 PORT MAP (iQ(0), dLoadIn(1), load, iD(1));
  mux2_2: mux2 PORT MAP (iQ(1), dLoadIn(2), load, iD(2));
  mux2_3: mux2 PORT MAP (iQ(2), dLoadIn(3), load, iD(3));
  mux2_4: mux2 PORT MAP (iQ(3), dLoadIn(4), load, iD(4));
  mux2_5: mux2 PORT MAP (iQ(4), dLoadIn(5), load, iD(5));
  mux2_6: mux2 PORT MAP (iQ(5), dLoadIn(6), load, iD(6));
  mux2_7: mux2 PORT MAP (iQ(6), dLoadIn(7), load, iD(7));
  ff0: flipFlopDPET PORT MAP (clk, iD(0),  '1', nRst, iQ(0));
  ff1: flipFlopDPET PORT MAP (clk, iD(1),  '1', nRst, iQ(1));
  ff2: flipFlopDPET PORT MAP (clk, iD(2),  '1', nRst, iQ(2));
  ff3: flipFlopDPET PORT MAP (clk, iD(3),  '1', nRst, iQ(3));
  ff4: flipFlopDPET PORT MAP (clk, iD(4),  '1', nRst, iQ(4));
  ff5: flipFlopDPET PORT MAP (clk, iD(5),  '1', nRst, iQ(5));
  ff6: flipFlopDPET PORT MAP (clk, iD(6),  '1', nRst, iQ(6));
  ff7: flipFlopDPET PORT MAP (clk, iD(7),  '1', nRst, iQ(7));
  dOut <= iQ;
END structure;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY outputUnit IS
  PORT (clk:    IN STD_LOGIC;
        endRst: IN STD_LOGIC; 
        rIn:    IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		  rOut:  OUT STD_LOGIC);
END outputUnit;

ARCHITECTURE structure OF outputUnit IS
  SIGNAL s_out, s_error: STD_LOGIC;
  COMPONENT gateOr8
    PORT (x: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
          y: OUT STD_LOGIC);
  END COMPONENT;
  COMPONENT gateOr2
    PORT (x1, x2: IN STD_LOGIC;
          y: OUT STD_LOGIC);
  END COMPONENT;
  COMPONENT flipFlopDPET
    PORT (clk, D:     IN STD_LOGIC;
          nSet, nRst: IN STD_LOGIC;
          Q, nQ:      OUT STD_LOGIC);
  END COMPONENT;
BEGIN
  or8: gateOr8 PORT MAP (rIn, s_out);
  ff0: flipFlopDPET PORT MAP (clk, s_out,  '1', '1', s_error);
  or1: gateOr2 PORT MAP (s_error, endRst, rOut);
END structure;