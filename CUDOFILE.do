add wave -position insertpoint  \
sim:/controlunit/Op_Code \
sim:/controlunit/Swap_Loopback \
sim:/controlunit/Reset_Exec \
sim:/controlunit/INT_Exec \
sim:/controlunit/INT_Mem \
sim:/controlunit/INT_WB \
sim:/controlunit/Register_Write \
sim:/controlunit/Branch \
sim:/controlunit/Immediate \
sim:/controlunit/Mem_Read \
sim:/controlunit/Mem_Write \
sim:/controlunit/Mem_2Reg \
sim:/controlunit/Port_Write \
sim:/controlunit/Port_Read \
sim:/controlunit/Protect_Write \
sim:/controlunit/Protect_Val \
sim:/controlunit/Write_Flag \
sim:/controlunit/Stack \
sim:/controlunit/Push \
sim:/controlunit/Call \
sim:/controlunit/Mem_2PC \
sim:/controlunit/Swap \
sim:/controlunit/RTI \
sim:/controlunit/CU_Signals
force -freeze sim:/controlunit/Swap_Loopback 0 0
force -freeze sim:/controlunit/Reset_Exec 0 0
force -freeze sim:/controlunit/INT_Exec 0 0
force -freeze sim:/controlunit/INT_Mem 0 0
force -freeze sim:/controlunit/INT_WB 0 0
force -freeze sim:/controlunit/Op_Code 00000 0
run
force -freeze sim:/controlunit/Op_Code 10000 0
run
force -freeze sim:/controlunit/Op_Code 10001 0
run
force -freeze sim:/controlunit/Op_Code  0
run
force -freeze sim:/controlunit/Op_Code 00000 0
run
force -freeze sim:/controlunit/Op_Code 00000 0
run
force -freeze sim:/controlunit/Op_Code 00000 0
run
force -freeze sim:/controlunit/Op_Code 00000 0
run
force -freeze sim:/controlunit/Op_Code 00000 0
run
force -freeze sim:/controlunit/Op_Code 00000 0
run
force -freeze sim:/controlunit/Op_Code 00000 0
run
force -freeze sim:/controlunit/Op_Code 00000 0
run
force -freeze sim:/controlunit/Op_Code 00000 0
run
force -freeze sim:/controlunit/Op_Code 00000 0
run
force -freeze sim:/controlunit/Op_Code 00000 0
run
force -freeze sim:/controlunit/Op_Code 00000 0
run
force -freeze sim:/controlunit/Op_Code 00000 0
run
force -freeze sim:/controlunit/Op_Code 00000 0
run
force -freeze sim:/controlunit/Op_Code 00000 0
run
force -freeze sim:/controlunit/Op_Code 00000 0
run
force -freeze sim:/controlunit/Op_Code 00000 0
run
force -freeze sim:/controlunit/Op_Code 00000 0
run
force -freeze sim:/controlunit/Op_Code 00000 0
run