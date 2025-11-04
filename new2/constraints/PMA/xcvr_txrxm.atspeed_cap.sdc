###############################################################################
# These confidential and proprietary static timing constraints for a Hardware
# component may be used only as authorized by a licensing agreement from
# Cadence Design Systems, Inc. In the event of publication, the following
# notice is applicable:
#
#       (C) COPYRIGHT 2009 Cadence Design Systems, Inc.
#           ALL RIGHTS RESERVED
#
# The entire notice above must be reproduced on all authorized copies of
# this code.
###############################################################################
#
# Filename  : xcvr.atspeed_cap.tcl
# Version   : $Revision2638 $
# Date/Time : $Date2013-02-19 13:53:13 -0500 (Tue, 19 Feb 2013) $
#
# Author    : dmasters
# Edited by : dmasters
# Abstract  : Functional & ATPG timing constraints for pma_xcvr_lane.
#
###############################################################################
# Change Log
# $Log$
#
###############################################################################
# TAG: 05/19/2014

if { [info exists load_syn_sdc] && $load_syn_sdc} {
    source $DUT_PATH/design/constraints/PMA/xcvr_txrxm.preamble.sdc
} else {
    source [file dirname [info script]]/xcvr_txrxm.preamble.sdc
}

current_design  xcvr_txrxm


###############################################################################
# Specific Mode/Case Analysis
###############################################################################
set_case_analysis 1 [get_ports xcvr_scanmode]


###############################################################################
# Clock Definitions
###############################################################################
# JMY 20201102 Update to minimum frequency of 200MHz per Mark Taylor
create_clock \
    -name           SCAN_REFCLK_ACAP_IN \
    -period         $CLK200_PERIOD \
    -waveform       $CLK200_WAVEFORM \
    [get_ports cmn_scanclk_ref_clk_in]

create_clock \
    -name           REFCLK_ACAP_GATED_IN \
    -period         $CLK200_PERIOD \
    -waveform       $CLK200_WAVEFORM \
    [get_ports cmn_ref_clk_gated_in]


#create_generated_clock \
#    -name           REFCLK_ACAP_GATED_IN \
#    -divide_by      1 \
#    -master_clock   [get_clocks SCAN_REFCLK_ACAP_IN] \
#    -source         [get_ports cmn_scanclk_ref_clk_in] \
#    -add \
#    [get_ports cmn_ref_clk_gated_in]

create_clock \
    -name           PSMCLK_ACAP \
    -period         $CLK200_PERIOD \
    -waveform       $CLK200_WAVEFORM \
    [get_ports xcvr_psm_clk]

create_clock \
    -name           PCLK_ACAP_IN \
    -period         $CLK200_PERIOD \
    -waveform       $CLK200_WAVEFORM \
    [get_ports cmn_cdb_pclk_in]

############################################
# tx_td_clk domain
############################################

   if { $do_pcie_gen3 } {
      create_clock \
         -name     TXTDCLK_GEN3_ACAP \
         -period   $CLK500_PERIOD \
         -waveform $CLK500_WAVEFORM \
         -add \
         [get_ports tx_td_clk]
   }

   if { $do_pcie_gen2 } {
      create_clock \
         -name     TXTDCLK_GEN2_ACAP \
         -period   $CLK250_PERIOD \
         -waveform $CLK250_WAVEFORM \
         -add \
         [get_ports tx_td_clk]
   }

   if { $do_pcie_gen1 } {
      create_clock \
         -name     TXTDCLK_GEN1_ACAP \
         -period   $CLK125_PERIOD \
         -waveform $CLK125_WAVEFORM \
         -add \
         [get_ports tx_td_clk]
   }

   if { $do_usb30 } {
      create_clock \
         -name     TXTDCLK_USB30_ACAP \
         -period   $CLK625_PERIOD \
         -waveform $CLK625_WAVEFORM \
         -add \
         [get_ports tx_td_clk]
   }
   if { $do_10gkr } {
      create_clock \
         -name     TXTDCLK_10GKR_ACAP \
         -period   $CLK644P53_PERIOD \
         -waveform $CLK644P53_WAVEFORM \
         -add \
         [get_ports tx_td_clk]
   }


   if { $do_gbe } {
      create_clock \
         -name     TXTDCLK_GBE_ACAP \
         -period   $CLK62P5_PERIOD \
         -waveform $CLK62P5_WAVEFORM \
         -add \
         [get_ports tx_td_clk]
   }

############################################
# ser_clk domain
############################################
# Lane xcvr_scanclk_ser_clk_ln_* input pins.

   if { $do_pcie_gen3 } {
      create_clock \
         -name     SERCLK_GEN3_ACAP \
         -period   $CLK500_PERIOD \
         -waveform $CLK500_WAVEFORM \
         -add \
         [get_ports xcvr_scanclk_ser_clk]
   }
   
   if { $do_pcie_gen2 } {
      create_clock \
         -name     SERCLK_GEN2_ACAP \
         -period   $CLK250_PERIOD \
         -waveform $CLK250_WAVEFORM \
         -add \
         [get_ports xcvr_scanclk_ser_clk]
   }
   
   if { $do_pcie_gen1 } {
      create_clock \
         -name     SERCLK_GEN1_ACAP \
         -period   $CLK125_PERIOD \
         -waveform $CLK125_WAVEFORM \
         -add \
         [get_ports xcvr_scanclk_ser_clk]
   }

   if { $do_usb30 } {
      create_clock \
         -name     SERCLK_USB30_ACAP \
         -period   $CLK625_PERIOD \
         -waveform $CLK625_WAVEFORM \
         -add \
         [get_ports xcvr_scanclk_ser_clk]
   }

   if { $do_10gkr } {
      create_clock \
         -name     SERCLK_10GKR_ACAP \
         -period   $CLK644P53_PERIOD \
         -waveform $CLK644P53_WAVEFORM \
         -add \
         [get_ports xcvr_scanclk_ser_clk]
   }

   if { $do_gbe } {
      create_clock \
         -name     SERCLK_GBE_ACAP \
         -period   $CLK62P5_PERIOD \
         -waveform $CLK62P5_WAVEFORM \
         -add \
         [get_ports xcvr_scanclk_ser_clk]
   }
# Create scan clocks on Lane rx_rd_clk_ln_* output pins. 

   if { $do_pcie_gen3 } {
      create_generated_clock \
         -name         RXRDCLK_GEN3_ACAP_OUT \
         -divide_by    1 \
         -master_clock [get_clocks SERCLK_GEN3_ACAP] \
         -source       [get_ports xcvr_scanclk_ser_clk] \
         -add \
         [get_ports rx_rd_clk]
   }
   
   if { $do_pcie_gen2 } {
      create_generated_clock \
         -name         RXRDCLK_GEN2_ACAP_OUT \
         -divide_by    1 \
         -master_clock [get_clocks SERCLK_GEN2_ACAP] \
         -source       [get_ports xcvr_scanclk_ser_clk] \
         -add \
         [get_ports rx_rd_clk]
   }
   
   if { $do_pcie_gen1 } {
      create_generated_clock \
         -name         RXRDCLK_GEN1_ACAP_OUT \
         -divide_by    1 \
         -master_clock [get_clocks SERCLK_GEN1_ACAP] \
         -source       [get_ports xcvr_scanclk_ser_clk] \
         -add \
         [get_ports rx_rd_clk]
   }
   
   if { $do_usb30 } {
      create_generated_clock \
         -name         RXRDCLK_USB30_ACAP_OUT \
         -divide_by    1 \
         -master_clock [get_clocks SERCLK_USB30_ACAP] \
         -source       [get_ports xcvr_scanclk_ser_clk] \
         -add \
         [get_ports rx_rd_clk]
   }
   
   if { $do_10gkr } {
      create_generated_clock \
         -name         RXRDCLK_10GKR_ACAP_OUT \
         -divide_by    1 \
         -master_clock [get_clocks SERCLK_10GKR_ACAP] \
         -source       [get_ports xcvr_scanclk_ser_clk] \
         -add \
         [get_ports rx_rd_clk]
   }
   
   if { $do_gbe } {
      create_generated_clock \
         -name         RXRDCLK_GBE_ACAP_OUT \
         -divide_by    1 \
         -master_clock [get_clocks SERCLK_GBE_ACAP] \
         -source       [get_ports xcvr_scanclk_ser_clk] \
         -add \
         [get_ports rx_rd_clk]
   }
# Full-rate and data-rate clocks. These clocks are not used to time 
# I/O data in any mode but we'll generate arcs from them regardless.
#
# Need to create_clock on cmn_pll0_clk_0_scanned_in pin which is sourced
# from cmn_scanclk_ser_clk in scan modes.


   if { $do_pcie_gen3 } {
      create_clock \
         -name     CMN_SERCLK_GEN3_ACAP \
         -period   $CLK500_PERIOD \
         -waveform $CLK500_WAVEFORM \
         -add \
         [get_ports cmn_pll0_clk_0_scanned_in]
   }
   
   if { $do_pcie_gen2 } {
      create_clock \
         -name     CMN_SERCLK_GEN2_ACAP \
         -period   $CLK250_PERIOD \
         -waveform $CLK250_WAVEFORM \
         -add \
         [get_ports cmn_pll0_clk_0_scanned_in]
   }
   
   if { $do_pcie_gen1 } {
      create_clock \
         -name     CMN_SERCLK_GEN1_ACAP \
         -period   $CLK125_PERIOD \
         -waveform $CLK125_WAVEFORM \
         -add \
         [get_ports cmn_pll0_clk_0_scanned_in]
   }

   if { $do_usb30 } {
      create_clock \
         -name     CMN_SERCLK_USB30_ACAP \
         -period   $CLK625_PERIOD \
         -waveform $CLK625_WAVEFORM \
         -add \
         [get_ports cmn_pll0_clk_0_scanned_in]
   }

   if { $do_10gkr } {
      create_clock \
         -name     CMN_SERCLK_10GKR_ACAP \
         -period   $CLK644P53_PERIOD \
         -waveform $CLK644P53_WAVEFORM \
         -add \
         [get_ports cmn_pll0_clk_0_scanned_in]
   }

   if { $do_gbe } {
      create_clock \
         -name     CMN_SERCLK_GBE_ACAP \
         -period   $CLK62P5_PERIOD \
         -waveform $CLK62P5_WAVEFORM \
         -add \
         [get_ports cmn_pll0_clk_0_scanned_in]
   }

if { $do_pcie_gen3 } {

      create_generated_clock \
         -name         FULLRT_GEN3_ACAP_OUT \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_SERCLK_GEN3_ACAP }] \
         -source [get_ports { cmn_pll0_clk_0_scanned_in }] \
         -add \
         [get_ports xcvr_pll_clk_fullrt]

      create_generated_clock \
         -name         DATART_GEN3_ACAP_OUT \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_SERCLK_GEN3_ACAP }] \
         -source [get_ports { cmn_pll0_clk_0_scanned_in }] \
         -add \
         [get_ports xcvr_pll_clk_datart]
   }


if { $do_pcie_gen2 } {

      create_generated_clock \
         -name         FULLRT_GEN2_ACAP_OUT \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_SERCLK_GEN2_ACAP }] \
         -source [get_ports { cmn_pll0_clk_0_scanned_in }] \
         -add \
         [get_ports xcvr_pll_clk_fullrt]

      create_generated_clock \
         -name         DATART_GEN2_ACAP_OUT \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_SERCLK_GEN2_ACAP }] \
         -source [get_ports { cmn_pll0_clk_0_scanned_in }] \
         -add \
         [get_ports xcvr_pll_clk_datart]
   }

if { $do_pcie_gen1 } {

      create_generated_clock \
         -name         FULLRT_GEN1_ACAP_OUT \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_SERCLK_GEN1_ACAP }] \
         -source [get_ports { cmn_pll0_clk_0_scanned_in }] \
         -add \
         [get_ports xcvr_pll_clk_fullrt]

      create_generated_clock \
         -name         DATART_GEN1_ACAP_OUT \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_SERCLK_GEN1_ACAP }] \
         -source [get_ports { cmn_pll0_clk_0_scanned_in }] \
         -add \
         [get_ports xcvr_pll_clk_datart]
   }

if { $do_usb30 } {

      create_generated_clock \
         -name         FULLRT_USB30_ACAP_OUT \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_SERCLK_USB30_ACAP }] \
         -source [get_ports { cmn_pll0_clk_0_scanned_in }] \
         -add \
         [get_ports xcvr_pll_clk_fullrt]

      create_generated_clock \
         -name         DATART_USB30_ACAP_OUT \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_SERCLK_USB30_ACAP }] \
         -source [get_ports { cmn_pll0_clk_0_scanned_in }] \
         -add \
         [get_ports xcvr_pll_clk_datart]
   }

if { $do_10gkr } {

      create_generated_clock \
         -name         FULLRT_10GKR_ACAP_OUT \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_SERCLK_10GKR_ACAP }] \
         -source [get_ports { cmn_pll0_clk_0_scanned_in }] \
         -add \
         [get_ports xcvr_pll_clk_fullrt]

      create_generated_clock \
         -name         DATART_10GKR_ACAP_OUT \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_SERCLK_10GKR_ACAP }] \
         -source [get_ports { cmn_pll0_clk_0_scanned_in }] \
         -add \
         [get_ports xcvr_pll_clk_datart]
   }

if { $do_gbe } {

      create_generated_clock \
         -name         FULLRT_GBE_ACAP_OUT \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_SERCLK_GBE_ACAP }] \
         -source [get_ports { cmn_pll0_clk_0_scanned_in }] \
         -add \
         [get_ports xcvr_pll_clk_fullrt]

      create_generated_clock \
         -name         DATART_GBE_ACAP_OUT \
         -divide_by    1 \
         -master_clock [get_clocks { CMN_SERCLK_GBE_ACAP }] \
         -source [get_ports { cmn_pll0_clk_0_scanned_in }] \
         -add \
         [get_ports xcvr_pll_clk_datart]
   }

# xcvr_scanclk_pll_clk for testing sd_clk domain
create_clock \
    -name           SDCLK_ACAP \
    -period         $CLK644P53_PERIOD \
    -waveform       $CLK644P53_WAVEFORM \
    [get_ports xcvr_scanclk_pll_clk]


#######################################
# Virtual Clocks
#######################################
# For asynchronous reset timing. This phase is NOT excluded from other clocks 
# so we can detect if an asynchronous reset goes logic other than reset 
# synchronization logic.
create_clock                                   \
            -name IO_RESET                     \
            -period   $RESET_PERIOD            \
            -waveform $RESET_WAVEFORM

# Asynchronous clock phases. This phase is excluded from all other clocks.
create_clock \
    -name           IO_ASYNC \
    -period         $ASYNC_PERIOD \
    -waveform       $ASYNC_WAVEFORM

#################################################################
# PLL*CLK Domain
#################################################################
create_clock \
    -name           PLL0CLK0_FULLRT_ACAP \
    -period   $CLK1031P25_PERIOD \
    -waveform $CLK1031P25_WAVEFORM \
    -add \
    [get_ports cmn_pll0_clk_0_scanned_in]

create_clock \
    -name           PLL0CLK1_FULLRT_ACAP \
    -period   $CLK1031P25_PERIOD \
    -waveform $CLK1031P25_WAVEFORM \
    -add \
    [get_ports cmn_pll0_clk_1_scanned_in]

create_clock \
    -name           PLL1CLK0_FULLRT_ACAP \
    -period   $CLK1031P25_PERIOD \
    -waveform $CLK1031P25_WAVEFORM \
    -add \
    [get_ports cmn_pll1_clk_0_scanned_in]

create_clock \
    -name           PLL1CLK1_FULLRT_ACAP \
    -period   $CLK1031P25_PERIOD \
    -waveform $CLK1031P25_WAVEFORM \
    -add \
    [get_ports cmn_pll1_clk_1_scanned_in]

############################################
# Misc clocks
############################################

# Assign a clock to the boundary scan clock inputs even though the logic
# is not scanned. Put rx_bscan_pc on unique clock due to large fails.
   create_clock \
      -name     BSCAN_CLK0 \
      -period   $BSCAN_PERIOD \
      -waveform $BSCAN_WAVEFORM \
      [get_ports {tx_bscan_clockdr }]

   create_clock \
      -name     BSCAN_CLK1\
      -period   $BSCAN_PERIOD \
      -waveform $BSCAN_WAVEFORM \
      [get_ports {tx_bscan_updatedr}]

   create_clock \
      -name     BSCAN_CLK2\
      -period   $BSCAN_PERIOD \
      -waveform $BSCAN_WAVEFORM \
      [get_ports {rx_bscan_clockdr}]

   create_clock \
      -name     BSCAN_PC_CLK \
      -period   $BSCAN_PERIOD \
      -waveform $BSCAN_WAVEFORM \
      [get_ports { rx_bscan_pc }]

###############################################################################
# Clock Uncertainties
###############################################################################
set_clock_uncertainty $setup_margin -setup -from [all_clocks] -to [all_clocks]
set_clock_uncertainty $hold_margin  -hold  -from [all_clocks] -to [all_clocks]

# Reduce uncertainty for MTBF flops.
set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_genblk1_u_data_sync_synth_*_2/CP }]
set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_genblk1_u_data_sync_synth_*_3/CP }]
set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_genblk1_u_data_sync_synth_*_4/CP }]
set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_u_reset_sync_synth_*_2/CP }]
set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_u_reset_sync_synth_*_3/CP }]
set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_u_reset_sync_synth_*_4/CP }]
#set_clock_uncertainty 0.035 -hold [get_pins -hier { *genblk1_u_reset_sync_synth_*_4/D }]

#set_false_path -hold -to [get_pins -hier { *genblk1_genblk1_u_data_sync_synth_*_2/D }]
#set_false_path -hold -to [get_pins -hier { *genblk1_genblk1_u_data_sync_synth_*_3/D }]
#set_false_path -hold -to [get_pins -hier { *genblk1_genblk1_u_data_sync_synth_*_4/D }]
#set_false_path -hold -to [get_pins -hier { *genblk1_u_reset_sync_synth_*_2/D }]
#set_false_path -hold -to [get_pins -hier { *genblk1_u_reset_sync_synth_*_3/D }]
#set_false_path -hold -to [get_pins -hier { *genblk1_u_reset_sync_synth_*_4/D }]

set_clock_uncertainty $setup_margin -setup -from [get_clocks {PCLK_ACAP_IN}] \
                                   -to [get_clocks {PCLK_ACAP_IN}]

set_clock_uncertainty $setup_margin -setup -from [get_clocks {SERCLK_GEN3_ACAP}] \
                                   -to [get_clocks {SERCLK_GEN3_ACAP}]

set_clock_uncertainty $setup_margin -setup -from [get_clocks {SERCLK_GEN2_ACAP}] \
                                   -to [get_clocks {SERCLK_GEN2_ACAP}]

set_clock_uncertainty $setup_margin -setup -from [get_clocks {SERCLK_GEN1_ACAP}] \
                                   -to [get_clocks {SERCLK_GEN1_ACAP}]

set_clock_uncertainty $setup_margin -setup -from [get_clocks {SERCLK_USB30_ACAP}] \
                                   -to [get_clocks {SERCLK_USB30_ACAP}]

set_clock_uncertainty $setup_margin -setup -from [get_clocks {SERCLK_10GKR_ACAP}] \
                                   -to [get_clocks {SERCLK_10GKR_ACAP}]

set_clock_uncertainty $setup_margin -setup -from [get_clocks {SERCLK_GBE_ACAP}] \
                                   -to [get_clocks {SERCLK_GBE_ACAP}]

set_clock_uncertainty $setup_margin -setup -from [get_clocks {TXTDCLK_GEN3_ACAP}] \
                                   -to [get_clocks {TXTDCLK_GEN3_ACAP}]

set_clock_uncertainty $setup_margin -setup -from [get_clocks {TXTDCLK_GEN2_ACAP}] \
                                   -to [get_clocks {TXTDCLK_GEN2_ACAP}]

set_clock_uncertainty $setup_margin -setup -from [get_clocks {TXTDCLK_GEN1_ACAP}] \
                                   -to [get_clocks {TXTDCLK_GEN1_ACAP}]

set_clock_uncertainty $setup_margin -setup -from [get_clocks {TXTDCLK_USB30_ACAP}] \
                                   -to [get_clocks {TXTDCLK_USB30_ACAP}]

set_clock_uncertainty $setup_margin -setup -from [get_clocks {TXTDCLK_10GKR_ACAP}] \
                                   -to [get_clocks {TXTDCLK_10GKR_ACAP}]

set_clock_uncertainty $setup_margin -setup -from [get_clocks {TXTDCLK_GBE_ACAP}] \
                                   -to [get_clocks {TXTDCLK_GBE_ACAP}]

set_clock_uncertainty $setup_margin -setup -from [get_clocks {PSMCLK_ACAP}] \
                                   -to [get_clocks {PSMCLK_ACAP}]

set_clock_uncertainty $setup_margin -setup -from [get_clocks {REFCLK_ACAP_GATED_IN}] \
                                   -to [get_clocks {REFCLK_ACAP_GATED_IN}]

#set_clock_uncertainty $setup_margin -setup -from [get_clocks {PLL*CLK*_FULLRT_ACAP}] \
#                                   -to [get_clocks {PLL*CLK*_FULLRT_ACAP}]

set_clock_uncertainty $setup_margin -setup -from [get_clocks {SDCLK_ACAP}] \
                                   -to [get_clocks {SDCLK_ACAP}]

###############################################################################
# Clock Groups
###############################################################################
set_clock_groups -asynchronous -name grp_acap_async  -group {IO_ASYNC}
set_clock_groups -asynchronous -name grp_acap_refclk -group {*REFCLK_*}
set_clock_groups -asynchronous -name grp_acap_psmclk -group {PSMCLK_*}
#set_clock_groups -asynchronous -name grp_acap_txtd   -group {TXTDCLK_*}
set_clock_groups -asynchronous -name grp_acap_pclk   -group {PCLK_ACAP_IN}
set_clock_groups -asynchronous -name grp_acap_serclk -group {TXTDCLK_* SERCLK_* RXRDCLK* FULLRT* DATART*}
set_clock_groups -asynchronous -name grp_acap_pllclk -group {PLL*CLK*_FULLRT_ACAP}
set_clock_groups -asynchronous -name grp_acap_bscan  -group { BSCAN_CLK* }
set_clock_groups -asynchronous -name grp_acap_bscan_pc  -group { BSCAN_PC_CLK }
set_clock_groups -asynchronous -name grp_acap_sd  -group { SDCLK_ACAP }


set str "set_clock_groups -physically_exclusive -name grp_std_pe"
set str_gen3 " -group \[get_clocks { *GEN3* }\]"
set str_gen2 " -group \[get_clocks { *GEN2* }\]"
set str_gen1 " -group \[get_clocks { *GEN1* }\]"
set str_usb  " -group \[get_clocks { *USB* }\]"
set str_10gkr " -group \[get_clocks { *10GKR* }\]"
set str_gbe  " -group \[get_clocks { *GBE* }\]"
if { $do_pcie_gen3 } { append str $str_gen3 }
if { $do_pcie_gen2 } { append str $str_gen2 }
if { $do_pcie_gen1 } { append str $str_gen1 }
if { $do_usb30 }     { append str $str_usb }
if { $do_10gkr }     { append str $str_10gkr }
if { $do_gbe }       { append str $str_gbe }
eval $str

###############################################################################
# Clock latency for clocks from common.
#-early | -late
# Specifies clock arrival time with respect to the early or the late time of the clock signal.
#In setup analysis, launch path is the late path and capture path is the early path.
#In hold analysis, launch path is the early path and the capture path is the late path. 
#If neither parameter is specified, the default is both early and late. 
 
###############################################################################
set_clock_latency 0.45 -source -max [get_ports {cmn_cdb_pclk_in}] -clock [get_clocks {PCLK_ACAP_IN}]
set_clock_latency 0.40 -source -min [get_ports {cmn_cdb_pclk_in}] -clock [get_clocks {PCLK_ACAP_IN}]

###############################################################################
# Transitions and Transition Limits
###############################################################################
#if {$timeMode == "ideal" } {
#    set_max_transition 0.150 [current_design]
#    set_max_transition 0.150 [all_inputs]
#    set_max_transition 0.150 [all_outputs]
#} else {
#    set_max_transition 0.210 [current_design]
#    set_max_transition 0.210 [all_inputs]
#    set_max_transition 0.210 [all_outputs]
#}

set_clock_transition $max_clk_trans [all_clocks]

###############################################################################
# I/O delay
###############################################################################
############################################
# Analog, asynchronous and constant ports
############################################

set async_inputs [get_ports {
   cmn_clock_stop_req_in
   cmn_macro_suspend_ack_in
   rx_bscan_ac
   rx_bscan_shiftdr
   rx_differential_invert
   rx_m
   rx_p
   rx_reset_n
   rx_sig_det_en_ext
   rx_termination
   tx_bscan_ac
   tx_bscan_acpulse
   tx_bscan_mode_c
   tx_bscan_shiftdr
   tx_cmn_mode_en_ext
   tx_deemphasis[*]
   tx_differential_invert
   tx_low_power_swing_en
   tx_rcv_detect_en
   tx_reset_n
   tx_sfifo_align_bump_in
   tx_vmargin[*]
   xcvr_bscan_mode_en
   xcvr_data_width[*]
   xcvr_lane_suspend
   xcvr_link_id[*]
   xcvr_link_reset_n
   xcvr_lpbk_fe_parallel_en
   xcvr_lpbk_isi_gen_en
   xcvr_lpbk_line_en
   xcvr_lpbk_ne_parallel_en
   xcvr_lpbk_recovered_clk_en
   xcvr_lpbk_serial_en
   xcvr_pll_clk_en
   xcvr_bscan_cfg[*]
   xcvr_scanen_cg
   xcvr_scanen
   xcvr_scanin[*]
   xcvr_scanmode
   xcvr_standard_mode[*]
}]

set async_outputs [get_ports {
   cmn_clock_stop_req_out
   cmn_macro_suspend_ack_out
   rx_cdrlf_fphl_locked
   rx_eye_plot_pi_val[*]
   rx_link_eval_fb_dir_change[*]
   rx_pi_val[*]
   rx_signal_detect
   tx_m
   tx_p
   tx_rcv_detect_done
   tx_rcv_detected
   tx_sfifo_align_bump_out
   xcvr_pll_clk_en_ack
   xcvr_scanout[*]
}]

foreach_in_collection pma_port $async_inputs {
   set port_name [get_object $pma_port]
   set_input_delay 0.0 -max -add -clock [get_clocks { IO_ASYNC }] $port_name
}
############################################
# Reference clocks
############################################

set refclk_inputs [get_ports { \
   cmn_ready_in \
   cmn_macro_suspend_ack_in \
}]
#   cmn_pll0_clk_0_scanned_in \
#   cmn_pll0_clk_1_scanned_in \
#   cmn_pll1_clk_0_scanned_in \
#   cmn_pll1_clk_1_scanned_in \

# Source-synchronous signals.
# Set I/O timing to 2/3 clock period.
set ref_value  [expr round(($CLK200_PERIOD * 2.0 / 3.0) * 100) / 100.0]
foreach_in_collection pma_port $refclk_inputs {
   set port_name [get_object $pma_port]
   set_input_delay $ref_value  -max -add -clock [get_clocks { SCAN_REFCLK_ACAP_IN }]  $port_name
   set_input_delay $ref_value  -max -add -clock [get_clocks { REFCLK_ACAP_GATED_IN }] $port_name
}

# Constant and aync signals
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_lpbk_serial_en}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_lpbk_fe_parallel_en}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_lpbk_ne_parallel_en}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_lpbk_line_en}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_lpbk_isi_gen_en}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_lpbk_recovered_clk_en}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_rcv_detect_en}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_deemphasis[*]}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_vmargin[*]}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_low_power_swing_en}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_differential_invert}]

set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_termination}]
set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_differential_invert}]

set_input_delay 0 -max -add -clock [get_clocks {IO_ASYNC}]   [get_ports {lane_addr[*]}]
set_input_delay 1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_cmn_mode_en_ext}]

#############################################
## PSM
#############################################

# Need to adjust I/O timing for WC clock latency.
if { $timeMode == "prop" } {
   set psm_latency  0.400
} else {
   set psm_latency  0.0
}

# Set I/O timing to 2/3 clock period.
set psm_value  [expr round(($CLK200_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set psm_indly  [expr $psm_value + $psm_latency]
set psm_outdly [expr $psm_value - $psm_latency]

   set psmclk [get_clocks PSMCLK_ACAP]
   set_input_delay  $psm_value -max -add -clock $psmclk [get_ports xcvr_power_state_req[*]]
   set_output_delay $psm_value -max -add -clock $psmclk [get_ports xcvr_power_state_ack[*]]
   set_output_delay $psm_value -max -add -clock $psmclk [get_ports xcvr_psm_ready]
   set_output_delay $psm_value -max -add -clock $psmclk [get_ports tx_sfifo_enq_reset_n_out]
   set_output_delay $psm_value -max -add -clock $psmclk [get_ports xcvr_psm_state[*]]


# DSM new
set serclk_inputs [get_ports { \
    cmn_clock_stop_req_in \
    cmn_macro_suspend_ack_in \
    xcvr_pll_clk_en \
    cmn_ready_in \
    rx_reset_n \
    tx_clk_reset_req_in \
    tx_reset_n \
    xcvr_clk_buf_en_0_in \
    xcvr_clk_buf_en_1_in \
    xcvr_clk_buf_en_0_del_in \
    xcvr_clk_buf_en_1_del_in \
    xcvr_link_reset_n \
    xcvr_lnr \
}]
# Set I/O timing to 2/3 clock period.
#set ser_value  [expr round(($CLK500_PERIOD * 2.0 / 3.0) * 100) / 100.0]
foreach_in_collection pma_port $serclk_inputs {
   set port_name [get_object $pma_port]

   set_input_delay 0.5  -max -add -clock [get_clocks {SERCLK_GEN3_ACAP}]  $port_name
   set_input_delay 1.0  -max -add -clock [get_clocks {SERCLK_GEN2_ACAP}]  $port_name
   set_input_delay 1.0  -max -add -clock [get_clocks {SERCLK_GEN1_ACAP}]  $port_name
   set_input_delay 0.5  -max -add -clock [get_clocks {SERCLK_USB30_ACAP}] $port_name
   set_input_delay 0.5  -max -add -clock [get_clocks {SERCLK_10GKR_ACAP}] $port_name
   set_input_delay 1.0  -max -add -clock [get_clocks {SERCLK_GBE_ACAP}]   $port_name
}

#set_input_delay 1.0 -max -add -clock [get_clocks {REFCLK_ACAP_IN}] [get_ports { \
#                                                                         xcvr_decap_en_in \
#                                                                         xctrl_power_enable_ph1_time_in[*] \
#                                                                         xctrl_power_enable_ph2_time_in[*] \
#                                                                 }]
set_input_delay 1.0 -max -add -clock [get_clocks {REFCLK_ACAP_GATED_IN}] [get_ports { \
                                                                         xcvr_lane_suspend \
                                                                        }]
set_input_delay 1.0 -max -add -clock [get_clocks {PSMCLK_ACAP}] [get_ports { \
                                                                         xcvr_power_state_en_token_in_ibs \
                                                                         xcvr_power_state_en_token_in_obs \
                                                                         xcvr_power_state_req[*] \
                                                                         tx_clk_reset_ack_in \
                                                                         tx_clk_reset_stp_in \
                                                                         xcvr_lnr \
                                                                   }]
set_input_delay 1.0 -max -add -clock [get_clocks {TXTDCLK_GEN3_ACAP}] [get_ports { \
                                                                         xcvr_lnr \
                                                                   }]
set_input_delay 1.0 -max -add -clock [get_clocks {TXTDCLK_GEN2_ACAP}] [get_ports { \
                                                                         xcvr_lnr \
                                                                   }]
set_input_delay 1.0 -max -add -clock [get_clocks {TXTDCLK_GEN1_ACAP}] [get_ports { \
                                                                         xcvr_lnr \
                                                                   }]
set_input_delay 1.0 -max -add -clock [get_clocks {TXTDCLK_USB30_ACAP}] [get_ports { \
                                                                         xcvr_lnr \
                                                                   }]
set_input_delay 1.0 -max -add -clock [get_clocks {TXTDCLK_10GKR_ACAP}] [get_ports { \
                                                                         xcvr_lnr \
                                                                   }]
set_input_delay 1.0 -max -add -clock [get_clocks {TXTDCLK_GBE_ACAP}] [get_ports { \
                                                                         xcvr_lnr \
                                                                   }]

#set_output_delay 2.5 -max -add -clock [get_clocks {REFCLK_ACAP_IN}] [get_ports {xcvr_decap_en_out}]
#changed this to max delay to get good delay out in the .lib ( nov27 2013)

set_output_delay 0.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_signal_detect}]
set_output_delay 0.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_pi_val[*]}]
set_output_delay 0.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_eye_plot_pi_val[*]}]

set_output_delay 0.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_in_obs_tie_high[*]}]
set_output_delay 0.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_in_obs_tie_low[*]}]
set_output_delay 0.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_in_ibs_tie_high[*]}]
set_output_delay 0.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_in_ibs_tie_low[*]}]
set_output_delay 0.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {lane_addr_tie_high}]
set_output_delay 0.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {lane_addr_tie_low}]

# DSM new
set serclk_outputs [get_ports { \
   cmn_clock_stop_req_out \
   cmn_macro_suspend_ack_out \
   cmn_ready_out \
   cmn_scanclk_ref_clk_out \
   rx_cdrlf_fphl_locked \
   tx_clk_reset_ack_out \
   tx_clk_reset_req_out \
   tx_clk_reset_stp_out \
   xcvr_clk_buf_en_0_out \
   xcvr_clk_buf_en_1_out \
}]
# Set I/O timing to 2/3 clock period.
#set ser_value  [expr round(($CLK500_PERIOD * 2.0 / 3.0) * 100) / 100.0]
foreach_in_collection pma_port $serclk_outputs {
   set port_name [get_object $pma_port]
   set_output_delay 0.5  -max -add -clock [get_clocks {SERCLK_GEN3_ACAP}]  $port_name
   set_output_delay 1.0  -max -add -clock [get_clocks {SERCLK_GEN2_ACAP}]  $port_name
   set_output_delay 1.0  -max -add -clock [get_clocks {SERCLK_GEN1_ACAP}]  $port_name
   set_output_delay 0.5  -max -add -clock [get_clocks {SERCLK_USB30_ACAP}] $port_name
   set_output_delay 0.5  -max -add -clock [get_clocks {SERCLK_10GKR_ACAP}] $port_name
   set_output_delay 1.0  -max -add -clock [get_clocks {SERCLK_GBE_ACAP}]   $port_name
}
set_output_delay 0.0 -max -add -clock [get_clocks {PSMCLK_ACAP}] [get_ports { \
                                                                          tx_clk_reset_req_out \
                                                                          xcvr_power_state_en_token_out_ibs \
                                                                          xcvr_power_state_en_token_out_obs \
                                                                          xcvr_power_state_ack[*] \
                                                                          xcvr_psm_state[*] \
                                                                         }]
set_output_delay 0.0 -max -add -clock [get_clocks {PCLK_ACAP_IN}] [get_ports { \
                                                                          xcvr_clk_buf_en_0_out \
                                                                          xcvr_clk_buf_en_1_out \
                                                                         }]
set_output_delay 0.0 -max -add -clock [get_clocks {REFCLK_ACAP_GATED_IN}] [get_ports { \
                                                                          tx_rcv_detected \
                                                                          tx_rcv_detect_done \
                                                                         }]
#
#Signals from common, and pass throughs to lanes.
#
#set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {cmn_scanclk_ref_clk_in}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_data_width[*]}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {cmn_atb_en_in}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {cmn_atb_sel_in}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {cmn_reset_n_in}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {cmn_cdb_preset_n_in}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {cmn_reset_sync_n_in}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_sig_det_en_ext}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_rescal_code_in[*]}]
set_input_delay  1.0 -max -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_standard_mode[*]}]


#outputs pass thru signals have their set_output_delay commented out since we
#don't want the timing engine to time these wrt IO_ASYNC clocks and give out
#false big violations due to this clock's high uncertainty
## adding the input delay to the max delay to fix issue in STA.
set_max_delay 1.5 -from [get_ports {cmn_reset_n_in}] -to [get_ports {cmn_reset_n_out}]
set_min_delay 0.7 -from [get_ports {cmn_reset_n_in}] -to [get_ports {cmn_reset_n_out}]
set_max_delay 1.5 -from [get_ports {cmn_reset_sync_n_in}] -to [get_ports {cmn_reset_sync_n_out}]
set_min_delay 0.7 -from [get_ports {cmn_reset_sync_n_in}] -to [get_ports {cmn_reset_sync_n_out}]
set_max_delay 1.5 -from [get_ports {cmn_atb_en_in}] -to [get_ports {cmn_atb_en_out}]
set_min_delay 0.7 -from [get_ports {cmn_atb_en_in}] -to [get_ports {cmn_atb_en_out}]
set_max_delay 1.5 -from [get_ports {cmn_atb_sel_in[*]}] -to [get_ports {cmn_atb_sel_out[*]}]
set_min_delay 0.7 -from [get_ports {cmn_atb_sel_in[*]}] -to [get_ports {cmn_atb_sel_out[*]}]
set_max_delay 1.5 -from [get_ports {cmn_cdb_preset_n_in}] -to [get_ports {cmn_cdb_preset_n_out}]
set_min_delay 0.7 -from [get_ports {cmn_cdb_preset_n_in}] -to [get_ports {cmn_cdb_preset_n_out}]


set_max_delay 2.000 -from [get_ports rx_rescal_code_in[2]] -to [get_ports rx_rescal_code_out[2]] 
set_min_delay 1.975 -from [get_ports rx_rescal_code_in[2]] -to [get_ports rx_rescal_code_out[2]] 
set_max_delay 2.000 -from [get_ports rx_rescal_code_in[1]] -to [get_ports rx_rescal_code_out[1]] 
set_min_delay 1.975 -from [get_ports rx_rescal_code_in[1]] -to [get_ports rx_rescal_code_out[1]] 
set_max_delay 2.000 -from [get_ports rx_rescal_code_in[0]] -to [get_ports rx_rescal_code_out[0]] 
set_min_delay 1.975 -from [get_ports rx_rescal_code_in[0]] -to [get_ports rx_rescal_code_out[0]] 

set_input_delay 2.4 -max -clock [get_clocks {PCLK_ACAP_IN}] [get_ports {cdb_tx_psel_in}]  -add_delay 
set_input_delay 2.4 -max -clock [get_clocks {PCLK_ACAP_IN}] [get_ports {cdb_rx_psel_in}]  -add_delay 
set_input_delay 2.4 -max -clock [get_clocks {PCLK_ACAP_IN}] [get_ports {cdb_txrx_paddr_in[*]}]  -add_delay 
set_input_delay 2.4 -max -clock [get_clocks {PCLK_ACAP_IN}] [get_ports {cdb_txrx_pwdata_in[*]}]  -add_delay 
set_input_delay 2.4 -max -clock [get_clocks {PCLK_ACAP_IN}] [get_ports {cdb_txrx_pwrite_in}]  -add_delay 
set_input_delay 2.4 -max -clock [get_clocks {PCLK_ACAP_IN}] [get_ports {cdb_txrx_plinkmultiwrite_in}]  -add_delay 
set_input_delay 2.4 -max -clock [get_clocks {PCLK_ACAP_IN}] [get_ports {cdb_tx_penable_in}]  -add_delay 
set_input_delay 2.4 -max -clock [get_clocks {PCLK_ACAP_IN}] [get_ports {cdb_rx_penable_in}]  -add_delay


set_input_delay 0.75 -min -clock [get_clocks {PCLK_ACAP_IN}] [get_ports {cdb_tx_psel_in}]  -add_delay 
set_input_delay 0.75 -min -clock [get_clocks {PCLK_ACAP_IN}] [get_ports {cdb_rx_psel_in}]  -add_delay 
set_input_delay 0.75 -min -clock [get_clocks {PCLK_ACAP_IN}] [get_ports {cdb_txrx_paddr_in[*]}]  -add_delay 
set_input_delay 0.75 -min -clock [get_clocks {PCLK_ACAP_IN}] [get_ports {cdb_txrx_pwdata_in[*]}]  -add_delay 
set_input_delay 0.75 -min -clock [get_clocks {PCLK_ACAP_IN}] [get_ports {cdb_txrx_pwrite_in}]  -add_delay 
set_input_delay 0.75 -min -clock [get_clocks {PCLK_ACAP_IN}] [get_ports {cdb_txrx_plinkmultiwrite_in}]  -add_delay 
set_input_delay 0.75 -min -clock [get_clocks {PCLK_ACAP_IN}] [get_ports {cdb_tx_penable_in}]  -add_delay 
set_input_delay 0.75 -min -clock [get_clocks {PCLK_ACAP_IN}] [get_ports {cdb_rx_penable_in}]  -add_delay

set_input_delay 1.0 -clock [get_clocks {IO_ASYNC}] [get_ports {cdb_txrx_prdata_in[*]}]  -add_delay 
set_input_delay 1.0 -clock [get_clocks {IO_ASYNC}] [get_ports {cdb_tx_pready_in}]  -add_delay 
set_input_delay 1.0 -clock [get_clocks {IO_ASYNC}] [get_ports {cdb_rx_pready_in}]  -add_delay 

set_max_delay 2.600 -from [get_ports cdb_tx_psel_in] -to [get_ports cdb_tx_psel_out] 
set_min_delay 0.790 -from [get_ports cdb_tx_psel_in] -to [get_ports cdb_tx_psel_out] 
set_max_delay 2.600 -from [get_ports cdb_rx_psel_in] -to [get_ports cdb_rx_psel_out]
set_min_delay 0.790 -from [get_ports cdb_rx_psel_in] -to [get_ports cdb_rx_psel_out] 

set_max_delay 2.600 -from [get_ports cdb_tx_penable_in] -to [get_ports cdb_tx_penable_out]
set_min_delay 0.790 -from [get_ports cdb_tx_penable_in] -to [get_ports cdb_tx_penable_out] 
set_max_delay 2.600 -from [get_ports cdb_rx_penable_in] -to [get_ports cdb_rx_penable_out]
set_min_delay 0.790 -from [get_ports cdb_rx_penable_in] -to [get_ports cdb_rx_penable_out] 

set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[13]] -to  [get_ports cdb_txrx_paddr_out[13]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[13]] -to  [get_ports cdb_txrx_paddr_out[13]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[12]] -to  [get_ports cdb_txrx_paddr_out[12]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[12]] -to  [get_ports cdb_txrx_paddr_out[12]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[11]] -to  [get_ports cdb_txrx_paddr_out[11]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[11]] -to  [get_ports cdb_txrx_paddr_out[11]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[10]] -to  [get_ports cdb_txrx_paddr_out[10]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[10]] -to  [get_ports cdb_txrx_paddr_out[10]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[9]] -to  [get_ports cdb_txrx_paddr_out[9]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[9]] -to  [get_ports cdb_txrx_paddr_out[9]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[8]] -to  [get_ports cdb_txrx_paddr_out[8]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[8]] -to  [get_ports cdb_txrx_paddr_out[8]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[7]] -to  [get_ports cdb_txrx_paddr_out[7]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[7]] -to  [get_ports cdb_txrx_paddr_out[7]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[6]] -to  [get_ports cdb_txrx_paddr_out[6]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[6]] -to  [get_ports cdb_txrx_paddr_out[6]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[5]] -to  [get_ports cdb_txrx_paddr_out[5]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[5]] -to  [get_ports cdb_txrx_paddr_out[5]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[4]] -to  [get_ports cdb_txrx_paddr_out[4]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[4]] -to  [get_ports cdb_txrx_paddr_out[4]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[3]] -to  [get_ports cdb_txrx_paddr_out[3]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[3]] -to  [get_ports cdb_txrx_paddr_out[3]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[2]] -to  [get_ports cdb_txrx_paddr_out[2]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[2]] -to  [get_ports cdb_txrx_paddr_out[2]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[1]] -to  [get_ports cdb_txrx_paddr_out[1]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[1]] -to  [get_ports cdb_txrx_paddr_out[1]]  
set_max_delay 2.600 -from [get_ports cdb_txrx_paddr_in[0]] -to  [get_ports cdb_txrx_paddr_out[0]] 
set_min_delay 0.790 -from [get_ports cdb_txrx_paddr_in[0]] -to  [get_ports cdb_txrx_paddr_out[0]]  

set_max_delay 2.600 -from [get_ports cdb_txrx_plinkmultiwrite_in] -to [get_ports cdb_txrx_plinkmultiwrite_out] 
set_min_delay 0.790 -from [get_ports cdb_txrx_plinkmultiwrite_in] -to [get_ports cdb_txrx_plinkmultiwrite_out]  

set_max_delay 2.600 -from [get_ports {cdb_txrx_pwrite_in}] -to  [get_ports {cdb_txrx_pwrite_out}] 
set_min_delay 0.790 -from [get_ports {cdb_txrx_pwrite_in}] -to  [get_ports {cdb_txrx_pwrite_out}]  

set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[15]] -to [get_ports cdb_txrx_pwdata_out[15]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[15]] -to [get_ports cdb_txrx_pwdata_out[15]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[14]] -to [get_ports cdb_txrx_pwdata_out[14]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[14]] -to [get_ports cdb_txrx_pwdata_out[14]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[13]] -to [get_ports cdb_txrx_pwdata_out[13]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[13]] -to [get_ports cdb_txrx_pwdata_out[13]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[12]] -to [get_ports cdb_txrx_pwdata_out[12]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[12]] -to [get_ports cdb_txrx_pwdata_out[12]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[11]] -to [get_ports cdb_txrx_pwdata_out[11]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[11]] -to [get_ports cdb_txrx_pwdata_out[11]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[10]] -to [get_ports cdb_txrx_pwdata_out[10]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[10]] -to [get_ports cdb_txrx_pwdata_out[10]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[9]] -to [get_ports cdb_txrx_pwdata_out[9]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[9]] -to [get_ports cdb_txrx_pwdata_out[9]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[8]] -to [get_ports cdb_txrx_pwdata_out[8]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[8]] -to [get_ports cdb_txrx_pwdata_out[8]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[7]] -to [get_ports cdb_txrx_pwdata_out[7]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[7]] -to [get_ports cdb_txrx_pwdata_out[7]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[6]] -to [get_ports cdb_txrx_pwdata_out[6]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[6]] -to [get_ports cdb_txrx_pwdata_out[6]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[5]] -to [get_ports cdb_txrx_pwdata_out[5]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[5]] -to [get_ports cdb_txrx_pwdata_out[5]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[4]] -to [get_ports cdb_txrx_pwdata_out[4]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[4]] -to [get_ports cdb_txrx_pwdata_out[4]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[3]] -to [get_ports cdb_txrx_pwdata_out[3]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[3]] -to [get_ports cdb_txrx_pwdata_out[3]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[2]] -to [get_ports cdb_txrx_pwdata_out[2]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[2]] -to [get_ports cdb_txrx_pwdata_out[2]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[1]] -to [get_ports cdb_txrx_pwdata_out[1]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[1]] -to [get_ports cdb_txrx_pwdata_out[1]]
set_max_delay 2.600 -from [get_ports cdb_txrx_pwdata_in[0]] -to [get_ports cdb_txrx_pwdata_out[0]]
set_min_delay 0.790 -from [get_ports cdb_txrx_pwdata_in[0]] -to [get_ports cdb_txrx_pwdata_out[0]]

# the number below is 1.0+0.2 (input_delay+max_delay) = 1.2
# the number below is 1.0+0.180 (input_delay+min_delay) = 1.18

set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[15]] -to [get_ports cdb_txrx_prdata_out[15]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[15]] -to [get_ports cdb_txrx_prdata_out[15]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[14]] -to [get_ports cdb_txrx_prdata_out[14]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[14]] -to [get_ports cdb_txrx_prdata_out[14]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[13]] -to [get_ports cdb_txrx_prdata_out[13]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[13]] -to [get_ports cdb_txrx_prdata_out[13]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[12]] -to [get_ports cdb_txrx_prdata_out[12]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[12]] -to [get_ports cdb_txrx_prdata_out[12]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[11]] -to [get_ports cdb_txrx_prdata_out[11]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[11]] -to [get_ports cdb_txrx_prdata_out[11]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[10]] -to [get_ports cdb_txrx_prdata_out[10]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[10]] -to [get_ports cdb_txrx_prdata_out[10]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[9]] -to [get_ports cdb_txrx_prdata_out[9]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[9]] -to [get_ports cdb_txrx_prdata_out[9]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[8]] -to [get_ports cdb_txrx_prdata_out[8]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[8]] -to [get_ports cdb_txrx_prdata_out[8]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[7]] -to [get_ports cdb_txrx_prdata_out[7]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[7]] -to [get_ports cdb_txrx_prdata_out[7]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[6]] -to [get_ports cdb_txrx_prdata_out[6]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[6]] -to [get_ports cdb_txrx_prdata_out[6]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[5]] -to [get_ports cdb_txrx_prdata_out[5]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[5]] -to [get_ports cdb_txrx_prdata_out[5]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[4]] -to [get_ports cdb_txrx_prdata_out[4]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[4]] -to [get_ports cdb_txrx_prdata_out[4]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[3]] -to [get_ports cdb_txrx_prdata_out[3]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[3]] -to [get_ports cdb_txrx_prdata_out[3]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[2]] -to [get_ports cdb_txrx_prdata_out[2]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[2]] -to [get_ports cdb_txrx_prdata_out[2]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[1]] -to [get_ports cdb_txrx_prdata_out[1]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[1]] -to [get_ports cdb_txrx_prdata_out[1]]
set_max_delay 1.200 -from [get_ports cdb_txrx_prdata_in[0]] -to [get_ports cdb_txrx_prdata_out[0]]
set_min_delay 1.180 -from [get_ports cdb_txrx_prdata_in[0]] -to [get_ports cdb_txrx_prdata_out[0]]
set_max_delay 1.200 -from [get_ports cdb_tx_pready_in] -to [get_ports cdb_tx_pready_out] 
set_min_delay 1.180 -from [get_ports cdb_tx_pready_in] -to [get_ports cdb_tx_pready_out]  
set_max_delay 1.200 -from [get_ports cdb_rx_pready_in] -to [get_ports cdb_rx_pready_out] 
set_min_delay 1.180 -from [get_ports cdb_rx_pready_in] -to [get_ports cdb_rx_pready_out]  

#
#NOTE:check if you need to add the clock_source insertion delay.
#
set_output_delay 0.500 -max -clock {PCLK_ACAP_IN} [get_ports cdb_txrx_prdata_out[*]]
set_output_delay 0.450 -min -clock {PCLK_ACAP_IN} [get_ports cdb_txrx_prdata_out[*]]
set_output_delay 0.500 -clock {PCLK_ACAP_IN} [get_ports cdb_tx_pready_out]
set_output_delay 0.500 -clock {PCLK_ACAP_IN} [get_ports cdb_rx_pready_out]

#Cannot have set_input delay on clock. should I be adding source insertion delay??
#set_input_delay 2.391 -clock {IO_ASYNC} -max -rise [get_ports {cmn_refclk_gated_in}]  -add_delay 

# Following are pass through versions of the cmn_clocks.
set_max_delay 0.200 -from [get_ports {cmn_ref_clk_gated_in}] -to [get_ports {cmn_ref_clk_gated_out}]
#NOTE: 09/28/2012:for the ff corner hold check changing the min delay from 180ps top 40ps.
set_min_delay 0.040 -from [get_ports {cmn_ref_clk_gated_in}] -to [get_ports {cmn_ref_clk_gated_out}]


## Note for cdb_clk we have a clock latency associated with it, hence adding latency to the
## max_delay.
## new_max_delay = max_delay + clock_latency = 0.200 + 1.85 = 2.05
## 09/28/2012: new_max_delay = max_delay + clock_latency = 0.200 + 0.45 = 0.65
set_max_delay 0.650 -from [get_ports {cmn_cdb_pclk_in}] -to [get_ports {cmn_cdb_pclk_out}]
#NOTE: 09/28/2012:for the ff corner hold check changing the min delay from 180ps top 40ps.
set_min_delay 0.040 -from [get_ports {cmn_cdb_pclk_in}] -to [get_ports {cmn_cdb_pclk_out}]
############################################
# Transmitter
############################################

# Need to adjust I/O timing for WC clock latency.
if { $timeMode == "prop" } {
   set txclk_latency  0.400
} else {
   set txclk_latency  0.0
}

# Set I/O timing to 2/3 clock period.
set gen3_value  [expr round(($CLK500_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set gen2_value  [expr round(($CLK250_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set gen1_value  [expr round(($CLK125_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set usb30_value [expr round(($CLK625_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set tengkr_value [expr round(($CLK644P53_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set gbe_value   [expr round(($CLK62P5_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set txclk_gen3_indly  [expr $gen3_value + $txclk_latency]
set txclk_gen2_indly  [expr $gen2_value + $txclk_latency]
set txclk_gen1_indly  [expr $gen1_value + $txclk_latency]
set txclk_usb30_indly [expr $usb30_value + $txclk_latency]
set txclk_10gkr_indly [expr $tengkr_value + $txclk_latency]
set txclk_gbe_indly   [expr $gbe_value + $txclk_latency]

   if { $do_pcie_gen3 } {
      set txclk [get_clocks TXTDCLK_GEN3_ACAP]
      set_input_delay $txclk_gen3_indly -max -add -clock $txclk [get_ports tx_td[*]]
      set_input_delay $txclk_gen3_indly -max -add -clock $txclk [get_ports tx_elec_idle]
      set_input_delay $txclk_gen3_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_in]
      set_input_delay $txclk_gen3_indly -max -add -clock $txclk [get_ports tx_bist_hold]
      set_output_delay $txclk_gen3_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_out]
   }
   if { $do_pcie_gen2 } {
      set txclk [get_clocks TXTDCLK_GEN2_ACAP]
      set_input_delay $txclk_gen2_indly -max -add -clock $txclk [get_ports tx_td[*]]
      set_input_delay $txclk_gen2_indly -max -add -clock $txclk [get_ports tx_elec_idle]
      set_input_delay $txclk_gen2_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_in]
      set_input_delay $txclk_gen2_indly -max -add -clock $txclk [get_ports tx_bist_hold]
      set_output_delay $txclk_gen2_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_out]
   }
   if { $do_pcie_gen1 } {
      set txclk [get_clocks TXTDCLK_GEN1_ACAP]
      set_input_delay $txclk_gen1_indly -max -add -clock $txclk [get_ports tx_td[*]]
      set_input_delay $txclk_gen1_indly -max -add -clock $txclk [get_ports tx_elec_idle]
      set_input_delay $txclk_gen1_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_in]
      set_input_delay $txclk_gen1_indly -max -add -clock $txclk [get_ports tx_bist_hold]
      set_output_delay $txclk_gen1_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_out]
   }
   if { $do_usb30 } {
      set txclk [get_clocks TXTDCLK_USB30_ACAP]
      set_input_delay $txclk_usb30_indly -max -add -clock $txclk [get_ports tx_td[*]]
      set_input_delay $txclk_usb30_indly -max -add -clock $txclk [get_ports tx_elec_idle]
      set_input_delay $txclk_usb30_indly -max -add -clock $txclk [get_ports tx_bist_hold]
      set_output_delay $txclk_usb30_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_out]
      set_input_delay $txclk_usb30_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_in]
   }
   if { $do_10gkr } {
      set txclk [get_clocks TXTDCLK_10GKR_ACAP]
      set_input_delay $txclk_10gkr_indly -max -add -clock $txclk [get_ports tx_td[*]]
      set_input_delay $txclk_10gkr_indly -max -add -clock $txclk [get_ports tx_elec_idle]
      set_input_delay $txclk_10gkr_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_in]
      set_output_delay $txclk_10gkr_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_out]
      set_input_delay $txclk_10gkr_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_in]
   }
   if { $do_gbe } {
      set txclk [get_clocks TXTDCLK_GBE_ACAP]
      set_input_delay $txclk_gbe_indly -max -add -clock $txclk [get_ports tx_td[*]]
      set_input_delay $txclk_gbe_indly -max -add -clock $txclk [get_ports tx_elec_idle]
      set_input_delay $txclk_gbe_indly -max -add -clock $txclk [get_ports tx_bist_hold]
      set_output_delay $txclk_gbe_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_out]
      set_input_delay $txclk_gbe_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_in]
   }
##
## To check the turn-around time for the txda_ser_data, based of rise edge of txda_ser_clk.
## Following timing is based of data from Mark Hale. Jul30 2012.
## Max_delay for ss corner = 1.94ns, for ff corner = 1.984ns, and tt corner = 1.96ns.
## + uncertainty -75ps
##set_max_delay 1.94 -from [get_clocks {TXCLK_GEN3}] -to [get_pins {u_xcvr_ana/txda_ser_data[*]}]
## NOte do not need this as we have setup and hold requirement numbers in the lib.
##set_max_delay 1.86 -from [get_clocks {TXCLK_GEN3}] -to [get_pins {u_xcvr_ana/txda_ser_data[*]}]

############################################
# Receiver
############################################

# Source-synchronous signals.
# Set I/O timing to 2/3 clock period.
set gen3_value  [expr round(($CLK500_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set gen2_value  [expr round(($CLK250_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set gen1_value  [expr round(($CLK125_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set usb30_value [expr round(($CLK625_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set tengkr_value [expr round(($CLK644P53_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set gbe_value   [expr round(($CLK62P5_PERIOD * 2.0 / 3.0) * 100) / 100.0]
# Set GEN2 and USB 3.0 I/O timing to 1/5 clock period for signals that are not timing critical.
set gen2_loose  [expr round(($CLK250_PERIOD * 1.0 / 5.0) * 100) / 100.0]
set usb30_loose [expr round(($CLK644P53_PERIOD * 1.0 / 5.0) * 100) / 100.0]
set tengkr_loose [expr round(($CLK644P53_PERIOD * 1.0 / 5.0) * 100) / 100.0]
# Set GEN3 I/O timing to 0 clock period for signals that are not timing critical.
set gen3_loose  [expr round(($CLK500_PERIOD * 0.0 / 5.0) * 100) / 100.0]

#
# Ports rx_sampler_latch_cal_diag_ln_*[*] are not timing critical.
# Ports rx_eq_eval_cnt_rst_ln_* are multicyle paths for PCIe, asynchronous otherwise.
#
   if { $do_pcie_gen3 } {
      set rxclk [get_clocks RXRDCLK_GEN3_ACAP_OUT]
      set_output_delay $gen3_value -max -add -clock $rxclk [get_ports rx_bist_err_toggle]
      set_output_delay $gen3_value -max -add -clock $rxclk [get_ports rx_bist_status]
      set_output_delay $gen3_value -max -add -clock $rxclk [get_ports rx_bist_sync]
      set_output_delay $gen3_value -max -add -clock $rxclk [get_ports rx_rd]
      set_output_delay $gen3_loose -max -add -clock $rxclk [get_ports rx_sampler_latch_cal_diag[*]]
   }
   if { $do_pcie_gen2 } {
      set rxclk [get_clocks RXRDCLK_GEN2_ACAP_OUT]
      set_output_delay $gen2_value -max -add -clock $rxclk [get_ports rx_bist_err_toggle]
      set_output_delay $gen2_value -max -add -clock $rxclk [get_ports rx_bist_status]
      set_output_delay $gen2_value -max -add -clock $rxclk [get_ports rx_bist_sync]
      set_output_delay $gen2_value -max -add -clock $rxclk [get_ports rx_rd]
      set_output_delay $gen2_loose -max -add -clock $rxclk [get_ports rx_sampler_latch_cal_diag[*]]
   }
   if { $do_pcie_gen1 } {
      set rxclk [get_clocks RXRDCLK_GEN1_ACAP_OUT]
      set_output_delay $gen1_value -max -add -clock $rxclk [get_ports rx_bist_err_toggle]
      set_output_delay $gen1_value -max -add -clock $rxclk [get_ports rx_bist_status]
      set_output_delay $gen1_value -max -add -clock $rxclk [get_ports rx_bist_sync]
      set_output_delay $gen1_value -max -add -clock $rxclk [get_ports rx_rd]
      set_output_delay $gen1_value -max -add -clock $rxclk [get_ports rx_sampler_latch_cal_diag[*]]
   }
   if { $do_usb30 } {
      set rxclk [get_clocks RXRDCLK_USB30_ACAP_OUT]
      set_output_delay $usb30_value -max -add -clock $rxclk [get_ports rx_bist_err_toggle]
      set_output_delay $usb30_value -max -add -clock $rxclk [get_ports rx_bist_status]
      set_output_delay $usb30_value -max -add -clock $rxclk [get_ports rx_bist_sync]
      set_output_delay $usb30_value -max -add -clock $rxclk [get_ports rx_rd]
      set_output_delay $usb30_loose -max -add -clock $rxclk [get_ports rx_sampler_latch_cal_diag[*]]
   }
   if { $do_10gkr } {
      set rxclk [get_clocks RXRDCLK_10GKR_ACAP_OUT]
      set_output_delay $tengkr_value -max -add -clock $rxclk [get_ports rx_bist_err_toggle]
      set_output_delay $tengkr_value -max -add -clock $rxclk [get_ports rx_bist_status]
      set_output_delay $tengkr_value -max -add -clock $rxclk [get_ports rx_bist_sync]
      set_output_delay $tengkr_value -max -add -clock $rxclk [get_ports rx_rd]
      set_output_delay $tengkr_loose -max -add -clock $rxclk [get_ports rx_sampler_latch_cal_diag[*]]
   }
   if { $do_gbe } {
      set rxclk [get_clocks RXRDCLK_GBE_ACAP_OUT]
      set_output_delay $gbe_value -max -add -clock $rxclk [get_ports rx_bist_err_toggle]
      set_output_delay $gbe_value -max -add -clock $rxclk [get_ports rx_bist_status]
      set_output_delay $gbe_value -max -add -clock $rxclk [get_ports rx_bist_sync]
      set_output_delay $gbe_value -max -add -clock $rxclk [get_ports rx_rd]
      set_output_delay $gbe_value -max -add -clock $rxclk [get_ports rx_sampler_latch_cal_diag[*]]
   }

#
# RX signals
#

set serclk_outputs [get_ports { \
   rx_rd[*] \
   rx_link_eval_fb_dir_change[*] \
   rx_bist_status \
   rx_bist_err_toggle \
   rx_bist_sync \
}]
# Set I/O timing to 2/3 clock period.
#set ser_value  [expr round(($CLK500_PERIOD * 2.0 / 3.0) * 100) / 100.0]
foreach_in_collection pma_port $serclk_outputs {
   set port_name [get_object $pma_port]

   set_output_delay 1.0  -max -add -clock [get_clocks {SERCLK_GEN3_ACAP}]  $port_name
   set_output_delay 2.0  -max -add -clock [get_clocks {SERCLK_GEN2_ACAP}]  $port_name
   set_output_delay 2.0  -max -add -clock [get_clocks {SERCLK_GEN1_ACAP}]  $port_name
   set_output_delay 1.0  -max -add -clock [get_clocks {SERCLK_USB30_ACAP}] $port_name
   set_output_delay 1.0  -max -add -clock [get_clocks {SERCLK_10GKR_ACAP}] $port_name
   set_output_delay 1.0  -max -add -clock [get_clocks {SERCLK_GBE_ACAP}]   $port_name
}


#rx_sampler_latch_cal_diag[*]
set_output_delay 0.50 -max -add -clock [get_clocks {SERCLK_GEN3_ACAP}]  [get_ports {rx_sampler_latch_cal_diag[*]}]
set_output_delay 0.50 -max -add -clock [get_clocks {SERCLK_GEN2_ACAP}]  [get_ports {rx_sampler_latch_cal_diag[*]}]
set_output_delay 0.50 -max -add -clock [get_clocks {SERCLK_GEN1_ACAP}]  [get_ports {rx_sampler_latch_cal_diag[*]}]
set_output_delay 0.50 -max -add -clock [get_clocks {SERCLK_USB30_ACAP}] [get_ports {rx_sampler_latch_cal_diag[*]}]
set_output_delay 0.50 -max -add -clock [get_clocks {SERCLK_10GKR_ACAP}] [get_ports {rx_sampler_latch_cal_diag[*]}]
set_output_delay 0.50 -max -add -clock [get_clocks {SERCLK_GBE_ACAP}]   [get_ports {rx_sampler_latch_cal_diag[*]}]

set_output_delay 0.50 -max -add -clock [get_clocks {PCLK_ACAP_IN}] [get_ports {rx_sampler_latch_cal_diag[*]}]

## ATPG Scan
#
set_input_delay 0.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_scanin[*]}]
set_input_delay 0.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_scanmode}]
set_input_delay 0.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_scanen}]
set_input_delay 0.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_scanen_cg}]

set_output_delay 0.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_scanout[*]}]

#
# Boundary Scan 
#
set_input_delay 0.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_bscan_mode_c}]
set_input_delay 0.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_bscan_acpulse}]
set_input_delay 0.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_bscan_ac}]

set_input_delay  2.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_bscan_tdi}]
set_output_delay 2.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {tx_bscan_tdo}]

set_input_delay  2.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_bscan_tdi}]
set_output_delay 2.0 -add -clock [get_clocks {IO_ASYNC}] [get_ports {rx_bscan_tdo}]


set_input_delay 1.00 -add -clock [get_clocks {IO_ASYNC}] [get_ports {xcvr_scanin[*]}]
set_max_delay 1.20 -to [get_ports {xcvr_scanout[*]}]

#######################################
# Driving Cell
#######################################
set_driving_cell -lib_cell $DRIVING_CELL -pin $DRIVING_PIN $digital_input_port_collection

###############################################################################
# Output Port Loading
###############################################################################
set_load 0.050 $digital_output_port_collection



#######################################
# Dont_Touch Nets
#######################################
# Power & Ground Connections
set_dont_touch [get_nets $power_ground_port_list]
# Cmn_ana connections that must remain pure from/to their respective pma_cmn I/O ports.
set_dont_touch [get_nets $analog_port_list]

###############################################################################
#
# Path exceptions.
#
###############################################################################
set_false_path -from [get_clocks {IO_ASYNC}]
set_false_path -to   [get_clocks {IO_ASYNC}]

#synthesis
if { $load_syn_sdc && !$load_post_map_syn_sdc } {

#P&R
} else {

   # Set false paths to first flop in reset_sync logic.
   #   *genblk1_u_reset_sync_synth_[234] are special synchronizer cells.
   #   *genblk1_u_reset_sync_synth_*_1 are synchronizers made from cascaded flops.
   set_false_path -to [get_pins -hier { *genblk1_u_reset_sync_synth_*_1/D }]
   set_false_path -to [get_pins -hier { *genblk1_u_reset_sync_synth_2_1/D }]
   set_false_path -to [get_pins -hier { *genblk1_u_reset_sync_synth_3_1/D }]
   set_false_path -to [get_pins -hier { *genblk1_u_reset_sync_synth_4_1/D }]

   # Set false paths to first flop in data_sync logic.
   #   *genblk1_u_data_sync_synth_[24] are special synchronizer cells.
   #   *genblk1_genblk1_u_data_sync_synth_*_1 are synchronizers made from cascaded flops.
   set_false_path -to [get_pins -hier { *genblk1_genblk1_u_data_sync_synth_*_1/D }]
   # Loren confirmed that both reset_sync flops get asynchronous resets.
   set_false_path -to [get_pins -hier { \
      *genblk1_u_reset_sync_synth_2_*/CD \
      *genblk1_u_reset_sync_synth_3_*/CD \
      *genblk1_u_reset_sync_synth_4_*/CD \
   }]

   # Some synchronizers are implemented as multi-bit cells. In most cases the first flop is the 
   # D0 pin, but in a few cases it's the D1.
   #set mb_sync_pins [get_pins -hier { \
   #   *CDN_MBIT_genblk1_genblk1_u_data_sync_synth_2_1_MB_genblk1_genblk1_u_data_sync_synth_2_2/D0 \
   #   *CDN_MBIT_genblk1_genblk1_u_data_sync_synth_4_1_MB_genblk1_genblk1_u_data_sync_synth_4_2/D0 \
   #}]
   #set mb_exception_pins [get_pins -hier { \
   #   *genblk1_u_data_sync_synth_2_1_MB_genblk1_genblk1_u_data_sync_synth_2_1_MB_CDN_MBIT_genblk1_genblk1_u_data_sync_synth_2_1_MB_genblk1_genblk1_u_data_sync_synth_2_2/D0 \
   #  *genblk1_u_data_sync_synth_2_2_MB_genblk1_genblk1_u_data_sync_synth_2_1_MB_CDN_MBIT_genblk1_genblk1_u_data_sync_synth_2_2_MB_genblk1_genblk1_u_data_sync_synth_2_2/D0 \
   #$}]
   #set mb_sync_pins [remove_from_collection $mb_sync_pins $mb_exception_pins]
   #set_false_path -to $mb_sync_pins
   #set_false_path -to [get_pins -hier { *genblk1_u_data_sync_synth_2_1_MB_genblk1_genblk1_u_data_sync_synth_2_1_MB_CDN_MBIT_genblk1_genblk1_u_data_sync_synth_2_1_MB_genblk1_genblk1_u_data_sync_synth_2_2/D1 }]
   #set_false_path -to [get_pins -hier { *genblk1_u_data_sync_synth_2_2_MB_genblk1_genblk1_u_data_sync_synth_2_1_MB_CDN_MBIT_genblk1_genblk1_u_data_sync_synth_2_2_MB_genblk1_genblk1_u_data_sync_synth_2_2/D1 }]
   #set_false_path -to [get_pins { u_rx_ctrl/u_rx_sig_detect_filt_apb_icfg/u_rx_sig_detect_filt_apb/u_rx_sig_detect_filt/u_data_sync_rxda_signal_detect_fast/u_data_sync_synth/CDN_MBIT_genblk1_genblk1_u_data_sync_synth_4_4_MB_genblk1_genblk1_u_data_sync_synth_4_1/D1 }]

   # Set false paths to analog scanin pins and from analog scanout pins.
   set_false_path -to      [get_pins { u_xcvr_ana/*scanin }]
   set_false_path -to      [get_pins { u_xcvr_ana/*scanin[*] }]
   set_false_path -through [get_pins { u_xcvr_ana/*scanout }]
   set_false_path -through [get_pins { u_xcvr_ana/*scanout[*] }]

   # False path all paths to SI pins.
   set si_pin_collection [ get_pins -of [ all_registers ] -filter { @name == SI } ]
   set_false_path  -from [all_clocks]  -to $si_pin_collection

}
###############################################################################
# Ideal Networks
###############################################################################


if { $load_syn_sdc && !$load_post_map_syn_sdc } {

} else {
   # NOTE : doing following to fix recovery violations in the prects db where we see large
   # fanout on the reset nets, which results in big delays on muxes and reset pins.
   if {$timeMode == "ideal"} {
        set_ideal_network [get_ports cmn_cdb_preset_n_in]
        set_ideal_network [get_ports cmn_reset_n_in]
	}

}

###############################################################################
#set propagated clock for p&r
###############################################################################
if {$load_syn_sdc} {
} else {
 if {$timeMode == "prop"} {
    reset_clock_tree_latency [all_clocks]
    set_propagated_clock     [all_clocks]
 }
}


