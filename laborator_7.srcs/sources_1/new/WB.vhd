----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2019 04:15:26 PM
-- Design Name: 
-- Module Name: WB - Behavioral
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


entity WB is
  Port (    MemtoReg:in STD_LOGIC;
            MemData: in STD_LOGIC_VECTOR(15 downto 0);
            ALURes: in STD_LOGIC_VECTOR(15 downto 0);
            WB_out: out STD_LOGIC_VECTOR(15 downto 0));
end WB;

architecture Behavioral of WB is
begin

with MemtoReg select
WB_out <=   ALURes when '0',
            MemData when '1';

end Behavioral;
