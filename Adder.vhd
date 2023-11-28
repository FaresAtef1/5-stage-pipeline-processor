library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY Adder is
	GENERIC (n: integer := 8);
	PORT(First,Second: IN std_logic_vector(n-1 downto 0);CarryIn : std_logic;Sum:OUT std_logic_vector(n-1 downto 0);CarryOut: OUT std_logic);
END ENTITY Adder;


ARCHITECTURE Arch_Adder of Adder is
COMPONENT FullAdder is
	 port(A,B,C:IN std_logic;S,Cout:OUT std_logic);
end component ;
Signal temp: std_logic_vector(n downto 0);
begin
temp(0) <= CarryIn;
Loop1: FOR i IN 0 to n-1 GENERATE
	comp : FullAdder port map(First(i),Second(i),temp(i),Sum(i),temp(i+1));
	END GENERATE;

CarryOut <= temp(n);



END Arch_Adder;
