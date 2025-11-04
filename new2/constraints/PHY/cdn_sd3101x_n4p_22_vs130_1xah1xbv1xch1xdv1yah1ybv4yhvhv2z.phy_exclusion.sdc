#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
#
# Copyright notice:
# "(c) 2013 Cadence Design System, Inc. All rights reserved worldwide."
#
#
# This work may not be copied, modified, re-published, uploaded, executed, or
# distributed in any way, in any medium, whether in whole or in part, without
# prior written permission from Cadence Design System, Inc.
# 
#----------------------------------------------------------------------------


set analog_port_list        [list \
                                   tx_p_ln_0 \
                                   tx_m_ln_0 \
                                   rx_p_ln_1 \
                                   rx_m_ln_1 \
                                   rx_p_ln_2 \
                                   rx_m_ln_2 \
                                   tx_p_ln_3 \
                                   tx_m_ln_3 \
                                   cmn_rext \
                                   pma_atb_core_0 \
                                   pma_atb_core_1 \
                            ]

set power_ground_port_list  [list \
                                   agnd \
                                   avdd_clk \
                                   avdd_h \
                                   avdd \
                                   avdd_tx0 \
                                   avdd_tx1 \
                                   avdd_tx2 \
                                   avdd_tx3 \
                                   avdd_rx \
                                   cmn_aonvdd \
                            ]

set reset_port_list         [list \
                                  apb_preset_n \
                                  uc_reset_n \
                                  phy_reset_n \
                                  pipe4_reset_n \
                                  pipe7_reset_n \
                                  dp_reset_n \
                                  tap_trst_n \
                                  uc_top_tap_trst_n \
                                  uc_l01_tap_trst_n \
                                  uc_l23_tap_trst_n \
                                  ieee1687_rstn \
                            ]

#-----------------------------------------------------------------------------
# Resets
#-----------------------------------------------------------------------------
foreach item $reset_port_list {
   set_ideal_network -no_propagate [get_ports $item]
   set_false_path -from [get_ports $item]
   set_dont_touch [get_nets $item]
}

#-----------------------------------------------------------------------------
# Power/ground pins
#-----------------------------------------------------------------------------
foreach item $power_ground_port_list {
set_dont_touch_network [get_ports $item]
}

#-----------------------------------------------------------------------------
# Analog PMA pins
#-----------------------------------------------------------------------------
foreach item $analog_port_list {
set_dont_touch_network [get_ports $item]
}

#-----------------------------------------------------------------------------
# Static and async PHY I/Os
#-----------------------------------------------------------------------------
set_false_path -to   [get_ports {phy_uc_init_complete}]
set_false_path -to   [get_ports {phy_error_interrupt}]
set_false_path -to   [get_ports {phy_interrupt_usb}]
set_false_path -to   [get_ports {phy_interrupt_dp}]
set_false_path -from [get_ports {phy_l00_ctlr_interrupt_in}]
set_false_path -from [get_ports {phy_l01_ctlr_interrupt_in}]

set_false_path -from [get_ports {typec_conn_dir}]
set_false_path -from [get_ports {phy_mode[*]}]

set_false_path -from [get_ports {ieee1687_interface_en}]

set_false_path -from [get_ports {pma_cmn_refclk_dig_div[*]}]
set_false_path -from [get_ports {pma_cmn_refclk_dig_sel}]
set_false_path -from [get_ports {pma_cmn_pll0_refclk_sel[*]}]
set_false_path -from [get_ports {pma_cmn_pll1_refclk_sel[*]}]


# Raw SerDes I/F
set_false_path -to   [get_ports {pma_cmn_ready}]

set_false_path -from [get_ports {pma_xcvr_pllclk_en}]
set_false_path -to   [get_ports {pma_xcvr_pllclk_en_ack}]

set_false_path -from [get_ports {pma_xcvr_power_state_req[*]}]
set_false_path -to   [get_ports {pma_xcvr_power_state_ack[*]}]

set_false_path -to   [get_ports {pma_cmn_avdd_pwrgood}]

set_false_path -from [get_ports {pma_xcvr_data_width[*]}]

set_false_path -from [get_ports {pma_tx_lfps_en}]
set_false_path -from [get_ports {pma_tx_lfps_mode}]

#-----------------------------------------------------------------------------
# Async PMA outputs
#-----------------------------------------------------------------------------
#TODO double confirm.
set_false_path -through [get_pins {u_mp_pma/tx_rcv_detect_done_ln_*}]
set_false_path -through [get_pins {u_mp_pma/tx_local_tx_coef_valid_ln_*}]

#-----------------------------------------------------------------------------
# False Paths to external boundary scan control interface
#-----------------------------------------------------------------------------
set_false_path -from [get_ports {bscan_ext_select}]
set_false_path -from [get_ports {tx_bscan_ext_updatedr}]
set_false_path -from [get_ports {tx_bscan_ext_mode_c}]
set_false_path -from [get_ports {tx_bscan_ext_ac}]
set_false_path -from [get_ports {tx_bscan_ext_acpulse}]
set_false_path -from [get_ports {rx_bscan_ext_pc}]
set_false_path -from [get_ports {rx_bscan_ext_ac}]

set_false_path -from [get_ports {xcvr_bscan_mode_en}]
