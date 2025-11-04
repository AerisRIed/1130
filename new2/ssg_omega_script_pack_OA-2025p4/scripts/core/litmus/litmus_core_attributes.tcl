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
# This file contains all non-default attributes to	#
# control overall tool behavior for the core portion	#
# of the flow.						#
#########################################################

#################
# General	#
#################

if {$rtl_flow == 1} {
  set_db ${var_prefix}_const_constraint_analysis_type pre-layout
} else {
  set_db ${var_prefix}_const_constraint_analysis_type post-layout
}
set_db ${var_prefix}_project_directory $prl_stamped_base_dir/litmus_project
set_db ${var_prefix}_hdl_enable_multibit_flop_abstraction 0
# set_db ${var_prefix}_const_report_all_witnesses true
set_db timing_enable_get_objects_regexp_compatibility true
set_db init_read_netlist_allow_undefined_cells false
set_db hdl_error_on_blackbox true
set_db hdl_vhdl_read_version 2008

#################
# CDC/RDC	#
#################

set_db ${var_prefix}_cdc_consider_clockgroup_for_reset_association 1
set_db ${var_prefix}_cdc_assign_static_on_reset_assertion_source 0
set_db ${var_prefix}_cdc_convergence_endpoints_limit_per_occurrence 1000
set_db ${var_prefix}_cdc_glitch_endpoints_limit_per_occurrence 1000
set_db ${var_prefix}_cdc_rdc_destination_flop_limit_per_occurrence 1000
set_db ${var_prefix}_cdc_rdc_source_flop_limit_per_occurrence 1000
set_db ${var_prefix}_cdc_reset_endpoints_limit_per_occurrence 1000

#################
# Renaming	#
#################

#########################################################
# The following set of naming styles modify the		#
# elaboration of the input RTL. These should be set to	#
# match the settings used in your Genus implementation	#
# flow or otherwise match the implied naming choices	#
# make in the SDC. All settings below are the default	#
# values. These variables are only relevant for the	#
# RTL-based flow, i.e. "rtl_flow" is set to 1.		#
#########################################################

set_db hdl_array_naming_style %s\[%d\]
set_db hdl_bus_wire_naming_style %s\[%d\]
set_db hdl_record_naming_style %s\[%s\]
set_db hdl_instance_array_naming_style %s\[%d\]
set_db hdl_generate_index_style %s\[%d\]
set_db hdl_parameter_naming_style _%s%d
set_db hdl_reg_naming_style %s_reg%s
set_db hdl_interface_separator _
set_db hdl_generate_separator .
set_db hdl_flatten_complex_port 0
set_db bus_naming_style %s\[%d\]
set_db bit_blasted_port_style %s_%d

#################
# Rule-specific	#
#################
