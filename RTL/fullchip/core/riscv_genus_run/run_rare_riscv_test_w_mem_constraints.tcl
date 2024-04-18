create_library_set -name LS1 -timing [list /project/chriskim07/PDKs/TSMC28nm/sclib/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn28hpcplusbwp30p140_180a/tcbn28hpcplusbwp30p140tt0p9v25c.lib /project/chriskim01/chipfab/rare23/SRAM/ts1n28hpcpsvtb1024x32m4swbaso_180a/NLDM/ts1n28hpcpsvtb1024x32m4swbaso_180a_tt0p9v25c.lib]

create_library_set -name LS2 -timing [list /project/chriskim07/PDKs/TSMC28nm/sclib/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn28hpcplusbwp30p140_180a/tcbn28hpcplusbwp30p140ffg0p99vm40c.lib /project/chriskim01/chipfab/rare23/SRAM/ts1n28hpcpsvtb1024x32m4swbaso_180a/NLDM/ts1n28hpcpsvtb1024x32m4swbaso_180a_ffg0p99vm40c.lib]

create_opcond -name PVT1 -process 1.0 -voltage 0.9 -temperature 25

create_opcond -name PVT2 -process 1.0 -voltage 0.99 -temperature -40


create_rc_corner -name QX -qrc_tech /project/chriskim01/chipfab/rare23/Innovus/qrc/qrcTechFile

create_timing_condition -name TC1 -library_sets LS1
create_timing_condition -name TC2 -library_sets LS2

create_delay_corner -name DC1 -timing_condition {PD_TOP@TC1 PD_DUT@TC1} -rc_corner QX
create_delay_corner -name DC2 -timing_condition {PD_TOP@TC2 PD_DUT@TC2} -rc_corner QX

create_constraint_mode -name CM1 -sdc_files run_rare_riscv_test_w_mem.sdc
create_constraint_mode -name CM2 -sdc_files run_rare_riscv_test_w_mem.sdc

create_analysis_view -name AV1 -constraint_mode CM1 -delay_corner DC1
create_analysis_view -name AV2 -constraint_mode CM2 -delay_corner DC2
set_analysis_view -setup {AV1 AV2} -hold {AV1 AV2}