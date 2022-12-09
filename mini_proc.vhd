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
    -- 16 bit Register
    Register_Block: register_file port map(
        CLK => CLK, RST => RST,
        RdEn => WrEn, RES => data3, Ra => Ra, Rb => Rb, Rd => Rd_tmp,
        SRCa => data1, SRCb => data2
    );

    -- Structural Block
    Structural_Block: structural port map( 
        A_BUS => data1, B_BUS => data2, CTRL => CTRL_tmp,
        RES => data3
    );

    sync_proc : process(CLK)
    begin
        if (rising_edge(CLK)) then PS <= NS;
        end if;
    end process;

    comb_proc : process(PS, RST, RstCtrl, CTRL)
    begin
        if (RST = '1' AND CTRL = "0111") then
            RstCtrl <= '1';
        else
            RstCtrl <= '0';
        end if;

        case PS is
        when ST0 => 
            if (RstCtrl = '1') then
                NS <= ST2;
                CTRL_tmp <= x"0";
                Rd_tmp <= x"0";
                WrEn <= '0';
            else
                NS <= ST1;
                CTRL_tmp <= CTRL;
                Rd_tmp <= Rd;
                WrEn <= '1';
            end if;
        when others =>
            NS <= ST0;
        end case;
    end process;      
    VAL <= data3;         
end Behavioral;