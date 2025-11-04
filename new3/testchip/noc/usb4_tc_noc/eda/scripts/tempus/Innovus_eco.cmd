#############################################################################################
#        Copyright (c) 2014-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

source Tempus_define.tcl
source ../scripts/tempus/Tempus_utils.tcl
source ../scripts/innovus/Innovus_util.cmd 
source ../scripts/innovus/Innovus_DFM_flow.cmd

setMultiCpuUsage -localCpu $SUPERTHREAD_COUNT

if {$TEMPUS_TSO_OPT_PASS2 > 0} {
  set TEMPUS_TSO_OPT $TEMPUS_TSO_OPT_PASS2
}

TIP_get_file_name_prefix

set_message -id ENCLF-223 -severity warn
set VER [lindex [split [getVersion] {-}] 0]

if {$VER >= 15} {
  set_message -id IMPLF-223 -severity warn
}
if {($VER >= 17.1) && ($VER <= 21.12)} {
  set_message -id TECHLIB-1318 -severity warn
}
if {$VER >= 22} {
  set_message -id IMPIMEX-4022 -severity warn
}

set restore_db_file_check false

exec mv final.enc final_preeco.enc
exec sed -i s/final/final_preeco/g final_preeco.enc
exec mv final.enc.dat final_preeco.enc.dat

source final_preeco.enc -verbose

if {$USE_POWER_LIBRARY == 1} {
  read_parasitics -rc_corner max_rc_corner [format "%s%s" $FILE_NAME_PREFIX "_extract_max.spef"] -rc_corner min_rc_corner [format "%s%s" $FILE_NAME_PREFIX "_extract_min.spef"] -rc_corner typ_rc_corner  [format "%s%s" $FILE_NAME_PREFIX "_extract_typ.spef"]
} else {
  read_parasitics -rc_corner max_rc_corner [format "%s%s" $FILE_NAME_PREFIX "_extract_max.spef"] -rc_corner min_rc_corner [format "%s%s" $FILE_NAME_PREFIX "_extract_min.spef"]
}

if {$TEMPUS_TSO_OPT == 1 } {
  if {[file exists  LEAK_eco_innovus.tcl]} {
    source LEAK_eco_innovus.tcl
  } else {
    Puts [format "%s%s" "**ERR" "OR : LEAK_eco_innovus.tcl file not found"]
    exit
  }  
}

if {$TEMPUS_TSO_OPT == 2 } {
  if {[file exists  SETUP_eco_innovus.tcl]} {
    source SETUP_eco_innovus.tcl
  } else {
    Puts [format "%s%s" "**ERR" "OR : SETUP_eco_innovus.tcl file not found"]
    exit
  }  
}
if {$TEMPUS_TSO_OPT == 3 } {
  if {[file exists  HOLD_eco_innovus.tcl]} {
    source HOLD_eco_innovus.tcl
  } else {
    Puts [format "%s%s" "**ERR" "OR : HOLD_eco_innovus.tcl file not found"]
    exit
  }  
}

if {$TEMPUS_TSO_OPT == 4 } {
  if {[file exists  AREA_eco_innovus.tcl]} {
    source AREA_eco_innovus.tcl
  } else {
    Puts [format "%s%s" "**ERR" "OR : AREA_eco_innovus.tcl file not found"]
    exit
  }  
}

if {$TEMPUS_TSO_OPT == 5 } {
  if {[file exists  HOLD_eco_innovus.tcl]} {
    source HOLD_eco_innovus.tcl
  } else {
    Puts [format "%s%s" "**ERR" "OR : HOLD_eco_innovus.tcl file not found"]
    exit
  }
  if {[file exists  SETUP_eco_innovus.tcl]} {
    source SETUP_eco_innovus.tcl
  } else {
    Puts [format "%s%s" "**ERR" "OR : SETUP_eco_innovus.tcl file not found"]
    exit
  }
}

ecoRoute
saveNetlist [format "%s%s" $FILE_NAME_PREFIX "_routed_eco.v"]
defOut -floorplan -ioRow -bumpAsPin -netlist -routing [format "%s%s" $FILE_NAME_PREFIX "_routed_eco.def"]
TIP_user_report_area_ref [format "%s%s" $FILE_NAME_PREFIX "_routed_eco"]
report_area > [format "%s%s" $FILE_NAME_PREFIX "_routed_eco.detail.area"]
extractRC
redirect [format "%s%s" $FILE_NAME_PREFIX "_routed.drc"] {verify_drc -check_only regular}

saveDesign final.enc

exit
