LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;

ENTITY FetchStage IS
    PORT (
        CLK : IN STD_LOGIC;
        Mem_Out, PC_INC_Decode, ALU_Res : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- PC_INC is PC + 1 from Decode Stage
        RDst_Exec : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        Reset_Mem, Call_Exec, Branch_Exec, Branch_Mem, Mem_2PC, Zero_flag, Init, PC_Init : IN STD_LOGIC;
        IN_Inst : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        Inst : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
        Sign_Extend, PC_Inc : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
END FetchStage;

ARCHITECTURE ArchFetchStage OF FetchStage IS
    COMPONENT Adder IS
        GENERIC (n : INTEGER := 8);
        PORT (
            First, Second : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            CarryIn : STD_LOGIC;
            Sum : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            CarryOut : OUT STD_LOGIC);
    END COMPONENT Adder;

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

    COMPONENT PCDecoder IS
        PORT (
            Rds : IN STD_LOGIC_VECTOR(31 DOWNTO 0); --Rdst_Execute
            memory : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            PC_inc : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            Rdst_Mem : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            call : IN STD_LOGIC;
            Zero_Flag : IN STD_LOGIC;
            mem_to_PC : IN STD_LOGIC;
            branch : IN STD_LOGIC;
            Branch_Mem : IN STD_LOGIC;
            PC_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
    END COMPONENT PCDecoder;

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

    COMPONENT SignExtend IS
        PORT (
            data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
    END COMPONENT SignExtend;

    SIGNAL PC : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL PC_Decoder_Out : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Inst_SIG : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL NOT_Init : STD_LOGIC;
    SIGNAL NOT_CLK : STD_LOGIC;
BEGIN
    NOT_CLK <= NOT CLK;
    PCD0 : PCDecoder PORT MAP(RDst_Exec, Mem_Out, PC_INC_Decode, ALU_Res, Call_Exec, Zero_flag, Mem_2PC, Branch_Exec, Branch_Mem, PC_Decoder_Out);
    PC0 : GenericRegister GENERIC MAP(32) PORT MAP('1', PC_Init, PC_Decoder_Out, x"00000000", PC);
    NOT_Init <= NOT Init;
    Inst_Mem : Memory GENERIC MAP(
        bus_width => 16,
        address_width => 12,
        slot_width => 16
    )
    PORT MAP(Reset_Mem, NOT_CLK, NOT_Init, PC(11 DOWNTO 0), IN_Inst, Inst_SIG);
    Inst <= Inst_SIG;
    SE0 : SignExtend PORT MAP(Inst_SIG, Sign_Extend);
    A0 : Adder GENERIC MAP(32) PORT MAP(PC, X"00000001", '0', PC_Inc, OPEN);

END ArchFetchStage;