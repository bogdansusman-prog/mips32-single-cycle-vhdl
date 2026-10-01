----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2026 08:02:02 PM
-- Design Name: 
-- Module Name: EX - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EX is
    Port ( RD1 : in STD_LOGIC_VECTOR (31 downto 0);
           RD2 : in STD_LOGIC_VECTOR (31 downto 0);
           ALUSrc : in STD_LOGIC;
           Ext_Imm : in STD_LOGIC_VECTOR (31 downto 0);
           sa : in STD_LOGIC_VECTOR (4 downto 0);
           func : in STD_LOGIC_VECTOR (5 downto 0);
           ALUOp : in STD_LOGIC_VECTOR (1 downto 0);
           PC4 : in STD_LOGIC_VECTOR (31 downto 0);
           Zero : out STD_LOGIC;
           GTZ : out STD_LOGIC;
           GEZ : out STD_LOGIC;
           ALURes : out STD_LOGIC_VECTOR (31 downto 0);
           BranchAddress : out STD_LOGIC_VECTOR (31 downto 0));
end EX;

architecture Behavioral of EX is
signal B : STD_LOGIC_vector(31 downto 0);
signal ALUCtrl : STD_LOGIC_VECTOR(2 downto 0);
signal C : std_logic_vector(31 downto 0);
signal Ext_Imm_Sh : std_logic_vector(31 downto 0);
begin

    B <= RD2 when ALUSrc = '0' else Ext_Imm;
    Ext_Imm_Sh <= Ext_Imm(29 downto 0) & "00";

    process(ALUOp, func)
    begin
        case ALUOp is
            when "00" =>
                ALUCtrl <= "000"; -- add pentru addi, lw, sw
            when "01" =>
                ALUCtrl <= "001"; --pentru beq bgez bgtz
            when "10" =>
                case func is
                    when "100000" => ALUCtrl <= "000"; -- add
                    when "100010" => ALUCtrl <= "001"; -- sub
                    when "000000" => ALUCtrl <= "101"; -- sll
                    when "000010" => ALUCtrl <= "110"; --srl
                    when "100100" => ALUCtrl <= "010"; --and
                    when "100101" => ALUCtrl <= "011"; --or
                    when "100110" => ALUCtrl <= "100"; --xor
                    when "101010" => ALUCtrl <= "111"; --slt
                    when others => ALUCtrl <= "000";
                end case;
          when others => ALUCtrl <= "000";
      end case;
    end process;
    
    
      process(RD1, B, ALUCtrl, sa)
      begin
        case ALUCtrl is
            when "000" => C <= std_logic_vector(signed(RD1) + signed(B));
            when "001" => C <= std_logic_vector(signed(RD1) - signed(B));
            when "101" => C <= std_logic_vector(shift_left(unsigned(B), to_integer(unsigned(sa))));
            when "110" => C <= std_logic_vector(shift_right(unsigned(B), to_integer(unsigned(sa))));
            when "010" => C <= RD1 and B;
            when "011" => C <= RD1 or B;
            when "100" => C <= RD1 xor B;
            when "111" => C <= (others => '0');
    if signed(RD1) < signed(B) then
        C(0) <= '1';
    end if;
            when others => C <= (others => '0');
            end case;
      
      end process;
      
      ALURes <= C;
    Zero <= '1' when C = X"00000000" else '0';
    GTZ <= '1' when signed(RD1) > 0 else '0';
    GEZ <= '1' when signed(RD1) >= 0 else '0';
    BranchAddress <= std_logic_vector(signed(PC4) + signed(Ext_Imm_Sh));
end Behavioral;
