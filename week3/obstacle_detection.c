#include<stdio.h>

int main () {

    int sensor = 1;
    int buzzer;
    int reset;

while(1) {

     if (reset) {
      buzzer = 0;
      sensor = 0;
      printf("Resetting all values \n");
     }
   
    else {
 
    if (!sensor) {
     buzzer = 0;
     printf("Object is not detectable \n");
     }

    if(sensor) {
     buzzer = 1;
     printf("Object is detectable \n");
    }
  
  }
}
return 0;

}
