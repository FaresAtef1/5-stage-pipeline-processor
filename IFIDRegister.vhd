LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY IFIDRegister IS
    PORT (
        RST_Reg : IN STD_LOGIC;
        Clk : IN STD_LOGIC;
        RST : IN STD_LOGIC;
        INT : IN STD_LOGIC;
        Enable : IN STD_LOGIC;
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
END IFIDRegister;

ARCHITECTURE ArchIFIDRegister OF IFIDRegister IS
BEGIN
    PROCESS (Clk, RST_Reg)
    BEGIN
        IF RST_Reg = '1' THEN
            RST_Out <= '0';
            INT_Out <= '0';
            INC_PC_Out <= (OTHERS => '0');
            Op_Code <= (OTHERS => '0');
            Rdst <= (OTHERS => '0');
            Rsrc1 <= (OTHERS => '0');
            Rsrc2 <= (OTHERS => '0');
            Immediate_Val_Out <= (OTHERS => '0');
        ELSIF RISING_EDGE(Clk) AND Enable = '0' THEN
            RST_Out <= RST;
            INT_Out <= INT;
            INC_PC_Out <= INC_PC;
            Op_Code <= Instruction(15 DOWNTO 11);
            Rdst <= Instruction(10 DOWNTO 8);
            Rsrc1 <= Instruction(7 DOWNTO 5);
            Rsrc2 <= Instruction(4 DOWNTO 2);
            Immediate_Val_Out <= Immediate_Val;
        END IF;
    END PROCESS;
END ArchIFIDRegister;