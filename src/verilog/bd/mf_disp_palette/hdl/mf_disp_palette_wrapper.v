//Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:24:04 MST 2014
//Date        : Sat Apr 23 13:09:07 2016
//Host        : matt-windows running 64-bit major release  (build 9200)
//Command     : generate_target mf_disp_palette_wrapper.bd
//Design      : mf_disp_palette_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module mf_disp_palette_wrapper
   (intr_clk,
    pal_rdaddr,
    pal_rddata,
    pal_rden,
    pal_wraddr,
    pal_wrdata,
    pal_wren,
    sys_clk);
  input intr_clk;
  input [7:0]pal_rdaddr;
  output [17:0]pal_rddata;
  input pal_rden;
  input [7:0]pal_wraddr;
  input [17:0]pal_wrdata;
  input pal_wren;
  input sys_clk;

  wire intr_clk;
  wire [7:0]pal_rdaddr;
  wire [17:0]pal_rddata;
  wire pal_rden;
  wire [7:0]pal_wraddr;
  wire [17:0]pal_wrdata;
  wire pal_wren;
  wire sys_clk;

mf_disp_palette mf_disp_palette_i
       (.intr_clk(intr_clk),
        .pal_rdaddr(pal_rdaddr),
        .pal_rddata(pal_rddata),
        .pal_rden(pal_rden),
        .pal_wraddr(pal_wraddr),
        .pal_wrdata(pal_wrdata),
        .pal_wren(pal_wren),
        .sys_clk(sys_clk));
endmodule
