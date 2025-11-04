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


class dut_usb4_tc_noc_env_base extends uvm_env;

   dut_usb4_tc_noc_env_cfg env_cfg;

   // a container for all the VIP agents in the testbench
   dut_usb4_tc_noc_env_vip_container all_vips;

   // Routing model instance and enabling flag
   bit has_routing_model = 1;
   dut_usb4_tc_noc_env_routing_model routing_model;

   // the following determines if this instance is active (drives activity) or passive
   // (monitors only)
   uvm_active_passive_enum active_passive = UVM_ACTIVE;

   // virtual sequencer instance and enabling flag
   bit has_vseqr = (active_passive == UVM_ACTIVE);
   dut_usb4_tc_noc_env_vsequencer vseqr;

   // a container for all the scoreboard agents in the testbench
   dut_usb4_tc_noc_env_scoreboard_container all_scoreboards;

   //----------------------------------------------------------
   // Internal implementation stuff
   //----------------------------------------------------------

   extern virtual function void apb_connect_code();

   virtual function void build_phase(uvm_phase phase);

      super.build_phase(phase);

      if (!uvm_config_db#(dut_usb4_tc_noc_env_cfg)::get(this,"","env_cfg", env_cfg)) begin
         env_cfg  = dut_usb4_tc_noc_env_cfg::type_id::create("env_cfg");
      end

      all_vips = dut_usb4_tc_noc_env_vip_container::type_id::create("all_vips", this);

      all_vips.env_cfg = env_cfg;
      
      if (env_cfg.disable_scoreboards == 0)      
        all_scoreboards = dut_usb4_tc_noc_env_scoreboard_container::type_id::create("all_scoreboards", this);

      if (has_routing_model)
         routing_model = dut_usb4_tc_noc_env_routing_model::type_id::create("routing_model", this);

      if (active_passive == UVM_ACTIVE && has_vseqr)
         vseqr = dut_usb4_tc_noc_env_vsequencer::type_id::create("vseqr", this);

   endfunction


   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);

      vseqr.p_routing_model = routing_model;

      // initialize any pointers
      all_vips.routing_model = routing_model;

      if (env_cfg.disable_scoreboards == 0) 
        all_scoreboards.scoreboard.routing_model = routing_model;

      // bring in the code to hook up pointers in the VIP container to all actual agents

      apb_connect_code();
   endfunction



   `uvm_component_utils_begin(dut_usb4_tc_noc_env_base)
      `uvm_field_enum(uvm_active_passive_enum, active_passive, UVM_ALL_ON)
      `uvm_field_int(has_vseqr, UVM_ALL_ON)
      `uvm_field_int(has_routing_model, UVM_ALL_ON)
   `uvm_component_utils_end


   function new(string name="dut_usb4_tc_noc_env_base", uvm_component parent=null);
      super.new(name,parent);
   endfunction

endclass

