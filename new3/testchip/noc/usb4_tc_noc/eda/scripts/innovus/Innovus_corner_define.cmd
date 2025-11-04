#############################################################################################
#        Copyright (c) 2010-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

#######################################################
#                                                     #
#  Innovus Corner configuration file		      # 
#                                                     #
#######################################################
source Innovus_define.cmd

set VER [lindex [split [getVersion] {-}] 0]
###############################################################################
#  Specify SDCs for all design modes
###############################################################################
if {$Innovus_UseiSpatialDB == 1} {
  if {$VER > 22} {
    if {[file exists ${FILE_NAME_PREFIX}_syn.db/cmn/${TOP_DESIGN}.mmmc/modes/default_emulate_constraint_mode/default_emulate_constraint_mode.sdc.gz]} {
      create_constraint_mode -name setup_view_functional -sdc_files \
          [list ${FILE_NAME_PREFIX}_syn.db/cmn/${TOP_DESIGN}.mmmc/modes/default_emulate_constraint_mode/default_emulate_constraint_mode.sdc.gz]
  
      create_constraint_mode -name hold_view_functional -sdc_files \
          [list ${FILE_NAME_PREFIX}_syn.db/cmn/${TOP_DESIGN}.mmmc/modes/default_emulate_constraint_mode/default_emulate_constraint_mode.sdc.gz]
  
      create_constraint_mode -name typ_view_functional -sdc_files \
          [list ${FILE_NAME_PREFIX}_syn.db/cmn/${TOP_DESIGN}.mmmc/modes/default_emulate_constraint_mode/default_emulate_constraint_mode.sdc.gz]
    } else {
      Puts [format "%s%s" "**ERR" "OR: There was no iSpatial SDC file to load."]
      Puts [format "%s%s" "**ERR" "OR: Please check if an iSpatial SDC was generated in Synthesis"]
      exit
    }
  } else {
    if {[file exists ../syn_genus/genus_innovus_interface_data/genus2invs.default_emulate_constraint_mode.sdc]} {
      create_constraint_mode -name setup_view_functional -sdc_files \
          [list ../syn_genus/genus_innovus_interface_data/genus2invs.default_emulate_constraint_mode.sdc]

      create_constraint_mode -name hold_view_functional -sdc_files \
          [list ../syn_genus/genus_innovus_interface_data/genus2invs.default_emulate_constraint_mode.sdc]

      create_constraint_mode -name typ_view_functional -sdc_files \
          [list ../syn_genus/genus_innovus_interface_data/genus2invs.default_emulate_constraint_mode.sdc]
    } else {
      Puts [format "%s%s" "**ERR" "OR: There was no iSpatial SDC file to load."]
      Puts [format "%s%s" "**ERR" "OR: Please check if an iSpatial SDC was generated in Synthesis"]
      exit
    }
  }
} else {
  create_constraint_mode -name setup_view_functional -sdc_files \
	[list [format "%s%s" $FILE_NAME_PREFIX "_cons.sdc"]]

  create_constraint_mode -name hold_view_functional -sdc_files \
        [list [format "%s%s" $FILE_NAME_PREFIX "_cons.sdc"]]

  create_constraint_mode -name typ_view_functional -sdc_files \
        [list [format "%s%s" $FILE_NAME_PREFIX "_cons.sdc"]]
}

###############################################################################
#  Create a library set consisting of .lib and .cdb files for each PVT corner
###############################################################################


if {$Innovus_DerateMethod == 2} { 
  create_library_set -name max_lib_set -timing $Lib_CadenceLIB -aocv $MAX_SBOCV
  create_library_set -name typ_lib_set -timing $Lib_CadenceTypLIB -aocv $MAX_SBOCV
  create_library_set -name min_lib_set -timing $Lib_CadenceMinLIB -aocv $MIN_SBOCV
  set EnableSBOCV 1
} else {
  create_library_set -name max_lib_set -timing $Lib_CadenceLIB  
  create_library_set -name min_lib_set -timing $Lib_CadenceMinLIB
  create_library_set -name typ_lib_set -timing $Lib_CadenceTypLIB
}
###############################################################################
#  Create extraction corners
###############################################################################

set cmd "create_rc_corner -name max_rc_corner \
                          -preRoute_res 1.0 \
                          -preRoute_cap 1.0 \
                          -preRoute_clkres 1.0 \
                          -preRoute_clkcap 1.0 \
                          -postRoute_res 1.0 \
                          -postRoute_cap 1.0 \
                          -postRoute_clkres 1.0 \
                          -postRoute_clkcap 1.0 \
                          -postRoute_xcap 1.0 \
                          -T $Lib_MaxCornerTemp "
if {[info exists Lib_MaxCapTable] && $Lib_MaxCapTable != "" && $Lib_MaxCapTable != "{}"} {
  set cmd "$cmd -cap_table $Lib_MaxCapTable "
}
if {[info exists Lib_MaxQrcTechFile] && $Lib_MaxQrcTechFile != "" && $Lib_MaxQrcTechFile != "{}"} {
  set cmd "$cmd -qx_tech_file $Lib_MaxQrcTechFile "
}
eval $cmd

set cmd "create_rc_corner -name min_rc_corner \
                          -preRoute_res 1.0 \
                          -preRoute_cap 1.0 \
                          -preRoute_clkres 1.0 \
                          -preRoute_clkcap 1.0 \
                          -postRoute_res 1.0 \
                          -postRoute_cap 1.0 \
                          -postRoute_clkres 1.0 \
                          -postRoute_clkcap 1.0 \
                          -postRoute_xcap 1.0 \
                          -T $Lib_MinCornerTemp "
if {[info exists Lib_MinCapTable] && $Lib_MinCapTable != "" && $Lib_MinCapTable != "{}"} {
  set cmd "$cmd -cap_table $Lib_MinCapTable "
}
if {[info exists Lib_MinQrcTechFile] && $Lib_MinQrcTechFile != "" && $Lib_MinQrcTechFile != "{}"} {
  set cmd "$cmd -qx_tech_file $Lib_MinQrcTechFile "
}
eval $cmd

set cmd "create_rc_corner -name typ_rc_corner \
                          -preRoute_res 1.0 \
                          -preRoute_cap 1.0 \
                          -preRoute_clkres 1.0 \
                          -preRoute_clkcap 1.0 \
                          -postRoute_res 1.0 \
                          -postRoute_cap 1.0 \
                          -postRoute_clkres 1.0 \
                          -postRoute_clkcap 1.0 \
                          -postRoute_xcap 1.0 \
                          -T $Lib_TypCornerTemp "
if {[info exists Lib_TypCapTable] && $Lib_TypCapTable != "" && $Lib_TypCapTable != "{}"} {
  set cmd "$cmd -cap_table $Lib_TypCapTable "
}
if {[info exists Lib_TypQrcTechFile] && $Lib_TypQrcTechFile != "" && $Lib_TypQrcTechFile != "{}"} {
  set cmd "$cmd -qx_tech_file $Lib_TypQrcTechFile "
}
eval $cmd


###############################################################################
#  Create delay corners
###############################################################################

create_delay_corner -name max_delay_corner -library_set max_lib_set -rc_corner max_rc_corner

create_delay_corner -name min_delay_corner -library_set min_lib_set -rc_corner min_rc_corner

create_delay_corner -name typ_delay_corner -library_set typ_lib_set -rc_corner typ_rc_corner
###############################################################################
#  Set derates for delay corners
###############################################################################

if {$VER < 20.1} {
  if {$Innovus_DerateMethod != 0} {
     set_timing_derate -delay_corner max_delay_corner -late  -data -cell_delay $DERATE_SLDC
     set_timing_derate -delay_corner max_delay_corner -late  -data -net_delay $DERATE_SLDN
     set_timing_derate -delay_corner max_delay_corner -late  -clock -cell_delay $DERATE_SLCC 
     set_timing_derate -delay_corner max_delay_corner -late  -clock -net_delay $DERATE_SLCN
     set_timing_derate -delay_corner max_delay_corner -early -data -cell_delay $DERATE_SEDC
     set_timing_derate -delay_corner max_delay_corner -early -data -net_delay $DERATE_SEDN
     set_timing_derate -delay_corner max_delay_corner -early -clock -cell_delay $DERATE_SECC
     set_timing_derate -delay_corner max_delay_corner -early -clock -net_delay $DERATE_SECN
   
     set_timing_derate -delay_corner min_delay_corner -late  -data -cell_delay $DERATE_FLDC
     set_timing_derate -delay_corner min_delay_corner -late  -data -net_delay $DERATE_FLDN
     set_timing_derate -delay_corner min_delay_corner -late  -clock -cell_delay $DERATE_FLCC 
     set_timing_derate -delay_corner min_delay_corner -late  -clock -net_delay $DERATE_FLCN
     set_timing_derate -delay_corner min_delay_corner -early -data -cell_delay $DERATE_FEDC
     set_timing_derate -delay_corner min_delay_corner -early -data -net_delay $DERATE_FEDN
     set_timing_derate -delay_corner min_delay_corner -early -clock -cell_delay $DERATE_FECC
     set_timing_derate -delay_corner min_delay_corner -early -clock -net_delay $DERATE_FECN
  }
}

###############################################################################
#  Specify all mode and corner combinations to analyse
###############################################################################

create_analysis_view -name setup_view \
   -constraint_mode setup_view_functional \
   -delay_corner max_delay_corner

create_analysis_view -name hold_view \
   -constraint_mode hold_view_functional \
   -delay_corner min_delay_corner

create_analysis_view -name typ_view \
   -constraint_mode typ_view_functional \
   -delay_corner typ_delay_corner

###############################################################################
#  Load technology data for specified analysis views
###############################################################################

set_analysis_view -setup [list setup_view] -hold [list setup_view hold_view] -leakage hold_view -dynamic typ_view

###############################################################################
#  Set the analysis view for Innovus commands 
###############################################################################

set_default_view -setup setup_view -hold hold_view

