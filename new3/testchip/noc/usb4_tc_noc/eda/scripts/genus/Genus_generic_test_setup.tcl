#############################################################################################
#        Copyright (c) 2008-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

#########################################################
# This is part 1 of 3 in the Genus DFT process - set up #
# the necessary test ports and attributes. This must be #
# read in prior to synthesizing to generic logic.       #
#########################################################

#########################################################
# Set up DFT-specific attributes                        #
#########################################################

if {[llength [find / -test_clock *]] != 0} {
  rm [find / -test_clock *]
}
set_attribute dft_prefix DFT_ /
set_attribute dft_scan_style muxed_scan /
set_attribute dft_scan_output_preference auto [find / -design $TOP_DESIGN]
set_attribute dft_connect_scan_data_pins_during_mapping loopback [find / -design $TOP_DESIGN]
set_attribute dft_connect_shift_enable_during_mapping tie_off [find / -design $TOP_DESIGN]
set_attribute dft_scan_map_mode tdrc_pass [find / -design $TOP_DESIGN]
set_attribute dft_mix_clock_edges_in_scan_chain true [find / -design $TOP_DESIGN]
if {$MAX_CHAIN_LENGTH > 0} {
  set_attribute dft_max_length_of_scan_chains $MAX_CHAIN_LENGTH [find / -design $TOP_DESIGN]
}

#########################################################
# Define DFT-related ports                              #
#########################################################

define_dft shift_enable -name test_se -active high -design $TOP_DESIGN -create_port -default test_se
set TMODE_PORT [find / -port ports_in/$TESTMODE]
if {$TMODE_PORT != [list]} {
  define_dft test_mode -test_only -name TMode -design $TOP_DESIGN -active high $TMODE_PORT
}
set OVERRIDE_PORT [find / -port ports_in/$TESTMODE_OVERRIDE]
if {$OVERRIDE_PORT != [list]} {
  define_dft shift_enable -name TModeClkGateOverride -design $TOP_DESIGN -active high $OVERRIDE_PORT
}

set CLOCK_IN_PORT [list]
foreach CP $CLK_PORT {
  lappend CLOCK_IN_PORT [find ./ -port ports_in/$CP]
}
set i 0
if {$CLOCK_IN_PORT != [list]} {
  foreach CIP $CLOCK_IN_PORT {
    incr i
    define_dft test_clock -name CLK$i -controllable -design $TOP_DESIGN $CIP
  }
}

set RESET_PORT [list]
foreach RP $RST_PORT {
  lappend RESET_PORT [find ./ -port ports_in/$RP]
}
set i 0
if {$RESET_PORT != [list]} {
  foreach RP $RESET_PORT {
    if {[lindex $RST_ACTIVE $i] == "low"} {
      set act high
    } else {
      set act low
    }
    incr i
    define_dft test_mode -scan_shift -name RESET$i -design $TOP_DESIGN -active $act $RP
  }
}
set JT_CLOCK_PORT [find / -port ports_in/$JTAG_CLK_PORT]
set DEBUG_CLOCK_PORT [list]
set DEBUG_CLOCK_NAME [list]
if {$JT_CLOCK_PORT != [list]} {
  set DEBUG_CLOCK_PORT $JT_CLOCK_PORT
  set DEBUG_CLOCK_NAME JTCK
}
if {$DEBUG_CLOCK_PORT != [list]} {
  define_dft test_clock -name $DEBUG_CLOCK_NAME $DEBUG_CLOCK_PORT -controllable -design $TOP_DESIGN
}
set JTRST_PORT [find / -port ports_in/$JTAG_RST_PORT]
if {$JTRST_PORT != [list]} {
  define_dft test_mode -scan_shift -name JTRST -design $TOP_DESIGN -active high $JTRST_PORT
}
if {($LOW_POWER_FLOW == 1) && (($LOW_POWER_GOAL == 3) || ($LOW_POWER_GOAL == 5))} {
  set_attribute lp_clock_gating_control_point precontrol [find / -design $TOP_DESIGN]
  if {$OVERRIDE_PORT != [list]} {
    set_attribute lp_clock_gating_test_signal $TESTMODE_OVERRIDE [find / -design $TOP_DESIGN]
  } else {
    set_attribute lp_clock_gating_test_signal test_se [find / -design $TOP_DESIGN]
  }
}
report dft_setup
check_dft_rules -max_print_violations -1
if {$OVERRIDE_PORT != [list]} {
  fix_dft_violations -clock -test_control $TESTMODE_OVERRIDE
} else {
  fix_dft_violations -clock -test_control test_se
}
if {$TMODE_PORT != [list]} {
  fix_dft_violations -async_reset -async_set -test_control $TESTMODE
} else {
  fix_dft_violations -async_reset -async_set -test_control test_se
}
check_dft_rules -max_print_violations -1
report dft_registers -fail_tdrc -dont_scan
