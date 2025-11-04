#############################################################################################
#        Copyright (c) 2008-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

#########################################################
# Define global variables                               #
#########################################################

set TDK_FLOW 0
set ALLOW_CLOCK_GATE_IMPORT 1
set PSO_MODE [list]
set QOR_SWITCH "-levels_of_logic"
if {$USE_PSO == 1} {
  set PSO_MODE "-mode normal"
  set QOR_SWITCH [list]
}
set TOOL_VERSION [lindex [split [get_attribute program_version] "-"] 0]
set GEN_SUBD_CONS 0
set OCV_DERATING_USED 0
set SBOCV_DERATING_USED 0
set SOCV_DERATING_USED 0
set SOCV_LIBS_DETECTED 0
set GEN_FLAT_NETLIST 0
set INCR_PASS_COUNTER 1
set KEEP_PREFANOUT_FLOPS 1
set STAGING_FLOPS_IN_MEM_GROUP 1
set LEC_NEQ_DEBUG 0
set INSERT_IO_BUFFERS 0
set REPORT_STATISTICS 1
set GENERATE_CG_REPORT 1
if {[info exists env(KEEP_PREFANOUT_FLOPS)] != 0} {
  set KEEP_PREFANOUT_FLOPS $env(KEEP_PREFANOUT_FLOPS)
}
if {[info exists env(STAGING_FLOPS_IN_MEM_GROUP)] != 0} {
  set STAGING_FLOPS_IN_MEM_GROUP $env(STAGING_FLOPS_IN_MEM_GROUP)
}
if {[info exists env(LEC_NEQ_DEBUG)] != 0} {
  set LEC_NEQ_DEBUG $env(LEC_NEQ_DEBUG)
}
set MC2_INCR_UNGRP_PASS 0
if {[info exists env(MC2_INCR_UNGRP_PASS)] != 0} {
  set MC2_INCR_UNGRP_PASS $env(MC2_INCR_UNGRP_PASS)
}
set GENERATE_HISTOGRAMS 1
if {[info exists env(GENERATE_HISTOGRAMS)] != 0} {
  set GENERATE_HISTOGRAMS $env(GENERATE_HISTOGRAMS)
}
set PA_CLK 0
if {[info exists env(PA_CLK)] != 0} {
  set PA_CLK $env(PA_CLK)
}
set PA_IDMA 0
if {[info exists env(PA_IDMA)] != 0} {
  set PA_IDMA $env(PA_IDMA)
}
set PA_SGE 0
if {[info exists env(PA_SGE)] != 0} {
  set PA_SGE $env(PA_SGE)
}
set PA_LS 0
if {[info exists env(PA_LS)] != 0} {
  set PA_LS $env(PA_LS)
}
set PA_IFS 0
if {[info exists env(PA_IFS)] != 0} {
  set PA_IFS $env(PA_IFS)
}
set PA_IO 0
if {[info exists env(PA_IO)] != 0} {
  set PA_IO $env(PA_IO)
}
set PA_MEM_IO 0
if {[info exists env(PA_MEM_IO)] != 0} {
  set PA_MEM_IO $env(PA_MEM_IO)
}
set PA_ICG 0
if {[info exists env(PA_ICG)] != 0} {
  set PA_ICG $env(PA_ICG)
}
set FIRST_LEVEL_CONS 0.6
set SECOND_LEVEL_CONS 0.7
set THIRD_LEVEL_CONS 0.8

#########################################################
# Set up generic variables and attributes               #
#########################################################

set_attribute iopt_stats 1 /
set_attribute map_fancy_names 1 /
set_attribute source_verbose true /
set_attribute source_verbose_info false /
set_attribute information_level 9 /
set_attribute heartbeat 1200 /
set_attribute heartbeat_print_date 1 /
set_attribute gen_module_prefix CDN_DP_ /
set_attribute retime_reg_naming_suffix _retimed_reg /

TIP_global_message_control

#########################################################
# Perform error checking                                #
#########################################################

if {($LOW_POWER_FLOW == 1) && (($LOW_POWER_LDR < 0) || ($LOW_POWER_LDR > 1))} {
  puts [format "%s%s" "Err" "or   : The Target_LowPowerLDR variable must be a floating-point number between 0 and 1"]
  quit(1)
}
if {($INSERT_SCAN == 0) && ($MAX_TEST_COVERAGE == 1)} {
  puts [format "%s%s" "Err" "or   : Scan observe/control test point insertion cannot be performed if scan chains are"]
  puts [format "%s%s" "Err" "or   : not to be inserted in the design; Syn_InsertScan must be set to 1 if Syn_MaxTestCoverage"]
  puts [format "%s%s" "Err" "or   : is also set to 1."]
  quit(1)
}
if {(![license feature Modus_DFT_Opt]) && ($MAX_TEST_COVERAGE == 1)} {
  puts [format "%s%s" "Err" "or   : A Modus_DFT_Opt license, which is required to perform additional test point insertion, could not be located."]
  puts [format "%s%s" "Err" "or   : Install this feature or set Syn_MaxTestCoverage to 0."]
  quit(1)
}

if {($INSERT_SCAN == 1) && ($MAX_TEST_COVERAGE == 1) && ($USE_MEMORY_MACROS == 0)} {
  puts [format "%s%s" "Err" "or   : Scan observe/control test point insertion can only be performed on flows using memory"]
  puts [format "%s%s" "Err" "or   : hard macros. Set the appropriate level of implementation hierarchy via one of the"]
  puts [format "%s%s" "Err" "or   : Syn_Use* variables in CadSetup.file."]
  quit(1)
}
if {[llength $Lib_CadencePhysicalLibrary] == 0} {
  puts [format "%s%s" "Err" "or   : The physical layout estimator (PLE) based flow requires both technology LEF and macro"]
  puts [format "%s%s" "Err" "or   : cell LEF files to be specified in CadSetup.file via the Lib_CadencePhysicalLibrary"]
  puts [format "%s%s" "Err" "or   : variable. The technology LEF must be listed first."]
  quit(1)
}
if {$GENUS_USE_ISPATIAL == 1} {
  if {$TOOL_VERSION < 21.11} {
    puts [format "%s%s" "Err" "or   : The iSpatial flow requires a Genus version of 21.11 or later. For best iSpatial results"]
    puts [format "%s%s" "Err" "or   : use the same release version of Genus and Innovus."]
    quit(1)
  }
  if {![file exists $FPLAN_FILE]} {
    puts [format "%s%s%s" "Err" "or   : The following floorplan does not exist: " $FPLAN_FILE]
    puts [format "%s%s" "Err" "or   : The iSpatial flow cannot be run without an input floorplan. Set Genus_iSpatialEnable to 0"]
    puts [format "%s%s" "Err" "or   : in CadSetup.file to run in PLE mode, or provide a valid floorplan via Fplan_File to use iSpatial."]
    quit(1)
  }
  if {($LIB_PROCESS_NODE < 3) || ($LIB_PROCESS_NODE > 250)} {
    puts [format "%s%s" "Err" "or   : The Lib_ProcessNode variable in CadSetup.file must be specified as a positive integer between 3 to 250."]
    quit(1)
  }
} else {
  if {$GENUS_CONGESTION == 1} {
    puts [format "%s%s" "Err" "or   : Turning on congestion optimization (Genus_CongestionOpt to 1) is supported only for"]
    puts [format "%s%s" "Err" "or   : the iSpatial flow (Genus_iSpatialEnable to 1)."]
    quit(1)
  }
}

#########################################################
# Determine derate method                               #
#########################################################

if {($DERATE_SLDC != 1) || ($DERATE_SLDN != 1) || ($DERATE_SLCC != 1) || ($DERATE_SLCN != 1) || \
    ($DERATE_SEDC != 1) || ($DERATE_SEDN != 1) || ($DERATE_SECC != 1) || ($DERATE_SECN != 1)} {
  puts [format "%s%s" "In" "fo    : OCV derates have been specified in CadSetup.file"]
  set OCV_DERATING_USED 1
}
if {[info exists MAX_SBOCV] && ($MAX_SBOCV != [list]) && ($MAX_SBOCV != "{}")} {
  puts [format "%s%s" "In" "fo    : Max corner SBOCV files have been specified in CadSetup.file"]
  set SBOCV_DERATING_USED 1
}

if {$GENUS_DERATE_METHOD == 0} {
  puts [format "%s%s" "In" "fo    : No OCV, SBOCV, or SOCV derating will be applied during this run"]
  set OCV_DERATING_USED 0
  set SBOCV_DERATING_USED 0
  set SOCV_DERATING_USED 0
} elseif {$GENUS_DERATE_METHOD == 1} {
  if {$OCV_DERATING_USED == 0} {
    puts [format "%s%s" "Err" "or   : OCV derating was requested via Genus_DerateMethod in CadSetup.file, but no non-unity"]
    puts [format "%s%s" "Err" "or   : max-corner OCV values have been specified."]
    quit(1)
  }
  if {$SBOCV_DERATING_USED == 1} {
    puts [format "%s%s" "Warn" "ing : SBOCV files are specified in CadSetup.file, but OCV derating was requested via"]
    puts [format "%s%s" "Warn" "ing : Genus_DerateMethod in CadSetup.file. The SBOCV files will be ignored, and only OCV"]
    puts [format "%s%s" "Warn" "ing : derating will be applied."]
  }
  if {$SOCV_DERATING_USED == 1} {
    puts [format "%s%s" "Warn" "ing : Sigma SOCV values were detected in the Liberty file, but OCV derating was requested via"]
    puts [format "%s%s" "Warn" "ing : Genus_DerateMethod in CadSetup.file. The sigma values will be ignored, and only OCV"]
    puts [format "%s%s" "Warn" "ing : derating will be applied."]
  }
  set OCV_DERATING_USED 1
  set SBOCV_DERATING_USED 0
  set SOCV_DERATING_USED 0
} elseif {$GENUS_DERATE_METHOD == 2} {
  if {$SBOCV_DERATING_USED == 0} {
    puts [format "%s%s" "Err" "or   : SBOCV derating was requested via Genus_DerateMethod in CadSetup.file, but no"]
    puts [format "%s%s" "Err" "or   : max-corner SBOCV files have been specified."]
    quit(1)
  }
  if {$OCV_DERATING_USED == 1} {
    puts [format "%s%s" "Warn" "ing : Genus does not support SBOCV with incremental OCVs in its native timing engine. Flow will proceed"]
    puts [format "%s%s" "Warn" "ing : with SBOCV derating and supply the incremental OCVs to Innovus for iSpatial as needed."]
  }
  if {$SOCV_DERATING_USED == 1} {
    puts [format "%s%s" "Warn" "ing : Sigma SOCV values were detected in the Liberty file, but SBOCV derating was requested via"]
    puts [format "%s%s" "Warn" "ing : Genus_DerateMethod in CadSetup.file. The sigma values will be ignored, and only SBOCV"]
    puts [format "%s%s" "Warn" "ing : derating will be applied."]
  }
  if {$GENUS_USE_ISPATIAL == 0} {
    puts [format "%s%s" "Err" "or   : SBOCV files can only be used for the Genus iSpatial flow. Set Genus_iSpatialEnable to 1 in CadSetup.file."]
    quit(1)
  }
  set OCV_DERATING_USED 0
  set SBOCV_DERATING_USED 1
  set SOCV_DERATING_USED 0
} elseif {$GENUS_DERATE_METHOD == 3} {
  if {[llength $Lib_CadenceLIB] != 0} {
    puts [format "%s%s" "Warn" "ing : The following grep command can fail if there are no sigma values in the first listed Liberty"]
    puts [format "%s%s" "Warn" "ing : file. Make sure all Liberty files have LVF sigma data in them before setting Genus_DerateMethod"]
    puts [format "%s%s" "Warn" "ing : to 3 in CadSetup.file."]
    redirect -variable SIGMA_COUNT "sh grep -c ocv_sigma_cell_rise [lindex $Lib_CadenceLIB 0]"
    if {$SIGMA_COUNT > 0} {
      puts [format "%s%s" "In" "fo    : SOCV sigma values are present in the first input Liberty file"]
      set SOCV_DERATING_USED 1
    }
  }
  if {$SOCV_DERATING_USED == 0} {
    puts [format "%s%s" "Err" "or   : SOCV derating was requested via Genus_DerateMethod in CadSetup.file, but no LVF data"]
    puts [format "%s%s%s" "Err" "or   : is present in the first file in the Lib_CadenceLIB variable: " [lindex $Lib_CadenceLIB 0]]
    quit(1)
  }
  if {$OCV_DERATING_USED == 1} {
    puts [format "%s%s" "Warn" "ing : Genus does not support SOCV with incremental OCVs in its native timing engine. Flow will proceed"]
    puts [format "%s%s" "Warn" "ing : with SOCV derating and supply the incremental OCVs to Innovus for iSpatial as needed."]
  }
  if {$SBOCV_DERATING_USED == 1} {
    puts [format "%s%s" "Warn" "ing : SBOCV files are specified in CadSetup.file, but SOCV derating was requested via"]
    puts [format "%s%s" "Warn" "ing : Genus_DerateMethod in CadSetup.file. The SBOCV files will be ignored, and only SOCV"]
    puts [format "%s%s" "Warn" "ing : derating will be applied."]
  }
  if {$GENUS_USE_ISPATIAL == 0} {
    puts [format "%s%s" "Err" "or   : SOCV derating can only be used for the Genus iSpatial flow. Set Genus_iSpatialEnable to 1 in CadSetup.file."]
    quit(1)
  }
  set OCV_DERATING_USED 0
  set SBOCV_DERATING_USED 0
  set SOCV_DERATING_USED 1
}

#########################################################
# Set up low-power flow variables                       #
#########################################################

if {$LOW_POWER_FLOW == 1} {
  set USE_ADVANCED_FEATURES 1
# set_attribute dp_area_mode true /
  set_attribute optimize_net_area false /
  set_attribute glo_redrem_ultra_effort true /
  set_attribute scale_of_area_per_unit_length 0 /
  if {($LOW_POWER_GOAL == 3) || ($LOW_POWER_GOAL == 5)} {
    set_attribute lp_insert_clock_gating true /
    set_attribute lp_insert_early_clock_gating true /
    set_attribute lp_insert_discrete_clock_gating_logic true /
    set_attribute lp_clock_gating_prefix genus_inserted_cg /
    set_attribute lp_clock_gating_infer_enable true /
#   set_attribute lp_insert_operand_isolation true /
#   set_attribute lp_operand_isolation_prefix lowp_oi /
#   set_attribute lp_physical_xor_clock_gating true /
#   set_attribute enable_xor_gating_during_map true /
  }
  set_attribute design_power_effort high /
  if {$LOW_POWER_GOAL == 1} {
    set_attribute opt_leakage_to_dynamic_ratio 1 /
  } elseif {($LOW_POWER_GOAL == 2) || ($LOW_POWER_GOAL == 3)} {
    set_attribute opt_leakage_to_dynamic_ratio 0 /
  } else {
    set_attribute opt_leakage_to_dynamic_ratio $LOW_POWER_LDR /
  }
}

#########################################################
# Set up root-level optimization attributes             #
#########################################################

set_attribute syn_map_effort $GENUS_MAP_EFFORT /
set_attribute syn_opt_effort $GENUS_MAP_EFFORT /
if {$GENUS_CONGESTION == 1} {
  set_attribute cas true /
  set_attribute congestion_effort $GENUS_MAP_EFFORT /
  set_attribute pqos_placement_effort $GENUS_MAP_EFFORT /
}
if {$USE_ADVANCED_FEATURES == 1} {
  set_attribute lbr_seq_in_out_phase_opto true /
  set_attribute boundary_optimize_invert_hpins true /
  set_attribute iopt_sequential_duplication true /
  set_attribute optimize_merge_flops true /
  set_attribute optimize_merge_latches true /
  set_attribute ultra_global_mapping true /
  set_attribute syn_generic_effort high /
  set_attribute syn_opt_effort extreme /
  set_attribute retime_effort_level high /
  set_attribute control_logic_optimization advanced /
  set_attribute dp_sharing advanced /
# set_attribute dp_rewriting advanced /
  set_attribute dp_speculation basic /
  set_attribute hlo_ultra true /
  if {$LOW_POWER_FLOW == 1} {
    set_attribute iopt_ultra_effort_for_area 1 /
    set_attribute enable_ultra_gmap_redrem 1 /
    set_attribute dp_analytical_opt extreme /
  } else {
    set_attribute dp_analytical_opt standard /
  }
} else {
  set_attribute lbr_seq_in_out_phase_opto false /
  set_attribute boundary_optimize_invert_hpins false /
  set_attribute syn_generic_effort medium /
}
if {$GENUS_USE_ISPATIAL == 1} {
  set GENUS_ADDITIONAL_PASSES 0
  TIP_ispatial_settings
}
if {$USE_PSO == 1} {
  set_attribute add_pin_name_to_lp_instance true /
}
if {$USE_MULTIBIT_CELLS == 1} {
  set_attribute use_multibit_cells true /
  set_attribute multibit_cells_from_different_busses true /
  set_attribute multibit_mapping_effort_level high /
  set_attribute multibit_debug true /
# set_attribute support_serial_scanin_multibit_cell true /
# set_attribute force_merge_combos_into_multibit_cells true /
# set_attribute force_merge_seqs_into_multibit_cells true /
# set_attribute dft_shift_register_with_mbci true /
# set_attribute dft_identify_non_boundary_shift_registers true /
}
TIP_superthreading_setup

set_attribute exact_match_seq_sync_ctrls true /
set_attribute exact_match_seq_async_ctrls true /
# set_attribute hdl_preserve_sync_ctrl_logic true /
# set_attribute hdl_preserve_sync_set_reset true /
# set_attribute hdl_preserve_async_sr_priority_logic true /
set_attribute power_engine joules /
# set_attribute lp_enable_jls_sdb_flow 1 /
set_attribute optimize_constant_0_flops true /
set_attribute optimize_constant_1_flops true /
set_attribute delete_unloaded_seqs true /
set_attribute optimize_constant_latches true /
set_attribute hdl_unconnected_value 0 /
set_attribute timing_use_ecsm_pin_capacitance true /
set_attribute timing_report_enable_common_header true /
set_attribute distributed_area_opt_cleanup true /
set_attribute map_mt_area_opt_cleanup true /
set_attribute use_multi_clks_latency_uncertainty_optimize true /
set_attribute use_multi_clks_latency_uncertainty_report true /
set_attribute scale_of_res_per_unit_length $GENUS_RES_WIRE_SCALE /
set_attribute scale_of_cap_per_unit_length $GENUS_CAP_WIRE_SCALE /
set_attribute auto_ungroup both /
set_attribute use_scan_seqs_for_non_dft degenerated_only /
set_attribute print_ports_nets_preserved_for_cb true /
set_attribute detailed_sdc_messages true /
set_attribute hdl_max_loop_limit 1024 /
set_attribute hdl_use_cw_first true /
set_attribute hdl_zero_replicate_is_null true /
set_attribute hdl_error_on_blackbox true /
set_attribute hdl_report_case_info true /
set_attribute hdl_generate_index_style %s_%d /
set_attribute hdl_generate_separator _ /
set_attribute hdl_interface_separator _ /
# set_attribute hdl_flatten_complex_port true /
set_attribute ungroup_separator _ /
set_attribute dp_ungroup_separator _ /
set_attribute hdl_parameterize_module_name false /
set_attribute hdl_parameter_naming_style _%d /
set_attribute hdl_append_generic_ports false /
set_attribute wlec_analyze_setup true /
set_attribute wlec_set_cdn_synth_root true /
set_attribute wlec_gzip_fv_json true /
set_attribute verification_directory_naming_style genus_fv /
# set_attribute write_vlog_no_negative_index true /
set_attribute write_vlog_line_wrap_limit 200 /
set_attribute statistics_run_id $TOP_DESIGN /
set_attribute statistics_log_data true /
set_attribute write_db_auto_save_user_globals true /
set_attribute dft_include_test_signal_outputs_in_abstract_model false /
set_attribute dft_include_controllable_pins_in_abstract_model none /
set_attribute enable_simple_boundary_optimization true /
set_attribute hdl_drive_redundant_flop_load_with_zero true /
set_attribute wlec_rtl_name_mapping_flow true /
# set_attribute wlec_run_hier_check_noneq true /
set_attribute time_recovery_arcs true /
if {$LEC_NEQ_DEBUG == 1} {
  set_attribute pbs_encrypt_internal_files 0 /
  set_attribute pbs_keep_tmp_dir 1 /
  set_attribute pbs_debug_level 3 /
  set_attribute pbs_debug_fv 1 /
}
if {$TOOL_VERSION == 21.11} {
  set_attribute dpopt_rewrite_ignore_pattern "base_unsigned_add_ldp_csa2_from" /
}

#########################################################
# Set up target libraries - PSO flow has all .lib file  #
# information defined in technology CPF file            #
#########################################################

if {$USE_PSO == 0} {
  if {$LIB_PROCESS_NODE <= 3} {
    puts [format "%s%s" "Warn" "ing : For Lib_ProcessNode values of 3 or less, the SOCV LVF analysis mode is set to moments"]
    set_attribute parse_lib_moments_table true /
    set_attribute delaycal_socv_lvf_mode moments /
    set_attribute delaycal_socv_use_lvf_tables all /
  }
  if {$USE_POWER_LIBRARY == 1} {
    create_library_domain {timing leakage}
    set_attribute library $Lib_CadenceLIB [find / -library_domain timing]
    set_attribute library $Lib_CadenceMinLIB [find / -library_domain leakage]
    set_attribute power_library leakage [find / -library_domain timing]
  } else {
    create_library_domain {timing}
    set_attribute library $Lib_CadenceLIB [find / -library_domain timing]
  }
  set_attribute default true [find / -library_domain timing]
  if {[get_attribute has_lvf [lindex [find / -libcell *] 10]] eq "true"} {
    if {$LIB_PROCESS_NODE <= 3} {
      set SOCV_LIBS_DETECTED 1
    } else {
      set SOCV_LIBS_DETECTED 0
    }
  }
}
if {$SBOCV_DERATING_USED == 1} {
  set_attribute aocv_library $MAX_SBOCV [find / -library_domain timing]
  if {$USE_POWER_LIBRARY == 1} {
    set_attribute aocv_library $MIN_SBOCV [find / -library_domain leakage]
  }
} elseif {($SOCV_DERATING_USED == 1) || ($SOCV_LIBS_DETECTED == 1)} {
  set_attribute socv_library $Lib_CadenceLIB [find / -library_domain timing]
  if {$USE_POWER_LIBRARY == 1} {
    set_attribute socv_library $Lib_CadenceMinLIB [find / -library_domain leakage]
  }
  set_attribute ocv_mode true /
  set_attribute socv_analysis 1 /
  set_attribute timing_analysis_socv true /
  set_attribute timing_report_max_transition_check_using_nsigma_slew true /
  set_attribute timing_nsigma_multiplier 3.0 /
}

#########################################################
# Scale all user-specified values to native Genus units #
#########################################################

if {($USE_PSO == 1) && ($CPF_FILE != [list])} {
  read_power_intent -cpf -module $TOP_DESIGN $CPF_FILE
}

set libcell_power_switches_present 0
foreach lc [find / -libcell *] {
  if {[get_attribute power_switch_cell $lc] eq true} {
    set libcell_power_switches_present 1
  }
}

set TIMESCALE 0
set CAPSCALE 0
set libcell_count 0
set local_count 0
foreach ln [find / -library *] {
  set local_count [llength [find $ln -libcell *]]
  if {$local_count > $libcell_count} {
    set libcell_count $local_count
    redirect /dev/null {set TS [get_attribute time_scale_in_ps $ln]}
    if {([llength $TS] != 0) && ($TS != 0)} {
      set TIMESCALE $TS
    }
    redirect /dev/null {set CS [get_attribute cap_scale_in_fF $ln]}
    if {([llength $CS] != 0) && ($CS != 0)} {
      set CAPSCALE $CS
    }
  }
}
if {$TIMESCALE == 0} {
  puts [format "%s%s" "Err" "or   : No timescale was defined in any input library."]
  quit(1)
} elseif {$CAPSCALE == 0} {
  puts [format "%s%s" "Err" "or   : No capscale was defined in any input library."]
  quit(1)
}
set MAX_DATA_TRANSITION [expr $MAX_DATA_TRANSITION * $TIMESCALE]
set MAX_CAPACITANCE [expr $MAX_CAPACITANCE * $CAPSCALE]

set MAX_CAP_SCALE_FACTOR 20
set BOUNDARY_LOAD_SCALE_FACTOR 4
if {$USE_MEMORY_MACROS == 1} {
  set BOUNDARY_LOAD_SCALE_FACTOR 25
}

#########################################################
# Use Physical Layout Estimator (PLE) flow              #
#########################################################

if {[llength $Lib_CadencePhysicalLibrary] != 0} {
  set_attribute severity Error [find / -message PHYS-103]
  set_attribute lef_stop_on_error true /
  set_attribute fail_on_error_mesg true /
  set_attribute lef_library $Lib_CadencePhysicalLibrary /
  set_attribute fail_on_error_mesg false /
}
if {[llength $Lib_MaxQrcTechFile] != 0} {
  set_attribute qrc_tech_file $Lib_MaxQrcTechFile /
} elseif {[llength $Lib_MaxCapTable] != 0} {
  set_attribute cap_table_file $Lib_MaxCapTable /
} else {
  puts [format "%s%s" "Warn" "ing : Neither a QRC techfile nor a Capacitance table file has been specified;"]
  puts [format "%s%s" "Warn" "ing : RC values will be taken from the LEF files instead, which will reduce accuracy."]
}
set_attribute interconnect_mode ple /

TIP_mixed_height_library_controls -apply_settings

#########################################################
# Test verilog library views for ATPG step              #
#########################################################

set MBIST_VERIFY_CHECK 0
set SIM_LIB_LENGTH [llength $VERILOG_SIM_LIB]
set VALID_SIM_LIBS 0
set ATPG_COUNTER 0
set RUN_ATPG 0
foreach vsl $VERILOG_SIM_LIB {
  if {[file readable $vsl]} {
    incr VALID_SIM_LIBS
  }
}
if {($SIM_LIB_LENGTH > 0) && ($SIM_LIB_LENGTH == $VALID_SIM_LIBS)} {
  incr ATPG_COUNTER
  incr MBIST_VERIFY_CHECK
} else {
  puts [format "%s%s" "Warn" "ing : A readable list of verilog library models is required for computing ATPG coverage using"]
  puts [format "%s%s" "Warn" "ing : Encounter Test. Specify these via the Lib_VerilogSimulationLibrary variable in CadSetup.file."]
  puts [format "%s%s" "Warn" "ing : ATPG coverage analysis will be skipped for this design."]
}
if {[license feature Encounter_Test_Architect]} {
  incr ATPG_COUNTER
} else {
  puts [format "%s%s" "Warn" "ing : An Encounter_Test_Architect license could not be located. Encounter Test cannot be run to"]
  puts [format "%s%s" "Warn" "ing : determine ATPG coverage for this design."]
}
if {$ATPG_COUNTER == 2} {
  set RUN_ATPG 1
}
