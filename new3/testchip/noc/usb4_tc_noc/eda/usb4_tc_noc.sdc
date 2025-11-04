################################################################################
#                                                                              #
# COPYRIGHT (c) 2025 Cadence Design Systems, Inc.  All rights reserved.        #
# --------------------------------------------------------------               #
# This code is proprietary and confidential information of                     #
# Cadence Design Systems. It may not be reproduced, used or transmitted        #
# in any form whatsoever without the express and written                       #
# permission of Cadence Design Systems.                                        #
#                                                                              #
################################################################################

###############################################################################
# Set SDC Version
###############################################################################
set sdc_version 2.0

################################################################################
#  Specify clock period and name
################################################################################
# Clock name
set CLK1_NAME     CLK1
set CLK2_NAME     CLK2

# Clock port name
set CLK1_PORT     tap2apb_pclk
set CLK2_PORT     noc_clk

# Clock period in [ns]
set CLK1_PERIOD   [expr (1000.00/$CLK1_FREQ)]
set CLK2_PERIOD   [expr (1000.00/$CLK2_FREQ)]

# Skew within a single clock tree
set INTRA_CLOCK_SKEW 0.06

################################################################################
# Clock gating setup and hold skew within a single clock domain
################################################################################
set CLK_GATE_SETUP 0.75
set CLK_GATE_HOLD  0.50

set_clock_gating_check -hold $CLK_GATE_HOLD -setup $CLK_GATE_SETUP

######################################################################################
#  Define Variables for Constraints
######################################################################################
#####################################################
#
#  Create variables for the external delay on
#  each of the interfaced
#  By Default the logic under test gets 1/3 the timing
#  Budget.  Changing the vars will change the budget
#  for the whole interface.
#
#####################################################
set CLK1_HALF         [expr 0.50 * $CLK1_PERIOD]
set CLK1_ONETHIRD     [expr 0.33 * $CLK1_PERIOD]
set CLK1_ONEFORTH     [expr 0.25 * $CLK1_PERIOD]
set CLK1_TWOTENTH     [expr 0.20 * $CLK1_PERIOD]
set CLK1_ONETENTH     [expr 0.10 * $CLK1_PERIOD]

set CLK2_HALF         [expr 0.50 * $CLK2_PERIOD]
set CLK2_ONETHIRD     [expr 0.33 * $CLK2_PERIOD]
set CLK2_ONEFORTH     [expr 0.25 * $CLK2_PERIOD]
set CLK2_TWOTENTH     [expr 0.20 * $CLK2_PERIOD]
set CLK2_ONETENTH     [expr 0.10 * $CLK2_PERIOD]

###############################################################################
# Source Clocks
###############################################################################
#Clock definition on ports
create_clock -name $CLK1_NAME [get_ports $CLK1_PORT] -period $CLK1_PERIOD -waveform "0 $CLK1_HALF"
create_clock -name $CLK2_NAME [get_ports $CLK2_PORT] -period $CLK2_PERIOD -waveform "0 $CLK2_HALF"

###############################################################################
# Clock groups
###############################################################################
#Use -physically_exclusive option for clocks that share the same pin (cannot physically exist together)
set_clock_groups -async -name grp1 -group {CLK1} -group {CLK2}

##################################################
#clock uncertainty
##################################################
set_clock_uncertainty $CLK1_ONEFORTH -setup [all_clocks]
set_clock_uncertainty 0.0 -hold  [all_clocks]

set_clock_uncertainty -setup -from [get_clocks $CLK1_NAME] -to  [get_clocks $CLK1_NAME] $INTRA_CLOCK_SKEW
set_clock_uncertainty -hold  -from [get_clocks $CLK1_NAME] -to  [get_clocks $CLK1_NAME] 0

set_clock_uncertainty -setup -from [get_clocks $CLK2_NAME] -to  [get_clocks $CLK2_NAME] $INTRA_CLOCK_SKEW
set_clock_uncertainty -hold  -from [get_clocks $CLK2_NAME] -to  [get_clocks $CLK2_NAME] 0

##################################################
# Constraints for all generic ports
echo "# Constraints for all generic ports"
##################################################

### Group all inputs for clk1 ###
set clk1_input    { \
                    cdb_paddr[*] \
                    cdb_psel \
                    cdb_penable \
                    cdb_pwrite \
                    cdb_pwdata[*] \
                    cdb_pstrb[*] \
                  }

set clk1_reset    { rst_n }

### Group all outputs for clk1 ###
### Remove clock out ports from outputs ###
set clk1_output    { \
                    cdb_pready \
                    cdb_prdata[*] \
                    cdb_pslverr \
                  }

### Group all inputs for clk2 ###
set clk2_input    { \
                    apb_mstr_paddr[*] \
                    apb_mstr_psel \
                    apb_mstr_penable \
                    apb_mstr_pwrite \
                    apb_mstr_pwdata[*] \
                    apb_mstr_pstrb[*] \
                    cmn_cdb_pready \
                    cmn_cdb_prdata[*] \
                    tc_reg_pready \
                    tc_reg_prdata[*] \
                    usb_sub_sys_pready \
                    usb_sub_sys_prdata[*] \
                    pam3_sub_sys_pready \
                    pam3_sub_sys_prdata[*] \
                    apb_tgt_pready \
                    apb_tgt_prdata[*] \
                    apb_tgt_pslverr \
                    xcvr_ln_0_pready \
                    xcvr_ln_0_prdata[*] \
                  }


### Group all outputs for clk2 ###
### Remove clock out ports from outputs ###
set clk2_output    { \
                    apb_mstr_pready \
                    apb_mstr_prdata[*] \
                    apb_mstr_pslverr \
                    cmn_cdb_paddr[*] \
                    cmn_cdb_psel \
                    cmn_cdb_penable \
                    cmn_cdb_pwrite \
                    cmn_cdb_pwdata[*] \
                    cmn_cdb_pstrb[*] \
                    tc_reg_paddr[*] \
                    tc_reg_psel \
                    tc_reg_penable \
                    tc_reg_pwrite \
                    tc_reg_pwdata[*] \
                    tc_reg_pstrb[*] \
                    usb_sub_sys_paddr[*] \
                    usb_sub_sys_psel \
                    usb_sub_sys_penable \
                    usb_sub_sys_pwrite \
                    usb_sub_sys_pwdata[*] \
                    usb_sub_sys_pstrb[*] \
                    pam3_sub_sys_paddr[*] \
                    pam3_sub_sys_psel \
                    pam3_sub_sys_penable \
                    pam3_sub_sys_pwrite \
                    pam3_sub_sys_pwdata[*] \
                    pam3_sub_sys_pstrb[*] \
                    apb_tgt_paddr[*] \
                    apb_tgt_psel \
                    apb_tgt_penable \
                    apb_tgt_pwrite \
                    apb_tgt_pwdata[*] \
                    apb_tgt_pstrb[*] \
                    xcvr_ln_0_paddr[*] \
                    xcvr_ln_0_psel \
                    xcvr_ln_0_penable \
                    xcvr_ln_0_pwrite \
                    xcvr_ln_0_pwdata[*] \
                    xcvr_ln_0_pstrb[*] \
                  }

echo "#####################################################"
echo "  Defining constraints for input and output delays"
echo "#####################################################"
##################################################
## set delays
##################################################
set_input_delay  -min $CLK1_ONETENTH -clock $CLK1_NAME $clk1_reset
set_input_delay  -max $CLK1_TWOTENTH -clock $CLK1_NAME $clk1_reset

set_input_delay  -min $CLK1_ONETENTH -clock $CLK1_NAME $clk1_input
set_input_delay  -max $CLK1_TWOTENTH -clock $CLK1_NAME $clk1_input
set_output_delay -min $CLK1_ONETENTH -clock $CLK1_NAME $clk1_output
set_output_delay -max $CLK1_TWOTENTH -clock $CLK1_NAME $clk1_output


set_input_delay  -min $CLK2_ONETENTH -clock $CLK2_NAME $clk2_input
set_input_delay  -max $CLK2_TWOTENTH -clock $CLK2_NAME $clk2_input
set_output_delay -min $CLK2_ONETENTH -clock $CLK2_NAME $clk2_output
set_output_delay -max $CLK2_TWOTENTH -clock $CLK2_NAME $clk2_output

##################################################
# Input constraints: drive cell
echo "Input constraints: set drive cell"
##################################################
set_driving_cell -lib_cell $DRIVE_CELL -pin Q $clk1_input
set_driving_cell -lib_cell $DRIVE_CELL -pin Q $clk1_reset
set_driving_cell -lib_cell $DRIVE_CELL -pin Q $clk2_input

##################################################
# Defining constraints for combinatorial paths
echo "Defining constraints for combinatorial paths"
###################################################
# These paths are only required if `CDNSUART_META_* are undefined
#set_max_delay 20 -from [get_ports ua_rxd]  -to [get_ports ua_txd]
#set_max_delay 20 -from [get_ports ua_ncts] -to [get_ports ua_nrts]

