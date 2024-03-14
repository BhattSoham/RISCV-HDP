# RISC-V based MYTH Workshop #

This is part of a workshop "RISC-V based MYTH" conducted by VLSI System Design.

This section will cover all the basics required related to RISC-V ISA. 

The following are as follows:

**RV Day 1**

***1. Introduction to RISC-V ISA and GNU compiler toolchain:***
   
  a. Introduction to RISC-V basic keywords.
  
  b. Labwork for RISC-V software toolchain.

  c. Integer number representation.

**RV Day 2**  

***2. Introduction to ABI and basic verification flow:***
   
  a. Application Binary Interface (ABI).
  
  b. Labwork using ABI function calls.

  c. Basic verification flow using Iverilog.

## RV Day 1 ##

**Introduction**

a. Introduction to RISC-V basic keywords: 

RISC-V instruction set architecture (ISA) is the language of the computer. So, the question arises how can our C program turn into a hardware representation? The answer is whenever we are writing any C program, that program is generally our "Source Code". That source code will convert into assembly language using any compiler. The compiler will turn our code into specific instructions through a ".exe" file. The Assembler then takes our file and converts it into binary, which is termed the "machine language" or "machine code". And the machine code will be used to do the layout for our design or the hardware representation will be created using that machine language.


