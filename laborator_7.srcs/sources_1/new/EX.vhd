

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity EX is
  Port (    RD1: in STD_LOGIC_VECTOR(15 downto 0);
            ALUSrc:in STD_LOGIC;
            RD2: in STD_LOGIC_VECTOR(15 downto 0);
            Ext_Imm: in STD_LOGIC_VECTOR(15 downto 0);
            sa:in STD_LOGIC;
            func:in STD_LOGIC_VECTOR(2 downto 0);
            ALUOp:in STD_LOGIC_VECTOR(1 downto 0);
            Zero: out STD_LOGIC;
            ALURes: out STD_LOGIC_VECTOR(15 downto 0)  );
end EX;

architecture Behavioral of EX is
signal operator2:STD_LOGIC_VECTOR(15 downto 0);
signal ALUCtrl: STD_LOGIC_VECTOR(2 downto 0);
signal sll1, srl1,sum, mul:STD_LOGIC_VECTOR(15 downto 0);
signal Res :STD_LOGIC_VECTOR(15 downto 0);

begin
ALURes <= Res;
with ALUSrc select
operator2 <=    RD2 when '0',
                Ext_Imm when '1';
                
with ALUOp select
ALUCtrl <=  "000" when "00",
            "001" when "01",
            "011" when "10",
            func when "11";
            
with sa select
sll1 <=     RD1(14 downto 0) & '0' when '0',
            RD1(13 downto 0) & "00" when '1';
            
with sa select 
srl1 <=     '0' & RD1(15 downto 1) when '0',
            "00" & RD1(15 downto 2) when '1'; 


mul <= RD1(7 downto 0) *  operator2(7 downto 0);

with ALUCtrl select
Res <=      RD1 + operator2  when "000",
            RD1 - operator2 when "001",
            mul when "010",
            RD1 and operator2 when "011",
            RD1 or operator2 when "100",
            RD1 xor operator2 when "101",
            sll1 when "110",
            srl1 when "111";
                
with Res select
Zero <=     '1' when  "0000000000000000",
            '0' when others;

end Behavioral;
