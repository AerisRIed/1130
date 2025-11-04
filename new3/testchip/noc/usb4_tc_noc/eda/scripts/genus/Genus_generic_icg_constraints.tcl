#############################################################################################
#        Copyright (c) 2008-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

#########################################################
# Group and constrain power_clkgate paths               #
#########################################################

set USING_ICG_CELLS 0
set CG_LATCH_CELLS {}
set CG_LATCH_D_PINS_ALL {}
unset CG_LATCH_D_PINS_CLK
unset CG_LATCH_CP_PINS_CLK
set i 1
foreach CP $CLK_PORT {
  set CG_LATCH_D_PINS_CLK($i) ""
  set CG_LATCH_CP_PINS_CLK($i) ""
  incr i
}
set CG_LATCH_D_PINS_JTCK {}
set CG_LATCH_CP_PINS_JTCK {}
set CG_LATCH_D_PINS_MBIST {}
set CG_LATCH_CP_PINS_MBIST {}
if {[llength [TIP_find_icg_cells]] != 0} {
  set USING_ICG_CELLS 1
  set CG_LATCH_CELLS [TIP_find_icg_cells]
  set i 1
  foreach CP $CLK_PORT {
    set CG_LATCH_D_PINS_CLK($i) [TIP_find_icg_enable_pins -source_clk CLK$i]
    set CG_LATCH_CP_PINS_CLK($i) [TIP_find_icg_enable_pins -source_clk CLK$i -clk_pins]
    if {$CG_LATCH_D_PINS_CLK($i) != ""} {
      lappend CG_LATCH_D_PINS_ALL $CG_LATCH_D_PINS_CLK($i)
    }
    incr i
  }
  set CG_LATCH_D_PINS_JTCK [TIP_find_icg_enable_pins -source_clk $JTAG_CLK_PORT]
  set CG_LATCH_CP_PINS_JTCK [TIP_find_icg_enable_pins -source_clk $JTAG_CLK_PORT -clk_pins]
  set CG_LATCH_D_PINS_MBIST [TIP_find_icg_enable_pins -source_clk PMDA_TCK]
  set CG_LATCH_CP_PINS_MBIST [TIP_find_icg_enable_pins -source_clk PMDA_TCK -clk_pins]
  if {[llength $CG_LATCH_D_PINS_JTCK] != 0} {
    lappend CG_LATCH_D_PINS_ALL $CG_LATCH_D_PINS_JTCK
  }
  if {[llength $CG_LATCH_D_PINS_MBIST] != 0} {
    lappend CG_LATCH_D_PINS_ALL $CG_LATCH_D_PINS_MBIST
  }
}
if {([llength $CG_LATCH_D_PINS_ALL] == 0) && ([llength [all::all_seqs -level_sensitive -data_pins]] != 0)} {
  lappend CG_LATCH_D_PINS_ALL [all::all_seqs -level_sensitive -data_pins]
}
if {[llength $CG_LATCH_D_PINS_ALL] != 0} {
  define_cost_group -name power_clkgate -design $TOP_DESIGN
  eval path_group -to $CG_LATCH_D_PINS_ALL -group power_clkgate -name power_clkgate_enable $PSO_MODE
  if {$PA_ICG != 0} {
    eval path_adjust -to $CG_LATCH_D_PINS_ALL -delay $PA_ICG -name pa_icg_1 $PSO_MODE
  }
}
if {([llength $CG_LATCH_CELLS] == 0) && ([llength  [all::all_seqs -level_sensitive]]  != 0)} {
  lappend CG_LATCH_CELLS  [all::all_seqs -level_sensitive] 
}
if {[llength $CG_LATCH_CELLS] != 0} {
  set_attribute latch_max_borrow 0 $CG_LATCH_CELLS
}
set i 1
foreach CP $CLK_PORT {
  if {($CG_LATCH_D_PINS_CLK($i) == "") && ([llength [all::all_seqs -level_sensitive -data_pins -clock CLK$i]] != 0)} {
    set CG_LATCH_D_PINS_CLK($i)  [all::all_seqs -level_sensitive -data_pins -clock CLK$i]
    set CG_LATCH_CP_PINS_CLK($i)  [all::all_seqs -level_sensitive -clock_pins -clock CLK$i]
  }
  if {$CG_LATCH_D_PINS_CLK($i) != ""} {
    set exception_counter 0
    set CG_LATCH_CP_PINS_CLK_list [split $CG_LATCH_CP_PINS_CLK($i) " "]
    set CG_LATCH_D_PINS_CLK_list [split $CG_LATCH_D_PINS_CLK($i) " "]
    foreach ckpin $CG_LATCH_CP_PINS_CLK_list dpin $CG_LATCH_D_PINS_CLK_list {
      set clock_gate_depth [llength [fanin -structural -vname $ckpin]]
      if {(($USING_ICG_CELLS == 1) && ($clock_gate_depth == 1)) || (($USING_ICG_CELLS == 0) && ($clock_gate_depth == 3))} {
        set DELAY_VALUE [expr ($FIRST_LEVEL_CONS * $CLOCK_PERIOD) / $TIMESCALE]
      } elseif {(($USING_ICG_CELLS == 1) && ($clock_gate_depth == 3)) || (($USING_ICG_CELLS == 0) && ($clock_gate_depth == 6))} {
        set DELAY_VALUE [expr ($SECOND_LEVEL_CONS * $CLOCK_PERIOD) / $TIMESCALE]
      } else {
        set DELAY_VALUE [expr ($THIRD_LEVEL_CONS * $CLOCK_PERIOD) / $TIMESCALE]
      }
      dc::set_max_delay -to $dpin -comment "max_delay_rm_power_clkgate_clk" -exception_name max_delay_rm_power_clkgate_clk_$exception_counter $DELAY_VALUE
      incr exception_counter
    }
  }
  incr i
}
if {$DEBUG_CLOCK_PORT != [list]} {
  if {([llength $CG_LATCH_D_PINS_JTCK] == 0) && ([llength [all::all_seqs -level_sensitive -data_pins -clock $JTAG_CLK_PORT]] != 0)} {
    set CG_LATCH_D_PINS_JTCK [all::all_seqs -level_sensitive -data_pins -clock $JTAG_CLK_PORT] 
    set CG_LATCH_CP_PINS_JTCK  [all::all_seqs -level_sensitive -clock_pins -clock $JTAG_CLK_PORT] 
  }
  if {[llength $CG_LATCH_D_PINS_JTCK] != 0} {
    set exception_counter 0
    foreach ckpin $CG_LATCH_CP_PINS_JTCK dpin $CG_LATCH_D_PINS_JTCK {
      set clock_gate_depth [llength [fanin -structural -vname $ckpin]]
      if {(($USING_ICG_CELLS == 1) && ($clock_gate_depth == 1)) || (($USING_ICG_CELLS == 0) && ($clock_gate_depth == 3))} {
	set DELAY_VALUE [expr (4.0 * ($FIRST_LEVEL_CONS * $CLOCK_PERIOD)) / $TIMESCALE]
      } elseif {(($USING_ICG_CELLS == 1) && ($clock_gate_depth == 3)) || (($USING_ICG_CELLS == 0) && ($clock_gate_depth == 6))} {
	set DELAY_VALUE [expr (4.0 * ($SECOND_LEVEL_CONS * $CLOCK_PERIOD)) / $TIMESCALE]
      } else {
	set DELAY_VALUE [expr (4.0 * ($THIRD_LEVEL_CONS * $CLOCK_PERIOD)) / $TIMESCALE]
      }
      dc::set_max_delay -to $dpin -comment "max_delay_rm_power_clkgate_jtck" -exception_name max_delay_rm_power_clkgate_jtck_$exception_counter $DELAY_VALUE
      incr exception_counter
    }
  }
}
if {$MBIST_CLOCK_PORT != [list]} {
  if {([llength $CG_LATCH_D_PINS_MBIST] == 0) && ([llength [all::all_seqs -level_sensitive -data_pins -clock PMDA_TCK]]  != 0)} {
    set CG_LATCH_D_PINS_MBIST [all::all_seqs -level_sensitive -data_pins -clock PMDA_TCK] 
    set CG_LATCH_CP_PINS_MBIST [all::all_seqs -level_sensitive -clock_pins -clock PMDA_TCK] 
  }
  if {[llength $CG_LATCH_D_PINS_MBIST] != 0} {
    set exception_counter 0
    foreach ckpin $CG_LATCH_CP_PINS_MBIST dpin $CG_LATCH_D_PINS_MBIST {
      set clock_gate_depth [llength [fanin -structural -vname $ckpin]]
      if {(($USING_ICG_CELLS == 1) && ($clock_gate_depth == 1)) || (($USING_ICG_CELLS == 0) && ($clock_gate_depth == 3))} {
	set DELAY_VALUE [expr ($FIRST_LEVEL_CONS * $CLOCK_PERIOD) / $TIMESCALE]
      } elseif {(($USING_ICG_CELLS == 1) && ($clock_gate_depth == 3)) || (($USING_ICG_CELLS == 0) && ($clock_gate_depth == 6))} {
	set DELAY_VALUE [expr ($SECOND_LEVEL_CONS * $CLOCK_PERIOD) / $TIMESCALE]
      } else {
	set DELAY_VALUE [expr ($THIRD_LEVEL_CONS * $CLOCK_PERIOD) / $TIMESCALE]
      }
      dc::set_max_delay -to $dpin -comment "max_delay_rm_power_clkgate_mbist" -exception_name max_delay_rm_power_clkgate_mbist_$exception_counter $DELAY_VALUE
      incr exception_counter
    }
  }
}
