
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity main_project is
  Port ( 
        clk: in STD_LOGIC;
        btn: in STD_LOGIC_VECTOR(4 downto 0);
        sw: in STD_LOGIC_VECTOR(15 downto 0);
        led: out STD_LOGIC_VECTOR(15 downto 0);
        an: out STD_LOGIC_VECTOR(7 downto 0);
        cat:out STD_LOGIC_VECTOR(6 downto 0));
end main_project;



architecture Behavioral of main_project is
---------------------------------------------COMPONENTS--------------------------------------
component I_F is
Port (  clk : in STD_LOGIC;
        PCSrc: in STD_LOGIC;
        Branch_adress: in STD_LOGIC_VECTOR(15 downto 0);
        Jump: in STD_LOGIC;
        Jump_adress: in STD_LOGIC_VECTOR(15 downto 0);


        Instr: out STD_LOGIC_VECTOR(15 downto 0);
        en_button: in STD_LOGIC ;
        rst_pc: in STD_LOGIC;
        PC_adress: out STD_LOGIC_VECTOR(15 downto 0));
end component;

component UC is
  Port (    Instr: in STD_LOGIC_VECTOR(15 downto 13);
            ALUOp : out STD_LOGIC_VECTOR(1 downto 0);
            RegDst, ExtOp, ALUSrc, Branch, BranchNE, Jump, MemWrite, MemtoReg , RegWrite : out STD_LOGIC);
end component;

component ID is
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
end component;

component MEM is
  Port (    clk : in STD_LOGIC;
            MemWrite: in STD_LOGIC;
            ALURes_in : in STD_LOGIC_VECTOR(15 downto 0);
            RD2: in STD_LOGIC_VECTOR(15 downto 0);
            MemData: out STD_LOGIC_VECTOR(15 downto 0);
            ALURes_out: out STD_LOGIC_VECTOR(15 downto 0);
            en_button:in STD_LOGIC);
end component;

component SSD is
  Port (    clk:in STD_LOGIC;
            digit0,digit1,digit2,digit3: in STD_LOGIC_VECTOR(3 downto 0);
            an: out STD_LOGIC_VECTOR(7 downto 0);
            cat: out STD_LOGIC_VECTOR(6 downto 0));
end component;

component MPG is 
Port(   input:in STD_LOGIC;
        clk : in STD_LOGIC;
        enable: out STD_LOGIC);
end component;

component EX is
  Port (    RD1: in STD_LOGIC_VECTOR(15 downto 0);
            ALUSrc:in STD_LOGIC;
            RD2: in STD_LOGIC_VECTOR(15 downto 0);
            Ext_Imm: in STD_LOGIC_VECTOR(15 downto 0);
            sa:in STD_LOGIC;
            func:in STD_LOGIC_VECTOR(2 downto 0);
            ALUOp:in STD_LOGIC_VECTOR(1 downto 0);
            Zero: out STD_LOGIC;
            ALURes: out STD_LOGIC_VECTOR(15 downto 0)  );
end component;

component WB is
  Port (    MemtoReg:in STD_LOGIC;
            MemData: in STD_LOGIC_VECTOR(15 downto 0);
            ALURes: in STD_LOGIC_VECTOR(15 downto 0);
            WB_out: out STD_LOGIC_VECTOR(15 downto 0));
end component;
---------------------------------------------------   END COMPONENTS   ---------------------------------------


----------------------------------------------  CONTROL SIGNALS  ---------------------------------------------
signal RegDst, ExtOp, ALUSrc, Branch, BranchNE, Jump, MemWrite, MemtoReg, PCSrc, RegWrite: STD_LOGIC;
signal ALUOp : STD_LOGIC_VECTOR(1 downto 0);
signal BranchAux, BranchNEAux: STD_LOGIC;
----------------------------------------------- / CONTROL SIGNALS---------------------------------------------

------------------------------------------------    MAIN SIGNALS ---------------------------------------------
signal Instr: STD_LOGIC_VECTOR(15 downto 0);
signal rs, rt, rd, opcode, func: STD_LOGIC_VECTOR(2 downto 0);
signal sa: STD_LOGIC;
signal imm: STD_LOGIC_VECTOR(6 downto 0); 
----------------------------------------------  END MAIN SIGNALS ---------------------------------------------

----------------------------------------------    OTHER SIGNALS ----------------------------------------------
signal WriteData: STD_LOGIC_VECTOR(15 downto 0);
signal Branch_adress, Jump_adress: STD_LOGIC_VECTOR(15 downto 0);
signal PC_current_address, PC_plus_1: STD_LOGIC_VECTOR(15 downto 0);

signal RD1, RD2:STD_LOGIC_VECTOR(15 downto 0);
signal ExtImm : STD_LOGIC_VECTOR(15 downto 0);
-------------------------------------------  END  OTHER SIGNALS ----------------------------------------------
signal ALURes_in, ALURes_out, MemData:STD_LOGIC_VECTOR(15 downto 0);
signal Zero_ALU:STD_LOGIC;

------------------------------------------- MPG buttons ------------------------------------------------------
signal en_button, rst_pc: STD_LOGIC :='0';
signal SSD_display :STD_LOGIC_VECTOR(15 downto 0);
-------------------------------------   END MPG buttons ------------------------------------------------------

begin
IF_instruction_fetch: I_F port map(clk, PCSrc, Branch_adress, Jump, Jump_adress, Instr, en_button, rst_pc, PC_current_address); 
UC_unit_control : UC port map(opcode, ALUOp, RegDst, ExtOp, ALUSrc, Branch, BranchNE, Jump, MemWrite, MemtoReg, RegWrite);
ID_instruction_decoder: ID port map(clk, RegWrite, Instr, RegDst, ExtOp, RD1, RD2, WriteData, ExtImm, func, sa, en_button);

PC_plus_1 <= PC_current_address + 1;

opcode <= Instr(15 downto 13);
rs <= Instr(12 downto 10);
rt <= Instr(9 downto 7);
rd <= Instr(6 downto 4);
sa <= Instr(3);
func <= Instr(2 downto 0);
imm <= Instr (6 downto 0);

--WriteData <= RD1 + RD2;

led(0)<=RegWrite;
led(1)<=MemtoReg;
led(2)<=MemWrite;
led(3)<=ALUOp(0);
led(4)<=ALUOp(1);
led(5)<=Jump;
led(6)<=BranchNE;
led(7)<=Branch;
led(8)<=ALUSrc;
led(9)<=ExtOp;
led(10)<=RegDst;

MPG_1:  MPG port map(btn(0), clk, en_button);
MPG_2:  MPG port map(btn(1), clk, rst_pc);

-- CE AFISEAZA SSD
with sw(2 downto 0) select
SSD_display <=  PC_current_address when "000",
                RD1 when "001",
                RD2 when "010",
                WriteData when "011",
                Instr when "100",
                ExtImm when "101",
                "0000000000000000" when others;

SSD_afisor: SSD port map(clk, SSD_display(3 downto 0), SSD_display(7 downto 4), SSD_display(11 downto 8), SSD_display(15 downto 12), an, cat);

-- DE AICI LAB 7
MEM_1: MEM port map(clk, MemWrite, ALURes_in, RD2, MemData, ALURes_out, en_button);
EX_1: EX port map( RD1, ALUSrc, RD2, ExtImm, sa, func, ALUOp, Zero_ALU, ALURes_out);
WB_1: WB port map (MemtoReg, MemData, ALURes_out, WriteData);

-- JUMP and BRANCH
BranchAux <= Branch and Zero_ALU;
BranchNEAux <= BranchNE and (not Zero_ALU);
PCSrc <= BranchAux or BranchNEAux;

Branch_adress <= PC_plus_1 + ExtImm;               
Jump_adress <=  PC_plus_1(15 downto 13) & Instr(12 downto 0);

led(15) <= Zero_ALU;

end Behavioral;
