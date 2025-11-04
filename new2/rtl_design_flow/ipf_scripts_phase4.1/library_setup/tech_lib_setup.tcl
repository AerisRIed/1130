#------------------------------------------------------------------------------
#                                     
#            CADENCE                    Copyright (c) 2002-2014
#                                       Cadence Design Systems, Inc.
#                                       All rights reserved.
#
#  This work may not be copied, modified, re-published, uploaded, executed, or
#  distributed in any way, in any medium, whether in whole or in part, without
#  prior written permission from Cadence Design Systems, Inc.
#------------------------------------------------------------------------------
#
#    Primary Unit Name :      tech_lib_setup.tcl
#
#          Description :      Library setup script called by project.tcl
#
#      Original Author :      Anna Gilbert
#
#------------------------------------------------------------------------------

#NB the referenced path below would possibly need to be modified, as appropriate to the location of the master tech_lib_setup.tcl 
#depending on your site
#the "local" tech_lib_setup.tcl file can be modified to include references to non-standard libraries, to meet customer-specific requirements.

#source /process/tsmc/library_setup/tech_lib_setup.tcl

#  Comment out above and use the following file as a template to understand the variables that
#  need to be set up to use the delivered synthesis scripts.
#source ./tech_lib_28nm.tcl
 if {$env(TECHNOLOGY) == "tsmcN4"} then {

    puts "TECH_LIB_SETUP ==> 4NM"

    set KITSLIB       /process/tsmcN4/data/stdcell/n4gp/TSMC
    set PMALIBS       "/projects/sd3101_n4p/users/ynzhang/U4_repository/Timberwolf_USB4_T4GP/trunk/design/reuse/pma"

    set VFILE	     "\
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_elvt_100a/verilog/tcbn04p_bwph210l6p51cnod_base_elvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_lvt_100a/verilog/tcbn04p_bwph210l6p51cnod_base_lvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_lvtll_100a/verilog/tcbn04p_bwph210l6p51cnod_base_lvtll.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_svt_100a/verilog/tcbn04p_bwph210l6p51cnod_base_svt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_ulvt_100a/verilog/tcbn04p_bwph210l6p51cnod_base_ulvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_ulvtll_100a/verilog/tcbn04p_bwph210l6p51cnod_base_ulvtll.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_elvt_100a/verilog/tcbn04p_bwph210l6p51cnod_lvl_elvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_lvt_100a/verilog/tcbn04p_bwph210l6p51cnod_lvl_lvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_lvtll_100a/verilog/tcbn04p_bwph210l6p51cnod_lvl_lvtll.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_svt_100a/verilog/tcbn04p_bwph210l6p51cnod_lvl_svt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_ulvt_100a/verilog/tcbn04p_bwph210l6p51cnod_lvl_ulvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_ulvtll_100a/verilog/tcbn04p_bwph210l6p51cnod_lvl_ulvtll.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_lvt_100a/verilog/tcbn04p_bwph210l6p51cnod_mb_lvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_lvtll_100a/verilog/tcbn04p_bwph210l6p51cnod_mb_lvtll.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_svt_100a/verilog/tcbn04p_bwph210l6p51cnod_mb_svt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_ulvt_100a/verilog/tcbn04p_bwph210l6p51cnod_mb_ulvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_ulvtll_100a/verilog/tcbn04p_bwph210l6p51cnod_mb_ulvtll.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_elvt_100a/verilog/tcbn04p_bwph210l6p51cnod_pm_elvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_lvt_100a/verilog/tcbn04p_bwph210l6p51cnod_pm_lvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_lvtll_100a/verilog/tcbn04p_bwph210l6p51cnod_pm_lvtll.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_svt_100a/verilog/tcbn04p_bwph210l6p51cnod_pm_svt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_ulvt_100a/verilog/tcbn04p_bwph210l6p51cnod_pm_ulvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_ulvtll_100a/verilog/tcbn04p_bwph210l6p51cnod_pm_ulvtll.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_elvt_100a/verilog/tcbn04p_bwph210l6p51cnod_syn_elvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_lvt_100a/verilog/tcbn04p_bwph210l6p51cnod_syn_lvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_ulvt_100a/verilog/tcbn04p_bwph210l6p51cnod_syn_ulvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_lvtll_100a/verilog/tcbn04p_bwph210l6p51cnod_syn_lvtll.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_svt_100a/verilog/tcbn04p_bwph210l6p51cnod_syn_svt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_ulvtll_100a/verilog/tcbn04p_bwph210l6p51cnod_syn_ulvtll.v \
"
    
    set ATPGLIB      " \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_elvt_100a/verilog/tcbn04p_bwph210l6p51cnod_base_elvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_lvt_100a/verilog/tcbn04p_bwph210l6p51cnod_base_lvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_lvtll_100a/verilog/tcbn04p_bwph210l6p51cnod_base_lvtll.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_svt_100a/verilog/tcbn04p_bwph210l6p51cnod_base_svt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_ulvt_100a/verilog/tcbn04p_bwph210l6p51cnod_base_ulvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_ulvtll_100a/verilog/tcbn04p_bwph210l6p51cnod_base_ulvtll.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_elvt_100a/verilog/tcbn04p_bwph210l6p51cnod_lvl_elvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_lvt_100a/verilog/tcbn04p_bwph210l6p51cnod_lvl_lvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_lvtll_100a/verilog/tcbn04p_bwph210l6p51cnod_lvl_lvtll.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_svt_100a/verilog/tcbn04p_bwph210l6p51cnod_lvl_svt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_ulvt_100a/verilog/tcbn04p_bwph210l6p51cnod_lvl_ulvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_ulvtll_100a/verilog/tcbn04p_bwph210l6p51cnod_lvl_ulvtll.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_lvt_100a/verilog/tcbn04p_bwph210l6p51cnod_mb_lvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_lvtll_100a/verilog/tcbn04p_bwph210l6p51cnod_mb_lvtll.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_svt_100a/verilog/tcbn04p_bwph210l6p51cnod_mb_svt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_ulvt_100a/verilog/tcbn04p_bwph210l6p51cnod_mb_ulvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_ulvtll_100a/verilog/tcbn04p_bwph210l6p51cnod_mb_ulvtll.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_elvt_100a/verilog/tcbn04p_bwph210l6p51cnod_pm_elvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_lvt_100a/verilog/tcbn04p_bwph210l6p51cnod_pm_lvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_lvtll_100a/verilog/tcbn04p_bwph210l6p51cnod_pm_lvtll.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_svt_100a/verilog/tcbn04p_bwph210l6p51cnod_pm_svt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_ulvt_100a/verilog/tcbn04p_bwph210l6p51cnod_pm_ulvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_ulvtll_100a/verilog/tcbn04p_bwph210l6p51cnod_pm_ulvtll.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_elvt_100a/verilog/tcbn04p_bwph210l6p51cnod_syn_elvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_lvt_100a/verilog/tcbn04p_bwph210l6p51cnod_syn_lvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_ulvt_100a/verilog/tcbn04p_bwph210l6p51cnod_syn_ulvt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_lvtll_100a/verilog/tcbn04p_bwph210l6p51cnod_syn_lvtll.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_svt_100a/verilog/tcbn04p_bwph210l6p51cnod_syn_svt.v \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_ulvtll_100a/verilog/tcbn04p_bwph210l6p51cnod_syn_ulvtll.v \
"
      
    set LIBLEF       "\
/process/tsmcN4/data/stdcell/n4gp/TSMC/PRTF_Innovus_4nm_014_Cad_V10a/PRTF/PRTF_Innovus_4nm_014_Cad_V10a/PR_tech/Cadence/LefHeader/Standard/VHV/PRTF_Innovus_N4P_14M_1X1Xb1Xe1Ya1Yb4Y2Yy2Z_UTRDL_M1P34_M2P35_M3P42_M4P42_M5P76_M6P76_M7P76_M8P76_M9P76_M10P76_H210_M0ROUTE.10a.tlef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_elvt_100a/lef/tcbn04p_bwph210l6p51cnod_base_elvt.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_lvt_100a/lef/tcbn04p_bwph210l6p51cnod_base_lvt.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_lvtll_100a/lef/tcbn04p_bwph210l6p51cnod_base_lvtll.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_svt_100a/lef/tcbn04p_bwph210l6p51cnod_base_svt.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_ulvt_100a/lef/tcbn04p_bwph210l6p51cnod_base_ulvt.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_ulvtll_100a/lef/tcbn04p_bwph210l6p51cnod_base_ulvtll.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_elvt_100a/lef/tcbn04p_bwph210l6p51cnod_lvl_elvt.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_lvt_100a/lef/tcbn04p_bwph210l6p51cnod_lvl_lvt.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_lvtll_100a/lef/tcbn04p_bwph210l6p51cnod_lvl_lvtll.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_svt_100a/lef/tcbn04p_bwph210l6p51cnod_lvl_svt.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_ulvt_100a/lef/tcbn04p_bwph210l6p51cnod_lvl_ulvt.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_ulvtll_100a/lef/tcbn04p_bwph210l6p51cnod_lvl_ulvtll.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_lvt_100a/lef/tcbn04p_bwph210l6p51cnod_mb_lvt.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_lvtll_100a/lef/tcbn04p_bwph210l6p51cnod_mb_lvtll.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_svt_100a/lef/tcbn04p_bwph210l6p51cnod_mb_svt.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_ulvt_100a/lef/tcbn04p_bwph210l6p51cnod_mb_ulvt.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_ulvtll_100a/lef/tcbn04p_bwph210l6p51cnod_mb_ulvtll.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_elvt_100a/lef/tcbn04p_bwph210l6p51cnod_pm_elvt.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_lvt_100a/lef/tcbn04p_bwph210l6p51cnod_pm_lvt.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_lvtll_100a/lef/tcbn04p_bwph210l6p51cnod_pm_lvtll.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_svt_100a/lef/tcbn04p_bwph210l6p51cnod_pm_svt.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_ulvt_100a/lef/tcbn04p_bwph210l6p51cnod_pm_ulvt.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_ulvtll_100a/lef/tcbn04p_bwph210l6p51cnod_pm_ulvtll.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_elvt_100a/lef/tcbn04p_bwph210l6p51cnod_syn_elvt.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_lvt_100a/lef/tcbn04p_bwph210l6p51cnod_syn_lvt.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_ulvt_100a/lef/tcbn04p_bwph210l6p51cnod_syn_ulvt.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_lvtll_100a/lef/tcbn04p_bwph210l6p51cnod_syn_lvtll.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_svt_100a/lef/tcbn04p_bwph210l6p51cnod_syn_svt.lef \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_ulvtll_100a/lef/tcbn04p_bwph210l6p51cnod_syn_ulvtll.lef \
$PMALIBS/lef/cmn_ana/cmn_ana.lef \
$PMALIBS/lef/rxtxm_ana/rxtxm_ana.lef \
$PMALIBS/lef/txm_ana/txm_ana.lef \
"
 
    set LIBLIB       " "
    set SLOWLIB      " \
 tcbn04p_bwph210l6p51cnod_base_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_elvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_base_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_lvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_base_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_base_lvtllssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_base_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_svtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_base_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_ulvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_base_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_base_ulvtllssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_lvl_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_elvtssgnp_0p675v_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_lvl_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_lvtssgnp_0p675v_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_lvl_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_lvtllssgnp_0p675v_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_lvl_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_svtssgnp_0p675v_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_lvl_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_ulvtssgnp_0p675v_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_lvl_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_ulvtllssgnp_0p675v_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_mb_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_lvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_mb_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_lvtllssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_mb_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_svtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_mb_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_ulvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_mb_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_ulvtllssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_pm_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_elvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_pm_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_lvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_pm_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_lvtllssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_pm_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_svtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_pm_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_ulvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_pm_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_ulvtllssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_syn_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_elvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_syn_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_lvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_syn_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_ulvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_syn_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_lvtllssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_syn_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_svtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_syn_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_ulvtllssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
 $PMALIBS/dotLib/cmn_ana_tt0p75v25c.lib \
 $PMALIBS/dotLib/rxtxm_ana_tt0p75v25c.lib \
 $PMALIBS/dotLib/txm_ana_tt0p75v25c.lib \
                     "
    set TYPLIB      " \
 tcbn04p_bwph210l6p51cnod_base_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_elvttt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_base_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_lvttt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_base_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_base_lvtlltt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_base_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_svttt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_base_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_ulvttt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_base_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_base_ulvtlltt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_lvl_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_elvttt_0p75v_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_lvl_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_lvttt_0p75v_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_lvl_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_lvtlltt_0p75v_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_lvl_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_svttt_0p75v_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_lvl_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_ulvttt_0p75v_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_lvl_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_ulvtlltt_0p75v_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_mb_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_lvttt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_mb_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_lvtlltt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_mb_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_svttt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_mb_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_ulvttt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_mb_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_ulvtlltt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_pm_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_elvttt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_pm_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_lvttt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_pm_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_lvtlltt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_pm_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_svttt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_pm_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_ulvttt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_pm_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_ulvtlltt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_syn_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_elvttt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_syn_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_lvttt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_syn_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_ulvttt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_syn_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_lvtlltt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_syn_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_svttt_0p75v_25c_typical.lib.gz \
 tcbn04p_bwph210l6p51cnod_syn_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_ulvtlltt_0p75v_25c_typical.lib.gz \
 $PMALIBS/dotLib/cmn_ana_tt0p75v25c.lib \
 $PMALIBS/dotLib/rxtxm_ana_tt0p75v25c.lib \
 $PMALIBS/dotLib/txm_ana_tt0p75v25c.lib \
                           "
    set FASTLIB      " \
 tcbn04p_bwph210l6p51cnod_base_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_elvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_base_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_lvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_base_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_base_lvtllffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_base_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_svtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_base_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_ulvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_base_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_base_ulvtllffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_lvl_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_elvtffgnp_0p825v_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_lvl_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_lvtffgnp_0p825v_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_lvl_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_lvtllffgnp_0p825v_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_lvl_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_svtffgnp_0p825v_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_lvl_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_ulvtffgnp_0p825v_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_lvl_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_ulvtllffgnp_0p825v_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_mb_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_lvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_mb_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_lvtllffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_mb_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_svtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_mb_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_ulvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_mb_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_ulvtllffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_pm_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_elvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_pm_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_lvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_pm_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_lvtllffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_pm_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_svtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_pm_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_ulvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_pm_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_ulvtllffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_syn_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_elvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_syn_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_lvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_syn_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_ulvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_syn_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_lvtllffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_syn_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_svtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 tcbn04p_bwph210l6p51cnod_syn_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_ulvtllffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
 $PMALIBS/dotLib/cmn_ana_tt0p75v25c.lib \
 $PMALIBS/dotLib/rxtxm_ana_tt0p75v25c.lib \
 $PMALIBS/dotLib/txm_ana_tt0p75v25c.lib \
                     "
    set MLLIB        " "
 		      
    set EDI_SLOWLIB  " \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_elvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_lvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_base_lvtllssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_svtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_ulvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_base_ulvtllssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_elvtssgnp_0p675v_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_lvtssgnp_0p675v_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_lvtllssgnp_0p675v_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_svtssgnp_0p675v_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_ulvtssgnp_0p675v_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_ulvtllssgnp_0p675v_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_lvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_lvtllssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_svtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_ulvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_ulvtllssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_elvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_lvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_lvtllssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_svtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_ulvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_ulvtllssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_elvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_lvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_ulvtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_lvtllssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_svtssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_ulvtllssgnp_0p675v_m40c_cworst_CCworst_T.lib.gz \
$PMALIBS/dotLib/cmn_ana_tt0p75v25c.lib \
$PMALIBS/dotLib/rxtxm_ana_tt0p75v25c.lib \
$PMALIBS/dotLib/txm_ana_tt0p75v25c.lib \
                          "
    set EDI_TYPLIB   " \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_elvttt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_lvttt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_base_lvtlltt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_svttt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_ulvttt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_base_ulvtlltt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_elvttt_0p75v_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_lvttt_0p75v_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_lvtlltt_0p75v_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_svttt_0p75v_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_ulvttt_0p75v_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_ulvtlltt_0p75v_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_lvttt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_lvtlltt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_svttt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_ulvttt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_ulvtlltt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_elvttt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_lvttt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_lvtlltt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_svttt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_ulvttt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_ulvtlltt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_elvttt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_lvttt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_ulvttt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_lvtlltt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_svttt_0p75v_25c_typical.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_ulvtlltt_0p75v_25c_typical.lib.gz \
$PMALIBS/dotLib/cmn_ana_tt0p75v25c.lib \
$PMALIBS/dotLib/rxtxm_ana_tt0p75v25c.lib \
$PMALIBS/dotLib/txm_ana_tt0p75v25c.lib \
		      "
  set EDI_FASTLIB      " \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_elvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_lvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_base_lvtllffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_svtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_base_ulvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_base_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_base_ulvtllffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_elvtffgnp_0p825v_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_lvtffgnp_0p825v_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_lvtllffgnp_0p825v_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_svtffgnp_0p825v_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_ulvtffgnp_0p825v_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_lvl_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_lvl_ulvtllffgnp_0p825v_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_lvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_lvtllffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_svtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_ulvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_mb_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_mb_ulvtllffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_elvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_lvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_lvtllffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_svtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_ulvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_pm_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_pm_ulvtllffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_elvt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_elvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_lvt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_lvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_ulvt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_ulvtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_lvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_lvtllffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_svt_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_svtffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$KITSLIB/tcbn04p_bwph210l6p51cnod_syn_ulvtll_100a/nldm/tcbn04p_bwph210l6p51cnod_syn_ulvtllffgnp_0p825v_125c_cbest_CCbest_T.lib.gz \
$PMALIBS/dotLib/cmn_ana_tt0p75v25c.lib \
$PMALIBS/dotLib/rxtxm_ana_tt0p75v25c.lib \
$PMALIBS/dotLib/txm_ana_tt0p75v25c.lib \
                     "

     set EDI_MLLIB   " "	       
		       	
		       	      
    set VDD_values "0.675 0.75 0.825"
    set TEMP_values "-40 25 125"
    set ss_setup_derate_factor 0.095
    set ss_hold_derate_factor 0.12
    set ff_hold_derate_factor 0.15
    set PROCNODE      4
    set max_route_layer 13
    set DRIVE_CELL    "BUFFMZD4BWP210H6P51CNODSVT"
    set WC_QRC_TECH   "/process/tsmcN4/data/gp/QRC/14M1X1Xb1Xe1Ya1Yb4Y2Yy2Z_SHDMIM_UT/current/cworst/Tech/cworst_CCworst_T/qrcTechFile"
    set WC_CAP_TABLE  ""
    set TYP_QRC_TECH  "/process/tsmcN4/data/gp/QRC/14M1X1Xb1Xe1Ya1Yb4Y2Yy2Z_SHDMIM_UT/current/typical/Tech/typical/qrcTechFile"
    set TYP_CAP_TABLE ""   
    set BC_QRC_TECH   "/process/tsmcN4/data/gp/QRC/14M1X1Xb1Xe1Ya1Yb4Y2Yy2Z_SHDMIM_UT/current/cbest/Tech/cbest_CCbest/qrcTechFile"
    set BC_CAP_TABLE  ""
    set TIELIST [list ]

#"*LATNQN_D_N_M7P5TR*"  *ULVT *ULVTLL 
    
    set DONT_USE [list  CKM* CKN* TIEH* TIEL* DEL* \
*SK* DCCK* *DFN* \
*AOI*D1BWP* *IOA*D1BWP* *IAO*D1BWP* *OAI*D1BWP* *DFM* \
*ELVT *ULVT* *CK* TIE* *D0P*BWP* G*BWP* *SYNC* *D36BWP* *D32BWP* *D28BWP* *D24BWP* *D20BWP* *D18BWP* *D16BWP* \
*D0* *D12* *D14* *D15* *D16* *D18* *D24* *D30* *D36* CK* DCCK* AOI22* OAI22* AOI3* G* PT* *D0P* *D1P5*  \
    ]

#         set DONT_USE [list  CKM* CKN* TIEH* TIEL* DEL* \
# *SK* DCCK* *DFN* \
# *AOI*D1BWP* *IOA*D1BWP* *IAO*D1BWP* *OAI*D1BWP* *DFM* \
#  *CK* TIE* *D0P*BWP* G*BWP* *SYNC* *D36BWP* *D32BWP* *D28BWP* *D24BWP* *D20BWP* *D18BWP* *D16BWP* \
# *D0* *D12* *D14* *D15* *D16* *D18* *D24* *D30* *D36* CK* DCCK* AOI22* OAI22* AOI3* G* PT* *D0P* *D1P5* *ULVT \
#     ]

    set CLK_BUFFERS [list  ]
       
    set CLK_INVERTERS [list  ]

 }



