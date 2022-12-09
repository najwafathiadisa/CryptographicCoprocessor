library ieee;
use ieee.std_logic_1164.ALL;

entity tb_mini_proc IS
end tb_mini_proc;

architecture behavior OF tb_mini_proc IS 
    -- Component Declaration for the coprocessor
    component mini_proc
        port(
                clock : IN  std_logic;
                reset : IN  std_logic;
                CTRL : IN  std_logic_vector(3 downto 0);
                Ra : IN  std_logic_vector(3 downto 0);
                Rb : IN  std_logic_vector(3 downto 0);
                Rd : IN  std_logic_vector(3 downto 0);
                Val : OUT std_logic_vector(15 downto 0)
        );
    end component;

    --Inputs
    signal clock : std_logic;
    signal reset : std_logic;
    signal CTRL : std_logic_vector(3 downto 0);
    signal Ra : std_logic_vector(3 downto 0);
    signal Rb : std_logic_vector(3 downto 0);
    signal Rd : std_logic_vector(3 downto 0);
    --Outputs
    signal Val : std_logic_vector(15 downto 0);

    -- Clock period definitions
    constant clock_period : time := 100 ps;

begin
        uut: mini_proc port map (
            clock => clock,
            reset => reset,
            CTRL => CTRL,
            Ra => Ra,
            Rb => Rb,
            Rd => Rd,
            Val => Val
        );

        stim_proc: process
        begin  
            reset <= '1';-- Reset State
            Ra <= "0000";
            Rb <= "0000";
            Rd <= "0000";
            CTRL <= "0111";
            wait for clock_period; 
            reset <= '0';-- ADD R5,R4, R12
            Ra <= "0101";
            Rb <= "0100";
            Rd <= "1100";
            CTRL <= "0000";
            wait for clock_period;
            Ra <= "0001";-- XOR R1,R8,R7
            Rb <= "1000";
            Rd <= "0111";
            CTRL <= "0100";
            wait for clock_period;
            Ra <= "0001";-- ROR4 R12,R0
            Rb <= "1100";
            Rd <= "0000";
            CTRL <= "1001";
            wait for clock_period;    
            Ra <= "0001";-- SLL8 R9,R3
            Rb <= "1001";
            Rd <= "0011";
            CTRL <= "1010";
            wait for clock_period;
            Ra <= "0000";-- ADD R0,R7,R10
            Rb <= "0111";
            Rd <= "1010";
            CTRL <= "0000";
            wait for clock_period;
            Ra <= "0111";-- SUB R7,R3,R12
            Rb <= "0011";
            Rd <= "1100";
            CTRL <= "0001";
            wait for clock_period;
            Ra <= "1100";-- AND R12,R10,R9
            Rb <= "1010";
            Rd <= "1001";
            CTRL <= "0010";
            wait for clock_period;
            Ra <= "1001"; --- LUT R9,R2
            Rb <= "1010";
            Rd <= "0010";
            CTRL <= "1011";  
            wait;
    end process;
end;