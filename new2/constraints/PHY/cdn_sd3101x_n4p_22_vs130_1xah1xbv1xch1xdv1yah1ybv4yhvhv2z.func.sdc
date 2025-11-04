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

#####################################################
set sdc_version 1.7

###############################################################################
## set_mode
################################################################################
set_mode -type {cell} func [get_cells u_mp_pma]

###############################################################################
# set_case_analysis
###############################################################################

set_case_analysis 0 [get_ports {scanmode}]
set_case_analysis 0 [get_ports {scanen}]
set_case_analysis 0 [get_ports {iddq_en}]

#######################################
# Clock definitions
#######################################
#These clocks connect with SOC, External Clocks
#dtb_clk

set apb_pclk_period         2.500;  # 400MHz
set uc_clk_period           2.000;  # 500MHz
set tap_clk_period          10.000; # 100MHz
set bscan_clk_period        10.000; # 100MHz
set ref_clk_period          6.400;  # 156.25MHz   Stable TODO: 100MHz
set ref_clk_out_period      25.600; # 39.0625MHz = 156.25/4  Stable TODO: 25MHz
set psm_clk_period          8.000;  # 125MHz

set datart_clk_pipe_period  1.600;  # 625MHz - worst case is USB4  Stable TODO: 1.25G if pcs/pma can support 16bits
set fullrt_clk_pipe_period  1.600;  # 625MHz - worst case is USB4  Stable TODO: 1.25G if pcs/pma can support 16bits
set datart_clk_raw_period   1.000;  # 1GHz   - worst case is DP UHBR20 with 20bits
set fullrt_clk_raw_period   1.000;  # 1GHz   - worst case is DP UHBR20 with 20bits

set pll0_prog0_clk_period   1.600;  # 625MHz - worst case is USB4
set pll0_prog1_clk_period   1.600;  # 625MHz - set for USB4 Gen2/3 (pipe_clk_max)
set pll1_prog0_clk_period   1.000;  # 1GHz   - worst case is DP UHBR20 with 20bits
set pll1_prog1_clk_period   1.000;  # 1GHz   - worst case is DP UHBR20 with 20bits
set phy_st_chg_period       10.000; # 100MHz

set vclk_period             5.000;  # 200MHz - virtual clock

###############################################################################
# PHY Level Clocks
###############################################################################
#APB_CLK
create_clock -name APB_PCLK               -period $apb_pclk_period   [get_ports {apb_pclk}]

# uC clock
create_clock -name UC_CLK                 -period $uc_clk_period     [get_ports {uc_clk}]

# TAP clock
create_clock -name TAP_CLK                -period $tap_clk_period    [get_ports {tap_tck}]

# Top uC TAP clock
create_clock -name UC_TOP_TAP_CLK         -period $tap_clk_period    [get_ports {uc_top_tap_tck}]

# Lane01 uC TAP clock
create_clock -name UC_LANE01_TAP_CLK      -period $tap_clk_period    [get_ports {uc_l01_tap_tck}]

# Lane23 uC TAP clock
create_clock -name UC_LANE23_TAP_CLK      -period $tap_clk_period    [get_ports {uc_l23_tap_tck}]

# IEEE1686 TAP clock
create_clock -name I1687_TAP_CLK          -period $tap_clk_period    [get_ports {ieee1687_tck}]

# BSCAN clock
create_clock -name BSCAN_EXT_CLOCKDR_CLK  -period $bscan_clk_period  [get_ports {bscan_ext_clockdr}]




###############################################################################
# PMA level clocks
###############################################################################
# The clocks defined below are required to be able to use the macro liberty files.

# Reference clock
#cmn_ref_clk & cmn_ref_clk_gated
create_clock -name REFCLK0      -period $ref_clk_out_period  [get_pins u_mp_pma/REFCLK0_OUT]
create_clock -name REFCLK1      -period $ref_clk_out_period  [get_pins u_mp_pma/REFCLK1_OUT]

create_clock -name REFCLK_INT0 -period $ref_clk_period  [get_ports pma_cmn_refclk0_int]
create_clock -name REFCLK_INT1 -period $ref_clk_period  [get_ports pma_cmn_refclk1_int]

#PLL Prog clock
#PIPE7 Max Clock
create_clock -name PLL0_PROG0 -period $pll0_prog0_clk_period  [get_pins u_mp_pma/cmn_pll0_clk_prog0]
#Unused in PCS Level
create_clock -name PLL0_PROG1 -period $pll0_prog1_clk_period  [get_pins u_mp_pma/cmn_pll0_clk_prog1]
#Full rate for Raw Tx data clock
create_clock -name PLL1_PROG0 -period $pll1_prog0_clk_period  [get_pins u_mp_pma/cmn_pll1_clk_prog0]
#Data rate for Raw Tx data clock
create_clock -name PLL1_PROG1 -period $pll1_prog1_clk_period  [get_pins u_mp_pma/cmn_pll1_clk_prog1]

# PSM clock
create_clock -name PSMCLK -period $psm_clk_period [get_pins u_mp_pma/cmn_psm_clk_out]

#DATART clock for PIPE
create_clock -name DATART_LN0_PIPE -period $datart_clk_pipe_period  [get_pins u_mp_pma/xcvr_pll_clk_datart_ln_0] 
create_clock -name DATART_LN3_PIPE -period $datart_clk_pipe_period  [get_pins u_mp_pma/xcvr_pll_clk_datart_ln_3] 

#PIPE4 clock
create_generated_clock -name PIPE4_CLK_LN0 -divide_by 2 -add -master_clock [get_clocks DATART_LN0_PIPE] \
                       -source [get_pins u_mp_pma/xcvr_pll_clk_datart_ln_0] \
                       [get_pins u_phy_clkrst/u_usb_pcs_tx_td_clk_div/clock_div2_reg/q]

create_generated_clock -name PIPE4_CLK_LN3 -divide_by 2 -add -master_clock [get_clocks DATART_LN3_PIPE] \
                       -source [get_pins u_mp_pma/xcvr_pll_clk_datart_ln_3] \
                       [get_pins u_phy_clkrst/u_usb_pcs_tx_td_clk_div/clock_div2_reg/q]

#PIPE7 clock
# When integrating the PHY SDC into an integrated solution, this clock constraint should be removed.
# This clock is driven from the pipe_clk_max PHY clock output / PLL0_PROG0 clock definition.
create_clock -name PIPE7_CLK_LN0 -period $datart_clk_pipe_period  [get_ports pipe7_l00_clk] 
create_clock -name PIPE7_CLK_LN1 -period $datart_clk_pipe_period  [get_ports pipe7_l01_clk] 

#FULLRT clock for PIPE
create_clock -name FULLRT_LN0_PIPE -period $fullrt_clk_pipe_period [get_pins u_mp_pma/xcvr_pll_clk_fullrt_ln_0]            
create_clock -name FULLRT_LN3_PIPE -period $fullrt_clk_pipe_period [get_pins u_mp_pma/xcvr_pll_clk_fullrt_ln_3]            

#Rx Data clock for PIPE
create_clock -name LN1_RXCLK_PIPE -period $datart_clk_pipe_period  [get_pins u_mp_pma/LN_1_RXCLK]
create_clock -name LN2_RXCLK_PIPE -period $datart_clk_pipe_period  [get_pins u_mp_pma/LN_2_RXCLK]

##Tx data clock for Raw 
#create_clock -name DATART_RAW -period $datart_clk_raw_period  [get_pins u_mp_pma/cmn_pll1_clk_datart0] 
#create_clock -name FULLRT_RAW -period $fullrt_clk_raw_period  [get_pins u_mp_pma/cmn_pll1_clk_fullrt] 

create_clock -name TX_DATART_RAW -period $datart_clk_raw_period  [get_ports pma_tx_td_clk]

# Clock definition for toggle F/F in PHY state change monitor - this clock drives a single F/F.  The reason for creating this 
#   clock is to eliminate a synthesis warning that a sequential element has no clock defined.
create_clock -name ST_CHG_CLK_USB_LN0 -period $phy_st_chg_period [get_pins u_phy_state_chg_monitor_usb3_usb4_l00/u_phy_scan_mux_pipe_phy_status/fcn_signal_in]
create_clock -name ST_CHG_CLK_USB_LN1 -period $phy_st_chg_period [get_pins u_phy_state_chg_monitor_usb4_l01/u_phy_scan_mux_pipe_phy_status/fcn_signal_in]


# RefClk Rcv Out
#create_clock -name RCVCLK -period $ref_clk_period [get_pins u_mp_pma/cmn_ref_clk_rcv]

#create_clock -name V_CLK            -period $vclk_period

###############################################################################
# Clock groups - based on the number of lanes
###############################################################################
set_clock_groups -async -name grp1 \
     -group {APB_PCLK} \
     -group {UC_CLK} \
     -group {TAP_CLK} \
     -group {UC_TOP_TAP_CLK} \
     -group {UC_LANE01_TAP_CLK} \
     -group {UC_LANE23_TAP_CLK} \
     -group {I1687_TAP_CLK} \
     -group {BSCAN_EXT_CLOCKDR_CLK} \
     -group {PSMCLK} \
     -group {ST_CHG_CLK_USB_LN0} \
     -group {ST_CHG_CLK_USB_LN1} \
     -group {REFCLK0} \
     -group {REFCLK1} \
     -group {REFCLK_INT0} \
     -group {REFCLK_INT1} \
     -group {PLL0_PROG0} \
     -group {PLL0_PROG1} \
     -group {PLL1_PROG0} \
     -group {PLL1_PROG1} \
     -group {DATART_LN0_PIPE PIPE4_CLK_LN0} \
     -group {DATART_LN3_PIPE PIPE4_CLK_LN3} \
     -group {PIPE7_CLK_LN0 PIPE7_CLK_LN1} \
     -group {FULLRT_LN0_PIPE} \
     -group {FULLRT_LN3_PIPE} \
     -group {LN1_RXCLK_PIPE} \
     -group {LN2_RXCLK_PIPE} \
     -group {TX_DATART_RAW}

###############################################################################
# I/O delay
###############################################################################

set tap_indly           [expr $tap_clk_period * 0.7]
set tap_outdly          [expr $tap_clk_period * 0.7]

set core_idelay         [expr $datart_clk_pipe_period * 0.7]
set core_odelay         [expr $datart_clk_pipe_period * 0.7]

set apb_idelay          [expr $apb_pclk_period * 0.7]
set apb_odelay          [expr $apb_pclk_period * 0.7]

set uc_idelay           [expr $uc_clk_period * 0.7]
set uc_odelay           [expr $uc_clk_period * 0.7]

set v_idelay            [expr $vclk_period * 0.7]
set v_odelay            [expr $vclk_period * 0.7]

set max_path_odelay     5.000;  # 5 nsec
set max_path_idelay     5.000;  # 5 nsec
set qualifier_delay     2.000;  # 2 nsec - 2 1GHz clock cycles

###############################################################################
## TAP interface
set_input_delay  $tap_indly  -clock [get_clocks {TAP_CLK}] [get_ports {tap_tms}]
set_input_delay  $tap_indly  -clock [get_clocks {TAP_CLK}] [get_ports {tap_tdi}]
set_output_delay $tap_outdly -clock [get_clocks {TAP_CLK}] [get_ports {tap_tdo}]
set_output_delay $tap_outdly -clock [get_clocks {TAP_CLK}] [get_ports {tap_tdoen}]

set_input_delay  $tap_indly  -clock [get_clocks {UC_TOP_TAP_CLK}] [get_ports {uc_top_tap_tms}]
set_input_delay  $tap_indly  -clock [get_clocks {UC_TOP_TAP_CLK}] [get_ports {uc_top_tap_tdi}]
set_output_delay $tap_outdly -clock [get_clocks {UC_TOP_TAP_CLK}] [get_ports {uc_top_tap_tdo}]
set_output_delay $tap_outdly -clock [get_clocks {UC_TOP_TAP_CLK}] [get_ports {uc_top_tap_tdoen}]

set_input_delay  $tap_indly  -clock [get_clocks {UC_LANE01_TAP_CLK}] [get_ports {uc_l01_tap_tms}]
set_input_delay  $tap_indly  -clock [get_clocks {UC_LANE01_TAP_CLK}] [get_ports {uc_l01_tap_tdi}]
set_output_delay $tap_outdly -clock [get_clocks {UC_LANE01_TAP_CLK}] [get_ports {uc_l01_tap_tdo}]
set_output_delay $tap_outdly -clock [get_clocks {UC_LANE01_TAP_CLK}] [get_ports {uc_l01_tap_tdoen}]

set_input_delay  $tap_indly  -clock [get_clocks {UC_LANE23_TAP_CLK}] [get_ports {uc_l23_tap_tms}]
set_input_delay  $tap_indly  -clock [get_clocks {UC_LANE23_TAP_CLK}] [get_ports {uc_l23_tap_tdi}]
set_output_delay $tap_outdly -clock [get_clocks {UC_LANE23_TAP_CLK}] [get_ports {uc_l23_tap_tdo}]
set_output_delay $tap_outdly -clock [get_clocks {UC_LANE23_TAP_CLK}] [get_ports {uc_l23_tap_tdoen}]

###############################################################################
## I1687 interface
set_input_delay  $tap_indly  -clock [get_clocks {I1687_TAP_CLK}] [get_ports {ieee1687_si}]
set_input_delay  $tap_indly  -clock [get_clocks {I1687_TAP_CLK}] [get_ports {ieee1687_capture_en}]
set_input_delay  $tap_indly  -clock [get_clocks {I1687_TAP_CLK}] [get_ports {ieee1687_shift_en}]
set_input_delay  $tap_indly  -clock [get_clocks {I1687_TAP_CLK}] [get_ports {ieee1687_update_en}]
set_input_delay  $tap_indly  -clock [get_clocks {I1687_TAP_CLK}] [get_ports {ieee1687_sel}]

set_output_delay $tap_outdly -clock [get_clocks {I1687_TAP_CLK}] [get_ports {ieee1687_so}]

###############################################################################
## External boundary scan
set_input_delay  $tap_indly  -clock "BSCAN_EXT_CLOCKDR_CLK" [get_ports {bscan_ext_shiftdr}]
set_input_delay  $tap_indly  -clock "BSCAN_EXT_CLOCKDR_CLK" [get_ports {rx_bscan_ext_tdi}]

#set_input_delay  $tap_indly  -clock "BSCAN_EXT_CLOCKDR_CLK" [get_ports {bscan_ext_select}]
#set_input_delay  $tap_indly  -clock "BSCAN_EXT_CLOCKDR_CLK" [get_ports {tx_bscan_ext_updatedr}]
#set_input_delay  $tap_indly  -clock "BSCAN_EXT_CLOCKDR_CLK" [get_ports {tx_bscan_ext_mode_c}]
#set_input_delay  $tap_indly  -clock "BSCAN_EXT_CLOCKDR_CLK" [get_ports {tx_bscan_ext_ac}]
#set_input_delay  $tap_indly  -clock "BSCAN_EXT_CLOCKDR_CLK" [get_ports {tx_bscan_ext_acpulse}]
#set_input_delay  $tap_indly  -clock "BSCAN_EXT_CLOCKDR_CLK" [get_ports {rx_bscan_ext_pc}]
#set_input_delay  $tap_indly  -clock "BSCAN_EXT_CLOCKDR_CLK" [get_ports {rx_bscan_ext_ac}]

set_output_delay $tap_outdly -clock "BSCAN_EXT_CLOCKDR_CLK" [get_ports {tx_bscan_ext_tdo}]

###############################################################################
#PIPE4 interface
# The below input/output delays shall be removed for IS SDC.  These are internal synchronous paths
#   between the controller and PHY.
# For the 16-bit PIPE data width case use "DATART_LN0_PIPE".  Change clock to PIPE_CLK_LN${lane} for 32-bit PIPE data width case
#USB3.2 5G  32bit: PIPE 125M(DIV clock), Interal 250M (datart clk)
#USB3.2 5G 16bit/10G 16bit/10G 32bit: PIPE = Internal (datart clk)
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_rate]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_powerdown[*]]
#set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_eb_mode]; # already have false path

set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_rx_polarity]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_rx_termination]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_rx_eq_training]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_tx_data[*]]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_tx_data_k[*]]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_tx_sync_header[*]]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_tx_start_block]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_tx_data_valid]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_tx_det_rx_lpbk]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_tx_elec_idle]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_tx_ones_zeros]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_tx_128b_enc_byp]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_tx_deemph[*]]

set_output_delay $core_odelay -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_phy_status]
set_output_delay $core_odelay -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_rx_data[*]]
set_output_delay $core_odelay -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_rx_data_k[*]]
set_output_delay $core_odelay -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_rx_sync_header[*]]
set_output_delay $core_odelay -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_rx_start_block]
set_output_delay $core_odelay -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_rx_data_valid]
set_output_delay $core_odelay -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_rx_valid]
set_output_delay $core_odelay -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_rx_status[*]]
#set_output_delay $core_odelay -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l00_rx_elec_idle]; # already have false path

set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_rx_polarity]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_rx_termination]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_rx_eq_training]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_tx_data[*]]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_tx_data_k[*]]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_tx_sync_header[*]]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_tx_start_block]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_tx_data_valid]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_tx_det_rx_lpbk]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_tx_elec_idle]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_tx_ones_zeros]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_tx_128b_enc_byp]
set_input_delay $core_idelay  -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_tx_deemph[*]]

set_output_delay $core_odelay -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_phy_status]
set_output_delay $core_odelay -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_rx_data[*]]
set_output_delay $core_odelay -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_rx_data_k[*]]
set_output_delay $core_odelay -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_rx_sync_header[*]]
set_output_delay $core_odelay -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_rx_start_block]
set_output_delay $core_odelay -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_rx_data_valid]
set_output_delay $core_odelay -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_rx_valid]
set_output_delay $core_odelay -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_rx_status[*]]
#set_output_delay $core_odelay -add -clock "DATART_LN0_PIPE" [get_ports pipe4_l01_rx_elec_idle]; # already have false path

set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_rate]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_powerdown[*]]
#set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_eb_mode]; # already have false path

set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_rx_polarity]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_rx_termination]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_rx_eq_training]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_tx_data[*]]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_tx_data_k[*]]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_tx_sync_header[*]]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_tx_start_block]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_tx_data_valid]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_tx_det_rx_lpbk]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_tx_elec_idle]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_tx_ones_zeros]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_tx_128b_enc_byp]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_tx_deemph[*]]

set_output_delay $core_odelay -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_phy_status]
set_output_delay $core_odelay -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_rx_data[*]]
set_output_delay $core_odelay -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_rx_data_k[*]]
set_output_delay $core_odelay -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_rx_sync_header[*]]
set_output_delay $core_odelay -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_rx_start_block]
set_output_delay $core_odelay -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_rx_data_valid]
set_output_delay $core_odelay -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_rx_valid]
set_output_delay $core_odelay -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_rx_status[*]]
#set_output_delay $core_odelay -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l00_rx_elec_idle]; # already have false path

set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_rx_polarity]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_rx_termination]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_rx_eq_training]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_tx_data[*]]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_tx_data_k[*]]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_tx_sync_header[*]]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_tx_start_block]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_tx_data_valid]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_tx_det_rx_lpbk]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_tx_elec_idle]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_tx_ones_zeros]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_tx_128b_enc_byp]
set_input_delay $core_idelay  -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_tx_deemph[*]]

set_output_delay $core_odelay -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_phy_status]
set_output_delay $core_odelay -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_rx_data[*]]
set_output_delay $core_odelay -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_rx_data_k[*]]
set_output_delay $core_odelay -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_rx_sync_header[*]]
set_output_delay $core_odelay -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_rx_start_block]
set_output_delay $core_odelay -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_rx_data_valid]
set_output_delay $core_odelay -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_rx_valid]
set_output_delay $core_odelay -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_rx_status[*]]
#set_output_delay $core_odelay -add -clock "DATART_LN3_PIPE" [get_ports pipe4_l01_rx_elec_idle]; # already have false path

#set_false_path -from [get_ports pipe4_l0*_rx_polarity]
set_false_path -from [get_ports pipe4_eb_mode]
set_false_path -to   [get_ports pipe4_l0*_rx_elec_idle]

###############################################################################
#PIPE7 interface
set_input_delay $core_idelay  -add -clock "PIPE7_CLK_LN0" [get_ports pipe7_l00_rate[*]]
#set_input_delay $core_idelay  -add -clock "PIPE7_CLK_LN0" [get_ports pipe7_l00_rx_termination]; # already have false path
#set_input_delay $core_idelay  -add -clock "PIPE7_CLK_LN0" [get_ports pipe7_l00_rx_standby]; # already have false path
set_input_delay $core_idelay  -add -clock "PIPE7_CLK_LN0" [get_ports pipe7_l00_powerdown[*]]
set_input_delay $core_idelay  -add -clock "PIPE7_CLK_LN0" [get_ports pipe7_l00_tx_det_rx_lpbk]
set_input_delay $core_idelay  -add -clock "PIPE7_CLK_LN0" [get_ports pipe7_l00_tx_data[*]]
set_input_delay $core_idelay  -add -clock "PIPE7_CLK_LN0" [get_ports pipe7_l00_tx_elec_idle]
set_input_delay $core_idelay  -add -clock "PIPE7_CLK_LN0" [get_ports pipe7_l00_tx_data_valid]
set_input_delay $core_idelay  -add -clock "PIPE7_CLK_LN0" [get_ports pipe7_l00_m2p_messagebus[*]]

set_output_delay $core_odelay -add -clock "PIPE7_CLK_LN0" [get_ports pipe7_l00_phy_status]
set_output_delay $core_odelay -add -clock "PIPE7_CLK_LN0" [get_ports pipe7_l00_rx_standby_status]
set_output_delay $core_odelay -add -clock "PIPE7_CLK_LN0" [get_ports pipe7_l00_p2m_messagebus[*]]

set_output_delay $core_odelay -add -clock "LN1_RXCLK_PIPE" [get_ports pipe7_l00_rx_data[*]]
set_output_delay $core_odelay -add -clock "LN1_RXCLK_PIPE" [get_ports pipe7_l00_rx_valid]
#set_output_delay $core_odelay -add -clock "LN1_RXCLK_PIPE" [get_ports pipe7_l00_rx_elec_idle]; # already have false path

set_output_delay $core_odelay -add -clock "LN2_RXCLK_PIPE" [get_ports pipe7_l00_rx_data[*]]
set_output_delay $core_odelay -add -clock "LN2_RXCLK_PIPE" [get_ports pipe7_l00_rx_valid]
#set_output_delay $core_odelay -add -clock "LN2_RXCLK_PIPE" [get_ports pipe7_l00_rx_elec_idle]; # already have false path

set_input_delay $core_idelay  -add -clock "PIPE7_CLK_LN1" [get_ports pipe7_l01_rate[*]]
#set_input_delay $core_idelay  -add -clock "PIPE7_CLK_LN1" [get_ports pipe7_l01_rx_termination]; # already have false path
#set_input_delay $core_idelay  -add -clock "PIPE7_CLK_LN1" [get_ports pipe7_l01_rx_standby]; # already have false path
set_input_delay $core_idelay  -add -clock "PIPE7_CLK_LN1" [get_ports pipe7_l01_powerdown[*]]
set_input_delay $core_idelay  -add -clock "PIPE7_CLK_LN1" [get_ports pipe7_l01_tx_det_rx_lpbk]
set_input_delay $core_idelay  -add -clock "PIPE7_CLK_LN1" [get_ports pipe7_l01_tx_data[*]]
set_input_delay $core_idelay  -add -clock "PIPE7_CLK_LN1" [get_ports pipe7_l01_tx_elec_idle]
set_input_delay $core_idelay  -add -clock "PIPE7_CLK_LN1" [get_ports pipe7_l01_tx_data_valid]
set_input_delay $core_idelay  -add -clock "PIPE7_CLK_LN1" [get_ports pipe7_l01_m2p_messagebus[*]]

set_output_delay $core_odelay -add -clock "PIPE7_CLK_LN1" [get_ports pipe7_l01_phy_status]
set_output_delay $core_odelay -add -clock "PIPE7_CLK_LN1" [get_ports pipe7_l01_rx_standby_status]
set_output_delay $core_odelay -add -clock "PIPE7_CLK_LN1" [get_ports pipe7_l01_p2m_messagebus[*]]

set_output_delay $core_odelay -add -clock "LN1_RXCLK_PIPE" [get_ports pipe7_l01_rx_data[*]]
set_output_delay $core_odelay -add -clock "LN1_RXCLK_PIPE" [get_ports pipe7_l01_rx_valid]
#set_output_delay $core_odelay -add -clock "LN1_RXCLK_PIPE" [get_ports pipe7_l01_rx_elec_idle]; # already have false path

set_output_delay $core_odelay -add -clock "LN2_RXCLK_PIPE" [get_ports pipe7_l01_rx_data[*]]
set_output_delay $core_odelay -add -clock "LN2_RXCLK_PIPE" [get_ports pipe7_l01_rx_valid]
#set_output_delay $core_odelay -add -clock "LN2_RXCLK_PIPE" [get_ports pipe7_l01_rx_elec_idle]; # already have false path


set_false_path -from [get_ports pipe7_l00_rx_standby]
set_false_path -from [get_ports pipe7_l00_rx_termination]
set_false_path -to   [get_ports pipe7_l00_rx_elec_idle]

set_false_path -from [get_ports pipe7_l01_rx_standby]
set_false_path -from [get_ports pipe7_l01_rx_termination]
set_false_path -to   [get_ports pipe7_l01_rx_elec_idle]

set_false_path -from [get_ports pipe7_clk_max_req]
set_false_path -to   [get_ports pipe7_clk_max_ack]

set_false_path -from [get_ports pipe7_pll0_en]
set_false_path -to   [get_ports pipe7_pll0_ok]

###############################################################################
# Raw I/F
for {set lane 0} {$lane < 4} {incr lane} {
set_input_delay $core_idelay -clock "TX_DATART_RAW" [get_ports pma_tx_td_ln_${lane}[*]]
set_input_delay $core_idelay -clock "TX_DATART_RAW" [get_ports pma_tx_elec_idle_ln_${lane}]
}

##############################################################################
# APB_PCLK Domain
set_input_delay  $apb_idelay -clock "APB_PCLK" [get_ports {apb_tgt_penable}]
set_input_delay  $apb_idelay -clock "APB_PCLK" [get_ports {apb_tgt_psel}]
set_input_delay  $apb_idelay -clock "APB_PCLK" [get_ports {apb_tgt_pwrite}]
set_input_delay  $apb_idelay -clock "APB_PCLK" [get_ports {apb_tgt_paddr[*]}]
set_input_delay  $apb_idelay -clock "APB_PCLK" [get_ports {apb_tgt_pwdata[*]}]

set_output_delay $apb_odelay -clock "APB_PCLK" [get_ports {apb_tgt_pready}]
set_output_delay $apb_odelay -clock "APB_PCLK" [get_ports {apb_tgt_prdata[*]}]
set_output_delay $apb_odelay -clock "APB_PCLK" [get_ports {apb_tgt_perr}]


set_input_delay  $apb_idelay -clock "APB_PCLK" [get_ports {apb_mstr_pready}]
set_input_delay  $apb_idelay -clock "APB_PCLK" [get_ports {apb_mstr_prdata[*]}]
set_input_delay  $apb_idelay -clock "APB_PCLK" [get_ports {apb_mstr_perr}]

set_output_delay $apb_odelay -clock "APB_PCLK" [get_ports {apb_mstr_paddr[*]}]
set_output_delay $apb_odelay -clock "APB_PCLK" [get_ports {apb_mstr_psel}]
set_output_delay $apb_odelay -clock "APB_PCLK" [get_ports {apb_mstr_penable}]
set_output_delay $apb_odelay -clock "APB_PCLK" [get_ports {apb_mstr_pwrite}]
set_output_delay $apb_odelay -clock "APB_PCLK" [get_ports {apb_mstr_pwdata[*]}]

###############################################################################
# SRAM interface 
set_input_delay  $uc_idelay -clock "UC_CLK" [get_ports *ram_rd_data_*[*]]

set_output_delay $uc_odelay -clock "UC_CLK" [get_ports *ram_ceb_*]
set_output_delay $uc_odelay -clock "UC_CLK" [get_ports *ram_web_*]
set_output_delay $uc_odelay -clock "UC_CLK" [get_ports sram_bweb_*[*]]
set_output_delay $uc_odelay -clock "UC_CLK" [get_ports *ram_addr_*[*]]
set_output_delay $uc_odelay -clock "UC_CLK" [get_ports *ram_wr_data_*[*]]
set_output_delay $uc_odelay -clock "UC_CLK" [get_ports sram_pwrdwn_*]

###############################################################################
# Async signal in virtual clock 
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {apb_preset_n}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {uc_reset_n}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {phy_reset_n}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {pipe4_reset_n}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {pipe7_reset_n}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {dp_reset_n}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {tap_trst_n}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {uc_top_tap_trst_n}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {uc_l01_tap_trst_n}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {uc_l23_tap_trst_n}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {ieee1687_rstn}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {typec_conn_dir}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {phy_mode[*]}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {phy_l00_ctlr_interrupt_in}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {phy_l01_ctlr_interrupt_in}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {pipe7_clk_max_req}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {pipe7_pll0_en}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {pma_xcvr_pllclk_en}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {pma_xcvr_power_state_req[*]}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {pma_xcvr_data_width[*]}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {pma_tx_lfps_en}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {pma_tx_lfps_mode}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {pma_cmn_refclk_dig_div[*]}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {pma_cmn_refclk_dig_sel}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {pma_cmn_pll0_refclk_sel[*]}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {pma_cmn_pll1_refclk_sel[*]}]; # already have false path
#set_input_delay $v_idelay -clock "V_CLK" [get_ports {ieee1687_interface_en}]; # already have false path

#set_output_delay $v_odelay -clock "V_CLK" [get_ports {phy_uc_init_complete}]; # already have false path
#set_output_delay $v_odelay -clock "V_CLK" [get_ports {phy_error_interrupt}]; # already have false path
#set_output_delay $v_odelay -clock "V_CLK" [get_ports {phy_interrupt_usb}]; # already have false path
#set_output_delay $v_odelay -clock "V_CLK" [get_ports {phy_interrupt_dp}]; # already have false path
#set_output_delay $v_odelay -clock "V_CLK" [get_ports {pipe7_clk_max_ack}]; # already have false path
#set_output_delay $v_odelay -clock "V_CLK" [get_ports {pipe7_pll0_ok}]; # already have false path
#set_output_delay $v_odelay -clock "V_CLK" [get_ports {pma_cmn_ready}]; # already have false path
#set_output_delay $v_odelay -clock "V_CLK" [get_ports {pma_xcvr_pllclk_en_ack}]; # already have false path
#set_output_delay $v_odelay -clock "V_CLK" [get_ports {pma_xcvr_power_state_ack[*]}]; # already have false path
#set_output_delay $v_odelay -clock "V_CLK" [get_ports {pma_cmn_avdd_pwrgood}]; # already have false path


#-----------------------------------------------------------------------------
# Static and async I/Os
#-----------------------------------------------------------------------------

#Set a maximum delay of 2 cycles for signals with a double sampled qualfier TODO need add more qualifier cmd.
set_max_delay $qualifier_delay -from [get_pins u_mp_pma/tx_rcv_detected_ln_0] -to [get_pins u_mp_pcs_ln_0/i_rcv_det/p_rx_status*/d]
set_max_delay $qualifier_delay -from [get_pins u_mp_pma/tx_rcv_detected_ln_0] -to [get_pins u_mp_pcs_ln_1/i_rcv_det/p_rx_status*/d]
set_max_delay $qualifier_delay -from [get_pins u_mp_pma/tx_rcv_detected_ln_3] -to [get_pins u_mp_pcs_ln_0/i_rcv_det/p_rx_status*/d]
set_max_delay $qualifier_delay -from [get_pins u_mp_pma/tx_rcv_detected_ln_3] -to [get_pins u_mp_pcs_ln_1/i_rcv_det/p_rx_status*/d]

#TODO
#set_false_path -through [get_pins {u_pma_iso_ctrl_ln_*/iso_pma_tx_fs[*]}] -through [get_pins {u_apb_top_wrapper/cdb_phy_bridged_prdata[*]}]
#set_false_path -through [get_pins {u_pma_iso_ctrl_ln_*/iso_pma_tx_lf[*]}] -through [get_pins {u_apb_top_wrapper/cdb_phy_bridged_prdata[*]}]

###############################################################################
# Scan ports
###############################################################################
# Scan
set_false_path -from [get_ports {phy_scanin[*]}]
set_false_path -from [get_ports {pma_cmn_scanin*[*]}]
set_false_path -from [get_ports {pma_xcvr_scanin*[*]}]
set_false_path -from [get_ports {scanen_cg}]
set_false_path -to   [get_ports {phy_scanout[*]}]
set_false_path -to   [get_ports {pma_cmn_scanout*[*]}]
set_false_path -to   [get_ports {pma_xcvr_scanout*[*]}]

###############################################################################
# Generic IP boundary conditions and exclusions 
###############################################################################
read_sdc -mode func ./cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z.phy_boundcond.sdc
read_sdc -mode func ./cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z.phy_exclusion.sdc
