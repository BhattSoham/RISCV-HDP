#include<stdio.h>

int main() {
int i, result = 0, n = 5;
for(i = 1; i<=n; ++i) {
   result += i;
}
printf("The result of sum from 1 to %d is %d \n", n, result);
return 0;
}
