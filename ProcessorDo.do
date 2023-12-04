add wave -position insertpoint  \
sim:/processor/CLK \
sim:/processor/RST \
sim:/processor/INT \
sim:/processor/Init \
sim:/processor/In_Inst \
sim:/processor/PC_Init \
sim:/processor/Write_Data \
sim:/processor/RST_Reg \
sim:/processor/RTI_ID \
sim:/processor/Register_Write_ID \
sim:/processor/Branch_ID \
sim:/processor/Immediate_ID \
sim:/processor/Mem_Read_ID \
sim:/processor/Mem_Write_ID \
sim:/processor/Mem_2Reg_ID \
sim:/processor/Port_Write_ID \
sim:/processor/Port_Read_ID \
sim:/processor/Protect_Write_ID \
sim:/processor/Protect_Val_ID \
sim:/processor/Write_Flag_ID \
sim:/processor/Stack_ID \
sim:/processor/Push_ID \
sim:/processor/Call_ID \
sim:/processor/Mem_2PC_ID \
sim:/processor/Swap_ID \
sim:/processor/RST_ID \
sim:/processor/INT_ID \
sim:/processor/Push_INT_PC_ID \
sim:/processor/Read_Data1_ID \
sim:/processor/Read_Data2_ID \
sim:/processor/INC_PC_ID \
sim:/processor/Op_Code_ID \
sim:/processor/Rdst_ID \
sim:/processor/Rsrc1_ID \
sim:/processor/Rsrc2_ID \
sim:/processor/RTI_EX \
sim:/processor/Register_Write_EX \
sim:/processor/Branch_EX \
sim:/processor/Immediate_EX \
sim:/processor/Mem_Read_EX \
sim:/processor/Mem_Write_EX \
sim:/processor/Mem_2Reg_EX \
sim:/processor/Port_Write_EX \
sim:/processor/Port_Read_EX \
sim:/processor/Protect_Write_EX \
sim:/processor/Write_Flag_EX \
sim:/processor/Stack_EX \
sim:/processor/Push_EX \
sim:/processor/Call_EX \
sim:/processor/Mem_2PC_EX \
sim:/processor/Swap_EX \
sim:/processor/RST_EX \
sim:/processor/INT_EX \
sim:/processor/Push_INT_PC_EX \
sim:/processor/Rdst_EX \
sim:/processor/Rsrc1_EX \
sim:/processor/Rsrc2_EX \
sim:/processor/Flags_EX \
sim:/processor/Read_Data1_EX \
sim:/processor/Read_Data2_EX \
sim:/processor/INC_PC_EX \
sim:/processor/Stack_Pointer_EX \
sim:/processor/ALU_Result_EX \
sim:/processor/Memory_Data_EX \
sim:/processor/Op_Code_EX \
sim:/processor/Protect_Val_EX \
sim:/processor/Protect_State_EX \
sim:/processor/RTI_MEM \
sim:/processor/Register_Write_MEM \
sim:/processor/Mem_2PC_MEM \
sim:/processor/Mem_2Reg_MEM \
sim:/processor/Push_MEM \
sim:/processor/Stack_MEM \
sim:/processor/Push_INT_PC_MEM \
sim:/processor/Call_MEM \
sim:/processor/Mem_Write_MEM \
sim:/processor/Mem_Read_MEM \
sim:/processor/Branch_MEM \
sim:/processor/Port_Write_MEM \
sim:/processor/Port_Read_MEM \
sim:/processor/RST_MEM \
sim:/processor/INT_MEM \
sim:/processor/Protect_State_MEM \
sim:/processor/Stack_Pointer_MEM \
sim:/processor/INC_PC_MEM \
sim:/processor/ALU_Result_MEM \
sim:/processor/Memory_Data_MEM \
sim:/processor/Rdst_MEM \
sim:/processor/Flags_MEM \
sim:/processor/Rdst_WB \
sim:/processor/Register_Write_WB \
sim:/processor/RTI_WB \
sim:/processor/Memory_Data_WB \
sim:/processor/EA \
sim:/processor/Immediate_Val_ID
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
force -freeze sim:/processor/Immediate_Val_ID 10#0 
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