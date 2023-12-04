LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MEMWBRegister IS
    PORT (
        Clk : IN STD_LOGIC;
        RST_Reg : IN STD_LOGIC;
        RTI : IN STD_LOGIC;
        Register_Write : IN STD_LOGIC;
        Mem_2PC : IN STD_LOGIC;
        Mem_2Reg : IN STD_LOGIC;
        Push_INT_PC : IN STD_LOGIC;
        Port_Read : IN STD_LOGIC;
        RST : IN STD_LOGIC;
        INT : IN STD_LOGIC;
        Port_Val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Memory_Data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        ALU_Result : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Rdst : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        -- output ports
        RTI_Out : OUT STD_LOGIC;
        Register_Write_Out : OUT STD_LOGIC;
        Mem_2PC_Out : OUT STD_LOGIC;
        Mem_2Reg_Out : OUT STD_LOGIC;
        Push_INT_PC_Out : OUT STD_LOGIC;
        Port_Read_Out : OUT STD_LOGIC;
        RST_Out : OUT STD_LOGIC;
        INT_Out : OUT STD_LOGIC;
        Port_Val_Out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Memory_Data_Out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        ALU_Result_Out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Rdst_Out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );

END MEMWBRegister;
ARCHITECTURE ArchMEMWBRegister OF MEMWBRegister IS
BEGIN
    PROCESS (Clk, RST_Reg)
    BEGIN

        IF RST_Reg = '1' THEN
            RTI_Out <= '0';
            Register_Write_Out <= '0';
            Mem_2PC_Out <= '0';
            Mem_2Reg_Out <= '0';
            Push_INT_PC_Out <= '0';
            Port_Read_Out <= '0';
            RST_Out <= '0';
            INT_Out <= '0';
            ALU_Result_Out <= (OTHERS => '0');
            Port_Val_Out<= (OTHERS => '0');
            Memory_Data_Out <= (OTHERS => '0');
            Rdst_Out <= (OTHERS => '0');
        ELSIF RISING_EDGE(Clk) THEN
            RTI_Out <= RTI;
            Register_Write_Out <= Register_Write;
            Mem_2PC_Out <= Mem_2PC;
            Mem_2Reg_Out <= Mem_2Reg;
            Push_INT_PC_Out <= Push_INT_PC;
            Port_Read_Out <= Port_Read;
            RST_Out <= RST;
            INT_Out <= INT;
            ALU_Result_Out <= ALU_Result;
            Port_Val_Out<= Port_Val;
            Memory_Data_Out <= Memory_Data;
            Rdst_Out <= Rdst;
        END IF;
    END PROCESS;

END ArchMEMWBRegister;