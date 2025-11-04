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
# Filename    : cmn.preamble.sdc
# Author(s)   : Dave Masters and Jack Yarolin
# Abstract    : Preabmle constraint file for Whistler CMN.
# Last Commit:
#     $Rev: 128706 $
#     $Date: 2022-11-01 04:04:14 +0800 (Tue, 01 Nov 2022) $
#     $Author: dominicl $
###############################################################################
# Change Log: Request via SVN query.
###############################################################################
if { ![info exists load_syn_sdc] } {
    puts "INFO: setting load_syn_sdc = 0"
    set load_syn_sdc 0
}

if { ![info exists load_post_map_syn_sdc] } {
    puts "INFO: setting load_post_map_syn_sdc = 0"
    set load_post_map_syn_sdc 0
}

if { ![info exists ::timeMode] } {
    puts "INFO: setting ::timeMode to ideal"
    set ::timeMode ideal
}

if { ![info exists ctsMode] } {
    puts "INFO: setting ctsMode to 0"
    set ctsMode 0
}

if { ![info exists fp_hold_to_mtbf_flops] } {
    puts "INFO: setting fp_hold_to_mtbf_flops to 0"
    set fp_hold_to_mtbf_flops 0
}

#TODO
#now our clock_mux use reuse ip cdnsdru_clock_mux_v0.v
#it is pure RTL code so no change in the inital stage
#need double confirm at stable stage.

# Synthesis (pre-mapped)
#if { $load_syn_sdc && !$load_post_map_syn_sdc } {
    #set clk_mux_pin_0   "u_dont_touch_scan_mux/i0"
#    set clk_mux_pin_0   "clk_in[0]"
#    set clk_mux_pin_1   "clk_in[1]"
#    set clk_mux_out_pin "clk_out"
#    set scan_mux_pin    "fcn_signal_in"
## Synthesis (post-mapped) or P&R
#} else {
#    set clk_mux_pin_0   "RC_i_1/I0"
#    set clk_mux_pin_1   "RC_i_1/I1"
#    set clk_mux_out_pin "RC_i_1/Z"
#    set scan_mux_pin    "u_scan_mux_synth/u_mux/I0"
#}

set scan_mux_pin           "u_scan_mux_synth/u_dont_touch_scan_mux/I0"
set clk_mux_pin_0          "*u_clock_mux_synth/*u_dont_touch_ck_mux/I0"
set clk_mux_pin_1          "*u_clock_mux_synth/*u_dont_touch_ck_mux/I1"
set clk_mux_out_pin        "*u_clock_mux_synth/*u_dont_touch_ck_mux/Z"



if { ![info exists ::DRIVING_CELL] } {
   set ::DRIVING_CELL [get_lib_cells BUFFMZD4BWP210H6P51CNODSVT]
   set ::DRIVING_PIN Z
   puts "INFO: setting DRIVING_CELL = [get_property $::DRIVING_CELL name]"
}

###############################################################################
# Clock period, waveform, and uncertainty variable settings.
###############################################################################
# Setup period scaling ability for BTI and Asymmetric aging as a period multiplier
# Initially update to 0.955 per DDR sims that resulted in a bound of 4.5%
set BTI_scalar            0.955

#add 
if { [info exists load_syn_sdc] && $load_syn_sdc == "0" } {
   set TOOL_scalar           1
} else {
   set TOOL_scalar           0.700
}
set ALL_scalar [expr $TOOL_scalar * $BTI_scalar]


#replace BTI_scalar with ALL_scalar
#Done

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
set CLK156P25_INV_WAVEFORM    " [expr $CLK156P25_PERIOD / 2] $CLK156P25_PERIOD "

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
#set CLK156P25_PERIOD      [expr $ALL_scalar * 6.400]
#set CLK156P25_WAVEFORM    " 0.0 [expr $CLK156P25_PERIOD / 2] "

# 312.5 MHz
set CLK312P5_PERIOD      [expr $ALL_scalar * 3.200]
set CLK312P5_WAVEFORM    " 0.0 [expr $CLK312P5_PERIOD / 2] "

# 625 MHz - includes 4% DC jitter per Mark Hale
set CLK625_PERIOD        [expr $ALL_scalar * 1.600]
set CLK625_WAVEFORM      " 0.0 [expr $CLK625_PERIOD / 2] "

# 644.531MHz 10GKR
set CLK644P531_PERIOD      [expr $ALL_scalar * 1.552]
set CLK644P531_WAVEFORM    " 0.0 [expr $CLK644P531_PERIOD / 2] "

# 650 MHz - SER-22698
set CLK650_PERIOD        [expr $ALL_scalar * 1.538]
set CLK650_WAVEFORM      " 0.0 [expr $CLK650_PERIOD / 2] "

# 1000MHz
set CLK1000_PERIOD      [expr $ALL_scalar * 1.000]
set CLK1000_WAVEFORM    " 0.0 [expr $CLK1000_PERIOD / 2] "

# 1250MHz
set CLK1250_PERIOD      [expr $ALL_scalar * 0.800]
set CLK1250_WAVEFORM    " 0.0 [expr $CLK1000_PERIOD / 2] "

# 2000MHz
set CLK2000_PERIOD      [expr $ALL_scalar * 0.500]
set CLK2000_WAVEFORM    " 0.0 [expr $CLK2000_PERIOD / 2] "

# Assume DSM runs at 200MHz to support atspeed and calibrations with 40-60% DC
set DSMCLK_PERIOD        [expr $ALL_scalar * 5.000]
set DSMCLK_WAVEFORM      " 0.0 [expr $DSMCLK_PERIOD / 2] "

# 593.75 MHz
set LOCKDET_PERIOD       [expr $ALL_scalar * 1.680]
set LOCKDET_WAVEFORM     " 0.0 [expr $LOCKDET_PERIOD / 2] "

# Assume SDCLK runs at 625 MHz
set SDCLK_PERIOD         [expr $ALL_scalar * 1.600]
set SDCLK_WAVEFORM       " 0.0 [expr $SDCLK_PERIOD / 2] "

# Boundary scan - 100 MHz
## OR- Changinf DC to 40/60 as per conversation with MarkT on 02022021 Jabber
set BSCAN_PERIOD         [expr $ALL_scalar * 10.000]
set BSCAN_WAVEFORM       " 0.0 [expr $BSCAN_PERIOD * 0.4] "

# For asynchronous clocks
set ASYNC_PERIOD         [expr $ALL_scalar * 17.000]
set ASYNC_WAVEFORM       " 0.0 [expr $ASYNC_PERIOD / 2] "

# Stuck-at scan clocks - 200 MHz
set STUCKAT_PERIOD        [expr $ALL_scalar * 5.000]
set STUCKAT_WAVEFORM      " 0.0 [expr $STUCKAT_PERIOD / 2] "

# Scan shift clocks - 200 MHz
set SHIFT_PERIOD         [expr $ALL_scalar * 5.000]
set SHIFT_WAVEFORM       " 0.0 [expr $SHIFT_PERIOD / 2] "

####NEED TO UPDATE FOR WHISTLER
# 2017.01.20_N16FFC_v1.0_Sign-off_Recommendation.pdf slide 7 Vnom=0.8V : SSGNP/0.72V/-40C
#set max_trans     0.200
#set max_clk_trans 0.100
set max_trans     0.250
set max_clk_trans 0.125


# Hold value between data_sync and reset_sync flops = 0 ps + DPT 3ps
# Modify hold margin to 29ps + 3ps DPT = 32ps
#Just for initial,need double confirm at stable.
set setup_margin    0.125
set setup_dc_margin 0.125
set hold_margin     0.005
set mtbf_margin     0.003


###############################################################################
# Ports
###############################################################################

#cmn_ref_clk_der \


set top_port_list           [list \
cmn_avdd_pwrgood \
cmn_bscan_mode_en \
cmn_cdb_paddr[*] \
cmn_cdb_pclk \
cmn_cdb_penable \
cmn_cdb_prdata[*] \
cmn_cdb_pready \
cmn_cdb_preset_n \
cmn_cdb_psel \
cmn_cdb_pwdata[*] \
cmn_cdb_pwrite \
cmn_macro_suspend_ack \
cmn_macro_suspend_req \
cmn_pll0_clk_prog0 \
cmn_pll0_clk_prog1 \
cmn_pll0_disabled \
cmn_pll0_en \
cmn_pll0_locked \
cmn_pll0_mode_sel \
cmn_pll0_ready \
cmn_pll0_ref_clk_sel[*] \
cmn_pll0_reset_n \
cmn_pll0_suspend_ack \
cmn_pll0_suspend_req \
cmn_pll1_clk_prog0 \
cmn_pll1_clk_prog1 \
cmn_pll1_disabled \
cmn_pll1_en \
cmn_pll1_locked \
cmn_pll1_mode_sel \
cmn_pll1_ready \
cmn_pll1_ref_clk_sel[*] \
cmn_pll1_reset_n \
cmn_pll1_suspend_ack \
cmn_pll1_suspend_req \
cmn_psm_clk_in \
cmn_psm_clk_out \
cmn_ready \
cmn_ref_clk \
cmn_ref_clk0_int \
cmn_ref_clk_active \
cmn_ref_clk_dig_div[*] \
cmn_ref_clk_dig_sel    \
cmn_ref_clk_disable \
cmn_ref_clk_gated \
cmn_reset_n \
cmn_scanclk_pll0_prog0_ats_out \
cmn_scanclk_pll0_prog1_ats_out \
cmn_scanclk_pll1_prog0_ats_out \
cmn_scanclk_pll1_prog1_ats_out \
cmn_scanclk_pll_clk \
cmn_scanclk_psm_clk \
cmn_scanclk_ref_clk \
cmn_scanclk_ser_clk \
cmn_scanen \
cmn_scanen_cg \
cmn_scanin[*] \
cmn_scanmode \
cmn_scanout[*] \
cmn_scan_pll_ats \
macro_id_flavor[*] \
macro_id_io_voltage[*] \
macro_id_metal_layers_0[*] \
macro_id_metal_layers_1[*] \
macro_id_metal_layers_2[*] \
macro_id_metal_layers_3[*] \
macro_id_metal_layers_d[*] \
macro_id_num_lanes_l[*] \
macro_id_num_lanes_r[*] \
macro_id_prod_num[*] \
macro_id_rev[*] \
macro_id_tie_high[*] \
macro_id_tie_low[*] \
                            ]


set analog_port_list        [list \
cmn_rext \
cmn_atb_core_0 \
cmn_atb_core_1 \
ana_clk_1_p_out_l \
ana_clk_1_m_out_l \
ana_clk_1_p_out_r \
ana_clk_1_m_out_r \
ana_clk_0_p_out_l \
ana_clk_0_m_out_l \
ana_clk_0_p_out_r \
ana_clk_0_m_out_r \
ana_tx_clk_reset_rel_l \
ana_tx_clk_reset_rel_r \
ana_sd_clk_l \
ana_sd_clk_r \
ana_ls_en_h_n \
ana_atb_0 \
ana_atb_1 \
ibg_rxafe_fromp_12p5u_h[*]      \
ibg_rxtxm_sd_fromp_25u_h[*]     \
iext_rxtxm_clkdist_fromn_50u[*] \
iext_rxtxm_clkdist_fromp_50u[*] \
iext_rxtxm_fromn_25u[*]         \
iext_txm_clkdist_fromn_50u[*]   \
ipoly_rxafe_fromp_25u[*]        \
ipoly_rxtxm_fromn_25u[*]        \
iptat_rxafe_fromp_12p5u_h[*]    \
                            ]


set power_ground_port_list  [list \
agnd \
avdd \
avdd_clk \
avdd_h \
cmn_aonvdd \
                            ]

set clock_input_port_list   [list \
cmn_ref_clk0_int \
cmn_ref_clk1_int \
cmn_psm_clk_in \
cmn_cdb_pclk \
cmn_scanclk_ref_clk \
cmn_scanclk_psm_clk \
cmn_scanclk_ser_clk \
cmn_scanclk_pll_clk \
                            ]
#cmn_ref_clk_der \

set clock_output_port_list  [list \
cmn_psm_clk_out \
cmn_ref_clk \
cmn_ref_clk_gated \
cmn_pll0_clk_prog0 \
cmn_pll0_clk_prog1 \
cmn_pll1_clk_prog0 \
cmn_pll1_clk_prog1 \
cmn_scanclk_pll0_prog0_ats_out \
cmn_scanclk_pll0_prog1_ats_out \
cmn_scanclk_pll1_prog0_ats_out \
cmn_scanclk_pll1_prog1_ats_out \
cmn_ref_clk_gated_l \
cmn_ref_clk_gated_r \
cmn_scanclk_ref_clk_l \
cmn_scanclk_ref_clk_r \
                            ]



set reset_input_port_list   [list \
cmn_reset_n \
cmn_pll0_reset_n \
cmn_pll1_reset_n \
cmn_cdb_preset_n \
                            ]
set reset_output_port_list  [list \
cmn_reset_n_l \
cmn_reset_n_r \
                            ]

set async_input_port_list       [list \
cmn_bscan_mode_en \
cmn_cdb_preset_n \
cmn_macro_suspend_req \
cmn_pll0_en \
cmn_pll0_mode_sel \
cmn_pll0_ref_clk_sel[*] \
cmn_pll0_reset_n \
cmn_pll0_suspend_req \
cmn_pll1_en \
cmn_pll1_mode_sel \
cmn_pll1_ref_clk_sel[*] \
cmn_pll1_reset_n \
cmn_pll1_suspend_req \
cmn_ref_clk1_int \
cmn_ref_clk_dig_div[*] \
cmn_ref_clk_dig_sel    \
cmn_ref_clk_disable \
cmn_reset_n \
cmn_scanen \
cmn_scanen_cg \
cmn_scanin[*] \
cmn_scanmode \
cmn_scan_pll_ats \
macro_id_flavor[*] \
macro_id_io_voltage[*] \
macro_id_metal_layers_0[*] \
macro_id_metal_layers_1[*] \
macro_id_metal_layers_2[*] \
macro_id_metal_layers_3[*] \
macro_id_metal_layers_d[*] \
macro_id_prod_num[*] \
macro_id_rev[*] \
				     ]

set async_output_port_list      [list \
cmn_avdd_pwrgood \
cmn_pll0_locked \
cmn_pll1_locked \
cmn_scanout[*] \
macro_id_tie_high[*] \
macro_id_tie_low[*] \
				     ]

#debug
#set analog_ports_found [get_ports  $analog_port_list]
#puts "DEBUG: Found [sizeof_collection $analog_ports_found] analog ports: $analog_ports_found"
#set analog_port_collection              [get_ports $analog_port_list]


set top_input_port_collection           [remove_from_collection [get_ports $top_port_list] [all_outputs]]
set top_output_port_collection          [remove_from_collection [get_ports $top_port_list] [all_inputs]]
set analog_port_collection              [add_to_collection [get_ports $analog_port_list] [get_ports $power_ground_port_list]]
set digital_input_port_collection       [remove_from_collection [all_inputs]  $analog_port_collection]
set digital_output_port_collection      [remove_from_collection [all_outputs] $analog_port_collection]
set clock_reset_input_port_collection   [add_to_collection [get_ports $clock_input_port_list]  [get_ports $reset_input_port_list]]
set clock_reset_output_port_collection  [add_to_collection [get_ports $clock_output_port_list] [get_ports $reset_output_port_list]]
set data_input_port_collection          [remove_from_collection $digital_input_port_collection  $clock_reset_input_port_collection]
set data_output_port_collection         [remove_from_collection $digital_output_port_collection $clock_reset_output_port_collection]
set async_input_port_collection         [get_ports $async_input_port_list]
set async_output_port_collection        [get_ports $async_output_port_list]
