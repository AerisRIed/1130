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
# Filename  : hbdc_3t_enc_wrapper.stuckat_cap.sdc
# Version   : $Revision2638 $
# Date/Time : $Date2013-02-19 13:53:13 -0500 (Tue, 19 Feb 2013) $
#
# Author    : Andrew Scott
# Edited by : Andrew Scott
# Abstract  : Functional timing constraints for hbdc_3t_enc_wrapper.
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

if { ![info exists DRIVING_CELL] } {
   set DRIVING_CELL [get_lib_cells BUFFD4BWP210H6P51CNODSVT]
   puts "INFO: setting DRIVING_CELL = ${DRIVING_CELL}"
   set DRIVING_PIN Z
}

current_design hbdc_3t_enc_wrapper

#######################################
# set_case_analysis
#######################################

set_case_analysis 1 [get_ports { txda_drv_scanmode }]
#set_case_analysis 0 [get_ports { txda_drv_scanen }]

#######################################
# Clock definitions
#######################################

create_clock -name IO_ASYNC -period 13.0 -waveform { 0 6.5 } 
create_clock -name CAP_CLK  -period 10.0 -waveform { 0 2.5 } [get_ports { txda_drv_scanclk }]

#######################################
# Clock Uncertainty
#######################################
# Set hold uncertainty to 65 ps instead of 55 ps to provide extra margin.
set_clock_uncertainty 0.150 -setup -from [all_clocks] -to [all_clocks]
set_clock_uncertainty 0.065 -hold  -from [all_clocks] -to [all_clocks]

#######################################
# Clock Exclusions
#######################################
set_clock_groups -name grp_async -asynchronous -group [get_clocks { IO_ASYNC }]

###############################################################################
# Transitions
###############################################################################

set_max_transition 0.215 [current_design]
set_max_transition 0.215 [all_inputs]
set_max_transition 0.215 [all_outputs]

set_clock_transition 0.100 [all_clocks]

###############################################################################
# Driving cell and loads
###############################################################################

set_driving_cell -lib_cell $DRIVING_CELL -pin $DRIVING_PIN [all_inputs]
set_load 0.025 [all_outputs] 

#######################################
# I/O timing
#######################################

set_input_delay  0.00 -max -clock [get_clocks { IO_ASYNC }]  [get_ports { txda_drv_scanin }]
set_input_delay  6.66 -max -clock [get_clocks { CAP_CLK }]   [get_ports { txda_drv_tr_mgn *_start *_end *_zero }]
set_output_delay 0.00 -max -clock [get_clocks { IO_ASYNC }]  [get_ports { *_main *_emph txda_drv_trd2_mgn txda_drv_scanout }]

if { [info exists do_libgen] && $do_libgen } {
   set_input_delay  0.00 -min -clock [get_clocks { CAP_CLK }] [get_ports { *_start *_end *_zero *_one }]
   set_false_path -through [get_ports { *_main *_emph txda_drv_trd2_mgn txda_drv_scanout }]
}

#######################################
# Exceptions
#######################################

## Set false path to SI pins.
#set si_pin_collection [get_pins -of [all_registers] -filter { @name == SI }]
#set_false_path -from [all_clocks] -to $si_pin_collection

if { [info exists ::timeMode] && $::timeMode == "prop" } {
    reset_clock_tree_latency [all_clocks]
    set_propagated_clock     [all_clocks]
}

#set_dont_touch [get_nets { pso* }]
