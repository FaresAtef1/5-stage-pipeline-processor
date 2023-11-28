library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;   
use std.textio.all;
use ieee.std_logic_textio.all;

ENTITY RegFile IS
    PORT (CLK: IN STD_LOGIC;
          RESET: IN STD_LOGIC;
          Reg1_Num, Reg2_Num, Write_Reg: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
          Write_Data: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
          Reg1_Data, Reg2_Data: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
END RegFile;

ARCHITECTURE ArchRegFile OF RegFile IS
    TYPE REG_ARRAY IS ARRAY(7 DOWNTO 0) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL R : REG_ARRAY;
BEGIN
    PROCESS (CLK, RESET)
    BEGIN
        IF RESET = '1' THEN
            FOR i IN 0 TO 7 LOOP
                R(i) <= (OTHERS => '0');
            END LOOP;
            REG1_DATA <= (OTHERS => '0');
            REG2_DATA <= (OTHERS => '0');
        ELSIF RISING_EDGE(CLK) THEN
            R(to_integer(unsigned(Write_Reg))) <=write_data;
        ELSE
            Reg1_Data <= R(to_integer(unsigned(Reg1_Num)));
            Reg2_Data <= R(to_integer(unsigned(Reg2_Num)));
        END IF; 
    END PROCESS; 
END ArchRegFile;