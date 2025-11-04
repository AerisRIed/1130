###################################################################################
#   Copyright (c) 2009-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.   #
# These coded instructions, statements, and computer programs are the copyrighted #
# works and confidential proprietary information of Cadence Design Systems Inc.   #
# They may not be modified, copied, reproduced, distributed, or disclosed to      #
# third parties in any manner, medium, or form, in whole or in part, without      #
# the prior written consent of Cadence Design Systems Inc.                        #
###################################################################################
######################################################
#                                                    #
# Innovus Initialize Design Script (for floorplan)   #
#                                                    #
######################################################
report_resource -start fullFlow
source Innovus_define.cmd
set elapsed_mins [expr [clock clicks -milliseconds] / 60000]

if {![info exists SUPERTHREAD_COUNT]} {
  set SUPERTHREAD_COUNT 1
}

setMultiCpuUsage -localCpu $SUPERTHREAD_COUNT
source ../scripts/innovus/Innovus_util.cmd
source ../scripts/innovus/Innovus_cons.cmd
source ../scripts/innovus/Innovus_autofp.cmd

source ../scripts/innovus/Innovus_DFM_flow.cmd

TIP_get_file_name_prefix

set VER [lindex [split [getVersion] {-}] 0]

setCheckMode -tapeOut true
TIP_invokeError -id {IMPSP-365 ENCDF-84  IMPSP-270}
TIP_suppressError -id {ENCLF-223 IMPLF-223 IMPLF-302 TCLCMD-917  TECHLIB-1398 TA-533 IMPDB-1221}
if {$VER >= 17.1 && $VER <= 21.12} {
  TIP_suppressError -id TECHLIB-1318 
}

set runPlaceFlag 1
if {[file exists Innovus_Lib/preCtsOpt.enc.dat]} {
  set runPlaceFlag 0
}

set init_design_uniquify 1
check_derate_method 

    ######################################################
    # Init Design                                        #
    ######################################################
    set init_import_mode {-treatUndefinedCellAsBbox 0 -keepEmptyModule 1} 
    set init_verilog [format "%s%s" $FILE_NAME_PREFIX "_netlist.v"]
    set init_design_netlisttype {Verilog}
    set init_design_settop {0}
    set init_lef_file "$Lib_CadencePhysicalLibrary"
    set init_pwr_net "$Fplan_PowerNetName"
    set init_gnd_net "$Fplan_GroundNetName"
    set init_assign_buffer {0} 
    set init_mmmc_file Innovus_corner_define.cmd
    
    set delaycal_use_default_delay_limit {1000}
    set delaycal_default_net_delay {1000.0ps} 
    set delaycal_default_net_load {2.0pf}
    set delaycal_input_transition_delay {100ps}
    
    TIP_get_sdc_units
    
    init_design

    TIP_applyDerate
    TIP_globalConnect

