-- bun

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity UC is
  Port (    Instr: in STD_LOGIC_VECTOR(15 downto 13);
            ALUOp : out STD_LOGIC_VECTOR(1 downto 0);
            RegDst, ExtOp, ALUSrc, Branch, BranchNE, Jump, MemWrite, MemtoReg , RegWrite : out STD_LOGIC);
end UC;

architecture Behavioral of UC is

begin

process( Instr) 
begin
    RegDst  <= '0';
    ExtOp   <= '0';
    ALUSrc  <= '0';
    Branch  <= '0';
    BranchNE  <= '0';
    Jump    <= '0';
    ALUOp   <= "00";
    MemWrite<= '0';
    MemtoReg<= '0';
    RegWrite<= '0';
    case Instr is
    -- R type
        when "000" =>   RegDst      <= '1'; 
                        RegWrite    <= '1';
                        ALUOp       <= "11";
    -- addi
        when "001" =>   ALUSrc      <= '1';         
                        ExtOp       <= '1';                    
                        RegWrite    <= '1';
    -- lw                  
        when "010" =>   ALUSrc <= '1';         
                        MemtoReg <= '1'; 
                        RegWrite <= '1';
    -- sw
        when "011" =>   ALUSrc <= '1';          
                        MemWrite <= '1';
    -- beq
        when "100" =>   Branch <= '1';
                        ExtOp <= '1';              
                        ALUOp <= "01";
    -- bne
        when "101" =>   BranchNE <= '1';
                        ExtOp <= '1';
                        ALUOp <= "01"; 
    -- andi                           
        when "110" =>   ALUSrc <= '1';
                        RegWrite <= '1';
                        ALUOp <= "10"; 
    -- jump
        when "111" =>   Jump <= '1';
     end case;
end process;

end Behavioral;
