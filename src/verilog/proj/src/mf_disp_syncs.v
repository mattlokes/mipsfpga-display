
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.02.2016 19:45:42
// Design Name: 
// Module Name: mf_disp_syncs
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

module mf_disp_syncs  #(parameter NUM=1)(
   input  wire resetn,
   input  wire clk_a,
   input  wire clk_b,
  
   input  wire pulse_mode,

   input  wire [(4*NUM)-1:0] in_a,
   output wire [(4*NUM)-1:0] out_b
);

genvar g;

`ifdef SIMPLE_CDC

generate
   for ( g=0; g<(4*NUM); g=g+1 ) begin
      mf_disp_sync sync (
                           .resetn     (resetn),
                           .clk_a      (clk_a),
                           .clk_b      (clk_b),
                           .pulse_mode (pulse_mode),
                           .in_a       (in_a[g]),
                           .out_b      (out_b[g])
                          );
   end
endgenerate

`else

 wire [NUM-1:0] cdc_empty;
 reg [NUM-1:0] cdc_empty_dly;
 wire [(NUM*4)-1:0] cdc_dout_pre;
generate
   for ( g=0; g<NUM; g=g+1 ) begin

      mf_disp_cdc_fifo sync(
                             .rst    (~resetn),
                             .empty  (cdc_empty[g]),
                             .full   (),
                             
                             .wr_clk (clk_a),
                             .wr_en  (|in_a[ ((g+1)*4)-1 : 4*g ]),
                             .din    ( in_a[ ((g+1)*4)-1 : 4*g ]),
                             
                             .rd_clk (clk_b),
                             .rd_en  (~cdc_empty[g]),
                             .dout   (cdc_dout_pre[ ((g+1)*4)-1 : 4*g] )
      );
      
      always @(posedge clk_b) cdc_empty_dly <= cdc_empty; 
      
      assign out_b[ ((g+1)*4)-1 : 4*g ] = cdc_dout_pre[ ((g+1)*4)-1 : 4*g ] & {4{~cdc_empty_dly[g]}};
   end
endgenerate
`endif
   
endmodule
