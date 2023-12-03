add wave -position insertpoint  \
sim:/executestage/Op_Code \
sim:/executestage/Rdst \
sim:/executestage/Rsrc1 \
sim:/executestage/Rsrc2 \
sim:/executestage/Rdst_Mem \
sim:/executestage/Rdst_WB \
sim:/executestage/Register_Write_Mem \
sim:/executestage/Register_Write_WB \
sim:/executestage/Immediate \
sim:/executestage/Protect_Write \
sim:/executestage/Protect_Val \
sim:/executestage/Write_Flag \
sim:/executestage/Stack \
sim:/executestage/Stack_Mem \
sim:/executestage/RTI_WB \
sim:/executestage/RTI_Flags \
sim:/executestage/Prev_ALU_Res \
sim:/executestage/Prev_Mem_Res \
sim:/executestage/Reset \
sim:/executestage/Read_Data1 \
sim:/executestage/Read_Data2 \
sim:/executestage/Immediate_Val \
sim:/executestage/Effective_Address \
sim:/executestage/ALU_Result \
sim:/executestage/Protect_Out \
sim:/executestage/Flags \
sim:/executestage/Stack_Pointer \
sim:/executestage/Mem_Data \
sim:/executestage/ALU_Sel \
sim:/executestage/ALU_Op1 \
sim:/executestage/ALU_Op2 \
sim:/executestage/ALU_Flags \
sim:/executestage/Protect_Address \
sim:/executestage/Forward_Data1 \
sim:/executestage/Forward_Data2 \
sim:/executestage/FR_EN \
sim:/executestage/Flag_Data \
sim:/executestage/ALU_SP
force -freeze sim:/executestage/Reset 1 0
run
force -freeze sim:/executestage/Reset 0 0
force -freeze sim:/executestage/Op_Code 00011 0
force -freeze sim:/executestage/Rdst 000 0
force -freeze sim:/executestage/Rsrc1 001 0
force -freeze sim:/executestage/Rsrc2 010 0
force -freeze sim:/executestage/Rdst_Mem 111 0
force -freeze sim:/executestage/Rdst_WB 111 0
force -freeze sim:/executestage/Register_Write_Mem 0 0
force -freeze sim:/executestage/Register_Write_WB 0 0
force -freeze sim:/executestage/Immediate 0 0
force -freeze sim:/executestage/Protect_Write 0 0
force -freeze sim:/executestage/Protect_Val 0 0
force -freeze sim:/executestage/Write_Flag 1 0
force -freeze sim:/executestage/Stack 0 0
force -freeze sim:/executestage/Stack_Mem 0 0
force -freeze sim:/executestage/RTI_WB 0 0
force -freeze sim:/executestage/RTI_Flags 000 0
force -freeze sim:/executestage/Prev_ALU_Res 10#50 0
force -freeze sim:/executestage/Prev_Mem_Res 10#60 0
force -freeze sim:/executestage/Read_Data1 10#10 0
force -freeze sim:/executestage/Read_Data2 10#200 0
force -freeze sim:/executestage/Immediate_Val 10#70 0
force -freeze sim:/executestage/Effective_Address 10#80 0
run
force -freeze sim:/executestage/Read_Data1 10#4294967290 0
run
force -freeze sim:/executestage/Read_Data1 10#4294967295 0
force -freeze sim:/executestage/Read_Data2 10#4294967295 0
force -freeze sim:/executestage/Op_Code 00101 0
run
force -freeze sim:/executestage/Op_Code 00100 0
force -freeze sim:/executestage/Immediate 1 0
run
force -freeze sim:/executestage/Op_Code 01010 0
run
force -freeze sim:/executestage/Op_Code 11001 0
force -freeze sim:/executestage/Immediate 0 0
force -freeze sim:/executestage/Write_Flag 0 0
force -freeze sim:/executestage/Stack 1 0
force -freeze sim:/executestage/Read_Data1 10#250 0
run
force -freeze sim:/executestage/Stack 0 0
force -freeze sim:/executestage/Stack_Mem 1 0
force -freeze sim:/executestage/Prev_ALU_Res 11111111111111111111111111111101 0
force -freeze sim:/executestage/Op_Code 00000 0
run
force -freeze sim:/executestage/Op_Code 11011 0
force -freeze sim:/executestage/Stack_Mem 0 0
force -freeze sim:/executestage/Read_Data1 10#1 0
force -freeze sim:/executestage/Protect_Write 1 0
force -freeze sim:/executestage/Protect_Val 1 0
run
force -freeze sim:/executestage/Protect_Write 0 0
force -freeze sim:/executestage/Protect_Val 0 0
run
force -freeze sim:/executestage/Protect_Write 1 0
force -freeze sim:/executestage/Protect_Val 1 0
force -freeze sim:/executestage/Immediate_Val 10#1 0
run
force -freeze sim:/executestage/Protect_Write 0 0
force -freeze sim:/executestage/Protect_Val 0 0
run
force -freeze sim:/executestage/Op_Code 11100 0
force -freeze sim:/executestage/Protect_Write 1 0
run
force -freeze sim:/executestage/Protect_Write 0 0
run
force -freeze sim:/executestage/Op_Code 10111 0
force -freeze sim:/executestage/Read_Data1 10#250 0
force -freeze sim:/executestage/Write_Flag 1 0
force -freeze sim:/executestage/Immediate 1 0
force -freeze sim:/executestage/Immediate_Val 10#2 0
run
force -freeze sim:/executestage/Op_Code 11000 0
force -freeze sim:/executestage/Read_Data1 10#1002 0
run
force -freeze sim:/executestage/Immediate_Val 10#50 0
run
force -freeze sim:/executestage/Op_Code 10000 0
force -freeze sim:/executestage/Immediate 0 0
force -freeze sim:/executestage/Read_Data1 10#1 0
force -freeze sim:/executestage/Read_Data1 10#0 0
run
force -freeze sim:/executestage/Read_Data1 10#1 0
run
force -freeze sim:/executestage/Op_Code 10001 0
run
noforce sim:/executestage/Op_Code
force -freeze sim:/executestage/Op_Code 10010 0
run
force -freeze sim:/executestage/Op_Code 10111 0
force -freeze sim:/executestage/Immediate_Val 10#65 0
run
force -freeze sim:/executestage/Immediate 1 0
run
force -freeze sim:/executestage/Op_Code 11000 0
force -freeze sim:/executestage/Immediate_Val 10#257 0
force -freeze sim:/executestage/Read_Data1 10#2 0
run
force -freeze sim:/executestage/Op_Code 10011 0
force -freeze sim:/executestage/Immediate 0 0
run
force -freeze sim:/executestage/Op_Code 00110 0
force -freeze sim:/executestage/Read_Data1 10#3 0
force -freeze sim:/executestage/Read_Data2 10#2 0
run
force -freeze sim:/executestage/Op_Code 00111 0
run
force -freeze sim:/executestage/Op_Code 01000 0
run
force -freeze sim:/executestage/Op_Code 10101 0
run
force -freeze sim:/executestage/Read_Data1 10#2 0
run
force -freeze sim:/executestage/Read_Data2 10#3 0
run
force -freeze sim:/executestage/Op_Code 10110 0
force -freeze sim:/executestage/Immediate 1 0
force -freeze sim:/executestage/Immediate_Val 10#1 0
force -freeze sim:/executestage/Immediate_Val 10#0 0
run
force -freeze sim:/executestage/Immediate_Val 10#7 0
run
