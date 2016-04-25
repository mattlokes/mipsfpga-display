//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2016 22:17:52
// Design Name: 
// Module Name: mf_disp_addr_dec
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


//MF Disp Memory Map

//   -------------------------
//   | CMD             0xFE3F
//   | 40B             0xFE00
//   -------------------------
//   | PALETTE         0xFDFF
//   |
//   |
//   | 1024B           0xFA00     
//   -------------------------
//   | FRAMEBUFFER     0xF9FF
//   |
//   |
//   |
//   |
//   | 64000B          0x0000
//   -------------------------

`include "mf_disp_conf.vh"

module mf_disp_addr_dec(
   
   input  wire [15:0]    sys_wr_addr,
   input  wire           sys_wr_vld,

   output wire           fb_wr_vld,
   output wire [15:0]    fb_wr_addr,                 
   output wire           pal_wr_vld,
   output wire [15:0]    pal_wr_addr,        
   output wire           cmd_wr_vld,
   output wire [15:0]    cmd_wr_addr

);

wire fb_addr_c;
wire pal_addr_c;
wire cmd_addr_c;

assign fb_wr_vld   = sys_wr_vld & (sys_wr_addr >= 16'h0000) & (sys_wr_addr < 16'hFA00);
assign fb_wr_addr  = sys_wr_addr[15:0]; //No Offset
assign pal_wr_vld  = sys_wr_vld & (sys_wr_addr >= 16'hFA00) & (sys_wr_addr < 16'hFE00);
assign {pal_addr_c, pal_wr_addr} = {1'b0,sys_wr_addr[15:0]} - {1'b0,16'hFA00};
assign cmd_wr_vld  = sys_wr_vld & (sys_wr_addr >= 16'hFE00) & (sys_wr_addr < 16'hFE3F);
assign {cmd_addr_c, cmd_wr_addr} = {1'b0,sys_wr_addr[15:0]} - {1'b0,16'hFE00};


    
endmodule
