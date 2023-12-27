LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;
USE IEEE.math_real.ALL;

ENTITY WriteDataDecoder IS
    PORT (
        R1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        PC_inc : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Flags : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Push_INT_PC : IN STD_LOGIC;
        Push_INT_PC_WB : IN STD_LOGIC;
        Call : IN STD_LOGIC;
        write_data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END WriteDataDecoder;

ARCHITECTURE WriteDataDecoderArch OF WriteDataDecoder IS
BEGIN
    PROCESS (R1, PC_inc, Flags, Push_INT_PC, Push_INT_PC_WB, Call)
    BEGIN
        
        IF (Call = '1' OR Push_INT_PC = '1') THEN
            write_data_out <= PC_inc ;
        ELSIF Push_INT_PC_WB = '1' THEN
            write_data_out <= ("00000000000000000000000000000") & Flags(2 DOWNTO 0) ;
        ELSE
            write_data_out <= R1 ;
        END IF;
    END PROCESS;

END WriteDataDecoderArch;