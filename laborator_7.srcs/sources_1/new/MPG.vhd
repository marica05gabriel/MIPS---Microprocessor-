--bun
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MPG is 
Port(   input:in STD_LOGIC;
        clk : in STD_LOGIC;
        enable: out STD_LOGIC);
end entity;

architecture MPG_ARH of MPG is
--signals:
signal counter: STD_LOGIC_VECTOR(15 downto 0):="0000000000000000";
signal Q1, Q2, Q3:STD_LOGIC;

begin

--numarator
process(clk)
begin
    if clk'event and clk = '1' then
        counter <= counter + 1;
     end if;
 end process;
 
 --bistabil 1
 process(clk)
 begin
    if clk'event and clk = '1' then
        if counter = "1111111111111111" then
            Q1 <= input ;
        end if;
    end if;
end process;

--bistabil 2, 3
process(clk)
begin
    if clk'event and clk = '1' then
        Q2 <= Q1 ;
        Q3 <= Q2;
    end if;
end process;

-- activez iesirea;
enable <= Q2 and (not Q3);

end architecture MPG_ARH;
