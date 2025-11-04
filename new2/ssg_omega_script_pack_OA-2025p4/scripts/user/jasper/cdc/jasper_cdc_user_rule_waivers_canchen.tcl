###Canchen add begin###
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp \
                                            -tag FLP_CK_CNST \
                                            -occurrence {u_pcs_iso_ctrl_ln_.\.u_data_sync_pipe7_rx_valid_override\.data_sync_flop}] \
          -comment {rx_clk only valid in ln1 or ln3}


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp \
                                            -tag FLP_CK_CNST \
                                            -occurrence {u_pcs_iso_ctrl_ln_.\.u_data_sync_pipe7_rx_valid_override_sel\.data_sync_flop}] \
          -comment {rx_clk only valid in ln1 or ln3}


check_cdc -waiver -add -filter [check_cdc -filter -add -regexp \
                                            -tag RST_RS_FSAR \
                                            -occurrence {u_pcs_iso_ctrl_ln_.\.u_data_sync_pipe7_rx_valid_override\.data_sync_flop}] \
          -comment {rx_rst only valid in ln1 or ln3}

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp \
                                            -tag RST_RS_FSAR \
                                            -occurrence {u_pcs_iso_ctrl_ln_.\.u_data_sync_pipe7_rx_valid_override_sel\.data_sync_flop}] \
          -comment {rx_rst only valid in ln1 or ln3}


# "Combo Logic on CDC path between source unit 'pipe7_l00_powerdown' driven by clock 'pipe7_l00_clk' and destination unit 'u_phy_state_chg_monitor_usb3_usb4_l00.i_mb_data_sync_pwr_rate.data_sync_inst[2].i_phy_data_sync_dest_dat.data_sync_flop' driven by clock 'uc_clk'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp \
                                                -tag CDC_PR_LOGC \
                                                -occurrence {u_phy_state_chg_monitor_usb3_usb4_l00\.i_mb_data_sync_pwr_rate\.data_sync_inst\[2\]\.i_phy_data_sync_dest_dat\.data_sync_flop\[0\]}] \
                                                -comment {comb logic is based on the value of the signal selected in the phy mode and does not change}

# "Combo Logic on CDC path between source unit 'pipe7_l00_rate' driven by clock 'pipe7_l00_clk' and destination unit 'u_phy_state_chg_monitor_usb3_usb4_l00.i_mb_data_sync_pwr_rate.data_sync_inst[4].i_phy_data_sync_dest_dat.data_sync_flop' driven by clock 'uc_clk'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp \
                                                -tag CDC_PR_LOGC \
                                                -occurrence {u_phy_state_chg_monitor_usb3_usb4_l00\.i_mb_data_sync_pwr_rate\.data_sync_inst\[4\]\.i_phy_data_sync_dest_dat\.data_sync_flop\[0\]}] \
                                                -comment {combo logic is a static mux }


# "Combo Logic on CDC path between source unit 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl_sm_v3_top.u_pll_ctrl_sm_v3.pllsm_current_state' driven by clock 'pma_cmn_refclk0_int' and destination unit 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_clk_gating_cell_cmn_pll0_lock_det_ref_clk.genblk1.u_data_sync_en_sync.genblk1.data_sync_flop' driven by clock 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_ref_clk'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp \
                                                  -tag CDC_PR_LOGC \
                                                  -occurrence {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_clk_gating_cell_cmn_pll0_lock_det_ref_clk\.genblk1\.u_data_sync_en_sync\.genblk1\.data_sync_flop\[0\]}] \
                                                  -comment {Other launch points into the OR/AND compbinatorial logic is static.  Thus no hazzard.}

# "Combo Logic on CDC path between source unit 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_clk_gating_cell_cmn_pll0_lock_det_fbdiv_clk.genblk1.u_data_sync_en_sync.genblk1.data_sync_flop' driven by clock 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_fb_divider_clk' and destination unit 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_data_sync_pll_lock_det_en_fbdiv_clk_ack.genblk1.data_sync_flop' driven by clock 'pma_cmn_refclk0_int'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp \
                                                -tag CDC_PR_LOGC \
                                                -occurrence {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_pll0_ctrl\.u_data_sync_pll_lock_det_en_fbdiv_clk_ack\.genblk1\.data_sync_flop\[0\]}] \
                                                -comment {False violations.  Caused by setting number of ACK stages to 0 in data sync.}



# "Combo Logic on CDC path between source unit 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_clk_gating_cell_cmn_pll0_lock_det_ref_clk.genblk1.u_data_sync_en_sync.genblk1.data_sync_flop' driven by clock 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_ana.cmnda_pll0_ref_clk' and destination unit 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_data_sync_pll_lock_det_en_ref_clk_ack.genblk1.data_sync_flop' driven by clock 'pma_cmn_refclk0_int'"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp \
                                                -tag CDC_PR_LOGC \
                                                -occurrence {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_pll0_ctrl\.u_data_sync_pll_lock_det_en_ref_clk_ack\.genblk1\.data_sync_flop\[0\]}] \
                                                -comment {False violations.  Caused by setting number of ACK stages to 0 in data sync.}

###Canchen add end###
