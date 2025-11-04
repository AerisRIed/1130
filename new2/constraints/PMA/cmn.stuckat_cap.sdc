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
# Filename    : cmn.stuckat_cap.tcl
# Author(s)   : Dave Masters and Jack Yarolin
# Abstract    : SCAN StuckAt Capture timing constraints for the Whistler CMN.
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
set_case_analysis 1 [get_ports cmn_scanmode]
set_case_analysis 0 [get_ports cmn_scanen]


###############################################################################
# Clock Definitions
###############################################################################
create_clock \
    -name           REFCLK_SCAP \
    -period         $STUCKAT_PERIOD \
    -waveform       $STUCKAT_WAVEFORM \
    [get_ports cmn_scanclk_ref_clk]

# Create scan clocks on Common cmn_ref_clk and cmn_ref_clk_gated output
# pins so I/O data can be timed against them.
create_generated_clock \
    -name           REFCLK_SCAP_OUT \
    -divide_by      1 \
    -master_clock   [get_clocks REFCLK_SCAP] \
    -source         [get_ports cmn_scanclk_ref_clk] \
    -add \
    [get_ports cmn_ref_clk]

create_generated_clock \
    -name           REFCLK_SCAP_GATED_OUT \
    -divide_by      1 \
    -master_clock   [get_clocks REFCLK_SCAP] \
    -source         [get_ports cmn_scanclk_ref_clk] \
    -add \
    [get_ports cmn_ref_clk_gated]

############################################
# PSM domain
############################################

create_clock \
    -name           PSMCLK_SCAP \
    -period         $STUCKAT_PERIOD \
    -waveform       $STUCKAT_WAVEFORM \
    [get_ports cmn_scanclk_psm_clk]

create_generated_clock \
   -name            PSMCLK_SCAP_OUT \
   -divide_by       1 \
   -master_clock    [get_clocks { PSMCLK_SCAP }] \
   -source          [get_ports { cmn_scanclk_psm_clk }] \
   -add \
   [get_ports { cmn_psm_clk_out }]

create_clock \
    -name           PSMCLK_SCAP_IN \
    -period         $STUCKAT_PERIOD \
    -waveform       $STUCKAT_WAVEFORM \
    [get_ports cmn_psm_clk_in]

############################################
# pclk domain
############################################

create_clock \
    -name           PCLK_SCAP \
    -period         $STUCKAT_PERIOD \
    -waveform       $STUCKAT_WAVEFORM \
    [get_ports cmn_cdb_pclk]

############################################
# scanclk_pll_clks
############################################
# Common cmn_scanclk_pll_clk input pin.
create_clock \
   -name     PLLCLK_SCAP \
   -period   $STUCKAT_PERIOD \
   -waveform $STUCKAT_WAVEFORM \
   -add \
   [get_ports { cmn_scanclk_pll_clk }]

############################################
# ser_clk domain
############################################

create_clock \
    -name           SERCLK_SCAP \
    -period         $STUCKAT_PERIOD \
    -waveform       $STUCKAT_WAVEFORM \
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
set_clock_groups -asynchronous -name grp_scap_async  -group [get_clocks {IO_ASYNC}]
set_clock_groups -asynchronous -name grp_scap_refclk -group [get_clocks {REFCLK_*}]
set_clock_groups -asynchronous -name grp_scap_psmclk -group [get_clocks {PSMCLK_SCAP PSMCLK_SCAP*}]
set_clock_groups -asynchronous -name grp_scap_pclk   -group [get_clocks {PCLK_SCAP}]
set_clock_groups -asynchronous -name grp_scap_pllclk -group [get_clocks {PLLCLK_SCAP}]
set_clock_groups -asynchronous -name grp_scap_serclk -group [get_clocks {SERCLK_SCAP}]

###############################################################################
# Clock Uncertainties
###############################################################################
set_clock_uncertainty  $setup_margin   -setup -from [all_clocks] -to [all_clocks]
set_clock_uncertainty  $hold_margin    -hold  -from [all_clocks] -to [all_clocks]

#DC Uncertainty
# REFCLK_SCAP 200MHz @40-60% DC : 5.0ns period
set_clock_uncertainty [expr $setup_dc_margin + 0.500] -setup -rise_from [get_clocks {REFCLK*}] -fall_to [get_clocks {REFCLK*}]
set_clock_uncertainty [expr $setup_dc_margin + 0.500] -setup -fall_from [get_clocks {REFCLK*}] -rise_to [get_clocks {REFCLK*}]

# PSMCLK_SCAP 200MHz @33-66% DC : 5.0ns period
set_clock_uncertainty [expr $setup_dc_margin + 0.850] -setup -rise_from [get_clocks {PSMCLK*}] -fall_to [get_clocks {PSMCLK*}]
set_clock_uncertainty [expr $setup_dc_margin + 0.850] -setup -fall_from [get_clocks {PSMCLK*}] -rise_to [get_clocks {PSMCLK*}]

# PCLK_SCAP 200MHz @33-66% DC : 5.0ns period
set_clock_uncertainty [expr $setup_dc_margin + 0.850] -setup -rise_from [get_clocks {PCLK_SCAP}] -fall_to [get_clocks {PCLK_SCAP}]
set_clock_uncertainty [expr $setup_dc_margin + 0.850] -setup -fall_from [get_clocks {PCLK_SCAP}] -rise_to [get_clocks {PCLK_SCAP}]

# PLLCLK_SCAP 200MHz @40-60% DC : 5.0ns period
set_clock_uncertainty [expr $setup_dc_margin + 0.500] -setup -rise_from [get_clocks {PLLCLK_SCAP}] -fall_to [get_clocks {PLLCLK_SCAP}]
set_clock_uncertainty [expr $setup_dc_margin + 0.500] -setup -fall_from [get_clocks {PLLCLK_SCAP}] -rise_to [get_clocks {PLLCLK_SCAP}]

# SERCLK_SCAP : 200MHz @40-60% DC : 5.0ns period
set_clock_uncertainty [expr $setup_dc_margin + 0.500] -setup -rise_from [get_clocks {SERCLK_SCAP}] -fall_to [get_clocks {SERCLK_SCAP}]
set_clock_uncertainty [expr $setup_dc_margin + 0.500] -setup -fall_from [get_clocks {SERCLK_SCAP}] -rise_to [get_clocks {SERCLK_SCAP}]

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
set IO_DELAY [expr round(($STUCKAT_PERIOD * 6.0 / 10.0) * 100) / 100.0]

set_input_delay  $IO_DELAY -max -add -clock [get_clocks REFCLK_SCAP]           $data_input_port_collection
set_input_delay  $IO_DELAY -max -add -clock [get_clocks PSMCLK_SCAP]           $data_input_port_collection
set_input_delay  $IO_DELAY -max -add -clock [get_clocks PSMCLK_SCAP_IN]        $data_input_port_collection
set_input_delay  $IO_DELAY -max -add -clock [get_clocks PSMCLK_SCAP_OUT]       $data_input_port_collection
set_input_delay  $IO_DELAY -max -add -clock [get_clocks PCLK_SCAP]             $data_input_port_collection
set_input_delay  $IO_DELAY -max -add -clock [get_clocks PLLCLK_SCAP]           $data_input_port_collection
set_input_delay  $IO_DELAY -max -add -clock [get_clocks SERCLK_SCAP]           $data_input_port_collection

set_output_delay $IO_DELAY -max -add -clock [get_clocks REFCLK_SCAP]           $data_output_port_collection
set_output_delay $IO_DELAY -max -add -clock [get_clocks REFCLK_SCAP_OUT]       $data_output_port_collection
set_output_delay $IO_DELAY -max -add -clock [get_clocks REFCLK_SCAP_GATED_OUT] $data_output_port_collection
set_output_delay $IO_DELAY -max -add -clock [get_clocks PSMCLK_SCAP]           $data_output_port_collection
set_output_delay $IO_DELAY -max -add -clock [get_clocks PSMCLK_SCAP_IN]        $data_output_port_collection
set_output_delay $IO_DELAY -max -add -clock [get_clocks PSMCLK_SCAP_OUT]       $data_output_port_collection
set_output_delay $IO_DELAY -max -add -clock [get_clocks PCLK_SCAP]             $data_output_port_collection
set_output_delay $IO_DELAY -max -add -clock [get_clocks PLLCLK_SCAP]           $data_output_port_collection
set_output_delay $IO_DELAY -max -add -clock [get_clocks SERCLK_SCAP]           $data_output_port_collection

# Feedthrough path adjustment overrides to reduce overly large negative slacks.
set_input_delay  3.0 -max -clock [get_clocks SERCLK_SCAP] [get_ports xcvr_power_state_en_token_r]
set_output_delay 3.0 -max -clock [get_clocks SERCLK_SCAP] [get_ports xcvr_power_state_en_token_l]
set_output_delay 3.0 -max -clock [get_clocks PCLK_SCAP]   [get_ports cmn_scanout[*]]

###############################################################################
# Misc
###############################################################################

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


###############################################################################
# Exceptions
###############################################################################
# Loren confirmed that both reset_sync flops get asynchronous resets.
#set_false_path -to [get_pins -hier *genblk1_u_reset_sync_synth_*_*/CD]

# False path all paths to SI pins.
#set si_pin_collection [ get_pins -of [ all_registers ] -filter { @name == SI } ]
#set_false_path  -from [all_clocks]  -to $si_pin_collection

