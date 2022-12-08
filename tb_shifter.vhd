library ieee;
use ieee.std_logic_1164.all;

entity tb_shifter is
end tb_shifter;

architecture behavior of tb_shifter is 

    -- Component Declaration for Shifter
    component shifter
    port(
        SHIFTINPUT : in  std_logic_vector(15 downto 0);
        SHIFT_Ctrl : in  std_logic_vector(3 downto 0);
        SHIFTOUT : out  std_logic_vector(15 downto 0)
    );
    end component;
    
    --Inputs
    signal SHIFTINPUT : std_logic_vector(15 downto 0) := (others => '0');
    signal SHIFT_Ctrl : std_logic_vector(3 downto 0) := (others => '0');
    --Outputs
    signal SHIFTOUT : std_logic_vector(15 downto 0);
    
begin
    -- Instantiate the Shifter
    uut: shifter port map (
        SHIFTINPUT => SHIFTINPUT,
        SHIFT_Ctrl => SHIFT_Ctrl,
        SHIFTOUT => SHIFTOUT
    );
    -- Stimulus process for shifter
    stim_proc: process
    begin  
        SHIFTINPUT <= x"0044";
        wait for 100 ns; 
        SHIFT_Ctrl <= "1000";-- ROR8
        wait for 100 ns; 
        SHIFT_Ctrl <= "1001";-- ROR4
        wait for 100 ns; 
        SHIFT_Ctrl <= "1010";-- SLL8
        wait;
    end process;
end;