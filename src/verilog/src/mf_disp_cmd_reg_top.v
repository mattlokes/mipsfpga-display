
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
`include "mf_disp_conf.vh"

module mf_disp_cmd_reg_top(
   input  wire         sys_clk, //Clk in
   input  wire         resetn,
   
   input  wire         cmd_wr_vld,
   input  wire  [7:0]  cmd_wr_addr,
   input  wire  [31:0] cmd_wr_data,

   output wire         cmd_intf_enabled, //Interface Enabled
   output wire         cmd_intf_pix_dm,  //Interface Pixel Doubling Mode
   output wire         cmd_intf_tm,      //Interface Test Pattern Mode

   output wire         cmd_intf_frame_switch, //Interface Show Next Frame
   output wire         cmd_intf_frame_restrt //Interface Restart Frame
 );
 
 // Command Registers
 // -----------------------------
 
 // 0x00 -- CTL0
 // 31                            3          2             1                  0
 // ----------------------------------------------------------------------------
 // |              Reserved        |TEST_MODE | DOUBLE_MODE | INTERFACE_ENABLED |
 // ----------------------------------------------------------------------------
 
 // 0x04 -- CTL1
 // 31                                               2            1           0
 // ----------------------------------------------------------------------------
 // |              Reserved                           | FRM_RESTRT | FRM_SWITCH |
 // ----------------------------------------------------------------------------
 
 // Reserved
 
//  0x24 -- CTL9

wire [9:0] ctl_wren_dec;
reg  [2:0] ctl_reg_0;

//Register Write Enable One Hot Vector
assign ctl_wren_dec[9:0] = {10{cmd_wr_vld}} & (10'b1 << (cmd_wr_addr[7:0] >> 2));

//CTL0 Register Block
always @(posedge sys_clk, negedge resetn) begin
   if( ~resetn ) begin //Reset
      ctl_reg_0 <= 3'b0;  //CTL0 only uses 3 bits
   end
   else begin
      if( ctl_wren_dec[0] ) begin
         ctl_reg_0 <= cmd_wr_data[2:0]; //CTL0 only uses 3 bits
      end
   end
end 

 assign cmd_intf_enabled = ctl_reg_0[0];  //Interface Enabled
 assign cmd_intf_pix_dm  = ctl_reg_0[1];  //Interface Pixel Doubling Mode
 assign cmd_intf_tm      = ctl_reg_0[2];  //Interface Test Pattern Mode

 
//CTL1 Peusdo Register
assign cmd_intf_frame_switch = ctl_wren_dec[1] & cmd_wr_data[0];
assign cmd_intf_frame_restrt = ctl_wren_dec[1] & cmd_wr_data[1];
 
 // Other Registers....
 
 
endmodule
