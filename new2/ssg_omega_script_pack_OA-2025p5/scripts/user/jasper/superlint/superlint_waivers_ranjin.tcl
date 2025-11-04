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

# IMPORTANT: please do not modify.
set_superlint_waiver_persistency_version 2

# "Bit/part select of integer variable 'ANA_CTRL_BIT_WIDTH' encountered"
check_superlint -waiver -add -module { cdnsdru_hbdc_distributor } -tag INT_NR_PSBT -arg { integer ANA_CTRL_BIT_WIDTH } -comment { legacy from the total_emph_segments signal in cdndru_hbdc_v5_half_v0.v }

# "Net 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.txda_drv_mgn_odd_pre_scan' declared in design-unit 'xcvr_txonly' has no driver but has at least one load"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0 } -tag NET_NO_DRIV -arg { u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.txda_drv_mgn_odd_pre_scan xcvr_txonly } -comment { txonly obsolete }

# "Net 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.txda_drv_mgn_odd_pre_scan' declared in design-unit 'xcvr_txonly' has no driver but has at least one load"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1 } -tag NET_NO_DRIV -arg { u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.txda_drv_mgn_odd_pre_scan xcvr_txonly } -comment { txonly obsolete }

# "Net 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.txda_lfps_sel' declared in design-unit 'xcvr_txonly' neither has driver nor any load"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0 } -tag NET_NO_LDDR -arg { u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.txda_lfps_sel xcvr_txonly } -comment { txonly obsolete }

# "Net 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.txda_lfps_sel' declared in design-unit 'xcvr_txonly' neither has driver nor any load"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1 } -tag NET_NO_LDDR -arg { u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.txda_lfps_sel xcvr_txonly } -comment { txonly obsolete }

# "Net 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.txda_drv_group1_emp_odd_pre_scan' declared in design-unit 'xcvr_txonly' neither has driver nor any load"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0 } -tag NET_NO_LDDR -arg { u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.txda_drv_group1_emp_odd_pre_scan xcvr_txonly } -comment { txonly obsolete }

# "Net 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.txda_drv_group1_emp_odd_pre_scan' declared in design-unit 'xcvr_txonly' neither has driver nor any load"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1 } -tag NET_NO_LDDR -arg { u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.txda_drv_group1_emp_odd_pre_scan xcvr_txonly } -comment { txonly obsolete }

# "Bit/part select of integer variable 'ANA_CTRL_BIT_WIDTH' encountered"
check_superlint -waiver -add -module { cdnsdru_hbdc_distributor } -tag INT_NR_PSBT -arg { integer ANA_CTRL_BIT_WIDTH } -comment { legacy from cdnsdru_hbdc_v5_half_v0.v }

# "Net 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.txda_drv_mgn_odd_pre_scan' declared in design-unit 'xcvr_txonly' has no driver but has at least one load"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0 } -tag NET_NO_DRIV -arg { u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.txda_drv_mgn_odd_pre_scan xcvr_txonly } -comment { txonly obsolete }

# "Net 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.txda_drv_mgn_odd_pre_scan' declared in design-unit 'xcvr_txonly' has no driver but has at least one load"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1 } -tag NET_NO_DRIV -arg { u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.txda_drv_mgn_odd_pre_scan xcvr_txonly } -comment { txonly obsolete }

# "Net 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.txda_drv_group1_emp_odd_pre_scan' declared in design-unit 'xcvr_txonly' neither has driver nor any load"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0 } -tag NET_NO_LDDR -arg { u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0.txda_drv_group1_emp_odd_pre_scan xcvr_txonly } -comment { txonly obsolete }

# "Net 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.txda_drv_group1_emp_odd_pre_scan' declared in design-unit 'xcvr_txonly' neither has driver nor any load"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1 } -tag NET_NO_LDDR -arg { u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly1.txda_drv_group1_emp_odd_pre_scan xcvr_txonly } -comment { txonly obsolete }

# "Input port 'txda0_drv_post_emp_odd' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda0_drv_post_emp_odd txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda0_drv_pre_emp_odd' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda0_drv_pre_emp_odd txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group0_emp_end' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group0_emp_end txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group0_emp_start' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group0_emp_start txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group0_emp_zero' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group0_emp_zero txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group0_main_start' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group0_main_start txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group0_main_zero' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group0_main_zero txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group0_mgn_zero' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group0_mgn_zero txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group1_emp_end' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group1_emp_end txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group1_emp_start' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group1_emp_start txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group1_main_start' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group1_main_start txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group1_main_zero' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group1_main_zero txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group1_mgn_zero' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group1_mgn_zero txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group2_emp_end' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group2_emp_end txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group2_emp_start' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group2_emp_start txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group2_emp_zero' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group2_emp_zero txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group2_main_start' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group2_main_start txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group2_main_zero' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group2_main_zero txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group2_mgn_zero' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group2_mgn_zero txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group3_emp_end' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group3_emp_end txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group3_emp_start' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group3_emp_start txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group3_main_start' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group3_main_start txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group3_main_zero' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group3_main_zero txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group3_mgn_zero' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group3_mgn_zero txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group4_emp_end' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group4_emp_end txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group4_emp_start' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group4_emp_start txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group4_emp_zero' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group4_emp_zero txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group4_main_start' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group4_main_start txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group4_main_zero' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group4_main_zero txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_group4_mgn_zero' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_group4_mgn_zero txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_pre1_emp_odd' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_pre1_emp_odd txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_pre2_emp_odd' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_pre2_emp_odd txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Input port 'txda1_drv_pre_emp_odd' of design-unit 'txm_ana' is being used inside design-unit, but not connected in its instance 'u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag INP_UC_INST -arg { txda1_drv_pre_emp_odd txm_ana u_mp_pma.u_pma_rev.u_xcvr_txm.u_txm_ana } -comment { txonly obsolete }

# "Port 'txda0_drv_pre2_emp_end' has size mismatch between design-unit instantiation and port declaration, '4' bits at instantiation and '2' bits at declaration"
check_superlint -waiver -add -module { xcvr_txm } -tag INS_MS_PSIZ -arg { txda0_drv_pre2_emp_end 4 2 } -comment { txonly obsolete }

# "Port 'txda0_drv_pre2_emp_start' has size mismatch between design-unit instantiation and port declaration, '4' bits at instantiation and '2' bits at declaration"
check_superlint -waiver -add -module { xcvr_txm } -tag INS_MS_PSIZ -arg { txda0_drv_pre2_emp_start 4 2 } -comment { txonly obsolete }

# "Port 'txda0_drv_pre2_main_start' has size mismatch between design-unit instantiation and port declaration, '4' bits at instantiation and '2' bits at declaration"
check_superlint -waiver -add -module { xcvr_txm } -tag INS_MS_PSIZ -arg { txda0_drv_pre2_main_start 4 2 } -comment { txonly obsolete }

# "Port 'txda1_drv_pre2_emp_end' has size mismatch between design-unit instantiation and port declaration, '4' bits at instantiation and '2' bits at declaration"
check_superlint -waiver -add -module { xcvr_txm } -tag INS_MS_PSIZ -arg { txda1_drv_pre2_emp_end 4 2 } -comment { txonly obsolete }

# "Port 'txda1_drv_pre2_emp_start' has size mismatch between design-unit instantiation and port declaration, '4' bits at instantiation and '2' bits at declaration"
check_superlint -waiver -add -module { xcvr_txm } -tag INS_MS_PSIZ -arg { txda1_drv_pre2_emp_start 4 2 } -comment { txonly obsolete }

# "Port 'txda1_drv_pre2_main_start' has size mismatch between design-unit instantiation and port declaration, '4' bits at instantiation and '2' bits at declaration"
check_superlint -waiver -add -module { xcvr_txm } -tag INS_MS_PSIZ -arg { txda1_drv_pre2_main_start 4 2 } -comment { txonly obsolete }

# "Bit/part select of integer variable 'ANA_CTRL_BIT_WIDTH' encountered"
check_superlint -waiver -add -module { cdnsdru_hbdc_distributor } -tag INT_NR_PSBT -arg { integer ANA_CTRL_BIT_WIDTH } -comment { legacy from cdnsdru_hbdc_v5_half_v0.v }

# "Wire 'txda_drv_group1_emp_odd_pre_scan' declared in module 'xcvr_txonly' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { xcvr_txonly } -tag WIR_NO_USED -arg { txda_drv_group1_emp_odd_pre_scan module xcvr_txonly } -comment { txonly obsolete }

# "Wire 'txda_lfps_sel' declared in module 'xcvr_txonly' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { xcvr_txonly } -tag WIR_NO_USED -arg { txda_lfps_sel module xcvr_txonly } -comment { txonly obsolete }

# "Wire 'txda_drv_seg_main_odd' declared in module 'xcvr_txrxm' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { xcvr_txrxm } -tag WIR_NO_USED -arg { txda_drv_seg_main_odd module xcvr_txrxm } -comment { used by old lib file }

# "Wire 'txda_drv_seg_pre1_emp_odd' declared in module 'xcvr_txrxm' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { xcvr_txrxm } -tag WIR_NO_USED -arg { txda_drv_seg_pre1_emp_odd module xcvr_txrxm } -comment { used by old lib file }

# "Wire 'txda_drv_seg_pre2_emp_odd' declared in module 'xcvr_txrxm' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { xcvr_txrxm } -tag WIR_NO_USED -arg { txda_drv_seg_pre2_emp_odd module xcvr_txrxm } -comment { used by old lib file }

# "Wire 'txda_drv_seg_post_emp_odd' declared in module 'xcvr_txrxm' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { xcvr_txrxm } -tag WIR_NO_USED -arg { txda_drv_seg_post_emp_odd module xcvr_txrxm } -comment { used by old lib file }

# "Wire 'txda_drv_seg_mgn_odd' declared in module 'xcvr_txrxm' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { xcvr_txrxm } -tag WIR_NO_USED -arg { txda_drv_seg_mgn_odd module xcvr_txrxm } -comment { used by old lib file }

# "Net 'u_mp_pma.u_pma_rev.u_xcvr_txm.txda0_drv_pre_emp_odd' declared in design-unit 'xcvr_txm' has no driver but has at least one load"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag NET_NO_DRIV -arg { u_mp_pma.u_pma_rev.u_xcvr_txm.txda0_drv_pre_emp_odd xcvr_txm } -comment { txonly obsolete }

# "Net 'u_mp_pma.u_pma_rev.u_xcvr_txm.txda1_drv_pre_emp_odd' declared in design-unit 'xcvr_txm' has no driver but has at least one load"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm } -tag NET_NO_DRIV -arg { u_mp_pma.u_pma_rev.u_xcvr_txm.txda1_drv_pre_emp_odd xcvr_txm } -comment { txonly obsolete }

