# OBSTACLE AWARENESS FOR INDIVIDUALS WITH DISABILITIES  #

This section will provide all the necessary details to focus on building a system to detect obstacles for  disabled individuals.

## PROJECT OVERVIEW ##

Improving obstacle awareness for people with impairments is critical for increasing their independence and safety when navigating their surroundings. An infrared sensor can help identify barriers in real-time while delivering information to the user. Integrating these systems into wearable gadgets or mobility aids allows people with impairments to notice and respond to challenges more efficiently, resulting in more freedom and trust in their everyday activities.

## KEY COMPONENTS ##

**1. IR SENSOR DETECTOR:** The project consists of an IR sensor, which will detect if there are any nearby obstacles for the impaired individuals.

**2. RISC-V PROCESSOR:** The processor that will handle all the necessary instructions customized for designing this project.

**3. BUZZER:** The buzzer will help to detect with its controllable 'On' and 'OFF' switches to detect the access.

**4. BATTERY:** There will be a battery that the user should charge for the device's operation.

## BLOCK DIAGRAM #

![image1](/week3/Block_Diagram.png)

# BASIC C CODE #

At first, we start with writing a basic C code for our block diagram.
```
#include<stdio.h>

int main () {
// INITIALIZATION
    int sensor = 1;
    int buzzer;
    int reset;

while(1) {
// RESET STAGE
     if (reset) {
      buzzer = 0;
      sensor = 0;
      printf("Resetting all values \n");
     }
   
    else {
// IF SENSOR = 0 
    if (!sensor) {
     buzzer = 0;
     printf("Object is not detectable \n");
     }
// IF SENSOR = 1
    if(sensor) {
     buzzer = 1;
     printf("Object is detectable \n");
    }
  
  }
}
return 0;

}
```
## TESTING THE CODE ##

 1. Open a terminal window
 2. Navigate to the directory when the .c file is present.
 3. Compile the code designed using gcc and RISC-V compilers and verify the output.


## OBSERVATION USING GCC COMPILER ##

Run the following commands:
```
gcc obstacle_detection.c
./a.out
```
![image2](/week3/gcc_output.png)

This is applicable when the sensor = 1.

## OBSERVATION USING RISCV COMPILER ##

Run the following commands:
```
riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o obstacle_detection.o obstacle_detection.c
spike pk obstacle_detection
```
![image2](/week3/spike_simulation.png)

## ASSEMBLY CODE GENERATION ##

For the assembly code generation, run the following commands:
```
riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o obstacle_detection.o obstacle_detection.c
riscv64-unknown-elf-objdump -d obstacle_detection.o | less
```
![image3](/week3/riscv_assembly.png)

# OBSTACLE DETECTION WITH INLINE ASSEMBLY #

The inline assembly code for the obstacle detection is given below.
```
// #include<stdio.h>
// #include<stdlib.h> 

int main () {
    int sensor ;
    int buzzer=0 ;
 
    int buzzer_reg ;
    int mask = 0xFFFFFFFD;  
    buzzer_reg = buzzer * 2;

asm volatile(
	"and x30, x30, %1\n\t"
    	"or x30, x30, %0\n\t"  
    	:
    	: "r" (buzzer_reg), "r"(mask)
	: "x30" 
	);

while(1) {

asm volatile(
		"andi %0, x30, 0x01\n\t"
		: "=r" (sensor)
		:
		:);
 
   if (sensor) {
     buzzer = 1;
     buzzer_reg = buzzer * 2;
     asm volatile (
    "and x30, x30, %1\n\t"
    "or x30, x30, %0\n\t"
    :
    :"r"(buzzer_reg), "r"(mask)
    :"x30"
     );
 //   printf("Object detected \n");
   //  printf("Output = %d \n", buzzer);
    // printf("Sensor = %d \n", sensor); 
     }

    else {
     buzzer = 0;
     buzzer_reg = buzzer * 2;
    asm volatile (
    "and x30, x30, %1\n\t"
    "or x30, x30, %0\n\t"
    :
    :"r"(buzzer_reg), "r"(mask)
    :"x30"
     );
 //   printf("Object not detected \n");
 //   printf("Output = %d \n", buzzer);
 //   printf("Sensor = %d \n", sensor); 
    }
  }
 
return 0;

}
```
## TESTING ##
Run the following commands:
```
riscv64-unknown-elf-gcc -march=rv64i -mabi=lp64 -ffreestanding  -o output assembly.c
spike pk output
```
If sensor = 0:

![image4](/week3/result1.png)


If sensor = 1:

![image5](/week3/result2.png)

## ASSEMBLY CODE GENERATION ##

For converting C code into the RISC-V assembly, run the following commands:
```
riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -ffreestanding -nostdlib  -o out assembly.c
riscv64-unknown-elf-objdump -d  -r out > obstacle_detection.txt
```

```


out:     file format elf32-littleriscv


Disassembly of section .text:

00010054 <main>:
   10054:	fe010113          	addi	sp,sp,-32
   10058:	00812e23          	sw	s0,28(sp)
   1005c:	02010413          	addi	s0,sp,32
   10060:	fe042623          	sw	zero,-20(s0)
   10064:	ffd00793          	li	a5,-3
   10068:	fef42423          	sw	a5,-24(s0)
   1006c:	fec42783          	lw	a5,-20(s0)
   10070:	00179793          	slli	a5,a5,0x1
   10074:	fef42223          	sw	a5,-28(s0)
   10078:	fe442783          	lw	a5,-28(s0)
   1007c:	fe842703          	lw	a4,-24(s0)
   10080:	00ef7f33          	and	t5,t5,a4
   10084:	00ff6f33          	or	t5,t5,a5
   10088:	001f7793          	andi	a5,t5,1
   1008c:	fef42023          	sw	a5,-32(s0)
   10090:	fe042783          	lw	a5,-32(s0)
   10094:	02078663          	beqz	a5,100c0 <main+0x6c>
   10098:	00100793          	li	a5,1
   1009c:	fef42623          	sw	a5,-20(s0)
   100a0:	fec42783          	lw	a5,-20(s0)
   100a4:	00179793          	slli	a5,a5,0x1
   100a8:	fef42223          	sw	a5,-28(s0)
   100ac:	fe442783          	lw	a5,-28(s0)
   100b0:	fe842703          	lw	a4,-24(s0)
   100b4:	00ef7f33          	and	t5,t5,a4
   100b8:	00ff6f33          	or	t5,t5,a5
   100bc:	fcdff06f          	j	10088 <main+0x34>
   100c0:	fe042623          	sw	zero,-20(s0)
   100c4:	fec42783          	lw	a5,-20(s0)
   100c8:	00179793          	slli	a5,a5,0x1
   100cc:	fef42223          	sw	a5,-28(s0)
   100d0:	fe442783          	lw	a5,-28(s0)
   100d4:	fe842703          	lw	a4,-24(s0)
   100d8:	00ef7f33          	and	t5,t5,a4
   100dc:	00ff6f33          	or	t5,t5,a5
   100e0:	fa9ff06f          	j	10088 <main+0x34>
```
Running the ***script.py*** file will generate the number of instructions used for the assembly. Run the following command on Linux:

```
python script.py
```
**Output:**

```
Number of different instructions:10
List of unique instructions:
and
andi
j
sw
li
lw
slli
beqz
or
addi


```



