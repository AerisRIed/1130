################################################################################
# Copyright (c) 2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design #
# Systems Inc. They may not be modified, copied, reproduced, distributed, or   #
# disclosed to third parties in any manner, medium, or form, in whole or in    #
# part, without the prior written consent of Cadence Design Systems Inc.       #
################################################################################

#########################################################
# TCL proc definitions used across all Omega tools	#
#########################################################

proc CETFE_rel2abs_path {{rel_path ""} {path_root ""}} {
  if {$path_root eq ""} {
    puts [format "%s%s" "Err" "or   : CETFE_rel2abs_path requires the path_root value to be non-empty"]
    exit 1
  }
  set abs_path [list]
  if {[llength $rel_path] != 0} {
    if {[regexp {^~} $rel_path] == 1} {
      set abs_path [file normalize [glob -nocomplain $rel_path]]
    } elseif {[regexp {^/} $rel_path] == 0} {
      set abs_path [file normalize [file join $path_root $rel_path]]
    } else {
      set abs_path [file normalize $rel_path]
    }
    if {[file readable $abs_path] == 0} {
      puts [format "%s%s%s" "Err" "or   : CETFE_rel2abs_path output is unreadable: " $abs_path]
      exit 1
    }
  }
  return $abs_path
}

proc CETFE_validate_lrm {{user_lang ""} {target_tool ""}} {
  if {($user_lang eq "") || ($target_tool eq "")} {
    puts [format "%s%s" "Err" "or   : CETFE_validate_lrm requires both user_lang and target_tool to be non-empty"]
    exit 1
  }
  set return_lang "unsupported"
  if {$target_tool eq "litmus1"} {
    if {[regexp {^(v1995|v2001|vhdl|sv|sv05|sva|auto_verilog)$} $user_lang] == 1} {
      set return_lang $user_lang
    } elseif {[regexp {^v2k$} $user_lang] == 1} {
      set return_lang "v2001"
    }
  } elseif {$target_tool eq "jasper"} {
    if {[regexp {^(vhdl|vhdl93|vhdl2k|vhdl08|verilog|v2k|v95|vams|sv|sv05|sv09|sv12|sv17)$} $user_lang] == 1} {
      set return_lang $user_lang
    }
  } elseif {$target_tool eq "clp"} {
    if {[regexp {^(verilog|verilog2k|v1995|systemverilog|sva|sv|sv09|sv12|vhdl|vhdl-93|vhdl-87|vhdl-2008)$} $user_lang] == 1} {
      set return_lang $user_lang
    } elseif {[regexp {^v2k$} $user_lang] == 1} {
      set return_lang "verilog2k"
    }
  } elseif {$target_tool eq "joules"} {
    if {[regexp {^(v1995|v2001|sv|vhdl)$} $user_lang] == 1} {
      set return_lang $user_lang
    } elseif {[regexp {^v2k$} $user_lang] == 1} {
      set return_lang "v2001"
    }
  } else {
    puts [format "%s%s%s" "Err" "or   : the following is not a supported Omega tool: " $target_tool]
    exit 1
  }
  if {$return_lang eq "unsupported"} {
    puts [format "%s%s%s%s%s" "Err" "or   : the specified LRM of " $user_lang " is not supported by " $target_tool]
    exit 1
  }
  return $return_lang
}

proc CETFE_tool_name_check {{target_tool ""}} {
  if {$target_tool eq ""} {
    puts [format "%s%s" "Err" "or   : the target_tool specification cannot be empty"]
    exit 1
  } elseif {[regexp {^(litmus1|jasper|clp|joules)$} $target_tool] == 0} {
    puts [format "%s%s" "Err" "or   : the target_tool must be one of \"litmus1\", \"jasper\", \"clp\", \"joules\""]
    exit 1
  }
}

proc CETFE_manipulate_omega_user_vars {{target_tool ""}} {
  global use_mmmc
  global single_corner_libs
  global lef_list
  global rtl_flow
  global top_design
  global golden_vf_file
  global rtl_defines
  global bbox_module_list
  global golden_netlist_file
  global golden_sdc_file
  global tool_thread_count
  global hier_inst_sdc
  global hier_jdb_mod_app
  global reset_init_file
  global golden_name_map_file
  global rtl_upf
  global netlist_upf
  global mmmc_file
  global golden_db_file
  global stimulus_file_list
  global verilog_sim_lib
  global path_to_dut
  global structure_threshold
  global depth_threshold
  global depth_fan_in_out_threshold
  global insert_clock_gating
  global cts_root_fanout
  global cts_branch_fanout
  global cts_leaf_fanout
  global cts_root_buffer
  global cts_branch_buffer
  global cts_leaf_buffer
  global prl_hier_flow
  global prl_user_vars_root_dir
  global prl_stamped_base_dir
  global global_command_merge_file

  CETFE_tool_name_check $target_tool

  # Manipulate single_corner_libs:
  set temp_sc_libs [list]
  foreach scl $single_corner_libs {
    lappend temp_sc_libs [CETFE_rel2abs_path $scl $prl_user_vars_root_dir]
  }
  set single_corner_libs $temp_sc_libs

  # Manipulate lef_list:
  set temp_ll [list]
  foreach ll $lef_list {
    lappend temp_ll [CETFE_rel2abs_path $ll $prl_user_vars_root_dir]
  }
  set lef_list $temp_ll

  # Manipulate golden_vf_file:
  if {[regexp {^clp$} $target_tool] == 1} {
    global prl_compare
    set manipulate_golden_vf [expr "$rtl_flow || $prl_compare"]
  } else {
    set manipulate_golden_vf $rtl_flow
  }
  if {$manipulate_golden_vf == 1} {
    set temp_vf_file_list [list]
    set temp_vf_dict [dict create]
    set merged_vf_counter 0
    dict for {vfile lang} $golden_vf_file {
      foreach vf $vfile {
	lappend temp_vf_file_list [CETFE_rel2abs_path $vf $prl_user_vars_root_dir]
      }
      set lang [CETFE_validate_lrm $lang $target_tool]
      set loc_merged_vf_file [file join $prl_stamped_base_dir merged_and_absolute_${merged_vf_counter}.vf]
      exec $global_command_merge_file -in $temp_vf_file_list -out $loc_merged_vf_file -anchor $prl_user_vars_root_dir
      dict set temp_vf_dict $loc_merged_vf_file $lang
      incr merged_vf_counter
      set temp_vf_file_list [list]
    }
    set golden_vf_file $temp_vf_dict
  }

  # Manipulate rtl_defines:
  if {[regexp {^jasper$} $target_tool] == 1} {
    if {[llength $rtl_defines] != 0} {
      set rtl_defines [format "%s%s" "+define+" [join $rtl_defines "+"]]
    }
  }

  # Manipulate golden_netlist_file:
  if {[regexp {^(litmus1|jasper|clp)$} $target_tool] == 1} {
    set golden_netlist_file [CETFE_rel2abs_path $golden_netlist_file $prl_user_vars_root_dir]
  }

  # Manipulate golden_sdc_file:
  if {[regexp {^(litmus1|jasper|joules)$} $target_tool] == 1} {
    set golden_sdc_file [CETFE_rel2abs_path $golden_sdc_file $prl_user_vars_root_dir]
  }

  # Manipulate hier_inst_sdc:
  if {[regexp {^litmus1$} $target_tool] == 1} {
    dict for {inst sdc} $hier_inst_sdc {
      set sdc [CETFE_rel2abs_path $sdc $prl_user_vars_root_dir]
      dict set hier_inst_sdc $inst $sdc
    }
  }

  # Manipulate golden_name_map_file, hier_jdb_mod_app, and reset_init_file:
  if {[regexp {^jasper$} $target_tool] == 1} {
    set golden_name_map_file [CETFE_rel2abs_path $golden_name_map_file $prl_user_vars_root_dir]
    set temp_jdb_dict [dict create]
    dict for {path mod_a} $hier_jdb_mod_app {
      dict for {mod_b app} $mod_a {
	if {([lsearch -exact -nocase $app cdc] != -1) || ([lsearch -exact -nocase $app superlint] != -1)} {
	  set path [CETFE_rel2abs_path $path $prl_user_vars_root_dir]
	  dict set temp_jdb_dict $path $mod_b $app
	} else {
	  puts [format "%s%s%s%s" "Err" "or   : the hier_jdb_mod_app dictionary specifies an unsupported App \"" $app "\""]
	  puts [format "%s%s" "Err" "or   : the only valid values are \"cdc\" and \"superlint\""]
	  exit 1
	}
	if {$prl_hier_flow} {
	  lappend bbox_module_list $mod_b
	  set bbox_module_list [lsort -unique $bbox_module_list]
	}
      }
    }
    set hier_jdb_mod_app $temp_jdb_dict
    set temp_reset_dict [dict create]
    set loc_reset_file_path [list]
    set loc_enabled_counter 0
    dict for {rst_type nested_a} $reset_init_file {
      dict for {f_type nested_b} $nested_a {
	dict for {f_path nested_c} $nested_b {
	  dict for {enabled addnl_args} $nested_c {
	    set loc_reset_file_path [CETFE_rel2abs_path $f_path $prl_user_vars_root_dir]
	    if {[regexp {^(sequence|init_state)$} $rst_type] == 0} {
	      puts [format "%s%s" "Err" "or   : the reset_init_file index value \"rst_type\" can be \"sequence\" or \"init_state\";"]
	      puts [format "%s%s%s" "Err" "or   : currently it is " $rst_type]
	      exit 1
	    }
	    if {[regexp {^(internal|fsdb|vcd|shm|vwdb)$} $f_type] == 0} {
	      puts [format "%s%s" "Err" "or   : the reset_init_file index value \"f_type\" can be \"internal\", \"fsdb\", \"vcd\","]
	      puts [format "%s%s%s" "Err" "or   : \"shm\", or \"vwdb\"; currently it is " $f_type]
	      exit 1
	    }
	    if {[string is boolean -strict $enabled] == 0} {
	      puts [format "%s%s%s" "Err" "or   : the reset_init_file index value \"enabled\" must be Boolean; currently it is " $enabled]
	      exit 1
	    } else {
	      set loc_enabled_counter [expr $loc_enabled_counter + $enabled]
	    }
	    dict set temp_reset_dict $rst_type $f_type $loc_reset_file_path $enabled "$addnl_args"
	  }
	}
      }
    }
    if {$loc_enabled_counter > 1} {
      puts [format "%s%s" "Err" "or   : the reset_init_file dictionary can have only one entry enabled at a time"]
      exit 1
    }
    set reset_init_file $temp_reset_dict
  }

  # Manipulate rtl_upf and netlist_upf:
  if {[regexp {^clp$} $target_tool] == 1} {
    set rtl_upf [CETFE_rel2abs_path $rtl_upf $prl_user_vars_root_dir]
    set netlist_upf [CETFE_rel2abs_path $netlist_upf $prl_user_vars_root_dir]
  }

  # Manipulate mmmc_file, golden_db_file, stimulus_file_list, and verilog_sim_lib:
  if {[regexp {^joules$} $target_tool] == 1} {
    set mmmc_file [CETFE_rel2abs_path $mmmc_file $prl_user_vars_root_dir]
    set golden_db_file [CETFE_rel2abs_path $golden_db_file $prl_user_vars_root_dir]
    set temp_stim_files [list]
    foreach stim_file $stimulus_file_list {
      lappend temp_stim_files [CETFE_rel2abs_path $stim_file $prl_user_vars_root_dir]
    }
    set stimulus_file_list $temp_stim_files
    set temp_vsim_files [list]
    foreach vsim_file $verilog_sim_lib {
      lappend temp_vsim_files [CETFE_rel2abs_path $vsim_file $prl_user_vars_root_dir]
    }
    set $verilog_sim_lib $temp_vsim_files
  }
}

proc CETFE_validate_omega_user_vars {{target_tool ""}} {
  global use_mmmc
  global rtl_flow
  global insert_clock_gating
  global tool_thread_count
  global structure_threshold
  global depth_threshold
  global depth_fan_in_out_threshold
  global cts_root_fanout
  global cts_branch_fanout
  global cts_leaf_fanout
  global top_design
  global path_to_dut
  global xprop_src_targ
  global run_atpg        
  global insert_scan     
  global lib_process_node

  CETFE_tool_name_check $target_tool

  set test_for_boolean [list use_mmmc rtl_flow insert_clock_gating run_atpg insert_scan]
  set test_for_integer [list tool_thread_count structure_threshold depth_threshold \
			     depth_fan_in_out_threshold cts_root_fanout \
			     cts_branch_fanout cts_leaf_fanout lib_process_node]
  set test_for_range [list top_design path_to_dut]

  foreach tfb $test_for_boolean {
    if {[string is boolean -strict [subst $${tfb}]] == 0} {
      puts [format "%s%s%s%s%s" "Err" "or   : the omega_user_vars.tcl variable \"" $tfb "\" only accepts a Boolean value. It is currently set to " [subst $${tfb}]]
      exit 1
    }
  }
  foreach tfi $test_for_integer {
    if {[string is integer -strict [subst $${tfi}]] == 0} {
      puts [format "%s%s%s%s%s" "Err" "or   : the omega_user_vars.tcl variable \"" $tfi "\" only accepts an integer value. It is currently set to " [subst $${tfi}]]
      exit 1
    }
  }
  foreach tfr $test_for_range {
    if {[llength [subst $${tfr}]] > 1} {
      puts [format "%s%s%s%s%s" "Err" "or   : the omega_user_vars.tcl variable \"" $tfr "\" can only contain one entry. It is currently set to " [subst $${tfr}]]
      exit 1
    }
  }
  if {[regexp {^jasper$} $target_tool] == 1} {
    if {[dict size $xprop_src_targ] == 0} {
      puts [format "%s%s" "Err" "or   : if running Jasper, the xprop_src_targ omega_user_vars.tcl dictionary cannot be undefined."]
      exit 1
    } else {
      dict for {index value} $xprop_src_targ {
	if {([regexp {^src_(uninit_regs|bbox_outputs|bus_contention|bus_floating|int_undriven|input_ports|stopats|reg_rst_abst|reg_init_abst)$} $index] == 0) &&
	    ([regexp {^targ_(clk_and_rst|control|data|index|output_ports|bbox_inputs|reg_rst_pin|reg_rst_val|counter|fsm)$} $index] == 0)} {
	  puts [format "%s%s%s%s" "Err" "or   : the index \"" $index "\" is not of the allowed set for the xprop_src_targ dictionary in omega_user_vars.tcl."]
	  exit 1
	}
	if {[string is boolean -strict $value] == 0} {
	  puts [format "%s%s%s%s%s%s" "Err" "or   : the value \"" $value "\" is not of type Boolean for the xprop_src_targ dictionary index \"" $index "\" in omega_user_vars.tcl."]
	  exit 1
	}
      }
    }
  }
  if {[regexp {^joules$} $target_tool] == 1} {
    global dft_shift_en
    global dft_test_modes
    global dft_async_reset_ports
    set test_for_active_sense [list dft_shift_en dft_test_modes dft_async_reset_ports]
    foreach tfas $test_for_active_sense {
      if {[info exists $tfas] == 1} {
	if {[dict size [subst $${tfas}]] > 0} {
	  dict for {port sig_a} [subst $${tfas}] {
	    dict for {sig_name active_sense} $sig_a {
	      if {[regexp {^(high|low)$} $active_sense] == 0} {
		puts [format "%s%s%s%s%s%s%s%s" "Err" "or   : the dictionary \"" $tfas "\" entry for port \"" $port "\" active sense \"" $active_sense "\" is not from the set {high,low}."]
		exit 1
	      }
	    }
	  }
	}
      }
    }
  }
}
