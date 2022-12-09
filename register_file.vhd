library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity register_file is
    port ( 
        CLK, RST: in std_logic; -- clock and reset
        RdEn: in std_logic; -- write enable to Rd
        RES : in std_logic_vector(15 downto 0); -- write value
        Ra,Rb,Rd: in std_logic_vector(3 downto 0); -- Ra, Rb: Source Registers, Rd: Destination Register
        SRCa,SRCb: out std_logic_vector(15 downto 0) -- read value
    );
end register_file;

architecture Behavioral of register_file is

    type mem_type is array(0 to 15) of std_logic_vector(15 downto 0);
    signal REG_FILE: mem_type :=( -- customizable memory initialization
        0 => x"0000", -- All of them could be any value
        1 => x"0001",
        2 => x"0020",
        3 => x"0300",
        4 => x"4000",
        5 => x"0005",
        6 => x"0060",
        7 => x"0700",
        8 => x"8000",
        9 => x"0009",
        10 => x"00a0",
        11 => x"0b00",
        12 => x"c000",
        13 => x"000d",
        14 => x"00e0",
        15 => x"0f00",
        others => (others => '0')
    );

begin

    --Write
    write_operation: process(CLK) 
    begin
        if(rising_edge(CLK)) then
            if(RdEn='1') then -- Write when RdWEn = '1'
                REG_FILE(to_integer(unsigned(Rd))) <= RES;
            end if;
        end if;
    end process;

    --Read
    read_operation: process(CLK)
    begin
        if(rising_edge(CLK)) then
            if(RST='1') then
                SRCa <= x"0000"; -- Zero filled
                SRCb <= x"0000"; -- Zero filled
            else
                SRCa <= REG_FILE(to_integer(unsigned(Ra)));
                SRCb <= REG_FILE(to_integer(unsigned(Rb)));
            end if;
        end if;
    end process;
end Behavioral;