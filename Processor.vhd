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
    -- SIGNAL RST_ID : STD_LOGIC;
    -- SIGNAL INT_ID : STD_LOGIC;
    -- SIGNAL INC_PC_Out_ID : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- SIGNAL Op_Code_ID : STD_LOGIC_VECTOR(4 DOWNTO 0);
    -- SIGNAL Rdst_ID, Rsrc1_ID, Rsrc2_ID : STD_LOGIC_VECTOR(2 DOWNTO 0);
    -- SIGNAL Immediate_Val_ID : STD_LOGIC_VECTOR(31 DOWNTO 0);
    --

    -- DECODE STAGE INPUT SIGNALS
    -- SIGNAL Op_Code_ID : STD_LOGIC_VECTOR (4 DOWNTO 0);
    -- SIGNAL Reset_ID, ResetExec_ID, ResetMem_ID, ResetWB_ID, INT_ID, INTExec_ID, INTMem_ID, INTWB_ID, MemReadExec_ID, SwapExec_ID, INRExec_ID, MemToPCExec_ID, MemToPCMem_ID, MemToPCWB_ID, RegWriteWB_ID : STD_LOGIC ;
    -- SIGNAL RDst_ID, RSrc1_ID, RSrc2_ID, Write_Reg_ID, ExecRdst_ID, ExecRsrc1_ID : STD_LOGIC_VECTOR (2 DOWNTO 0);
    -- SIGNAL Write_Data_ID : STD_LOGIC_VECTOR (31 DOWNTO 0);

    --DECODE STAGE OUTPUT SIGNALS
    -- SIGNAL Register_Write_ID, Branch_ID, Immediate_ID, Mem_Read_ID, Mem_Write_ID, Mem_2Reg_ID,
    -- Port_Write_ID, Port_Read_ID, Protect_Write_ID, Protect_Val_ID, Write_Flag_ID, Stack_ID, Push_ID, Call_ID, Mem_2PC_ID, SWAP_ID, RTI_ID, Push_INT_PC_ID : STD_LOGIC;
    SIGNAL InstRdst_ID : STD_LOGIC_VECTOR (2 DOWNTO 0);
    -- SIGNAL Read_Data1_ID, Read_Data2_ID : STD_LOGIC_VECTOR (31 DOWNTO 0);
COMPONENT IDEXRegister IS
    PORT (
        RST_Reg : IN STD_LOGIC;
        Clk : IN STD_LOGIC;
        Register_Write : IN STD_LOGIC;
        Branch : IN STD_LOGIC;
        Immediate : IN STD_LOGIC;
        Mem_Read : IN STD_LOGIC;
        Mem_Write : IN STD_LOGIC;
        Mem_2Reg : IN STD_LOGIC;
        Port_Write : IN STD_LOGIC;
        Port_Read : IN STD_LOGIC;
        Protect_Write : IN STD_LOGIC;
        Protect_Val : IN STD_LOGIC;
        Write_Flag : IN STD_LOGIC;
        Stack : IN STD_LOGIC;
        Push : IN STD_LOGIC;
        Call : IN STD_LOGIC;
        Mem_2PC : IN STD_LOGIC;
        Swap : IN STD_LOGIC;
        RTI : IN STD_LOGIC;
        RST : IN STD_LOGIC;
        INT : IN STD_LOGIC;
        Read_Data1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Read_Data2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Op_Code : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        Rdst, Rsrc1, Rsrc2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        INC_PC: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Push_INT_PC : IN STD_LOGIC;
        --output ports
        Register_Write_Out : OUT STD_LOGIC;
        Branch_Out : OUT STD_LOGIC;
        Immediate_Out : OUT STD_LOGIC;
        Mem_Read_Out : OUT STD_LOGIC;
        Mem_Write_Out : OUT STD_LOGIC;
        Mem_2Reg_Out : OUT STD_LOGIC;
        Port_Write_Out : OUT STD_LOGIC;
        Port_Read_Out : OUT STD_LOGIC;
        Protect_Write_Out : OUT STD_LOGIC;
        Protect_Val_Out : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
        Write_Flag_Out : OUT STD_LOGIC;
        Stack_Out : OUT STD_LOGIC;
        Push_Out : OUT STD_LOGIC;
        Call_Out : OUT STD_LOGIC;
        Mem_2PC_Out : OUT STD_LOGIC;
        Swap_Out : OUT STD_LOGIC;
        RTI_Out : OUT STD_LOGIC;
        RST_Out : OUT STD_LOGIC;
        INT_Out : OUT STD_LOGIC;
        Read_Data1_Out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Read_Data2_Out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Op_Code_Out : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        Rdst_Out, Rsrc1_Out, Rsrc2_Out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        INC_PC_Out: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Push_INT_PC_Out : OUT STD_LOGIC

    );
END COMPONENT IDEXRegister;
COMPONENT EXMEMRegister IS
    PORT (
        Clk : IN STD_LOGIC;
        RST_Reg : IN STD_LOGIC;
        RTI : IN STD_LOGIC;
        Register_Write : IN STD_LOGIC;
        Mem_2PC : IN STD_LOGIC;
        Mem_2Reg : IN STD_LOGIC;
        Push : IN STD_LOGIC;
        Stack : IN STD_LOGIC;
        Push_INT_PC : IN STD_LOGIC;
        Call : IN STD_LOGIC;
        Mem_Write : IN STD_LOGIC;
        Mem_Read : IN STD_LOGIC;
        Branch : IN STD_LOGIC;
        Port_Write : IN STD_LOGIC;
        Port_Read : IN STD_LOGIC;
        RST : IN STD_LOGIC;
        INT : IN STD_LOGIC;
        Stack_Pointer : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        INC_PC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        ALU_Result : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Memory_Data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Flags : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Rdst: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Protect_State : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        -- output ports
        RTI_Out : OUT STD_LOGIC;
        Register_Write_Out : OUT STD_LOGIC;
        Mem_2PC_Out : OUT STD_LOGIC;
        Mem_2Reg_Out : OUT STD_LOGIC;
        Push_Out : OUT STD_LOGIC;
        Stack_Out : OUT STD_LOGIC;
        Push_INT_PC_Out : OUT STD_LOGIC;
        Call_Out : OUT STD_LOGIC;
        Mem_Write_Out : OUT STD_LOGIC;
        Mem_Read_Out : OUT STD_LOGIC;
        Branch_Out : OUT STD_LOGIC;
        Port_Write_Out : OUT STD_LOGIC;
        Port_Read_Out : OUT STD_LOGIC;
        RST_Out : OUT STD_LOGIC;
        INT_Out : OUT STD_LOGIC;
        Stack_Pointer_Out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        INC_PC_Out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        ALU_Result_Out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Memory_Data_Out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Flags_Out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        Rdst_Out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        Protect_State_Out : OUT STD_LOGIC
    );
END COMPONENT EXMEMRegister;
COMPONENT ExecuteStage IS
    PORT (
        Op_Code : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        Rdst, Rsrc1, Rsrc2 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Rdst_Mem, Rdst_WB : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Register_Write_Mem, Register_Write_WB : IN STD_LOGIC;
        Immediate : IN STD_LOGIC;
        Protect_Write : IN STD_LOGIC;
        Protect_Val : IN STD_LOGIC_VECTOR(0 DOWNTO 0);-- to match generic map
        Write_Flag : IN STD_LOGIC;
        Stack : IN STD_LOGIC;
        Stack_Mem : IN STD_LOGIC;
        RTI_WB : IN STD_LOGIC;
        RTI_Flags : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Prev_ALU_Res : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Prev_Mem_Res : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Read_Data1 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        Read_Data2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        Immediate_Val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Effective_Address : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
        Reset : IN STD_LOGIC;
        ALU_Result : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        Protect_Out : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);-- to match generic map
        Flags : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        Stack_Pointer : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        Mem_Data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)

    );
END COMPONENT ExecuteStage;

-- instruction decode stage intermediate signals
SIGNAL RST_Reg : STD_LOGIC;
SIGNAL RTI_ID,Register_Write_ID,Branch_ID,Immediate_ID,Mem_Read_ID,Mem_Write_ID,Mem_2Reg_ID,Port_Write_ID,Port_Read_ID,Protect_Write_ID,Protect_Val_ID,Write_Flag_ID,Stack_ID,Push_ID,Call_ID,Mem_2PC_ID,Swap_ID,RST_ID,INT_ID,Push_INT_PC_ID : STD_LOGIC;
SIGNAL Read_Data1_ID,Read_Data2_ID,INC_PC_ID : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL Op_Code_ID : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL Rdst_ID,Rsrc1_ID,Rsrc2_ID : STD_LOGIC_VECTOR(2 DOWNTO 0);

-- execute stage intermediate signals
SIGNAL RTI_EX,Register_Write_EX,Branch_EX,Immediate_EX,Mem_Read_EX,Mem_Write_EX,Mem_2Reg_EX,Port_Write_EX,Port_Read_EX,Protect_Write_EX,Write_Flag_EX,Stack_EX,Push_EX,Call_EX,Mem_2PC_EX,Swap_EX,RST_EX,INT_EX,Push_INT_PC_EX: STD_LOGIC;
SIGNAL Rdst_EX, Rsrc1_EX, Rsrc2_EX,Flags_EX :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL Read_Data1_EX,Read_Data2_EX,INC_PC_EX,Stack_Pointer_EX,ALU_Result_EX,Memory_Data_EX:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL Op_Code_EX:  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL Protect_Val_EX,Protect_State_EX : STD_LOGIC_VECTOR (0 DOWNTO 0); -- helps with generics

-- memory stage intermediate signals
SIGNAL RTI_MEM,Register_Write_MEM,Mem_2PC_MEM,Mem_2Reg_MEM,Push_MEM,Stack_MEM,Push_INT_PC_MEM,Call_MEM,Mem_Write_MEM,Mem_Read_MEM,Branch_MEM,Port_Write_MEM,Port_Read_MEM,RST_MEM,INT_MEM,Protect_State_MEM : STD_LOGIC;
SIGNAL Stack_Pointer_MEM,INC_PC_MEM,ALU_Result_MEM,Memory_Data_MEM: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL Rdst_MEM,Flags_MEM: STD_LOGIC_VECTOR(2 DOWNTO 0);


-- write back stage intermediate signals
SIGNAL Rdst_WB  : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL Register_Write_WB, RTI_WB : STD_LOGIC;
SIGNAL Flags_WB: STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL Memory_Data_WB : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL EA : STD_LOGIC_VECTOR (19 DOWNTO 0); -- STILL NEEDS WORK (EFFECTIVE ADDRESS IS 20 BITS!)

-- immediate value forwarded from the fetch stage
SIGNAL Immediate_Val_ID : STD_LOGIC_VECTOR (31 DOWNTO 0);

BEGIN
    FS : FetchStage PORT MAP(CLK, X"00000000", INC_PC_ID, X"00000002", X"00000003", X"00000004", Mem_Init, '0', '0', '0', '0', '0', Init, PC_Init, In_Inst, Instruction_IF, Immediate_Val_IF, INC_PC_IF);
    IFID : IFIDRegister PORT MAP(Pipeline_Regs_Init, CLK, RST, INT, INC_PC_IF, Instruction_IF, Immediate_Val_IF, RST_ID, INT_ID, INC_PC_ID, Op_Code_ID, Rdst_ID, Rsrc1_ID, Rsrc2_ID, Immediate_Val_ID);
    DS : DecodeStage PORT MAP(
        CLK => CLK,
        Op_Code => Op_Code_ID,
        Reset => PC_Init,
        ResetExec => '0',
        ResetMem => '0',
        ResetWB => '0', INT => INT_ID, INTExec => '0', INTMem => '0', INTWB => '0', MemReadExec => '0', SwapExec => '0', INRExec => '0', MemToPCExec => '0', MemToPCMem => '0', MemToPCWB => '0', RegWriteWB => '0',
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

-- idex-register port mapping
IDEX : IDEXRegister PORT MAP (RST_Reg,CLK,Register_Write_ID,Branch_ID,Immediate_ID,Mem_Read_ID,Mem_Write_ID,Mem_2Reg_ID,Port_Write_ID,Port_Read_ID,Protect_Write_ID,Protect_Val_ID,Write_Flag_ID,Stack_ID,Push_ID,Call_ID,Mem_2PC_ID,Swap_ID,RTI_ID,RST_ID,INT_ID,Read_Data1_ID,Read_Data2_ID,Op_Code_ID,Rdst_ID,Rsrc1_ID,Rsrc2_ID,INC_PC_ID,Push_INT_PC_ID,
Register_Write_EX,Branch_EX,Immediate_EX,Mem_Read_EX,Mem_Write_EX,Mem_2Reg_EX,Port_Write_EX,Port_Read_EX,Protect_Write_EX,Protect_Val_EX,Write_Flag_EX,Stack_EX,Push_EX,Call_EX,Mem_2PC_EX,Swap_EX,RTI_EX,RST_EX,INT_EX,Read_Data1_EX,Read_Data2_EX,Op_Code_EX,Rdst_EX,Rsrc1_EX,Rsrc2_EX,INC_PC_EX,Push_INT_PC_EX);

-- exmem-register port mapping
EXMEM: EXMEMRegister PORT MAP (CLK,RST_Reg ,RTI_EX,Register_Write_EX,Mem_2PC_EX,Mem_2Reg_EX,Push_EX,Stack_EX,Push_INT_PC_EX,Call_EX,Mem_Write_EX,Mem_Read_EX,Branch_EX,Port_Write_EX,Port_Read_EX,RST_EX,INT_EX,Stack_Pointer_EX,INC_PC_EX,ALU_Result_EX,Memory_Data_EX,Flags_EX,Rdst_EX,Protect_State_EX,
RTI_MEM,Register_Write_MEM,Mem_2PC_MEM,Mem_2Reg_MEM,Push_MEM,Stack_MEM,Push_INT_PC_MEM,Call_MEM,Mem_Write_MEM,Mem_Read_MEM,Branch_MEM,Port_Write_MEM,Port_Read_MEM,RST_MEM,INT_MEM,Stack_Pointer_MEM,INC_PC_MEM,ALU_Result_MEM,Memory_Data_MEM,Flags_MEM,Rdst_MEM,Protect_State_MEM);

-- execute stage port mapping
EXECUTE : ExecuteStage PORT MAP (Op_Code_EX,Rdst_EX,Rsrc1_EX,Rsrc2_EX,Rdst_MEM,Rdst_WB,Register_Write_MEM,Register_Write_WB,Immediate_EX,Protect_Write_EX,Protect_Val_EX,Write_Flag_EX,Stack_EX,Stack_MEM,RTI_WB,Flags_WB,ALU_Result_MEM,Memory_Data_WB,Read_Data1_EX,Read_Data2_EX,Immediate_Val_ID,EA,RST_EX,
ALU_Result_EX,Protect_State_EX,Flags_EX,Stack_Pointer_EX,Memory_Data_EX);

   
END ArchProcessor;