set hier_path ""

set SRAM_DEPTH              14
set PHY_SCAN_IN_WIDTH       15
set PHY_SCAN_OUT_WIDTH      15
set PMA_CMN_SCAN_IN_WIDTH   39
set PMA_CMN_SCAN_OUT_WIDTH  39
set PMA_XCVR_SCAN_IN_WIDTH  89
set PMA_XCVR_SCAN_OUT_WIDTH 89

#---------------------------------------------------------------------------------------------------------------------------------#
#                                                          Setup clocks                                                           #
#---------------------------------------------------------------------------------------------------------------------------------#
#--- clock on TOP ---#
clock apb_pclk
clock uc_clk
clock pipe7_l00_clk
clock pipe7_l01_clk
clock pma_tx_td_clk
clock pma_cmn_refclk0_int
clock pma_cmn_refclk1_int
#clock dtb_clk
clock tap_tck -both_edges
# ???
clock uc_top_tap_tck -both_edges 
clock uc_l01_tap_tck -both_edges
clock uc_l23_tap_tck -both_edges

clock ieee1687_tck 

#--- clock internal ---#
#clock u_pma_top.u_pma_ana_wrapper.u_pma_ana.cmnda_pll_ref_clk
#clock pipe4_clk
#clock pipe7_l00_rx_clk
#clock pipe7_l01_rx_clk

#clock pipe7_clk_max
#clock usb_datart_clk
#clock usb_fullrt_clk
#clock dp_datart_clk
#clock dp_fullrt_clk

clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_fb_divider_clk
clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_ref_clk
clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_dsm_clk
clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog1
clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_dsm_clk
clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_clk_prog0
clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_clk_prog1
clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pmc_clk
clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_tmpsns_sdm_clk_out

clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_clk
clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_des_clk

clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_mom_osc_clk
clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_sd_clk
clock u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_ser_clk
clock u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_ser_clk
#clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.rxda_des_clk_2x
clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_clk
clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_ser_clk
#clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.rxda_des_clk_2x
clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_clk
clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_ser_clk


#clock u_mp_pma.cmn_ref_clk_gated
#clock u_mp_pma.cmn_ref_clk
#clock u_mp_pma.cmn_psm_clk_out
#clock u_mp_pma.cmn_pll0_clk_prog0
#clock u_mp_pma.rx_rd_clk_ln_0
#clock u_mp_pma.rx_rd_clk_ln_1
#clock u_mp_pma.rx_rd_clk_ln_2
#clock u_mp_pma.rx_rd_clk_ln_3
#clock u_mp_pma.xcvr_pll_clk_datart_ln_0
#clock u_mp_pma.xcvr_pll_clk_datart_ln_3
#clock u_mp_pma.xcvr_pll_clk_fullrt_ln_0
#clock u_mp_pma.xcvr_pll_clk_fullrt_ln_3

#--- Setup virtual clocks ---#
check_cdc -clock_domain -virtual_clock vclk
check_cdc -clock_domain -virtual_clock vclk_bump
check_cdc -clock_domain -virtual_clock vclk_scan
check_cdc -clock_domain -virtual_clock vclk_ana
#check_cdc -clock_domain -virtual_clock vclk_tap
check_cdc -clock_domain -virtual_clock vclk_uc_reset_n
check_cdc -clock_domain -virtual_clock vclk_phy_reset_n
check_cdc -clock_domain -virtual_clock vclk_pipe4_reset_n
check_cdc -clock_domain -virtual_clock vclk_pipe7_reset_n
check_cdc -clock_domain -virtual_clock vclk_dp_reset_n

clock vclk
clock vclk_bump
clock vclk_scan
clock vclk_ana
#clock vclk_tap
clock vclk_uc_reset_n
clock vclk_phy_reset_n
clock vclk_pipe4_reset_n
clock vclk_pipe7_reset_n
clock vclk_dp_reset_n

config_rtlds -clock -group -sync {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0 pipe7_l00_clk pipe7_l01_clk}

# try to define generated clocks on output of MUX, and set the generated clock physically_exclusive
# not working, there are still more than 1 clocks on output of MUX
#config_rtlds -clock -create {u_phy_clkrst.u_int_pma_tx_td_clk_ln_23_mux.clk_out} -name u_int_pma_tx_td_clk_ln_23_mux_pma_tx_td_clk
#config_rtlds -clock -create {u_phy_clkrst.u_int_pma_tx_td_clk_ln_23_mux.clk_out} -name u_int_pma_tx_td_clk_ln_23_pll0_clk_prog0 -add
#config_rtlds -clock -group -sync {u_int_pma_tx_td_clk_ln_23_mux_pma_tx_td_clk pma_tx_td_clk}
#config_rtlds -clock -group -sync {u_int_pma_tx_td_clk_ln_23_pll0_clk_prog0 u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0}
#config_rtlds -clock -group -physically_exclusive {u_int_pma_tx_td_clk_ln_23_mux_pma_tx_td_clk u_int_pma_tx_td_clk_ln_23_pll0_clk_prog0}

#---------------------------------------------------------------------------------------------------------------------------------#
#                                                 Constant PHY inputs                                                             #
# --------------------------------------------------------------------------------------------------------------------------------#

config_rtlds -signal -constant [subst {{${hier_path}iddq_en 0}}]

config_rtlds -signal -constant [subst {{${hier_path}scanmode  0}}]
config_rtlds -signal -constant [subst {{${hier_path}scanen    0}}]
config_rtlds -signal -constant [subst {{${hier_path}scanen_cg 0}}]

config_rtlds -signal -constant [subst {{${hier_path}xcvr_bscan_mode_en 0}}]

config_rtlds -signal -constant [subst {{${hier_path}pma_cmn_refclk_dig_div  0}}]
config_rtlds -signal -constant [subst {{${hier_path}pma_cmn_refclk_dig_sel  0}}]
config_rtlds -signal -constant [subst {{${hier_path}pma_cmn_pll0_refclk_sel 0}}]
config_rtlds -signal -constant [subst {{${hier_path}pma_cmn_pll1_refclk_sel 0}}]

config_rtlds -signal -constant [subst {{${hier_path}cmn_scan_pll_ats 0}}]

config_rtlds -signal -constant [subst {{${hier_path}cmn_scanclk_psmclk 0}}]
config_rtlds -signal -constant [subst {{${hier_path}cmn_scanclk_refclk 0}}]
config_rtlds -signal -constant [subst {{${hier_path}cmn_scanclk_serclk 0}}]
config_rtlds -signal -constant [subst {{${hier_path}cmn_scanclk_pllclk 0}}]
config_rtlds -signal -constant [subst {{${hier_path}scanclk_pipeclk    0}}]

config_rtlds -signal -constant [subst {{${hier_path}xcvr_scanclk_serclk_ln_0 0}}]
config_rtlds -signal -constant [subst {{${hier_path}xcvr_scanclk_pllclk_ln_0 0}}]
config_rtlds -signal -constant [subst {{${hier_path}xcvr_scanclk_serclk_ln_1 0}}]
config_rtlds -signal -constant [subst {{${hier_path}xcvr_scanclk_pllclk_ln_1 0}}]
config_rtlds -signal -constant [subst {{${hier_path}xcvr_scanclk_serclk_ln_2 0}}]
config_rtlds -signal -constant [subst {{${hier_path}xcvr_scanclk_pllclk_ln_2 0}}]
config_rtlds -signal -constant [subst {{${hier_path}xcvr_scanclk_serclk_ln_3 0}}]
config_rtlds -signal -constant [subst {{${hier_path}xcvr_scanclk_pllclk_ln_3 0}}]

config_rtlds -signal -constant [subst {{${hier_path}tx_bscan_ext_clockdr 0}}]
config_rtlds -signal -constant [subst {{${hier_path}rx_bscan_ext_clockdr 0}}]


config_rtlds -signal -constant [subst {{${hier_path}bscan_ext_select       0}}]
config_rtlds -signal -constant [subst {{${hier_path}tx_bscan_ext_updatedr  0}}]
config_rtlds -signal -constant [subst {{${hier_path}tx_bscan_ext_mode_c    0}}]
config_rtlds -signal -constant [subst {{${hier_path}tx_bscan_ext_ac        0}}]
config_rtlds -signal -constant [subst {{${hier_path}tx_bscan_ext_acpulse   0}}]
config_rtlds -signal -constant [subst {{${hier_path}rx_bscan_ext_pc        0}}]
config_rtlds -signal -constant [subst {{${hier_path}rx_bscan_ext_ac        0}}]


config_rtlds -signal -constant [subst {{${hier_path}ieee1687_interface_en  0}}]

config_rtlds -signal -constant [subst {{${hier_path}typec_conn_dir  0}}]

#config_rtlds -signal -constant [subst {{${hier_path}phy_mode 1}}]
# u_pcs_iso_ctrl_cmn.iso_mode_usb4_en also used as clock gating enable, so you can't set it to 0
#config_rtlds -signal -constant [subst {{${hier_path}u_pcs_iso_ctrl_cmn.iso_mode_usb4_en 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_phy_clkrst.u_mux_pipe_clk.clk_sel 0}}]

#---------------------------------------------------------------------------------------------------------------------------------#
#                                                   Static PHY inputs                                                             #
#---------------------------------------------------------------------------------------------------------------------------------#
#UTMI Related signals which should be stable for a long time before used.
#config_rtlds -signal -static "${hier_path}typec_conn_dir"

config_rtlds -signal -static "${hier_path}phy_mode"
config_rtlds -signal -static "${hier_path}pipe4_eb_mode"

config_rtlds -signal -static "${hier_path}pma_xcvr_data_width"

#config_rtlds -signal -static "${hier_path}ieee1687_interface_en"

#---------------------------------------------------------------------------------------------------------------------------------#
#                                                 Constant PHY internal registers                                                 #
#---------------------------------------------------------------------------------------------------------------------------------#
# set iso_mode_en to 0 when scan_mode_en is 0
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_cmn.phy_isolation_ctrl_reg\[19\] 0}}]
# set macro_isolation_mode_en to 0 when scan_mode_en is 0
config_rtlds -signal -constant [subst {{${hier_path}u_tap_complex.custom_reg_1_out\[0\] 0}}]

#config_rtlds -signal -constant [subst {{${hier_path}u_mp_pcs_top_ln_0.mp_pcs_original.i_pwr_rate_ctrl.pma_cmn_standard_mode\[2\] 0}}]
#config_rtlds -signal -constant [subst {{${hier_path}u_mp_pcs_top_ln_0.mp_pcs_original.i_pwr_rate_ctrl.pma_cmn_standard_mode\[1\] 0}}]
#config_rtlds -signal -constant [subst {{${hier_path}u_mp_pcs_top_ln_0.mp_pcs_original.i_pwr_rate_ctrl.pma_cmn_standard_mode\[0\] 0}}]
#config_rtlds -signal -constant [subst {{${hier_path}u_mp_pcs_top_ln_1.mp_pcs_original.i_pwr_rate_ctrl.pma_cmn_standard_mode\[2\] 0}}]
#config_rtlds -signal -constant [subst {{${hier_path}u_mp_pcs_top_ln_1.mp_pcs_original.i_pwr_rate_ctrl.pma_cmn_standard_mode\[1\] 0}}]
#config_rtlds -signal -constant [subst {{${hier_path}u_mp_pcs_top_ln_1.mp_pcs_original.i_pwr_rate_ctrl.pma_cmn_standard_mode\[0\] 0}}]
#config_rtlds -signal -constant [subst {{${hier_path}u_mp_pcs_top_ln_0.mp_pcs_serdes.i_pwr_rate_ctrl.pma_standard_mode\[2\] 0}}]
#config_rtlds -signal -constant [subst {{${hier_path}u_mp_pcs_top_ln_0.mp_pcs_serdes.i_pwr_rate_ctrl.pma_standard_mode\[1\] 0}}]
#config_rtlds -signal -constant [subst {{${hier_path}u_mp_pcs_top_ln_0.mp_pcs_serdes.i_pwr_rate_ctrl.pma_standard_mode\[0\] 0}}]
#config_rtlds -signal -constant [subst {{${hier_path}u_mp_pcs_top_ln_1.mp_pcs_serdes.i_pwr_rate_ctrl.pma_standard_mode\[2\] 0}}]
#config_rtlds -signal -constant [subst {{${hier_path}u_mp_pcs_top_ln_1.mp_pcs_serdes.i_pwr_rate_ctrl.pma_standard_mode\[1\] 0}}]
#config_rtlds -signal -constant [subst {{${hier_path}u_mp_pcs_top_ln_1.mp_pcs_serdes.i_pwr_rate_ctrl.pma_standard_mode\[0\] 0}}]

config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_iso_lane_mode_reg\[22\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_iso_lane_mode_reg\[21\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_iso_lane_mode_reg\[20\] 0}}]

# set u_phy_clkrst.pipe7_pma_tx_td_clk_ln_0 and u_phy_clkrst.int_pma_tx_td_clk_ln_01 sel to 0
config_rtlds -signal -constant [subst {{${hier_path}u_pcs_iso_ctrl_cmn.phy_pma_lane_map_reg\[12\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pcs_iso_ctrl_cmn.phy_pma_lane_map_reg\[8\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pcs_iso_ctrl_cmn.phy_pma_lane_map_reg\[4\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pcs_iso_ctrl_cmn.phy_pma_lane_map_reg\[0\]  0}}]

# set u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.rxda_des_clk_invert_sel to 0
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_rxclk_ctrl_reg\[15\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_rxclk_ctrl_reg\[15\] 0}}]

# set pma lopback to constant to set u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.u_clock_mux_v0_rx_rd_clk.clk_sel
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_xcvr_ctrl_reg\[ 1\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_xcvr_ctrl_reg\[ 2\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_xcvr_ctrl_reg\[ 4\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_xcvr_ctrl_reg\[ 5\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_xcvr_ctrl_reg\[ 6\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_xcvr_ctrl_reg\[ 8\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_xcvr_ctrl_reg\[18\] 1}}]

config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_xcvr_ctrl_reg\[ 1\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_xcvr_ctrl_reg\[ 2\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_xcvr_ctrl_reg\[ 4\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_xcvr_ctrl_reg\[ 5\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_xcvr_ctrl_reg\[ 6\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_xcvr_ctrl_reg\[ 8\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_xcvr_ctrl_reg\[ 8\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_xcvr_ctrl_reg\[18\] 1}}]

config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_xcvr_ctrl_reg\[ 1\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_xcvr_ctrl_reg\[ 2\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_xcvr_ctrl_reg\[ 4\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_xcvr_ctrl_reg\[ 5\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_xcvr_ctrl_reg\[ 6\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_xcvr_ctrl_reg\[ 8\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_xcvr_ctrl_reg\[ 8\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_xcvr_ctrl_reg\[18\] 1}}]

config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_xcvr_ctrl_reg\[ 1\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_xcvr_ctrl_reg\[ 2\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_xcvr_ctrl_reg\[ 4\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_xcvr_ctrl_reg\[ 5\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_xcvr_ctrl_reg\[ 6\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_xcvr_ctrl_reg\[ 8\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_xcvr_ctrl_reg\[ 8\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_xcvr_ctrl_reg\[18\] 1}}]

# set xcvr_stand_mode iso to 0
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_override_reg\[4\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_override_reg\[10\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_override_reg\[9\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_override_reg\[8\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_override_reg\[2\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_override_reg\[1\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_override_reg\[0\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_override_reg\[4\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_override_reg\[10\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_override_reg\[9\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_override_reg\[8\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_override_reg\[2\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_override_reg\[1\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_override_reg\[0\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_override_reg\[4\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_override_reg\[10\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_override_reg\[9\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_override_reg\[8\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_override_reg\[2\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_override_reg\[1\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_override_reg\[0\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_override_reg\[4\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_override_reg\[10\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_override_reg\[9\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_override_reg\[8\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_override_reg\[2\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_override_reg\[1\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_override_reg\[0\] 0}}]

# set xcvr_diag_plldrc_ctrl_reg to constant to u_mp_pma.u_pma_rev.u_xcvr_txm.U_xcvr_txonly0.u_xcvr_clkrst.u_clock_mux_cmn_pll_clk_gated.clk_sel a constant 
# to make u_mp_pma.u_pma_rev.u_xcvr_txm.U_xcvr_txonly0.u_xcvr_clkrst.cmn_pll_clk_gated unique
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[15\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[14\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[13\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[12\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[11\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[10\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[9\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[8\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[7\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[6\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[5\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[4\]  1}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[3\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[2\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[1\]  1}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[0\]  0}}]

config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[15\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[14\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[13\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[12\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[11\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[10\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[9\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[8\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[7\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[6\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[5\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[4\]  1}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[3\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[2\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[1\]  1}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_plldrc_ctrl_reg\[0\]  0}}]

config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[15\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[14\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[13\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[12\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[11\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[10\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[9\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[8\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[7\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[6\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[5\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[4\]  1}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[3\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[2\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[1\]  1}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[0\]  0}}]

config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[15\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[14\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[13\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[12\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[11\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[10\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[9\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[8\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[7\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[6\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[5\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[4\]  1}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[3\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[2\]  0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[1\]  1}}]
config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg\[0\]  0}}]


# PHY APB register
config_rtlds -signal -constant [subst {{${hier_path}u_tap_complex.u_diagnostic_ctrl_reg.pdo\[0\] 0}}]
config_rtlds -signal -constant [subst {{${hier_path}u_tap_complex.u_diagnostic_ctrl_reg.pdo\[1\] 1}}]

#---------------------------------------------------------------------------------------------------------------------------------#
#                                                   Static PHY internal registers                                                 #
#---------------------------------------------------------------------------------------------------------------------------------#
#config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_rxclk_ctrl_reg[15]"
#config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_rxclk_ctrl_reg[15]"

config_rtlds -signal -static "${hier_path}u_mp_pcs_top_ln_0.mp_pcs_original.i_pwr_rate_ctrl.pma_cmn_standard_mode"
config_rtlds -signal -static "${hier_path}u_mp_pcs_top_ln_1.mp_pcs_original.i_pwr_rate_ctrl.pma_cmn_standard_mode"
config_rtlds -signal -static "${hier_path}u_mp_pcs_top_ln_0.mp_pcs_serdes.i_pwr_rate_ctrl.pma_standard_mode"
config_rtlds -signal -static "${hier_path}u_mp_pcs_top_ln_1.mp_pcs_serdes.i_pwr_rate_ctrl.pma_standard_mode"

config_rtlds -signal -static "${hier_path}u_mp_pcs_top_ln_0.mp_pcs_original.i_pwr_rate_ctrl.pma_cmn_data_width"
config_rtlds -signal -static "${hier_path}u_mp_pcs_top_ln_1.mp_pcs_original.i_pwr_rate_ctrl.pma_cmn_data_width"
config_rtlds -signal -static "${hier_path}u_mp_pcs_top_ln_0.mp_pcs_serdes.i_pwr_rate_ctrl.pma_data_width"
config_rtlds -signal -static "${hier_path}u_mp_pcs_top_ln_1.mp_pcs_serdes.i_pwr_rate_ctrl.pma_data_width"

config_rtlds -signal -static "${hier_path}u_tap_complex.u_diagnostic_apb_access_wr_data_reg.pdo"
config_rtlds -signal -static "${hier_path}u_tap_complex.u_diagnostic_apb_access_address_reg.pdo"
config_rtlds -signal -static "${hier_path}u_tap_complex.u_diagnostic_apb_access_control_reg.pdo\[2\]"

# message bus input, mb_lm_cdb_xxx
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_pipe_lm_cfg0"
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_pipe_lm_cfg1"
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_pipe_lm_cfg2"

# original pipe: cfg_usb_gen2_prex & cfg_usb_gen2_postx
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_pipe_usb3_gen2_pre_cfg"
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_pipe_usb3_gen2_post_cfg"

# original pipe: pipe4_cfg_pcs_xxx, pipe4_cfg_usb_xxx
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_pipe4_cmn_ctrl_reg\[0\]"
#config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_pipe4_cmn_ctrl_reg\[1\]"
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_pipe4_cmn_ctrl_reg\[2\]"
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_pipe4_cmn_ctrl_reg\[3\]"
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_pipe4_cmn_ctrl_reg\[4\]"
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_pipe4_cmn_ctrl_reg\[6\]"
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_pipe4_cmn_ctrl_reg\[11\:8\]"
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_pipe4_cmn_ctrl_reg\[15\:12\]"
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_pipe4_cmn_ctrl_reg\[17\:16\]"
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_pipe4_cmn_ctrl_reg\[18\]"
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_pipe4_cmn_ctrl_reg\[19\]"
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_pipe4_cmn_ctrl_reg\[20\]"
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_pipe4_cmn_ctrl_reg\[21\]"
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_pipe4_cmn_ctrl_reg\[22\]"

# original pipe: pcs_cal_x, pcs_com_x
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_pipe_com_lock_cfg"

# original pipe: pcs_eie_x, pcs_rcv_det_x
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_pcs_gen3_eie_lock_cfg"

# cfg_l1_x_exit_fast_cnt
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_cmn.phy_timeout_reg"

# direction change or figure of merit selection
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_ln_0.phy_pipe_ctrl_sts\[3\]"
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_ln_2.phy_pipe_ctrl_sts\[3\]"
# tx_local_fs_lf_valid --- not static
#config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_ln_0.phy_pipe_ctrl_sts\[6\]"
#config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_ln_2.phy_pipe_ctrl_sts\[6\]"

# mb destructive margining sel
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_ln_0.phy_pipe_ctrl_sts\[13\]"
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_ln_2.phy_pipe_ctrl_sts\[13\]"

# data_path_override
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_ln_0.phy_pipe_ctrl_sts\[24\]"
config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_ln_2.phy_pipe_ctrl_sts\[24\]"

# Can be considered static for CDC - Captured on rising edge of penable/psel
config_rtlds -signal -static "${hier_path}u_phy_apb_slv_async_if.apb_pwdata_d"
config_rtlds -signal -static "${hier_path}u_phy_apb_slv_async_if.apb_paddr_d"
config_rtlds -signal -static "${hier_path}u_phy_apb_slv_async_if.apb_pwrite_d"
config_rtlds -signal -static "${hier_path}u_phy_apb_slv_async_if.int_apb_prdata"
config_rtlds -signal -static "${hier_path}u_phy_apb_slv_async_if.int_apb_perr"

config_rtlds -signal -static "${hier_path}u_phy_apb_mstr_async_if.apb_pwdata_d"
config_rtlds -signal -static "${hier_path}u_phy_apb_mstr_async_if.apb_paddr_d"
config_rtlds -signal -static "${hier_path}u_phy_apb_mstr_async_if.apb_pwrite_d"
config_rtlds -signal -static "${hier_path}u_phy_apb_mstr_async_if.int_apb_prdata"
config_rtlds -signal -static "${hier_path}u_phy_apb_mstr_async_if.int_apb_perr"

config_rtlds -signal -static "${hier_path}u_apb_top_wrapper.u_async_apb_if_slv.async_rdata"


config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd.u_cmn_cdiag_ovrd_cdb_regs.cmn_cdiag_psmclk_ctrl_reg"

#---------------------------------------------------------------------------------------------------------------------------------#
#                                                           Setup resets                                                          #
#---------------------------------------------------------------------------------------------------------------------------------#
config_rtlds -reset -async apb_preset_n        -polarity low
config_rtlds -reset -async uc_reset_n          -polarity low
config_rtlds -reset -async phy_reset_n         -polarity low
config_rtlds -reset -async pipe4_reset_n       -polarity low
config_rtlds -reset -async pipe7_reset_n       -polarity low
config_rtlds -reset -async dp_reset_n          -polarity low

config_rtlds -reset -sync tap_trst_n           -polarity low  -clock tap_tck
config_rtlds -reset -sync uc_top_tap_trst_n    -polarity low  -clock uc_top_tap_tck
config_rtlds -reset -sync uc_l01_tap_trst_n    -polarity low  -clock uc_l01_tap_tck
config_rtlds -reset -sync uc_l23_tap_trst_n    -polarity low  -clock uc_l23_tap_tck

config_rtlds -reset -sync ieee1687_rstn        -polarity low  -clock ieee1687_tck
#config_rtlds -reset -sync u_tap_complex.u_JTAG_MACRO.U_TAP_CONTROLLER.TCS_RESET -polarity low -clock tap_tck
#config_rtlds -reset -sync u_ieee1687_wrapper.u_diag_ctrl_tdr.u_reg\[1\] -polarity low -clock ieee1687_tck
#config_rtlds -reset -sync u_ieee1687_wrapper.u_diag_ctrl_tdr.u_reg\[0\] -polarity low -clock ieee1687_tck

#check_cdc -reset -set_order {u_pcs_top.u_pcs_crg.u_reset_sync_phy_state_reset.genblk1.reset_sync_flop[2] u_pcs_top.u_pcs_crg.u_reset_sync_cm_rap_reset.genblk1.reset_sync_flop[1]}


#---------------------------------------------------------------------------------------------------------------------------------#
#                                                  port clock domain assignment                                                   #
#---------------------------------------------------------------------------------------------------------------------------------#
# async inputs
config_rtlds -port uc_reset_n                               -clock vclk_uc_reset_n
config_rtlds -port phy_reset_n                              -clock vclk_phy_reset_n
config_rtlds -port pipe4_reset_n                            -clock vclk_pipe4_reset_n
config_rtlds -port pipe7_reset_n                            -clock vclk_pipe7_reset_n
config_rtlds -port dp_reset_n                               -clock vclk_dp_reset_n

config_rtlds -port typec_conn_dir                           -clock vclk
config_rtlds -port phy_mode                                 -clock vclk

config_rtlds -port phy_interrupt_usb                        -clock vclk
config_rtlds -port phy_interrupt_dp                         -clock vclk

config_rtlds -port phy_l00_ctlr_interrupt_in                -clock vclk
config_rtlds -port phy_l01_ctlr_interrupt_in                -clock vclk

# PMA bumps
config_rtlds -port tx_p_ln_0                                -clock vclk_bump
config_rtlds -port tx_m_ln_0                                -clock vclk_bump
config_rtlds -port rx_p_ln_1                                -clock vclk_bump
config_rtlds -port rx_m_ln_1                                -clock vclk_bump
config_rtlds -port rx_p_ln_2                                -clock vclk_bump
config_rtlds -port rx_m_ln_2                                -clock vclk_bump
config_rtlds -port tx_p_ln_3                                -clock vclk_bump
config_rtlds -port tx_m_ln_3                                -clock vclk_bump
config_rtlds -port cmn_rext                                 -clock vclk_bump

# ???
config_rtlds -port pma_atb_core_0                           -clock vclk
config_rtlds -port pma_atb_core_1                           -clock vclk
config_rtlds -port dtb_data                                 -clock vclk

config_rtlds -port phy_uc_init_complete                     -clock uc_clk
config_rtlds -port phy_error_interrupt                      -clock uc_clk

config_rtlds -port sram_ceb_top                             -clock uc_clk      
config_rtlds -port sram_web_top                             -clock uc_clk 
config_rtlds -port sram_bweb_top                            -clock uc_clk   
config_rtlds -port sram_addr_top                            -clock uc_clk   
config_rtlds -port sram_wr_data_top                         -clock uc_clk      
config_rtlds -port sram_rd_data_top                         -clock uc_clk     
#config_rtlds -port iram_addr_top                            -clock uc_clk   
#config_rtlds -port iram_rd_data_top                         -clock uc_clk     
#config_rtlds -port iram_ceb_top                             -clock uc_clk     
#config_rtlds -port iram_web_top                             -clock uc_clk    
#config_rtlds -port iram_wr_data_top                         -clock uc_clk     
config_rtlds -port sram_pwrdwn_top                          -clock uc_clk  

config_rtlds -port sram_ceb_ln_01                           -clock uc_clk      
config_rtlds -port sram_web_ln_01                           -clock uc_clk 
config_rtlds -port sram_bweb_ln_01                          -clock uc_clk   
config_rtlds -port sram_addr_ln_01                          -clock uc_clk   
config_rtlds -port sram_wr_data_ln_01                       -clock uc_clk      
config_rtlds -port sram_rd_data_ln_01                       -clock uc_clk     
#config_rtlds -port iram_addr_ln_01                          -clock uc_clk   
#config_rtlds -port iram_rd_data_ln_01                       -clock uc_clk     
#config_rtlds -port iram_ceb_ln_01                           -clock uc_clk     
#config_rtlds -port iram_web_ln_01                           -clock uc_clk    
#config_rtlds -port iram_wr_data_ln_01                       -clock uc_clk     
config_rtlds -port sram_pwrdwn_ln_01                        -clock uc_clk

config_rtlds -port sram_ceb_ln_23                           -clock uc_clk      
config_rtlds -port sram_web_ln_23                           -clock uc_clk 
config_rtlds -port sram_bweb_ln_23                          -clock uc_clk   
config_rtlds -port sram_addr_ln_23                          -clock uc_clk   
config_rtlds -port sram_wr_data_ln_23                       -clock uc_clk      
config_rtlds -port sram_rd_data_ln_23                       -clock uc_clk     
#config_rtlds -port iram_addr_ln_23                          -clock uc_clk   
#config_rtlds -port iram_rd_data_ln_23                       -clock uc_clk     
#config_rtlds -port iram_ceb_ln_23                           -clock uc_clk     
#config_rtlds -port iram_web_ln_23                           -clock uc_clk    
#config_rtlds -port iram_wr_data_ln_23                       -clock uc_clk     
config_rtlds -port sram_pwrdwn_ln_23                        -clock uc_clk

config_rtlds -port apb_tgt_penable                          -clock apb_pclk
config_rtlds -port apb_tgt_psel                             -clock apb_pclk
config_rtlds -port apb_tgt_pwrite                           -clock apb_pclk
config_rtlds -port apb_tgt_paddr                            -clock apb_pclk
config_rtlds -port apb_tgt_pwdata                           -clock apb_pclk
config_rtlds -port apb_tgt_prdata                           -clock apb_pclk
config_rtlds -port apb_tgt_pready                           -clock apb_pclk
config_rtlds -port apb_tgt_perr                             -clock apb_pclk

config_rtlds -port apb_mstr_penable                         -clock apb_pclk
config_rtlds -port apb_mstr_psel                            -clock apb_pclk
config_rtlds -port apb_mstr_pwrite                          -clock apb_pclk
config_rtlds -port apb_mstr_paddr                           -clock apb_pclk
config_rtlds -port apb_mstr_pwdata                          -clock apb_pclk
config_rtlds -port apb_mstr_prdata                          -clock apb_pclk
config_rtlds -port apb_mstr_pready                          -clock apb_pclk
config_rtlds -port apb_mstr_perr                            -clock apb_pclk

# PIPE interface
config_rtlds -port pipe4_eb_mode                            -clock vclk
config_rtlds -port pipe4_l00_phy_status                     -clock vclk  
config_rtlds -port pipe4_l00_rx_elec_idle                   -clock vclk
config_rtlds -port pipe4_l01_phy_status                     -clock vclk  
config_rtlds -port pipe4_l01_rx_elec_idle                   -clock vclk

config_rtlds -port pipe4_clk                                -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_rate                               -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_powerdown\[1\:0\]                  -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0

config_rtlds -port pipe4_l00_rx_data\[31\:0\]               -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0 
config_rtlds -port pipe4_l00_rx_data_k\[3\:0\]              -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0     
config_rtlds -port pipe4_l00_rx_sync_header\[3\:0\]         -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0  
config_rtlds -port pipe4_l00_rx_start_block                 -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l00_rx_data_valid                  -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l00_rx_valid                       -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l00_rx_status\[2\:0\]              -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l00_rx_polarity                    -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l00_rx_termination                 -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l00_rx_eq_training                 -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l00_tx_data\[31\:0\]               -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0 
config_rtlds -port pipe4_l00_tx_data_k\[3\:0\]              -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l00_tx_sync_header\[3\:0\]         -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l00_tx_start_block                 -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l00_tx_data_valid                  -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l00_tx_det_rx_lpbk                 -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l00_tx_elec_idle                   -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l00_tx_ones_zeros                  -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l00_tx_128b_enc_byp                -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l00_tx_deemph\[1\:0\]              -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0

config_rtlds -port pipe4_l01_rx_data\[31\:0\]               -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0   
config_rtlds -port pipe4_l01_rx_data_k\[3\:0\]              -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0     
config_rtlds -port pipe4_l01_rx_sync_header\[3\:0\]         -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0  
config_rtlds -port pipe4_l01_rx_start_block                 -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l01_rx_data_valid                  -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l01_rx_valid                       -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l01_rx_status\[2\:0\]              -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l01_rx_polarity                    -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l01_rx_termination                 -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l01_rx_eq_training                 -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l01_tx_data\[31\:0\]               -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0 
config_rtlds -port pipe4_l01_tx_data_k\[3\:0\]              -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l01_tx_sync_header\[3\:0\]         -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l01_tx_start_block                 -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l01_tx_data_valid                  -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l01_tx_det_rx_lpbk                 -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l01_tx_elec_idle                   -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l01_tx_ones_zeros                  -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l01_tx_128b_enc_byp                -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
config_rtlds -port pipe4_l01_tx_deemph\[1\:0\]              -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0

# ???
config_rtlds -port pipe7_clk_max_req                        -clock vclk
config_rtlds -port pipe7_clk_max_ack                        -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0


# ???
config_rtlds -port pipe7_pll0_en                            -clock vclk
config_rtlds -port pipe7_pll0_ok                            -clock uc_clk

config_rtlds -port pipe7_l00_rate\[1\:0\]                   -clock pipe7_l00_clk 
config_rtlds -port pipe7_l00_phy_status                     -clock vclk
config_rtlds -port pipe7_l00_rx_data\[39\:0\]               -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_clk
config_rtlds -port pipe7_l00_rx_valid                       -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_clk
config_rtlds -port pipe7_l00_rx_standby_status              -clock vclk
config_rtlds -port pipe7_l00_rx_elec_idle                   -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_clk
config_rtlds -port pipe7_l00_rx_termination                 -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_clk
config_rtlds -port pipe7_l00_rx_standby                     -clock vclk
config_rtlds -port pipe7_l00_powerdown\[2\:0\]              -clock pipe7_l00_clk
config_rtlds -port pipe7_l00_tx_data\[39\:0\]               -clock pipe7_l00_clk
config_rtlds -port pipe7_l00_tx_data_valid                  -clock pipe7_l00_clk
config_rtlds -port pipe7_l00_tx_det_rx_lpbk                 -clock pipe7_l00_clk
config_rtlds -port pipe7_l00_tx_elec_idle                   -clock pipe7_l00_clk
config_rtlds -port pipe7_l00_m2p_messagebus\[7\:0\]         -clock pipe7_l00_clk
config_rtlds -port pipe7_l00_p2m_messagebus\[7\:0\]         -clock pipe7_l00_clk
#config_rtlds -port pipe7_l00_m2p_messagebus\[7\:0\]         -clock u_phy_clkrst.u_mux_pipe_clk.clk_out
#config_rtlds -port pipe7_l00_p2m_messagebus\[7\:0\]         -clock u_phy_clkrst.u_mux_pipe_clk.clk_out

config_rtlds -port pipe7_l01_rate\[1\:0\]                   -clock pipe7_l01_clk 
config_rtlds -port pipe7_l01_phy_status                     -clock vclk
config_rtlds -port pipe7_l01_rx_data\[39\:0\]               -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_des_clk
config_rtlds -port pipe7_l01_rx_valid                       -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_des_clk
config_rtlds -port pipe7_l01_rx_standby_status              -clock vclk
config_rtlds -port pipe7_l01_rx_elec_idle                   -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_des_clk
config_rtlds -port pipe7_l01_rx_termination                 -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_des_clk
config_rtlds -port pipe7_l01_rx_standby                     -clock vclk
config_rtlds -port pipe7_l01_powerdown\[2\:0\]              -clock pipe7_l01_clk
config_rtlds -port pipe7_l01_tx_data\[39\:0\]               -clock pipe7_l01_clk
config_rtlds -port pipe7_l01_tx_data_valid                  -clock pipe7_l01_clk
config_rtlds -port pipe7_l01_tx_det_rx_lpbk                 -clock pipe7_l01_clk
config_rtlds -port pipe7_l01_tx_elec_idle                   -clock pipe7_l00_clk
config_rtlds -port pipe7_l01_m2p_messagebus\[7\:0\]         -clock pipe7_l01_clk
config_rtlds -port pipe7_l01_p2m_messagebus\[7\:0\]         -clock pipe7_l01_clk
#config_rtlds -port pipe7_l01_m2p_messagebus\[7\:0\]         -clock u_phy_clkrst.u_mux_pipe_clk.clk_out
#config_rtlds -port pipe7_l01_p2m_messagebus\[7\:0\]         -clock u_phy_clkrst.u_mux_pipe_clk.clk_out

# raw intf for DP
config_rtlds -port pma_cmn_ready                            -clock vclk
config_rtlds -port pma_xcvr_pllclk_en_ack                   -clock vclk
config_rtlds -port pma_xcvr_pllclk_en                       -clock vclk
config_rtlds -port pma_xcvr_power_state_ack\[5\:0\]         -clock vclk 
config_rtlds -port pma_xcvr_power_state_req\[5\:0\]         -clock vclk

config_rtlds -port pma_xcvr_data_width\[2\:0\]              -clock vclk

config_rtlds -port pma_tx_lfps_en                           -clock pma_tx_td_clk
config_rtlds -port pma_tx_lfps_mode                         -clock pma_tx_td_clk

config_rtlds -port pma_tx_elec_idle_ln_0                    -clock pma_tx_td_clk
config_rtlds -port pma_tx_td_ln_0\[31\:0\]                  -clock pma_tx_td_clk
config_rtlds -port pma_tx_elec_idle_ln_1                    -clock pma_tx_td_clk
config_rtlds -port pma_tx_td_ln_1\[31\:0\]                  -clock pma_tx_td_clk
config_rtlds -port pma_tx_elec_idle_ln_2                    -clock pma_tx_td_clk
config_rtlds -port pma_tx_td_ln_2\[31\:0\]                  -clock pma_tx_td_clk
config_rtlds -port pma_tx_elec_idle_ln_3                    -clock pma_tx_td_clk
config_rtlds -port pma_tx_td_ln_3\[31\:0\]                  -clock pma_tx_td_clk

#config_rtlds -port pma_cmn_refclk_dig_div\[1\:0\]           -clock vclk 
#config_rtlds -port pma_cmn_refclk_dig_sel                   -clock vclk 
#config_rtlds -port pma_cmn_pll0_refclk_sel\[1\:0\]          -clock vclk 
#config_rtlds -port pma_cmn_pll1_refclk_sel\[1\:0\]          -clock vclk 

# tap_trst_n - tap_tck ??
config_rtlds -port tap_trst_n                               -clock tap_tck
config_rtlds -port tap_tms                                  -clock tap_tck
config_rtlds -port tap_tdi                                  -clock tap_tck
config_rtlds -port tap_tdo                                  -clock tap_tck
config_rtlds -port tap_tdoen                                -clock tap_tck

config_rtlds -port uc_top_tap_trst_n                        -clock uc_top_tap_tck
config_rtlds -port uc_top_tap_tms                           -clock uc_top_tap_tck
config_rtlds -port uc_top_tap_tdi                           -clock uc_top_tap_tck
config_rtlds -port uc_top_tap_tdo                           -clock uc_top_tap_tck
config_rtlds -port uc_top_tap_tdoen                         -clock uc_top_tap_tck

config_rtlds -port uc_l01_tap_trst_n                        -clock uc_l01_tap_tck
config_rtlds -port uc_l01_tap_tms                           -clock uc_l01_tap_tck
config_rtlds -port uc_l01_tap_tdi                           -clock uc_l01_tap_tck
config_rtlds -port uc_l01_tap_tdo                           -clock uc_l01_tap_tck
config_rtlds -port uc_l01_tap_tdoen                         -clock uc_l01_tap_tck

config_rtlds -port uc_l23_tap_trst_n                        -clock uc_l23_tap_tck
config_rtlds -port uc_l23_tap_tms                           -clock uc_l23_tap_tck
config_rtlds -port uc_l23_tap_tdi                           -clock uc_l23_tap_tck
config_rtlds -port uc_l23_tap_tdo                           -clock uc_l23_tap_tck
config_rtlds -port uc_l23_tap_tdoen                         -clock uc_l23_tap_tck


config_rtlds -port ieee1687_interface_en                    -clock vclk_scan
config_rtlds -port ieee1687_rstn                            -clock vclk_scan
config_rtlds -port ieee1687_so                              -clock {ieee1687_tck}
config_rtlds -port ieee1687_si                              -clock {ieee1687_tck}
config_rtlds -port ieee1687_capture_en                      -clock {ieee1687_tck}
config_rtlds -port ieee1687_shift_en                        -clock {ieee1687_tck}
config_rtlds -port ieee1687_update_en                       -clock {ieee1687_tck}
config_rtlds -port ieee1687_sel                             -clock {ieee1687_tck}

#config_rtlds -port iddq_en                                  -clock vclk_bump

#config_rtlds -port scanmode                                 -clock vclk_scan
#config_rtlds -port scanen                                   -clock vclk_scan
#config_rtlds -port scanen_cg                                -clock vclk_scan

# ???
#config_rtlds -port cmn_scan_pll_ats                         -clock vclk_scan            
config_rtlds -port cmn_scanclk_pll0_prog0_ats_out           -clock vclk_scan
config_rtlds -port cmn_scanclk_pll0_prog1_ats_out           -clock vclk_scan
config_rtlds -port cmn_scanclk_pll1_prog0_ats_out           -clock vclk_scan
config_rtlds -port cmn_scanclk_pll1_prog1_ats_out           -clock vclk_scan
       
# ???
config_rtlds -port phy_scanin             -clock vclk_scan
config_rtlds -port phy_scanout            -clock vclk_scan
config_rtlds -port pma_cmn_scanin         -clock vclk_scan
config_rtlds -port pma_cmn_scanout        -clock vclk_scan
config_rtlds -port pma_xcvr_scanin_ln_0   -clock vclk_scan 
config_rtlds -port pma_xcvr_scanout_ln_0  -clock vclk_scan
config_rtlds -port pma_xcvr_scanin_ln_1   -clock vclk_scan 
config_rtlds -port pma_xcvr_scanout_ln_1  -clock vclk_scan
config_rtlds -port pma_xcvr_scanin_ln_2   -clock vclk_scan 
config_rtlds -port pma_xcvr_scanout_ln_2  -clock vclk_scan
config_rtlds -port pma_xcvr_scanin_ln_3   -clock vclk_scan 
config_rtlds -port pma_xcvr_scanout_ln_3  -clock vclk_scan

config_rtlds -port tx_bscan_ext_shiftdr                 -clock vclk_scan
config_rtlds -port rx_bscan_ext_shiftdr                 -clock vclk_scan
config_rtlds -port rx_bscan_ext_tdi                     -clock vclk_scan
config_rtlds -port tx_bscan_ext_tdo                     -clock vclk_scan

#config_rtlds -port xcvr_bscan_mode_en                   -clock vclk_scan


#pma clock
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_i_data -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_clk
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_q_data -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_clk
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_e_data -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_clk
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_des_i_data -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_des_clk
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_des_q_data -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_des_clk
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_des_e_data -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_des_clk


#pma virtual clock
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_0p5ui_mode_en                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_atb_en                       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_atbsel_onehot                -clock vclk_ana
#config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_bscan_ac                     -clock vclk_ana
#config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_bscan_ce                     -clock vclk_ana
#config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_bscan_pc                     -clock vclk_ana
#config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_bscan_pdn                    -clock vclk_ana
#config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_bscan_pdp                    -clock vclk_ana
#config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_bscan_a                      -clock vclk_ana
#config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_bscan_ce                     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_clk_gate_en            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_disable_1ol            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_disable_2ol            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_fphl_start             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_fphl_timer_acc_val     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_fphl_timer_del_val     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_fphl_timer_tr1_val     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_fphl_timer_tr2_val     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_fphl_timer_tr3_val     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_gain_2ol_val_req       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_int_max_2ol_clr_en     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_int_threshold_2ol      -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_iq_offset              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_iq_offset_load_pulse   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_pi_ctrl_inv            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_pi_ovrd_down           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_pi_ovrd_en             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_pi_ovrd_up             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_pi_val_req             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_reset_hold             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_reset_n                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_scanclk                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_scanen                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_scanen_cg              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_scanin                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_scanmode               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_update_rate_1ol        -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_update_rate_2ol        -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_ctle_current_adj             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cya                          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_data_width                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_dfe_eq_en                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_dfe_eq_en_del                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_dfe_eq_tap1_pol              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_dfe_eq_tap2_en               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_dfe_eq_tap3_en               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_dfe_eq_tap4_en               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_dfe_eq_tap5_en               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_dfe_error_threshold          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_dfe_error_threshold_pol      -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_dfe_offset_dac_en            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_dfe_pattern_filter_sel       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_dfe_rpc_div_ctrl             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_dfe_tap_1_coef               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_dfe_tap_2_coef               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_dfe_tap_3_coef               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_dfe_tap_4_coef               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_dfe_tap_5_coef               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_e_pi_cml2cmos_en             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_epath_en                     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_epath_en_del                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_eye_surf_pi_dist             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_eye_surf_pi_down_req         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_eye_surf_pi_up_req           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_eye_surf_run                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_fe_attenuation               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_fe_cm_adj                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_fe_lfeq_en                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_fe_nqst_sel                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_fe_offset_adj                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_fe_offset_range_low          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_fe_peaking_amp_gain          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_fe_res_code                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_fe_term2ground               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_fe_vga_flat                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_fe_vga_gain                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_fe_vga_ind_bypass            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_fe_vreg_high                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_iptat_tune                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_lfeq_gain                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_lfeq_zero_freq               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_lpbk_recovered_clk_en        -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_lpbk_recovered_clk_sel       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_lpbk_serial_en               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_mux_diagctrl_global_ovr      -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_mux_diagctrl_overen          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_pam3_en                      -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_pi_cml2cmos_cur_adj          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_pi_cml2cmos_en               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_pi_en                        -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_pi_en_del                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_pi_mixer_cur_adj             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_pi_negcap_en                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_pi_rate_sel                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_rx_clk_reset_n               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_rx_en                        -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_rx_en_del                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sampler_clk_rst_n            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sampler_latch_cal_en         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sampler_latch_cal_even_m_en  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sampler_latch_cal_even_p_en  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sampler_latch_cal_odd_m_en   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sampler_latch_cal_odd_p_en   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sampler_offset_e_dac         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sampler_offset_i_dac         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sampler_offset_q_dac         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_cal_0_clk                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_cal_0_code                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_cal_0_en                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_cal_0_up                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_cal_1_clk                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_cal_1_code                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_cal_1_en                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_cal_1_up                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_cal_halfgain              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_clk_bypass                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_clk_in                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_dcpath_en                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_en                        -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_en_del                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_invert_samplers           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_onecomp_mode_en           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_siglvl_n                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_squelch_pulse_none        -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_vga_current_adj              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_atb_core_en                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_atbsel_onehot                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_cm_sense_clk                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_cm_sense_en                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_cm_sense_en_del              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_cm_sense_vref_dac            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_cya                          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_dat_buf_en                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_dat_buf_en_del               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_data_width                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_dc_cal_act_en                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_dc_cal_act_negcode           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_dc_cal_act_poscode           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_dc_cal_act_range             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_dc_cal_act_sign              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_dc_cal_act_strobe            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_dc_cal_en                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_dc_cal_en_del                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_cmn_mode_en              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_cmn_mode_hiz             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_en                       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_en_del                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_idle_lowi_en             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_main_odd                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_mgn_odd                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_post_dis_one             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_post_emp_end             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_post_emp_odd             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_post_emp_start           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_post_emp_zero            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_post_main_start          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_post_main_zero           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_post_mgn_zero            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_postemph_en              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_pre1_dis_one             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_pre1_emp_end             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_pre1_emp_start           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_pre1_emp_zero            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_pre1_main_start          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_pre1_main_zero           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_pre1_mgn_zero            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_pre2_dis_one             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_pre2_emp_end             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_pre2_emp_start           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_pre2_emp_zero            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_pre2_main_start          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_pre2_main_zero           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_pre2_mgn_zero            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_pre_emp_odd              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_predrv_pullup            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_preemph1_en              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_preemph2_en              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_scanclk                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_scanen                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_scanin                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_scanmode                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_lpbk_line_en                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_lpbk_post_drv_en             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_lpbk_recovered_clk_en        -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_lpbk_serial_en               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_rcvdet_and_orb               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_rcvdet_en                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_rcvdet_ref_clk               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_rcvdet_start                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_rcvdet_vref_dac              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_ser_dat                      -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_ser_en                       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_ser_en_del                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_ser_loaddelay                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_test_chain_clk               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_test_chain_clk_sel           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_test_chain_en                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_test_chain_in                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_ckpath_qcc_cali_en         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_ckpath_qcc_cali_en_del     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_clk_sel                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_cmp_clk                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_curr_adj_iqgen             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_decap_en                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_decap_en_del               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_en                         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_en_del                     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_ipath_skew                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_iqgen_div_rst_n            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_qpath_skew                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_ratesel_iqgen              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_rx_fe_cali_en              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_rx_fe_cali_en_del          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_tx_clk_div_en              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_tx_clk_div_sel             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_tx_clk_en                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_tx_clk_en_del              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_tx_clk_reset_n             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_tx_clk_sel                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_tx_dcc_cali_en             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_tx_dcc_cali_en_del         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_txser_sel                  -clock vclk_ana

config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_pulse_low                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_clkp_1_left                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_clkn_0_left                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_clkp_0_left                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_clkn_1_left                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_tx_dcc_comp_out            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_rx_fe_comp_out             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_ckpath_qcc_comp_out        -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_pulse_none                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_cya_out                      -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_cal_0_comp                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_pulse_high                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_cal_1_comp                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_eye_surf_pi_ack              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_int_max_2ol            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_gain_2ol_val_ack       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_fphl_locked            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_eye_plot_pi_val        -clock vclk_ana


config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_0p5ui_mode_en                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_atb_en                       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_atbsel_onehot                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_clk_gate_en            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_disable_1ol            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_disable_2ol            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_fphl_start             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_fphl_timer_acc_val     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_fphl_timer_del_val     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_fphl_timer_tr1_val     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_fphl_timer_tr2_val     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_fphl_timer_tr3_val     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_gain_2ol_val_req       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_int_max_2ol_clr_en     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_int_threshold_2ol      -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_iq_offset              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_iq_offset_load_pulse   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_pi_ctrl_inv            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_pi_ovrd_down           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_pi_ovrd_en             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_pi_ovrd_up             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_pi_val_req             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_reset_hold             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_reset_n                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_scanclk                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_scanen                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_scanen_cg              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_scanin                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_scanmode               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_update_rate_1ol        -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_update_rate_2ol        -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_ctle_current_adj             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cya                          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_data_width                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_dfe_eq_en                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_dfe_eq_en_del                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_dfe_eq_tap1_pol              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_dfe_eq_tap2_en               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_dfe_eq_tap3_en               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_dfe_eq_tap4_en               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_dfe_eq_tap5_en               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_dfe_error_threshold          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_dfe_error_threshold_pol      -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_dfe_offset_dac_en            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_dfe_pattern_filter_sel       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_dfe_rpc_div_ctrl             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_dfe_tap_1_coef               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_dfe_tap_2_coef               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_dfe_tap_3_coef               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_dfe_tap_4_coef               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_dfe_tap_5_coef               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_e_pi_cml2cmos_en             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_epath_en                     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_epath_en_del                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_eye_surf_pi_dist             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_eye_surf_pi_down_req         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_eye_surf_pi_up_req           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_eye_surf_run                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_fe_attenuation               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_fe_cm_adj                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_fe_lfeq_en                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_fe_nqst_sel                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_fe_offset_adj                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_fe_offset_range_low          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_fe_peaking_amp_gain          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_fe_res_code                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_fe_term2ground               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_fe_vga_flat                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_fe_vga_gain                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_fe_vga_ind_bypass            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_fe_vreg_high                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_iptat_tune                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_lfeq_gain                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_lfeq_zero_freq               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_lpbk_recovered_clk_en        -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_lpbk_recovered_clk_sel       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_lpbk_serial_en               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_mux_diagctrl_global_ovr      -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_mux_diagctrl_overen          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_pam3_en                      -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_pi_cml2cmos_cur_adj          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_pi_cml2cmos_en               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_pi_en                        -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_pi_en_del                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_pi_mixer_cur_adj             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_pi_negcap_en                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_pi_rate_sel                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_rx_clk_reset_n               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_rx_en                        -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_rx_en_del                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sampler_clk_rst_n            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sampler_latch_cal_en         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sampler_latch_cal_even_m_en  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sampler_latch_cal_even_p_en  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sampler_latch_cal_odd_m_en   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sampler_latch_cal_odd_p_en   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sampler_offset_e_dac         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sampler_offset_i_dac         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sampler_offset_q_dac         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_cal_0_clk                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_cal_0_code                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_cal_0_en                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_cal_0_up                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_cal_1_clk                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_cal_1_code                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_cal_1_en                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_cal_1_up                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_cal_halfgain              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_clk_bypass                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_clk_in                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_dcpath_en                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_en                        -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_en_del                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_invert_samplers           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_onecomp_mode_en           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_siglvl_n                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_squelch_pulse_none        -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_vga_current_adj              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_atb_core_en                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_atbsel_onehot                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_cm_sense_clk                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_cm_sense_en                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_cm_sense_en_del              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_cm_sense_vref_dac            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_cya                          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_dat_buf_en                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_dat_buf_en_del               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_data_width                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_dc_cal_act_en                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_dc_cal_act_negcode           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_dc_cal_act_poscode           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_dc_cal_act_range             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_dc_cal_act_sign              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_dc_cal_act_strobe            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_dc_cal_en                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_dc_cal_en_del                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_cmn_mode_en              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_cmn_mode_hiz             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_en                       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_en_del                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_idle_lowi_en             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_main_odd                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_mgn_odd                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_post_dis_one             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_post_emp_end             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_post_emp_odd             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_post_emp_start           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_post_emp_zero            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_post_main_start          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_post_main_zero           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_post_mgn_zero            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_postemph_en              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_pre1_dis_one             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_pre1_emp_end             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_pre1_emp_start           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_pre1_emp_zero            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_pre1_main_start          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_pre1_main_zero           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_pre1_mgn_zero            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_pre2_dis_one             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_pre2_emp_end             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_pre2_emp_start           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_pre2_emp_zero            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_pre2_main_start          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_pre2_main_zero           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_pre2_mgn_zero            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_pre_emp_odd              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_predrv_pullup            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_preemph1_en              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_preemph2_en              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_scanclk                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_scanen                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_scanin                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_scanmode                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_lpbk_line_en                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_lpbk_post_drv_en             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_lpbk_recovered_clk_en        -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_lpbk_serial_en               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_rcvdet_and_orb               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_rcvdet_en                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_rcvdet_ref_clk               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_rcvdet_start                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_rcvdet_vref_dac              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_ser_dat                      -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_ser_en                       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_ser_en_del                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_ser_loaddelay                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_test_chain_clk               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_test_chain_clk_sel           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_test_chain_en                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_test_chain_in                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_ckpath_qcc_cali_en         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_ckpath_qcc_cali_en_del     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_clk_sel                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_cmp_clk                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_curr_adj_iqgen             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_decap_en                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_decap_en_del               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_en                         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_en_del                     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_ipath_skew                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_iqgen_div_rst_n            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_qpath_skew                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_ratesel_iqgen              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_rx_fe_cali_en              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_rx_fe_cali_en_del          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_tx_clk_div_en              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_tx_clk_div_sel             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_tx_clk_en                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_tx_clk_en_del              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_tx_clk_reset_n             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_tx_clk_sel                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_tx_dcc_cali_en             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_tx_dcc_cali_en_del         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_txser_sel                  -clock vclk_ana

config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_pulse_low                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.ana_clkp_1_left                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.ana_clkn_0_left                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.ana_clkp_0_left                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.ana_clkn_1_left                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_tx_dcc_comp_out            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_rx_fe_comp_out             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_ckpath_qcc_comp_out        -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_pulse_none                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_cya_out                      -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_cal_0_comp                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_pulse_high                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_cal_1_comp                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_eye_surf_pi_ack              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_int_max_2ol            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_gain_2ol_val_ack       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_fphl_locked            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_eye_plot_pi_val        -clock vclk_ana


config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_bias_cur_adj                              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_bias_bg_start_hyst_dis                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_ibiascal_trim_code                        -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_bias_bandgap_en                           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_bias_bandgap_en_del                       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_bias_en                                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_rescal_trim_code_tx                       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_rescal_trim_code_rx                       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_rescal_vext_trim_code_tx                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_rescal_vext_trim_code_rx                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_bias_bgcal_en                             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_bias_bgcal_up                             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_bias_bgcal_azsel                          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_bias_bg_start_adj                         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_bias_filt_byp                             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_bias_chopper_en                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_ibiascal_en                               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_ibiascal_en_del                           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_ibiascal_code                             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_rescal_en_rx                              -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_rescal_en_tx_dseg                         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_rescal_en_tx_useg                         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_rescal_en_del_rx                          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_rescal_en_del_tx_dseg                     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_rescal_en_del_tx_useg                     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_rescal_code_rx                            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_rescal_code_tx_dseg_bin                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_rescal_code_tx_useg_bin                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_en                                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_en_del                               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_rst_n                                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_rst_n_del                            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_bw_cal_en                            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_bw_cal_vsel                          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0_en                         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0_div_frac_sel               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0_div_frac                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0_div_high                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0_div_low                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog1_en                         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog1_div_frac_sel               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog1_div_frac                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog1_div_high                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog1_div_low                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_fb_div_high                          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_fb_div_low                           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_precharge_en                         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_fb_divider_clk_sel                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_fb_divider_clk_div                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_vreg_adj                             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_vreg_ref_sel                         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_vreg_sf_cur_inc                      -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_vreg_vco_ref_sel                     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_vreg_vco_sf_cur_inc                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_vco_cal_en                           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_vco_cal_code                         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_var_trm_cal_en                       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_var_trm_cal_code                     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_tmp_trm_cp_ref                       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_tmp_trm_vref_filter_bypass           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_vco_bias_current_trim                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_cp_int_cap_adj                       -clock vclk_ana  
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_cp_int_cur_adj                       -clock vclk_ana  
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_cp_prop_cap_adj                      -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_cp_prop_cur_adj                      -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_cp_vref_tune                         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_cp_prop_samp_en                      -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_filt_r_adj                           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_filt_c_adj                           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_pfd_rst_dly                          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_ref_clk_sel                          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_ref_clk_div_sel                      -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_ptat_cal_dis                         -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_vco_10g_en                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_lcvco_roffset                        -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_lcvco_propref_byp_en                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_lcvco_propref_byp_a                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_lcvco_propref_byp_b                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_vrefout_en                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_vref_filt_en                         -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_vreg_en                              -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_vreg_en_del                          -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_cppd                                 -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_cpencp                               -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_cpensb                               -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_vcovctrlinitialize                   -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_vcofilterbypass                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_vcofixedcurrentmodectrl              -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_fbdiv_pwr_en                         -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_prog_div_en                          -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_fbdiv_pwr_en_dly                     -clock vclk_ana  
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_prog_div_en_dly                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_fbdiv_rst_n                          -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_vcobuf_en                            -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_upfrc                                -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_dnfrc                                -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_lock_det_en                          -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_prog_div_rst_n                       -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_post_div_rst_n                       -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_vregana_adj                          -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_vregvref_adj                         -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_vrefdig_sel                          -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_vrefana_sel                          -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_vreg_sf_cur_inc                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_vregvco_sf_cur_inc                   -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_pfdpd                                -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_pfdpwctrl                            -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_upfrcval                             -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_dnfrcval                             -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_pfdrstdctl                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_cpsbampr                             -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_cpsel                                -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_cpisbctrl                            -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_cpbiasctl                            -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_cpsbptatr                            -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_lpfctl                               -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_lpfreset                             -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_lpfcpctl                             -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_vcohfmf                              -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_vcofixedcurrentctrl                  -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_vcofilterbwtrim                      -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_vcoinitializevco                     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_vcokvcoctrl                          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_vcovctrlinittrimonehot               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_lock_det_depth                       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_post_div                             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_fbdiv_high                           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_fbdiv_low                            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_clk_prog0_div_en                     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_clk_prog1_div_en                     -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_clk_prog0_en                         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_clk_prog0_div_frac_sel               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_clk_prog0_div_frac                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_clk_prog0_div_high                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_clk_prog0_div_low                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_clk_prog1_en                         -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_clk_prog1_div_frac_sel               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_clk_prog1_div_frac                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_clk_prog1_div_high                   -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_clk_prog1_div_low                    -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_ref_clk_sel                          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_ref_clk_div_sel                      -clock vclk_ana  
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_sd_clk_en                                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_sd_clk_cal_en                             -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_sd_clk_cal_code                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_sd_clk_buf_en_l                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_sd_clk_buf_en_r                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_tx_clk_reset_rel                          -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_clkdist_buf_en_1                          -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_clkdist_buf_en_1_del                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_clkdist_buf_en_0                          -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_clkdist_buf_en_0_del                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_atb_ref_clk0_en                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_atb_ref_clk1_en                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_atbsel_onehot                             -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_atb_core_en                               -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_atb_core_0                                -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_atb_core_1                                -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_atba2d_en                                 -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_atba2d_start                              -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_atba2d_en_off_cor                         -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_atba2d_clk_div_sel                        -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_atba2d_frc_val                            -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_atba2d_off_byp_en                         -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_atba2d_off_adj_byp                        -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_atba2d_adcmode                            -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_mom_osc_cur_sel                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_mom_osc_en                                -clock vclk_ana  
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_mom_osc_en_dly                            -clock vclk_ana    
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_mom_osc_rc_mode                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_mom_osc_rst_n                             -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_mom_osc_rtrim                             -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_mom_osc_flip_sel                          -clock vclk_ana        
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_mom_osc_global_flip_en                    -clock vclk_ana  
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_tmpsns_en                                 -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_tmpsns_en_del                             -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_tmpsns_rst_n                              -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_tmpsns_cur_avg_sel                        -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_tmpsns_ref_cur_sel                        -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_tmpsns_comp_ref_sel                       -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_tmpsns_sdm_clk_div                        -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_tmpsns_cur_mirr_sw_en                     -clock vclk_ana   
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_tmpsns_dis_amp_ctrl                       -clock vclk_ana  


config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ana_tx_clk_reset_rel_out_r                      -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ana_tx_clk_reset_rel_out_l                      -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ana_clk_m_0_out                                 -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_gpana_in                                  -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmn_rext                                        -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_cmn_avdd_pwrgood                          -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_bias_bg_start_count                       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_bias_bgcal_comp                           -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_ibiascal_comp                             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_rescal_comp_tx_useg                       -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_rescal_comp_rx                            -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_locked                               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_atba2d_dvalid                             -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_atba2d_dout                               -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_cya                                       -clock vclk_ana


config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_cm_sense_en                          -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_cm_sense_en_del                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_cm_sense_vref_dac                    -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_cya                                  -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_dat_buf_en                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_dat_buf_en_del                       -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_data_width                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_dc_cal_act_en                        -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_dc_cal_act_negcode                   -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_dc_cal_act_poscode                   -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_dc_cal_act_range                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_dc_cal_act_sign                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_dc_cal_act_strobe                    -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_cmn_mode_en                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_cmn_mode_hiz                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_en                               -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_en_del                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_idle_lowi_en                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_main_odd                         -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_mgn_odd                          -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_post_dis_one                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_post_emp_end                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_post_emp_odd                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_post_emp_start                   -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_post_emp_zero                    -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_post_main_start                  -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_post_main_zero                   -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_post_mgn_zero                    -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_postemph_en                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_pre1_dis_one                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_pre1_emp_end                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_pre1_emp_start                   -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_pre1_emp_zero                    -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_pre1_main_start                  -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_pre1_main_zero                   -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_pre1_mgn_zero                    -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_pre2_dis_one                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_pre2_emp_end                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_pre2_emp_start                   -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_pre2_emp_zero                    -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_pre2_main_start                  -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_pre2_main_zero                   -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_pre2_mgn_zero                    -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_pre_emp_odd                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_predrv_pullup                    -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_preemph1_en                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_preemph2_en                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_scanen                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_scanin                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_scanmode                         -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_lpbk_line_en                         -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_lpbk_post_drv_en                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_lpbk_recovered_clk_en                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_lpbk_serial_en                       -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_rcvdet_and_orb                       -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_rcvdet_en                            -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_rcvdet_ref_clk                       -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_rcvdet_start                         -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_rcvdet_vref_dac                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_ser_dat                              -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_ser_en                               -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_ser_en_del                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_ser_loaddelay                        -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_test_chain_clk                       -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_test_chain_clk_sel                   -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_test_chain_en                        -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_test_chain_in                        -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_bscan_a                              -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_bscan_ce                             -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_cm_sense_clk                         -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_cm_sense_en                          -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_cm_sense_en_del                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_cm_sense_vref_dac                    -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_cya                                  -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_dat_buf_en                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_dat_buf_en_del                       -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_data_width                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_dc_cal_act_en                        -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_dc_cal_act_negcode                   -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_dc_cal_act_poscode                   -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_dc_cal_act_range                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_dc_cal_act_sign                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_dc_cal_act_strobe                    -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_cmn_mode_en                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_cmn_mode_hiz                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_en                               -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_en_del                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_idle_lowi_en                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_main_odd                         -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_mgn_odd                          -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_post_dis_one                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_post_emp_end                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_post_emp_odd                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_post_emp_start                   -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_post_emp_zero                    -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_post_main_start                  -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_post_main_zero                   -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_post_mgn_zero                    -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_postemph_en                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_pre1_dis_one                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_pre1_emp_end                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_pre1_emp_start                   -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_pre1_emp_zero                    -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_pre1_main_start                  -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_pre1_main_zero                   -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_pre1_mgn_zero                    -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_pre2_dis_one                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_pre2_emp_end                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_pre2_emp_start                   -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_pre2_emp_zero                    -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_pre2_main_start                  -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_pre2_main_zero                   -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_pre2_mgn_zero                    -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_pre_emp_odd                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_predrv_pullup                    -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_preemph1_en                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_preemph2_en                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_scanclk                          -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_scanen                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_scanin                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_scanmode                         -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_lpbk_line_en                         -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_lpbk_post_drv_en                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_lpbk_recovered_clk_en                -clock vclk_ana
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_lpbk_serial_en                       -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_rcvdet_and_orb                       -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_rcvdet_en                            -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_rcvdet_start                         -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_rcvdet_vref_dac                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_ser_dat                              -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_ser_en                               -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_ser_en_del                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_ser_loaddelay                        -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_test_chain_clk_sel                   -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_test_chain_en                        -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_test_chain_in                        -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda0_decap_en                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda0_decap_en_del                       -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda0_tx_cali_en                         -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda0_tx_cali_en_del                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda0_tx_clk_div_en                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda0_tx_clk_div_sel                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda0_tx_clk_en                          -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda0_tx_clk_en_del                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda0_tx_clk_rst_n                       -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda0_tx_clk_sel                         -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda0_atb_core_en                        -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda0_atbsel_onehot                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda1_decap_en                           -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda1_decap_en_del                       -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda1_tx_cali_en                         -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda1_tx_cali_en_del                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda1_tx_clk_div_en                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda1_tx_clk_div_sel                     -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda1_tx_clk_en                          -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda1_tx_clk_en_del                      -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda1_tx_clk_rst_n                       -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda1_tx_clk_sel                         -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda1_atb_core_en                        -clock vclk_ana 
config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.xcvrda1_atbsel_onehot                      -clock vclk_ana 



# set synchronous clock groups

#---------------------------------------------------------------------------------------------------------------------------------#
#                                                         False paths                                                             #
#---------------------------------------------------------------------------------------------------------------------------------#
#config_rtlds -signal -false_path -through {u_dtb_mux.dtb_data} -to {u_pcs_top.u_phy_pcs_reg_ctrl.u_pcs_cdb_reg.sys_prdata}
#config_rtlds -signal -false_path                               -to {dtb_data}

#config_rtlds -signal -false_path -to {cmnda_vclk}
#config_rtlds -signal -false_path -to {vclk}

# RxStatus drivers on RefClk
config_rtlds -signal -false_path -from u_mp_pcs_top_ln_0.mp_pcs_original.i_rcv_det.ref_rx_status
config_rtlds -signal -false_path -from u_mp_pcs_top_ln_1.mp_pcs_original.i_rcv_det.ref_rx_status

# Clock is off at destination when source changes value
config_rtlds -signal -false_path -from u_mp_pcs_top_ln_0.mp_pcs_serdes.i_pwr_rate_ctrl.cur_pipe_rate -to pipe7_l00_rx_data
config_rtlds -signal -false_path -from u_mp_pcs_top_ln_1.mp_pcs_serdes.i_pwr_rate_ctrl.cur_pipe_rate -to pipe7_l01_rx_data


# CTC buffer related
config_rtlds -signal -false_path -from "u_mp_pcs_top_ln_0.mp_pcs_original.i_rpcs.i_rctc.fifo_reg\[*\]"
config_rtlds -signal -false_path -from "u_mp_pcs_top_ln_1.mp_pcs_original.i_rpcs.i_rctc.fifo_reg\[*\]"

config_rtlds -signal -false_path -from "u_mp_pcs_top_ln_0.mp_pcs_original.i_rpcs.i_128b_rctc.fifo_reg\[*\]"
config_rtlds -signal -false_path -from "u_mp_pcs_top_ln_1.mp_pcs_original.i_rpcs.i_128b_rctc.fifo_reg\[*\]"
#check_cdc -signal_config -add_false_path -from "u_mp_pcs_top_ln_1.mp_pcs_original.i_rpcs.i_rctc.fifo_reg\[*\]\[*\]"

# Isolation register read paths
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_0.u_pcs_iso_mb.rx_word0_0 -to u_pcs_iso_ctrl_ln_0.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_0.u_pcs_iso_mb.rx_word0_1 -to u_pcs_iso_ctrl_ln_0.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_0.u_pcs_iso_mb.rx_word0_2 -to u_pcs_iso_ctrl_ln_0.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_0.u_pcs_iso_mb.rx_word1_0 -to u_pcs_iso_ctrl_ln_0.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_0.u_pcs_iso_mb.rx_word1_1 -to u_pcs_iso_ctrl_ln_0.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_0.u_pcs_iso_mb.rx_word1_2 -to u_pcs_iso_ctrl_ln_0.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_0.u_pcs_iso_mb.rx_word2_0 -to u_pcs_iso_ctrl_ln_0.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_0.u_pcs_iso_mb.rx_word2_1 -to u_pcs_iso_ctrl_ln_0.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_0.u_pcs_iso_mb.rx_word2_2 -to u_pcs_iso_ctrl_ln_0.cdb_prdata

config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_1.u_pcs_iso_mb.rx_word0_0 -to u_pcs_iso_ctrl_ln_1.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_1.u_pcs_iso_mb.rx_word0_1 -to u_pcs_iso_ctrl_ln_1.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_1.u_pcs_iso_mb.rx_word0_2 -to u_pcs_iso_ctrl_ln_1.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_1.u_pcs_iso_mb.rx_word1_0 -to u_pcs_iso_ctrl_ln_1.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_1.u_pcs_iso_mb.rx_word1_1 -to u_pcs_iso_ctrl_ln_1.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_1.u_pcs_iso_mb.rx_word1_2 -to u_pcs_iso_ctrl_ln_1.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_1.u_pcs_iso_mb.rx_word2_0 -to u_pcs_iso_ctrl_ln_1.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_1.u_pcs_iso_mb.rx_word2_1 -to u_pcs_iso_ctrl_ln_1.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_1.u_pcs_iso_mb.rx_word2_2 -to u_pcs_iso_ctrl_ln_1.cdb_prdata

config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_2.u_pcs_iso_mb.rx_word0_0 -to u_pcs_iso_ctrl_ln_2.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_2.u_pcs_iso_mb.rx_word0_1 -to u_pcs_iso_ctrl_ln_2.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_2.u_pcs_iso_mb.rx_word0_2 -to u_pcs_iso_ctrl_ln_2.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_2.u_pcs_iso_mb.rx_word1_0 -to u_pcs_iso_ctrl_ln_2.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_2.u_pcs_iso_mb.rx_word1_1 -to u_pcs_iso_ctrl_ln_2.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_2.u_pcs_iso_mb.rx_word1_2 -to u_pcs_iso_ctrl_ln_2.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_2.u_pcs_iso_mb.rx_word2_0 -to u_pcs_iso_ctrl_ln_2.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_2.u_pcs_iso_mb.rx_word2_1 -to u_pcs_iso_ctrl_ln_2.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_2.u_pcs_iso_mb.rx_word2_2 -to u_pcs_iso_ctrl_ln_2.cdb_prdata

config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_3.u_pcs_iso_mb.rx_word0_0 -to u_pcs_iso_ctrl_ln_3.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_3.u_pcs_iso_mb.rx_word0_1 -to u_pcs_iso_ctrl_ln_3.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_3.u_pcs_iso_mb.rx_word0_2 -to u_pcs_iso_ctrl_ln_3.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_3.u_pcs_iso_mb.rx_word1_0 -to u_pcs_iso_ctrl_ln_3.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_3.u_pcs_iso_mb.rx_word1_1 -to u_pcs_iso_ctrl_ln_3.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_3.u_pcs_iso_mb.rx_word1_2 -to u_pcs_iso_ctrl_ln_3.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_3.u_pcs_iso_mb.rx_word2_0 -to u_pcs_iso_ctrl_ln_3.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_3.u_pcs_iso_mb.rx_word2_1 -to u_pcs_iso_ctrl_ln_3.cdb_prdata
config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_3.u_pcs_iso_mb.rx_word2_2 -to u_pcs_iso_ctrl_ln_3.cdb_prdata

# tx_swing & tx_margin
config_rtlds -signal -false_path -from u_mp_pcs_top_ln_0.message_bus.u_cdnsdru_usb4_message_bus_gen_reg_ctrl_v4.phy_reg408
config_rtlds -signal -false_path -from u_mp_pcs_top_ln_1.message_bus.u_cdnsdru_usb4_message_bus_gen_reg_ctrl_v4.phy_reg408

# Async PIPE pins
config_rtlds -signal -false_path -to pipe7_l00_rx_elec_idle
config_rtlds -signal -false_path -to pipe7_l01_rx_elec_idle
config_rtlds -signal -false_path -to pipe4_l00_rx_elec_idle
config_rtlds -signal -false_path -to pipe4_l01_rx_elec_idle

# ---------------------------------------------------------------------------------------------------------------------------------#
#                                                   Mutually exclusive signals                                                     #
# ---------------------------------------------------------------------------------------------------------------------------------#

config_rtlds -signal -exclusive {pipe7_l00_rate[0] \
                                 pipe7_l00_rate[1] \
                                 pipe7_l01_rate[0] \
                                 pipe7_l01_rate[1] \
                                 pipe7_l00_powerdown[0] \
                                 pipe7_l00_powerdown[1] \
                                 pipe7_l00_powerdown[2] \
                                 pipe7_l01_powerdown[0] \
                                 pipe7_l01_powerdown[1] \
                                 pipe7_l01_powerdown[2]}

# need confirm m2p_msg_start/phy_pipe_ctrl_sts[7]
config_rtlds -signal -exclusive {u_pcs_iso_ctrl_ln_0.phy_pipe_lm_ctrl_sts[0] \
                                 u_pcs_iso_ctrl_ln_0.phy_pipe_lm_ctrl_sts[1] \
                                 u_pcs_iso_ctrl_ln_0.phy_pipe_lm_ctrl_sts[2] \
                                 u_pcs_iso_ctrl_ln_0.phy_pipe_lm_ctrl_sts[3] \
                                 u_pcs_iso_ctrl_ln_0.phy_pipe_lm_ctrl_sts[4] \
                                 u_pcs_iso_ctrl_ln_0.u_psync_pipe_mb_rx_eq_eval_cmpl.data_toggle \
                                 u_pcs_iso_ctrl_ln_0.u_psync_pipe_mb_phy_iorecal_request.data_toggle \
                                 u_pcs_iso_ctrl_ln_0.u_psync_pipe_mb_iorecal_done.data_toggle \
                                 u_pcs_iso_ctrl_ln_0.u_psync_pipe_mb_rx_eq_training_cmpl_stb.data_toggle \
                                 u_pcs_iso_ctrl_ln_0.m2p_msg_start \
                                 u_pcs_iso_ctrl_ln_0.phy_pipe_ctrl_sts[7] \
                                 u_pma_iso_ctrl_ln_1.phy_pma_rx_mrgn_ctrl[16] \
                                 u_pma_iso_ctrl_ln_1.phy_pma_xcvr_ctrl_reg[18] \
                                 u_mp_pma.rx_signal_detect_ln_0}

config_rtlds -signal -exclusive {u_pcs_iso_ctrl_ln_1.phy_pipe_lm_ctrl_sts[0] \
                                 u_pcs_iso_ctrl_ln_1.phy_pipe_lm_ctrl_sts[1] \
                                 u_pcs_iso_ctrl_ln_1.phy_pipe_lm_ctrl_sts[2] \
                                 u_pcs_iso_ctrl_ln_1.phy_pipe_lm_ctrl_sts[3] \
                                 u_pcs_iso_ctrl_ln_1.phy_pipe_lm_ctrl_sts[4] \
                                 u_pcs_iso_ctrl_ln_1.u_psync_pipe_mb_rx_eq_eval_cmpl.data_toggle \
                                 u_pcs_iso_ctrl_ln_1.u_psync_pipe_mb_phy_iorecal_request.data_toggle \
                                 u_pcs_iso_ctrl_ln_1.u_psync_pipe_mb_iorecal_done.data_toggle \
                                 u_pcs_iso_ctrl_ln_1.u_psync_pipe_mb_rx_eq_training_cmpl_stb.data_toggle \
                                 u_pcs_iso_ctrl_ln_1.m2p_msg_start \
                                 u_pcs_iso_ctrl_ln_1.phy_pipe_ctrl_sts[7] \
                                 u_pma_iso_ctrl_ln_2.phy_pma_rx_mrgn_ctrl[16] \
                                 u_pma_iso_ctrl_ln_2.phy_pma_xcvr_ctrl_reg[18] \
                                 u_mp_pma.rx_signal_detect_ln_1}
#---------------------------------------------------------------------------------------------------------------------------------#
#                                                     Define synchronizers                                                        #
#---------------------------------------------------------------------------------------------------------------------------------#
#check_cdc -scheme -add fifo -map {{Wfull push_full} {Rempty pop_empty} {Winc push} {Rinc pop} \
#                                  {Wptr wptr_gray} {Rptr rptr_gray} {Wdata pushd} {Rdata popd}} \
#                                   -module cdnsdru_async_fifo_v0$SUFFIX

check_cdc -scheme -add ndff -map {{dout dest_dat} {data source_dat}} -module phy_mb_data_sync$SUFFIX                                  
check_cdc -scheme -add ndff -map {{dout d_out} {data d_in}} -module phy_data_sync$SUFFIX
check_cdc -scheme -add ndff -map {{dout reset_out_n} {data reset_in_n}} -module phy_reset_sync$SUFFIX

# Signals which are gray coded
#check_cdc -signal_config -add_gray_code {
#                                         u_pcs_top.u_rx_top.utmi_rx_intf_i.rx_buffer.wptr_gray[0] \
#                                         u_pcs_top.u_rx_top.utmi_rx_intf_i.rx_buffer.wptr_gray[1] \
#                                         u_pcs_top.u_rx_top.utmi_rx_intf_i.rx_buffer.wptr_gray[2] \
#                                         u_pcs_top.u_rx_top.utmi_rx_intf_i.rx_buffer.wptr_gray[3] 
#                                         }
