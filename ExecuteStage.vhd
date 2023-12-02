ENTITY ExecuteStage IS
    PORT (
        Op_Code : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        Rdst, Rsrc1, Rsrc2 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Rdst_Mem, Rdst_WB : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Register_Write_Mem, Register_Write_WB IN STD_LOGIC;
        Immediate : IN STD_LOGIC;
        Protect_Write : IN STD_LOGIC;
        Protect_Val : IN STD_LOGIC;
        Write_Flag : IN STD_LOGIC;
        Stack : IN STD_LOGIC;
        Stack_Mem : IN STD_LOGIC;
        RTI_WB : IN STD_LOGIC;
        Prev_ALU_Res : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Prev_Mem_Res : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Read_Data1 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        Read_Data2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        Immediate_Val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Effective_Address : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
        ALU_Result : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        Protect_Out : OUT STD_LOGIC;
        Flags : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        Stack_Pointer : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        Mem_Data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)

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
    COMPONENT ALUControlUnit IS PORT (
        OpCode : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        ALUOP : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT ALUControlUnit;

    COMPONENT ForwardingUnit IS
        PORT (
            PrevALURes, PrevMemRes : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            ExecWB, MemWB : IN STD_LOGIC;
            RSrc1, RSrc2 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Forward_Data1, Forward_Data2 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0));
    END COMPONENT ForwardingUnit;

    SIGNAL Carry_Flag : STD_LOGIC;
    SIGNAL Zero_Flag : STD_LOGIC;
    SIGNAL Negative_Flag : STD_LOGIC;
    SIGNAL ALU_Sel : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL ALU_Op1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL ALU_Op2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL ALU_Flags : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Protect_Address : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Forward_Data1 : STD_LOGIC_VECTOR (1 DOWNTO 0);
    SIGNAL Forward_Data2 : STD_LOGIC_VECTOR (1 DOWNTO 0);
BEGIN
    AC1 : ALUControlUnit PORT MAP(Op_Code, ALU_Sel);
    A1 : ALU PORT MAP(Carry_Flag, ALU_Sel, ALU_Op1, ALU_Op2, ALU_Result, ALU_Flags);
    F1 : ForwardingUnit PORT MAP(Rdst_Mem, Rdst_WB, Register_Write_Mem, Register_Write_WB, Rsrc1, Rsrc2, Forward_Data1, Forward_Data2);
    -- operand 1 mux
    ALU_Op1 <=
        Read_Data1 WHEN Stack = '0' AND Forward_Data1 = "00" ELSE
        Stack_Pointer WHEN Stack = '1' AND Stack_Mem = '0' ELSE
        Prev_ALU_Res WHEN (Stack = '1' AND Stack_Mem = '1') OR Forward_Data1 = "10" ELSE
        Prev_Mem_Res WHEN Forward_Data1 = "11";
    -- operand 2 mux
    ALU_Op2 <=
        Immediate_Val WHEN Immediate = '1' ELSE
        Read_Data2 WHEN Forward_Data2 = "00" ELSE
        Prev_ALU_Res WHEN Forward_Data2 = "10" ELSE
        Prev_Mem_Res WHEN Forward_Data2 = "11" ; -- EA is missing!!!!!!!!!!!!!!!
    -- memory data mux
    Mem_Data <=
        Read_Data1 WHEN Forward_Data1 = "00" ELSE
        Prev_ALU_Res WHEN Forward_Data1 = "10" ELSE
        Prev_Mem_Res WHEN Forward_Data1 = "11" ;
    --  protect address mux !!!!------> protect memory module isn't implemented
    Protect_Address <=
        Read_Data1 WHEN Protect_Write='1' ELSE
        Immediate_Val ;
    
    

    END ARCHITECTURE ArchExecuteStage;