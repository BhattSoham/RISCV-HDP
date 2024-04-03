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
riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -ffreestanding  -o out assembly.c
riscv64-unknown-elf-objdump -d  -r out > obstacle_detection.txt
```

```

output:     file format elf64-littleriscv


Disassembly of section .text:
00010144 <main>:
   10144:	fd010113          	addi	sp,sp,-48
   10148:	02812623          	sw	s0,44(sp)
   1014c:	03010413          	addi	s0,sp,48
   10150:	00100793          	li	a5,1
   10154:	fef42623          	sw	a5,-20(s0)
   10158:	ffd00793          	li	a5,-3
   1015c:	fef42223          	sw	a5,-28(s0)
   10160:	fe042783          	lw	a5,-32(s0)
   10164:	00179793          	slli	a5,a5,0x1
   10168:	fcf42e23          	sw	a5,-36(s0)
   1016c:	fdc42783          	lw	a5,-36(s0)
   10170:	fe442703          	lw	a4,-28(s0)
   10174:	00ef7f33          	and	t5,t5,a4
   10178:	00ff6f33          	or	t5,t5,a5
   1017c:	fe842783          	lw	a5,-24(s0)
   10180:	00078c63          	beqz	a5,10198 <main+0x54>
   10184:	fe042023          	sw	zero,-32(s0)
   10188:	fe042623          	sw	zero,-20(s0)
   1018c:	001f7793          	andi	a5,t5,1
   10190:	fef42423          	sw	a5,-24(s0)
   10194:	fe9ff06f          	j	1017c <main+0x38>
   10198:	fec42783          	lw	a5,-20(s0)
   1019c:	02078663          	beqz	a5,101c8 <main+0x84>
   101a0:	00100793          	li	a5,1
   101a4:	fef42023          	sw	a5,-32(s0)
   101a8:	fe042783          	lw	a5,-32(s0)
   101ac:	00179793          	slli	a5,a5,0x1
   101b0:	fcf42e23          	sw	a5,-36(s0)
   101b4:	fdc42783          	lw	a5,-36(s0)
   101b8:	fe442703          	lw	a4,-28(s0)
   101bc:	00ef7f33          	and	t5,t5,a4
   101c0:	00ff6f33          	or	t5,t5,a5
   101c4:	fb9ff06f          	j	1017c <main+0x38>
   101c8:	fe042023          	sw	zero,-32(s0)
   101cc:	fe042783          	lw	a5,-32(s0)
   101d0:	00179793          	slli	a5,a5,0x1
   101d4:	fcf42e23          	sw	a5,-36(s0)
   101d8:	fdc42783          	lw	a5,-36(s0)
   101dc:	fe442703          	lw	a4,-28(s0)
   101e0:	00ef7f33          	and	t5,t5,a4
   101e4:	00ff6f33          	or	t5,t5,a5
   101e8:	f95ff06f          	j	1017c <main+0x38>
```
Running the /week3/script.py file, it will generate the number of instructions used for the assembly.
```
Number of different instructions: 31
List of unique instructions:
and
bltz
lbu
bnez
bltu
beqz
andi
sub
blt
add
ret
li
lw
jal
auipc
addi
bgeu
srai
jr
jalr
j
sw
ecall
sll
mv
slli
bne
neg
sb
beq
or
```



