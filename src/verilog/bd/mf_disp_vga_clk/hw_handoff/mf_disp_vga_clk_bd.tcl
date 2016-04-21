
################################################################
# This is a generated script based on design: mf_disp_vga_clk
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2014.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source mf_disp_vga_clk_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7a100tcsg324-1
#    set_property BOARD_PART digilentinc.com:nexys4_ddr:part0:1.1 [current_project]


# CHANGE DESIGN NAME HERE
set design_name mf_disp_vga_clk

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}


# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set CLK100MHZ [ create_bd_port -dir I -type clk CLK100MHZ ]
  set_property -dict [ list CONFIG.CLK_DOMAIN {mf_disp_vga_clk_sys_clk} CONFIG.FREQ_HZ {100000000}  ] $CLK100MHZ
  set clock_pll_locked [ create_bd_port -dir O clock_pll_locked ]
  set resetn [ create_bd_port -dir I -type rst resetn ]
  set sys_clk [ create_bd_port -dir O -type clk sys_clk ]
  set vga_clk [ create_bd_port -dir O -type clk vga_clk ]

  # Create instance: vga_clk_wiz, and set properties
  set vga_clk_wiz [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.1 vga_clk_wiz ]
  set_property -dict [ list CONFIG.CLKIN1_JITTER_PS {100.0} CONFIG.CLKIN2_JITTER_PS {100.0} CONFIG.CLKOUT1_JITTER {183.215} CONFIG.CLKOUT1_PHASE_ERROR {105.461} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {25.175} CONFIG.CLKOUT2_JITTER {159.475} CONFIG.CLKOUT2_PHASE_ERROR {105.461} CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {50.000} CONFIG.CLKOUT2_USED {true} CONFIG.CLK_IN1_BOARD_INTERFACE {Custom} CONFIG.CLK_IN2_BOARD_INTERFACE {Custom} CONFIG.NUM_OUT_CLKS {2} CONFIG.PRIM_IN_FREQ {100.000} CONFIG.RESET_BOARD_INTERFACE {Custom} CONFIG.RESET_TYPE {ACTIVE_LOW} CONFIG.USE_INCLK_SWITCHOVER {false}  ] $vga_clk_wiz

  # Create port connections
  connect_bd_net -net CLK100MHZ_1 [get_bd_ports CLK100MHZ] [get_bd_pins vga_clk_wiz/clk_in1]
  connect_bd_net -net resetn_1 [get_bd_ports resetn] [get_bd_pins vga_clk_wiz/resetn]
  connect_bd_net -net vga_clk_wiz_clk_out1 [get_bd_ports vga_clk] [get_bd_pins vga_clk_wiz/clk_out1]
  connect_bd_net -net vga_clk_wiz_clk_out2 [get_bd_ports sys_clk] [get_bd_pins vga_clk_wiz/clk_out2]
  connect_bd_net -net vga_clk_wiz_locked [get_bd_ports clock_pll_locked] [get_bd_pins vga_clk_wiz/locked]

  # Create address segments
  

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


