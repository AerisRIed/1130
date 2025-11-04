###############################################################################
# These confidential and proprietary static timing constraints for a Hardware
# component may be used only as authorized by a licensing agreement from
# Cadence Design Systems, Inc. In the event of publication, the following
# notice is applicable:
#
#       (C) COPYRIGHT 2015 Cadence Design Systems, Inc.
#           ALL RIGHTS RESERVED
#
# The entire notice above must be reproduced on all authorized copies of
# this code.
###############################################################################
# Filename    : cmn.func.tcl
# Author(s)   : Dave Masters and Jack Yarolin
# Abstract    : Functional timing constraints for the Whistler CMN.
# Last Commit:
#     $Rev: 128706 $
#     $Date: 2022-11-01 04:04:14 +0800 (Tue, 01 Nov 2022) $
#     $Author: dominicl $
###############################################################################
# Change Log: Request via SVN query.
###############################################################################

if { [info exists load_syn_sdc] && $load_syn_sdc} {
    #source $DUT_PATH/constraints/cmn.preamble.sdc
    source $DUT_PATH/design/constraints/PMA/cmn.preamble.sdc
} else {
    source [file dirname [info script]]/cmn.preamble.sdc
}

current_design cmn


###############################################################################
# Specific Mode/Case Analysis
###############################################################################
set_case_analysis 0 [get_ports cmn_scanmode]
set_case_analysis 0 [get_ports cmn_scanen]
set_case_analysis 0 [get_ports cmn_scanen_cg]
set_case_analysis 0 [get_ports cmn_scan_pll_ats]

###############################################################################
# Clock Definitions
###############################################################################

###########################################################
# Reference Clocks
###########################################################
# The PLL reference clock coming from the SOC (cmn_ref_clk_int) go directly 
#to the analog so are untimed from a digital STA perspective. 
#Clocks are defined for them so the clock
# attribute will be set. 
# Implement REFCLK frequencies to 156.25MHz, targeting 200MHz for stuckat
create_clock \
    -name           REFCLK0_FROM_SOC \
    -period         $CLK156P25_PERIOD \
    -waveform       $CLK156P25_WAVEFORM \
    [get_ports cmn_ref_clk0_int]

create_clock \
    -name           REFCLK1_FROM_SOC \
    -period         $CLK156P25_PERIOD \
    -waveform       $CLK156P25_WAVEFORM \
    [get_ports cmn_ref_clk1_int]

# Output from analog. The max frequency is 100 MHz. The clock can be divided by
# 1, 2, 4 or 8 although 2 and 4 are reserved cases. The macro is timed at the
# divide-by-1 frequency of 100 MHz.
#create_clock \
#    -name           REFCLK \
#    -period         $CLK156P25_PERIOD \
#    -waveform       $CLK156P25_WAVEFORM \
#    [get_pins u_cmn_ana/cmnda_ref_clk]
#
## Output clock pins on PMA for reference clocks.
#create_generated_clock \
#    -name           REFCLK_OUT \
#    -divide_by      1 \
#    -master_clock   [get_clocks REFCLK] \
#    -source         [get_pins u_cmn_ana/cmnda_ref_clk] \
#    -add \
#    [get_ports cmn_ref_clk]
#
#create_generated_clock \
#    -name           REFCLK_GATED_OUT \
#    -divide_by      1 \
#    -master_clock   [get_clocks REFCLK] \
#    -source         [get_pins u_cmn_ana/cmnda_ref_clk] \
#    -add \
#    [get_ports cmn_ref_clk_gated]

create_generated_clock \
    -name           REFCLK0_OUT \
    -divide_by      1 \
    -master_clock   [get_clocks REFCLK0_FROM_SOC] \
    -source         [get_ports cmn_ref_clk0_int] \
    -add \
    [get_pins u_cmn_clkrst/u_clock_mux_ref_clk/clk_out]


create_generated_clock \
    -name           REFCLK1_OUT \
    -divide_by      1 \
    -master_clock   [get_clocks REFCLK1_FROM_SOC] \
    -source         [get_ports cmn_ref_clk1_int] \
    -add \
    [get_pins u_cmn_clkrst/u_clock_mux_ref_clk/clk_out]



#create_generated_clock \
#    -name           REFCLK_OUT \
#    -divide_by      1 \
#    -master_clock   [get_clocks REFCLK] \
#    -source         [get_pins u_cmn_clkrst/u_clock_mux_ref_clk/clk_out] \
#    -add \
#    [get_ports cmn_ref_clk]

create_generated_clock \
    -name           REFCLK_OUT_0 \
    -divide_by      1 \
    -master_clock   [get_clocks REFCLK0_OUT] \
    -source         [get_pins u_cmn_clkrst/u_clock_mux_ref_clk/clk_out] \
    -add \
    [get_ports cmn_ref_clk]

create_generated_clock \
    -name           REFCLK_OUT_1 \
    -divide_by      1 \
    -master_clock   [get_clocks REFCLK1_OUT] \
    -source         [get_pins u_cmn_clkrst/u_clock_mux_ref_clk/clk_out] \
    -add \
    [get_ports cmn_ref_clk]


#create_generated_clock \
#    -name           REFCLK_GATED_OUT \
#    -divide_by      1 \
#    -master_clock   [get_clocks REFCLK] \
#    -source         [get_pins u_cmn_clkrst/u_clock_mux_ref_clk/clk_out] \
#    -add \
#    [get_ports cmn_ref_clk_gated]

create_generated_clock \
    -name           REFCLK_GATED_OUT_0 \
    -divide_by      1 \
    -master_clock   [get_clocks REFCLK0_OUT] \
    -source         [get_pins u_cmn_clkrst/u_clock_mux_ref_clk/clk_out] \
    -add \
    [get_ports cmn_ref_clk_gated]

create_generated_clock \
    -name           REFCLK_GATED_OUT_1 \
    -divide_by      1 \
    -master_clock   [get_clocks REFCLK1_OUT] \
    -source         [get_pins u_cmn_clkrst/u_clock_mux_ref_clk/clk_out] \
    -add \
    [get_ports cmn_ref_clk_gated]



# PLL programmable clocks
#PLL0 (max 1.25G)
#PLL1 (max 1G)
create_clock \
   -name     PLL0_CLK_PROG0 \
   -period   $CLK1250_PERIOD \
   -waveform $CLK1250_WAVEFORM \
   [get_pins { u_cmn_ana/cmnda_pll0_clk_prog0 }]

create_generated_clock \
   -name         PLL0_CLK_PROG0_OUT \
   -divide_by    1 \
   -master_clock [get_clocks { PLL0_CLK_PROG0 }] \
   -source       [get_pins { u_cmn_ana/cmnda_pll0_clk_prog0 }] \
   -add \
   [get_ports { cmn_pll0_clk_prog0 }]

create_clock \
   -name     PLL0_CLK_PROG1 \
   -period   $CLK1250_PERIOD \
   -waveform $CLK1250_WAVEFORM \
   [get_pins { u_cmn_ana/cmnda_pll0_clk_prog1 }]

create_generated_clock \
   -name         PLL0_CLK_PROG1_OUT \
   -divide_by    1 \
   -master_clock [get_clocks { PLL0_CLK_PROG1 }] \
   -source       [get_pins { u_cmn_ana/cmnda_pll0_clk_prog1 }] \
   -add \
   [get_ports { cmn_pll0_clk_prog1 }]

create_clock \
   -name     PLL1_CLK_PROG0 \
   -period   $CLK1000_PERIOD \
   -waveform $CLK1000_WAVEFORM \
   [get_pins { u_cmn_ana/cmnda_pll1_clk_prog0 }]

create_generated_clock \
   -name         PLL1_CLK_PROG0_OUT \
   -divide_by    1 \
   -master_clock [get_clocks { PLL1_CLK_PROG0 }] \
   -source       [get_pins { u_cmn_ana/cmnda_pll1_clk_prog0 }] \
   -add \
   [get_ports { cmn_pll1_clk_prog0 }]

create_clock \
   -name     PLL1_CLK_PROG1 \
   -period   $CLK1000_PERIOD \
   -waveform $CLK1000_WAVEFORM \
   [get_pins { u_cmn_ana/cmnda_pll1_clk_prog1 }]

create_generated_clock \
   -name         PLL1_CLK_PROG1_OUT \
   -divide_by    1 \
   -master_clock [get_clocks { PLL1_CLK_PROG1 }] \
   -source       [get_pins { u_cmn_ana/cmnda_pll1_clk_prog1 }] \
   -add \
   [get_ports { cmn_pll1_clk_prog1 }]

######################################################
# MOM Cap Oscillator output clock 100MHz - goes to clkmsmt
######################################################
create_clock \
   -name     CMN_MOM_OSC_CLK \
   -period   $CLK100_PERIOD \
   -waveform $CLK100_WAVEFORM \
   [get_pins { u_cmn_ana/cmnda_mom_osc_clk }]

######################################################
# Temperature sensor filter clock
######################################################
create_clock \
   -name     CMN_TMPSNS_CLK \
   -period   $CLK312P5_PERIOD \
   -waveform $CLK312P5_WAVEFORM \
   [get_pins { u_cmn_ana/cmnda_tmpsns_sdm_clk_out }]


#######################################
# Process Monitor Clock
#######################################
create_clock \
    -name           PCMCLK \
    -period         $CLK500_PERIOD \
    -waveform       $CLK500_WAVEFORM \
    [get_pins u_cmn_ana/cmnda_pmc_clk]

#######################################
# Signal Detect Clock
#######################################
create_clock \
    -name           SDCLK \
    -period         $CLK625_PERIOD \
    -waveform       $CLK625_WAVEFORM \
    [get_pins u_cmn_ana/cmnda_sd_clk]

###########################################################
# PSM clocks
###########################################################
# The PSM clock is generated from the SD CLK.
# Max freq is 125MHz but since SD CLK is above 500MHz in Calibration PSMCLK will be a little overconstrained.
create_generated_clock \
    -name           PSMCLK \
    -divide_by      4 \
    -master_clock   [get_clocks SDCLK] \
    -source         [get_pins u_cmn_ana/cmnda_sd_clk] \
    -add \
    [get_pins u_cmn_clkrst/u_clock_div_prog_psm_clk/u_clock_mux/${clk_mux_pin_1}]

# Common output PSM clock.
create_generated_clock \
    -name           PSMCLK_OUT \
    -divide_by      1 \
    -master_clock   [get_clocks PSMCLK] \
    -source         [get_pins u_cmn_clkrst/u_clock_div_prog_psm_clk/u_clock_mux/${clk_mux_pin_1}] \
    -add \
    [get_ports cmn_psm_clk_out]

# Common input PSM clock.
# [DL] SDC review. At-speed is having it as 200MHz and is the most restrictive.
create_clock \
    -name           PSMCLK_IN \
    -period         $CLK156P25_PERIOD \
    -waveform       $CLK156P25_WAVEFORM \
    [get_ports cmn_psm_clk_in]


#######################################
# CDB clock : 500MHz
########################################
#create_clock \
#    -name           CDBCLK \
#    -period         $CLK500_PERIOD \
#    -waveform       $CLK500_WAVEFORM \
#    [get_ports cmn_cdb_pclk]
#######################################

### Bumping for Palladium preemptive fix
create_clock \
    -name           CDBCLK \
    -period         $CLK525_PERIOD \
    -waveform       $CLK525_WAVEFORM \
    [get_ports cmn_cdb_pclk]


###########################################################
# PLL reference, feedback and DSM clocks.
###########################################################
# PLL0 reference clocks.
create_clock \
    -name           PLL0_REFCLK \
    -period         $CLK156P25_PERIOD \
    -waveform       $CLK156P25_WAVEFORM \
    [get_pins u_cmn_ana/cmnda_pll0_ref_clk]

#create_clock \
#    -name           PLL1_REFCLK \
#    -period         $CLK156P25_PERIOD \
#    -waveform       $CLK156P25_WAVEFORM \
#    [get_pins u_cmn_ana/cmnda_pll1_ref_clk]

# PLL0 feedback divider clocks.
# Spec has 500MHz max but during calibration there is a chance this may go higher SER-22134


#fb divider clock max (625M)
#confirmed with Zhiqiang
create_clock \
    -name           PLL0_FBCLK \
    -period         $CLK625_PERIOD \
    -waveform       $CLK625_WAVEFORM \
    [get_pins u_cmn_ana/cmnda_pll0_fb_divider_clk]

#create_clock \
#    -name           PLL1_FBCLK \
#    -period         $CLK625_PERIOD \
#    -waveform       $CLK625_WAVEFORM \
#    [get_pins u_cmn_ana/cmnda_pll1_fb_divider_clk]

# PLL0/1 DSM clocks. Currently speced to 100MHz max but calibration and stuckat caused target to 200MHz
create_clock \
    -name           PLL0_DSMCLK \
    -period         $DSMCLK_PERIOD \
    -waveform       $DSMCLK_WAVEFORM \
    [get_pins u_cmn_ana/cmnda_pll0_dsm_clk]

create_clock \
    -name           PLL1_DSMCLK \
    -period         $DSMCLK_PERIOD \
    -waveform       $DSMCLK_WAVEFORM \
    [get_pins u_cmn_ana/cmnda_pll1_dsm_clk]


# BSCAN
# No bscan clock in timberwolf
#create_clock                                                                                        \
#    -name           CMN_REF_CLK0_BSCAN_CLOCKDR                                                               \
#    -period         $BSCAN_PERIOD                                                                   \
#    -waveform       $BSCAN_WAVEFORM                                                                 \
#    [get_ports cmn_ref_clk0_bscan_clockdr]
#
#create_clock                                                                                        \
#    -name           CMN_REF_CLK1_BSCAN_CLOCKDR                                                               \
#    -period         $BSCAN_PERIOD                                                                   \
#    -waveform       $BSCAN_WAVEFORM                                                                 \
#    [get_ports cmn_ref_clk1_bscan_clockdr]
#
#create_clock                                                                                        \
#    -name           CMN_REF_CLK0_BSCAN_PC                                                                     \
#    -period         $BSCAN_PERIOD                                                                   \
#    -waveform       $BSCAN_WAVEFORM                                                                 \
#    [get_ports cmn_ref_clk0_bscan_pc]
#
#create_clock                                                                                        \
#    -name           CMN_REF_CLK1_BSCAN_PC                                                                     \
#    -period         $BSCAN_PERIOD                                                                   \
#    -waveform       $BSCAN_WAVEFORM                                                                 \
#    [get_ports cmn_ref_clk1_bscan_pc]



#######################################
# Virtual Clocks
#######################################
# Asynchronous clock phases. This phase is excluded from all other clocks.
create_clock \
    -name           IO_ASYNC \
    -period         $ASYNC_PERIOD \
    -waveform       $ASYNC_WAVEFORM


###############################################################################
# Clock Groups
###############################################################################

set_clock_groups -async -name grp_ref0   -group  [get_clocks {REFCLK0_FROM_SOC REFCLK0_OUT REFCLK_OUT_0 REFCLK_GATED_OUT_0}]
set_clock_groups -async -name grp_ref1   -group  [get_clocks {REFCLK1_FROM_SOC REFCLK1_OUT REFCLK_OUT_1 REFCLK_GATED_OUT_1}]
#set_clock_groups -name "REFCLK" -physically_exclusive
#set_clock_groups -name "REFCLK" -logically_exclusive  \
#                 -group {REFCLK0_OUT} \
#                 -group {REFCLK1_OUT}

set_clock_groups -async -name grp_pll0prg0 -group  [get_clocks { PLL0_CLK_PROG0 PLL0_CLK_PROG0_OUT}]
set_clock_groups -async -name grp_pll0prg1 -group  [get_clocks { PLL0_CLK_PROG1 PLL0_CLK_PROG1_OUT}]
set_clock_groups -async -name grp_pll1prg0 -group  [get_clocks { PLL1_CLK_PROG0 PLL1_CLK_PROG0_OUT}]
set_clock_groups -async -name grp_pll1prg1 -group  [get_clocks { PLL1_CLK_PROG1 PLL1_CLK_PROG1_OUT}]
set_clock_groups -async -name grp_mom    -group  [get_clocks {CMN_MOM_OSC_CLK}]
set_clock_groups -async -name grp_tmpsns -group  [get_clocks {CMN_TMPSNS_CLK}]
set_clock_groups -async -name grp_pcm    -group  [get_clocks {PCMCLK}]
#set_clock_groups -async -name grp_lfps   -group  [get_clocks {SDCLK}] #confirmed with ME guys
#set_clock_groups -async -name grp_psm    -group  [get_clocks { PSMCLK PSMCLK_OUT}]
set_clock_groups -async -name grp_psm    -group  [get_clocks {SDCLK PSMCLK PSMCLK_OUT}]

set_clock_groups -async -name grp_psmin  -group  [get_clocks {PSMCLK_IN}]
set_clock_groups -async -name grp_cdb    -group  [get_clocks {CDBCLK}]
set_clock_groups -async -name grp_pllref -group  [get_clocks {PLL0_REFCLK}]
set_clock_groups -async -name grp_pllfb  -group  [get_clocks {PLL0_FBCLK}]
set_clock_groups -async -name grp_plldsm0 -group  [get_clocks {PLL0_DSMCLK}]
set_clock_groups -async -name grp_plldsm1 -group  [get_clocks {PLL1_DSMCLK}]
set_clock_groups -async -name grp_async  -group  [get_clocks {IO_ASYNC}]


#set_clock_groups -async -name grp_pll01  -group  [get_clocks {*PLL0*}] \
#                                         -group  [get_clocks {*PLL1*}]
#set_clock_groups -async -name grp_cmsmt  -group  [get_clocks {*PLL0*}] \
#                                         -group  [get_clocks {*PLL1*}] \
#                                         -group  [get_clocks {SDCLK}]

#set_clock_groups -async -name grp_bscan    -group [get_clocks { *BSCAN_CLOCKDR }]
#set_clock_groups -async -name grp_bscan_pc -group [get_clocks { *BSCAN_PC }]

###############################################################################
# Clock Uncertainties
###############################################################################
#########################################################################
# Default uncertainties. Default setup is high in order to catch
# unaccounted for clock relationships.
set default_margin 5.000
set_clock_uncertainty $default_margin -setup -from [all_clocks] -to [all_clocks]
set_clock_uncertainty $hold_margin    -hold  -from [all_clocks] -to [all_clocks]

# Account for intra-clock relationships.
#set_clock_uncertainty $setup_margin -setup -from [get_clocks REFCLK] -to [get_clocks REFCLK]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks REFCLK] -to [get_clocks REFCLK_GATED*]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks REFCLK] -to [get_clocks REFCLK_OUT]

#set_clock_uncertainty $setup_margin -setup -from [get_clocks REFCLK_DER] -to [get_clocks REFCLK_DER]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks REFCLK_DIV2] -to [get_clocks REFCLK_DIV2]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks REFCLK_DIV4] -to [get_clocks REFCLK_DIV4]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks REFCLK0_RCV] -to [get_clocks REFCLK0_RCV]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks REFCLK1_RCV] -to [get_clocks REFCLK1_RCV]

#For refernece clock and psm clock , add more margin (+0.2)
#update for timberwolf add 200ps margin after review.
set_clock_uncertainty [expr $setup_margin + 0.200] -setup -from [get_clocks REFCLK0_FROM_SOC] -to [get_clocks REFCLK0_FROM_SOC]
set_clock_uncertainty [expr $setup_margin + 0.200] -setup -from [get_clocks REFCLK0_FROM_SOC] -to [get_clocks REFCLK0_OUT]
set_clock_uncertainty [expr $setup_margin + 0.200] -setup -from [get_clocks REFCLK0_FROM_SOC] -to [get_clocks REFCLK_OUT_0]
set_clock_uncertainty [expr $setup_margin + 0.200] -setup -from [get_clocks REFCLK0_FROM_SOC] -to [get_clocks REFCLK_GATED_OUT_0]
set_clock_uncertainty [expr $setup_margin + 0.200] -setup -from [get_clocks REFCLK0_OUT]      -to [get_clocks REFCLK0_OUT]
set_clock_uncertainty [expr $setup_margin + 0.200] -setup -from [get_clocks REFCLK0_OUT]      -to [get_clocks REFCLK_OUT_0]
set_clock_uncertainty [expr $setup_margin + 0.200] -setup -from [get_clocks REFCLK0_OUT]      -to [get_clocks REFCLK_GATED_OUT_0]

set_clock_uncertainty [expr $setup_margin + 0.200] -setup -from [get_clocks REFCLK1_FROM_SOC] -to [get_clocks REFCLK1_FROM_SOC]
set_clock_uncertainty [expr $setup_margin + 0.200] -setup -from [get_clocks REFCLK1_FROM_SOC] -to [get_clocks REFCLK1_OUT]
set_clock_uncertainty [expr $setup_margin + 0.200] -setup -from [get_clocks REFCLK1_FROM_SOC] -to [get_clocks REFCLK_OUT_1]
set_clock_uncertainty [expr $setup_margin + 0.200] -setup -from [get_clocks REFCLK1_FROM_SOC] -to [get_clocks REFCLK_GATED_OUT_1]
set_clock_uncertainty [expr $setup_margin + 0.200] -setup -from [get_clocks REFCLK1_OUT]      -to [get_clocks REFCLK1_OUT]
set_clock_uncertainty [expr $setup_margin + 0.200] -setup -from [get_clocks REFCLK1_OUT]      -to [get_clocks REFCLK_OUT_1]
set_clock_uncertainty [expr $setup_margin + 0.200] -setup -from [get_clocks REFCLK1_OUT]      -to [get_clocks REFCLK_GATED_OUT_1]

set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL0_CLK_PROG0] -to [get_clocks PLL0_CLK_PROG0]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL0_CLK_PROG0] -to [get_clocks PLL0_CLK_PROG0_OUT]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL0_CLK_PROG1] -to [get_clocks PLL0_CLK_PROG1]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL0_CLK_PROG1] -to [get_clocks PLL0_CLK_PROG1_OUT]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL1_CLK_PROG0] -to [get_clocks PLL1_CLK_PROG0]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL1_CLK_PROG0] -to [get_clocks PLL1_CLK_PROG0_OUT]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL1_CLK_PROG1] -to [get_clocks PLL1_CLK_PROG1]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL1_CLK_PROG1] -to [get_clocks PLL1_CLK_PROG1_OUT]
set_clock_uncertainty $setup_margin -setup -from [get_clocks CMN_MOM_OSC_CLK] -to [get_clocks CMN_MOM_OSC_CLK]
set_clock_uncertainty $setup_margin -setup -from [get_clocks CMN_TMPSNS_CLK] -to [get_clocks CMN_TMPSNS_CLK]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PCMCLK] -to [get_clocks PCMCLK]


#set_clock_uncertainty $setup_margin -setup -from [get_clocks SDCLK] -to [get_clocks SDCLK]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks PSMCLK] -to [get_clocks PSMCLK]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks PSMCLK] -to [get_clocks PSMCLK_OUT]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks {SDCLK PSMCLK PSMCLK_OUT}] -to [get_clocks {SDCLK PSMCLK PSMCLK_OUT}]
set_clock_uncertainty $setup_margin -setup -from [get_clocks SDCLK] -to [get_clocks SDCLK]
set_clock_uncertainty $setup_margin -setup -from [get_clocks SDCLK] -to [get_clocks PSMCLK]
set_clock_uncertainty $setup_margin -setup -from [get_clocks SDCLK] -to [get_clocks PSMCLK_OUT]

#add
set_clock_uncertainty $setup_margin -setup -from [get_clocks PSMCLK] -to [get_clocks SDCLK]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PSMCLK] -to [get_clocks PSMCLK]

set_clock_uncertainty $setup_margin -setup -from [get_clocks PSMCLK_IN] -to [get_clocks PSMCLK_IN]

set_clock_uncertainty $setup_margin -setup -from [get_clocks CDBCLK] -to [get_clocks CDBCLK]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL0_REFCLK] -to [get_clocks PLL0_REFCLK]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL0_FBCLK] -to [get_clocks PLL0_FBCLK]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL0_DSMCLK] -to [get_clocks PLL0_DSMCLK]
set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL1_DSMCLK] -to [get_clocks PLL1_DSMCLK]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL1_FBCLK] -to [get_clocks PLL1_FBCLK]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks PLL1_REFCLK] -to [get_clocks PLL1_REFCLK]
set_clock_uncertainty $setup_margin -setup -from [get_clocks IO_ASYNC] -to [get_clocks IO_ASYNC]

#set_clock_uncertainty $setup_margin -setup -from [get_clocks CMN_REF_CLK0_BSCAN_CLOCKDR]  -to [get_clocks CMN_REF_CLK0_BSCAN_CLOCKDR]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks CMN_REF_CLK1_BSCAN_CLOCKDR]  -to [get_clocks CMN_REF_CLK1_BSCAN_CLOCKDR]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks CMN_REF_CLK0_BSCAN_PC]       -to [get_clocks CMN_REF_CLK0_BSCAN_PC]
#set_clock_uncertainty $setup_margin -setup -from [get_clocks CMN_REF_CLK1_BSCAN_PC]       -to [get_clocks CMN_REF_CLK1_BSCAN_PC]

# REFCLK 156.25MHz @40-60% DC : 6.4ns period 
# add 10% margin
#set_clock_uncertainty [expr $setup_dc_margin + 0.640] -setup -rise_from [get_clocks {REFCLK*}] -fall_to [get_clocks {REFCLK*}]
#set_clock_uncertainty [expr $setup_dc_margin + 0.640] -setup -fall_from [get_clocks {REFCLK*}] -rise_to [get_clocks {REFCLK*}]

set_clock_uncertainty [expr $setup_dc_margin + 0.640] -setup -rise_from [get_clocks {REFCLK0_FROM_SOC REFCLK0_OUT REFCLK_OUT_0 REFCLK_GATED_OUT_0}] \
                                                             -fall_to   [get_clocks {REFCLK0_FROM_SOC REFCLK0_OUT REFCLK_OUT_0 REFCLK_GATED_OUT_0}]
set_clock_uncertainty [expr $setup_dc_margin + 0.640] -setup -fall_from [get_clocks {REFCLK0_FROM_SOC REFCLK0_OUT REFCLK_OUT_0 REFCLK_GATED_OUT_0}] \
                                                             -rise_to   [get_clocks {REFCLK0_FROM_SOC REFCLK0_OUT REFCLK_OUT_0 REFCLK_GATED_OUT_0}]

set_clock_uncertainty [expr $setup_dc_margin + 0.640] -setup -rise_from [get_clocks {REFCLK1_FROM_SOC REFCLK1_OUT REFCLK_OUT_1 REFCLK_GATED_OUT_1}] \
                                                             -fall_to   [get_clocks {REFCLK1_FROM_SOC REFCLK1_OUT REFCLK_OUT_1 REFCLK_GATED_OUT_1}]
set_clock_uncertainty [expr $setup_dc_margin + 0.640] -setup -fall_from [get_clocks {REFCLK1_FROM_SOC REFCLK1_OUT REFCLK_OUT_1 REFCLK_GATED_OUT_1}] \
                                                             -rise_to   [get_clocks {REFCLK1_FROM_SOC REFCLK1_OUT REFCLK_OUT_1 REFCLK_GATED_OUT_1}]


#need confirm with zhiqiang for all clock
# for whistle PLL programmable clocks 2GHz @30-70% DC : 0.5ns period
# add 20%
# for timberwolf margin 1.25GHz 800ps if dc = 30-70, add 160ps
set_clock_uncertainty [expr $setup_dc_margin + 0.160] -setup -rise_from [get_clocks {PLL0_CLK_PROG0*}] -fall_to [get_clocks {PLL0_CLK_PROG0*}]
set_clock_uncertainty [expr $setup_dc_margin + 0.160] -setup -fall_from [get_clocks {PLL0_CLK_PROG0*}] -rise_to [get_clocks {PLL0_CLK_PROG0*}]

set_clock_uncertainty [expr $setup_dc_margin + 0.160] -setup -rise_from [get_clocks {PLL0_CLK_PROG1*}] -fall_to [get_clocks {PLL0_CLK_PROG1*}]
set_clock_uncertainty [expr $setup_dc_margin + 0.160] -setup -fall_from [get_clocks {PLL0_CLK_PROG1*}] -rise_to [get_clocks {PLL0_CLK_PROG1*}]

set_clock_uncertainty [expr $setup_dc_margin + 0.160] -setup -rise_from [get_clocks {PLL1_CLK_PROG0*}] -fall_to [get_clocks {PLL1_CLK_PROG0*}]
set_clock_uncertainty [expr $setup_dc_margin + 0.160] -setup -fall_from [get_clocks {PLL1_CLK_PROG0*}] -rise_to [get_clocks {PLL1_CLK_PROG0*}]

set_clock_uncertainty [expr $setup_dc_margin + 0.160] -setup -rise_from [get_clocks {PLL1_CLK_PROG1*}] -fall_to [get_clocks {PLL1_CLK_PROG1*}]
set_clock_uncertainty [expr $setup_dc_margin + 0.160] -setup -fall_from [get_clocks {PLL1_CLK_PROG1*}] -rise_to [get_clocks {PLL1_CLK_PROG1*}]

# MOM Cap Oscillator output clock 100MHz @10-90% : 10ns period
set_clock_uncertainty [expr $setup_dc_margin + 4.000] -setup -rise_from [get_clocks {CMN_MOM_OSC_CLK}] -fall_to [get_clocks {CMN_MOM_OSC_CLK}]
set_clock_uncertainty [expr $setup_dc_margin + 4.000] -setup -fall_from [get_clocks {CMN_MOM_OSC_CLK}] -rise_to [get_clocks {CMN_MOM_OSC_CLK}]

# Temperature sensor filter clock 312.5MHz @45-55% : 3.2ns period
set_clock_uncertainty [expr $setup_dc_margin + 0.160] -setup -rise_from [get_clocks {CMN_TMPSNS_CLK}] -fall_to [get_clocks {CMN_TMPSNS_CLK}]
set_clock_uncertainty [expr $setup_dc_margin + 0.160] -setup -fall_from [get_clocks {CMN_TMPSNS_CLK}] -rise_to [get_clocks {CMN_TMPSNS_CLK}]

# Process Monitor Clock 500MHz @45-55% : 2ns period
set_clock_uncertainty [expr $setup_dc_margin + 0.100] -setup -rise_from [get_clocks {PCMCLK}] -fall_to [get_clocks {PCMCLK}]
set_clock_uncertainty [expr $setup_dc_margin + 0.100] -setup -fall_from [get_clocks {PCMCLK}] -rise_to [get_clocks {PCMCLK}]

# Signal Detect Clock 625MHz @45-55%% : 1.6ns period
#TODO confirmed with xingyang
set_clock_uncertainty [expr $setup_dc_margin + 0.080] -setup -rise_from [get_clocks {SDCLK}] -fall_to [get_clocks {SDCLK}]
set_clock_uncertainty [expr $setup_dc_margin + 0.080] -setup -fall_from [get_clocks {SDCLK}] -rise_to [get_clocks {SDCLK}]

# PSM clocks 125MHz @33-66% : 8ns period
#TODO confirmed with xingyang
set_clock_uncertainty [expr $setup_dc_margin + 1.360] -setup -rise_from [get_clocks {PSMCLK*}] -fall_to [get_clocks {PSMCLK*}]
set_clock_uncertainty [expr $setup_dc_margin + 1.360] -setup -fall_from [get_clocks {PSMCLK*}] -rise_to [get_clocks {PSMCLK*}]

# CDB clock : 500MHz @50% : 2ns period, assume 5% 
set_clock_uncertainty [expr $setup_dc_margin + 0.100] -setup -rise_from [get_clocks {CDBCLK}] -fall_to [get_clocks {CDBCLK}]
set_clock_uncertainty [expr $setup_dc_margin + 0.100] -setup -fall_from [get_clocks {CDBCLK}] -rise_to [get_clocks {CDBCLK}]

# PLL0 reference clocks : 156.25MHz @40-60% : 6.4ns period
set_clock_uncertainty [expr $setup_dc_margin + 0.640] -setup -rise_from [get_clocks {PLL0_REFCLK}] -fall_to [get_clocks {PLL0_REFCLK}]
set_clock_uncertainty [expr $setup_dc_margin + 0.640] -setup -fall_from [get_clocks {PLL0_REFCLK}] -rise_to [get_clocks {PLL0_REFCLK}]

#set_clock_uncertainty [expr $setup_dc_margin + 0.640] -setup -rise_from [get_clocks {PLL1_REFCLK}] -fall_to [get_clocks {PLL1_REFCLK}]
#set_clock_uncertainty [expr $setup_dc_margin + 0.640] -setup -fall_from [get_clocks {PLL1_REFCLK}] -rise_to [get_clocks {PLL1_REFCLK}]

# PLL0 feedback divider clocks : 625MHz @40-60% ats : 1.6ns period
set_clock_uncertainty [expr $setup_dc_margin + 0.160] -setup -rise_from [get_clocks {PLL0_FBCLK}] -fall_to [get_clocks {PLL0_FBCLK}]
set_clock_uncertainty [expr $setup_dc_margin + 0.160] -setup -fall_from [get_clocks {PLL0_FBCLK}] -rise_to [get_clocks {PLL0_FBCLK}]

#set_clock_uncertainty [expr $setup_dc_margin + 0.160] -setup -rise_from [get_clocks {PLL1_FBCLK}] -fall_to [get_clocks {PLL1_FBCLK}]
#set_clock_uncertainty [expr $setup_dc_margin + 0.160] -setup -fall_from [get_clocks {PLL1_FBCLK}] -rise_to [get_clocks {PLL1_FBCLK}]

# PLL0/1 DSM clocks : 200MHz @40-60% ats : 5ns period
set_clock_uncertainty [expr $setup_dc_margin + 0.500] -setup -rise_from [get_clocks {PLL0_DSMCLK}] -fall_to [get_clocks {PLL0_DSMCLK}]
set_clock_uncertainty [expr $setup_dc_margin + 0.500] -setup -fall_from [get_clocks {PLL0_DSMCLK}] -rise_to [get_clocks {PLL0_DSMCLK}]

set_clock_uncertainty [expr $setup_dc_margin + 0.500] -setup -rise_from [get_clocks {PLL1_DSMCLK}] -fall_to [get_clocks {PLL1_DSMCLK}]
set_clock_uncertainty [expr $setup_dc_margin + 0.500] -setup -fall_from [get_clocks {PLL1_DSMCLK}] -rise_to [get_clocks {PLL1_DSMCLK}]

# BSCAN 100MHz 40-60 @10ns period
#set_clock_uncertainty [expr $setup_dc_margin + 1.000] -setup -rise_from [get_clocks {CMN_REF_CLK1_BSCAN_CLOCKDR}] -fall_to   [get_clocks {CMN_REF_CLK1_BSCAN_CLOCKDR}]
#set_clock_uncertainty [expr $setup_dc_margin + 1.000] -setup -fall_to   [get_clocks {CMN_REF_CLK1_BSCAN_CLOCKDR}] -rise_from [get_clocks {CMN_REF_CLK1_BSCAN_CLOCKDR}]
#
#set_clock_uncertainty [expr $setup_dc_margin + 1.000] -setup -rise_from [get_clocks {CMN_REF_CLK0_BSCAN_CLOCKDR}] -fall_to   [get_clocks {CMN_REF_CLK0_BSCAN_CLOCKDR}]
#set_clock_uncertainty [expr $setup_dc_margin + 1.000] -setup -fall_to   [get_clocks {CMN_REF_CLK0_BSCAN_CLOCKDR}] -rise_from [get_clocks {CMN_REF_CLK0_BSCAN_CLOCKDR}]
#
#set_clock_uncertainty [expr $setup_dc_margin + 1.000] -setup -rise_from [get_clocks {CMN_REF_CLK0_BSCAN_PC}] -fall_to   [get_clocks {CMN_REF_CLK0_BSCAN_PC}]
#set_clock_uncertainty [expr $setup_dc_margin + 1.000] -setup -fall_to   [get_clocks {CMN_REF_CLK0_BSCAN_PC}] -rise_from [get_clocks {CMN_REF_CLK0_BSCAN_PC}]
#
#set_clock_uncertainty [expr $setup_dc_margin + 1.000] -setup -rise_from [get_clocks {CMN_REF_CLK1_BSCAN_PC}] -fall_to   [get_clocks {CMN_REF_CLK1_BSCAN_PC}]
#set_clock_uncertainty [expr $setup_dc_margin + 1.000] -setup -fall_to   [get_clocks {CMN_REF_CLK1_BSCAN_PC}] -rise_from [get_clocks {CMN_REF_CLK1_BSCAN_PC}]


###############################################################################
# Transitions and Transition Limits
###############################################################################
if { [info exists load_syn_sdc] && $load_syn_sdc} {
    set_max_transition   $max_trans [current_design]
    set_max_transition   $max_trans [all_inputs]
    set_max_transition   $max_trans [all_outputs]
    set_clock_transition $max_clk_trans [all_clocks]
} else {
::tech::set_transitions
}

###############################################################################
# I/O Timing
###############################################################################

###########################################################
# Asynchronous and Constant I/Os
# NOTE: Some of the signals in this section are feedthroughs
#       but we want their constraints to be "synchronous"
#       style instead of using set_max_delay. Therefore, 
#       their arrival/output-valid times are w.r.t. IO_ASYNC.
###########################################################

############################################
# Analog, asynchronous and constant ports
############################################
#Listed as found in Section 2 of the Whistler32G PMA Specific

#   cmn_ref_clk_dig_sel
#   cmn_ref_clk0_term_en
#   cmn_ref_clk1_term_en
#   cmn_ref_clk0_rcv_en
#   cmn_ref_clk1_rcv_en


#focus cmn_rext/cmn_atb_core_0/cmn_atb_core_1
set async_inputs [get_ports {
   cmn_rext
   cmn_ref_clk_dig_sel
   cmn_ref_clk_disable
   cmn_ref_clk_dig_div[*]
   cmn_reset_n
   cmn_macro_suspend_req
   cmn_pll0_ref_clk_sel[*]
   cmn_pll0_reset_n
   cmn_pll0_en
   cmn_pll0_mode_sel
   cmn_pll0_suspend_req
   cmn_pll1_ref_clk_sel[*]
   cmn_pll1_reset_n
   cmn_pll1_en
   cmn_pll1_mode_sel
   cmn_pll1_suspend_req
   cmn_cdb_preset_n
   cmn_atb_core_0
   cmn_atb_core_1
   cmn_scanmode
   cmn_scanen
   cmn_scanen_cg
   cmn_scanin[*]
   cmn_bscan_mode_en
   xcvr_power_state_en_token_r
}]


foreach_in_collection pma_port $async_inputs {
   set port_name [get_object $pma_port]
   set_input_delay 0.0 -max -add -clock [get_clocks { IO_ASYNC }] $port_name
}

#cmn_avdd_clk_pwrgood
#cmn_ref_clk_der

#focus cmn_rext cmn_atb_core_*

set async_outputs [get_ports {
   cmn_rext
   cmn_avdd_pwrgood
   cmn_pll0_locked
   cmn_pll1_locked
   cmn_atb_core_*
   cmn_scanout[*]
   cmn_scanclk_pll0_prog0_ats_out
   cmn_scanclk_pll0_prog1_ats_out
   cmn_scanclk_pll1_prog0_ats_out
   cmn_scanclk_pll1_prog1_ats_out
   xcvrc_isl_power_isolation_en_l
   xcvrc_isl_power_isolation_en_r
   diag_isl_power_isolation_en_l
   diag_isl_power_isolation_en_r
}]

set ASYNC_IO_DELAY      [expr round((($ASYNC_PERIOD * 1.0) * 0.485) * 100.0) / 100.0]
if { $::timeMode == "ideal" } {
    set async_input_delay  8.000
    set async_output_delay 8.000
} else {
    set async_input_delay  $ASYNC_IO_DELAY
    set async_output_delay $ASYNC_IO_DELAY
}

set_output_delay $async_output_delay -max -add -clock   [get_clocks IO_ASYNC] \
                                                        [get_ports  { \
                                                                    cmn_reset_n_l \
                                                                    cmn_reset_n_r \
                                                                    cmn_reset_sync_n_l \
                                                                    cmn_reset_sync_n_r \
                                                                    xcvr_power_state_en_token_l \
                                                                    } \
                                                        ]


###########################################################
# REFCLK
###########################################################
set CLK156P25_IO_DELAY     [expr round(($CLK156P25_PERIOD * 2.0 / 3.0) * 100.0) / 100.0]
if { $::timeMode == "ideal" } {
    set refclk_input_delay  2.800
    set refclk_output_delay 2.800
} else {
    set refclk_input_delay  $CLK156P25_IO_DELAY
    set refclk_output_delay $CLK156P25_IO_DELAY
}
#set_input_delay $refclk_input_delay -max -add -clock    [get_clocks REFCLK] \
#                                                        [get_ports  { \
#                                                                    cmn_macro_suspend_req \
#                                                                    cmn_pll0_en \
#                                                                    cmn_pll1_en \
#                                                                    cmn_ref_clk_dig_div[*] \
#                                                                    cmn_ref_clk_disable \
#                                                                    rx_sd_clk_en_to_cmn_l \
#                                                                    rx_sd_clk_en_to_cmn_r \
#                                                                    rx_sig_det_en_to_cmn_l \
#                                                                    rx_sig_det_en_to_cmn_r \
#                                                                    } \
#                                                        ]

set_input_delay $refclk_input_delay -max -add -clock    [get_clocks REFCLK0_OUT] \
                                                        [get_ports  { \
                                                                    cmn_macro_suspend_req \
                                                                    cmn_pll0_en \
                                                                    cmn_pll1_en \
                                                                    cmn_ref_clk_dig_div[*] \
                                                                    cmn_ref_clk_disable \
                                                                    rx_sd_clk_en_to_cmn_l \
                                                                    rx_sd_clk_en_to_cmn_r \
                                                                    rx_sig_det_en_to_cmn_l \
                                                                    rx_sig_det_en_to_cmn_r \
                                                                    } \
                                                        ]


set_input_delay $refclk_input_delay -max -add -clock    [get_clocks REFCLK1_OUT] \
                                                        [get_ports  { \
                                                                    cmn_macro_suspend_req \
                                                                    cmn_pll0_en \
                                                                    cmn_pll1_en \
                                                                    cmn_ref_clk_dig_div[*] \
                                                                    cmn_ref_clk_disable \
                                                                    rx_sd_clk_en_to_cmn_l \
                                                                    rx_sd_clk_en_to_cmn_r \
                                                                    rx_sig_det_en_to_cmn_l \
                                                                    rx_sig_det_en_to_cmn_r \
                                                                    } \
                                                        ]


#                                                                    cmn_pll1_en \

#set_output_delay $refclk_output_delay -max -add -clock  [get_clocks REFCLK_OUT] \
#                                                        [get_ports  { \
#                                                                    cmn_macro_suspend_ack \
#                                                                    cmn_macro_suspend_ack_l \
#                                                                    cmn_macro_suspend_ack_r \
#                                                                    cmn_pll0_suspend_ack \
#                                                                    cmn_pll0_disabled \
#                                                                    cmn_pll0_locked \
#                                                                    cmn_pll0_ready \
#                                                                    cmn_pll1_suspend_ack \
#                                                                    cmn_pll1_disabled \
#                                                                    cmn_pll1_locked \
#                                                                    cmn_pll1_ready \
#                                                                    cmn_ready \
#                                                                    cmn_ready_l \
#                                                                    cmn_ready_r \
#                                                                    cmn_ref_clk_active \
#                                                                    xcvr_decap_en_l \
#                                                                    xcvr_decap_en_r \
#                                                                    } \
#                                                        ]

set_output_delay $refclk_output_delay -max -add -clock  [get_clocks REFCLK0_OUT] \
                                                        [get_ports  { \
                                                                    cmn_macro_suspend_ack \
                                                                    cmn_macro_suspend_ack_l \
                                                                    cmn_macro_suspend_ack_r \
                                                                    cmn_pll0_suspend_ack \
                                                                    cmn_pll0_disabled \
                                                                    cmn_pll0_locked \
                                                                    cmn_pll0_ready \
                                                                    cmn_pll1_suspend_ack \
                                                                    cmn_pll1_disabled \
                                                                    cmn_pll1_locked \
                                                                    cmn_pll1_ready \
                                                                    cmn_ready \
                                                                    cmn_ready_l \
                                                                    cmn_ready_r \
                                                                    cmn_ref_clk_active \
                                                                    xcvr_decap_en_l \
                                                                    xcvr_decap_en_r \
                                                                    } \
                                                        ]

set_output_delay $refclk_output_delay -max -add -clock  [get_clocks REFCLK1_OUT] \
                                                        [get_ports  { \
                                                                    cmn_macro_suspend_ack \
                                                                    cmn_macro_suspend_ack_l \
                                                                    cmn_macro_suspend_ack_r \
                                                                    cmn_pll0_suspend_ack \
                                                                    cmn_pll0_disabled \
                                                                    cmn_pll0_locked \
                                                                    cmn_pll0_ready \
                                                                    cmn_pll1_suspend_ack \
                                                                    cmn_pll1_disabled \
                                                                    cmn_pll1_locked \
                                                                    cmn_pll1_ready \
                                                                    cmn_ready \
                                                                    cmn_ready_l \
                                                                    cmn_ready_r \
                                                                    cmn_ref_clk_active \
                                                                    xcvr_decap_en_l \
                                                                    xcvr_decap_en_r \
                                                                    } \
                                                        ]

set_output_delay $refclk_output_delay -max -add -clock  [get_clocks REFCLK_OUT_0] \
                                                        [get_ports  { \
                                                                    cmn_macro_suspend_ack \
                                                                    cmn_macro_suspend_ack_l \
                                                                    cmn_macro_suspend_ack_r \
                                                                    cmn_pll0_suspend_ack \
                                                                    cmn_pll0_disabled \
                                                                    cmn_pll0_locked \
                                                                    cmn_pll0_ready \
                                                                    cmn_pll1_suspend_ack \
                                                                    cmn_pll1_disabled \
                                                                    cmn_pll1_locked \
                                                                    cmn_pll1_ready \
                                                                    cmn_ready \
                                                                    cmn_ready_l \
                                                                    cmn_ready_r \
                                                                    cmn_ref_clk_active \
                                                                    xcvr_decap_en_l \
                                                                    xcvr_decap_en_r \
                                                                    } \
                                                        ]

set_output_delay $refclk_output_delay -max -add -clock  [get_clocks REFCLK_OUT_1] \
                                                        [get_ports  { \
                                                                    cmn_macro_suspend_ack \
                                                                    cmn_macro_suspend_ack_l \
                                                                    cmn_macro_suspend_ack_r \
                                                                    cmn_pll0_suspend_ack \
                                                                    cmn_pll0_disabled \
                                                                    cmn_pll0_locked \
                                                                    cmn_pll0_ready \
                                                                    cmn_pll1_suspend_ack \
                                                                    cmn_pll1_disabled \
                                                                    cmn_pll1_locked \
                                                                    cmn_pll1_ready \
                                                                    cmn_ready \
                                                                    cmn_ready_l \
                                                                    cmn_ready_r \
                                                                    cmn_ref_clk_active \
                                                                    xcvr_decap_en_l \
                                                                    xcvr_decap_en_r \
                                                                    } \
                                                        ]




#set_output_delay $refclk_output_delay -max -add -clock  [get_clocks REFCLK_GATED_OUT] \
#                                                        [get_ports  { \
#                                                                    cmn_macro_suspend_ack \
#                                                                    cmn_macro_suspend_ack_l \
#                                                                    cmn_macro_suspend_ack_r \
#                                                                    cmn_pll0_suspend_ack \
#                                                                    cmn_pll0_disabled \
#                                                                    cmn_pll0_ready \
#                                                                    cmn_pll1_suspend_ack \
#                                                                    cmn_pll1_disabled \
#                                                                    cmn_pll1_ready \
#                                                                    cmn_ready \
#                                                                    cmn_ready_l \
#                                                                    cmn_ready_r \
#                                                                    cmn_ref_clk_active \
#                                                                    xcvr_decap_en_l \
#                                                                    xcvr_decap_en_r \
#                                                                    } \
#                                                        ]

set_output_delay $refclk_output_delay -max -add -clock  [get_clocks REFCLK_GATED_OUT_0] \
                                                        [get_ports  { \
                                                                    cmn_macro_suspend_ack \
                                                                    cmn_macro_suspend_ack_l \
                                                                    cmn_macro_suspend_ack_r \
                                                                    cmn_pll0_suspend_ack \
                                                                    cmn_pll0_disabled \
                                                                    cmn_pll0_ready \
                                                                    cmn_pll1_suspend_ack \
                                                                    cmn_pll1_disabled \
                                                                    cmn_pll1_ready \
                                                                    cmn_ready \
                                                                    cmn_ready_l \
                                                                    cmn_ready_r \
                                                                    cmn_ref_clk_active \
                                                                    xcvr_decap_en_l \
                                                                    xcvr_decap_en_r \
                                                                    } \
                                                        ]

set_output_delay $refclk_output_delay -max -add -clock  [get_clocks REFCLK_GATED_OUT_1] \
                                                        [get_ports  { \
                                                                    cmn_macro_suspend_ack \
                                                                    cmn_macro_suspend_ack_l \
                                                                    cmn_macro_suspend_ack_r \
                                                                    cmn_pll0_suspend_ack \
                                                                    cmn_pll0_disabled \
                                                                    cmn_pll0_ready \
                                                                    cmn_pll1_suspend_ack \
                                                                    cmn_pll1_disabled \
                                                                    cmn_pll1_ready \
                                                                    cmn_ready \
                                                                    cmn_ready_l \
                                                                    cmn_ready_r \
                                                                    cmn_ref_clk_active \
                                                                    xcvr_decap_en_l \
                                                                    xcvr_decap_en_r \
                                                                    } \
                                                        ]

###########################################################
# PSMCLK
###########################################################
if { $::timeMode == "ideal" } {
    set psmclk_input_delay  2.800
    set psmclk_output_delay 2.800
} else {
    set psmclk_input_delay  $CLK156P25_IO_DELAY
    set psmclk_output_delay $CLK156P25_IO_DELAY
}
set_input_delay $psmclk_input_delay -max -add -clock    [get_clocks PSMCLK_IN] \
                                                        [get_ports  { \
                                                                    tx_clk_reset_req_l \
                                                                    tx_clk_reset_req_r \
                                                                    xcvr_clk_buf_en_0_l \
                                                                    xcvr_clk_buf_en_0_r \
                                                                    xcvr_clk_buf_en_1_l \
                                                                    xcvr_clk_buf_en_1_r \
                                                                    } \
                                                        ]

set_output_delay $psmclk_output_delay -max -add -clock  [get_clocks PSMCLK_OUT] \
                                                        [get_ports  { \
                                                                    tx_clk_reset_ack_l \
                                                                    tx_clk_reset_ack_r \
                                                                    tx_clk_reset_stp_l \
                                                                    tx_clk_reset_stp_r \
                                                                    } \
                                                        ]


###########################################################
# CDBCLK
###########################################################
set CLK500_IO_DELAY     [expr round(($CLK500_PERIOD * 2.0 / 3.0) * 100.0) / 100.0]
if { $::timeMode == "ideal" } {
    #set cdbclk_input_delay  0.600
    #set cdbclk_output_delay 0.600
    #update for timeberwolf
    set cdbclk_input_delay  0.800
    set cdbclk_output_delay 0.800
} else {
    set cdbclk_input_delay  $CLK500_IO_DELAY
    set cdbclk_output_delay $CLK500_IO_DELAY
}
set_input_delay $cdbclk_input_delay -max -add -clock    [get_clocks CDBCLK] \
                                                        [get_ports  { \
                                                                    cmn_cdb_paddr[*] \
                                                                    cmn_cdb_penable \
                                                                    cmn_cdb_psel \
                                                                    cmn_cdb_pwdata[*] \
                                                                    cmn_cdb_pwrite \
                                                                    } \
                                                        ]

set_output_delay $cdbclk_output_delay -max -add -clock  [get_clocks CDBCLK] \
                                                        [get_ports  { \
                                                                    cmn_cdb_prdata[*] \
                                                                    cmn_cdb_pready \
                                                                    cmn_atb_en_l \
                                                                    cmn_atb_en_r \
                                                                    cmn_atb_sel_l[*] \
                                                                    cmn_atb_sel_r[*] \
                                                                    rx_rescal_code_l[*] \
                                                                    rx_rescal_code_r[*] \
                                                                    tx_rescal_code_l[*] \
                                                                    tx_rescal_code_r[*] \
                                                                    } \
                                                        ]

#### alexd: Constraining the cdb_isl_power_isolation_en signal, creating issues at PMA integration
set_output_delay $cdbclk_output_delay -max -add -clock [get_clocks CDBCLK] [get_ports {cdb_isl_power_isolation_en_l cdb_isl_power_isolation_en_r}]

############################################
# Boundary scan
############################################

# Need to adjust I/O timing for WC clock latency
#if { $::timeMode == "prop" } {
#   set bscan_latency  0.035
#} else {
#   set bscan_latency  0.0
#}
#
## Set I/O timing to 1/3 clock period.
#set bscan_value  [expr round(($BSCAN_PERIOD * 1.0 / 3.0) * 100) / 100.0]
#set bscan_indly  [expr $bscan_value + $bscan_latency]
#set bscan_outdly [expr $bscan_value - $bscan_latency]
#
#   set cmn_ref_clk1 [get_clocks CMN_REF_CLK1_BSCAN_CLOCKDR]
#   set_input_delay  $bscan_indly  -max -add -clock $cmn_ref_clk1 [get_ports cmn_ref_clk1_bscan_shiftdr]
#   set_input_delay  $bscan_indly  -max -add -clock $cmn_ref_clk1 [get_ports cmn_ref_clk1_bscan_tdi]
#   set_output_delay $bscan_outdly -max -add -clock $cmn_ref_clk1 [get_ports cmn_ref_clk1_bscan_tdo]
#   set cmn_ref_clk0 [get_clocks CMN_REF_CLK0_BSCAN_CLOCKDR]
#   set_input_delay  $bscan_indly  -max -add -clock $cmn_ref_clk0 [get_ports cmn_ref_clk0_bscan_shiftdr]
#   set_input_delay  $bscan_indly  -max -add -clock $cmn_ref_clk0 [get_ports cmn_ref_clk0_bscan_tdi]
#   set_output_delay $bscan_outdly -max -add -clock $cmn_ref_clk0 [get_ports cmn_ref_clk0_bscan_tdo]


#######################################
# Feedthrough Overrides 
#######################################


###############################################################################
# Input Driving Cells
###############################################################################
set_driving_cell -lib_cell $::DRIVING_CELL -pin $::DRIVING_PIN $digital_input_port_collection


###############################################################################
# Output Port Loading
###############################################################################
set_load 0.020 $digital_output_port_collection


###############################################################################
# Don't Use/Touch
###############################################################################
# Power & Ground Connections
if { [info exists load_syn_sdc] && $load_syn_sdc} {
} else {
set_dont_touch [get_nets $power_ground_port_list]
}
# Cmn_ana connections that must remain pure from/to their respective pma_cmn I/O ports.
set_dont_touch [get_nets $analog_port_list]


###############################################################################
# Timing Exceptions
###############################################################################
# Synthesis (pre-mapped)
if { $load_syn_sdc && !$load_post_map_syn_sdc } {

# P&R
} else {
   # Set false paths to first flop in reset_sync logic.
   set_false_path -to [get_pins -hier *genblk1_u_reset_sync_synth_*_1/D]
   # Set false paths to first flop in data_sync logic.
   set_false_path -to [get_pins -hier *genblk1_genblk1_u_data_sync_synth_*_1/D]
    # Loren confirmed that both reset_sync flops get asynchronous resets.
    set_false_path -to [get_pins -hier *genblk1_u_reset_sync_synth_*_*/CD]
#    # False path all paths to SI pins.
#    set si_pin_collection [get_pins -of [all_registers] -filter {name == SI}]
#    set_false_path -from [all_clocks] -to $si_pin_collection
    # False paths to/from macro_id ports since they are static (tied-off).
    set macro_id_input_ports  [get_ports *macro_id* -filter {direction == in}]
    set macro_id_output_ports [get_ports *macro_id* -filter {direction == out}]
    set_false_path -from $macro_id_input_ports
    set_false_path -to   $macro_id_output_ports
}

#TODO for PR. for stable 
### Multicycle paths
# Following can be multi-cycled as sources are only used for overrides, capture clocks will be stopped for at least 3-4 cycles per Loren
# u_cmn_ctrl/u_cmn_cdiag_ovrd/u_cmn_cdiag_ovrd_cdb_regs/cmn_cdiag_xcvrc_pwri_ovrd_reg_reg[14]/Q -> xcvrc_isl_power_isolation_en_<l,r>
#set_multicycle_path -setup 3 \
#    -through [get_pins u_cmn_ctrl/u_cmn_cdiag_ovrd/u_cmn_cdiag_ovrd_cdb_regs/cmn_cdiag_xcvrc_pwri_ovrd_reg_reg[*]/Q] \
#    -through [get_ports xcvrc_isl_power_isolation_en_l]
#set_multicycle_path -hold 2 \
#    -through [get_pins u_cmn_ctrl/u_cmn_cdiag_ovrd/u_cmn_cdiag_ovrd_cdb_regs/cmn_cdiag_xcvrc_pwri_ovrd_reg_reg[*]/Q] \
#    -through [get_ports xcvrc_isl_power_isolation_en_l]
#set_multicycle_path -setup 3 \
#    -through [get_pins u_cmn_ctrl/u_cmn_cdiag_ovrd/u_cmn_cdiag_ovrd_cdb_regs/cmn_cdiag_xcvrc_pwri_ovrd_reg_reg[*]/Q] \
#    -through [get_ports xcvrc_isl_power_isolation_en_r]
#set_multicycle_path -hold 2 \
#    -through [get_pins u_cmn_ctrl/u_cmn_cdiag_ovrd/u_cmn_cdiag_ovrd_cdb_regs/cmn_cdiag_xcvrc_pwri_ovrd_reg_reg[*]/Q] \
#    -through [get_ports xcvrc_isl_power_isolation_en_r]
## u_cmn_ctrl/u_cmn_cdiag_ovrd/u_cmn_cdiag_ovrd_cdb_regs/cmn_cdiag_diag_pwri_ovrd_reg_reg[14]/Q -> diag_isl_power_isolation_en_l
#set_multicycle_path -setup 3 \
#    -through [get_pins u_cmn_ctrl/u_cmn_cdiag_ovrd/u_cmn_cdiag_ovrd_cdb_regs/cmn_cdiag_diag_pwri_ovrd_reg_reg[*]/Q] \
#    -through [get_ports diag_isl_power_isolation_en_l]
#set_multicycle_path -hold 2 \
#    -through [get_pins u_cmn_ctrl/u_cmn_cdiag_ovrd/u_cmn_cdiag_ovrd_cdb_regs/cmn_cdiag_diag_pwri_ovrd_reg_reg[*]/Q] \
#    -through [get_ports diag_isl_power_isolation_en_l]
#set_multicycle_path -setup 3 \
#    -through [get_pins u_cmn_ctrl/u_cmn_cdiag_ovrd/u_cmn_cdiag_ovrd_cdb_regs/cmn_cdiag_diag_pwri_ovrd_reg_reg[*]/Q] \
#    -through [get_ports diag_isl_power_isolation_en_r]
#set_multicycle_path -hold 2 \
#    -through [get_pins u_cmn_ctrl/u_cmn_cdiag_ovrd/u_cmn_cdiag_ovrd_cdb_regs/cmn_cdiag_diag_pwri_ovrd_reg_reg[*]/Q] \
#    -through [get_ports diag_isl_power_isolation_en_r]


###############################################################################
# Ideal Networks (before P&R)
###############################################################################
if { $::timeMode == "ideal" } {
    # Synthesis post-mapped or P&R.
    if { ($load_syn_sdc && $load_post_map_syn_sdc) || !$load_syn_sdc } {
        #set_ideal_network [get_pins u_cmn_clkrst/u_reset_sync_cmn_cdb_preset/u_scan_mux/mux_47_28_g1/Y ]
    }
}


###############################################################################
# Clock Latency REsePropagation
###############################################################################
if { !$load_syn_sdc && $::timeMode == "prop" } {
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

