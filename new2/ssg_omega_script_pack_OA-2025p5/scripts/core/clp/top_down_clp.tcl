tclmode
################################################################################
# Copyright (c) 2024 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design #
# Systems Inc. They may not be modified, copied, reproduced, distributed, or   #
# disclosed to third parties in any manner, medium, or form, in whole or in    #
# part, without the prior written consent of Cadence Design Systems Inc.       #
################################################################################

#########################################################
# This file should not require any user modification    #
#########################################################

#########################################################
# Load scripts                                          #
#########################################################
set golden_vf_file [dict create]

if {[file readable ./omega_local_user_vars.tcl]} {
  source -echo ./omega_local_user_vars.tcl
} else {
  puts [format "%s%s" "Err" "or   : expected user input file ./omega_local_user_vars.tcl not found."]
  exit
}

set global_tcl_utils_file                "$prl_script_root_dir/../common/TclUtils.tcl"
set global_command_merge_file            "$prl_script_root_dir/../common/MergeCommandFile.pl"

#########################################################
# Load attribute specification file                     #
#########################################################
set files_to_read "\
${global_tcl_utils_file} \
${prl_script_root_dir}/clp_core_attributes.tcl \
${prl_script_root_dir}/../../${prl_user_dir}/clp/clp_user_attributes.tcl \
"

foreach fi $files_to_read {
  set fi [file normalize ${fi}];
  if {[file readable ${fi}]} {
    source -echo ${fi}
  } else {
    puts [format "%s%s" "Err" "or   : expected attribute specification file ${fi} not found."]
    exit
  }
}

#########################################################
# Manipulate user variables                             #
#########################################################
CETFE_manipulate_omega_user_vars "clp"
CETFE_validate_omega_user_vars "clp"

if {(!$rtl_flow || $prl_compare)} {
  if {${golden_netlist_file} eq ""} {
    puts [format "%s%s" "Err" "or: File golden_netlist_file from omega_user_vars.tcl is empty."]
    exit
  }
  if {${netlist_upf} eq ""} {
    puts [format "%s%s" "Err" "or: File netlist_upf from omega_user_vars.tcl is empty."]
    exit
  }
}

if {($rtl_flow || $prl_compare)} {
  if {${rtl_upf} eq ""} {
    puts [format "%s%s" "Err" "or: File rtl_upf from omega_user_vars.tcl is empty."]
    exit
  }
  if {[dict size $golden_vf_file] == 0} {
    puts [format "%s%s" "Err" "or: RTL-level analysis or UPF Compare has been selected, however there are"]
    puts [format "%s%s" "Err" "or: no input filelists defined in golden_vf_file."]
    exit
  }
}

#########################################################
# Initial setup                                         #
#########################################################
usage -auto -elapse

set_multi_cpu_usage -keep_license true -local_cpu $tool_thread_count

set_log_file [file join $prl_stamped_base_dir clp_session.log] -progress -replace

set define_cmd ""
if {$rtl_defines ne ""} {
  foreach rtld $rtl_defines {
    set define_cmd "$define_cmd -define $rtld"
  }
}

#########################################################
# Apply rule filters                                    #
#########################################################
set files_to_read "\
${prl_script_root_dir}/clp_core_rule_filters.tcl \
${prl_script_root_dir}/../../${prl_user_dir}/clp/clp_user_rule_filters.tcl \
"

foreach fi $files_to_read {
  set fi [file normalize ${fi}];
  if {[file readable ${fi}]} {
    source -echo ${fi}
  } else {
    puts [format "%s%s" "Err" "or   : expected attribute specification file ${fi} not found."]
    exit
  }
}

#########################################################
# Load library views                                    #
#########################################################
set load_library_cmd "read_library -statetable -liberty -lp std"
foreach lib $single_corner_libs {
  if {[regexp {\.gz$} $lib]} {
    set load_library_cmd "$load_library_cmd -unzip $lib"
  } else {
    set load_library_cmd "$load_library_cmd $lib"
  }
}

eval $load_library_cmd

#########################################################
# Load design and perform design-rule linting           #
#########################################################
if {($rtl_flow || $prl_compare)} {
  set rtln 0
  dict for {flist lrm} $golden_vf_file {
    set append_cmd "read_design -$lrm -f $flist $define_cmd"
    if {[expr $rtln +1] != [dict size $golden_vf_file]} {
      set append_cmd "$append_cmd -noelaborate"
    }
    if {$prl_compare} {
      set append_cmd "$append_cmd -golden"
    }
    eval $append_cmd
    incr rtln
  }
}

if {(!$rtl_flow || $prl_compare)} {
  set append_cmd ""
  if {$prl_compare} {
    set append_cmd "-revised"
  }
  eval "read_design -verilog -sensitive $golden_netlist_file $append_cmd"
}

set_root_module $top_design

#########################################################
# Read UPF                                              #
#########################################################
if {($rtl_flow || $prl_compare)} {
  set append_cmd ""
  if {$prl_compare} {
    set append_cmd "-golden"
  }
  eval "read_power_intent -1801 $rtl_upf $append_cmd"
}

if {(!$rtl_flow || $prl_compare)} {
  set append_cmd ""
  if {$prl_compare} {
    set append_cmd "-revised"
  }
  eval "read_power_intent -1801 $netlist_upf $append_cmd"
}

#########################################################
# Reports                                               #
#########################################################
if {!$prl_compare} {
  set_system_mode verify
}

if {$prl_compare} {
  compare_power_intent
  report_compared_intent > [file join $prl_stamped_base_dir report ${top_design}.compare_power_intent.rpt]
  report_compared_intent -verbose > [file join $prl_stamped_base_dir report ${top_design}.compare_power_intent.verbose.rpt]
} else {
  report_rule_filter > [file join $prl_stamped_base_dir report ${top_design}.rule_filters.rpt]
  report_rule_check -verbose -modified > [file join $prl_stamped_base_dir report ${top_design}.rule_check.modified.rpt]
  report_rule_check -1801 -verbose -status fail -severity Error > [file join $prl_stamped_base_dir report ${top_design}.rule_check.error.rpt]
  report_rule_check -1801 -verbose -status fail -severity Warning > [file join $prl_stamped_base_dir report ${top_design}.rule_check.warning.rpt]
  report_rule_check -1801 -verbose -severity Note > [file join $prl_stamped_base_dir report ${top_design}.rule_check.note.rpt]
  report_black_box -detail > [file join $prl_stamped_base_dir report ${top_design}.black_box.rpt]
  report_lowpower_info -alive_power_down -instance * > [file join $prl_stamped_base_dir report ${top_design}.alive_power_down.insts.rpt]
  report_lowpower_info -alive_power_down -net * > [file join $prl_stamped_base_dir report ${top_design}.alive_power_down.nets.rpt]
  report_design_data -verbose > [file join $prl_stamped_base_dir report ${top_design}.design_data.rpt]
  report_library_data -skip_unref -sort name > [file join $prl_stamped_base_dir report ${top_design}.library_data.rpt]
  report_power_intent > [file join $prl_stamped_base_dir report ${top_design}.power_intent.rpt]
  report_pst >  [file join $prl_stamped_base_dir report ${top_design}.pst.rpt]
}

if {!$prl_gui} {
  exit
}

