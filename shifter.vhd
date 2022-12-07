library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shifter is
    generic ( 
        N: integer:=16
    );
    Port ( 
        SHIFTINPUT : in  STD_LOGIC_VECTOR(N-1 downto 0);
        SHIFT_Ctrl : in  STD_LOGIC_VECTOR(3 downto 0); 
        SHIFTOUT: out  STD_LOGIC_VECTOR(N-1 downto 0)
    );
end shifter;

architecture Behavioral of shifter is
begin

end Behavioral;