# --- CDC_PR_LOGC --- #

# the waivers in comments are old format, kept for reference only which is from whistler design.

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LOGC \
                                          -source_unit      {u_mp_pma.u_pma_rev.u_xcvr.*.u_xcvr_ctrl.u_power_sm_v4_top.u_power_sm_v4.psm_current_state\[4\]} \
                                          -destination_unit {u_mp_pma.u_pma_rev.u_xcvr.*.u_data_sync_xcvr_power_state_en_s4.genblk1.data_sync_flop\[0\]}] \
                                          -comment {Logic in the path is a sample/hold latch which in only enabled/disabled when input and output of latch have same value.  No hazard.}    

#check_cdc -waiver -add -filter [check_cdc -filter -add \
#                                          -source_unit u_pma_rev.u_xcvr_la.u_xcvr_ctrl.u_power_sm_v4_top.u_power_sm_v4.psm_current_state*4* \
#                                          -destination_unit u_pma_rev.u_xcvr_la.u_data_sync_xcvr_power_state_en_s4.*.data_sync_flop* \
#                                          -tag CDC_PR_LOGC] \
#          -comment {Logic in the path is a sample/hold latch which in only enabled/disabled when input and output of latch have same value.  No hazard.}


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LOGC \
                                          -source_unit {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_ana.xcvrda_rx_fe_comp_out} \
                                          -destination_unit {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_rx_ctrl.u_ctle_vga_cal_ctrl_apb_icfg.u_bin_cal_apb_..u_bin_cal.u_data_sync_da_ana_cal_resp.genblk1.data_sync_flop\[0\]}] \
                                          -comment {Logic in path are static MUXs.  Thus no hazzard.}    


#check_cdc -waiver -add -filter [check_cdc -filter -add \
#                                          -source_unit u_pma_rev.u_cmn.u_cmn_ana.cmnda_bias_bgcal_comp \
#                                          -destination_unit u_pma_rev.u_cmn.u_cmn_func.u_bg_cal_ctrl_apb_icfg.u_bin_cal_apb.u_bin_cal.u_data_sync_da_ana_cal_resp.*.data_sync_flop* \
#                                          -tag CDC_PR_LOGC] \
#          -comment {Logic in path are static MUXs.  Thus no hazzard.}


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LOGC \
                                          -source_unit {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_clkrst.u_clk_gating_cell_rx_sampler_latch_cal.genblk1.u_data_sync_en_sync.genblk1.data_sync_flop\[3\]} \
                                          -destination_unit {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_xcvr_ctrl.u_data_sync_rx_sampler_latch_cal_clk_gate_ack.genblk1.data_sync_flop\[0\]}] \
                                          -comment {False violations.  Caused by setting number of ACK stages to 0 in data sync.}    



#check_cdc -waiver -add -filter [check_cdc -filter -add \
#                                          -source_unit u_pma_rev.u_xcvr_la.u_xcvr_clkrst.u_clk_gating_cell_rx_sampler_latch_cal.*.data_sync_flop* \
#                                          -destination_unit u_pma_rev.u_xcvr_la.u_xcvr_ctrl.u_data_sync_rx_sloc_cal_clk_gate_ack.*.data_sync_flop* \
#                                          -tag CDC_PR_LOGC] \
#          -comment {False violations.  Caused by setting number of ACK stages to 0 in data sync.}


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LOGC \
                                          -source_unit      {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_rx_ctrl.u_rx_equalizer_engine.u_ree_ana_ctrl_sm_v2_top_epath.u_ree_ana_ctrl_sm_v2.st_current_state\[2\]} \
                                          -destination_unit {u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane..u_ana_en_del_ctrl_rxda_epath_en.u_data_sync_en_in.genblk1.data_sync_flop\[0\]}] \
                                          -comment {False violations. The signals are not dynamic at the same time.}  

#check by ruiqi 2025/10/13


# --- CNV_ST_GLCH --- #


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CNV_ST_GLCH \
                                                -occurrence {u_pcs_iso_ctrl_cmn\.u_phy_data_sync_sts_regs\[4\]\.data_sync_flop\[0\]}] \
                                                -comment {reused code still need check in verify simulation}

# reused code from whistler, need check in verify simulation



check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CNV_ST_GLCH \
                                                -occurrence {u_mp_pma.u_pma_rev.u_xcvr_.*.u_xcvr_clkrst.u_data_sync_tx_sfifo_enq_reset_n_out.genblk1.data_sync_flop\[0\]}] \
                                                -comment {No glitch hazzard.  The logic in the path is an AND.  The launch F/Fs are mutually exclusive.  The rest of the logic is static}

#check_cdc -waiver -add -filter [check_cdc -filter -add \
#                                          -occurrence u_pma_rev.u_xcvr_la.u_xcvr_clkrst.u_data_sync_tx_sfifo_enq_reset_n_out.*.data_sync_flop* \
#                                          -tag CNV_ST_GLCH] \
#          -comment {No glitch hazzard.  The logic in the path is an AND.  The launch F/Fs are mutually exclusive.  The rest of the logic is static}




check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CNV_ST_GLCH \
                                                -occurrence {u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_vco_cal_sm_v4_top.u_vco_cal_sm_v4.u_data_sync_vco_cal_run.genblk1.data_sync_flop\[0\]}] \
                                                -comment {No glitch hazzard.  The logic in the path is an AND.  The launch F/Fs are mutually exclusive.  The rest of the logic is static}


#check_cdc -waiver -add -filter [check_cdc -filter -add \
#                                          -occurrence u_pma_rev.u_cmn.u_cmn_pll*_ctrl.u_pll_ctrl.u_vco_cal_sm_v4_top.u_vco_cal_sm_v4.u_data_sync_vco_cal_run.*.data_sync_flop* \
#                                          -tag CNV_ST_GLCH] \
#          -comment {No glitch hazzard.  The logic in the path are ORs.  The launch F/Fs are mutually exclusive.}




# --- RST_NO_CONS --- #

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag    RST_NO_CONS  \
                                                               -module phy_clock_mux \
                                                               -occurrence {u_phy_clkrst.u_pma_tx_td_clk_reset_mux_ln_1.clk_out}] \
                                                               -comment {clkrst module the phy_clock_mux is used for rst_mux}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag    RST_NO_CONS  \
                                                               -module phy_clock_mux \
                                                               -occurrence {u_phy_clkrst.u_mux_pipe_reset_n_sel.clk_out}] \
                                                               -comment {clkrst module the phy_clock_mux is used for rst_mux}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag    RST_NO_CONS  \
                                                               -module phy_clock_mux \
                                                               -occurrence {u_phy_clkrst.u_pma_tx_td_clk_reset_mux_ln_0.clk_out}] \
                                                               -comment {clkrst module the phy_clock_mux is used for rst_mux}



# --- RST_RS_RIDP --- #
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_RIDP \
                                                               -destination_unit {u_phy_clkrst\.u_.*_link_reset_sequencer\.count} \
                                                               -module phy_lane_reset_sequencer \
                                                               -instance {u_phy_clkrst\.u_.*_link_reset_sequencer}] \
                                                               -comment {reuse code in clkrst , this violation is in the internal logic.}

# --- RST_RS_FOUT --- #
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_FOUT \
                                                               -module phy_lane_reset_sequencer \
                                                               -instance {u_phy_clkrst\.u_.*_link_reset_sequencer} \
                                                               -reset_domain {u_phy_clkrst\.u_.*_link_reset_sequencer\.state}]\
                                                               -comment {reuse code in clkrst , this violation is in the internal logic.}
