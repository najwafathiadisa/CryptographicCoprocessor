library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- 16-bit ALU 
entity alu is
    port (
        ABUS: in std_logic_vector(15 downto 0); -- First data source for the ALU
        BBUS: in std_logic_vector(15 downto 0); -- Second data source for the ALU
        ALUctrl: in std_logic_vector(3 downto 0); -- Opcode of the operation
        ALUOUT: out std_logic_vector(15 downto 0)  -- Data output from the ALU 
    );
end alu;

architecture Behavioral of alu is
    -- N-bit Adder 
    component adder is
        generic (
                N: integer:=32
        );
        port( 
            src1: in std_logic_vector(N-1 downto 0); -- First data source for the Adder
            src2: in std_logic_vector(N-1 downto 0); -- Second data source for the Adder
            res: out std_logic_vector(N-1 downto 0) -- The sum of both data source
        );
    end component adder;
    -- N-bit Subtractor
    component subtractor is
        generic (
                N: integer:=32
        );
        port( 
            src1: in std_logic_vector(N-1 downto 0); -- First data source for the Subtractor
            src2: in std_logic_vector(N-1 downto 0); -- Second data source for the Subtractor
            res: out std_logic_vector(N-1 downto 0) -- The sub of both data source
        );
    end component subtractor;

    signal add_out: std_logic_vector(16-1 downto 0); -- To hold the output of the N bit adder
    signal sub_out: std_logic_vector(16-1 downto 0); -- To hold the output of the N bit subtractor

begin
    -- ABUS + BBUS
    N_bit_adder: adder 
        generic map ( 
            N => 16    
        )
        port map(
            src1 => ABUS, 
            src2 => BBUS, 
            res => add_out 
        ); 
    
    -- ABUS - BBUS
    N_bit_subtractor: subtractor 
        generic map (
            N => 16     
        ) 
        port map(
            src1 => ABUS,
            src2 => BBUS,
            res => sub_out 
        ); 

-- Another ALU instructions
    process(ALUctrl,ABUS,BBUS,add_out,sub_out)
    begin 
        case(ALUctrl) is
            when "0000" =>  ALUOUT <= add_out;  -- ADD
            when "0001" =>  ALUOUT <= sub_out ;-- SUB 
            when "0010" =>  ALUOUT <= ABUS and BBUS; -- AND
            when "0011" =>  ALUOUT <= ABUS or BBUS; -- OR
            when "0100" =>  ALUOUT <= ABUS xor BBUS; -- XOR
            when "0101" =>  ALUOUT <= not ABUS; -- NOT
            when "0110" =>  ALUOUT <= ABUS; -- MOVE
            when others => ALUOUT <= add_out; -- DEFAULT
        end case;
    end process;
end Behavioral;