//Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:24:04 MST 2014
//Date        : Sat Apr 23 13:09:07 2016
//Host        : matt-windows running 64-bit major release  (build 9200)
//Command     : generate_target mf_disp_palette.bd
//Design      : mf_disp_palette
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module mf_disp_palette
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

  wire intr_clk_1;
  wire [7:0]pal_rdaddr_1;
  wire pal_rden_1;
  wire [7:0]pal_wraddr_1;
  wire [17:0]pal_wrdata_1;
  wire pal_wren_1;
  wire [17:0]palette_blk_mem_gen_doutb;
  wire sys_clk_1;

  assign intr_clk_1 = intr_clk;
  assign pal_rdaddr_1 = pal_rdaddr[7:0];
  assign pal_rddata[17:0] = palette_blk_mem_gen_doutb;
  assign pal_rden_1 = pal_rden;
  assign pal_wraddr_1 = pal_wraddr[7:0];
  assign pal_wrdata_1 = pal_wrdata[17:0];
  assign pal_wren_1 = pal_wren;
  assign sys_clk_1 = sys_clk;
mf_disp_palette_palette_blk_mem_gen_0 palette_blk_mem_gen
       (.addra(pal_wraddr_1),
        .addrb(pal_rdaddr_1),
        .clka(sys_clk_1),
        .clkb(intr_clk_1),
        .dina(pal_wrdata_1),
        .doutb(palette_blk_mem_gen_doutb),
        .ena(pal_wren_1),
        .enb(pal_rden_1),
        .wea(pal_wren_1));
endmodule
