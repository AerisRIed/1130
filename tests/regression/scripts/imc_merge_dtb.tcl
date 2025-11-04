
# © 2020 Cadence Design Systems, Inc. All rights reserved worldwide.
# 
# ----------------------------------------
# 
# This file is being provided as part of a reference example to showcase
# Cadence's JasperGold integration methodology. They are the proprietary
# and confidential information of Cadence or its licensors, and are supplied
# subject to, and may be used only by Cadence's customer in accordance with a
# previously executed agreements between Cadence and that customer.
# 
# Further, they may only be used with JasperGold and cannot be used with any
# other Formal Verification Tools.
# 
# ALL MATERIALS FURNISHED BY CADENCE HEREUNDER ARE PROVIDED "AS IS" WITHOUT
# WARRANTY OF ANY KIND, AND CADENCE SPECIFICALLY DISCLAIMS ANY WARRANTY OF
# NONINFRINGEMENT, FITNESS FOR A PARTICULAR PURPOSE OR MERCHANTABILITY.
# CADENCE SHALL NOT BE LIABLE FOR ANY COSTS OF PROCUREMENT OF SUBSTITUTES,
# LOSS OF PROFITS, INTERRUPTION OF BUSINESS, OR FOR ANY OTHER SPECIAL,
# CONSEQUENTIAL OR INCIDENTAL DAMAGES, HOWEVER CAUSED, WHETHER FOR BREACH OF
# WARRANTY, CONTRACT, TORT, NEGLIGENCE, STRICT LIABILITY OR OTHERWISE.
# 
# ----------------------------------------

merge_config -source cdn_sd2101_t3gp_vs133_1xah1xbv1xch1xdv1yah1ybv4yhvhv2yy2z  -target  cdn_eusb2v2_tb_top.cdns_eusb2v2_phy_top
config  merge.union_icc_jg_merge -set true 

merge /projects/sd2101_tsmcn3p_fe/users/swenchen/eco_branch/eUSB2V2_TSMCN3/verif/vm/cov_work/scope/combined3/  /projects/sd2101_tsmcn3p_fe/users/swenchen/eco_branch/eUSB2V2_TSMCN3/verif/formal/cov_work/scope/pcs_iso/ -out combined_dtb -cross_domain icc:jg -metrics all -initial_model union_all -overwrite -message 1 -force_merge_versions
