library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity AES128Decoder is
    port(   clk: in std_logic;
            reset: in std_logic;
            clk_enable: in std_logic;
            load_block: in std_logic;
            load_key: in std_logic;
            key_exp_index: in std_logic_vector(1 downto 0);
            round_index: in std_logic_vector(3 downto 0);
            start_key_exp: in std_logic;
            start_round: in std_logic;
            last_round: in std_logic;
            blk_in: std_logic_vector(127 downto 0);
            key_in: std_logic_vector(127 downto 0);
            enc: out std_logic_vector(127 downto 0)
    );
end AES128Decoder;

architecture Behavioral of AES128Decoder is

type TType is array(0 to 255) of std_logic_vector(31 downto 0);
constant T : TType :=
(   x"c66363a5", x"f87c7c84", x"ee777799", x"f67b7b8d",
    x"fff2f20d", x"d66b6bbd", x"de6f6fb1", x"91c5c554",
    x"60303050", x"02010103", x"ce6767a9", x"562b2b7d", 
    x"e7fefe19", x"b5d7d762", x"4dababe6", x"ec76769a", 
    x"8fcaca45", x"1f82829d", x"89c9c940", x"fa7d7d87",
    x"effafa15", x"b25959eb", x"8e4747c9", x"fbf0f00b",
    x"41adadec", x"b3d4d467", x"5fa2a2fd", x"45afafea",
    x"239c9cbf", x"53a4a4f7", x"e4727296", x"9bc0c05b",
    x"75b7b7c2", x"e1fdfd1c", x"3d9393ae", x"4c26266a",
    x"6c36365a", x"7e3f3f41", x"f5f7f702", x"83cccc4f",
    x"6834345c", x"51a5a5f4", x"d1e5e534", x"f9f1f108",
    x"e2717193", x"abd8d873", x"62313153", x"2a15153f",
    x"0804040c", x"95c7c752", x"46232365", x"9dc3c35e",
    x"30181828", x"379696a1", x"0a05050f", x"2f9a9ab5",
    x"0e070709", x"24121236", x"1b80809b", x"dfe2e23d",
    x"cdebeb26", x"4e272769", x"7fb2b2cd", x"ea75759f", 
    x"1209091b", x"1d83839e", x"582c2c74", x"341a1a2e",
    x"361b1b2d", x"dc6e6eb2", x"b45a5aee", x"5ba0a0fb", 
    x"a45252f6", x"763b3b4d", x"b7d6d661", x"7db3b3ce", 
    x"5229297b", x"dde3e33e", x"5e2f2f71", x"13848497", 
    x"a65353f5", x"b9d1d168", x"00000000", x"c1eded2c", 
    x"40202060", x"e3fcfc1f", x"79b1b1c8", x"b65b5bed", 
    x"d46a6abe", x"8dcbcb46", x"67bebed9", x"7239394b", 
    x"944a4ade", x"984c4cd4", x"b05858e8", x"85cfcf4a", 
    x"bbd0d06b", x"c5efef2a", x"4faaaae5", x"edfbfb16", 
    x"864343c5", x"9a4d4dd7", x"66333355", x"11858594", 
    x"8a4545cf", x"e9f9f910", x"04020206", x"fe7f7f81", 
    x"a05050f0", x"783c3c44", x"259f9fba", x"4ba8a8e3", 
    x"a25151f3", x"5da3a3fe", x"804040c0", x"058f8f8a", 
    x"3f9292ad", x"219d9dbc", x"70383848", x"f1f5f504", 
    x"63bcbcdf", x"77b6b6c1", x"afdada75", x"42212163", 
    x"20101030", x"e5ffff1a", x"fdf3f30e", x"bfd2d26d", 
    x"81cdcd4c", x"180c0c14", x"26131335", x"c3ecec2f", 
    x"be5f5fe1", x"359797a2", x"884444cc", x"2e171739", 
    x"93c4c457", x"55a7a7f2", x"fc7e7e82", x"7a3d3d47", 
    x"c86464ac", x"ba5d5de7", x"3219192b", x"e6737395", 
    x"c06060a0", x"19818198", x"9e4f4fd1", x"a3dcdc7f", 
    x"44222266", x"542a2a7e", x"3b9090ab", x"0b888883", 
    x"8c4646ca", x"c7eeee29", x"6bb8b8d3", x"2814143c", 
    x"a7dede79", x"bc5e5ee2", x"160b0b1d", x"addbdb76", 
    x"dbe0e03b", x"64323256", x"743a3a4e", x"140a0a1e", 
    x"924949db", x"0c06060a", x"4824246c", x"b85c5ce4", 
    x"9fc2c25d", x"bdd3d36e", x"43acacef", x"c46262a6", 
    x"399191a8", x"319595a4", x"d3e4e437", x"f279798b", 
    x"d5e7e732", x"8bc8c843", x"6e373759", x"da6d6db7", 
    x"018d8d8c", x"b1d5d564", x"9c4e4ed2", x"49a9a9e0", 
    x"d86c6cb4", x"ac5656fa", x"f3f4f407", x"cfeaea25", 
    x"ca6565af", x"f47a7a8e", x"47aeaee9", x"10080818", 
    x"6fbabad5", x"f0787888", x"4a25256f", x"5c2e2e72", 
    x"381c1c24", x"57a6a6f1", x"73b4b4c7", x"97c6c651", 
    x"cbe8e823", x"a1dddd7c", x"e874749c", x"3e1f1f21", 
    x"964b4bdd", x"61bdbddc", x"0d8b8b86", x"0f8a8a85", 
    x"e0707090", x"7c3e3e42", x"71b5b5c4", x"cc6666aa", 
    x"904848d8", x"06030305", x"f7f6f601", x"1c0e0e12", 
    x"c26161a3", x"6a35355f", x"ae5757f9", x"69b9b9d0", 
    x"17868691", x"99c1c158", x"3a1d1d27", x"279e9eb9", 
    x"d9e1e138", x"ebf8f813", x"2b9898b3", x"22111133", 
    x"d26969bb", x"a9d9d970", x"078e8e89", x"339494a7", 
    x"2d9b9bb6", x"3c1e1e22", x"15878792", x"c9e9e920", 
    x"87cece49", x"aa5555ff", x"50282878", x"a5dfdf7a", 
    x"038c8c8f", x"59a1a1f8", x"09898980", x"1a0d0d17", 
    x"65bfbfda", x"d7e6e631", x"844242c6", x"d06868b8", 
    x"824141c3", x"299999b0", x"5a2d2d77", x"1e0f0f11", 
    x"7bb0b0cb", x"a85454fc", x"6dbbbbd6", x"2c16163a"
); 

type SType is array(0 to 255) of std_logic_vector(7 downto 0);
constant S : SType :=
(   x"63", x"7C", x"77", x"7B", 
    x"F2", x"6B", x"6F", x"C5", 
    x"30", x"01", x"67", x"2B", 
    x"FE", x"D7", x"AB", x"76", 
    x"CA", x"82", x"C9", x"7D", 
    x"FA", x"59", x"47", x"F0", 
    x"AD", x"D4", x"A2", x"AF", 
    x"9C", x"A4", x"72", x"C0", 
    x"B7", x"FD", x"93", x"26", 
    x"36", x"3F", x"F7", x"CC", 
    x"34", x"A5", x"E5", x"F1", 
    x"71", x"D8", x"31", x"15", 
    x"04", x"C7", x"23", x"C3", 
    x"18", x"96", x"05", x"9A", 
    x"07", x"12", x"80", x"E2", 
    x"EB", x"27", x"B2", x"75", 
    x"09", x"83", x"2C", x"1A", 
    x"1B", x"6E", x"5A", x"A0", 
    x"52", x"3B", x"D6", x"B3", 
    x"29", x"E3", x"2F", x"84", 
    x"53", x"D1", x"00", x"ED", 
    x"20", x"FC", x"B1", x"5B", 
    x"6A", x"CB", x"BE", x"39", 
    x"4A", x"4C", x"58", x"CF", 
    x"D0", x"EF", x"AA", x"FB", 
    x"43", x"4D", x"33", x"85", 
    x"45", x"F9", x"02", x"7F", 
    x"50", x"3C", x"9F", x"A8", 
    x"51", x"A3", x"40", x"8F", 
    x"92", x"9D", x"38", x"F5", 
    x"BC", x"B6", x"DA", x"21", 
    x"10", x"FF", x"F3", x"D2", 
    x"CD", x"0C", x"13", x"EC", 
    x"5F", x"97", x"44", x"17", 
    x"C4", x"A7", x"7E", x"3D", 
    x"64", x"5D", x"19", x"73", 
    x"60", x"81", x"4F", x"DC", 
    x"22", x"2A", x"90", x"88", 
    x"46", x"EE", x"B8", x"14", 
    x"DE", x"5E", x"0B", x"DB", 
    x"E0", x"32", x"3A", x"0A", 
    x"49", x"06", x"24", x"5C", 
    x"C2", x"D3", x"AC", x"62", 
    x"91", x"95", x"E4", x"79", 
    x"E7", x"C8", x"37", x"6D", 
    x"8D", x"D5", x"4E", x"A9", 
    x"6C", x"56", x"F4", x"EA", 
    x"65", x"7A", x"AE", x"08", 
    x"BA", x"78", x"25", x"2E", 
    x"1C", x"A6", x"B4", x"C6", 
    x"E8", x"DD", x"74", x"1F", 
    x"4B", x"BD", x"8B", x"8A", 
    x"70", x"3E", x"B5", x"66", 
    x"48", x"03", x"F6", x"0E", 
    x"61", x"35", x"57", x"B9", 
    x"86", x"C1", x"1D", x"9E", 
    x"E1", x"F8", x"98", x"11", 
    x"69", x"D9", x"8E", x"94", 
    x"9B", x"1E", x"87", x"E9", 
    x"CE", x"55", x"28", x"DF", 
    x"8C", x"A1", x"89", x"0D", 
    x"BF", x"E6", x"42", x"68", 
    x"41", x"99", x"2D", x"0F", 
    x"B0", x"54", x"BB", x"16"
);

type RType is array(0 to 9) of std_logic_vector(31 downto 0);
constant Rcon : RType := ( x"01000000", x"02000000", x"04000000", x"08000000", x"10000000", 
                           x"20000000", x"40000000", x"80000000", x"1B000000", x"36000000"
                         );

type BlockType is array(0 to 3, 0 to 3) of std_logic_vector(7 downto 0);

signal key : BlockType;
signal state : BlockType;
signal tmp_state : BlockType; 

signal s_key_tmp, s_key_rot : std_logic_vector(31 downto 0);

signal s_tmp0, s_tmp1, s_tmp2, s_tmp3 : std_logic_vector(31 downto 0);
signal s_final0, s_final1, s_final2, s_final3 : std_logic_vector(31 downto 0);

signal t_aux3_0, t_aux2_0, t_aux1_0, t_aux0_0 : std_logic_vector(31 downto 0);
signal t_aux3_1, t_aux2_1, t_aux1_1, t_aux0_1 : std_logic_vector(31 downto 0);
signal t_aux3_2, t_aux2_2, t_aux1_2, t_aux0_2 : std_logic_vector(31 downto 0);
signal t_aux3_3, t_aux2_3, t_aux1_3, t_aux0_3 : std_logic_vector(31 downto 0);

signal s_is_last : std_logic := '0';

signal k_0, k_1, k_2, k_3 : std_logic_vector(31 downto 0);

begin

-- column 0            
t_aux0_0 <= T(to_integer(unsigned(state(0,0))));
t_aux1_0 <= T(to_integer(unsigned(state(1,1))))(7 downto 0) & T(to_integer(unsigned(state(1,1))))(31 downto 8);
t_aux2_0 <= T(to_integer(unsigned(state(2,2))))(15 downto 0) & T(to_integer(unsigned(state(2,2))))(31 downto 16);
t_aux3_0 <= T(to_integer(unsigned(state(3,3))))(23 downto 0) & T(to_integer(unsigned(state(3,3))))(31 downto 24);

k_0 <= key(0,0) & key(0,1) & key(0,2) & key(0,3);

s_tmp0 <= k_0 xor t_aux0_0 xor t_aux1_0 xor t_aux2_0 xor t_aux3_0; 

-- column 1            
t_aux0_1 <= T(to_integer(unsigned(state(1,0))));
t_aux1_1 <= T(to_integer(unsigned(state(2,1))))(7 downto 0) & T(to_integer(unsigned(state(2,1))))(31 downto 8);
t_aux2_1 <= T(to_integer(unsigned(state(3,2))))(15 downto 0) & T(to_integer(unsigned(state(3,2))))(31 downto 16);
t_aux3_1 <= T(to_integer(unsigned(state(0,3))))(23 downto 0) & T(to_integer(unsigned(state(0,3))))(31 downto 24);

k_1 <= key(1,0) & key(1,1) & key(1,2) & key(1,3);

s_tmp1 <= k_1 xor t_aux0_1 xor t_aux1_1 xor t_aux2_1 xor t_aux3_1;

-- column 2            
t_aux0_2 <= T(to_integer(unsigned(state(2,0))));
t_aux1_2 <= T(to_integer(unsigned(state(3,1))))(7 downto 0) & T(to_integer(unsigned(state(3,1))))(31 downto 8);
t_aux2_2 <= T(to_integer(unsigned(state(0,2))))(15 downto 0) & T(to_integer(unsigned(state(0,2))))(31 downto 16);
t_aux3_2 <= T(to_integer(unsigned(state(1,3))))(23 downto 0) & T(to_integer(unsigned(state(1,3))))(31 downto 24);

k_2 <= key(2,0) & key(2,1) & key(2,2) & key(2,3);

s_tmp2 <= k_2 xor t_aux0_2 xor t_aux1_2 xor t_aux2_2 xor t_aux3_2;

-- column 3            
t_aux0_3 <= T(to_integer(unsigned(state(3,0))));
t_aux1_3 <= T(to_integer(unsigned(state(0,1))))(7 downto 0) & T(to_integer(unsigned(state(0,1))))(31 downto 8);
t_aux2_3 <= T(to_integer(unsigned(state(1,2))))(15 downto 0) & T(to_integer(unsigned(state(1,2))))(31 downto 16);
t_aux3_3 <= T(to_integer(unsigned(state(2,3))))(23 downto 0) & T(to_integer(unsigned(state(2,3))))(31 downto 24);

k_3 <= key(3,0) & key(3,1) & key(3,2) & key(3,3);

s_tmp3 <= k_3 xor t_aux0_3 xor t_aux1_3 xor t_aux2_3 xor t_aux3_3;


-- Final round path

s_key_tmp <= (S(to_integer(unsigned(key(3,1)))) & S(to_integer(unsigned(key(3,2)))) & S(to_integer(unsigned(key(3,3)))) & S(to_integer(unsigned(key(3,0))))) xor Rcon(to_integer(unsigned(round_index))) when key_exp_index = "00"
                else key(to_integer(unsigned(key_exp_index))-1,0) & key(to_integer(unsigned(key_exp_index))-1,1) & 
                     key(to_integer(unsigned(key_exp_index))-1,2) & key(to_integer(unsigned(key_exp_index))-1,3);

process(clk, reset, clk_enable, load_key, load_block, start_key_exp, start_round, last_round)
begin
    if rising_edge(clk) then
        if clk_enable = '1' then
            if reset = '1' then
                s_is_last <= '0';
            elsif load_key = '1' then
                key <= ( ( key_in(127 downto 120), key_in(119 downto 112), key_in(111 downto 104), key_in(103 downto  96) ),
                         ( key_in( 95 downto  88), key_in( 87 downto  80), key_in( 79 downto  72), key_in( 71 downto  64) ),
                         ( key_in( 63 downto  56), key_in( 55 downto  48), key_in( 47 downto  40), key_in( 39 downto  32) ),
                         ( key_in( 31 downto  24), key_in( 23 downto  16), key_in( 15 downto   8), key_in(  7 downto   0) )
                );
                
            elsif load_block = '1' then
                state <= ( ( blk_in(127 downto 120) xor key(0,0), blk_in(119 downto 112) xor key(0,1), blk_in(111 downto 104) xor key(0,2), blk_in(103 downto  96) xor key(0,3) ),
                           ( blk_in( 95 downto  88) xor key(1,0), blk_in( 87 downto  80) xor key(1,1), blk_in( 79 downto  72) xor key(1,2), blk_in( 71 downto  64) xor key(1,3) ),
                           ( blk_in( 63 downto  56) xor key(2,0), blk_in( 55 downto  48) xor key(2,1), blk_in( 47 downto  40) xor key(2,2), blk_in( 39 downto  32) xor key(2,3) ),
                           ( blk_in( 31 downto  24) xor key(3,0), blk_in( 23 downto  16) xor key(3,1), blk_in( 15 downto   8) xor key(3,2), blk_in(  7 downto   0) xor key(3,3) )
                );
            elsif start_key_exp = '1' and s_is_last = '0' then
                key(to_integer(unsigned(key_exp_index)),0) <= key(to_integer(unsigned(key_exp_index)),0) xor s_key_tmp(31 downto 24);
                key(to_integer(unsigned(key_exp_index)),1) <= key(to_integer(unsigned(key_exp_index)),1) xor s_key_tmp(23 downto 16);
                key(to_integer(unsigned(key_exp_index)),2) <= key(to_integer(unsigned(key_exp_index)),2) xor s_key_tmp(15 downto 8);
                key(to_integer(unsigned(key_exp_index)),3) <= key(to_integer(unsigned(key_exp_index)),3) xor s_key_tmp(7 downto 0);
            elsif start_round = '1' and s_is_last = '0' then
                if last_round = '0' then
                    state <= ( ( s_tmp0(31 downto 24), s_tmp0(23 downto 16), s_tmp0(15 downto 8), s_tmp0(7 downto 0) ),
                               ( s_tmp1(31 downto 24), s_tmp1(23 downto 16), s_tmp1(15 downto 8), s_tmp1(7 downto 0) ),
                               ( s_tmp2(31 downto 24), s_tmp2(23 downto 16), s_tmp2(15 downto 8), s_tmp2(7 downto 0) ),
                               ( s_tmp3(31 downto 24), s_tmp3(23 downto 16), s_tmp3(15 downto 8), s_tmp3(7 downto 0) )
                    );
                else
                    s_is_last <= '1';
                    state <= ( ( S(to_integer(unsigned(state(0,0)))) xor key(0,0), S(to_integer(unsigned(state(1,1)))) xor key(0,1), S(to_integer(unsigned(state(2,2)))) xor key(0,2), S(to_integer(unsigned(state(3,3)))) xor key(0,3) ),
                               ( S(to_integer(unsigned(state(1,0)))) xor key(1,0), S(to_integer(unsigned(state(2,1)))) xor key(1,1), S(to_integer(unsigned(state(3,2)))) xor key(1,2), S(to_integer(unsigned(state(0,3)))) xor key(1,3) ),
                               ( S(to_integer(unsigned(state(2,0)))) xor key(2,0), S(to_integer(unsigned(state(3,1)))) xor key(2,1), S(to_integer(unsigned(state(0,2)))) xor key(2,2), S(to_integer(unsigned(state(1,3)))) xor key(2,3) ),
                               ( S(to_integer(unsigned(state(3,0)))) xor key(3,0), S(to_integer(unsigned(state(0,1)))) xor key(3,1), S(to_integer(unsigned(state(1,2)))) xor key(3,2), S(to_integer(unsigned(state(2,3)))) xor key(3,3) )
                             );
                end if;
            end if;
            enc <= state(0,0) & state(0,1) & state(0,2) & state(0,3) &
                           state(1,0) & state(1,1) & state(1,2) & state(1,3) &
                           state(2,0) & state(2,1) & state(2,2) & state(2,3) &
                           state(3,0) & state(3,1) & state(3,2) & state(3,3);
              
        end if;
    end if;
end process;
end Behavioral;
