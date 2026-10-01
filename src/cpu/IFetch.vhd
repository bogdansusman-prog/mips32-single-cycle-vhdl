----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2026 06:21:57 PM
-- Design Name: 
-- Module Name: IFetch - Behavioral
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
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IFetch is
      Port (
        CLK           : in  STD_LOGIC;
        RST           : in  STD_LOGIC;
        EN            : in  STD_LOGIC;
        Jump          : in  STD_LOGIC;
        PCSrc         : in  STD_LOGIC;
        JumpAddress   : in  STD_LOGIC_VECTOR(31 downto 0);
        BranchAddress : in  STD_LOGIC_VECTOR(31 downto 0);
        Instruction   : out STD_LOGIC_VECTOR(31 downto 0);
        PCPlus4       : out STD_LOGIC_VECTOR(31 downto 0)
    );
end IFetch;

architecture Behavioral of IFetch is
type rom_type is array(0 to 31) of std_logic_vector(31 downto 0);
signal ROM : rom_type := (

-- 0xF8010004 | lw $1, 4($0) | $1 = MEM[$0 + 4] = A
0  => "11111000000000010000000000000100",

-- 0xF8020000 | lw $2, 0($0) | $2 = MEM[$0 + 0] = X
1  => "11111000000000100000000000000000",

-- 0xFC040000 | addi $4, $0, 0 | $4 = $0 + 0 = 0, count = 0
2  => "11111100000001000000000000000000",

-- 0xF8230000 | lw $3, 0($1) | $3 = MEM[$1 + 0] = MEM[A], valoarea curenta
3  => "11111000001000110000000000000000",

-- 0xF0600005 | beq $3, $0, 5 | daca $3 == $0, sare la pozitia 10: sw $4, 8($0)
-- calcul offset: 10 - (4 + 1) = 5
4  => "11110000011000000000000000000101",

-- 0x0062282A | slt $5, $3, $2 | $5 = 1 daca $3 < $2, altfel $5 = 0
5  => "00000000011000100010100000101010",

-- 0xF0A00001 | beq $5, $0, 1 | daca $5 == $0, sare la pozitia 8: addi $1, $1, 4
-- calcul offset: 8 - (6 + 1) = 1
6  => "11110000101000000000000000000001",

-- 0xFC840001 | addi $4, $4, 1 | $4 = $4 + 1, count++
7  => "11111100100001000000000000000001",

-- 0xFC210004 | addi $1, $1, 4 | $1 = $1 + 4, trece la urmatoarea adresa
8  => "11111100001000010000000000000100",

-- 0xE4000003 | j 3 | sare la pozitia 3: lw $3, 0($1)
9  => "11100100000000000000000000000011",

-- 0xF4040008 | sw $4, 8($0) | MEM[$0 + 8] = $4, scrie rezultatul la adresa 8
10 => "11110100000001000000000000001000",

others => "00000000000000000000000000100000"
);
signal PC : std_logic_vector(31 downto 0) := (others => '0');
signal PC_next : std_logic_vector(31 downto 0);
signal PC_plus_4_int : std_logic_vector(31 downto 0);
signal branch_mux : std_logic_vector(31 downto 0);

begin

--PC + 4
PC_plus_4_int <= STD_LOGIC_VECTOR(PC + 4);
    PCPlus4       <= PC_plus_4_int;
    
    branch_mux <= BranchAddress when PCSrc = '1' else PC_plus_4_int;
    PC_next <= JumpAddress when Jump = '1' else branch_mux;


    process(CLK, RST)
    begin
        if RST = '1' then
            PC <= (others => '0');
        elsif rising_edge(CLK) then
            if EN = '1' then
                PC <= PC_next;
                end if;
            end if;
    end process;

Instruction <= ROM(conv_integer(PC(6 downto 2)));

end Behavioral;
