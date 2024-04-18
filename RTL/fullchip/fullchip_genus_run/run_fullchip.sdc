set sdc_version 2.0
set_units -time ns -capacitance pF

# 1.1GHz
set clock_period 0.95
# 125 MHz
set stream_clock_period 8
# 100 kHz
set pwm_clock_period 10000
# 500 MHz
set ac_stress_clock_period 2

##############################################
##  Defining Clocks - External
##############################################
create_clock \
    -name stream_clk \
    -period $stream_clock_period \
    [get_ports ACLK_IO]

#create_clock \
    -name pwm_clk_a \
    -period $pwm_clock_period \
    [get_ports HEATER_PWM_A_IO]

#create_clock \
    -name pwm_clk_b \
    -period $pwm_clock_period \
    [get_ports HEATER_PWM_B_IO]

##############################################
##  Defining Clocks - Internal
##############################################
create_clock \
    -name core_clk \
    -period $clock_period \
    [get_pins rarechip_inst/top_RARE_inst/dco_top_inst/CLKOUT]

##############################################
##  Adding Uncertainty
##############################################
set_clock_uncertainty -setup 0.1 [get_clocks {core_clk}]
set_clock_uncertainty -hold 0.1 [get_clocks {core_clk}]

set_clock_uncertainty -setup 0.1 [get_clocks {stream_clk}]
set_clock_uncertainty -hold 0.1 [get_clocks {stream_clk}]

create_generated_clock -source [get_pins rarechip_inst/top_RARE_inst/dco_top_inst/CLKOUT] -divide_by 1 -name system_dco\
[get_pins rarechip_inst/top_RARE_inst/riscv_clk_control_inst/clk_in_dco]

create_generated_clock -source [get_ports ACLK_IO] -divide_by 1 -name system_stream\
[get_pins rarechip_inst/top_RARE_inst/riscv_clk_control_inst/clk_in_fpga]

set_clock_groups -logically_exclusive -group [get_clocks system_stream] -group [get_clocks system_dco]


#set_clock_groups -logically_exclusive -group [get_clocks core_clk] -group [get_clocks stream_clk]
set_clock_groups -asynchronous -group [get_clocks core_clk] -group [get_clocks stream_clk]

set_false_path -from [get_clocks {core_clk}] -to [get_clocks {stream_clk}]
set_false_path -from [get_clocks {stream_clk}] -to [get_clocks {core_clk}]
set_false_path -from [get_clocks {stream_clk}] -to [get_clocks {system_dco}]
set_false_path -from [get_clocks {system_dco}] -to [get_clocks {stream_clk}]

set_false_path -from [get_clocks {core_clk}] -to [get_clocks {system_stream}]
set_false_path -from [get_clocks {system_stream}] -to [get_clocks {core_clk}]

set_false_path -from ARESETB_IO -to [all_registers] 

set_false_path -from [get_clocks {stream_clk}] -to [get_ports {DCO_FREQ_OUT_IO}]

#set_false_path -fall_from [get_pins rarechip_inst/top_RARE_inst/rare_primary/core_resetb] -to [get_clocks {core_clk}]
#set_false_path -fall_from [get_pins rarechip_inst/top_RARE_inst/rare_secondary/core_resetb] -to [get_clocks {core_clk}]
#set_false_path -from [get_clocks {core_clk}] -fall_to [get_pins rarechip_inst/top_RARE_inst/rare_primary/core_resetb]
#set_false_path -from [get_clocks {core_clk}] -fall_to [get_pins rarechip_inst/top_RARE_inst/rare_secondary/core_resetb]


#set_false_path -from [get_pins rarechip_inst/top_RARE_inst/riscv_resetb] -to [get_clocks {core_clk}]

#COMMENTED
#set_false_path -from [get_clocks {stream_clk}] -to [get_pins rarechip_inst/top_RARE_inst/rare_primary/core_resetb]
#set_false_path -from [get_clocks {stream_clk}] -to [get_pins rarechip_inst/top_RARE_inst/rare_secondary/core_resetb]

set_false_path -fall_from [get_pins rarechip_inst/top_RARE_inst/rare_primary/core_resetb] -through rarechip_inst/top_RARE_inst/rare_primary/*
set_false_path -fall_from [get_pins rarechip_inst/top_RARE_inst/rare_secondary/core_resetb] -through rarechip_inst/top_RARE_inst/rare_secondary/*






##############################################
##  Defining I/O ports
##############################################
set axi_input_ports [list \
    AWRITEB_IO\
    AADDR_IO*\
    AVALID_IO\
    WDATA_IO*\
    WVALID_IO\
    RREADY_IO\
]

set axi_output_ports [list \
    WREADY_IO\
    RDATA_IO*\
    RVALID_IO*\
]

set debug_output_ports [list \
    DEBUG_OUT_IO*\
    DCO_FREQ_OUT_IO*\
]

set rare_input_nets {\
rarechip_inst/top_RARE_inst/rare_primary/core_resetb\
rarechip_inst/top_RARE_inst/rare_secondary/core_resetb\
rarechip_inst/top_RARE_inst/rare_primary/clk_out_riscv_en\
rarechip_inst/top_RARE_inst/rare_secondary/clk_out_riscv_en\
}

set rare_input_ports_primary {\
rarechip_inst/top_RARE_inst/rare_primary/stream_resetb*\
rarechip_inst/top_RARE_inst/rare_primary/stream_addr_instr*\
rarechip_inst/top_RARE_inst/rare_primary/stream_data_in_instr*\
rarechip_inst/top_RARE_inst/rare_primary/stream_we_instr*\
rarechip_inst/top_RARE_inst/rare_primary/stream_en_instr*\
rarechip_inst/top_RARE_inst/rare_primary/stream_addr_data*\
rarechip_inst/top_RARE_inst/rare_primary/stream_data_in_data*\
rarechip_inst/top_RARE_inst/rare_primary/stream_we_data*\
rarechip_inst/top_RARE_inst/rare_primary/stream_en_data*\
rarechip_inst/top_RARE_inst/rare_primary/odometer_sel*\
rarechip_inst/top_RARE_inst/rare_primary/odometer_enable*\
rarechip_inst/top_RARE_inst/rare_primary/stress*\
rarechip_inst/top_RARE_inst/rare_primary/ac_dc*\
rarechip_inst/top_RARE_inst/rare_primary/sel_inv*\
rarechip_inst/top_RARE_inst/rare_primary/sel_nand*\
rarechip_inst/top_RARE_inst/rare_primary/sel_nor*\
rarechip_inst/top_RARE_inst/rare_primary/odometer_meas_trig*\
rarechip_inst/top_RARE_inst/rare_primary/ac_dc*\
rarechip_inst/top_RARE_inst/rare_primary/heater_enable*\
rarechip_inst/top_RARE_inst/rare_primary/temp_sensor_decode*\
rarechip_inst/top_RARE_inst/rare_primary/boot_addr_i*\
rarechip_inst/top_RARE_inst/rare_primary/mtvec_addr_i*\
rarechip_inst/top_RARE_inst/rare_primary/fetch_enable_i*\
}

set rare_input_ports_secondary {\
rarechip_inst/top_RARE_inst/rare_secondary/stream_resetb*\
rarechip_inst/top_RARE_inst/rare_secondary/stream_addr_instr*\
rarechip_inst/top_RARE_inst/rare_secondary/stream_data_in_instr*\
rarechip_inst/top_RARE_inst/rare_secondary/stream_we_instr*\
rarechip_inst/top_RARE_inst/rare_secondary/stream_en_instr*\
rarechip_inst/top_RARE_inst/rare_secondary/stream_addr_data*\
rarechip_inst/top_RARE_inst/rare_secondary/stream_data_in_data*\
rarechip_inst/top_RARE_inst/rare_secondary/stream_we_data*\
rarechip_inst/top_RARE_inst/rare_secondary/stream_en_data*\
rarechip_inst/top_RARE_inst/rare_secondary/odometer_sel*\
rarechip_inst/top_RARE_inst/rare_secondary/odometer_enable*\
rarechip_inst/top_RARE_inst/rare_secondary/stress*\
rarechip_inst/top_RARE_inst/rare_secondary/ac_dc*\
rarechip_inst/top_RARE_inst/rare_secondary/sel_inv*\
rarechip_inst/top_RARE_inst/rare_secondary/sel_nand*\
rarechip_inst/top_RARE_inst/rare_secondary/sel_nor*\
rarechip_inst/top_RARE_inst/rare_secondary/odometer_meas_trig*\
rarechip_inst/top_RARE_inst/rare_secondary/ac_dc*\
rarechip_inst/top_RARE_inst/rare_secondary/heater_enable*\
rarechip_inst/top_RARE_inst/rare_secondary/temp_sensor_decode*\
rarechip_inst/top_RARE_inst/rare_secondary/boot_addr_i*\
rarechip_inst/top_RARE_inst/rare_secondary/mtvec_addr_i*\
rarechip_inst/top_RARE_inst/rare_secondary/fetch_enable_i*\
}

set rare_output_ports {\
rarechip_inst/top_RARE_inst/rare_primary/stream_data_out_instr*\
rarechip_inst/top_RARE_inst/rare_primary/stream_data_out_data*\
rarechip_inst/top_RARE_inst/rare_primary/bit_count*\
rarechip_inst/top_RARE_inst/rare_secondary/stream_data_out_instr*\
rarechip_inst/top_RARE_inst/rare_secondary/stream_data_out_data*\
rarechip_inst/top_RARE_inst/rare_secondary/bit_count*\
}

set rare_output_ports_clk {\
rarechip_inst/top_RARE_inst/rare_primary/*ddls*\
rarechip_inst/top_RARE_inst/rare_secondary/*ddls*\
rarechip_inst/top_RARE_inst/rare_primary/*mem_scan_out*\
rarechip_inst/top_RARE_inst/rare_secondary/*mem_scan_out*\
rarechip_inst/top_RARE_inst/rare_primary/riscv_ready_out*\
rarechip_inst/top_RARE_inst/rare_primary/riscv_debug_out*\
rarechip_inst/top_RARE_inst/rare_secondary/riscv_ready_out*\
rarechip_inst/top_RARE_inst/rare_secondary/riscv_debug_out*\
rarechip_inst/top_RARE_inst/rare_primary/core_sleep_o*\
rarechip_inst/top_RARE_inst/rare_secondary/core_sleep_o*\
}

set_input_delay -clock stream_clk -max 6 [get_ports [list $axi_input_ports]]
set_input_delay -clock stream_clk -min 1 [get_ports [list $axi_input_ports]]
set_output_delay -clock stream_clk 5 [get_ports [list $axi_output_ports]]

#set_output_delay -clock clk -min 0.5 [get_pins $rare_input_nets]
#set_output_delay -clock stream_clk -min 0.5 [get_pins $rare_input_ports_primary]
#set_output_delay -clock stream_clk -min 0.5 [get_pins $rare_input_ports_secondary]


#set_input_delay -clock stream_clk 0.5 [get_pins $rare_output_ports]
#set_input_delay -clock core_clk 0.5 [get_pins $rare_output_ports_clk]

##############################################
##  Defining Output Load on data ports
##############################################

set block_output_load_min            0.005
set block_output_load_max            0.1

set_load -min $block_output_load_min [all_outputs]
set_load -max $block_output_load_max [all_outputs]
#set_load -min $block_output_load_min [get_nets $rare_input_nets]
#set_load -max $block_output_load_max [get_nets $rare_input_nets]



#set_load -min $block_output_load_min $axi_output_ports
#set_load -max $block_output_load_max $axi_output_ports
#set_load -min $block_output_load_min $debug_output_ports
#set_load -max $block_output_load_max $debug_output_ports


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
set_max_capacitance $clock_capacitance_max [get_clocks *] -clock_path

set_max_transition  $clock_transition_max [get_ports $axi_output_ports]
set_max_capacitance $clock_capacitance_max [get_ports $axi_output_ports]
set_max_transition  $clock_transition_max [get_ports $debug_output_ports]
set_max_capacitance $clock_capacitance_max [get_ports $debug_output_ports]
set_max_transition  $clock_transition_max [get_pins $rare_input_ports_primary]
set_max_transition  $clock_transition_max [get_pins $rare_input_ports_secondary]
set_max_transition  $clock_transition_max [get_pins $rare_input_nets]


