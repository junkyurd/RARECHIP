set TOPDESIGN FULLCHIP

set_db library {/project/chriskim07/PDKs/TSMC28nm/iolib/tphn28hpcpgv18_170d/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tphn28hpcpgv18_170a/tphn28hpcpgv18tt0p9v1p8v25c.lib\
/project/chriskim07/PDKs/TSMC28nm/sclib/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn28hpcplusbwp30p140_180a/tcbn28hpcplusbwp30p140tt0p9v25c.lib\
/project/chriskim07/PDKs/TSMC28nm/sclib/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn28hpcplusbwp30p140lvt_180a/tcbn28hpcplusbwp30p140lvttt0p8v25c.lib\
/project/chriskim07/PDKs/TSMC28nm/sclib/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn28hpcplusbwp30p140_180a/tcbn28hpcplusbwp30p140tt0p9v0p9v25c.lib\
/project/chriskim01/chipfab/rare23/SRAM/ts1n28hpcpsvtb1024x32m4sw_180a/NLDM/ts1n28hpcpsvtb1024x32m4sw_180a_tt0p9v25c.lib\
/project/chriskim01/chipfab/rare23/SRAM/ts1n28hpcpsvtb2048x32m4sw_180a/NLDM/ts1n28hpcpsvtb2048x32m4sw_180a_tt0p9v25c.lib\
/project/chriskim01/chipfab/rare23/LIBERATE/lib/rare_riscv_test_w_mem.lib\
}

set_db lef_library {/project/chriskim07/PDKs/TSMC28nm/28HPC_tools/APR_Tech/Cadence/tn28clpr002e1_1_9_1a/PRTF_EDI_28nm_Cad_V19_1a/PR_tech_VRP_140nm/Cadence/LefHeader/HVH/tsmcn28_9lm6X1Z1URDL.tlef\
/project/chriskim07/PDKs/TSMC28nm/iolib/tphn28hpcpgv18_170d/TSMCHOME/digital/Back_End/lef/tphn28hpcpgv18_110a/mt_2/9lm/lef/tphn28hpcpgv18_9lm.lef\
/project/chriskim07/PDKs/TSMC28nm/iolib/tphn28hpcpgv18_170d/TSMCHOME/digital/Back_End/lef/tphn28hpcpgv18_110a/mt_2/9lm/lef/tphn28hpcpgv18_9lm.lef\
/project/chriskim07/PDKs/TSMC28nm/sclib/TSMCHOME/digital/Back_End/lef/tcbn28hpcplusbwp30p140_110a/lef/tcbn28hpcplusbwp30p140.lef\
/project/chriskim07/PDKs/TSMC28nm/sclib/TSMCHOME/digital/Back_End/lef/tcbn28hpcplusbwp30p140lvt_110a/lef/tcbn28hpcplusbwp30p140lvt.lef\
/project/chriskim01/chipfab/rare23/SRAM/ts1n28hpcpsvtb1024x32m4sw_180a/LEF/ts1n28hpcpsvtb1024x32m4sw_180a.lef\
/project/chriskim01/chipfab/rare23/SRAM/ts1n28hpcpsvtb2048x32m4sw_180a/LEF/ts1n28hpcpsvtb2048x32m4sw_180a.lef\
/project/chriskim01/chipfab/rare23/Innovus/fullchip/core/riscv_innovus_run/RESULTS/rare_riscv_test_w_mem.lef\
}

read_hdl -sv {\
/project/chriskim01/chipfab/rare23/Genus/fullchip/FULLCHIP/FULLCHIP.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/io/io_conn.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/RARECHIP.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/axi/rare_heater_control_s_axi.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/axi/buffered_rare_heater_control_s_axi.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/axi/skid_buffer.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/axi/sync_fifo.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/ddls/ddls_decoder.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/ddls/ddls_delayed_resetb.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/ddls/ddls.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/top_RARE_phy.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/rare_sram_mux.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/riscv_clk_control.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/fullchip_out_mux.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/rare_clk_mux.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/riscv_stop_ctrl.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/vco/VCO_full.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/vco/ROSC101_SEL_INV.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/vco/buff_block_vco.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/vco/freq_div_12b.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/vco/freq_div_3b.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/vco/signal_control_vco.v\
/project/chriskim01/chipfab/rare23/Innovus/fullchip/core/dco/DCO_TOP_GATE.v\
}

set_db information_level 5
set_db hdl_error_on_latch true
set_db hdl_latch_keep_feedback true
set_db hdl_error_on_latch false

elaborate $TOPDESIGN
current_design $TOPDESIGN
set_dont_touch {*io_conn* *DCO_TOP* *ROSC101_SEL_INV* *buff_block_vco*}
set_dont_use *LVT
read_sdc run_fullchip.sdc

syn_generic
syn_map
syn_opt -incr


report_area > SYN/area.rpt
report_timing -path_type full > SYN/timing.rpt
write_sdf > SYN/$TOPDESIGN.syn.sdf

remove_cdn_loop_breaker
write_hdl -pg > SYN/$TOPDESIGN.pg.syn.vg
write_hdl > SYN/$TOPDESIGN.syn.vg
write_design -innovus -base_name "./SYN/Innovus/FULLCHIP"

