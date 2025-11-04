###############################################################################
# These confidential and proprietary static timing constraints for a Hardware
# component may be used only as authorized by a licensing agreement from
# Cadence Design Systems, Inc. In the event of publication, the following
# notice is applicable:
#
#       (C) COPYRIGHT 2022 Cadence Design Systems, Inc.
#           ALL RIGHTS RESERVED
#
# The entire notice above must be reproduced on all authorized copies of
# this code.
###############################################################################
#
# Filename  : sd1601_pma.func.tcl
# Version   : $Revision$
# Date/Time : $Date$
#
# Author    : Jack Yarolin
# Abstract  : Functional and boundary scan constraints for the Whistler PMA.
#
###############################################################################
# Change Log
# $Log:$
#
###############################################################################
# IMPORTANT:
#   This file does not set the current_design variable; it must be set prior
#   to sourcing this file, .e.g.,
#      current_design cdn_sd1601_t7g_44_vf150_1xh1xav1yah5yvhvhv2yy2yx2r
#
#   There are several variables that can be optionally set:
#      ::timeMode      - Clocking mode. Valid values are "prop" and "ideal".
#                     Normally set by CFI.
#      do_libgen     - Set to 1 to adjust constraints for Liberty model
#                     generation.
###############################################################################
#if {![info exists ::dsgn]} {set ::dsgn $::env(TOPCELL)}

#source [file dirname [info script]]/pma.preamble.sdc
source $DUT_PATH/design/constraints/PMA/pma.preamble.sdc

#current_design $::dsgn
current_design cdn_sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z


###############################################################################
# set_case_analysis
###############################################################################

# Scan controls.
#set_case_analysis 0 [get_ports { cmn_scanmode cmn_scanen cmn_scanen_cg cmn_scan_pll_ats xcvr_flyover_en_ln_*}]
set_case_analysis 0 [get_ports { cmn_scanmode cmn_scanen cmn_scanen_cg cmn_scan_pll_ats}]

#for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {
#   set lane_inst u_pma_rev/u_xcvr_$lane_map($lane)
#   # During functional mode when powered up, sandh need to be timed as passthru to allow PSM clk data phase to output pins
#   set_case_analysis 0 [get_pins ${lane_inst}/u_xcvr_ctrl/u_sandh_latch_xcvr_power_state_ack/sandh_out_reg[*]/EN]
#   # Need to force non-inverted deserializer and serializer clocks.
#   set_case_analysis 0 [get_pins  ${lane_inst}/u_xcvr_ctrl/u_xcvr_diag_ovrd/u_xcvr_diag_ovrd_cdb_regs/xcvr_diag_rx_ana_clk_ctrl_reg_reg[29]/Q]
#   set_case_analysis 0 [get_pins  ${lane_inst}/u_xcvr_ctrl/u_xcvr_diag_ovrd/u_xcvr_diag_ovrd_cdb_regs/xcvr_diag_tx_ana_clk_ctrl_reg_reg[29]/Q]
#   # Scan controls.
#   set_case_analysis 0 [get_ports xcvr_scanmode_ln_${lane}]
#   set_case_analysis 0 [get_ports xcvr_scanen_ln_${lane}]
#   set_case_analysis 0 [get_ports xcvr_scanen_cg_ln_${lane}]
#}

if { $load_syn_sdc && !$load_post_map_syn_sdc } {
set_case_analysis 0 [get_pins u_pma_rev/u_xcvr_txm/u_xcvr_txonly0/u_xcvr_ctrl/u_sandh_latch_xcvr_power_state_ack/sandh_en]
set_case_analysis 0 [get_pins u_pma_rev/u_xcvr_txm/u_xcvr_txonly1/u_xcvr_ctrl/u_sandh_latch_xcvr_power_state_ack/sandh_en]
set_case_analysis 0 [get_pins u_pma_rev/u_xcvr_txrxm_lane1/u_xcvr_ctrl/u_sandh_latch_xcvr_power_state_ack/sandh_en]
set_case_analysis 0 [get_pins u_pma_rev/u_xcvr_txrxm_lane2/u_xcvr_ctrl/u_sandh_latch_xcvr_power_state_ack/sandh_en]

set_case_analysis 0 [get_pins  u_pma_rev/u_xcvr_txm/u_xcvr_txonly0/u_xcvr_ctrl/u_xcvr_diag_ovrd/u_xcvr_diag_ovrd_cdb_regs/xcvr_diag_txclk_ctrl_reg[15]]
set_case_analysis 0 [get_pins  u_pma_rev/u_xcvr_txm/u_xcvr_txonly0/u_xcvr_ctrl/u_xcvr_diag_ovrd/u_xcvr_diag_ovrd_cdb_regs/xcvr_diag_rxclk_ctrl_reg[15]]
set_case_analysis 0 [get_pins  u_pma_rev/u_xcvr_txm/u_xcvr_txonly1/u_xcvr_ctrl/u_xcvr_diag_ovrd/u_xcvr_diag_ovrd_cdb_regs/xcvr_diag_txclk_ctrl_reg[15]]
set_case_analysis 0 [get_pins  u_pma_rev/u_xcvr_txm/u_xcvr_txonly1/u_xcvr_ctrl/u_xcvr_diag_ovrd/u_xcvr_diag_ovrd_cdb_regs/xcvr_diag_rxclk_ctrl_reg[15]]
set_case_analysis 0 [get_pins  u_pma_rev/u_xcvr_txrxm_lane1/u_xcvr_ctrl/u_xcvr_diag_ovrd/u_xcvr_diag_ovrd_cdb_regs/xcvr_diag_txclk_ctrl_reg[15]]
set_case_analysis 0 [get_pins  u_pma_rev/u_xcvr_txrxm_lane1/u_xcvr_ctrl/u_xcvr_diag_ovrd/u_xcvr_diag_ovrd_cdb_regs/xcvr_diag_rxclk_ctrl_reg[15]]
set_case_analysis 0 [get_pins  u_pma_rev/u_xcvr_txrxm_lane2/u_xcvr_ctrl/u_xcvr_diag_ovrd/u_xcvr_diag_ovrd_cdb_regs/xcvr_diag_txclk_ctrl_reg[15]]
set_case_analysis 0 [get_pins  u_pma_rev/u_xcvr_txrxm_lane2/u_xcvr_ctrl/u_xcvr_diag_ovrd/u_xcvr_diag_ovrd_cdb_regs/xcvr_diag_rxclk_ctrl_reg[15]]


# P&R
} else {

# During functional mode when powered up, sandh need to be timed as passthru to allow PSM clk data phase to output pins
set_case_analysis 0 [get_pins u_pma_rev/u_xcvr_txm/u_xcvr_txonly0/u_xcvr_ctrl/u_sandh_latch_xcvr_power_state_ack/sandh_out_reg[*]/EN]
set_case_analysis 0 [get_pins u_pma_rev/u_xcvr_txm/u_xcvr_txonly1/u_xcvr_ctrl/u_sandh_latch_xcvr_power_state_ack/sandh_out_reg[*]/EN]
set_case_analysis 0 [get_pins u_pma_rev/u_xcvr_txrxm_lane1/u_xcvr_ctrl/u_sandh_latch_xcvr_power_state_ack/sandh_out_reg[*]/EN]
set_case_analysis 0 [get_pins u_pma_rev/u_xcvr_txrxm_lane2/u_xcvr_ctrl/u_sandh_latch_xcvr_power_state_ack/sandh_out_reg[*]/EN]


# Need to force non-inverted deserializer and serializer clocks.
set_case_analysis 0 [get_pins  u_pma_rev/u_xcvr_txm/u_xcvr_txonly0/u_xcvr_ctrl/u_xcvr_diag_ovrd/u_xcvr_diag_ovrd_cdb_regs/xcvr_diag_txclk_ctrl_reg_reg[15]/Q]
set_case_analysis 0 [get_pins  u_pma_rev/u_xcvr_txm/u_xcvr_txonly0/u_xcvr_ctrl/u_xcvr_diag_ovrd/u_xcvr_diag_ovrd_cdb_regs/xcvr_diag_rxclk_ctrl_reg_reg[15]/Q]
set_case_analysis 0 [get_pins  u_pma_rev/u_xcvr_txm/u_xcvr_txonly1/u_xcvr_ctrl/u_xcvr_diag_ovrd/u_xcvr_diag_ovrd_cdb_regs/xcvr_diag_txclk_ctrl_reg_reg[15]/Q]
set_case_analysis 0 [get_pins  u_pma_rev/u_xcvr_txm/u_xcvr_txonly1/u_xcvr_ctrl/u_xcvr_diag_ovrd/u_xcvr_diag_ovrd_cdb_regs/xcvr_diag_rxclk_ctrl_reg_reg[15]/Q]
set_case_analysis 0 [get_pins  u_pma_rev/u_xcvr_txrxm_lane1/u_xcvr_ctrl/u_xcvr_diag_ovrd/u_xcvr_diag_ovrd_cdb_regs/xcvr_diag_txclk_ctrl_reg_reg[15]/Q]
set_case_analysis 0 [get_pins  u_pma_rev/u_xcvr_txrxm_lane1/u_xcvr_ctrl/u_xcvr_diag_ovrd/u_xcvr_diag_ovrd_cdb_regs/xcvr_diag_rxclk_ctrl_reg_reg[15]/Q]
set_case_analysis 0 [get_pins  u_pma_rev/u_xcvr_txrxm_lane2/u_xcvr_ctrl/u_xcvr_diag_ovrd/u_xcvr_diag_ovrd_cdb_regs/xcvr_diag_txclk_ctrl_reg_reg[15]/Q]
set_case_analysis 0 [get_pins  u_pma_rev/u_xcvr_txrxm_lane2/u_xcvr_ctrl/u_xcvr_diag_ovrd/u_xcvr_diag_ovrd_cdb_regs/xcvr_diag_rxclk_ctrl_reg_reg[15]/Q]


}

for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {
   # Scan controls.
   set_case_analysis 0 [get_ports xcvr_scanmode_ln_${lane}]
   set_case_analysis 0 [get_ports xcvr_scanen_ln_${lane}]
   set_case_analysis 0 [get_ports xcvr_scanen_cg_ln_${lane}]
}



###############################################################################
# Clock definitions
###############################################################################

############################################
# Reference and related clocks.
############################################

# The PLL reference clock coming from the bumps (cmn_ref_clk_p and cmn_ref_clk_m)
# and from the SOC (cmn_ref_clk_int) go directly to the analog so are untimed 
# from a digital STA perspective. Clocks are defined for them so the clock
# attribute will be set. 
#create_clock \
#    -name     REFCLK0_P_FROM_BUMP \
#    -period   $CLK156P25_PERIOD \
#    -waveform $CLK156P25_WAVEFORM \
#    [get_ports { cmn_ref_clk0_p }]
#
#create_clock \
#    -name     REFCLK0_M_FROM_BUMP \
#    -period   $CLK156P25_PERIOD \
#    -waveform $CLK156P25_INV_WAVEFORM \
#    [get_ports { cmn_ref_clk0_m }]
#
#create_clock \
#    -name     REFCLK1_P_FROM_BUMP \
#    -period   $CLK156P25_PERIOD \
#    -waveform $CLK156P25_WAVEFORM \
#    [get_ports { cmn_ref_clk1_p }]
#
#create_clock \
#    -name     REFCLK1_M_FROM_BUMP \
#    -period   $CLK156P25_PERIOD \
#    -waveform $CLK156P25_INV_WAVEFORM \
#    [get_ports { cmn_ref_clk1_m }]

create_clock \
    -name     REFCLK0_FROM_SOC \
    -period   $CLK156P25_PERIOD \
    -waveform $CLK156P25_WAVEFORM \
    [get_ports { cmn_ref_clk0_int }]

create_clock \
    -name     REFCLK1_FROM_SOC \
    -period   $CLK156P25_PERIOD \
    -waveform $CLK156P25_WAVEFORM \
    [get_ports { cmn_ref_clk1_int }]

# Output from analog. The max frequency is 156.25 MHz. The clock can be divided by
# 1, 2, 4 or 8 although 2 and 8 are reserved cases. The macro is timed at the
# divide-by-1 frequency of 156.25 MHz.
#create_clock \
#    -name     REFCLK \
#    -period   $CLK156P25_PERIOD \
#    -waveform $CLK156P25_WAVEFORM \
#    [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_ref_clk }]
#


create_generated_clock \
    -name           REFCLK0_OUT \
    -divide_by      1 \
    -master_clock   [get_clocks REFCLK0_FROM_SOC] \
    -source         [get_ports cmn_ref_clk0_int] \
    -add \
    [get_pins u_pma_rev/u_cmn/u_cmn_clkrst/u_clock_mux_ref_clk/clk_out]


create_generated_clock \
    -name           REFCLK1_OUT \
    -divide_by      1 \
    -master_clock   [get_clocks REFCLK1_FROM_SOC] \
    -source         [get_ports cmn_ref_clk1_int] \
    -add \
    [get_pins u_pma_rev/u_cmn/u_cmn_clkrst/u_clock_mux_ref_clk/clk_out]




## Output clock pins on PMA for reference clocks.
#create_generated_clock \
#    -name         REFCLK_OUT \
#    -divide_by    1 \
#    -master_clock [get_clocks { REFCLK }] \
#    -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_ref_clk }] \
#    -add \
#    [get_ports { cmn_ref_clk }]

create_generated_clock \
    -name           REFCLK_OUT_0 \
    -divide_by      1 \
    -master_clock   [get_clocks REFCLK0_OUT] \
    -source         [get_pins u_pma_rev/u_cmn/u_cmn_clkrst/u_clock_mux_ref_clk/clk_out] \
    -add \
    [get_ports cmn_ref_clk]

create_generated_clock \
    -name           REFCLK_OUT_1 \
    -divide_by      1 \
    -master_clock   [get_clocks REFCLK1_OUT] \
    -source         [get_pins u_pma_rev/u_cmn/u_cmn_clkrst/u_clock_mux_ref_clk/clk_out] \
    -add \
    [get_ports cmn_ref_clk]



#create_generated_clock \
#    -name         REFCLK_GATED_OUT \
#    -divide_by    1 \
#    -master_clock [get_clocks { REFCLK }] \
#    -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_ref_clk }] \
#    -add \
#    [get_ports { cmn_ref_clk_gated }]

create_generated_clock \
    -name           REFCLK_GATED_OUT_0 \
    -divide_by      1 \
    -master_clock   [get_clocks REFCLK0_OUT] \
    -source         [get_pins u_pma_rev/u_cmn/u_cmn_clkrst/u_clock_mux_ref_clk/clk_out] \
    -add \
    [get_ports cmn_ref_clk_gated]

create_generated_clock \
    -name           REFCLK_GATED_OUT_1 \
    -divide_by      1 \
    -master_clock   [get_clocks REFCLK1_OUT] \
    -source         [get_pins u_pma_rev/u_cmn/u_cmn_clkrst/u_clock_mux_ref_clk/clk_out] \
    -add \
    [get_ports cmn_ref_clk_gated]



# Reference clock receiver clock. This clock always runs at same frequency as the input
# reference clock and does not clock any logic. REFCLK_RCV_OUT is needed for Liberty
# model generation.
#create_clock \
#    -name     REFCLK0_RCV \
#    -period   $CLK156P25_PERIOD \
#    -waveform $CLK156P25_WAVEFORM \
#    [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_ref_clk0_rcv }]
#
#create_generated_clock \
#    -name         REFCLK0_RCV_OUT \
#    -divide_by    1 \
#    -master_clock [get_clocks { REFCLK0_RCV }] \
#    -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_ref_clk0_rcv }] \
#    -add \
#    [get_ports { cmn_ref_clk0_rcv }]
#
#create_clock \
#    -name     REFCLK1_RCV \
#    -period   $CLK156P25_PERIOD \
#    -waveform $CLK156P25_WAVEFORM \
#    [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_ref_clk1_rcv }]
#
#create_generated_clock \
#    -name         REFCLK1_RCV_OUT \
#    -divide_by    1 \
#    -master_clock [get_clocks { REFCLK1_RCV }] \
#    -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_ref_clk1_rcv }] \
#    -add \
#    [get_ports { cmn_ref_clk1_rcv }]

# [DL] 10/5/2022 SDC review. Commented out as it outputted unwanted data in the lib.
# Derived reference clock. This clock always runs at same frequency as the input
# reference clock and does not clock any logic. REFCLK_DER_OUT and REFCLK_DER_N_OUT
# are needed for Liberty model generation.
#create_clock \
    #   -name     REFCLK_DER \
    #   -period   $CLK156P25_PERIOD \
    #   -waveform $CLK156P25_WAVEFORM \
    #   [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_ref_clk_der }]

#create_generated_clock \
    #   -name         REFCLK_DER_OUT \
    #   -divide_by    1 \
    #   -master_clock [get_clocks { REFCLK_DER }] \
    #   -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_ref_clk_der }] \
    #   -add \
    #   [get_ports { cmn_ref_clk_der }]


# PLL programmable clocks
# PLL0 (max 1.25G)
# PLL1 (max 1G)
#create_clock \
#    -name     PLL0_CLK_PROG0 \
#    -period   $CLK1250_PERIOD \
#    -waveform $CLK1250_WAVEFORM \
#    [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_clk_prog0 }]
#
#create_generated_clock \
#    -name         PLL0_CLK_PROG0_OUT \
#    -divide_by    1 \
#    -master_clock [get_clocks { PLL0_CLK_PROG0 }] \
#    -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_clk_prog0 }] \
#    -add \
#    [get_ports { cmn_pll0_clk_prog0 }]
#
#create_clock \
#    -name     PLL0_CLK_PROG1 \
#    -period   $CLK1250_PERIOD \
#    -waveform $CLK1250_WAVEFORM \
#    [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_clk_prog1 }]
#
#create_generated_clock \
#    -name         PLL0_CLK_PROG1_OUT \
#    -divide_by    1 \
#    -master_clock [get_clocks { PLL0_CLK_PROG1 }] \
#    -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_clk_prog1 }] \
#    -add \
#    [get_ports { cmn_pll0_clk_prog1 }]
#
#create_clock \
#    -name     PLL1_CLK_PROG0 \
#    -period   $CLK1000_PERIOD \
#    -waveform $CLK1000_WAVEFORM \
#    [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll1_clk_prog0 }]
#
#create_generated_clock \
#    -name         PLL1_CLK_PROG0_OUT \
#    -divide_by    1 \
#    -master_clock [get_clocks { PLL1_CLK_PROG0 }] \
#    -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll1_clk_prog0 }] \
#    -add \
#    [get_ports { cmn_pll1_clk_prog0 }]
#
#create_clock \
#    -name     PLL1_CLK_PROG1 \
#    -period   $CLK1000_PERIOD \
#    -waveform $CLK1000_WAVEFORM \
#    [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll1_clk_prog1 }]
#
#create_generated_clock \
#    -name         PLL1_CLK_PROG1_OUT \
#    -divide_by    1 \
#    -master_clock [get_clocks { PLL1_CLK_PROG1 }] \
#    -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll1_clk_prog1 }] \
#    -add \
#    [get_ports { cmn_pll1_clk_prog1 }]

######################################################
# MOM Cap Oscillator output clock 100MHz - goes to clkmsmt
######################################################
create_clock \
    -name     CMN_MOM_OSC_CLK \
    -period   $CLK100_PERIOD \
    -waveform $CLK100_WAVEFORM \
    [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_mom_osc_clk }]

######################################################
# Temperature sensor filter clock - NOTE: 625MHz for atspeed scan
######################################################
create_clock \
    -name     CMN_TMPSNS_CLK \
    -period   $CLK312P5_PERIOD \
    -waveform $CLK312P5_WAVEFORM \
    [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_tmpsns_sdm_clk_out }]

#######################################
# Process Monitor Clock
#######################################
# JMY 20160822 Add PCMCLK, 500MHz based upon information provided by analog @ 45-55% DC - goes to clkmsmt
create_clock \
    -name     CMN_PCMCLK \
    -period   $CLK500_PERIOD \
    -waveform $CLK500_WAVEFORM \
    [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pmc_clk }]

#######################################
# Signal Detect Clock
#######################################
create_clock \
    -name     CMN_SDCLK \
    -period   $CLK625_PERIOD \
    -waveform $CLK625_WAVEFORM \
    [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_sd_clk }]

###########################################################
# PSM clocks
###########################################################
# JMY 20160825 Update to div-by-4 of 625MHz (156.25MHz) to cover 125MHz spec
create_generated_clock \
    -name         CMN_PSMCLK \
    -divide_by    4 \
    -master_clock [get_clocks { CMN_SDCLK }] \
    -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_sd_clk }] \
    -add \
    [get_pins u_pma_rev/u_cmn/u_cmn_clkrst/u_clock_div_prog_psm_clk/u_clock_mux/${clk_mux_pin_1} ]

# Common output PSM clock.
create_generated_clock \
    -name         CMN_PSMCLK_OUT \
    -divide_by    1 \
    -master_clock [get_clocks { CMN_PSMCLK }] \
    -source       [get_pins  u_pma_rev/u_cmn/u_cmn_clkrst/u_clock_div_prog_psm_clk/u_clock_mux/${clk_mux_pin_1} ] \
    -add \
    [get_ports { cmn_psm_clk_out }]

# Common input PSM clock.
# [DL] SDC review. At-speed is having it as 200MHz and is the most restrictive.
create_clock \
    -name     CMN_PSMCLK_IN \
    -period   $CLK156P25_PERIOD \
    -waveform $CLK156P25_WAVEFORM \
    [get_ports { cmn_psm_clk_in }]

# Lane input PSM clocks. 
for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {

   # [DL] SDC review. At-speed is having it as 200MHz and is the most restrictive.
   create_clock \
       -name     LN_${lane}_PSMCLK \
       -period   $CLK156P25_PERIOD \
       -waveform $CLK156P25_WAVEFORM \
       [get_ports xcvr_psm_clk_ln_$lane]

}

############################################
# CDB clock : 525MHz
############################################
create_clock \
    -name     CMN_CDBCLK \
    -period   $CLK525_PERIOD \
    -waveform $CLK525_WAVEFORM \
    [get_ports { cmn_cdb_pclk }]

for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {
   set lane_inst u_pma_rev/u_xcvr_$lane_map($lane)

   create_clock \
       -name     LN_${lane}_CDBCLK \
       -period   $CLK525_PERIOD \
       -waveform $CLK525_WAVEFORM \
       [get_ports xcvr_cdb_pclk_ln_$lane]
}

############################################
# Misc Common clocks.
############################################

############################################
# PLL reference, feedback and DSM clocks.
############################################

# PLL0 reference clocks. Implement REFCLK frequencies to 156.25MHz (100MHz max per spec)
create_clock \
    -name     PLL0_REFCLK \
    -period   $CLK156P25_PERIOD \
    -waveform $CLK156P25_WAVEFORM \
    [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_ref_clk }]

#create_clock \
#    -name     PLL1_REFCLK \
#    -period   $CLK156P25_PERIOD \
#    -waveform $CLK156P25_WAVEFORM \
#    [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll1_ref_clk }]

# PLL0/1 feedback divider clocks.
# Spec has 500MHz max but during calibration there is a chance this may go higher SER-22134
create_clock \
    -name     PLL0_FBCLK \
    -period   $CLK625_PERIOD \
    -waveform $CLK625_WAVEFORM \
    [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_fb_divider_clk }]

#create_clock \
#    -name     PLL1_FBCLK \
#    -period   $CLK625_PERIOD \
#    -waveform $CLK625_WAVEFORM \
#    [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll1_fb_divider_clk }]

# PLL0/1 DSM clocks. Currently speced to 100MHz max but calibration and stuckat caused target to 200MHz
create_clock \
    -name     PLL0_DSMCLK \
    -period   $DSMCLK_PERIOD \
    -waveform $DSMCLK_WAVEFORM \
    [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_dsm_clk }]

create_clock \
    -name     PLL1_DSMCLK \
    -period   $DSMCLK_PERIOD \
    -waveform $DSMCLK_WAVEFORM \
    [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll1_dsm_clk }]

############################################
# Full-rate and data-rate clocks.
############################################

##Select LN_${lane}_FULLRT_GEN5 as clock to generate fullrt and datart output clocks
#for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {
#   set lane_inst u_pma_rev/u_xcvr_$lane_map($lane)
#
#   create_clock \
#       -name     LN_${lane}_FULLRT_GEN5 \
#       -period   $CLK1000_PERIOD \
#       -waveform $CLK1000_WAVEFORM \
#       -add \
#       [get_pins ${lane_inst}/u_xcvr_ana/xcvrda_clk_fullrt]
#
#   # Address sinks not getting clocks
#   create_generated_clock \
#       -name           LN_${lane}_FULLRT_GEN5_DIV2 \
#       -divide_by      2 \
#       -master_clock   [get_clocks LN_${lane}_FULLRT_GEN5] \
#       -source         [get_pins ${lane_inst}/u_xcvr_ana/xcvrda_clk_fullrt] \
#       -add \
#       [get_pins  ${lane_inst}/u_xcvr_clkrst/u_clock_div_prog_xcvr_pll_div2_clk/u_clock_mux/$clk_mux_pin_1]
#
#   # DIV2 versions of xcvrda_clk_fullrt
#   create_generated_clock \
#       -name           LN_${lane}_FULLRT_DIV_GEN5 \
#       -divide_by      2 \
#       -master_clock   [get_clocks LN_${lane}_FULLRT_GEN5] \
#       -source         [get_pins ${lane_inst}/u_xcvr_ana/xcvrda_clk_fullrt] \
#       -add \
#       [get_pins ${lane_inst}/u_xcvr_clkrst/u_clock_div_prog_xcvr_pll_lock_det_fb_clk/u_clock_mux/${clk_mux_pin_1}]
#
#   # Suppress propagation of PLL_CLK_FULLRT_GEN5 because functionally clock is divided to 500MHz or less per Loren
#   # set_sense in 19.1 and beyond
#   if { [info exists load_syn_sdc] && $load_syn_sdc} { 
#      set_clock_sense \
#          -clocks [get_clocks LN_${lane}_FULLRT_GEN5] \
#          -stop_propagation \
#          [get_pins ${lane_inst}/u_xcvr_clkrst/u_clock_div_prog_xcvr_pll_lock_det_fb_clk/u_clock_mux/${clk_mux_out_pin}]
#   } else {
#      set_sense \
#          -clocks [get_clocks LN_${lane}_FULLRT_GEN5] \
#          -stop_propagation \
#          [get_pins ${lane_inst}/u_xcvr_clkrst/u_clock_div_prog_xcvr_pll_lock_det_fb_clk/u_clock_mux/${clk_mux_out_pin}]
#   }
#
#   create_generated_clock \
#       -name         LN_${lane}_FULLRT_GEN5_OUT \
#       -divide_by    1 \
#       -master_clock [get_clocks  LN_${lane}_FULLRT_GEN5 ] \
#       -source       [get_pins ${lane_inst}/u_xcvr_ana/xcvrda_clk_fullrt ] \
#       -add \
#       [get_ports xcvr_pll_clk_fullrt_ln_$lane]
#
#   create_generated_clock \
#       -name         LN_${lane}_DATART_GEN5_OUT \
#       -divide_by    1 \
#       -master_clock [get_clocks  LN_${lane}_FULLRT_GEN5 ] \
#       -source       [get_pins  ${lane_inst}/u_xcvr_ana/xcvrda_clk_fullrt ] \
#       -add \
#       [get_ports xcvr_pll_clk_datart_ln_$lane]
#}

############################################
# Full-rate and data-rate clocks.
############################################

#if { $do_usb4_gen3 } {

   # PLL0
   create_clock \
      -name     CMN_PLL0CLK0_GEN3 \
      -period   $CLK1250_PERIOD \
      -waveform $CLK1250_WAVEFORM \
      [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_clk_prog0  }]

   create_generated_clock \
      -name         CMN_PLL0CLK0_GEN3_OUT \
      -divide_by    1 \
      -master_clock [get_clocks { CMN_PLL0CLK0_GEN3 }] \
      -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_clk_prog0  }] \
      -add \
      [get_ports { cmn_pll0_clk_prog0 }]

   create_clock \
      -name     CMN_PLL0CLK1_GEN3 \
      -period   $CLK1250_PERIOD \
      -waveform $CLK1250_WAVEFORM \
      [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_clk_prog1  }]

   create_generated_clock \
      -name         CMN_PLL0CLK1_GEN3_OUT \
      -divide_by    1 \
      -master_clock [get_clocks { CMN_PLL0CLK1_GEN3 }] \
      -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_clk_prog1  }] \
      -add \
      [get_ports { cmn_pll0_clk_prog1 }]

   
   # PLL1
   # PLL1 only use for DP (raw serdes interface)
   create_clock \
      -name     CMN_PLL1CLK0_GEN3 \
      -period   $CLK1000_PERIOD \
      -waveform $CLK1000_WAVEFORM \
      [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll1_clk_prog0 }]

   create_generated_clock \
      -name         CMN_PLL1CLK0_GEN3_OUT \
      -divide_by    1 \
      -master_clock [get_clocks { CMN_PLL1CLK0_GEN3 }] \
      -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll1_clk_prog0 }] \
      -add \
      [get_ports { cmn_pll1_clk_prog0 }]

   create_clock \
      -name     CMN_PLL1CLK1_GEN3 \
      -period   $CLK1000_PERIOD \
      -waveform $CLK1000_WAVEFORM \
      [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll1_clk_prog1 }]

   create_generated_clock \
      -name         CMN_PLL1CLK1_GEN3_OUT \
      -divide_by    1 \
      -master_clock [get_clocks { CMN_PLL1CLK1_GEN3 }] \
      -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll1_clk_prog1 }] \
      -add \
      [get_ports { cmn_pll1_clk_prog1 }]

    
   #Select CMN_PLL0CLK0_GEN3 as clock to generate output clock, should not matter
   # Need to review MUX4 to determine if set_clock_sense is required
   for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {
      #set lane_inst u_pma_rev/u_xcvr_$lane_map($lane)

      create_generated_clock \
         -name         LN_${lane}_PLLCLK_FULLRT_GEN3_OUT_0 \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_PLL0CLK0_GEN3 }] \
         -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_clk_prog0 }] \
         -add \
         [get_ports xcvr_pll_clk_fullrt_ln_$lane]

      #add for USB3
      create_generated_clock \
         -name         LN_${lane}_PLLCLK_FULLRT_GEN3_OUT_1 \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_PLL0CLK1_GEN3 }] \
         -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_clk_prog1 }] \
         -add \
         [get_ports xcvr_pll_clk_fullrt_ln_$lane]   

     # create_generated_clock \
     #    -name         LN_${lane}_PLL0CLK_DATART0_GEN3 \
     #    -divide_by    1 \
     #    -master_clock [get_clocks { CMN_PLL0CLK0_GEN3 }] \
     #    -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_clk_prog0 }] \
     #    -add \
	 # [get_pins ${lane_inst}/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/RC_i_1/I0]

     # create_generated_clock \
     #    -name         LN_${lane}_PLL0CLK_DATART_GEN3_OUT \
     #    -divide_by    1 \
     #    -master_clock [get_clocks LN_${lane}_PLL0CLK_DATART0_GEN3] \
     #    -source       [get_pins ${lane_inst}/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/RC_i_1/I0] \
     #    -add \
     #    [get_ports xcvr_pll_clk_datart_ln_$lane]

   }

   #Lane0: Txonly lane0
   create_generated_clock \
         -name         LN_0_PLL0CLK0_DATART0_GEN3 \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_PLL0CLK0_GEN3 }] \
         -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_clk_prog0 }] \
         -add \
	  [get_pins u_pma_rev/u_xcvr_txm/u_xcvr_txonly0/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/clk_in[0]]

   create_generated_clock \
         -name         LN_0_PLL0CLK1_DATART0_GEN3 \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_PLL0CLK1_GEN3 }] \
         -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_clk_prog1 }] \
         -add \
	  [get_pins u_pma_rev/u_xcvr_txm/u_xcvr_txonly0/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/clk_in[0]]

   create_generated_clock \
         -name         LN_0_PLL0CLK0_DATART_GEN3_OUT \
         -divide_by    1 \
         -master_clock [get_clocks LN_0_PLL0CLK0_DATART0_GEN3] \
         -source       [get_pins u_pma_rev/u_xcvr_txm/u_xcvr_txonly0/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/clk_in[0]] \
         -add \
         [get_ports xcvr_pll_clk_datart_ln_0]

   create_generated_clock \
         -name         LN_0_PLL0CLK1_DATART_GEN3_OUT \
         -divide_by    1 \
         -master_clock [get_clocks LN_0_PLL0CLK1_DATART0_GEN3] \
         -source       [get_pins u_pma_rev/u_xcvr_txm/u_xcvr_txonly0/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/clk_in[0]] \
         -add \
         [get_ports xcvr_pll_clk_datart_ln_0]


   #Lane3 : Txonly lane1
   create_generated_clock \
         -name         LN_3_PLL0CLK0_DATART0_GEN3 \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_PLL0CLK0_GEN3 }] \
         -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_clk_prog0 }] \
         -add \
	  [get_pins u_pma_rev/u_xcvr_txm/u_xcvr_txonly1/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/clk_in[0]]

   create_generated_clock \
         -name         LN_3_PLL0CLK1_DATART0_GEN3 \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_PLL0CLK1_GEN3 }] \
         -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_clk_prog1 }] \
         -add \
	  [get_pins u_pma_rev/u_xcvr_txm/u_xcvr_txonly1/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/clk_in[0]]

   create_generated_clock \
         -name         LN_3_PLL0CLK0_DATART_GEN3_OUT \
         -divide_by    1 \
         -master_clock [get_clocks LN_3_PLL0CLK0_DATART0_GEN3] \
         -source       [get_pins u_pma_rev/u_xcvr_txm/u_xcvr_txonly1/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/clk_in[0]] \
         -add \
         [get_ports xcvr_pll_clk_datart_ln_3]

   create_generated_clock \
         -name         LN_3_PLL0CLK1_DATART_GEN3_OUT \
         -divide_by    1 \
         -master_clock [get_clocks LN_3_PLL0CLK1_DATART0_GEN3] \
         -source       [get_pins u_pma_rev/u_xcvr_txm/u_xcvr_txonly1/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/clk_in[0]] \
         -add \
         [get_ports xcvr_pll_clk_datart_ln_3]


   #Lane1 : Txrx lane 1
   create_generated_clock \
         -name         LN_1_PLL0CLK0_DATART0_GEN3 \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_PLL0CLK0_GEN3 }] \
         -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_clk_prog0 }] \
         -add \
	  [get_pins u_pma_rev/u_xcvr_txrxm_lane1/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/clk_in[0]]

   create_generated_clock \
         -name         LN_1_PLL0CLK1_DATART0_GEN3 \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_PLL0CLK1_GEN3 }] \
         -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_clk_prog1 }] \
         -add \
	  [get_pins u_pma_rev/u_xcvr_txrxm_lane1/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/clk_in[0]]

   create_generated_clock \
         -name         LN_1_PLL0CLK0_DATART_GEN3_OUT \
         -divide_by    1 \
         -master_clock [get_clocks LN_1_PLL0CLK0_DATART0_GEN3] \
         -source       [get_pins u_pma_rev/u_xcvr_txrxm_lane1/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/clk_in[0]] \
         -add \
         [get_ports xcvr_pll_clk_datart_ln_1]

   create_generated_clock \
         -name         LN_1_PLL0CLK1_DATART_GEN3_OUT \
         -divide_by    1 \
         -master_clock [get_clocks LN_1_PLL0CLK1_DATART0_GEN3] \
         -source       [get_pins u_pma_rev/u_xcvr_txrxm_lane1/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/clk_in[0]] \
         -add \
         [get_ports xcvr_pll_clk_datart_ln_1]


   #Lane2 : Txrx lane 2
   create_generated_clock \
         -name         LN_2_PLL0CLK0_DATART0_GEN3 \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_PLL0CLK0_GEN3 }] \
         -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_clk_prog0 }] \
         -add \
	  [get_pins u_pma_rev/u_xcvr_txrxm_lane2/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/clk_in[0]]

   create_generated_clock \
         -name         LN_2_PLL0CLK1_DATART0_GEN3 \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_PLL0CLK1_GEN3 }] \
         -source       [get_pins { u_pma_rev/u_cmn/u_cmn_ana/cmnda_pll0_clk_prog1 }] \
         -add \
	  [get_pins u_pma_rev/u_xcvr_txrxm_lane2/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/clk_in[0]]

   create_generated_clock \
         -name         LN_2_PLL0CLK0_DATART_GEN3_OUT \
         -divide_by    1 \
         -master_clock [get_clocks LN_2_PLL0CLK0_DATART0_GEN3] \
         -source       [get_pins u_pma_rev/u_xcvr_txrxm_lane2/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/clk_in[0]] \
         -add \
         [get_ports xcvr_pll_clk_datart_ln_2]

   create_generated_clock \
         -name         LN_2_PLL0CLK1_DATART_GEN3_OUT \
         -divide_by    1 \
         -master_clock [get_clocks LN_2_PLL0CLK1_DATART0_GEN3] \
         -source       [get_pins u_pma_rev/u_xcvr_txrxm_lane2/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/clk_in[0]] \
         -add \
         [get_ports xcvr_pll_clk_datart_ln_2]



#}; # End of do_usb4_gen3





############################################
# Lane PLL Reference clock
# No Lane PLL in Timberwolf
############################################
#for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {
#   set lane_inst u_pma_rev/u_xcvr_$lane_map($lane)
#   create_clock  \
#       -name           LN_${lane}_PLLLN_REF_CLK  \
#       -period         $CLKPLLN_PERIOD  \
#       -waveform       $CLKPLLN_WAVEFORM \
#       [get_pins ${lane_inst}/u_xcvr_ana/xcvrda_pllln_ref_clk]
#
#   create_generated_clock \
#       -name           LN_${lane}_PLLLN_REF_CLK_DIV2 \
#       -divide_by      2 \
#       -master_clock   [get_clocks LN_${lane}_PLLLN_REF_CLK ] \
#       -source         [get_pins ${lane_inst}/u_xcvr_ana/xcvrda_pllln_ref_clk ] \
#       -add \
#       [get_pins ${lane_inst}/u_xcvr_clkrst/u_clock_div_prog_xcvr_pll_lock_det_ref_clk/u_clock_mux/${clk_mux_pin_1}]
#
#   # Suppress propagation of PLLLN_REF_CLK because functionally clock is divided to 500MHz or less per Loren
#   # Note: This results in 664.0625MHz which exceeds 500MHz.
#   # set_sense in 19.1 and beyond
#   # SER-23418
#   set_sense \
#       -clocks [get_clocks LN_${lane}_PLLLN_REF_CLK ] \
#       -stop_propagation \
#       [get_pins ${lane_inst}/u_xcvr_clkrst/u_clock_div_prog_xcvr_pll_lock_det_ref_clk/u_clock_mux/${clk_mux_out_pin}]
#
#}

############################################
# Signal detect clocks
############################################
#for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {
#   set lane_inst u_pma_rev/u_xcvr_$lane_map($lane)
#
#   create_clock \
#       -name     LN_${lane}_SDCLK \
#       -period   $CLK625_PERIOD \
#       -waveform $CLK625_WAVEFORM \
#       [get_pins ${lane_inst}/u_xcvr_ana/int_rxda_sd_clk]
#
#}

#only txrx lane have sd clock (Lane1 and Lane2)
create_clock \
    -name     LN_1_SDCLK \
    -period   $CLK625_PERIOD \
    -waveform $CLK625_WAVEFORM \
    [get_pins u_pma_rev/u_xcvr_txrxm_lane1/u_xcvr_ana/rxda_sd_clk]

create_clock \
    -name     LN_2_SDCLK \
    -period   $CLK625_PERIOD \
    -waveform $CLK625_WAVEFORM \
    [get_pins u_pma_rev/u_xcvr_txrxm_lane2/u_xcvr_ana/rxda_sd_clk]

############################################
# Lane transmit (tx_td) clocks. 
############################################
#update the tx_td_clk from 1000M(whistle) to 1250M(timberwolf)

#for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {
#   create_clock \
#       -name     LN_${lane}_TXTDCLK_GEN5 \
#       -period   $CLK1000_PERIOD \
#       -waveform $CLK1000_WAVEFORM \
#       -add \
#       [get_ports tx_td_clk_ln_$lane]
#}

for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {
   create_clock \
       -name     LN_${lane}_TXTDCLK_GEN3 \
       -period   $CLK1250_PERIOD \
       -waveform $CLK1250_WAVEFORM \
       -add \
       [get_ports tx_td_clk_ln_$lane]
}


############################################
# Serializer clocks.
############################################
# Per Lync with Mark Hale, div-by-20 speced as 60% +/- 4% DC 
#                          div-by-16 speced as 50% +/- 4% DC

#for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {
#   set lane_inst u_pma_rev/u_xcvr_$lane_map($lane)
#
#   create_clock \
#       -name     LN_${lane}_TXCLK_GEN5 \
#       -period   $CLK1000_PERIOD \
#       -waveform $CLK1000_WAVEFORM \
#       -add \
#       [get_pins ${lane_inst}/u_xcvr_ana/int_txda_ser_clk] 
#
#}

#update the txda_ser_clk to 1250M
create_clock \
    -name     LN_0_TXCLK_GEN3 \
    -period   $CLK1250_PERIOD \
    -waveform $CLK1250_WAVEFORM \
    -add \
    [get_pins u_pma_rev/u_xcvr_txm/u_txm_ana/txda0_ser_clk] 

create_clock \
    -name     LN_3_TXCLK_GEN3 \
    -period   $CLK1250_PERIOD \
    -waveform $CLK1250_WAVEFORM \
    -add \
    [get_pins u_pma_rev/u_xcvr_txm/u_txm_ana/txda1_ser_clk] 

create_clock \
    -name     LN_1_TXCLK_GEN3 \
    -period   $CLK1250_PERIOD \
    -waveform $CLK1250_WAVEFORM \
    -add \
    [get_pins u_pma_rev/u_xcvr_txrxm_lane1/u_xcvr_ana/txda_ser_clk] 

create_clock \
    -name     LN_2_TXCLK_GEN3 \
    -period   $CLK1250_PERIOD \
    -waveform $CLK1250_WAVEFORM \
    -add \
    [get_pins u_pma_rev/u_xcvr_txrxm_lane2/u_xcvr_ana/txda_ser_clk] 


############################################
# Deserializer clocks
############################################

#for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {
#   set lane_inst u_pma_rev/u_xcvr_$lane_map($lane)
#
#   create_clock \
#       -name     LN_${lane}_RXCLK_GEN5 \
#       -period   $RXDPCLK_PERIOD \
#       -waveform $RXDPCLK_WAVEFORM \
#       -add \
#       [get_pins ${lane_inst}/u_xcvr_ana/int_rxda_des_clk]
#
#   #### JMY NEED TO UPDATE TO OTHER PROTOCOLS WHEN COMPLETE ####################################
#   # Address sinks not getting clocks
#   create_generated_clock \
#       -name           LN_${lane}_RXCLK_DIV2_GEN5 \
#       -divide_by      2 \
#       -master_clock   [get_clocks LN_${lane}_RXCLK_GEN5] \
#       -source         [get_pins ${lane_inst}/u_xcvr_ana/int_rxda_des_clk] \
#       -add \
#       [get_pins ${lane_inst}/u_xcvr_clkrst/u_clock_div_prog_rx_rd_div2_clk_cal/u_clock_mux/${clk_mux_pin_1}]
#   #### JMY NEED TO UPDATE TO OTHER PROTOCOLS WHEN COMPLETE ####################################
#
#   create_generated_clock \
#       -name         LN_${lane}_RXRDCLK_GEN5_OUT \
#       -divide_by    1 \
#       -master_clock [get_clocks LN_${lane}_RXCLK_GEN5] \
#       -source       [get_pins ${lane_inst}/u_xcvr_ana/int_rxda_des_clk] \
#       -add \
#       [get_ports rx_rd_clk_ln_$lane]
#}

create_clock \
    -name     LN_1_RXCLK_GEN3 \
    -period   $RXDPCLK_PERIOD \
    -waveform $RXDPCLK_WAVEFORM \
    -add \
    [get_pins u_pma_rev/u_xcvr_txrxm_lane1/u_xcvr_ana/rxda_des_clk]

create_generated_clock \
    -name         LN_1_RXRDCLK_GEN3_OUT \
    -divide_by    1 \
    -master_clock [get_clocks LN_1_RXCLK_GEN3] \
    -source       [get_pins u_pma_rev/u_xcvr_txrxm_lane1/u_xcvr_ana/rxda_des_clk] \
    -add \
    [get_ports rx_rd_clk_ln_1]

create_clock \
    -name     LN_2_RXCLK_GEN3 \
    -period   $RXDPCLK_PERIOD \
    -waveform $RXDPCLK_WAVEFORM \
    -add \
    [get_pins u_pma_rev/u_xcvr_txrxm_lane2/u_xcvr_ana/rxda_des_clk]

create_generated_clock \
    -name         LN_2_RXRDCLK_GEN3_OUT \
    -divide_by    1 \
    -master_clock [get_clocks LN_2_RXCLK_GEN3] \
    -source       [get_pins u_pma_rev/u_xcvr_txrxm_lane2/u_xcvr_ana/rxda_des_clk] \
    -add \
    [get_ports rx_rd_clk_ln_2]


############################################
# Misc Lane clocks.
############################################
############################################
# Cal Clocks
############################################

#for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {
#   set lane_inst u_pma_rev/u_xcvr_$lane_map($lane)
#
#   ############################################
#   # Duty Cycle Correction clock
#   ############################################
#   create_clock \
#       -name     LN_${lane}_DC_CALCLK \
#       -period   $CLK156P25_PERIOD \
#       -waveform $CLK156P25_WAVEFORM \
#       [get_pins ${lane_inst}/u_xcvr_ana/txda_dc_cal_clk]
#
#   ############################################
#   # Receive gear box clock
#   ############################################
#   create_clock \
#       -name     LN_${lane}_GB_CLK \
#       -period   $CLK1250_PERIOD \
#       -waveform $CLK1250_WAVEFORM \
#       -add \
#       [get_pins ${lane_inst}/u_xcvr_ana/rxda_gb_clk]
#
#   create_generated_clock \
#       -name         LN_${lane}_GB_CLK_OUT \
#       -divide_by    1 \
#       -master_clock [get_clocks LN_${lane}_GB_CLK] \
#       -source       [get_pins ${lane_inst}/u_xcvr_ana/rxda_gb_clk] \
#       -add \
#       [get_ports rx_gb_clk_ln_$lane]
#
#
#   ############################################
#   # Receive clock phase alignment cal clock
#   ############################################
#   create_clock \
#       -name     LN_${lane}_DCC_QEC_CAL_CLK \
#       -period   $CLK156P25_PERIOD \
#       -waveform $CLK156P25_WAVEFORM \
#       -add \
#       [get_pins ${lane_inst}/u_xcvr_ana/rxda_dcc_qec_cal_clk]
#
#   ############################################
#   # Receive E/D clock phase alignment cal clock
#   ############################################
#   create_clock \
#       -name     LN_${lane}_PHASE_ALIGN_DET_CLK \
#       -period   $CLK644_PERIOD \
#       -waveform $CLK644_WAVEFORM \
#       -add \
#       [get_pins ${lane_inst}/u_xcvr_ana/rxda_dfe_phase_align_det_clk]
#
#}

############################################
# Boundary scan clocks
############################################
## XCVRs
for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {

   create_clock \
       -name     LN_${lane}_TX_BSCAN_CLOCKDR \
       -period   $BSCAN_PERIOD \
       -waveform $BSCAN_WAVEFORM \
       [get_ports tx_bscan_clockdr_ln_${lane}]

   create_clock \
       -name     LN_${lane}_TX_BSCAN_UPDATEDR \
       -period   $BSCAN_PERIOD \
       -waveform $BSCAN_WAVEFORM \
       [get_ports tx_bscan_updatedr_ln_${lane}]

#   create_clock \
#       -name     LN_${lane}_RX_BSCAN_CLOCKDR \
#       -period   $BSCAN_PERIOD \
#       -waveform $BSCAN_WAVEFORM \
#       [get_ports rx_bscan_clockdr_ln_${lane}]
#
#   create_clock \
#       -name     LN_${lane}_RX_BSCAN_PC \
#       -period   $BSCAN_PERIOD \
#       -waveform $BSCAN_WAVEFORM \
#       [get_ports rx_bscan_pc_ln_${lane}]

}

create_clock \
    -name     LN_1_RX_BSCAN_CLOCKDR \
    -period   $BSCAN_PERIOD \
    -waveform $BSCAN_WAVEFORM \
    [get_ports rx_bscan_clockdr_ln_1]

create_clock \
    -name     LN_2_RX_BSCAN_CLOCKDR \
    -period   $BSCAN_PERIOD \
    -waveform $BSCAN_WAVEFORM \
    [get_ports rx_bscan_clockdr_ln_2]    

create_clock \
    -name     LN_1_RX_BSCAN_PC \
    -period   $BSCAN_PERIOD \
    -waveform $BSCAN_WAVEFORM \
    [get_ports rx_bscan_pc_ln_1]

create_clock \
    -name     LN_2_RX_BSCAN_PC \
    -period   $BSCAN_PERIOD \
    -waveform $BSCAN_WAVEFORM \
    [get_ports rx_bscan_pc_ln_2]


## CMN
#create_clock                                                \
#    -name           CMN_REF_CLK0_BSCAN_CLOCKDR              \
#    -period         $BSCAN_PERIOD                           \
#    -waveform       $BSCAN_WAVEFORM                         \
#    [get_ports cmn_ref_clk0_bscan_clockdr]
#
#create_clock                                                \
#    -name           CMN_REF_CLK1_BSCAN_CLOCKDR              \
#    -period         $BSCAN_PERIOD                           \
#    -waveform       $BSCAN_WAVEFORM                         \
#    [get_ports cmn_ref_clk1_bscan_clockdr]
#
#create_clock                                                \
#    -name           CMN_REF_CLK0_BSCAN_PC                   \
#    -period         $BSCAN_PERIOD                           \
#    -waveform       $BSCAN_WAVEFORM                         \
#    [get_ports cmn_ref_clk0_bscan_pc]
#
#create_clock                                                \
#    -name           CMN_REF_CLK1_BSCAN_PC                   \
#    -period         $BSCAN_PERIOD                           \
#    -waveform       $BSCAN_WAVEFORM                         \
#    [get_ports cmn_ref_clk1_bscan_pc]


############################################
# Misc clocks
############################################

# Virtual asynchronous clock phase. This phase is excluded from all other clocks.
create_clock \
    -name     IO_ASYNC \
    -period   $ASYNC_PERIOD \
    -waveform $ASYNC_WAVEFORM


###############################################################################
# Clock groups
###############################################################################

#SER-23420
for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {set_clock_groups -async -name grp_cdb_LN_${lane} -group [get_clocks  LN_${lane}_CDBCLK ]}
set_clock_groups -async -name grp_cdb      -group [get_clocks { CMN_CDBCLK }]

set_clock_groups -async -name grp_bscan    -group [get_clocks { *BSCAN_CLOCKDR *BSCAN_UPDATEDR }]
set_clock_groups -async -name grp_bscan_pc -group [get_clocks { *BSCAN_PC }]
set_clock_groups -async -name grp_async    -group [get_clocks { IO_ASYNC }]
set_clock_groups -async -name grp_lfps     -group [get_clocks { *SDCLK }]
set_clock_groups -async -name grp_txtd     -group [get_clocks { *TXTDCLK* }]
set_clock_groups -async -name grp_mom      -group [get_clocks { CMN_MOM_OSC_CLK }]
set_clock_groups -async -name grp_tmpsns   -group [get_clocks { CMN_TMPSNS_CLK}]
#set_clock_groups -async -name grp_pllln    -group [get_clocks { LN_*_PLLLN_* }]

#set_clock_groups -async -name grp_pllfb    -group [get_clocks { PLL*_FBCLK }]
#set_clock_groups -async -name grp_pllref   -group [get_clocks { PLL*_REFCLK }]
set_clock_groups -async -name grp_pllfb    -group [get_clocks { PLL0_FBCLK }]
set_clock_groups -async -name grp_pllref   -group [get_clocks { PLL0_REFCLK }]

#set_clock_groups -async -name grp_plldsm   -group [get_clocks { PLL*_DSMCLK }]
set_clock_groups -async -name grp_plldsm0   -group [get_clocks { PLL0_DSMCLK }]
set_clock_groups -async -name grp_plldsm1   -group [get_clocks { PLL1_DSMCLK }]

#set_clock_groups -async -name grp_pll0prg0 -group  [get_clocks { PLL0_CLK_PROG0 }]
#set_clock_groups -async -name grp_pll0prg1 -group  [get_clocks { PLL0_CLK_PROG1 }]
#set_clock_groups -async -name grp_pll1prg0 -group  [get_clocks { PLL1_CLK_PROG0 }]
#set_clock_groups -async -name grp_pll1prg1 -group  [get_clocks { PLL1_CLK_PROG1 }]
set_clock_groups -async -name grp_pll0prg0 -group  [get_clocks { CMN_PLL0CLK0_GEN3 }]
set_clock_groups -async -name grp_pll0prg1 -group  [get_clocks { CMN_PLL0CLK1_GEN3 }]
set_clock_groups -async -name grp_pll1prg0 -group  [get_clocks { CMN_PLL1CLK0_GEN3 }]
set_clock_groups -async -name grp_pll1prg1 -group  [get_clocks { CMN_PLL1CLK1_GEN3 }]


set_clock_groups -async -name grp_psmclk   -group [get_clocks { *_PSM* }]
set_clock_groups -async -name grp_pcmclk   -group [get_clocks { *_PCM* }]
#set_clock_groups -async -name grp_rate     -group [get_clocks { *FULLRT* *DATART* }]

set_clock_groups -async -name grp_ref      -group [get_clocks { REFCLK* }]

#set_clock_groups -async -name grp_cal      -group [get_clocks { LN_*_DC_CALCLK }]
#set_clock_groups -async -name grp_gb       -group [get_clocks { LN_*_GB_CLK* }]
#set_clock_groups -async -name grp_dcc      -group [get_clocks { LN_*_DCC_QEC_CAL_CLK }]
#set_clock_groups -async -name grp_phase    -group [get_clocks { LN_*_PHASE_ALIGN_DET_CLK }]

#set_clock_groups -async -name grp_rx_rx2x   -group [get_clocks *RXCLK_*] \
    #                                            -group [get_clocks *RXCLK2X_*]

set_clock_groups -async -name grp_rx   -group [get_clocks { *RXCLK_* }] 

set_clock_groups -async -name grp_pll01 \
    -group [get_clocks { *PLL0* }] \
    -group [get_clocks { *PLL1* }]

# Removed *_RXCLK2X_*
if { !$do_libgen } {
   set_clock_groups -async -name grp_txrx \
       -group [get_clocks { *_TXCLK_* }] \
       -group [get_clocks { *_RXCLK_* *_RXRDCLK_* }]
} else {
   set_clock_groups -async -name grp_txrx \
       -group [get_clocks { *_TXCLK_* }] \
       -group [get_clocks { *_RXCLK_* *_RXRDCLK_* }]
}

#set_clock_groups -physically_exclusive -name grp_std_pe -group [get_clocks { *GEN5* }]
set_clock_groups -physically_exclusive -name grp_std_pe -group [get_clocks { *GEN3* }]

###############################################################################
# Clock uncertainty
###############################################################################
set_clock_uncertainty $setup_margin -setup -from [all_clocks] -to [all_clocks]
set_clock_uncertainty $hold_margin  -hold  -from [all_clocks] -to [all_clocks]


###############################################################################
# Mixed edge clocks with extra uncertainty for DC 
###############################################################################
# 45-55 duty cycle as per SER-23498 which came AFTER SER-22287.

#### Blanket statement to find potential outliers
set_clock_uncertainty 42 -setup -rise_from [all_clocks] -fall_to [all_clocks]
set_clock_uncertainty 42 -setup -fall_from [all_clocks] -rise_to [all_clocks]


#PLL0_DSMCLK PLL1_DSMCLK
set dsm_clk_grp [get_clocks {PLL0_DSMCLK PLL1_DSMCLK }]
set dsm_mixed_setup_uncertainty [expr {$setup_margin} + 0.05 * $DSMCLK_PERIOD]

set_clock_uncertainty $dsm_mixed_setup_uncertainty -setup -rise_from $dsm_clk_grp -fall_to $dsm_clk_grp
set_clock_uncertainty $dsm_mixed_setup_uncertainty -setup -fall_from $dsm_clk_grp -rise_to $dsm_clk_grp


#LN_*_TXCLK_GEN5
#set txtd_clk_grp [get_clocks {LN_*_TXCLK_GEN5}]
#set txtd_mixed_setup_uncertainty [expr {$setup_margin} + 0.05 * $CLK1000_PERIOD ]
set txtd_clk_grp [get_clocks {LN_*_TXCLK_GEN3}]
set txtd_mixed_setup_uncertainty [expr {$setup_margin} + 0.05 * $CLK1250_PERIOD ]

set_clock_uncertainty $txtd_mixed_setup_uncertainty -setup -rise_from $txtd_clk_grp -fall_to $txtd_clk_grp
set_clock_uncertainty $txtd_mixed_setup_uncertainty -setup -fall_from $txtd_clk_grp -rise_to $txtd_clk_grp


# BSCAN 100MHz 40-60 @10ns period
#set_clock_uncertainty [expr $setup_dc_margin + 1.000] -setup -rise_from [get_clocks {CMN_REF_CLK1_BSCAN_CLOCKDR}] -fall_to   [get_clocks {CMN_REF_CLK1_BSCAN_CLOCKDR}]
#set_clock_uncertainty [expr $setup_dc_margin + 1.000] -setup -fall_to   [get_clocks {CMN_REF_CLK1_BSCAN_CLOCKDR}] -rise_from [get_clocks {CMN_REF_CLK1_BSCAN_CLOCKDR}]
#
#set_clock_uncertainty [expr $setup_dc_margin + 1.000] -setup -rise_from [get_clocks {CMN_REF_CLK0_BSCAN_CLOCKDR}] -fall_to   [get_clocks {CMN_REF_CLK0_BSCAN_CLOCKDR}]
#set_clock_uncertainty [expr $setup_dc_margin + 1.000] -setup -fall_to   [get_clocks {CMN_REF_CLK0_BSCAN_CLOCKDR}] -rise_from [get_clocks {CMN_REF_CLK0_BSCAN_CLOCKDR}]
#
#set_clock_uncertainty [expr $setup_dc_margin + 1.000] -setup -rise_from [get_clocks {CMN_REF_CLK0_BSCAN_PC}] -fall_to   [get_clocks {CMN_REF_CLK0_BSCAN_PC}]
#set_clock_uncertainty [expr $setup_dc_margin + 1.000] -setup -fall_to   [get_clocks {CMN_REF_CLK0_BSCAN_PC}] -rise_from [get_clocks {CMN_REF_CLK0_BSCAN_PC}]
#
#set_clock_uncertainty [expr $setup_dc_margin + 1.000] -setup -rise_from [get_clocks {CMN_REF_CLK1_BSCAN_PC}] -fall_to   [get_clocks {CMN_REF_CLK1_BSCAN_PC}]
#set_clock_uncertainty [expr $setup_dc_margin + 1.000] -setup -fall_to   [get_clocks {CMN_REF_CLK1_BSCAN_PC}] -rise_from [get_clocks {CMN_REF_CLK1_BSCAN_PC}]

#####################################################################
# Add setup and hold uncertainty to the FIFO read reset paths to 
# account for serializer clock skew between Lanes. 
#####################################################################

set rd_setup_margin [expr $setup_margin + $serclk_skew]
set rd_hold_margin  [expr $hold_margin  + $serclk_skew]

set_clock_uncertainty $rd_setup_margin -setup -from [get_clocks LN_*_TXCLK_*] -to [get_clocks LN_*_TXCLK_*]
set_clock_uncertainty $rd_hold_margin  -hold  -from [get_clocks LN_*_TXCLK_*] -to [get_clocks LN_*_TXCLK_*]

## Reset the setup and hold uncertainty for same lane setup/hold paths since
## the above only applies to inter-lane transfers, not intra-lane transfers.
for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {
   set_clock_uncertainty $setup_margin -setup -from [get_clocks LN_${lane}_TXCLK_*] -to [get_clocks LN_${lane}_TXCLK_*]
   set_clock_uncertainty $hold_margin  -hold  -from [get_clocks LN_${lane}_TXCLK_*] -to [get_clocks LN_${lane}_TXCLK_*]
}


#####################################################################
# Add setup and hold uncertainty to the FIFO write reset paths to 
# account for TXTD clock skew between Lanes.
#####################################################################
set wr_setup_margin [expr $setup_margin + $txtdclk_skew]
set wr_hold_margin  [expr $hold_margin  + $txtdclk_skew]

set_clock_uncertainty $wr_setup_margin -setup -from [get_clocks LN_*_TXTDCLK_*] -to [get_clocks LN_*_TXTDCLK_*]
set_clock_uncertainty $wr_hold_margin  -hold  -from [get_clocks LN_*_TXTDCLK_*] -to [get_clocks LN_*_TXTDCLK_*]

# Reset the setup and hold uncertainty for same lane setup/hold paths since 
# the above only applies to inter-lane transfers, not intra-lane transfers.
for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {
   set_clock_uncertainty $setup_margin -setup -from [get_clocks LN_${lane}_TXTDCLK_*] -to [get_clocks LN_${lane}_TXTDCLK_*]
   set_clock_uncertainty $hold_margin  -hold  -from [get_clocks LN_${lane}_TXTDCLK_*] -to [get_clocks LN_${lane}_TXTDCLK_*]
}


#####################################################################
# Add setup and hold uncertainty to account for skew across the 
# PMA's PSMCLK inputs to the CMN and Lane.
#####################################################################
set psm_setup_margin [expr $setup_margin + $psmclk_skew]
set psm_hold_margin  [expr $hold_margin  + $psmclk_skew]

set_clock_uncertainty $psm_setup_margin -setup -from [get_clocks CMN_PSMCLK_IN] -to [get_clocks LN_*_PSMCLK]
set_clock_uncertainty $psm_setup_margin -setup -from [get_clocks LN_*_PSMCLK]   -to [get_clocks CMN_PSMCLK_IN]
set_clock_uncertainty $psm_setup_margin -setup -from [get_clocks LN_*_PSMCLK]   -to [get_clocks LN_*_PSMCLK]

set_clock_uncertainty $psm_hold_margin  -hold  -from [get_clocks CMN_PSMCLK_IN] -to [get_clocks LN_*_PSMCLK]
set_clock_uncertainty $psm_hold_margin  -hold  -from [get_clocks LN_*_PSMCLK]   -to [get_clocks CMN_PSMCLK_IN]
set_clock_uncertainty $psm_hold_margin  -hold  -from [get_clocks LN_*_PSMCLK]   -to [get_clocks LN_*_PSMCLK]

# Reset the setup and hold uncertainty for same-lane setup/hold paths since 
# the above only applies to inter-lane transfers, not intra-lane transfers.
for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {
   set_clock_uncertainty $setup_margin -setup -from [get_clocks LN_${lane}_PSMCLK] -to [get_clocks LN_${lane}_PSMCLK]
   set_clock_uncertainty $hold_margin  -hold  -from [get_clocks LN_${lane}_PSMCLK] -to [get_clocks LN_${lane}_PSMCLK]
}

# Account for calibration overshoot of frequency on rx_rd_clk for RX PI ILL calibration : 500MHz vs 562.5MHz (2ns vs 1.777ns)
# SER-22142 Maximum clock frequency durring PI ILL calibration
#set rx_pi_ill_setup_margin [expr 0.223 + $setup_margin]
#for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {
#   set_clock_uncertainty $rx_pi_ill_setup_margin -setup -from [get_clocks LN_${lane}_RXCLK_DIV2_*] -to [get_clocks LN_${lane}_RXCLK_DIV2_*]
#}

#Add following to avoid BSCAN_UPDATEDR to BSCAN_CLOCKDR holds
set_clock_uncertainty 0.0 -hold [get_pins -hier { *TDO_net_reg/CP }]

# Reduce uncertainty for MTBF flops.
#set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_u_reset_sync_synth_2_2/CP }]

###############################################################################
# Transitions
###############################################################################
#::tech::set_transitions
if { [info exists load_syn_sdc] && $load_syn_sdc} {
    set_max_transition   $max_trans [current_design]
    set_max_transition   $max_trans [all_inputs]
    set_max_transition   $max_trans [all_outputs]
    set_clock_transition $max_clk_trans [all_clocks]
} else {
::tech::set_transitions
}


###############################################################################
# I/O delay
###############################################################################

############################################
# Analog, asynchronous and constant ports
############################################
#Listed as found in Section 2 of the Whistler32G PMA spec

#rx_m_ln_*
#rx_p_ln_*
#xcvr_flyover_en_ln_*
#xcvr_flyover_rxtermen_ln_*
#xcvr_flyover_scanout_ln_*
#cmn_ref_clk0_term_en
#cmn_ref_clk1_term_en
#cmn_ref_clk0_rcv_en
#cmn_ref_clk1_rcv_en


set async_inputs [get_ports {
   xcvr_m_ln_1
   xcvr_p_ln_1
   xcvr_m_ln_2
   xcvr_p_ln_2
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
   xcvr_lane_suspend_ln_*
   xcvr_link_reset_n_ln_*
   xcvr_standard_mode_ln_*[*]
   xcvr_data_width_ln_*[*]
   rx_sig_det_en_ext_ln_*
   tx_cmn_mode_en_ext_ln_*
   xcvr_pll_clk_en_ln_*
   xcvr_cdb_preset_n_ln_*
   tx_reset_n_ln_*
   rx_reset_n_ln_*
   xcvr_lpbk_serial_en_ln_*
   xcvr_lpbk_fe_parallel_en_ln_*
   xcvr_lpbk_line_en_ln_*
   xcvr_lpbk_recovered_clk_en_ln_*
   tx_differential_invert_ln_*
   tx_rcv_detect_en_ln_*
   tx_deemphasis_ln_*[*]
   tx_get_local_preset_coef_ln_*
   tx_get_local_init_coef_ln_*
   tx_local_preset_index_ln_*[*]
   tx_vmargin_ln_*[*]
   tx_low_power_swing_en_ln_*
   rx_termination_ln_*
   rx_eq_training_data_valid_ln_*
   rx_differential_invert_ln_*
   cmn_scanmode
   cmn_scanen
   cmn_scanen_cg
   cmn_scan_pll_ats
   cmn_scanin[*]
   xcvr_scanmode_ln_*
   xcvr_scanen_ln_*
   xcvr_scanen_cg_ln_*
   xcvr_scanin_ln_*[*]
   cmn_bscan_mode_en
   xcvr_bscan_mode_en_ln_*
   tx_bscan_mode_c_ln_*
   tx_bscan_acpulse_ln_*
   tx_bscan_ac_ln_*
   rx_bscan_ac_ln_*
}]

#cmn_avdd_clk_pwrgood
#xcvr_flyover_scanin_ln_*
#cmn_ref_clk_der

set async_outputs [get_ports {
   xcvr_m_ln_0
   xcvr_p_ln_0
   xcvr_m_ln_1
   xcvr_p_ln_1
   xcvr_m_ln_2
   xcvr_p_ln_2
   xcvr_m_ln_3
   xcvr_p_ln_3
   cmn_rext
   cmn_avdd_pwrgood
   cmn_pll0_locked
   cmn_pll1_locked
   cmn_atb_core_*
   xcvr_pll_clk_en_ack_ln_*
   tx_rcv_detect_done_ln_*
   tx_rcv_detected_ln_*
   tx_local_tx_coef_valid_ln_*
   tx_local_tx_preset_coef_ln_*[*]
   tx_local_fs_ln_*[*]
   tx_local_lf_ln_*[*]
   rx_signal_detect_ln_*
   rx_cdrlf_fphl_locked_ln_*
   cmn_scanclk_pll0_prog0_ats_out
   cmn_scanclk_pll0_prog1_ats_out
   cmn_scanclk_pll1_prog0_ats_out
   cmn_scanclk_pll1_prog1_ats_out
   cmn_scanout[*]
   xcvr_scanout_ln_*[*]
}]

foreach_in_collection pma_port $async_inputs {
   set port_name [get_object $pma_port]
   set_input_delay 0.0 -max -add -clock [get_clocks { IO_ASYNC }] $port_name
}

############################################
# Reference clocks
############################################

set refclk_outputs [get_ports {
   cmn_ref_clk_active
   cmn_ready
   cmn_macro_suspend_ack
   cmn_pll0_ready
   cmn_pll0_suspend_ack
   cmn_pll0_disabled
   cmn_pll1_ready
   cmn_pll1_suspend_ack
   cmn_pll1_disabled
}]

# Source-synchronous signals.
# Set I/O timing to 2/3 clock period.
set ref_value  [expr round(($CLK156P25_PERIOD * 1.0 / 3.0) * 100) / 100.0]

foreach_in_collection pma_port $refclk_outputs {
   set port_name [get_object $pma_port]
   #set_output_delay $ref_value  -max -add -clock [get_clocks { REFCLK_OUT }] $port_name
   #set_output_delay $ref_value  -max -add -clock [get_clocks { REFCLK_GATED_OUT }] $port_name
   set_output_delay $ref_value  -max -add -clock [get_clocks { REFCLK_OUT_0 }] $port_name
   set_output_delay $ref_value  -max -add -clock [get_clocks { REFCLK_GATED_OUT_0 }] $port_name

   set_output_delay $ref_value  -max -add -clock [get_clocks { REFCLK_OUT_1 }] $port_name
   set_output_delay $ref_value  -max -add -clock [get_clocks { REFCLK_GATED_OUT_1 }] $port_name

   # Create hold arcs in Liberty models
   if { $do_libgen } {
      #set_output_delay 0.0 -min -add -clock [get_clocks { REFCLK_OUT }] $port_name
      #set_output_delay 0.0 -min -add -clock [get_clocks { REFCLK_GATED_OUT }] $port_name
      set_output_delay 0.0 -min -add -clock [get_clocks { REFCLK_OUT_0 }] $port_name
      set_output_delay 0.0 -min -add -clock [get_clocks { REFCLK_GATED_OUT_0 }] $port_name

      set_output_delay 0.0 -min -add -clock [get_clocks { REFCLK_OUT_1 }] $port_name
      set_output_delay 0.0 -min -add -clock [get_clocks { REFCLK_GATED_OUT_1 }] $port_name
   }
}

#############################################
## PSM
#############################################

# Need to adjust I/O timing for WC clock latency.
if { $::timeMode == "prop" } {
   set psm_latency  0.400
} else {
   set psm_latency  0.0
}

# Set I/O timing to 2/3 clock period.
set psm_value  [expr round(($CLK156P25_PERIOD * 1.0 / 3.0) * 100) / 100.0]
set psm_indly  [expr $psm_value + $psm_latency]
set psm_outdly [expr $psm_value - $psm_latency]

for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {

   set psmclk [get_clocks LN_${lane}_PSMCLK]
   set_input_delay  $psm_value -max -add -clock $psmclk [get_ports xcvr_power_state_req_ln_${lane}[*]]
   set_output_delay $psm_value -max -add -clock $psmclk [get_ports xcvr_power_state_ack_ln_${lane}[*]]
   set_output_delay $psm_value -max -add -clock $psmclk [get_ports xcvr_psm_ready_ln_${lane}]
   set_output_delay $psm_value -max -add -clock $psmclk [get_ports xcvr_psm_state_ln_${lane}[*]]

   # Create hold arcs in Liberty models
   if { $do_libgen } {
      set_input_delay  0.0 -min -add -clock $psmclk [get_ports xcvr_power_state_req_ln_${lane}[*]]
      set_output_delay 0.0 -min -add -clock $psmclk [get_ports xcvr_power_state_ack_ln_${lane}[*]]
      set_output_delay 0.0 -min -add -clock $psmclk [get_ports xcvr_psm_ready_ln_${lane}]
      set_output_delay 0.0 -min -add -clock $psmclk [get_ports xcvr_psm_state_ln_${lane}[*]]
   }
}

############################################
# Transmitter
############################################

# Need to adjust I/O timing for WC clock latency.
if { $::timeMode == "prop" } {
   #set txclk_latency  0.200 TODO
   set txclk_latency  0.100
} else {
   set txclk_latency  0.0
}

# Set I/O timing to 2/3 clock period.
#set gen5_value  [expr round(($CLK1000_PERIOD * 1.0 / 3.0) * 100) / 100.0]
#set txclk_gen5_indly  [expr $gen5_value + $txclk_latency]
#set txclk_gen5_outdly  [expr $gen5_value + $txclk_latency]
set gen3_value  [expr round(($CLK1250_PERIOD * 1.0 / 3.0) * 100) / 100.0]
set txclk_gen3_indly  [expr $gen3_value + $txclk_latency]
set txclk_gen3_outdly  [expr $gen3_value + $txclk_latency]

for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {

   #set txclk [get_clocks LN_${lane}_TXTDCLK_GEN5]
   set txclk [get_clocks LN_${lane}_TXTDCLK_GEN3]
   set_input_delay  $txclk_gen3_indly  -max -add -clock $txclk [get_ports tx_sfifo_align_bump_in_ln_${lane}] 
   set_output_delay $txclk_gen3_outdly -max -add -clock $txclk [get_ports tx_sfifo_align_bump_out_ln_${lane}]
   set_input_delay  $txclk_gen3_indly  -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_in_ln_${lane}]
   set_output_delay $txclk_gen3_outdly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_out_ln_${lane}]
   set_input_delay  $txclk_gen3_indly  -max -add -clock $txclk [get_ports tx_elec_idle_ln_${lane}]
   set_input_delay  $txclk_gen3_indly  -max -add -clock $txclk [get_ports tx_td_ln_${lane}[*]]
   set_input_delay  $txclk_gen3_indly  -max -add -clock $txclk [get_ports tx_bist_hold_ln_${lane}]

   # Create hold arcs in Liberty models.
   if { $do_libgen } {
      #set txclk [get_clocks LN_${lane}_TXTDCLK_GEN5]
      set txclk [get_clocks LN_${lane}_TXTDCLK_GEN3]
      set_input_delay  0.0 -min -add -clock $txclk [get_ports tx_sfifo_align_bump_in_ln_${lane}] 
      set_output_delay 0.0 -min -add -clock $txclk [get_ports tx_sfifo_align_bump_out_ln_${lane}]
      set_input_delay  0.0 -min -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_in_ln_${lane}]
      set_output_delay 0.0 -min -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_out_ln_${lane}]
      set_input_delay  0.0 -min -add -clock $txclk [get_ports tx_elec_idle_ln_${lane}]
      set_input_delay  0.0 -min -add -clock $txclk [get_ports tx_td_ln_${lane}[*]]
      set_input_delay  0.0 -min -add -clock $txclk [get_ports tx_bist_hold_ln_${lane}]
   }

}; # End of lane loop

############################################
# Receiver
############################################

# Source-synchronous signals.
# Set I/O timing to 2/3 clock period.
#set gen5_value       [expr round(($CLK1000_PERIOD * 1.0 / 3.0) * 100) / 100.0]
set gen3_value       [expr round(($CLK1250_PERIOD * 1.0 / 3.0) * 100) / 100.0]

#for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {

#only have lane1/lane2 for rx
for { set lane 1 } { $lane < 3 } { incr lane 1 } {

   #set rxclk [get_clocks LN_${lane}_RXCLK_GEN5]
   set rxclk [get_clocks LN_${lane}_RXCLK_GEN3]
   set_output_delay $gen3_value -max -add -clock $rxclk [get_ports rx_rd_ln_${lane}]
   set_output_delay $gen3_value -max -add -clock $rxclk [get_ports rx_bist_status_ln_${lane}]
   set_output_delay $gen3_value -max -add -clock $rxclk [get_ports rx_bist_err_toggle_ln_${lane}]
   set_output_delay $gen3_value -max -add -clock $rxclk [get_ports rx_bist_sync_ln_${lane}]

   # Create hold arcs in Liberty models.
   if { $do_libgen } {
      set rxclk [get_clocks LN_${lane}_RXCLK_GEN5]
      set_output_delay 0.0 -min -add -clock $rxclk [get_ports rx_rd_ln_${lane}]
      set_output_delay 0.0 -min -add -clock $rxclk [get_ports rx_bist_status_ln_${lane}]
      set_output_delay 0.0 -min -add -clock $rxclk [get_ports rx_bist_err_toggle_ln_${lane}]
      set_output_delay 0.0 -min -add -clock $rxclk [get_ports rx_bist_sync_ln_${lane}]
   }

}; # End of lane loop

############################################
# CDB
############################################

# Need to adjust I/O timing for WC clock latency.
if { $::timeMode == "prop" } {
   #set pclk_latency  0.500 //TODO
   set pclk_latency  0.100 
} else {
   set pclk_latency  0.0
}

# Set I/O timing to 2/3 clock period.
set cdb_value [expr round(($CLK500_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set pclk_indly  [expr $cdb_value + $pclk_latency]
set pclk_outdly [expr $cdb_value - $pclk_latency]

set_input_delay  $pclk_indly  -max -add -clock [get_clocks { CMN_CDBCLK }] [get_ports { cmn_cdb_penable }]
set_input_delay  $pclk_indly  -max -add -clock [get_clocks { CMN_CDBCLK }] [get_ports { cmn_cdb_psel }]
set_input_delay  $pclk_indly  -max -add -clock [get_clocks { CMN_CDBCLK }] [get_ports { cmn_cdb_paddr[*] }]
set_input_delay  $pclk_indly  -max -add -clock [get_clocks { CMN_CDBCLK }] [get_ports { cmn_cdb_pwrite }]
set_input_delay  $pclk_indly  -max -add -clock [get_clocks { CMN_CDBCLK }] [get_ports { cmn_cdb_pwdata[*] }]
set_output_delay $pclk_outdly -max -add -clock [get_clocks { CMN_CDBCLK }] [get_ports { cmn_cdb_prdata[*] }]
set_output_delay $pclk_outdly -max -add -clock [get_clocks { CMN_CDBCLK }] [get_ports { cmn_cdb_pready }]

# Create hold arcs in Liberty models.
if { $do_libgen } {
   set_input_delay  0.0  -min -add -clock [get_clocks { CMN_CDBCLK }] [get_ports { cmn_cdb_penable }]
   set_input_delay  0.0  -min -add -clock [get_clocks { CMN_CDBCLK }] [get_ports { cmn_cdb_psel }]
   set_input_delay  0.0  -min -add -clock [get_clocks { CMN_CDBCLK }] [get_ports { cmn_cdb_paddr[*] }]
   set_input_delay  0.0  -min -add -clock [get_clocks { CMN_CDBCLK }] [get_ports { cmn_cdb_pwrite }]
   set_input_delay  0.0  -min -add -clock [get_clocks { CMN_CDBCLK }] [get_ports { cmn_cdb_pwdata[*] }]
   set_output_delay 0.0  -min -add -clock [get_clocks { CMN_CDBCLK }] [get_ports { cmn_cdb_prdata[*] }]
   set_output_delay 0.0  -min -add -clock [get_clocks { CMN_CDBCLK }] [get_ports { cmn_cdb_pready }]
}

for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {

   set_input_delay  $pclk_indly  -max -add -clock [get_clocks  LN_${lane}_CDBCLK ] [get_ports xcvr_cdb_penable_ln_${lane} ]
   set_input_delay  $pclk_indly  -max -add -clock [get_clocks  LN_${lane}_CDBCLK ] [get_ports xcvr_cdb_psel_tx_ln_${lane} ]
   set_input_delay  $pclk_indly  -max -add -clock [get_clocks  LN_${lane}_CDBCLK ] [get_ports xcvr_cdb_psel_rx_ln_${lane} ]
   set_input_delay  $pclk_indly  -max -add -clock [get_clocks  LN_${lane}_CDBCLK ] [get_ports xcvr_cdb_paddr_ln_${lane}[*] ]
   set_input_delay  $pclk_indly  -max -add -clock [get_clocks  LN_${lane}_CDBCLK ] [get_ports xcvr_cdb_pwrite_ln_${lane} ]
   set_input_delay  $pclk_indly  -max -add -clock [get_clocks  LN_${lane}_CDBCLK ] [get_ports xcvr_cdb_pwdata_ln_${lane}[*] ]
   set_output_delay $pclk_outdly -max -add -clock [get_clocks  LN_${lane}_CDBCLK ] [get_ports xcvr_cdb_prdata_ln_${lane}[*] ]
   set_output_delay $pclk_outdly -max -add -clock [get_clocks  LN_${lane}_CDBCLK ] [get_ports xcvr_cdb_pready_ln_${lane} ]

   # Create hold arcs in Liberty models.
   if { $do_libgen } {
      set_input_delay  0.0  -min -add -clock [get_clocks  LN_${lane}_CDBCLK ] [get_ports xcvr_cdb_penable_ln_${lane} ]
      set_input_delay  0.0  -min -add -clock [get_clocks  LN_${lane}_CDBCLK ] [get_ports xcvr_cdb_psel_tx_ln_${lane} ]
      set_input_delay  0.0  -min -add -clock [get_clocks  LN_${lane}_CDBCLK ] [get_ports xcvr_cdb_psel_rx_ln_${lane} ]
      set_input_delay  0.0  -min -add -clock [get_clocks  LN_${lane}_CDBCLK ] [get_ports xcvr_cdb_paddr_ln_${lane}[*] ]
      set_input_delay  0.0  -min -add -clock [get_clocks  LN_${lane}_CDBCLK ] [get_ports xcvr_cdb_pwrite_ln_${lane} ]
      set_input_delay  0.0  -min -add -clock [get_clocks  LN_${lane}_CDBCLK ] [get_ports xcvr_cdb_pwdata_ln_${lane}[*] ]
      set_output_delay 0.0  -min -add -clock [get_clocks  LN_${lane}_CDBCLK ] [get_ports xcvr_cdb_prdata_ln_${lane}[*] ]
      set_output_delay 0.0  -min -add -clock [get_clocks  LN_${lane}_CDBCLK ] [get_ports xcvr_cdb_pready_ln_${lane} ]
   }

}; # End of lane loop

############################################
# Boundary scan
############################################
# Need to adjust I/O timing for WC clock latency
if { $::timeMode == "prop" } {
   set bscan_latency  0.035
} else {
   set bscan_latency  0.0
}


# Set I/O timing to 1/3 clock period.
set bscan_value  [expr round(($BSCAN_PERIOD * 1.0 / 3.0) * 100) / 100.0]
set bscan_indly  [expr $bscan_value + $bscan_latency]
set bscan_outdly [expr $bscan_value - $bscan_latency]

#set cmn_ref_clk1 [get_clocks CMN_REF_CLK1_BSCAN_CLOCKDR]
#set_input_delay  $bscan_indly  -max -add -clock $cmn_ref_clk1 [get_ports cmn_ref_clk1_bscan_shiftdr]
#set_input_delay  $bscan_indly  -max -add -clock $cmn_ref_clk1 [get_ports cmn_ref_clk1_bscan_tdi]
#set_output_delay $bscan_outdly -max -add -clock $cmn_ref_clk1 [get_ports cmn_ref_clk1_bscan_tdo]
#if { $do_libgen } {
#   set_input_delay  0  -min -add -clock $cmn_ref_clk1 [get_ports cmn_ref_clk1_bscan_shiftdr]
#   set_input_delay  0  -min -add -clock $cmn_ref_clk1 [get_ports cmn_ref_clk1_bscan_tdi]
#   set_output_delay 0  -min -add -clock $cmn_ref_clk1 [get_ports cmn_ref_clk1_bscan_tdo]
#}
#
#set cmn_ref_clk0 [get_clocks CMN_REF_CLK0_BSCAN_CLOCKDR]
#set_input_delay  $bscan_indly  -max -add -clock $cmn_ref_clk0 [get_ports cmn_ref_clk0_bscan_shiftdr]
#set_input_delay  $bscan_indly  -max -add -clock $cmn_ref_clk0 [get_ports cmn_ref_clk0_bscan_tdi]
#set_output_delay $bscan_outdly -max -add -clock $cmn_ref_clk0 [get_ports cmn_ref_clk0_bscan_tdo]
#if { $do_libgen } {
#   set_input_delay  0  -min -add -clock $cmn_ref_clk0 [get_ports cmn_ref_clk0_bscan_shiftdr]
#   set_input_delay  0  -min -add -clock $cmn_ref_clk0 [get_ports cmn_ref_clk0_bscan_tdi]
#   set_output_delay 0  -min -add -clock $cmn_ref_clk0 [get_ports cmn_ref_clk0_bscan_tdo]
#}


for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {

   set txbscanclk [get_clocks LN_${lane}_TX_BSCAN_CLOCKDR]
   set_input_delay  $bscan_indly  -max -add -clock $txbscanclk [get_ports tx_bscan_shiftdr_ln_${lane}]
   set_input_delay  $bscan_indly  -max -add -clock $txbscanclk [get_ports tx_bscan_tdi_ln_${lane}]
   set_output_delay $bscan_outdly -max -add -clock $txbscanclk [get_ports tx_bscan_tdo_ln_${lane}]
   #set rxbscanclk [get_clocks LN_${lane}_RX_BSCAN_CLOCKDR]
   #set_input_delay  $bscan_indly  -max -add -clock $rxbscanclk [get_ports rx_bscan_shiftdr_ln_${lane}]
   #set_input_delay  $bscan_indly  -max -add -clock $rxbscanclk [get_ports rx_bscan_tdi_ln_${lane}]
   #set_output_delay $bscan_outdly -max -add -clock $rxbscanclk [get_ports rx_bscan_tdo_ln_${lane}]

   # Create hold arcs in Liberty models
   if { $do_libgen } {
      set txbscanclk [get_clocks LN_${lane}_TX_BSCAN_CLOCKDR]
      set_input_delay  0.0 -min -add -clock $txbscanclk [get_ports tx_bscan_shiftdr_ln_${lane}]
      set_input_delay  0.0 -min -add -clock $txbscanclk [get_ports tx_bscan_tdi_ln_${lane}]
      set_output_delay 0.0 -min -add -clock $txbscanclk [get_ports tx_bscan_tdo_ln_${lane}]
      #set rxbscanclk [get_clocks LN_${lane}_RX_BSCAN_CLOCKDR]
      #set_input_delay  0.0 -min -add -clock $rxbscanclk [get_ports rx_bscan_shiftdr_ln_${lane}]
      #set_input_delay  0.0 -min -add -clock $rxbscanclk [get_ports rx_bscan_tdi_ln_${lane}]
      #set_output_delay 0.0 -min -add -clock $rxbscanclk [get_ports rx_bscan_tdo_ln_${lane}]
   }

}

#lane1&lane2 have rx part
for { set lane 1 } { $lane < 3 } { incr lane 1 } {

   set rxbscanclk [get_clocks LN_${lane}_RX_BSCAN_CLOCKDR]
   set_input_delay  $bscan_indly  -max -add -clock $rxbscanclk [get_ports rx_bscan_shiftdr_ln_${lane}]
   set_input_delay  $bscan_indly  -max -add -clock $rxbscanclk [get_ports rx_bscan_tdi_ln_${lane}]
   set_output_delay $bscan_outdly -max -add -clock $rxbscanclk [get_ports rx_bscan_tdo_ln_${lane}]

   # Create hold arcs in Liberty models
   if { $do_libgen } {
      set rxbscanclk [get_clocks LN_${lane}_RX_BSCAN_CLOCKDR]
      set_input_delay  0.0 -min -add -clock $rxbscanclk [get_ports rx_bscan_shiftdr_ln_${lane}]
      set_input_delay  0.0 -min -add -clock $rxbscanclk [get_ports rx_bscan_tdi_ln_${lane}]
      set_output_delay 0.0 -min -add -clock $rxbscanclk [get_ports rx_bscan_tdo_ln_${lane}]
   }

}

#############################################
## Misc
#############################################

###############################################################################
# Driving cell
###############################################################################

if { !$do_libgen } {
    set_driving_cell -lib_cell $::DRIVING_CELL -pin $::DRIVING_PIN $clk_inputs
    set_driving_cell -lib_cell $::DRIVING_CELL -pin $::DRIVING_PIN $data_inputs
}

###############################################################################
# Loads
###############################################################################

set_load 0.020 [get_ports [all_outputs]]
set_load 1.000 [get_ports { cmn_atb_core_* }]
#set_load 1.200 [get_ports { tx_m_ln_* tx_p_ln_* }]
set_load 1.200 [get_ports { xcvr_m_ln_* xcvr_p_ln_* }]
set_load 1.200 [get_ports { cmn_rext }]

################################################################################
## Exceptions
################################################################################
set_false_path -from [get_clocks IO_ASYNC]
set_false_path -to   [get_clocks IO_ASYNC]

#add condition for PD by Luke
if { [info exists load_syn_sdc] && $load_syn_sdc} {
} else {

# Set false paths to first flop in reset_sync logic.
set_false_path -to [get_pins -hier { *genblk1_u_reset_sync_synth_*_1/D }]

# Set false paths to first flop in data_sync logic.
set_false_path -to [get_pins -hier { *genblk1_u_data_sync_synth_*_1/D }]

# 20220216 JMY Need to make an exception for data_sync on the signal detect logic
for { set lane 0 } { $lane < $num_lanes } { incr lane 1 } {
   set lane_inst u_pma_rev/u_xcvr_$lane_map($lane)
   reset_path_exception -type false_path -to ${lane_inst}/u_rx_ctrl/u_rx_sig_detect_filt_apb_icfg/u_rx_sig_detect_filt_apb/u_rx_sig_detect_filt_v2/u_data_sync_rxda_signal_detect_fast/u_data_sync_synth/genblk1_genblk1_u_data_sync_synth_2_1/D
}

# Loren confirmed that both reset_sync flops get asynchronous resets.
set_false_path -to [get_pins -hier { *genblk1_u_reset_sync_synth_*/CD }]

}

# JMY Prevent timing from NRESTORE->Q pins on RSDF FFs, logic prevents this from being a critical path
#     as downstream clocks are off
# Updated syntax to make H240/H300 agnostic per Joey's modifications
#add disable timing for retention Cells

#set_disable_timing [get_lib_cells head.libCells.name RSDFRPQHDCWD*BWP*H*P*] -from NRESTORE -to Q
#set_disable_timing [get_lib_cells head.libCells.name RSDFSNQHDCWD*BWP*H*P*] -from NRESTORE -to Q
#set_disable_timing [get_lib_cells head.libCells.name RSDFSRPQHDCWD*BWP*H*P*] -from NRESTORE -to Q

if { [info exists load_syn_sdc] && $load_syn_sdc} {
} else {
set_disable_timing [get_lib_cells head.libCells.name RSDFRPQHDCWD*BWP*H*P*] -from NRESTORE -to Q
set_disable_timing [get_lib_cells head.libCells.name RSDFSNQHDCWD*BWP*H*P*] -from NRESTORE -to Q
set_disable_timing [get_lib_cells head.libCells.name RSDFSRPQHDCWD*BWP*H*P*] -from NRESTORE -to Q

set_disable_timing [get_lib_cells head.libCells.name RSDFRPQHDCWD*BWP*H*P*] -from NRESTORE -to CD
set_disable_timing [get_lib_cells head.libCells.name RSDFSNQHDCWD*BWP*H*P*] -from NRESTORE -to CD
set_disable_timing [get_lib_cells head.libCells.name RSDFSRPQHDCWD*BWP*H*P*] -from NRESTORE -to CD

set_disable_timing [get_lib_cells head.libCells.name RSDFRPQHDCWD*BWP*H*P*] -from NRESTORE -to SDN
set_disable_timing [get_lib_cells head.libCells.name RSDFSNQHDCWD*BWP*H*P*] -from NRESTORE -to SDN
set_disable_timing [get_lib_cells head.libCells.name RSDFSRPQHDCWD*BWP*H*P*] -from NRESTORE -to SDN

}




# generating Liberty models.
if { $do_libgen } {
   foreach_in_collection pma_port $async_inputs {
      set port_name [get_object $pma_port]
      set_false_path -through $port_name -to [all_clocks]
   }

   foreach_in_collection pma_port $async_outputs {
      set port_name [get_object $pma_port]
      set_false_path -through $port_name -from [all_clocks]
   }

   # Explicitly squash these paths
   set_false_path -from cmn_scan_pll_ats -to cmn_scanclk_pll0_prog0_ats_out
   set_false_path -from cmn_scan_pll_ats -to cmn_scanclk_pll0_prog1_ats_out
   set_false_path -from cmn_scan_pll_ats -to cmn_scanclk_pll1_prog0_ats_out
   set_false_path -from cmn_scan_pll_ats -to cmn_scanclk_pll1_prog1_ats_out
}


# Set false paths to analog scanin pins and from analog scanout pins.
set_false_path -through $xcvr_ana_cdrlf_scan_pins
set_false_path -through $xcvr_ana_drv_scan_pins
#set_false_path -through $xcvr_ana_dfe_scan_pins

#add for Timberwolf
set_false_path -through $txm_ana_drv_scan_pins

### Multicycle paths
# Following can be multi-cycled as sources are only used for overrides, capture clocks will be stopped for at least 3-4 cycles per Loren
# u_pma_rev/u_cmn/u_cmn_ctrl/u_cmn_cdiag_ovrd/u_cmn_cdiag_ovrd_cdb_regs/cmn_cdiag_xcvrc_pwri_ovrd_reg_reg[14]/Q -> u_pma_rev/u_cmn/xcvrc_isl_power_isolation_en_<l,r>

#annotation by Luke
#set_multicycle_path -setup 3 \
#    -through [get_pins u_pma_rev/u_cmn/u_cmn_ctrl/u_cmn_cdiag_ovrd/u_cmn_cdiag_ovrd_cdb_regs/cmn_cdiag_xcvrc_pwri_ovrd_reg_reg[*]/Q] \
#    -through [get_pins u_pma_rev/u_cmn/xcvrc_isl_power_isolation_en_l]
#set_multicycle_path -hold 2 \
#    -through [get_pins u_pma_rev/u_cmn/u_cmn_ctrl/u_cmn_cdiag_ovrd/u_cmn_cdiag_ovrd_cdb_regs/cmn_cdiag_xcvrc_pwri_ovrd_reg_reg[*]/Q] \
#    -through [get_pins u_pma_rev/u_cmn/xcvrc_isl_power_isolation_en_l]
#set_multicycle_path -setup 3 \
#    -through [get_pins u_pma_rev/u_cmn/u_cmn_ctrl/u_cmn_cdiag_ovrd/u_cmn_cdiag_ovrd_cdb_regs/cmn_cdiag_xcvrc_pwri_ovrd_reg_reg[*]/Q] \
#    -through [get_pins u_pma_rev/u_cmn/xcvrc_isl_power_isolation_en_r]
#set_multicycle_path -hold 2 \
#    -through [get_pins u_pma_rev/u_cmn/u_cmn_ctrl/u_cmn_cdiag_ovrd/u_cmn_cdiag_ovrd_cdb_regs/cmn_cdiag_xcvrc_pwri_ovrd_reg_reg[*]/Q] \
#    -through [get_pins u_pma_rev/u_cmn/xcvrc_isl_power_isolation_en_r]
## u_pma_rev/u_cmn/u_cmn_ctrl/u_cmn_cdiag_ovrd/u_cmn_cdiag_ovrd_cdb_regs/cmn_cdiag_diag_pwri_ovrd_reg_reg[14]/Q -> u_pma_rev/u_cmn/diag_isl_power_isolation_en_l
#set_multicycle_path -setup 3 \
#    -through [get_pins u_pma_rev/u_cmn/u_cmn_ctrl/u_cmn_cdiag_ovrd/u_cmn_cdiag_ovrd_cdb_regs/cmn_cdiag_diag_pwri_ovrd_reg_reg[*]/Q] \
#    -through [get_pins u_pma_rev/u_cmn/diag_isl_power_isolation_en_l]
#set_multicycle_path -hold 2 \
#    -through [get_pins u_pma_rev/u_cmn/u_cmn_ctrl/u_cmn_cdiag_ovrd/u_cmn_cdiag_ovrd_cdb_regs/cmn_cdiag_diag_pwri_ovrd_reg_reg[*]/Q] \
#    -through [get_pins u_pma_rev/u_cmn/diag_isl_power_isolation_en_l]
#set_multicycle_path -setup 3 \
#    -through [get_pins u_pma_rev/u_cmn/u_cmn_ctrl/u_cmn_cdiag_ovrd/u_cmn_cdiag_ovrd_cdb_regs/cmn_cdiag_diag_pwri_ovrd_reg_reg[*]/Q] \
#    -through [get_pins u_pma_rev/u_cmn/diag_isl_power_isolation_en_r]
#set_multicycle_path -hold 2 \
#    -through [get_pins u_pma_rev/u_cmn/u_cmn_ctrl/u_cmn_cdiag_ovrd/u_cmn_cdiag_ovrd_cdb_regs/cmn_cdiag_diag_pwri_ovrd_reg_reg[*]/Q] \
#    -through [get_pins u_pma_rev/u_cmn/diag_isl_power_isolation_en_r]


###############################################################################
# Misc
###############################################################################

#if { $::timeMode == "prop" } {
if {!$load_syn_sdc && $::timeMode == "prop" } {
   reset_clock_tree_latency [all_clocks]
   set_propagated_clock [all_clocks]
}

