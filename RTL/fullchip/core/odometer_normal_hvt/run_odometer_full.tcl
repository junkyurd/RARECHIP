#set RTL_PATH "/project/chriskim00/jkim/odometer/odometer_gf22nm/Synthesis"
#set RTL_LIST {\
#rosc_inv_only_syn.v \
#rosc_nand_only_syn.v \
#rosc_nor_only_syn.v \
#}

#set_db init_hdl_search_path $RTL_PATH


set_db library { /project/chriskim07/PDKs/TSMC28nm/iolib/tphn28hpcpgv18_170d/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tphn28hpcpgv18_170a/tphn28hpcpgv18tt0p9v1p8v25c.lib /project/chriskim07/PDKs/TSMC28nm/sclib/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn28hpcplusbwp30p140_180a/tcbn28hpcplusbwp30p140tt0p9v25c.lib /project/chriskim07/PDKs/TSMC28nm/sclib/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn28hpcplusbwp30p140hvt_180a/tcbn28hpcplusbwp30p140hvttt0p9v25c.lib}


#set_db lef_library {/project/chriskim00/itahmida/TSMC28/synthesis/backend/tsmcn28_9lm6X1R1UUTRDL.tlef /project/chriskim07/PDKs/TSMC28nm/iolib/tphn28hpcpgv18_170d/TSMCHOME/digital/Back_End/lef/tphn28hpcpgv18_110a/mt_2/9lm/lef/tphn28hpcpgv18_9lm.lef /project/chriskim07/PDKs/TSMC28nm/sclib/TSMCHOME/digital/Back_End/lef/tcbn28hpcplusbwp30p140_110a/lef/tcbn28hpcplusbwp30p140.lef}

read_hdl { ./ROSC_ALL_HVT.v 
./rosc_block_top_pwr_hvt_ref.v 
./rosc_block_top_pwr_hvt_stress.v 
./odometer_top.v 
./shift_sample_3b.v 
./edge_detector.v 
./signal_ctrl.v 
./power_enable.v 
./parallel_latch.v 
./odometer_meas_detect.v 
./odometer_full_hvt.v}

#read_hdl $RTL_LIST
set_db information_level 5
set_db hdl_error_on_latch true

elaborate
current_design odometer_full_hvt
#set_db [get_db design:ring_Osci_31 .modules *] .ungroup_ok false

set_dont_touch {ROSC10*_SEL* *pwr_control*}

read_sdc ./odometer_full.constraints_genus.tcl
#set_dont_touch {right_inverter pwr rosc_nand}
#remove_cdn_loop_breaker
syn_generic
syn_map
syn_opt
#remove_cdn_loop_breaker
report_area > area.rpt
report_timing > timing.rpt
remove_cdn_loop_breaker

#write_design -innovus -base_name "./odometer_full_ver4_syn/odometer_full_ver4_syn"
write_hdl > odometer_full_hvt.vg