//********************************************************
//* Cadence.
//*
//*Author                   : chao.huang 
//*Email                    : chaoh@cadence.com
//*Filename                 : clk_pkg.sv
//*Description  :                                         
//
//
//--------------------------------------------------------
//* Date	          Modified By		   Reason
//2025-05-22 01:44
//
//--------------------------------------------------------
//*******************************************************
package clk_pkg;

    timeunit 1ns;
    timeprecision 1fs;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
 
    import tb_param::*;
    import clk_if_pkg::*;

    parameter CLK_JITTER_DEFAULT_EN = 0;
    parameter real CLK_JITTER_PERCENT    = 0.3;  
    parameter INI_PERIOD_HIGH_LIMIT = 5000;
    parameter INI_PERIOD_LOW_LIMIT  = 2000;
    parameter PPM =1000000;
    parameter CLK_CALC_NUM = 12;


    typedef struct {
       int  clk_index; 
       bit  clk_en;
       real clk_frequency_MHz=10**2; 
       real clk_duty_cycle=0.5;
       bit  set_ini_period_rand=1 ;
    } t_set_one_clk_para;

    typedef struct {
        int  clk_index; 
        bit  clk_en;
        real clk_frequency_MHz=10**2; //base frequency
        real start_freq_Mhz; // the start frequency of SSC,  enabled by set_ini_period_rand, most equal to 99.5% of base frequency
        bit  set_ini_period_rand=0; 
        real delta_frequency_MHz; //the delta of SSC frequency, most equal to 0.5% of base frequency
        real delta_time;     // shall used with accuracy_count, if caculated delta_time is smaller than 1fs, times accuracy_count to 1fs  
        int accuracy_count;  // shall used with delta_time, if caculated delta_time is big than 1fs, accuracy_count set to 0
        bit clk_ssc_en;
        //bit  delta_mode=1;   // default enabled 
    } t_set_one_ssc_clk_para;
    //------------------------
    // Package Contents
    //------------------------
    `include "clk_cfg.svh"
    `include "clk_trans.svh"
    `include "clk_sequencer.svh"
    `include "clk_driver.svh"
    `include "clk_sequence.svh"

    `include "clk_agent.svh"

endpackage: clk_pkg

