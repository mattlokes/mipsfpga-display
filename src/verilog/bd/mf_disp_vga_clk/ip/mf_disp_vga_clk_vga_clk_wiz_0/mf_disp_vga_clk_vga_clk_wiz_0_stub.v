// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:24:04 MST 2014
// Date        : Sat Apr 23 13:03:51 2016
// Host        : matt-windows running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/Matt/Projects/mipsfpga_display/src/verilog/bd/mf_disp_vga_clk/ip/mf_disp_vga_clk_vga_clk_wiz_0/mf_disp_vga_clk_vga_clk_wiz_0_stub.v
// Design      : mf_disp_vga_clk_vga_clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module mf_disp_vga_clk_vga_clk_wiz_0(clk_in1, clk_out1, clk_out2, resetn, locked)
/* synthesis syn_black_box black_box_pad_pin="clk_in1,clk_out1,clk_out2,resetn,locked" */;
  input clk_in1;
  output clk_out1;
  output clk_out2;
  input resetn;
  output locked;
endmodule
