#############################################################################################
#        Copyright (c) 2008-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

set_attribute hdl_language sv
set_attribute hdl_unconnected_value 0 /

TIP_hard_macro_checker
read_hdl custom_macro.sv
read_hdl -sv -f $FILE_LIST

elaborate $TOP_DESIGN

TIP_lec_debug_checkpoint -netlist post_elab.v -db post_elab.db -logfile rtl_to_post_elab.log -golden rtl -revised post_elab.v -dofile rtl_to_post_elab.do

set SAFETY_PRESERVE_LIST {}
if {([info exists env(SAFETY_PRESERVE_LIST)] != 0) && ([llength $SAFETY_PRESERVE_LIST] == 0)} {
  set SAFETY_PRESERVE_LIST $env(SAFETY_PRESERVE_LIST)
}
foreach spl $SAFETY_PRESERVE_LIST {
  foreach spl_subd [find / -regexp "${spl}*?$" -subdesign [format "%s%s%s" "*" $spl "*"]] {
    set_attribute merge_combinational_hier_instance false [find / -instance $spl*]
  }
}

set UNIQUE_MACRO_CELLS [list]

if {$USE_MEMORY_MACROS == 1} {
  set MEMORY_DESIGN_LIST [list]
  set MACRO_INSTANCES [get_object_name [filter is_memory true [find / -inst *]]]
  foreach MM $MACRO_INSTANCES {
    lappend MEMORY_DESIGN_LIST [basename $MM]
    cd $MM
    set_attribute preserve false [get_attribute libcell $MM]
    set_attribute avoid false [get_attribute libcell $MM]
    lappend UNIQUE_MACRO_CELLS [basename [get_attribute libcell $MM]]
    cd
  }
  set UNIQUE_MACRO_CELLS [lsort -unique $UNIQUE_MACRO_CELLS]

  if {($USE_MEMORY_MACROS == 1) && ([llength $UNIQUE_MACRO_CELLS] == 0)} {
    puts [format "%s%s" "Err" "or   : No memories present in the design. At least one memory hard macro needs to be instantiated"]
    quit(1)
  }

  if {[llength $UNIQUE_MACRO_CELLS] != 0} {
    redirect [format "%s%s" $FILE_NAME_PREFIX {_syn.memory_macro_list}] {puts [format "%s%s%s" "set UNIQUE_MACRO_CELLS {" $UNIQUE_MACRO_CELLS "}"]}
  } else {
    redirect [format "%s%s" $FILE_NAME_PREFIX {_syn.memory_macro_list}] {puts "set UNIQUE_MACRO_CELLS \[list\]"}
  }
}

TIP_lint_timing_and_combo_loops -file_prefix $TOP_DESIGN

if {($LOW_POWER_FLOW == 1) && (($LOW_POWER_GOAL == 3) || ($LOW_POWER_GOAL == 5))} {
  TIP_define_lp_icg_setup -des_name $TOP_DESIGN
}

TIP_output_db -db [format "%s%s" $FILE_NAME_PREFIX {_read.db}]
