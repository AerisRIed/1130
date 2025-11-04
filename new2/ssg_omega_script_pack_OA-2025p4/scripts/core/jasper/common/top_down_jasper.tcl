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
# Manipulate user variables and load scripts		#
#########################################################

set golden_vf_file [dict create]
set hier_jdb_mod_app [dict create]

if {[file readable ./omega_local_user_vars.tcl]} {
  source ./omega_local_user_vars.tcl
} else {
  puts [format "%s%s" "Err" "or   : expected user input file ./omega_local_user_vars.tcl not found."]
  exit
}

set global_tcl_utils_file                "$prl_script_root_dir/../../common/TclUtils.tcl"
set global_command_merge_file            "$prl_script_root_dir/../../common/MergeCommandFile.pl"
set common_core_utils_file               "$prl_script_root_dir/jasper_common_core_utils.tcl"
set common_core_message_settings_file    "$prl_script_root_dir/jasper_common_core_message_settings.tcl"
set common_user_signal_binding_file      "$prl_script_root_dir/../../../user/jasper/common/jasper_common_user_signal_binding.tcl"
set common_user_additional_args_file     "$prl_script_root_dir/../../../user/jasper/common/jasper_common_user_additional_args.tcl"
set common_user_message_settings_file    "$prl_script_root_dir/../../../user/jasper/common/jasper_common_user_message_settings.tcl"
set cdc_core_rule_waivers_file           "$prl_script_root_dir/../cdc/jasper_cdc_core_rule_waivers.tcl"
set cdc_core_message_settings_file       "$prl_script_root_dir/../cdc/jasper_cdc_core_message_settings.tcl"
set cdc_core_rtl_rules_file              "$prl_script_root_dir/../cdc/jasper_cdc_core_rules_rtl.tcl"
set cdc_core_gate_rules_file             "$prl_script_root_dir/../cdc/jasper_cdc_core_rules_gate.tcl"
set cdc_core_rule_settings_file          "$prl_script_root_dir/../cdc/jasper_cdc_core_rule_settings.tcl"
set cdc_user_rule_waivers_file           "$prl_script_root_dir/../../../user/jasper/cdc/jasper_cdc_user_rule_waivers.tcl"
set cdc_user_message_settings_file       "$prl_script_root_dir/../../../user/jasper/cdc/jasper_cdc_user_message_settings.tcl"
set cdc_user_constraints_file            "$prl_script_root_dir/../../../user/jasper/cdc/jasper_cdc_user_constraints.tcl"
set cdc_user_rule_settings_file          "$prl_script_root_dir/../../../user/jasper/cdc/jasper_cdc_user_rule_settings.tcl"
set superlint_core_rules_file            "$prl_script_root_dir/../superlint/jasper_superlint_core_rules.tcl"
set superlint_core_message_settings_file "$prl_script_root_dir/../superlint/jasper_superlint_core_message_settings.tcl"
set superlint_core_rule_settings_file    "$prl_script_root_dir/../superlint/jasper_superlint_core_rule_settings.tcl"
set superlint_core_rule_waivers_file     "$prl_script_root_dir/../superlint/jasper_superlint_core_rule_waivers.tcl"
set superlint_user_constraints_file      "$prl_script_root_dir/../../../user/jasper/superlint/jasper_superlint_user_constraints.tcl"
set superlint_user_message_settings_file "$prl_script_root_dir/../../../user/jasper/superlint/jasper_superlint_user_message_settings.tcl"
set superlint_user_rule_settings_file    "$prl_script_root_dir/../../../user/jasper/superlint/jasper_superlint_user_rule_settings.tcl"
set superlint_user_rule_waivers_file     "$prl_script_root_dir/../../../user/jasper/superlint/jasper_superlint_user_rule_waivers.tcl"
set mcp_core_message_settings_file       "$prl_script_root_dir/../mcp/jasper_mcp_core_message_settings.tcl"
set mcp_user_constraints_file            "$prl_script_root_dir/../../../user/jasper/mcp/jasper_mcp_user_constraints.tcl"
set mcp_user_message_settings_file       "$prl_script_root_dir/../../../user/jasper/mcp/jasper_mcp_user_message_settings.tcl"
set mcp_user_rule_waivers_file           "$prl_script_root_dir/../../../user/jasper/mcp/jasper_mcp_user_rule_waivers.tcl"

foreach cif [list $global_tcl_utils_file $global_command_merge_file $common_core_utils_file $common_core_message_settings_file \
		  $common_user_signal_binding_file $common_user_additional_args_file $common_user_message_settings_file \
		  $cdc_core_rule_waivers_file $cdc_core_message_settings_file $cdc_core_rtl_rules_file $cdc_core_gate_rules_file \
		  $cdc_core_rule_settings_file $cdc_user_rule_waivers_file $cdc_user_message_settings_file $cdc_user_constraints_file \
		  $cdc_user_rule_settings_file $superlint_core_rules_file $superlint_core_message_settings_file \
		  $superlint_core_rule_settings_file $superlint_core_rule_waivers_file $superlint_user_constraints_file \
		  $superlint_user_message_settings_file $superlint_user_rule_settings_file $superlint_user_rule_waivers_file \
		  $mcp_core_message_settings_file $mcp_user_constraints_file $mcp_user_message_settings_file $mcp_user_rule_waivers_file] {
  if {![file readable $cif]} {
    puts [format "%s%s%s" "Err" "or   : expected input file not readable - " $cif]
    exit 1
  }
}

source $global_tcl_utils_file
source $common_core_utils_file

CETFE_manipulate_omega_user_vars "jasper"
CETFE_validate_omega_user_vars "jasper"

#########################################################
# Setup flow, load design and library, elaborate	#
#########################################################

CETFE_jg_initial_setup
CETFE_jg_hier_setup
CETFE_jg_load_rulefile
CETFE_jg_analyze_design
CETFE_jg_load_liberty
CETFE_jg_elaborate_design
CETFE_jg_hier_load
CETFE_jg_load_sdc

#########################################################
# Run specific App flow					#
#########################################################

if {$prl_run_cdc} {
  CETFE_jg_cdc_stepped_flow
} elseif {$prl_run_superlint} {
  CETFE_jg_superlint_stepped_flow
} elseif {$prl_run_mcp} {
  CETFE_jg_mcp_stepped_flow
}

#########################################################
# Report generation					#
#########################################################

if {$prl_generate_reports} {
  ###############################
  # To csv directory		#
  ###############################

  if {$prl_run_cdc} {
    CETFE_jg_cdc_report_csv
  } elseif {$prl_run_superlint} {
    CETFE_jg_superlint_report_csv
  }

  ###############################
  # To report directory		#
  ###############################

  if {$prl_run_cdc} {
    CETFE_jg_cdc_list_constants
    CETFE_jg_cdc_list_statics
    CETFE_jg_cdc_print_summary
    CETFE_jg_cdc_report_text
  } elseif {$prl_run_superlint} {
    CETFE_jg_superlint_report_text
  } elseif {$prl_run_mcp} {
    CETFE_jg_mcp_report_text
  }

  ###############################
  # To html directory		#
  ###############################

  if {$prl_run_cdc} {
    CETFE_jg_cdc_report_html
  } elseif {$prl_run_superlint} {
    CETFE_jg_superlint_report_html
  }

  ###############################
  # To collateral directory	#
  ###############################

  if {$prl_run_cdc} {
    CETFE_jg_cdc_report_collateral
  } elseif {$prl_run_superlint} {
    CETFE_jg_superlint_report_collateral
  } elseif {$prl_run_mcp} {
    CETFE_jg_mcp_report_collateral
  }
}

if {$prl_gui == 0} {
  exit
}
