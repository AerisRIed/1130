################################################################################
# Copyright (c) 2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design #
# Systems Inc. They may not be modified, copied, reproduced, distributed, or   #
# disclosed to third parties in any manner, medium, or form, in whole or in    #
# part, without the prior written consent of Cadence Design Systems Inc.       #
################################################################################

#########################################################
# Define all rule check waivers via the			#
# "check_cdc -waiver" command. Anything set here will	#
# supplement/override the settings in			#
# jasper_cdc_core_rule_waivers.tcl.			#
#########################################################

#puts [pwd]
source ../scripts/user/jasper/cdc/jasper_cdc_user_rule_waivers_ddwang.tcl
source ../scripts/user/jasper/cdc/jasper_cdc_user_rule_waivers_canchen.tcl
source ../scripts/user/jasper/cdc/jasper_cdc_user_rule_waivers_kaibo.tcl
source ../scripts/user/jasper/cdc/jasper_cdc_user_rule_waivers_ruiqi1.tcl
source ../scripts/user/jasper/cdc/jasper_cdc_user_rule_waivers_ruiqi2.tcl
source ../scripts/user/jasper/cdc/jasper_cdc_user_rule_waivers_luke.tcl
source ../scripts/user/jasper/cdc/jasper_cdc_user_rule_waivers_suhang.tcl
source ../scripts/user/jasper/cdc/jasper_cdc_user_rule_waivers_jinsong.tcl

# -------------------------------------------------------------------------------- #
#                            PCS waiver                                            #
# -------------------------------------------------------------------------------- #
# --- CDC_NO_SYNC --- #

#check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
#                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_pll0_clk_prog0} \
#                                          -destination_clock_domain uc_clk \
#                                          -source_unit {} \
#                                          -destination_unit {}] \
#                                          -comment {rx_data_k has qualifier(rx_data_valid)}

# from pipe_clk(pipe4_clk or pipe7_clk) to uc_clk
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
                                          -source_unit {u_mp_pcs_top_ln_0\.message_bus\.u_cdnsdru_usb4_message_bus_gen_reg_ctrl_v4\.phy_reg801\[2\:0\]} \
                                          -destination_unit {u_pcs_iso_ctrl_ln_0\.cdb_prdata\[23\:21\]}] \
                                          -comment {nelb position has qualifier(nelb_en)}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
                                          -source_unit {u_mp_pcs_top_ln_1\.message_bus\.u_cdnsdru_usb4_message_bus_gen_reg_ctrl_v4\.phy_reg801\[2\:0\]} \
                                          -destination_unit {u_pcs_iso_ctrl_ln_2\.cdb_prdata\[23\:21\]}] \
                                          -comment {nelb position has qualifier(nelb_en)}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
                                          -source_unit {u_mp_pcs_top_ln_0.mp_pcs_original.i_rpcs.i_datawidth.pipe_rx_data_k} \
                                          -destination_unit {u_pcs_iso_ctrl_ln_0.cdb_prdata\[15\:12\]}] \
                                          -comment {rx_data_k has qualifier(rx_data_valid)}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
                                          -source_unit {u_mp_pcs_top_ln_1.mp_pcs_original.i_rpcs.i_datawidth.pipe_rx_data_k} \
                                          -destination_unit {u_pcs_iso_ctrl_ln_2.cdb_prdata\[15\:12\]}] \
                                          -comment {rx_data_k has qualifier(rx_data_valid)}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
                                          -source_unit {u_mp_pcs_top_ln_0.mp_pcs_original.u_mp_tx_deemph.pipe_rate_d} \
                                          -destination_unit {u_pcs_iso_ctrl_ln_0.cdb_prdata\[17\:0\]}] \
                                          -comment {tx_deemph has qualifier(tx_deemph_stb)}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
                                          -source_unit {u_mp_pcs_top_ln_1.mp_pcs_original.u_mp_tx_deemph.pipe_rate_d} \
                                          -destination_unit {u_pcs_iso_ctrl_ln_2.cdb_prdata\[17\:0\]}] \
                                          -comment {tx_deemph has qualifier(tx_deemph_stb)}                                          

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
                                          -source_unit {u_mp_pcs_top_ln_0.mp_pcs_original.u_mp_tx_deemph.pipe_tx_deemph_d\[1\:0\]} \
                                          -destination_unit {u_pcs_iso_ctrl_ln_0.cdb_prdata\[1\:0\]}] \
                                          -comment {tx_deemph has qualifier(tx_deemph_stb)}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
                                          -source_unit {u_mp_pcs_top_ln_1.mp_pcs_original.u_mp_tx_deemph.pipe_tx_deemph_d\[1\:0\]} \
                                          -destination_unit {u_pcs_iso_ctrl_ln_2.cdb_prdata\[1\:0\]}] \
                                          -comment {tx_deemph has qualifier(tx_deemph_stb)}
                                          
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
                                          -source_unit {u_mp_pcs_top_ln_0.mp_pcs_original.u_mp_tx_deemph.pma_tx_deemphasis_usb3_gen2} \
                                          -destination_unit {u_pcs_iso_ctrl_ln_0.cdb_prdata\[17\:0\]}] \
                                          -comment {tx_deemph has qualifier(tx_deemph_stb)}                                          

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_NO_SYNC \
                                          -source_unit {u_mp_pcs_top_ln_1.mp_pcs_original.u_mp_tx_deemph.pma_tx_deemphasis_usb3_gen2} \
                                          -destination_unit {u_pcs_iso_ctrl_ln_2.cdb_prdata\[17\:0\]}] \
                                          -comment {tx_deemph has qualifier(tx_deemph_stb)}


# --- CDC_PR_FOUT --- #
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -source_unit pipe7_l*_powerdown* \
                                          -tag CDC_PR_FOUT] \
          -comment {There are no relative relationships between each re-sync'd signal.  Thus no hazard with multiple re-synchronizers.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -source_unit pipe4_powerdown* \
                                          -tag CDC_PR_FOUT] \
          -comment {There are no relative relationships between each re-sync'd signal.  Thus no hazard with multiple re-synchronizers.}

# Destination CDB register data syncs
#check_cdc -waiver -add -filter [check_cdc -filter -add \
#                                          -destination_unit u_p*_iso_ctrl_*.*phy_data_sync* \
#                                          -tag CDC_PR_FOUT] \
#          -comment {There are no relative relationships between each re-sync'd signal.  Thus no hazard with multiple re-synchronizers.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -source_unit u_tap_complex.u_async_apb_if_mst.u_async_ctrl_if_mst.st_current_state* \
                                          -tag CDC_PR_FOUT] \
          -comment {There are no relative relationships between each re-sync'd signal.  Thus no hazard with multiple re-synchronizers.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -source_unit u_pcs_iso_ctrl_ln_*.phy_pipe_lm_ctrl_sts*0* \
                                          -tag CDC_PR_FOUT] \
          -comment {There are no relative relationships between each re-sync'd signal.  Thus no hazard with multiple re-synchronizers.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -source_unit u_mp_pcs_top_ln_*.mp_pcs_original.i_pwr_rate_ctrl.path_128b_sel \
                                          -tag CDC_PR_FOUT] \
          -comment {There are no relative relationships between each re-sync'd signal.  Thus no hazard with multiple re-synchronizers.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -source_unit u_mp_pcs_top_ln_*.mp_pcs_original.i_pwr_rate_ctrl.clk_en_ref \
                                          -tag CDC_PR_FOUT] \
          -comment {There is a relative relationship here.  However, the data synchronizers have different delays, 2 vs. 4, to deal with this.  Thus can waive.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -source_unit pipe4_l0*_tx_det_rx_lpbk \
                                          -tag CDC_PR_FOUT] \
          -comment {inside reuse mp_pcs: tx_det_rx_lpbk is indeed synced to refclk twice. but no function issue.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -source_unit pipe4_l0*_tx_elec_idle \
                                          -tag CDC_PR_FOUT] \
          -comment {inside reuse mp_pcs: tx_elec_idle is indeed synced to refclk twice. but no function issue.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -source_unit pipe4_rate \
                                          -tag CDC_PR_FOUT] \
          -comment {pipe4_rate is used by all original lanes and synced inside each instance. but no function issue.}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp \
                                          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_rx_ctrl\.u_rx_diag_ovrd\.u_rx_diag_ovrd_cdb_regs\.rx_diag_sigdet_tune_reg\[12\]} \
                                          -tag CDC_PR_FOUT] \
          -comment {This signal is sigdetect and synced to mp_pcs_original and mp_pma...rx_equalizer_engine. but no function issue.}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp \
                                          -tag CDC_PR_FOUT \
          -source_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_rx_ctrl\.u_rx_sig_detect_filt_apb_icfg\.u_rx_sig_detect_filt_low_apb\.u_rx_sig_detect_filt_low_v2\.st_ctrl_current_state\[1\:0\]}] \
          -comment {There are no relative relationships between mp_pcs_original & rx_equalizer_engine; There are no relative relationships between u_pma_iso_ctrl_ln_1 & u_pcs_iso_ctrl_ln_0. There is a relative relationship between u_pcs_iso_ctrl_ln_0.xxx_sync but goes to pipe4/pipe7 different ways, Thus can waive}



# --- CDC_PR_LOGC --- #          

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LOGC \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_pll0_clk_prog0} \
                                          -source_unit {u_mp_pcs_top_ln_0\.mp_pcs_original\.i_pwr_rate_ctrl\.pma_xcvr_pll_clk_en} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly0\.u_xcvr_clkrst\.u_clk_gating_cell_xcvr_pll_clk_fullrt\.genblk1\.u_data_sync_en_sync\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {combo logic is introduced by en_ack which is generated by en, however they will not toggle at the same clock(same as torrent), there is no problem}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LOGC \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_pll0_clk_prog0} \
                                          -source_unit {u_mp_pcs_top_ln_1\.mp_pcs_original\.i_pwr_rate_ctrl\.pma_xcvr_pll_clk_en} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly1\.u_xcvr_clkrst\.u_clk_gating_cell_xcvr_pll_clk_fullrt\.genblk1\.u_data_sync_en_sync\.genblk1\.data_sync_flop\[0\]}] \
                                          -comment {combo logic is introduced by en_ack which is generated by en, however they will not toggle at the same clock(same as torrent), there is no problem}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LOGC \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_pll0_clk_prog0} \
                                          -source_unit {u_mp_pcs_top_ln_0\.mp_pcs_original\.i_pwr_rate_ctrl\.pma_xcvr_pll_clk_en} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly0\.u_xcvr_clkrst\.u_clock_div_prog_pll_clk\.genblk1\.u_reset_sync\.genblk1\.reset_sync_flop\[0\]}] \
                                          -comment {combo logic is introduced by en_ack which is generated by en, however they will not toggle at the same clock(same as torrent), there is no problem}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LOGC \
                                          -source_clock_domain pma_cmn_refclk0_int \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_pll0_clk_prog0} \
                                          -source_unit {u_mp_pcs_top_ln_1\.mp_pcs_original\.i_pwr_rate_ctrl\.pma_xcvr_pll_clk_en} \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly1\.u_xcvr_clkrst\.u_clock_div_prog_pll_clk\.genblk1\.u_reset_sync\.genblk1\.reset_sync_flop\[0\]}] \
                                          -comment {combo logic is introduced by en_ack which is generated by en, however they will not toggle at the same clock(same as torrent), there is no problem}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LOGC \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_pll0_clk_prog0} \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -source_unit {u_phy_clkrst\.u_phy_pcs_pipe4_clk_reset_n\.reset_sync_flop\[1\]} \
                                          -destination_unit {u_mp_pcs_top_ln_0\.mp_pcs_serdes\.i_pwr_rate_ctrl\.i_phy_data_sync_pma_xcvr_pll_clk_en_ack_low\.data_sync_flop\[0\]}] \
                                          -comment {When pipe reset asserted, logic related to dest unit also under reset; en_ack will not toggle when reset released, thus no problem}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CDC_PR_LOGC \
                                          -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_pll0_clk_prog0} \
                                          -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                          -source_unit {u_phy_clkrst\.u_phy_pcs_pipe4_clk_reset_n\.reset_sync_flop\[1\]} \
                                          -destination_unit {u_mp_pcs_top_ln_1\.mp_pcs_serdes\.i_pwr_rate_ctrl\.i_phy_data_sync_pma_xcvr_pll_clk_en_ack_low\.data_sync_flop\[0\]}] \
                                          -comment {When pipe reset asserted, logic related to dest unit also under reset; en_ack will not toggle when reset released, thus no problem}
# --- CNV_ST_GLCH --- #          
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_phy_apb_mstr_async_if.u_phy_data_sync_penable* \
                                          -tag CNV_ST_GLCH] \
          -comment {No glitch hazard with this path.  A separate glitch free path qualifies this synchronized signal.}


# --- CNV_ST_CONV --- #          
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_phy_apb_mstr_async_if.cdb_psel \
                                          -tag CNV_ST_CONV] \
          -comment {No convergence hazards with APB accesses wrt to various data synchronizers in the system.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_phy_apb_mstr_async_if.state* \
                                          -tag CNV_ST_CONV] \
          -comment {No convergence hazards with APB accesses wrt to various data synchronizers in the system.}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CNV_ST_CONV \
                                          -occurrence {u_mp_pcs_top_ln_0\.mp_pcs_original\.i_rpcs\.i_rctc_ctrl\.ctc_rd_en}] \
                                          -comment {path_128b_sel and te_rst_rx are controlled by one FSM and they will never toggle at the same cycle, thus no conv issue.}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CNV_ST_CONV \
                                          -occurrence {u_mp_pcs_top_ln_0.mp_pcs_original.i_rpcs.i_rctc_ctrl.g3_ctc_rd_en}] \
                                          -comment {path_128b_sel and te_rst_rx are controlled by one FSM and they will never toggle at the same cycle, thus no conv issue.}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CNV_ST_CONV \
                                          -occurrence {u_mp_pcs_top_ln_1\.mp_pcs_original\.i_rpcs\.i_rctc_ctrl\.ctc_rd_en}] \
                                          -comment {path_128b_sel and te_rst_rx are controlled by one FSM and they will never toggle at the same cycle, thus no conv issue.}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CNV_ST_CONV \
                                          -occurrence {u_mp_pcs_top_ln_1.mp_pcs_original.i_rpcs.i_rctc_ctrl.g3_ctc_rd_en}] \
                                          -comment {path_128b_sel and te_rst_rx are controlled by one FSM and they will never toggle at the same cycle, thus no conv issue.}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CNV_ST_CONV \
                                          -occurrence {u_mp_pcs_top_ln_0\.mp_pcs_original\.u_mp_tx_deemph\.int_tx_deemph_post_d}] \
                                          -comment {pma_pll_ready will never toggle at the same time with others; other signals are al;so exclusive to each other, thus no convegence issue}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CNV_ST_CONV \
                                          -occurrence {u_mp_pcs_top_ln_0.mp_pcs_original.u_mp_tx_deemph.int_tx_deemph_pre_d}] \
                                          -comment {pma_pll_ready will never toggle at the same time with others; other signals are al;so exclusive to each other, thus no convegence issue}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CNV_ST_CONV \
                                          -occurrence {u_mp_pcs_top_ln_0.mp_pcs_original.u_mp_tx_deemph.pma_tx_deemphasis_usb3_gen2\[11\:6\]}] \
                                          -comment {pma_pll_ready will never toggle at the same time with others; other signals are al;so exclusive to each other, thus no convegence issue}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CNV_ST_CONV \
                                          -occurrence {u_mp_pcs_top_ln_1\.mp_pcs_original\.u_mp_tx_deemph\.int_tx_deemph_post_d}] \
                                          -comment {pma_pll_ready will never toggle at the same time with others; other signals are al;so exclusive to each other, thus no convegence issue}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CNV_ST_CONV \
                                          -occurrence {u_mp_pcs_top_ln_1.mp_pcs_original.u_mp_tx_deemph.int_tx_deemph_pre_d}] \
                                          -comment {pma_pll_ready will never toggle at the same time with others; other signals are al;so exclusive to each other, thus no convegence issue}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag CNV_ST_CONV \
                                          -occurrence {u_mp_pcs_top_ln_1.mp_pcs_original.u_mp_tx_deemph.pma_tx_deemphasis_usb3_gen2\[11\:6\]}] \
                                          -comment {pma_pll_ready will never toggle at the same time with others; other signals are al;so exclusive to each other, thus no convegence issue}



###Kaibo add begin###

# --- RDC_RS_DFRS --- #          
# "Flop/port 'u_phy_port_master_lane_sel.a0_ready' and flop/port 'u_phy_pwrst_aggr_ln_1.state' driven by clock 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_sd_clk' have different reset signal 'phy_reset_n' . The destination flop is driven by 'no' reset source"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                                  -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                                  -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                                  -source_unit {u_phy_port_master_lane_sel\.a0_ready} \
                                                  -destination_unit {u_phy_pwrst_aggr_ln_1\.state} \
                                                  -occurrence {u_phy_port_master_lane_sel\.a0_ready\-u_phy_pwrst_aggr_ln_1\.state} \
                                                  -source_reset_domain phy_reset_n] \
                                                  -comment {Since when phy_reset_n is deassertd, the psm_clk doesn't aggregate. When psm_clk works, phy_reset_n has already been stable.}

# "Flop/port 'u_phy_port_master_lane_sel.a0_ready' and flop/port 'u_phy_pwrst_aggr_ln_0.state' driven by clock 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_sd_clk' have different reset signal 'phy_reset_n' . The destination flop is driven by 'no' reset source"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS \
                                                  -source_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                                  -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                                  -source_unit {u_phy_port_master_lane_sel\.a0_ready} \
                                                  -destination_unit {u_phy_pwrst_aggr_ln_0\.state} \
                                                  -occurrence {u_phy_port_master_lane_sel\.a0_ready\-u_phy_pwrst_aggr_ln_0\.state} \
                                                  -source_reset_domain phy_reset_n] \
                                                  -comment {Since when phy_reset_n is deassertd, the psm_clk doesn't aggregate. When psm_clk works, phy_reset_n has already been stable.}

# --- RST_NO_SYNC  --- #          
# "Reset signal 'phy_reset_n' driven by clock 'vclk_phy_reset_n' is not synchronized to the clock 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_sd_clk' of the destination unit 'u_phy_port_master_lane_sel.a0_ready'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                                  -source_clock_domain vclk_phy_reset_n \
                                                  -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                                  -destination_unit {u_phy_port_master_lane_sel\.a0_ready} \
                                                  -occurrence {phy_reset_n\-u_phy_port_master_lane_sel\.a0_ready} \
                                                  -reset_domain phy_reset_n] \
                                                  -comment {Since when phy_reset_n is deassertd, the psm_clk doesn't aggregate. When psm_clk works, phy_reset_n has already been stable.}

# "Reset signal 'phy_reset_n' driven by clock 'vclk_phy_reset_n' is not synchronized to the clock 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_sd_clk' of the destination unit 'u_phy_port_master_lane_sel.count'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                                  -source_clock_domain vclk_phy_reset_n \
                                                  -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                                  -destination_unit {u_phy_port_master_lane_sel\.count} \
                                                  -occurrence {phy_reset_n\-u_phy_port_master_lane_sel\.count} \
                                                  -reset_domain phy_reset_n] \
                                                  -comment {Since when phy_reset_n is deassertd, the psm_clk doesn't aggregate. When psm_clk works, phy_reset_n has already been stable.}

# "Reset signal 'phy_reset_n' driven by clock 'vclk_phy_reset_n' is not synchronized to the clock 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_sd_clk' of the destination unit 'u_phy_port_master_lane_sel.state'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                                  -source_clock_domain vclk_phy_reset_n \
                                                  -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                                  -destination_unit {u_phy_port_master_lane_sel\.state} \
                                                  -occurrence {phy_reset_n\-u_phy_port_master_lane_sel\.state} \
                                                  -reset_domain phy_reset_n] \
                                                  -comment {Since when phy_reset_n is deassertd, the psm_clk doesn't aggregate. When psm_clk works, phy_reset_n has already been stable.}

# "Reset signal 'phy_reset_n' driven by clock 'vclk_phy_reset_n' is not synchronized to the clock 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_sd_clk' of the destination unit 'u_phy_port_master_lane_sel.u_phy_data_sync_pipe_l00_reset_n.data_sync_flop'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                                  -source_clock_domain vclk_phy_reset_n \
                                                  -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                                  -destination_unit {u_phy_port_master_lane_sel\.u_phy_data_sync_pipe_l00_reset_n\.data_sync_flop} \
                                                  -occurrence {phy_reset_n\-u_phy_port_master_lane_sel\.u_phy_data_sync_pipe_l00_reset_n\.data_sync_flop} \
                                                  -reset_domain phy_reset_n] \
                                                  -comment {Since when phy_reset_n is deassertd, the psm_clk doesn't aggregate. When psm_clk works, phy_reset_n has already been stable.}

# "Reset signal 'phy_reset_n' driven by clock 'vclk_phy_reset_n' is not synchronized to the clock 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_sd_clk' of the destination unit 'u_phy_port_master_lane_sel.u_phy_data_sync_pma_xcvr_power_state_req_a0_ln_0.data_sync_flop'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                                  -source_clock_domain vclk_phy_reset_n \
                                                  -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                                  -destination_unit {u_phy_port_master_lane_sel\.u_phy_data_sync_pma_xcvr_power_state_req_a0_ln_0\.data_sync_flop} \
                                                  -occurrence {phy_reset_n\-u_phy_port_master_lane_sel\.u_phy_data_sync_pma_xcvr_power_state_req_a0_ln_0\.data_sync_flop} \
                                                  -reset_domain phy_reset_n] \
                                                  -comment {Since when phy_reset_n is deassertd, the psm_clk doesn't aggregate. When psm_clk works, phy_reset_n has already been stable.}

# "Reset signal 'phy_reset_n' driven by clock 'vclk_phy_reset_n' is not synchronized to the clock 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_sd_clk' of the destination unit 'u_phy_port_master_lane_sel.u_phy_data_sync_pipe_l01_reset_n.data_sync_flop'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                                  -source_clock_domain vclk_phy_reset_n \
                                                  -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                                  -destination_unit {u_phy_port_master_lane_sel\.u_phy_data_sync_pipe_l01_reset_n\.data_sync_flop} \
                                                  -occurrence {phy_reset_n\-u_phy_port_master_lane_sel\.u_phy_data_sync_pipe_l01_reset_n\.data_sync_flop} \
                                                  -reset_domain phy_reset_n] \
                                                  -comment {Since when phy_reset_n is deassertd, the psm_clk doesn't aggregate. When psm_clk works, phy_reset_n has already been stable.}

# "Reset signal 'phy_reset_n' driven by clock 'vclk_phy_reset_n' is not synchronized to the clock 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_sd_clk' of the destination unit 'u_phy_port_master_lane_sel.u_phy_data_sync_pma_xcvr_power_state_req_a0_ln_1.data_sync_flop'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_NO_SYNC \
                                                  -source_clock_domain vclk_phy_reset_n \
                                                  -destination_clock_domain {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_ana\.cmnda_sd_clk} \
                                                  -destination_unit {u_phy_port_master_lane_sel\.u_phy_data_sync_pma_xcvr_power_state_req_a0_ln_1\.data_sync_flop} \
                                                  -occurrence {phy_reset_n\-u_phy_port_master_lane_sel\.u_phy_data_sync_pma_xcvr_power_state_req_a0_ln_1\.data_sync_flop} \
                                                  -reset_domain phy_reset_n] \
                                                  -comment {Since when phy_reset_n is deassertd, the psm_clk doesn't aggregate. When psm_clk works, phy_reset_n has already been stable.}
###Kaibo add end###



# -------------------------------------------------------------------------------- #
#                            PMA waiver                                            #
# -------------------------------------------------------------------------------- #

