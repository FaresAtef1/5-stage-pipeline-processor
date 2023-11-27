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
    type REG_ARRAY is array(7 DOWNTO 0, 31 DOWNTO 0) of STD_LOGIC;
    SIGNAL R : REG_ARRAY;

    BEGIN
    PROCESS (CLK, RESET)
    BEGIN
        IF RESET = '1' THEN
            FOR i IN 0 TO 7 LOOP
                FOR j IN 0 TO 31 LOOP
                    R(i,j) <= '0';
                END LOOP;
            END LOOP;
            REG1_DATA <= (OTHERS => '0');
            REG2_DATA <= (OTHERS => '0');
        ELSIF RISING_EDGE(CLK) THEN
            FOR i IN 0 TO 31 LOOP
                R(to_integer(unsigned(Write_Reg)),i) <=write_data(i);
            END LOOP;
        ELSE
            FOR i IN 0 TO 31 LOOP
                Reg1_Data(i) <= R(to_integer(unsigned(Reg1_Num)),i);
                Reg2_Data(i) <= R(to_integer(unsigned(Reg2_Num)),i);
            END LOOP;
        END IF; 
    END PROCESS; 
END ArchRegFile;