# DIFFERENCE BETWEEN RISCV COMPILERS AND OTHER COMPILER

*Hello World Program*

At first, we start to write a basic C program for printing Hello World.

```
#include<stdio.h>
int main() {
  printf("Hello World! \n");
  return 0;
}
```
We are using Godbolt [https://godbolt.org/] to show the assembly differences and execution of the code.

**ASSEMBLY DIFFERENCES**
The *HELLO WORLD* program can be differentiated using the mips gcc and riscv32-unknown-elf-gcc toolchain as shown in the below diagram.
![image](week1/helloworld.png)

