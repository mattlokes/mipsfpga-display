// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:24:04 MST 2014
// Date        : Wed Apr 27 20:35:22 2016
// Host        : matt-windows running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/Matt/Projects/mipsfpga-display/src/verilog/proj/ip/xil_2014_4/pal_bram_mem_gen/pal_bram_mem_gen_stub.v
// Design      : pal_bram_mem_gen
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_2,Vivado 2014.4" *)
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
