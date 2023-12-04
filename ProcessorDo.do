force -freeze sim:/processor/CLK 1 0, 0 {100 ps} -r 200
force -freeze sim:/processor/RST 0 0
force -freeze sim:/processor/INT 0 0
force -freeze sim:/processor/Init 0 0
force -freeze sim:/processor/In_Inst 10#0 0
force -freeze sim:/processor/PC_Init 0 0
force -freeze sim:/processor/Write_Data 10#0 0
force -freeze sim:/processor/RST_Reg 0 0
force -freeze sim:/processor/RTI_ID 0 0
force -freeze sim:/processor/Register_Write_ID 1 0
force -freeze sim:/processor/Branch_ID 0 0
force -freeze sim:/processor/Immediate_ID 0 0
force -freeze sim:/processor/Mem_Read_ID 0 0
force -freeze sim:/processor/Mem_Write_ID 0 0
force -freeze sim:/processor/Mem_2Reg_ID 0 0
force -freeze sim:/processor/Port_Write_ID 0 0
force -freeze sim:/processor/Port_Read_ID 0 0
force -freeze sim:/processor/Protect_Write_ID 0 0
force -freeze sim:/processor/Protect_Val_ID 0 0
force -freeze sim:/processor/Write_Flag_ID 1 0
force -freeze sim:/processor/Stack_ID 0 0
force -freeze sim:/processor/Push_ID 0 0
force -freeze sim:/processor/Call_ID 0 0
force -freeze sim:/processor/Mem_2PC_ID 0 0
force -freeze sim:/processor/Swap_ID 0 0
force -freeze sim:/processor/RST_ID 0 0
force -freeze sim:/processor/INT_ID 0 0
force -freeze sim:/processor/Push_INT_PC_ID 0 0
force -freeze sim:/processor/Read_Data1_ID 10#15 0
force -freeze sim:/processor/Read_Data2_ID 10#20 0
force -freeze sim:/processor/INC_PC_ID 10#0 0
force -freeze sim:/processor/Op_Code_ID 00011 0
force -freeze sim:/processor/Rdst_ID 111 0
force -freeze sim:/processor/Rsrc1_ID 011 0
force -freeze sim:/processor/Rsrc2_ID 010 0
force -freeze sim:/processor/Rdst_WB 000 0
force -freeze sim:/processor/Register_Write_WB 0 0
force -freeze sim:/processor/RTI_WB 0 0
force -freeze sim:/processor/Memory_Data_WB 10#0 0
force -freeze sim:/processor/EA 10#0 0
force -freeze sim:/processor/Immediate_Val_ID 10#0 0
run
run
run
run
run
force -freeze sim:/processor/Op_Code_ID 10111 0
force -freeze sim:/processor/Immediate_ID 1 0
force -freeze sim:/processor/Immediate_Val_ID 10#1 0
run
run
force -freeze sim:/processor/Op_Code_ID 00101 0
force -freeze sim:/processor/Immediate_ID 0 0
run
run
force -freeze sim:/processor/RST_ID 1 0
run
run
force -freeze sim:/processor/Op_Code_ID 11001 0
force -freeze sim:/processor/Push_ID 1 0
force -freeze sim:/processor/Stack_ID 1 0
force -freeze sim:/processor/Write_Flag_ID 0 0
force -freeze sim:/processor/Register_Write_ID 0 0
run
run
force -freeze sim:/processor/RST_ID 0 0
run
run
run
run
force -freeze sim:/processor/Op_Code_ID 01001 0
run
run
run
run
force -freeze sim:/processor/Op_Code_ID 00110 0
force -freeze sim:/processor/Stack_ID 0 0
force -freeze sim:/processor/Push_ID 0 0
run
run
run
run
