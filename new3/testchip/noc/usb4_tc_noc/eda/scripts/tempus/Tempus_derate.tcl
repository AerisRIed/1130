################################################################################
#     Copyright (c) 2023-2025 by Cadence Design Systems Inc.  ALL RIGHTS RESERVED.          #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to   #
# third parties in any manner, medium, or form, in whole or in part, without   #
# the prior written consent of Cadence Design Systems Inc.                                  #
################################################################################

set DERATING_USED 0
redirect /dev/null {reset_timing_derate}

if {$WORST_CORNER_DERATE == 2} {
  if { ($LIB_PROCESS_NODE <= 5 ) && ($Innovus_DerateMethod == 3) } {
    if {$DERATE_SLDC != 1} {
      if {($DERATE_SLDC < 0.1) || ($DERATE_SLDC > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_max_late_data_cell is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -late -data -cell_delay $DERATE_SLDC -delay_corner ${setup_views}_delay_corner -mean [get_lib_cells */*]
      }
    }
    if {$DERATE_SLDN != 1} {
      if {($DERATE_SLDN < 0.1) || ($DERATE_SLDN > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_max_late_data_net is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -late -data -net_delay $DERATE_SLDN -delay_corner ${setup_views}_delay_corner
      }
    }
    if {$DERATE_SLCC != 1} {
      if {($DERATE_SLCC < 0.1) || ($DERATE_SLCC > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_max_late_clock_cell is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -late -clock -cell_delay $DERATE_SLCC -delay_corner ${setup_views}_delay_corner -mean [get_lib_cells */*]
        set timing_remove_clock_reconvergence_pessimism true
      }
    }
    if {$DERATE_SLCN != 1} {
      if {($DERATE_SLCN < 0.1) || ($DERATE_SLCN > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_max_late_clock_net is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -late -clock -net_delay $DERATE_SLCN -delay_corner ${setup_views}_delay_corner
        set timing_remove_clock_reconvergence_pessimism true
      }
    }
    if {$DERATE_SEDC != 1} {
      if {($DERATE_SEDC < 0.1) || ($DERATE_SEDC > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_max_early_data_cell is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -early -data -cell_delay $DERATE_SEDC -delay_corner ${setup_views}_delay_corner  -mean [get_lib_cells */*]
      }
    }
    if {$DERATE_SEDN != 1} {
      if {($DERATE_SEDN < 0.1) || ($DERATE_SEDN > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_max_early_data_net is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -early -data -net_delay $DERATE_SEDN -delay_corner ${setup_views}_delay_corner
      }
    }
    if {$DERATE_SECC != 1} {
      if {($DERATE_SECC < 0.1) || ($DERATE_SECC > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_max_early_clock_cell is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -early -clock -cell_delay $DERATE_SECC -delay_corner ${setup_views}_delay_corner  -mean [get_lib_cells */*]
        set timing_remove_clock_reconvergence_pessimism true
      }
    }
    if {$DERATE_SECN != 1} {
      if {($DERATE_SECN < 0.1) || ($DERATE_SECN > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_max_early_clock_net is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -early -clock -net_delay $DERATE_SECN -delay_corner ${setup_views}_delay_corner
        set timing_remove_clock_reconvergence_pessimism true
      }
    }

    if {$DERATE_FLDC != 1} {
      if {($DERATE_FLDC < 0.1) || ($DERATE_FLDC > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_min_late_data_cell is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -late -data -cell_delay $DERATE_FLDC -delay_corner ${hold_views}_delay_corner  -mean [get_lib_cells */*]
      }
    }
    if {$DERATE_FLDN != 1} {
      if {($DERATE_FLDN < 0.1) || ($DERATE_FLDN > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_min_late_data_net is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -late -data -net_delay $DERATE_FLDN -delay_corner ${hold_views}_delay_corner
      }
    }
    if {$DERATE_FLCC != 1} {
      if {($DERATE_FLCC < 0.1) || ($DERATE_FLCC > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_min_late_clock_cell is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -late -clock -cell_delay $DERATE_FLCC -delay_corner ${hold_views}_delay_corner  -mean [get_lib_cells */*]
        set timing_remove_clock_reconvergence_pessimism true
      }
    }
    if {$DERATE_FLCN != 1} {
      if {($DERATE_FLCN < 0.1) || ($DERATE_FLCN > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_min_late_clock_net is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -late -clock -net_delay $DERATE_FLCN -delay_corner ${hold_views}_delay_corner
        set timing_remove_clock_reconvergence_pessimism true
      }
    }
    if {$DERATE_FEDC != 1} {
      if {($DERATE_FEDC < 0.1) || ($DERATE_FEDC > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_min_early_data_cell is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -early -data -cell_delay $DERATE_FEDC -delay_corner ${hold_views}_delay_corner  -mean [get_lib_cells */*]
      }
    }
    if {$DERATE_FEDN != 1} {
      if {($DERATE_FEDN < 0.1) || ($DERATE_FEDN > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_min_early_data_net is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -early -data -net_delay $DERATE_FEDN -delay_corner ${hold_views}_delay_corner
      }
    }
    if {$DERATE_FECC != 1} {
      if {($DERATE_FECC < 0.1) || ($DERATE_FECC > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_min_early_clock_cell is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -early -clock -cell_delay $DERATE_FECC -delay_corner ${hold_views}_delay_corner  -mean [get_lib_cells */*]
        set timing_remove_clock_reconvergence_pessimism true
      }
    }
    if {$DERATE_FECN != 1} {
      if {($DERATE_FECN < 0.1) || ($DERATE_FECN > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_min_early_clock_net is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -early -clock -net_delay $DERATE_FECN -delay_corner ${hold_views}_delay_corner
        set timing_remove_clock_reconvergence_pessimism true
      }
    }
  } else {
    if {$DERATE_SLDC != 1} {
      if {($DERATE_SLDC < 0.1) || ($DERATE_SLDC > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_max_late_data_cell is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -late -data -cell_delay $DERATE_SLDC -delay_corner ${setup_views}_delay_corner
      }
    }
    if {$DERATE_SLDN != 1} {
      if {($DERATE_SLDN < 0.1) || ($DERATE_SLDN > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_max_late_data_net is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -late -data -net_delay $DERATE_SLDN -delay_corner ${setup_views}_delay_corner
      }
    }
    if {$DERATE_SLCC != 1} {
      if {($DERATE_SLCC < 0.1) || ($DERATE_SLCC > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_max_late_clock_cell is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -late -clock -cell_delay $DERATE_SLCC -delay_corner ${setup_views}_delay_corner
        set timing_remove_clock_reconvergence_pessimism true
      }
    }
    if {$DERATE_SLCN != 1} {
      if {($DERATE_SLCN < 0.1) || ($DERATE_SLCN > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_max_late_clock_net is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -late -clock -net_delay $DERATE_SLCN -delay_corner ${setup_views}_delay_corner
        set timing_remove_clock_reconvergence_pessimism true
      }
    }
    if {$DERATE_SEDC != 1} {
      if {($DERATE_SEDC < 0.1) || ($DERATE_SEDC > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_max_early_data_cell is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -early -data -cell_delay $DERATE_SEDC -delay_corner ${setup_views}_delay_corner
      }
    }
    if {$DERATE_SEDN != 1} {
      if {($DERATE_SEDN < 0.1) || ($DERATE_SEDN > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_max_early_data_net is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -early -data -net_delay $DERATE_SEDN -delay_corner ${setup_views}_delay_corner
      }
    }
    if {$DERATE_SECC != 1} {
      if {($DERATE_SECC < 0.1) || ($DERATE_SECC > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_max_early_clock_cell is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -early -clock -cell_delay $DERATE_SECC -delay_corner ${setup_views}_delay_corner
        set timing_remove_clock_reconvergence_pessimism true
      }
    }
    if {$DERATE_SECN != 1} {
      if {($DERATE_SECN < 0.1) || ($DERATE_SECN > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_max_early_clock_net is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -early -clock -net_delay $DERATE_SECN -delay_corner ${setup_views}_delay_corner
        set timing_remove_clock_reconvergence_pessimism true
      }
    }

    if {$DERATE_FLDC != 1} {
      if {($DERATE_FLDC < 0.1) || ($DERATE_FLDC > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_min_late_data_cell is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -late -data -cell_delay $DERATE_FLDC -delay_corner ${hold_views}_delay_corner
      }
    }
    if {$DERATE_FLDN != 1} {
      if {($DERATE_FLDN < 0.1) || ($DERATE_FLDN > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_min_late_data_net is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -late -data -net_delay $DERATE_FLDN -delay_corner ${hold_views}_delay_corner
      }
    }
    if {$DERATE_FLCC != 1} {
      if {($DERATE_FLCC < 0.1) || ($DERATE_FLCC > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_min_late_clock_cell is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -late -clock -cell_delay $DERATE_FLCC -delay_corner ${hold_views}_delay_corner
        set timing_remove_clock_reconvergence_pessimism true
      }
    }
    if {$DERATE_FLCN != 1} {
      if {($DERATE_FLCN < 0.1) || ($DERATE_FLCN > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_min_late_clock_net is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -late -clock -net_delay $DERATE_FLCN -delay_corner ${hold_views}_delay_corner
        set timing_remove_clock_reconvergence_pessimism true
      }
    }
    if {$DERATE_FEDC != 1} {
      if {($DERATE_FEDC < 0.1) || ($DERATE_FEDC > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_min_early_data_cell is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -early -data -cell_delay $DERATE_FEDC -delay_corner ${hold_views}_delay_corner
      }
    }
    if {$DERATE_FEDN != 1} {
      if {($DERATE_FEDN < 0.1) || ($DERATE_FEDN > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_min_early_data_net is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -early -data -net_delay $DERATE_FEDN -delay_corner ${hold_views}_delay_corner
      }
    }
    if {$DERATE_FECC != 1} {
      if {($DERATE_FECC < 0.1) || ($DERATE_FECC > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_min_early_clock_cell is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -early -clock -cell_delay $DERATE_FECC -delay_corner ${hold_views}_delay_corner
        set timing_remove_clock_reconvergence_pessimism true
      }
    }
    if {$DERATE_FECN != 1} {
      if {($DERATE_FECN < 0.1) || ($DERATE_FECN > 2)} {
        echo [format "%s%s" "Err" "or: derating factor Target_derate_min_early_clock_net is out of allowed 0.1 - 2.0 range"]
        quit
      } else {
        set DERATING_USED 1
        set_timing_derate -early -clock -net_delay $DERATE_FECN -delay_corner ${hold_views}_delay_corner
        set timing_remove_clock_reconvergence_pessimism true
      }
    }
  }


}

if {$WORST_CORNER_DERATE == 1} {
  if {$DERATE_SLDC != 1} {
    if {($DERATE_SLDC < 0.1) || ($DERATE_SLDC > 2)} {
      echo [format "%s%s" "Err" "or: derating factor Target_derate_max_late_data_cell is out of allowed 0.1 - 2.0 range"]
      quit
    } else {
      set DERATING_USED 1
      set_timing_derate -late -data -cell_delay $DERATE_SLDC
    }
  }
  if {$DERATE_SLDN != 1} {
    if {($DERATE_SLDN < 0.1) || ($DERATE_SLDN > 2)} {
      echo [format "%s%s" "Err" "or: derating factor Target_derate_max_late_data_net is out of allowed 0.1 - 2.0 range"]
      quit
    } else {
      set DERATING_USED 1
      set_timing_derate -late -data -net_delay $DERATE_SLDN
    }
  }
  if {$DERATE_SLCC != 1} {
    if {($DERATE_SLCC < 0.1) || ($DERATE_SLCC > 2)} {
      echo [format "%s%s" "Err" "or: derating factor Target_derate_max_late_clock_cell is out of allowed 0.1 - 2.0 range"]
      quit
    } else {
      set DERATING_USED 1
      set_timing_derate -late -clock -cell_delay $DERATE_SLCC
      set timing_remove_clock_reconvergence_pessimism true
    }
  }
  if {$DERATE_SLCN != 1} {
    if {($DERATE_SLCN < 0.1) || ($DERATE_SLCN > 2)} {
      echo [format "%s%s" "Err" "or: derating factor Target_derate_max_late_clock_net is out of allowed 0.1 - 2.0 range"]
      quit
    } else {
      set DERATING_USED 1
      set_timing_derate -late -clock -net_delay $DERATE_SLCN
      set timing_remove_clock_reconvergence_pessimism true
    }
  }
  if {$DERATE_SEDC != 1} {
    if {($DERATE_SEDC < 0.1) || ($DERATE_SEDC > 2)} {
      echo [format "%s%s" "Err" "or: derating factor Target_derate_max_early_data_cell is out of allowed 0.1 - 2.0 range"]
      quit
    } else {
      set DERATING_USED 1
      set_timing_derate -early -data -cell_delay $DERATE_SEDC
    }
  }
  if {$DERATE_SEDN != 1} {
    if {($DERATE_SEDN < 0.1) || ($DERATE_SEDN > 2)} {
      echo [format "%s%s" "Err" "or: derating factor Target_derate_max_early_data_net is out of allowed 0.1 - 2.0 range"]
      quit
    } else {
      set DERATING_USED 1
      set_timing_derate -early -data -net_delay $DERATE_SEDN
    }
  }
  if {$DERATE_SECC != 1} {
    if {($DERATE_SECC < 0.1) || ($DERATE_SECC > 2)} {
      echo [format "%s%s" "Err" "or: derating factor Target_derate_max_early_clock_cell is out of allowed 0.1 - 2.0 range"]
      quit
    } else {
      set DERATING_USED 1
      set_timing_derate -early -clock -cell_delay $DERATE_SECC
      set timing_remove_clock_reconvergence_pessimism true
    }
  }
  if {$DERATE_SECN != 1} {
    if {($DERATE_SECN < 0.1) || ($DERATE_SECN > 2)} {
      echo [format "%s%s" "Err" "or: derating factor Target_derate_max_early_clock_net is out of allowed 0.1 - 2.0 range"]
      quit
    } else {
      set DERATING_USED 1
      set_timing_derate -early -clock -net_delay $DERATE_SECN
      set timing_remove_clock_reconvergence_pessimism true
    }
  }
} 

if {$WORST_CORNER_DERATE == 0} {
  if {$DERATE_FLDC != 1} {
    if {($DERATE_FLDC < 0.1) || ($DERATE_FLDC > 2)} {
      echo [format "%s%s" "Err" "or: derating factor Target_derate_min_late_data_cell is out of allowed 0.1 - 2.0 range"]
      quit
    } else {
      set DERATING_USED 1
      set_timing_derate -late -data -cell_delay $DERATE_FLDC
    }
  }
  if {$DERATE_FLDN != 1} {
    if {($DERATE_FLDN < 0.1) || ($DERATE_FLDN > 2)} {
      echo [format "%s%s" "Err" "or: derating factor Target_derate_min_late_data_net is out of allowed 0.1 - 2.0 range"]
      quit
    } else {
      set DERATING_USED 1
      set_timing_derate -late -data -net_delay $DERATE_FLDN
    }
  }
  if {$DERATE_FLCC != 1} {
    if {($DERATE_FLCC < 0.1) || ($DERATE_FLCC > 2)} {
      echo [format "%s%s" "Err" "or: derating factor Target_derate_min_late_clock_cell is out of allowed 0.1 - 2.0 range"]
      quit
    } else {
      set DERATING_USED 1
      set_timing_derate -late -clock -cell_delay $DERATE_FLCC
      set timing_remove_clock_reconvergence_pessimism true
    }
  }
  if {$DERATE_FLCN != 1} {
    if {($DERATE_FLCN < 0.1) || ($DERATE_FLCN > 2)} {
      echo [format "%s%s" "Err" "or: derating factor Target_derate_min_late_clock_net is out of allowed 0.1 - 2.0 range"]
      quit
    } else {
      set DERATING_USED 1
      set_timing_derate -late -clock -net_delay $DERATE_FLCN
      set timing_remove_clock_reconvergence_pessimism true
    }
  }
  if {$DERATE_FEDC != 1} {
    if {($DERATE_FEDC < 0.1) || ($DERATE_FEDC > 2)} {
      echo [format "%s%s" "Err" "or: derating factor Target_derate_min_early_data_cell is out of allowed 0.1 - 2.0 range"]
      quit
    } else {
      set DERATING_USED 1
      set_timing_derate -early -data -cell_delay $DERATE_FEDC
    }
  }
  if {$DERATE_FEDN != 1} {
    if {($DERATE_FEDN < 0.1) || ($DERATE_FEDN > 2)} {
      echo [format "%s%s" "Err" "or: derating factor Target_derate_min_early_data_net is out of allowed 0.1 - 2.0 range"]
      quit
    } else {
      set DERATING_USED 1
      set_timing_derate -early -data -net_delay $DERATE_FEDN
    }
  }
  if {$DERATE_FECC != 1} {
    if {($DERATE_FECC < 0.1) || ($DERATE_FECC > 2)} {
      echo [format "%s%s" "Err" "or: derating factor Target_derate_min_early_clock_cell is out of allowed 0.1 - 2.0 range"]
      quit
    } else {
      set DERATING_USED 1
      set_timing_derate -early -clock -cell_delay $DERATE_FECC
      set timing_remove_clock_reconvergence_pessimism true
    }
  }
  if {$DERATE_FECN != 1} {
    if {($DERATE_FECN < 0.1) || ($DERATE_FECN > 2)} {
      echo [format "%s%s" "Err" "or: derating factor Target_derate_min_early_clock_net is out of allowed 0.1 - 2.0 range"]
      quit
    } else {
      set DERATING_USED 1
      set_timing_derate -early -clock -net_delay $DERATE_FECN
      set timing_remove_clock_reconvergence_pessimism true
    }
  }
}
