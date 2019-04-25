-- bun

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity SSD is
  Port (    digit0:in STD_LOGIC_VECTOR(3 downto 0);
            digit1:in STD_LOGIC_VECTOR(3 downto 0);
            digit2:in STD_LOGIC_VECTOR(3 downto 0);
            digit3:in STD_LOGIC_VECTOR(3 downto 0);
            clk : in STD_LOGIC;
            an: out STD_LOGIC_VECTOR(7 downto 0 );
            cat: out STD_LOGIC_VECTOR(6 downto 0));
end SSD;

architecture Behavioral of SSD is
--signals
signal counter:STD_LOGIC_VECTOR(15 downto 0):="0000000000000000";
signal mux_cat_out:STD_LOGIC_VECTOR(3 downto 0);

begin
--numarator pe 16 biti
process(clk)
begin
    if clk'event and clk = '1' then
        counter <= counter + 1;
    end if;
end process;

--mux catod
process(counter(15 downto 14))
begin
--if clk'event and clk = '1' then
    case counter(15 downto 14) is
        when "00" =>  mux_cat_out <= digit0;
        when "01" =>  mux_cat_out <= digit1;
        when "10" =>  mux_cat_out <= digit2;
        when "11" =>  mux_cat_out <= digit3;
    end case;
--end if;
end process;

process(mux_cat_out)
begin
    case mux_cat_out is
        when "0000" => cat<="1000000";   --0
        when "0001" => cat<="1111001";   --1
        when "0010" => cat<="0100100";   --2
        when "0011" => cat<="0110000";   --3
        when "0100" => cat<="0011001";   --4
        when "0101" => cat<="0010010";   --5
        when "0110" => cat<="0000010";   --6
        when "0111" => cat<="1111000";   --7
        when "1000" => cat<="0000000";   --8
        when "1001" => cat<="0010000";   --9
        when "1010" => cat<="0001000";   --A
        when "1011" => cat<="0000011";   --b
        when "1100" => cat<="1000110";   --C
        when "1101" => cat<="0100001";   --d
        when "1110" => cat<="0000110";   --E
        when "1111" => cat<="0001110";   --F
    end case;
end process;

-- DCD 7 segm
process(clk)
begin
    case counter(15 downto 14) is
        when "00" => an(3 downto 0) <= "1110";
        when "01" => an(3 downto 0) <= "1101";
        when "10" => an(3 downto 0) <= "1011";
        when "11" => an(3 downto 0) <= "0111";
    end case;
end process;

end Behavioral;
