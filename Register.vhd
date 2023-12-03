LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY GenericRegister IS
    GENERIC (
        Size : INTEGER := 32
    );
    PORT (
        WR_EN : IN STD_LOGIC;
        RST : IN STD_LOGIC;
        Data : IN STD_LOGIC_VECTOR(Size - 1 DOWNTO 0);
        RST_Val : IN STD_LOGIC_VECTOR(Size-1 DOWNTO 0);
        Reg_Out : OUT STD_LOGIC_VECTOR(Size - 1 DOWNTO 0)
    );

END GenericRegister;

ARCHITECTURE ArchGenericRegister OF GenericRegister IS
BEGIN
Reg_Out <= 
            RST_Val WHEN RST='1' ELSE
            Data WHEN WR_EN='1' ;

END ArchGenericRegister;