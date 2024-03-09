#include<stdio.h>
int main() {

int a,b,result ;
char op;
printf("Enter two numbers:");
scanf("%d %d", &a, &b);

printf("Enter the operation from ADD, SUB, MUL, DIV, OR, AND, XOR : ");
scanf(" %c", &op);

switch(op) {
 case '+':
   result = a + b;
  break;
 
 case '-':
    result = a - b;
  break;

 case '*':
    result = a * b;
  break;

 case '/':
    result = a / b;
  break;

 case '|':
   result = a | b;
  break;

 case '&':
   result = a & b;
  break;

 case '^':
   result = a ^ b;
  break;

 default: 
   printf("Wrong operation");
   return 1;
}

printf("Result is: %d", result);

return 0;

}

    
