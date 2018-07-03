library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity RAM_16x8 is
	port(reset          : in  std_logic;
		  current_addr   : in  std_logic_vector(4 downto 0);
		  writeClk       : in  std_logic;
		  writeEnable    : in  std_logic;
		  writeData1     : in  std_logic_vector(7 downto 0);
		  writeAddress1  : in  std_logic_vector(4 downto 0);
		  writeData2     : in  std_logic_vector(7 downto 0);
		  writeAddress2  : in  std_logic_vector(4 downto 0);
		  readAddress1   : in  std_logic_vector(4 downto 0);
		  readData1      : out std_logic_vector(7 downto 0);
		  readAddress2   : in  std_logic_vector(4 downto 0);
		  readData2      : out std_logic_vector(7 downto 0);
		  complete       : out std_logic);
end RAM_16x8;

architecture Behavioral of RAM_16x8 is
	
	constant NUM_WORDS : integer := 16;
	subtype TDataWord is std_logic_vector(7 downto 0);
	type TMemory is array (0 to NUM_WORDS-1) of TDataWord;
	signal s_memory : TMemory;
	
	signal s_complete : std_logic := '0';

begin

	process(writeClk)
	begin
		if (rising_edge(writeClk)) then
			if(reset = '1' or current_addr = "00000") then
				s_memory(0) <= "00000000";
			elsif (writeEnable = '1' and s_complete = '0') then
				s_memory(to_integer(unsigned(writeAddress1))) <= writeData1;
				if(unsigned(writeAddress2) >= 0) then
					s_memory(to_integer(unsigned(writeAddress2))) <= writeData2;
				end if;
				s_complete <= '1';
			else
				s_complete <= '0';
			end if;
		end if;
	end process;
	readData1 <= s_memory(to_integer(unsigned(readAddress1)));
	readData2 <= s_memory(to_integer(unsigned(readAddress2)));
	
	complete <= '0' when (writeEnable = '0') else s_complete;

end Behavioral;