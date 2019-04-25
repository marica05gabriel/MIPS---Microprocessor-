-- bun

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;



entity reg_file is
  Port (    
            clk:in STD_LOGIC;
            RegWr: in STD_LOGIC;
            RA1:in STD_LOGIC_VECTOR(2 downto 0);
            RA2:in STD_LOGIC_VECTOR(2 downto 0);
            WA: in STD_LOGIC_VECTOR(2 downto 0);
            WD: in STD_LOGIC_VECTOR(15 downto 0);
            RD1,RD2:out STD_LOGIC_VECTOR(15 downto 0);
            en_button: in STD_LOGIC);
end reg_file;

architecture Behavioral of reg_file is
type reg_array is array (0 to 15) of STD_LOGIC_VECTOR(15 downto 0);
signal reg_file : reg_array:=(
"0000000000000000",
"0000000000000001",
"0000000000000010",
"0000000000000011",
others => "0000000000000010");

begin
RD1 <= reg_file(conv_integer(RA1));
RD2 <= reg_file(conv_integer(RA2));

process(clk)
begin
if clk'event and clk = '1' then
    if en_button = '1' then
        if RegWr = '1' then
            reg_file(conv_integer(WA)) <= WD;
        end if;
    end if;
end if;
end process;


end Behavioral;
