// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.4 (win64) Build 1412921 Wed Nov 18 09:43:45 MST 2015
// Date        : Mon Apr 25 19:49:09 2016
// Host        : matt-windows running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/Matt/Projects/mipsfpga-display/new/mipsfpga-display.srcs/sources_1/ip/tb_hw_clk_wiz/tb_hw_clk_wiz_stub.v
// Design      : tb_hw_clk_wiz
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module tb_hw_clk_wiz(clk_in1, clk_out1, clk_out2)
/* synthesis syn_black_box black_box_pad_pin="clk_in1,clk_out1,clk_out2" */;
  input clk_in1;
  output clk_out1;
  output clk_out2;
endmodule
