################################################################################
#
# Innovus setup file
# Created by Genus(TM) Synthesis Solution 19.15-s090_1
#   on 11/27/2023 22:13:50
#
################################################################################
#
# Genus(TM) Synthesis Solution setup file
# This file can only be run in Innovus Common UI mode.
#
################################################################################

      regexp {\d\d} [get_db program_version] major_version
      if { $major_version < 18 } {
        error "Innovus version must be 18 or higher."
      }
    

      set _t0 [clock seconds]
      puts [format  {%%%s Begin Genus to Innovus Setup (%s)} \# [clock format $_t0 -format {%m/%d %H:%M:%S}]]
    
if {[is_attribute -obj_type root read_physical_allow_multiple_port_pin_without_must_join]} {
set_db read_physical_allow_multiple_port_pin_without_must_join true
} else {
  set read_physical_allow_multiple_port_pin_without_must_join 1
}


# Design Import
################################################################################
set_library_unit -cap 1pf -time 1ns
## Reading FlowKit settings file
source ./SYN/Innovus/rare_riscv_test_w_mem.flowkit_settings.tcl

source ./SYN/Innovus/rare_riscv_test_w_mem.invs_init.tcl

# Reading metrics file
################################################################################
read_metric -id current ./SYN/Innovus/rare_riscv_test_w_mem.metrics.json

## Reading common preserve file for dont_touch and dont_use preserve settings
source -quiet ./SYN/Innovus/rare_riscv_test_w_mem.preserve.tcl



# Mode Setup
################################################################################
source ./SYN/Innovus/rare_riscv_test_w_mem.mode


# MSV Setup
################################################################################

# Source cell padding from Genus
################################################################################
source ./SYN/Innovus/rare_riscv_test_w_mem.cell_pad.tcl 


# Reading write_name_mapping file
################################################################################

      if { [is_attribute -obj_type port original_name] &&
           [is_attribute -obj_type pin original_name] &&
           [is_attribute -obj_type pin is_phase_inverted]} {
        source ./SYN/Innovus/rare_riscv_test_w_mem.wnm_attrs.tcl
      }
    

# Reading NDR file
source ./SYN/Innovus/rare_riscv_test_w_mem.ndr.tcl

# Reading minimum routing layer data file
################################################################################
eval_legacy {gpsPrivate::readMinLayerCstr -file ./SYN/Innovus/rare_riscv_test_w_mem.min_layer} 

eval_legacy {set edi_pe::pegConsiderMacroLayersUnblocked 1}
eval_legacy {set edi_pe::pegPreRouteWireWidthBasedDensityCalModel 1}

      set _t1 [clock seconds]
      puts [format  {%%%s End Genus to Innovus Setup (%s, real=%s)} \# [clock format $_t1 -format {%m/%d %H:%M:%S}] [clock format [expr {28800 + $_t1 - $_t0}] -format {%H:%M:%S}]]
    
