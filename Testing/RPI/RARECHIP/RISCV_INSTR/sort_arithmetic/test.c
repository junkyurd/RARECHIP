#include <stddef.h>

int main() __attribute__((optimize("O0")));
void *memcpy(void *dest, const void *src, size_t n)
{
    for (size_t i = 0; i < n; i++)
    {
        ((char*)dest)[i] = ((char*)src)[i];
    }
}

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
  volatile unsigned int *mem_sol_out_f = (volatile unsigned int*) (0x000007E4) ;

  ////////////////////////////////////////////////////////////////////////////////

  int myNumbers[] = {94, 5, 67, 82, 93, 31, 46, 37, 21, 80, 41, 71, 65, 84, 72, 89, 25, 18, 61, 28, 14, 42, 60, 95, 56, 50, 99, 6, 97, 55, 66, 29, 12, 38, 4, 36, 27, 35, 79, 11, 9, 24, 98, 7, 26, 15, 49, 40, 19, 78};
  // average is 46, sum is 2300
  // sort = {4, 5, 6, 7, 9, 11, 12, 14, 15, 18, 19, 21, 24, 25, 26, 27, 28, 29, 31, 35, 36, 37, 38, 40, 41, 42, 46, 49, 50, 55, 56, 60, 61, 65, 66, 67, 71, 72, 78, 79, 80, 82, 84, 89, 93, 94, 95, 97, 98, 99}
  // size of arr
  int n = sizeof(myNumbers)/sizeof(myNumbers[0]);
  int sum_myNumbers = 0;
  float average_myNumbers;
  for (int i = 0; i < n; i++){
	sum_myNumbers += myNumbers[i];
  }
  average_myNumbers = (float)sum_myNumbers / n;
  
  // sort myNumbers
  int temp;
  for (int i = 0; i < n-1; i++){
	for (int j = 0; i < n-i-1; j++) {
		if (myNumbers[j] > myNumbers[j+1]){
			temp = myNumbers[j];
			myNumbers[j] = myNumbers[j+1];
			myNumbers[j+1] = temp;
		}
	}
  }

  int sum = 1;
  int product = 1;
  int difference = 10; // Start with 10 and subtract values from it
  int squares_sum = 0; // Sum of squares of numbers

  // Loop from 1 to 5 for primary calculations
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

  
  //Finalize Algorithm, RISCV_READY = 1
        
  //*mem_gpo_0 = 0x00000001;      
  *mem_stop_trig = 0x00000005;

  return 0;
}