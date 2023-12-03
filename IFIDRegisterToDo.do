add wave -position insertpoint  \
sim:/ifidregister/RST_Reg \
sim:/ifidregister/Clk \
sim:/ifidregister/RST \
sim:/ifidregister/INT \
sim:/ifidregister/INC_PC \
sim:/ifidregister/Instruction \
sim:/ifidregister/Immediate_Val \
sim:/ifidregister/RST_Out \
sim:/ifidregister/INT_Out \
sim:/ifidregister/INC_PC_Out \
sim:/ifidregister/Op_Code \
sim:/ifidregister/Rdst \
sim:/ifidregister/Rsrc1 \
sim:/ifidregister/Rsrc2 \
sim:/ifidregister/Immediate_Val_Out
force -freeze sim:/ifidregister/Clk 1 0, 0 {100 ps} -r 200
force -freeze sim:/ifidregister/RST_Reg 1 0
run
force -freeze sim:/ifidregister/RST_Reg 0 0
force -freeze sim:/ifidregister/RST 1 0
force -freeze sim:/ifidregister/INT 1 0
force -freeze sim:/ifidregister/INC_PC 10#10 0
force -freeze sim:/ifidregister/Instruction 1000011010100100 0
force -freeze sim:/ifidregister/Immediate_Val 10#50 0
run
run
force -freeze sim:/ifidregister/RST 0 0
force -freeze sim:/ifidregister/INT 0 0
force -freeze sim:/ifidregister/INC_PC 10#60 0
run
run