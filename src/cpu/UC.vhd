----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2026 07:14:05 PM
-- Design Name: 
-- Module Name: UC - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UC is
    Port (         
    Instr     : in  STD_LOGIC_VECTOR(5 downto 0); -- opcode
        RegDst    : out STD_LOGIC;
        ExtOp     : out STD_LOGIC;
        ALUSrc    : out STD_LOGIC;
        Branch    : out STD_LOGIC;
        Jump      : out STD_LOGIC;
        MemWrite  : out STD_LOGIC;
        MemtoReg  : out STD_LOGIC;
        RegWrite  : out STD_LOGIC;
        ALUOp     : out STD_LOGIC_VECTOR(1 downto 0);
        B_GEZ : out std_logic;
        B_GTZ : out std_logic
        
        );
end UC;

architecture Behavioral of UC is

begin
process(Instr)
begin
    RegDst   <= '0';
    ExtOp    <= '0';
    ALUSrc   <= '0';
    Branch   <= '0';
    Jump     <= '0';
    MemWrite <= '0';
    MemtoReg <= '0';
    RegWrite <= '0';
    ALUOp    <= "00";
    B_GEZ <= '0';
    B_GTZ <= '0';

  case Instr is
      -- R type: ADD SUB SLL SRL AND OR XOR SLT
            when "000000" =>
                RegDst   <= '1';
                RegWrite <= '1';
                ALUOp    <= "10";

            -- ADDI
            when "111111" =>
                ExtOp    <= '1';
                RegWrite <= '1';
                ALUSrc <= '1';

            -- LW
            when "111110" =>
                ExtOp    <= '1';
                MemtoReg <= '1';
                RegWrite <= '1';
                ALUSrc <='1';

            -- SW
            when "111101" =>
                ExtOp    <= '1';
                MemWrite <= '1';
                ALUSrc <= '1';

            -- BEQ
            when "111100" =>
                ExtOp    <= '1';
                ALUSrc   <= '0';
                Branch   <= '1';
                ALUOp    <= "01";

            -- BGEZ
            when "111011" =>
                ExtOp    <= '1';
                ALUSrc   <= '1';
                B_GEZ    <= '1';
                ALUOp    <= "01";

            -- BGTZ
            when "111010" =>
                ExtOp    <= '1';
                ALUSrc   <= '1';
                B_GTZ    <= '1';
                ALUOp    <= "01";

            -- J
            when "111001" =>
                Jump <= '1';

            when others =>
                null;
        end case;
    end process;

end Behavioral;
