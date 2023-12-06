quit -sim
vcom Processor.vhd
vsim -t ns Processor
add wave -position end  sim:/processor/CLK
add wave -position end  sim:/processor/RST
add wave -position end  sim:/processor/INT
add wave -position end  sim:/processor/Init
add wave -position end  sim:/processor/In_Inst
add wave -position end  sim:/processor/PC_Init
add wave -position end  sim:/processor/Mem_Init
add wave -position end  sim:/processor/RST_Reg
add wave -position end  sim:/processor/Port_Input
add wave -position end  sim:/processor/Out_Port_Data
add wave -position end  sim:/processor/RST_Reg_IF
add wave -position end  sim:/processor/INC_PC_IF
add wave -position end  sim:/processor/Immediate_Val_IF
add wave -position end  sim:/processor/Instruction_IF
add wave -position end  sim:/processor/RTI_ID
add wave -position end  sim:/processor/Register_Write_ID
add wave -position end  sim:/processor/Branch_ID
add wave -position end  sim:/processor/Immediate_ID
add wave -position end  sim:/processor/Mem_Read_ID
add wave -position end  sim:/processor/Mem_Write_ID
add wave -position end  sim:/processor/Mem_2Reg_ID
add wave -position end  sim:/processor/Port_Write_ID
add wave -position end  sim:/processor/Port_Read_ID
add wave -position end  sim:/processor/Protect_Write_ID
add wave -position end  sim:/processor/Protect_Val_ID
add wave -position end  sim:/processor/Write_Flag_ID
add wave -position end  sim:/processor/Stack_ID
add wave -position end  sim:/processor/Push_ID
add wave -position end  sim:/processor/Call_ID
add wave -position end  sim:/processor/Mem_2PC_ID
add wave -position end  sim:/processor/Swap_ID
add wave -position end  sim:/processor/RST_ID
add wave -position end  sim:/processor/INT_ID
add wave -position end  sim:/processor/Push_INT_PC_ID
add wave -position end  sim:/processor/Read_Data1_ID
add wave -position end  sim:/processor/Read_Data2_ID
add wave -position end  sim:/processor/INC_PC_ID
add wave -position end  sim:/processor/Op_Code_ID
add wave -position end  sim:/processor/Rdst_ID
add wave -position end  sim:/processor/Rsrc1_ID
add wave -position end  sim:/processor/Rsrc2_ID
add wave -position end  sim:/processor/Inst_Rdst_ID
add wave -position end  sim:/processor/Inst_Rsrc1_ID
add wave -position end  sim:/processor/Inst_Rsrc2_ID
add wave -position end  sim:/processor/Reg0_ID
add wave -position end  sim:/processor/Reg1_ID
add wave -position end  sim:/processor/Reg2_ID
add wave -position end  sim:/processor/Reg3_ID
add wave -position end  sim:/processor/Reg4_ID
add wave -position end  sim:/processor/Reg5_ID
add wave -position end  sim:/processor/Reg6_ID
add wave -position end  sim:/processor/Reg7_ID
add wave -position end  sim:/processor/RTI_EX
add wave -position end  sim:/processor/Register_Write_EX
add wave -position end  sim:/processor/Branch_EX
add wave -position end  sim:/processor/Immediate_EX
add wave -position end  sim:/processor/Mem_Read_EX
add wave -position end  sim:/processor/Mem_Write_EX
add wave -position end  sim:/processor/Mem_2Reg_EX
add wave -position end  sim:/processor/Port_Write_EX
add wave -position end  sim:/processor/Port_Read_EX
add wave -position end  sim:/processor/Protect_Write_EX
add wave -position end  sim:/processor/Write_Flag_EX
add wave -position end  sim:/processor/Stack_EX
add wave -position end  sim:/processor/Push_EX
add wave -position end  sim:/processor/Call_EX
add wave -position end  sim:/processor/Mem_2PC_EX
add wave -position end  sim:/processor/Swap_EX
add wave -position end  sim:/processor/RST_EX
add wave -position end  sim:/processor/INT_EX
add wave -position end  sim:/processor/Push_INT_PC_EX
add wave -position end  sim:/processor/Rdst_EX
add wave -position end  sim:/processor/Rsrc1_EX
add wave -position end  sim:/processor/Rsrc2_EX
add wave -position end  sim:/processor/Flags_EX
add wave -position end  sim:/processor/Read_Data1_EX
add wave -position end  sim:/processor/Read_Data2_EX
add wave -position end  sim:/processor/INC_PC_EX
add wave -position end  sim:/processor/Stack_Pointer_EX
add wave -position end  sim:/processor/ALU_Result_EX
add wave -position end  sim:/processor/Memory_Data_EX
add wave -position end  sim:/processor/Op_Code_EX
add wave -position end  sim:/processor/Protect_Val_EX
add wave -position end  sim:/processor/Protect_State_EX
add wave -position end  sim:/processor/RTI_MEM
add wave -position end  sim:/processor/Register_Write_MEM
add wave -position end  sim:/processor/Mem_2PC_MEM
add wave -position end  sim:/processor/Mem_2Reg_MEM
add wave -position end  sim:/processor/Push_MEM
add wave -position end  sim:/processor/Stack_MEM
add wave -position end  sim:/processor/Push_INT_PC_MEM
add wave -position end  sim:/processor/Call_MEM
add wave -position end  sim:/processor/Mem_Write_MEM
add wave -position end  sim:/processor/Mem_Read_MEM
add wave -position end  sim:/processor/Branch_MEM
add wave -position end  sim:/processor/Port_Write_MEM
add wave -position end  sim:/processor/Port_Read_MEM
add wave -position end  sim:/processor/RST_MEM
add wave -position end  sim:/processor/INT_MEM
add wave -position end  sim:/processor/Protect_State_MEM
add wave -position end  sim:/processor/Stack_Pointer_MEM
add wave -position end  sim:/processor/INC_PC_MEM
add wave -position end  sim:/processor/ALU_Result_MEM
add wave -position end  sim:/processor/Memory_Data_MEM
add wave -position end  sim:/processor/Rdst_MEM
add wave -position end  sim:/processor/Flags_MEM
add wave -position end  sim:/processor/Port_Out
add wave -position end  sim:/processor/Memory_Out
add wave -position end  sim:/processor/Rdst_WB
add wave -position end  sim:/processor/Register_Write_WB
add wave -position end  sim:/processor/RTI_WB
add wave -position end  sim:/processor/INT_WB
add wave -position end  sim:/processor/Push_INT_PC_WB
add wave -position end  sim:/processor/Mem_2PC_WB
add wave -position end  sim:/processor/Mem_2Reg_WB
add wave -position end  sim:/processor/Port_Read_WB
add wave -position end  sim:/processor/RST_WB
add wave -position end  sim:/processor/Memory_Out_WB
add wave -position end  sim:/processor/ALU_Result_WB
add wave -position end  sim:/processor/Port_Out_WB
add wave -position end  sim:/processor/WriteBack_Data
add wave -position end  sim:/processor/EA
add wave -position end  sim:/processor/Immediate_Val_ID

# Apply inputs for a specific duration
force -freeze CLK 1 0, 0 {50 ns} -r 100
force -freeze IN_Inst "0101000000000000" 0 
force -freeze PC_Init 1 0 
force -freeze Mem_Init 1 0 
force -freeze RST_Reg 1 0 
force -freeze Init 0 0
force -freeze RST 0 0  
force -freeze INT 0 0 

run 100 ns

force -freeze PC_Init 0 0 
force -freeze Mem_Init 0 0 
run 100 ns

force -freeze RST_Reg 0 0 
force -freeze Init 1 0 
run 100 ns


force -freeze IN_Inst "0000000000000011" 0 
run 100 ns

force -freeze IN_Inst "0101000100000000" 0 
run 100 ns

force -freeze IN_Inst "0000000000000111" 0 
run 100 ns

force -freeze IN_Inst "1000010100000000" 0 
run 100 ns

force -freeze IN_Inst "0001101000000100" 0 
run 100 ns

force -freeze IN_Inst "1011101000000000" 0 
run 100 ns

force -freeze IN_Inst "0000000000000010" 0 
run 100 ns

force -freeze IN_Inst "1001100100000000" 0 
run 100 ns

force -freeze IN_Inst "1101001000000000" 0 
run 100 ns

force -freeze IN_Inst "0000000000000000" 0 
run 100 ns

force -freeze IN_Inst "1101101100000000" 0 
run 100 ns

force -freeze IN_Inst "1101000100000000" 0 
run 100 ns

force -freeze IN_Inst "0000000000000000" 0 
run 100 ns

force -freeze IN_Inst "0101110000000000" 0 
run 100 ns

force -freeze IN_Inst "0000000000000000" 0 
run 100 ns

force -freeze IN_Inst "0011111010100100" 0 
run 100 ns

force -freeze IN_Inst "1010001000000000" 0 
run 100 ns



force -freeze PC_Init 1 0 
force -freeze Init 0 0 
run 100 ns
force -freeze PC_Init 0 0 
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns
run 100 ns

# Program
# LDM R0,3     
# 0101000000000000
# 0000000000000011
# LDM R1,7
# 0101000100000000
# 0000000000000111
# NOT R5
# 1000010100000000
# ADD R2,R0,R1
# 0001101000000100
# RCL R2,2
# 1011101000000000
# 0000000000000010
# DEC R1
# 1001100100000000
# STD R2,0
# 1101001000000000
# 0000000000000000
# Protect R3
# 1101101100000000
# STD R1,0
# 1101000100000000
# 0000000000000000
# LDD R4,0
# 0101110000000000
# 0000000000000000
# OR R6,R5,R1
# 0011111010100100
# OUT R2
# 1010001000000000