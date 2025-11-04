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
# Filename  : sd1601_pma.preamble.sdc
#
# Author    : Jack Yarolin
# Abstract  : This file contains flag and physical lane map settings, port 
#             collections. It also extracts the configuration from the design 
#             name. This file is sourced by the constraint file for each
#             timing mode.
#
###############################################################################
# IMPORTANT:
#
#   There are several variables that can be optionally set:
#      ::timeMode      - Clocking mode. Valid values are "prop" and "ideal".
#                     Normally set by CFI.
#      do_libgen     - Set to 1 to adjust constraints for Liberty model
#                     generation.
###############################################################################

###############################################################################
# Flags
###############################################################################

# Specifies whether clocking is in ideal or propagated mode. Valid values
# are "ideal" and "prop".
if { ![info exists ::timeMode] } {
   Puts "INFO: setting ::timeMode to prop"
   set ::timeMode prop
}
Puts "INFO: ::timeMode = $::timeMode"

# Specifies if constraints are being used for Liberty model generation.
if { ![info exists do_libgen] } {
   Puts "INFO: setting do_libgen to 0"
   set do_libgen 0
}
Puts "INFO: do_libgen = $do_libgen"

if { ![info exists load_post_map_syn_sdc] } {
    puts "INFO: setting load_post_map_syn_sdc = 0"
    set load_post_map_syn_sdc 0
}


# Synthesis (pre-mapped)
if { $load_syn_sdc && !$load_post_map_syn_sdc } {
    set clk_mux_pin_0   "clk_in[0]"
    set clk_mux_pin_1   "clk_in[1]"
    set clk_mux_out_pin "clk_out"
    set scan_mux_pin    "fcn_signal_in"
# Synthesis (post-mapped) or P&R
} else {
set clk_mux_pin_0   "RC_i_1/I0"
set clk_mux_pin_1   "RC_i_1/I1"
set clk_mux_out_pin "RC_i_1/Z"
set scan_mux_pin    "u_scan_mux_synth/u_mux/I0"
}

if { ![info exists ::DRIVING_CELL] } {
   set ::DRIVING_CELL [get_lib_cells BUFFMZD4BWP210H6P51CNODSVT]
   set ::DRIVING_PIN Z
   puts "INFO: setting DRIVING_CELL = [get_property $::DRIVING_CELL name]"
}

###############################################################################
# Create physical lane map
###############################################################################

#if { ![info exists config] } {
#   puts "ERROR: no configuration specifed"
#   exit
#}
set config [regsub {(.*)_([0-8][0-8])_(.*)} [get_object [current_design]] {\2}]
Puts "INFO: Configuration = $config"

# This physical map computation assumes there can be up to 8 lanes on either
# size of the Common.
array set phys_lanes { 0 "rh" 1 "rg"  2 "rf"  3 "re"  4 "rd"  5 "rc"  6 "rb"  7 "ra" \
                           8 "la" 9 "lb" 10 "lc" 11 "ld" 12 "le" 13 "lf" 14 "lg" 15 "lh" }
set num_west_lanes  [string index $config 0]
set num_east_lanes  [string index $config 1]
set num_lanes       [expr $num_west_lanes + $num_east_lanes]
set idx [expr 8 - $num_east_lanes]
for { set i 0 } { $i < $num_lanes } { incr i 1 } {
   set lane_map($i) $phys_lanes($idx)
   incr idx 1
}

Puts "INFO: No. lanes = $num_lanes"
for { set i 0 } { $i < $num_lanes } { incr i 1 } { puts "INFO: LN_${i} = $lane_map($i)" }

###############################################################################
# Port collections
###############################################################################

# General port collections
set supply_ports    [get_ports { \
                                 agnd       \
                                 avdd_clk   \
                                 avdd_h     \
                                 avdd       \
                                 avdd_tx0   \
                                 avdd_tx1   \
                                 avdd_tx2   \
                                 avdd_tx3   \
                                 avdd_rx    \
                                 cmn_aonvdd \
                                  }]

set bump_ports      [get_ports { \
                                     cmn_rext     \
                                     xcvr_p_ln_0  \
                                     xcvr_m_ln_0  \
                                     xcvr_p_ln_1  \
                                     xcvr_m_ln_1  \
                                     xcvr_p_ln_2  \
                                     xcvr_m_ln_2  \
                                     xcvr_p_ln_3  \
                                     xcvr_m_ln_3  \
                                  }]

set analog_ports    [get_ports { \
                                     cmn_atb_core_0 \
                                     cmn_atb_core_1 \
                                     cmn_ref_clk0_int \
                                     cmn_ref_clk1_int \
                                     cmn_avdd_pwrgood \
                                  }]

set top_edge_ports  [add_to_collection [all_inputs] [all_outputs]]
set top_edge_ports  [remove_from_collection $top_edge_ports $supply_ports]
set top_edge_ports  [remove_from_collection $top_edge_ports $bump_ports]
Puts "No. supply ports   = [sizeof_collection $supply_ports]"
Puts "No. bump ports     = [sizeof_collection $bump_ports]"
Puts "No. top edge ports = [sizeof_collection $top_edge_ports]"

# Reset ports
set reset_inputs [get_ports { \
                                  cmn_reset_n \
                                  cmn_pll0_reset_n \
                                  cmn_pll1_reset_n \
                                  cmn_cdb_preset_n \
                                  xcvr_cdb_preset_n_ln_0 \
                                  xcvr_cdb_preset_n_ln_1 \
                                  xcvr_cdb_preset_n_ln_2 \
                                  xcvr_cdb_preset_n_ln_3 \
                                  rx_reset_n_ln_0 \
                                  rx_reset_n_ln_1 \
                                  rx_reset_n_ln_2 \
                                  rx_reset_n_ln_3 \
                                  tx_reset_n_ln_0 \
                                  tx_reset_n_ln_1 \
                                  tx_reset_n_ln_2 \
                                  tx_reset_n_ln_3 \
                                  xcvr_link_reset_n_ln_0 \
                                  xcvr_link_reset_n_ln_1 \
                                  xcvr_link_reset_n_ln_2 \
                                  xcvr_link_reset_n_ln_3 }]
# tx_sfifo_enq_reset_n_in_ln_* is synchronous to tx_td_clk
Puts "No. reset ports    = [sizeof_collection $reset_inputs]"

# Clock port collections (includes bumps)
set func_clk_inputs [get_ports { \
                                     cmn_ref_clk0_int \
                                     cmn_ref_clk1_int \
                                     cmn_psm_clk_in \
                                     cmn_cdb_pclk \
                                     xcvr_psm_clk_ln_0 \
                                     xcvr_psm_clk_ln_1 \
                                     xcvr_psm_clk_ln_2 \
                                     xcvr_psm_clk_ln_3 \
                                     xcvr_cdb_pclk_ln_0 \
                                     xcvr_cdb_pclk_ln_1 \
                                     xcvr_cdb_pclk_ln_2 \
                                     xcvr_cdb_pclk_ln_3 \
                                     tx_td_clk_ln_0 \
                                     tx_td_clk_ln_1 \
                                     tx_td_clk_ln_2 \
                                     tx_td_clk_ln_3 \
                                     tx_bscan_clockdr_ln_0 \
                                     tx_bscan_clockdr_ln_1 \
                                     tx_bscan_clockdr_ln_2 \
                                     tx_bscan_clockdr_ln_3 \
                                     tx_bscan_updatedr_ln_0 \
                                     tx_bscan_updatedr_ln_1 \
                                     tx_bscan_updatedr_ln_2 \
                                     tx_bscan_updatedr_ln_3 \
                                     rx_bscan_clockdr_ln_0 \
                                     rx_bscan_clockdr_ln_1 \
                                     rx_bscan_clockdr_ln_2 \
                                     rx_bscan_clockdr_ln_3 \
                                     rx_bscan_pc_ln_0 \
                                     rx_bscan_pc_ln_1 \
                                     rx_bscan_pc_ln_2 \
                                     rx_bscan_pc_ln_3 \
                                  }]


#cmn_ref_clk0_rcv
#cmn_ref_clk1_rcv
#cmn_ref_clk_der
#cmn_ref_clk_der_n
#rx_gb_clk_ln_*

set func_clk_outputs [get_ports { \
                                      cmn_psm_clk_out \
                                      cmn_ref_clk \
                                      cmn_ref_clk_gated \
                                      cmn_pll0_clk_prog0 \
                                      cmn_pll0_clk_prog1 \
                                      cmn_pll1_clk_prog0 \
                                      cmn_pll1_clk_prog1 \
                                      xcvr_pll_clk_datart_ln_0 \
                                      xcvr_pll_clk_datart_ln_1 \
                                      xcvr_pll_clk_datart_ln_2 \
                                      xcvr_pll_clk_datart_ln_3 \
                                      xcvr_pll_clk_fullrt_ln_0 \
                                      xcvr_pll_clk_fullrt_ln_1 \
                                      xcvr_pll_clk_fullrt_ln_2 \
                                      xcvr_pll_clk_fullrt_ln_3 \
                                      rx_rd_clk_ln_0 \
                                      rx_rd_clk_ln_1 \
                                      rx_rd_clk_ln_2 \
                                      rx_rd_clk_ln_3 \
                                   }]

set func_clk_ports  [add_to_collection $func_clk_inputs $func_clk_outputs]
set scan_clk_inputs [get_ports { \
                                     cmn_psm_clk_in \
                                     cmn_cdb_pclk \
                                     xcvr_psm_clk_ln_0 \
                                     xcvr_psm_clk_ln_1 \
                                     xcvr_psm_clk_ln_2 \
                                     xcvr_psm_clk_ln_3 \
                                     xcvr_cdb_pclk_ln_0 \
                                     xcvr_cdb_pclk_ln_1 \
                                     xcvr_cdb_pclk_ln_2 \
                                     xcvr_cdb_pclk_ln_3 \
                                     tx_td_clk_ln_0 \
                                     tx_td_clk_ln_1 \
                                     tx_td_clk_ln_2 \
                                     tx_td_clk_ln_3 \
                                     cmn_scanclk_ref_clk \
                                     cmn_scanclk_psm_clk \
                                     cmn_scanclk_ser_clk \
                                     cmn_scanclk_pll_clk \
                                     xcvr_scanclk_ser_clk_ln_0 \
                                     xcvr_scanclk_ser_clk_ln_1 \
                                     xcvr_scanclk_ser_clk_ln_2 \
                                     xcvr_scanclk_ser_clk_ln_3 \
                                     xcvr_scanclk_pll_clk_ln_0 \
                                     xcvr_scanclk_pll_clk_ln_1 \
                                     xcvr_scanclk_pll_clk_ln_2 \
                                     xcvr_scanclk_pll_clk_ln_3 \
                                  }]
set clk_inputs      [add_to_collection $func_clk_inputs $scan_clk_inputs]
set clk_outputs     [copy_collection $func_clk_outputs]
set clk_ports       [add_to_collection $clk_inputs $clk_outputs]
Puts "No. func clk ports   = [sizeof_collection $func_clk_ports]"
Puts "No. func clk inputs  = [sizeof_collection $func_clk_inputs]"
Puts "No. func clk outputs = [sizeof_collection $func_clk_outputs]"
Puts "No. scan clk inputs  = [sizeof_collection $scan_clk_inputs]"
Puts "No. all clk inputs   = [sizeof_collection $clk_inputs]"
Puts "No. all clk outputs  = [sizeof_collection $clk_outputs]"
Puts "No. all clk ports    = [sizeof_collection $clk_ports]"

# Scan ports
set scan_ports           [get_ports { *_scan* }]
set scan_data_ports      [remove_from_collection $scan_ports $scan_clk_inputs]
set scanin_ports         [get_ports { *_scanin* }]
set scanout_ports        [get_ports { *_scanout* }]
Puts "No. scan ports         = [sizeof_collection $scan_ports]"
Puts "No. scan data ports    = [sizeof_collection $scan_data_ports]"
Puts "No. scanin ports       = [sizeof_collection $scanin_ports]"
Puts "No. scanout ports      = [sizeof_collection $scanout_ports]"

set cmn_scanin_ports   [get_ports { cmn_scanin* }]
set cmn_scanout_ports  [get_ports { cmn_scanout* }]
set xcvr_scanin_ports  [get_ports { xcvr_scanin* }]
set xcvr_scanout_ports [get_ports { xcvr_scanout* }]
Puts "No. cmn scanin ports   = [sizeof_collection $cmn_scanin_ports]"
Puts "No. cmn scanout ports  = [sizeof_collection $cmn_scanout_ports]"
Puts "No. xcvr scanin ports  = [sizeof_collection $xcvr_scanin_ports]"
Puts "No. xcvr scanout ports = [sizeof_collection $xcvr_scanout_ports]"

# Data ports
set data_ports        [remove_from_collection $top_edge_ports $clk_ports]
set data_inputs       [remove_from_collection $data_ports [all_outputs]]
set data_outputs      [remove_from_collection $data_ports [all_inputs]]
set func_data_ports   [remove_from_collection $data_ports $scan_ports]
set func_data_inputs  [remove_from_collection $func_data_ports [all_outputs]]
set func_data_outputs [remove_from_collection $func_data_ports [all_inputs]]
Puts "No. data ports        = [sizeof_collection $data_ports]"
Puts "No. data inputs       = [sizeof_collection $data_inputs]"
Puts "No. data outputs      = [sizeof_collection $data_outputs]"
Puts "No. func data ports   = [sizeof_collection $func_data_ports]"
Puts "No. func data inputs  = [sizeof_collection $func_data_inputs]"
Puts "No. func data outputs = [sizeof_collection $func_data_outputs]"

# Analog lib interface pins to small digital blocks in xcvr
#set xcvr_ana_cell_collection  [get_cells -hier -filter { ref_lib_cell_name == xcvr_ana }]

#set xcvr_ana_cell_collection  [get_cells -hier -filter { ref_lib_cell_name == rxtxm_ana | ref_lib_cell_name == txm_ana }]

set xcvr_ana_cell_collection  [get_cells -hier -filter { ref_lib_cell_name == rxtxm_ana }]
set xcvr_ana_cdrlf_func_pins  [get_pins -of $xcvr_ana_cell_collection \
                                   -filter { ref_lib_pin_name =~ "rxda_cdrlf*" && ref_lib_pin_name !~ "rxda_cdrlf_scan*" }]
set xcvr_ana_cdrlf_scan_pins  [get_pins -of $xcvr_ana_cell_collection \
                                   -filter { ref_lib_pin_name =~ "rxda_cdrlf_scan*" && ref_lib_pin_name !~ "rxda_cdrlf_scanclk" }]
Puts "No. xcvr_ana cdrlf func pins  = [sizeof_collection $xcvr_ana_cdrlf_func_pins]"
Puts "No. xcvr_ana cdrlf scan pins  = [sizeof_collection $xcvr_ana_cdrlf_scan_pins]"
foreach_in_collection pin $xcvr_ana_cdrlf_func_pins { puts [get_object $pin] }
foreach_in_collection pin $xcvr_ana_cdrlf_scan_pins { puts [get_object $pin] }

set xcvr_ana_dfe_func_pins  [get_pins -of $xcvr_ana_cell_collection \
                                 -filter { ref_lib_pin_name =~ "rxda_dfe*" && ref_lib_pin_name !~ "rxda_dfe_scan*" }]
#set xcvr_ana_dfe_scan_pins  [get_pins -of $xcvr_ana_cell_collection \
#                                 -filter { ref_lib_pin_name =~ "rxda_dfe_scan*" && ref_lib_pin_name !~ "rxda_dfe_scanclk" }]
Puts "No. xcvr_ana dfe func pins  = [sizeof_collection $xcvr_ana_dfe_func_pins]"
#Puts "No. xcvr_ana dfe scan pins  = [sizeof_collection $xcvr_ana_dfe_scan_pins]"
foreach_in_collection pin $xcvr_ana_dfe_func_pins { puts [get_object $pin] }
#foreach_in_collection pin $xcvr_ana_dfe_scan_pins { puts [get_object $pin] }


set xcvr_ana_drv_func_pins  [get_pins -of $xcvr_ana_cell_collection \
                                 -filter { ref_lib_pin_name =~ "txda_drv*" && ref_lib_pin_name !~ "txda_drv_scan*" }]
set xcvr_ana_drv_scan_pins  [get_pins -of $xcvr_ana_cell_collection \
                                 -filter { ref_lib_pin_name =~ "txda_drv_scan*" && ref_lib_pin_name !~ "txda_drv_scanclk" }]
set xcvr_ana_drv_scan_pins        [get_pins -of $xcvr_ana_cell_collection -filter { ref_lib_pin_name =~ "txda_drv_scan*" }]
Puts "No. xcvr_ana drv func pins    = [sizeof_collection $xcvr_ana_drv_func_pins]"
Puts "No. xcvr_ana drv scan pins    = [sizeof_collection $xcvr_ana_drv_scan_pins]"
foreach_in_collection pin $xcvr_ana_drv_func_pins { puts [get_object $pin] }
foreach_in_collection pin $xcvr_ana_drv_scan_pins { puts [get_object $pin] }


#add txm ana pins for timberwolf
set txm_ana_cell_collection  [get_cells -hier -filter { ref_lib_cell_name == txm_ana }]

set txm_ana_drv_func_pins  [get_pins -of $txm_ana_cell_collection \
                                 -filter { ((ref_lib_pin_name =~ "txda0_drv*" && ref_lib_pin_name !~ "txda0_drv_scan*")  \
                                         || (ref_lib_pin_name =~ "txda1_drv*" && ref_lib_pin_name !~ "txda1_drv_scan*")) }]
#set txm_ana_drv_scan_pins  [get_pins -of $txm_ana_cell_collection \
#                                 -filter { ((ref_lib_pin_name =~ "txda0_drv_scan*" && ref_lib_pin_name !~ "txda0_drv_scanclk") \
#                                        ||  (ref_lib_pin_name =~ "txda1_drv_scan*" && ref_lib_pin_name !~ "txda1_drv_scanclk")) }]
set txm_ana_drv_scan_pins        [get_pins -of $txm_ana_cell_collection -filter { ref_lib_pin_name =~ "txda0_drv_scan*" || ref_lib_pin_name =~ "txda1_drv_scan*"  }]
Puts "No. txm_ana drv func pins    = [sizeof_collection $txm_ana_drv_func_pins]"
Puts "No. txm_ana drv scan pins    = [sizeof_collection $txm_ana_drv_scan_pins]"
foreach_in_collection pin $txm_ana_drv_func_pins { puts [get_object $pin] }
foreach_in_collection pin $txm_ana_drv_scan_pins { puts [get_object $pin] }


###############################################################################
# Clock period and waveform definitions
###############################################################################
# Setup period scaling ability for BTI and Asymmetric aging as a period multiplier
# Initially update to 0.955 per DDR sims that resulted in a bound of 4.5%
set BTI_scalar            0.955

#add for timewolf
if { [info exists load_syn_sdc] && $load_syn_sdc == "0" } {
   set TOOL_scalar           1
} else {
   set TOOL_scalar           0.700
}
set ALL_scalar [expr $TOOL_scalar * $BTI_scalar]


# 62.5 MHz
set CLK62P5_PERIOD       [expr $ALL_scalar * 16.000]
set CLK62P5_WAVEFORM     " 0.0 [expr $CLK62P5_PERIOD / 2] "

# 100 MHz
set CLK100_PERIOD        [expr $ALL_scalar * 10.000]
set CLK100_WAVEFORM      " 0.0 [expr $CLK100_PERIOD / 2] "
set CLK100_INV_WAVEFORM  " [expr $CLK100_PERIOD / 2] $CLK100_PERIOD "

# 125 MHz
set CLK125_PERIOD        [expr $ALL_scalar * 8.000]
set CLK125_WAVEFORM      " 0.0 [expr $CLK125_PERIOD / 2] "

# 135 MHz
set CLK135_PERIOD        [expr $ALL_scalar * 7.400]
set CLK135_WAVEFORM      " 0.0 [expr $CLK135_PERIOD / 2] "

# 156.25 MHz
set CLK156P25_PERIOD        [expr $ALL_scalar * 6.400]
set CLK156P25_WAVEFORM      " 0.0 [expr $CLK156P25_PERIOD / 2] "

# 200 MHz - update to 225MHz for Intel 22
set CLK200_PERIOD        [expr $ALL_scalar * 5.000]
set CLK200_WAVEFORM      " 0.0 [expr $CLK200_PERIOD / 2] "

# 250 MHz
set CLK250_PERIOD        [expr $ALL_scalar * 4.000]
set CLK250_WAVEFORM      " 0.0 [expr $CLK250_PERIOD / 2] "

# 270 MHz
set CLK270_PERIOD        [expr $ALL_scalar * 3.700]
set CLK270_WAVEFORM      " 0.0 [expr $CLK270_PERIOD / 2] "

# 500 MHz
set CLK500_PERIOD        [expr $ALL_scalar * 2.000]
set CLK500_WAVEFORM      " 0.0 [expr $CLK500_PERIOD / 2] "

# 525 MHz
set CLK525_PERIOD        [expr $ALL_scalar * 1.904]
set CLK525_WAVEFORM      " 0.0 [expr $CLK525_PERIOD / 2] "

# 156.25 MHz
set CLK156P25_PERIOD      [expr $ALL_scalar * 6.400]
set CLK156P25_WAVEFORM    " 0.0 [expr $CLK156P25_PERIOD / 2] "
set CLK156P25_INV_WAVEFORM    " [expr $CLK156P25_PERIOD / 2] $CLK156P25_PERIOD "

# 312.5 MHz
set CLK312P5_PERIOD      [expr $ALL_scalar * 3.200]
set CLK312P5_WAVEFORM    " 0.0 [expr $CLK312P5_PERIOD / 2] "

# 625 MHz - includes 4% DC jitter per Mark Hale
set CLK625_PERIOD        [expr $ALL_scalar * 1.600]
set CLK625_WAVEFORM      " 0.0 [expr $CLK625_PERIOD / 2] "

# 644.531MHz 10GKR
set CLK644_PERIOD        [expr $ALL_scalar * 1.552]
set CLK644_WAVEFORM      " 0.0 [expr $CLK644_PERIOD / 2] "

# 650 MHz
set CLK650_PERIOD        [expr $ALL_scalar * 1.538]
set CLK650_WAVEFORM      " 0.0 [expr $CLK650_PERIOD / 2] "

# 1000MHz
set CLK1000_PERIOD      [expr $ALL_scalar * 1.000]
set CLK1000_WAVEFORM    " 0.0 [expr $CLK1000_PERIOD / 2] "

# 1250MHz
set CLK1250_PERIOD      [expr $ALL_scalar * 0.800]
set CLK1250_WAVEFORM    " 0.0 [expr $CLK1250_PERIOD / 2] "

# rx_dp_clk 1000MHz with instantaneous clock cycle adjust for PI step -> 1008.867MHz per SER-23128
# update rxdpclk to 1.25G (0.800*0.991 = 0.792)
#set RXDPCLK_PERIOD      [expr $ALL_scalar * 0.991]
set RXDPCLK_PERIOD      [expr $ALL_scalar * 0.792]
set RXDPCLK_WAVEFORM    " 0.0 [expr $RXDPCLK_PERIOD / 2] "

# 2000MHz
set CLK2000_PERIOD      [expr $ALL_scalar * 0.500]
set CLK2000_WAVEFORM    " 0.0 [expr $CLK2000_PERIOD / 2] "

# rx_dp_clk_cal 1125MHz only can take place during RX PI ILL calibration
set RXDPCLKCAL_PERIOD      [expr $ALL_scalar * 0.991]
set RXDPCLKCAL_WAVEFORM    " 0.0 [expr $RXDPCLKCAL_PERIOD / 2] "

# Assume DSM runs at 200MHz to support atspeed and calibrations with 40-60% DC
set DSMCLK_PERIOD        [expr $ALL_scalar * 5.000]
set DSMCLK_WAVEFORM      " 0.0 [expr $DSMCLK_PERIOD / 2] "

# Assume SDCLK runs at 625 MHz
set SDCLK_PERIOD         [expr $ALL_scalar * 1.600]
set SDCLK_WAVEFORM       " 0.0 [expr $SDCLK_PERIOD / 2] "

# PLLN_REF_CLK 1289.0625MHz
set CLKPLLN_PERIOD       [expr $ALL_scalar * 0.775]
set CLKPLLN_WAVEFORM     " 0.0 [expr $CLKPLLN_PERIOD / 2] "

# Boundary scan - 100 MHz
set BSCAN_PERIOD         [expr $ALL_scalar * 10.000]
set BSCAN_WAVEFORM       " 0.0 [expr $BSCAN_PERIOD / 2] "

# For asynchronous clocks
set ASYNC_PERIOD         [expr $ALL_scalar * 17.000]
set ASYNC_WAVEFORM       " 0.0 [expr $ASYNC_PERIOD / 2] "

# Stuck-at scan clocks - 200 MHz
set STUCKAT_PERIOD        [expr $ALL_scalar * 5.000]
set STUCKAT_WAVEFORM      " 0.0 [expr $STUCKAT_PERIOD / 2] "

# Scan shift clocks - 200 MHz
set SHIFT_PERIOD         [expr $ALL_scalar * 5.000]
set SHIFT_WAVEFORM       " 0.0 [expr $SHIFT_PERIOD / 2] "

###############################################################################
# Transition, uncertainty and skew values
###############################################################################
####NEED TO UPDATE FOR WHISTLER
# 2017.01.20_N16FFC_v1.0_Sign-off_Recommendation.pdf slide 7 Vnom=0.8V : SSGNP/0.72V/-40C
#set max_trans     0.200
#set max_clk_trans 0.100
#update for timberwolf
set max_trans     0.250
set max_clk_trans 0.125

# Hold value between data_sync and reset_sync flops = 0 ps + DPT 3ps
# Modify hold margin to 29ps + 3ps DPT = 32ps
set setup_margin    0.125
set setup_dc_margin 0.125
set hold_margin     0.005
set mtbf_margin     0.003

#
# Margins to account for incoming clock skew that may exist at the SOC level.
# Need a minimum of 100 ps.
#

# PSM input clocks (cmn_psm_clk_in and xcvr_psm_clk_ln_*).
# This is for functional and scan capture modes.
set psmclk_skew   0.205

# FIFO read reset clocks (cmnda_ser_clk and txda_ser_clk).
# This is for functional and scan capture modes.
# JMY 20160921 Increase based upon request from NY
set serclk_skew   0.205

# tx_td_clk_ln_* input clocks.
# This is for functional and scan capture modes.
set txtdclk_skew  0.205


# CDB input clocks
set cdbclk_skew  0.205



###############################################################################
# Don't use/touch
###############################################################################

#set_dont_touch [get_nets { gnd }]
#set_dont_touch [get_nets { cmn_ref_clk0_p }]
#set_dont_touch [get_nets { cmn_ref_clk0_m }]
#set_dont_touch [get_nets { cmn_ref_clk1_p }]
#set_dont_touch [get_nets { cmn_ref_clk1_m }]
#set_dont_touch [get_nets { tx_p_ln_* }]
#set_dont_touch [get_nets { tx_m_ln_* }]
#set_dont_touch [get_nets { rx_p_ln_* }]
#set_dont_touch [get_nets { rx_m_ln_* }]
#set_dont_touch [get_nets { *_avdd *_avdd_* *_aonvdd }]


set_dont_touch [get_nets { cmn_rext }]
set_dont_touch [get_nets { agnd }]
set_dont_touch [get_nets { avdd_clk avdd_h avdd avdd_tx0 avdd_tx1 avdd_tx2 avdd_tx3 avdd_rx cmn_aonvdd}]
set_dont_touch [get_nets { cmn_ref_clk0_int }]
set_dont_touch [get_nets { cmn_ref_clk1_int }]
set_dont_touch [get_nets { cmn_atb_core_0 }]
set_dont_touch [get_nets { cmn_atb_core_1 }]
set_dont_touch [get_nets { xcvr_p_ln_* }]
set_dont_touch [get_nets { xcvr_m_ln_* }]
