----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2026 01:56:08 PM
-- Design Name: 
-- Module Name: SSD - Behavioral
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
use IEEE.std_logic_unsigned .ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SSD is
    Port ( clk : in STD_LOGIC;
           digits : in STD_LOGIC_VECTOR (31 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end SSD;

architecture Behavioral of SSD is
    signal cnt          : std_logic_vector(16 downto 0) := (others => '0');
    signal sel          : std_logic_vector(2 downto 0);
    signal hex_digit    : std_logic_vector(3 downto 0);
begin

    process(clk)
    begin
        if rising_edge(clk) then
            cnt <= cnt+1;
        end if;
    end process;
    
    
    sel <= std_logic_vector(cnt(16 downto 14));
    --sel <= std_logic_vector(cnt(2 downto 0));
    
    process(sel, digits)
    begin
        case sel is
            when "000" =>
                an <= "11111110";
                hex_digit <= digits(3 downto 0);
            when "001" =>
                an <= "11111101";
                hex_digit <= digits(7 downto 4);
            when "010" =>
                an <= "11111011";
                hex_digit <= digits(11 downto 8);
            when "011" =>
                an <= "11110111";
                hex_digit <= digits(15 downto 12);
            when "100" =>
                an <= "11101111";
                hex_digit <= digits(19 downto 16);
            when "101" =>
                an <= "11011111";
                hex_digit <= digits(23 downto 20);
            when "110" =>
                an <= "10111111";
                hex_digit <= digits(27 downto 24);
            when others =>
                an <= "01111111";
                hex_digit <= digits(31 downto 28);
        end case;
    end process;
    

    process(hex_digit)
    begin
        case hex_digit is
            when "0000" => cat <= "1000000"; -- 0
            when "0001" => cat <= "1111001"; -- 1
            when "0010" => cat <= "0100100"; -- 2
            when "0011" => cat <= "0110000"; -- 3
            when "0100" => cat <= "0011001"; -- 4
            when "0101" => cat <= "0010010"; -- 5
            when "0110" => cat <= "0000010"; -- 6
            when "0111" => cat <= "1111000"; -- 7
            when "1000" => cat <= "0000000"; -- 8
            when "1001" => cat <= "0010000"; -- 9
            when "1010" => cat <= "0001000"; -- A
            when "1011" => cat <= "0000011"; -- b
            when "1100" => cat <= "1000110"; -- C
            when "1101" => cat <= "0100001"; -- d
            when "1110" => cat <= "0000110"; -- E
            when others => cat <= "0001110"; -- F
        end case;
    end process;
end Behavioral;
