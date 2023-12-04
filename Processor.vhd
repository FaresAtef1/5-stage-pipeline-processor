LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;

ENTITY Processor IS
    PORT (
        CLK, RST , INT, Init: IN STD_LOGIC;
        In_Inst : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        PC_Init : IN STD_LOGIC;
        Write_Data : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
END Processor;

ARCHITECTURE ArchProcessor OF Processor IS
BEGIN
    PROCESS (CLK)
    BEGIN
        
    END PROCESS;
END ArchProcessor;