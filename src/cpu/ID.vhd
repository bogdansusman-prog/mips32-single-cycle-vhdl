----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2026 06:47:06 PM
-- Design Name: 
-- Module Name: ID - Behavioral
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
entity ID is
    Port ( clk : in STD_LOGIC;
           EN : in STD_LOGIC;
           Instr : in STD_LOGIC_VECTOR (25 downto 0);
           RegWrite : in STD_LOGIC;
           RegDst : in STD_LOGIC;
           ExtOp : in STD_LOGIC;
           WD : in STD_LOGIC_VECTOR (31 downto 0);
           RD1 : out STD_LOGIC_VECTOR (31 downto 0);
           RD2 : out STD_LOGIC_VECTOR (31 downto 0);
           Ext_Imm : out STD_LOGIC_VECTOR (31 downto 0);
           func : out STD_LOGIC_VECTOR (5 downto 0);
           sa : out STD_LOGIC_VECTOR (4 downto 0));
end ID;

architecture Behavioral of ID is
    type reg_file is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
    signal RF : reg_file := (0 => X"00000000",
    1 => X"00000001",
    2 => X"00000002",
    3 => X"00000003",
    4 => X"00000004",
    others => X"00000000");

    signal rs_addr : STD_LOGIC_VECTOR(4 downto 0);
    signal rt_addr : STD_LOGIC_VECTOR(4 downto 0);
    signal rd_addr : STD_LOGIC_VECTOR(4 downto 0);
    signal wr_addr : STD_LOGIC_VECTOR(4 downto 0);
    signal imm16   : STD_LOGIC_VECTOR(15 downto 0);
begin

    rs_addr <= Instr(25 downto 21);
    rt_addr <= Instr(20 downto 16);
    rd_addr <= Instr(15 downto 11);
    imm16   <= Instr(15 downto 0);

    -- multiplexor pentru registrul de destinatie
    wr_addr <= rd_addr when RegDst = '1' else rt_addr;

    -- citire asincrona din register file
    RD1 <= RF(conv_integer(rs_addr));
    RD2 <= RF(conv_integer(rt_addr));

    -- scriere sincrona in register file
    process(clk)
    begin
        if rising_edge(clk) then
            if EN = '1' and RegWrite = '1' then
    if conv_integer(wr_addr) /= 0 then
        RF(conv_integer(wr_addr)) <= WD;
    end if;
end if;
        end if;
    end process;

    -- extensie imediat
    process(imm16, ExtOp)
    begin
        if ExtOp = '1' then
            if imm16(15) = '1' then
                Ext_Imm <= X"FFFF" & imm16;
            else
                Ext_Imm <= X"0000" & imm16;
            end if;
        else
            Ext_Imm <= X"0000" & imm16;
        end if;
    end process;

    func <= Instr(5 downto 0);
    sa   <= Instr(10 downto 6);

end Behavioral;
