# ASSIGNMENT / TASK 3 #

This section consists of two parts:

i. Verify all the C code (Counter, Matrix multiplication, ALU) using the RISC-V compiler and Spike ISA simulator.

ii. Measure the CPU performance of all the abovementioned programs using the RISC-V disassembler.

## VERIFY ALL THE C CODES (COUNTER, MATRIX MULTIPLICATION, ALU) USING THE RISC-V COMPILER AND SPIKE ISA SIMULATOR ##

We must use these commands to generate the object file or the machine code and verify the codes using the RISC-V compiler. Also, the command for generating the output results using Spike is given.    
```
~ riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o filename.o filename.c
~ riscv64-unknown-elf-objdump -d filename.o | less
~ spike pk filename.o
```
Also, to generate the RISCV ASM code or .S file for the respective C program, we need to use this command.
```
riscv64-unknown-elf-gcc -S filename.c -o filename.S
```

All the results after verifying and generating using Spike have been given below in the specific parts.

**1. 4-bit Counter**

 C code for the 4-bit counter is provided in the Task 5 section. 

![image1](/week2/task5/RISCV_commands_counter.png)

![image2](/week2/task5/counter_assembly.png)

![image3](/week2/task5/spike_output_counter.png)


**2. Matrix Multiplication**

 C code for the matrix multiplication is provided in the Task 5 section. 

![image4](/week2/task5/RISCV_commands_matmul.png)

![image5](/week2/task5/matmul_assembly.png)

![image6](/week2/task5/spike_output_matmul.png)

**3. ALU**

 C code for the ALU is provided in the Task 5 section. 

![image7](/week2/task5/RISCV_commands_ALU.png)

![image8](/week2/task5/ALU_assembly.png)

![image9](/week2/task5/spike_output_ALU.png)

## MEASURE THE CPU PERFORMANCE OF ALL THE ABOVEMENTIONED PROGRAMS USING RISC-V DISASSEMBLER ##

Let us assume the number of clock cycles for the RISC-V instructions.

**Instructions associated with add, mul, div: 2 cycles.**

**Instructions associated with load, store, and move: 3 cycles.**

**Instructions associated with jump, and branch: 4 cycles.**

**All other Instructions: 2 cycles.**

**1. 4-bit Counter**

For the assembly program for the 4-bit counter by RISC-V Disassembler, let us assume the clock cycles to see the CPU performance below.
```
addi	sp,sp,-32 -> 2 cycles
sd	ra,24(sp) -> 3 cycles
sd	s0,16(sp) -> 3 cycles
addi	s0,sp,32 -> 2 cycles
sw	zero,-20(s0) -> 3 cycles 
```
Therefore, 
**Clock cycle per instruction (CPI) = Total number of clock cycles / Number of instructions**

So, CPI will be 13 / 5 = 2.6.

Now, we know, **CPU time = CPI x Number of instructions for a program x Clock cycle time (T)**

Let's assume, T = 200ps.

So, **CPU time = 2.6 x 5 x 200ps = 2600ps or 2.6ns.**

**2. Matrix Multiplication**

For the assembly program for the matrix multiplication by RISC-V Disassembler, let us assume the clock cycles to see the CPU performance below.
```
addi	sp,sp,-80 -> 2 cycles
sd	ra,72(sp) -> 3 cycles
sd	s0,64(sp) -> 3 cycles
addi	s0,sp,80 -> 2 cycles
sd	a0,-72(s0) -> 3 cycles
sd	a1,-80(s0) -> 3 cycles
lui	a5,%hi(.LC2) -> 3 cycles
addi	a0,a5,%lo(.LC2) -> 2 cycles
call	puts -> 2 cycles
call	clock -> 2 cycles
sd	a0,-40(s0) -> 3 cycles
sw	zero,-20(s0) -> 3 cycles
j	.L2 -> 3 cycles
```
Therefore, 
**Clock cycle per instruction (CPI) = Total number of clock cycles / Number of instructions**

So, CPI will be 34 / 13 = 2.6153.

Now, we know, **CPU time = CPI x Number of instructions for a program x Clock cycle time (T)**

Let's assume, T = 200ps.

So, **CPU time = 2.6153 x 13 x 200ps = 6800ps or 6.8ns.**

**3. ALU**

For the assembly program for the ALU by the RISC-V Disassembler, let us assume the clock cycles to see the CPU performance below.
```
addi	sp,sp,-32 -> 2 cycles
sd	ra,24(sp)  -> 3 cycles
sd	s0,16(sp)  -> 3 cycles
addi	s0,sp,32  -> 2 cycles
lui	a5,%hi(.LC0)  -> 3 cycles
addi	a0,a5,%lo(.LC0)  -> 2 cycles
call	printf  -> 2 cycles
addi	a4,s0,-28  -> 2 cycles
addi	a5,s0,-24  -> 2 cycles
mv	a2,a4  -> 3 cycles
mv	a1,a5  -> 3 cycles
lui	a5,%hi(.LC1)  -> 3 cycles
addi	a0,a5,%lo(.LC1)  -> 2 cycles
call	scanf  -> 2 cycles
lui	a5,%hi(.LC2)  -> 3 cycles
addi	a0,a5,%lo(.LC2)  -> 2 cycles
call	printf  -> 2 cycles
addi	a5,s0,-29  -> 2 cycles
mv	a1,a5  -> 3 cycles
lui	a5,%hi(.LC3)  -> 3 cycles
addi	a0,a5,%lo(.LC3)  -> 2 cycles
call	scanf  -> 2 cycles
lbu	a5,-29(s0)  -> 3 cycles
sext.w	a5,a5  -> 2 cycles
mv	a3,a5  -> 3 cycles
li	a4,45  -> 3 cycles
beq	a3,a4,.L2  -> 4 cycles
mv	a3,a5  -> 3 cycles
li	a4,45  -> 3 cycles
bgt	a3,a4,.L3  -> 4 cycles
mv	a3,a5  -> 3 cycles
li	a4,42  -> 3 cycles
beq	a3,a4,.L4  -> 4 cycles
mv	a3,a5  -> 3 cycles
li	a4,43  -> 3 cycles
beq	a3,a4,.L5  -> 4 cycles
mv	a4,a5  -> 3 cycles
li	a5,38  -> 3 cycles
beq	a4,a5,.L6  -> 4 cycles
j	.L7  -> 3 cycles
 
```
Therefore, 
**Clock cycle per instruction (CPI) = Total number of clock cycles / Number of instructions**

So, CPI will be  111 / 40 = 2.775.

Now, we know, **CPU time = CPI x Number of instructions for a program x Clock cycle time (T)**

Let's assume, T = 200ps.

So, **CPU time = 2.775 x 40 x 200ps = 22,200ps or 22.2ns.**

**According to the CPU performance, execution time for counter < execution time for Matrix multiplication < execution time for ALU.**
