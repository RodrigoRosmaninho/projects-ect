LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY crc_checker IS
  PORT (clk:    IN STD_LOGIC;
        a:      IN STD_LOGIC;
		  nGRst:  IN STD_LOGIC;
		  error:     OUT STD_LOGIC);
END crc_checker;

ARCHITECTURE structure OF crc_checker IS
  SIGNAL regOut, remOut: STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL cnt: STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL s_endRST, s_load: STD_LOGIC;
  COMPONENT controlUnit
  PORT (cnt:     IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		  endRst: OUT STD_LOGIC;
        dLoad:  OUT STD_LOGIC);
  END COMPONENT;
  COMPONENT binCounter_5bit
    PORT (nGRst: IN STD_LOGIC;
          endRst: IN STD_LOGIC;
          clk:  IN STD_LOGIC;
          c:    OUT STD_LOGIC_VECTOR (4 DOWNTO 0));
  END COMPONENT;
  COMPONENT shiftLeftRegister_SIPOPL_8bit
    PORT (clk:     IN STD_LOGIC;
          dIn:     IN STD_LOGIC;
		    load:    IN STD_LOGIC;
			 nRst:     IN STD_LOGIC;
		    dLoadIn: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
          dOut:   OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
  END COMPONENT;
  COMPONENT remainderStageCalculator
    PORT (a:     IN STD_LOGIC;
	       dIn:   IN STD_LOGIC_VECTOR (7 DOWNTO 0);
          dOut: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
  END COMPONENT;
  COMPONENT outputUnit
  PORT (clk:    IN STD_LOGIC;
        endRst: IN STD_LOGIC; 
        rIn:    IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		  rOut:  OUT STD_LOGIC);
  END COMPONENT;
BEGIN
  control: controlUnit PORT MAP (cnt, s_endRST, s_load);
  counter: binCounter_5bit PORT MAP (nGRst, s_endRST, clk, cnt);
  shiftReg: shiftLeftRegister_SIPOPL_8bit PORT MAP (clk, a, s_load, nGRst, remOut, regOut);
  remCalc: remainderStageCalculator PORT MAP (a, regOut, remOut);
  output: outputUnit PORT MAP (clk, s_endRST, remOut, error);
END structure;
