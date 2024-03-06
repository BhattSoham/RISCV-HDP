# DIFFERENCE BETWEEN RISCV COMPILERS AND OTHER COMPILER

**Hello World**

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
![image](/week1/helloworld.png)

**Counter**

The next program we are focusing on is on implementation of a 5-bit counter using the C program.
```
#include<stdio.h>
#include<time.h>

void delay(int n){
int us = n; // initializing the time as an integer and which is 'n'
start_time clock_unit = clock(); // defining start_time variable as clock_unit and assigning it's value as clock()
while(clock() < start_time + (us * CLOCK_PERIOD / 1000000); // while condition if clock() is less than the mentioned condition
}

void display(int count) {   // Function to display
printf("Count value is: %d\n", count); // printing the count value
}
int count = 0x00000000;
	while (1) //infinite loop
	{
		display(count);
		count++; //counter is incrementing
        if(count==16){ //  if it's a 5-bit counter, then reset the count value to 0
            count=0; 
        }
		delay(500000); // delay of 0.5 ms
	}
}
```
We can see the difference between the assembly instructions using the riscv64-unknown-elf-gcc toolchain and the x86-64 gcc compilers.
![image](/week1/4_bit_counter.png)

Now, let us modify the 4-bit counter to the 7-bit counter and see the difference.
![image2](/week1/7_bit_counter.png)

**Matrix Multiplication**

Another program that we are going to implement is matrix multiplication.
```
#include<stdio.h>
#include<stdlib.h>
#include<time.h>

#define R1 2
#define R2 2
#define C1 2
#define C2 2

void mulMat(int mat1[][C1], int mat2[][C2])
{
        int res[R1][C2];
        printf("Multiplication of given two matrices is:\n");

        clock_t start_time, end_time;
        start_time = clock() ;

        for (int i = 0; i < R1; i++) {
                for (int j = 0; j < C2; j++) {
                        res[i][j] = 0;

                        for (int k = 0; k < R2; k++) {
                                res[i][j] += mat1[i][k] * mat2[k][j];
                        }
                        printf("%d\t", res[i][j]);
                }
                printf("\n");
        }
end_time = clock() ;
}

int main () {
    printf("Start Matrix Multiplication: \n");
      int mat1[R1][C1] = { {1,2} , {3,4}};
      int mat2[R2][C2] = { {3,4} , {4,5}};

      if (C1 != R2) {
        printf(" Wrong execution \n");
        exit(EXIT_FAILURE);
      }
      mulMat(mat1, mat2);
      return 0;
}
```





