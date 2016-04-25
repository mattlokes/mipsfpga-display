`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.02.2016 19:45:42
// Design Name: 
// Module Name: mf_disp_sync
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

module mf_disp_sync(
   input  wire resetn,
   input  wire clk_a,
   input  wire clk_b,
  
   input  wire pulse_mode,

   input  wire in_a,
   output wire out_b
);

   reg reg_in;
   
   wire sync_ack;
   reg  reg_ack_a_0;
   reg  reg_ack_a_1;
   
   reg reg_b_0;
   reg reg_b_1;
   reg reg_b_2;
   
   // Keep State of in_a until ack comes back
   always @(posedge clk_a or negedge resetn) begin
      if (~resetn )          reg_in <= 1'b0;
      if ( in_a | sync_ack ) reg_in <= in_a;
   end
   
   // cdb_double flop sync
   always @(posedge clk_b) begin
      reg_b_0 <= reg_in;
      reg_b_1 <= reg_b_0;
      reg_b_2 <= reg_b_1;
   end
   
   // cda_double ack flop sync
   always @(posedge clk_a) begin
      reg_ack_a_0 <= reg_b_1;
      reg_ack_a_1 <= reg_ack_a_0;
   end
   
   assign sync_ack = reg_ack_a_1;
   
   //Pulse Output Mode Mux
   assign out_b = pulse_mode ? ~reg_b_2 & reg_b_1 :
                               reg_b_1;
   
endmodule
