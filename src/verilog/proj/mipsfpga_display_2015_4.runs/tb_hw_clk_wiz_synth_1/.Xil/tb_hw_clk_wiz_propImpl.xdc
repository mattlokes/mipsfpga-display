set_property SRC_FILE_INFO {cfile:c:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/ip/xil_2015_4/tb_hw_clk_wiz/tb_hw_clk_wiz.xdc rfile:../../../ip/xil_2015_4/tb_hw_clk_wiz/tb_hw_clk_wiz.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:56 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.1
