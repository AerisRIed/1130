################################################################################
## Copyright (c) 2024 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       #
## These coded instructions, statements, and computer programs are the          #
## copyrighted works and confidential proprietary information of Cadence Design #
## Systems Inc. They may not be modified, copied, reproduced, distributed, or   #
## disclosed to third parties in any manner, medium, or form, in whole or in    #
## part, without the prior written consent of Cadence Design Systems Inc.       #
#################################################################################
#
#########################################################
## This file should not require any user modification	#
#########################################################
#
#########################################################
## Load user-editable variables				#
#########################################################

set golden_vf_file [dict create]
set dft_shift_en [dict create]
set dft_async_reset_ports [dict create]
set dft_test_clocks [dict create]
set dft_test_modes [dict create]

if {[file readable ./omega_local_user_vars.tcl]} {
  source -echo ./omega_local_user_vars.tcl
} else {
  puts [format "%s%s" "Err" "or   : expected user input file ./omega_local_user_vars.tcl not found."]
  exit
}

set_db init_hdl_search_path $prl_rtl_search_path

set global_tcl_utils_file                "$prl_script_root_dir/../common/TclUtils.tcl"
set global_command_merge_file            "$prl_script_root_dir/../common/MergeCommandFile.pl"
set joules_core_attr_file                "$prl_script_root_dir/joules_core_attributes.tcl"
set joules_core_procs_file	         "$prl_script_root_dir/joules_core_procs.tcl"
set joules_user_attr_file                "$prl_script_root_dir/../../user/joules/joules_user_attributes.tcl"

foreach cif [list $global_tcl_utils_file $global_command_merge_file $joules_core_attr_file $joules_core_procs_file $joules_user_attr_file] {
  if {![file readable $cif]} {
    puts [format "%s%s%s" "Err" "or   : expected input file not readable - " $cif]
    exit
  }
}

source -echo $global_tcl_utils_file

CETFE_manipulate_omega_user_vars "joules"
CETFE_validate_omega_user_vars "joules"


#########################################################
## Load attribute specification file			#
#########################################################
if {$prl_joules_flow == 3} {
  set insert_clock_gating 1
}


if {[file readable ${prl_script_root_dir}/joules_core_attributes.tcl]} {
  source -echo ${prl_script_root_dir}/joules_core_attributes.tcl
} else {
    puts [format "%s%s" "Err" "or   : expected attribute specification file ${prl_script_root_dir}/joules_core_attributes.tcl not found."]
      exit
}

if {[file readable ${prl_script_root_dir}/../../user/joules/joules_user_attributes.tcl]} {
  source -echo ${prl_script_root_dir}/../../user/joules/joules_user_attributes.tcl
} else {
    puts [format "%s%s" "Err" "or   : expected attribute specification file ${prl_script_root_dir}/../../user/joules/joules_user_attributes.tcl not found."]
      exit
}

#########################################################
### Read in procs			                #
#########################################################

if {[file readable ${prl_script_root_dir}/joules_core_procs.tcl]} {
  source -echo ${prl_script_root_dir}/joules_core_procs.tcl
} else {
    puts [format "%s%s" "Err" "or   : expected procs file ./joules_core_procs.tcl not found."]
      exit
}


#########################################################
# Initial setup						#
#########################################################
if {[info exists env(CDNS_MULTITHREAD_COUNT)]} {
  set superthread_count $env(CDNS_MULTITHREAD_COUNT)
} else {
  set superthread_count $tool_thread_count
}
set_multi_cpu_usage -local_cpu $superthread_count

#set_log_file [file join $reporting_dir joules_session.log] -progress -replace

set define_cmd ""
if {$rtl_defines ne [list]} {
  set define_cmd "-define \{$rtl_defines\}"
}

#########################################################
## Load library views					#
##########################################################
if {$rtl_flow == 1} {
  if {$use_mmmc == 1} {
    if {[file readable $mmmc_file]} {
      read_mmmc $mmmc_file
    } else {
      puts [format "%s%s%s%s" "Err" "or   : the MMMC file specified by " $mmmc_file " is not readable."]
      exit
    }
  } else {
    read_libs $single_corner_libs
  }
  
  read_physical -lef $lef_list


#########################################################
# Setup for Trial synthesis
#########################################################
if {$prl_joules_flow == 3} {
  set_db metric_enable false
  if {($run_atpg == 1) && ($insert_scan == 0)} {
    puts [format "%s%s" "Err" "or : run_atpg is turned on, but insert_scan is set to 0 in omega_user_vars.tcl file. Please disable run_atpg to turn off ATPG or set both insert_scan and run_atpg to 1 to enable ATPG"]
    exit
  }

  set PSO_MODE [list]
  set QOR_SWITCH "-levels_of_logic"

  #pso settings if upf file exists
  if {[file readable $rtl_upf]} {
    set PSO_MODE "-mode normal"
    set QOR_SWITCH [list]
    if {$rtl_flow == 1} {
      set_db / .add_pin_name_to_lp_instance true
      set_db / .hdl_unconnected_value none
    }
  }


  #socv setup for 3nm or lower
  if {$lib_process_node <= 3} {
    puts [format "%s%s" "Warn" "ing : For Lib_ProcessNode values of 3 or less, the SOCV LVF analysis mode is set to moments"]
    if {$rtl_flow == 1} {
      set_db / .parse_lib_moments_table true
      set_db / .delaycal_socv_lvf_mode moments
      set_db / .delaycal_socv_use_lvf_tables all
    }
  }
 
  if {[file readable $rtl_upf]} {
    if {$rtl_flow == 1} {
      read_power_intent -1801 -module $top_design $rtl_upf
    }
  }

  #setup ATPG
  set MBIST_VERIFY_CHECK 0
  set SIM_LIB_LENGTH [llength $verilog_sim_lib]
  set VALID_SIM_LIBS 0
  set ATPG_COUNTER 0
  set RUN_ATPG 0
  if {($run_atpg == 1) && ($insert_scan == 1)} {
    foreach vsl $verilog_sim_lib {
      if {[file readable $vsl]} {
        incr VALID_SIM_LIBS
      }
    }
    if {($SIM_LIB_LENGTH > 0) && ($SIM_LIB_LENGTH == $VALID_SIM_LIBS)} {
      incr ATPG_COUNTER
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
  }
}

  
#########################################################
## Load design and read sdc
##########################################################
  if {[dict size $golden_vf_file] == 0} {
    puts [format "%s%s" "Err" "or   : RTL-level analysis has been selected, however there are"]
    puts [format "%s%s" "Err" "or   : no input filelists defined in golden_vf_file."]
    exit
  } else {
    dict for {flist lrm} $golden_vf_file {
      if {$lrm == "vhdl"} {
        puts "flist: $flist lrm: $lrm"
        puts "$golden_vf_file"
	#placeholder for future updates
        eval "read_hdl -language $lrm $define_cmd -f $flist"
      } else {
        puts "flist: $flist lrm: $lrm"
        puts "$golden_vf_file"
        eval "read_hdl -language $lrm $define_cmd -f $flist"
      }
    }
  }
  elaborate $top_design
  if {$prl_joules_flow == 3} {
    if {$rtl_flow == 1} {
      edit_netlist_uniquify [get_db designs $top_design]
      CETFE_define_lp_icg_setup -des_name $top_design
    }
  }
  if {$use_mmmc == 0} {
    if {[file readable $golden_sdc_file]} {
      read_sdc $golden_sdc_file
    } else {
      puts [format "%s%s%s%s" "Err" "or   : the single-corner SDC file specified by " $golden_sdc_file " is not readable."]
      exit
    }
  } else {
    puts [format "%s%s" "In" "fo    : the SDC file was taken from the first analysis view defined in the MMMC file."]
  }
  init_design
} else {
  if {[file readable $golden_db_file]} {
    read_db $golden_db_file
    source -echo ./omega_local_user_vars.tcl
    CETFE_manipulate_omega_user_vars "joules"
    CETFE_validate_omega_user_vars "joules"

    set rtl_flow 0
  } else {
    puts [format "%s%s%s%s" "Err" "or   : the gate-level netlist specified by " $golden_db_file " is not readable."]
    exit
  }
}


#########################################################
## Run quick synthesis and power compute
#########################################################
if {$prl_joules_flow == 1} {
  if {$rtl_flow == 1} {
    syn_power -effort medium
    write_db -all_root_attributes ./dbs/syn_power.db
  }
  #set clock_vt_base_cells [get_db base_cells]
  #set cts_buffer_cells [get_db $clock_vt_base_cells .name $cts_buffer_reg*LVT]
  #set cts_d1_buffer_cell [lindex $cts_buffer_cells 0]
  
  #puts "cts_cell $cts_d1_buffer_cell"
  file mkdir power_estimate

  create_clock_tree -force -name CT1 -fanout root=$cts_root_fanout branch=$cts_branch_fanout leaf=$cts_leaf_fanout -root_buffers $cts_root_buffer -branch_buffers $cts_branch_buffer -leaf_buffers $cts_leaf_buffer -max_tree_depth 5
  report_clock_tree -ctg_name CT1 -summary -power > ./power_estimate/Joules_CTS.rpt
  report_gates > ./power_estimate/Joules_gates.rpt

  set diag_list {}
  foreach stimulus_file $stimulus_file_list {
    set stimulus_format [string map {. ""} [file extension $stimulus_file]]  
    if {[file exists $stimulus_file]} {
        if {$path_to_dut ne ""} {
          read_stimulus -resim_cg_enables -format $stimulus_format -file $stimulus_file -dut_instance $path_to_dut
        } else {
          puts [format "%s%s" "Err" "or   : Please define a DUT instance name when using activity file or remove files under stimulus_file_list"]
          quit
        }
      } else {
        puts "File $stimulus_file don't exist."
	continue
      }

      set diag_num 0
      set diag_name [file rootname [file tail $stimulus_file]]
      set diag_name_temp $diag_name
      while {$diag_name_temp eq [lsearch -inline $diag_list $diag_name_temp]} {
        set diag_num [expr {$diag_num+1}]
        set diag_name_temp "${diag_name_temp}_${diag_num}"
      }
      if {$diag_num != 0} {
        set diag_name "${diag_name}_${diag_num}"
      }
      lappend diag_list $diag_name


      file mkdir power_estimate/$diag_name

      report_sdb_annotation -show_details seq:unasserted:out -out ./power_estimate/$diag_name/unassertedflops.rpt
      report_sdb_annotation -inputs -out ./power_estimate/$diag_name/annotation.rpt
      compute_power -mode time_based -out ./power_estimate/$diag_name/power_engine.rpt
      report_activity -out ./power_estimate/$diag_name/power.rpt
      report_power -by_category -cols {internal switching leakage total} -category {register memory logic clock_comb clock_seq} -unit mW -format %.5f -out ./power_estimate/$diag_name/power.rpt -append
      report_power -by_hier -levels 10 -min_leaf_cnt 1000 -unit mW -format "%.5f" -out ./power_estimate/$diag_name/power.hier.rpt
     
      report_icg_efficiency -cols {enable_eff downstream_clkpin_power impact} -sort_by impact -out ./power_estimate/$diag_name/icg_efficiency.rpt
      propagate_activity
      compute_ideal_power
      report_ideal_power -by_leaf -sort_by wasted_power -cols {flops cg toggles cg_eff dag_eff clk_eff wasted_power inst} -show_power_data -out ./power_estimate/$diag_name/clock_gate_opportunity.rpt
      report_ideal_power -by_leaf -sort_by seq_power -cols {flops cg toggles cg_eff dag_eff clk_eff seq_power inst} -show_power_data -out ./power_estimate/$diag_name/data_gate_opportunity.rpt
      CETFE_filter_clock_gate_report -clock_gate_rpt ./power_estimate/$diag_name/clock_gate_opportunity.rpt -data_gate_rpt ./power_estimate/$diag_name/data_gate_opportunity.rpt -output_dir ./power_estimate/$diag_name
      
  }

}

#######################Start of Flow 2########################
if {$prl_joules_flow == 2} {
  if {$rtl_flow == 1} {
    power_hdl -generic_flow scrub -effort high
    write_db -all -to_file dbs/odc_power_hdl_scrub.db
  }
    file mkdir odc_analysis/statistical
    file mkdir odc_analysis/statistical/odc
    file mkdir odc_analysis/statistical/logic
    file mkdir odc_analysis/statistical/stb
    file mkdir odc_analysis/statistical/reset
    set REM_ODC_VARS "-max_expr_print_length 20 -min_reg_width 8 -max_oper_count 16 -show_depth -cols id exprsn_metadata file_row_col cg_status enable_exprsn enable_occur odc_exprsn bank_name -sort_by exprsn_metadata -only_file_row_info -expand_to_signals"
    set REM_LOGIC_GATING_VARS "-max_expr_print_length 20 -operators_only -expand_to_signals -show_depth -sort_by score -cols id score area_score exprsn exprsn_metadata file_row_col function_type width wt_pct logic"
    set REM_STB_VARS "-max_expr_print_length 20 -min_reg_width 8 -max_oper_count 16 -only_file_row_info -sort_by id -cols id file_row_col enable_exprsn flop_bank exprsn_metadata"


   #Main reports
    #Logic opt report 
    compute_logic_opt -allow_port_punching
    CETFE_local_odc_reporting -report_type lg -input_type vectorless -file_name ./odc_analysis/statistical/logic/structural_logic_opt_pp.rpt
  
    #reset report
    compute_reset_opt
    CETFE_local_odc_reporting -report_type rst -input_type vectorless -file_name ./odc_analysis/statistical/reset/structural_reset_opt.rpt
  
    #ODC report
    compute_odc -allow_port_punching -allow_precompute -effort high
    CETFE_local_odc_reporting -report_type odc -input_type vectorless -file_name ./odc_analysis/statistical/odc/structural_odc_pp.rpt
  
  
    #STB reports
    compute_stb 
    CETFE_local_odc_reporting -report_type stbs -input_type vectorless -file_name ./odc_analysis/statistical/stb/structural_standard_stb.rpt
  
    compute_stb -const_based
    CETFE_local_odc_reporting -report_type stbc -input_type vectorless -file_name ./odc_analysis/statistical/stb/structural_constant_stb.rpt
  
  
  #Logic_gates sub reports
    compute_logic_opt
    CETFE_local_odc_reporting -report_type lg -input_type vectorless -file_name ./odc_analysis/statistical/logic/structural_logic_opt_no-pp.rpt
  
  #ODC sub reports
    compute_odc -allow_precompute -effort high
    CETFE_local_odc_reporting -report_type odc -input_type vectorless -file_name ./odc_analysis/statistical/odc/structural_odc_no-pp.rpt
  
  if {$stimulus_file_list ne ""} {
    file mkdir odc_analysis/vector
    set REM_ODC_VARS "-show_power_details -unit nW -max_expr_print_length 20 -min_reg_width 8 -max_oper_count 16 -show_depth -only_file_row_info -expand_to_signals -sort_by design_dyn_pct -cols id exprsn_metadata file_row_col cg_status enable_exprsn enable_occur odc_exprsn skip_gating total_toggles wasted_pct clock_toggles wasted_clock_pct dyn_pow_saving_pct design_dyn_pct bank_name"
    set REM_LOGIC_GATING_VARS "-max_expr_print_length 20 -operators_only -expand_to_signals -show_depth -cols id score area_score exprsn exprsn_metadata file_row_col function_type width wt_pct logic -sort_by score"
    set REM_STB_VARS "-show_power_details -unit nW -max_expr_print_length 20 -min_reg_width 8 -max_oper_count 16 -only_file_row_info -ps_threshold 0.000001 -sort_by dyn_pow_saving_pct -cols id file_row_col enable_exprsn wasted_clocks wasted_clock_pct dyn_pow_saving dyn_pow dyn_pow_saving_pct flop_bank exprsn_metadata"
 
    set diag_list {} 
    foreach stimulus_file $stimulus_file_list {
      set stimulus_format [string map {. ""} [file extension $stimulus_file]]
      if {$stimulus_format eq "saif"} {
        puts "Warning: ODC analysis is not supported for saif toggle files and will be skipped"
        continue
      }

      set diag_num 0
      set diag_name [file rootname [file tail $stimulus_file]]
      set diag_name_temp $diag_name
      while {$diag_name_temp eq [lsearch -inline $diag_list $diag_name_temp]} {
        set diag_num [expr {$diag_num+1}]
        set diag_name_temp "${diag_name_temp}_${diag_num}"
      }
      if {$diag_num != 0} {
        set diag_name "${diag_name}_${diag_num}"
      }
      lappend diag_list $diag_name



      file mkdir odc_analysis/vector/$diag_name
      file mkdir odc_analysis/vector/$diag_name/odc
      file mkdir odc_analysis/vector/$diag_name/stb
      file mkdir odc_analysis/vector/$diag_name/logic

      #logic opt
      compute_logic_opt -allow_port_punching
      CETFE_local_odc_reporting -report_type lg -input_type simulation -stim_path $stimulus_file -stim_type $stimulus_format -file_name ./odc_analysis/vector/$diag_name/logic/simulation_logic_opt_pp.rpt -delete_vector

      #ODC
      compute_odc -allow_port_punching -allow_precompute -effort high
      CETFE_local_odc_reporting -report_type odc -input_type simulation -stim_path $stimulus_file -stim_type $stimulus_format -file_name ./odc_analysis/vector/$diag_name/odc/simulation_odc_pp.rpt -delete_vector

      #STB
      compute_stb
      CETFE_local_odc_reporting -report_type stbs -input_type simulation -stim_path $stimulus_file -stim_type $stimulus_format -file_name ./odc_analysis/vector/$diag_name/stb/simulation_standard_stb.rpt -delete_vector

      compute_stb -const_based
      CETFE_local_odc_reporting -report_type stbc -input_type simulation -stim_path $stimulus_file -stim_type $stimulus_format -file_name ./odc_analysis/vector/$diag_name/stb/simulation_constant_stb.rpt -delete_vector

      #Logic_gates sub reports
      compute_logic_opt
      CETFE_local_odc_reporting -report_type lg -input_type simulation -stim_path $stimulus_file -stim_type $stimulus_format -file_name ./odc_analysis/vector/$diag_name/logic/simulation_logic_opt_no-pp.rpt -delete_vector

      #ODC sub reports
      compute_odc -allow_precompute -effort high
      CETFE_local_odc_reporting -report_type odc -input_type simulation -stim_path $stimulus_file -stim_type $stimulus_format -file_name ./odc_analysis/vector/$diag_name/odc/simulation_odc_no-pp.rpt -delete_vector

    }
  }
}

#######################Start of Trial Synthesis########################
if {$prl_joules_flow == 3} {
  if {$rtl_flow == 1} {
    set_db metric_enable false
    
    
    #apply power intent
    if {[file readable $rtl_upf]} {
      apply_power_intent -summary
      report_power_intent -summary
      create_mode -default -name normal
      set_constraint_mode normal
      redirect [format "%s%s" "trial_synthesis/$top_design" {_syn.pso_lib_check}] {check_library -isolation_cell -retention_cell}
    }
  
    redirect [format "%s%s" "trial_synthesis/$top_design" {_syn.dp}] {puts "******* after elaboration *******"}
    redirect -append [format "%s%s" "trial_synthesis/$top_design" {_syn.dp}] {report_dp -all -sort operators}
    redirect [format "%s%s" "trial_synthesis/$top_design" {_syn.report_sequential}] {report_sequential -hier [get_db designs $top_design]}
  
    set_db metric_enable true
    push_snapshot_stack
  
    #CETFE_prevent_scan_usage
    CETFE_set_dont_use_cells
  
    if {[file readable $rtl_upf]} {
      commit_power_intent
      optimize_iso_ls
    }
  
    #set specific low power attributes
    set_db [get_db designs $top_design] .lp_clock_gating_max_flops 128
    set_db [get_db designs $top_design] .lp_clock_gating_min_flops 2
    set_db [get_db designs $top_design] .lp_clock_gating_extract_common_enable true
    set_db [get_db designs $top_design] .lp_clock_gating_auto_cost_grouping false
  
    ungroup -flatten -all -only_user_hierarchy
  
    #should I add MBIST
    #source -echo -verbose Genus_generic_insert_mbist.tcl
  
    CETFE_output_db -db [format "%s%s" "dbs/$top_design" {_pre_constrained.db}] -override
    #insert scan
    if {$insert_scan == 1} {
      CETFE_init_DFT
    }
  
    #generic path grouping
    CETFE_create_path_groups
    CETFE_prefanout_and_icg_control
  
    #configure vivid metrics
    CETFE_configure_vivid_metrics_genus
  
  
    #generating precompile sdc for testing
    CETFE_generate_precompile_sdc
  
    CETFE_output_db -db [format "%s%s" "dbs/$top_design" {_constrained.db}] -override
  
    syn_generic
  
    redirect -append [format "%s%s" "trial_synthesis/$top_design" {_syn.dp}] {puts "******* after to_generic *******"}
    redirect -append [format "%s%s" "trial_synthesis/$top_design" {_syn.dp}] {report_dp -all -sort operators}
    CETFE_output_db -db [format "%s%s" "dbs/$top_design" {_generic.db}] -override
    pop_snapshot_stack
    CETFE_dump_vivid_metrics_genus -step syn_generic
  
    #start syn_map
    push_snapshot_stack
    set_db / .lp_clock_gating_prefix rtl_arch_cg
    update_clock_gate -keep_name -hierarchical -detail -verbose
  
    syn_map
  
    CETFE_output_db -db [format "%s%s" "dbs/$top_design" {_mapped.db}] -override
    pop_snapshot_stack
    CETFE_dump_vivid_metrics_genus -step syn_map
  
    #start syn_opt
    push_snapshot_stack
  
    #DFT?
    check_dft_rules -advanced
    #source Genus_generic_insert_lbist.tcl
    if {$insert_scan == 1} {
      identify_multibit_cell_abstract_scan_segments
      CETFE_define_scan_chain
    
      CETFE_output_db -db [format "%s%s" "dbs/$top_design" {_scan.db}] -override
    }
  
  #  if {[file readable $rtl_upf]} {
  #    write_power_intent -1801 -overwrite -base_name [format "%s%s" $top_design "_post_map_for_lec"] -design [get_db designs $top_design]
  #  }
  
    CETFE_restructure_clock_tree
  
    edit_netlist_uniquify [get_db designs $top_design] -verbose
  
    add_assign_buffer_options -dont_skip_unconstrained_paths -ignore_preserve_setting -no_buffers_use_inverters -verbose
    set_db / .remove_assigns true
  
    if {[file readable $rtl_upf]} {
      commit_power_intent
      optimize_iso_ls
    }
  
    syn_opt
  
    report_hierarchy
  
    CETFE_output_db -db [format "%s%s" "dbs/$top_design" {_opt.db}] -override
  }
 
  #output generation
  ungroup -flatten -all -force
  
  update_names -verilog -max_length 500
  write_hdl > [format "%s%s" "trial_synthesis/$top_design" {_syn.v}]

  CETFE_output_db -override -db [format "%s%s" "dbs/$top_design" {_syn.db}]
  
  if {$insert_scan == 1} {
    CETFE_generate_dft_report_package -file_prefix "trial_synthesis/dft/$top_design"
  }

  report_units
  redirect -append [format "%s%s" "trial_synthesis/$top_design" {_syn.dp}] {puts "******* after to_mapped *******"}
  redirect -append [format "%s%s" "trial_synthesis/$top_design" {_syn.dp}] {report_dp -all -sort operators}

  CETFE_generate_output_report_package -file_prefix "trial_synthesis/$top_design"

  set ALL_COST_GROUPS [get_db cost_groups *]
  #set REPORT_COST_GROUPS $ALL_COST_GROUPS
  set REPORT_COST_GROUPS [list]
  set REMOVE_COST_GROUPS [list]
  foreach ACG $ALL_COST_GROUPS {
    if {[get_db [vfind $ACG] .slack] eq "no_value"} {
      lappend REMOVE_COST_GROUPS $ACG
    }
  }

  lmap item $ALL_COST_GROUPS {
    if {$item ni $REMOVE_COST_GROUPS} {
      lappend REPORT_COST_GROUPS $item
    } else {
      continue
    }
  }

  CETFE_generate_timing_report -file_prefix "trial_synthesis/$top_design"

  pop_snapshot_stack
  CETFE_dump_vivid_metrics_genus -step syn_opt


  #if PSO
  if {[file readable $rtl_upf]} {
    write_power_intent -1801 -overwrite -base_name [format "%s%s" "trial_synthesis/$top_design" "_syn"] -design [get_db designs $top_design]
    write_clp_script -clp_out_report clp_rule_check.report -design $top_design -files_1801 [format "%s%s%s" "./trial_synthesis/" $top_design "_syn.upf"] -ignore_level_shifter_high_to_low -log_file clp_pso_check.log -lp_only -netlist [format "%s%s%s" "./trial_synthesis/" $top_design "_syn.v"] -tcl > clp_pso_check.do
    report_power_intent -power_states -detail > [format "%s%s" "trial_synthesis/$top_design" {_syn.pso_design_report}]
    report_power_intent_instances -show_full_names -summary >> [format "%s%s" "trial_synthesis/$top_design" {_syn.pso_design_report}]
    report_power_intent_instances -show_full_names -detail >> [format "%s%s" "trial_synthesis/$top_design" {_syn.pso_design_report}]
  }


############################### Start of Structural analysis ###############################################
  file mkdir structural_analysis
  file mkdir structural_analysis/reg_cone
  file mkdir structural_analysis/path_depth
  file mkdir structural_analysis/io_to_cg
  file mkdir structural_analysis/through_paths
  file mkdir structural_analysis/combo_loops

  #reg_cone analysis
  analyze_structure -object sequential -type fanout -threshold ${structure_threshold} -cone_detail -report_type detail -out structural_analysis/reg_cone/struct_seq_fanout_${structure_threshold}.rpt

  if {![file readable ./structural_analysis/reg_cone/struct_seq_fanout_${structure_threshold}.rpt]} {
    set outfile_fanout [open "./structural_analysis/reg_cone/struct_seq_fanout_${structure_threshold}.rpt" w+]
    puts $outfile_fanout "The structure_threshold value is too high for the design and there are no registers to report above this threshold.\n Please reduce the structure_threshold value to a lower value"
    close $outfile_fanout
  }
  
  analyze_structure -object sequential -type fanin -threshold ${structure_threshold} -cone_detail -report_type detail -out structural_analysis/reg_cone/struct_seq_fanin_${structure_threshold}.rpt
  
  if {![file readable ./structural_analysis/reg_cone/struct_seq_fanin_${structure_threshold}.rpt]} {
    set outfile_fanin [open "./structural_analysis/reg_cone/struct_seq_fanin_${structure_threshold}.rpt" w+]
    puts $outfile_fanin "The structure_threshold value is too high for the design and there are no registers to report above this threshold.\n Please reduce the structure_threshold value to a lower value"
    close $outfile_fanin
  }  

  analyze_reg_cone -threshold ${structure_threshold} -top_n 5000 -out structural_analysis/reg_cone/reg_cone_summary.rpt

  if {[file readable ./structural_analysis/reg_cone/reg_cone_summary.rpt]} { 
    CETFE_sort_reg_cone -reg_cone_report structural_analysis/reg_cone/reg_cone_summary.rpt -reg_cone_sorted_report structural_analysis/reg_cone/reg_cone_summary.rpt
  } else {
    set outfile_reg_cone [open "structural_analysis/reg_cone/reg_cone_summary.rpt" w+]
    puts $outfile_reg_cone "The structure_threshold value is too high for the design and there are no registers to report above this threshold.\n Please reduce the structure_threshold value to a lower value"
    close $outfile_reg_cone
  }

  #combo loops
  CETFE_lint_timing_and_combo_loops -file_path structural_analysis/combo_loops/combinational_loops.rpt

  #io_to_cg and through paths
  set CLOCKS_LIST [get_db clocks]
  set CLK_IN_PORTS [get_clock_ports]
  set CLK_OUT_PORTS [get_db ports * -if {(.direction == out) && ((.name == *clk*) || (.name == *CLK*) || (.name == *Clk*)) }]
  
  set IN_X_CLK [remove_from_collection [all_inputs -design $top_design] $CLK_IN_PORTS]
  set OUT_X_CLK [remove_from_collection [all_outputs -design $top_design] $CLK_OUT_PORTS]
  
  set CG_LATCH_D_PINS_ALL {}
  if {[llength [CETFE_find_icg_cells]] != 0} {
    set USING_ICG_CELLS 1
    foreach CLOCK_ID $CLOCKS_LIST {
      set CG_LATCH_D_PINS_TEMP {}
      set CG_LATCH_D_PINS_TEMP [CETFE_find_icg_enable_pins -source_clk $CLOCK_ID]
      if {[llength $CG_LATCH_D_PINS_TEMP] != 0} {
        lappend CG_LATCH_D_PINS_ALL $CG_LATCH_D_PINS_TEMP
      }
    }
  }


  redirect [format "%s" "structural_analysis/io_to_cg/PI_to_CG.timing"] {report_timing -from $IN_X_CLK -to $CG_LATCH_D_PINS_ALL -max_paths 25 -nworst 5}

  redirect [format "%s" "structural_analysis/through_paths/through_paths.timing"] {report_timing -from $IN_X_CLK -to $OUT_X_CLK -max_paths 25 -nworst 5}

  #path depth analysis
  analyze_depth -depth ${depth_threshold} -report_type inst_level -fanin ${depth_fan_in_out_threshold} -fanout ${depth_fan_in_out_threshold} -out structural_analysis/path_depth/depth_inst_${depth_threshold}.rpt

  CETFE_detail_path_depth -path_report structural_analysis/path_depth/depth_inst_${depth_threshold}.rpt -path_detail_report structural_analysis/path_depth/depth_inst_Detail.rpt


}


######################################### write out yaml file ############################################
if {[file readable ./omega_local_user_vars.tcl]} {
  set fh [open ./omega_local_user_vars.tcl r]
  set varList {}
  set dictList {}
  while {[gets $fh line] >= 0} {
    if {[string match "set*" $line]} {
      set parts [split $line]
      if {[llength $parts] >= 2} {
	set varname [lindex $parts 1]
	if {![string match "prl_*" $varname]} {
	  lappend varList $varname
	}
      }
    } elseif {[string match "dict*" $line]} {
      set parts [split $line]
      if {[llength $parts] >= 3} {
	set varname [lindex $parts 2]
	if {[lsearch -exact $dictList $varname] < 0} {
	  lappend dictList $varname
        }
      }
    }
  }
  
  set out_yaml [open "omega_to_nu.yaml" w]
  CETFE_yaml_scalars_to_yaml $varList $out_yaml
  CETFE_yaml_dicts_to_yaml $dictList $out_yaml
  close $out_yaml
}


exit

