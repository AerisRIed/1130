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
# Filename    : cmn.atspeed_cap.tcl
# Author(s)   : Dave Masters and Randy Fry
# Abstract    : SCAN At-Speed Capture timing constraints for the Torrent CMN.
# Last Commit:
#     $Rev: 128817 $
#     $Date: 2022-11-03 04:49:47 +0800 (Thu, 03 Nov 2022) $
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
# Mark requested 200MHz for stuckat and shift, adjusting atspeed to match for 
# lower frequency clocks
create_clock \
    -name           REFCLK_ACAP \
    -period         $CLK200_PERIOD \
    -waveform       $CLK200_WAVEFORM \
    [get_ports cmn_scanclk_ref_clk]

# Output clock pins on PMA for reference clocks.
create_generated_clock \
    -name           REFCLK_ACAP_OUT \
    -divide_by      1 \
    -master_clock   [get_clocks REFCLK_ACAP] \
    -source         [get_ports cmn_scanclk_ref_clk] \
    -add \
    [get_ports cmn_ref_clk]

create_generated_clock \
    -name           REFCLK_ACAP_GATED_OUT \
    -divide_by      1 \
    -master_clock   [get_clocks REFCLK_ACAP] \
    -source         [get_ports cmn_scanclk_ref_clk] \
    -add \
    [get_ports cmn_ref_clk_gated]

############################################
# PSM domain
############################################

create_clock \
    -name           PSMCLK_ACAP \
    -period         $CLK200_PERIOD \
    -waveform       $CLK200_WAVEFORM \
    [get_ports cmn_scanclk_psm_clk]

create_generated_clock \
    -name           PSMCLK_OUT_ACAP \
    -divide_by      1 \
    -master_clock   [get_clocks PSMCLK_ACAP] \
    -source         [get_ports cmn_scanclk_psm_clk] \
    -add \
    [get_ports cmn_psm_clk_out]

create_clock \
    -name           PSMCLK_IN_ACAP \
    -period         $CLK200_PERIOD \
    -waveform       $CLK200_WAVEFORM \
    [get_ports cmn_psm_clk_in]

############################################
# pclk domain
############################################

create_clock \
    -name           PCLK_ACAP \
    -period         $CLK525_PERIOD \
    -waveform       $CLK525_WAVEFORM \
    [get_ports cmn_cdb_pclk]

############################################
# scanclk_pll_clks
# Adjust DC 40-60% for atspeed timing
############################################

create_clock \
   -name     CMN_PLLCLK_ACAP \
   -period   $CLK650_PERIOD \
   -waveform $CLK650_WAVEFORM \
   [get_ports { cmn_scanclk_pll_clk }]


############################################
# ser_clk domain
############################################
# PLL programmable clocks
#PLL0 (max 1.25G)
#PLL1 (max 1G)


#create_clock \
#    -name           SERCLK_ACAP \
#    -period         $CLK1000_PERIOD \
#    -waveform       $CLK1000_WAVEFORM \
#    [get_ports cmn_scanclk_ser_clk]

create_clock \
    -name           SERCLK_ACAP \
    -period         $CLK1250_PERIOD \
    -waveform       $CLK1250_WAVEFORM \
    [get_ports cmn_scanclk_ser_clk]

create_generated_clock \
   -name         PLL0_CLK_PROG0_ACAP_OUT \
   -divide_by    1 \
   -master_clock [get_clocks SERCLK_ACAP] \
   -source       [get_ports cmn_scanclk_ser_clk] \
   -add \
   [get_ports cmn_pll0_clk_prog0]

create_generated_clock \
   -name         PLL0_CLK_PROG1_ACAP_OUT \
   -divide_by    1 \
   -master_clock [get_clocks SERCLK_ACAP] \
   -source       [get_ports cmn_scanclk_ser_clk] \
   -add \
   [get_ports cmn_pll0_clk_prog1]

create_generated_clock \
   -name         PLL1_CLK_PROG0_ACAP_OUT \
   -divide_by    1 \
   -master_clock [get_clocks SERCLK_ACAP] \
   -source       [get_ports cmn_scanclk_ser_clk] \
   -add \
   [get_ports cmn_pll1_clk_prog0]

create_generated_clock \
   -name         PLL1_CLK_PROG1_ACAP_OUT \
   -divide_by    1 \
   -master_clock [get_clocks SERCLK_ACAP] \
   -source       [get_ports cmn_scanclk_ser_clk] \
   -add \
   [get_ports cmn_pll1_clk_prog1]


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
set_clock_groups -async -name grp_acap_async  -group [get_clocks {IO_ASYNC}]
set_clock_groups -async -name grp_acap_refclk -group [get_clocks {REFCLK_*}]
set_clock_groups -async -name grp_acap_psmclk -group [get_clocks {PSMCLK_ACAP PSMCLK_IN_ACAP PSMCLK_OUT_ACAP}]
set_clock_groups -async -name grp_acap_pclk   -group [get_clocks {PCLK_ACAP}]
set_clock_groups -async -name grp_acap_serclk -group [get_clocks {SERCLK_ACAP PLL*_ACAP_OUT}]
set_clock_groups -async -name grp_acap_pll    -group [get_clocks {CMN_PLLCLK_ACAP}]

###############################################################################
# Clock Uncertainties
###############################################################################
set_clock_uncertainty $setup_margin -setup -from [all_clocks] -to [all_clocks]
set_clock_uncertainty $hold_margin  -hold  -from [all_clocks] -to [all_clocks]

#DC Uncertainty
# REFCLK_ACAP 200MHz @40-60% DC : 5.0ns period
set_clock_uncertainty [expr $setup_dc_margin + 0.500] -setup -rise_from [get_clocks {REFCLK*}] -fall_to [get_clocks {REFCLK*}]
set_clock_uncertainty [expr $setup_dc_margin + 0.500] -setup -fall_from [get_clocks {REFCLK*}] -rise_to [get_clocks {REFCLK*}]

# PSMCLK_ACAP 200MHz @33-66% DC : 5.0ns period
set_clock_uncertainty [expr $setup_dc_margin + 0.850] -setup -rise_from [get_clocks {PSMCLK*}] -fall_to [get_clocks {PSMCLK*}]
set_clock_uncertainty [expr $setup_dc_margin + 0.850] -setup -fall_from [get_clocks {PSMCLK*}] -rise_to [get_clocks {PSMCLK*}]

# CDB clock : 500MHz @50% : 2ns period, assume 5%
set_clock_uncertainty [expr $setup_dc_margin + 0.100] -setup -rise_from [get_clocks {PCLK_ACAP}] -fall_to [get_clocks {PCLK_ACAP}]
set_clock_uncertainty [expr $setup_dc_margin + 0.100] -setup -fall_from [get_clocks {PCLK_ACAP}] -rise_to [get_clocks {PCLK_ACAP}]

#CMN_PLLCLK_ACAP : 650MHz @40-60% : 1.538ns period
set_clock_uncertainty [expr $setup_dc_margin + 0.154] -setup -rise_from [get_clocks {CMN_PLLCLK_ACAP}] -fall_to [get_clocks {CMN_PLLCLK_ACAP}]
set_clock_uncertainty [expr $setup_dc_margin + 0.154] -setup -fall_from [get_clocks {CMN_PLLCLK_ACAP}] -rise_to [get_clocks {CMN_PLLCLK_ACAP}]

#SERCLK_ACAP : 1GHz @40-60% (assumed) : 1.0ns period
set_clock_uncertainty [expr $setup_dc_margin + 0.100] -setup -rise_from [get_clocks {SERCLK_ACAP}] -fall_to [get_clocks {SERCLK_ACAP}]
set_clock_uncertainty [expr $setup_dc_margin + 0.100] -setup -fall_from [get_clocks {SERCLK_ACAP}] -rise_to [get_clocks {SERCLK_ACAP}]

set_clock_uncertainty [expr $setup_dc_margin + 0.100] -setup -rise_from [get_clocks {PLL0_CLK_PROG0_ACAP_OUT}] -fall_to [get_clocks {PLL0_CLK_PROG0_ACAP_OUT}]
set_clock_uncertainty [expr $setup_dc_margin + 0.100] -setup -fall_from [get_clocks {PLL0_CLK_PROG0_ACAP_OUT}] -rise_to [get_clocks {PLL0_CLK_PROG0_ACAP_OUT}]

set_clock_uncertainty [expr $setup_dc_margin + 0.100] -setup -rise_from [get_clocks {PLL0_CLK_PROG1_ACAP_OUT}] -fall_to [get_clocks {PLL0_CLK_PROG1_ACAP_OUT}]
set_clock_uncertainty [expr $setup_dc_margin + 0.100] -setup -fall_from [get_clocks {PLL0_CLK_PROG1_ACAP_OUT}] -rise_to [get_clocks {PLL0_CLK_PROG1_ACAP_OUT}]

set_clock_uncertainty [expr $setup_dc_margin + 0.100] -setup -rise_from [get_clocks {PLL1_CLK_PROG0_ACAP_OUT}] -fall_to [get_clocks {PLL1_CLK_PROG0_ACAP_OUT}]
set_clock_uncertainty [expr $setup_dc_margin + 0.100] -setup -fall_from [get_clocks {PLL1_CLK_PROG0_ACAP_OUT}] -rise_to [get_clocks {PLL1_CLK_PROG0_ACAP_OUT}]

set_clock_uncertainty [expr $setup_dc_margin + 0.100] -setup -rise_from [get_clocks {PLL1_CLK_PROG1_ACAP_OUT}] -fall_to [get_clocks {PLL1_CLK_PROG1_ACAP_OUT}]
set_clock_uncertainty [expr $setup_dc_margin + 0.100] -setup -fall_from [get_clocks {PLL1_CLK_PROG1_ACAP_OUT}] -rise_to [get_clocks {PLL1_CLK_PROG1_ACAP_OUT}]

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
############################################
# Analog, asynchronous and constant ports
############################################
#Listed as found in Section 2 of the Whistler32G PMA spec
set async_inputs [get_ports {
   cmn_rext
   cmn_ref_clk_dig_sel
   cmn_ref_clk_disable
   cmn_ref_clk_dig_div[*]
   cmn_reset_n
   cmn_macro_suspend_req
   cmn_pll0_ref_clk_sel[*]
   cmn_pll0_reset_n
   cmn_pll0_en
   cmn_pll0_mode_sel
   cmn_pll0_suspend_req
   cmn_pll1_ref_clk_sel[*]
   cmn_pll1_reset_n
   cmn_pll1_en
   cmn_pll1_mode_sel
   cmn_pll1_suspend_req
   cmn_cdb_preset_n
   cmn_atb_core_0
   cmn_atb_core_1
   cmn_scanmode
   cmn_scanen
   cmn_scanen_cg
   cmn_scanin[*]
   cmn_bscan_mode_en
   xcvr_power_state_en_token_r
}]


foreach_in_collection pma_port $async_inputs {
   set port_name [get_object_name $pma_port]
   set_input_delay 0.0 -max -add -clock [get_clocks { IO_ASYNC }] $port_name
}

set async_outputs [get_ports {
   cmn_rext
   cmn_avdd_pwrgood
   cmn_pll0_locked
   cmn_pll1_locked
   cmn_atb_core_*
   cmn_scanout[*]
}]

set ASYNC_IO_DELAY      [expr round((($ASYNC_PERIOD * 1.0) * 0.485) * 100.0) / 100.0]
if { $::timeMode == "ideal" } {
    set async_input_delay  8.000
    set async_output_delay 8.000
} else {
    set async_input_delay  $ASYNC_IO_DELAY
    set async_output_delay $ASYNC_IO_DELAY
}

set_output_delay $async_output_delay -max -add -clock   [get_clocks IO_ASYNC] \
                                                        [get_ports  { \
                                                                    cmn_reset_n_l \
                                                                    cmn_reset_n_r \
                                                                    cmn_reset_sync_n_l \
                                                                    cmn_reset_sync_n_r \
                                                                    xcvr_power_state_en_token_l \
                                                                    } \
                                                        ]


#######################################
# REFCLK_ACAP 
#######################################
set CLK156P25_IO_DELAY     [expr round(($CLK156P25_PERIOD * 2.0 / 3.0) * 100.0) / 100.0]
if { $::timeMode == "ideal" } {
    set refclk_input_delay  2.800
    set refclk_output_delay 2.800
} else {
    set refclk_input_delay  $CLK156P25_IO_DELAY
    set refclk_output_delay $CLK156P25_IO_DELAY
}
#set_input_delay $refclk_input_delay -max -add -clock    [get_clocks REFCLK_ACAP] \
#                                                        [get_ports  { \
#                                                                    cmn_macro_suspend_req \
#                                                                    cmn_pll0_en \
#                                                                    cmn_pll1_en \
#                                                                    cmn_ref_clk_dig_div[*] \
#                                                                    cmn_ref_clk_disable \
#                                                                    cmn_ref_clk0_rcv_en \
#                                                                    cmn_ref_clk1_rcv_en \
#                                                                    rx_sd_clk_en_to_cmn_l \
#                                                                    rx_sd_clk_en_to_cmn_r \
#                                                                    rx_sig_det_en_to_cmn_l \
#                                                                    rx_sig_det_en_to_cmn_r \
#                                                                    } \
#                                                        ]

set_input_delay $refclk_input_delay -max -add -clock    [get_clocks REFCLK_ACAP] \
                                                        [get_ports  { \
                                                                    cmn_macro_suspend_req \
                                                                    cmn_pll0_en \
                                                                    cmn_pll1_en \
                                                                    cmn_ref_clk_dig_div[*] \
                                                                    cmn_ref_clk_disable \
                                                                    rx_sd_clk_en_to_cmn_l \
                                                                    rx_sd_clk_en_to_cmn_r \
                                                                    rx_sig_det_en_to_cmn_l \
                                                                    rx_sig_det_en_to_cmn_r \
                                                                    } \
                                                        ]




#                                                                    cmn_pll1_en \

set_output_delay $refclk_output_delay -max -add -clock  [get_clocks REFCLK_ACAP_OUT] \
                                                        [get_ports  { \
                                                                    cmn_macro_suspend_ack \
                                                                    cmn_macro_suspend_ack_l \
                                                                    cmn_macro_suspend_ack_r \
                                                                    cmn_pll0_suspend_ack \
                                                                    cmn_pll0_disabled \
                                                                    cmn_pll0_locked \
                                                                    cmn_pll0_ready \
                                                                    cmn_pll1_suspend_ack \
                                                                    cmn_pll1_disabled \
                                                                    cmn_pll1_locked \
                                                                    cmn_pll1_ready \
                                                                    cmn_ready \
                                                                    cmn_ready_l \
                                                                    cmn_ready_r \
                                                                    cmn_ref_clk_active \
                                                                    xcvr_decap_en_l \
                                                                    xcvr_decap_en_r \
                                                                    } \
                                                        ]


set_output_delay $refclk_output_delay -max -add -clock  [get_clocks REFCLK_ACAP_GATED_OUT] \
                                                        [get_ports  { \
                                                                    cmn_macro_suspend_ack \
                                                                    cmn_macro_suspend_ack_l \
                                                                    cmn_macro_suspend_ack_r \
                                                                    cmn_pll0_suspend_ack \
                                                                    cmn_pll0_disabled \
                                                                    cmn_pll0_locked \
                                                                    cmn_pll0_ready \
                                                                    cmn_pll1_suspend_ack \
                                                                    cmn_pll1_disabled \
                                                                    cmn_pll1_locked \
                                                                    cmn_pll1_ready \
                                                                    cmn_ready \
                                                                    cmn_ready_l \
                                                                    cmn_ready_r \
                                                                    cmn_ref_clk_active \
                                                                    xcvr_decap_en_l \
                                                                    xcvr_decap_en_r \
                                                                    } \
                                                        ]


#######################################
# PSMCLK_ACAP 
#######################################
if { $::timeMode == "ideal" } {
    set psmclk_input_delay  2.800
    set psmclk_output_delay 2.800
} else {
    set psmclk_input_delay  $CLK156P25_IO_DELAY
    set psmclk_output_delay $CLK156P25_IO_DELAY
}
set_input_delay $psmclk_input_delay -max -add -clock    [get_clocks PSMCLK_IN_ACAP] \
                                                        [get_ports  { \
                                                                    tx_clk_reset_req_l \
                                                                    tx_clk_reset_req_r \
                                                                    xcvr_clk_buf_en_0_l \
                                                                    xcvr_clk_buf_en_0_r \
                                                                    xcvr_clk_buf_en_1_l \
                                                                    xcvr_clk_buf_en_1_r \
                                                                    } \
                                                        ]

set_output_delay $psmclk_output_delay -max -add -clock  [get_clocks PSMCLK_OUT_ACAP] \
                                                        [get_ports  { \
                                                                    tx_clk_reset_ack_l \
                                                                    tx_clk_reset_ack_r \
                                                                    tx_clk_reset_stp_l \
                                                                    tx_clk_reset_stp_r \
                                                                    } \
                                                        ]

#######################################
# PCLK_ACAP 
#######################################
set CLK525_IO_DELAY     [expr round(($CLK525_PERIOD * 2.0 / 3.0) * 100.0) / 100.0]
if { $::timeMode == "ideal" } {
    set cdbclk_input_delay  0.600
    set cdbclk_output_delay 0.600
} else {
    set cdbclk_input_delay  $CLK525_IO_DELAY
    set cdbclk_output_delay $CLK525_IO_DELAY
}
set_input_delay $cdbclk_input_delay -max -add -clock    [get_clocks PCLK_ACAP] \
                                                        [get_ports  { \
                                                                    cmn_cdb_paddr[*] \
                                                                    cmn_cdb_penable \
                                                                    cmn_cdb_psel \
                                                                    cmn_cdb_pwdata[*] \
                                                                    cmn_cdb_pwrite \
                                                                    } \
                                                        ]

set_output_delay $cdbclk_output_delay -max -add -clock  [get_clocks PCLK_ACAP] \
                                                        [get_ports  { \
                                                                    cmn_cdb_prdata[*] \
                                                                    cmn_cdb_pready \
                                                                    cmn_atb_en_l \
                                                                    cmn_atb_en_r \
                                                                    cmn_atb_sel_l[*] \
                                                                    cmn_atb_sel_r[*] \
                                                                    rx_rescal_code_l[*] \
                                                                    rx_rescal_code_r[*] \
                                                                    tx_rescal_code_l[*] \
                                                                    tx_rescal_code_r[*] \
                                                                    } \
                                                        ]



#######################################
# Feedthrough Overrides 
#######################################

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
#set_dont_touch [get_nets $power_ground_port_list]
# Cmn_ana connections that must remain pure from/to their respective pma_cmn I/O ports.
set_dont_touch [get_nets $analog_port_list]


###############################################################################
# Exceptions
###############################################################################
# Synthesis (pre-mapped)
if { $load_syn_sdc && !$load_post_map_syn_sdc } {

# P&R
} else {
   # Set false paths to first flop in reset_sync logic.
   set_false_path -to [get_pins -hier *genblk1_u_reset_sync_synth_*_1/D]
   # Set false paths to first flop in data_sync logic.
   set_false_path -to [get_pins -hier *genblk1_genblk1_u_data_sync_synth_*_1/D]
   # Loren confirmed that both reset_sync flops get asynchronous resets.
   set_false_path -to [get_pins -hier *genblk1_u_reset_sync_synth_*_*/CD]
#   # False path all paths to SI pins.
#   set si_pin_collection [ get_pins -of [ all_registers ] -filter { @name == SI } ]
#   set_false_path  -from [all_clocks]  -to $si_pin_collection

}

