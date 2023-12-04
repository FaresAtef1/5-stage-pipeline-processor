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
run 100 ns