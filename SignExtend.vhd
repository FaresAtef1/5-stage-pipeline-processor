library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;   
use std.textio.all;
use ieee.std_logic_textio.all;
use IEEE.math_real.all;

ENTITY SignExtend IS
    PORT (data_in: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
          data_out: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END SignExtend;

ARCHITECTURE SignExtendArch OF SignExtend IS 
BEGIN 
    data_out(31 DOWNTO 16)<=(OTHERS=>data_in(15));  
    data_out(15 DOWNTO 0)<=data_in;
END SignExtendArch;