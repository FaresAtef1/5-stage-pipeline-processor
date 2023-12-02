LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;
USE IEEE.math_real.ALL;
USE IEEE.STD_LOGIC_MISC.ALL;
ENTITY Rotate IS PORT (
    Data : IN STD_LOGIC_VECTOR(32 DOWNTO 0);
    Amount : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    Enable : IN STD_LOGIC;
    Direction : IN STD_LOGIC;
    RData : OUT STD_LOGIC_VECTOR(32 DOWNTO 0));

END Rotate;

ARCHITECTURE RotateArch OF Rotate IS
BEGIN
    PROCESS (Data, Amount, Direction)
    BEGIN
        IF (Amount /= x"00000000" AND Enable='1') THEN
            IF (Direction = '0') THEN
                RData <= Data(32 - to_integer(unsigned(Amount)) DOWNTO 0) & Data(32 DOWNTO 32 - to_integer(unsigned(Amount)) + 1);
            ELSE
                RData <= Data(to_integer(unsigned(Amount)) - 1 DOWNTO 0) & Data(32 DOWNTO to_integer(unsigned(Amount)));
            END IF;
        ELSE
            RData <= Data;
        END IF;
    END PROCESS;

END RotateArch;