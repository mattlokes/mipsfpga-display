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
   int mfd_display_enable ( void )
   {
      return 0
   }

   int mfd_display_disable ( void )
   {
      return 0
   }

   int mfd_display_testmode ( void )
   {
      return 0
   }
   
   int mfd_display_set_palette ( unsigned char mapped_color,
                                 unsigned int raw_color ) 
   {
      return 0
   }

   int mfd_display_fill_frame( unsigned char mapped_color ) 
   {
      return 0
   }
   
   int mfd_display_fill_palette ( unsigned int raw_color )
   {
      return 0
   }

   int mfd_display_switch_frame( void )
   {
      return 0
   }
   
   int mfd_display_init ( void )
   {
      return 0
   }

   //Drawing Functions
   void mfd_draw_point( unsigned short x, 
                        unsigned short y, 
			unsigned char mapped_color )
   {

   }
   
   void mfd_draw_line( unsigned short x0,
                       unsigned short y0, 
		       unsigned short x1, 
		       unsigned short y1,
		       unsigned char mapped_color )
   {

   }

   void mfd_draw_box( unsigned short x0,
                      unsigned short y0, 
		      unsigned short x1, 
		      unsigned short y1,
		      unsigned char mapped_color )
   {

   }

   void mfd_draw_circ( unsigned short x,
                       unsigned short y,
		       unsigned short r,
		       unsigned char mapped_color)
   {

   }

   void mfd_draw_font( unsigned short x,
                       unsigned short y,
		       char* str,
		       unsigned char mapped_color)
   {

   }


