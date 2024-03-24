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

The inline C code for the obstacle detection is given below.
```
#include<stdio.h>
#include<stdlib.h>

int main () {
    int sensor = 0;
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
      printf("Resetting all values \n");
      printf("Output = %d \n", buzzer);
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
     printf("Object detected \n");
     printf("Output = %d \n", buzzer);
     printf("Sensor = %d \n", sensor);
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
    printf("Object not detected \n");
    printf("Output = %d \n", buzzer);
    printf("Sensor = %d \n", sensor);
    }
  }
 


}


return 0;

}
```
## TESTING ##
Run the following commands:
```
riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -ffreestanding  -o output assembly.c
spike pk output
```
If sensor = 0:

![image4](/week3/result1.png)


If sensor = 1:

![image5](/week3/result2.png)

## ASSEMBLY CODE GENERATION ##

For converting C code into the RISC-V assembly, run the following commands:
```
riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -ffreestanding  -o output assembly.c
riscv64-unknown-elf-objdump -d  -r out > obstacle_detection_assembly.txt
```

```

output:     file format elf64-littleriscv


Disassembly of section .text:
0000000000010184 <main>:
   10184:	fd010113          	addi	sp,sp,-48
   10188:	02113423          	sd	ra,40(sp)
   1018c:	02813023          	sd	s0,32(sp)
   10190:	03010413          	addi	s0,sp,48
   10194:	00100793          	li	a5,1
   10198:	fef42623          	sw	a5,-20(s0)
   1019c:	ffd00793          	li	a5,-3
   101a0:	fef42223          	sw	a5,-28(s0)
   101a4:	fe042783          	lw	a5,-32(s0)
   101a8:	0017979b          	slliw	a5,a5,0x1
   101ac:	fcf42e23          	sw	a5,-36(s0)
   101b0:	fdc42783          	lw	a5,-36(s0)
   101b4:	fe442703          	lw	a4,-28(s0)
   101b8:	00ef7f33          	and	t5,t5,a4
   101bc:	00ff6f33          	or	t5,t5,a5
   101c0:	fe842783          	lw	a5,-24(s0)
   101c4:	0007879b          	sext.w	a5,a5
   101c8:	02078c63          	beqz	a5,10200 <main+0x7c>
   101cc:	fe042023          	sw	zero,-32(s0)
   101d0:	fe042623          	sw	zero,-20(s0)
   101d4:	001f7793          	andi	a5,t5,1
   101d8:	fef42423          	sw	a5,-24(s0)
   101dc:	000217b7          	lui	a5,0x21
   101e0:	29078513          	addi	a0,a5,656 # 21290 <__clzdi2+0x48>
   101e4:	334000ef          	jal	ra,10518 <printf>
   101e8:	fe042783          	lw	a5,-32(s0)
   101ec:	00078593          	mv	a1,a5
   101f0:	000217b7          	lui	a5,0x21
   101f4:	2a878513          	addi	a0,a5,680 # 212a8 <__clzdi2+0x60>
   101f8:	320000ef          	jal	ra,10518 <printf>
   101fc:	fc5ff06f          	j	101c0 <main+0x3c>
   10200:	fec42783          	lw	a5,-20(s0)
   10204:	0007879b          	sext.w	a5,a5
   10208:	06078063          	beqz	a5,10268 <main+0xe4>
   1020c:	00100793          	li	a5,1
   10210:	fef42023          	sw	a5,-32(s0)
   10214:	fe042783          	lw	a5,-32(s0)
   10218:	0017979b          	slliw	a5,a5,0x1
   1021c:	fcf42e23          	sw	a5,-36(s0)
   10220:	fdc42783          	lw	a5,-36(s0)
   10224:	fe442703          	lw	a4,-28(s0)
   10228:	00ef7f33          	and	t5,t5,a4
   1022c:	00ff6f33          	or	t5,t5,a5
   10230:	000217b7          	lui	a5,0x21
   10234:	2b878513          	addi	a0,a5,696 # 212b8 <__clzdi2+0x70>
   10238:	2e0000ef          	jal	ra,10518 <printf>
   1023c:	fe042783          	lw	a5,-32(s0)
   10240:	00078593          	mv	a1,a5
   10244:	000217b7          	lui	a5,0x21
   10248:	2a878513          	addi	a0,a5,680 # 212a8 <__clzdi2+0x60>
   1024c:	2cc000ef          	jal	ra,10518 <printf>
   10250:	fec42783          	lw	a5,-20(s0)
   10254:	00078593          	mv	a1,a5
   10258:	000217b7          	lui	a5,0x21
   1025c:	2d078513          	addi	a0,a5,720 # 212d0 <__clzdi2+0x88>
   10260:	2b8000ef          	jal	ra,10518 <printf>
   10264:	f5dff06f          	j	101c0 <main+0x3c>
   10268:	fe042023          	sw	zero,-32(s0)
   1026c:	fe042783          	lw	a5,-32(s0)
   10270:	0017979b          	slliw	a5,a5,0x1
   10274:	fcf42e23          	sw	a5,-36(s0)
   10278:	fdc42783          	lw	a5,-36(s0)
   1027c:	fe442703          	lw	a4,-28(s0)
   10280:	00ef7f33          	and	t5,t5,a4
   10284:	00ff6f33          	or	t5,t5,a5
   10288:	000217b7          	lui	a5,0x21
   1028c:	2e078513          	addi	a0,a5,736 # 212e0 <__clzdi2+0x98>
   10290:	288000ef          	jal	ra,10518 <printf>
   10294:	fe042783          	lw	a5,-32(s0)
   10298:	00078593          	mv	a1,a5
   1029c:	000217b7          	lui	a5,0x21
   102a0:	2a878513          	addi	a0,a5,680 # 212a8 <__clzdi2+0x60>
   102a4:	274000ef          	jal	ra,10518 <printf>
   102a8:	fec42783          	lw	a5,-20(s0)
   102ac:	00078593          	mv	a1,a5
   102b0:	000217b7          	lui	a5,0x21
   102b4:	2d078513          	addi	a0,a5,720 # 212d0 <__clzdi2+0x88>
   102b8:	260000ef          	jal	ra,10518 <printf>
   102bc:	f05ff06f          	j	101c0 <main+0x3c>
```




