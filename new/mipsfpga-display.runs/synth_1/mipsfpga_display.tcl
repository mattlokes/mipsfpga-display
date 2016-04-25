# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.cache/wt [current_project]
set_property parent.project_path C:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:nexys4_ddr:part0:1.1 [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
read_verilog C:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/sources_1/imports/proj/include/mf_disp_conf.vh
read_ip c:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/sources_1/ip/fb_bram_mem_gen/fb_bram_mem_gen.xci
set_property used_in_implementation false [get_files -all c:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/sources_1/ip/fb_bram_mem_gen/fb_bram_mem_gen_ooc.xdc]
set_property is_locked true [get_files c:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/sources_1/ip/fb_bram_mem_gen/fb_bram_mem_gen.xci]

read_ip c:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/sources_1/ip/pal_bram_mem_gen/pal_bram_mem_gen.xci
set_property used_in_implementation false [get_files -all c:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/sources_1/ip/pal_bram_mem_gen/pal_bram_mem_gen_ooc.xdc]
set_property is_locked true [get_files c:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/sources_1/ip/pal_bram_mem_gen/pal_bram_mem_gen.xci]

read_ip c:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/sources_1/ip/cdc_fifo_gen/cdc_fifo_gen.xci
set_property used_in_implementation false [get_files -all c:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/sources_1/ip/cdc_fifo_gen/cdc_fifo_gen/cdc_fifo_gen_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/sources_1/ip/cdc_fifo_gen/cdc_fifo_gen/cdc_fifo_gen.xdc]
set_property is_locked true [get_files c:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/sources_1/ip/cdc_fifo_gen/cdc_fifo_gen.xci]

read_verilog -library xil_defaultlib {
  C:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/sources_1/imports/proj/src/mf_disp_cmd_reg_top.v
  C:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/sources_1/imports/proj/src/mf_disp_intf_vga_top.v
  C:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/sources_1/imports/proj/src/mf_disp_fb_top.v
  C:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/sources_1/imports/proj/src/mf_disp_syncs.v
  C:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/sources_1/imports/proj/src/mf_disp_addr_dec.v
  C:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/sources_1/imports/proj/src/mf_disp_top.v
  C:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/sources_1/imports/proj/src/mf_disp_axi_top.v
  C:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/sources_1/imports/proj/src/mipsfpga_display.v
}
read_xdc C:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/package_constrs/imports/new/timing.xdc
set_property used_in_implementation false [get_files C:/Users/matt.lokes/mipsfpga-display/mipsfpga-display.srcs/package_constrs/imports/new/timing.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
synth_design -top mipsfpga_display -part xc7a100tcsg324-1
write_checkpoint -noxdef mipsfpga_display.dcp
catch { report_utilization -file mipsfpga_display_utilization_synth.rpt -pb mipsfpga_display_utilization_synth.pb }