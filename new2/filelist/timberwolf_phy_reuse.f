////////////////////////////////Normal function Reuse modules

///////////////////////////////PCS Resue
$PHY_DESIGN_AREA/design/reuse/rtl_phy_misc_components/phy_tx_coef_calc_mult.v
$PHY_DESIGN_AREA/design/reuse/rtl_phy_misc_components/phy_mb_data_sync.v
$PHY_DESIGN_AREA/design/reuse/rtl_phy_misc_components/phy_clk_gating_cell.v
$PHY_DESIGN_AREA/design/reuse/rtl_phy_misc_components/phy_data_delay.v
$PHY_DESIGN_AREA/design/reuse/rtl_phy_misc_components/phy_tpsync.v
$PHY_DESIGN_AREA/design/reuse/rtl_phy_misc_components/sram_pwrdwn_ctrl_v1.v
$PHY_DESIGN_AREA/design/reuse/rtl_phy_misc_components/phy_clock_div_sync.v
$PHY_DESIGN_AREA/design/reuse/rtl_phy_misc_components/phy_gen_mux2to1.v
$PHY_DESIGN_AREA/design/reuse/rtl_phy_misc_components/phy_gen_timer.v
$PHY_DESIGN_AREA/design/reuse/rtl_phy_misc_components/phy_state_chg_monitor.v

$PHY_DESIGN_AREA/design/reuse/rtl_phy_cdb_amba_apb/phy_apb_async_if.v
$PHY_DESIGN_AREA/design/reuse/rtl_phy_cdb_amba_apb/cdb_arbiter_v1.v
$PHY_DESIGN_AREA/design/reuse/rtl_phy_cdb_amba_apb/async_apb_if_mst.v
$PHY_DESIGN_AREA/design/reuse/rtl_phy_cdb_amba_apb/async_apb_if_slv.v
$PHY_DESIGN_AREA/design/reuse/rtl_phy_cdb_amba_apb/async_apb_if_slv_v1.v
$PHY_DESIGN_AREA/design/reuse/rtl_phy_cdb_amba_apb/cdb_watchdog.v
$PHY_DESIGN_AREA/design/reuse/rtl_phy_cdb_amba_apb/phy_cdb_slave_var.v
$PHY_DESIGN_AREA/design/reuse/rtl_phy_cdb_amba_apb/cdb_arbiter_v2.v

$PHY_DESIGN_AREA/design/reuse/rtl_async_ctrl_interfaces/async_ctrl_if_mst.v
$PHY_DESIGN_AREA/design/reuse/rtl_async_ctrl_interfaces/async_ctrl_if_slv.v

$PHY_DESIGN_AREA/design/reuse/rtl_tap/tap_complex.v
$PHY_DESIGN_AREA/design/reuse/rtl_tap/JTAG_MACRO.v
$PHY_DESIGN_AREA/design/reuse/rtl_tap/tap_custom_reg.v
$PHY_DESIGN_AREA/design/reuse/rtl_tap/TAP_CONTROLLER.v
$PHY_DESIGN_AREA/design/reuse/rtl_tap/INSTRUCTION_REGISTER.v
$PHY_DESIGN_AREA/design/reuse/rtl_tap/INSTRUCTION_DECODE.v
$PHY_DESIGN_AREA/design/reuse/rtl_tap/JTAG_CLOCK_GATE.v
$PHY_DESIGN_AREA/design/reuse/rtl_tap/BYPASS_REGISTER.v
$PHY_DESIGN_AREA/design/reuse/rtl_tap/ieee1687_wrapper.v
$PHY_DESIGN_AREA/design/reuse/rtl_tap/custom_sync_mux_pre_sib.v
$PHY_DESIGN_AREA/design/reuse/rtl_tap/custom_sync_tdr.v


//original pipe
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_cmn_if_v1.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_pwr_rate_ctrl_v2.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_rcv_det_v1.sv
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/pcie_fslf_smpl_trig.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/pcie_pipe_4_eq_wrap_v2.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/pcie_pipe_4_eq_wrap_v3.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_rx_elec_idle.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_tx_datawidth_v2.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_tx_clk_cross_fifo.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_8b10b_tenc.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_128b_tenc_v1.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_tmux.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/usb_tlfps_v2.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_tpcs_v3.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_tx_deemph.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/sata_lpbk_alignfsm.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/sata_lpbk.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/sata_toob.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/usb30_lpbkslv_bercfsm.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/usb30_lpbkslv_brstfsm.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/usb30_lpbkslv_ec.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/usb30_lpbkslv_scr.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/usb30_lpbkslv_skpfsm.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/usb30_lpbkslv_uflowfsm.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/usb30_lpbkslv.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_rd_buf_v1.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_comma_align_fsm.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_comma_align_v1.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_eieos_align_16b_v2.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_eieos_align_32b_v2.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_usb_symb_err_cor_16b.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_usb_symb_err_cor_32b.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_ctc_en_ctrl.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_128b_rctc_16b_v1.sv
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_128b_rctc_32b_v1.sv
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_rctc_ctrl.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_rctc.sv
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_8b10b_rdec.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_128b_rdec.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_rx_datawidth.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_rpcs_v3.v
$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs/mp_pcs_lane_v3.v
