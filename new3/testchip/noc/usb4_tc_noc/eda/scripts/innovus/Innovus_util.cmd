#############################################################################################
#        Copyright (c) 2009-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

#########################################################################################
#Procedures to Check Derate Method 
#########################################################################################
proc TIP_check_derate_method {} {
  source Innovus_define.cmd
  set SIGMA_COUNT 0
  if {$Innovus_DerateMethod == 0} {

    Puts [format "%s%s" "Warn" "ing : No Derating is used for timing analysis"]
    if {($DERATE_SLDC != 1) || ($DERATE_SLDN != 1) || ($DERATE_SLCC != 1) || ($DERATE_SLCN != 1) || ($DERATE_SEDC != 1) || ($DERATE_SEDN != 1) || ($DERATE_SECC != 1) || ($DERATE_SECN != 1) || ($DERATE_FLDC != 1) || ($DERATE_FLDN != 1) || ($DERATE_FLCC != 1) || ($DERATE_FLCN != 1) || ($DERATE_FEDC != 1) || ($DERATE_FEDN != 1) || ($DERATE_FECC != 1) || ($DERATE_FECN != 1)} {
      Puts [format "%s%s" "Warn" "ing : Some of the Target_derate* variables are non-unity value and Innovus_DerateMethod is set to 0. "]
      Puts [format "%s%s" "Warn" "ing : Values of the Target_derate* variables will be ignored for Timing Analysis."]
    }
    if {[info exists MAX_SBOCV] && ($MAX_SBOCV ne "{}")} {
      Puts [format "%s%s" "Warn" "ing : MAX_SBOCV is defined in CadSetup.file.Since Innovus_DerateMethod is set to 0, MAX_SBOCV will be ignored."]
    }
    if {[info exists MIN_SBOCV] && ($MIN_SBOCV ne "{}")} { 
      Puts [format "%s%s" "Warn" "ing : MIN_SBOCV is defined in CadSetup.file.Since Innovus_DerateMethod is set to 0, MIN_SBOCV will be ignored."]
    }

  } elseif {$Innovus_DerateMethod == 1} {

    Puts [format "%s%s" "In" "fo : OCV Derating is used for timing analysis"]
    if {($DERATE_SLDC == 1) && ($DERATE_SLDN == 1) && ($DERATE_SLCC == 1) && ($DERATE_SLCN == 1) && ($DERATE_SEDC == 1) && ($DERATE_SEDN == 1) && ($DERATE_SECC == 1) && ($DERATE_SECN == 1) && ($DERATE_FLDC == 1) && ($DERATE_FLDN == 1) && ($DERATE_FLCC == 1) && ($DERATE_FLCN == 1) && ($DERATE_FEDC == 1) && ($DERATE_FEDN == 1) && ($DERATE_FECC == 1) && ($DERATE_FECN == 1)} {
      Puts [format "%s%s" "ERR" "OR : OCV Derating is selected in CadSetup.file but all Target_derate* variables are set to unity value"]
      exit
    }
    if {[info exists MAX_SBOCV] && ($MAX_SBOCV ne "{}")} {
      Puts [format "%s%s" "Warn" "ing : MAX_SBOCV is defined in CadSetup.file.Since Innovus_DerateMethod is set to 1, MAX_SBOCV will be ignored."]
    }
    if {[info exists MIN_SBOCV] && ($MIN_SBOCV ne "{}")} { 
      Puts [format "%s%s" "Warn" "ing : MIN_SBOCV is defined in CadSetup.file.Since Innovus_DerateMethod is set to 1, MIN_SBOCV will be ignored."]
    }

  } elseif {$Innovus_DerateMethod == 2} {

    if {[info exists MAX_SBOCV] && ($MAX_SBOCV eq "{}")} {
      Puts [format "%s%s" "ERR" "OR :    MAX_SBOCV must be defined in CadSetup.file for AOCV flow."]
      exit
    }
    if {[info exists MIN_SBOCV] && ($MIN_SBOCV eq "{}")} { 
      Puts [format "%s%s" "ERR" "OR :    MIN_SBOCV must be defined in CadSetup.file for AOCV flow."]
      exit
    }
    Puts [format "%s%s" "In" "fo : AOCV Derating with Incremental OCV  is used for timing analysis"]

  } elseif {$Innovus_DerateMethod == 3} {

    if {[llength $Lib_CadenceLIB] != 0} {
      Puts [format "%s%s" "Warn" "ing : The following grep command can fail if there are no sigma values in the first listed Liberty"]
      Puts [format "%s%s" "Warn" "ing : file. Make sure all Liberty files have LVF sigma data in them before setting Innovus_DerateMethod"]
      Puts [format "%s%s" "Warn" "ing : to 3 in CadSetup.file."]
      set LIB [open [lindex $Lib_CadenceLIB 0]]
      while {[gets $LIB line] >= 0} {
        if {[regexp {ocv_sigma_cell_rise} $line]} {
	  set SIGMA_COUNT 1
	  break
	}
      }
      close $LIB
      if {$SIGMA_COUNT > 0} {
        Puts [format "%s%s" "In" "fo : SOCV sigma values are present in the first input Liberty file"]
        Puts [format "%s%s" "In" "fo : SOCV Derating with Incremental OCV  is used for timing analysis"]
      } else {
        Puts [format "%s%s"   "ERR" "OR : SOCV derating was requested via Innovus_DerateMethod in CadSetup.file, but no LVF data"]
        Puts [format "%s%s%s" "ERR" "OR : is present in the first file in the Lib_CadenceLIB variable: " [lindex $Lib_CadenceLIB 0]]
        exit
      }
    }
    set SIGMA_COUNT 0
    if {[llength $Lib_CadenceMinLIB] != 0} {
      Puts [format "%s%s" "Warn" "ing : The following grep command can fail if there are no sigma values in the first listed Liberty"]
      Puts [format "%s%s" "Warn" "ing : file. Make sure all Liberty files have LVF sigma data in them before setting Innovus_DerateMethod"]
      Puts [format "%s%s" "Warn" "ing : to 3 in CadSetup.file."]
      set LIB [open [lindex $Lib_CadenceMinLIB 0]]
      while {[gets $LIB line] >= 0} {
        if {[regexp {ocv_sigma_cell_rise} $line]} {
	  set SIGMA_COUNT 1
	  break
	}
      }
      close $LIB
      if {$SIGMA_COUNT > 0} {
        Puts [format "%s%s" "In" "fo : SOCV sigma values are present in the first input Liberty file"]
        Puts [format "%s%s" "In" "fo : SOCV Derating with Incremental OCV  is used for timing analysis"]
      } else {
        Puts [format "%s%s"   "ERR" "OR : SOCV derating was requested via Innovus_DerateMethod in CadSetup.file, but no LVF data"]
        Puts [format "%s%s%s" "ERR" "OR : is present in the first file in the Lib_CadenceMinLIB variable: " [lindex $Lib_CadenceMinLIB 0]]
        exit
      }
    }

  } else {
      Puts [concat "ERR" "OR : Valid Values of Innovus_DerateMethod are 0,1,2 or 3.Refer  CadSetup.file for usage."]
      exit
  }
}
#########################################################################################
#Procedures to generate intermediate qor summary
#########################################################################################
proc TIP_get_file_name_prefix {} {
  source Innovus_define.cmd
  global FILE_NAME_PREFIX
  if {[file exists Block_netlist.v]} {
    set FILE_NAME_PREFIX Block
  } else {
    set FILE_NAME_PREFIX $TOP_DESIGN
  }
}

proc TIP_get_drc_count {} {
  redirect -variable drc_str {verify_drc -limit 10000 -check_only regular}
  regexp {Complete\s*:\s*(\d+)\s*Viols} $drc_str dummy drc_count
  return $drc_count
}

proc TIP_get_congestion_new {column_width} {
  source Innovus_define.cmd
  redirect -variable str {reportCongestion -overflow}
  set VER [lindex [split [getVersion] {-}] 0]
  if {($VER >= 20.1) && ( $LIB_PROCESS_NODE <=  5)} {
    regexp -all {Overflow (\S+)% H \+ (\S+)% V} $str dummy h_overall v_overall
  } else {
    regexp -all {Overflow.*\((\S+)% H.*\((\S+)% V} $str dummy h_overall v_overall
  }

  if {![info exists h_overall]} {set h_overall NA}
  if {![info exists v_overall]} {set v_overall NA}

  set h_overall [format "(%.2f)" ${h_overall}]
  set v_overall [format "(%.2f)" ${v_overall}]
  set format_string "%-${column_width}s"
  set congestion "[format $format_string "${h_overall}"]"
  set congestion "${congestion}[format $format_string "${v_overall}"]"
  return $congestion
}

proc TIP_get_congestion {column_width} {
  redirect -variable str {trialRoute}
  regexp -all {Overflow:\s*([\d.]*)%\s*H\s*\+\s*([\d.]*)% V} $str dummy h_overall v_overall
  if {![info exists h_overall]} {set h_overall NA}
  if {![info exists v_overall]} {set v_overall NA}
  regexp {Remain\s*cntH\s*cntV.*-+\n(.+)\n-+\n(.*?\n.*?\n).*} $str dummy m1 m2
  set congest ""
  if {[info exists m1]} {
    set congest "${m1}\n"
  }
  if {[info exists m2]} {
    set congest "${congest}${m2}"
  }
  set h_overflow 0
  set v_overflow 0
  while {[regexp {\s*(\S+):\s*(\d+)\s*\S*?%\s*(\d+)\s*\S*?%\n(.*)} $congest dummy \
          overflow h_gcells v_gcells congest ]==1} {
    set h_overflow [expr $h_overflow + ((2 - $overflow)*$h_gcells)]
    set v_overflow [expr $v_overflow + ((2 - $overflow)*$v_gcells)]
  }
  if {$h_overflow > 99999} {set h_overflow "99999+"}
  set h_overall [format "(%.2f)" ${h_overall}]
  if {$v_overflow > 99999} {set v_overflow "99999+"}
  set v_overall [format "(%.2f)" ${v_overall}]
  set format_string "%-${column_width}s"
  set congestion "[format $format_string "${h_overflow}${h_overall}"]"
  set congestion "${congestion}[format $format_string "${v_overflow}${v_overall}"]"
  return $congestion
}

proc TIP_format_data {table_captions column_width} {
  set max_caption_len 0
  foreach caption $table_captions {
    set str_len [string length $caption]
    if {$str_len > $max_caption_len} {set max_caption_len $str_len}
  }
  set caption_rows [expr int(ceil($max_caption_len / double($column_width)))]
  set retval ""
  for {set i 0} {$i<$caption_rows} {incr i} {
    set str ""
    for {set j 0} {$j<[llength $table_captions]} {incr j} {
      set range_l [expr $i * $column_width]
      set range_h [expr (($i + 1) * $column_width)-1]
      set format_str "%-${column_width}s"
      set text [format $format_str [string range [lindex $table_captions $j] $range_l $range_h]]
      set str "$str|$text"
    }
    set str "$str|"
    if {$retval==""} {
      set retval $str
    } else {
      set retval "${retval}\n${str}"
    }
  }
  return $retval
}

proc TIP_create_header {prefix column_width} {
  if {[catch {open ${prefix}.summary "a+"} aFilePtr] != 0} {
    Puts [format "%s%s" "**ERR" "OR: failed to open file ${prefix}.summary for writing header"]
    exit
  }
  set path_groups [get_path_groups -quiet *]
  set table_captions [list "Flow Point"]
     set table_units [list ""]

  foreach_in_collection path_group [sort_collection [get_path_groups *] full_name] {
    lappend table_captions "[get_property $path_group name]"
    lappend table_units "(MHz)        +uncertainty"
  }
  lappend table_captions "Core Area" "Cell Area" "Cell Density" "Congestion" "DRC Count" "Runtime"
  lappend table_units "(mm2)" "(mm2)" "%" "H(%)         V(%)" "#" "minutes"
  set total_str_length [expr ([llength $table_captions]*($column_width+1))+1]

  puts $aFilePtr [string repeat "-" $total_str_length]
  set retval [TIP_format_data $table_captions $column_width]
  puts $aFilePtr $retval
  set retval [TIP_format_data $table_units $column_width]
  puts $aFilePtr $retval
  puts $aFilePtr [string repeat "-" $total_str_length]
  close $aFilePtr
}

proc TIP_create_header_nouncer {prefix column_width} {
  if {[catch {open ${prefix}.summary_nouncer "a+"} aFilePtr_nouncer] != 0} {
    Puts [format "%s%s" "**ERR" "OR: failed to open file ${prefix}.summary_nouncer for writing header"]
    exit
  }
  set path_groups [get_path_groups -quiet *]
  set table_captions [list "Flow Point"]
     set table_units [list ""]

  foreach_in_collection path_group [sort_collection [get_path_groups *] full_name] {
    lappend table_captions "[get_property $path_group name]"
    lappend table_units "(MHz)        "
  }
  lappend table_captions "Uncertainty" "Core Area" "Cell Area" "Cell Density" "Congestion" "DRC Count" "Runtime"
  lappend table_units "(ns)" "(mm2)" "(mm2)" "%" "H(%)         V(%)" "#" "minutes"
  set total_str_length [expr ([llength $table_captions]*($column_width+1))+1]

  puts $aFilePtr_nouncer [string repeat "-" $total_str_length]
  set retval_nouncer [TIP_format_data $table_captions $column_width]
  puts $aFilePtr_nouncer $retval_nouncer
  set retval_nouncer [TIP_format_data $table_units $column_width]
  puts $aFilePtr_nouncer $retval_nouncer
  puts $aFilePtr_nouncer [string repeat "-" $total_str_length]
  close $aFilePtr_nouncer
}

proc TIP_add_summary_point {clear_summary prefix flow_point prev_mins} {
  global env
  source Innovus_define.cmd
  set path_groups [get_path_groups -quiet *]
  set path_groups_exist 1
  if {[sizeof_collection $path_groups]==0} {
    set path_groups_exist 0
    TIP_create_path_groups
    set path_groups [get_path_groups -quiet *]
  }
  set column_width 13
  if {$clear_summary==1} { TIP_create_header $prefix $column_width }
  if {$clear_summary==1} { TIP_create_header_nouncer $prefix $column_width }

  if {[getAnalysisMode -quiet -aocv]} {
    set timing_format {instance arc slew load cell user_derate aocv_derate stage_count delay incr_delay arrival fanout}
  } elseif {[getAnalysisMode -quiet -socv]} {
    set timing_format {instance arc slew load cell user_derate delay_mean delay_sigma delay incr_delay arrival fanout}
  } else {
    set timing_format {instance arc slew load cell user_derate delay incr_delay arrival fanout}
  } 
  set_global timing_report_group_based_mode true 
  report_timing -path_type full_clock -max_paths $Innovus_NumPaths -format $timing_format > ${flow_point}.timing

  ##############################
  #collect data to output
  ##############################
  set data_list [list $flow_point]
  set data_list_nouncer [list $flow_point]
  foreach_in_collection path_gr [sort_collection [get_path_groups *] full_name] {
    set tpath [report_timing -collection -max_paths 1 -path_group [get_property $path_gr name]]
    set tpath_uncertainty [get_property -quiet $tpath clock_uncertainty]
    set capture_clock [get_property -quiet $tpath capturing_clock]
    set capture_edge [get_property -quiet $tpath capturing_clock_open_edge_type]
    set launch_clock [get_property -quiet $tpath launching_clock]
    set launch_edge [get_property -quiet $tpath launching_clock_open_edge_type]

    set slack [get_property $tpath slack]
    if {[sizeof_collection $capture_clock] > 0} {
      set period [get_property -quiet $capture_clock period]
    } else {
      set period [get_property -quiet $launch_clock period]
    }
    if {$period==""} {
      lappend data_list "NA/NA"
      lappend data_list_nouncer "NA/NA"
      continue
    }
    if {$capture_edge != $launch_edge} {
      set suffix "H"
    } else {
      set suffix ""
    }
    set status_nouncer [catch {set ach_freq_nouncer [expr int(1/(($period - $slack - $tpath_uncertainty)*1e-3))]}]
    set status [catch {set ach_freq [expr int(1/(($period - $slack)*1e-3))]}]
    if {$status != 0} {
      lappend data_list "NA/NA"
      continue
    }
    if {$status_nouncer != 0} {
      lappend data_list_nouncer "NA/NA"
      continue
    }
    set status [catch {set target_freq [expr int(1/(($period)*1e-3))]}]
    set status_nouncer [catch {set target_freq [expr int(1/(($period)*1e-3))]}]
    if {$status != 0} {
      lappend data_list "NA/NA"
      continue
    }
    if {$status_nouncer != 0} {
      lappend data_list_nouncer "NA/NA"
      continue
    }
    if {$ach_freq < $target_freq} {
      set suffix "!$suffix"
    }
    lappend data_list "$ach_freq/$target_freq $suffix"
    lappend data_list_nouncer "$ach_freq_nouncer/$target_freq $suffix"
  }
  lappend data_list_nouncer "$tpath_uncertainty"

  set fpBox [dbHeadFPlan]
  set coreBox [dbFPlanCoreBox $fpBox]
  set coreX [dbBoxDimX $coreBox]
  set coreY [dbBoxDimY $coreBox]
  set coreMicronX [dbDBUToMicrons $coreX]
  set coreMicronY [dbDBUToMicrons $coreY]
  set core_area [expr $coreMicronX * $coreMicronY]

  set isRectilinear 0
  set nrCuts 0
  dbForEachFPlanPtnCut [dbHeadFPlan] ptnCut {
    set isRectilinear 1
    incr nrCuts
    set ptnCutBox [dbPtnCutBox $ptnCut]
    set ptnCutX [dbBoxDimX $ptnCutBox]
    set ptnCutY [dbBoxDimY $ptnCutBox]
    set micronsPtnCutX [dbDBUToMicrons $ptnCutX]
    set micronsPtnCutY [dbDBUToMicrons $ptnCutY]
    set micronsPtnCutArea [expr $micronsPtnCutX * $micronsPtnCutY]
    set core_area [expr $core_area - $micronsPtnCutArea]
  }

  set density [dbFPlanRegRowDensity [dbGet top.fplan]]
  set area [expr $density * $core_area]
  set density [format "%.2f%%" [expr $density * 100]]

  if {([expr ($area / $core_area)*100] > 80.0) && ([regexp {DFM} $flow_point] != 1)} {
    Puts [format "%s%s" "**ERR" "OR: High core utilization post $flow_point"]
  }

  lappend data_list [format "%0.3f" [expr $core_area / 1000000.0]]
  lappend data_list [format "%0.3f" [expr $area / 1000000.0]]
  lappend data_list $density

  lappend data_list_nouncer [format "%0.3f" [expr $core_area / 1000000.0]]
  lappend data_list_nouncer [format "%0.3f" [expr $area / 1000000.0]]
  lappend data_list_nouncer $density

  redirect -variable str {checkPlace}
  regexp {Unplaced\s*=\s*(\d+)} $str dummy unplaced

  set drc_count 0
  if {[info exists unplaced] && ($unplaced > 0)} {
    lappend data_list "NA"
    lappend data_list "NA"
    lappend data_list_nouncer "NA"
    lappend data_list_nouncer "NA"
  } elseif {[regexp {Route|HvtOpt|LvtOpt|signoffOpt} $flow_point]==1} {
    lappend data_list "NA"
    lappend data_list_nouncer "NA"
    set drc_count [TIP_get_drc_count]
    lappend data_list $drc_count
    lappend data_list_nouncer $drc_count
    if {$drc_count > 1000} {
      if {[regexp {postRouteTop} $flow_point] != 1} {
        Puts [format "%s%s" "**ERR" "OR: High DRC count post $flow_point"]
      }
    }
  } else {
    lappend data_list [TIP_get_congestion_new $column_width]
    lappend data_list "NA"
    lappend data_list_nouncer [TIP_get_congestion_new $column_width]
    lappend data_list_nouncer "NA"
  }

  redirect -variable timing_str {timeDesign -reportOnly}
  if {[regexp {TNS \(ns\):\|(.*?)\n.*} $timing_str dummy match]==1} {
    foreach tns_str [split $match "|"] {
      if {[catch {set tns [expr $tns_str]}]==0} {
        if {$tns > 1000.0} {
           Puts [format "%s%s%s%s" "**ERR" "OR: Very high TNS (" $tns "ns) post '$flow_point'"]
        } elseif {$tns > 500.0} {
           Puts [format "%s%s%s%s" "**WAR" "N: High TNS (" $tns "ns) post '$flow_point'"]
        }
      }
    }
  }

  set mins [expr [clock clicks -milliseconds] / 60000]
  set elapsed_mins [expr $mins - $prev_mins]
  lappend data_list $elapsed_mins
  lappend data_list_nouncer $elapsed_mins

  ##############################
  #output data to summary file
  ##############################
  if {[catch {open ${prefix}.summary "a+"} aFilePtr] != 0} {
    Puts [format "%s%s" "**ERR" "OR: failed to open file ${prefix}.summary for writing data"]
    exit
  }
  if {[catch {open ${prefix}.summary_nouncer "a+"} aFilePtr_nouncer] != 0} {
    Puts [format "%s%s" "**ERR" "OR: failed to open file ${prefix}.summary_nouncer for writing data"]
    exit
  }
  set retval [TIP_format_data $data_list $column_width]
  set retval_nouncer [TIP_format_data $data_list_nouncer $column_width]
  puts $aFilePtr $retval
  puts $aFilePtr_nouncer $retval_nouncer
  close $aFilePtr
  close $aFilePtr_nouncer

  ##############################
  #cleanup
  ##############################  
  if {$path_groups_exist==0} {
    reset_path_group -all
  }
  return [list $mins $drc_count]
}


#Procedure to place IO pins according to recommended guidelines
proc TIP_place_io_pins {} {
  source Innovus_define.cmd
  set fpx0 [lindex [dbHeadIoBox] 0]
  set fpy0 [lindex [dbHeadIoBox] 1]
  set fpx1 [lindex [dbHeadIoBox] 2]
  set fpy1 [lindex [dbHeadIoBox] 3]
  
  set fp_width  [expr ($fpx1 - $fpx0) * [dbHeadMicronPerDBU]]
  set fp_height  [expr ($fpy1 - $fpy0) * [dbHeadMicronPerDBU]]

  set xports [get_ports -quiet *]

  set iports [get_ports -quiet {IRam* ICache* ITag* IRom* URam*}]
  if {[sizeof_collection $iports] > 0} {
    #set iports [sort_collection $iports full_name]
    set xports [remove_from_collection $xports $iports]
  }

  set dports [get_ports -quiet {DRam* DCache* DTag* DRom* DPort* PrefetchRam* TraceMem*}]
  if {[sizeof_collection $dports] > 0} {
    set dports [sort_collection $dports full_name]
    set xports [remove_from_collection $xports $dports]
  }

  if {[sizeof_collection $xports] > 0} {
    #set xports [sort_collection $xports full_name]
  }
  
  if {[catch {open innovus.io "w"} aFilePtr] != 0} {
    Puts [format "%s%s" "**ERR" "OR: failed to open file innovus.io" "]
    exit
  }  
  puts $aFilePtr "#IO locations generated by place_innovus_ios.tcl"
  puts $aFilePtr "(globals"
  puts $aFilePtr "    version = 3"
  puts $aFilePtr "    io_order = default"
  puts $aFilePtr ")"
  puts $aFilePtr "(iopin"

  set pin_layer_left_right_minWidth [dbGet [dbGet -p head.layers.name $Fplan_LeftRightPinLayer].minWidth]
  set pin_layer_left_right_minArea  [dbGet [dbGet -p head.layers.name $Fplan_LeftRightPinLayer].area]
  if {($pin_layer_left_right_minWidth > 0.1) || ($LIB_PROCESS_NODE <= 16)} {
    set pin_layer_left_right_width $pin_layer_left_right_minWidth
  } else {
    set pin_layer_left_right_width 0.1
  }
  set pin_layer_left_right_depth [format "%.1f" [expr $pin_layer_left_right_minArea/$pin_layer_left_right_width]]
  if {$pin_layer_left_right_depth < $pin_layer_left_right_minWidth} {
    set pin_layer_left_right_depth $pin_layer_left_right_minWidth
  }
  set pin_layer_left_right_minSpacing [dbGet [dbGet -p head.layers.name $Fplan_LeftRightPinLayer].minSpacing]
  if {([expr $pin_layer_left_right_minSpacing + $pin_layer_left_right_width] > 0.3) || ($LIB_PROCESS_NODE <= 16)} {
    set pin_layer_left_right_spacing [expr $pin_layer_left_right_minSpacing + $pin_layer_left_right_width]
  } else {
    set pin_layer_left_right_spacing 0.3
  }

  set pin_layer_top_bottom_minWidth [dbGet [dbGet -p head.layers.name $Fplan_TopBottomPinLayer].minWidth]
  set pin_layer_top_bottom_minArea  [dbGet [dbGet -p head.layers.name $Fplan_TopBottomPinLayer].area]
  if {$pin_layer_top_bottom_minWidth > 0.1} {
    set pin_layer_top_bottom_width $pin_layer_top_bottom_minWidth
  } else {
    set pin_layer_top_bottom_width 0.1
    if {$LIB_PROCESS_NODE <= 16} {
      set pin_layer_top_bottom_width $pin_layer_top_bottom_minWidth
    }
  }
  set pin_layer_top_bottom_depth [format "%.1f" [expr $pin_layer_top_bottom_minArea/$pin_layer_top_bottom_width]]
  if {$pin_layer_top_bottom_depth < $pin_layer_top_bottom_minWidth} {
    set pin_layer_top_bottom_depth $pin_layer_top_bottom_minWidth
  }
  set pin_layer_top_bottom_minSpacing [dbGet [dbGet -p head.layers.name $Fplan_TopBottomPinLayer].minSpacing]
  if {[expr $pin_layer_top_bottom_minSpacing + $pin_layer_top_bottom_width] > 0.3} {
    set pin_layer_top_bottom_spacing [expr $pin_layer_top_bottom_minSpacing + $pin_layer_top_bottom_width]
  } else {
    set pin_layer_top_bottom_spacing 0.3
    if {$LIB_PROCESS_NODE <= 16} {
      set pin_layer_top_bottom_spacing [expr 2 * ($pin_layer_top_bottom_minSpacing + $pin_layer_top_bottom_width)]
    }
  }

  if {[regexp {(\d+)} $Fplan_LeftRightPinLayer dummy pin_layer_left_right]} {
  } else {
    set pin_layer_left_right 3
  }
  if {[regexp {(\d+)} $Fplan_TopBottomPinLayer dummy pin_layer_top_bottom]} {
  } else {
    set pin_layer_top_bottom 4
  }

  if {$LIB_PROCESS_NODE <= 7} {
    set pin_layer_left_right [expr $pin_layer_left_right + 1]
    set pin_layer_top_bottom [expr $pin_layer_top_bottom + 1]
  }

if {[sizeof_collection $iports] > 0} {
    puts $aFilePtr "    (left"
    set curr_offset [expr ceil($fp_height - ([sizeof_collection $iports]*$pin_layer_left_right_spacing)) - 20]
    set two_layer_offset [expr ceil($fp_height - ([sizeof_collection $iports]*$pin_layer_left_right_spacing * 0.5)) - 20]
    set layer $pin_layer_left_right
    set layer_2 [expr $pin_layer_left_right - 2]
    if {($layer <= 0) || ($layer_2 <= 0)} {
      Puts [format "%s%s" "**ERR" "OR: CadSetup.file varibles Fplan_*PinLayer should be greater than 2."]
      exit
      }
    set place_on_two_layer 0

    if {$two_layer_offset <= 0} {
      set extra_length_needed     [format "%.1f" [expr -1.0 * $two_layer_offset]]
      set extra_length_needed_pct [format "%.1f" [expr ($extra_length_needed / $fp_height)*100.0]]
      set recommended_length      [format "%.1f" [expr $fp_height + $extra_length_needed]]
      set aspect_ratio            [format "%.1f" [expr ($fp_height / $fp_width)]]
      Puts [format "%s%s" "**ERR" "OR: Could not place I* pins on metal layer $layer and $layer_2. Your floorplan height is not sufficient to accommodate all I* pins."]
      Puts [format "%s%s" "**INFO: "  "Current floorplan height: $fp_height"]
      Puts [format "%s%s" "**INFO: "  "Minimum floorplan height needed: $recommended_length"]
      Puts [format "%s%s" "**INFO: "  "Height delta: $extra_length_needed (${extra_length_needed_pct}%)"]
      Puts [format "%s%s" "**INFO: "  "Current floorplan width:  $fp_width"]
      Puts [format "%s%s" "**INFO: "  "Current aspect ratio: $aspect_ratio"]
      exit
    }

    if {$curr_offset <= 0} {
      set place_on_two_layer 1
      Puts [format "%s%s" "**WARN: "  "Could not place I* pins on metal layer $layer. Your floorplan height is not sufficient to accommodate all I* pins on one metal layer."]
      Puts [format "%s%s" "**INFO: "  "I* pins will be placed at both metal layer $layer and $layer_2."]
      set curr_offset [expr ceil($fp_height - ([sizeof_collection $iports]*$pin_layer_left_right_spacing * 0.5)) - 20]
    }

    for {set i 0} {$i < [sizeof_collection $iports]} {incr i} {
      set port [get_property [index_collection $iports $i] full_name]

      if {$place_on_two_layer == 0} {
           puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
           set curr_offset [expr $curr_offset + $pin_layer_left_right_spacing] 
      } else {
           if {$i % 2 == 0} {
           puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
           }
           if {$i % 2 == 1} {
           puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
           }
           set curr_offset [expr $curr_offset + $pin_layer_left_right_spacing / 2]
      }
    }
    puts $aFilePtr "    )"
  }

if {[sizeof_collection $dports] > 0} {
    puts $aFilePtr "    (right"
    set curr_offset [expr ceil($fp_height - ([sizeof_collection $dports]*$pin_layer_left_right_spacing)) - 20]
    set two_layer_offset [expr ceil($fp_height - ([sizeof_collection $dports]*$pin_layer_left_right_spacing * 0.5)) - 20]
    set layer $pin_layer_left_right
    set layer_2 [expr $pin_layer_left_right - 2]
    if {($layer <= 0) || ($layer_2 <= 0)} {
      Puts [format "%s%s" "**ERR" "OR: CadSetup.file varibles Fplan_*PinLayer should be greater than 2."]
      exit
      }
    set place_on_two_layer 0

    if {$two_layer_offset <= 0} {
      set extra_length_needed     [format "%.1f" [expr -1.0 * $two_layer_offset]]
      set extra_length_needed_pct [format "%.1f" [expr ($extra_length_needed / $fp_height)*100.0]]
      set recommended_length      [format "%.1f" [expr $fp_height + $extra_length_needed]]
      set aspect_ratio            [format "%.1f" [expr ($fp_height / $fp_width)]]
      Puts [format "%s%s" "**ERR" "OR: Could not place D* pins on metal layer $layer and $layer_2. Your floorplan height is not sufficient to accommodate all D* pins."]
      Puts [format "%s%s" "**INFO: "  "Current floorplan height: $fp_height"]
      Puts [format "%s%s" "**INFO: "  "Minimum floorplan height needed: $recommended_length"]
      Puts [format "%s%s" "**INFO: "  "Height delta: $extra_length_needed (${extra_length_needed_pct}%)"]
      Puts [format "%s%s" "**INFO: "  "Current floorplan width:  $fp_width"]
      Puts [format "%s%s" "**INFO: "  "Current aspect ratio: $aspect_ratio"]
      exit
    }

    if {$curr_offset <= 0} {
      set place_on_two_layer 1
      Puts [format "%s%s" "**WARN: "  "Could not place D* pins on metal layer $layer. Your floorplan height is not sufficient to accommodate all D* pins on one metal layer."]
      Puts [format "%s%s" "**INFO: "  "D* pins will be placed at both metal layer $layer and $layer_2."]
      set curr_offset [expr ceil($fp_height - ([sizeof_collection $dports]*$pin_layer_left_right_spacing * 0.5)) - 20]
    }

    for {set i 0} {$i < [sizeof_collection $dports]} {incr i} {
      set port [get_property [index_collection $dports $i] full_name]

      if {$place_on_two_layer == 0} {
           puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
           set curr_offset [expr $curr_offset + $pin_layer_left_right_spacing]
      } else {
           if {$i % 2 == 0} {
           puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
           }
           if {$i % 2 == 1} {
           puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
           }
           set curr_offset [expr $curr_offset + $pin_layer_left_right_spacing / 2]
      }
    }
    puts $aFilePtr "    )"
  }

if {[sizeof_collection $xports] > 0} {
    puts $aFilePtr "    (top"
    set curr_offset [expr ceil(($fp_width/2.0) - (([sizeof_collection $xports]*$pin_layer_top_bottom_spacing)/2.0))]
    set two_layer_offset [expr ceil(($fp_width/2.0) - (([sizeof_collection $xports]*$pin_layer_top_bottom_spacing * 0.5)/2.0))]
    set layer $pin_layer_top_bottom
    set layer_2 [expr $pin_layer_top_bottom - 2]
    if {($layer <= 0) || ($layer_2 <= 0)} {
      Puts [format "%s%s" "**ERR" "OR: CadSetup.file varibles Fplan_*PinLayer should be greater than 2."]
      exit
    }
    set place_on_two_layer 0

    if {$two_layer_offset <= 0} {
      set extra_length_needed     [format "%.1f" [expr -1.0 * $two_layer_offset]]
      set extra_length_needed_pct [format "%.1f" [expr ($extra_length_needed / $fp_width)*100.0]]
      set recommended_length      [format "%.1f" [expr $fp_width + $extra_length_needed]]
      set aspect_ratio            [format "%.1f" [expr ($fp_height / $fp_width)]]
      Puts [format "%s%s" "**ERR" "OR: Could not place other IO pins on metal layer $layer and $layer_2. Your floorplan width is not sufficient to accommodate all other IO pins."]
      Puts [format "%s%s" "**INFO: "  "Current floorplan width: $fp_width"]
      Puts [format "%s%s" "**INFO: "  "Minimum floorplan width needed: $recommended_length"]
      Puts [format "%s%s" "**INFO: "  "Width delta: $extra_length_needed (${extra_length_needed_pct}%)"]
      Puts [format "%s%s" "**INFO: "  "Current floorplan height:  $fp_height"]
      Puts [format "%s%s" "**INFO: "  "Current aspect ratio: $aspect_ratio"]
      exit
    }

    if {$curr_offset <= 0} {
      set place_on_two_layer 1
      Puts [format "%s%s" "**WARN: "  "Could not place other IO pins on metal layer $layer. Your floorplan width is not sufficient to accommodate all other IO pins on one metal layer."]
      Puts [format "%s%s" "**INFO: "  "Other IO pins will be placed at both metal layer $layer and $layer_2."]
      set curr_offset [expr ceil(($fp_width/2.0) - (([sizeof_collection $xports]*$pin_layer_top_bottom_spacing * 0.5)/2.0))]
    }

    for {set i 0} {$i < [sizeof_collection $xports]} {incr i} {
      set port [get_property [index_collection $xports $i] full_name]

      if {$place_on_two_layer == 0} {
           puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
           set curr_offset [expr $curr_offset + $pin_layer_top_bottom_spacing]
      } else {
           if {$i % 2 == 0} {
           puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
           }
           if {$i % 2 == 1} {
           puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
           }
           set curr_offset [expr $curr_offset + $pin_layer_top_bottom_spacing / 2]
      }
    }
    puts $aFilePtr "    )"
  }

  puts $aFilePtr ")"
  close $aFilePtr
  loadIoFile innovus.io
  if {$LIB_PROCESS_NODE <= 7} {
    legalizePin -keepOrder -moveFixedPin
  } else {
    legalizePin -keepLayer -keepOrder -moveFixedPin
  }
}

proc TIP_place_io_pins_top {} {
  source Innovus_define.cmd
  set fpx0 [lindex [dbHeadIoBox] 0]
  set fpy0 [lindex [dbHeadIoBox] 1]
  set fpx1 [lindex [dbHeadIoBox] 2]
  set fpy1 [lindex [dbHeadIoBox] 3]
  
  set fp_width  [expr ($fpx1 - $fpx0) * [dbHeadMicronPerDBU]]
  set fp_height  [expr ($fpy1 - $fpy0) * [dbHeadMicronPerDBU]]

  set xports [get_ports -quiet *]

  set iports [get_ports -quiet {IRam* ICache* ITag* IRom* URam*}]
  if {[sizeof_collection $iports] > 0} {
    set iports [sort_collection $iports full_name]
    set xports [remove_from_collection $xports $iports]
    set xports [concat $iports $xports]
  }

  set dports [get_ports -quiet {DRam* DCache* DTag* DRom* DPort* PrefetchRam* TraceMem*}]
  if {[sizeof_collection $dports] > 0} {
    set dports [sort_collection $dports full_name]
    set xports [remove_from_collection $xports $dports]
    set xports [concat $xports $dports]
  }

  if {[catch {open innovus.io "w"} aFilePtr] != 0} {
    Puts [format "%s%s" "**ERR" "OR: failed to open file innovus.io" "]
    exit
  }  
  puts $aFilePtr "#IO locations generated by place_innovus_ios.tcl"
  puts $aFilePtr "(globals"
  puts $aFilePtr "    version = 3"
  puts $aFilePtr "    io_order = default"
  puts $aFilePtr ")"
  puts $aFilePtr "(iopin"

  set pin_layer_top_bottom_minWidth [dbGet [dbGet -p head.layers.name $Fplan_TopBottomPinLayer].minWidth]
  set pin_layer_top_bottom_minArea  [dbGet [dbGet -p head.layers.name $Fplan_TopBottomPinLayer].area]
  if {($pin_layer_top_bottom_minWidth > 0.1) || ($LIB_PROCESS_NODE <= 16)} {
    set pin_layer_top_bottom_width $pin_layer_top_bottom_minWidth
  } else {
    set pin_layer_top_bottom_width 0.1
  }
  set pin_layer_top_bottom_depth [format "%.1f" [expr $pin_layer_top_bottom_minArea/$pin_layer_top_bottom_width]]
  if {$pin_layer_top_bottom_depth < $pin_layer_top_bottom_minWidth} {
    set pin_layer_top_bottom_depth $pin_layer_top_bottom_minWidth
  }
  set pin_layer_top_bottom_minSpacing [dbGet [dbGet -p head.layers.name $Fplan_TopBottomPinLayer].minSpacing]
  if {([expr $pin_layer_top_bottom_minSpacing + $pin_layer_top_bottom_width] > 0.3) || ($LIB_PROCESS_NODE <= 16)} {
    set pin_layer_top_bottom_spacing [expr 2 * ($pin_layer_top_bottom_minSpacing + $pin_layer_top_bottom_width)]
  } else {
    set pin_layer_top_bottom_spacing 0.3
  }

  if {[regexp {(\d+)} $Fplan_TopBottomPinLayer dummy pin_layer_top_bottom]} {
  } else {
    set pin_layer_top_bottom 6
  }

  if {$LIB_PROCESS_NODE <= 7} {
    set pin_layer_top_bottom [expr $pin_layer_top_bottom + 1]
  }

if {[sizeof_collection $xports] > 0} {
    puts $aFilePtr "    (top"
    set curr_offset [expr ceil(($fp_width/2.0) - (([sizeof_collection $xports]*$pin_layer_top_bottom_spacing)/2.0))]
    set two_layer_offset [expr ceil(($fp_width/2.0) - (([sizeof_collection $xports]*$pin_layer_top_bottom_spacing * 0.5)/2.0))]
    set three_layer_offset [expr ceil(($fp_width/2.0) - (([sizeof_collection $xports]*$pin_layer_top_bottom_spacing * 0.33)/2.0))]
    set layer $pin_layer_top_bottom
    set layer_2 [expr $pin_layer_top_bottom - 2]
    set layer_3 [expr $pin_layer_top_bottom - 4]
    if {($layer <= 0) || ($layer_2 <= 0)} {
      Puts [format "%s%s" "**ERR" "OR: CadSetup.file varibles Fplan_*PinLayer should be greater than 2."]
      exit
    }
    set place_on_two_layer 0
    set place_on_three_layer 0

    if {$three_layer_offset <= 0} {
      set extra_length_needed     [format "%.1f" [expr -1.0 * $three_layer_offset]]
      set extra_length_needed_pct [format "%.1f" [expr ($extra_length_needed / $fp_width)*100.0]]
      set recommended_length      [format "%.1f" [expr $fp_width + $extra_length_needed]]
      set aspect_ratio            [format "%.1f" [expr ($fp_height / $fp_width)]]
      Puts [format "%s%s" "**ERR" "OR: Could not place other IO pins on metal layers $layer, $layer_2 and $layer_3. Your floorplan width is not sufficient to accommodate all other IO pins."]
      Puts [format "%s%s" "**INFO: "  "Current floorplan width: $fp_width"]
      Puts [format "%s%s" "**INFO: "  "Minimum floorplan width needed: $recommended_length"]
      Puts [format "%s%s" "**INFO: "  "Width delta: $extra_length_needed (${extra_length_needed_pct}%)"]
      Puts [format "%s%s" "**INFO: "  "Current floorplan height:  $fp_height"]
      Puts [format "%s%s" "**INFO: "  "Current aspect ratio: $aspect_ratio"]
      exit
    } elseif {$two_layer_offset <= 0} {
      set place_on_three_layer 1
      Puts [format "%s%s" "**WARN: "  "Could not place all IO pins on metal layers $layer and $layer_2. Your floorplan width is not sufficient to accommodate all IO pins on one metal layer."]
      Puts [format "%s%s" "**INFO: "  "IO pins will be placed at 3 metal layers $layer, $layer_2 and $layer_3."]
      set curr_offset $three_layer_offset
    } elseif {$curr_offset <= 0} {
      set place_on_two_layer 1
      Puts [format "%s%s" "**WARN: "  "Could not place all IO pins on metal layer $layer. Your floorplan width is not sufficient to accommodate all IO pins on one metal layer."]
      Puts [format "%s%s" "**INFO: "  "IO pins will be placed at both metal layers $layer and $layer_2."]
      set curr_offset $two_layer_offset
    }

    for {set i 0} {$i < [sizeof_collection $xports]} {incr i} {
      set port [get_property [index_collection $xports $i] full_name]
      if {$place_on_three_layer == 1} {
        if {$i % 3 == 0} {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
          }
        } elseif {$i % 3 == 1} {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
          }
        } else {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_3 width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_3 width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
          }
        }
        set curr_offset [expr $curr_offset + $pin_layer_top_bottom_spacing / 3]
      } elseif {$place_on_two_layer == 1} {
        if {$i % 2 == 0} {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
          }
        } else {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
          }
        }
        set curr_offset [expr $curr_offset + $pin_layer_top_bottom_spacing / 2]
      } else {
        if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT] )} {
          set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width * 2]
          puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
          set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width / 2]
        } else {
          puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
        }
        set curr_offset [expr $curr_offset + $pin_layer_top_bottom_spacing]
      }
    }
    puts $aFilePtr "    )"
  }
  puts $aFilePtr ")"
  close $aFilePtr
  loadIoFile innovus.io
  legalizePin -keepLayer -keepOrder -moveFixedPin
}

proc TIP_place_io_pins_noc {} {
  source Innovus_define.cmd
  set fpx0 [lindex [dbHeadIoBox] 0]
  set fpy0 [lindex [dbHeadIoBox] 1]
  set fpx1 [lindex [dbHeadIoBox] 2]
  set fpy1 [lindex [dbHeadIoBox] 3]
  
  set fp_width  [expr ($fpx1 - $fpx0) * [dbHeadMicronPerDBU]]
  set fp_height  [expr ($fpy1 - $fpy0) * [dbHeadMicronPerDBU]]

  set allports [get_ports -quiet *]

  set bot_ports [get_ports -quiet $Innovus_BotPins]
  if {[sizeof_collection $bot_ports] > 0} {
    set allports [remove_from_collection $allports $bot_ports]
  }

  set left_ports [get_ports -quiet $Innovus_LeftPins]
  if {[sizeof_collection $left_ports] > 0} {
    set allports [remove_from_collection $allports $left_ports]
  }

  set right_ports [get_ports -quiet $Innovus_RightPins]
  if {[sizeof_collection $right_ports] > 0} {
    set allports [remove_from_collection $allports $right_ports]
  }

  set top_ports [get_ports -quiet $Innovus_TopPins]
  if {[sizeof_collection $top_ports] > 0} {
    set allports [remove_from_collection $allports $top_ports]
    set top_ports [concat $allports $top_ports]
  }

  if {[catch {open innovus.io "w"} aFilePtr] != 0} {
    Puts [format "%s%s" "**ERR" "OR: failed to open file innovus.io" "]
    exit
  }  
  puts $aFilePtr "#IO locations generated by place_innovus_ios.tcl"
  puts $aFilePtr "(globals"
  puts $aFilePtr "    version = 3"
  puts $aFilePtr "    io_order = default"
  puts $aFilePtr ")"
  puts $aFilePtr "(iopin"

  set pin_layer_left_right_minWidth [dbGet [dbGet -p head.layers.name $Fplan_LeftRightPinLayer].minWidth]
  set pin_layer_left_right_minArea  [dbGet [dbGet -p head.layers.name $Fplan_LeftRightPinLayer].area]
  if {($pin_layer_left_right_minWidth > 0.1) || ($LIB_PROCESS_NODE <= 16)} {
    set pin_layer_left_right_width $pin_layer_left_right_minWidth
  } else {
    set pin_layer_left_right_width 0.1
  }
  set pin_layer_left_right_depth [format "%.1f" [expr $pin_layer_left_right_minArea/$pin_layer_left_right_width]]
  if {$pin_layer_left_right_depth < $pin_layer_left_right_minWidth} {
    set pin_layer_left_right_depth $pin_layer_left_right_minWidth
  }
  set pin_layer_left_right_minSpacing [dbGet [dbGet -p head.layers.name $Fplan_LeftRightPinLayer].minSpacing]
  if {([expr $pin_layer_left_right_minSpacing + $pin_layer_left_right_width] > 0.3) || ($LIB_PROCESS_NODE <= 16)} {
    set pin_layer_left_right_spacing [expr $pin_layer_left_right_minSpacing + $pin_layer_left_right_width]
  } else {
    set pin_layer_left_right_spacing 0.3
  }

  set pin_layer_top_bottom_minWidth [dbGet [dbGet -p head.layers.name $Fplan_TopBottomPinLayer].minWidth]
  set pin_layer_top_bottom_minArea  [dbGet [dbGet -p head.layers.name $Fplan_TopBottomPinLayer].area]
  if {($pin_layer_top_bottom_minWidth > 0.1) || ($LIB_PROCESS_NODE <= 16)} {
    set pin_layer_top_bottom_width $pin_layer_top_bottom_minWidth
  } else {
    set pin_layer_top_bottom_width 0.1
  }
  set pin_layer_top_bottom_depth [format "%.1f" [expr $pin_layer_top_bottom_minArea/$pin_layer_top_bottom_width]]
  if {$pin_layer_top_bottom_depth < $pin_layer_top_bottom_minWidth} {
    set pin_layer_top_bottom_depth $pin_layer_top_bottom_minWidth
  }
  set pin_layer_top_bottom_minSpacing [dbGet [dbGet -p head.layers.name $Fplan_TopBottomPinLayer].minSpacing]
  if {([expr $pin_layer_top_bottom_minSpacing + $pin_layer_top_bottom_width] > 0.3) || ($LIB_PROCESS_NODE <= 16)} {
    set pin_layer_top_bottom_spacing [expr 2 * ($pin_layer_top_bottom_minSpacing + $pin_layer_top_bottom_width)]
  } else {
    set pin_layer_top_bottom_spacing 0.3
  }

  if {[regexp {(\d+)} $Fplan_LeftRightPinLayer dummy pin_layer_left_right]} {
  } else {
    set pin_layer_left_right 11
  }
  if {[regexp {(\d+)} $Fplan_TopBottomPinLayer dummy pin_layer_top_bottom]} {
  } else {
    set pin_layer_top_bottom 12
  }

  if {$LIB_PROCESS_NODE <= 7} {
    set pin_layer_left_right [expr $pin_layer_left_right + 1]
    set pin_layer_top_bottom [expr $pin_layer_top_bottom + 1]
  }

  if {[sizeof_collection $left_ports] > 0} {
    puts $aFilePtr "    (left"
    set curr_offset [expr ceil(($fp_height/2.0) - (([sizeof_collection $left_ports]*$pin_layer_left_right_spacing)/2.0))]
    set two_layer_offset [expr ceil(($fp_height/2.0) - (([sizeof_collection $left_ports]*$pin_layer_left_right_spacing * 0.5)/2.0))]
    set three_layer_offset [expr ceil(($fp_height/2.0) - (([sizeof_collection $left_ports]*$pin_layer_left_right_spacing * 0.33)/2.0))]
    set layer $pin_layer_left_right
    set layer_2 [expr $pin_layer_left_right - 2]
    set layer_3 [expr $pin_layer_left_right - 4]
    if {($layer <= 0) || ($layer_2 <= 0) || ($layer_3 <= 0)} {
      Puts [format "%s%s" "**ERR" "OR: CadSetup.file varibles Fplan_*PinLayer should be greater than 4."]
      exit
    }
    set place_on_two_layer 0
    set place_on_three_layer 0

    if {$three_layer_offset <= 0} {
      set extra_length_needed     [format "%.1f" [expr -1.0 * $three_layer_offset]]
      set extra_length_needed_pct [format "%.1f" [expr ($extra_length_needed / $fp_height)*100.0]]
      set recommended_length      [format "%.1f" [expr $fp_height + $extra_length_needed]]
      set aspect_ratio            [format "%.1f" [expr ($fp_height / $fp_width)]]
      Puts [format "%s%s" "**ERR" "OR: Could not place other IO pins on metal layers $layer, $layer_2 and $layer_3. Your floorplan height is not sufficient to accommodate all IO pins."]
      Puts [format "%s%s" "**INFO: "  "Current floorplan height: $fp_height"]
      Puts [format "%s%s" "**INFO: "  "Minimum floorplan height needed: $recommended_length"]
      Puts [format "%s%s" "**INFO: "  "Height delta: $extra_length_needed (${extra_length_needed_pct}%)"]
      Puts [format "%s%s" "**INFO: "  "Current floorplan width:  $fp_width"]
      Puts [format "%s%s" "**INFO: "  "Current aspect ratio: $aspect_ratio"]
      exit
    } elseif {$two_layer_offset <= 0} {
      set place_on_three_layer 1
      Puts [format "%s%s" "**WARN: "  "Could not place all IO pins on metal layers $layer and $layer_2. Your floorplan height is not sufficient to accommodate all IO pins on two metal layers."]
      Puts [format "%s%s" "**INFO: "  "IO pins will be placed at 3 metal layers $layer, $layer_2 and $layer_3."]
      set curr_offset $three_layer_offset
    } elseif {$curr_offset <= 0} {
      set place_on_two_layer 1
      Puts [format "%s%s" "**WARN: "  "Could not place IO pins on metal layer $layer. Your floorplan height is not sufficient to accommodate all IO pins on one metal layer."]
      Puts [format "%s%s" "**INFO: "  "IO pins will be placed at both metal layer $layer and $layer_2."]
      set curr_offset $two_layer_offset
    }

    for {set i 0} {$i < [sizeof_collection $left_ports]} {incr i} {
      set port [get_property [index_collection $left_ports $i] full_name]
      if {$place_on_three_layer == 1} {
        if {$i % 3 == 0} {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_left_right_width [expr $pin_layer_left_right_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
            set pin_layer_left_right_width [expr $pin_layer_left_right_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
          }
        } elseif {$i % 3 == 1} {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_left_right_width [expr $pin_layer_left_right_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
            set pin_layer_left_right_width [expr $pin_layer_left_right_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
          }
        } else {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_left_right_width [expr $pin_layer_left_right_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_3 width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
            set pin_layer_left_right_width [expr $pin_layer_left_right_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_3 width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
          }
        }
        set curr_offset [expr $curr_offset + $pin_layer_left_right_spacing / 3]
      } elseif {$place_on_two_layer == 1} {
        if {$i % 2 == 0} {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_left_right_width [expr $pin_layer_left_right_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
            set pin_layer_left_right_width [expr $pin_layer_left_right_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
          }
        } else {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_left_right_width [expr $pin_layer_left_right_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
            set pin_layer_left_right_width [expr $pin_layer_left_right_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
          }
        }
        set curr_offset [expr $curr_offset + $pin_layer_left_right_spacing / 2]
      } else {
        if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT] )} {
          set pin_layer_left_right_width [expr $pin_layer_left_right_width * 2]
          puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
          set pin_layer_left_right_width [expr $pin_layer_left_right_width / 2]
        } else {
          puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
        }
        set curr_offset [expr $curr_offset + $pin_layer_left_right_spacing]
      }
    }
    puts $aFilePtr "    )"
  }

  if {[sizeof_collection $right_ports] > 0} {
    puts $aFilePtr "    (right"
    set curr_offset [expr ceil(($fp_height/2.0) - (([sizeof_collection $right_ports]*$pin_layer_left_right_spacing)/2.0))]
    set two_layer_offset [expr ceil(($fp_height/2.0) - (([sizeof_collection $right_ports]*$pin_layer_left_right_spacing * 0.5)/2.0))]
    set three_layer_offset [expr ceil(($fp_height/2.0) - (([sizeof_collection $right_ports]*$pin_layer_left_right_spacing * 0.33)/2.0))]
    set layer $pin_layer_left_right
    set layer_2 [expr $pin_layer_left_right - 2]
    set layer_3 [expr $pin_layer_left_right - 4]
    if {($layer <= 0) || ($layer_2 <= 0) || ($layer_3 <= 0)} {
      Puts [format "%s%s" "**ERR" "OR: CadSetup.file varibles Fplan_*PinLayer should be greater than 4."]
      exit
    }
    set place_on_two_layer 0
    set place_on_three_layer 0

    if {$three_layer_offset <= 0} {
      set extra_length_needed     [format "%.1f" [expr -1.0 * $three_layer_offset]]
      set extra_length_needed_pct [format "%.1f" [expr ($extra_length_needed / $fp_height)*100.0]]
      set recommended_length      [format "%.1f" [expr $fp_height + $extra_length_needed]]
      set aspect_ratio            [format "%.1f" [expr ($fp_height / $fp_width)]]
      Puts [format "%s%s" "**ERR" "OR: Could not place other IO pins on metal layers $layer, $layer_2 and $layer_3. Your floorplan height is not sufficient to accommodate all IO pins."]
      Puts [format "%s%s" "**INFO: "  "Current floorplan height: $fp_height"]
      Puts [format "%s%s" "**INFO: "  "Minimum floorplan height needed: $recommended_length"]
      Puts [format "%s%s" "**INFO: "  "Height delta: $extra_length_needed (${extra_length_needed_pct}%)"]
      Puts [format "%s%s" "**INFO: "  "Current floorplan width:  $fp_width"]
      Puts [format "%s%s" "**INFO: "  "Current aspect ratio: $aspect_ratio"]
      exit
    } elseif {$two_layer_offset <= 0} {
      set place_on_three_layer 1
      Puts [format "%s%s" "**WARN: "  "Could not place all IO pins on metal layers $layer and $layer_2. Your floorplan height is not sufficient to accommodate all IO pins on two metal layers."]
      Puts [format "%s%s" "**INFO: "  "IO pins will be placed at 3 metal layers $layer, $layer_2 and $layer_3."]
      set curr_offset $three_layer_offset
    } elseif {$curr_offset <= 0} {
      set place_on_two_layer 1
      Puts [format "%s%s" "**WARN: "  "Could not place IO pins on metal layer $layer. Your floorplan height is not sufficient to accommodate all IO pins on one metal layer."]
      Puts [format "%s%s" "**INFO: "  "IO pins will be placed at both metal layer $layer and $layer_2."]
      set curr_offset $two_layer_offset
    }

    for {set i 0} {$i < [sizeof_collection $right_ports]} {incr i} {
      set port [get_property [index_collection $right_ports $i] full_name]
      if {$place_on_three_layer == 1} {
        if {$i % 3 == 0} {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_left_right_width [expr $pin_layer_left_right_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
            set pin_layer_left_right_width [expr $pin_layer_left_right_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
          }
        } elseif {$i % 3 == 1} {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_left_right_width [expr $pin_layer_left_right_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
            set pin_layer_left_right_width [expr $pin_layer_left_right_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
          }
        } else {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_left_right_width [expr $pin_layer_left_right_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_3 width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
            set pin_layer_left_right_width [expr $pin_layer_left_right_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_3 width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
          }
        }
        set curr_offset [expr $curr_offset + $pin_layer_left_right_spacing / 3]
      } elseif {$place_on_two_layer == 1} {
        if {$i % 2 == 0} {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_left_right_width [expr $pin_layer_left_right_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
            set pin_layer_left_right_width [expr $pin_layer_left_right_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
          }
        } else {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_left_right_width [expr $pin_layer_left_right_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
            set pin_layer_left_right_width [expr $pin_layer_left_right_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
          }
        }
        set curr_offset [expr $curr_offset + $pin_layer_left_right_spacing / 2]
      } else {
        if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT] )} {
          set pin_layer_left_right_width [expr $pin_layer_left_right_width * 2]
          puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
          set pin_layer_left_right_width [expr $pin_layer_left_right_width / 2]
        } else {
          puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_left_right_width depth=$pin_layer_left_right_depth place_status=fixed  )"
        }
        set curr_offset [expr $curr_offset + $pin_layer_left_right_spacing]
      }
    }
    puts $aFilePtr "    )"
  }

  if {[sizeof_collection $top_ports] > 0} {
    puts $aFilePtr "    (top"
    set curr_offset [expr ceil(($fp_width/2.0) - (([sizeof_collection $top_ports]*$pin_layer_top_bottom_spacing)/2.0))]
    set two_layer_offset [expr ceil(($fp_width/2.0) - (([sizeof_collection $top_ports]*$pin_layer_top_bottom_spacing * 0.5)/2.0))]
    set three_layer_offset [expr ceil(($fp_width/2.0) - (([sizeof_collection $top_ports]*$pin_layer_top_bottom_spacing * 0.33)/2.0))]
    set layer $pin_layer_top_bottom
    set layer_2 [expr $pin_layer_top_bottom - 2]
    set layer_3 [expr $pin_layer_top_bottom - 4]
    if {($layer <= 0) || ($layer_2 <= 0)} {
      Puts [format "%s%s" "**ERR" "OR: CadSetup.file varibles Fplan_*PinLayer should be greater than 4."]
      exit
    }
    set place_on_two_layer 0
    set place_on_three_layer 0

    if {$three_layer_offset <= 0} {
      set extra_length_needed     [format "%.1f" [expr -1.0 * $three_layer_offset]]
      set extra_length_needed_pct [format "%.1f" [expr ($extra_length_needed / $fp_width)*100.0]]
      set recommended_length      [format "%.1f" [expr $fp_width + $extra_length_needed]]
      set aspect_ratio            [format "%.1f" [expr ($fp_height / $fp_width)]]
      Puts [format "%s%s" "**ERR" "OR: Could not place other IO pins on metal layers $layer, $layer_2 and $layer_3. Your floorplan width is not sufficient to accommodate all IO pins."]
      Puts [format "%s%s" "**INFO: "  "Current floorplan width: $fp_width"]
      Puts [format "%s%s" "**INFO: "  "Minimum floorplan width needed: $recommended_length"]
      Puts [format "%s%s" "**INFO: "  "Width delta: $extra_length_needed (${extra_length_needed_pct}%)"]
      Puts [format "%s%s" "**INFO: "  "Current floorplan height:  $fp_height"]
      Puts [format "%s%s" "**INFO: "  "Current aspect ratio: $aspect_ratio"]
      exit
    } elseif {$two_layer_offset <= 0} {
      set place_on_three_layer 1
      Puts [format "%s%s" "**WARN: "  "Could not place all IO pins on metal layers $layer and $layer_2. Your floorplan width is not sufficient to accommodate all IO pins on one metal layer."]
      Puts [format "%s%s" "**INFO: "  "IO pins will be placed at 3 metal layers $layer, $layer_2 and $layer_3."]
      set curr_offset $three_layer_offset
    } elseif {$curr_offset <= 0} {
      set place_on_two_layer 1
      Puts [format "%s%s" "**WARN: "  "Could not place all IO pins on metal layer $layer. Your floorplan width is not sufficient to accommodate all IO pins on one metal layer."]
      Puts [format "%s%s" "**INFO: "  "IO pins will be placed at both metal layers $layer and $layer_2."]
      set curr_offset $two_layer_offset
    }

    for {set i 0} {$i < [sizeof_collection $top_ports]} {incr i} {
      set port [get_property [index_collection $top_ports $i] full_name]
      if {$place_on_three_layer == 1} {
        if {$i % 3 == 0} {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
          }
        } elseif {$i % 3 == 1} {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
          }
        } else {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_3 width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_3 width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
          }
        }
        set curr_offset [expr $curr_offset + $pin_layer_top_bottom_spacing / 3]
      } elseif {$place_on_two_layer == 1} {
        if {$i % 2 == 0} {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
          }
        } else {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
          }
        }
        set curr_offset [expr $curr_offset + $pin_layer_top_bottom_spacing / 2]
      } else {
        if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT] )} {
          set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width * 2]
          puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
          set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width / 2]
        } else {
          puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
        }
        set curr_offset [expr $curr_offset + $pin_layer_top_bottom_spacing]
      }
    }
    puts $aFilePtr "    )"
  }

  if {[sizeof_collection $bot_ports] > 0} {
    puts $aFilePtr "    (bottom"
    set curr_offset [expr ceil(($fp_width/2.0) - (([sizeof_collection $bot_ports]*$pin_layer_top_bottom_spacing)/2.0))]
    set two_layer_offset [expr ceil(($fp_width/2.0) - (([sizeof_collection $bot_ports]*$pin_layer_top_bottom_spacing * 0.5)/2.0))]
    set three_layer_offset [expr ceil(($fp_width/2.0) - (([sizeof_collection $bot_ports]*$pin_layer_top_bottom_spacing * 0.33)/2.0))]
    set layer $pin_layer_top_bottom
    set layer_2 [expr $pin_layer_top_bottom - 2]
    set layer_3 [expr $pin_layer_top_bottom - 4]
    if {($layer <= 0) || ($layer_2 <= 0)} {
      Puts [format "%s%s" "**ERR" "OR: CadSetup.file varibles Fplan_*PinLayer should be greater than 2."]
      exit
    }
    set place_on_two_layer 0
    set place_on_three_layer 0

    if {$three_layer_offset <= 0} {
      set extra_length_needed     [format "%.1f" [expr -1.0 * $three_layer_offset]]
      set extra_length_needed_pct [format "%.1f" [expr ($extra_length_needed / $fp_width)*100.0]]
      set recommended_length      [format "%.1f" [expr $fp_width + $extra_length_needed]]
      set aspect_ratio            [format "%.1f" [expr ($fp_height / $fp_width)]]
      Puts [format "%s%s" "**ERR" "OR: Could not place other IO pins on metal layers $layer, $layer_2 and $layer_3. Your floorplan width is not sufficient to accommodate all IO pins."]
      Puts [format "%s%s" "**INFO: "  "Current floorplan width: $fp_width"]
      Puts [format "%s%s" "**INFO: "  "Minimum floorplan width needed: $recommended_length"]
      Puts [format "%s%s" "**INFO: "  "Width delta: $extra_length_needed (${extra_length_needed_pct}%)"]
      Puts [format "%s%s" "**INFO: "  "Current floorplan height:  $fp_height"]
      Puts [format "%s%s" "**INFO: "  "Current aspect ratio: $aspect_ratio"]
      exit
    } elseif {$two_layer_offset <= 0} {
      set place_on_three_layer 1
      Puts [format "%s%s" "**WARN: "  "Could not place all IO pins on metal layers $layer and $layer_2. Your floorplan width is not sufficient to accommodate all IO pins on one metal layer."]
      Puts [format "%s%s" "**INFO: "  "IO pins will be placed at 3 metal layers $layer, $layer_2 and $layer_3."]
      set curr_offset $three_layer_offset
    } elseif {$curr_offset <= 0} {
      set place_on_two_layer 1
      Puts [format "%s%s" "**WARN: "  "Could not place all IO pins on metal layer $layer. Your floorplan width is not sufficient to accommodate all IO pins on one metal layer."]
      Puts [format "%s%s" "**INFO: "  "IO pins will be placed at both metal layers $layer and $layer_2."]
      set curr_offset $two_layer_offset
    }

    for {set i 0} {$i < [sizeof_collection $bot_ports]} {incr i} {
      set port [get_property [index_collection $bot_ports $i] full_name]
      if {$place_on_three_layer == 1} {
        if {$i % 3 == 0} {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
          }
        } elseif {$i % 3 == 1} {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
          }
        } else {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_3 width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_3 width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
          }
        }
        set curr_offset [expr $curr_offset + $pin_layer_top_bottom_spacing / 3]
      } elseif {$place_on_two_layer == 1} {
        if {$i % 2 == 0} {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
          }
        } else {
          if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT])} {
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width * 2]
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
            set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width / 2]
          } else {
            puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer_2 width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
          }
        }
        set curr_offset [expr $curr_offset + $pin_layer_top_bottom_spacing / 2]
      } else {
        if {($LIB_PROCESS_NODE != 5) && ([regexp $port $JTAG_CLK_PORT] || [regexp $port $CLK_PORT] )} {
          set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width * 2]
          puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
          set pin_layer_top_bottom_width [expr $pin_layer_top_bottom_width / 2]
        } else {
          puts $aFilePtr "        (pin name=\"$port\" offset=$curr_offset layer=$layer width=$pin_layer_top_bottom_width depth=$pin_layer_top_bottom_depth place_status=fixed  )"
        }
        set curr_offset [expr $curr_offset + $pin_layer_top_bottom_spacing]
      }
    }
    puts $aFilePtr "    )"
  }
  puts $aFilePtr ")"
  close $aFilePtr
  loadIoFile innovus.io
  legalizePin -keepLayer -keepOrder -moveFixedPin
}

proc TIP_addNdr {widthMultiplier spaceMultiplier minCuts} {
  source Innovus_define.cmd
  set ruleName ${widthMultiplier}w_${spaceMultiplier}s_ndr
  if {[dbGet head.rules.name $ruleName] == "0x0"} {
    set widthString ""
    set spaceString ""
    set minCutString ""
    set layers [dbGet -p head.layers.type routing]
    for {set layer_num 0} {$layer_num < [llength $layers]} {incr layer_num} {
      set layer [lindex $layers $layer_num]
      if {$LIB_PROCESS_NODE == 10} {
            set ndr_btm_layer 3
	    if {[dbGet head.layers.numMasks -i [expr $ndr_btm_layer + 1]] > 1} { 
	    	set ndr_btm_layer 4
	    }
      } elseif {$LIB_PROCESS_NODE <= 7} {
            set ndr_btm_layer 5
      } else {
            set ndr_btm_layer 2
      } 
      if {$layer_num < $ndr_btm_layer} {
        set myWidthMultiplier 1.0
        set mySpaceMultiplier 1.0
      } else {
        set myWidthMultiplier $widthMultiplier
        set mySpaceMultiplier $spaceMultiplier
      }
      set width [expr [dbGet $layer.minWidth] * $myWidthMultiplier]
      set widthString "$widthString [dbGet $layer.name] $width"
      set space [expr [dbGet $layer.minSpacing] * $mySpaceMultiplier]
      set spaceString "$spaceString [dbGet $layer.name] $space"
    }

  if {$LIB_PROCESS_NODE <= 3} {
    foreach layer [dbGet -p head.layers.type cut] {
      if {([regexp -nocase {VIA1$} [dbGet $layer.extname]]==0)&&([regexp -nocase {VIA2$} [dbGet $layer.extname]]==0)&&([regexp -nocase {VIA0} [dbGet $layer.extname]]==0)&&([regexp -nocase {VIA3$} [dbGet $layer.extname]]==0)&&([regexp -nocase {VIA4$} [dbGet $layer.extname]]==0)&&([regexp -nocase {RV} [dbGet $layer.extname]]==0)} {
        set minCutString "$minCutString [dbGet $layer.extname] $minCuts"
      }
    }
    } else {
      foreach layer [dbGet -p head.layers.type cut] {
        if {([regexp -nocase {V.*1} [dbGet $layer.extname]]==0)&&([regexp -nocase {V.*2} [dbGet $layer.extname]]==0)} {
          set minCutString "$minCutString [dbGet $layer.extname] $minCuts"
        }
      }
    }
    add_ndr -width $widthString -spacing $spaceString -min_cut $minCutString $ruleName
    Puts "INFO: Created NDR $ruleName"
  } else {
    Puts "INFO: Not creating rule $ruleName because it already exists"
  }
}

proc TIP_modifyPitchForNDR {widthMultiplier spaceMultiplier} {
    set pitchString "generateTracks"
    set layers [dbGet -p head.layers.type routing]
    set layer_count [expr [llength $layers] - 2]
    set layers [lrange $layers 0 $layer_count]
    foreach layer $layers {
      set width [expr [dbGet $layer.minWidth] * $widthMultiplier]
      set space [expr [dbGet $layer.minSpacing] * $spaceMultiplier]
      set pitchString "$pitchString -[dbGet $layer.name]HPitch [expr $space + $width] -[dbGet $layer.name]VPitch [expr $space + $width]"
    }
   eval "$pitchString"
}

proc TIP_getMetalLayers {} {
  defOut -noCoreCells -noStdCells -ioRow temp.def
  if {[catch {open temp.def "r"} filePtr] != 0} {
    Puts [format "%s%s" "**ERR" "OR: failed to open file temp.def for reading for getTopMetalLayer."]
    return -1
  }
  set metal_layer_list [list]
  while { [gets $filePtr line] >= 0 } {
     if {[regexp {^TRACKS.*LAYER\s(\S\S*)\s;} $line dummy layer_name]} {
          if {[lsearch $metal_layer_list $layer_name] == -1} {lappend metal_layer_list $layer_name;}
     }
  }
  close $filePtr
  return $metal_layer_list
}

proc TIP_block_macros {halo memory_macro_instances} {
    foreach mem $memory_macro_instances {
    set obj_ptr [dbGetInstByName $mem]
    set boundary [dbInstBox $obj_ptr]
    set boundary_x1 [dbDBUToMicrons [lindex $boundary 0]]
    set boundary_y1 [dbDBUToMicrons [lindex $boundary 1]]
    set boundary_x2 [dbDBUToMicrons [lindex $boundary 2]]
    set boundary_y2 [dbDBUToMicrons [lindex $boundary 3]]

    set limit_left   [expr $boundary_x1 - $halo]
    set limit_right  [expr $boundary_x2 + $halo]
    set limit_bottom    [expr $boundary_y1 - $halo]
    set limit_top [expr $boundary_y2 + $halo]

    createObstruct $limit_left  $limit_bottom $boundary_x1 $limit_top
    createObstruct $boundary_x2 $limit_bottom $limit_right $limit_top
    createObstruct $limit_left  $limit_bottom $limit_right $boundary_y1
    createObstruct $limit_left  $boundary_y2  $limit_right $limit_top
    }
}

proc TIP_block_macro_route {halo memory_macro_instances} {
    foreach mem $memory_macro_instances {
    set obj_ptr [dbGetInstByName $mem]
    set boundary [dbInstBox $obj_ptr]
    set boundary_x1 [expr [dbDBUToMicrons [lindex $boundary 0]] - $halo]
    set boundary_y1 [expr [dbDBUToMicrons [lindex $boundary 1]] - $halo]
    set boundary_x2 [expr [dbDBUToMicrons [lindex $boundary 2]] + $halo]
    set boundary_y2 [expr [dbDBUToMicrons [lindex $boundary 3]] + $halo]
    createRouteBlk -box $boundary_x1 $boundary_y1 $boundary_x2 $boundary_y2 -layer all
    }
}

proc TIP_cut_macro_sroutes {halo memory_macro_instances} {
    foreach mem $memory_macro_instances {
    set obj_ptr [dbGetInstByName $mem]
    set boundary [dbInstBox $obj_ptr]
    set x1 [expr [dbDBUToMicrons [lindex $boundary 0]] - $halo]
    set y1 [expr [dbDBUToMicrons [lindex $boundary 1]] - $halo]
    set x2 [expr [dbDBUToMicrons [lindex $boundary 2]] + $halo]
    set y2 [expr [dbDBUToMicrons [lindex $boundary 3]] + $halo]
    editCutWire -x1 $x1 -y1 $y1 -x2 $x2 -y2 $y1
    editCutWire -x1 $x1 -y1 $y2 -x2 $x2 -y2 $y2
    editCutWire -x1 $x1 -y1 $y1 -x2 $x1 -y2 $y2
    editCutWire -x1 $x2 -y1 $y1 -x2 $x2 -y2 $y2
    editDelete -area $x1 $y1 $x2 $y2
    }
}

proc TIP_remove_floating_sroute {} {
  verifyConnectivity -nets {VDD VSS} -type special -noAntenna   \
                     -noWeakConnect -noUnConnPin -noUnroutedNet \
                     -error 10000 -report rptConnectivity.tmp
  if {[catch {open rptConnectivity.tmp "r"} filePtr] != 0} {
    Puts [format "%s%s" "**ERR" "OR: failed to open file rptConnectivity.tmp for reading for TIP_remove_floating_sroute."]
    return -1
  }

  set deleted_wire_coordinate_list [list]
  deselectAll

  while { [gets $filePtr line] >= 0 } {
     if {[regexp {^Net.*open\s+at\s+(.*)} $line dummy coordinates]} {
       regexp {\((\S*),\s+(\S*)\)\s+\((\S*),\s+(\S*)\)} $coordinates dummy x1 y1 x2 y2
       editSelect -area $x1 $y1 $x2 $y2
       set num_selected [dbHeadNrSel]
       if {$num_selected==1} {
         editDelete -type special -nets {VDD VSS} -area $x1 $y1 $x2 $y2
         lappend deleted_wire_coordinate_list [list $x1 $y1 $x2 $y2]
       }
       deselectAll
     }
  }
  close $filePtr
  deselectAll
  clearDrc

  set deleted_wire_coordinate_list [TIP_sort_coordinates_by_y1 $deleted_wire_coordinate_list]
  TIP_block_removed_regions $deleted_wire_coordinate_list
}

proc TIP_sort_coordinates_by_y1 {coordinate_list} {
  set count [llength $coordinate_list]
  for {set i [expr $count - 1]} {$i >= 1} {incr i -1} {
    for {set j [expr $i - 1]} {$j >= 0} {incr j -1} {
      set outer_list [lindex $coordinate_list $i]
      set inner_list [lindex $coordinate_list $j]
      set outer_val [lindex $outer_list 1]
      set inner_val [lindex $inner_list 1]

      if {$outer_val > $inner_val} {
        set coordinate_list [lreplace $coordinate_list $j $j $outer_list]
        set coordinate_list [lreplace $coordinate_list $i $i $inner_list]
      }
    }
  }
  return $coordinate_list
}

proc TIP_block_removed_regions {deleted_wire_coordinate_list} {

  set placement_blockage_merge_threshold 10
  set merged_coordinate_list [list]

  #create a placement blockage for regions where power/gnd
  #wires have been deleted. merge such placement blockages
  #together
  foreach deleted_wire_coord $deleted_wire_coordinate_list {
    set x1 [lindex $deleted_wire_coord 0]; set x2 [lindex $deleted_wire_coord 2]
    set y1 [lindex $deleted_wire_coord 1]; set y2 [lindex $deleted_wire_coord 3]
    set add_to_merged_list 1
    set i 0
    #check if the deleted wire is close to an existing
    #blockage. if it is, increase the blockage vertically
    #to encompass the deleted wire
    foreach coor $merged_coordinate_list {
      set bx1 [lindex $coor 0]; set bx2 [lindex $coor 2]
      set by1 [lindex $coor 1]; set by2 [lindex $coor 3]
      set y_separation_from_block_bottom [expr $by1 - $y2]
      set y_separation_from_block_top    [expr $y2 - $by2]
      if {$y_separation_from_block_bottom > $y_separation_from_block_top} {
        set y_separation $y_separation_from_block_bottom
        set increase_blockage_at "bottom"
      } else {
        set y_separation $y_separation_from_block_top 
        set increase_blockage_at "top"
      }
      #if y_separation is negative, coords are already in
      #blocked area so skip
      if {($bx1 == $x1) && ($bx2 == $x2) && ($y_separation < 0)} {
        set add_to_merged_list 0
        break
      }
      if {($bx1 == $x1) && ($bx2 == $x2) && ($y_separation < $placement_blockage_merge_threshold)} {
        set add_to_merged_list 0
        if {$increase_blockage_at == "top"} {
          set by2 $y2
        } else {
          set by1 $y1
        }
        set coor [list $bx1 $by1 $bx2 $by2]
        set merged_coordinate_list [lreplace $merged_coordinate_list $i $i $coor]
        break
      }
      incr i
    }
    if {$add_to_merged_list==1} {
      lappend merged_coordinate_list $deleted_wire_coord
    }
  }
  foreach coor $merged_coordinate_list {
    set bx1 [lindex $coor 0]; set bx2 [lindex $coor 2]
    set by1 [lindex $coor 1]; set by2 [lindex $coor 3]
    createObstruct $bx1 $by1 $bx2 $by2
  }
}


proc TIP_generate_ignored_nets_list {} {
  set clk_nets [get_nets -quiet -of [all_fanout -from [get_ports -quiet {*CLK* *clk* *JTCK*}]]]
  set test_nets [get_nets -quiet -of [all_fanout -from [get_ports -quiet {*test*}]]]
  set ignored_nets [add_to_collection $clk_nets $test_nets]
  if {[catch {open ignored_nets.txt "w"} aFilePtr] != 0} {
    Puts [format "%s%s" "**ERR" "OR: failed to open file ignored_nets.txt for write"]
    exit
  }
  foreach_in_collection n $ignored_nets {
    puts $aFilePtr [get_property $n full_name]
  }
  close $aFilePtr
}

# used to generate area reports
proc TIP_user_report_area_ref {prefix} {
  if {$prefix != ""} {
    if {[catch {open ${prefix}.area "w"} aFilePtr] != 0} {
      Puts [format "%s%s" "**ERR" "OR: failed to open file ${prefix}.area for writing"]
      return -1
    }
    if {[catch {open ${prefix}.ref "w"} rFilePtr] != 0} {
      Puts [format "%s%s" "**ERR" "OR: failed to open file ${prefix}.ref for writing"]
      return -1
    }
  } else {
      Puts [format "%s%s" "**ERR" "OR: no prefix specified for area reports"]
      return -1    
  }
  set VER [lindex [split [getVersion] {-}] 0]
  set totalArea 0
  set totalCount 0
  set ioArea 0
  set ioCount 0
  set seqArea 0
  set bufArea 0
  set invArea 0
  set phyArea 0
  set combArea 0
  set areaIoArea 0
  set areaIoCount 0
  set blockArea 0
  set blockCount 0
  set blackBoxArea 0
  set blackBoxCount 0
  set stdCellArea 0
  set stdCellCount 0
  set bufferCount 0
  set inverterCount 0
  set physicalCellCount 0
  set sequentialStandardCellCount 0
  set otherStandardCellCount 0
  set haloArea 0
  dbForEachCellInst [dbHeadTopCell] inst {
    set cell [dbInstCell $inst]
    set cellName [dbCellName $cell]
    set instArea [TIP_userInstArea $inst]
    set totalArea [expr $instArea + $totalArea]
    incr totalCount
    # Create hash table to store cell counts and area
    if {[array exists cellCount] == 0} {
      set cellCount($cellName) 1
      set cellArea($cellName) $instArea
    } elseif {[array names cellCount $cellName] != $cellName} { 
      set cellCount($cellName) 1
      set cellArea($cellName) $instArea
    } else {
      incr cellCount($cellName) 
      set cellArea($cellName) [expr $cellArea($cellName) + $instArea]
    }
    
    if {[dbIsInstIo $inst]} {
      set ioArea [expr $instArea + $ioArea]
      incr ioCount
    } elseif {[dbIsInstBlock $inst]} {
      if {[dbIsInstBlackBox $inst]} {
        set blackBoxArea [expr $instArea + $blackBoxArea]
        incr blackBoxCount
      } else {
        set blockArea [expr $instArea + $blockArea]
        set haloArea [expr [dbGet $inst.pHaloBox_area] - $instArea + $haloArea]
        incr blockCount
      }
    } elseif {[dbIsInstStdCell $inst]} {
      if {[dbIsInstAreaIo $inst]} {
        set areaIoArea [expr $instArea + $areaIoArea]
        incr areaIoCount
      } else {
        set stdCellArea [expr $instArea + $stdCellArea]
        incr stdCellCount
        if {$VER >= 21.1} {
          if {[get_db $cell .is_inverter]} {
            set invArea [expr $instArea + $invArea]
            incr inverterCount
          } elseif {[get_db $cell .is_buffer]} {
            set bufArea [expr $instArea + $bufArea]
            incr bufferCount
          } elseif {[dbIsCellSequential $cell]} {
            set seqArea [expr $instArea + $seqArea]
            incr sequentialStandardCellCount
          } elseif {[dbIsInstPhysicalOnly $inst] == 1} {
            set phyArea [expr $instArea + $phyArea]
            incr physicalCellCount
          } else {
            set combArea [expr $instArea + $combArea]
            incr otherStandardCellCount
          }
        } else {
          if {[ckIsInstanceBuf $inst] == 2} {
            set invArea [expr $instArea + $invArea]
            incr inverterCount
          } elseif {[ckIsInstanceBuf $inst] == 1} {
            set bufArea [expr $instArea + $bufArea]
            incr bufferCount
          } elseif {[dbIsCellSequential $cell]} {
            set seqArea [expr $instArea + $seqArea]
            incr sequentialStandardCellCount
          } elseif {[dbIsInstPhysicalOnly $inst] == 1} {
            set phyArea [expr $instArea + $phyArea]
            incr physicalCellCount
          } else {
            set combArea [expr $instArea + $combArea]
            incr otherStandardCellCount
          }
        }
      }
    }
  }

  set fpBox [dbHeadFPlan]
  set coreBox [dbFPlanCoreBox $fpBox]
  set coreX [dbBoxDimX $coreBox]
  set coreY [dbBoxDimY $coreBox]
  set coreMicronX [dbDBUToMicrons $coreX]
  set coreMicronY [dbDBUToMicrons $coreY]
  set coreArea [expr $coreMicronX * $coreMicronY]
    
  set dieBox [dbHeadBox]
  set dieX [dbBoxDimX $dieBox]
  set dieY [dbBoxDimY $dieBox]
  set micronsX [dbDBUToMicrons $dieX]
  set micronsY [dbDBUToMicrons $dieY]
  set dieBoxArea [expr $micronsX * $micronsY]
  set dieArea $dieBoxArea
  set isRectilinear 0
  set nrCuts 0
  dbForEachFPlanPtnCut [dbHeadFPlan] ptnCut {
    set isRectilinear 1
    incr nrCuts
    set ptnCutBox [dbPtnCutBox $ptnCut]
    set ptnCutX [dbBoxDimX $ptnCutBox]
    set ptnCutY [dbBoxDimY $ptnCutBox]
    set micronsPtnCutX [dbDBUToMicrons $ptnCutX]
    set micronsPtnCutY [dbDBUToMicrons $ptnCutY]
    set micronsPtnCutArea [expr $micronsPtnCutX * $micronsPtnCutY]
    set dieArea [expr $dieArea - $micronsPtnCutArea]
    set coreArea [expr $coreArea - $micronsPtnCutArea]
  }
  
  # Print Summary
  set bufPercent  [expr 100 * ($bufArea  / $stdCellArea)]
  set invPercent  [expr 100 * ($invArea  / $stdCellArea)]
  set seqPercent  [expr 100 * ($seqArea  / $stdCellArea)]
  set phyPercent  [expr 100 * ($phyArea  / $stdCellArea)]
  set combPercent [expr 100 * ($combArea / $stdCellArea)]

  puts $aFilePtr "Std Cell Type   Count  Area(um^2)    (%)"
  puts $aFilePtr "------------------------------------------"
  puts $aFilePtr [format "  Buffers:      %8s %10.2f (%6.2f%%)" $bufferCount $bufArea $bufPercent]
  puts $aFilePtr [format "  Inverters:    %8s %10.2f (%6.2f%%)" $inverterCount $invArea $invPercent]
  puts $aFilePtr [format "  Sequentials:  %8s %10.2f (%6.2f%%)" $sequentialStandardCellCount $seqArea $seqPercent]
  puts $aFilePtr [format "  Physicals:    %8s %10.2f (%6.2f%%)" $physicalCellCount $phyArea $phyPercent]
  puts $aFilePtr [format "  Comb:         %8s %10.2f (%6.2f%%)" $otherStandardCellCount $combArea $combPercent]
  puts $aFilePtr "------------------------------------------"
  puts $aFilePtr [format "Std Cell Total: %8s %10.2f (%6.2f%%)" $stdCellCount $stdCellArea 100]
  puts $aFilePtr [format "Block:          %8s %10.2f" $blockCount $blockArea]
  puts $aFilePtr [format "BlackBox:       %8s %10.2f" $blackBoxCount $blackBoxArea]
  puts $aFilePtr [format "IO:             %8s %10.2f" $ioCount $ioArea]
  puts $aFilePtr [format "Area IO:        %8s %10.2f" $areaIoCount $areaIoArea]
  puts $aFilePtr "------------------------------------------"
  puts $aFilePtr [format "Block Halo Area:%8s %10.2f" "" $haloArea]
  puts $aFilePtr [format "Total Area:     %8s %10.2f" "" $totalArea]
  puts $aFilePtr [format "Core Area:      %8s %10.2f" "" $coreArea]
  puts $aFilePtr [format "Die Area:       %8s %10.2f" "" $dieArea]
  
  puts $aFilePtr ""
  puts $aFilePtr "Core Density = (Standard Cell + Block + Black Box) / Core Area"
  puts $aFilePtr [format "Core Density = %2.2f%%" [expr 100 * ($stdCellArea + $blockArea + $blackBoxArea) / $coreArea]]
  puts $aFilePtr ""
  puts $aFilePtr "Core Density (No Physical) = (Standard Cell + Block + Black Box - Physical Cell) / Core Area"
  puts $aFilePtr [format "Core Density = %2.2f%%" [expr 100 * ($stdCellArea + $blockArea + $blackBoxArea - $phyArea) / $coreArea]]
  puts $aFilePtr ""
  puts $aFilePtr "Logic Density = (Standard Cell - Physical Cell) / (Core Area - Block - Black Box - Physical Cell - Block Halo)"
  puts $aFilePtr [format "Logic Density = %2.2f%%" [expr 100 * ($stdCellArea - $phyArea) / ($coreArea - $blockArea - $blackBoxArea - $phyArea - $haloArea)]]
  puts $aFilePtr ""
  puts $aFilePtr "Die Density = (Standard Cell + Block + Black Box + IO Cell + Area IO Cell) / Die Area"
  puts $aFilePtr [format "Die Density = %2.2f%%" [expr 100 * ($stdCellArea + $blockArea + $blackBoxArea + $ioArea + $areaIoArea) / $dieArea]]

  # Print cell counts and area
  puts $rFilePtr ""
  puts $rFilePtr "       Lib Cell           Instances          Area     "
  puts $rFilePtr "----------------------------------------------------"
  foreach cellName [lsort [array names cellCount]] {
    set line [format "%-20s %10s %15.3f" $cellName $cellCount($cellName) $cellArea($cellName)]
    puts $rFilePtr $line
  }
  puts $rFilePtr "----------------------------------------------------"
  puts $rFilePtr [format "%-20s %10s %15.3f" "Total" [expr $stdCellCount + $blockCount] [expr $stdCellArea + $blockArea]]
  puts $rFilePtr ""
  puts $rFilePtr ""

  close $aFilePtr
  close $rFilePtr
}

proc TIP_userInstArea {inst} {
  set cell [dbInstCell $inst]
  set dim [dbCellDim $cell]
  set x [dbDBUToMicrons [lindex $dim 0]]
  set y [dbDBUToMicrons [lindex $dim 1]]
  set boxArea [expr $x * $y]
  return $boxArea
}

proc TIP_remove_unconnected_nets {} {
  set unconnected_nets [get_nets -quiet -hier *UNCONNECTED*]
  foreach_in_collection un $unconnected_nets {
    set nn [get_property $un full_name]
    set dp [get_property $un driver_pins]
    set lp [get_property $un load_pins]
    if {([sizeof_collection $dp]==0)||([sizeof_collection $lp]==0)} {
      deleteNet $nn
    }
  }
}


proc TIP_report_clock_stats {report_suffix} {
  setPreference CmdLogMode 0
  
  if { [catch {set fid [open "${report_suffix}.clock_latency" "w"]} ] } {
    Puts [format "%s%s" "**ERR" "OR: Could not open ${report_suffix}.clock_latency for writing"]
  }
  
  set view_list [all_setup_analysis_views]
  foreach view $view_list {
    puts $fid "######################################################################"
    puts $fid "## SETUP VIEW : $view"
    puts $fid "######################################################################"
    set all_clocks [lsort -u [get_property [get_clocks *] full_name]]
    foreach clk $all_clocks {
      set clk_name $clk
      set clk_root [get_property [get_clocks $clk] sources]
      #Do not get stats for virtual clocks
      if {[sizeof_collection $clk_root] <= 0} {continue}
      set clk_regs [all_fanout -endpoints_only -only_cells -from $clk_root]
      set sink_count [sizeof_collection $clk_regs]
      set max_clk_path_delay 0
      set min_clk_path_delay 1000000
      set max_clk_path_pin ""
      set min_clk_path_pin ""

      foreach_in_collection clk_reg $clk_regs {
        set clk_reg_clk_pins [get_pins -quiet -of $clk_reg -filter "is_clock_pin==true"]
        if {[sizeof_collection $clk_reg_clk_pins]<=0} {
          continue
        }
        set clk_reg_clk_pin [index_collection $clk_reg_clk_pins 0]
        if {[get_property $clk_reg_clk_pin is_clock_gating]==true} {
          continue
        }
        set tp [report_timing -view $view -collection -unconstrained -from $clk_root -to $clk_reg_clk_pin]
        if {[sizeof_collection $tp] <= 0} {
          continue
        }
        set arrival [get_property $tp arrival]
        set source_insertion [get_property $tp launching_clock_latency]
        if {($arrival == "") || ($source_insertion == "")} {
          continue
        }
        set clk_path_delay [expr $arrival + (-1.0 * $source_insertion)]
        if {$clk_path_delay < $min_clk_path_delay} {
          set min_clk_path_delay $clk_path_delay
          set min_clk_path_pin [get_property $clk_reg_clk_pin full_name]
        }
        if {$clk_path_delay > $max_clk_path_delay} {
          set max_clk_path_delay $clk_path_delay
          set max_clk_path_pin [get_property $clk_reg_clk_pin full_name]
        }       
      }
      puts $fid "\tClock             : $clk_name"
      puts $fid "\t\tMax Latency     : $max_clk_path_delay"
      puts $fid "\t\tMax Latency Pin : $max_clk_path_pin"
      puts $fid "\t\tMin Latency     : $min_clk_path_delay"
      puts $fid "\t\tMin Latency Pin : $min_clk_path_pin"
      puts $fid "----------------------------------------------------------------------"
    }
  }

  set view_list [all_hold_analysis_views]
  foreach view $view_list {
    puts $fid "######################################################################"
    puts $fid "## HOLD VIEW : $view"
    puts $fid "######################################################################"
    set all_clocks [lsort -u [get_property [get_clocks *] full_name]]
    foreach clk $all_clocks {
      set clk_name $clk
      set clk_root [get_property [get_clocks $clk] sources]
      #Do not get stats for virtual clocks
      if {[sizeof_collection $clk_root] <= 0} {continue}
      set clk_regs [all_fanout -endpoints_only -only_cells -from $clk_root]
      set sink_count [sizeof_collection $clk_regs]
      set max_clk_path_delay 0
      set min_clk_path_delay 1000000
      set max_clk_path_pin ""
      set min_clk_path_pin ""

      foreach_in_collection clk_reg $clk_regs {
        set clk_reg_clk_pins [get_pins -quiet -of $clk_reg -filter "is_clock_pin==true"]
        if {[sizeof_collection $clk_reg_clk_pins]<=0} {
          continue
        }
        set clk_reg_clk_pin [index_collection $clk_reg_clk_pins 0]
        if {[get_property $clk_reg_clk_pin is_clock_gating]==true} {
          continue
        }
        set tp [report_timing -view $view -early -collection -unconstrained -from $clk_root -to $clk_reg_clk_pin]
        if {[sizeof_collection $tp] <= 0} {
          continue
        }
        set arrival [get_property $tp arrival]
        set source_insertion [get_property $tp launching_clock_latency]
        if {($arrival == "") || ($source_insertion == "")} {
          continue
        }
        set clk_path_delay [expr $arrival + (-1.0 * $source_insertion)]
        if {$clk_path_delay < $min_clk_path_delay} {
          set min_clk_path_delay $clk_path_delay
          set min_clk_path_pin [get_property $clk_reg_clk_pin full_name]
        }
        if {$clk_path_delay > $max_clk_path_delay} {
          set max_clk_path_delay $clk_path_delay
          set max_clk_path_pin [get_property $clk_reg_clk_pin full_name]
        }
      }
      puts $fid "\tClock             : $clk_name"
      puts $fid "\t\tMax Latency     : $max_clk_path_delay"
      puts $fid "\t\tMax Latency Pin : $max_clk_path_pin"
      puts $fid "\t\tMin Latency     : $min_clk_path_delay"
      puts $fid "\t\tMin Latency Pin : $min_clk_path_pin"
      puts $fid "----------------------------------------------------------------------"
    }
  }
  close $fid

  setPreference CmdLogMode 1
}

proc TIP_get_sdc_units {} {
  source Innovus_define.cmd
  global FILE_NAME_PREFIX
  if {[catch {open ${FILE_NAME_PREFIX}_cons.sdc "r"} filePtr] != 0} {
    Puts [format "%s%s" "**ERR" "OR: failed to open file ${FILE_NAME_PREFIX}_cons.sdc for reading for TIP_get_sdc_units."]
    return -1
  }
  while { [gets $filePtr line] >= 0 } {
     if {[regexp {^set_units -capacitance 1000.0fF} $line]} {
          setLibraryUnit -cap 1pf
     }
     if {[regexp {^set_units -capacitance 1.0fF} $line]} {
          setLibraryUnit -cap 1ff
     }
     if {[regexp {^set_units -time 1000.0ps} $line]} {
          setLibraryUnit -time 1ns
     }
     if {[regexp {^set_units -capacitance 1.0ps} $line]} {
          setLibraryUnit -time 1ps
     }
     if {[regexp {^set_units -time ns.*-capacitance pF} $line]} {
          setLibraryUnit -time 1ns -cap 1pf
     }
     if {[regexp {^set_units -time ps.*-capacitance fF} $line]} {
          setLibraryUnit -time 1ps -cap 1ff
     }
     if {[regexp {^set_units -time ns.*-capacitance fF} $line]} {
          setLibraryUnit -time 1ns -cap 1ff
     }
     if {[regexp {^set_units -time ps.*-capacitance pF} $line]} {
          setLibraryUnit -time 1ps -cap 1pf
     }
  }
  close $filePtr
}
proc TIP_define_cts_specs {} {
    source Innovus_define.cmd
    TIP_remove_overconstrain_cgs
    if {$Fplan_MaxRoutingLayer >= 9} {
        set trunk_top_preferred_layer M9
        set trunk_bottom_preferred_layer M8
        set leaf_top_preferred_layer M7
        set leaf_bottom_preferred_layer M6
    } else {
        set trunk_top_preferred_layer M7
        set trunk_bottom_preferred_layer M6
        set leaf_top_preferred_layer M5
        set leaf_bottom_preferred_layer M4
    }

    if {$Fplan_MaxRoutingLayer >= 7} {
        if {![regexp {nondr} $Innovus_RoutingFlow]} {
          if {$LIB_PROCESS_NODE == 5} {
            TIP_addNdr 1 3 2
            if {$Innovus_ClockShieldingEnabled==1} {
            create_route_type -name cts_route_type_leaf -top_preferred_layer $leaf_top_preferred_layer \
                              -bottom_preferred_layer $leaf_bottom_preferred_layer
            create_route_type -name cts_route_type_nonleaf -top_preferred_layer $trunk_top_preferred_layer \
                              -bottom_preferred_layer $trunk_bottom_preferred_layer \
                              -non_default_rule 1w_3s_ndr \
                              -shield_net VSS -bottom_shield_layer $trunk_bottom_preferred_layer
            } else {
            create_route_type -name cts_route_type_leaf -top_preferred_layer $leaf_top_preferred_layer \
                              -bottom_preferred_layer $leaf_bottom_preferred_layer \
                              -non_default_rule 1w_3s_ndr
            create_route_type -name cts_route_type_nonleaf -top_preferred_layer $trunk_top_preferred_layer \
                              -bottom_preferred_layer $trunk_bottom_preferred_layer \
                              -non_default_rule 1w_3s_ndr
            }
          } else {
            TIP_addNdr 2 2 2
            if {$Innovus_ClockShieldingEnabled==1} {
            create_route_type -name cts_route_type_leaf -top_preferred_layer $leaf_top_preferred_layer \
                              -bottom_preferred_layer $leaf_bottom_preferred_layer
            create_route_type -name cts_route_type_nonleaf -top_preferred_layer $trunk_top_preferred_layer \
                              -bottom_preferred_layer $trunk_bottom_preferred_layer \
                              -non_default_rule 2w_2s_ndr \
                              -shield_net VSS -bottom_shield_layer $trunk_bottom_preferred_layer
            } else {
            create_route_type -name cts_route_type_leaf -top_preferred_layer $leaf_top_preferred_layer \
                              -bottom_preferred_layer $leaf_bottom_preferred_layer \
                              -non_default_rule 2w_2s_ndr
            create_route_type -name cts_route_type_nonleaf -top_preferred_layer $trunk_top_preferred_layer \
                              -bottom_preferred_layer $trunk_bottom_preferred_layer \
                              -non_default_rule 2w_2s_ndr
            }
          }
        } else {
          if {$Innovus_ClockShieldingEnabled==1} {
          create_route_type -name cts_route_type_leaf -top_preferred_layer $leaf_top_preferred_layer \
                            -bottom_preferred_layer $leaf_bottom_preferred_layer
          create_route_type -name cts_route_type_nonleaf -top_preferred_layer $trunk_top_preferred_layer \
                            -bottom_preferred_layer $trunk_bottom_preferred_layer \
                            -shield_net VSS -bottom_shield_layer $trunk_bottom_preferred_layer
          } else {
          create_route_type -name cts_route_type_leaf -top_preferred_layer $leaf_top_preferred_layer \
                            -bottom_preferred_layer $leaf_bottom_preferred_layer
          create_route_type -name cts_route_type_nonleaf -top_preferred_layer $trunk_top_preferred_layer \
                            -bottom_preferred_layer $trunk_bottom_preferred_layer
          }
        }
    set_ccopt_property route_type -net_type top cts_route_type_nonleaf
    set_ccopt_property route_type -net_type trunk cts_route_type_nonleaf
    set_ccopt_property route_type -net_type leaf cts_route_type_leaf
    }

    set_ccopt_property buffer_cells $LIB_CLOCK_BUFFERS
    set_ccopt_property inverter_cells $LIB_CLOCK_INVERTERS
    set_ccopt_property target_max_trans $MAX_CLOCK_TRANSITION
    set_ccopt_property target_skew $CLOCK_SKEW
    
    setAnalysisMode -cppr both -analysisType onChipVariation
    
    set_interactive_constraint_modes [all_constraint_modes -active]
    foreach_in_collection root [get_clock_source] {
      set clk_root [get_property $root full_name]
      reset_clock_latency $clk_root 
      set_clock_latency -source -max 0.0 [get_ports $clk_root]
      set_clock_latency -source -min 0.0 [get_ports $clk_root]
    }
    set_interactive_constraint_modes {}

    set_ccopt_property update_io_latency true
    set_ccopt_property ccopt_worst_chain_report_timing_too true
    set_ccopt_property cts_use_inverters true
    set_ccopt_property add_wire_delay_in_detailed_balancer true
    
    create_ccopt_clock_tree_spec

    foreach sg [get_ccopt_skew_groups *] {
       unset_ccopt_property target_insertion_delay -skew_group $sg
    }
    if {$Innovus_ClockShieldingEnabled == 1} {
      setNanoRouteMode -routeBottomShieldLayer [dbGet [dbGet -p head.layers.name $trunk_bottom_preferred_layer].num]
    }

}

## This proc is used to add Flip-Chip bumps in the design to improve IR Drop.
## It is recommended to use "PAD75UBMBOT_90DEG" for Horizontal Top Layer and PAD75UBMBOT_0DEG for Vertical Top Layer.  
## If 12LM stack used, M12 is horizontal, so use PAD75UBMBOT_90DEG.
## Incase of custom CoreToDie spacing, edit variables Fplan_Spacing_left, Fplan_Spacing_right, Fplan_Spacing_top and Fplan_Spacing_bottom. 
## Default is same for all, i.e. Fplan_CoreToIOSpacing.
## Pre-requisite : Top layer of powerplan must have stripe width >= 3um. 
## This is to ensure proper via generation over bumps from AP layer to top layer. Stripe spacing and set-to-set-distance can be set accordingly.

proc TIP_place_flipchip_bumps {} {
  deletePGPin -all  
  source Innovus_define.cmd
  #### Get floorplan height, width ####
  set chip_x [dbGet top.fPlan.box_urx]
  set chip_y [dbGet top.fPlan.box_ury]
  
  #### Defining width, height of various Bump Cells ####
  set width [dbget [dbget -p head.allCells.name $Fplan_FlipChipBumpCell].size_x]
  set height [dbget [dbget -p head.allCells.name $Fplan_FlipChipBumpCell].size_y]
  
  #### Setting pitch, spacing
  set pitch_x $Fplan_FlipChipBumpPitch
  set pitch_y $Fplan_FlipChipBumpPitch
  set Fplan_Spacing_left   $Fplan_CoreToIOSpacing
  set Fplan_Spacing_right  $Fplan_CoreToIOSpacing
  set Fplan_Spacing_top    $Fplan_CoreToIOSpacing
  set Fplan_Spacing_bottom $Fplan_CoreToIOSpacing
  
  #### Get the max. number of rows and columns of bumps that can be added within core boundary. 
  #### Also ensure equal spacing between bumps and from die boundary
  set col [expr (int($chip_x / $pitch_x))]
  set row [expr (int($chip_y / $pitch_y))]
  #if {[expr ($col % 2)] != 0} {
  #  if {[expr (($col*$pitch_x) + $width)] < [expr $chip_x - ($Fplan_Spacing_left + $Fplan_Spacing_right)]} {
  #    set col [expr ($col + 1)]
  #  } else {
  #    set col [expr ($col - 1)]
  #  }
  #}  
  #if {[expr ($row % 2)] != 0} {
  #  if {[expr (($row*$pitch_y) + $height)] < [expr $chip_y - ($Fplan_Spacing_top + $Fplan_Spacing_bottom)]} {
  #    set row [expr ($row + 1)]
  #  } else {
  #    set row [expr ($row - 1)]
  #  }
  #} 
  #### Set the XY location for the first bump to be placed w.r.t. origin (0,0) 
  #set loc_x [format %.2f [expr double(($chip_x - (($col-1)*$pitch_x) - $width) / 2)]]
  #set loc_y [format %.2f [expr double(($chip_y - (($row-1)*$pitch_y) - $height) / 2)]]
  set bump_sizex [dbGet [dbGet -p1 head.allCells.name $Fplan_FlipChipBumpCell].size_x]
  set bump_sizey [dbGet [dbGet -p1 head.allCells.name $Fplan_FlipChipBumpCell].size_y]  
  
  #### PG Bumps creation and VDD/VSS Assignment ####
  deleteBumps -all
  #create_bump -cell $Fplan_FlipChipBumpCell -loc_type cell_lowerleft -pitch "$pitch_x $pitch_y" -loc "[expr $loc_x] [expr $loc_y]" -pattern_array "$row $col"
  create_bump -cell $Fplan_FlipChipBumpCell -edge_spacing "[expr $Fplan_FlipChipBumpPitch/2] [expr $Fplan_FlipChipBumpPitch/2] [expr $bump_sizex/2] [expr $bump_sizey/2]" -loc "[expr $Fplan_FlipChipBumpPitch/2] [expr $Fplan_FlipChipBumpPitch/2]" -pattern_full_chip -pitch "$Fplan_FlipChipBumpPitch $Fplan_FlipChipBumpPitch" -start_from lower_left  -name_format "BUMP_%r_%c"
  
  #### Assigning VDD bumps in checker-board pattern
  deselectAll
  for {set i 1} {$i <= $row} {incr i 1} {
   if {[expr $i % 3] == 1} {
     for {set j 1} {$j <= $col} {incr j 6} {
     selectObject Bump [format "%s%s%s%s" "BUMP_" "$i" _ "$j"]
     }
   } elseif {[expr $i % 3] == 2} {
     for {set j 5} {$j <= $col} {incr j 6} {
     selectObject Bump [format "%s%s%s%s" "BUMP_" "$i" _ "$j"]
     }
   } else {
     for {set j 3} {$j <= $col} {incr j 6} {
       selectObject Bump [format "%s%s%s%s" "BUMP_" "$i" _ "$j"] 
     }
   }
  }
  assignPGBumps -nets VDD -selected
  
  #### Assigning VSS bumps in checker-board pattern
  deselectAll
  for {set i 1} {$i <= $row} {incr i 1} {
   if {[expr $i % 3] == 1} {
     for {set j 4} {$j <= $col} {incr j 6} {
     selectObject Bump [format "%s%s%s%s" "BUMP_" "$i" _ "$j"]
     }
   } elseif {[expr $i % 3] == 2} {
     for {set j 2} {$j <= $col} {incr j 6} {
     selectObject Bump [format "%s%s%s%s" "BUMP_" "$i" _ "$j"]
     }
   } else {
     for {set j 6} {$j <= $col} {incr j 6} {
     selectObject Bump [format "%s%s%s%s" "BUMP_" "$i" _ "$j"]
     }
   }
  }
  assignPGBumps -nets VSS -selected
  
  deselectAll
  #### Generate vias from AP to Top layer ####
  ## Create shape to enable via drop
  set top_layer [lindex [lsort -decreasing -dictionary [dbGet head.layers.num]] 0]
  set bump_layer_name [dbGet [dbGet -p1 head.layers.num $top_layer].name]
  set stripe_layer_name [dbGet [dbGet -p1 head.layers.num [expr $top_layer -1]].name]
  set min_spacing [dbGet [dbGet -p1 head.layers.name $bump_layer_name].minSpacing]
  set min_width [expr [dbGet [dbGet -p1 head.layers.name $bump_layer_name].minWidth] * 2]

  set size_shape_incr_x [expr $Fplan_FlipChipBumpPitch/2 - $min_spacing/2]
  set size_shape_incr_y [expr $Fplan_FlipChipBumpPitch/2 - $min_spacing/2]
  if {[expr $size_shape_incr_x * 2] > [dbGet [dbGet -p1 head.layers.name $bump_layer_name].maxWidth]} {
    if {[dbGet [dbGet -p1 head.layers.name $bump_layer_name].direction] eq "Vertical"} {
      set size_shape_incr_x [expr [dbGet [dbGet -p1 head.layers.name $bump_layer_name].maxWidth]/2]
    } else {
      set size_shape_incr_y [expr [dbGet [dbGet -p1 head.layers.name $bump_layer_name].maxWidth]/2]
    }
  }
  foreach bump [dbGet top.bumps] {
    add_shape -rect "[expr [dbGet $bump.bump_shape_center_x] - $size_shape_incr_x] [expr [dbGet $bump.bump_shape_center_y] - $size_shape_incr_y] [expr [dbGet $bump.bump_shape_center_x] + $size_shape_incr_x] [expr [dbGet $bump.bump_shape_center_y] + $size_shape_incr_y]" -layer $bump_layer_name -status FIXED -shape STRIPE -net [dbGet $bump.net.name]
  }

  ## Recreate stripes if needed
  if {[lindex [lsort -u -increasing [dbGet [dbGet -p1 [dbGet -p1 top.physNets.isPwrOrGnd 1].sWires.layer.name $stripe_layer_name].width]] 0] < $min_width} {
    puts "Stripe too small to fit bump to stripe vias, will generate it again"
    editDelete -layer $stripe_layer_name -shape STRIPE
    setAddStripeMode -stacked_via_bottom_layer [dbGet [dbGet -p1 head.layers.num [expr $top_layer -2]].name] -stacked_via_top_layer $bump_layer_name
    addStripe -layer $stripe_layer_name -create_pins 0 -spacing $min_spacing -nets "[dbGet [dbGet -p1 top.physNets.isPwrOrGnd 1].name]" -direction [dbGet [dbGet -p1 head.layers.name $stripe_layer_name].direction] -width $min_width -start [dbGet top.fPlan.box_llx] -set_to_set_distance [expr $min_width * 2 + $min_spacing * 2]
  }

  ## Create PG Pin to be used as voltage source by Voltus.
  ## The script will check if it should be placed in stripes or bumps
  set pg_pin_layer [lindex [lsort -u -decreasing -dictionary [dbGet top.physNets.swires.layer.num]] 0]
  set pg_pin_layer_name [dbGet [dbGet -p1 head.layers.num $pg_pin_layer].name]
  
  foreach stripe [dbGet -p1 [dbGet -p2 [dbGet -p1 top.physNets.isPwrOrGnd 1].swires.layer.name $pg_pin_layer_name].shape stripe] {
    if {[dbGet $stripe.box_sizex] < [dbGet $stripe.box_sizey]} {
      set size_pin [dbGet $stripe.box_sizex]
      set pin_llx [dbGet $stripe.box_llx]
      set pin_lly [dbGet $stripe.box_lly]
      set pin_urx [dbGet $stripe.box_urx]
      set pin_ury [expr [dbGet $stripe.box_lly] + $size_pin]
      eval "createPGPin [dbGet $stripe.net.name] -dir input -net [dbGet $stripe.net.name] -geom \"$pg_pin_layer_name $pin_llx $pin_lly $pin_urx $pin_ury\""
      set pin_llx [dbGet $stripe.box_llx]
      set pin_lly [expr [dbGet $stripe.box_ury] - $size_pin]
      set pin_urx [dbGet $stripe.box_urx]
      set pin_ury [dbGet $stripe.box_ury]
      eval "createPGPin [dbGet $stripe.net.name] -dir input -net [dbGet $stripe.net.name] -geom \"$pg_pin_layer_name $pin_llx $pin_lly $pin_urx $pin_ury\""
    } else {
      set size_pin [dbGet $stripe.box_sizey]
      set pin_llx [dbGet $stripe.box_llx]
      set pin_lly [dbGet $stripe.box_lly]
      set pin_urx [expr [dbGet $stripe.box_llx] + $size_pin]
      set pin_ury [dbGet $stripe.box_ury]
      eval "createPGPin [dbGet $stripe.net.name] -dir input -net [dbGet $stripe.net.name] -geom \"$pg_pin_layer_name $pin_llx $pin_lly $pin_urx $pin_ury\""
      set pin_llx [expr [dbGet $stripe.box_urx] - $size_pin]
      set pin_lly [dbGet $stripe.box_lly]
      set pin_urx [dbGet $stripe.box_urx]
      set pin_ury [dbGet $stripe.box_ury]
      eval "createPGPin [dbGet $stripe.net.name] -dir input -net [dbGet $stripe.net.name] -geom \"$pg_pin_layer_name $pin_llx $pin_lly $pin_urx $pin_ury\""
    }
  }
}


# This procedure should be used to add Filler/Decap cells in the database to reduce dynamic IR Drop of the design
# It is recommended to use it on postRoute Hold or Post TSO database
proc TIP_place_filler_decap_cells {} {
  source Innovus_define.cmd
  
  ## Getting Decap cell list and their sizes ##
  set decaps [regexp -all -inline {(DCAP\w+)\s} $Innovus_DecapCells ]
  foreach {whole cell} $decaps {
    lappend decap_list [list $cell]
  }
  set sizes [regexp -all -inline {DCAP(\d+)\w+} $decap_list ]
  foreach {whole size} $sizes {
    lappend decap_sizes [list $size]
  }

  ## Getting postfix for decap and filler cells ##
  set reference_cell [lindex $decap_list 0]
  regexp {DCAP\w+(BWP\w+)} $reference_cell dummy postfix

  ## Getting filler cell list and their sizes ##
  set fillers [list $Lib_FillerCells]  
  set sizes [regexp -all -inline {FILL(\d+)\w+} $Lib_FillerCells ]
  foreach {whole size} $sizes {
    lappend filler_sizes [list $size]
  }

  set filler_sizes [lsort -unique $filler_sizes]
  ## Appending filler cell to Decap cell list if decap cell of same size is not available  ##
  foreach i $filler_sizes {
    if {[lsearch $decap_sizes $i] == -1} {lappend decap_list "FILL$i$postfix"} 
  }

  ## Adding fillers and decaps ##
  deleteFiller -prefix FILLER
  Puts [format "%s%s" "Merged Filler-Decap list :" " ${decap_list}"]
  deleteFiller -prefix FILLER
  setFillerMode -core $decap_list
  addFiller -prefix FILLER
}

# This procedure is used to fix floating metal DRCs by deleting those floating patch wires.
proc TIP_fix_drc_viol {violation} {

if {[dbGet top.markers.subType -p  $violation] !=0x0 } {
puts "Getting the markers information for specified drc type...."    
foreach MARKER [dbGet top.markers.subType -p $violation] {
    set MARKER_BOX [dbget $MARKER.box]                      
    set MARKER_LAYER [dbget $MARKER.layer.name]
    set NET_PTR [dbQuery -areas $MARKER_BOX -layer $MARKER_LAYER -objType pWire]
    set NET_PTR1 [dbQuery -areas $MARKER_BOX -layer $MARKER_LAYER -objType sWire]
        if {![regexp 0x0 [dbget $NET_PTR.net.name]]} {
            select_obj $NET_PTR
#            editSelect -area $MARKER_BOX -layer $MARKER_LAYER -wires_only 1
        }
        if {![regexp 0x0 [dbget $NET_PTR1.net.name]]} {
            select_obj $NET_PTR1
#            editSelect -area $MARKER_BOX -layer $MARKER_LAYER -wires_only 1
        }
}

set net_names {}
lappend net_names [dbget selected.net.name]

#foreach n $net_names {
#        dbSet [dbGetNetByName [lindex $n 0]].wires.status routed
#}

puts "Deleting the patch wires...."
editDelete -selected -type Patch



deselectAll

#foreach n $net_names {
#    selectNet $n
#}


puts "Connectivity report is being dumped..."

redirect conn_fixpatch.rpt {verifyConnectivity -type regular -error 0}

setMultiCpuUsage -localCpu 16

#setNanoRouteMode -routeDesignFixClockNets false
#setNanoRouteMode -routeSelectedNetOnly true     
#ecoRoute -target
#setNanoRouteMode -routeSelectedNetOnly false
#setNanoRouteMode -routeDesignFixClockNets true

puts "DRC report is being dumped..."
redirect drc.rpt {verify_drc -check_only regular -limit 0}

} else {
puts "No $violation DRC exist in the design"
}
}

proc TIP_listns {{parentns ::}} {
  set result [list]
  foreach ns [namespace children $parentns] {
    eval lappend result [TIP_listns $ns]
    lappend result $ns
  }
  return $result
}

proc TIP_suppressError {args} {
parse_proc_arguments -args $args results
  foreach argname [array names results] {
    foreach error $results($argname) {
    set_message -id $error -severity warn
    } 
  }
}

define_proc_arguments TIP_suppressError -info "Command Description" -define_args \
{{-id "Error ID help" "string_val" string optional}
}

proc TIP_invokeError {args} {
parse_proc_arguments -args $args results
  foreach argname [array names results] {
    foreach error $results($argname) {
    set_message -id $error -severity error 
    } 
  }
}

define_proc_arguments TIP_invokeError -info "Command Description" -define_args \
{{-id "Error ID help" "string_val" string optional}
}

proc TIP_applyDerate {} {
global VER
global Innovus_DerateMethod
global LIB_PROCESS_NODE
global DERATE_SLDC
global DERATE_SLDN
global DERATE_SLCC
global DERATE_SLCN
global DERATE_SEDC
global DERATE_SEDN
global DERATE_SECC
global DERATE_SECN
global DERATE_FLDC
global DERATE_FLDN
global DERATE_FLCC
global DERATE_FLCN
global DERATE_FEDC
global DERATE_FEDN
global DERATE_FECC
global DERATE_FECN
 
  if {$VER >= 20.1} {
           if {$Innovus_DerateMethod != 0} {
   	  if {$LIB_PROCESS_NODE <= 5 } {
              set_timing_derate -delay_corner max_delay_corner -late  -mean -data -cell_delay $DERATE_SLDC [get_lib_cells *]
              set_timing_derate -delay_corner max_delay_corner -late  -data -net_delay $DERATE_SLDN
              set_timing_derate -delay_corner max_delay_corner -late  -mean -clock -cell_delay $DERATE_SLCC [get_lib_cells *]
              set_timing_derate -delay_corner max_delay_corner -late  -clock -net_delay $DERATE_SLCN
              set_timing_derate -delay_corner max_delay_corner -early -mean -data -cell_delay $DERATE_SEDC [get_lib_cells *]
              set_timing_derate -delay_corner max_delay_corner -early -data -net_delay $DERATE_SEDN
              set_timing_derate -delay_corner max_delay_corner -early -mean -clock -cell_delay $DERATE_SECC [get_lib_cells *]
              set_timing_derate -delay_corner max_delay_corner -early -clock -net_delay $DERATE_SECN
    
              set_timing_derate -delay_corner min_delay_corner -late  -mean -data -cell_delay $DERATE_FLDC [get_lib_cells *]
              set_timing_derate -delay_corner min_delay_corner -late  -data -net_delay $DERATE_FLDN
              set_timing_derate -delay_corner min_delay_corner -late  -mean -clock -cell_delay $DERATE_FLCC [get_lib_cells *]
              set_timing_derate -delay_corner min_delay_corner -late  -clock -net_delay $DERATE_FLCN
              set_timing_derate -delay_corner min_delay_corner -early -mean -data -cell_delay $DERATE_FEDC [get_lib_cells *]
              set_timing_derate -delay_corner min_delay_corner -early -data -net_delay $DERATE_FEDN
              set_timing_derate -delay_corner min_delay_corner -early -mean -clock -cell_delay $DERATE_FECC [get_lib_cells *]
              set_timing_derate -delay_corner min_delay_corner -early -clock -net_delay $DERATE_FECN
   	  } else {
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
         }
}

proc TIP_verifyDRC {args} {
parse_proc_arguments -args $args results
  if {[llength $args] != 0} {
  foreach stage $results([array names results]) {
  redirect  $stage.drc -tee {set_verify_drc_mode -reset}
  redirect  $stage.drc -tee {set_verify_drc_mode -check_only all}
  redirect  $stage.drc -tee {verify_drc -limit 0}
  }
  } else {
  set_verify_drc_mode -reset
  set_verify_drc_mode -check_only all
  verify_drc -limit 0 -report ./drc.rpt
  }
}
define_proc_arguments TIP_verifyDRC -info "Command Description" -define_args \
{{-log_stage "String help" "string_val" string optional}
}

proc TIP_globalConnect {} {
  global Fplan_PowerNetName
  global Fplan_GroundNetName
  foreach vss_term [dbGet -u [dbGet -p1 head.allCells.pgTerms.type groundTerm].name] { 
    globalNetConnect $Fplan_GroundNetName -type pgpin -pin $vss_term -inst * 
  }
  foreach vdd_term [dbGet -u [dbGet -p1 head.allCells.pgTerms.type powerTerm].name] { 
    globalNetConnect $Fplan_PowerNetName -type pgpin -pin $vdd_term -inst * 
  }  
  globalNetConnect $Fplan_PowerNetName -type tiehi
  globalNetConnect $Fplan_GroundNetName -type tielo    
}

proc TIP_checkFP {} {
global VER
global LIB_PROCESS_NODE
global Innovus_FP_USE

if {$VER >= 21.12 && $LIB_PROCESS_NODE == 7 && $Innovus_FP_USE == 2} {
    if {[llength [dbget [dbget top.fplan.tracks.layers.name M0 -p2].mask 2 -e]] == 0} {
   puts "ERR DEF's M0 track has mask no mask 2, please check DEF file quality"
   exit
   }
   
   if {[llength [dbget [dbget top.pgNets.swires.layer.name M0 -p2].mask 2 -e]] == 0} {
   puts "ERR DEF's M0 has no mask 2, please regenerate PG grid"
   exit
   }
   }
}

proc TIP_checkUnplacedPin {} {
global unplaced_ios
setPlaceMode -placeIoPins false
foreach_in_collection p [get_ports *] {                                                                         
  redirect -variable stat {getPtnPinStatus -cell [dbGet top.name] -pin [get_property $p full_name]}
  Puts $stat
  if {[regexp {unplaced} $stat]==1} {
    incr unplaced_ios
    Puts [format "%s%s" "**ERR" "OR: Unplaced pin [get_property $p full_name]"]
  }
}
}

proc TIP_setRoutingLayer {} {
global Fplan_MaxRoutingLayer
  if {$Fplan_MaxRoutingLayer != 0} {
    setNanoRouteMode  -routeBottomRoutingLayer 1 -routeTopRoutingLayer $Fplan_MaxRoutingLayer
    setTrialRouteMode -maxRouteLayer $Fplan_MaxRoutingLayer
  } else {
    Puts [concat "**ERR" "OR: Please specify a max routing layer. Fplan_MaxRoutingLayer=0 in CadSetup.file"]
    exit
  }
}

proc TIP_setNanoRouteSettings {} {
global Innovus_RoutingFlow
global LIB_PROCESS_NODE
global LIB_TECH_NODE
global Fplan_MaxRoutingLayer
global LIB_TECH_NODE
global cell_height
  if {[regexp {tsmc28_7t_a} $Innovus_RoutingFlow]} {
        setNanoRouteMode -drouteUseMultiCutViaEffort none \
                         -routeWithLithoDriven false \
                         -drouteAutoStop false \
                         -drouteVerboseViolationSummary 1 \
                         -routeExpAdvancedPinAccess true  \
                         -routeWithViaInPin 1:2 \
                         -droutePostRouteSpreadWire none \
                         -droutePostRouteSwapVia false  \
                         -droutePostRouteWidenWire none \
                         -routeTopRoutingLayer 8 \
                         -routeBottomRoutingLayer 2 \
                         -routeWithTimingDriven false \
                         -routeWithSiDriven false \
                         -routeWithViaOnlyForStandardCellPin true \
                         -routeConcurrentMinimizeViaCountEffort none
        setPlaceMode -viaInPin true -checkPinLayerForAccess {1 2} -congEffort high
        generateTracks -honorPitch
  } elseif {[regexp {tsmc16_7t_a} $Innovus_RoutingFlow]} {
        setNanoRouteMode -drouteUseMultiCutViaEffort low
        setNanoRouteMode -drouteOnGridOnly "wire 4:7"
        setNanoRouteMode -routeBottomRoutingLayer 2
        setNanoRouteMode -routeAllowPinAsFeedthrough false
        setNanoRouteMode -routeWithViaOnlyForStandardCellPin 1:1
        generateTracks -m2HOffset 0.032
  } else {
        setNanoRouteMode -drouteUseMultiCutViaEffort high
        setGenerateViaMode -auto true
  } 
  if {$LIB_PROCESS_NODE == 10} {
        generateTracks -m2VOffset 0.011

        setNanoRouteMode -dbIgnoreFollowPinShape true
        setNanoRouteMode -drouteEndIteration default
        setNanoRouteMode -droutePostRouteSpreadWire false
        setNanoRouteMode -routeBottomRoutingLayer 2 -routeTopRoutingLayer $Fplan_MaxRoutingLayer
        setNanoRouteMode -routeBottomShieldLayer 4
        setNanoRouteMode -routeStrictlyHonorNonDefaultRule wire
        setNanoRouteMode -routeWithViaInPin 1:1
        setNanoRouteMode -drouteOnGridOnly "wire 4:8"
        setNanoRouteMode -routeConcurrentMinimizeViaCountEffort high
        setNanoRouteMode -drouteExpMinimizeClockTopologyChange true
        setNanoRouteMode -drouteMinimizeLithoEffectOnLayer "t t t"
        #setNanoRouteMode -drouteUseMultiCutViaEffort high # need to turn it on only for clock nets....disabling for now....
        setNanoRouteMode -envMacroObsAsRoutingBlockage auto
        setNanoRouteMode -drouteExpDynamicPinAccess true
        setNanoRouteMode -routeExpAdaptivePinAccess true
        setNanoRouteMode -drouteExpEnableBlockMaskRepair true
        setNanoRouteMode -drouteBottomMultiCutViaRoutingLayer 3

        setPlaceMode -spreadLevel 3
        setNanoRouteMode -routeWithViaOnlyForStandardCellPin "2:2" 
        setVar edi_pe::pegPreRouteConsiderImprovedExtraSpacingHandling 1
        setVar edi_pe::pegPreRouteConsiderNewNDRModeling 1
              setVar edi_pe::pegPreRouteEnableLowLayerDensityCorrection 2
              setVar edi_pe::pegPreRouteWireWidthBasedDensityCalModel 2
        }
    
  if {$LIB_PROCESS_NODE == 7} {
        set Fplan_MaxRoutingLayer [expr $Fplan_MaxRoutingLayer + 1]
        setRouteMode -earlyGlobalMaxRouteLayer $Fplan_MaxRoutingLayer
        setRouteMode -earlyGlobalNumTracksPerClockWire 4

        #setLimitedAccessFeature socv 1
        #setAnalysisMode -socv true
        setBetaFeature encEnable7nm 1
        setDesignMode -process 7 -node $LIB_TECH_NODE
        setNanoRouteMode -dbProcessNode N7
        setNanoRouteMode -routeTopRoutingLayer $Fplan_MaxRoutingLayer
        setNanoRouteMode -routeBottomRoutingLayer 2
        setRouteMode -earlyGlobalMinRouteLayer 2

        # Enable use of one site filler without diffusion
        setPlaceMode -place_detail_use_no_diffusion_one_site_filler true

        # Avoid 1:1 filler abutment
        setFillerMode -avoid_abutment_patterns "1:1 2:1"

        # All Process related setting's are set here
        setNanoRouteMode -dbProcessNode N7

        # Library specific Setting
        set cell_height [dbGet [dbGet -p head.libCells.name CKBD4BWP*].name]
        if {[regexp {360H} $cell_height]==1} {
        setNanoRouteMode -routeExpWithTrimMetal "-layer 2 \
                -mask2 {-pitch 0.36 -core_offset 0.275 -width 0.03 } \
                -mask2 {-pitch 0.36 -core_offset 0.155 -width 0.03 } \
                -mask2 {-pitch 0.36 -core_offset 0.045 -width 0.03 } \
                -mask1 {-pitch 0.12 -core_offset 0.000 -width 0.03 }"
        } elseif {[regexp {300H} $cell_height]==1} {
        setNanoRouteMode -routeExpWithTrimMetal "-layer 2 \
                -mask2 {-pitch 0.30 -core_offset 0.065 -width 0.03 } \
                -mask2 {-pitch 0.30 -core_offset 0.235 -width 0.03 } \
                -mask1 {-pitch 0.30 -core_offset 0.025 -width 0.03 } \
                -mask1 {-pitch 0.30 -core_offset 0.195 -width 0.03 }"
        } else {
        setNanoRouteMode -routeExpWithTrimMetal "-layer 2 \
                -mask2 {-pitch 0.24 -core_offset 0.225 -width 0.03 } \
                -mask2 {-pitch 0.24 -core_offset 0.095 -width 0.03 } \
                -mask1 {-pitch 0.24 -core_offset 0.015 -width 0.03 } \
                -mask1 {-pitch 0.24 -core_offset 0.145 -width 0.03 }"
        }

  if {[regexp {240H} $cell_height]==1} {
    add_tracks -pitch_pattern {M0 offset 0.0 pitch 0.06 {pitch 0.04 repeat 3} pitch 0.06 pitch 0.06 {pitch 0.04 repeat 3} pitch 0.06} -mask_pattern {{M0 1 2 1 2 1 2 1 2 1} {M1 2 1} {M2 2 1} {M3 1 2}} -offset {M2 horiz 0.02}
  }

  # Disable postRoute wireSpreading, If FlowEffort is set to high/extreme
  #If needed you can set it to true
  setNanoRouteMode -droutePostRouteSpreadWire false

  # To reduce the via count while routing
  setNanoRouteMode -routeConcurrentMinimizeViaCountEffort high

  # To add Tapping via for the specified distance for shielding
  setNanoRouteMode  -routeExpShieldAddTappingVia true

  # To optimize/cleanup unused or unoptimized Patch
  setNanoRouteMode -drouteExpOptimizeTrimPatch true

       # To access M2 MACRO pin with VIA only
       setNanoRouteMode -routeWithViaOnlyForMacroCellPin 2:2

       # This is default now under N7. This to allow multiple NDR on a net for EM fixing
       setNanoRouteMode -drouteUseLefPinTaperRule true

       setNanoRouteMode -drouteUseMultiCutViaEffort default

       setNanoRouteMode -envMacroObsAsRoutingBlockage min
 } 

  if {$LIB_PROCESS_NODE == 5} {
        set Fplan_MaxRoutingLayer [expr $Fplan_MaxRoutingLayer + 1]
        setRouteMode -earlyGlobalMaxRouteLayer $Fplan_MaxRoutingLayer
        setDesignMode -flowEffort standard -process 5 -node $LIB_TECH_NODE
        setNanoRouteMode -dbProcessNode N5
        
        # N5 H210 Library
        set cell_height_210 [dbGet [dbGet -p head.libCells.name CKBD4BWP*].name]
        if ([regexp {210H} $cell_height_210]==1) {
          setFPlanMode -checkTypes oddEvenSiteRow
          setFPlanMode -rowSiteWidth odd
          setFPlanMode -rowSiteHeight even
          add_tracks -width_pitch_pattern {M0 offset 0.0 width 0.056 pitch 0.049 {width 0.014 pitch 0.028 repeat 4} width 0.014 pitch 0.049 } -mask_pattern {M0 1 2 1 2 1 2 M1 2 1 M2 1 2 M3 1 2 M4 1 2} -offsets {M1 vert die_box 0.0085 M2 horiz 0 M3 vert die_box 0.0085 M4 horiz 0 M5 vert 0 M6 horiz 0 M7 vert 0 M8 horiz 0 M9 vert 0 M10 horiz 0 M11 vert 0 M12 horiz 0 M13 vert 0 M14 horiz 0 M15 vert 0 M16 horiz 0}
          setPreference ConstraintUserYGrid 0.028
          setPreference ConstraintUserXGrid 0.051
        }
        # N5 H280 Library
        set cell_height_280 [dbGet [dbGet -p head.libCells.name CKBKAD1BWP*].name]
        if ([regexp {280H} $cell_height_280]==1) {
          add_tracks -offsets {M1 vert 0.0285} -mask_pattern {{M1 1 2} {M2 1 2}}
          setPreference ConstraintUserYGrid 0.035
          setPreference ConstraintUserXGrid 0.057
        }
        
        setFPlanMode -snapDieGrid userDefine
        setFPlanMode -snapCoreGrid userDefine
        setFPlanMode -snapIoGrid userDefine
        setFPlanMode -snapBlockGrid userDefine	
 
        # Implant rule
        setPlaceMode -place_global_place_io_pins true
        setPlaceMode -place_detail_no_filler_without_implant true
        setPlaceMode -place_detail_use_no_diffusion_one_site_filler true
 
        # More spreading might be helpful for DRC's in high density designs, whilst sacrificing wirelength/power/timing
        setPlaceMode -place_global_initial_padding_level 4
 
        # EEQ Flow for EEQ Library
        setPlaceMode -place_detail_swap_eeq_cells true
 
        setRouteMode -earlyGlobalMaxRouteLayer $Fplan_MaxRoutingLayer
        setNanoRouteMode -routeTopRoutingLayer $Fplan_MaxRoutingLayer
        setVar mustjoinallports_is_one_pin 1
        setGenerateViaMode -auto true
        setGenerateViaMode -advanced_rule true
        setNanoRouteMode -routeBottomRoutingLayer 2
        setNanoRouteMode -drouteUseMultiCutViaEffort high
        setNanoRouteMode -routeWithViaInPin 1:1
        setNanoRouteMode -droutePostRouteSwapVia none
        setNanoRouteMode -droutePostRouteWidenWire false
        setNanoRouteMode -droutePostRouteSpreadWire false
  }

if {$LIB_PROCESS_NODE == 3} {
        set Fplan_MaxRoutingLayer [expr $Fplan_MaxRoutingLayer + 1]
        setRouteMode -earlyGlobalMaxRouteLayer $Fplan_MaxRoutingLayer
        setDesignMode -flowEffort standard -process 3 -node $LIB_TECH_NODE
        setNanoRouteMode -dbProcessNode N3E
        
        source ../scripts/innovus/Innovus_DFM_flow.cmd 
        set cell_name [TIP_get_cellname_postfix]

        # Implant rule
        setPlaceMode -place_global_place_io_pins true
        setPlaceMode -place_detail_no_filler_without_implant true
        setPlaceMode -place_detail_use_no_diffusion_one_site_filler true

        # More spreading might be helpful for DRC's in high density designs, whilst sacrificing wirelength/power/timing
        setPlaceMode -place_global_initial_padding_level 4
 
        # EEQ Flow for EEQ Library
        setPlaceMode -place_detail_swap_eeq_cells true
 
        setRouteMode -earlyGlobalMaxRouteLayer $Fplan_MaxRoutingLayer
        setNanoRouteMode -routeTopRoutingLayer $Fplan_MaxRoutingLayer
        setVar mustjoinallports_is_one_pin 1
        setGenerateViaMode -auto true
        setGenerateViaMode -advanced_rule true
        setNanoRouteMode -drouteUseMultiCutViaEffort high
        setNanoRouteMode -droutePostRouteSwapVia none
        setNanoRouteMode -droutePostRouteWidenWire false
        setNanoRouteMode -droutePostRouteSpreadWire false
        setNanoRouteMode -grouteExpTdPostfixUseParallelRouting true
        setNanoRouteMode -grouteExpTdPostfixParallelRoutingDistancePercentage 50.0

        set cell_name [lindex [dbGet -u head.libCells.name *BWP*] 0]
        if {[regexp BWP143 $cell_name]} {
          setFPlanMode -defaultRowPatternSite coreW48M143H286 -firstRowSiteIndex 0 -lastRowSiteIndex 0
          setFPlanMode -rowSiteHeight computed
          setFPlanMode -rowHeightMultiple 2
          setFPlanMode -rowHeightIncrementCornerToCorner 3
          setFPlanMode -rowHeightIncrementIncornerToCorner 0
          setFPlanMode -rowHeightIncrementIncornerToIncorner 5
          setFPlanMode -initAllCompatibleCoreSiteRows true
          setPreference ConstraintUserYGrid 0.572
          setPreference ConstraintUserXGrid 0.048
          setFPlanMode -snapDieGrid userDefine 
          setFPlanMode -snapCoreGrid userDefine
          setNanoRouteMode -routeBottomRoutingLayer 1
          setNanoRouteMode -routeWithViaInPin false
        } elseif {[regexp BWP169H3P48 $cell_name]} {
          setFPlanMode -rowSiteHeight even 
          setFPlanMode -rowHeightMultiple 2
          setFPlanMode -rowHeightIncrementCornerToCorner 4
          setFPlanMode -rowHeightIncrementIncornerToCorner 0
          setFPlanMode -rowHeightIncrementIncornerToIncorner 4
          setFPlanMode -initAllCompatibleCoreSiteRows true
          setPreference ConstraintUserYGrid 0.338
          setPreference ConstraintUserXGrid 0.048
          setFPlanMode -snapDieGrid userDefine 
          setFPlanMode -snapCoreGrid userDefine
          setNanoRouteMode -routeBottomRoutingLayer 2
          setNanoRouteMode -routeWithViaInPin 1:1
        } elseif {[regexp BWP169H3P54 $cell_name]} {
          setFPlanMode -rowSiteHeight even 
          setFPlanMode -rowHeightMultiple 2
          setFPlanMode -rowHeightIncrementCornerToCorner 4
          setFPlanMode -rowHeightIncrementIncornerToCorner 0
          setFPlanMode -rowHeightIncrementIncornerToIncorner 4
          setFPlanMode -initAllCompatibleCoreSiteRows true
          setPreference ConstraintUserYGrid 0.338
          setPreference ConstraintUserXGrid 0.054
          setFPlanMode -snapDieGrid userDefine 
          setFPlanMode -snapCoreGrid userDefine
          setNanoRouteMode -routeBottomRoutingLayer 1
          setNanoRouteMode -routeWithViaInPin false
          setNanoRouteMode -routeExpwithEdr true
        }
  } 
}

proc TIP_setDerateSettings {} {
global Innovus_DerateMethod
global VER
global LIB_PROCESS_NODE
global Innovus_UltraAccuracyMode


  if {[info exists Innovus_DerateMethod] && ($Innovus_DerateMethod == 2)} {
    if {$VER >= 16.22 && $VER < 17.10} {
        set_global timing_enable_backward_compatible_aocv_mode false
    }
    setAnalysisMode -aocv true -analysisType onChipVariation -cppr both
    set_global timing_aocv_derate_mode aocv_additive
    set_global timing_aocv_enable_gba_combine_launch_capture true
    set_global timing_aocv_analysis_mode combine_launch_capture
    set_global timing_enable_aocv_slack_based true
    set_global timing_enable_aocv_accurate_mode true
    set_global timing_aocv_slack_threshold 0.0
  }
  
  if {[info exists Innovus_DerateMethod] && ($Innovus_DerateMethod == 3)} {
    if {$VER < 17.10} {
      Puts [concat "**ERR" "Please apply Innovus 17.1 or above for LVF library to enable SOCV"]
      exit
    }
    setAnalysisMode -socv true -analysisType onChipVariation -cppr both
    set_global timing_socv_view_based_nsigma_multiplier_mode true
    set_socv_reporting_nsigma_multiplier -setup 3 -hold 3
    if {$LIB_PROCESS_NODE <= 5} {
      set timing_library_hold_sigma_multiplier 0
      set timing_library_gen_hold_constraint_table sigma
      setDelayCalMode -socv_accuracy_mode low -socv_lvf_mode moments
    } else {
      setDelayCalMode -socv_accuracy_mode low -socv_lvf_mode early_late
    }
    set_global timing_socv_statistical_min_max_mode mean_and_three_sigma_bounded
    set timing_report_enable_verbose_ssta_mode true
    set timing_socv_rc_variation_mode true
    set_socv_rc_variation_factor -early 0.1 
    set_socv_rc_variation_factor -late 0.1
    if {$LIB_PROCESS_NODE == 5 && $Innovus_UltraAccuracyMode == 1} {
      setDelayCalMode -accuracy_level 3 -socv_accuracy_mode ultra -advanced_pincap_mode 2 -socv_machine_learning_level 1
      set_global timing_cppr_threshold_ps 3
    }
    if {$LIB_PROCESS_NODE <= 3 && $Innovus_UltraAccuracyMode == 1} {
      setDelayCalMode -accuracy_level 3 -socv_accuracy_mode ultra -advanced_pincap_mode 2 -socv_machine_learning_level 1 -socv_lvf_mode adjusted_moments 
      set_global timing_cppr_threshold_ps 3
      set timing_socv_statistical_min_max_mode mean_and_three_sigma_bounded 
      setDelayCalMode -socv_use_lvf_tables {delay slew constraint} 
    }
  
    if {$LIB_PROCESS_NODE == 7 && $Innovus_UltraAccuracyMode == 1} {
      setDelayCalMode -advanced_pincap_mode 2 -socv_machine_learning_level 1 -socv_accuracy_mode ultra 
    }
  }
}

proc TIP_constrainTVF {} {
global fusa_mingap
global fusa_gap
global tvf_space_x
global tvf_space_y

setNanoRouteMode -routeHonorExclusiveRegion true
setPlaceMode -hardFence true
setOptMode -honorFence true

deselectAll
selectObject Module Core0
set bbox [dbget selected.boxes ]
  if {[llength [dbget selected.name ]]} {
   set cmd "create_group -name TOP_Core0 -type region -rects $bbox "
   eval $cmd
   } else {
   puts "There's no Core0 fence in DEF file, please check and rerun"
   exit
  }
deselectAll
selectObject Module Core1
set bbox [dbget selected.boxes ]
  if {[llength [dbget selected.name ]]} {
  set cmd "create_group -name TOP_Core1 -type region -rects $bbox"
  eval $cmd
  } else {
  puts "There's no Core1 fence in DEF file, please check and rerun"
  exit
  }
deselectAll

createExclusiveGroups TOP_Core0 -exclusiveGroups TOP_Core1 -min_gap $fusa_mingap -gap $fusa_gap
 
foreach m [dbGet top.hInst.HInsts.name ] {
  if {$m =="Core0"} {
  update_group -name TOP_Core0 -add -objs [dbget top.insts.name Core0/*]
  } elseif {$m =="Core1"} {
   update_group -name TOP_Core1 -add -objs [dbget top.insts.name Core1/*]
  } 
}
         
setRouteMode -earlyGlobalRoutePartitionHonorFence Core0
setRouteMode -earlyGlobalRoutePartitionHonorFence Core1 
set i 0
set TV [open ../syn_genus/Xtsubsystem_syn.scanchains r]
set TV_data [read $TV]
set TVF [split $TV_data "\n"]

  foreach lines $TVF {
    if [regexp TV_FLOP_ff1 $lines] {
    set tvflop [lindex $lines 2]
    set tvflop2 [regsub {TV_FLOP_ff1} $tvflop {TV_FLOP_ff2}]
    set tvflop3 [regsub {TV_FLOP_ff1} $tvflop {TV_FLOP_ff3}]
    set cmd "create_inst_space_group tvf_$i -inst {$tvflop $tvflop2 $tvflop3}  -spacing_x $tvf_space_x -spacing_y $tvf_space_y "
    puts $cmd
    eval $cmd
    set i [expr $i +1]
    }
  }


  setPlaceMode -place_detail_check_inst_space_group true
  setRouteMode -earlyGlobalHonorMsvRouteConstraint true
}
