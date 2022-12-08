library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity structural is
    port ( 
        A_BUS: in std_logic_vector(15 downto 0); --Source Data 1
        B_BUS: in std_logic_vector(15 downto 0); --Source Data 2
        CTRL: in std_logic_vector(3 downto 0); --Opcode Input
        RES: out std_logic_vector(15 downto 0) --Output Data
    );
end structural;

architecture Behavioral of structural is
    --Non Linear Lookup Hasher Block
    component non_linear_lookup is
        port ( 
            LUTIN: in std_logic_vector(7 downto 0);
            LUTOUT: out std_logic_vector(7 downto 0)
        );
    end component non_linear_lookup;

    --Shifter Block
    component shifter is
        generic ( 
            N: integer:=16
        );
        Port (  
            SHIFTINPUT : in  STD_LOGIC_VECTOR(N-1 downto 0);
            SHIFT_Ctrl : in  STD_LOGIC_VECTOR(3 downto 0); 
            SHIFTOUT: out  STD_LOGIC_VECTOR(N-1 downto 0)
        );
    end component shifter;

    --Alu Block
    component alu is
        port (
            ABUS: in std_logic_vector(15 downto 0);
            BBUS: in std_logic_vector(15 downto 0);
            ALUctrl: in std_logic_vector(3 downto 0);
            ALUOUT: out std_logic_vector(15 downto 0)
        );
    end component alu;

    signal alu_out, shifter_out, hasher_out: std_logic_vector(15 downto 0);
    signal lut_out: std_logic_vector(7 downto 0);

begin

end Behavioral;