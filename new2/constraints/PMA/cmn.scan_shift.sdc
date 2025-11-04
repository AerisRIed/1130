###############################################################################
# These confidential and proprietary static timing constraints for a Hardware
# component may be used only as authorized by a licensing agreement from
# Cadence Design Systems, Inc. In the event of publication, the following
# notice is applicable:
#
#       (C) COPYRIGHT 2015 Cadence Design Systems, Inc.
#           ALL RIGHTS RESERVED
#
# The entire notice above must be reproduced on all authorized copies of
# this code.
###############################################################################
# Filename    : cmn.scan_shift.tcl
# Author(s)   : Dave Masters and Randy Fry
# Abstract    : SCAN Shift timing constraints for the Torrent CMN.
# Last Commit:
#     $Rev: 128703 $
#     $Date: 2022-11-01 03:47:57 +0800 (Tue, 01 Nov 2022) $
#     $Author: dmasters $
###############################################################################
# Change Log: Request via SVN query.
###############################################################################

#source [file dirname [info script]]/cmn.preamble.sdc
source $DUT_PATH/design/constraints/PMA/cmn.preamble.sdc

current_design cmn


###############################################################################
# Specific Mode/Case Analysis
###############################################################################
set_case_analysis 1 [get_ports {cmn_scanmode cmn_scanen cmn_scanen_cg}]


###############################################################################
# Clock Definitions
###############################################################################
create_clock \
    -name           REFCLK_SHIFT \
    -period         $SHIFT_PERIOD \
    -waveform       $SHIFT_WAVEFORM \
    [get_ports cmn_scanclk_ref_clk]

# Create scan clocks on Common cmn_ref_clk and cmn_ref_clk_gated output
# pins so I/O data can be timed against them.
create_generated_clock \
   -name            REFCLK_SHIFT_OUT \
   -divide_by       1 \
   -master_clock    [get_clocks { REFCLK_SHIFT }] \
   -source          [get_ports { cmn_scanclk_ref_clk }] \
   -add \
   [get_ports { cmn_ref_clk }]

create_generated_clock \
   -name            REFCLK_SHIFT_GATED_OUT \
   -divide_by       1 \
   -master_clock    [get_clocks { REFCLK_SHIFT }] \
   -source          [get_ports { cmn_scanclk_ref_clk }] \
   -add \
   [get_ports { cmn_ref_clk_gated }]

############################################
# PSM domain
############################################

create_clock \
    -name           PSMCLK_SHIFT \
    -period         $SHIFT_PERIOD \
    -waveform       $SHIFT_WAVEFORM \
    [get_ports cmn_scanclk_psm_clk]

create_generated_clock \
   -name            PSMCLK_SHIFT_OUT \
   -divide_by       1 \
   -master_clock    [get_clocks { PSMCLK_SHIFT }] \
   -source          [get_ports { cmn_scanclk_psm_clk }] \
   -add \
   [get_ports { cmn_psm_clk_out }]

create_clock \
    -name           PSMCLK_SHIFT_IN \
    -period         $SHIFT_PERIOD \
    -waveform       $SHIFT_WAVEFORM \
    [get_ports cmn_psm_clk_in]

############################################
# pclk domain
############################################

create_clock \
    -name           PCLK_SHIFT \
    -period         $SHIFT_PERIOD \
    -waveform       $SHIFT_WAVEFORM \
    [get_ports cmn_cdb_pclk]

############################################
# scanclk_pll_clks
############################################

create_clock \
   -name            PLLCLK_SHIFT \
   -period          $SHIFT_PERIOD \
   -waveform        $SHIFT_WAVEFORM \
   -add \
   [get_ports { cmn_scanclk_pll_clk }]

############################################
# ser_clk domain
############################################

create_clock \
    -name           SERCLK_SHIFT \
    -period         $SHIFT_PERIOD \
    -waveform       $SHIFT_WAVEFORM \
    [get_ports cmn_scanclk_ser_clk]


#######################################
# Virtual Clocks
#######################################
# Asynchronous clock phases. This phase is excluded from all other clocks.
create_clock \
    -name           IO_ASYNC \
    -period         $ASYNC_PERIOD \
    -waveform       $ASYNC_WAVEFORM 

###############################################################################
# Clock Groups
###############################################################################
set_clock_groups -asynchronous -name grp_shift_async  -group {IO_ASYNC}
set_clock_groups -asynchronous -name grp_shift_refclk -group {REFCLK_*}
set_clock_groups -asynchronous -name grp_shift_psmclk -group {PSMCLK_*}
set_clock_groups -asynchronous -name grp_shift_pclk   -group {PCLK_SHIFT}
set_clock_groups -asynchronous -name grp_shift_pllclk -group {PLLCLK_SHIFT}
set_clock_groups -asynchronous -name grp_shift_serclk -group {SERCLK_SHIFT}

###############################################################################
# Clock Uncertainties
###############################################################################
# Assume 20-80% duty cycle for a 5 ns clock period.
set rf_setup_margin [expr $setup_margin + 1.500]
set_clock_uncertainty $setup_margin    -setup -rise_from [all_clocks] -rise_to [all_clocks]
set_clock_uncertainty $setup_margin    -setup -fall_from [all_clocks] -fall_to [all_clocks]
#set_clock_uncertainty $rf_setup_margin -setup -rise_from [all_clocks] -fall_to [all_clocks]
#set_clock_uncertainty $rf_setup_margin -setup -fall_from [all_clocks] -rise_to [all_clocks]
set_clock_uncertainty $hold_margin     -hold  -from [all_clocks] -to [all_clocks]
set_clock_uncertainty   $setup_margin \
                        -setup \
                        -from   [get_clocks IO_ASYNC] \
                        -to     [get_clocks IO_ASYNC]

#DC Uncertainty
# REFCLK_SHIFT 200MHz @20-80% DC : 5.0ns period
set_clock_uncertainty [expr $setup_dc_margin + 1.500] -setup -rise_from [get_clocks {REFCLK*}] -fall_to [get_clocks {REFCLK*}]
set_clock_uncertainty [expr $setup_dc_margin + 1.500] -setup -fall_from [get_clocks {REFCLK*}] -rise_to [get_clocks {REFCLK*}]

# PSMCLK_SHIFT 200MHz @20-80% DC : 5.0ns period
set_clock_uncertainty [expr $setup_dc_margin + 1.500] -setup -rise_from [get_clocks {PSMCLK*}] -fall_to [get_clocks {PSMCLK*}]
set_clock_uncertainty [expr $setup_dc_margin + 1.500] -setup -fall_from [get_clocks {PSMCLK*}] -rise_to [get_clocks {PSMCLK*}]

# PCLK_SHIFT 200MHz @20-80% DC : 5.0ns period
set_clock_uncertainty [expr $setup_dc_margin + 1.500] -setup -rise_from [get_clocks {PCLK_SHIFT}] -fall_to [get_clocks {PCLK_SHIFT}]
set_clock_uncertainty [expr $setup_dc_margin + 1.500] -setup -fall_from [get_clocks {PCLK_SHIFT}] -rise_to [get_clocks {PCLK_SHIFT}]

# PLLCLK_SHIFT 200MHz @20-80% DC : 5.0ns period
set_clock_uncertainty [expr $setup_dc_margin + 1.500] -setup -rise_from [get_clocks {PLLCLK_SHIFT}] -fall_to [get_clocks {PLLCLK_SHIFT}]
set_clock_uncertainty [expr $setup_dc_margin + 1.500] -setup -fall_from [get_clocks {PLLCLK_SHIFT}] -rise_to [get_clocks {PLLCLK_SHIFT}]

# SERCLK_SHIFT : 200MHz @20-80% DC : 5.0ns period
set_clock_uncertainty [expr $setup_dc_margin + 1.500] -setup -rise_from [get_clocks {SERCLK_SHIFT}] -fall_to [get_clocks {SERCLK_SHIFT}]
set_clock_uncertainty [expr $setup_dc_margin + 1.500] -setup -fall_from [get_clocks {SERCLK_SHIFT}] -rise_to [get_clocks {SERCLK_SHIFT}]



#######################################
# MTBF flops
#######################################

###############################################################################
# Transitions and Transition Limits
###############################################################################
if { [info exists load_syn_sdc] && $load_syn_sdc} {
    set_max_transition   $max_trans [current_design]
    set_max_transition   $max_trans [all_inputs]
    set_max_transition   $max_trans [all_outputs]
    set_clock_transition $max_clk_trans [all_clocks]
} else {
::tech::set_transitions
}

###############################################################################
# I/O Timing
###############################################################################
#######################################
# Relative to IO_ASYNC
#######################################
set_input_delay 0.000 -max -add -clock [get_clocks IO_ASYNC] $data_input_port_collection 


#######################################
# SCAN_SHIFT I/O
#######################################
set_input_delay 3.330 -max -add -clock      [get_clocks REFCLK_SHIFT] \
                                            [get_ports  { \
                                                        cmn_scanin[*] \
                                                        } \
                                            ]

set_input_delay 3.330 -max -add -clock      [get_clocks PSMCLK_SHIFT] \
                                            [get_ports  { \
                                                        cmn_scanin[*] \
                                                        } \
                                            ]

set_input_delay 3.330 -max -add -clock      [get_clocks PSMCLK_SHIFT_IN] \
                                            [get_ports  { \
                                                        cmn_scanin[*] \
                                                        } \
                                            ]

set_input_delay 3.330 -max -add -clock      [get_clocks PCLK_SHIFT] \
                                            [get_ports  { \
                                                        cmn_scanin[*] \
                                                        } \
                                            ]

set_input_delay 3.330 -max -add -clock      [get_clocks PLLCLK_SHIFT] \
                                            [get_ports  { \
                                                        cmn_scanin[*] \
                                                        } \
                                            ]

set_input_delay 3.330 -max -add -clock      [get_clocks SERCLK_SHIFT] \
                                            [get_ports  { \
                                                        cmn_scanin[*] \
                                                        } \
                                            ]


set_output_delay 0.200 -max -add -clock     [get_clocks REFCLK_SHIFT] \
                                            [get_ports  { \
                                                        cmn_scanout[*] \
                                                        } \
                                            ]

set_output_delay 0.200 -max -add -clock     [get_clocks PSMCLK_SHIFT] \
                                            [get_ports  { \
                                                        cmn_scanout[*] \
                                                        } \
                                            ]

set_output_delay 0.200 -max -add -clock     [get_clocks PSMCLK_SHIFT_IN] \
                                            [get_ports  { \
                                                        cmn_scanout[*] \
                                                        } \
                                            ]

set_output_delay 0.200 -max -add -clock     [get_clocks PCLK_SHIFT] \
                                            [get_ports  { \
                                                        cmn_scanout[*] \
                                                        } \
                                            ]

set_output_delay 0.200 -max -add -clock     [get_clocks PLLCLK_SHIFT] \
                                            [get_ports  { \
                                                        cmn_scanout[*] \
                                                        } \
                                            ]

set_output_delay 0.200 -max -add -clock     [get_clocks SERCLK_SHIFT] \
                                            [get_ports  { \
                                                        cmn_scanout[*] \
                                                        } \
                                            ]



###############################################################################
# Input Driving Cells
###############################################################################
set_driving_cell -lib_cell $::DRIVING_CELL -pin $::DRIVING_PIN $digital_input_port_collection


###############################################################################
# Output Port Loading
###############################################################################
set_load 0.020 $digital_output_port_collection


###############################################################################
# Don't Use/Touch
###############################################################################
# Power & Ground Connections
set_dont_touch [get_nets $power_ground_port_list]
# Cmn_ana connections that must remain pure from/to their respective pma_cmn I/O ports.
set_dont_touch [get_nets $analog_port_list]

