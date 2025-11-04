# "Resets 'u_phy_reconfig_ctlr.u_phy_scan_mux_cmn_reset_n_out.fcn_signal_out,u_pma_iso_ctrl_cmn.phy_pma_cmn_ctrl_reg[7]' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_pll0_reset_sync_n', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -severity Error \
                                          -instance {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst} \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.reset_pll0_reset_sync_n} \
                                          -reset_domain {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out u_pma_iso_ctrl_cmn\.phy_pma_cmn_ctrl_reg\[7\]}] \
                                          -comment {2 resets: pll0_reset_n and cmn_reset_n will not be asserted at the same time. When one reset is active, the other one must be stable.}

# "Asynchronous or Synchronized Reset signal 'u_pma_iso_ctrl_cmn.phy_pma_cmn_ctrl_reg[7]' is connected to the data pin of flop/latch 'u_pma_iso_ctrl_cmn.cdb_prdata' driven by clock/enable 'uc_clk'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                                          -destination_clock_domain uc_clk \
                                          -destination_unit {u_pma_iso_ctrl_cmn\.cdb_prdata} \
                                          -severity Error \
                                          -instance u_pma_iso_ctrl_cmn \
                                          -occurrence {u_pma_iso_ctrl_cmn\.phy_pma_cmn_ctrl_reg\[7\]\-u_pma_iso_ctrl_cmn\.cdb_prdata} \
                                          -reset_domain {u_pma_iso_ctrl_cmn\.phy_pma_cmn_ctrl_reg\[7\]}] \
                                          -comment {Design needed. UC need to know the current state of the pll0_reset_n.}

# "Asynchronous or Synchronized Reset signal 'u_pma_iso_ctrl_cmn.phy_pma_cmn_ctrl_reg[7]' is connected to the data pin of flop/latch 'u_pma_pll_ready_aggr.pma_pll_ready' driven by clock/enable 'uc_clk'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                                          -destination_clock_domain uc_clk \
                                          -destination_unit {u_pma_pll_ready_aggr\.pma_pll_ready} \
                                          -severity Error \
                                          -instance u_pma_pll_ready_aggr \
                                          -occurrence {u_pma_iso_ctrl_cmn\.phy_pma_cmn_ctrl_reg\[7\]\-u_pma_pll_ready_aggr\.pma_pll_ready} \
                                          -reset_domain {u_pma_iso_ctrl_cmn\.phy_pma_cmn_ctrl_reg\[7\]}] \
                                          -comment {When pll0 is asserted, this means that pll0 is ready. We need this reset signal to do some judgement.}

# "No synchronizer between source unit 'u_pcs_iso_ctrl_ln_1.iso_pipe_mb_tx_local_tx_preset_coef_reg' driven by clock 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0, pipe7_l00_clk' and destination unit 'u_pcs_iso_ctrl_ln_1.cdb_prdata' driven by clock 'uc_clk'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
                                          -source_unit {u_pcs_iso_ctrl_ln_1\.iso_pipe_mb_tx_local_tx_preset_coef_reg} \
                                          -destination_unit {u_pcs_iso_ctrl_ln_1\.cdb_prdata\[17\:0\]}] \
                                          -comment {No need to synchronize since only UC read this reg.}

# "No synchronizer between source unit 'u_pcs_iso_ctrl_ln_3.iso_pipe_mb_tx_local_tx_preset_coef_reg' driven by clock 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0, pipe7_l00_clk' and destination unit 'u_pcs_iso_ctrl_ln_3.cdb_prdata' driven by clock 'uc_clk'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
                                          -source_unit {u_pcs_iso_ctrl_ln_3\.iso_pipe_mb_tx_local_tx_preset_coef_reg} \
                                          -destination_unit {u_pcs_iso_ctrl_ln_3\.cdb_prdata\[17\:0\]}] \
                                          -comment {No need to synchronize since only UC read this reg.}

# "No synchronizer between source unit 'u_pcs_iso_ctrl_ln_0.iso_pipe_mb_tx_local_tx_preset_coef_reg' driven by clock 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0, pipe7_l00_clk' and destination unit 'u_pcs_iso_ctrl_ln_0.cdb_prdata' driven by clock 'uc_clk'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
                                          -source_unit {u_pcs_iso_ctrl_ln_0\.iso_pipe_mb_tx_local_tx_preset_coef_reg} \
                                          -destination_unit {u_pcs_iso_ctrl_ln_0\.cdb_prdata\[17\:0\]}] \
                                          -comment {No need to synchronize since only UC read this reg.}

# "No synchronizer between source unit 'u_pcs_iso_ctrl_ln_2.iso_pipe_mb_tx_local_tx_preset_coef_reg' driven by clock 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0, pipe7_l00_clk' and destination unit 'u_pcs_iso_ctrl_ln_2.cdb_prdata' driven by clock 'uc_clk'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
                                          -source_unit {u_pcs_iso_ctrl_ln_2\.iso_pipe_mb_tx_local_tx_preset_coef_reg} \
                                          -destination_unit {u_pcs_iso_ctrl_ln_2\.cdb_prdata\[17\:0\]}] \
                                          -comment {No need to synchronize since only UC read this reg.}

# "Reset signal 'u_apb_top_wrapper.u_async_apb_if_slv.u_phy_reset_sync_apb_preset.reset_sync_flop[1]' driven by clock 'uc_clk' is not synchronized to the clock 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0, pipe7_l00_clk' of the destination unit 'u_phy_state_chg_monitor_usb4_l01.pipe_phy_status_tgl'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                          -destination_unit {u_phy_state_chg_monitor_usb4_l01\.pipe_phy_status_tgl} \
                                          -severity Error \
                                          -occurrence {u_apb_top_wrapper\.u_async_apb_if_slv\.u_phy_reset_sync_apb_preset\.reset_sync_flop\[1\]\-u_phy_state_chg_monitor_usb4_l01\.pipe_phy_status_tgl} \
                                          -reset_domain {u_apb_top_wrapper\.u_async_apb_if_slv\.u_phy_reset_sync_apb_preset\.reset_sync_flop\[1\]}] \
                                          -comment {PIPE PhyStatus is guaranteed to be static when reset_n is released.}

# "Reset signal 'u_apb_top_wrapper.u_async_apb_if_slv.u_phy_reset_sync_apb_preset.reset_sync_flop[1]' driven by clock 'uc_clk' is not synchronized to the clock 'vclk, pipe7_l00_clk' of the destination unit 'u_phy_state_chg_monitor_usb3_usb4_l00.pipe_phy_status_tgl'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                          -destination_unit {u_phy_state_chg_monitor_usb3_usb4_l00\.pipe_phy_status_tgl} \
                                          -severity Error \
                                          -occurrence {u_apb_top_wrapper\.u_async_apb_if_slv\.u_phy_reset_sync_apb_preset\.reset_sync_flop\[1\]\-u_phy_state_chg_monitor_usb3_usb4_l00\.pipe_phy_status_tgl}] \
                                          -comment {PIPE PhyStatus is guaranteed to be static when reset_n is released.}

# "Reset signal 'u_phy_reconfig_ctlr.u_phy_scan_mux_cmn_reset_n_out.fcn_signal_out' driven by clock 'async_to_all' is not synchronized to the clock 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_clk' of the destination unit 'u_pma_iso_ctrl_ln_1.u_phy_data_sync_pma_rx_inject_error.data_sync_flop'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                          -source_clock_domain async_to_all \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_xcvr_ana\.rxda_des_clk} \
                                          -destination_unit {u_pma_iso_ctrl_ln_1\.u_phy_data_sync_pma_rx_inject_error\.data_sync_flop} \
                                          -severity Error \
                                          -occurrence {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out\-u_pma_iso_ctrl_ln_1\.u_phy_data_sync_pma_rx_inject_error\.data_sync_flop}] \
                                          -comment {When cmn_reset_n is deasserted, rx cdrlf clock will not work at the same time.}

# "Reset signal 'u_phy_reconfig_ctlr.u_phy_scan_mux_cmn_reset_n_out.fcn_signal_out' driven by clock 'async_to_all' is not synchronized to the clock 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ana.rxda_des_clk' of the destination unit 'u_pma_iso_ctrl_ln_2.u_phy_data_sync_pma_rx_inject_error.data_sync_flop'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                          -source_clock_domain async_to_all \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_ana\.rxda_des_clk} \
                                          -destination_unit {u_pma_iso_ctrl_ln_2\.u_phy_data_sync_pma_rx_inject_error\.data_sync_flop} \
                                          -severity Error \
                                          -occurrence {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out\-u_pma_iso_ctrl_ln_2\.u_phy_data_sync_pma_rx_inject_error\.data_sync_flop}] \
                                          -comment {When cmn_reset_n is deasserted, rx cdrlf clock will not work at the same time.}

# 
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                          -source_clock_domain async_to_all \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_pll0_clk_prog0\ pipe7_l00_clk} \
                                          -local_source_clock async_to_all \
                                          -local_destination_clock {u_phy_clkrst\.u_int_pma_tx_td_clk_ln_01_mux\.clk_out} \
                                          -severity Error \
                                          -local_source_reset {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out} \
                                          -local_destination_reset {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out} \
                                          -reset_domain {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out}] \
                                          -comment {When cmn_reset_n is deasserted, the clock generated from PLL has not toggled.}

# 
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                          -source_clock_domain async_to_all \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_pll0_clk_prog0\ pipe7_l00_clk} \
                                          -local_source_clock async_to_all \
                                          -local_destination_clock {u_phy_clkrst\.u_int_pma_tx_td_clk_ln_23_mux\.clk_out} \
                                          -severity Error \
                                          -local_source_reset {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out} \
                                          -local_destination_reset {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out} \
                                          -reset_domain {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out}] \
                                          -comment {When cmn_reset_n is deasserted, the clock generated from PLL has not toggled.}

# "Reset signal 'u_phy_reconfig_ctlr.u_phy_scan_mux_cmn_reset_n_out.fcn_signal_out' driven by clock 'async_to_all' is not synchronized to the clock 'pipe7_l00_clk, u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0' of the destination unit 'u_pma_iso_ctrl_ln_0.u_phy_data_sync_pma_tx_bist_hold.data_sync_flop'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                          -source_clock_domain async_to_all \
                                          -destination_clock_domain {pipe7_l00_clk\ u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_pll0_clk_prog0} \
                                          -local_source_clock async_to_all \
                                          -local_destination_clock {u_phy_clkrst\.u_int_pma_tx_td_clk_ln_01_mux\.clk_out} \
                                          -severity Error \
                                          -occurrence {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out\-u_pma_iso_ctrl_ln_0\.u_phy_data_sync_pma_tx_bist_hold\.data_sync_flop} \
                                          -local_source_reset {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out} \
                                          -local_destination_reset {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out} \
                                          -reset_domain {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out}] \
                                          -comment {When cmn_rst_n is deasserted, pma_tx_td_clk will not toggle.}

# "Reset signal waiver for phy_data_sync module with tx_td_clk"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                          -source_clock_domain async_to_all \
                                          -destination_clock_domain {pipe7_l00_clk\ u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_pll0_clk_prog0} \
                                          -local_source_clock async_to_all \
                                          -local_destination_clock {u_phy_clkrst\.u_int_pma_tx_td_clk_ln_01_mux\.clk_out} \
                                          -severity Error \
                                          -module phy_data_sync \
                                          -reset_domain {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out}] \
                                          -comment {When cmn_rst_n is deasserted, pma_tx_td_clk will not toggle.}

# "Reset signal waiver for phy_data_sync module with local reset synchronization"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                          -source_clock_domain async_to_all \
                                          -destination_clock_domain {pipe7_l00_clk\ u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_pll0_clk_prog0} \
                                          -local_source_clock async_to_all \
                                          -severity Error \
                                          -local_source_reset {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out} \
                                          -local_destination_reset {u_phy_reconfig_ctlr\.u_phy_scan_mux_cmn_reset_n_out\.fcn_signal_out}] \
                                          -comment {When cmn_rst_n is deasserted, pma_tx_td_clk will not toggle.}

# "Reset synchronization waiver for IEEE1687 TAP controller reset domain"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                          -source_clock_domain vclk_scan \
                                          -destination_clock_domain ieee1687_tck \
                                          -local_source_clock vclk_scan \
                                          -local_destination_clock ieee1687_tck \
                                          -severity Error \
                                          -local_source_reset ieee1687_rstn \
                                          -local_destination_reset ieee1687_rstn \
                                          -reset_domain ieee1687_rstn] \
                                          -comment {The IEEE logic is controlled by a TAP controller at the SoC level.  There are rules in the 1149.1 spec that govern how and when the reset can be toggled.}

# "Reset signal 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_tx_dsync.u_sa_sync_fifo_v1.u_sa_sync_fifo_v1_ptr_algn_det.ptr_align_det_reset_n' driven by clock 'async_to_all' is not synchronized to the clock 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0, pipe7_l00_clk' of the destination unit 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_tx_dsync.u_sa_sync_fifo_v1.u_sa_sync_fifo_v1_ptr_algn_det.u_reset_sync_ptr_align_det_flop.genblk1.reset_sync_flop'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                          -source_clock_domain async_to_all \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_pll0_clk_prog0\ pipe7_l00_clk} \
                                          -local_source_clock async_to_all \
                                          -local_destination_clock {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.*\.u_tx_dsync\.u_sa_sync_fifo_v1\.u_sa_sync_fifo_v1_ptr_algn_det\.u_clk_gating_cell_enq_clk_gated\.clk_out} \
                                          -severity Error \
                                          -local_source_reset {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.*\.u_tx_dsync\.u_sa_sync_fifo_v1\.u_sa_sync_fifo_v1_ptr_algn_det\.ptr_align_det_reset_n} \
                                          -local_destination_reset {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly.*\.u_tx_dsync\.u_sa_sync_fifo_v1\.u_sa_sync_fifo_v1_ptr_algn_det\.ptr_align_det_reset_n}] \
                                          -comment {phy_reset_sync_module.}

# "Reset signal 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_cdrlf_config.u_cdrlf_config_cdb_regs.cdr_2ol_max_det_reset_n' driven by clock 'async_to_all' is not synchronized to the clock 'uc_clk' of the destination unit 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_cdrlf_config.u_cdrlf_config_cdb_regs.u_reset_sync_cdr_2ol_max_det_flop.genblk1.reset_sync_flop'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                          -source_clock_domain async_to_all \
                                          -destination_clock_domain uc_clk \
                                          -local_source_clock async_to_all \
                                          -local_destination_clock {u_clk_gate_pma_cdb_clk_ln_.*\.i_clk_gate\.clk_out} \
                                          -severity Error \
                                          -local_source_reset {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.*\.u_rx_ctrl\.u_cdrlf_config\.u_cdrlf_config_cdb_regs\.cdr_2ol_max_det_reset_n} \
                                          -local_destination_reset {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.*\.u_rx_ctrl\.u_cdrlf_config\.u_cdrlf_config_cdb_regs\.cdr_2ol_max_det_reset_n}] \
                                          -comment {phy_reset_sync_module.}

# "Reset signal 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_eq_mode_change_det.reset_eq_mode_change' driven by clock 'async_to_all' is not synchronized to the clock 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_des_clk' of the destination unit 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_eq_mode_change_det.u_reset_sync_eq_mode_change.genblk1.reset_sync_flop'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                          -source_clock_domain async_to_all \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.*\.u_xcvr_ana\.rxda_des_clk} \
                                          -local_source_clock async_to_all \
                                          -local_destination_clock {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.*\.u_xcvr_clkrst\.u_clk_gating_cell_rx_ree_ctrl_clk\.clk_out} \
                                          -severity Error \
                                          -local_source_reset {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.*\.u_rx_ctrl\.u_rx_equalizer_engine\.u_eq_mode_change_det\.reset_eq_mode_change} \
                                          -local_destination_reset {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.*\.u_rx_ctrl\.u_rx_equalizer_engine\.u_eq_mode_change_det\.reset_eq_mode_change}] \
                                          -comment {phy_reset_sync_module.}

# "Reset signal 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_sig_detect_filt_apb_icfg.u_rx_sig_detect_filt_low_apb.u_rx_sig_detect_filt_low_v2.reset_rx_sig_det_filter_n' driven by clock 'async_to_all' is not synchronized to the clock 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ana.rxda_sd_clk' of the destination unit 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_sig_detect_filt_apb_icfg.u_rx_sig_detect_filt_low_apb.u_rx_sig_detect_filt_low_v2.u_reset_sync_rx_sig_det_filter_reset_n.genblk1.reset_sync_flop'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                          -source_clock_domain async_to_all \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.*\.u_xcvr_ana\.rxda_sd_clk} \
                                          -local_source_clock async_to_all \
                                          -local_destination_clock {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.*\.u_xcvr_clkrst\.u_clk_gating_cell_rx_sig_detect_clk\.clk_out} \
                                          -severity Error \
                                          -local_source_reset {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.*\.u_rx_ctrl\.u_rx_sig_detect_filt_apb_icfg\.u_rx_sig_detect_filt_low_apb\.u_rx_sig_detect_filt_low_v2\.reset_rx_sig_det_filter_n} \
                                          -local_destination_reset {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.*\.u_rx_ctrl\.u_rx_sig_detect_filt_apb_icfg\.u_rx_sig_detect_filt_low_apb\.u_rx_sig_detect_filt_low_v2\.reset_rx_sig_det_filter_n}] \
                                          -comment {phy_reset_sync_module.}

# "Reset signal 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_tx_dsync.u_sa_sync_fifo_v1.u_sa_sync_fifo_v1_ptr_algn_det.ptr_align_det_reset_n' driven by clock 'async_to_all' is not synchronized to the clock 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0, pipe7_l00_clk' of the destination unit 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_tx_dsync.u_sa_sync_fifo_v1.u_sa_sync_fifo_v1_ptr_algn_det.u_reset_sync_ptr_align_det_flop.genblk1.reset_sync_flop'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                          -source_clock_domain async_to_all \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_pll0_clk_prog0\ pipe7_l00_clk} \
                                          -local_source_clock async_to_all \
                                          -local_destination_clock {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.*\.u_tx_dsync\.u_sa_sync_fifo_v1\.u_sa_sync_fifo_v1_ptr_algn_det\.u_clk_gating_cell_enq_clk_gated\.clk_out} \
                                          -severity Error \
                                          -local_source_reset {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.*\.u_tx_dsync\.u_sa_sync_fifo_v1\.u_sa_sync_fifo_v1_ptr_algn_det\.ptr_align_det_reset_n} \
                                          -local_destination_reset {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane.*\.u_tx_dsync\.u_sa_sync_fifo_v1\.u_sa_sync_fifo_v1_ptr_algn_det\.ptr_align_det_reset_n}] \
                                          -comment {phy_reset_sync_module.}

# "Reset signal 'u_phy_clkrst.u_phy_reset_sync_dp_tx_sfifo_enq_reset_n_in_ln_0.reset_in_n' driven by clock 'async_to_all' is not synchronized to the clock 'pma_tx_td_clk' of the destination unit 'u_phy_clkrst.u_phy_reset_sync_dp_tx_sfifo_enq_reset_n_in_ln_0.reset_sync_flop'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                          -source_clock_domain async_to_all \
                                          -destination_clock_domain pma_tx_td_clk \
                                          -destination_unit {u_phy_clkrst\.u_phy_reset_sync_dp_tx_sfifo_enq_reset_n_in_ln_0\.reset_sync_flop} \
                                          -local_source_clock async_to_all \
                                          -local_destination_clock pma_tx_td_clk \
                                          -severity Error \
                                          -local_source_reset {u_phy_clkrst\.u_phy_reset_sync_dp_tx_sfifo_enq_reset_n_in_ln_0\.reset_in_n} \
                                          -local_destination_reset {u_phy_clkrst\.u_phy_reset_sync_dp_tx_sfifo_enq_reset_n_in_ln_0\.reset_in_n}] \
                                          -comment {phy_reset_sync_module.}

# "Reset signal 'u_phy_clkrst.u_phy_reset_sync_tx_sfifo_enq_reset_n_ln_0.reset_in_n' driven by clock 'async_to_all' is not synchronized to the clock 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_clk_prog0' of the destination unit 'u_phy_clkrst.u_phy_reset_sync_tx_sfifo_enq_reset_n_ln_0.reset_sync_flop'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                          -source_clock_domain async_to_all \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_pll0_clk_prog0} \
                                          -destination_unit {u_phy_clkrst\.u_phy_reset_sync_tx_sfifo_enq_reset_n_ln_0\.reset_sync_flop} \
                                          -local_source_clock async_to_all \
                                          -local_destination_clock {u_phy_clkrst\.u_gate_usb_datart_clk\.i_clk_gate\.clk_out} \
                                          -severity Error \
                                          -local_source_reset {u_phy_clkrst\.u_phy_reset_sync_tx_sfifo_enq_reset_n_ln_0\.reset_in_n} \
                                          -local_destination_reset {u_phy_clkrst\.u_phy_reset_sync_tx_sfifo_enq_reset_n_ln_0\.reset_in_n}] \
                                          -comment {phy_reset_sync_module.}
