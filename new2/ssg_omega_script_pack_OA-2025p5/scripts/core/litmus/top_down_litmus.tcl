################################################################################
# Copyright (c) 2024 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       #
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
# TCL proc definitions unique to Litmus1 flow		#
#########################################################

set ::_constraint_statement_(set_units) ""

proc set_units {args} {
  array unset _cmd_info_; array set _cmd_info_ [info frame -2]
  set _cmd_str_ ${_cmd_info_(cmd)}
  array unset _cmd_info_; array set _cmd_info_ [info frame -3]
  set _cmd_file_ [lindex ${_cmd_info_(cmd)} end]
  set _cmd_line_ ${_cmd_info_(line)}
  puts "Info : ${_cmd_file_}:${_cmd_line_} : ${_cmd_str_}"
  lappend ::_constraint_statement_(set_units) [list ${_cmd_file_}:${_cmd_line_} ${_cmd_str_}]
  return -code ok
}

proc CETFE_get_port_constraints {args} {
  switch -- [parse_options "CETFE_get_port_constraints" {} $args \
                "-port_dir srs collect information for this port direction" \
                port_dir \
                "-fp srs name of previously opened file pointer" \
                loc_fp \
            ] {
               -2 { return }
                0 { error "Failed on CETFE_get_port_constraints" }
              }
  global var_prefix
  foreach dp [get_db ports -if {.direction == $port_dir}] {
    set loc_port_name [get_db $dp .name]
    set loc_constraints [get_db $dp .${var_prefix}_constraint_object]
    puts $loc_fp "\n${loc_port_name}"
    foreach lc $loc_constraints {
      puts $loc_fp "    $lc"
    }
  }
}

#########################################################
# Manipulate user variables and perform error checking	#
#########################################################

set hier_inst_sdc [dict create]
set hier_option_list [list]
set hier_inst_list [list]
set golden_vf_file [dict create]

if {[file readable ./omega_local_user_vars.tcl]} {
  source -echo ./omega_local_user_vars.tcl
} else {
  puts [format "%s%s" "Err" "or   : expected user input file ./omega_local_user_vars.tcl not found."]
  exit
}

set global_tcl_utils_file            "$prl_script_root_dir/../common/TclUtils.tcl"
set global_command_merge_file        "$prl_script_root_dir/../common/MergeCommandFile.pl"
set litmus_core_attr_file            "$prl_script_root_dir/litmus_core_attributes.tcl"
set litmus_core_rule_filter_file     "$prl_script_root_dir/litmus_core_rule_filters.tcl"
set litmus_user_attr_file            "$prl_script_root_dir/../../user/litmus/litmus_user_attributes.tcl"
set litmus_user_mmmc_file            "$prl_script_root_dir/../../user/litmus/litmus_user_mmmc.tcl"
set litmus_user_hier_clock_file      "$prl_script_root_dir/../../user/litmus/litmus_user_hier_clock_mapping.tcl"
set litmus_user_rule_filter_file     "$prl_script_root_dir/../../user/litmus/litmus_user_rule_filters.tcl"
set litmus_user_additional_args_file "$prl_script_root_dir/../../user/litmus/litmus_user_additional_args.tcl"

foreach cif [list $global_tcl_utils_file $global_command_merge_file $litmus_core_attr_file \
		  $litmus_core_rule_filter_file $litmus_user_attr_file $litmus_user_mmmc_file \
		  $litmus_user_hier_clock_file $litmus_user_rule_filter_file $litmus_user_additional_args_file] {
  if {![file readable $cif]} {
    puts [format "%s%s%s" "Err" "or   : expected input file not readable - " $cif]
    exit
  }
}

source -echo $global_tcl_utils_file

CETFE_manipulate_omega_user_vars "litmus1"
CETFE_validate_omega_user_vars "litmus1"

if {($prl_no_libs == 0) && ($use_mmmc == 0) && ([llength $single_corner_libs] == 0)} {
  puts [format "%s%s" "Err" "or   : if \"use_mmmc\" is 0 and \"single_corner_libs\" remains empty in"]
  puts [format "%s%s" "Err" "or   : omega_user_vars.tcl, then the \"-nolib\" option must be given to RunLitmus.pl"]
  exit
}

set_db init_hdl_search_path $prl_rtl_search_path

set ltms_invoked_version [get_db program_major_version]
if {$prl_use_litmusX == 1} {
  if {$ltms_invoked_version < 25.1} {
    puts [format "%s%s" "Err" "or   : LitmusX is packaged in the SSV bundle and requires a release version of at least 25.10."]
    puts [format "%s%s" "Err" "or   : Check your Litmus installation to make sure you are actually running LitmusX."]
    exit
  } else {
    puts [format "%s%s" "In" "fo    : Currently running LitmusX."]
    set var_prefix "ltms"
  }
} else {
  if {$ltms_invoked_version >= 24} {
    puts [format "%s%s" "Err" "or   : Litmus1 is only available up to the 23.2* tool stream; check your Litmus installation"]
    puts [format "%s%s" "Err" "or   : to make sure you are actually running Litmus1."]
    exit
  } elseif {$ltms_invoked_version < 23} {
    puts [format "%s%s" "Err" "or   : These scripts require the 23.2* tool stream of Litmus1."]
    exit
  } else {
    puts [format "%s%s" "In" "fo    : Currently running Litmus1."]
    set var_prefix "cfm"
  }
}

if {$prl_hier_flow == 1} {
  if {$use_mmmc == 1} {
    puts [format "%s%s" "Err" "or   : The hierarchical SDC comparison flow cannot be run in MMMC mode."]
    exit
  } elseif {[dict size $hier_inst_sdc] == 0} {
    puts [format "%s%s" "Err" "or   : The hierarchical SDC comparison flow has been selected, however"]
    puts [format "%s%s" "Err" "or   : there are no instances defined in hier_inst_sdc."]
    exit
  }
  dict for {inst path} $hier_inst_sdc {
    lappend hier_option_list "-scope_name $inst -scope_constraints $path"
  }
  set hier_option_list [regsub -all "\{|\}" $hier_option_list ""]
  set hier_inst_list [dict keys $hier_inst_sdc]
} else {
  if {[dict size $hier_inst_sdc] > 0} {
    puts [format "%s%s" "Warn" "ing : The flat SDC flow has been selected, however the hier_inst_sdc dictionary"]
    puts [format "%s%s" "Warn" "ing : is not empty. Proceeding with the flat SDC flow."]
  }
}

if {$prl_force_run == 1} {
  set_dofile_abort off
} else {
  set_dofile_abort exit
}

redirect [file join $prl_stamped_base_dir modified_rules ${top_design}_initial_rule_settings.txt] {report_rule_check -overview}

#########################################################
# Load additional args and attribute files		#
#########################################################

source -echo $litmus_user_additional_args_file
source -echo $litmus_core_attr_file
source -echo $litmus_user_attr_file

#########################################################
# Initial setup						#
#########################################################

usage -auto -elapse

set_multi_cpu_usage -keep_license true -local_cpu $tool_thread_count

set_log_file [file join $prl_stamped_base_dir litmus_session.log] -progress -replace

set define_cmd ""
if {$rtl_defines ne [list]} {
  set define_cmd "-define \{$rtl_defines\}"
}

#########################################################
# Apply rule filters					#
#########################################################

source -echo $litmus_core_rule_filter_file
source -echo $litmus_user_rule_filter_file
redirect [file join $prl_stamped_base_dir applied_filter ${top_design}_specified_rule_filters.txt] {report_rule_filter}

#########################################################
# Load library views					#
#########################################################

if {$prl_no_libs == 1} {
  puts [format "%s%s" "In" "fo    : The -nolib option was given to RunLitmus.pl, therefore no library data will be loaded for this run."]
} else {
  if {$use_mmmc == 1} {
    read_mmmc $litmus_user_mmmc_file
  } else {
    set additional_args [list]
    if {[info exists read_libs_omega_args]} {
      set additional_args $read_libs_omega_args
    }
    eval "read_libs $single_corner_libs $additional_args"
  }
}

#########################################################
# Load design and perform design-rule linting		#
#########################################################

if {[llength $bbox_module_list] != 0} {
  add_notranslate_modules $bbox_module_list
}

if {$rtl_flow == 1} {
  if {[dict size $golden_vf_file] == 0} {
    puts [format "%s%s" "Err" "or   : RTL-level analysis has been selected, however there are"]
    puts [format "%s%s" "Err" "or   : no input filelists defined in golden_vf_file."]
    exit
  } else {
    dict for {flist lrm} $golden_vf_file {
      eval "read_hdl -language $lrm $define_cmd -f $flist"
    }
  }
  set additional_args [list]
  if {[info exists elaborate_omega_args]} {
    set additional_args $elaborate_omega_args
  }
  eval "elaborate $top_design $additional_args"
} else {
  read_netlist -top $top_design $golden_netlist_file
}
redirect [file join $prl_stamped_base_dir report ${top_design}_design_lint_report.txt] {report_rule_check -verbose -rule_separation 1 -category library_design -status fail}
report_rule_check -verbose -rule_separation 1 -category library_design -status fail -no_header -spreadsheet [file join $prl_stamped_base_dir xlsx ${top_design}_design_lint_report.xlsx]
write_db [file join $prl_stamped_base_dir db ${top_design}_elaborate.db]

#########################################################
# Read SDC and perform SDC linting			#
#########################################################

if {$prl_hier_flow == 1} {
  eval read_hierarchical_sdc -top $golden_sdc_file $hier_option_list
} else {
  if {$use_mmmc == 0} {
    read_sdc $golden_sdc_file
  } else {
    puts [format "%s%s" "In" "fo    : the SDC file was taken from the first analysis view defined in the MMMC file."]
  }
}

init_design
redirect [file join $prl_stamped_base_dir report ${top_design}_library_lint_report.txt] {report_rule_check -verbose -rule_separation 1 -category lib_lint -status fail}
report_rule_check -verbose -rule_separation 1 -category lib_lint -status fail -no_header -spreadsheet [file join $prl_stamped_base_dir xlsx ${top_design}_library_lint_report.xlsx]
redirect [file join $prl_stamped_base_dir report ${top_design}_black_box_report.txt] {report_black_box -detail}
redirect [file join $prl_stamped_base_dir report ${top_design}_design_instance_report.txt] {report_design_data -verbose}
redirect [file join $prl_stamped_base_dir report ${top_design}_libcell_instance_report.txt] {report_library_data -skip_unref -sort name}
redirect [file join $prl_stamped_base_dir report ${top_design}_sdc_summary.txt] {report_sdc}
redirect -append [file join $prl_stamped_base_dir report ${top_design}_sdc_summary.txt] {report_sdc -verbose -status fail}
redirect -append [file join $prl_stamped_base_dir report ${top_design}_sdc_summary.txt] {report_sdc -verbose -status inactive}
redirect [file join $prl_stamped_base_dir report ${top_design}_sdc_lint_report.txt] {report_rule_check -verbose -rule_separation 1 -category constraint_lint -status fail}
report_rule_check -verbose -rule_separation 1 -category constraint_lint -status fail -no_header -spreadsheet [file join $prl_stamped_base_dir xlsx ${top_design}_sdc_lint_report.xlsx]
redirect [file join $prl_stamped_base_dir report ${top_design}_clock_group_report.txt] {report_clock_group}
report_clocks               >  [file join $prl_stamped_base_dir report ${top_design}_clock_relationship_report.txt]
report_clocks -hierarchy    >> [file join $prl_stamped_base_dir report ${top_design}_clock_relationship_report.txt]
report_case_analysis -dir   >  [file join $prl_stamped_base_dir report ${top_design}_case_analysis_report.txt]
set_table_style -no_frame_fix_width -nosplit
report_path_exceptions -all >  [file join $prl_stamped_base_dir report ${top_design}_path_exceptions_report.txt]
set_table_style -frame
write_db [file join $prl_stamped_base_dir db ${top_design}_sdc_lint.db]

#########################################################
# Verify design modeling				#
#########################################################

if {$prl_hier_flow == 0} {
  verify_design_modeling -force
  redirect [file join $prl_stamped_base_dir report ${top_design}_modeling_lint_report.txt] {report_rule_check -verbose -rule_separation 1 -category modeling_rules -status fail}
  report_rule_check -verbose -rule_separation 1 -category modeling_rules -status fail -no_header -spreadsheet [file join $prl_stamped_base_dir xlsx ${top_design}_modeling_lint_report.xlsx]
  write_db [file join $prl_stamped_base_dir db ${top_design}_modeling.db]
}

#########################################################
# Verify SDC timing intent				#
#########################################################

set timing_intent_lint_report [file join $prl_stamped_base_dir report ${top_design}_timing_intent_lint_report.txt]
if {$prl_hier_flow == 1} {
  source -echo $litmus_user_hier_clock_file
  redirect [file join $prl_stamped_base_dir report ${top_design}_hier_clock_map_report.txt] {report_hierarchical_clock_mapping}
  eval verify_hierarchical_timing_intent -force -scope_names [list $hier_inst_list]
  redirect $timing_intent_lint_report {report_rule_check -verbose -rule_separation 1 -category constraint_hier_signoff -status fail -attribute CONST_HIER_SCA* CONST_HIER_CLK* CONST_HIER_UNC* CONST_HIER_LAT*}
  redirect -append $timing_intent_lint_report {report_rule_check -verbose -rule_separation 1 -category constraint_hier_signoff -status fail -attribute CONST_HIER_CTR* CONST_HIER_GRP* CONST_HIER_CG* CONST_HIER_PLS*}
  redirect -append $timing_intent_lint_report {report_rule_check -verbose -rule_separation 1 -category constraint_hier_signoff -status fail -attribute CONST_HIER_IO* CONST_HIER_OLD* CONST_HIER_EXC* CONST_HIER_SDT*}
  redirect -append $timing_intent_lint_report {report_rule_check -verbose -rule_separation 1 -category constraint_hier_signoff -status fail -attribute CONST_HIER_TIM* CONST_HIER_DAT* CONST_HIER_HFN*}
  report_rule_check -verbose -rule_separation 1 -category constraint_hier_signoff -status fail -attribute -no_header -spreadsheet [file join $prl_stamped_base_dir xlsx ${top_design}_timing_intent_lint_report.xlsx]
} else {
  verify_timing_intent -force
  redirect $timing_intent_lint_report {report_rule_check -verbose -rule_separation 1 -category constraint_signoff -status fail -attribute CONST_SCA_*}
  redirect -append $timing_intent_lint_report {report_rule_check -verbose -rule_separation 1 -category constraint_signoff -status fail -attribute CONST_CLK_* CONST_CG_*}
  redirect -append $timing_intent_lint_report {report_rule_check -verbose -rule_separation 1 -category constraint_signoff -status fail -attribute CONST_IO_*}
  redirect -append $timing_intent_lint_report {report_rule_check -verbose -rule_separation 1 -category constraint_signoff -status fail -attribute CONST_EXC_*}
  redirect -append $timing_intent_lint_report {report_rule_check -verbose -rule_separation 1 -category constraint_signoff -status fail -attribute CONST_DGN_* CONST_DAT_* CONST_HFN_*}
  report_rule_check -verbose -rule_separation 1 -category constraint_signoff -status fail -attribute -no_header -spreadsheet [file join $prl_stamped_base_dir xlsx ${top_design}_timing_intent_lint_report.xlsx]
}
set additional_args [list]
if {[info exists report_analysis_coverage_omega_args]} {
  set additional_args $report_analysis_coverage_omega_args
}
eval "report_analysis_coverage -include_dyn_checks -verbose {violated untested} $additional_args" > [file join $prl_stamped_base_dir report ${top_design}_analysis_coverage.txt]
set additional_args [list]
if {[info exists check_timing_omega_args]} {
  set additional_args $check_timing_omega_args
}
eval "check_timing -verbose $additional_args" > [file join $prl_stamped_base_dir report ${top_design}_check_timing_report.txt]
write_db [file join $prl_stamped_base_dir db ${top_design}_timing_intent.db]
redirect [file join $prl_stamped_base_dir applied_filter ${top_design}_applied_rule_filters.txt] {report_rule_filter}
redirect [file join $prl_stamped_base_dir modified_rules ${top_design}_final_rule_settings.txt] {report_rule_check -overview}
write_sdc [file join $prl_stamped_base_dir collateral ${top_design}_flattened.sdc]

#########################################################
# Custom validation					#
#########################################################

set final_error_report [file join $prl_stamped_base_dir report ${top_design}_severity_error_fail_summary.txt]
redirect $final_error_report {report_rule_check -summary -status fail -severity error}
report_rule_check -summary -status fail -severity error -no_header -spreadsheet [file join $prl_stamped_base_dir xlsx ${top_design}_severity_error_fail_summary.xlsx]

foreach cs [get_db constraint_statements] {
  if {[get_db $cs .${var_prefix}_sdc_version] < 2.1} {
    redirect -append $final_error_report { \
    puts [format "%s%s" "Err" "or   : The following SDC command uses syntax older than version 2.1.\
    All commands must be compliant with at least version 2.1 of the SDC standard."]}
    redirect -append $final_error_report { \
    puts [format "%s%s" "          Command: " [get_db $cs .${var_prefix}_command_string]]}
    redirect -append $final_error_report { \
    puts [format "%s%s" "          In file: " [get_db $cs .${var_prefix}_file_location]]}
    redirect -append $final_error_report { \
    puts [format "%s%s" "          On line: " [get_db $cs .${var_prefix}_file_start_line]]}
  }
}

if {[llength $::_constraint_statement_(set_units)] == 0} {
  redirect -append $final_error_report { \
  puts [format "%s%s" "Err" "or   : The SDC file does not have units defined. All SDC files\
  must have at least one \"set_units\" command."]}
}

set port_constraint_report [file join $prl_stamped_base_dir report ${top_design}_port_sdc_report.txt]
set pcr_fp [open $port_constraint_report a]
if {[llength [get_db ports -if {.direction == in}]] != 0} {
  puts $pcr_fp "#######################\n# SDCs on input ports #\n#######################"
  CETFE_get_port_constraints -port_dir "in" -fp $pcr_fp
}
if {[llength [get_db ports -if {.direction == out}]] != 0} {
  puts $pcr_fp "\n########################\n# SDCs on output ports #\n########################"
  CETFE_get_port_constraints -port_dir "out" -fp $pcr_fp
}
if {[llength [get_db ports -if {.direction == inout}]] != 0} {
  puts $pcr_fp "\n#######################\n# SDCs on inout ports #\n#######################"
  CETFE_get_port_constraints -port_dir "inout" -fp $pcr_fp
}

if {$prl_invoke_gui == 1} {
  gui_show
}

if {($prl_debug_mode == 0) && ($prl_invoke_gui == 0)} {
  exit
}
