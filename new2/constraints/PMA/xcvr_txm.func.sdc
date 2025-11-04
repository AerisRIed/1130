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
# Filename  : xcvr.func.tcl
# Version   : $Revision$
# Date/Time : $Date$
#
# Author    : Dave Masters & Jack Yarolin & Dominic Lavoie 
# Abstract  : Functional constraints for the Whistler XCVR.
#
###############################################################################
# Change Log
# $Log:$
#
###############################################################################

if { [info exists load_syn_sdc] && $load_syn_sdc} {
   source ./constraints/xcvr_txm.preamble.sdc
} else {
   source [file dirname [info script]]/xcvr_txm.preamble.sdc
}

current_design xcvr_txm


###############################################################################
# set_case_analysis
###############################################################################
set_case_analysis 0 [get_ports {xcvr_scanmode_ln0 xcvr_scanen_ln0 xcvr_scanen_cg_ln0}]
set_case_analysis 0 [get_ports {xcvr_scanmode_ln1 xcvr_scanen_ln1 xcvr_scanen_cg_ln1}]

# During functional mode when powered up, sandh need to be timed as passthru to allow PSM clk data phase to output pins
if { [info exists load_syn_sdc] && $load_syn_sdc} {
   set_case_analysis 0 [get_pins -hier { *xcvr_diag_txclk_ctrl_reg*}]
} else {
   # Need to force non-inverted serializer clocks for both lanes
   set_case_analysis 0 [get_pins u_xcvr_txonly0/u_xcvr_ctrl/u_sandh_latch_xcvr_power_state_ack/sandh_out_reg[*]/EN]
   set_case_analysis 0 [get_pins u_xcvr_txonly1/u_xcvr_ctrl/u_sandh_latch_xcvr_power_state_ack/sandh_out_reg[*]/EN]
   set_case_analysis 0 [get_pins -hier { *xcvr_diag_txclk_ctrl_reg_reg[15]/Q }]
}

#######################################
# Clock definitions
#######################################

############################################
# Reference clocks
############################################
#
# CMN_REFCLK_IN_LN0/1
#
create_clock \
    -name           REFCLK_GATED_IN_LN0 \
    -period         $CLK156P25_PERIOD \
    -waveform       $CLK156P25_WAVEFORM \
    -add \
    [get_ports cmn_ref_clk_gated_in_ln0]

create_generated_clock \
    -name           REFCLK_GATED_OUT_LN0 \
    -divide_by      1 \
    -master_clock   [get_clocks REFCLK_GATED_IN_LN0] \
    -source         [get_ports cmn_ref_clk_gated_in_ln0] \
    -add \
    [get_ports cmn_ref_clk_gated_out_ln0]

create_clock \
    -name           REFCLK_GATED_IN_LN1 \
    -period         $CLK156P25_PERIOD \
    -waveform       $CLK156P25_WAVEFORM \
    -add \
    [get_ports cmn_ref_clk_gated_in_ln1]

create_generated_clock \
    -name           REFCLK_GATED_OUT_LN1 \
    -divide_by      1 \
    -master_clock   [get_clocks REFCLK_GATED_IN_LN1] \
    -source         [get_ports cmn_ref_clk_gated_in_ln1] \
    -add \
    [get_ports cmn_ref_clk_gated_out_ln1]
###########################################################
# PSM clock
###########################################################
# [DL] SDC review. At-speed is having it as 200MHz and is the most restrictive.
create_clock \
    -name           PSMCLK_LN0 \
    -period         $CLK156P25_PERIOD \
    -waveform       $CLK156P25_WAVEFORM \
    -add \
    [get_ports xcvr_psm_clk_ln0]

create_clock \
    -name           PSMCLK_LN1 \
    -period         $CLK156P25_PERIOD \
    -waveform       $CLK156P25_WAVEFORM \
    -add \
    [get_ports xcvr_psm_clk_ln1]

############################################
# CDB clock.
############################################
#
#CDBCLK
#
create_clock \
    -name           CDBCLK_LN0 \
    -period         $CLK525_PERIOD \
    -waveform       $CLK525_WAVEFORM \
    -add \
    [get_ports xcvr_cdb_pclk_ln0]

create_clock \
    -name           CDBCLK_LN1 \
    -period         $CLK525_PERIOD \
    -waveform       $CLK525_WAVEFORM \
    -add [get_ports xcvr_cdb_pclk_ln1]

#USB 3.0
create_clock                                                                                      \
    -name           PLL0_CLK0_FULLRT_USB_IN_LN0                                                        \
    -period         $CLK500_PERIOD                                                                \
    -waveform       $CLK500_WAVEFORM                                                              \
    -add                                                                                          \
    [get_ports cmn_pll0_clk_0_scanned_in_ln0]

create_generated_clock                                                                            \
     -name         PLL0CLK_FULLRT_DISPLAY_OUT_LN0                                                     \
     -divide_by    1                                                                              \
     -master_clock [get_clocks  PLL0_CLK_FULLRT_DISPLAY_IN_LN0 ]                                      \
     -source       [get_ports cmn_pll0_clk_0_scanned_in_ln0 ]                                         \
     -add                                                                                         \
     [get_ports xcvr_pll_clk_fullrt_ln0 ]

create_generated_clock                                                                            \
     -name         PLL0CLK_FULLRT_DISPLAY_OUT_LN1                                                     \
     -divide_by    1                                                                              \
     -master_clock [get_clocks  PLL0_CLK_FULLRT_DISPLAY_IN_LN1 ]                                      \
     -source       [get_ports cmn_pll0_clk_0_scanned_in_ln1 ]                                         \
     -add                                                                                         \
     [get_ports xcvr_pll_clk_fullrt_ln1 ]

create_clock                                                                                      \
    -name           PLL0_CLK_FULLRT_IN_LN0                                                            \
    -period         $CLK500_PERIOD                                                                \
    -waveform       $CLK500_WAVEFORM                                                              \
    -add                                                                                          \
    [get_ports cmn_pll0_clk_0_scanned_in_ln0]

create_generated_clock                                                                            \
     -name         PLL0CLK_FULLRT_GEN3_OUT_LN0                                                        \
     -divide_by    1                                                                              \
     -master_clock [get_clocks  PLL0_CLK_FULLRT_IN_LN0 ]                                              \
     -source       [get_ports cmn_pll0_clk_0_scanned_in_ln0 ]                                         \
     -add                                                                                         \
     [get_ports xcvr_pll_clk_fullrt_ln0 ]

create_generated_clock                                                                            \
     -name         PLL0CLK_DATART_GEN2_LN0                                                            \
     -divide_by    2                                                                              \
     -master_clock [get_clocks  PLL0_CLK_FULLRT_IN_LN0 ]                                              \
     -source       [get_ports cmn_pll0_clk_0_scanned_in_ln0 ]                                         \
     -add                                                                                         \
     [get_pins u_xcvr_txonly0/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux_I1_pin}]

create_clock                                                                                      \
    -name           PLL1_CLK0_FULLRT_USB_IN_LN0                                                        \
    -period         $CLK500_PERIOD                                                                \
    -waveform       $CLK500_WAVEFORM                                                              \
    -add                                                                                          \
    [get_ports cmn_pll1_clk_0_scanned_in_ln0]

create_clock                                                                                      \
    -name           PLL0_CLK1_FULLRT_USB_IN_LN0                                                        \
    -period         $CLK625_PERIOD                                                                \
    -waveform       $CLK625_WAVEFORM                                                              \
    -add                                                                                          \
    [get_ports cmn_pll0_clk_1_scanned_in_ln0]

create_clock                                                                                      \
    -name           PLL1_CLK1_FULLRT_USB_IN_LN0                                                        \
    -period         $CLK625_PERIOD                                                                \
    -waveform       $CLK625_WAVEFORM                                                              \
    -add                                                                                          \
    [get_ports cmn_pll1_clk_1_scanned_in_ln0]

create_clock                                                                                      \
    -name           PLL0_CLK0_FULLRT_USB_IN_LN1                                                        \
    -period         $CLK500_PERIOD                                                                \
    -waveform       $CLK500_WAVEFORM                                                              \
    -add                                                                                          \
    [get_ports cmn_pll0_clk_0_scanned_in_ln1]

create_generated_clock                                                                            \
     -name         PLL0CLK_DATART_GEN2                                                            \
     -divide_by    2                                                                              \
     -master_clock [get_clocks  PLL0_CLK_FULLRT_IN ]                                              \
     -source       [get_ports cmn_pll0_clk_0_scanned_in_ln0 ]                                         \
     -add                                                                                         \
     [get_pins u_xcvr_txonly0/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux_I1_pin}]

create_clock                                                                                      \
    -name           PLL1_CLK0_FULLRT_USB_IN_LN1                                                        \
    -period         $CLK500_PERIOD                                                                \
    -waveform       $CLK500_WAVEFORM                                                              \
    -add                                                                                          \
    [get_ports cmn_pll1_clk_0_scanned_in_ln1]

create_clock                                                                                      \
    -name           PLL0_CLK1_FULLRT_USB_IN_LN1                                                        \
    -period         $CLK625_PERIOD                                                                \
    -waveform       $CLK625_WAVEFORM                                                              \
    -add                                                                                          \
    [get_ports cmn_pll0_clk_1_scanned_in_ln1]

create_clock                                                                                      \
    -name           PLL1_CLK1_FULLRT_USB_IN_LN1                                                        \
    -period         $CLK625_PERIOD                                                                \
    -waveform       $CLK625_WAVEFORM                                                              \
    -add                                                                                          \
    [get_ports cmn_pll1_clk_1_scanned_in_ln1]


############################################
# Full-rate and data-rate clocks. Per table 4.10
############################################
# Lane 0 PLL clocks
# PLL1 
#
create_clock                                                                                      \
    -name           PLL1_CLK_FULLRT_DISPLAY_IN_LN0                                                    \
    -period         $CLK1031P25_PERIOD                                                            \
    -waveform       $CLK1031P25_WAVEFORM                                                          \
    -add                                                                                          \
    [get_ports cmn_pll1_clk_0_scanned_in_ln0]

 create_generated_clock                                                                           \
     -name         PLL1CLK_FULLRT_DISPLAY_OUT_LN0                                                  \
     -divide_by    1                                                                              \
     -master_clock [get_clocks PLL1_CLK_FULLRT_DISPLAY_IN_LN0]                                       \
     -source       [get_ports cmn_pll1_clk_0_scanned_in_ln0]                                         \
     -add                                                                                         \
     [get_ports xcvr_pll_clk_fullrt_ln0]

create_generated_clock                                                                            \
    -name           PLL1CLK_DATART_DISPLAY_LN0                                                    \
    -divide_by      2                                                                             \
    -master_clock   [get_clocks PLL1_CLK_FULLRT_DISPLAY_IN_LN0]                                       \
    -source         [get_ports cmn_pll1_clk_0_scanned_in_ln0]                                         \
    -add                                                                                          \
    [get_pins u_xcvr_txonly0/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux1_I1_pin}]

 create_generated_clock                                                                           \
      -name         PLL1CLK_DATART_DISPLAY_OUT                                                    \
      -divide_by    1                                                                            \
      -master_clock [get_clocks  PLL1CLK_DATART_DISPLAY_LN0 ]                                         \
      -source       [get_pins u_xcvr_txonly0/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux1_I1_pin}] \
      -add                                                                                        \
      [get_ports xcvr_pll_clk_datart_ln0]


create_clock                                                                                      \
    -name           PLL1_CLK_FULLRT_IN_LN0                                                            \
    -period         $CLK500_PERIOD                                                                \
    -waveform       $CLK500_WAVEFORM                                                              \
    -add                                                                                          \
    [get_ports cmn_pll1_clk_0_scanned_in_ln0]

 create_generated_clock                                                                           \
     -name         PLL1CLK_FULLRT_GEN3_OUT_LN0                                                        \
     -divide_by    1                                                                              \
     -master_clock [get_clocks PLL1_CLK_FULLRT_IN_LN0]                                               \
     -source       [get_ports cmn_pll1_clk_0_scanned_in_ln0]                                         \
     -add                                                                                         \
     [get_ports xcvr_pll_clk_fullrt_ln0]

create_generated_clock                                                                            \
    -name           PLL1CLK_DATART_GEN3_LN0                                                           \
    -divide_by      1                                                                             \
    -master_clock   [get_clocks PLL1_CLK_FULLRT_IN_LN0]                                               \
    -source         [get_ports cmn_pll1_clk_0_scanned_in_ln0]                                         \
    -add                                                                                          \
    [get_pins u_xcvr_txonly0/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux1_I0_pin}]

 create_generated_clock                                                                           \
      -name         PLL1CLK_DATART_GEN3_OUT_LN0                                                       \
      -divide_by    1                                                                             \
      -master_clock [get_clocks  PLL1CLK_DATART_GEN3_LN0 ]                                             \
      -source       [get_pins u_xcvr_txonly0/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux1_I0_pin} ] \
      -add                                                                                        \
      [get_ports xcvr_pll_clk_datart_ln0]

create_generated_clock                                                                            \
    -name           PLL1CLK_DATART_GEN2_LN0                                                           \
    -divide_by      2                                                                             \
    -master_clock   [get_clocks PLL1_CLK_FULLRT_IN_LN0]                                               \
    -source         [get_ports cmn_pll1_clk_0_scanned_in_ln0]                                         \
    -add                                                                                          \
    [get_pins u_xcvr_txonly0/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux1_I1_pin}]

create_generated_clock                                                                            \
    -name           PLL1CLK_DATART_GEN1_LN0                                                           \
    -divide_by      4                                                                             \
    -master_clock   [get_clocks PLL1_CLK_FULLRT_IN_LN0]                                               \
    -source         [get_ports cmn_pll1_clk_0_scanned_in_ln0]                                         \
    -add                                                                                          \
    [get_pins u_xcvr_txonly0/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux1_I1_pin}]

create_generated_clock                                                                            \
    -name           PLL1CLK_DATART_DIV8_LN0                                                           \
    -divide_by      8                                                                             \
    -master_clock   [get_clocks PLL1_CLK_FULLRT_IN_LN0]                                               \
    -source         [get_ports cmn_pll1_clk_0_scanned_in_ln0]                                         \
    -add                                                                                          \
    [get_pins u_xcvr_txonly0/u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux1_I1_pin}]

############################################
# Lane transmit (tx_td) clocks. 
############################################
#
# TXTDCLKIN (Lane 0)
# This is the input clock to each lane to which
# the tx_td data can be synchronized.
#
create_clock \
    -name     TXTDCLK_LN0 \
    -period   $CLK1000_PERIOD \
    -waveform $CLK1000_WAVEFORM \
    -add \
    [get_ports tx_td_clk_ln0]

#
# TXTDCLKIN (Lane 1)
#
create_clock \
    -name     TXTDCLK_LN1 \
    -period   $CLK1000_PERIOD \
    -waveform $CLK1000_WAVEFORM \
    -add \
    [get_ports tx_td_clk_ln1]

############################################
# Serializer clocks.
############################################
#
# Serializer clock from Transmitter Lane 0
#
create_clock \
    -name     TXCLK_LN0 \
    -period   $CLK1000_PERIOD \
    -waveform $CLK1000_WAVEFORM \
    -add \
    [get_pins u_txm_ana/txda0_ser_clk] 

#
# Serializer clock from Transmitter Lane 1
#
create_clock \
    -name     TXCLK_LN1 \
    -period   $CLK1000_PERIOD \
    -waveform $CLK1000_WAVEFORM \
    -add \
    [get_pins u_txm_ana/txda1_ser_clk] 

############################################
# Boundary scan clocks
############################################

create_clock \
    -name           TX_BSCAN_CLOCKDR_LN0 \
    -period         $BSCAN_PERIOD \
    -waveform       $BSCAN_WAVEFORM \
    [get_ports tx_bscan_clockdr_ln0]

create_clock \
    -name           TX_BSCAN_UPDATEDR_LN0 \
    -period         $BSCAN_PERIOD \
    -waveform       $BSCAN_WAVEFORM \
    [get_ports tx_bscan_updatedr_ln0]

create_clock \
    -name           TX_BSCAN_CLOCKDR_LN1 \
    -period         $BSCAN_PERIOD \
    -waveform       $BSCAN_WAVEFORM \
    [get_ports tx_bscan_clockdr_ln1]

create_clock \
    -name           TX_BSCAN_UPDATEDR_LN1 \
    -period         $BSCAN_PERIOD \
    -waveform       $BSCAN_WAVEFORM \
    [get_ports tx_bscan_updatedr_ln1]


#######################################
# Misc clocks
###############################################################################
# virtual clocks for cdb IO
###############################################################################
create_clock \
    -name           vclk_seq \
    -period         $CLK200_PERIOD \
    -waveform       $CLK200_WAVEFORM

create_clock \
    -name           vclk_comb \
    -period         $CLK2000_PERIOD \
    -waveform       $CLK2000_WAVEFORM

#######################################
# Virtual Asynchronous clock phases. This phase is excluded from all other clocks.
create_clock \
    -name           IO_ASYNC \
    -period         $ASYNC_PERIOD \
    -waveform       $ASYNC_WAVEFORM

###############################################################################
# Clock Uncertainties
###############################################################################
#########################################################################
# Default uncertainties. Default setup is high in order to catch
# unaccounted for clock relationships.
set default_margin 5.000
set_clock_uncertainty $default_margin -setup -from [all_clocks] -to [all_clocks]
set_clock_uncertainty $hold_margin -hold  -from [all_clocks] -to [all_clocks]

set_clock_uncertainty 0.000 -setup -from [get_clocks vclk_comb] -to [get_clocks vclk_comb]
set_clock_uncertainty 0.000 -hold  -from [get_clocks vclk_comb] -to [get_clocks vclk_comb]

# Account for intra-clock relationships.
set_clock_uncertainty $setup_margin -setup -from [get_clocks REFCLK_GATED_IN*]   -to [get_clocks REFCLK_GATED_IN*]
set_clock_uncertainty $setup_margin -setup -from [get_clocks REFCLK_GATED_OUT*]  -to [get_clocks REFCLK_GATED_OUT*]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TX_BSCAN_CLOCKDR_LN0]  -to [get_clocks TX_BSCAN_CLOCKDR_LN0]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TX_BSCAN_UPDATEDR_LN0] -to [get_clocks TX_BSCAN_UPDATEDR_LN0]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TX_BSCAN_CLOCKDR_LN1]  -to [get_clocks TX_BSCAN_CLOCKDR_LN1]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TX_BSCAN_UPDATEDR_LN1] -to [get_clocks TX_BSCAN_UPDATEDR_LN1]
set_clock_uncertainty $setup_margin -setup -from [get_clocks { CDBCLK_LN0 vclk_seq }] -to [get_clocks { CDBCLK_LN0 vclk_seq }]
set_clock_uncertainty $setup_margin -setup -from [get_clocks { CDBCLK_LN1 vclk_seq }] -to [get_clocks { CDBCLK_LN1 vclk_seq }]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PSMCLK_LN0]            -to [get_clocks PSMCLK_LN0]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PSMCLK_LN1]            -to [get_clocks PSMCLK_LN1]

set_clock_uncertainty $setup_margin -setup -from [get_clocks TXTDCLK_LN0]   -to [get_clocks  TXTDCLK_LN0]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXTDCLK_LN1]   -to [get_clocks  TXTDCLK_LN1]

set_clock_uncertainty $setup_margin -setup -from [get_clocks TXCLK_LN0]   -to [get_clocks TXCLK_LN0]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXCLK_LN1]   -to [get_clocks TXCLK_LN1]

# Account for inter-clock relationships.
set_clock_uncertainty $setup_margin -setup -from [get_clocks *REFCLK*]  -to [get_clocks *REFCLK*]
set_clock_uncertainty $setup_margin -setup -from [get_clocks IO_ASYNC]  -to [get_clocks IO_ASYNC]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXCLK_*]   -to [get_clocks TXCLK_*]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXCLK_LN0]   -to [get_clocks TXTDCLK_LN0]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXTDCLK_LN0] -to [get_clocks TXCLK_LN0]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXCLK_LN1]   -to [get_clocks TXTDCLK_LN1]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXTDCLK_LN1] -to [get_clocks TXCLK_LN1]

set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL1_CLK_FULLRT_IN_LN0] -to [get_clocks PLL1_CLK_FULLRT_IN_LN0]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL1_CLK_FULLRT_DISPLAY_IN_LN0] -to [get_clocks PLL1_CLK_FULLRT_DISPLAY_IN_LN0]

# Reduce uncertainty for MTBF flops
set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *u_dont_touch_data_sync*/CP }]
set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *u_dont_touch_reset_sync_*/CP }]
# [DL] TBD: Add duty cycle tolerance uncertainties

# [DL] TBD: Add duty cycle tolerance uncertainties

###############################################################################
# Clock groups
###############################################################################
set_clock_groups -async -name grp_cdb_ln0  -group [get_clocks { CDBCLK_LN0 vclk_seq }]
set_clock_groups -async -name grp_cdb_ln1  -group [get_clocks { CDBCLK_LN1 vclk_seq }]
set_clock_groups -async -name grp_bscan_ln0 -group [get_clocks { TX_BSCAN_CLOCKDR_LN0 TX_BSCAN_UPDATEDR_LN0 }]
set_clock_groups -async -name grp_bscan_ln1 -group [get_clocks { TX_BSCAN_CLOCKDR_LN1 TX_BSCAN_UPDATEDR_LN1 }]
set_clock_groups -async -name grp_async    -group [get_clocks { IO_ASYNC }]
set_clock_groups -async -name grp_txtd     -group [get_clocks { TXTDCLK* }]
set_clock_groups -async -name grp_psm      -group [get_clocks { PSMCLK_LN0 PSMCLK_LN1 }]
set_clock_groups -async -name grp_rate     -group [get_clocks { *FULLRT* *DATART* }]
set_clock_groups -async -name grp_ref      -group [get_clocks { REFCLK* }]
set_clock_groups -async -name grp_tx       -group [get_clocks { TXCLK_* TXTDCLK_* }]
set_clock_groups -async -name grp_vclk     -group [get_clocks { vclk_comb }]

# Physically exclusive clock groups
set_clock_groups -physically_exclusive -name grp_pllclk -group [get_clocks { *PLL0_CLK0* }] \
                                                            -group [get_clocks { *PLL0_CLK1* }]

set_clock_groups -physically_exclusive -name grp_usb    -group [get_clocks { *PLL0_CLK0* }] \
                                                            -group [get_clocks { *PLL0CLK_DATART* }]

# Physically exclusive groups for different protocol modes (per lane)
set_clock_groups -physically_exclusive -name grp_std_pe \
   -group [get_clocks { *_DIV8* }] \
   -group [get_clocks { *DISPLAY* }] \
   -group [get_clocks { *GEN3* PLL*_CLK_FULLRT_LN0* }] \
   -group [get_clocks { *GEN2* }] \
   -group [get_clocks { *GEN1* }] \
   -group [get_clocks { *USB30* }] \
   -group [get_clocks { *USB4* }]



# Note: Removed clock groups for RX-related clocks (RXCLK, RXRDCLK, RXDA_GB, RXDA_DCC_QEC_CAL, 
# RXDA_PHASE_ALIGN_DET, PLLLN) as they don't exist in this TX-only module
# Note: Removed TXDA_DC_CAL_CLK as it doesn't exist (DC cal uses control signals, not a clock)

###############################################################################
# Clock latency for clocks from common.
#-early | -late
# Specifies clock arrival time with respect to the early or the late time of the clock signal.
#In setup analysis, launch path is the late path and capture path is the early path.
#In hold analysis, launch path is the early path and the capture path is the late path.
#If neither parameter is specified, the default is both early and late.

###############################################################################
#set_clock_latency 0.45 -source -max [get_ports xcvr_cdb_pclk_ln0] -clock [get_clocks CDBCLK_LN0]
#set_clock_latency 0.40 -source -min [get_ports xcvr_cdb_pclk_ln0] -clock [get_clocks CDBCLK_LN0]
#set_clock_latency 0.45 -source -max [get_ports xcvr_cdb_pclk_ln1] -clock [get_clocks CDBCLK_LN1]
#set_clock_latency 0.40 -source -min [get_ports xcvr_cdb_pclk_ln1] -clock [get_clocks CDBCLK_LN1]
#need confirm by Dave

###############################################################################

###############################################################################
# I/O Timing
###############################################################################

# Constant and async signals
#Listed as found in Section 2 of the Whistler32G PMA spec
set async_inputs [get_ports {
   xcvr_lane_suspend_ln0
   xcvr_lane_suspend_ln1
   xcvr_lnr_ln0
   xcvr_lnr_ln1
   xcvr_link_reset_n_ln0
   xcvr_link_reset_n_ln1
   xcvr_standard_mode_ln0[*]
   xcvr_standard_mode_ln1[*]
   xcvr_data_width_ln0[*]
   xcvr_data_width_ln1[*]
   tx_cmn_mode_en_ext_ln0
   tx_cmn_mode_en_ext_ln1
   xcvr_pll_clk_en_ln0
   xcvr_pll_clk_en_ln1
   xcvr_cdb_preset_n_ln0
   xcvr_cdb_preset_n_ln1
   tx_reset_n_ln0
   tx_reset_n_ln1
   xcvr_lpbk_serial_en_ln0
   xcvr_lpbk_serial_en_ln1
   xcvr_lpbk_line_en_ln0
   xcvr_lpbk_line_en_ln1
   tx_differential_invert_ln0
   tx_differential_invert_ln1
   tx_rcv_detect_en_ln0
   tx_rcv_detect_en_ln1
   tx_deemphasis_ln0[*]
   tx_deemphasis_ln1[*]
   tx_get_local_preset_coef_ln0
   tx_get_local_preset_coef_ln1
   tx_get_local_init_coef_ln0
   tx_get_local_init_coef_ln1
   tx_local_preset_index_ln0[*]
   tx_local_preset_index_ln1[*]
   tx_vmargin_ln0[*]
   tx_vmargin_ln1[*]
   tx_low_power_swing_en_ln0
   tx_low_power_swing_en_ln1
   xcvr_scanmode_ln0
   xcvr_scanmode_ln1
   xcvr_scanen_ln0
   xcvr_scanen_ln1
   xcvr_scanen_cg_ln0
   xcvr_scanen_cg_ln1
   xcvr_scanin_ln0[*]
   xcvr_scanin_ln1[*]
   xcvr_bscan_mode_en_ln0
   xcvr_bscan_mode_en_ln1
   tx_bscan_mode_c_ln0
   tx_bscan_mode_c_ln1
   tx_bscan_acpulse_ln0
   tx_bscan_acpulse_ln1
   tx_bscan_ac_ln0
   tx_bscan_ac_ln1
   cmn_atb_en_in_ln0
   cmn_atb_en_in_ln1
   cmn_atb_sel_in_ln0
   cmn_atb_sel_in_ln1
   cmn_reset_n_in_ln0
   cmn_reset_n_in_ln1
   cmn_reset_sync_n_in_ln0
   cmn_reset_sync_n_in_ln1
   tx_rescal_code_in_ln0[*]
   tx_rescal_code_in_ln1[*]
}]

set_input_delay 0.0 -max -add -clock [get_clocks { IO_ASYNC }] $async_inputs

set async_outputs [get_ports {
   tx_m_ln0
   tx_m_ln1
   tx_p_ln0
   tx_p_ln1
   xcvr_pll_clk_en_ack_ln0
   xcvr_pll_clk_en_ack_ln1
   tx_rcv_detect_done_ln0
   tx_rcv_detect_done_ln1
   tx_rcv_detected_ln0
   tx_rcv_detected_ln1
   tx_local_tx_coef_valid_ln0
   tx_local_tx_coef_valid_ln1
   tx_local_tx_preset_coef_ln0[*]
   tx_local_tx_preset_coef_ln1[*]
   tx_local_fs_ln0[*]
   tx_local_fs_ln1[*]
   tx_local_lf_ln0[*]
   tx_local_lf_ln1[*]
   cmn_reset_n_out_ln0
   cmn_reset_n_out_ln1
   cmn_reset_sync_n_out_ln0
   cmn_reset_sync_n_out_ln1
   xcvr_in_obs_tie_high_ln0[*]
   xcvr_in_obs_tie_high_ln1[*]
   xcvr_in_obs_tie_low_ln0[*]
   xcvr_in_obs_tie_low_ln1[*]
   xcvr_in_ibs_tie_high_ln0[*]
   xcvr_in_ibs_tie_high_ln1[*]
   xcvr_in_ibs_tie_low_ln0[*]
   xcvr_in_ibs_tie_low_ln1[*]
   xcvr_scanout_ln0[*]
   xcvr_scanout_ln1[*]
   lane_addr_tie_high_ln0
   lane_addr_tie_high_ln1
   lane_addr_tie_low_ln0
   lane_addr_tie_low_ln1
}]


############################################
# Reference clocks
############################################

# Source-synchronous signals.
# Set I/O timing to 2/3 clock period.
set ref_value  [expr round(($CLK156P25_PERIOD * 2.0 / 3.0) * 100) / 100.0]


#############################################
## PSM
#############################################

# # Need to adjust I/O timing for WC clock latency.
# if { $::timeMode == "prop" } {
#    set psm_latency  0.400
# } else {
#    set psm_latency  0.0
# }

# Set I/O timing to 2/3 clock period.
set psm_value  [expr round(($CLK125_PERIOD * 2.0 / 3.0) * 100) / 100.0]
# set psm_indly  [expr $psm_value + $psm_latency]
# set psm_outdly [expr $psm_value - $psm_latency]

set psmclk_ln0 [get_clocks PSMCLK_LN0]
set_input_delay  $psm_value -max -add -clock $psmclk_ln0 [get_ports xcvr_power_state_req_ln0[*]]
set_output_delay $psm_value -max -add -clock $psmclk_ln0 [get_ports xcvr_power_state_ack_ln0[*]]
set_output_delay $psm_value -max -add -clock $psmclk_ln0 [get_ports xcvr_psm_ready_ln0]
set_output_delay $psm_value -max -add -clock $psmclk_ln0 [get_ports xcvr_psm_state_ln0[*]]

set psmclk_ln1 [get_clocks PSMCLK_LN1]
set_input_delay  $psm_value -max -add -clock $psmclk_ln1 [get_ports xcvr_power_state_req_ln1[*]]
set_output_delay $psm_value -max -add -clock $psmclk_ln1 [get_ports xcvr_power_state_ack_ln1[*]]
set_output_delay $psm_value -max -add -clock $psmclk_ln1 [get_ports xcvr_psm_ready_ln1]
set_output_delay $psm_value -max -add -clock $psmclk_ln1 [get_ports xcvr_psm_state_ln1[*]]

############################################
# Transmitter
############################################

# # Need to adjust I/O timing for WC clock latency.
# if { $::timeMode == "prop" } {
#    set txclk_latency  0.400
# } else {
#    set txclk_latency  0.0
# }

# # Set I/O timing to 2/3 clock period.
# set gen5_value  [expr round(($CLK1000_PERIOD * 2.0 / 3.0) * 100) / 100.0]
# set txclk_gen5_indly  [expr $gen5_value + $txclk_latency]
# set txclk_gen5_outdly  [expr $gen5_value + $txclk_latency]

# Based upon Joey's initial CCOPT results
set tx_out_delay_value 0.200
set tx_in_delay_value  0.200

set txclk_ln0 [get_clocks TXTDCLK_LN0]
set_input_delay  $tx_in_delay_value  -max -add -clock $txclk_ln0 [get_ports tx_sfifo_align_bump_in_ln0]
set_output_delay $tx_out_delay_value -max -add -clock $txclk_ln0 [get_ports tx_sfifo_align_bump_out_ln0]
set_input_delay  $tx_in_delay_value  -max -add -clock $txclk_ln0 [get_ports tx_sfifo_enq_reset_n_in_ln0]
set_output_delay $tx_out_delay_value -max -add -clock $txclk_ln0 [get_ports tx_sfifo_enq_reset_n_out_ln0]
set_input_delay  $tx_in_delay_value  -max -add -clock $txclk_ln0 [get_ports tx_elec_idle_ln0]
set_input_delay  $tx_in_delay_value  -max -add -clock $txclk_ln0 [get_ports tx_td_ln0[*]]
set_input_delay  $tx_in_delay_value  -max -add -clock $txclk_ln0 [get_ports tx_bist_hold_ln0]
set_input_delay  $tx_in_delay_value  -max -add -clock $txclk_ln0 [get_ports tx_lfps_en_ln0]
set_input_delay  $tx_in_delay_value  -max -add -clock $txclk_ln0 [get_ports tx_lfps_mode_ln0]

set txclk_ln1 [get_clocks TXTDCLK_LN1]
set_input_delay  $tx_in_delay_value  -max -add -clock $txclk_ln1 [get_ports tx_sfifo_align_bump_in_ln1]
set_output_delay $tx_out_delay_value -max -add -clock $txclk_ln1 [get_ports tx_sfifo_align_bump_out_ln1]
set_input_delay  $tx_in_delay_value  -max -add -clock $txclk_ln1 [get_ports tx_sfifo_enq_reset_n_in_ln1]
set_output_delay $tx_out_delay_value -max -add -clock $txclk_ln1 [get_ports tx_sfifo_enq_reset_n_out_ln1]
set_input_delay  $tx_in_delay_value  -max -add -clock $txclk_ln1 [get_ports tx_elec_idle_ln1]
set_input_delay  $tx_in_delay_value  -max -add -clock $txclk_ln1 [get_ports tx_td_ln1[*]]
set_input_delay  $tx_in_delay_value  -max -add -clock $txclk_ln1 [get_ports tx_bist_hold_ln1]
set_input_delay  $tx_in_delay_value  -max -add -clock $txclk_ln1 [get_ports tx_lfps_en_ln1]
set_input_delay  $tx_in_delay_value  -max -add -clock $txclk_ln1 [get_ports tx_lfps_mode_ln1]

############################################
# CDB
############################################

# Need to adjust I/O timing for WC clock latency.
if { $::timeMode == "prop" } {
   #set pclk_latency  0.600
   set pclk_latency  0.400
} else {
   set pclk_latency  0.000
}

# Set I/O timing to 2/3 clock period.
set cdb_value [expr round(($CLK500_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set pclk_indly  [expr $cdb_value + $pclk_latency]
set pclk_outdly [expr $cdb_value - $pclk_latency]

set_input_delay  $pclk_indly -max -add -clock [get_clocks { CDBCLK_LN0 }] [get_ports { xcvr_cdb_pwdata_ln0[*] }]
set_input_delay  $pclk_indly -max -add -clock [get_clocks { CDBCLK_LN0 }] [get_ports { xcvr_cdb_pwrite_ln0 }]
set_input_delay  $pclk_indly -max -add -clock [get_clocks { CDBCLK_LN0 }] [get_ports { xcvr_cdb_paddr_ln0[*] }]
set_input_delay  $pclk_indly -max -add -clock [get_clocks { CDBCLK_LN0 }] [get_ports { xcvr_cdb_penable_ln0 }]
set_input_delay  $pclk_indly -max -add -clock [get_clocks { CDBCLK_LN0 }] [get_ports { xcvr_cdb_psel_tx_ln0 }]
set_output_delay $pclk_outdly -max -add -clock [get_clocks { CDBCLK_LN0 }] [get_ports { xcvr_cdb_pready_ln0 }]
set_output_delay $pclk_outdly -max -add -clock [get_clocks { CDBCLK_LN0 }] [get_ports { xcvr_cdb_prdata_ln0[*] }]

set_input_delay  $pclk_indly -max -add -clock [get_clocks { CDBCLK_LN1 }] [get_ports { xcvr_cdb_pwdata_ln1[*] }]
set_input_delay  $pclk_indly -max -add -clock [get_clocks { CDBCLK_LN1 }] [get_ports { xcvr_cdb_pwrite_ln1 }]
set_input_delay  $pclk_indly -max -add -clock [get_clocks { CDBCLK_LN1 }] [get_ports { xcvr_cdb_paddr_ln1[*] }]
set_input_delay  $pclk_indly -max -add -clock [get_clocks { CDBCLK_LN1 }] [get_ports { xcvr_cdb_penable_ln1 }]
set_input_delay  $pclk_indly -max -add -clock [get_clocks { CDBCLK_LN1 }] [get_ports { xcvr_cdb_psel_tx_ln1 }]
set_output_delay $pclk_outdly -max -add -clock [get_clocks { CDBCLK_LN1 }] [get_ports { xcvr_cdb_pready_ln1 }]
set_output_delay $pclk_outdly -max -add -clock [get_clocks { CDBCLK_LN1 }] [get_ports { xcvr_cdb_prdata_ln1[*] }]

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

set txbscanclk_ln0 [get_clocks TX_BSCAN_CLOCKDR_LN0]
set_input_delay  $bscan_indly  -max -add -clock $txbscanclk_ln0 [get_ports tx_bscan_shiftdr_ln0]
set_input_delay  $bscan_indly  -max -add -clock $txbscanclk_ln0 [get_ports tx_bscan_tdi_ln0]
set_output_delay $bscan_outdly -max -add -clock $txbscanclk_ln0 [get_ports tx_bscan_tdo_ln0]

set txbscanclk_ln1 [get_clocks TX_BSCAN_CLOCKDR_LN1]
set_input_delay  $bscan_indly  -max -add -clock $txbscanclk_ln1 [get_ports tx_bscan_shiftdr_ln1]
set_input_delay  $bscan_indly  -max -add -clock $txbscanclk_ln1 [get_ports tx_bscan_tdi_ln1]
set_output_delay $bscan_outdly -max -add -clock $txbscanclk_ln1 [get_ports tx_bscan_tdo_ln1]

#############################################
## misc
#############################################

################################################################################
## Timing Exceptions
################################################################################
set_false_path -from [get_clocks IO_ASYNC]
set_false_path -to   [get_clocks IO_ASYNC]

set_false_path -from vclk_seq -to vclk_seq

#Synthesis
if { $load_syn_sdc && !$load_post_map_syn_sdc } {
} else {

   
   # Set false paths to analog scanin pins and from analog scanout pins.
   set_false_path -to      [get_pins { u_txm_ana/txda0_drv_scanin u_txm_ana/txda1_drv_scanin }]
   set_false_path -through [get_pins { u_txm_ana/*scanout }]

   # Set false paths to first flop in reset_sync logic.
   set_false_path -to [get_pins -hier { *genblk1_u_reset_sync_synth_*_1/D }]

   # Set false paths to first flop in data_sync logic.
   set_false_path -to [get_pins -hier { *genblk1_u_data_sync_synth_*_1/D }]

   # Set false paths for hold to all SYNC FFs, seeing fails despite lower uncertainty
   #set_false_path -hold -to [get_pins -hier { *genblk1_u_reset_sync_synth_2_*/D }]
   #set_false_path -hold -to [get_pins -hier { *genblk1_u_data_sync_synth_2_*/D }]

   # Loren confirmed that both reset_sync flops get asynchronous resets.
   set_false_path -to [get_pins -hier { \
                                            *genblk1_u_reset_sync_synth_*/CD \
                                         }]

}

# JMY Prevent timing from NRESTORE->Q pins on RSDF FFs, logic prevents this from being a critical path
#     as downstream clocks are off
# Updated syntax to make H240/H300 agnostic per Joey's modifications
if { [info exists load_syn_sdc] && $load_syn_sdc} {
} else {
   set_disable_timing [get_lib_cells RSDFRPQHDCWMZD*BWP*H*P*] -from NRESTORE -to Q
   set_disable_timing [get_lib_cells RSDFSNQHDCWMZD*BWP*H*P*] -from NRESTORE -to Q
   set_disable_timing [get_lib_cells RSDFSRPQHDCWMZD*BWP*H*P*] -from NRESTORE -to Q
}

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
# Input Driving cells
###############################################################################
if { $::DRIVING_CELL != "" } {
   set_driving_cell -lib_cell $::DRIVING_CELL -pin $::DRIVING_PIN $digital_input_port_collection
} else {
   puts "WARNING: DRIVING_CELL is not set. Skipping set_driving_cell command."
}

###############################################################################
#Output Port Load
###############################################################################
#set_load 0.010 $digital_output_port_collection
set_load 0.020 [get_ports [all_outputs]]
set_load 1.200 [get_ports { tx_m_ln0 tx_m_ln1 tx_p_ln0 tx_p_ln1 }]

#######################################
# Dont_Touch Nets
#######################################
# Power & Ground Connections
if { [info exists load_syn_sdc] && $load_syn_sdc} {
} else {
   set_dont_touch [get_nets $power_ground_port_list] 
}
# Cmn_ana connections that must remain pure from/to their respective pma_cmn I/O ports.
set_dont_touch [get_nets $analog_port_list]

# Added 05152020 to control strobe/enable skew (SER 21800/21801/21803/21804/21807) 
# TX DC calibration control signals
set_max_delay -to u_txm_ana/txda0_dc_cal_act_negcode*        1.2
set_max_delay -to u_txm_ana/txda0_dc_cal_act_poscode*        1.2
set_max_delay -to u_txm_ana/txda0_dc_cal_act_sign            1.2
set_max_delay -to u_txm_ana/txda0_dc_cal_act_strobe          1.2
set_max_delay -to u_txm_ana/txda0_dc_cal_act_en              1.2
set_max_delay -to u_txm_ana/txda1_dc_cal_act_negcode*        1.2
set_max_delay -to u_txm_ana/txda1_dc_cal_act_poscode*        1.2
set_max_delay -to u_txm_ana/txda1_dc_cal_act_sign            1.2
set_max_delay -to u_txm_ana/txda1_dc_cal_act_strobe          1.2
set_max_delay -to u_txm_ana/txda1_dc_cal_act_en              1.2
