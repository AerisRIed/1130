#############################################################################################
#        Copyright (c) 2010-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

::legacy::set_attribute common_ui false /
set_attribute legacy_collection true /

################################################
# Define variables and search paths            #
################################################

set_attribute script_search_path {. .. ../scripts/genus}
source -verbose Genus_generic_define.tcl
source -verbose Genus_generic_utils.tcl
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
  puts [format "%s%s" "Err" "or   : FILE_LIST is not set in env_design.sh. Specify complete path to RTL File list"]
  quit(1)
}
if {![file isdirectory $RTL_PATH]} {
  puts [format "%s%s" "Err" "or   : $RTL_PATH doesnt't exist. Please specify correct RTL directory."]
  quit(1)
}
if {![file exists $FILE_LIST]} {
  puts [format "%s%s" "Err" "or   : RTL File List $FILE_LIST doesnt't exist. Please specify correct one."]
  quit(1)
}
set_attribute init_hdl_search_path [list $RTL_PATH $RTL_PATH/memories/ $RTL_PATH/noc/ $RTL_PATH/primitives/ . ../ ../../]

set FILE_NAME_PREFIX $TOP_DESIGN
if {$USE_MEMORY_MACROS == 1} {
  set_attribute hdl_error_on_blackbox false /
  set_attribute init_blackbox_for_undefined true /
  set_attribute write_vlog_empty_module_for_logic_abstract true /
} else {
  set_attribute hdl_error_on_blackbox true /
}
set LEC_NEQ_DEBUG 0
source -verbose load_etc.tcl
source -verbose Genus_generic_libsetup.tcl

set_attribute iopt_stats 1 /
set_attribute map_fancy_names 1 /
set_attribute source_verbose true /
set_attribute source_verbose_info false /
set_attribute information_level 9 /
set_attribute heartbeat 1200 /
set_attribute heartbeat_print_date 1 /
set_attribute hdl_max_loop_limit 1024 /
set_attribute hdl_use_cw_first true /
set_attribute hdl_zero_replicate_is_null true /
set_attribute hdl_report_case_info true /
set_attribute hdl_track_filename_row_col true /
set_attribute hdl_generate_index_style %s_%d /
set_attribute hdl_generate_separator _ /
# set_attribute hdl_flatten_complex_port true /
set_attribute gen_module_prefix CDN_DP_ /
set_attribute optimize_constant_0_flops true /
set_attribute optimize_constant_1_flops true /
set_attribute delete_unloaded_seqs true /
set_attribute optimize_constant_latches true /
set_attribute hdl_unconnected_value 0 /
set_attribute write_vlog_line_wrap_limit 200 /
set_attribute auto_ungroup both /

TIP_global_message_control
TIP_superthreading_setup

set RUN_RESET_CHECK 1
if {[info exists env(RUN_RESET_CHECK)] != 0} {
  set RUN_RESET_CHECK $env(RUN_RESET_CHECK)
}

################################################
# Read in the design                           #
################################################

set_attribute hdl_language sv
read_hdl -sv -f $FILE_LIST

cd
TIP_blackbox_local_memories
elaborate $TOP_DESIGN
edit_netlist uniquify [find / -design $TOP_DESIGN]

TIP_lint_timing_and_combo_loops -file_prefix $TOP_DESIGN

################################################
# Check for RTL issues in the design           #
################################################

redirect [format "%s%s" $FILE_NAME_PREFIX {_syn.check_design}] {check_design}

################################################
# Generate list of all ports in the design     #
################################################

foreach top_port [find / -port *] {
  redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.rtl_port_list}] {puts [basename $top_port]}
}

################################################
# Generate output files of all flops and all   #
# latches in the design                        #
################################################

redirect /dev/null {set ALL_FLOPS [all des seqs -edge_triggered]}
redirect /dev/null {set ALL_LATCHES [all des seqs -level_sensitive]}
foreach AF $ALL_FLOPS {
  redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.rtl_flop_list}] {puts $AF}
}
foreach AL $ALL_LATCHES {
  redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.rtl_latch_list}] {puts $AL}
}

if {$RUN_RESET_CHECK == 1} {
  ################################################
  # In a sync reset config, make sure that each  #
  # clock gate has the output of a reset         #
  # synchronizer connected to its enable pin     #
  ################################################

  TIP_check_reset_sync_to_clock_gate_enable
}

if {$RUN_RESET_CHECK == 1} {
  ################################################
  # In an async reset config, make sure that for #
  # each reset synchronizer, the functional      #
  # reset output connects only to flop async     #
  # set/reset pins, and the logical reset output #
  # connects only to flop data/enable pins       #
  ################################################

  TIP_check_async_reset_synchronizer_fanout
}

################################################
# Generate output files of all sync clear,     #
# sync set, async clear, async set, and        #
# standard flops in the design                 #
################################################

redirect [format "%s%s" $FILE_NAME_PREFIX {_syn.report_sequential}] {report sequential -hier [find / -design $TOP_DESIGN]}
redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.report_sequential}] {puts [list]}

################################################
# Generate an output file of all edge-         #
# triggered sequential elements that are       #
# connected to a free-running clock            #
################################################

set ALL_FLOP_CLOCK_PINS [all des seqs -edge_triggered -clock_pins]
foreach AFCP $ALL_FLOP_CLOCK_PINS {
  if {[llength [fanin -structural -vname -startpoints $AFCP]] <= 1} {
    redirect -append [format "%s%s" $FILE_NAME_PREFIX {_syn.free_running_flops}] {puts [dirname -times 2 $AFCP]}
  }
}

if {$INSERT_SCAN == 1} {
  source Genus_generic_test_setup.tcl
}

quit
