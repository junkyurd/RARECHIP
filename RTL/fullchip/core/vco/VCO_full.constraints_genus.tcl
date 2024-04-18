##############################################
##  Defining Clock Period 
##  Numbers need to be updated by hardening owner based on actual frequency
##############################################
# All times are in ns

set LOAD_period          10
# set test_clk speed to 500 Mhz
##############################################



##############################################
##  Defining Clocks
##############################################
create_clock -name LOAD          -period $LOAD_period          [get_ports LOAD]

##############################################


##############################################
##  Defining I/O budgeting
##############################################



set input_data_port_list  [remove_from_collection [get_ports * -filter "direction==in"]  [get_ports [list LOAD]]]
set_input_delay  -clock VCO_MUX -max [expr 0.65 * $VCO_MUX_period] $input_data_port_list


##############################################
##############################################
##  Defining false path between clocks
##############################################
# set_false_path -from [get_clocks VCO_MUX] -to [get_clocks SCANIN_CLK]
# set_false_path -from [get_clocks VCO_MUX] -to [get_clocks SCANOUT_CLK]
# set_false_path -from [get_clocks SCANIN_CLK]    -to [get_clocks SCANOUT_CLK]
##############################################



##############################################
##  Defining Input transition on Clocks/Data
##############################################

set block_input_transition_min       0.010
set clock_input_transition_min       0.005

set block_input_transition_max      0.100
set clock_input_transition_max      0.050

## Input Transition With Driver Load Modeling

##############################################
##  Defining Output Load on data ports
##############################################

set block_output_load_min            0.0
set block_output_load_max            0.02

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

set_dont_touch [get_cells RO/*] true

set_dont_touch [get_cells  buff_block_vco/* ] true

