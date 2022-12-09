library ieee;
use ieee.std_logic_1164.ALL;
use IEEE.std_logic_unsigned.all;
-- Testbench 

entity tb_alu IS
end tb_alu;

architecture behavior OF tb_alu IS 

    -- Component Declaration for the 16-bit ALU
    component alu
        port(
            ABUS : IN  std_logic_vector(15 downto 0); -- First data source for the ALU
            BBUS : IN  std_logic_vector(15 downto 0); -- Second data source for the ALU
            ALUctrl : IN  std_logic_vector(3 downto 0); -- Opcode of the operation
            ALUOUT : OUT  std_logic_vector(15 downto 0) -- Data output from the ALU 
        );
    end component;

    --Inputs
    signal ABUS : std_logic_vector(15 downto 0) := (others => '0');
    signal BBUS : std_logic_vector(15 downto 0) := (others => '0');
    signal ALUctrl : std_logic_vector(3 downto 0) := (others => '0');

    --Outputs
    signal ALUOUT : std_logic_vector(15 downto 0);
    
BEGIN
    -- Instantiate the 16-bit ALU 
    uut: ALU PORT MAP (
            ABUS => ABUS,
            BBUS => BBUS,
            ALUctrl => ALUctrl,
            ALUOUT => ALUOUT
    );
    
    testbench_proc: process
    begin  
        ABUS <= x"1d4b";
        BBUS <= x"85b2";

        ALUctrl <= "0000";
        wait for 100 ns;
        assert (ALUOUT = "1010001011111101")
                report "Error at 0 Operation"
                severity Error;
        
        ALUctrl <= "0001";
        wait for 100 ns;
        assert (ALUOUT = "1001011110011001")
                report "Error at 1 Operation"
                severity Error;
        
        ALUctrl <= "0010";
        wait for 100 ns;
        assert (ALUOUT = "0000010100000010")
                report "Error at 2 Operation"
                severity Error;

        ALUctrl <= "0011";
        wait for 100 ns;
        assert (ALUOUT = "1001110111111011")
                report "Error at 3 Operation"
                severity Error;

        ALUctrl <= "0100";
        wait for 100 ns;
        assert (ALUOUT = "1001100011111001")
                report "Error at 4 Operation"
                severity Error;

        ALUctrl <= "0101";
        wait for 100 ns;
        assert (ALUOUT = "1110001010110100")
                report "Error at 5 Operation"
                severity Error;

        ALUctrl <= "0110";
        wait for 100 ns;
        assert (ALUOUT = "0001110101001011")
                report "Error at 6 Operation"
                severity Error;

        wait;
    end process;
END;