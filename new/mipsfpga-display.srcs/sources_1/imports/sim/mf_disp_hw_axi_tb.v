`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.02.2016 17:32:11
// Design Name: 
// Module Name: mf_disp_hw_axi_tb
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

module mf_disp_hw_axi_tb(
   input  wire         CLK100MHZ,
   
   input  wire         RESETN_I,
   
   output wire         VGA_HSYNC_O,
   output wire         VGA_VSYNC_O,
   output wire [3:0]   VGA_RED_O,
   output wire [3:0]   VGA_GREEN_O,
   output wire [3:0]   VGA_BLUE_O
);

wire resetn;
wire tb_clk;

`ifdef MF_DISP_SIMULATION
   reg sim_resetn;
   reg sim_clk100;
   initial begin
      sim_resetn = 1'b0;
      #50; sim_resetn = 1'b1; 
   end
   initial begin
      sim_clk100 = 0;
      forever begin
         #5; 
         sim_clk100 = ~sim_clk100;
      end 
   end
   assign resetn = sim_resetn;
   assign tb_clk = sim_clk100;
`else
   assign resetn = RESETN_I;
   assign tb_clk = CLK100MHZ;
`endif


wire         sys_wr_avld;
wire         sys_wr_dvld;
wire [31:0]  sys_wr_addr;
wire [31:0]  sys_wr_data;

reg [31:0] tb_tick;
reg [7:0]  tb_ptr;
wire [95:0]  tb_cmds [255:0];

wire nxt_tb_cmd_tick_match;
wire send_cmd;

wire sys_clk;
wire pix_clk;

//Testbench Commands
//assign tb_cmds[0][95:0] = { 32'd1000, 32'h0000FE00, 32'h00000005 }; //Enable & TestMode
assign tb_cmds[0][95:0] = { 32'd10, 32'h0000FA00, 32'h00000000 }; //Set Pal0  to Black
assign tb_cmds[1][95:0] = { 32'd12, 32'h0000FA04, 32'h0003F000 }; //Set Pal1  to Red
assign tb_cmds[2][95:0] = { 32'd14, 32'h0000FA08, 32'h0000003F }; //Set Pal2  to Blue
assign tb_cmds[3][95:0] = { 32'd16, 32'h0000FA0C, 32'h0003FFFF }; //Set Pal2  to White
assign tb_cmds[4][95:0] = { 32'd18, 32'h00000000, 32'h01010101 }; //Set P0-3  to Red
assign tb_cmds[5][95:0] = { 32'd20, 32'h00000004, 32'h02020202 }; //Set P4-7  to Blue
assign tb_cmds[6][95:0] = { 32'd22, 32'h00000008, 32'h03030303 }; //Set P8-11 to White

assign tb_cmds[7][95:0] = { 32'd24, 32'h00000134, 32'h01010101 }; //Set P0-3  to Red
assign tb_cmds[8][95:0] = { 32'd26, 32'h00000138, 32'h02020202 }; //Set P4-7  to Blue
assign tb_cmds[9][95:0] = { 32'd28, 32'h0000013C, 32'h03030303 }; //Set P8-11 to White

assign tb_cmds[10][95:0] = { 32'd30, 32'h0000F8C0, 32'h01010101 }; //Set P0-3  to Red
assign tb_cmds[11][95:0] = { 32'd32, 32'h0000F8C4, 32'h02020202 }; //Set P4-7  to Blue
assign tb_cmds[12][95:0] = { 32'd34, 32'h0000F8C8, 32'h03030303 }; //Set P8-11 to White

assign tb_cmds[13][95:0] = { 32'd36, 32'h0000F9F4, 32'h01010101 }; //Set P0-3  to Red
assign tb_cmds[14][95:0] = { 32'd38, 32'h0000F9F8, 32'h02020202 }; //Set P4-7  to Blue
assign tb_cmds[15][95:0] = { 32'd40, 32'h0000F9FC, 32'h03030303 }; //Set P8-11 to White

assign tb_cmds[16][95:0] = { 32'd42, 32'h0000FE04, 32'h00000001 }; //Switch Frame
assign tb_cmds[17][95:0] = { 32'd60, 32'h0000FE00, 32'h00000001 }; //Enable

assign tb_cmds[18][95:0] = { 32'd0,    32'h00000000, 32'h00000000 };

wire wr_in_prog;
wire wr_done;

//Testbench Ticker
always @(posedge sys_clk, negedge resetn)
   if      ( ~resetn )                tb_tick <= 32'h0;
   else if ( tb_tick < 32'h7FFFFFFF)
      if ( wr_in_prog )  //Pause ticker if awready|wready are 0
         tb_tick <= tb_tick;
      else
         tb_tick <= tb_tick + 1'b1;

//Testbench Cmd Pointer
 always @(posedge sys_clk, negedge resetn)
   if( ~resetn ) tb_ptr <= 8'h0;
   else if( wr_done ) tb_ptr <= tb_ptr + 1'b1;

//Next Command Tick Match, therefore send command.
 assign nxt_tb_cmd_tick_match = tb_tick[31:0] == tb_cmds[tb_ptr][95:64];   
 assign send_cmd = nxt_tb_cmd_tick_match;

//Write State Machine
parameter IDLE = 0;
parameter AWVALID = 1;
parameter WVALID = 2;
parameter DONE = 3;

reg [31:0] cstate;
reg [31:0] nstate;

always @(posedge sys_clk, negedge resetn)
   if( ~resetn ) cstate <= IDLE;
   else          cstate <= nstate;

always @(*) begin
   case ( cstate )
      IDLE: begin
         if( nxt_tb_cmd_tick_match ) nstate = AWVALID;
         else                        nstate = cstate;
      end
      
      AWVALID: begin
         if( s00_axi_awready ) nstate = WVALID;
         else                  nstate = cstate;
      end
      
      WVALID: begin
         if( s00_axi_wready ) nstate = DONE;
         else                 nstate = cstate;
      end
      
      DONE:    nstate = IDLE;
      default: nstate = IDLE;
   
   endcase
end

assign wr_in_prog = (cstate == DONE) || (cstate == AWVALID) || (cstate == WVALID);
assign wr_done    = (cstate == DONE);

assign sys_wr_avld  = (cstate == AWVALID);
assign sys_wr_dvld  = (cstate == WVALID);
assign sys_wr_addr  = (cstate == AWVALID) ? tb_cmds[tb_ptr][63:32] : 32'h00000000;
assign sys_wr_data  = (cstate == WVALID)  ? tb_cmds[tb_ptr][31:0]  : 32'h00000000;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

//Pixel Clock
tb_hw_clk_wiz vga_clk (
   .clk_in1(  tb_clk ),//BOARD (100Mhz) CLK in
   .clk_out1( pix_clk ), //VGA   (25.175Mhz) CLK out
   .clk_out2( sys_clk )  //SYS   (50Mhz) CLK out
 );


wire s00_axi_awready;
wire s00_axi_wready;

//Instantiation of mipsfpga_display_axi_top
mf_disp_axi_top # ( 
	.C_S_AXI_ID_WIDTH(1),
	.C_S_AXI_DATA_WIDTH(32),
	.C_S_AXI_ADDR_WIDTH(16),
	.C_S_AXI_AWUSER_WIDTH(0),
	.C_S_AXI_ARUSER_WIDTH(0),
	.C_S_AXI_WUSER_WIDTH(0),
	.C_S_AXI_RUSER_WIDTH(0),
	.C_S_AXI_BUSER_WIDTH(0)
) mf_disp_axi_top_inst (
    
        .PIX_CLK(pix_clk),
        .VGA_HSYNC(VGA_HSYNC_O),
        .VGA_VSYNC(VGA_VSYNC_O),
        .VGA_RED  (VGA_RED_O),
        .VGA_GREEN(VGA_GREEN_O),
        .VGA_BLUE (VGA_BLUE_O),

	.S_AXI_ACLK( sys_clk ),
	.S_AXI_ARESETN( resetn ),
	.S_AXI_AWID(1'b0),
	.S_AXI_AWADDR( sys_wr_addr[15:0] ),
	.S_AXI_AWLEN( 7'b0 ), //1 Burst 
	.S_AXI_AWSIZE( 3'h2 ), //4 bytes
	.S_AXI_AWBURST( 2'h0 ), //fixed
	.S_AXI_AWLOCK( 2'h0 ), //NORMAL
	.S_AXI_AWCACHE( 4'h0 ), //DC
	.S_AXI_AWPROT( 3'h0 ),
	.S_AXI_AWQOS( 4'h0 ),
	.S_AXI_AWREGION( 4'h0 ),
	.S_AXI_AWUSER( 1'b0),
	.S_AXI_AWVALID( sys_wr_avld ),
	.S_AXI_AWREADY(s00_axi_awready),
	.S_AXI_WDATA( sys_wr_data ),
	.S_AXI_WSTRB( {4{sys_wr_dvld}} ),
	.S_AXI_WLAST( 1'b1),
	.S_AXI_WUSER( 1'b0 ),
	.S_AXI_WVALID( sys_wr_dvld ),
	.S_AXI_WREADY(s00_axi_wready ),
	.S_AXI_BID(),
	.S_AXI_BRESP(),
	.S_AXI_BUSER(),
	.S_AXI_BVALID(),
	.S_AXI_BREADY( 1'b1 ),
	.S_AXI_ARID( 1'b0 ),
	.S_AXI_ARADDR( 16'h0 ),
	.S_AXI_ARLEN( 7'h0 ),
	.S_AXI_ARSIZE( 2'h2 ),
	.S_AXI_ARBURST( 2'h0 ),
	.S_AXI_ARLOCK( 2'h0 ),
	.S_AXI_ARCACHE( 4'h0 ),
	.S_AXI_ARPROT( 3'h0 ),
	.S_AXI_ARQOS( 4'h0 ),
	.S_AXI_ARREGION( 4'h0 ),
	.S_AXI_ARUSER( 1'b0 ),
	.S_AXI_ARVALID( 1'b0 ),
	.S_AXI_ARREADY(),
	.S_AXI_RID(),
	.S_AXI_RDATA(),
	.S_AXI_RRESP(),
	.S_AXI_RLAST(),
	.S_AXI_RUSER(),
	.S_AXI_RVALID(),
	.S_AXI_RREADY( 1'b1 )
);

endmodule

