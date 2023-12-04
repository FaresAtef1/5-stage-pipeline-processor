LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;

ENTITY Processor IS
    PORT (
        CLK, RST, INT, Init : IN STD_LOGIC;
        In_Inst : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        PC_Init : IN STD_LOGIC;
        Mem_Init : IN STD_LOGIC;
        Pipeline_Regs_Init : IN STD_LOGIC;
        Write_Data : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
END Processor;

ARCHITECTURE ArchProcessor OF Processor IS
    COMPONENT FetchStage IS
        PORT (
            CLK : IN STD_LOGIC;
            Mem_Out, PC_INC_Decode, PC_INC_Mem, ALU_Res : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- PC_INC is PC + 1 from Decode Stage
            RDst_Exec : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            Reset_Mem, Call_Exec, Branch_Exec, Branch_Mem, Mem_2PC, Zero_flag, Init, PC_Init : IN STD_LOGIC;
            IN_Inst : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            Inst : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
            Sign_Extend, PC_Inc : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
    END COMPONENT FetchStage;

    COMPONENT IFIDRegister IS
        PORT (
            RST_Reg : IN STD_LOGIC;
            Clk : IN STD_LOGIC;
            RST : IN STD_LOGIC;
            INT : IN STD_LOGIC;
            INC_PC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            Instruction : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            Immediate_Val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            RST_Out : OUT STD_LOGIC;
            INT_Out : OUT STD_LOGIC;
            INC_PC_Out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            Op_Code : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            Rdst, Rsrc1, Rsrc2 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            Immediate_Val_Out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT IFIDRegister;

    COMPONENT DecodeStage IS
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
            Push_INT_PC : OUT STD_LOGIC;
            InstRdst : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            Read_Data1, Read_Data2 : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
    END COMPONENT DecodeStage;

    -- IF/ID Register
    SIGNAL RST_Reg_IF : STD_LOGIC;
    SIGNAL INC_PC_IF, Immediate_Val_IF : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Instruction_IF : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL RST_Out_ID : STD_LOGIC;
    SIGNAL INT_Out_ID : STD_LOGIC;
    SIGNAL INC_PC_Out_ID : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Op_Code_ID : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL Rdst_ID, Rsrc1_ID, Rsrc2_ID : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Immediate_Val_Out_ID : STD_LOGIC_VECTOR(31 DOWNTO 0);
    --

    -- DECODE STAGE INPUT SIGNALS
    -- SIGNAL Op_Code_ID : STD_LOGIC_VECTOR (4 DOWNTO 0);
    -- SIGNAL Reset_ID, ResetExec_ID, ResetMem_ID, ResetWB_ID, INT_ID, INTExec_ID, INTMem_ID, INTWB_ID, MemReadExec_ID, SwapExec_ID, INRExec_ID, MemToPCExec_ID, MemToPCMem_ID, MemToPCWB_ID, RegWriteWB_ID : STD_LOGIC ;
    -- SIGNAL RDst_ID, RSrc1_ID, RSrc2_ID, Write_Reg_ID, ExecRdst_ID, ExecRsrc1_ID : STD_LOGIC_VECTOR (2 DOWNTO 0);
    -- SIGNAL Write_Data_ID : STD_LOGIC_VECTOR (31 DOWNTO 0);

    --DECODE STAGE OUTPUT SIGNALS
    SIGNAL Register_Write_ID, Branch_ID, Immediate_ID, Mem_Read_ID, Mem_Write_ID, Mem_2Reg_ID,
    Port_Write_ID, Port_Read_ID, Protect_Write_ID, Protect_Val_ID, Write_Flag_ID, Stack_ID, Push_ID, Call_ID, Mem_2PC_ID, SWAP_ID, RTI_ID, Push_INT_PC_ID : STD_LOGIC;
    SIGNAL InstRdst_ID : STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL Read_Data1_ID, Read_Data2_ID : STD_LOGIC_VECTOR (31 DOWNTO 0);
BEGIN
    FS : FetchStage PORT MAP(CLK, X"00000000", INC_PC_Out_ID, X"00000002", X"00000003", X"00000004", Mem_Init, '0', '0', '0', '0', '0', Init, PC_Init, In_Inst, Instruction_IF, Immediate_Val_IF, INC_PC_IF);
    IFID : IFIDRegister PORT MAP(Pipeline_Regs_Init, CLK, RST, INT, INC_PC_IF, Instruction_IF, Immediate_Val_IF, RST_Out_ID, INT_Out_ID, INC_PC_Out_ID, Op_Code_ID, Rdst_ID, Rsrc1_ID, Rsrc2_ID, Immediate_Val_Out_ID);
    DS : DecodeStage PORT MAP(
        CLK => CLK,
        Op_Code => Op_Code_ID,
        Reset => PC_Init,
        ResetExec => '0',
        ResetMem => '0',
        ResetWB => '0', INT => INT_Out_ID, INTExec => '0', INTMem => '0', INTWB => '0', MemReadExec => '0', SwapExec => '0', INRExec => '0', MemToPCExec => '0', MemToPCMem => '0', MemToPCWB => '0', RegWriteWB => '0',
        RDst => Rdst_ID,
        RSrc1 => Rsrc1_ID,
        RSrc2 => Rsrc2_ID,
        Write_Reg => "000",
        ExecRdst => "000",
        ExecRsrc1 => "000",
        Write_Data => "11111111111111111111111111111111",
        Register_Write => Register_Write_ID,
        Branch => Branch_ID,
        Immediate => Immediate_ID,
        Mem_Read => Mem_Read_ID,
        Mem_Write => Mem_Write_ID,
        Mem_2Reg => Mem_2Reg_ID,
        Port_Write => Port_Write_ID,
        Port_Read => Port_Read_ID,
        Protect_Write => Protect_Write_ID,
        Protect_Val => Protect_Val_ID,
        Write_Flag => Write_Flag_ID,
        Stack => Stack_ID,
        Push => Push_ID,
        Call => Call_ID,
        Mem_2PC => Mem_2PC_ID,
        SWAP => SWAP_ID,
        RTI => RTI_ID,
        Push_INT_PC => Push_INT_PC_ID,
        InstRdst => InstRdst_ID,
        Read_Data1 => Read_Data1_ID, Read_Data2 => Read_Data2_ID);

END ArchProcessor;