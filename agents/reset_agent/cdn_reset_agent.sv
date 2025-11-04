//------------------------------------------------------------------------------
// Copyright (c) 2021 Cadence Design Systems, Inc.
//
// The information herein (Cadence IP) contains confidential and proprietary
// information of Cadence Design Systems, Inc. Cadence IP may not be modified,
// copied, reproduced, distributed, or disclosed to third parties in any manner,
// medium, or form, in whole or in part, without the prior written consent of
// Cadence Design Systems Inc. Cadence IP is for use by Cadence Design Systems,
// Inc. customers only. Cadence Design Systems, Inc. reserves the right to make
// changes to Cadence IP at any time and without notice.
//------------------------------------------------------------------------------
//
//   Filename:           cdn_reset_agent.sv
//   Module Name:        cdn_reset_agent.sv
//
//   Release Revision:   1.0
//
//   Product Type:       Configurable
//   IP Type:            Soft IP
//   IP Family:          Storage
//   Technology:         N/A
//   Protocol:           ONFi5.0
//   Architecture:       PHY
//
//------------------------------------------------------------------------------
// Description :
// This file contains the detailed description of the cdn_reset UVC agent.
//----------------------------------------------------------------------------

`ifndef CDN_RESET_AGENT_SV
`define CDN_RESET_AGENT_SV

class cdn_reset_agent extends uvm_agent;

    //------------------------------------------------------------------------
    // MEMBER VARIABLES.
    //------------------------------------------------------------------------


    //------------------------------------------------------------------------
    // CONTROL MEMBER VARIABLES.
    //------------------------------------------------------------------------

    // This member variable controls if the agent is active or passive.
    cdn_phy_vif_t  				pipe_agt_if[tb_param :: MAX_LANE_NUM]; // for pipe reset
    virtual cdn_reset_if 		phy_rst_if; // only for phy reset
    cdn_reset_config 			m_cfg; 		
    int                   lane_num;
    alt_mode_t            alt_mode;
    //------------------------------------------------------------------------
    // COMPONENTS.
    //------------------------------------------------------------------------

    cdn_reset_driver driver[tb_param :: MAX_LANE_NUM];
    cdn_reset_sequencer sequencer[tb_param :: MAX_LANE_NUM];
    //cdn_reset_monitor monitor;

    //------------------------------------------------------------------------
    // UVM AUTOMATION MACROS.
    //------------------------------------------------------------------------

    // The component utils marco provides base virtual methods like 
    // get_type_name and create.
    `uvm_component_utils_begin(cdn_reset_agent)
    `uvm_component_utils_end

    //------------------------------------------------------------------------
    // EXTEND OR OVERRIDE BASE METHODS
    //------------------------------------------------------------------------

    // Extend the new method
    function new (string name, uvm_component parent);
        super.new(name, parent);
		m_cfg = new();
    endfunction : new

    // Extend the build_phase method to create the monitor (for both active 
    // and passive agents) and create the sequencer and driver for the active
    // agent instance.
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
	  // get configs
	  //m_cfg = cdn_reset_config::type_id::create("m_cfg");
	  // get phy reset inf 
	    if(!uvm_config_db#(virtual cdn_reset_if)::get(this, "", $psprintf("phy_reset_if"),phy_rst_if)) begin
        `uvm_fatal(get_full_name(), "No phy reset interface specified for this agent instance")
      end

    `ifdef ALT_MODE
      if (alt_mode == DP) lane_num = tb_param::DP_LANE_NUM;
      else if (alt_mode == USB32) lane_num = tb_param::USB32_LANE_NUM;
      if (alt_mode == DP) begin
         for(int i = 0; i < tb_param::DP_LANE_NUM; i++) begin //set interface
           sequencer[i] = cdn_reset_sequencer::type_id::create($sformatf("sequencer[%0d]",i), this);
           driver[i] = cdn_reset_driver::type_id::create($sformatf("driver[%0d]",i), this);
           driver[i].lane_id = i;
           if(!uvm_config_db#(cdn_phy_vif_t)::get(this, "", $psprintf("dp_if[%0d]",i),pipe_agt_if[i])) begin
             `uvm_fatal("", $psprintf("No virtual interface specified for this agent instance[%0d]",i))
           end 
           uvm_config_db# (cdn_phy_vif_t)::set(this,$psprintf("driver[%0d]",i),$psprintf("m_drv_if"),pipe_agt_if[i]);
           uvm_config_db# (virtual cdn_reset_if)::set(this,$psprintf("driver[%0d]",i),"phy_reset_if",phy_rst_if);
	         uvm_config_db# (cdn_reset_config)::set(this,$psprintf("driver[%0d]",i),"m_cfg",m_cfg);
         end 
      end else if (alt_mode == USB32) begin 
        for(int i = 0; i < tb_param::USB32_LANE_NUM; i++) begin //set interface
          sequencer[i] = cdn_reset_sequencer::type_id::create($sformatf("sequencer[%0d]",i), this);
          driver[i] = cdn_reset_driver::type_id::create($sformatf("driver[%0d]",i), this);
          driver[i].lane_id = i;
          if(!uvm_config_db#(cdn_phy_vif_t)::get(this, "", $psprintf("usb32_if[%0d]",i),pipe_agt_if[i])) begin
            `uvm_fatal("", $psprintf("No virtual interface specified for this agent instance[%0d]",i))
          end 
          uvm_config_db# (cdn_phy_vif_t)::set(this,$psprintf("driver[%0d]",i),$psprintf("m_drv_if"),pipe_agt_if[i]);
          uvm_config_db# (virtual cdn_reset_if)::set(this,$psprintf("driver[%0d]",i),"phy_reset_if",phy_rst_if);
          uvm_config_db# (cdn_reset_config)::set(this,$psprintf("driver[%0d]",i),"m_cfg",m_cfg);
        end
      end
    `else 
      if (m_cfg.dp_enable) lane_num = tb_param::DP_LANE_NUM;
      else                 lane_num = tb_param::USB32_LANE_NUM;
      for(int i = 0; i < lane_num; i++) begin //set interface
	    sequencer[i] = cdn_reset_sequencer::type_id::create($sformatf("sequencer[%0d]",i), this);
        driver[i] = cdn_reset_driver::type_id::create($sformatf("driver[%0d]",i), this);
	    driver[i].lane_id = i;
        if(!uvm_config_db#(cdn_phy_vif_t)::get(this, "", $psprintf("m_agt_if[%0d]",i),pipe_agt_if[i])) begin
          `uvm_fatal("", $psprintf("No virtual interface specified for this agent instance[%0d]",i))
        end 
        uvm_config_db# (cdn_phy_vif_t)::set(this,$psprintf("driver[%0d]",i),$psprintf("m_drv_if"),pipe_agt_if[i]);
        uvm_config_db# (virtual cdn_reset_if)::set(this,$psprintf("driver[%0d]",i),"phy_reset_if",phy_rst_if);
	    uvm_config_db# (cdn_reset_config)::set(this,$psprintf("driver[%0d]",i),"m_cfg",m_cfg);
      end
    `endif
    endfunction : build_phase

    // Extend the connect_phase method to connect the TLM port between the
    // sequencer and the driver.
    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
	  for(int i = 0; i < lane_num; i++) begin
        driver[i].seq_item_port.connect(sequencer[i].seq_item_export);
	  end
    endfunction : connect_phase

endclass : cdn_reset_agent

`endif

//----------------------------------------------------------------------------
// End of file
//----------------------------------------------------------------------------
