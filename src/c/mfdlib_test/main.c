/*
 * main.c for the MIPSfpga core running on Nexys4 DDR board.
 *
 * This program:
 *   (1) enables display 
 *   (2) writes palette data
 *   (3) writes pixel data
 *   (4) enable buffer
 */

#include "mfdlib.h"

//------------------
// main()
//------------------
int main() {

  mfd_display_init();
  mfd_display_testmode();

  while(1) { }
  return 0;
}

void delay() {
  volatile unsigned int j;

  for (j = 0; j < (1000000); j++) ;	// delay 
}


