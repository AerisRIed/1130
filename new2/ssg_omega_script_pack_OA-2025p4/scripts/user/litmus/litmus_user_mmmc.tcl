################################################################################
# Copyright (c) 2024 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design #
# Systems Inc. They may not be modified, copied, reproduced, distributed, or   #
# disclosed to third parties in any manner, medium, or form, in whole or in    #
# part, without the prior written consent of Cadence Design Systems Inc.       #
################################################################################

#########################################################
# This file serves as an example MMMC configuration.	#
# Either this exact file or a project-specific version	#
# correlating to the SDC under analysis can be read in	#
# to Litmus by setting "use_mmmc" to 1 and keeping a	#
# file with this name in the scripts/user directory.	#
# At a minimum a MMMC file must contain one each of	#
# the following commands:				#
# create_library_set					#
# create_rc_corner					#
# create_timing_condition				#
# create_delay_corner					#
# create_constraint_mode				#
# create_analysis_view					#
# set_analysis_view					#
#########################################################

#########################################################
# Root directories for file paths			#
#########################################################

set N5_base_svt_root      "/cad/library/tsmc/tsmc5/tcbn05_bwph210l6p51cnod_base_svt/TSMCHOME/digital/Front_End/LVF/CCS/tcbn05_bwph210l6p51cnod_base_svt_120a"
set N5_mb_svt_root        "/cad/library/tsmc/tsmc5/tcbn05_bwph210l6p51cnod_mb_svt/TSMCHOME/digital/Front_End/LVF/CCS/tcbn05_bwph210l6p51cnod_mb_svt_120a"
set N5_pm_svt_root        "/cad/library/tsmc/tsmc5/tcbn05_bwph210l6p51cnod_pm_svt/TSMCHOME/digital/Front_End/LVF/CCS/tcbn05_bwph210l6p51cnod_pm_svt_120a"
set N5_base_svt_socv_root "/cad/library/tsmc/tsmc5/tcbn05_bwph210l6p51cnod_base_svt/TSMCHOME/digital/Front_End/timing_margin/SPM/socv/tcbn05_bwph210l6p51cnod_base_svt_120b"
set N5_mb_svt_socv_root   "/cad/library/tsmc/tsmc5/tcbn05_bwph210l6p51cnod_mb_svt/TSMCHOME/digital/Front_End/timing_margin/SPM/socv/tcbn05_bwph210l6p51cnod_mb_svt_120b"
set N5_pm_svt_socv_root   "/cad/library/tsmc/tsmc5/tcbn05_bwph210l6p51cnod_pm_svt/TSMCHOME/digital/Front_End/timing_margin/SPM/socv/tcbn05_bwph210l6p51cnod_pm_svt_120b"
set N5_analog_root        "/fac/vol15/gerstner/internal_support/dmasters/analog_etms/nldm"
set N5_qrc_root           "/cad/library/tsmc/tsmc5/tech_package/qrc/1p16m_1x1xb1xe1ya1yb6y2yy2r/1d2p1"
set N5_sdc_root           "/fac/vol15/gerstner/internal_support/dmasters/litmus_golden_sdc_analysis/local_sdc"

#########################################################
# MMMC commands						#
#########################################################

create_library_set -name libset_WCL_SVT \
    -timing [list $N5_base_svt_root/tcbn05_bwph210l6p51cnod_base_svtssgnp_0p675v_m40c_cworst_CCworst_T_hm_lvf_p_ccs.lib \
                  $N5_mb_svt_root/tcbn05_bwph210l6p51cnod_mb_svtssgnp_0p675v_m40c_cworst_CCworst_T_hm_lvf_p_ccs.lib \
	          $N5_pm_svt_root/tcbn05_bwph210l6p51cnod_pm_svtssgnp_0p675v_m40c_cworst_CCworst_T_hm_lvf_p_ccs.lib \
	          $N5_analog_root/xcvr_ana.ssgnp_0p675v_m40c.lib] \
    -socv [list $N5_base_svt_socv_root/tcbn05_bwph210l6p51cnod_base_svtssgnp_0p675v_m40c_cworst_CCworst_T_sp.socv \
                $N5_mb_svt_socv_root/tcbn05_bwph210l6p51cnod_mb_svtssgnp_0p675v_m40c_cworst_CCworst_T_sp.socv \
		$N5_pm_svt_socv_root/tcbn05_bwph210l6p51cnod_pm_svtssgnp_0p675v_m40c_cworst_CCworst_T_sp.socv]

create_library_set -name libset_TC_SVT \
    -timing [list $N5_base_svt_root/tcbn05_bwph210l6p51cnod_base_svttt_0p75v_85c_typical_hm_lvf_p_ccs.lib \
                  $N5_mb_svt_root/tcbn05_bwph210l6p51cnod_mb_svttt_0p75v_85c_typical_hm_lvf_p_ccs.lib \
                  $N5_pm_svt_root/tcbn05_bwph210l6p51cnod_pm_svttt_0p75v_85c_typical_hm_lvf_p_ccs.lib \
                  $N5_analog_root/xcvr_ana.tt_0p75v_85c.lib] \
    -socv [list $N5_base_svt_socv_root/tcbn05_bwph210l6p51cnod_base_svttt_0p75v_85c_typical_sp.socv \
                $N5_mb_svt_socv_root/tcbn05_bwph210l6p51cnod_mb_svttt_0p75v_85c_typical_sp.socv \
                $N5_pm_svt_socv_root/tcbn05_bwph210l6p51cnod_pm_svttt_0p75v_85c_typical_sp.socv]

create_library_set -name libset_ML_SVT \
    -timing [list $N5_base_svt_root/tcbn05_bwph210l6p51cnod_base_svtffgnp_0p825v_125c_cbest_CCbest_T_hm_lvf_p_ccs.lib \
                  $N5_mb_svt_root/tcbn05_bwph210l6p51cnod_mb_svtffgnp_0p825v_125c_cbest_CCbest_T_hm_lvf_p_ccs.lib \
                  $N5_pm_svt_root/tcbn05_bwph210l6p51cnod_pm_svtffgnp_0p825v_125c_cbest_CCbest_T_hm_lvf_p_ccs.lib \
                  $N5_analog_root/xcvr_ana.ffgnp_0p825v_125c.lib] \
    -socv [list $N5_base_svt_socv_root/tcbn05_bwph210l6p51cnod_base_svtffgnp_0p825v_125c_cbest_CCbest_T_sp.socv \
                $N5_mb_svt_socv_root/tcbn05_bwph210l6p51cnod_mb_svtffgnp_0p825v_125c_cbest_CCbest_T_sp.socv \
                $N5_pm_svt_socv_root/tcbn05_bwph210l6p51cnod_pm_svtffgnp_0p825v_125c_cbest_CCbest_T_sp.socv]

create_rc_corner -name rc_cworst_CCworst_T -qrc_tech [list $N5_qrc_root/cworst/Tech/cworst_CCworst_T/qrcTechFile] -temperature -40
create_rc_corner -name rc_typical -qrc_tech [list $N5_qrc_root/typical/Tech/typical/qrcTechFile] -temperature 85
create_rc_corner -name rc_cbest_CCbest -qrc_tech [list $N5_qrc_root/cbest/Tech/cbest_CCbest/qrcTechFile] -temperature 125

create_timing_condition -name timing_condition_WCL -library_sets libset_WCL_SVT
create_timing_condition -name timing_condition_TC -library_sets libset_TC_SVT
create_timing_condition -name timing_condition_ML -library_sets libset_ML_SVT

create_delay_corner -name dc_WCL -rc_corner rc_cworst_CCworst_T -timing_condition {timing_condition_WCL}
create_delay_corner -name dc_TC -rc_corner rc_typical -timing_condition {timing_condition_TC}
create_delay_corner -name dc_ML -rc_corner rc_cbest_CCbest -timing_condition {timing_condition_ML}

create_constraint_mode -name func -sdc_files [list $N5_sdc_root/xcvr.func.sdc]

create_analysis_view -name av_func_WCL -constraint_mode func -delay_corner dc_WCL
create_analysis_view -name av_func_TC -constraint_mode func -delay_corner dc_TC
create_analysis_view -name av_func_ML -constraint_mode func -delay_corner dc_ML

set_analysis_view -setup {av_func_WCL} -hold {av_func_ML} -dynamic {av_func_TC} -leakage {av_func_TC}
