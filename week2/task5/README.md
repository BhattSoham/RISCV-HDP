# ASSIGNMENT / TASK 3 #

This section consists of two parts:

i. Verify all the C code (Counter, Matrix multiplication, ALU) using the RISC-V compiler and Spike ISA simulator.

ii. Measure the CPU performance of all the abovementioned programs using Godbolt or RISC-V disassembler.

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

## MEASURE THE CPU PERFORMANCE OF ALL THE ABOVEMENTIONED PROGRAMS USING GODBOLT OR RISC-V DISASSEMBLER ##

Let us assume the number of clock cycles for the RISC-V instructions.

**Instructions associated with add, mul, div: 2 cycles.**

**Instructions associated with load, store, and move: 3 cycles.**

**Instructions associated with jump, and branch: 4 cycles.**

**All other Instructions: 2 cycles.**

**1. 4-bit Counter**

For the assembly program for the 4-bit counter by RISC-V Disassembler, let us assume the clock cycles to see the CPU performance below.
```
addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sw	zero,-20(s0)
  -> 2 cycles
```
Therefore, 
**Clock cycle per instruction (CPI) = Total number of clock cycles / Number of instructions**

So, CPI will be 61 / 20 = 3.05.

Now, we know, **CPU time = CPI x Number of instructions for a program x Clock cycle time (T)**

Let's assume, T = 200ps.

So, **CPU time = 3.05 x 20 x 200ps = 12,200ps or 12.2ns.**

**2. Matrix Multiplication**

For the assembly program for the matrix multiplication by RISC-V Disassembler, let us assume the clock cycles to see the CPU performance below.
```
addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	addi	s0,sp,80
	sd	a0,-72(s0)
	sd	a1,-80(s0)
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	puts
	call	clock
	sd	a0,-40(s0)
	sw	zero,-20(s0)
	j	.L2
```
Therefore, 
**Clock cycle per instruction (CPI) = Total number of clock cycles / Number of instructions**

So, CPI will be 63 / 22 = 2.86.

Now, we know, **CPU time = CPI x Number of instructions for a program x Clock cycle time (T)**

Let's assume, T = 200ps.

So, **CPU time = 2.86 x 22 x 200ps = 12,584ps or 12.584ns.**

**3. ALU**

For the assembly program for the ALU by Godbolt, let us assume the clock cycles to see the CPU performance below.
```
addi    sp,sp,-32 -> 2 cycles
sw      ra,28(sp) -> 3 cycles
sw      s0,24(sp) -> 3 cycles
addi    s0,sp,32 -> 2 cycles
lui     a5,%hi(.LC0) -> 3 cycles
addi    a0,a5,%lo(.LC0) -> 2 cycles
call    printf -> 2 cycles
addi    a4,s0,-28 -> 2 cycles
addi    a5,s0,-24 -> 2 cycles
mv      a2,a4 -> 3 cycles
mv      a1,a5 -> 3 cycles
lui     a5,%hi(.LC1) -> 3 cycles
addi    a0,a5,%lo(.LC1) -> 2 cycles
call    __isoc99_scanf -> 2 cycles
lui     a5,%hi(.LC2) -> 3 cycles
addi    a0,a5,%lo(.LC2) -> 2 cycles
call    printf -> 2 cycles
addi    a5,s0,-29 -> 2 cycles
mv      a1,a5 -> 3 cycles
lui     a5,%hi(.LC3) -> 3 cycles
addi    a0,a5,%lo(.LC3) -> 2 cycles
call    __isoc99_scanf -> 2 cycles
lbu     a5,-29(s0) -> 3 cycles
li      a4,124 -> 3 cycles
beq     a5,a4,.L2 -> 4 cycles
li      a4,124 -> 3 cycles
bgt     a5,a4,.L3 -> 4 cycles
li      a4,47 -> 3 cycles
bgt     a5,a4,.L4 -> 4 cycles
li      a4,38 -> 3 cycles
blt     a5,a4,.L3 -> 4 cycles
addi    a5,a5,-38 -> 2 cycles
li      a4,9 -> 3 cycles
bgtu    a5,a4,.L3 -> 4 cycles
slli    a4,a5,2 -> 4 cycles
lui     a5,%hi(.L6) -> 3 cycles
addi    a5,a5,%lo(.L6) -> 2 cycles
add     a5,a4,a5 -> 2 cycles
lw      a5,0(a5) -> 3 cycles
jr      a5 -> 4 cycles
 
```
Therefore, 
**Clock cycle per instruction (CPI) = Total number of clock cycles / Number of instructions**

So, CPI will be  111 / 40 = 2.775.

Now, we know, **CPU time = CPI x Number of instructions for a program x Clock cycle time (T)**

Let's assume, T = 200ps.

So, **CPU time = 2.775 x 40 x 200ps = 22,200ps or 22.2ns.**
