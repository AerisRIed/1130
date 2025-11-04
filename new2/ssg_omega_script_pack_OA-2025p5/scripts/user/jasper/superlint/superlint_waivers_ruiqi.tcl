
#no used signal as expected


check_superlint -waiver -add  -module { cdnsdru_ree_peaking_amp_gain_v6_cdb_regs } -tag OTP_NO_USED -arg { ree_peak_stat_reg module cdnsdru_ree_peaking_amp_gain_v6_cdb_regs } -comment { not used signal as expected } 


check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5 } -tag OTP_UC_INST -arg { int_accumulator_out_min cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5.u_ree_gain_int_v3 } -comment { not used as expected } 


check_superlint -waiver -add -module { rx_equalizer_engine_cdb_regs } -tag INP_NO_USED -arg { cdb_pwdata[31:16] module rx_equalizer_engine_cdb_regs } -comment { no used part as expected }


check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl } -tag OTP_UC_INST -arg { rx_cya rx_diag_ovrd u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -comment { no used signal as expected } 


check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl } -tag OTP_UC_INST -arg { atbsel_onehot[63:52] cdnsdru_atb_decode_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_atb_decode } -comment { no used signal as expected } 


check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_sampler_dac_ctrl } -tag OTP_UC_INST -arg { rx_samp_dac_ctrl_reg[15:8] sampler_dac_ctrl_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_sampler_dac_ctrl.u_sampler_dac_ctrl_cdb_regs } -comment { no used signal as expected }

check_superlint -waiver -add -module { cdnsdru_ree_attenuation_v3_cdb_regs } -tag ASG_MS_RPAD -arg { cdnsdru_ree_attenuation_v3_cdb_regs cdb_prdata_int unsigned 33 \{27'b0000_0000_0000,rxda_dfe_attenuation_bin\} unsigned 32 1 } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.u_min_pulse_low_filter } -tag OTP_UC_INST -arg { counter_value rx_lfps_det_filter_v0_gen_timer_with_output u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.u_min_pulse_low_filter.u_timer } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.u_min_pulse_high_filter } -tag OTP_UC_INST -arg { counter_value rx_lfps_det_filter_v0_gen_timer_with_output u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.u_min_pulse_high_filter.u_timer } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.u_min_pulse_low_filter } -tag OTP_UC_INST -arg { counter_value rx_lfps_det_filter_v0_gen_timer_with_output u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.u_min_pulse_low_filter.u_timer } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.u_min_pulse_high_filter } -tag OTP_UC_INST -arg { counter_value rx_lfps_det_filter_v0_gen_timer_with_output u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.u_min_pulse_high_filter.u_timer } -comment { no used signal as expected } 

check_superlint -waiver -add -source_file {/projects/sd3101_t4gp_fe/users/ruiqi_huang/Timberwolf_USB4_T4GP/trunk/design/reuse/pma/rtl/pma_rx_ctrl/rx_ctrl_bist_top.v} -start_line 68 -end_line 68 -start_column 16 -end_column 32 -module { rx_ctrl_bist_top } -tag WIR_NO_READ -arg { rx_bist_ctrl_reg[3:1] module rx_ctrl_bist_top } -comment { no used signal as expected }  

check_superlint -waiver -add -source_file {/projects/sd3101_t4gp_fe/users/ruiqi_huang/Timberwolf_USB4_T4GP/trunk/design/reuse/pma/rtl/pma_rx_ctrl/rx_ctrl_bist_top.v} -start_line 68 -end_line 68 -start_column 16 -end_column 32 -module { rx_ctrl_bist_top } -tag WIR_NO_READ -arg { rx_bist_ctrl_reg[7:5] module rx_ctrl_bist_top } -comment { no used signal as expected }  

check_superlint -waiver -add -source_file {/projects/sd3101_t4gp_fe/users/ruiqi_huang/Timberwolf_USB4_T4GP/trunk/design/reuse/pma/rtl/pma_rx_ctrl/rx_ctrl_bist_top.v} -start_line 68 -end_line 68 -start_column 16 -end_column 32 -module { rx_ctrl_bist_top } -tag WIR_NO_READ -arg { rx_bist_ctrl_reg[15:12] module rx_ctrl_bist_top } -comment { no used signal as expected }  

check_superlint -waiver -add -source_file {/projects/sd3101_t4gp_fe/users/ruiqi_huang/Timberwolf_USB4_T4GP/trunk/design/reuse/pma/rtl/pma_rx_ctrl/rx_ctrl.v} -start_line 440 -end_line 440 -start_column 16 -end_column 29 -module { rx_ctrl } -tag WIR_NO_READ -arg { atbsel_onehot[63:52] module rx_ctrl } -comment { no used signal as expected }  

check_superlint -waiver -add -source_file {/projects/sd3101_t4gp_fe/users/ruiqi_huang/Timberwolf_USB4_T4GP/trunk/design/reuse/pma/rtl/pma_rx_ctrl/rx_ctrl.v} -start_line 545 -end_line 545 -start_column 16 -end_column 50 -module { rx_ctrl } -tag WIR_NO_READ -arg { rxdata_offset_cal_and_ree_sum_7bit[7] module rx_ctrl } -comment { no used signal as expected } 

check_superlint -waiver -add -source_file {/projects/sd3101_t4gp_fe/users/ruiqi_huang/Timberwolf_USB4_T4GP/trunk/design/reuse/pma/rtl/pma_rx_ctrl/rx_ctrl.v} -start_line 550 -end_line 550 -start_column 16 -end_column 33 -module { rx_ctrl } -tag WIR_NO_READ -arg { rxdata_offset_cal[0] module rx_ctrl } -comment { no used signal as expected }  

check_superlint -waiver -add -source_file {/projects/sd3101_t4gp_fe/users/ruiqi_huang/Timberwolf_USB4_T4GP/trunk/design/reuse/pma/rtl/pma_rx_ctrl/rx_ctrl.v} -start_line 443 -end_line 443 -start_column 16 -end_column 22 -module { rx_ctrl } -tag WIR_NO_READ -arg { rx_cya module rx_ctrl } -comment { reserved use } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5 } -tag OTP_UC_INST -arg { int_accumulator_out_min cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5.u_ree_gain_int_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5 } -tag OTP_UC_INST -arg { int_accumulator_out_min cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5.u_ree_gain_int_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_sampler_dac_ctrl } -tag OTP_UC_INST -arg { rx_samp_dac_ctrl_reg[15:8] sampler_dac_ctrl_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_sampler_dac_ctrl.u_sampler_dac_ctrl_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_sampler_dac_ctrl } -tag OTP_UC_INST -arg { rx_samp_dac_ctrl_reg[15:8] sampler_dac_ctrl_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_sampler_dac_ctrl.u_sampler_dac_ctrl_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl } -tag OTP_UC_INST -arg { atbsel_onehot[63:52] cdnsdru_atb_decode_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_atb_decode } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl } -tag OTP_UC_INST -arg { atbsel_onehot[63:52] cdnsdru_atb_decode_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_atb_decode } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl } -tag OTP_UC_INST -arg { rx_cya rx_diag_ovrd u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl } -tag OTP_UC_INST -arg { rx_cya rx_diag_ovrd u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4 } -tag OTP_UC_INST -arg { int_accumulator_out_min cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4.u_ree_gain_int_v3 } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4 } -tag OTP_UC_INST -arg { int_accumulator_out_min cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4.u_ree_gain_int_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4 } -tag OTP_UC_INST -arg { int_accumulator_out_max cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4.u_ree_gain_int_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4 } -tag OTP_UC_INST -arg { int_accumulator_out_max cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4.u_ree_gain_int_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6 } -tag OTP_UC_INST -arg { int_accumulator_out_min cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6.u_ree_gain_int_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6 } -tag OTP_UC_INST -arg { int_accumulator_out_min cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6.u_ree_gain_int_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6 } -tag OTP_UC_INST -arg { int_accumulator_out_min cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6.u_ree_gain_int_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6 } -tag OTP_UC_INST -arg { int_accumulator_out_min cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6.u_ree_gain_int_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6 } -tag OTP_UC_INST -arg { int_accumulator_out_max cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6.u_ree_gain_int_v3 } -comment { no used signal as expected } 





check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { clk_gate_en cdnsdru_ree_gen_ctrl_sm_v4_top u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_usb } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { clk_gate_en cdnsdru_ree_gen_ctrl_sm_v4_top u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_usb } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_smgm_ctrl1_reg[15:12] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_smgm_ctrl1_reg[15:12] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_tap1_clip_reg[7:5] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_tap1_clip_reg[15:11] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_tap1_clip_reg[7:5] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_tap1_clip_reg[15:11] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_tap2ton_clip_reg[7:5] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_tap2ton_clip_reg[15:11] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  


check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_tap2ton_clip_reg[7:5] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_tap2ton_clip_reg[15:11] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_txeqeval_ctrl_reg[15:2] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  


check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_txeqeval_ctrl_reg[15:2] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  


check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_pcieg3_tx_eq_ctrl_sm } -tag OTP_UC_INST -arg { ree_pg3sm_ctrl_reg_value cdnsdru_ree_pcieg3_ctrl_sm_v2_cdb_regs_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_pcieg3_tx_eq_ctrl_sm.u_ree_pcieg3_ctrl_sm_v2_cdb_regs } -comment { no used signal as expected }  


check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_pcieg3_tx_eq_ctrl_sm } -tag OTP_UC_INST -arg { ree_pg3sm_ctrl_reg_value cdnsdru_ree_pcieg3_ctrl_sm_v2_cdb_regs_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_pcieg3_tx_eq_ctrl_sm.u_ree_pcieg3_ctrl_sm_v2_cdb_regs } -comment { no used signal as expected } 


check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_fifo_diag_reg[11:6] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected } 


check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_fifo_diag_reg[15:14] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  


check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_fifo_diag_reg[11:6] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  


check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_fifo_diag_reg[15:14] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  


check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { clk_gate_en cdnsdru_ree_gen_ctrl_sm_v4_top u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_1 } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { clk_gate_en cdnsdru_ree_gen_ctrl_sm_v4_top u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_1 } -comment { no used signal as expected } 


check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { clk_gate_en cdnsdru_ree_gen_ctrl_sm_v4_top u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_2 } -comment { no used signal as expected }  


check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { clk_gate_en cdnsdru_ree_gen_ctrl_sm_v4_top u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_2 } -comment { no used signal as expected } 


check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { clk_gate_en cdnsdru_ree_gen_ctrl_sm_v4_top u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_periodic } -comment { no used signal as expected }  


check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { clk_gate_en cdnsdru_ree_gen_ctrl_sm_v4_top u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_periodic } -comment { no used signal as expected } 
 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[11:9] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs.u_cdb_slave_ree_diag } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[11:9] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs.u_cdb_slave_ree_diag } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl } -tag OTP_UC_INST -arg { atben_to_ana cdnsdru_atb_decode_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_atb_decode } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl } -tag OTP_UC_INST -arg { atben_to_ana cdnsdru_atb_decode_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_atb_decode } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -tag OTP_UC_INST -arg { cdb_pread_sel[19] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -tag OTP_UC_INST -arg { cdb_pread_sel[23] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -tag OTP_UC_INST -arg { cdb_pread_sel[29:26] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs.u_cdb_slave } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -tag OTP_UC_INST -arg { cdb_pread_sel[19] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -tag OTP_UC_INST -arg { cdb_pread_sel[23] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs.u_cdb_slave } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -tag OTP_UC_INST -arg { cdb_pread_sel[29:26] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[9] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[11] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[19:13] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs.u_cdb_slave } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[23] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs.u_cdb_slave } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[29:25] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs.u_cdb_slave } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[9] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[11] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs.u_cdb_slave } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[19:13] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs.u_cdb_slave } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[23] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[29:25] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_acya_reg[15:8] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_dfe_amp_tune_2_reg[4:0] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_dfe_amp_tune_2_reg[6] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_dfe_amp_tune_2_reg[11] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_dfe_amp_tune_3_reg[15:4] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_dfe_amp_tune_4_reg rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_dfe_amp_tune_reg[3] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_dfe_ctrl_reg[15:13] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_lfeq_tune_reg[15:8] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_lpbk_ctrl_reg[15:6] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_pi_rate_reg[3:2] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_pi_rate_reg[7:6] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_pi_rate_reg[11:10] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_pi_rate_reg[15:14] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_pi_tune_reg[3] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_pi_tune_reg[15:10] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_ree_dac_ctrl_reg[1:0] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_ree_dac_ctrl_reg[15:3] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_samp_ctrl_reg[1] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_samp_ctrl_reg[15:9] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_sigdet_tune_reg[3] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_sigdet_tune_reg[11:8] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_sigdet_tune_reg[15] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_xcvr_rate_sel_reg[3] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_xcvr_rate_sel_reg[7:6] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_xcvr_rate_sel_reg[15:10] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_acya_reg[15:8] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_dfe_amp_tune_2_reg[4:0] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_dfe_amp_tune_2_reg[6] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_dfe_amp_tune_2_reg[11] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_dfe_amp_tune_3_reg[15:4] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_dfe_amp_tune_4_reg rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_dfe_amp_tune_reg[3] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_dfe_ctrl_reg[15:13] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_lfeq_tune_reg[15:8] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_lpbk_ctrl_reg[15:6] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_pi_rate_reg[3:2] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_pi_rate_reg[7:6] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_pi_rate_reg[11:10] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_pi_rate_reg[15:14] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_pi_tune_reg[3] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_pi_tune_reg[15:10] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_ree_dac_ctrl_reg[1:0] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_ree_dac_ctrl_reg[15:3] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_samp_ctrl_reg[1] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_samp_ctrl_reg[15:9] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_sigdet_tune_reg[3] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_sigdet_tune_reg[11:8] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_sigdet_tune_reg[15] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_xcvr_rate_sel_reg[3] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_xcvr_rate_sel_reg[7:6] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd } -tag OTP_UC_INST -arg { rx_diag_xcvr_rate_sel_reg[15:10] rx_diag_ovrd_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_diag_ovrd.u_rx_diag_ovrd_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper } -tag OTP_UC_INST -arg { rx_slc_ctrl[14:2] rx_sampler_latch_cal_wrapper_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper } -tag OTP_UC_INST -arg { rx_slc_ctrl[14:2] rx_sampler_latch_cal_wrapper_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal } -tag OTP_UC_INST -arg { rx_sampler_latch_cal_clk_gate_en cdnsdru_rx_sampler_latch_cal_ctrl_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal.u_rx_sampler_latch_cal_ctrl } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal } -tag OTP_UC_INST -arg { rx_sampler_latch_cal_clk_gate_en cdnsdru_rx_sampler_latch_cal_ctrl_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal.u_rx_sampler_latch_cal_ctrl } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_qcc_icfg } -tag OTP_UC_INST -arg { da_ana_cal_clk cdnsdru_bin_cal_apb_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_qcc_icfg.u_bin_cal_apb } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_qcc_icfg } -tag OTP_UC_INST -arg { da_ana_cal_clk cdnsdru_bin_cal_apb_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_qcc_icfg.u_bin_cal_apb } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[1] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[3] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[5] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs.u_cdb_slave } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[7] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[9] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs.u_cdb_slave } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[11] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs.u_cdb_slave } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[1] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[3] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs.u_cdb_slave } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[5] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[7] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[9] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[11] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_sampler_latch_cal_wrapper.u_rx_sampler_latch_cal_wrapper_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_usb } -tag OTP_UC_INST -arg { ree_gcsm_ctrl_reg_value[15:4] cdnsdru_ree_gen_ctrl_sm_v4_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_usb.u_ree_gen_ctrl_sm_v4_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_1 } -tag OTP_UC_INST -arg { ree_gcsm_ctrl_reg_value[15:4] cdnsdru_ree_gen_ctrl_sm_v4_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_1.u_ree_gen_ctrl_sm_v4_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_2 } -tag OTP_UC_INST -arg { ree_gcsm_ctrl_reg_value[15:4] cdnsdru_ree_gen_ctrl_sm_v4_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_2.u_ree_gen_ctrl_sm_v4_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_periodic } -tag OTP_UC_INST -arg { ree_gcsm_ctrl_reg_value[15:4] cdnsdru_ree_gen_ctrl_sm_v4_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_periodic.u_ree_gen_ctrl_sm_v4_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_usb } -tag OTP_UC_INST -arg { ree_gcsm_ctrl_reg_value[15:4] cdnsdru_ree_gen_ctrl_sm_v4_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_usb.u_ree_gen_ctrl_sm_v4_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_1 } -tag OTP_UC_INST -arg { ree_gcsm_ctrl_reg_value[15:4] cdnsdru_ree_gen_ctrl_sm_v4_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_1.u_ree_gen_ctrl_sm_v4_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_2 } -tag OTP_UC_INST -arg { ree_gcsm_ctrl_reg_value[15:4] cdnsdru_ree_gen_ctrl_sm_v4_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_2.u_ree_gen_ctrl_sm_v4_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_periodic } -tag OTP_UC_INST -arg { ree_gcsm_ctrl_reg_value[15:4] cdnsdru_ree_gen_ctrl_sm_v4_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_periodic.u_ree_gen_ctrl_sm_v4_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3 } -tag OTP_UC_INST -arg { accumulator_max cdnsdru_accumulator_dyn_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3.u_int_accumulator } -comment { reuse }

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3 } -tag OTP_UC_INST -arg { accumulator_max cdnsdru_accumulator_dyn_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3.u_int_accumulator } -comment { reuse } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation } -tag OTP_UC_INST -arg { rxda_dfe_attenuation_therm[30:10] cdnsdru_ree_attenuation_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation } -tag OTP_UC_INST -arg { rxda_dfe_attenuation_therm[30:10] cdnsdru_ree_attenuation_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[5] cdnsdru_cdb_slave_var_w_wait_v1 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[5] cdnsdru_cdb_slave_var_w_wait_v1 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[5] cdnsdru_cdb_slave_var_w_wait_v1 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[5] cdnsdru_cdb_slave_var_w_wait_v1 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { cdb_psel_tap_4_coef rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { reserved } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { cdb_psel_tap_4_coef rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { reserved }

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { cdb_psel_tap_5_coef rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { reserved } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { cdb_psel_tap_5_coef rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { reserved } 


check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5 } -tag OTP_UC_INST -arg { accumulator_min cdnsdru_accumulator_dyn_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5.u_tgt_adj_accumulator } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5 } -tag OTP_UC_INST -arg { accumulator_min cdnsdru_accumulator_dyn_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5.u_tgt_adj_accumulator } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_e_data_d1[13:0] cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used }

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_e_data_d1[17:16] cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used }

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_e_data_d1[29:20] cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used }

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_e_data_d2 cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_i_data_d1[13:0] cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_i_data_d1[17:16] cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_i_data_d1[29:20] cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used }

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_i_data_d2 cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_q_data_d0[31] cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used }

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_q_data_d1[14:0] cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_q_data_d1[18:16] cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used }

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_q_data_d1[30:20] cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used }

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_q_data_d2 cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_e_data_d1[13:0] cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_e_data_d1[17:16] cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_e_data_d1[29:20] cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used }

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_e_data_d2 cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used }

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_i_data_d1[13:0] cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_i_data_d1[17:16] cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used }

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_i_data_d1[29:20] cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_i_data_d2 cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_q_data_d0[31] cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_q_data_d1[14:0] cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_q_data_d1[18:16] cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used }

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_q_data_d1[30:20] cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { dfe_q_data_d2 cdnsdru_ree_data_sampler_v2 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_data_sampler } -comment { no used }

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_addr_cfg_reg[7:3] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_addr_cfg_reg[15:11] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_addr_cfg_reg[7:3] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_addr_cfg_reg[15:11] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { adder_out[7:5] cdnsdru_ree_add_mult_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_add_mult_tap_234 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { adder_out[7:5] cdnsdru_ree_add_mult_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_add_mult_tap_234 } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { adder_out[7:5] cdnsdru_ree_add_mult_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_add_mult_tap_1 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { adder_out[7:5] cdnsdru_ree_add_mult_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_add_mult_tap_1 } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_cdrlf_config.u_cdrlf_config_cdb_regs } -tag OTP_UC_INST -arg { cdb_pread_sel[7:6] cdnsdru_cdb_slave_var_w_wait_v1 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_cdrlf_config.u_cdrlf_config_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_cdrlf_config.u_cdrlf_config_cdb_regs } -tag OTP_UC_INST -arg { cdb_pread_sel[7:6] cdnsdru_cdb_slave_var_w_wait_v1 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_cdrlf_config.u_cdrlf_config_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation } -tag OTP_UC_INST -arg { ree_atten_thr_reg[7:5] cdnsdru_ree_attenuation_v3_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation } -tag OTP_UC_INST -arg { ree_atten_thr_reg[15:13] cdnsdru_ree_attenuation_v3_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation } -tag OTP_UC_INST -arg { ree_atten_thr_reg[7:5] cdnsdru_ree_attenuation_v3_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation } -tag OTP_UC_INST -arg { ree_atten_thr_reg[15:13] cdnsdru_ree_attenuation_v3_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation } -tag OTP_UC_INST -arg { ree_atten_ctrl_reg[15:5] cdnsdru_ree_attenuation_v3_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation } -tag OTP_UC_INST -arg { ree_atten_ctrl_reg[23:21] cdnsdru_ree_attenuation_v3_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation } -tag OTP_UC_INST -arg { ree_atten_ctrl_reg[31:25] cdnsdru_ree_attenuation_v3_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation } -tag OTP_UC_INST -arg { ree_atten_ctrl_reg[15:5] cdnsdru_ree_attenuation_v3_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation } -tag OTP_UC_INST -arg { ree_atten_ctrl_reg[23:21] cdnsdru_ree_attenuation_v3_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation } -tag OTP_UC_INST -arg { ree_atten_ctrl_reg[31:25] cdnsdru_ree_attenuation_v3_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3 } -tag OTP_UC_INST -arg { accumulator_value[5] cdnsdru_accumulator_dyn_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3.u_int_accumulator } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3 } -tag OTP_UC_INST -arg { accumulator_value[5] cdnsdru_accumulator_dyn_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3.u_int_accumulator } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3 } -tag OTP_UC_INST -arg { accumulator_min cdnsdru_accumulator_dyn_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3.u_int_accumulator } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3 } -tag OTP_UC_INST -arg { accumulator_min cdnsdru_accumulator_dyn_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3.u_int_accumulator } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[2] cdnsdru_cdb_slave_var_w_wait_v1 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3_cdb_regs.u_cdb_slave } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[2] cdnsdru_cdb_slave_var_w_wait_v1 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_attenuation.u_ree_attenuation_v3_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_eye_surf_ctrl_top.u_eye_surf_ctrl_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[10:3] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_eye_surf_ctrl_top.u_eye_surf_ctrl_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_eye_surf_ctrl_top.u_eye_surf_ctrl_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[10:3] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_eye_surf_ctrl_top.u_eye_surf_ctrl_cdb_regs.u_cdb_slave } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_bist_core_apb } -tag OTP_UC_INST -arg { rx_bist_ctrl_reg[3:1] cdnsdru_rx_bist_core_apb_cdb_regs_v3_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_bist_core_apb.u_rx_bist_core_apb_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_bist_core_apb } -tag OTP_UC_INST -arg { rx_bist_ctrl_reg[7:5] cdnsdru_rx_bist_core_apb_cdb_regs_v3_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_bist_core_apb.u_rx_bist_core_apb_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_bist_core_apb } -tag OTP_UC_INST -arg { rx_bist_ctrl_reg[15:12] cdnsdru_rx_bist_core_apb_cdb_regs_v3_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_bist_core_apb.u_rx_bist_core_apb_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_bist_core_apb } -tag OTP_UC_INST -arg { rx_bist_ctrl_reg[3:1] cdnsdru_rx_bist_core_apb_cdb_regs_v3_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_bist_core_apb.u_rx_bist_core_apb_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_bist_core_apb } -tag OTP_UC_INST -arg { rx_bist_ctrl_reg[7:5] cdnsdru_rx_bist_core_apb_cdb_regs_v3_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_bist_core_apb.u_rx_bist_core_apb_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_bist_core_apb } -tag OTP_UC_INST -arg { rx_bist_ctrl_reg[15:12] cdnsdru_rx_bist_core_apb_cdb_regs_v3_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_bist_core_apb.u_rx_bist_core_apb_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_covrd0_reg[7:6] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_covrd0_reg[15:14] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_covrd0_reg[23:22] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_covrd0_reg[31:30] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_covrd0_reg[7:6] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_covrd0_reg[15:14] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_covrd0_reg[23:22] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_covrd0_reg[31:30] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_covrd0_reg[7:6] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_covrd0_reg[15:14] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_covrd0_reg[23:22] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_covrd0_reg[31:30] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_covrd0_reg[7:6] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_covrd0_reg[15:14] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_covrd0_reg[23:22] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_covrd0_reg[31:30] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5 } -tag OTP_UC_INST -arg { therm_ctrl cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5.u_ree_gain_int_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5 } -tag OTP_UC_INST -arg { therm_ctrl cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5.u_ree_gain_int_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5 } -tag OTP_UC_INST -arg { therm_ctrl cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5.u_ree_gain_int_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5 } -tag OTP_UC_INST -arg { therm_ctrl cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5.u_ree_gain_int_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5 } -tag OTP_UC_INST -arg { int_accumulator_out_max cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5.u_ree_gain_int_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5 } -tag OTP_UC_INST -arg { int_accumulator_out_max cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5.u_ree_gain_int_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5 } -tag OTP_UC_INST -arg { int_accumulator_out_max cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5.u_ree_gain_int_v3 } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5 } -tag OTP_UC_INST -arg { int_accumulator_out_max cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5.u_ree_gain_int_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5 } -tag OTP_UC_INST -arg { int_accumulator_out_min cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5.u_ree_gain_int_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5 } -tag OTP_UC_INST -arg { int_accumulator_out_min cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5.u_ree_gain_int_v3 } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5 } -tag OTP_UC_INST -arg { int_accumulator_out_min cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5.u_ree_gain_int_v3 } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5 } -tag OTP_UC_INST -arg { int_accumulator_out_min cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5.u_ree_gain_int_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain } -tag OTP_UC_INST -arg { ree_vga_gain_ctrl_reg[7] cdnsdru_ree_vga_gain_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain } -tag OTP_UC_INST -arg { ree_vga_gain_ctrl_reg[15:13] cdnsdru_ree_vga_gain_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain } -tag OTP_UC_INST -arg { ree_vga_gain_ctrl_reg[22:21] cdnsdru_ree_vga_gain_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain } -tag OTP_UC_INST -arg { ree_vga_gain_ctrl_reg[30:29] cdnsdru_ree_vga_gain_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain } -tag OTP_UC_INST -arg { ree_vga_gain_ctrl_reg[7] cdnsdru_ree_vga_gain_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain } -tag OTP_UC_INST -arg { ree_vga_gain_ctrl_reg[15:13] cdnsdru_ree_vga_gain_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain } -tag OTP_UC_INST -arg { ree_vga_gain_ctrl_reg[22:21] cdnsdru_ree_vga_gain_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain } -tag OTP_UC_INST -arg { ree_vga_gain_ctrl_reg[30:29] cdnsdru_ree_vga_gain_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_covrd1_reg[31:6] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_covrd1_reg[31:6] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_covrd1_reg[31:6] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_covrd1_reg[31:6] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_ctrl_reg[7] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_ctrl_reg[15:12] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_ctrl_reg[23:22] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_ctrl_reg[31:30] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  
 
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_ctrl_reg[7] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_ctrl_reg[15:12] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_ctrl_reg[23:22] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_ctrl_reg[31:30] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_ctrl_reg[7] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_ctrl_reg[15:12] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_ctrl_reg[23:22] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_ctrl_reg[31:30] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs }  -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_ctrl_reg[7] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_ctrl_reg[15:12] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_ctrl_reg[23:22] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_ctrl_reg[31:30] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[1] cdnsdru_cdb_slave_var_w_wait_v1 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[1] cdnsdru_cdb_slave_var_w_wait_v1 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5_cdb_regs.u_cdb_slave } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_ovrd_ctrl_reg[14:8] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_ovrd_ctrl_reg[31:21] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_ovrd_ctrl_reg[14:8] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_ovrd_ctrl_reg[31:21] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_ovrd_ctrl_reg[14:8] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_ovrd_ctrl_reg[31:21] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_ovrd_ctrl_reg[14:8] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_ovrd_ctrl_reg[31:21] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_thr_reg[15:9] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_thr_reg[31:25] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_thr_reg[15:9] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_thr_reg[31:25] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_thr_reg[15:9] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain } -tag OTP_UC_INST -arg { ree_peak_thr_reg[31:25] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_peaking_amp_gain.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_thr_reg[15:9] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor } -tag OTP_UC_INST -arg { ree_peak_thr_reg[31:25] cdnsdru_ree_peaking_amp_gain_v6_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_post_cursor.u_ree_peaking_amp_gain_v6_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[1] cdnsdru_cdb_slave_var_w_wait_v1 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4_cdb_regs.u_cdb_slave } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[1] cdnsdru_cdb_slave_var_w_wait_v1 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef } -tag OTP_UC_INST -arg { ree_off_cor_ctrl_reg[15:7] cdnsdru_ree_offset_cor_coef_v4_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef } -tag OTP_UC_INST -arg { ree_off_cor_ctrl_reg[22] cdnsdru_ree_offset_cor_coef_v4_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef } -tag OTP_UC_INST -arg { ree_off_cor_ctrl_reg[31:24] cdnsdru_ree_offset_cor_coef_v4_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef } -tag OTP_UC_INST -arg { ree_off_cor_ctrl_reg[15:7] cdnsdru_ree_offset_cor_coef_v4_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef } -tag OTP_UC_INST -arg { ree_off_cor_ctrl_reg[22] cdnsdru_ree_offset_cor_coef_v4_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef } -tag OTP_UC_INST -arg { ree_off_cor_ctrl_reg[31:24] cdnsdru_ree_offset_cor_coef_v4_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4 } -tag OTP_UC_INST -arg { therm_ctrl cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4.u_ree_gain_int_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4 } -tag OTP_UC_INST -arg { therm_ctrl cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_offset_cor_coef.u_ree_offset_cor_coef_v4.u_ree_gain_int_v3 } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5 } -tag OTP_UC_INST -arg { therm_ctrl[31] cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5.u_ree_gain_int_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5 } -tag OTP_UC_INST -arg { therm_ctrl[31] cdnsdru_ree_gain_int_v3 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_vga_gain.u_ree_vga_gain_v5.u_ree_gain_int_v3 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { cdb_psel_tap_2_coef rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { cdb_psel_tap_2_coef rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { cdb_psel_lfeq_ctrl rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { cdb_psel_lfeq_ctrl rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -tag OTP_UC_INST -arg { cdb_pread_sel[11] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs.u_cdb_slave_ree_diag } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -tag OTP_UC_INST -arg { cdb_pread_sel[11] cdnsdru_cdb_slave_var_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs.u_cdb_slave_ree_diag } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_ctle_vga_cal_ctrl_apb_icfg } -tag OTP_UC_INST -arg { da_ana_cal_clk cdnsdru_bin_cal_apb_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_ctle_vga_cal_ctrl_apb_icfg.u_bin_cal_apb_1 } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_ctle_vga_cal_ctrl_apb_icfg } -tag OTP_UC_INST -arg { da_ana_cal_clk cdnsdru_bin_cal_apb_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_ctle_vga_cal_ctrl_apb_icfg.u_bin_cal_apb_1 } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_ctle_vga_cal_ctrl_apb_icfg } -tag OTP_UC_INST -arg { clk_out cdnsdru_clock_mux_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_ctle_vga_cal_ctrl_apb_icfg.u_clock_mux_rx_ctle_cal_clk } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_ctle_vga_cal_ctrl_apb_icfg } -tag OTP_UC_INST -arg { clk_out cdnsdru_clock_mux_v0 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_ctle_vga_cal_ctrl_apb_icfg.u_clock_mux_rx_ctle_cal_clk } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { cdb_psel_tap_3_coef rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { cdb_psel_tap_3_coef rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1 } -tag OTP_UC_INST -arg { ree_tap_ctrl_reg[7] cdnsdru_ree_tap_coef_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1 } -tag OTP_UC_INST -arg { ree_tap_ctrl_reg[15:12] cdnsdru_ree_tap_coef_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1 } -tag OTP_UC_INST -arg { ree_tap_ctrl_reg[22] cdnsdru_ree_tap_coef_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1 } -tag OTP_UC_INST -arg { ree_tap_ctrl_reg[31:24] cdnsdru_ree_tap_coef_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor } -tag OTP_UC_INST -arg { ree_tap_ctrl_reg[7] cdnsdru_ree_tap_coef_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor } -tag OTP_UC_INST -arg { ree_tap_ctrl_reg[15:12] cdnsdru_ree_tap_coef_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor } -tag OTP_UC_INST -arg { ree_tap_ctrl_reg[22] cdnsdru_ree_tap_coef_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor } -tag OTP_UC_INST -arg { ree_tap_ctrl_reg[31:24] cdnsdru_ree_tap_coef_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1 } -tag OTP_UC_INST -arg { ree_tap_ctrl_reg[7] cdnsdru_ree_tap_coef_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1 } -tag OTP_UC_INST -arg { ree_tap_ctrl_reg[15:12] cdnsdru_ree_tap_coef_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1 } -tag OTP_UC_INST -arg { ree_tap_ctrl_reg[22] cdnsdru_ree_tap_coef_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1 } -tag OTP_UC_INST -arg { ree_tap_ctrl_reg[31:24] cdnsdru_ree_tap_coef_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor } -tag OTP_UC_INST -arg { ree_tap_ctrl_reg[7] cdnsdru_ree_tap_coef_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor } -tag OTP_UC_INST -arg { ree_tap_ctrl_reg[15:12] cdnsdru_ree_tap_coef_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor } -tag OTP_UC_INST -arg { ree_tap_ctrl_reg[22] cdnsdru_ree_tap_coef_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor } -tag OTP_UC_INST -arg { ree_tap_ctrl_reg[31:24] cdnsdru_ree_tap_coef_v5_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[1] cdnsdru_cdb_slave_var_w_wait_v1 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[1] cdnsdru_cdb_slave_var_w_wait_v1 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5_cdb_regs.u_cdb_slave } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[1] cdnsdru_cdb_slave_var_w_wait_v1 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_tap_coef_1.u_ree_tap_coef_v5_cdb_regs.u_cdb_slave } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5_cdb_regs } -tag OTP_UC_INST -arg { cdb_pwrite_en[1] cdnsdru_cdb_slave_var_w_wait_v1 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_tx_pre_cursor.u_ree_tap_coef_v5_cdb_regs.u_cdb_slave } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_ctrl_data_mask_reg[14] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_ctrl_data_mask_reg[14] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_diag_ctrl_reg[2] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_diag_ctrl_reg[15:7] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_diag_ctrl_reg[2] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine } -tag OTP_UC_INST -arg { rx_ree_diag_ctrl_reg[15:7] rx_equalizer_engine_cdb_regs u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_rx_equalizer_engine_cdb_regs } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_usb } -tag OTP_UC_INST -arg { eq_ack cdnsdru_ree_gen_ctrl_sm_v4 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_usb.u_ree_gen_ctrl_sm_v4 } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_1 } -tag OTP_UC_INST -arg { eq_ack cdnsdru_ree_gen_ctrl_sm_v4 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_1.u_ree_gen_ctrl_sm_v4 } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_2 } -tag OTP_UC_INST -arg { eq_ack cdnsdru_ree_gen_ctrl_sm_v4 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_2.u_ree_gen_ctrl_sm_v4 } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_periodic } -tag OTP_UC_INST -arg { eq_ack cdnsdru_ree_gen_ctrl_sm_v4 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_periodic.u_ree_gen_ctrl_sm_v4 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_usb } -tag OTP_UC_INST -arg { eq_ack cdnsdru_ree_gen_ctrl_sm_v4 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_usb.u_ree_gen_ctrl_sm_v4 } -comment { no used signal as expected } 

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_1 } -tag OTP_UC_INST -arg { eq_ack cdnsdru_ree_gen_ctrl_sm_v4 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_1.u_ree_gen_ctrl_sm_v4 } -comment { no used signal as expected } 
 
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_2 } -tag OTP_UC_INST -arg { eq_ack cdnsdru_ree_gen_ctrl_sm_v4 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_2.u_ree_gen_ctrl_sm_v4 } -comment { no used signal as expected }  

check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_periodic } -tag OTP_UC_INST -arg { eq_ack cdnsdru_ree_gen_ctrl_sm_v4 u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_equalizer_engine.u_ree_gen_ctrl_sm_periodic.u_ree_gen_ctrl_sm_v4 } -comment { no used signal as expected }  

check_superlint -waiver -add  -module { cdnsdru_ree_sc_cor_v1_v0 } -tag ASG_MS_RPAD -arg { cdnsdru_ree_sc_cor_v1_v0 total_below_threshold unsigned 7 {(((((((((((((((((((((((((((((((bit_below_threshold[31] + bit_below_threshold[30]) + bit_below_threshold[29]) + bit_below_threshold[28]) + bit_below_threshold[27]) + bit_below_threshold[26]) + bit_below_threshold[25]) + bit_below_threshold[24]) + bit_below_threshold[23]) + bit_below_threshold[22]) + bit_below_threshold[21]) + bit_below_threshold[20]) + bit_below_threshold[19]) + bit_below_threshold[18]) + bit_below_threshold[17]) + bit_below_threshold[16]) + bit_below_threshold[15]) + bit_below_threshold[14]) + bit_below_threshold[13]) + bit_below_threshold[12]) + bit_below_threshold[11]) + bit_below_threshold[10]) + bit_below_threshold[9]) + bit_below_threshold[8]) + bit_below_threshold[7]) + bit_below_threshold[6]) + bit_below_threshold[5]) + bit_below_threshold[4]) + bit_below_threshold[3]) + bit_below_threshold[2]) + bit_below_threshold[1]) + bit_below_threshold[0])} unsigned 1 6 } -comment {enough width for use same as reuse model } 


check_superlint -waiver -add -module { cdnsdru_ree_attenuation_v3_cdb_regs } -tag ASG_MS_RTRU -arg { cdnsdru_ree_attenuation_v3_cdb_regs cdb_prdata_int unsigned 33 {\{\{(17 - COUNTER_WIDTH)\{1'b0\}\},ree_atten_thr_reg[(COUNTER_WIDTH + 15):16],4'b0000,ree_atten_thr_reg[12:8],3'b000,ree_atten_thr_reg[4:0]\}} unsigned 34 1 } -comment { enough width for use same as reuse model } 


check_superlint -waiver -add  -module { cdnsdru_ree_lfeq_ctrl_v3 } -tag ASG_MS_RPAD -arg { cdnsdru_ree_lfeq_ctrl_v3 sum_out_pos unsigned 6 {(((((((((((((((((((((((((((((((out_pos[31] + out_pos[30]) + out_pos[29]) + out_pos[28]) + out_pos[27]) + out_pos[26]) + out_pos[25]) + out_pos[24]) + out_pos[23]) + out_pos[22]) + out_pos[21]) + out_pos[20]) + out_pos[19]) + out_pos[18]) + out_pos[17]) + out_pos[16]) + out_pos[15]) + out_pos[14]) + out_pos[13]) + out_pos[12]) + out_pos[11]) + out_pos[10]) + out_pos[9]) + out_pos[8]) + out_pos[7]) + out_pos[6]) + out_pos[5]) + out_pos[4]) + out_pos[3]) + out_pos[2]) + out_pos[1]) + out_pos[0])} unsigned 1 5 } -comment { adder width ensured by design } 

check_superlint -waiver -add  -module { cdnsdru_ree_lfeq_ctrl_v3 } -tag ASG_MS_RPAD -arg { cdnsdru_ree_lfeq_ctrl_v3 sum_out_neg unsigned 6 {(((((((((((((((((((((((((((((((out_neg[31] + out_neg[30]) + out_neg[29]) + out_neg[28]) + out_neg[27]) + out_neg[26]) + out_neg[25]) + out_neg[24]) + out_neg[23]) + out_neg[22]) + out_neg[21]) + out_neg[20]) + out_neg[19]) + out_neg[18]) + out_neg[17]) + out_neg[16]) + out_neg[15]) + out_neg[14]) + out_neg[13]) + out_neg[12]) + out_neg[11]) + out_neg[10]) + out_neg[9]) + out_neg[8]) + out_neg[7]) + out_neg[6]) + out_neg[5]) + out_neg[4]) + out_neg[3]) + out_neg[2]) + out_neg[1]) + out_neg[0])} unsigned 1 5 } -comment { adder width ensured by design }

