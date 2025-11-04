

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_clkrst\.reset_rx_ree_ctrl_reset_n} \
-destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_clkrst\.reset_rx_ree_fcn_reset_n}] \
-comment {ree fcn rst and ctrl rst from same source}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_clkrst\.reset_rx_ree_fcn_reset_n} \
-destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_clkrst\.reset_rx_ree_ctrl_reset_n} ]\
-comment {ree fcn rst and ctrl rst from same source}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_ctrl\.u_xcvr_hsrrsm_rx\.hsrrsm_current_state\[2\]} \
-destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_clkrst\.reset_rx_ree_ctrl_reset_n} ]\
-comment {ree fcn rst and ctrl rst from same source}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_ctrl\.u_xcvr_hsrrsm_rx\.hsrrsm_current_state\[2\]} \
-destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_clkrst\.reset_rx_ree_fcn_reset_n}]\
-comment {ree fcn rst and ctrl rst from same source}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_eq_mode_change_det.reset_eq_mode_change} \
-destination_reset_domain {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_rx_ree_ctrl_reset_n} ]\
-comment {eq mode change also work as a rst}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_eq_mode_change_det.reset_eq_mode_change} \
-destination_reset_domain {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_rx_ree_fcn_reset_n} ]\
-comment {eq mode change also work as a rst}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_ctrl\.u_xcvr_hsrrsm_rx\.hsrrsm_current_state\[2\]} \
-destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_clkrst\.reset_rx_diag_reset_n}] \
-comment {hrrsm[2] as psm rst will also reset reset_rx_diag_reset_n }

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_ctrl\.u_xcvr_hsrrsm_rx\.hsrrsm_current_state\[2\]} \
-destination_reset_domain {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_rx_sampler_latch_cal_reset_n}] \
-comment {hrrsm[2] as psm rst will also reset reset_rx_diag_reset_n }

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_rx_sampler_latch_cal_reset_n} \
-destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_ctrl\.u_xcvr_hsrrsm_rx\.hsrrsm_current_state\[2\]}] \
-comment {hrrsm[2] as psm rst will also reset reset_rx_diag_reset_n }

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_clkrst\.reset_rx_diag_reset_n} \
-destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_ctrl\.u_xcvr_hsrrsm_rx\.hsrrsm_current_state\[2\]}] \
-comment {hrrsm[2] as psm rst will also reset reset_rx_diag_reset_n }

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_ctrl\.u_xcvr_hsrrsm_rx\.hsrrsm_current_state\[2\]} \
-destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_clkrst\.reset_u_reset_sync_rx_false_eye_det_reset_n}] \
-comment {hrrsm[2] as psm rst will also reset reset_rx_diag_reset_n }

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_bin_cal_reset_n} \
-destination_reset_domain {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out}] \
-comment {xcvr_link_rst will also reset bin cali}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_bin_cal_reset_n} \
-destination_reset_domain {u_phy_clkrst\.u_usb_link_reset_sequencer\.state}] \
-comment {xcvr_link_rst will also reset bin cali}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_ctrl\.u_xcvr_hsrrsm_rx\.hsrrsm_current_state\[2\]} \
-destination_reset_domain {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out}] \
-comment {cmn_reset and xcvr_link_rst will also reset hrrsm[2] }

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_ctrl\.u_xcvr_hsrrsm_rx\.hsrrsm_current_state\[2\]} \
-destination_reset_domain {u_phy_clkrst\.u_usb_link_reset_sequencer\.state}] \
-comment {cmn_reset and xcvr_link_rst will also reset hrrsm[2] }


#has rst source from ana
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_rx_ctrl\.u_cdrlf_config\.u_cdrlf_config_cdb_regs\.cdr_2ol_max_det_reset_n} \
-destination_reset_domain {uc_reset_n u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[2\]}] \
-comment {cdrlf reg has another rst source of cdr_2ol_max_det_reset} 

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_rx_ctrl\.u_cdrlf_config\.u_cdrlf_config_cdb_regs\.cdr_2ol_max_det_reset_n} \
-destination_reset_domain {u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[2\] uc_reset_n}] \
-comment {cdrlf reg has another rst source of cdr_2ol_max_det_reset} 

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_rx_ctrl\.u_cdrlf_config\.u_cdrlf_config_cdb_regs\.cdr_2ol_max_det_reset_n} \
-destination_reset_domain {uc_reset_n u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[0\]}] \
-comment {cdrlf reg has another rst source of cdr_2ol_max_det_reset} 

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_rx_ctrl\.u_rx_diag_ovrd\.reset_lfps_det_low_test} \
-destination_reset_domain {uc_reset_n u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[2\]}] \
-comment {lfps reg has another rst source of lfps_det_low } 

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_rx_ctrl\.u_rx_diag_ovrd\.reset_lfps_det_low_test} \
-destination_reset_domain {uc_reset_n u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[0\]}] \
-comment {lfps reg has another rst source of lfps_det_low } 

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_rx_ctrl\.u_rx_diag_ovrd\.reset_lfps_det_high_test} \
-destination_reset_domain {uc_reset_n u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[0\]}] \
-comment {lfps reg has another rst source of lfps_det_high} 

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_rx_ctrl\.u_rx_diag_ovrd\.reset_lfps_det_high_test} \
-destination_reset_domain {uc_reset_n u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[2\]}] \
-comment {lfps reg has another rst source of lfps_det_high} 

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_rx_ctrl\.u_rx_diag_ovrd\.reset_lfps_det_high_test} \
-destination_reset_domain {u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[2\] uc_reset_n}] \
-comment {lfps reg has another rst source of lfps_det_high} 

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain uc_reset_n \
-destination_reset_domain {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.reset_lfps_det_low_test}] \
-comment {lfps reg has another rst source of lfps}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.reset_lfps_det_low_test} \
-destination_reset_domain {u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[2\] uc_reset_n}] \
-comment {lfps reg has another rst source of lfps}


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain uc_reset_n \
-destination_reset_domain {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.reset_lfps_det_high_test}] \
-comment {lfps reg has another rst source of lfps}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_rx_ctrl\.u_rx_sig_detect_filt_apb_icfg\.u_rx_sig_detect_filt_low_apb\.u_rx_sig_detect_filt_low_v2\.reset_rx_sig_det_filter_n} \
-destination_reset_domain {u_phy_clkrst\.u_usb_link_reset_sequencer\.state u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out}] \
-comment {signal detect reg has another rst source of signal detector}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain uc_reset_n \
-destination_reset_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_rx_ctrl\.u_rx_diag_ovrd\.reset_sig_det_high_test}] \
-comment {signal detect reg has another rst source of signal detector}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain uc_reset_n \
-destination_reset_domain {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.reset_sig_det_low_test} ] \
-comment {signal detect reg has another rst source of signal detector}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.reset_sig_det_high_test} \
-destination_reset_domain {uc_reset_n u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[0\]} ] \
-comment {signal detect reg has another rst source of signal detector}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.reset_sig_det_low_test} \
-destination_reset_domain  {uc_reset_n u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[2\]} ]\
-comment {signal detect reg has another rst source of signal detector}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.reset_sig_det_low_test} \
-destination_reset_domain  {u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[2\] uc_reset_n} ]\
-comment {signal detect reg has another rst source of signal detector}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.reset_sig_det_low_test} \
-destination_reset_domain  {uc_reset_n u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[0\]} ]\
-comment {signal detect reg has another rst source of signal detector}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.reset_sig_det_high_test} \
-destination_reset_domain  {uc_reset_n u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[2\]}]\
-comment {signal detect reg has another rst source of signal detector}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.reset_sig_det_high_test} \
-destination_reset_domain  {u_pcs_iso_ctrl_cmn\.phy_ln_soft_cdb_reset_n\[2\] uc_reset_n}]\
-comment {signal detect reg has another rst source of signal detector}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
-source_reset_domain {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_bin_cal_reset_n} \
-destination_reset_domain {u_phy_clkrst\.u_usb_link_reset_sequencer\.state u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out}] \
-comment {link rst will also rst bin cal}





