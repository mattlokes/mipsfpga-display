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
   #include <stdio.h>
   #include <math.h>
   #include <malloc.h>
   #include <png.h>

   #include "mfdlib.h"
   #include "mfdlib_font.h"

   png_bytep frame_buf = NULL;
   png_bytep frame_pal = NULL;
   uint32_t  frame_off = 0; // either 0 or 64000
   int png_write_screen(char* filename, int width, int height, char* buffer, char* title);
   
   //Display Control and Initialisation Tasks
   //--------------------------------------------------------------------
   inline int32_t mfd_display_enable ( void )
   {
      //printf("MFDLIB_PC: mfd_display_enable\n");
      //*((volatile uint32_t*)MFD_CTL0) = 0x00000001;
      return 0;
   }

   inline int32_t mfd_display_disable ( void )
   {
      //printf("MFDLIB_PC: mfd_display_disable\n");
      //*((volatile uint32_t*)MFD_CTL0) = 0x00000000;
      return 0;
   }

   inline int32_t mfd_display_testmode ( void )
   {
      //printf("MFDLIB_PC: mfd_display_testmode\n");
      //*((volatile uint32_t*)MFD_CTL0) = 0x00000005;
      return 0;
   }
   
   inline int32_t mfd_display_set_palette ( uint8_t  mapped_color,
                                            uint32_t raw_color ) 
   {
     //printf("MFDLIB_PC: mfd_display_palette\n");
     // uint32_t *pal_ptr = MFD_PAL_BASE + ((uint32_t)mapped_color);
     // *pal_ptr = raw_color;
     frame_pal[(3*mapped_color) + 0] = (png_byte)((raw_color & 0x0000003F)<<2); //R
     frame_pal[(3*mapped_color) + 1] = (png_byte)((raw_color & 0x00000FC0)>>4); //R
     frame_pal[(3*mapped_color) + 2] = (png_byte)((raw_color & 0x0003F000)>>10); //R
      return 0;
   }

   int32_t mfd_display_fill_frame( uint8_t mapped_color ) 
   {
      //printf("MFDLIB_PC: mfd_display_fill_frame\n");
      uint32_t  i = 0;
      //uint32_t* frm_ptr = MFD_FRM_BASE;
      //uint32_t  col = ((uint32_t)mapped_color)<<24 | ((uint32_t)mapped_color)<<16 |
      //                ((uint32_t)mapped_color)<<8  | ((uint32_t)mapped_color) ;
      //for ( i=0; i<(MFD_FRM_SIZE/4); i++ )
      for ( i=0; i<MFD_FRM_SIZE; i++ )
      {
         frame_buf[frame_off+i] = mapped_color;
       //  *frm_ptr = col;
       // *frm_ptr++;
      }
      return 0;
   }
   
   int32_t mfd_display_fill_palette ( uint32_t raw_color )
   {
      //printf("MFDLIB_PC: mfd_display_fill_palette\n");
      uint32_t i = 0;
      //uint32_t* pal_ptr = MFD_PAL_BASE;
      //for ( i=0; i<(MFD_PAL_SIZE/4); i++ )
      for ( i=0; i<256; i++ )
      {
         frame_pal[(3*i) + 0] = (png_byte)((raw_color & 0x0000003F)<<2); //R
         frame_pal[(3*i) + 1] = (png_byte)((raw_color & 0x00000FC0)>>4); //R
         frame_pal[(3*i) + 2] = (png_byte)((raw_color & 0x0003F000)>>10); //R
        //*pal_ptr = raw_color;
	//*pal_ptr++;
      }
      return 0;
   }

   inline int32_t mfd_display_switch_frame( void )
   {
      printf("MFDLIB_PC: mfd_display_switch_frame\n");
      //*((volatile uint32_t*)MFD_CTL1) = 0x00000001;
      png_write_screen("frame.png", MFD_FRM_X, MFD_FRM_Y, (png_bytep)(frame_buf+frame_off), "frame_screenshot");
      frame_off = (frame_off == 0) ? MFD_FRM_SIZE : 0; //Swith Frame
      return 0;
   }
   
   int32_t mfd_display_init ( void )
   {
      printf("MFDLIB_PC: mfd_display_init\n");
      uint32_t i = 0;
      frame_buf = (png_bytep) malloc(2 * MFD_FRM_SIZE);
      frame_pal = (png_bytep) malloc(3 * 256);
      for (i=0; i<2*MFD_FRM_SIZE; i++) frame_buf[i] = 0;
      for (i=0; i<3*256;          i++) frame_pal[i] = 0;
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
      //printf("MFDLIB_PC: mfd_draw_point\n");
      //X + 320*Y + MFD_FRM_BASE = pnt_addr
      //volatile uint8_t* point_addr = (volatile uint8_t*)MFD_FRM_BASE;
      //uint32_t          offset     = x;

      //offset     += y<<8; // Y*256
      //offset     += y<<6; // Y*64
      //point_addr += offset;

      //*point_addr = mapped_color;
      frame_buf[((320*y)+x) + frame_off] = mapped_color;
   }
   
   void mfd_draw_line( uint32_t x0,
                       uint32_t y0, 
		       uint32_t x1, 
		       uint32_t y1,
		       uint8_t mapped_color )
   {
      //printf("MFDLIB_PC: mfd_draw_line\n");
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
      printf("MFDLIB_PC: mfd_draw_box\n");

   }

   void mfd_draw_circ( uint32_t x,
                       uint32_t y,
		       uint32_t r,
		       uint8_t mapped_color)
   {
      printf("MFDLIB_PC: mfd_draw_circ\n");

   }

   void mfd_draw_char( uint32_t x,
                       uint32_t y,
		       char c,
		       uint8_t mapped_color)
   {
      //printf("MFDLIB_PC: mfd_draw_char\n");
      uint32_t i,j;

      // Convert the character to an index
      c = c & 0x7F;
      c = (c < ' ') ? 0 : (c - ' ');

      // 'font' is a multidimensional array of [96][char_width]
      // which is really just a 1D array of size 96*char_width.
      //const uint8_t* chr = mfd_font[c*MFD_FONT_W];
      const uint8_t* chr = mfd_font[c];

      // Draw pixels
      for (j=0; j<MFD_FONT_W; j++) {
         for (i=0; i<MFD_FONT_H; i++) {
            if (chr[j] & (1<<i)) {
                mfd_draw_point( x+j, y+i, mapped_color);
            }
         }
      }
   }

   void mfd_draw_str( uint32_t x,
                      uint32_t y,
		      const char* str,
		      uint8_t mapped_color)
   {
      //printf("MFDLIB_PC: mfd_draw_str\n");
      while (*str) {
         mfd_draw_char( x, y, *str++, mapped_color);
         x += MFD_FONT_W+1;
      }
   }

int png_write_screen(char* filename, int width, int height, char* buffer, char* title)
{
        //printf("MFDLIB_PC: png_write_screen\n");
	int code = 0;
	FILE *fp = NULL;
	png_structp png_ptr = NULL;
	png_infop info_ptr = NULL;
	png_bytep row = NULL;
	
	// Open file for writing (binary mode)
	fp = fopen(filename, "wb+");
	if (fp == NULL) {
		fprintf(stderr, "Could not open file %s for writing\n", filename);
		code = 1;
		goto finalise;
	}

	// Initialize write structure
	png_ptr = png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
	if (png_ptr == NULL) {
		fprintf(stderr, "Could not allocate write struct\n");
		code = 1;
		goto finalise;
	}

	// Initialize info structure
	info_ptr = png_create_info_struct(png_ptr);
	if (info_ptr == NULL) {
		fprintf(stderr, "Could not allocate info struct\n");
		code = 1;
		goto finalise;
	}

	// Setup Exception handling
	if (setjmp(png_jmpbuf(png_ptr))) {
		fprintf(stderr, "Error during png creation\n");
		code = 1;
		goto finalise;
	}

	png_init_io(png_ptr, fp);

	// Write header (8 bit colour depth)
	png_set_IHDR(png_ptr, info_ptr, width, height,
			8, PNG_COLOR_TYPE_RGB, PNG_INTERLACE_NONE,
			PNG_COMPRESSION_TYPE_BASE, PNG_FILTER_TYPE_BASE);

	// Set title
	if (title != NULL) {
		png_text title_text;
		title_text.compression = PNG_TEXT_COMPRESSION_NONE;
		title_text.key = "Title";
		title_text.text = title;
		png_set_text(png_ptr, info_ptr, &title_text, 1);
	}

	png_write_info(png_ptr, info_ptr);

	// Allocate memory for one row (3 bytes per pixel - RGB)
	row = (png_bytep) malloc(3 * width * sizeof(png_byte));


	// Write image data
	int x, y;
	for (y=0 ; y<height ; y++) {
		for (x=0 ; x<width ; x++) {
                        row[(x*3) + 2] = frame_pal[3*frame_buf[(y*width + x)+frame_off] + 0];
                        row[(x*3) + 1] = frame_pal[3*frame_buf[(y*width + x)+frame_off] + 1];
                        row[(x*3) + 0] = frame_pal[3*frame_buf[(y*width + x)+frame_off] + 2];
		}
		png_write_row(png_ptr, row);
	}

	// End write
	png_write_end(png_ptr, NULL);

	finalise:
	if (fp != NULL) fclose(fp);
	if (info_ptr != NULL) png_free_data(png_ptr, info_ptr, PNG_FREE_ALL, -1);
	if (png_ptr != NULL) png_destroy_write_struct(&png_ptr, (png_infopp)NULL);
	if (row != NULL) free(row);

	return code;
}



