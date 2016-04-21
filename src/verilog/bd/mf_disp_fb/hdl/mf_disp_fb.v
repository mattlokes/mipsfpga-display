//Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:24:04 MST 2014
//Date        : Thu Apr 21 21:50:52 2016
//Host        : matt-windows running 64-bit major release  (build 9200)
//Command     : generate_target mf_disp_fb.bd
//Design      : mf_disp_fb
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module mf_disp_fb
   (fb_rdaddr,
    fb_rddata,
    fb_rden,
    fb_wraddr,
    fb_wrdata,
    fb_wren,
    intr_clk,
    sys_clk);
  input [14:0]fb_rdaddr;
  output [31:0]fb_rddata;
  input fb_rden;
  input [14:0]fb_wraddr;
  input [31:0]fb_wrdata;
  input fb_wren;
  input intr_clk;
  input sys_clk;

  wire [14:0]fb_rdaddr_1;
  wire fb_rden_1;
  wire [14:0]fb_wraddr_1;
  wire [31:0]fb_wrdata_1;
  wire fb_wren_1;
  wire [31:0]framebuff_blk_mem_gen_doutb;
  wire intr_clk_1;
  wire sys_clk_1;

  assign fb_rdaddr_1 = fb_rdaddr[14:0];
  assign fb_rddata[31:0] = framebuff_blk_mem_gen_doutb;
  assign fb_rden_1 = fb_rden;
  assign fb_wraddr_1 = fb_wraddr[14:0];
  assign fb_wrdata_1 = fb_wrdata[31:0];
  assign fb_wren_1 = fb_wren;
  assign intr_clk_1 = intr_clk;
  assign sys_clk_1 = sys_clk;
mf_disp_fb_framebuff_blk_mem_gen_0 framebuff_blk_mem_gen
       (.addra(fb_wraddr_1),
        .addrb(fb_rdaddr_1),
        .clka(sys_clk_1),
        .clkb(intr_clk_1),
        .dina(fb_wrdata_1),
        .doutb(framebuff_blk_mem_gen_doutb),
        .ena(fb_wren_1),
        .enb(fb_rden_1),
        .wea(fb_wren_1));
endmodule
