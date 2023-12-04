LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;

ENTITY IOPort IS
    PORT (
        RESET, OutW, InR : IN STD_LOGIC;
        Write_Data : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- Data to be written to the output port
        InData : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- Data from the input port
        Read_Data : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        Output_Port : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)); -- Data read from the input port
END IOPort;

ARCHITECTURE ArchIOPort OF IOPort IS
    SIGNAL INPort : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- SIGNAL OUTPort : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    PROCESS (RESET, OutW, InR, Write_Data, InData, INPort)
    BEGIN
        IF RESET = '1' THEN
            INPort <= (OTHERS => '0');
            Output_Port <= (OTHERS => '0');
            Read_Data <= (OTHERS => '0');
        ELSIF OutW = '1' THEN
            Output_Port <= Write_Data;
        ELSIF InR = '1'THEN
            Read_Data <= INPort;
        END IF;
        IF RESET = '0' THEN
            INPort <= InData;
        END IF;
    END PROCESS;
END ArchIOPort;