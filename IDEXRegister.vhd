LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY IDEXRegister IS
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
        Protect_Val_Out : OUT STD_LOGIC;
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
        INC_PC_Out: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)

    );

END IDEXRegister;

ARCHITECTURE ArchIDEXRegister OF IDEXRegister IS
BEGIN
    PROCESS (Clk, RST_Reg)
    BEGIN

        IF RST_Reg = '1' THEN
            Register_Write_Out <= '0';
            Branch_Out <= '0';
            Immediate_Out <= '0';
            Mem_Read_Out <= '0';
            Mem_Write_Out <= '0';
            Mem_2Reg_Out <= '0';
            Port_Write_Out <= '0';
            Port_Read_Out <= '0';
            Protect_Write_Out <= '0';
            Protect_Val_Out <= '0';
            Write_Flag_Out <= '0';
            Stack_Out <= '0';
            Push_Out <= '0';
            Call_Out <= '0';
            Mem_2PC_Out <= '0';
            Swap_Out <= '0';
            RTI_Out <= '0';
            Read_Data1_Out <= (OTHERS => '0');
            Read_Data2_Out <= (OTHERS => '0');
            RST_Out <= '0';
            INT_Out <= '0';
            INC_PC_Out <= (OTHERS => '0');
            Op_Code_out <= (OTHERS => '0');
            Rdst_Out <= (OTHERS => '0');
            Rsrc1_Out <= (OTHERS => '0');
            Rsrc2_Out <= (OTHERS => '0');
        ELSIF RISING_EDGE(Clk) THEN
            Register_Write_Out <= Register_Write;
            Branch_Out <= Branch;
            Immediate_Out <= Immediate;
            Mem_Read_Out <= Mem_Read;
            Mem_Write_Out <= Mem_Write;
            Mem_2Reg_Out <= Mem_2Reg;
            Port_Write_Out <= Port_Write;
            Port_Read_Out <= Port_Read;
            Protect_Write_Out <= Protect_Write;
            Protect_Val_Out <= Protect_Val;
            Write_Flag_Out <= Write_Flag;
            Stack_Out <= Stack;
            Push_Out <= Push;
            Call_Out <= Call;
            Mem_2PC_Out <= Mem_2PC;
            Swap_Out <= Swap;
            RTI_Out <= RTI;
            Read_Data1_Out <= Read_Data1;
            Read_Data2_Out <= Read_Data2;
            RST_Out <= RST;
            INT_Out <= INT;
            INC_PC_Out <= INC_PC;
            Op_Code_out <= Op_Code;
            Rdst_Out <= Rdst;
            Rsrc1_Out <= Rsrc1;
            Rsrc2_Out <= Rsrc2;
        END IF;
    END PROCESS;
END ArchIDEXRegister;