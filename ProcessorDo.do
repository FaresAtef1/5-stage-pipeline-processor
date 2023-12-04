quit -sim
vcom Processor.vhd
vsim -t ns Processor
# INPUTS
add wave -color yellow CLK RST INT Init In_Inst PC_Init Mem_Init Pipeline_Regs_Init
# OUTPUTS
add wave -color cyan Write_Data RST_Reg_IF INC_PC_IF Immediate_Val_IF Instruction_IF RST_Out_ID INT_Out_ID INC_PC_Out_ID Op_Code_ID Rdst_ID Rsrc1_ID Rsrc2_ID Immediate_Val_Out_ID Register_Write_ID Branch_ID Immediate_ID Mem_Read_ID Mem_Write_ID Mem_2Reg_ID Port_Write_ID Port_Read_ID Protect_Write_ID Protect_Val_ID Write_Flag_ID Stack_ID Push_ID Call_ID Mem_2PC_ID SWAP_ID processor/RTI_ID Push_INT_PC_ID InstRdst_ID Read_Data1_ID Read_Data2_ID 

# Apply inputs for a specific duration
force -freeze CLK 1 0, 0 {50 ns} -r 100
force -freeze IN_Inst "1000000000101011" 0 
force -freeze PC_Init 1 0 
force -freeze Mem_Init 1 0 
force -freeze Pipeline_Regs_Init 1 0 
force -freeze Init 0 0
force -freeze RST 1 0  
force -freeze INT 1 0 

run 100 ns

force -freeze PC_Init 0 0 
force -freeze Mem_Init 0 0 
run 100 ns

force -freeze Pipeline_Regs_Init 0 0 
force -freeze Init 1 0 
run 100 ns

force -freeze IN_Inst "0011100000101011" 0 
run 100 ns

force -freeze IN_Inst "0101100000101011" 0 
run 100 ns

force -freeze PC_Init 1 0 
force -freeze Init 0 0 
run 100 ns
force -freeze PC_Init 0 0 
run 100 ns
run 100 ns





//////////////////////////////////////////////////////////////////
run 100 nforce -freeze sim:/processor/CLK 1 0, 0 {100 ps} -r 200
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
