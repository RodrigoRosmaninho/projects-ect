LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateInv IS
  PORT (x: IN STD_LOGIC;
        y: OUT STD_LOGIC);
END gateInv;

ARCHITECTURE logicFunction OF gateInv IS
BEGIN
  y <= NOT x;
END logicFunction;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateAnd2 IS
  PORT (x1, x2: IN STD_LOGIC;
        y:      OUT STD_LOGIC);
END gateAnd2;

ARCHITECTURE logicFunction OF gateAnd2 IS
BEGIN
  y <= x1 AND x2;
END logicFunction;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateOr2 IS
  PORT (x1, x2: IN STD_LOGIC;
        y:      OUT STD_LOGIC);
END gateOr2;

ARCHITECTURE logicFunction OF gateOr2 IS
BEGIN
  y <= x1 OR x2;
END logicFunction;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateXor2 IS
  PORT (x1, x2: IN STD_LOGIC;
        y:      OUT STD_LOGIC);
END gateXor2;

ARCHITECTURE logicFunction OF gateXor2 IS
BEGIN
  y <= x1 XOR x2;
END logicFunction;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateOr8 IS
  PORT (x: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        y: OUT STD_LOGIC);
END gateOr8;

ARCHITECTURE logicFunction OF gateOr8 IS
  SIGNAL l0_1, l0_2, l0_3, l0_4, l1_1, l1_2: STD_LOGIC;
  COMPONENT gateOr2
    PORT (x1, x2: IN STD_LOGIC;
          y: OUT STD_LOGIC);
  END COMPONENT;
BEGIN
  or0:  gateOr2  PORT MAP (x(0), x(1), l0_1);
  or1:  gateOr2  PORT MAP (x(2), x(3), l0_2);
  or2:  gateOr2  PORT MAP (x(4), x(5), l0_3);
  or3:  gateOr2  PORT MAP (x(6), x(7), l0_4);
  or4:  gateOr2  PORT MAP (l0_1, l0_2, l1_1);
  or5:  gateOr2  PORT MAP (l0_3, l0_4, l1_2);
  or6:  gateOr2  PORT MAP (l1_1, l1_2, y);
END logicFunction;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux2 IS
  PORT (x1, x2, sel:  IN STD_LOGIC;
        y:           OUT STD_LOGIC);
END mux2;

ARCHITECTURE structure OF mux2 IS
  SIGNAL invSel, resAnd0, resAnd1: STD_LOGIC;
  COMPONENT gateOr2
    PORT (x1, x2: IN STD_LOGIC;
          y: OUT STD_LOGIC);
  END COMPONENT;
  COMPONENT gateAnd2
    PORT (x1, x2: IN STD_LOGIC;
          y: OUT STD_LOGIC);
  END COMPONENT;
  COMPONENT gateInv
    PORT (x:  IN STD_LOGIC;
          y: OUT STD_LOGIC);
  END COMPONENT;
BEGIN
  inv0: gateInv  PORT MAP (sel, invSel);
  and0: gateAnd2 PORT MAP (x1, invSel, resAnd0);
  and1: gateAnd2 PORT MAP (x2, sel, resAnd1);
  or0:  gateOr2  PORT MAP (resAnd0, resAnd1, y);
END structure;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY flipFlopDPET IS
  PORT (clk, D:     IN STD_LOGIC;
        nSet, nRst: IN STD_LOGIC;
        Q, nQ:      OUT STD_LOGIC);
END flipFlopDPET;

ARCHITECTURE behavior OF flipFlopDPET IS
BEGIN
  PROCESS (clk, nSet, nRst)
  BEGIN
    IF (nRst = '0')
	    THEN Q <= '0';
		      nQ <= '1';
		 ELSIF (nSet = '0')
		       THEN Q <= '1';
		            nQ <= '0';
	          ELSIF (clk = '1') AND (clk'EVENT)
	                THEN Q <= D;
		                  nQ <= NOT D;

	 END IF;
  END PROCESS;
END behavior;