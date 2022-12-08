library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity non_linear_lookup is
    port (  
        LUTIN: in std_logic_vector(7 downto 0); --Look Up Table IN
        LUTOUT: out std_logic_vector(7 downto 0) --Look Up Table OUT
    );
end non_linear_lookup;

architecture Behavioral of non_linear_lookup is
    signal MSB_in,LSB_in,MSB_out,LSB_out: std_logic_vector(3 downto 0); --Signal to hold the i/o value

begin

end Behavioral;