library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY FullAdder is 
	port(A,B,C: IN Std_logic;S,Cout:OUT std_logic);
END ENTITY FullAdder;


ARCHITECTURE Arch of FullAdder is
Signal s1:std_logic;
begin
	s1 <= A XOR B;
	S <= s1 XOR C;
	Cout <= (A AND B) XOR (s1 AND C );
	




end Arch;
