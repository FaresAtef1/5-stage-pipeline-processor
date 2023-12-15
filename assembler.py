import re
def getRegisterAddress(reg):
    if(reg=="R0"): return "000"
    if(reg=="R1"): return "001"
    if(reg=="R2"): return "010"
    if(reg=="R3"): return "011"
    if(reg=="R4"): return "100"
    if(reg=="R5"): return "101"
    if(reg=="R6"): return "110"
    if(reg=="R7"): return "111"
    return "000"


insrtuctionsFile=   open("instructions.txt",mode="r")
binaryFile= open("binaryCode.txt",mode="w")
instructions= insrtuctionsFile.readlines()
instructionsOpCodes={
    "NOP":"00000",
    "NOT":"10000",
    "NEG":"10001",
    "INC":"10010",
    "DEC":"10011",
    "OUT":"10100",
    "IN":"00001",
    "SWAP":"00010",
    "ADD":"00011",
    "ADDI":"00100",
    "SUB":"00101",
    "AND":"00110",
    "OR":"00111",
    "XOR":"01000",
    "CMP":"10101",
    "BITSET":"10110",
    "RCL":"10111",
    "RCR":"11000",
    "PUSH":"11001",
    "POP":"01001",
    "LDM":"01010",
    "LDD":"01011",
    "STD":"11010",
    "PROTECT":"11011",
    "FREE":"11100",
    "JZ":"11101",
    "JMP":"11110",
    "CALL":"11111",
    "RET":"01100",
    "RTI":"01101",
}

immediateInstructions=["BITSET","RCL","RCR","LDM"]
for inst in instructions:
    inst=inst.strip()
    instParts=re.split(r'[,\s]+',inst)
    instructionBits=""
    EA="00000000000000000000"
    opcode=(instructionsOpCodes.get(instParts[0]))
    instructionBits+=opcode
    if(len(instParts)==1):
        instructionBits+="00000000000"
    if(len(instParts)==2):
        instructionBits+=getRegisterAddress(instParts[1])+"00000000"
    if(len(instParts)==3):
        if (instParts[0]!="STD" and instParts[0]!="LDD") :
            instructionBits+=getRegisterAddress(instParts[1])+getRegisterAddress(instParts[2])+"00000"
        else:
            EA=format(int(instParts[2]),'020b')[-20:]
            instructionBits+=getRegisterAddress(instParts[1])+getRegisterAddress(instParts[2])+"0"+EA[0:4]
    if(len(instParts)==4):
        instructionBits+=getRegisterAddress(instParts[1])+getRegisterAddress(instParts[2])+getRegisterAddress(instParts[3])+"00"
    binaryFile.writelines([instructionBits,"\n"])
    if(instParts[0] =="ADDI"):
        immediateVal=format(int(instParts[3]),'016b')[-16:]
        binaryFile.writelines([immediateVal,'\n'])
    if(instParts[0] in immediateInstructions):
        immediateVal=format(int(instParts[2]),'016b')[-16:]
        binaryFile.writelines([immediateVal,'\n'])
    if(instParts[0]=="STD" or instParts[0]=="LDD"):
        binaryFile.writelines([EA[-16:],'\n'])

        
insrtuctionsFile.close()
binaryFile.close()


