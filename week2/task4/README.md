# Basic RISC-V Microarchitecture Implementation #

RISC-V microarchitecture refers to the internal design and organization of a processor based on the RISC-V instruction set architecture (ISA). We will focus on several steps before making the whole implementation.

## Introduction to Program Counter and Instruction Memory ##

We have seen several RISC-V ISAs previously in the given directory [week2/task1].

Let's see the image given below.

![image1](/week2/task4/instruction_classes.png)

Here, the instruction memory or "IMEM" is just an "SRAM" or "Static Random Access Memory". In the IMEM, there are several instructions specified. So, what is happening, is the memory has two states: i. Read, and ii. Write.
All the states with the instructions are given above along with the program counter. The program counter is nothing but the address specified before the instructions and it is incrementing with PC+4.  

Two points need to be identified from the above picture: 

**a. The program counter (PC) contains the address of the current instruction.**

**b. Every instruction reads one or two registers.**

## Introduction to Register File and Data Memory ##

'PC" or the program counter is a 32-bit register. Other than that, we have another 32 registers with 32 bits each for RISC-V microarchitecture.

If we see these pictures, there are logical and arithmetic operations, where ALU has been used. There is another picture given for the data memory.

![image2](/week2/task4/arith_operations.png)

![image3](/week2/task4/logical_operations.png)

![image4](/week2/task4/dmem.png)

**Now the question arises, is only the register going to the ALU unit?**
 The answer is that we have to define that we need to pass the immediate value or the register from the instruction to the ALU unit.

 Also, there are two instructions like "load" and "store", where our memory is associated. As we see in the previous figure, there is a hard value added to the stack pointer, which is the memory address location. That immediate value is not coming from the register. 
 
![image5](/week2/task4/datapath_till_reg_alu.png)

In the above figure, that [8+sp] is been calculated by the ALU, and the content of the mem[8+sp] address will be sent back to the a2 register through the load instruction.



