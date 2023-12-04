add wave -position insertpoint  \
sim:/memwbregister/Clk \
sim:/memwbregister/RST_Reg \
sim:/memwbregister/RTI \
sim:/memwbregister/Register_Write \
sim:/memwbregister/Mem_2PC \
sim:/memwbregister/Mem_2Reg \
sim:/memwbregister/Push_INT_PC \
sim:/memwbregister/Port_Read \
sim:/memwbregister/RST \
sim:/memwbregister/INT \
sim:/memwbregister/Port_Val \
sim:/memwbregister/Memory_Data \
sim:/memwbregister/ALU_Result \
sim:/memwbregister/Rdst \
sim:/memwbregister/RTI_Out \
sim:/memwbregister/Register_Write_Out \
sim:/memwbregister/Mem_2PC_Out \
sim:/memwbregister/Mem_2Reg_Out \
sim:/memwbregister/Push_INT_PC_Out \
sim:/memwbregister/Port_Read_Out \
sim:/memwbregister/RST_Out \
sim:/memwbregister/INT_Out \
sim:/memwbregister/Port_Val_Out \
sim:/memwbregister/Memory_Data_Out \
sim:/memwbregister/ALU_Result_Out \
sim:/memwbregister/Rdst_Out
force -freeze sim:/memwbregister/Clk 1 0, 0 {100 ps} -r 200
force -freeze sim:/memwbregister/RST_Reg 1 0
run
force -freeze sim:/memwbregister/RST_Reg 0 0
force -freeze sim:/memwbregister/RTI 1 0
force -freeze sim:/memwbregister/Register_Write 0 0
force -freeze sim:/memwbregister/Mem_2PC 1 0
force -freeze sim:/memwbregister/Mem_2Reg 0 0
force -freeze sim:/memwbregister/Push_INT_PC 1 0
force -freeze sim:/memwbregister/Port_Read 0 0
force -freeze sim:/memwbregister/RST 1 0
force -freeze sim:/memwbregister/INT 0 0
force -freeze sim:/memwbregister/Port_Val 10#20 0
force -freeze sim:/memwbregister/Memory_Data 10#30 0
force -freeze sim:/memwbregister/ALU_Result 10#40 0
force -freeze sim:/memwbregister/Rdst 110 0
run
run
force -freeze sim:/memwbregister/RTI 0 0
force -freeze sim:/memwbregister/Register_Write 1 0
force -freeze sim:/memwbregister/Mem_2PC 0 0
force -freeze sim:/memwbregister/Mem_2Reg 1 0
force -freeze sim:/memwbregister/Push_INT_PC 0 0
force -freeze sim:/memwbregister/Port_Read 1 0
force -freeze sim:/memwbregister/RST 0 0
force -freeze sim:/memwbregister/INT 1 0
force -freeze sim:/memwbregister/Port_Val 10#80 0
force -freeze sim:/memwbregister/Memory_Data 10#90 0
force -freeze sim:/memwbregister/ALU_Result 10#100 0
force -freeze sim:/memwbregister/Rdst 001 0
run
run