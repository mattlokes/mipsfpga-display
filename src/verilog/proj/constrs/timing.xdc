create_clock -period 39.722 -name pix_clk -waveform {0.000 19.861} [get_ports pix_clk]
create_clock -period 20.000 -name s00_axi_aclk -waveform {0.000 10.000} [get_ports s00_axi_aclk]

set_max_delay -datapath_only -from [get_cells mf_disp_axi_top_inst/disp/en_sync_sp/reg_a_0_reg] -to [get_cells mf_disp_axi_top_inst/disp/en_sync_sp/reg_b_0_reg] 5.000
set_max_delay -datapath_only -from [get_cells mf_disp_axi_top_inst/disp/tm_sync_sp/reg_a_0_reg] -to [get_cells mf_disp_axi_top_inst/disp/tm_sync_sp/reg_b_0_reg] 5.000
set_max_delay -datapath_only -from [get_cells mf_disp_axi_top_inst/disp/dm_sync_sp/reg_a_0_reg] -to [get_cells mf_disp_axi_top_inst/disp/dm_sync_sp/reg_b_0_reg] 5.000
set_max_delay -datapath_only -from [get_cells mf_disp_axi_top_inst/disp/fb/fs_sync_ps/reg_a_0_reg] -to [get_cells mf_disp_axi_top_inst/disp/fb/fs_sync_ps/reg_b_0_reg] 5.000
