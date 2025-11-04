# -------------------------------------------------------------------------------- #
#                            PCS waiver                                            #
# -------------------------------------------------------------------------------- #
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
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -destination_unit u_p*_iso_ctrl_*.*phy_data_sync* \
                                          -tag CDC_PR_FOUT] \
          -comment {There are no relative relationships between each re-sync'd signal.  Thus no hazard with multiple re-synchronizers.}

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


# --- CDC_PR_LOGC --- #          




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




# -------------------------------------------------------------------------------- #
#                            PMA waiver                                            #
# -------------------------------------------------------------------------------- #
