#############################################################################################
#        Copyright (c) 2008-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

###############################################################################################
## Disclaimer : This EDA Flow is going through internal review process and subject to change  #
###############################################################################################

::legacy::set_attribute common_ui false /
set_attribute legacy_collection true /

set_attribute script_search_path {. .. ../scripts/genus}
source -verbose Genus_generic_define.tcl
source Genus_generic_utils.tcl
set RTL_PATH ""
if {([info exists env(RTL_PATH)] ne "") && ([llength $RTL_PATH] == 0)} {
  set RTL_PATH $env(RTL_PATH)
} else {
  puts [format "%s%s" "Err" "or   : RTL_PATH is not set in env_design.sh. Specify the path to RTL directory."]
  quit(1)
}
set FILE_LIST ""
if {([info exists env(FILE_LIST)] ne "") && ([llength $FILE_LIST] == 0)} {
  set FILE_LIST $env(FILE_LIST)
} else {
  puts [format "%s%s" "Err" "or   : FILE_LIST is not set in env_design.sh. Specify the path to RTL File list."]
  quit(1)
}
set_attribute init_hdl_search_path [list $RTL_PATH $RTL_PATH/memories/ $RTL_PATH/noc/ $RTL_PATH/primitives/ . ../ ../../]

set CONS_FILE ""
set SDC_FILE ""
if {(([info exists env(SDC_FILE)] eq "") && ([llength $SDC_FILE] == 0) && ([info exists env(CONS_FILE)] eq "") && ([llength $CONS_FILE] == 0))} {
  puts [format "%s%s" "Err" "or   : Neither SDC_FILE nor CONS_FILE is set in env_design.sh. Specify either SDC or Constraints file."]
  quit(1)
}

if {([info exists env(CONS_FILE)] ne "") && ([llength $CONS_FILE] == 0)} {
  set CONS_FILE $env(CONS_FILE)
} 
if {([info exists env(SDC_FILE)] ne "") && ([llength $SDC_FILE] == 0)} {
  set SDC_FILE $env(SDC_FILE)
}
set PATH_TO_DUT ""
if {([info exists env(PATH_TO_DUT)] ne "") && ([llength $PATH_TO_DUT] == 0)} {
  set PATH_TO_DUT $env(PATH_TO_DUT)
}

if {![file isdirectory $RTL_PATH]} {
  puts [format "%s%s" "Err" "or   : $RTL_PATH doesn't exist. Please specify correct RTL directory."]
  quit(1)
}
if {![file exists $FILE_LIST]} {
  puts [format "%s%s" "Err" "or   : RTL File List $FILE_LIST doesn't exist. Please specify correct one."]
  quit(1)
}
if {(![file exists $CONS_FILE]) && (![file exists $SDC_FILE])} {
  puts [format "%s%s" "Err" "or   : Please specify correct constraints or SDC File."]
  quit(1)
}

TIP_generate_timestamp -tag startup

#########################################################
# Read in user defined variables, setup libraries	#
#########################################################

set FILE_NAME_PREFIX $TOP_DESIGN 


source load_etc.tcl
source -verbose Genus_generic_libsetup.tcl
set GENERATE_PRECOMPILE_SDC 0
set MODULE_PRESERVE_LIST {}
if {([info exists env(MODULE_PRESERVE_LIST)] != 0) && ([llength $MODULE_PRESERVE_LIST] == 0)} {
  set MODULE_PRESERVE_LIST $env(MODULE_PRESERVE_LIST)
}
set MODULE_ALLOW_BOUNDARY_OPT 1
if {[info exists env(MODULE_ALLOW_BOUNDARY_OPT)] != 0} {
  set MODULE_ALLOW_BOUNDARY_OPT $env(MODULE_ALLOW_BOUNDARY_OPT)
}
if {[info exists env(GEN_SUBD_CONS)] != 0} {
  set GEN_SUBD_CONS $env(GEN_SUBD_CONS)
}
if {[info exists env(GEN_FLAT_NETLIST)] != 0} {
  set GEN_FLAT_NETLIST $env(GEN_FLAT_NETLIST)
}

#########################################################
# Read in and elaborate the design			#
#########################################################

source Genus_read.tcl

TIP_floorplan_related_settings

if {$USE_PSO == 1} {
  apply_power_intent -summary
  report power_intent -summary
  create_mode -default -name normal
  dc::set_constraint_mode normal
  redirect [format "%s%s" $FILE_NAME_PREFIX {_syn.pso_lib_check}] {check_library -isolation_cell -retention_cell}
  redirect [format "%s%s" $FILE_NAME_PREFIX {_syn.pso_cpf_check}] {check_cpf -all -lp_only -detail -debug -tclmode -continue_on_error}
}

redirect [format "%s%s" $FILE_NAME_PREFIX {_syn.dp}] {puts "******* after elaboration *******"}
redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.dp}] {report datapath -all -sort operators}
redirect [format "%s%s" $FILE_NAME_PREFIX {_syn.report_sequential}] {report sequential -hier [find / -design $TOP_DESIGN]}

#########################################################
# Constrain the design                                  #
#########################################################

if {$INSERT_SCAN == 0} {
  TIP_prevent_scan_usage
}

TIP_set_preferred_and_dont_use_cells

if {$USE_PSO == 1} {
  commit_power_intent
  optimize_iso_ls
}

source Genus_generic_cons.tcl
if {$LOW_POWER_FLOW == 1} {
  TIP_set_design_specific_lp_attributes
  TIP_load_saif_file
}

TIP_load_custom_ple

set_attribute number_of_routing_layers $Fplan_MaxRoutingLayer /
# set_attribute utilization_threshold $MAX_PLACEMENT_DENSITY [find / -design $TOP_DESIGN]

timestat GenericConstraints
eval report timing -lint -verbose $PSO_MODE


#########################################################
# Prevent certain hierarchy from being optimized away	#
# by the automatic ungrouping algorithm			#
#########################################################

if {[llength $MODULE_PRESERVE_LIST] != 0} {
  foreach subd $MODULE_PRESERVE_LIST {
    foreach sub_subd [find / -subdesign $subd] {
      if {$MODULE_ALLOW_BOUNDARY_OPT == 1} {
	set_attribute boundary_opto true $sub_subd
      } else {
	set_attribute boundary_opto false $sub_subd
      }
      set_attribute ungroup_ok false $sub_subd
    }
  }
}

TIP_prevent_mem_pin_inverter_push

#########################################################
# Set up design for scan insertion			#
#########################################################

if {$INSERT_SCAN == 1} {
  source Genus_generic_test_setup.tcl
}

#########################################################
# Perform path grouping					#
#########################################################

source Genus_generic_pathgroup.tcl
compress_constraints [find / -design $TOP_DESIGN]
timestat Pathgrouping

#########################################################
# Prevent integrated clock gate remapping and prevent	#
# flop merging on specific instances			#
#########################################################

TIP_prefanout_and_icg_control

#########################################################
# Map design to gates					#
#########################################################

TIP_load_additional_sdc_cons -sdc_file $GENUS_ADDITIONAL_SDC_CONS

TIP_generate_precompile_sdc

TIP_generate_timestamp -tag apply_constraints

TIP_output_db -db [format "%s%s" $FILE_NAME_PREFIX {_constrained.db}]

TIP_lec_debug_checkpoint -netlist pre_syn_generic.v -db pre_syn_generic.db -logfile post_elab_to_pre_syn_generic.log -golden post_elab.v -revised pre_syn_generic.v -dofile post_elab_to_pre_syn_generic.do

TIP_mixed_height_library_controls -max_util -pct_cntrl

if {$GENUS_USE_ISPATIAL == 1} {
  syn_generic -physical
} else {
  syn_generic
}

TIP_mixed_height_library_controls -short_tall_cntrl

TIP_lec_debug_checkpoint -netlist post_syn_generic.v -db post_syn_generic.db -logfile pre_syn_generic_to_post_syn_generic.log -golden pre_syn_generic.v -revised post_syn_generic.v -dofile pre_syn_generic_to_post_syn_generic.do

redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.dp}] {puts "******* after to_generic *******"}
redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.dp}] {report datapath -all -sort operators}

TIP_generate_timestamp -tag syn_generic
timestat GenericSynth

TIP_output_db -db [format "%s%s" $FILE_NAME_PREFIX {_generic.db}]

if {($ALLOW_CLOCK_GATE_IMPORT == 1) && ($LOW_POWER_FLOW == 1) && (($LOW_POWER_GOAL == 3) || ($LOW_POWER_GOAL == 5))} {
  set_attribute lp_clock_gating_prefix rtl_arch_cg /
  clock_gating import -keep_name -hierarchical -detail -verbose
  source -echo -verbose Genus_generic_icg_constraints.tcl
}

if {$INSERT_SCAN == 1} {
  source Genus_generic_test_point_insertion.tcl
}
if {$GENUS_USE_INITIAL_TARGET == 1} {
  TIP_set_initial_targets_on_cost_groups
}
if {($INSERT_SCAN == 1) && ($LOW_POWER_FLOW == 1) && (($LOW_POWER_GOAL == 3) || ($LOW_POWER_GOAL == 5))} {
  set lp_cg_ignore_min_flops_constraint 1
}

TIP_lec_debug_checkpoint -netlist pre_syn_map.v -db pre_syn_map.db -logfile post_syn_generic_to_pre_syn_map.log -golden post_syn_generic.v -revised pre_syn_map.v -dofile post_syn_generic_to_pre_syn_map.do

if {$GENUS_USE_ISPATIAL == 1} {
  syn_map -physical
} else {
  syn_map
}

TIP_mixed_height_library_controls -short_tall_cntrl -gen_report -file_prefix "post_map"

TIP_lec_debug_checkpoint -netlist post_syn_map.v -db post_syn_map.db -logfile pre_syn_map_to_post_syn_map.log -golden pre_syn_map.v -revised post_syn_map.v -dofile pre_syn_map_to_post_syn_map.do

TIP_generate_timestamp -tag syn_map
TIP_generate_timestat -print_tag "first_synthesis" -stat_tag "FirstSynth"
TIP_output_db -db [format "%s%s" $FILE_NAME_PREFIX {_mapped.db}]

#########################################################
# Add wrapper cell, compression logic and lbist	  #
#########################################################
if {$USE_PSO == 1} {
  write_power_intent -cpf -overwrite -base_name [format "%s%s" $FILE_NAME_PREFIX "_post_map_for_lec"] -design [find / -design $TOP_DESIGN]
  write_do_lec -hier -logfile rtl_to_int.log -golden_design rtl -revised_design fv_map -verbose -cpf_golden $CPF_FILE -cpf_revised [format "%s%s%s" "./" $FILE_NAME_PREFIX "_post_map_for_lec.cpf"] > rtl_to_int.do
} else {
  write_do_lec -hier -logfile rtl_to_int.log -golden_design rtl -revised_design fv_map -verbose > rtl_to_int.do
}

if {$INSERT_SCAN == 1} {
  if {$USE_MULTIBIT_CELLS == 1} {
    identify_multibit_cell_abstract_scan_segments
  }
  source Genus_generic_test_chain_definition.tcl
  TIP_output_db -db [format "%s%s" $FILE_NAME_PREFIX {_scan.db}]
}

if {($LOW_POWER_FLOW == 1) && (($LOW_POWER_GOAL == 3) || ($LOW_POWER_GOAL == 5))} {
  clock_gating declone -hier
  clock_gating rebalance -strict_min_flop_constraint -hierarchical
  clock_gating split -hier -max_level 2
}

TIP_restructure_clock_tree

#########################################################
# Perform PLE-based incremental synthesis		#
#########################################################

set_attribute ui_respects_preserve false /

set EXCLUDE_LIST [list]

if {[llength $MODULE_PRESERVE_LIST] != 0} {
  if {$MODULE_ALLOW_BOUNDARY_OPT == 1} {
    TIP_ungroup_target_subdesigns -subdesign_list $MODULE_PRESERVE_LIST
  } else {
    TIP_ungroup_target_subdesigns -preserve_boundary -subdesign_list $MODULE_PRESERVE_LIST
  }
  cd
  foreach subd $MODULE_PRESERVE_LIST {
    foreach sub_subd [find / -subdesign $subd] {
      foreach inst_sub_subd [get_attribute instances $sub_subd] {
	lappend EXCLUDE_LIST $inst_sub_subd
      }
    }
  }
}
if {$USE_PSO == 0} {
  if {[llength $EXCLUDE_LIST] != 0} {
    ungroup -flatten -all -only_user_hierarchy -exclude $EXCLUDE_LIST
  } else {
    ungroup -flatten -all -only_user_hierarchy
  }
}
edit_netlist uniquify [find / -design $TOP_DESIGN] -verbose
add_assign_buffer_options -dont_skip_unconstrained_paths -ignore_preserve_setting -no_buffers_use_inverters -verbose
set_attribute remove_assigns true /
if {$USE_PSO == 1} {
  commit_power_intent
  optimize_iso_ls
}

TIP_lec_debug_checkpoint -netlist pre_syn_opt.v -db pre_syn_opt.db -logfile post_syn_map_to_pre_syn_opt.log -golden post_syn_map.v -revised pre_syn_opt.v -dofile post_syn_map_to_pre_syn_opt.do

syn_opt

TIP_mixed_height_library_controls -short_tall_cntrl -gen_report -file_prefix "post_opt_full"

TIP_lec_debug_checkpoint -netlist post_syn_opt.v -db post_syn_opt.db -logfile pre_syn_opt_to_post_syn_opt.log -golden pre_syn_opt.v -revised post_syn_opt.v -dofile pre_syn_opt_to_post_syn_opt.do

TIP_generate_timestamp -tag mandatory_syn_opt
TIP_generate_timestat -print_tag "mandatory_incremental" -stat_tag "MandatoryIncr"

report hierarchy

TIP_output_db -db [format "%s%s" $FILE_NAME_PREFIX {_first_opt.db}]

while {$GENUS_ADDITIONAL_PASSES > 0} {
  if {$TOOL_VERSION < 22.10} {
    syn_opt -incremental
  } else {
    syn_opt
  }
  set GENUS_ADDITIONAL_PASSES [expr $GENUS_ADDITIONAL_PASSES - 1]
  TIP_generate_timestamp -tag incremental_syn_opt
  TIP_generate_timestat -print_tag "optional_incremental" -stat_tag "OptionalIncr"
  TIP_output_db -db [format "%s%s%s%s" $FILE_NAME_PREFIX "_opt_incremental_" $INCR_PASS_COUNTER ".db"]
  incr INCR_PASS_COUNTER
}

TIP_mixed_height_library_controls -short_tall_cntrl -gen_report -file_prefix "post_opt_incr"

TIP_lec_debug_checkpoint -netlist post_incr_syn_opt.v -db post_incr_syn_opt.db -logfile post_syn_opt_to_post_incr_syn_opt.log -golden post_syn_opt.v -revised post_incr_syn_opt.v -dofile post_syn_opt_to_post_incr_syn_opt.do

#########################################################
# Perform iSpatial synthesis				#
#########################################################

if {$GENUS_USE_ISPATIAL == 1} {
  TIP_ispatial_setup_and_launch
  TIP_remove_path_groups_and_exceptions
  source -echo -verbose Genus_generic_pathgroup.tcl
  if {[llength [find / -cost_group power_clkgate]] == 0} {
    source -echo -verbose Genus_generic_icg_constraints.tcl
  }
  TIP_mixed_height_library_controls -gen_report -file_prefix "post_ispatial"
}

#########################################################
# Generate output files					#
#########################################################

TIP_ungroup_cdns_special_modules

if {$USE_PSO == 0} {
  set EXCLUDE_LIST [list]
  if {[llength $MODULE_PRESERVE_LIST] != 0} {
    foreach subd $MODULE_PRESERVE_LIST {
      foreach sub_subd [find / -subdesign $subd] {
	foreach inst_sub_subd [get_attribute instances $sub_subd] {
	  lappend EXCLUDE_LIST $inst_sub_subd
	}
      }
    }
  }
  if {[llength $EXCLUDE_LIST] != 0} {
    ungroup -flatten -all -exclude $EXCLUDE_LIST
  } else {
    ungroup -flatten -all -force
  }
}
change_names -verilog -max_length 500
write_hdl > [format "%s%s" $FILE_NAME_PREFIX {_syn.v}]
if {$GENUS_USE_ISPATIAL == 1} {
  TIP_output_db -common -override -db [format "%s%s" $FILE_NAME_PREFIX {_syn.db}]
} else {
  TIP_output_db -override -db [format "%s%s" $FILE_NAME_PREFIX {_syn.db}]
}

if {$INSERT_SCAN == 1} {
  TIP_generate_dft_report_package -file_prefix $FILE_NAME_PREFIX
}

report units
redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.dp}] {puts "******* after to_mapped *******"}
redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.dp}] {report datapath -all -sort operators}

TIP_generate_output_report_package -file_prefix $FILE_NAME_PREFIX

set ALL_COST_GROUPS [find / -cost_group *]
set REPORT_COST_GROUPS $ALL_COST_GROUPS
foreach ACG $ALL_COST_GROUPS {
  if {[get_attribute slack $ACG] eq "no_value"} {
    set REPORT_COST_GROUPS [dc::remove_from_collection $REPORT_COST_GROUPS $ACG]
  }
}
TIP_generate_timing_report -file_prefix $FILE_NAME_PREFIX
if {$REPORT_STATISTICS == 1} {
  statistics report -run_id [get_attribute statistics_run_id] -ignore_user_defined
}
redirect [format "%s%s" $FILE_NAME_PREFIX {_syn.timing}] {puts [list]}
foreach cg $REPORT_COST_GROUPS {
  if {($GENUS_USE_ISPATIAL == 1) && ($GENUS_DERATE_METHOD != 0)} {
    redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.timing}] "eval report timing -num_paths $GENUS_NUM_PATHS -worst 10 -cost_group $cg -physical -user_derate -incr_derate $PSO_MODE"
  } elseif {($GENUS_USE_ISPATIAL == 0) && ($GENUS_DERATE_METHOD != 0)} {
    redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.timing}] "eval report timing -num_paths $GENUS_NUM_PATHS -worst 10 -cost_group $cg -user_derate -incr_derate $PSO_MODE"
  } elseif {$GENUS_USE_ISPATIAL == 1} {
    redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.timing}] "eval report timing -num_paths $GENUS_NUM_PATHS -worst 10 -cost_group $cg -physical $PSO_MODE"
  } else {
    redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.timing}] "eval report timing -num_paths $GENUS_NUM_PATHS -worst 10 -cost_group $cg $PSO_MODE"
  }
}
set i 1
foreach CP $CLK_PORT {
  redirect -append [format "%s%s%s" $FILE_NAME_PREFIX {_syn.timing_CLK} $i] "eval report timing -num_paths $GENUS_NUM_PATHS -worst 10 -cost_group [find / -cost_group CLK$i] $PSO_MODE"
  if {[find / -cost_group I2F_$i] != [list]} {
    redirect -append [format "%s%s%s" $FILE_NAME_PREFIX {_syn.timing_I2F_} $i] "eval report timing -num_paths $GENUS_NUM_PATHS -worst 10 -cost_group [find / -cost_group I2F_$i] $PSO_MODE"
  }
  if {[find / -cost_group F2O_$i] != [list]} {
    redirect -append [format "%s%s%s" $FILE_NAME_PREFIX {_syn.timing_F2O_} $i] "eval report timing -num_paths $GENUS_NUM_PATHS -worst 10 -cost_group [find / -cost_group F2O_$i] $PSO_MODE"
  }
  incr i
}
if {[find / -cost_group I2O] != [list]} {
  redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.timing_I2O}] "eval report timing -num_paths $GENUS_NUM_PATHS -worst 10 -cost_group [find / -cost_group I2O] $PSO_MODE"
}
if {[find / -cost_group power_*] != [list]} {
  redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.timing_clkgate}] "eval report timing -num_paths $GENUS_NUM_PATHS -worst 10 -cost_group [find / -cost_group power_*] $PSO_MODE"
}
if {$USE_MEMORY_MACROS == 1} {
  redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.timing_mem_io}] "eval report timing -num_paths $GENUS_NUM_PATHS -worst 10 -cost_group [find / -cost_group mem_io*] $PSO_MODE"
}

statistics report -run_id $TOP_DESIGN -ignore_user_defined
if {$GENERATE_HISTOGRAMS == 1} {
  TIP_generate_native_logic_depth_histograms
}

if {$GENUS_WRITE_SDF == 1} {
  TIP_make_clock_network_ideal -des_name $TOP_DESIGN
  set SCAN_ENABLE_PORT [find / -port test_se]
  if {$SCAN_ENABLE_PORT != [list]} {
    set scan_en_nets [all_connected $SCAN_ENABLE_PORT]
    foreach item $scan_en_nets {
      set_attribute -quiet physical_cap 0 $item
    }
  }
  write_sdf -timescale ns -precision 3 -interconn interconnect -nonegchecks > [format "%s%s" $FILE_NAME_PREFIX {_syn.sdf}]
}

TIP_remove_path_groups_and_exceptions

if {$INSERT_SCAN == 1} {
  TIP_remove_ideal_dft_port_settings
}
TIP_remove_ocv_derates
eval write_sdc -no_split $PSO_MODE > [format "%s%s" $FILE_NAME_PREFIX {_syn.sdc}]

if {$USE_PSO == 1} {
  write_power_intent -cpf -overwrite -base_name [format "%s%s" $FILE_NAME_PREFIX "_syn"] -design [find / -design $TOP_DESIGN]
  write_do_clp -clp_out_report clp_rule_check.report -design $TOP_DESIGN -cpf_file [format "%s%s%s" "./" $FILE_NAME_PREFIX "_syn.cpf"] -ignore_ls_htol -logfile clp_pso_check.log -lp_only -netlist [format "%s%s%s" "./" $FILE_NAME_PREFIX "_syn.v"] -tclmode -verbose > clp_pso_check.do
  write_do_lec -hier -golden_design fv_map -revised_design [format "%s%s%s" "./" $FILE_NAME_PREFIX "_syn.v"] -cpf_golden [format "%s%s%s" "./" $FILE_NAME_PREFIX "_post_map_for_lec.cpf"] -cpf_revised [format "%s%s%s" "./" $FILE_NAME_PREFIX "_syn.cpf"] -logfile int_to_final.log -verbose > int_to_final.do
# The following command will call Conformal Low Power (CLP) within the current Genus session
# verify_power_structure -debug -tclmode -all -lp_only -continue_on_error -detail -post_synthesis > [format "%s%s" $FILE_NAME_PREFIX {_syn.pso_structure_check}]
  report power_intent -power_states -detail > [format "%s%s" $FILE_NAME_PREFIX {_syn.pso_design_report}]
  report power_intent_instances -show_full_names -summary >> [format "%s%s" $FILE_NAME_PREFIX {_syn.pso_design_report}]
  report power_intent_instances -show_full_names -detail >> [format "%s%s" $FILE_NAME_PREFIX {_syn.pso_design_report}]
} else {
  write_do_lec -flat -golden_design fv_map -revised_design [format "%s%s%s" "./" $FILE_NAME_PREFIX "_syn.v"] -logfile int_to_final.log -verbose > int_to_final.do
}

TIP_lec_debug_checkpoint -netlist final_netlist.v -db final_netlist.db -logfile post_incr_syn_opt_to_final_netlist.log -golden post_incr_syn_opt.v -revised final_netlist.v -dofile post_incr_syn_opt_to_final_netlist.do

if {($GEN_SUBD_CONS == 1) && ([llength $MODULE_PRESERVE_LIST] != 0)} {
  TIP_generate_subdesign_constraints -subdesign_list $MODULE_PRESERVE_LIST
}

TIP_generate_timestamp -tag report_generation
puts "Final Runtime & Memory"
timestat Final

if {([llength $Lib_CadenceTypLIB] > 0) && ($Lib_CadenceLIB ne $Lib_CadenceTypLIB) && ($USE_PSO == 0)} {
  TIP_generate_typical_corner_output_files -prefix $FILE_NAME_PREFIX
}

TIP_generate_flat_netlist -file_prefix $FILE_NAME_PREFIX
write_design -basename $TOP_DESIGN

quit
