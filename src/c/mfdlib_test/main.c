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
  int i = 0;
  mfd_display_init();
  //mfd_display_testmode();
  while(1) {
     //Write MIPSfpga Diagonally 4 times
     //---------------------------------------------------  
     mfd_display_set_palette( 0x00, 0x00000000);
     mfd_display_set_palette( 0x01, 0x0003FFFF);
     mfd_display_set_palette( 0x02, 0x0000003F);
     mfd_display_set_palette( 0x03, 0x0003F000);
     mfd_display_set_palette( 0x04, 0x00000FC0);
  
     delay(200000000);
     for (i=1; i<5; i=i+1) {
        mfd_display_switch_frame();
        mfd_draw_str( i*20,i*20,"MIPSfpga", (uint8_t)i);
        mfd_display_switch_frame();
        delay(200000000);
     }
     //Flash Text
     for(i=0; i<10; i=i+1) {
        delay(200000000);
        mfd_display_switch_frame();
     }
     //Clear Screen
     mfd_display_fill_frame( 0x00 );
     mfd_display_switch_frame();
     mfd_display_fill_frame( 0x00 );
     
     // Do Gradient Fill left to Right (R,G,B,W)
     //---------------------------------------------------  
     //Fill Palette (64 possible shades of white, red, green and blue)
     for(i=0; i<64; i=i+1) {
        mfd_display_set_palette( i, ((uint32_t)i<<12) );    //Red
        mfd_display_set_palette( i+64, ((uint32_t)i<<6) ); //Green
        mfd_display_set_palette( i+128, ((uint32_t)i ));    //Blue
        mfd_display_set_palette( i+192, ( ((uint32_t)i<<12) |
                                          ((uint32_t)i<<6)  |
                                            ((uint32_t)i)));    //White
     }
     //Draw Gradient Slowly
     for(i=0; i<256; i=i+1) {
        mfd_display_switch_frame();
        mfd_draw_line( i,0,i,199, (uint8_t)i);
        mfd_display_switch_frame();
        delay(10000000);
     }
     //Pause to view
     for(i=0; i<10; i=i+1) {
        delay(200000000);
     }
     //Clear Screen
     mfd_display_fill_frame( 0x00 );
     mfd_display_switch_frame();
     mfd_display_fill_frame( 0x00 );
     
     // Do Gradient Fill right to left (W,M,Y,C)
     //---------------------------------------------------  
     //Fill Palette (64 possible shades of white, red, green and blue)
     for(i=0; i<64; i=i+1) {
        mfd_display_set_palette( i, ((uint32_t)i<<6) | ((uint32_t)i) );    //Cyan
        mfd_display_set_palette( i+64, ((uint32_t)i<<6) | ((uint32_t)i<<12)); //Yellow
        mfd_display_set_palette( i+128, ((uint32_t)i | ((uint32_t)i<<12)));    //Magenta
        mfd_display_set_palette( i+192, ( ((uint32_t)i<<12) |
                                          ((uint32_t)i<<6)  |
                                            ((uint32_t)i)));    //White
     }
     //Draw Gradient Slowly
     for(i=0; i<256; i=i+1) {
        mfd_display_switch_frame();
        mfd_draw_line( 319-i,0,319-i,199, (uint8_t)i);
        mfd_display_switch_frame();
        delay(10000000);
     }
     //Pause to view
     for(i=0; i<10; i=i+1) {
        delay(200000000);
     }
     //Clear Screen
     mfd_display_fill_frame( 0x00 );
     mfd_display_switch_frame();
     mfd_display_fill_frame( 0x00 );
 
  }
  return 0;
}

void delay( uint32_t cnt) {
  volatile uint32_t j;

  for (j = 0; j<cnt; j++) ;	// delay 
}


