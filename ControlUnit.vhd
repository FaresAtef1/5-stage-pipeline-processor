LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ControlUnit IS
    PORT (
        RTI_Exec : IN STD_LOGIC;
        Op_Code : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        Swap_Loopback : IN STD_LOGIC;
        Reset_Exec : IN STD_LOGIC;
        INT_Exec : IN STD_LOGIC;
        INT_Mem : IN STD_LOGIC;
        INT_WB : IN STD_LOGIC;
        Hazard : IN STD_LOGIC;
        Immediate_EX : IN STD_LOGIC;
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
END ENTITY ControlUnit;

ARCHITECTURE ArchControlUnit OF ControlUnit IS
    SIGNAL CU_Signals : STD_LOGIC_VECTOR(17 DOWNTO 0);
BEGIN
    
    Register_Write <= CU_Signals(17);
    Branch <= CU_Signals(16);
    Immediate <= CU_Signals(15);
    Mem_Read <= CU_Signals(14);
    Mem_Write <= CU_Signals(13);
    Mem_2Reg <= CU_Signals(12);
    Port_Write <= CU_Signals(11);
    Port_Read <= CU_Signals(10);
    Protect_Write <= CU_Signals(9);
    Protect_Val <= CU_Signals(8);
    Write_Flag <= CU_Signals(7);
    Stack <= CU_Signals(6);
    Push <= CU_Signals(5);
    Call <= CU_Signals(4);
    Mem_2PC <= CU_Signals(3);
    Swap <= CU_Signals(2);
    RTI <= CU_Signals(1);
    Push_INT_PC <= CU_Signals(0);

    CU_Signals <=

        "000100000000001000" WHEN Reset_Exec = '1' ELSE --RESET COMING FROM EXECUTE STAGE
        "100000000000000000" WHEN Swap_Loopback = '1' ELSE --SWAP LOOPBACK SIGNAL FROM EXECUTE STAGE
        "000100000000001000" WHEN INT_Exec = '1' ELSE --INTERRUPT COMING FROM EXECUTE STAGE
        "000010000001100001" WHEN INT_Mem = '1' ELSE 
        "000010000001100000" WHEN INT_WB = '1' ELSE --STILL NEEDS SOME WORK ASSOCIATED WITH (CALL) SIGNAL
        "000100000001001000" WHEN RTI_Exec = '1' ELSE --RTI COMING FROM EXECUTE STAGE
        "000000000000000000" WHEN Hazard = '1' OR Immediate_EX='1' ELSE
        "000000000000000000" WHEN Op_Code = "00000" ELSE --NOP   
        "100000000010000000" WHEN Op_Code = "10000" ELSE --NOT
        "100000000010000000" WHEN Op_Code = "10001" ELSE --NEG
        "100000000010000000" WHEN Op_Code = "10010" ELSE --INC
        "100000000010000000" WHEN Op_Code = "10011" ELSE --DEC
        "000000100000000000" WHEN Op_Code = "10100" ELSE --OUT
        "100000010000000000" WHEN Op_Code = "00001" ELSE --IN
        "100000000000000100" WHEN Op_Code = "00010" ELSE --Swap
        "100000000010000000" WHEN Op_Code = "00011" ELSE --ADD
        "101000000010000000" WHEN Op_Code = "00100" ELSE --ADDI
        "100000000010000000" WHEN Op_Code = "00101" ELSE --SUB
        "100000000010000000" WHEN Op_Code = "00110" ELSE --AND
        "100000000010000000" WHEN Op_Code = "00111" ELSE --OR
        "100000000010000000" WHEN Op_Code = "01000" ELSE --XOR
        "000000000010000000" WHEN Op_Code = "10101" ELSE --CMP
        "101000000010000000" WHEN Op_Code = "10110" ELSE --BITSET
        "101000000010000000" WHEN Op_Code = "10111" ELSE --RCL
        "101000000010000000" WHEN Op_Code = "11000" ELSE --RCR
        "000010000001100000" WHEN Op_Code = "11001" ELSE --PUSH
        "100101000001000000" WHEN Op_Code = "01001" ELSE --POP
        "101000000010000000" WHEN Op_Code = "01010" ELSE --LDM
        "101101000000000000" WHEN Op_Code = "01011" ELSE --LDD --EA HAS TO BE 20 BITS!
        "001010000000000000" WHEN Op_Code = "11010" ELSE --STD
        "000000001100000000" WHEN Op_Code = "11011" ELSE --PROTECT
        "000000001000000000" WHEN Op_Code = "11100" ELSE --FREE
        "010000000000000000" WHEN Op_Code = "11101" ELSE --JZ - NOT FULLY IMPLEMENTED
        "000000000000010000" WHEN Op_Code = "11110" ELSE --JMP
        "000010000001110000" WHEN Op_Code = "11111" ELSE --CALL --NOT FINISHED (2 Cycles to push)
        "000100000001001000" WHEN Op_Code = "01100" ELSE --RET --NOT FINISHED (2 Cycles to pop)
        "000100000001001010" WHEN Op_Code = "01101"; --RTI --NOT FINISHED (2 Cycles to pop)
END ArchControlUnit;