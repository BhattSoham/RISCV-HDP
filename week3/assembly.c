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
