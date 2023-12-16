binaryFile= open("binaryCode.txt",mode="r")
wavesFile=open("waves.txt",mode="r")
doFile=open("doFile.txt",mode="w")
doFile.writelines(["quit -sim","\n","vcom Processor.vhd","\n","vsim -t ns Processor\n"])
doFile.writelines([
    "force -freeze CLK 1 0, 0 {50 ns} -r 100\n",
    "force -freeze PC_Init 1 0 \n",
    "force -freeze Mem_Init 1 0 \n",
    "force -freeze RST_Reg 1 0 \n",
    "force -freeze Init 0 0 \n",
    "force -freeze RST 0 0  \n",
    "force -freeze INT 0 0 \n",
    "force -freeze Port_Input \"1000000100000011\" 0 \n",
    "run 100 ns\n",
    "force -freeze PC_Init 0 0 \n",
    "force -freeze Mem_Init 0 0\n" ,
    "run 100 ns\n",
    "force -freeze RST_Reg 0 0 \n",
    "force -freeze Init 1 0 \n"
])


binaryInstructions=binaryFile.readlines()
for inst in binaryInstructions:
    doFile.writelines([
        f"force -freeze IN_Inst \"{inst.strip()}\" 0 ",
        "\n",
        "run 100 ns\n"
    ])
waves=wavesFile.readlines()
doFile.writelines(waves)
doFile.writelines([
    "force -freeze PC_Init 1 0 \n",
    "force -freeze Init 0 0 \n",
    "run 100 ns\n"
    "force -freeze PC_Init 0 0 \n",
])

doFile.writelines([
    "\n",f"run {100*len(binaryInstructions)} ns"
])
