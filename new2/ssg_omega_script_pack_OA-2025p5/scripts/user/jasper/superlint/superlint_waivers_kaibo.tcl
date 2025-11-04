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

# "The signal 'lane_in_0', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { lane_in_0 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'lane_in_1', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { lane_in_1 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'lane_in_2', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { lane_in_2 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'lane_in_3', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { lane_in_3 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'lane_in_4', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { lane_in_4 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'lane_in_5', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { lane_in_5 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'lane_in_6', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { lane_in_6 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'lane_in_7', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { lane_in_7 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'lane_in_8', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { lane_in_8 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'lane_in_9', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { lane_in_9 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'lane_in_10', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { lane_in_10 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'lane_in_11', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { lane_in_11 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'lane_in_12', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { lane_in_12 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'lane_in_13', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { lane_in_13 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'lane_in_14', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { lane_in_14 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'lane_in_15', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { lane_in_15 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'port_out', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { port_out module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'int_lane_in_0', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { int_lane_in_0 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'int_lane_in_1', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { int_lane_in_1 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'int_lane_in_2', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { int_lane_in_2 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'int_lane_in_3', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { int_lane_in_3 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'int_lane_in_4', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { int_lane_in_4 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'int_lane_in_5', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { int_lane_in_5 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'int_lane_in_6', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { int_lane_in_6 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'int_lane_in_7', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { int_lane_in_7 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'int_lane_in_8', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { int_lane_in_8 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'int_lane_in_9', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { int_lane_in_9 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'int_lane_in_10', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { int_lane_in_10 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'int_lane_in_11', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { int_lane_in_11 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'int_lane_in_12', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { int_lane_in_12 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'int_lane_in_13', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { int_lane_in_13 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'int_lane_in_14', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { int_lane_in_14 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }

# "The signal 'int_lane_in_15', defined in module 'phy_port_lane_aggr_or', is a one pin bus in its instance 'u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0'"
check_superlint -waiver -add -module { phy_port_lane_aggr_or } -tag ARY_NR_SLRG -arg { int_lane_in_15 module phy_port_lane_aggr_or u_phy_port_lane_aggr_int_pma_xcvr_pllclk_en_ack_ln_0 } -comment { The parameter of BIT_WIDTH is always 1. }
