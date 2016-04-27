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
   
   input  wire in_a,
   output wire out_b
);

   reg reg_a_0;
   (* ASYNC_REG = "TRUE" *) 
   reg reg_b_0;
   (* ASYNC_REG = "TRUE" *) 
   reg reg_b_1;
   
   always @(posedge clk_a or negedge resetn) begin
      if (~resetn )          reg_a_0 <= 1'b0;
      else                   reg_a_0 <= in_a;
   end
   
   // cdb_double flop sync
   always @(posedge clk_b) begin
      if (~resetn ) begin
         reg_b_0 <= 1'b0;
         reg_b_1 <= 1'b0;
      end
      else begin
         reg_b_0 <= reg_a_0;
         reg_b_1 <= reg_b_0;
      end
   end
   
   assign out_b = reg_b_1;
   //assign out_b = reg_b_0;

endmodule
