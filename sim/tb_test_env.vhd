
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_test_env is
--  Port ( );
end tb_test_env;

architecture Behavioral of tb_test_env is

    signal clk : std_logic := '0';
    signal sw  : std_logic_vector(15 downto 0) := (others => '0');
    signal btn : std_logic_vector(4 downto 0) := (others => '0');
    signal led : std_logic_vector(15 downto 0);
    signal an  : std_logic_vector(7 downto 0);
    signal cat : std_logic_vector(6 downto 0);

    procedure press_button(signal b : out std_logic) is
    begin
        b <= '1';
        wait for 20 ns;
        b <= '0';
        wait for 80 ns;
    end procedure;

begin

    uut: entity work.test_env
    port map(
        clk => clk,
        sw  => sw,
        btn => btn,
        led => led,
        an  => an,
        cat => cat
    );

    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

        stim_proc: process
    begin
        -- RESET
        press_button(btn(1));
        wait for 100 ns;

        -- PAS 0: lw $1,4($0)
        sw(7 downto 5) <= "000"; wait for 100 ns; -- Instruction
        sw(7 downto 5) <= "001"; wait for 100 ns; -- PC+4
        sw(7 downto 5) <= "010"; wait for 100 ns; -- RD1
        sw(7 downto 5) <= "011"; wait for 100 ns; -- RD2
        sw(7 downto 5) <= "100"; wait for 100 ns; -- Ext_Imm
        sw(7 downto 5) <= "101"; wait for 100 ns; -- ALURes
        sw(7 downto 5) <= "110"; wait for 100 ns; -- MemData
        sw(7 downto 5) <= "111"; wait for 100 ns; -- BranchAddress
        press_button(btn(0));

        -- PAS 1: lw $2,0($0)
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 2: addi $4,$0,0
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 3: lw $3,0($1)
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 4: beq $3,$0,5
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 5: slt $5,$3,$2
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 6: beq $5,$0,1
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 7: addi $4,$4,1
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 8: addi $1,$1,4
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 9: j 3
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 10: lw $3,0($1)
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 11: beq $3,$0,5
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 12: slt $5,$3,$2
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 13: beq $5,$0,1
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 14: addi $1,$1,4
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 15: j 3
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 16: lw $3,0($1)
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 17: beq $3,$0,5
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 18: slt $5,$3,$2
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 19: beq $5,$0,1
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 20: addi $4,$4,1
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 21: addi $1,$1,4
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 22: j 3
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 23: lw $3,0($1)
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 24: beq $3,$0,5
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 25: slt $5,$3,$2
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 26: beq $5,$0,1
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 27: addi $1,$1,4
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 28: j 3
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 29: lw $3,0($1)
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 30: beq $3,$0,5
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
        press_button(btn(0));

        -- PAS 31: sw $4,8($0)
        sw(7 downto 5) <= "000"; wait for 100 ns;
        sw(7 downto 5) <= "001"; wait for 100 ns;
        sw(7 downto 5) <= "010"; wait for 100 ns;
        sw(7 downto 5) <= "011"; wait for 100 ns;
        sw(7 downto 5) <= "100"; wait for 100 ns;
        sw(7 downto 5) <= "101"; wait for 100 ns;
        sw(7 downto 5) <= "110"; wait for 100 ns;
        sw(7 downto 5) <= "111"; wait for 100 ns;
	
	press_button(btn(2)); -- enable MEM pentru sw
        wait for 100 ns;

        sw(7 downto 5) <= "110"; wait for 200 ns;


        wait;
    end process;

end Behavioral;