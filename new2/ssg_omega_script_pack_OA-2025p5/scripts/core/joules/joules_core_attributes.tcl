################################################################################
# Copyright (c) 2024 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design #
# Systems Inc. They may not be modified, copied, reproduced, distributed, or   #
# disclosed to third parties in any manner, medium, or form, in whole or in    #
# part, without the prior written consent of Cadence Design Systems Inc.       #
################################################################################

#########################################################
# This file contains all non-default attributes to	#
# control overall tool behavior				#
#########################################################

#################
# General	#
#################

set_db / .iopt_stats 1
set_db / .map_fancy_names 1
set_db / .source_verbose true
set_db / .source_verbose_info false
set_db / .information_level 9
set_db / .heartbeat 1200
set_db / .heartbeat_print_date 1
set_db / .gen_module_prefix CDN_DP_
set_db / .retime_reg_naming_suffix _retimed_reg
set_db / .hdl_error_on_blackbox false
set_db / .init_blackbox_for_undefined true
set_db / .write_vlog_empty_module_for_logic_abstract true
set_db hdl_vhdl_read_version 2008

#########################
## Joules Low Power	#
#########################
if {$insert_clock_gating == 1} {
  set_db / .optimize_net_area false
  set_db / .glo_redrem_ultra_effort true
  set_db / .scale_of_area_per_unit_length 0

  #low power setting
  set_db / .lp_insert_clock_gating true
  set_db / .lp_insert_early_clock_gating true
  set_db / .lp_insert_discrete_clock_gating_logic true
  set_db / .lp_clock_gating_prefix genus_inserted_cg
  set_db / .lp_clock_gating_infer_enable true

  #advance feature settings
  set_db / .lbr_seq_in_out_phase_opto true
  set_db / .boundary_optimize_invert_hpins true
  set_db / .popt_constant_propagation_cg 1
  set_db / .optimize_merge_flops true
  set_db / .optimize_merge_latches true
  set_db / .ultra_global_mapping true
  set_db / .syn_generic_effort high
  set_db / .syn_map_effort high
  set_db / .syn_opt_effort extreme
  set_db / .retime_effort_level high
  set_db / .control_logic_optimization advanced
  set_db / .dp_sharing advanced
  set_db / .dp_speculation basic
  set_db / .hlo_ultra true
  set_db / .iopt_ultra_effort_for_area 1
  set_db / .enable_ultra_gmap_redrem 1
  set_db / .dp_analytical_opt extreme

  #using Multibit cells
  set_db / .use_multibit_cells true
  set_db / .multibit_cells_from_different_busses true
  set_db / .multibit_mapping_effort_level high
  set_db / .multibit_debug true
  set_db / .multibit_auto_exclude_registers_with_exceptions true

  
} else {
  set_db / .lbr_seq_in_out_phase_opto false
  set_db / .boundary_optimize_invert_hpins false
  set_db / .syn_generic_effort medium
  set_db / .dp_analytical_opt standard
}

if {[file readable $rtl_upf]} {
  set_db / .add_pin_name_to_lp_instance true
  set_db / .hdl_unconnected_value none
} else {
  set_db / .hdl_unconnected_value 0
}



set_db / .opt_leakage_to_dynamic_ratio 0.5
##################################################
##    Root-level optimization attributes         #
##################################################
set_db / .exact_match_seq_sync_ctrls true
set_db / .exact_match_seq_async_ctrls true

set_db / .power_engine joules

set_db / .optimize_constant_0_flops true
set_db / .optimize_constant_1_flops true
set_db / .delete_unloaded_seqs true
set_db / .optimize_constant_latches true
set_db / .timing_use_ecsm_pin_capacitance true
set_db / .timing_report_enable_common_header true
set_db / .distributed_area_opt_cleanup true
set_db / .map_mt_area_opt_cleanup true
set_db / .use_multi_clks_latency_uncertainty_optimize true
set_db / .use_multi_clks_latency_uncertainty_report true
set_db / .auto_ungroup both
set_db / .use_scan_seqs_for_non_dft degenerated_only
set_db / .print_ports_nets_preserved_for_cb true
set_db / .detailed_sdc_messages true
set_db / .hdl_max_loop_limit 1024
set_db / .hdl_use_cw_first true
set_db / .hdl_zero_replicate_is_null true
set_db / .hdl_error_on_blackbox true
set_db / .hdl_report_case_info true
set_db / .hdl_generate_index_style %s_%d
set_db / .hdl_generate_separator _
set_db / .hdl_interface_separator _
set_db / .ungroup_separator _
set_db / .dp_ungroup_separator _
set_db / .hdl_parameterize_module_name false
set_db / .hdl_parameter_naming_style _%d
set_db / .hdl_append_generic_ports false
set_db / .wlec_analyze_setup true
set_db / .wlec_set_cdn_synth_root true
set_db / .wlec_gzip_fv_json true
set_db / .verification_directory_naming_style genus_fv
set_db / .write_vlog_line_wrap_limit 200
set_db / .statistics_log_data true
set_db / .write_db_auto_save_user_globals true
set_db / .dft_include_test_signal_outputs_in_abstract_model false
set_db / .dft_include_controllable_pins_in_abstract_model none
set_db / .enable_simple_boundary_optimization true
set_db / .hdl_drive_redundant_flop_load_with_zero true
set_db / .wlec_rtl_names_flow true
set_db / .time_recovery_arcs true

set_db message:CDFG-508    .max_print infinity
set_db message:CDFG2G-615  .max_print infinity
set_db message:CDFG2G-616  .max_print infinity
set_db message:CDFG-417    .severity Error
set_db message:CDFG-464    .severity Error
set_db message:CDFG-465    .severity Error
set_db message:CDFG-467    .severity Error
set_db message:CDFG-562    .severity Error
set_db message:DFT-302     .severity Error
set_db message:ELABUTL-125 .severity Error
set_db message:PHYS-360    .severity Error
set_db message:VLOGPT-650  .severity Error
suppress_messages {TUI-58 TUI-59 RETIME-402 LBR-30 LBR-31 LBR-72 LBR-77 LBR-155 LBR-162 LBR-170 LBR-201 PHYS-106 PHYS-109 RPT_CG-12 CDFG-738 CDFG-739 DFT-515 GLO-28}

