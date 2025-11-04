#############################################################################################
#        Copyright (c) 2014-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

set_var search_path ". .. ../scripts/tempus"

set GENSDF_UNCERTAINTY 0
set GENUS_DERATE_METHOD 0
if {[file exists Genus_generic_define.tcl] != 0} {
  source Genus_generic_define.tcl
  set GENSDF_UNCERTAINTY $GENUS_SYNTH_UNCERTAINTY
} else {
  echo [format "%s%s" "Err" "or: Genus_generic_define.tcl is not available - run"]
  echo [format "%s%s" "Err" "or: a synthesis makefile target before attempting this SDF generation step."]
  exit
} 
source Tempus_define.tcl
source ../scripts/tempus/Tempus_utils.tcl

read_lib $Lib_CadenceLIB

TIP_get_file_name_prefix

if {[file exists "Block_syn.v"] != 0} {
  if {[file exists "Block_syn.design_name"] != 0} {
    source -echo -verbose Block_syn.design_name
  } else {
    echo [format "%s%s" "Err" "or: Block_syn.design_name must be present in the synthesis output directory to generate a block-level SDF file"]
    exit
  }
  set TOP_DESIGN $BLOCK_DESIGN
  set FILE_NAME_PREFIX Block
}

if {[file exists [format "%s%s" $FILE_NAME_PREFIX "_syn.v"]] != 0} {
  read_verilog [format "%s%s" $FILE_NAME_PREFIX "_syn.v"]
} else {
  echo [format "%s%s" "Err" "or: No input netlist detected."]
  exit
}

set_top_module $TOP_DESIGN

#############################
# Apply generic constraints #
#############################

set_op_cond $OPERATING_CONDITION
set_analysis_mode -analysisType single

set CLOCK_PORT [list]
redirect /dev/null {set CLOCK_PORT [get_ports -quiet "$CLK_PORT"]}
redirect /dev/null {set CLOCK_PORT [filter_collection $CLOCK_PORT {port_direction == in}]}
if {[sizeof_collection $CLOCK_PORT] == 0} {
  create_clock -period $CLOCK_PERIOD -name CLK
} else {
  set j 0
  foreach CP $CLOCK_PORT {
    set i [expr $j + 1]
    set CLOCK_PERIOD [expr 1000.0/[lindex $CLK_FREQ $j]]
    create_clock -period $CLOCK_PERIOD -name CLK$i $CP
    incr j
  }
}

set DEBUG_CLOCK_PORT [list]
redirect /dev/null {set DEBUG_CLOCK_PORT [get_ports -quiet "$JTAG_CLK_PORT"]}
redirect /dev/null {set DEBUG_CLOCK_PORT [filter_collection $DEBUG_CLOCK_PORT {port_direction == in}]}
if {[sizeof_collection $DEBUG_CLOCK_PORT] != 0} {
  create_clock -period [expr 4 * $CLOCK_PERIOD] -name JTCK $DEBUG_CLOCK_PORT
}
set_clock_transition $MAX_CLOCK_TRANSITION [get_clocks *]
set_clock_uncertainty -setup [expr $GENSDF_UNCERTAINTY + $CLOCK_JITTER] [get_clocks *]
set_clock_uncertainty -hold $GENSDF_UNCERTAINTY [get_clocks *]

#######################
# Boundary conditions #
#######################

set in_no_clk [remove_from_collection [remove_from_collection [all_inputs] $CLOCK_PORT] $DEBUG_CLOCK_PORT] 

set DRIVE_CELL_LIBRARY $DRIVE_CELL
set D_CELL [list]
foreach_in_collection S [get_libs *] {
  redirect /dev/null {set D_CELL [get_lib_cells [format "%s/%s" [get_object_name $S] $DRIVE_CELL]]}
  if {[sizeof_collection $D_CELL] != 0} {
    set DRIVE_CELL_LIBRARY [get_object_name $S]
  }
}

# default boundary conditions: output load = 4X specified - mostly invx1, input drive = specified
set b_pin [get_lib_pins $BOUNDARY_LOAD]
set b_load [get_property $b_pin pin_capacitance]
set_load [expr 4 * $b_load] [all_outputs]
set_driving_cell -lib_cell $DRIVE_CELL -library $DRIVE_CELL_LIBRARY -pin $DRIVE_PIN -from_pin $DRIVE_PIN_FROM $in_no_clk

# DRC constraints
set_max_transition $MAX_DATA_TRANSITION [current_design]
if {$MAX_FANOUT > 0} {
  set_max_fanout $MAX_FANOUT [current_design]
}
if {$MAX_CAPACITANCE > 0} {
  set_max_capacitance $MAX_CAPACITANCE [current_design]
} elseif {$MAX_CAPACITANCE == 0} {
  set_max_capacitance [expr 20 * $b_load] [remove_from_collection [all_inputs] [all_clocks]]
}

############
# Derating #
############

set DERATING_USED 0
if {$DERATE_SLDC != 1} {
  set DERATING_USED 1
  set_timing_derate -late -data -cell_delay $DERATE_SLDC
}
if {$DERATE_SLDN != 1} {
  set DERATING_USED 1
  set_timing_derate -late -data -net_delay $DERATE_SLDN
}
if {$DERATE_SLCC != 1} {
  set DERATING_USED 1
  set_timing_derate -late -clock -cell_delay $DERATE_SLCC
}
if {$DERATE_SLCN != 1} {
  set DERATING_USED 1
  set_timing_derate -late -clock -net_delay $DERATE_SLCN
}
if {$DERATE_SEDC != 1} {
  set DERATING_USED 1
  set_timing_derate -early -data -cell_delay $DERATE_SEDC
}
if {$DERATE_SEDN != 1} {
  set DERATING_USED 1
  set_timing_derate -early -data -net_delay $DERATE_SEDN
}
if {$DERATE_SECC != 1} {
  set DERATING_USED 1
  set_timing_derate -early -clock -cell_delay $DERATE_SECC
}
if {$DERATE_SECN != 1} {
  set DERATING_USED 1
  set_timing_derate -early -clock -net_delay $DERATE_SECN
}
if {$DERATING_USED == 1} {
  set timing_remove_clock_reconvergence_pessimism true
}

##########################################
# Reading in setload for net capacitance #
##########################################

if {[file exists [format "%s%s" $FILE_NAME_PREFIX "_syn.setload"]] != 0} {
  read_sdc [format "%s%s" $FILE_NAME_PREFIX "_syn.setload"]
} else {
  echo [format "%s%s" "Warn" "ing: No setload file was found in the local directory. Tempus will generate the SDF based on wireload values instead."]
}

##############################################################################
# Zero out the delays through clock gating cells and nets; generate the .sdf #
##############################################################################

set C_NET [list]
set CONTAINS_PCM [sizeof_collection [get_cells -hier -quiet PCM]]
if {$CONTAINS_PCM == 1} {
  set ZERO_CELL_LIST [list]
  set ISOLATION_FLOPS [get_cells -quiet PCM/*ISOLATE_reg*]
  set SWITCH_FLOPS [get_cells -quiet PCM/*PSO_reg*]
  set RETAIN_FLOPS [get_cells -quiet PCM/*BRETAIN_reg*]
  set SAVE_FLOPS [get_cells -quiet PCM/*SAVE_reg*]
  set RESTORE_FLOPS [get_cells -quiet PCM/*BRESTORE_reg*]
  set TARGET_FLOPS [add_to_collection [add_to_collection [add_to_collection [add_to_collection $ISOLATION_FLOPS $SWITCH_FLOPS] $RETAIN_FLOPS] $SAVE_FLOPS] $RESTORE_FLOPS]
  if {[sizeof_collection $TARGET_FLOPS] != 0} {
    foreach_in_collection targflps $TARGET_FLOPS {
      set ZERO_CELL_LIST [add_to_collection $ZERO_CELL_LIST [all_fanout -from [format "%s%s" [get_object_name $targflps] "/*"] -only_cells]]
    }
    set ZERO_CELL_LIST [filter_collection $ZERO_CELL_LIST {is_combinational == true}]
    set ZERO_CELL_LIST [remove_from_collection -intersect $ZERO_CELL_LIST [get_cells PCM/*]]
  }
  if {[sizeof_collection $ZERO_CELL_LIST] != 0} {
    foreach_in_collection zcl $ZERO_CELL_LIST {
      set ZCL_IN [filter_collection [get_pins [format "%s%s" [get_object_name $zcl] {/*}]] {pin_direction == in}]
      set ZCL_OUT [filter_collection [get_pins [format "%s%s" [get_object_name $zcl] {/*}]] {pin_direction == out}]
      redirect /dev/null {set_annotated_delay -cell 0.0 -from $ZCL_IN -to $ZCL_OUT}
      foreach_in_collection P [add_to_collection $ZCL_IN $ZCL_OUT] {
	set C_NET [add_to_collection [all_connected [get_object_name $P]] $C_NET]
      }
    }
  }
}

set CG_CELLS [all_fanout -clock_tree -only_cells -flat]
set CLOCK_GATES [add_to_collection [filter_collection $CG_CELLS {is_combinational == true}] [filter_collection $CG_CELLS {is_integrated_clock_gating_cell == true}]]
if {[sizeof_collection $CLOCK_GATES] != 0} {
  foreach_in_collection G $CLOCK_GATES {
    set G_IN [filter_collection [get_pins [format "%s%s" [get_object_name $G] {/*}]] {pin_direction == in}]
    set G_OUT [filter_collection [get_pins [format "%s%s" [get_object_name $G] {/*}]] {pin_direction == out}]
    redirect /dev/null {set_annotated_delay -cell -from $G_IN -to $G_OUT 0.0}
    foreach_in_collection P [add_to_collection $G_IN $G_OUT] {
      set C_NET [add_to_collection [all_connected [get_object_name $P]] $C_NET]
    }
  }
}

# Async reset staging flops, as well as all logic on the async reset tree,
# needs to get set to a small non-zero value for gatesims to function properly
set ASYNC_RESET_CELLS [list]
set ALL_CELLS_ON_RESET_NETWORK [list]
set ALL_ASYNC_FLOP_PINS [all_registers -async_pins -edge_triggered]
set ASYNC_RESET_FLOPS [filter_collection [all_registers -cells -edge_triggered] "full_name =~ *asyncreset*"]
set ASYNC_RESET_OUTPUTS [filter_collection [all_registers -output_pins -edge_triggered] "full_name =~ *asyncreset*"]
set ASYNC_RESET_ASYNC_PINS [filter_collection [all_registers -async_pins -edge_triggered] "full_name =~ *asyncreset*"]
foreach_in_collection ARO $ASYNC_RESET_OUTPUTS {
  set ARO_FO_COUNT [sizeof_collection [all_fanout -from [get_object_name $ARO] -to $ALL_ASYNC_FLOP_PINS -only_cells -flat]]
  if { $ARO_FO_COUNT != 0} {  
    append_to_collection -unique ALL_CELLS_ON_RESET_NETWORK [filter_collection [all_fanout -from [get_object_name $ARO] -to $ALL_ASYNC_FLOP_PINS -only_cells -flat] {is_combinational == true}]
  }
}
foreach_in_collection ARAP $ASYNC_RESET_ASYNC_PINS {
  append_to_collection -unique ALL_CELLS_ON_RESET_NETWORK [filter_collection [all_fanin -to [get_object_name $ARAP] -only_cells -flat] {is_combinational == true}]
}
set ASYNC_RESET_CELLS [add_to_collection -unique $ASYNC_RESET_FLOPS $ALL_CELLS_ON_RESET_NETWORK]
if {$ASYNC_RESET_CELLS != [list]} {
  foreach_in_collection ARC $ASYNC_RESET_CELLS {
    set ARC_IN [filter_collection [get_pins [format "%s%s" [get_object_name $ARC] {/*}]] {pin_direction == in}]
    set ARC_OUT [filter_collection [get_pins [format "%s%s" [get_object_name $ARC] {/*}]] {pin_direction == out}]
    redirect /dev/null {set_annotated_delay -cell 0.001 -from $ARC_IN -to $ARC_OUT}
    foreach_in_collection P [add_to_collection $ARC_IN $ARC_OUT] {
      set C_NET [add_to_collection [all_connected [get_object_name $P]] $C_NET]
    }
  }
}

if {[sizeof_collection $C_NET] != 0} {
  redirect /dev/null {set_resistance 0.0 $C_NET}
}
redirect /dev/null {set TEST_SE [get_ports -quiet test_se]}
if {[sizeof_collection $TEST_SE] != 0} {
  redirect /dev/null {set_resistance 0.0 [all_connected $TEST_SE]}
}
set VER [lindex [split [getVersion] {-}] 0]
if {$VER >= 20} {
  set_message -id IMPESI-4001 -severity warn
}
write_sdf -nonegchecks -filter -collapse_internal_pins -ideal_clock_network -splitsetuphold [format "%s%s" $FILE_NAME_PREFIX "_syn.sdf"]

exit
