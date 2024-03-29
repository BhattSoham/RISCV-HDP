# RV DAY 1 #

This section is based on RISC-V ISA and its associated works.

***Introduction***

RISC-V instruction set architecture (ISA) is the language of the computer. So, the question arises how can our C program turn into a hardware representation? 

In simple words, it is three simple steps:

**RISC-V architecture -> RTL Implementation -> Layout(qflow)**

To explain it more simply, 

**Write your 'C' program -> Execute by hardware -> Get the desired output**

![image1](/week2/task1/RISCV_to_layout.png)

Now to expand it, the answer is whenever we are writing any C program, that program is generally our "Source Code". That output of the source code will be converted into assembly language (or instructions) using any compiler. The compiler will turn our code into specific instructions through a ".exe" file. The job of the assembler is to take the instructions and convert them into binary numbers. The assembler then takes our .exe file and converts it into binary, which is termed the "machine language" or "machine code" (represented using logic '0's and '1's). The machine code will then be fed to the hardware and accordingly, it generates the output.

![image2](/week2/task1/apps_to_hardware.png)

![image3](/week2/task1/c_to_hw.png)

If we see the pictures given above, we can see the system software. The system software comprises of three parts, operating system, compiler, and assembler. If the hardware belongs to x86/ARM/MIPS/RISCV-V, then the instructions will also belong to the respective formats.

So, in summary:

**C program -> Assembly language generated by the compiler (the hex part in the instructions will be converted to machine instructions) -> Machine language by assembler -> Hardware (integrated the machine language into chip layout).**

Another thing is, that the instructions are called the **"Abstract Interface"**. They are generally the connector between the C program and RISC-V hardware. 

Another interface is the **HDL language** or the **Hardware Description language**. That is, implementation of the instructions). The next part is the synthesis into netlists of RTL (From logic gates, F/Fs, etc) and then the final part is the physical design implementation of the netlist (Hardware). That is the complete **RTL to GDS** flow.

![image4](/week2/task1/using_rtl.png)

***a. Introduction to RISC-V basic keywords***

Regarding the RISC-V basic keywords, we have to keep these things in mind:
 i) Pseudo Instruction.
 ii) Base Integer Instructions (RV64I, RV32I) -> Based on the 32/64 bit data.
 iii) Floating Point Extensions (RV64F: Single-precision formats, RV64D: Double-precision formats)
 iv) Multiply/Division Extension (RV64M)
 v) Application Binary Interface (ABI)
 vi) Memory Allocation and Stack Pointer

**i) Pseudo Instructions:**

![image5](/week2/task1/Pseudo_instructions.png)

These instructions are move("mv"), load-immediate("li"), and return("ret"); highlighted by yellow in the picture given above.

**ii) Base integer instructions (RV64I, RV32I)**

![image6](/week2/task1/RV64I.png)

These instructions are termed "Base integer instructions". They are associated with integer addition, jump, store, etc. They are highlighted with a red arrow in the previous picture. They are dependent upon 32 or 64 bits of data and that's why, we can choose the right instruction format for RV32I and RV64I respectively.

**iii)  Floating point extensions**

![image7](/week2/task1/RV64F_&_RV64D.png)

They are of two types. One is for single-precision format (RV64F) and the other is for double-precision format (RV64D).

**iv) Multiply/Division Extension (RV64M)**

![image8](/week2/task1/RV64M.png)

These are the instructions used for multiply or division formats for RISC-V architecture.

**v) Application Binary Interface (ABI)**

![image9](/week2/task1/ABI.png)

The keywords presented using yellow color are for the application programmers who can use these registers directly for their RISC-V specification using those interfaces. These are called "Application Binary Interface" or "ABI". Every register is associated with some starting address. 

**vi) Memory allocation and stack pointer**

![image10](/week2/task1/Mem_allocation.png)

In every instruction, some data transfer occurs between memory, stack pointer, and register. This concept is called "Memory allocation and stack pointer".

***b. Labwork for RISC-V software toolchain***

Let us take a simple C program to add and calculate the sum of numbers 1 to n. So for that, let us write the program on 'text editor' or use the command:
```
~ leafpad sum.c
```
The code is given below:
```
~ gcc sum.c
~./a.out
```
We can check the following result using gcc compiler in the below image.

![image11](/week2/task1/sum/using_gcc.png)

Now, in the RISCV64 software toolchain, we can compile our code using the following commands: 
```
~ riscv64-unknown-elf-gcc -O1 -mabi=lp64 -march=rv64i -o sum.o sum.c
```
To see the assembly instructions used for our code, we will use this command:
```
~ riscv64-unknown-elf-objdump -d sum.o | less
```
![image12](/week2/task1/sum/main.png)

Here, we can see the base address of our main function is 0000000000010184. If we subtract it from 00000000000101b0 and divide it by 4 (as byte instructions always increment by 4), we will get our number of instructions used, which is 11. 

Also, to get more optimized instructions,  we can use the following command by interchanging "O1" with "Ofast".
```
~ riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o sum.o sum.c
```
***c. SPIKE simulation and debug***

SPIKE is a functional RISC-V ISA C++ sofware simulator. Spike is a debugger too, it can be invoked to debug an assembly code, just like any high-level language debugger. We can add breakpoints in terms of memory addresses reported in the leftmost column of the ASM code. To see the same output as gcc compiler using the SPIKE simulator, we will use the following command:
```
spike pk sum.o
```
![image13](/week2/task1/sum/using_spike.png)

For debugging, we will use the following command:
```
spike -d pk sum.o
```
Please check the below picture.

![image14](/week2/task1/sum/debug.png)

Let's imagine we wish to examine the content of the RISCV registers when main() is called. 
What is the content of register a2 when the main function is called?
To answer this question, we need to run the debugger. 

Command to invoke the spike debugger: 
```
~ spike -d pk sum1ton.o
~ till pc 0 100b0 
~ reg 0 a2 
```
