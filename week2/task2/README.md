# RV Day 2 #

**Introduction to ABI**

"ABI" or "Application Binary Interface is an interface between two binary program modules in computer software.
The application programmer can directly access the registers of the RISC-V architecture or the hardware resources via a system call and this way is called the Application Binary Interface (ABI) or System Call Interface.

The below picture is detailed regarding the interfaces used from the application program to the hardware. The RISC-V hardware resources can be accessed by the operating system via User and system ISA. The user or the programmer can also access the hardware resources using System ISA.

![image15](/week2/task2/ABI_detailed.png)

If the programmer wants to know the hardware resources of our processor, it has to be done via registers. 

![image16](/week2/task2/ABI_to_Reg.png)

Now, we need to understand the architecture of the registers provided by RISC-V. We have 32 registers for RISC-V architecture. And, the width of the register is defined by the key "XLEN". It is 32 bits for RV32 and 64 bits for RV64.

![image17](/week2/task2/RISCV_reg.png)

Now the question arises, why do we need 32 registers only and how does the ABI access the resources of the processor via registers?

Now, let's take an example given in the below figure. The data provided there is a 64-bit data. So, for storing the 64-bit data in the registers, there are two options. The first one is to store it directly in the memory, which has a limited storage capability due to the 32-bit registers. The next option is to store the data in the registers from memory. The memory can hold 8 bits or 1 byte of data. 

![image18](/week2/task2/Process_of_data.png)

For the given data, it will be split into 8 parts. The first part will go to the LSB and thereby, moving towards the MSB. This process is called the "Little-endian memory addressing system". There's another one for the memory allocation which is called the "Big-endian memory addressing system", where the first part will go to the MSB and thereby move towards the LSB. That is the reverse of the "Little-endian" system.

But RISC-V belongs to the Little-endian memory addressing system".

![image19](/week2/task2/little_endian_memory.png)

1 double word is equal to 32 bits or 4 bytes. From the next picture, it can be concluded, if the address of the first doubleword is m[0]. the address of the second double word will be m[8] and so on.

![image20](/week2/task2/doubleword_2.png)

**LOAD INSTRUCTION**

Let's assume there's an array of 3 doublewords, it will start from m[16].

![image21](/week2/task2/doubleword.png)

Let's say we have to load the value to reg x8. So for that, we have to determine our base address which is x[23], and let it have 0 initially. The command to use it is the "load" command. What the load command does is that it loads the value of the x23 from the memory adding 16 (which is the offset) and stores it back to the register x8. 

![image22](/week2/task2/load.png)

Every instruction in RISC-V is 32 bits, be it a 32-bit register or a 64-bit register. So the 32-bit instruction format of the load command is given below.

![image23](/week2/task2/load_inst_format.png)

**ADD INSTRUCTION**

Another instruction is the "Add" command. To write it, we can present it like this 

![image24](/week2/task2/add.png)

Here, the content of x8 and x24 is added and stored to the reg x8. The 32-bit instruction format through which we can say the computer to do the add command is given below.

![image25](/week2/task2/add_inst_format.png)

**STORE INSTRUCTION**

Another instruction is the "store" command. Here the contents of the reg will be stored back to the memory. It is important because we have a limited number of registers for RISC-V and we have to store it continuously to the memory as it can store more amount of data.

![image26](/week2/task2/store.png)

The 32-bit instruction format for the same is given below.

![image27](/week2/task2/store_inst_format.png)

**Concluding 32-bit registers and their ABI names**

First of all, we have discussed only 3 instructions from the 47 RISC-V instructions. These "load", store" and "add" commands are called "Base Integer Instructions" (RV64I).

![image28](/week2/task2/Base_instructions.png)

Now, the add instruction is an R-type instruction because all the operations are associated with registers.

![image29](/week2/task2/R-type.png)

For the load instruction, it is I-type instruction as the name suggests "Immediate". It is associated with immediate or offset and register operations.

![image30](/week2/task2/I_type.png)

In the case of store instruction, it is S-type instruction as it is associated with only source registers.

![image31](/week2/task2/S_type.png)

Now our previous question was why it is only 32 registers for the RISC-V architecture. The answer is for every register, be it the source or destination, each one is 5 bits to be represented. For that reason, we have 2<sup>5</sup> = 32 integer registers for RISC-V architecture (because to represent the number of bits, we use 2<sup>n</sup>).

![image32](/week2/task2/why_32_reg.png)

The naming convention for the RISC-V registers is 0 to 31. Why? Given in the below figure. For this reason, it is [x0 to x(2<sup>5</sup> - 1)] or [x0 to x31.]

![image32](/week2/task2/patterns.png)

Now the ABI does a system call via these registers. 

![image33](/week2/task2/ABI_via_reg.png)

And it does like this:

![image34](/week2/task2/ABI_names.png)

These are the ABI names through which the programmer accesses the RISC-V CPU core.

![image35](/week2/task2/ABI_names_2.png)

***2. Labwork using ABI function calls***

We will re-write our C program to get the sum from 1 to n using assembly language. 

![image36](/week2/task2/Sum_using_ASM.png)

The algorithm which will be used for writing the assembly language is given below.

![image37](/week2/task2/Algo_ASM.png)

We will write a small C code again to sum 1 to n using a customized version. 
```
#include<stdio.h> // standard library

extern int load(int x, int y) // load is an external function with two arguments x and y and which will return integer

int main() {
      int result = 0, count = 9; // initializing result as 0 and count as 9
      result = load(0x0, count+1); // this shows load has two arguments with 0x0 which is 0 in decimal, and count + 1 is 9+1 = 10, so the load is called with two values 0 and 10 and it is assigned to result
      printf("Sum of numbers from 1 to %d is %d\n", result, count); // printing the sum

}
```
For the assembly, it is given below for the previous algorithm.
```
.section .text // Part of the text section, which typically contains executable instructions.
.global load // Load as global, meaning it can be accessed from other parts of the program
.type load, @function // Load as a function type

load: add a4, a0, zero // Initialize sum reg a4 as 0x0
      add a3, a0, zero // Initialize intermediate reg a3 by 0
      add a2, a0, a1 // adding a0 (0) and a1(10) and storing 10 to a2
loop: add a4, a3, a4 // a4 = a3 + a4
      add a3, a3, 1 // a3 = a3 + 1
      blt a3, a2, loop // if a3 < a2, returns to the branch label : loop section
      add a0, a4, zero // otherwise, store final result to a0 so that it can be read by the main program
      ret // return a0
```
For the result, if our code is right, we run it using the RISC-V compiler using the below commands:
```
~ riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o 1to9_custom.o 1to9_custom.c load.S
~ spike pk 1to9_custom.o
```
![image38](/week2/task2/riscv_1to9_custom.png)

For disassembling, we use the following command:
```
~ riscv64-unknown-elf-objdump -d 1to9_custom.o | less
```
![image39](/week2/task2/Disassembling.png)

If we see the code, it passes the variables a0 and a1 only. And load is assigned to jump and it does the operation.

***3. Basic verification flow using Iverilog.***

Till now, we have worked on simulation. Now, we want to verify our code on a small PicoRV32 RISC-V CPU core.

![image40](/week2/task2/C_on_RISCV_CPU.png)

We can generate the hex file and display the result using the following commands and the images are given below. 

![image41](/week2/task2/hex_gen_commands.png)

![image42](/week2/task2/hex_file.png)


