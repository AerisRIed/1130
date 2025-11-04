################################################################################
# Copyright (c) 2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design #
# Systems Inc. They may not be modified, copied, reproduced, distributed, or   #
# disclosed to third parties in any manner, medium, or form, in whole or in    #
# part, without the prior written consent of Cadence Design Systems Inc.       #
################################################################################

#########################################################
# This file should not require any user modification	#
#########################################################

#########################################################
# TCL proc definitions used across all Jasper Apps	#
#########################################################

#########################
# Global procs		#
#########################

proc CETFE_jg_boolean_to_on_off {{bool_val ""}} {
  set on_off_val [list]
  if {$bool_val == 1} {
    set on_off_val "on"
  } elseif {$bool_val == 0} {
    set on_off_val "off"
  } else {
    puts [format "%s%s%s%s" "Err" "or   : input value \"" $bool_val "\" is not Boolean. Returning empty list instead."]
  }
  return $on_off_val
}

proc CETFE_jg_check_settings {} {
  global rtl_flow
  global prl_run_cdc

  if {($rtl_flow == 0) && ($prl_run_cdc == 0)} {
    puts [format "%s%s" "Err" "or   : the rtl_flow variable is set to 0; only the CDC App supports a netlist-based flow."]
    exit 1
  }
}

proc CETFE_jg_initial_setup {} {
  global single_corner_libs
  global rtl_flow 
  global top_design
  global golden_vf_file
  global hier_jdb_mod_app
  global rtl_defines
  global bbox_module_list
  global golden_netlist_file
  global golden_name_map_file
  global golden_sdc_file
  global tool_thread_count
  global prl_gui
  global prl_stage
  global prl_rule_level
  global prl_hier_flow
  global prl_debug_mode
  global prl_run_superlint
  global prl_run_cdc
  global prl_run_mcp
  global prl_run_xprop
  global prl_run_sec
  global prl_run_lpv
  global prl_user_vars_root_dir
  global prl_script_root_dir
  global prl_stamped_base_dir
  global prl_generate_reports
  global common_core_message_settings_file
  global common_user_message_settings_file
  global common_user_attributes_file

  clear -all
  if {$prl_run_cdc} {
    check_cdc -init
  } elseif {$prl_run_superlint} {
    check_superlint -init
  } elseif {$prl_run_mcp} {
    check_timing_exception -init
  } elseif {$prl_run_xprop} {
    check_xprop -init
    check_xprop -init_all_control true -sequential -init_data true -init_index true
  }
  source $common_core_message_settings_file
  source $common_user_message_settings_file
  if {$tool_thread_count > 1} {
    set_parallel_synthesis_mode on
    set_parallel_synthesis_dispatch_mode local
    set_parallel_synthesis_num_process $tool_thread_count
    set_superlint_parallel_synthesis true
    set_superlint_parallel_extraction $tool_thread_count
    set_superlint_prove_parallel_tasks on
    set_proofgrid_max_jobs $tool_thread_count
    set_proofgrid_max_local_jobs $tool_thread_count
    set_proofgrid_per_engine_max_jobs $tool_thread_count
    set_proofgrid_per_engine_max_local_jobs $tool_thread_count
  }
  set_log_timestamp_mode on
  set_message_history_limit 10000
  set_cte_enable_session_tcl_env_restore true
  set_tcl_auto_show_error_info on
  set_capture_elaborated_design on
  set_schematic_viewer_simplify_concatenations true
  set_schematic_viewer_collapse_combo_logic true
  set_cumulative_reset on
  set_read_sdc_debug on
  set_superlint_enable_hier_lint true
# set_superlint_debug_unreachable true
  set_superlint_leverage_formal true
  set_superlint_deadcode_full_case_filter true
  set_superlint_deadcode_unified_loop true
# set_superlint_fsm_automatic_assumptions_type coi
  set_superlint_signals_automatic_assumptions_type all
  set_superlint_enable_rtl_inline_waiver true
  if {($prl_run_cdc == 1) && ($rtl_flow == 0)} {
    set_cdc_gate_level_analysis_mode on
  }
  if {$prl_run_mcp} {
    set_liberty_enable_timing_model_synthesis on
  }
  if {$prl_run_xprop} {
    set_max_trace_length 0
    set_prove_time_limit 24h
    set_prove_per_property_time_limit 10s
    set_prove_per_property_time_limit_factor 10
    set_prove_per_property_max_time_limit 4h
    set_xprop_autoprove_expose_internal_cex off
    set_xprop_autoprove_max_number_of_internal_cex 100
    set_xprop_autoprove_minimal_max_length_of_internal_cex 1
    set_xprop_break_loop_mode default
    set_xprop_ignore_non_resetting_flops_as_source off
    set_xprop_proofgrid_utilization_warning_percentage_threshold 70
    set_xprop_show_proof_log true
  }
  source $common_user_attributes_file
}

proc CETFE_jg_hier_setup {} {
  global prl_hier_flow
  global hier_jdb_mod_app

  if {$prl_hier_flow} {
    if {[dict size $hier_jdb_mod_app] == 0} {
      puts [format "%s%s" "Err" "or   : the hierarchical flow has been selected, however"]
      puts [format "%s%s" "Err" "or   : there are no modules defined in hier_jdb_mod_app."]
      exit 1
    }
  } else {
    if {[dict size $hier_jdb_mod_app] > 0} {
      puts [format "%s%s" "Warn" "ing : the top-down flow has been selected, however the hier_jdb_mod_app"]
      puts [format "%s%s" "Warn" "ing : dictionary is not empty. Proceeding with the top-down flow."]
    }
  }
}

proc CETFE_jg_load_rulefile {} {
  global single_corner_libs
  global rtl_flow
  global top_design
  global golden_vf_file
  global hier_jdb_mod_app
  global rtl_defines
  global bbox_module_list
  global golden_netlist_file
  global golden_name_map_file
  global golden_sdc_file
  global tool_thread_count
  global prl_gui
  global prl_stage
  global prl_rule_level
  global prl_hier_flow
  global prl_debug_mode
  global prl_run_superlint
  global prl_run_cdc
  global prl_run_mcp
  global prl_run_xprop
  global prl_run_sec
  global prl_run_lpv
  global prl_user_vars_root_dir
  global prl_script_root_dir
  global prl_stamped_base_dir
  global prl_generate_reports
  global cdc_core_rtl_rules_file
  global cdc_core_gate_rules_file
  global cdc_core_message_settings_file
  global cdc_user_message_settings_file
  global cdc_core_rule_settings_file
  global cdc_user_rule_settings_file
  global superlint_core_rules_file
  global superlint_core_message_settings_file
  global superlint_user_message_settings_file
  global superlint_core_rule_settings_file
  global superlint_user_rule_settings_file
  global mcp_core_message_settings_file
  global mcp_user_message_settings_file
  global xprop_core_message_settings_file
  global xprop_user_message_settings_file

  if {$prl_run_cdc} {
    if {$rtl_flow} {
      set external_cdc_rule_file $cdc_core_rtl_rules_file
    } else {
      set external_cdc_rule_file $cdc_core_gate_rules_file
    }
    config_rtlds -rule -load $external_cdc_rule_file
    config_rtlds -rule -set_default $external_cdc_rule_file
    source $cdc_core_message_settings_file
    source $cdc_user_message_settings_file
    source $cdc_core_rule_settings_file
    source $cdc_user_rule_settings_file
  } elseif {$prl_run_superlint} {
    if {$prl_rule_level eq "full_install"} {
      set external_superlint_rule_file [file join [get_install_dir] "etc/res/rtlds/rules/superlint.def"]
    } else {
      set external_superlint_rule_file $superlint_core_rules_file
    }
    config_rtlds -rule -load $external_superlint_rule_file
    config_rtlds -rule -set_default $external_superlint_rule_file
    source $superlint_core_message_settings_file
    source $superlint_user_message_settings_file
    source $superlint_core_rule_settings_file
    source $superlint_user_rule_settings_file
  } elseif {$prl_run_mcp} {
    source $mcp_core_message_settings_file
    source $mcp_user_message_settings_file
  } elseif {$prl_run_xprop} {
    source $xprop_core_message_settings_file
    source $xprop_user_message_settings_file
  }
}

proc CETFE_jg_analyze_design {} {
  global rtl_flow
  global golden_vf_file
  global rtl_defines
  global golden_netlist_file
  global prl_run_cdc
  global common_user_additional_args_file

  source $common_user_additional_args_file
  set additional_args [list]
  if {[info exists analyze_omega_args]} {
    set additional_args $analyze_omega_args
  }
  if {($prl_run_cdc == 1) && ($rtl_flow == 0)} {
    if {[llength $golden_netlist_file] > 0} {
      eval analyze -gate_level $golden_netlist_file $additional_args
    } else {
      puts [format "%s%s" "Err" "or   : no netlist was defined via the golden_netlist_file variable"]
      exit 1
    }
  } else {
    if {[dict size $golden_vf_file] == 0} {
      puts [format "%s%s" "Err" "or   : RTL-level analysis has been selected, however there are"]
      puts [format "%s%s" "Err" "or   : no input filelists defined in golden_vf_file."]
      exit 1
    } else {
      dict for {flist lrm} $golden_vf_file {
	eval analyze -$lrm -f_relative_to_file_location $flist $rtl_defines $additional_args
      }
    }
  }
}

proc CETFE_jg_load_liberty {} {
  global rtl_flow
  global single_corner_libs
  global prl_run_cdc

  if {[llength $single_corner_libs] > 0} {
    puts [format "%s%s" "In" "fo    : loading user-specified Liberty files from the \"single_corner_libs\" variable"]
    foreach scl $single_corner_libs {
      if {[file readable $scl]} {
	liberty -load $scl
      } else {
	puts [format "%s%s%s" "Err" "or   : specified Liberty file not readable - " $scl]
	exit 1
      }
    }
  } else {
    if {($prl_run_cdc == 1) && ($rtl_flow == 0)} {
      puts [format "%s%s" "Err" "or   : Liberty files are required when running CDC analysis at the netlist level"]
      exit 1
    } else {
      puts [format "%s%s" "In" "fo    : no user-specified Liberty files were provided; continuing with analysis"]
    }
  }
}

proc CETFE_jg_elaborate_design {} {
  global bbox_module_list
  global top_design
  global common_user_additional_args_file

  source $common_user_additional_args_file
  set additional_args [list]
  if {[info exists elaborate_omega_args]} {
    set additional_args $elaborate_omega_args
  }
  set loc_fixed_args "-enable_extended_optimization -remove_dangling_logic"
  if {[llength $bbox_module_list] > 0} {
    eval elaborate -bbox_m {$bbox_module_list} -top $top_design $loc_fixed_args $additional_args
  } else {
    eval elaborate -top $top_design $loc_fixed_args $additional_args
  }
  liberty -list
}

proc CETFE_jg_hier_load {} {
  global top_design
  global hier_jdb_mod_app
  global prl_hier_flow
  global prl_run_cdc
  global prl_run_superlint
  global prl_stamped_base_dir

  if {$prl_hier_flow} {
    if {$prl_run_cdc} {
      dict for {path mod_a} $hier_jdb_mod_app {
	dict for {mod_b app} $mod_a {
	  if {[lsearch -exact -nocase $app cdc] != -1} {
	    puts [format "%s%s%s%s%s" "In" "fo    : loading hierarchical CDC DB for module " $mod_b ": " $path]
	    check_cdc -hierarchical -load -file_name $path
	  }
	}
      }
      check_cdc -list hier_db_info -force -file [file join $prl_stamped_base_dir csv ${top_design}_hier_db_info.csv]
    } elseif {$prl_run_superlint} {
      dict for {path mod_a} $hier_jdb_mod_app {
	dict for {mod_b app} $mod_a {
	  if {[lsearch -exact -nocase $app superlint] != -1} {
	    puts [format "%s%s%s%s%s" "In" "fo    : loading hierarchical Superlint DB for module " $mod_b ": " $path]
	    check_superlint -import -file $path
	  }
	}
      }
    }
  }
}

proc CETFE_jg_load_sdc {} {
  global golden_sdc_file
  global prl_run_cdc
  global prl_run_mcp

  if {[llength $golden_sdc_file] > 0} {
    read_sdc $golden_sdc_file
  } else {
    if {($prl_run_cdc == 1) || ($prl_run_mcp == 1)} {
      puts [format "%s%s" "Err" "or   : no SDC file was defined via the golden_sdc_file variable; the CDC and MCP Apps require an SDC file"]
      exit 1
    } else {
      puts [format "%s%s" "In" "fo    : no SDC file was defined via the golden_sdc_file variable; this App does not require one"]
    }
  }
}

proc CETFE_jg_load_reset_sequence {} {
  global single_corner_libs
  global rtl_flow
  global top_design
  global golden_vf_file
  global hier_jdb_mod_app
  global reset_init_file
  global rtl_defines
  global bbox_module_list
  global golden_netlist_file
  global golden_name_map_file
  global golden_sdc_file
  global tool_thread_count
  global prl_gui
  global prl_stage
  global prl_rule_level
  global prl_hier_flow
  global prl_debug_mode
  global prl_run_superlint
  global prl_run_cdc
  global prl_run_mcp
  global prl_run_xprop
  global prl_run_sec
  global prl_run_lpv
  global prl_user_vars_root_dir
  global prl_script_root_dir
  global prl_stamped_base_dir
  global prl_generate_reports
  global common_user_reset_sequence_file

  dict for {rst_type nested_a} $reset_init_file {
    dict for {f_type nested_b} $nested_a {
      dict for {f_path nested_c} $nested_b {
	dict for {enabled addnl_args} $nested_c {
	  if {$enabled == 1} {
	    if {$f_type eq "internal"} {
	      eval reset -$rst_type $f_path $addnl_args
	    } else {
	      if {$rst_type eq "sequence"} {
		eval reset -sequence -$f_type $f_path $addnl_args
	      } elseif {$rst_type eq "init_state"} {
		eval reset -$f_type $f_path $addnl_args
	      }
	    }
	  }
	}
      }
    }
  }
}

#########################
# CDC procs		#
#########################

proc CETFE_jg_cdc_stepped_flow {} {
  global single_corner_libs
  global rtl_flow
  global top_design
  global golden_vf_file
  global hier_jdb_mod_app
  global rtl_defines
  global bbox_module_list
  global golden_netlist_file
  global golden_name_map_file
  global golden_sdc_file
  global tool_thread_count
  global prl_gui
  global prl_stage
  global prl_rule_level
  global prl_hier_flow
  global prl_debug_mode
  global prl_run_superlint
  global prl_run_cdc
  global prl_run_mcp
  global prl_run_xprop
  global prl_run_sec
  global prl_run_lpv
  global prl_user_vars_root_dir
  global prl_script_root_dir
  global prl_stamped_base_dir
  global prl_generate_reports
  global common_user_signal_binding_file
  global cdc_user_constraints_file
  global cdc_core_rule_waivers_file
  global cdc_user_rule_waivers_file

  save -force -all_sessions [file join $prl_stamped_base_dir db ${top_design}_post_sdc.jdb]

  if {$prl_stage >= 2} {
    #####################################################################
    # Checkpoint 1: define constraints and waivers, find clock domains	#
    #####################################################################
    if {$rtl_flow == 0} {
      if {[llength $golden_name_map_file] > 0} {
	check_cdc -name_map -file $golden_name_map_file
      } else {
	puts [format "%s%s" "In" "fo    : no LEC name mapping file was provided for CDC gate-level analysis; proceeding with auto mapping"]
      }
    }
    source $common_user_signal_binding_file
    source $cdc_user_constraints_file
    source $cdc_core_rule_waivers_file
    source $cdc_user_rule_waivers_file
    check_cdc -clock_domain -find
    check_cdc -debug -color_clock_logic true
    save -force -all_sessions [file join $prl_stamped_base_dir db ${top_design}_post_clock_domain.jdb]
  }
  if {$prl_stage >= 3} {
    #####################################################################
    # Checkpoint 2: find CDC pairs and schemes				#
    #####################################################################
    check_cdc -pair -find
    check_cdc -scheme -find
    save -force -all_sessions [file join $prl_stamped_base_dir db ${top_design}_post_schemes.jdb]
  }
  if {$prl_stage >= 4} {
    #####################################################################
    # Checkpoint 3: convergence and reset structural analysis		#
    #####################################################################
    check_cdc -group -find
    check_cdc -reset -find
    save -force -all_sessions [file join $prl_stamped_base_dir db ${top_design}_post_reset.jdb]
  }
  if {$prl_stage >= 5} {
    #####################################################################
    # Checkpoint 4: protocol, signal, waiver, and metastability proofs	#
    #####################################################################
    # check_cdc -protocol_check -generate
    # check_cdc -protocol_check -prove
    # config_rtlds -signal -prove
    # check_cdc -waiver -generate
    # check_cdc -waiver -prove
    check_cdc -metastability -inject
    check_cdc -metastability -prove
    save -force -all_sessions [file join $prl_stamped_base_dir db ${top_design}_post_metastability.jdb]
  }
}

proc CETFE_jg_cdc_report_csv {} {
  global prl_stamped_base_dir
  global top_design

  set reporting_list_object {pairs domains rules filters signal_config signoff violations reset_schemes \
                             schemes clock_groups waivers ipqc clock_matrix clock_synchronicity domain_crossings \
                             reset_order reset_definitions rdc_pairs design_resets declared_resets}
  set reporting_file_suffix {cdc_pairs clock_domains cdc_path_rules userdef_filters const_and_static_ports \
                             signoff_violations cdc_violations rdc_schemes cdc_schemes clock_groups cdc_waivers \
                             cdc_ipqc clock_matrix clock_synchronicity domain_crossings reset_order reset_definitions \
                             rdc_pairs design_resets declared_resets}
  foreach rlo $reporting_list_object rfs $reporting_file_suffix {
    check_cdc -list $rlo -force -file [file join $prl_stamped_base_dir csv ${top_design}_${rfs}.csv]
  }
}

proc CETFE_jg_cdc_list_constants {} {
  global prl_stamped_base_dir
  global top_design

  set loc_output_file [file join $prl_stamped_base_dir report ${top_design}_constant_port_list.txt]
  set loc_fp [open $loc_output_file a]
  puts $loc_fp "#\n# Ports set to constant values\n#\n"

  set signal_config_list [check_cdc -list signal_config]
  foreach key [dict keys $signal_config_list] {
    set loc_config_type [dict get $signal_config_list $key {Type}]
    set loc_config_signal [dict get $signal_config_list $key {Signals}]
    set loc_config_value [dict get $signal_config_list $key {Value}]
    if {$loc_config_type eq "ConstantValue"} {
      puts $loc_fp [format "%-60s %5s" $loc_config_signal $loc_config_value]
    }
  }
  close $loc_fp
}

proc CETFE_jg_cdc_list_statics {} {
  global prl_stamped_base_dir
  global top_design

  set loc_output_file [file join $prl_stamped_base_dir report ${top_design}_static_port_list.txt]
  set loc_fp [open $loc_output_file a]
  puts $loc_fp "#\n# Ports set to type static\n#\n"

  set signal_config_list [check_cdc -list signal_config]
  foreach key [dict keys $signal_config_list] {
    set loc_config_type [dict get $signal_config_list $key {Type}]
    set loc_config_signal [dict get $signal_config_list $key {Signals}]
    if {$loc_config_type eq "StaticValue"} {
      puts $loc_fp [format "%-60s" $loc_config_signal]
    }
  }
  close $loc_fp
}

proc CETFE_jg_cdc_print_summary {} {
  global prl_stamped_base_dir
  global top_design

  set loc_output_file [file join $prl_stamped_base_dir report ${top_design}_cdc_results_summary.txt]
  set loc_fp [open $loc_output_file a]
  set pair_count 0
  set pair_pass_count 0
  set pair_fail_count 0
  set pair_wave_count 0
  set scheme_count 0
  set scheme_pass_count 0
  set scheme_fail_count 0
  set scheme_wave_count 0
  set group_count 0
  set group_pass_count 0
  set group_fail_count 0
  set group_wave_count 0
  set prop_count 0
  set prop_pass_count 0
  set prop_fail_count 0
  set prop_wave_count 0
  set pair_list [check_cdc -list pairs]
  set scheme_list [check_cdc -list schemes]
  set group_list [check_cdc -list groups]
  set prop_list [check_cdc -list scheme_properties]
  set pair_count [llength [dict keys $pair_list]]
  set scheme_count [llength [dict keys $scheme_list]]
  set group_count [llength [dict keys $group_list]]
  set prop_count [llength [dict keys $prop_list]]
  foreach key [dict keys $pair_list] {
    set status [dict get $pair_list $key Status]
    if {$status == "Passed"} {incr pair_pass_count 1}
    if {$status == "Failed"} {incr pair_fail_count 1}
    if {($status == "Waived") || ($status == "AutoWaived")} {incr pair_wave_count 1}
  }
  foreach key [dict keys $scheme_list] {
    set status [dict get $scheme_list $key Status]
    if {$status == "Passed"} {incr scheme_pass_count 1}
    if {$status == "Failed"} {incr scheme_fail_count 1}
    if {($status == "Waived") || ($status == "AutoWaived")} {incr scheme_wave_count 1}
  }
  foreach key [dict keys $group_list] {
    set status [dict get $group_list $key Status]
    if {$status == "Passed"} {incr group_pass_count 1}
    if {$status == "Failed"} {incr group_fail_count 1}
    if {($status == "Waived") || ($status == "AutoWaived")} {incr group_wave_count 1}
  }
  foreach key [dict keys $prop_list] {
    set status [dict get $prop_list $key Status]
    if {$status == "Passed"} {incr prop_pass_count 1}
    if {$status == "Failed"} {incr prop_fail_count 1}
    if {($status == "Waived") || ($status == "AutoWaived")} {incr prop_wave_count 1}
  }
  puts $loc_fp "########################\n# CDC Analysis Summary #\n########################\n"
  puts $loc_fp "CDC Pairs"
  puts $loc_fp "    Total: $pair_count"
  puts $loc_fp "    Pass : $pair_pass_count"
  puts $loc_fp "    Fail : $pair_fail_count"
  puts $loc_fp "    Wave : $pair_wave_count"
  puts $loc_fp "\nCDC Defined Schemes"
  puts $loc_fp "    Total: $scheme_count"
  puts $loc_fp "    Pass : $scheme_pass_count"
  puts $loc_fp "    Fail : $scheme_fail_count"
  puts $loc_fp "    Wave : $scheme_wave_count"
  puts $loc_fp "\nCDC Data Reconvergence"
  puts $loc_fp "    Total: $group_count"
  puts $loc_fp "    Pass : $group_pass_count"
  puts $loc_fp "    Fail : $group_fail_count"
  puts $loc_fp "    Wave : $group_wave_count"
  puts $loc_fp "\nCDC Functional Checks"
  puts $loc_fp "    Total: $prop_count"
  puts $loc_fp "    Pass : $prop_pass_count"
  puts $loc_fp "    Fail : $prop_fail_count"
  puts $loc_fp "    Wave : $prop_wave_count"
  close $loc_fp
}

proc CETFE_jg_cdc_report_text {} {
  global prl_stamped_base_dir
  global top_design

  check_cdc -report -setup -force -file [file join $prl_stamped_base_dir report ${top_design}_cdc_run_setup.txt]
  check_cdc -report -waiver -force -file [file join $prl_stamped_base_dir report ${top_design}_waivers.txt]
  check_cdc -report -signoff -force -file [file join $prl_stamped_base_dir report ${top_design}_signoff_violations.txt]
  check_cdc -report -violation -order tag -grouping none -force -file [file join $prl_stamped_base_dir report ${top_design}_all_cdc_violations_summary.txt]
  check_cdc -report -violation -order tag -grouping none -detailed -force -file [file join $prl_stamped_base_dir report ${top_design}_all_cdc_violations_detailed.txt]
  check_cdc -report -violation -order tag -grouping none -waived none -force -file [file join $prl_stamped_base_dir report ${top_design}_non_waived_cdc_violations_summary.txt]
  check_cdc -report -violation -order tag -grouping none -detailed -waived none -force -file [file join $prl_stamped_base_dir report ${top_design}_non_waived_cdc_violations_detailed.txt]
  check_cdc -report -violation -order tag -grouping none -waived only -force -file [file join $prl_stamped_base_dir report ${top_design}_waived_cdc_violations_summary.txt]
  check_cdc -report -violation -order tag -grouping none -detailed -waived only -force -file [file join $prl_stamped_base_dir report ${top_design}_waived_cdc_violations_detailed.txt]
}

proc CETFE_jg_cdc_report_html {} {
  global prl_stamped_base_dir
  global top_design

  check_cdc -report -setup -force -html -file [file join $prl_stamped_base_dir html ${top_design}_cdc_run_setup.html]
  check_cdc -report -waiver -force -html -file [file join $prl_stamped_base_dir html ${top_design}_waivers.html]
  check_cdc -report -signoff -force -html -file [file join $prl_stamped_base_dir html ${top_design}_signoff_violations.html]
  check_cdc -report -violation -order tag -grouping none -force -html -file [file join $prl_stamped_base_dir html ${top_design}_all_cdc_violations_summary.html]
  check_cdc -report -violation -order tag -grouping none -detailed -force -html -file [file join $prl_stamped_base_dir html ${top_design}_all_cdc_violations_detailed.html]
  check_cdc -report -violation -order tag -grouping none -waived none -force -html -file [file join $prl_stamped_base_dir html ${top_design}_non_waived_cdc_violations_summary.html]
  check_cdc -report -violation -order tag -grouping none -detailed -waived none -force -html -file [file join $prl_stamped_base_dir html ${top_design}_non_waived_cdc_violations_detailed.html]
  check_cdc -report -violation -order tag -grouping none -waived only -force -html -file [file join $prl_stamped_base_dir html ${top_design}_waived_cdc_violations_summary.html]
  check_cdc -report -violation -order tag -grouping none -detailed -waived only -force -html -file [file join $prl_stamped_base_dir html ${top_design}_waived_cdc_violations_detailed.html]
}

proc CETFE_jg_cdc_report_collateral {} {
  global prl_stamped_base_dir
  global top_design

  check_cdc -waiver -export -force -file [file join $prl_stamped_base_dir collateral ${top_design}_saved_waivers.tcl]
  config_rtlds -rule -save [file join $prl_stamped_base_dir collateral ${top_design}_saved_rules.tcl]
  check_cdc -export -database -force -file [file join $prl_stamped_base_dir collateral ${top_design}_cdc.jdb]
  check_cdc -hierarchical -report [file join $prl_stamped_base_dir report ${top_design}_hier_jdb_report.txt] -info [file join $prl_stamped_base_dir collateral ${top_design}_cdc.jdb]
}

#########################
# Superlint procs	#
#########################

proc CETFE_jg_superlint_stepped_flow {} {
  global single_corner_libs
  global rtl_flow
  global top_design
  global golden_vf_file
  global hier_jdb_mod_app
  global rtl_defines
  global bbox_module_list
  global golden_netlist_file
  global golden_name_map_file
  global golden_sdc_file
  global tool_thread_count
  global prl_gui
  global prl_stage
  global prl_rule_level
  global prl_hier_flow
  global prl_debug_mode
  global prl_run_superlint
  global prl_run_cdc
  global prl_run_mcp
  global prl_run_xprop
  global prl_run_sec
  global prl_run_lpv
  global prl_user_vars_root_dir
  global prl_script_root_dir
  global prl_stamped_base_dir
  global prl_generate_reports
  global common_user_signal_binding_file
  global superlint_user_constraints_file
  global superlint_core_rule_waivers_file
  global superlint_user_rule_waivers_file

  check_superlint -save -file [file join $prl_stamped_base_dir db ${top_design}_post_sdc.jdb]

  if {$prl_stage >= 2} {
    #####################################################################
    # Checkpoint 1: signal binding and DFT signal constraints		#
    #####################################################################
    source $common_user_signal_binding_file
    source $superlint_user_constraints_file
    reset -analyze
    check_superlint -save -file [file join $prl_stamped_base_dir db ${top_design}_post_signal_binding.jdb]
  }
  if {$prl_stage >= 3} {
    #####################################################################
    # Checkpoint 2: extract properties and lint messages		#
    #####################################################################
    check_superlint -extract
    check_superlint -save -file [file join $prl_stamped_base_dir db ${top_design}_post_extract.jdb]
  }
  if {$prl_stage >= 4} {
    #####################################################################
    # Checkpoint 3: run proof and leverage formal checks		#
    #####################################################################
    check_superlint -prove
    check_superlint -leverage
    source $superlint_core_rule_waivers_file
    source $superlint_user_rule_waivers_file
    check_superlint -save -file [file join $prl_stamped_base_dir db ${top_design}_post_leverage.jdb]
  }
}

proc CETFE_jg_superlint_report_csv {} {
  global prl_stamped_base_dir
  global top_design

  check_superlint -report -setup -force -csv -file [file join $prl_stamped_base_dir csv ${top_design}_setup.csv]
  check_superlint -report -force -waived none -csv -file [file join $prl_stamped_base_dir csv ${top_design}_summary.csv]
  check_superlint -report -property -force -csv -file [file join $prl_stamped_base_dir csv ${top_design}_property.csv] -grouping advanced -detailed
  check_superlint -report -violation -force -waived none -severity error -order tag -csv -file [file join $prl_stamped_base_dir csv ${top_design}_violation.csv] -grouping advanced -detailed
  check_superlint -report -violation -force -waived none -severity warning -order tag -csv -file [file join $prl_stamped_base_dir csv ${top_design}_warning.csv] -grouping advanced -detailed
  check_superlint -report -violation -force -waived only -order tag -csv -file [file join $prl_stamped_base_dir csv ${top_design}_waived_checks.csv] -grouping advanced -detailed
  check_superlint -report -waiver -force -csv -file [file join $prl_stamped_base_dir csv ${top_design}_waivers.csv] -detailed
  check_superlint -report -signoff -force -csv -file [file join $prl_stamped_base_dir csv ${top_design}_signoff.csv]
  check_superlint -report -test_coverage -force -csv -file [file join $prl_stamped_base_dir csv ${top_design}_test_coverage.csv]
}

proc CETFE_jg_superlint_report_text {} {
  global prl_stamped_base_dir
  global top_design

  check_superlint -report -setup -force -file [file join $prl_stamped_base_dir report ${top_design}_setup.txt]
  check_superlint -report -force -waived none -file [file join $prl_stamped_base_dir report ${top_design}_summary.txt]
  check_superlint -report -property -force -file [file join $prl_stamped_base_dir report ${top_design}_property.txt] -grouping advanced -detailed
  check_superlint -report -violation -force -waived none -severity error -order tag -file [file join $prl_stamped_base_dir report ${top_design}_violation.txt] -grouping advanced -detailed
  check_superlint -report -violation -force -waived none -severity warning -order tag -file [file join $prl_stamped_base_dir report ${top_design}_warning.txt] -grouping advanced -detailed
  check_superlint -report -violation -force -waived only -order tag -file [file join $prl_stamped_base_dir report ${top_design}_waived_checks.txt] -grouping advanced -detailed
  check_superlint -report -waiver -force -file [file join $prl_stamped_base_dir report ${top_design}_waivers.txt] -detailed
  check_superlint -report -signoff -force -file [file join $prl_stamped_base_dir report ${top_design}_signoff.txt]
  check_superlint -report -test_coverage -force -file [file join $prl_stamped_base_dir report ${top_design}_test_coverage.txt]
  set loc_icg_report [file join $prl_stamped_base_dir report ${top_design}_gated_clocks.txt]
  set loc_icg_fp [open $loc_icg_report a]
  foreach rtl_icg [check_superlint -gated_clock] {
    puts $loc_icg_fp $rtl_icg
  }
  close $loc_icg_fp
  set loc_const_report [file join $prl_stamped_base_dir report ${top_design}_constants.txt]
  set loc_const_fp [open $loc_const_report a]
  foreach any_const [check_superlint -constant any] {
    puts $loc_const_fp $any_const
  }
  close $loc_const_fp
}

proc CETFE_jg_superlint_report_html {} {
  global prl_stamped_base_dir
  global top_design

  check_superlint -report -setup -force -html -file [file join $prl_stamped_base_dir html ${top_design}_setup.html]
  check_superlint -report -force -waived none -html -file [file join $prl_stamped_base_dir html ${top_design}_summary.html]
  check_superlint -report -property -force -html -file [file join $prl_stamped_base_dir html ${top_design}_property.html] -grouping advanced -detailed
  check_superlint -report -violation -force -waived none -severity error -order tag -html -file [file join $prl_stamped_base_dir html ${top_design}_violation.html] -grouping advanced -detailed
  check_superlint -report -violation -force -waived none -severity warning -order tag -html -file [file join $prl_stamped_base_dir html ${top_design}_warning.html] -grouping advanced -detailed
  check_superlint -report -violation -force -waived only -order tag -html -file [file join $prl_stamped_base_dir html ${top_design}_waived_checks.html] -grouping advanced -detailed
  check_superlint -report -waiver -force -html -file [file join $prl_stamped_base_dir html ${top_design}_waivers.html] -detailed
  check_superlint -report -signoff -force -html -file [file join $prl_stamped_base_dir html ${top_design}_signoff.html]
  check_superlint -report -test_coverage -force -html -file [file join $prl_stamped_base_dir html ${top_design}_test_coverage.html]
}

proc CETFE_jg_superlint_report_collateral {} {
  global prl_stamped_base_dir
  global top_design

  check_superlint -configure -force -save_rule_file [file join $prl_stamped_base_dir collateral ${top_design}_rules_run.def]
  check_superlint -waiver -export -version -file_name [file join $prl_stamped_base_dir collateral ${top_design}_waivers.tcl]
  check_superlint -save -file [file join $prl_stamped_base_dir collateral ${top_design}_superlint.jdb]
}

#########################
# MCP procs		#
#########################

proc CETFE_jg_mcp_stepped_flow {} {
  global single_corner_libs
  global rtl_flow
  global top_design
  global golden_vf_file
  global hier_jdb_mod_app
  global rtl_defines
  global bbox_module_list
  global golden_netlist_file
  global golden_name_map_file
  global golden_sdc_file
  global tool_thread_count
  global prl_gui
  global prl_stage
  global prl_rule_level
  global prl_hier_flow
  global prl_debug_mode
  global prl_run_superlint
  global prl_run_cdc
  global prl_run_mcp
  global prl_run_xprop
  global prl_run_sec
  global prl_run_lpv
  global prl_user_vars_root_dir
  global prl_script_root_dir
  global prl_stamped_base_dir
  global prl_generate_reports
  global common_user_signal_binding_file
  global mcp_user_constraints_file
  global mcp_user_rule_waivers_file

  save -force -all_sessions [file join $prl_stamped_base_dir db ${top_design}_post_sdc.jdb]

  if {$prl_stage >= 2} {
    #####################################################################
    # Checkpoint 1: generate all MCP/FP properties			#
    #####################################################################
    source $common_user_signal_binding_file
    source $mcp_user_constraints_file
    check_timing_exception -generate -exception_type all
    clock -list
    check_timing_exception -list timing_exception_check
    save -force -all_sessions [file join $prl_stamped_base_dir db ${top_design}_post_generate.jdb]
  }
  if {$prl_stage >= 3} {
    #####################################################################
    # Checkpoint 2: prove all MCP/FP properties, source waivers		#
    #####################################################################
    check_timing_exception -prove -threads $tool_thread_count
    source $mcp_user_rule_waivers_file
    save -force -all_sessions [file join $prl_stamped_base_dir db ${top_design}_post_prove.jdb]
  }
}

proc CETFE_jg_mcp_report_text {} {
  global prl_stamped_base_dir
  global top_design

  check_timing_exception -report -force -file [file join $prl_stamped_base_dir report ${top_design}_report_summary.txt]
  check_timing_exception -report -force -file [file join $prl_stamped_base_dir report ${top_design}_report_detailed.txt] -detailed
  check_timing_exception -audit -force -file [file join $prl_stamped_base_dir report ${top_design}_audit_summary.txt]
  check_timing_exception -audit -force -file [file join $prl_stamped_base_dir report ${top_design}_audit_detailed.txt] -detailed
  set loc_waiver_report [file join $prl_stamped_base_dir report ${top_design}_waivers.txt]
  set loc_waiver_fp [open $loc_waiver_report a]
  foreach waiver_list [check_timing_exception -waiver -list] {
    puts $loc_waiver_fp $waiver_list
  }
  close $loc_waiver_fp
}

proc CETFE_jg_mcp_report_collateral {} {
  global prl_stamped_base_dir
  global top_design

  check_timing_exception -waiver -export -force -file [file join $prl_stamped_base_dir collateral ${top_design}_exported_waivers.tcl]
  check_timing_exception -export -force -to [file join $prl_stamped_base_dir collateral ${top_design}_to_xcelium_tcv.json]
}

#########################
# XPROP procs		#
#########################

proc CETFE_jg_xprop_report_reset_info {} {
  global prl_stamped_base_dir
  global top_design

  set loc_design_info_report [file join $prl_stamped_base_dir report ${top_design}_design_info.txt]
  redirect -file $loc_design_info_report -force {get_design_info}
  set loc_reset_convergence_report [file join $prl_stamped_base_dir report ${top_design}_reset_convergence.txt]
  set loc_reset_convergence_fp [open $loc_reset_convergence_report a]
  puts $loc_reset_convergence_fp [format "%s%s" "Total cycles required for reset convergence: " [get_reset_info -get_length]]
  close $loc_reset_convergence_fp
  set loc_reset_unstable_report [file join $prl_stamped_base_dir report ${top_design}_reset_unstable.txt]
  set loc_reset_unstable_fp [open $loc_reset_unstable_report a]
  puts $loc_reset_unstable_fp "The following registers did not converge by the end of reset analysis:\n"
  foreach lru [get_reset_info -get_unstable] {
    puts $loc_reset_unstable_fp $lru
  }
  close $loc_reset_unstable_fp
  set loc_const_reg_report [file join $prl_stamped_base_dir report ${top_design}_constant_flops.txt]
  set loc_const_reg_fp [open $loc_const_reg_report a]
  puts $loc_const_reg_fp "The following registers have a constant value after reset:\n"
  foreach lcr [get_reset_info -constant_registers] {
    puts $loc_const_reg_fp $lcr
  }
  close $loc_const_reg_fp
  set loc_all_uninit_report [file join $prl_stamped_base_dir report ${top_design}_all_uninit.txt]
  set loc_all_uninit_fp [open $loc_all_uninit_report a]
  puts $loc_all_uninit_fp "The following flops are uninitialized after reset (format: <instance> <state> <type> <cycle> <module>):\n"
  foreach lau [get_reset_info -x_value -list type cycle module -sort_by module] {
    puts $loc_all_uninit_fp $lau
  }
  close $loc_all_uninit_fp
  set loc_async_reset_uninit_report [file join $prl_stamped_base_dir report ${top_design}_async_reset_uninit.txt]
  set loc_async_reset_uninit_fp [open $loc_async_reset_uninit_report a]
  puts $loc_async_reset_uninit_fp "The following asynchronously reset flops are uninitialized after reset (format: <instance> <state> <type> <cycle> <module>):\n"
  foreach laru [get_reset_info -x_value -with_reset_pin -list type cycle module -sort_by module] {
    puts $loc_async_reset_uninit_fp $laru
  }
  close $loc_async_reset_uninit_fp
}

proc CETFE_jg_xprop_source_and_target_setup {} {
  global prl_stamped_base_dir
  global xprop_src_targ
  global top_design

  catch {task -remove XPROP}
  task -create XPROP -set
  set loc_sources_report [file join $prl_stamped_base_dir report ${top_design}_x_sources_selected.txt]
  set loc_targets_report [file join $prl_stamped_base_dir report ${top_design}_x_targets_selected.txt]
  set loc_sources_fp [open $loc_sources_report a]
  set loc_targets_fp [open $loc_targets_report a]
  dict for {index value} $xprop_src_targ {
    set loc_bool_to_on_off [CETFE_jg_boolean_to_on_off $value]
    if {$index eq "src_uninit_regs"} {
      set_xprop_use_reset_state $loc_bool_to_on_off -task XPROP
      puts $loc_sources_fp [format "%-40s%-5s" "set_xprop_use_reset_state" $loc_bool_to_on_off]
    } elseif {$index eq "src_bbox_outputs"} {
      set_xprop_use_bbox_outputs $loc_bool_to_on_off -task XPROP
      puts $loc_sources_fp [format "%-40s%-5s" "set_xprop_use_bbox_outputs" $loc_bool_to_on_off]
    } elseif {$index eq "src_bus_contention"} {
      set_xprop_use_bus_contention $loc_bool_to_on_off -task XPROP
      puts $loc_sources_fp [format "%-40s%-5s" "set_xprop_use_bus_contention" $loc_bool_to_on_off]
    } elseif {$index eq "src_bus_floating"} {
      set_xprop_use_bus_floating $loc_bool_to_on_off -task XPROP
      puts $loc_sources_fp [format "%-40s%-5s" "set_xprop_use_bus_floating" $loc_bool_to_on_off]
    } elseif {$index eq "src_int_undriven"} {
      set_xprop_use_internal_undriven $loc_bool_to_on_off -task XPROP
      puts $loc_sources_fp [format "%-40s%-5s" "set_xprop_use_internal_undriven" $loc_bool_to_on_off]
    } elseif {$index eq "src_input_ports"} {
      set_xprop_use_inputs $loc_bool_to_on_off -task XPROP
      puts $loc_sources_fp [format "%-40s%-5s" "set_xprop_use_inputs" $loc_bool_to_on_off]
    } elseif {$index eq "src_stopats"} {
      set_xprop_use_stopats $loc_bool_to_on_off -task XPROP
      puts $loc_sources_fp [format "%-40s%-5s" "set_xprop_use_stopats" $loc_bool_to_on_off]
    } elseif {$index eq "src_reg_rst_abst"} {
      set_xprop_use_reset_abstraction $loc_bool_to_on_off -task XPROP
      puts $loc_sources_fp [format "%-40s%-5s" "set_xprop_use_reset_abstraction" $loc_bool_to_on_off]
    } elseif {$index eq "src_reg_init_abst"} {
      set_xprop_use_init_abstraction $loc_bool_to_on_off -task XPROP
      puts $loc_sources_fp [format "%-40s%-5s" "set_xprop_use_init_abstraction" $loc_bool_to_on_off]
    }
  }
  dict for {index value} $xprop_src_targ {
    set loc_bool_to_on_off [CETFE_jg_boolean_to_on_off $value]
    if {$loc_bool_to_on_off eq "on"} {
      if {$index eq "targ_clk_and_rst"} {
	check_xprop -create -clocks_and_resets -task XPROP
	puts $loc_targets_fp [format "%-60s%-5s" "clocks_and_resets" $loc_bool_to_on_off]
      } elseif {$index eq "targ_control"} {
	check_xprop -create -control -no_flops_with_reset_pin -include_sync_resets -task XPROP
	puts $loc_targets_fp [format "%-60s%-5s" "control no_flops_with_reset_pin include_sync_resets" $loc_bool_to_on_off]
      } elseif {$index eq "targ_data"} {
	check_xprop -create -data -task XPROP
	puts $loc_targets_fp [format "%-60s%-5s" "data" $loc_bool_to_on_off]
      } elseif {$index eq "targ_index"} {
	check_xprop -create -index -task XPROP
	puts $loc_targets_fp [format "%-60s%-5s" "index" $loc_bool_to_on_off]
      } elseif {$index eq "targ_output_ports"} {
	check_xprop -create -outputs -task XPROP
	puts $loc_targets_fp [format "%-60s%-5s" "outputs" $loc_bool_to_on_off]
      } elseif {$index eq "targ_bbox_inputs"} {
	check_xprop -create -bbox_inputs -task XPROP
	puts $loc_targets_fp [format "%-60s%-5s" "bbox_inputs" $loc_bool_to_on_off]
      } elseif {$index eq "targ_reg_rst_pin"} {
	check_xprop -create -flops_with_reset_pin -include_sync_resets -task XPROP
	puts $loc_targets_fp [format "%-60s%-5s" "flops_with_reset_pin include_sync_resets" $loc_bool_to_on_off]
      } elseif {$index eq "targ_reg_rst_val"} {
	check_xprop -create -flops_with_reset_value -include_sync_resets -task XPROP
	puts $loc_targets_fp [format "%-60s%-5s" "flops_with_reset_value" $loc_bool_to_on_off]
      } elseif {$index eq "targ_counter"} {
	check_xprop -create -counters -task XPROP
	puts $loc_targets_fp [format "%-60s%-5s" "counters" $loc_bool_to_on_off]
      } elseif {$index eq "targ_fsm"} {
	check_xprop -create -fsms -task XPROP
	puts $loc_targets_fp [format "%-60s%-5s" "fsms" $loc_bool_to_on_off]
      }
    }
  }
  close $loc_sources_fp
  close $loc_targets_fp
}

proc CETFE_jg_xprop_stepped_flow {} {
  global single_corner_libs
  global rtl_flow
  global top_design
  global golden_vf_file
  global hier_jdb_mod_app
  global xprop_src_targ
  global rtl_defines
  global bbox_module_list
  global golden_netlist_file
  global golden_name_map_file
  global golden_sdc_file
  global tool_thread_count
  global prl_gui
  global prl_stage
  global prl_rule_level
  global prl_hier_flow
  global prl_debug_mode
  global prl_run_superlint
  global prl_run_cdc
  global prl_run_mcp
  global prl_run_xprop
  global prl_run_sec
  global prl_run_lpv
  global prl_user_vars_root_dir
  global prl_script_root_dir
  global prl_stamped_base_dir
  global prl_generate_reports
  global common_user_signal_binding_file
  global common_user_reset_sequence_file
  global xprop_user_assertion_file
  global xprop_user_rule_waivers_file

  save -force -all_sessions [file join $prl_stamped_base_dir db ${top_design}_post_sdc.jdb]

  if {$prl_stage >= 2} {
    #####################################################################
    # Checkpoint 1: run reset, setup X-sources/targets, report flops	#
    #####################################################################
    source $common_user_signal_binding_file
    CETFE_jg_load_reset_sequence
    source $xprop_user_assertion_file
    CETFE_jg_xprop_source_and_target_setup
    CETFE_jg_xprop_report_reset_info
    save -force -all_sessions [file join $prl_stamped_base_dir db ${top_design}_post_setup.jdb]
  }
  if {$prl_stage >= 3} {
    #####################################################################
    # Checkpoint 2: run proof, source waivers				#
    #####################################################################
    foreach found_task [task -list -silent] {
      check_xprop -prove -task ${found_task}
    }
    source $xprop_user_rule_waivers_file
    save -force -all_sessions [file join $prl_stamped_base_dir db ${top_design}_post_prove.jdb]
  }
}

proc CETFE_jg_xprop_report_csv {} {
  global prl_stamped_base_dir
  global top_design

  check_xprop -report source -csv -file [file join $prl_stamped_base_dir csv ${top_design}_x_sources.csv]
# check_xprop -report reason -detailed -csv -file [file join $prl_stamped_base_dir csv ${top_design}_x_reasons.csv]
  check_xprop -report -force -csv -file [file join $prl_stamped_base_dir csv ${top_design}_total_property_summary.csv]
  check_xprop -report -waived only -force -csv -file [file join $prl_stamped_base_dir csv ${top_design}_waived_property_summary.csv]
  check_xprop -report -waived none -force -csv -file [file join $prl_stamped_base_dir csv ${top_design}_unwaived_property_summary.csv]
}

proc CETFE_jg_xprop_report_text {} {
  global prl_stamped_base_dir
  global top_design

  check_xprop -report source -file [file join $prl_stamped_base_dir report ${top_design}_x_sources.txt]
# check_xprop -report reason -detailed -file [file join $prl_stamped_base_dir report ${top_design}_x_reasons.txt]
  check_xprop -report -force -file [file join $prl_stamped_base_dir report ${top_design}_total_property_summary.txt]
  check_xprop -report -waived only -force -file [file join $prl_stamped_base_dir report ${top_design}_waived_property_summary.txt]
  check_xprop -report -waived none -force -file [file join $prl_stamped_base_dir report ${top_design}_unwaived_property_summary.txt]
}

proc CETFE_jg_xprop_report_html {} {
  global prl_stamped_base_dir
  global top_design

  check_xprop -report -force -html -file [file join $prl_stamped_base_dir html ${top_design}_total_property_summary.html]
  check_xprop -report -waived only -force -html -file [file join $prl_stamped_base_dir html ${top_design}_waived_property_summary.html]
  check_xprop -report -waived none -force -html -file [file join $prl_stamped_base_dir html ${top_design}_unwaived_property_summary.html]
}

proc CETFE_jg_xprop_report_collateral {} {
  global prl_stamped_base_dir
  global top_design

  set loc_waiver_count [llength [check_xprop -waiver -list -silent]]
  if {$loc_waiver_count > 0} {
    check_xprop -waiver -list
    check_xprop -waiver -export -file_name [file join $prl_stamped_base_dir collateral ${top_design}_waivers.tcl]
  }
  check_xprop -export -include_disable_iff -env -file [file join $prl_stamped_base_dir collateral ${top_design}_to_xcelium.db]
}
