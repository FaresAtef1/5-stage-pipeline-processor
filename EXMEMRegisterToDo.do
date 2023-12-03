add wave -position insertpoint  \
sim:/exmemregister/Clk \
sim:/exmemregister/RST_Reg \
sim:/exmemregister/RTI \
sim:/exmemregister/Register_Write \
sim:/exmemregister/Mem_2PC \
sim:/exmemregister/Mem_2Reg \
sim:/exmemregister/Push \
sim:/exmemregister/Stack \
sim:/exmemregister/Push_INT_PC \
sim:/exmemregister/Call \
sim:/exmemregister/Mem_Write \
sim:/exmemregister/Mem_Read \
sim:/exmemregister/Branch \
sim:/exmemregister/Port_Write \
sim:/exmemregister/Port_Read \
sim:/exmemregister/RST \
sim:/exmemregister/INT \
sim:/exmemregister/Stack_Pointer \
sim:/exmemregister/INC_PC \
sim:/exmemregister/ALU_Result \
sim:/exmemregister/Memory_Data \
sim:/exmemregister/Flags \
sim:/exmemregister/Rdst \
sim:/exmemregister/Rsrc1 \
sim:/exmemregister/Rsrc2 \
sim:/exmemregister/Protect_State \
sim:/exmemregister/RTI_Out \
sim:/exmemregister/Register_Write_Out \
sim:/exmemregister/Mem_2PC_Out \
sim:/exmemregister/Mem_2Reg_Out \
sim:/exmemregister/Push_Out \
sim:/exmemregister/Stack_Out \
sim:/exmemregister/Push_INT_PC_Out \
sim:/exmemregister/Call_Out \
sim:/exmemregister/Mem_Write_Out \
sim:/exmemregister/Mem_Read_Out \
sim:/exmemregister/Branch_Out \
sim:/exmemregister/Port_Write_Out \
sim:/exmemregister/Port_Read_Out \
sim:/exmemregister/RST_Out \
sim:/exmemregister/INT_Out \
sim:/exmemregister/Stack_Pointer_Out \
sim:/exmemregister/INC_PC_Out \
sim:/exmemregister/ALU_Result_Out \
sim:/exmemregister/Memory_Data_Out \
sim:/exmemregister/Flags_Out \
sim:/exmemregister/Rdst_Out \
sim:/exmemregister/Rsrc1_Out \
sim:/exmemregister/Rsrc2_Out \
sim:/exmemregister/Protect_State_Out
force -freeze sim:/exmemregister/Clk 1 0, 0 {100 ps} -r 200
force -freeze sim:/exmemregister/RST_Reg 1 0
run
force -freeze sim:/exmemregister/RST_Reg 0 0
force -freeze sim:/exmemregister/RTI 1 0
force -freeze sim:/exmemregister/Register_Write 1 0
force -freeze sim:/exmemregister/Mem_2PC 1 0
force -freeze sim:/exmemregister/Mem_2Reg 1 0
force -freeze sim:/exmemregister/Push 1 0
force -freeze sim:/exmemregister/Stack 1 0
force -freeze sim:/exmemregister/Push_INT_PC 1 0
force -freeze sim:/exmemregister/Call 1 0
force -freeze sim:/exmemregister/Mem_Write 1 0
force -freeze sim:/exmemregister/Mem_Read 1 0
force -freeze sim:/exmemregister/Branch 1 0
force -freeze sim:/exmemregister/Port_Write 1 0
force -freeze sim:/exmemregister/Port_Read 1 0
force -freeze sim:/exmemregister/RST 1 0
force -freeze sim:/exmemregister/INT 1 0
force -freeze sim:/exmemregister/Stack_Pointer 10#25 0
force -freeze sim:/exmemregister/INC_PC 10#35 0
force -freeze sim:/exmemregister/ALU_Result 10#45 0
force -freeze sim:/exmemregister/Memory_Data 10#55 0
force -freeze sim:/exmemregister/Flags 110 0
force -freeze sim:/exmemregister/Rdst 10#1 0
force -freeze sim:/exmemregister/Rsrc1 10#2 0
force -freeze sim:/exmemregister/Rsrc2 10#3 0
force -freeze sim:/exmemregister/Protect_State 1 0
run
run
run
force -freeze sim:/exmemregister/Stack_Pointer 10#65 0
run
run
run