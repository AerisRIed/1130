#############################################################################################
#        Copyright (c) 2008-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

TIP_create_libs $lib_config

eval "read_lib \"$[lindex [lindex $lib_config 0] 1]\""
if {$TSO_FLOW} {
  read_lib -lef "$lef_file" 
}

read_verilog ${FILE_NAME_PREFIX}_netlist.v

set init_pwr_net "$Fplan_PowerNetName"
set init_gnd_net "$Fplan_GroundNetName"

set_top_module $TOP_DESIGN

foreach vss_term [dbGet -u [dbGet -p1 head.allCells.pgTerms.type groundTerm].name] { 
  globalNetConnect $Fplan_GroundNetName -type pgpin -pin $vss_term -inst * 
}
foreach vdd_term [dbGet -u [dbGet -p1 head.allCells.pgTerms.type powerTerm].name] { 
  globalNetConnect $Fplan_PowerNetName -type pgpin -pin $vdd_term -inst * 
}  
globalNetConnect $Fplan_PowerNetName -type tiehi
globalNetConnect $Fplan_GroundNetName -type tielo 

set_analysis_mode -analysisType onChipVariation -cppr both

set extra_args ""
if {$TSO_FLOW} {
  set def_file "${FILE_NAME_PREFIX}_routed.def"
  read_def $def_file
}
if {$USE_POWER_LIBRARY} {
  set extra_args "-dynamic $typ_view"
} else {
  set extra_args "-dynamic $setup_views"
}

eval "set_analysis_view -setup $setup_views -hold $hold_views -leakage $leakage_view $extra_args"

report_analysis_views

if {$Innovus_DerateMethod==3} {
  set_analysis_mode -socv true
  set timing_report_enable_verbose_ssta_mode true
  set_global timing_socv_view_based_nsigma_multiplier_mode true
  set_socv_reporting_nsigma_multiplier -setup 3 -hold 3
  set timing_socv_statistical_min_max_mode mean_and_three_sigma_bounded
  if { $LIB_PROCESS_NODE == 5} {
    set_delay_cal_mode -socv_accuracy_mode low -socv_lvf_mode moments 
  } elseif {$LIB_PROCESS_NODE == 3} {
    set_global timing_enable_socv_skewness_propagation_mode true
    set_delay_cal_mode -socv_accuracy_mode low -socv_lvf_mode adjusted_moments -socv_slew_induced_variation_mode 3 -socv_use_lvf_tables {delay slew constraint}
  } else {
     set_delay_cal_mode -socv_accuracy_mode low -socv_lvf_mode early_late
  }
  if {($LIB_PROCESS_NODE <= 5) && ($Innovus_UltraAccuracyMode == 1)} {
    set_delay_cal_mode -accuracy_level 3 -socv_accuracy_mode ultra -advanced_pincap_mode 2 -socv_machine_learning_level 1
    set_global timing_cppr_threshold_ps 3  
  }
  if {($LIB_PROCESS_NODE == 7) && ($Innovus_UltraAccuracyMode == 1)} {
    set_delay_cal_mode -advanced_pincap_mode 2 -socv_machine_learning_level 1 -socv_accuracy_mode ultra 
  }
  #Following TSMC Recommendation degrading performance and impacting run-time
  #set_delay_cal_mode -socv_accuracy_mode ultra -socv_moments_quantile_mode 1 -socv_delay_slew_correlation_mode 2 -socv_use_lvf_tables {delay slew}
  set timing_socv_rc_variation_mode true
  set_socv_rc_variation_factor -early 0.1 
  set_socv_rc_variation_factor -late 0.1
}

########################
## Reading SPEFs
########################
set spef_map(setup) max
set spef_map(hold) min
set spef_map(typ) typ
set spef_map(leakage) min
foreach rc_corner [all_rc_corners -active] {
  set rc_name [string map {"_rc_corner" ""} $rc_corner]
  if {[file exists ${FILE_NAME_PREFIX}_verify_$spef_map(${rc_name}).spef]} { 
    read_spef -starN -rc_corner $rc_corner ${FILE_NAME_PREFIX}_verify_$spef_map(${rc_name}).spef
  } else {
    Puts "${FILE_NAME_PREFIX}_verify_$spef_map(${rc_name}).spef not found, using $setup_views instead"
    read_spef -starN -rc_corner $rc_corner ${FILE_NAME_PREFIX}_verify_$spef_map(${setup_views}).spef
  }
}

########################
##Settings
########################
if {$TEMPUS_SI} {
  set_delay_cal_mode -engine aae -SIAware true
  set_si_mode -individual_attacker_threshold 0.0125 -separate_delta_delay_on_data true  -individual_attacker_simulation_filtering true 
  set_si_mode -switch_prob 0.3 -accumulated_small_attacker_mode current -accumulated_small_attacker_threshold 0.05 -accumulated_small_attacker_sigma 2
  if {$VER >= 17} {
    set_si_mode -delay_only true -enable_logical_correlation true -si_reselection all -clocks synchronous -attacker_alignment timing_aware_edge
  }  else {
    set_si_mode -delay_only true -enable_logical_correlation_in_delay true -si_reselection all -clocks synchronous -attacker_alignment path
  } 
}

if {$TEMPUS_WFP == 1 && $LIB_PROCESS_NODE < 30} {
  if {$VER >= 18} {
    set_delay_cal_mode -equivalent_waveform_model propagation -ewm_type simulation 
  } elseif {$VER >= 17} {
    set_delay_cal_mode -equivalent_waveform_model propagation 
  }  else {
    set_delay_cal_mode -equivalent_waveform_model_type ecsm -equivalent_waveform_model_propagation true
  }   
}

if {$LIB_PROCESS_NODE < 20} {
  set_delay_cal_mode -enable_quiet_receivers_for_hold true
}

source [glob final.enc.dat/mmmc/pathgroup.sdc*]

########################
## Apply deratings
########################
set WORST_CORNER_DERATE 2
if {$Innovus_DerateMethod != 0} {
  source -verbose ../scripts/tempus/Tempus_derate.tcl
}

################################################
## Set clock uncertainty and update IO latency
################################################
set_interactive_constraint_modes [all_constraint_modes -active]

reset_propagated_clock [get_property [all_clocks] sources]
reset_propagated_clock [all_clocks]

set j 0
foreach CP $CLK_PORT {
  set i [expr $j + 1]
  if {[sizeof_collection [get_clocks -quiet CLK$i]]!=0} {
    set CLK_SOURCE_PORT [get_clock_source CLK$i]
    if {[lindex $CLK_FREQ $j] != 0} {
      set CLOCK_PERIOD [expr 1000.0/[lindex $CLK_FREQ $j]]
      create_clock $CLK_SOURCE_PORT -name CLK$i -period $CLOCK_PERIOD
    }
    reset_propagated_clock CLK$i
    reset_propagated_clock [get_clock_source CLK$i]
    reset_clock_uncertainty CLK$i
    if {$CLOCK_JITTER != 0} {
      set_clock_uncertainty -setup $CLOCK_JITTER [get_clocks CLK$i]
    }
    if {$HOLD_MARGIN != 0} {
      set_clock_uncertainty -hold $HOLD_MARGIN [get_clocks CLK$i]
    }
  }
  incr j
}

if {[sizeof_collection [get_ports -quiet $JTAG_CLK_PORT]]!=0} {
  set JTCK_SOURCE_PORT [get_clock_source $JTAG_CLK_PORT]
  if {$JTAG_CLK_FREQ != 0} {
    set JTAG_CLK_PERIOD [expr 1000.0/[lindex $JTAG_CLK_FREQ $j]]
    create_clock $JTCK_SOURCE_PORT -name JTCK -period $JTAG_CLK_PERIOD
  }
  reset_propagated_clock $JTAG_CLK_PORT
  reset_propagated_clock [get_ports -quiet $JTAG_CLK_PORT]
  reset_clock_uncertainty $JTAG_CLK_PORT
  if {$CLOCK_JITTER != 0} {
    set_clock_uncertainty -setup $CLOCK_JITTER [get_clocks $JTAG_CLK_PORT]
  }
  if {$HOLD_MARGIN != 0} {
    set_clock_uncertainty -hold $HOLD_MARGIN [get_clocks $JTAG_CLK_PORT]
  }
}

if {[sizeof_collection [get_ports -quiet PMDA_TCK]]!=0} {
  reset_propagated_clock PMDA_TCK
  reset_propagated_clock [get_ports -quiet PMDA_TCK]
  reset_clock_uncertainty PMDA_TCK
  if {$CLOCK_JITTER != 0} {
    set_clock_uncertainty -setup $CLOCK_JITTER [get_clocks PMDA_TCK]
  }
  if {$HOLD_MARGIN != 0} {
    set_clock_uncertainty -hold $HOLD_MARGIN [get_clocks PMDA_TCK]
  }
}

set_interactive_constraint_modes {}
update_io_latency -verbose

#######################
#SETUP REPORTING
#######################
set timing_path_based_exhaustive_max_paths_limit 20000000
set_global timing_pba_exhaustive_path_nworst_limit 500
if {$TEMPUS_PBA == 1} {
  set_pba_mode -epba_bounded_mode true
  set_pba_mode -ipba_endpoints_max_limit 500
  set_global timing_disable_retime_clock_path_slew_propagation true
}

set timing_path_based_enable_exhaustive_depth_bounded_by_gba false
set_global report_timing_format {instance arc cell load fanout delay incr_delay arrival annotation}

if {$Innovus_DerateMethod == 2} {
  set_global timing_aocv_analysis_mode combine_launch_capture
  set report_timing_format_prepba "instance arc cell load fanout aocv_derate delay incr_delay arrival annotation user_derate"
  set extra_parameters "-retime aocv -retime_mode exhaustive"

  set report_timing_format_postpba "instance arc cell load fanout aocv_derate retime_delay incr_delay arrival annotation user_derate"
  set retime_pba "aocv_path_slew_propagation"
} else {
  if {$Innovus_DerateMethod == 3} {
    set report_timing_format_prepba "instance arc cell load fanout delay_mean delay_sigma delay incr_delay arrival annotation user_derate"
    set report_timing_format_postpba "instance arc cell load fanout delay_mean delay_sigma retime_delay incr_delay arrival annotation user_derate"
  } else {
    set report_timing_format_prepba "instance arc cell load fanout delay incr_delay arrival annotation user_derate"
    set report_timing_format_postpba "instance arc cell load fanout retime_delay incr_delay arrival annotation user_derate"
  } 
  set extra_parameters ""
  set retime_pba "path_slew_propagation"
}

if {$TSO_FLOW} {
  set report_suffix "_tso"
} else {
  set report_suffix ""
}

## GBA report
set_global report_timing_format $report_timing_format_prepba
eval "report_timing -view $setup_views -max_paths $TEMPUS_NUM_PATHS -max_slack 1000 -path_type full_clock $extra_parameters > ${FILE_NAME_PREFIX}_verify${report_suffix}.timing"

report_timing_summary > ${FILE_NAME_PREFIX}_verify${report_suffix}.timing_summary

if {$TEMPUS_PBA > 0} {
  ## PBA reports
  set_global report_timing_format $report_timing_format_postpba
  report_timing -view $setup_views -max_paths $TEMPUS_NUM_PATHS -max_slack 1000 -path_type full_clock -retime $retime_pba -retime_mode exhaustive > ${FILE_NAME_PREFIX}_verify${report_suffix}.recalc_timing
  
  report_analysis_summary -view $setup_views -late -retime $retime_pba -retime_mode exhaustive > ${FILE_NAME_PREFIX}_verify${report_suffix}.recalc_timing_summary
  report_constraint -all_violators -view $setup_views -retime $retime_pba -retime_mode exhaustive > ${FILE_NAME_PREFIX}_verify${report_suffix}.viol
}

if {$TEMPUS_GENERATE_ETM == 1} {
  TIP_dump_id_per_wns_port setup $Innovus_DerateMethod $FILE_NAME_PREFIX $setup_views $hold_views
}

if {$TEMPUS_WRITE_SDF == 1} {
  write_sdf -view $setup_views -nonegchecks -filter -collapse_internal_pins ${FILE_NAME_PREFIX}_verify.sdf
}

report_annotated_parasitics -view $setup_views > ${FILE_NAME_PREFIX}_verify${report_suffix}.rpt.parasitics

report_power -clock_gating_efficiency -print_memory_power -outfile ${FILE_NAME_PREFIX}_verify${report_suffix}.power.rpt

#This proc is defined in Tempus_utils.tcl
TIP_calculate_insertion_delay ${FILE_NAME_PREFIX}_verify${report_suffix}.clock_insertion_delays $setup_views

check_timing -view $setup_views > ${FILE_NAME_PREFIX}_verify${report_suffix}.rpt.timing

report_analysis_coverage -exclude const -view $setup_views > ${FILE_NAME_PREFIX}_verify${report_suffix}.rpt.coverage

set i 1
foreach CP $CLK_PORT {
  if {[sizeof_collection [get_clocks -quiet CLK$i]]!=0} {
    redirect [format "%s%s%s" $FILE_NAME_PREFIX "_verify.clock_" $i] {report_clock_timing -type summary -clock CLK$i -view $setup_views -late}
  }
  incr i
}
redirect /dev/null {set DEBUG_CLOCK_PORT [get_ports -quiet $JTAG_CLK_PORT]}
if {$DEBUG_CLOCK_PORT != [list]} {
  redirect [format "%s%s" $FILE_NAME_PREFIX "_verify.debug_clock"] {report_clock_timing -type summary -clock $JTAG_CLK_PORT -view $setup_views -late}
}
redirect /dev/null {set MBIST_CLOCK_PORT [get_ports -quiet "PMDA_TCK"]}
set MCCount [sizeof_collection $MBIST_CLOCK_PORT]
if {$MBIST_CLOCK_PORT != [list]&& $MCCount > 0} {
  redirect [format "%s%s" $FILE_NAME_PREFIX "_verify.mbist_clock"] {report_clock_timing -type summary -clock PMDA_TCK -view $setup_views -late}
}

#######################
#HOLD REPORTING
#######################
set_global timing_pba_exhaustive_path_nworst_limit 50

if {$TEMPUS_PBA == 1} {
  set_pba_mode -ipba_endpoints_max_limit 50
}

if {$Innovus_DerateMethod != 2} {
  set_global timing_aocv_analysis_mode separate_data_clock
}

## GBA report
set_global report_timing_format $report_timing_format_prepba
eval "report_timing -early -view $hold_views -max_paths $TEMPUS_NUM_PATHS -max_slack 0 -path_type full_clock $extra_parameters > ${FILE_NAME_PREFIX}_verify${report_suffix}.min.timing"

## PBA reports
if {$TEMPUS_PBA > 0} {
  set_global report_timing_format $report_timing_format_postpba
  report_timing -early -view $hold_views -max_paths $TEMPUS_NUM_PATHS -max_slack 1000 -path_type full_clock -retime $retime_pba -retime_mode exhaustive > ${FILE_NAME_PREFIX}_verify${report_suffix}.min.recalc_timing

  report_analysis_summary -view $hold_views -early -retime $retime_pba -retime_mode exhaustive > ${FILE_NAME_PREFIX}_verify${report_suffix}.min.recalc_timing_summary
  report_constraint -all_violators -early -view $hold_views -retime $retime_pba -retime_mode exhaustive > ${FILE_NAME_PREFIX}_verify${report_suffix}.min.viol
}

if {$TEMPUS_GENERATE_ETM == 1} {
  TIP_dump_id_per_wns_port hold $Innovus_DerateMethod $FILE_NAME_PREFIX $setup_views $hold_views
}
if {$TEMPUS_WRITE_SDF == 1} {
  write_sdf -view $hold_views -nonegchecks -filter -collapse_internal_pins ${FILE_NAME_PREFIX}_verify.min.sdf
}

#This proc is defined in Tempus_utils.tcl
TIP_calculate_insertion_delay ${FILE_NAME_PREFIX}_verify${report_suffix}.min.clock_insertion_delays $hold_views

set i 1
foreach CP $CLK_PORT {
  if {[sizeof_collection [get_clocks -quiet CLK$i]]!=0} {
    redirect [format "%s%s%s" $FILE_NAME_PREFIX "_verify.min.clock_" $i] {report_clock_timing -type summary -clock CLK$i -view $hold_views}
  }
  incr i
}
if {$DEBUG_CLOCK_PORT != [list]} {
  redirect [format "%s%s" $FILE_NAME_PREFIX "_verify.min.debug_clock"] {report_clock_timing -type summary -clock $JTAG_CLK_PORT -view $hold_views}
}
if {$MBIST_CLOCK_PORT != [list]&& $MCCount > 0} {
  redirect [format "%s%s" $FILE_NAME_PREFIX "_verify.min.mbist_clock"] {report_clock_timing -type summary -clock PMDA_TCK -view $hold_views}
}


#######################
#ETM Generate
#######################
if {$TEMPUS_GENERATE_ETM == 1 && $TSO_FLOW == 0} {
  #Recommended to generate ETM in pba mode
  set_global timing_extract_model_slew_propagation_mode path_based_slew 

  if {$TEMPUS_WFP == 1} {
    set_global timing_extract_model_enable_waveform_propagation true
  }
  if {$Innovus_DerateMethod == 2} {
    set timing_extract_model_aocv_mode path_based
  }
  
  #Recommended to reset drive and driving cells
  set_interactive_constraint_modes [all_constraint_modes -active]
  reset_drive *
  reset_driving_cell *
  set_interactive_constraint_modes {}

  #Other recommendations for ETM 
  set_global timing_enable_timing_window_pessimism_removal  false
  set_global timing_enable_spatial_derate_mode false

  foreach view $lib_config {
    set view_name [lindex $view 0]
    if {($view_name == $typ_view && $USE_POWER_LIBRARY == 0) || ($view_name == $leakage_view)} {
      continue
    }
    set_analysis_view -setup $view_name -hold $view_name
    set rc_corner [get_delay_corner -rc_corner ${view_name}_delay_corner]
    if {[file exists ${FILE_NAME_PREFIX}_verify_$spef_map(${view_name}).spef]} { 
      read_spef -starN -rc_corner $rc_corner ${FILE_NAME_PREFIX}_verify_$spef_map(${view_name}).spef
    } else {
      Puts "${FILE_NAME_PREFIX}_verify_$spef_map(${view_name}).spef not found, using $setup_views instead"
      read_spef -starN -rc_corner $rc_corner ${FILE_NAME_PREFIX}_verify_$spef_map(${setup_views}).spef
    }
    set opcond [set [lindex $view 3]]

    set outdir etm_[string toupper $view_name]
    catch {rm -rf $outdir}
    catch {exec mkdir $outdir}
    update_timing -full

    set libname "${FILE_NAME_PREFIX}_${opcond}"

    #setting higher tolerance values for validation
    do_extract_model $outdir/${libname}_etm.lib -verilog_shell_file $outdir/etm.v -verilog_shell_module etm -assertions $outdir/model.asrt -view $view_name -pg -validate val.$outdir -abs_tol_val 0.02 -per_tol_val 3 -lib_name $libname
  } 
}

if {$TSO_FLOW} {
  if {$TEMPUS_TSO_OPT > 0 } {
    set_interactive_constraint_modes [all_constraint_modes -active]
    foreach lib_cel $LIB_DONT_USE {
      set_dont_use $lib_cel true
    }
    set_interactive_constraint_modes {}
  }
  if {$TEMPUS_TSO_OPT == 1 } {
    set_eco_opt_mode -verbose true -eco_file_prefix LEAK -optimize_sequential_cells true -enableIncrDelayFixes true -lkgExtTcf dummy.tcf
    set_eco_opt_mode -resize_inst true -add_inst true -retime $retime_pba -swap_inst true -check_type both -retime_mode exhaustive
    if {($Lib_CNODEdge_Info ne {}) && ($Lib_MinCNODLeak_Info ne {}) && ($Lib_CNODLeak_Config ne {})} {
      load_side_file -files [list $Lib_CNODEdge_Info $Lib_MinCNODLeak_Info $Lib_CNODLeak_Config] -dump_tcl_file lef_side_file.tcl
      source lef_side_file.tcl
      set cmd "cat $Lib_MinCNODLeak_Info $Lib_CNODLeak_Config > all_lib_side_file.txt"
      eval exec $cmd
      set_power_analysis_mode -view $leakage_view -boundary_gate_leakage_file all_lib_side_file.txt -write_static_currents true -boundary_gate_leakage_report true -boundary_leakage_multi_pgpin_support true -boundary_leakage_PXE_support true
    } else {
      set_power_analysis_mode -view $leakage_view
    }
    eco_opt_design -leakage 
  }
  
  if {$TEMPUS_TSO_OPT == 2 } {
    set_eco_opt_mode -verbose true -eco_file_prefix SETUP -optimize_sequential_cells true -enableIncrDelayFixes true
    set_eco_opt_mode -resize_inst true -add_inst true -retime $retime_pba -swap_inst true -check_type both -retime_mode exhaustive
    eco_opt_design -setup 
  }
  
  if {$TEMPUS_TSO_OPT == 3 } {
    set_eco_opt_mode -verbose true -eco_file_prefix HOLD -optimize_sequential_cells true -enableIncrDelayFixes true 
    set_eco_opt_mode -resize_inst true -add_inst true -retime $retime_pba -swap_inst true -check_type both -retime_mode exhaustive
    eco_opt_design -hold 
  }
  
  if {$TEMPUS_TSO_OPT == 4} {
    set_eco_opt_mode -verbose true -eco_file_prefix AREA -optimize_sequential_cells true -enableIncrDelayFixes true 
    set_eco_opt_mode -resize_inst true -add_inst true -retime $retime_pba -swap_inst true -check_type both -delete_inst true -retime_mode exhaustive
    eco_opt_design -area 
  }
  
  if {$TEMPUS_TSO_OPT == 5} {
    set_eco_opt_mode -allow_multiple_incremental true
    set_eco_opt_mode -optimize_sequential_cells true -enableIncrDelayFixes true 
    set_eco_opt_mode -resize_inst true -add_inst true -retime $retime_pba -swap_inst true -check_type both -retime_mode exhaustive
  
    set_eco_opt_mode -verbose true -eco_file_prefix HOLD
    eco_opt_design -hold 
    set_eco_opt_mode -verbose true -eco_file_prefix SETUP -check_type both
    eco_opt_design -setup 
  }
}

