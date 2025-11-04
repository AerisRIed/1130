//********************************************************
//* Cadence.
//*
//*Author                   : chao.huang 
//*Email                    : chaoh@cadence.com
//*Filename                 : cdn_u4_usb4_agent.sv
//*Description  :                                         
//
//
//--------------------------------------------------------
//* Date	          Modified By		   Reason
//2025-06-13 03:14
//
//--------------------------------------------------------
//*******************************************************
class cdn_u4_usb4_agent extends cdn_phy_agent_base;

    //------------------------------------
    // Member                             
    //------------------------------------
    cdn_u4_usb4_driver                  usb4_drv[tb_param :: USB4_LANE_NUM];
    cdn_u4_usb4_monitor                 usb4_mon[tb_param :: USB4_LANE_NUM];
    cdn_u4_usb4_config                  usb4_cfg;
    cdn_u4_usb4_sequencer               usb4_sqr;
    cdn_u4_usb4_ltssm_control           usb4_ltssm_control;
    cdn_u4_usb4_ltssm_operation         usb4_ltssm_operation;
	cdn_u4_usb4_port_status             port_status;
    cdn_u4_usb4_physical_timer_cfg      timer_cfg;
    
    serdes_tx_model                      m_serdes_tx[tb_param :: USB4_LANE_NUM];
    serdes_rx_model                      m_serdes_rx[tb_param :: USB4_LANE_NUM];
    serdes_cfg                           m_serdes_cfg[tb_param :: USB4_LANE_NUM];  
    
   // cdn_phy_vif_t usb4_agt_if[tb_param :: USB4_LANE_NUM]; 
    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_component_utils(cdn_u4_usb4_agent)
     
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "cdn_u4_usb4_agent", uvm_component parent);
        super.new(name,parent);
    endfunction : new

    //------------------------------------
    // Methods 
    //------------------------------------
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern virtual task configure_phase(uvm_phase phase);

endclass : cdn_u4_usb4_agent


/////////////////////////////////////////
// Function : build_phase
//   uvm build_phase
/////////////////////////////////////////
function void cdn_u4_usb4_agent::build_phase(uvm_phase phase);
/*{{{*/
    super.build_phase(phase);
      usb4_cfg     = cdn_u4_usb4_config::type_id::create("usb4_cfg");
      timer_cfg    = new();
      port_status  = new("port_status");
      usb4_sqr    = cdn_u4_usb4_sequencer::type_id::create($psprintf("usb4_sqr"), this);
      usb4_ltssm_operation = cdn_u4_usb4_ltssm_operation::type_id::create($psprintf("usb4_ltssm_operation"), this);
      usb4_ltssm_control  = cdn_u4_usb4_ltssm_control::type_id::create($psprintf("usb4_ltssm_control"), this);
      if (is_active == UVM_ACTIVE) begin //creat handle
        for(int i = 0; i < tb_param :: USB4_LANE_NUM; i++ ) begin
            m_serdes_cfg[i] = serdes_cfg::type_id::create($psprintf("m_serdes_cfg[%0d]",i),this);
            usb4_drv[i] = cdn_u4_usb4_driver::type_id::create($psprintf("usb4_drv[%0d]",i), this);
            usb4_mon[i] = cdn_u4_usb4_monitor::type_id::create($psprintf("usb4_mon[%0d]",i), this);
            usb4_drv[i].lane_id = i;
            usb4_mon[i].lane_id = i;
            //usb4_sqr[i] = cdn_u4_usb4_sequencer::type_id::create($psprintf("usb4_sqr[%0d]",i), this);
            //usb4_ltssm_operation[i] = cdn_u4_usb4_ltssm_operation::type_id::create($psprintf("usb4_ltssm_operation[%0d]",i), this);
            //usb4_ltssm_control[i] = cdn_u4_usb4_ltssm_control::type_id::create($psprintf("usb4_ltssm_control[%0d]",i), this);
            m_serdes_tx[i] = serdes_tx_model::type_id::create($psprintf("m_serdes_tx[%0d]",i),this);
            m_serdes_rx[i] = serdes_rx_model::type_id::create($psprintf("m_serdes_rx[%0d]",i),this);
            `uvm_info(get_full_name(), $psprintf("usb4_mon[%0d] created!",i),UVM_LOW);
            `uvm_info(get_full_name(), $psprintf("usb4_ltssm_operation[%0d] created!",i),UVM_LOW);
            `uvm_info(get_full_name(), $psprintf("usb4_drv[%0d] created!",i),UVM_LOW);
        end
      end
        for(int i = 0; i < tb_param :: USB4_LANE_NUM; i++ ) begin //set interface
            //if (!uvm_config_db#(cdn_phy_vif_t)::get(this, "", $psprintf("usb4_if[%0d]",i),usb4_agt_if[i])) begin
            //    `uvm_fatal("AGT/NO cdn_phy_vif_t", "No virtual interface specified for this agent instance")
            //end
            `uvm_info(get_full_name(), $psprintf("usb4_drv[%0d] set interface",i),UVM_LOW);
            `uvm_info(get_full_name(), $psprintf("usb4_mon[%0d] set interface",i),UVM_LOW);
            uvm_config_db# (cdn_phy_vif_t)::set(this,$psprintf("usb4_drv[%0d]",i),"m_drv_if",pipe_agt_if[i]);
            uvm_config_db# (cdn_phy_vif_t)::set(this,$psprintf("usb4_mon[%0d]",i),"m_mon_if",pipe_agt_if[i]);
        end
endfunction : build_phase /*}}}*/
/////////////////////////////////////////
// Function : connect_phase
//   uvm connect_phase
/////////////////////////////////////////
function void cdn_u4_usb4_agent::connect_phase(uvm_phase phase);
  // super.connect_phase(phase);
   if (is_active == UVM_ACTIVE) begin
      usb4_ltssm_operation.symbol_pattern.m_cfg     = this.usb4_cfg;
      usb4_ltssm_operation.m_ltssm_ctrl             = this.usb4_ltssm_control;
      usb4_ltssm_operation.m_cfg                    = this.usb4_cfg;
      usb4_ltssm_control.m_cfg                      = this.usb4_cfg;
      usb4_ltssm_control.port_status                = this.port_status;
      usb4_ltssm_operation.port_status              = this.port_status;
      usb4_sqr.port_status                          = this.port_status;
      usb4_ltssm_control.ltssm_instruction_port.connect(usb4_sqr.seq_item_export);
     for(int i = 0; i < tb_param :: USB4_LANE_NUM; i++ ) begin
        usb4_drv[i].m_cfg                             = this.usb4_cfg;
        usb4_ltssm_operation.m_vif[i]                 = this.pipe_agt_if[i];
        usb4_drv[i].m_vif                             = this.pipe_agt_if[i];
        usb4_ltssm_control.m_vif[i]                   = this.pipe_agt_if[i];
        usb4_mon[i].m_vif                             = this.pipe_agt_if[i];
        usb4_mon[i].m_cfg                             = this.usb4_cfg;
        usb4_mon[i].timer_cfg                         = this.timer_cfg;
        usb4_mon[i].port_status                       = this.port_status;
        usb4_sqr.port_status                          = this.port_status;
        usb4_drv[i].timer_cfg                         = this.timer_cfg;
        usb4_ltssm_operation.sym_gen_stim_ap.connect(usb4_drv[i].cdn_u4_usb4_symbol_export_ep);
     end
        foreach(m_serdes_tx[i]) begin
            m_serdes_tx[i].m_vif = pipe_agt_if[i].serdes_tx;
            m_serdes_tx[i].m_cfg = m_serdes_cfg[i];
        end
        foreach(m_serdes_rx[i]) begin
            m_serdes_rx[i].m_vif = pipe_agt_if[i].serdes_rx;
            m_serdes_rx[i].m_cfg = m_serdes_cfg[i];
        end
        m_serdes_cfg[1].latency = 0;//TODO need to random to satisfied with USB4 Spec
   end
endfunction

task cdn_u4_usb4_agent::configure_phase (uvm_phase phase);
  super.configure_phase(phase);
  //ToDo: Configure components here
     for(int i = 0; i < tb_param :: USB4_LANE_NUM; i++ ) begin
        if(usb4_cfg.usb4_gen_speed == GEN2_SPEED) begin
          m_serdes_cfg[i].set_default(0.1ns,32,PAM2);
        end else begin
          m_serdes_cfg[i].set_default(0.05ns,32,PAM2);
        end
     end
endtask:configure_phase

