//Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:24:04 MST 2014
//Date        : Sat Apr 23 13:09:04 2016
//Host        : matt-windows running 64-bit major release  (build 9200)
//Command     : generate_target mf_disp_cdc_fifo.bd
//Design      : mf_disp_cdc_fifo
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module mf_disp_cdc_fifo
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

  wire [3:0]din_1;
  wire [3:0]fifo_generator_0_dout;
  wire fifo_generator_0_empty;
  wire fifo_generator_0_full;
  wire rd_clk_1;
  wire rd_en_1;
  wire rst_1;
  wire wr_clk_1;
  wire wr_en_1;

  assign din_1 = din[3:0];
  assign dout[3:0] = fifo_generator_0_dout;
  assign empty = fifo_generator_0_empty;
  assign full = fifo_generator_0_full;
  assign rd_clk_1 = rd_clk;
  assign rd_en_1 = rd_en;
  assign rst_1 = rst;
  assign wr_clk_1 = wr_clk;
  assign wr_en_1 = wr_en;
mf_disp_cdc_fifo_fifo_generator_0_0 fifo_generator_0
       (.din(din_1),
        .dout(fifo_generator_0_dout),
        .empty(fifo_generator_0_empty),
        .full(fifo_generator_0_full),
        .rd_clk(rd_clk_1),
        .rd_en(rd_en_1),
        .rst(rst_1),
        .wr_clk(wr_clk_1),
        .wr_en(wr_en_1));
endmodule
