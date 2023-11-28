library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;   
use std.textio.all;
use ieee.std_logic_textio.all;

ENTITY IOPort IS
    PORT (CLK: IN STD_LOGIC;
          RESET, OutW, InR: IN STD_LOGIC;
          Write_Data: IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- Data to be written to the output port
          InData: IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- Data from the input port
          Read_Data: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)); -- Data read from the input port
END IOPort;

ARCHITECTURE ArchIOPort OF IOPort IS
    SIGNAL INPort : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL OUTPort : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    PROCESS (CLK, RESET, InData)
    BEGIN
        IF RESET = '1' THEN
            INPort <= (OTHERS => '0');
            OUTPort <= (OTHERS => '0');
            Read_Data <= (OTHERS => '0');
        ELSIF RISING_EDGE(CLK) THEN
            IF OutW = '1' THEN
                OUTPort <= Write_Data;
            END IF;
            IF InR = '1'THEN
                Read_Data <= INPort;
            END IF;    
        END IF;
        IF RESET = '0' THEN
            INPort <= InData;
        END IF;
    END PROCESS; 
END ArchIOPort;