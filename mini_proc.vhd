library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mini_proc is
    port ( 
        CLK, RST: in std_logic; -- clock and reset
        CTRL: in std_logic_vector(3 downto 0); -- Opcode
        Ra, Rb, Rd: in std_logic_vector(3 downto 0); -- Ra, Rb: Source Registers, Rd: Destination Register
        VAL : out std_logic_vector(15 downto 0) -- Result value of computation
    );
end mini_proc;

architecture Behavioral of mini_proc is
    -- Register file
    component register_file is
        port ( 
            CLK: in std_logic;
            RST: in std_logic;
            RdEn: in std_logic; 
            RES : in std_logic_vector(15 downto 0); -- write value
            Ra,Rb,Rd: in std_logic_vector(3 downto 0); -- selected value of Registers Ra, Rb, Rd
            SRCa,SRCb: out std_logic_vector(15 downto 0) -- read value
        );
    end component register_file;

    -- Structural Block
    component structural is
        port ( 
            A_BUS: in std_logic_vector(15 downto 0);
            B_BUS: in std_logic_vector(15 downto 0);
            CTRL: in std_logic_vector(3 downto 0);
            RES: out std_logic_vector(15 downto 0)
        );
    end component structural;

    -- The three states for the FSM
    type states is (ST0, ST1, ST2); 
    signal PS, NS: states;

    signal WrEn: std_logic; --Write Enable
    signal data1,data2,data3:std_logic_vector(15 downto 0); --2 source input and 1 data output
    signal CTRL_tmp: std_logic_vector(3 downto 0); --Signal to hold the CTRL value
    signal Rd_tmp: std_logic_vector(3 downto 0); --Signal to hold the Rd value
    signal RstCtrl: std_logic; --Signal that determine if RST = 1 and CTRL = 0111

begin

end Behavioral;