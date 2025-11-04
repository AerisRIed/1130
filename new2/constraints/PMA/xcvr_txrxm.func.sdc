###############################################################################
# These confidential and proprietary static timing constraints for a Hardware
# component may be used only as authorized by a licensing agreement from
# Cadence Design Systems, Inc. In the event of publication, the following
# notice is applicable:
#
#       (C) COPYRIGHT 2014 Cadence Design Systems, Inc.
#           ALL RIGHTS RESERVED
#
# The entire notice above must be reproduced on all authorized copies of
# this code.
###############################################################################
#
# Filename  : xcvr.func.tcl
# Version   : $Revision$
# Date/Time : $Date$
#
# Author    : Dave Masters & Randy Fry
# Abstract  : Functional constraints for the SalvoFF XCVR.
#
###############################################################################
# Change Log
# $Log:$
#
###############################################################################

if { [info exists load_syn_sdc] && $load_syn_sdc} {
    source $DUT_PATH/design/constraints/PMA/xcvr_txrxm.preamble.sdc
} else {
    source [file dirname [info script]]/xcvr_txrxm.preamble.sdc
}

current_design  xcvr_txrxm


###############################################################################
# set_case_analysis
###############################################################################
set_case_analysis 0 [get_ports xcvr_scanen_cg]
set_case_analysis 0 [get_ports xcvr_scanen]
set_case_analysis 0 [get_ports xcvr_scanmode]



# During functional mode when powered up, sandh need to be timed as passthru to allow PSM clk data phase to output pins
if { [info exists load_syn_sdc] && $load_syn_sdc} {
   set_case_analysis 0 [get_pins -hier { *xcvr_diag_rxclk_ctrl_reg* }]
   set_case_analysis 0 [get_pins -hier { *xcvr_diag_txclk_ctrl_reg* }]
} else {
# Need to force non-inverted deserializer and serializer clocks. 
   set_case_analysis 0 [get_pins -hier { *xcvr_diag_rxclk_ctrl_reg_reg[15]/Q }]
   set_case_analysis 0 [get_pins -hier { *xcvr_diag_txclk_ctrl_reg_reg[15]/Q }]
   set_case_analysis 0 [get_pins u_xcvr_ctrl/u_sandh_latch_xcvr_power_state_ack/sandh_out_reg[*]/EN]
}

#######################################
# Clock definitions
#######################################

############################################
# Reference clocks
############################################
#
# CMN_REFCLK_IN
#
create_clock                                                                                        \
    -name           REFCLK_GATED_IN                                                                 \
    -period         $CLK156P25_PERIOD                                                               \
    -waveform       $CLK156P25_WAVEFORM                                                             \
    -add                                                                                            \
    [get_ports cmn_ref_clk_gated_in]

create_generated_clock \
    -name           REFCLK_GATED_OUT \
    -divide_by      1                                                                               \
    -master_clock   [get_clocks REFCLK_GATED_IN]                                                    \
    -source         [get_ports cmn_ref_clk_gated_in] \
    -add \
    [get_ports cmn_ref_clk_gated_out]
#
# Reference Clock for analog circuits to sample the transmitter signals
#
create_generated_clock                                                                              \
    -name           TXDA_RCVDET_CLK                                                                 \
    -divide_by      1                                                                               \
    -master_clock   [get_clocks REFCLK_GATED_IN]                                                    \
    -source         [get_ports cmn_ref_clk_gated_in]                                                \
    -add                                                                                            \
    [get_pins u_xcvr_ana/txda_rcvdet_ref_clk]

###########################################################
# PSM clock
# JMY 20201030 Update to 200MHz as required in atspeed and stuckat per Mark Taylor
###########################################################
create_clock                                                                                        \
    -name           PSMCLK                                                                   \
    -period         $CLK200_PERIOD                                                                \
    -waveform       $CLK200_WAVEFORM                                                               \
    -add                                                                                            \
    [get_ports xcvr_psm_clk]

############################################
# CDB clock.
############################################
#
#CDBCLK_IN
#
create_clock                                                                                        \
    -name           CDBCLK_IN                                                                   \
    -period         $CLK525_PERIOD                                                                  \
    -waveform       $CLK525_WAVEFORM                                                                \
    -add                                                                                            \
    [get_ports  xcvr_cdb_pclk]

############################################
# Full-rate and data-rate clocks.
############################################
#
# PLL1 
#
create_clock                                                                                      \
    -name           PLL1_CLK_FULLRT_DISPLAY_IN                                                    \
    -period         $CLK1031P25_PERIOD                                                            \
    -waveform       $CLK1031P25_WAVEFORM                                                          \
    -add                                                                                          \
    [get_ports cmn_pll1_clk_0_scanned_in]

 create_generated_clock                                                                           \
     -name         PLL1CLK_FULLRT_DISPLAY_OUT                                                     \
     -divide_by    1                                                                              \
     -master_clock [get_clocks PLL1_CLK_FULLRT_DISPLAY_IN ]                                       \
     -source       [get_ports cmn_pll1_clk_0_scanned_in ]                                         \
     -add                                                                                         \
     [get_ports xcvr_pll_clk_fullrt]

create_generated_clock                                                                            \
    -name           PLL1CLK_DATART_DISPLAY                                                        \
    -divide_by      2                                                                             \
    -master_clock   [get_clocks PLL1_CLK_FULLRT_DISPLAY_IN]                                       \
    -source         [get_ports cmn_pll1_clk_0_scanned_in]                                         \
    -add                                                                                          \
    [get_pins u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux_I1_pin}]

 create_generated_clock                                                                           \
      -name         PLL1CLK_DATART_DISPLAY_OUT                                                    \
      -divide_by    1                                                                            \
      -master_clock [get_clocks  PLL1CLK_DATART_DISPLAY ]                                         \
      -source       [get_pins u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux_I1_pin}] \
      -add                                                                                        \
      [get_ports xcvr_pll_clk_datart]


create_clock                                                                                      \
    -name           PLL1_CLK_FULLRT_IN                                                            \
    -period         $CLK500_PERIOD                                                                \
    -waveform       $CLK500_WAVEFORM                                                              \
    -add                                                                                          \
    [get_ports cmn_pll1_clk_0_scanned_in]

 create_generated_clock                                                                           \
     -name         PLL1CLK_FULLRT_GEN3_OUT                                                        \
     -divide_by    1                                                                              \
     -master_clock [get_clocks PLL1_CLK_FULLRT_IN ]                                               \
     -source       [get_ports cmn_pll1_clk_0_scanned_in ]                                         \
     -add                                                                                         \
     [get_ports xcvr_pll_clk_fullrt]

create_generated_clock                                                                            \
    -name           PLL1CLK_DATART_GEN3                                                           \
    -divide_by      1                                                                             \
    -master_clock   [get_clocks PLL1_CLK_FULLRT_IN]                                               \
    -source         [get_ports cmn_pll1_clk_0_scanned_in]                                         \
    -add                                                                                          \
    [get_pins u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux_I0_pin}]

 create_generated_clock                                                                           \
      -name         PLL1CLK_DATART_GEN3_OUT                                                       \
      -divide_by    1                                                                             \
      -master_clock [get_clocks  PLL1CLK_DATART_GEN3 ]                                             \
      -source       [get_pins u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux_I0_pin} ] \
      -add                                                                                        \
      [get_ports xcvr_pll_clk_datart]

create_generated_clock                                                                            \
    -name           PLL1CLK_DATART_GEN2                                                           \
    -divide_by      2                                                                             \
    -master_clock   [get_clocks PLL1_CLK_FULLRT_IN]                                               \
    -source         [get_ports cmn_pll1_clk_0_scanned_in]                                         \
    -add                                                                                          \
    [get_pins u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux_I1_pin}]

create_generated_clock                                                                            \
    -name           PLL1CLK_DATART_GEN1                                                           \
    -divide_by      4                                                                             \
    -master_clock   [get_clocks PLL1_CLK_FULLRT_IN]                                               \
    -source         [get_ports cmn_pll1_clk_0_scanned_in]                                         \
    -add                                                                                          \
    [get_pins u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux_I1_pin}]

create_generated_clock                                                                            \
    -name           PLL1CLK_DATART_DIV8                                                           \
    -divide_by      8                                                                             \
    -master_clock   [get_clocks PLL1_CLK_FULLRT_IN]                                               \
    -source         [get_ports cmn_pll1_clk_0_scanned_in]                                         \
    -add                                                                                          \
    [get_pins u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux_I1_pin}]
#
#PLL0
#
create_clock                                                                                      \
    -name           PLL0_CLK_FULLRT_DISPLAY_IN                                                    \
    -period         $CLK1031P25_PERIOD                                                            \
    -waveform       $CLK1031P25_WAVEFORM                                                          \
    -add                                                                                          \
    [get_ports cmn_pll0_clk_0_scanned_in]

create_generated_clock                                                                            \
     -name         PLL0CLK_FULLRT_DISPLAY_OUT                                                     \
     -divide_by    1                                                                              \
     -master_clock [get_clocks  PLL0_CLK_FULLRT_DISPLAY_IN ]                                      \
     -source       [get_ports cmn_pll0_clk_0_scanned_in ]                                         \
     -add                                                                                         \
     [get_ports xcvr_pll_clk_fullrt ]

create_clock                                                                                      \
    -name           PLL0_CLK_FULLRT_IN                                                            \
    -period         $CLK500_PERIOD                                                                \
    -waveform       $CLK500_WAVEFORM                                                              \
    -add                                                                                          \
    [get_ports cmn_pll0_clk_0_scanned_in]

create_generated_clock                                                                            \
     -name         PLL0CLK_FULLRT_GEN3_OUT                                                        \
     -divide_by    1                                                                              \
     -master_clock [get_clocks  PLL0_CLK_FULLRT_IN ]                                              \
     -source       [get_ports cmn_pll0_clk_0_scanned_in ]                                         \
     -add                                                                                         \
     [get_ports xcvr_pll_clk_fullrt ]

create_generated_clock                                                                            \
     -name         PLL0CLK_DATART_GEN2                                                            \
     -divide_by    2                                                                              \
     -master_clock [get_clocks  PLL0_CLK_FULLRT_IN ]                                              \
     -source       [get_ports cmn_pll0_clk_0_scanned_in ]                                         \
     -add                                                                                         \
     [get_pins u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux_I1_pin}]

create_generated_clock \
      -name         PLL0CLK_DATART_GEN2_OUT \
      -divide_by    1 \
      -master_clock [get_clocks PLL0CLK_DATART_GEN2] \
      -source       [get_pins u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux_I1_pin}] \
      -add \
      [get_ports xcvr_pll_clk_datart ]
#gen1
create_generated_clock \
    -name         PLL0CLK_DATART_GEN1 \
    -divide_by    4 \
    -master_clock [get_clocks  PLL0_CLK_FULLRT_IN ] \
    -source       [get_ports  cmn_pll0_clk_0_scanned_in ] \
    -add \
    [get_pins u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux_I1_pin} ]

create_generated_clock \
    -name         PLL0CLK_DATART_GEN1_OUT \
    -divide_by    1 \
    -master_clock [get_clocks PLL0CLK_DATART_GEN1] \
    -source       [get_pins u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux_I1_pin} ] \
    -add \
    [get_ports xcvr_pll_clk_datart]

create_generated_clock                                                                              \
    -name           PLL0CLK_DATART_DIV8                                                           \
    -divide_by      8                                                                               \
    -master_clock   [get_clocks PLL0_CLK_FULLRT_IN]                                              \
    -source         [get_ports cmn_pll0_clk_0_scanned_in]                                               \
    -add                                                                                            \
    [get_pins u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux_I1_pin} ]
#USB 3.0
create_clock                                                                                      \
    -name           PLL0_CLK0_FULLRT_USB_IN                                                        \
    -period         $CLK500_PERIOD                                                                \
    -waveform       $CLK500_WAVEFORM                                                              \
    -add                                                                                          \
    [get_ports cmn_pll0_clk_0_scanned_in]

create_clock                                                                                      \
    -name           PLL1_CLK0_FULLRT_USB_IN                                                        \
    -period         $CLK500_PERIOD                                                                \
    -waveform       $CLK500_WAVEFORM                                                              \
    -add                                                                                          \
    [get_ports cmn_pll1_clk_0_scanned_in]

create_clock                                                                                      \
    -name           PLL0_CLK1_FULLRT_USB_IN                                                        \
    -period         $CLK625_PERIOD                                                                \
    -waveform       $CLK625_WAVEFORM                                                              \
    -add                                                                                          \
    [get_ports cmn_pll0_clk_1_scanned_in]

create_clock                                                                                      \
    -name           PLL1_CLK1_FULLRT_USB_IN                                                        \
    -period         $CLK625_PERIOD                                                                \
    -waveform       $CLK625_WAVEFORM                                                              \
    -add                                                                                          \
    [get_ports cmn_pll1_clk_1_scanned_in]
 
create_generated_clock \
    -name         PLL0CLK_DATART_USB30 \
    -divide_by    1 \
    -master_clock [get_clocks  PLL0_CLK1_FULLRT_USB_IN ] \
    -source       [get_ports  cmn_pll0_clk_1_scanned_in ] \
    -add \
    [get_pins u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux_I0_pin} ]

create_generated_clock \
    -name         PLL0CLK_DATART_USB30_OUT \
    -divide_by    1 \
    -master_clock [get_clocks PLL0CLK_DATART_USB30] \
    -source       [get_pins u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux_I0_pin} ] \
    -add \
    [get_ports xcvr_pll_clk_datart ]


#U4
create_clock                                                                                      \
    -name           PLL0_CLK0_FULLRT_U4_IN                                                      \
    -period         $CLK1250_PERIOD                                                               \
    -waveform       $CLK1250_WAVEFORM                                                             \
    -add                                                                                          \
    [get_ports cmn_pll0_clk_0_scanned_in]

create_clock                                                                                      \
    -name           PLL0_CLK1_FULLRT_U4_IN                                                      \
    -period         $CLK1250_PERIOD                                                               \
    -waveform       $CLK1250_WAVEFORM                                                             \
    -add                                                                                          \
    [get_ports cmn_pll0_clk_1_scanned_in]

create_clock                                                                                      \
    -name           PLL1_CLK0_FULLRT_U4_IN                                                      \
    -period         $CLK1000_PERIOD                                                               \
    -waveform       $CLK1000_WAVEFORM                                                             \
    -add                                                                                          \
    [get_ports cmn_pll1_clk_0_scanned_in]


create_clock                                                                                      \
    -name           PLL1_CLK1_FULLRT_U4_IN                                                      \
    -period         $CLK1000_PERIOD                                                               \
    -waveform       $CLK1000_WAVEFORM                                                             \
    -add                                                                                          \
    [get_ports cmn_pll1_clk_1_scanned_in]

create_generated_clock \
    -name         PLL0CLK_DATART_U4 \
    -divide_by    1 \
    -master_clock [get_clocks  PLL0_CLK1_FULLRT_U4_IN ] \
    -source       [get_ports  cmn_pll0_clk_1_scanned_in ] \
    -add \
    [get_pins u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux_I0_pin} ]

create_generated_clock \
    -name         PLL0CLK_DATART_U4_OUT \
    -divide_by    1 \
    -master_clock [get_clocks PLL0CLK_DATART_U4] \
    -source       [get_pins u_xcvr_clkrst/u_clock_div_prog_pll_clk/u_clock_mux/${clk_mux_I0_pin} ] \
    -add \
    [get_ports xcvr_pll_clk_datart ]


############################################
# Lock Detection clocks.
############################################
# The Lockdet clock is the a step clock, which steps up in frequency till it finds the
# closest frequency that matches.
# email 2012/05/29 -
#       rxda_*pi_ill_cal_lockdet_clk  These clocks are the divide by 16 clocks coming out of the deserializer (rxda_des_clk and rxda_des_clk_e).
#       at lowest cal setting (where the cal routine starts), can be 800MHz/16
#       at highest cal setting, can be 8GHz+/16 = 0.125ns*16= 2.0ns
#       2012/09/18 - In my sims, I verify the function over corners to 4.4G so you would see 550MHz.

create_clock \
    -name     SDCLK \
    -period   $CLK625_PERIOD \
    -waveform $CLK625_WAVEFORM \
    [get_pins u_xcvr_ana/rxda_sd_clk]

############################################
# Lane transmit (tx_td) clocks. 
############################################
#
#TXTDCLKIN,
# This is the input clock to each lane to which
# the tx_td data can be synchronized.
#
if { $do_display } {
   create_clock                                                                                        \
       -name           TXTDCLK_DISPLAY                                                                    \
       -period         $CLK515P625_PERIOD                                                                    \
       -waveform       $CLK515P625_WAVEFORM                                                                  \
       -add                                                                                            \
       [get_ports tx_td_clk]
}

if { $do_pcie_gen3 } {
   create_clock                                                                                        \
       -name           TXTDCLK_GEN3                                                                    \
       -period         $CLK500_PERIOD                                                                    \
       -waveform       $CLK500_WAVEFORM                                                                  \
       -add                                                                                            \
       [get_ports tx_td_clk]
}

if { $do_pcie_gen2 } {
   create_clock                                                                                        \
       -name           TXTDCLK_GEN2                                                                    \
       -period         $CLK250_PERIOD                                                                    \
       -waveform       $CLK250_WAVEFORM                                                                  \
       -add                                                                                            \
       [get_ports tx_td_clk]
}

if { $do_pcie_gen1 } {
   create_clock                                                                                        \
       -name           TXTDCLK_GEN1                                                                    \
       -period         $CLK125_PERIOD                                                                    \
       -waveform       $CLK125_WAVEFORM                                                                  \
          -add                                                                                            \
       [get_ports tx_td_clk]
}

if { $do_usb30 } {
      create_clock \
         -name     TXTDCLK_USB30 \
         -period   $CLK625_PERIOD \
         -waveform $CLK625_WAVEFORM \
         -add \
         [get_ports tx_td_clk]
}



if { $do_usb4 } {
      create_clock \
         -name     TXTDCLK_U4 \
         -period   $CLK1250_PERIOD \
         -waveform $CLK1250_WAVEFORM \
         -add \
         [get_ports tx_td_clk]
}






############################################
# Serializer clocks.
############################################
#
#Serializer clock from Transmitter
#
if { $do_display } {
   create_clock                                                                                        \
       -name           TXCLK_DISPLAY                                                                      \
       -period         $CLK515P625_PERIOD                                                                    \
       -waveform       $CLK515P625_WAVEFORM                                                                  \
       -add                                                                                            \
       [get_pins u_xcvr_ana/txda_ser_clk]
}

# Gen3
if { $do_pcie_gen3 } {
   create_clock                                                                                        \
       -name           TXCLK_GEN3                                                                      \
       -period         $CLK500_PERIOD                                                                    \
       -waveform       $CLK500_WAVEFORM                                                                  \
       -add                                                                                            \
       [get_pins u_xcvr_ana/txda_ser_clk]
   

#      # Block TXCLK_GEN3 from going through the divided side of the clock selection mux.
#      set_clock_sense -clocks [get_clocks TXCLK_GEN3] -stop_propagation \
#         [get_pins u_xcvr_clkrst/u_clock_div_tx_ser_clk/u_clock_mux/${clk_mux_I1_pin}]
          
}

# Gen2
if { $do_pcie_gen2 } {
   create_clock                                                                                        \
       -name           TXCLK_GEN2                                                                      \
       -period         $CLK250_PERIOD                                                                    \
       -waveform       $CLK250_WAVEFORM                                                                  \
       -add                                                                                            \
       [get_pins u_xcvr_ana/txda_ser_clk]
   

#      # Block LN_*_TXCLK_GEN2 from going through the divided side of the clock selection mux.
#      set_clock_sense -clocks [get_clocks TXCLK_GEN2] -stop_propagation \
#         [get_pins u_xcvr_clkrst/u_clock_div_tx_ser_clk/u_clock_mux/${clk_mux_I1_pin}] 
  
}

# Gen1
if { $do_pcie_gen1 } {
   create_clock                                                                                        \
       -name           TXCLK_GEN1                                                                      \
       -period         $CLK125_PERIOD                                                                    \
       -waveform       $CLK125_WAVEFORM                                                                  \
       -add                                                                                            \
       [get_pins u_xcvr_ana/txda_ser_clk]
   

#      # Block LN_*_TXCLK_GEN1 from going through the divided side of the clock selection mux.
#      set_clock_sense -clocks [get_clocks TXCLK_GEN1] -stop_propagation \
#         [get_pins u_xcvr_clkrst/u_clock_div_tx_ser_clk/u_clock_mux/${clk_mux_I1_pin}]  
 
}

# USB 3.0

if { $do_usb30 } {
   

      create_clock \
         -name     TXCLK_USB30 \
         -period   $CLK625_PERIOD \
         -waveform $CLK625_WAVEFORM \
         -add \
         [get_pins u_xcvr_ana/txda_ser_clk] 

#      # Block LN_*_TXCLK_USB30 from going through the divided side of the clock selection mux.
#      set_clock_sense -clocks [get_clocks TXCLK_USB30] -stop_propagation \
#         [get_pins u_xcvr_clkrst/u_clock_div_tx_ser_clk/u_clock_mux/${clk_mux_I1_pin}]
}

# USB 4

if { $do_usb4 } {
   

      create_clock \
         -name     TXCLK_U4 \
         -period   $CLK1250_PERIOD \
         -waveform $CLK1250_WAVEFORM \
         -add \
         [get_pins u_xcvr_ana/txda_ser_clk] 

}



############################################
# Near-end loopback clocks.
############################################

# Near-end loopback clocks are generated from the tx_td_clk clocks.
#
#LPBK_NE
# NOTE: needs to be redefined during p&r at the ouput of the gate.
#
if { $do_display } {
   create_generated_clock                                                                              \
       -name           LPBK_NE_DISPLAY                                                                 \
       -divide_by      1                                                                               \
       -master_clock   [get_clocks TXTDCLK_DISPLAY]                                                    \
       -source         [get_ports tx_td_clk]                                                           \
       -add                                                                                            \
       [get_pins u_xcvr_clkrst/${tx_td_ne_lpbk_clk_pin}]
   
   create_generated_clock                                                                              \
       -name           LPBK_NE_DISPLAY_OUT                                                             \
       -divide_by      1                                                                               \
       -master_clock   [get_clocks LPBK_NE_DISPLAY]                                                    \
       -source         [get_pins u_xcvr_clkrst/${tx_td_ne_lpbk_clk_pin}]                               \
       -add                                                                                            \
       [get_ports rx_rd_clk]
}

# Gen3
if { $do_pcie_gen3 } {
   create_generated_clock                                                                              \
       -name           LPBK_NE_GEN3                                                                    \
       -divide_by      1                                                                               \
       -master_clock   [get_clocks TXTDCLK_GEN3]                                                       \
       -source         [get_ports tx_td_clk]                                                           \
       -add                                                                                            \
       [get_pins u_xcvr_clkrst/${tx_td_ne_lpbk_clk_pin}]
   
   create_generated_clock                                                                              \
       -name           LPBK_NE_GEN3_OUT                                                                \
       -divide_by      1                                                                               \
       -master_clock   [get_clocks LPBK_NE_GEN3]                                                       \
       -source         [get_pins u_xcvr_clkrst/${tx_td_ne_lpbk_clk_pin}]                               \
       -add                                                                                            \
       [get_ports rx_rd_clk]
}
   
# Gen2
if { $do_pcie_gen2 } {
   create_generated_clock                                                                              \
       -name           LPBK_NE_GEN2                                                                    \
       -divide_by      1                                                                               \
       -master_clock   [get_clocks TXTDCLK_GEN2]                                                       \
       -source         [get_ports tx_td_clk]                                                           \
       -add                                                                                            \
       [get_pins u_xcvr_clkrst/${tx_td_ne_lpbk_clk_pin}]
   
   create_generated_clock                                                                              \
       -name           LPBK_NE_GEN2_OUT                                                                \
       -divide_by      1                                                                               \
       -master_clock   [get_clocks LPBK_NE_GEN2]                                                       \
       -source         [get_pins u_xcvr_clkrst/${tx_td_ne_lpbk_clk_pin}]                                  \
       -add                                                                                            \
       [get_ports rx_rd_clk]
}
   
# Gen1
if { $do_pcie_gen1 } {
   create_generated_clock                                                                              \
       -name           LPBK_NE_GEN1                                                                    \
       -divide_by      1                                                                               \
       -master_clock   [get_clocks TXTDCLK_GEN1]                                                       \
       -source         [get_ports tx_td_clk]                                                           \
       -add                                                                                            \
       [get_pins u_xcvr_clkrst/${tx_td_ne_lpbk_clk_pin}]
   
   create_generated_clock                                                                              \
       -name           LPBK_NE_GEN1_OUT                                                                \
       -divide_by      1                                                                               \
       -master_clock   [get_clocks LPBK_NE_GEN1]                                                       \
       -source         [get_pins u_xcvr_clkrst/${tx_td_ne_lpbk_clk_pin}]                                  \
       -add                                                                                            \
       [get_ports rx_rd_clk]
}

# USB 3.0
   if { $do_usb30 } {

         create_generated_clock \
            -name         LPBK_NE_USB30 \
            -divide_by    1 \
            -master_clock [get_clocks TXTDCLK_USB30] \
            -source       [get_ports tx_td_clk] \
            -add \
            [get_pins u_xcvr_clkrst/u_clk_gating_and_tx_td_ne_lpbk_clk/u_clk_gating_and_synth/u_dont_touch_ck_and/Z]

         create_generated_clock \
            -name         LPBK_NE_USB30_OUT \
            -divide_by    1 \
            -master_clock [get_clocks LPBK_NE_USB30] \
            -source       [get_pins u_xcvr_clkrst/u_clk_gating_and_tx_td_ne_lpbk_clk/u_clk_gating_and_synth/u_dont_touch_ck_and/Z] \
            -add \
            [get_ports rx_rd_clk]
}

# USB 4
   if { $do_usb4 } {

         create_generated_clock \
            -name         LPBK_NE_U4 \
            -divide_by    1 \
            -master_clock [get_clocks TXTDCLK_U4] \
            -source       [get_ports tx_td_clk] \
            -add \
            [get_pins u_xcvr_clkrst/u_clk_gating_and_tx_td_ne_lpbk_clk/u_clk_gating_and_synth/u_dont_touch_ck_and/Z]

         create_generated_clock \
            -name         LPBK_NE_U4_OUT \
            -divide_by    1 \
            -master_clock [get_clocks LPBK_NE_U4] \
            -source       [get_pins u_xcvr_clkrst/u_clk_gating_and_tx_td_ne_lpbk_clk/u_clk_gating_and_synth/u_dont_touch_ck_and/Z] \
            -add \
            [get_ports rx_rd_clk]
}



#     set_clock_sense -clocks [get_clocks LPBK_NE_*] -stop_propagation \
         [get_pins u_xcvr_clkrst/u_clk_gating_and_rx_rd_fe_lpbk_clk/u_clk_gating_and_synth/u_dont_touch_ck_and/Z]

############################################
# Deserializer clocks
############################################
#
# Receiver deserializer clock.
# NOTE: Gen1 & Gen2 : 250MHz, Gen3 : 500MHz.
if { $do_display } {
   create_clock                                                                                        \
       -name           RXCLK_DISPLAY                                                                   \
       -period         $CLK625_PERIOD                                                                  \
       -waveform       $CLK625_WAVEFORM                                                                \
       -add                                                                                            \
       [get_pins u_xcvr_ana/rxda_des_clk]
   
   create_generated_clock                                                                              \
       -name           RXRDCLK_DISPLAY_OUT                                                             \
       -divide_by      1                                                                               \
       -master_clock   [get_clocks RXCLK_DISPLAY]                                                         \
       -source         [get_pins u_xcvr_ana/rxda_des_clk]                                              \
       -add                                                                                            \
       [get_ports rx_rd_clk]

#   create_clock                                                                                        \
       -name           RXCLK_2X_DISPLAY                                                                   \
       -period         $CLK1031P25_PERIOD                                                                 \
       -waveform       $CLK1031P25_WAVEFORM                                                               \
       -add                                                                                            \
       [get_pins u_xcvr_ana/rxda_des_clk_2x]
}
   
# Gen3
if { $do_pcie_gen3 } {
   create_clock                                                                                        \
       -name           RXCLK_GEN3                                                                      \
       -period         $CLK500_PERIOD                                                                  \
       -waveform       $CLK500_WAVEFORM                                                                \
       -add                                                                                            \
       [get_pins u_xcvr_ana/rxda_des_clk]
   
   create_generated_clock                                                                              \
       -name           RXRDCLK_GEN3_OUT                                                                \
       -divide_by      1                                                                               \
       -master_clock   [get_clocks RXCLK_GEN3]                                                         \
       -source         [get_pins u_xcvr_ana/rxda_des_clk]                                              \
       -add                                                                                            \
       [get_ports rx_rd_clk]

#   create_clock                                                                                        \
       -name           RXCLK_2X_GEN3                                                                   \
       -period         $CLK1000_PERIOD                                                                 \
       -waveform       $CLK1000_WAVEFORM                                                               \
       -add                                                                                            \
       [get_pins u_xcvr_ana/rxda_des_clk_2x]
}
   
# Gen2
if { $do_pcie_gen2 } {
   create_clock                                                                                        \
       -name           RXCLK_GEN2                                                                      \
       -period         $CLK250_PERIOD                                                                    \
       -waveform       $CLK250_WAVEFORM                                                                  \
       -add                                                                                            \
       [get_pins u_xcvr_ana/rxda_des_clk]
   
   create_generated_clock                                                                              \
       -name           RXRDCLK_GEN2_OUT                                                                \
       -divide_by      1                                                                               \
       -master_clock   [get_clocks RXCLK_GEN2]                                                         \
       -source         [get_pins u_xcvr_ana/rxda_des_clk]                                              \
       -add                                                                                            \
       [get_ports rx_rd_clk]

#   create_clock                                                                                        \
       -name           RXCLK_2X_GEN2                                                                      \
       -period         $CLK500_PERIOD                                                                    \
       -waveform       $CLK500_WAVEFORM                                                                  \
       -add                                                                                            \
       [get_pins u_xcvr_ana/rxda_des_clk_2x]
}
   
# Gen1
if { $do_pcie_gen1 } {
   create_clock                                                                                        \
       -name           RXCLK_GEN1                                                                      \
       -period         $CLK125_PERIOD                                                                    \
       -waveform       $CLK125_WAVEFORM                                                                  \
       -add                                                                                            \
       [get_pins u_xcvr_ana/rxda_des_clk]
   
   create_generated_clock                                                                              \
       -name           RXRDCLK_GEN1_OUT                                                                \
       -divide_by      1                                                                               \
       -master_clock   [get_clocks RXCLK_GEN1]                                                         \
       -source         [get_pins u_xcvr_ana/rxda_des_clk]                                              \
       -add                                                                                            \
       [get_ports rx_rd_clk]

#   create_clock                                                                                        \
       -name           RXCLK_2X_GEN1                                                                      \
       -period         $CLK250_PERIOD                                                                    \
       -waveform       $CLK250_WAVEFORM                                                                  \
       -add                                                                                            \
       [get_pins u_xcvr_ana/rxda_des_clk_2x]
}

# USB 3.0
if { $do_usb30 } {
      create_clock \
         -name     RXCLK_USB30 \
         -period   $CLK625_PERIOD \
         -waveform $CLK625_WAVEFORM \
         -add \
         [get_pins u_xcvr_ana/rxda_des_clk]

      create_generated_clock \
         -name         RXRDCLK_USB30_OUT \
         -divide_by    1 \
         -master_clock [get_clocks RXCLK_USB30] \
         -source       [get_pins u_xcvr_ana/rxda_des_clk] \
         -add \
         [get_ports rx_rd_clk]
}

# USB 4
if { $do_usb4 } {
      create_clock \
         -name     RXCLK_U4 \
         -period   $CLK1250_PERIOD \
         -waveform $CLK1250_WAVEFORM \
         -add \
         [get_pins u_xcvr_ana/rxda_des_clk]

      create_generated_clock \
         -name         RXRDCLK_U4_OUT \
         -divide_by    1 \
         -master_clock [get_clocks RXCLK_U4] \
         -source       [get_pins u_xcvr_ana/rxda_des_clk] \
         -add \
         [get_ports rx_rd_clk]
}


# The clock divider in the receiver is not used for any modes so block phases from going
# through the divider side of the clock selection mux.
#
# Also, the RXCLK phases are used in the transmitter for far-end loopback mode. Block the
# phases from propagating back to the receiver through the near-end loopback path.

#   set_clock_sense -clocks [get_clocks RXCLK_*] -stop_propagation \
#      [get_pins u_xcvr_clkrst/u_clock_div_rx_des_clk/u_clock_mux/${clk_mux_I1_pin}]
   set_clock_sense -clocks [get_clocks RXCLK_*] -stop_propagation \
      [get_pins u_xcvr_clkrst/u_clk_gating_and_tx_td_ne_lpbk_clk/u_clk_gating_and_synth/u_dont_touch_ck_and/Z]


############################################
# Boundary scan clocks
############################################

create_clock                                                                                        \
    -name           TX_BSCAN_CLOCKDR                                                                \
    -period         $BSCAN_PERIOD                                                                   \
    -waveform       $BSCAN_WAVEFORM                                                                 \
    [get_ports tx_bscan_clockdr]

create_clock                                                                                        \
    -name           TX_BSCAN_UPDATEDR                                                               \
    -period         $BSCAN_PERIOD                                                                   \
    -waveform       $BSCAN_WAVEFORM                                                                 \
    [get_ports tx_bscan_updatedr]

create_clock                                                                                        \
    -name           RX_BSCAN_CLOCKDR                                                                \
    -period         $BSCAN_PERIOD                                                                   \
    -waveform       $BSCAN_WAVEFORM                                                                 \
    [get_ports rx_bscan_clockdr]

create_clock                                                                                        \
    -name           RX_BSCAN_PC                                                                     \
    -period         $BSCAN_PERIOD                                                                   \
    -waveform       $BSCAN_WAVEFORM                                                                 \
    [get_ports rx_bscan_pc]


#######################################
# Misc clocks
#######################################
# Virtual Asynchronous clock phases. This phase is excluded from all other clocks.
create_clock                                                                                        \
    -name           IO_ASYNC                                                                        \
    -period         $ASYNC_PERIOD                                                                   \
    -waveform       $ASYNC_WAVEFORM

###############################################################################
# virtual clocks for cdb IO
###############################################################################
create_clock -name vclk_seq  -period $CLK200_PERIOD -waveform $CLK200_WAVEFORM
create_clock -name vclk_comb -period $CLK2000_PERIOD -waveform $CLK2000_WAVEFORM

###############################################################################
# Clock Uncertainties
###############################################################################
# NOTE  Signoff Uncertainties: Setup = 130ps = 30ps + 100ps (PLL Jitter)
#                              Hold  = 55ps
#                         MTBF Hold  = 35ps
###############################################################################
set default_margin 5.000

#########################################################################
# Default uncertainties. Default setup is high in order to catch
# unaccounted for clock relationships.
set_clock_uncertainty $default_margin -setup -from [all_clocks] -to [all_clocks]
set_clock_uncertainty $hold_margin    -hold  -from [all_clocks] -to [all_clocks]

set_clock_uncertainty 0.000 -setup -from [get_clocks vclk_comb] -to [get_clocks vclk_comb]
set_clock_uncertainty 0.000 -hold  -from [get_clocks vclk_comb] -to [get_clocks vclk_comb]

# Account for intra-clock relationships.
#set_clock_uncertainty $setup_margin -setup -from [get_clocks REFCLK_IN] -to [get_clocks REFCLK_IN]
set_clock_uncertainty $setup_margin -setup -from [get_clocks REFCLK_GATED_IN] -to [get_clocks REFCLK_GATED_IN]
set_clock_uncertainty $setup_margin -setup -from [get_clocks REFCLK_GATED_OUT] -to [get_clocks REFCLK_GATED_OUT]
set_clock_uncertainty $setup_margin -setup -from [get_clocks LPBK_NE_DISPLAY] -to [get_clocks LPBK_NE_DISPLAY]
set_clock_uncertainty $setup_margin -setup -from [get_clocks LPBK_NE_DISPLAY_OUT] -to [get_clocks LPBK_NE_DISPLAY_OUT]
set_clock_uncertainty $setup_margin -setup -from [get_clocks LPBK_NE_GEN3] -to [get_clocks LPBK_NE_GEN3]
set_clock_uncertainty $setup_margin -setup -from [get_clocks LPBK_NE_GEN3_OUT] -to [get_clocks LPBK_NE_GEN3_OUT]
set_clock_uncertainty $setup_margin -setup -from [get_clocks LPBK_NE_GEN2] -to [get_clocks LPBK_NE_GEN2]
set_clock_uncertainty $setup_margin -setup -from [get_clocks LPBK_NE_GEN2_OUT] -to [get_clocks LPBK_NE_GEN2_OUT]
set_clock_uncertainty $setup_margin -setup -from [get_clocks LPBK_NE_GEN1] -to [get_clocks LPBK_NE_GEN1]
set_clock_uncertainty $setup_margin -setup -from [get_clocks LPBK_NE_GEN1_OUT] -to [get_clocks LPBK_NE_GEN1_OUT]
set_clock_uncertainty $setup_margin -setup -from [get_clocks LPBK_NE_USB30] -to [get_clocks LPBK_NE_USB30]
set_clock_uncertainty $setup_margin -setup -from [get_clocks LPBK_NE_USB30_OUT] -to [get_clocks LPBK_NE_USB30_OUT]
set_clock_uncertainty $setup_margin -setup -from [get_clocks LPBK_NE_U4] -to [get_clocks LPBK_NE_U4]
set_clock_uncertainty $setup_margin -setup -from [get_clocks LPBK_NE_U4_OUT] -to [get_clocks LPBK_NE_U4_OUT]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks LPBK_NE_10GKR_OUT] -to [get_clocks LPBK_NE_10GKR_OUT]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks LPBK_NE_GBE] -to [get_clocks LPBK_NE_GBE]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks LPBK_NE_GBE_OUT] -to [get_clocks LPBK_NE_GBE_OUT]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TX_BSCAN_CLOCKDR] -to [get_clocks TX_BSCAN_CLOCKDR]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TX_BSCAN_UPDATEDR] -to [get_clocks TX_BSCAN_UPDATEDR]
set_clock_uncertainty $setup_margin -setup -from [get_clocks RX_BSCAN_CLOCKDR] -to [get_clocks RX_BSCAN_CLOCKDR]
set_clock_uncertainty $setup_margin -setup -from [get_clocks RX_BSCAN_PC] -to [get_clocks RX_BSCAN_PC]
set_clock_uncertainty $setup_margin -setup -from [get_clocks { CDBCLK_IN vclk_seq }] -to [get_clocks { CDBCLK_IN vclk_seq }]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks { CDBCLK_OUT vclk_seq }] -to [get_clocks { CDBCLK_OUT vclk_seq }]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks RXCLK_2X_DISPLAY] -to [get_clocks RXCLK_2X_DISPLAY]
set_clock_uncertainty $setup_margin -setup -from [get_clocks RXCLK_DISPLAY] -to [get_clocks RXCLK_DISPLAY]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks RXCLK_2X_GEN3] -to [get_clocks RXCLK_2X_GEN3]
set_clock_uncertainty $setup_margin -setup -from [get_clocks RXCLK_GEN3] -to [get_clocks RXCLK_GEN3]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks RXCLK_2X_GEN2] -to [get_clocks RXCLK_2X_GEN2]
set_clock_uncertainty $setup_margin -setup -from [get_clocks RXCLK_GEN2] -to [get_clocks RXCLK_GEN2]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks RXCLK_2X_GEN1] -to [get_clocks RXCLK_2X_GEN1]
set_clock_uncertainty $setup_margin -setup -from [get_clocks RXCLK_GEN1] -to [get_clocks RXCLK_GEN1]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks RXCLK_2X_USB30] -to [get_clocks RXCLK_2X_USB30]
set_clock_uncertainty $setup_margin -setup -from [get_clocks RXCLK_USB30] -to [get_clocks RXCLK_USB30]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks RXCLK_2X_10GKR] -to [get_clocks RXCLK_2X_10GKR]
set_clock_uncertainty $setup_margin -setup -from [get_clocks RXCLK_U4] -to [get_clocks RXCLK_U4]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks RXCLK_2X_GBE] -to [get_clocks RXCLK_2X_GBE]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks RXCLK_GBE] -to [get_clocks RXCLK_GBE]
set_clock_uncertainty $setup_margin -setup -from [get_clocks RXRDCLK_DISPLAY_OUT] -to [get_clocks RXRDCLK_DISPLAY_OUT]
set_clock_uncertainty $setup_margin -setup -from [get_clocks RXRDCLK_GEN3_OUT] -to [get_clocks RXRDCLK_GEN3_OUT]
set_clock_uncertainty $setup_margin -setup -from [get_clocks RXRDCLK_GEN2_OUT] -to [get_clocks RXRDCLK_GEN2_OUT]
set_clock_uncertainty $setup_margin -setup -from [get_clocks RXRDCLK_GEN1_OUT] -to [get_clocks RXRDCLK_GEN1_OUT]
set_clock_uncertainty $setup_margin -setup -from [get_clocks RXRDCLK_U4_OUT] -to [get_clocks RXRDCLK_U4_OUT]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXTDCLK_DISPLAY] -to [get_clocks  TXTDCLK_DISPLAY]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXTDCLK_GEN3] -to [get_clocks  TXTDCLK_GEN3]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXTDCLK_GEN2] -to [get_clocks  TXTDCLK_GEN2]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXTDCLK_GEN1] -to [get_clocks  TXTDCLK_GEN1]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXTDCLK_USB30] -to [get_clocks  TXTDCLK_USB30]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXTDCLK_U4] -to [get_clocks  TXTDCLK_U4]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks TXTDCLK_GBE] -to [get_clocks  TXTDCLK_GBE]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXCLK_DISPLAY] -to [get_clocks TXCLK_DISPLAY]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXCLK_GEN3] -to [get_clocks TXCLK_GEN3]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXCLK_GEN2] -to [get_clocks TXCLK_GEN2]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXCLK_GEN1] -to [get_clocks TXCLK_GEN1]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXCLK_USB30] -to [get_clocks TXCLK_USB30]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXCLK_U4] -to [get_clocks TXCLK_U4]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks TXCLK_GBE] -to [get_clocks TXCLK_GBE]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks TXCLK_GBE_DIV2] -to [get_clocks TXCLK_GBE_DIV2]
set_clock_uncertainty $setup_margin -setup -from [get_clocks LPBK_*] -to [get_clocks TXCLK_*]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXCLK_*] -to [get_clocks LPBK_*]
set_clock_uncertainty $setup_margin -setup -from [get_clocks SDCLK] -to [get_clocks SDCLK] 
#set_clock_uncertainty $setup_margin -setup -from [get_clocks RXDA_E_LOCKDET_CLK] -to [get_clocks  RXDA_E_LOCKDET_CLK]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks RXDA_E_LOCKDET_CLK] -to [get_clocks  RXDA_IQ_LOCKDET_CLK]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks RXDA_IQ_LOCKDET_CLK] -to [get_clocks RXDA_IQ_LOCKDET_CLK]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks RXDA_IQ_LOCKDET_CLK] -to [get_clocks RXDA_E_LOCKDET_CLK]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL0_CLK_FULLRT_DISPLAY_IN] -to [get_clocks PLL0_CLK_FULLRT_DISPLAY_IN]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL1_CLK_FULLRT_DISPLAY_IN] -to [get_clocks PLL1_CLK_FULLRT_DISPLAY_IN]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL0_CLK_FULLRT_IN] -to [get_clocks PLL0_CLK_FULLRT_IN]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL1_CLK_FULLRT_IN] -to [get_clocks PLL1_CLK_FULLRT_IN]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL0CLK_DATART_GEN2] -to [get_clocks PLL0CLK_DATART_GEN2]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL0CLK_DATART_GEN1] -to [get_clocks PLL0CLK_DATART_GEN1]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL0CLK_DATART_DIV8] -to [get_clocks PLL0CLK_DATART_DIV8]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PSMCLK] -to [get_clocks PSMCLK]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks RXRDCLK_GBE_OUT] -to [get_clocks RXRDCLK_GBE_OUT]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks CDBCLK_OUT] -to [get_clocks CDBCLK_IN]

# Account for inter-clock relationships.
set_clock_uncertainty $setup_margin -setup -from [get_clocks *REFCLK*] -to [get_clocks *REFCLK*]
set_clock_uncertainty $setup_margin -setup -from [get_clocks IO_ASYNC] -to [get_clocks IO_ASYNC]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXCLK_*] -to [get_clocks TXCLK_*]
set_clock_uncertainty $setup_margin -setup -from [get_clocks RXCLK_*] -to [get_clocks RXRDCLK_*]
set_clock_uncertainty $setup_margin -setup -from [get_clocks RXRDCLK_*] -to [get_clocks RXCLK_*]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks CDBCLK_IN] -to [get_clocks CDBCLK_OUT]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL0*] -to [get_clocks PLL0*]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL1*] -to [get_clocks PLL1*]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXCLK_*] -to [get_clocks TXTDCLK_*]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXTDCLK_*] -to [get_clocks TXCLK_*]
set_clock_uncertainty $setup_margin -setup -from [get_clocks LPBK_NE_*] -to [get_clocks TXTDCLK_*]
set_clock_uncertainty $setup_margin -setup -from [get_clocks TXTDCLK_*] -to [get_clocks LPBK_NE_*]

 
# Reduce uncertainty for MTBF flops
#set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_genblk1_u_data_sync_synth_*_2/CP }]
#set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_genblk1_u_data_sync_synth_*_3/CP }]
#set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_genblk1_u_data_sync_synth_*_4/CP }]
set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *u_dont_touch_data_sync*/CP }]

#set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_u_reset_sync_synth_*_2/CP }]
#set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_u_reset_sync_synth_*_3/CP }]
#set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_u_reset_sync_synth_*_4/CP }]
set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *u_dont_touch_reset_sync_*/CP }]


#set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_u_lfps_sync_synth_*_2/CP }]
#set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_u_lfps_sync_synth_*_3/CP }]
#set_clock_uncertainty $mtbf_margin -hold [get_pins -hier { *genblk1_u_lfps_sync_synth_*_4/CP }]
# Reduce uncertainty for MTBF flops (except for the one case that is not a real data_sync case).
#set_clock_uncertainty 0.035 -hold [get_pins -hier { *genblk1_genblk1_u_data_sync_synth_*_2/D }]
#set_clock_uncertainty 0.035 -hold [get_pins -hier { *genblk1_genblk1_u_data_sync_synth_*_3/D }]
#set_clock_uncertainty 0.035 -hold [get_pins -hier { *genblk1_genblk1_u_data_sync_synth_*_4/D }]
#set_clock_uncertainty 0.035 -hold [get_pins -hier { *genblk1_u_reset_sync_synth_*_2/D }]
#set_clock_uncertainty 0.035 -hold [get_pins -hier { *genblk1_u_reset_sync_synth_*_3/D }]
#
#set_false_path -hold -to [get_pins -hier { *genblk1_genblk1_u_data_sync_synth_*_2/D }]
#set_false_path -hold -to [get_pins -hier { *genblk1_genblk1_u_data_sync_synth_*_3/D }]
#set_false_path -hold -to [get_pins -hier { *genblk1_genblk1_u_data_sync_synth_*_4/D }]
#set_false_path -hold -to [get_pins -hier { *genblk1_u_reset_sync_synth_*_2/D }]
#set_false_path -hold -to [get_pins -hier { *genblk1_u_reset_sync_synth_*_3/D }]



###############################################################################
# Clock groups
###############################################################################
set_clock_groups -async -name grp_cdb      -group [get_clocks { CDBCLK* vclk_seq }]
set_clock_groups -async -name grp_bscan    -group [get_clocks { *BSCAN_CLOCKDR *BSCAN_UPDATEDR }]
set_clock_groups -async -name grp_bscan_pc -group [get_clocks { *BSCAN_PC }]
set_clock_groups -async -name grp_async    -group [get_clocks { IO_ASYNC }]
#set_clock_groups -async -name grp_lock     -group [get_clocks { *LOCKDET* }]
set_clock_groups -async -name grp_lfps     -group [get_clocks { SDCLK }]
#set_clock_groups -async -name grp_txtd     -group [get_clocks { TXTDCLK* }]
set_clock_groups -async -name grp_psm      -group [get_clocks { PSMCLK }]
set_clock_groups -async -name grp_rate     -group [get_clocks { *FULLRT* *DATART* }]
set_clock_groups -async -name grp_ref      -group [get_clocks { REFCLK* TXDA_RCVDET_CLK }]
set_clock_groups -async -name grp_pll01    -group [get_clocks { PLL0* }] \
                                           -group [get_clocks { PLL1* }]
set_clock_groups -async -name grp_txrx     -group [get_clocks { TXTDCLK* TXCLK_* LPBK_NE_* }] \
                                           -group [get_clocks { RXCLK_* RXRDCLK_* }]
set_clock_groups -async -name grp_2x       -group [get_clocks { RXCLK_DISPLAY RXCLK_GEN3 RXCLK_GEN2 RXCLK_GEN1 RXCLK_USB30  }] 

set_clock_groups -async -name grp_vclk     -group [get_clocks { vclk_comb }]

set_clock_groups -physically_exclusive -name grp_pllclk -group [get_clocks { *PLL0_CLK0* *PLL1_CLK0* }] \
                                                        -group [get_clocks { *PLL0_CLK1* *PLL1_CLK1* }]
set_clock_groups -physically_exclusive -name grp_usb    -group [get_clocks { *PLL0_CLK0* }] \
                                                        -group [get_clocks { *PLL0CLK_DATART_USB30* }]
#set_clock_groups -physically_exclusive -name grp_10gkr  -group [get_clocks { *PLL0_CLK0* }] \
                                                        -group [get_clocks { *PLL0CLK_DATART_10GKR* }]

set str "set_clock_groups -physically_exclusive -name grp_std_pe"
append str " -group \[get_clocks { *_DIV8* }\]"
set str_display " -group \[get_clocks { *DISPLAY* }\]"
set str_gen3 " -group \[get_clocks { *GEN3* PLL*_CLK_FULLRT_IN}\]"
set str_gen2 " -group \[get_clocks { *GEN2* }\]"
set str_gen1 " -group \[get_clocks { *GEN1* }\]"
set str_usb  " -group \[get_clocks { *USB* }\]"
set str_usb4  " -group \[get_clocks { *U4* }\]"


if { $do_display }   { append str $str_display }
if { $do_pcie_gen3 } { append str $str_gen3 }
if { $do_pcie_gen2 } { append str $str_gen2 }
if { $do_pcie_gen1 } { append str $str_gen1 }
if { $do_usb30 }     { append str $str_usb }
if { $do_usb4 }      { append str $str_usb4 }

eval $str

###############################################################################
# Clock latency for clocks from common.
#-early | -late
# Specifies clock arrival time with respect to the early or the late time of the clock signal.
#In setup analysis, launch path is the late path and capture path is the early path.
#In hold analysis, launch path is the early path and the capture path is the late path.
#If neither parameter is specified, the default is both early and late.

###############################################################################
#set_clock_latency 0.45 -source -max [get_ports xcvr_cdb_pclk] -clock [get_clocks CDBCLK_IN]
#set_clock_latency 0.40 -source -min [get_ports xcvr_cdb_pclk] -clock [get_clocks CDBCLK_IN]
#need confirm by Dave

###############################################################################

###############################################################################
# I/O Timing
###############################################################################

# Constant and async signals
set async_inputs        [get_ports {xcvr_lpbk_serial_en                             \
                                    xcvr_lpbk_fe_parallel_en                        \
                                    xcvr_lpbk_ne_parallel_en                        \
                                    xcvr_lpbk_line_en                               \
                                    xcvr_lpbk_isi_gen_en                            \
                                    xcvr_lpbk_recovered_clk_en                      \
                                    tx_rcv_detect_en                                \
                                    tx_deemphasis[*]                                \
                                    tx_vmargin[*]                                   \
                                    tx_low_power_swing_en                           \
                                    tx_differential_invert                          \
                                    rx_termination                                  \
                                    rx_differential_invert                          \
                                    lane_addr[*]                                    \
                                    xcvr_scanin[*]                                  \
                                    xcvr_scanmode                                   \
                                    xcvr_scanen                                     \
                                    xcvr_scanen_cg                                  \
                                    tx_bscan_mode_c                                 \
                                    tx_bscan_acpulse                                \
                                    tx_bscan_ac                                     \
                                    tx_bscan_shiftdr                                \
                                    rx_bscan_ac                                     \
                                    rx_bscan_shiftdr                                \
                                    tx_cmn_mode_en_ext                              \
				    xcvr_bscan_cfg[*]                               \
                                    xcvr_data_width[*]                              \
                                    cmn_atb_en_in                                   \
                                    cmn_atb_sel_in                                  \
                                    cmn_reset_n_in                                  \
                                    xcvr_cdb_preset_n                               \
                                    cmn_reset_sync_n_in                             \
                                    rx_sig_det_en_ext                               \
                                    rx_rescal_code_in[*]                            \
                                    xcvr_standard_mode[*]                           \
                                    xcvr_cdb_pwdata*                                \
                                    xcvr_scanin[*]                                  \
                        }]

#                                    tx_lfps_en                                      \
#                                    tx_get_local_preset_coef                        \
#                                    tx_local_preset_index[*]                        \
#                                    rx_invalid_request                              \
#                                    rx_eq_training                                  \

foreach_in_collection pma_port $async_inputs {
   set port_name [get_object $pma_port]
   set_input_delay 0.0 -max -add -clock [get_clocks { IO_ASYNC }] $port_name
}

set async_outputs       [get_ports {cmn_reset_n_out                                 \
                                    cmn_reset_sync_n_out                            \
                                    rx_signal_detect                                \
                                    rx_pi_val[*]                                    \
                                    rx_eye_plot_pi_val[*]                           \
                                    xcvr_in_obs_tie_high[*]                         \
                                    xcvr_in_obs_tie_low[*]                          \
                                    xcvr_in_ibs_tie_high[*]                         \
                                    xcvr_in_ibs_tie_low[*]                          \
                                    lane_addr_tie_high                              \
                                    lane_addr_tie_low                               \
                        }]

#                                    tx_local_tx_preset_coef[*]                      \
#                                    tx_local_tx_coef_valid                          \
#                                    rx_lfps_detect                                  \

############################################
# Reference clocks
############################################

#set refclk_outputs [get_ports {
#   xcvr_lane_en_ack
#}]

# Source-synchronous signals.
# Set I/O timing to 2/3 clock period.
set ref_value  [expr round(($CLK100_PERIOD * 2.0 / 3.0) * 100) / 100.0]

#foreach_in_collection pma_port $refclk_outputs {
#   set port_name [get_object $pma_port]
#   set_output_delay $ref_value  -max -add -clock [get_clocks { REFCLK_GATED_OUT }] $port_name
#
#}

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

   set psmclk [get_clocks PSMCLK]
   set_input_delay  $psm_value -max -add -clock $psmclk [get_ports xcvr_power_state_req[*]]
   set_output_delay $psm_value -max -add -clock $psmclk [get_ports xcvr_power_state_ack[*]]
   set_output_delay $psm_value -max -add -clock $psmclk [get_ports xcvr_psm_ready]
   set_output_delay $psm_value -max -add -clock $psmclk [get_ports tx_sfifo_enq_reset_n_out]
   set_output_delay $psm_value -max -add -clock $psmclk [get_ports xcvr_psm_state[*]]

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
set display_value  [expr round(($CLK515P625_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set gen3_value  [expr round(($CLK500_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set gen2_value  [expr round(($CLK250_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set gen1_value  [expr round(($CLK125_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set usb30_value [expr round(($CLK625_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set usb4_value  [expr round(($CLK1250_PERIOD * 2.0 / 3.0) * 100) / 100.0]

set txclk_display_indly  [expr $display_value + $txclk_latency]
set txclk_gen3_indly  [expr $gen3_value + $txclk_latency]
set txclk_gen2_indly  [expr $gen2_value + $txclk_latency]
set txclk_gen1_indly  [expr $gen1_value + $txclk_latency]
set txclk_usb30_indly [expr $usb30_value + $txclk_latency]
set txclk_usb4_indly  [expr $usb4_value + $txclk_latency]

   if { $do_display } {
      set txclk [get_clocks TXTDCLK_DISPLAY]
      set_input_delay $txclk_display_indly -max -add -clock $txclk [get_ports tx_td[*]]
      set_input_delay $txclk_display_indly -max -add -clock $txclk [get_ports tx_elec_idle]
      set_input_delay $txclk_display_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_in]
      set_input_delay $txclk_display_indly -max -add -clock $txclk [get_ports tx_bist_hold]
      set_output_delay $txclk_display_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_out]
   }
   if { $do_pcie_gen3 } {
      set txclk [get_clocks TXTDCLK_GEN3]
      set_input_delay $txclk_gen3_indly -max -add -clock $txclk [get_ports tx_td[*]]
      set_input_delay $txclk_gen3_indly -max -add -clock $txclk [get_ports tx_elec_idle]
      set_input_delay $txclk_gen3_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_in]
      set_input_delay $txclk_gen3_indly -max -add -clock $txclk [get_ports tx_bist_hold]
      set_output_delay $txclk_gen3_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_out]
   }
   if { $do_pcie_gen2 } {
      set txclk [get_clocks TXTDCLK_GEN2]
      set_input_delay $txclk_gen2_indly -max -add -clock $txclk [get_ports tx_td[*]]
      set_input_delay $txclk_gen2_indly -max -add -clock $txclk [get_ports tx_elec_idle]
      set_input_delay $txclk_gen2_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_in]
      set_input_delay $txclk_gen2_indly -max -add -clock $txclk [get_ports tx_bist_hold]
      set_output_delay $txclk_gen2_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_out]
   }
   if { $do_pcie_gen1 } {
      set txclk [get_clocks TXTDCLK_GEN1]
      set_input_delay $txclk_gen1_indly -max -add -clock $txclk [get_ports tx_td[*]]
      set_input_delay $txclk_gen1_indly -max -add -clock $txclk [get_ports tx_elec_idle]
      set_input_delay $txclk_gen1_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_in]
      set_input_delay $txclk_gen1_indly -max -add -clock $txclk [get_ports tx_bist_hold]
      set_output_delay $txclk_gen1_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_out]
   }
   if { $do_usb30 } {
      set txclk [get_clocks TXTDCLK_USB30]
      set_input_delay $txclk_usb30_indly -max -add -clock $txclk [get_ports tx_td[*]]
      set_input_delay $txclk_usb30_indly -max -add -clock $txclk [get_ports tx_elec_idle]
      set_input_delay $txclk_usb30_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_in]
      set_input_delay $txclk_usb30_indly -max -add -clock $txclk [get_ports tx_bist_hold]
      set_output_delay $txclk_usb30_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_out]
   }
   if { $do_usb4 } {
      set txclk [get_clocks TXTDCLK_USB30]
      set_input_delay $txclk_usb4_indly -max -add -clock $txclk [get_ports tx_td[*]]
      set_input_delay $txclk_usb4_indly -max -add -clock $txclk [get_ports tx_elec_idle]
      set_input_delay $txclk_usb4_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_in]
      set_input_delay $txclk_usb4_indly -max -add -clock $txclk [get_ports tx_bist_hold]
      set_output_delay $txclk_usb4_indly -max -add -clock $txclk [get_ports tx_sfifo_enq_reset_n_out]
   }


############################################
# Receiver
############################################

# Source-synchronous signals.
# Set I/O timing to 2/3 clock period.
set display_value  [expr round(($CLK625_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set gen3_value  [expr round(($CLK500_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set gen2_value  [expr round(($CLK250_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set gen1_value  [expr round(($CLK125_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set usb30_value [expr round(($CLK625_PERIOD * 2.0 / 3.0) * 100) / 100.0]

# Set GEN2 and USB 3.0 I/O timing to 1/5 clock period for signals that are not timing critical.
set gen2_loose  [expr round(($CLK250_PERIOD * 1.0 / 5.0) * 100) / 100.0]
set usb30_loose [expr round(($CLK250_PERIOD * 1.0 / 5.0) * 100) / 100.0]
set usb4_loose  [expr round(($CLK250_PERIOD * 1.0 / 5.0) * 100) / 100.0]
# Set GEN3 I/O timing to 0 clock period for signals that are not timing critical.
set gen3_loose  [expr round(($CLK500_PERIOD * 0.0 / 5.0) * 100) / 100.0]
set display_loose  [expr round(($CLK625_PERIOD * 0.0 / 5.0) * 100) / 100.0]

#
# Ports rx_sampler_latch_cal_diag_ln_*[*] are not timing critical.
# Ports rx_eq_eval_cnt_rst_ln_* are multicyle paths for PCIe, asynchronous otherwise.
#

   if { $do_display } {
      set rxclk [get_clocks RXRDCLK_DISPLAY_OUT]
      set_output_delay $display_value -max -add -clock $rxclk [get_ports rx_bist_err_toggle]
      set_output_delay $display_value -max -add -clock $rxclk [get_ports rx_bist_status]
      set_output_delay $display_value -max -add -clock $rxclk [get_ports rx_bist_sync]
      set_output_delay $display_value -max -add -clock $rxclk [get_ports rx_rd]
      set_output_delay $gen3_loose -max -add -clock $rxclk [get_ports rx_sampler_latch_cal_diag[*]]
#      set_input_delay  $display_value -max -add -clock $rxclk [get_ports rx_eq_eval_cnt_rst]
   }

   if { $do_pcie_gen3 } {
      set rxclk [get_clocks RXRDCLK_GEN3_OUT]
      set_output_delay $gen3_value -max -add -clock $rxclk [get_ports rx_bist_err_toggle]
      set_output_delay $gen3_value -max -add -clock $rxclk [get_ports rx_bist_status]
      set_output_delay $gen3_value -max -add -clock $rxclk [get_ports rx_bist_sync]
      set_output_delay $gen3_value -max -add -clock $rxclk [get_ports rx_rd]
      set_output_delay $gen3_loose -max -add -clock $rxclk [get_ports rx_sampler_latch_cal_diag[*]]
#      set_input_delay  $gen3_value -max -add -clock $rxclk [get_ports rx_eq_eval_cnt_rst]
   }

   if { $do_pcie_gen2 } {
      set rxclk [get_clocks RXRDCLK_GEN2_OUT]
      set_output_delay $gen2_value -max -add -clock $rxclk [get_ports rx_bist_err_toggle]
      set_output_delay $gen2_value -max -add -clock $rxclk [get_ports rx_bist_status]
      set_output_delay $gen2_value -max -add -clock $rxclk [get_ports rx_bist_sync]
      set_output_delay $gen2_value -max -add -clock $rxclk [get_ports rx_rd]
      set_output_delay $gen2_loose -max -add -clock $rxclk [get_ports rx_sampler_latch_cal_diag[*]]
#      set_input_delay  $gen2_value -max -add -clock $rxclk [get_ports rx_eq_eval_cnt_rst]
   }
   if { $do_pcie_gen1 } {
      set rxclk [get_clocks RXRDCLK_GEN1_OUT]
      set_output_delay $gen1_value -max -add -clock $rxclk [get_ports rx_bist_err_toggle]
      set_output_delay $gen1_value -max -add -clock $rxclk [get_ports rx_bist_status]
      set_output_delay $gen1_value -max -add -clock $rxclk [get_ports rx_bist_sync]
      set_output_delay $gen1_value -max -add -clock $rxclk [get_ports rx_rd]
      set_output_delay $gen1_value -max -add -clock $rxclk [get_ports rx_sampler_latch_cal_diag[*]]
#      set_input_delay  $gen1_value -max -add -clock $rxclk [get_ports rx_eq_eval_cnt_rst]
   }
   if { $do_usb30 } {
      set rxclk [get_clocks RXRDCLK_USB30_OUT]
      set_output_delay $usb30_value -max -add -clock $rxclk [get_ports rx_bist_err_toggle]
      set_output_delay $usb30_value -max -add -clock $rxclk [get_ports rx_bist_status]
      set_output_delay $usb30_value -max -add -clock $rxclk [get_ports rx_bist_sync]
      set_output_delay $usb30_value -max -add -clock $rxclk [get_ports rx_rd]
      set_output_delay $usb30_loose -max -add -clock $rxclk [get_ports rx_sampler_latch_cal_diag[*]]
   }
   if { $do_usb4 } {
      set rxclk [get_clocks RXRDCLK_USB30_OUT]
      set_output_delay $usb4_value -max -add -clock $rxclk [get_ports rx_bist_err_toggle]
      set_output_delay $usb4_value -max -add -clock $rxclk [get_ports rx_bist_status]
      set_output_delay $usb4_value -max -add -clock $rxclk [get_ports rx_bist_sync]
      set_output_delay $usb4_value -max -add -clock $rxclk [get_ports rx_rd]
      set_output_delay $usb4_loose -max -add -clock $rxclk [get_ports rx_sampler_latch_cal_diag[*]]
   }


############################################
# CDB
############################################

# Need to adjust I/O timing for WC clock latency.
if { $timeMode == "prop" } {
   set pclk_latency  0.500
} else {
   set pclk_latency  0.0
}

# Set I/O timing to 2/3 clock period.
set cdb_value [expr round(($CLK525_PERIOD * 2.0 / 3.0) * 100) / 100.0]
set pclk_indly  [expr $cdb_value + $pclk_latency]
set pclk_outdly [expr $cdb_value - $pclk_latency]

#set_input_delay  0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_rx_pready_in }]
#set_input_delay  0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_tx_pready_in }]
#set_input_delay  0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_txrx_prdata_in[*] }]
#set_input_delay  0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_txrx_pwdata_in[*] }]
#set_input_delay  0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_txrx_plinkmultiwrite_in }]
#set_input_delay  0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_txrx_pwrite_in }]
#set_input_delay  0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_txrx_paddr_in[*] }]
#set_input_delay  0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_rx_penable_in }]
#set_input_delay  0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_tx_penable_in }]
#set_input_delay  0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_rx_psel_in }]
#set_input_delay  0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_tx_psel_in }]

set_input_delay  $pclk_indly -max -add -clock [get_clocks {CDBCLK_IN  }] [get_ports {  xcvr_cdb_preset_n }]
set_input_delay  $pclk_indly -max -add -clock [get_clocks {CDBCLK_IN  }] [get_ports {  xcvr_cdb_penable  }]
set_input_delay  $pclk_indly -max -add -clock [get_clocks {CDBCLK_IN  }] [get_ports {  xcvr_cdb_psel_tx  }]
set_input_delay  $pclk_indly -max -add -clock [get_clocks {CDBCLK_IN  }] [get_ports {  xcvr_cdb_psel_rx  }]
set_input_delay  $pclk_indly -max -add -clock [get_clocks {CDBCLK_IN  }] [get_ports {  xcvr_cdb_paddr[*] }]
set_input_delay  $pclk_indly -max -add -clock [get_clocks {CDBCLK_IN  }] [get_ports {  xcvr_cdb_pwrite   }]
set_input_delay  $pclk_indly -max -add -clock [get_clocks {CDBCLK_IN  }] [get_ports {  xcvr_cdb_pwdata[*]}]

#set_output_delay 0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_rx_pready_out }]
#set_output_delay 0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_tx_pready_out }]
#set_output_delay 0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_txrx_prdata_out[*] }]
#set_output_delay 0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_txrx_pwdata_out[*] }]
#set_output_delay 0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_txrx_plinkmultiwrite_out }]
#set_output_delay 0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_txrx_pwrite_out }]
#set_output_delay 0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_txrx_paddr_out[*] }]
#set_output_delay 0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_rx_penable_out }]
#set_output_delay 0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_tx_penable_out }]
#set_output_delay 0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_rx_psel_out }]
#set_output_delay 0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cdb_tx_psel_out }]
#set_output_delay 0 -max -add -clock [get_clocks { vclk_comb }] [get_ports { cmn_cdb_preset_n_out }]


#set_output_delay $pclk_outdly -max -add -clock [get_clocks { vclk_seq }] [get_ports { cdb_rx_pready_out }]
#set_output_delay $pclk_outdly -max -add -clock [get_clocks { vclk_seq }] [get_ports { cdb_tx_pready_out }]
#set_output_delay $pclk_outdly -max -add -clock [get_clocks { vclk_seq }] [get_ports { cdb_txrx_prdata_out[*] }]
#set_output_delay $pclk_outdly -max -add -clock [get_clocks { vclk_seq }] [get_ports { cdb_txrx_pwdata_out[*] }]
#set_output_delay $pclk_outdly -max -add -clock [get_clocks { vclk_seq }] [get_ports { cdb_txrx_plinkmultiwrite_out }]
#set_output_delay $pclk_outdly -max -add -clock [get_clocks { vclk_seq }] [get_ports { cdb_txrx_pwrite_out }]
#set_output_delay $pclk_outdly -max -add -clock [get_clocks { vclk_seq }] [get_ports { cdb_txrx_paddr_out[*] }]
#set_output_delay $pclk_outdly -max -add -clock [get_clocks { vclk_seq }] [get_ports { cdb_rx_penable_out }]
#set_output_delay $pclk_outdly -max -add -clock [get_clocks { vclk_seq }] [get_ports { cdb_tx_penable_out }]
#set_output_delay $pclk_outdly -max -add -clock [get_clocks { vclk_seq }] [get_ports { cdb_rx_psel_out }]
#set_output_delay $pclk_outdly -max -add -clock [get_clocks { vclk_seq }] [get_ports { cdb_tx_psel_out }]
#set_output_delay $pclk_outdly -max -add -clock [get_clocks { vclk_seq }] [get_ports { cmn_cdb_preset_n_out }]

set_output_delay $pclk_outdly -max -add -clock [get_clocks { CDBCLK_IN }] [get_ports { xcvr_cdb_pready }]
set_output_delay $pclk_outdly -max -add -clock [get_clocks { CDBCLK_IN }] [get_ports { xcvr_cdb_prdata* }]


############################################
# Boundary scan
############################################

# Need to adjust I/O timing for WC clock latency
if { $timeMode == "prop" } {
   set bscan_latency  0.035
} else {
   set bscan_latency  0.0
}

# Set I/O timing to 2/3 clock period.
set bscan_value  [expr round(($BSCAN_PERIOD * 1.0 / 3.0) * 100) / 100.0]
set bscan_indly  [expr $bscan_value + $bscan_latency]
set bscan_outdly [expr $bscan_value - $bscan_latency]

   set txbscanclk [get_clocks TX_BSCAN_CLOCKDR]
   set_input_delay  $bscan_indly  -max -add -clock $txbscanclk [get_ports tx_bscan_tdi]
   set_output_delay $bscan_outdly -max -add -clock $txbscanclk [get_ports tx_bscan_tdo]
   set rxbscanclk [get_clocks RX_BSCAN_CLOCKDR]
   set_input_delay  $bscan_indly  -max -add -clock $rxbscanclk [get_ports rx_bscan_tdi]
   set_output_delay $bscan_outdly -max -add -clock $rxbscanclk [get_ports rx_bscan_tdo]

#############################################
## misc
#############################################
## Constrain the power isolation enable to be well less than a clock cycle.
##set_max_delay 3.5 -through [get_pins { u_pma_rev/u_xcvr_*/u_pwr_isl_ctrl_sm_xctrl/pwr_isl_ctrl_current_state_reg[5]/CK }]
#set retn_pin_collection [get_pins -of [get_cells -hier -filter { ref_lib_cell_name == GPSDRFFNSRPQ_X1N_A9TLTS_C20 }] -filter { name == RETN }]
#set_max_delay 3.5 -to $retn_pin_collection
#set retn_pin_collection_2 [get_pins -of [get_cells -hier -filter { ref_lib_cell_name == GPSDRFFSRPQ_X1N_A9TLTS_C20 }] -filter { name == RETN }]
#set_max_delay 3.5 -to $retn_pin_collection_2

################################################################################
## Timing Exceptions
################################################################################
set_false_path -from [get_clocks IO_ASYNC]
set_false_path -to   [get_clocks IO_ASYNC]
# There is an XOR in the RXCLK path coming out of the xcvr_ana. Therefore, the 
# RXRDCLK_*_OUT needs to match up to the same edge. Otherwiee, half-cycle paths
# show up. 
set_false_path -rise_from [get_clocks RXCLK*] -fall_to [get_clocks RXRDCLK*]
set_false_path -fall_from [get_clocks RXCLK*] -rise_to [get_clocks RXRDCLK*]
set_false_path -rise_from [get_clocks RXRDCLK_*] -fall_to [get_clocks RXCLK_*]
set_false_path -fall_from [get_clocks RXRDCLK_*] -rise_to [get_clocks RXCLK_*]

set_false_path -from vclk_seq -to vclk_seq

#Synthesis
if { $load_syn_sdc && !$load_post_map_syn_sdc } {
} else {

# JMY 20150729 Attempt to use the MTBF hold uncertainty for the sync_synth FFs
#    set_false_path -hold -to [get_pins -hier *genblk1_genblk1_u_data_sync_synth_*_2/D]
#    set_false_path -hold -to [get_pins -hier *genblk1_genblk1_u_data_sync_synth_*_3/D]
#    set_false_path -hold -to [get_pins -hier *genblk1_genblk1_u_data_sync_synth_*_4/D]
#    set_false_path -hold -to [get_pins -hier *genblk1_u_reset_sync_synth_*_2/D]
#    set_false_path -hold -to [get_pins -hier *genblk1_u_reset_sync_synth_*_3/D]
#    set_false_path -hold -to [get_pins -hier *genblk1_u_reset_sync_synth_*_4/D]

    # Temporary until confirmation.
    set_false_path -to [get_pins -hier *u_reset_sync_synth_*_*/CD]

    set_false_path -from [all_clocks] \
                   -to   [get_pins -hier */SI]
#    set_false_path -from [get_clocks LPBK_NE_*] \
#                   -through [get_pins u_rx_ctrl/u_eye_surf_ctrl_apb/u_eye_surf/u_eye_surf_sm/st_current_state_reg[*]/Q]
#    set_false_path -from [get_clocks LPBK_NE_*] \
#                   -through [get_pins u_rx_ctrl/u_eye_surf_ctrl_apb/u_eye_surf/u_eye_surf_pi_ctrl_int/*st_current_state_reg[*]/Q*]
 
  # Set false paths to analog scanin pins and from analog scanout pins.
    set_false_path -to      [get_pins { u_xcvr_ana/*scanin }]
    set_false_path -to      [get_pins { u_xcvr_ana/*scanin[*] }]
    set_false_path -through [get_pins { u_xcvr_ana/*scanout }]
    set_false_path -through [get_pins { u_xcvr_ana/*scanout[*] }]


# Set false paths to first flop in reset_sync logic.
# set_false_path -to [get_pins -hier { *genblk1_u_reset_sync_synth_*_1/D }]
set_false_path -to [get_pins -hier { *u_dont_touch_reset_sync_first/D }]

# Set false paths to first flop in data_sync logic.
# set_false_path -to [get_pins -hier { *genblk1_u_data_sync_synth_*_1/D }]
 set_false_path -to [get_pins -hier { *u_dont_touch_data_sync_first/D }]


# Loren confirmed that both reset_sync flops get asynchronous resets.
# set_false_path -to [get_pins -hier *genblk1_u_reset_sync_synth_*_1/CD]
set_false_path -to [get_pins -hier *u_dont_touch_reset_sync_first/CD]

# False path all paths to SI pins from functional and scan capture clocks.
set si_pin_collection [get_pins -of [all_registers] -filter { @name == SI }]
set_false_path -from [all_clocks] -to $si_pin_collection

## Set false paths from clock divider registers to lockup latches, which go to SI pins.
#set_false_path \
#   -through [get_pins { u_pma_rev/u_xcvr_*/u_xcvr_clkrst/u_clock_div_rx_des_clk/clock_div_reg/Q }] \
#   -to      [get_pins { u_pma_rev/u_xcvr_*/u_xcvr_clkrst/u_clock_div_rx_des_clk/DFT_lockup_RC_i_*/D }]
#
#set_false_path \
#   -through [get_pins { u_pma_rev/u_cmn/u_cmn_ctrl/u_cmn_ctrl_clkrst/u_clock_div_prog_psm_clk/clock_div_reg/Q }] \
#   -to      [get_pins { u_pma_rev/u_cmn/u_cmn_ctrl/u_cmn_ctrl_clkrst/u_clock_div_prog_psm_clk/DFT_lockup_RC_i_*/D }]

# Set false paths to/from all asynchronous/constant ports to suppress arcs when
# generating Liberty models.
}


#commenting as taken care by CPD, data:300, clock:150, 30/09/20
################################################################################
## Transitions and Transition Limits
################################################################################
#if {$timeMode == "ideal" } {
#    set_max_transition 0.150 [current_design]
#    set_max_transition 0.150 [all_inputs]
#    set_max_transition 0.150 [all_outputs]
#} else {
#    set_max_transition $max_trans [current_design]
#    set_max_transition $max_trans [all_inputs]
#    set_max_transition $max_trans [all_outputs]
#}
#
#set_clock_transition $max_clk_trans [all_clocks]

###############################################################################
# Input Driving cells
###############################################################################
set_driving_cell -lib_cell $DRIVING_CELL -pin $DRIVING_PIN $digital_input_port_collection

###############################################################################
#Output Port Load
###############################################################################
set_load 0.020 $digital_output_port_collection
#set_load 0.020 [get_ports [all_outputs]]
#set_load 1.200 [get_ports { tx_m tx_p }]

#add heavy load to these since these will drive a long distance away into the cmn
#set_load 0.100 [get_ports tx_beacon_en_to_cmn_in]
#set_load 0.100 [get_ports tx_beacon_en_to_cmn_out]


#######################################
# Dont_Touch Nets
#######################################
# Power & Ground Connections
set_dont_touch [get_nets $power_ground_port_list] 
# Cmn_ana connections that must remain pure from/to their respective pma_cmn I/O ports.
set_dont_touch [get_nets $analog_port_list]

###############################################################################
# Ideal Networks
###############################################################################


##if { $load_syn_sdc && !$load_post_map_syn_sdc } {
##} else {
##   # NOTE : doing following to fix recovery violations in the prects db where we see large
##   # fanout on the reset nets, which results in big delays on muxes and reset pins.
##        #set_ideal_network [get_pins  u_pwr_isl_ctrl_sm_xfunc/RC_i_3205/Z]
##   if {$timeMode == "ideal"} {
##        set_ideal_network [get_ports cmn_cdb_preset_n_in]
##        set_ideal_network [get_ports cmn_reset_n_in]
##        set_ideal_network [get_pins u_xcvr_clkrst/u_reset_sync_cdb_preset/u_scan_mux/u_scan_mux_synth/u_mux/Z]
##    }
##}

# The clock measurement logic in both the cmn and xcvr will only have one clock active at a time.
# Therefore, hold violations between two different clocks through this logic are not real. 
# Special exceptions are not needed in the cmn since clock_group statements handle it but the
# xcvr needs a couple special-case false paths.
if { $load_syn_sdc } {
} else {
    foreach clock_pair [list "TXCLK_*,LPBK_NE_*" "TXCLK_*,TXTDCLK_*" "TXTDCLK_*,LPBK_NE_*" ] {
        set clockA [lindex [split $clock_pair ,] 0]
        set clockB [lindex [split $clock_pair ,] 1]

        for { set loop_cnt 0 } { $loop_cnt <= 1 } { incr loop_cnt } {
            #set_false_path  -hold \
            #                -from    [get_clocks ${clockA}] \
            #                -to      [get_clocks ${clockB}] \
            #                -through [get_pins u_rx_ctrl/u_cmn_clk_freq_msmt_v1_top/u_clk_freq_msmt_v1/DFT_lockup_RC_i_1284/D]
            set_false_path  -hold \
                            -from    [get_clocks ${clockA}] \
                            -to      [get_clocks ${clockB}] \
                            -through [get_pins u_rx_ctrl/u_cmn_clk_freq_msmt_v1_top/u_clk_freq_msmt_v1/u_data_sync_test_cnt_ack_test_clk/u_data_sync_synth/DFT_lockup_latch_neg_edge/D]
            set_false_path  -hold \
                            -from    [get_clocks ${clockA}] \
                            -to      [get_clocks ${clockB}] \
                            -through [get_pins u_rx_ctrl/u_cmn_clk_freq_msmt_v1_top/u_clk_freq_msmt_v1/u_data_sync_enable_test_cnt/u_data_sync_synth/u_dont_touch_data_sync_first*/D]
            set_false_path  -hold \
                            -from    [get_clocks ${clockA}] \
                            -to      [get_clocks ${clockB}] \
                            -through [get_pins u_rx_ctrl/u_cmn_clk_freq_msmt_v1_top/u_clk_freq_msmt_v1/u_data_sync_test_cnt_ack_test_clk/u_data_sync_synth/u_dont_touch_data_sync_first*/D]
            set_false_path  -hold \
                            -from    [get_clocks ${clockA}] \
                            -to      [get_clocks ${clockB}] \
                            -through [get_pins u_xcvr_clkrst/u_clk_gating_cell_xcvr_cmsmt_test_clk/genblk1_u_data_sync_en_sync/u_data_sync_synth/u_dont_touch_data_sync_first*/D]

            # Now, swap clock directions for next loop iteration.
            set clockAHold $clockA
            set clockA $clockB
            set clockB $clockAHold
        }
    }
}

# JMY Prevent timing from NRESTORE->Q pins on RSDF FFs, logic prevents this from being a critical path
#     as downstream clocks are off
# Updated syntax to make H240/H300 agnostic per Joey's modifications
#add disable timing for retention Cells
if { [info exists load_syn_sdc] && $load_syn_sdc} {
} else {
set_disable_timing [get_lib_cells head.libCells.name RSDFRPQHDCWD*BWP*H*P*] -from NRESTORE -to Q
set_disable_timing [get_lib_cells head.libCells.name RSDFSNQHDCWD*BWP*H*P*] -from NRESTORE -to Q
set_disable_timing [get_lib_cells head.libCells.name RSDFSRPQHDCWD*BWP*H*P*] -from NRESTORE -to Q

set_disable_timing [get_lib_cells head.libCells.name RSDFRPQHDCWD*BWP*H*P*] -from NRESTORE -to CD
set_disable_timing [get_lib_cells head.libCells.name RSDFSNQHDCWD*BWP*H*P*] -from NRESTORE -to CD
set_disable_timing [get_lib_cells head.libCells.name RSDFSRPQHDCWD*BWP*H*P*] -from NRESTORE -to CD

set_disable_timing [get_lib_cells head.libCells.name RSDFRPQHDCWD*BWP*H*P*] -from NRESTORE -to SDN
set_disable_timing [get_lib_cells head.libCells.name RSDFSNQHDCWD*BWP*H*P*] -from NRESTORE -to SDN
set_disable_timing [get_lib_cells head.libCells.name RSDFSRPQHDCWD*BWP*H*P*] -from NRESTORE -to SDN

}
# JMY 20170712 Prevent timing from NRESTORE->Q pins on RSDF FFs, logic prevents this from being a critical path
#set_disable_timing RSDFSNQHDCWD1BWP210H6P51CNODSVT -from NRESTORE -to Q
#set_disable_timing RSDFRPQHDCWD1BWP210H6P51CNODSVT -from NRESTORE -to Q
#set_disable_timing RSDFRPQHDCWD2BWP210H6P51CNODSVT -from NRESTORE -to Q
#set_disable_timing RSDFSNQHDCWD2BWP210H6P51CNODSVT -from NRESTORE -to Q
#set_disable_timing RSDFSNQHDCWD4BWP210H6P51CNODSVT -from NRESTORE -to Q
#set_disable_timing RSDFRPQHDCWD4BWP210H6P51CNODSVT -from NRESTORE -to Q

#set_disable_timing RSDFSNQHDCWD1BWP210H6P51CNODLVT -from NRESTORE -to Q
#set_disable_timing RSDFRPQHDCWD1BWP210H6P51CNODLVT -from NRESTORE -to Q
#set_disable_timing RSDFRPQHDCWD2BWP210H6P51CNODLVT -from NRESTORE -to Q
#set_disable_timing RSDFSNQHDCWD2BWP210H6P51CNODLVT -from NRESTORE -to Q
#set_disable_timing RSDFSNQHDCWD4BWP210H6P51CNODLVT -from NRESTORE -to Q
#set_disable_timing RSDFRPQHDCWD4BWP210H6P51CNODLVT -from NRESTORE -to Q

# JMY 20150729 Modify to address similar to sd0800_pma.func.tcl constraints from Randy.
#    set_false_path  -hold \
#                    -from    [get_clocks TXCLK_*] \
#                    -to      [get_clocks LPBK_NE_*] \
#                    -through [get_pins u_rx_ctrl/u_cmn_clk_freq_msmt_v1_top/u_clk_freq_msmt_v1/DFT_lockup_RC_i_1284/D]
#    set_false_path  -hold \
#                    -from    [get_clocks TXCLK_*] \
#                    -to      [get_clocks LPBK_NE_*] \
#                    -through [get_pins u_rx_ctrl/u_cmn_clk_freq_msmt_v1_top/u_clk_freq_msmt_v1/u_data_sync_test_cnt_ack_test_clk/u_data_sync_synth/DFT_lockup_RC_i_1/D]
#    set_false_path  -hold \
#                    -from    [get_clocks LPBK_NE_*] \
#                    -to      [get_clocks TXCLK_*] \
#                    -through [get_pins u_rx_ctrl/u_cmn_clk_freq_msmt_v1_top/u_clk_freq_msmt_v1/DFT_lockup_RC_i_1284/D]
#    set_false_path  -hold \
#                    -from    [get_clocks LPBK_NE_*] \
#                    -to      [get_clocks TXCLK_*] \
#                    -through [get_pins u_rx_ctrl/u_cmn_clk_freq_msmt_v1_top/u_clk_freq_msmt_v1/u_data_sync_test_cnt_ack_test_clk/u_data_sync_synth/DFT_lockup_RC_i_1/D]
#    set_false_path  -hold \
#                    -from    [get_clocks TXTDCLK_*] \
#                    -to      [get_clocks LPBK_NE_*] \
#                    -through [get_pins u_rx_ctrl/u_cmn_clk_freq_msmt_v1_top/u_clk_freq_msmt_v1/DFT_lockup_RC_i_1284/D]
#    set_false_path  -hold \
#                    -from    [get_clocks TXTDCLK_*] \
#                    -to      [get_clocks LPBK_NE_*] \
#                    -through [get_pins u_rx_ctrl/u_cmn_clk_freq_msmt_v1_top/u_clk_freq_msmt_v1/u_data_sync_test_cnt_ack_test_clk/u_data_sync_synth/DFT_lockup_RC_i_1/D]
#    set_false_path  -hold \
#                    -from    [get_clocks RXDA_E_LOCKDET_CLK] \
#                    -to      [get_clocks RXDA_IQ_LOCKDET_CLK] \
#                    -through [get_pins u_rx_ctrl/u_cmn_clk_freq_msmt_v1_top/u_clk_freq_msmt_v1/DFT_lockup_RC_i_1284/D]
#    set_false_path  -hold \
#                    -from    [get_clocks RXDA_E_LOCKDET_CLK] \
#                    -to      [get_clocks RXDA_IQ_LOCKDET_CLK] \
#                    -through [get_pins u_rx_ctrl/u_cmn_clk_freq_msmt_v1_top/u_clk_freq_msmt_v1/u_data_sync_test_cnt_ack_test_clk/u_data_sync_synth/DFT_lockup_RC_i_1/D]
#    set_false_path  -hold \
#                    -from    [get_clocks RXDA_IQ_LOCKDET_CLK] \
#                    -to      [get_clocks RXDA_E_LOCKDET_CLK] \
#                    -through [get_pins u_rx_ctrl/u_cmn_clk_freq_msmt_v1_top/u_clk_freq_msmt_v1/DFT_lockup_RC_i_1284/D]
#    set_false_path  -hold \
#                    -from    [get_clocks RXDA_IQ_LOCKDET_CLK] \
#                    -to      [get_clocks RXDA_E_LOCKDET_CLK] \
#                    -through [get_pins u_rx_ctrl/u_cmn_clk_freq_msmt_v1_top/u_clk_freq_msmt_v1/u_data_sync_test_cnt_ack_test_clk/u_data_sync_synth/DFT_lockup_RC_i_1/D]
#    set_false_path  -hold \
#                    -from    [get_clocks TXCLK_*] \
#                    -to      [get_clocks TXTDCLK_*] \
#                    -through [get_pins u_rx_ctrl/u_cmn_clk_freq_msmt_v1_top/u_clk_freq_msmt_v1/DFT_lockup_RC_i_1284/D]
#    set_false_path  -hold \
#                    -from    [get_clocks TXCLK_*] \
#                    -to      [get_clocks TXTDCLK_*] \
#                    -through [get_pins u_rx_ctrl/u_cmn_clk_freq_msmt_v1_top/u_clk_freq_msmt_v1/u_data_sync_test_cnt_ack_test_clk/u_data_sync_synth/DFT_lockup_RC_i_1/D]
#    set_false_path  -hold \
#                    -from    [get_clocks TXTDCLK_*] \
#                    -to      [get_clocks TXCLK_*] \
#                    -through [get_pins u_rx_ctrl/u_cmn_clk_freq_msmt_v1_top/u_clk_freq_msmt_v1/DFT_lockup_RC_i_1284/D]
#    set_false_path  -hold \
#                    -from    [get_clocks TXTDCLK_*] \
#                    -to      [get_clocks TXCLK_*] \
#                    -through [get_pins u_rx_ctrl/u_cmn_clk_freq_msmt_v1_top/u_clk_freq_msmt_v1/u_data_sync_test_cnt_ack_test_clk/u_data_sync_synth/DFT_lockup_RC_i_1/D]


###############################################################################
# Clock Latency REsePropagation
###############################################################################
if { !$load_syn_sdc && $timeMode == "prop" } {
    reset_clock_tree_latency [all_clocks]
    set_propagated_clock     [all_clocks]
}

###############################################################################
# Power Analysis
###############################################################################
if { [info exists do_power_analysis] && $do_power_analysis } {
   set_case_analysis 0 [get_pins -hier */SAVE]
   set_case_analysis 1 [get_pins -hier */NSLEEPIN]
}
