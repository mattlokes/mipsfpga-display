/*
 * main.c for the MIPSfpga core running on Nexys4 DDR board.
 *
 * This program:
 *   (1) enables display 
 *   (2) writes palette data
 *   (3) writes pixel data
 *   (4) enable buffer
 */
#include <stdint.h>
#include "mfdlib.h"

void delay( uint32_t cnt);
//------------------
// main()
//------------------
int main() {

  mfd_display_init();
  //mfd_display_testmode();
  mfd_display_set_palette( 0x01, 0x0003FFFF);
  mfd_display_set_palette( 0x02, 0x0000003F);
  mfd_display_fill_frame( 0x02 );
  mfd_draw_line( 0,0,319,199,0x01);
  mfd_draw_line( 0,199,319,0,0x01);
  mfd_draw_line( 159,0,159,199,0x01);
  mfd_draw_line( 0,99,319,99,0x01);
  mfd_display_switch_frame();
  //mfd_display_fill_frame( 0x01 );
  //mfd_display_switch_frame();

  while(1) {
     delay(1000000);
     //mfd_display_switch_frame();
  }
  return 0;
}

void delay( uint32_t cnt) {
  volatile uint32_t j;

  for (j = 0; j<cnt; j++) ;	// delay 
}


