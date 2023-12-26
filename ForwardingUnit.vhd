LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;

ENTITY ForwardingUnit IS
    PORT (
        Swap_Mem : IN STD_LOGIC;
        PrevALURes, PrevMemRes : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        ExecWB, MemWB : IN STD_LOGIC;
        RSrc1, RSrc2 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Forward_Data1, Forward_Data2 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
    );
END ForwardingUnit;

-- 00 -> No Forwarding
-- 10 -> Forward Prev ALU res
-- 11 -> Forward prev Mem res 

ARCHITECTURE ArchForwardingUnit OF ForwardingUnit IS
    SIGNAL Sig_Forward_Data1, Sig_Forward_Data2 : STD_LOGIC_VECTOR (1 DOWNTO 0);
BEGIN
    PROCESS (PrevAluRes, PrevMemRes, ExecWB, MemWB, RSrc1, RSrc2)
    BEGIN
        Sig_Forward_Data1 <= "00";
        Sig_Forward_Data2 <= "00";
        IF ExecWB = '1' AND Swap_Mem ='0' THEN
            IF PrevAluRes = RSrc1 THEN
                Sig_Forward_Data1 <= "10";
            END IF;
            IF PrevALURes = RSrc2 THEN
                Sig_Forward_Data2 <= "10";
            END IF;
        END IF; 
        IF MemWB = '1' THEN
            IF PrevMemRes = RSrc1 AND (NOT(ExecWB = '1' AND PrevAluRes = RSrc1 AND Swap_Mem='0')) THEN
                Sig_Forward_Data1 <= "11";
            END IF;
            IF PrevMemRes = RSrc2 AND (NOT(ExecWB = '1' AND PrevAluRes = RSrc2)) THEN
                Sig_Forward_Data2 <= "11";
            END IF;
        END IF;
    END PROCESS;
    Forward_Data1 <= Sig_Forward_Data1;
    Forward_Data2 <= Sig_Forward_Data2;
END ArchForwardingUnit;