LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY CU IS
    PORT (
        Op_Code : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
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
        RTI : OUT STD_LOGIC
    );
END ENTITY CU;

ARCHITECTURE ArchCU OF CU IS

    SIGNAL CU_Signals : STD_LOGIC_VECTOR(16 DOWNTO 0);
BEGIN

    Register_Write <= CU_Signals(16);
    Branch <= CU_Signals(15);
    Immediate <= CU_Signals(14);
    Mem_Read <= CU_Signals(13);
    Mem_Write <= CU_Signals(12);
    Mem_2Reg <= CU_Signals(11);
    Port_Write <= CU_Signals(10);
    Port_Read <= CU_Signals(9);
    Protect_Write <= CU_Signals(8);
    Protect_Val <= CU_Signals(7);
    Write_Flag <= CU_Signals(6);
    Stack <= CU_Signals(5);
    Push <= CU_Signals(4);
    Call <= CU_Signals(3);
    Mem_2PC <= CU_Signals(2);
    SWAP <= CU_Signals(1);
    RTI <= CU_Signals(0);

    CU_Signals <=

        "00000000000000000" WHEN Op_Code = "00000" ELSE --NOP
        "10000000001000000" WHEN Op_Code = "10000" ELSE --NOT
        "10000000001000000" WHEN Op_Code = "10001" ELSE --NEG
        "10000000001000000" WHEN Op_Code = "10010" ELSE --INC
        "10000000001000000" WHEN Op_Code = "10011" ELSE --DEC
        "00000010000000000" WHEN Op_Code = "10100" ELSE --OUT
        "10000001000000000" WHEN Op_Code = "00001" ELSE --IN
        "10000000000000010" WHEN Op_Code = "00010" ELSE --SWAP
        "10000000001000000" WHEN Op_Code = "00010" ELSE --ADD
        "10100000001000000" WHEN Op_Code = "00010" ELSE --ADDI
        "10000000001000000" WHEN Op_Code = "00010" ELSE --SUB
        "10000000001000000" WHEN Op_Code = "00010" ELSE --AND
        "10000000001000000" WHEN Op_Code = "00010" ELSE --OR
        "10000000001000000" WHEN Op_Code = "00010" ELSE --XOR
        "00000000001000000" WHEN Op_Code = "00010" ELSE --CMP
        "10100000001000000" WHEN Op_Code = "00010" ELSE --BITSET
        "10100000001000000" WHEN Op_Code = "00010" ELSE --RCL
        "10100000001000000" WHEN Op_Code = "00010" ELSE --RCR
        "00001000000110000" WHEN Op_Code = "00010" ELSE --PUSH
        "10010100000100000" WHEN Op_Code = "00010" ELSE --POP
        "10100000001000000" WHEN Op_Code = "00010" ELSE --LDM
        "10110100000000000" WHEN Op_Code = "00010" ELSE --LDD
        "00101000000000000" WHEN Op_Code = "00010" ELSE --STD
        "00000000110000000" WHEN Op_Code = "00010" ELSE --PROTECT
        "00000000100000000" WHEN Op_Code = "00010" ELSE --FREE
        "01000000000000000" WHEN Op_Code = "00010" ELSE --JZ - NOT FULLY IMPLEMENTED
        "01000000000000000" WHEN Op_Code = "00010" ELSE --JMP
        "00001000000100000" WHEN Op_Code = "00010" ELSE --CALL --NOT FINISHED (2 Cycles to push)
        "10000000000000010" WHEN Op_Code = "00010" ELSE --RET --NOT FINISHED (2 Cycles to pop)
        "10000000000000010" WHEN Op_Code = "00010" ELSE --RTI --NOT FINISHED (2 Cycles to pop)

    END ArchCU;