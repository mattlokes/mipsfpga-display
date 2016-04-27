// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.4 (win64) Build 1412921 Wed Nov 18 09:43:45 MST 2015
// Date        : Wed Apr 27 17:18:04 2016
// Host        : MattLokes running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/ip/xil_2015_4/fb_bram_mem_gen/fb_bram_mem_gen_stub.v
// Design      : fb_bram_mem_gen
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_1,Vivado 2015.4" *)
module fb_bram_mem_gen(clka, ena, wea, addra, dina, clkb, enb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[3:0],addra[14:0],dina[31:0],clkb,enb,addrb[14:0],doutb[31:0]" */;
  input clka;
  input ena;
  input [3:0]wea;
  input [14:0]addra;
  input [31:0]dina;
  input clkb;
  input enb;
  input [14:0]addrb;
  output [31:0]doutb;
endmodule
