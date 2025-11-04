#############################################################################################
#        Copyright (c) 2015-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

proc TIP_check_derate_method {} {
  source Tempus_define.tcl
  set SIGMA_COUNT 0
  if {$Innovus_DerateMethod == 0} {
    puts [format "%s%s" "Warn" "ing : No Derating is used for timing analysis"]
    if {($DERATE_SLDC != 1) || ($DERATE_SLDN != 1) || ($DERATE_SLCC != 1) || ($DERATE_SLCN != 1) || ($DERATE_SEDC != 1) || ($DERATE_SEDN != 1) || ($DERATE_SECC != 1) || ($DERATE_SECN != 1) || ($DERATE_FLDC != 1) || ($DERATE_FLDN != 1) || ($DERATE_FLCC != 1) || ($DERATE_FLCN != 1) || ($DERATE_FEDC != 1) || ($DERATE_FEDN != 1) || ($DERATE_FECC != 1) || ($DERATE_FECN != 1)} {
      puts [format "%s%s" "Warn" "ing : Some of the Target_derate* variables are non-unity value and Innovus_DerateMethod is set to 0. "]
      puts [format "%s%s" "Warn" "ing : Values of the Target_derate* variables will be ignored for Timing Analysis."]
    }
    if {[info exists MAX_SBOCV] && ($MAX_SBOCV ne {})} {
      puts [format "%s%s" "Warn" "ing : MAX_SBOCV is defined in CadSetup.file.Since Innovus_DerateMethod is set to 0, MAX_SBOCV will be ignored."]
    }
    if {[info exists MIN_SBOCV] && ($MIN_SBOCV ne {})} { 
      puts [format "%s%s" "Warn" "ing : MIN_SBOCV is defined in CadSetup.file.Since Innovus_DerateMethod is set to 0, MIN_SBOCV will be ignored."]
    }
  } elseif {$Innovus_DerateMethod == 1} {
    puts [format "%s%s" "In" "fo : OCV Derating is used for timing analysis"]
    if {($DERATE_SLDC == 1) && ($DERATE_SLDN == 1) && ($DERATE_SLCC == 1) && ($DERATE_SLCN == 1) && ($DERATE_SEDC == 1) && ($DERATE_SEDN == 1) && ($DERATE_SECC == 1) && ($DERATE_SECN == 1) && ($DERATE_FLDC == 1) && ($DERATE_FLDN == 1) && ($DERATE_FLCC == 1) && ($DERATE_FLCN == 1) && ($DERATE_FEDC == 1) && ($DERATE_FEDN == 1) && ($DERATE_FECC == 1) && ($DERATE_FECN == 1)} {
      puts [format "%s%s" "ERR" "OR : OCV Derating is selected in CadSetup.file but all Target_derate* variables are set to unity value"]
      exit
    }
    if {[info exists MAX_SBOCV] && ($MAX_SBOCV ne {})} {
      puts [format "%s%s" "Warn" "ing : MAX_SBOCV is defined in CadSetup.file.Since Innovus_DerateMethod is set to 1, MAX_SBOCV will be ignored."]
    }
    if {[info exists MIN_SBOCV] && ($MIN_SBOCV ne {})} { 
      puts [format "%s%s" "Warn" "ing : MIN_SBOCV is defined in CadSetup.file.Since Innovus_DerateMethod is set to 1, MIN_SBOCV will be ignored."]
    }
  } elseif {$Innovus_DerateMethod == 2} {
    if {[info exists MAX_SBOCV] && ($MAX_SBOCV eq {})} {
      puts [format "%s%s" "ERR" "OR :    MAX_SBOCV must be defined in CadSetup.file for AOCV flow."]
      exit
    }
    if {[info exists MIN_SBOCV] && ($MIN_SBOCV eq {})} { 
      puts [format "%s%s" "ERR" "OR :    MIN_SBOCV must be defined in CadSetup.file for AOCV flow."]
      exit
    }
    puts [format "%s%s" "In" "fo : AOCV Derating with Incremental OCV  is used for timing analysis"]
  } elseif {$Innovus_DerateMethod == 3} {
    if {[llength $Lib_CadenceLIB] != 0} {
      puts [format "%s%s" "Warn" "ing : The following grep command can fail if there are no sigma values in the first listed Liberty"]
      puts [format "%s%s" "Warn" "ing : file. Make sure all Liberty files have LVF sigma data in them before setting Innovus_DerateMethod"]
      puts [format "%s%s" "Warn" "ing : to 3 in CadSetup.file."]
      set LIB [open [lindex $Lib_CadenceLIB 0]]
      while {[gets $LIB line] >= 0} {
	  if {[regexp {ocv_sigma_cell_rise} $line]} {
          set SIGMA_COUNT 1
          break
        }
      }
      close $LIB
      if {$SIGMA_COUNT > 0} {
        puts [format "%s%s" "In" "fo : SOCV sigma values are present in the first input Liberty file"]
        puts [format "%s%s" "In" "fo : SOCV Derating with Incremental OCV  is used for timing analysis"]
      } else {
        puts [format "%s%s"   "ERR" "OR : SOCV derating was requested via Innovus_DerateMethod in CadSetup.file, but no LVF data"]
        puts [format "%s%s%s" "ERR" "OR : is present in the first file in the Lib_CadenceLIB variable: " [lindex $Lib_CadenceLIB 0]]
        exit
      }
    }
    set SIGMA_COUNT 0
    if {[llength $Lib_CadenceMinLIB] != 0} {
      puts [format "%s%s" "Warn" "ing : The following grep command can fail if there are no sigma values in the first listed Liberty"]
      puts [format "%s%s" "Warn" "ing : file. Make sure all Liberty files have LVF sigma data in them before setting Innovus_DerateMethod"]
      puts [format "%s%s" "Warn" "ing : to 3 in CadSetup.file."]
      set LIB [open [lindex $Lib_CadenceMinLIB 0]]
      while {[gets $LIB line] >= 0} {
	  if {[regexp {ocv_sigma_cell_rise} $line]} {
          set SIGMA_COUNT 1
          break
        }
      }
      close $LIB
      if {$SIGMA_COUNT > 0} {
        puts [format "%s%s" "In" "fo : SOCV sigma values are present in the first input Liberty file"]
        puts [format "%s%s" "In" "fo : SOCV Derating with Incremental OCV  is used for timing analysis"]
      } else {
        puts [format "%s%s"   "ERR" "OR : SOCV derating was requested via Innovus_DerateMethod in CadSetup.file, but no LVF data"]
        puts [format "%s%s%s" "ERR" "OR : is present in the first file in the Lib_CadenceMinLIB variable: " [lindex $Lib_CadenceMinLIB 0]]
        exit
      }
    } 
  } else {
    puts [concat "ERR" "OR : Valid Values of Innovus_DerateMethod are 0,1,2 or 3.Refer  CadSetup.file for usage."]
    exit
  }
}

proc TIP_get_file_name_prefix {} {
  source Tempus_define.tcl
  global FILE_NAME_PREFIX
  if {[file exists Block_netlist.v] || [file exists Block_syn.v]} {
    set FILE_NAME_PREFIX Block
  } else {
    set FILE_NAME_PREFIX $TOP_DESIGN
  }
}

proc TIP_create_path_groups {} {
  source Tempus_define.tcl
  set enable_flop_clk_pins ""
  set enable_latch_clk_pins ""
  set clk_gate_enable_pins ""
  set enable_latch_data_pins ""
  set clk_gate_pins [get_pins -quiet -hier -filter "is_clock_gating==true"]

  set mem_in_ports ""
  set mem_out_ports ""

  if {[sizeof_collection $clk_gate_pins] > 0} {
    foreach_in_collection clk_gate_pin $clk_gate_pins {
      if {[sizeof_collection [get_property $clk_gate_pin clocks]]==0} {
        set clk_gate_enable_pins [add_to_collection $clk_gate_enable_pins $clk_gate_pin]
        if {[get_property [get_cells -of $clk_gate_pin] is_integrated_clock_gating_cell]==true} {
          set enable_flop_clk_pins [add_to_collection $enable_flop_clk_pins \
                           [all_fanin -startpoints_only -to $clk_gate_pin]]
        } else {
          set enable_latch_clk_pins [add_to_collection $enable_latch_clk_pins \
                             [all_fanin -startpoints_only -to $clk_gate_pin]]
        }
      }
    }

    if {([sizeof_collection $enable_flop_clk_pins] > 0)&&([sizeof_collection $clk_gate_enable_pins] > 0)} {
      group_path -name power_clkgate -from $enable_flop_clk_pins -to $clk_gate_enable_pins
    }
    if {([sizeof_collection $enable_latch_clk_pins] > 0)&&([sizeof_collection $clk_gate_enable_pins] > 0)} {
      group_path -name gating_check -from $enable_latch_clk_pins -to $clk_gate_enable_pins

      set enable_latch_data_pins [get_pins -hier -quiet -of [get_cells -hier -quiet -of $enable_latch_clk_pins] \
                                           -filter "is_data==true"]
      foreach_in_collection enable_latch_data_pin $enable_latch_data_pins {
        set is_rise_edge_triggered [get_attribute [get_cell -of $enable_latch_data_pin] is_rise_edge_triggered]
        set is_fall_edge_triggered [get_attribute [get_cell -of $enable_latch_data_pin] is_fall_edge_triggered]

        if {($is_rise_edge_triggered==false) && ($is_fall_edge_triggered==false)} {
          group_path -name power_clkgate -to $enable_latch_data_pin
        }
      }
    }
  }

  set mss_cells     [get_cells -hier -quiet -filter "@full_name=~*TwoCycle* || @is_memory_cell==true"]
  set mss_clk_pins  [get_pins -quiet -of $mss_cells -filter "@is_clock==true"]
  set mss_data_pins [get_pins -quiet -of $mss_cells -filter "@is_clock==false && @direction==in"]

  set i 1
  foreach CP $CLK_PORT {
    set all_reg($i)  [all_registers -clock_pins -clock CLK$i] 
    set clk_pins($i) [remove_from_collection $all_reg($i) $mss_clk_pins]
    incr i
  }
  set i 1
  foreach CP $CLK_PORT {
    set data_pins($i) [all_registers -data_pins -clock CLK$i]
    if {([sizeof_collection $mss_data_pins] > 0)} {set data_pins($i) [remove_from_collection $data_pins($i) $mss_data_pins]}
    if {([sizeof_collection $enable_latch_data_pins] > 0)} {set data_pins($i) [remove_from_collection $data_pins($i) $enable_latch_data_pins]}
    if {([sizeof_collection $clk_gate_enable_pins] > 0)} {set data_pins($i) [remove_from_collection $data_pins($i) $clk_gate_enable_pins]}
    incr i
  }

  set i 1
  foreach CP $CLK_PORT {
    if {[sizeof_collection [get_clocks -quiet CLK$i]]!=0} {
      #set async_pins [remove_from_collection [all_registers -async_pins -clock CLK$i] $mss_data_pins]
      #if {[sizeof_collection $async_pins]>0} {group_path -name CLK -from $clk_pins($i) -to $async_pins($i)}
  
      if {[sizeof_collection $data_pins($i)]>0}  {group_path -name CLK$i -from $clk_pins($i) -to $data_pins($i)}
  
      if {[sizeof_collection $mss_clk_pins]!=0} {
        foreach_in_collection mss_clk_pin $mss_clk_pins {
          group_path -name mem_io -from [get_property $mss_clk_pin full_name]
        }
        group_path -name mem_io -from $clk_pins($i) -to [get_pins -of [get_cells -of $mss_clk_pins] -filter "pin_direction==in && is_clock_pin==false"]
      } else {
        set mem_in_ports [get_pins -quiet -of $mss_cells -filter "@direction==in"]
        set mem_out_ports [get_pins -quiet -of $mss_cells -filter "@direction==out"]
        if {([sizeof_collection $mem_in_ports]>0) && ([sizeof_collection $data_pins]>0)} {
          group_path -name mem_io -from $mem_in_ports -to $data_pins(i)
        }
        if {([sizeof_collection $mem_out_ports]>0) && ([sizeof_collection $clk_pins]>0)} {
          group_path -name mem_io -from $clk_pins($i) -to $mem_out_ports
        }
        if {([sizeof_collection $mem_in_ports]>0) && ([sizeof_collection $mem_out_ports]>0)} {
  	group_path -name mem_io -from $mem_in_ports -to $mem_out_ports
        }
      }
      group_path -name I2F_$i -from [remove_from_collection [all_inputs] $mem_in_ports] -to $data_pins($i)
      group_path -name F2O_$i -from $clk_pins($i) -to [remove_from_collection [all_outputs] $mem_out_ports]
  
      group_path -name I2O -from [all_inputs] -to [all_outputs]
    }
    incr i
  }
  
  if {[sizeof_collection [get_clocks -quiet $JTAG_CLK_PORT]]!=0} {
    set clk_pins   [all_registers -clock_pins -clock $JTAG_CLK_PORT]
    set data_pins  [all_registers -data_pins -clock $JTAG_CLK_PORT]
    set async_pins [all_registers -async_pins -clock $JTAG_CLK_PORT]
  
    group_path -name JTCK -from $clk_pins -to $data_pins
    if {[sizeof_collection $async_pins]!=0} {
      group_path -name JTCK -from $clk_pins -to $async_pins
    }  
    group_path -name I2F -from [remove_from_collection [all_inputs] $mem_in_ports] -to $data_pins
    group_path -name F2O -from $clk_pins -to [remove_from_collection [all_outputs] $mem_out_ports]
  }
  
  if {[sizeof_collection [get_clocks -quiet PMDA_TCK]]!=0} {
    set mbist_clk_pins   [all_registers -clock_pins -clock PMDA_TCK]
    set mbist_data_pins  [all_registers -data_pins -clock PMDA_TCK]
  
    group_path -name PMDA_TCK -from $mbist_clk_pins -to $mbist_data_pins
    set mbist_input_ports [get_ports -quiet PMDA_* -filter "@direction==in"]
    set mbist_output_ports [get_ports -quiet PMDA_* -filter "@direction==out"]
    set mbist_clk_ports [get_ports -quiet PMDA_TCK]
    group_path -name mbist_io_paths -from [remove_from_collection $mbist_input_ports $mbist_clk_ports] -to $mbist_data_pins
    group_path -name mbist_io_paths -from $mbist_clk_pins -to $mbist_output_ports
  }
}

proc TIP_compensate_negative_hold_delays {} {
  set cells [get_cells -hier -filter "is_sequential==true"]
  echo "##" > annotate_delays.tcl
  foreach_in_collection c $cells {
    set pins [get_pins -quiet -of $c -filter "pin_direction==in && is_clock_pin==false && lib_pin_name != SI && lib_pin_name != SE"]
    foreach_in_collection p $pins {
      set tps [report_timing -collection -early -to $p]
      if {[sizeof_collection $tps] == 1} {
	set tp [index_collection $tps 0]
	set slack [get_attribute $tp slack]
	if {$slack != "INFINITY"} {
	  set hold_req [get_attribute -quiet $tp endpoint_hold_time_value]
	  if {$hold_req == ""} {
	    set hold_req [get_attribute -quiet $tp endpoint_removal_time_value]
	    if {$hold_req == ""} {
	      puts "no data for [get_attribute $p full_name]"
	      continue
	    }
	  }
	  set inv_hold_req [expr -1.0 * $hold_req]
	  if {($hold_req < 0)} {
	    echo "set_annotated_delay -net -to [get_attribute $p full_name] -increment  $inv_hold_req" >> annotate_delays.tcl
	  }
	}
      }
    }
  }
}

proc TIP_calculate_insertion_delay {FILE_NAME VIEW} {
  source Tempus_define.tcl
  
  # CLK
  set CLOCK_PORT [list]
  foreach CP $CLK_PORT {
    redirect /dev/null {set CLOCK_PORT [add_to_collection $CLOCK_PORT [get_ports $CP]]}
  }
  redirect /dev/null {set CLOCK_PORT [filter_collection $CLOCK_PORT {port_direction == in}]}

  # Debug clock
  set DEBUG_CLOCK_PORT [list]
  set DEBUG_CLOCK_NAME [list]
  redirect /dev/null {set DEBUG_CLOCK_PORT [get_ports -quiet "$JTAG_CLK_PORT"]}

  ###########################
  set ins_delay_median_clk 0
  set INSERTION_PATHS_CLK [list]
  set ARRIVAL_TIMES_CLK [list]
  foreach_in_collection CP [add_to_collection $CLOCK_PORT $DEBUG_CLOCK_PORT] {
    set INSERTION_PATHS_CLK [add_to_collection $INSERTION_PATHS_CLK [report_timing -view $VIEW -collection -from [get_ports [get_object_name $CP]] -max_paths 2000000]]
  }
  foreach_in_collection IP $INSERTION_PATHS_CLK {
    lappend ARRIVAL_TIMES_CLK [get_property $IP arrival]
  }
  set ins_delay_median_clk [lindex [lsort $ARRIVAL_TIMES_CLK] [expr int([llength $ARRIVAL_TIMES_CLK] / 2)]]
  redirect [format "%s" $FILE_NAME] {echo [format "%s%s" "Median CLK insertion delay is: " $ins_delay_median_clk]}

  ################################
  if {$DEBUG_CLOCK_PORT != [list] } {
    set ins_delay_median_dclk 0
    set INSERTION_PATHS_DCLK [list]
    set ARRIVAL_TIMES_DCLK [list]
    foreach_in_collection CP $DEBUG_CLOCK_PORT {
      set INSERTION_PATHS_DCLK [add_to_collection $INSERTION_PATHS_DCLK [report_timing -view $VIEW  -collection -unconstrained -from [get_ports [get_object_name $CP]] -max_paths 2000000]]
    }
    foreach_in_collection IP $INSERTION_PATHS_DCLK {
      lappend ARRIVAL_TIMES_DCLK [get_property $IP arrival]
    }
    set ins_delay_median_dclk [lindex [lsort $ARRIVAL_TIMES_DCLK] [expr [llength $ARRIVAL_TIMES_DCLK] / 2]]
	redirect -append [format "%s" $FILE_NAME] {echo [format "%s%s" "Median JTCK insertion delay is: " $ins_delay_median_dclk]}
  }
}

proc TIP_dump_id_per_wns_port {pvt_corner using_sbocv file_prefix} {
  if {$pvt_corner eq "setup"} {
    set OUTFILE [format "%s%s" $file_prefix "_verify.port_id_values"]
  } elseif {$pvt_corner eq "hold"} {
    set OUTFILE [format "%s%s" $file_prefix "_verify.min.port_id_values"]
  } else {
    puts [format "%s%s" "Err" "or   : Only \"setup\" and \"hold\" are supported values for the pvt_corner argument"]
  }
  set out_fp [open $OUTFILE w]
  set ALL_INPUT_PORTS [get_ports -filter "@direction==in"]
  set SKIP_THESE_INPUT_PORTS [list]
  append_to_collection SKIP_THESE_INPUT_PORTS [get_ports -quiet $JTAG_CLK_PORT]
  foreach CP $CLK_PORT {append_to_collection SKIP_THESE_INPUT_PORTS [get_ports -quiet $CP]}
  foreach RS $RST_PORT {append_to_collection SKIP_THESE_INPUT_PORTS [get_ports -quiet $RS]}
  append_to_collection SKIP_THESE_INPUT_PORTS [get_ports -quiet $TESTMODE]
  append_to_collection SKIP_THESE_INPUT_PORTS [get_ports -quiet $TESTMODE_OVERRIDE]
  append_to_collection SKIP_THESE_INPUT_PORTS [get_ports -quiet test_se]
  append_to_collection SKIP_THESE_INPUT_PORTS [get_ports -quiet test_si*]
  append_to_collection SKIP_THESE_INPUT_PORTS [get_ports -quiet $JTAG_RST_PORT]
  append_to_collection SKIP_THESE_INPUT_PORTS [get_ports -quiet PMDA_TCK]
  append_to_collection SKIP_THESE_INPUT_PORTS [get_ports -quiet PMDA_RESET]
  append_to_collection SKIP_THESE_INPUT_PORTS [get_ports -quiet PMDA_TDI]
  set REDUCED_INPUT_PORTS [remove_from_collection $ALL_INPUT_PORTS $SKIP_THESE_INPUT_PORTS]
  set ALL_OUTPUT_PORTS [get_ports -filter "@direction==out"]
  set SKIP_THESE_OUTPUT_PORTS [list]
  append_to_collection SKIP_THESE_OUTPUT_PORTS [get_ports -quiet test_so*]
  append_to_collection SKIP_THESE_OUTPUT_PORTS [get_ports -quiet PMDA_DONE]
  append_to_collection SKIP_THESE_OUTPUT_PORTS [get_ports -quiet PMDA_FAIL]
  append_to_collection SKIP_THESE_OUTPUT_PORTS [get_ports -quiet PMDA_TDO]
  set REDUCED_OUTPUT_PORTS [remove_from_collection $ALL_OUTPUT_PORTS $SKIP_THESE_OUTPUT_PORTS]
  
  foreach_in_collection RIP $REDUCED_INPUT_PORTS {
    set CURRENT_INPUT_PORT [get_ports [get_object_name $RIP]]
    if {$pvt_corner eq "setup"} {
      if {$using_sbocv == 2} {
	set CURRENT_INPUT_TIMING_PATH [report_timing -collection -view $setup_views -max_paths 1 -nworst 1 -max_slack 1000 -path_type full_clock -retime aocv_path_slew_propagation -retime_mode exhaustive -from $CURRENT_INPUT_PORT]
      } else {
	set CURRENT_INPUT_TIMING_PATH [report_timing -collection -view $setup_views -max_paths 1 -nworst 1 -max_slack 1000 -path_type full_clock -retime path_slew_propagation -retime_mode exhaustive -from $CURRENT_INPUT_PORT]
      }
    } else {
      if {$using_sbocv == 2} {
	set CURRENT_INPUT_TIMING_PATH [report_timing -collection -early -view $hold_views -max_paths 1 -nworst 1 -max_slack 1000 -path_type full_clock -retime aocv_path_slew_propagation -retime_mode exhaustive -from $CURRENT_INPUT_PORT]
      } else {
	set CURRENT_INPUT_TIMING_PATH [report_timing -collection -early -view $hold_views -max_paths 1 -nworst 1 -max_slack 1000 -path_type full_clock -retime path_slew_propagation -retime_mode exhaustive -from $CURRENT_INPUT_PORT]
      }
    }
    set CURRENT_INPUT_ID [get_property $CURRENT_INPUT_TIMING_PATH capturing_clock_latency]
    puts $out_fp [format "%-15s   %-50s   %10s" "input" [get_object_name $CURRENT_INPUT_PORT] $CURRENT_INPUT_ID]
  }
  
  foreach_in_collection ROP $REDUCED_OUTPUT_PORTS {
    set CURRENT_OUTPUT_PORT [get_ports [get_object_name $ROP]]
    if {$pvt_corner eq "setup"} {
      if {$using_sbocv == 2} {
	set CURRENT_OUTPUT_TIMING_PATH [report_timing -collection -view $setup_views -max_paths 1 -nworst 1 -max_slack 1000 -path_type full_clock -retime aocv_path_slew_propagation -retime_mode exhaustive -to $CURRENT_OUTPUT_PORT]
      } else {
	set CURRENT_OUTPUT_TIMING_PATH [report_timing -collection -view $setup_views -max_paths 1 -nworst 1 -max_slack 1000 -path_type full_clock -retime path_slew_propagation -retime_mode exhaustive -to $CURRENT_OUTPUT_PORT]
      }
    } else {
      if {$using_sbocv == 2} {
	set CURRENT_OUTPUT_TIMING_PATH [report_timing -collection -early -view $hold_views -max_paths 1 -nworst 1 -max_slack 1000 -path_type full_clock -retime aocv_path_slew_propagation -retime_mode exhaustive -to $CURRENT_OUTPUT_PORT]
      } else {
	set CURRENT_OUTPUT_TIMING_PATH [report_timing -collection -early -view $hold_views -max_paths 1 -nworst 1 -max_slack 1000 -path_type full_clock -retime path_slew_propagation -retime_mode exhaustive -to $CURRENT_OUTPUT_PORT]
      }
    }
    set CURRENT_OUTPUT_ID [get_property $CURRENT_OUTPUT_TIMING_PATH launching_clock_latency]
    puts $out_fp [format "%-15s   %-50s   %10s" "output" [get_object_name $CURRENT_OUTPUT_PORT] $CURRENT_OUTPUT_ID]
  }
  close $out_fp
}

proc TIP_create_libs { lib_config } {
  source Tempus_define.tcl -verbose
  foreach lib $lib_config {
    set lib_file [set [lindex $lib 1]]
    set constraint_map(setup) "setup"
    set constraint_map(hold) "hold"
    set constraint_map(typ) "setup"
    set constraint_map(leakage) "setup"
    if {$lib_file != {} && $lib_file != ""} {
      if {$Innovus_DerateMethod == 2} {
        eval "create_library_set -name [lindex $lib 0]_lib_set -timing \"$lib_file\" -aocv $[lindex $lib 2]"
        set_analysis_mode -aocv true
      } else {
        eval "create_library_set -name [lindex $lib 0]_lib_set -timing \"$lib_file\""
        set_analysis_mode -aocv false
      }
      eval "create_constraint_mode -name [lindex $lib 0]_view_functional -sdc_files [glob final.enc.dat/mmmc/modes/$constraint_map([lindex $lib 0])_view_functional/$constraint_map([lindex $lib 0])_view_functional.sdc*]"

      create_rc_corner -name [lindex $lib 0]_rc_corner
      eval "create_delay_corner -name [lindex $lib 0]_delay_corner -library_set [lindex $lib 0]_lib_set -rc_corner [lindex $lib 0]_rc_corner"
      eval "create_analysis_view -name [lindex $lib 0] -constraint_mode [lindex $lib 0]_view_functional -delay_corner [lindex $lib 0]_delay_corner"
    }
  }
}

