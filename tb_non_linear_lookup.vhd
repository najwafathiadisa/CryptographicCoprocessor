library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity tb_lookuptable is
end tb_lookuptable;

architecture behavior of tb_lookuptable is 

    -- Component Declaration for Lookup Table Implementation in VHDL
    component non_linear_lookup
    port(
        LUTIN : in  std_logic_vector(7 downto 0);
        LUTOUT : out  std_logic_vector(7 downto 0)
        );
    end component;

    --Inputs
    signal LUTIN : std_logic_vector(7 downto 0) := (others => '0');

    --Outputs
    signal LUTOUT : std_logic_vector(7 downto 0);
    signal i: integer;
    
begin
    -- Instantiate the Lookup Table Implementation
    uut: non_linear_lookup PORT MAP (
        LUTIN => LUTIN,
        LUTOUT => LUTOUT
    );

    stim_proc: process
    begin  
        LUTIN <= x"00";
        -- initialize 4-bit input data in VHDL testbench
        for i in 0 to 15 loop
            LUTIN <= std_logic_vector(to_unsigned(i, 8));
            wait for 100 ns; 
        end loop;
        wait;
    end process;
end;