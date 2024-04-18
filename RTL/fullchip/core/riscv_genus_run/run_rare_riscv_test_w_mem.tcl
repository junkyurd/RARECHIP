set TOPDESIGN rare_riscv_test_w_mem
#/project/chriskim07/PDKs/TSMC28nm/iolib/tphn28hpcpgv18_170d/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tphn28hpcpgv18_170a/tphn28hpcpgv18tt0p9v1p8v25c.lib
set_db library {/project/chriskim07/PDKs/TSMC28nm/sclib/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn28hpcplusbwp30p140_180a/tcbn28hpcplusbwp30p140tt0p9v25c.lib\
/project/chriskim07/PDKs/TSMC28nm/sclib/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn28hpcplusbwp30p140_180a/tcbn28hpcplusbwp30p140tt0p9v0p9v25c.lib\
/project/chriskim01/chipfab/rare23/SRAM/ts1n28hpcpsvtb1024x32m4sw_180a/NLDM/ts1n28hpcpsvtb1024x32m4sw_180a_tt0p9v25c.lib\
/project/chriskim01/chipfab/rare23/SRAM/ts1n28hpcpsvtb2048x32m4sw_180a/NLDM/ts1n28hpcpsvtb2048x32m4sw_180a_tt0p9v25c.lib\
}

set_db lef_library {/project/chriskim07/PDKs/TSMC28nm/28HPC_tools/APR_Tech/Cadence/tn28clpr002e1_1_9_1a/PRTF_EDI_28nm_Cad_V19_1a/PR_tech_VRP_140nm/Cadence/LefHeader/HVH/tsmcn28_9lm6X1Z1URDL.tlef\
/project/chriskim07/PDKs/TSMC28nm/iolib/tphn28hpcpgv18_170d/TSMCHOME/digital/Back_End/lef/tphn28hpcpgv18_110a/mt_2/9lm/lef/tphn28hpcpgv18_9lm.lef\
/project/chriskim07/PDKs/TSMC28nm/sclib/TSMCHOME/digital/Back_End/lef/tcbn28hpcplusbwp30p140_110a/lef/tcbn28hpcplusbwp30p140.lef\
/project/chriskim01/chipfab/rare23/SRAM/ts1n28hpcpsvtb1024x32m4sw_180a/LEF/ts1n28hpcpsvtb1024x32m4sw_180a.lef\
/project/chriskim01/chipfab/rare23/SRAM/ts1n28hpcpsvtb2048x32m4sw_180a/LEF/ts1n28hpcpsvtb2048x32m4sw_180a.lef\
/project/chriskim01/chipfab/rare23/Innovus/fullchip/core/odometer_normal_rvt/odometer_full_rvt.lef\
/project/chriskim01/chipfab/rare23/Innovus/fullchip/core/odometer_normal_lvt/odometer_full_lvt.lef\
/project/chriskim01/chipfab/rare23/Innovus/fullchip/core/odometer_normal_hvt/odometer_full_hvt.lef\
/project/chriskim01/chipfab/rare23/Innovus/fullchip/core/odometer_stacked/odometer_full_stacked_rvt.lef\
/project/chriskim01/chipfab/rare23/Innovus/fullchip/core/vco/VCO_full.lef\
/project/chriskim01/chipfab/rare23/Innovus/fullchip/core/rosc_heater/rare_heater.lef\
/project/chriskim01/chipfab/rare23/Innovus/fullchip/core/temp_sensor/rare_sensor.lef\
}

#read_mmmc run_rare_riscv_test_w_mem_constraints.tcl


read_hdl -sv {\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_common_cells/include/common_cells/registers.svh\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_common_cells/include/common_cells/assertions.svh\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_common_cells/src/cf_math_pkg.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_common_cells/src/rr_arb_tree.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_common_cells/src/lzc.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/src/fpnew_pkg.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/vendor/opene906/E906_RTL_FACTORY/gen_rtl/clk/rtl/gated_clk_cell.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fdsu/rtl/pa_fdsu_ctrl.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fdsu/rtl/pa_fdsu_ff1.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fdsu/rtl/pa_fdsu_pack_single.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fdsu/rtl/pa_fdsu_prepare.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fdsu/rtl/pa_fdsu_round_single.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fdsu/rtl/pa_fdsu_special.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fdsu/rtl/pa_fdsu_srt_single.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fdsu/rtl/pa_fdsu_top.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fpu/rtl/pa_fpu_dp.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fpu/rtl/pa_fpu_frbus.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/vendor/opene906/E906_RTL_FACTORY/gen_rtl/fpu/rtl/pa_fpu_src_type.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/src/fpnew_divsqrt_th_32.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/src/fpnew_classifier.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/src/fpnew_rounding.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/src/fpnew_cast_multi.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/src/fpnew_fma_multi.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/src/fpnew_noncomp.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/src/fpnew_opgroup_fmt_slice.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/src/fpnew_opgroup_multifmt_slice.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/src/fpnew_opgroup_block.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/src/fpnew_divsqrt_multi.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/vendor/pulp_platform_fpnew/src/fpnew_top.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/include/cv32e40p_apu_core_pkg.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/include/cv32e40p_fpu_pkg.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/include/cv32e40p_pkg.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/rare_riscv_test_w_mem.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/rare_riscv_test.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/cv32e40p_top_RARE.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/cv32e40p_core_RARE.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/cv32e40p_sleep_unit_RARE.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/cv32e40p_clock_gate_RARE.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/heater_wrapper.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/temp_sensor_wrapper.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/riscv_clk_control.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/riscv_stop_ctrl.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/rare_clk_mux.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/rare_clk_riscv_and.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/rare_sram_mux.v\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_if_stage.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_cs_registers.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_register_file_ff.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_load_store_unit.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_id_stage.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_aligner.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_decoder.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_compressed_decoder.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_fifo.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_prefetch_buffer.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_hwloop_regs.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_mult.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_int_controller.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_ex_stage.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_alu_div.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_alu.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_ff_one.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_popcnt.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_apu_disp.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_controller.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_obi_interface.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_prefetch_controller.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_sleep_unit.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/rtl/cv32e40p_fp_wrapper.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/bhv/include/cv32e40p_tracer_pkg.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/cv32e40p/bhv/cv32e40p_tb_wrapper.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/cv32e40p_id_stage_RARE.sv\
/project/chriskim01/chipfab/rare23/Genus/fullchip/core/riscv/rare_core/cv32e40p_register_file_ff_RARE.sv\
}

set_db information_level 5
set_db hdl_error_on_latch true
set_db hdl_latch_keep_feedback true
set_db hdl_error_on_latch false

elaborate $TOPDESIGN
current_design $TOPDESIGN
set_dont_touch {*heater_wrapper* *temp_sensor_wrapper*}
#*rare_sram_mux* *rare_clk_riscv_and*  rare_riscv_test_inst/cv32e40p_top_inst/core_i/sleep_unit_i/core_clock_gate_i/clk_en_inst*}
read_power_intent -cpf run_rare_riscv_test_w_mem.cpf -module $TOPDESIGN

apply_power_intent

read_sdc run_rare_riscv_test_w_mem.sdc
commit_power_intent

syn_generic
syn_map
syn_opt -incr

report_area > SYN/area.rpt
report_timing -path_type full > SYN/timing.rpt

write_sdf > SYN/$TOPDESIGN.syn.sdf
write_hdl -pg > SYN/$TOPDESIGN.pg.syn.vg
write_hdl > SYN/$TOPDESIGN.syn.vg
write_design -innovus -base_name "./SYN/Innovus/rare_riscv_test_w_mem"