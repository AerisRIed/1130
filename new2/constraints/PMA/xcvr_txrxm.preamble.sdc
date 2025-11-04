##############################################################################
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
# Filename    : cmn.preamble.tcl
# Author(s)   : Dave Masters and Elsa Delacruz
# Abstract    : Preabmle constraint file for Torrent XCVR.
# Last Commit:
#
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

if { ![info exists timeMode] } {
    puts "INFO: setting timeMode to ideal"
    set timeMode ideal
}

if { ![info exists ctsMode] } {
    puts "INFO: setting ctsMode to 0"
    set ctsMode 0
}

if { ![info exists fp_hold_to_mtbf_flops] } {
    puts "INFO: setting fp_hold_to_mtbf_flops to 0"
    set fp_hold_to_mtbf_flops 0
}

if { ![info exists do_display]   } { set do_display 1 }
if { ![info exists do_pcie_gen3] } { set do_pcie_gen3 1 }
if { ![info exists do_pcie_gen2] } { set do_pcie_gen2 1 }
if { ![info exists do_pcie_gen1] } { set do_pcie_gen1 1 }
if { ![info exists do_usb30]     } { set do_usb30 1 }
if { ![info exists do_usb30_gen2]} { set do_usb30_gen2 1 }
#if { ![info exists do_10gkr]     } { set do_10gkr 1 }
#if { ![info exists do_gbe]       } { set do_gbe 1 }
if { ![info exists do_usb4]      } { set do_usb4 1 }

#set mode_list {}
if { $do_display }   { puts "INFO: standard set to JEDS SRIO DP mode" }
if { $do_pcie_gen3 } { puts "INFO: standard set to PCIe Gen3 mode" }
if { $do_pcie_gen2 } { puts "INFO: standard set to PCIe Gen2 mode" }
if { $do_pcie_gen1 } { puts "INFO: standard set to PCIe Gen1 mode" }
if { $do_usb30     } { puts "INFO: standard set to USB 3.0 mode" }
if { $do_usb30_gen2 } { puts "INFO: standard set to USB 3.0/3.1 Gen2 mode" }
#if { $do_10gkr     } { puts "INFO: standard set to 10GKR mode" }
#if { $do_gbe       } { puts "INFO: standard set to 1G Ethernet mode" }
if { $do_usb4      } { puts "INFO: standard set to USB 4 mode" }


# Synthesis (pre-mapped) update to DTC cell pin
    set scan_mux_pin           "u_scan_mux_synth/u_dont_touch_scan_mux/I0"
    set clk_mux_I0_pin         "*u_clock_mux_synth/*u_dont_touch_ck_mux/I0"
    set clk_mux_I1_pin         "*u_clock_mux_synth/*u_dont_touch_ck_mux/I1"
    set clk_mux_Z_pin          "*u_clock_mux_synth/*u_dont_touch_ck_mux/Z"
    set rx_rd_fe_lpbk_clk_pin  "u_clk_gating_and_rx_rd_fe_lpbk_clk/u_clk_gating_and_synth/u_dont_touch_ck_and/Z"
    set tx_td_ne_lpbk_clk_pin  "u_clk_gating_and_tx_td_ne_lpbk_clk/u_clk_gating_and_synth/u_dont_touch_ck_and/Z"


#if { $load_syn_sdc && !$load_post_map_syn_sdc } {
#    set scan_mux_pin            "fcn_signal_in"
#    set clk_mux0_pin_0          "clk_in[0]"
#    set clk_mux0_pin_1          "clk_in[1]"
#    set clk_mux0_I0_pin         "clk_in[0]"
#    set clk_mux0_I1_pin         "clk_in[1]"
#    set clk_mux0_Z_pin          "clk_out"
#    set clk_mux1_I0_pin         "clk_in[0]"
#    set clk_mux1_I1_pin         "clk_in[1]"
#    set cm_clk_mux_Z_pin        "clk_out"
#    set rx_rd_fe_lpbk_clk_pin   "rx_rd_fe_lpbk_clk"
#    set tx_td_ne_lpbk_clk_pin   "tx_td_ne_lpbk_clk"
#
# Synthesis (post-mapped) or P&R
#} else {
#    set clk_mux1_I0_pin         "RC_i_1/I0"
#    set clk_mux1_I1_pin         "RC_i_1/I1"
#    set clk_mux1_Z_pin          "RC_i_1/Z"
#    set cm_clk_mux_Z_pin        "u_clock_mux1/Z"
#    set rx_rd_fe_lpbk_clk_pin   "u_clk_gating_and_rx_rd_fe_lpbk_clk/u_clk_gating_and_synth/u_dont_touch_ck_and/Z"
#    set tx_td_ne_lpbk_clk_pin   "u_clk_gating_and_tx_td_ne_lpbk_clk/u_clk_gating_and_synth/u_dont_touch_ck_and/Z"
#}


###############################################################################
# Clock period, waveform, and uncertainty variable settings.
###############################################################################
# Setup period scaling ability for BTI and Asymmetric aging as a period multiplier
# Initially update to 0.955 per DDR sims that resulted in a bound of 4.5%
# Update to 0.945 based upon HPP sim results from James
## SG commeneted after confirmation grom Dave. Not required 5nm and below.
set BTI_scalar            0.955

#add 
if { [info exists load_syn_sdc] && $load_syn_sdc == "0" } {
   set TOOL_scalar           1
} else {
   set TOOL_scalar           0.700
}
set ALL_scalar [expr $TOOL_scalar * $BTI_scalar]

puts "INFO: set ALL_scalar"
# 100 MHz
set CLK100_PERIOD       [expr $ALL_scalar * 10.000]
set CLK100_WAVEFORM     " 0.0 [expr $CLK100_PERIOD / 2] "
set CLK100_INV_WAVEFORM " [expr $CLK100_PERIOD / 2] $CLK100_PERIOD "

# 2.00 GHz
#set CLK2000_PERIOD     2.000
set CLK2000_PERIOD     [expr $ALL_scalar * 0.500]
set CLK2000_WAVEFORM   " 0.0 [expr $CLK2000_PERIOD / 2] "

# 1.00 GHz
#set CLK1000_PERIOD     1.000
set CLK1000_PERIOD      [expr $ALL_scalar * 1.000]
set CLK1000_WAVEFORM   " 0.0 [expr $CLK1000_PERIOD / 2] "

# 1.03125 GHz
#set CLK1031P25_PERIOD     0.9697
set CLK1031P25_PERIOD    [expr $ALL_scalar *  0.9697]
set CLK1031P25_WAVEFORM   " 0.0 [expr $CLK1031P25_PERIOD / 2] "

# 1.25 GHz
#set CLK1000_PERIOD     0.800
set CLK1250_PERIOD      [expr $ALL_scalar * 0.800]
set CLK1250_WAVEFORM   " 0.0 [expr $CLK1250_PERIOD / 2] "

# 62.5 MHz
#set CLK62P5_PERIOD       16.000
set CLK62P5_PERIOD       [expr $ALL_scalar *  16.000]
set CLK62P5_WAVEFORM     " 0.0 [expr $CLK62P5_PERIOD / 2] "

# 270 MHz
#set CLK270_PERIOD       3.700
set CLK270_PERIOD       [expr $ALL_scalar *  3.700]
set CLK270_WAVEFORM     " 0.0 [expr $CLK270_PERIOD / 2] "

# 625 MHz
#set CLK625_PERIOD    1.600
set CLK625_PERIOD    [expr $ALL_scalar *  1.600]
set CLK625_WAVEFORM  " 0.0 [expr $CLK625_PERIOD / 2] "

# 644P53 MHz for USXGMII and 10GKr datarates
##set CLK644P53_PERIOD    1.552
set CLK644P53_PERIOD    [expr $ALL_scalar * 1.552]
set CLK644P53_WAVEFORM  " 0.0 [expr $CLK644P53_PERIOD / 2] "

# 500 MHz
#set CLK500_PERIOD       2.000
set CLK500_PERIOD       [expr $ALL_scalar *  2.000]
set CLK500_WAVEFORM     " 0.0 [expr $CLK500_PERIOD / 2] "

# 515.625 MHz
#set CLK515P625_PERIOD       1.940
set CLK515P625_PERIOD       [expr $ALL_scalar * 1.940]
set CLK515P625_WAVEFORM     " 0.0 [expr $CLK515P625_PERIOD / 2] "

# 525 MHz
set CLK525_PERIOD            [expr $ALL_scalar * 1.90]
set CLK525_WAVEFORM          " 0.0 [expr $CLK525_PERIOD / 2 ]"

# 250 MHz
#set CLK250_PERIOD       4.000
set CLK250_PERIOD       [expr $ALL_scalar * 4.000]
set CLK250_WAVEFORM     " 0.0 [expr $CLK250_PERIOD / 2] "

# 125 MHz
#set CLK125_PERIOD       8.000
set CLK125_PERIOD        [expr $ALL_scalar * 8.000]
set CLK125_WAVEFORM     " 0.0 [expr $CLK125_PERIOD / 2] "

# 135 MHz
#set CLK135_PERIOD       7.400
set CLK135_PERIOD       [expr $ALL_scalar * 7.400]
set CLK135_WAVEFORM     " 0.0 [expr $CLK135_PERIOD / 2] "

# 156.25 MHz
#set CLK156P25_PERIOD       6.400
set CLK156P25_PERIOD       [expr $ALL_scalar * 6.400]
set CLK156P25_WAVEFORM     " 0.0 [expr $CLK156P25_PERIOD / 2] "

# 200 MHz
#set CLK200_PERIOD       5.000
set CLK200_PERIOD       [expr $ALL_scalar * 5.000]
set CLK200_WAVEFORM     " 0.0 [expr $CLK200_PERIOD / 2] "

# 333 MHz
#set CLK333_PERIOD       3.000
set CLK333_PERIOD      [expr $ALL_scalar * 3.000]
set CLK333_WAVEFORM     " 0.0 [expr $CLK333_PERIOD / 2] "

# 350 MHz
#set CLK350_PERIOD       2.858
set CLK350_PERIOD       [expr $ALL_scalar * 2.858]
set CLK350_WAVEFORM     " 0.0 [expr $CLK350_PERIOD / 2] "

# Boundary scan - 100 MHz
#set BSCAN_PERIOD         10.000
set BSCAN_PERIOD         [expr $ALL_scalar * 10.000]
set BSCAN_WAVEFORM       " 0.0 [expr $BSCAN_PERIOD / 2] "

# Reset - 100 MHz
#set RESET_PERIOD        19.000
set RESET_PERIOD        [expr $ALL_scalar * 19.000]
set RESET_WAVEFORM      " 0.0 [expr $RESET_PERIOD / 2] "


# For Asynchronous I/Os
set ASYNC_PERIOD        17.000
set ASYNC_WAVEFORM      " 0.0 [expr $ASYNC_PERIOD / 2] "

# Stuck-at scan clocks - 200 MHz
# JMY 20201030 Updates to 200MHz per Mark Taylor's request
#set STUCKAT_PERIOD       5.000
set STUCKAT_PERIOD       [expr $ALL_scalar * 5.000]
set STUCKAT_WAVEFORM     " 0.0 [expr $STUCKAT_PERIOD / 2] "


# SCAN Shift Clocks
#set SHIFTCLK_PERIOD     5.000
set SHIFTCLK_PERIOD     [expr $ALL_scalar * 5.000]
set SHIFTCLK_WAVEFORM   " 0.0 [expr $SHIFTCLK_PERIOD / 2] "

# SCAN Stuckat Clocks
# JMY 20201030 Updates to 200MHz per Mark Taylor's request
#set SCAPCLK_PERIOD      5.000
set SCAPCLK_PERIOD      [expr $ALL_scalar * 5.000]
set SCAPCLK_WAVEFORM    " 0.0 [expr $SCAPCLK_PERIOD / 2] "

#Commenting as tran values taken care in CPD , data : 300,clock :150
# Set max transition value as specified by ARM. Set a tighter value for clocks.
#set max_trans           0.215
#set max_clk_trans       0.150
set max_trans 0.250
set max_clk_trans 0.125

# Setup value = 30 ps + 100 ps jitter
# JMY 20201030 hold_margin can be reduced due to hold margining _hm libs being used
# JMY 20201106 Update to 75ps setup uncertainty
#    Assume 20ps PLL jitter + 25ps clock tree jitter + 30ps margin
set setup_margin        0.125
set hold_margin         0.005
set mtbf_margin         0.003


###############################################################################
# Ports
###############################################################################
set top_port_list               [list \
                                    lane_addr[*] \
                                    lane_addr_tie_high \
                                    lane_addr_tie_low \
                                    rx_bist_err_toggle \
                                    rx_bist_status \
                                    rx_bist_sync \
                                    rx_bscan_ac \
                                    rx_bscan_clockdr \
                                    rx_bscan_pc \
                                    rx_bscan_shiftdr \
                                    rx_bscan_tdi \
                                    rx_bscan_tdo \
                                    rx_cdrlf_fphl_locked \
                                    rx_differential_invert \
                                    rx_eye_plot_pi_val[*] \
                                    rx_pi_val[*] \
                                    rx_rd[*] \
                                    rx_rd_clk \
                                    rx_reset_n \
                                    rx_sampler_latch_cal_diag[*] \
                                    rx_sig_det_en_ext \
                                    rx_signal_detect \
                                    rx_termination \
                                    tx_bist_hold \
                                    tx_bscan_ac \
                                    tx_bscan_acpulse \
                                    tx_bscan_clockdr \
                                    tx_bscan_mode_c \
                                    tx_bscan_shiftdr \
                                    tx_bscan_tdi \
                                    tx_bscan_tdo \
                                    tx_bscan_updatedr \
                                    tx_cmn_mode_en_ext \
                                    tx_deemphasis[*] \
                                    tx_differential_invert \
                                    tx_elec_idle \
                                    tx_low_power_swing_en \
                                    tx_rcv_detect_done \
                                    tx_rcv_detected \
                                    tx_rcv_detect_en \
                                    tx_reset_n \
                                    tx_sfifo_align_bump_in \
                                    tx_sfifo_align_bump_out \
                                    tx_sfifo_enq_reset_n_in \
                                    tx_sfifo_enq_reset_n_out \
                                    tx_td[*] \
                                    tx_td_clk \
                                    tx_vmargin[*] \
                                    xcvr_bscan_mode_en \
				    xcvr_bscan_cfg[*] \
                                    xcvr_data_width[*] \
                                    xcvr_lane_suspend \
                                    xcvr_link_reset_n \
                                    xcvr_lnr \
                                    xcvr_lpbk_fe_parallel_en \
                                    xcvr_lpbk_isi_gen_en \
                                    xcvr_lpbk_line_en \
                                    xcvr_lpbk_ne_parallel_en \
                                    xcvr_lpbk_recovered_clk_en \
                                    xcvr_lpbk_serial_en \
                                    xcvr_pll_clk_datart \
                                    xcvr_pll_clk_en \
                                    xcvr_pll_clk_en_ack \
                                    xcvr_pll_clk_fullrt \
                                    xcvr_power_state_ack[*] \
                                    xcvr_power_state_req[*] \
                                    xcvr_psm_clk \
                                    xcvr_psm_ready \
                                    xcvr_psm_state[*] \
                                    xcvr_psm_state[*] \
                                    xcvr_scanclk_pll_clk \
                                    xcvr_scanclk_ser_clk \
                                    xcvr_scanen \
                                    xcvr_scanen_cg \
                                    xcvr_scanin[*] \
                                    xcvr_scanmode \
                                    xcvr_scanout[*] \
                                    xcvr_standard_mode[*] \
                                ]

set analog_port_list            [list \
                                    ana_atb_0 \
                                    ana_atb_1 \
                                    ana_rxtxm_data_m \
                                    ana_rxtxm_data_p \
                                    ana_clkn_0_in    \
                                    ana_clkp_0_in    \
                                    ana_clkn_1_in                   \
                                    ana_clkp_1_in                   \
                                    ana_clkn_0_out                  \
                                    ana_clkp_0_out                  \
                                    ana_clkn_1_out                  \
                                    ana_clkp_1_out                  \
                                    ana_ls_en_h_n                   \
                                    ana_recovered_clk_lpbk_in       \
                                    ana_recovered_clk_lpbk_n_in     \
                                    ana_sd_clk_in                   \
                                    ana_tx_clk_rst_rel_in           \
                                    ana_recovered_clk_lpbk          \
                                    ana_recovered_clk_lpbk_n        \
                                    ana_sd_clk_out                  \
                                    ana_tx_clk_rst_rel_out          \
                                    ibg_rxafe_fromp_12p5u_h         \
                                    ibg_rxtxm_sd_fromp_25u_h        \
                                    iext_rxtxm_clkdist_fromn_50u*   \
                                    iext_rxtxm_clkdist_fromp_50u    \
                                    iext_rxtxm_fromn_25u            \
                                    ipoly_rxafe_fromp_25u           \
                                    ipoly_rxtxm_fromn_25u           \
                                    iptat_rxafe_fromp_12p5u_h       \
                                ]


set power_ground_port_list      [list \
                                    agnd \
                                    avdd \
                                    avdd_clk \
                                    avdd_h \
                                    avdd_rx \
                                    avdd_tx \
                                ]

set tie_port_list               [list \
                                    lane_addr_tie_high \
                                    lane_addr_tie_low \
                                    xcvr_in_ibs_tie_high[0] \
                                    xcvr_in_ibs_tie_high[1] \
                                    xcvr_in_ibs_tie_low[0] \
                                    xcvr_in_ibs_tie_low[1] \
                                    xcvr_in_ibs_tie_low[2] \
                                    xcvr_in_ibs_tie_low[3] \
                                    xcvr_in_ibs_tie_low[4] \
                                    xcvr_in_ibs_tie_low[5] \
                                    xcvr_in_obs_tie_high[0] \
                                    xcvr_in_obs_tie_high[1] \
                                    xcvr_in_obs_tie_low[0] \
                                    xcvr_in_obs_tie_low[1] \
                                    xcvr_in_obs_tie_low[2] \
                                    xcvr_in_obs_tie_low[3] \
                                    xcvr_in_obs_tie_low[4] \
                                    xcvr_in_obs_tie_low[5] \
                                    xcvr_in_obs_tie_low[6] \
                                    xcvr_in_obs_tie_low[7] \
                                    xcvr_in_obs_tie_low[8] \
                                    xcvr_in_obs_tie_low[9] \
                                    xcvr_in_obs_tie_low[10] \
                                    xcvr_in_obs_tie_low[11] \
                                    xcvr_in_obs_tie_low[12] \
                                    xcvr_in_obs_tie_low[13] \
                                ]

set clock_input_port_list       [list \
                                    xcvr_cdb_pclk \
                                    cmn_ref_clk_gated_in \
                                    cmn_pll0_clk_0_scanned_in \
                                    cmn_pll0_clk_1_scanned_in \
                                    cmn_pll1_clk_0_scanned_in \
                                    cmn_pll1_clk_1_scanned_in \
                                    cmn_scanclk_ref_clk_in \
                                    rx_bscan_clockdr \
                                    rx_bscan_pc \
                                    tx_bscan_clockdr \
                                    tx_bscan_updatedr \
                                    tx_td_clk \
                                    xcvr_psm_clk \
                                    xcvr_scanclk_pll_clk \
                                    xcvr_scanclk_ser_clk \
                                ]

set clock_output_port_list      [list \
                                    cmn_ref_clk_gated_out \
                                    cmn_pll0_clk_0_scanned_out \
                                    cmn_pll0_clk_1_scanned_out \
                                    cmn_pll1_clk_0_scanned_out \
                                    cmn_pll1_clk_1_scanned_out \
                                    cmn_scanclk_ref_clk_out \
                                    rx_rd_clk \
                                    xcvr_pll_clk_datart \
                                    xcvr_pll_clk_fullrt \
                                ]

set async_input_port_list       [list \
				    tx_get_local_init_coef \
                                    xcvr_lpbk_serial_en \
                                    xcvr_lpbk_fe_parallel_en \
                                    xcvr_lpbk_ne_parallel_en \
                                    xcvr_lpbk_line_en \
                                    xcvr_lpbk_isi_gen_en \
                                    xcvr_lpbk_recovered_clk_en \
                                    tx_rcv_detect_en \
                                    tx_deemphasis[*] \
                                    tx_vmargin[*] \
                                    tx_low_power_swing_en \
                                    tx_differential_invert \
                                    rx_termination \
                                    rx_differential_invert \
                                    lane_addr[*] \
                                    xcvr_scanin[*] \
                                    xcvr_scanmode \
                                    xcvr_scanen \
                                    xcvr_scanen_cg \
                                    tx_bscan_mode_c \
                                    tx_bscan_acpulse \
                                    tx_bscan_ac \
                                    tx_bscan_shiftdr \
                                    rx_bscan_ac \
                                    rx_bscan_shiftdr \
                                    tx_cmn_mode_en_ext \
                                    xcvr_data_width[*] \
                                    cmn_atb_en_in \
                                    cmn_atb_sel_in \
                                    cmn_reset_n_in \
                                    xcvr_cdb_preset_n \
                                    cmn_reset_sync_n_in \
                                    rx_sig_det_en_ext \
                                    rx_rescal_code_in[*] \
                                    xcvr_standard_mode[*] \
                                    xcvr_cdb_pready \
                                    xcvr_scanin[*] \
                                ]

set async_output_port_list      [list \
                                    xcvr_cdb_preset_n\
                                    xcvr_cdb_prdata[*]\
                                    cmn_reset_n_out\
                                    cmn_reset_sync_n_out\
                                    rx_signal_detect \
                                    rx_pi_val[*] \
                                    rx_eye_plot_pi_val[*] \
                                    xcvr_in_obs_tie_high[*] \
                                    xcvr_in_obs_tie_low[*] \
                                    xcvr_in_ibs_tie_high[*] \
                                    xcvr_in_ibs_tie_low[*] \
                                    xcvr_scanout[*] \
                                    lane_addr_tie_high \
                                    lane_addr_tie_low \
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
set async_input_port_collection     [get_ports $async_input_port_list]
set async_output_port_collection    [get_ports $async_output_port_list]

if { ![info exists DRIVING_CELL] } {
    puts "INFO: setting DRIVING_CELL definition"
    set DRIVING_CELL   [get_lib_cells BUFFMZD4BWP210H6P51CNODSVT]
}

if { ![info exists DRIVING_PIN] } {
    puts "INFO: setting DRIVING_PIN definition"
    set DRIVING_PIN Z
}


# Analog lib interface pins to small digital blocks in xcvr
set xcvr_ana_cell_collection  [get_cells -hier -filter {ref_lib_cell_name == rxtxm_ana}]
set xcvr_ana_cdrlf_func_pins  [get_pins -of $xcvr_ana_cell_collection \
    -filter {ref_lib_pin_name =~ "rxda_cdrlf*" && ref_lib_pin_name !~ "rxda_cdrlf_scan*"}]
set xcvr_ana_cdrlf_scan_pins  [get_pins -of $xcvr_ana_cell_collection \
    -filter {ref_lib_pin_name =~ "rxda_cdrlf_scan*" && ref_lib_pin_name !~ "rxda_cdrlf_scanclk"}]

set xcvr_ana_drv_func_pins  [get_pins -of $xcvr_ana_cell_collection \
    -filter {ref_lib_pin_name =~ "txda_drv*" && ref_lib_pin_name !~ "txda_drv_scan*"}]
set xcvr_ana_drv_scan_pins  [get_pins -of $xcvr_ana_cell_collection \
    -filter {ref_lib_pin_name =~ "txda_drv_scan*" && ref_lib_pin_name !~ "txda_drv_scanclk"}]
set xcvr_ana_drv_scan_pins  [get_pins -of $xcvr_ana_cell_collection -filter {ref_lib_pin_name =~ "txda_drv_scan*"}]
