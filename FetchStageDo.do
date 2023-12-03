quit -sim
vcom FetchStage.vhd
vsim -t ns FetchStage
# INPUTS
add wave -color yellow CLK Mem_Out PC_INC_Decode PC_INC_Mem ALU_Res RDst_Exec Reset_Mem Call_Exec Branch_Exec Branch_Mem Mem_2PC Zero_flag Init PC_Init IN_Inst
# OUTPUTS
add wave -color cyan Inst Sign_Extend PC_Inc

# Apply inputs for a specific duration
force -freeze IN_Inst x"00000001" 0 
force -freeze PC_Init 0 0 
force -freeze Init 1 0 
force -freeze Zero_flag 0 0 
force -freeze Mem_2PC 0 0 
force -freeze Branch_Mem 0 0 
force -freeze Branch_Exec x"0" 0 
force -freeze Call_Exec x"0" 0 
force -freeze Reset_Mem x"0" 0 
force -freeze RDst_Exec x"00000000" 0 
force -freeze ALU_Res x"00000000" 0 
force -freeze PC_INC_Mem x"0000000c" 0 
force -freeze PC_INC_Decode x"00000000" 0 
force -freeze Mem_Out x"00000000" 0 
force -freeze CLK 1 0, 0 {50 ns} -r 100
run 100 ns
force -freeze PC_INC_Decode x"00000001" 0 
force -freeze IN_Inst x"00000002" 0 

run 100 ns
force -freeze PC_INC_Decode x"00000002" 0 
force -freeze IN_Inst x"00000003" 0 

run 100 ns
force -freeze PC_INC_Decode x"00000003" 0 
force -freeze IN_Inst x"00000004" 0 

run 100 ns
force -freeze Init 0 0 
force -freeze PC_INC_Decode x"00000000" 0 

run 100 ns
force -freeze PC_INC_Decode x"00000001" 0 

run 100 ns
force -freeze Init 0 0 
force -freeze PC_INC_Decode x"00000002" 0 

run 100 ns
force -freeze Init 0 0 
force -freeze PC_INC_Decode x"00000003" 0 
run 100 ns

force -freeze Init 1 0 
force -freeze PC_INC_Decode x"0000000b" 0 
force -freeze IN_Inst x"0000000b" 0 

run 100 ns
force -freeze PC_INC_Decode x"0000000c" 0 
force -freeze IN_Inst x"0000000c" 0 

run 100 ns

force -freeze PC_INC_Decode x"0000000d" 0 
force -freeze IN_Inst x"0000000d" 0 
force -freeze RDst_Exec x"0000000b" 0 
run 100 ns

force -freeze Init 0 0 
force -freeze Call_Exec x"1" 0 
run 100 ns

force -freeze Call_Exec x"0" 0 
force -freeze PC_INC_Decode x"000000c" 0 
run 100 ns

force -freeze PC_INC_Decode x"000000d" 0 
run 100 ns

force -freeze Branch_Exec 1 0 
run 100 ns

force -freeze Branch_Exec 0 0 
force -freeze Mem_2PC 1 0 
run 100 ns

force -freeze Mem_2PC 0 0 
force -freeze Branch_Mem 1 0
run 100 ns
