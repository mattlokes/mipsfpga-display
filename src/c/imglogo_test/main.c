/*
 * main.c for the MIPSfpga core running on Nexys4 DDR board.
 *
 * This program:
 *   (1) enables display 
 *   (2) writes palette data
 *   (3) writes pixel data
 *   (4) enable buffer
 */


//------------------
// main()
//------------------
#include "imglogo.h"

void delay() {
  volatile unsigned int j;

  for (j = 0; j < (1000); j++) ;	// delay 
}

int main() {
  volatile int *MF_DISP_CTL0 = (int*)0xb0d0fe00;
  volatile int *MF_DISP_CTL1 = (int*)0xb0d0fe04;
  volatile int *MF_DISP_PAL_BASE = (int*)0xb0d0fa00;
  volatile int *MF_DISP_FRM_BASE = (int*)0xb0d00000;
  
  int *pal_ptr = (int*)MF_DISP_PAL_BASE;
  int *frm_ptr = (int*)MF_DISP_FRM_BASE;
  unsigned int i = 0;
  unsigned int j = 0;


  //unsigned int rawLogo[16000]
  
  //Enable DISPLAY CTL0[0] = Enable
  *MF_DISP_CTL0 = 0x00000000;

  //Load DISPLAY PALETTE
  *pal_ptr = 0x00000000; //Pal[0] = BLACK
  pal_ptr += 255;
  *pal_ptr = 0x0003FFFF; //Pal[255] = WHITE


  //rawLogoW = (unsigned int) rawLogo;
  //Alternating Red Dots
  for( j=0; j<20; j=j+1) {
     for( i=j*800; i<((j+1)*800); i=i+1) {
        *frm_ptr = rawLogo[i]; 
        frm_ptr += 1;
     }
     delay();
  }
  
  //Switch DISPLAY Frame CTL1[0] = Switch
  *MF_DISP_CTL1 = 0x00000001;
  //Enable DISPLAY CTL0[0] = Enable
  *MF_DISP_CTL0 = 0x00000001;



  while(1) { }
  return 0;
}



