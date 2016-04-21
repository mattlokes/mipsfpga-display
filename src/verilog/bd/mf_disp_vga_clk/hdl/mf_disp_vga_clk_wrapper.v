//Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:24:04 MST 2014
//Date        : Sat Mar 19 16:22:03 2016
//Host        : matt-windows running 64-bit major release  (build 9200)
//Command     : generate_target mf_disp_vga_clk_wrapper.bd
//Design      : mf_disp_vga_clk_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module mf_disp_vga_clk_wrapper
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

  wire CLK100MHZ;
  wire clock_pll_locked;
  wire resetn;
  wire sys_clk;
  wire vga_clk;

mf_disp_vga_clk mf_disp_vga_clk_i
       (.CLK100MHZ(CLK100MHZ),
        .clock_pll_locked(clock_pll_locked),
        .resetn(resetn),
        .sys_clk(sys_clk),
        .vga_clk(vga_clk));
endmodule
