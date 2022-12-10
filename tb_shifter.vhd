library ieee;
use ieee.std_logic_1164.all;

entity tb_shifter is
end tb_shifter;

architecture behavior of tb_shifter is 

    -- Component Declaration for Shifter
    component shifter
    port(
        SHIFTINPUT : in  std_logic_vector(15 downto 0); --Value to be shifted
        SHIFT_Ctrl : in  std_logic_vector(3 downto 0); --Opcode of the operation
        SHIFTOUT : out  std_logic_vector(15 downto 0) --Shifted Value
    );
    end component;
    
    --Inputs
    signal SHIFTINPUT : std_logic_vector(15 downto 0) := (others => '0');
    signal SHIFT_Ctrl : std_logic_vector(3 downto 0) := (others => '0');
    --Outputs
    signal SHIFTOUT : std_logic_vector(15 downto 0);
    
begin
    -- Port Map the Shifter
    uut: shifter port map (
        SHIFTINPUT => SHIFTINPUT,
        SHIFT_Ctrl => SHIFT_Ctrl,
        SHIFTOUT => SHIFTOUT
    );
    
    tb: process
        constant period : time := 100 ns;
    begin  
        SHIFTINPUT <= x"d675";
        wait for period;

        SHIFT_Ctrl <= "1000";-- ROR8
        wait for period;
        assert (SHIFTOUT = "0111010111010110")
            report "Error at ROR8 Operation"
            severity Error;
        
        SHIFT_Ctrl <= "1001";-- ROR4
        wait for period; 
        assert (SHIFTOUT = "0101110101100111")
            report "Error at ROR4 Operation"
            severity Error;

        SHIFT_Ctrl <= "1010";-- SLL8
        wait for period;
        assert (SHIFTOUT = "0111010100000000")
            report "Error at SLL8 Operation"
            severity Error;

        wait;
    end process;
end;