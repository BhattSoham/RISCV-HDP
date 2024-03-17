# ASSIGNMENT / TASK 3 #

This section consists of two parts:

i. Verify all the C code (Counter, Matrix multiplication, ALU) using the RISC-V compiler and Spike output.

ii. Measure the CPU performance of all the abovementioned programs using Godbolt or RISC-V disassembler.

## VERIFY ALL THE C CODES (COUNTER, MATRIX MULTIPLICATION, ALU) USING THE RISC-V COMPILER AND SPIKE OUTPUT ##

We must use these commands to generate the assembly codes and results or verify the codes using the RISC-V compiler and Spike.
```
~ riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o filename.o filename.c
~ riscv64-unknown-elf-objdump -d filename.o | less
~ spike pk filename.o
```
All the results after verifying and generating have been given below in the specific parts.

**4-bit Counter**

 C code for the 4-bit counter is provided in the Task 5 section. 

![image1](/week2/task5/RISCV_commands_counter.png)

![image2](/week2/task5/counter_assembly.png)

![image3](/week2/task5/spike_output_counter.png)


**Matrix Multiplication**

 C code for the matrix multiplication is provided in the Task 5 section. 

![image4](/week2/task5/RISCV_commands_matmul.png)

![image5](/week2/task5/matmul_assembly.png)

![image6](/week2/task5/spike_output_matmul.png)

**ALU**

 C code for the ALU is provided in the Task 5 section. 

![image7](/week2/task5/RISCV_commands_ALU.png)

![image8](/week2/task5/ALU_assembly.png)

![image9](/week2/task5/spike_output_ALU.png)

## MEASURE THE CPU PERFORMANCE OF ALL THE ABOVEMENTIONED PROGRAMS USING RISC-V DISASSEMBLER ##

**4-bit Counter**

For the assembly program for the 4-bit counter, let us assume the clock cycles to see the CPU performance below.
```
 addi    sp,sp,-48  -> 2 cycles
 sd      s0,32(sp)  -> 3 cycles
 sd      s2,16(sp)  -> 3 cycles
 sd      s3,8(sp)   -> 3 cycles
 sd      ra,40(sp)  -> 3 cycles
 sd      s1,24(sp)  -> 3 cycles
 li      s0,0       -> 3 cycles
 lui     s3,0x21    -> 3 cycles
 li      s2,16      -> 3 cycles
 mv      a1,s0      -> 4 cycles
 addi    a0,s3,816  -> 2 cycles
>
 addiw   s0,s0,1    -> 2 cycles
 jal     ra,104b4 <printf> -> 4 cycles
 bne     s0,s2,100ec <main+0x3c> -> 4 cycles
 li      s0,0       -> 3 cycles
 jal     ra,10228 <clock> -> 4 cycles
 addi    s1,a0,500 -> 2 cycles
 jal     ra,10228 <clock> -> 4 cycles
 bltu    a0,s1,100f4 <main+0x44> -> 4 cycles
 j       100d4 <main+0x24> -> 2 cycles
```
Therefore, 
**Clock cycle per instruction (CPI) = Total number of clock cycles / Number of instructions**

So, CPI will be 61 / 20 = 3.05.

Now, we know, **CPU time = CPI x Number of instructions for a program x Clock cycle time (T)**

Let's assume, T = 200ps.

So, **CPU time = 3.05 x 20 x 200ps = 261ps.**

**Matrix Multiplication**

For the assembly program for the matrix multiplication, let us assume the clock cycles to see the CPU performance below.
```
   100b0:       00021537                lui     a0,0x21
   100b4:       fd010113                addi    sp,sp,-48
   100b8:       64850513                addi    a0,a0,1608 # 21648 <__clzdi2+0xa0>
   100bc:       02113423                sd      ra,40(sp)
   100c0:       718000ef                jal     ra,107d8 <puts>
   100c4:       000217b7                lui     a5,0x21
   100c8:       5f078793                addi    a5,a5,1520 # 215f0 <__clzdi2+0x48>
   100cc:       0007b603                ld      a2,0(a5)
   100d0:       0087b683                ld      a3,8(a5)
   100d4:       0107b703                ld      a4,16(a5)
   100d8:       0187b783                ld      a5,24(a5)
   100dc:       00010513                mv      a0,sp
   100e0:       01010593                addi    a1,sp,16
   100e4:       00c13023                sd      a2,0(sp)
   100e8:       00d13423                sd      a3,8(sp)
   100ec:       00e13823                sd      a4,16(sp)
   100f0:       00f13c23                sd      a5,24(sp)
   100f4:       0e8000ef                jal     ra,101dc <mulMat>
   100f8:       02813083                ld      ra,40(sp)
   100fc:       00000513                li      a0,0
   10100:       03010113                addi    sp,sp,48
   10104:       00008067                ret


```
