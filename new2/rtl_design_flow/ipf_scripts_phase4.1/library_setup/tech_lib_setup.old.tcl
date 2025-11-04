
#------------------------------------------------------------------------------
#                                     
#            CADENCE                    Copyright (c) 2001-2013
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
#      Original Author :      Patrick McKeever
#
#------------------------------------------------------------------------------
# $Id: tech_lib_setup.tcl 1377 2015-01-20 15:34:29Z patrickm $


# TSMC55LP All VT library follows
if {$env(TECHNOLOGY) == "TSMC55LP"} then {

   set KITSLIB       /process/tsmc/TSMC55LP/TSMCHOME/digital

   set VFILE        "$KITSLIB/Front_End/verilog/tcbn55lplvt_200a/tcbn55lplvt.v \
                     $KITSLIB/Front_End/verilog/tcbn55lphvt_200a/tcbn55lphvt.v \
                     $KITSLIB/Front_End/verilog/tcbn55lp_200a/tcbn55lp.v \
                     "
   set ATPGLIB      "$KITSLIB/Front_End/mentor_dft/tcbn55lplvt_200a/tcbn55lplvt.mdt \
                     $KITSLIB/Front_End/mentor_dft/tcbn55lphvt_200a/tcbn55lphvt.mdt \
                     $KITSLIB/Front_End/mentor_dft/tcbn55lp_200a/tcbn55lp.mdt \
                     "
   set LIBLEF       "$KITSLIB/Back_End/lef/tcbn55lplvt_200a/lef/tcbn55lplvt_6lmT2.lef \
                     $KITSLIB/Back_End/lef/tcbn55lphvt_200a/lef/tcbn55lphvt_6lmT2.lef \
                     $KITSLIB/Back_End/lef/tcbn55lp_200a/lef/tcbn55lp_6lmT2.lef \
                            "
   set LIBLIB       "$KITSLIB/Front_End/timing_power_noise/NLDM/tcbn55lplvt_200a \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn55lphvt_200a \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn55lp_200a \
                     "
   set SLOWLIB      "tcbn55lplvtwc.lib \
                     tcbn55lphvtwc.lib \
                     tcbn55lpwc.lib \
                     "
   set TYPLIB       "tcbn55lplvttc.lib \
 		     tcbn55lphvttc.lib \
 		     tcbn55lptc.lib \
 		     "	
   set FASTLIB      "tcbn55lplvtbc.lib \
                     tcbn55lphvtbc.lib \
                     tcbn55lpbc.lib \
                     "
   set EDI_SLOWLIB  "$KITSLIB/Front_End/timing_power_noise/NLDM/tcbn55lplvt_200a/tcbn55lplvtwc.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn55lphvt_200a/tcbn55lphvtwc.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn55lp_200a/tcbn55lpwc.lib \
                     "
   set EDI_TYPLIB  "$KITSLIB/Front_End/timing_power_noise/NLDM/tcbn55lplvt_200a/tcbn55lplvttc.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn55lphvt_200a/tcbn55lphvttc.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn55lp_200a/tcbn55lptc.lib \
                     "		     		     
   set EDI_FASTLIB  "$KITSLIB/Front_End/timing_power_noise/NLDM/tcbn55lplvt_200a/tcbn55lplvtbc.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn55lphvt_200a/tcbn55lphvtbc.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn55lp_200a/tcbn55lpbc.lib \
                     "
   set WC_DB        "$KITSLIB/Back_End/celtic/tcbn55lplvt_200a/tcbn55lplvtwc.cdb \
                     $KITSLIB/Back_End/celtic/tcbn55lphvt_200a/tcbn55lphvtwc.cdb \
                     $KITSLIB/Back_End/celtic/tcbn55lp_200a/tcbn55lpwc.cdb \
                     "
   set BC_DB        "$KITSLIB/Back_End/celtic/tcbn55lplvt_200a/tcbn55lplvtbc.cdb \
                     $KITSLIB/Back_End/celtic/tcbn55lphvt_200a/tcbn55lphvtbc.cdb \
                     $KITSLIB/Back_End/celtic/tcbn55lp_200a/tcbn55lpbc.cdb \
                     "

   set VDD_values  "1.08 1.32 1.20"
   set TEMP_values "125 0 25"
   set ss_setup_derate_factor 0.05
   set ss_hold_derate_factor 0.05
   set ff_hold_derate_factor 0.05
   set PROCNODE      55
   set max_route_layer 7
   set DRIVE_CELL    BUFFD4
   set WC_CAP_TABLE  ""
   set WC_QRC_TECH   ""
   set BC_CAP_TABLE  ""
   set BC_QRC_TECH   ""

   set TIELIST [list \
      "TIEH" \
      "TIEL" \
   ]
   set DONT_USE [list \
      "CKAN2D*" \
      "CKBD*" \
      "CKMUX2D*" \
      "CKND2D*" \
      "CKND*" \
      "CKXOR2D*" \
      "DEL*" \
      "GTIE*" \
      "TIE*" \
      "*0*" \
      "*24*" \
   ]
   set CLK_BUFFERS [list \
      "CKBD4LVT" \
      "CKBD8LVT" \
      "CKBD12LVT" \
      "CKBD16LVT" \
   ]            
   set CLK_INVERTERS [list \
      "CKND4LVT" \
      "CKND8LVT" \
      "CKND12LVT" \
      "CKND16LVT" \
   ]

}


# TSMC40LP All VT library follows
if {$env(TECHNOLOGY) == "TSMC40LP"} then {

   set KITSLIB       /process/tsmc/TSMC40LP/TSMCHOME/digital

   set VFILE        "$KITSLIB/Front_End/verilog/tcbn40lpbwplvt_200a/tcbn40lpbwplvt.v \
                     $KITSLIB/Front_End/verilog/tcbn40lpbwphvt_200a/tcbn40lpbwphvt.v \
                     $KITSLIB/Front_End/verilog/tcbn40lpbwp_200a/tcbn40lpbwp.v \
                     "
   set ATPGLIB      "$KITSLIB/Front_End/mentor_dft/tcbn40lpbwplvt_120a/tcbn40lpbwplvt.mdt \
                     $KITSLIB/Front_End/mentor_dft/tcbn40lpbwphvt_120a/tcbn40lpbwphvt.mdt \
                     $KITSLIB/Front_End/mentor_dft/tcbn40lpbwp_120a/tcbn40lpbwp.mdt \
                     "
   set LIBLEF       "$KITSLIB/Back_End/lef/tcbn40lpbwplvt_120c/lef/HVH_0d5_0/tcbn40lpbwplvt_7lm5X1ZRDL.lef \
                     $KITSLIB/Back_End/lef/tcbn40lpbwphvt_120c/lef/HVH_0d5_0/tcbn40lpbwphvt_7lm5X1ZRDL.lef \
                     $KITSLIB/Back_End/lef/tcbn40lpbwp_120c/lef/HVH_0d5_0/tcbn40lpbwp_7lm5X1ZRDL.lef \
                     "
   set LIBLIB       "$KITSLIB/Front_End/timing_power_noise/NLDM/tcbn40lpbwplvt_200a \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn40lpbwphvt_200a \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn40lpbwp_200a \
                     "
   set SLOWLIB      "tcbn40lpbwplvtwc.lib \
                     tcbn40lpbwphvtwc.lib \
                     tcbn40lpbwpwc.lib \
                     "
   set TYPLIB       "tcbn40lpbwplvttc.lib \
 		     tcbn40lpbwphvttc.lib \
 		     tcbn40lpbwptc.lib \
 		     "			     
   set FASTLIB      "tcbn40lpbwplvtbc.lib \
                     tcbn40lpbwphvtbc.lib \
                     tcbn40lpbwpbc.lib \
                     "
   set EDI_SLOWLIB  "$KITSLIB/Front_End/timing_power_noise/NLDM/tcbn40lpbwplvt_200a/tcbn40lpbwplvtwc.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn40lpbwphvt_200a/tcbn40lpbwphvtwc.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn40lpbwp_200a/tcbn40lpbwpwc.lib \
                     "
   set EDI_TYPLIB   "$KITSLIB/Front_End/timing_power_noise/NLDM/tcbn40lpbwplvt_200a/tcbn40lpbwplvttc.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn40lpbwphvt_200a/tcbn40lpbwphvttc.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn40lpbwp_200a/tcbn40lpbwptc.lib \
                     "		     		     
   set EDI_FASTLIB  "$KITSLIB/Front_End/timing_power_noise/NLDM/tcbn40lpbwplvt_200a/tcbn40lpbwplvtbc.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn40lpbwphvt_200a/tcbn40lpbwphvtbc.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn40lpbwp_200a/tcbn40lpbwpbc.lib \
                     "
   set WC_DB        "$KITSLIB/Back_End/celtic/tcbn40lpbwplvt_200a/tcbn40lpbwplvtwc.cdb \
                     $KITSLIB/Back_End/celtic/tcbn40lpbwphvt_200a/tcbn40lpbwphvtwc.cdb \
                     $KITSLIB/Back_End/celtic/tcbn40lpbwp_200a/tcbn40lpbwpwc.cdb \
                     "
   set TYP_DB       "$KITSLIB/Back_End/celtic/tcbn40lpbwplvt_200a/tcbn40lpbwplvttc.cdb \
                     $KITSLIB/Back_End/celtic/tcbn40lpbwphvt_200a/tcbn40lpbwphvttc.cdb \
                     $KITSLIB/Back_End/celtic/tcbn40lpbwp_200a/tcbn40lpbwptc.cdb \
                     "		     		     
   set BC_DB        "$KITSLIB/Back_End/celtic/tcbn40lpbwplvt_200a/tcbn40lpbwplvtbc.cdb \
                     $KITSLIB/Back_End/celtic/tcbn40lpbwphvt_200a/tcbn40lpbwphvtbc.cdb \
                     $KITSLIB/Back_End/celtic/tcbn40lpbwp_200a/tcbn40lpbwpbc.cdb \
                     "

   set VDD_values   "0.99 1.21 1.10"
   set TEMP_values  "125 0 25"
   set ss_setup_derate_factor 0.05
   set ss_hold_derate_factor 0.05
   set ff_hold_derate_factor 0.05
   set PROCNODE      40
   set max_route_layer 7
   set DRIVE_CELL    BUFFD4BWP
   set WC_CAP_TABLE  $KITSLIB/Back_End/lef/tcbn40lpbwp_120c/techfiles/captable/cln40lp_1p07m+alrdl_5x1z_cworst.captab
   set WC_QRC_TECH   $KITSLIB/EXTRACTION/1p07m+alrdl_5x1z/cworst/qrcTechFile
   set TYP_CAP_TABLE $KITSLIB/Back_End/lef/tcbn40lpbwp_120c/techfiles/captable/cln40lp_1p07m+alrdl_5x1z_typical.captab
   set TYP_QRC_TECH  $KITSLIB/EXTRACTION/1p07m+alrdl_5x1z/typical/qrcTechFile  
   set BC_CAP_TABLE  $KITSLIB/Back_End/lef/tcbn40lpbwp_120c/techfiles/captable/cln40lp_1p07m+alrdl_5x1z_cbest.captab
   set BC_QRC_TECH   $KITSLIB/EXTRACTION/1p07m+alrdl_5x1z/cbest/qrcTechFile

   set TIELIST [list \
      "TIEHBWP" \
      "TIELBWP" \
   ]
   set DONT_USE [list \
      "CKAN2D*" \
      "CKBD*" \
      "CKMUX2D*" \
      "CKND2D*" \
      "CKND*" \
      "CKXOR2D*" \
      "DEL*" \
      "GTIE*" \
      "TIE*" \
      "*0BWP*" \
      "*24BWP*" \
   ]
   set CLK_BUFFERS [list \
      "CKBD4BWPLVT" \
      "CKBD8BWPLVT" \
      "CKBD12BWPLVT" \
      "CKBD16BWPLVT" \
   ]      
   set CLK_INVERTERS [list \
      "CKND4BWPLVT" \
      "CKND8BWPLVT" \
      "CKND12BWPLVT" \
      "CKND16BWPLVT" \
   ]

}

# TSMC28HPM All VT 7-track library follows
if {$env(TECHNOLOGY) == "TSMC28HPM_7T"} then {

   set KITSLIB       /process/stdcell/tsmc/28nm/n28hpm/TSMC
   set PMALIB        /projects/sduu02u2y_t28hpm_01_vf180_7020_r100/work/digital_repo_common_chkout/sduu02u2y_t28hpc_01_vf180_7020/ana_macro/usb2_pma_top/v0p0

   set VFILE        "$KITSLIB/tcbn28hpmbwp7t30p140_100b/verilog/tcbn28hpmbwp7t30p140.v \
		     $KITSLIB/tcbn28hpmbwp7t30p140hvt_100b/verilog/tcbn28hpmbwp7t30p140hvt.v \
		     $KITSLIB/tcbn28hpmbwp7t30p140lvt_100b/verilog/tcbn28hpmbwp7t30p140lvt.v \
		     $PMALIB/usb2_pma_top.v \
		     "
   set ATPGLIB      "$KITSLIB/tcbn28hpmbwp7t30p140_100b/mentor_dft/tcbn28hpmbwp7t30p140.mdt \
		     $KITSLIB/tcbn28hpmbwp7t30p140hvt_100b/mentor_dft/tcbn28hpmbwp7t30p140hvt.mdt \
		     $KITSLIB/tcbn28hpmbwp7t30p140lvt_100b/mentor_dft/tcbn28hpmbwp7t30p140lvt.mdt \
		     "		     
   set LIBLEF       "$KITSLIB/tcbn28hpmbwp7t30p140_100b/lef/tcbn28hpmbwp7t30p140_9lm6X2ZUTRDL.lef \
   		     $KITSLIB/tcbn28hpmbwp7t30p140_100b/lef/tcbn28hpmbwp7t30p140.macro.lef \
   		     $KITSLIB/tcbn28hpmbwp7t30p140hvt_100b/lef/tcbn28hpmbwp7t30p140hvt_9lm6X2ZUTRDL.lef \
   		     $KITSLIB/tcbn28hpmbwp7t30p140hvt_100b/lef/tcbn28hpmbwp7t30p140hvt.macro.lef \
   		     $KITSLIB/tcbn28hpmbwp7t30p140lvt_100b/lef/tcbn28hpmbwp7t30p140lvt_9lm6X2ZUTRDL.lef \
   		     $KITSLIB/tcbn28hpmbwp7t30p140lvt_100b/lef/tcbn28hpmbwp7t30p140lvt.macro.lef \
   		     $PMALIB/lef/usb2_pma_top.lef \
		     "		    
   set LIBLIB       "$KITSLIB/tcbn28hpmbwp7t30p140_100b/ecsm/ \
                     $KITSLIB/tcbn28hpmbwp7t30p140hvt_100b/ecsm/ \
                     $KITSLIB/tcbn28hpmbwp7t30p140lvt_100b/ecsm/ \
                     $KITSLIB/tcbn28hpmbwp7t30p140_100b/ecsm/ \
                     $KITSLIB/tcbn28hpmbwp7t30p140hvt_100b//ecsm/ \
                     $KITSLIB/tcbn28hpmbwp7t30p140lvt_100b/ecsm/ \
                     $PMALIB/libs/ \
		     "		     
   set SLOWLIB      "tcbn28hpmbwp7t30p140ss0p81vm40c_ecsm.lib \
                     tcbn28hpmbwp7t30p140hvtss0p81vm40c_ecsm.lib \
                     tcbn28hpmbwp7t30p140lvtss0p81vm40c_ecsm.lib \
                     tcbn28hpmbwp7t30p140ss0p81v0p81vm40c_ecsm.lib \
                     tcbn28hpmbwp7t30p140hvtss0p81v0p81vm40c_ecsm.lib \
                     tcbn28hpmbwp7t30p140lvtss0p81v0p81vm40c_ecsm.lib \
                     usb2_pma_top_ss0p810vm40c_typical.lib \
		     "		     
   set TYPLIB       "tcbn28hpmbwp7t30p140tt0p9v25c_ecsm.lib \
                     tcbn28hpmbwp7t30p140hvttt0p9v25c_ecsm.lib \
                     tcbn28hpmbwp7t30p140lvttt0p9v25c_ecsm.lib \
                     tcbn28hpmbwp7t30p140tt0p9v0p9v25c_ecsm.lib \
                     tcbn28hpmbwp7t30p140hvttt0p9v0p9v25c_ecsm.lib \
                     tcbn28hpmbwp7t30p140lvttt0p9v0p9v25c_ecsm.lib \
                     usb2_pma_top_tt0p900v25c_typical.lib \
		     "		     	
   set FASTLIB      "tcbn28hpmbwp7t30p140ff0p99vm40c_ecsm.lib \
                     tcbn28hpmbwp7t30p140hvtff0p99vm40c_ecsm.lib \
                     tcbn28hpmbwp7t30p140lvtff0p99vm40c_ecsm.lib \
                     tcbn28hpmbwp7t30p140ff0p99v0p99vm40c_ecsm.lib \
                     tcbn28hpmbwp7t30p140hvtff0p99v0p99vm40c_ecsm.lib \
                     tcbn28hpmbwp7t30p140lvtff0p99v0p99vm40c_ecsm.lib \
                     usb2_pma_top_ff0p990vm40c_typical.lib \
		     "		     
   set MLLIB        "tcbn28hpmbwp7t30p140ff0p99v125c_ecsm.lib \
                     tcbn28hpmbwp7t30p140hvtff0p99v125c_ecsm.lib \
                     tcbn28hpmbwp7t30p140lvtff0p99v125c_ecsm.lib \
                     tcbn28hpmbwp7t30p140ff0p99v0p99v125c_ecsm.lib \
                     tcbn28hpmbwp7t30p140hvtff0p99v0p99v125c_ecsm.lib \
                     tcbn28hpmbwp7t30p140lvtff0p99v0p99v125c_ecsm.lib \
                     usb2_pma_top_ff0p990v125c_typical.lib \
		     "		     
   set EDI_SLOWLIB  "$KITSLIB/tcbn28hpmbwp7t30p140_100b/ecsm/tcbn28hpmbwp7t30p140ss0p81vm40c_ecsm.lib \
                     $KITSLIB/tcbn28hpmbwp7t30p140hvt_100b/ecsm/tcbn28hpmbwp7t30p140hvtss0p81vm40c_ecsm.lib \
		     $KITSLIB/tcbn28hpmbwp7t30p140lvt_100b/ecsm/tcbn28hpmbwp7t30p140lvtss0p81vm40c_ecsm.lib \
		     $KITSLIB/tcbn28hpmbwp7t30p140_100b/ecsm/tcbn28hpmbwp7t30p140ss0p81v0p81vm40c_ecsm.lib \
                     $KITSLIB/tcbn28hpmbwp7t30p140hvt_100b/ecsm/tcbn28hpmbwp7t30p140hvtss0p81v0p81vm40c_ecsm.lib \
		     $KITSLIB/tcbn28hpmbwp7t30p140lvt_100b/ecsm/tcbn28hpmbwp7t30p140lvtss0p81v0p81vm40c_ecsm.lib \
		     $PMALIB/libs/usb2_pma_top_ss0p810vm40c_typical.lib \
		     "		     
   set EDI_TYPLIB   "$KITSLIB/tcbn28hpmbwp7t30p140_100b/ecsm/tcbn28hpmbwp7t30p140tt0p9v25c_ecsm.lib \
                     $KITSLIB/tcbn28hpmbwp7t30p140hvt_100b/ecsm/tcbn28hpmbwp7t30p140hvttt0p9v25c_ecsm.lib \
		     $KITSLIB/tcbn28hpmbwp7t30p140lvt_100b/ecsm/tcbn28hpmbwp7t30p140lvttt0p9v25c_ecsm.lib \
		     $KITSLIB/tcbn28hpmbwp7t30p140_100b/ecsm/tcbn28hpmbwp7t30p140tt0p9v0p9v25c_ecsm.lib \
                     $KITSLIB/tcbn28hpmbwp7t30p140hvt_100b/ecsm/tcbn28hpmbwp7t30p140hvttt0p9v0p9v25c_ecsm.lib \
		     $KITSLIB/tcbn28hpmbwp7t30p140lvt_100b/ecsm/tcbn28hpmbwp7t30p140lvttt0p9v0p9v25c_ecsm.lib \
		     $PMALIB/libs/usb2_pma_top_tt0p900v25c_typical.lib \
		     "			     	     		     
   set EDI_FASTLIB  "$KITSLIB/tcbn28hpmbwp7t30p140_100b/ecsm/tcbn28hpmbwp7t30p140ff0p99vm40c_ecsm.lib \
                     $KITSLIB/tcbn28hpmbwp7t30p140hvt_100b/ecsm/tcbn28hpmbwp7t30p140hvtff0p99vm40c_ecsm.lib \
		     $KITSLIB/tcbn28hpmbwp7t30p140lvt_100b/ecsm/tcbn28hpmbwp7t30p140lvtff0p99vm40c_ecsm.lib \
		     $KITSLIB/tcbn28hpmbwp7t30p140_100b/ecsm/tcbn28hpmbwp7t30p140ff0p99v0p99vm40c_ecsm.lib \
                     $KITSLIB/tcbn28hpmbwp7t30p140hvt_100b/ecsm/tcbn28hpmbwp7t30p140hvtff0p99v0p99vm40c_ecsm.lib \
		     $KITSLIB/tcbn28hpmbwp7t30p140lvt_100b/ecsm/tcbn28hpmbwp7t30p140lvtff0p99v0p99vm40c_ecsm.lib \
		     $PMALIB/libs/usb2_pma_top_ff0p990vm40c_typical.lib \
		     "		     
   set EDI_MLLIB    "$KITSLIB/tcbn28hpmbwp7t30p140_100b/ecsm/tcbn28hpmbwp7t30p140ff0p99v125c_ecsm.lib \
                     $KITSLIB/tcbn28hpmbwp7t30p140hvt_100b/ecsm/tcbn28hpmbwp7t30p140hvtff0p99v125c_ecsm.lib \
		     $KITSLIB/tcbn28hpmbwp7t30p140lvt_100b/ecsm/tcbn28hpmbwp7t30p140lvtff0p99v125c_ecsm.lib \
		     $KITSLIB/tcbn28hpmbwp7t30p140_100b/ecsm/tcbn28hpmbwp7t30p140ff0p99v0p99v125c_ecsm.lib \
                     $KITSLIB/tcbn28hpmbwp7t30p140hvt_100b/ecsm/tcbn28hpmbwp7t30p140hvtff0p99v0p99v125c_ecsm.lib \
		     $KITSLIB/tcbn28hpmbwp7t30p140lvt_100b/ecsm/tcbn28hpmbwp7t30p140lvtff0p99v0p99v125c_ecsm.lib \
		     $PMALIB/libs/usb2_pma_top_ff0p990v125c_typical.lib \
		     "		     
   set WC_DB        ""		     
   set TYP_DB       ""		     		     		     
   set BC_DB        ""		     
# since we are using ecsm, we dont need noise characteristics during synth.
   set VDD_values    "0.81 0.99 0.90"
   set TEMP_values   "-40 0 25"
   set ss_setup_derate_factor 0.095
   set ss_hold_derate_factor 0.12
   set ff_hold_derate_factor 0.15
   set PROCNODE      28
   set max_route_layer 9
   set DRIVE_CELL    BUFFD4BWP7T30P140
   set WC_CAP_TABLE  ""
   set WC_QRC_TECH   "__REPLACE__"
   set TYP_CAP_TABLE ""
   set TYP_QRC_TECH  "__REPLACE__"   
   set BC_CAP_TABLE  ""
   set BC_QRC_TECH   "__REPLACE__"

   set TIELIST [list \
      "TIEHBWP7T30P140" \
      "TIELBWP7T30P140" \
   ]
   set DONT_USE [list \
      "CKAN2D*" \
      "CKBD*" \
      "CKMUX2D*" \
      "CKND2D*" \
      "CKND*" \
      "CKXOR2D*" \
      "DEL*" \
      "GTIE*" \
      "TIE*" \
      "*0BWP7T30*" \
   ]
   set CLK_BUFFERS [list \
      "CKBD4BWP7T30" \
      "CKBD8BWP7T30" \
      "CKBD12BWP7T30" \
      "CKBD16BWP7T30" \
   ]
      
   set CLK_INVERTERS [list \
      "CKND4BWP7T30" \
      "CKND8BWP7T30" \
      "CKND12BWP7T30" \
      "CKND16BWP7T30" \
   ]

}



# TSMC28HPM All VT 9-track 8LM library follows
if {$env(TECHNOLOGY) == "TSMC28HPM_9T"} then {

   set KITSLIB       /process/tsmc/TSMC28HPM/TSMCHOME/digital
   set PMALIB       /servers/scratch50/kirank/usb2_ots/28nm/ana_macro/usb2_pma_top/v0p0

   set VFILE        "$KITSLIB/Front_End/verilog/tcbn28hpmbwp35lvt_111b/tcbn28hpmbwp35lvt.v \
                     $KITSLIB/Front_End/verilog/tcbn28hpmbwp35hvt_111b/tcbn28hpmbwp35hvt.v \
                     $KITSLIB/Front_End/verilog/tcbn28hpmbwp35_111b/tcbn28hpmbwp35.v \
                     $KITSLIB/Front_End/verilog/tcbn28hpmbwp35cglvt_111b/tcbn28hpmbwp35cglvt.v \
                     $KITSLIB/Front_End/verilog/tcbn28hpmbwp35cghvt_111b/tcbn28hpmbwp35cghvt.v \
                     $KITSLIB/Front_End/verilog/tcbn28hpmbwp35cg_111b/tcbn28hpmbwp35cg.v \
                     "
   set ATPGLIB      "$KITSLIB/Front_End/mentor_dft/tcbn28hpmbwp35lvt_110a/tcbn28hpmbwp35lvt.mdt \
	             $KITSLIB/Front_End/mentor_dft/tcbn28hpmbwp35_110a/tcbn28hpmbwp35.mdt \
	             $KITSLIB/Front_End/mentor_dft/tcbn28hpmbwp35hvt_110a/tcbn28hpmbwp35hvt.mdt \
                     $KITSLIB/Front_End/mentor_dft/tcbn28hpmbwp35cglvt_110a/tcbn28hpmbwp35cglvt.mdt \
	             $KITSLIB/Front_End/mentor_dft/tcbn28hpmbwp35cg_110a/tcbn28hpmbwp35cg.mdt \
	             $KITSLIB/Front_End/mentor_dft/tcbn28hpmbwp35cghvt_110a/tcbn28hpmbwp35cghvt.mdt \
	             "		     
   set LIBLEF       "$KITSLIB/Back_End/lef/tcbn28hpmbwp35lvt_110a/lef/HVH_0d5_0/tcbn28hpmbwp35lvt_8lm5X2ZUTRDL.lef \
                     $KITSLIB/Back_End/lef/tcbn28hpmbwp35hvt_110a/lef/HVH_0d5_0/tcbn28hpmbwp35hvt_8lm5X2ZUTRDL.lef \
                     $KITSLIB/Back_End/lef/tcbn28hpmbwp35_110a/lef/HVH_0d5_0/tcbn28hpmbwp35_8lm5X2ZUTRDL.lef \
                     $KITSLIB/Back_End/lef/tcbn28hpmbwp35cglvt_110a/lef/HVH_0d5_0/tcbn28hpmbwp35cglvt_8lm5X2ZUTRDL.lef \
                     $KITSLIB/Back_End/lef/tcbn28hpmbwp35cghvt_110a/lef/HVH_0d5_0/tcbn28hpmbwp35cghvt_8lm5X2ZUTRDL.lef \
                     $KITSLIB/Back_End/lef/tcbn28hpmbwp35cg_110a/lef/HVH_0d5_0/tcbn28hpmbwp35cg_8lm5X2ZUTRDL.lef \
                     $PMALIB/lef/usb2_pma_top.lef \
		     "		     
   set LIBLIB       "$KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35lvt_111a \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35hvt_111a \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35_111a \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35cglvt_111a \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35cghvt_111a \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35cg_111a \
                     $PMALIB/libs \
		     "		     
   set SLOWLIB      "tcbn28hpmbwp35lvtss0p81vm40c.lib \
                     tcbn28hpmbwp35hvtss0p81vm40c.lib \
                     tcbn28hpmbwp35ss0p81vm40c.lib \
		     tcbn28hpmbwp35ss0p81v0p81vm40c.lib \
		     tcbn28hpmbwp35hvtss0p81v0p81vm40c.lib \
		     tcbn28hpmbwp35lvtss0p81v0p81vm40c.lib \
                     tcbn28hpmbwp35cglvtss0p81vm40c.lib \
                     tcbn28hpmbwp35cghvtss0p81vm40c.lib \
                     tcbn28hpmbwp35cgss0p81vm40c.lib \
                     usb2_pma_top_ss0p72vm40c.lib \
		     "		     
   set TYPLIB       "tcbn28hpmbwp35lvttt0p9v25c.lib \
 		     tcbn28hpmbwp35hvttt0p9v25c.lib \
 		     tcbn28hpmbwp35tt0p9v25c.lib \
		     tcbn28hpmbwp35hvttt0p9v0p9v25c.lib \
		     tcbn28hpmbwp35lvttt0p9v0p9v25c.lib \
		     tcbn28hpmbwp35tt0p9v0p9v25c.lib \
 		     tcbn28hpmbwp35cglvttt0p9v25c.lib \
 		     tcbn28hpmbwp35cghvttt0p9v25c.lib \
 		     tcbn28hpmbwp35cgtt0p9v25c.lib \
 		     usb2_pma_top_tt0p85v25c.lib \
		     "		     	
   set FASTLIB      "tcbn28hpmbwp35lvtff0p99v0c.lib \
                     tcbn28hpmbwp35hvtff0p99v0c.lib \
                     tcbn28hpmbwp35ff0p99v0c.lib \
		     tcbn28hpmbwp35lvtff0p99v0p99v0c.lib \
		     tcbn28hpmbwp35hvtff0p99v0p99v0c.lib \
		     tcbn28hpmbwp35ff0p99v0p99v0c.lib \
                     tcbn28hpmbwp35cglvtff0p99v0c.lib \
                     tcbn28hpmbwp35cghvtff0p99v0c.lib \
                     tcbn28hpmbwp35cgff0p99v0c.lib \
                     usb2_pma_top_ff0p935vm40c.lib \
		     "		     
   set EDI_SLOWLIB  "$KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35lvt_111a/tcbn28hpmbwp35lvtss0p81vm40c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35hvt_111a/tcbn28hpmbwp35hvtss0p81vm40c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35_111a/tcbn28hpmbwp35ss0p81vm40c.lib \
		     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35lvt_111a/tcbn28hpmbwp35lvtss0p81v0p81vm40c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35hvt_111a/tcbn28hpmbwp35hvtss0p81v0p81vm40c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35_111a/tcbn28hpmbwp35ss0p81v0p81vm40c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35cglvt_111a/tcbn28hpmbwp35cglvtss0p81vm40c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35cghvt_111a/tcbn28hpmbwp35cghvtss0p81vm40c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35cg_111a/tcbn28hpmbwp35cgss0p81vm40c.lib \
                     $PMALIB/libs/usb2_pma_top_ss0p72vm40c.lib \
		     "		     
   set EDI_TYPLIB   "$KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35lvt_111a/tcbn28hpmbwp35lvttt0p9v25c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35hvt_111a/tcbn28hpmbwp35hvttt0p9v25c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35_111a/tcbn28hpmbwp35tt0p9v25c.lib \
		     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35lvt_111a/tcbn28hpmbwp35lvttt0p9v0p9v25c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35hvt_111a/tcbn28hpmbwp35hvttt0p9v0p9v25c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35_111a/tcbn28hpmbwp35tt0p9v0p9v25c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35cglvt_111a/tcbn28hpmbwp35cglvttt0p9v25c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35cghvt_111a/tcbn28hpmbwp35cghvttt0p9v25c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35cg_111a/tcbn28hpmbwp35cgtt0p9v25c.lib \
                     $PMALIB/libs/usb2_pma_top_tt0p85v25c.lib \
		     "			     	     		     
   set EDI_FASTLIB  "$KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35lvt_111a/tcbn28hpmbwp35lvtff0p99v0c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35hvt_111a/tcbn28hpmbwp35hvtff0p99v0c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35_111a/tcbn28hpmbwp35ff0p99v0c.lib \
		     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35lvt_111a/tcbn28hpmbwp35lvtff0p99v0p99v0c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35hvt_111a/tcbn28hpmbwp35hvtff0p99v0p99v0c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35_111a/tcbn28hpmbwp35ff0p99v0p99v0c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35cglvt_111a/tcbn28hpmbwp35cglvtff0p99v0c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35cghvt_111a/tcbn28hpmbwp35cghvtff0p99v0c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp35cg_111a/tcbn28hpmbwp35cgff0p99v0c.lib \
                     $PMALIB/libs/usb2_pma_top_ff0p935vm40c.lib \
		     "		     
   set WC_DB        "$KITSLIB/Back_End/celtic/tcbn28hpmbwp35lvt_111a/tcbn28hpmbwp35lvtss0p81vm40c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35hvt_111a/tcbn28hpmbwp35hvtss0p81vm40c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35_111a/tcbn28hpmbwp35ss0p81vm40c.cdb \
		     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35lvt_111a/tcbn28hpmbwp35lvtss0p81v0p81vm40c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35hvt_111a/tcbn28hpmbwp35hvtss0p81v0p81vm40c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35_111a/tcbn28hpmbwp35ss0p81v0p81vm40c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35cglvt_111a/tcbn28hpmbwp35cglvtss0p81vm40c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35cghvt_111a/tcbn28hpmbwp35cghvtss0p81vm40c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35cg_111a/tcbn28hpmbwp35cgss0p81vm40c.cdb \
                     "		     
   set TYP_DB       "$KITSLIB/Back_End/celtic/tcbn28hpmbwp35lvt_111a/tcbn28hpmbwp35lvttt0p9v25c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35hvt_111a/tcbn28hpmbwp35hvttt0p9v25c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35_111a/tcbn28hpmbwp35tt0p9v25c.cdb \
		     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35lvt_111a/tcbn28hpmbwp35lvttt0p9v0p9v25c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35hvt_111a/tcbn28hpmbwp35hvttt0p9v0p9v25c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35_111a/tcbn28hpmbwp35tt0p9v0p9v25c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35cglvt_111a/tcbn28hpmbwp35cglvttt0p9v25c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35cghvt_111a/tcbn28hpmbwp35cghvttt0p9v25c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35cg_111a/tcbn28hpmbwp35cgtt0p9v25c.cdb \
                     "		     		     		     
   set BC_DB        "$KITSLIB/Back_End/celtic/tcbn28hpmbwp35lvt_111a/tcbn28hpmbwp35lvtff0p99v0c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35hvt_111a/tcbn28hpmbwp35hvtff0p99v0c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35_111a/tcbn28hpmbwp35ff0p99v0c.cdb \
		     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35lvt_111a/tcbn28hpmbwp35lvtff0p99v0p99v0c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35hvt_111a/tcbn28hpmbwp35hvtff0p99v0p99v0c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35_111a/tcbn28hpmbwp35ff0p99v0p99v0c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35cglvt_111a/tcbn28hpmbwp35cglvtff0p99v0c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35cghvt_111a/tcbn28hpmbwp35cghvtff0p99v0c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpmbwp35cg_111a/tcbn28hpmbwp35cgff0p99v0c.cdb \
                     "		     

   set VDD_values    "0.81 0.99 0.90"
   set TEMP_values   "125 0 25"
   set ss_setup_derate_factor 0.095
   set ss_hold_derate_factor 0.12
   set ff_hold_derate_factor 0.15
   set PROCNODE      28
   set max_route_layer 9
   set DRIVE_CELL    BUFFD4BWP35
   set WC_CAP_TABLE  $KITSLIB/EXTRACTION/cworst/cln28hpm_1p08m_ut_alrdl_5x2z_cworst.captable
   set WC_QRC_TECH   $KITSLIB/EXTRACTION/cworst/qrcTechFile
   set TYP_CAP_TABLE $KITSLIB/EXTRACTION/typical/cln28hpm_1p08m_ut_alrdl_5x2z_typical.captable
   set TYP_QRC_TECH  $KITSLIB/EXTRACTION/typical/qrcTechFile   
   set BC_CAP_TABLE  $KITSLIB/EXTRACTION/cbest/cln28hpm_1p08m_ut_alrdl_5x2z_cbest.captable
   set BC_QRC_TECH   $KITSLIB/EXTRACTION/cbest/qrcTechFile

   set TIELIST [list \
      "TIEHBWP35" \
      "TIELBWP35" \
   ]
   set DONT_USE [list \
      "CKAN2D*" \
      "CKBD*" \
      "CKMUX2D*" \
      "CKND2D*" \
      "CKND*" \
      "CKXOR2D*" \
      "DEL*" \
      "GTIE*" \
      "TIE*" \
      "*0BWP35*" \
      "*24BWP*" \
   ]
   set CLK_BUFFERS [list \
      "CKBD4BWP35LVT" \
      "CKBD8BWP35LVT" \
      "CKBD12BWP35LVT" \
      "CKBD16BWP35LVT" \
   ]
      
   set CLK_INVERTERS [list \
      "CKND4BWP35LVT" \
      "CKND8BWP35LVT" \
      "CKND12BWP35LVT" \
      "CKND16BWP35LVT" \
   ]

}


if {$env(TECHNOLOGY) == "TSMC28HPC_9T"} then {

   set KITSLIB       /process/tsmc/TSMC28HPC/TSMCHOME/digital

   set VFILE        "$KITSLIB/Front_End/verilog/tcbn28hpcbwp35p140lvt_100a/tcbn28hpcbwp35p140lvt.v \
                     $KITSLIB/Front_End/verilog/tcbn28hpcbwp35p140hvt_100a/tcbn28hpcbwp35p140hvt.v \
                     $KITSLIB/Front_End/verilog/tcbn28hpcbwp35p140_100a/tcbn28hpcbwp35p140.v \
                     $KITSLIB/Front_End/verilog/tcbn28hpcbwp35p140cglvt_100a/tcbn28hpcbwp35p140cglvt.v \
                     $KITSLIB/Front_End/verilog/tcbn28hpcbwp35p140cghvt_100a/tcbn28hpcbwp35p140cghvt.v \
                     $KITSLIB/Front_End/verilog/tcbn28hpcbwp35p140cg_100a/tcbn28hpcbwp35p140cg.v \
                     "
   set ATPGLIB      "$KITSLIB/Front_End/mentor_dft/tcbn28hpcbwp35p140lvt_100a/tcbn28hpcbwp35p140lvt.mdt \
	             $KITSLIB/Front_End/mentor_dft/tcbn28hpcbwp35p140_100a/tcbn28hpcbwp35p140.mdt \
	             $KITSLIB/Front_End/mentor_dft/tcbn28hpcbwp35p140hvt_100a/tcbn28hpcbwp35p140hvt.mdt \
                     $KITSLIB/Front_End/mentor_dft/tcbn28hpcbwp35p140cglvt_100a/tcbn28hpcbwp35p140cglvt.mdt \
	             $KITSLIB/Front_End/mentor_dft/tcbn28hpcbwp35p140cg_100a/tcbn28hpcbwp35p140cg.mdt \
	             $KITSLIB/Front_End/mentor_dft/tcbn28hpcbwp35p140cghvt_100a/tcbn28hpcbwp35p140cghvt.mdt \
	             "		     
   set LIBLEF       "$KITSLIB/Back_End/lef/tcbn28hpcbwp35p140lvt_100a/lef/VHV_0d5_0/tcbn28hpcbwp35p140lvt_8lm5X2ZUTRDL.lef \
                     $KITSLIB/Back_End/lef/tcbn28hpcbwp35p140hvt_100a/lef/VHV_0d5_0/tcbn28hpcbwp35p140hvt_8lm5X2ZUTRDL.lef \
                     $KITSLIB/Back_End/lef/tcbn28hpcbwp35p140_100a/lef/VHV_0d5_0/tcbn28hpcbwp35p140_8lm5X2ZUTRDL.lef \
                     $KITSLIB/Back_End/lef/tcbn28hpcbwp35p140cglvt_100a/lef/VHV_0d5_0/tcbn28hpcbwp35p140cglvt_8lm5X2ZUTRDL.lef \
                     $KITSLIB/Back_End/lef/tcbn28hpcbwp35p140cghvt_100a/lef/VHV_0d5_0/tcbn28hpcbwp35p140cghvt_8lm5X2ZUTRDL.lef \
                     $KITSLIB/Back_End/lef/tcbn28hpcbwp35p140cg_100a/lef/VHV_0d5_0/tcbn28hpcbwp35p140cg_8lm5X2ZUTRDL.lef \
                     "		     
   set LIBLIB       "$KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140lvt_100a \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140hvt_100a \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140_100a \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140cglvt_100a \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140cghvt_100a \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140cg_100a \
                     "		     
   set SLOWLIB      "tcbn28hpcbwp35p140lvtssg0p81vm40c.lib \
                     tcbn28hpcbwp35p140hvtssg0p81vm40c.lib \
                     tcbn28hpcbwp35p140ssg0p81vm40c.lib \
		     tcbn28hpcbwp35p140ssg0p81v0p81vm40c.lib \
		     tcbn28hpcbwp35p140hvtssg0p81v0p81vm40c.lib \
		     tcbn28hpcbwp35p140lvtssg0p81v0p81vm40c.lib \
                     tcbn28hpcbwp35p140cglvtssg0p81vm40c.lib \
                     tcbn28hpcbwp35p140cghvtssg0p81vm40c.lib \
                     tcbn28hpcbwp35p140cgssg0p81vm40c.lib \
                     "		     
   set TYPLIB       "tcbn28hpcbwp35p140lvttt0p9v25c.lib \
 		     tcbn28hpcbwp35p140hvttt0p9v25c.lib \
 		     tcbn28hpcbwp35p140tt0p9v25c.lib \
		     tcbn28hpcbwp35p140hvttt0p9v0p9v25c.lib \
		     tcbn28hpcbwp35p140lvttt0p9v0p9v25c.lib \
		     tcbn28hpcbwp35p140tt0p9v0p9v25c.lib \
 		     tcbn28hpcbwp35p140cglvttt0p9v25c.lib \
 		     tcbn28hpcbwp35p140cghvttt0p9v25c.lib \
 		     tcbn28hpcbwp35p140cgtt0p9v25c.lib \
 		     "		     	
   set FASTLIB      "tcbn28hpcbwp35p140lvtff0p99v0c.lib \
                     tcbn28hpcbwp35p140hvtff0p99v0c.lib \
                     tcbn28hpcbwp35p140ff0p99v0c.lib \
		     tcbn28hpcbwp35p140lvtff0p99v0p99v0c.lib \
		     tcbn28hpcbwp35p140hvtff0p99v0p99v0c.lib \
		     tcbn28hpcbwp35p140ff0p99v0p99v0c.lib \
                     tcbn28hpcbwp35p140cglvtff0p99v0c.lib \
                     tcbn28hpcbwp35p140cghvtff0p99v0c.lib \
                     tcbn28hpcbwp35p140cgff0p99v0c.lib \
                     "		     
   set EDI_SLOWLIB  "$KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140lvt_100a/tcbn28hpcbwp35p140lvtssg0p81vm40c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140hvt_100a/tcbn28hpcbwp35p140hvtssg0p81vm40c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140_100a/tcbn28hpcbwp35p140ssg0p81vm40c.lib \
		     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140lvt_100a/tcbn28hpcbwp35p140lvtssg0p81v0p81vm40c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140hvt_100a/tcbn28hpcbwp35p140hvtssg0p81v0p81vm40c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140_100a/tcbn28hpcbwp35p140ssg0p81v0p81vm40c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140cglvt_100a/tcbn28hpcbwp35p140cglvtssg0p81vm40c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140cghvt_100a/tcbn28hpcbwp35p140cghvtssg0p81vm40c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140cg_100a/tcbn28hpcbwp35p140cgssg0p81vm40c.lib \
                     "		     
   set EDI_TYPLIB   "$KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140lvt_100a/tcbn28hpcbwp35p140lvttt0p9v25c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140hvt_100a/tcbn28hpcbwp35p140hvttt0p9v25c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140_100a/tcbn28hpcbwp35p140tt0p9v25c.lib \
		     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140lvt_100a/tcbn28hpcbwp35p140lvttt0p9v0p9v25c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140hvt_100a/tcbn28hpcbwp35p140hvttt0p9v0p9v25c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140_100a/tcbn28hpcbwp35p140tt0p9v0p9v25c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140cglvt_100a/tcbn28hpcbwp35p140cglvttt0p9v25c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140cghvt_100a/tcbn28hpcbwp35p140cghvttt0p9v25c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140cg_100a/tcbn28hpcbwp35p140cgtt0p9v25c.lib \
                     "			     	     		     
   set EDI_FASTLIB  "$KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140lvt_100a/tcbn28hpcbwp35p140lvtff0p99v0c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140hvt_100a/tcbn28hpcbwp35p140hvtff0p99v0c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140_100a/tcbn28hpcbwp35p140ff0p99v0c.lib \
		     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140lvt_100a/tcbn28hpcbwp35p140lvtff0p99v0p99v0c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140hvt_100a/tcbn28hpcbwp35p140hvtff0p99v0p99v0c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140_100a/tcbn28hpcbwp35p140ff0p99v0p99v0c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140cglvt_100a/tcbn28hpcbwp35p140cglvtff0p99v0c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140cghvt_100a/tcbn28hpcbwp35p140cghvtff0p99v0c.lib \
                     $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpcbwp35p140cg_100a/tcbn28hpcbwp35p140cgff0p99v0c.lib \
                     "		     
   set WC_DB        "$KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140lvt_100a/tcbn28hpcbwp35p140lvtssg0p81vm40c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140hvt_100a/tcbn28hpcbwp35p140hvtssg0p81vm40c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140_100a/tcbn28hpcbwp35p140ssg0p81vm40c.cdb \
		     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140lvt_100a/tcbn28hpcbwp35p140lvtssg0p81v0p81vm40c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140hvt_100a/tcbn28hpcbwp35p140hvtssg0p81v0p81vm40c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140_100a/tcbn28hpcbwp35p140ssg0p81v0p81vm40c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140cglvt_100a/tcbn28hpcbwp35p140cglvtssg0p81vm40c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140cghvt_100a/tcbn28hpcbwp35p140cghvtssg0p81vm40c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140cg_100a/tcbn28hpcbwp35p140cgssg0p81vm40c.cdb \
                     "		     
   set TYP_DB       "$KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140lvt_100a/tcbn28hpcbwp35p140lvttt0p9v25c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140hvt_100a/tcbn28hpcbwp35p140hvttt0p9v25c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140_100a/tcbn28hpcbwp35p140tt0p9v25c.cdb \
		     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140lvt_100a/tcbn28hpcbwp35p140lvttt0p9v0p9v25c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140hvt_100a/tcbn28hpcbwp35p140hvttt0p9v0p9v25c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140_100a/tcbn28hpcbwp35p140tt0p9v0p9v25c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140cglvt_100a/tcbn28hpcbwp35p140cglvttt0p9v25c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140cghvt_100a/tcbn28hpcbwp35p140cghvttt0p9v25c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140cg_100a/tcbn28hpcbwp35p140cgtt0p9v25c.cdb \
                     "		     		     		     
   set BC_DB        "$KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140lvt_100a/tcbn28hpcbwp35p140lvtff0p99v0c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140hvt_100a/tcbn28hpcbwp35p140hvtff0p99v0c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140_100a/tcbn28hpcbwp35p140ff0p99v0c.cdb \
		     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140lvt_100a/tcbn28hpcbwp35p140lvtff0p99v0p99v0c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140hvt_100a/tcbn28hpcbwp35p140hvtff0p99v0p99v0c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140_100a/tcbn28hpcbwp35p140ff0p99v0p99v0c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140cglvt_100a/tcbn28hpcbwp35p140cglvtff0p99v0c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140cghvt_100a/tcbn28hpcbwp35p140cghvtff0p99v0c.cdb \
                     $KITSLIB/Back_End/celtic/tcbn28hpcbwp35p140cg_100a/tcbn28hpcbwp35p140cgff0p99v0c.cdb \
                     "		     

   set VDD_values    "0.81 0.99 0.90"
   set TEMP_values   "125 0 25"
   set ss_setup_derate_factor 0.095
   set ss_hold_derate_factor 0.12
   set ff_hold_derate_factor 0.15
   set PROCNODE      28
   set max_route_layer 9
   set DRIVE_CELL    BUFFD4BWP35P140
   set WC_CAP_TABLE  ""
   set WC_QRC_TECH   $KITSLIB/EXTRACTION/cworst/qrcTechFile
   set TYP_CAP_TABLE ""
   set TYP_QRC_TECH  $KITSLIB/EXTRACTION/typical/qrcTechFile   
   set BC_CAP_TABLE  ""
   set BC_QRC_TECH   $KITSLIB/EXTRACTION/cbest/qrcTechFile

   set TIELIST [list \
      "TIEHBWP35P140" \
      "TIELBWP35P140" \
   ]
   set DONT_USE [list \
      "CKAN2D*" \
      "CKBD*" \
      "CKMUX2D*" \
      "CKND2D*" \
      "CKND*" \
      "CKXOR2D*" \
      "DEL*" \
      "GTIE*" \
      "TIE*" \
      "*0BWP35*" \
      "*24BWP*" \
   ]
   set CLK_BUFFERS [list \
      "CKBD4BWP35LVT" \
      "CKBD8BWP35LVT" \
      "CKBD12BWP35LVT" \
      "CKBD16BWP35LVT" \
   ]
      
   set CLK_INVERTERS [list \
      "CKND4BWP35LVT" \
      "CKND8BWP35LVT" \
      "CKND12BWP35LVT" \
      "CKND16BWP35LVT" \
   ]

}

# TSMC28HPM All VT 9-track 8LM library follows
if {$env(TECHNOLOGY) == "SMIC28HK_9T"} then {

   set KITSLIB      /servers/pdk/ext_stdlib/28nm/SMIC/downloads/
   set PMALIB       /projects/sduu02u2y_t28hpm_01_vf180_7020_r100/work/digital_repo_common_chkout/sduu02u2y_t28hpc_01_vf180_7020/ana_macro/usb2_pma_top/v0p0

   set VFILE        "$KITSLIB/06_04_2016/SCC28NHK_HSC35_PMK_RVT_V0p1/verilog/scc28nhk_hsc35_pmk_rvt.v \
                     $KITSLIB/02-02-2015/SCC28NHK_HSC35_RVT_V0.1/SCC28NHK_HSC35_RVT_V0p1/verilog/scc28nhk_hsc35_rvt.v \
                     "
   set ATPGLIB      $VFILE
		     
   set LIBLEF       "$KITSLIB/06_04_2016/SCC28NHK_HSC35_PMK_RVT_V0p1/lef/macro/scc28nhk_hsc35_pmk_rvt.lef \
		     $KITSLIB/02-02-2015/SCC28NHK_HSC35_RVT_V0.1/SCC28NHK_HSC35_RVT_V0p1/lef/macro/scc28nhk_hsc35_rvt.lef \
                     $KITSLIB/06_04_2016/SCC28NHK_HSC35_PMK_RVT_V0p1/lef/tf_tm/m3p135/scc28n_m3p135_8m_6ma_2tm_alpa2.lef \
		     $KITSLIB/02-02-2015/SCC28NHK_HSC35_RVT_V0.1/SCC28NHK_HSC35_RVT_V0p1/lef/tf_stm/m3p135/scc28n_m3p135_8m_6ma_2tm_alpa2.lef \
		     $PMALIB/lef/usb2_pma_top.lef \
                     "		     
   set LIBLIB       "$KITSLIB/06_04_2016/SCC28NHK_HSC35_PMK_RVT_V0p1/liberty/0.9v \
                     $KITSLIB/02-02-2015/SCC28NHK_HSC35_RVT_V0.1/SCC28NHK_HSC35_RVT_V0p1/liberty/0.9v \
                     "		     
   set SLOWLIB      "scc28nhk_hsc35_pmk_rvt_ss_v0p81_-40c_ccs.lib \
                     scc28nhk_hsc35_rvt_ss_v0p81_-40c_ccs.lib \
		     usb2_pma_top_ss0p810vm40c.lib \
                     "		     
   set TYPLIB       "scc28nhk_hsc35_pmk_rvt_tt_v0p9_25c_ccs.lib \
                     scc28nhk_hsc35_rvt_tt_v0p9_25c_ccs.lib \
		     usb2_pma_top_tt0p900v25c_typical.lib \
 		     "		     	
   set FASTLIB      "scc28nhk_hsc35_pmk_rvt_ff_v0p99_0c_ccs.lib \
                     scc28nhk_hsc35_rvt_ff_v0p99_0c_ccs.lib \
		     usb2_pma_top_ff0p990vm40c.lib \
                     "
   set MLLIB        "scc28nhk_hsc35_pmk_rvt_ff_v0p99_125c_ccs.lib \
                     scc28nhk_hsc35_rvt_ff_v0p99_125c_ccs.lib \
		     usb2_pma_top_ff0p990vm40c.lib \
                     "
   set EDI_SLOWLIB  "$KITSLIB/06_04_2016/SCC28NHK_HSC35_PMK_RVT_V0p1/liberty/0.9v/scc28nhk_hsc35_pmk_rvt_ss_v0p81_-40c_ccs.lib \
                     $KITSLIB/02-02-2015/SCC28NHK_HSC35_RVT_V0.1/SCC28NHK_HSC35_RVT_V0p1/liberty/0.9v/scc28nhk_hsc35_rvt_ss_v0p81_-40c_ccs.lib \
                     $PMALIB/libs/usb2_pma_top_ss0p810vm40c.lib \
		     "		     
   set EDI_TYPLIB   "$KITSLIB/06_04_2016/SCC28NHK_HSC35_PMK_RVT_V0p1/liberty/0.9v/scc28nhk_hsc35_pmk_rvt_tt_v0p9_25c_ccs.lib \
                     $KITSLIB/02-02-2015/SCC28NHK_HSC35_RVT_V0.1/SCC28NHK_HSC35_RVT_V0p1/liberty/0.9v/scc28nhk_hsc35_rvt_tt_v0p9_25c_ccs.lib \
                     $PMALIB/libs/usb2_pma_top_tt0p900v25c_typical.lib \
		     "			     	     		     
   set EDI_FASTLIB  "$KITSLIB/06_04_2016/SCC28NHK_HSC35_PMK_RVT_V0p1/liberty/0.9v/scc28nhk_hsc35_pmk_rvt_ff_v0p99_0c_ccs.lib \
                     $KITSLIB/02-02-2015/SCC28NHK_HSC35_RVT_V0.1/SCC28NHK_HSC35_RVT_V0p1/liberty/0.9v/scc28nhk_hsc35_rvt_ff_v0p99_0c_ccs.lib \
                     $PMALIB/libs/usb2_pma_top_ff0p990vm40c.lib \
		     "
   set EDI_MLLIB    "$KITSLIB/06_04_2016/SCC28NHK_HSC35_PMK_RVT_V0p1/liberty/0.9v/scc28nhk_hsc35_pmk_rvt_ff_v0p99_125c_ccs.lib \
                     $KITSLIB/02-02-2015/SCC28NHK_HSC35_RVT_V0.1/SCC28NHK_HSC35_RVT_V0p1/liberty/0.9v/scc28nhk_hsc35_rvt_ff_v0p99_125c_ccs.lib \
                     $PMALIB/libs/usb2_pma_top_ff0p990vm40c.lib \
		     "
   set WC_DB        "$KITSLIB/06_04_2016/SCC28NHK_HSC35_PMK_RVT_V0p1/cdb/0.9v/scc28nhk_hsc35_pmk_rvt_ss_v0p81_-40c.cdb \
                     $KITSLIB/02-02-2015/SCC28NHK_HSC35_RVT_V0.1/SCC28NHK_HSC35_RVT_V0p1/cdb/0.9v/scc28nhk_hsc35_rvt_ss_v0p81_-40c.cdb \
                     "		     
   set TYP_DB       "$KITSLIB/06_04_2016/SCC28NHK_HSC35_PMK_RVT_V0p1/cdb/0.9v/scc28nhk_hsc35_pmk_rvt_tt_v0p9_25c.cdb \
                     $KITSLIB/02-02-2015/SCC28NHK_HSC35_RVT_V0.1/SCC28NHK_HSC35_RVT_V0p1/cdb/0.9v/scc28nhk_hsc35_rvt_tt_v0p9_25c.cdb \
                     "		     		     		     
   set BC_DB        "$KITSLIB/06_04_2016/SCC28NHK_HSC35_PMK_RVT_V0p1/cdb/0.9v/scc28nhk_hsc35_pmk_rvt_ff_v0p99_0c.cdb \
                     $KITSLIB/02-02-2015/SCC28NHK_HSC35_RVT_V0.1/SCC28NHK_HSC35_RVT_V0p1/cdb/0.9v/scc28nhk_hsc35_rvt_ff_v0p99_0c.cdb \
                     "		     

   set VDD_values    "0.81 0.9 0.99"
   set TEMP_values   "-40 0 25"
   set ss_setup_derate_factor 0.095
   set ss_hold_derate_factor 0.12
   set ff_hold_derate_factor 0.15
   set PROCNODE      28
   set max_route_layer 9
   set DRIVE_CELL    BUFV7_9TR35
   #set WC_CAP_TABLE  $KITSLIB/common/captables/v0p2/1P8M_6Ma_6Ic_2TMc_ALPA2/QRC_28HKMG_1P8M_6Ic_2TMc_ALPA1_CMAX_tran.captbl
   set WC_QRC_TECH   /process/smic/smic28/hk/QRC/1P8M_6Ma_6Ic_2TMc_ALPA2/dig_VER1p0_0R/rulefiles/CMAX/qrcTechFile
   #set TYP_CAP_TABLE $KITSLIB/common/captables/v0p2/1P8M_6Ma_6Ic_2TMc_ALPA2/QRC_28HKMG_1P8M_6Ic_2TMc_ALPA1_TYP_tran.captbl
   set TYP_QRC_TECH  /process/smic/smic28/hk/QRC/1P8M_6Ma_6Ic_2TMc_ALPA2/dig_VER1p0_0R/rulefiles/TYPICAL/qrcTechFile  
   #set BC_CAP_TABLE  $KITSLIB/common/captables/v0p2/1P8M_6Ma_6Ic_2TMc_ALPA2/QRC_28HKMG_1P8M_6Ic_2TMc_ALPA1_CMIN_tran.captbl
   set BC_QRC_TECH   /process/smic/smic28/hk/QRC/1P8M_6Ma_6Ic_2TMc_ALPA2/dig_VER1p0_0R/rulefiles/CMIN/qrcTechFile

    set TIELIST [list \
       "PULL0_9TR35" \
       "PULL1_9TR35" \
    ]
    set DONT_USE [list "*V0*"\
    ]
    set CLK_BUFFERS [list \
       "CLKBUFV*RQ_9TR35" \
    ]
       
    set CLK_INVERTERS [list \
       "CLKINV*_9TL35" \
   ]


}

 # TSMC28HPM All VT 12-track 8LM library follows
 if {$env(TECHNOLOGY) == "FDSOI28HPM"} then {

    set KITSLIB      /vols/cosmic_pdk/stdcell/SAMSUNG/28nm/28FDSOI/V4.0/
    set PMALIB       /process/tsmc16ff/rscratch/radhikap/28nm/ana_macro/usb2_pma_top/v0p0

    set VFILE	     "$KITSLIB/verilog/C28SOI_SC_12_COREPBP10_LL_allpins.v \
 		      $KITSLIB/verilog/C28SOI_SC_12_CORHPPBP10_LL_allpins.v \
 		      "		      
    set ATPGLIB      "" 		      	      
    set LIBLEF       "$PMALIB/lef/usb2_pma_top.lef
 		      "		      
    set LIBLIB       "$KITSLIB/libs \
 		      $KITSLIB/libs \
 		      $KITSLIB/libs \
		      $PMALIB/libs"		      
    set SLOWLIB      "C28SOI_SC_12_COREPBP10_LL_ss28_0.80V_0.00V_0.00V_0.00V_m40C.lib \
 		      C28SOI_SC_12_CORHPPBP10_LL_ss28_0.80V_0.00V_0.00V_0.00V_m40C.lib \
		      C28SOI_SC_12_CLK_LL_ss28_0.80V_0.00V_0.00V_0.00V_m40C.lib \
		      usb2_pma_top_ss0p72vm40c.lib
 		      "		      
    set TYPLIB       "C28SOI_SC_12_COREPBP10_LL_tt28_0.90V_0.00V_0.00V_0.00V_25C.lib \
 		      C28SOI_SC_12_CORHPPBP10_LL_tt28_0.90V_0.00V_0.00V_0.00V_25C.lib \
 		      C28SOI_SC_12_CLK_LL_tt28_0.90V_0.00V_0.00V_0.00V_25C.lib \
		      usb2_pma_top_tt0p85v25c.lib
 		      "			      	      
    set FASTLIB      "C28SOI_SC_12_COREPBP10_LL_ff28_1.00V_0.00V_0.00V_0.00V_m40C.lib \
 		      C28SOI_SC_12_CORHPPBP10_LL_ff28_1.00V_0.00V_0.00V_0.00V_m40C.lib \
 		      C28SOI_SC_12_CLK_LL_ff28_1.00V_0.00V_0.00V_0.00V_m40C.lib \
		      usb2_pma_top_ff0p935vm40c.lib
 		      "		      
    set EDI_SLOWLIB  "$KITSLIB/libs/C28SOI_SC_12_COREPBP10_LL_ss28_0.80V_0.00V_0.00V_0.00V_m40C.lib \
 		      $KITSLIB/libs/C28SOI_SC_12_CORHPPBP10_LL_ss28_0.80V_0.00V_0.00V_0.00V_m40C.lib \
 		      $KITSLIB/libs/C28SOI_SC_12_CLK_LL_ss28_0.80V_0.00V_0.00V_0.00V_m40C.lib \
		      $PMALIB/libs/usb2_pma_top_ss0p72vm40c.lib
 		      "		      
    set EDI_TYPLIB   "$KITSLIB/libs/C28SOI_SC_12_COREPBP10_LL_tt28_0.90V_0.00V_0.00V_0.00V_25C.lib \
 		      $KITSLIB/libs/C28SOI_SC_12_CORHPPBP10_LL_tt28_0.90V_0.00V_0.00V_0.00V_25C.lib \
 		      $KITSLIB/libs/C28SOI_SC_12_CLK_LL_tt28_0.90V_0.00V_0.00V_0.00V_25C.lib \
		      $PMALIB/libs/usb2_pma_top_tt0p85v25c.lib"
		      			     	     		     
    set EDI_FASTLIB  "$KITSLIB/libs/C28SOI_SC_12_COREPBP10_LL_ff28_1.00V_0.00V_0.00V_0.00V_m40C.lib \
 		      $KITSLIB/libs/C28SOI_SC_12_CORHPPBP10_LL_ff28_1.00V_0.00V_0.00V_0.00V_m40C.lib \
 		      $KITSLIB/libs/C28SOI_SC_12_CLK_LL_ff28_1.00V_0.00V_0.00V_0.00V_m40C.lib \
		      $PMALIB/libs/usb2_pma_top_ff0p935vm40c.lib"
		      		      
    set WC_DB	     ""		      
    set TYP_DB       ""			      
    set BC_DB	     ""		      

    set VDD_values "0.9 1.0 1.1"
    set TEMP_values "-40 25 125"
    set ss_setup_derate_factor 0.095
    set ss_hold_derate_factor 0.12
    set ff_hold_derate_factor 0.15
    set PROCNODE      28
    set max_route_layer 9
    set DRIVE_CELL    C12T28SOI_LL_BFX4_P10
   # set WC_CAP_TABLE  $KITSLIB/EXTRACTION/cworst/cln28hpm_1p08m_ut_alrdl_5x2z_cworst.captable
    #set WC_QRC_TECH   $KITSLIB/EXTRACTION/cworst/qrcTechFile
   # set TYP_CAP_TABLE $KITSLIB/EXTRACTION/typical/cln28hpm_1p08m_ut_alrdl_5x2z_typical.captable
   # set TYP_QRC_TECH  $KITSLIB/EXTRACTION/typical/qrcTechFile   
   # set BC_CAP_TABLE  $KITSLIB/EXTRACTION/cbest/cln28hpm_1p08m_ut_alrdl_5x2z_cbest.captable
   # set BC_QRC_TECH   $KITSLIB/EXTRACTION/cbest/qrcTechFile

    set TIELIST [list ]
    set DONT_USE [list ]
    set CLK_BUFFERS [list ]
       
    set CLK_INVERTERS [list ]

 }
 
if {$env(TECHNOLOGY) == "TSMC28HPC_7T"} then {

   set KITSLIB       /process/stdcell/tsmc/28nm/n28hpc/TSMC
   set PMALIB        /projects/sduu02u2y_t28hpm_01_vf180_7020_r100/work/digital_repo_common_chkout/sduu02u2y_t28hpc_01_vf180_7020/ana_macro/usb2_pma_top/v0p0

   set VFILE        "$KITSLIB/tcbn28hpcbwp7t40p140_100c/verilog/tcbn28hpcbwp7t40p140.v \
		     $KITSLIB/tcbn28hpcbwp7t40p140hvt_100c/verilog/tcbn28hpcbwp7t40p140hvt.v \
		     $KITSLIB/tcbn28hpcbwp7t40p140lvt_100c/verilog/tcbn28hpcbwp7t40p140lvt.v \
		     $PMALIB/verilog/usb2_pma_top.v \
		     "
   set ATPGLIB      "$KITSLIB/tcbn28hpcbwp7t40p140_100c/mentor_dft/tcbn28hpcbwp7t40p140.mdt \
		     $KITSLIB/tcbn28hpcbwp7t40p140hvt_100c/mentor_dft/tcbn28hpcbwp7t40p140hvt.mdt \
		     $KITSLIB/tcbn28hpcbwp7t40p140lvt_100c/mentor_dft/tcbn28hpcbwp7t40p140lvt.mdt \
		     "		     
   set LIBLEF       "$KITSLIB/tcbn28hpcbwp7t40p140_100c/lef/tcbn28hpcbwp7t40p140_9lm6X2ZUTRDL.lef \
   		     $KITSLIB/tcbn28hpcbwp7t40p140_100c/lef/tcbn28hpcbwp7t40p140.macro.lef \
   		     $KITSLIB/tcbn28hpcbwp7t40p140hvt_100c/lef/tcbn28hpcbwp7t40p140hvt_9lm6X2ZUTRDL.lef \
   		     $KITSLIB/tcbn28hpcbwp7t40p140hvt_100c/lef/tcbn28hpcbwp7t40p140hvt.macro.lef \
   		     $KITSLIB/tcbn28hpcbwp7t40p140lvt_100c/lef/tcbn28hpcbwp7t40p140lvt_9lm6X2ZUTRDL.lef \
   		     $KITSLIB/tcbn28hpcbwp7t40p140lvt_100c/lef/tcbn28hpcbwp7t40p140lvt.macro.lef \
   		     $PMALIB/lef/usb2_pma_top.lef \
		     "		     
   set LIBLIB       "$KITSLIB/tcbn28hpcbwp7t40p140_100c/ecsm/ \
                     $KITSLIB/tcbn28hpcbwp7t40p140hvt_100c/ecsm/ \
                     $KITSLIB/tcbn28hpcbwp7t40p140lvt_100c/ecsm/ \
                     $KITSLIB/tcbn28hpcbwp7t40p140_100c/ecsm/ \
                     $KITSLIB/tcbn28hpcbwp7t40p140hvt_100c/ecsm/ \
                     $KITSLIB/tcbn28hpcbwp7t40p140lvt_100c/ecsm/ \
                     $PMALIB/libs/ \
		     "		     
   set SLOWLIB      "tcbn28hpcbwp7t40p140ssg0p81vm40c_ecsm.lib \
                     tcbn28hpcbwp7t40p140hvtssg0p81vm40c_ecsm.lib \
                     tcbn28hpcbwp7t40p140lvtssg0p81vm40c_ecsm.lib \
                     tcbn28hpcbwp7t40p140ssg0p81v0p81vm40c_ecsm.lib \
                     tcbn28hpcbwp7t40p140hvtssg0p81v0p81vm40c_ecsm.lib \
                     tcbn28hpcbwp7t40p140lvtssg0p81v0p81vm40c_ecsm.lib \
                     usb2_pma_top_ss0p810vm40c_typical.lib \
		     "		     
   set TYPLIB       "tcbn28hpcbwp7t40p140tt0p9v25c_ecsm.lib \
                     tcbn28hpcbwp7t40p140hvttt0p9v25c_ecsm.lib \
                     tcbn28hpcbwp7t40p140lvttt0p9v25c_ecsm.lib \
                     tcbn28hpcbwp7t40p140tt0p9v0p9v25c_ecsm.lib \
                     tcbn28hpcbwp7t40p140hvttt0p9v0p9v25c_ecsm.lib \
                     tcbn28hpcbwp7t40p140lvttt0p9v0p9v25c_ecsm.lib \
                     usb2_pma_top_tt0p900v25c_typical.lib \
		     "		     	
   set FASTLIB      "tcbn28hpcbwp7t40p140ff0p99vm40c_ecsm.lib \
                     tcbn28hpcbwp7t40p140hvtff0p99vm40c_ecsm.lib \
                     tcbn28hpcbwp7t40p140lvtff0p99vm40c_ecsm.lib \
                     tcbn28hpcbwp7t40p140ff0p99v0p99vm40c_ecsm.lib \
                     tcbn28hpcbwp7t40p140hvtff0p99v0p99vm40c_ecsm.lib \
                     tcbn28hpcbwp7t40p140lvtff0p99v0p99vm40c_ecsm.lib \
                     usb2_pma_top_ff0p990vm40c_typical.lib \
		     "		     
   set MLLIB        "tcbn28hpcbwp7t40p140ff0p99v125c_ecsm.lib \
                     tcbn28hpcbwp7t40p140hvtff0p99v125c_ecsm.lib \
                     tcbn28hpcbwp7t40p140lvtff0p99v125c_ecsm.lib \
                     tcbn28hpcbwp7t40p140ff0p99v0p99v125c_ecsm.lib \
                     tcbn28hpcbwp7t40p140hvtff0p99v0p99v125c_ecsm.lib \
                     tcbn28hpcbwp7t40p140lvtff0p99v0p99v125c_ecsm.lib \
                     usb2_pma_top_ff0p990v125c_typical.lib \
		     "		     
   set EDI_SLOWLIB  "$KITSLIB/tcbn28hpcbwp7t40p140_100c/ecsm/tcbn28hpcbwp7t40p140ssg0p81vm40c_ecsm.lib \
                     $KITSLIB/tcbn28hpcbwp7t40p140hvt_100c/ecsm/tcbn28hpcbwp7t40p140hvtssg0p81vm40c_ecsm.lib \
		     $KITSLIB/tcbn28hpcbwp7t40p140lvt_100c/ecsm/tcbn28hpcbwp7t40p140lvtssg0p81vm40c_ecsm.lib \
		     $KITSLIB/tcbn28hpcbwp7t40p140_100c/ecsm/tcbn28hpcbwp7t40p140ssg0p81v0p81vm40c_ecsm.lib \
                     $KITSLIB/tcbn28hpcbwp7t40p140hvt_100c/ecsm/tcbn28hpcbwp7t40p140hvtssg0p81v0p81vm40c_ecsm.lib \
		     $KITSLIB/tcbn28hpcbwp7t40p140lvt_100c/ecsm/tcbn28hpcbwp7t40p140lvtssg0p81v0p81vm40c_ecsm.lib \
		     $PMALIB/libs/usb2_pma_top_ss0p810vm40c_typical.lib \
		     "		     
   set EDI_TYPLIB   "$KITSLIB/tcbn28hpcbwp7t40p140_100c/ecsm/tcbn28hpcbwp7t40p140tt0p9v25c_ecsm.lib \
                     $KITSLIB/tcbn28hpcbwp7t40p140hvt_100c/ecsm/tcbn28hpcbwp7t40p140hvttt0p9v25c_ecsm.lib \
		     $KITSLIB/tcbn28hpcbwp7t40p140lvt_100c/ecsm/tcbn28hpcbwp7t40p140lvttt0p9v25c_ecsm.lib \
		     $KITSLIB/tcbn28hpcbwp7t40p140_100c/ecsm/tcbn28hpcbwp7t40p140tt0p9v0p9v25c_ecsm.lib \
                     $KITSLIB/tcbn28hpcbwp7t40p140hvt_100c/ecsm/tcbn28hpcbwp7t40p140hvttt0p9v0p9v25c_ecsm.lib \
		     $KITSLIB/tcbn28hpcbwp7t40p140lvt_100c/ecsm/tcbn28hpcbwp7t40p140lvttt0p9v0p9v25c_ecsm.lib \
		     $PMALIB/libs/usb2_pma_top_tt0p900v25c_typical.lib \
		     "			     	     		     
   set EDI_FASTLIB  "$KITSLIB/tcbn28hpcbwp7t40p140_100c/ecsm/tcbn28hpcbwp7t40p140ff0p99vm40c_ecsm.lib \
                     $KITSLIB/tcbn28hpcbwp7t40p140hvt_100c/ecsm/tcbn28hpcbwp7t40p140hvtff0p99vm40c_ecsm.lib \
		     $KITSLIB/tcbn28hpcbwp7t40p140lvt_100c/ecsm/tcbn28hpcbwp7t40p140lvtff0p99vm40c_ecsm.lib \
		     $KITSLIB/tcbn28hpcbwp7t40p140_100c/ecsm/tcbn28hpcbwp7t40p140ff0p99v0p99vm40c_ecsm.lib \
                     $KITSLIB/tcbn28hpcbwp7t40p140hvt_100c/ecsm/tcbn28hpcbwp7t40p140hvtff0p99v0p99vm40c_ecsm.lib \
		     $KITSLIB/tcbn28hpcbwp7t40p140lvt_100c/ecsm/tcbn28hpcbwp7t40p140lvtff0p99v0p99vm40c_ecsm.lib \
		     $PMALIB/libs/usb2_pma_top_ff0p990vm40c_typical.lib \
		     "		     
   set EDI_MLLIB    "$KITSLIB/tcbn28hpcbwp7t40p140_100c/ecsm/tcbn28hpcbwp7t40p140ff0p99v125c_ecsm.lib \
                     $KITSLIB/tcbn28hpcbwp7t40p140hvt_100c/ecsm/tcbn28hpcbwp7t40p140hvtff0p99v125c_ecsm.lib \
		     $KITSLIB/tcbn28hpcbwp7t40p140lvt_100c/ecsm/tcbn28hpcbwp7t40p140lvtff0p99v125c_ecsm.lib \
		     $KITSLIB/tcbn28hpcbwp7t40p140_100c/ecsm/tcbn28hpcbwp7t40p140ff0p99v0p99v125c_ecsm.lib \
                     $KITSLIB/tcbn28hpcbwp7t40p140hvt_100c/ecsm/tcbn28hpcbwp7t40p140hvtff0p99v0p99v125c_ecsm.lib \
		     $KITSLIB/tcbn28hpcbwp7t40p140lvt_100c/ecsm/tcbn28hpcbwp7t40p140lvtff0p99v0p99v125c_ecsm.lib \
		     $PMALIB/libs/usb2_pma_top_ff0p990v125c_typical.lib \
		     "		     
   set WC_DB        ""		     
   set TYP_DB       ""		     		     		     
   set BC_DB        ""		     
# since we are using ecsm, we dont need noise characteristics during synth.
   set VDD_values    "0.81 0.99 0.90"
   set TEMP_values   "-40 0 25"
   set ss_setup_derate_factor 0.095
   set ss_hold_derate_factor 0.12
   set ff_hold_derate_factor 0.15
   set PROCNODE      28
   set max_route_layer 9
   set DRIVE_CELL    BUFFD4BWP7T40P140
   set WC_CAP_TABLE  ""
   set WC_QRC_TECH   "__REPLACE__"
   set TYP_CAP_TABLE ""
   set TYP_QRC_TECH  "__REPLACE__"   
   set BC_CAP_TABLE  ""
   set BC_QRC_TECH   "__REPLACE__"

   set TIELIST [list \
      "TIEHBWP7T40P140" \
      "TIELBWP7T40P140" \
   ]
   set DONT_USE [list \
      "CKAN2D*" \
      "CKBD*" \
      "CKMUX2D*" \
      "CKND2D*" \
      "CKND*" \
      "CKXOR2D*" \
      "DEL*" \
      "GTIE*" \
      "TIE*" \
      "*0BWP7T40*" \
   ]
   set CLK_BUFFERS [list \
      "CKBD4BWP7T40" \
      "CKBD8BWP7T40" \
      "CKBD12BWP7T40" \
      "CKBD16BWP7T40" \
   ]
      
   set CLK_INVERTERS [list \
      "CKND4BWP7T40" \
      "CKND8BWP7T40" \
      "CKND12BWP7T40" \
      "CKND16BWP7T40" \
   ]

}

if {$env(TECHNOLOGY) == "FDSOI28HPM_8T"} then {

   set KITSLIB       /servers/pdk/ext_stdlib/28nm/SAMSUNG/FDSOI/FSL
   set PMALIB        /projects/sduu02u2y_t28hpm_01_vf180_7020_r100/work/digital_repo_common_chkout/sduu02u2y_t28hpc_01_vf180_7020/ana_macro/usb2_pma_top/v0p0

   set VFILE        "$KITSLIB/C28SOI_SC_8_P10_LR/SEC2.6.1/verilog/C28SOI_SC_8_COREPBP10_LR_allpins.v \
                     $KITSLIB/C28SOI_SC_8_P4_LR/SEC2.6.1/verilog/C28SOI_SC_8_COREPBP4_LR_allpins.v \
                     $PMALIB/verilog/usb2_pma_top.v \
                     "
   set ATPGLIB      $VFILE
   set LIBLEF       "$KITSLIB/common/lef/6U1x_2U2x_2T8x_LB/technology.14.lef \
                     $KITSLIB/common/lef/6U1x_2U2x_2T8x_LB/viarule_generate.lef \
                     $KITSLIB/common/lef/6U1x_2U2x_2T8x_LB/site.lef \
                     $KITSLIB/C28SOI_SC_8_P10_LR/SEC2.6.1/lef/C28SOI_SC_8_COREPBP10_LR_soc.lef \
                     $KITSLIB/C28SOI_SC_8_P4_LR/SEC2.6.1/lef/C28SOI_SC_8_COREPBP4_LR_soc.lef \
   		     $PMALIB/lef/usb2_pma_top.lef \
                     "
   set LIBLIB       "$KITSLIB/C28SOI_SC_8_P10_LR/SEC2.6.1/libs/ \
                     $KITSLIB/C28SOI_SC_8_P4_LR/SEC2.6.1/libs/ \
                     $PMALIB/libs/ \
                     "
   set SLOWLIB      "C28SOI_SC_8_COREPBP10_LR_ss28_0.90V_m40C_2ey.lib \
                     C28SOI_SC_8_CORI_LR_ss28_0.90V_m40C_2ey.lib \
                     C28SOI_SC_8_COREPBP4_LR_ss28_0.90V_m40C_2ey.lib \
                     C28SOI_SC_8_CORI_LR_ss28_0.90V_m40C_2ey.lib \
                     usb2_pma_top_ss0p810vm40c_typical.lib \
                     "
   set TYPLIB       "C28SOI_SC_8_COREPBP10_LR_tt28_1.00V_25C.lib \
 		     C28SOI_SC_8_CORI_LR_tt28_1.00V_25C.lib \
                     C28SOI_SC_8_COREPBP4_LR_tt28_1.00V_25C.lib \
                     C28SOI_SC_8_CORI_LR_ss28_tt28_1.00V_25C.lib \
                     usb2_pma_top_tt0p900v25c_typical.lib \
                     "	
   set FASTLIB      "C28SOI_SC_8_COREPBP10_LR_ff28_1.10V_m40C.lib \
 		     C28SOI_SC_8_CORI_LR_ff28_1.10V_m40C.lib \
                     C28SOI_SC_8_COREPBP4_LR_ff28_1.10V_m40C.lib \
                     C28SOI_SC_8_CORI_LR_ss28_ff28_1.10V_m40C.lib \
                     usb2_pma_top_ff0p990vm40c_typical.lib \
                     "
   set MLLIB        "C28SOI_SC_8_COREPBP10_LR_ff28_1.10V_125C.lib \
 		     C28SOI_SC_8_CORI_LR_ff28_1.10V_125C.lib \
                     C28SOI_SC_8_COREPBP4_LR_ff28_1.10V_125C.lib \
                     C28SOI_SC_8_CORI_LR_ss28_ff28_1.10V_125C.lib \
                     usb2_pma_top_ff0p990v125c_typical.lib \
		     "		     
   set EDI_SLOWLIB  "$KITSLIB/C28SOI_SC_8_P10_LR/SEC2.6.1/libs/C28SOI_SC_8_COREPBP10_LR_ss28_0.90V_m40C_2ey.lib \
                     $KITSLIB/C28SOI_SC_8_P10_LR/SEC2.6.1/libs/C28SOI_SC_8_CORI_LR_ss28_0.90V_m40C_2ey.lib \
                     $KITSLIB/C28SOI_SC_8_P4_LR/SEC2.6.1/libs/C28SOI_SC_8_COREPBP4_LR_ss28_0.90V_m40C_2ey.lib \
                     $KITSLIB/C28SOI_SC_8_P4_LR/SEC2.6.1/libs/C28SOI_SC_8_CORI_LR_ss28_0.90V_m40C_2ey.lib \
                     $PMALIB/libs/usb2_pma_top_ss0p810vm40c_typical.lib \
		     "
   set EDI_TYPLIB   "$KITSLIB/C28SOI_SC_8_P10_LR/SEC2.6.1/libs/C28SOI_SC_8_COREPBP10_LR_tt28_1.00V_25C.lib \
                     $KITSLIB/C28SOI_SC_8_P10_LR/SEC2.6.1/libs/C28SOI_SC_8_CORI_LR_tt28_1.00V_25C.lib \
                     $KITSLIB/C28SOI_SC_8_P4_LR/SEC2.6.1/libs/C28SOI_SC_8_COREPBP4_LR_tt28_1.00V_25C.lib \
                     $KITSLIB/C28SOI_SC_8_P4_LR/SEC2.6.1/libs/C28SOI_SC_8_CORI_LR_tt28_1.00V_25C.lib \
                     $PMALIB/libs/usb2_pma_top_tt0p900v25c_typical.lib \
		     "		     		     
   set EDI_FASTLIB  "$KITSLIB/C28SOI_SC_8_P10_LR/SEC2.6.1/libs/C28SOI_SC_8_COREPBP10_LR_ff28_1.10V_m40C.lib \
                     $KITSLIB/C28SOI_SC_8_P10_LR/SEC2.6.1/libs/C28SOI_SC_8_CORI_LR_ff28_1.10V_m40C.lib \
                     $KITSLIB/C28SOI_SC_8_P4_LR/SEC2.6.1/libs/C28SOI_SC_8_COREPBP4_LR_ff28_1.10V_m40C.lib \
                     $KITSLIB/C28SOI_SC_8_P4_LR/SEC2.6.1/libs/C28SOI_SC_8_CORI_LR_ff28_1.10V_m40C.lib \
                     $PMALIB/libs/usb2_pma_top_ff0p990vm40c_typical.lib \
		     "
   set EDI_MLLIB    "$KITSLIB/C28SOI_SC_8_P10_LR/SEC2.6.1/libs/C28SOI_SC_8_COREPBP10_LR_ff28_1.10V_125C.lib \
                     $KITSLIB/C28SOI_SC_8_P10_LR/SEC2.6.1/libs/C28SOI_SC_8_CORI_LR_ff28_1.10V_125C.lib \
                     $KITSLIB/C28SOI_SC_8_P4_LR/SEC2.6.1/libs/C28SOI_SC_8_COREPBP4_LR_ff28_1.10V_125C.lib \
                     $KITSLIB/C28SOI_SC_8_P4_LR/SEC2.6.1/libs/C28SOI_SC_8_CORI_LR_ff28_1.10V_125C.lib \
                     $PMALIB/libs/usb2_pma_top_ff0p990v125c_typical.lib \
		     "
   set WC_DB        "$KITSLIB/Back_End/celtic/tcbn55lplvt_200a/tcbn55lplvtwc.cdb \
                     $KITSLIB/Back_End/celtic/tcbn55lphvt_200a/tcbn55lphvtwc.cdb \
                     $KITSLIB/Back_End/celtic/tcbn55lp_200a/tcbn55lpwc.cdb \
                     "
   set BC_DB        "$KITSLIB/Back_End/celtic/tcbn55lplvt_200a/tcbn55lplvtbc.cdb \
                     $KITSLIB/Back_End/celtic/tcbn55lphvt_200a/tcbn55lphvtbc.cdb \
                     $KITSLIB/Back_End/celtic/tcbn55lp_200a/tcbn55lpbc.cdb \
                     "

   set VDD_values  "0.9 1.0 1.1"
   set TEMP_values "-40 25 125"
   set ss_setup_derate_factor 0.095
   set ss_hold_derate_factor 0.12
   set ff_hold_derate_factor 0.15
   set PROCNODE      28
   set max_route_layer 9
   set DRIVE_CELL    C12T28SOI_LL_BFX4_P10
   set WC_CAP_TABLE  ""
   set WC_QRC_TECH   "/servers/pdk/ext_stdlib/28nm/SAMSUNG/FDSOI/FSL/common/Qrctechfiles/6U1x_2U2x_2T8x_LB/FuncCmin.tech"
   set TYP_CAP_TABLE  ""
   set TYP_QRC_TECH   "/servers/pdk/ext_stdlib/28nm/SAMSUNG/FDSOI/FSL/common/Qrctechfiles/6U1x_2U2x_2T8x_LB/nominal.tech"
   set BC_CAP_TABLE  ""
   set BC_QRC_TECH   "/servers/pdk/ext_stdlib/28nm/SAMSUNG/FDSOI/FSL/common/Qrctechfiles/6U1x_2U2x_2T8x_LB/FuncCmax.tech"

   set TIELIST [list ]
   set DONT_USE [list \
     "*ECO*" \
     "*CNBF*" \
     "*CNDIV*" \
     "*DV*BF*" \
     "*DV*IV*" \
    ]
   set CLK_BUFFERS [list ]            
   set CLK_INVERTERS [list ]

}


 # TSMC28HPM All VT 12-track 8LM library follows
 if {$env(TECHNOLOGY) == "TSMC28HPM_12T_8LM"} then {

    set KITSLIB       /process/tsmc/TSMC28HPM/TSMCHOME/digital
    set PMALIB       /servers/scratch50/radhikap/usb2_ots/28nm/ana_macro/usb2_pma_top/v0p0
    
    set VFILE	     "$KITSLIB/Front_End/verilog/tcbn28hpmbwp12t35lvt_111b/tcbn28hpmbwp12t35lvt.v \
 		      $KITSLIB/Front_End/verilog/tcbn28hpmbwp12t35hvt_111b/tcbn28hpmbwp12t35hvt.v \
 		      $KITSLIB/Front_End/verilog/tcbn28hpmbwp12t35_111b/tcbn28hpmbwp12t35.v \
 		      $KITSLIB/Front_End/verilog/tcbn28hpmbwp12t35cglvt_111b/tcbn28hpmbwp12t35cglvt.v \
 		      $KITSLIB/Front_End/verilog/tcbn28hpmbwp12t35cghvt_111b/tcbn28hpmbwp12t35cghvt.v \
 		      $KITSLIB/Front_End/verilog/tcbn28hpmbwp12t35cg_111b/tcbn28hpmbwp12t35cg.v \
 		      "		      
    set ATPGLIB      "$KITSLIB/Front_End/mentor_dft/tcbn28hpmbwp12t35lvt_110a/tcbn28hpmbwp12t35lvt.mdt \
 		      $KITSLIB/Front_End/mentor_dft/tcbn28hpmbwp12t35_110a/tcbn28hpmbwp12t35.mdt \
 		      $KITSLIB/Front_End/mentor_dft/tcbn28hpmbwp12t35hvt_110a/tcbn28hpmbwp12t35hvt.mdt \
 		      $KITSLIB/Front_End/mentor_dft/tcbn28hpmbwp12t35cglvt_110a/tcbn28hpmbwp12t35cglvt.mdt \
 		      $KITSLIB/Front_End/mentor_dft/tcbn28hpmbwp12t35cg_110a/tcbn28hpmbwp12t35cg.mdt \
 		      $KITSLIB/Front_End/mentor_dft/tcbn28hpmbwp12t35cghvt_110a/tcbn28hpmbwp12t35cghvt.mdt \
 		      " 		      	      
    set LIBLEF       "$KITSLIB/Back_End/lef/tcbn28hpmbwp12t35lvt_110a/lef/HVH_0d5_0/tcbn28hpmbwp12t35lvt_8lm5X2ZUTRDL.lef \
 		      $KITSLIB/Back_End/lef/tcbn28hpmbwp12t35hvt_110a/lef/HVH_0d5_0/tcbn28hpmbwp12t35hvt_8lm5X2ZUTRDL.lef \
 		      $KITSLIB/Back_End/lef/tcbn28hpmbwp12t35_110a/lef/HVH_0d5_0/tcbn28hpmbwp12t35_8lm5X2ZUTRDL.lef \
 		      $KITSLIB/Back_End/lef/tcbn28hpmbwp12t35cglvt_110a/lef/HVH_0d5_0/tcbn28hpmbwp12t35cglvt_8lm5X2ZUTRDL.lef \
 		      $KITSLIB/Back_End/lef/tcbn28hpmbwp12t35cghvt_110a/lef/HVH_0d5_0/tcbn28hpmbwp12t35cghvt_8lm5X2ZUTRDL.lef \
 		      $KITSLIB/Back_End/lef/tcbn28hpmbwp12t35cg_110a/lef/HVH_0d5_0/tcbn28hpmbwp12t35cg_8lm5X2ZUTRDL.lef \
 		      $PMALIB/lef/usb2_pma_top.lef \
		     "		      
    set LIBLIB       "$KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35lvt_111a \
 		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35hvt_111a \
 		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35_111a \
 		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35cglvt_111a \
 		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35cghvt_111a \
 		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35cg_111a \
 		      $PMALIB/libs \
		     "		      
    set SLOWLIB      "tcbn28hpmbwp12t35lvtss0p81vm40c.lib \
 		      tcbn28hpmbwp12t35hvtss0p81vm40c.lib \
 		      tcbn28hpmbwp12t35ss0p81vm40c.lib \
		      tcbn28hpmbwp12t35lvtss0p81v0p81vm40c.lib \
 		      tcbn28hpmbwp12t35hvtss0p81v0p81vm40c.lib \
 		      tcbn28hpmbwp12t35ss0p81v0p81vm40c.lib \
 		      tcbn28hpmbwp12t35cglvtss0p81vm40c.lib \
 		      tcbn28hpmbwp12t35cghvtss0p81vm40c.lib \
 		      tcbn28hpmbwp12t35cgss0p81vm40c.lib \
 		      usb2_pma_top_ss0p72vm40c.lib \
		     "		      
    set TYPLIB       "tcbn28hpmbwp12t35lvttt0p9v25c.lib \
 		      tcbn28hpmbwp12t35hvttt0p9v25c.lib \
 		      tcbn28hpmbwp12t35tt0p9v25c.lib \
		      tcbn28hpmbwp12t35lvttt0p9v0p9v25c.lib \
 		      tcbn28hpmbwp12t35hvttt0p9v0p9v25c.lib \
 		      tcbn28hpmbwp12t35tt0p9v0p9v25c.lib \
 		      tcbn28hpmbwp12t35cglvttt0p9v25c.lib \
 		      tcbn28hpmbwp12t35cghvttt0p9v25c.lib \
 		      tcbn28hpmbwp12t35cgtt0p9v25c.lib \
 		      usb2_pma_top_tt0p85v25c.lib \
		     "			      	      
    set FASTLIB      "tcbn28hpmbwp12t35lvtff0p99v0c.lib \
 		      tcbn28hpmbwp12t35hvtff0p99v0c.lib \
 		      tcbn28hpmbwp12t35ff0p99v0c.lib \
		      tcbn28hpmbwp12t35lvtff0p99v0p99v0c.lib \
 		      tcbn28hpmbwp12t35hvtff0p99v0p99v0c.lib \
 		      tcbn28hpmbwp12t35ff0p99v0p99v0c.lib \
 		      tcbn28hpmbwp12t35cglvtff0p99v0c.lib \
 		      tcbn28hpmbwp12t35cghvtff0p99v0c.lib \
 		      tcbn28hpmbwp12t35cgff0p99v0c.lib \
 		      usb2_pma_top_ff0p935vm40c.lib \
		     "		      
    set EDI_SLOWLIB  "$KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35lvt_111a/tcbn28hpmbwp12t35lvtss0p81vm40c.lib \
 		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35hvt_111a/tcbn28hpmbwp12t35hvtss0p81vm40c.lib \
 		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35_111a/tcbn28hpmbwp12t35ss0p81vm40c.lib \
		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35lvt_111a/tcbn28hpmbwp12t35lvtss0p81v0p81vm40c.lib \
 		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35hvt_111a/tcbn28hpmbwp12t35hvtss0p81v0p81vm40c.lib \
 		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35_111a/tcbn28hpmbwp12t35ss0p81v0p81vm40c.lib \
 		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35cglvt_111a/tcbn28hpmbwp12t35cglvtss0p81vm40c.lib \
 		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35cghvt_111a/tcbn28hpmbwp12t35cghvtss0p81vm40c.lib \
 		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35cg_111a/tcbn28hpmbwp12t35cgss0p81vm40c.lib \
 		      $PMALIB/libs/usb2_pma_top_ss0p72vm40c.lib \
		     "		      
    set EDI_TYPLIB   "$KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35lvt_111a/tcbn28hpmbwp12t35lvttt0p9v25c.lib \
                      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35hvt_111a/tcbn28hpmbwp12t35hvttt0p9v25c.lib \
                      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35_111a/tcbn28hpmbwp12t35tt0p9v25c.lib \
		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35lvt_111a/tcbn28hpmbwp12t35lvttt0p9v0p9v25c.lib \
                      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35hvt_111a/tcbn28hpmbwp12t35hvttt0p9v0p9v25c.lib \
                      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35_111a/tcbn28hpmbwp12t35tt0p9v0p9v25c.lib \
                      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35cglvt_111a/tcbn28hpmbwp12t35cglvttt0p9v25c.lib \
                      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35cghvt_111a/tcbn28hpmbwp12t35cghvttt0p9v25c.lib \
                      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35cg_111a/tcbn28hpmbwp12t35cgtt0p9v25c.lib \
                     $PMALIB/libs/usb2_pma_top_tt0p85v25c.lib \
		     "			     	     		     
    set EDI_FASTLIB  "$KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35lvt_111a/tcbn28hpmbwp12t35lvtff0p99v0c.lib \
 		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35hvt_111a/tcbn28hpmbwp12t35hvtff0p99v0c.lib \
 		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35_111a/tcbn28hpmbwp12t35ff0p99v0c.lib \
		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35lvt_111a/tcbn28hpmbwp12t35lvtff0p99v0p99v0c.lib \
 		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35hvt_111a/tcbn28hpmbwp12t35hvtff0p99v0p99v0c.lib \
 		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35_111a/tcbn28hpmbwp12t35ff0p99v0p99v0c.lib \
 		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35cglvt_111a/tcbn28hpmbwp12t35cglvtff0p99v0c.lib \
 		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35cghvt_111a/tcbn28hpmbwp12t35cghvtff0p99v0c.lib \
 		      $KITSLIB/Front_End/timing_power_noise/NLDM/tcbn28hpmbwp12t35cg_111a/tcbn28hpmbwp12t35cgff0p99v0c.lib \
 		      $PMALIB/libs/usb2_pma_top_ff0p935vm40c.lib \
		     "		      
    set WC_DB	     "$KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35lvt_111a/tcbn28hpmbwp12t35lvtss0p81vm40c.cdb \
 		      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35hvt_111a/tcbn28hpmbwp12t35hvtss0p81vm40c.cdb \
 		      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35_111a/tcbn28hpmbwp12t35ss0p81vm40c.cdb \
		      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35lvt_111a/tcbn28hpmbwp12t35lvtss0p81v0p81vm40c.cdb \
 		      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35hvt_111a/tcbn28hpmbwp12t35hvtss0p81v0p81vm40c.cdb \
 		      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35_111a/tcbn28hpmbwp12t35ss0p81v0p81vm40c.cdb \
 		      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35cglvt_111a/tcbn28hpmbwp12t35cglvtss0p81vm40c.cdb \
 		      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35cghvt_111a/tcbn28hpmbwp12t35cghvtss0p81vm40c.cdb \
 		      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35cg_111a/tcbn28hpmbwp12t35cgss0p81vm40c.cdb \
 		      "		      
    set TYP_DB       "$KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35lvt_111a/tcbn28hpmbwp12t35lvttt0p9v25c.cdb \
                      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35hvt_111a/tcbn28hpmbwp12t35hvttt0p9v25c.cdb \
                      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35_111a/tcbn28hpmbwp12t35tt0p9v25c.cdb \
		      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35lvt_111a/tcbn28hpmbwp12t35lvttt0p9v0p9v25c.cdb \
                      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35hvt_111a/tcbn28hpmbwp12t35hvttt0p9v0p9v25c.cdb \
                      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35_111a/tcbn28hpmbwp12t35tt0p9v0p9v25c.cdb \
                      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35cglvt_111a/tcbn28hpmbwp12t35cglvttt0p9v25c.cdb \
                      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35cghvt_111a/tcbn28hpmbwp12t35cghvttt0p9v25c.cdb \
                      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35cg_111a/tcbn28hpmbwp12t35cgtt0p9v25c.cdb \
                      "			      
    set BC_DB	     "$KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35lvt_111a/tcbn28hpmbwp12t35lvtff0p99v0c.cdb \
 		      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35hvt_111a/tcbn28hpmbwp12t35hvtff0p99v0c.cdb \
 		      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35_111a/tcbn28hpmbwp12t35ff0p99v0c.cdb \
		      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35lvt_111a/tcbn28hpmbwp12t35lvtff0p99v0p99v0c.cdb \
 		      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35hvt_111a/tcbn28hpmbwp12t35hvtff0p99v0p99v0c.cdb \
 		      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35_111a/tcbn28hpmbwp12t35ff0p99v0p99v0c.cdb \
 		      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35cglvt_111a/tcbn28hpmbwp12t35cglvtff0p99v0c.cdb \
 		      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35cghvt_111a/tcbn28hpmbwp12t35cghvtff0p99v0c.cdb \
 		      $KITSLIB/Back_End/celtic/tcbn28hpmbwp12t35cg_111a/tcbn28hpmbwp12t35cgff0p99v0c.cdb \
 		      "		      

    set VDD_values "0.81 0.99 0.90"
    set TEMP_values "125 0 25"
    set ss_setup_derate_factor 0.095
    set ss_hold_derate_factor 0.12
    set ff_hold_derate_factor 0.15
    set PROCNODE      28
    set max_route_layer 9
    set DRIVE_CELL    BUFFD4BWP12T35
    set WC_CAP_TABLE  $KITSLIB/EXTRACTION/cworst/cln28hpm_1p08m_ut_alrdl_5x2z_cworst.captable
    set WC_QRC_TECH   $KITSLIB/EXTRACTION/cworst/qrcTechFile
    set TYP_CAP_TABLE $KITSLIB/EXTRACTION/typical/cln28hpm_1p08m_ut_alrdl_5x2z_typical.captable
    set TYP_QRC_TECH  $KITSLIB/EXTRACTION/typical/qrcTechFile   
    set BC_CAP_TABLE  $KITSLIB/EXTRACTION/cbest/cln28hpm_1p08m_ut_alrdl_5x2z_cbest.captable
    set BC_QRC_TECH   $KITSLIB/EXTRACTION/cbest/qrcTechFile

    set TIELIST [list \
       "TIEHBWP12T35" \
       "TIELBWP12T35" \
    ]
    set DONT_USE [list \
       "CKAN2D*" \
       "CKBD*" \
       "CKMUX2D*" \
       "CKND2D*" \
       "CKND*" \
       "CKXOR2D*" \
       "DEL*" \
       "GTIE*" \
       "TIE*" \
       "*0BWP12T35*" \
       "*24BWP*" \
    ]
    set CLK_BUFFERS [list \
       "CKBD4BWP12T35LVT" \
       "CKBD8BWP12T35LVT" \
       "CKBD12BWP12T35LVT" \
       "CKBD16BWP12T35LVT" \
    ]
       
    set CLK_INVERTERS [list \
       "CKND4BWP12T35LVT" \
       "CKND8BWP12T35LVT" \
       "CKND12BWP12T35LVT" \
       "CKND16BWP12T35LVT" \
    ]

 }
 
# TSMC16FF Plus All VT 9LM library follows
 if {$env(TECHNOLOGY) == "TSMC16FFPLUS"} then {

    set KITSLIB       /grid/vormetric/tsmc_16nm/davida/EC3325993/

    set VFILE	     "$KITSLIB/TSMC/tcbn16ffplusllbwp16p90lvt_090a/verilog/tcbn16ffplusllbwp16p90lvt.v \
 		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90ulvt_090a/verilog/tcbn16ffplusllbwp16p90ulvt.v \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90_090a/verilog/tcbn16ffplusllbwp16p90.v \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90pm_100a/verilog/tcbn16ffplusllbwp16p90pm.v \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90pmlvt_100a/verilog/tcbn16ffplusllbwp16p90pmlvt.v \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90pmulvt_100a/verilog/tcbn16ffplusllbwp16p90pmulvt.v \
		      
 		      "
    set ATPGLIB      "$KITSLIB/TSMC/tcbn16ffplusllbwp16p90lvt_090a/source/TSMCHOME/digital/Front_End/mentor_dft/tcbn16ffplusllbwp16p90lvt_090a/tcbn16ffplusllbwp16p90lvt.mdt \
 		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90ulvt_090a/source/TSMCHOME/digital/Front_End/mentor_dft/tcbn16ffplusllbwp16p90ulvt_090a/tcbn16ffplusllbwp16p90ulvt.mdt \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90_090a/mentor_dft/tcbn16ffplusllbwp16p90.mdt \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90pmlvt_100a/mentor_dft/tcbn16ffplusllbwp16p90pmlvt.mdt \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90pmulvt_100a/mentor_dft/tcbn16ffplusllbwp16p90pmulvt.mdt \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90pm_100a/mentor_dft/tcbn16ffplusllbwp16p90pm.mdt \
 		      " 	      
    set LIBLEF       "$KITSLIB/TSMC/TN16CLPR001E1_1_0_1C/N16FF_PRTF_Cad_1.0_1c/PR_tech/Cadence/LefHeader/Standard/HVH/N16_Encounter_9M_2Xa1Xd3Xe2Z_UTRDL_1.0_1c.tlef \
                      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90lvt_090a/lef/tcbn16ffplusllbwp16p90lvt.lef \
 		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90ulvt_090a/lef/tcbn16ffplusllbwp16p90ulvt.lef \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90_090a/lef/tcbn16ffplusllbwp16p90.lef \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90pm_100a/lef/tcbn16ffplusllbwp16p90pm.lef \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90pmlvt_100a/lef/tcbn16ffplusllbwp16p90pmlvt.lef \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90pmulvt_100a/lef/tcbn16ffplusllbwp16p90pmulvt.lef \
 		      "
    set LIBLIB       "$KITSLIB/TSMC/tcbn16ffplusllbwp16p90lvt_090a/nldm/ \
 		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90ulvt_090a/nldm/ \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90_090a/nldm/ \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90pm_100a/nldm/ \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90pmlvt_100a/nldm/ \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90pmulvt_100a/nldm/ \
 		      "
    set SLOWLIB      "tcbn16ffplusllbwp16p90lvtssgnp0p72vm40c.lib \
 		      tcbn16ffplusllbwp16p90ulvtssgnp0p72vm40c.lib \
		      tcbn16ffplusllbwp16p90ssgnp0p72vm40c.lib \
		      tcbn16ffplusllbwp16p90ssgnp0p72v0p72vm40c.lib \
		      tcbn16ffplusllbwp16p90lvtssgnp0p72v0p72vm40c.lib \
		      tcbn16ffplusllbwp16p90ulvtssgnp0p72v0p72vm40c.lib \
		      tcbn16ffplusllbwp16p90pmssgnp0p72vm40c.lib \
		      tcbn16ffplusllbwp16p90pmlvtssgnp0p72vm40c.lib \
		      tcbn16ffplusllbwp16p90pmulvtssgnp0p72vm40c.lib \
 		      "
    set TYPLIB       "tcbn16ffplusllbwp16p90lvttt0p8v25c.lib \
 		      tcbn16ffplusllbwp16p90ulvttt0p8v25c.lib \
		      tcbn16ffplusllbwp16p90tt0p8v25c.lib \
		      tcbn16ffplusllbwp16p90lvttt0p8v0p8v25c.lib \
		      tcbn16ffplusllbwp16p90ulvttt0p8v0p8v25c.lib \
		      tcbn16ffplusllbwp16p90tt0p8v0p8v25c.lib \
 		      tcbn16ffplusllbwp16p90pmtt0p8v25c.lib \
		      tcbn16ffplusllbwp16p90pmlvttt0p8v25c.lib \
		      tcbn16ffplusllbwp16p90pmulvttt0p8v25c.lib \
 		      "		      
    set FASTLIB      "tcbn16ffplusllbwp16p90lvtffgnp0p88v0c.lib \
 		      tcbn16ffplusllbwp16p90ulvtffgnp0p88v0c.lib \
		      tcbn16ffplusllbwp16p90ffgnp0p88v0c.lib \
		      tcbn16ffplusllbwp16p90lvtffgnp0p88v0p88v0c.lib \
		      tcbn16ffplusllbwp16p90ulvtffgnp0p88v0p88v0c.lib \
		      tcbn16ffplusllbwp16p90ffgnp0p88v0p88v0c.lib \
		      tcbn16ffplusllbwp16p90pmffgnp0p88v0c.lib \
		      tcbn16ffplusllbwp16p90pmlvtffgnp0p88v0c.lib \
		      tcbn16ffplusllbwp16p90pmulvtffgnp0p88v0c.lib \
 		      "
    set EDI_SLOWLIB  "$KITSLIB/TSMC/tcbn16ffplusllbwp16p90lvt_090a/nldm/tcbn16ffplusllbwp16p90lvtssgnp0p72vm40c.lib \
 		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90ulvt_090a/nldm/tcbn16ffplusllbwp16p90ulvtssgnp0p72vm40c.lib \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90_090a/nldm/tcbn16ffplusllbwp16p90ssgnp0p72vm40c.lib \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90lvt_090a/nldm/tcbn16ffplusllbwp16p90lvtssgnp0p72v0p72vm40c.lib \
 		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90ulvt_090a/nldm/tcbn16ffplusllbwp16p90ulvtssgnp0p72v0p72vm40c.lib \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90_090a/nldm/tcbn16ffplusllbwp16p90ssgnp0p72v0p72vm40c.lib \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90pm_100a/nldm/tcbn16ffplusllbwp16p90pmssgnp0p72vm40c.lib \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90pmlvt_100a/nldm/tcbn16ffplusllbwp16p90pmlvtssgnp0p72vm40c.lib \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90pmulvt_100a/nldm/tcbn16ffplusllbwp16p90pmulvtssgnp0p72vm40c.lib \
 		      "
    set EDI_TYPLIB   "$KITSLIB/TSMC/tcbn16ffplusllbwp16p90lvt_090a/nldm/tcbn16ffplusllbwp16p90lvttt0p8v25c.lib \
                      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90ulvt_090a/nldm/tcbn16ffplusllbwp16p90ulvttt0p8v25c.lib \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90_090a/nldm/tcbn16ffplusllbwp16p90tt0p8v25c.lib \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90lvt_090a/nldm/tcbn16ffplusllbwp16p90lvttt0p8v0p8v25c.lib \
                      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90ulvt_090a/nldm/tcbn16ffplusllbwp16p90ulvttt0p8v0p8v25c.lib \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90_090a/nldm/tcbn16ffplusllbwp16p90tt0p8v0p8v25c.lib \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90pm_100a/nldm/tcbn16ffplusllbwp16p90pmtt0p8v25c.lib \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90pmlvt_100a/nldm/tcbn16ffplusllbwp16p90pmlvttt0p8v25c.lib \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90pmulvt_100a/nldm/tcbn16ffplusllbwp16p90pmulvttt0p8v25c.lib \
                     "		     		     
    set EDI_FASTLIB  "$KITSLIB/TSMC/tcbn16ffplusllbwp16p90lvt_090a/nldm/tcbn16ffplusllbwp16p90lvtffgnp0p88v0c.lib \
 		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90ulvt_090a/nldm/tcbn16ffplusllbwp16p90ulvtffgnp0p88v0c.lib \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90_090a/nldm/tcbn16ffplusllbwp16p90ffgnp0p88v0c.lib \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90lvt_090a/nldm/tcbn16ffplusllbwp16p90lvtffgnp0p88v0p88v0c.lib \
 		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90ulvt_090a/nldm/tcbn16ffplusllbwp16p90ulvtffgnp0p88v0p88v0c.lib \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90_090a/nldm/tcbn16ffplusllbwp16p90ffgnp0p88v0p88v0c.lib \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90pm_100a/nldm/tcbn16ffplusllbwp16p90pmffgnp0p88v0c.lib \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90pmlvt_100a/nldm/tcbn16ffplusllbwp16p90pmlvtffgnp0p88v0c.lib \
		      $KITSLIB/TSMC/tcbn16ffplusllbwp16p90pmulvt_100a/nldm/tcbn16ffplusllbwp16p90pmulvtffgnp0p88v0c.lib \
 		      "
    set VDD_values "0.72 0.88 0.80"
    set TEMP_values "-40 0 25"
    set ss_setup_derate_factor 0.11
    set ss_hold_derate_factor 0.14
    set ff_hold_derate_factor 0.18
    set PROCNODE      16
    set max_route_layer 9
    set DRIVE_CELL    BUFFD4BWP16P90LVT
    set WC_QRC_TECH   $KITSLIB/tsmc/tsmc16/ffllp/QRC/9M2Xa1Xd3Xe2Z/dig_v0d9P2/cworst/Tech/cworst/qrcTechFile
    set WC_CAP_TABLE  ""
    set TYP_QRC_TECH  $KITSLIB/tsmc/tsmc16/ffllp/QRC/9M2Xa1Xd3Xe2Z/dig_v0d9P2/typical/Tech/typical/qrcTechFile
    set TYP_CAP_TABLE ""   
    set BC_QRC_TECH   $KITSLIB/tsmc/tsmc16/ffllp/QRC/9M2Xa1Xd3Xe2Z/dig_v0d9P2/cbest/Tech/cbest/qrcTechFile
    set BC_CAP_TABLE  ""
    set TIELIST [list \
       "TIEHBWP16P90" \
       "TIELBWP16P90" \
    ]
    set DONT_USE [list \
       "CKAN2D*" \
       "CKBD*" \
       "CKMUX2D*" \
       "CKND2D*" \
       "CKND*" \
       "CKXOR2D*" \
       "DEL*" \
       "TIE*" \
       "*24BWP*" \
    ]
    set CLK_BUFFERS [list \
       "CKBD1BWP16P90" \
       "CKBD2BWP16P90" \
       "CKBD4BWP16P90" \
       "CKBD8BWP16P90" \
       "CKBD12BWP16P90" \
       "CKBD16BWP16P90" \
    ]
       
    set CLK_INVERTERS [list \
       "CKND1BWP16P90" \
       "CKND2BWP16P90" \
       "CKND4BWP16P90" \
       "CKND8BWP16P90" \
       "CKND12BWP16P90" \
       "CKND16BWP16P90" \
    ]

 }


# TSMC16FFC All VT 11-track 11LM library follows
if {$env(TECHNOLOGY) == "TSMC16FFC_11T_11LM"} then {

    set KITSLIB      /process/tsmc16ff/stdcell/tsmc/16nm/n16ffcll/TSMC
    set PMALIB       /process/tsmc16ff/rscratch/work/svn/usb2_projects_t16ff_cmn_chckout/CDNSUSB2PHY_R101_T16FFLLP/ana_macro/usb2_pma_top/v0p0
#    set PMALIB      /projects/sd1000_t16ffc/delivery/usb2_pma_top
    
    set VFILE       "$KITSLIB/tcbn16ffcllbwp16p90_100a/verilog/tcbn16ffcllbwp16p90.v \
                     $KITSLIB/tcbn16ffcllbwp16p90lvt_100a/verilog/tcbn16ffcllbwp16p90.v \
                     $KITSLIB/tcbn16ffcllbwp16p90pm_100a/verilog/tcbn16ffcllbwp16p90pm.v \
		     $PMALIB/verilog/usb2_pma_top.v \
                    "

    set ATPGLIB     "$KITSLIB/tcbn16ffcllbwp16p90_100a/verilog/tcbn16ffcllbwp16p90.v \
                     $KITSLIB/tcbn16ffcllbwp16p90lvt_100a/verilog/tcbn16ffcllbwp16p90.v \
                     $KITSLIB/tcbn16ffcllbwp16p90pm_100a/verilog/tcbn16ffcllbwp16p90pm.v \
		     $PMALIB/verilog/usb2_pma_top.v \
                    "
                    
    set LIBLEF      "/process/tsmc16ff/stdcell/tsmc/16nm/TSMC/TN16CLPR001E1_1_2A/N16FF_PRTF_Cad_1.2a/PR_tech/Cadence/LefHeader/Standard/HVH/N16_Encounter_11M_2Xa1Xd3Xe2Y2Z_UTRDL_9T_PODE_1.2a.tlef \
                     $KITSLIB/tcbn16ffcllbwp16p90_100a/lef/tcbn16ffcllbwp16p90.lef \
                     $KITSLIB/tcbn16ffcllbwp16p90lvt_100a/lef/tcbn16ffcllbwp16p90lvt.lef \
                     $KITSLIB/tcbn16ffcllbwp16p90pm_100a/lef/tcbn16ffcllbwp16p90pm.lef \
   		     $PMALIB/lef/usb2_pma_top.lef \
                    "

    set LIBLIB      "$KITSLIB/tcbn16ffcllbwp16p90_100a/ecsm \
                     $KITSLIB/tcbn16ffcllbwp16p90lvt_100a/ecsm \
                     $KITSLIB/tcbn16ffcllbwp16p90pm_100a/ecsm \
                     $PMALIB/libs/ \
                    "

    set SLOWLIB     "tcbn16ffcllbwp16p90ssgnp0p72vm40c_ecsm.lib \
                     tcbn16ffcllbwp16p90lvtssgnp0p72vm40c_ecsm.lib \
                     tcbn16ffcllbwp16p90pmssgnp0p72vm40c_ecsm.lib \
		     usb2_pma_top_ss0p72vm40c.lib \
                    "

    set TYPLIB      "tcbn16ffcllbwp16p90tt0p8v25c_ecsm.lib \
                     tcbn16ffcllbwp16p90lvttt0p8v25c_ecsm.lib \
                     tcbn16ffcllbwp16p90pmtt0p8v25c_ecsm.lib \
		     usb2_pma_top_tt0p85v25c.lib \
                    "

    set FASTLIB     "tcbn16ffcllbwp16p90ffgnp0p88v0c_ecsm.lib \
                     tcbn16ffcllbwp16p90lvtffgnp0p88v0c_ecsm.lib \
                     tcbn16ffcllbwp16p90pmffgnp0p88v0c_ecsm.lib \
		     usb2_pma_top_ff0p935vm40c.lib \
                     "

    set MLLIB       "tcbn16ffcllbwp16p90ffgnp0p88v125c_ecsm.lib \
                     tcbn16ffcllbwp16p90lvtffgnp0p88v125c_ecsm.lib \
                     tcbn16ffcllbwp16p90pmffgnp0p88v125c_ecsm.lib \
		     usb2_pma_top_ff0p935vm40c.lib \
                     "

    set EDI_SLOWLIB "$KITSLIB/tcbn16ffcllbwp16p90_100a/ecsm/tcbn16ffcllbwp16p90ssgnp0p72vm40c_ecsm.lib \
                     $KITSLIB/tcbn16ffcllbwp16p90lvt_100a/ecsm/tcbn16ffcllbwp16p90lvtssgnp0p72vm40c_ecsm.lib \
                     $KITSLIB/tcbn16ffcllbwp16p90pm_100a/ecsm/tcbn16ffcllbwp16p90pmssgnp0p72vm40c_ecsm.lib \
                     $PMALIB/libs/usb2_pma_top_ss0p72vm40c.lib \
                     "

    set EDI_TYPLIB  "$KITSLIB/tcbn16ffcllbwp16p90_100a/ecsm/tcbn16ffcllbwp16p90tt0p8v25c_ecsm.lib \
                     $KITSLIB/tcbn16ffcllbwp16p90pm_100a/ecsm/tcbn16ffcllbwp16p90pmtt0p8v25c_ecsm.lib \
                     $KITSLIB/tcbn16ffcllbwp16p90lvl_100a/ecsm/tcbn16ffcllbwp16p90lvltt0p8v0p8v25c_ecsm.lib \
                     $PMALIB/libs/usb2_pma_top_tt0p85v25c.lib \
                     "

    set EDI_FASTLIB "$KITSLIB/tcbn16ffcllbwp16p90_100a/ecsm/tcbn16ffcllbwp16p90ffgnp0p88v0c_ecsm.lib \
                     $KITSLIB/tcbn16ffcllbwp16p90lvt_100a/ecsm/tcbn16ffcllbwp16p90lvtffgnp0p88v0c_ecsm.lib \
                     $KITSLIB/tcbn16ffcllbwp16p90pm_100a/ecsm/tcbn16ffcllbwp16p90pmffgnp0p88v0c_ecsm.lib \
                     $PMALIB/libs/usb2_pma_top_ff0p935vm40c.lib \
                     "

    set EDI_MLLIB   "$KITSLIB/tcbn16ffcllbwp16p90_100a/ecsm/tcbn16ffcllbwp16p90ffgnp0p88v125c_ecsm.lib \
                     $KITSLIB/tcbn16ffcllbwp16p90lvt_100a/ecsm/tcbn16ffcllbwp16p90lvtffgnp0p88v125c_ecsm.lib \
                     $KITSLIB/tcbn16ffcllbwp16p90pm_100a/ecsm/tcbn16ffcllbwp16p90pmffgnp0p88v125c_ecsm.lib \
                     $PMALIB/libs/usb2_pma_top_ff0p935vm40c.lib \
                     "

            
#    set WC_DB      " \
#                    $KITSLIB/tcbn28hpmbwp12t35cg_111a/celtic/tcbn28hpmbwp12t35cgss0p81vm40c.cdb \
#                    "              
#    set TYP_DB       " \
#                      $KITSLIB/tcbn28hpmbwp12t35cg_111a/celtic/tcbn28hpmbwp12t35cgtt0p9v25c.cdb \
#                      "                            
#    set BC_DB      " \
#                    $KITSLIB/tcbn28hpmbwp12t35cg_111a/celtic/tcbn28hpmbwp12t35cgff0p99v0c.cdb \
                    "              

    set VDD_values "0.72 0.8 0.88"
    set TEMP_values "-40 0 125"
    set ss_setup_derate_factor 0.095
    set ss_hold_derate_factor 0.12
    set ff_hold_derate_factor 0.15
    set PROCNODE      16
    set max_route_layer 11
    set DRIVE_CELL    BUFFD4BWP16P90
#    set WC_CAP_TABLE  $KITSLIB/EXTRACTION/cworst/cln28hpm_1p08m_ut_alrdl_5x2z_cworst.captable
#    set WC_QRC_TECH   /process/tsmc/tsmc16/ffc/QRC/9M2Xa1Xd3Xe2Z/qrc.4/cworst/Tech/cworst/qrcTechFile
    set WC_QRC_TECH   /process/tsmc16ff/tsmc/tsmc16/ffc/QRC/11M2Xa1Xd3Xe2Y2R/qrc.7/cworst/Tech/cworst/qrcTechFile
#    set TYP_CAP_TABLE $KITSLIB/EXTRACTION/typical/cln28hpm_1p08m_ut_alrdl_5x2z_typical.captable
#    set TYP_QRC_TECH  /process/tsmc/tsmc16/ffc/QRC/9M2Xa1Xd3Xe2Z/qrc.4/typical/Tech/typical/qrcTechFile
    set TYP_QRC_TECH  /process/tsmc16ff/tsmc/tsmc16/ffc/QRC/11M2Xa1Xd3Xe2Y2R/qrc.7/typical/Tech/typical/qrcTechFile
#    set BC_CAP_TABLE  $KITSLIB/EXTRACTION/cbest/cln28hpm_1p08m_ut_alrdl_5x2z_cbest.captable
#    set BC_QRC_TECH   /process/tsmc/tsmc16/ffc/QRC/9M2Xa1Xd3Xe2Z/qrc.4/cbest/Tech/cbest/qrcTechFile
    set BC_QRC_TECH   /process/tsmc16ff/tsmc/tsmc16/ffc/QRC/11M2Xa1Xd3Xe2Y2R/qrc.7/cbest/Tech/cbest/qrcTechFile

    set TIELIST [list \
       "TIEHBWP16P90" \
       "TIELBWP16P90" \
    ]
    set DONT_USE [list \
       "G*" \
       "*24BWP*" \
       "*20BWP*" \
       "BHDBWP*" \
    ]
    set CLK_BUFFERS [list \
       "CKBD4BWP16P90" \
       "CKBD8BWP16P90" \
       "CKBD12BWP16P90" \
       "CKBD16BWP16P90" \
    ]
       
    set CLK_INVERTERS [list \
       "CKND4BWP16P90" \
       "CKND8BWP16P90" \
       "CKND12BWP16P90" \
       "CKND16BWP16P90" \
    ]

}

# TSMC12FFC library follows
if {$env(TECHNOLOGY) == "TSMC12FFC"} then {
    set KITSLIB      /process/tsmcN12/data/stdcell/tsmc/n12ffcll/TSMC
#    set PMALIB       /process/tsmc16ff/rscratch/work/svn/usb2_projects_t16ff_cmn_chckout/CDNSUSB2PHY_R101_T16FFLLP/ana_macro/usb2_pma_top/v0p0
    set PMALIB      /projects/sd1000_t16ffc/delivery/usb2_pma_top
    
    set VFILE       "$KITSLIB/tcbn12ffcllbwp16p90cpd_100a/verilog/tcbn12ffcllbwp16p90cpd.v \
                     $KITSLIB/tcbn12ffcllbwp16p90cpdpm_100a/verilog/tcbn12ffcllbwp16p90cpdpm.v \
		     $PMALIB/verilog/usb2_pma_top_stub.v \
                    "

    set ATPGLIB     "$KITSLIB/tcbn12ffcllbwp16p90cpd_100a/verilog/tcbn12ffcllbwp16p90cpd.v \
                     $KITSLIB/tcbn12ffcllbwp16p90cpdpm_100a/verilog/tcbn12ffcllbwp16p90cpdpm.v \
		     $PMALIB/verilog/usb2_pma_top_stub.v \
                    "
                    
    set LIBLEF      "/process/tsmcN12/data/stdcell/tsmc/n12ffcll/TSMC/PRTF/N12FF_PRTF_Cad_001_0.9_1a/PR_tech/Cadence/LefHeader/Standard/VHV/N12_Innovus_9M_2Xa1Xd3Xe2Z_UTRDL_H576_CPODE_0.9_1a.tlef \
                     $KITSLIB/tcbn12ffcllbwp16p90cpd_100a/lef/tcbn12ffcllbwp16p90cpd.lef \
                     $KITSLIB/tcbn12ffcllbwp16p90cpdpm_100a/lef/tcbn12ffcllbwp16p90cpdpm.lef \
   		     $PMALIB/lef/usb2_pma_top.lef \
                    "

    set LIBLIB      "$KITSLIB/tcbn12ffcllbwp16p90cpd_100a/ecsm \
                     $KITSLIB/tcbn12ffcllbwp16p90cpdpm_100a/ecsm \
                     $PMALIB/lib/ \
                    "

    set SLOWLIB     "tcbn12ffcllbwp16p90cpdssgnp0p72vm40c_ecsm.lib \
                     tcbn12ffcllbwp16p90cpdpmssgnp0p72vm40c_ecsm.lib \
		     usb2_pma_top_ssgnp0p72vm40c_cworst_CCworst.lib \
                    "

    set TYPLIB      "tcbn12ffcllbwp16p90cpdtt0p8v25c_ecsm.lib \
                     tcbn12ffcllbwp16p90cpdpmtt0p8v25c_ecsm.lib \
		     usb2_pma_top_tt0p8v25c_rcnom.lib \
                    "

    set FASTLIB     "tcbn12ffcllbwp16p90cpdffgnp0p88v0c_ecsm.lib \
                     tcbn12ffcllbwp16p90cpdpmffgnp0p88v0c_ecsm.lib \
		     usb2_pma_top_ffgnp0p88vm40c_cbest_CCbest.lib \
                     "

    set MLLIB       "tcbn12ffcllbwp16p90cpdffgnp0p88v125c_ecsm.lib \
                     tcbn12ffcllbwp16p90cpdpmffgnp0p88v125c_ecsm.lib \
		     usb2_pma_top_ffgnp0p88v125c_cbest_CCbest.lib \
                     "

    set EDI_SLOWLIB "$KITSLIB/tcbn12ffcllbwp16p90cpd_100a/ecsm/tcbn12ffcllbwp16p90cpdssgnp0p72vm40c_ecsm.lib \
                     $KITSLIB/tcbn12ffcllbwp16p90cpdpm_100a/ecsm/tcbn12ffcllbwp16p90cpdpmssgnp0p72vm40c_ecsm.lib \
                     $PMALIB/lib/usb2_pma_top_ssgnp0p72vm40c_cworst_CCworst.lib \
                     "

    set EDI_TYPLIB  "$KITSLIB/tcbn12ffcllbwp16p90cpd_100a/ecsm/tcbn12ffcllbwp16p90cpdtt0p8v25c_ecsm.lib \
                     $KITSLIB/tcbn12ffcllbwp16p90cpdpm_100a/ecsm/tcbn12ffcllbwp16p90cpdpmtt0p8v25c_ecsm.lib \
                     $PMALIB/lib/usb2_pma_top_tt0p8v25c_rcnom.lib \
                     "

    set EDI_FASTLIB "$KITSLIB/tcbn12ffcllbwp16p90cpd_100a/ecsm/tcbn12ffcllbwp16p90cpdffgnp0p88v0c_ecsm.lib \
                     $KITSLIB/tcbn12ffcllbwp16p90cpdpm_100a/ecsm/tcbn12ffcllbwp16p90cpdpmffgnp0p88v0c_ecsm.lib \
                     $PMALIB/lib/usb2_pma_top_ffgnp0p88vm40c_cbest_CCbest.lib \
                     "

    set EDI_MLLIB   "$KITSLIB/tcbn12ffcllbwp16p90cpd_100a/ecsm/tcbn12ffcllbwp16p90cpdffgnp0p88v125c_ecsm.lib \
                     $KITSLIB/tcbn12ffcllbwp16p90cpdpm_100a/ecsm/tcbn12ffcllbwp16p90cpdpmffgnp0p88v125c_ecsm.lib \
                     $PMALIB/lib/usb2_pma_top_ffgnp0p88v125c_cbest_CCbest.lib \
                     "

            
#    set WC_DB      " \
#                    $KITSLIB/tcbn28hpmbwp12t35cg_111a/celtic/tcbn28hpmbwp12t35cgss0p81vm40c.cdb \
#                    "              
#    set TYP_DB       " \
#                      $KITSLIB/tcbn28hpmbwp12t35cg_111a/celtic/tcbn28hpmbwp12t35cgtt0p9v25c.cdb \
#                      "                            
#    set BC_DB      " \
#                    $KITSLIB/tcbn28hpmbwp12t35cg_111a/celtic/tcbn28hpmbwp12t35cgff0p99v0c.cdb \
                    "              

    set VDD_values "0.72 0.8 0.88"
    set TEMP_values "-40 0 125"
    set ss_setup_derate_factor 0.095
    set ss_hold_derate_factor 0.12
    set ff_hold_derate_factor 0.15
    set PROCNODE      16
    set max_route_layer 9
    set DRIVE_CELL    BUFFD4BWP16P90
#    set WC_CAP_TABLE  $KITSLIB/EXTRACTION/cworst/cln28hpm_1p08m_ut_alrdl_5x2z_cworst.captable
    set WC_QRC_TECH   /process/tsmcN12/data/ffc/QRC/9M2Xa1Xd3Xe2Z/dig_v1d0p1a/rcworst/Tech/rcworst/qrcTechFile
#    set TYP_CAP_TABLE $KITSLIB/EXTRACTION/typical/cln28hpm_1p08m_ut_alrdl_5x2z_typical.captable
    set TYP_QRC_TECH  /process/tsmcN12/data/ffc/QRC/9M2Xa1Xd3Xe2Z/dig_v1d0p1a/typical/Tech/typical/qrcTechFile
#    set BC_CAP_TABLE  $KITSLIB/EXTRACTION/cbest/cln28hpm_1p08m_ut_alrdl_5x2z_cbest.captable
    set BC_QRC_TECH   /process/tsmcN12/data/ffc/QRC/9M2Xa1Xd3Xe2Z/dig_v1d0p1a/rcbest/Tech/rcbest/qrcTechFile

    set TIELIST [list \
       "TIEHBWP16P90CPD" \
       "TIELBWP16P90CPD" \
    ]
    set DONT_USE [list \
       "PTD*" \
       "PTB*" \
       "PTI*" \
       "*D0P75BWP*" \
    ]
    set CLK_BUFFERS [list \
       "CKBD4BWP16P90CPD" \
       "CKBD8BWP16P90CPD" \
       "CKBD12BWP16P90CPD" \
       "CKBD16BWP16P90CPD" \
    ]
       
    set CLK_INVERTERS [list \
       "CKND4BWP16P90CPD" \
       "CKND8BWP16P90CPD" \
       "CKND12BWP16P90CPD" \
       "CKND16BWP16P90CPD" \
    ]

}




# TSMC10nm  All VT 12LM library follows
 if {$env(TECHNOLOGY) == "TSMC10nm"} then {

    set KITSLIB       /grid/vormetric/tsmc_10nm/pbennett/10nm/EC22229/TSMC

    set VFILE	     "$KITSLIB/tcbn10ffbwp360h10p66pd/TSMCHOME/digital/Front_End/verilog/tcbn10ffbwp360h10p66pd_c141024_005a/tcbn10ffbwp360h10p66pd_c141024_005a.v \
 		      $KITSLIB/tcbn10ffbwp360h10p66pdlvt/TSMCHOME/digital/Front_End/verilog/tcbn10ffbwp360h10p66pdlvt_c141024_005a/tcbn10ffbwp360h10p66pdlvt_c141024_005a.v \
 		      $KITSLIB/tcbn10ffbwp360h10p66pdulvt/TSMCHOME/digital/Front_End/verilog/tcbn10ffbwp360h10p66pdulvt_c141024_005a/tcbn10ffbwp360h10p66pdulvt_c141024_005a.v \
		      "
    set ATPGLIB      "$KITSLIB/tcbn10ffbwp360h10p66pd/TSMCHOME/digital/Front_End/mentor_dft/tcbn10ffbwp360h10p66pd_c141024_005a/tcbn10ffbwp360h10p66pd_c141024_005a.mdt \
 		      $KITSLIB/tcbn10ffbwp360h10p66pdlvt/TSMCHOME/digital/Front_End/mentor_dft/tcbn10ffbwp360h10p66pdlvt_c141024_005a/tcbn10ffbwp360h10p66pdlvt_c141024_005a.mdt \
		      $KITSLIB/tcbn10ffbwp360h10p66pdulvt/TSMCHOME/digital/Front_End/mentor_dft/tcbn10ffbwp360h10p66pdulvt_c141024_005a/tcbn10ffbwp360h10p66pdulvt_c141024_005a.mdt \
 		      " 	      
    set LIBLEF       "$KITSLIB/N10_PRTF_Cad_005_0.5a/PR_tech/Cadence/LefHeader/HVH/N10_Encounter_12M_2X1Ya4Y2Yy2Z_UTRDL_M2P44_M3P45_M4P80_0.5a.tlef \
                      $KITSLIB/tcbn10ffbwp360h10p66pd/TSMCHOME/digital/Back_End/lef/tcbn10ffbwp360h10p66pd_c141024_005a/lef/tcbn10ffbwp360h10p66pd_c141024_005a.lef \
		      $KITSLIB/tcbn10ffbwp360h10p66pd/TSMCHOME/digital/Back_End/lef/tcbn10ffbwp360h10p66pd_c141024_005a/lef/tcbn10ffbwp360h10p66pd_c141024_005a_par.lef \
 		      $KITSLIB/tcbn10ffbwp360h10p66pdlvt/TSMCHOME/digital/Back_End/lef/tcbn10ffbwp360h10p66pdlvt_c141024_005a/lef/tcbn10ffbwp360h10p66pdlvt_c141024_005a.lef \
		      $KITSLIB/tcbn10ffbwp360h10p66pdlvt/TSMCHOME/digital/Back_End/lef/tcbn10ffbwp360h10p66pdlvt_c141024_005a/lef/tcbn10ffbwp360h10p66pdlvt_c141024_005a_par.lef \
		      $KITSLIB/tcbn10ffbwp360h10p66pdulvt/TSMCHOME/digital/Back_End/lef/tcbn10ffbwp360h10p66pdulvt_c141024_005a/lef/tcbn10ffbwp360h10p66pdulvt_c141024_005a.lef \
		      $KITSLIB/tcbn10ffbwp360h10p66pdulvt/TSMCHOME/digital/Back_End/lef/tcbn10ffbwp360h10p66pdulvt_c141024_005a/lef/tcbn10ffbwp360h10p66pdulvt_c141024_005a_par.lef \
 		      "
    set LIBLIB       "$KITSLIB/tcbn10ffbwp360h10p66pd/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn10ffbwp360h10p66pd_c141024_005a \
                      $KITSLIB/tcbn10ffbwp360h10p66pdlvt/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn10ffbwp360h10p66pdlvt_c141024_005a \
		      $KITSLIB/tcbn10ffbwp360h10p66pdulvt/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn10ffbwp360h10p66pdulvt_c141024_005a \
 		      "
    set SLOWLIB      "tcbn10ffbwp360h10p66pd_c141024_005a_ssgnp_0p700v_m25c_cworst_T_nldm.lib \
                      tcbn10ffbwp360h10p66pdlvt_c141024_005a_ssgnp_0p700v_m25c_cworst_T_nldm.lib \
		      tcbn10ffbwp360h10p66pdulvt_c141024_005a_ssgnp_0p700v_m25c_cworst_T_nldm.lib \
 		      "
    set FASTLIB      "tcbn10ffbwp360h10p66pd_c141024_005a_ffgnp_1p115v_125c_cbest_T_nldm.lib \
 		      tcbn10ffbwp360h10p66pdlvt_c141024_005a_ffgnp_1p115v_125c_cbest_T_nldm.lib \
		      tcbn10ffbwp360h10p66pdulvt_c141024_005a_ffgnp_1p115v_125c_cbest_T_nldm.lib \
 		      "
    set EDI_SLOWLIB  "$KITSLIB/tcbn10ffbwp360h10p66pd/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn10ffbwp360h10p66pd_c141024_005a/tcbn10ffbwp360h10p66pd_c141024_005a_ssgnp_0p700v_m25c_cworst_T_nldm.lib \
 		      $KITSLIB/tcbn10ffbwp360h10p66pdlvt/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn10ffbwp360h10p66pdlvt_c141024_005a/tcbn10ffbwp360h10p66pdlvt_c141024_005a_ssgnp_0p700v_m25c_cworst_T_nldm.lib \
		      $KITSLIB/tcbn10ffbwp360h10p66pdulvt/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn10ffbwp360h10p66pdulvt_c141024_005a/tcbn10ffbwp360h10p66pdulvt_c141024_005a_ssgnp_0p700v_m25c_cworst_T_nldm.lib \
 		      "
    set EDI_TYPLIB   "$KITSLIB/tcbn10ffbwp360h10p66pd/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn10ffbwp360h10p66pd_c141024_005a/tcbn10ffbwp360h10p66pd_c141024_005a_ffgnp_0p750v_85c_typical_nldm.lib \
                      $KITSLIB/tcbn10ffbwp360h10p66pdlvt/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn10ffbwp360h10p66pdlvt_c141024_005a/tcbn10ffbwp360h10p66pdlvt_c141024_005a_ffgnp_0p750v_85c_typical_nldm.lib \
		      $KITSLIB/tcbn10ffbwp360h10p66pdulvt/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn10ffbwp360h10p66pdulvt_c141024_005a/tcbn10ffbwp360h10p66pdulvt_c141024_005a_ffgnp_0p750v_85c_typical_nldm.lib \
                     "		     		     
    set EDI_FASTLIB  "$KITSLIB/tcbn10ffbwp360h10p66pd/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn10ffbwp360h10p66pd_c141024_005a/tcbn10ffbwp360h10p66pd_c141024_005a_ffgnp_1p115v_125c_cbest_T_nldm.lib \
 		      $KITSLIB/tcbn10ffbwp360h10p66pdlvt/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn10ffbwp360h10p66pdlvt_c141024_005a/tcbn10ffbwp360h10p66pdlvt_c141024_005a_ffgnp_1p115v_125c_cbest_T_nldm.lib \
		      $KITSLIB/tcbn10ffbwp360h10p66pdulvt/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn10ffbwp360h10p66pdulvt_c141024_005a/tcbn10ffbwp360h10p66pdulvt_c141024_005a_ffgnp_1p115v_125c_cbest_T_nldm.lib \
 		      "
    set VDD_values "0.70 0.75 1.15"
    set TEMP_values "125 85 -25"
    set ss_setup_derate_factor 0.11
    set ss_hold_derate_factor 0.14
    set ff_hold_derate_factor 0.18
    set PROCNODE      10
    set max_route_layer 12
    set DRIVE_CELL    BUFF_NOM_D4_H360_L10_P66_S
    set WC_QRC_TECH   $KITSLIB/Extraction/RC_QRC_cln10ff_1p12m_2x1ya4y2yy2z_ut-alrdl_DPT_5corners_0.05p2a/cworst/Tech/cworst_T/qrcTechFile
    set WC_CAP_TABLE  ""
    set TYP_QRC_TECH  $KITSLIB/Extraction/RC_QRC_cln10ff_1p12m_2x1ya4y2yy2z_ut-alrdl_DPT_5corners_0.05p2a/typical/Tech/typical/qrcTechFile   
    set TYP_CAP_TABLE ""   
    set BC_QRC_TECH   $KITSLIB/Extraction/RC_QRC_cln10ff_1p12m_2x1ya4y2yy2z_ut-alrdl_DPT_5corners_0.05p2a/cbest/Tech/cbest_T/qrcTechFile
    set BC_CAP_TABLE  ""
    set TIELIST [list \
       "TIEH_NOM_H360_L10_P66_S" \
       "TIEL_NOM_H360_L10_P66_S" \
    ]
    set DONT_USE [list \
       "CKAN2*" \
       "CKB*" \
       "CKMUX2*" \
       "CKND2*" \
       "CKN*" \
       "CKXOR2*" \
       "DEL*" \
       "TIE*" \
    ]
    set CLK_BUFFERS [list \
       "CKB_NOM_D1_H360_L10_P66_S" \
       "CKB_NOM_D2_H360_L10_P66_S" \
       "CKB_NOM_D4_H360_L10_P66_S" \
       "CKB_NOM_D14_H360_L10_P66_S" \
       "CKB_NOM_D18_H360_L10_P66_S" \
       "CKB_NOM_D20_H360_L10_P66_S" \
    ]
       
    set CLK_INVERTERS [list \
       "CKN_NOM_D1_H360_L10_P66_S" \
       "CKN_NOM_D2_H360_L10_P66_S" \
       "CKN_NOM_D4_H360_L10_P66_S" \
       "CKN_NOM_D14_H360_L10_P66_S" \
       "CKN_NOM_D18_H360_L10_P66_S" \
       "CKN_NOM_D20_H360_L10_P66_S" \
    ]

 }


# TSMC7nm library follows
if {$env(TECHNOLOGY) == "TSMC7nm"} then {

    set KITSLIB       "/process/tsmcN7/data/stdcell/tsmc/n7/TSMC"
    set PMALIBS       "/servers/digital_design/dsathish/USB2_IP/cdn_sd1000_ss7lpp/pma_libs"

    set VFILE	     "$KITSLIB/tcbn07_bwph240l11p57pd_base_svt_100b/verilog/tcbn07_bwph240l11p57pd_base_svt.v \
    		      $KITSLIB/tcbn07_bwph240l11p57pd_pm_svt_100b/verilog/tcbn07_bwph240l11p57pd_pm_svt.v \
		      $KITSLIB/tcbn07_bwph240l11p57pd_base_lvt_100b/verilog/tcbn07_bwph240l11p57pd_base_lvt.v \
    		      $KITSLIB/tcbn07_bwph240l11p57pd_pm_lvt_100b/verilog/tcbn07_bwph240l11p57pd_pm_lvt.v \
		      $KITSLIB/tcbn07_bwph240l11p57pd_base_ulvt_100b/verilog/tcbn07_bwph240l11p57pd_base_ulvt.v \
    		      $KITSLIB/tcbn07_bwph240l11p57pd_pm_ulvt_100b/verilog/tcbn07_bwph240l11p57pd_pm_ulvt.v \
                      $PMALIBS/../rtl/usb2_pma_top_stub.sv \
		      "
    
    set ATPGLIB      "$KITSLIB/tcbn07_bwph240l11p57pd_base_svt_090b/mentor_dft/tcbn07_bwph240l11p57pd_base_svt.mdt \
    		      $KITSLIB/tcbn07_bwph240l11p57pd_pm_svt_090b/mentor_dft/tcbn07_bwph240l11p57pd_pm_svt.mdt \
		      $KITSLIB/tcbn07_bwph240l11p57pd_base_lvt_090b/mentor_dft/tcbn07_bwph240l11p57pd_base_lvt.mdt \
    		      $KITSLIB/tcbn07_bwph240l11p57pd_pm_lvt_090b/mentor_dft/tcbn07_bwph240l11p57pd_pm_lvt.mdt \
		      $KITSLIB/tcbn07_bwph240l11p57pd_base_ulvt_090b/mentor_dft/tcbn07_bwph240l11p57pd_base_ulvt.mdt \
    		      $KITSLIB/tcbn07_bwph240l11p57pd_pm_ulvt_090b/mentor_dft/tcbn07_bwph240l11p57pd_pm_ulvt.mdt \
                      $PMALIBS/../rtl/usb2_pma_top_stub.sv \
		      "
      
    set LIBLEF       "$KITSLIB/PRTECH/N07FF_PRTF_Cad_001_1.1a/PR_tech/Cadence/LefHeader/Standard/VHV/N07_Innovus_13M_1X1Xa1Ya5Y2Yy2R_UTRDL_M1P57_M2P40_M3P44_M4P76_M5P76_M6P76_M7P76_M8P76_M9P76_H240_1.1a.tlef \
                      $KITSLIB/tcbn07_bwph240l11p57pd_base_svt_100b/lef/tcbn07_bwph240l11p57pd_base_svt.lef \
                      $KITSLIB/tcbn07_bwph240l11p57pd_pm_svt_100b/lef/tcbn07_bwph240l11p57pd_pm_svt.lef \
                      $KITSLIB/tcbn07_bwph240l11p57pd_base_lvt_100b/lef/tcbn07_bwph240l11p57pd_base_lvt.lef \
                      $KITSLIB/tcbn07_bwph240l11p57pd_pm_lvt_100b/lef/tcbn07_bwph240l11p57pd_pm_lvt.lef \
                      $KITSLIB/tcbn07_bwph240l11p57pd_base_ulvt_100b/lef/tcbn07_bwph240l11p57pd_base_ulvt.lef \
                      $KITSLIB/tcbn07_bwph240l11p57pd_pm_ulvt_100b/lef/tcbn07_bwph240l11p57pd_pm_ulvt.lef \
                      "
 
    set LIBLIB       "$KITSLIB/tcbn07_bwph240l11p57pd_base_svt_100b/ecsm \
                      $KITSLIB/tcbn07_bwph240l11p57pd_pm_svt_100b/ecsm \
                      $KITSLIB/tcbn07_bwph240l11p57pd_base_lvt_100b/ecsm \
                      $KITSLIB/tcbn07_bwph240l11p57pd_pm_lvt_100b/ecsm \
                      $KITSLIB/tcbn07_bwph240l11p57pd_base_ulvt_100b/ecsm \
                      $KITSLIB/tcbn07_bwph240l11p57pd_pm_ulvt_100b/ecsm \
                      $PMALIBS \
                      "
    set SLOWLIB      "tcbn07_bwph240l11p57pd_base_svtssgnp_0p675v_m40c_cworst_CCworst_T_hm_ecsm.lib.gz \
                      tcbn07_bwph240l11p57pd_pm_svtssgnp_0p675v_m40c_cworst_CCworst_T_hm_ecsm.lib.gz \
                      tcbn07_bwph240l11p57pd_base_lvtssgnp_0p675v_m40c_cworst_CCworst_T_hm_ecsm.lib.gz \
                      tcbn07_bwph240l11p57pd_pm_lvtssgnp_0p675v_m40c_cworst_CCworst_T_hm_ecsm.lib.gz \
                      tcbn07_bwph240l11p57pd_base_ulvtssgnp_0p675v_m40c_cworst_CCworst_T_hm_ecsm.lib.gz \
                      tcbn07_bwph240l11p57pd_pm_ulvtssgnp_0p675v_m40c_cworst_CCworst_T_hm_ecsm.lib.gz \
                      usb2_pma_top_ssgnp0p675vm40c.lib \
                     "
    set TYPLIB      "tcbn07_bwph240l11p57pd_base_svttt_0p75v_25c_typical_hm_ecsm.lib.gz \
                     tcbn07_bwph240l11p57pd_pm_svttt_0p75v_25c_typical_hm_ecsm.lib.gz \
		     tcbn07_bwph240l11p57pd_base_lvttt_0p75v_25c_typical_hm_ecsm.lib.gz \
                     tcbn07_bwph240l11p57pd_pm_lvttt_0p75v_25c_typical_hm_ecsm.lib.gz \
		     tcbn07_bwph240l11p57pd_base_ulvttt_0p75v_25c_typical_hm_ecsm.lib.gz \
                     tcbn07_bwph240l11p57pd_pm_ulvttt_0p75v_25c_typical_hm_ecsm.lib.gz \
		     usb2_pma_top_tt0p75v25c.lib \
                    "
    set FASTLIB      "tcbn07_bwph240l11p57pd_base_svtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      tcbn07_bwph240l11p57pd_pm_svtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      tcbn07_bwph240l11p57pd_base_lvtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      tcbn07_bwph240l11p57pd_pm_lvtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      tcbn07_bwph240l11p57pd_base_ulvtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      tcbn07_bwph240l11p57pd_pm_ulvtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      usb2_pma_top_ffgnp0p825v125c.lib \
                     "
    set MLLIB        "tcbn07_bwph240l11p57pd_base_svtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      tcbn07_bwph240l11p57pd_pm_svtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      tcbn07_bwph240l11p57pd_base_lvtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      tcbn07_bwph240l11p57pd_pm_lvtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      tcbn07_bwph240l11p57pd_base_ulvtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      tcbn07_bwph240l11p57pd_pm_ulvtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      usb2_pma_top_ffgnp0p825v125c.lib \
                     "
 		      
    set EDI_SLOWLIB  "$KITSLIB/tcbn07_bwph240l11p57pd_base_svt_100b/ecsm/tcbn07_bwph240l11p57pd_base_svtssgnp_0p675v_m40c_cworst_CCworst_T_hm_ecsm.lib.gz \
                      $KITSLIB/tcbn07_bwph240l11p57pd_pm_svt_100b/ecsm/tcbn07_bwph240l11p57pd_pm_svtssgnp_0p675v_m40c_cworst_CCworst_T_hm_ecsm.lib.gz \
                      $KITSLIB/tcbn07_bwph240l11p57pd_base_lvt_100b/ecsm/tcbn07_bwph240l11p57pd_base_lvtssgnp_0p675v_m40c_cworst_CCworst_T_hm_ecsm.lib.gz \
                      $KITSLIB/tcbn07_bwph240l11p57pd_pm_lvt_100b/ecsm/tcbn07_bwph240l11p57pd_pm_lvtssgnp_0p675v_m40c_cworst_CCworst_T_hm_ecsm.lib.gz \
                      $KITSLIB/tcbn07_bwph240l11p57pd_base_ulvt_100b/ecsm/tcbn07_bwph240l11p57pd_base_ulvtssgnp_0p675v_m40c_cworst_CCworst_T_hm_ecsm.lib.gz \
                      $KITSLIB/tcbn07_bwph240l11p57pd_pm_ulvt_100b/ecsm/tcbn07_bwph240l11p57pd_pm_ulvtssgnp_0p675v_m40c_cworst_CCworst_T_hm_ecsm.lib.gz \
                      $PMALIBS/usb2_pma_top_ssgnp0p675vm40c.lib \
		      "
    set EDI_TYPLIB   "$KITSLIB/tcbn07_bwph240l11p57pd_base_svt_100b/ecsm/tcbn07_bwph240l11p57pd_base_svttt_0p75v_25c_typical_hm_ecsm.lib.gz \
                      $KITSLIB/tcbn07_bwph240l11p57pd_pm_svt_100b/ecsm/tcbn07_bwph240l11p57pd_pm_svttt_0p75v_25c_typical_hm_ecsm.lib.gz \
                      $KITSLIB/tcbn07_bwph240l11p57pd_base_lvt_100b/ecsm/tcbn07_bwph240l11p57pd_base_lvttt_0p75v_25c_typical_hm_ecsm.lib.gz \
                      $KITSLIB/tcbn07_bwph240l11p57pd_pm_lvt_100b/ecsm/tcbn07_bwph240l11p57pd_pm_lvttt_0p75v_25c_typical_hm_ecsm.lib.gz \
                      $KITSLIB/tcbn07_bwph240l11p57pd_base_ulvt_100b/ecsm/tcbn07_bwph240l11p57pd_base_ulvttt_0p75v_25c_typical_hm_ecsm.lib.gz \
                      $KITSLIB/tcbn07_bwph240l11p57pd_pm_ulvt_100b/ecsm/tcbn07_bwph240l11p57pd_pm_ulvttt_0p75v_25c_typical_hm_ecsm.lib.gz \
                      $PMALIBS/usb2_pma_top_tt0p75v25c.lib \
		      "
		      		     		     
    set EDI_FASTLIB  "$KITSLIB/tcbn07_bwph240l11p57pd_base_svt_100b/ecsm/tcbn07_bwph240l11p57pd_base_svtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      $KITSLIB/tcbn07_bwph240l11p57pd_pm_svt_100b/ecsm/tcbn07_bwph240l11p57pd_pm_svtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      $KITSLIB/tcbn07_bwph240l11p57pd_base_lvt_100b/ecsm/tcbn07_bwph240l11p57pd_base_lvtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      $KITSLIB/tcbn07_bwph240l11p57pd_pm_lvt_100b/ecsm/tcbn07_bwph240l11p57pd_pm_lvtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      $KITSLIB/tcbn07_bwph240l11p57pd_base_ulvt_100b/ecsm/tcbn07_bwph240l11p57pd_base_ulvtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      $KITSLIB/tcbn07_bwph240l11p57pd_pm_ulvt_100b/ecsm/tcbn07_bwph240l11p57pd_pm_ulvtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      $PMALIBS/usb2_pma_top_ffgnp0p825v125c.lib \
		      "
     set EDI_MLLIB   "$KITSLIB/tcbn07_bwph240l11p57pd_base_svt_100b/ecsm/tcbn07_bwph240l11p57pd_base_svtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      $KITSLIB/tcbn07_bwph240l11p57pd_pm_svt_100b/ecsm/tcbn07_bwph240l11p57pd_pm_svtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      $KITSLIB/tcbn07_bwph240l11p57pd_base_lvt_100b/ecsm/tcbn07_bwph240l11p57pd_base_lvtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      $KITSLIB/tcbn07_bwph240l11p57pd_pm_lvt_100b/ecsm/tcbn07_bwph240l11p57pd_pm_lvtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      $KITSLIB/tcbn07_bwph240l11p57pd_base_ulvt_100b/ecsm/tcbn07_bwph240l11p57pd_base_ulvtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      $KITSLIB/tcbn07_bwph240l11p57pd_pm_ulvt_100b/ecsm/tcbn07_bwph240l11p57pd_pm_ulvtffgnp_0p825v_125c_cbest_CCbest_T_hm_ecsm.lib.gz \
                      $PMALIBS/usb2_pma_top_ffgnp0p825v125c.lib \
		      "	       
		       	
		       	      
    set VDD_values "0.675 0.75 0.825"
    set TEMP_values "125 25 -40"
    set ss_setup_derate_factor 0.11
    set ss_hold_derate_factor 0.14
    set ff_hold_derate_factor 0.18
    set PROCNODE      7
    set max_route_layer 7
    set DRIVE_CELL    BUFFD10BWP240H11P57PDSVT
    set WC_QRC_TECH   "/process/tsmcN7/data/g/QRC/11M2X1Ya3Y2Yy2R_UT/dig_v1d0p1/cworst/Tech/cworst_CCworst_T/qrcTechFile"
    set WC_CAP_TABLE  ""
    set TYP_QRC_TECH  "/process/tsmcN7/data/g/QRC/11M2X1Ya3Y2Yy2R_UT/dig_v1d0p1/typical/Tech/typical/qrcTechFile"
    set TYP_CAP_TABLE ""   
    set BC_QRC_TECH   "/process/tsmcN7/data/g/QRC/11M2X1Ya3Y2Yy2R_UT/dig_v1d0p1/cbest/Tech/cbest_CCbest_T/qrcTechFile"
    set BC_CAP_TABLE  ""
    set TIELIST [list ]

    
    set DONT_USE [list \
"*BHDBWP240H11P57PD*" \
"*BUFFD20BWP240H11P57PD*" \
"*BUFFD24BWP240H11P57PD*" \
"*BUFFD28BWP240H11P57PD*" \
"*BUFFD32BWP240H11P57PD*" \
"*BUFFD36BWP240H11P57PD*" \
"*BUFFSKFD20BWP240H11P57PD*" \
"*BUFFSKFD24BWP240H11P57PD*" \
"*BUFFSKFD28BWP240H11P57PD*" \
"*BUFFSKFD32BWP240H11P57PD*" \
"*BUFFSKFD36BWP240H11P57PD*" \
"*BUFFSKRD20BWP240H11P57PD*" \
"*BUFFSKRD24BWP240H11P57PD*" \
"*BUFFSKRD28BWP240H11P57PD*" \
"*BUFFSKRD32BWP240H11P57PD*" \
"*BUFFSKRD36BWP240H11P57PD*" \
"*BUFTD20BWP240H11P57PD*" \
"*BUFTD24BWP240H11P57PD*" \
"*CKBD20BWP240H11P57PD*" \
"*CKBD24BWP240H11P57PD*" \
"*CKLHQD20BWP240H11P57PD*" \
"*CKLHQD24BWP240H11P57PD*" \
"*CKLNQD20BWP240H11P57PD*" \
"*CKLNQD24BWP240H11P57PD*" \
"*CKLNQOPTBBD20BWP240H11P57PD*" \
"*CKLNQOPTBBD24BWP240H11P57PD*" \
"*CKND20BWP240H11P57PD*" \
"*CKND24BWP240H11P57PD*" \
"*DCCKBD20BWP240H11P57PD*" \
"*DCCKBD24BWP240H11P57PD*" \
"*DCCKND20BWP240H11P57PD*" \
"*DCCKND24BWP240H11P57PD*" \
"*GAN2D1BWP240H11P57PD*" \
"*GAN2D2BWP240H11P57PD*" \
"*GAN2D4BWP240H11P57PD*" \
"*GAN3D1BWP240H11P57PD*" \
"*GAN4D1BWP240H11P57PD*" \
"*GANTENNABWP240H11P57PD*" \
"*GAO21D1BWP240H11P57PD*" \
"*GAO22D1BWP240H11P57PD*" \
"*GAOI21D1BWP240H11P57PD*" \
"*GAOI21D2BWP240H11P57PD*" \
"*GAOI22D1BWP240H11P57PD*" \
"*GAOI22D2BWP240H11P57PD*" \
"*GBUFFD16BWP240H11P57PD*" \
"*GBUFFD1BWP240H11P57PD*" \
"*GBUFFD2BWP240H11P57PD*" \
"*GBUFFD3BWP240H11P57PD*" \
"*GBUFFD4BWP240H11P57PD*" \
"*GBUFFD8BWP240H11P57PD*" \
"*GCKLNQD2BWP240H11P57PD*" \
"*GCKLNQD6BWP240H11P57PD*" \
"*GDCAP1SHXPBWP240H11P57PD*" \
"*GDCAP1SHXPSWPABBWP240H11P57PD*" \
"*GDCAP1SHXPSWPBWP240H11P57PD*" \
"*GDCAP2DHXPBWP240H11P57PD*" \
"*GDCAP2SHXPBWP240H11P57PD*" \
"*GDCAP3DHXPBWP240H11P57PD*" \
"*GDCAP3SHXPBWP240H11P57PD*" \
"*GDCAP4DHXPBWP240H11P57PD*" \
"*GDCAP4SHXPBWP240H11P57PD*" \
"*GDCAP5DHXPBWP240H11P57PD*" \
"*GDELBD1BWP240H11P57PD*" \
"*GDELED1BWP240H11P57PD*" \
"*GDFQD1BWP240H11P57PD*" \
"*GDFQD2BWP240H11P57PD*" \
"*GDFRPQD1BWP240H11P57PD*" \
"*GDFRPQD2BWP240H11P57PD*" \
"*GDFSNQD1BWP240H11P57PD*" \
"*GDFSNQD2BWP240H11P57PD*" \
"*GFILL1SHBWP240H11P57PD*" \
"*GFILL1SHSWPABBWP240H11P57PD*" \
"*GFILL1SHSWPBWP240H11P57PD*" \
"*GFILL2DHBWP240H11P57PD*" \
"*GFILL2SHBWP240H11P57PD*" \
"*GFILL3DHBWP240H11P57PD*" \
"*GFILL3SHBWP240H11P57PD*" \
"*GFILL4DHBWP240H11P57PD*" \
"*GFILL4SHBWP240H11P57PD*" \
"*GFILL5DHBWP240H11P57PD*" \
"*GINVD16BWP240H11P57PD*" \
"*GINVD1BWP240H11P57PD*" \
"*GINVD2BWP240H11P57PD*" \
"*GINVD2BWP240H11P57PD*" \
"*GINVD3BWP240H11P57PD*" \
"*GINVD4BWP240H11P57PD*" \
"*GINVD8BWP240H11P57PD*" \
"*GLHQD2BWP240H11P57PD*" \
"*GLNQD2BWP240H11P57PD*" \
"*GMUX2D1BWP240H11P57PD*" \
"*GMUX2D2BWP240H11P57PD*" \
"*GMUX2ND1BWP240H11P57PD*" \
"*GMUX2ND2BWP240H11P57PD*" \
"*GND2D1BWP240H11P57PD*" \
"*GND2D2BWP240H11P57PD*" \
"*GND3D1BWP240H11P57PD*" \
"*GND3D2BWP240H11P57PD*" \
"*GND4D2BWP240H11P57PD*" \
"*GNR2D1BWP240H11P57PD*" \
"*GNR2D2BWP240H11P57PD*" \
"*GNR3D1BWP240H11P57PD*" \
"*GNR3D2BWP240H11P57PD*" \
"*GNR4D2BWP240H11P57PD*" \
"*GOA21D2BWP240H11P57PD*" \
"*GOA22D2BWP240H11P57PD*" \
"*GOAI21D1BWP240H11P57PD*" \
"*GOAI21D2BWP240H11P57PD*" \
"*GOR2D1BWP240H11P57PD*" \
"*GOR2D2BWP240H11P57PD*" \
"*GOR2D4BWP240H11P57PD*" \
"*GOR3D2BWP240H11P57PD*" \
"*GOR4D2BWP240H11P57PD*" \
"*GSDFQD1BWP240H11P57PD*" \
"*GSDFRPQD1BWP240H11P57PD*" \
"*GSDFRPQD2BWP240H11P57PD*" \
"*GSDFSNQD1BWP240H11P57PD*" \
"*GSDFSNQD2BWP240H11P57PD*" \
"*GTIEHXPBWP240H11P57PD*" \
"*GTIELXNBWP240H11P57PD*" \
"*GXNR2D1BWP240H11P57PD*" \
"*GXNR2D2BWP240H11P57PD*" \
"*GXOR2D1BWP240H11P57PD*" \
"*GXOR2D2BWP240H11P57PD*" \
"*INVD20BWP240H11P57PD*" \
"*INVD24BWP240H11P57PD*" \
"*INVD28BWP240H11P57PD*" \
"*INVD32BWP240H11P57PD*" \
"*INVD36BWP240H11P57PD*" \
"*INVSKFD20BWP240H11P57PD*" \
"*INVSKFD24BWP240H11P57PD*" \
"*INVSKFD28BWP240H11P57PD*" \
"*INVSKFD32BWP240H11P57PD*" \
"*INVSKFD36BWP240H11P57PD*" \
"*INVSKRD20BWP240H11P57PD*" \
"*INVSKRD36BWP240H11P57PD*" \
"*LHCSNQD1BWP240H11P57PD*" \
"*LHCSNQD2BWP240H11P57PD*" \
"*LHCSNQD4BWP240H11P57PD*" \
"*LNCSNQD1BWP240H11P57PD*" \
"*LNCSNQD2BWP240H11P57PD*" \
"*LNCSNQD4BWP240H11P57PD*" \
"*ND2D20BWP240H11P57PD*" \
"*ND2D24BWP240H11P57PD*" \
"*ND2SKFD20BWP240H11P57PD*" \
"*ND2SKFD24BWP240H11P57PD*" \
"*NR2D20BWP240H11P57PD*" \
"*NR2D24BWP240H11P57PD*" \
"*NR2SKRD20BWP240H11P57PD*" \
"*NR2SKRD24BWP240H11P57PD*" \
"*D1BWP*" \
    ]
    set CLK_BUFFERS [list     ]
       
    set CLK_INVERTERS [list ]

 }

# SS10 LPP Library
if {$env(TECHNOLOGY) == "SS10LPP_8p75T_13M"} then {
#--------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------

   set KITSLIB 		 /foundry/sec10/data/stdcell/10lpp/SEC
   set TECHLIB 		 /foundry/sec10/data/stdcell/10lpp/SEC/PNR/LN10LPP_INNOVUS_S00-V1.2.2.0_SOURCE/13M_3Mx_6Dx_2Hx_2Iz_LB/8p75TR/
   set VERILOG_TR_C68L22 $KITSLIB/ln10lpp_sc_d8p75t_ipq3904_1.1_1/verilog
   set LEF_TR_C68L22  	 $KITSLIB/ln10lpp_sc_d8p75t_ipq3904_1.1_1/lef
   set NLDM_TR_C68L22  	 $KITSLIB/ln10lpp_sc_d8p75t_ipq3904_1.1_1/lib
   set PMALIB            "/servers/digital_design/dsathish/USB2_IP/cdn_sd1000_ss7lpp/pma_libs"

#--------------------------------------------------------------------------------------------------------
# Verilog Files
#--------------------------------------------------------------------------------------------------------

   set VFILE             "$VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l20.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l20_pwr_aware.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l22.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l22_pwr_aware.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l20.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l20_pwr_aware.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l22.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l22_pwr_aware.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l20.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l20_pwr_aware.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l22.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l22_pwr_aware.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l20.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l20_pwr_aware.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l22.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l22_pwr_aware.v \
                          $PMALIB/../rtl/usb2_pma_top_stub.sv \
			  "

   set ATPGLIB           "$VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l20.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l20_pwr_aware.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l22.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l22_pwr_aware.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l20.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l20_pwr_aware.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l22.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l22_pwr_aware.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l20.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l20_pwr_aware.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l22.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l22_pwr_aware.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l20.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l20_pwr_aware.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l22.v \
                          $VERILOG_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l22_pwr_aware.v \
			  $PMALIB/../rtl/usb2_pma_top_stub.sv \
                         "

#--------------------------------------------------------------------------------------------------------
# Lef Files
#--------------------------------------------------------------------------------------------------------

    set LIBLEF           "$TECHLIB/ln10lpp_tech_13M_3Mx_6Dx_2Hx_2Iz_LB.big.die.lef \
		          $LEF_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l20.lef \
                          $LEF_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l20.lef \
                          $LEF_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l22.lef \
                          $LEF_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l22.lef \
                          $LEF_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l20.lef \
                          $LEF_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l22.lef \
                          $LEF_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l22.lef \
                          $LEF_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l20.lef \
                         "

    set LIBLIB           "$NLDM_TR_C68L22/ \
                          $PMALIB/ \
 		         "
			 
#--------------------------------------------------------------------------------------------------------
# Lib Files
#--------------------------------------------------------------------------------------------------------

set     SLOWLIB          "$NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l20_sspg_nominal_max_0p6750v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l22_sspg_nominal_max_0p6750v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l20_sspg_nominal_max_0p6750v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l22_sspg_nominal_max_0p6750v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l20_sspg_nominal_max_0p6750v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l22_sspg_nominal_max_0p6750v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l20_sspg_nominal_max_0p6750v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l22_sspg_nominal_max_0p6750v_125c_sadhm.lib  \
                          $PMALIB/libs/usb2_pma_top_ssgnp0p675vm40c.lib \
                         "

set     TYPLIB           "$NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l20_tt_nominal_max_0p8500v_55c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l22_tt_nominal_max_0p8500v_55c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l20_tt_nominal_max_0p8500v_55c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l22_tt_nominal_max_0p8500v_55c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l20_tt_nominal_max_0p8500v_55c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l22_tt_nominal_max_0p8500v_55c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l20_tt_nominal_max_0p8500v_55c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l22_tt_nominal_max_0p8500v_55c_sadhm.lib \
                          $PMALIB/libs/usb2_pma_top_ssgnp0p675vm40c.lib \
                         "

set     FASTLIB          "$NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l20_ffpg_nominal_min_0p9000v_m40c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l22_ffpg_nominal_min_0p9000v_m40c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l20_ffpg_nominal_min_0p9000v_m40c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l22_ffpg_nominal_min_0p9000v_m40c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l20_ffpg_nominal_min_0p9000v_m40c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l22_ffpg_nominal_min_0p9000v_m40c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l20_ffpg_nominal_min_0p9000v_m40c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l22_ffpg_nominal_min_0p9000v_m40c_sadhm.lib \
                          $PMALIB/usb2_pma_top_ssgnp0p675vm40c.lib \
                         "

set     MLLIB            "$NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l20_ffpg_nominal_min_0p9000v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l22_ffpg_nominal_min_0p9000v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l20_ffpg_nominal_min_0p9000v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l22_ffpg_nominal_min_0p9000v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l20_ffpg_nominal_min_0p9000v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l22_ffpg_nominal_min_0p9000v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l20_ffpg_nominal_min_0p9000v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l22_ffpg_nominal_min_0p9000v_125c_sadhm.lib  \
                          $PMALIB/usb2_pma_top_ssgnp0p675vm40c.lib \
                         "

#--------------------------------------------------------------------------------------------------------
# EDI Lib Files
#--------------------------------------------------------------------------------------------------------

set     EDI_SLOWLIB      "$NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l20_sspg_nominal_max_0p6750v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l22_sspg_nominal_max_0p6750v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l20_sspg_nominal_max_0p6750v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l22_sspg_nominal_max_0p6750v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l20_sspg_nominal_max_0p6750v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l22_sspg_nominal_max_0p6750v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l20_sspg_nominal_max_0p6750v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l22_sspg_nominal_max_0p6750v_125c_sadhm.lib  \
                          $PMALIB/usb2_pma_top_ssgnp0p675vm40c.lib \
                         "

set     EDI_TYPLIB       "$NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l20_tt_nominal_max_0p8500v_55c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l22_tt_nominal_max_0p8500v_55c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l20_tt_nominal_max_0p8500v_55c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l22_tt_nominal_max_0p8500v_55c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l20_tt_nominal_max_0p8500v_55c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l22_tt_nominal_max_0p8500v_55c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l20_tt_nominal_max_0p8500v_55c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l22_tt_nominal_max_0p8500v_55c_sadhm.lib \
                          $PMALIB/usb2_pma_top_ssgnp0p675vm40c.lib \
                         "

set     EDI_FASTLIB      "$NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l20_ffpg_nominal_min_0p9000v_m40c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l22_ffpg_nominal_min_0p9000v_m40c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l20_ffpg_nominal_min_0p9000v_m40c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l22_ffpg_nominal_min_0p9000v_m40c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l20_ffpg_nominal_min_0p9000v_m40c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l22_ffpg_nominal_min_0p9000v_m40c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l20_ffpg_nominal_min_0p9000v_m40c_sadhm.lib \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l22_ffpg_nominal_min_0p9000v_m40c_sadhm.lib \
                          $PMALIB/usb2_pma_top_ssgnp0p675vm40c.lib \
                         "

set     EDI_MLLIB        "$NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l20_ffpg_nominal_min_0p9000v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_lvt_c68l22_ffpg_nominal_min_0p9000v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l20_ffpg_nominal_min_0p9000v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_flk_rvt_c68l22_ffpg_nominal_min_0p9000v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l20_ffpg_nominal_min_0p9000v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_lvt_c68l22_ffpg_nominal_min_0p9000v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l20_ffpg_nominal_min_0p9000v_125c_sadhm.lib  \
                          $NLDM_TR_C68L22/ln10lpp_sc_d8p75t_pmk_rvt_c68l22_ffpg_nominal_min_0p9000v_125c_sadhm.lib  \
                          $PMALIB/usb2_pma_top_ssgnp0p675vm40c.lib \
                         "

#--------------------------------------------------------------------------------------------------------
# WC/BC DB Files
#--------------------------------------------------------------------------------------------------------

set     WC_DB      	 "
			 "
set     BC_DB      	 "
			 "

#--------------------------------------------------------------------------------------------------------
# Misc Settings
#--------------------------------------------------------------------------------------------------------

    set VDD_values 		"0.675 0.765 0.85 0.90"
    set TEMP_values 		"-40 55 125"
    set ss_setup_derate_factor 	0.320
    set ss_hold_derate_factor 	0.320
    set ff_hold_derate_factor 	0.110
    set PROCNODE      		10
    set max_route_layer 	8
    set DRIVE_CELL   		BUF_D4_N_D8P75TL_C68L22
    set WC_QRC_TECH   		/foundry/sec10/data/lpp/QRC/dig_V1.2.2.0/LN10LPP_Quantus_QRC_S00-V1.2.2.0_SOURCE/tcad/13M_3Mx_6Dx_2Hx_2Iz_LB/SigCmaxDP_ErPlus_MOL_nom_modRvia/qrcTechFile
    set WC_CAP_TABLE  		""
    set TYP_QRC_TECH  		/foundry/sec10/data/lpp/QRC/dig_V1.2.2.0/LN10LPP_Quantus_QRC_S00-V1.2.2.0_SOURCE/tcad/13M_3Mx_6Dx_2Hx_2Iz_LB/nominal/qrcTechFile
    set TYP_CAP_TABLE 		""   
    set BC_QRC_TECH   		/foundry/sec10/data/lpp/QRC/dig_V1.2.2.0/LN10LPP_Quantus_QRC_S00-V1.2.2.0_SOURCE/tcad/13M_3Mx_6Dx_2Hx_2Iz_LB/SigCminDP_ErMinus/qrcTechFile
    set BC_CAP_TABLE  		""

#--------------------------------------------------------------------------------------------------------
# TIE Cells
#--------------------------------------------------------------------------------------------------------

    set TIELIST [list \
       "TIEHI_D1_N_D8P75TR_C68L22" \
       "TIELO_D1_N_D8P75TR_C68L22" \
    ]

#--------------------------------------------------------------------------------------------------------
# DONT USE Cells
#--------------------------------------------------------------------------------------------------------

    set DONT_USE [list                 \
  ]

#--------------------------------------------------------------------------------------------------------
# Clock Buffer Cells
#--------------------------------------------------------------------------------------------------------

    set CLK_BUFFERS [list \
       "BUF_D16_N_D8P75TL_C68L20" \
       "BUF_D14_N_D8P75TL_C68L20" \
       "BUF_D12_N_D8P75TL_C68L20" \
       "BUF_D10_N_D8P75TL_C68L20" \
    ]
       
#--------------------------------------------------------------------------------------------------------
# Inverter Cells
#--------------------------------------------------------------------------------------------------------

    set CLK_INVERTERS [list \
       "INV_D16_N_D8P75TL_C68L20" \
       "INV_D14_N_D8P75TL_C68L20" \
       "INV_D12_N_D8P75TL_C68L20" \
       "INV_D10_N_D8P75TL_C68L20" \
    ]

#--------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------

}
 

 if {$env(TECHNOLOGY) == "SAMSUNG_SS7LPP"} then {

    set KITSLIB       "/process/sec7/data/stdcell/7lpp/SEC/7LPP_STD_MDB_20190219"
    set PMALIBS       "/servers/digital_design/dsathish/usb2_projects/cdn_sd1000_ss7lpp/pma_libs/dotlibs_03052019"

    set VFILE	      "$KITSLIB/verilog/ln07lpp_sc_m7p5t_flk_lvt_c60l08_pwr_aware.v \
                       $KITSLIB/verilog/ln07lpp_sc_m7p5t_flk_lvt_c60l08.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_flk_lvt_c60l10_pwr_aware.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_flk_lvt_c60l10.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_pmk_lvt_c60l08_pwr_aware.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_pmk_lvt_c60l08.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_pmk_lvt_c60l10_pwr_aware.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_pmk_lvt_c60l10.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_flk_rvt_c60l08_pwr_aware.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_flk_rvt_c60l08.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_flk_rvt_c60l10_pwr_aware.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_flk_rvt_c60l10.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_pmk_rvt_c60l08_pwr_aware.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_pmk_rvt_c60l08.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_pmk_rvt_c60l10_pwr_aware.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_pmk_rvt_c60l10.v \
    		       $PMALIBS/../../rtl/usb2_pma_top_stub.sv \
		      "
    
    set ATPGLIB       "$KITSLIB/verilog/ln07lpp_sc_m7p5t_flk_lvt_c60l08_pwr_aware.v \
                       $KITSLIB/verilog/ln07lpp_sc_m7p5t_flk_lvt_c60l08.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_flk_lvt_c60l10_pwr_aware.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_flk_lvt_c60l10.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_pmk_lvt_c60l08_pwr_aware.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_pmk_lvt_c60l08.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_pmk_lvt_c60l10_pwr_aware.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_pmk_lvt_c60l10.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_flk_rvt_c60l08_pwr_aware.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_flk_rvt_c60l08.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_flk_rvt_c60l10_pwr_aware.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_flk_rvt_c60l10.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_pmk_rvt_c60l08_pwr_aware.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_pmk_rvt_c60l08.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_pmk_rvt_c60l10_pwr_aware.v \
		       $KITSLIB/verilog/ln07lpp_sc_m7p5t_pmk_rvt_c60l10.v \
		       $PMALIBS/../../rtl/usb2_pma_top_stub.sv \
                      "
      
     	      
    set LIBLIB       "$KITSLIB/lib/ \
                      $PMALIBS \      
		     "
 
    set LIBLEF       "/process/sec7/data/stdcell/7lpp/SEC/PRTF/LN07LPP_INNOVUS_S00-V1.0.1.1/13M_4Mx_7Dx_1Gx_1Iz_LB/6p75TR/ln07lpp_tech_13M_4Mx_7Dx_1Gx_1Iz_LB.lef \
                      $KITSLIB/lef/ln07lpp_sc_m7p5t_flk_lvt_c60l08.lef \
    		      $KITSLIB/lef/ln07lpp_sc_m7p5t_flk_lvt_c60l10.lef \
		      $KITSLIB/lef/ln07lpp_sc_m7p5t_pmk_lvt_c60l08.lef \
		      $KITSLIB/lef/ln07lpp_sc_m7p5t_pmk_lvt_c60l10.lef \
		      $KITSLIB/lef/ln07lpp_sc_m7p5t_flk_rvt_c60l08.lef \
		      $KITSLIB/lef/ln07lpp_sc_m7p5t_flk_rvt_c60l10.lef \
		      $KITSLIB/lef/ln07lpp_sc_m7p5t_pmk_rvt_c60l08.lef \
		      $KITSLIB/lef/ln07lpp_sc_m7p5t_pmk_rvt_c60l10.lef \
    		     "

    set SLOWLIB      "ln07lpp_sc_m7p5t_flk_lvt_c60l08_sspg_nominal_max_0p6750v_m40c_sadhm.lib \
                      ln07lpp_sc_m7p5t_flk_lvt_c60l10_sspg_nominal_max_0p6750v_m40c_sadhm.lib \
		      ln07lpp_sc_m7p5t_pmk_lvt_c60l08_sspg_nominal_max_0p6750v_m40c_sadhm.lib \
		      ln07lpp_sc_m7p5t_pmk_lvt_c60l10_sspg_nominal_max_0p6750v_m40c_sadhm.lib \
		      ln07lpp_sc_m7p5t_flk_rvt_c60l08_sspg_nominal_max_0p6750v_m40c_sadhm.lib \
		      ln07lpp_sc_m7p5t_flk_rvt_c60l10_sspg_nominal_max_0p6750v_m40c_sadhm.lib \
		      ln07lpp_sc_m7p5t_pmk_rvt_c60l08_sspg_nominal_max_0p6750v_m40c_sadhm.lib \
		      ln07lpp_sc_m7p5t_pmk_rvt_c60l10_sspg_nominal_max_0p6750v_m40c_sadhm.lib \
		      usb2_pma_top_sspg_0p675v_m40c_SigRCmaxDP_ErPlus_GlobalRvia_MOL_nominal.lib \
		     "
    set TYPLIB       "ln07lpp_sc_m7p5t_flk_lvt_c60l08_tt_nominal_max_0p8500v_55c_sadhm.lib \
    		      ln07lpp_sc_m7p5t_flk_lvt_c60l10_tt_nominal_max_0p8500v_55c_sadhm.lib \
		      ln07lpp_sc_m7p5t_pmk_lvt_c60l08_tt_nominal_max_0p8500v_55c_sadhm.lib \
		      ln07lpp_sc_m7p5t_pmk_lvt_c60l10_tt_nominal_max_0p8500v_55c_sadhm.lib \
		      ln07lpp_sc_m7p5t_flk_rvt_c60l08_tt_nominal_max_0p8500v_55c_sadhm.lib \
		      ln07lpp_sc_m7p5t_flk_rvt_c60l10_tt_nominal_max_0p8500v_55c_sadhm.lib \
		      ln07lpp_sc_m7p5t_pmk_rvt_c60l08_tt_nominal_max_0p8500v_55c_sadhm.lib \
		      ln07lpp_sc_m7p5t_pmk_rvt_c60l10_tt_nominal_max_0p8500v_55c_sadhm.lib \
		      usb2_pma_top_tt_0p750v_25c_SigRCmaxDP_ErPlus_GlobalRvia_MOL_nominal.lib \
                     "
    set FASTLIB      "ln07lpp_sc_m7p5t_flk_lvt_c60l08_ffpg_nominal_min_0p9000v_125c_sadhm.lib \
                      ln07lpp_sc_m7p5t_flk_lvt_c60l10_ffpg_nominal_min_0p9000v_125c_sadhm.lib \
		      ln07lpp_sc_m7p5t_pmk_lvt_c60l08_ffpg_nominal_min_0p9000v_125c_sadhm.lib \
		      ln07lpp_sc_m7p5t_pmk_lvt_c60l10_ffpg_nominal_min_0p9000v_125c_sadhm.lib \
		      ln07lpp_sc_m7p5t_flk_rvt_c60l08_ffpg_nominal_min_0p9000v_125c_sadhm.lib \
		      ln07lpp_sc_m7p5t_flk_rvt_c60l10_ffpg_nominal_min_0p9000v_125c_sadhm.lib \
		      ln07lpp_sc_m7p5t_pmk_rvt_c60l08_ffpg_nominal_min_0p9000v_125c_sadhm.lib \
		      ln07lpp_sc_m7p5t_pmk_rvt_c60l10_ffpg_nominal_min_0p9000v_125c_sadhm.lib \
		      usb2_pma_top_ffpg_0p900v_m40c_SigRCminDP_ErMinus_GlobalRvia_MOL_nominal.lib \
    		     "
 		      
    set EDI_SLOWLIB  "$KITSLIB/lib/ln07lpp_sc_m7p5t_flk_lvt_c60l08_sspg_nominal_max_0p6750v_m40c_sadhm.lib \
                      $KITSLIB/lib/ln07lpp_sc_m7p5t_flk_lvt_c60l10_sspg_nominal_max_0p6750v_m40c_sadhm.lib \
		      $KITSLIB/lib/ln07lpp_sc_m7p5t_pmk_lvt_c60l08_sspg_nominal_max_0p6750v_m40c_sadhm.lib \
		      $KITSLIB/lib/ln07lpp_sc_m7p5t_pmk_lvt_c60l10_sspg_nominal_max_0p6750v_m40c_sadhm.lib \
		      $KITSLIB/lib/ln07lpp_sc_m7p5t_flk_rvt_c60l08_sspg_nominal_max_0p6750v_m40c_sadhm.lib \
		      $KITSLIB/lib/ln07lpp_sc_m7p5t_flk_rvt_c60l10_sspg_nominal_max_0p6750v_m40c_sadhm.lib \
		      $KITSLIB/lib/ln07lpp_sc_m7p5t_pmk_rvt_c60l08_sspg_nominal_max_0p6750v_m40c_sadhm.lib \
		      $KITSLIB/lib/ln07lpp_sc_m7p5t_pmk_rvt_c60l10_sspg_nominal_max_0p6750v_m40c_sadhm.lib \
		      $PMALIBS/usb2_pma_top_sspg_0p675v_m40c_SigRCmaxDP_ErPlus_GlobalRvia_MOL_nominal.lib \
                     "
    set EDI_TYPLIB   "$KITSLIB/lib/ln07lpp_sc_m7p5t_flk_lvt_c60l08_tt_nominal_max_0p8500v_55c_sadhm.lib \
    		      $KITSLIB/lib/ln07lpp_sc_m7p5t_flk_lvt_c60l10_tt_nominal_max_0p8500v_55c_sadhm.lib \
		      $KITSLIB/lib/ln07lpp_sc_m7p5t_pmk_lvt_c60l08_tt_nominal_max_0p8500v_55c_sadhm.lib \
		      $KITSLIB/lib/ln07lpp_sc_m7p5t_pmk_lvt_c60l10_tt_nominal_max_0p8500v_55c_sadhm.lib \
		      $KITSLIB/lib/ln07lpp_sc_m7p5t_flk_rvt_c60l08_tt_nominal_max_0p8500v_55c_sadhm.lib \
		      $KITSLIB/lib/ln07lpp_sc_m7p5t_flk_rvt_c60l10_tt_nominal_max_0p8500v_55c_sadhm.lib \
		      $KITSLIB/lib/ln07lpp_sc_m7p5t_pmk_rvt_c60l08_tt_nominal_max_0p8500v_55c_sadhm.lib \
		      $KITSLIB/lib/ln07lpp_sc_m7p5t_pmk_rvt_c60l10_tt_nominal_max_0p8500v_55c_sadhm.lib \
		      $PMALIBS/usb2_pma_top_tt_0p750v_25c_SigRCmaxDP_ErPlus_GlobalRvia_MOL_nominal.lib \
                     "
		       		     		     
    set EDI_FASTLIB  "$KITSLIB/lib/ln07lpp_sc_m7p5t_flk_lvt_c60l08_ffpg_nominal_min_0p9000v_125c_sadhm.lib \
                      $KITSLIB/lib/ln07lpp_sc_m7p5t_flk_lvt_c60l10_ffpg_nominal_min_0p9000v_125c_sadhm.lib \
		      $KITSLIB/lib/ln07lpp_sc_m7p5t_pmk_lvt_c60l08_ffpg_nominal_min_0p9000v_125c_sadhm.lib \
		      $KITSLIB/lib/ln07lpp_sc_m7p5t_pmk_lvt_c60l10_ffpg_nominal_min_0p9000v_125c_sadhm.lib \
		      $KITSLIB/lib/ln07lpp_sc_m7p5t_flk_rvt_c60l08_ffpg_nominal_min_0p9000v_125c_sadhm.lib \
		      $KITSLIB/lib/ln07lpp_sc_m7p5t_flk_rvt_c60l10_ffpg_nominal_min_0p9000v_125c_sadhm.lib \
		      $KITSLIB/lib/ln07lpp_sc_m7p5t_pmk_rvt_c60l08_ffpg_nominal_min_0p9000v_125c_sadhm.lib \
		      $KITSLIB/lib/ln07lpp_sc_m7p5t_pmk_rvt_c60l10_ffpg_nominal_min_0p9000v_125c_sadhm.lib \
		      $PMALIBS/usb2_pma_top_ffpg_0p900v_m40c_SigRCminDP_ErMinus_GlobalRvia_MOL_nominal.lib \
                     "
		       
    set EDI_MLLIB   "
                     $PMALIBS/usb2_pma_top_ffpg_0p900v_m40c_SigRCminDP_ErMinus_GlobalRvia_MOL_nominal.lib \
                    "	       	
		       	      
    set VDD_values "0.675 0.765 0.85 0.90"
    set TEMP_values "-40 55 125"
    set ss_setup_derate_factor 0.320
    set ss_hold_derate_factor 0.320
    set ff_hold_derate_factor 0.110
    set PROCNODE 7
    set max_route_layer 7
    set DRIVE_CELL    BUF_D4_N_D7P5TL_C60L10
    set WC_QRC_TECH   "/process/sec7/data/lpp/QRC/V1.0.4.0/LN07LPP_QuantusQRC_S00-V1.0.4.0_SOURCE/QRC/LN07LPP_QuantusQRC_S00-V1.0.4.0/13M_4Mx_7Dx_2Iz_LB/SigCmaxDP_ErPlus_GlobalRvia_MOL_nominal/qrcTechFile"
    set WC_CAP_TABLE  ""
    set TYP_QRC_TECH  "/process/sec7/data/lpp/QRC/V1.0.4.0/LN07LPP_QuantusQRC_S00-V1.0.4.0_SOURCE/QRC/LN07LPP_QuantusQRC_S00-V1.0.4.0/13M_4Mx_7Dx_2Iz_LB/nominal/qrcTechFile"
    set TYP_CAP_TABLE ""   
    set BC_QRC_TECH   "/process/sec7/data/lpp/QRC/V1.0.4.0/LN07LPP_QuantusQRC_S00-V1.0.4.0_SOURCE/QRC/LN07LPP_QuantusQRC_S00-V1.0.4.0/13M_4Mx_7Dx_2Iz_LB/SigCminDP_ErMinus/qrcTechFile"
    set BC_CAP_TABLE  ""
    set TIELIST [list ]

    
    set DONT_USE [list ]
    set CLK_BUFFERS [list \
    "BUF_D16_N_M7P5TL_C60L08" \
    "BUF_D14_N_M7P5TL_C60L08" \
    "BUF_D12_N_M7P5TL_C60L08" \
    "BUF_D10_N_M7P5TL_C60L08" \
    ]
    set CLK_INVERTERS [list \
    "INV_D16_N_M7P5TL_C60L08" \
    "INV_D14_N_M7P5TL_C60L08" \
    "INV_D12_N_M7P5TL_C60L08" \
    "INV_D10_N_M7P5TL_C60L08" \
    ]

 }

 if {$env(TECHNOLOGY) == "SAMSUNG_SS18"} then {

    set KITSLIB       "/process/sec18/data/stdcell/18fdsoi/ST"
    set PMALIBS       "/servers/digital_design/dsathish/usb2_projects/cdn_sd1000_ss18fdsoi/pma_libs/dotlibs_03052019"

    set VFILE	      "$KITSLIB/sc9mcp_base_rvt_c18_r3p0.20201224-00/verilog/sc9mcp_ln18fds_base_rvt_c18.v \
		       $KITSLIB/sc9mcp_base_rvt_c22_r3p0.20201224-00/verilog/sc9mcp_ln18fds_base_rvt_c22.v \
    		       $KITSLIB/sc9mcp_pmk_rvt_c18_r0p0.20201224/verilog/sc9mcp_ln18fds_pmk_rvt_c18.v \
    		       $KITSLIB/sc9mcp_pmk_rvt_c22_r0p0.20201224/verilog/sc9mcp_ln18fds_pmk_rvt_c22.v \
		       $KITSLIB/sc9mcp_base_lvt_c22_r3p0.20201224-00/verilog/sc9mcp_ln18fds_base_lvt_c22.v \
		       $KITSLIB/sc9mcp_pmk_lvt_c22_r0p0.20201224/verilog/sc9mcp_ln18fds_pmk_lvt_c22.v \
		       $KITSLIB/sc9mcp_base_lvt_c18_r3p0.20201224-00/verilog/sc9mcp_ln18fds_base_lvt_c18.v \
		       $KITSLIB/sc9mcp_pmk_lvt_c18_r0p0.20201224/verilog/sc9mcp_ln18fds_pmk_lvt_c18.v \
    		       $PMALIBS/../../rtl/usb2_pma_top_stub.sv \
		      "
    
    set ATPGLIB       "$KITSLIB/sc9mcp_base_rvt_c18_r3p0.20201224-00/dft/fastscan/sc9mcp_ln18fds_base_rvt_c18.mdt \
    		       $KITSLIB/sc9mcp_base_rvt_c22_r3p0.20201224-00/dft/fastscan/sc9mcp_ln18fds_base_rvt_c22.mdt \
    		       $KITSLIB/sc9mcp_pmk_rvt_c18_r0p0.20201224/dft/fastscan/sc9mcp_ln18fds_pmk_rvt_c18.v \
    		       $KITSLIB/sc9mcp_pmk_rvt_c22_r0p0.20201224/dft/fastscan/sc9mcp_ln18fds_pmk_rvt_c22.v \
		       $KITSLIB/sc9mcp_base_lvt_c22_r3p0.20201224-00/dft/fastscan/sc9mcp_ln18fds_base_lvt_c22.mdt \
		       $KITSLIB/sc9mcp_pmk_lvt_c22_r0p0.20201224/dft/fastscan/sc9mcp_ln18fds_pmk_lvt_c22.mdt \
		       $PMALIBS/../../rtl/usb2_pma_top_stub.sv \
                      "
      
     	      
    set LIBLIB       "$KITSLIB/sc9mcp_base_rvt_c18_r3p0.20201224-00/lib \
                      $KITSLIB/sc9mcp_base_rvt_c22_r3p0.20201224-00/lib \
                      $KITSLIB/sc9mcp_pmk_rvt_c18_r0p0.20201224/lib \
                      $KITSLIB/sc9mcp_pmk_rvt_c22_r0p0.20201224/lib \
		      $KITSLIB/sc9mcp_base_lvt_c22_r3p0.20201224-00/lib \
		      $KITSLIB/sc9mcp_pmk_lvt_c22_r0p0.20201224/lib \
		      $KITSLIB/sc9mcp_base_lvt_c18_r3p0.20201224-00/lib \
		      $KITSLIB/sc9mcp_pmk_lvt_c18_r0p0.20201224/lib \
                      $PMALIBS/ \      
		     "
 
    set LIBLEF       "$KITSLIB/sc9mcp_base_rvt_c18_r3p0.20201224-00/lef/sc9mcp_ln18fds_base_rvt_c18.lef \
                      $KITSLIB/sc9mcp_base_rvt_c22_r3p0.20201224-00/lef/sc9mcp_ln18fds_base_rvt_c22.lef \
                      $KITSLIB/sc9mcp_pmk_rvt_c18_r0p0.20201224/lef/sc9mcp_ln18fds_pmk_rvt_c18.lef \
                      $KITSLIB/sc9mcp_pmk_rvt_c22_r0p0.20201224/lef/sc9mcp_ln18fds_pmk_rvt_c22.lef \
		      $KITSLIB/sc9mcp_base_lvt_c22_r3p0.20201224-00/lef/sc9mcp_ln18fds_base_lvt_c22.lef \
		      $KITSLIB/sc9mcp_pmk_lvt_c22_r0p0.20201224/lef/sc9mcp_ln18fds_pmk_lvt_c22.lef \
		      $KITSLIB/sc9mcp_base_lvt_c18_r3p0.20201224-00/lef/sc9mcp_ln18fds_base_lvt_c18.lef \
		      $KITSLIB/sc9mcp_pmk_lvt_c18_r0p0.20201224/lef/sc9mcp_ln18fds_pmk_lvt_c18.lef \
		      $KITSLIB/P18_Foundation_Cadence_TechnoKit_8M3Mx3Cx1Gx1UTMLB_1.0-INTERM-00/PRTF/LEF/technology.lef \
		      /process/sec18/data/stdcell/18fdsoi/SEC/LN18FDS_INNOVUS_S00_V0.8.0.0/PRTF/LN18FDS_INNOVUS_S00-V0.8.0.0/8M_3Mx_3Cx_1Gx_1UTM_LB/ln18fds_tech_8M_3Mx_3Cx_1Gx_1UTM_LB.lef \
    		     "

    set SLOWLIB      "sc9mcp_ln18fds_base_rvt_c18_sspg_nominal_max_0p72v_0p00vnw_0p00vpw_m40c.lib \
                      sc9mcp_ln18fds_base_rvt_c22_sspg_nominal_max_0p72v_0p00vnw_0p00vpw_m40c.lib \
                      sc9mcp_ln18fds_pmk_rvt_c18_sspg_nominal_max_0p72v_0p00vnw_0p00vpw_m40c.lib \
                      sc9mcp_ln18fds_pmk_rvt_c22_sspg_nominal_max_0p72v_0p00vnw_0p00vpw_m40c.lib \
		      sc9mcp_ln18fds_base_lvt_c22_sspg_nominal_max_0p72v_0p00vnw_0p00vpw_m40c.lib \
		      sc9mcp_ln18fds_pmk_lvt_c22_sspg_nominal_max_0p72v_0p00vnw_0p00vpw_m40c.lib \
		      sc9mcp_ln18fds_pmk_lvt_c18_sspg_nominal_max_0p72v_0p00vnw_0p00vpw_m40c.lib \
		      sc9mcp_ln18fds_base_lvt_c18_sspg_nominal_max_0p72v_0p00vnw_0p00vpw_m40c.lib \
		      usb2_pma_top_sspg_0p675v_m40c_SigRCmaxDP_ErPlus_GlobalRvia_MOL_nominal.lib \
		     "
    set TYPLIB       "sc9mcp_ln18fds_base_rvt_c18_tt_nominal_max_0p90v_0p00vnw_0p00vpw_25c.lib \
                      sc9mcp_ln18fds_base_rvt_c22_tt_nominal_max_0p90v_0p00vnw_0p00vpw_25c.lib \
                      sc9mcp_ln18fds_pmk_rvt_c18_tt_nominal_max_0p90v_0p00vnw_0p00vpw_25c.lib \
                      sc9mcp_ln18fds_pmk_rvt_c22_tt_nominal_max_0p90v_0p00vnw_0p00vpw_25c.lib \
		      sc9mcp_ln18fds_base_lvt_c22_tt_nominal_max_0p90v_0p00vnw_0p00vpw_25c.lib \
		      sc9mcp_ln18fds_pmk_lvt_c22_tt_nominal_max_0p90v_0p00vnw_0p00vpw_25c.lib \
		      sc9mcp_ln18fds_pmk_lvt_c18_tt_nominal_max_0p90v_0p00vnw_0p00vpw_25c.lib \
		      sc9mcp_ln18fds_base_lvt_c18_tt_nominal_max_0p90v_0p00vnw_0p00vpw_25c.lib \
		      usb2_pma_top_tt_0p750v_25c_SigRCmaxDP_ErPlus_GlobalRvia_MOL_nominal.lib \
                     "
    set FASTLIB      "sc9mcp_ln18fds_base_rvt_c18_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
		      sc9mcp_ln18fds_base_rvt_c22_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
		      sc9mcp_ln18fds_pmk_rvt_c18_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
		      sc9mcp_ln18fds_pmk_rvt_c22_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
		      sc9mcp_ln18fds_base_lvt_c22_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
		      sc9mcp_ln18fds_pmk_lvt_c22_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
		      sc9mcp_ln18fds_pmk_lvt_c18_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
		      sc9mcp_ln18fds_base_lvt_c18_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
		      usb2_pma_top_ffpg_0p900v_m40c_SigCmaxDP_ErPlus_GlobalRvia_MOL_nominal.lib  \
    		     "
 		      
    set EDI_SLOWLIB  "$KITSLIB/sc9mcp_base_rvt_c18_r3p0.20201224-00/lib/sc9mcp_ln18fds_base_rvt_c18_sspg_nominal_max_0p72v_0p00vnw_0p00vpw_m40c.lib \
		      $KITSLIB/sc9mcp_base_rvt_c22_r3p0.20201224-00/lib/sc9mcp_ln18fds_base_rvt_c22_sspg_nominal_max_0p72v_0p00vnw_0p00vpw_m40c.lib \
		      $KITSLIB/sc9mcp_pmk_rvt_c18_r0p0.20201224/lib/sc9mcp_ln18fds_pmk_rvt_c18_sspg_nominal_max_0p72v_0p00vnw_0p00vpw_m40c.lib \
		      $KITSLIB/sc9mcp_pmk_rvt_c22_r0p0.20201224/lib/sc9mcp_ln18fds_pmk_rvt_c22_sspg_nominal_max_0p72v_0p00vnw_0p00vpw_m40c.lib \
		      $KITSLIB/sc9mcp_base_lvt_c22_r3p0.20201224-00/lib/sc9mcp_ln18fds_base_lvt_c22_sspg_nominal_max_0p72v_0p00vnw_0p00vpw_m40c.lib \
		      $KITSLIB/sc9mcp_pmk_lvt_c22_r0p0.20201224/lib/sc9mcp_ln18fds_pmk_lvt_c22_sspg_nominal_max_0p72v_0p00vnw_0p00vpw_m40c.lib \
		      $KITSLIB/sc9mcp_pmk_lvt_c18_r0p0.20201224/lib/sc9mcp_ln18fds_pmk_lvt_c18_sspg_nominal_max_0p72v_0p00vnw_0p00vpw_m40c.lib \
		      $KITSLIB/sc9mcp_base_lvt_c18_r3p0.20201224-00/lib/sc9mcp_ln18fds_base_lvt_c18_sspg_nominal_max_0p72v_0p00vnw_0p00vpw_m40c.lib \
		      $PMALIBS/usb2_pma_top_sspg_0p675v_m40c_SigRCmaxDP_ErPlus_GlobalRvia_MOL_nominal.lib \
                     "
    set EDI_TYPLIB   "$KITSLIB/sc9mcp_base_rvt_c18_r3p0.20201224-00/lib/sc9mcp_ln18fds_base_rvt_c18_tt_nominal_max_0p90v_0p00vnw_0p00vpw_25c.lib \
                      $KITSLIB/sc9mcp_base_rvt_c22_r3p0.20201224-00/lib/sc9mcp_ln18fds_base_rvt_c22_tt_nominal_max_0p90v_0p00vnw_0p00vpw_25c.lib \
                      $KITSLIB/sc9mcp_pmk_rvt_c18_r0p0.20201224/lib/sc9mcp_ln18fds_pmk_rvt_c18_tt_nominal_max_0p90v_0p00vnw_0p00vpw_25c.lib \
                      $KITSLIB/sc9mcp_pmk_rvt_c22_r0p0.20201224/lib/sc9mcp_ln18fds_pmk_rvt_c22_tt_nominal_max_0p90v_0p00vnw_0p00vpw_25c.lib \
		      $KITSLIB/sc9mcp_base_lvt_c22_r3p0.20201224-00/lib/sc9mcp_ln18fds_base_lvt_c22_tt_nominal_max_0p90v_0p00vnw_0p00vpw_25c.lib \
		      $KITSLIB/sc9mcp_pmk_lvt_c22_r0p0.20201224/lib/sc9mcp_ln18fds_pmk_lvt_c22_tt_nominal_max_0p90v_0p00vnw_0p00vpw_25c.lib \
		      $KITSLIB/sc9mcp_pmk_lvt_c18_r0p0.20201224/lib/sc9mcp_ln18fds_pmk_lvt_c18_tt_nominal_max_0p90v_0p00vnw_0p00vpw_25c.lib \
		      $KITSLIB/sc9mcp_base_lvt_c18_r3p0.20201224-00/lib/sc9mcp_ln18fds_base_lvt_c18_tt_nominal_max_0p90v_0p00vnw_0p00vpw_25c.lib \
		      $PMALIBS/usb2_pma_top_tt_0p750v_25c_SigRCmaxDP_ErPlus_GlobalRvia_MOL_nominal.lib \
                     "
		       		     		     
    set EDI_FASTLIB  "$KITSLIB/sc9mcp_base_rvt_c18_r3p0.20201224-00/lib/sc9mcp_ln18fds_base_rvt_c18_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
                      $KITSLIB/sc9mcp_base_rvt_c22_r3p0.20201224-00/lib/sc9mcp_ln18fds_base_rvt_c22_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
                      $KITSLIB/sc9mcp_pmk_rvt_c18_r0p0.20201224/lib/sc9mcp_ln18fds_pmk_rvt_c18_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
                      $KITSLIB/sc9mcp_pmk_rvt_c22_r0p0.20201224/lib/sc9mcp_ln18fds_pmk_rvt_c22_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
		      $KITSLIB/sc9mcp_base_lvt_c22_r3p0.20201224-00/lib/sc9mcp_ln18fds_base_lvt_c22_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
		      $KITSLIB/sc9mcp_pmk_lvt_c22_r0p0.20201224/lib/sc9mcp_ln18fds_pmk_lvt_c22_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
		      $KITSLIB/sc9mcp_pmk_lvt_c18_r0p0.20201224/lib/sc9mcp_ln18fds_pmk_lvt_c18_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
		      $KITSLIB/sc9mcp_base_lvt_c18_r3p0.20201224-00/lib/sc9mcp_ln18fds_base_lvt_c18_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
		      $PMALIBS/usb2_pma_top_ffpg_0p900v_m40c_SigCmaxDP_ErPlus_GlobalRvia_MOL_nominal.lib \
                     "
		       
    set EDI_MLLIB   "$KITSLIB/sc9mcp_base_rvt_c18_r3p0.20201224-00/lib/sc9mcp_ln18fds_base_rvt_c18_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
                     $KITSLIB/sc9mcp_base_rvt_c22_r3p0.20201224-00/lib/sc9mcp_ln18fds_base_rvt_c22_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
                     $KITSLIB/sc9mcp_pmk_rvt_c18_r0p0.20201224/lib/sc9mcp_ln18fds_pmk_rvt_c18_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
                     $KITSLIB/sc9mcp_pmk_rvt_c22_r0p0.20201224/lib/sc9mcp_ln18fds_pmk_rvt_c22_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
		     $KITSLIB/sc9mcp_base_lvt_c22_r3p0.20201224-00/lib/sc9mcp_ln18fds_base_lvt_c22_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
		     $KITSLIB/sc9mcp_pmk_lvt_c22_r0p0.20201224/lib/sc9mcp_ln18fds_pmk_lvt_c22_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
		     $KITSLIB/sc9mcp_pmk_lvt_c18_r0p0.20201224/lib/sc9mcp_ln18fds_pmk_lvt_c18_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
		     $KITSLIB/sc9mcp_base_lvt_c18_r3p0.20201224-00/lib/sc9mcp_ln18fds_base_lvt_c18_ffpg_nominal_min_1p10v_0p00vnw_0p00vpw_m40c.lib \
                     $PMALIBS/usb2_pma_top_ffpg_0p900v_m40c_SigCmaxDP_ErPlus_GlobalRvia_MOL_nominal.lib \
                    "	       	
		       	      
    set VDD_values "0.72 0.80 0.88"
    set TEMP_values "140 25 -40"
    set ss_setup_derate_factor 0.11
    set ss_hold_derate_factor 0.14
    set ff_hold_derate_factor 0.18
    set PROCNODE 18
    set max_route_layer 6
    set DRIVE_CELL   BUF_X6M_A9PTR_C18 
    set WC_QRC_TECH   "/process/sec18/data/stdcell/18fdsoi/ST/P18_Foundation_Cadence_TechnoKit_8M3Mx3Cx1Gx1UTMLB_1.0-INTERM-00/PRTF/QRC_TECHFILE/SigCmaxDP_ErPlus/qrcTechFile"
    set WC_CAP_TABLE  ""
    set TYP_QRC_TECH  "/process/sec18/data/stdcell/18fdsoi/ST/P18_Foundation_Cadence_TechnoKit_8M3Mx3Cx1Gx1UTMLB_1.0-INTERM-00/PRTF/QRC_TECHFILE/nominal/qrcTechFile"
    set TYP_CAP_TABLE ""   
    set BC_QRC_TECH   "/process/sec18/data/stdcell/18fdsoi/ST/P18_Foundation_Cadence_TechnoKit_8M3Mx3Cx1Gx1UTMLB_1.0-INTERM-00/PRTF/QRC_TECHFILE/SigCminDP_ErMinus/qrcTechFile"
    set BC_CAP_TABLE  ""
    set TIELIST [list ]

    
    set DONT_USE [list 	\
		  "*X0P*" \
		  "*X1M*" \
		  "*X1P*" \
		  "*X1B*" \
		  "*X1A*" \
		  "*X20*" \
		  "DLY*" \
		  "HEAD*" \
		  ]   
    set CLK_BUFFERS [list BUF_X4B*]
    set CLK_INVERTERS [list INV_X4B*]

 }


