library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity non_linear_lookup is
    port (  
        LUTIN: in std_logic_vector(7 downto 0); --Value to be hashed
        LUTOUT: out std_logic_vector(7 downto 0) --Hashed value
    );
end non_linear_lookup;

architecture Behavioral of non_linear_lookup is
    signal MSB_in,LSB_in,MSB_out,LSB_out: std_logic_vector(3 downto 0); --Signal to hold the i/o value

begin
    --The input split into 2 of 4bit binary and hashed independently
    MSB_in <= LUTIN(7 downto 4);
    LSB_in <= LUTIN(3 downto 0);

    LUT_1: process(MSB_in) begin
        case(MSB_in) is
            when "0000" => MSB_out <= "1010";
            when "0001" => MSB_out <= "0111";
            when "0010" => MSB_out <= "1101";
            when "0011" => MSB_out <= "1001";
            when "0100" => MSB_out <= "1100";
            when "0101" => MSB_out <= "0101";
            when "0110" => MSB_out <= "0000";
            when "0111" => MSB_out <= "1111";
            when "1000" => MSB_out <= "0100";
            when "1001" => MSB_out <= "0110";
            when "1010" => MSB_out <= "0001";
            when "1011" => MSB_out <= "1011";
            when "1100" => MSB_out <= "0010";
            when "1101" => MSB_out <= "0011";
            when "1110" => MSB_out <= "1110";
            when "1111" => MSB_out <= "1000";
            when others => MSB_out <= "0000";
        end case;
    end process;

    LUT_2: process(LSB_in) begin
        case(LSB_in) is
            when "0000" => LSB_out <= "1001";
            when "0001" => LSB_out <= "1101";
            when "0010" => LSB_out <= "0000";
            when "0011" => LSB_out <= "0001";
            when "0100" => LSB_out <= "0011";
            when "0101" => LSB_out <= "1110";
            when "0110" => LSB_out <= "1111";
            when "0111" => LSB_out <= "1010";
            when "1000" => LSB_out <= "1100";
            when "1001" => LSB_out <= "1011";
            when "1010" => LSB_out <= "0100";
            when "1011" => LSB_out <= "0110";
            when "1100" => LSB_out <= "0111";
            when "1101" => LSB_out <= "1000";
            when "1110" => LSB_out <= "0010";
            when "1111" => LSB_out <= "0101";
            when others => LSB_out <= "0000";
        end case;
    end process;

    LUTOUT <= MSB_out & LSB_out; --Stick both the MSN and LSN part of the input
end Behavioral;