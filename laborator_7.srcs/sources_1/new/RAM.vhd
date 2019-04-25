


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- write first
entity rams_write_first is
    port ( clk : in std_logic;
    we : in std_logic;
    en : in std_logic;
    addr : in std_logic_vector(15 downto 0);
    di : in std_logic_vector(15 downto 0);
    do : out std_logic_vector(15 downto 0));
end rams_write_first;

architecture syn of rams_write_first is
type ram_type is array (0 to 15) of std_logic_vector (15 downto 0);
--signal RAM: ram_type:=(
--"0000000000000000",     --  0
--"0000000000000001",     --  1
--"0000000000000010",     --  2
--"0000000000000011",     --  3
--"0000000000000100",     --  4
--"0000000000000101",     --  5
--"0000000000000110",     --  6
--"0000000000000111",     --  7
--"0000000000001000",     --  8
--"0000000000001001",     --  9
--"0000000000001010",     --  10
--"0000000000001011",     --  11
--"0000000000001100",     --  12
--"0000000000001101",     --  13
--"0000000000001110",     --  14
--"0000000000001111",     --  15
--others => "0000000000000100");

signal RAM: ram_type:=(
"0000000000001010",     --  0   10
"0000000000001001",     --  1   9
"0000000000001000",     --  2   8
"0000000000000111",     --  3   7
"0000000000000110",     --  4   6
"0000000000000101",     --  5   5
"0000000000000100",     --  6   4
"0000000000000011",     --  7   3
"0000000000000010",     --  8   2
"0000000000000001",     --  9   1
"0000000000000000",     --  10  0
"0000000000001011",     --  11
"0000000000001100",     --  12
"0000000000001101",     --  13
"0000000000001110",     --  14
"0000000000001111",     --  15
others => "0000000000000100");

begin

process (clk)
begin
    if clk'event and clk = '1' then
        if en = '1' then
            if we = '1' then
                RAM(conv_integer(addr(3 downto 0))) <= di;  -- adresa pe doar 4 biti ATENTIE!!! 
            end if;
        end if;
    end if;
    do <= RAM( conv_integer(addr(3 downto 0))); -- adresa pe doar 4 biti ATENTIE!!!
end process;


end syn;