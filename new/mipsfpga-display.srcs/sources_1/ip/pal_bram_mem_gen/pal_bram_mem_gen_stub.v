// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.4 (win64) Build 1412921 Wed Nov 18 09:43:45 MST 2015
// Date        : Wed Apr 27 10:00:52 2016
// Host        : MattLokes running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/matt.lokes/Projects/mipsfpga-display/new/mipsfpga-display.srcs/sources_1/ip/pal_bram_mem_gen/pal_bram_mem_gen_stub.v
// Design      : pal_bram_mem_gen
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_1,Vivado 2015.4" *)
module pal_bram_mem_gen(clka, ena, wea, addra, dina, clkb, enb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[7:0],dina[17:0],clkb,enb,addrb[7:0],doutb[17:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [7:0]addra;
  input [17:0]dina;
  input clkb;
  input enb;
  input [7:0]addrb;
  output [17:0]doutb;
endmodule
