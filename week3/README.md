# OBSTACLE AWARENESS FOR INDIVIDUALS WITH DISABILITIES  #

This section will provide all the necessary details to focus on building a system to detect obstacles for  disabled individuals.

## PROJECT OVERVIEW ##

Improving obstacle awareness for people with impairments is critical for increasing their independence and safety when navigating their surroundings. An infrared sensor can help identify barriers in real-time while delivering information to the user. Integrating these systems into wearable gadgets or mobility aids allows people with impairments to notice and respond to challenges more efficiently, resulting in more freedom and trust in their everyday activities.

## KEY COMPONENTS ##

**1. IR SENSOR DETECTOR:** The project consists of an IR sensor, which will detect if there are any nearby obstacles for the impaired individuals.

**2. RISC-V PROCESSOR:** The processor that will handle all the necessary instructions customized for designing this project.

**3. BUZZER:** The buzzer will help to detect with its controllable 'On' and 'OFF' switches to detect the access.

**4. RESET:** The "Reset" button will be turned on during the operation.

**5. BATTERY:** There will be a battery that the user should charge for the device's operation.

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
/* #include<stdio.h>
#include<stdlib.h> */

int main () {
    int sensor = 1;
    int buzzer;
    int reset;
    int buzzer_reg;
    int mask = 0xFFFFFFFD;  
    buzzer_reg = buzzer * 2;

asm volatile (
    "and x30, x30, %1\n\t"
    "or x30, x30, %0\n\t"
    :
    :"r"(buzzer_reg), "r"(mask)
    :"x30"
     );

while(1) {

  if (reset) {
      buzzer = 0;
      sensor = 0;
      asm volatile (
    "andi %0, x30, 0x0001\n\t"
    :"=r"(reset)
    :
    :
     );
     /* printf("Resetting all values \n");
      printf("Output = %d \n", buzzer); */
     }
  else  {
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
    /* printf("Object detected \n");
     printf("Output = %d \n", buzzer);
     printf("Sensor = %d \n", sensor); */
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
  /*  printf("Object not detected \n");
    printf("Output = %d \n", buzzer);
    printf("Sensor = %d \n", sensor); */
    }
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
   10054:	fd010113          	addi	sp,sp,-48
   10058:	02812623          	sw	s0,44(sp)
   1005c:	03010413          	addi	s0,sp,48
   10060:	00100793          	li	a5,1
   10064:	fef42623          	sw	a5,-20(s0)
   10068:	ffd00793          	li	a5,-3
   1006c:	fef42223          	sw	a5,-28(s0)
   10070:	fe042783          	lw	a5,-32(s0)
   10074:	00179793          	slli	a5,a5,0x1
   10078:	fcf42e23          	sw	a5,-36(s0)
   1007c:	fdc42783          	lw	a5,-36(s0)
   10080:	fe442703          	lw	a4,-28(s0)
   10084:	00ef7f33          	and	t5,t5,a4
   10088:	00ff6f33          	or	t5,t5,a5
   1008c:	fe842783          	lw	a5,-24(s0)
   10090:	00078c63          	beqz	a5,100a8 <main+0x54>
   10094:	fe042023          	sw	zero,-32(s0)
   10098:	fe042623          	sw	zero,-20(s0)
   1009c:	001f7793          	andi	a5,t5,1
   100a0:	fef42423          	sw	a5,-24(s0)
   100a4:	fe9ff06f          	j	1008c <main+0x38>
   100a8:	fec42783          	lw	a5,-20(s0)
   100ac:	02078663          	beqz	a5,100d8 <main+0x84>
   100b0:	00100793          	li	a5,1
   100b4:	fef42023          	sw	a5,-32(s0)
   100b8:	fe042783          	lw	a5,-32(s0)
   100bc:	00179793          	slli	a5,a5,0x1
   100c0:	fcf42e23          	sw	a5,-36(s0)
   100c4:	fdc42783          	lw	a5,-36(s0)
   100c8:	fe442703          	lw	a4,-28(s0)
   100cc:	00ef7f33          	and	t5,t5,a4
   100d0:	00ff6f33          	or	t5,t5,a5
   100d4:	fb9ff06f          	j	1008c <main+0x38>
   100d8:	fe042023          	sw	zero,-32(s0)
   100dc:	fe042783          	lw	a5,-32(s0)
   100e0:	00179793          	slli	a5,a5,0x1
   100e4:	fcf42e23          	sw	a5,-36(s0)
   100e8:	fdc42783          	lw	a5,-36(s0)
   100ec:	fe442703          	lw	a4,-28(s0)
   100f0:	00ef7f33          	and	t5,t5,a4
   100f4:	00ff6f33          	or	t5,t5,a5
   100f8:	f95ff06f          	j	1008c <main+0x38>
```
Running the ***script.py*** file will generate the number of instructions used for the assembly. Run the following command on Linux:

```
python script.py
```
**Output:**

```
Number of different instructions: 10
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



