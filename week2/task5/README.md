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

So, **CPU time = 3.05 x 20 x 200ps = 12,200ps or 12.2ns.**

**Matrix Multiplication**

For the assembly program for the matrix multiplication, let us assume the clock cycles to see the CPU performance below.
```
lui     a0,0x21  -> 3 cycles
addi    sp,sp,-48 -> 2 cycles
addi    a0,a0,1608 -> 2 cycles
sd      ra,40(sp) -> 3 cycles
jal     ra,107d8 <puts> -> 4 cycles
lui     a5,0x21 -> 3 cycles
addi    a5,a5,1520 -> 2 cycles
ld      a2,0(a5) -> 3 cycles
ld      a3,8(a5) -> 3 cycles
ld      a4,16(a5) -> 3 cycles
ld      a5,24(a5) -> 3 cycles
mv      a0,sp -> 4 cycles
addi    a1,sp,16 -> 2 cycles
sd      a2,0(sp) -> 3 cycles
sd      a3,8(sp) -> 3 cycles
sd      a4,16(sp) -> 3 cycles
sd      a5,24(sp) -> 3 cycles
jal     ra,101dc <mulMat> -> 4 cycles
ld      ra,40(sp) -> 3 cycles
li      a0,0 -> 3 cycles
addi    sp,sp,48 -> 2 cycles
ret  -> 2 cycles
```
Therefore, 
**Clock cycle per instruction (CPI) = Total number of clock cycles / Number of instructions**

So, CPI will be 63 / 22 = 2.86.

Now, we know, **CPU time = CPI x Number of instructions for a program x Clock cycle time (T)**

Let's assume, T = 200ps.

So, **CPU time = 2.86 x 22 x 200ps = 12,584ps or 12.584ns.**

**ALU**

For the assembly program for the ALU, let us assume the clock cycles to see the CPU performance below.
```
100b0:       0002b537                lui     a0,0x2b
   100b4:       fe010113                addi    sp,sp,-32
   100b8:       d1050513                addi    a0,a0,-752 # 2ad10 <__clzdi2+0x44>
   100bc:       00113c23                sd      ra,24(sp)
   100c0:       57c000ef                jal     ra,1063c <printf>
   100c4:       0002b537                lui     a0,0x2b
   100c8:       00c10613                addi    a2,sp,12
   100cc:       00810593                addi    a1,sp,8
   100d0:       d2850513                addi    a0,a0,-728 # 2ad28 <__clzdi2+0x5c>
   100d4:       5bc000ef                jal     ra,10690 <scanf>
   100d8:       0002b537                lui     a0,0x2b
   100dc:       d3050513                addi    a0,a0,-720 # 2ad30 <__clzdi2+0x64>
   100e0:       55c000ef                jal     ra,1063c <printf>
   100e4:       0002b537                lui     a0,0x2b
   100e8:       00710593                addi    a1,sp,7
   100ec:       d7050513                addi    a0,a0,-656 # 2ad70 <__clzdi2+0xa4>
   100f0:       5a0000ef                jal     ra,10690 <scanf>
   100f4:       00714783                lbu     a5,7(sp)
   100f8:       02d00713                li      a4,45
   100fc:       08e78063                beq     a5,a4,1017c <main+0xcc>
   10100:       02f77c63                bgeu    a4,a5,10138 <main+0x88>
   10104:       05e00713                li      a4,94
   10108:       08e78263                beq     a5,a4,1018c <main+0xdc>
   1010c:       07c00713                li      a4,124
    10110:       08e78863                beq     a5,a4,101a0 <main+0xf0>
   10114:       02f00713                li      a4,47
   10118:       08e78e63                beq     a5,a4,101b4 <main+0x104>
   1011c:       0002b537                lui     a0,0x2b
   10120:       d7850513                addi    a0,a0,-648 # 2ad78 <__clzdi2+0xac>
   10124:       518000ef                jal     ra,1063c <printf>
   10128:       01813083                ld      ra,24(sp)
   1012c:       00100513                li      a0,1
   10130:       02010113                addi    sp,sp,32
   10134:       00008067                ret
   10138:       02a00713                li      a4,42
   1013c:       08e78663                beq     a5,a4,101c8 <main+0x118>
   10140:       02b00713                li      a4,43
   10144:       08e78c63                beq     a5,a4,101dc <main+0x12c>
   10148:       02600713                li      a4,38
   1014c:       fce798e3                bne     a5,a4,1011c <main+0x6c>
   10150:       00812583                lw      a1,8(sp)
   10154:       00c12503                lw      a0,12(sp)
   10158:       00a5f5b3                and     a1,a1,a0
   1015c:       0005859b                sext.w  a1,a1
   10160:       0002b537                lui     a0,0x2b
   10164:       d8850513                addi    a0,a0,-632 # 2ad88 <__clzdi2+0xbc>
   10168:       4d4000ef                jal     ra,1063c <printf>
   1016c:       01813083                ld      ra,24(sp)
   10170:       00000513                li      a0,0
   10174:       02010113                addi    sp,sp,32
   10178:       00008067                ret
   1017c:       00812583                lw      a1,8(sp)
   10180:       00c12503                lw      a0,12(sp)
   10184:       40a585bb                subw    a1,a1,a0
   10188:       fd9ff06f                j       10160 <main+0xb0>
   1018c:       00812583                lw      a1,8(sp)
   10190:       00c12503                lw      a0,12(sp)
   10194:       00a5c5b3                xor     a1,a1,a0
   10198:       0005859b                sext.w  a1,a1
   1019c:       fc5ff06f                j       10160 <main+0xb0>
   101a0:       00812583                lw      a1,8(sp)
   101a4:       00c12503                lw      a0,12(sp)
   101a8:       00a5e5b3                or      a1,a1,a0
   101ac:       0005859b                sext.w  a1,a1
   101b0:       fb1ff06f                j       10160 <main+0xb0>
   101b4:       00c12583                lw      a1,12(sp)
   101b8:       00812503                lw      a0,8(sp)
   101a4:       00c12503                lw      a0,12(sp)
   101a8:       00a5e5b3                or      a1,a1,a0
   101ac:       0005859b                sext.w  a1,a1
   101b0:       fb1ff06f                j       10160 <main+0xb0>
   101b4:       00c12583                lw      a1,12(sp)
   101b8:       00812503                lw      a0,8(sp)
   101bc:       168000ef                jal     ra,10324 <__divdi3>
   101c0:       0005059b                sext.w  a1,a0
   101c4:       f9dff06f                j       10160 <main+0xb0>
   101c8:       00c12583                lw      a1,12(sp)
   101cc:       00812503                lw      a0,8(sp)
   101d0:       0f0000ef                jal     ra,102c0 <__muldi3>
   101d4:       0005059b                sext.w  a1,a0
   101d8:       f89ff06f                j       10160 <main+0xb0>
   101dc:       00812583                lw      a1,8(sp)
   101e0:       00c12503                lw      a0,12(sp)
   101e4:       00a585bb                addw    a1,a1,a0
   101e8:       f79ff06f                j       10160 <main+0xb0>

```
