proc CETFE_append_details_to_report {args} {
  switch -- [parse_options "CETFE_append_details_to_report" {} $args \
		"-report_type srs type of report: either odc or lg or stbs or stbc or rst" \
		  report_type \
		"-file_name srs name of input file to which details are appended" \
		  file_name
	    ] {
	       -2 { return }
		0 { error "Failed on CETFE_append_details_to_report" }
	      }

  if {[file exists $file_name]} {
    set loop_counter 0
    set loc_fp [open $file_name]
    while {([gets $loc_fp line] != -1) && ($loop_counter < 900)} {
      set odc_id [lindex $line 0]
      incr loop_counter
      if {$report_type eq "odc"} {
	if {[regexp {ODC_B} $odc_id]} {
	  report_odc -append -out temp.txt -id $odc_id -show_details -expand_to_signals -max_expr_print_length 10000
	}
      } elseif {$report_type eq "stbs"} {
	if {[regexp {STB_B} $odc_id]} {
	  report_stb -append -out temp.txt -id $odc_id -max_expr_print_length 10000
	}
      } elseif {$report_type eq "stbc"} {
	if {[regexp {STB_C} $odc_id]} {
	  report_stb -append -out temp.txt -id $odc_id -max_expr_print_length 10000 -const_based -detail_rtl
	}
      }
    }
    if {[file exists temp.txt]} {
      sh cat temp.txt >> $file_name
      sh rm temp.txt
    }
    if {$loop_counter == 900} {
      puts [format "%s%s%s%s%s" "Warn" "ing : loop counter hit for report type " $report_type " for file " $file_name]
    }
  } else {
    puts [format "%s%s%s" "Err" "or   : Input file does not exist: " $file_name]
  }
}

proc CETFE_local_odc_reporting {args} {
  switch -- [parse_options "CETFE_local_odc_reporting" {} $args \
		"-report_type srs type of report: either odc or lg or stbs or stbc or rst" \
		  report_type \
		"-input_type srs type of simulation: vectorless or simulation" \
		  input_type \
		"-stim_path sos absolute file path to input stimulus; used only for simulation input type" \
		  stim_path \
		"-stim_type sos file type of input stimulus: either vcd or fsdb or shm; used only for simulation input type" \
		  stim_type \
		"-file_name srs name of output file" \
		  file_name \
		"-delete_vector bos clear all stimulus from system memory; used only for simulation input type" \
		  delete_vector
       	    ] {
	       -2 { return }
		0 { error "Failed on CETFE_local_odc_reporting" }
	      }
  
  global path_to_dut
  global REM_ODC_VARS
  global REM_LOGIC_GATING_VARS
  global REM_STB_VARS
  
  if {$input_type eq "simulation"} {
    set dut_instance $path_to_dut
  }

  set local_file_name $file_name
  if {$input_type eq "simulation"} {
    read_stimulus -file $stim_path -format $stim_type -dut_instance $dut_instance -scrub_prep -resim_cg_enables
    propagate_activity -scale_to_sdc_frequency -stim [get_sdb_stims]
  }
  if {$report_type eq "odc"} {
    report_odc -min_reg_width 8 -summary -detail -out $local_file_name
    eval report_odc -append -out $local_file_name $REM_ODC_VARS
    CETFE_append_details_to_report -report_type odc -file_name $local_file_name
  } elseif {$report_type eq "lg"} {
    report_logic_gating -summary -out $local_file_name
    eval report_logic_gating -append -out $local_file_name $REM_LOGIC_GATING_VARS
  } elseif {$report_type eq "stbs"} {
    report_stb -min_reg_width 8 -summary -detail -out $local_file_name
    if {$input_type eq "simulation"} {
      redirect /dev/null {report_stb -show_power_details}
    }
    eval report_stb -append -out $local_file_name $REM_STB_VARS
    CETFE_append_details_to_report -report_type stbs -file_name $local_file_name
  } elseif {$report_type eq "stbc"} {
    report_stb -const_based -min_reg_width 8 -summary -detail -out $local_file_name
    if {$input_type eq "simulation"} {
      redirect /dev/null {report_stb -const_based -show_power_details}
    }
    eval report_stb -const_based -append -out $local_file_name $REM_STB_VARS
    CETFE_append_details_to_report -report_type stbc -file_name $local_file_name
  } elseif {$report_type eq "rst"} {
    report_redundant_resets -summary -out $local_file_name
    report_redundant_resets -append -out $local_file_name
  } else {
    puts [format "%s%s%s" "Err" "or   : Unsupported report type: " $report_type]
    quit(1)
  }
  if {($input_type eq "simulation") && $delete_vector} {
    delete_sdb
  }
}


proc CETFE_filter_clock_gate_report {args} {
  switch -- [parse_options "CETFE_filter_clock_gate_report" {} $args \
                "-clock_gate_rpt srs path of clock gate report" \
                  clock_gate_rpt \
                "-data_gate_rpt srs path of data gate report" \
                  data_gate_rpt \
                "-output_dir srs path to output directory" \
		  output_dir
            ] {
               -2 { return }
                0 { error "CETFE_filter_clock_gate_report" }
              }

  set clk_eff_rpt [open $clock_gate_rpt r]
  set seq_power_rpt [open $data_gate_rpt r]
  
  set lines [split [read $clk_eff_rpt] "\n"]
  close $clk_eff_rpt
  
  set lines_seq_power [split [read $seq_power_rpt] "\n"]
  close $seq_power_rpt
  
  set out_rpt_clock_eff [open $clock_gate_rpt w+]
  set out_rpt_ungated_flops [open "$output_dir/ungated_flops.rpt" w+]
  set out_rpt_dg_eff [open $data_gate_rpt w+]
  
  
  foreach line $lines {
    if {[ regexp {^\s+[0-9].*} $line ]} {
      if {([format "%.2f" [lindex $line 7]] == "100")} {
        puts $out_rpt_ungated_flops $line
      } elseif {([format "%.2f" [lindex $line 12]] < 50) && ([format "%.2f" [lindex $line 13]] < 50) } {
        puts $out_rpt_clock_eff $line
      }
      
    } else {
      puts $out_rpt_clock_eff $line
      puts $out_rpt_ungated_flops $line
    }
  }
  
  set max_clock_toggle 0
  
  foreach line $lines_seq_power {
    if {[ regexp {^\s+[0-9].*} $line ]} {
      set clock_toggle [lindex $line 10]
      if {[format "%.2f" $clock_toggle] > $max_clock_toggle} {
        set max_clock_toggle [format "%.2f" $clock_toggle]
      }
    }
  }
  
  
  puts $max_clock_toggle
  
  foreach line $lines_seq_power {
    if {[ regexp {^\s+[0-9].*} $line ]} {
      if {([format "%.2f" [lindex $line 7]] != "100")} {
        if {([format "%.2f" [lindex $line 11]] > 90) && ([format "%.2f" [lindex $line 13]] > 90) && ([format "%.2f" [lindex $line 10]] < [expr 0.1 * $max_clock_toggle])} {
          puts $out_rpt_dg_eff $line
        }
      }
    } else {
      puts $out_rpt_dg_eff $line
    }
  }
  close $out_rpt_clock_eff
  close $out_rpt_ungated_flops
  close $out_rpt_dg_eff

}

proc CETFE_detail_path_depth {args} {
  switch -- [parse_options "CETFE_detail_path_depth" {} $args \
                "-path_report srs path to joules generated path depth report" \
                  path_report \
                "-path_detail_report srs path to output report" \
		  path_detail_report
            ] {
               -2 { return }
                0 { error "CETFE_detail_path_depth" }
              }

  set inst_rpt [open $path_report r]
  set lines [split [read $inst_rpt] "\n"]
  close $inst_rpt; 
  set formatStr {%-90s%-90s%-5s}
  set out_rpt [open $path_detail_report w+]  
  puts $out_rpt "Detailed Depth Report\n"
  puts $out_rpt "The top worst 25 paths are being reported for each starting point in the order of worst depth\n\n"
  
  #Get list of lines with data
  set lines_data_fanout {}
  set lines_data_fanin {}
  set data_list_type lines_data_fanout
  foreach line $lines {
    if {[ regexp {^\s+[0-9].*} $line ]} {
      puts "appending line $line"	  
      lappend $data_list_type $line	  
    }
    if {[ regexp {^Startpoint_Count} $line ]} {
      puts "switching data list"
      set data_list_type lines_data_fanin
    }  
  }
  
  set lines_data_list {}
  lappend lines_data_list $lines_data_fanout
  lappend lines_data_list $lines_data_fanin
  
  
  #Sort the list according to path depth
  #Sorting is done for instances less than 1000 dues to exponential time complexity
  set lines_data_sorted {}
  foreach lines_data $lines_data_list {
    if {[llength $lines_data] < 1000} {
      for {set i 0} {$i < [llength $lines_data]} {incr i} {
        for {set j 0} {$j < [expr [llength $lines_data]-$i-1]} {incr j} {
          set next_index [expr $j+1]
    	  
          set curr_match [regexp -all -inline {^\s+\d+\s+(\d+)} [lindex $lines_data $j]]
          set curr_depth [lindex $curr_match 1]
    
          set next_match [regexp -all -inline {^\s+\d+\s+(\d+)} [lindex $lines_data $next_index]]
          set next_depth [lindex $next_match 1]
    
          if {$curr_depth < $next_depth} {
            set temp [lindex $lines_data $j]
            set lines_data [lreplace $lines_data $j $j [lindex $lines_data $next_index]]
            set lines_data [lreplace $lines_data $next_index $next_index $temp]
          }
        }
      }
    lappend lines_data_sorted $lines_data    
    } else {
    lappend lines_data_sorted $lines_data  
    }
  }
  
  
  #print worst 25 timing paths start and end points for each instance
  set number_of_paths 25
  for {set j 0} {$j < 2} {incr j} {
    set lines_data [lindex $lines_data_sorted $j]
    if {$j == 0 } {
      puts $out_rpt "[string repeat # 190]"
      puts $out_rpt "Fanout report\n"
      puts $out_rpt "[string repeat # 190]"
    } else {
      puts $out_rpt "[string repeat # 190]"
      puts $out_rpt "Fanin report\n"
      puts $out_rpt "[string repeat # 190]"
    }
    
    foreach line $lines_data {
      set depth_mismatch 0
      set instance [lindex $line 3]
      if {$j == 0 } {	  
        set timing_collection [report_timing -from inst:$instance -begin_end_pair -collection]
      } else {
        set timing_collection [report_timing -to inst:$instance -begin_end_pair -collection]
      }
  
      if {[llength $timing_collection] != 0} {
        foreach_in_collection timing_path_unique $timing_collection {
          set Size [sizeof_collection [get_db $timing_path_unique .timing_points]]
          set logic_depth [expr $Size/2]
          if {$logic_depth != [format "%.2f" [lindex $line 1]]} {
            set depth_mismatch 1
          } 
        }
      } else {
	set depth_mismatch 1
      }
      if {$depth_mismatch == 1} {
        continue
      }
  
      puts $out_rpt "\nInstance through $instance" 
      puts $out_rpt [format $formatStr "Start_Point" "End_Point" "Total_Depth"]
      puts $line
      set through_reported_list {}
      for {set i 0} {$i < $number_of_paths} {incr i} {
        if {$i == 0} {
          if {$j == 0 } {
            set timing_collection [report_timing -from inst:$instance -begin_end_pair -collection]
          } else {
            set timing_collection [report_timing -to inst:$instance -begin_end_pair -collection]
          }
          puts "entering zero loop"
        } else {
          if {$j == 0 } {
            set timing_collection [report_timing -from inst:$instance -begin_end_pair -collection -not_through $through_reported_list ] 
          } else {
            set timing_collection [report_timing -to inst:$instance -begin_end_pair -collection -not_through $through_reported_list ]
          }
        
        }
        
        foreach_in_collection timing_path_unique $timing_collection {
          puts "entering timing_collection loop"
          puts "$timing_path_unique"
          set start_point [get_db $timing_path_unique .launching_point]
          set end_point [get_db $timing_path_unique .capturing_point]
          set Size [sizeof_collection [get_db $timing_path_unique .timing_points]]
          set logic_depth [expr $Size/2]
          puts $out_rpt [format $formatStr $start_point $end_point $logic_depth]
          if {$j == 0 } {
            lappend through_reported_list [get_db $timing_path_unique .capturing_point]
          } else {
            lappend through_reported_list [get_db $timing_path_unique .launching_point]
          }
          puts "printing through reported list\n"
          puts "$through_reported_list\n"
        }
      }
      puts $out_rpt "[string repeat - 190]"
    }
  }
  
  close $out_rpt

}

proc CETFE_sort_reg_cone {args} {
  switch -- [parse_options "CETFE_sort_reg_cone" {} $args \
                "-reg_cone_report srs path to joules generated path depth report" \
                  reg_cone_report \
                "-reg_cone_sorted_report srs path to output report" \
		  reg_cone_sorted_report
            ] {
               -2 { return }
                0 { error "CETFE_sort_reg_cone" }
              }


  set reg_cone_rpt [open $reg_cone_report r]
  set lines [split [read $reg_cone_rpt] "\n"]
  close $reg_cone_rpt;
  
  set formatStr {%-10s%-10s%-10s%-100s%-20s%-20s}
  set out_rpt [open $reg_cone_sorted_report w+]
  puts $out_rpt "Detailed Fanin Fanout Report\n"
  puts $out_rpt "The top worst 5000 registers are being reported with their fanin, fanout and product\n\n"
  
  set lines_data {}
  foreach line $lines {
    if {[ regexp {^[0-9].*} $line ]} {
      lappend lines_data $line  
    }
  }
  
  set lines_data_sorted {}
  for {set i 0} {$i < [llength $lines_data]} {incr i} {
    for {set j 0} {$j < [expr [llength $lines_data]-$i-1]} {incr j} {
      set next_index [expr $j+1]
      set curr_line [lindex $lines_data $j]
      set curr_fanin [lindex $curr_line 0]
      set curr_fanout [lindex $curr_line 1]
      set curr_prod [expr $curr_fanin * $curr_fanout]
  
      set next_line [lindex $lines_data $next_index]
      set next_fanin [lindex $next_line 0]
      set next_fanout [lindex $next_line 1]
      set next_prod [expr $next_fanin * $next_fanout]
  
      if {$curr_prod < $next_prod} {
        set temp [lindex $lines_data $j]
        set lines_data [lreplace $lines_data $j $j [lindex $lines_data $next_index]]
        set lines_data [lreplace $lines_data $next_index $next_index $temp]
      }
    }
  }
  
  puts $out_rpt "[string repeat - 188]"
  puts $out_rpt [format $formatStr Fanin Fanout Product Register Fanin_Path_Depth Fanout_Path_Depth]
  puts $out_rpt "[string repeat - 188]"
  foreach line $lines_data {
    set instance_name [lindex $line 4]
    set timing_from [report_timing -from $instance_name -begin_end_pair -collection] 
    set timing_to [report_timing -to $instance_name -begin_end_pair -collection]
    set Size_from [sizeof_collection [get_db $timing_from .timing_points]]
    set Size_to [sizeof_collection [get_db $timing_to .timing_points]]
    set logic_depth_from [expr $Size_from/2]
    set logic_depth_to [expr $Size_to/2]

    set prod_fan [expr [lindex $line 0] * [lindex $line 1]]
    puts $out_rpt [format $formatStr [lindex $line 0] [lindex $line 1] $prod_fan [lindex $line 4] $logic_depth_from $logic_depth_to]
  }
  close $out_rpt
}

proc CETFE_lint_timing_and_combo_loops {args} {
  switch -- [parse_options "CETFE_lint_timing_and_combo_loops" {} $args \
		   "-file_path srs combo loop file path" \
		   outfile_path \
		   ] {
		      -2 { return }
		       0 { error "Failed on CETFE_lint_timing_and_combo_loops" }
	    	   }

  check_timing_intent
  set combo_loop_exists [check_design -combo_loop]

  if {$combo_loop_exists == 1} {
    puts [format "%s%s" "Warning   : combinational loops detected - see " $outfile_path]
    report_loop > $outfile_path
  }
  
  set combo_loops [get_db -if {.preserve_for_cb==true} hnets]
  
  if {[llength $combo_loops] != 0} {
    set out_rpt [open $outfile_path a+]
    puts $out_rpt "[string repeat # 190]"
    puts $out_rpt "List of Nets preserved to add combinational loop breakers"
    puts $out_rpt "[string repeat # 190]"

    puts [format "%s%s" "Warning   : combinational loops detected - see " $outfile_path]
    foreach combo_loop $combo_loops {
      puts $out_rpt "$combo_loop"
    }
   
    close $out_rpt
  }
  if {[llength $combo_loops] == 0 && $combo_loop_exists == 0} {
    set out_rpt [open $outfile_path a+]
    puts $out_rpt "No combo loops to report"
    close $out_rpt
  }

}

proc CETFE_find_icg_cells {} {
  set icg_cells {}
  foreach element [vfind ./ -inst -hinst *] {
    set lib_cell [get_db [vfind $element] .libcell]
    if {[llength $lib_cell] && [llength [get_db [vfind $lib_cell] .clock_gating_integrated_cell]]} {
      lappend icg_cells $element
    }
  }
  return $icg_cells
}

proc CETFE_find_icg_enable_pins {args} {
  switch -- [parse_options "CETFE_find_icg_enable_pins" {} $args \
		   "-clk_pins bos list clock pins instead" \
		   clk_pins \
		   "-output_pins bos list output pins instead" \
		   output_pins \
		   "-source_clk srs name of source clock" \
		   source_clk
	    ] {
	       -2 { return }
		0 { error "Failed on CETFE_find_icg_enable_pins"}
	      }
  set icg_enable_pins {}
  set icg_clock_pins {}
  set icg_output_pins {}
  set icg_cells [CETFE_find_icg_cells]
  set clock_port {}
  if {[llength [vfind / -clock $source_clk]] != 0} {
    set clock_port [concat [get_db [vfind / -clock $source_clk] .inverted_sources] [get_db [vfind / -clock $source_clk] .non_inverted_sources]]
  }
  foreach element $icg_cells {
    set lib_cell [get_db [vfind $element] .libcell]
    set lib_cell_pins [vfind $lib_cell -lib_pin *]
    set lib_cell_enable_pin [vbasename [get_db $lib_cell_pins -if {.clock_gate_enable_pin == true}]]
    set lib_cell_clock_pin [vbasename [get_db $lib_cell_pins -if {.clock_gate_clock_pin == true}]]
    set lib_cell_output_pin [vbasename [get_db $lib_cell_pins -if {.clock_gate_out_pin == true}]]
    set element_enable_pin [vfind $element -pin -hpin $lib_cell_enable_pin]
    set element_clock_pin [vfind $element -pin -hpin $lib_cell_clock_pin]
    set element_output_pin [vfind $element -pin -hpin $lib_cell_output_pin]
    set possible_root_clock_ports [get_fanin -structural -startpoints $element_clock_pin]
    set clock_port_match 0
    foreach cp $clock_port {
      if {[llength [::legacy::filter name [vbasename $cp] $possible_root_clock_ports]] != 0} {
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


