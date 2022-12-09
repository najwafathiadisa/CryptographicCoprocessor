library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity subtractor is
    generic ( 
        N: integer:=32
    );
    port (
        src1 : IN std_logic_vector (N-1 downto 0); -- First data source for the Subtractor
        src2 : IN std_logic_vector (N-1 downto 0); -- Second data source for the Subtractor
        res : OUT std_logic_vector (N-1 downto 0) -- The sub of both data source
    );
end entity subtractor;

architecture dataflow of subtractor is
begin
    res <= std_logic_vector(unsigned(src1) - unsigned(src2));
end architecture dataflow;