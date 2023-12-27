LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY ExecuteStage IS
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
        Swap_Mem : IN STD_LOGIC;
        RTI_Flags : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Prev_ALU_Res : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Prev_Mem_Res : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Read_Data1 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        Read_Data2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        Immediate_Val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Effective_Address : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
        Reset : IN STD_LOGIC; -- Not Reset_Exec, It is Reset_Init (in the processor module)
        Reset_Mem : IN STD_LOGIC;
        Push_INT_PC_EX : IN STD_LOGIC;
        Push_INT_PC_Mem : IN STD_LOGIC;
        INC_PC_IDEX : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        INC_PC_MEMWB : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        ALU_Result : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        Protect_Out : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);-- to match generic map
        Flags : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        Stack_Pointer : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        Mem_Data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        INC_PC_OUT_EX : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)

    );
END ExecuteStage;
ARCHITECTURE ArchExecuteStage OF ExecuteStage IS
    COMPONENT ALU IS
        PORT (
            Cin : IN STD_LOGIC;
            Sel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            Reg1, Reg2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            Result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            Flags : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
        );
    END COMPONENT ALU;
    COMPONENT ALUControlUnit IS
        PORT (
            OpCode : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            ALUOP : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            Push_INT_PC_EX : IN STD_LOGIC;
            Push_INT_PC_Mem : IN STD_LOGIC
        );
    END COMPONENT ALUControlUnit;

    COMPONENT ForwardingUnit IS
        PORT (
            Swap_Mem : IN STD_LOGIC;
            PrevALURes, PrevMemRes : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            ExecWB, MemWB : IN STD_LOGIC;
            RSrc1, RSrc2 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Forward_Data1, Forward_Data2 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0));
    END COMPONENT ForwardingUnit;

    COMPONENT Memory IS
        GENERIC (
            bus_width : INTEGER := 16;
            address_width : INTEGER := 12;
            slot_width : INTEGER := 16
        );
        PORT (
            RST : IN STD_LOGIC;
            WR_EN : IN STD_LOGIC;
            RD_EN : IN STD_LOGIC;
            Address : IN STD_LOGIC_VECTOR(address_width - 1 DOWNTO 0);
            Write_Data : IN STD_LOGIC_VECTOR (bus_width - 1 DOWNTO 0);
            Read_Data : OUT STD_LOGIC_VECTOR (bus_width - 1 DOWNTO 0));
    END COMPONENT Memory;

    COMPONENT GenericRegister IS
        GENERIC (
            Size : INTEGER := 32
        );
        PORT (
            WR_EN : IN STD_LOGIC;
            RST : IN STD_LOGIC;
            Data : IN STD_LOGIC_VECTOR(Size - 1 DOWNTO 0);
            RST_Val : IN STD_LOGIC_VECTOR(Size - 1 DOWNTO 0);
            Reg_Out : OUT STD_LOGIC_VECTOR(Size - 1 DOWNTO 0)
        );

    END COMPONENT GenericRegister;
    SIGNAL ALU_Sel : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL ALU_Op1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL ALU_Op2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL ALU_Flags : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Protect_Address : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Forward_Data1 : STD_LOGIC_VECTOR (1 DOWNTO 0);
    SIGNAL Forward_Data2 : STD_LOGIC_VECTOR (1 DOWNTO 0);
    SIGNAL FR_EN : STD_LOGIC;
    SIGNAL Flag_Data : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL ALU_SP : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL FR_Out : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Read_Enable : STD_LOGIC;
    SIGNAL Reset_Regs : STD_LOGIC;
BEGIN
    AC1 : ALUControlUnit PORT MAP(Op_Code, ALU_Sel, Push_INT_PC_EX, Push_INT_PC_Mem);
    A1 : ALU PORT MAP(FR_Out(2), ALU_Sel, ALU_Op1, ALU_Op2, ALU_Result, ALU_Flags);
    F1 : ForwardingUnit PORT MAP(Swap_Mem,Rdst_Mem, Rdst_WB, Register_Write_Mem, Register_Write_WB, Rsrc1, Rsrc2, Forward_Data1, Forward_Data2);
    PM1 : Memory GENERIC MAP(1, 12, 1) PORT MAP(Reset_Regs, Protect_Write, Read_Enable, Protect_Address(11 DOWNTO 0), Protect_Val, Protect_Out); --- protect memory
    FR1 : GenericRegister GENERIC MAP(3) PORT MAP(FR_EN, Reset_Regs, Flag_Data, "000", FR_Out);-- Flags Register
    SP1 : GenericRegister PORT MAP(Stack_Mem, Reset_Regs, Prev_ALU_Res, x"00000FFE", ALU_SP);-- stack pointer Register
    Reset_Regs <= Reset OR Reset_Mem;
    Stack_Pointer <= ALU_SP;
    INC_PC_OUT_EX <= INC_PC_IDEX WHEN Push_INT_PC_EX= '0' ELSE INC_PC_MEMWB;
    -- operand 1 mux
    ALU_Op1 <=
        Read_Data1 WHEN Stack = '0' AND Forward_Data1 = "00" ELSE
        ALU_SP WHEN Stack = '1' AND Stack_Mem = '0' ELSE
        Prev_ALU_Res WHEN (Stack = '1' AND Stack_Mem = '1') OR Forward_Data1 = "10" ELSE
        Prev_Mem_Res WHEN Forward_Data1 = "11";
    -- operand 2 mux
    ALU_Op2 <=
        Immediate_Val WHEN Immediate = '1' ELSE
        Read_Data2 WHEN Forward_Data2 = "00" ELSE
        Prev_ALU_Res WHEN Forward_Data2 = "10" ELSE
        Prev_Mem_Res WHEN Forward_Data2 = "11"; -- EA is missing!!!!!!!!!!!!!!!
    -- memory data mux
    Mem_Data <=
        Read_Data1 WHEN Forward_Data1 = "00" ELSE
        Prev_ALU_Res WHEN Forward_Data1 = "10" ELSE
        Prev_Mem_Res WHEN Forward_Data1 = "11";
    --  protect address mux 
    Protect_Address <=
        Read_Data1 WHEN Protect_Write = '1' ELSE
        Immediate_Val;
    -- flag register mux
    Flag_Data <=
        ALU_Flags WHEN RTI_WB = '0' ELSE
        RTI_Flags WHEN RTI_WB = '1';
    -- flag register write enable
    FR_EN <= Write_Flag OR RTI_WB;
    --
    Flags <= FR_Out;

    Read_Enable <= NOT Protect_Write;

END ARCHITECTURE ArchExecuteStage;