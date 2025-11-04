//PMA digital RTL (for synth & simulation)
//+define+SD3101_N4P_22_VS130_1XAH1XBV1XCH1XDV1YAH1YBV4YHVHV2X
+incdir+$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_top/
+incdir+$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn_func/

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_top/pma_top_22.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_top/pma_rev_22.v

//CMN RTL
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn/cmn_clkrst.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn/ana_sig_test_mux.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn/cmn_cdb.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn/cmn_pll_ctrl.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn/cmn_ring_pll_ctrl.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn/ana_en_del_ctrl.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn/pll_ctrl.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn/pll_var_trm_cdb_regs.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn/pll_var_trm.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn/pll_var_trm_wrapper.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn/pwr_isl_ctrl_sm_cmn_icfg.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn/sandh_latch.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn/pll_ctrl_cdb_regs.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn/ring_pll_ctrl_cdb_regs.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn/ring_pll_ctrl.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn/ring_pll_ctrl_sm_v0/ring_pll_ctrl_sm_v0_top.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn/ring_pll_ctrl_sm_v0/ring_pll_ctrl_sm_v0.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn/ring_pll_ctrl_sm_v0/ring_pll_ctrl_sm_v0_cdb_regs.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn_ctrl/cmn_cdiag_ovrd_cdb_regs.v  
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn_ctrl/cmn_cdiag_ovrd.v  
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn_ctrl/cmn_ctrl.v  

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn_func/ana_cal_filter.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn_func/bg_cal_ctrl_apb_icfg.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn_func/cmn_fdiag_ovrd_cdb_regs.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn_func/cmn_fdiag_ovrd.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn_func/cmn_func.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn_func/cmn_hsrrsm.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn_func/cmn_ibiascal_icfg.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn_func/cmn_pdiag_lc_pll_cdb_regs.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn_func/cmn_pdiag_ring_pll_cdb_regs.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn_func/cmn_temp_sensor_filt.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn_func/rx_rescal_ctrl_icfg.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn_func/sd_clk_cal_icfg.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn_func/tx_rescal_ctrl_pd_icfg.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn_func/tx_rescal_ctrl_pu_icfg.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_cmn/cmn.v

//XCVR RTL
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_xcvr/xcvr_txrxm.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_xcvr/xcvr_txm.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_xcvr/xcvr_txonly.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_xcvr/xcvr_pwr_isl_ctrl.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_xcvr/pwr_isl_ctrl_sm_xcvr_icfg.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_xcvr/xcvr_clkrst.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_xcvr/xcvr_cdb.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_drv_ctrl/drv_ctrl.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_drv_ctrl/fast_est_cmn_mode.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_drv_ctrl/tx_coef_calc.sv
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_drv_ctrl/tx_coef_calc_mult.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_drv_ctrl/tx_coef_calc_cdb_regs.sv
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_drv_ctrl/cdnsdru_hbdc_distributor.sv
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_drv_ctrl/hbdc_usb4_wrapper.sv
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_drv_ctrl/tx_lfps_ctrl.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_drv_ctrl/drv_ctrl_diag_ovrd.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_drv_ctrl/drv_ctrl_diag_ovrd_cdb_regs.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/ana_rtl_hbdc/hbdc_b2t_enc_wrapper.sv

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_xcvr_ctrl/xcvr_diag_ovrd.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_xcvr_ctrl/xcvr_diag_ovrd_cdb_regs.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_xcvr_ctrl/xcvr_hsrrsm.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_xcvr_ctrl/xcvr_clk_rst_sm.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_xcvr_ctrl/xcvr_ctrl.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_tx_ctrl/tx_ctrl.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_tx_ctrl/tx_ctrl_bist_top.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_tx_ctrl/tx_dc_cal_ctrl_apb_icfg.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_tx_ctrl/tx_dc_cal_act_mapping.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_tx_ctrl/tx_diag_ovrd.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_tx_ctrl/tx_diag_ovrd_cdb_regs.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_tx_dsync/tx_dsync.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_ctrl.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_dsync/rx_dsync.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_diag_ovrd.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_diag_ovrd_cdb_regs.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_equalizer_engine.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_equalizer_engine_cdb_regs.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/eq_mode_change_det.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_sampler_latch_cal_wrapper.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_sampler_latch_cal_wrapper_cdb_regs.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_sampler_latch_cal.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_sampler_latch_cal_sequencer.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/sd_cal_ctrl_apb_icfg.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/qcc_cal_ctrl_apb_icfg.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/ctle_vga_cal_ctrl_apb_icfg.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rcv_ctrl.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/sampler_dac_ctrl.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/sampler_dac_ctrl_cdb_regs.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_sig_detect_filt_apb_icfg.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdrlf_config.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdrlf_config_cdb_regs.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_false_eye_det_cdb_regs.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_false_eye_det.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_false_eye_det_wrapper.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_ctrl_bist_top.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_lfps_det_filter_top_icfg.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_lfps_det_filter_v0_top.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_lfps_det_filter_v0_cdb_regs.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_lfps_det_filter_v0_edge_gen.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_lfps_det_filter_v0_embed_det.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_lfps_det_filter_v0_gen_timer_with_output.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_lfps_det_filter_v0_nosig_filter.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_lfps_det_filter_v0_signal_filter.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_lfps_det_filter_v0_single_filter.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_lfps_det_filter_v0_sync.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/rx_lfps_det_filter_v0.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_fw_ctrl_sm_top.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_fw_ctrl_sm_cdb_regs.v

//********ree change width for reuse module********/
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_sc_cor_v1_v0/trunk/hdl/hdl_src/cdnsdru_ree_sc_cor_v1_cdb_regs_v0.v 
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_sc_cor_v1_v0/trunk/hdl/hdl_src/cdnsdru_ree_sc_cor_v1_v0.v 
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_sc_cor_v1_v0/trunk/hdl/hdl_src/cdnsdru_ree_sc_cor_v1_top_v0.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_lfeq_ctrl_v3/trunk/hdl/hdl_src/cdnsdru_ree_lfeq_ctrl_v3.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_lfeq_ctrl_v3/trunk/hdl/hdl_src/cdnsdru_ree_lfeq_ctrl_v3_top.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_lfeq_ctrl_v3/trunk/hdl/hdl_src/cdnsdru_ree_lfeq_ctrl_v3_comb.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_lfeq_ctrl_v3/trunk/hdl/hdl_src/cdnsdru_ree_lfeq_ctrl_v3_cdb_regs.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_offset_cor_coef_v4/trunk/hdl/hdl_src/cdnsdru_ree_offset_cor_coef_v4.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_offset_cor_coef_v4/trunk/hdl/hdl_src/cdnsdru_ree_offset_cor_coef_v4_top.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_offset_cor_coef_v4/trunk/hdl/hdl_src/cdnsdru_ree_offset_cor_coef_v4_cdb_regs.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_offset_cor_coef_v4/trunk/hdl/hdl_src/cdnsdru_ree_offset_cor_coef_input_comb_v0.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_tap_coef_v5/trunk/hdl/hdl_src/cdnsdru_ree_tap_coef_v5.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_tap_coef_v5/trunk/hdl/hdl_src/cdnsdru_ree_tap_coef_v5_top.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_tap_coef_v5/trunk/hdl/hdl_src/cdnsdru_ree_tap_coef_v5_cdb_regs.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_tap_coef_v5/trunk/hdl/hdl_src/cdnsdru_ree_tap_coef_comb_zero_x_v0.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_tap_coef_v5/trunk/hdl/hdl_src/cdnsdru_ree_tap_coef_comb_non_zero_x_v0.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_vga_gain_v5/trunk/hdl/hdl_src/cdnsdru_ree_vga_gain_v5.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_vga_gain_v5/trunk/hdl/hdl_src/cdnsdru_ree_vga_gain_v5_top.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_vga_gain_v5/trunk/hdl/hdl_src/cdnsdru_ree_vga_gain_v5_cdb_regs.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_vga_gain_v5/trunk/hdl/hdl_src/cdnsdru_ree_vga_gain_input_comb_v0.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_vga_gain_v5/trunk/hdl/hdl_src/cdnsdru_ree_vga_gain_input_comb_v0_pt.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_attenuation_v3/trunk/hdl/hdl_src/cdnsdru_ree_attenuation_v3_top.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_attenuation_v3/trunk/hdl/hdl_src/cdnsdru_ree_attenuation_v3.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_attenuation_v3/trunk/hdl/hdl_src/cdnsdru_ree_attenuation_v3_cdb_regs.v
                                  
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_peaking_amp_gain_v6/trunk/hdl/hdl_src/cdnsdru_ree_peaking_amp_gain_v6.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_peaking_amp_gain_v6/trunk/hdl/hdl_src/cdnsdru_ree_peaking_amp_gain_v6_top.v
$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_peaking_amp_gain_v6/trunk/hdl/hdl_src/cdnsdru_ree_peaking_amp_gain_v6_cdb_regs.v

$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_rx_ctrl/cdnsdru_ree_ignore_1010_v0/trunk/hdl/hdl_src/cdnsdru_ree_ignore_1010_v0.v

