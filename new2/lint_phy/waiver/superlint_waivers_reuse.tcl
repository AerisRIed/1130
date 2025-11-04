# mp_pcs modules
check_superlint -waiver -add -module mp_pcs_lane_v3        -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module usb30_lpbkslv_ec      -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module usb30_lpbkslv         -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module mp_rx_elec_idle       -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module mp_rctc               -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module mp_128b_rctc_16b_v1   -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module mp_128b_rctc_32b_v1   -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module mp_comma_align_v1     -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module mp_8b10b_rdec         -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module mp_eieos_align_16b_v2 -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module mp_eieos_align_32b_v2 -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module mp_cmn_if_v1          -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module mp_tx_datawidth_v2    -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module mp_rpcs_v3            -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module mp_tpcs_v3            -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module mp_rx_datawidth       -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module mp_rd_buf_v1          -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module mp_128b_tenc_v1       -comment {reuse module, ingore all warnings/errors} -force


# 
check_superlint -waiver -add -module custom_sync_tdr         -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module async_apb_if_slv_v1     -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module JTAG_MACRO              -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module custom_sync_mux_pre_sib -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module TAP_CONTROLLER          -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module BYPASS_REGISTER         -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module phy_data_delay          -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module phy_scan_mux            -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module phy_gen_mux2to1         -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module INSTRUCTION_DECODE      -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module phy_apb_async_if        -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module phy_clk_gate            -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module phy_clock_mux           -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module phy_clk_gating_cell     -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module phy_reset_sync          -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module tap_complex           -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module ieee1687_wrapper      -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module phy_mb_data_sync      -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -module phy_clock_div_sync    -comment {reuse module, ingore all warnings/errors} -force


check_superlint -waiver -add -instance u_tap_complex.u_JTAG_MACRO.INSTRUCTION_REGISTER      -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -instance u_phy_apb_slv_async_if.u_phy_reset_sync_apb_preset_n -comment {reuse module, ingore all warnings/errors} -force

# uC modules
check_superlint -waiver -add -instance u_uc_top.u_breset_sync_clk                           -comment {reuse module, ingore all warnings/errors} -force

check_superlint -waiver -add -instance u_uc_top.u_idram_arb                                 -comment {reuse module, ingore all warnings/errors} -force

check_superlint -waiver -add -source_file ../rtl/rtl_xtensa/xtensa/core/PCandIFetch.v -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -source_file ../rtl/rtl_xtensa/xtensa/core/PCUnit.v      -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -source_file ../rtl/rtl_xtensa/xtensa/core/LoadStore.v   -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -source_file ../rtl/rtl_xtensa/xtensa/core/LSElement.v   -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -source_file ../rtl/rtl_xtensa/xtensa/core/InstFetch.v   -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -source_file ../rtl/rtl_xtensa/xtensa/core/Decoder.v     -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -source_file ../rtl/rtl_xtensa/xtensa/core/Datapath.v    -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -source_file ../rtl/rtl_xtensa/xtensa/core/DStLdByp.v    -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -source_file ../rtl/rtl_xtensa/xtensa/core/DAlign.v      -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -source_file ../rtl/rtl_xtensa/xtensa/debug/Debug.v      -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -source_file ../rtl/rtl_xtensa/xtensa/debug/AccessPort.v -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add -source_file ../rtl/rtl_xtensa/xtensa/core/DataTlb.v     -comment {reuse module, ingore all warnings/errors} -force

#
#
# pma modules
check_superlint -waiver -add  -module cdnsdru_ss_wave_signal_gen_top_v3       -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_ss_wave_signal_gen_v3           -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_data_delay_v0                   -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_bin_cal_apb_v0                  -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_bin_cal_v0                      -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module ana_sig_test_mux                        -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module sandh_latch                             -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_clock_mux_v0                    -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_scan_tp_ctrl_v1                 -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_pll_ds_modulator_v3_top         -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_pll_ds_modulator_v3             -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_pll_ctrl_sm_v3_top              -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module ana_cal_filter                          -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_clk_gating_cell_v0              -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_clock_div_prog_v1               -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_data_sync_v0                    -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_sa_sync_fifo_v1_error_det_v0    -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_scan_tp_obs_v1                  -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_BC_11496_OUT_v3                 -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_BC_ENAB_NT_v3                   -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_BC_11496_ACTR_v3                -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_sa_sync_fifo_v1_v0              -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_macro_id_regs_v2_v0             -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_vco_cal_sm_v4_cdb_regs_v0       -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_vco_cal_sm_v4_top_v0            -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_vco_cal_sm_v4_v0                -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_clk_freq_msmt_v1_cdb_regs_v0    -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_startup_sm_v4_top               -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_startup_sm_v4_cdb_regs          -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_pll_ctrl_sm_v3_cdb_regs         -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_twos_comp_num_compare_v0        -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_accumulator_dyn_v0              -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_twos_comp_to_sign_mag_v0        -comment {reuse module, ingore all warnings/errors} -force
check_superlint -waiver -add  -module cdnsdru_hbdc_v5_half_v0                 -comment {reuse module, ingore all warnings/errors} -force






#pma rx
check_superlint -waiver -add  -module cdnsdru_bist_udd_fifo_v1                 -comment {reuse module, ingore all warnings/errors}  -force
check_superlint -waiver -add  -module cdnsdru_cdb_slave_var_v0                 -comment {reuse module, ingore all warnings/errors}  -force
check_superlint -waiver -add  -module cdnsdru_data_delay_v0                    -comment {reuse module, ingore all warnings/errors}  -force
check_superlint -waiver -add  -module cdnsdru_eye_surf_v2                      -comment {reuse module, ingore all warnings/errors}  -force
check_superlint -waiver -add  -module cdnsdru_rx_sig_detect_filt_low_v2_v0     -comment {reuse module, ingore all warnings/errors}  -force
check_superlint -waiver -add  -module cdnsdru_rx_sig_detect_filt_low_v2_top_v0 -comment {reuse module, ingore all warnings/errors}  -force
check_superlint -waiver -add  -module cdnsdru_rx_sig_detect_filt_v2_top_v0     -comment {reuse module, ingore all warnings/errors}  -force
check_superlint -waiver -add  -module cdnsdru_ln_rxctrl_bist_v1                -comment {reuse module, ingore all warnings/errors}  -force
check_superlint -waiver -add  -module cdnsdru_rx_sampler_ind_latch_cal_v2      -comment {reuse module, ingore all warnings/errors}  -force
check_superlint -waiver -add  -module cdnsdru_ree_gain_int_v3                  -comment {reuse module, ingore all warnings/errors}  -force
check_superlint -waiver -add  -module cdnsdru_ree_peaking_amp_gain_v6          -comment {reuse module, ingore all warnings/errors}  -force
check_superlint -waiver -add  -module cdnsdru_ree_peaking_amp_gain_v3_cdb_regs -comment {reuse module, ingore all warnings/errors}  -force
check_superlint -waiver -add  -module cdnsdru_gen_wide_timer_v0                -comment {reuse module, ingore all warnings/errors}  -force
check_superlint -waiver -add  -module cdnsdru_scan_mux_v0                      -comment {reuse module, ingore all warnings/errors}  -force
check_superlint -waiver -add  -module cdnsdru_therm_code_n_bits_v0             -comment {reuse module, ingore all warnings/errors}  -force

check_superlint -waiver -add  -module rx_lfps_det_filter_v0_nosig_filter       -comment {reuse module, ingore all warnings/errors}  -force
check_superlint -waiver -add  -module rx_lfps_det_filter_v0_top                -comment {reuse module, ingore all warnings/errors}  -force
check_superlint -waiver -add  -module rx_lfps_det_filter_v0                    -comment {reuse module, ingore all warnings/errors}  -force
check_superlint -waiver -add  -module rx_lfps_det_filter_v0_single_filter      -comment {reuse module, ingore all warnings/errors}  -force
check_superlint -waiver -add  -module rx_false_eye_det                         -comment {reuse module, ingore all warnings/errors}  -force

check_superlint -waiver -add  -module cdnsdru_gen_fifo_v0                      -comment {reuse module, ingore all warnings/errors}  -force

