################################################################################
#
# Init setup file
# Created by Genus(TM) Synthesis Solution on 11/30/2023 17:13:07
#
################################################################################

      if { ![is_common_ui_mode] } {
        error "This script must be loaded into an 'innovus -stylus' session."
      }
    


read_mmmc ./SYN/Innovus/FULLCHIP.mmmc.tcl

read_physical -lef {/project/chriskim07/PDKs/TSMC28nm/28HPC_tools/APR_Tech/Cadence/tn28clpr002e1_1_9_1a/PRTF_EDI_28nm_Cad_V19_1a/PR_tech_VRP_140nm/Cadence/LefHeader/HVH/tsmcn28_9lm6X1Z1URDL.tlef /project/chriskim07/PDKs/TSMC28nm/iolib/tphn28hpcpgv18_170d/TSMCHOME/digital/Back_End/lef/tphn28hpcpgv18_110a/mt_2/9lm/lef/tphn28hpcpgv18_9lm.lef /project/chriskim07/PDKs/TSMC28nm/iolib/tphn28hpcpgv18_170d/TSMCHOME/digital/Back_End/lef/tphn28hpcpgv18_110a/mt_2/9lm/lef/tphn28hpcpgv18_9lm.lef /project/chriskim07/PDKs/TSMC28nm/sclib/TSMCHOME/digital/Back_End/lef/tcbn28hpcplusbwp30p140_110a/lef/tcbn28hpcplusbwp30p140.lef /project/chriskim07/PDKs/TSMC28nm/sclib/TSMCHOME/digital/Back_End/lef/tcbn28hpcplusbwp30p140lvt_110a/lef/tcbn28hpcplusbwp30p140lvt.lef /project/chriskim01/chipfab/rare23/SRAM/ts1n28hpcpsvtb1024x32m4sw_180a/LEF/ts1n28hpcpsvtb1024x32m4sw_180a.lef /project/chriskim01/chipfab/rare23/SRAM/ts1n28hpcpsvtb2048x32m4sw_180a/LEF/ts1n28hpcpsvtb2048x32m4sw_180a.lef /project/chriskim01/chipfab/rare23/Innovus/fullchip/core/riscv_innovus_run/RESULTS/rare_riscv_test_w_mem.lef}

read_netlist ./SYN/Innovus/FULLCHIP.v

init_design
