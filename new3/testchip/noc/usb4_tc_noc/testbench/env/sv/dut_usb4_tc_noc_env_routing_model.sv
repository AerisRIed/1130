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

class dut_usb4_tc_noc_env_routing_model extends cdn_stg_routing_model;
   
   //---------------------------------------
   // UVM declaration and constructor
   //---------------------------------------
   `uvm_component_utils(dut_usb4_tc_noc_env_routing_model)
   function new (string name = "dut_usb4_tc_noc_env_routing_model", uvm_component parent=null);
      super.new(name, parent);
      // type override port class such that during the build_phase, 
      // this routing model instance uses the customised routing model port
      set_type_override_by_type(cdn_stg_routing_model_port::get_type(),
                                dut_usb4_tc_noc_env_routing_model_port::get_type());
   endfunction
   
   
   virtual function void clear_scoreboard_agent_memory_map(uvm_component scoreboard_agent);
      dut_usb4_tc_noc_env_scoreboard_agent env_scoreboard_agent;
      
      if ($cast(env_scoreboard_agent, scoreboard_agent)) begin
         env_scoreboard_agent.inst.resetMemory();
         return;
      end
      
      `uvm_info("STG_ROUTING_MODEL_PORT", 
                "unknown SCOREBOARD agent type encountered when attempting to clear its memory map", 
                UVM_LOW)
   endfunction

   //---------------------------------------
   // Overriding a hook method in the base type to specify all domains
   //---------------------------------------
   virtual function void populate_domains();
      
      // cdn_stg_routing_model_domain add_domain_params(string name,
      //                                                cdn_stg_routing_model_shareable_domain_t domain_type)
      
      cdn_stg_routing_model_shareable_domain domain; // storage for the current domain
      
   endfunction : populate_domains
   
   
   //---------------------------------------
   // Overriding a hook method in the base type to specify all ports
   //---------------------------------------
   virtual function void populate_ports();
      
      uvm_component      no_agent[$];  
      uvm_sequencer_base no_seqrs[$];
      cdn_stg_routing_model_port port;
      
      // cdn_stg_routing_model_port add_port_params(string name,
      //                                            string protocol,
      //                                            string version,
      //                                            bit is_ddr,
      //                                            cdn_stg_routing_model_role_t role,
      //                                            int address_width,
      //                                            int node_id = -1,
      //                                            string node_type = "",
      //                                            bit is_hnf_monitored = 0,
      //                                            const ref uvm_component p_ext_agents[$],
      //                                            const ref uvm_sequencer_base p_ext_sequencers[$],
      //                                            const ref uvm_component p_agents[$]);
      
      port = add_port_params("apb_mstr", "APB", "AMBA4", 0, INGRESS, 32, , , , no_agent, no_seqrs, no_agent);
      port = add_port_params("cdb", "APB", "AMBA4", 0, INGRESS, 32, , , , no_agent, no_seqrs, no_agent);
      port = add_port_params("cmn_cdb", "APB", "AMBA4", 0, EGRESS, 9, , , , no_agent, no_seqrs, no_agent);
      port = add_port_params("tc_reg", "APB", "AMBA4", 0, EGRESS, 16, , , , no_agent, no_seqrs, no_agent);
      port = add_port_params("usb_sub_sys", "APB", "AMBA4", 0, EGRESS, 16, , , , no_agent, no_seqrs, no_agent);
      port = add_port_params("pam3_sub_sys", "APB", "AMBA4", 0, EGRESS, 16, , , , no_agent, no_seqrs, no_agent);
      port = add_port_params("apb_tgt", "APB", "AMBA4", 0, EGRESS, 18, , , , no_agent, no_seqrs, no_agent);
      port = add_port_params("xcvr_ln_0", "APB", "AMBA4", 0, EGRESS, 10, , , , no_agent, no_seqrs, no_agent);
      
   endfunction : populate_ports
   
   
   //---------------------------------------
   // Overriding a hook method in the base type to specify all remap modes
   //---------------------------------------   
   virtual function void populate_remap_states();
      
      // add_remap_state_params(string instance_path, string name);
      
      cdn_stg_routing_model_remap_state remap_state;
      // no remap states found
   endfunction : populate_remap_states
   
   
   //---------------------------------------
   // Update routing model remap states (enable/disable)
   //---------------------------------------
   virtual function void update_routing_model_remap_states(string remap_state_names[$]);
      cdn_stg_routing_model_remap_state remap_state;
	   
      // no remap states found
	   
   endfunction : update_routing_model_remap_states	      
   
   //---------------------------------------
   // Overriding a hook method in the base type to specify all data routes
   //---------------------------------------
   virtual function void populate_dataroutes();
      
      // add_dataroute_params(string name,
      //                      bit is_external,
      //                      cdn_stg_routing_model_memory_map_t memory_map_type,      
      //                      string from_master, cdn_stg_routing_model_addr_t master_start_addr, master_end_addr,
      //                      cdn_stg_addr_t mask, mask_value,
      //                      string to_slave, cdn_stg_routing_model_addr_t slave_start_addr = master_start_addr,
      //                                                                    slave_end_addr = master_end_addr,
      //                      string remap_state_names[$])

      cdn_stg_routing_model_dataroute          dr; // storage for the current dataroute

      cdn_stg_routing_model_addressable_region ar; // storage for the memory regions with shareable attributes

      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_ED40000_ED401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hED40000, 64'hED401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hED401FF - 64'hED40000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_7DD40000_7DD401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h7DD40000, 64'h7DD401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7DD401FF - 64'h7DD40000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_840000_8401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h840000, 64'h8401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8401FF - 64'h840000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_AE040000_AE0401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hAE040000, 64'hAE0401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hAE0401FF - 64'hAE040000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_72540000_725401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h72540000, 64'h725401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h725401FF - 64'h72540000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_85F40000_85F401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h85F40000, 64'h85F401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h85F401FF - 64'h85F40000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_3640000_36401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h3640000, 64'h36401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h36401FF - 64'h3640000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_12B40000_12B401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h12B40000, 64'h12B401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h12B401FF - 64'h12B40000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_8A040000_8A0401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h8A040000, 64'h8A0401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8A0401FF - 64'h8A040000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_68040000_680401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h68040000, 64'h680401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h680401FF - 64'h68040000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_73440000_734401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h73440000, 64'h734401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h734401FF - 64'h73440000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_7A640000_7A6401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h7A640000, 64'h7A6401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7A6401FF - 64'h7A640000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_D8840000_D88401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hD8840000, 64'hD88401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hD88401FF - 64'hD8840000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_8ED40000_8ED401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h8ED40000, 64'h8ED401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8ED401FF - 64'h8ED40000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_7E740000_7E7401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h7E740000, 64'h7E7401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7E7401FF - 64'h7E740000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_E6E40000_E6E401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hE6E40000, 64'hE6E401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hE6E401FF - 64'hE6E40000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_850000_85FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h850000, 64'h85FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h85FFFF - 64'h850000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_12B50000_12B5FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h12B50000, 64'h12B5FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h12B5FFFF - 64'h12B50000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_7DD50000_7DD5FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h7DD50000, 64'h7DD5FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7DD5FFFF - 64'h7DD50000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_ED50000_ED5FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hED50000, 64'hED5FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hED5FFFF - 64'hED50000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_E6E50000_E6E5FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hE6E50000, 64'hE6E5FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hE6E5FFFF - 64'hE6E50000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_72550000_7255FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h72550000, 64'h7255FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7255FFFF - 64'h72550000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_8ED50000_8ED5FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h8ED50000, 64'h8ED5FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8ED5FFFF - 64'h8ED50000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_73450000_7345FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h73450000, 64'h7345FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7345FFFF - 64'h73450000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_7E750000_7E75FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h7E750000, 64'h7E75FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7E75FFFF - 64'h7E750000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_AE050000_AE05FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hAE050000, 64'hAE05FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hAE05FFFF - 64'hAE050000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_8A050000_8A05FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h8A050000, 64'h8A05FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8A05FFFF - 64'h8A050000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_3650000_365FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h3650000, 64'h365FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h365FFFF - 64'h3650000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_68050000_6805FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h68050000, 64'h6805FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h6805FFFF - 64'h68050000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_D8850000_D885FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hD8850000, 64'hD885FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hD885FFFF - 64'hD8850000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_85F50000_85F5FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h85F50000, 64'h85F5FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h85F5FFFF - 64'h85F50000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_7A650000_7A65FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h7A650000, 64'h7A65FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7A65FFFF - 64'h7A650000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_AE060000_AE06FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hAE060000, 64'hAE06FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hAE06FFFF - 64'hAE060000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_68060000_6806FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h68060000, 64'h6806FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h6806FFFF - 64'h68060000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_ED60000_ED6FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hED60000, 64'hED6FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hED6FFFF - 64'hED60000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_7DD60000_7DD6FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h7DD60000, 64'h7DD6FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7DD6FFFF - 64'h7DD60000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_12B60000_12B6FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h12B60000, 64'h12B6FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h12B6FFFF - 64'h12B60000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_860000_86FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h860000, 64'h86FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h86FFFF - 64'h860000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_E6E60000_E6E6FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hE6E60000, 64'hE6E6FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hE6E6FFFF - 64'hE6E60000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_85F60000_85F6FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h85F60000, 64'h85F6FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h85F6FFFF - 64'h85F60000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_73460000_7346FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h73460000, 64'h7346FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7346FFFF - 64'h73460000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_3660000_366FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h3660000, 64'h366FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h366FFFF - 64'h3660000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_7A660000_7A66FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h7A660000, 64'h7A66FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7A66FFFF - 64'h7A660000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_D8860000_D886FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hD8860000, 64'hD886FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hD886FFFF - 64'hD8860000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_7E760000_7E76FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h7E760000, 64'h7E76FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7E76FFFF - 64'h7E760000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_72560000_7256FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h72560000, 64'h7256FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7256FFFF - 64'h72560000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_8A060000_8A06FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h8A060000, 64'h8A06FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8A06FFFF - 64'h8A060000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_8ED60000_8ED6FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h8ED60000, 64'h8ED6FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8ED6FFFF - 64'h8ED60000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_ED70000_ED7FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hED70000, 64'hED7FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hED7FFFF - 64'hED70000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_68070000_6807FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h68070000, 64'h6807FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h6807FFFF - 64'h68070000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_E6E70000_E6E7FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hE6E70000, 64'hE6E7FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hE6E7FFFF - 64'hE6E70000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_8ED70000_8ED7FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h8ED70000, 64'h8ED7FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8ED7FFFF - 64'h8ED70000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_D8870000_D887FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hD8870000, 64'hD887FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hD887FFFF - 64'hD8870000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_12B70000_12B7FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h12B70000, 64'h12B7FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h12B7FFFF - 64'h12B70000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_AE070000_AE07FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hAE070000, 64'hAE07FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hAE07FFFF - 64'hAE070000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_7DD70000_7DD7FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h7DD70000, 64'h7DD7FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7DD7FFFF - 64'h7DD70000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_7A670000_7A67FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h7A670000, 64'h7A67FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7A67FFFF - 64'h7A670000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_73470000_7347FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h73470000, 64'h7347FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7347FFFF - 64'h73470000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_7E770000_7E77FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h7E770000, 64'h7E77FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7E77FFFF - 64'h7E770000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_3670000_367FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h3670000, 64'h367FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h367FFFF - 64'h3670000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_8A070000_8A07FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h8A070000, 64'h8A07FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8A07FFFF - 64'h8A070000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_72570000_7257FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h72570000, 64'h7257FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7257FFFF - 64'h72570000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_85F70000_85F7FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h85F70000, 64'h85F7FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h85F7FFFF - 64'h85F70000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_870000_87FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h870000, 64'h87FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h87FFFF - 64'h870000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_73400000_7343FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h73400000, 64'h7343FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7343FFFF - 64'h73400000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_7E700000_7E73FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h7E700000, 64'h7E73FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7E73FFFF - 64'h7E700000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_85F00000_85F3FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h85F00000, 64'h85F3FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h85F3FFFF - 64'h85F00000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_800000_83FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h800000, 64'h83FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h83FFFF - 64'h800000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_ED00000_ED3FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hED00000, 64'hED3FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hED3FFFF - 64'hED00000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_AE000000_AE03FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hAE000000, 64'hAE03FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hAE03FFFF - 64'hAE000000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_72500000_7253FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h72500000, 64'h7253FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7253FFFF - 64'h72500000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_D8800000_D883FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hD8800000, 64'hD883FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hD883FFFF - 64'hD8800000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_E6E00000_E6E3FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hE6E00000, 64'hE6E3FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hE6E3FFFF - 64'hE6E00000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_12B00000_12B3FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h12B00000, 64'h12B3FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h12B3FFFF - 64'h12B00000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_7DD00000_7DD3FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h7DD00000, 64'h7DD3FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7DD3FFFF - 64'h7DD00000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_8A000000_8A03FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h8A000000, 64'h8A03FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8A03FFFF - 64'h8A000000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_7A600000_7A63FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h7A600000, 64'h7A63FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7A63FFFF - 64'h7A600000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_8ED00000_8ED3FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h8ED00000, 64'h8ED3FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8ED3FFFF - 64'h8ED00000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_68000000_6803FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h68000000, 64'h6803FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h6803FFFF - 64'h68000000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_3600000_363FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h3600000, 64'h363FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h363FFFF - 64'h3600000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_D8840400_D88407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hD8840400, 64'hD88407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hD88407FF - 64'hD8840400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_8A040400_8A0407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h8A040400, 64'h8A0407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8A0407FF - 64'h8A040400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_73440400_734407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h73440400, 64'h734407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h734407FF - 64'h73440400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_7E740400_7E7407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h7E740400, 64'h7E7407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7E7407FF - 64'h7E740400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_3640400_36407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h3640400, 64'h36407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h36407FF - 64'h3640400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_840400_8407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h840400, 64'h8407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8407FF - 64'h840400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_8ED40400_8ED407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h8ED40400, 64'h8ED407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8ED407FF - 64'h8ED40400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_72540400_725407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h72540400, 64'h725407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h725407FF - 64'h72540400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_68040400_680407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h68040400, 64'h680407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h680407FF - 64'h68040400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_7DD40400_7DD407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h7DD40400, 64'h7DD407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7DD407FF - 64'h7DD40400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_85F40400_85F407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h85F40400, 64'h85F407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h85F407FF - 64'h85F40400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_ED40400_ED407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hED40400, 64'hED407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hED407FF - 64'hED40400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_7A640400_7A6407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h7A640400, 64'h7A6407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7A6407FF - 64'h7A640400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_E6E40400_E6E407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hE6E40400, 64'hE6E407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hE6E407FF - 64'hE6E40400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_12B40400_12B407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'h12B40400, 64'h12B407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h12B407FF - 64'h12B40400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_apb_mstr_AE040400_AE0407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "apb_mstr", 64'hAE040400, 64'hAE0407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hAE0407FF - 64'hAE040400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_ED40000_ED401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hED40000, 64'hED401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hED401FF - 64'hED40000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_7DD40000_7DD401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h7DD40000, 64'h7DD401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7DD401FF - 64'h7DD40000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_840000_8401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h840000, 64'h8401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8401FF - 64'h840000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_AE040000_AE0401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hAE040000, 64'hAE0401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hAE0401FF - 64'hAE040000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_72540000_725401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h72540000, 64'h725401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h725401FF - 64'h72540000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_85F40000_85F401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h85F40000, 64'h85F401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h85F401FF - 64'h85F40000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_3640000_36401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h3640000, 64'h36401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h36401FF - 64'h3640000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_12B40000_12B401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h12B40000, 64'h12B401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h12B401FF - 64'h12B40000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_8A040000_8A0401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h8A040000, 64'h8A0401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8A0401FF - 64'h8A040000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_68040000_680401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h68040000, 64'h680401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h680401FF - 64'h68040000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_73440000_734401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h73440000, 64'h734401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h734401FF - 64'h73440000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_7A640000_7A6401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h7A640000, 64'h7A6401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7A6401FF - 64'h7A640000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_D8840000_D88401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hD8840000, 64'hD88401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hD88401FF - 64'hD8840000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_8ED40000_8ED401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h8ED40000, 64'h8ED401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8ED401FF - 64'h8ED40000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_7E740000_7E7401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h7E740000, 64'h7E7401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7E7401FF - 64'h7E740000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_E6E40000_E6E401FF_to_i_usb4_tc_noc_cmn_cdb_0_1FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hE6E40000, 64'hE6E401FF,
                                64'h0, 64'h0,
                                "cmn_cdb", 64'h0, 64'h1FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hE6E401FF - 64'hE6E40000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_850000_85FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h850000, 64'h85FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h85FFFF - 64'h850000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_12B50000_12B5FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h12B50000, 64'h12B5FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h12B5FFFF - 64'h12B50000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_7DD50000_7DD5FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h7DD50000, 64'h7DD5FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7DD5FFFF - 64'h7DD50000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_ED50000_ED5FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hED50000, 64'hED5FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hED5FFFF - 64'hED50000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_E6E50000_E6E5FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hE6E50000, 64'hE6E5FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hE6E5FFFF - 64'hE6E50000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_72550000_7255FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h72550000, 64'h7255FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7255FFFF - 64'h72550000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_8ED50000_8ED5FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h8ED50000, 64'h8ED5FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8ED5FFFF - 64'h8ED50000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_73450000_7345FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h73450000, 64'h7345FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7345FFFF - 64'h73450000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_7E750000_7E75FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h7E750000, 64'h7E75FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7E75FFFF - 64'h7E750000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_AE050000_AE05FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hAE050000, 64'hAE05FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hAE05FFFF - 64'hAE050000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_8A050000_8A05FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h8A050000, 64'h8A05FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8A05FFFF - 64'h8A050000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_3650000_365FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h3650000, 64'h365FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h365FFFF - 64'h3650000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_68050000_6805FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h68050000, 64'h6805FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h6805FFFF - 64'h68050000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_D8850000_D885FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hD8850000, 64'hD885FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hD885FFFF - 64'hD8850000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_85F50000_85F5FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h85F50000, 64'h85F5FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h85F5FFFF - 64'h85F50000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_7A650000_7A65FFFF_to_i_usb4_tc_noc_tc_reg_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h7A650000, 64'h7A65FFFF,
                                64'h0, 64'h0,
                                "tc_reg", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7A65FFFF - 64'h7A650000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_AE060000_AE06FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hAE060000, 64'hAE06FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hAE06FFFF - 64'hAE060000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_68060000_6806FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h68060000, 64'h6806FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h6806FFFF - 64'h68060000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_ED60000_ED6FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hED60000, 64'hED6FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hED6FFFF - 64'hED60000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_7DD60000_7DD6FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h7DD60000, 64'h7DD6FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7DD6FFFF - 64'h7DD60000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_12B60000_12B6FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h12B60000, 64'h12B6FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h12B6FFFF - 64'h12B60000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_860000_86FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h860000, 64'h86FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h86FFFF - 64'h860000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_E6E60000_E6E6FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hE6E60000, 64'hE6E6FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hE6E6FFFF - 64'hE6E60000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_85F60000_85F6FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h85F60000, 64'h85F6FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h85F6FFFF - 64'h85F60000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_73460000_7346FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h73460000, 64'h7346FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7346FFFF - 64'h73460000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_3660000_366FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h3660000, 64'h366FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h366FFFF - 64'h3660000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_7A660000_7A66FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h7A660000, 64'h7A66FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7A66FFFF - 64'h7A660000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_D8860000_D886FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hD8860000, 64'hD886FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hD886FFFF - 64'hD8860000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_7E760000_7E76FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h7E760000, 64'h7E76FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7E76FFFF - 64'h7E760000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_72560000_7256FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h72560000, 64'h7256FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7256FFFF - 64'h72560000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_8A060000_8A06FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h8A060000, 64'h8A06FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8A06FFFF - 64'h8A060000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_8ED60000_8ED6FFFF_to_i_usb4_tc_noc_usb_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h8ED60000, 64'h8ED6FFFF,
                                64'h0, 64'h0,
                                "usb_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8ED6FFFF - 64'h8ED60000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_ED70000_ED7FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hED70000, 64'hED7FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hED7FFFF - 64'hED70000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_68070000_6807FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h68070000, 64'h6807FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h6807FFFF - 64'h68070000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_E6E70000_E6E7FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hE6E70000, 64'hE6E7FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hE6E7FFFF - 64'hE6E70000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_8ED70000_8ED7FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h8ED70000, 64'h8ED7FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8ED7FFFF - 64'h8ED70000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_D8870000_D887FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hD8870000, 64'hD887FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hD887FFFF - 64'hD8870000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_12B70000_12B7FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h12B70000, 64'h12B7FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h12B7FFFF - 64'h12B70000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_AE070000_AE07FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hAE070000, 64'hAE07FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hAE07FFFF - 64'hAE070000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_7DD70000_7DD7FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h7DD70000, 64'h7DD7FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7DD7FFFF - 64'h7DD70000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_7A670000_7A67FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h7A670000, 64'h7A67FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7A67FFFF - 64'h7A670000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_73470000_7347FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h73470000, 64'h7347FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7347FFFF - 64'h73470000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_7E770000_7E77FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h7E770000, 64'h7E77FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7E77FFFF - 64'h7E770000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_3670000_367FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h3670000, 64'h367FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h367FFFF - 64'h3670000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_8A070000_8A07FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h8A070000, 64'h8A07FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8A07FFFF - 64'h8A070000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_72570000_7257FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h72570000, 64'h7257FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7257FFFF - 64'h72570000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_85F70000_85F7FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h85F70000, 64'h85F7FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h85F7FFFF - 64'h85F70000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_870000_87FFFF_to_i_usb4_tc_noc_pam3_sub_sys_0_FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h870000, 64'h87FFFF,
                                64'h0, 64'h0,
                                "pam3_sub_sys", 64'h0, 64'hFFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h87FFFF - 64'h870000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_73400000_7343FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h73400000, 64'h7343FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7343FFFF - 64'h73400000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_7E700000_7E73FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h7E700000, 64'h7E73FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7E73FFFF - 64'h7E700000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_85F00000_85F3FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h85F00000, 64'h85F3FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h85F3FFFF - 64'h85F00000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_800000_83FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h800000, 64'h83FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h83FFFF - 64'h800000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_ED00000_ED3FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hED00000, 64'hED3FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hED3FFFF - 64'hED00000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_AE000000_AE03FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hAE000000, 64'hAE03FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hAE03FFFF - 64'hAE000000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_72500000_7253FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h72500000, 64'h7253FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7253FFFF - 64'h72500000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_D8800000_D883FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hD8800000, 64'hD883FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hD883FFFF - 64'hD8800000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_E6E00000_E6E3FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hE6E00000, 64'hE6E3FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hE6E3FFFF - 64'hE6E00000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_12B00000_12B3FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h12B00000, 64'h12B3FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h12B3FFFF - 64'h12B00000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_7DD00000_7DD3FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h7DD00000, 64'h7DD3FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7DD3FFFF - 64'h7DD00000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_8A000000_8A03FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h8A000000, 64'h8A03FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8A03FFFF - 64'h8A000000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_7A600000_7A63FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h7A600000, 64'h7A63FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7A63FFFF - 64'h7A600000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_8ED00000_8ED3FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h8ED00000, 64'h8ED3FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8ED3FFFF - 64'h8ED00000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_68000000_6803FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h68000000, 64'h6803FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h6803FFFF - 64'h68000000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_3600000_363FFFF_to_i_usb4_tc_noc_apb_tgt_0_3FFFF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h3600000, 64'h363FFFF,
                                64'h0, 64'h0,
                                "apb_tgt", 64'h0, 64'h3FFFF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h363FFFF - 64'h3600000 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_D8840400_D88407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hD8840400, 64'hD88407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hD88407FF - 64'hD8840400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_8A040400_8A0407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h8A040400, 64'h8A0407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8A0407FF - 64'h8A040400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_73440400_734407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h73440400, 64'h734407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h734407FF - 64'h73440400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_7E740400_7E7407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h7E740400, 64'h7E7407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7E7407FF - 64'h7E740400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_3640400_36407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h3640400, 64'h36407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h36407FF - 64'h3640400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_840400_8407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h840400, 64'h8407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8407FF - 64'h840400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_8ED40400_8ED407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h8ED40400, 64'h8ED407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h8ED407FF - 64'h8ED40400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_72540400_725407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h72540400, 64'h725407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h725407FF - 64'h72540400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_68040400_680407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h68040400, 64'h680407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h680407FF - 64'h68040400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_7DD40400_7DD407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h7DD40400, 64'h7DD407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7DD407FF - 64'h7DD40400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_85F40400_85F407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h85F40400, 64'h85F407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h85F407FF - 64'h85F40400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_ED40400_ED407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hED40400, 64'hED407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hED407FF - 64'hED40400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_7A640400_7A6407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h7A640400, 64'h7A6407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h7A6407FF - 64'h7A640400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_E6E40400_E6E407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hE6E40400, 64'hE6E407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hE6E407FF - 64'hE6E40400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_12B40400_12B407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'h12B40400, 64'h12B407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'h12B407FF - 64'h12B40400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      dr = add_dataroute_params("i_usb4_tc_noc_cdb_AE040400_AE0407FF_to_i_usb4_tc_noc_xcvr_ln_0_0_3FF",
                                1'b1,
                                SCOREBOARD_VIP_AGENT_MAP,
                                "cdb", 64'hAE040400, 64'hAE0407FF,
                                64'h0, 64'h0,
                                "xcvr_ln_0", 64'h0, 64'h3FF,
                                {});
      ar = dr.add_addressable_region(64'h0,(64'hAE0407FF - 64'hAE040400 + 1),CDN_STG_MEMORY_NON_SHAREABLE);
      
   endfunction : populate_dataroutes
   
endclass : dut_usb4_tc_noc_env_routing_model
