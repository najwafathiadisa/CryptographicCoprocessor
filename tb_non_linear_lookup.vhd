library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity tb_non_linear_lookup is
end tb_non_linear_lookup;

architecture behavior of tb_non_linear_lookup is 

    -- Component Declaration for Lookup Table Implementation in VHDL
    component non_linear_lookup
    port(
        LUTIN : in  std_logic_vector(7 downto 0); --Value to be hashed
        LUTOUT : out  std_logic_vector(7 downto 0) --Hashed value
        );
    end component;

    --Inputs
    signal LUTIN : std_logic_vector(7 downto 0) := (others => '0');
    --Outputs
    signal LUTOUT : std_logic_vector(7 downto 0);
    signal i: integer; --Counter Value
    
begin
    -- Instantiate the Lookup Table Implementation
    uut: non_linear_lookup PORT MAP (
        LUTIN => LUTIN,
        LUTOUT => LUTOUT
    );

    testbench_proc: process
    begin  
        LUTIN <= x"00";
        wait for 100 ns;
        assert (LUTOUT = "10101001")
                report "Error at x00 Operation"
                severity Error;
        
        LUTIN <= x"01";
        wait for 100 ns;
        assert (LUTOUT = "10101101")
                report "Error at x01 Operation"
                severity Error;
            
        LUTIN <= x"12";
        wait for 100 ns;
        assert (LUTOUT = "01110000")
                report "Error at x12 Operation"
                severity Error;

        LUTIN <= x"23";
        wait for 100 ns;
        assert (LUTOUT = "11010001")
                report "Error at x23 Operation"
                severity Error;
        
        LUTIN <= x"34";
        wait for 100 ns;
        assert (LUTOUT = "10010011")
                report "Error at x34 Operation"
                severity Error;

        wait;
    end process;
end;