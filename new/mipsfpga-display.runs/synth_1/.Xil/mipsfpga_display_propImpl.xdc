set_property SRC_FILE_INFO {cfile:c:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/sources_1/ip/cdc_fifo_gen/cdc_fifo_gen/cdc_fifo_gen_clocks.xdc rfile:../../../mipsfpga-display.srcs/sources_1/ip/cdc_fifo_gen/cdc_fifo_gen/cdc_fifo_gen_clocks.xdc id:1 order:LATE scoped_inst:{mf_disp_axi_top_inst/disp/intf_syncs/genblk1[0].sync/U0}} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_disable_timing -from CLK -to O [filter [all_fanout -from [get_ports wr_clk] -flat -endpoints_only -only_cells] {PRIMITIVE_SUBGROUP==dram || PRIMITIVE_SUBGROUP==LUTRAM}]
set_property src_info {type:SCOPED_XDC file:1 line:61 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -from [get_cells inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/rd_pntr_gc_reg[*]] -to [get_cells inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/gsync_stage[*].wr_stg_inst/Q_reg_reg[*]] -datapath_only [get_property -min PERIOD [get_clocks -of_objects [get_ports pix_clk]]]
set_property src_info {type:SCOPED_XDC file:1 line:63 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -from [get_cells inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/wr_pntr_gc_reg[*]] -to [get_cells inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/gsync_stage[*].rd_stg_inst/Q_reg_reg[*]] -datapath_only [get_property -min PERIOD [get_clocks -of_objects [get_ports s00_axi_aclk]]]