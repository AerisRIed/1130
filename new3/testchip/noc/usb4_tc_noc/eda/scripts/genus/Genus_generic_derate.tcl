#############################################################################################
#        Copyright (c) 2013-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

if {$DERATE_SLDC != 1} {
  if {($DERATE_SLDC < 0.1) || ($DERATE_SLDC > 2)} {
    puts [format "%s%s" "Err" "or   : derating factor Target_derate_max_late_data_cell is out of allowed 0.1 - 2.0 range"]
    quit(1)
  } else {
    if {$SOCV_DERATING_USED == 1} {
      set_timing_derate -delay_corner default_emulate_delay_corner -late -data -mean -cell_delay $DERATE_SLDC [find / -design $TOP_DESIGN]
    } else {
      set_timing_derate -delay_corner default_emulate_delay_corner -late -data -cell_delay $DERATE_SLDC [find / -design $TOP_DESIGN]
    }
  }
}
if {$DERATE_SLDN != 1} {
  if {($DERATE_SLDN < 0.1) || ($DERATE_SLDN > 2)} {
    puts [format "%s%s" "Err" "or   : derating factor Target_derate_max_late_data_net is out of allowed 0.1 - 2.0 range"]
    quit(1)
  } else {
    if {$SOCV_DERATING_USED == 1} {
      set_timing_derate -delay_corner default_emulate_delay_corner -late -data -mean -net_delay $DERATE_SLDN [find / -design $TOP_DESIGN]
    } else {
      set_timing_derate -delay_corner default_emulate_delay_corner -late -data -net_delay $DERATE_SLDN [find / -design $TOP_DESIGN]
    }
  }
}
if {$DERATE_SLCC != 1} {
  if {($DERATE_SLCC < 0.1) || ($DERATE_SLCC > 2)} {
    puts [format "%s%s" "Err" "or   : derating factor Target_derate_max_late_clock_cell is out of allowed 0.1 - 2.0 range"]
    quit(1)
  } else {
    if {$SOCV_DERATING_USED == 1} {
      set_timing_derate -delay_corner default_emulate_delay_corner -late -clock -mean -cell_delay $DERATE_SLCC [find / -design $TOP_DESIGN]
    } else {
      set_timing_derate -delay_corner default_emulate_delay_corner -late -clock -cell_delay $DERATE_SLCC [find / -design $TOP_DESIGN]
    }
  }
}
if {$DERATE_SLCN != 1} {
  if {($DERATE_SLCN < 0.1) || ($DERATE_SLCN > 2)} {
    puts [format "%s%s" "Err" "or   : derating factor Target_derate_max_late_clock_net is out of allowed 0.1 - 2.0 range"]
    quit(1)
  } else {
    if {$SOCV_DERATING_USED == 1} {
      set_timing_derate -delay_corner default_emulate_delay_corner -late -clock -mean -net_delay $DERATE_SLCN [find / -design $TOP_DESIGN]
    } else {
      set_timing_derate -delay_corner default_emulate_delay_corner -late -clock -net_delay $DERATE_SLCN [find / -design $TOP_DESIGN]
    }
  }
}
if {$DERATE_SEDC != 1} {
  if {($DERATE_SEDC < 0.1) || ($DERATE_SEDC > 2)} {
    puts [format "%s%s" "Err" "or   : derating factor Target_derate_max_early_data_cell is out of allowed 0.1 - 2.0 range"]
    quit(1)
  } else {
    if {$SOCV_DERATING_USED == 1} {
      set_timing_derate -delay_corner default_emulate_delay_corner -early -data -mean -cell_delay $DERATE_SEDC [find / -design $TOP_DESIGN]
    } else {
      set_timing_derate -delay_corner default_emulate_delay_corner -early -data -cell_delay $DERATE_SEDC [find / -design $TOP_DESIGN]
    }
  }
}
if {$DERATE_SEDN != 1} {
  if {($DERATE_SEDN < 0.1) || ($DERATE_SEDN > 2)} {
    puts [format "%s%s" "Err" "or   : derating factor Target_derate_max_early_data_net is out of allowed 0.1 - 2.0 range"]
    quit(1)
  } else {
    if {$SOCV_DERATING_USED == 1} {
      set_timing_derate -delay_corner default_emulate_delay_corner -early -data -mean -net_delay $DERATE_SEDN [find / -design $TOP_DESIGN]
    } else {
      set_timing_derate -delay_corner default_emulate_delay_corner -early -data -net_delay $DERATE_SEDN [find / -design $TOP_DESIGN]
    }
  }
}
if {$DERATE_SECC != 1} {
  if {($DERATE_SECC < 0.1) || ($DERATE_SECC > 2)} {
    puts [format "%s%s" "Err" "or   : derating factor Target_derate_max_early_clock_cell is out of allowed 0.1 - 2.0 range"]
    quit(1)
  } else {
    if {$SOCV_DERATING_USED == 1} {
      set_timing_derate -delay_corner default_emulate_delay_corner -early -clock -mean -cell_delay $DERATE_SECC [find / -design $TOP_DESIGN]
    } else {
      set_timing_derate -delay_corner default_emulate_delay_corner -early -clock -cell_delay $DERATE_SECC [find / -design $TOP_DESIGN]
    }
  }
}
if {$DERATE_SECN != 1} {
  if {($DERATE_SECN < 0.1) || ($DERATE_SECN > 2)} {
    puts [format "%s%s" "Err" "or   : derating factor Target_derate_max_early_clock_net is out of allowed 0.1 - 2.0 range"]
    quit(1)
  } else {
    if {$SOCV_DERATING_USED == 1} {
      set_timing_derate -delay_corner default_emulate_delay_corner -early -clock -mean -net_delay $DERATE_SECN [find / -design $TOP_DESIGN]
    } else {
      set_timing_derate -delay_corner default_emulate_delay_corner -early -clock -net_delay $DERATE_SECN [find / -design $TOP_DESIGN]
    }
  }
}
