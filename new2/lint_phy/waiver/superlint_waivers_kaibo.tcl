##############################################################################################
##############################################################################################
##############################################################################################
# "Net 'u_typec_pma_mux.mux_ln_cdb_preset_n[0]' generated from combinational logic is driving set/reset of one or more flip-flops. One such flip-flop is 'u_pma_iso_ctrl_ln_0.phy_pma_override_reg[0]'"
check_superlint -waiver -add -instance { u_typec_pma_mux } -tag RST_IS_DCMB -arg { u_typec_pma_mux.mux_ln_cdb_preset_n[0] } -comment { typec_conn_dir is a static signal, no change during operation } 

# "Net 'u_typec_pma_mux.mux_ln_cdb_preset_n[2]' generated from combinational logic is driving set/reset of one or more flip-flops. One such flip-flop is 'u_pma_iso_ctrl_ln_2.phy_pma_override_reg[0]'"
check_superlint -waiver -add -instance { u_typec_pma_mux } -tag RST_IS_DCMB -arg { u_typec_pma_mux.mux_ln_cdb_preset_n[2] } -comment { typec_conn_dir is a static signal, no change during operation }

# "Port 'xcvr_link_id_ln_0' (which is being used as an output) of design-unit 'typec_pma_mux' is being driven inside the design, but not connected in its instance 'u_typec_pma_mux'"
check_superlint -waiver -add -instance {  } -tag OTP_UC_INST -arg { xcvr_link_id_ln_0 typec_pma_mux u_typec_pma_mux } -comment { no use for TImberwolf PMA } 

# "Port 'xcvr_link_id_ln_1' (which is being used as an output) of design-unit 'typec_pma_mux' is being driven inside the design, but not connected in its instance 'u_typec_pma_mux'"
check_superlint -waiver -add -instance {  } -tag OTP_UC_INST -arg { xcvr_link_id_ln_1 typec_pma_mux u_typec_pma_mux } -comment { no use for TImberwolf PMA } 

# "Port 'xcvr_link_id_ln_2' (which is being used as an output) of design-unit 'typec_pma_mux' is being driven inside the design, but not connected in its instance 'u_typec_pma_mux'"
check_superlint -waiver -add -instance {  } -tag OTP_UC_INST -arg { xcvr_link_id_ln_2 typec_pma_mux u_typec_pma_mux } -comment { no use for TImberwolf PMA } 

# "Port 'xcvr_link_id_ln_3' (which is being used as an output) of design-unit 'typec_pma_mux' is being driven inside the design, but not connected in its instance 'u_typec_pma_mux'"
check_superlint -waiver -add -instance {  } -tag OTP_UC_INST -arg { xcvr_link_id_ln_3 typec_pma_mux u_typec_pma_mux } -comment { no use for TImberwolf PMA } 

# "Port 'mux_ln_cdb_preset_n[1]' (which is being used as an output) of design-unit 'typec_pma_mux' is being driven inside the design, but not connected in its instance 'u_typec_pma_mux'"
check_superlint -waiver -add -instance {  } -tag OTP_UC_INST -arg { mux_ln_cdb_preset_n[1] typec_pma_mux u_typec_pma_mux } -comment { only bit0 and bit2 are valid. } 

# "Port 'mux_ln_cdb_preset_n[15:3]' (which is being used as an output) of design-unit 'typec_pma_mux' is being driven inside the design, but not connected in its instance 'u_typec_pma_mux'"
check_superlint -waiver -add -instance {  } -tag OTP_UC_INST -arg { mux_ln_cdb_preset_n[15:3] typec_pma_mux u_typec_pma_mux } -comment { only bit0 and bit2 are valid. } 

