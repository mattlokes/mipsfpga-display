`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.02.2016 17:32:11
// Design Name: 
// Module Name: mf_disp_hw_tb
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

module mf_disp_hw_tb(
   input  wire         CLK100MHZ,
   
   input  wire         RESETN_I,
   
   output wire         VGA_HSYNC_O,
   output wire         VGA_VSYNC_O,
   output wire [3:0]   VGA_RED_O,
   output wire [3:0]   VGA_GREEN_O,
   output wire [3:0]   VGA_BLUE_O
);

wire         sys_wr_vld;
wire [31:0]  sys_wr_addr;
wire [31:0]  sys_wr_data;

reg [31:0] tb_tick;
reg [7:0]  tb_ptr;
wire [95:0]  tb_cmds [255:0];

wire nxt_tb_cmd_tick_match;
wire send_cmd;

wire sys_clk;
wire pix_clk;

wire resetn = RESETN_I;

//Testbench Commands
//assign tb_cmds[0][95:0] = { 32'd1000, 32'h0000FE00, 32'h00000005 }; //Enable & TestMode
assign tb_cmds[0][95:0] = { 32'd1000, 32'h0000FA00, 32'h00000000 }; //Set Pal0  to Black
assign tb_cmds[1][95:0] = { 32'd1002, 32'h0000FA04, 32'h0003F000 }; //Set Pal1  to Red
assign tb_cmds[2][95:0] = { 32'd1004, 32'h0000FA08, 32'h0000003F }; //Set Pal2  to Blue
assign tb_cmds[3][95:0] = { 32'd1006, 32'h0000FA0C, 32'h0003FFFF }; //Set Pal2  to White
assign tb_cmds[4][95:0] = { 32'd1008, 32'h00000000, 32'h01010101 }; //Set P0-3  to Red
assign tb_cmds[5][95:0] = { 32'd1010, 32'h00000004, 32'h02020202 }; //Set P4-7  to Blue
assign tb_cmds[6][95:0] = { 32'd1012, 32'h00000008, 32'h03030303 }; //Set P8-11 to White

assign tb_cmds[7][95:0] = { 32'd1014, 32'h00000134, 32'h01010101 }; //Set P0-3  to Red
assign tb_cmds[8][95:0] = { 32'd1016, 32'h00000138, 32'h02020202 }; //Set P4-7  to Blue
assign tb_cmds[9][95:0] = { 32'd1018, 32'h0000013C, 32'h03030303 }; //Set P8-11 to White

assign tb_cmds[10][95:0] = { 32'd1020, 32'h0000F8C0, 32'h01010101 }; //Set P0-3  to Red
assign tb_cmds[11][95:0] = { 32'd1022, 32'h0000F8C4, 32'h02020202 }; //Set P4-7  to Blue
assign tb_cmds[12][95:0] = { 32'd1024, 32'h0000F8C8, 32'h03030303 }; //Set P8-11 to White

assign tb_cmds[13][95:0] = { 32'd1026, 32'h0000F9F4, 32'h01010101 }; //Set P0-3  to Red
assign tb_cmds[14][95:0] = { 32'd1028, 32'h0000F9F8, 32'h02020202 }; //Set P4-7  to Blue
assign tb_cmds[15][95:0] = { 32'd1030, 32'h0000F9FC, 32'h03030303 }; //Set P8-11 to White

assign tb_cmds[16][95:0] = { 32'd1032, 32'h0000FE04, 32'h00000001 }; //Switch Frame
assign tb_cmds[17][95:0] = { 32'd1132, 32'h0000FE00, 32'h00000001 }; //Enable

assign tb_cmds[18][95:0] = { 32'd0,    32'h00000000, 32'h00000000 };

//Testbench Ticker
always @(posedge sys_clk, negedge resetn)
   if      ( ~resetn )                tb_tick <= 32'h0;
   else if ( tb_tick < 32'h7FFFFFFF)  tb_tick <= tb_tick + 1'b1;

//Testbench Cmd Pointer
 always @(posedge sys_clk, negedge resetn)
   if( ~resetn ) tb_ptr <= 8'h0;
   else if( nxt_tb_cmd_tick_match ) tb_ptr <= tb_ptr + 1'b1;

//Next Command Tick Match, therefore send command.
 assign nxt_tb_cmd_tick_match = tb_tick[31:0] == tb_cmds[tb_ptr][95:64];   
 assign send_cmd = nxt_tb_cmd_tick_match;

assign sys_wr_vld  = send_cmd ? 1'h1         : 1'h0;
assign sys_wr_addr = send_cmd ? tb_cmds[tb_ptr][63:32] : 32'h00000000;
assign sys_wr_data = send_cmd ? tb_cmds[tb_ptr][31:0]  : 32'h00000000;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

//Pixel Clock
tb_hw_clk_wiz vga_clk (
   .clk_in1( CLK100MHZ ),//BOARD (100Mhz) CLK in
   .clk_out1( pix_clk ), //VGA   (25.175Mhz) CLK out
   .clk_out2( sys_clk )  //SYS   (50Mhz) CLK out
 );

mf_disp_top disp(
   .resetn      (resetn),
   
   .pix_clk     (pix_clk),
   
   .sys_clk     (sys_clk),
   .sys_wr_vld  (sys_wr_vld),
   .sys_wr_addr (sys_wr_addr),
   .sys_wr_data (sys_wr_data),
   
   .VGA_hsync   (VGA_HSYNC_O),
   .VGA_vsync   (VGA_VSYNC_O),
   .VGA_red     (VGA_RED_O),
   .VGA_green   (VGA_GREEN_O),
   .VGA_blue    (VGA_BLUE_O)
);


endmodule

