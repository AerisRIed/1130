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


class dut_usb4_tc_noc_env_scoreboard_container extends uvm_env;

   // [if applicable] Interconnect Monitor instance
   dut_usb4_tc_noc_env_scoreboard_agent scoreboard;

   `uvm_component_utils_begin(dut_usb4_tc_noc_env_scoreboard_container)
   `uvm_component_utils_end
   
  
   function new(string name="dut_usb4_tc_noc_env_scoreboard_container", uvm_component parent=null);
      super.new(name,parent);
   endfunction

   /*
    *
    * build_phase
    * 
    */
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      
      scoreboard = dut_usb4_tc_noc_env_scoreboard_agent::type_id::create("scoreboard", this);      
      begin
        scoreboardCfg scoreboard_cfg = scoreboardCfg::type_id::create("scoreboard_cfg",this);
        scoreboard_cfg.is_active = UVM_PASSIVE;
        uvm_config_object::set(this,"scoreboard","cfg",scoreboard_cfg);        
      end

      
   endfunction


   /*
    *
    * end_of_elaboration_phase
    * 
    */
   virtual function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      
   endfunction
   
   
   /*
    *
    * start_of_simulation_phase
    * 
    */
   virtual function void start_of_simulation_phase(uvm_phase phase);
      super.start_of_simulation_phase(phase);      
   endfunction
   
endclass
   
