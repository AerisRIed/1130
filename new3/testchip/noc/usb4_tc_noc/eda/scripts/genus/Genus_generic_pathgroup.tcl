#############################################################################################
#        Copyright (c) 2008-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

#########################################################
# Define variables again; necessary for retiming flow	#
#########################################################
set CLOCK_IN_PORT [list]
set CLOCK_OUT_PORT [list]
foreach CP $CLK_PORT {
  lappend CLOCK_IN_PORT [find ./ -port ports_in/$CP]
  lappend CLOCK_OUT_PORT [find ./ -port ports_out/$CP]
}
set DEBUG_CLOCK_PORT [list]
set JT_CLOCK_PORT [find ./ -port ports_in/$JTAG_CLK_PORT]
if {$JT_CLOCK_PORT != [list]} {
  set DEBUG_CLOCK_PORT $JT_CLOCK_PORT
}
set MBIST_CLOCK_PORT [list]
set MBIST_IN_PORT [list]
set MBIST_OUT_PORT [list]
set IN_X_CLK  [dc::remove_from_collection [dc::remove_from_collection [dc::remove_from_collection [all_inputs -design $TOP_DESIGN] $CLOCK_IN_PORT] $DEBUG_CLOCK_PORT] $MBIST_CLOCK_PORT]
set OUT_X_CLK [dc::remove_from_collection [dc::remove_from_collection [all_outputs -design $TOP_DESIGN] $CLOCK_OUT_PORT] $MBIST_CLOCK_PORT]

set PIF_IN_PRESENT 0
set PIF_OUT_PRESENT 0
if {[llength $IN_X_CLK] != 0} {
  set PIF_IN_PRESENT 1
}
if {[llength $OUT_X_CLK] != 0} {
  set PIF_OUT_PRESENT 1
}

#########################################################
# Group I/O paths					#
#########################################################
set i 1
foreach CP $CLK_PORT {
  if {[llength [all::all_seqs -clock CLK$i]] != 0} {
    define_cost_group -name CLK$i -design $TOP_DESIGN
  }
  incr i
}
if {($PIF_IN_PRESENT == 1) && ($PIF_OUT_PRESENT == 1)} {
  define_cost_group -name I2O -design $TOP_DESIGN
  eval path_group -from $IN_X_CLK -to $OUT_X_CLK -group I2O -name I2O $PSO_MODE
  if {$PA_IO != 0} {
    eval path_adjust -from $IN_X_CLK -to $OUT_X_CLK -delay $PA_IO -name pa_io_0 $PSO_MODE
  }
}
if {$CLOCK_IN_PORT != [list]} {
  set i 1
  foreach CP $CLK_PORT {
    if {[llength [all::all_seqs -clock CLK$i]] != 0} {
      eval path_group -from [all::all_seqs -clock CLK$i] -to [all::all_seqs -clock CLK$i] -group CLK$i -name CLK${i}_F2F $PSO_MODE
      if {$PA_CLK != 0} {
        eval path_adjust -from [all::all_seqs -clock CLK$i] -to [all::all_seqs -clock CLK$i] -delay $PA_CLK -name pa_clk_$i $PSO_MODE
      }
      if {$PIF_OUT_PRESENT == 1} {
        define_cost_group -name F2O_$i -design $TOP_DESIGN
        eval path_group -from [all::all_seqs -clock CLK$i] -to $OUT_X_CLK -group F2O_$i -name F2O_$i $PSO_MODE
        if {$PA_IO != 0} {
  	eval path_adjust -from [all::all_seqs -clock CLK$i] -to $OUT_X_CLK -delay $PA_IO -name pa_o_$i $PSO_MODE
        }
      }
      if {$PIF_IN_PRESENT == 1} {
        define_cost_group -name I2F_$i -design $TOP_DESIGN
        eval path_group -from $IN_X_CLK -to [all::all_seqs -edge_triggered -clock CLK$i] -group I2F_$i -name I2F_$i $PSO_MODE
        if {$PA_IO != 0} {
  	eval path_adjust -from $IN_X_CLK -to [all::all_seqs -edge_triggered -clock CLK$i] -delay $PA_IO -name pa_i_$i $PSO_MODE
        }
      }
    }
    incr i
  }
}
if {$DEBUG_CLOCK_PORT != [list]} {
  if {[llength [all::all_seqs -clock $JTAG_CLK_PORT]] != 0} {
    define_cost_group -name JTCK -design $TOP_DESIGN
  }
  if {[llength [all::all_seqs -clock $JTAG_CLK_PORT]] != 0} {
    if {$PIF_OUT_PRESENT == 1} {
      eval path_group -from [all::all_seqs -clock $JTAG_CLK_PORT] -to $OUT_X_CLK -group JTCK -name JTCK_F2O $PSO_MODE
    }
    if {$PIF_IN_PRESENT == 1} {
      eval path_group -from $IN_X_CLK -to [all::all_seqs -edge_triggered -clock $JTAG_CLK_PORT] -group JTCK -name JTCK_I2F $PSO_MODE
    }
    eval path_group -from [all::all_seqs -clock $JTAG_CLK_PORT] -to [all::all_seqs -clock $JTAG_CLK_PORT] -group JTCK -name JTCK_F2F $PSO_MODE
  }
}
if {$MBIST_CLOCK_PORT != [list]} {
  if {[llength [all::all_seqs -clock PMDA_TCK]] != 0} {
    define_cost_group -name PMDA_TCK -design $TOP_DESIGN
  }
  if {[llength $MBIST_IN_PORT] != 0 || [llength $MBIST_OUT_PORT] != 0} {
    define_cost_group -name mbist_io_paths -design $TOP_DESIGN
  }
  if {[llength [all::all_seqs -clock PMDA_TCK]] != 0} {
    if {[llength $MBIST_OUT_PORT] != 0} {
      eval path_group -from [all::all_seqs -clock PMDA_TCK] -to $MBIST_OUT_PORT -group mbist_io_paths -name mbist_io_paths_F2O $PSO_MODE
    }
    if {[llength $MBIST_IN_PORT] != 0} {
      eval path_group -from [dc::remove_from_collection $MBIST_IN_PORT $MBIST_CLOCK_PORT] -to [all::all_seqs -edge_triggered -clock PMDA_TCK] -group mbist_io_paths -name mbist_io_paths_I2F $PSO_MODE
    }
    eval path_group -from [all::all_seqs -clock PMDA_TCK] -to [all::all_seqs -clock PMDA_TCK] -group PMDA_TCK -name mbist_F2F $PSO_MODE
  }
}

if {$USE_MEMORY_MACROS == 1} {
  #########################################################
  # Group mem_io_paths: paths starting or ending at the   #
  #                     local memory hard macros,         #
  #                     including 7-stage flops (if       #
  #                     configured).                      #
  #########################################################

  set MEMORY_PINS [list]
  foreach UM $UNIQUE_MACRO_CELLS {
    foreach MI [filter -regexp libcell $UM [find / -instance *]] {
      cd $MI
      set MEMORY_PINS [dc::add_to_collection $MEMORY_PINS [find ./ -pin *]]
      cd
    }
  }

  cd
  set clocks [find / -clock *]
  set all_clock_tree_pins [list]
  foreach clock $clocks {
    set source [concat [get_attribute inverted_sources $clock] [get_attribute non_inverted_sources $clock]]
    foreach src $source {
      set all_clock_tree_pins [concat $all_clock_tree_pins [fanout -endpoint $src]]
    }
  }

  set MEMORY_PINS [dc::remove_from_collection $MEMORY_PINS $all_clock_tree_pins]
  if {[llength $MEMORY_PINS] != 0} {
    define_cost_group -name mem_io -design $TOP_DESIGN
    eval path_group -through $MEMORY_PINS -group mem_io -name mem_io_paths_macros $PSO_MODE
    if {$PA_MEM_IO != 0} {
      eval path_adjust -through $MEMORY_PINS -delay $PA_MEM_IO -name pa_mem_io_6 $PSO_MODE
    }
  }
} 

#########################################################
# Group power_clkgate paths                             #
#########################################################

set USING_ICG_CELLS 0
set CG_LATCH_CELLS {}
set CG_LATCH_D_PINS_ALL {}
set CG_LATCH_D_PINS_CLK {}
set CG_LATCH_CP_PINS_CLK {}
set CG_LATCH_D_PINS_JTCK {}
set CG_LATCH_CP_PINS_JTCK {}
set CG_LATCH_D_PINS_MBIST {}
set CG_LATCH_CP_PINS_MBIST {}
if {[llength [TIP_find_icg_cells]] != 0} {
  set USING_ICG_CELLS 1
  set CG_LATCH_CELLS [TIP_find_icg_cells]
  set i 1
  foreach CP $CLK_PORT {
    lappend CG_LATCH_D_PINS_CLK [TIP_find_icg_enable_pins -source_clk CLK$i]
    lappend CG_LATCH_CP_PINS_CLK [TIP_find_icg_enable_pins -source_clk CLK$i -clk_pins]
    incr i
  }
  set CG_LATCH_D_PINS_JTCK [TIP_find_icg_enable_pins -source_clk JTCK]
  set CG_LATCH_CP_PINS_JTCK [TIP_find_icg_enable_pins -source_clk JTCK -clk_pins]
  set CG_LATCH_D_PINS_MBIST [TIP_find_icg_enable_pins -source_clk PMDA_TCK]
  set CG_LATCH_CP_PINS_MBIST [TIP_find_icg_enable_pins -source_clk PMDA_TCK -clk_pins]
  if {[llength $CG_LATCH_D_PINS_CLK] != 0} {
    lappend CG_LATCH_D_PINS_ALL $CG_LATCH_D_PINS_CLK
  }
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
if {[llength $CG_LATCH_CELLS] != 0} {
  set_attribute latch_max_borrow 0 $CG_LATCH_CELLS
}

