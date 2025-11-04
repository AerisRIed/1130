###############################################################################
# These confidential and proprietary static timing constraints for a Hardware
# component may be used only as authorized by a licensing agreement from
# Cadence Design Systems, Inc. In the event of publication, the following
# notice is applicable:
#
#       (C) COPYRIGHT 2014 Cadence Design Systems, Inc.
#           ALL RIGHTS RESERVED
#
# The entire notice above must be reproduced on all authorized copies of
# this code.
###############################################################################
#
# Filename  : cdrlf_wrapper_ll.func.tcl
# Version   : $Revision$
# Date/Time : $Date$
#
# Author      : John Paul Saavedra
# Modified by : 
# Abstract    : Functional timing constraints for cdrlf_ll_wrapper.
#
###############################################################################
# Change Log
# $Log$
#
###############################################################################

if { ![info exists ::timeMode] } {
    puts "INFO: setting ::timeMode to ideal"
    set ::timeMode ideal
}

if { ![info exists load_syn_sdc] } {
   puts "INFO: setting load_syn_sdc = 0"
   set load_syn_sdc 0
}

if { ![info exists ::DRIVING_CELL] } {
   set ::DRIVING_CELL [get_lib_cells BUFFMZD4BWP210H6P51CNODSVT]
   set ::DRIVING_PIN Z
   puts "INFO: setting DRIVING_CELL = [get_property $::DRIVING_CELL name]"
}


current_design cdrlf_ll_wrapper

#######################################
# set_case_analysis
#######################################

set_case_analysis 0 [get_ports { rxda_cdrlf_scanmode }]
set_case_analysis 0 [get_ports { rxda_cdrlf_scanen }]
set_case_analysis 0 [get_ports { rxda_cdrlf_scanen_cg }]

###############################################################################
# Clock period, waveform, and uncertainty variable settings.
###############################################################################
set BTI_scalar            0.955

#add 
if { [info exists load_syn_sdc] && $load_syn_sdc == "0" } {`
   set TOOL_scalar           1
} else {
   set TOOL_scalar           0.700
}
set ALL_scalar [expr $TOOL_scalar * $BTI_scalar]


#######################################
# Clock definitions
#######################################
#set CLOCK_PERIOD          0.372; # 2.6875GHz
#set CLOCK_PERIOD          0.368; # 2.717GHz

#set CLOCK_PERIOD          0.307; # 3.251625   add 1/64  for pi accurance 3.2016 GHz,update in U4 Timberwolf
set CLOCK_PERIOD          [expr $ALL_scalar * 0.307];
# 3.251625   add 1/64  for pi accurancy

#set CLOCK_PERIOD          0.3937; 2.54G for tmp use

set CLOCK_HALF_PERIOD     [expr { ${CLOCK_PERIOD} / 2.0 }]
set CLOCK_ONETHIRD_PERIOD [expr { ${CLOCK_PERIOD} / 3.0 }]
set CLOCK_TWOTHIRD_PERIOD [expr { ${CLOCK_PERIOD} / 3.0 * 2.0 }]

create_clock -name IO_ASYNC \
             -period 13.00 \
             -waveform { 0.00 6.50 } 

# Main clock running at 2.6667 GHz
create_clock -name clock \
    -period ${CLOCK_PERIOD} \
    -waveform [list 0 ${CLOCK_HALF_PERIOD}] \
    [get_ports clock]

create_clock -add -name c2q_clock \
    -period ${CLOCK_PERIOD} \
    -waveform [list 0 ${CLOCK_HALF_PERIOD}] \
    [get_ports clock]


#######################################
# Clock Exclusions
#######################################
set_clock_groups -name grp0 -asynchronous -group [get_clocks IO_ASYNC]
set_clock_groups -name grp_check -physically_exclusive -group [get_clocks c2q_clock]

#######################################
# Clock Uncertainty
#######################################
set_clock_uncertainty 0.000 -setup [get_clocks c2q_clock]; # Designed for same edge checks
set_clock_uncertainty 0.000 -hold  [get_clocks *]

# SER-22125 17ps c2c jitter
set c2c_uncertainty 0.017
# SER-21798 - From March 31st 2020 caracterization of schematic data, between 170aF to 6fF
## Updated from 3.35 to 3.41 PDK 1.2
set duty_cycle_distorsion 3.41
set dcd_uncertainty [expr { ${duty_cycle_distorsion} / 100.0 * ${CLOCK_PERIOD} + ${c2c_uncertainty} }]
set_clock_uncertainty ${c2c_uncertainty} -setup -fall_from [get_clocks clock] -fall_to [get_clocks clock]
set_clock_uncertainty ${c2c_uncertainty} -setup -rise_from [get_clocks clock] -rise_to [get_clocks clock]
set_clock_uncertainty ${dcd_uncertainty} -setup -rise_from [get_clocks clock] -fall_to [get_clocks clock]
set_clock_uncertainty ${dcd_uncertainty} -setup -fall_from [get_clocks clock] -rise_to [get_clocks clock]

###############################################################################
# Transitions
###############################################################################
if { [llength [info proc ::tech::set_transitions]] } {
   ::tech::set_transitions
} else {
   set_max_transition 0.100 [current_design]
   set_max_transition 0.100 [all_inputs]
   set_max_transition 0.100 [all_outputs]
}
set_clock_transition  0.050 [all_clocks]


###############################################################################
# Driving cell and loads
###############################################################################
set_driving_cell -lib_cell $::DRIVING_CELL -pin $::DRIVING_PIN [remove_from_collection [all_inputs] [get_ports {phase_l* clock}]]
set_load 0.025 [all_outputs] 

#######################################
# I/O timing
#######################################
if { [info exists ::timeMode] && $::timeMode == "prop" } {
   set clk_latency  0.167
} else {
   set clk_latency  0.0
}
set clk_indly  [expr {0.025 + $clk_latency}]
set clk_outdly [expr {0.150 - $clk_latency}]

# Input delays
set_input_delay 0.00 -max -clock [get_clocks { IO_ASYNC }] [get_ports { rxda_cdrlf_clk_gate_en }]
set_input_delay 0.00 -max -clock [get_clocks { IO_ASYNC }] [get_ports { rxda_cdrlf_disable_* }]
set_input_delay 0.00 -max -clock [get_clocks { IO_ASYNC }] [get_ports { rxda_cdrlf_pi_ovrd_* }]
set_input_delay 0.00 -max -clock [get_clocks { IO_ASYNC }] [get_ports { rxda_cdrlf_reset_n }]
set_input_delay 0.00 -max -clock [get_clocks { IO_ASYNC }] [get_ports { rxda_cdrlf_reset_hold }]
set_input_delay 0.00 -max -clock [get_clocks { IO_ASYNC }] [get_ports { rxda_cdrlf_update_rate_* }]
set_input_delay 0.00 -max -clock [get_clocks { IO_ASYNC }] [get_ports { rxda_cdrlf_fphl_start }]
set_input_delay 0.00 -max -clock [get_clocks { IO_ASYNC }] [get_ports { rxda_cdrlf_fphl_timer_* }]
set_input_delay 0.00 -max -clock [get_clocks { IO_ASYNC }] [get_ports { rxda_cdrlf_int_threshold_2ol[*] }]
set_input_delay 0.00 -max -clock [get_clocks { IO_ASYNC }] [get_ports { rxda_eye_surf_pi_down_req }]
set_input_delay 0.00 -max -clock [get_clocks { IO_ASYNC }] [get_ports { rxda_eye_surf_pi_up_req }]
set_input_delay 0.00 -max -clock [get_clocks { IO_ASYNC }] [get_ports { rxda_cdrlf_iq_offset[*]}]
set_input_delay 0.00 -max -clock [get_clocks { IO_ASYNC }] [get_ports { rxda_cdrlf_iq_offset_load_pulse}]

# SER-21798 - From March 31st 2020 caracterization of schematic data, between 170aF to 6fF
# LEAD                                 LAG         
# rt_max   rt_min   rd_max   rd_min   rt_max   rt_min   rd_max   rd_min
# 0.019    0.004    0.015    -0.003   0.017    0.004    0.015    -0.003
#set_input_delay  0.015 -max -clock [get_clocks { clock }] [get_ports { phase_lag[*] }]
#set_input_delay  0.015 -max -clock [get_clocks { clock }] [get_ports { phase_lead[*] }]
#set_input_delay -0.003 -min -clock [get_clocks { clock }] [get_ports { phase_lag[*] }]
#set_input_delay -0.003 -min -clock [get_clocks { clock }] [get_ports { phase_lead[*] }]
#set_input_transition 0.020 -max [get_ports { phase_lag[*]  }]
#set_input_transition 0.020 -max [get_ports { phase_lead[*] }]
#set_input_transition 0.011 -max [get_ports { clock }]
#set_input_transition 0.004 -min [get_ports { phase_lag[*]  }]
#set_input_transition 0.004 -min [get_ports { phase_lead[*] }]
#set_input_transition 0.004 -min [get_ports { clock }]

##### UPDATE PDK 1.2
# LEAD                                     LAG         
#slew_max  slew_min  delay_max  delay_min  slew_max  slew_min  delay_max  delay_min 
#0.0205    0.0027    0.0173      -0.0018   0.0199    0.0026    0.0155     -0.0036   
set_input_delay  0.016 -max -clock [get_clocks { clock }] [get_ports { phase_lag[*] }]
set_input_delay  0.017 -max -clock [get_clocks { clock }] [get_ports { phase_lead[*] }]
set_input_delay -0.004 -min -clock [get_clocks { clock }] [get_ports { phase_lag[*] }]
set_input_delay -0.002 -min -clock [get_clocks { clock }] [get_ports { phase_lead[*] }]
set_input_transition 0.020 -max [get_ports { phase_lag[*]  }]
set_input_transition 0.021 -max [get_ports { phase_lead[*] }]
set_input_transition 0.010 -max [get_ports { clock }]
set_input_transition 0.002 -min [get_ports { phase_lag[*]  }]
set_input_transition 0.002 -min [get_ports { phase_lead[*] }]
set_input_transition 0.002 -min [get_ports { clock }]

# Output delays
#set_output_delay 0.00 -max -clock [get_clocks { clock }] [get_ports { rxda_cdrlf_fphl_locked }]
#set_output_delay 0.00 -max -clock [get_clocks { clock }] [get_ports { rxda_cdrlf_int_max_2ol }]
#set_output_delay 0.00 -max -clock [get_clocks { clock }] [get_ports { rxda_eye_surf_pi_ack }]
#set_output_delay 0.00 -max -clock [get_clocks { clock }] [get_ports { rxda_cdrlf_eye_plot_pi_val[*] }]

# SER-21939 Constraining to attempt under half a cycle of clock 2 q
set_output_delay $CLOCK_HALF_PERIOD -max -clock [get_clocks { c2q_clock }] [get_ports {i_pi_ctrl[*] }]
set_output_delay $CLOCK_HALF_PERIOD -max -clock [get_clocks { c2q_clock }] [get_ports {q_pi_ctrl[*] }]
set_output_delay $clk_outdly -max -clock [get_clocks { clock }] [get_ports { e_pi_ctrl[*] }]

#######################################
# Exceptions
#######################################
# SER-21939 c2q_clock is only used to constrain clock2q of the cdrlf
#set_false_path -from [get_clocks { c2q_clock }] -to [get_pins -of_objects [remove_from_collection [all_registers] [get_cells {u_cdrlf_pi_sreg_if_iq/pi_ctrl_shift_reg_reg[*]}]] -filter {is_clock == true}]
set_false_path -from [get_clocks { c2q_clock }] -to [get_pins -of_objects [remove_from_collection [all_registers] [get_cells {u_cdrlf_pi_sreg_if_i/pi_ctrl_shift_reg*}]] -filter {is_clock == true}]
set_false_path -from [get_clocks { c2q_clock }] -to [get_pins -of_objects [remove_from_collection [all_registers] [get_cells {u_cdrlf_pi_sreg_if_q/pi_ctrl_shift_reg*}]] -filter {is_clock == true}]


