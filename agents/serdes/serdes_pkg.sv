package serdes_pkg;

    import uvm_pkg::*;
    import tb_param::*;
    `include "uvm_macros.svh"

    timeunit 1ns;
    timeprecision 1fs;  // need change for other rate 


    //-----------define--------------//
    parameter OVER_SAMPLE_PERCENT = 0.006;//0.04;
    parameter ALL_0_1_DIS_EN      = 0; // if one cycle of pd to be all "0"/"1", break serdes loop
    parameter LFPS_DET_EN = 1;
    parameter TX_JITTER_EN = 0;
    parameter TX_SSC_EN = 0;
    parameter COMPENSATE = 0;
    
    parameter real JITTER_SKEW = 0.0000003; //300ppm

    parameter EN_GIVE_ONE_MORE_CLK_AFTER_EI = 0;

    parameter PD_MAX_WIDTH = 64;
    parameter PD_BUF_DEEP = 2;

    parameter LFPS_MIN_PERIOD = 8; //20*40% half of 20
    parameter LFPS_MAX_PERIOD = 60; //100*60% half of 80

    parameter bit[1:0] TX_SD_IDLE_MODE = 2'b10;// 0->0, 1->1, 2->z

    parameter real BAUD_RATE = 25.6;//25.6 for USB4 GEN4 PAM3
    
    //-----------serdes debug tx/rx real type VOL--------------//
    parameter real TRI_VOL_2 = 2;
    parameter real TRI_VOL_1 = 1;
    parameter real TRI_VOL_0 = 0;
    
    //-----------serdes tx/rx type VOL for analog mapping--------------//
    parameter bit [1:0]TRI_VOL_2_P = 1;
    parameter bit [1:0]TRI_VOL_2_N = 0;
    
    parameter bit [1:0]TRI_VOL_1_P = 0;
    parameter bit [1:0]TRI_VOL_1_N = 0;
    
    parameter bit [1:0]TRI_VOL_0_P = 0;
    parameter bit [1:0]TRI_VOL_0_N = 1;

    parameter bit[1:0] TRI_VOL_0_PD = 2'b00;
    parameter bit[1:0] TRI_VOL_1_PD = 2'b01;
    parameter bit[1:0] TRI_VOL_2_PD = 2'b11;
    
    typedef virtual serdes_if #(.PD_WIDTH(tb_param::SERDES_WIDTH)) serdes_vif;


	typedef enum {
        PAM2,
        PAM3,
        PAM4
	}e_pam_type;
    
    
    
    //------------object------------//
    `include "serdes_cfg.sv"

    //-----------component----------//
    `include "serdes_rx_model.sv"
    `include "serdes_tx_model.sv"

endpackage : serdes_pkg


