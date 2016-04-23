//Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:24:04 MST 2014
//Date        : Sat Apr 23 13:09:10 2016
//Host        : matt-windows running 64-bit major release  (build 9200)
//Command     : generate_target mf_disp_fb_wrapper.bd
//Design      : mf_disp_fb_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module mf_disp_fb_wrapper
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

  wire [14:0]fb_rdaddr;
  wire [31:0]fb_rddata;
  wire fb_rden;
  wire [14:0]fb_wraddr;
  wire [31:0]fb_wrdata;
  wire fb_wren;
  wire intr_clk;
  wire sys_clk;

mf_disp_fb mf_disp_fb_i
       (.fb_rdaddr(fb_rdaddr),
        .fb_rddata(fb_rddata),
        .fb_rden(fb_rden),
        .fb_wraddr(fb_wraddr),
        .fb_wrdata(fb_wrdata),
        .fb_wren(fb_wren),
        .intr_clk(intr_clk),
        .sys_clk(sys_clk));
endmodule
