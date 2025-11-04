
#assign reset_cmn_tmpsns_filt_reset_n = cmn_reset_sync_n & cmn_diag_power_reset_n;
#check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_tmpsns_filt_reset_n -tag RST_IS_DCMB -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_tmpsns_filt_reset_n} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_tmpsns_filt_reset_n.genblk1.reset_sync_flop[0]}} -comment {cmn_diag_power_reset_n will deassert after the cmn_reset_sync_n ,so no glitch happened}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst -tag RST_IS_DCMB -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_tmpsns_filt_reset_n} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_tmpsns_filt_reset_n.genblk1.reset_sync_flop[0]}} -comment {cmn_diag_power_reset_n will deassert after the cmn_reset_sync_n ,so no glitch happened}

#assign reset_cmn_sd_clk_cal_fb_clk_reset_n = cmn_reset_sync_n & ccal_isl_power_reset_nsr_n;
#check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_sd_clk_cal_fb_clk_reset_n -tag RST_IS_DCMB -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_sd_clk_cal_fb_clk_reset_n} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_sd_clk_cal_fb_clk_reset_n.genblk1.reset_sync_flop[0]}} -comment {ccal_isl_power_reset_nsr_n will deassert after the cmn_reset_sync_n ,so no glitch happened}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst -tag RST_IS_DCMB -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_sd_clk_cal_fb_clk_reset_n} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_sd_clk_cal_fb_clk_reset_n.genblk1.reset_sync_flop[0]}} -comment {ccal_isl_power_reset_nsr_n will deassert after the cmn_reset_sync_n ,so no glitch happened}

#assign reset_cdb_preset_diag_isl_synced_cdbclk_n = cmn_cdb_preset_n & diag_isl_power_reset_nsr_n;
#check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cdb_preset_diag_isl_synced_cdbclk -tag RST_IS_DCMB -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cdb_preset_diag_isl_synced_cdbclk_n} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cdb_preset_diag_isl_synced_cdbclk.genblk1.reset_sync_flop[0]}} -comment {diag_isl_power_reset_nsr_n will deassert after the cmn_reset_sync_n ,so no glitch happened}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst -tag RST_IS_DCMB -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cdb_preset_diag_isl_synced_cdbclk_n} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cdb_preset_diag_isl_synced_cdbclk.genblk1.reset_sync_flop[0]}} -comment {aaa ddd }


#assign reset_cmn_pll0_vcocal_fbdiv_clk_reset_n = cmn_pll0_reset_sync_n & pllc_isl_power_reset_wsr_n;
#check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_pll0_vcocal_fbdiv_clk_reset_n -tag RST_IS_DCMB -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_pll0_vcocal_fbdiv_clk_reset_n} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_pll0_vcocal_fbdiv_clk_reset_n.genblk1.reset_sync_flop[0]}} -comment {pllc_isl_power_reset_wsr_n will deassert after the cmn_pll0_reset_sync_n ,so no glitch happened}


check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst -tag RST_IS_DCMB -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_pll0_vcocal_fbdiv_clk_reset_n} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_pll0_vcocal_fbdiv_clk_reset_n.genblk1.reset_sync_flop[0]}} -comment {pllc_isl_power_reset_wsr_n will deassert after the cmn_pll0_reset_sync_n ,so no glitch happened}



#assign reset_cmn_pll0_vcocal_ref_clk_reset_n = cmn_pll0_reset_sync_n & pllc_isl_power_reset_wsr_n;
check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst -tag RST_IS_DCMB -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_pll0_vcocal_ref_clk_reset_n} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_pll0_vcocal_ref_clk_reset_n.genblk1.reset_sync_flop[0]}} -comment {pllc_isl_power_reset_wsr_n will deassert after the cmn_pll0_reset_sync_n ,so no glitch happened}

#assign reset_cmn_pll0_lock_det_fbdiv_clk_reset_n = cmn_pll0_reset_sync_n & pllc_isl_power_reset_nsr_n;
check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst -tag RST_IS_DCMB -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_pll0_lock_det_fbdiv_clk_reset_n} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_pll0_lock_det_fbdiv_clk_reset_n.genblk1.reset_sync_flop[0]}} -comment {pllc_isl_power_reset_wsr_n will deassert after the cmn_pll0_reset_sync_n ,so no glitch happened}

#assign reset_cmn_pll0_lock_det_ref_clk_reset_n = cmn_pll0_reset_sync_n & pllc_isl_power_reset_nsr_n;
check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst -tag RST_IS_DCMB -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_pll0_lock_det_ref_clk_reset_n} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_pll0_lock_det_ref_clk_reset_n.genblk1.reset_sync_flop[0]}} -comment {pllc_isl_power_reset_wsr_n will deassert after the cmn_pll0_reset_sync_n ,so no glitch happened}

#assign reset_cmn_hs_rst_rel_sm_reset_n = xcvrc_isl_power_reset_nsr_n & cmn_reset_sync_n;
check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst -tag RST_IS_DCMB -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_hs_rst_rel_sm_reset_n} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_hs_rst_rel_sm_reset_n.genblk1.reset_sync_flop[0]}} -comment {xcvrc_isl_power_reset_nsr_n will deassert after the cmn_pll0_reset_sync_n ,so no glitch happened}




#assign reset_pllsm0_nsr_reset_n = cmn_pll0_reset_sync_n & pllc_isl_power_reset_nsr_n;
check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst -tag RST_IS_DCMB -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_pllsm0_nsr_reset_n} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_pllsm0_nsr_reset_n.genblk1.reset_sync_flop[0]}} -comment {pllc_isl_power_reset_nsr_n will deassert after the cmn_pll0_reset_sync_n ,so no glitch happened}

#assign reset_pllsm0_wsr_reset_n = cmn_pll0_reset_sync_n & pllc_isl_power_reset_wsr_n;
#check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_pllsm0_wsr_reset_n -tag RST_IS_DCMB -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_pllsm0_wsr_reset_n} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_pllsm0_wsr_reset_n.genblk1.reset_sync_flop[0]}} -comment {pllc_isl_power_reset_wsr_n will deassert after the cmn_pll0_reset_sync_n ,so no glitch happened}
check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst -tag RST_IS_DCMB -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_pllsm0_wsr_reset_n} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_pllsm0_wsr_reset_n.genblk1.reset_sync_flop[0]}} -comment {pllc_isl_power_reset_wsr_n will deassert after the cmn_pll0_reset_sync_n ,so no glitch happened}

#assign reset_pllsm1_wsr_reset_n = cmn_pll1_reset_sync_n & pllc_isl_power_reset_wsr_n;
#check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_pllsm1_wsr_reset_n -tag RST_IS_DCMB -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_pllsm1_wsr_reset_n} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_pllsm1_wsr_reset_n.genblk1.reset_sync_flop[0]}} -comment {pllc_isl_power_reset_wsr_n will deassert after the cmn_pll1_reset_sync_n ,so no glitch happened}
check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst -tag RST_IS_DCMB -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_pllsm1_wsr_reset_n} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_pllsm1_wsr_reset_n.genblk1.reset_sync_flop[0]}} -comment {pllc_isl_power_reset_wsr_n will deassert after the cmn_pll1_reset_sync_n ,so no glitch happened}





#assign reset_cmn_ccal_power_reset_n = cmn_reset_sync_n & ccal_isl_power_reset_nsr_n;
#check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_ccal_power_reset_n -tag RST_IS_DCMB -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_ccal_power_reset_n} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_ccal_power_reset_n.genblk1.reset_sync_flop[0]}} -comment {ccal_isl_power_reset_nsr_n will deassert after the cmn_reset_sync_n,so no glitch happened}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst -tag RST_IS_DCMB -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_ccal_power_reset_n} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_ccal_power_reset_n.genblk1.reset_sync_flop[0]}} -comment {ccal_isl_power_reset_nsr_n will deassert after the cmn_reset_sync_n,so no glitch happened}

#assign reset_cmn_diag_power_reset_n = cmn_reset_sync_n & diag_isl_power_reset_nsr_n;
#check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_diag_power_reset_n -tag RST_IS_DCMB -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_diag_power_reset_n} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_diag_power_reset_n.genblk1.reset_sync_flop[0]}} -comment {diag_isl_power_reset_nsr_n will deassert after the cmn_reset_sync_n,so no glitch happened}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst -tag RST_IS_DCMB -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_diag_power_reset_n} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_diag_power_reset_n.genblk1.reset_sync_flop[0]}} -comment {diag_isl_power_reset_nsr_n will deassert after the cmn_reset_sync_n,so no glitch happened}






#reset signal output to the apb register for debug only
check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn -tag RST_IS_DDAF -comment {reset signal connect to apb register for debug only}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_func -tag RST_IS_DDAF -comment {reset signal connect to apb register for debug only}


check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn -tag RST_IS_DDAF -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cdb_isl_ctrl_sm_reset_n.u_scan_mux.fcn_signal_out} {u_mp_pma.u_pma_rev.u_cmn.u_pwr_isl_ctrl_sm_icfg_diag.u_cdnsdru_pwr_isl_ctrl_sm_v3.pwr_isl_ctrl_current_state[0]} {flip-flop} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_cdb.u_cdb_local_bridge.cdb_prdata[1]}} -comment {reset signal connect to apb register for debug only}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn -tag RST_IS_DDAF -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_pll0_vcocal_ref_clk_reset_n.u_scan_mux.fcn_signal_out} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_clk_gating_cell_cmn_pll0_vcocal_ref_clk.genblk1.u_data_sync_en_sync.genblk1.data_sync_flop[0]} {flip-flop} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_cdb.u_cdb_local_bridge.cdb_prdata[1]}} -comment {reset signal connect to apb register for debug only}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn -tag RST_IS_DDAF -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.u_scan_mux.fcn_signal_out} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_startup_sm_v4_top.u_data_sync_ssm_pre_auto_cal_en_ovrd.genblk1.data_sync_flop[0]} {flip-flop} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_cdb.u_cdb_local_bridge.cdb_prdata[0]}} -comment {reset signal connect to apb register for debug only}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn -tag RST_IS_DDAF -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_pll0_lock_det_ref_clk_reset_n.u_scan_mux.fcn_signal_out} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_pll_lock_detect_v4_top.u_pll_lock_detect_v4.u_data_sync_enable_lock_detect_refclk.genblk1.data_sync_flop[0]} {flip-flop} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_cdb.u_cdb_local_bridge.cdb_prdata[0]}} -comment {reset signal connect to apb register for debug only}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_func -tag RST_IS_DDAF -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_tmpsns_filt_reset_n.u_scan_mux.fcn_signal_out} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_clk_gating_cell_cmn_tmpsns_filt_clk.genblk3.u_data_delay_en_ack.data_delay_flop[0]} {flip-flop} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_cdb.u_cdb_local_bridge.cdb_prdata[13]}} -comment {reset signal connect to apb register for debug only}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_func -tag RST_IS_DDAF -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_ccal_power_reset_n.u_scan_mux.fcn_signal_out} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_pd_icfg.u_tx_rescal_ctrl_pd.u_bin_cal.cal_run_d1} {flip-flop} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_cdb.u_cdb_local_bridge.cdb_prdata[12]}} -comment {reset signal connect to apb register for debug only}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_func -tag RST_IS_DDAF -argument {{u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_ccal_power_reset_n.u_scan_mux.fcn_signal_out} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_pd_icfg.u_tx_rescal_ctrl_pd.u_bin_cal.cal_run_d1} {flip-flop} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_cdb.u_cdb_local_bridge.cdb_prdata[10]}} -comment {reset signal connect to apb register for debug only}




#internal generate clock error waiver
check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst -tag CLK_NO_INPT -argument {{cmn_clkrst} {selected_div_ref_clk} {cmn_ref_clk_gated_ack_d1}} -comment {selected_div_ref_clk is a intenal generated clock}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst -tag CLK_NO_INPT -argument {{cmn_clkrst} {cmnda_ref_clk_gated} {cmn_ref_clk_active_sr_flop}} -comment {cmnda_ref_clk_gated is a intenal generated clock }

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst -tag CLK_NO_INPT -argument {{cmn_clkrst} {cmnda_ref_clk_scanned} {pre_ref_clk_dis_synced_d1}} -comment {cmnda_ref_clk_scanned is a internal generate clock}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn -tag CLK_NO_INPT -argument {{cmn} {cmn_ssm_clk} {cmnda_bias_bandgap_en_hold}} -comment {cmn_ssm_clk is a internal generate clock}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn -tag CLK_NO_INPT -argument {{cmn} {cmn_ssm_clk_gated} {cdb_por_recovery_req}} -comment {cmn_ssm_clk_gated is a internal generate clock}


check_superlint -waiver -add -tag SIG_IS_MDRV -argument {{ana_atb_0}} -comment {ana_atb_0 from analog}
check_superlint -waiver -add -tag SIG_IS_MDRV -argument {{ana_atb_1}} -comment {ana_atb_1 from analog}


#warning waiver
check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl -tag OTP_UC_INST -argument {{pllsmda_pll_alt_en} {cdnsdru_pll_ctrl_sm_v3_top} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl_sm_v3_top}} -comment {output not used when instance pll control}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl -tag OTP_UC_INST -argument {{pllsmda_pll_reg_en} {cdnsdru_pll_ctrl_sm_v3_top} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl_sm_v3_top}} -comment {output not used when instance pll control}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl -tag OTP_UC_INST -argument {{pllsm_user_def_ctrl[11:1]} {cdnsdru_pll_ctrl_sm_v3_top} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl_sm_v3_top}} -comment {pllsm_user_def_ctrl[11:1] not used when instance pll control}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_ring_cmn_pll1_ctrl.u_ring_pll_ctrl_sm_v0_top.u_ring_pll_ctrl_sm_v0_cdb_regs -tag OTP_UC_INST -argument {{cdb_pwrite_en[10]} {cdnsdru_cdb_slave_var_v0} {u_mp_pma.u_pma_rev.u_cmn.u_ring_cmn_pll1_ctrl.u_ring_pll_ctrl_sm_v0_top.u_ring_pll_ctrl_sm_v0_cdb_regs.u_cdb_slave}} -comment {cdb_pwrite_en_1010_readonly not used, this address only use read-only register}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_pll_var_trm_wrapper.u_pll_var_trm -tag OTP_UC_INST -argument {{vco_cal_ana_enable} {cdnsdru_vco_cal_sm_v4_v0} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_pll_var_trm_wrapper.u_pll_var_trm.u_vco_cal_sm_v4_var_trm}} -comment {vco_cal_ana_enable not used in our project ,but it is a output in the reused module cdnsdru_vco_cal_sm_v4_v0}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl -tag OTP_UC_INST -argument {{pll_lock_det_en_ack} {cdnsdru_pll_lock_detect_v4_top} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_pll_lock_detect_v4_top}} -comment {reused ip output not used}

#In bg binary cal, we add ana_cal_filter, so the input from analog no long need sync
check_superlint -waiver -add -module cdnsdru_data_sync_v0:(NUM_FLOPS=0) -tag INP_NO_USED -argument {{reset_n} {module} {cdnsdru_data_sync_v0}} -comment {no need sync again in the bg calibration}

#u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_clk_gating_cell_cmn_cdb_pclk_gated
check_superlint -waiver -add -module cdnsdru_clk_gating_cell_v0:(NUM_SYNC_FLOPS=0,NUM_ACK_FLOPS=0) -tag INP_NO_USED -argument {{reset_n} {module} {cdnsdru_clk_gating_cell_v0}} -comment {no need sync again in the clock gating cell}

#u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_clock_div_prog_ssm_clk.upstream_reset_in_n
#NO_CLOCK_DIV_RESET set to 1 so the upstream_reset_in_n is not used.
check_superlint -waiver -add -module cdnsdru_clock_div_prog_v0:(NO_CLOCK_DIV_RESET=1,DIV_CTRL_WIDTH=4) -tag INP_NO_USED -argument {{upstream_reset_in_n} {module} {cdnsdru_clock_div_prog_v0}} -comment {NO_CLOCK_DIV_RESET set to 1 so the upstream_reset_in_n is not used.}

check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{rx_eq_eval_ln_0} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {rx signal not use in the txonly lane}


#common ana power input pin waiver if nlint not define CDNS_PMA_PWR_AWARE
check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn -tag INP_UC_INST -argument {{agnd} {cmn_ana} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana}} -comment {common ana power input pin waiver if nlint not define CDNS_PMA_PWR_AWARE}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn -tag INP_UC_INST -argument {{avdd} {cmn_ana} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana}} -comment {common ana power input pin waiver if nlint not define CDNS_PMA_PWR_AWARE}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn -tag INP_UC_INST -argument {{avdd_clk} {cmn_ana} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana}} -comment {common ana power input pin waiver if nlint not define CDNS_PMA_PWR_AWARE}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn -tag INP_UC_INST -argument {{avdd_h} {cmn_ana} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana}} -comment {common ana power input pin waiver if nlint not define CDNS_PMA_PWR_AWARE}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn -tag INP_UC_INST -argument {{cmn_aonvdd} {cmn_ana} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana}} -comment {common ana power input pin waiver if nlint not define CDNS_PMA_PWR_AWARE}


#some reused module in the pll_var_trm is not used
check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_pll_var_trm_wrapper.u_pll_var_trm -tag OTP_UC_INST -comment {some reused module in the pll_var_trm is not used}

#IO signal warning waive
check_superlint -waiver -add -module cmn -tag PRT_NR_IOPT -comment {common inout signal warning waive}
check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag PRT_NR_IOPT -comment {pma_rev_22 inout signal warning waive}
check_superlint -waiver -add -module cdn_sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z -tag PRT_NR_IOPT -comment {pma_top_22 inout signal warning waive}

#some bit in the drive signal not used 
check_superlint -waiver -add -module cmn -tag WIR_NO_READ -comment {some apb bits in the drive signal not used}
check_superlint -waiver -add -module cmn_fdiag_ovrd -tag WIR_NO_READ -comment {some apb bits in the drive signal not used}
check_superlint -waiver -add -module cmn_func -tag WIR_NO_READ -comment {some apb bits in the drive signal not used}
check_superlint -waiver -add -module cmn_cdiag_ovrd_cdb_regs -tag WIR_NO_READ -comment {some apb bits in the drive signal not used}
check_superlint -waiver -add -module cmn_cdb -tag WIR_NO_READ -comment {some apb bits in the drive signal not used}
check_superlint -waiver -add -module cmn_cdiag_ovrd -tag WIR_NO_READ  -comment {some apb bits in the drive signal not used}
check_superlint -waiver -add -module cmn_ctrl -tag WIR_NO_READ -comment {some apb bits in the drive signal not used}

check_superlint -waiver -add -module tx_rescal_ctrl_pd_icfg -tag WIR_NO_READ -comment {reused module, some output bits not used}
check_superlint -waiver -add -module rx_rescal_ctrl_icfg -tag WIR_NO_READ -comment {reused module, some output bits not used}
check_superlint -waiver -add -module cmn_ibiascal_icfg -tag WIR_NO_READ -comment {reused module, some output bits not used}
check_superlint -waiver -add -module pll_var_trm -tag WIR_NO_READ -comment {reused module, some output bits not used}


#warning waiver, input not used, preserve for future extension
check_superlint -waiver -add -module ring_pll_ctrl_cdb_regs -tag INP_NO_USED -argument {{cdb_paddr[1:0]} {module} {ring_pll_ctrl_cdb_regs}} -comment {cdb_paddr[1:0] not used in this module}

check_superlint -waiver -add -module bg_cal_ctrl_apb_icfg -tag INP_NO_USED -argument {{cdb_paddr[4]} {module} {bg_cal_ctrl_apb_icfg}} -comment {cdb_paddr[4] is not used}

check_superlint -waiver -add -module pll_ctrl_cdb_regs -tag INP_NO_USED -argument {{cdb_paddr[1:0]} {module} {pll_ctrl_cdb_regs}} -comment {cdb_paddr[1:0] is not used}

check_superlint -waiver -add -module cmn_ibiascal_icfg -tag INP_NO_USED -argument {{cdb_paddr[4]} {module} {cmn_ibiascal_icfg}} -comment {cdb_paddr[4] is not used}

check_superlint -waiver -add -module rx_rescal_ctrl_icfg -tag INP_NO_USED -argument {{cdb_paddr[4:3]} {module} {rx_rescal_ctrl_icfg}} -comment {cdb_paddr[4:3] is not used}

check_superlint -waiver -add -module tx_rescal_ctrl_pd_icfg -tag INP_NO_USED -argument {{cdb_paddr[4:3]} {module} {tx_rescal_ctrl_pd_icfg}} -comment {cdb_paddr[4:3] is not used}

#reused ip output not used
check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl -tag OTP_UC_INST -argument {{cmn_cdiag_ccal_pwri_ovrd_reg[13:12]} {cmn_cdiag_ovrd} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd}} -comment {some output bits not used in power island override register}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl -tag OTP_UC_INST -argument {{cmn_cdiag_ccal_pwri_ovrd_reg[10]} {cmn_cdiag_ovrd} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd}} -comment {some output bits not used in power island override register}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl -tag OTP_UC_INST -argument {{cmn_cdiag_ccal_pwri_ovrd_reg[8]} {cmn_cdiag_ovrd} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd}} -comment {some output bits not used in power island override register}


#keep rx signal in the tx-only lane lane0/3
check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{rx_bscan_pc_ln_0} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {rx_bscan_pc_ln_0/3 is not used in txonly lane3}
check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{rx_bscan_pc_ln_3} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {rx_bscan_pc_ln_0/3 is not used in txonly lane3}

check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{rx_eq_training_data_valid_ln_3} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {rx signal is not used in tx only lane}

check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{rx_termination_ln_3} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {rx signal is not used in tx only lane}

check_superlint -waiver -add -module tx_rescal_ctrl_pu_icfg -tag INP_NO_USED -argument {{cdb_paddr[4:3]} {module} {tx_rescal_ctrl_pu_icfg}} -comment {cdb_paddr[4:3] is not used}

check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{rx_bscan_ac_ln_0} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {keep rx_bscan_ac_ln_0}

check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{rx_bscan_tdi_ln_0} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {keep rx_bscan_tdi_ln_0}

check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{rx_differential_invert_ln_3} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {keep rx_differential_invert_ln_3}

check_superlint -waiver -add  -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{rx_eq_training_ln_3} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {keep rx_eq_training_ln_3}

check_superlint -waiver -add  -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{rx_eq_training_ln_0} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {rx_eq_trainging_ln_0 is not used }

check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{rx_eq_eval_ln_3} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {keep}

check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{rx_invalid_request_ln_3} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {keep }

check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{rx_bscan_ac_ln_3} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {keep}

check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{rx_bscan_tdi_ln_3} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {keep}

check_superlint -waiver -add -tag INP_NO_USED -argument {{rx_bscan_shiftdr_ln_3} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {keep rx_bscan_shiftdr_ln_3 in txonly lane }

check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{xcvr_standard_mode_ln_3[2]} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {xcvr_standard_mode_ln_3[2] is not used in txonly lane}

check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{xcvr_standard_mode_ln_0[2]} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {xcvr_standard_mode_ln_0[2] is not used in txonly lane}

check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{rx_eq_training_data_valid_ln_0} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {keep}

check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{rx_termination_ln_0} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {keep}

check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{rx_differential_invert_ln_0} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {keep}

check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{rx_invalid_request_ln_0} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {keep}

check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{rx_bscan_shiftdr_ln_0} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {keep }

check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{rx_bscan_clockdr_ln_0} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {keep }

check_superlint -waiver -add -module sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100 -tag INP_NO_USED -argument {{rx_bscan_clockdr_ln_3} {module} {sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z_r100}} -comment {keep  }



#output not used warning
check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst -tag OTP_UC_INST -argument {{en_ack} {cdnsdru_clk_gating_cell_v0} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_clk_gating_cell_cmn_cdb_pclk}} -comment {clk gating output en_ack not used}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst -tag OTP_UC_INST -argument {{en_ack} {cdnsdru_clk_gating_cell_v0} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_clk_gating_cell_cmn_cdb_pclk_gated}} -comment {clk gating output en_ack not used}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_bg_cal_ctrl_apb_icfg -tag OTP_UC_INST -argument {{da_ana_cal_clk} {cdnsdru_bin_cal_apb_v0} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_bg_cal_ctrl_apb_icfg.u_bin_cal_apb}} -comment {da_ana_cal_clk not used in the bg cal}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_bg_cal_ctrl_apb_icfg -tag OTP_UC_INST -argument {{da_ana_cal_trigger} {cdnsdru_bin_cal_apb_v0} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_bg_cal_ctrl_apb_icfg.u_bin_cal_apb}} -comment {da_ana_cal_trigger not used in the bg cal}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_pu_icfg -tag OTP_UC_INST -argument {{da_ana_cal_clk} {cdnsdru_bin_cal_apb_v0} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_pu_icfg.u_tx_rescal_ctrl_pu}} -comment {da_ana_cal_clk not used in the tx cal}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_func -tag OTP_UC_INST -argument {{cmnda_rescal_clk_tx_useg} {tx_rescal_ctrl_pu_icfg} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_pu_icfg}} -comment {cmnda_rescal_clk_tx_useg not used}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_pu_icfg -tag OTP_UC_INST -argument {{cal_code_fcn[6]} {cdnsdru_bin_cal_apb_v0} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_pu_icfg.u_tx_rescal_ctrl_pu}} -comment {cal_code_fcn[6] not used}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_pd_icfg -tag OTP_UC_INST -argument {{da_ana_cal_clk} {cdnsdru_bin_cal_apb_v0} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_pd_icfg.u_tx_rescal_ctrl_pd}} -comment {da_ana_cal_clk not used in the tx cal}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_ibiascal_icfg -tag OTP_UC_INST -argument {{da_ana_cal_clk} {cdnsdru_bin_cal_apb_v0} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_ibiascal_icfg.u_bin_cal_apb}} -comment {da_ana_cal_clk not used in the ibis cal}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_rx_rescal_ctrl_icfg -tag OTP_UC_INST -argument {{da_ana_cal_clk} {cdnsdru_bin_cal_apb_v0} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_rx_rescal_ctrl_icfg.u_rx_res_cal_ctrl}} -comment {da_ana_cal_clk not used in the rx res cal}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_fdiag_ovrd -tag OTP_UC_INST  -comment {some apb output not used}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_func -tag OTP_UC_INST -comment {some apb output not used}

#check_superlint -waiver -add  -module * -tag CAS_NO_CNST -argument {{cdb_pread_sel_*}} -comment {case condition use variable}

#check_superlint -waiver -add -module cmn_fdiag_ovrd_cdb_regs -tag CAS_NO_CNST -argument {{cdb_pread_sel_*}} -comment {case condition use variable}

#check_superlint -waiver -add -module cmn_pdiag_ring_pll_cdb_regs -tag CAS_NO_CNST -argument {{cdb_pread_sel_*}} -comment {case condition use variable }

###############################################################################
#warning waiver, input not used, preserve for future extension or optimization
###############################################################################
check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd -tag OTP_UC_INST -argument {{cmn_cdiag_psmclk_ctrl_reg[31:4]} {cmn_cdiag_ovrd_cdb_regs} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd.u_cmn_cdiag_ovrd_cdb_regs}} -comment {high width use for future}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd -tag OTP_UC_INST -argument {{cmn_cdiag_pwri_tmr_reg[7:3]} {cmn_cdiag_ovrd_cdb_regs} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd.u_cmn_cdiag_ovrd_cdb_regs}} -comment {high width use for future}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd -tag OTP_UC_INST -argument {{cmn_cdiag_pwri_tmr_reg[31:11]} {cmn_cdiag_ovrd_cdb_regs} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd.u_cmn_cdiag_ovrd_cdb_regs}} -comment {high width use for future}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd -tag OTP_UC_INST -argument {{cmn_cdiag_refclk_ctrl1_reg[31:1]} {cmn_cdiag_ovrd_cdb_regs} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd.u_cmn_cdiag_ovrd_cdb_regs}} -comment {high width use for future}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd -tag OTP_UC_INST -argument {{cmn_cdiag_sdosc_ctrl_reg[31:2]} {cmn_cdiag_ovrd_cdb_regs} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd.u_cmn_cdiag_ovrd_cdb_regs}} -comment {high width use for future}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl -tag OTP_UC_INST -argument {{cmn_cdiag_cdb_pwri_ovrd_reg} {cmn_cdiag_ovrd} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd}} -comment {high width use for future} 

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl -tag OTP_UC_INST -argument {{cmn_cdiag_diag_pwri_ovrd_reg[13:12]} {cmn_cdiag_ovrd} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd}} -comment {high width use for future}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl -tag OTP_UC_INST -argument {{cmn_cdiag_diag_pwri_ovrd_reg[10]} {cmn_cdiag_ovrd} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd}} -comment {high width use for future}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl -tag OTP_UC_INST -argument {{cmn_cdiag_diag_pwri_ovrd_reg[8]} {cmn_cdiag_ovrd} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd}} -comment {high width use for future}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd -tag OTP_UC_INST -argument {{cmn_cdiag_dcya_reg[31:8]} {cmn_cdiag_ovrd_cdb_regs} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd.u_cmn_cdiag_ovrd_cdb_regs}} -comment {high width use for future}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd -tag OTP_UC_INST -argument {{cmn_cdiag_cdb_pwri_ovrd_reg[13:12]} {cmn_cdiag_ovrd_cdb_regs} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd.u_cmn_cdiag_ovrd_cdb_regs}} -comment {high width use for future}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd -tag OTP_UC_INST -argument {{cmn_cdiag_cdb_pwri_ovrd_reg[10]} {cmn_cdiag_ovrd_cdb_regs} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd.u_cmn_cdiag_ovrd_cdb_regs}} -comment {high width use for future}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd -tag OTP_UC_INST -argument {{cmn_cdiag_cdb_pwri_ovrd_reg[8]} {cmn_cdiag_ovrd_cdb_regs} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd.u_cmn_cdiag_ovrd_cdb_regs}} -comment {high width use for future}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl -tag OTP_UC_INST -argument {{cmn_cya} {cmn_cdiag_ovrd} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl.u_cmn_cdiag_ovrd}} -comment {keep for future used}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn -tag OTP_UC_INST -argument {{cmn_cdiag_ccal_pwri_ovrd_reg[10]} {cmn_ctrl} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl}} -comment {keep for future used}

check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn -tag OTP_UC_INST -argument {{cmn_cdiag_ccal_pwri_ovrd_reg[13:12]} {cmn_ctrl} {u_mp_pma.u_pma_rev.u_cmn.u_cmn_ctrl}} -comment {keep for future used}


check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst -tag OTP_UC_INST  -comment {clk gating output not used wavier}

#waiver all dft warning
check_superlint -waiver -add -instance u_mp_pma.u_pma_rev.u_cmn -tag OTP_UC_INST  -comment {warning cdnsdru_scan_tp_obs_v1 output not use warning}


#waiver all cdb_pread_sel_* CAS_NO_CNST warning TODO
check_superlint -waiver -add -tag CAS_NO_CNST -comment {waiver all cdb_pread_sel_* CAS_NO_CNST issue}

#waiver all CND_IR_CCAS warning
check_superlint -waiver -add -tag CND_IR_CCAS -argument {{1'b1}} -comment {waiver all CND_IR_CCAS warning}

