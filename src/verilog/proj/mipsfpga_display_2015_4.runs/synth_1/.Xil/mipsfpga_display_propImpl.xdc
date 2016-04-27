set_property SRC_FILE_INFO {cfile:C:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/constrs/timing.xdc rfile:../../../constrs/timing.xdc id:1} [current_design]
set_property src_info {type:XDC file:1 line:4 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -datapath_only -from [get_cells mf_disp_axi_top_inst/disp/en_sync_sp/reg_a_0_reg] -to [get_cells mf_disp_axi_top_inst/disp/en_sync_sp/reg_b_0_reg] 5.000
set_property src_info {type:XDC file:1 line:5 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -datapath_only -from [get_cells mf_disp_axi_top_inst/disp/tm_sync_sp/reg_a_0_reg] -to [get_cells mf_disp_axi_top_inst/disp/tm_sync_sp/reg_b_0_reg] 5.000
set_property src_info {type:XDC file:1 line:6 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -datapath_only -from [get_cells mf_disp_axi_top_inst/disp/dm_sync_sp/reg_a_0_reg] -to [get_cells mf_disp_axi_top_inst/disp/dm_sync_sp/reg_b_0_reg] 5.000
set_property src_info {type:XDC file:1 line:7 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -datapath_only -from [get_cells mf_disp_axi_top_inst/disp/fb/fs_sync_ps/reg_a_0_reg] -to [get_cells mf_disp_axi_top_inst/disp/fb/fs_sync_ps/reg_b_0_reg] 5.000
