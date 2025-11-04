#############################################################################################
#        Copyright (c) 2009-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

#Updates clock source latencies to compensate for CTS delay
#No need to constrain IO CLK latency.
proc TIP_calculate_clock_latencies {} {
  source Innovus_define.cmd
  if {[catch {open "clock_latencies.cmd" "w"} filePtr] != 0} {
    Puts [format "%s%s" "**ERR" "OR: failed to open file clock_latencies.cmd for writing"]
    return -1
  }
  set activeSetup [all_setup_analysis_views]
  set activeHold [all_hold_analysis_views]  
  puts $filePtr "#######################################################"
  puts $filePtr "## Auto generated script to constrain clock latencies"
  puts $filePtr "## post CTS for IO timing paths for $TOP_DESIGN"
  puts $filePtr "#######################################################\n"
  foreach view [all_analysis_views] {
      set_analysis_view -setup $view -hold $view -update_timing
      puts $filePtr "  #####################################################################"
      puts $filePtr "  set_analysis_view -setup $view -hold $view"
      puts $filePtr "  set_interactive_constraint_modes ${view}_functional" 
      set all_clks [get_clocks -quiet *]
      foreach_in_collection clk $all_clks {
          set clk_name [lindex [get_property $clk full_name] 0]
          set clkx $clk
          if {$clk_name == ""} continue

           set io_flops ""
           set clk_ports [all_inputs -clock $clkx]
           if {[sizeof_collection $clk_ports]>0} {
             set io_flops [all_fanout -endpoints_only -from $clk_ports -only_cells]
           }
           set clk_ports [all_outputs -clock $clkx]
           if {[sizeof_collection $clk_ports]>0} {
             set io_flops [add_to_collection $io_flops \
                          [all_fanin -startpoints_only -to $clk_ports -only_cells]]
           }
           if {[sizeof_collection $io_flops]>0} {
             set io_flop_clk_pins [get_pins -hier -quiet -of $io_flops -filter "is_clock==true"]
           } else {
             set io_flop_clk_pins ""
           }
           
           if {[sizeof_collection $io_flop_clk_pins]<=0} { 
             puts $filePtr "##########################################"
             puts $filePtr "# No boundary flops found for clock '${clk_name}'"
             continue
           }

           set io_latencies [list]
           foreach_in_collection flop_clk_pin $io_flop_clk_pins {
             set flop_clk_pin_max_latency [get_property -quiet \
                                          -clock $clk [get_pin $flop_clk_pin] \
                                          actual_latency_late_rise_max]
             if {$flop_clk_pin_max_latency != ""} {
               lappend io_latencies $flop_clk_pin_max_latency
             }
           }
           if {[llength $io_latencies]==0} {
             continue
           }
           set clk_src [get_property [lindex \
                       [get_property $clk sources] 0] full_name]
  
           set existing_latency [lindex [get_property [get_ports $clk_src] \
                                 source_latency_early_fall_max] 0]
  
           if {$existing_latency == "NA"} {set existing_latency 0}
  
           set latency [lindex [lsort -real $io_latencies] \
                                   [expr [llength $io_latencies]/2]]
  
           set latency [expr $latency - $existing_latency]
           puts $filePtr "  set_clock_latency -source -max -${latency} \[get_ports { $clk_src }\]"
           puts $filePtr "  set_clock_latency -source -min -${latency} \[get_ports { $clk_src }\]"
      }
           puts $filePtr "  set_interactive_constraint_modes {}"
  }
  close $filePtr
  source clock_latencies.cmd
  set_analysis_view -hold $activeHold -setup $activeSetup
}

#Removes additional constraint on clock gates added during placement
proc TIP_remove_overconstrain_cgs {} {
  source Innovus_define.cmd
  set clk_gate_enable_pins ""
  set clk_gate_pins [get_pins -quiet -hier -filter "is_clock_gating==true"]
  if {[sizeof_collection $clk_gate_pins]==0} {
    return
  }
  foreach_in_collection clk_gate_pin $clk_gate_pins {
    if {[sizeof_collection [get_property $clk_gate_pin clocks]]==0} {
      set clk_gate_enable_pins [add_to_collection $clk_gate_enable_pins $clk_gate_pin]
    }
  }
  
  set cmd ""
  foreach_in_collection cge $clk_gate_enable_pins {
    set cmd "${cmd};reset_path_exception -type path_delay -to [get_property $cge full_name]"
  }
  set_interactive_constraint_modes [all_constraint_modes  -active]
  eval $cmd
  set_interactive_constraint_modes {}
}

#Creates general Core path groups
proc TIP_create_path_groups {} {
  source Innovus_define.cmd
  set enable_flop_clk_pins ""
  set enable_latch_clk_pins ""
  set clk_gate_enable_pins ""
  set enable_latch_data_pins ""
  set clk_gate_pins [get_pins -quiet -hier -filter "is_clock_gating==true"]
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
      #if {[sizeof_collection $async_pins]>0} {group_path -name CLK$i -from $clk_pins($i) -to $async_pins}

      if {[sizeof_collection $data_pins($i)]>0}  {
        group_path -name CLK$i -from $clk_pins($i) -to $data_pins($i)
      }
  
      set mem_in_ports ""
      set mem_out_ports ""
      if {[sizeof_collection $mss_clk_pins]!=0} {
        foreach_in_collection mss_clk_pin $mss_clk_pins {
          group_path -name mem_io -from [get_property $mss_clk_pin full_name]
        }
        group_path -name mem_io -to [get_pins -of [get_cells -of $mss_clk_pins] -filter "pin_direction==in && is_clock_pin==false"]
        group_path -name mem_io -from [get_pins -of [get_cells -of $mss_clk_pins] -filter "pin_direction==out && is_clock_pin==false"]
      } else {
        set mem_in_ports [get_pins -quiet -of $mss_cells -filter "@direction==in"]
        set mem_out_ports [get_pins -quiet -of $mss_cells -filter "@direction==out"]
  
        if {([sizeof_collection $mem_in_ports]>0) && ([sizeof_collection $data_pins($i)]>0)} {
          group_path -name mem_io -from $mem_in_ports
        }
        if {([sizeof_collection $mem_out_ports]>0) && ([sizeof_collection $clk_pins($i)]>0)} {
          group_path -name mem_io -to $mem_out_ports
        }
      }
  
      if {$Innovus_EnableIOPathGroup==1} {
        if {[sizeof_collection $data_pins($i)]>0} {
          set input_ports [all_inputs]
          set clk_ports [get_ports -quiet $CP]
          if {[sizeof_collection $clk_ports] > 0} {
            set input_ports [remove_from_collection $input_ports $clk_ports]
          }
          if {[sizeof_collection $mem_in_ports] > 0} {
            set input_ports [remove_from_collection $input_ports $mem_in_ports]
          }
          if {[sizeof_collection $input_ports] > 0} {
            group_path -name I2F_$i -from $input_ports -to $data_pins($i)
          }
        }
        if {[sizeof_collection $clk_pins($i)]>0} {
          set output_ports [all_outputs]
          if {[sizeof_collection $mem_out_ports] > 0} {
            set output_ports [remove_from_collection $output_ports $mem_out_ports]
          }
          if {[sizeof_collection $output_ports] > 0} {
            group_path -name F2O_$i -from $clk_pins($i) -to $output_ports
          }
        }
      }
    }
    incr i
  }

  if {([sizeof_collection [report_timing -from [all_inputs] -to [all_outputs] -collection]]>0) && ($Innovus_EnableIOPathGroup==1)} {
    group_path -name I2O -from [all_inputs] -to [all_outputs]
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
    set mbist_data_pins [all_registers -data_pins -clock PMDA_TCK]
    if {[sizeof_collection $mbist_data_pins]>0}  {group_path -name PMDA_TCK -from $mbist_clk_pins -to $mbist_data_pins}
    if {[sizeof_collection $mbist_data_pins]>0} {
      set mbist_input_ports [get_ports -quiet PMDA_* -filter "@direction==in"]
      set mbist_clk_ports [get_ports -quiet {PMDA_TCK}]
      if {[sizeof_collection $mbist_clk_ports] > 0} {
        set mbist_input_ports [remove_from_collection $mbist_input_ports $mbist_clk_ports]
      }
      if {[sizeof_collection $mbist_input_ports] > 0} {
        group_path -name mbist_io_paths -from $mbist_input_ports -to $mbist_data_pins
      }
    }
    if {[sizeof_collection $mbist_clk_pins]>0} {
      set mbist_output_ports [get_ports -quiet PMDA_* -filter "@direction==out"]
      if {[sizeof_collection $mbist_output_ports] > 0} {
        group_path -name mbist_io_paths -from $mbist_clk_pins -to $mbist_output_ports
      }
    }
  }
}


proc TIP_set_uncertainties {{extra_uncertainty 0}} {
  set_interactive_constraint_modes [all_constraint_modes -active]
  source Innovus_define.cmd
  
    reset_clock_uncertainty [get_clocks *]
    set i 1
    foreach CP $CLK_PORT {
      set_clock_uncertainty -setup [expr $extra_uncertainty + $CLOCK_JITTER] CLK$i
      set_clock_uncertainty -hold $HOLD_MARGIN CLK$i
      incr i
    }
    if {[sizeof_collection [get_ports -quiet JTCK]]!=0} {
      set_clock_uncertainty -setup [expr $extra_uncertainty + $CLOCK_JITTER] JTCK
      set_clock_uncertainty -hold $HOLD_MARGIN JTCK
    }
    
    set_interactive_constraint_modes {}
}

proc TIP_dont_merge_icg {} {
  if {[sizeof_collection [get_cells -hier -quiet -filter "@full_name=~*_icgprefanout*"]]!=0} {
    set_dont_touch [get_cells -hier -quiet -filter "@full_name=~*_icgprefanout*"]
    set_ccopt_property allow_resize_of_dont_touch_cells true
  }
}
