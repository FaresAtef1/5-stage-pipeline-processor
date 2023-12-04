LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY HazardDetctionUnit IS
    PORT (
        MemRead, INRExec, SwapExec, MemToPCExec, MemToPCMem, MemToPCWB, Immediate : IN STD_LOGIC; -- INR--> Input port read
        RSrc1, RSrc2 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        ExecRdst : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Hazard : OUT STD_LOGIC);
END HazardDetctionUnit;

ARCHITECTURE ArchHazardDetctionUnit OF HazardDetctionUnit IS
BEGIN
    PROCESS (MemRead, INRExec, SwapExec, MemToPCExec, MemToPCMem, MemToPCWB, RSrc1, RSrc2, ExecRdst)
    BEGIN
        IF MemToPCExec = '1' OR MemToPCMem = '1' OR MemToPCWB = '1' OR SwapExec = '1' OR Immediate = '1' THEN
            Hazard <= '1';
        ELSIF (MEMRead = '1' OR INRExec = '1') AND ((RSrc1 = ExecRdst) OR (RSrc2 = ExecRdst)) THEN -- INRExec --> To handle IN R1; Add R2, R1, R3
            Hazard <= '1';
        ELSE
            Hazard <= '0';
        END IF;
    END PROCESS;
END ArchHazardDetctionUnit;