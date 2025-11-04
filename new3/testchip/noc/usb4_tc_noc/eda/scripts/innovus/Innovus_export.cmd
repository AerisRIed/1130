#############################################################################################
#        Copyright (c) 2009-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

######################################################
#                                                    #
#          Export design                             #
#                                                    #
######################################################

saveNetlist [format "%s%s" $FILE_NAME_PREFIX "_routed.v"]

set dbgDefOutLefVias 1
set dbgLefDefOutVersion 5.8
defOut -floorplan -ioRow -bumpAsPin -netlist -routing [format "%s%s" $FILE_NAME_PREFIX "_routed.def"]


if {[getAnalysisMode -quiet -aocv]} {
  set timing_format {instance arc slew load cell user_derate aocv_derate stage_count delay incr_delay arrival fanout}
} elseif {[getAnalysisMode -quiet -socv]} {
  set timing_format {instance arc slew load cell user_derate delay_mean delay_sigma delay incr_delay arrival fanout}
} else {
  set timing_format {instance arc slew load cell user_derate delay incr_delay arrival fanout}
}

set_global timing_report_group_based_mode true
report_timing -path_type full_clock -max_paths $Innovus_NumPaths -format $timing_format > [format "%s%s" $FILE_NAME_PREFIX "_routed.timing"]

if {[getAnalysisMode -quiet -aocv]} {
  report_timing -path_type full_clock -max_paths 50 -retime aocv_path_slew_propagation -format $timing_format > [format "%s%s" $FILE_NAME_PREFIX "_routed.recalc_timing"]
} elseif {[getAnalysisMode -quiet -socv]} {
  report_timing -path_type full_clock -max_paths 50 -retime path_slew_propagation -format $timing_format > [format "%s%s" $FILE_NAME_PREFIX "_routed.recalc_timing"]
} else {
  report_timing -path_type full_clock -max_paths 50 -retime path_slew_propagation -format $timing_format > [format "%s%s" $FILE_NAME_PREFIX "_routed.recalc_timing"]
}

#rcOut -setload [format "%s%s" $FILE_NAME_PREFIX "_routed.setload"]

if {$Innovus_WriteSPEF == 1} {
  if {($Lib_MaxCapTable != $Lib_MinCapTable) && ($Lib_MaxCapTable != "{}") && ($Lib_MinCapTable != "{}")} {
    rcOut -spef [format "%s%s" $FILE_NAME_PREFIX "_routed.spef.max"] -rc_corner max_rc_corner
    rcOut -spef [format "%s%s" $FILE_NAME_PREFIX "_routed.spef.min"] -rc_corner min_rc_corner
  } else {
    rcOut -spef [format "%s%s" $FILE_NAME_PREFIX "_routed.spef"]
  }
}
if {$Innovus_WriteSDF == 1} {
  write_sdf -recompute_parallel_arcs -nonegchecks -filter -collapse_internal_pins  [format "%s%s" $FILE_NAME_PREFIX "_routed.sdf"]
}
report_power -leakage -outfile [format "%s%s" $FILE_NAME_PREFIX "_routed.leak.power"]
report_power -outfile [format "%s%s" $FILE_NAME_PREFIX "_routed.dyn.power"]
TIP_user_report_area_ref [format "%s%s" $FILE_NAME_PREFIX "_routed"]
report_area > [format "%s%s" $FILE_NAME_PREFIX "_routed.detail.area"]
reportTranViolation -all -outfile [format "%s%s" $FILE_NAME_PREFIX "_routed.tran.viol"] 
reportCapViolation -all -outfile [format "%s%s" $FILE_NAME_PREFIX "_routed.cap.viol"] 

setAnalysisMode -checkType hold

report_timing -path_type full_clock -max_paths $Innovus_NumPaths -format $timing_format > [format "%s%s" $FILE_NAME_PREFIX "_routed.min.timing"]

redirect [format "%s%s" $FILE_NAME_PREFIX "_routed.drc"] {verify_drc -check_only regular} 
setMultiCpuUsage -localCpu 1
redirect [format "%s%s" $FILE_NAME_PREFIX "_routed.connect"] {verifyConnectivity -type all -error 1000 -warning 50}
setMultiCpuUsage -localCpu $SUPERTHREAD_COUNT

