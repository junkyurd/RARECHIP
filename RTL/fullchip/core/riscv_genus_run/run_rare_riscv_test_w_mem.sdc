set sdc_version 2.0
set_units -time ns -capacitance pF

# 1GHZ
set clock_period 1
# 125 MHz
set stream_clock_period 8
# 500 MHz
set ac_stress_clock_period 2.0
# 100 kHz
set pwm_clock_period 10000

create_clock \
    -name clk \
    -period $clock_period \
    [get_ports core_clk]

create_clock \
    -name stream_clk \
    -period $stream_clock_period \
    [get_ports stream_clk]

#create_generated_clock -divide_by 2 -source [get_clocks clk] -name clk_by2 [get_registers *clk_dco_x2]
#create_generated_clock -divide_by 4 -name clk_by4 -source [get_ports core_clk] [get_registers *clk_dco_x4]
#create_generated_clock -divide_by 8 -name clk_by8 -source [get_ports core_clk] [get_registers *clk_dco_x8]
#create_generated_clock -divide_by 16 -name clk_by16 -source [get_ports core_clk] [get_registers *clk_dco_x16]
#create_generated_clock -divide_by 32 -name clk_by32 -source [get_ports core_clk] [get_registers *clk_dco_x32]
#create_generated_clock -divide_by 64 -name clk_by64 -source [get_ports core_clk] [get_registers *clk_dco_x64]
#create_generated_clock -divide_by 128 -name clk_by128 -source [get_ports core_clk] [get_registers *clk_dco_x128]
#create_generated_clock -divide_by 256 -name clk_by256 -source [get_ports core_clk] [get_registers *clk_dco_x256]
#create_generated_clock -divide_by 512 -name clk_by512 -source [get_ports core_clk] [get_registers *clk_dco_x512]
#create_generated_clock -divide_by 1024 -name clk_by1024 -source [get_ports core_clk] [get_registers *clk_dco_x1024]

#create_generated_clock -name clk_gated -divide_by 1 -source [get_ports core_clk] [get_pins rare_riscv_test_inst/cv32e40p_top_inst/core_i/sleep_unit_i/core_clock_gate_i/clk_en_inst/clk_out]



set_clock_groups -logically_exclusive -group [get_clocks clk] -group [get_clocks stream_clk]
#set_clock_groups -logically_exclusive -group [get_clocks stream_clk] -group [get_clocks clk_gated]


##############################################
##  Adding Uncertainty
##############################################
set_clock_uncertainty -setup 0.100 [get_clocks {clk}]
set_clock_uncertainty -hold 0.100 [get_clocks {clk}]

set_clock_uncertainty -setup 0.100 [get_clocks {stream_clk}]
set_clock_uncertainty -hold 0.200 [get_clocks {stream_clk}]
##############################################
##  Defining I/O ports
##############################################
set ddls_output_ports [list \
    *ddls\
    mem_scan_out*\
]

set early_input_ports [list \
    clk_out_riscv_en\
	core_resetb*\
]

set stream_input_ports [list \
	boot_addr_i*\
    mtvec_addr_i*\
	fetch_enable_i*\
    stream_addr_instr*\
    stream_data_in_instr*\
    stream_we_instr*\
    stream_en_instr*\
    stream_addr_data*\
    stream_data_in_data*\
    stream_we_data*\
    stream_en_data*\
]

set stream_output_ports [list \
    stream_data_out_instr*\
    stream_data_out_data*\
]

set odometer_input_ports [list \
    ac_stress_clk*\
    odometer_sel*\
    odometer_enable*\
    stress*\
    ac_dc*\
    sel_inv*\
    sel_nand*\
    sel_nor*\
    odometer_meas_trig*\
    odometer_load*\
]

set odometer_output_ports [list \
    bit_count*\
]

set debug_output_ports [list \
    riscv_ready_out*\
    riscv_debug_out*\
]

set heater_input_ports [list \
    heater_enable*\
    temp_sensor_decode*\
]

set heater_output_ports [list \
    sense_hi\
    sense_lo\
    source_hi\
    source_lo\
]

set all_other_input_ports [remove_from_collection [all_inputs] [get_ports [list $early_input_ports $stream_input_ports $odometer_input_ports]]]

set_false_path -from [get_clocks {stream_clk}] -through *rare_riscv_test_inst/cv32e40p_top_inst*

#set_false_path -from [get_pins rare_riscv_test_inst/cv32e40p_top_inst/core_i/sleep_unit_i/core_clock_gate_i/clk_en_inst/clk_en] [get_pins rare_riscv_test_inst/cv32e40p_top_inst/core_i/sleep_unit_i/core_clock_gate_i/clk_en_inst/clk_in]
#set_false_path -from [get_clocks {stream_clk}] -to [get_clocks {clk}]
#set_false_path -from [get_clocks {clk}] -to [get_clocks {stream_clk}]
#set_false_path -from [get_ports stream*] -to [get_clocks {clk}]
#set_false_path -from [get_ports heater_enable*] -to [get_clocks {clk}]
#set_false_path -from [get_ports temp_sensor_decode*] -to [get_clocks {clk}]
#set_false_path -from [get_ports {sense* source_hi source_lo}] -to [get_clocks {clk}]
#set_false_path -from [get_ports {odometer_sel* odometer_enable odometer_resetb stress ac_dc sel_inv sel_nand sel_nor odometer_meas_trig odometer_load}] -to [get_clocks {clk}]


#set_false_path -from stream_resetb  -to [get_clocks *]
#set_false_path -from core_resetb -to [get_clocks *]

set_false_path -from stream_resetb -to [all_registers]

##############################################
##  Defining I/O budgeting
##############################################


set_input_delay -clock clk 0.5 [get_ports [list $early_input_ports]]
#set_input_delay -clock clk -min 0.1 [get_ports [list $early_input_ports]]
set_input_delay -clock stream_clk 0.5 [get_ports [list $stream_input_ports]]
#set_input_delay -clock stream_clk -min 0.1 [get_ports [list $stream_input_ports]]
set_input_delay -clock stream_clk 0.5 [get_ports [list $odometer_input_ports]]
#set_input_delay -clock stream_clk -min 0.1 [get_ports [list $odometer_input_ports]]
set_input_delay -clock stream_clk 0.5 [get_ports [list $heater_input_ports]]
#set_input_delay -clock stream_clk -min 0.1 [get_ports [list $heater_input_ports]]

set_input_delay -clock stream_clk 0.5 [get_ports [list $all_other_input_ports]]
#set_input_delay -clock stream_clk -min 0.1 [get_ports [list $all_other_input_ports]]

set_output_delay -clock clk 0.5 [get_ports [list $ddls_output_ports]]
set_output_delay -clock clk 0.5 [get_ports [list $debug_output_ports]]

set_output_delay -clock stream_clk 0.5 [get_ports [list $stream_output_ports]]
set_output_delay -clock stream_clk 0.5 [get_ports [list $odometer_output_ports]]

##############################################
##  Defining Output Load on data ports
##############################################

set block_output_load_min            0.005
set block_output_load_max            0.010

set_load -min $block_output_load_min [all_outputs]
set_load -max $block_output_load_max [all_outputs]

set_load 0.01 [get_nets *rare_riscv_test_inst/heater_enable*]
set_load 0.01 [get_nets *rare_riscv_test_inst/temp_sensor_decode*]
set_load 0.01 [get_nets *rare_riscv_test_inst/sense_hi*]
set_load 0.01 [get_nets *rare_riscv_test_inst/sense_lo*]

set_load 0.1 [get_nets *rare_riscv_test_inst/odometer_resetb*]
set_load 0.1 [get_nets *rare_riscv_test_inst/ac_stress_clk*]
set_load 0.01 [get_nets *rare_riscv_test_inst/stress*]
set_load 0.01 [get_nets *rare_riscv_test_inst/ac_dc*]
set_load 0.01 [get_nets *rare_riscv_test_inst/sel_inv*]
set_load 0.01 [get_nets *rare_riscv_test_inst/sel_nand*]
set_load 0.01 [get_nets *rare_riscv_test_inst/sel_nor*]
set_load 0.1 [get_nets *rare_riscv_test_inst/odometer_meas_trig*]
set_load 0.1 [get_nets *rare_riscv_test_inst/odometer_load*]

#set_load 0.1 [get_nets *rare_riscv_test_inst/odometer_full_*/RESETB*]
#set_load 0.1 [get_nets *rare_riscv_test_inst/odometer_full_*/AC_STRESS_CLK*]
#set_load 0.1 [get_nets *rare_riscv_test_inst/odometer_full_*/START*]
#set_load 0.1 [get_nets *rare_riscv_test_inst/odometer_full_*/AC_DC*]
#set_load 0.1 [get_nets *rare_riscv_test_inst/odometer_full_*/SEL_INV*]
#set_load 0.1 [get_nets *rare_riscv_test_inst/odometer_full_*/SEL_NAND*]
#set_load 0.1 [get_nets *rare_riscv_test_inst/odometer_full_*/SEL_NOR*]
#set_load 0.1 [get_nets *rare_riscv_test_inst/odometer_full_*/MEAS_TRIG*]
#set_load 0.1 [get_nets *rare_riscv_test_inst/odometer_full_*/LOAD*]


##############################################
##  Defining max trans/cap
##############################################

set fo4  0.01

set data_transition_max             [expr 6 * $fo4]
set clock_transition_max            [expr 6 * $fo4]

set data_capacitance_max            0.05
set clock_capacitance_max           0.1


# Max Capacitance/Transition on Data Network
set_max_transition  $clock_transition_max [get_clocks *] -clock_path
set_max_capacitance $clock_capacitance_max [get_clock *] -clock_path
#set_max_transition  $clock_transition_max [get_clocks *] [current_design]

set_max_transition $data_transition_max [get_ports [list\
    heater_enable_dut*\
	temp_sensor_decode_dut*\
	sense_hi*\
	sense_lo*\
	odometer_sel*\
	odometer_enable*\
	ac_stress_clk*\
	odometer_resetb*\
	stress*\
	ac_dc*\
	sel_inv*\
	sel_nand*\
	sel_nor*\
	odometer_meas_trig*\
	odometer_load*\
]]


set_max_capacitance $data_capacitance_max [get_ports [list\
    heater_enable_dut*\
	temp_sensor_decode_dut*\
	sense_hi*\
	sense_lo*\
	odometer_sel*\
	odometer_enable*\
	ac_stress_clk*\
	odometer_resetb*\
	stress*\
	ac_dc*\
	sel_inv*\
	sel_nand*\
	sel_nor*\
	odometer_meas_trig*\
	odometer_load*\
]]


# Max Capacitance/Transition on Clock Network
#set_max_transition  $clock_transition_max  [get_clocks *] -clock_path
#set_max_capacitance $clock_capacitance_max [get_clocks *] -clock_path

