LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;

ENTITY DecodeStage IS
    PORT (
        CLK : IN STD_LOGIC;
        Op_Code : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        Reset, ResetExec, ResetMem, ResetWB, INT, INTExec, INTMem, INTWB, MemReadExec, SwapExec, INRExec, MemToPCExec, MemToPCMem, MemToPCWB, RegWriteWB : IN STD_LOGIC;
        RDst, RSrc1, RSrc2, Write_Reg, ExecRdst, ExecRsrc1 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Write_Data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        Register_Write : OUT STD_LOGIC;
        Branch : OUT STD_LOGIC;
        Immediate : OUT STD_LOGIC;
        Mem_Read : OUT STD_LOGIC;
        Mem_Write : OUT STD_LOGIC;
        Mem_2Reg : OUT STD_LOGIC;
        Port_Write : OUT STD_LOGIC;
        Port_Read : OUT STD_LOGIC;
        Protect_Write : OUT STD_LOGIC;
        Protect_Val : OUT STD_LOGIC;
        Write_Flag : OUT STD_LOGIC;
        Stack : OUT STD_LOGIC;
        Push : OUT STD_LOGIC;
        Call : OUT STD_LOGIC;
        Mem_2PC : OUT STD_LOGIC;
        SWAP : OUT STD_LOGIC;
        RTI : OUT STD_LOGIC;
        InstRdst : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        Read_Data1, Read_Data2 : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
END DecodeStage;

ARCHITECTURE ArchDecodeStage OF DecodeStage IS
    COMPONENT HazardDetctionUnit IS
        PORT (
            MemRead, INRExec, SwapExec, MemToPCExec, MemToPCMem, MemToPCWB : IN STD_LOGIC;
            RSrc1, RSrc2 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            ExecRdst : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Hazard : OUT STD_LOGIC);
    END COMPONENT HazardDetctionUnit;
    COMPONENT ControlUnit IS
        PORT (
            Op_Code : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            Swap_Loopback : IN STD_LOGIC;
            Reset_Exec : IN STD_LOGIC;
            INT_Exec : IN STD_LOGIC;
            INT_Mem : IN STD_LOGIC;
            INT_WB : IN STD_LOGIC;
            Register_Write : OUT STD_LOGIC;
            Branch : OUT STD_LOGIC;
            Immediate : OUT STD_LOGIC;
            Mem_Read : OUT STD_LOGIC;
            Mem_Write : OUT STD_LOGIC;
            Mem_2Reg : OUT STD_LOGIC;
            Port_Write : OUT STD_LOGIC;
            Port_Read : OUT STD_LOGIC;
            Protect_Write : OUT STD_LOGIC;
            Protect_Val : OUT STD_LOGIC;
            Write_Flag : OUT STD_LOGIC;
            Stack : OUT STD_LOGIC;
            Push : OUT STD_LOGIC;
            Call : OUT STD_LOGIC;
            Mem_2PC : OUT STD_LOGIC;
            Swap : OUT STD_LOGIC;
            RTI : OUT STD_LOGIC;
            Push_INT_PC : OUT STD_LOGIC
        );
    END COMPONENT ControlUnit;
    COMPONENT RegFile IS
        PORT (
            CLK : IN STD_LOGIC;
            RESET, RegWrite : IN STD_LOGIC;
            Reg1_Num, Reg2_Num, Write_Reg : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Write_Data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            Reg1_Data, Reg2_Data : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
    END COMPONENT RegFile;
    COMPONENT RegFileDecoder IS
        PORT (
            Rdst, RSrc1, RExec : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            SingleOp, Swap : IN STD_LOGIC;
            Reg1 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
    END COMPONENT RegFileDecoder;
    SIGNAL Hazard : STD_LOGIC;
    SIGNAL Read_Data1_SIG, Read_Data2_SIG : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL CU_Signals : STD_LOGIC_VECTOR(16 DOWNTO 0);
    SIGNAL ReadReg1, ReadReg2 : STD_LOGIC_VECTOR(2 DOWNTO 0); -- ReadReg1 is the register number of the first register to be read, ReadReg2 is the register number of the second register to be read
BEGIN
    D1 : RegFileDecoder PORT MAP(RDst, RSrc1, ExecRdst, Op_Code(4), SwapExec, ReadReg1); -- Op_Code(4) is the SingleOp signal
    ReadReg2 <= RSrc2 WHEN Op_Code(4) = '0' ELSE
        RSRC1; -- For instruction cmp
    H1 : HazardDetctionUnit PORT MAP(MemReadExec, INRExec, SwapExec, MemToPCExec, MemToPCMem, MemToPCWB, RSrc1, RSrc2, ExecRdst, Hazard);
    C1 : ControlUnit PORT MAP(Op_Code, SwapExec, ResetExec, INTExec, INTMem, INTWB, CU_Signals(16), CU_Signals(15), CU_Signals(14), CU_Signals(13), CU_Signals(12), CU_Signals(11), CU_Signals(10), CU_Signals(9), CU_Signals(8), CU_Signals(7), CU_Signals(6), CU_Signals(5), CU_Signals(4), CU_Signals(3), CU_Signals(2), CU_Signals(1), CU_Signals(0));
    R1 : RegFile PORT MAP(CLK, Reset, RegWriteWB, ReadReg1, ReadReg2, Write_Reg, Write_Data, Read_Data1_SIG, Read_Data2_SIG);
    PROCESS (Read_Data1_SIG, Read_Data2_SIG, Hazard)
    BEGIN
        IF Hazard = '1' AND (INT = '0' AND INTExec = '0' AND INTMem = '0' AND INTWB = '0') THEN
            Register_Write <= '0';
            Branch <= '0';
            Immediate <= '0';
            Mem_Read <= '0';
            Mem_Write <= '0';
            Mem_2Reg <= '0';
            Port_Write <= '0';
            Port_Read <= '0';
            Protect_Write <= '0';
            Protect_Val <= '0';
            Write_Flag <= '0';
            Stack <= '0';
            Push <= '0';
            Call <= '0';
            Mem_2PC <= '0';
            SWAP <= '0';
            RTI <= '0';
        ELSE
            Register_Write <= CU_Signals(16);
            Branch <= CU_Signals(15);
            Immediate <= CU_Signals(14);
            Mem_Read <= CU_Signals(13);
            Mem_Write <= CU_Signals(12);
            Mem_2Reg <= CU_Signals(11);
            Port_Write <= CU_Signals(10);
            Port_Read <= CU_Signals(9);
            Protect_Write <= CU_Signals(8);
            Protect_Val <= CU_Signals(7);
            Write_Flag <= CU_Signals(6);
            Stack <= CU_Signals(5);
            Push <= CU_Signals(4);
            Call <= CU_Signals(3);
            Mem_2PC <= CU_Signals(2);
            SWAP <= CU_Signals(1);
            RTI <= CU_Signals(0);
        END IF;
        IF SwapExec = '1' THEN
            InstRdst <= ExecRsrc1;
        ELSE
            InstRdst <= RDst;
        END IF;
        Read_Data1 <= Read_Data1_SIG;
        Read_Data2 <= Read_Data2_SIG;
    END PROCESS;
END ArchDecodeStage;