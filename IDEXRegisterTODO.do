add wave -position insertpoint  \
sim:/idexregister/RST_Reg \
sim:/idexregister/Clk \
sim:/idexregister/Register_Write \
sim:/idexregister/Branch \
sim:/idexregister/Immediate \
sim:/idexregister/Mem_Read \
sim:/idexregister/Mem_Write \
sim:/idexregister/Mem_2Reg \
sim:/idexregister/Port_Write \
sim:/idexregister/Port_Read \
sim:/idexregister/Protect_Write \
sim:/idexregister/Protect_Val \
sim:/idexregister/Write_Flag \
sim:/idexregister/Stack \
sim:/idexregister/Push \
sim:/idexregister/Call \
sim:/idexregister/Mem_2PC \
sim:/idexregister/Swap \
sim:/idexregister/RTI \
sim:/idexregister/RST \
sim:/idexregister/INT \
sim:/idexregister/Read_Data1 \
sim:/idexregister/Read_Data2 \
sim:/idexregister/Op_Code \
sim:/idexregister/Rdst \
sim:/idexregister/Rsrc1 \
sim:/idexregister/Rsrc2 \
sim:/idexregister/INC_PC \
sim:/idexregister/Register_Write_Out \
sim:/idexregister/Branch_Out \
sim:/idexregister/Immediate_Out \
sim:/idexregister/Mem_Read_Out \
sim:/idexregister/Mem_Write_Out \
sim:/idexregister/Mem_2Reg_Out \
sim:/idexregister/Port_Write_Out \
sim:/idexregister/Port_Read_Out \
sim:/idexregister/Protect_Write_Out \
sim:/idexregister/Protect_Val_Out \
sim:/idexregister/Write_Flag_Out \
sim:/idexregister/Stack_Out \
sim:/idexregister/Push_Out \
sim:/idexregister/Call_Out \
sim:/idexregister/Mem_2PC_Out \
sim:/idexregister/Swap_Out \
sim:/idexregister/RTI_Out \
sim:/idexregister/RST_Out \
sim:/idexregister/INT_Out \
sim:/idexregister/Read_Data1_Out \
sim:/idexregister/Read_Data2_Out \
sim:/idexregister/Op_Code_Out \
sim:/idexregister/Rdst_Out \
sim:/idexregister/Rsrc1_Out \
sim:/idexregister/Rsrc2_Out \
sim:/idexregister/INC_PC_Out
force -freeze sim:/idexregister/Clk 1 0, 0 {100 ps} -r 200
force -freeze sim:/idexregister/RST_Reg 1 0
run
force -freeze sim:/idexregister/RST_Reg 0 0
force -freeze sim:/idexregister/Register_Write 0 0
force -freeze sim:/idexregister/Branch 1 0
force -freeze sim:/idexregister/Immediate 0 0
force -freeze sim:/idexregister/Mem_Read 1 0
force -freeze sim:/idexregister/Mem_Write 0 0
force -freeze sim:/idexregister/Mem_2Reg 1 0
force -freeze sim:/idexregister/Port_Write 0 0
force -freeze sim:/idexregister/Port_Read 1 0
force -freeze sim:/idexregister/Protect_Write 0 0
force -freeze sim:/idexregister/Protect_Val 1 0
force -freeze sim:/idexregister/Write_Flag 0 0
force -freeze sim:/idexregister/Stack 1 0
force -freeze sim:/idexregister/Push 0 0
force -freeze sim:/idexregister/Call 1 0
force -freeze sim:/idexregister/Mem_2PC 0 0
force -freeze sim:/idexregister/Swap 1 0
force -freeze sim:/idexregister/RTI 0 0
force -freeze sim:/idexregister/RST 1 0
force -freeze sim:/idexregister/INT 0 0
force -freeze sim:/idexregister/Read_Data1 10#10 0
force -freeze sim:/idexregister/Read_Data2 10#20 0
force -freeze sim:/idexregister/Op_Code 11011 0
force -freeze sim:/idexregister/Rdst 110 0
force -freeze sim:/idexregister/Rsrc1 011 0
force -freeze sim:/idexregister/Rsrc2 101 0
force -freeze sim:/idexregister/INC_PC 10#30 0
run
run
force -freeze sim:/idexregister/Register_Write 1 0
force -freeze sim:/idexregister/Branch 0 0
force -freeze sim:/idexregister/Immediate 1 0
force -freeze sim:/idexregister/Mem_Read 0 0
force -freeze sim:/idexregister/Mem_Write 1 0
force -freeze sim:/idexregister/Mem_2Reg 0 0
force -freeze sim:/idexregister/Port_Write 1 0
force -freeze sim:/idexregister/Port_Read 0 0
force -freeze sim:/idexregister/Protect_Write 1 0
force -freeze sim:/idexregister/Protect_Val 0 0
force -freeze sim:/idexregister/Write_Flag 1 0
force -freeze sim:/idexregister/Stack 0 0
force -freeze sim:/idexregister/Push 1 0
force -freeze sim:/idexregister/Call 0 0
force -freeze sim:/idexregister/Mem_2PC 1 0
force -freeze sim:/idexregister/Swap 0 0
force -freeze sim:/idexregister/RTI 1 0
force -freeze sim:/idexregister/RST 0 0
force -freeze sim:/idexregister/INT 1 0
force -freeze sim:/idexregister/Read_Data1 10#50 0
force -freeze sim:/idexregister/Read_Data2 10#70 0
force -freeze sim:/idexregister/Op_Code 00100 0
force -freeze sim:/idexregister/Rdst 000 0
force -freeze sim:/idexregister/Rsrc1 001 0
force -freeze sim:/idexregister/Rsrc2 111 0
force -freeze sim:/idexregister/INC_PC 10#500 0
run
run