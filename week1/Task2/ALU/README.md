# 4-bit ALU using C and Verilog #
### C Code ###
The C code for implementing a 4-bit ALU has been given here: ![ALU_C_Code](/week1/Task2/ALU/alu.c)
The code can be watched on Linux using the following command:
```
~ cat alu.c
```
So, for compiling the C code we have to use the following commands given below:
![Compilation](/week1/Task2/ALU/c_compilation.png)

### Verilog Code ###

   Now, let us take the same example and run it on Verilog code. To run it on Verilog code, open the "Text Editor" on your Linux machine and demonstrate the behavioral module for a 4-bit ALU. The Verilog code can be found here: ![ALU_verilog](week1/Task2/ALU/ALU.v)

To check whether our behavioral is working perfectly, we have to write a testbench for it. The test bench can be found here: ![ALU_test_bench](/week1/Task2/ALU/ALU_tb.v)

We can also check our codes on Linux by the following commands:
```
~ cat ALU.v
~ cat ALU_tb.v
```
The simulation has been done using Icarus Verilog (A simulation and synthesis tool used for designing and testing digital circuits in Verilog) and GTKWave (A waveform viewer that allows for the visualization of simulation outputs, facilitating the analysis of digital signals). The commands for simulating our verilog code and generating the waveform are given below:
```
~ iverilog -o test_v testbench_file.v behavioral_file.v
~ ./test_v //to open the dump file for generating waveform
~ gtkwave
```
![compilation](/week1/Task2/ALU/ALU_tb.png)
![waveform](/week1/Task2/ALU/waveform.png)

RISC-V assembly code has been generated for our C code using Godbolt (https://godbolt.org/)
![Assembly_SS](/week1/Task2/ALU/ALU_godbolt.png)
The full assembly code can be found here: ![Assembly](week1/Task2/ALU/ALU.s)


