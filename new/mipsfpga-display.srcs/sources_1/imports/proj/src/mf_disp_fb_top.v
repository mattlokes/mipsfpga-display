//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2016 21:33:56
// Design Name: 
// Module Name: mf_disp_fb_top
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

module mf_disp_fb_top(

   input   wire           sys_clk,         //Sys Clk
   input   wire           pix_clk,        //Interface Clock
   
   input   wire           fb_active_sel,   //Frame0 /1 Select, For double buffering
   
   input   wire           fb_wr_vld,
   input   wire [15:0]    fb_wr_addr,
   input   wire [31:0]    fb_wr_data,
   
   input   wire           pal_wr_vld,
   input   wire [9:0]     pal_wr_addr,
   input   wire [17:0]    pal_wr_data,
   
   input   wire           pix_rd_vld,
   input   wire [15:0]    pix_rd_addr,
   output  wire [5:0]     pix_rd_rdata,
   output  wire [5:0]     pix_rd_gdata,
   output  wire [5:0]     pix_rd_bdata
   
);

 reg pix_rd_vld_dly;
 reg [15:0] pix_rd_addr_dly;
 reg fb_active_sel_dly;

 wire [31:0] fb_rd_data;
 wire [17:0] pix_rd_data;
 
 wire [7:0]  pal_wr_addr_shft;
 wire [1:0]  tmp_pal_wr_addr_shft;
 
 //Split Data out in RGB pixel values
 assign {pix_rd_rdata[5:0], pix_rd_gdata[5:0], pix_rd_bdata[5:0]} = pix_rd_data[17:0];
 assign {tmp_pal_wr_addr_shft, pal_wr_addr_shft[7:0]} = pal_wr_addr[9:0] >> 2;
    
 //Timing Flop
 always @(posedge pix_clk) begin
    pix_rd_vld_dly    <= pix_rd_vld;
    pix_rd_addr_dly   <= pix_rd_addr[15:0];
    fb_active_sel_dly <= fb_active_sel;
 end   
    
    
 //128kiB Memory Frame Buffer Instantiation   
fb_bram_mem_gen fb_ram (
    //Frame Buffer Write Data
    .clka  ( sys_clk ),
    .ena   ( fb_wr_vld ),
    .wea   ( {4{fb_wr_vld}} ),
    .addra ( {fb_wr_addr[15:2], fb_active_sel} ),
    .dina  ( fb_wr_data[31:0] ),
    //Frame Buffer Read Data
    .clkb  ( pix_clk ),
    .enb   ( pix_rd_vld_dly ),
    .addrb ( {pix_rd_addr_dly[15:2], ~fb_active_sel_dly} ),
    .doutb ( fb_rd_data[31:0] )
);
 
 //256x18bit Colour Palette
pal_bram_mem_gen pal_ram(
    //Palette Data Write
    .clka  ( sys_clk ),
    .ena   ( pal_wr_vld ),
    .wea   ( pal_wr_vld ),
    .addra ( pal_wr_addr_shft[7:0] ),
    .dina  ( pal_wr_data[17:0] ),
    // Pixel Data out of Palette
    .clkb  ( pix_clk ),
    .enb   ( pix_rd_vld ),
    .addrb ( fb_rd_data[7:0] ),
    .doutb ( pix_rd_data[17:0] )
);
    
endmodule
