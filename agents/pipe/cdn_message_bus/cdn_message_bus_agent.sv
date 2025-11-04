//------------------------------------------------------------------------------
//
//   Filename:           cdn_message_bus_agent.sv
//   Module Name:        cdn_message_bus_agent
//
//   Release Revision:   1.0
//
//   Product Type:       Configurable
//   Protocol:           PIPE
//   Architecture:       PHY
//
//------------------------------------------------------------------------------
// Description: 
// This file defines the agent for the cdn_meassage_bus UVC.
//----------------------------------------------------------------------------
`ifndef CDN_MESSAGE_BUS_AGENT_SV
`define CDN_MESSAGE_BUS_AGENT_SV

class cdn_message_bus_agent extends cdn_phy_agent_base;
  //------------------------------------------------------------------------
  // CONTROL MEMBER VARIABLES.
  //------------------------------------------------------------------------

  // This member variable controls if the Module UVC env is active or 
  // passive i.e. is it a stand alone module level env - UVM_ACTIVE or
  // is it part of a system/sub-system level env - UVM_PASSIVE.
  protected uvm_active_passive_enum is_active = UVM_ACTIVE;
  uvm_tlm_analysis_fifo #(cdn_message_bus_transaction) mon2drv_fifo[tb_param :: USB4_LANE_NUM];
  uvm_tlm_analysis_fifo #(cdn_message_bus_transaction) drv2mon_fifo[tb_param :: USB4_LANE_NUM];
  string report_id = "CDN_MESSAGE_BUS_AGENT_C";
  //------------------------------------------------------------------------
  // COMPONENTS.
  //------------------------------------------------------------------------

  cdn_message_bus_driver    message_bus_drv[tb_param :: USB4_LANE_NUM];
  cdn_message_bus_sequencer message_bus_sqr[tb_param :: USB4_LANE_NUM];
  cdn_message_bus_monitor   message_bus_mon[tb_param :: USB4_LANE_NUM];
  cdn_phy_vif_t  pipe_agt_if[tb_param :: USB4_LANE_NUM];
  //------------------------------------------------------------------------
  // UVM AUTOMATION MACROS.
  //------------------------------------------------------------------------
  // The component utils marco provides base virtual methods like 
  // get_type_name and create.
  `uvm_component_utils_begin(cdn_message_bus_agent)
    //  `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
    //  `uvm_field_object( driver,   UVM_REFERENCE)
        //  `uvm_field_real   ( rx_bit_multi_clk_div, UVM_ALL_ON )
    //  `uvm_field_real   ( tx_bit_multi_clk_div, UVM_ALL_ON )
    //  `uvm_field_real   ( jtag_tck_clk_div, UVM_ALL_ON )
  `uvm_component_utils_end

  //------------------------------------------------------------------------
  // EXTEND OR OVERRIDE BASE METHODS
  //------------------------------------------------------------------------

  // Extend the new method
  function new (string name="cdn_message_bus_agent", uvm_component parent);
      super.new(name, parent);
  endfunction : new

  // Extend the build_phase method to create the monitor and driver.
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	`uvm_info(report_id,$sformatf("Starting of _%s_",phase.get_name()),UVM_LOW)
  for(int i = 0; i < tb_param::USB4_LANE_NUM; i++) begin //set interface
   if(!uvm_config_db#(cdn_phy_vif_t)::get(this, "",$psprintf("m_agt_if[%0d]",i),pipe_agt_if[i])) begin
        `uvm_fatal(get_full_name(), "No virtual interface specified for this agent instance")
      end
  end
  for(int i = 0; i < tb_param::USB4_LANE_NUM; i++) begin //set interface
    message_bus_drv[i] = cdn_message_bus_driver::type_id::create($psprintf("message_bus_drv[%0d]",i), this);
    message_bus_sqr[i] = cdn_message_bus_sequencer::type_id::create($psprintf("message_bus_sqr[%0d]",i),this);
	message_bus_mon[i] = cdn_message_bus_monitor::type_id::create($psprintf("message_bus_mon[%0d]",i),this);
	mon2drv_fifo[i]        = new($psprintf("mon2drv_fifo[%0d]",i),this);
	drv2mon_fifo[i]        = new($psprintf("drv2mon_fifo[%0d]",i),this);
  end
  for(int i = 0; i < tb_param::USB4_LANE_NUM; i++) begin //set interface
   uvm_config_db# (cdn_phy_vif_t)::set(this,$psprintf("message_bus_drv[%0d]",i),"m_drv_if",pipe_agt_if[i]);
   uvm_config_db# (cdn_phy_vif_t)::set(this,$psprintf("message_bus_mon[%0d]",i),"m_mon_if",pipe_agt_if[i]);
  end

	`uvm_info(report_id,$sformatf("Ending of _%s_",phase.get_name()),UVM_LOW)
  endfunction : build_phase

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

   `uvm_info(report_id,$sformatf("Starting of _%s_",phase.get_name()),UVM_LOW)
    //uvm_top.print_topology();  
   //Connection of driver seq item pull port to sequencer pull export
for(int i = 0; i < tb_param::USB4_LANE_NUM; i++) begin
   message_bus_drv[i].seq_item_port.connect(message_bus_sqr[i].seq_item_export);
  //connection of monitor to driver item port 
   message_bus_mon[i].mon_trans_ap.connect(mon2drv_fifo[i].analysis_export);
   message_bus_drv[i].mon_trans_imp.connect(mon2drv_fifo[i].blocking_get_export);
  //connection of driver to monitor item port
   message_bus_drv[i].drv_trans_ap.connect(drv2mon_fifo[i].analysis_export);
   message_bus_mon[i].drv_trans_imp.connect(drv2mon_fifo[i].blocking_get_export);
end
   `uvm_info(report_id,$sformatf("Ending of _%s_",phase.get_name()),UVM_LOW)
  endfunction:connect_phase

endclass : cdn_message_bus_agent

`endif

//----------------------------------------------------------------------------
// End of file
//----------------------------------------------------------------------------
