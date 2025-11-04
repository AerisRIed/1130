##############################################################################################
##############################################################################################
##############################################################################################
# "The input port 'cdb_paddr[13:0]' declared in the module 'pma_ln_cdb_addr_decode' is unused"
check_superlint -waiver -add -module { pma_ln_cdb_addr_decode } -tag INP_NO_USED -arg { cdb_paddr[13:0] module pma_ln_cdb_addr_decode } -comment { only use high two 2bits to do address range selection }

# "The input port 'cdb_paddr[8:0]' declared in the module 'pma_cmn_cdb_addr_decode' is unused"
check_superlint -waiver -add -module { pma_cmn_cdb_addr_decode } -tag INP_NO_USED -arg { cdb_paddr[8:0] module pma_cmn_cdb_addr_decode } -comment { only use [15:14] & [12:9] to decode address }

# "The input port 'cdb_paddr[13]' declared in the module 'pma_cmn_cdb_addr_decode' is unused"
check_superlint -waiver -add -module { pma_cmn_cdb_addr_decode } -tag INP_NO_USED -arg { cdb_paddr[13] module pma_cmn_cdb_addr_decode } -comment { only use [15:14] & [12:9] to decode address }

# "The input port 'phy_scanin' declared in the module 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z' is unused"
check_superlint -waiver -add -module { cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -tag INP_NO_USED -arg { phy_scanin module cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -comment { This is the digital scan in signal which would be used at the synthesis stage. }

# "The input port 'apb_tgt_paddr[1:0]' declared in the module 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z' is unused"
check_superlint -waiver -add -module { cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -tag INP_NO_USED -arg { apb_tgt_paddr[1:0] module cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -comment { the lower 2 bit is used for 32 bits align. }


##############################################################################################
##############################################################################################
##############################################################################################
# "Module name 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z' differs from file name 'typec_timberwolf_phy_top.sv'"
check_superlint -waiver -add -module { cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -tag FIL_MS_DUNM -arg { Module cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z typec_timberwolf_phy_top.sv } -comment { the PHY top module name use MACRO. So the mismatch is expected. }


##############################################################################################
##############################################################################################
##############################################################################################
# "The output port 'phy_scanout' declared in the module 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z' is unused"
check_superlint -waiver -add -module { cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -tag OTP_NO_USED -arg { phy_scanout module cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -comment { This is the digital scan in signal which would be used at the synthesis stage. }


##############################################################################################
##############################################################################################
##############################################################################################
# "Inconsistent ordering of bits in range declarations in design-unit phy_spdup_cmn_rom -- should be all Descending ranges"
check_superlint -waiver -add -module { phy_spdup_cmn_rom } -tag ARY_MS_DRNG -arg { phy_spdup_cmn_rom Descending } -comment { this is register rom that the [0:31] is address. }

# "Inconsistent ordering of bits in range declarations in design-unit phy_spdup_ln_rom -- should be all Descending ranges"
check_superlint -waiver -add -module { phy_spdup_ln_rom } -tag ARY_MS_DRNG -arg { phy_spdup_ln_rom Descending } -comment { this is register rom that the [0:31] is address. }


##############################################################################################
##############################################################################################
##############################################################################################
# "The signal 'clk_sel', defined in module 'phy_clock_mux', is a one pin bus in its instance 'u_tap_complex.u_JTAG_MACRO.u_phy_scan_mux_JTAG_TCK_MUX'"
check_superlint -waiver -add -module { phy_clock_mux } -tag ARY_NR_SLRG -arg { clk_sel module phy_clock_mux u_tap_complex.u_JTAG_MACRO.u_phy_scan_mux_JTAG_TCK_MUX } -comment { The width is based on the parameter. So, when the parameter is 1, the data width is 1-bit width that leads to one pin bus issue. }

# "The signal 'source_dat', defined in module 'phy_mb_data_sync', is a one pin bus in its instance 'u_mp_pcs_top_ln_0.mp_pcs_serdes.i_cmn_if.i_mb_data_sync_pwr_change'"
check_superlint -waiver -add -module { phy_mb_data_sync } -tag ARY_NR_SLRG -arg { source_dat module phy_mb_data_sync u_mp_pcs_top_ln_0.mp_pcs_serdes.i_cmn_if.i_mb_data_sync_pwr_change } -comment { The width is based on the parameter. So, when the parameter is 1, the data width is 1-bit width that leads to one pin bus issue.}

# "The signal 'dest_dat', defined in module 'phy_mb_data_sync', is a one pin bus in its instance 'u_mp_pcs_top_ln_0.mp_pcs_serdes.i_cmn_if.i_mb_data_sync_pwr_change'"
check_superlint -waiver -add -module { phy_mb_data_sync } -tag ARY_NR_SLRG -arg { dest_dat module phy_mb_data_sync u_mp_pcs_top_ln_0.mp_pcs_serdes.i_cmn_if.i_mb_data_sync_pwr_change } -comment { The width is based on the parameter. So, when the parameter is 1, the data width is 1-bit width that leads to one pin bus issue. }

# "The signal 'dest_dat_stbl', defined in module 'phy_mb_data_sync', is a one pin bus in its instance 'u_mp_pcs_top_ln_0.mp_pcs_serdes.i_cmn_if.i_mb_data_sync_pwr_change'"
check_superlint -waiver -add -module { phy_mb_data_sync } -tag ARY_NR_SLRG -arg { dest_dat_stbl module phy_mb_data_sync u_mp_pcs_top_ln_0.mp_pcs_serdes.i_cmn_if.i_mb_data_sync_pwr_change } -comment { The width is based on the parameter. So, when the parameter is 1, the data width is 1-bit width that leads to one pin bus issue. }

# "The signal 'dest_dat_sync', defined in module 'phy_mb_data_sync', is a one pin bus in its instance 'u_mp_pcs_top_ln_0.mp_pcs_serdes.i_cmn_if.i_mb_data_sync_pwr_change'"
check_superlint -waiver -add -module { phy_mb_data_sync } -tag ARY_NR_SLRG -arg { dest_dat_sync module phy_mb_data_sync u_mp_pcs_top_ln_0.mp_pcs_serdes.i_cmn_if.i_mb_data_sync_pwr_change } -comment { The width is based on the parameter. So, when the parameter is 1, the data width is 1-bit width that leads to one pin bus issue. }

# "The signal 'muxin_a', defined in module 'phy_gen_mux2to1', is a one pin bus in its instance 'u_pcs_iso_ctrl_cmn.u_pcs_isomux_phy_reset_n'"
check_superlint -waiver -add -module { phy_gen_mux2to1 } -tag ARY_NR_SLRG -arg { muxin_a module phy_gen_mux2to1 u_pcs_iso_ctrl_cmn.u_pcs_isomux_phy_reset_n } -comment { The width is based on the parameter. So, when the parameter is 1, the data width is 1-bit width that leads to one pin bus issue. }

# "The signal 'muxin_b', defined in module 'phy_gen_mux2to1', is a one pin bus in its instance 'u_pcs_iso_ctrl_cmn.u_pcs_isomux_phy_reset_n'"
check_superlint -waiver -add -module { phy_gen_mux2to1 } -tag ARY_NR_SLRG -arg { muxin_b module phy_gen_mux2to1 u_pcs_iso_ctrl_cmn.u_pcs_isomux_phy_reset_n } -comment { The width is based on the parameter. So, when the parameter is 1, the data width is 1-bit width that leads to one pin bus issue. }

# "The signal 'muxout', defined in module 'phy_gen_mux2to1', is a one pin bus in its instance 'u_pcs_iso_ctrl_cmn.u_pcs_isomux_phy_reset_n'"
check_superlint -waiver -add -module { phy_gen_mux2to1 } -tag ARY_NR_SLRG -arg { muxout module phy_gen_mux2to1 u_pcs_iso_ctrl_cmn.u_pcs_isomux_phy_reset_n } -comment { The width is based on the parameter. So, when the parameter is 1, the data width is 1-bit width that leads to one pin bus issue. }


##############################################################################################
##############################################################################################
##############################################################################################
# "Output/inout 'phy_scanout' is not driven in the design-unit 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z'"
check_superlint -waiver -add -tag OTP_NR_UDRV -arg { phy_scanout cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -comment { digital scan output floating is expected. }


##############################################################################################
##############################################################################################
##############################################################################################
# "Blocking assignment to variable 'clock_div2' encountered in a sequential block"
check_superlint -waiver -add -module { phy_clock_div_sync } -tag SEQ_NR_BLKA -arg { clock_div2 } -comment { Blocking assignments are used here to prevent a race condition. }

# "Blocking assignment to variable 'clock_div2' encountered in a sequential block"
check_superlint -waiver -add -module { phy_clock_div_sync } -tag SEQ_NR_BLKA -arg { clock_div2 } -comment { Blocking assignments are used here to prevent a race condition. }


##############################################################################################
##############################################################################################
##############################################################################################
# "Port 's_apb_perror' (which is being used as an output) of design-unit 'uc' is being driven inside the design, but not connected in its instance 'u_uc_top'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { s_apb_perror uc u_uc_top } -comment { Output ffloating signal, expected. }

# "Port 'pipe_mb_tx_local_tx_coef_valid' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_3'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe_mb_tx_local_tx_coef_valid pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_3 } -comment { Output ffloating signal, expected. }

# "Port 'cdb_pwrite_uc_slv' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { cdb_pwrite_uc_slv pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'iso_pipe7_tx_data' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { iso_pipe7_tx_data pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'iso_pipe7_tx_elec_idle' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { iso_pipe7_tx_elec_idle pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'iso_pipe_mb_tx_local_preset_index' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { iso_pipe_mb_tx_local_preset_index pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'iso_pma_cmn_macro_suspend_ack' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { iso_pma_cmn_macro_suspend_ack pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'lm_cdb_ctrl_reset' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { lm_cdb_ctrl_reset pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'lm_cdb_pma_reset' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { lm_cdb_pma_reset pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'lm_cdb_reset' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { lm_cdb_reset pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'lm_cdb_rx_reset' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { lm_cdb_rx_reset pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'lm_cdb_tx_reset' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { lm_cdb_tx_reset pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'phy_interrupt' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { phy_interrupt pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'phy_state_chg_monitor_en' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { phy_state_chg_monitor_en pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pipe4_phy_status' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe4_phy_status pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pipe4_rx_data' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe4_rx_data pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pipe4_rx_data_k' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe4_rx_data_k pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pipe4_rx_data_valid' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe4_rx_data_valid pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. } 

# "Port 'pipe4_rx_elec_idle' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe4_rx_elec_idle pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pipe4_rx_start_block' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe4_rx_start_block pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pipe4_rx_status' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe4_rx_status pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. } 

# "Port 'pipe4_rx_sync_header' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe4_rx_sync_header pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pipe4_rx_valid' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe4_rx_valid pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pipe7_data_path_override' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe7_data_path_override pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'master_lane_clkoff' (which is being used as an output) of design-unit 'phy_port_master_lane_sel' is being driven inside the design, but not connected in its instance 'u_phy_port_master_lane_sel'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { master_lane_clkoff phy_port_master_lane_sel u_phy_port_master_lane_sel } -comment { Output ffloating signal, expected. }

# "Port 'master_lane_clkon' (which is being used as an output) of design-unit 'phy_port_master_lane_sel' is being driven inside the design, but not connected in its instance 'u_phy_port_master_lane_sel'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { master_lane_clkon phy_port_master_lane_sel u_phy_port_master_lane_sel } -comment { Output ffloating signal, expected. }

# "Port 'pma_cdb_psel1' (which is being used as an output) of design-unit 'pma_cdb_prdata_sync' is being driven inside the design, but not connected in its instance 'u_pma_cdb_prdata_sync_cmn'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pma_cdb_psel1 pma_cdb_prdata_sync u_pma_cdb_prdata_sync_cmn } -comment { Output ffloating signal, expected. }

# "Port 'pipe7_p2m_messagebus' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe7_p2m_messagebus pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { test }

# "Port 'cdb_paddr_uc_slv' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { cdb_paddr_uc_slv pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { test }

# "Port 'cdb_penable_uc_slv' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { cdb_penable_uc_slv pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { test }

# "Port 'cdb_psel_uc_slv' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { cdb_psel_uc_slv pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { test }

# "Port 'cdb_pwdata_uc_slv' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { cdb_pwdata_uc_slv pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { test }

# "Port 'pipe_mb_tx_local_fs_lf_valid' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe_mb_tx_local_fs_lf_valid pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { test }

# "Port 'pipe7_phy_status' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe7_phy_status pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { test }

# "Port 'pipe7_rx_data' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe7_rx_data pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pipe7_rx_standby_status' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe7_rx_standby_status pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pipe_mb_lane_mgn_sel' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe_mb_lane_mgn_sel pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pipe_mb_rx_eq_eval_complete' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe_mb_rx_eq_eval_complete pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pipe_mb_rx_eq_eval_sel' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe_mb_rx_eq_eval_sel pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pipe_mb_rx_eq_eval_status' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe_mb_rx_eq_eval_status pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pipe_mb_rx_link_eval_fb_dir_change' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe_mb_rx_link_eval_fb_dir_change pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pipe_mb_rx_link_eval_fom' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe_mb_rx_link_eval_fom pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 's_apb_perror' (which is being used as an output) of design-unit 'uc' is being driven inside the design, but not connected in its instance 'u_uc_ln_01'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { s_apb_perror uc u_uc_ln_01 } -comment { Output ffloating signal, expected. }

# "Port 'cdb_perr_in0' (which is being used as an output) of design-unit 'cdb_arbiter_v2' is being driven inside the design, but not connected in its instance 'u_cdb_arbiter_ln_01'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { cdb_perr_in0 cdb_arbiter_v2 u_cdb_arbiter_ln_01 } -comment { Output ffloating signal, expected. }

# "Port 'cdb_perr_in1' (which is being used as an output) of design-unit 'cdb_arbiter_v2' is being driven inside the design, but not connected in its instance 'u_cdb_arbiter_ln_01'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { cdb_perr_in1 cdb_arbiter_v2 u_cdb_arbiter_ln_01 } -comment { Output ffloating signal, expected. }

# "Port 'pipe_mb_tx_local_tx_coef_valid' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe_mb_tx_local_tx_coef_valid pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pipe_mb_tx_local_tx_preset_coef' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe_mb_tx_local_tx_preset_coef pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'uc_ecc_en' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { uc_ecc_en pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'uc_iram_base_addr' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { uc_iram_base_addr pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'uc_runstall' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { uc_runstall pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'uc_soft_reset_n' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { uc_soft_reset_n pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'uc_sram_init' (which is being used as an output) of design-unit 'pcs_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pcs_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { uc_sram_init pcs_iso_ctrl_ln u_pcs_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pma_rx_lfps_detect' (which is being used as an output) of design-unit 'pma_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pma_iso_ctrl_ln_3'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pma_rx_lfps_detect pma_iso_ctrl_ln u_pma_iso_ctrl_ln_3 } -comment { Output ffloating signal, expected. }

# "Port 'pma_rx_link_eval_fom' (which is being used as an output) of design-unit 'pma_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pma_iso_ctrl_ln_3'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pma_rx_link_eval_fom pma_iso_ctrl_ln u_pma_iso_ctrl_ln_3 } -comment { Output ffloating signal, expected. }

# "Port 'pma_rx_rd' (which is being used as an output) of design-unit 'pma_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pma_iso_ctrl_ln_3'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pma_rx_rd pma_iso_ctrl_ln u_pma_iso_ctrl_ln_3 } -comment { Output ffloating signal, expected. }

# "Port 'pipe_rx_mrgn_errcnt' (which is being used as an output) of design-unit 'pma_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pma_iso_ctrl_ln_3'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe_rx_mrgn_errcnt pma_iso_ctrl_ln u_pma_iso_ctrl_ln_3 } -comment { Output ffloating signal, expected. }

# "Port 'pipe_rx_mrgn_valid' (which is being used as an output) of design-unit 'pma_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pma_iso_ctrl_ln_3'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe_rx_mrgn_valid pma_iso_ctrl_ln u_pma_iso_ctrl_ln_3 } -comment { Output ffloating signal, expected. }

# "Port 'pma_tx_local_fs' (which is being used as an output) of design-unit 'pma_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pma_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pma_tx_local_fs pma_iso_ctrl_ln u_pma_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pma_tx_local_lf' (which is being used as an output) of design-unit 'pma_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pma_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pma_tx_local_lf pma_iso_ctrl_ln u_pma_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pma_tx_local_preset_coef' (which is being used as an output) of design-unit 'pma_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pma_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pma_tx_local_preset_coef pma_iso_ctrl_ln u_pma_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pma_tx_local_tx_coef_valid' (which is being used as an output) of design-unit 'pma_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pma_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pma_tx_local_tx_coef_valid pma_iso_ctrl_ln u_pma_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pma_tx_rcv_detect_done' (which is being used as an output) of design-unit 'pma_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pma_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pma_tx_rcv_detect_done pma_iso_ctrl_ln u_pma_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pma_tx_rcv_detected' (which is being used as an output) of design-unit 'pma_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pma_iso_ctrl_ln_1'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pma_tx_rcv_detected pma_iso_ctrl_ln u_pma_iso_ctrl_ln_1 } -comment { Output ffloating signal, expected. }

# "Port 'pma_tx_local_fs' (which is being used as an output) of design-unit 'pma_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pma_iso_ctrl_ln_2'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pma_tx_local_fs pma_iso_ctrl_ln u_pma_iso_ctrl_ln_2 } -comment { Output ffloating signal, expected. }

# "Port 'pma_tx_local_lf' (which is being used as an output) of design-unit 'pma_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pma_iso_ctrl_ln_2'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pma_tx_local_lf pma_iso_ctrl_ln u_pma_iso_ctrl_ln_2 } -comment { Output ffloating signal, expected. }

# "Port 'pma_tx_local_preset_coef' (which is being used as an output) of design-unit 'pma_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pma_iso_ctrl_ln_2'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pma_tx_local_preset_coef pma_iso_ctrl_ln u_pma_iso_ctrl_ln_2 } -comment { Output ffloating signal, expected. }

# "Port 'pma_tx_local_tx_coef_valid' (which is being used as an output) of design-unit 'pma_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pma_iso_ctrl_ln_2'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pma_tx_local_tx_coef_valid pma_iso_ctrl_ln u_pma_iso_ctrl_ln_2 } -comment { Output ffloating signal, expected. }

# "Port 'pma_tx_rcv_detect_done' (which is being used as an output) of design-unit 'pma_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pma_iso_ctrl_ln_2'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pma_tx_rcv_detect_done pma_iso_ctrl_ln u_pma_iso_ctrl_ln_2 } -comment { Output ffloating signal, expected. }

# "Port 'pma_tx_rcv_detected' (which is being used as an output) of design-unit 'pma_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pma_iso_ctrl_ln_2'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pma_tx_rcv_detected pma_iso_ctrl_ln u_pma_iso_ctrl_ln_2 } -comment { Output ffloating signal, expected. }

# "Port 'pipe4_pma_cmn_refclk_disable' (which is being used as an output) of design-unit 'mp_pcs_top' is being driven inside the design, but not connected in its instance 'u_mp_pcs_top_ln_0'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe4_pma_cmn_refclk_disable mp_pcs_top u_mp_pcs_top_ln_0 } -comment { Output ffloating signal, expected. }

# "Port 'pipe4_lane_off' (which is being used as an output) of design-unit 'mp_pcs_top' is being driven inside the design, but not connected in its instance 'u_mp_pcs_top_ln_0'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { pipe4_lane_off mp_pcs_top u_mp_pcs_top_ln_0 } -comment { Output ffloating signal, expected. }

# "Port 'iso_mode_en' (which is being used as an output) of design-unit 'pma_iso_ctrl_cmn' is being driven inside the design, but not connected in its instance 'u_pma_iso_ctrl_cmn'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { iso_mode_en pma_iso_ctrl_cmn u_pma_iso_ctrl_cmn } -comment { Output ffloating signal, expected. }

# "Port 's_apb_perror' (which is being used as an output) of design-unit 'uc' is being driven inside the design, but not connected in its instance 'u_uc_ln_23'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { s_apb_perror uc u_uc_ln_23 } -comment { Output floating. expected } 

# "Port 'cdb_perr_in0' (which is being used as an output) of design-unit 'cdb_arbiter_v2' is being driven inside the design, but not connected in its instance 'u_cdb_arbiter_ln_23'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { cdb_perr_in0 cdb_arbiter_v2 u_cdb_arbiter_ln_23 } -comment { Output floating. expected } 

# "Port 'cdb_perr_in1' (which is being used as an output) of design-unit 'cdb_arbiter_v2' is being driven inside the design, but not connected in its instance 'u_cdb_arbiter_ln_23'"
check_superlint -waiver -add -tag OTP_UC_INST -arg { cdb_perr_in1 cdb_arbiter_v2 u_cdb_arbiter_ln_23 } -comment { Output floating. expected }

# "Port 'pma_rx_signal_detect' (which is being used as an output) of design-unit 'pma_iso_ctrl_ln' is being driven inside the design, but not connected in its instance 'u_pma_iso_ctrl_ln_3'"
check_superlint -waiver -add  -tag OTP_UC_INST -arg { pma_rx_signal_detect pma_iso_ctrl_ln u_pma_iso_ctrl_ln_3 } -comment { output floaint. expected }

##############################################################################################
##############################################################################################
##############################################################################################
# "Wire 'iso_pma_tx_local_preset_index_ln_2[5:4]' declared in module 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z' does not drive any object, but is assigned at least once"
check_superlint -waiver -add -module { cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -tag WIR_NO_READ -arg { iso_pma_tx_local_preset_index_ln_2[5:4] module cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -comment { [5:4] is output floating, that is expected. } 

##############################################################################################
##############################################################################################
##############################################################################################

# "Wire 'ln_cdb_preset_n[1]' declared in module 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -tag WIR_NO_USED -arg { ln_cdb_preset_n[1] module cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -comment { Only use bit0/2, others are reserved. }

# "Wire 'ln_cdb_preset_n[15:3]' declared in module 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -tag WIR_NO_USED -arg { ln_cdb_preset_n[15:3] module cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -comment { Only use bit0/2, others are reserved. }

# "Wire 'uc_ecc_uncor_err_iram_ln_23' declared in module 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -tag WIR_NO_USED -arg { uc_ecc_uncor_err_iram_ln_23 module cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -comment { There is no dual port for iram. }

# "Wire 'uc_ecc_cor_err_iram_ln_23' declared in module 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -tag WIR_NO_USED -arg { uc_ecc_cor_err_iram_ln_23 module cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -comment { There is no dual port for iram. }

# "Wire 'uc_ecc_uncor_err_iram_ln_01' declared in module 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -tag WIR_NO_USED -arg { uc_ecc_uncor_err_iram_ln_01 module cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -comment { There is no dual port for iram. }

# "Wire 'uc_ecc_cor_err_iram_ln_01' declared in module 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -tag WIR_NO_USED -arg { uc_ecc_cor_err_iram_ln_01 module cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -comment { There is no dual port for iram. }

# "Wire 'uc_ecc_cor_err_iram_top' declared in module 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -tag WIR_NO_USED -arg { uc_ecc_cor_err_iram_top module cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -comment { There is no dual port for iram. }

# "Wire 'uc_ecc_uncor_err_iram_top' declared in module 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -tag WIR_NO_USED -arg { uc_ecc_uncor_err_iram_top module cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -comment { There is no dual port for iram. } 

# "Wire 'cdb_prdata_ln_0' declared in module 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -tag WIR_NO_USED -arg { cdb_prdata_ln_0 module cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -comment { these two signal only used in NO uC case. }

# "Wire 'cdb_pready_ln_0' declared in module 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -tag WIR_NO_USED -arg { cdb_pready_ln_0 module cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -comment { these two signal only used in NO uC case. }

# "Wire 'cdb_prdata_ln_1' declared in module 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -tag WIR_NO_USED -arg { cdb_prdata_ln_1 module cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -comment { these two signal only used in NO uC case. }

# "Wire 'cdb_pready_ln_1' declared in module 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -tag WIR_NO_USED -arg { cdb_pready_ln_1 module cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -comment { these two signal only used in NO uC case. }


# "Wire 'cdb_prdata_ln_2' declared in module 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -tag WIR_NO_USED -arg { cdb_prdata_ln_2 module cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -comment { these two signal only used in NO uC case. }

# "Wire 'cdb_pready_ln_2' declared in module 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -tag WIR_NO_USED -arg { cdb_pready_ln_2 module cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -comment { these two signal only used in NO uC case. }

# "Wire 'cdb_prdata_ln_3' declared in module 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -tag WIR_NO_USED -arg { cdb_prdata_ln_3 module cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -comment { these two signal only used in NO uC case. }

# "Wire 'cdb_pready_ln_3' declared in module 'cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -tag WIR_NO_USED -arg { cdb_pready_ln_3 module cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z } -comment { these two signal only used in NO uC case. }


##############################################################################################
##############################################################################################
##############################################################################################
# "Unequal length operands in equality operator encountered in design-unit/block phy_reconfig_ctlr. LHS operand is 4 bits, RHS operand is 32 bits"
check_superlint -waiver -add -module { phy_reconfig_ctlr } -tag OPR_NR_UCMP -arg { phy_reconfig_ctlr 4 32 } -comment { The lane number of phy_reconfig_ctrl comes from Macro Parameter. }

##############################################################################################
##############################################################################################
##############################################################################################
# "In design-unit 'phy_state_chg_monitor', clock 'pipe_phy_status_scan' driving one or more flip-flops, is not an input. One such flip-flop is 'pipe_phy_status_tgl'"
check_superlint -waiver -add -instance { u_phy_state_chg_monitor_usb3_usb4_l00 } -tag CLK_NO_INPT -arg { phy_state_chg_monitor pipe_phy_status_scan pipe_phy_status_tgl } -comment { phy monitor module uses pipe_phy_status as clock. }

##############################################################################################
##############################################################################################
##############################################################################################
# "Flip-flop 'u_phy_state_chg_monitor_usb3_usb4_l00.pipe_phy_status_tgl' is triggered at the negative edge of clock 'u_phy_state_chg_monitor_usb3_usb4_l00.pipe_phy_status_scan'"
check_superlint -waiver -add -instance { u_phy_state_chg_monitor_usb3_usb4_l00 } -tag FLP_IS_TNEF -arg { u_phy_state_chg_monitor_usb3_usb4_l00.pipe_phy_status_tgl u_phy_state_chg_monitor_usb3_usb4_l00.pipe_phy_status_scan } -comment { Phy monitor modules use pipe_phy_state negedge as clock }

# "Variable index/range selection of 'select' is potentially outside the defined range"
check_superlint -waiver -add -source_file {/projects/sd3101_t4gp_fe/users/suhang_chen/Timberwolf_USB4_T4GP/trunk/design/rtl/typec_phy_top/phy_spdup_cmn_rom.v} -start_line 197 -end_line 197 -start_column 32 -end_column 38 -module { phy_spdup_cmn_rom } -tag IDX_NR_ORNG -arg { select } -comment { Select is controlled by internal logic. } -persistency_data { AAAApnicLYxRCoMwEAXHC/QsiQY9jUiyqfghIraUevu+pGF5O3nMktWlOI0hZYuDrX4ELozMwcJLHPA45at+EDjFXrPwkffyTu/iI1tlkim01nPtd/N39UHcxJJeN9C1/PdDfz/ZFePN/AMyEBxR }

# "Variable index/range selection of 'select' is potentially outside the defined range"
check_superlint -waiver -add -source_file {/projects/sd3101_t4gp_fe/users/suhang_chen/Timberwolf_USB4_T4GP/trunk/design/rtl/typec_phy_top/phy_spdup_ln_rom.v} -start_line 173 -end_line 173 -start_column 32 -end_column 38 -module { phy_spdup_ln_rom } -tag IDX_NR_ORNG -arg { select } -comment { Select is controlled by internal logic. } -persistency_data { AAAApnicLYxRCoAgEAWnC3SWyiAvE5Fa9BERFVG372myvB0fszhb502w1o7BzJ1zwIEnsDFwioaaSnnUN1p2sdEM3PK1fKV39CNLopOJ9LmH1N/s3+RbcRFjGt1AkfPvUn9PrIrnov8APYMcZQ== }

