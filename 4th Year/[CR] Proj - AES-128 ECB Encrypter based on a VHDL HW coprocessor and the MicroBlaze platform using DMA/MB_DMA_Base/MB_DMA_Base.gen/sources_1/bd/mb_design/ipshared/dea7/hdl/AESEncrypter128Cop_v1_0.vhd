library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AESEncrypter128Cop_v1_0 is
	generic (
		-- Users to add parameters here
        
		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXIS
		C_S00_AXIS_TDATA_WIDTH	: integer	:= 32;

		-- Parameters of Axi Master Bus Interface M00_AXIS
		C_M00_AXIS_TDATA_WIDTH	: integer	:= 32
	);
	port (
		-- Users to add ports here
               
		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S00_AXIS
		s00_axis_aclk	: in std_logic;
		s00_axis_aresetn	: in std_logic;
		s00_axis_tready	: out std_logic;
		s00_axis_tdata	: in std_logic_vector(C_S00_AXIS_TDATA_WIDTH-1 downto 0);
		s00_axis_tstrb	: in std_logic_vector((C_S00_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s00_axis_tlast	: in std_logic;
		s00_axis_tvalid	: in std_logic;

		-- Ports of Axi Master Bus Interface M00_AXIS
		m00_axis_aclk	: in std_logic;
		m00_axis_aresetn	: in std_logic;
		m00_axis_tvalid	: out std_logic;
		m00_axis_tdata	: out std_logic_vector(C_M00_AXIS_TDATA_WIDTH-1 downto 0);
		m00_axis_tstrb	: out std_logic_vector((C_M00_AXIS_TDATA_WIDTH/8)-1 downto 0);
		m00_axis_tlast	: out std_logic;
		m00_axis_tready	: in std_logic
	);
end AESEncrypter128Cop_v1_0;

architecture arch_imp of AESEncrypter128Cop_v1_0 is

	-- component declaration
	component AESEncrypter128Cop_v1_0_S00_AXIS is
		generic (
		C_S_AXIS_TDATA_WIDTH	: integer	:= 32
		);
		port (
		S_AXIS_ACLK	: in std_logic;
		S_AXIS_ARESETN	: in std_logic;
		S_AXIS_TREADY	: out std_logic;
		S_AXIS_TDATA	: in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
		S_AXIS_TSTRB	: in std_logic_vector((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0);
		S_AXIS_TLAST	: in std_logic;
		S_AXIS_TVALID	: in std_logic;
		dataValid       : out std_logic;
        readBlock         : out std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
        byteEnable      : out std_logic_vector((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0);
        lastWord        : out std_logic;
        readEnabled     : in  std_logic		
		);
	end component AESEncrypter128Cop_v1_0_S00_AXIS;

	component AESEncrypter128Cop_v1_0_M00_AXIS is
		generic (
		C_M_AXIS_TDATA_WIDTH	: integer	:= 32
		);
		port (
		M_AXIS_ACLK	: in std_logic;
		M_AXIS_ARESETN	: in std_logic;
		M_AXIS_TVALID	: out std_logic;
		M_AXIS_TDATA	: out std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0);
		M_AXIS_TSTRB	: out std_logic_vector((C_M_AXIS_TDATA_WIDTH/8)-1 downto 0);
		M_AXIS_TLAST	: out std_logic;
		M_AXIS_TREADY	: in std_logic;
		dataValid       : in  std_logic;
        encData         : in  std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0);
        byteEnable      : in  std_logic_vector((C_M_AXIS_TDATA_WIDTH/8)-1 downto 0);
        lastWord        : in  std_logic;
        readEnabled     : out std_logic
		);
	end component AESEncrypter128Cop_v1_0_M00_AXIS;
	
	component AES128_TopLevel is
        port(   clk: in std_logic;
                resetn:     in std_logic;
                key_in:     in std_logic_vector(127 downto 0);
                block_in:   in std_logic_vector(127 downto 0);
                enc:        out std_logic_vector(127 downto 0);
                finish:     out std_logic
            );
    end component AES128_TopLevel;

    signal s_dataValid    : std_logic;
    signal s_byteEnable   : std_logic_vector((C_M00_AXIS_TDATA_WIDTH/8)-1 downto 0);
    signal s_lastWord     : std_logic;
    signal s_readEnabled  : std_logic := '0';
    
    signal s_dataValid_m    : std_logic;
    signal s_encData_m      : std_logic_vector(127 downto 0);
    signal s_encData_m32    : std_logic_vector(31 downto 0);

    signal s_byteEnable_m   : std_logic_vector((C_M00_AXIS_TDATA_WIDTH/8)-1 downto 0);
    signal s_lastWord_m     : std_logic := '0';
    signal s_readEnabled_m  : std_logic;
    
    signal s_count : integer range 0 to 4 := 0;
    signal s_count_r: integer range 0 to 3 := 0;
    
    signal s_readVal        : std_logic_vector(C_S00_AXIS_TDATA_WIDTH-1 downto 0);
    signal s_block          : std_logic_vector(127 downto 0);
    signal s_key            : std_logic_vector(127 downto 0);
    signal s_keyvalid       : std_logic := '0';
    
    signal s_reset          : std_logic := '0';
    signal s_finish         : std_logic;
    
    signal s_ready          : std_logic := '0';  
    signal s_write          : std_logic := '0';
    
begin

-- Instantiation of Axi Bus Interface S00_AXIS
AESEncrypter128Cop_v1_0_S00_AXIS_inst : AESEncrypter128Cop_v1_0_S00_AXIS
	generic map (
		C_S_AXIS_TDATA_WIDTH	=> C_S00_AXIS_TDATA_WIDTH
	)
	port map (
		S_AXIS_ACLK	=> s00_axis_aclk,
		S_AXIS_ARESETN	=> s00_axis_aresetn,
		S_AXIS_TREADY	=> s00_axis_tready,
		S_AXIS_TDATA	=> s00_axis_tdata,
		S_AXIS_TSTRB	=> s00_axis_tstrb,
		S_AXIS_TLAST	=> s00_axis_tlast,
		S_AXIS_TVALID	=> s00_axis_tvalid,
		dataValid       => s_dataValid,
        readBlock       => s_readVal,
        byteEnable      => s_byteEnable,
        lastWord        => s_lastWord,
        readEnabled     => s_readEnabled
	);

-- Instantiation of Axi Bus Interface M00_AXIS
AESEncrypter128Cop_v1_0_M00_AXIS_inst : AESEncrypter128Cop_v1_0_M00_AXIS
	generic map (
		C_M_AXIS_TDATA_WIDTH	=> C_M00_AXIS_TDATA_WIDTH
	)
	port map (
		M_AXIS_ACLK	    => m00_axis_aclk,
		M_AXIS_ARESETN	=> m00_axis_aresetn,
		M_AXIS_TVALID	=> m00_axis_tvalid,
		M_AXIS_TDATA	=> m00_axis_tdata,
		M_AXIS_TSTRB	=> m00_axis_tstrb,
		M_AXIS_TLAST	=> m00_axis_tlast,
		M_AXIS_TREADY	=> m00_axis_tready,
		dataValid       => s_dataValid_m,
        encData         => s_encData_m32,
        byteEnable      => s_byteEnable_m,
        lastWord        => s_lastWord_m,
        readEnabled     => s_readEnabled_m
	);

-- Add user logic here
AES128_inst: AES128_TopLevel
    port map (
        clk => m00_axis_aclk,
        resetn => s_reset,
        key_in => s_key,
        block_in => s_block,
        enc => s_encData_m,
        finish => s_finish
    );

process(m00_axis_aclk, s_finish, s_byteEnable, s_dataValid)
begin
    if rising_edge(m00_axis_aclk) then
        if s_write = '0' and s_ready = '0' then
            s_readEnabled <= '1';
            if s_byteEnable = x"F" and s_dataValid = '1' then
                if s_keyvalid = '0' then
                    if s_count_r = 3 then
                        s_key(127-s_count_r*32 downto 96-s_count_r*32) <= s_readVal;
                        s_keyvalid <= '1';
                        s_count_r <= 0;
                    else
                        s_key(127-s_count_r*32 downto 96-s_count_r*32) <= s_readVal;
                        s_count_r <= s_count_r + 1;
                    end if;
                else
                    if s_count_r = 3 then
                        s_block(127-s_count_r*32 downto 96-s_count_r*32) <= s_readVal;
                        s_ready <= '1';
                        s_count_r <= 0;
                    else
                        s_block(127-s_count_r*32 downto 96-s_count_r*32) <= s_readVal;
                        s_count_r <= s_count_r + 1;
                    end if;
                end if;
            end if;
        elsif s_ready = '1' then
            s_reset <= '1';
            s_write <= '1';
            s_ready <= '0';            
        elsif s_write = '1' and s_finish = '1' then
            s_dataValid_m <= '1';
            s_byteEnable_m <= (others => '1');
            s_lastWord_m <= '0';
            if s_readEnabled_m = '1' or s_count = 0 then
                if s_count < 3 then
                    s_dataValid_m <= '1';
                    s_byteEnable_m <= (others => '1');
                    s_encData_m32 <= s_encData_m(127-s_count*32 downto 96-s_count*32);
                    s_count <= s_count + 1;
                else
                    s_dataValid_m <= '1';
                    s_byteEnable_m <= (others => '1');
                    s_lastWord_m <= '1';
                    s_encData_m32 <= s_encData_m(127-s_count*32 downto 96-s_count*32);
                    s_reset <= '0';
                    s_count <= 0;
                end if;
              end if;      
        end if;
    end if;
end process;

-- User logic ends

end arch_imp;
