library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- 16-bit ALU 
entity alu is
    port (
        ABUS: in std_logic_vector(15 downto 0); -- ABUS data input of the 16-bit ALU
        BBUS: in std_logic_vector(15 downto 0); -- BBUS data input of the 16-bit ALU
        ALUctrl: in std_logic_vector(3 downto 0); -- ALUctrl control input of the 16-bit ALU 
        ALUOUT: out std_logic_vector(15 downto 0)  -- 16-bit data output of the 16-bit ALU 
    );
end alu;

architecture Behavioral of alu is
    -- N-bit Adder 
    component adder is
        generic (
                N: integer:=32
        );
        port( 
            src1: in std_logic_vector(N-1 downto 0);
            src2: in std_logic_vector(N-1 downto 0);
            res: out std_logic_vector(N-1 downto 0)
        );
    end component adder;
    -- N-bit Subtractor
    component subtractor is
        generic (
                N: integer:=32
        );
        port( 
            src1: in std_logic_vector(N-1 downto 0);
            src2: in std_logic_vector(N-1 downto 0);
            res: out std_logic_vector(N-1 downto 0)
        );
    end component subtractor;

    signal tmp_out1: std_logic_vector(16-1 downto 0);
    signal tmp_out2: std_logic_vector(16-1 downto 0);
    signal tmp: std_logic_vector(16-1 downto 0);

begin
    
end Behavioral;