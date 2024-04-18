##############################################
##  Defining Clock Period 
##  Numbers need to be updated by hardening owner based on actual frequency
##############################################
# All times are in ns
set timing_cap_unit 1pf
set timing_time_unit 1ns

set AC_STRESS_CLK_period  2.0
set MEAS_TRIG_period     10.0
set LOAD_period          10.0
set DETECT_period        1.6
# set test_clk speed to 500 Mhz	
##############################################



##############################################
##  Defining Clocks
##############################################

create_clock -name AC_STRESS_CLK -period $AC_STRESS_CLK_period [get_ports AC_STRESS_CLK]
create_clock -name LOAD          -period $LOAD_period          [get_ports LOAD]
create_clock -name MEAS_TRIG     -period $LOAD_period          [get_ports MEAS_TRIG]
create_clock [get_pins odometer_top_odometer_meas_detect_inst/DETECT]  -name DETECT -period $DETECT_period

##############################################
set_clock_groups -logically_exclusive -group [get_clocks LOAD] -group [get_clocks AC_STRESS_CLK]
set_clock_groups -logically_exclusive -group [get_clocks MEAS_TRIG] -group [get_clocks LOAD]
set_clock_groups -asynchronous -group [get_clocks MEAS_TRIG] -group [get_clocks AC_STRESS_CLK]
set_clock_groups -logically_exclusive -group [get_clocks DETECT] -group [get_clocks LOAD]



##############################################
##  Defining I/O budgeting
##############################################



set input_data_port_list  [remove_from_collection [get_ports * -filter "direction==in"]  [get_ports [list AC_STRESS_CLK MEAS_TRIG LOAD]]]
set_input_delay  -clock AC_STRESS_CLK -max 0.5  $input_data_port_list

#set_output_delay -clock AC_STRESS_CLK -max 0.5 [get_ports [list RESETB_INT LOAD_INT MEAS_TRIG_INT]]

#set_output_delay -clock SCANIN_CLK    -max [expr 0.1 * $SCANIN_CLK_period]    [get_ports [list SCANIN_CLK_INT ]]
#set_output_delay -clock AC_STRESS_CLK -max [expr 0.1 * $AC_STRESS_CLK_period] [get_ports [list AC_STRESS_CLK_INT ]]
#set_output_delay -clock SCANOUT_CLK   -max [expr 0.1 * $SCANOUT_CLK_period]   [get_ports [list SCANOUT_CLK_INT ]]

##############################################
##############################################
##  Defining false path between clocks
##############################################
# set_false_path -from [get_clocks AC_STRESS_CLK] -to [get_clocks SCANIN_CLK]
# set_false_path -from [get_clocks AC_STRESS_CLK] -to [get_clocks SCANOUT_CLK]
# set_false_path -from [get_clocks SCANIN_CLK]    -to [get_clocks SCANOUT_CLK]
##############################################



##############################################
##  Defining Input transition on Clocks/Data
##############################################

set block_input_transition_min       0.001
set clock_input_transition_min       0.001

set block_input_transition_max      0.06
set clock_input_transition_max      0.06

## Input Transition With Driver Load Modeling
set_input_transition $block_input_transition_min -min [remove_from_collection [all_inputs] [get_ports [list AC_STRESS_CLK]]]
set_input_transition $clock_input_transition_min -min                                      [get_ports [list AC_STRESS_CLK]]

set_input_transition $block_input_transition_max -max [remove_from_collection [all_inputs] [get_ports [list AC_STRESS_CLK]]]
set_input_transition $clock_input_transition_max -max                                      [get_ports [list AC_STRESS_CLK]]

##############################################
##  Defining Output Load on data ports
##############################################

set block_output_load_min            0.005
set block_output_load_max            0.01

set_load -pin_load -min $block_output_load_min [all_outputs]
set_load -pin_load -max $block_output_load_max [all_outputs]

##############################################
##  Defining max trans/cap
##############################################

set fo4  0.01

set data_transition_max             [expr 6 * $fo4]
set clock_transition_max            [expr 6 * $fo4]

set data_capacitance_max            0.1
set clock_capacitance_max           0.1


# Max Capacitance/Transition on Data Network
set_max_transition  $data_transition_max    [current_design]
set_max_capacitance $data_capacitance_max   [current_design]

# Max Capacitance/Transition on Clock Network
set_max_transition  $clock_transition_max  [get_clocks *] -clock_path
set_max_capacitance $clock_capacitance_max [get_clocks *] -clock_path

##############################################
##  Defining Exceptions
##############################################

# set_multicycle_path 1 -hold  -from [get_ports LOAD]

#set_dont_touch [get_cells rosc_stress_ROSC_INV99/*] true
#set_dont_touch [get_cells rosc_stress_ROSC_INV101/*] true
#set_dont_touch [get_cells rosc_stress_ROSC_INV97/*] true
set_dont_touch [get_cells rosc_ref/ROSC_INV99/*] true
set_dont_touch [get_cells rosc_ref/ROSC_INV101/*] true
set_dont_touch [get_cells rosc_ref/ROSC_INV97/*] true

#set_dont_touch [get_cells  */buff_block_ver4/buff_*] true
#set_dont_touch [get_cells  */buff_block_ver4/*.buff_block*.buf_del* ] true

#set OSC_period_INV99_ref  0.7
#set OSC_period_INV99_stress  0.7
#set OSC_period_INV97_ref  0.7
#set OSC_period_INV97_stress  0.7
#set OSC_period_INV101_ref  0.7
#set OSC_period_INV101_stress  0.7


set OSC_period_inv  0.8

# create_clock -name OUT_INV99_stress  -period $OSC_period2 [get_pins rosc_stress_ROSC_INV99/genblk1[100].INV1/ZN ]
# create_clock -name OUT_INV101_stress -period $OSC_period4 [get_pins rosc_stress_ROSC_INV101/genblk1[100].NAND/ZN ]
# create_clock -name OUT_INV97_stress  -period $OSC_period6 [get_pins rosc_stress_ROSC_INV97/genblk1[100].NOR/ZN ]
# create_clock -name OUT_INV99_ref     -period $OSC_period1 [get_pins rosc_ref_ROSC_INV99/RO[102].INV1/ZN ]
# create_clock -name OUT_INV97_ref     -period $OSC_period3 [get_pins rosc_ref_ROSC_INV101/genblk1[102].NAND/ZN ]
# create_clock -name OUT_INV101_ref    -period $OSC_period5 [get_pins rosc_ref_ROSC_INV97/genblk1[102].NOR/ZN] 


create_clock -name  OUT_INV_ref -period $OSC_period_inv [get_pins rosc_ref/OUT]
create_clock -name  OUT_INV_stress -period $OSC_period_inv [get_pins rosc_stress/OUT]

set_false_path -from [get_ports RESETB ]




set_clock_groups -logically_exclusive -group [get_clocks LOAD] -group [get_clocks OUT_INV_ref]
set_clock_groups -logically_exclusive -group [get_clocks LOAD] -group [get_clocks OUT_INV_stress]


#set_clock_groups -logically_exclusive -group [get_clocks OUT_INV97_stress] -group [get_clocks OUT_INV101_stress]
#set_clock_groups -logically_exclusive -group [get_clocks OUT_INV97_ref] -group [get_clocks OUT_INV99_ref]
#set_clock_groups -asynchronous -group {OUT_INV99_stress OUT_INV101_stress OUT_INV97_stress OUT_INV99_ref OUT_INV97_ref OUT_INV101_ref}

set_clock_groups -asynchronous -group {AC_STRESS_CLK} -group [get_clocks OUT_*]
set_clock_groups -asynchronous -group {MEAS_TRIG} -group [get_clocks OUT_*]
set_clock_groups -asynchronous -group {OUT_INV_stress} -group {OUT_INV_ref}
