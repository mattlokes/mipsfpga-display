//Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:24:04 MST 2014
//Date        : Sat Mar 19 16:22:03 2016
//Host        : matt-windows running 64-bit major release  (build 9200)
//Command     : generate_target mf_disp_vga_clk.bd
//Design      : mf_disp_vga_clk
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module mf_disp_vga_clk
   (CLK100MHZ,
    clock_pll_locked,
    resetn,
    sys_clk,
    vga_clk);
  input CLK100MHZ;
  output clock_pll_locked;
  input resetn;
  output sys_clk;
  output vga_clk;

  wire CLK100MHZ_1;
  wire resetn_1;
  wire vga_clk_wiz_clk_out1;
  wire vga_clk_wiz_clk_out2;
  wire vga_clk_wiz_locked;

  assign CLK100MHZ_1 = CLK100MHZ;
  assign clock_pll_locked = vga_clk_wiz_locked;
  assign resetn_1 = resetn;
  assign sys_clk = vga_clk_wiz_clk_out2;
  assign vga_clk = vga_clk_wiz_clk_out1;
mf_disp_vga_clk_vga_clk_wiz_0 vga_clk_wiz
       (.clk_in1(CLK100MHZ_1),
        .clk_out1(vga_clk_wiz_clk_out1),
        .clk_out2(vga_clk_wiz_clk_out2),
        .locked(vga_clk_wiz_locked),
        .resetn(resetn_1));
endmodule
