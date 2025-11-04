//********************************************************
//* Cadence.
//*
//*Author                   : chao.huang 
//*Email                    : chaoh@cadence.com
//*Filename                 : clk_env.sv
//*Description  :                                         
//
//
//--------------------------------------------------------
//* Date	          Modified By		   Reason
//2025-05-22 02:16
//
//--------------------------------------------------------
//*******************************************************
class env extends uvm_env; 
    /*{{{*/
    
    
    //---------------------------------------
    // Member
    //---------------------------------------
    clk_agent           m_clk_agent;
    
    
    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_component_utils(env)
    
    
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new(string name = "env", uvm_component parent);
        super.new(name, parent);
    endfunction : new
    
    
    //---------------------------------------
    // Methods 
    //---------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_clk_agent = clk_agent::type_id::create("m_clk_agent", this);
    endfunction : build_phase
    
endclass : env /*}}}*/

