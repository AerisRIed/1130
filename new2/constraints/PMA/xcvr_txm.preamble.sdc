#(C) COPYRIGHT 2025 Cadence ALL RIGHTS RESERVED
# Filename    : xcvr_txm.preamble.sdc
# Author(s)   : Ran Jin
# Abstract    : Preamble constraint file for Timberwolf XCVR TXM (TX-only module).
#------------------------------------
if { ![info exists load_syn_sdc] } {
   puts "INFO: setting load_syn_sdc = 0"
   set load_syn_sdc 0
}

if { ![info exists load_post_map_syn_sdc] } {
   puts "INFO: setting load_post_map_syn_sdc = 0"
   set load_post_map_syn_sdc 0
}

# IMPORTANT:There are several variables that can be optionally set:
#      ::timeMode      - Clocking mode. Valid values are "prop" and "ideal".
if { ![info exists ::timeMode] } {
   puts "INFO: setting ::timeMode to ideal"
   set ::timeMode ideal
}

if { ![info exists ctsMode] } {
   puts "INFO: setting ctsMode to 0"
   set ctsMode 0
}

# Synthesis (pre-mapped)
if { $load_syn_sdc && !$load_post_map_syn_sdc } {
    set scan_mux_pin            "fcn_signal_in"
    set clk_mux0_pin_0          "clk_in[0]"
    set clk_mux0_pin_1          "clk_in[1]"
    set clk_mux0_I0_pin         "clk_in[0]"
    set clk_mux0_I1_pin         "clk_in[1]"
    set clk_mux0_Z_pin          "clk_out"
    set clk_mux1_I0_pin         "clk_in[0]"
    set clk_mux1_I1_pin         "clk_in[1]"
    set cm_clk_mux_Z_pin        "clk_out"
    set rx_rd_fe_lpbk_clk_pin   "rx_rd_fe_lpbk_clk"
    set tx_td_ne_lpbk_clk_pin   "tx_td_ne_lpbk_clk"

# Synthesis (post-mapped) or P&R
} else {
    set scan_mux_pin            "u_scan_mux_synth/u_mux/I0"
    set clk_mux0_I0_pin         "RC_i_1/I0"
    set clk_mux0_I1_pin         "RC_i_1/I1"
    set clk_mux0_Z_pin          "RC_i_1/Z"
    set clk_mux1_I0_pin         "RC_i_1/I0"
    set clk_mux1_I1_pin         "RC_i_1/I1"
    set clk_mux1_Z_pin          "RC_i_1/Z"
    set cm_clk_mux_Z_pin        "u_clock_mux1/Z"
    set rx_rd_fe_lpbk_clk_pin   "u_clk_gating_and_rx_rd_fe_lpbk_clk/u_clk_gating_and_synth/u_dont_touch_ck_and/Z"
    set tx_td_ne_lpbk_clk_pin   "u_clk_gating_and_tx_td_ne_lpbk_clk/u_clk_gating_and_synth/u_dont_touch_ck_and/Z"
}

###############################################################################
# Clock period, waveform, and uncertainty variable settings.
###############################################################################
# Setup period scaling ability for BTI and Asymmetric aging as a period multiplier
# Initially update to 0.955 per DDR sims that resulted in a bound of 4.5%
set BTI_scalar            0.955

# 62.5 MHz
set CLK62P5_PERIOD       [expr $BTI_scalar * 16.000]
set CLK62P5_WAVEFORM     " 0.0 [expr $CLK62P5_PERIOD / 2] "

# 100 MHz
set CLK100_PERIOD        [expr $BTI_scalar * 10.000]
set CLK100_WAVEFORM      " 0.0 [expr $CLK100_PERIOD / 2] "
set CLK100_INV_WAVEFORM  " [expr $CLK100_PERIOD / 2] $CLK100_PERIOD "

# 125 MHz
set CLK125_PERIOD        [expr $BTI_scalar * 8.000]
set CLK125_WAVEFORM      " 0.0 [expr $CLK125_PERIOD / 2] "

# 135 MHz
set CLK135_PERIOD        [expr $BTI_scalar * 7.400]
set CLK135_WAVEFORM      " 0.0 [expr $CLK135_PERIOD / 2] "

# 156.25 MHz
set CLK156P25_PERIOD        [expr $BTI_scalar * 6.400]
set CLK156P25_WAVEFORM      " 0.0 [expr $CLK156P25_PERIOD / 2] "

# 200 MHz - update to 225MHz for Intel 22
set CLK200_PERIOD        [expr $BTI_scalar * 5.000]
set CLK200_WAVEFORM      " 0.0 [expr $CLK200_PERIOD / 2] "

# 250 MHz
set CLK250_PERIOD        [expr $BTI_scalar * 4.000]
set CLK250_WAVEFORM      " 0.0 [expr $CLK250_PERIOD / 2] "

# 270 MHz
set CLK270_PERIOD        [expr $BTI_scalar * 3.700]
set CLK270_WAVEFORM      " 0.0 [expr $CLK270_PERIOD / 2] "

# 500 MHz
set CLK500_PERIOD        [expr $BTI_scalar * 2.000]
set CLK500_WAVEFORM      " 0.0 [expr $CLK500_PERIOD / 2] "

# 525 MHz
set CLK525_PERIOD        [expr $BTI_scalar * 1.904]
set CLK525_WAVEFORM      " 0.0 [expr $CLK525_PERIOD / 2] "

# 156.25 MHz
set CLK156P25_PERIOD      [expr $BTI_scalar * 6.400]
set CLK156P25_WAVEFORM    " 0.0 [expr $CLK156P25_PERIOD / 2] "
set CLK156P25_INV_WAVEFORM    " [expr $CLK156P25_PERIOD / 2] $CLK156P25_PERIOD "

# 312.5 MHz
set CLK312P5_PERIOD      [expr $BTI_scalar * 3.200]
set CLK312P5_WAVEFORM    " 0.0 [expr $CLK312P5_PERIOD / 2] "

# 625 MHz - includes 4% DC jitter per Mark Hale
set CLK625_PERIOD        [expr $BTI_scalar * 1.600]
set CLK625_WAVEFORM      " 0.0 [expr $CLK625_PERIOD / 2] "

# 644MHz 10GKR
set CLK644_PERIOD        [expr $BTI_scalar * 1.552]
set CLK644_WAVEFORM      " 0.0 [expr $CLK644_PERIOD / 2] "

# 650 MHz
set CLK650_PERIOD        [expr $BTI_scalar * 1.538]
set CLK650_WAVEFORM      " 0.0 [expr $CLK650_PERIOD / 2] "

# 1000MHz
set CLK1000_PERIOD      [expr $BTI_scalar * 1.000]
set CLK1000_WAVEFORM    " 0.0 [expr $CLK1000_PERIOD / 2] "

# rx_dp_clk 1000MHz with instantaneous clock cycle adjust for PI step -> 1008.867MHz per SER-23128
set RXDPCLK_PERIOD      [expr $BTI_scalar * 0.991]
set RXDPCLK_WAVEFORM    " 0.0 [expr $RXDPCLK_PERIOD / 2] "

# rx_dp_clk_cal 1125MHz only can take place during RX PI ILL calibration
set RXDPCLKCAL_PERIOD      [expr $BTI_scalar * 0.991]
set RXDPCLKCAL_WAVEFORM    " 0.0 [expr $RXDPCLKCAL_PERIOD / 2] "

# 1250MHz
set CLK1250_PERIOD      [expr $BTI_scalar * 0.800]
set CLK1250_WAVEFORM    " 0.0 [expr $CLK1250_PERIOD / 2] "

# 1328.125MHz
set CLK1328P125_PERIOD      [expr $BTI_scalar * 0.752]
set CLK1328P125_WAVEFORM    " 0.0 [expr $CLK1328P125_PERIOD / 2] "

# Assume DSM runs at 200MHz to support atspeed and calibrations with 40-60% DC
set DSMCLK_PERIOD        [expr $BTI_scalar * 5.000]
set DSMCLK_WAVEFORM      " 0.0 [expr $DSMCLK_PERIOD / 2] "

# Assume SDCLK runs at 625 MHz
set SDCLK_PERIOD         [expr $BTI_scalar * 1.600]
set SDCLK_WAVEFORM       " 0.0 [expr $SDCLK_PERIOD / 2] "

# PLLN_REF_CLK 1289.0625MHz
set CLKPLLN_PERIOD       [expr $BTI_scalar * 0.775]
set CLKPLLN_WAVEFORM     " 0.0 [expr $CLKPLLN_PERIOD / 2] "

# Boundary scan - 100 MHz 
set BSCAN_PERIOD         [expr $BTI_scalar * 10.000]
set BSCAN_WAVEFORM       " 0.0 [expr $BSCAN_PERIOD / 2] "

# For asynchronous clocks
set ASYNC_PERIOD         [expr $BTI_scalar * 17.000]
set ASYNC_WAVEFORM       " 0.0 [expr $ASYNC_PERIOD / 2] "

# Stuck-at scan clocks - 200 MHz
set STUCKAT_PERIOD        [expr $BTI_scalar * 5.000]
set STUCKAT_WAVEFORM      " 0.0 [expr $STUCKAT_PERIOD / 2] "

# Scan shift clocks - 200 MHz
set SHIFT_PERIOD         [expr $BTI_scalar * 5.000]
set SHIFT_WAVEFORM       " 0.0 [expr $SHIFT_PERIOD / 2] "

set BTI_scalar            1
puts "INFO: set BTI_scalar"
# 100 MHz
set CLK100_PERIOD       [expr $BTI_scalar * 10.000]
set CLK100_WAVEFORM     " 0.0 [expr $CLK100_PERIOD / 2] "
set CLK100_INV_WAVEFORM " [expr $CLK100_PERIOD / 2] $CLK100_PERIOD "

# 2.00 GHz
#set CLK2000_PERIOD     2.000
set CLK2000_PERIOD     [expr $BTI_scalar * 0.500]
set CLK2000_WAVEFORM   " 0.0 [expr $CLK2000_PERIOD / 2] "

# 1.00 GHz
#set CLK1000_PERIOD     1.000
set CLK1000_PERIOD      [expr $BTI_scalar * 1.000]
set CLK1000_WAVEFORM   " 0.0 [expr $CLK1000_PERIOD / 2] "

# 1.03125 GHz
#set CLK1031P25_PERIOD     0.9697
set CLK1031P25_PERIOD    [expr $BTI_scalar *  0.9697]
set CLK1031P25_WAVEFORM   " 0.0 [expr $CLK1031P25_PERIOD / 2] "

# 62.5 MHz
#set CLK62P5_PERIOD       16.000
set CLK62P5_PERIOD       [expr $BTI_scalar *  16.000]
set CLK62P5_WAVEFORM     " 0.0 [expr $CLK62P5_PERIOD / 2] "

# 270 MHz
#set CLK270_PERIOD       3.700
set CLK270_PERIOD       [expr $BTI_scalar *  3.700]
set CLK270_WAVEFORM     " 0.0 [expr $CLK270_PERIOD / 2] "

# 625 MHz
#set CLK625_PERIOD    1.600
set CLK625_PERIOD    [expr $BTI_scalar *  1.600]
set CLK625_WAVEFORM  " 0.0 [expr $CLK625_PERIOD / 2] "

# 644P53 MHz for USXGMII and 10GKr datarates
##set CLK644P53_PERIOD    1.552
set CLK644P53_PERIOD    [expr $BTI_scalar * 1.552]
set CLK644P53_WAVEFORM  " 0.0 [expr $CLK644P53_PERIOD / 2] "

# 500 MHz
#set CLK500_PERIOD       2.000
set CLK500_PERIOD       [expr $BTI_scalar *  2.000]
set CLK500_WAVEFORM     " 0.0 [expr $CLK500_PERIOD / 2] "

# 515.625 MHz
#set CLK515P625_PERIOD       1.940
set CLK515P625_PERIOD       [expr $BTI_scalar * 1.940]
set CLK515P625_WAVEFORM     " 0.0 [expr $CLK515P625_PERIOD / 2] "

# 525 MHz
set CLK525_PERIOD            [expr $BTI_scalar * 1.90]
set CLK525_WAVEFORM          " 0.0 [expr $CLK525_PERIOD / 2 ]"

# 250 MHz
#set CLK250_PERIOD       4.000
set CLK250_PERIOD       [expr $BTI_scalar * 4.000]
set CLK250_WAVEFORM     " 0.0 [expr $CLK250_PERIOD / 2] "

# 125 MHz
#set CLK125_PERIOD       8.000
set CLK125_PERIOD        [expr $BTI_scalar * 8.000]
set CLK125_WAVEFORM     " 0.0 [expr $CLK125_PERIOD / 2] "

# 135 MHz
#set CLK135_PERIOD       7.400
set CLK135_PERIOD       [expr $BTI_scalar * 7.400]
set CLK135_WAVEFORM     " 0.0 [expr $CLK135_PERIOD / 2] "

# 156.25 MHz
#set CLK156P25_PERIOD       6.400
set CLK156P25_PERIOD       [expr $BTI_scalar * 6.400]
set CLK156P25_WAVEFORM     " 0.0 [expr $CLK156P25_PERIOD / 2] "

# 200 MHz
#set CLK200_PERIOD       5.000
set CLK200_PERIOD       [expr $BTI_scalar * 5.000]
set CLK200_WAVEFORM     " 0.0 [expr $CLK200_PERIOD / 2] "

# 333 MHz
#set CLK333_PERIOD       3.000
set CLK333_PERIOD      [expr $BTI_scalar * 3.000]
set CLK333_WAVEFORM     " 0.0 [expr $CLK333_PERIOD / 2] "

# 350 MHz
#set CLK350_PERIOD       2.858
set CLK350_PERIOD       [expr $BTI_scalar * 2.858]
set CLK350_WAVEFORM     " 0.0 [expr $CLK350_PERIOD / 2] "

####NEED TO UPDATE FOR WHISTLER
# 2017.01.20_N16FFC_v1.0_Sign-off_Recommendation.pdf slide 7 Vnom=0.8V : SSGNP/0.72V/-40C
set max_trans     0.200
set max_clk_trans 0.100


# Hold value between data_sync and reset_sync flops = 0 ps + DPT 3ps
# Modify hold margin to 29ps + 3ps DPT = 32ps
set setup_margin  0.125
set hold_margin   0.005
set mtbf_margin   0.003

#
# Margins to account for incoming clock skew that may exist at the SOC level.
# Need a minimum of 100 ps.
#

# PSM input clocks (cmn_psm_clk_in and xcvr_psm_clk_ln_*).
# This is for functional and scan capture modes.
set psmclk_skew   0.205

# tx_td_clk_ln_* input clocks.
# This is for functional and scan capture modes.
set txtdclk_skew  0.205



###############################################################################
# Ports
###############################################################################
set top_port_list               [list \
                                     lane_addr_ln0[*] \
                                     lane_addr_ln1[*] \
                                     lane_addr_tie_high_ln0 \
                                     lane_addr_tie_high_ln1 \
                                     lane_addr_tie_low_ln0 \
                                     lane_addr_tie_low_ln1 \
                                     tx_bist_hold_ln0 \
                                     tx_bist_hold_ln1 \
                                     tx_bscan_ac_ln0 \
                                     tx_bscan_ac_ln1 \
                                     tx_bscan_acpulse_ln0 \
                                     tx_bscan_acpulse_ln1 \
                                     tx_bscan_clockdr_ln0 \
                                     tx_bscan_clockdr_ln1 \
                                     tx_bscan_mode_c_ln0 \
                                     tx_bscan_mode_c_ln1 \
                                     tx_bscan_shiftdr_ln0 \
                                     tx_bscan_shiftdr_ln1 \
                                     tx_bscan_tdi_ln0 \
                                     tx_bscan_tdi_ln1 \
                                     tx_bscan_tdo_ln0 \
                                     tx_bscan_tdo_ln1 \
                                     tx_bscan_updatedr_ln0 \
                                     tx_bscan_updatedr_ln1 \
                                     tx_cmn_mode_en_ext_ln0 \
                                     tx_cmn_mode_en_ext_ln1 \
                                     tx_deemphasis_ln0[*] \
                                     tx_deemphasis_ln1[*] \
                                     tx_differential_invert_ln0 \
                                     tx_differential_invert_ln1 \
                                     tx_elec_idle_ln0 \
                                     tx_elec_idle_ln1 \
                                     tx_get_local_preset_coef_ln0 \
                                     tx_get_local_preset_coef_ln1 \
                                     tx_get_local_init_coef_ln0 \
                                     tx_get_local_init_coef_ln1 \
                                     tx_local_fs_ln0[*] \
                                     tx_local_fs_ln1[*] \
                                     tx_local_lf_ln0[*] \
                                     tx_local_lf_ln1[*] \
                                     tx_local_preset_index_ln0[*] \
                                     tx_local_preset_index_ln1[*] \
                                     tx_local_tx_coef_valid_ln0 \
                                     tx_local_tx_coef_valid_ln1 \
                                     tx_local_tx_preset_coef_ln0[*] \
                                     tx_local_tx_preset_coef_ln1[*] \
                                     tx_low_power_swing_en_ln0 \
                                     tx_low_power_swing_en_ln1 \
                                     tx_rcv_detect_done_ln0 \
                                     tx_rcv_detect_done_ln1 \
                                     tx_rcv_detected_ln0 \
                                     tx_rcv_detected_ln1 \
                                     tx_rcv_detect_en_ln0 \
                                     tx_rcv_detect_en_ln1 \
                                     tx_reset_n_ln0 \
                                     tx_reset_n_ln1 \
                                     rx_reset_n_ln0 \
                                     rx_reset_n_ln1 \
                                     tx_sfifo_align_bump_in_ln0 \
                                     tx_sfifo_align_bump_in_ln1 \
                                     tx_sfifo_align_bump_out_ln0 \
                                     tx_sfifo_align_bump_out_ln1 \
                                     tx_sfifo_enq_reset_n_in_ln0 \
                                     tx_sfifo_enq_reset_n_in_ln1 \
                                     tx_sfifo_enq_reset_n_out_ln0 \
                                     tx_sfifo_enq_reset_n_out_ln1 \
                                     tx_td_ln0[*] \
                                     tx_td_ln1[*] \
                                     tx_td_clk_ln0 \
                                     tx_td_clk_ln1 \
                                     tx_vmargin_ln0[*] \
                                     tx_vmargin_ln1[*] \
                                     tx_lfps_en_ln0 \
                                     tx_lfps_en_ln1 \
                                     tx_lfps_mode_ln0 \
                                     tx_lfps_mode_ln1 \
                                     xcvr_bscan_cfg_ln0[*] \
                                     xcvr_bscan_cfg_ln1[*] \
                                     xcvr_bscan_mode_en_ln0 \
                                     xcvr_bscan_mode_en_ln1 \
                                     xcvr_cdb_paddr_ln0[*] \
                                     xcvr_cdb_paddr_ln1[*] \
                                     xcvr_cdb_pclk_ln0 \
                                     xcvr_cdb_pclk_ln1 \
                                     xcvr_cdb_preset_n_ln0 \
                                     xcvr_cdb_preset_n_ln1 \
                                     xcvr_cdb_penable_ln0 \
                                     xcvr_cdb_penable_ln1 \
                                     xcvr_cdb_prdata_ln0[*] \
                                     xcvr_cdb_prdata_ln1[*] \
                                     xcvr_cdb_pready_ln0 \
                                     xcvr_cdb_pready_ln1 \
                                     xcvr_cdb_psel_tx_ln0 \
                                     xcvr_cdb_psel_tx_ln1 \
                                     xcvr_cdb_psel_rx_ln0 \
                                     xcvr_cdb_psel_rx_ln1 \
                                     xcvr_cdb_pwrite_ln0 \
                                     xcvr_cdb_pwrite_ln1 \
                                     xcvr_cdb_pwdata_ln0[*] \
                                     xcvr_cdb_pwdata_ln1[*] \
                                     xcvr_data_width_ln0[*] \
                                     xcvr_data_width_ln1[*] \
                                     xcvr_lane_suspend_ln0 \
                                     xcvr_lane_suspend_ln1 \
                                     xcvr_link_reset_n_ln0 \
                                     xcvr_link_reset_n_ln1 \
                                     xcvr_lnr_ln0 \
                                     xcvr_lnr_ln1 \
                                     xcvr_lpbk_fe_parallel_en_ln0 \
                                     xcvr_lpbk_fe_parallel_en_ln1 \
                                     xcvr_lpbk_ne_parallel_en_ln0 \
                                     xcvr_lpbk_ne_parallel_en_ln1 \
                                     xcvr_lpbk_line_en_ln0 \
                                     xcvr_lpbk_line_en_ln1 \
                                     xcvr_lpbk_isi_gen_en_ln0 \
                                     xcvr_lpbk_isi_gen_en_ln1 \
                                     xcvr_lpbk_recovered_clk_en_ln0 \
                                     xcvr_lpbk_recovered_clk_en_ln1 \
                                     xcvr_lpbk_serial_en_ln0 \
                                     xcvr_lpbk_serial_en_ln1 \
                                     xcvr_pll_clk_datart_ln0 \
                                     xcvr_pll_clk_datart_ln1 \
                                     xcvr_pll_clk_en_ln0 \
                                     xcvr_pll_clk_en_ln1 \
                                     xcvr_pll_clk_en_ack_ln0 \
                                     xcvr_pll_clk_en_ack_ln1 \
                                     xcvr_pll_clk_fullrt_ln0 \
                                     xcvr_pll_clk_fullrt_ln1 \
                                     xcvr_power_state_ack_ln0[*] \
                                     xcvr_power_state_ack_ln1[*] \
                                     xcvr_power_state_req_ln0[*] \
                                     xcvr_power_state_req_ln1[*] \
                                     xcvr_psm_clk_ln0 \
                                     xcvr_psm_clk_ln1 \
                                     xcvr_psm_ready_ln0 \
                                     xcvr_psm_ready_ln1 \
                                     xcvr_psm_state_ln0[*] \
                                     xcvr_psm_state_ln1[*] \
                                     xcvr_scanclk_pll_clk_ln0 \
                                     xcvr_scanclk_pll_clk_ln1 \
                                     xcvr_scanclk_ser_clk_ln0 \
                                     xcvr_scanclk_ser_clk_ln1 \
                                     xcvr_scanen_ln0 \
                                     xcvr_scanen_ln1 \
                                     xcvr_scanen_cg_ln0 \
                                     xcvr_scanen_cg_ln1 \
                                     xcvr_scanin_ln0[*] \
                                     xcvr_scanin_ln1[*] \
                                     xcvr_scanmode_ln0 \
                                     xcvr_scanmode_ln1 \
                                     xcvr_scanout_ln0[*] \
                                     xcvr_scanout_ln1[*] \
                                     xcvr_standard_mode_ln0[*] \
                                     xcvr_standard_mode_ln1[*] \
                                     rx_sig_det_en_ext_ln0 \
                                     rx_sig_det_en_ext_ln1 \
                                     xcvr_in_obs_tie_high_ln0[*] \
                                     xcvr_in_obs_tie_high_ln1[*] \
                                     xcvr_in_obs_tie_low_ln0[*] \
                                     xcvr_in_obs_tie_low_ln1[*] \
                                     xcvr_in_ibs_tie_high_ln0[*] \
                                     xcvr_in_ibs_tie_high_ln1[*] \
                                     xcvr_in_ibs_tie_low_ln0[*] \
                                     xcvr_in_ibs_tie_low_ln1[*] \
                                    ]

set analog_port_list            [list \
                                     tx_p_ln0 \
                                     tx_m_ln0 \
                                     tx_p_ln1 \
                                     tx_m_ln1 \
                                     ana_atb_0 \
                                     ana_atb_1 \
                                     ana_clk_0_p_in \
                                     ana_clk_0_m_in \
                                     ana_clk_1_p_in \
                                     ana_clk_1_m_in \
                                     ana_clk_0_p_out \
                                     ana_clk_0_m_out \
                                     ana_clk_1_p_out \
                                     ana_clk_1_m_out \
                                     ana_sd_clk_in \
                                     ana_sd_clk_out \
                                     ana_tx_clk_rst_rel_in \
                                     ana_tx_clk_rst_rel_out \
                                     iext_txm_clkdist_fromn_50u[*] \
                                    ]

set power_ground_port_list      [list \
                                     agnd \
                                     avdd \
                                     avdd_clk \
                                     avdd_tx0 \
                                     avdd_tx1 \
                                    ]

set tie_port_list               [list \
                                     lane_addr_tie_high_ln0 \
                                     lane_addr_tie_high_ln1 \
                                     lane_addr_tie_low_ln0 \
                                     lane_addr_tie_low_ln1 \
                                     xcvr_in_ibs_tie_high_ln0[0] \
                                     xcvr_in_ibs_tie_high_ln0[1] \
                                     xcvr_in_ibs_tie_high_ln1[0] \
                                     xcvr_in_ibs_tie_high_ln1[1] \
                                     xcvr_in_ibs_tie_low_ln0[0] \
                                     xcvr_in_ibs_tie_low_ln0[1] \
                                     xcvr_in_ibs_tie_low_ln0[2] \
                                     xcvr_in_ibs_tie_low_ln0[3] \
                                     xcvr_in_ibs_tie_low_ln0[4] \
                                     xcvr_in_ibs_tie_low_ln0[5] \
                                     xcvr_in_ibs_tie_low_ln1[0] \
                                     xcvr_in_ibs_tie_low_ln1[1] \
                                     xcvr_in_ibs_tie_low_ln1[2] \
                                     xcvr_in_ibs_tie_low_ln1[3] \
                                     xcvr_in_ibs_tie_low_ln1[4] \
                                     xcvr_in_ibs_tie_low_ln1[5] \
                                     xcvr_in_obs_tie_high_ln0[0] \
                                     xcvr_in_obs_tie_high_ln0[1] \
                                     xcvr_in_obs_tie_high_ln1[0] \
                                     xcvr_in_obs_tie_high_ln1[1] \
                                     xcvr_in_obs_tie_low_ln0[0] \
                                     xcvr_in_obs_tie_low_ln0[1] \
                                     xcvr_in_obs_tie_low_ln0[2] \
                                     xcvr_in_obs_tie_low_ln0[3] \
                                     xcvr_in_obs_tie_low_ln0[4] \
                                     xcvr_in_obs_tie_low_ln0[5] \
                                     xcvr_in_obs_tie_low_ln0[6] \
                                     xcvr_in_obs_tie_low_ln0[7] \
                                     xcvr_in_obs_tie_low_ln0[8] \
                                     xcvr_in_obs_tie_low_ln0[9] \
                                     xcvr_in_obs_tie_low_ln0[10] \
                                     xcvr_in_obs_tie_low_ln0[11] \
                                     xcvr_in_obs_tie_low_ln0[12] \
                                     xcvr_in_obs_tie_low_ln0[13] \
                                     xcvr_in_obs_tie_low_ln1[0] \
                                     xcvr_in_obs_tie_low_ln1[1] \
                                     xcvr_in_obs_tie_low_ln1[2] \
                                     xcvr_in_obs_tie_low_ln1[3] \
                                     xcvr_in_obs_tie_low_ln1[4] \
                                     xcvr_in_obs_tie_low_ln1[5] \
                                     xcvr_in_obs_tie_low_ln1[6] \
                                     xcvr_in_obs_tie_low_ln1[7] \
                                     xcvr_in_obs_tie_low_ln1[8] \
                                     xcvr_in_obs_tie_low_ln1[9] \
                                     xcvr_in_obs_tie_low_ln1[10] \
                                     xcvr_in_obs_tie_low_ln1[11] \
                                     xcvr_in_obs_tie_low_ln1[12] \
                                     xcvr_in_obs_tie_low_ln1[13] \
                                    ]

set clock_input_port_list       [list \
                                     xcvr_psm_clk_ln0 \
                                     xcvr_psm_clk_ln1 \
                                     xcvr_cdb_pclk_ln0 \
                                     xcvr_cdb_pclk_ln1 \
                                     tx_td_clk_ln0 \
                                     tx_td_clk_ln1 \
                                     xcvr_scanclk_ser_clk_ln0 \
                                     xcvr_scanclk_ser_clk_ln1 \
                                     xcvr_scanclk_pll_clk_ln0 \
                                     xcvr_scanclk_pll_clk_ln1 \
                                     tx_bscan_clockdr_ln0 \
                                     tx_bscan_clockdr_ln1 \
                                     tx_bscan_updatedr_ln0 \
                                     tx_bscan_updatedr_ln1 \
                                     cmn_ref_clk_gated_in_ln0 \
                                     cmn_ref_clk_gated_in_ln1 \
                                     cmn_scanclk_ref_clk_in_ln0 \
                                     cmn_scanclk_ref_clk_in_ln1 \
                                     cmn_pll0_clk_0_scanned_in_ln0 \
                                     cmn_pll0_clk_0_scanned_in_ln1 \
                                     cmn_pll0_clk_1_scanned_in_ln0 \
                                     cmn_pll0_clk_1_scanned_in_ln1 \
                                     cmn_pll1_clk_0_scanned_in_ln0 \
                                     cmn_pll1_clk_0_scanned_in_ln1 \
                                     cmn_pll1_clk_1_scanned_in_ln0 \
                                     cmn_pll1_clk_1_scanned_in_ln1 \
                                    ]

set clock_output_port_list      [list \
                                     xcvr_pll_clk_datart_ln0 \
                                     xcvr_pll_clk_datart_ln1 \
                                     xcvr_pll_clk_fullrt_ln0 \
                                     xcvr_pll_clk_fullrt_ln1 \
                                     cmn_ref_clk_gated_out_ln0 \
                                     cmn_ref_clk_gated_out_ln1 \
                                     cmn_scanclk_ref_clk_out_ln0 \
                                     cmn_scanclk_ref_clk_out_ln1 \
                                     cmn_pll0_clk_0_scanned_out_ln0 \
                                     cmn_pll0_clk_0_scanned_out_ln1 \
                                     cmn_pll0_clk_1_scanned_out_ln0 \
                                     cmn_pll0_clk_1_scanned_out_ln1 \
                                     cmn_pll1_clk_0_scanned_out_ln0 \
                                     cmn_pll1_clk_0_scanned_out_ln1 \
                                     cmn_pll1_clk_1_scanned_out_ln0 \
                                     cmn_pll1_clk_1_scanned_out_ln1 \
                                    ]

set top_input_port_collection       [remove_from_collection [get_ports $top_port_list] [all_outputs]]
set top_output_port_collection      [remove_from_collection [get_ports $top_port_list] [all_inputs]]
set analog_port_collection          [add_to_collection [get_ports $analog_port_list] [get_ports $power_ground_port_list]]
set digital_input_port_collection   [remove_from_collection [all_inputs]  $analog_port_collection]
set digital_output_port_collection  [remove_from_collection [all_outputs] $analog_port_collection]
set clock_input_port_collection     [get_ports $clock_input_port_list]
set clock_output_port_collection    [get_ports $clock_output_port_list]
set data_input_port_collection      [remove_from_collection $digital_input_port_collection  $clock_input_port_collection]
set data_output_port_collection     [remove_from_collection $digital_output_port_collection $clock_output_port_collection]

if { ![info exists DRIVING_CELL] } {
    puts "INFO: setting DRIVING_CELL definition"
    set DRIVING_CELL  BUFFMZD4BWP210H6P51CNODSVT
}

if { ![info exists DRIVING_PIN] } {
    puts "INFO: setting DRIVING_PIN definition"
    set DRIVING_PIN Z
}

# if { ![info exists ::DRIVING_CELL] } {
#    set ::DRIVING_CELL [get_lib_cells BUFFD4BWP*DSVT]
#    set ::DRIVING_PIN Z
#    puts "INFO: setting DRIVING_CELL = [get_property $::DRIVING_CELL name]"
# }

# Analog lib interface pins to small digital blocks in xcvr
# For TX-only module (txm_ana instead of rxtxm_ana)
set xcvr_ana_cell_collection  [get_cells -hier -filter {ref_lib_cell_name == txm_ana}]

# TX driver pins (TX-only, no RX CDR or DFE)
set xcvr_ana_drv_func_pins  [get_pins -of $xcvr_ana_cell_collection \
                                 -filter {ref_lib_pin_name =~ "txda*_drv*" && ref_lib_pin_name !~ "txda*_drv_scan*"}]
set xcvr_ana_drv_scan_pins  [get_pins -of $xcvr_ana_cell_collection \
                                 -filter {ref_lib_pin_name =~ "txda*_drv_scan*" && ref_lib_pin_name !~ "txda*_drv_scanclk"}]
