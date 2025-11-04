//********************************************************
//* Cadence.
//*
//*Author                   : chao.huang 
//*Email                    : chaoh@cadence.com
//*Filename                 : clk_if.svh
//*Description  :                                         
//
//
//--------------------------------------------------------
//* Date	          Modified By		   Reason
//2025-05-22 01:47
//
//--------------------------------------------------------
//*******************************************************

`timescale 1ns/1fs
interface clk_if #(
    parameter NUM_CLK_EN = 1
)(
);


    logic clk_en[NUM_CLK_EN];
    logic clk_gen[NUM_CLK_EN];
    int accuracy_count[NUM_CLK_EN];

    logic drv_clk_en[NUM_CLK_EN];
    logic drv_clk_gen[NUM_CLK_EN];
    
    real  clk_period[NUM_CLK_EN];
    real  clk_freq[NUM_CLK_EN];

    event trig_change[NUM_CLK_EN];

    assign clk_en  = drv_clk_en;
    assign clk_gen = drv_clk_gen;

    initial begin
        foreach(drv_clk_en[i])
            drv_clk_en[i] = 'b0;
        foreach(drv_clk_gen[i])
            drv_clk_gen[i] = 'bz;
    end
endinterface : clk_if
