#############################################################################################
#        Copyright (c) 2008-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

#########################################################
# This is part 2 of 3 in the Genus DFT process - the    #
# optional step of inserting test points on hard macro  #
# memory ports. In addition, auto-fixing of             #
# uncontrollable asynchronous reset and clock signals   #
# occurs here. This must be read in after generic       #
# logic synthesis but prior to technology-specific      #
# synthesis.                                            #
#########################################################

#########################################################
# If selected, insert additional control/observe points #
#########################################################

set TC_PORT test_se
if {$OVERRIDE_PORT != [list]} {
  set TC_PORT $OVERRIDE_PORT
} elseif {$TMODE_PORT != [list]} {
  set TC_PORT $TMODE_PORT
}

if {($MAX_TEST_COVERAGE == 1) && ($USE_MEMORY_MACROS == 1) } {
  check_dft_rules
  if {$USE_PSO == 1} {
    set_attribute ui_respects_preserve false /
  }
  set CLK_MEMORY_PINS_IN [list]
  set CLK_MEMORY_PINS_OUT [list]
  set PRESERVE_MEM_HIER_LIST [list]
  TIP_mem_macro_build_up_exclude_list -mem_list $MEMORY_DESIGN_LIST -excl_list PRESERVE_MEM_HIER_LIST
  foreach PMHL $PRESERVE_MEM_HIER_LIST {
    cd [format "%s%s" $PMHL "/pins_in"]
    set SOURCE_MEM_CLOCK [list]
    set CLK_MEMORY_PINS_IN [list]
    foreach CP $CLK_PORT {
      lappend SOURCE_MEM_CLOCK [basename [lindex [fanin -structural -ignore_broken_timing_paths -timing_model_comb -startpoints [find ./ -pin $CP]] 0]]
      lappend CLK_MEMORY_PINS_IN [dc::add_to_collection $CLK_MEMORY_PINS_IN [dc::remove_from_collection [find ./ -pin *] [find ./ -pin $CP]]]
    }
    cd [format "%s%s" $PMHL "/pins_out"]
    set CLK_MEMORY_PINS_OUT [dc::add_to_collection $CLK_MEMORY_PINS_OUT [find ./ -pin *]]
    cd
  }
  set CLK_OBS_PIN_LIST [list]
  set CLK_CNTRL_PIN_LIST [list]
  
  foreach_in_collection CMPI $CLK_MEMORY_PINS_IN {
    if {[sizeof_collection [fanin -structural -ignore_broken_timing_paths -timing_model_comb -stop_at_seqs [get_object_name $CMPI]]] > 1} {
      lappend CLK_OBS_PIN_LIST [get_object_name $CMPI]
    }
  }
  foreach_in_collection CMPO $CLK_MEMORY_PINS_OUT {
    if {[sizeof_collection [fanout -structural -ignore_broken_timing_paths -timing_model_comb -stop_at_seqs -endpoints [get_object_name $CMPO]]] > 1} {
      lappend CLK_CNTRL_PIN_LIST [get_object_name $CMPO]
    }
  }
  if {[llength $CLK_OBS_PIN_LIST] != 0} {
    insert_dft test_point -location $CLK_OBS_PIN_LIST -max_observe_share 128 -test_clock_pin $CLOCK_IN_PORT -type observe_scan -test_control $TC_PORT -gate_clock_for_observe $TC_PORT
  }
  if {[llength $CLK_CNTRL_PIN_LIST] != 0} {
    foreach CCPL $CLK_CNTRL_PIN_LIST {
      insert_dft test_point -location $CCPL -test_clock_pin $CLOCK_IN_PORT -type control_scan -test_control $TC_PORT -gate_clock_test_control $TC_PORT
    }
  }
}
