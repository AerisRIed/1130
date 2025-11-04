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
# This file is used to define Litmus message settings	#
# and rule filters for the core portion of the flow.	#
#########################################################

#########################
# Message handling	#
#########################

if {($prl_rule_level eq "min") || ($prl_rule_level eq "std")} {
  # Suppress all messages with default severity "Note"
  foreach ri [get_db rule_instances * -if .${var_prefix}_severity==Note] {
    set_message -id [get_db $ri .name] -suppress
  }

  # Downgrade all design modeling errors to warnings
  foreach mr [get_db rule_instances -if .${var_prefix}_category==MODELING_RULES] {
    if {[get_db $mr .${var_prefix}_severity] eq "Error"} {
      set_message -id [get_db $mr .base_name] -severity warn
    }
  }

  # CCR 3119780: hierarchical set_false_path check causes long runtime
  if {[llength [get_db rule_instances CONST_HIER_EXC17]] != 0} {
    set_message -id CONST_HIER_EXC17 -suppress
  }
}

if {($prl_rule_level eq "std") || ($prl_rule_level eq "all")} {
  # CCR 3087607: add more set_case_analysis rules
  if {[llength [get_db rule_instances CONST_LINT_SCA2]] != 0} {
    set_message -id CONST_LINT_SCA2 -severity warn
  }
  if {[llength [get_db rule_instances CONST_LINT_SCA3]] != 0} {
    set_message -id CONST_LINT_SCA3 -severity error
  }

  set cetfe_promote_to_error [list]
  # Two clocks are physically exclusive by design, but not specified as physically exclusive by set_clock_groups
  lappend cetfe_promote_to_error "CONST_LINT_GRP1"
  # Two clocks are physically exclusive by design, but specified as logically exclusive by set_clock_groups
  lappend cetfe_promote_to_error "CONST_LINT_GRP2"
  # Two clocks are not physically exclusive by design, but specified as physically exclusive by set_clock_groups
  lappend cetfe_promote_to_error "CONST_LINT_GRP3"
  # A set_false_path and a set_multicycle_path command match the same timing path
  lappend cetfe_promote_to_error "CONST_EXC_OLP1a"
  # False path exception does not match any timing path
  lappend cetfe_promote_to_error "CONST_EXC_FLP1"
  # Connected master clock and generated clocks are declared as set_false_path
  lappend cetfe_promote_to_error "CONST_EXC_CLK1"
  # Incomplete set_min/max_delay options
  lappend cetfe_promote_to_error "CONST_EXC_SMD3"
  # Incomplete multi-cycle path options
  lappend cetfe_promote_to_error "CONST_EXC_MCP5"
  # Multi-cycle path setup/hold multiplier is over/under defined
  lappend cetfe_promote_to_error "CONST_EXC_MCP6"
  # An input port is in a timing path within a clock group for which it does not have input delay defined
  lappend cetfe_promote_to_error "CONST_IO_IDL13"
  # An output port is in a timing path within a clock group for which it does not have output delay defined
  lappend cetfe_promote_to_error "CONST_IO_ODL13"
  # set_disable_timing on clock tree
  lappend cetfe_promote_to_error "CONST_CLK_DEF38"
  # Asynchronous or physically exclusive clock group is defined among master clock and its generated clocks
  lappend cetfe_promote_to_error "CONST_CLK_GRP1"
  # Inconsistent set_min_delay/set_max_delay
  lappend cetfe_promote_to_error "CONST_DGN_CMB2"
  # Unsupported command used
  lappend cetfe_promote_to_error "CONST_LINTCFG_CMD2"
  # User defined forbidden command used
  lappend cetfe_promote_to_error "CONST_LINTCFG_CMD3"
  # Non-SDC command used
  lappend cetfe_promote_to_error "CONST_LINTCFG_CMD4"
  # Unsupported option used
  lappend cetfe_promote_to_error "CONST_LINTCFG_OPT2"
  # User defined forbidden option used
  lappend cetfe_promote_to_error "CONST_LINTCFG_OPT3"
  # Non-SDC option used
  lappend cetfe_promote_to_error "CONST_LINTCFG_OPT4"
  # Missing required option
  lappend cetfe_promote_to_error "CONST_LINTCFG_OPT5"
  # Missing mandatory option
  lappend cetfe_promote_to_error "CONST_LINTCFG_OPT6"
  # Invalid object specified
  lappend cetfe_promote_to_error "CONST_LINTCFG_REF4"
  # Invalid value specified
  lappend cetfe_promote_to_error "CONST_LINTCFG_VAL3"
  # Clock is missing
  lappend cetfe_promote_to_error "CONST_CLK_DEF1"
  # A clock does not belong to any of the user-defined clock groups
  lappend cetfe_promote_to_error "CONST_CLK_DEF21"
  # Clock redefined: used create_clock on an object that is in the transitive fanout of another clock
  lappend cetfe_promote_to_error "CONST_CLK_DEF23"
  # Input/output delay set on port/pin on which a clock is defined
  lappend cetfe_promote_to_error "CONST_CLK_DEF33"
  # Clock reaches a multiplexer select pin
  lappend cetfe_promote_to_error "CONST_CLK_DEF44"
  # Inter-clock uncertainty not defined between synchronous clocks that drive connected sequential elements
  lappend cetfe_promote_to_error "CONST_CLK_UNC6"
  # A combinational timing loop was found in the design
  lappend cetfe_promote_to_error "CONST_DGN_CMB6"
  # Connected latches work on the same clock
  lappend cetfe_promote_to_error "CONST_DGN_TIM2"
  # A set_max/min_delay and a set_multicycle_path command match the same timing path
  lappend cetfe_promote_to_error "CONST_EXC_OLP1c"
  # Could not find source pin for clock
  lappend cetfe_promote_to_error "TCLCMD-1002"
  # Could not find master for generated clock in view
  lappend cetfe_promote_to_error "TCLCMD-1003"
  # Clock group name was already defined. New specification has overwritten previous specification
  lappend cetfe_promote_to_error "TCLCMD-1007"
  # Could not parse input file due to wrong inputs
  lappend cetfe_promote_to_error "TCLCMD-1017"
  # Clock not found
  lappend cetfe_promote_to_error "TCLCMD-1051"
  # No valid objects specified
  lappend cetfe_promote_to_error "TCLCMD-1075"
  # Command is no longer supported. Use instead
  lappend cetfe_promote_to_error "TCLCMD-1084"
  # Clock group has already been defined with an identical specification. This assertion will be ignored
  lappend cetfe_promote_to_error "TCLCMD-1086"

  foreach cpte $cetfe_promote_to_error {
    if {[llength [get_db rule_instances $cpte]] != 0} {
      set loc_current_severity [get_db [get_db rule_instances $cpte] .${var_prefix}_severity]
      puts [format "%s%s%s%s%s%s" "In" "fo    : Promoting severity of rule " $cpte " from default of " $loc_current_severity " to Error."]
      set_message -id $cpte -severity error
    } else {
      puts [format "%s%s%s%s" "Warn" "ing : The rule " $cpte " does not exist and hence cannot be promoted to severity Error."]
    }
  }
}

if {$prl_rule_level eq "min"} {
  set cetfe_min_signoff_set [list]
  # set_case_analysis conflict
  lappend cetfe_min_signoff_set "CONST_SCA_CHK1"
  # Clock is missing
  lappend cetfe_min_signoff_set "CONST_CLK_DEF1"
  # Generated clock source path is undetermined
  lappend cetfe_min_signoff_set "CONST_CLK_DEF40"
  # Undefined clock transition
  lappend cetfe_min_signoff_set "CONST_CLK_CTR1"
  # Undefined clock network latency for real and generated clocks
  lappend cetfe_min_signoff_set "CONST_CLK_LAT1"
  # Undefined clock uncertainty
  lappend cetfe_min_signoff_set "CONST_CLK_UNC1"
  # Input is unconstrained
  lappend cetfe_min_signoff_set "CONST_IO_IDL1"
  # Undefined input transition
  lappend cetfe_min_signoff_set "CONST_IO_ITR1"
  # Output is unconstrained
  lappend cetfe_min_signoff_set "CONST_IO_ODL1"
  # Undefined load on output
  lappend cetfe_min_signoff_set "CONST_IO_OLD1"
  # False path exception does not match any timing path
  lappend cetfe_min_signoff_set "CONST_EXC_FLP1"
  # Multi-cycle path exception does not match any timing path
  lappend cetfe_min_signoff_set "CONST_EXC_MCP1"
  # set_max_delay exception does not match any timing path
  lappend cetfe_min_signoff_set "CONST_EXC_SMD1"
  # set_min_delay exception does not match any timing path
  lappend cetfe_min_signoff_set "CONST_EXC_SMD2"

  set all_constraint_signoff_rules [get_db [get_db rule_instances -if .${var_prefix}_category==CONSTRAINT_SIGNOFF] .base_name]
  set_message -id $all_constraint_signoff_rules -suppress
  set_message -id $cetfe_min_signoff_set -unsuppress
  puts [format "%s%s%s" "Warn" "ing : Only the following constraint signoff rules will be checked: " $cetfe_min_signoff_set]
}

#########################
# Rule filters		#
#########################
