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


`define MIN_ITEM_COUNT 20
`define MAX_ITEM_COUNT 100

//-------------------------------
//  dut_usb4_tc_noc_env_base_vseq
//-------------------------------
class dut_usb4_tc_noc_env_base_vseq extends uvm_sequence;

   cdn_stg_routing_model routing_model;

   int unsigned max_item_count = `MAX_ITEM_COUNT;
   int unsigned min_item_count = `MIN_ITEM_COUNT;

   // enable bit for wait_for_rst_done
   rand bit wait_for_rst_enabled;
   // wait for item done
   rand bit wait_for_item_done;
   // count of single_tans seq
   rand int unsigned item_count;
   rand int unsigned seq_addr_ratio;

   // constraints
   constraint wait_for_rst_enabled_default_c { soft wait_for_rst_enabled == 1; }
   constraint wait_for_item_done_default_c { soft wait_for_item_done == 0; }
   constraint item_default_c { soft item_count inside {[min_item_count : max_item_count] }; }
   constraint seq_addr_ratio_c { soft seq_addr_ratio == 0; }

   // events to signals sequence done
   event master_seq_done;
   event slave_seq_done;
	
   // stg custom reset event
   uvm_event stg_end_rst = new("stg_end_rst");
   // stg custom configure_dut event	
   uvm_event stg_configure_dut_event = new("stg_event");	

   // references to started and ended sequences
   uvm_sequence_base running_master_seqs[$];
   uvm_sequence_base ended_master_seqs[$];
   uvm_sequence_base running_slave_seqs[$];
   uvm_sequence_base ended_slave_seqs[$];

   // how should the start / end address be determined for the transfers
   // initiated by this sequence?
   // TO_SPECIFIC_ADDRESS - sequence address is determined by custom extension
   // TO_SLAVE - route from master to slave
   // TO_MAPPED_SEGMENTS - route from master to a mapped segment
   // TO_UNMAPPED_SEGMENTS - route from master to an unmapped segment
   // TO_ILLEGAL_MAPPED_SEGMENTS - route from master to a segment mapped to another master
   //                              but unmapped to this master
   // TO_INTERNAL_SEGMENTS - route from master to an internal segment
   // TO_RANDOM_SEGMENTS - route from masters to mapped / unmapped / illegal mapped segments
   rand cdn_stg_sequence_routing_mechanism_t routing_mechanism;

   `uvm_object_utils_begin(dut_usb4_tc_noc_env_base_vseq)
      `uvm_field_object (routing_model, UVM_DEFAULT)
      `uvm_field_enum (cdn_stg_sequence_routing_mechanism_t, routing_mechanism, UVM_DEFAULT)
      `uvm_field_int (max_item_count, UVM_DEFAULT)
      `uvm_field_int (min_item_count, UVM_DEFAULT)
      `uvm_field_int (wait_for_rst_enabled, UVM_DEFAULT)
      `uvm_field_int (item_count, UVM_DEFAULT)
      `uvm_field_int (seq_addr_ratio, UVM_DEFAULT)
      `uvm_field_queue_object (running_master_seqs, UVM_DEFAULT | UVM_REFERENCE)
      `uvm_field_queue_object (ended_master_seqs, UVM_DEFAULT | UVM_REFERENCE)
      `uvm_field_queue_object (running_slave_seqs, UVM_DEFAULT | UVM_REFERENCE)
      `uvm_field_queue_object (ended_slave_seqs, UVM_DEFAULT | UVM_REFERENCE)
   `uvm_object_utils_end

   `uvm_declare_p_sequencer(dut_usb4_tc_noc_env_vsequencer)

   function new(string name = "dut_usb4_tc_noc_env_base_vseq");
      super.new(name);
   endfunction

   function cdn_stg_routing_model get_routing_model();
      return(p_sequencer.p_routing_model);
   endfunction

   function void pre_randomize();
      super.pre_randomize();
      routing_model = get_routing_model();
      if (!$value$plusargs("CDN_STG_MAX_ITEM_COUNT=%d", max_item_count))
         max_item_count = `MAX_ITEM_COUNT;
      if (!$value$plusargs("CDN_STG_MIN_ITEM_COUNT=%d", min_item_count))
         min_item_count = `MIN_ITEM_COUNT;
      if (!(max_item_count >= min_item_count))
         `uvm_fatal("ILLEGAL_ITEM_COUNT_RANGE", $sformatf("%s%s",
               "max_item_count must be greater than or equal to min_item_count.  ",
               "Use +CDN_STG_MAX_ITEM_COUNT=<count> and +CDN_STG_MIN_ITEM_COUNT=<count> to set a valid range"));
   endfunction

   virtual task pre_body();
      super.pre_body();
      `uvm_info("VSEQ_START", { "Starting sequence ", get_type_name() }, UVM_MEDIUM)
      starting_phase.raise_objection(this, "Sequence started");
   endtask

   virtual task post_body();
      super.post_body();
      `uvm_info("VSEQ_END", { "Ended sequence ", get_type_name() }, UVM_MEDIUM)
      starting_phase.drop_objection(this, "Sequence ended");
   endtask


   task invoke_routing_master_seq_on(uvm_sequencer_base sequencer,
      int unsigned master_id,
      int unsigned slave_id[$],
      cdn_stg_routing_model_memory_segment target_segments[$],
      int unsigned item_count,
      ref uvm_sequence_base running_master_seqs[$],
      ref uvm_sequence_base ended_master_seqs[$],
      int unsigned seq_addr_ratio);

      //vip_master_seq_var_decl_code
      var cdn_stg_apb_routing_master_seq apb_routing_master_seq;
      var int apb_routing_master_seq_idx[$];
      var cdnApbUvmSequencer _cdnApbUvmSequencer;

      // In case no slave is accessible by this master, then return
      if (routing_mechanism == TO_SLAVES && slave_id.size() == 0) begin
         return;         
      end

      //In case no segment is accessible by this master, then return
      if (target_segments.size() == 0 && routing_mechanism inside {TO_RANDOM_SEGMENTS,
               TO_MAPPED_SEGMENTS,
               TO_UNMAPPED_SEGMENTS,
               TO_INTERNAL_SEGMENTS,
               TO_ILLEGAL_MAPPED_SEGMENTS}) begin
         return;         
      end

      //vip_master_seq_invocation_code
      if ( $cast(_cdnApbUvmSequencer, sequencer) )
      begin
         cdnApbUvmAgent agent;
         cdnStgApbUvmMasterAgent master_agent;
         cdn_stg_routing_model_port port;
         port = routing_model.get_port_by_id(master_id);
         $cast(master_agent,port.p_ext_agents[0]);
         $cast(agent,master_agent);
         `uvm_create_on (apb_routing_master_seq , _cdnApbUvmSequencer)
         apb_routing_master_seq.routing_model = routing_model;
         apb_routing_master_seq.routing_mechanism = routing_mechanism;
         apb_routing_master_seq.master_id = master_id;
         apb_routing_master_seq.target_slaves = slave_id;
         apb_routing_master_seq.target_segments = target_segments;
         if (!apb_routing_master_seq.randomize() with {
                  count == item_count;
                  seq_addr_ratio == local::seq_addr_ratio;
                  wait_for_item_done == local::wait_for_item_done;})
            `uvm_fatal("RAND_FAILED", "Failed to randomize!")
         running_master_seqs.push_back(apb_routing_master_seq);
         `uvm_send(apb_routing_master_seq)
          wait(apb_routing_master_seq.get_sequence_state() & (STOPPED|FINISHED));
         // indicate we're done to possible listeners
         ended_master_seqs.push_back(apb_routing_master_seq);
         apb_routing_master_seq_idx = running_master_seqs.find_first_index(seq) with (seq == apb_routing_master_seq);
         running_master_seqs.delete(apb_routing_master_seq_idx[0]);
         -> master_seq_done;
      end
 
   endtask // invoke_routing_master_seq_on


   task invoke_routing_slave_seq_on(uvm_sequencer_base sequencer, int unsigned slave_id,
         ref uvm_sequence_base running_slave_seqs[$],
         ref uvm_sequence_base ended_slave_seqs[$]);

      //vip_slave_seq_var_decl_code
      var cdn_stg_apb_routing_slave_seq apb_routing_slave_seq;
      var int apb_routing_slave_seq_idx[$];
      var cdnApbUvmSequencer _cdnApbUvmSequencer;

      //vip_slave_seq_invocation_code
      if ( $cast(_cdnApbUvmSequencer, sequencer) )
      begin
         cdnApbUvmAgent agent;
         cdnStgApbUvmSlaveAgent slave_agent;
         cdn_stg_routing_model_port port;
         port = routing_model.get_port_by_id(slave_id);
         $cast(slave_agent,port.p_ext_agents[0]);
         $cast(agent,slave_agent);
         `uvm_create_on (apb_routing_slave_seq , _cdnApbUvmSequencer)
         apb_routing_slave_seq.routing_model = routing_model;
         apb_routing_slave_seq.slave_id = slave_id;
         running_slave_seqs.push_back(apb_routing_slave_seq);
         `uvm_send(apb_routing_slave_seq)
          wait(apb_routing_slave_seq.get_sequence_state() & (STOPPED|FINISHED));
         // indicate we're done to possible listeners
         ended_slave_seqs.push_back(apb_routing_slave_seq);
         apb_routing_slave_seq_idx = running_slave_seqs.find_first_index(seq) with (seq == apb_routing_slave_seq);
         running_slave_seqs.delete(apb_routing_slave_seq_idx[0]);
         -> slave_seq_done;
      end
      
   endtask // invoke_routing_slave_seq_on

endclass : dut_usb4_tc_noc_env_base_vseq


//-------------------------------
// dut_usb4_tc_noc_env_configure_tb_vseq
//-------------------------------
class dut_usb4_tc_noc_env_configure_tb_vseq extends dut_usb4_tc_noc_env_base_vseq;
   `uvm_object_utils(dut_usb4_tc_noc_env_configure_tb_vseq)
   function new(string name = "dut_usb4_tc_noc_env_configure_tb_vseq");
      super.new(name);
   endfunction

   virtual task body();
      `uvm_info("BASE_CONFIG_TB_VSEQ", "Base configure_tb sequence running...", UVM_LOW)
   endtask
endclass : dut_usb4_tc_noc_env_configure_tb_vseq


//-------------------------------
// dut_usb4_tc_noc_env_configure_dut_vseq
//-------------------------------
class dut_usb4_tc_noc_env_configure_dut_vseq extends dut_usb4_tc_noc_env_base_vseq;
   `uvm_object_utils(dut_usb4_tc_noc_env_configure_dut_vseq)
   function new(string name = "dut_usb4_tc_noc_env_configure_dut_vseq");
      super.new(name);
   endfunction

   virtual task body();
      `uvm_info("BASE_CONFIG_DUT_VSEQ", "Base configure_dut sequence running...", UVM_LOW)
   endtask
endclass : dut_usb4_tc_noc_env_configure_dut_vseq


//-------------------------------
// multi_master_multi_route_vseq
//-------------------------------
typedef int unsigned id_queue[$];

class dut_usb4_tc_noc_env_multi_master_multi_route_vseq extends dut_usb4_tc_noc_env_base_vseq;

   // Configurable from above --------------------------------------------------

   // id's of the masters and slaves to use in the sequence
   int unsigned master_ids[],
   slave_ids[];

   // number of drive.clock cycles to wait following completion of the master sequences
   //  before stopping the slave sequences
   rand int unsigned slave_seq_drain_cycles;
   constraint slave_seq_drain_cycles_default_c {
      soft slave_seq_drain_cycles == 100;
   }

   // internal implementation --------------------------------------------------
   cdn_stg_routing_model_port all_active_masters[$], masters_to_drive[$],
   all_accessible_slaves[$], slaves_to_drive[$],
   slave_desc;
   int unsigned masters_to_drive_ids[], slaves_to_drive_ids[];
   uvm_sequencer_base master_sequencers[], slave_sequencers[];
   id_queue slave_desc_ids[][];

   `uvm_object_utils_begin(dut_usb4_tc_noc_env_multi_master_multi_route_vseq)
      `uvm_field_array_int (master_ids, UVM_DEFAULT)
      `uvm_field_array_int (slave_ids, UVM_DEFAULT)

      `uvm_field_queue_object (all_active_masters, UVM_DEFAULT)
      `uvm_field_queue_object (masters_to_drive, UVM_DEFAULT)
      `uvm_field_array_int (masters_to_drive_ids, UVM_DEFAULT)
      `uvm_field_array_object (master_sequencers, UVM_DEFAULT)
      `uvm_field_queue_object (all_accessible_slaves, UVM_DEFAULT)
      `uvm_field_queue_object (slaves_to_drive, UVM_DEFAULT)
      `uvm_field_array_int (slaves_to_drive_ids, UVM_DEFAULT)
      `uvm_field_object (slave_desc, UVM_DEFAULT)
      `uvm_field_array_object (slave_sequencers, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "dut_usb4_tc_noc_env_multi_master_multi_route_vseq");
      super.new(name);
   endfunction

   // Hook method to allow the user to procedurally initialize the
   //  master_ids and slave_ids
   virtual task initialize_ids();
   endtask

   // Hook method to allow the user to check validity of selected master/slave pair
   virtual task validate_route_for_initialized_ids();
   endtask

   // determine the list of target_slave_ids
   //  target slaves_ids is the subset of slaves accessible from this master
   //  that are in the list of slave_ids
   virtual task get_target_slave_ids(cdn_stg_routing_model_port master_port,
         ref int unsigned target_slave_ids[$]);
      cdn_stg_routing_model_port accessible_slaves[$];

      if (routing_mechanism inside {TO_SLAVES})
      begin
         routing_model.get_slaves_accessible_from_master(master_port, accessible_slaves);

         foreach (accessible_slaves[i])
         begin
            if (routing_model.get_port_id(accessible_slaves[i]) inside {slave_ids})
               target_slave_ids.push_back(routing_model.get_port_id(accessible_slaves[i]));
         end

         if (target_slave_ids.size() == 0)
            `uvm_warning("MULTI_MASTER_MULTI_ROUTE_VSEQ",
               $sformatf("%s\n%s",
                  $sformatf("no accessible slaves from master[%s]", master_port.name),
                  "Please check constraints and assignements to <seq>.slave_ids and ensure the master can access on or more of those slaves"
               ))
      end

   endtask

   // hook method to allow the user to influence the target segments
   // by default: get the target segments based upon the routing_mechanism
   virtual task get_target_segments(cdn_stg_routing_model_port master_port,
         ref cdn_stg_routing_model_memory_segment segments[$]);

      if (routing_mechanism inside {TO_RANDOM_SEGMENTS,
               TO_MAPPED_SEGMENTS,
               TO_UNMAPPED_SEGMENTS,
               TO_INTERNAL_SEGMENTS,
               TO_ILLEGAL_MAPPED_SEGMENTS}) begin

         routing_model.get_target_segments(routing_mechanism, master_port, segments, 1);
         if (segments.size() == 0)
         begin
            `uvm_warning("MULTI_MASTER_MULTI_ROUTE_VSEQ",
               $sformatf("no target segments found for port[%s] using %s routing mechanism",
                  master_port.name, routing_mechanism.name()));
         end
      end

   endtask

   // body
   virtual task body();
      `uvm_info("MULTI_MASTER_MULTI_ROUTE_VSEQ", {get_type_name()," sequence running..."}, UVM_LOW)


      // hook task to allow ids to be initialized
      initialize_ids();

      if (master_ids.size() == 0)
         `uvm_fatal("MULTI_MASTER_MULTI_ROUTE_VSEQ",
            "no master_ids provided, did you implement initialize_ids()?");
      if (routing_mechanism == TO_SLAVES && slave_ids.size() == 0)
         `uvm_fatal("MULTI_MASTER_MULTI_ROUTE_VSEQ",
            "no slave_ids provided, did you implement initialize_ids()?");

      // hook task to validate datapath for initialized ids
      validate_route_for_initialized_ids();

      // initialize all_active_masters
      routing_model.get_active_masters(all_active_masters);
      // masters_to_drive is a subset of all_active_masters whose port_id is in master_ids
      masters_to_drive = all_active_masters.find(mpd) with (routing_model.get_port_id(mpd) inside {master_ids});
      // check there are some masters_to_drive
      if (masters_to_drive.size() == 0)
         `uvm_fatal("MULTI_MASTER_MULTI_ROUTE_VSEQ",
            "failed to find masters_to_drive, please check initialization of master_ids")

      // initialize all_accessible_slaves
      routing_model.get_slaves(all_accessible_slaves);
      // drive all slaves by default
      slaves_to_drive = all_accessible_slaves;
      if (routing_mechanism == TO_SLAVES)
      begin
         // if the routing mechanism is TO_SLAVES then
         // slaves_to_drive is a subset of all_accessible_slaves whose port_id is in slave_ids
         slaves_to_drive = all_accessible_slaves.find(spd) with (routing_model.get_port_id(spd) inside {slave_ids});
         if (slaves_to_drive.size() == 0)
            `uvm_fatal("MULTI_MASTER_MULTI_ROUTE_VSEQ",
               "failed to find slaves_to_drive, please check initialization of slave_ids")
      end

      // initialize the sequencer queues
      masters_to_drive_ids = new[masters_to_drive.size()];
      master_sequencers = new[masters_to_drive.size()];
      slave_desc_ids = new[slaves_to_drive.size()];
      slaves_to_drive_ids = new[slaves_to_drive.size()];
      slave_sequencers = new[slaves_to_drive.size()];

      // initiate traffic from each master port (from master_ids)
      //  to each slave (from slave_ids) that it can access
      // drive stimulus on master and slave interfaces
      fork : firstof
         begin
            fork : multi_master_multi_route_stimulus

               // master stimulus
               begin : master_stimulus

                  // Start each master sequence in a thread of its own
                  foreach (masters_to_drive[i])
                  begin
                     int index = i;
                     int unsigned target_slave_ids[$];
                     cdn_stg_routing_model_memory_segment target_segments[$];

                     masters_to_drive_ids[i] = routing_model.get_port_id(masters_to_drive[i]);
                     master_sequencers[i] = masters_to_drive[i].choose_ext_sequencer();

                     // target slaves accessible by this master AND in the list of slave_ids
                     get_target_slave_ids(masters_to_drive[i], target_slave_ids);
                     // target segments accessibe by this master
                     get_target_segments(masters_to_drive[i], target_segments);

                     fork
                        invoke_routing_master_seq_on (master_sequencers[index],
                           masters_to_drive_ids[index],
                           target_slave_ids,
                           target_segments,
                           item_count,
                           running_master_seqs,
                           ended_master_seqs,
                           seq_addr_ratio);
                     join_none
                  end
                  // wait for all routing seq to finish
                  wait fork;

               end : master_stimulus

               // slave stimulus
               begin : slave_stimulus

                  // Start each slave sequence in a thread of its own
                  if (slaves_to_drive.size() > 0)
                  begin

                     foreach (slaves_to_drive[i])
                     begin
                        int index = i;
                        slave_desc = slaves_to_drive[i];
                        slaves_to_drive_ids[i] = routing_model.get_port_id(slave_desc);
                        if (slave_desc.p_ext_sequencers.size() > 0)
                           slave_sequencers[i] = slave_desc.choose_ext_sequencer();
                        fork
                           if (slave_sequencers[index] != null)
                              invoke_routing_slave_seq_on (slave_sequencers[index],
                                 slaves_to_drive_ids[index],
                                 running_slave_seqs,
                                 ended_slave_seqs);
                           else
                              wait(0); // wait forever to allow master stimulus to complete
                        join_none
                     end
                     // wait for all routing seq to finish
                     wait fork;

                  end else
                     wait(0); // wait forever to allow master stimulus
               // to complete when there are no active slaves

               end : slave_stimulus

            join_any : multi_master_multi_route_stimulus

         end join : firstof

      // Wait for all the master sequences to finish
      while (running_master_seqs.size() > 0)
      begin
         `uvm_info("MULTI_MASTER_MULTI_ROUTE_VSEQ",
            {$sformatf("Waiting for %d Master sequences to complete",running_master_seqs.size())},
            UVM_MEDIUM)
         @(master_seq_done);
      end

      // stop all the slave sequences after a configurable drain time
      `uvm_info("MULTI_MASTER_MULTI_ROUTE_VSEQ",
         {$sformatf("Master sequences completed. Waiting for %d cycles before stopping all slave sequences",slave_seq_drain_cycles)},
         UVM_LOW)
      repeat (slave_seq_drain_cycles)
         @(posedge p_sequencer.tap2apb_pclk_vif.clk)
      foreach (slave_sequencers[j])
         if (slave_sequencers[j] != null)
            slave_sequencers[j].stop_sequences();

   endtask // body()

endclass : dut_usb4_tc_noc_env_multi_master_multi_route_vseq


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
// Dataroute based sequences
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

//-------------------------------
// multi_master_multi_slave_vseq
//-------------------------------
class multi_master_multi_slave_vseq extends dut_usb4_tc_noc_env_multi_master_multi_route_vseq;

   `uvm_object_utils(multi_master_multi_slave_vseq)

   function new(string name = "multi_master_multi_slave_vseq");
      super.new(name);
   endfunction

   constraint routing_mechanism_to_slave_c {
      routing_mechanism == TO_SLAVES;
   }

      
   function void get_single_master();
      string interface_name;
      cdn_stg_routing_model_port master_ports[$];
	 
      if($value$plusargs("STG_INGRESS=%s", interface_name)) begin
         master_ids = new[1]; 
	 if(routing_model.get_ingress_id_by_name(interface_name)!=-1) begin
	    master_ids[0] = routing_model.get_port_id_by_name(interface_name);
	 end 
	 else begin
	    `uvm_fatal("CDN_STG_ROUTING_MODEL_BAD_PORT_NAME", 
		  $sformatf("No ingress with the name '%s'", interface_name));
	 end
      end  
      else begin  
         master_ports.push_back(routing_model.choose_active_master(1));
         master_ids = new[master_ports.size()];
         foreach (master_ports[i]) master_ids[i] = routing_model.get_port_id(master_ports[i]);
      end
   endfunction	  
   
   function void get_single_slave(bit accessible_only);

      string interface_name;
      cdn_stg_routing_model_port slave_ports[$];
	   
      if ($value$plusargs("STG_EGRESS=%s", interface_name)) begin
         slave_ids = new[1];
	 if(routing_model.get_egress_id_by_name(interface_name)!=-1) begin
	    slave_ids[0] = routing_model.get_port_id_by_name(interface_name);
	 end
	 else begin 
	    `uvm_fatal("CDN_STG_ROUTING_MODEL_BAD_PORT_NAME", 
		$sformatf("No egress with the name '%s'", interface_name));
	 end
      end
      else if(accessible_only == 1) begin
         slave_ports.push_back(routing_model.choose_slave_accessible_from_master(
	       routing_model.get_port_by_id(master_ids[0])));
         slave_ids = new[slave_ports.size()];
         foreach (slave_ports[i]) slave_ids[i] = routing_model.get_port_id(slave_ports[i]);
        
      end 
      else begin
         slave_ports.push_back(routing_model.choose_slave());
      	 slave_ids = new[slave_ports.size()];
      	foreach (slave_ports[i]) slave_ids[i] = routing_model.get_port_id(slave_ports[i]);
      end
   endfunction	

endclass : multi_master_multi_slave_vseq


//-------------------------------
// all_masters_all_slaves_vseq
//-------------------------------
class all_masters_all_slaves_vseq extends multi_master_multi_slave_vseq;

   `uvm_object_utils(all_masters_all_slaves_vseq)

   function new(string name = "all_masters_all_slaves_vseq");
      super.new(name);
   endfunction

   virtual task initialize_ids();
      cdn_stg_routing_model_port master_ports[$], slave_ports[$];

      // initialize master_ids and slave_ids
      routing_model.get_masters(master_ports);
      master_ids = new[master_ports.size()];
      foreach (master_ports[i]) master_ids[i] = routing_model.get_port_id(master_ports[i]);

      routing_model.get_slaves(slave_ports);
      slave_ids = new[slave_ports.size()];
      foreach (slave_ports[i]) slave_ids[i] = routing_model.get_port_id(slave_ports[i]);
   endtask

endclass : all_masters_all_slaves_vseq

//-------------------------------
// all_masters_single_slave_vseq
//-------------------------------
class all_masters_single_slave_vseq extends multi_master_multi_slave_vseq;

   `uvm_object_utils(all_masters_single_slave_vseq)

   function new(string name = "all_masters_single_slave_vseq");
      super.new(name);
   endfunction

   virtual task initialize_ids();
      cdn_stg_routing_model_port master_ports[$];

      // initialize master_ids and slave_ids
      bit slave_accessible_only=1;
      get_single_slave(slave_accessible_only);
      
      routing_model.get_masters_that_access_slave(
	      routing_model.get_port_by_id(slave_ids[0]), master_ports);
      master_ids = new[master_ports.size()];
      foreach (master_ports[i]) master_ids[i] = routing_model.get_port_id(master_ports[i]);
   endtask

endclass : all_masters_single_slave_vseq

//-------------------------------
// single_master_all_slaves_vseq
//-------------------------------
class single_master_all_slaves_vseq extends multi_master_multi_slave_vseq;

   `uvm_object_utils(single_master_all_slaves_vseq)

   function new(string name = "single_master_all_slaves_vseq");
      super.new(name);
   endfunction

   virtual task initialize_ids();
      cdn_stg_routing_model_port slave_ports[$];

      // initialize master_ids and slave_ids
      get_single_master();
   
      routing_model.get_slaves_accessible_from_master(
	      routing_model.get_port_by_id(master_ids[0]), slave_ports);
      slave_ids = new[slave_ports.size()];
      foreach (slave_ports[i]) slave_ids[i] = routing_model.get_port_id(slave_ports[i]);
   endtask

endclass : single_master_all_slaves_vseq

//-------------------------------
// single_master_single_slave_vseq
//-------------------------------
class single_master_single_slave_vseq extends multi_master_multi_slave_vseq;

   `uvm_object_utils(single_master_single_slave_vseq)

   function new(string name = "single_master_single_slave_vseq");
      super.new(name);
   endfunction

   virtual task initialize_ids();
      bit slave_accessible_only=1;
	   
      // initialize master_ids and slave_ids
      get_single_master();
      get_single_slave(slave_accessible_only);
   endtask

   virtual task validate_route_for_initialized_ids();
      cdn_stg_routing_model_port master_ports[$], slave_ports[$];
      cdn_stg_routing_model_port accessible_slaves[$], matched_slaves[$];

      foreach (master_ids[i]) master_ports[i] = routing_model.get_port_by_id(master_ids[i]);
      foreach (slave_ids[i]) slave_ports[i] = routing_model.get_port_by_id(slave_ids[i]);
      routing_model.get_slaves_accessible_from_master(master_ports[0],accessible_slaves);
      matched_slaves = accessible_slaves.find(x) with (x == slave_ports[0]);

      if (!(matched_slaves.size() > 0))
         `uvm_fatal("single_master_single_slave_vseq",
            $sformatf("No dataroute exists from master %0s to selected slave %0s ",master_ports[0].get_name(),slave_ports[0].get_name()))
   endtask


endclass : single_master_single_slave_vseq


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
// Segment based sequences
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

//-------------------------------
// multi_master_multi_segment_vseq
//-------------------------------
class multi_master_multi_segment_vseq extends dut_usb4_tc_noc_env_multi_master_multi_route_vseq;

   `uvm_object_utils(multi_master_multi_segment_vseq)

   function new(string name = "multi_master_multi_segment_vseq");
      super.new(name);
   endfunction

   constraint routing_mechanism_to_segment_c {
      routing_mechanism inside {TO_RANDOM_SEGMENTS,
         TO_MAPPED_SEGMENTS,
         TO_UNMAPPED_SEGMENTS,
         TO_INTERNAL_SEGMENTS,
         TO_ILLEGAL_MAPPED_SEGMENTS};
   }

   function void get_single_master(bit only_external_dataroutes);
      string interface_name;
      cdn_stg_routing_model_port master_ports[$];
	 
      if($value$plusargs("STG_INGRESS=%s", interface_name)) begin
         master_ids = new[1]; 
	     if(routing_model.get_ingress_id_by_name(interface_name)!=-1) begin
	        master_ids[0] = routing_model.get_port_id_by_name(interface_name);
	     end 
	     else begin
	        `uvm_fatal("CDN_STG_ROUTING_MODEL_BAD_PORT_NAME", 
		        $sformatf("No ingress with the name '%s'", interface_name));
	     end
      end  
      else begin  
         master_ports.push_back(routing_model.choose_active_master(only_external_dataroutes));
         master_ids = new[master_ports.size()];
         foreach (master_ports[i]) master_ids[i] = routing_model.get_port_id(master_ports[i]);
      end
   endfunction	 
endclass : multi_master_multi_segment_vseq


//-------------------------------
// single_master_mapped_segments
//-------------------------------
class single_master_mapped_segments_vseq extends multi_master_multi_segment_vseq;

   `uvm_object_utils(single_master_mapped_segments_vseq)

   function new(string name = "single_master_mapped_segments_vseq");
      super.new(name);
   endfunction

   constraint single_master_mapped_segments_vseq_c {
      routing_mechanism == TO_MAPPED_SEGMENTS;
   }

   virtual task initialize_ids();
      bit only_external_dataroutes = 1;
      cdn_stg_routing_model_port master_ports[$];

      // initialize master_ids
      get_single_master(only_external_dataroutes);

   endtask

endclass : single_master_mapped_segments_vseq


//-------------------------------
// all_masters_mapped_segments
//-------------------------------
class all_masters_mapped_segments_vseq extends multi_master_multi_segment_vseq;

   `uvm_object_utils(all_masters_mapped_segments_vseq)

   function new(string name = "all_masters_mapped_segments_vseq");
      super.new(name);
   endfunction

   constraint all_masters_mapped_segments_vseq_c {
      routing_mechanism == TO_MAPPED_SEGMENTS;
   }

   virtual task initialize_ids();
      cdn_stg_routing_model_port master_ports[$];

      // initialize master_ids
      routing_model.get_active_masters(master_ports, 1);
      master_ids = new[master_ports.size()];
      foreach (master_ports[i]) master_ids[i] = routing_model.get_port_id(master_ports[i]);
   endtask

endclass : all_masters_mapped_segments_vseq


//-------------------------------
// single_master_unmapped_segments
//-------------------------------
class single_master_unmapped_segments_vseq extends multi_master_multi_segment_vseq;

   `uvm_object_utils(single_master_unmapped_segments_vseq)

   function new(string name = "single_master_unmapped_segments_vseq");
      super.new(name);
   endfunction

   constraint single_master_unmapped_segments_vseq_c {
      routing_mechanism == TO_UNMAPPED_SEGMENTS;
   }

   virtual task initialize_ids();
      bit only_external_dataroutes = 0;
      cdn_stg_routing_model_port master_ports[$];

      // initialize master_ids
      get_single_master(only_external_dataroutes);
   endtask

endclass : single_master_unmapped_segments_vseq


//-------------------------------
// all_masters_unmapped_segments
//-------------------------------
class all_masters_unmapped_segments_vseq extends multi_master_multi_segment_vseq;

   `uvm_object_utils(all_masters_unmapped_segments_vseq)

   function new(string name = "all_masters_unmapped_segments_vseq");
      super.new(name);
   endfunction

   constraint all_masters_unmapped_segments_vseq_c {
      routing_mechanism == TO_UNMAPPED_SEGMENTS;
   }

   virtual task initialize_ids();
      cdn_stg_routing_model_port master_ports[$];

      // initialize master_ids
      routing_model.get_active_masters(master_ports, 0);
      master_ids = new[master_ports.size()];
      foreach (master_ports[i]) master_ids[i] = routing_model.get_port_id(master_ports[i]);
   endtask

endclass : all_masters_unmapped_segments_vseq

//-------------------------------
// single_master_internal_segments
//-------------------------------
class single_master_internal_segments_vseq extends multi_master_multi_segment_vseq;

   `uvm_object_utils(single_master_internal_segments_vseq)

   function new(string name = "single_master_internal_segments_vseq");
      super.new(name);
   endfunction

   constraint single_master_internal_segments_vseq_c {
      routing_mechanism == TO_INTERNAL_SEGMENTS;
   }

   virtual task initialize_ids();
      bit only_external_dataroutes = 0;
      cdn_stg_routing_model_port master_ports[$];

      // initialize master_ids
      get_single_master(only_external_dataroutes);
   endtask

endclass : single_master_internal_segments_vseq

//-------------------------------
// all_masters_internal_segments
//-------------------------------
class all_masters_internal_segments_vseq extends multi_master_multi_segment_vseq;

   `uvm_object_utils(all_masters_internal_segments_vseq)

   function new(string name = "all_masters_internal_segments_vseq");
      super.new(name);
   endfunction

   constraint all_masters_internal_segments_vseq_c {
      routing_mechanism == TO_INTERNAL_SEGMENTS;
   }

   virtual task initialize_ids();
      cdn_stg_routing_model_port master_ports[$];

      // initialize master_ids
      routing_model.get_active_masters(master_ports, 0);
      master_ids = new[master_ports.size()];
      foreach (master_ports[i]) master_ids[i] = routing_model.get_port_id(master_ports[i]);
   endtask

endclass : all_masters_internal_segments_vseq

//-------------------------------
// single_master_illegal_mapped_segments
//-------------------------------
class single_master_illegal_mapped_segments_vseq extends multi_master_multi_segment_vseq;

   `uvm_object_utils(single_master_illegal_mapped_segments_vseq)

   function new(string name = "single_master_illegal_mapped_segments_vseq");
      super.new(name);
   endfunction

   constraint single_master_illegal_mapped_segments_vseq_c {
      routing_mechanism == TO_ILLEGAL_MAPPED_SEGMENTS;
   }

   virtual task initialize_ids();
      bit only_external_dataroutes = 0;
      cdn_stg_routing_model_port master_ports[$];

      // initialize master_ids
      get_single_master(only_external_dataroutes);

   endtask

endclass : single_master_illegal_mapped_segments_vseq


//-------------------------------
// all_masters_illegal_mapped_segments
//-------------------------------
class all_masters_illegal_mapped_segments_vseq extends multi_master_multi_segment_vseq;

   `uvm_object_utils(all_masters_illegal_mapped_segments_vseq)

   function new(string name = "all_masters_illegal_mapped_segments_vseq");
      super.new(name);
   endfunction

   constraint all_masters_illegal_mapped_segments_vseq_c {
      routing_mechanism == TO_ILLEGAL_MAPPED_SEGMENTS;
   }

   virtual task initialize_ids();
      cdn_stg_routing_model_port master_ports[$];

      // initialize master_ids
      routing_model.get_active_masters(master_ports, 0);
      master_ids = new[master_ports.size()];
      foreach (master_ports[i]) master_ids[i] = routing_model.get_port_id(master_ports[i]);
   endtask

endclass : all_masters_illegal_mapped_segments_vseq


//-------------------------------
// single_master_random_segments
//-------------------------------
class single_master_random_segments_vseq extends multi_master_multi_segment_vseq;

   `uvm_object_utils(single_master_random_segments_vseq)

   function new(string name = "single_master_random_segments_vseq");
      super.new(name);
   endfunction

   constraint single_master_random_segments_vseq_c {
      routing_mechanism == TO_RANDOM_SEGMENTS;
   }

   virtual task initialize_ids();
      bit only_external_dataroutes = 1;
      cdn_stg_routing_model_port master_ports[$];

      // initialize master_ids
      get_single_master(only_external_dataroutes);

   endtask

endclass : single_master_random_segments_vseq


//-------------------------------
// all_masters_random_segments
//-------------------------------
class all_masters_random_segments_vseq extends multi_master_multi_segment_vseq;

   `uvm_object_utils(all_masters_random_segments_vseq)

   function new(string name = "all_masters_random_segments_vseq");
      super.new(name);
   endfunction

   constraint all_masters_random_segments_vseq_c {
      routing_mechanism == TO_RANDOM_SEGMENTS;
   }

   virtual task initialize_ids();
      cdn_stg_routing_model_port master_ports[$];

      // initialize master_ids
      routing_model.get_active_masters(master_ports, 1);
      master_ids = new[master_ports.size()];
      foreach (master_ports[i]) master_ids[i] = routing_model.get_port_id(master_ports[i]);
   endtask

endclass : all_masters_random_segments_vseq



//------------------------------------------------------------------------------
//
// test-level virtual sequences
//
//------------------------------------------------------------------------------

//-------------------------------
// dut_usb4_tc_noc_env_base_vseq_test
//-------------------------------
class dut_usb4_tc_noc_env_base_vseq_test extends dut_usb4_tc_noc_env_base_vseq;

   dut_usb4_tc_noc_env_configure_tb_vseq configure_tb_seq;
   dut_usb4_tc_noc_env_configure_dut_vseq configure_dut_seq;

   `uvm_object_utils_begin(dut_usb4_tc_noc_env_base_vseq_test)
      `uvm_field_object (configure_tb_seq, UVM_DEFAULT)
      `uvm_field_object (configure_dut_seq, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "dut_usb4_tc_noc_env_base_vseq_test");
      super.new(name);
   endfunction

   virtual task config_ur_scenario_if_set(string scenario_name, bit is_start_scenario);
      // scenario recording is enabled via the 'stg -sim ... -enable_ur' flag
      // and is required in both build (compile/elaborate) and run (simulation) invocations of stg
      `ifdef STG_ENABLE_UR
         int scenario_status;
         if(is_start_scenario) begin
            scenario_status = CDN_UR_SCENARIO_START;
         end else begin
            scenario_status = CDN_UR_SCENARIO_END;
         end
         
         cdnURSetGlobalCfgStrVal(CDN_UR_GLOBAL_CFG_SCENARIO_NAME, scenario_name);
         cdnURSetGlobalCfgIntVal(CDN_UR_GLOBAL_CFG_SCENARIO_STATUS, scenario_status);

         `uvm_info("CONFIGURE_UR_SCENARIO", 
		{$sformatf("Configuring the %s of the %s scenario ", (is_start_scenario ? "start" : "end"), scenario_name)}
		, UVM_HIGH)

      `endif // STG_ENABLE_UR
   endtask

   // hook task to allow the user to configure the TB VIP agents
   virtual task configure_tb();
      `uvm_info("CONFIGURE_TB", {"Executing configure_tb..."}, UVM_LOW)
      `uvm_do(configure_tb_seq)
   endtask

   // hook task to allow the user the configure the DUT
   virtual task configure_dut();
      `uvm_info("CONFIGURE_DUT", {"Executing configure_dut..."}, UVM_LOW)
      `uvm_do(configure_dut_seq)
   endtask

   // hook task to allow the user to implement their own test stimulus
   virtual task do_stimulus();
      `uvm_info("DO_STIMULUS", {"Executing do_stimulus in sequence ", get_type_name()}, UVM_LOW)
   endtask
   
   virtual task wait_custom_reset();
      `uvm_info("STG_CUSTOM_END_RESET_EVENT", "Waiting for STG custom reset", UVM_LOW)
      stg_end_rst.wait_ptrigger();
      `uvm_info("STG_CUSTOM_END_RESET_EVENT", "Finished STG custom reset", UVM_LOW)	
   endtask

   virtual task wait_configure_dut_event();
      `uvm_info("STG_CONFIGURE_DUT_EVENT", "Waiting for STG configure DUT event", UVM_LOW)
      stg_configure_dut_event.wait_ptrigger();
      `uvm_info("STG_CONFIGURE_DUT_EVENT", "Finished waiting for STG configure DUT event", UVM_LOW)      
   endtask   

   // body
   virtual task body();
      
      string clocking_info;
      string clock_pairs[$];
      string clk_info[$];
      int reset_clk_freq;
      real reset_init_delay;
      
      `uvm_info(get_name(), "****** CLOCK FREQUENCY CONTROL ******", UVM_NONE)
      
      fork
        begin
          if($value$plusargs("reset_clk_freq=%0d", reset_clk_freq)) begin
            reset_init_delay = 10000000 / reset_clk_freq; // (10 clock cycles of clock in ps)

            while(!p_sequencer.rst_n_vif.is_inreset())
              #1;

            while(p_sequencer.rst_n_vif.is_inreset())
              #1;

            p_sequencer.rst_n_vif.start_reset();
            #reset_init_delay;
		        p_sequencer.rst_n_vif.end_reset();

          end
        end
 
        begin
          if($value$plusargs("clocking_info=%s", clocking_info)) begin
            string clk_name, freq_str;
            int clock_freq;
      
            uvm_split_string(clocking_info, ",", clock_pairs);
      
            foreach (clock_pairs[i]) begin
              uvm_split_string(clock_pairs[i], ":", clk_info);
      
              if($sscanf(clk_info[1], "%0d", clock_freq)) begin
                string clk_vif_name = $sformatf("%s_vif",clk_info[0]);
                 
                // All possible clock VIFs 
                if(clk_vif_name == "tap2apb_pclk_vif")
                  p_sequencer.tap2apb_pclk_vif.set_clock_freq_in_mhz(clock_freq);
                if(clk_vif_name == "noc_clk_vif")
                  p_sequencer.noc_clk_vif.set_clock_freq_in_mhz(clock_freq);

              end
            end
          end
        end
      join
      disable fork;
      
      `uvm_info(get_name(), "****** END OF CLOCK FREQUENCY CONTROL ******", UVM_NONE)

      // configure the testbench

      configure_tb();

      if (wait_for_rst_enabled) begin
        // wait for reset done
      	config_ur_scenario_if_set("wait_for_reset", 1);	      
        p_sequencer.wait_for_rst_done();
        config_ur_scenario_if_set("wait_for_reset", 0);
      end

      `ifdef STG_CUSTOM_END_RESET_EVENT
        config_ur_scenario_if_set("wait_for_stg_custom_reset", 1);
        wait_custom_reset();
        config_ur_scenario_if_set("wait_for_stg_custom_reset", 0);
      `endif

      // configure the DUT
      config_ur_scenario_if_set("configure_dut", 1);
      configure_dut();
      config_ur_scenario_if_set("configure_dut", 0);
      
      `ifdef STG_CONFIGURE_DUT_EVENT
        config_ur_scenario_if_set("wait_for_stg_configure_dut_event", 1);		
        wait_configure_dut_event();	
        config_ur_scenario_if_set("wait_for_stg_configure_dut_event", 0);	
      `endif      

      // do the test stimulus
      config_ur_scenario_if_set("do_stimulus", 1);
      do_stimulus();
      config_ur_scenario_if_set("do_stimulus", 0);

   endtask // body

endclass : dut_usb4_tc_noc_env_base_vseq_test

//-------------------------------
// all_masters_all_slaves_vseq_test
//-------------------------------
class all_masters_all_slaves_vseq_test extends dut_usb4_tc_noc_env_base_vseq_test;

   all_masters_all_slaves_vseq all_masters_all_slaves;

   `uvm_object_utils_begin(all_masters_all_slaves_vseq_test)
      `uvm_field_object (all_masters_all_slaves, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "all_masters_all_slaves_vseq_test");
      super.new(name);
   endfunction

   virtual task do_stimulus();
      super.do_stimulus();
      `uvm_do(all_masters_all_slaves)
   endtask

endclass : all_masters_all_slaves_vseq_test


//-------------------------------
// all_masters_single_slave_vseq_test
//-------------------------------
class all_masters_single_slave_vseq_test extends dut_usb4_tc_noc_env_base_vseq_test;

   all_masters_single_slave_vseq all_masters_single_slave;

   `uvm_object_utils_begin(all_masters_single_slave_vseq_test)
      `uvm_field_object (all_masters_single_slave, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "all_masters_single_slave_vseq_test");
      super.new(name);
   endfunction

   virtual task do_stimulus();
      super.do_stimulus();
      `uvm_do(all_masters_single_slave)
   endtask // body

endclass : all_masters_single_slave_vseq_test


//-------------------------------
// single_master_all_slaves_vseq_test
//-------------------------------
class single_master_all_slaves_vseq_test extends dut_usb4_tc_noc_env_base_vseq_test;

   single_master_all_slaves_vseq single_master_all_slaves;

   `uvm_object_utils_begin(single_master_all_slaves_vseq_test)
      `uvm_field_object (single_master_all_slaves, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "single_master_all_slaves_vseq_test");
      super.new(name);
   endfunction

   virtual task do_stimulus();
      super.do_stimulus();
      `uvm_do(single_master_all_slaves)
   endtask // body

endclass : single_master_all_slaves_vseq_test


//-------------------------------
// single_master_single_slave_vseq_test
//-------------------------------
class single_master_single_slave_vseq_test extends dut_usb4_tc_noc_env_base_vseq_test;

   single_master_single_slave_vseq single_master_single_slave;

   `uvm_object_utils_begin(single_master_single_slave_vseq_test)
      `uvm_field_object (single_master_single_slave, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "single_master_single_slave_vseq_test");
      super.new(name);
   endfunction

   virtual task do_stimulus();
      super.do_stimulus();
      `uvm_do(single_master_single_slave)
   endtask // body

endclass : single_master_single_slave_vseq_test


//-------------------------------
// single_master_mapped_segments
//-------------------------------
class single_master_mapped_segments_vseq_test extends dut_usb4_tc_noc_env_base_vseq_test;

   single_master_mapped_segments_vseq single_master_mapped_segments;

   `uvm_object_utils_begin(single_master_mapped_segments_vseq_test)
      `uvm_field_object (single_master_mapped_segments, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "single_master_mapped_segments_vseq_test");
      super.new(name);
   endfunction

   virtual task do_stimulus();
      super.do_stimulus();
      `uvm_do(single_master_mapped_segments)
   endtask // body

endclass : single_master_mapped_segments_vseq_test


//-------------------------------
// all_masters_mapped_segments
//-------------------------------
class all_masters_mapped_segments_vseq_test extends dut_usb4_tc_noc_env_base_vseq_test;

   all_masters_mapped_segments_vseq all_masters_mapped_segments;

   `uvm_object_utils_begin(all_masters_mapped_segments_vseq_test)
      `uvm_field_object (all_masters_mapped_segments, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "all_masters_mapped_segments_vseq_test");
      super.new(name);
   endfunction

   virtual task do_stimulus();
      super.do_stimulus();
      `uvm_do(all_masters_mapped_segments)
   endtask // body

endclass : all_masters_mapped_segments_vseq_test


//-------------------------------
// single_master_unmapped_segments
//-------------------------------
class single_master_unmapped_segments_vseq_test extends dut_usb4_tc_noc_env_base_vseq_test;

   single_master_unmapped_segments_vseq single_master_unmapped_segments;

   `uvm_object_utils_begin(single_master_unmapped_segments_vseq_test)
      `uvm_field_object (single_master_unmapped_segments, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "single_master_unmapped_segments_vseq_test");
      super.new(name);
   endfunction

   virtual task do_stimulus();
      super.do_stimulus();
      `uvm_do(single_master_unmapped_segments)
   endtask // body

endclass : single_master_unmapped_segments_vseq_test


//-------------------------------
// all_masters_unmapped_segments
//-------------------------------
class all_masters_unmapped_segments_vseq_test extends dut_usb4_tc_noc_env_base_vseq_test;

   all_masters_unmapped_segments_vseq all_masters_unmapped_segments;

   `uvm_object_utils_begin(all_masters_unmapped_segments_vseq_test)
      `uvm_field_object (all_masters_unmapped_segments, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "all_masters_unmapped_segments_vseq_test");
      super.new(name);
   endfunction

   virtual task do_stimulus();
      super.do_stimulus();
      `uvm_do(all_masters_unmapped_segments)
   endtask // body

endclass : all_masters_unmapped_segments_vseq_test


//-------------------------------
// single_master_internal_segments
//-------------------------------
class single_master_internal_segments_vseq_test extends dut_usb4_tc_noc_env_base_vseq_test;

   single_master_internal_segments_vseq single_master_internal_segments;

   `uvm_object_utils_begin(single_master_internal_segments_vseq_test)
      `uvm_field_object (single_master_internal_segments, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "single_master_internal_segments_vseq_test");
      super.new(name);
   endfunction

   virtual task do_stimulus();
      super.do_stimulus();
      `uvm_do(single_master_internal_segments)
   endtask // body

endclass : single_master_internal_segments_vseq_test


//-------------------------------
// all_masters_internal_segments
//-------------------------------
class all_masters_internal_segments_vseq_test extends dut_usb4_tc_noc_env_base_vseq_test;

   all_masters_internal_segments_vseq all_masters_internal_segments;

   `uvm_object_utils_begin(all_masters_internal_segments_vseq_test)
      `uvm_field_object (all_masters_internal_segments, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "all_masters_internal_segments_vseq_test");
      super.new(name);
   endfunction

   virtual task do_stimulus();
      super.do_stimulus();
      `uvm_do(all_masters_internal_segments)
   endtask // body

endclass : all_masters_internal_segments_vseq_test


//-------------------------------
// single_master_illegal_mapped_segments
//-------------------------------
class single_master_illegal_mapped_segments_vseq_test extends dut_usb4_tc_noc_env_base_vseq_test;

   single_master_illegal_mapped_segments_vseq single_master_illegal_mapped_segments;

   `uvm_object_utils_begin(single_master_illegal_mapped_segments_vseq_test)
      `uvm_field_object (single_master_illegal_mapped_segments, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "single_master_illegal_mapped_segments_vseq_test");
      super.new(name);
   endfunction

   virtual task do_stimulus();
      super.do_stimulus();
      `uvm_do(single_master_illegal_mapped_segments)
   endtask // body

endclass : single_master_illegal_mapped_segments_vseq_test


//-------------------------------
// all_masters_illegal_mapped_segments
//-------------------------------
class all_masters_illegal_mapped_segments_vseq_test extends dut_usb4_tc_noc_env_base_vseq_test;

   all_masters_illegal_mapped_segments_vseq all_masters_illegal_mapped_segments;

   `uvm_object_utils_begin(all_masters_illegal_mapped_segments_vseq_test)
      `uvm_field_object (all_masters_illegal_mapped_segments, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "all_masters_illegal_mapped_segments_vseq_test");
      super.new(name);
   endfunction

   virtual task do_stimulus();
      super.do_stimulus();
      `uvm_do(all_masters_illegal_mapped_segments)
   endtask // body

endclass : all_masters_illegal_mapped_segments_vseq_test


//-------------------------------
// single_master_random_segments
//-------------------------------
class single_master_random_segments_vseq_test extends dut_usb4_tc_noc_env_base_vseq_test;

   single_master_random_segments_vseq single_master_random_segments;

   `uvm_object_utils_begin(single_master_random_segments_vseq_test)
      `uvm_field_object (single_master_random_segments, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "single_master_random_segments_vseq_test");
      super.new(name);
   endfunction

   virtual task do_stimulus();
      super.do_stimulus();
      `uvm_do(single_master_random_segments)
   endtask // body

endclass : single_master_random_segments_vseq_test


//-------------------------------
// all_masters_random_segments
//-------------------------------
class all_masters_random_segments_vseq_test extends dut_usb4_tc_noc_env_base_vseq_test;

   all_masters_random_segments_vseq all_masters_random_segments;

   `uvm_object_utils_begin(all_masters_random_segments_vseq_test)
      `uvm_field_object (all_masters_random_segments, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "all_masters_random_segments_vseq_test");
      super.new(name);
   endfunction

   virtual task do_stimulus();
      super.do_stimulus();
      `uvm_do(all_masters_random_segments)
   endtask // body

endclass : all_masters_random_segments_vseq_test

//-------------------------------
// custom_reset_and_configure_dut_event_vseq_test
// use these defines to see effect: 
// -define STG_CUSTOM_END_RESET_EVENT
// -define STG_CONFIGURE_DUT_EVENT
// +UVM_VERBOSITY=LOW
//-------------------------------
class custom_reset_and_configure_dut_event_vseq_test extends dut_usb4_tc_noc_env_base_vseq_test;

   single_master_single_slave_vseq single_master_single_slave;

   `uvm_object_utils_begin(custom_reset_and_configure_dut_event_vseq_test)
      `uvm_field_object (single_master_single_slave, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "custom_reset_and_configure_dut_event_vseq_test");
      super.new(name);
   endfunction
   
	virtual task wait_custom_reset();
		fork : custom_reset
	   		super.wait_custom_reset();
			
			begin
				`uvm_info(get_name(), $sformatf("[%0t] waiting=>...", $time), UVM_LOW)
				#1us;
				stg_end_rst.trigger();
				`uvm_info(get_name(), $sformatf("[%0t] done waiting=>...", $time), UVM_LOW)
			end
		join : custom_reset
	endtask
	
	virtual task wait_configure_dut_event();
		fork : configure_dut_event
	   		super.wait_configure_dut_event();
			
			begin
				`uvm_info(get_name(), $sformatf("[%0t] waiting=>...", $time), UVM_LOW)
				#3us;
				stg_configure_dut_event.trigger();
				`uvm_info(get_name(), $sformatf("[%0t] done waiting=>...", $time), UVM_LOW)
			end
		join : configure_dut_event
   endtask	

   virtual task do_stimulus();
      super.do_stimulus();
      `uvm_do(single_master_single_slave)
   endtask

endclass : custom_reset_and_configure_dut_event_vseq_test

//-------------------------------
// clock_and_reset_control
//-------------------------------
class clock_and_reset_control_vseq_test extends dut_usb4_tc_noc_env_base_vseq_test;

	`uvm_object_utils(clock_and_reset_control_vseq_test)

	  function new(string name = "clock_and_reset_control_vseq_test");
	    super.new(name);        
	  endfunction : new 
	
	
	  
  virtual task body();
	  `uvm_info(get_name(), "**************** UVM CLOCK'N'RESET CONTROL DEMO ****************", UVM_NONE)
	  `uvm_info(get_name(), "Run first 1000ns with default clock/reset settings", UVM_NONE)
	  
	  fork
		  #5000ns;
		  begin
			#2000ns;
		  	p_sequencer.rst_n_vif.start_reset();
			#300ns;
			p_sequencer.rst_n_vif.end_reset();
		  end
		  begin
			  #1000ns;
			  p_sequencer.tap2apb_pclk_vif.enable_clock();
			  #1000ns;
			  p_sequencer.tap2apb_pclk_vif.set_asymmetric_clock(200,800);
			  #1000ns;
			  p_sequencer.tap2apb_pclk_vif.pause_clock();
			  #1000ns;
			  p_sequencer.tap2apb_pclk_vif.resume_clock();
			  #1000ns;
			  p_sequencer.tap2apb_pclk_vif.set_clock_freq_in_mhz(0.5);
			  #6000ns;
			  p_sequencer.tap2apb_pclk_vif.set_symmetric_clock(1000);
			  #1000ns;
			  p_sequencer.tap2apb_pclk_vif.disable_clock();
			  #1000ns;
			  p_sequencer.tap2apb_pclk_vif.enable_clock();
		  end
	  join
	  disable fork;

	  `uvm_info(get_name(), "**************** END OF DEMO ****************", UVM_NONE)
  endtask
	
endclass : clock_and_reset_control_vseq_test


