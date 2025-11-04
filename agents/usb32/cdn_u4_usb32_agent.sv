//********************************************************
//* Cadence.
//*
//*Author                   : chao.huang 
//*Email                    : chaoh@cadence.com
//*Filename                 : cdn_u4_usb32_agent.sv
//*Description  :                                         
//
//
//--------------------------------------------------------
//* Date	          Modified By		   Reason
//2025-06-13 03:14
//
//--------------------------------------------------------
//*******************************************************
class cdn_u4_usb32_agent extends cdn_phy_agent_base;

    //------------------------------------
    // Member                             
    //------------------------------------
    cdn_u4_usb32_driver                  usb32_drv[tb_param :: USB32_LANE_NUM];
    cdn_u4_usb32_monitor                 usb32_mon[tb_param :: USB32_LANE_NUM];
    cdn_u4_usb32_config                  usb32_cfg;
    cdn_u4_usb32_sequencer               usb32_sqr;
    cdn_u4_usb32_ltssm_control           usb32_ltssm_control;
    cdn_u4_usb32_ltssm_operation         usb32_ltssm_operation;
	cdn_u4_usb32_port_status             port_status;
    cdn_u4_usb32_physical_timer_cfg      timer_cfg;
    
    serdes_tx_model                      m_serdes_tx[tb_param :: USB32_LANE_NUM];
    serdes_rx_model                      m_serdes_rx[tb_param :: USB32_LANE_NUM];
    serdes_cfg                           m_serdes_cfg[tb_param :: USB32_LANE_NUM];  
    
   // cdn_phy_vif_t usb32_agt_if[tb_param :: USB32_LANE_NUM]; 
    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_component_utils(cdn_u4_usb32_agent)
     
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "cdn_u4_usb32_agent", uvm_component parent);
        super.new(name,parent);
    endfunction : new

    //------------------------------------
    // Methods 
    //------------------------------------
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task configure_phase(uvm_phase phase);

endclass : cdn_u4_usb32_agent


/////////////////////////////////////////
// Function : build_phase
//   uvm build_phase
/////////////////////////////////////////
function void cdn_u4_usb32_agent::build_phase(uvm_phase phase);
/*{{{*/
    super.build_phase(phase);
      usb32_cfg     = cdn_u4_usb32_config::type_id::create("usb32_cfg");
      timer_cfg    = new();
      port_status  = new("port_status");
      usb32_sqr    = cdn_u4_usb32_sequencer::type_id::create($psprintf("usb32_sqr"), this);
      usb32_ltssm_operation = cdn_u4_usb32_ltssm_operation::type_id::create($psprintf("usb32_ltssm_operation"), this);
      usb32_ltssm_control  = cdn_u4_usb32_ltssm_control::type_id::create($psprintf("usb32_ltssm_control"), this);
      if (is_active == UVM_ACTIVE) begin //creat handle
        for(int i = 0; i < tb_param :: USB32_LANE_NUM; i++ ) begin
            m_serdes_cfg[i] = serdes_cfg::type_id::create($psprintf("m_serdes_cfg[%0d]",i),this);
            usb32_drv[i] = cdn_u4_usb32_driver::type_id::create($psprintf("usb32_drv[%0d]",i), this);
            usb32_drv[i].lane_id = i;
            usb32_mon[i] = cdn_u4_usb32_monitor::type_id::create($psprintf("usb32_mon[%0d]",i), this);
            usb32_mon[i].lane_id = i;
            //usb32_sqr[i] = cdn_u4_usb32_sequencer::type_id::create($psprintf("usb32_sqr[%0d]",i), this);
            //usb32_ltssm_operation[i] = cdn_u4_usb32_ltssm_operation::type_id::create($psprintf("usb32_ltssm_operation[%0d]",i), this);
            //usb32_ltssm_control[i] = cdn_u4_usb32_ltssm_control::type_id::create($psprintf("usb32_ltssm_control[%0d]",i), this);
            m_serdes_tx[i] = serdes_tx_model::type_id::create($psprintf("m_serdes_tx[%0d]",i),this);
            m_serdes_rx[i] = serdes_rx_model::type_id::create($psprintf("m_serdes_rx[%0d]",i),this);
            `uvm_info(get_full_name(), $psprintf("usb32_mon[%0d] created!",i),UVM_LOW);
            `uvm_info(get_full_name(), $psprintf("usb32_ltssm_operation[%0d] created!",i),UVM_LOW);
            `uvm_info(get_full_name(), $psprintf("usb32_drv[%0d] created!",i),UVM_LOW);
        end
      end
        for(int i = 0; i < tb_param :: USB32_LANE_NUM; i++ ) begin //set interface
            //if (!uvm_config_db#(cdn_phy_vif_t)::get(this, "", $psprintf("usb32_if[%0d]",i),usb32_agt_if[i])) begin
            //    `uvm_fatal("AGT/NO cdn_phy_vif_t", "No virtual interface specified for this agent instance")
            //end
            `uvm_info(get_full_name(), $psprintf("usb32_drv[%0d] set interface",i),UVM_LOW);
            `uvm_info(get_full_name(), $psprintf("usb32_mon[%0d] set interface",i),UVM_LOW);
            uvm_config_db# (cdn_phy_vif_t)::set(this,$psprintf("usb32_drv[%0d]",i),"m_drv_if",pipe_agt_if[i]);
            uvm_config_db# (cdn_phy_vif_t)::set(this,$psprintf("usb32_mon[%0d]",i),"m_mon_if",pipe_agt_if[i]);
        end
endfunction : build_phase /*}}}*/
/////////////////////////////////////////
// Function : connect_phase
//   uvm connect_phase
/////////////////////////////////////////
function void cdn_u4_usb32_agent::connect_phase(uvm_phase phase);
  // super.connect_phase(phase);
   if (is_active == UVM_ACTIVE) begin
      usb32_ltssm_operation.symbol_pattern.m_cfg     = this.usb32_cfg;
      usb32_ltssm_operation.m_ltssm_ctrl             = this.usb32_ltssm_control;
      usb32_ltssm_operation.m_cfg                    = this.usb32_cfg;
      usb32_ltssm_control.m_cfg                      = this.usb32_cfg;
      usb32_ltssm_control.port_status                = this.port_status;
      usb32_ltssm_operation.port_status              = this.port_status;
      usb32_sqr.port_status                          = this.port_status;
      usb32_ltssm_control.ltssm_instruction_port.connect(usb32_sqr.seq_item_export);
     for(int i = 0; i < tb_param :: USB32_LANE_NUM; i++ ) begin
        usb32_drv[i].lane_id                           = i;
        usb32_mon[i].lane_id                           = i;
        usb32_drv[i].m_cfg                             = this.usb32_cfg;
        usb32_ltssm_operation.m_vif[i]                 = this.pipe_agt_if[i];
        usb32_drv[i].m_vif                             = this.pipe_agt_if[i];
        usb32_ltssm_control.m_vif[i]                   = this.pipe_agt_if[i];
        usb32_mon[i].m_vif                             = this.pipe_agt_if[i];
        usb32_mon[i].m_cfg                             = this.usb32_cfg;
        usb32_mon[i].timer_cfg                         = this.timer_cfg;
        usb32_mon[i].port_status                       = this.port_status;
        usb32_sqr.port_status                          = this.port_status;
        usb32_drv[i].timer_cfg                         = this.timer_cfg;
        usb32_ltssm_operation.sym_gen_stim_ap.connect(usb32_drv[i].cdn_u4_usb32_symbol_export_ep);
     end

    foreach(m_serdes_tx[i]) begin
        m_serdes_tx[i].m_vif = pipe_agt_if[i].serdes_tx;
        m_serdes_tx[i].m_cfg = m_serdes_cfg[i];
    end
    foreach(m_serdes_rx[i]) begin
        m_serdes_rx[i].m_vif = pipe_agt_if[i].serdes_rx;
        m_serdes_rx[i].m_cfg = m_serdes_cfg[i];
    end
    if(tb_cfg.std_mode != ALT_MODE) begin
      m_serdes_cfg[1].latency = 0;//TODO need to random to satisfied with USB32 Spec
      usb32_drv[1].m_shared_obj =   usb32_drv[0].m_shared_obj;
    end
 end
endfunction

task cdn_u4_usb32_agent::configure_phase (uvm_phase phase);
  super.configure_phase(phase);
  //ToDo: Configure components here
     for(int i = 0; i < tb_param :: USB32_LANE_NUM; i++ ) begin
        if(usb32_cfg.usb32_gen_speed == GEN1_SPEED) begin
          m_serdes_cfg[i].set_default(0.2ns,40,PAM2);
        end else begin
          m_serdes_cfg[i].set_default(0.1ns,32,PAM2);
        end
     end
endtask:configure_phase

