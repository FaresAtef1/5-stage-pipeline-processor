# 5-stage-pipeline-processor
The processor in this project follows a RISC-like instruction set architecture. It is equipped with eight 4-byte general-purpose registers, labeled R0 through R7. Additionally, there are two specific registers: one functions as a program counter (PC), and the other serves as a stack pointer (SP), pointing to the top of the stack. The initial value of SP is set to (2^12-1).

The memory address space is 4 KB with a width of 16 bits, and it is word-addressable, where a word is defined as 2 bytes (N.B. word = 2 bytes). The data bus between memory and the processor has a 16-bit width for instruction memory and a 32-bit width for data memory.

In this processor, we have implemented support for 30 instructions, addressing all hazard types (Structural, Data, and Control), as well as handling interrupt and reset inputs. Additionally, we have developed our own [assembler](https://github.com/FaresAtef1/5-stage-pipeline-processor/tree/main/assembler) written in Python.

## Processor Specifications
1) Registers
2) Input-Output
3) Instructions & Op Codes
4) Instruction Bits Details
5) Control Signals
6) Schematic Diagram of The Processor
7) Pipeline Stages Design
8) Pipeline Hazards and Solutions

### 1) Registers
```
R[0:7]<31:0>   	  ; Eight 32-bit general purpose registers
PC<31:0>          ; 32-bit program counter
SP<31:0>          ; 32-bit stack pointer
CCR<3:0>          ; condition code register
Z<0>:=CCR<0> 	  ; zero flag, change after arithmetic, logical, or shift operations
N<0>:=CCR<1> 	  ; negative flag, change after arithmetic, logical, or shift operations
C<0>:=CCR<2> 	  ; carry flag, change after arithmetic or shift operations
```

### 2) Input-Output
```
IN.PORT<31:0> 	; 32-bit data input port
OUT.PORT<31:0> 	; 32-bit data output port
INTR.IN<0>      ; a single, non-maskable interrupt
RESET.IN<0> 	; reset signal
```

### 3) Instructions & Op Codes
```
Rsrc1	; 1st operand register 
Rsrc2	; 2nd operand register 
Rdst	; result register
EA	; Effective address (20 bit)
Imm	; Immediate Value (16 bit)
```

<div align="center">
 
 Instruction | Op Code 
:----------:|:----------:
NOP	| 00000
NOT Rdst	| 10000
NEG Rdst	| 10001
INC Rdst	| 10010
DEC Rdst	| 10011
CMP Rsrc1, Rsrc2	| 10101
IN Rdst	| 00001
OUT Rdst	| 10100
SWAP Rsrc, Rdst	| 00010
ADD Rdst, Rsrc1, Rsrc2	| 00011
SUB Rdst, Rsrc1, Rsrc2	| 00101
AND Rdst, Rsrc1, Rsrc2	| 00110
OR Rdst, Rsrc1, Rsrc2	| 00111
XOR Rdst, Rsrc1, Rsrc2	| 01000
ADDI Rdst, Rsrc1, Imm	| 00100
BITSET Rdst, Imm	| 10110
RCL Rsrc, Imm	| 10111
RCR Rsrc, Imm	| 11000
LDM Rdst, Imm	| 01010
LDD Rdst, EA	| 01011
STD Rsrc, EA	| 11010
PUSH Rdst	| 11001
POP Rdst	| 01001
PROTECT Rsrc	| 11011
FREE Rsrc	| 11100
JZ Rdst	| 11101
JMP Rdst	| 11110
CALL Rdst	| 11111
RET	| 01100
RTI	| 01101

</div>

### 4) Instruction Bits Details
```
Op Code [15-11]
Rdst [10-8]
Rs [7-5]
Rt [4-2]
Unused [1-0]
```
In case of using immediate values, which are 16-bits long we use the next slot in memory for the retrieval of that value.

Also, in the case of using an effective address which is 20-bits long we use the last 4 bits in the instruction, since it is unused, along with the 16-bits available in the next memory slot to be able to deliver a 20-bit value for execution.


### 5) Control Signals

![image](https://github.com/FaresAtef1/5-stage-pipeline-processor/assets/96792115/6187c409-ec11-4ca7-b418-a3963e636648)
It can also be found [here](https://github.com/FaresAtef1/5-stage-pipeline-processor/blob/main/documentation/ControlSignals.xlsx).

### 6) Schematic Diagram of The Processor
![Processor](https://github.com/FaresAtef1/5-stage-pipeline-processor/assets/96792115/579b1e51-4939-4197-a889-d729fdcd06e8)

Full design with details can be found [here](https://www.canva.com/design/DAFzjgNgY9I/crOsA9dvig85tfbw5jPZ0A/edit?utm_content=DAFzjgNgY9I&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton).

### 7) Pipeline Stages Design
To achieve a five-stage pipeline design, we have used four large registers to keep all the data of each stage separate from all the other stages.
These registers are:

- IF/ID
This is the register between the fetch and decode stages, size: 81-bits in total split into:
```
INT Signal: 1-bit
PC+1: 32-bit
Instruction: 16-bit
Immediate Value: 32-bit
```

- ID/EX
This is the register between the decode and execute stages, size: 124-bits in total split into:
```
19 1-Bit Signals which are: [ Register_Write, Branch, Immediate, Mem_Read, Mem_Write, Mem_2Reg, Port_Write, Port_Read, Protect_Write, Protect_Val ,Write_Flag, Stack, Push, Call, Mem_2PC, Swap, RTI, RST, INT, PUSH_INT_PC ]
3 32-Bit Register Values which are: [ Reg1_Value, Reg2_Value, PC+1]
3 3-Bit Register Addresses which are: [ Rdst,Rs,Rt ]
5-Bit Op Code
```

- EX/MEM
This is the register between the execute and memory stages, size: 124-bits in total split into:
```
16 1-Bit Signals which are: [ Register_Write, Branch, Mem_Read, Mem_Write, Mem_2Reg, Port_Write, Port_Read, Stack, Push, Call, Mem_2PC, RTI, RST, INT, PUSH_INT_PC,Protect_State ]
4 32-Bit Register Values which are: [ ALU Result, Memory Data, PC+1, Stack Pointer ]
3-Bit Destination Register Address
3-Bit Flag Register
```

- MEM/WB
This is the register between the memory and write-back stages, size: 107-bits in total split into:
```
8 1-Bit Signals which are: [ Register_Write, Mem_2Reg, Port_Read, Call, Mem_2PC, RTI, RST, INT, PUSH_INT_PC ]
3 32-Bit Register Values which are: [ ALU Result, Memory Data, Port Data ]
3-Bit Destination Register Address
```

### 8) Pipeline Hazards and Solutions

We face three types of hazards in our design which are:
- Structural
- Data
- Control
 
For Structural we have faced the following:
-	Using the same memory for instruction fetch and storing and retrieving data, for that: We have used two different memory elements: Data and Instruction.
-	Reading from and writing to the register file during the same clock cycle, for that: We ensure that writing is done at the first half of the clock cycle and reading is done in the second.

For Data We have faced the following:
-	RAW Dependency, for that: we have added a forwarding unit to forward data from both the ALU and Memory before it is written back to the register file.
-	Load Use Scenario, for that: We stall the pipeline for one cycle and leave the forward unit to do its job.

For Control We have faced the following:
-	Incorrect Prediction, for that: We flush the incorrectly fetched instructions.

N.B., we use a static (not taken) branch prediction approach.

## ©️Developers

| Name                 |         Email          |
|----------------------|:----------------------:|
| Fares Atef           | faresatef553@gmail.com |
| Ghaith Mohamed       |  gaoia123@gmail.com    |
| Amr ElSheshtawy      | Sheshtawy321@gmail.com |
| Amr Magdy            |  amr4121999@gmail.com  |
