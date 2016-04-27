// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.4 (win64) Build 1412921 Wed Nov 18 09:43:45 MST 2015
// Date        : Wed Apr 27 17:16:42 2016
// Host        : MattLokes running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/ip/xil_2015_4/tb_hw_clk_wiz/tb_hw_clk_wiz_stub.v
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
