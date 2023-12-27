LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY ALUControlUnit IS PORT (
    RTI_Mem : IN STD_LOGIC;
    OpCode : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    ALUOP : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
);

END ALUControlUnit;

ARCHITECTURE ALUControlUnitArch OF ALUControlUnit IS
    SIGNAL OpCodeTemp : STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN
    WITH OpCodeTemp SELECT
        ALUOP <=
        "0000" WHEN "00000", -- NOP
        "0000" WHEN "00001", -- IN
        "0000" WHEN "00010", -- SWAP
        "0010" WHEN "00011", -- ADD
        "0010" WHEN "00100", -- ADDI
        "0011" WHEN "00101", -- SUB
        "0100" WHEN "00110", -- AND
        "0101" WHEN "00111", -- OR
        "0110" WHEN "01000", -- XOR
        "1110" WHEN "01001", -- pop
        "0001" WHEN "01010", -- LDM
        "0001" WHEN "01011", -- LDD
        "1110" WHEN "01100", -- RET
        "1110" WHEN "01101", -- RTI
        "0111" WHEN "10000",
        "1000" WHEN "10001",
        "1001" WHEN "10010",
        "1010" WHEN "10011",
        "0000" WHEN "10100",
        "0011" WHEN "10101", -- CMP
        "1101" WHEN "10110", -- BITSET
        "1011" WHEN "10111", -- RCL
        "1100" WHEN "11000", -- RCR
        "1111" WHEN "11001", -- PUSH
        "0001" WHEN "11010", -- STD
        "0000" WHEN "11011", -- PROTECT
        "0000" WHEN "11100", -- FREE
        "0000" WHEN "11101", -- JZ
        "0000" WHEN "11110", -- JMP
        "1111" WHEN "11111", -- CALL
        "0000" WHEN OTHERS;

    OpCodeTemp <= OpCode WHEN RTI_Mem = '0' ELSE
        "01101";

END ALUControlUnitArch;