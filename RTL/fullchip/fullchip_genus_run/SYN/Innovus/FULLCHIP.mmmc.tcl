#################################################################################
#
# Created by Genus(TM) Synthesis Solution 19.15-s090_1 on Thu Nov 30 17:13:05 CST 2023
#
#################################################################################

## library_sets
create_library_set -name default_emulate_libset_max \
    -timing { /project/chriskim07/PDKs/TSMC28nm/iolib/tphn28hpcpgv18_170d/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tphn28hpcpgv18_170a/tphn28hpcpgv18tt0p9v1p8v25c.lib \
              /project/chriskim07/PDKs/TSMC28nm/sclib/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn28hpcplusbwp30p140_180a/tcbn28hpcplusbwp30p140tt0p9v25c.lib \
              /project/chriskim07/PDKs/TSMC28nm/sclib/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn28hpcplusbwp30p140lvt_180a/tcbn28hpcplusbwp30p140lvttt0p8v25c.lib \
              /project/chriskim07/PDKs/TSMC28nm/sclib/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn28hpcplusbwp30p140_180a/tcbn28hpcplusbwp30p140tt0p9v0p9v25c.lib \
              /project/chriskim01/chipfab/rare23/SRAM/ts1n28hpcpsvtb1024x32m4sw_180a/NLDM/ts1n28hpcpsvtb1024x32m4sw_180a_tt0p9v25c.lib \
              /project/chriskim01/chipfab/rare23/SRAM/ts1n28hpcpsvtb2048x32m4sw_180a/NLDM/ts1n28hpcpsvtb2048x32m4sw_180a_tt0p9v25c.lib \
              /project/chriskim01/chipfab/rare23/LIBERATE/lib/rare_riscv_test_w_mem.lib }

## opcond
create_opcond -name default_emulate_opcond \
    -process 1.0 \
    -voltage 1.799999 \
    -temperature 25.0

## timing_condition
create_timing_condition -name default_emulate_timing_cond_max \
    -opcond default_emulate_opcond \
    -library_sets { default_emulate_libset_max }

## rc_corner
create_rc_corner -name default_emulate_rc_corner \
    -temperature 25.0 \
    -pre_route_res 1.0 \
    -pre_route_cap 1.0 \
    -pre_route_clock_res 0.0 \
    -pre_route_clock_cap 0.0 \
    -post_route_res {1.0 1.0 1.0} \
    -post_route_cap {1.0 1.0 1.0} \
    -post_route_cross_cap {1.0 1.0 1.0} \
    -post_route_clock_res {1.0 1.0 1.0} \
    -post_route_clock_cap {1.0 1.0 1.0}

## delay_corner
create_delay_corner -name default_emulate_delay_corner \
    -early_timing_condition { default_emulate_timing_cond_max } \
    -late_timing_condition { default_emulate_timing_cond_max } \
    -early_rc_corner default_emulate_rc_corner \
    -late_rc_corner default_emulate_rc_corner

## constraint_mode
create_constraint_mode -name default_emulate_constraint_mode \
    -sdc_files { ./SYN/Innovus/FULLCHIP.default_emulate_constraint_mode.sdc }

## analysis_view
create_analysis_view -name default_emulate_view \
    -constraint_mode default_emulate_constraint_mode \
    -delay_corner default_emulate_delay_corner

## set_analysis_view
set_analysis_view -setup { default_emulate_view } \
                  -hold { default_emulate_view }
