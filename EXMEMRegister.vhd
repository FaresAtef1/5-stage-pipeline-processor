LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY EXMEMRegister IS
    PORT (
        Protect_Val, Protect_Write : IN STD_LOGIC;
        Clk : IN STD_LOGIC;
        RST_Reg : IN STD_LOGIC;
        RTI : IN STD_LOGIC;
        Swap : IN STD_LOGIC;
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
        Rdst : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Protect_State : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        -- output ports
        RTI_Out : OUT STD_LOGIC;
        Swap_Out : OUT STD_LOGIC;
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
        Protect_State_Out : OUT STD_LOGIC;
        Protect_Val_Out, Protect_Write_Out : OUT STD_LOGIC
    );
END ENTITY EXMEMRegister;

ARCHITECTURE ArchEXMEMRegister OF EXMEMRegister IS
BEGIN
    PROCESS (Clk, RST_Reg)
    BEGIN

        IF RST_Reg = '1' THEN
            Protect_Val_Out <= '0';
            Protect_Write_Out <= '0';
            RTI_Out <= '0';
            Register_Write_Out <= '0';
            Mem_2PC_Out <= '0';
            Mem_2Reg_Out <= '0';
            Push_Out <= '0';
            Stack_Out <= '0';
            Push_INT_PC_Out <= '0';
            Call_Out <= '0';
            Mem_Write_Out <= '0';
            Mem_Read_Out <= '0';
            Branch_Out <= '0';
            Port_Write_Out <= '0';
            Port_Read_Out <= '0';
            RST_Out <= '0';
            INT_Out <= '0';
            Stack_Pointer_Out <= (OTHERS => '0');
            INC_PC_Out <= (OTHERS => '0');
            ALU_Result_Out <= (OTHERS => '0');
            Memory_Data_Out <= (OTHERS => '0');
            Flags_Out <= (OTHERS => '0');
            Rdst_Out <= (OTHERS => '0');
            Protect_State_Out <= '0';
            Swap_Out <= '0';
        ELSIF RISING_EDGE(Clk) THEN
            Protect_Val_Out <= Protect_Val;
            Protect_Write_Out <= Protect_Write;
            RTI_Out <= RTI;
            Register_Write_Out <= Register_Write;
            Mem_2PC_Out <= Mem_2PC;
            Mem_2Reg_Out <= Mem_2Reg;
            Push_Out <= Push;
            Stack_Out <= Stack;
            Push_INT_PC_Out <= Push_INT_PC;
            Call_Out <= Call;
            Mem_Write_Out <= Mem_Write;
            Mem_Read_Out <= Mem_Read;
            Branch_Out <= Branch;
            Port_Write_Out <= Port_Write;
            Port_Read_Out <= Port_Read;
            RST_Out <= RST;
            INT_Out <= INT;
            Stack_Pointer_Out <= Stack_Pointer;
            INC_PC_Out <= INC_PC;
            ALU_Result_Out <= ALU_Result;
            Memory_Data_Out <= Memory_Data;
            Flags_Out <= Flags;
            Rdst_Out <= Rdst;
            Protect_State_Out <= Protect_State(0);
            Swap_Out <= Swap;
        END IF;
    END PROCESS;

END ArchEXMEMRegister;