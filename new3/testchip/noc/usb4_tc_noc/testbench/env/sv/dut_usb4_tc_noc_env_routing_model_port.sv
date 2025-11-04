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

typedef class dut_usb4_tc_noc_env_scoreboard_agent;

class dut_usb4_tc_noc_env_routing_model_port extends cdn_stg_routing_model_port;
  
   //---------------------------------------
   // UVM declaration and constructor
   //---------------------------------------
   `uvm_object_utils(dut_usb4_tc_noc_env_routing_model_port)
   function new (string name = "dut_usb4_tc_noc_env_routing_model_port");
      super.new(name);
   endfunction
      
   virtual function void configure_vip_agent_memory_map(
                           uvm_component vip_agent,
                           cdn_stg_routing_model_memory_segment seg,
                           bit clear_memory_map = 1); 
      
      cdn_stg_routing_model_memory_shareable_t shareability;
      cdnStgApbUvmSlaveAgent p_cdnStgApbUvmSlaveAgent;
      cdnStgApbUvmMasterAgent p_cdnStgApbUvmMasterAgent;

         
      if ($cast(p_cdnStgApbUvmSlaveAgent, vip_agent)) begin
         if (clear_memory_map) begin
            p_cdnStgApbUvmSlaveAgent.clearMappedMemorySegments();
         end
         p_cdnStgApbUvmSlaveAgent.configureMappedMemorySegment(seg.start_addr, seg.end_addr, 0);
         return;
      end
      if ($cast(p_cdnStgApbUvmMasterAgent, vip_agent)) begin
         if (clear_memory_map) begin
            p_cdnStgApbUvmMasterAgent.clearMappedMemorySegments();
         end
         p_cdnStgApbUvmMasterAgent.configureMappedMemorySegment(seg.start_addr, seg.end_addr, 0);
         return;
      end
            
      `uvm_info("STG_ROUTING_MODEL_PORT", 
                "unknown VIP agent type encountered when attempting to configure the agent's memory map", 
                UVM_LOW)
   endfunction
   
   virtual function void configure_scoreboard_agent_memory_map(
                           uvm_component scoreboard_agent,
                           cdn_stg_routing_model_memory_segment seg);
      dut_usb4_tc_noc_env_scoreboard_agent dut_usb4_tc_noc_scoreboard_agent;
      denaliSvdAddressRangeAttributeT attributes [];
      string ingress_port_names[$], egress_port_names[$];
         seg.get_ingress_port_names_for_scoreboard(ingress_port_names);
         seg.get_egress_port_names_for_scoreboard(egress_port_names);
      
      if ($cast(dut_usb4_tc_noc_scoreboard_agent, scoreboard_agent)) begin
         foreach (ingress_port_names[i]) begin
            dut_usb4_tc_noc_scoreboard_agent.inst.mapMemorySegmentToMultipleSlaves(
                               ingress_port_names[i],
                               seg.start_addr, seg.end_addr,
                               egress_port_names, attributes);
         end
         return;
      end
      
      `uvm_info("STG_ROUTING_MODEL_PORT", 
                "unknown SCOREBOARD agent type encountered when attempting to configure its memory map", 
                UVM_LOW)
   endfunction

endclass : dut_usb4_tc_noc_env_routing_model_port
