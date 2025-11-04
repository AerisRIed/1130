#############################################################################################
#        Copyright (c) 2008-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

if {[llength $CONS_FILE] != 0} {
  source $CONS_FILE
} elseif {[llength $SDC_FILE] != 0} {
  global MAX_CAPACITANCE
  global TOP_DESIGN
  global BOUNDARY_LOAD_SCALE_FACTOR
  global BOUNDARY_LOAD
  global CLK_PORT
  global JTAG_CLK_PORT

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
  if {($GENUS_MBIST_INSERTION == 1) || ($GENUS_MBIST_INSERTION == 3)} {
    set MBIST_CLOCK_PORT [find ./ -port ports_in/PMDA_TCK]
  }
  set IN_X_CLK  [dc::remove_from_collection [dc::remove_from_collection [dc::remove_from_collection [all_inputs -design $TOP_DESIGN] $CLOCK_IN_PORT] $DEBUG_CLOCK_PORT] $MBIST_CLOCK_PORT]
  set OUT_X_CLK [dc::remove_from_collection [dc::remove_from_collection [all_outputs -design $TOP_DESIGN] $CLOCK_OUT_PORT] $MBIST_CLOCK_PORT]

  set BOUNDARY_LOAD_VALUE [get_attribute load [format "%s%s%s" [find [find / -library_domain timing] -libcell [basename [dirname $BOUNDARY_LOAD]]] "/" [basename $BOUNDARY_LOAD]]]
  if {[llength $BOUNDARY_LOAD] > 0} {
    set_attribute external_pin_cap [expr $BOUNDARY_LOAD_SCALE_FACTOR * $BOUNDARY_LOAD_VALUE] $OUT_X_CLK
    if {$MAX_CAPACITANCE > 0} {
      set_attribute max_capacitance $MAX_CAPACITANCE $TOP_DESIGN
    } else {
      set_attribute max_capacitance [expr $MAX_CAP_SCALE_FACTOR * $BOUNDARY_LOAD_VALUE] $IN_X_CLK
    }
  }

  set fp_1 [open "$SDC_FILE" r]
  set fp_1_data [read $fp_1]
  close $fp_1
  set data_1 [split $fp_1_data "\n"]
  set new_sdc [format "%s%s" $TOP_DESIGN "_cons.sdc"]
  set fp_2 [open "$new_sdc" w]
  foreach line $data_1 {
    if {$line eq "# Clock period in \[ns\]"} {
      puts $fp_2 "# Clock frequency in \[MHz\]"
      set i 1
      foreach CF $CLK_FREQ {
        puts $fp_2 "set CLK${i}_FREQ $CF"
        incr i
      }
      puts $fp_2 "\n"
    } elseif {$line eq "# Skew within a single clock tree"} {
      puts $fp_2 "# Set drive cell for input pins"
      puts $fp_2 "set DRIVE_CELL $DRIVE_CELL"
      puts $fp_2 "\n"
    }
    puts $fp_2 $line
  }
  close $fp_2
  read_sdc -stop_on_errors -echo -verbose $new_sdc
  exec rm $new_sdc
}

if {($OCV_DERATING_USED == 1) || ($SBOCV_DERATING_USED == 1) || ($SOCV_DERATING_USED == 1)} {
  if {$SBOCV_DERATING_USED == 1} {
    phys_enable_ocv -native_aocv -design [find / -design $TOP_DESIGN]
  } elseif {$SOCV_DERATING_USED == 1} {
    phys_enable_ocv -native_socv -design [find / -design $TOP_DESIGN]
  }
  source -verbose Genus_generic_derate.tcl
}
