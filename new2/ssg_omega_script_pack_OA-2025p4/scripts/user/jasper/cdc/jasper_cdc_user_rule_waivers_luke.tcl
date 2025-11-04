
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
                                          -source_clock_domain vclk_ana         \
                                          -destination_clock_domain uc_clk      \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_rescal_comp_rx}  \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_prdata\[12\]}] \
                                          -comment {cmnda_rescal_comp_rx connect to the apb for debug only}


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC  \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_tmpsns_sdm_clk_out} \
                                          -destination_clock_domain uc_clk       \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_temp_sensor_filt\.cmn_tmpsns_filt_out}  \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_prdata\[15\:0\]}] \
                                          -comment {cmn_tmpsns_filt_out connect to the apb for debug only}



check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain uc_clk         \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_sd_clk_cal_icfg\.u_vco_cal_sm_v4_top\.u_vco_cal_sm_v4\.vco_code_startup_value_sel} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_prdata\[4\:0\]}]  \
                                          -comment {vco_code connect to the apb for debug only}


#Below is latch in the PMA
#The sandh_en is from power island control (psm clock)
#Will be latched when the sandh_in is stable
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_rx_ctrl\.u_sandh_latch_rxda_sdcal_0_up\.sandh_out}] \
                                          -comment {cali code is stable when xcal_isl_state_sandh is toggle }

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_rx_ctrl\.u_sandh_latch_rxda_sdcal_0_azsel\.sandh_out}] \
                                          -comment {cali code is stable when xcal_isl_state_sandh is toggle }


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_rx_ctrl\.u_sandh_latch_rxda_sdcal_1_up\.sandh_out}] \
                                          -comment {cali code is stable when xcal_isl_state_sandh is toggle }

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_rx_ctrl\.u_sandh_latch_rxda_sdcal_1_azsel\.sandh_out}] \
                                          -comment {cali code is stable when xcal_isl_state_sandh is toggle }


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain pma_cmn_refclk0_int  \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_rx_ctrl\.u_sandh_latch_xcvrda_qcc_cal_code_azsel\.sandh_out}] \
                                          -comment {cali code is stable when xcal_isl_state_sandh is toggle }



check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_rx_ctrl\.u_sandh_latch_rxda_sdcal_0_up\.sandh_out}] \
                                          -comment {cali code is stable when xcal_isl_state_sandh is toggle }

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_rx_ctrl\.u_sandh_latch_rxda_sdcal_0_azsel\.sandh_out}] \
                                          -comment {cali code is stable when xcal_isl_state_sandh is toggle }


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_rx_ctrl\.u_sandh_latch_rxda_sdcal_1_up\.sandh_out}] \
                                          -comment {cali code is stable when xcal_isl_state_sandh is toggle }

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_rx_ctrl\.u_sandh_latch_rxda_sdcal_1_azsel\.sandh_out}] \
                                          -comment {cali code is stable when xcal_isl_state_sandh is toggle }

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain pma_cmn_refclk0_int  \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_rx_ctrl\.u_sandh_latch_xcvrda_qcc_cal_code_azsel\.sandh_out}] \
                                          -comment {cali code is stable when xcal_isl_state_sandh is toggle }


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_rx_ctrl\.u_sandh_latch_rxda_offset_dac_atten\.sandh_out}] \
                                          -comment {cali code is stable when xcal_isl_state_sandh is toggle}    

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_rx_ctrl\.u_sandh_latch_rxda_offset_dac_atten\.sandh_out}] \
                                          -comment {cali code is stable when xcal_isl_state_sandh is toggle}


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_rx_ctrl\.u_sandh_latch_rxda_ctle_cal_code_azsel_0\.sandh_out}] \
                                          -comment {cali code is stable when xcal_isl_state_sandh is toggle}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_rx_ctrl\.u_sandh_latch_rxda_ctle_cal_code_azsel_0\.sandh_out}] \
                                          -comment {cali code is stable when xcal_isl_state_sandh is toggle}                                          

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly0\.u_xcvr_ctrl\.u_power_sm_v4_top\.u_power_sm_v4\.psm_state_ack_reg} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly0\.u_xcvr_ctrl\.u_sandh_latch_xcvr_power_state_ack\.sandh_out}] \
                                          -comment {xcvrc_isl_state_sandh is from common module -ref clk, the ack is stable when in low power state}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly0\.u_xcvr_ctrl\.u_power_sm_v4_top\.u_power_sm_v4\.psm_current_state} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly0\.u_xcvr_ctrl\.u_sandh_latch_xcvr_power_state_en\.sandh_out}] \
                                          -comment {xcvrc_isl_state_sandh is from common module -ref clk, the ack is stable when in low power state}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly1\.u_xcvr_ctrl\.u_power_sm_v4_top\.u_power_sm_v4\.psm_state_ack_reg} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly1\.u_xcvr_ctrl\.u_sandh_latch_xcvr_power_state_ack\.sandh_out}] \
                                          -comment {xcvrc_isl_state_sandh is from common module -ref clk, the ack is stable when in low power state}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly1\.u_xcvr_ctrl\.u_power_sm_v4_top\.u_power_sm_v4\.psm_current_state} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly1\.u_xcvr_ctrl\.u_sandh_latch_xcvr_power_state_en\.sandh_out}] \
                                          -comment {xcvrc_isl_state_sandh is from common module -ref clk, the ack is stable when in low power state}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_xcvr_ctrl\.u_power_sm_v4_top\.u_power_sm_v4\.psm_state_ack_reg} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_xcvr_ctrl\.u_sandh_latch_xcvr_power_state_ack\.sandh_out}] \
                                          -comment {xcvrc_isl_state_sandh is from common module -ref clk, the ack is stable when in low power state}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_xcvr_ctrl\.u_power_sm_v4_top\.u_power_sm_v4\.psm_current_state} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_xcvr_ctrl\.u_sandh_latch_xcvr_power_state_en\.sandh_out}] \
                                          -comment {xcvrc_isl_state_sandh is from common module -ref clk, the ack is stable when in low power state}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_ctrl\.u_power_sm_v4_top\.u_power_sm_v4\.psm_state_ack_reg} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_ctrl\.u_sandh_latch_xcvr_power_state_ack\.sandh_out}] \
                                          -comment {xcvrc_isl_state_sandh is from common module -ref clk, the ack is stable when in low power state}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_ctrl\.u_power_sm_v4_top\.u_power_sm_v4\.psm_current_state} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_ctrl\.u_sandh_latch_xcvr_power_state_en\.sandh_out}] \
                                          -comment {xcvrc_isl_state_sandh is from common module -ref clk, the ack is stable when in low power state}


#-destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_rx_ctrl\.u_sandh_latch_rxda_sampler_latch_cal_even/odd_cp/cm\.sandh_out}]

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_xcvr_ana\.rxda_des_clk} \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_rx_ctrl\.u_rx_sampler_latch_cal_wrapper\.u_rx_sampler_latch_cal\.u_rx_sampler_latch_cal_sequencer\.st_current_state}] \
                                          -comment {cali code is stable when xcal_isl_state_sandh is toggle}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_xcvr_ana\.rxda_des_clk} \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_rx_ctrl\.u_rx_sampler_latch_cal_wrapper\.u_rx_sampler_latch_cal\.u_rx_sampler_latch_cal_ctrl\.csm_current_state}] \
                                          -comment {cali code is stable when xcal_isl_state_sandh is toggle}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_ana\.rxda_des_clk} \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_rx_ctrl\.u_rx_sampler_latch_cal_wrapper\.u_rx_sampler_latch_cal\.u_rx_sampler_latch_cal_sequencer\.st_current_state}] \
                                          -comment {cali code is stable when xcal_isl_state_sandh is toggle}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LTCH \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_ana\.rxda_des_clk} \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_rx_ctrl\.u_rx_sampler_latch_cal_wrapper\.u_rx_sampler_latch_cal\.u_rx_sampler_latch_cal_ctrl\.csm_current_state}] \
                                          -comment {cali code is stable when xcal_isl_state_sandh is toggle}


#RDC DFRS waiver
#Destination flip-flop is data sync
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.cmn_ssm_auto_cal_skip} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_clk_gating_cell_cmn_ibiascal_clk\.genblk1\.u_data_sync_en_sync\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.cmn_ssm_auto_cal_skip} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_clk_gating_cell_cmn_sd_clk_cal_ref_clk\.genblk1\.u_data_sync_en_sync\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.cmn_ssm_auto_cal_skip} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_sd_clk_cal_icfg\.u_vco_cal_sm_v4_top\.u_vco_cal_sm_v4\.u_data_sync_vco_cal_run\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.cmn_ssm_auto_cal_skip} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_tx_rescal_ctrl_pu_icfg\.u_tx_rescal_ctrl_pu\.u_bin_cal\.u_data_sync_cal_run\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.cmn_ssm_auto_cal_skip} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_clk_gating_cell_cmn_tx_rescal_pu_clk\.genblk1\.u_data_sync_en_sync\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.cmn_ssm_auto_cal_skip} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_rx_rescal_ctrl_icfg\.u_rx_res_cal_ctrl\.u_bin_cal\.u_data_sync_cal_run\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.cmn_ssm_auto_cal_skip} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_clk_gating_cell_cmn_rx_rescal_clk\.genblk1\.u_data_sync_en_sync\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.cmn_ssm_auto_cal_skip} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_ibiascal_icfg\.u_bin_cal_apb\.u_bin_cal\.u_data_sync_cal_run\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}                                          

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.cmn_ssm_auto_cal_skip} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_tx_rescal_ctrl_pd_icfg\.u_tx_rescal_ctrl_pd\.u_bin_cal\.u_data_sync_cal_run\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[10\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_ibiascal_icfg\.u_bin_cal_apb\.u_bin_cal\.u_data_sync_cal_run\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}
                                          
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[2\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_sd_clk_cal_icfg\.u_vco_cal_sm_v4_top\.u_vco_cal_sm_v4\.u_data_sync_vco_cal_run\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[8\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_tx_rescal_ctrl_pu_icfg\.u_tx_rescal_ctrl_pu\.u_bin_cal\.u_data_sync_cal_run\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_bg_cal\.genblk1\.mcsm_sub_cal\[3\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_clk_gating_cell_cmn_bgcal_clk\.genblk1\.u_data_sync_en_sync\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[2\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_clk_gating_cell_cmn_sd_clk_cal_ref_clk\.genblk1\.u_data_sync_en_sync\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}   

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[6\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_clk_gating_cell_cmn_tx_rescal_pd_clk\.genblk1\.u_data_sync_en_sync\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.cmn_ssm_auto_cal_skip} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_clk_gating_cell_cmn_tx_rescal_pu_clk\.genblk1\.u_data_sync_en_sync\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.cmn_ssm_auto_cal_skip} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_clk_gating_cell_cmn_tx_rescal_pd_clk\.genblk1\.u_data_sync_en_sync\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.cmn_ssm_auto_cal_skip} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_tx_rescal_ctrl_pu_icfg\.u_tx_rescal_ctrl_pu\.u_bin_cal\.u_data_sync_cal_run\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[4\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_clk_gating_cell_cmn_rx_rescal_clk\.genblk1\.u_data_sync_en_sync\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[6\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_tx_rescal_ctrl_pd_icfg\.u_tx_rescal_ctrl_pd\.u_bin_cal\.u_data_sync_cal_run\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[8\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_clk_gating_cell_cmn_tx_rescal_pu_clk\.genblk1\.u_data_sync_en_sync\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[4\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_rx_rescal_ctrl_icfg\.u_rx_res_cal_ctrl\.u_bin_cal\.u_data_sync_cal_run\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}
                                          
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_bg_cal\.genblk1\.mcsm_sub_cal\[3\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_bg_cal_ctrl_apb_icfg\.u_bin_cal_apb\.u_bin_cal\.u_data_sync_cal_run\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}
                                          

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[10\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_clk_gating_cell_cmn_ibiascal_clk\.genblk1\.u_data_sync_en_sync\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {destination flip-flop is data sync}


#cal reset is assert sync and deassert sync
#After all calibration are done, then cal reset is assert to shut down cali power domain
#cal_done is stable before cal reset is assert;
#from cmn_cal_done to the cmn ctrl state
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_ibiascal_icfg\.u_bin_cal_apb\.u_bin_cal\.cal_current_state\[0\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[12\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run}] \
                                          -comment {cal_done is stable before cal reset is assert}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_clk_gating_cell_cmn_ibiascal_clk\.genblk3\.u_data_delay_en_ack\.data_delay_flop} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[13\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run}] \
                                          -comment {data_delay_flop is stable before cal reset is assert}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_ibiascal_icfg\.u_bin_cal_apb\.u_bin_cal\.cal_current_state\[0\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[11\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run}] \
                                          -comment {cal_done is stable before cal reset is assert}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_rx_rescal_ctrl_icfg\.u_rx_res_cal_ctrl\.u_bin_cal\.cal_current_state\[0\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[4\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run}] \
                                          -comment {cal_done is stable before cal reset is assert}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_bg_cal_ctrl_apb_icfg\.u_bin_cal_apb\.u_bin_cal\.cal_current_state\[0\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_bg_cal\.genblk1\.mcsm_sub_cal\[4\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run}] \
                                          -comment {cal_done is stable before cal reset is assert}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_bg_cal_ctrl_apb_icfg\.u_bin_cal_apb\.u_bin_cal\.cal_current_state\[0\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_bg_cal\.genblk1\.mcsm_sub_cal\[3\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run}] \
                                          -comment {cal_done is stable before cal reset is assert}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_clk_gating_cell_cmn_ibiascal_clk\.genblk3\.u_data_delay_en_ack\.data_delay_flop} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[12\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run}] \
                                          -comment {cal_done is stable before cal reset is assert}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_tx_rescal_ctrl_pu_icfg\.u_tx_rescal_ctrl_pu\.u_bin_cal\.cal_current_state\[0\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[8\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run}] \
                                          -comment {cal_done is stable before cal reset is assert}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_ibiascal_icfg\.u_bin_cal_apb\.u_bin_cal\.cal_current_state\[0\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[13\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run}] \
                                          -comment {cal_done is stable before cal reset is assert}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_sd_clk_cal_icfg\.u_vco_cal_sm_v4_top\.u_vco_cal_sm_v4\.vc_current_state\[2\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[2\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run}] \
                                          -comment {cal_done is stable before cal reset is assert}


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_tx_rescal_ctrl_pd_icfg\.u_tx_rescal_ctrl_pd\.u_bin_cal\.cal_current_state\[0\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[7\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run}] \
                                          -comment {cal_done is stable before cal reset is assert}


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_tx_rescal_ctrl_pd_icfg\.u_tx_rescal_ctrl_pd\.u_bin_cal\.cal_current_state\[0\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[6\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run}] \
                                          -comment {cal_done is stable before cal reset is assert}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_rx_rescal_ctrl_icfg\.u_rx_res_cal_ctrl\.u_bin_cal\.cal_current_state\[0\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[5\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run}] \
                                          -comment {cal_done is stable before cal reset is assert}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_tx_rescal_ctrl_pu_icfg\.u_tx_rescal_ctrl_pu\.u_bin_cal\.cal_current_state\[0\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[9\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run}] \
                                          -comment {cal_done is stable before cal reset is assert}
                                          

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_ibiascal_icfg\.u_bin_cal_apb\.u_bin_cal\.cal_current_state\[0\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[10\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run}] \
                                          -comment {cal_done is stable before cal reset is assert}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_sd_clk_cal_icfg\.u_vco_cal_sm_v4_top\.u_vco_cal_sm_v4\.vc_current_state\[2\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_multical_sm_v3_auto_cal\.genblk1\.mcsm_sub_cal\[3\]\.genblk1\.u_cdnsdru_multical_state_flop\.curr_run}] \
                                          -comment {cal_done is stable before cal reset is assert}
 
#src reset is cmn_ssm_reset_n = cmn_reset_sync_n;
#dst reset is reset sync of reset_pllsm0_wsr_reset_n = cmn_pll0_reset_sync_n & pllc_isl_power_reset_wsr_n;
#cmn_pll0_reset_sync_n is reset sync of reset_pll0_reset_sync_n = cmn_reset_n & cmn_pll0_reset_n;
#if cmn_reset_n is assert, then reset_pllsm0_wsr_reset_n will be assert at the same time
#therefore, the below RDC can be waiver
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_startup_sm_v4_top\.u_startup_sm_v4\.ssm_current_state\[6\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_pll0_ctrl\.u_pll_ctrl_sm_v3_top\.pllsm_clk_gate_en}] \
                                          -comment {the dst reset have more condition}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_startup_sm_v4_top\.u_data_sync_ssm_post_auto_cal_en_ovrd\.genblk1\.data_sync_flop\[1\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_pll0_ctrl\.u_pll_ctrl_sm_v3_top\.u_pll_ctrl_sm_v3\.pllsm_current_state}] \
                                          -comment {the dst reset have more condition}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_startup_sm_v4_top\.u_data_sync_ssm_post_auto_cal_en_ovrd\.genblk1\.data_sync_flop\[1\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_pll0_ctrl\.u_pll_ctrl_sm_v3_top\.pllsm_clk_gate_en}] \
                                          -comment {the dst reset have more condition}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_startup_sm_v4_top\.u_startup_sm_v4\.ssm_current_state\[6\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_pll0_ctrl\.u_pll_ctrl_sm_v3_top\.u_pll_ctrl_sm_v3\.pllsm_current_state}] \
                                          -comment {the dst reset have more condition}

#source reg reset reset_cdb_preset_diag_isl_synced_cdbclk_n = cmn_cdb_preset_n & diag_isl_power_reset_nsr_n;
#diag_isl_power_reset_nsr_n is from diag power island which will be enable after the cmn_reset_n & cdb override;
#destination reg reset cmn_cdb_preset_n
#source reset will deassert later after cmn_cdb_preset_n;while assert as the same as destination reset(with cmn_cdb_preset_n)
#Normal mode, the diag_isl_power_reset_nsr_n is always assert
#In diag mode, after the checking finish, it should assert cmn_cdb_preset_n first or reset all PMA logic.
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain uc_clk \
                                          -destination_clock_domain uc_clk \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_clk_freq_msmt_v1_top\.u_clk_freq_msmt_v1_cdb_regs\.u_cdb_slave\.cdb_current_state\[0\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_current_state}] \
                                          -comment {reset assert will assert at the same time}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain uc_clk \
                                          -destination_clock_domain uc_clk \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_current_state} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_clk_freq_msmt_v1_top\.u_clk_freq_msmt_v1_cdb_regs\.u_cdb_slave\.cdb_current_state}] \
                                          -comment {reset assert will assert at the same time}


#src reset is reset_pllsm0_wsr_reset_n
#dst reset is reset_pllsm0_nsr_reset_n
#when reset_pllsm0_wsr_reset_n assert, reset_pllsm0_nsr_reset_n will assert
#However, if reset_pllsm0_nsr_reset_n assert, reset_pllsm0_wsr_reset_n cannot be assert

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_pll0_ctrl\.u_ana_en_del_ctrl_cmnda_en\.delay_reg}] \
                                          -comment {when power off, reset_pllsm0_wsr_reset_n will not be assert but reset_pllsm0_nsr_reset_n will be assert}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_pll0_ctrl\.u_ana_en_del_ctrl_cmn_pll_rst_n\.en_out}] \
                                          -comment {when power off, reset_pllsm0_wsr_reset_n will not be assert but reset_pllsm0_nsr_reset_n will be assert}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_pll0_ctrl\.u_ana_en_del_ctrl_cmn_pll_rst_n\.delay_reg}] \
                                          -comment {when power off, reset_pllsm0_wsr_reset_n will not be assert but reset_pllsm0_nsr_reset_n will be assert}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_pll0_ctrl\.u_ana_en_del_ctrl_cmnda_en\.en_out}] \
                                          -comment {when power off, reset_pllsm0_wsr_reset_n will not be assert but reset_pllsm0_nsr_reset_n will be assert}

#src reset is cmn_ssm_reset_n (cmn_reset_sync_n)
#dst reset is reset_rx_sig_det_en_to_cmn_n = cmn_ssm_reset_n & (rx_sig_det_en_to_cmn | ~cmn_macro_suspend_ack)
#dst reset have more condition
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_startup_sm_v4_top\.u_startup_sm_v4\.ssm_current_state\[3\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.cmnda_bias_bandgap_en_hold}] \
                                          -comment {dst reset have more condition}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_startup_sm_v4_top\.u_data_sync_ssmda_bias_en_ovrd\.genblk1\.data_sync_flop\[1\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.cmnda_bias_bandgap_en_hold}] \
                                          -comment {dst reset have more condition}


#src reset is cmn_ssm_reset_n (cmn_reset_sync_n)
#dst reset is reset_pllsm1_wsr_reset_n = cmn_pll1_reset_sync_n(reset sync of cmn_reset_n & cmn_pll1_reset_n) & pllc_isl_power_reset_wsr_n;
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_ring_cmn_pll1_ctrl\.u_ring_pll_ctrl_sm_v0_top\.pllsm_clk_gate_en}] \
                                          -comment {dst reset have more condition}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_ring_cmn_pll1_ctrl\.u_ring_pll_ctrl_sm_v0_top\.u_ring_pll_ctrl_sm_v0\.pllsm_current_state}] \
                                          -comment {dst reset have more condition}



#TODO begin, need low power waveform double check.
#srt reset is reset_cmn_hs_rst_rel_sm_reset_n              = xcvrc_isl_power_reset_nsr_n & cmn_reset_sync_n;
#dst reset is reset_tx_reset_n(reset_xcvr_psm_reset_n)     = cmn_reset_sync_n & xcvr_link_reset_n & xcvrc_isl_power_reset_wsr_n;
#Reason1: the dst clock is xcvr_psm_clk_enabled_gated, will be gated if go into low power state (xcvrc_isl_power_reset_nsr_n will be assert)
#Reason2: clk_reset_ack will not toggle if want to low power state

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_hsrrsm_tx\.hsrrsm_current_state\[0\]\ u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_hsrrsm_tx\.hsrrsm_current_state\[2\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly0\.u_xcvr_ctrl\.u_xcvr_hsrrsm_tx\.hsrrsm_current_state}] \
                                          -comment {clock is gated off when go into low power state}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_hsrrsm_tx\.hsrrsm_current_state\[2\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly0\.u_xcvr_ctrl\.u_xcvr_hsrrsm_tx\.clk_reset_stp_d1}] \
                                          -comment {clock is gated off when go into low power state}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly0\.u_xcvr_ctrl\.u_xcvr_hsrrsm_tx\.hsrrsm_current_state\[1\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_hsrrsm_tx\.hsrrsm_current_state}] \
                                          -comment {clock is gated off when go into low power state}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_hsrrsm_tx\.hsrrsm_current_state\[0\]\ u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_hsrrsm_tx\.hsrrsm_current_state\[2\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly1\.u_xcvr_ctrl\.u_xcvr_hsrrsm_tx\.hsrrsm_current_state}] \
                                          -comment {clock is gated off when go into low power state}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_hsrrsm_tx\.hsrrsm_current_state\[2\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly1\.u_xcvr_ctrl\.u_xcvr_hsrrsm_tx\.clk_reset_stp_d1}] \
                                          -comment {clock is gated off when go into low power state}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly1\.u_xcvr_ctrl\.u_xcvr_hsrrsm_tx\.hsrrsm_current_state\[1\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_hsrrsm_tx\.hsrrsm_current_state}] \
                                          -comment {clock is gated off when go into low power state}



check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_hsrrsm_tx\.hsrrsm_current_state\[0\]\ u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_hsrrsm_tx\.hsrrsm_current_state\[2\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_xcvr_ctrl\.u_xcvr_hsrrsm_tx\.hsrrsm_current_state}] \
                                          -comment {clock is gated off when go into low power state}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_xcvr_ctrl\.u_xcvr_hsrrsm_tx\.hsrrsm_current_state\[1\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_hsrrsm_tx\.hsrrsm_current_state}] \
                                          -comment {clock is gated off when go into low power state}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_hsrrsm_tx\.hsrrsm_current_state\[2\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_xcvr_ctrl\.u_xcvr_hsrrsm_tx\.clk_reset_stp_d1}] \
                                          -comment {clock is gated off when go into low power state}


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_hsrrsm_tx\.hsrrsm_current_state\[0\]\ u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_hsrrsm_tx\.hsrrsm_current_state\[2\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_ctrl\.u_xcvr_hsrrsm_tx\.hsrrsm_current_state}] \
                                          -comment {clock is gated off when go into low power state}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_ctrl\.u_xcvr_hsrrsm_tx\.hsrrsm_current_state\[1\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_hsrrsm_tx\.hsrrsm_current_state}] \
                                          -comment {clock is gated off when go into low power state}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_hsrrsm_tx\.hsrrsm_current_state\[2\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_ctrl\.u_xcvr_hsrrsm_tx\.clk_reset_stp_d1}] \
                                          -comment {clock is gated off when go into low power state}

#TODO end




#src reset: cmn_cdb_preset_n
#dst reset: reset_cdb_preset_diag_isl_synced_cdbclk_n = cmn_cdb_preset_n & diag_isl_power_reset_nsr_n;
#the dst reset have more condition, so canbe waived

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain uc_clk \
                                          -destination_clock_domain uc_clk \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_pwdata_reg\[15\:0\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_clk_freq_msmt_v1_top\.u_clk_freq_msmt_v1_cdb_regs\.ref_clk_tmr_reg\[15\:0\]}] \
                                          -comment {the dst reset have more condition, so canbe waived}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain uc_clk \
                                          -destination_clock_domain uc_clk \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_pwrite_reg} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_clk_freq_msmt_v1_top\.u_clk_freq_msmt_v1_cdb_regs\.clk_freq_msmt_ctrl_reg\[15\]}] \
                                          -comment {the dst reset have more condition, so canbe waived}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain uc_clk \
                                          -destination_clock_domain uc_clk \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_penable_reg} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_clk_freq_msmt_v1_top\.u_clk_freq_msmt_v1_cdb_regs\.u_cdb_slave\.cdb_current_state}] \
                                          -comment {the dst reset have more condition, so canbe waived}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain uc_clk \
                                          -destination_clock_domain uc_clk \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_paddr_reg\[13\:2\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_clk_freq_msmt_v1_top\.u_clk_freq_msmt_v1_cdb_regs\.u_cdb_slave\.cdb_current_state}] \
                                          -comment {the dst reset have more condition, so canbe waived}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain uc_clk \
                                          -destination_clock_domain uc_clk \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_psel_reg} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_clk_freq_msmt_v1_top\.u_clk_freq_msmt_v1_cdb_regs\.u_cdb_slave\.cdb_current_state}] \
                                          -comment {the dst reset have more condition, so canbe waived}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain uc_clk \
                                          -destination_clock_domain uc_clk \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_pwdata_reg\[15\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_clk_freq_msmt_v1_top\.u_clk_freq_msmt_v1_cdb_regs\.clk_freq_msmt_ctrl_reg\[15\]}] \
                                          -comment {the dst reset have more condition, so canbe waived}                                          

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain uc_clk \
                                          -destination_clock_domain uc_clk \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_pwrite_reg} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_clk_freq_msmt_v1_top\.u_clk_freq_msmt_v1_cdb_regs\.ref_clk_tmr_reg\[15\:0\]}] \
                                          -comment {the dst reset have more condition, so canbe waived}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain uc_clk \
                                          -destination_clock_domain uc_clk \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_paddr_reg\[1\:0\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_clk_freq_msmt_v1_top\.u_clk_freq_msmt_v1_cdb_regs\.clk_freq_msmt_ctrl_reg\[15\]}] \
                                          -comment {the dst reset have more condition, so canbe waived}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain uc_clk \
                                          -destination_clock_domain uc_clk \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_paddr_reg\[1\:0\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_clk_freq_msmt_v1_top\.u_clk_freq_msmt_v1_cdb_regs\.ref_clk_tmr_reg\[15\:0\]}] \
                                          -comment {the dst reset have more condition, so canbe waived}



#src reset: reset_cdb_preset_diag_isl_synced_cdbclk_n = cmn_cdb_preset_n & diag_isl_power_reset_nsr_n;
#dst reset: cmn_cdb_preset_n
#for cmn_clk_freq_msmt function, the software should open related power island then do operation for dignostic purpose
#therefore, after open power, if want to run normal function. It should assert cdb_preset_n again.
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain uc_clk \
                                          -destination_clock_domain uc_clk \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_clk_freq_msmt_v1_top\.u_clk_freq_msmt_v1_cdb_regs\.u_data_sync_measurement_done\.genblk1\.data_sync_flop\[1\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_prdata\[14\]}] \
                                          -comment {when power off the diag power island,it should assert cdb_preset_n again before running normal function}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain uc_clk \
                                          -destination_clock_domain uc_clk \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_clk_freq_msmt_v1_top\.u_clk_freq_msmt_v1_cdb_regs\.clk_freq_msmt_ctrl_reg\[15\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_prdata\[15\]}] \
                                          -comment {when power off the diag power island,it should assert cdb_preset_n again before running normal function}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain uc_clk \
                                          -destination_clock_domain uc_clk \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_clk_freq_msmt_v1_top\.u_clk_freq_msmt_v1_cdb_regs\.u_cdb_slave\.cdb_current_state\[0\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_pready}] \
                                          -comment {when power off the diag power island,it should assert cdb_preset_n again before running normal function}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain uc_clk \
                                          -destination_clock_domain uc_clk \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_func\.u_cmn_clk_freq_msmt_v1_top\.u_clk_freq_msmt_v1_cdb_regs\.ref_clk_tmr_reg\[15\:0\]} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_cdb\.u_cdb_local_bridge\.cdb_prdata\[15\:0\]}] \
                                          -comment {when power off the diag power island,it should assert cdb_preset_n again before running normal function}






#from pma common ready to pcs common ready
#dst have sync cell to decline cdc
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_startup_sm_v4_top\.u_startup_sm_v4\.ssm_current_state\[0\]} \
                                          -destination_unit {u_phy_clkrst\.u_dp_link_reset_sequencer\.u_phy_data_sync_pma_cmn_ready\.data_sync_flop\[0\]}] \
                                          -comment {dst cell is data sync}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_startup_sm_v4_top\.u_startup_sm_v4\.ssm_current_state\[0\]} \
                                          -destination_unit {u_phy_clkrst\.u_phy_reset_sequencer\.u_phy_data_sync_pma_cmn_ready\.data_sync_flop\[0\]}] \
                                          -comment {dst cell is data sync}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_startup_sm_v4_top\.u_startup_sm_v4\.ssm_current_state\[0\]} \
                                          -destination_unit {u_phy_clkrst\.u_usb3_link_reset_sequencer\.u_phy_data_sync_pma_cmn_ready\.data_sync_flop\[0\]}] \
                                          -comment {dst cell is data sync}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_startup_sm_v4_top\.u_startup_sm_v4\.ssm_current_state\[0\]} \
                                          -destination_unit {u_phy_clkrst\.u_usb4_link_reset_sequencer\.u_phy_data_sync_pma_cmn_ready\.data_sync_flop\[0\]}] \
                                          -comment {dst cell is data sync}


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ctrl\.u_startup_sm_v4_top\.u_startup_sm_v4\.ssm_current_state\[0\]} \
                                          -destination_unit {u_phy_clkrst\.u_usb_link_reset_sequencer\.u_phy_data_sync_pma_cmn_ready\.data_sync_flop\[0\]}] \
                                          -comment {dst cell is data sync}

    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_mgnhs_mult_*_reg"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_mgnfs_mult_*_reg"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_ctrl_reg"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_lf_mult_reg"
    # 
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_mgnhs_mult_*_reg"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_mgnfs_mult_*_reg"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_ctrl_reg"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_lf_mult_reg"

    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_mgnhs_mult_*_reg"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_mgnfs_mult_*_reg"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_ctrl_reg"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_lf_mult_reg"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_mgnhs_mult_*_reg"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_mgnfs_mult_*_reg"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_ctrl_reg"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_drv_ctrl.u_tx_coef_calc.u_tx_coef_calc_cdb_regs.tx_txcc_lf_mult_reg"

    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_0.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_0.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[4\:0\]"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_0.u_bin_cal_apb_cdb_regs.cal_tune_reg\[4\:0\]"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_1.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_1.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[4\:0\]"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_1.u_bin_cal_apb_cdb_regs.cal_tune_reg\[4\:0\]"

    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_qcc_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_qcc_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[4\:0\]"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_qcc_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_tune_reg\[4\:0\]"

    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_ctle_vga_cal_ctrl_apb_icfg.u_bin_cal_apb_*.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_ctle_vga_cal_ctrl_apb_icfg.u_bin_cal_apb_*.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[5\:0\]"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_ctle_vga_cal_ctrl_apb_icfg.u_bin_cal_apb_*.u_bin_cal_apb_cdb_regs.cal_tune_reg\[5\:0\]"
    #
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_0.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_0.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[4\:0\]"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_0.u_bin_cal_apb_cdb_regs.cal_tune_reg\[4\:0\]"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_1.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_1.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[4\:0\]"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_sd_cal_ctrl_apb_icfg.u_bin_cal_apb_1.u_bin_cal_apb_cdb_regs.cal_tune_reg\[4\:0\]"

    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_qcc_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_qcc_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[4\:0\]"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_qcc_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_tune_reg\[4\:0\]"


    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_ctle_vga_cal_ctrl_apb_icfg.u_bin_cal_apb_*.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_ctle_vga_cal_ctrl_apb_icfg.u_bin_cal_apb_*.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[5\:0\]"
    # config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_ctle_vga_cal_ctrl_apb_icfg.u_bin_cal_apb_*.u_bin_cal_apb_cdb_regs.cal_tune_reg\[5\:0\]"


  # power switch internal registers for output override
#     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[0\] 0}}]
#     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[1\] 0}}]
#     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[2\] 1}}]
#     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[3\] 0}}]
#     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[4\] 0}}]
#     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[5\] 1}}]
#     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[6\] 0}}]
#     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[7\] 0}}]
#     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[14\] 0}}]
#
#
#     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[0\] 0}}]
#     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[1\] 0}}]
#     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[2\] 1}}]
#     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[3\] 0}}]
#     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[4\] 0}}]
#     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[5\] 1}}]
#     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[6\] 0}}]
#     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[7\] 0}}]
#     config_rtlds -signal -constant [subst {{${hier_path}u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.u_xcvr_diag_ovrd.u_xcvr_diag_ovrd_cdb_regs.xcvr_diag_xcal_pwri_ovrd_reg\[14\] 0}}]
#
    #config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_*_icfg.u_tx_rescal_ctrl_*.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    #config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_*_icfg.u_tx_rescal_ctrl_*.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[6\:0\]"
    #config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_tx_rescal_ctrl_*_icfg.u_tx_rescal_ctrl_*.u_bin_cal_apb_cdb_regs.cal_tune_reg\[6\:0\]"

    #config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_rx_rescal_ctrl_icfg.u_rx_res_cal_ctrl.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    #config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_rx_rescal_ctrl_icfg.u_rx_res_cal_ctrl.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[5\:0\]"
    #config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_rx_rescal_ctrl_icfg.u_rx_res_cal_ctrl.u_bin_cal_apb_cdb_regs.cal_tune_reg\[5\:0\]"


    #config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_bg_cal_ctrl_apb_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[15\:14\]"
    #config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_bg_cal_ctrl_apb_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_ovrd_reg\[5\:0\]"
    #config_rtlds -signal -static "${hier_path}u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_bg_cal_ctrl_apb_icfg.u_bin_cal_apb.u_bin_cal_apb_cdb_regs.cal_tune_reg\[5\:0\]"



