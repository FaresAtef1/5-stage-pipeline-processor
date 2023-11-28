LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;
USE IEEE.math_real.ALL;
USE IEEE.STD_LOGIC_MISC.ALL;
ENTITY ALU IS
    PORT (
        Cin : IN STD_LOGIC;
        Sel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        Reg1, Reg2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Flags : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );

END ALU;
ARCHITECTURE ALUArch OF ALU IS
    COMPONENT Adder IS
        GENERIC (n : INTEGER := 8);
        PORT (
            First, Second : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            CarryIn : STD_LOGIC;
            Sum : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            CarryOut : OUT STD_LOGIC);
    END COMPONENT Adder;
    COMPONENT Rotate IS PORT (
        Data : IN STD_LOGIC_VECTOR(32 DOWNTO 0);
        Amount : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Direction : IN STD_LOGIC;
        RData : OUT STD_LOGIC_VECTOR(32 DOWNTO 0));
    END COMPONENT Rotate;

    SIGNAL TempA, TempB, TempOut : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL TempCin, TempCout : STD_LOGIC;
    SIGNAL TempResult : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Temp : STD_LOGIC_VECTOR(32 DOWNTO 0) ;
    SIGNAL RotateDirction : STD_LOGIC;
    SIGNAL RotateOut : STD_LOGIC_VECTOR(32 DOWNTO 0);
BEGIN
    Temp <=Cin & Reg1;
    u0 : Adder GENERIC MAP(32) PORT MAP(TempA, TempB, TempCin, TempOut, TempCout);
    r0 : Rotate PORT MAP(Temp, Reg2, RotateDirction, RotateOut);
    PROCESS (Cin, Sel, Reg1, Reg2, TempOut,RotateOut)
    BEGIN
        IF Sel = "0000" THEN --passing the first operand
            TempResult <= Reg1;
            Flags(2) <= Cin;
        ELSIF Sel = "0001" THEN --passing the second operand
            TempResult <= Reg2;
            Flags(2) <= Cin;
        ELSIF Sel = "0010" THEN -- A+B
            TempA <= Reg1;
            TempB <= Reg2;
            TempCin <= '0';
            TempResult <= TempOut;
            Flags(2) <= TempCout;
        ELSIF Sel = "0011" THEN -- A-B
            TempA <= Reg1;
            TempB <= NOT Reg2;
            TempCin <= '1';
            TempResult <= TempOut;
            Flags(2) <= TempCout;
        ELSIF Sel = "0100" THEN -- A AND B
            TempResult <= Reg1 AND Reg2;
            Flags(2) <= Cin;
        ELSIF Sel = "0101" THEN -- A OR B
            TempResult <= Reg1 OR Reg2;
            Flags(2) <= Cin;
        ELSIF Sel = "0110" THEN -- A XOR B
            TempResult <= Reg1 XOR Reg2;
            Flags(2) <= Cin;
        ELSIF Sel = "0111" THEN -- NOT A
            TempResult <= NOT Reg1;
            Flags(2) <= Cin;
        ELSIF Sel = "1000" THEN -- Negative A
            TempA <= (OTHERS => '0');
            TempB <= NOT Reg1;
            TempCin <= '1';
            TempResult <= TempOut;
            Flags(2) <= TempCout;
        ELSIF Sel = "1001" THEN -- A+1
            TempA <= Reg1;
            TempB <= (OTHERS => '0');
            TempB(0) <= '1';
            TempCin <= '0';
            TempResult <= TempOut;
            Flags(2) <= TempCout;
        ELSIF Sel = "1010" THEN -- A-1
            TempA <= Reg1;
            TempB <= (OTHERS => '1');
            TempCin <= '0';
            TempResult <= TempOut;
            Flags(2) <= TempCout;
        ELSIF Sel = "1011" THEN -- RCL -- assume that the value of Reg2 betwenn 0 and 32
            RotateDirction <= '0';
            TempResult <= RotateOut(31 DOWNTO 0);
            Flags(2) <= RotateOut(32);
        ELSIF Sel = "1100" THEN -- RCR
            RotateDirction <= '1';
            TempResult <= RotateOut(31 DOWNTO 0);
            Flags(2) <= RotateOut(32);
        ELSIF Sel = "1101" THEN -- BitSet
            Flags(2) <= Reg1(to_integer(unsigned(Reg2)));
            TempResult <= Reg1;
            TempResult(to_integer(unsigned(Reg2))) <= '1';
        ELSE
            TempResult <= (OTHERS => '0');
            Flags(2) <= Cin;
        END IF;
    END PROCESS;
    Result <= TempResult;
    Flags(1) <= TempResult(31); -- Negative Flag
    Flags(0) <= (NOT OR_REDUCE(TempResult)); --Zero Flag
END ALUArch;