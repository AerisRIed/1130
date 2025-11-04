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

merge_config -sourcetype cdn_sd2101_i3p765_vm130_6x2ya2yb2yc2yd1ye1ga1gb  -target cdn_eusb2v2_tb_top.cdns_eusb2v2_phy_top


config  merge.union_icc_jg_merge -set true 


merge /rscratch/general/nawang/Regression_dir/eusb2v2/results/cdn_eusb2v2_phy_vm_i3_full_upf_cov_session.nawang.25_05_07_09_10_14_1161/merged_ucds/default/1746590606198/merged_tests/  /rscratch/general/nawang/Regression_dir/eusb2v2/results/cdn_eusb2v2_phy_full_session_i3_wreal_speedup_cal_cov.nawang.25_05_01_21_18_58_8918/merged_ucds/default/1746247499334/merged_tests/ -out combined_vm -cross_domain icc:jg -metrics all -initial_model union_all -overwrite -message 1 -force_merge_versions 


merge_config -sourcetype cdn_sd2101_i3p765_vm130_6x2ya2yb2yc2yd1ye1ga1gb  -target cdn_eusb2v2_tb_top.cdns_eusb2v2_phy_top


config  merge.union_icc_jg_merge -set true 

merge /projects/sd2101_tsmcn3p_fe/users/swenchen/eUSB2V2_TSMCN3/verif/vm/cov_work/scope/combined_vm /rscratch/general/nawang/Regression_dir/eusb2v2/results/cdn_eusb2v2_phy_full_session_hlm_i3_cov.nawang.25_04_29_22_25_42_8377/merged_ucds/default/1745963163453/merged_tests/  -out combined_vm_2 -cross_domain icc:jg -metrics all -initial_model union_all -overwrite -message 1 -force_merge_versions

merge_config -sourcetype cdn_sd2101_i3p765_vm130_6x2ya2yb2yc2yd1ye1ga1gb  -target cdn_eusb2v2_tb_top.cdns_eusb2v2_phy_top


config  merge.union_icc_jg_merge -set true 

merge /projects/sd2101_tsmcn3p_fe/users/swenchen/eUSB2V2_TSMCN3/verif/vm/cov_work/scope/combined_vm_2 /rscratch/general/nawang/Regression_dir/eusb2v2/results/cdn_eusb2v2_phy_full_session_mlm_i3_cov.nawang.25_05_01_21_28_56_5433/merged_ucds/default/1746457392605/merged_tests/  -out combined_vm_all -cross_domain icc:jg -metrics all -initial_model union_all -overwrite -message 1 -force_merge_versions
