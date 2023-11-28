library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;   
use std.textio.all;
use ieee.std_logic_textio.all;
use IEEE.math_real.all;

ENTITY Memory IS
    GENERIC(
        bus_width: INTEGER:=16;
        address_width: INTEGER:=12; 
        slot_width: INTEGER:=16
    );
    PORT (CLK: IN STD_LOGIC;
          RST: IN STD_LOGIC;
          WR_EN: IN STD_LOGIC;
          RD_EN: IN STD_LOGIC;
          Address: IN STD_LOGIC_VECTOR(address_width-1 DOWNTO 0);
          Write_Data: IN STD_LOGIC_VECTOR (bus_width-1 DOWNTO 0);
          Read_Data: OUT STD_LOGIC_VECTOR (bus_width-1 DOWNTO 0));
END Memory;

ARCHITECTURE MemoryArch OF Memory IS 
    TYPE MEM_ARRAY IS ARRAY(2**address_width-1 DOWNTO 0) OF STD_LOGIC_VECTOR(slot_width-1 DOWNTO 0);
    SIGNAL MemoryArray:MEM_ARRAY;
BEGIN 
    PROCESS (CLK,RST)
    BEGIN 
        IF RST='1' THEN
            MemoryArray<=(OTHERS =>(OTHERS=>'U'));
        END IF;
        IF rising_edge(CLK) THEN
            IF RD_EN='1' THEN
                rddata: FOR i IN 0 TO (bus_width/slot_width-1) loop
                    Read_Data((i+1)*slot_width-1 DOWNTO (i)*slot_width)<=MemoryArray(to_integer(unsigned(Address))+i);
                END LOOP rddata;
            END IF;
            IF WR_EN='1' THEN
                wrdata: FOR i IN 0 TO (bus_width/slot_width-1) loop
                    MemoryArray(to_integer(unsigned(Address))+i)<=Write_Data((i+1)*slot_width-1 DOWNTO (i)*slot_width);
                END LOOP wrdata;
            END IF;
        END IF;
    END PROCESS;             
END MemoryArch;