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
   inline int mfd_display_enable ( void )
   {
      *((volatile unsigned int*)MFD_CTL0) = 0x00000001;
      return 0;
   }

   inline int mfd_display_disable ( void )
   {
      *((volatile unsigned int*)MFD_CTL0) = 0x00000000;
      return 0;
   }

   inline int mfd_display_testmode ( void )
   {
      *((volatile unsigned int*)MFD_CTL0) = 0x00000005;
      return 0;
   }
   
   inline int mfd_display_set_palette ( unsigned char mapped_color,
                                        unsigned int raw_color ) 
   {
      unsigned int *pal_ptr = MFD_PAL_BASE + ((unsigned int)mapped_color);
      *pal_ptr = raw_color;
      return 0;
   }

   int mfd_display_fill_frame( unsigned char mapped_color ) 
   {
      unsigned int i = 0;
      unsigned int* frm_ptr = MFD_FRM_BASE;
      for ( i=0; i<(MFD_FRM_SIZE/4); i++ )
      {
         *frm_ptr = mapped_color;
	 *frm_ptr++;
      }
      return 0;
   }
   
   int mfd_display_fill_palette ( unsigned int raw_color )
   {
      unsigned int i = 0;
      unsigned int* pal_ptr = MFD_PAL_BASE;
      for ( i=0; i<(MFD_PAL_SIZE/4); i++ )
      {
         *pal_ptr = raw_color;
	 *pal_ptr++;
      }
      return 0;
   }

   inline int mfd_display_switch_frame( void )
   {
      *((volatile unsigned int*)MFD_CTL1) = 0x00000001;
      return 0;
   }
   
   int mfd_display_init ( void )
   {
      unsigned int i = 0;
      mfd_display_disable();             // Disable display.
      mfd_display_fill_frame( 0x00000000 );    // Clear frame. 
      mfd_display_switch_frame();        // Switch to other frame.
      mfd_display_fill_palette( 0x00000000 );  // Clear palette.
      mfd_display_fill_frame( 0x00000000 );    // Clear other frame.
      mfd_display_enable ();
      return 0;
   }

   //Drawing Functions
   //--------------------------------------------------------------------
   void mfd_draw_point( unsigned int x, 
                        unsigned int y, 
			unsigned char mapped_color )
   {
      //X + 320*Y + MFD_FRM_BASE = pnt_addr
      unsigned int    offset     = 0;
      volatile unsigned char * point_addr = 0;

      offset  = x;
      offset += y<<8; // Y*256
      offset += y<<6; // Y*64

      point_addr = (volatile unsigned char *)MFD_FRM_BASE + offset;
      *point_addr = mapped_color;

   }
   
   void mfd_draw_line( unsigned int x0,
                       unsigned int y0, 
		       unsigned int x1, 
		       unsigned int y1,
		       unsigned char mapped_color )
   {
      //Bresenham's Line Drawining Algorthm
      int            dx  = (int)abs(x1-x0); 
      int            dy  = (int)abs(y1-y0); 
      unsigned int sx  = x0<x1 ? 1 : -1;
      unsigned int sy  = y0<y1 ? 1 : -1; 
      int            err = (int)((dx>dy ? dx : -dy)>>1); 
      int            e2;
        
      for(;;){
         mfd_draw_point( x0, y0, mapped_color);
         if (x0==x1 && y0==y1) break;
         e2 = err;
         if (e2 >-dx) { err -= dy; x0 += sx; }
	 if (e2 < dy) { err += dx; y0 += sy; }
      }
   }

   void mfd_draw_box( unsigned int x0,
                      unsigned int y0, 
		      unsigned int x1, 
		      unsigned int y1,
		      unsigned char mapped_color )
   {

   }

   void mfd_draw_circ( unsigned int x,
                       unsigned int y,
		       unsigned int r,
		       unsigned char mapped_color)
   {

   }

   void mfd_draw_font( unsigned int x,
                       unsigned int y,
		       char* str,
		       unsigned char mapped_color)
   {

   }


