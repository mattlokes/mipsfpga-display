//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2016 21:32:20
// Design Name: 
// Module Name: mf_disp_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "mf_disp_conf.vh"

module mf_disp_top(
   input  wire         resetn,
   
   input  wire         pix_clk,
   input  wire         sys_clk,

   input  wire         sys_wr_vld,
   input  wire [15:0]  sys_wr_addr,
   input  wire [31:0]  sys_wr_data,
   
   /******* VGA Signals *******************/
   
   output wire         VGA_hsync,
   output wire         VGA_vsync,
   output wire [3:0]   VGA_red,
   output wire [3:0]   VGA_green,
   output wire [3:0]   VGA_blue
);


   wire        fb_wr_vld;
   wire [15:0] fb_wr_addr;
   wire        pal_wr_vld;
   wire [15:0] pal_wr_addr;
   wire        cmd_wr_vld;
   wire [15:0] cmd_wr_addr;
   
   wire   cmd_intf_frame_switch;
   wire   cmd_intf_frame_restrt;
   wire   intf_frame_switch;
   wire   intf_frame_restrt;
   wire   cmd_intf_enabled;
   wire   cmd_intf_pix_dm;
   wire   cmd_intf_tm;
   
   wire   intf_frame_sel;
   
   wire        pix_rd_vld;
   wire [15:0] pix_rd_addr;
   wire [5:0]  pix_rd_rdata;
   wire [5:0]  pix_rd_gdata;
   wire [5:0]  pix_rd_bdata;


//Address Decoder for Display Controller Memory Map
mf_disp_addr_dec dec( 
   .sys_wr_addr  ( sys_wr_addr[15:0] ),
   .sys_wr_vld   ( sys_wr_vld  ),

   .fb_wr_vld    ( fb_wr_vld ),
   .fb_wr_addr   ( fb_wr_addr[15:0] ),   
   .pal_wr_vld   ( pal_wr_vld ),
   .pal_wr_addr  ( pal_wr_addr[15:0] ),
   .cmd_wr_vld   ( cmd_wr_vld ),
   .cmd_wr_addr  ( cmd_wr_addr[15:0] )
);

//Command Register for Display Control
mf_disp_cmd_reg_top cmd(
   .sys_clk      ( sys_clk ), //Clk in
   .resetn       ( resetn ),
   
   .cmd_wr_vld   ( cmd_wr_vld ),
   .cmd_wr_addr  ( cmd_wr_addr[7:0] ),
   .cmd_wr_data  ( sys_wr_data[31:0]),
   
   .cmd_intf_enabled ( cmd_intf_enabled ), //Interface Enabled
   .cmd_intf_pix_dm  ( cmd_intf_pix_dm ),  //Interface Pixel Doubling Mode
   .cmd_intf_tm      ( cmd_intf_tm ),      //Interface Test Pattern Mode
   
   .cmd_intf_frame_switch (cmd_intf_frame_switch), //Interface Show Next Frame
   .cmd_intf_frame_restrt (cmd_intf_frame_restrt) //Interface Restart Frame
);    

// Framebuffer and Palette Instance    
mf_disp_fb_top fb (

   .sys_clk      ( sys_clk ), //Clk in
   .pix_clk      ( pix_clk ), //Clk in
   
   .fb_active_sel( intf_frame_sel ),
   .fb_wr_vld    ( fb_wr_vld ),
   .fb_wr_addr   ( fb_wr_addr[15:0] ),
   .fb_wr_data   ( sys_wr_data[31:0] ),
       
   .pal_wr_vld   ( pal_wr_vld ),
   .pal_wr_addr  ( pal_wr_addr[9:0] ),
   .pal_wr_data  ( sys_wr_data[17:0]),
       
   .pix_rd_vld   ( pix_rd_vld ),
   .pix_rd_addr  ( pix_rd_addr[15:0] ),
   .pix_rd_rdata ( pix_rd_rdata[5:0] ),
   .pix_rd_gdata ( pix_rd_gdata[5:0] ),
   .pix_rd_bdata ( pix_rd_bdata[5:0] )
       
);

// Syncronisers for the system to interface clock domain
wire [1:0] tmp_o;
mf_disp_syncs #(1) intf_syncs (
   .pulse_mode( 1'b1 ),
   .resetn    ( resetn ),
   .clk_a     ( sys_clk ),
   .clk_b     ( pix_clk ),
   .in_a      ( {2'b0,  cmd_intf_frame_restrt, cmd_intf_frame_switch } ),
   .out_b     ( {tmp_o,     intf_frame_restrt,     intf_frame_switch } )
);


//Phys Interface to the Frame Buffer
mf_disp_intf_vga_top intf (
   //Display Internal Signals
   .vga_clk   ( pix_clk ),
   .resetn    ( resetn  ),
   
   //Do these constant pins need CDC handling?!
   .intf_mode_enabled    ( cmd_intf_enabled ), //Interface Enabled
   .intf_mode_pix_double ( cmd_intf_pix_dm ),  //Interface Pixel Doubling Mode
   .intf_mode_test       ( cmd_intf_tm ),      //Interface Test Pattern Mode
   
   .intf_frame_sel       (intf_frame_sel),
   
   .intf_frame_switch    (intf_frame_switch), //Interface Show Next Frame
   .intf_frame_restrt     (intf_frame_restrt), //Interface Restart Frame
   
   .intf_pix_rd_vld   ( pix_rd_vld ),
   .intf_pix_rd_addr  ( pix_rd_addr[15:0] ),
   .intf_pix_rd_rdata ( pix_rd_rdata[5:0] ),
   .intf_pix_rd_gdata ( pix_rd_gdata[5:0] ),
   .intf_pix_rd_bdata ( pix_rd_bdata[5:0] ),
   
   //VGA Signals
   .VGA_hsync     ( VGA_hsync ),
   .VGA_vsync     ( VGA_vsync ),
   .VGA_red       ( VGA_red[3:0]),
   .VGA_green     ( VGA_green[3:0]),
   .VGA_blue      ( VGA_blue[3:0])
);
    
endmodule
