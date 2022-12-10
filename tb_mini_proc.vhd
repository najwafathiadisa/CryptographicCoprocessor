library ieee;
use ieee.std_logic_1164.ALL;

entity tb_mini_proc IS
end tb_mini_proc;

architecture behavior OF tb_mini_proc IS 
    -- Component Declaration for the coprocessor
    component mini_proc
        port(
            --Inputs
            CLK, RST : IN  std_logic; -- clock and reset
            CTRL, Ra, Rb, Rd : IN  std_logic_vector(3 downto 0); -- CTRL: Opcode; Ra, Rb: Source Registers; Rd: Destination Register 
            --Output
            VAL : OUT std_logic_vector(15 downto 0) -- Result value of computation
        );
    end component;

    --Inputs
    signal CLK, RST : std_logic := '0';
    signal CTRL, Ra, Rb, Rd : std_logic_vector(3 downto 0) := (others => '0');
    --Output
    signal VAL : std_logic_vector(15 downto 0);

    -- Clock period definitions
    constant clock_period : time := 100 ps;
    constant clock_half_period : time := 50 ps;

begin
        uut: mini_proc port map (
            CLK => CLK,
            RST => RST,
            CTRL => CTRL,
            Ra => Ra,
            Rb => Rb,
            Rd => Rd,
            VAL => VAL
        );

        testbench_proc: process
        begin  

            RST <= '0'; -- Set State
            CTRL <= "0000";-- ADD
            Ra <= "0111"; -- R7
            Rb <= "1011"; -- R11
            Rd <= "0111"; -- R7
            wait for clock_period;
            wait for clock_half_period;
            assert (VAL = "0001001000000000")
                report "Error at ADD Operation"
                severity Error;
            wait for clock_half_period;

            CTRL <= "0001";-- SUB
            Ra <= "0111"; -- R7
            Rb <= "1110"; -- R14
            Rd <= "0111"; -- R7
            wait for clock_period;
            wait for clock_half_period;
            assert (VAL = "0001000100100000")
                report "Error at SUB Operation"
                severity Error;
            wait for clock_half_period;

            CTRL <= "0010";-- AND
            Ra <= "0111"; -- R7
            Rb <= "1100"; -- R12
            Rd <= "0111"; -- R7
            wait for clock_period;
            wait for clock_half_period;
            assert (VAL = "0000000000000000")
                report "Error at AND Operation"
                severity Error;
            wait for clock_half_period;

            CTRL <= "0011";-- OR
            Ra <= "0111"; -- R7
            Rb <= "1010"; -- R10
            Rd <= "0111"; -- R7
            wait for clock_period;
            wait for clock_half_period;
            assert (VAL = "0000000010100000")
                report "Error at OR Operation"
                severity Error;
            wait for clock_half_period;

            CTRL <= "0100";-- XOR
            Ra <= "0111"; -- R7
            Rb <= "0011"; -- R3
            Rd <= "0111"; -- R7
            wait for clock_period;
            wait for clock_half_period;
            assert (VAL = "0000001110100000")
                report "Error at XOR Operation"
                severity Error;
            wait for clock_half_period;

            CTRL <= "0101";-- NOT
            Ra <= "0111"; -- R7
            wait for clock_period;
            wait for clock_half_period;
            assert (VAL = "1111110001011111")
                report "Error at NOT Operation"
                severity Error;
            wait for clock_half_period;

            CTRL <= "0110";-- MOVE
            Ra <= "0111"; -- R7
            Rd <= "1011"; -- R11
            wait for clock_period;
            wait for clock_half_period;
            assert (VAL = "1111110001011111")
                report "Error at MOVE Operation"
                severity Error;
            wait for clock_half_period;

            CTRL <= "1000"; --ROR8
            Rb <= "1011"; --R11
            Rd <= "1011"; --R11
            wait for clock_period;
            wait for clock_half_period;
            assert (VAL = "0101111111111100")
                report "Error at ROR8 Operation"
                severity Error;
            wait for clock_half_period;

            CTRL <= "1001"; --ROR4
            Rb <= "1011"; --R11
            Rd <= "1011"; --R11
            wait for clock_period;
            wait for clock_half_period;
            assert (VAL = "1100010111111111")
                report "Error at ROR4 Operation"
                severity Error;
            wait for clock_half_period;

            CTRL <= "1010"; --SLL8
            Rb <= "1011"; --R11
            Rd <= "1011"; --R11
            wait for clock_period;
            wait for clock_half_period;
            assert (VAL = "1111111100000000")
                report "Error at SLL8 Operation"
                severity Error;
            wait for clock_half_period;

            CTRL <= "1011";  --LUT
            Ra <= "1011"; --R11
            Rd <= "1011"; --R11
            wait for clock_period;
            wait for clock_half_period;
            assert (VAL = "1111111110101001")
                report "Error at LUT Operation"
                severity Error;
            wait for clock_half_period;
            wait;
    end process;
end;