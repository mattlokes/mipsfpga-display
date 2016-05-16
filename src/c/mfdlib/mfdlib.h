/////////////////////////////////////////////////
//
//    File   :  mfdlib.h
//    Version:  0.1
//    Date   :  3/5/2016
//    Author :  Matt Lokes (matt.lokes@imgtec.com)
//
//    Description :  MIPSfpga Display support library Header
//
//
/////////////////////////////////////////////////

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#ifndef MFDLIB_H_
#define MFDLIB_H_

   //<USER DEFINEABLE> [Ensure bit 16bits = 0x0000]
   #define MFD_BASE_PA 0x10D00000
   #define MFD_BASE_VA 0xB0D00000

   //   MFD Memory Map
   //   -------------------------
   //   | CMD             0xFE3F
   //   | 40B             0xFE00
   //   -------------------------
   //   | PALETTE         0xFDFF
   //   |
   //   | 1024B           0xFA00     
   //   -------------------------
   //   | FRAMEBUFFER     0xF9FF
   //   |
   //   |
   //   | 64000B          0x0000
   //   -------------------------


   #define MFD_CTL0     (unsigned int*)( MFD_BASE_VA + 0xFE00 )
   #define MFD_CTL1     (unsigned int*)( MFD_BASE_VA + 0xFE04 )
  
   #define MFD_PAL_BASE (unsigned int*)( MFD_BASE_VA + 0xFA00 )
   #define MFD_PAL_SIZE 1024
   
   #define MFD_FRM_BASE (unsigned int*)( MFD_BASE_VA + 0x0000 )
   #define MFD_FRM_SIZE 64000

   #define MFD_FRM_X 320
   #define MFD_FRM_Y 200

   #define MFD_POINT(x , y)  ( x + (y<<8) + (y<<6) )

   //Display Control and Initialisation Tasks
   //--------------------------------------------------------------------
   inline int mfd_display_enable ( void );
   inline int mfd_display_disable ( void );
   inline int mfd_display_testmode ( void );
   
   inline int mfd_display_set_palette ( unsigned char mapped_color, unsigned int raw_color );

   int mfd_display_fill_frame( unsigned char mapped_color );
   int mfd_display_fill_palette ( unsigned int raw_color );

   inline int mfd_display_switch_frame( void );
   int mfd_display_init ( void );

   //Drawing Functions
   //--------------------------------------------------------------------
   void mfd_draw_point( unsigned short x, unsigned short y, unsigned char mapped_color);
   void mfd_draw_line( unsigned short x0, unsigned short y0, unsigned short x1, unsigned short y1, unsigned char mapped_color);
   void mfd_draw_box( unsigned short x0, unsigned short y0, unsigned short x1, unsigned short y1, unsigned char mapped_color);
   void mfd_draw_circ( unsigned short x, unsigned short y, unsigned short r, unsigned char mapped_color);
   void mfd_draw_font( unsigned short x, unsigned short y, char* str, unsigned char mapped_color);


#endif /*MFDLIB_H_*/ 
