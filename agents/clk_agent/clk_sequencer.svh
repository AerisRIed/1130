//********************************************************
//* Cadence.
//*
//*Author                   : chao.huang 
//*Email                    : chaoh@cadence.com
//*Filename                 : clk_sequencer.svh
//*Description  :                                         
//
//
//--------------------------------------------------------
//* Date	          Modified By		   Reason
//2025-05-22 01:45
//
//--------------------------------------------------------
//*******************************************************
class clk_sequencer #(parameter NUM_CLK_EN = 1) extends uvm_sequencer #(clk_trans #(.NUM_CLK_EN(NUM_CLK_EN)));

    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_component_param_utils(clk_sequencer #(.NUM_CLK_EN(NUM_CLK_EN)))
     
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "clk_sequencer", uvm_component parent);
        super.new(name,parent);
    endfunction : new

endclass : clk_sequencer

typedef clk_sequencer#(.NUM_CLK_EN(tb_param::NUM_CLK_EN)) clk_sqr_t;
