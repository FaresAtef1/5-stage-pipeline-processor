LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;

ENTITY WriteBackStage IS
    PORT (
        Mem_Out, ALU_Res, Port_Out : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        IOR, Mem_2Reg : IN STD_LOGIC;
        Write_Data : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
END WriteBackStage;

ARCHITECTURE ArchWriteBackStage OF WriteBackStage IS
BEGIN
    PROCESS (Mem_Out, ALU_Res, Port_Out, IOR, Mem_2Reg)
    BEGIN
        IF (IOR = '1') THEN
            Write_Data <= Port_Out;
        ELSIF (Mem_2Reg = '1') THEN
            Write_Data <= Mem_Out;
        ELSE
            Write_Data <= ALU_Res;
        END IF;
    END PROCESS;
END ArchWriteBackStage;