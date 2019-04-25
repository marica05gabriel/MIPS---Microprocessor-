-- bun
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;


entity I_F is
Port (  clk : in STD_LOGIC;
        PCSrc: in STD_LOGIC;
        Branch_adress: in STD_LOGIC_VECTOR(15 downto 0);
        Jump: in STD_LOGIC;
        Jump_adress: in STD_LOGIC_VECTOR(15 downto 0);


        Instr: out STD_LOGIC_VECTOR(15 downto 0);
        en_button: in STD_LOGIC ;
        rst_pc: in STD_LOGIC;
        PC_adress: out STD_LOGIC_VECTOR(15 downto 0));

end entity;

architecture Behavioral of I_F is

component PC is
  Port (    clk: in STD_LOGIC;
            en_button: in STD_LOGIC;
            rst_button: in STD_LOGIC;
            next_adress :in STD_LOGIC_VECTOR(15 downto 0);
            adress: out STD_LOGIC_VECTOR(15 downto 0));
end component;

component ROM_progr is
  Port (    
            adr: in STD_LOGIC_VECTOR (15 downto 0);
            data_out: out STD_LOGIC_VECTOR(15 downto 0));
end component;

signal PC_current_address, PC_next_in: STD_LOGIC_VECTOR(15 downto 0);
signal Instr_ROM: STD_LOGIC_VECTOR(15 downto 0);
signal Branch: STD_LOGIC_VECTOR(15 downto 0);
signal PC_plus_1: STD_LOGIC_VECTOR(15 downto 0);

begin

ROM: ROM_progr port map(PC_current_address, Instr); 
PC_program_counter: PC port map (clk, en_button, rst_pc, PC_next_in , PC_current_address); 

PC_plus_1 <= PC_current_address + 1;

with PCSrc select
Branch <=   Branch_adress when '1',
            PC_plus_1 when '0';
with Jump select
PC_next_in <=   Jump_adress when '1',
                Branch when '0';
                
PC_adress <= PC_current_address;           
            
         

end Behavioral;
