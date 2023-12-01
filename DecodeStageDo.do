quit -sim
vcom DecodeStage.vhd
vsim -t ns DecodeStage
# INPUTS
add wave -color yellow CLK Op_Code Reset ResetExec ResetMem ResetWB INT INTExec INTMem INTWB MemReadExec SwapExec INRExec MemToPCExec MemToPCMem MemToPCWB RegWriteWB RDst RSrc1 RSrc2 Write_Reg ExecRdst ExecRsrc1 Write_Data
# OUTPUTS
add wave -color cyan Register_Write Branch Immediate Mem_Read Mem_Write Mem_2Reg Port_Write Port_Read Protect_Write Protect_Val Write_Flag Stack Push Call Mem_2PC SWAP RTI InstRdst Read_Data1 Read_Data2 Read_Data1_SIG Read_Data2_SIG Hazard ReadReg1 ReadReg2

# Apply inputs for a specific duration
force -freeze Reset 1 0 
force -freeze ResetExec 0 0 
force -freeze ResetMem 0 0 
force -freeze ResetWB 0 0 
force -freeze INT 0 0 
force -freeze INTExec 0 0 
force -freeze INTMem 0 0 
force -freeze INTWB 0 0 
force -freeze MemReadExec 0 0 
force -freeze SwapExec 0 0 
force -freeze INRExec 0 0 
force -freeze MemToPCExec 0 0 
force -freeze MemToPCMem 0 0 
force -freeze MemToPCWB 0 0 
force -freeze RegWriteWB 1 0 
force -freeze Op_Code x"1" 0 
force -freeze RDst x"2" 0 
force -freeze RSrc1 x"0" 0 
force -freeze RSrc2 x"1" 0 
force -freeze Write_Reg x"0" 0 
force -freeze ExecRdst x"0" 0 
force -freeze ExecRsrc1 x"1" 0 
force -freeze Write_Data x"a" 0 
force -freeze CLK 1 0, 0 {50 ns} -r 100
run 100 ns
force -freeze Reset 0 0 
run 100 ns
force -freeze Write_Reg x"1" 0 
force -freeze Write_Data x"b" 0 
run 100 ns
force -freeze MemReadExec 1 0 
run 100 ns
force -freeze MemReadExec 0 0 
force -freeze ExecRsrc1 x"2" 0 
force -freeze ExecRdst x"3" 0 
run 100 ns
force -freeze SwapExec 1 0 
run 100 ns