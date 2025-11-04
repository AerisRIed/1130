#############################################################################################
#        Copyright (c) 2008-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

source load_etc.tcl

proc TIP_generate_timestamp {args} {
  switch -- [parse_options "TIP_generate_timestamp" {} $args \
		"-tag srs name associated with timestamp" \
		date_tag \
	    ] {
	       -2 { return }
		0 { error "Failed on TIP_generate_timestamp" }
	      }
  puts [format "%s%s%s%s" "The system " "time after " $date_tag " is:"]
  sh date +%s
}

proc TIP_generate_timestat {args} {
  switch -- [parse_options "TIP_generate_timestat" {} $args \
		"-print_tag srs name printed with runtime and memory string" \
		print_tag \
		"-stat_tag srs name printed with timestat command" \
		stat_tag \
	    ] {
	       -2 { return }
		0 { error "Failed on TIP_generate_timestat" }
	      }
  global QOR_SWITCH

  puts [format "%s%s%s" "Runtime " "& Memory after " $print_tag]
  eval timestat $stat_tag
  eval report qor $QOR_SWITCH
}

proc TIP_output_db {args} {
  switch -- [parse_options "TIP_output_db" {} $args \
		"-common bos Generate Innovus-compatible DB file" \
		generate_common_db \
		"-override bos Always generate DB regardless of global dump variable" \
		override_dump \
		"-db srs Target output DB file" \
		output_db \
	    ] {
	       -2 { return }
		0 {  error "Failed on TIP_output_db"}
	      }
  global GENUS_DUMP
  global TOP_DESIGN
  global TOOL_VERSION

  if {$override_dump} {
    if {$generate_common_db} {
      eval write_db -common -verbose -all_root_attributes -design [find / -design $TOP_DESIGN] $output_db
    } else {
      eval write_db -verbose -all_root_attributes -design [find / -design $TOP_DESIGN] $output_db
    }
  }
}

proc TIP_all_clockgating {args} {
  switch -- [parse_options "TIP_all_clockgating" {} $args \
                   "-enable_pins bos return enable pins of clock_gating elements" \
                   enable \
                   "-pattern srs pattern name to search for clock_gating instances" \
                   pattern \
		   "-pin_pattern srs pattern name for pins of clock_gating instances" \
		   pin_pattern \
		   "-des_name srs target design name" \
		   verilog_design_name
                   ] {
                       -2 { return }
                       0 {  error "Failed on TIP_all_clockgating"}
                   }
  set cg_enables ""
  set design [find / -design $verilog_design_name]
  set all_cg_insts [find $design -inst $pattern]
  set cg_inst_inp_pins ""
  if {$enable} {
    if {[llength $all_cg_insts]} {
      foreach cg_inst $all_cg_insts {
        set cg_inst_inp_pins [concat $cg_inst_inp_pins [find $cg_inst -pin pins_in/$pin_pattern]]
      }
      set clocks [find $design -clock *]
      set all_clock_tree_pins ""
      foreach clock $clocks {
        set source [concat [get_attribute inverted_sources $clock] [get_attribute non_inverted_sources $clock]]
        foreach src $source {
          set all_clock_tree_pins [concat $all_clock_tree_pins [fanout -endpoint $src]]
        }
      }
      set final_list [dc::remove_from_collection $cg_inst_inp_pins $all_clock_tree_pins]
      return $final_list
    } else {
      puts "No instances found for the given pattern $pattern"
      return
    }
  } else {
    if {[llength $all_cg_insts]} {
      return $all_cg_insts
    } else {
      puts "No instances found for the given pattern $pattern"
      return
    }
  }   
}

proc TIP_prevent_scan_usage {} {
  set all_lib_flops [filter flop true [find / -libcell *]]
  set lib_scan_flops ""
  set lib_standard_flops ""
  foreach flop $all_lib_flops {
    set scn_en [llength [get_attribute scan_enable $flop]]
    set scn_in [llength [get_attribute scan_in $flop]]
    if {$scn_en && $scn_in} {
      lappend lib_scan_flops $flop
    } else {
      lappend lib_standard_flops $flop
    }
  }
  if {[llength $lib_scan_flops] == 0} {
    puts "None of the libraries loaded into this session contain scan flops."
  } elseif {[llength $lib_standard_flops] < [llength $lib_scan_flops]} {
    puts "There are more scan flops than standard flops in the libraries loaded for this session;"
    puts "All scan flops will be used to allow for correct functionality."
  } else {
    puts "The following library scan flops will not be used during this synthesis run:"
    puts $lib_scan_flops
    set_attribute -quiet preserve true $lib_scan_flops
    set_attribute -quiet avoid true $lib_scan_flops
  }
}

proc TIP_force_scan_usage {args} {
  switch -- [parse_options "TIP_force_scan_usage" {} $args \
                   "-async_ok bos Include asynchronous flops" \
                   async_ok
                   ] {
                       -2 { return }
                        0 { error "Failed on TIP_force_scan_usage"}
                     }
  set allowed_scan_flops ""
  set standard_scan_flops ""
  set found_sync_flop 0
  set list_of_flops [filter flop true [find / -libcell *]]
  foreach flop $list_of_flops {
    set scn_en [llength [get_attribute scan_enable $flop]]
    set scn_in [llength [get_attribute scan_in $flop]]
    set sc [llength [get_attribute sync_clear $flop]]
    set sp [llength [get_attribute sync_preset $flop]]
    set ac [llength [get_attribute async_clear $flop]]
    set ap [llength [get_attribute async_preset $flop]]
    if {$async_ok && ($ac || $ap) && $scn_en && $scn_in} {
      lappend allowed_scan_flops $flop
    } elseif {($sc || $sp) && $scn_en && $scn_in} {
      set found_sync_flop 1
      lappend allowed_scan_flops $flop
    } elseif {$scn_en && $scn_in} {
      lappend standard_scan_flops $flop
    }
  }
  if {([llength $allowed_scan_flops] == 0) && ([llength $standard_scan_flops] == 0)} {
    puts [format "%s%s" "Err" "or   : the libraries loaded in this session do not contain any scan flops, although scan"]
    puts [format "%s%s" "Err" "or   : insertion is selected for this design. This run will now terminate."]
    quit(1)
  } elseif {[llength $allowed_scan_flops] == 0} {
    puts [format "%s%s" "Warn" "ing : the libraries loaded in this session do not contain set/reset scan flops, although"]
    puts [format "%s%s" "Warn" "ing : several set/reset flop instantiations exist in the RTL. All available scan flops except"]
    puts [format "%s%s" "Warn" "ing : those defined by the Lib_DontUseCells list will be used in this run. However, this will"]
    puts [format "%s%s" "Warn" "ing : increase the probability that gate-level simulations will fail due to X propagation during reset."]
    puts "Scan flops to be used in this synthesis run are:"
    puts $standard_scan_flops
    set_attribute -quiet preserve false $standard_scan_flops
    set_attribute -quiet avoid false $standard_scan_flops
  } elseif {$found_sync_flop == 0} {
    puts [format "%s%s" "Warn" "ing : the libraries loaded in this session do not contain synchronous set/reset scan flops,"]
    puts [format "%s%s" "Warn" "ing : which are necessary for this design. All available scan flops except those defined by"]
    puts [format "%s%s" "Warn" "ing : the Lib_DontUseCells list will be used in this run. However, this will increase the"]
    puts [format "%s%s" "Warn" "ing : probability that gate-level simulations will fail due to X propagation during reset."]
    puts "Scan flops to be used in this synthesis run are:"
    puts $allowed_scan_flops
    puts $standard_scan_flops
    set_attribute -quiet preserve false $allowed_scan_flops
    set_attribute -quiet avoid false $allowed_scan_flops
    set_attribute -quiet preserve false $standard_scan_flops
    set_attribute -quiet avoid false $standard_scan_flops
  } else {
    puts "Scan flops to be used in this synthesis run are:"
    puts $allowed_scan_flops
    set_attribute -quiet preserve false $allowed_scan_flops
    set_attribute -quiet avoid false $allowed_scan_flops
  }
}

proc TIP_use_only_sync_reset_flops {args} {
  switch -- [parse_options "TIP_use_only_sync_reset_flops" {} $args \
                   "-async_ok bos Include asynchronous flops" \
                   async_ok
                   ] {
                       -2 { return }
                        0 { error "Failed on TIP_use_only_sync_reset_flops"}
                     }
  set reset_flop_list ""
  set non_reset_flop_list ""
  set found_sync_flop 0
  set all_flops [filter flop true [find / -libcell *]] 
  foreach flop $all_flops {
    set sc [llength [get_attribute sync_clear $flop]]
    set sp [llength [get_attribute sync_preset $flop]]
    set ac [llength [get_attribute async_clear $flop]]
    set ap [llength [get_attribute async_preset $flop]]
    set scn_en [llength [get_attribute scan_enable $flop]]
    set scn_in [llength [get_attribute scan_in $flop]]
    if {($sc || $sp) && !$scn_en && !$scn_in} {
      set found_sync_flop 1
      lappend reset_flop_list $flop
    } elseif {($ac || $ap) && $async_ok && !$scn_en && !$scn_in} {
      lappend reset_flop_list $flop
    } else {
      lappend non_reset_flop_list $flop
    }
  }
  if {[llength $reset_flop_list] == 0} {
    puts [format "%s%s" "Warn" "ing : the libraries loaded in this session contain neither sync nor async reset flops, although"]
    puts [format "%s%s" "Warn" "ing : several reset flop instantiations occur in the RTL. All flops other than those specified by the"]
    puts [format "%s%s" "Warn" "ing : Lib_DontUseCells list will be used in this synthesis run. However, this will increase the"]
    puts [format "%s%s" "Warn" "ing : probability that gate-level simulations will fail due to X propagation during reset."]
  } elseif {$found_sync_flop == 0} {
    puts [format "%s%s" "Warn" "ing : the libraries loaded in this session do not contain any synchronous reset flops, although"]
    puts [format "%s%s" "Warn" "ing : several synchronous reset flop instantiations occur in the RTL. All flops other than those specified"]
    puts [format "%s%s" "Warn" "ing : by the Lib_DontUseCells list will be used in this synthesis run. However, this will increase the"]
    puts [format "%s%s" "Warn" "ing : probability that gate-level simulations will fail due to X propagation during reset."]
  } else {
    puts "Flops to be used in this synthesis run are:"
    puts $reset_flop_list
    set_attribute -quiet preserve false $reset_flop_list
    set_attribute -quiet avoid false $reset_flop_list
    if {[llength $non_reset_flop_list] != 0} {
      set_attribute -quiet preserve true $non_reset_flop_list
      set_attribute -quiet avoid true $non_reset_flop_list
    }
  }
}

proc TIP_make_clock_network_ideal {args} {
  switch -- [parse_options "TIP_make_clock_network_ideal" {} $args \
		   "-des_name srs target design name" \
		   verilog_design_name
		   ] {
		       -2 { return }
		       0 {  error "Failed on TIP_make_clock_network_ideal"}
		   }
  array unset instances_list
  array unset nets_list
  set design [find / -design $verilog_design_name]
  set ports ""
  set clocks [find $design -clock *]
  foreach clk $clocks {
    set ports [concat $ports [concat [get_attribute inverted_sources $clk] [get_attribute non_inverted_sources $clk]]]
  }
  if {![llength $ports]} {
    puts [format "%s%s" "Err" "or   : No clock ports found."]
    error "Failed on 'TIP_make_clock_network_ideal'"    
  }
  set instance_list ""
  set net_list ""
  array set instances_list {}
  array set nets_list {}
  foreach clkport $ports {
    set clk_pins [fanout -structural $clkport]
    set clk_cells ""
    set combo_cells ""
    set associated_nets ""
    foreach ele $clk_pins {
      set inst [dirname [dirname $ele]]
      if {[what_is $inst] eq "instance"} {
        set index [get_attribute address $inst]
        if {![info exists instances_list($index)]} {
          set instances_list([get_attribute address $inst]) $inst
        }
      } 
    }
  }
  foreach name [array names instances_list] {
    if {([basename [dirname $instances_list($name)]] ne "instances_comb") \
        && (![llength [get_attribute clock_gating_integrated_cell [get_attribute libcell $instances_list($name)]]])} {
      unset instances_list($name)
    }
  }
  foreach name [array names instances_list] {
    set inst $instances_list($name)
    set out_pin [find $inst -pin -maxdepth 2 pins_out/*] 
    set_attribute -quiet ideal_driver true $out_pin
    set nets [all_connected $out_pin]
    foreach ele $nets {
      set net_index [get_attribute address $ele]
      if {![info exists nets_list($net_index)]} {
        set nets_list($net_index) $ele
      }
    }
  }
  foreach net [array names nets_list] {
    set_attribute -quiet physical_cap 0 $nets_list($net)
  }
}

proc TIP_find_icg_cells {} {
  set icg_cells {}
  foreach element [find ./ -instance *] {
    set lib_cell [get_attribute libcell $element]
    if {[llength $lib_cell] && [llength [get_attribute clock_gating_integrated_cell $lib_cell]]} {
      lappend icg_cells $element
    }
  }
  return $icg_cells
}

proc TIP_find_icg_enable_pins {args} {
  switch -- [parse_options "TIP_find_icg_enable_pins" {} $args \
                   "-clk_pins bos list clock pins instead" \
                   clk_pins \
		   "-output_pins bos list output pins instead" \
		   output_pins \
                   "-source_clk srs name of source clock" \
                   source_clk
                   ] {
                       -2 { return }
                        0 { error "Failed on TIP_find_icg_enable_pins"}
                     }
  set icg_enable_pins {}
  set icg_clock_pins {}
  set icg_output_pins {}
  set icg_cells [TIP_find_icg_cells]
  set clock_port {}
  if {[llength [find / -clock $source_clk]] != 0} {
    set clock_port [concat [get_attribute inverted_sources [find / -clock $source_clk]] [get_attribute non_inverted_sources [find / -clock $source_clk]]]
  }
  foreach element $icg_cells {
    set lib_cell [get_attribute libcell $element]
    set lib_cell_enable_pin [basename [filter clock_gate_enable_pin true [find $lib_cell -libpin *]]]
    set lib_cell_clock_pin [basename [filter clock_gate_clock_pin true [find $lib_cell -libpin *]]]
    set lib_cell_output_pin [basename [filter clock_gate_out_pin true [find $lib_cell -libpin *]]]
    set element_enable_pin [find $element -pin $lib_cell_enable_pin]
    set element_clock_pin [find $element -pin $lib_cell_clock_pin]
    set element_output_pin [find $element -pin $lib_cell_output_pin]
    set possible_root_clock_ports [fanin -structural -startpoints $element_clock_pin]
    set clock_port_match 0
    foreach cp $clock_port {
      if {[llength [filter name [basename $cp] $possible_root_clock_ports]] != 0} {
	set clock_port_match 1
      }
    }
    if {$clock_port_match == 1} {
      if {[llength $element_enable_pin]} {
	lappend icg_enable_pins $element_enable_pin
      }
      if {[llength $element_clock_pin]} {
	lappend icg_clock_pins $element_clock_pin
      }
      if {[llength $element_output_pin]} {
	lappend icg_output_pins $element_output_pin
      }
    }
  }
  if {$clk_pins} {
    return $icg_clock_pins
  } elseif {$output_pins} {
    return $icg_output_pins
  } else {
    return $icg_enable_pins
  }
}

proc TIP_test_scan_chain_complete {args} {
  switch -- [parse_options "TIP_test_scan_chain_complete" {} $args \
                   "-memory_list srs list of memory hard macros to exclude from consideration" \
                   memory_list \
		   "-max_length srs maximum flop count of all scan chains" \
		   max_length
                   ] {
                       -2 { return }
                        0 { error "Failed on TIP_test_scan_chain_complete"}
                     }
  set RUN_FAILED 0
  set MEM_MACRO_COUNT 0
  foreach ml $memory_list {
    set MEM_MACRO_COUNT [expr $MEM_MACRO_COUNT + [llength [filter -regexp libcell $ml [find / -instance *]]]]
  }
  set ICG_COUNT [llength [TIP_find_icg_cells]]
  set DESIGN_FLOP_COUNT [llength [all::all_seqs -edge_triggered]]
  set DESIGN_FLOP_COUNT [expr $DESIGN_FLOP_COUNT - $MEM_MACRO_COUNT - $ICG_COUNT]
  set DESIGN_SCAN_CHAINS [find / -actual_scan_chain *]
  set TOTAL_SCAN_FLOP_COUNT 0
  foreach SC $DESIGN_SCAN_CHAINS {
    set SINGLE_CHAIN_LENGTH [get_attribute reg_count $SC]
    set TOTAL_SCAN_FLOP_COUNT [expr $TOTAL_SCAN_FLOP_COUNT + $SINGLE_CHAIN_LENGTH]
    if {$max_length > 0} {
      if {$SINGLE_CHAIN_LENGTH > $max_length} {
	puts [format "%s%s%s%s%s%s%s" "Err" "or   : In scan chain " $SC " there are " $SINGLE_CHAIN_LENGTH " flops, when the maximum allowed is " $max_length]
	set RUN_FAILED 1
      } else {
	puts [format "%s%s%s%s%s%s" "Check passed: scan chain " $SC " has " $SINGLE_CHAIN_LENGTH " flops out of a maximum of " $max_length]
      }
    }
  }
  if {$TOTAL_SCAN_FLOP_COUNT >= $DESIGN_FLOP_COUNT} {
    puts "Check passed: total number of flops in scan chains is greater than or equal to the total design flop count"
  } else {
    set DISCREPANCY [expr $DESIGN_FLOP_COUNT - $TOTAL_SCAN_FLOP_COUNT]
    puts [format "%s%s%s%s" "Err" "or   : There are " $DISCREPANCY " design flops not assigned to any scan chains"]
    set RUN_FAILED 1
  }
  if {$RUN_FAILED == 1} {
    check_dft_rules > failed_dft_insertion.report
    change_names -verilog -max_length 500
    write_hdl > failed_dft_insertion.v
    report dft_chains > failed_dft_insertion.scanchains
    report gates > failed_dft_insertion.ref
    quit(1)
  }
}

proc TIP_ungroup_target_subdesigns {args} {
  switch -- [parse_options "TIP_ungroup_target_subdesigns" {} $args \
	     "-preserve_boundary bos return prevent boundary optimization" \
	     preserve_boundary \
	     "-subdesign_list srs list of subdesigns to ungroup" \
	     subdesign_list
	    ] {
	       -2 { return }
		0 { error "Failed on TIP_ungroup_target_subdesigns"}
	      }
  set global_instance_list [list]
  if {[llength $subdesign_list] != 0} {
    foreach subd $subdesign_list {
      foreach sub_subd [find / -regexp "${subd}(_\[0-9\]+)*?$" -subdesign $subd] {
	foreach inst_sub_subd [get_attribute instances $sub_subd] {
	  lappend global_instance_list $inst_sub_subd
	}
      }
    }
  }
  if {[llength $global_instance_list] != 0} {
    foreach gil $global_instance_list {
      cd $gil
      set local_exclude_list [list]
      set local_instance_string [list]
      foreach lil $global_instance_list {
	set local_instance_string [basename $lil]
	if {[llength [find ./ -instance $local_instance_string]] != 0} {
	  lappend local_exclude_list [find ./ -instance $local_instance_string]
	}
      }
      if {[llength $local_exclude_list] != 0} {
	ungroup -flatten -all -only_user_hierarchy -exclude $local_exclude_list
      } else {
	ungroup -flatten -all -only_user_hierarchy
      }
      cd
    }
  }
  if {[llength $subdesign_list] != 0} {
    foreach subd $subdesign_list {
      foreach sub_subd [find / -regexp "${subd}_?\[0-9\]*?_?\[0-9\]*?_?\[0-9\]*?_?\[0-9\]*?$" -subdesign [format "%s%s%s" "*" $subd "*"]] {
	if {$preserve_boundary} {
	  set_attribute boundary_opto false $sub_subd
	} else {
	  set_attribute boundary_opto true $sub_subd
	}
	set_attribute ungroup_ok false $sub_subd
      }
    }
  }
}

proc TIP_generate_subdesign_constraints {args} {
  switch -- [parse_options "TIP_generate_subdesign_constraints" {} $args \
	     "-subdesign_list srs list of subdesigns to characterize" \
	     subdesign_list
	    ] {
	       -2 { return }
		0 { error "Failed on TIP_generate_subdesign_constraints"}
	      }
  if {[llength $subdesign_list] != 0} {
    foreach subd $subdesign_list {
      foreach sub_subd [find / -regexp "${subd}(_\[0-9\]+)*?$" -subdesign $subd] {
	foreach inst_sub_subd [get_attribute instances $sub_subd] {
	  set name_of_instance [basename $inst_sub_subd]
	  redirect [format "%s%s" $name_of_instance ".boundary_opto_report"] {report boundary_opto $inst_sub_subd}
	  derive_environment -sdc_only -name $name_of_instance $inst_sub_subd
	  cd
	  cd [find / -design $name_of_instance]
	  redirect [format "%s%s" $name_of_instance ".port_list"] {puts "Input Ports:"}
	  foreach ip [find ./ -port ports_in/*] {
	    redirect -append [format "%s%s" $name_of_instance ".port_list"] {puts [basename $ip]}
	  }
	  redirect -append [format "%s%s" $name_of_instance ".port_list"] {puts "Output Ports:"}
	  foreach op [find ./ -port ports_out/*] {
	    redirect -append [format "%s%s" $name_of_instance ".port_list"] {puts [basename $op]}
	  }
	  cd
	  write_sdc -no_split [find / -design $name_of_instance] > [format "%s%s" $name_of_instance ".sdc"]
	  rm [find / -design $name_of_instance]
	}
      }
    }
  }
}

proc TIP_report_instance_boundary_optimizations {args} {
  switch -- [parse_options "TIP_report_instance_boundary_optimizations" {} $args \
	     "-instance srs design instance on which to report boundary pin changes" \
	     specified_instance
	    ] {
	       -2 { return }
		0 {error "Failed on TIP_report_instance_boundary_optimizations"}
	      }
  if {[llength $specified_instance] != 0} {
    set full_instance_path [find ./ -instance $specified_instance]
    if {[llength $full_instance_path] != 0} {
      set instance_name [basename $full_instance_path]
      redirect [format "%s%s" $instance_name "_boundary_opto.report"] {puts "Boundary optimizations for $instance_name:"}
      set all_instance_pins [get_pins -of_objects $full_instance_path]
      foreach aip $all_instance_pins {
	set pin_dir [get_attribute direction [get_pins $aip]]
	set pin_opt [get_attribute boundary_change [get_pins $aip]]
	if {$pin_opt ne "none"} {
	  redirect -append [format "%s%s" $instance_name "_boundary_opto.report"] {puts [format "%s   %s   %s" [basename $aip] $pin_dir $pin_opt]}
	}
      }
    }
  }
}

proc TIP_report_single_cycle_loops {} {
  redirect exact_single_cycle_loops.txt {puts [format "%-100s%-10s" "Single Cycle Loop Flop" "Slack"]}
  redirect -append exact_single_cycle_loops.txt {puts [string repeat - 110]}
  redirect partial_single_cycle_loops.txt {puts [format "%-100s%-100s%-10s" "Startpoint" "Endpoint" "Slack"]}
  redirect -append partial_single_cycle_loops.txt {puts [string repeat - 210]}
  set ALL_FLOP_OUTPUTS [all::all_seqs -edge_triggered -output_pins]
  set TOTAL_OUTPUT_COUNT [llength $ALL_FLOP_OUTPUTS]
  set HEARTBEAT_COUNT 0
  foreach AFO $ALL_FLOP_OUTPUTS {
    incr HEARTBEAT_COUNT
    set CURRENT_STARTPOINT [basename [dirname [dirname $AFO]]]
    set START_MATCH [join [lreplace [split $CURRENT_STARTPOINT _] end-1 end] _]
    set FANOUT_ENDPOINTS [fanout -structural -endpoints $AFO]
    foreach FE $FANOUT_ENDPOINTS {
      set CURRENT_ENDPOINT [basename [dirname [dirname $FE]]]
      set END_MATCH [join [lreplace [split $CURRENT_ENDPOINT _] end-1 end] _]
      if {$START_MATCH eq $END_MATCH} {
	redirect -variable timingPath {report timing -from [dirname [dirname $AFO]] -to [dirname [dirname $FE]]}
	set pathLines [split $timingPath "\n"]
	set SLACK_VAL 0.0
	foreach elem $pathLines {
	  if {[string match "Timing" [lindex $elem 0]] && [string match "slack" [lindex $elem 1]]} {
	    set SLACK_VAL [lindex $elem 3]
	  }
	}
	set SLACK_VAL [join [lreplace [split $SLACK_VAL ""] end-1 end] ""]
	if {$SLACK_VAL < 0.0} {
	  if {$CURRENT_STARTPOINT eq $CURRENT_ENDPOINT} {
	    redirect -append exact_single_cycle_loops.txt {puts [format "%-100s%-10s" $CURRENT_STARTPOINT $SLACK_VAL]}
	  } else {
	    redirect -append partial_single_cycle_loops.txt {puts [format "%-100s%-100s%-10s" $CURRENT_STARTPOINT $CURRENT_ENDPOINT $SLACK_VAL]}
	  }
	}
      }
    }
    if {[expr $HEARTBEAT_COUNT % 200] == 0} {
      puts [format "%s%s%s%s%s" "Processed " $HEARTBEAT_COUNT " out of " $TOTAL_OUTPUT_COUNT " output ports"]
    }
  }
}

proc TIP_analyze_transitive_fanout {args} {
  switch -- [parse_options "TIP_analyze_transitive_fanout" {} $args \
                   "-threshold srs threshold to dump out flop outputs" \
                   thresh_val
                   ] {
                       -2 { return }
                        0 { error "Failed on TIP_analyze_transitive_fanout"}
                     }

  time_info -current
  set heartbeat_count 0
  set new_dir_name [format "%s%s" "flops_over_" $thresh_val]
  sh mkdir -p transitive_flop_fanout/$new_dir_name

  redirect transitive_flop_fanout/flop_fanout.txt {puts [format "%-150s    %10s" "Flop name" "Fanout"]}
  redirect -append transitive_flop_fanout/flop_fanout.txt {puts [string repeat - 164]}
  redirect transitive_flop_fanout/flop_fanin.txt {puts [format "%-150s    %10s" "Flop name" "Fanin"]}
  redirect -append transitive_flop_fanout/flop_fanin.txt {puts [string repeat - 164]}

  set ALL_DESIGN_FLOP_OUTPUTS [filter -invert name "*asyncreset*" [filter -invert name "*_cg1*" [all::all_seqs -edge_triggered -output_pins]]]
  set output_port_count [llength $ALL_DESIGN_FLOP_OUTPUTS]
  set ALL_DESIGN_FLOP_INPUTS [filter -invert name "*asyncreset*" [filter -invert name "*_cg1*" [all::all_seqs -edge_triggered -data_pins]]]
  set input_port_count [llength $ALL_DESIGN_FLOP_INPUTS]
  foreach ADFO $ALL_DESIGN_FLOP_OUTPUTS {
    incr heartbeat_count
    set local_flop_name [basename [dirname -times 2 $ADFO]]
    set local_structural_fanout [fanout -structural -endpoints -vname $ADFO]
    redirect -append transitive_flop_fanout/flop_fanout.txt {puts [format "%-150s    %10s" $local_flop_name [llength $local_structural_fanout]]}
    if {[llength $local_structural_fanout] >= $thresh_val} {
      set local_file_name [format "%s%s" $local_flop_name ".fanout_list"]
      foreach lsf $local_structural_fanout {
	redirect -append transitive_flop_fanout/$new_dir_name/$local_file_name {puts $lsf}
      }
    }
    if {[expr $heartbeat_count % 500] == 0} {
      puts [format "%s%s%s%s%s" "Processed " $heartbeat_count " out of " $output_port_count " flop outputs"]
    }
  }
  set heartbeat_count 0
  foreach ADFI $ALL_DESIGN_FLOP_INPUTS {
    incr heartbeat_count
    if {([basename $ADFI] ne "SI") && ([basename $ADFI] ne "SE")} {
      set local_flop_name [basename [dirname -times 2 $ADFI]]
      set local_structural_fanin [fanin -structural -startpoints $ADFI]
      redirect -append transitive_flop_fanout/flop_fanin.txt {puts [format "%-150s    %10s" $local_flop_name [llength $local_structural_fanin]]}
    }
    if {[expr $heartbeat_count % 500] == 0} {
      puts [format "%s%s%s%s%s" "Processed " $heartbeat_count " out of " $input_port_count " flop inputs"]
    }
  }
  time_info -current
}

proc TIP_check_async_reset_synchronizer_fanout {} {
  set RESET_STAGING_SUBMODULES [find / -subdesign *reset_tmode_async*]
  foreach RSS $RESET_STAGING_SUBMODULES {
    foreach IRSS [get_attribute instances $RSS] {
      set non_functional_reset_pins [filter -invert name "*apre" [filter -invert name "*aclr" [filter direction in [fanout -structural -endpoints [format "%s%s" $IRSS "/pins_out/*freset"]]]]]
      set non_functional_reset_pins [filter -invert name "*ResetMuxWrapper*" [filter -invert name "*mem_seven_stage*" $non_functional_reset_pins]]
      set non_functional_reset_pins [filter -invert name "*ScalarPipe*TIE*localReset" $non_functional_reset_pins]
      if {[llength $non_functional_reset_pins] != 0} {
	set final_pin_list [list]
	foreach nfrp $non_functional_reset_pins {
	  if {[sizeof_collection [filter name "*ResetMuxWrapper*" [fanin -structural $nfrp]]] == 0} {
	    lappend final_pin_list $nfrp
	  }
	}
	if {[llength $final_pin_list] != 0} {
	  puts [format "%s%s%s" "Err" "or   : Functional reset of this synchronizer goes somewhere other than an async set/reset pin: " $IRSS]
	  redirect -append async_functional_reset_bad_fanout.txt {puts [format "%s%s" "Bad fanout of xtfreset in synchronizer: " $IRSS]}
	  foreach fpl $final_pin_list {
	    redirect -append async_functional_reset_bad_fanout.txt {puts "    $fpl"}
	  }
	}
      }
      set non_logical_reset_pins [filter -invert name "*srd" [filter -invert name "*srl" [filter -invert name "*sena" [filter -invert name "*d" [filter direction in [fanout -structural -endpoints [format "%s%s" $IRSS "/pins_out/*lreset"]]]]]]]
      set non_logical_reset_pins [filter -invert name "*ICache*" [filter -invert name "*ITag*" [filter -invert name "*DCache*" [filter -invert name "*DTag*" [filter -invert name "*DRam*" $non_logical_reset_pins]]]]]
      set non_logical_reset_pins [filter -invert name "*IRam*" [filter -invert name "*DRom*" [filter -invert name "*IRom*" [filter -invert name "*URam*" [filter -invert name "*DPort*" $non_logical_reset_pins]]]]]
      set non_logical_reset_pins [filter -invert name "*PrefetchRam*" [filter -invert name "*TraceMem*" [filter -invert name "*L1SCache*" [filter -invert name "*L1STag*" [filter -invert name "*L1VCache*" $non_logical_reset_pins]]]]]
      set non_logical_reset_pins [filter -invert name "*L1VTag*" [filter -invert name "*L1VPrefetch*" [filter -invert name "*VectorDRam*" [filter -invert name "*ReorderBuffer*" $non_logical_reset_pins]]]]
      set non_logical_reset_pins [filter -invert name "*ResetMuxWrapper*" $non_logical_reset_pins]
      if {[llength $non_logical_reset_pins] != 0} {
	set final_pin_list [list]
	foreach nlrp $non_logical_reset_pins {
	  if {[sizeof_collection [filter name "*ResetMuxWrapper*" [fanin -structural $nlrp]]] == 0} {
	    lappend final_pin_list $nlrp
	  }
	}
	if {[llength $final_pin_list] != 0} {
	  puts [format "%s%s%s" "Err" "or   : Logical reset of this synchronizer goes somewhere other than a data or enable input pin: " $IRSS]
	  redirect -append async_logical_reset_bad_fanout.txt {puts [format "%s%s" "Bad fanout of xtlreset in synchronizer: " $IRSS]}
	  foreach fpl $final_pin_list {
	    redirect -append async_logical_reset_bad_fanout.txt {puts "    $fpl"}
	  }
	}
      }
    }
  }
}

proc TIP_check_reset_sync_to_clock_gate_enable {} {
  set CLOCK_GATE_SUBMODULES [find / -subdesign *gated_tmode_clock*]
  set heartbeat_count 0
  set CG_SUBMODULE_COUNT [llength $CLOCK_GATE_SUBMODULES]
  foreach CGS $CLOCK_GATE_SUBMODULES {
    incr heartbeat_count
    foreach ICGS [get_attribute instances $CGS] {
      set CG_EN_PIN [filter name "*xten" [get_pins -of_objects $ICGS]]
      set FANIN_STARTPOINTS [fanin -structural -vname -startpoints $CG_EN_PIN]
      set POTENTIAL_RESET_SYNC_1 [llength [filter name "*Reset_reg*" $FANIN_STARTPOINTS]]
      set POTENTIAL_RESET_SYNC_2 [llength [filter name "*tapClkGateResetBd2_reg*" $FANIN_STARTPOINTS]]
      set POTENTIAL_RESET_SYNC_3 [llength [filter name "*reset*reg*" $FANIN_STARTPOINTS]]
      set POTENTIAL_RESET_SYNC_4 [llength [filter name "*ResetProc_synchronized_reg*" $FANIN_STARTPOINTS]]
      set POTENTIAL_RESET_SYNC_5 [llength [filter name "*TlbReset_Inst*" $FANIN_STARTPOINTS]]
      set POTENTIAL_RESET_SYNC_6 [llength [filter name "*ResetProc_logic*" $FANIN_STARTPOINTS]]
      set POTENTIAL_RESET_SYNC_7 [llength [filter name "*instreseti*" $FANIN_STARTPOINTS]]
      set POTENTIAL_RESET_SYNC_8 [llength [filter name "*insthreseti*" $FANIN_STARTPOINTS]]
      set FIND_A_RESET [expr $POTENTIAL_RESET_SYNC_1 + $POTENTIAL_RESET_SYNC_2 + $POTENTIAL_RESET_SYNC_3 + $POTENTIAL_RESET_SYNC_4 + $POTENTIAL_RESET_SYNC_5 + $POTENTIAL_RESET_SYNC_6 + $POTENTIAL_RESET_SYNC_7 + $POTENTIAL_RESET_SYNC_8]
      if {$FIND_A_RESET == 0} {
	puts [format "%s%s%s" "Err" "or   : The following clock gate does not have a staged synchronous reset going into its enable pin: " $ICGS]
	redirect -append clock_gates_without_sync_reset.txt {puts [format "%s%s" "No staged synchronous reset into enable pin of: " $ICGS]}
	foreach FS $FANIN_STARTPOINTS {
	  redirect -append clock_gates_without_sync_reset.txt {puts [format "%s%s" "        Fanin from: " $FS]}
	}
      }
    }
    if {[expr $heartbeat_count % 100] == 0} {
      puts [format "%s%s%s%s%s" "Sync reset check completed on " $heartbeat_count " out of " $CG_SUBMODULE_COUNT " clock gates"]
    }
  }
}

proc TIP_etm_transitive_flop_clk_pins {args} {
  switch -- [parse_options "TIP_etm_transitive_flop_clk_pins" {} $args \
		   "-instance srs ETM instance name" \
		   etm_inst_name \
		   "-file_prefix srs output file name prefix" \
		   outfile_prefix \
		   ] {
	              -2 { return }
        	       0 { error "Failed on TIP_etm_transitive_flop_clk_pins" }
            	   }
  set heartbeat_count 0
  set ETM_INPUT_PINS [get_pins -quiet -filter "direction==in" -leaf -of_objects $etm_inst_name]
  foreach CP $CLK_PORT {  
    set ETM_INPUT_PINS [filter -invert name "*/$CP" ]
  }
  set ETM_INPUT_PINS [filter -invert name "*/*CLK*"  [filter -invert name "*/$TESTMODE*" $ETM_INPUT_PINS]]
  set ETM_INPUT_PINS [filter -invert name "*/test_se" [filter -invert name "*/test_si*" ]]
  set ETM_OUTPUT_PINS [filter -invert name "*/test_so*" [get_pins -quiet -filter "direction==out" -leaf -of_objects $etm_inst_name]]
  set INPUT_COUNT [llength $ETM_INPUT_PINS]
  set OUTPUT_COUNT [llength $ETM_OUTPUT_PINS]
  foreach EIP $ETM_INPUT_PINS {
    incr heartbeat_count
    foreach FISP [fanin -structural -startpoints -vname $EIP] {
      redirect -append [format "%s%s" $outfile_prefix "_etm_transitive_input_flops.txt"] {puts $FISP}
    }
    if {[expr $heartbeat_count % 100] == 0} {
      puts [format "%s%s%s%s%s%s" "Transitive fanin startpoints reported for " $heartbeat_count " out of " $INPUT_COUNT " input ports of ETM " $outfile_prefix]
    }
  }
  set heartbeat_count 0
  foreach EOP $ETM_OUTPUT_PINS {
    incr heartbeat_count
    foreach FOSP [fanout -structural -endpoints -vname $EOP] {
      redirect -append [format "%s%s" $outfile_prefix "_etm_transitive_output_flops.txt"] {puts $FOSP}
    }
    if {[expr $heartbeat_count % 100] == 0} {
      puts [format "%s%s%s%s%s%s" "Transitive fanout endpoints reported for " $heartbeat_count " out of " $OUTPUT_COUNT " output ports of ETM " $outfile_prefix]
    }
  }
}

proc TIP_lint_timing_and_combo_loops {args} {
  switch -- [parse_options "TIP_lint_timing_and_combo_loops" {} $args \
		   "-file_prefix srs combo loop file name prefix" \
		   outfile_prefix \
		   ] {
	              -2 { return }
        	       0 { error "Failed on TIP_lint_timing_and_combo_loops" }
            	   }
  check_design -unresolved
  report timing -lint
  if {[get_attribute print_count [find / -message TIM-20]] != 0} {
    puts [format "%s%s%s%s" "Err" "or   : combinational loops detected - see " $outfile_prefix "_combinational_loops.txt file."]
    report cdn_loop_breaker > [format "%s%s" $outfile_prefix "_combinational_loops.txt"]
    quit(1)
  }
  set_attribute common_ui true /
  set combo_loops [get_db -if {.preserve_for_cb==true} hnets]
  if {[llength $combo_loops] != 0} {
    puts [format "%s%s%s%s" "Err" "or   : combinational loops detected - see " $outfile_prefix "_combinational_loops.txt file."]
    redirect [format "%s%s" $outfile_prefix "_combinational_loops.txt"] {puts $combo_loops}
    quit(1)
  }
  ::legacy::set_attribute common_ui false /
}

proc TIP_define_lp_icg_setup {args} {
  switch -- [parse_options "TIP_define_lp_icg_setup" {} $args \
		   "-des_name srs top-level design name" \
		   des_name \
		   ] {
	              -2 { return }
        	       0 { error "Failed on TIP_define_lp_icg_setup" }
            	   }
  foreach lc [find ./ -libcell *] {
    if {[llength [get_attribute clock_gating_integrated_cell $lc]] != 0} {
      set_attribute preserve false $lc
      set_attribute avoid false $lc
    }
  }
  set FIRST_ICG_INSTANCE [lindex [TIP_find_icg_cells] 0]
  if {[llength $FIRST_ICG_INSTANCE] != 0} {
    set USER_ICG_LIBCELL [get_attribute libcell $FIRST_ICG_INSTANCE]
    set_attribute lp_clock_gating_cell $USER_ICG_LIBCELL [find / -design $des_name]
    puts [format "%s%s%s" "In" "fo    : Automatic clock-gate insertion will use the following ICG libcell: " $USER_ICG_LIBCELL]
  }
}

proc TIP_ispatial_settings {} {
  global TOOL_VERSION
  global USE_MULTIBIT_CELLS
  global LOW_POWER_FLOW
  global LIB_PROCESS_NODE
  global LIB_TECH_NODE
  global MAX_PLACEMENT_DENSITY
  global Innovus_EarlyClockFlow
  global Innovus_MaxAllowedDelay
  global Innovus_CcoptUsefulSkewEnabled

  set_attribute place_global_clock_gate_aware true /
  set_attribute place_global_timing_effort high /
  set_attribute spatial_high_effort_placement true /
  set_attribute opt_spatial_manage_path_groups false /
  set_attribute invs_write_path_groups true /
  set_attribute library_setup_ispatial true /
  set_attribute opt_spatial_effort extreme /
  set_attribute opt_spatial_restructuring true /
  set_attribute aae_enabled 1 /
  if {$Innovus_EarlyClockFlow == 1} {
    set_attribute design_early_clock_flow true /
    set_attribute opt_spatial_early_clock true /
  } else {
    set_attribute design_early_clock_flow false /
    set_attribute opt_spatial_early_clock false /
  }
  if {$Innovus_CcoptUsefulSkewEnabled == 1} {
    set_attribute opt_spatial_useful_skew true /
  } else {
    set_attribute opt_spatial_useful_skew false /
  }
  if {$USE_MULTIBIT_CELLS == 1} {
    set_attribute opt_spatial_merge_flops true /
    set_attribute opt_multi_bit_flop_reorder_bits true /
  } else {
    set_attribute opt_spatial_merge_flops false /
    set_attribute opt_multi_bit_flop_reorder_bits false /
  }
  if {$LOW_POWER_FLOW == 1} {
    set_attribute opt_spatial_power_driven_effort high /
  } else {
    set_attribute opt_spatial_power_driven_effort low /
  }
  set_attribute write_design_create_boundary_opto_file true /
  set_attribute phys_checkout_innovus_license true /
  set_attribute report_timing_show_wire_length true /
  set_attribute phys_flow_effort high /
  set_attribute design_process_node $LIB_PROCESS_NODE /
  set_attribute design_tech_node $LIB_TECH_NODE /
  set_attribute invs_save_db true /
  set_attribute invs_temp_dir genus_innovus_interface_data /
  set_attribute invs_write_path_groups true /
  set_attribute invs_layer_independent_extraction true /
  set_attribute invs_preload_script ../scripts/genus/Genus_innovus_preload.tcl /
  if {$LIB_PROCESS_NODE == 16} {
    setDesignMode -flowEffort standard
    setDelayCalMode -enable_high_fanout true
    setDelayCalMode -enable_quiet_receivers_for_hold true
    setDelayCalMode -eng_copyNetPropToNewNet true
    setDelayCalMode -ewm_type simulation
    setDelayCalMode -ignoreNetLoad false
    setDelayCalMode -socv_accuracy_mode low
    setPlaceMode -place_global_place_io_pins false
    setAnalysisMode -aocv true
    setAnalysisMode -checkType setup
    setAnalysisMode -clkSrcPath false
    setAnalysisMode -clockPropagation forced_ideal
    if {$TOOL_VERSION < 22.10} {
      setOptMode -drcMargin -0.2
      setOptMode -powerEffort high
      setOptMode -usefulSkewPreCTS true
      setAnalysisMode -cppr both
    } else {
      setOptMode -opt_drv_margin -0.2
      setOptMode -opt_power_effort high
      setOptMode -opt_skew_pre_cts true
    }
  } elseif {$LIB_PROCESS_NODE == 7} {
    set_global lib_build_asynch_de_assert_arc true
    set_global timing_socv_view_based_nsigma_multiplier_mode true
    set_global timing_socv_statistical_min_max_mode mean_and_three_sigma_bounded
    set_global timing_socv_rc_variation_mode true
    setDesignMode -flowEffort standard
    setDelayCalMode -enable_high_fanout true
    setDelayCalMode -enable_quiet_receivers_for_hold true
    setDelayCalMode -eng_copyNetPropToNewNet true
    setDelayCalMode -ewm_type simulation
    setDelayCalMode -ignoreNetLoad false
    setDelayCalMode -signoff_alignment_settings true
    setDelayCalMode -socv_accuracy_mode low
    setDelayCalMode -socv_lvf_mode early_late
    setPlaceMode -place_detail_use_no_diffusion_one_site_filler true
    setPlaceMode -place_global_place_io_pins false
    setAnalysisMode -aocv false
    setAnalysisMode -checkType setup
    setAnalysisMode -clkSrcPath false
    setAnalysisMode -clockPropagation forced_ideal
    setAnalysisMode -socv true
    setAnalysisMode -timingEngine statistical
    setRouteMode -earlyGlobalNumTracksPerClockWire 4
    if {$TOOL_VERSION < 22.10} {
      set_global delaycal_use_default_delay_limit 1000
      set_global delaycal_default_net_delay 1000.0ps
      set_global delaycal_default_net_load 2.0pf
      set_global delaycal_input_transition_delay 100ps
      setUsefulSkewMode -maxAllowedDelay $Innovus_MaxAllowedDelay
      setOptMode -usefulSkewPreCTS true
      setAnalysisMode -cppr both
    } else {
      setUsefulSkewMode -opt_skew_max_allowed_delay $Innovus_MaxAllowedDelay
      setOptMode -opt_skew_pre_cts true
    }
  } elseif {$LIB_PROCESS_NODE == 5} {
    set_global lib_build_asynch_de_assert_arc true
    set_global timing_socv_view_based_nsigma_multiplier_mode true
    set_global timing_socv_statistical_min_max_mode mean_and_three_sigma_bounded
    set_global timing_socv_rc_variation_mode true
    setDesignMode -flowEffort standard
    setDelayCalMode -enable_high_fanout true
    setDelayCalMode -enable_quiet_receivers_for_hold true
    setDelayCalMode -eng_copyNetPropToNewNet true
    setDelayCalMode -ewm_type simulation
    setDelayCalMode -ignoreNetLoad false
    setDelayCalMode -signoff_alignment_settings true
    setDelayCalMode -socv_accuracy_mode low
    setDelayCalMode -socv_lvf_mode moments
    setPlaceMode -place_detail_no_filler_without_implant true
    setPlaceMode -place_detail_swap_eeq_cells true
    setPlaceMode -place_detail_use_no_diffusion_one_site_filler true
    setPlaceMode -place_global_place_io_pins true
    setAnalysisMode -aocv false
    setAnalysisMode -checkType setup
    setAnalysisMode -clkSrcPath false
    setAnalysisMode -clockPropagation forced_ideal
    setAnalysisMode -socv true
    setAnalysisMode -timingEngine statistical
    if {$TOOL_VERSION < 22.10} {
      set_global delaycal_use_default_delay_limit 1000
      set_global delaycal_default_net_delay 1000.0ps
      set_global delaycal_default_net_load 2.0pf
      set_global delaycal_input_transition_delay 100ps
      setUsefulSkewMode -maxAllowedDelay $Innovus_MaxAllowedDelay
      setOptMode -usefulSkewPreCTS true
      setOptMode -reclaimArea true
      setAnalysisMode -cppr both
    } else {
      setUsefulSkewMode -opt_skew_max_allowed_delay $Innovus_MaxAllowedDelay
      setOptMode -opt_skew_pre_cts true
      setOptMode -opt_area_recovery true
    }
  } elseif {$LIB_PROCESS_NODE == 3} {
    set_global lib_build_asynch_de_assert_arc true
    set_global timing_socv_view_based_nsigma_multiplier_mode true
    set_global timing_socv_statistical_min_max_mode mean_and_three_sigma_bounded
    set_global timing_socv_rc_variation_mode true
    setDesignMode -process $LIB_PROCESS_NODE -node $LIB_TECH_NODE
    setDesignMode -flowEffort standard
    setDelayCalMode -enable_high_fanout true
    setDelayCalMode -enable_quiet_receivers_for_hold true
    setDelayCalMode -eng_copyNetPropToNewNet true
    setDelayCalMode -ewm_type simulation
    setDelayCalMode -ignoreNetLoad false
    setDelayCalMode -signoff_alignment_settings true
    setDelayCalMode -socv_accuracy_mode low
    setDelayCalMode -socv_lvf_mode moments
    setPlaceMode -place_global_place_io_pins true
    setPlaceMode -place_global_max_density $MAX_PLACEMENT_DENSITY
    setPlaceMode -place_global_timing_effort high
    setPlaceMode -place_detail_no_filler_without_implant true
    setPlaceMode -place_detail_swap_eeq_cells true
    setPlaceMode -place_detail_use_no_diffusion_one_site_filler true
    setAnalysisMode -checkType setup
    setAnalysisMode -clkSrcPath false
    setAnalysisMode -clockPropagation forced_ideal
    setAnalysisMode -socv true
    setAnalysisMode -timingEngine statistical
    if {$TOOL_VERSION < 22.10} {
      set_global delaycal_use_default_delay_limit 1000
      set_global delaycal_default_net_delay 1000.0ps
      set_global delaycal_default_net_load 2.0pf
      set_global delaycal_input_transition_delay 100ps
      setUsefulSkewMode -maxAllowedDelay $Innovus_MaxAllowedDelay
      setOptMode -usefulSkewPreCTS true
      setOptMode -reclaimArea true
      setOptMode -fixClockDrv true
      setOptMode -fixFanoutLoad true
      setOptMode -addInstancePrefix prects
      setOptMode -usefulSkew true
      setOptMode -allEndPoints true
      setAnalysisMode -cppr both
      setNanoRouteMode -dbProcessNode $LIB_TECH_NODE
      setNanoRouteMode -drouteUseMultiCutViaEffort high
      setNanoRouteMode -routeWithViaInPin 1:1
      setNanoRouteMode -routeStrictlyHonorNonDefaultRule true
    } else {
      setUsefulSkewMode -opt_skew_max_allowed_delay $Innovus_MaxAllowedDelay
      setOptMode -opt_skew_pre_cts true
      setOptMode -opt_post_route_fix_clock_drv true
      setOptMode -opt_fix_fanout_load true
      setOptMode -opt_new_inst_prefix prects
      setOptMode -opt_skew true
      setOptMode -opt_all_end_points true
      setNanoRouteMode -route_process_node $LIB_TECH_NODE
      setNanoRouteMode -route_detail_use_multi_cut_via_effort high
      setNanoRouteMode -route_with_via_in_pin 1:1
      setNanoRouteMode -route_strict_honor_route_rule true
    }
  } else {
    puts [format "%s%s%s" "Warn" "ing : There are no specific Innovus placement/CTS settings available for this non-FinFET node: " $LIB_PROCESS_NODE]
    puts [format "%s%s" "Warn" "ing : iSpatial will proceed with default global settings."]
  }
}

proc TIP_ispatial_setup_and_launch {} {
  global FILE_NAME_PREFIX
  global LIB_PROCESS_NODE
  global INSERT_IO_BUFFERS
  global LIB_IO_BUFFERS
  global Innovus_EarlyClockFlow
  global TOOL_VERSION
  global CLK_PORT

  if {$LIB_PROCESS_NODE <= 7} {
    set_socv_rc_variation_factor -early 0.1
    set_socv_rc_variation_factor -late 0.1
  }
  if {$INSERT_IO_BUFFERS == 1} {
    set_attribute invs_add_io_buffers true /
    set_attribute invs_add_io_buffers_exclude_clock_net true /
    set_attribute invs_add_io_buffers_in_cells $LIB_IO_BUFFERS /
    set_attribute invs_add_io_buffers_out_cells $LIB_IO_BUFFERS /
    set_attribute invs_add_io_buffers_port true /
    set_attribute invs_add_io_buffers_suffix "iobuffer" /
    set_attribute invs_add_io_buffers_status softfixed /
  }

  if {$TOOL_VERSION < 22.10} {
    write_design -innovus -gzip_files -base_name ple_netlist/ple
  } else {
    TIP_output_db -override -db ple_netlist.db
  }

  set PATH_GROUP_LIST [list]
  set i 1
  foreach CP $CLK_PORT {
    lappend $PATH_GROUP_LIST CLK$i
    incr i
  }
  foreach PGL $PATH_GROUP_LIST {
    if {[llength [find / -cost_group $PGL]] != 0} {
      set_attribute spatial_path_group_effort_level high [find / -cost_group $PGL]
    }
  }
  if {$Innovus_EarlyClockFlow == 1} {
    set ECF_ICG_INSTANCE [lindex [TIP_find_icg_cells] 0]
    if {[llength $ECF_ICG_INSTANCE] != 0} {
      set TARGET_ICG_CELL [basename [get_attribute libcell $ECF_ICG_INSTANCE]]
      redirect -append Genus_generic_define.tcl {puts "set TARGET_ICG_CELL $TARGET_ICG_CELL"}
    } else {
      redirect -append Genus_generic_define.tcl {puts "set TARGET_ICG_CELL {}"}
    }
    read_clock_tree_spec ../scripts/genus/Genus_innovus_ecf_spec.tcl
  }
  syn_opt -spatial
  TIP_generate_timestamp -tag full_ispatial_syn_opt
  TIP_generate_timestat -print_tag "full_ispatial_synthesis" -stat_tag "FulliSpatialSynth"
  TIP_output_db -db [format "%s%s" $FILE_NAME_PREFIX {_full_ispatial.db}]
}

proc TIP_set_design_specific_lp_attributes {} {
  global LOW_POWER_GOAL
  global TOP_DESIGN
  if {($LOW_POWER_GOAL == 3) || ($LOW_POWER_GOAL == 5)} {
    set_attribute lp_clock_gating_max_flops 128 [find / -design $TOP_DESIGN]
    set_attribute lp_clock_gating_min_flops 2 [find / -design $TOP_DESIGN]
    set_attribute lp_clock_gating_extract_common_enable true [find / -design $TOP_DESIGN]
    set_attribute lp_clock_gating_auto_cost_grouping false [find / -design $TOP_DESIGN]
  }
}

proc TIP_generate_native_logic_depth_histograms {} {
  global REPORT_COST_GROUPS
  global FILE_NAME_PREFIX
  set BAR_COUNT 8
  set SLACK_LIMIT 100000
  puts [format "%s%s" "In" "fo    : Generating native path depth histogram report for entire design"]
  redirect [format "%s%s" $FILE_NAME_PREFIX "_syn.top_level_ll_histogram"] {report_logic_levels_histogram -bars $BAR_COUNT -slack_limit $SLACK_LIMIT -skip_buffer -skip_inverter}
  foreach RCG $REPORT_COST_GROUPS {
    set RCG_BASENAME [basename $RCG]
    puts [format "%s%s%s" "In" "fo    : Generating native path depth histogram detailed report for cost group: " $RCG_BASENAME]
    redirect [format "%s%s%s%s" $FILE_NAME_PREFIX "_syn." $RCG_BASENAME "_ll_histogram"] {report_logic_levels_histogram -bars $BAR_COUNT -slack_limit $SLACK_LIMIT -skip_buffer -skip_inverter -details -cost_group $RCG}
  }
}

proc TIP_remove_path_groups_and_exceptions {} {
  set CG_LATCH_CELLS {}
  if {[llength [TIP_find_icg_cells]] != 0} {
    set CG_LATCH_CELLS [TIP_find_icg_cells]
  } else {
    if {[llength [dc::remove_from_collection [all::all_seqs -level_sensitive] [find / -instance *RF*latchout*]]] != 0} {
      lappend CG_LATCH_CELLS [dc::remove_from_collection [all::all_seqs -level_sensitive] [find / -instance *RF*latchout*]]
    }
  }
  if {[llength $CG_LATCH_CELLS] != 0} {
    set_attribute latch_max_borrow no_value $CG_LATCH_CELLS
  }
  if {[llength [find / -exception max_delay_rm_*]] != 0} {
    rm [find / -exception max_delay_rm_*]
  }
  if {[llength [find / -exception pa_*]] != 0} {
    rm [find / -exception pa_*]
  }
  if {[llength [find / -cost_group *]] != 0} {
    rm [find / -cost_group *]
  }
}

proc TIP_set_initial_targets_on_cost_groups {} {
  global CLK_PORT
  set COST_GROUP_LIST [list]
  set i 1
  foreach CP $CLK_PORT {
    lappend $COST_GROUP_LIST CLK$i
    incr i
  }
  foreach CGL $COST_GROUP_LIST {
    if {[llength [find / -cost_group $CGL]] != 0} {
      set_attribute initial_target 0 [find / -cost_group $CGL]
    }
  }
}

proc TIP_generate_typical_corner_output_files {args} {
  switch -- [parse_options "TIP_generate_typical_corner_output_files" {} $args \
		"-prefix srs prefix of generated output files" \
		file_prefix \
	    ] {
	       -2 { return }
		0 { error "Failed on TIP_generate_typical_corner_output_files" }
	      }

  global TOP_DESIGN
  global CLOCK_IN_PORT
  global DEBUG_CLOCK_PORT
  global MBIST_CLOCK_PORT
  global CLOCK_OUT_PORT
  global Lib_CadenceTypLIB
  global SOCV_DERATING_USED
  global SOCV_LIBS_DETECTED
  global USE_POWER_LIBRARY
  global Lib_TypQrcTechFile
  global Lib_MaxQrcTechFile
  global Lib_TypCapTable
  global Lib_MaxCapTable
  global TYP_BOUNDARY_LOAD
  global BOUNDARY_LOAD_SCALE_FACTOR
  global MAX_CAPACITANCE
  global MAX_CAP_SCALE_FACTOR
  global TYP_OPERATING_CONDITION
  global DRIVE_CELL
  global DRIVE_PIN
  global DRIVE_PIN_FROM
  global MBIST_OUT_PORT
  global MBIST_IN_X_PORT
  global PSO_MODE
  global GENUS_WRITE_SPEF

  set GENERATE_NEW_LOADFILES 0
  set IN_X_CLK [dc::remove_from_collection [dc::remove_from_collection [all_inputs -design $TOP_DESIGN] $CLOCK_IN_PORT] $DEBUG_CLOCK_PORT] 
  set IN_X_CLK [dc::remove_from_collection $IN_X_CLK $MBIST_CLOCK_PORT]
  set OUT_X_CLK [dc::remove_from_collection [dc::remove_from_collection [all_outputs -design $TOP_DESIGN] $CLOCK_OUT_PORT] $MBIST_CLOCK_PORT]
  set_attribute operating_conditions _nominal_ [find / -library_domain timing]
  set_attribute library $Lib_CadenceTypLIB [find / -library_domain timing]
  if {$USE_POWER_LIBRARY == 1} {
    set_attribute library $Lib_CadenceTypLIB [find / -library_domain leakage]
  }
  if {($SOCV_DERATING_USED == 1) || ($SOCV_LIBS_DETECTED == 1)} {
    set_attribute socv_library $Lib_CadenceTypLIB [find / -library_domain timing]
    if {$USE_POWER_LIBRARY == 1} {
      set_attribute socv_library $Lib_CadenceTypLIB [find / -library_domain leakage]
    }
  }
  if {([llength $Lib_TypQrcTechFile] > 0) && ($Lib_MaxQrcTechFile ne $Lib_TypQrcTechFile)} {
    set_attribute qrc_tech_file $Lib_TypQrcTechFile /
    set GENERATE_NEW_LOADFILES 1
  } elseif {([llength $Lib_TypCapTable] > 0) && ($Lib_MaxCapTable ne $Lib_TypCapTable)} {
    set_attribute cap_table_file $Lib_TypCapTable /
    set GENERATE_NEW_LOADFILES 1
  }
  set TYP_BOUNDARY_LOAD_VALUE [get_attribute load [format "%s%s%s" [find [find / -library_domain timing] -libcell [basename [dirname $TYP_BOUNDARY_LOAD]]] "/" [basename $TYP_BOUNDARY_LOAD]]]
  if {[llength $TYP_BOUNDARY_LOAD] > 0} {
    set_attribute external_pin_cap [expr $BOUNDARY_LOAD_SCALE_FACTOR * $TYP_BOUNDARY_LOAD_VALUE] $OUT_X_CLK
    if {$MAX_CAPACITANCE > 0} {
      set_attribute max_capacitance $MAX_CAPACITANCE $TOP_DESIGN
    } elseif {$MAX_CAPACITANCE == 0} {
      set_attribute max_capacitance [expr $MAX_CAP_SCALE_FACTOR * $TYP_BOUNDARY_LOAD_VALUE] $IN_X_CLK
    }
  }
  if {[llength $TYP_OPERATING_CONDITION] > 0} {
    set_attribute operating_conditions $TYP_OPERATING_CONDITION [find / -library_domain timing]
  }
  set_attribute external_driver "" $IN_X_CLK
  set_attribute external_driver_from_pin "" $IN_X_CLK
  set DRIVE_CELL_SEARCH_VALUE [find [find / -library_domain timing] -libcell $DRIVE_CELL]
  set_attribute external_driver [find $DRIVE_CELL_SEARCH_VALUE -libpin $DRIVE_PIN] $IN_X_CLK
  set_attribute external_driver_from_pin [find $DRIVE_CELL_SEARCH_VALUE -libpin $DRIVE_PIN_FROM] $IN_X_CLK
  redirect /dev/null "eval report timing -num_paths 1 -worst 1 $PSO_MODE"
  eval write_sdc -no_split $PSO_MODE > [format "%s%s" $file_prefix {_syn.typ_sdc}]
  if {$GENERATE_NEW_LOADFILES == 1} {
    write_load_constraints > [format "%s%s" $file_prefix {_syn.typ_setload}]
    if {$GENUS_WRITE_SPEF == 1} {
      write_spef > [format "%s%s" $file_prefix {_syn.typ_spef.gz}]
    }
  }
}

proc TIP_listns {{parentns ::}} {
  set result [list]
  foreach ns [namespace children $parentns] {
    eval lappend result [TIP_listns $ns]
    lappend result $ns
  }
  return $result
}

proc TIP_floorplan_related_settings {args} {
  switch -- [parse_options "TIP_floorplan_related_settings" {} $args \
		"-force_def bos force use of DEF floorplan" \
		force_def \
		"-force_ratio bos force use of core_utilization and aspect_ratio" \
		force_ratio \
	    ] {
	       -2 { return }
		0 { error "Failed on TIP_floorplan_related_settings" }
	      }
  global GENUS_USE_ISPATIAL
  global FPLAN_FILE
  global TOP_DESIGN
  global MAX_PLACEMENT_DENSITY
  global Fplan_MaxRoutingLayer
  global Fplan_CoreUtilization
  global Fplan_AspectRatio
  global libcell_power_switches_present

  if {$force_def && $force_ratio} {
    puts [format "%s%s" "Err" "or   : this proc cannot use both force_def and force_ratio options simultaneously."]
    quit(1)
  }
  if {(($GENUS_USE_ISPATIAL == 1) || ($force_def)) && !($force_ratio)} {
    set_attribute read_def_fuzzy_name_match 1 /
    set_attribute find_fuzzy_match true /
    if {$libcell_power_switches_present == 1} {
      read_def -power_switch_insert -keep_filler_cells -keep_welltap_cells $FPLAN_FILE
    } else {
      read_def -keep_filler_cells -keep_welltap_cells $FPLAN_FILE
    }
    set_attribute read_def_fuzzy_name_match 0 /
    set_attribute find_fuzzy_match false /
    check_floorplan -detailed
  } else {
    set_attribute init_core_utilization $Fplan_CoreUtilization [find / -design $TOP_DESIGN]
    set_attribute aspect_ratio $Fplan_AspectRatio [find / -design $TOP_DESIGN]
  }
  set_attribute number_of_routing_layers $Fplan_MaxRoutingLayer /
# set_attribute utilization_threshold $MAX_PLACEMENT_DENSITY [find / -design $TOP_DESIGN]
}

proc TIP_set_preferred_and_dont_use_cells {} {
  global LIB_PREFER
  global LIB_DONT_USE

  foreach al $LIB_PREFER {
    foreach lc [find / -libcell $al] {
      set_attribute preserve false $lc
      set_attribute avoid false $lc
    }
  }
  foreach al $LIB_DONT_USE {
    foreach lc [find / -libcell $al] {
      set_attribute preserve true $lc
      set_attribute avoid true $lc
    }
  }
}

proc TIP_load_custom_ple {} {
  global GENUS_CUSTOM_PLE_FILE

  if {$GENUS_CUSTOM_PLE_FILE ne "_none_"} {
    if {![file exists $GENUS_CUSTOM_PLE_FILE]} {
      puts [format "%s%s%s" "Err" "or   : The following custom PLE model does not exist: " $GENUS_CUSTOM_PLE_FILE]
      quit(1)
    }
    decrypt $GENUS_CUSTOM_PLE_FILE
  }
}

proc TIP_load_saif_file {} {
  global LOW_POWER_STIM_FILE
  global TOP_DESIGN
  if {$LOW_POWER_STIM_FILE != [list]} {
    read_saif -instance "Testbench/$TOP_DESIGN" -verbose $LOW_POWER_SAIF_FILE
  }
}

proc TIP_prefanout_and_icg_control {} {
  global KEEP_PREFANOUT_FLOPS

  foreach dil [filter -invert libcell "" [find / -instance *]] {
    if {[llength [get_attribute clock_gating_integrated_cell [get_attribute libcell $dil]]] != 0} {
      set_attribute preserve const_prop_size_delete_ok $dil
    }
  }
  if {$KEEP_PREFANOUT_FLOPS == 1} {
    foreach pfi [find / -instance *_prefanout*] {
      foreach final_inst [filter flop true [find $pfi -instance instances_seq/*]] {
	set_attribute optimize_merge_seq false $final_inst
      }
    }
    foreach pfi [filter flop true [find / -instance *_prefanout*]] {
      set_attribute optimize_merge_seq false $pfi
    }
  }
}

proc TIP_lec_debug_checkpoint {args} {
  switch -- [parse_options "TIP_lec_debug_checkpoint" {} $args \
		"-netlist srs target output netlist with LEC features" \
		lec_netlist \
		"-db srs target output DB file" \
		lec_db \
		"-logfile srs target Conformal logfile name" \
		lec_logfile \
		"-golden srs golden design target" \
		lec_golden \
		"-revised srs revised design target" \
		lec_revised \
		"-dofile srs target Conformal dofile name" \
		lec_dofile \
	    ] {
	       -2 { return }
		0 {  error "Failed on TIP_lec_debug_checkpoint"}
	      }
  global LEC_NEQ_DEBUG
  global TOP_DESIGN

  if {$LEC_NEQ_DEBUG == 1} {
    eval write_hdl -lec > $lec_netlist
    TIP_output_db -override -db $lec_db
    eval write_do_lec -verbose -hier -logfile $lec_logfile -golden_design $lec_golden -revised_design $lec_revised > $lec_dofile
  }
}

proc TIP_prevent_mem_pin_inverter_push {} {
  set MACRO_INSTANCES [get_object_name [filter is_memory true [find / -inst *]]]
  foreach MM $MACRO_INSTANCES {
    set HPINS [get_pins -hierarchical $MM/*]
    foreach HP $HPINS {
      set_attribute boundary_optimize_invert_hpins false $HP
    }
  }
}

proc TIP_blackbox_local_memories {} {
  if {[sizeof_collection [find / -hdl_arch *sram*words*bits*]] != 0} {
    set_attribute blackbox true [find / -hdl_arch *sram*words*bits*]
  }
  set MACRO_INSTANCES [get_object_name [filter is_memory true [find / -inst *]]]
  foreach MM $MACRO_INSTANCES {
    set_attribute blackbox true $MM
  }
}

proc TIP_ungroup_cdns_special_modules {} {
  foreach dp_inst [find / -subdesign CDN_DP_*] {
    edit_netlist ungroup [get_attribute instances $dp_inst]
  }
  foreach rsp_inst [find / -subdesign [format "%s%s%s" "*" "retiming_state_point" "*"]] {
    edit_netlist ungroup [get_attribute instances $rsp_inst]
  }
  foreach lc_inst [find / -subdesign lowp_cg_*] {
    edit_netlist ungroup [get_attribute instances $lc_inst]
  }
  foreach mm_inst [find / -subdesign mux_model_*] {
    edit_netlist ungroup [get_attribute instances $mm_inst]
  }
}

proc TIP_generate_output_report_package {args} {
  switch -- [parse_options "TIP_generate_output_report_package" {} $args \
		"-file_prefix srs file name prefix for all reports: <prefix>_syn.<report_type>" \
		file_prefix \
	    ] {
	       -2 { return }
		0 { error "TIP_generate_output_report_package" }
	      }
  global QOR_SWITCH
  global GENUS_WRITE_SPEF
  global GENUS_USE_ISPATIAL
  global TOP_DESIGN
  global LOW_POWER_FLOW
  global LOW_POWER_GOAL
  global TOOL_VERSION
  global USE_MULTIBIT_CELLS
  global GENERATE_CG_REPORT

  report area > [format "%s%s" $file_prefix {_syn.area}]
  report gates > [format "%s%s" $file_prefix {_syn.ref}]
  eval report qor $QOR_SWITCH > [format "%s%s" $file_prefix {_syn.qor}]
  redirect [format "%s%s" $file_prefix {_syn.viol}] {report design_rules}
  report ple > [format "%s%s" $file_prefix {_syn.ple}]
  write_load_constraints > [format "%s%s" $file_prefix {_syn.setload}]
  report sequential -deleted_seqs > [format "%s%s" $file_prefix {_syn.seqopt}]
  report sequential -hier > [format "%s%s" $file_prefix {_syn.seq_unopt}]
  if {$GENUS_WRITE_SPEF == 1} {
    write_spef > [format "%s%s" $file_prefix {_syn.spef.gz}]
  }
  if {$GENUS_USE_ISPATIAL == 1} {
    write_def > [format "%s%s" $file_prefix {_syn.def}]
    report utilization > [format "%s%s" $file_prefix {_syn.util}]
    report congestion > [format "%s%s" $file_prefix {_syn.congest}]
    check_placement [find / -design $TOP_DESIGN] -verbose -file [format "%s%s" $file_prefix {_syn.placement_report}]
  }
  if {$GENERATE_CG_REPORT == 1} {
    if {($LOW_POWER_FLOW == 1) && (($LOW_POWER_GOAL == 3) || ($LOW_POWER_GOAL == 5))} {
      set CG_FILE_SUFFIX "_syn.rtl_and_tool_cg"
#     report operand_isolation > [format "%s%s" $file_prefix {_syn.tool_inserted_operand_isolation}]
    } else {
      set CG_FILE_SUFFIX "_syn.rtl_cg"
    }
    if {$TOOL_VERSION >= 22.12} {
      redirect [format "%s%s" $file_prefix $CG_FILE_SUFFIX] {report_clock_gates -include_timing}
      redirect -append [format "%s%s" $file_prefix $CG_FILE_SUFFIX] {report_clock_gates -sinks_histogram}
      redirect -append [format "%s%s" $file_prefix $CG_FILE_SUFFIX] {report_clock_gates -tree_view}
      redirect -append [format "%s%s" $file_prefix $CG_FILE_SUFFIX] {report_clock_gates -detail}
      redirect -append [format "%s%s" $file_prefix $CG_FILE_SUFFIX] {puts "Set of ungated flops in the design:"}
      foreach_in_collection RCG [report_clock_gates -get_sinks ungated] {
	redirect -append [format "%s%s" $file_prefix $CG_FILE_SUFFIX] {puts $RCG}
      }
    } else {
      report clock_gating > [format "%s%s" $file_prefix $CG_FILE_SUFFIX]
      report clock_gating -ungated_ff >> [format "%s%s" $file_prefix $CG_FILE_SUFFIX]
      report clock_gating -gated_ff >> [format "%s%s" $file_prefix $CG_FILE_SUFFIX]
      report clock_gating -multi_stage_count_from_root >> [format "%s%s" $file_prefix $CG_FILE_SUFFIX]
      report clock_gating -multi_stage_tree_view >> [format "%s%s" $file_prefix $CG_FILE_SUFFIX]
    }
  }
  if {$USE_MULTIBIT_CELLS == 1} {
    report multibit_inferencing -lib > [format "%s%s" $file_prefix {_syn.multibit}]
    report multibit_inferencing -no_header >> [format "%s%s" $file_prefix {_syn.multibit}]
    report multibit_inferencing -no_header -not_merged_summary >> [format "%s%s" $file_prefix {_syn.multibit}]
    report multibit_inferencing -no_header -not_merged_instance_list >> [format "%s%s" $file_prefix {_syn.multibit}]
  }
}

proc TIP_generate_timing_report {args} {
  switch -- [parse_options "TIP_generate_timing_report" {} $args \
		"-file_prefix srs file name prefix for timing report: <prefix>_syn.timing" \
		file_prefix \
	    ] {
	       -2 { return }
		0 { error "TIP_generate_timing_report" }
	      }
  global REPORT_COST_GROUPS
  global GENUS_USE_ISPATIAL
  global GENUS_DERATE_METHOD
  global GENUS_NUM_PATHS
  global PSO_MODE

  redirect [format "%s%s" $file_prefix {_syn.timing}] {puts [list]}
  foreach cg $REPORT_COST_GROUPS {
    if {($GENUS_USE_ISPATIAL == 1) && ($GENUS_DERATE_METHOD != 0)} {
      redirect -append [format "%s%s" $file_prefix {_syn.timing}] "eval report timing -num_paths $GENUS_NUM_PATHS -worst 10 -cost_group $cg -physical -user_derate -incr_derate $PSO_MODE"
    } elseif {($GENUS_USE_ISPATIAL == 0) && ($GENUS_DERATE_METHOD != 0)} {
      redirect -append [format "%s%s" $file_prefix {_syn.timing}] "eval report timing -num_paths $GENUS_NUM_PATHS -worst 10 -cost_group $cg -user_derate -incr_derate $PSO_MODE"
    } elseif {$GENUS_USE_ISPATIAL == 1} {
      redirect -append [format "%s%s" $file_prefix {_syn.timing}] "eval report timing -num_paths $GENUS_NUM_PATHS -worst 10 -cost_group $cg -physical $PSO_MODE"
    } else {
      redirect -append [format "%s%s" $file_prefix {_syn.timing}] "eval report timing -num_paths $GENUS_NUM_PATHS -worst 10 -cost_group $cg $PSO_MODE"
    }
  }
}

proc TIP_generate_dft_report_package {args} {
  switch -- [parse_options "TIP_generate_dft_report_package" {} $args \
		"-file_prefix srs file name prefix for all DFT reports: <prefix>_syn.<report_type>" \
		file_prefix \
	    ] {
	       -2 { return }
		0 { error "TIP_generate_dft_report_package" }
	      }
  global TOP_DESIGN
  global RUN_ATPG
  global VERILOG_SIM_LIB

  redirect /dev/null {create_chains_database -design [find / -design $TOP_DESIGN]}
  report_chains_total_wirelength -sort total
  report dft_chains [find / -design $TOP_DESIGN] > [format "%s%s" $file_prefix {_syn.scanchains}]
  write_scandef -version 5.5 > [format "%s%s" $file_prefix {_syn.scandef}]
  write_atpg -stil > TetraMAX_protocol.spf
  write_dft_abstract_model > [format "%s%s" $file_prefix {_syn.scan_abst_model}]
  if {$RUN_ATPG == 1} {
    redirect [format "%s%s" $file_prefix {_syn.test_coverage}] {analyze_testability -directory et_work_dir -effort high -fault_sample_size -1 -library $VERILOG_SIM_LIB}
#   write_dft_atpg -directory et_work_dir -effort high -force -library $VERILOG_SIM_LIB
  }
}

proc TIP_unique_macro_cell_locator {args} {
  switch -- [parse_options "TIP_unique_macro_cell_locator" {} $args \
		"-file_prefix srs file name prefix for memory macro report: <prefix>_syn.memory_macro_list" \
		file_prefix \
		"-macro_var srs unique macro cells global variable" \
		macro_var \
	    ] {
	       -2 { return }
		0 { error "TIP_unique_macro_cell_locator" }
	      }
  upvar #0 $macro_var local_unique_cell_list

  foreach dil [filter -invert libcell "" [find / -instance *]] {
    set local_libcell_path [get_attribute libcell $dil]
    set libcell_path_basename [basename $local_libcell_path]
    if {([get_attribute memory $local_libcell_path] eq "true") && ([get_attribute is_macro_cell $local_libcell_path] eq "true")} {
      lappend local_unique_cell_list $libcell_path_basename
    }
  }
  set local_unique_cell_list [lsort -unique $local_unique_cell_list]
  if {[llength $local_unique_cell_list] != 0} {
    redirect [format "%s%s" $file_prefix {_syn.memory_macro_list}] {puts [format "%s%s%s" "set UNIQUE_MACRO_CELLS {" $local_unique_cell_list "}"]}
  } else {
    redirect [format "%s%s" $file_prefix {_syn.memory_macro_list}] {puts "set UNIQUE_MACRO_CELLS \[list\]"}
  }
}

proc TIP_mem_macro_checker {args} {
  switch -- [parse_options "TIP_mem_macro_checker" {} $args \
		"-global_macro_var srs unique macro cells global variable" \
		global_macro_var \
		"-global_mdl_var srs memory design list global variable" \
		global_mdl_var \
	    ] {
	       -2 { return }
		0 { error "TIP_mem_macro_checker" }
	      }
  upvar #0 $global_macro_var local_macro_var
  upvar #0 $global_mdl_var local_mdl_var
  global TOP_DESIGN

  elaborate
  set MEM_MACRO_LIST [find / -invert /designs/$TOP_DESIGN -design *]
  foreach MM $MEM_MACRO_LIST {
    lappend local_mdl_var [basename $MM]
    cd $MM
    if {[llength [find ./ -instance *placeholder*]] != 0} {
      puts [format "%s%s%s%s" "Err" "or   : Incorrectly instantiated memory hard macro in " $MM " - placeholder still present in instance name"]
      quit(1)
    }
    set MACRO_INSTANCES [list]
    foreach MI [find ./ -instance *] {
      if {[llength [get_attribute libcell $MI]] != 0} {
	if {([get_attribute memory [get_attribute libcell $MI]] eq "true") && ([get_attribute is_macro_cell [get_attribute libcell $MI]] eq "true")} {
	  lappend MACRO_INSTANCES $MI
	}
      }
    }
    if {[llength $MACRO_INSTANCES] == 0} {
      puts [format "%s%s%s%s" "Err" "or   : The " $MM " instance is empty - at least one memory hard macro needs to be instantiated per local memory"]
      quit(1)
    }
    foreach MI $MACRO_INSTANCES {
      set_attribute preserve false [get_attribute libcell $MI]
      set_attribute avoid false [get_attribute libcell $MI]
      lappend local_macro_var [basename [get_attribute libcell $MI]]
    }
    cd
    rm $MM
  }
  set local_macro_var [lsort -unique $local_macro_var]
  if {[llength [find / -design *]] != 0} {
    rm [find / -design *]
  }
}

proc TIP_hard_macro_checker {} {
  read_hdl custom_macro.sv
  elaborate
  set MACRO_LIST [find / -design *]
  set CORRECT_MACRO 0
  foreach macro_design $MACRO_LIST {
    if {[regexp {gated.*clock} [basename $macro_design] match]} {
      set CORRECT_MACRO 1
    }
    cd $macro_design
    set M_REF [find ./ -subdesign [format "%s%s" [basename $macro_design] "_macro"]]
    if {[llength $M_REF] != 0} {
      puts [format "%s%s" "Err" "or   : unmodified design in custom_macro.sv"]
      puts [format "%s%s%s" "Err" "or   : either instantiate a macro or comment out design " [basename $macro_design]]
      quit(1)
    }
    cd
    rm $macro_design
  }
  if {$CORRECT_MACRO == 0} {
    puts [format "%s%s" "Err" "or   : custom_macro.sv must replace the *gated*clock module for this configuration"]
    quit(1)
  }
}

proc TIP_load_additional_sdc_cons {args} {
  switch -- [parse_options "TIP_load_additional_sdc_cons" {} $args \
		"-sdc_file srs name of additional input SDC file" \
		sdc_file \
	    ] {
	       -2 { return }
		0 { error "Failed on TIP_load_additional_sdc_cons" }
	      }

  if {$sdc_file ne "_none_"} {
    if {![file readable $sdc_file]} {
      puts [format "%s%s%s" "Err" "or   : The following file of additional SDC constraints is not readable: " $sdc_file]
      quit(1)
    }
    read_sdc -stop_on_errors -echo -verbose $sdc_file
  }
}

proc TIP_generate_precompile_sdc {} {
  global GENERATE_PRECOMPILE_SDC
  global PSO_MODE
  global TOP_DESIGN

  if {$GENERATE_PRECOMPILE_SDC == 1} {
    eval write_sdc -no_split $PSO_MODE > [format "%s%s" $TOP_DESIGN {_precompile_full_constraints.sdc.gz}]
  }
}

proc TIP_remove_ideal_dft_port_settings {} {
  global TESTMODE
  global TESTMODE_OVERRIDE

  set SCAN_ENABLE_PORT [find / -port ports_in/test_se]
  if {$SCAN_ENABLE_PORT != [list]} {
#   reset_attribute timing_case_logic_value $SCAN_ENABLE_PORT
#   reset_attribute timing_case_logic_value_by_mode $SCAN_ENABLE_PORT
    dc::remove_ideal_network $SCAN_ENABLE_PORT
  }
  set TMODE_PORT [find / -port ports_in/$TESTMODE]
  if {$TMODE_PORT != [list]} {
#   reset_attribute timing_case_logic_value $TMODE_PORT
#   reset_attribute timing_case_logic_value_by_mode $TMODE_PORT
    dc::remove_ideal_network $TMODE_PORT
  }
  set OVERRIDE_PORT [find / -port ports_in/$TESTMODE_OVERRIDE]
  if {$OVERRIDE_PORT != [list]} {
#   reset_attribute timing_case_logic_value $OVERRIDE_PORT
#   reset_attribute timing_case_logic_value_by_mode $OVERRIDE_PORT
    dc::remove_ideal_network $OVERRIDE_PORT
  }
}

proc TIP_remove_ocv_derates {} {
  global GENUS_DERATE_METHOD
  global TOP_DESIGN

  if {$GENUS_DERATE_METHOD != 0} {
    phys_reset_ocv -design [find / -design $TOP_DESIGN]
    reset_timing_derate [find / -design $TOP_DESIGN]
    reset_timing_derate [find / -instance *]
  }
}

proc TIP_generate_flat_netlist {args} {
  switch -- [parse_options "TIP_generate_flat_netlist" {} $args \
		"-file_prefix srs file name prefix for flattened netlist: <prefix>_syn_flattened.v" \
		file_prefix \
	    ] {
	       -2 { return }
		0 { error "TIP_generate_flat_netlist" }
	      }
  global GEN_FLAT_NETLIST

  if {$GEN_FLAT_NETLIST == 1} {
    foreach subd [find / -subdesign *] {
      set_attribute ungroup_ok true $subd
    }
    ungroup -flatten -all -force
    change_names -verilog -max_length 500
    write_hdl > [format "%s%s" $file_prefix {_syn_flattened.v}]
  }
}

proc TIP_superthreading_setup {} {
  global SUPERTHREAD_COUNT

  if {$SUPERTHREAD_COUNT > 1} {
    set_attribute max_cpus_per_server $SUPERTHREAD_COUNT /
    set_attribute invs_cpu_usage $SUPERTHREAD_COUNT /
    set_attribute wlec_parallel_threads $SUPERTHREAD_COUNT /
    set_attribute auto_super_thread true /
  } else {
    set_attribute max_cpus_per_server 1 /
    set_attribute invs_cpu_usage 1 /
    set_attribute wlec_parallel_threads 1 /
    set_attribute auto_super_thread false /
  }
}

proc TIP_mixed_height_library_controls {args} {
  switch -- [parse_options "TIP_mixed_height_library_controls" {} $args \
		"-apply_settings bos apply all root-level mixed-height attribute settings" \
		apply_settings \
		"-max_util bos apply hybrid-row max utilization on the top design" \
		max_util \
		"-pct_cntrl bos apply post-map percent control balance on the top design" \
		pct_cntrl \
		"-short_tall_cntrl bos apply short-tall control command" \
		short_tall_cntrl \
		"-gen_report bos generate a detailed short-tall report" \
		gen_report \
		"-file_prefix sos prefix of detailed short-tall report output file" \
		file_prefix \
	    ] {
	       -2 { return }
		0 { error "TIP_mixed_height_library_controls" }
	      }
  global TOP_DESIGN
  global LIB_MH_LIBRARY
  global LIB_MH_SHORT_HEIGHT
  global LIB_MH_TALL_HEIGHT
  global LIB_MH_DOUBLE_HEIGHT

  if {$LIB_MH_LIBRARY == 1} {
    if {($LIB_MH_TALL_HEIGHT > 0) && ($LIB_MH_TALL_HEIGHT < $LIB_MH_SHORT_HEIGHT)} {
      puts [format "%s%s" "Err" "or   : The value of Lib_MHTallCellHeight must be greater than the value of Lib_MHShortCellHeight"]
      quit(1)
    }
    if {($LIB_MH_DOUBLE_HEIGHT > 0) && ($LIB_MH_DOUBLE_HEIGHT < $LIB_MH_TALL_HEIGHT)} {
      puts [format "%s%s" "Err" "or   : The value of Lib_MHDoubleCellHeight must be greater than the value of Lib_MHTallCellHeight"]
      quit(1)
    }
    if {$apply_settings} {
      if {$LIB_MH_SHORT_HEIGHT > 0} {
	set_attribute short_cell_height $LIB_MH_SHORT_HEIGHT /
      }
      if {$LIB_MH_TALL_HEIGHT > 0} {
	set_attribute tall_cell_height $LIB_MH_TALL_HEIGHT /
      }
      if {$LIB_MH_DOUBLE_HEIGHT > 0} {
	set_attribute double_cell_height $LIB_MH_DOUBLE_HEIGHT /
      }
      if {($LIB_MH_SHORT_HEIGHT > 0) && ($LIB_MH_TALL_HEIGHT > 0)} {
#	set_attribute route_early_global_n3_row_height [format "%.3f" [expr (($LIB_MH_SHORT_HEIGHT + $LIB_MH_TALL_HEIGHT) / 2)]] /
      }
      set_attribute enhanced_percent_control true /
      set_attribute target_tall_percent 50.0 /
      set_attribute pbs_map_distributed_percent_control_balance true /
      set_attribute pbs_map_percent_control_balance true /
      set_attribute density_aware_balancing_enabled true /
      set_attribute enable_mask_shift_check_errors true /
    }
    if {$max_util} {
      set_attribute phys_hybrid_row_max_utilization 0.85 [find / -design $TOP_DESIGN]
    }
    if {$pct_cntrl} {
      pbs::post_map_percent_control_balance [find / -design $TOP_DESIGN]
    }
    if {$short_tall_cntrl} {
      apply_short_tall_control
    }
    if {$gen_report} {
      redirect [format "%s%s" $file_prefix "_mixed_height_cell_report.txt"] {report_short_tall -detailed}
    }
  }
}

proc TIP_global_message_control {} {
  set_attribute max_print infinity [find / -message CDFG-508]
  set_attribute max_print infinity [find / -message CDFG2G-615]
  set_attribute max_print infinity [find / -message CDFG2G-616]
  set_attribute severity Error [find / -message CDFG-417]
  set_attribute severity Error [find / -message CDFG-464]
  set_attribute severity Error [find / -message CDFG-465]
  set_attribute severity Error [find / -message CDFG-467]
  set_attribute severity Error [find / -message CDFG-562]
  set_attribute severity Error [find / -message DFT-302]
  set_attribute severity Error [find / -message ELABUTL-125]
  set_attribute severity Error [find / -message PHYS-360]
  set_attribute severity Error [find / -message VLOGPT-650]
  suppress_messages {TUI-58 TUI-59 RETIME-402 LBR-30 LBR-31 LBR-72 LBR-77 LBR-155 LBR-162 LBR-170 LBR-201 PHYS-106 PHYS-109 RPT_CG-12 CDFG-738 CDFG-739 DFT-515 GLO-28}
}

proc TIP_restructure_clock_tree {} {
  global LOW_POWER_FLOW
  global LOW_POWER_GOAL

  if {($LOW_POWER_FLOW == 1) && (($LOW_POWER_GOAL == 3) || ($LOW_POWER_GOAL == 5))} {
    clock_gating declone -hier
    clock_gating rebalance -strict_min_flop_constraint -hierarchical
    clock_gating split -hier -max_level 2
  }
}

