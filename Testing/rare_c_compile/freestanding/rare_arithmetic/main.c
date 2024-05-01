#include <stdlib.h>
#include "qsort.h"

int main() __attribute__((optimize("O0")));

int main(){

  ////////////////////////////////////////////////////////////////////////////////
  // Memory Mapping
  // 1. Output
  volatile unsigned int *mem_stop_trig = (volatile unsigned int*) (0x000007FC) ; //Memory location for activating the stop signal
  volatile unsigned int *mem_sol_out_a = (volatile unsigned int*) (0x000007F8) ;
  volatile unsigned int *mem_sol_out_b = (volatile unsigned int*) (0x000007F4) ;
  volatile unsigned int *mem_sol_out_c = (volatile unsigned int*) (0x000007F0) ;
  volatile unsigned int *mem_sol_out_d = (volatile unsigned int*) (0x000007EC) ;
  volatile unsigned int *mem_sol_out_e = (volatile unsigned int*) (0x000007E8) ;
  volatile unsigned int *mem_sol_out_f = (volatile unsigned int*) (0x00000784) ;

  ////////////////////////////////////////////////////////////////////////////////

  int number[] = {42, 23, 31, 1, 5, 17, 9, 22, 18, 19, 28, 78, 92, 67, 13, 45, 57, 98, 70, 30, 11, 2, 0, 91, 62};
  // sum: 931 avg: 37.24
  // size of arr
  int sum_myNumbers = 0;
  for (int i = 0; i < 25; i++){
	sum_myNumbers += number[i];
  }
  //average_myNumbers = (float)sum_myNumbers / n;
  
  int sum = 1;
  int product = 1;
  int difference = 10; // Start with 10 and subtract values from it
  int squares_sum = 0; // Sum of squares of numbers

  // Loop from 1 to 10 for primary calculations
  for (int i = 1; i <= 10; i++) {
      sum += i;          // Add i to sum
      product *= i;      // Multiply product by i
      difference -= i;   // Subtract i from difference
      squares_sum += i * i; // Add square of i to squares_sum
  }
  // Calculations without I/O
  int final_sum = sum;
  int final_product = product;
  int final_difference = difference;
  int final_squares_sum = squares_sum;
  // For testing
  
  *mem_sol_out_a = sum;
  *mem_sol_out_b = product;
  *mem_sol_out_c = difference;
  *mem_sol_out_d = squares_sum;
  *mem_sol_out_e = sum_myNumbers;
  
  quicksort(number,0,25-1);
  
  for (int i = 0; i < 25; i++){
  	*(mem_sol_out_f + i) = number[i];
  }     
  //*mem_gpo_0 = 0x00000001;      
  *mem_stop_trig = 0x00000005;

  return 0;
}
