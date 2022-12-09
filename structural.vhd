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
    --Alu Block
    ALU_unit: alu port map( 
        ABUS => A_BUS, 
        BBUS => B_BUS,
        ALUctrl => CTRL,
        ALUOUT => alu_out
    ); 
    
    --Shifter Block
    shifter_unit: shifter generic map (N => 16) -- shifter
        port map(
            SHIFTINPUT => B_BUS,
            SHIFT_Ctrl => CTRL,
            SHIFTOUT => shifter_out 
        ); 
    
    --Non Linear Lookup Hasher Block
    non_linear_lookup_unit1: non_linear_lookup
        port map( 
            LUTIN => A_BUS(7 downto 0), 
            LUTOUT => lut_out
        );
        hasher_out <= A_BUS(15 downto 8) & shifter_out;
    
    --Control Unit
    control_logic: process(CTRL, alu_out, hasher_out, shifter_out) begin
        case(CTRL(3 downto 3)) is
            when "0" => 
                RES <= alu_out;
            when others => 
                case(CTRL(1 downto 0)) is
                    when "11" =>
                        RES <= hasher_out;
                    when others =>
                        RES <= shifter_out;
                end case;
        end case;
    end process control_logic;
end Behavioral;