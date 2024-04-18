################################################################################
#
# Init setup file
# Created by Genus(TM) Synthesis Solution on 11/27/2023 22:13:50
#
################################################################################

      if { ![is_common_ui_mode] } {
        error "This script must be loaded into an 'innovus -stylus' session."
      }
    


read_mmmc ./SYN/Innovus/rare_riscv_test_w_mem.mmmc.tcl

read_physical -lef {/project/chriskim07/PDKs/TSMC28nm/28HPC_tools/APR_Tech/Cadence/tn28clpr002e1_1_9_1a/PRTF_EDI_28nm_Cad_V19_1a/PR_tech_VRP_140nm/Cadence/LefHeader/HVH/tsmcn28_9lm6X1Z1URDL.tlef /project/chriskim07/PDKs/TSMC28nm/iolib/tphn28hpcpgv18_170d/TSMCHOME/digital/Back_End/lef/tphn28hpcpgv18_110a/mt_2/9lm/lef/tphn28hpcpgv18_9lm.lef /project/chriskim07/PDKs/TSMC28nm/sclib/TSMCHOME/digital/Back_End/lef/tcbn28hpcplusbwp30p140_110a/lef/tcbn28hpcplusbwp30p140.lef /project/chriskim01/chipfab/rare23/SRAM/ts1n28hpcpsvtb1024x32m4sw_180a/LEF/ts1n28hpcpsvtb1024x32m4sw_180a.lef /project/chriskim01/chipfab/rare23/SRAM/ts1n28hpcpsvtb2048x32m4sw_180a/LEF/ts1n28hpcpsvtb2048x32m4sw_180a.lef /project/chriskim01/chipfab/rare23/Innovus/fullchip/core/odometer_normal_rvt/odometer_full_rvt.lef /project/chriskim01/chipfab/rare23/Innovus/fullchip/core/odometer_normal_lvt/odometer_full_lvt.lef /project/chriskim01/chipfab/rare23/Innovus/fullchip/core/odometer_normal_hvt/odometer_full_hvt.lef /project/chriskim01/chipfab/rare23/Innovus/fullchip/core/odometer_stacked/odometer_full_stacked_rvt.lef /project/chriskim01/chipfab/rare23/Innovus/fullchip/core/vco/VCO_full.lef /project/chriskim01/chipfab/rare23/Innovus/fullchip/core/rosc_heater/rare_heater.lef /project/chriskim01/chipfab/rare23/Innovus/fullchip/core/temp_sensor/rare_sensor.lef}

read_netlist ./SYN/Innovus/rare_riscv_test_w_mem.v

read_power_intent  -cpf ./SYN/Innovus/rare_riscv_test_w_mem.cpf

init_design -skip_sdc_read
