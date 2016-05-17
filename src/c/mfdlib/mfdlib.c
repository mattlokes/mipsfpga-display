/////////////////////////////////////////////////
//
//    File   :  mfdlib.c
//    Version:  0.1
//    Date   :  3/5/2016
//    Author :  Matt Lokes (matt.lokes@imgtec.com)
//
//    Description :  MIPSfpga Display support library
//
//
/////////////////////////////////////////////////

   #include "mfdlib.h"


   //Display Control and Initialisation Tasks
   //--------------------------------------------------------------------
   inline int32_t mfd_display_enable ( void )
   {
      *((volatile uint32_t*)MFD_CTL0) = 0x00000001;
      return 0;
   }

   inline int32_t mfd_display_disable ( void )
   {
      *((volatile uint32_t*)MFD_CTL0) = 0x00000000;
      return 0;
   }

   inline int32_t mfd_display_testmode ( void )
   {
      *((volatile uint32_t*)MFD_CTL0) = 0x00000005;
      return 0;
   }
   
   inline int32_t mfd_display_set_palette ( uint8_t  mapped_color,
                                            uint32_t raw_color ) 
   {
      uint32_t *pal_ptr = MFD_PAL_BASE + ((uint32_t)mapped_color);
      *pal_ptr = raw_color;
      return 0;
   }

   int32_t mfd_display_fill_frame( uint8_t mapped_color ) 
   {
      uint32_t  i = 0;
      uint32_t* frm_ptr = MFD_FRM_BASE;
      uint32_t  col = ((uint32_t)mapped_color)<<24 | ((uint32_t)mapped_color)<<16 |
                      ((uint32_t)mapped_color)<<8  | ((uint32_t)mapped_color) ;
      for ( i=0; i<(MFD_FRM_SIZE/4); i++ )
      {
         *frm_ptr = col;
	 *frm_ptr++;
      }
      return 0;
   }
   
   int32_t mfd_display_fill_palette ( uint32_t raw_color )
   {
      uint32_t i = 0;
      uint32_t* pal_ptr = MFD_PAL_BASE;
      for ( i=0; i<(MFD_PAL_SIZE/4); i++ )
      {
         *pal_ptr = raw_color;
	 *pal_ptr++;
      }
      return 0;
   }

   inline int32_t mfd_display_switch_frame( void )
   {
      *((volatile uint32_t*)MFD_CTL1) = 0x00000001;
      return 0;
   }
   
   int32_t mfd_display_init ( void )
   {
      uint32_t i = 0;
      mfd_display_disable();                  // Disable display.
      mfd_display_fill_frame( 0x00000000 );   // Clear frame. 
      mfd_display_switch_frame();             // Switch to other frame.
      mfd_display_fill_palette( 0x00000000 ); // Clear palette.
      mfd_display_fill_frame( 0x00000000 );   // Clear other frame.
      mfd_display_enable ();
      return 0;
   }

   //Drawing Functions
   //--------------------------------------------------------------------
   inline void mfd_draw_point( uint32_t x, 
                               uint32_t y, 
		               uint8_t mapped_color )
   {
      //X + 320*Y + MFD_FRM_BASE = pnt_addr
      volatile uint8_t* point_addr = (volatile uint8_t*)MFD_FRM_BASE;
      uint32_t          offset     = x;

      offset     += y<<8; // Y*256
      offset     += y<<6; // Y*64
      point_addr += offset;

      *point_addr = mapped_color;
   }
   
   void mfd_draw_line( uint32_t x0,
                       uint32_t y0, 
		       uint32_t x1, 
		       uint32_t y1,
		       uint8_t mapped_color )
   {
      //Bresenham's Line Drawining Algorthm
      int32_t   dx  = (int32_t)abs(x1-x0); 
      int32_t   dy  = (int32_t)abs(y1-y0); 
      uint32_t  sx  = x0<x1 ? 1 : -1;
      uint32_t  sy  = y0<y1 ? 1 : -1; 
      int32_t   err = (int32_t)((dx>dy ? dx : -dy)>>1); 
      int32_t   e2;
        
      for(;;){
         mfd_draw_point( x0, y0, mapped_color);
         if (x0==x1 && y0==y1) break;
         e2 = err;
         if (e2 >-dx) { err -= dy; x0 += sx; }
	 if (e2 < dy) { err += dx; y0 += sy; }
      }
   }

   void mfd_draw_box( uint32_t x0,
                      uint32_t y0, 
		      uint32_t x1, 
		      uint32_t y1,
		      uint8_t mapped_color )
   {

   }

   void mfd_draw_circ( uint32_t x,
                       uint32_t y,
		       uint32_t r,
		       uint8_t mapped_color)
   {

   }

   void mfd_draw_font( uint32_t x,
                       uint32_t y,
		       char* str,
		       uint8_t mapped_color)
   {

   }


