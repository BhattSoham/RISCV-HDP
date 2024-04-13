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
