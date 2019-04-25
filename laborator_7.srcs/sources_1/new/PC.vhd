-- bun
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity PC is
  Port (    clk: in STD_LOGIC;
            en_button: in STD_LOGIC;
            rst_button: in STD_LOGIC;
            next_adress :in STD_LOGIC_VECTOR(15 downto 0);
            adress: out STD_LOGIC_VECTOR(15 downto 0));
end PC;

architecture Behavioral of PC is

begin
process(clk,rst_button)
begin
    if rst_button = '1' then
        adress <= b"0000_0000_0000_0000";
    else
        if rising_edge(clk) then
            if en_button = '1' then
                adress <= next_adress;
            end if;
        end if; 
    end if;
end process;


end Behavioral;
