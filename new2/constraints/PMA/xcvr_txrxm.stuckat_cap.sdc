###############################################################################
# These confidential and proprietary static timing constraints for a Hardware
# component may be used only as authorized by a licensing agreement from
# Cadence Design Systems, Inc. In the event of publication, the following
# notice is applicable:
#
#       (C) COPYRIGHT 2009 Cadence Design Systems, Inc.
#           ALL RIGHTS RESERVED
#
# The entire notice above must be reproduced on all authorized copies of
# this code.
###############################################################################
#
# Filename  : xcvr.atspeed_cap.tcl
# Version   : $Revision2638 $
# Date/Time : $Date2013-02-19 13:53:13 -0500 (Tue, 19 Feb 2013) $
#
# Author    : dmasters
# Edited by : dmasters
# Abstract  : Functional & ATPG timing constraints for pma_xcvr_lane.
#
###############################################################################
# Change Log
# $Log$
#
###############################################################################
# TAG: 05/09/2014
if { [info exists load_syn_sdc] && $load_syn_sdc} {
    source $DUT_PATH/design/constraints/PMA/xcvr_txrxm.preamble.sdc
} else {
    source [file dirname [info script]]/xcvr_txrxm.preamble.sdc
}

current_design  xcvr_txrxm




###############################################################################
# set_case_analysis
###############################################################################

set_case_analysis 1 [get_ports { xcvr_scanmode }]


#######################################
# Clock definitions
#######################################
############################################
# ref_clk domain
############################################
#create_clock \
#   -name      REFCLK_SCAP_IN \
#   -period    $STUCKAT_PERIOD \
#   -waveform  $STUCKAT_WAVEFORM\
#   [get_ports { cmn_ref_clk_in }]

#create_clock \
#   -name      REFCLK_SCAP_OUT \
#   -period    $STUCKAT_PERIOD \
#   -waveform  $STUCKAT_WAVEFORM\
#   [get_ports { cmn_ref_clk_out }]

# Input scan clock cmn_scanclk_ref_clk_in pin.
create_clock \
   -name     SCAN_REFCLK_SCAP_IN \
   -period   $STUCKAT_PERIOD \
   -waveform $STUCKAT_WAVEFORM \
   [get_ports { cmn_scanclk_ref_clk_in }]

# Create scan clocks on cmn_ref_clk and cmn_ref_clk_gated
# pins so I/O data can be timed against them.

create_clock \
   -name      REFCLK_SCAP_GATED_IN \
   -period    $STUCKAT_PERIOD \
   -waveform  $STUCKAT_WAVEFORM \
   [get_ports cmn_ref_clk_gated_in]

############################################
# PSM domain
############################################

create_clock \
    -name     PSMCLK_SCAP \
    -period   $STUCKAT_PERIOD \
    -waveform $STUCKAT_WAVEFORM \
    -add \
    [get_ports xcvr_psm_clk]

############################################
# pclk domain
############################################

create_clock \
   -name     CDBCLK_SCAP_IN \
   -period   $STUCKAT_PERIOD \
   -waveform $STUCKAT_WAVEFORM \
   [get_ports { cmn_cdb_pclk_in }]


create_clock \
   -name     CDBCLK_SCAP_OUT \
   -period   $STUCKAT_PERIOD \
   -waveform $STUCKAT_WAVEFORM \
   [get_ports { cmn_cdb_pclk_out }]

############################################
# ser_clk domain
############################################

   create_clock \
      -name     TXTDCLK_SCAP \
      -period   $STUCKAT_PERIOD \
      -waveform $STUCKAT_WAVEFORM \
      -add \
      [get_ports tx_td_clk]

   create_clock \
      -name     SERCLK_SCAP \
      -period   $STUCKAT_PERIOD \
      -waveform $STUCKAT_WAVEFORM \
      -add \
      [get_ports xcvr_scanclk_ser_clk]

   create_generated_clock \
      -name         RXRDCLK_SCAP_OUT \
      -divide_by    1 \
      -master_clock [get_clocks SERCLK_SCAP] \
      -source       [get_ports xcvr_scanclk_ser_clk] \
      -add \
      [get_ports rx_rd_clk]
   
# Full-rate and data-rate clocks. These clocks are not used to time 
# I/O data in any mode but we'll generate arcs from them regardless.
   create_clock \
      -name     CMN_SERCLK_SCAP \
      -period   $STUCKAT_PERIOD \
      -waveform $STUCKAT_WAVEFORM \
      -add \
      [get_ports cmn_pll0_clk_0_scanned_in]

   create_generated_clock \
      -name         FULLRT_SCAP_OUT \
      -divide_by    1 \
      -master_clock [get_clocks { CMN_SERCLK_SCAP }] \
      -source [get_ports { cmn_pll0_clk_0_scanned_in }] \
      -add \
      [get_ports xcvr_pll_clk_fullrt]

   create_generated_clock \
      -name         DATART_SCAP_OUT \
      -divide_by    1 \
      -master_clock [get_clocks { CMN_SERCLK_SCAP }] \
      -source [get_ports { cmn_pll0_clk_0_scanned_in }] \
      -add \
      [get_ports xcvr_pll_clk_datart]

#################################################################
# PLL*CLK Domain
#################################################################
create_clock \
    -name           PLL0CLK0_FULLRT_SCAP \
    -period   $STUCKAT_PERIOD \
    -waveform $STUCKAT_WAVEFORM \
    -add \
    [get_ports cmn_pll0_clk_0_scanned_in]

create_clock \
    -name           PLL0CLK1_FULLRT_SCAP \
    -period   $STUCKAT_PERIOD \
    -waveform $STUCKAT_WAVEFORM \
    -add \
    [get_ports cmn_pll0_clk_1_scanned_in]

create_clock \
    -name           PLL1CLK0_FULLRT_SCAP \
    -period   $STUCKAT_PERIOD \
    -waveform $STUCKAT_WAVEFORM \
    -add \
    [get_ports cmn_pll1_clk_0_scanned_in]

create_clock \
    -name           PLL1CLK1_FULLRT_SCAP \
    -period   $STUCKAT_PERIOD \
    -waveform $STUCKAT_WAVEFORM \
    -add \
    [get_ports cmn_pll1_clk_1_scanned_in]

############################################
# SD_CLK domain
############################################
   create_clock \
      -name     SDCLK_SCAP \
      -period   $STUCKAT_PERIOD \
      -waveform $STUCKAT_WAVEFORM \
      -add \
      [get_ports xcvr_scanclk_pll_clk]


############################################
# Misc clocks
############################################

# Assign a clock to the boundary scan clock inputs even though the logic
# is not scanned.

   create_clock \
      -name     BSCAN_CLK0 \
      -period   $BSCAN_PERIOD \
      -waveform $BSCAN_WAVEFORM \
      [get_ports {tx_bscan_clockdr }]

   create_clock \
      -name     BSCAN_CLK1 \
      -period   $BSCAN_PERIOD \
      -waveform $BSCAN_WAVEFORM \
      [get_ports { tx_bscan_updatedr }]

   create_clock \
      -name     BSCAN_CLK2 \
      -period   $BSCAN_PERIOD \
      -waveform $BSCAN_WAVEFORM \
      [get_ports { rx_bscan_clockdr }]

   create_clock \
      -name     BSCAN_CLK3 \
      -period   $BSCAN_PERIOD \
      -waveform $BSCAN_WAVEFORM \
      [get_ports { rx_bscan_pc }]

#######################################
# Virtual Clocks
#######################################
# For asynchronous reset timing. This phase is NOT excluded from other clocks 
# so we can detect if an asynchronous reset goes logic other than reset 
# synchronization logic.
create_clock                                  \
            -name IO_RESET                    \
            -period   $ASYNC_PERIOD           \
            -waveform $ASYNC_WAVEFORM

# Asynchronous clock phases. This phase is excluded from all other clocks.
create_clock \
    -name           IO_ASYNC \
    -period         $ASYNC_PERIOD \
    -waveform       $ASYNC_WAVEFORM

###############################################################################
# Clock Uncertainties
###############################################################################
set default_margin 5.000

#########################################################################
# Default uncertainties. Default setup is high in order to catch
# unaccounted for clock relationships.
#########################################################################
set_clock_uncertainty  $default_margin -setup -from [all_clocks] -to [all_clocks]
set_clock_uncertainty  $hold_margin    -hold  -from [all_clocks] -to [all_clocks]


#######################################
# SCAN Clocks
#######################################
set_clock_uncertainty   $setup_margin \
                        -setup \
                        -from   [get_clocks { \
                                            SCAN_REFCLK_SCAP_IN \
                                            REFCLK_SCAP_GATED_IN \
                                            PSMCLK_SCAP \
                                            CDBCLK_SCAP_IN \
                                            CDBCLK_SCAP_OUT \
                                            TXTDCLK_SCAP \
                                            SERCLK_SCAP \
					    CMN_SERCLK_SCAP \
                                            PLL*CLK*_FULLRT_SCAP \
					    SDCLK_SCAP \
                                            RXRDCLK_SCAP_OUT \
                                            BSCAN_CLK* \
                                            } \
                                ] \
                        -to     [get_clocks { \
                                            SCAN_REFCLK_SCAP_IN \
                                            REFCLK_SCAP_GATED_IN \
                                            PSMCLK_SCAP \
                                            CDBCLK_SCAP_IN \
                                            CDBCLK_SCAP_OUT \
                                            TXTDCLK_SCAP \
                                            SERCLK_SCAP \
					    CMN_SERCLK_SCAP \
                                            PLL*CLK*_FULLRT_SCAP \
					    SDCLK_SCAP \
                                            RXRDCLK_SCAP_OUT \
                                            BSCAN_CLK* \
                                            } \
                                ]

set_clock_uncertainty   $setup_margin \
                        -setup \
                        -from   [get_clocks IO_ASYNC] \
                        -to     [get_clocks IO_ASYNC]

# Reduce uncertainty for MTBF flops (except for the one case that is not a real data_sync case).
set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_genblk1_u_data_sync_synth_*_2/CP }]
set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_genblk1_u_data_sync_synth_*_3/CP }]
set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_genblk1_u_data_sync_synth_*_4/CP }]
set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_u_reset_sync_synth_*_2/CP }]
set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_u_reset_sync_synth_*_3/CP }]
set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_u_reset_sync_synth_*_4/CP }]
#set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_u_lfps_sync_synth_*_2/CP }]
#set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_u_lfps_sync_synth_*_3/CP }]
#set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_u_lfps_sync_synth_*_4/CP }]
#set_clock_uncertainty 0.035 -hold [get_pins -hier { *genblk1_u_reset_sync_synth_*_4/D }]

set_false_path -hold -to [get_pins -hier *genblk1_genblk1_u_data_sync_synth_*_2/D]
set_false_path -hold -to [get_pins -hier *genblk1_genblk1_u_data_sync_synth_*_3/D]
set_false_path -hold -to [get_pins -hier *genblk1_genblk1_u_data_sync_synth_*_4/D]
set_false_path -hold -to [get_pins -hier *genblk1_u_reset_sync_synth_*_2/D]
set_false_path -hold -to [get_pins -hier *genblk1_u_reset_sync_synth_*_3/D]
#set_false_path -hold -to [get_pins -hier { *genblk1_u_reset_sync_synth_*_4/D }]

###############################################################################
# Clock latency for clocks from common.
#-early | -late
# Specifies clock arrival time with respect to the early or the late time of the clock signal.
#In setup analysis, launch path is the late path and capture path is the early path.
#In hold analysis, launch path is the early path and the capture path is the late path. 
#If neither parameter is specified, the default is both early and late. 
 
###############################################################################
set_clock_latency 0.45 -source -max [get_ports {cmn_cdb_pclk_in}] -clock [get_clocks {CDBCLK_SCAP_IN}]
set_clock_latency 0.40 -source -min [get_ports {cmn_cdb_pclk_in}] -clock [get_clocks {CDBCLK_SCAP_IN}]

###############################################################################
# Clock uncertainty
###############################################################################
# Note: PreCTS uncertainty 150ps, postCTS uncertainty 100ps, SI uncertainty: 75ps
# hold uncertainty 50ps
###############################################################################

# Add extra uncertainty to account for clock skew between the ser_clk and tx_tdclk
#set_clock_uncertainty [expr 0.150 + 0.125] -setup \
#   -from [get_clocks { SERCLK_SCAP }]  -to [get_clocks { TXTDCLK_SCAP }]
#set_clock_uncertainty [expr 0.150 + 0.125] -setup \
#   -from [get_clocks { TXTDCLK_SCAP }]  -to [get_clocks { SERCLK_SCAP }]
# Relaxed from 125 ps to 100 ps to make timing easier.
#set_clock_uncertainty [expr 0.055 + 0.100] -hold \
#   -from [get_clocks { SERCLK_SCAP }]  -to [get_clocks { TXTDCLK_SCAP }]
#set_clock_uncertainty [expr 0.055 + 0.100] -hold \
#   -from [get_clocks { TXTDCLK_SCAP }]  -to [get_clocks { SERCLK_SCAP }]

###############################################################################
# Clock Groups
###############################################################################
set_clock_groups -asynchronous -name grp_scap_async  -group {IO_ASYNC}
set_clock_groups -asynchronous -name grp_scap_refclk -group {REFCLK_* SCAN_REFCLK*}
set_clock_groups -asynchronous -name grp_scap_psmclk -group {PSMCLK_SCAP*}
set_clock_groups -asynchronous -name grp_scap_sdclk -group { SDCLK_SCAP }
set_clock_groups -asynchronous -name grp_scap_serclk -group {SERCLK_SCAP TXTDCLK_SCAP RXRDCLK_SCAP_OUT FULLRT* DATART*}
set_clock_groups -asynchronous -name grp_scap_pllclk -group {PLL*CLK*_FULLRT_SCAP}
set_clock_groups -asynchronous -name grp_scan_bscan  -group { BSCAN_CLK* }
set_clock_groups -asynchronous -name grp_shift_pclk  -group { CDBCLK_SCAP* }


###############################################################################
# I/O Timing
###############################################################################
set IO_DELAY [expr round(($SCAPCLK_PERIOD * 4.0 / 10.0) * 100) / 100.0]

set_input_delay $IO_DELAY  -max -add -clock [get_clocks { SCAN_REFCLK_SCAP_IN }]   $data_input_port_collection
set_input_delay $IO_DELAY  -max -add -clock [get_clocks { REFCLK_SCAP_GATED_IN }]  $data_input_port_collection
set_input_delay $IO_DELAY  -max -add -clock [get_clocks { CDBCLK_SCAP_IN }]        $data_input_port_collection
set_input_delay $IO_DELAY  -max -add -clock [get_clocks { CDBCLK_SCAP_OUT }]       $data_input_port_collection
set_input_delay $IO_DELAY  -max -add -clock [get_clocks { TXTDCLK_SCAP }]          $data_input_port_collection
set_input_delay $IO_DELAY  -max -add -clock [get_clocks { SERCLK_SCAP }]           $data_input_port_collection
set_input_delay $IO_DELAY  -max -add -clock [get_clocks { SDCLK_SCAP }]            $data_input_port_collection
set_input_delay $IO_DELAY  -max -add -clock [get_clocks { RXRDCLK_SCAP_OUT }]      $data_input_port_collection
set_input_delay $IO_DELAY  -max -add -clock [get_clocks { PSMCLK_SCAP }]           $data_input_port_collection

# Feedthrough path adjustment overrides to reduce overly large negative slacks.


set_input_delay  2.0 -max -clock [get_clocks SERCLK_SCAP] [get_ports cmn_clock_stop_req_in]
set_input_delay  2.0 -max -clock [get_clocks SERCLK_SCAP] [get_ports xcvr_scanen]
set_input_delay  2.0 -max -clock [get_clocks SERCLK_SCAP] [get_ports xcvr_power_state_en_token_in_ibs]
set_input_delay  2.0 -max -clock [get_clocks SERCLK_SCAP] [get_ports cmn_clock_stop_req_in]

set_output_delay 2.0 -max -clock [get_clocks SERCLK_SCAP] [get_ports cmn_clock_stop_req_out]
set_output_delay 2.0 -max -clock [get_clocks SERCLK_SCAP] [get_ports xcvr_power_state_en_token_out_ibs]
set_output_delay 2.0 -max -clock [get_clocks SERCLK_SCAP] [get_ports xcvr_power_state_en_token_out_obs]
set_output_delay 2.0 -max -clock [get_clocks SERCLK_SCAP] [get_ports cmn_clock_stop_req_out]


set_output_delay 3.0 -max -clock [get_clocks CDBCLK_SCAP_IN]   [get_ports xcvr_scanout[*]]


###############################################################################
# Exceptions
###############################################################################

# Loren confirmed that both reset_sync flops get asynchronous resets.
set_false_path -to [get_pins -hier { \
   *genblk1_u_reset_sync_synth_2_*/CD \
   *genblk1_u_reset_sync_synth_3_*/CD \
   *genblk1_u_reset_sync_synth_4_*/CD \
}]

# Set false paths to analog scanin pins and from analog scanout pins.
set_false_path -through $xcvr_ana_cdrlf_scan_pins
set_false_path -through $xcvr_ana_drv_scan_pins

# Set false paths through macro scanin/scanout ports.
set_false_path -through [get_ports { *_scanin* *_scanout* }]

# Don't check boundary scan timing in this mode.
set_false_path -from [get_clocks { BSCAN_CLK* }] -to [get_clocks { BSCAN_CLK* }]

# This reuse logic is in the Common but should have been synthesized away.
#set_false_path -hold \
#   -through [get_pins { u_pma_rev/u_cmn/u_cmn_dsync/u_sync_fifo/fifo_array_reg[*][*]/Q* }] \
#   -to      [get_pins { u_pma_rev/u_cmn/u_cmn_dsync/txda_ser_data_pipe_d1_reg[*]/D }]
#set_false_path -hold \
#   -through [get_pins { u_pma_rev/u_cmn/u_cmn_dsync/u_sync_fifo/fifo_array_reg[*][*]/Q }] \
#   -to      [get_pins { u_pma_rev/u_cmn/u_cmn_dsync/sync_fifo_elec_idle_pipe_d1_reg/D }]
#
#set_false_path -hold \
#   -through [get_pins { u_pma_rev/u_cmn/u_cmn_dsync/u_sync_fifo/fifo_array_reg[*][*]/QN }] \
#   -to      [get_pins { u_pma_rev/u_cmn/u_cmn_dsync/sync_fifo_elec_idle_pipe_d1_reg/D }]

# Multicycle paths
#set_multicycle_path -setup 3 -through [get_ports { xcvr_lane_master_ln_* }]
#set_multicycle_path -hold  2 -through [get_ports { xcvr_lane_master_ln_* }]
set_multicycle_path -setup 2 -through [get_ports { xcvr_data_width*[*] }]
set_multicycle_path -hold  1 -through [get_ports { xcvr_data_width*[*] }]
#set_multicycle_path -setup 2 -through [get_ports { xcvr_pll_clk_en_ln_* }] -to [get_pins -hier { *genblk1_genblk1_u_data_sync_synth_4_1/D }]
#set_multicycle_path -hold  1 -through [get_ports { xcvr_pll_clk_en_ln_* }] -to [get_pins -hier { *genblk1_genblk1_u_data_sync_synth_4_1/D }]

#set_multicycle_path -setup 2 \
#   -through [get_pins { u_pma_rev/u_xcvr_*/u_xcvr_ctrl/u_xcvr_ctrl_clkrst/u_clk_gating_cell_xcvr_pll_clk_fullrt/genblk3_u_data_delay_en_ack/data_delay_flop_reg[*]/Q }] \
#   -to      [get_ports { xcvr_pll_clk_en_ack_ln_* }]
#set_multicycle_path -hold  1 \
#   -through [get_pins { u_pma_rev/u_xcvr_*/u_xcvr_ctrl/u_xcvr_ctrl_clkrst/u_clk_gating_cell_xcvr_pll_clk_fullrt/genblk3_u_data_delay_en_ack/data_delay_flop_reg[*]/Q }] \
#   -to      [get_ports { xcvr_pll_clk_en_ack_ln_* }]

#set_multicycle_path -setup 2 \
#   -through [get_pins { u_pma_rev/u_xcvr_*/u_xcvr_ctrl/u_power_sm_6_v2_apb/u_power_sm_6_v2_sr/u_power_multical_sm/sub_cal_run_shift_reg_reg[3]/Q }] \
#   -to      [get_pins { u_pma_rev/u_xcvr_*/u_xcvr_ctrl/u_power_sm_6_v2_apb/u_power_sm_6_v2_sr/u_power_multical_sm/genblk1_3_u_data_sync_sub_cal_done/u_data_sync_synth/genblk1_genblk1_u_data_sync_synth_2_1/D }]
#set_multicycle_path -hold  1 \
#   -through [get_pins { u_pma_rev/u_xcvr_*/u_xcvr_ctrl/u_power_sm_6_v2_apb/u_power_sm_6_v2_sr/u_power_multical_sm/sub_cal_run_shift_reg_reg[3]/Q }] \
#   -to      [get_pins { u_pma_rev/u_xcvr_*/u_xcvr_ctrl/u_power_sm_6_v2_apb/u_power_sm_6_v2_sr/u_power_multical_sm/genblk1_3_u_data_sync_sub_cal_done/u_data_sync_synth/genblk1_genblk1_u_data_sync_synth_2_1/D }]

# In2out multicycle paths
set_multicycle_path -setup 2 -through [get_ports { rx_termination  }] -through [get_ports { rx_signal_detect }]
set_multicycle_path -hold  1 -through [get_ports { rx_termination  }] -through [get_ports { rx_signal_detect }]
set_multicycle_path -setup 2 -through [get_ports { rx_sig_det_en_ext }] -through [get_ports { rx_signal_detect }]
set_multicycle_path -hold  1 -through [get_ports { rx_sig_det_en_ext }] -through [get_ports { rx_signal_detect }]
set_multicycle_path -setup 2 -through [get_ports { rx_differential_invert }] -through [get_ports { rx_rd[*] }]
set_multicycle_path -hold  1 -through [get_ports { rx_differential_invert }] -through [get_ports { rx_rd[*] }]
set_multicycle_path -setup 2 -through [get_ports { xcvr_lpbk_ne_parallel_en }] -through [get_ports { rx_signal_detect }]
set_multicycle_path -hold  1 -through [get_ports { xcvr_lpbk_ne_parallel_en }] -through [get_ports { rx_signal_detect }]

#set_multicycle_path -setup 2 -through [get_ports { cmn_macro_en }] -to [get_pins { u_pma_rev/u_cmn/u_cmn_func/u_data_sync_xcvr_clk_buf_en_*/u_data_sync_synth/special_genblk1_genblk1_u_data_sync_synth_4/D }]
#set_multicycle_path -hold  1 -through [get_ports { cmn_macro_en }] -to [get_pins { u_pma_rev/u_cmn/u_cmn_func/u_data_sync_xcvr_clk_buf_en_*/u_data_sync_synth/special_genblk1_genblk1_u_data_sync_synth_4/D }]
#set_multicycle_path -setup 2 -through [get_ports { cmn_macro_en }] -to [get_pins { u_pma_rev/u_cmn/u_cmn_func/ECO_SER_3751_*_sync2D_inst/D }]
#set_multicycle_path -hold  1 -through [get_ports { cmn_macro_en }] -to [get_pins { u_pma_rev/u_cmn/u_cmn_func/ECO_SER_3751_*_sync2D_inst/D }]
#set_multicycle_path -setup 2 -through [get_ports { xcvr_pll_clk_en }] -to [get_pins { u_pma_rev/*/u_xcvr_ctrl/u_xcvr_ctrl_clkrst/u_clock_div_prog_pll_clk/genblk1_u_reset_sync/u_reset_sync_synth/special_genblk1_genblk1_u_reset_sync_synth_4/D }]
#set_multicycle_path -hold  1 -through [get_ports { xcvr_pll_clk_en }] -to [get_pins { u_pma_rev/*/u_xcvr_ctrl/u_xcvr_ctrl_clkrst/u_clock_div_prog_pll_clk/genblk1_u_reset_sync/u_reset_sync_synth/special_genblk1_genblk1_u_reset_sync_synth_4/D }]

# reset signals

# Constant and aync signals
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_lpbk_serial_en}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_lpbk_fe_parallel_en}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_lpbk_ne_parallel_en}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_lpbk_line_en}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_lpbk_isi_gen_en}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_lpbk_recovered_clk_en}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_rcv_detect_en}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_deemphasis[*]}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_vmargin[*]}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_low_power_swing_en}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_differential_invert}]

set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_termination}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_differential_invert}]

set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}]   [get_ports {lane_addr[*]}]

set_input_delay 1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_cmn_mode_en_ext}]

# DSM new
set_input_delay 1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports { \
                                                                         xcvr_pll_clk_en \
                                                                         rx_sig_det_en_ext \
                                                                         xcvr_link_reset_n \
                                                                        }]
set_input_delay 1.0 -max -add -clock [get_clocks {SERCLK_SCAP}] [get_ports { \
                                                                         cmn_clock_stop_req_in\
                                                                         cmn_macro_suspend_ack_in \
                                                                         xcvr_pll_clk_en \
                                                                         cmn_ready_in \
                                                                         rx_reset_n \
                                                                         tx_clk_reset_req_in \
                                                                         tx_reset_n \
                                                                         xcvr_clk_buf_en_0_in \
                                                                         xcvr_clk_buf_en_1_in \
                                                                         xcvr_clk_buf_en_0_del_in \
                                                                         xcvr_clk_buf_en_1_del_in \                                                                         
                                                                         xcvr_link_reset_n \
                                                                         xcvr_lnr \
                                                                        }]
#set_input_delay 1.0 -max -add -clock [get_clocks {REFCLK_SCAP_IN}] [get_ports { \
#                                                                         xcvr_decap_en_in \
#                                                                         xctrl_power_enable_ph1_time_in[*] \
#                                                                         xctrl_power_enable_ph2_time_in[*] \
#                                                                         xctrl_power_suspend_req_in \
#                                                                         xctrl_power_recover_req_in \
#                                                                         xctrl_power_suspend_ack_in \
#                                                                         xctrl_power_recover_ack_in \
#                                                                         xcvr_power_state_a4_in \
#                                                                 }]
set_input_delay 1.0 -max -add -clock [get_clocks {REFCLK_SCAP_GATED_IN}] [get_ports { \
                                                                         xcvr_lane_suspend \
                                                                        }]
set_input_delay 1.0 -max -add -clock [get_clocks {TXTDCLK_SCAP}] [get_ports { \
                                                                         xcvr_lnr \
                                                                   }]

#set_output_delay 2.5 -max -add -clock [get_clocks {REFCLK_SCAP_IN}] [get_ports {xcvr_decap_en_out}]
#changed this to max delay to get good delay out in the .lib ( nov27 2013)

set_output_delay 0.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_signal_detect}]
set_output_delay 0.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_pi_val[*]}]
set_output_delay 0.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_eye_plot_pi_val[*]}]

set_output_delay 0.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_in_ibs_tie_high[*]}]
set_output_delay 0.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_in_ibs_tie_low[*]}]
set_output_delay 0.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {lane_addr_tie_high}]
set_output_delay 0.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {lane_addr_tie_low}]

# DSM new
set_output_delay 0.0 -max -add -clock [get_clocks {SERCLK_SCAP}] [get_ports { \
                                                                          xcvr_pll_clk_en_ack \
                                                                         }]
set_output_delay 0.0 -max -add -clock [get_clocks {SERCLK_SCAP}] [get_ports { \
                                                                          cmn_clock_stop_req_out \
                                                                          cmn_macro_suspend_ack_out \
                                                                          cmn_ready_out \
                                                                          cmn_scanclk_ref_clk_out \
                                                                          rx_cdrlf_fphl_locked \
                                                                          tx_clk_reset_ack_out \
                                                                          tx_clk_reset_req_out \
                                                                          tx_clk_reset_stp_out \
                                                                          xcvr_clk_buf_en_0_out \
                                                                          xcvr_clk_buf_en_1_out \
                                                                          xcvr_clk_buf_en_0_del_out \
                                                                          xcvr_clk_buf_en_1_del_out \
                                                                         }]
set_output_delay 0.0 -max -add -clock [get_clocks {CDBCLK_SCAP_IN}] [get_ports { \
                                                                          xcvr_clk_buf_en_0_out \
                                                                          xcvr_clk_buf_en_1_out \
                                                                          xcvr_clk_buf_en_0_del_out \
                                                                          xcvr_clk_buf_en_1_del_out \
                                                                         }]
#set_output_delay 0.0 -max -add -clock [get_clocks {REFCLK_SCAP_IN}] [get_ports { \
#                                                                          xctrl_power_suspend_req_out \
#                                                                          xctrl_power_recover_req_out \
#                                                                          xctrl_power_suspend_ack_out \
#                                                                          xctrl_power_recover_ack_out \
#                                                                          xcvr_power_state_a4_out \
#                                                                         }]
set_output_delay 0.0 -max -add -clock [get_clocks {REFCLK_SCAP_GATED_IN}] [get_ports { \
                                                                          tx_rcv_detected \
                                                                          tx_rcv_detect_done \
                                                                         }]
#
#Signals from common, and pass throughs to lanes.
#
#set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {cmn_scanclk_ref_clk_in}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_data_width[*]}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_data_width[*]}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_data_width[*]}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {cmn_atb_en_in}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {cmn_atb_sel_in}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {cmn_reset_n_in}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {cmn_cdb_preset_n_in}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {cmn_reset_sync_n_in}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_sig_det_en_ext}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_rescal_code_in[*]}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_standard_mode[*]}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_standard_mode[*]}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_standard_mode[*]}]


#outputs pass thru signals have their set_output_delay commented out since we
#don't want the timing engine to time these wrt IO_ASYNC clocks and give out
#false big violations due to this clock's high uncertainty
## adding the input delay to the max delay to fix issue in STA.
set_max_delay 1.5 -from [get_ports {cmn_reset_n_in}] -to [get_ports {cmn_reset_n_out}]
set_min_delay 0.7 -from [get_ports {cmn_reset_n_in}] -to [get_ports {cmn_reset_n_out}]
set_max_delay 1.5 -from [get_ports {cmn_reset_sync_n_in}] -to [get_ports {cmn_reset_sync_n_out}]
set_min_delay 0.7 -from [get_ports {cmn_reset_sync_n_in}] -to [get_ports {cmn_reset_sync_n_out}]
set_max_delay 1.5 -from [get_ports {cmn_atb_en_in}] -to [get_ports {cmn_atb_en_out}]
set_min_delay 0.7 -from [get_ports {cmn_atb_en_in}] -to [get_ports {cmn_atb_en_out}]
set_max_delay 1.5 -from [get_ports {cmn_atb_sel_in[*]}] -to [get_ports {cmn_atb_sel_out[*]}]
set_min_delay 0.7 -from [get_ports {cmn_atb_sel_in[*]}] -to [get_ports {cmn_atb_sel_out[*]}]
set_max_delay 1.5 -from [get_ports {cmn_cdb_preset_n_in}] -to [get_ports {cmn_cdb_preset_n_out}]
set_min_delay 0.7 -from [get_ports {cmn_cdb_preset_n_in}] -to [get_ports {cmn_cdb_preset_n_out}]

set_max_delay 2.000 -from [get_ports rx_rescal_code_in[2]] -to [get_ports rx_rescal_code_out[2]] 
set_min_delay 1.975 -from [get_ports rx_rescal_code_in[2]] -to [get_ports rx_rescal_code_out[2]] 
set_max_delay 2.000 -from [get_ports rx_rescal_code_in[1]] -to [get_ports rx_rescal_code_out[1]] 
set_min_delay 1.975 -from [get_ports rx_rescal_code_in[1]] -to [get_ports rx_rescal_code_out[1]] 
set_max_delay 2.000 -from [get_ports rx_rescal_code_in[0]] -to [get_ports rx_rescal_code_out[0]] 
set_min_delay 1.975 -from [get_ports rx_rescal_code_in[0]] -to [get_ports rx_rescal_code_out[0]] 

set_input_delay 2.4 -max -clock [get_clocks {CDBCLK_SCAP_IN}] [get_ports {cdb_tx_psel_in}]  -add_delay 
set_input_delay 2.4 -max -clock [get_clocks {CDBCLK_SCAP_IN}] [get_ports {cdb_rx_psel_in}]  -add_delay 
set_input_delay 2.4 -max -clock [get_clocks {CDBCLK_SCAP_IN}] [get_ports {cdb_txrx_paddr_in[*]}]  -add_delay 
set_input_delay 2.4 -max -clock [get_clocks {CDBCLK_SCAP_IN}] [get_ports {cdb_txrx_pwdata_in[*]}]  -add_delay 
set_input_delay 2.4 -max -clock [get_clocks {CDBCLK_SCAP_IN}] [get_ports {cdb_txrx_pwrite_in}]  -add_delay 
set_input_delay 2.4 -max -clock [get_clocks {CDBCLK_SCAP_IN}] [get_ports {cdb_txrx_plinkmultiwrite_in}]  -add_delay 
set_input_delay 2.4 -max -clock [get_clocks {CDBCLK_SCAP_IN}] [get_ports {cdb_tx_penable_in}]  -add_delay 
set_input_delay 2.4 -max -clock [get_clocks {CDBCLK_SCAP_IN}] [get_ports {cdb_rx_penable_in}]  -add_delay

set_input_delay 0.75 -min -clock [get_clocks {CDBCLK_SCAP_IN}] [get_ports {cdb_tx_psel_in}]  -add_delay 
set_input_delay 0.75 -min -clock [get_clocks {CDBCLK_SCAP_IN}] [get_ports {cdb_rx_psel_in}]  -add_delay 
set_input_delay 0.75 -min -clock [get_clocks {CDBCLK_SCAP_IN}] [get_ports {cdb_txrx_paddr_in[*]}]  -add_delay 
set_input_delay 0.75 -min -clock [get_clocks {CDBCLK_SCAP_IN}] [get_ports {cdb_txrx_pwdata_in[*]}]  -add_delay 
set_input_delay 0.75 -min -clock [get_clocks {CDBCLK_SCAP_IN}] [get_ports {cdb_txrx_pwrite_in}]  -add_delay 
set_input_delay 0.75 -min -clock [get_clocks {CDBCLK_SCAP_IN}] [get_ports {cdb_txrx_plinkmultiwrite_in}]  -add_delay 
set_input_delay 0.75 -min -clock [get_clocks {CDBCLK_SCAP_IN}] [get_ports {cdb_tx_penable_in}]  -add_delay 
set_input_delay 0.75 -min -clock [get_clocks {CDBCLK_SCAP_IN}] [get_ports {cdb_rx_penable_in}]  -add_delay

set_input_delay 1.0 -clock [get_clocks {IO_ASYNC}] [get_ports {cdb_txrx_prdata_in[*]}]  -add_delay 
set_input_delay 1.0 -clock [get_clocks {IO_ASYNC}] [get_ports {cdb_tx_pready_in}]  -add_delay 
set_input_delay 1.0 -clock [get_clocks {IO_ASYNC}] [get_ports {cdb_rx_pready_in}]  -add_delay 

set_max_delay 2.600 -from [get_ports cdb_tx_psel_in] -to [get_ports cdb_tx_psel_out] 
set_min_delay 0.790 -from [get_ports cdb_tx_psel_in] -to [get_ports cdb_tx_psel_out] 
set_max_delay 2.600 -from [get_ports cdb_rx_psel_in] -to [get_ports cdb_rx_psel_out]
set_min_delay 0.790 -from [get_ports cdb_rx_psel_in] -to [get_ports cdb_rx_psel_out] 

set_max_delay 2.600 -from [get_ports cdb_tx_penable_in] -to [get_ports cdb_tx_penable_out]
set_min_delay 0.790 -from [get_ports cdb_tx_penable_in] -to [get_ports cdb_tx_penable_out] 
set_max_delay 2.600 -from [get_ports cdb_rx_penable_in] -to [get_ports cdb_rx_penable_out]
set_min_delay 0.790 -from [get_ports cdb_rx_penable_in] -to [get_ports cdb_rx_penable_out] 

set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[13]] -to  [get_ports cdb_txrx_paddr_out[13]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[13]] -to  [get_ports cdb_txrx_paddr_out[13]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[12]] -to  [get_ports cdb_txrx_paddr_out[12]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[12]] -to  [get_ports cdb_txrx_paddr_out[12]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[11]] -to  [get_ports cdb_txrx_paddr_out[11]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[11]] -to  [get_ports cdb_txrx_paddr_out[11]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[10]] -to  [get_ports cdb_txrx_paddr_out[10]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[10]] -to  [get_ports cdb_txrx_paddr_out[10]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[9]] -to  [get_ports cdb_txrx_paddr_out[9]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[9]] -to  [get_ports cdb_txrx_paddr_out[9]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[8]] -to  [get_ports cdb_txrx_paddr_out[8]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[8]] -to  [get_ports cdb_txrx_paddr_out[8]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[7]] -to  [get_ports cdb_txrx_paddr_out[7]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[7]] -to  [get_ports cdb_txrx_paddr_out[7]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[6]] -to  [get_ports cdb_txrx_paddr_out[6]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[6]] -to  [get_ports cdb_txrx_paddr_out[6]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[5]] -to  [get_ports cdb_txrx_paddr_out[5]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[5]] -to  [get_ports cdb_txrx_paddr_out[5]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[4]] -to  [get_ports cdb_txrx_paddr_out[4]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[4]] -to  [get_ports cdb_txrx_paddr_out[4]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[3]] -to  [get_ports cdb_txrx_paddr_out[3]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[3]] -to  [get_ports cdb_txrx_paddr_out[3]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[2]] -to  [get_ports cdb_txrx_paddr_out[2]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[2]] -to  [get_ports cdb_txrx_paddr_out[2]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[1]] -to  [get_ports cdb_txrx_paddr_out[1]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[1]] -to  [get_ports cdb_txrx_paddr_out[1]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[0]] -to  [get_ports cdb_txrx_paddr_out[0]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[0]] -to  [get_ports cdb_txrx_paddr_out[0]]  

set_max_delay 2.600 -from [get_ports cdb_txrx_plinkmultiwrite_in] -to [get_ports cdb_txrx_plinkmultiwrite_out] 
set_min_delay 0.790 -from [get_ports cdb_txrx_plinkmultiwrite_in] -to [get_ports cdb_txrx_plinkmultiwrite_out]  

set_max_delay 2.600 -from [get_ports {cdb_txrx_pwrite_in}] -to  [get_ports {cdb_txrx_pwrite_out}] 
set_min_delay 0.790 -from [get_ports {cdb_txrx_pwrite_in}] -to  [get_ports {cdb_txrx_pwrite_out}]  

set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[15]] -to [get_ports cdb_txrx_pwdata_out[15]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[15]] -to [get_ports cdb_txrx_pwdata_out[15]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[14]] -to [get_ports cdb_txrx_pwdata_out[14]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[14]] -to [get_ports cdb_txrx_pwdata_out[14]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[13]] -to [get_ports cdb_txrx_pwdata_out[13]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[13]] -to [get_ports cdb_txrx_pwdata_out[13]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[12]] -to [get_ports cdb_txrx_pwdata_out[12]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[12]] -to [get_ports cdb_txrx_pwdata_out[12]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[11]] -to [get_ports cdb_txrx_pwdata_out[11]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[11]] -to [get_ports cdb_txrx_pwdata_out[11]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[10]] -to [get_ports cdb_txrx_pwdata_out[10]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[10]] -to [get_ports cdb_txrx_pwdata_out[10]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[9]] -to [get_ports cdb_txrx_pwdata_out[9]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[9]] -to [get_ports cdb_txrx_pwdata_out[9]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[8]] -to [get_ports cdb_txrx_pwdata_out[8]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[8]] -to [get_ports cdb_txrx_pwdata_out[8]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[7]] -to [get_ports cdb_txrx_pwdata_out[7]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[7]] -to [get_ports cdb_txrx_pwdata_out[7]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[6]] -to [get_ports cdb_txrx_pwdata_out[6]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[6]] -to [get_ports cdb_txrx_pwdata_out[6]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[5]] -to [get_ports cdb_txrx_pwdata_out[5]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[5]] -to [get_ports cdb_txrx_pwdata_out[5]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[4]] -to [get_ports cdb_txrx_pwdata_out[4]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[4]] -to [get_ports cdb_txrx_pwdata_out[4]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[3]] -to [get_ports cdb_txrx_pwdata_out[3]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[3]] -to [get_ports cdb_txrx_pwdata_out[3]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[2]] -to [get_ports cdb_txrx_pwdata_out[2]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[2]] -to [get_ports cdb_txrx_pwdata_out[2]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[1]] -to [get_ports cdb_txrx_pwdata_out[1]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[1]] -to [get_ports cdb_txrx_pwdata_out[1]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[0]] -to [get_ports cdb_txrx_pwdata_out[0]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[0]] -to [get_ports cdb_txrx_pwdata_out[0]]

# the number below is 1.0+0.2 (input_delay+max_delay) = 1.2
# the number below is 1.0+0.180 (input_delay+min_delay) = 1.18

set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[15]] -to [get_ports cdb_txrx_prdata_out[15]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[15]] -to [get_ports cdb_txrx_prdata_out[15]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[14]] -to [get_ports cdb_txrx_prdata_out[14]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[14]] -to [get_ports cdb_txrx_prdata_out[14]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[13]] -to [get_ports cdb_txrx_prdata_out[13]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[13]] -to [get_ports cdb_txrx_prdata_out[13]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[12]] -to [get_ports cdb_txrx_prdata_out[12]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[12]] -to [get_ports cdb_txrx_prdata_out[12]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[11]] -to [get_ports cdb_txrx_prdata_out[11]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[11]] -to [get_ports cdb_txrx_prdata_out[11]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[10]] -to [get_ports cdb_txrx_prdata_out[10]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[10]] -to [get_ports cdb_txrx_prdata_out[10]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[9]] -to [get_ports cdb_txrx_prdata_out[9]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[9]] -to [get_ports cdb_txrx_prdata_out[9]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[8]] -to [get_ports cdb_txrx_prdata_out[8]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[8]] -to [get_ports cdb_txrx_prdata_out[8]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[7]] -to [get_ports cdb_txrx_prdata_out[7]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[7]] -to [get_ports cdb_txrx_prdata_out[7]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[6]] -to [get_ports cdb_txrx_prdata_out[6]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[6]] -to [get_ports cdb_txrx_prdata_out[6]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[5]] -to [get_ports cdb_txrx_prdata_out[5]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[5]] -to [get_ports cdb_txrx_prdata_out[5]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[4]] -to [get_ports cdb_txrx_prdata_out[4]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[4]] -to [get_ports cdb_txrx_prdata_out[4]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[3]] -to [get_ports cdb_txrx_prdata_out[3]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[3]] -to [get_ports cdb_txrx_prdata_out[3]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[2]] -to [get_ports cdb_txrx_prdata_out[2]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[2]] -to [get_ports cdb_txrx_prdata_out[2]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[1]] -to [get_ports cdb_txrx_prdata_out[1]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[1]] -to [get_ports cdb_txrx_prdata_out[1]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[0]] -to [get_ports cdb_txrx_prdata_out[0]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[0]] -to [get_ports cdb_txrx_prdata_out[0]]
set_max_delay 1.200 -from [get_ports cdb_tx_pready_in] -to [get_ports cdb_tx_pready_out] 
set_min_delay 1.180 -from [get_ports cdb_tx_pready_in] -to [get_ports cdb_tx_pready_out]  
set_max_delay 1.200 -from [get_ports cdb_rx_pready_in] -to [get_ports cdb_rx_pready_out] 
set_min_delay 1.180 -from [get_ports cdb_rx_pready_in] -to [get_ports cdb_rx_pready_out]  

#
#NOTE:check if you need to add the clock_source insertion delay.
#
set_output_delay 0.500 -max -clock {CDBCLK_SCAP_IN} [get_ports cdb_txrx_prdata_out[*]]
set_output_delay 0.450 -min -clock {CDBCLK_SCAP_IN} [get_ports cdb_txrx_prdata_out[*]]
set_output_delay 0.500 -clock {CDBCLK_SCAP_IN} [get_ports cdb_tx_pready_out]
set_output_delay 0.500 -clock {CDBCLK_SCAP_IN} [get_ports cdb_rx_pready_out]

# Following are pass through versions of the cmn_clocks.
set_max_delay 0.200 -from [get_ports {cmn_ref_clk_gated_in}] -to [get_ports {cmn_ref_clk_gated_out}]
#NOTE: 09/28/2012:for the ff corner hold check changing the min delay from 180ps top 40ps.
set_min_delay 0.040 -from [get_ports {cmn_ref_clk_gated_in}] -to [get_ports {cmn_ref_clk_gated_out}]


## Note for cdb_clk we have a clock latency associated with it, hence adding latency to the
## max_delay.
## new_max_delay = max_delay + clock_latency = 0.200 + 1.85 = 2.05
## 09/28/2012: new_max_delay = max_delay + clock_latency = 0.200 + 0.45 = 0.65
set_max_delay 0.650 -from [get_ports {cmn_cdb_pclk_in}] -to [get_ports {cmn_cdb_pclk_out}]
#NOTE: 09/28/2012:for the ff corner hold check changing the min delay from 180ps top 40ps.
set_min_delay 0.040 -from [get_ports {cmn_cdb_pclk_in}] -to [get_ports {cmn_cdb_pclk_out}]

#
# TX signals
#
#TXCLK_GEN1
#set_input_delay 2.0 -max -add -clock [get_clocks  {TXTDCLK_SCAP}] [get_ports {tx_elec_idle}]
set_input_delay 2.4 -max -add -clock [get_clocks  {TXTDCLK_SCAP}] [get_ports {tx_elec_idle}]

#based on constraint review, jun27,2013
set_input_delay 2.1 -max -add -clock [get_clocks TXTDCLK_SCAP] [get_ports {tx_td[*]}]


##
## To check the turn-around time for the txda_ser_data, based of rise edge of txda_ser_clk.
## Following timing is based of data from Mark Hale. Jul30 2012.
## Max_delay for ss corner = 1.94ns, for ff corner = 1.984ns, and tt corner = 1.96ns.
## + uncertainty -75ps
##set_max_delay 1.94 -from [get_clocks {TXCLK_GEN3}] -to [get_pins {u_xcvr_ana/txda_ser_data[*]}]
## NOte do not need this as we have setup and hold requirement numbers in the lib.
##set_max_delay 1.86 -from [get_clocks {TXCLK_GEN3}] -to [get_pins {u_xcvr_ana/txda_ser_data[*]}]


#
# RX signals
#

set_output_delay 2.0 -max -add -clock [get_clocks {SERCLK_SCAP}] [get_ports {rx_rd[*]}]



# Receiver equalization evaluation direction change.

set_output_delay 2.0 -max -add -clock [get_clocks {SERCLK_SCAP}] [get_ports {rx_bist_status}]

set_output_delay 2.0 -max -add -clock [get_clocks {SERCLK_SCAP}] [get_ports {rx_bist_err_toggle}]

set_output_delay 2.0 -max -add -clock [get_clocks {SERCLK_SCAP}] [get_ports {rx_bist_sync}]

#rx_sampler_latch_cal_diag[*]
set_output_delay 2.0 -max -add -clock [get_clocks {SERCLK_SCAP}] [get_ports {rx_sampler_latch_cal_diag[*]}]
set_output_delay 2.0 -max -add -clock [get_clocks {CDBCLK_SCAP_IN}] [get_ports {rx_sampler_latch_cal_diag[*]}]

#
## ATPG Scan
#
set_input_delay 0.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_scanin[*]}]
set_input_delay 0.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_scanmode}]
set_input_delay 0.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_scanen}]
set_input_delay 0.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_scanen_cg}]

set_output_delay 0.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_scanout[*]}]

#
# Boundary Scan 
#
set_input_delay 0.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_bscan_mode_c}]
set_input_delay 0.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_bscan_acpulse}]
set_input_delay 0.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_bscan_ac}]

set_input_delay 0.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_bscan_mode_en}]
set_input_delay 0.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_bscan_ac}]
#set_input_delay 0.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_bscan_pc}]

set_input_delay  2.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_bscan_tdi}]
set_output_delay 2.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_bscan_tdo}]

set_input_delay  2.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_bscan_tdi}]
set_output_delay 2.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_bscan_tdo}]


set_input_delay 1.00 -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_scanin[*]}]
set_max_delay 1.20 -to [get_ports {xcvr_scanout[*]}]


###############################################################################
# Transitions and Transition Limits
###############################################################################
if {$timeMode == "ideal" } {
    set_max_transition 0.150 [current_design]
    set_max_transition 0.150 [all_inputs]
    set_max_transition 0.150 [all_outputs]
} else {
    set_max_transition $max_trans [current_design]
    set_max_transition $max_trans [all_inputs]
    set_max_transition $max_trans [all_outputs]
}

set_clock_transition $max_clk_trans [all_clocks]



###############################################################################
# Input Driving Cells
###############################################################################
#set_driving_cell -lib_cell $DRIVING_CELL -pin $DRIVING_PIN $digital_input_port_collection

###############################################################################
# Output Port Loading
###############################################################################
set_load 0.050 $digital_output_port_collection


###############################################################################
# Don't Use/Touch
###############################################################################
# Power & Ground Connections
set_dont_touch [get_nets $power_ground_port_list]
# Cmn_ana connections that must remain pure from/to their respective pma_cmn I/O ports.
set_dont_touch [get_nets $analog_port_list]


###############################################################################
# Exceptions.
###############################################################################


set_false_path -from [get_clocks {IO_ASYNC}]
set_false_path -to   [get_clocks {IO_ASYNC}]

#synthesis
if { $load_syn_sdc && !$load_post_map_syn_sdc } {

#P&R
} else {

   # Set false paths to analog scanin pins and from analog scanout pins.
   set_false_path -to      [get_pins { u_xcvr_ana/*scanin }]
   set_false_path -to      [get_pins { u_xcvr_ana/*scanin[*] }]
   set_false_path -through [get_pins { u_xcvr_ana/*scanout }]
   set_false_path -through [get_pins { u_xcvr_ana/*scanout[*] }]

   # False path all paths to SI pins.
   set si_pin_collection [ get_pins -of [ all_registers ] -filter { @name == SI } ]
   set_false_path  -from [all_clocks]  -to $si_pin_collection

}

###############################################################################
# Ideal Networks
###############################################################################


if { $load_syn_sdc && !$load_post_map_syn_sdc } {

} else {
   # NOTE : doing following to fix recovery violations in the prects db where we see large
   # fanout on the reset nets, which results in big delays on muxes and reset pins.
   if {$timeMode == "ideal"} {
        set_ideal_network [get_ports cmn_cdb_preset_n_in]
        set_ideal_network [get_ports cmn_reset_n_in]
	}

}

###############################################################################
# Clock Latency REsePropagation
###############################################################################
if { !$load_syn_sdc && $timeMode == "prop" } {
    reset_clock_tree_latency [all_clocks]
    set_propagated_clock     [all_clocks]
}



