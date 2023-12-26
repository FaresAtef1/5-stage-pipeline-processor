LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;
USE IEEE.math_real.ALL;

ENTITY PCDecoder IS
    PORT (
        Rds : IN STD_LOGIC_VECTOR(31 DOWNTO 0); --Rdst_Exec
        memory : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        PC_inc : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Rdst_Mem : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        call : IN STD_LOGIC;
        Zero_Flag : IN STD_LOGIC;
        mem_to_PC : IN STD_LOGIC;
        branch : IN STD_LOGIC;
        Branch_Mem : IN STD_LOGIC;
        PC_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END PCDecoder;

ARCHITECTURE PCDecoderArch OF PCDecoder IS
BEGIN
    PROCESS (Rds, Rdst_Mem, memory, PC_inc, call, mem_to_PC, branch, Branch_Mem, Zero_Flag)
    BEGIN
        IF mem_to_PC = '1' THEN
            PC_out <= memory;
        ELSIF Zero_Flag = '1' AND Branch_Mem = '1' THEN
            PC_out <= Rdst_Mem;
        ELSIF call = '1' THEN
            PC_out <= Rds;
        ELSE
            PC_OUT <= PC_inc;
        END IF;
    END PROCESS;

END PCDecoderArch;