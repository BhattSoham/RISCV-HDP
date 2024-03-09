# Addition using C and Verilog HDL #

We all know how to add. This is the directory for adding two numbers using C and Verilog HDL.

### C Code ###
Let's take a simple example of adding up two numbers. The C code for the addition is :
```
#include<stdio.h>
int main () {
   int num1, num2, result;   // Taking two numbers and a result as integers
   printf("Enter two numbers:"); // Printing the numbers
   scanf("%d %d", &num1, &num2); // Scanning them
   result = num1 + num2; // The functionality of result
   printf("The final result is: %d \n", result); // Printing the result
   return 0;
}
```
We can check the code on Linux too using ***cat*** command.
```
~ cat add.c
```
So, for compiling the C code we have to use the following commands given below:
![Compilation](/week1/Task2/Addition/c.png)

### Verilog Code ###

Now, let us take the same example and run it on Verilog code. To run it on Verilog code, open the "Text Editor" on your Linux machine and demonstrate the behavioral module for a 1-bit adder.
```
module add( 
input num1, num2, cin,  // input and output declaration
output sum, cout);

reg [1:0] temp; // a variable 'temp' to check our sum and carry

always@(*)
   begin
       temp = {1'b0, num1} + {1'b0, num2} + {1'b0, cin}; // Operation of temp
   end

assign sum = temp[0]; // To generate the output for sum
assign cout = temp[1]; //To generate the output for carry out

endmodule 
```
To check whether our behavioral is working perfectly, we have to write a testbench for it.
```
module add_tb();
reg num1, num2, cin; // reg for the inputs and wire for the outputs
wire sum, cout;

add uut ( // Port mapping section with modulo and stimulus
.num1(num1),
.num2(num2),
.cin(cin),
.sum(sum),
.cout(cout)
);

initial begin  
 $dumpfile("add.vcd");   // to generate the vcd file for our waveform
 $dumpvars(1, add_tb);

num1 = 0; num2 = 0; cin = 0; #10; // Test cases, #10 is delaying for 10 ns 
num1 = 0; num2 = 0; cin = 1; #10; // after generating the output.
num1 = 0; num2 = 1; cin = 0; #10;
num1 = 0; num2 = 1; cin = 1; #10;
num1 = 1; num2 = 0; cin = 0; #10;
num1 = 1; num2 = 0; cin = 1; #10;
num1 = 0; num2 = 1; cin = 0; #10;
num1 = 1; num2 = 1; cin = 1; #10;

end

endmodule
```
We can also check our codes on Linux by the following commands:
```
~ cat add.v
~ cat add_tb.v
```
The simulation has been done using Icarus Verilog (A simulation and synthesis tool used for designing and testing digital circuits in Verilog) and GTKWave (A waveform viewer that allows for the visualization of simulation outputs, facilitating the analysis of digital signals). The commands for simulating our verilog code and generating the waveform are given below:
```
~ iverilog -o test_v testbench_file.v behavioral_file.v
~ ./test_v //to open the dump file for generating waveform
~ gtkwave
```
![compilation](/week1/Task2/Addition/verilog_compilation.png)

Also, the RISC-V assembly code for generating the addition using C code using [https://godbolt.org/] is given below:
![Assembly](/week1/Task2/Addition/add_godbolt.png)
The full assembly code can be found here: ![Assembly](/week1/Task2/Addition/add.s)
