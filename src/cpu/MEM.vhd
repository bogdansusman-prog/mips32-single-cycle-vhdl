----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2026 09:28:41 PM
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEM is
    Port ( clk : in STD_LOGIC;
            en : in STD_LOGIC;
           MemWrite : in STD_LOGIC;
           ALURes : in STD_LOGIC_VECTOR (31 downto 0);
           RD2 : in STD_LOGIC_VECTOR (31 downto 0);
           MemData : out STD_LOGIC_VECTOR (31 downto 0));
end MEM;

architecture Behavioral of MEM is

    type ram_type is array (0 to 63) of STD_LOGIC_VECTOR(31 downto 0);
    signal RAM : ram_type := (
    0 => X"0000000A", -- MEM[0]  = X = 10
    1 => X"0000000C", -- MEM[4]  = A = 12
    2 => X"00000000", -- MEM[8]  = rezultat
    3 => X"00000007", -- MEM[12] = 7
    4 => X"0000000F", -- MEM[16] = 15
    5 => X"00000003", -- MEM[20] = 3
    6 => X"0000000B", -- MEM[24] = 11
    7 => X"00000000", -- MEM[28] = terminator
    others => X"00000000"
);

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if en = '1' and MemWrite = '1' then
                RAM(conv_integer(ALURes(7 downto 2))) <= RD2;
            end if;
        end if;
    end process;

    MemData <= RAM(conv_integer(ALURes(7 downto 2)));

end Behavioral;
