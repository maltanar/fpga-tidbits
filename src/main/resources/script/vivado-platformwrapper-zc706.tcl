if {$argc != 5} {
  puts "Expected: <tidbits root> <accel verilog> <proj name> <proj dir> <freq>"
  exit
}

# pull cmdline variables to use during setup
set config_tidbits_root  [lindex $argv 0]
set config_blackboxip_repo "$config_tidbits_root/src/main/vivado-ip-cores"
set config_tidbits_verilog "$config_tidbits_root/src/main/verilog"
set config_accel_verilog [lindex $argv 1]
set config_proj_name [lindex $argv 2]
set config_proj_dir [lindex $argv 3]
set config_freq [lindex $argv 4]
puts $config_tidbits_verilog
# fixed for platform
set config_proj_part "xc7z045ffg900-2"
set config_proj_board "xilinx.com:zc706:part0:1.2"

# set up project
create_project $config_proj_name $config_proj_dir -part $config_proj_part
set_property board_part $config_proj_board [current_project]
set_property ip_repo_paths $config_blackboxip_repo [current_project]
update_ip_catalog

# create block design
create_bd_design "procsys"
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]

# instantiate PlatformWrapper blackbox IP
create_bd_cell -type ip -vlnv ntnueecs:eecsaccel:ZedBoardWrapper:1.0 ZedBoardWrapper_0
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins ZedBoardWrapper_0/csr]
# enable AXI HP ports, set target frequency to 200 MHz
set_property -dict [list CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ $config_freq CONFIG.PCW_USE_S_AXI_HP0 {1} CONFIG.PCW_USE_S_AXI_HP1 {1} CONFIG.PCW_USE_S_AXI_HP2 {1} CONFIG.PCW_USE_S_AXI_HP3 {1}] [get_bd_cells processing_system7_0]
# set number of ports to four on the blackbox IP
set_property -dict [list CONFIG.NUM_MEM_PORTS {4}] [get_bd_cells ZedBoardWrapper_0]
# connect IP to Zynq PS
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/ZedBoardWrapper_0/mem0" Clk "Auto" }  [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/ZedBoardWrapper_0/mem1" Clk "Auto" }  [get_bd_intf_pins processing_system7_0/S_AXI_HP1]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/ZedBoardWrapper_0/mem2" Clk "Auto" }  [get_bd_intf_pins processing_system7_0/S_AXI_HP2]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/ZedBoardWrapper_0/mem3" Clk "Auto" }  [get_bd_intf_pins processing_system7_0/S_AXI_HP3]
# make the block design look prettier
regenerate_bd_layout
validate_bd_design
save_bd_design
# create HDL wrapper
make_wrapper -files [get_files $config_proj_dir/$config_proj_name.srcs/sources_1/bd/procsys/procsys.bd] -top
add_files -norecurse $config_proj_dir/$config_proj_name.srcs/sources_1/bd/procsys/hdl/procsys_wrapper.v
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
# use manual compile order to ensure accel verilog is processed prior to block design
update_compile_order -fileset sources_1
set_property source_mgmt_mode DisplayOnly [current_project]
# add the real Verilog implementation for the accelerator and move to top
add_files -norecurse $config_accel_verilog
reorder_files -front $config_accel_verilog
# add misc verilog files used by fpga-tidbits
add_files -norecurse $config_tidbits_verilog/Q_srl.v $config_tidbits_verilog/DualPortBRAM.v
reorder_files -before $config_accel_verilog $config_tidbits_verilog/Q_srl.v $config_tidbits_verilog/DualPortBRAM.v
