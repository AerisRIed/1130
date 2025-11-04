/* ------------------------------------------------------------------------------
--
-- CADENCE Copyright (c) 2025
-- Cadence Design Systems, Inc.
-- All rights reserved.
--
-- 
-- This work may not be copied, modified, re-published, uploaded, executed, or
-- distributed in any way, in any medium, whether in whole or in part, without
-- prior written permission from Cadence Design Systems, Inc.
--------------------------------------------------------------------------------- */

class dut_usb4_tc_noc_env_vsequencer extends uvm_sequencer; 
   
   `uvm_component_utils(dut_usb4_tc_noc_env_vsequencer)
   
   function new(string name="dut_usb4_tc_noc_env_vsequencer", uvm_component parent=null);
      super.new(name,parent);
   endfunction
   
   // CLOCK CONTROL
   // pointer to clock_controller_interface from UVM DB
   virtual interface clock_controller_interface #(
   .CLK_STATUS(0),
   .CLK_INIT_VAL(0),
   .CLK_INIT_DELAY(0), // 0ps
   .CLK_HALFPERIOD(5000) // 5000ps
   ) tap2apb_pclk_vif;

   // CLOCK CONTROL
   // pointer to clock_controller_interface from UVM DB
   virtual interface clock_controller_interface #(
   .CLK_STATUS(0),
   .CLK_INIT_VAL(0),
   .CLK_INIT_DELAY(9), // 9ps
   .CLK_HALFPERIOD(5000) // 5000ps
   ) noc_clk_vif;

   // RESET CONTROL
   // pointer to reset_controller_interface from UVM DB
   virtual interface reset_controller_interface #(
   .RST_KIND(0),
   .RST_INIT_DELAY(8000), // 8000ps
   .NUM_CLKS_ASSERTED(10),
   .DEASSERT_POSITION(0)
   ) rst_n_vif;

   // RESET CONTROL
   // pointer to reset_controller_interface from UVM DB
   virtual interface reset_controller_interface #(
   .RST_KIND(0),
   .RST_INIT_DELAY(8000), // 8000ps
   .NUM_CLKS_ASSERTED(15),
   .DEASSERT_POSITION(0)
   ) apbViprst_n_vif;

   
   reg dont_wait_for_reset[string];
   
   // pointer to the routing model
   dut_usb4_tc_noc_env_routing_model p_routing_model;
   
   
   
   // CLOCK CONTROL
   // internal function retrieving pointer to clock_controller_interface from UVM DB
   function void __internal_get_tap2apb_pclk_vif;
      if ( !uvm_config_db#(virtual interface clock_controller_interface #(
      .CLK_STATUS(0),
      .CLK_INIT_VAL(0),
      .CLK_INIT_DELAY(0), // 0ps
      .CLK_HALFPERIOD(5000) // 5000ps
      ))::get(this, "", "tap2apb_pclk_vif", tap2apb_pclk_vif)) begin
         `uvm_fatal("NOVIF", "Failed to retrieve clock controller interface 'tap2apb_pclk_vif'")
      end
   endfunction

   // CLOCK CONTROL
   // internal function retrieving pointer to clock_controller_interface from UVM DB
   function void __internal_get_noc_clk_vif;
      if ( !uvm_config_db#(virtual interface clock_controller_interface #(
      .CLK_STATUS(0),
      .CLK_INIT_VAL(0),
      .CLK_INIT_DELAY(9), // 9ps
      .CLK_HALFPERIOD(5000) // 5000ps
      ))::get(this, "", "noc_clk_vif", noc_clk_vif)) begin
         `uvm_fatal("NOVIF", "Failed to retrieve clock controller interface 'noc_clk_vif'")
      end
   endfunction

   // RESET CONTROL
   // internal function retrieving pointer to reset_controller_interface from UVM DB
   function void __internal_get_rst_n_vif;
      if ( !uvm_config_db#(virtual interface reset_controller_interface #(
      .RST_KIND(0),
      .RST_INIT_DELAY(8000), // 8000ps
      .NUM_CLKS_ASSERTED(10),
      .DEASSERT_POSITION(0)
      ))::get(this, "", "rst_n_vif", rst_n_vif)) begin
         `uvm_fatal("NOVIF", "Failed to retrieve reset controller interface 'rst_n_vif'")
      end
   endfunction

   // RESET CONTROL
   // internal function retrieving pointer to reset_controller_interface from UVM DB
   function void __internal_get_apbViprst_n_vif;
      if ( !uvm_config_db#(virtual interface reset_controller_interface #(
      .RST_KIND(0),
      .RST_INIT_DELAY(8000), // 8000ps
      .NUM_CLKS_ASSERTED(15),
      .DEASSERT_POSITION(0)
      ))::get(this, "", "apbViprst_n_vif", apbViprst_n_vif)) begin
         `uvm_fatal("NOVIF", "Failed to retrieve reset controller interface 'apbViprst_n_vif'")
      end
   endfunction

   
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
   endfunction
   
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      
      __internal_get_tap2apb_pclk_vif;
      __internal_get_noc_clk_vif;
      __internal_get_rst_n_vif;
      __internal_get_apbViprst_n_vif;

   endfunction

   
   virtual function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      if (p_routing_model == null) 
         `uvm_fatal("NO_PMONITOR", { "p_routing_model left null for '", get_full_name(), "'"})
   endfunction
   

   virtual task wait_for_agent_rst_done(uvm_component agent);
      cdnApbUvmAgent apbAgent;
       virtual interface vip_select_itf sitf;
       string agent_name;
       string vip_select_name;

       if (agent == null) begin
           return;
       end

       agent_name = agent.get_parent().get_name();

       if (dont_wait_for_reset.exists(agent_name)) begin // if configured in CSV wait_for_reset="N", don't wait for reset
           `uvm_info("DONT_WAIT_FOR_RESET", $sformatf("Skipping wait_for_reset agent %s", agent_name), UVM_MEDIUM)
           return;
       end

       vip_select_name = {"vip_", agent_name, "_select"};

       if (!uvm_config_db#(virtual vip_select_itf)::get(null, "*", "vip_select_itf", sitf)) begin
           `uvm_fatal("DYNSWITCHDEBUG", { "No vip_select interface configured for '", agent_name, "'"})
       end

       if (sitf.ports.exists(vip_select_name)) begin
           if (sitf.ports[vip_select_name] == 0) begin // if vip is turned off, don't wait for reset
               return;
           end
       end

      if ($cast(apbAgent, agent)) begin
         `uvm_info("RESET_ENDED", $sformatf("Waiting for agent %s", 
            apbAgent.hdlPath), UVM_MEDIUM)
         apbAgent.monitor.ResetEndedCbEvent.wait_ptrigger();
         `uvm_info("RESET_ENDED", $sformatf("Finished reset for agent %s", 
            apbAgent.hdlPath), UVM_MEDIUM)
         return;
      end

      `uvm_fatal(get_type_name(), "Cast to protocol agent failed")
   endtask
   
   // wait for all agents rst done
   virtual task wait_for_all_agents_rst_done();
      cdn_stg_routing_model_port masters[$];
      cdn_stg_routing_model_port slaves[$];
     
      p_routing_model.get_slaves(slaves);
      foreach (slaves[ii])
         fork
            automatic int kk = ii;
            begin            
               wait_for_agent_rst_done(slaves[kk].p_agents[0]);
            end
            begin
               wait_for_agent_rst_done(slaves[kk].p_ext_agents[0]);
            end
         join_none

      p_routing_model.get_masters(masters);

      foreach (masters[ii])
         fork
            automatic int kk = ii;
            begin
               wait_for_agent_rst_done(masters[kk].p_agents[0]);
            end
            begin
               wait_for_agent_rst_done(masters[kk].p_ext_agents[0]);
            end
         join_none      
      
      wait fork; // wait for all the above fork-join_none to complete

   endtask

   virtual task wait_for_rst_done();
      wait_for_all_agents_rst_done();
   endtask

endclass
