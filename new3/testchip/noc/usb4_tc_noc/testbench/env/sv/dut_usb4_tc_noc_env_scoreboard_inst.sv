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

class dut_usb4_tc_noc_env_scoreboard_agent extends cdn_stg_basic_env_scoreboard_agent;
   
   `uvm_component_utils_begin(dut_usb4_tc_noc_env_scoreboard_agent)
   `uvm_component_utils_end

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if (!$test$plusargs("STG_DISABLE_VIP_COVERAGE")) begin
         uvm_config_int::set(this,"*monitor", "coverageEnable", 1);
      end;
   endfunction   
   
   // helper function to obtain the VIP inst object for a given agent
   virtual function denaliIcmAwareInstance get_inst_for_port(cdn_stg_routing_model_port port_desc);
      denaliIcmAwareInstance result;
      
      cdnStgApbUvmSlaveAgent p_cdnStgApbUvmSlaveAgent;
      cdnStgApbUvmMasterAgent p_cdnStgApbUvmMasterAgent;
      
      assert (routing_model != null);
      if (port_desc != null) begin
         uvm_component p_agent = port_desc.p_agents[0];
         if(p_agent == null) begin
            p_agent = port_desc.p_ext_agents[0];
            if(p_agent == null)
               `uvm_fatal("NULL_AGENT",
                          $sformatf("null agent pointer in %s", 
                          port_desc.get_full_name()))
         end
         
         if ($cast(p_cdnStgApbUvmSlaveAgent, p_agent)) begin
            if (! $cast(result, p_cdnStgApbUvmSlaveAgent.inst))
               `uvm_fatal("UNEXPECTED_INST_TYPE",
                          $sformatf("Expecting a denaliIcmAwareInstance inst in %s", 
                          p_cdnStgApbUvmSlaveAgent.inst.get_full_name()))
            return(result);
         end
         if ($cast(p_cdnStgApbUvmMasterAgent, p_agent)) begin
            if (! $cast(result, p_cdnStgApbUvmMasterAgent.inst))
               `uvm_fatal("UNEXPECTED_INST_TYPE",
                          $sformatf("Expecting a denaliIcmAwareInstance inst in %s", 
                          p_cdnStgApbUvmMasterAgent.inst.get_full_name()))
            return(result);
         end
         // if we reached this point, the agent type is wrong
         `uvm_fatal("UNEXPECTED_AGENT_TYPE",
         $sformatf("Expecting an agent kind supported by SVD, but found something else in %s", p_agent.get_full_name()))
      end
  
   endfunction
   
   
       
endclass : dut_usb4_tc_noc_env_scoreboard_agent

class dut_usb4_tc_noc_env_scoreboard_inst extends cdnSvdUvmInstance;
   
   `uvm_component_utils(dut_usb4_tc_noc_env_scoreboard_inst)
   function new(string name, uvm_component parent);
      super.new(name, parent);
      
   endfunction
   
   
   /*
    *
    * end_of_elaboration_phase
    *
    */
   virtual function void end_of_elaboration_phase(uvm_phase phase);
      int status;

      super.end_of_elaboration_phase(phase);

      // enable callbacks
      status = setCallback(DENALI_SVD_CB_CompoundItemDone);
   endfunction
   
   /*
    *
    * ConvertCompoundItemId implementation
    *
    */
   
   `ifndef IGNORE_ID
      `define IGNORE_ID 64'hffff_ff84
   `endif
 
   virtual function void ConvertCompoundItemId(ref denaliSvdTransaction trans);
      // by default, ignore ID
      trans.CompoundItemIdOut = `IGNORE_ID;
   endfunction

   
   virtual function void AddressTranslation(ref denaliSvdTransaction trans);
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hED40000:64'hED401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h7DD40000:64'h7DD401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h840000:64'h8401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hAE040000:64'hAE0401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h72540000:64'h725401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h85F40000:64'h85F401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h3640000:64'h36401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h12B40000:64'h12B401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h8A040000:64'h8A0401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h68040000:64'h680401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h73440000:64'h734401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h7A640000:64'h7A6401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hD8840000:64'hD88401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h8ED40000:64'h8ED401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h7E740000:64'h7E7401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hE6E40000:64'hE6E401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h850000:64'h85FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h12B50000:64'h12B5FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h7DD50000:64'h7DD5FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hED50000:64'hED5FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hE6E50000:64'hE6E5FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h72550000:64'h7255FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h8ED50000:64'h8ED5FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h73450000:64'h7345FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h7E750000:64'h7E75FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hAE050000:64'hAE05FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h8A050000:64'h8A05FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h3650000:64'h365FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h68050000:64'h6805FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hD8850000:64'hD885FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h85F50000:64'h85F5FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h7A650000:64'h7A65FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hAE060000:64'hAE06FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h68060000:64'h6806FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hED60000:64'hED6FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h7DD60000:64'h7DD6FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h12B60000:64'h12B6FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h860000:64'h86FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hE6E60000:64'hE6E6FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h85F60000:64'h85F6FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h73460000:64'h7346FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h3660000:64'h366FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h7A660000:64'h7A66FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hD8860000:64'hD886FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h7E760000:64'h7E76FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h72560000:64'h7256FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h8A060000:64'h8A06FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h8ED60000:64'h8ED6FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hED70000:64'hED7FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h68070000:64'h6807FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hE6E70000:64'hE6E7FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h8ED70000:64'h8ED7FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hD8870000:64'hD887FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h12B70000:64'h12B7FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hAE070000:64'hAE07FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h7DD70000:64'h7DD7FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h7A670000:64'h7A67FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h73470000:64'h7347FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h7E770000:64'h7E77FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h3670000:64'h367FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h8A070000:64'h8A07FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h72570000:64'h7257FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h85F70000:64'h85F7FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h870000:64'h87FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h73400000:64'h7343FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h7E700000:64'h7E73FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h85F00000:64'h85F3FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h800000:64'h83FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hED00000:64'hED3FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hAE000000:64'hAE03FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h72500000:64'h7253FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hD8800000:64'hD883FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hE6E00000:64'hE6E3FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h12B00000:64'h12B3FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h7DD00000:64'h7DD3FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h8A000000:64'h8A03FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h7A600000:64'h7A63FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h8ED00000:64'h8ED3FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h68000000:64'h6803FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h3600000:64'h363FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hD8840400:64'hD88407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h8A040400:64'h8A0407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h73440400:64'h734407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h7E740400:64'h7E7407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h3640400:64'h36407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h840400:64'h8407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h8ED40400:64'h8ED407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h72540400:64'h725407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h68040400:64'h680407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h7DD40400:64'h7DD407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h85F40400:64'h85F407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hED40400:64'hED407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h7A640400:64'h7A6407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hE6E40400:64'hE6E407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'h12B40400:64'h12B407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "apb_mstr" && trans.Address inside {[64'hAE040400:64'hAE0407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hED40000:64'hED401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h7DD40000:64'h7DD401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h840000:64'h8401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hAE040000:64'hAE0401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h72540000:64'h725401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h85F40000:64'h85F401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h3640000:64'h36401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h12B40000:64'h12B401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h8A040000:64'h8A0401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h68040000:64'h680401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h73440000:64'h734401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h7A640000:64'h7A6401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hD8840000:64'hD88401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h8ED40000:64'h8ED401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h7E740000:64'h7E7401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hE6E40000:64'hE6E401FF]})
      begin
         trans.AddressOut = trans.Address[8:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h850000:64'h85FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h12B50000:64'h12B5FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h7DD50000:64'h7DD5FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hED50000:64'hED5FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hE6E50000:64'hE6E5FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h72550000:64'h7255FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h8ED50000:64'h8ED5FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h73450000:64'h7345FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h7E750000:64'h7E75FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hAE050000:64'hAE05FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h8A050000:64'h8A05FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h3650000:64'h365FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h68050000:64'h6805FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hD8850000:64'hD885FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h85F50000:64'h85F5FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h7A650000:64'h7A65FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hAE060000:64'hAE06FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h68060000:64'h6806FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hED60000:64'hED6FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h7DD60000:64'h7DD6FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h12B60000:64'h12B6FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h860000:64'h86FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hE6E60000:64'hE6E6FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h85F60000:64'h85F6FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h73460000:64'h7346FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h3660000:64'h366FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h7A660000:64'h7A66FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hD8860000:64'hD886FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h7E760000:64'h7E76FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h72560000:64'h7256FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h8A060000:64'h8A06FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h8ED60000:64'h8ED6FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hED70000:64'hED7FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h68070000:64'h6807FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hE6E70000:64'hE6E7FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h8ED70000:64'h8ED7FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hD8870000:64'hD887FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h12B70000:64'h12B7FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hAE070000:64'hAE07FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h7DD70000:64'h7DD7FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h7A670000:64'h7A67FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h73470000:64'h7347FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h7E770000:64'h7E77FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h3670000:64'h367FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h8A070000:64'h8A07FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h72570000:64'h7257FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h85F70000:64'h85F7FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h870000:64'h87FFFF]})
      begin
         trans.AddressOut = trans.Address[15:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h73400000:64'h7343FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h7E700000:64'h7E73FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h85F00000:64'h85F3FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h800000:64'h83FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hED00000:64'hED3FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hAE000000:64'hAE03FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h72500000:64'h7253FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hD8800000:64'hD883FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hE6E00000:64'hE6E3FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h12B00000:64'h12B3FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h7DD00000:64'h7DD3FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h8A000000:64'h8A03FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h7A600000:64'h7A63FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h8ED00000:64'h8ED3FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h68000000:64'h6803FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h3600000:64'h363FFFF]})
      begin
         trans.AddressOut = trans.Address[17:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hD8840400:64'hD88407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h8A040400:64'h8A0407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h73440400:64'h734407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h7E740400:64'h7E7407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h3640400:64'h36407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h840400:64'h8407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h8ED40400:64'h8ED407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h72540400:64'h725407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h68040400:64'h680407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h7DD40400:64'h7DD407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h85F40400:64'h85F407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hED40400:64'hED407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h7A640400:64'h7A6407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hE6E40400:64'hE6E407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'h12B40400:64'h12B407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end
      if ( trans.PortName == "cdb" && trans.Address inside {[64'hAE040400:64'hAE0407FF]})
      begin
         trans.AddressOut = trans.Address[9:0];
         return;
      end

      trans.AddressOut = trans.Address;
   endfunction : AddressTranslation

endclass : dut_usb4_tc_noc_env_scoreboard_inst

function bit do_icm_inst_override();
   cdnSvdUvmInstance::type_id::set_type_override( dut_usb4_tc_noc_env_scoreboard_inst::get_type());
   cdnSvdUvmCoverage::type_id::set_type_override(denaliSvdUserCoverageInstance::get_type());
   return 1;
endfunction
bit do_icm_inst_override_called = do_icm_inst_override();


