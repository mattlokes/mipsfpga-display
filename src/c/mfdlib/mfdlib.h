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

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
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


   #define MFD_CTL0     (uint32_t*)( MFD_BASE_VA + 0xFE00 )
   #define MFD_CTL1     (uint32_t*)( MFD_BASE_VA + 0xFE04 )
  
   #define MFD_PAL_BASE (uint32_t*)( MFD_BASE_VA + 0xFA00 )
   #define MFD_PAL_SIZE 1024
   
   #define MFD_FRM_BASE (uint32_t*)( MFD_BASE_VA + 0x0000 )
   #define MFD_FRM_SIZE 64000

   #define MFD_FRM_X 320
   #define MFD_FRM_Y 200

   #define MFD_POINT(x , y)  ( x + (y<<8) + (y<<6) )

   extern const unsigned char mfd_font[96][5];

   //Display Control and Initialisation Tasks
   //--------------------------------------------------------------------
   inline int32_t mfd_display_enable ( void );
   inline int32_t mfd_display_disable ( void );
   inline int32_t mfd_display_testmode ( void );
   
   inline int32_t mfd_display_set_palette ( uint8_t mapped_color, uint32_t raw_color );

   int32_t mfd_display_fill_frame( uint8_t mapped_color );
   int32_t mfd_display_fill_palette ( uint32_t raw_color );

   inline int32_t mfd_display_switch_frame( void );
   int32_t mfd_display_init ( void );

   //Drawing Functions
   //--------------------------------------------------------------------
   inline void mfd_draw_point( uint32_t x, uint32_t y, uint8_t mapped_color);
          void mfd_draw_line ( uint32_t x0, uint32_t y0, uint32_t x1, uint32_t y1, uint8_t mapped_color);
          void mfd_draw_box  ( uint32_t x0, uint32_t y0, uint32_t x1, uint32_t y1, uint8_t mapped_color);
          void mfd_draw_circ ( uint32_t x, uint32_t y, uint32_t r, uint8_t mapped_color);
          void mfd_draw_char ( uint32_t x, uint32_t y, char c, uint8_t mapped_color);
          void mfd_draw_str  ( uint32_t x, uint32_t y, const char* str, uint8_t mapped_color);


#endif /*MFDLIB_H_*/ 
