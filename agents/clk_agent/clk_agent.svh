//********************************************************
//* Cadence.
//*
//*Author                   : chao.huang 
//*Email                    : chaoh@cadence.com
//*Filename                 : clk_agent.svh
//*Description  :                                         
//
//
//--------------------------------------------------------
//* Date	          Modified By		   Reason
//2025-05-22 01:47
//
//--------------------------------------------------------
//*******************************************************
class clk_agent extends uvm_agent;

    //---------------------------------------
    // Member
    //---------------------------------------
    clk_vif_t    m_vif;
    clk_cfg_t    m_cfg;
    clk_driver_t m_driver;
    clk_sqr_t    m_sqr;

    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_component_utils(clk_agent)
     
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "clk_agent", uvm_component parent);
        super.new(name,parent);
    endfunction : new

    //---------------------------------------
    // Methods 
    //---------------------------------------
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern function void config_out_sqr(string clk_sqr_name);

endclass : clk_agent

/////////////////////////////////////////
// Function : build_phase
//   uvm build_phase
/////////////////////////////////////////
function void clk_agent::build_phase(uvm_phase phase);
/*{{{*/
    super.build_phase(phase);

    // get config
    if(!uvm_config_db#(clk_cfg_t)::get(this, "*", "clk_cfg_t", m_cfg)) begin
        `uvm_info(get_name(), "No config set for : clk_cfg", UVM_NONE);
        m_cfg = clk_cfg_t::type_id::create("m_cfg");
        m_cfg.set_default_config();
    end

    // get interface
    if(!uvm_config_db#(clk_vif_t)::get(this, "*", "m_vif", m_vif))
        `uvm_info(get_name(), "No interface set for : m_vif", UVM_NONE);

    // create component
    if( UVM_ACTIVE == get_is_active() ) begin
        m_driver = clk_driver_t::type_id::create("m_driver", this);
        m_driver.m_cfg = this.m_cfg;
        m_driver.m_vif = this.m_vif;
        m_sqr    = clk_sqr_t::type_id::create("m_sqr", this);
    end
    
    config_out_sqr(m_cfg.seqr_name);

endfunction : build_phase /*}}}*/

/////////////////////////////////////////
// Function : connect_phase
//   uvm connect_phase
/////////////////////////////////////////
function void clk_agent::connect_phase(uvm_phase phase);
/*{{{*/
    super.connect_phase(phase);
    if(get_is_active() == UVM_ACTIVE) begin
        m_driver.seq_item_port.connect(m_sqr.seq_item_export);
    end
endfunction : connect_phase /*}}}*/

/////////////////////////////////////////
// Function : config_out_sqr
//   using uvm_config_db to config out sqr
// Input : clk_sqr_name
// Output: Void
/////////////////////////////////////////
function void clk_agent::config_out_sqr(string clk_sqr_name);
/*{{{*/
    if( UVM_ACTIVE == get_is_active() ) begin 
        uvm_config_db#(clk_sqr_t)::set(uvm_root::get(), "*", clk_sqr_name, m_sqr);
    end
endfunction : config_out_sqr /*}}}*/
