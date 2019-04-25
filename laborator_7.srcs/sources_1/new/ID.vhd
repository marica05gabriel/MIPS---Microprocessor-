-- bun
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity ID is
  Port (    clk: in STD_LOGIC;
            RegWrite: in STD_LOGIC;
            Instr:in STD_LOGIC_VECTOR(15 downto 0);
            RegDst:in STD_LOGIC;
            ExtOp: in STD_LOGIC;
            RD1: out STD_LOGIC_VECTOR(15 downto 0);
            RD2: out STD_LOGIC_VECTOR(15 downto 0);
            WD: in STD_LOGIC_VECTOR(15 downto 0);
            Ext_Imm:out STD_LOGIC_VECTOR(15 downto 0);
            func: out STD_LOGIC_VECTOR(2 downto 0);
            sa:out STD_LOGIC;
            en_button: in STD_LOGIC);
end ID;

architecture Behavioral of ID is
signal RA1, RA2 ,WA: STD_LOGIC_VECTOR(2 downto 0);
signal signExt: STD_LOGIC_VECTOR(15 downto 0);

component reg_file is
  Port (    
            clk:in STD_LOGIC;
            RegWr: in STD_LOGIC;
            RA1:in STD_LOGIC_VECTOR(2 downto 0);
            RA2:in STD_LOGIC_VECTOR(2 downto 0);
            WA: in STD_LOGIC_VECTOR(2 downto 0);
            WD: in STD_LOGIC_VECTOR(15 downto 0);
            RD1,RD2:out STD_LOGIC_VECTOR(15 downto 0);
            en_button: in STD_LOGIC);
end component;
begin
RegFile: reg_file port map(clk, RegWrite, RA1, RA2, WA, WD ,RD1, RD2, en_button);

RA1 <= Instr(12 downto 10);     -- rs
RA2 <= Instr(9 downto 7);       -- rt

with RegDst select
WA <=   Instr(9 downto 7) when '0',     -- rt
        Instr(6 downto 4) when '1';     -- rd

signExt <=  Instr(6)&Instr(6)&Instr(6)&Instr(6)&Instr(6)&Instr(6)&Instr(6)&Instr(6)&Instr(6)& Instr(6 downto 0);       
with ExtOp select 
Ext_Imm <=  "000000000"&Instr(6 downto 0) when '0',
            signExt when '1';
            
func <= Instr(2 downto 0);
sa <= Instr(3);

end Behavioral;
