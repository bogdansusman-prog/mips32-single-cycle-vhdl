----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2026 09:07:34 PM
-- Design Name: 
-- Module Name: test_env - Behavioral
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
--use IEEE.STD_LOGIC_unsigned.all; 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_env is
    Port ( clk : in std_logic;
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end test_env;

architecture Behavioral of test_env is
--semnale
 signal RegDst_s    : std_logic;
    signal ExtOp_s     : std_logic;
    signal ALUSrc_s    : std_logic;
    signal Branch_s    : std_logic;
    signal Jump_s      : std_logic;
    signal MemWrite_s  : std_logic;
    signal MemtoReg_s  : std_logic;
    signal RegWrite_s  : std_logic;
    signal B_GEZ_s     : std_logic;
    signal B_GTZ_s     : std_logic;
    signal ALUOp_s     : std_logic_vector(1 downto 0);

    signal RD1_s       : std_logic_vector(31 downto 0);
    signal RD2_s       : std_logic_vector(31 downto 0);
    signal Ext_Imm_s   : std_logic_vector(31 downto 0);
    signal func_s      : std_logic_vector(5 downto 0);
    signal sa_s        : std_logic_vector(4 downto 0);

    signal wd_s          : std_logic_vector(31 downto 0);
    signal en_ifetch     : std_logic;
    signal rst           : std_logic;
    signal instruction_s : std_logic_vector(31 downto 0);
    signal pcplus4_s     : std_logic_vector(31 downto 0);
    signal digits        : std_logic_vector(31 downto 0);
    
    signal Zero_s           : std_logic;
    signal GTZ_EX_s         : std_logic;
    signal GEZ_EX_s         : std_logic;
    signal ALURes_s         : std_logic_vector(31 downto 0);
    signal BranchAddress_s  : std_logic_vector(31 downto 0);
    signal PCSrc_s          : std_logic;
    
    signal MemData_s : std_logic_vector(31 downto 0);
    
    signal en_mem : std_logic;
    
    signal JumpAddress_s : std_logic_vector(31 downto 0);

begin

JumpAddress_s <= pcplus4_s(31 downto 28) & instruction_s(25 downto 0) & "00";
    mpg0 : entity work.MPG
    port map(
        enable => en_ifetch,
        btn    => btn(0),
        clk    => clk
    );

    mpg1 : entity work.MPG
    port map(
        enable => rst,
        btn    => btn(1),
        clk    => clk
    );
    
    mpg2 : entity work.MPG
    port map(
        enable => en_mem,
        btn    => btn(2), 
        clk    => clk
    );

    ifetch_unit : entity work.IFetch
    port map(
        CLK           => clk,
        RST           => rst,
        EN            => en_ifetch,
        Jump          => Jump_s,
        PCSrc         => PCSrc_s,
        JumpAddress => JumpAddress_s,
        BranchAddress => BranchAddress_s,
        Instruction   => instruction_s,
        PCPlus4       => pcplus4_s
        
    );

    uc_unit : entity work.UC
    port map(
        Instr     => instruction_s(31 downto 26),
        RegDst    => RegDst_s,
        ExtOp     => ExtOp_s,
        ALUSrc    => ALUSrc_s,
        Branch    => Branch_s,
        Jump      => Jump_s,
        MemWrite  => MemWrite_s,
        MemtoReg  => MemtoReg_s,
        RegWrite  => RegWrite_s,
        ALUOp     => ALUOp_s,
        B_GEZ     => B_GEZ_s,
        B_GTZ     => B_GTZ_s
    );

    wd_s <= MemData_s when MemtoReg_s = '1' else ALURes_s;

    id_unit : entity work.ID
    port map(
        clk      => clk,
        EN       => en_ifetch,
        Instr    => instruction_s(25 downto 0),
        RegWrite => RegWrite_s,
        RegDst   => RegDst_s,
        ExtOp    => ExtOp_s,
        WD       => wd_s,
        RD1      => RD1_s,
        RD2      => RD2_s,
        Ext_Imm  => Ext_Imm_s,
        func     => func_s,
        sa       => sa_s
    );

   process(sw, instruction_s, pcplus4_s, RD1_s, RD2_s, Ext_Imm_s, ALURes_s, MemData_s, BranchAddress_s)
begin
    case sw(7 downto 5) is
        when "000" => digits <= instruction_s;
        when "001" => digits <= pcplus4_s;
        when "010" => digits <= RD1_s;
        when "011" => digits <= RD2_s;
        when "100" => digits <= Ext_Imm_s;
        when "101" => digits <= ALURes_s;
        when "110" => digits <= MemData_s;
        when "111" => digits <= BranchAddress_s;
        when others => digits <= X"00000000";

    end case;
end process;

    ssd1 : entity work.SSD
    port map(
        clk    => clk,
        digits => digits,
        an     => an,
        cat    => cat
    );

        PCSrc_s <= (Branch_s and Zero_s) or
           (B_GEZ_s and GEZ_EX_s) or
           (B_GTZ_s and GTZ_EX_s);
        ex_unit : entity work.EX
    port map(
        RD1           => RD1_s,
        RD2           => RD2_s,
        ALUSrc        => ALUSrc_s,
        Ext_Imm       => Ext_Imm_s,
        sa            => sa_s,
        func          => func_s,
        ALUOp         => ALUOp_s,
        PC4           => pcplus4_s,
        Zero          => Zero_s,
        GTZ           => GTZ_EX_s,
        GEZ           => GEZ_EX_s,
        ALURes        => ALURes_s,
        BranchAddress => BranchAddress_s
    );


    mem_unit : entity work.MEM
port map(
    clk      => clk,
    en => en_mem,
    MemWrite => MemWrite_s,
    ALURes   => ALURes_s,
    RD2      => RD2_s,
    MemData  => MemData_s
);

led(0) <= RegWrite_s;
led(1) <= MemtoReg_s;
led(2) <= MemWrite_s;
led(3) <= Jump_s;
led(4) <= Branch_s;
led(5) <= ALUSrc_s;
led(6) <= ExtOp_s;
led(7) <= RegDst_s;
led(9 downto 8) <= ALUOp_s;
led(10) <= B_GEZ_s;
led(11) <= B_GTZ_s;
led(12) <= Zero_s;
led(13) <= GEZ_EX_s;
led(14) <= GTZ_EX_s;
led(15) <= PCSrc_s;

end Behavioral;

