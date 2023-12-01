library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;   
use std.textio.all;
use ieee.std_logic_textio.all;
use IEEE.std_logic_unsigned.all;

ENTITY HazardDetctionUnit IS
    PORT (MemRead, INRExec, SwapExec, MemToPCExec, MemToPCMem, MemToPCWB: IN STD_LOGIC; -- INR--> Input port read
          RSrc1, RSrc2 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
          ExecRdst : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
          Hazard : OUT STD_LOGIC);
END HazardDetctionUnit;

ARCHITECTURE ArchHazardDetctionUnit OF HazardDetctionUnit IS
BEGIN
    PROCESS (MemRead, INRExec, SwapExec, MemToPCExec, MemToPCMem, MemToPCWB, RSrc1, RSrc2, ExecRdst)
    BEGIN
        IF MemToPCExec = '1' OR MemToPCMem = '1' OR MemToPCWB = '1' OR SwapExec = '1' THEN
            Hazard <= '1';
        ELSIF (MEMRead = '1' OR INRExec = '1') AND ((RSrc1 = ExecRdst) OR (RSrc2 = ExecRdst)) THEN
            Hazard <= '1';
        ELSE
            Hazard <= '0';
        END IF;
    END PROCESS; 
END ArchHazardDetctionUnit;