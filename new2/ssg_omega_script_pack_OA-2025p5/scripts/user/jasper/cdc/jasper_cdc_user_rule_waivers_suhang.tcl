# ----------------------------------------
# Jasper Version Info
# tool      : Jasper 2025.03
# platform  : Linux 3.10.0-1160.2.2.el7.x86_64
# version   : 2025.03p001 64 bits
# build date: 2025.04.22 13:40:17 UTC
# ----------------------------------------
# started   : 2025-09-30 08:53:13 CST
# created   : 2025-09-30 09:32:16 CST
# hostname  : kdt-farm27.cadence.com
# pid       : 222841
# arguments : '-style' 'windows' '-label' 'session_0' '-console' '//127.0.0.1:42190' '-data' 'AAAC3nic3ZBLTsMwEIb/ICohpF4EqbSUtAKpG7phCQhYWyEJKX2lihN1CUflJuGzU6qEIxDLmfH/GHsmkDT7rOta/gu+m6hZoO7nzidd5OmrE6XeL3XKPtNAsRK2dE6+U6FcS/QXGh5PKXwpC2LRXutKI7YBC5WhMnpHM1QFn+JplJUWirRFYfAvYLbgL/rQRm9et6f6Gq/Rq541p5qBD3WvR5QligrPijxBb3FmvoZluao5lVKyiNxyR4Fih8/wjzivyB50R19jXjzWBDzEv4S15O4N5tC/OdxmUN7S4+joccgN0WFT787+TEbB9B9Pq611b42pVPgO2nNs8A0r97eWRNdrQtz7ubbVl/Ax3Uh9/QCQuXiA' '-proj' '/projects/sd3101_t4gp_fe/users/suhang_chen/Timberwolf_USB4_T4GP/trunk/design/ssg_omega_script_pack_OA-2025p4/jasper_cdc_run_09302025_085306/jgproject/sessionLogs/session_0' '-init' '-hidden' '/projects/sd3101_t4gp_fe/users/suhang_chen/Timberwolf_USB4_T4GP/trunk/design/ssg_omega_script_pack_OA-2025p4/jasper_cdc_run_09302025_085306/jgproject/.tmp/.initCmds.tcl' '/projects/sd3101_t4gp_fe/users/suhang_chen/Timberwolf_USB4_T4GP/trunk/design/ssg_omega_script_pack_OA-2025p4/scripts/core/jasper/common/top_down_jasper.tcl'
# ----------------------------------------
#
# Any disclosure about the Cadence Design Systems software or its use
# model to any third party violates the written Non-Disclosure Agreement
# between Cadence Design Systems, Inc. and the customer.
#
# THIS SOFTWARE CONTAINS CONFIDENTIAL INFORMATION AND TRADE SECRETS OF
# CADENCE DESIGN SYSTEMS, INC. USE, DISCLOSURE, OR REPRODUCTION IS
# PROHIBITED WITHOUT THE PRIOR EXPRESS WRITTEN PERMISSION OF CADENCE
# DESIGN SYSTEMS, INC.
#
# Copyright (C) 2000-2025 Cadence Design Systems, Inc. All Rights
# Reserved.  Unpublished -- rights reserved under the copyright laws of
# the United States.
#
# This product includes software developed by others and redistributed
# according to license agreement. See doc/third_party_readme.txt for
# further details.
#
# RESTRICTED RIGHTS LEGEND
#
# Use, duplication, or disclosure by the Government is subject to
# restrictions as set forth in subparagraph (c) (1) (ii) of the Rights in
# Technical Data and Computer Software clause at DFARS 252.227-7013 or
# subparagraphs (c) (1) and (2) of Commercial Computer Software -- Restricted
# Rights at 48 CFR 52.227-19, as applicable.
#
#
#                           Cadence Design Systems, Inc.
#                           2655 Seely Avenue
#                           San Jose, CA 95134
#                           Phone: 408.943.1234
#
# For technical assistance visit http://support.cadence.com.

######################################################
# PCS
######################################################

# "Resets 'pipe7_reset_n,pipe4_reset_n' with matching polarities converge at 'u_phy_clkrst.int_iso_pipe_mux_reset_n', possibly causing invalid assertion/deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_phy_clkrst\.int_iso_pipe_mux_reset_n} -local_source_reset {pipe7_reset_n pipe4_reset_n}] \
                                          -comment {This is the mux to select pipe4_reset_n and pipe7_reset_n. It can't switch dynamiclly.}

# "Resets 'pipe7_reset_n,u_phy_clkrst.u_phy_reset_sync_phy_refclk_reset_n.reset_sync_flop[1]' with matching polarities converge at 'u_phy_clkrst.u_usb4_link_reset_sequencer.:tmp_10', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_phy_clkrst\.u_usb4_link_reset_sequencer\.\:tmp_10}] \
                                          -comment {This logic is phy_reset_n & pipe7_reset_n, there is a reset sequence of these two resets.}

# "Resets 'u_phy_clkrst.u_phy_reset_sync_phy_refclk_reset_n.reset_sync_flop[1],pipe4_reset_n' with matching polarities converge at 'u_phy_clkrst.u_usb3_link_reset_sequencer.:tmp_10', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_phy_clkrst\.u_usb3_link_reset_sequencer\.\:tmp_10}] \
                                          -comment {This logic is phy_reset_n & pipe4_reset_n, there is a reset sequence of these two resets.}

# "Resets 'pipe7_reset_n,u_phy_clkrst.u_phy_reset_sync_phy_refclk_reset_n.reset_sync_flop[1],pipe4_reset_n' with matching polarities converge at 'u_phy_clkrst.u_usb_link_reset_sequencer.:tmp_10', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_phy_clkrst\.u_usb_link_reset_sequencer\.\:tmp_10}] \
                                          -comment {This logic is phy_reset_n & mux_pipe_reset_n, there is a reset sequence of these two resets.}

# "Resets 'u_phy_clkrst.u_phy_reset_sync_phy_refclk_reset_n.reset_sync_flop[1],dp_reset_n' with matching polarities converge at 'u_phy_clkrst.u_dp_link_reset_sequencer.:tmp_10', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_phy_clkrst\.u_dp_link_reset_sequencer\.\:tmp_10}] \
                                          -comment {This logic is phy_reset_n & dp_reset_n, there is a reset sequence of these two resets.}

# "Resets 'u_apb_top_wrapper.u_async_apb_if_slv.u_phy_reset_sync_apb_preset.reset_sync_flop[1],u_pcs_iso_ctrl_cmn.phy_ln_soft_cdb_reset_n[0]' with matching polarities converge at 'int_ln_cdb_preset_n[0]', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {int_ln_cdb_preset_n\[0\]}] \
                                          -comment {cdb_reset & soft_reset, the soft_reset comes from apb register. So, there's no glitch risk.}

# "Resets 'u_apb_top_wrapper.u_async_apb_if_slv.u_phy_reset_sync_apb_preset.reset_sync_flop[1],u_pcs_iso_ctrl_cmn.phy_ln_soft_cdb_reset_n[2]' with matching polarities converge at 'int_ln_cdb_preset_n[2]', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {int_ln_cdb_preset_n\[2\]}] \
                                          -comment {cdb_reset & soft_reset, the soft_reset comes from apb register. So, there's no glitch risk.}

# "Resets 'u_apb_top_wrapper.u_async_apb_if_slv.u_phy_reset_sync_apb_preset.reset_sync_flop[1],u_pcs_iso_ctrl_cmn.uc_soft_reset_n' with matching polarities converge at ':tmp_341', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_pcs_iso_ctrl_cmn\.uc_soft_reset_n}] \
                                          -comment {uc_soft_reset_n = uc_ctrl_reg & uc_self_reset_n, the uc_ctrl_reg comes from apb register. So, there's no glitch risk.}

# "Resets 'u_apb_top_wrapper.u_async_apb_if_slv.u_phy_reset_sync_apb_preset.reset_sync_flop[1],u_pcs_iso_ctrl_cmn.uc_soft_reset_n' with matching polarities converge at ':tmp_341', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -source_clock_domain uc_clk \
                                          -local_source_clock uc_clk \
                                          -occurrence {\:tmp_341}] \
                                          -comment {uc_soft_reset_n = uc_ctrl_reg & uc_self_reset_n, the uc_ctrl_reg comes from apb register. So, there's no glitch risk.}

# "Resets 'u_apb_top_wrapper.u_async_apb_if_slv.u_phy_reset_sync_apb_preset.reset_sync_flop[1],u_pcs_iso_ctrl_ln_2.uc_soft_reset_n,u_pcs_iso_ctrl_cmn.phy_ln_soft_cdb_reset_n[2]' with matching polarities converge at ':tmp_11132', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -source_clock_domain uc_clk \
                                          -local_source_clock uc_clk \
                                          -occurrence {\:tmp_11132}] \
                                          -comment {uc_soft_reset_n = uc_ctrl_reg & uc_self_reset_n, the uc_ctrl_reg comes from apb register. So, there's no glitch risk.}

# "Resets 'u_pcs_iso_ctrl_ln_0.uc_soft_reset_n,u_apb_top_wrapper.u_async_apb_if_slv.u_phy_reset_sync_apb_preset.reset_sync_flop[1],u_pcs_iso_ctrl_cmn.phy_ln_soft_cdb_reset_n[0]' with matching polarities converge at ':tmp_5856', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -source_clock_domain uc_clk \
                                          -local_source_clock uc_clk \
                                          -occurrence {\:tmp_5856}] \
                                          -comment {cdb_reset & uc_soft_reset, the soft reset comes from register. No glicth risk.}

######################################################
# PMA CMN
######################################################

# "Resets 'u_pma_iso_ctrl_cmn.phy_pma_cmn_ctrl_reg[7],u_phy_reconfig_ctlr.u_phy_scan_mux_cmn_reset_n_out.fcn_signal_out' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_pll0_reset_sync_n', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.reset_pll0_reset_sync_n}] \
                                          -comment {this reset signal is cmn_reset & cmn_pll0_reset which comes from apb regsiter. No giltch risk.}

# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_diag_power_reset_n.genblk1.reset_sync_flop[1]' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.reset_cmn_tmpsns_filt_reset_n', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.reset_cmn_tmpsns_filt_reset_n}] \
                                          -comment {This Reset convergence happens at cmn reset & cmn_diag_power_reset_n, the first one reset he whole phy, the second only asserted during low power state. No glitch risk.}

######################################################
# PMA txonly0
######################################################

# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_clkrst.reset_cmn_reset_int_synced_sd_clk_n', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly0\.u_xcvr_clkrst\.reset_cmn_reset_int_synced_sd_clk_n}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset. the first one is whole phy reset. the second one is only released after phy reset, and than count for 32 reference clock cycles and wait for cmn ready.}

# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_clkrst.reset_cmn_reset_int_synced_ref_clk_n', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly0\.u_xcvr_clkrst\.reset_cmn_reset_int_synced_ref_clk_n}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset. the first one is whole phy reset. the second one is only released after phy reset, and than count for 32 reference clock cycles and wait for cmn ready.}

# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_clkrst.reset_xcvr_ref_clk_reset_n', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly0\.u_xcvr_clkrst\.reset_xcvr_ref_clk_reset_n}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset. the first one is whole phy reset. the second one is only released after phy reset, and than count for 32 reference clock cycles and wait for cmn ready.}

# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_clkrst.reset_cmn_reset_synced_pll_clk_n', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly0\.u_xcvr_clkrst\.reset_cmn_reset_synced_pll_clk_n}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset. the first one is whole phy reset. the second one is only released after phy reset, and than count for 32 reference clock cycles and wait for cmn ready.}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_clkrst.u_reset_sync_xcvr_psm_reset_n.genblk1.reset_sync_flop[1],u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_clkrst.u_reset_sync_tx_reset_n.genblk1.reset_sync_flop[1]' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.u_xcvr_ctrl.reset_xcvr_hsrrsm_tx', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly0\.u_xcvr_ctrl\.reset_xcvr_hsrrsm_tx}] \
                                          -comment {xcvr_psm_reset_n & tx_reset_sync_n. The latter has a tx_reset_n which comes from apb register. No glitch risk.}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.txda_drv_idle_lowi_en_fv', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly0\.txda_drv_idle_lowi_en_fv}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset & txda_drv_idle_lowi_en_pre_scan.}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.txda_drv_cmn_mode_en_fv', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly0\.txda_drv_cmn_mode_en_fv}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset & (txda_drv_cmn_mode_en_pre_scan | tx_cmn_mode_en_ext_gated).}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.txda_dat_buf_en_del_fv', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly0\.txda_dat_buf_en_del_fv}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset & txda_dat_buf_en_del_pre_scan}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.txda_dat_buf_en_fv', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly0\.txda_dat_buf_en_fv}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset & txda_dat_buf_en_pre_scan}

######################################################
# PMA txonly1
######################################################

# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_clkrst.reset_cmn_reset_int_synced_sd_clk_n', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly1\.u_xcvr_clkrst\.reset_cmn_reset_int_synced_sd_clk_n}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset. the first one is whole phy reset. the second one is only released after phy reset, and than count for 32 reference clock cycles and wait for cmn ready.}

# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_clkrst.reset_cmn_reset_int_synced_ref_clk_n', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly1\.u_xcvr_clkrst\.reset_cmn_reset_int_synced_ref_clk_n}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset. the first one is whole phy reset. the second one is only released after phy reset, and than count for 32 reference clock cycles and wait for cmn ready.}

# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_clkrst.reset_xcvr_ref_clk_reset_n', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly1\.u_xcvr_clkrst\.reset_xcvr_ref_clk_reset_n}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset. the first one is whole phy reset. the second one is only released after phy reset, and than count for 32 reference clock cycles and wait for cmn ready.}

# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_clkrst.reset_cmn_reset_synced_pll_clk_n', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly1\.u_xcvr_clkrst\.reset_cmn_reset_synced_pll_clk_n}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset. the first one is whole phy reset. the second one is only released after phy reset, and than count for 32 reference clock cycles and wait for cmn ready.}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_clkrst.u_reset_sync_xcvr_psm_reset_n.genblk1.reset_sync_flop[1],u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_clkrst.u_reset_sync_tx_reset_n.genblk1.reset_sync_flop[1]' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.u_xcvr_ctrl.reset_xcvr_hsrrsm_tx', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly1\.u_xcvr_ctrl\.reset_xcvr_hsrrsm_tx}] \
                                          -comment {xcvr_psm_reset_n & tx_reset_sync_n. The latter has a tx_reset_n which comes from apb register. No glitch risk.}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.txda_drv_idle_lowi_en_fv', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly1\.txda_drv_idle_lowi_en_fv}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset & txda_drv_idle_lowi_en_pre_scan.}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.txda_drv_cmn_mode_en_fv', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly1\.txda_drv_cmn_mode_en_fv}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset & (txda_drv_cmn_mode_en_pre_scan | tx_cmn_mode_en_ext_gated).}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.txda_dat_buf_en_del_fv', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly1\.txda_dat_buf_en_del_fv}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset & txda_dat_buf_en_del_pre_scan}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.txda_dat_buf_en_fv', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txm\.u_xcvr_txonly1\.txda_dat_buf_en_fv}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset & txda_dat_buf_en_pre_scan}

######################################################
# PMA txrxm1
######################################################

# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.reset_cmn_reset_int_synced_sd_clk_n', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_xcvr_clkrst\.reset_cmn_reset_int_synced_sd_clk_n}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset. the first one is whole phy reset. the second one is only released after phy reset, and than count for 32 reference clock cycles and wait for cmn ready.}

# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.reset_cmn_reset_int_synced_ref_clk_n', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_xcvr_clkrst\.reset_cmn_reset_int_synced_ref_clk_n}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset. the first one is whole phy reset. the second one is only released after phy reset, and than count for 32 reference clock cycles and wait for cmn ready.}

# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.reset_xcvr_ref_clk_reset_n', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_xcvr_clkrst\.reset_xcvr_ref_clk_reset_n}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset. the first one is whole phy reset. the second one is only released after phy reset, and than count for 32 reference clock cycles and wait for cmn ready.}

# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.reset_cmn_reset_synced_pll_clk_n', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_xcvr_clkrst\.reset_cmn_reset_synced_pll_clk_n}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset. the first one is whole phy reset. the second one is only released after phy reset, and than count for 32 reference clock cycles and wait for cmn ready.}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.u_reset_sync_tx_reset_n.genblk1.reset_sync_flop[1],u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.u_reset_sync_xcvr_psm_reset_n.genblk1.reset_sync_flop[1]' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.reset_xcvr_hsrrsm_tx', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_xcvr_ctrl\.reset_xcvr_hsrrsm_tx}] \
                                          -comment {xcvr_psm_reset_n & tx_reset_sync_n. The latter has a tx_reset_n which comes from apb register. No glitch risk.}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.u_reset_sync_rx_reset_n.genblk1.reset_sync_flop[1],u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.u_reset_sync_xcvr_psm_reset_n.genblk1.reset_sync_flop[1]' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_ctrl.xcvr_hsrrsm_rx_reset_n', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_xcvr_ctrl\.xcvr_hsrrsm_rx_reset_n}] \
                                          -comment {xcvr_psm_reset_n & rx_reset_sync_n. The latter has a tx_reset_n which comes from apb register. No glitch risk.}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.txda_drv_idle_lowi_en_fv', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.txda_drv_idle_lowi_en_fv}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset & txda_drv_idle_lowi_en_pre_scan.}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.txda_drv_cmn_mode_en_fv', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.txda_drv_cmn_mode_en_fv}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset & (txda_drv_cmn_mode_en_pre_scan | tx_cmn_mode_en_ext_gated)}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.txda_dat_buf_en_del_fv', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.txda_dat_buf_en_del_fv}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset & txda_dat_buf_en_del_pre_scan}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.txda_dat_buf_en_fv', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.txda_dat_buf_en_fv}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset & txda_dat_buf_en_pre_scan}

######################################################
# PMA txrxm2
######################################################

# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_cmn_reset_int_synced_sd_clk_n', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_clkrst\.reset_cmn_reset_int_synced_sd_clk_n}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset. the first one is whole phy reset. the second one is only released after phy reset, and than count for 32 reference clock cycles and wait for cmn ready.}

# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_cmn_reset_int_synced_ref_clk_n', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_clkrst\.reset_cmn_reset_int_synced_ref_clk_n}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset. the first one is whole phy reset. the second one is only released after phy reset, and than count for 32 reference clock cycles and wait for cmn ready.}

# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_xcvr_ref_clk_reset_n', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_clkrst\.reset_xcvr_ref_clk_reset_n}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset. the first one is whole phy reset. the second one is only released after phy reset, and than count for 32 reference clock cycles and wait for cmn ready.}

# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.reset_cmn_reset_synced_pll_clk_n', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_clkrst\.reset_cmn_reset_synced_pll_clk_n}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset. the first one is whole phy reset. the second one is only released after phy reset, and than count for 32 reference clock cycles and wait for cmn ready.}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.u_reset_sync_tx_reset_n.genblk1.reset_sync_flop[1],u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.u_reset_sync_xcvr_psm_reset_n.genblk1.reset_sync_flop[1]' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.reset_xcvr_hsrrsm_tx', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_ctrl\.reset_xcvr_hsrrsm_tx}] \
                                          -comment {xcvr_psm_reset_n & tx_reset_sync_n. The latter has a tx_reset_n which comes from apb register. No glitch risk.}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.u_reset_sync_rx_reset_n.genblk1.reset_sync_flop[1],u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.u_reset_sync_xcvr_psm_reset_n.genblk1.reset_sync_flop[1]' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_ctrl.xcvr_hsrrsm_rx_reset_n', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_ctrl\.xcvr_hsrrsm_rx_reset_n}] \
                                          -comment {xcvr_psm_reset_n & rx_reset_sync_n. The latter has a tx_reset_n which comes from apb register. No glitch risk.}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.txda_drv_idle_lowi_en_fv', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.txda_drv_idle_lowi_en_fv}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset & txda_drv_idle_lowi_en_pre_scan.}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.txda_drv_cmn_mode_en_fv', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.txda_drv_cmn_mode_en_fv}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset & (txda_drv_cmn_mode_en_pre_scan | tx_cmn_mode_en_ext_gated)}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.txda_dat_buf_en_del_fv', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.txda_dat_buf_en_del_fv}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset & txda_dat_buf_en_del_pre_scan}

#TODO
# "Resets 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_reset_sync_cmn_reset_sync.genblk1.reset_sync_flop[5],u_phy_clkrst.u_usb_link_reset_sequencer.state' with matching polarities converge at 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.txda_dat_buf_en_fv', possibly causing invalid deassertion due to glitch in the convergence point"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_CONV \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.txda_dat_buf_en_fv}] \
                                          -comment {This Reset convergence occurs at cmn_reset & xcvr_line_reset & txda_dat_buf_en_pre_scan}








######################################################
# PCS
######################################################

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_phy_state_chg_monitor_*.* \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazards with any resynchronizers in state change monitor block.  No related signals that are racing.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_phy_apb_mstr_async_if.cdb_p* \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazards with APB accesses wrt to various data synchronizers in the system.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_phy_apb_mstr_async_if.int_cdb_pready_tgl \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazards with APB accesses wrt to various data synchronizers in the system.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_pcs_iso_ctrl_ln_*.u_psync_pipe_mb_tx_deemph_chg_stb.data_toggle \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazards with APB accesses wrt to various data synchronizers in the system. There's a operation sequence.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_pcs_iso_ctrl_ln_*.u_psync_pipe_mb_tx_deemph_chg_stb.data_a \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazards with APB accesses wrt to various data synchronizers in the system. There's a operation sequence.}

######################################################
# PMA CMN
######################################################

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_cmn_clk_freq_msmt_v1_top.u_clk_freq_msmt_v1.test_cnt_ack \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_pll_var_trm_wrapper.u_pll_var_trm.u_fbdiv_clk_high_freq_counter.accumulator \
                                          -tag CNV_ST_CONV] \
                                          -comment {no convergence hazard.  There is no relative relationship between the converging signals.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_pll_var_trm_wrapper.u_pll_var_trm.u_fbdiv_clk_low_freq_counter.accumulator \
                                          -tag CNV_ST_CONV] \
                                          -comment {no convergence hazard.  There is no relative relationship between the converging signals.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_pll_var_trm_wrapper.u_pll_var_trm.u_vco_cal_sm_v4_var_trm.pcnt_current_state \
                                          -tag CNV_ST_CONV] \
                                          -comment {no convergence hazard.  There is no relative relationship between the converging signals.}
                                         
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_pll_var_trm_wrapper.u_pll_var_trm.u_vco_cal_sm_v4_var_trm.init_previous_clk_difference \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_pll_var_trm_wrapper.u_pll_var_trm.u_vco_cal_sm_v4_var_trm.pllcnt* \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_pll_var_trm_wrapper.u_pll_var_trm.u_vco_cal_sm_v4_var_trm.previous_clk_difference \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_vco_cal_sm_v4_top.u_vco_cal_sm_v4.previous_clk_difference \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_vco_cal_sm_v4_top.u_vco_cal_sm_v4.pcnt_current_state \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_sd_clk_cal_icfg.u_vco_cal_sm_v4_top.u_vco_cal_sm_v4.pcnt_current_state \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.*.u_vco_cal_sm_v4.init_previous_clk_difference \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.*.u_vco_cal_sm_v4.first_check \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.*.u_vco_cal_sm_v4.previous_pllclk_gr_eq \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.*.u_vco_cal_sm_v4.u_step_size_controller.accumulator \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.*.u_vco_cal_sm_v4.u_vco_code_counter.accumulator \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.*.u_vco_cal_sm_v4.vc_current_state* \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_multical_sm_v3_pll_cal.*.u_cdnsdru_multical_state_flop.curr_run \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals to the curr_run F/Fs in the multical FSM.}


#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_vco_cal_sm_v4_top.u_vco_cal_sm_v4.current_clk_difference_greater \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}


check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_pll_lock_detect_v4_top.u_pll_lock_detect_v4.pll_lock_det_en_ack \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.*.u_vco_cal_sm_v4.pllcnt* \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.*.u_vco_cal_sm_v4.previous_clk_difference \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.cmn_ref_clk_active_sr_flop \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals. The source signals come from apb register.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana.txda1_rcvdet_ref_clk \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals. one logic of this is clock which has ICG and the enable comes from apb register. Another logic of this is enbale which comes from the same apb register.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_cmn.u_cmn_func.u_sd_clk_cal_icfg.u_vco_cal_sm_v4_top.u_vco_cal_sm_v4.current_clk_difference_greater \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_pll_var_trm_wrapper.u_pll_var_trm.u_vco_cal_sm_v4_var_trm.u_vco_code_counter.accumulator* \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}
#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_pll_var_trm_wrapper.u_pll_var_trm.u_vco_cal_sm_v4_var_trm.first_check \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_pll_var_trm_wrapper.u_pll_var_trm.u_vco_cal_sm_v4_var_trm.previous_pllclk_gr_eq \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_pll_var_trm_wrapper.u_pll_var_trm.u_vco_cal_sm_v4_var_trm.vc_current_state* \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_pll_var_trm_wrapper.u_pll_var_trm.u_vco_cal_sm_v4_var_trm.u_step_size_controller.accumulator* \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_cmn.u_cmn_pll0_ctrl.u_pll_ctrl.u_pll_var_trm_wrapper.u_pll_var_trm.u_vco_cal_sm_v4_var_trm.current_clk_difference_greater \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

 
######################################################
# PMA txonly0
######################################################
#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_xcvr_txm.st_dcc_run_current_state* \
                                          -tag CNV_ST_CONV] \
                                          -comment {This SM uses txda0_dc_comp_out & txda1_dc_comp_out. Both come from Analog circut.}





######################################################
# PMA txonly1
######################################################




######################################################
# PMA txrxm1
######################################################
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_cmn_clk_freq_msmt_v1_top.u_clk_freq_msmt_v1.test_cnt_ack \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.hfsig_none_high2_d1r \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals. Two convergence signals come from Analog.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.hfsig_none_high_d1r \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals. Two convergence signals come from Analog.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.hfsig_none_low2_d1r\
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals. Two convergence signals come from Analog.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.hfsig_none_low_d1r \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals. Two convergence signals come from Analog.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.hfsig_raw2_d1 \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals. Two convergence signals come from Analog.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.pulse_high_rising_or_hf_d2 \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals. Two convergence signals come from Analog.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.pulse_low_rising_or_hf_d2 \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals. Two convergence signals come from Analog.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.u_min_pulse_high_filter.illegal_none_d1 \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals. Two convergence signals come from Analog.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.u_min_pulse_low_filter.illegal_none_d1 \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals. Two convergence signals come from Analog.}


  
######################################################
# PMA txrxm2
######################################################
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_cmn_clk_freq_msmt_v1_top.u_clk_freq_msmt_v1.test_cnt_ack \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.hfsig_none_high2_d1r \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals. Two convergence signals come from Analog.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.hfsig_none_high_d1r \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals. Two convergence signals come from Analog.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence  u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.hfsig_none_low2_d1r\
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals. Two convergence signals come from Analog.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.hfsig_none_low_d1r \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals. Two convergence signals come from Analog.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.hfsig_raw2_d1 \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals. Two convergence signals come from Analog.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.pulse_high_rising_or_hf_d2 \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals. Two convergence signals come from Analog.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.pulse_low_rising_or_hf_d2 \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals. Two convergence signals come from Analog.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.u_min_pulse_high_filter.illegal_none_d1 \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals. Two convergence signals come from Analog.}

#New added
check_cdc -waiver -add -filter [check_cdc -filter -add \
                                          -occurrence u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_rx_ctrl.u_rx_lfps_det_filter_top_icfg.u_rx_lfps_det_filter_v0_top.u_rx_lfps_det_filter_v0.u_min_pulse_low_filter.illegal_none_d1 \
                                          -tag CNV_ST_CONV] \
                                          -comment {No convergence hazard.  There is no relative relationship between the converging signals. Two convergence signals come from Analog.}





# "Clock pin of flop 'u_phy_state_chg_monitor_dp.pipe_phy_status_tgl' has a constant value"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag FLP_CK_CNST \
                                          -local_source_clock {u_phy_state_chg_monitor_dp\.pipe_phy_status} \
                                          -occurrence {u_phy_state_chg_monitor_dp\.pipe_phy_status_tgl}] \
                                          -comment {This module is used for USB & DP, the pipe_status is tied off because of DP mode.}

######################################################
# PMA txrxm1
######################################################

# "Clock pin of flop 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.u_clk_gating_cell_rx_rd_clk_2x.genblk1.u_data_sync_en_sync.genblk1.data_sync_flop' has a constant value"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag FLP_CK_CNST \
                                          -local_source_clock {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_xcvr_clkrst\.rxda_des_clk_2x} \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_xcvr_clkrst\.u_clk_gating_cell_rx_rd_clk_2x\.genblk1\.u_data_sync_en_sync\.genblk1\.data_sync_flop}] \
                                          -comment {This's rxda_des_clk_2x which is not used in the PHY.}

# "Clock pin of flop 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1.u_xcvr_clkrst.u_reset_sync_rx_dig_reset_scanned_2x_n.genblk1.reset_sync_flop' has a constant value"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag FLP_CK_CNST \
                                          -local_source_clock {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_xcvr_clkrst\.rxda_des_clk_2x} \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane1\.u_xcvr_clkrst\.u_reset_sync_rx_dig_reset_scanned_2x_n\.genblk1\.reset_sync_flop}] \
                                          -comment {This's rxda_des_clk_2x which is not used in the PHY.}

######################################################
# PMA txrxm2
######################################################
# "Clock pin of flop 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.u_clk_gating_cell_rx_rd_clk_2x.genblk1.u_data_sync_en_sync.genblk1.data_sync_flop' has a constant value"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag FLP_CK_CNST \
                                          -local_source_clock {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_clkrst\.rxda_des_clk_2x} \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_clkrst\.u_clk_gating_cell_rx_rd_clk_2x\.genblk1\.u_data_sync_en_sync\.genblk1\.data_sync_flop}] \
                                          -comment {This's rxda_des_clk_2x which is not used in the PHY.}

# "Clock pin of flop 'u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane2.u_xcvr_clkrst.u_reset_sync_rx_dig_reset_scanned_2x_n.genblk1.reset_sync_flop' has a constant value"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag FLP_CK_CNST \
                                          -local_source_clock {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_clkrst\.rxda_des_clk_2x} \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_xcvr_txrxm_lane2\.u_xcvr_clkrst\.u_reset_sync_rx_dig_reset_scanned_2x_n\.genblk1\.reset_sync_flop}] \
                                          -comment {This's rxda_des_clk_2x which is not used in the PHY.}






# "Reset condition of flop 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_clock_div_prog_ssm_clk.clock_div_cnt' might not be asserted, keeping it stuck at run state"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag FLP_NO_INIT \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_clock_div_prog_ssm_clk\.clock_div_cnt} \
                                          -local_destination_clock {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_clk_gating_cell_pre_ref_clk_div\.clk_out} \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_clock_div_prog_ssm_clk\.clock_div_cnt}] \
                                          -comment {When the cmn_reset_n released, the clock is stable and there is a cmn_ref_clk_disable to control it.}

# "Reset condition of flop 'u_mp_pma.u_pma_rev.u_cmn.u_cmn_clkrst.u_clock_div_prog_ssm_clk.clock_div' might not be asserted, keeping it stuck at run state"
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag FLP_NO_INIT \
                                          -destination_clock_domain pma_cmn_refclk0_int \
                                          -destination_unit {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_clock_div_prog_ssm_clk\.clock_div} \
                                          -local_destination_clock {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_clk_gating_cell_pre_ref_clk_div\.clk_out} \
                                          -occurrence {u_mp_pma\.u_pma_rev\.u_cmn\.u_cmn_clkrst\.u_clock_div_prog_ssm_clk\.clock_div}] \
                                          -comment {When the cmn_reset_n released, the clock is stable and there is a cmn_ref_clk_disable to control it.}
