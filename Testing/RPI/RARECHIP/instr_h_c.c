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

  // 3. Accelerator, 8bit width x (Address[11:0] + 1bit register)
  //volatile signed char (*mem_acc)[64][64]  = (void*) (0xFFFF0000) ;  // start of acc-cache
  // 4. TSMC SRAM , 8bit width x Address[14:0], (32bit width x Address[14:2])

  //volatile signed char (*mem_data)[64][64] = (void*) (0xFFFF8000) ;  // start of data-cache
  //volatile char *mem_acc_reg      = (volatile char*) (0xFFFF1000) ;

  ////////////////////////////////////////////////////////////////////////////////

  int sum = 0;
  int product = 1;
  int difference = 10; // Start with 10 and subtract values from it
  int squares_sum = 0; // Sum of squares of numbers
  int nested_products_sum = 0; // Sum of products from the nested loop

  // Loop from 1 to 5 for primary calculations
  for (int i = 1; i <= 3; i++) {
      sum += i;          // Add i to sum
      product *= i;      // Multiply product by i
      difference -= i;   // Subtract i from difference
      squares_sum += i * i; // Add square of i to squares_sum
  }
  __asm__("nop");
  __asm__("nop");
  __asm__("nop");
  __asm__("nop");
  __asm__("nop");
  __asm__("nop");
  __asm__("nop");
  *mem_stop_trig = 0x00000005;
  __asm__("nop");
  __asm__("nop");
  __asm__("nop");
  __asm__("nop");
  __asm__("nop");
  __asm__("nop");
  __asm__("nop");
  for (int i = 1; i <= 2; i++) {
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