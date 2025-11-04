# Copyright (c) 2008-2025 by Cadence Design Systems Inc.  ALL RIGHTS RESERVED.              #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to   #
# third parties in any manner, medium, or form, in whole or in part, without   #
# the prior written consent of Cadence Design Systems Inc.                                  #
################################################################################

###############################################################################################
## Disclaimer : This EDA Flow is going through internal review process and subject to change  #
###############################################################################################

################################################################################
# <QRC_extract.cmd>                                                            #
# This file is used to be the default extraction command file for QRC          #
################################################################################

# Include variable definition
include QRC_define.cmd

# Specify pointer to qrcTechFile
if {$Lib_MaxQrcTechFile != $Lib_TypQrcTechFile} {
process_technology \
  -technology_library_file corner.defs \
  -technology_name $LIB_PROCESS_NODE \ 
  -technology_corner "max" "min" "typ"\
  -temperature $Lib_MaxCornerTemp $Lib_MinCornerTemp $Lib_TypCornerTemp
}
if {$Lib_MaxQrcTechFile == $Lib_TypQrcTechFile} {
process_technology \
  -technology_library_file corner.defs \
  -technology_name $LIB_PROCESS_NODE \ 
  -technology_corner "max" "min" \
  -temperature $Lib_MaxCornerTemp $Lib_MinCornerTemp
}

if {[info exists env(QRC_HOME)] != 0} {
  if {$env(QRC_HOME) != "/cad/cadence_root/quantus/ext_2120/21.20-p060" } {
    if {$LIB_PROCESS_NODE <= 7} {
      filter_coupling_cap \
        -total_cap_threshold             0      \
        -cap_filtering_mode              absolute_and_relative \
        -coupling_cap_threshold_absolute 0.1 \
        -coupling_cap_threshold_relative 1.0
    }
  }
}

# Multi-threading setting
distributed_processing -multi_cpu $SUPERTHREAD_COUNT

# Specify library lef files
input_db \
  -type def \
  -lef_file_list $Lib_CadencePhysicalLibrary


# Technology Layer Map
extraction_setup -technology_layer_map $QRC_LayerMappingInfo

# Net selection
extract -selection all -type rc_coupled
extract -selection net VDD -type none
extract -selection net VSS -type none

graybox -type lef_obstruction

# Output setting
output_setup \
  -keep_temporary_files           false           \
  -temporary_directory_name       temp            \
  -compress_temporary_files       true            \
  -compressed 0

output_db \
  -type spef \
  -subtype standard \
  -hierarchy_delimiter "/" \
  -pin_delimiter : \
  -busbit_delimiter [] \
  -use_name_map true \
  -output_incomplete_nets true \
  -output_unrouted_nets true 

