----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2019 03:36:58 PM
-- Design Name: 
-- Module Name: MEM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity MEM is
  Port (    clk : in STD_LOGIC;
            MemWrite: in STD_LOGIC;
            ALURes_in : in STD_LOGIC_VECTOR(15 downto 0);
            RD2: in STD_LOGIC_VECTOR(15 downto 0);
            MemData: out STD_LOGIC_VECTOR(15 downto 0);
            ALURes_out: out STD_LOGIC_VECTOR(15 downto 0);
            en_button:in STD_LOGIC);
end MEM;


architecture Behavioral of MEM is

component rams_write_first is
    port ( clk : in std_logic;
    we : in std_logic;
    en : in std_logic;
    addr : in std_logic_vector(15 downto 0);
    di : in std_logic_vector(15 downto 0);
    do : out std_logic_vector(15 downto 0));
end component;

begin

ALURes_out <= ALURes_in;

MEM_file: rams_write_first port map(clk, MemWrite, en_button, ALURes_in, RD2, MemData);

end Behavioral;
