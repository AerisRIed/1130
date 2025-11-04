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
    compute_odc -allow_port_punching -allow_precompute -max_precompute_levels 2 -multicycle -run_logic_opt
    CETFE_local_odc_reporting -report_type lg -input_type vectorless -file_name ./odc_analysis/statistical/logic/structural_lg_odc_pp_mc_precomp.rpt
  
    #reset report
    compute_odc -allow_port_punching -allow_precompute -max_precompute_levels 2 -multicycle -run_reset_opt
    CETFE_local_odc_reporting -report_type rst -input_type vectorless -file_name ./odc_analysis/statistical/reset/structural_reset_odc_pp_mc_precomp.rpt
  
    #ODC report
    compute_odc -allow_port_punching -allow_precompute -max_precompute_levels 2 -multicycle
    CETFE_local_odc_reporting -report_type odc -input_type vectorless -file_name ./odc_analysis/statistical/odc/structural_cg_odc_pp_mc_precomp.rpt
  
  
    #STB reports
    compute_stb 
    CETFE_local_odc_reporting -report_type stbs -input_type vectorless -file_name ./odc_analysis/statistical/stb/structural_standard_stb.rpt
  
    compute_stb -const_based
    CETFE_local_odc_reporting -report_type stbc -input_type vectorless -file_name ./odc_analysis/statistical/stb/structural_constant_stb.rpt
  
  
  #Logic_gates sub reports
    compute_odc -allow_port_punching -run_logic_opt
    CETFE_local_odc_reporting -report_type lg -input_type vectorless -file_name ./odc_analysis/statistical/logic/structural_lg_odc_pp.rpt
  
    compute_odc -allow_port_punching -multicycle -run_logic_opt
    CETFE_local_odc_reporting -report_type lg -input_type vectorless -file_name ./odc_analysis/statistical/logic/structural_lg_odc_pp_mc.rpt
  
    compute_odc -allow_port_punching -allow_precompute -max_precompute_levels 2 -run_logic_opt
    CETFE_local_odc_reporting -report_type lg -input_type vectorless -file_name ./odc_analysis/statistical/logic/structural_lg_odc_pp_precomp.rpt
  
  #ODC sub reports
    compute_odc -allow_port_punching
    CETFE_local_odc_reporting -report_type odc -input_type vectorless -file_name ./odc_analysis/statistical/odc/structural_cg_odc_pp.rpt
  
    compute_odc -allow_port_punching -multicycle
    CETFE_local_odc_reporting -report_type odc -input_type vectorless -file_name ./odc_analysis/statistical/odc/structural_cg_odc_pp_mc.rpt

    compute_odc -allow_port_punching -allow_precompute -max_precompute_levels 2
    CETFE_local_odc_reporting -report_type odc -input_type vectorless -file_name ./odc_analysis/statistical/odc/structural_cg_odc_pp_precomp.rpt

  if {$stimulus_file_list ne ""} {
    file mkdir odc_analysis/vector
    set REM_ODC_VARS "-show_power_details -unit nW -max_expr_print_length 20 -min_reg_width 8 -max_oper_count 16 -show_depth -only_file_row_info -expand_to_signals -sort_by design_dyn_pct -cols id exprsn_metadata file_row_col cg_status enable_exprsn enable_occur odc_exprsn skip_gating total_toggles wasted_pct clock_toggles wasted_clock_pct dyn_pow_saving_pct design_dyn_pct bank_name"
    set REM_LOGIC_GATING_VARS "-show_power_details -unit nW -max_expr_print_length 20 -operators_only -expand_to_signals -show_depth -cols id score area_score exprsn exprsn_metadata file_row_col function_type width wt_pct logic -sort_by score"
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

      compute_odc -allow_port_punching -allow_precompute -max_precompute_levels 2 -multicycle -run_logic_opt
      CETFE_local_odc_reporting -report_type lg -input_type simulation -stim_path $stimulus_file -stim_type $stimulus_format -file_name ./odc_analysis/vector/$diag_name/logic/simulation_lg_odc_pp_mc_precomp.rpt -delete_vector

      compute_odc -allow_port_punching -allow_precompute -max_precompute_levels 2 -multicycle
     CETFE_local_odc_reporting -report_type odc -input_type simulation -stim_path $stimulus_file -stim_type $stimulus_format -file_name ./odc_analysis/vector/$diag_name/odc/simulation_cg_odc_pp_mc_precomp.rpt -delete_vector

      compute_stb
      CETFE_local_odc_reporting -report_type stbs -input_type simulation -stim_path $stimulus_file -stim_type $stimulus_format -file_name ./odc_analysis/vector/$diag_name/stb/simulation_standard_stb.rpt -delete_vector

      compute_stb -const_based
      CETFE_local_odc_reporting -report_type stbc -input_type simulation -stim_path $stimulus_file -stim_type $stimulus_format -file_name ./odc_analysis/vector/$diag_name/stb/simulation_constant_stb.rpt -delete_vector

#Logic_gates sub reports
      compute_odc -allow_port_punching -run_logic_opt
      CETFE_local_odc_reporting -report_type lg -input_type simulation -stim_path $stimulus_file -stim_type $stimulus_format -file_name ./odc_analysis/vector/$diag_name/logic/simulation_lg_odc_pp.rpt -delete_vector

      compute_odc -allow_port_punching -multicycle -run_logic_opt
      CETFE_local_odc_reporting -report_type lg -input_type simulation -stim_path $stimulus_file -stim_type $stimulus_format -file_name ./odc_analysis/vector/$diag_name/logic/simulation_lg_odc_pp_mc.rpt -delete_vector

      compute_odc -allow_port_punching -allow_precompute -max_precompute_levels 2 -run_logic_opt
      CETFE_local_odc_reporting -report_type lg -input_type simulation -stim_path $stimulus_file -stim_type $stimulus_format -file_name ./odc_analysis/vector/$diag_name/logic/simulation_lg_odc_pp_precomp.rpt -delete_vector

#ODC sub reports
      compute_odc -allow_port_punching
      CETFE_local_odc_reporting -report_type odc -input_type simulation -stim_path $stimulus_file -stim_type $stimulus_format -file_name ./odc_analysis/vector/$diag_name/odc/simulation_cg_odc_pp.rpt -delete_vector

      compute_odc -allow_port_punching -multicycle
      CETFE_local_odc_reporting -report_type odc -input_type simulation -stim_path $stimulus_file -stim_type $stimulus_format -file_name ./odc_analysis/vector/$diag_name/odc/simulation_cg_odc_pp_mc.rpt -delete_vector

      compute_odc -allow_port_punching -allow_precompute -max_precompute_levels 2
      CETFE_local_odc_reporting -report_type odc -input_type simulation -stim_path $stimulus_file -stim_type $stimulus_format -file_name ./odc_analysis/vector/$diag_name/odc/simulation_cg_odc_pp_precomp.rpt -delete_vector

    }
  }
}
#######################Start of Flow 3########################
if {$prl_joules_flow == 3} {
  file mkdir structural_analysis 
  file mkdir structural_analysis/reg_cone
  file mkdir structural_analysis/path_depth
  file mkdir structural_analysis/io_to_cg
  file mkdir structural_analysis/through_paths
  file mkdir structural_analysis/combo_loops

  if {$rtl_flow == 1} {
    prototype_design -synthesis_type logical -stop_at generic -database_generation db_only
    puts stdout "Generic DB Created: ${top_design}_generic.db"
    write_db -to_file dbs/structural_${top_design}_gen.db
  
    #Map the design
    prototype_design -synthesis_type logical -stop_at mapper -database_generation db_only
    puts stdout "Mapped DB Created: ${top_design}_map.db"
    write_db -to_file dbs/structural_${top_design}_map.db
  
    syn_opt
    write_db -to_file dbs/structural_${top_design}_opt.db
  } else {
    source -echo ./omega_local_user_vars.tcl
    CETFE_manipulate_omega_user_vars "joules"
    CETFE_validate_omega_user_vars "joules"
  }

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

exit

