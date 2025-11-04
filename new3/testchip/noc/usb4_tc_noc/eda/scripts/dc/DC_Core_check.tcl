#############################################################################################
#        Copyright (c) 2004-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

################################################
# Define variables and search paths            #
################################################

if {[info exists env(DESIGN)] != 0} {
  set DESIGN_NAME [getenv DESIGN]
  echo [format "%s%s%s" "In" "fo: The top-level design name is taken from the shell environment variable DESIGN and is set to: " $DESIGN_NAME]
} else {
  echo [format "%s%s" "Err" "or: The top-level module name must be defined by the DESIGN environment variable;"]
  echo [format "%s%s" "Err" "or: Setup env_design.sh correctly and source the file before running the DC check make target"]
  quit
}
if {[info exists env(RTL_PATH)] != 0} {
  set RTL_PATH [getenv RTL_PATH]
  echo [format "%s%s%s" "In" "fo: The root path to the RTL directory is coming from the shell environment variable RTL_PATH and is set to: " $RTL_PATH]
} else {
  echo [format "%s%s" "Err" "or: The root path to the RTL directory must be defined by the RTL_PATH environment variable;"]
  echo [format "%s%s" "Err" "or: Setup env_design.sh correctly and source the file before running the DC check make target"]
  quit
}
if {[info exists env(FILE_LIST)] != 0} {
  set VF_FILE_LIST [getenv FILE_LIST]
  echo [format "%s%s%s" "In" "fo: The file list containing all input RTL is coming from the shell environment variable FILE_LIST and is set to: " $VF_FILE_LIST]
} else {
  echo [format "%s%s" "Err" "or: The file list containing all input RTL must be defined by the FILE_LIST environment variable;"]
  echo [format "%s%s" "Err" "or: Setup env_design.sh correctly and source the file before running the DC check make target"]
  quit
}

set USE_MEMORY_MACROS 0
if {[info exists env(USE_MEMORY_MACROS)] != 0} {
  set USE_MEMORY_MACROS [getenv USE_MEMORY_MACROS]
}

set TOP_DESIGN $DESIGN_NAME
set FILE_NAME_PREFIX $TOP_DESIGN
echo [format "%s%s%s%s" "In" "fo: Running at the " $FILE_NAME_PREFIX ""]

lappend search_path . .. ../scripts/dc
lappend search_path [format "%s"   $RTL_PATH]
lappend search_path [format "%s%s"   $RTL_PATH {/noc}]
lappend search_path [format "%s%s"   $RTL_PATH {/memories}]
lappend search_path [format "%s%s"   $RTL_PATH {/primitives}]

################################################
# Target generic GTECH library                 #
################################################

set_app_var target_library gtech.db
set_app_var link_library [list]
set_app_var symbol_library [list]
set_app_var synthetic_library [list]

read_db $target_library
lappend link_library * standard.sldb
set_app_var link_library [concat $target_library $link_library]
lappend symbol_library generic.sdb
read_db standard.sldb
lappend synthetic_library {dw_foundation.sldb}
set_app_var link_library [concat $link_library $synthetic_library]
lappend search_path [format "%s%s" $synopsys_root {/dw/sim_ver}]
read_db dw_foundation.sldb

set_app_var case_analysis_with_logic_constants true
set_app_var hdlin_reporting_level comprehensive
set_app_var hdlin_check_no_latch true
set_app_var hdlin_vrlg_std 2001
set_app_var hdlin_sverilog_std 2012
set_app_var hdlin_mux_size_limit 32
set_app_var hdlin_auto_save_templates true
set_app_var compile_seqmap_honor_sync_set_reset true
set_app_var enable_recovery_removal_arcs true
set_app_var hdlin_ff_always_sync_set_reset true
set_app_var hdlin_ff_always_async_set_reset true
set_app_var compile_seqmap_honor_sync_set_reset true
set_app_var hdl_keep_licenses false
define_design_lib WORK -path workdir
sh mkdir -p workdir
suppress_message [list TIM-052 TIM-128 ELAB-311 VER-173 PSYN-1002 TFCHK-014 HDL-193 RCEX-011]
set_app_var verbose_messages false
set_app_var sh_new_variable_message false
set_app_var verilogout_no_tri true
set_app_var report_default_significant_digits 3
set_app_var exit_delete_command_log_file true
set_app_var exit_delete_filename_log_file true
set hdlin_enable_ieee_1735_support true

set UNIQUE_MACRO_CELLS [list]

################################################
# Read in the design                           #
################################################

redirect /dev/null {remove_license HDL-Compiler}
while {[get_license {"HDL-Compiler"}] == 0} {
   echo {Waiting for HDL-Compiler license...}
   sh sleep 120
}

set_app_var hdlin_sv_blackbox_modules "placeholder_ICG"

analyze -format sverilog -vcs "-sverilog -f $VF_FILE_LIST"

elaborate $TOP_DESIGN
current_design $TOP_DESIGN

set LINK_STATUS [link]
if {$LINK_STATUS == 0} {
  echo [concat [format "%s%s" [join [concat "Err" "or"] ""] {: unresolved references. Exiting ...}]]
  quit
}

redirect /dev/null {remove_license HDL-Compiler}

redirect combinational_loops.txt {report_timing -loops -enable_preset_clear_arcs -nosplit}
if {[sh (grep "Timing loop detected." combinational_loops.txt | wc -l)] > 0} {
  echo [format "%s%s" "Err" "or: combinational loops detected - see combinational_loops.txt file."]
  quit
} else {
  echo "Check passed: there are no combinational timing loops in the design."
  sh rm combinational_loops.txt
}

current_design $TOP_DESIGN
uniquify

################################################
# Check for RTL errors in the design           #
################################################

redirect -tee [format "%s%s" $FILE_NAME_PREFIX {_syn.check_design}] {check_design -summary -no_warnings -nosplit}

################################################
# Generate output files of all flops and all   #
# latches in the design                        #
################################################

redirect /dev/null {set ALL_FLOPS [all_registers -edge_triggered]}
redirect /dev/null {set ALL_LATCHES [filter_collection [all_registers -level_sensitive] undefined(retention_cell)]}
foreach_in_collection AF $ALL_FLOPS {
  redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.rtl_flop_list}] {echo [get_object_name $AF]}
}
foreach_in_collection AL $ALL_LATCHES {
  redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.rtl_latch_list}] {echo [get_object_name $AL]}
}

################################################
# Generate output files of all sync clear,     #
# sync set, async clear, async set, and        #
# standard flops in the design                 #
################################################

set SYNC_CLEAR_FLOPS [list]
set SYNC_SET_FLOPS [list]
set ASYNC_CLEAR_FLOPS [list]
set ASYNC_SET_FLOPS [list]
set STANDARD_FLOPS [list]

foreach_in_collection AF $ALL_FLOPS {
  set SC_PIN [get_pins -quiet -of_objects [get_object_name $AF] -filter "name=~synch_clear"]
  set SS_PIN [get_pins -quiet -of_objects [get_object_name $AF] -filter "name=~synch_preset"]
  set AC_PIN [get_pins -quiet -of_objects [get_object_name $AF] -filter "name=~clear"]
  set AS_PIN [get_pins -quiet -of_objects [get_object_name $AF] -filter "name=~preset"]

  set IS_SC [sizeof_collection [filter_collection [all_connected $SC_PIN] "name!~\*Logic0\*"]]
  set IS_SS [sizeof_collection [filter_collection [all_connected $SS_PIN] "name!~\*Logic0\*"]]
  set IS_AC [sizeof_collection [filter_collection [all_connected $AC_PIN] "name!~\*Logic0\*"]]
  set IS_AS [sizeof_collection [filter_collection [all_connected $AS_PIN] "name!~\*Logic0\*"]]

  if {$IS_SC == 1} {
    lappend SYNC_CLEAR_FLOPS [get_object_name $AF]
  } elseif {$IS_SS == 1} {
    lappend SYNC_SET_FLOPS [get_object_name $AF]
  } elseif {$IS_AC == 1} {
    lappend ASYNC_CLEAR_FLOPS [get_object_name $AF]
  } elseif {$IS_AS == 1} {
    lappend ASYNC_SET_FLOPS [get_object_name $AF]
  } else {
    lappend STANDARD_FLOPS [get_object_name $AF]
  }
}

foreach SCF $SYNC_CLEAR_FLOPS {
  redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.sync_clear_flops}] {echo $SCF}
}
foreach SSF $SYNC_SET_FLOPS {
  redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.sync_set_flops}] {echo $SSF}
}
foreach ACF $ASYNC_CLEAR_FLOPS {
  redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.async_clear_flops}] {echo $ACF}
}
foreach ASF $ASYNC_SET_FLOPS {
  redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.async_set_flops}] {echo $ASF}
}
foreach SF $STANDARD_FLOPS {
  redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.standard_flops}] {echo $SF}
}

################################################
# Generate an output file of all edge-         #
# triggered sequential elements that are       #
# connected to a free-running clock            #
################################################

set ALL_FLOP_CLOCK_PINS [filter_collection [all_registers -edge_triggered -clock_pins] "full_name =~ *clocked_on"]

foreach_in_collection AFCP $ALL_FLOP_CLOCK_PINS {
  set NUM_CELLS_ON_CLOCK_PATH [sizeof_collection [all_fanin -to [get_object_name $AFCP] -flat -startpoints_only -only_cells]]
  if {$NUM_CELLS_ON_CLOCK_PATH == 0} {
    redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.free_running_flops}] {echo [file dirname [get_object_name $AFCP]]}
  }
}

quit
