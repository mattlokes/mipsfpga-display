//Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:24:04 MST 2014
//Date        : Sat Apr 23 13:09:04 2016
//Host        : matt-windows running 64-bit major release  (build 9200)
//Command     : generate_target mf_disp_cdc_fifo_wrapper.bd
//Design      : mf_disp_cdc_fifo_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module mf_disp_cdc_fifo_wrapper
   (din,
    dout,
    empty,
    full,
    rd_clk,
    rd_en,
    rst,
    wr_clk,
    wr_en);
  input [3:0]din;
  output [3:0]dout;
  output empty;
  output full;
  input rd_clk;
  input rd_en;
  input rst;
  input wr_clk;
  input wr_en;

  wire [3:0]din;
  wire [3:0]dout;
  wire empty;
  wire full;
  wire rd_clk;
  wire rd_en;
  wire rst;
  wire wr_clk;
  wire wr_en;

mf_disp_cdc_fifo mf_disp_cdc_fifo_i
       (.din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rst(rst),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
endmodule
