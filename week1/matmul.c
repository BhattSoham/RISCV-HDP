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
