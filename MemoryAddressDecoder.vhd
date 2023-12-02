
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;
USE IEEE.math_real.ALL;

ENTITY MemoryAddressDecoder IS
    PORT (
        ALU_Res : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Prev_SP : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Push : IN STD_LOGIC;
        WB_INT : IN STD_LOGIC;
        RST : IN STD_LOGIC;
        Address_out : OUT STD_LOGIC_VECTOR(11 DOWNTO 0));
END MemoryAddressDecoder;

ARCHITECTURE MemoryAddressDecoderArch OF MemoryAddressDecoder IS
BEGIN
    PROCESS (ALU_Res, Prev_SP, Push, WB_INT, RST)
    BEGIN
        IF (RST = '1') THEN
            Address_out <= (OTHERS => ('0'));
        ELSIF WB_INT = '1' THEN
            Address_out <= "000000000010";
        ELSIF Push = '1' THEN
            Address_out <= Prev_SP(11 DOWNTO 0);
        ELSE
            Address_out <= ALU_Res(11 DOWNTO 0);
        END IF;
    END PROCESS;

END MemoryAddressDecoderArch;