#############################################################################################
#        Copyright (c) 2015-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

source -verbose Genus_generic_define.tcl
source -verbose Genus_power_define.tcl
if {$GATE_CPF_FILE != [list]} {
  set USE_PSO 1
  set CPF_FILE $GATE_CPF_FILE
} else {
  set USE_PSO 0
}
set FILE_NAME_PREFIX $TOP_DESIGN

if {$USE_CORNER eq "TYPICAL"} {
  set Lib_CadenceLIB $Lib_CadenceTypLIB
  set LIB_DONT_USE $TYP_LIB_DONT_USE
  set LIB_PREFER $TYP_LIB_PREFER
  set BOUNDARY_LOAD $TYP_BOUNDARY_LOAD
  set OPERATING_CONDITION $TYP_OPERATING_CONDITION
  set Lib_MaxQrcTechFile $Lib_TypQrcTechFile
  set Lib_MaxCapTable $Lib_TypCapTable
} elseif {$USE_CORNER eq "FAST"} {
  set Lib_CadenceLIB $Lib_CadenceMinLIB
} else  {
  set Lib_CadenceLIB $Lib_CadenceLIB
}

set_distribute_host -local
set_multi_cpu_usage -localCpu $SUPERTHREAD_COUNT
set_power_output_dir .
set_power_analysis_mode -reset
read_activity_file -reset

read_lib -max $Lib_CadenceLIB
read_lib -lef $Lib_CadencePhysicalLibrary

read_verilog $POWER_NETLIST
set_top_module $TOP_DESIGN
if {(($Lib_CNODEdge_Info ne {}) && ($Lib_MinCNODLeak_Info ne {}) && ($Lib_CNODLeak_Config ne {}) && ($USE_CORNER eq "FAST")) || (($Lib_CNODEdge_Info ne {}) && ($Lib_TypCNODLeak_Info ne {}) && ($Lib_CNODLeak_Config ne {}) && ($USE_CORNER eq "TYPICAL"))} {
  if {([info exists POWER_DEF] != 0) && [file exists $POWER_DEF]} {
    read_def $POWER_DEF
  } else {
    puts "Warning: CNOD Leakage files found but Def file is missing\n"; 
    puts "Warning: Power analysis will continue without def file and boundary leakage will not be performed\n"; 
  }
}
set_message_limit 1000 {SPEF-1126 SPEF-1127 SPEF-1134 TCLCMD-917}
set_message -id {SPEF-1126 SPEF-1127 SPEF-1134 TCLCMD-917} -severity warn
read_spef $POWER_SPEF
read_sdc $POWER_SDC
set_message -id {SPEF-1126 SPEF-1127 SPEF-1134 TCLCMD-917} -severity error
set_message_limit 20 {SPEF-1126 SPEF-1127 SPEF-1134 TCLCMD-917}

set ideal_net_fanout_threshold 200
set cells_on_clock_tree [all_fanout -clock_tree -only_cells -flat]
set clock_gates [filter_collection $cells_on_clock_tree {is_combinational == true || is_integrated_clock_gating_cell == true}]
foreach_in_collection cg $clock_gates {
  set output_pin_list [get_pins -of_objects $cg -filter {pin_direction == out}]
  foreach_in_collection opl $output_pin_list {
    set current_pin_fanout [sizeof_collection [all_fanout -from [get_object_name $opl] -only_cells -levels 1]]
    if {$current_pin_fanout >= $ideal_net_fanout_threshold} {
      set_ideal_network -no_propagate [get_object_name $opl]
    }
  }
}

if {$DETAILED_REPORTS == 1} {
  check_design -all -noHtml -outfile check_design_report.txt
  checkTimingLibrary -checkPower -outfile check_timing_library_report.txt
}
if {($Lib_CNODEdge_Info ne {}) && ($Lib_MinCNODLeak_Info ne {}) && ($Lib_CNODLeak_Config ne {}) && ($USE_CORNER eq "FAST")} {
  load_side_file -files [list $Lib_CNODEdge_Info $Lib_MinCNODLeak_Info $Lib_CNODLeak_Config] -dump_tcl_file lef_side_file.tcl
  source lef_side_file.tcl
  set cmd "cat $Lib_MinCNODLeak_Info $Lib_CNODLeak_Config > all_lib_side_file.txt"
  eval exec $cmd
}
if {($Lib_CNODEdge_Info ne {}) && ($Lib_TypCNODLeak_Info ne {}) && ($Lib_CNODLeak_Config ne {}) && ($USE_CORNER eq "TYPICAL")} {
  load_side_file -files [list $Lib_CNODEdge_Info $Lib_TypCNODLeak_Info $Lib_CNODLeak_Config] -dump_tcl_file lef_side_file.tcl
  source lef_side_file.tcl
  set cmd "cat $Lib_TypCNODLeak_Info $Lib_CNODLeak_Config > all_lib_side_file.txt"
  eval exec $cmd
}

set_power_analysis_mode -enable_input_net_power true \
                        -enable_mt_in_vectorbasedflow true \
                        -report_missing_nets true \
                        -report_black_boxes true

set_power_analysis_mode -method static \
                        -create_binary_db false \
                        -write_static_currents true \
                        -x_transition_factor 0 \
                        -z_transition_factor 0

if {(($Lib_CNODEdge_Info ne {}) && ($Lib_MinCNODLeak_Info ne {}) && ($Lib_CNODLeak_Config ne {}) && ($USE_CORNER eq "FAST")) || (($Lib_CNODEdge_Info ne {}) && ($Lib_TypCNODLeak_Info ne {}) && ($Lib_CNODLeak_Config ne {}) && ($USE_CORNER eq "TYPICAL"))} {
  set_power_analysis_mode -create_binary_db false -enable_input_net_power true \
                          -enable_mt_in_vectorbasedflow true -method static \
                          -report_missing_nets true -write_static_currents true \
                          -report_black_boxes true -x_transition_factor 0 -z_transition_factor 0 \
                          -boundary_gate_leakage_file  all_lib_side_file.txt -boundary_gate_leakage_report true \
                          -boundary_leakage_multi_pgpin_support true \
                          -boundary_leakage_PXE_support true
} else {
  set_power_analysis_mode -create_binary_db false -enable_input_net_power true \
                          -enable_mt_in_vectorbasedflow true -method static \
                          -report_missing_nets true -write_static_currents true \
                          -report_black_boxes true -x_transition_factor 0 -z_transition_factor 0
}

set FIRST_TOGGLE_FILE 1
foreach TOGGLE_FILE $ABSOLUTE_DIAG_PATHS DN $DIAG_NAMES DST $DIAG_START_TIMES DET $DIAG_END_TIMES {
  read_activity_file -reset
  if {$USE_VCD == 1} {
    print "\nStart and Stop times are ${DST} ns and ${DET} ns respectively\n";
    read_activity_file -format VCD -start ${DST}ns -end ${DET}ns -scope $SCOPE $TOGGLE_FILE
  } else {
    read_activity_file -format SAIF -scope $SCOPE $TOGGLE_FILE
  }
  if {($DETAILED_REPORTS == 1) && ($FIRST_TOGGLE_FILE == 1)} {
    dump_unannotated_nets -type all -file unannotated_nets_report.txt
    set FIRST_TOGGLE_FILE 0
  }
  propagate_activity
  report_power -no_wrap -cell_type all -net -outfile [format "%s%s" $DN ".power_report"]
  if {$DETAILED_REPORTS == 1} {
    set CGE_FILE clock_gating_efficiency_report.txt
    set RGE_FILE register_gating_efficiency_report.txt
    set TR_FILE toggle_rate_report.txt
    redirect -append $CGE_FILE {echo {++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}}
    redirect -append $CGE_FILE {echo [format "%s%s" "Clock gating efficiency report for diag: " $DN]}
    redirect -append $CGE_FILE {echo {++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}}
    redirect -append $CGE_FILE {report_power -no_wrap -clock_gating_efficiency}
    redirect -append $RGE_FILE {echo {++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}}
    redirect -append $RGE_FILE {echo [format "%s%s" "Register gating efficiency report for diag: " $DN]}
    redirect -append $RGE_FILE {echo {++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}}
    redirect -append $RGE_FILE {report_power -no_wrap -register_gating_efficiency -cluster_gating_efficiency}
    redirect -append $TR_FILE {echo {++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}}
    redirect -append $TR_FILE {echo [format "%s%s" "Toggle rate report for diag: " $DN]}
    redirect -append $TR_FILE {echo {++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}}
    redirect -append $TR_FILE {report_power -no_wrap -toggle_rate}
    if {$USE_VCD == 1} {
      set VP_FILE vcd_time_based_power_report.txt
      redirect -append $VP_FILE {echo {++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}}
      redirect -append $VP_FILE {echo [format "%s%s" "VCD time-based power profile report for diag: " $DN]}
      redirect -append $VP_FILE {echo {++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}}
      redirect -append $VP_FILE {report_power -no_wrap -time_based_report -cell_type all}
    }
  }
}

exit
