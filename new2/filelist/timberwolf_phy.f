
////////////////////////////////PHY
+incdir+$PHY_DESIGN_AREA/design/rtl/typec_phy_top
+incdir+$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/serdes_arch
+incdir+$PHY_DESIGN_AREA/design/reuse/pipe_mp_pcs
+incdir+$PHY_DESIGN_AREA/design/reuse/pma/rtl/pma_top


$PHY_DESIGN_AREA/design/rtl/typec_phy_top/cdn_sd3101_phy_defines.v
$PHY_DESIGN_AREA/design/rtl/typec_phy_top/typec_timberwolf_phy_top.sv

$PHY_DESIGN_AREA/design/rtl/typec_phy_top/apb_top_wrapper.v
$PHY_DESIGN_AREA/design/rtl/typec_phy_top/pma_cdb_prdata_sync.v
$PHY_DESIGN_AREA/design/rtl/typec_phy_top/pma_cmn_cdb_addr_decode.v
$PHY_DESIGN_AREA/design/rtl/typec_phy_top/pma_ln_cdb_addr_decode.v
$PHY_DESIGN_AREA/design/rtl/typec_phy_top/phy_tap_mux.v

$PHY_DESIGN_AREA/design/rtl/typec_phy_top/phy_port_master_lane_sel.v
$PHY_DESIGN_AREA/design/rtl/typec_phy_top/phy_pwrst_aggr_prw_v1.v
$PHY_DESIGN_AREA/design/rtl/typec_phy_top/pma_pll_ready_aggr.v
$PHY_DESIGN_AREA/design/rtl/typec_phy_top/phy_port_lane_aggr_or.v

////////////////////////////////Isolation
$PHY_DESIGN_AREA/design/rtl/typec_phy_top/pcs_iso_ctrl_cmn.v
$PHY_DESIGN_AREA/design/rtl/typec_phy_top/pcs_iso_ctrl_ln.v
$PHY_DESIGN_AREA/design/rtl/typec_phy_top/pma_iso_ctrl_cmn.v
$PHY_DESIGN_AREA/design/rtl/typec_phy_top/pma_iso_ctrl_ln.v
$PHY_DESIGN_AREA/design/rtl/typec_phy_top/pcs_iso_mb.v

////////////////////////////////uC filelist
-F $PHY_DESIGN_AREA/design/rtl/rtl_xtensa/xtensa/xtensa.f
$PHY_DESIGN_AREA/design/rtl/rtl_xtensa/uc.v
$PHY_DESIGN_AREA/design/rtl/rtl_xtensa/sram_initialize.v
$PHY_DESIGN_AREA/design/rtl/rtl_xtensa/idram_arb.v
$PHY_DESIGN_AREA/design/rtl/rtl_xtensa/ecc.v
$PHY_DESIGN_AREA/design/rtl/rtl_xtensa/dram2apb.v
$PHY_DESIGN_AREA/design/rtl/rtl_xtensa/apb2sram.v
$PHY_DESIGN_AREA/design/rtl/rtl_xtensa/CW_ecc_legacy_width32_chkbits7_synd_sel0.v
$PHY_DESIGN_AREA/design/rtl/rtl_xtensa/CW_ecc_legacy_width32_chkbits7_synd_sel1.v

////////////////////////////////PCS clkrst
$PHY_DESIGN_AREA/design/rtl/typec_phy_top/typec_phy_timberwolf_clkrst.v
$PHY_DESIGN_AREA/design/rtl/typec_phy_top/phy_lane_reset_sequencer.v
$PHY_DESIGN_AREA/design/rtl/typec_phy_top/phy_reset_sequencer.v



////////////////////////////////mp_pcs_top 
$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/mp_pcs_top.sv


////////////////////////////////message bus
$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/message_bus/cdnsdru_usb4_message_bus_pipe_defines_v4.v
$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/message_bus/cdnsdru_usb4_message_bus_allfslf_wr_v4.v
$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/message_bus/cdnsdru_usb4_message_bus_eq_train_v4.v
$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/message_bus/cdnsdru_usb4_message_bus_gen_reg_ctrl_v4.v
$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/message_bus/cdnsdru_usb4_message_bus_io_recal_v4.v
$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/message_bus/cdnsdru_usb4_message_bus_link_eval_stat_regs_v4.v
$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/message_bus/cdnsdru_usb4_message_bus_lm_regs_v4.v
$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/message_bus/cdnsdru_usb4_message_bus_pcs_rx_ctrl_v4.v
$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/message_bus/cdnsdru_usb4_message_bus_pipe_rx_ctrl_v4.v
$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/message_bus/cdnsdru_usb4_message_bus_pipe_tx_ctrl_v4.v
$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/message_bus/cdnsdru_usb4_message_bus_pma_txrx_ctrl_v4.v
$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/message_bus/cdnsdru_usb4_message_bus_preset_coef_regs_v4.v
$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/message_bus/cdnsdru_usb4_message_bus_top_v4.v


////////////////////////////////Serdes pipe 
$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/serdes_arch/mp_cmn_if_pipe6_usb4.v
$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/serdes_arch/mp_pcs_consts_usb4.vh
$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/serdes_arch/mp_pcs_lane_pipe6_var_pclk_usb4.v
$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/serdes_arch/mp_pwr_rate_ctrl_pipe6_var_pclk_usb4.v
$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/serdes_arch/mp_rcv_det_pipe6_usb4.sv
$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/serdes_arch/mp_rpcs_pipe6_usb4.v
$PHY_DESIGN_AREA/design/rtl/mp_pcs_top/serdes_arch/mp_tpcs_pipe6_var_pclk_usb4.v


////////////////////////////////type-c mux
$PHY_DESIGN_AREA/design/rtl/typec_phy_top/typec_pma_mux.v

////////////////////////////////speedup cfg
$PHY_DESIGN_AREA/design/rtl/typec_phy_top/phy_reconfig_ctlr.v
$PHY_DESIGN_AREA/design/rtl/typec_phy_top/phy_spdup_cmn_rom.v
$PHY_DESIGN_AREA/design/rtl/typec_phy_top/phy_spdup_ln_rom.v
