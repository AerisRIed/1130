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
# Copyright (C) 2000-2024 Cadence Design Systems, Inc. All Rights
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

##############################################################
#errors waiver
##############################################################
#
# "Unequal length operands in assignment in design-unit/block 'cdnsdru_eye_surf_sm_v2'. Length of RHS is less than LHS. LHS 'eye_surf_max_test_points' (unsigned) - 16 bit(s), RHS '{{(16 - COORD_EW_OFFSET_WIDTH){1'b0}},eye_surf_coord_ns_offset}' (unsigned) - 14 bit(s). RHS will be padded by 2 bit(s)."
check_superlint -waiver -add -module { cdnsdru_eye_surf_sm_v2 } -tag ASG_MS_RPAD -arg { cdnsdru_eye_surf_sm_v2 eye_surf_max_test_points unsigned 16 {\{\{(16 - COORD_EW_OFFSET_WIDTH)\{1'b0\}\},eye_surf_coord_ns_offset\}} unsigned 14 2 } -comment { reuse eyesurf error } -persistency_data { AAAAlHicZYpBCsAgDATnSWr9j7R68CSlQqm/7xq8lG4Ik2UCv1xkCo1EFzc8TvuoNyKnGDSJW97LO93T71TjITOZVy/Wx/LDfBSrODfo55MXoeoUfA== }

# "Output/inout 'xcvr_scanout[89:1]' is not fully driven in the design-unit 'xcvr_txonly'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txm.u_xcvr_txonly0 } -tag OTP_NO_FDRV -arg { xcvr_scanout[89:1] xcvr_txonly } -comment { DFT TODO, wave first } -persistency_data { AAAAlHicZYrBCoAgEERff6Tm/0jpwZNEQeTfNysegmZZ3g5v4ZeTTKGRuMQVj9M+6o3IIQZN4pb38k63+Y06uMsY8+xl9D59Hz6KVbQN+vlmeQGh6xR9 }

# "Output/inout 'xcvr_scanout[89:4]' is not fully driven in the design-unit 'xcvr_txrxm'"
check_superlint -waiver -add -instance { u_mp_pma.u_pma_rev.u_xcvr_txrxm_lane1 } -tag OTP_NO_FDRV -arg { xcvr_scanout[89:4] xcvr_txrxm } -comment { DFT TODO, wave first } -persistency_data { AAAAlHicZYrBCoAgEERff6Tm/0jpwZNEQeTfNysegmZZ3g5v4ZeTTKGRuMQVj9M+6o3IIQZN4pb38k63+Y06uMsY8+xl9D59Hz6KVbQN+vlmeQGh6xR9 }


# "Wire 'cdb_pread_sel_00011_unused' declared in module 'cdnsdru_eye_surf_ctrl_cdb_regs_v2' is unused (neither read nor assigned)"
check_superlint -waiver -add -module { cdnsdru_eye_surf_ctrl_cdb_regs_v2 } -tag WIR_NO_USED -arg { cdb_pread_sel_00011_unused module cdnsdru_eye_surf_ctrl_cdb_regs_v2 } -comment { clerical error  } -persistency_data { AAAAlHicZYpBCsAgDATnSWr9j7R68CSlQqm/7xq8lG4Ik2UCv1xkCo1EFzc8TvuoNyKnGDSJW97LO93T71TjITOZVy/Wx/LDfBSrODfo55MXoeoUfA== }


#pma rx
check_superlint -waiver -add  -module xcvr_txonly  -tag CLK_NO_INPT  -comment {Original clock design from Whistler/torrent}  -force
check_superlint -waiver -add  -module xcvr_txrxm   -tag CLK_NO_INPT  -comment {Original clock design from Whistler/torrent}  -force
check_superlint -waiver -add  -module xcvr_clkrst  -tag CLK_NO_INPT  -comment {Original clock design from Whistler/torrent}  -force
check_superlint -waiver -add  -module xcvr_ctrl    -tag RST_IS_DCMB  -comment {Original clock design from Whistler/torrent, reset will be sync after combination logics}  -force
check_superlint -waiver -add  -module xcvr_clkrst  -tag RST_IS_DCMB  -comment {Original clock design from Whistler/torrent, reset will be sync after combination logics}  -force


##############################################################
#warnings waiver
##############################################################


check_superlint -waiver -add  -module tx_coef_calc_cdb_regs -tag WIR_NO_READ  -comment {unused register field or readonly register not need to write}  -force
check_superlint -waiver -add  -module tx_coef_calc -tag WIR_NO_READ  -comment {unused register field or readonly register not need to write}  -force
check_superlint -waiver -add  -module cdnsdru_power_sm_v4_cdb_regs -tag WIR_NO_READ  -comment {unused register field or readonly register not need to write}  -force
check_superlint -waiver -add  -module drv_ctrl_diag_ovrd -tag WIR_NO_READ  -comment {unused register field or readonly register not need to write}  -force



