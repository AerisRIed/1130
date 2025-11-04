#############################################################################################
#        Copyright (c) 2014-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

###############################################################################################
## Disclaimer : This EDA Flow is going through internal review process and subject to change  #
###############################################################################################

set_var search_path ". .. ../scripts/tempus"

source -verbose Tempus_define.tcl
source ../scripts/tempus/Tempus_utils.tcl

################################################################################
# Global variables
################################################################################
set sh_enable_page_mode true
set sh_source_uses_search_path true

set_global timing_report_use_worst_parallel_cell_arc true
set_global timing_report_unconstrained_paths true
set_global timing_use_latch_time_borrow true

set_global report_precision 4
set_table_style -no_frame_fix_width -nosplit
set_table_style -name report_timing -max_width {100}
set_global timing_report_group_based_mode true

set_global timing_remove_clock_reconvergence_pessimism true
set_global timing_disable_retime_clock_path_slew_propagation false
set_global timing_path_based_recompute_noise true

set timing_disable_drv_reports_on_constant_nets true
set_global timing_aocv_derate_mode aocv_additive

set timing_library_read_without_power false

set_global timing_disable_recovery_removal_checks false
set_global lib_build_asynch_de_assert_arc true

set VER [lindex [split [getVersion] {-}] 0]

set_message -id ENCLF-223 -severity warn
set_message -id SPEF-1155 -severity warn
set_message -id ENCSYC-1442 -severity warn

if {$VER >= 15} {
  set_message -id IMPSYC-1442 -severity warn 
  set_message -id IMPLF-302 -severity warn
  set_message -id IMPDF-359 -severity warn
}
if {$TEMPUS_PBA == 1} {
  set_message -id TCLCMD-1644 -severity warn
}
if {($VER >= 17.1) && ($VER <= 21.12)} {
  set_message -id TECHLIB-1318 -severity warn
}
## Settings needed before reading library
if { $LIB_PROCESS_NODE <= 5} {
  set timing_library_hold_sigma_multiplier 0
  set timing_library_gen_hold_constraint_table_using_sigma_values sigma
  set_global timing_derate_spatial_distance_unit 1nm
}

################################################################################
# Source the variables defined in the CadSetup.file
################################################################################
if {$TSO_FLOW} {
  if {$TEMPUS_TSO_OPT < 1 || $TEMPUS_TSO_OPT > 5} {
    Puts "Error: The TSO_OPT value in CadSetup.file is invalid."
    exit
  }
  if {$TEMPUS_TSO_OPT_PASS2 > 0} {
    set TEMPUS_TSO_OPT $TEMPUS_TSO_OPT_PASS2
  }
  if {($Lib_CadenceLIB eq "{}") || ($Lib_CadenceLIB eq "") } {
    Puts "Error: The Lib_CadenceLIB variable in CadSetup.file must be specified for TSO flow."
    exit
  }
  if {($Lib_CadenceMinLIB eq "{}") || ($Lib_CadenceMinLIB eq "") } {
    Puts "Error: The Lib_CadenceMinLIB variable in CadSetup.file must be specified for TSO flow."
    exit
  }
  if {($Lib_CadencePhysicalLibrary eq "{}") || ($Lib_CadencePhysicalLibrary eq "") } {
    Puts "Error: The Lib_CadencePhysicalLibrary variable in CadSetup.file must be specified for TSO flow."
    exit
  }
  if {$TEMPUS_PBA != 2} {
    Puts "Error: TEMPUS_PBA must be set to 2 when using TSO"
    exit
  }
}

if {$TEMPUS_GENERATE_ETM == 1 && $TEMPUS_PBA != 2} {
  Puts "Error: TEMPUS_PBA must be set to 2 when generating ETM"
  exit
}

if {$TEMPUS_PBA > 0} {
  set_global timing_path_based_enable_verbose_mode 2
}

TIP_check_derate_method

if {($LIB_PROCESS_NODE < 3) || ($LIB_PROCESS_NODE > 250)} {
  puts [format "%s%s" "Err" "or   : The Lib_ProcessNode variable in CadSetup.file must be specified as a positive integer between 5 to 250."]
  exit
}

set_design_mode -process $LIB_PROCESS_NODE -node $LIB_TECH_NODE
if {$SUPERTHREAD_COUNT > 1} {
  set REMOTE_HOST [expr {$SUPERTHREAD_COUNT/2}]
  set CPU_PER_HOST 2
} else {
  set REMOTE_HOST $SUPERTHREAD_COUNT
  set CPU_PER_HOST 1
}
set_multi_cpu_usage -localCpu $SUPERTHREAD_COUNT -remoteHost $REMOTE_HOST -cpuPerRemoteHost $CPU_PER_HOST

TIP_get_file_name_prefix

# corner  Verif_Lib     TSO_Lib        SBOCV    Opcond 
set lib_config "\
{setup Lib_CadenceLIB MAX_SBOCV OPERATING_CONDITION} \
{leakage Lib_CadenceLIBML MIN_SBOCV MIN_OPERATING_CONDITION} \
{hold Lib_CadenceMinLIB MIN_SBOCV MIN_OPERATING_CONDITION} \
"
if {$USE_POWER_LIBRARY} {
  set lib_config "$lib_config \
  {typ Lib_CadenceTypLIB MAX_SBOCV TYP_OPERATING_CONDITION} \
  "
}

set lef_file $Lib_CadencePhysicalLibrary

set setup_views "setup"
set hold_views "hold"
set typ_view "typ"
set leakage_view "leakage"

source -verbose ../scripts/tempus/Tempus_timing_analysis.tcl

exit

