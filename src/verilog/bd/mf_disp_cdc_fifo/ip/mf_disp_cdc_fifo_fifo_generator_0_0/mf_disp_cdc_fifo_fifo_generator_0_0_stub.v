// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:24:04 MST 2014
// Date        : Sat Apr 23 13:04:56 2016
// Host        : matt-windows running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/Matt/Projects/mipsfpga_display/src/verilog/bd/mf_disp_cdc_fifo/ip/mf_disp_cdc_fifo_fifo_generator_0_0/mf_disp_cdc_fifo_fifo_generator_0_0_stub.v
// Design      : mf_disp_cdc_fifo_fifo_generator_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v12_0,Vivado 2014.4" *)
module mf_disp_cdc_fifo_fifo_generator_0_0(rst, wr_clk, rd_clk, din, wr_en, rd_en, dout, full, empty)
/* synthesis syn_black_box black_box_pad_pin="rst,wr_clk,rd_clk,din[3:0],wr_en,rd_en,dout[3:0],full,empty" */;
  input rst;
  input wr_clk;
  input rd_clk;
  input [3:0]din;
  input wr_en;
  input rd_en;
  output [3:0]dout;
  output full;
  output empty;
endmodule
