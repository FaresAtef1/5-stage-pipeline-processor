LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY ALUControlUnit IS
    PORT (
        OpCode : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        ALUOP : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Push_INT_PC_EX : IN STD_LOGIC;
        Push_INT_PC_Mem : IN STD_LOGIC
    );

END ALUControlUnit;

ARCHITECTURE ALUControlUnitArch OF ALUControlUnit IS
BEGIN
    -- WITH OpCode SELECT
    --     ALUOP <=
    --     "0000" WHEN "00000", -- NOP
    --     "0000" WHEN "00001", -- IN
    --     "0000" WHEN "00010", -- SWAP
    --     "0010" WHEN "00011", -- ADD
    --     "0010" WHEN "00100", -- ADDI
    --     "0011" WHEN "00101", -- SUB
    --     "0100" WHEN "00110", -- AND
    --     "0101" WHEN "00111", -- OR
    --     "0110" WHEN "01000", -- XOR
    --     "1110" WHEN "01001", -- pop
    --     "0001" WHEN "01010", -- LDM
    --     "0001" WHEN "01011", -- LDD
    --     "1110" WHEN "01100", -- RET
    --     "1110" WHEN "01101", -- RTI
    --     "0111" WHEN "10000",
    --     "1000" WHEN "10001",
    --     "1001" WHEN "10010",
    --     "1010" WHEN "10011",
    --     "0000" WHEN "10100",
    --     "0011" WHEN "10101", -- CMP
    --     "1101" WHEN "10110", -- BITSET
    --     "1011" WHEN "10111", -- RCL
    --     "1100" WHEN "11000", -- RCR
    --     "1111" WHEN "11001", -- PUSH
    --     "0001" WHEN "11010", -- STD
    --     "0000" WHEN "11011", -- PROTECT
    --     "0000" WHEN "11100", -- FREE
    --     "0000" WHEN "11101", -- JZ
    --     "0000" WHEN "11110", -- JMP
    --     "1111" WHEN "11111", -- CALL
    --     "0000" WHEN OTHERS;

    ALUOP <=
        "1111" WHEN Push_INT_PC_EX ='1' OR Push_INT_PC_Mem = '1' ELSE
        "0000" WHEN OpCode = "00000" ELSE-- NOP
        "0000" WHEN OpCode = "00001" ELSE-- IN
        "0000" WHEN OpCode = "00010" ELSE -- SWAP
        "0010" WHEN OpCode = "00011" ELSE -- ADD
        "0010" WHEN OpCode = "00100" ELSE -- ADDI
        "0011" WHEN OpCode = "00101" ELSE -- SUB
        "0100" WHEN OpCode = "00110" ELSE -- AND
        "0101" WHEN OpCode = "00111" ELSE -- OR
        "0110" WHEN OpCode = "01000" ELSE -- XOR
        "1110" WHEN OpCode = "01001" ELSE -- pop
        "0001" WHEN OpCode = "01010" ELSE -- LDM
        "0001" WHEN OpCode = "01011" ELSE -- LDD
        "1110" WHEN OpCode = "01100" ELSE -- RET
        "1110" WHEN OpCode = "01101" ELSE -- RTI
        "0111" WHEN OpCode = "10000" ELSE
        "1000" WHEN OpCode = "10001" ELSE
        "1001" WHEN OpCode = "10010" ELSE
        "1010" WHEN OpCode = "10011" ELSE
        "0000" WHEN OpCode = "10100" ELSE
        "0011" WHEN OpCode = "10101" ELSE -- CMP
        "1101" WHEN OpCode = "10110" ELSE -- BITSET
        "1011" WHEN OpCode = "10111" ELSE -- RCL
        "1100" WHEN OpCode = "11000" ELSE -- RCR
        "1111" WHEN OpCode = "11001" ELSE -- PUSH
        "0001" WHEN OpCode = "11010" ELSE -- STD
        "0000" WHEN OpCode = "11011" ELSE -- PROTECT
        "0000" WHEN OpCode = "11100" ELSE -- FREE
        "0000" WHEN OpCode = "11101" ELSE -- JZ
        "0000" WHEN OpCode = "11110" ELSE -- JMP
        "1111" WHEN OpCode = "11111" ELSE -- CALL
        "0000";
END ALUControlUnitArch;