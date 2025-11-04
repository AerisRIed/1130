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
# Filename  : xcvr.scan_shift.tcl
# Version   : $Revision2638 $
# Date/Time : $Date2013-02-19 13:53:13 -0500 (Tue, 19 Feb 2013) $
#
# Author    : Shweta Lolage
# Edited by : Chirayu Hardikar
# Abstract  : Functional & ATPG timing constraints for pma_xcvr_lane.
#
###############################################################################
# Change Log
# $Log$
#
###############################################################################
if { [info exists load_syn_sdc] && $load_syn_sdc} {
    source $DUT_PATH/design/constraints/PMA/xcvr_txrxm.preamble.sdc
} else {
    source [file dirname [info script]]/xcvr_txrxm.preamble.sdc
}

current_design  xcvr_txrxm

#############################################################################
# set_case_analysis
#############################################################################
set_case_analysis 1 [get_ports {xcvr_scanmode xcvr_scanen xcvr_scanen_cg}]


#############################################################################
# Clock Definitions
#############################################################################

#################################################################
# Reference Clocks
#################################################################
create_clock \
    -name           SCAN_REFCLK_SHIFT_IN \
    -period         $SHIFTCLK_PERIOD \
    -waveform       $SHIFTCLK_WAVEFORM \
    -add \
    [get_ports cmn_scanclk_ref_clk_in]

create_clock \
   -name      REFCLK_SHIFT_GATED_IN \
   -period    $SHIFTCLK_PERIOD \
   -waveform  $SHIFTCLK_WAVEFORM \
   [get_ports cmn_ref_clk_gated_in]

#################################################################
# PSM Clock
#################################################################
create_clock \
    -name           PSMCLK_SHIFT \
    -period         $SHIFTCLK_PERIOD \
    -waveform       $SHIFTCLK_WAVEFORM \
    -add \
    [get_ports xcvr_psm_clk]


#################################################################
# CDB Clocks
#################################################################
create_clock \
    -name           CDBCLK_SHIFT_IN \
    -period         $SHIFTCLK_PERIOD \
    -waveform       $SHIFTCLK_WAVEFORM \
    -add \
    [get_ports cmn_cdb_pclk_in]

#create_clock \
#    -name           CDBCLK_CDB_ISL_SHIFT_IN \
#    -period         $SHIFTCLK_PERIOD \
#    -waveform       $SHIFTCLK_WAVEFORM \
#    -add \
#    [get_ports cmn_cdb_pclk_cdb_isl_gated_in]


#################################################################
# PLL*CLK Domain
#################################################################
create_clock \
    -name           PLL0CLK0_FULLRT_SHIFT \
    -period         $SHIFTCLK_PERIOD \
    -waveform       $SHIFTCLK_WAVEFORM \
    -add \
    [get_ports cmn_pll0_clk_0_scanned_in]

create_clock \
    -name           PLL0CLK1_FULLRT_SHIFT \
    -period         $SHIFTCLK_PERIOD \
    -waveform       $SHIFTCLK_WAVEFORM \
    -add \
    [get_ports cmn_pll0_clk_1_scanned_in]

create_clock \
    -name           PLL1CLK0_FULLRT_SHIFT \
    -period         $SHIFTCLK_PERIOD \
    -waveform       $SHIFTCLK_WAVEFORM \
    -add \
    [get_ports cmn_pll1_clk_0_scanned_in]

create_clock \
    -name           PLL1CLK1_FULLRT_SHIFT \
    -period         $SHIFTCLK_PERIOD \
    -waveform       $SHIFTCLK_WAVEFORM \
    -add \
    [get_ports cmn_pll1_clk_1_scanned_in]

#################################################################
# SDCLK Domain
#################################################################
create_clock \
    -name           SDCLK_SHIFT \
    -period         $SHIFTCLK_PERIOD \
    -waveform       $SHIFTCLK_WAVEFORM \
    -add \
    [get_ports xcvr_scanclk_pll_clk]

#################################################################
# SERCLK Domain
#################################################################
create_clock \
    -name           SERCLK_SHIFT \
    -period         $SHIFTCLK_PERIOD \
    -waveform       $SHIFTCLK_WAVEFORM \
    -add \
    [get_ports xcvr_scanclk_ser_clk]


#################################################################
# TXCLK Domain
#################################################################
create_clock \
    -name           TXTDCLK_SHIFT \
    -period         $SHIFTCLK_PERIOD \
    -waveform       $SHIFTCLK_WAVEFORM \
    -add \
    [get_ports tx_td_clk]


#################################################################
# Misc Clocks
#################################################################
# Assign a clock to the boundary scan clock inputs even though the logic
# is not scanned.
create_clock \
    -name           BSCAN_CLK \
    -period         $BSCAN_PERIOD \
    -waveform       $BSCAN_WAVEFORM \
    [get_ports      {
                    tx_bscan_clockdr \
                    tx_bscan_updatedr \
                    rx_bscan_clockdr \
                    rx_bscan_pc \
                    } \
    ]

# Asynchronous clock phases. This phase is excluded from all other clocks.
create_clock \
    -name           IO_ASYNC \
    -period         $ASYNC_PERIOD \
    -waveform       $ASYNC_WAVEFORM


#############################################################################
# Clock latency for clocks from common.
# -early | -late
# Specifies clock arrival time with respect to the early or the late time of the clock signal.
# In setup analysis, launch path is the late path and capture path is the early path.
# In hold analysis, launch path is the early path and the capture path is the late path.
# If neither parameter is specified, the default is both early and late.
#############################################################################
set_clock_latency 0.45 -source -max [get_ports cmn_cdb_pclk_in]          -clock [get_clocks CDBCLK_SHIFT_IN]
set_clock_latency 0.40 -source -min [get_ports cmn_cdb_pclk_in]          -clock [get_clocks CDBCLK_SHIFT_IN]
#set_clock_latency 0.45 -source -max [get_ports cmn_cdb_pclk_cdb_isl_gated_out] -clock [get_clocks CDBCLK_CDB_ISL_SHIFT_IN]
#set_clock_latency 0.40 -source -min [get_ports cmn_cdb_pclk_cdb_isl_gated_out] -clock [get_clocks CDBCLK_CDB_ISL_SHIFT_IN]


#############################################################################
# Clock Uncertainties
#############################################################################
set default_margin 5.000


#############################################################################
# Default uncertainties. Default setup is high in order to catch
# unaccounted for clock relationships.
#############################################################################
set_clock_uncertainty  $default_margin -setup -from [all_clocks] -to [all_clocks]
set_clock_uncertainty  $hold_margin    -hold  -from [all_clocks] -to [all_clocks]


#############################################################################
# SCAN Clocks
#############################################################################
set_clock_uncertainty   $setup_margin \
                        -setup \
                        -from   [get_clocks { \
                                            SCAN_REFCLK_SHIFT_IN \
                                            REFCLK_SHIFT_GATED_IN \
                                            PSMCLK_SHIFT \
                                            CDBCLK_SHIFT_IN \
                                            PLL0CLK0_FULLRT_SHIFT \
                                            PLL0CLK1_FULLRT_SHIFT \
                                            PLL1CLK0_FULLRT_SHIFT \
                                            PLL1CLK1_FULLRT_SHIFT \
                                            SERCLK_SHIFT \
                                            SDCLK_SHIFT \
                                            TXTDCLK_SHIFT \
                                            } \
                                ] \
                        -to     [get_clocks { \
                                            SCAN_REFCLK_SHIFT_IN \
                                            REFCLK_SHIFT_GATED_IN \
                                            PSMCLK_SHIFT \
                                            CDBCLK_SHIFT_IN \
                                            PLL0CLK0_FULLRT_SHIFT \
                                            PLL0CLK1_FULLRT_SHIFT \
                                            PLL1CLK0_FULLRT_SHIFT \
                                            PLL1CLK1_FULLRT_SHIFT \
                                            SERCLK_SHIFT \
                                            SDCLK_SHIFT \
                                            TXTDCLK_SHIFT \
                                            } \
                                ]

set_clock_uncertainty   $setup_margin \
                        -setup \
                        -from       [get_clocks IO_ASYNC] \
                        -to         [get_clocks IO_ASYNC]


#############################################################################
# Transitions
#############################################################################

set_max_transition $max_trans [current_design]
set_max_transition $max_clk_trans -clock_path [all_clocks]
#set_max_transition $max_trans [all_inputs]
#set_max_transition $max_trans [all_outputs]
#set_max_transition $max_clk_trans $clk_inputs

set_clock_transition $max_clk_trans [all_clocks]


#############################################################################
# MTBF flops
#############################################################################
# Reduce uncertainty for MTBF flops
set_false_path -hold -to [get_pins -hier *genblk1_genblk1_u_data_sync_synth_*_2/D]
set_false_path -hold -to [get_pins -hier *genblk1_genblk1_u_data_sync_synth_*_3/D]
set_false_path -hold -to [get_pins -hier *genblk1_genblk1_u_data_sync_synth_*_4/D]
set_false_path -hold -to [get_pins -hier *genblk1_u_reset_sync_synth_*_2/D]
set_false_path -hold -to [get_pins -hier *genblk1_u_reset_sync_synth_*_3/D]
set_false_path -hold -to [get_pins -hier *genblk1_u_reset_sync_synth_*_4/D]
#set_false_path -hold -to [get_pins -hier { *genblk1_u_lfps_sync_synth_*_2/D }]
#set_false_path -hold -to [get_pins -hier { *genblk1_u_lfps_sync_synth_*_3/D }]
#set_false_path -hold -to [get_pins -hier { *genblk1_u_lfps_sync_synth_*_4/D }]


#############################################################################
# Clock groups
#############################################################################
set_clock_groups -async -name grp_shift_async   -group [get_clocks IO_ASYNC]
set_clock_groups -async -name grp_shift_bscan   -group [get_clocks BSCAN_CLK]
set_clock_groups -async -name grp_shift_pclk    -group [get_clocks CDBCLK*SHIFT*]
set_clock_groups -async -name grp_shift_refclk  -group [get_clocks {SCAN_REFCLK* REFCLK*}]
set_clock_groups -async -name grp_shift_psmclk  -group [get_clocks PSMCLK*]
set_clock_groups -async -name grp_shift_serclk  -group [get_clocks {SERCLK* PLL*CLK*_FULLRT*}]
set_clock_groups -async -name grp_shift_sdclk  -group [get_clocks SDCLK*]
set_clock_groups -async -name grp_shift_txtdclk -group [get_clocks TXTDCLK*]
set_clock_groups -async -name grp_shift_pll01   -group [get_clocks PLL0CLK*] \
                                                -group [get_clocks PLL1CLK*]


#############################################################################
# I/O Timing
#############################################################################

#################################################################
# Relative to IO_ASYNC
#################################################################
set_input_delay 0.000 -max -add -clock [get_clocks IO_ASYNC] $data_input_port_collection

set_input_delay 3.330 -max -add -clock [get_clocks SCAN_REFCLK_SHIFT_IN]            [get_ports  { \
                                                                                                xcvr_scanin[*] \
                                                                                                } \
                                                                                    ]
set_input_delay 3.330 -max -add -clock [get_clocks PSMCLK_SHIFT]                    [get_ports  { \
                                                                                                xcvr_scanin[*] \
                                                                                                } \
                                                                                    ]
set_input_delay 3.330 -max -add -clock [get_clocks CDBCLK_SHIFT_IN]                 [get_ports  { \
                                                                                                xcvr_scanin[*] \
                                                                                                } \
                                                                                    ]
set_input_delay 3.330 -max -add -clock [get_clocks SERCLK_SHIFT]                    [get_ports  { \
                                                                                                xcvr_scanin[*] \
                                                                                                } \
                                                                                    ]
set_input_delay 3.330 -max -add -clock [get_clocks SDCLK_SHIFT]                     [get_ports  { \
                                                                                                xcvr_scanin[*] \
                                                                                                } \
                                                                                    ]
#set_output_delay 1.660 -max -add -clock_fall -clock [get_clocks TXTDCLK_SHIFT]      [get_ports  { \
#                                                                                                xcvr_scanout[*] \
#                                                                                                } \
#                                                                                    ]
set_output_delay 1.660 -max -add -clock [get_clocks TXTDCLK_SHIFT]                   [get_ports  { \
                                                                                                xcvr_scanout[*] \
                                                                                                } \
                                                                                    ]


#outputs pass thru signals have their set_output_delay commented out since we
#don't want the timing engine to time these wrt IO_ASYNC clocks and give out
#false big violations due to this clock's high uncertainty
## adding the input delay to the max delay to fix issue in STA.
set_max_delay 1.5 -from [get_ports cmn_reset_n_in] -to [get_ports cmn_reset_n_out]
set_min_delay 0.7 -from [get_ports cmn_reset_n_in] -to [get_ports cmn_reset_n_out]
set_max_delay 1.5 -from [get_ports cmn_reset_sync_n_in] -to [get_ports cmn_reset_sync_n_out]
set_min_delay 0.7 -from [get_ports cmn_reset_sync_n_in] -to [get_ports cmn_reset_sync_n_out]
set_max_delay 1.5 -from [get_ports cmn_atb_en_in] -to [get_ports cmn_atb_en_out]
set_min_delay 0.7 -from [get_ports cmn_atb_en_in] -to [get_ports cmn_atb_en_out]
set_max_delay 1.5 -from [get_ports cmn_atb_sel_in[*]] -to [get_ports cmn_atb_sel_out[*]]
set_min_delay 0.7 -from [get_ports cmn_atb_sel_in[*]] -to [get_ports cmn_atb_sel_out[*]]
set_max_delay 1.5 -from [get_ports cmn_cdb_preset_n_in] -to [get_ports cmn_cdb_preset_n_out]
set_min_delay 0.7 -from [get_ports cmn_cdb_preset_n_in] -to [get_ports cmn_cdb_preset_n_out]

set_input_delay 2.4 -max -clock [get_clocks IO_ASYNC] [get_ports cdb_tx_psel_in] -add_delay
set_input_delay 2.4 -max -clock [get_clocks IO_ASYNC] [get_ports cdb_rx_psel_in] -add_delay
set_input_delay 2.4 -max -clock [get_clocks IO_ASYNC] [get_ports cdb_txrx_paddr_in[*]] -add_delay
set_input_delay 2.4 -max -clock [get_clocks IO_ASYNC] [get_ports cdb_txrx_pwdata_in[*]] -add_delay
set_input_delay 2.4 -max -clock [get_clocks IO_ASYNC] [get_ports cdb_txrx_pwrite_in] -add_delay
set_input_delay 2.4 -max -clock [get_clocks IO_ASYNC] [get_ports cdb_txrx_plinkmultiwrite_in] -add_delay
set_input_delay 2.4 -max -clock [get_clocks IO_ASYNC] [get_ports cdb_tx_penable_in] -add_delay
set_input_delay 2.4 -max -clock [get_clocks IO_ASYNC] [get_ports cdb_rx_penable_in] -add_delay

set_input_delay 0.75 -min -clock [get_clocks IO_ASYNC] [get_ports cdb_tx_psel_in] -add_delay
set_input_delay 0.75 -min -clock [get_clocks IO_ASYNC] [get_ports cdb_rx_psel_in] -add_delay
set_input_delay 0.75 -min -clock [get_clocks IO_ASYNC] [get_ports cdb_txrx_paddr_in[*]] -add_delay
set_input_delay 0.75 -min -clock [get_clocks IO_ASYNC] [get_ports cdb_txrx_pwdata_in[*]] -add_delay
set_input_delay 0.75 -min -clock [get_clocks IO_ASYNC] [get_ports cdb_txrx_pwrite_in] -add_delay
set_input_delay 0.75 -min -clock [get_clocks IO_ASYNC] [get_ports cdb_txrx_plinkmultiwrite_in] -add_delay
set_input_delay 0.75 -min -clock [get_clocks IO_ASYNC] [get_ports cdb_tx_penable_in] -add_delay
set_input_delay 0.75 -min -clock [get_clocks IO_ASYNC] [get_ports cdb_rx_penable_in] -add_delay


set_input_delay 1.0 -clock [get_clocks IO_ASYNC] [get_ports cdb_txrx_prdata_in[*]] -add_delay
set_input_delay 1.0 -clock [get_clocks IO_ASYNC] [get_ports cdb_tx_pready_in] -add_delay
set_input_delay 1.0 -clock [get_clocks IO_ASYNC] [get_ports cdb_rx_pready_in] -add_delay

set_max_delay 2.600 -from [get_ports cdb_tx_psel_in] -to [get_ports cdb_tx_psel_out]
set_min_delay 0.790 -from [get_ports cdb_tx_psel_in] -to [get_ports cdb_tx_psel_out]
set_max_delay 2.600 -from [get_ports cdb_rx_psel_in] -to [get_ports cdb_rx_psel_out]
set_min_delay 0.790 -from [get_ports cdb_rx_psel_in] -to [get_ports cdb_rx_psel_out]

set_max_delay 2.600 -from [get_ports cdb_tx_penable_in] -to [get_ports cdb_tx_penable_out]
set_min_delay 0.790 -from [get_ports cdb_tx_penable_in] -to [get_ports cdb_tx_penable_out]
set_max_delay 2.600 -from [get_ports cdb_rx_penable_in] -to [get_ports cdb_rx_penable_out]
set_min_delay 0.790 -from [get_ports cdb_rx_penable_in] -to [get_ports cdb_rx_penable_out]

set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[13]] -to [get_ports cdb_txrx_paddr_out[13]]
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[13]] -to [get_ports cdb_txrx_paddr_out[13]]
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[12]] -to [get_ports cdb_txrx_paddr_out[12]]
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[12]] -to [get_ports cdb_txrx_paddr_out[12]]
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[11]] -to [get_ports cdb_txrx_paddr_out[11]]
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[11]] -to [get_ports cdb_txrx_paddr_out[11]]
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[10]] -to [get_ports cdb_txrx_paddr_out[10]]
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[10]] -to [get_ports cdb_txrx_paddr_out[10]]
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[9]] -to [get_ports cdb_txrx_paddr_out[9]]
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[9]] -to [get_ports cdb_txrx_paddr_out[9]]
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[8]] -to [get_ports cdb_txrx_paddr_out[8]]
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[8]] -to [get_ports cdb_txrx_paddr_out[8]]
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[7]] -to [get_ports cdb_txrx_paddr_out[7]]
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[7]] -to [get_ports cdb_txrx_paddr_out[7]]
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[6]] -to [get_ports cdb_txrx_paddr_out[6]]
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[6]] -to [get_ports cdb_txrx_paddr_out[6]]
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[5]] -to [get_ports cdb_txrx_paddr_out[5]]
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[5]] -to [get_ports cdb_txrx_paddr_out[5]]
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[4]] -to [get_ports cdb_txrx_paddr_out[4]]
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[4]] -to [get_ports cdb_txrx_paddr_out[4]]
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[3]] -to [get_ports cdb_txrx_paddr_out[3]]
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[3]] -to [get_ports cdb_txrx_paddr_out[3]]
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[2]] -to [get_ports cdb_txrx_paddr_out[2]]
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[2]] -to [get_ports cdb_txrx_paddr_out[2]]
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[1]] -to [get_ports cdb_txrx_paddr_out[1]]
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[1]] -to [get_ports cdb_txrx_paddr_out[1]]
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[0]] -to [get_ports cdb_txrx_paddr_out[0]]
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[0]] -to [get_ports cdb_txrx_paddr_out[0]]

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
set_output_delay 0.500 -max -clock {IO_ASYNC} [get_ports cdb_txrx_prdata_out[*]]
set_output_delay 0.450 -min -clock {IO_ASYNC} [get_ports cdb_txrx_prdata_out[*]]
set_output_delay 0.500 -clock {IO_ASYNC} [get_ports cdb_tx_pready_out]
set_output_delay 0.500 -clock {IO_ASYNC} [get_ports cdb_rx_pready_out]

#Cannot have set_input delay on clock. should I be adding source insertion delay??
#set_input_delay 2.391 -clock {IO_ASYNC} -max -rise [get_ports {cmn_refclk_gated_in}] -add_delay

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
#set_input_delay 2.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_elec_idle}]
set_input_delay 2.4 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_elec_idle}]

#based on constraint review, jun27,2013
set_input_delay 2.1 -max -add -clock [get_clocks IO_ASYNC] [get_ports {tx_td[*]}]


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
#set_input_delay 2.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_eq_eval}]

set_output_delay 2.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_rd[*]}]

#set_output_delay 2.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_eq_eval_complete}]

#set_output_delay 2.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_eq_eval_status}]

# Receiver equalization evaluation direction change.
#set_output_delay 2.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_link_eval_fb_dir_change[*]}]

set_output_delay 2.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_bist_status}]

set_output_delay 2.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_bist_err_toggle}]

set_output_delay 2.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_bist_sync}]

#rx_sampler_latch_cal_diag[*]
set_output_delay 0.50 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_sampler_latch_cal_diag[*]}]

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
set_driving_cell -lib_cell $DRIVING_CELL -pin $DRIVING_PIN $digital_input_port_collection


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

# Don't check boundary scan timing in this mode.
set_false_path -from [get_clocks { BSCAN_CLK }] -to [get_clocks { BSCAN_CLK }]


###############################################################################
# Clock Latency REsePropagation
###############################################################################
set_false_path -from [get_clocks {IO_ASYNC}]
set_false_path -to   [get_clocks {IO_ASYNC}]

if { !$load_syn_sdc && $timeMode == "prop" } {
    reset_clock_tree_latency [all_clocks]
    set_propagated_clock     [all_clocks]
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
#set propagated clock for p&r
###############################################################################
if {$load_syn_sdc} {
} else {
 if {$timeMode == "prop"} {
    reset_clock_tree_latency [all_clocks]
    set_propagated_clock     [all_clocks]
 }
}


