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
# Filename  : cdrlf_ll_wrapper.atspeed_cap.tcl
# Version   : $Revision$
# Date/Time : $Date$
#
# Author      : John Paul Saavedra
# Modified by : 
# Abstract    : at-speed capture timing constraints for cdrlf_wrapper.
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
   set ::DRIVING_CELL [get_lib_cells BUFFD4BWP*DSVT]
   set ::DRIVING_PIN Z
   puts "INFO: setting DRIVING_CELL = [get_property $::DRIVING_CELL name]"
}


current_design cdrlf_ll_wrapper

#######################################
# set_case_analysis
#######################################

set_case_analysis 1 [get_ports { rxda_cdrlf_scanmode }]
set_case_analysis 0 [get_ports { rxda_cdrlf_scanen }]
# set_case_analysis 0 [get_ports { rxda_cdrlf_scanen_cg }]

#######################################
# Clock definitions
#######################################
set CLOCK_PERIOD          1.600
set CLOCK_HALF_PERIOD     [expr { ${CLOCK_PERIOD} / 2.0 }]
set CLOCK_ONETHIRD_PERIOD [expr { ${CLOCK_PERIOD} / 3.0 }]
set CLOCK_TWOTHIRD_PERIOD [expr { ${CLOCK_PERIOD} / 3.0 * 2.0 }]

create_clock -name IO_ASYNC \
             -period 13.00 \
             -waveform { 0.00 6.50 } 

# main scan clock running at 625MHz 
create_clock -name ACAP_CLK \
    -period ${CLOCK_PERIOD} \
    -waveform [list 0 ${CLOCK_HALF_PERIOD}] \
             [get_ports rxda_cdrlf_scanclk]

#######################################
# Clock Exclusions
#######################################
set_clock_groups -name grp0 -asynchronous -group [get_clocks IO_ASYNC]

#######################################
# Clock Uncertainty
#######################################
set_clock_uncertainty 0.250 -setup -from [all_clocks] -to [all_clocks]
set_clock_uncertainty 0.000 -hold  -from [all_clocks] -to [all_clocks]

###############################################################################
# Transitions
###############################################################################
if { [llength [info proc ::tech::set_transitions]] } {
   ::tech::set_transitions
} else {
   set_max_transition 0.100 [current_design]
   set_max_transition 0.100 [all_inputs]
   set_max_transition 0.100 [all_outputs]
   set_clock_transition  0.050 [all_clocks]
}


###############################################################################
# Driving cell and loads
###############################################################################
set_driving_cell -lib_cell $::DRIVING_CELL -pin $::DRIVING_PIN [all_inputs]
set_load 0.025 [all_outputs] 

#######################################
# I/O timing
#######################################

# Input delays
set_input_delay  0.00 -max -clock [get_clocks { IO_ASYNC }] [all_inputs -no_clocks]

# Output delays
set_output_delay 0.00 -max -clock [get_clocks { IO_ASYNC }] [all_outputs]

#######################################
# Exceptions
#######################################



