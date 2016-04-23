`timescale 1ns / 100ps

//MF Disp Conf Header File
`ifndef MF_DISP_CONF_VH
   `define MF_DISP_CONF_VH
   
   //Choose Which Display Interface
   `define MF_DISP_VGA
   //`define MF_DISP_LCD

   `ifdef MF_DISP_VGA
      `define MF_DISP_INTF mf_disp_intf_vga_top
   `endif

   `ifdef MF_DISP_LCD
      `define MF_DISP_INTF mf_disp_intf_lcd_top
   `endif

`endif
