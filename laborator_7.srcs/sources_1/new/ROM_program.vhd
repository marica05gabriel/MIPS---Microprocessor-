-- bun
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ROM_progr is
  Port (    
            adr: in STD_LOGIC_VECTOR (15 downto 0);
            data_out: out STD_LOGIC_VECTOR(15 downto 0));
end ROM_progr;

architecture Behavioral of ROM_progr is

type ROM_File is array (0 to 255) of STD_LOGIC_VECTOR(15 downto 0);
signal ROM_data: ROM_File:=(
b"000_000_000_001_0_000",       --0     add $0 $0 $1        0010
b"001_000_100_0001010",         --1     addi $0 10 $4       220A
b"000_000_000_010_0_000",       --2     add $0 $0 $2        0020
b"001_000_110_0000001",         --3     addi $0 1 $6        2301
b"100_001_100_0001000",         --4     beq $1 $4 8         8608
b"010_010_011_0000000",         --5     lw 00($2) $3        4980
b"110_011_101_0000001",         --6     andi $3 1 $5        CE81
b"101_101_110_0000010",         --7     bne $5 $6 2         B702
b"000_011_011_011_0_000",       --8     add $3 $3 $3        0DB0 
b"011_010_011_0000000",         --9     sw $3 00($2)        6980
b"001_001_001_0000001",         --A    addi $1 1 $1        2481
b"001_010_010_0000001",         --B    addi $2 1 $2        2901
b"111_0000000000100",           --C    j 4 
b"010_000_100_0000000",         --D
b"010_000_100_0000001",         --E        
b"010_000_100_0000010",         --F
b"010_000_100_0000011",         --10
b"010_000_100_0000100",         --11
b"010_000_100_0000101",         --12
b"010_000_100_0000110",         --13
b"010_000_100_0000111",         --14
b"010_000_100_0001000",         --15
b"010_000_100_0001001",         --16
b"010_000_100_0001010",         --17
others => b"000_000_000_000_0_000" ); 

begin

data_out <= ROM_data( conv_integer(adr) );
        

end Behavioral;
