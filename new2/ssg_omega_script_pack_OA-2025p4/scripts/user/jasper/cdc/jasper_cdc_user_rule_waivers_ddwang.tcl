
#check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
#                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_pll0_clk_prog0} \
#                                          -destination_clock_domain uc_clk \
#                                          -source_unit {u_mp_pcs_top_ln_0.mp_pcs_original.u_mp_tx_deemph.pipe_rate_d} \
#                                          -destination_unit {u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_cdb.u_cdb_local_bridge_tx.cdb_prdata\[5\:0\]}] \
#                                          -comment {???}
#
#check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
#                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_pll0_clk_prog0} \
#                                          -destination_clock_domain uc_clk \
#                                          -source_unit {u_mp_pcs_top_ln_0.mp_pcs_original.u_mp_tx_deemph.pipe_tx_deemph_d\[1\:0\]} \
#                                          -destination_unit {u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_cdb.u_cdb_local_bridge_tx.cdb_prdata\[5\:0\]}] \
#                                          -comment {???}
#
#check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
#                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_pll0_clk_prog0} \
#                                          -destination_clock_domain uc_clk \
#                                          -source_unit {u_mp_pcs_top_ln_0.mp_pcs_original.u_mp_tx_deemph.pma_tx_deemphasis_usb3_gen2} \
#                                          -destination_unit {u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_cdb.u_cdb_local_bridge_tx.cdb_prdata\[5\:0\]}] \
#                                          -comment {???}

# --- CDC_NO_SYNC --- #
# pma_cmn_refclk0_int -> cmnda_pll0_clk_prog0
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
                                          -source_unit {u_mp_pcs_top_ln_..mp_pcs_original.i_pwr_rate_ctrl.pipe_clk_div_override} \
                                          -destination_unit {u_mp_pcs_top_ln_..mp_pcs_original.i_cmn_if.pipe_smpl_pt}] \
                                          -comment {pipe_clk_div_override only toggles when dest clock is off}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
                                          -source_unit {u_mp_pcs_top_ln_..mp_pcs_original.i_pwr_rate_ctrl.pipe_clk_div_override} \
                                          -destination_unit {u_mp_pcs_top_ln_..mp_pcs_original.i_cmn_if.td_started}] \
                                          -comment {pipe_clk_div_override only toggles when dest clock is off}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
                                          -source_unit {u_mp_pcs_top_ln_..u_eq_wrap.int_pma_tx_localpresetindex\[3\:0\]} \
                                          -destination_unit {u_pcs_iso_ctrl_ln_..cdb_prdata\[27\:24\]}] \
                                          -comment {tx_localpresetindex has pipe_mb_tx_get_local_preset_coef_stb as qualifier}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
                                          -source_unit {u_mp_pcs_top_ln_..message_bus.u_cdnsdru_usb4_message_bus_pma_txrx_ctrl_v4.rx_mrgn_offset} \
                                          -destination_unit {u_pma_iso_ctrl_ln_..cdb_prdata\[14\:8\]}] \
                                          -comment {rx_mrgn_offset has rx_mrgn_req(synced) as qualifier}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
                                          -source_unit {u_mp_pcs_top_ln_..message_bus.u_cdnsdru_usb4_message_bus_pma_txrx_ctrl_v4.rx_mrgn_dir} \
                                          -destination_unit {u_pma_iso_ctrl_ln_..cdb_prdata\[5\:4\]}] \
                                          -comment {rx_mrgn_dir has rx_mrgn_req(synced) as qualifier}

# --- CDC_PR_FOUT --- #
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_FOUT \
                                          -source_unit {u_mp_pcs_top_ln_..mp_pcs_original.i_pwr_rate_ctrl.pipe_clk_div_override}] \
                                          -comment {pipe_clk_div_override will be stable before dest clock running, thus no issue.}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_FOUT \
                                          -source_unit {u_mp_pcs_top_ln_..mp_pcs_original.u_mp_tx_deemph.pipe_rate_d}] \
                                          -comment {There are no relative relationships between each re-sync'd signal.  Thus no hazard with multiple re-synchronizers.}                                          

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_FOUT \
                                          -source_unit {u_mp_pcs_top_ln_..mp_pcs_original.u_mp_tx_deemph.pipe_tx_deemph_d\[1\:0\]}] \
                                          -comment {There are no relative relationships between each re-sync'd signal.  Thus no hazard with multiple re-synchronizers.}                                          

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_FOUT \
                                          -source_unit {u_mp_pcs_top_ln_..mp_pcs_original.u_mp_tx_deemph.pma_tx_deemphasis_usb3_gen2}] \
                                          -comment {There are no relative relationships between each re-sync'd signal.  Thus no hazard with multiple re-synchronizers.}                                          

# en_ack is synced in top & origin & serdes pcs, but en_ack synced in top is used to generate en_ack_low, which has 1 more sync cell, so the delay is different.
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_FOUT \
                                          -source_unit {u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly..u_xcvr_clkrst.u_clk_gating_cell_xcvr_pll_clk_fullrt.genblk3.u_data_delay_en_ack.data_delay_flop\[1\]}] \
                                          -comment {There are no relative relationships between each re-sync'd signal.  Thus no hazard with multiple re-synchronizers.}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_FOUT \
                                          -source_unit {u_mp_pcs_top_ln_.\.mp_pcs_original\.i_pwr_rate_ctrl\.pma_xcvr_pll_clk_en}] \
                                          -comment {There are no relative relationships between each re-sync'd signal.  Thus no hazard with multiple re-synchronizers.}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_FOUT \
                                          -source_unit {u_mp_pcs_top_ln_.\.mp_pcs_serdes\.i_pwr_rate_ctrl\.pma_xcvr_pll_clk_en}] \
                                          -comment {There are no relative relationships between each re-sync'd signal.  Thus no hazard with multiple re-synchronizers.}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_FOUT \
                                          -source_unit {u_mp_pcs_top_ln_.\.u_eq_wrap\.pma_rx_eqeval}] \
                                          -comment {There are no relative relationships between each re-sync'd signal.  Thus no hazard with multiple re-synchronizers.}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_FOUT \
                                          -source_unit {u_mp_pcs_top_ln_.\.u_eq_wrap\.pma_rx_invalidrequest}] \
                                          -comment {There are no relative relationships between each re-sync'd signal.  Thus no hazard with multiple re-synchronizers.}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_FOUT \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_tx_rescal_ctrl_pd_icfg\.u_tx_rescal_ctrl_pd\.u_bin_cal\.cal_code_hold}] \
                                          -comment {The destination unit is muti bit sync cell}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_FOUT \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_tx_rescal_ctrl_pu_icfg\.u_tx_rescal_ctrl_pu\.u_bin_cal\.cal_code_hold}] \
                                          -comment {The destination unit is muti bit sync cell}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_FOUT \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_pwr_isl_ctrl_sm_icfg_ccal\.u_cdnsdru_pwr_isl_ctrl_sm_v3\.pwr_isl_ctrl_current_state\[8\]}] \
                                          -comment {The destination unit is muti bit sync cell}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_FOUT \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_drv_ctrl\.u_tx_coef_calc\.u_tx_coef_calc_cdb_regs\.tx_txcc_mgn_mult_000_reg\[7\:0\]}] \
                                          -comment {The destination unit is muti bit sync cell}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_FOUT \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_drv_ctrl\.u_tx_coef_calc\.u_tx_coef_calc_cdb_regs\.tx_txcc_p10emph_coef_mult_reg\[7\:0\]}] \
                                          -comment {The destination unit is muti bit sync cell}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_FOUT \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_drv_ctrl\.u_tx_coef_calc\.u_tx_coef_calc_cdb_regs\.tx_txcc_p1emph_coef_mult_reg\[7\:0\]}] \
                                          -comment {The destination unit is muti bit sync cell}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_FOUT \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.\.u_rx_ctrl\.u_rx_equalizer_engine\.u_ree_pcieg3_tx_eq_ctrl_sm\.u_ree_pcieg3_ctrl_sm_v2\.pcie_ree_current_state\[0\]}] \
                                          -comment {There are no relative relationships between each re-sync'd signal.  Thus no hazard with multiple re-synchronizers.}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_FOUT \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.\.u_rx_ctrl\.u_rx_sig_detect_filt_apb_icfg\.u_rx_sig_detect_filt_low_apb\.u_rx_sig_detect_filt_low_v2\.st_filt_current_state\[0\]}] \
                                          -comment {There are no relative relationships between each re-sync'd signal.  Thus no hazard with multiple re-synchronizers.}





# --- RST_RS_FSAR (register is stuck by reset) --- #
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_FSAR \
                                          -destination_unit {u_mp_pcs_top_ln_..mp_pcs_original.i_mp_rx_elec_idle.l1_x_exit_dly_cnt}] \
                                          -comment {PCIe is not used, so the l1_x_exit_reset_n is tied low}                                          

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_FSAR \
                                          -destination_unit {u_mp_pcs_top_ln_..mp_pcs_original.i_mp_rx_elec_idle.l1_x_exit_dly_load}] \
                                          -comment {PCIe is not used, so the l1_x_exit_reset_n is tied low} 

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_FSAR \
                                          -destination_unit {u_mp_pcs_top_ln_..mp_pcs_original.i_mp_rx_elec_idle.l1_x_exit_gate}] \
                                          -comment {PCIe is not used, so the l1_x_exit_reset_n is tied low}  

# --- RST_RS_RIDP (reset used as data) --- #
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_phy_clkrst\.u_phy_pcs_pipe4_clk_reset_n\.reset_sync_flop\[1\]\-u_mp_pcs_top_ln_.\.mp_pcs_serdes\.i_pwr_rate_ctrl\.i_phy_data_sync_pma_xcvr_pll_clk_en_ack_low\.data_sync_flop}] \
                       -comment {the pipe4_clk_reset_n is indeed use as data but no function issue.}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_phy_clkrst\.u_pcs_pipe7_clk_reset_n_ln_.\.reset_sync_flop\[1\]\-u_mp_pcs_top_ln_.\.mp_pcs_serdes\.i_pwr_rate_ctrl\.i_phy_data_sync_pma_xcvr_pll_clk_en_ack_low\.data_sync_flop}] \
                       -comment {the pipe7_clk_reset_n is indeed use as data but no function issue}                                          

# reset is connected to register for debug
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_reset_sync_cdb_isl_ctrl_sm_reset_n\.genblk1\.reset_sync_flop\[5\]\-u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_reset_sync_cmn_ccal_power_reset_n\.genblk1\.reset_sync_flop\[1\]\-u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}                       

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_reset_sync_cmn_sd_clk_cal_fb_clk_reset_n\.genblk1\.reset_sync_flop\[1\]\-u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}                       

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_reset_sync_cmn_reset_sync\.genblk1\.reset_sync_flop\[5\]\-u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_reset_sync_cmn_tmpsns_filt_reset_n\.genblk1\.reset_sync_flop\[1\]\-u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly..u_xcvr_clkrst.u_reset_sync_rx_sd_cal_reset_n.genblk1.reset_sync_flop\[1\]\-u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly..u_xcvr_cdb.u_cdb_local_bridge_tx.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly..u_xcvr_clkrst.u_reset_sync_tx_coef_calc_reset.genblk1.reset_sync_flop\[1\]\-u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly..u_xcvr_cdb.u_cdb_local_bridge_tx.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly..u_xcvr_clkrst.u_reset_sync_xcvr_psm_reset_n.genblk1.reset_sync_flop\[1\]\-u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly..u_xcvr_cdb.u_cdb_local_bridge_tx.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly..u_xcvr_clkrst.u_reset_sync_xcvr_ref_clk_reset_n.genblk1.reset_sync_flop\[1\]\-u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly..u_xcvr_cdb.u_cdb_local_bridge_tx.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev\.u_xcvr_txm.u_xcvr_txonly..u_xcvr_ctrl.u_xcvr_hsrrsm_tx.da_clk_reset_n\-u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly..u_xcvr_cdb.u_cdb_local_bridge_tx.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_pll._dsm_reset_n.genblk1.reset_sync_flop\[1\]\-u_mp_pma.u_pma_rev.u_cmn.u_cmn_cdb.u_cdb_local_bridge.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_pll._lock_det_fbdiv_clk_reset_n.genblk1.reset_sync_flop\[1\]\-u_mp_pma.u_pma_rev.u_cmn.u_cmn_cdb.u_cdb_local_bridge.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}                 

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_pll._lock_det_ref_clk_reset_n.genblk1.reset_sync_flop\[1\]\-u_mp_pma.u_pma_rev.u_cmn.u_cmn_cdb.u_cdb_local_bridge.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}                  

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_pll._vcocal_fbdiv_clk_reset_n.genblk1.reset_sync_flop\[1\]\-u_mp_pma.u_pma_rev.u_cmn.u_cmn_cdb.u_cdb_local_bridge.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_pll._vcocal_ref_clk_reset_n.genblk1.reset_sync_flop\[1\]\-u_mp_pma.u_pma_rev.u_cmn.u_cmn_cdb.u_cdb_local_bridge.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_clkrst.u_reset_sync_rx_dig_reset_scanned_n.genblk1.reset_sync_flop\[3\]\-u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_cdb.u_cdb_local_bridge_rx.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_clkrst.u_reset_sync_rx_ree_fcn_reset.genblk1.reset_sync_flop\[1\]\-u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_cdb.u_cdb_local_bridge_rx.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_clkrst.u_reset_sync_rx_sd_cal_reset_n.genblk1.reset_sync_flop\[1\]\-u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_cdb.u_cdb_local_bridge_tx.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_clkrst.u_reset_sync_xcvr_psm_reset_n.genblk1.reset_sync_flop\[1\]\-u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_cdb.u_cdb_local_bridge_tx.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_clkrst.u_reset_sync_xcvr_ref_clk_reset_n.genblk1.reset_sync_flop\[1\]\-u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_cdb.u_cdb_local_bridge_tx.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_ctrl.u_xcvr_hsrrsm_tx.da_clk_reset_n-u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_cdb.u_cdb_local_bridge_tx.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_pma_iso_ctrl_ln_..phy_pma_xcvr_ctrl_reg\[31\]\-u_pma_iso_ctrl_ln_..cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_pma_iso_ctrl_ln_..phy_pma_xcvr_ctrl_reg\[30\]\-u_pma_iso_ctrl_ln_..cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_clkrst.u_reset_sync_cmn_reset_int_synced_sd_clk.genblk1.reset_sync_flop\[3\]\-u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_cdb.u_cdb_local_bridge_.x.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_clkrst.u_reset_sync_rx_ree_ctrl_reset.genblk1.reset_sync_flop\[3\]\-u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_cdb.u_cdb_local_bridge_.x.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_clkrst.u_scan_mux_tx_sync_fifo_enq_rst_n.fcn_signal_out-u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_cdb.u_cdb_local_bridge_.x.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_ctrl.u_xcvr_hsrrsm_rx.hsrrsm_current_state\[2\]\-u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_cdb.u_cdb_local_bridge_rx.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly..u_xcvr_clkrst.u_scan_mux_tx_sync_fifo_enq_rst_n.fcn_signal_out-u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly..u_xcvr_cdb.u_cdb_local_bridge_tx.cdb_prdata}] \
                       -comment {connect reset to CDB register for debug}                       

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {dp_reset_n\-u_pcs_iso_ctrl_cmn.u_phy_data_sync_sts_regs\[0\].data_sync_flop}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {phy_reset_n\-u_pcs_iso_ctrl_cmn.u_phy_data_sync_sts_regs\[7\].data_sync_flop}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {pipe4_reset_n\-u_pcs_iso_ctrl_cmn.u_phy_data_sync_sts_regs\[2\].data_sync_flop}] \
                       -comment {connect reset to CDB register for debug}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {pipe7_reset_n\-u_pcs_iso_ctrl_cmn.u_phy_data_sync_sts_regs\[1\].data_sync_flop}] \
                       -comment {connect reset to CDB register for debug}

## below 4 paths are specific usage in phy_lane_reset_sequencer
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_phy_clkrst.u_dp_link_reset_sequencer.state\-u_phy_clkrst.u_dp_link_reset_sequencer.count}] \
                       -comment {specific usage in phy_lane_reset_sequencer}                       

# usb3 & usb4
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_phy_clkrst.u_usb._link_reset_sequencer.state\-u_phy_clkrst.u_usb._link_reset_sequencer.count}] \
                       -comment {specific usage in phy_lane_reset_sequencer}                       

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_phy_clkrst.u_usb_link_reset_sequencer.state\-u_phy_clkrst.u_usb_link_reset_sequencer.count}] \
                       -comment {specific usage in phy_lane_reset_sequencer}

# below paths are legacy usage.
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly..u_xcvr_clkrst.u_scan_mux_tx_sync_fifo_enq_rst_n.fcn_signal_out\-u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly..u_xcvr_ctrl.u_xcvr_hsrrsm_tx.u_data_sync_dig_reset_release_ack.genblk1.data_sync_flop}] \
                       -comment {specific usage}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_clkrst.u_scan_mux_tx_sync_fifo_enq_rst_n.fcn_signal_out\-u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_ctrl.u_xcvr_hsrrsm_tx.u_data_sync_dig_reset_release_ack.genblk1.data_sync_flop}] \
                       -comment {specific usage}                       

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_ctrl.u_xcvr_hsrrsm_rx.hsrrsm_current_state\[2\]\-u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_ctrl.u_xcvr_hsrrsm_rx.hsrrsm_current_state\[1\:0\] u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_ctrl.u_xcvr_hsrrsm_rx.hsrrsm_current_state\[4\:3\]}] \
                       -comment {specific usage}                       

# below paths are legacy usage.
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_phy_clkrst.u_pcs_pipe7_clk_reset_n_ln_..reset_sync_flop\[1\]\-u_phy_pwrst_aggr_ln_..u_sync_pipe_ln_reset_n\[14\].data_sync_flop}] \
                       -comment {specific usage}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_phy_clkrst.u_pcs_pipe7_clk_reset_n_ln_..reset_sync_flop\[1\]\-u_phy_pwrst_aggr_ln_..u_sync_pipe_ln_reset_n\[15\].data_sync_flop}] \
                       -comment {specific usage}                       

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_phy_clkrst.u_phy_pcs_pipe4_clk_reset_n.reset_sync_flop\[1\]\-u_phy_pwrst_aggr_ln_..u_sync_pipe_ln_reset_n\[14\].data_sync_flop}] \
                       -comment {specific usage}                       

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_phy_clkrst.u_phy_pcs_pipe4_clk_reset_n.reset_sync_flop\[1\]\-u_phy_pwrst_aggr_ln_..u_sync_pipe_ln_reset_n\[15\].data_sync_flop}] \
                       -comment {specific usage}                       

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_phy_clkrst.u_pcs_pipe7_clk_reset_n_ln_..reset_sync_flop\[1\]\-u_phy_port_master_lane_sel.u_phy_data_sync_pipe_l0._reset_n.data_sync_flop}] \
                       -comment {specific usage}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                       -occurrence {u_phy_clkrst.u_phy_pcs_pipe4_clk_reset_n.reset_sync_flop\[1\]\-u_phy_port_master_lane_sel.u_phy_data_sync_pipe_l0._reset_n.data_sync_flop}] \
                       -comment {specific usage}



#---------- RDC ---------#
#--- RDC_RS_DFRS ---#
# if there is sync cell in data path, use "source_unit" and "destination_unit"
# otherwise, use "source_reset" and "destination_reset" if possible
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
          -source_unit {u_mp_pcs_top_ln_.\.u_eq_wrap\.pma_tx_getlocalpresetcoeff} \
          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_xcvr_clkrst\.u_clk_gating_cell_tx_coef_calc_clk\.genblk1\.u_data_sync_en_sync\.genblk1\.data_sync_flop\[0\]}] \
          -comment {reset is different, but already has sync cell in data path}                                          


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
          -source_unit {u_mp_pcs_top_ln_.\.message_bus\.u_cdnsdru_usb4_message_bus_gen_reg_ctrl_v4\.phy_reg408\[3\]} \
          -destination_unit {u_mp_pcs_top_ln_.\.mp_pcs_serdes\.i_mb_data_sync_pipe_local_fs\.data_sync_inst\[.\]\.i_phy_data_sync_dest_dat\.data_sync_flop\[0\]}] \
          -comment {already has sync cell in data path}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
          -source_unit {u_mp_pcs_top_ln_.\.message_bus\.u_cdnsdru_usb4_message_bus_gen_reg_ctrl_v4\.phy_reg408\[3\]} \
          -destination_unit {u_mp_pcs_top_ln_.\.mp_pcs_serdes\.i_mb_data_sync_pipe_local_lf\.data_sync_inst\[.\]\.i_phy_data_sync_dest_dat\.data_sync_flop\[0\]}] \
          -comment {already has sync cell in data path}


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_pwr_isl_ctrl_sm_icfg_xcvrc\.u_cdnsdru_pwr_isl_ctrl_sm_v3\.pwr_isl_ctrl_current_state\[8\]} \
          -destination_unit {u_mp_pcs_top_ln_.\.mp_pcs_original\.i_pwr_rate_ctrl\.i_phy_data_sync_pma_req_ref_psm\[3\]\.data_sync_flop\[0\]}] \
          -comment {already has sync cell in data path}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_pwr_isl_ctrl_sm_icfg_xcvrc\.u_cdnsdru_pwr_isl_ctrl_sm_v3\.pwr_isl_ctrl_current_state\[8\]} \
          -destination_unit {u_mp_pcs_top_ln_.\.mp_pcs_original\.i_pwr_rate_ctrl\.i_phy_data_sync_pma_req_ref_psm\[4\]\.data_sync_flop\[0\]}] \
          -comment {already has sync cell in data path}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
          -source_unit {u_mp_pcs_top_ln_.\.mp_pcs_original\.i_pwr_rate_ctrl\.pma_pwr_state_req\[0\]} \
          -destination_unit {u_phy_port_master_lane_sel\.u_phy_data_sync_pma_xcvr_power_state_req_a0_ln_.\.data_sync_flop\[0\]}] \
          -comment {already has sync cell in data path}          

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
          -source_unit {u_mp_pcs_top_ln_.\.mp_pcs_serdes\.i_pwr_rate_ctrl\.pma_pwr_state_req\[0\]} \
          -destination_unit {u_phy_port_master_lane_sel\.u_phy_data_sync_pma_xcvr_power_state_req_a0_ln_.\.data_sync_flop\[0\]}] \
          -comment {already has sync cell in data path}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_drv_ctrl\.u_tx_rcv_detect_v2_apb\.u_tx_rcv_detect_v2\.rcv_det_current_state\[3\]} \
          -destination_unit {u_mp_pcs_top_ln_.\.mp_pcs_original\.i_rcv_det\.i_phy_data_sync_ref_rcv_detect_done\.data_sync_flop\[0\]}] \
          -comment {already has sync cell in data path}

# TODO: below 3 items need double confirm.
# src & dst reset is same but treat as different since static reset mux
# phy_reset_n & {pipe4_reset_n, pipe7_reset_n}(muxed from pipe7 or pipe4) -> phy_reset_n & pipe4_reset_n
# since phy mode is static, tool treats the resets as different.
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
           -local_source_reset {u_phy_clkrst\.u_mux_pipe_reset_n_sel\.clk_out} \
           -local_destination_reset {u_phy_clkrst\.u_phy_pcs_pipe4_clk_reset_n\.reset_sync_flop\[1\]}] \
           -comment {the reset is actually the same}

# phy_reset_n & {pipe4_reset_n, pipe7_reset_n}(muxed from pipe7 or pipe4) -> phy_reset_n & pipe4_reset_n
# since phy mode is static, tool treats the resets as different.
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
          -local_source_reset {u_phy_clkrst\.u_pma_tx_td_clk_reset_mux_ln_.\.clk_out} \
          -local_destination_reset {u_phy_clkrst\.u_phy_pcs_pipe4_clk_reset_n\.reset_sync_flop\[1\]}] \
          -comment {the reset is actually the same.}

# phy_reset_n & {pipe4_reset_n, pipe7_reset_n} -> phy_reset_n & {pipe4_reset_n, pipe7_reset_n}
# since phy mode is static, tool treats the resets as different.
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
          -local_source_reset {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_xcvr_clkrst\.u_reset_sync_cmn_reset_int_synced_ref_clk\.genblk1\.reset_sync_flop\[1\]} \
          -local_destination_reset {u_phy_clkrst\.u_phy_reset_sync_usb_pcs_refclk_reset_n\.reset_sync_flop\[1\]}] \
          -comment {the reset is actually the same.}


# below 7 items: tools treat stopat reset as different, stopat introdeced because there are register's Q used as reset --- this register is driven by clock.
# uc_reset_n -> uc_reset_n 
# TODO: need confirm
#check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
#          -source_reset_domain {u_pcs_iso_ctrl_cmn\.uc_soft_reset_n} \
#          -destination_reset_domain {u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[2\]}] \
#          -comment {the reset is actually the same.}
#
#check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
#          -source_reset_domain {u_pcs_iso_ctrl_cmn\.uc_soft_reset_n} \
#          -destination_reset_domain {u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[0\]}] \
#          -comment {the reset is actually the same.}
#
#check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
#          -source_reset_domain {u_pcs_iso_ctrl_ln_.\.uc_soft_reset_n} \
#          -destination_reset_domain {u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[2\]}] \
#          -comment {the reset is actually the same.}
#
#check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
#          -source_reset_domain {u_pcs_iso_ctrl_ln_.\.uc_soft_reset_n} \
#          -destination_reset_domain {u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[0\]}] \
#          -comment {the reset is actually the same.}
#
#check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
#          -local_source_reset {u_uc_top\.u_breset_sync_clk\.reset_sync_flop\[1\]} \
#          -local_destination_reset {u_apb_top_wrapper\.u_async_apb_if_slv\.u_phy_reset_sync_apb_preset\.reset_sync_flop\[1\]}] \
#          -comment {the reset is actually the same.}
#
#check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
#          -local_source_reset {u_uc_top\.u_breset_sync_clk\.reset_sync_flop\[1\]} \
#          -local_destination_reset {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_reset_sync_cdb_preset_synced_cdbclk\.genblk1\.reset_sync_flop\[1\]}] \
#          -comment {the reset is actually the same.}
#
#check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
#          -local_source_reset {u_uc_ln_..\.u_breset_sync_clk\.reset_sync_flop\[1\]} \
#          -local_destination_reset {u_apb_top_wrapper\.u_async_apb_if_slv\.u_phy_reset_sync_apb_preset\.reset_sync_flop\[1\]}] \
#          -comment {the reset is actually the same.}        



# {pipe4_rst, pipe7_rst} -> {pipe4_rst, pipe7_rst} & phy_reset
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_phy_clkrst\.u_usb3_link_reset_sequencer\.state u_phy_clkrst\.u_usb4_link_reset_sequencer\.state} \
                       -destination_reset_domain {u_mp_pcs_top_ln_.\.message_bus\.u_phy_reset_sync_phy_reset_n\.reset_in_n}] \
                       -comment {dst reset already contains src reset}                       

# {pipe4_rst, pipe7_rst} & phy_reset -> {pipe4_rst, pipe7_rst}
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_mp_pcs_top_ln_.\.message_bus\.u_phy_reset_sync_phy_reset_n\.reset_in_n} \
                       -destination_reset_domain {u_phy_clkrst\.u_usb3_link_reset_sequencer\.state u_phy_clkrst\.u_usb4_link_reset_sequencer\.state}] \
                       -comment {src reset has 1 more signal, but when phy reset asserted, pipe reset should also asserted.}                       

# resetA -> resetA & resetB
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out} \
                       -destination_reset_domain {u_phy_clkrst\.u_usb_link_reset_sequencer\.state}] \
                       -comment {dst reset contains src reset}

# resetA -> resetA & resetB
# src reset is phy_reset_n; dst reset is phy_reset_n & pipex_reset_n & power_isl_reset_n
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out} \
                       -destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_xcvr_clkrst\.reset_tx_dig_reset_scanned_n}] \
                       -comment {dst reset contains src reset}


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out} \
                       -destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.\.u_xcvr_clkrst\.reset_tx_dig_reset_scanned_n}] \
                       -comment {dst reset contains src reset}


# {pipe4_rst, pipe7_rst} -> {pipe4_rst, pipe7_rst} & phy_reset & power_isl_reset_n
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_phy_clkrst\.u_usb3_link_reset_sequencer\.state u_phy_clkrst\.u_usb4_link_reset_sequencer\.state} \
                       -destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_xcvr_clkrst\.reset_tx_coef_calc_reset_n}] \
                       -comment {dst reset contains src reset}

                       
# {pipe4_rst, pipe7_rst} & phy_reset & power_isl_reset_n -> {pipe4_rst, pipe7_rst}
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_xcvr_clkrst\.reset_tx_coef_calc_reset_n} \
                       -destination_reset_domain {u_phy_clkrst\.u_usb3_link_reset_sequencer\.state u_phy_clkrst\.u_usb4_link_reset_sequencer\.state}] \
                       -comment {when phy_reset asserted, pipe reset should also be asserted; when power_isl_reset_n asserted, src unit value was stable}


# src rst: xcvr_isl_power_reset_wsr_n & phy_rst & {pipe4_rst, pipe7_rst}
# dst rst: phy_rst & {pipe4_rst, pipe7_rst}
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_xcvr_clkrst\.reset_xcvr_psm_reset_n} \
                       -destination_reset_domain {u_phy_clkrst\.u_usb_link_reset_sequencer\.state}] \
                       -comment {src reset has 1 more reset from power island control fsm, when it asserted, signal is fixed to desired value}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.\.u_xcvr_clkrst\.reset_xcvr_psm_reset_n} \
                       -destination_reset_domain {u_phy_clkrst\.u_usb_link_reset_sequencer\.state}] \
                       -comment {src reset has 1 more reset from power island control fsm, when it asserted, signal is fixed to desired value}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.\.u_xcvr_ctrl\.u_xcvr_hsrrsm_rx\.hsrrsm_current_state\[2\]} \
                       -destination_reset_domain {u_phy_clkrst\.u_usb_link_reset_sequencer\.state}] \
                       -comment {src reset has 1 more reset from power island control fsm, when it asserted, signal is fixed to desired value}


# {pipe4 reset, pipe7 reset} -> {pipe4 reset, pipe7 reset} & phy_reset_n & xcvr_isl_power_reset_wsr_n 
# TODO: need jinran to confirm reset of u_sa_sync_fifo_v1
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_phy_clkrst\.u_usb3_link_reset_sequencer\.state u_phy_clkrst\.u_usb4_link_reset_sequencer\.state} \
                       -destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_xcvr_clkrst\.u_scan_mux_tx_sync_fifo_enq_rst_n\.fcn_signal_out}] \
                       -comment {dst reset contains src reset}

# phy reset -> {pipe4 reset, pipe7 reset} & phy_reset_n & xcvr_isl_power_reset_wsr_n
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out} \
                       -destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_xcvr_clkrst\.u_scan_mux_tx_sync_fifo_enq_rst_n\.fcn_signal_out}] \
                       -comment {dst reset contains src reset}

# phy reset -> phy_reset_n & power_isl_reset_n & ...
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out} \
                       -destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_xcvr_clkrst\.reset_xcvr_psm_reset_n}] \
                       -comment {dst reset contains src reset}

# phy reset -> phy_reset_n & power_isl_reset_n & ...
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out} \
                       -destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.\.u_xcvr_clkrst\.u_scan_mux_tx_sync_fifo_enq_rst_n\.fcn_signal_out}] \
                       -comment {dst reset contains src reset}

# phy reset -> phy_reset_n & power_isl_reset_n & ...
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out} \
                       -destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.\.u_xcvr_clkrst\.reset_xcvr_psm_reset_n}] \
                       -comment {dst reset contains src reset}

# phy_reset_n & {pipe4_reset_n, pipe7_reset_n} -> phy_reset_n & {pipe4_reset_n, pipe7_reset_n} & power_reset_wsr_n
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_phy_clkrst\.u_usb_link_reset_sequencer\.state} \
                       -destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_xcvr_clkrst\.reset_xcvr_psm_reset_n}] \
                       -comment {dst reset contains src reset}

# phy_reset_n & {pipe4_reset_n, pipe7_reset_n} -> phy_reset_n & {pipe4_reset_n, pipe7_reset_n} & power_reset_wsr_n
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_phy_clkrst\.u_usb_link_reset_sequencer\.state} \
                       -destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.\.u_xcvr_clkrst\.reset_xcvr_psm_reset_n}] \
                       -comment {dst reset contains src reset}


# uc_reset_n -> apb_preset_n. 
# in module phy_apb_slv_async_if, there is a sync cell after the destination unit
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS -instance u_phy_apb_slv_async_if \
                       -source_reset_domain uc_reset_n \
                       -destination_reset_domain apb_preset_n] \
                       -comment {the resets are indeed different, but there is sync cell after destination unit}                       

# in module phy_apb_mstr_async_if, there is a sync cell after the destination unit
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS -instance u_phy_apb_mstr_async_if \
                       -source_reset_domain apb_preset_n \
                       -destination_reset_domain uc_reset_n] \
                       -comment {the resets are indeed different, but there is sync cell after destination unit}                       


# uc_reset_n -> phy_reset_n: if uc_reset_n goes low, phy_reset_n should goes low too, otherwise, phy can not work properly.
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain uc_reset_n \
                       -destination_reset_domain {u_phy_clkrst\.u_phy_reset_sequencer\.st_current_state\[0\]}] \
                       -comment {dst reset and src reset should asserted together.}

# phy_reset_n -> uc_reset_n: if phy_reset_n goes low, uc_reset_n should goes low too, otherwise, phy can not work properly.            
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_phy_clkrst\.u_phy_reset_sequencer\.st_current_state\[0\]} \
                       -destination_reset_domain uc_reset_n] \
                       -comment {dst reset and src reset should asserted together.}

# phy_reset_n -> phy_ln_soft_cdb_reset_n[0](reset by uc_reset_n)
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_phy_clkrst\.u_phy_reset_sequencer\.st_current_state\[0\]} \
                       -destination_reset_domain {uc_reset_n u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[0\]}] \
                       -comment {dst reset and src reset should asserted together.}

# phy_reset_n -> phy_ln_soft_cdb_reset_n[2](reset by uc_reset_n)
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_phy_clkrst\.u_phy_reset_sequencer\.st_current_state\[0\]} \
                       -destination_reset_domain {uc_reset_n u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[2\]}] \
                       -comment {dst reset and src reset should asserted together.}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_phy_clkrst\.u_phy_reset_sequencer\.st_current_state\[0\]} \
                       -destination_reset_domain {u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[2\] uc_reset_n}] \
                       -comment {dst reset and src reset should asserted together.}

# uc_reset_n -> reset_xcvr_psm_reset_n(reset by phy_reset_n)
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain uc_reset_n \
                       -destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_xcvr_clkrst\.reset_xcvr_psm_reset_n}] \
                       -comment {dst reset and src reset should asserted together.}                     

# uc_reset_n -> reset_xcvr_psm_reset_n(reset by phy_reset_n)
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain uc_reset_n \
                       -destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.\.u_xcvr_clkrst\.reset_xcvr_psm_reset_n}] \
                       -comment {dst reset and src reset should asserted together.}                       


# below path belong to Jinran 
# xcvr_isl_power_reset_nsr_n & phy_reset_n & {pipe7_reset_n pipe4_reset_n} -> phy_reset_n & {pipe7_reset_n pipe4_reset_n}
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_xcvr_clkrst\.reset_tx_coef_calc_reset_n} \
                       -destination_reset_domain {u_phy_clkrst\.u_usb_link_reset_sequencer\.state u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out}] \
                       -comment {src reset has 1 more reset from power island control fsm, when it asserted, signal is fixed to desired value} 

# xcal_isl_power_reset_nsr_n & phy_reset_n & {pipe7_reset_n pipe4_reset_n} -> phy_reset_n & {pipe7_reset_n pipe4_reset_n}
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_xcvr_clkrst\.reset_bin_cal_reset_n} \
                       -destination_reset_domain {u_phy_clkrst\.u_usb_link_reset_sequencer\.state u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out}] \
                       -comment {src reset has 1 more reset from power island control fsm, when it asserted, signal is fixed to desired value}

## {pipe4 reset, pipe7 reset} & phy_reset_n & xcvr_isl_power_reset_wsr_n -> {pipe4 reset, pipe7 reset} & phy_reset_n & xcvr_isl_power_reset_wsr_n 
## need double check
#check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
#                       -source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_tx_dsync\.u_sa_sync_fifo_v1\.u_sa_sync_fifo_v1_ptr_algn_det\.ptr_align_det_reset_n} \
#                       -destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_xcvr_clkrst\.u_scan_mux_tx_sync_fifo_enq_rst_n\.fcn_signal_out}] \
#                       -comment {reset is same but treat as different because of stopat}
#
## {pipe4 reset, pipe7 reset} & phy_reset_n & xcvr_isl_power_reset_wsr_n -> {pipe4 reset, pipe7 reset} & phy_reset_n & xcvr_isl_power_reset_wsr_n                      
#check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
#                       -source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_xcvr_ctrl\.u_xcvr_hsrrsm_tx\.da_clk_reset_n} \
#                       -destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_xcvr_clkrst\.u_scan_mux_tx_sync_fifo_enq_rst_n\.fcn_signal_out}] \
#                       -comment {reset is same but treat as different because of stopat}
#
## {pipe4 reset, pipe7 reset} & phy_reset_n & xcvr_isl_power_reset_wsr_n -> {pipe4 reset, pipe7 reset} & phy_reset_n & xcvr_isl_power_reset_wsr_n
#check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
#                       -source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.\.u_tx_dsync\.u_sa_sync_fifo_v1\.u_sa_sync_fifo_v1_ptr_algn_det\.ptr_align_det_reset_n} \
#                       -destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.\.u_xcvr_clkrst\.u_scan_mux_tx_sync_fifo_enq_rst_n\.fcn_signal_out}] \
#                       -comment {reset is same but treat as different because of stopat}
#
## {pipe4 reset, pipe7 reset} & phy_reset_n & xcvr_isl_power_reset_wsr_n -> {pipe4 reset, pipe7 reset} & phy_reset_n & xcvr_isl_power_reset_wsr_n
#check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
#                       -source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.\.u_xcvr_ctrl\.u_xcvr_hsrrsm_tx\.da_clk_reset_n} \
#                       -destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.\.u_xcvr_clkrst\.u_scan_mux_tx_sync_fifo_enq_rst_n\.fcn_signal_out}] \
#                       -comment {reset is same but treat as different because of stopat}

# phy_reset_n -> phy_reset_n & xcal_isl_power_reset_nsr_n & {pipe7_reset_n pipe4_reset_n}                       
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                       -source_reset_domain {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out} \
                       -destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.\.u_xcvr_clkrst\.reset_bin_cal_reset_n}] \
                       -comment {dst reset contains src reset}
