#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
#
# Copyright notice:
# "(c) 2013 Cadence Design System, Inc. All rights reserved worldwide."
#
#
# This work may not be copied, modified, re-published, uploaded, executed, or
# distributed in any way, in any medium, whether in whole or in part, without
# prior written permission from Cadence Design System, Inc.
# 
#----------------------------------------------------------------------------

###############################################################################
# Clock uncertainty
###############################################################################

set_clock_uncertainty 0.200 -setup [all_clocks]
set_clock_uncertainty 0.055 -hold  [all_clocks]

#######################################
# Transitions
#######################################
set_max_transition   0.15      [current_design]
set_clock_transition 0.04      [all_clocks]

#######################################
# output loads in pF
#######################################
set_load             0.05      [all_outputs]

#########################
## Input Driving Cell
#########################
set_driving_cell -lib_cell $DRIVE_CELL -pin Z [remove_from_collection [all_inputs] \
                 [get_ports {apb_pclk \
                             uc_clk \
                             pipe4_clk \
                             pipe7_l00_clk \
                             pipe7_l01_clk \
                             pma_tx_td_clk \
                             pma_cmn_refclk0_int \
                             pma_cmn_refclk1_int \
                             tap_tck \
                             uc_top_tap_tck \
                             uc_l01_tap_tck \
                             uc_l23_tap_tck \
                             ieee1687_tck\
                             bscan_ext_clockdr \
                             apb_preset_n \
                             uc_reset_n \
                             phy_reset_n \
                             pipe4_reset_n \
                             pipe7_reset_n \
                             dp_reset_n \
                             tap_trst_n \
                             uc_top_tap_trst_n \
                             uc_l01_tap_trst_n \
                             uc_l23_tap_trst_n \
                             ieee1687_rstn}]]

#########################
## Input Max Capacitance
#########################
set_max_capacitance 0.050 [all_inputs]
