proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  create_project -in_memory -part xc7a100tcsg324-1
  set_property board_part digilentinc.com:nexys4_ddr:part0:1.1 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir C:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/mipsfpga_display_2015_4.cache/wt [current_project]
  set_property parent.project_path C:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/mipsfpga_display_2015_4.xpr [current_project]
  set_property ip_repo_paths c:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/mipsfpga_display_2015_4.cache/ip [current_project]
  set_property ip_output_repo c:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/mipsfpga_display_2015_4.cache/ip [current_project]
  add_files -quiet C:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/mipsfpga_display_2015_4.runs/synth_1/mipsfpga_display.dcp
  add_files -quiet C:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/mipsfpga_display_2015_4.runs/cdc_fifo_gen_synth_1/cdc_fifo_gen.dcp
  set_property netlist_only true [get_files C:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/mipsfpga_display_2015_4.runs/cdc_fifo_gen_synth_1/cdc_fifo_gen.dcp]
  add_files -quiet C:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/mipsfpga_display_2015_4.runs/pal_bram_mem_gen_synth_1/pal_bram_mem_gen.dcp
  set_property netlist_only true [get_files C:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/mipsfpga_display_2015_4.runs/pal_bram_mem_gen_synth_1/pal_bram_mem_gen.dcp]
  add_files -quiet C:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/mipsfpga_display_2015_4.runs/fb_bram_mem_gen_synth_1/fb_bram_mem_gen.dcp
  set_property netlist_only true [get_files C:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/mipsfpga_display_2015_4.runs/fb_bram_mem_gen_synth_1/fb_bram_mem_gen.dcp]
  read_xdc -mode out_of_context -ref cdc_fifo_gen -cells U0 c:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/ip/xil_2015_4/cdc_fifo_gen/cdc_fifo_gen_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/ip/xil_2015_4/cdc_fifo_gen/cdc_fifo_gen_ooc.xdc]
  read_xdc -ref cdc_fifo_gen -cells U0 c:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/ip/xil_2015_4/cdc_fifo_gen/cdc_fifo_gen/cdc_fifo_gen.xdc
  set_property processing_order EARLY [get_files c:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/ip/xil_2015_4/cdc_fifo_gen/cdc_fifo_gen/cdc_fifo_gen.xdc]
  read_xdc -mode out_of_context -ref pal_bram_mem_gen -cells U0 c:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/ip/xil_2015_4/pal_bram_mem_gen/pal_bram_mem_gen_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/ip/xil_2015_4/pal_bram_mem_gen/pal_bram_mem_gen_ooc.xdc]
  read_xdc -mode out_of_context -ref fb_bram_mem_gen -cells U0 c:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/ip/xil_2015_4/fb_bram_mem_gen/fb_bram_mem_gen_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/ip/xil_2015_4/fb_bram_mem_gen/fb_bram_mem_gen_ooc.xdc]
  read_xdc C:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/constrs/timing.xdc
  read_xdc -ref cdc_fifo_gen -cells U0 c:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/ip/xil_2015_4/cdc_fifo_gen/cdc_fifo_gen/cdc_fifo_gen_clocks.xdc
  set_property processing_order LATE [get_files c:/Users/matt.lokes/Projects/mipsfpga-display/src/verilog/proj/ip/xil_2015_4/cdc_fifo_gen/cdc_fifo_gen/cdc_fifo_gen_clocks.xdc]
  link_design -top mipsfpga_display -part xc7a100tcsg324-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force mipsfpga_display_opt.dcp
  report_drc -file mipsfpga_display_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file mipsfpga_display.hwdef}
  place_design 
  write_checkpoint -force mipsfpga_display_placed.dcp
  report_io -file mipsfpga_display_io_placed.rpt
  report_utilization -file mipsfpga_display_utilization_placed.rpt -pb mipsfpga_display_utilization_placed.pb
  report_control_sets -verbose -file mipsfpga_display_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force mipsfpga_display_routed.dcp
  report_drc -file mipsfpga_display_drc_routed.rpt -pb mipsfpga_display_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file mipsfpga_display_timing_summary_routed.rpt -rpx mipsfpga_display_timing_summary_routed.rpx
  report_power -file mipsfpga_display_power_routed.rpt -pb mipsfpga_display_power_summary_routed.pb
  report_route_status -file mipsfpga_display_route_status.rpt -pb mipsfpga_display_route_status.pb
  report_clock_utilization -file mipsfpga_display_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

