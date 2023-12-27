LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;

ENTITY RegFile IS
    PORT (
        Big_Reset : IN STD_LOGIC;
        CLK : IN STD_LOGIC;
        RESET, RegWrite : IN STD_LOGIC;
        Reg1_Num, Reg2_Num, Write_Reg : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Write_Data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        Reg1_Data, Reg2_Data : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        Reg0, Reg1, Reg2, Reg3, Reg4, Reg5, Reg6, Reg7 : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
END RegFile;

ARCHITECTURE ArchRegFile OF RegFile IS
    TYPE REG_ARRAY IS ARRAY(7 DOWNTO 0) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL R : REG_ARRAY;
BEGIN
    PROCESS (CLK, RESET, Write_Data, Reg1_Num, Reg2_Num, Write_Reg,Big_Reset)
    BEGIN
        IF RESET = '1'  OR Big_Reset ='1' THEN
            FOR i IN 0 TO 7 LOOP
                R(i) <= (OTHERS => '0');
            END LOOP;
            REG1_Data <= (OTHERS => '0');
            REG2_Data <= (OTHERS => '0');
        ELSIF CLK = '0' THEN
            Reg1_Data <= R(to_integer(unsigned(Reg1_Num)));
            Reg2_Data <= R(to_integer(unsigned(Reg2_Num)));
            Reg0 <= R(0);
            Reg1 <= R(1);
            Reg2 <= R(2);
            Reg3 <= R(3);
            Reg4 <= R(4);
            Reg5 <= R(5);
            Reg6 <= R(6);
            Reg7 <= R(7);
        ELSIF CLK = '1' AND RegWrite = '1' THEN
            R(to_integer(unsigned(Write_Reg))) <= write_data;
        END IF;
    END PROCESS;
END ArchRegFile;