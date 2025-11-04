#############################################################################################
#        Copyright (c) 2008-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

#########################################################
# This is part 3 of 3 in the Genus DFT process - define #
# the actual scan chains and stitch them together.      #
# Definition is necessary to keep the port naming       #
# convention consistent with Cadence Genus Tool.        #
# Stitching the chains together alphabetically is the   #
# final step. Backend tools will re-stitch the scan     #
# chains when the placement is finalized. This must be  #
# read in after technology-specific synthesis but prior #
# to incremental synthesis passes.                      #
#########################################################

#########################################################
# Define scan chains and stitch them together           #
#########################################################

check_dft_rules

set ScanChainCount [connect_scan_chains -preview -auto_create_chains [find / -design $TOP_DESIGN]]
if {$ScanChainCount == "1"} {
  set_attribute dft_min_number_of_scan_chains 1 [find / -design $TOP_DESIGN]
  define_dft scan_chain -name s1 -create_ports -non_shared_output -shift_enable test_se -sdi test_si -sdo test_so
} elseif {$ScanChainCount != "0" && $ScanChainCount != ""} {
  set_attribute dft_min_number_of_scan_chains $ScanChainCount [find / -design $TOP_DESIGN]
  for {set i 1} {$i <= $ScanChainCount} {incr i 1} {
    define_dft scan_chain -name s$i -create_ports -non_shared_output -shift_enable test_se -sdi test_si$i -sdo test_so$i
  }
}
report dft_chains -summary
report dft_setup
connect_scan_chains [find / -design $TOP_DESIGN]
TIP_test_scan_chain_complete -max_length $MAX_CHAIN_LENGTH -memory_list $UNIQUE_MACRO_CELLS
dc::set_ideal_network -no_propagate [find / -port test_se]
dc::set_case_analysis 0 [find / -port test_se]
if {$TMODE_PORT != [list]} {
  dc::set_case_analysis 0 $TMODE_PORT
}
if {$OVERRIDE_PORT != [list]} {
  dc::set_case_analysis 0 $OVERRIDE_PORT
}

report case_analysis
TIP_generate_timestat -print_tag "scan_insertion" -stat_tag "ScanInsertion"

