LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;
USE IEEE.math_real.ALL;

ENTITY RegFileDecoder IS
    PORT (
        Rdst, RSrc1, RExec : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        SingleOp, Swap : IN STD_LOGIC;
        Reg1 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END RegFileDecoder;

-- There is no scenario in which both SingleOp and Swap are equal to 1 -- Sike!

ARCHITECTURE RegFileDecoderArch OF RegFileDecoder IS
BEGIN
    PROCESS (Rdst, RSrc1, RExec, SingleOp, Swap)
    BEGIN
        IF SingleOp = '0' AND Swap = '0' THEN
            Reg1 <= RSrc1;
        ELSIF Swap = '1' THEN
            Reg1 <= RExec;
        ELSIF SingleOp = '1' THEN
            Reg1 <= Rdst;
        ELSE -- will never happen
            Reg1 <= Rsrc1;
        END IF;
    END PROCESS;
END RegFileDecoderArch;