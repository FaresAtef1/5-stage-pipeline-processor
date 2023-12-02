LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;
USE IEEE.math_real.ALL;

ENTITY PCDecoder IS
    PORT (
        Rds : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        memory : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        PC_inc : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        correct_branch : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        call : IN STD_LOGIC;
        mem_to_PC : IN STD_LOGIC;
        prediction : IN STD_LOGIC;
        branch : IN STD_LOGIC;
        wrong_pred : IN STD_LOGIC;
        prev_branch : IN STD_LOGIC;
        PC_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END PCDecoder;

ARCHITECTURE PCDecoderArch OF PCDecoder IS
BEGIN
    PROCESS (Rds, correct_branch, memory, PC_inc, call, mem_to_PC, prediction, branch, wrong_pred, prev_branch)
    BEGIN
        IF (call = '1') OR (branch = '1' AND prediction = '1') THEN
            PC_out <= Rds;
        ELSIF mem_to_PC = '1' THEN
            PC_out <= memory;
        ELSIF wrong_pred = '1' AND prev_branch = '1' THEN
            PC_out <= correct_branch;
        ELSE
            PC_OUT <= PC_inc;
        END IF;
    END PROCESS;

END PCDecoderArch;