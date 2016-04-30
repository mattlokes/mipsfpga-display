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
int main() {
  volatile int *MF_DISP_CTL0 = (int*)0xb0d0fe00;
  volatile int *MF_DISP_CTL1 = (int*)0xb0d0fe04;
  volatile int *MF_DISP_PAL_BASE = (int*)0xb0d0fa00;
  volatile int *MF_DISP_FRM_BASE = (int*)0xb0d00000;
  
  int *pal_ptr = (int*)MF_DISP_PAL_BASE;
  int *frm_ptr = (int*)MF_DISP_FRM_BASE;
  int i = 0;
  
  //Enable DISPLAY CTL0[0] = Enable
  *MF_DISP_CTL0 = 0x00000000;

  //Load DISPLAY PALETTE
  *pal_ptr = 0x00000000; //Pal[0] = BLACK
  pal_ptr += 1;
  *pal_ptr = 0x0003F000; //Pal[1] = RED
  pal_ptr += 1;
  *pal_ptr = 0x00000FC0; //Pal[2] = GREEN
  pal_ptr += 1;
  *pal_ptr = 0x0000003F; //Pal[3] = BLUE
  pal_ptr += 1;
  *pal_ptr = 0x0003FFFF; //Pal[4] = WHITE
  pal_ptr += 1;

  //Alternating Red Dots
  for( i=0; i<4; i=i+1) {
     *frm_ptr = 0x01000100;
     frm_ptr += 1;
  }
  //Alternating Green Dots
  for( i=0; i<4; i=i+1) {
     *frm_ptr = 0x02000200;
     frm_ptr += 1;
  }
  //Alternating Blue Dots
  for( i=0; i<4; i=i+1) {
     *frm_ptr = 0x03000300;
     frm_ptr += 1;
  }
  //Alternating White Dots
  for( i=0; i<4; i=i+1) {
     *frm_ptr = 0x04000400;
     frm_ptr += 1;
  }
  
  //Switch DISPLAY Frame CTL1[0] = Switch
  *MF_DISP_CTL1 = 0x00000001;
  //Enable DISPLAY CTL0[0] = Enable
  *MF_DISP_CTL0 = 0x00000001;



  while(1) { }
  return 0;
}

void delay() {
  volatile unsigned int j;

  for (j = 0; j < (1000000); j++) ;	// delay 
}


