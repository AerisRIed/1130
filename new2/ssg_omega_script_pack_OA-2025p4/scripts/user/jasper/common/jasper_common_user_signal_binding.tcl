################################################################################
# Copyright (c) 2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design #
# Systems Inc. They may not be modified, copied, reproduced, distributed, or   #
# disclosed to third parties in any manner, medium, or form, in whole or in    #
# part, without the prior written consent of Cadence Design Systems Inc.       #
################################################################################
set hier_path ""
#########################################################
# Define reset and hard macro port bindings for all	#
# Jasper Apps. Anything using the "config_rtlds"	#
# command with either "-reset" or "-port" should occur	#
# in this file.						#
#########################################################
if {$prl_run_superlint == 1} {
    puts "Run lint"
} else {
    puts "Run CDC/RDC"
    set SUFFIX ""
    
    # below content should be same as cdc_rdc_phy/constraint.tcl 
    set hier_path ""
    
    set SRAM_DEPTH              14
    set PHY_SCAN_IN_WIDTH       15
    set PHY_SCAN_OUT_WIDTH      15
    set PMA_CMN_SCAN_IN_WIDTH   39
    set PMA_CMN_SCAN_OUT_WIDTH  39
    set PMA_XCVR_SCAN_IN_WIDTH  89
    set PMA_XCVR_SCAN_OUT_WIDTH 89
    
    # 
    set USB_DP_SEL 0
    
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
    clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_clk
    clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_ser_clk
    clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_sd_clk
    clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_ser_clk
    
    
    #--- Setup virtual clocks ---#
    check_cdc -clock_domain -virtual_clock vclk
    check_cdc -clock_domain -virtual_clock vclk_bump
    check_cdc -clock_domain -virtual_clock vclk_scan
    check_cdc -clock_domain -virtual_clock vclk_ana
    check_cdc -clock_domain -virtual_clock vclk_ana_only
    check_cdc -clock_domain -virtual_clock vclk_uc_reset_n
    check_cdc -clock_domain -virtual_clock vclk_phy_reset_n
    check_cdc -clock_domain -virtual_clock vclk_pipe4_reset_n
    check_cdc -clock_domain -virtual_clock vclk_pipe7_reset_n
    check_cdc -clock_domain -virtual_clock vclk_dp_reset_n
    
    clock vclk
    clock vclk_bump
    clock vclk_scan
    clock vclk_ana
    clock vclk_ana_only
    clock vclk_uc_reset_n
    clock vclk_phy_reset_n
    clock vclk_pipe4_reset_n
    clock vclk_pipe7_reset_n
    clock vclk_dp_reset_n
    
    config_rtlds -clock -group -sync {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0 pipe7_l00_clk pipe7_l01_clk}
    config_rtlds -clock -group -sync {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_clk_prog0 pma_tx_td_clk}
    
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
    
    #---------------------------------------------------------------------------------------------------------------------------------#
    #                                                   Static PHY inputs                                                             #
    #---------------------------------------------------------------------------------------------------------------------------------#
    #UTMI Related signals which should be stable for a long time before used.
    #config_rtlds -signal -static "${hier_path}typec_conn_dir"
    
    config_rtlds -signal -static "${hier_path}phy_mode"
    config_rtlds -signal -static "${hier_path}pipe4_eb_mode"
    
    config_rtlds -signal -static "${hier_path}pma_xcvr_data_width"

    config_rtlds -signal -static "${hier_path}pipe4_l00_rx_termination"
    config_rtlds -signal -static "${hier_path}pipe4_l01_rx_termination"

    config_rtlds -signal -static "${hier_path}pipe7_l00_rx_termination"
    config_rtlds -signal -static "${hier_path}pipe7_l01_rx_termination"
    
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
    
    # standardmode
    #config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_iso_lane_mode_reg\[22\] 0}}]
    #config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_iso_lane_mode_reg\[21\] 0}}]
    #config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_iso_lane_mode_reg\[20\] 0}}]
    
    # set u_phy_clkrst.pipe7_pma_tx_td_clk_ln_0 and u_phy_clkrst.int_pma_tx_td_clk_ln_01 sel to 0
    config_rtlds -signal -constant [subst {{${hier_path}u_pcs_iso_ctrl_cmn.phy_pma_lane_map_reg\[12\] $USB_DP_SEL}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pcs_iso_ctrl_cmn.phy_pma_lane_map_reg\[8\]  $USB_DP_SEL}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pcs_iso_ctrl_cmn.phy_pma_lane_map_reg\[4\]  $USB_DP_SEL}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pcs_iso_ctrl_cmn.phy_pma_lane_map_reg\[0\]  $USB_DP_SEL}}]
    
    # set u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.rxda_des_clk_invert_sel to 0
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_rxclk_ctrl_reg\[15\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_rxclk_ctrl_reg\[15\] 0}}]
    
    # set u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.txda_des_clk_invert_sel to 0
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_txclk_ctrl_reg\[15\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_txclk_ctrl_reg\[15\] 0}}]

    # set pma lopback to constant to set u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.u_clock_mux_v0_rx_rd_clk.clk_sel
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_xcvr_ctrl_reg\[1\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_xcvr_ctrl_reg\[2\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_xcvr_ctrl_reg\[4\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_xcvr_ctrl_reg\[5\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_xcvr_ctrl_reg\[6\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_xcvr_ctrl_reg\[8\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_xcvr_ctrl_reg\[18\] 1}}]
    
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_xcvr_ctrl_reg\[1\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_xcvr_ctrl_reg\[2\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_xcvr_ctrl_reg\[4\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_xcvr_ctrl_reg\[5\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_xcvr_ctrl_reg\[6\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_xcvr_ctrl_reg\[8\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_xcvr_ctrl_reg\[18\] 1}}]
    
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_xcvr_ctrl_reg\[1\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_xcvr_ctrl_reg\[2\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_xcvr_ctrl_reg\[4\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_xcvr_ctrl_reg\[5\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_xcvr_ctrl_reg\[6\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_xcvr_ctrl_reg\[8\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_xcvr_ctrl_reg\[18\] 1}}]
    
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_xcvr_ctrl_reg\[1\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_xcvr_ctrl_reg\[2\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_xcvr_ctrl_reg\[4\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_xcvr_ctrl_reg\[5\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_xcvr_ctrl_reg\[6\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_xcvr_ctrl_reg\[8\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_xcvr_ctrl_reg\[18\] 1}}]
    
    # set xcvr_stand_mode/width iso to 0
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_override_reg\[4\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_0.phy_pma_override_reg\[12\] 0}}]

    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_override_reg\[4\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_1.phy_pma_override_reg\[12\] 0}}]

    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_override_reg\[4\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_2.phy_pma_override_reg\[12\] 0}}]

    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_override_reg\[4\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pma_iso_ctrl_ln_3.phy_pma_override_reg\[12\] 0}}]

    
    # set xcvr_diag_plldrc_ctrl_reg to constant to u_mp_pma.u_pma_rev.u_xcvr_txm.U_xcvr_txonly0.u_xcvr_clkrst.u_clock_mux_cmn_pll_clk_gated.clk_sel a constant 
    # to make u_mp_pma.u_pma_rev.u_xcvr_txm.U_xcvr_txonly0.u_xcvr_clkrst.cmn_pll_clk_gated unique
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
    
    # power switch internal registers for output override
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.cmn_cdiag_xcvrc_pwri_ovrd_reg\[0\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.cmn_cdiag_xcvrc_pwri_ovrd_reg\[1\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.cmn_cdiag_xcvrc_pwri_ovrd_reg\[2\] 1}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.cmn_cdiag_xcvrc_pwri_ovrd_reg\[3\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.cmn_cdiag_xcvrc_pwri_ovrd_reg\[4\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.cmn_cdiag_xcvrc_pwri_ovrd_reg\[5\] 1}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.cmn_cdiag_xcvrc_pwri_ovrd_reg\[6\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.cmn_cdiag_xcvrc_pwri_ovrd_reg\[7\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.cmn_cdiag_xcvrc_pwri_ovrd_reg\[14\] 0}}]

    # power switch internal registers for output override
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.cmn_cdiag_ccal_pwri_ovrd_reg\[0\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.cmn_cdiag_ccal_pwri_ovrd_reg\[1\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.cmn_cdiag_ccal_pwri_ovrd_reg\[2\] 1}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.cmn_cdiag_ccal_pwri_ovrd_reg\[3\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.cmn_cdiag_ccal_pwri_ovrd_reg\[4\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.cmn_cdiag_ccal_pwri_ovrd_reg\[5\] 1}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.cmn_cdiag_ccal_pwri_ovrd_reg\[6\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.cmn_cdiag_ccal_pwri_ovrd_reg\[7\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.cmn_cdiag_ccal_pwri_ovrd_reg\[14\] 0}}]

      # power switch internal registers for output override
     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[0\] 0}}]
     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[1\] 0}}]
     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[2\] 1}}]
     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[3\] 0}}]
     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[4\] 0}}]
     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[5\] 1}}]
     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[6\] 0}}]
     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[7\] 0}}]
     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[14\] 0}}]


     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[0\] 0}}]
     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[1\] 0}}]
     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[2\] 1}}]
     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[3\] 0}}]
     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[4\] 0}}]
     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[5\] 1}}]
     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[6\] 0}}]
     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[7\] 0}}]
     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[14\] 0}}]


    # PHY APB register
    config_rtlds -signal -constant [subst {{${hier_path}u_tap_complex.u_diagnostic_ctrl_reg.pdo\[0\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_tap_complex.u_diagnostic_ctrl_reg.pdo\[1\] 1}}]

    config_rtlds -signal -constant [subst {{${hier_path}u_pcs_iso_ctrl_cmn.phy_lane_off_ctrl_reg\[8\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pcs_iso_ctrl_cmn.phy_lane_off_ctrl_reg\[3\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pcs_iso_ctrl_cmn.phy_lane_off_ctrl_reg\[2\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pcs_iso_ctrl_cmn.phy_lane_off_ctrl_reg\[1\] 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_pcs_iso_ctrl_cmn.phy_lane_off_ctrl_reg\[0\] 0}}]


    #Kaibo add begins
    #TODO: Need to review with Luke.
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_bg_cal_ctrl_apb_icfg.bgcal_filt_bypass_en 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_ibiascal_icfg.ibiascal_filt_bypass_en 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_rx_rescal_ctrl_icfg.rx_rescal_filt_bypass_en 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_pd_icfg.tx_pd_rescal_filt_bypass_en 0}}]
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_pu_icfg.tx_pu_rescal_filt_bypass_en 0}}]

    #TODO: Need to review with Ran.
    config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly?.u_tx_ctrl.u_tx_dc_cal_ctrl_apb_icfg.tx_dc_cal_filt_bypass_en 0}}]

    config_rtlds -signal -constant {{${hier_path}u_pcs_iso_ctrl_cmn.pipe_ln_reset_reg[31:16] 16'hFFFF}}
    #Kaibo add ends

    #---------------------------------------------------------------------------------------------------------------------------------#
    #                                                   Static PHY internal registers                                                 #
    #---------------------------------------------------------------------------------------------------------------------------------#
    #config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_rxclk_ctrl_reg[15]"
    #config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.xcvr_diag_rxclk_ctrl_reg[15]"
    
    config_rtlds -signal -static "${hier_path}u_mp_pcs_top_ln_0.mp_pcs_original.i_tpcs.i_datawidth.int_pma_rx_term"
    config_rtlds -signal -static "${hier_path}u_mp_pcs_top_ln_1.mp_pcs_original.i_tpcs.i_datawidth.int_pma_rx_term"

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
    # tx_local_fs_lf_valid
    config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_ln_0.phy_pipe_ctrl_sts\[6\]"
    config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_ln_2.phy_pipe_ctrl_sts\[6\]"
    # rx_valid_override(same as whistler)
    config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_ln_0.phy_pipe_ctrl_sts\[17\]"
    config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_ln_2.phy_pipe_ctrl_sts\[17\]"
    # data_path_override
    config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_ln_0.phy_pipe_ctrl_sts\[24\]"
    config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_ln_2.phy_pipe_ctrl_sts\[24\]"
    # mb destructive margining sel
    config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_ln_0.phy_pipe_ctrl_sts\[13\]"
    config_rtlds -signal -static "${hier_path}u_pcs_iso_ctrl_ln_2.phy_pipe_ctrl_sts\[13\]"
   
    #PMA reference clock disable
    config_rtlds -signal -static "${hier_path}u_pma_iso_ctrl_cmn.phy_pma_cmn_ctrl_reg\[17\]"

    #Common ready mask
    config_rtlds -signal -static "${hier_path}u_pma_iso_ctrl_cmn.phy_pma_cmn_ctrl_reg\[28\]"


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

    #PMA static
    #override config
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_vco_cal_sm_v4_top.u_vco_cal_sm_v4_cdb_regs.vcocal_ctrl_value\[15\]"

    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_ibiascal_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_ibiascal_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[6\:0\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_ibiascal_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_tune_reg\[6\:0\]"

    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_sd_clk_cal_icfg.u_vco_cal_sm_v4_top.u_vco_cal_sm_v4_cdb_regs.vcocal_ovrd_value\[15\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_sd_clk_cal_icfg.u_vco_cal_sm_v4_top.u_vco_cal_sm_v4_cdb_regs.vcocal_ovrd_value\[4\:0\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_sd_clk_cal_icfg.u_vco_cal_sm_v4_top.u_vco_cal_sm_v4_cdb_regs.vcocal_start_value\[14\:12\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_sd_clk_cal_icfg.u_vco_cal_sm_v4_top.u_vco_cal_sm_v4_cdb_regs.vcocal_start_value\[4\:0\]"

    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_*_icfg.u_tx_rescal_ctrl_*.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_*_icfg.u_tx_rescal_ctrl_*.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[6\:0\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_*_icfg.u_tx_rescal_ctrl_*.u_bin_cal_apb_cdb_regs.cal_tune_reg\[6\:0\]"

    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_rx_rescal_ctrl_icfg.u_rx_res_cal_ctrl.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_rx_rescal_ctrl_icfg.u_rx_res_cal_ctrl.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[5\:0\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_rx_rescal_ctrl_icfg.u_rx_res_cal_ctrl.u_bin_cal_apb_cdb_regs.cal_tune_reg\[5\:0\]"

    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_bg_cal_ctrl_apb_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_bg_cal_ctrl_apb_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[5\:0\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_bg_cal_ctrl_apb_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_tune_reg\[5\:0\]"

   #add by luke 2025/10/06
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_mgnhs_mult_*_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_mgnfs_mult_*_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_lf_mult_reg"
    
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_mgnhs_mult_*_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_mgnfs_mult_*_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_lf_mult_reg"

    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_mgnhs_mult_*_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_mgnfs_mult_*_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_lf_mult_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_mgnhs_mult_*_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_mgnfs_mult_*_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_lf_mult_reg"

    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_0.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_0.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[4\:0\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_0.u_bin_cal_apb_cdb_regs.cal_tune_reg\[4\:0\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_1.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_1.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[4\:0\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_1.u_bin_cal_apb_cdb_regs.cal_tune_reg\[4\:0\]"

    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_qcc_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_qcc_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[4\:0\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_qcc_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_tune_reg\[4\:0\]"

    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_ctle_vga_cal_ctrl_apb_icfg.u_bin_cal_apb_*.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_ctle_vga_cal_ctrl_apb_icfg.u_bin_cal_apb_*.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[5\:0\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_ctle_vga_cal_ctrl_apb_icfg.u_bin_cal_apb_*.u_bin_cal_apb_cdb_regs.cal_tune_reg\[5\:0\]"
    
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_0.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_0.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[4\:0\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_0.u_bin_cal_apb_cdb_regs.cal_tune_reg\[4\:0\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_1.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_1.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[4\:0\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_1.u_bin_cal_apb_cdb_regs.cal_tune_reg\[4\:0\]"

    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_qcc_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_qcc_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[4\:0\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_qcc_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_tune_reg\[4\:0\]"


    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_ctle_vga_cal_ctrl_apb_icfg.u_bin_cal_apb_*.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_ctle_vga_cal_ctrl_apb_icfg.u_bin_cal_apb_*.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[5\:0\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_ctle_vga_cal_ctrl_apb_icfg.u_bin_cal_apb_*.u_bin_cal_apb_cdb_regs.cal_tune_reg\[5\:0\]"


    # added by jinsong
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_drv_ctrl.u_tx_rcv_detect_v2_apb.u_tx_rcv_detect_v2_apb_cdb_regs.tx_rcv_detect_ctrl_reg\[15\]"
    #config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_tx_ctrl.u_tx_bist_core_apb.u_tx_bist_core_apb_cdb_regs.tx_bist_ctrl_reg\[0\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_tx_ctrl.u_tx_dc_cal_ctrl_apb_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ctrl_reg\[15\]"
    #config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_tx_ctrl.u_tx_diag_ovrd.u_tx_diag_ovrd_cdb_regs.tx_diag_sfifo_ctrl_reg\[4\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_bidi_ctrl_reg\[0\]"
    #config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_tx_ctrl.u_tx_dc_cal_ctrl_apb_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[14\]"


    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_drv_ctrl.u_tx_rcv_detect_v2_apb.u_tx_rcv_detect_v2_apb_cdb_regs.tx_rcv_detect_ctrl_reg\[15\]"
    #config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_tx_ctrl.u_tx_bist_core_apb.u_tx_bist_core_apb_cdb_regs.tx_bist_ctrl_reg\[0\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_tx_ctrl.u_tx_dc_cal_ctrl_apb_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ctrl_reg\[15\]"
    #config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_tx_ctrl.u_tx_diag_ovrd.u_tx_diag_ovrd_cdb_regs.tx_diag_sfifo_ctrl_reg\[4\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_bidi_ctrl_reg\[0\]"
    #config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_tx_ctrl.u_tx_dc_cal_ctrl_apb_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[14\]"

    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_drv_ctrl.u_tx_rcv_detect_v2_apb.u_tx_rcv_detect_v2_apb_cdb_regs.tx_rcv_detect_ctrl_reg\[15\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_cmn_clk_freq_msmt_v1_top.u_clk_freq_msmt_v1_cdb_regs.clk_freq_msmt_ctrl_reg\[15\]"
    #config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_eye_surf_ctrl_top.u_eye_surf_ctrl_cdb_regs.rx_eyesurf_ctrl\[31\]"
    #config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_bist_core_apb.u_rx_bist_core_apb_cdb_regs.rx_bist_ctrl_reg\[0\]"

    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs.rx_ree_smgm_ctrl1_reg\[3:0\]"    
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs.rx_ree_smgm_ctrl1_reg\[7:4\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs.rx_ree_smgm_ctrl1_reg\[11:8\]"
    #config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_tx_ctrl.u_tx_bist_core_apb.u_tx_bist_core_apb_cdb_regs.tx_bist_ctrl_reg\[0\]"
    #config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_tx_ctrl.u_tx_diag_ovrd.u_tx_diag_ovrd_cdb_regs.tx_diag_sfifo_ctrl_reg\[4\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_psc_ovrd_reg\[3:0\]"

    #config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_false_eye_det_wrapper.u_rx_false_eye_det_cdb_regs.rx_feye_det_ctrl_reg\[4:0\]"

    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_drv_ctrl.u_tx_rcv_detect_v2_apb.u_tx_rcv_detect_v2_apb_cdb_regs.tx_rcv_detect_ctrl_reg\[15\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_cmn_clk_freq_msmt_v1_top.u_clk_freq_msmt_v1_cdb_regs.clk_freq_msmt_ctrl_reg\[15\]"
    #config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_eye_surf_ctrl_top.u_eye_surf_ctrl_cdb_regs.rx_eyesurf_ctrl\[31\]"
    #config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_bist_core_apb.u_rx_bist_core_apb_cdb_regs.rx_bist_ctrl_reg\[0\]"

    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs.rx_ree_smgm_ctrl1_reg\[3:0\]"    
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs.rx_ree_smgm_ctrl1_reg\[7:4\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs.rx_ree_smgm_ctrl1_reg\[11:8\]"
    #config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_tx_ctrl.u_tx_bist_core_apb.u_tx_bist_core_apb_cdb_regs.tx_bist_ctrl_reg\[0\]"
    #config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_tx_ctrl.u_tx_diag_ovrd.u_tx_diag_ovrd_cdb_regs.tx_diag_sfifo_ctrl_reg\[4\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_psc_ovrd_reg\[3:0\]"

    #config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_false_eye_det_wrapper.u_rx_false_eye_det_cdb_regs.rx_feye_det_ctrl_reg\[4:0\]"

    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_power_state_ctrl_v3_rx.psc_rdy\[14:0\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_power_state_ctrl_v3_rx.psc_rdy\[14:0\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_power_state_ctrl_v3_rx.psc_cal\[14:0\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_power_state_ctrl_v3_rx.psc_cal\[14:0\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_power_state_ctrl_v3_rx.psc_a5\[14:0\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_power_state_ctrl_v3_rx.psc_a5\[14:0\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_power_state_ctrl_v3_rx.psc_a4\[14:0\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_power_state_ctrl_v3_rx.psc_a4\[14:0\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_power_state_ctrl_v3_rx.psc_a3\[14:0\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_power_state_ctrl_v3_rx.psc_a3\[14:0\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_power_state_ctrl_v3_rx.psc_a2\[14:0\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_power_state_ctrl_v3_rx.psc_a2\[14:0\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_power_state_ctrl_v3_rx.psc_a1\[14:0\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_power_state_ctrl_v3_rx.psc_a1\[14:0\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_power_state_ctrl_v3_rx.psc_a0\[14:0\]"
    config_rtlds -signal -static "${hier_path}   u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_power_state_ctrl_v3_rx.psc_a0\[14:0\]"

    #PMA override regs are set to be static.
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd.u_cmn_cdiag_ovrd_cdb_regs.cmn_cdiag_pwri_tmr_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_startup_sm_v4_top.u_startup_sm_v4_cdb_regs.ssm_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_fdiag_ovrd.u_cmn_fdiag_ovrd_cdb_regs.cmn_diag_tmpsns_filt_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl_sm_v3_top.u_pll_ctrl_sm_v3_cdb_regs.pllsm_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_clk_freq_msmt_v1_top.u_clk_freq_msmt_v1_cdb_regs.test_clk_sel_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_bg_cal_ctrl_apb_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_start_reg"    
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_clk_freq_msmt_v1_top.u_clk_freq_msmt_v1_cdb_regs.ref_clk_tmr_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_ibiascal_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_start_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_rx_rescal_ctrl_icfg.u_rx_res_cal_ctrl.u_bin_cal_apb_cdb_regs.cal_start_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_pd_icfg.u_tx_rescal_ctrl_pd.u_bin_cal_apb_cdb_regs.cal_start_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_fdiag_ovrd.u_cmn_fdiag_ovrd_cdb_regs.cmn_diag_cal_filt_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_pu_icfg.u_tx_rescal_ctrl_pu.u_bin_cal_apb_cdb_regs.cal_start_reg"

    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_bg_cal_ctrl_apb_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_init_tmr_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_bg_cal_ctrl_apb_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_iter_tmr_reg" 
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_ibiascal_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_init_tmr_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_ibiascal_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_iter_tmr_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_rx_rescal_ctrl_icfg.u_rx_res_cal_ctrl.u_bin_cal_apb_cdb_regs.cal_init_tmr_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_rx_rescal_ctrl_icfg.u_rx_res_cal_ctrl.u_bin_cal_apb_cdb_regs.cal_iter_tmr_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_pdiag_pll0_mode0_cdb_regs.cmn_pdiag_pll_prog0_clk_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_pdiag_pll0_mode0_cdb_regs.cmn_pdiag_pll_prog1_clk_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_pdiag_pll0_mode1_cdb_regs.cmn_pdiag_pll_prog0_clk_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_pdiag_pll0_mode1_cdb_regs.cmn_pdiag_pll_prog1_clk_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_pdiag_pll1_mode0_cdb_regs.cmn_pdiag_pll_prog0_clk_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_pdiag_pll1_mode0_cdb_regs.cmn_pdiag_pll_prog1_clk_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_pdiag_pll1_mode1_cdb_regs.cmn_pdiag_pll_prog0_clk_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_pdiag_pll1_mode1_cdb_regs.cmn_pdiag_pll_prog1_clk_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_ring_cmn_pll1_ctrl.u_ring_pll_ctrl_sm_v0_top.u_ring_pll_ctrl_sm_v0_cdb_regs.pllsm_ctrl1_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_sd_clk_cal_icfg.u_vco_cal_sm_v4_top.u_vco_cal_sm_v4_cdb_regs.refclk_timer_init_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_sd_clk_cal_icfg.u_vco_cal_sm_v4_top.u_vco_cal_sm_v4_cdb_regs.refclk_timer_iter_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_sd_clk_cal_icfg.u_vco_cal_sm_v4_top.u_vco_cal_sm_v4_cdb_regs.refclk_timer_start_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_pd_icfg.u_tx_rescal_ctrl_pd.u_bin_cal_apb_cdb_regs.cal_init_tmr_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_pd_icfg.u_tx_rescal_ctrl_pd.u_bin_cal_apb_cdb_regs.cal_iter_tmr_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_pu_icfg.u_tx_rescal_ctrl_pu.u_bin_cal_apb_cdb_regs.cal_init_tmr_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_pu_icfg.u_tx_rescal_ctrl_pu.u_bin_cal_apb_cdb_regs.cal_iter_tmr_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl_sm_v3_top.u_pll_ctrl_sm_v3_cdb_regs.pllsm_tmr_1_lower_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl_sm_v3_top.u_pll_ctrl_sm_v3_cdb_regs.pllsm_tmr_1_upper_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl_sm_v3_top.u_pll_ctrl_sm_v3_cdb_regs.pllsm_tmr_2_lower_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl_sm_v3_top.u_pll_ctrl_sm_v3_cdb_regs.pllsm_tmr_2_upper_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl_sm_v3_top.u_pll_ctrl_sm_v3_cdb_regs.pllsm_tmr_3_lower_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl_sm_v3_top.u_pll_ctrl_sm_v3_cdb_regs.pllsm_tmr_3_upper_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl_sm_v3_top.u_pll_ctrl_sm_v3_cdb_regs.pllsm_tmr_4_lower_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_ring_cmn_pll1_ctrl.u_ring_pll_ctrl_sm_v0_top.u_ring_pll_ctrl_sm_v0_cdb_regs.pllsm_tmr_1_upper_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_ring_cmn_pll1_ctrl.u_ring_pll_ctrl_sm_v0_top.u_ring_pll_ctrl_sm_v0_cdb_regs.pllsm_tmr_1_lower_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_ring_cmn_pll1_ctrl.u_ring_pll_ctrl_sm_v0_top.u_ring_pll_ctrl_sm_v0_cdb_regs.pllsm_tmr_2_upper_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_ring_cmn_pll1_ctrl.u_ring_pll_ctrl_sm_v0_top.u_ring_pll_ctrl_sm_v0_cdb_regs.pllsm_tmr_2_lower_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_ring_cmn_pll1_ctrl.u_ring_pll_ctrl_sm_v0_top.u_ring_pll_ctrl_sm_v0_cdb_regs.pllsm_tmr_3_upper_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_ring_cmn_pll1_ctrl.u_ring_pll_ctrl_sm_v0_top.u_ring_pll_ctrl_sm_v0_cdb_regs.pllsm_tmr_3_lower_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_ring_cmn_pll1_ctrl.u_ring_pll_ctrl_sm_v0_top.u_ring_pll_ctrl_sm_v0_cdb_regs.pllsm_tmr_4_upper_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_ring_cmn_pll1_ctrl.u_ring_pll_ctrl_sm_v0_top.u_ring_pll_ctrl_sm_v0_cdb_regs.pllsm_tmr_4_lower_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_ring_cmn_pll1_ctrl.u_ring_pll_ctrl_sm_v0_top.u_ring_pll_ctrl_sm_v0_cdb_regs.pllsm_tmr_5_upper_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_ring_cmn_pll1_ctrl.u_ring_pll_ctrl_sm_v0_top.u_ring_pll_ctrl_sm_v0_cdb_regs.pllsm_tmr_5_lower_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_ring_cmn_pll1_ctrl.u_ring_pll_ctrl_sm_v0_top.u_ring_pll_ctrl_sm_v0_cdb_regs.pllsm_tmr_6_upper_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_ring_cmn_pll1_ctrl.u_ring_pll_ctrl_sm_v0_top.u_ring_pll_ctrl_sm_v0_cdb_regs.pllsm_tmr_6_lower_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_ring_cmn_pll1_ctrl.u_ring_pll_ctrl_sm_v0_top.u_ring_pll_ctrl_sm_v0_cdb_regs.pllsm_tmr_7_upper_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_ring_cmn_pll1_ctrl.u_ring_pll_ctrl_sm_v0_top.u_ring_pll_ctrl_sm_v0_cdb_regs.pllsm_tmr_7_lower_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_ring_cmn_pll1_ctrl.u_ring_pll_ctrl_sm_v0_top.u_ring_pll_ctrl_sm_v0_cdb_regs.pllsm_tmr_8_upper_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_ring_cmn_pll1_ctrl.u_ring_pll_ctrl_sm_v0_top.u_ring_pll_ctrl_sm_v0_cdb_regs.pllsm_tmr_8_lower_reg"

    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly?.u_drv_ctrl.u_drv_ctrl_diag_ovrd.u_drv_ctrl_diag_ovrd_cdb_regs.drv_diag_lane_fcm_en_mgn_tmr_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly?.u_drv_ctrl.u_drv_ctrl_diag_ovrd.u_drv_ctrl_diag_ovrd_cdb_regs.drv_diag_lane_fcm_en_to_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly?.u_tx_ctrl.u_tx_dc_cal_ctrl_apb_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ovrd_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly?.u_tx_ctrl.u_tx_diag_ovrd.u_tx_diag_ovrd_cdb_regs.tx_diag_elec_idle_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly?.u_tx_ctrl.u_tx_diag_ovrd.u_tx_diag_ovrd_cdb_regs.tx_diag_sfifo_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly?.u_tx_ctrl.u_tx_diag_ovrd.u_tx_diag_ovrd_cdb_regs.tx_diag_sfifo_tmr_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly?.u_drv_ctrl.u_drv_ctrl_diag_ovrd.u_drv_ctrl_diag_ovrd_cdb_regs.drv_diag_lane_fcm_en_swait_tmr_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly?.u_drv_ctrl.u_tx_rcv_detect_v2_apb.u_tx_rcv_detect_v2_apb_cdb_regs.tx_rcv_detect_ovrd_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly?.u_drv_ctrl.u_tx_rcv_detect_v2_apb.u_tx_rcv_detect_v2_apb_cdb_regs.tx_rcv_detect_en_tmr_reg_int"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly?.u_drv_ctrl.u_tx_rcv_detect_v2_apb.u_tx_rcv_detect_v2_apb_cdb_regs.tx_rcv_detect_start_tmr_reg_int"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly?.u_tx_ctrl.u_tx_bist_core_apb.u_tx_bist_core_apb_cdb_regs.tx_bist_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly?.u_tx_ctrl.u_tx_dc_cal_ctrl_apb_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_start_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly?.u_tx_ctrl.u_tx_diag_ovrd.u_tx_diag_ovrd_cdb_regs.tx_diag_ser_tune_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly?.u_tx_ctrl.u_tx_dc_cal_ctrl_apb_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_tune_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly?.u_tx_ctrl.u_tx_bist_core_apb.u_tx_bist_core_apb_cdb_regs.tx_bist_seed0_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly?.u_tx_ctrl.u_tx_dc_cal_ctrl_apb_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_init_tmr_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly?.u_tx_ctrl.u_tx_dc_cal_ctrl_apb_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_iter_tmr_reg"

    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_drv_ctrl.u_drv_ctrl_diag_ovrd.u_drv_ctrl_diag_ovrd_cdb_regs.drv_diag_lane_fcm_en_mgn_tmr_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_drv_ctrl.u_drv_ctrl_diag_ovrd.u_drv_ctrl_diag_ovrd_cdb_regs.drv_diag_lane_fcm_en_to_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_tx_ctrl.u_tx_dc_cal_ctrl_apb_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ovrd_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_tx_ctrl.u_tx_diag_ovrd.u_tx_diag_ovrd_cdb_regs.tx_diag_elec_idle_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_tx_ctrl.u_tx_diag_ovrd.u_tx_diag_ovrd_cdb_regs.tx_diag_sfifo_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_tx_ctrl.u_tx_diag_ovrd.u_tx_diag_ovrd_cdb_regs.tx_diag_sfifo_tmr_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_drv_ctrl.u_drv_ctrl_diag_ovrd.u_drv_ctrl_diag_ovrd_cdb_regs.drv_diag_lane_fcm_en_swait_tmr_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_drv_ctrl.u_tx_rcv_detect_v2_apb.u_tx_rcv_detect_v2_apb_cdb_regs.tx_rcv_detect_ovrd_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_rx_ctrl.u_cmn_clk_freq_msmt_v1_top.u_clk_freq_msmt_v1_cdb_regs.ref_clk_tmr_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_rx_ctrl.u_eye_surf_ctrl_top.u_eye_surf_ctrl_cdb_regs.rx_eyesurf_ctrl"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_rx_ctrl.u_eye_surf_ctrl_top.u_eye_surf_ctrl_cdb_regs.rx_eyesurf_tmr_test"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_rx_ctrl.u_rx_bist_core_apb.u_rx_bist_core_apb_cdb_regs.rx_bist_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_rx_ctrl.u_eye_surf_ctrl_top.u_eye_surf_ctrl_cdb_regs.rx_eyesurf_offset"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_rx_ctrl.u_rx_bist_core_apb.u_rx_bist_core_apb_cdb_regs.rx_bist_synccnt_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_drv_ctrl.u_tx_rcv_detect_v2_apb.u_tx_rcv_detect_v2_apb_cdb_regs.tx_rcv_detect_en_tmr_reg_int"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_drv_ctrl.u_tx_rcv_detect_v2_apb.u_tx_rcv_detect_v2_apb_cdb_regs.tx_rcv_detect_start_tmr_reg_int"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_plldrc_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_rx_ctrl.u_cmn_clk_freq_msmt_v1_top.u_clk_freq_msmt_v1_cdb_regs.test_clk_sel_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_rx_ctrl.u_rx_false_eye_det_wrapper.u_rx_false_eye_det_cdb_regs.rx_feye_det_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_rx_ctrl.u_rx_false_eye_det_wrapper.u_rx_false_eye_det_cdb_regs.rx_feye_det_thr_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_rx_ctrl.u_rx_false_eye_det_wrapper.u_rx_false_eye_det_cdb_regs.rx_feye_det_pi_adj_1_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_rx_ctrl.u_rx_false_eye_det_wrapper.u_rx_false_eye_det_cdb_regs.rx_feye_det_pi_adj_2_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_rx_ctrl.u_rx_false_eye_det_wrapper.u_rx_false_eye_det_cdb_regs.rx_feye_det_tmr_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_tx_ctrl.u_tx_bist_core_apb.u_tx_bist_core_apb_cdb_regs.tx_bist_ctrl_reg"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_tx_ctrl.u_tx_bist_core_apb.u_tx_bist_core_apb_cdb_regs.tx_bist_seed0_reg"

    config_rtlds -signal -static "${hier_path}u_pma_iso_ctrl_ln_?.phy_pma_xcvr_ctrl_reg\[24\]"
    config_rtlds -signal -static "${hier_path}u_pma_iso_ctrl_ln_?.phy_pma_iso_tx_mgn_reg"
    config_rtlds -signal -static "${hier_path}u_pma_iso_ctrl_cmn.phy_isolation_ctrl_reg\[20\]"
    #When pll0_mode_sel toggles, the pll0 has already been disabled.
    config_rtlds -signal -static "${hier_path}u_pma_iso_ctrl_cmn.phy_pma_cmn_ctrl_reg\[1\]"
    #When pll1_mode_sel toggles, the pll1 has already been disabled.
    config_rtlds -signal -static "${hier_path}u_pma_iso_ctrl_cmn.phy_pma_cmn_ctrl_reg\[9\]"
    #tx cali code used for TXFFE 
    #config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_mult_mgn.data_in"

#2025/10/6 Suhang ADD, From Whistler PMA
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd.u_cmn_cdiag_ovrd_cdb_regs.cmn_cdiag_diag_pwri_ovrd_reg\[7:0\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd.u_cmn_cdiag_ovrd_cdb_regs.cmn_cdiag_diag_pwri_ovrd_reg\[14\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_sd_clk_cal_icfg.u_vco_cal_sm_v4_top.u_vco_cal_sm_v4_cdb_regs.vcocal_tctrl_value\[2:0\]"


    #TODO Can Chen add, need review
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_fdiag_ovrd.u_cmn_fdiag_ovrd_cdb_regs.cmn_diag_tmpsns_filt_ctrl_reg\[31\]" 
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_bg_cal_ctrl_apb_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ctrl_reg\[15\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_clk_freq_msmt_v1_top.u_clk_freq_msmt_v1_cdb_regs.clk_freq_msmt_ctrl_reg\[15\]"  
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_ibiascal_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ctrl_reg\[15\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_rx_rescal_ctrl_icfg.u_rx_res_cal_ctrl.u_bin_cal_apb_cdb_regs.cal_ctrl_reg\[15\]"
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_pu_icfg.u_tx_rescal_ctrl_pu.u_bin_cal_apb_cdb_regs.cal_ctrl_reg\[15\]" 
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_sd_clk_cal_icfg.u_vco_cal_sm_v4_top.u_vco_cal_sm_v4_cdb_regs.vcocal_ctrl_value\[15\]" 
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_pd_icfg.u_tx_rescal_ctrl_pd.u_bin_cal_apb_cdb_regs.cal_ctrl_reg\[15\]" 
    config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_pd_icfg.u_tx_rescal_ctrl_pd.u_bin_cal_apb_cdb_regs.cal_ctrl_reg\[15\]"


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
    
    #config_rtlds -reset -sync ieee1687_rstn        -polarity low  -clock ieee1687_tck
    config_rtlds -reset -async ieee1687_rstn       -polarity low 
    #config_rtlds -reset -sync u_tap_complex.u_JTAG_MACRO.U_TAP_CONTROLLER.TCS_RESET -polarity low -clock tap_tck
    #config_rtlds -reset -sync u_ieee1687_wrapper.u_diag_ctrl_tdr.u_reg\[1\] -polarity low -clock ieee1687_tck
    #config_rtlds -reset -sync u_ieee1687_wrapper.u_diag_ctrl_tdr.u_reg\[0\] -polarity low -clock ieee1687_tck
    
    #check_cdc -reset -set_order {u_pcs_top.u_pcs_crg.u_reset_sync_phy_state_reset.genblk1.reset_sync_flop[2] u_pcs_top.u_pcs_crg.u_reset_sync_cm_rap_reset.genblk1.reset_sync_flop[1]}
    
    # internal reset
    config_rtlds -reset -async u_phy_clkrst.u_phy_reset_sequencer.st_current_state\[0\]                  -polarity low
    config_rtlds -reset -async u_phy_clkrst.u_phy_reset_sequencer.st_current_state\[1\]                  -polarity low
    config_rtlds -reset -async u_phy_clkrst.u_usb_link_reset_sequencer.state                             -polarity low
    config_rtlds -reset -async u_phy_clkrst.u_dp_link_reset_sequencer.state                              -polarity low
    config_rtlds -reset -async u_phy_clkrst.u_usb4_link_reset_sequencer.state                            -polarity low
    config_rtlds -reset -async u_phy_clkrst.u_usb3_link_reset_sequencer.state                            -polarity low
    config_rtlds -reset -async u_phy_clkrst.u_phy_reset_sync_dp_tx_sfifo_enq_reset_n_in_ln_0.reset_in_n  -polarity low
    config_rtlds -reset -async u_phy_clkrst.u_phy_reset_sync_tx_sfifo_enq_reset_n_ln_0.reset_in_n        -polarity low

    config_rtlds -reset -async u_phy_reconfig_ctlr.u_phy_scan_mux_cmn_reset_n_out.fcn_signal_out          -polarity low
    
    config_rtlds -reset -sync u_pcs_iso_ctrl_cmn.phy_ln_soft_cdb_reset_n\[0\]                            -polarity low -clock uc_clk
    config_rtlds -reset -sync u_pcs_iso_ctrl_cmn.phy_ln_soft_cdb_reset_n\[1\]                            -polarity low -clock uc_clk
    config_rtlds -reset -sync u_pcs_iso_ctrl_cmn.phy_ln_soft_cdb_reset_n\[2\]                            -polarity low -clock uc_clk
    config_rtlds -reset -sync u_pcs_iso_ctrl_cmn.phy_ln_soft_cdb_reset_n\[3\]                            -polarity low -clock uc_clk
    config_rtlds -reset -sync u_pcs_iso_ctrl_cmn.phy_ln_soft_cdb_reset_n\[4\]                            -polarity low -clock uc_clk
    config_rtlds -reset -sync u_pcs_iso_ctrl_cmn.phy_ln_soft_cdb_reset_n\[5\]                            -polarity low -clock uc_clk
    config_rtlds -reset -sync u_pcs_iso_ctrl_cmn.phy_ln_soft_cdb_reset_n\[6\]                            -polarity low -clock uc_clk
    config_rtlds -reset -sync u_pcs_iso_ctrl_cmn.phy_ln_soft_cdb_reset_n\[7\]                            -polarity low -clock uc_clk
    config_rtlds -reset -sync u_pcs_iso_ctrl_cmn.phy_ln_soft_cdb_reset_n\[8\]                            -polarity low -clock uc_clk
    config_rtlds -reset -sync u_pcs_iso_ctrl_cmn.phy_ln_soft_cdb_reset_n\[9\]                            -polarity low -clock uc_clk
    config_rtlds -reset -sync u_pcs_iso_ctrl_cmn.phy_ln_soft_cdb_reset_n\[10\]                           -polarity low -clock uc_clk
    config_rtlds -reset -sync u_pcs_iso_ctrl_cmn.phy_ln_soft_cdb_reset_n\[11\]                           -polarity low -clock uc_clk
    config_rtlds -reset -sync u_pcs_iso_ctrl_cmn.phy_ln_soft_cdb_reset_n\[12\]                           -polarity low -clock uc_clk
    config_rtlds -reset -sync u_pcs_iso_ctrl_cmn.phy_ln_soft_cdb_reset_n\[13\]                           -polarity low -clock uc_clk
    config_rtlds -reset -sync u_pcs_iso_ctrl_cmn.phy_ln_soft_cdb_reset_n\[14\]                           -polarity low -clock uc_clk
    config_rtlds -reset -sync u_pcs_iso_ctrl_cmn.phy_ln_soft_cdb_reset_n\[15\]                           -polarity low -clock uc_clk

    config_rtlds -reset -async u_mp_pcs_top_ln_0.message_bus.u_phy_reset_sync_phy_reset_n.reset_in_n     -polarity low
    config_rtlds -reset -async u_mp_pcs_top_ln_1.message_bus.u_phy_reset_sync_phy_reset_n.reset_in_n     -polarity low

    config_rtlds -reset -async u_mp_pcs_top_ln_0.mp_pcs_serdes.i_rpcs.u_phy_reset_sync_rx_rx_clk.reset_in_n -polarity low
    config_rtlds -reset -async u_mp_pcs_top_ln_1.mp_pcs_serdes.i_rpcs.u_phy_reset_sync_rx_rx_clk.reset_in_n -polarity low

    config_rtlds -reset -sync u_tap_complex.u_JTAG_MACRO.TAP_CONTROLLER.TCS_RESET                       -polarity low -clock tap_tck

#uC_reset.
    config_rtlds -reset -sync u_pcs_iso_ctrl_cmn.uc_soft_reset_n                                      -polarity low -clock uc_clk
    config_rtlds -reset -sync u_pcs_iso_ctrl_ln_0.uc_soft_reset_n                                     -polarity low -clock uc_clk
    config_rtlds -reset -sync u_pcs_iso_ctrl_ln_2.uc_soft_reset_n                                     -polarity low -clock uc_clk

#Reset signal from ISO
    config_rtlds -reset -async u_pma_iso_ctrl_cmn.phy_pma_cmn_ctrl_reg\[7\]                             -polarity low
    #config_rtlds -reset -async u_pma_iso_ctrl_cmn.phy_pma_cmn_ctrl_reg\[15\]                             -polarity low    ??
    config_rtlds -reset -async u_pma_iso_ctrl_ln_0.phy_pma_xcvr_ctrl_reg\[31\]                          -polarity low
    config_rtlds -reset -async u_pma_iso_ctrl_ln_1.phy_pma_xcvr_ctrl_reg\[31\]                          -polarity low
    config_rtlds -reset -async u_pma_iso_ctrl_ln_1.phy_pma_xcvr_ctrl_reg\[30\]                          -polarity low
    config_rtlds -reset -async u_pma_iso_ctrl_ln_2.phy_pma_xcvr_ctrl_reg\[31\]                          -polarity low
    config_rtlds -reset -async u_pma_iso_ctrl_ln_2.phy_pma_xcvr_ctrl_reg\[30\]                          -polarity low
    config_rtlds -reset -async u_pma_iso_ctrl_ln_3.phy_pma_xcvr_ctrl_reg\[31\]                          -polarity low


# u_cmn
    # pll0 related
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_pll0_lock_det_fbdiv_clk_reset_n         -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_pll0_lock_det_ref_clk_reset_n           -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_pll0_vcocal_fbdiv_clk_reset_n           -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_pll0_vcocal_ref_clk_reset_n             -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_pll0_clk_reset_n                        -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_pll0_dsm_reset_n                        -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_pllsm0_nsr_reset_n                          -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_pllsm0_wsr_reset_n                          -polarity low

    # pll1 related
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_pll1_clk_reset_n                        -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_pll1_dsm_reset_n                        -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_pll1_reset_sync_n                           -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_pllsm1_wsr_reset_n                          -polarity low

    # common (non-pll specific)
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_sd_clk_cal_fb_clk_reset_n               -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_ccal_power_reset_n                      -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_diag_power_reset_n                      -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cdb_preset_diag_isl_synced_cdbclk_n         -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_hs_rst_rel_sm_reset_n                   -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cdb_isl_ctrl_sm_reset_n                     -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_cmn.reset_rx_sig_det_en_to_cmn_n                                   -polarity low

# u_xcvr_txonly0 (aligned)
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_tx_dsync.u_sa_sync_fifo_v1.u_sa_sync_fifo_v1_error_det.fifo_error_flop_reset_n      -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_tx_dsync.u_sa_sync_fifo_v1.u_sa_sync_fifo_v1_ptr_algn_det.ptr_align_det_reset_n     -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_clkrst.reset_tx_dig_reset_scanned_n                                            -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.u_xcvr_hsrrsm_tx.da_clk_reset_n                                           -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_clkrst.rx_dig_reset_n                                                          -polarity low  ;# tie 1 (no rx logic)
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_clkrst.reset_tx_reset_n                                                        -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_clkrst.clock_div_upstrm_rst_in_n_pll_clk                                       -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_clkrst.reset_cdb_preset_diag_isl_synced_cdbclk_n                               -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_clkrst.reset_bin_cal_reset_n                                                   -polarity low
    #Based on the current design, PHY only runs on USB4 protocol. So this reset belongs to pipe7_l00_clk.
    config_rtlds -reset -sync  u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_clkrst.u_scan_mux_tx_sync_fifo_enq_rst_n.fcn_signal_out                        -polarity low -clock pipe7_l00_clk
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.reset_decap                                                                           -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_clkrst.reset_xcvr_psm_reset_n                                                  -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_clkrst.reset_tx_coef_calc_reset_n                                              -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_clkrst.reset_xcvr_ref_clk_reset_xcvrc_isl_n                                    -polarity low

# u_xcvr_txonly1 (aligned)
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_tx_dsync.u_sa_sync_fifo_v1.u_sa_sync_fifo_v1_error_det.fifo_error_flop_reset_n      -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_tx_dsync.u_sa_sync_fifo_v1.u_sa_sync_fifo_v1_ptr_algn_det.ptr_align_det_reset_n     -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_clkrst.reset_tx_dig_reset_scanned_n                                            -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.u_xcvr_hsrrsm_tx.da_clk_reset_n                                           -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_clkrst.rx_dig_reset_n                                                          -polarity low  ;# tie 1 (no rx logic)
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_clkrst.reset_tx_reset_n                                                        -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_clkrst.clock_div_upstrm_rst_in_n_pll_clk                                       -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_clkrst.reset_cdb_preset_diag_isl_synced_cdbclk_n                               -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_clkrst.reset_bin_cal_reset_n                                                   -polarity low
    #Based on the current design, PHY only runs on USB4 protocol. So this reset belongs to pipe7_l00_clk.
    config_rtlds -reset -sync  u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_clkrst.u_scan_mux_tx_sync_fifo_enq_rst_n.fcn_signal_out                        -polarity low -clock pipe7_l00_clk
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.reset_decap                                                                           -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_clkrst.reset_xcvr_psm_reset_n                                                  -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_clkrst.reset_tx_coef_calc_reset_n                                              -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_clkrst.reset_xcvr_ref_clk_reset_xcvrc_isl_n                                    -polarity low

# u_xcvr_txrxm_lane1 (aligned)
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.reset_sig_det_high_test                                           -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.reset_sig_det_low_test                                            -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_sig_detect_filt_apb_icfg.u_rx_sig_detect_filt_low_apb.u_rx_sig_detect_filt_low_v2.reset_rx_sig_det_filter_n -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_tx_dsync.u_sa_sync_fifo_v1.u_sa_sync_fifo_v1_error_det.fifo_error_flop_reset_n           -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_tx_dsync.u_sa_sync_fifo_v1.u_sa_sync_fifo_v1_ptr_algn_det.ptr_align_det_reset_n          -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.reset_tx_dig_reset_scanned_n                                                 -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_hsrrsm_tx.da_clk_reset_n                                                -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.reset_tx_reset_n                                                             -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.reset_rx_reset_n                                                             -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.reset_rx_ree_fcn_reset_n                                                     -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.rx_ree_eq_fcn_reset_n                                      -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.reset_rx_ree_ctrl_reset_n                                                    -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.reset_rx_diag_reset_n                                                        -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.clock_div_upstrm_rst_in_n_pll_clk                                            -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_hsrrsm_rx.hsrrsm_current_state\[2\]                                     -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.reset_lfps_det_high_test                                          -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.reset_lfps_det_low_test                                           -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.reset_xcvr_cmsmt_ref_clk_reset_n                                             -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.reset_cdb_preset_diag_isl_synced_cdbclk_n                                    -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.reset_rx_sampler_latch_cal_reset_n                                           -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.reset_bin_cal_reset_n                                                        -polarity low
    #Based on the current design, PHY only runs on USB4 protocol. So this reset belongs to pipe7_l00_clk.
    config_rtlds -reset -sync  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.u_scan_mux_tx_sync_fifo_enq_rst_n.fcn_signal_out                             -polarity low -clock pipe7_l00_clk
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_eq_mode_change_det.reset_eq_mode_change                  -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.reset_decap                                                                                -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.reset_xcvr_psm_reset_n                                                       -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.reset_tx_coef_calc_reset_n                                                   -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.reset_xcvr_ref_clk_reset_xcvrc_isl_n                                         -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_cdrlf_config.u_cdrlf_config_cdb_regs.cdr_2ol_max_det_reset_n                   -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.reset_u_reset_sync_rx_false_eye_det_reset_n                                  -polarity low
# u_xcvr_txrxm_lane2 (aligned)
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.reset_sig_det_high_test                                           -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.reset_sig_det_low_test                                            -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_sig_detect_filt_apb_icfg.u_rx_sig_detect_filt_low_apb.u_rx_sig_detect_filt_low_v2.reset_rx_sig_det_filter_n -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_tx_dsync.u_sa_sync_fifo_v1.u_sa_sync_fifo_v1_error_det.fifo_error_flop_reset_n           -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_tx_dsync.u_sa_sync_fifo_v1.u_sa_sync_fifo_v1_ptr_algn_det.ptr_align_det_reset_n          -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_tx_dig_reset_scanned_n                                                 -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_hsrrsm_tx.da_clk_reset_n                                                -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_tx_reset_n                                                             -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_rx_reset_n                                                             -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_rx_ree_fcn_reset_n                                                     -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.rx_ree_eq_fcn_reset_n                                      -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_rx_ree_ctrl_reset_n                                                    -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_rx_diag_reset_n                                                        -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.clock_div_upstrm_rst_in_n_pll_clk                                            -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_hsrrsm_rx.hsrrsm_current_state\[2\]                                     -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.reset_lfps_det_high_test                                          -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.reset_lfps_det_low_test                                           -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_xcvr_cmsmt_ref_clk_reset_n                                             -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_cdb_preset_diag_isl_synced_cdbclk_n                                    -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_rx_sampler_latch_cal_reset_n                                           -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_bin_cal_reset_n                                                        -polarity low
    #Based on the current design, PHY only runs on USB4 protocol. So this reset belongs to pipe7_l00_clk.
    config_rtlds -reset -sync  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.u_scan_mux_tx_sync_fifo_enq_rst_n.fcn_signal_out                             -polarity low -clock pipe7_l00_clk
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_eq_mode_change_det.reset_eq_mode_change                  -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.reset_decap                                                                                -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_xcvr_psm_reset_n                                                       -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_tx_coef_calc_reset_n                                                   -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_xcvr_ref_clk_reset_xcvrc_isl_n                                         -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_cdrlf_config.u_cdrlf_config_cdb_regs.cdr_2ol_max_det_reset_n                   -polarity low
    config_rtlds -reset -async u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_u_reset_sync_rx_false_eye_det_reset_n                                  -polarity low


############################################################################################################################

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
    config_rtlds -port pma_atb_core_0                           -clock vclk_ana
    config_rtlds -port pma_atb_core_1                           -clock vclk_ana
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
    
    config_rtlds -port pipe7_clk_max_req                        -clock vclk
    config_rtlds -port pipe7_clk_max_ack                        -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0
    
    config_rtlds -port pipe7_pll0_en                            -clock vclk
    config_rtlds -port pipe7_pll0_ok                            -clock uc_clk
    
    config_rtlds -port pipe7_l00_rate\[1\:0\]                   -clock pipe7_l00_clk 
    config_rtlds -port pipe7_l00_phy_status                     -clock pipe7_l00_clk
    config_rtlds -port pipe7_l00_rx_data\[39\:0\]               -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_clk
    config_rtlds -port pipe7_l00_rx_valid                       -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_clk
    config_rtlds -port pipe7_l00_rx_standby_status              -clock pipe7_l00_clk
    config_rtlds -port pipe7_l00_rx_elec_idle                   -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_clk
    config_rtlds -port pipe7_l00_rx_termination                 -clock pipe7_l00_clk
    config_rtlds -port pipe7_l00_rx_standby                     -clock vclk
    config_rtlds -port pipe7_l00_powerdown\[2\:0\]              -clock pipe7_l00_clk
    config_rtlds -port pipe7_l00_tx_data\[39\:0\]               -clock pipe7_l00_clk
    config_rtlds -port pipe7_l00_tx_data_valid                  -clock pipe7_l00_clk
    config_rtlds -port pipe7_l00_tx_det_rx_lpbk                 -clock pipe7_l00_clk
    config_rtlds -port pipe7_l00_tx_elec_idle                   -clock pipe7_l00_clk
    config_rtlds -port pipe7_l00_m2p_messagebus\[7\:0\]         -clock pipe7_l00_clk
    config_rtlds -port pipe7_l00_p2m_messagebus\[7\:0\]         -clock pipe7_l00_clk
    
    config_rtlds -port pipe7_l01_rate\[1\:0\]                   -clock pipe7_l01_clk 
    config_rtlds -port pipe7_l01_phy_status                     -clock pipe7_l01_clk
    config_rtlds -port pipe7_l01_rx_data\[39\:0\]               -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_des_clk
    config_rtlds -port pipe7_l01_rx_valid                       -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_des_clk
    config_rtlds -port pipe7_l01_rx_standby_status              -clock pipe7_l01_clk
    config_rtlds -port pipe7_l01_rx_elec_idle                   -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_des_clk
    config_rtlds -port pipe7_l01_rx_termination                 -clock pipe7_l01_clk
    config_rtlds -port pipe7_l01_rx_standby                     -clock vclk
    config_rtlds -port pipe7_l01_powerdown\[2\:0\]              -clock pipe7_l01_clk
    config_rtlds -port pipe7_l01_tx_data\[39\:0\]               -clock pipe7_l01_clk
    config_rtlds -port pipe7_l01_tx_data_valid                  -clock pipe7_l01_clk
    config_rtlds -port pipe7_l01_tx_det_rx_lpbk                 -clock pipe7_l01_clk
    config_rtlds -port pipe7_l01_tx_elec_idle                   -clock pipe7_l00_clk
    config_rtlds -port pipe7_l01_m2p_messagebus\[7\:0\]         -clock pipe7_l01_clk
    config_rtlds -port pipe7_l01_p2m_messagebus\[7\:0\]         -clock pipe7_l01_clk
    
    # raw intf for DP
    config_rtlds -port pma_cmn_ready                            -clock pma_cmn_refclk0_int
    config_rtlds -port pma_xcvr_pllclk_en_ack                   -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll1_clk_prog0
    config_rtlds -port pma_xcvr_pllclk_en                       -clock vclk
    config_rtlds -port pma_xcvr_power_state_ack\[5\:0\]         -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_sd_clk 
    config_rtlds -port pma_xcvr_power_state_req\[5\:0\]         -clock vclk
    
    config_rtlds -port pma_xcvr_data_width\[2\:0\]              -clock vclk
    
    config_rtlds -port pma_tx_lfps_en                           -clock vclk
    config_rtlds -port pma_tx_lfps_mode                         -clock vclk
    
    config_rtlds -port pma_tx_elec_idle_ln_0                    -clock pma_tx_td_clk
    config_rtlds -port pma_tx_td_ln_0\[31\:0\]                  -clock pma_tx_td_clk
    config_rtlds -port pma_tx_elec_idle_ln_1                    -clock pma_tx_td_clk
    config_rtlds -port pma_tx_td_ln_1\[31\:0\]                  -clock pma_tx_td_clk
    config_rtlds -port pma_tx_elec_idle_ln_2                    -clock pma_tx_td_clk
    config_rtlds -port pma_tx_td_ln_2\[31\:0\]                  -clock pma_tx_td_clk
    config_rtlds -port pma_tx_elec_idle_ln_3                    -clock pma_tx_td_clk
    config_rtlds -port pma_tx_td_ln_3\[31\:0\]                  -clock pma_tx_td_clk
    
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
    
    config_rtlds -port cmn_scanclk_pll0_prog0_ats_out           -clock vclk_scan
    config_rtlds -port cmn_scanclk_pll0_prog1_ats_out           -clock vclk_scan
    config_rtlds -port cmn_scanclk_pll1_prog0_ats_out           -clock vclk_scan
    config_rtlds -port cmn_scanclk_pll1_prog1_ats_out           -clock vclk_scan
           
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
    
    config_rtlds -port tx_bscan_ext_shiftdr   -clock vclk_scan
    config_rtlds -port rx_bscan_ext_shiftdr   -clock vclk_scan
    config_rtlds -port rx_bscan_ext_tdi       -clock vclk_scan
    config_rtlds -port tx_bscan_ext_tdo       -clock vclk_scan
    
    #pma clock
    config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_i_data -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_clk
    config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_q_data -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_clk
    config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_e_data -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_clk
    config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_des_i_data -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_des_clk
    config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_des_q_data -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_des_clk
    config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_des_e_data -clock u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_des_clk

    config_rtlds -port u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_tmpsns_sdm_out -clock u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_tmpsns_sdm_clk_out
    
    
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

    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group0_main_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group0_emp_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group0_mgn_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group1_main_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group1_mgn_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group2_main_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group2_emp_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group2_mgn_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group3_main_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group3_mgn_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group4_main_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group4_emp_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group4_mgn_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group0_main_start      -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group0_emp_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group0_emp_end         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group1_main_start      -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group1_emp_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group1_emp_end         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group2_main_start      -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group2_emp_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group2_emp_end         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group3_main_start      -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group3_emp_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group3_emp_end         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group4_main_start      -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group4_emp_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group4_emp_end         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group0_main_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group0_emp_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group0_mgn_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group1_main_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group1_mgn_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group2_main_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group2_emp_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group2_mgn_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group3_main_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group3_mgn_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group4_main_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group4_emp_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group4_mgn_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group0_main_start      -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group0_emp_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group0_emp_end         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group1_main_start      -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group1_emp_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group1_emp_end         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group2_main_start      -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group2_emp_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group2_emp_end         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group3_main_start      -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group3_emp_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group3_emp_end         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group4_main_start      -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group4_emp_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_group4_emp_end         -clock vclk_ana

    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group0_main_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group0_emp_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group0_mgn_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group1_main_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group1_mgn_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group2_main_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group2_emp_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group2_mgn_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group3_main_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group3_mgn_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group4_main_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group4_emp_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group4_mgn_zero        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group0_main_start      -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group0_emp_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group0_emp_end         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group1_main_start      -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group1_emp_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group1_emp_end         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group2_main_start      -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group2_emp_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group2_emp_end         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group3_main_start      -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group3_emp_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group3_emp_end         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group4_main_start      -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group4_emp_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_group4_emp_end         -clock vclk_ana
                
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group0_main_zero         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group0_emp_zero          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group0_mgn_zero          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group1_main_zero         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group1_mgn_zero          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group2_main_zero         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group2_emp_zero          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group2_mgn_zero          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group3_main_zero         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group3_mgn_zero          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group4_main_zero         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group4_emp_zero          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group4_mgn_zero          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group0_main_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group0_emp_start        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group0_emp_end          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group1_main_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group1_emp_start        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group1_emp_end          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group2_main_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group2_emp_start        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group2_emp_end          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group3_main_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group3_emp_start        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group3_emp_end          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group4_main_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group4_emp_start        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_group4_emp_end          -clock vclk_ana

    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group0_main_zero         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group0_emp_zero          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group0_mgn_zero          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group1_main_zero         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group1_mgn_zero          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group2_main_zero         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group2_emp_zero          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group2_mgn_zero          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group3_main_zero         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group3_mgn_zero          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group4_main_zero         -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group4_emp_zero          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group4_mgn_zero          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group0_main_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group0_emp_start        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group0_emp_end          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group1_main_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group1_emp_start        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group1_emp_end          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group2_main_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group2_emp_start        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group2_emp_end          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group3_main_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group3_emp_start        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group3_emp_end          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group4_main_start       -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group4_emp_start        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_group4_emp_end          -clock vclk_ana

config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_seg_dis_odd -clock vclk_ana
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_scanout -clock vclk_scan
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_bscan_ztn -clock tap_tck
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_bscan_ztp -clock tap_tck 
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_test_chain_out -clock vclk_ana
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_scanout -clock vclk_scan
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_seg_pre2_emp_odd -clock vclk_ana
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_seg_pre1_emp_odd -clock vclk_ana
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_seg_main_odd -clock vclk_ana
config_rtlds -port bscan_ext_clockdr -clock vclk_ana
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_seg_mgn_odd -clock vclk_ana
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_seg_post_emp_odd -clock vclk_ana
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_drv_scanout -clock vclk_scan
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_test_chain_out -clock vclk_ana
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_bscan_ztp -clock tap_tck
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_bscan_ztn -clock tap_tck
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_scanout -clock vclk_scan
config_rtlds -port bscan_ext_shiftdr -clock vclk_ana
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_seg_dis_odd -clock vclk_ana
config_rtlds -port pma_cmn_avdd_pwrgood -clock vclk_ana
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_pre1_emp_odd -clock vclk_ana
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_pre2_emp_odd -clock vclk_ana
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_pre1_emp_odd -clock vclk_ana
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_pre2_emp_odd -clock vclk_ana
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_test_chain_clk -clock vclk_ana
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_drv_scanout -clock vclk_scan
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_test_chain_out -clock vclk_ana
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_drv_scanout -clock vclk_scan
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_test_chain_out -clock vclk_ana
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_seg_post_emp_odd -clock vclk_ana
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_seg_mgn_odd -clock vclk_ana
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_seg_pre1_emp_odd -clock vclk_ana
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_seg_pre2_emp_odd -clock vclk_ana
config_rtlds -port u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_drv_seg_main_odd -clock vclk_ana

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
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_dc_comp_out                  -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_rcvdet_detected_n            -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.txda_cm_sense_comp                -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.xcvrda_tx_clk_rst_n               -clock vclk_ana


    
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_pulse_low                 -clock vclk_ana
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
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_pi_val                 -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_cdrlf_pi_val_ack             -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_atb_core_en                  -clock vclk_ana
    
    
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
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.xcvrda_tx_clk_rst_n               -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_rcvdet_detected_n            -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_dc_comp_out                  -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_pi_val_ack             -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_cdrlf_pi_val                 -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.txda_cm_sense_comp                -clock vclk_ana

    
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
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_atb_core_en                  -clock vclk_ana
    
    
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
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_post_div                             -clock vclk_ana 
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pmc_sel                                   -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pmc_en                                    -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_gpana_0_out                               -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_gpana_1_out                               -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_gpana_2_out                               -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_rescal_comp_tx_dseg                       -clock vclk_ana
    
    
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_gpana_in                                  -clock vclk_ana
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
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_rcvdet_detected_n                    -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_cya_out                              -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_atbsel_onehot                        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_dc_cal_en                            -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_atb_core_en                          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_cm_sense_comp                        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_dc_comp_out                          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda0_dc_cal_en_del                        -clock vclk_ana


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
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_dc_comp_out                          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_cm_sense_comp                        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_cya_out                              -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_rcvdet_detected_n                    -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_atbsel_onehot                        -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_atb_core_en                          -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_dc_cal_en                            -clock vclk_ana
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_dc_cal_en_del                        -clock vclk_ana




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
    
    
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_clkp_1_left                   -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_clkn_0_left                   -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_clkp_0_left                   -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_clkn_1_left                   -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_clk_1_m_out                   -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_clk_1_p_out                   -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_clk_0_m_out                   -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_clk_0_p_out                   -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_sd_clk_out                    -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_tx_clk_rst_rel_out            -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.iptat_rxafe_fromp_12p5u_h         -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.iext_rxtxm_fromn_25u              -clock vclk_ana_only

    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.iext_rxtxm_clkdist_fromp_50u      -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ipoly_rxtxm_fromn_25u             -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ipoly_rxafe_fromp_25u             -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ibg_rxafe_fromp_12p5u_h           -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_tx_clk_rst_rel_in             -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.iext_rxtxm_clkdist_fromn_50u      -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ibg_rxtxm_sd_fromp_25u_h          -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_ls_en_h_n                     -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_sd_clk_in                     -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_clk_0_p_in                    -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_clk_0_m_in                    -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_clk_1_p_in                    -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_clk_1_m_in                    -clock vclk_ana_only

    #bump
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_rxtxm_data_p                  -clock vclk_bump
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.ana_rxtxm_data_m                  -clock vclk_bump
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.ana_rxtxm_data_p                  -clock vclk_bump
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.ana_rxtxm_data_m                  -clock vclk_bump
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.tx_m_0                                     -clock vclk_bump
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.tx_m_1                                     -clock vclk_bump
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.tx_p_0                                     -clock vclk_bump
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.tx_p_1                                     -clock vclk_bump
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmn_rext                                        -clock vclk_bump



    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.iptat_rxafe_fromp_12p5u_h         -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.iext_rxtxm_clkdist_fromp_50u      -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.ipoly_rxtxm_fromn_25u             -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.ipoly_rxafe_fromp_25u             -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.ibg_rxafe_fromp_12p5u_h           -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.ana_tx_clk_rst_rel_in             -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.iext_rxtxm_clkdist_fromn_50u      -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.ibg_rxtxm_sd_fromp_25u_h          -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.ana_ls_en_h_n                     -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.ana_sd_clk_in                     -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.ana_clk_0_p_in                    -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.ana_clk_0_m_in                    -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.ana_clk_1_p_in                    -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.ana_clk_1_m_in                    -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.iext_rxtxm_fromn_25u              -clock vclk_ana_only



    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ana_tx_clk_reset_rel_out_r                      -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ana_tx_clk_reset_rel_out_l                      -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ana_clk_m_0_out                                 -clock vclk_ana_only

    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ana_tx_clk_reset_rel_r                          -clock vclk_ana_only

    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.iext_rxtxm_fromn_25u                            -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.iext_rxtxm_clkdist_fromp_50u                    -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ipoly_rxafe_fromp_25u                           -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.iext_txm_clkdist_fromn_50u                      -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.iptat_rxafe_fromp_12p5u_h                       -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ipoly_rxtxm_fromn_25u                           -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ana_clk_0_p_out_r                               -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ana_tx_clk_reset_rel_l                          -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ana_sd_clk_r                                    -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ana_sd_clk_l                                    -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ibg_rxafe_fromp_12p5u_h                         -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ana_ls_en_h_n                                   -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.iext_rxtxm_clkdist_fromn_50u                    -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ibg_rxtxm_sd_fromp_25u_h                        -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ana_clk_0_m_out_r                               -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ana_clk_0_p_out_l                               -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ana_clk_0_m_out_l                               -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ana_clk_1_p_out_r                               -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ana_clk_1_m_out_r                               -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ana_clk_1_p_out_l                               -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.ana_clk_1_m_out_l                               -clock vclk_ana_only

    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.ana_clk_0_m_in                             -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.ana_clk_0_p_in                             -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.ana_clk_1_m_in                             -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.ana_clk_1_p_in                             -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.ana_sd_clk_in                              -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.iext_txm_clkdist_fromn_50u                 -clock vclk_ana_only
    config_rtlds -port  u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.ana_tx_clk_rst_rel_in                      -clock vclk_ana_only

#uC Top
    config_rtlds -port u_uc_top.xttop.BReset                       -clock uc_clk
    config_rtlds -port u_uc_top.xttop.BResetProc_logic             -clock uc_clk
    config_rtlds -port u_uc_top.xttop.BResetProc_synchronized      -clock uc_clk
    config_rtlds -port u_uc_top.xttop.DReset                       -clock uc_clk
    config_rtlds -port u_uc_top.xttop.RunStall                     -clock uc_clk
    config_rtlds -port u_uc_top.xttop.TMode                        -clock uc_clk
    config_rtlds -port u_uc_top.xttop.TModeClkGateOverride         -clock uc_clk
    config_rtlds -port u_uc_top.xttop.softBReset                   -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.PFatalError                  -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.PFaultInfo                   -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.PFaultInfoValid              -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.PWaitMode                    -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.DebugMode                    -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.XOCDMode                     -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.OCDHaltOnReset               -clock uc_clk
    config_rtlds -port u_uc_top.xttop.IRam0Addr                    -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.IRam0Busy                    -clock uc_clk
    config_rtlds -port u_uc_top.xttop.IRam0Data                    -clock uc_clk
    config_rtlds -port u_uc_top.xttop.IRam0En                      -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.IRam0LoadStore               -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.IRam0Wr                      -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.IRam0WrData                  -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.DRam0Addr0                   -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.DRam0Busy0                   -clock uc_clk
    config_rtlds -port u_uc_top.xttop.DRam0ByteEn0                 -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.DRam0Data0                   -clock uc_clk
    config_rtlds -port u_uc_top.xttop.DRam0En0                     -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.DRam0Wr0                     -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.DRam0WrData0                 -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.DRam1Addr0                   -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.DRam1Busy0                   -clock uc_clk
    config_rtlds -port u_uc_top.xttop.DRam1ByteEn0                 -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.DRam1Data0                   -clock uc_clk
    config_rtlds -port u_uc_top.xttop.DRam1En0                     -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.DRam1Wr0                     -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.DRam1WrData0                 -clock uc_clk 
    config_rtlds -port u_uc_top.xttop.BInterrupt                   -clock uc_clk
    config_rtlds -port u_uc_top.xttop.PRID                         -clock uc_clk

#    config_rtlds -port u_uc_top.xttop.DBGEN                        -clock PBCLK # input 
#    config_rtlds -port u_uc_top.xttop.NIDEN                        -clock PBCLK # input 
#    config_rtlds -port u_uc_top.xttop.PADDR                        -clock PBCLK # input 
#    config_rtlds -port u_uc_top.xttop.PBCLKEN                      -clock PBCLK # input 
#    config_rtlds -port u_uc_top.xttop.PENABLE                      -clock PBCLK # input 
#    config_rtlds -port u_uc_top.xttop.PRDATA                       -clock PBCLK # output 
#    config_rtlds -port u_uc_top.xttop.PREADY                       -clock PBCLK # output 
#    config_rtlds -port u_uc_top.xttop.PRESETn                      -clock PBCLK # input (reset for APB domain) 
#    config_rtlds -port u_uc_top.xttop.PSEL                         -clock PBCLK # input 
#    config_rtlds -port u_uc_top.xttop.PSLVERR                      -clock PBCLK # output 
#    config_rtlds -port u_uc_top.xttop.PWDATA                       -clock PBCLK # input 
#    config_rtlds -port u_uc_top.xttop.PWRITE                       -clock PBCLK # input 
#    config_rtlds -port u_uc_top.xttop.SPIDEN                       -clock PBCLK # input 
#    config_rtlds -port u_uc_top.xttop.SPNIDEN                      -clock PBCLK # input

    config_rtlds -port u_uc_top.xttop.JTDI                         -clock uc_top_tap_tck
    config_rtlds -port u_uc_top.xttop.JTDO                         -clock uc_top_tap_tck
    config_rtlds -port u_uc_top.xttop.JTDOEn                       -clock uc_top_tap_tck
    config_rtlds -port u_uc_top.xttop.JTMS                         -clock uc_top_tap_tck
    config_rtlds -port JTRST                                       -clock uc_top_tap_tck

#uC lane01
    config_rtlds -port u_uc_ln_01.xttop.BReset                       -clock uc_clk
    config_rtlds -port u_uc_ln_01.xttop.BResetProc_logic             -clock uc_clk
    config_rtlds -port u_uc_ln_01.xttop.BResetProc_synchronized      -clock uc_clk
    config_rtlds -port u_uc_ln_01.xttop.DReset                       -clock uc_clk
    config_rtlds -port u_uc_ln_01.xttop.RunStall                     -clock uc_clk
    config_rtlds -port u_uc_ln_01.xttop.TMode                        -clock uc_clk
    config_rtlds -port u_uc_ln_01.xttop.TModeClkGateOverride         -clock uc_clk
    config_rtlds -port u_uc_ln_01.xttop.softBReset                   -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.PFatalError                  -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.PFaultInfo                   -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.PFaultInfoValid              -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.PWaitMode                    -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.DebugMode                    -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.XOCDMode                     -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.OCDHaltOnReset               -clock uc_clk
    config_rtlds -port u_uc_ln_01.xttop.IRam0Addr                    -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.IRam0Busy                    -clock uc_clk
    config_rtlds -port u_uc_ln_01.xttop.IRam0Data                    -clock uc_clk
    config_rtlds -port u_uc_ln_01.xttop.IRam0En                      -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.IRam0LoadStore               -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.IRam0Wr                      -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.IRam0WrData                  -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.DRam0Addr0                   -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.DRam0Busy0                   -clock uc_clk
    config_rtlds -port u_uc_ln_01.xttop.DRam0ByteEn0                 -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.DRam0Data0                   -clock uc_clk
    config_rtlds -port u_uc_ln_01.xttop.DRam0En0                     -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.DRam0Wr0                     -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.DRam0WrData0                 -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.DRam1Addr0                   -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.DRam1Busy0                   -clock uc_clk
    config_rtlds -port u_uc_ln_01.xttop.DRam1ByteEn0                 -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.DRam1Data0                   -clock uc_clk
    config_rtlds -port u_uc_ln_01.xttop.DRam1En0                     -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.DRam1Wr0                     -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.DRam1WrData0                 -clock uc_clk 
    config_rtlds -port u_uc_ln_01.xttop.BInterrupt                   -clock uc_clk
    config_rtlds -port u_uc_ln_01.xttop.PRID                         -clock uc_clk

#    config_rtlds -port u_uc_ln_01.xttop.DBGEN                        -clock PBCLK # input 
#    config_rtlds -port u_uc_ln_01.xttop.NIDEN                        -clock PBCLK # input 
#    config_rtlds -port u_uc_ln_01.xttop.PADDR                        -clock PBCLK # input 
#    config_rtlds -port u_uc_ln_01.xttop.PBCLKEN                      -clock PBCLK # input 
#    config_rtlds -port u_uc_ln_01.xttop.PENABLE                      -clock PBCLK # input 
#    config_rtlds -port u_uc_ln_01.xttop.PRDATA                       -clock PBCLK # output 
#    config_rtlds -port u_uc_ln_01.xttop.PREADY                       -clock PBCLK # output 
#    config_rtlds -port u_uc_ln_01.xttop.PRESETn                      -clock PBCLK # input (reset for APB domain) 
#    config_rtlds -port u_uc_ln_01.xttop.PSEL                         -clock PBCLK # input 
#    config_rtlds -port u_uc_ln_01.xttop.PSLVERR                      -clock PBCLK # output 
#    config_rtlds -port u_uc_ln_01.xttop.PWDATA                       -clock PBCLK # input 
#    config_rtlds -port u_uc_ln_01.xttop.PWRITE                       -clock PBCLK # input 
#    config_rtlds -port u_uc_ln_01.xttop.SPIDEN                       -clock PBCLK # input 
#    config_rtlds -port u_uc_ln_01.xttop.SPNIDEN                      -clock PBCLK # input

    config_rtlds -port u_uc_ln_01.xttop.JTDI                         -clock uc_l01_tap_tck
    config_rtlds -port u_uc_ln_01.xttop.JTDO                         -clock uc_l01_tap_tck
    config_rtlds -port u_uc_ln_01.xttop.JTDOEn                       -clock uc_l01_tap_tck
    config_rtlds -port u_uc_ln_01.xttop.JTMS                         -clock uc_l01_tap_tck
    config_rtlds -port u_uc_ln_01.xttop.JTRST                        -clock uc_l01_tap_tck

#uC lane23
    config_rtlds -port u_uc_ln_23.xttop.BReset                       -clock uc_clk
    config_rtlds -port u_uc_ln_23.xttop.BResetProc_logic             -clock uc_clk
    config_rtlds -port u_uc_ln_23.xttop.BResetProc_synchronized      -clock uc_clk
    config_rtlds -port u_uc_ln_23.xttop.DReset                       -clock uc_clk
    config_rtlds -port u_uc_ln_23.xttop.RunStall                     -clock uc_clk
    config_rtlds -port u_uc_ln_23.xttop.TMode                        -clock uc_clk
    config_rtlds -port u_uc_ln_23.xttop.TModeClkGateOverride         -clock uc_clk
    config_rtlds -port u_uc_ln_23.xttop.softBReset                   -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.PFatalError                  -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.PFaultInfo                   -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.PFaultInfoValid              -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.PWaitMode                    -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.DebugMode                    -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.XOCDMode                     -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.OCDHaltOnReset               -clock uc_clk
    config_rtlds -port u_uc_ln_23.xttop.IRam0Addr                    -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.IRam0Busy                    -clock uc_clk
    config_rtlds -port u_uc_ln_23.xttop.IRam0Data                    -clock uc_clk
    config_rtlds -port u_uc_ln_23.xttop.IRam0En                      -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.IRam0LoadStore               -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.IRam0Wr                      -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.IRam0WrData                  -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.DRam0Addr0                   -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.DRam0Busy0                   -clock uc_clk
    config_rtlds -port u_uc_ln_23.xttop.DRam0ByteEn0                 -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.DRam0Data0                   -clock uc_clk
    config_rtlds -port u_uc_ln_23.xttop.DRam0En0                     -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.DRam0Wr0                     -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.DRam0WrData0                 -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.DRam1Addr0                   -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.DRam1Busy0                   -clock uc_clk
    config_rtlds -port u_uc_ln_23.xttop.DRam1ByteEn0                 -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.DRam1Data0                   -clock uc_clk
    config_rtlds -port u_uc_ln_23.xttop.DRam1En0                     -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.DRam1Wr0                     -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.DRam1WrData0                 -clock uc_clk 
    config_rtlds -port u_uc_ln_23.xttop.BInterrupt                   -clock uc_clk
    config_rtlds -port u_uc_ln_23.xttop.PRID                         -clock uc_clk

#    config_rtlds -port u_uc_ln_23.xttop.DBGEN                        -clock PBCLK # input 
#    config_rtlds -port u_uc_ln_23.xttop.NIDEN                        -clock PBCLK # input 
#    config_rtlds -port u_uc_ln_23.xttop.PADDR                        -clock PBCLK # input 
#    config_rtlds -port u_uc_ln_23.xttop.PBCLKEN                      -clock PBCLK # input 
#    config_rtlds -port u_uc_ln_23.xttop.PENABLE                      -clock PBCLK # input 
#    config_rtlds -port u_uc_ln_23.xttop.PRDATA                       -clock PBCLK # output 
#    config_rtlds -port u_uc_ln_23.xttop.PREADY                       -clock PBCLK # output 
#    config_rtlds -port u_uc_ln_23.xttop.PRESETn                      -clock PBCLK # input (reset for APB domain) 
#    config_rtlds -port u_uc_ln_23.xttop.PSEL                         -clock PBCLK # input 
#    config_rtlds -port u_uc_ln_23.xttop.PSLVERR                      -clock PBCLK # output 
#    config_rtlds -port u_uc_ln_23.xttop.PWDATA                       -clock PBCLK # input 
#    config_rtlds -port u_uc_ln_23.xttop.PWRITE                       -clock PBCLK # input 
#    config_rtlds -port u_uc_ln_23.xttop.SPIDEN                       -clock PBCLK # input 
#    config_rtlds -port u_uc_ln_23.xttop.SPNIDEN                      -clock PBCLK # input

    config_rtlds -port u_uc_ln_23.xttop.JTDI                         -clock uc_l23_tap_tck
    config_rtlds -port u_uc_ln_23.xttop.JTDO                         -clock uc_l23_tap_tck
    config_rtlds -port u_uc_ln_23.xttop.JTDOEn                       -clock uc_l23_tap_tck
    config_rtlds -port u_uc_ln_23.xttop.JTMS                         -clock uc_l23_tap_tck
    config_rtlds -port u_uc_ln_23.xttop.JTRST                        -clock uc_l23_tap_tck

    # set synchronous clock groups
    
    #---------------------------------------------------------------------------------------------------------------------------------#
    #                                                         False paths                                                             #
    #---------------------------------------------------------------------------------------------------------------------------------#
    #config_rtlds -signal -false_path -through {u_dtb_mux.dtb_data} -to {u_pcs_top.u_phy_pcs_reg_ctrl.u_pcs_cdb_reg.sys_prdata}
    #config_rtlds -signal -false_path                               -to {dtb_data}
    
    #config_rtlds -signal -false_path -to {cmnda_vclk}
    #config_rtlds -signal -false_path -to {vclk}
    #

    #config_rtlds -signal -false_path -from {uc_clk} -to {vclk_ana}
    config_rtlds -signal -false_path -to {vclk_ana}

    # RxStatus drivers on RefClk
    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_0.mp_pcs_original.i_rcv_det.ref_rx_status
    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_1.mp_pcs_original.i_rcv_det.ref_rx_status
    
    # Clock is off at destination when source changes value
    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_0.mp_pcs_serdes.i_pwr_rate_ctrl.cur_pipe_rate -to pipe7_l00_rx_data
    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_1.mp_pcs_serdes.i_pwr_rate_ctrl.cur_pipe_rate -to pipe7_l01_rx_data

    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_0.mp_pcs_serdes.i_pwr_rate_ctrl.cur_pipe_rate -to u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_tx_dsync.u_sa_sync_fifo_v1.fifo_array
    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_1.mp_pcs_serdes.i_pwr_rate_ctrl.cur_pipe_rate -to u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_tx_dsync.u_sa_sync_fifo_v1.fifo_array
    
    
    # CTC buffer related
    config_rtlds -signal -false_path -from "u_mp_pcs_top_ln_0.mp_pcs_original.i_rpcs.i_rctc.fifo_reg\[*\]"
    config_rtlds -signal -false_path -from "u_mp_pcs_top_ln_1.mp_pcs_original.i_rpcs.i_rctc.fifo_reg\[*\]"
    
    config_rtlds -signal -false_path -from "u_mp_pcs_top_ln_0.mp_pcs_original.i_rpcs.i_128b_rctc.fifo_reg\[*\]"
    config_rtlds -signal -false_path -from "u_mp_pcs_top_ln_1.mp_pcs_original.i_rpcs.i_128b_rctc.fifo_reg\[*\]"
    #check_cdc -signal_config -add_false_path -from "u_mp_pcs_top_ln_1.mp_pcs_original.i_rpcs.i_rctc.fifo_reg\[*\]\[*\]"
    
    # Isolation register read paths for message bus emulate
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

    # Isolation register write paths for message bus emulate
    config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_0.phy_pipe_iso_lm_mac2phy -to u_mp_pcs_top_ln_0.message_bus.u_cdnsdru_usb4_message_bus_pipe_rx_ctrl_v4.mb_pipe_rx_data_reg1
    config_rtlds -signal -false_path -from u_pcs_iso_ctrl_ln_2.phy_pipe_iso_lm_mac2phy -to u_mp_pcs_top_ln_1.message_bus.u_cdnsdru_usb4_message_bus_pipe_rx_ctrl_v4.mb_pipe_rx_data_reg1


    config_rtlds -signal -false_path -through u_mp_pcs_top_ln_0.pipe4_usb_lpbkslv_ec -to u_pcs_iso_ctrl_ln_0.cdb_prdata
    config_rtlds -signal -false_path -through u_mp_pcs_top_ln_1.pipe4_usb_lpbkslv_ec -to u_pcs_iso_ctrl_ln_2.cdb_prdata

    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_0.mp_pcs_original.i_cmn_if.phystatus_int        -to pipe4_l00_phy_status
    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_0.mp_pcs_original.i_pwr_rate_ctrl.phystatus_ref -to pipe4_l00_phy_status
    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_0.mp_pcs_original.i_rcv_det.p_phy_status        -to pipe4_l00_phy_status
    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_0.mp_pcs_original.i_rcv_det.ref_phy_status      -to pipe4_l00_phy_status

    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_1.mp_pcs_original.i_cmn_if.phystatus_int        -to pipe4_l01_phy_status
    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_1.mp_pcs_original.i_pwr_rate_ctrl.phystatus_ref -to pipe4_l01_phy_status
    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_1.mp_pcs_original.i_rcv_det.p_phy_status        -to pipe4_l01_phy_status
    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_1.mp_pcs_original.i_rcv_det.ref_phy_status      -to pipe4_l01_phy_status



    # tx_swing & tx_margin
    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_0.message_bus.u_cdnsdru_usb4_message_bus_gen_reg_ctrl_v4.phy_reg402
    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_0.message_bus.u_cdnsdru_usb4_message_bus_gen_reg_ctrl_v4.phy_reg403
    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_0.message_bus.u_cdnsdru_usb4_message_bus_gen_reg_ctrl_v4.phy_reg404
    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_0.message_bus.u_cdnsdru_usb4_message_bus_gen_reg_ctrl_v4.phy_reg408
    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_0.message_bus.u_cdnsdru_usb4_message_bus_gen_reg_ctrl_v4.phy_reg409

    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_1.message_bus.u_cdnsdru_usb4_message_bus_gen_reg_ctrl_v4.phy_reg402
    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_1.message_bus.u_cdnsdru_usb4_message_bus_gen_reg_ctrl_v4.phy_reg403
    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_1.message_bus.u_cdnsdru_usb4_message_bus_gen_reg_ctrl_v4.phy_reg404
    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_1.message_bus.u_cdnsdru_usb4_message_bus_gen_reg_ctrl_v4.phy_reg408
    config_rtlds -signal -false_path -from u_mp_pcs_top_ln_1.message_bus.u_cdnsdru_usb4_message_bus_gen_reg_ctrl_v4.phy_reg409
    
    # Async PIPE pins
    config_rtlds -signal -false_path -to pipe7_l00_rx_elec_idle
    config_rtlds -signal -false_path -to pipe7_l01_rx_elec_idle
    config_rtlds -signal -false_path -to pipe4_l00_rx_elec_idle
    config_rtlds -signal -false_path -to pipe4_l01_rx_elec_idle

    # pipe_clk_div_override only toggles when dest clock is off
    #config_rtlds -signal -false_path -from u_mp_pcs_top_ln_0.mp_pcs_original.i_pwr_rate_ctrl.pipe_clk_div_override \
    #                                 -to   u_mp_pcs_top_ln_0.mp_pcs_original.i_cmn_if.pipe_smpl_pt

    #config_rtlds -signal -false_path -from u_mp_pcs_top_ln_0.mp_pcs_original.i_pwr_rate_ctrl.pipe_clk_div_override \
    #                                 -to   u_mp_pcs_top_ln_0.mp_pcs_original.i_cmn_if.td_started                                   

    #config_rtlds -signal -false_path -from u_mp_pcs_top_ln_1.mp_pcs_original.i_pwr_rate_ctrl.pipe_clk_div_override \
    #                                 -to   u_mp_pcs_top_ln_1.mp_pcs_original.i_cmn_if.pipe_smpl_pt

    #config_rtlds -signal -false_path -from u_mp_pcs_top_ln_1.mp_pcs_original.i_pwr_rate_ctrl.pipe_clk_div_override \
    #                                 -to   u_mp_pcs_top_ln_1.mp_pcs_original.i_cmn_if.td_started     
    
    #the related PMA signals connected to cdb_bus. Used for debug.
    config_rtlds -signal -false_path -from u_mp_pma.u_pma_rev.u_cmn.* \
                                     -to   u_pma_iso_ctrl_ln_?.cdb_prdata
    config_rtlds -signal -false_path -to u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly?.u_xcvr_cdb.u_cdb_local_bridge_tx.cdb_prdata
    config_rtlds -signal -false_path -to u_mp_pma.u_pma_rev.u_cmn.u_cmn_cdb.u_cdb_local_bridge.cdb_prdata
    config_rtlds -signal -false_path -to u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_xcvr_cdb.u_cdb_local_bridge_tx.cdb_prdata
    config_rtlds -signal -false_path -to u_pma_iso_ctrl_ln_?.cdb_prdata
    config_rtlds -signal -false_path -to u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane?.u_xcvr_cdb.u_cdb_local_bridge_rx.cdb_prdata                                     
    config_rtlds -signal -false_path -to phy_interrupt_usb                                     
    config_rtlds -signal -false_path -to phy_interrupt_dp                                     

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

    # phy_pipe_lm_ctrl_sts[4:0] are all mb reset for debug purpose
    # phy_pipe_ctrl_sts[7] is override message bus enable; m2p_msg_start only active after phy_pipe_ctrl_sts[7] asserted 
    # phy_pma_rx_mrgn_ctrl[16] comes from PMA, has no relationship with above signals.
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
                                     u_pma_iso_ctrl_ln_1.phy_pma_xcvr_ctrl_reg[18]}
    # u_mp_pma.rx_signal_detect_ln_0
    
    config_rtlds -signal -exclusive {u_pcs_iso_ctrl_ln_2.phy_pipe_lm_ctrl_sts[0] \
                                     u_pcs_iso_ctrl_ln_2.phy_pipe_lm_ctrl_sts[1] \
                                     u_pcs_iso_ctrl_ln_2.phy_pipe_lm_ctrl_sts[2] \
                                     u_pcs_iso_ctrl_ln_2.phy_pipe_lm_ctrl_sts[3] \
                                     u_pcs_iso_ctrl_ln_2.phy_pipe_lm_ctrl_sts[4] \
                                     u_pcs_iso_ctrl_ln_2.u_psync_pipe_mb_rx_eq_eval_cmpl.data_toggle \
                                     u_pcs_iso_ctrl_ln_2.u_psync_pipe_mb_phy_iorecal_request.data_toggle \
                                     u_pcs_iso_ctrl_ln_2.u_psync_pipe_mb_iorecal_done.data_toggle \
                                     u_pcs_iso_ctrl_ln_2.u_psync_pipe_mb_rx_eq_training_cmpl_stb.data_toggle \
                                     u_pcs_iso_ctrl_ln_2.m2p_msg_start \
                                     u_pcs_iso_ctrl_ln_2.phy_pipe_ctrl_sts[7] \
                                     u_pma_iso_ctrl_ln_2.phy_pma_rx_mrgn_ctrl[16] \
                                     u_pma_iso_ctrl_ln_2.phy_pma_xcvr_ctrl_reg[18]}
    # u_mp_pma.rx_signal_detect_ln_1
    

#2025/10/6 Suhang ADD, From Whistler PMA
    config_rtlds -signal -exclusive {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd.u_cmn_cdiag_ovrd_cdb_regs.cmn_cdiag_diag_pwri_ovrd_reg[15] \
                                     u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd.u_cmn_cdiag_ovrd_cdb_regs.cmn_cdiag_diag_pwri_ovrd_reg[11] \
                                     u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd.u_cmn_cdiag_ovrd_cdb_regs.cmn_cdiag_diag_pwri_ovrd_reg[9]}
    
  #2025/10/11 jinsong ADD, From Whistler PMA
#    config_rtlds -signal -exclusive     {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_ctrl.rx_psc_out_en_d1 \
#                                         u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_ana_ctrl_sm_v2_top_epath.u_ree_ana_ctrl_sm_v2.st_current_state[2] \
#                                         u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.xcvr_lane_suspend_selected}

#check_cdc -signal_config -add_exclusive {u_pma_rev.u_xcvr_la.u_xcvr_ctrl.rx_psc_out_en_d1 \
#                                         u_pma_rev.u_xcvr_la.u_xcvr_ctrl.activate_rx_data_blank \
#                                         u_pma_rev.u_xcvr_la.xcvr_lane_suspend_selected}

    
    #---------------------------------------------------------------------------------------------------------------------------------#
    #                                                     Define synchronizers                                                        #
    #---------------------------------------------------------------------------------------------------------------------------------#
    #check_cdc -scheme -add fifo -map {{Wfull push_full} {Rempty pop_empty} {Winc push} {Rinc pop} \
    #                                  {Wptr wptr_gray} {Rptr rptr_gray} {Wdata pushd} {Rdata popd}} \
    #                                   -module cdnsdru_async_fifo_v0$SUFFIX
    
    check_cdc -scheme -add ndff -map {{dout dest_dat} {data source_dat}} -module phy_mb_data_sync$SUFFIX                                  
    check_cdc -scheme -add ndff -map {{dout d_out} {data d_in}} -module phy_data_sync$SUFFIX
    check_cdc -scheme -add ndff -map {{dout reset_out_n} {data reset_in_n}} -module phy_reset_sync$SUFFIX
    check_cdc -scheme -add ndff -map {{dout reset_out_n} {data reset_in_n}} -module cdnsdru_reset_sync_v0$SUFFIX
    check_cdc -scheme -add ndff -map {{dout d_out}       {data d_in}}       -module cdnsdru_data_sync_v0$SUFFIX

    #check_cdc -scheme -add ndff -map {{data enq_data} {dout deq_data}} \
    #                                   -module cdnsdru_sa_sync_fifo_v1_v0$SUFFIX
    
    # Signals which are gray coded
    #check_cdc -signal_config -add_gray_code {
    #                                         u_pcs_top.u_rx_top.utmi_rx_intf_i.rx_buffer.wptr_gray[0] \
    #                                         u_pcs_top.u_rx_top.utmi_rx_intf_i.rx_buffer.wptr_gray[1] \
    #                                         u_pcs_top.u_rx_top.utmi_rx_intf_i.rx_buffer.wptr_gray[2] \
    #                                         u_pcs_top.u_rx_top.utmi_rx_intf_i.rx_buffer.wptr_gray[3] 
    #                                         }
    
    
    
}
