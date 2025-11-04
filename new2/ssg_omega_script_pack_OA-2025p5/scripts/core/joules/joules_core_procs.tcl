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

proc CETFE_create_path_groups {} {
  set_interactive_constraint_modes [all_constraint_modes]
  foreach current_clock [lsort -u [get_db clocks .base_name]] {
    set flop_list [get_object_name [all_registers -clock $current_clock]]
    set macro_list [get_object_name [all_registers -clock $current_clock -macros]]
    set input_list [get_object_name [all_inputs -clock $current_clock]]
    set output_list [get_object_name [all_outputs -clock $current_clock]]
    set icg_list [get_object_name [get_cells -of_objects [all_registers -clock $current_clock -clock_pins ]]]
    if {[llength $flop_list] != 0} {
      group_path -from $flop_list -to $flop_list -name ${current_clock}_F2F
      if {([llength $input_list] != 0)} {
        group_path -from $input_list -to $flop_list -name I2F_io_paths_${current_clock}
      }
      if {[llength $output_list] != 0} {
        group_path -from $flop_list -to $output_list -name F2O_io_paths_${current_clock}
      }
      if {[llength $input_list] != 0 && [llength $output_list] != 0} {
        group_path -from $input_list -to $output_list -name I2O_io_paths_${current_clock}
      }
      if {[llength $macro_list] != 0} {
        group_path -from $macro_list -to $flop_list -name MACRO_IO_I2F_paths_${current_clock}
        group_path -from $flop_list -to $macro_list -name MACRO_IO_F2O_paths_${current_clock}
      }
      if {[llength $icg_list] != 0 } {
        group_path -from $flop_list -to $icg_list   -name ICG_paths_${current_clock}
      }
    }
  }
  set_interactive_constraint_modes {}
}


proc CETFE_define_lp_icg_setup {args} {
  switch -- [parse_options "CETFE_define_lp_icg_setup" {} $args \
                   "-des_name srs top-level design name" \
                   des_name \
                   ] {
                      -2 { return }
                       0 { error "Failed on CETFE_define_lp_icg_setup" }
                   }

    foreach lc [vfind ./ -libcell *] {
      if {[llength [get_db [vfind $lc] .clock_gating_integrated_cell]] != 0} {
        set_db [vfind $lc] .preserve false
        set_db [vfind $lc] .avoid false
      }
    }
    set FIRST_ICG_INSTANCE [lindex [CETFE_find_icg_cells] 0]
    if {[llength $FIRST_ICG_INSTANCE] != 0} {
      set USER_ICG_LIBCELL [get_db [vfind $FIRST_ICG_INSTANCE] .libcell]
      set_db [vfind / -design $des_name] .lp_clock_gating_cell $USER_ICG_LIBCELL
      puts [format "%s%s%s" "In" "fo    : Automatic clock-gate insertion will use the following ICG libcell: " $USER_ICG_LIBCELL]
    }
}

proc CETFE_prevent_scan_usage {} {
  set all_lib_flops [get_db [vfind / -lib_cell *] -if {.flop == true}]
  set lib_scan_flops ""
  set lib_standard_flops ""
  foreach flop $all_lib_flops {
    set scn_en [llength [get_db [vfind $flop] .scan_enable]]
    set scn_in [llength [get_db [vfind $flop] .scan_in]]
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
    set_db [vfind $lib_scan_flops] .preserve true
    set_db [vfind $lib_scan_flops] .avoid true
  }
}

proc CETFE_set_dont_use_cells {} {
  global dont_use_cells

  foreach al $dont_use_cells {
    foreach lc [vfind / -libcell $al] {
      set_db [vfind $lc] .preserve true
      set_db [vfind $lc] .avoid true
    }
  }
}

proc CETFE_generate_precompile_sdc {} {
  global PSO_MODE
  global top_design

    eval write_sdc -no_split $PSO_MODE > [format "%s%s" "trial_synthesis/$top_design" {_precompile_full_constraints.sdc.gz}]
}

proc CETFE_output_db {args} {
  switch -- [parse_options "CETFE_output_db" {} $args \
                "-common bos Generate Innovus-compatible DB file" \
                generate_common_db \
                "-override bos Always generate DB regardless of global dump variable" \
                override_dump \
                "-db srs Target output DB file" \
                output_db \
            ] {
               -2 { return }
                0 {  error "Failed on CETFE_output_db"}
              }
  global top_design

  if {$override_dump} {
    if {$generate_common_db} {
      eval write_db -common -verbose -all_root_attributes -design [get_db designs $top_design] $output_db
    } else {
      eval write_db -verbose -all_root_attributes -design [get_db designs $top_design] $output_db
    }
  }
}

proc CETFE_dump_vivid_metrics_genus {args} {
  switch -- [parse_options "CETFE_dump_vivid_metrics_genus" {} $args \
                   "-step srs snapshot name for synthesis step" \
                   step
                   ] {
                      -2 { return }
                       0 {  error "Failed on CETFE_dump_vivid_metrics_genus"}
                   }

  set design_name [get_db current_design .name]
  create_snapshot -name $step -categories *
  write_metric -out_file "trial_synthesis/metrics.json"
  write_metric -merge -out_file "trial_synthesis/unified_metrics.json"
  read_metric -id $design_name "trial_synthesis/metrics.json"
  report_metric -format vivid -id $design_name -out_file "trial_synthesis/qor.html"
}

proc CETFE_restructure_clock_tree {} {

    declone_clock_gate -hier
    rebalance_clock_gating -strict_min_flop_constraint -hierarchical
    split_clock_gate -hier -max_level 2
}

proc CETFE_prefanout_and_icg_control {} {
  foreach dil [::legacy::filter -invert libcell "" [vfind / -inst -hinst *]] {
    if {[llength [get_db [get_db [vfind $dil] .libcell] .clock_gating_integrated_cell]] != 0} {
      set_db [vfind $dil] .preserve const_prop_size_delete_ok
    }
  }
  foreach pfi [vfind / -inst -hinst *_prefanout*] {
    foreach final_inst [::legacy::filter flop true [vfind [vfind $pfi] -inst -hinst insts/*]] {
      set_db [vfind $final_inst] .optimize_merge_seq false
    }
  }
  foreach pfi [::legacy::filter flop true [vfind / -inst -hinst *_prefanout*]] {
    set_db [vfind $pfi] .optimize_merge_seq false
  }
}

proc CETFE_configure_vivid_metrics_genus {} {
  set path_groups [get_db cost_groups *]
  set path_group_list [list]
  foreach_in_collection path_group $path_groups {
    lappend path_group_list [get_db [vfind / -cost_group $path_group] .base_name]
  }

  set_db metric_capture_timing_path_groups $path_group_list
  set_db metric_capture_timing_paths 10

  set_db [get_db base_cells -if {.name == *DSVT}]    .voltage_threshold_group svt
  set_db [get_db base_cells -if {.name == *DLVTLL}]  .voltage_threshold_group lvtll
  set_db [get_db base_cells -if {.name == *DLVT}]    .voltage_threshold_group lvt
  set_db [get_db base_cells -if {.name == *DULVTLL}] .voltage_threshold_group ulvtll
  set_db [get_db base_cells -if {.name == *DULVT}]   .voltage_threshold_group ulvt
}


proc CETFE_generate_output_report_package {args} {
  switch -- [parse_options "CETFE_generate_output_report_package" {} $args \
                "-file_prefix srs file name prefix for all reports: <prefix>_syn.<report_type>" \
                file_prefix \
            ] {
               -2 { return }
                0 { error "CETFE_generate_output_report_package" }
              }
  global QOR_SWITCH
  global top_design

  report_area > [format "%s%s" $file_prefix {_syn.area}]
  report_gates > [format "%s%s" $file_prefix {_syn.ref}]
  eval report_qor $QOR_SWITCH > [format "%s%s" $file_prefix {_syn.qor}]
  redirect [format "%s%s" $file_prefix {_syn.viol}] {report_design_rules}
  report_ple > [format "%s%s" $file_prefix {_syn.ple}]
  report_sequential -deleted > [format "%s%s" $file_prefix {_syn.seqopt}]
  report_sequential -hier > [format "%s%s" $file_prefix {_syn.seq_unopt}]
  write_spef > [format "%s%s" $file_prefix {_syn.spef.gz}]
  set CG_FILE_SUFFIX "_syn.rtl_and_tool_cg"
  redirect [format "%s%s" $file_prefix $CG_FILE_SUFFIX] {report_clock_gates -include_timing}
  redirect -append [format "%s%s" $file_prefix $CG_FILE_SUFFIX] {report_clock_gates -sinks_histogram}
  redirect -append [format "%s%s" $file_prefix $CG_FILE_SUFFIX] {report_clock_gates -tree_view}
  redirect -append [format "%s%s" $file_prefix $CG_FILE_SUFFIX] {report_clock_gates -detail}
  redirect -append [format "%s%s" $file_prefix $CG_FILE_SUFFIX] {puts "Set of ungated flops in the design:"}
  foreach_in_collection RCG [report_clock_gates -get_sinks ungated] {
    redirect -append [format "%s%s" $file_prefix $CG_FILE_SUFFIX] {puts $RCG}
  }
  report_multibit_inferencing -lib > [format "%s%s" $file_prefix {_syn.multibit}]
  report_multibit_inferencing -no_header >> [format "%s%s" $file_prefix {_syn.multibit}]
  report_multibit_inferencing -no_header -not_merged_summary >> [format "%s%s" $file_prefix {_syn.multibit}]
  report_multibit_inferencing -no_header -not_merged_instance_list >> [format "%s%s" $file_prefix {_syn.multibit}]
}

proc CETFE_generate_timing_report {args} {
  switch -- [parse_options "CETFE_generate_timing_report" {} $args \
                "-file_prefix srs file name prefix for timing report: <prefix>_syn.timing" \
                file_prefix \
            ] {
               -2 { return }
                0 { error "CETFE_generate_timing_report" }
              }
  global REPORT_COST_GROUPS
  set GENUS_NUM_PATHS 2000

  set local_timing_fp [format "%s%s" $file_prefix {_syn.timing}]
  set local_derates_fp [format "%s%s" $file_prefix {_syn.ocv_derates}]
  set local_reporting_column_format {timing_point flags arc edge cell fanout load transition delay_mean delay_sigma delay arrival user_derate incr_derate slew_derate socv_derate total_derate}
  redirect $local_timing_fp {puts [list]}
  foreach cg $REPORT_COST_GROUPS {
    redirect -append $local_timing_fp {report_timing -fields $local_reporting_column_format -path_type full_clock -max_paths $GENUS_NUM_PATHS -nworst 10 -group $cg}
    for {set i 0} {$i < 2} {incr i} {
      redirect -append $local_timing_fp {puts [list]}
    }
  }
  redirect $local_derates_fp {report_timing_derate}
}


proc CETFE_define_scan_chain {} {
  global top_design
  global shift_en_sig
  global dft_test_modes
  global dft_shift_en

  set ScanChainCount [connect_scan_chains -preview -auto_create_chains [get_db designs $top_design]]
  if {$ScanChainCount == "1"} {
    set_db [get_db designs $top_design] .dft_min_number_of_scan_chains 1
    define_scan_chain -name s1 -create_ports -non_shared_output -shift_enable $shift_en_sig -sdi test_si -sdo test_so
  } elseif {$ScanChainCount != "0" && $ScanChainCount != ""} {
    set_db [get_db designs $top_design] .dft_min_number_of_scan_chains $ScanChainCount
    for {set i 1} {$i <= $ScanChainCount} {incr i 1} {
      define_scan_chain -name s$i -create_ports -non_shared_output -shift_enable $shift_en_sig -sdi test_si$i -sdo test_so$i
    }
  }

  report_scan_chains -summary
  report_scan_setup
  connect_scan_chains [get_db designs $top_design]

  set_interactive_constraint_modes [all_constraint_modes]
  if {$dft_shift_en ne "" || $dft_shift_en != [list]} {
    dict for {se_name se_data} $dft_shift_en {
      set_case_analysis 0 [get_db ports $se_name]
    }
  } else {
    set_case_analysis 0 [get_db ports test_se]
  }

  if {$dft_test_modes ne "" || $dft_test_modes != [list]} {
    dict for {tm_name tm_data} $dft_test_modes {
      set_case_analysis 0 [get_db ports $tm_name]
    }
  } else {
    set_case_analysis 0 [get_db ports scan_mode]
  }
  set_interactive_constraint_modes {}

  report_case_analysis

}

proc CETFE_generate_dft_report_package {args} {
  switch -- [parse_options "CETFE_generate_dft_report_package" {} $args \
                "-file_prefix srs file name prefix for all DFT reports: <prefix>_syn.<report_type>" \
                file_prefix \
            ] {
               -2 { return }
                0 { error "CETFE_generate_dft_report_package" }
              }
  global top_design
  global RUN_ATPG
  global verilog_sim_lib

  redirect /dev/null {create_chains_database -design [get_db designs $top_design]}
  report_chains_total_wirelength -sort total
  report_scan_chains [get_db designs $top_design] > [format "%s%s" "trial_synthesis/dft/$top_design" {_syn.scanchains}]
  report_scan_registers [get_db designs $top_design] > [format "%s%s" "trial_synthesis/dft/$top_design" {_syn.scanregisters}]
  write_scandef -version 5.5 > [format "%s%s" "trial_synthesis/dft/$top_design" {_syn.scandef}]

  if {$RUN_ATPG == 1} {
    redirect [format "%s%s" "trial_synthesis/dft/$top_design" {_syn.test_coverage}] {analyze_atpg_testability -directory et_work_dir -atpg_options "-effort high" -library $verilog_sim_lib}
  }
}

proc CETFE_check_scan_all_posedge {} {
  global dft_test_modes
  set NEGEDGE_TEST_FLOPS [get_db [all::all_seqs -edge_triggered] -if {.dft_test_clock_edge == fall}]
  set NEGEDGE_TEST_FLOP_COUNT [sizeof_collection $NEGEDGE_TEST_FLOPS]
  if {$NEGEDGE_TEST_FLOP_COUNT > 0} {
    puts [format "%s%s%s%s" "Err" "or   : The following " $NEGEDGE_TEST_FLOP_COUNT " flops are nededge triggered for scan when dft_test_mode is 1'b1:"]
    foreach ntf $NEGEDGE_TEST_FLOPS {
      puts $ntf
    }
    quit(1)
  } else {
    puts "Check passed: all flops are positive edge triggered for scan when dft_test_mode is 1'b1"
  }
}


proc CETFE_init_DFT {} {
  global top_design
  global dft_test_clocks
  global dft_test_modes
  global dft_shift_en
  global dft_cg_en
  global dft_async_reset_ports  
  global shift_en_sig

  if {[llength [get_db test_clocks *]] != 0} {
     delete_obj [get_db test_clocks *]
  }
  set_db / .dft_prefix DFT_
  set_db / .dft_scan_style muxed_scan
  set_db [get_db designs $top_design] .dft_scan_output_preference auto
  set_db [get_db designs $top_design] .dft_connect_scan_data_pins_during_mapping loopback
  set_db [get_db designs $top_design] .dft_connect_shift_enable_during_mapping tie_off
  set_db [get_db designs $top_design] .dft_scan_map_mode tdrc_pass
  set_db [get_db designs $top_design] .dft_mix_clock_edges_in_scan_chain true
  
  set_db [get_db designs $top_design] .dft_max_length_of_scan_chains 50000

  if {[dict size $dft_test_clocks] > 0} {
    dict for {clk_sig clk_name} $dft_test_clocks {

      if {[get_db ports $clk_sig] ne ""} {
        set clk_cmd "define_test_clock -name $clk_name -controllable -design $top_design $clk_sig"
        eval $clk_cmd
      } else {
	  puts [format "%s%s%s%s" "Err" "or   : the clock-port " $clk_sig " doesn't exist. Please enter the correct clock port info and rerun or keep the test_clocks dictionary empty"]
          exit 1
      }
    }
  } else {
     foreach clk [get_db -u [get_db clocks -if {.is_generated == false}] .base_name] {
       if {[get_db -u [get_db -u clocks -if {.base_name == $clk}] .sources] ne ""} {
         define_test_clock -name $clk -controllable -design $top_design [get_db [get_db -u [get_db -u clocks -if {.base_name == $clk}] .sources] .base_name]
       }
     }
  }

  if {[dict size $dft_test_modes] > 0} {
    dict for {tm_sig tm_data} $dft_test_modes {
      set tm_name [lindex $tm_data 0]
      set tm_active [lindex $tm_data 1] 
       
      if {[get_db ports $tm_sig] ne ""} {
        set tm_cmd "define_test_signal -function test_mode -active $tm_active -test_only -name $tm_name -design $top_design $tm_sig"
        eval $tm_cmd
      } else {
        puts "Test-mode port $tm_name does not exist. Creating a new port $tm_name"
        define_test_signal -function test_mode -active high -test_only -create_port -name $tm_name -design $top_design $tm_sig
       }
     }
   } else {
      puts "Test-mode port does not exist. Creating a new port scan_mode"
      define_test_signal -function test_mode -active high -test_only -create_port -name scan_mode -design $top_design scan_mode
   }

   if {[dict size $dft_shift_en] > 0} {
     #create a test_se signal
     define_test_signal -function shift_enable -name test_se -active high -design $top_design -create_port test_se
     dict for {se_sig se_data} $dft_shift_en {
      set shift_en_sig $se_sig
      set se_name [lindex $se_data 0]
      set se_active [lindex $se_data 1]

       if {[get_db ports $se_sig] ne ""} {
           set se_cmd "define_test_signal -function shift_enable -active $se_active -name $se_name -design $top_design $se_sig"
           eval $se_cmd
       } else {
          puts "Shift-enable port $se_name does not exist. Creating a new port $se_name"
          define_test_signal -function shift_enable -name $se_name -active high -design $top_design -create_port $se_sig
       }

       if {$dft_cg_en ne "" || $dft_cg_en !=[list]} {
          set cgen_match_se 0
          if {$dft_cg_en eq $se_sig} {
             set cgen_match_se 1
             set_db designs .lp_clock_gating_test_signal $dft_cg_en
          } 
       }
     }

     if {$dft_cg_en eq "" || $dft_cg_en == [list]} {
        puts "Warning: No clock-gating enable signal defined. Assuming $shift_en_sig as clock-gating enable signal"
        set cgen_match_se 1
        set_db designs .lp_clock_gating_test_signal $shift_en_sig
     }

     if {$cgen_match_se == 0} {
        puts "Warning: Clock-gating enable signal not defined as shift-enable signal or not present. Auto-setting signal $dft_cg_en as shift-enable signal with polarity set to high."
        define_test_signal -function shift_enable -name $dft_cg_en -active high -design $top_design -create_port $dft_cg_en
        set_db designs .lp_clock_gating_test_signal $dft_cg_en
     }
   } else {
      set shift_en_sig test_se
      puts "Warning: Shift-enable port does not exist. Creating a new port $shift_en_sig"
      define_test_signal -function shift_enable -name $shift_en_sig -active high -design $top_design -create_port $shift_en_sig
      set_db designs .lp_clock_gating_test_signal $shift_en_sig
   }

  if {[dict size $dft_async_reset_ports] > 0} {
    dict for {rst_sig rst_data} $dft_async_reset_ports {
      set rst_name [lindex $rst_data 0]
      set rst_active [lindex $rst_data 1]

      if {[get_db ports $rst_sig] ne ""} {
        set rst_cmd "define_test_signal -function test_mode -scan_shift -name $rst_name -design $top_design -active $rst_active $rst_sig"
        eval $rst_cmd
      } else {
        puts "Warning: Async Reset-port $rst_sig doesn't exist. Make sure that mentioned reset-port $rst_sig is present in the design."
      }
    }
  } else {
    puts "Warning: Async Reset ports not specified in omega_user_vars.tcl file. Async Reset port must be specified for Asynchronous designs"
    #exit 1
  }

report_scan_setup
check_dft_rules -max_list_violations -1

CETFE_check_scan_all_posedge  

report_scan_registers -fail_tdrc -dont_scan  

}

proc yaml_quote_scalar {s} {
  if {[string first "\n" $s] > -1} {
    # multiline block scalar
    set lines [split $s "\n"]
    set body ""
    foreach line $lines { append body "  $line\n" }
    return [list 1 "|" $body]
  }
  set needs 0
  if {$s eq ""} { set needs 1 }
  if {!$needs && [regexp {[:\-\?\#\&\*\!\|\>\%\@\`]} $s]} { set needs 1 }
  if {!$needs && [regexp {\s} $s]} { set needs 1 }
  if {!$needs && [regexp {^[\{\}\[\],]} $s]} { set needs 1 }
  if {!$needs} { return [list 0 $s ""] }

  set esc $s
  regsub -all {"} $esc {\\"} esc
  regsub -all {\t} $esc {\\t} esc
  regsub -all {\\} $esc {\\\\} esc
  return [list 0 "\"$esc\"" ""]
}

proc yaml_indent {n} { string repeat " " $n }

proc yaml_emit_scalar {fh value indent} {
  set q [yaml_quote_scalar $value]
  if {[lindex $q 0]} {
    puts $fh "[yaml_indent $indent][lindex $q 1]"
    foreach line [split [lindex $q 2] "\n"] {
      if {$line ne ""} { puts $fh "[yaml_indent $indent]$line" }
    }
  } else {
    puts $fh "[yaml_indent $indent][lindex $q 1]"
  }
}

proc yaml_emit_value {fh value indent {mode {}}} {
  if {$mode eq "seq_only"} {
    if {[string is list -strict $value]} {
      set n [llength $value]
      if {$n == 0} {
        puts $fh "[yaml_indent $indent][]"
        return
      } elseif {$n == 1} {
        yaml_emit_scalar $fh [lindex $value 0] $indent
        return
      } else {
        foreach item $value {
          if {![catch {dict size $item} _]} {
            puts $fh "[yaml_indent $indent]-"
            yaml_emit_value $fh $item [expr {$indent + 2}]
          } elseif {[string is list -strict $item]} {
            set m [llength $item]
            if {$m <= 1} {
              puts $fh "[yaml_indent $indent]- [lindex [yaml_quote_scalar [lindex $item 0]] 1]"
            } else {
              puts $fh "[yaml_indent $indent]-"
              yaml_emit_value $fh $item [expr {$indent + 2}] "seq_only"
            }
          } else {
            set iq [lindex [yaml_quote_scalar $item] 1]
            puts $fh "[yaml_indent $indent]- $iq"
          }
        }
        return
      }
    } else {
      yaml_emit_scalar $fh $value $indent
      return
    }
  }

  #Dict
  if {![catch {dict size $value} _]} {
    foreach {k v} $value {
      set kq [lindex [yaml_quote_scalar $k] 1]
      puts $fh "[yaml_indent $indent]$kq:"
      yaml_emit_value $fh $v [expr {$indent + 2}] "seq_only"
    }
    return
  }

  #List (but not dict)
  if {[string is list -strict $value]} {
    set n [llength $value]
    if {$n == 0} {
      puts $fh "[yaml_indent $indent][]"
      return
    } elseif {$n == 1} {
      yaml_emit_scalar $fh [lindex $value 0] $indent
      return
    } else {
      foreach item $value {
        if {![catch {dict size $item} _]} {
          puts $fh "[yaml_indent $indent]-"
          yaml_emit_value $fh $item [expr {$indent + 2}]
        } elseif {[string is list -strict $item]} {
          set m [llength $item]
          if {$m <= 1} {
            puts $fh "[yaml_indent $indent]- [lindex [yaml_quote_scalar [lindex $item 0]] 1]"
          } else {
            puts $fh "[yaml_indent $indent]-"
            yaml_emit_value $fh $item [expr {$indent + 2}]
          }
        } else {
          set iq [lindex [yaml_quote_scalar $item] 1]
          puts $fh "[yaml_indent $indent]- $iq"
        }
      }
      return
    }
  }

  yaml_emit_scalar $fh $value $indent
}

proc CETFE_yaml_scalars_to_yaml {varList fh {nameMap {}}} {
  foreach var $varList {
    global $var
    set key $var
    if {[string length $nameMap] && [dict exists $nameMap $var]} {
      set key [dict get $nameMap $var]
    }
    set keyQ [lindex [yaml_quote_scalar $key] 1]

    if {![info exists $var]} {
      puts $fh "$keyQ: null"
      continue
    }
    set val [set $var]

    if {![catch {dict size $val} _]} {
      puts $fh "$keyQ:"
      yaml_emit_value $fh $val 2 "seq_only"
    } elseif {[string is list -strict $val]} {
      puts $fh "$keyQ:"
      yaml_emit_value $fh $val 2 "seq_only"
    } else {
      set q [yaml_quote_scalar $val]
      if {[lindex $q 0]} {
        puts $fh "$keyQ: [lindex $q 1]"
        foreach line [split [lindex $q 2] "\n"] {
            if {$line ne ""} { puts $fh "$line" }
        }
      } else {
        puts $fh "$keyQ: [lindex $q 1]"
      }
    }
  }
}

proc CETFE_yaml_dicts_to_yaml {varList fh {nameMap {}}} {
  foreach var $varList {
    global $var
    set key $var
    if {[string length $nameMap] && [dict exists $nameMap $var]} {
      set key [dict get $nameMap $var]
    }
    set keyQ [lindex [yaml_quote_scalar $key] 1]

    if {![info exists $var]} {
      puts $fh "$keyQ: null"
      continue
    }
    set val [set $var]
    if {[catch {dict size $val}]} {
      # Not a dict; write empty mapping to keep YAML valid
      puts $fh "$keyQ: {}"
      continue
    }
    puts $fh "$keyQ:"
    yaml_emit_value $fh $val 2
  }
}

