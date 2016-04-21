
################################################################
# This is a generated script based on design: mf_disp_fb
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
# source mf_disp_fb_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7a100tcsg324-1
#    set_property BOARD_PART digilentinc.com:nexys4_ddr:part0:1.1 [current_project]


# CHANGE DESIGN NAME HERE
set design_name mf_disp_fb

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
  set fb_rdaddr [ create_bd_port -dir I -from 14 -to 0 fb_rdaddr ]
  set fb_rddata [ create_bd_port -dir O -from 31 -to 0 fb_rddata ]
  set fb_rden [ create_bd_port -dir I fb_rden ]
  set fb_wraddr [ create_bd_port -dir I -from 14 -to 0 fb_wraddr ]
  set fb_wrdata [ create_bd_port -dir I -from 31 -to 0 fb_wrdata ]
  set fb_wren [ create_bd_port -dir I fb_wren ]
  set intr_clk [ create_bd_port -dir I intr_clk ]
  set sys_clk [ create_bd_port -dir I -type clk sys_clk ]
  set_property -dict [ list CONFIG.FREQ_HZ {50000000}  ] $sys_clk

  # Create instance: framebuff_blk_mem_gen, and set properties
  set framebuff_blk_mem_gen [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 framebuff_blk_mem_gen ]
  set_property -dict [ list CONFIG.Enable_32bit_Address {false} CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Memory_Type {Simple_Dual_Port_RAM} CONFIG.Operating_Mode_A {NO_CHANGE} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100} CONFIG.Read_Width_B {32} CONFIG.Register_PortB_Output_of_Memory_Primitives {true} CONFIG.Use_Byte_Write_Enable {false} CONFIG.Write_Depth_A {32000} CONFIG.Write_Width_B {32} CONFIG.use_bram_block {Stand_Alone}  ] $framebuff_blk_mem_gen

  # Create port connections
  connect_bd_net -net fb_rdaddr_1 [get_bd_ports fb_rdaddr] [get_bd_pins framebuff_blk_mem_gen/addrb]
  connect_bd_net -net fb_rden_1 [get_bd_ports fb_rden] [get_bd_pins framebuff_blk_mem_gen/enb]
  connect_bd_net -net fb_wraddr_1 [get_bd_ports fb_wraddr] [get_bd_pins framebuff_blk_mem_gen/addra]
  connect_bd_net -net fb_wrdata_1 [get_bd_ports fb_wrdata] [get_bd_pins framebuff_blk_mem_gen/dina]
  connect_bd_net -net fb_wren_1 [get_bd_ports fb_wren] [get_bd_pins framebuff_blk_mem_gen/ena] [get_bd_pins framebuff_blk_mem_gen/wea]
  connect_bd_net -net framebuff_blk_mem_gen_doutb [get_bd_ports fb_rddata] [get_bd_pins framebuff_blk_mem_gen/doutb]
  connect_bd_net -net intr_clk_1 [get_bd_ports intr_clk] [get_bd_pins framebuff_blk_mem_gen/clkb]
  connect_bd_net -net sys_clk_1 [get_bd_ports sys_clk] [get_bd_pins framebuff_blk_mem_gen/clka]

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


