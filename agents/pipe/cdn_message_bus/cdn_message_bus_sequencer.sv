//------------------------------------------------------------------------------
//
//   Filename:           cdn_message_bus_sequencer.sv
//   Module Name:        cdn_message_bus_sequencer
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
`ifndef CDN_MESSAGE_BUS_SEQUENCER_SV
`define CDN_MESSAGE_BUS_SEQUENCER_SV

 class cdn_message_bus_sequencer extends uvm_sequencer#(cdn_message_bus_transaction);
   //facory registration
   `uvm_component_utils(cdn_message_bus_sequencer)

   //debug interface

    //report id
    string report_id = "CDN_MESSAGE_BUS_SEQUENCER_C";

    //New constructor 
    function new(string name = "cdn_message_bus_sequencer",uvm_component parent);
     super.new(name,parent);
    endfunction:new

   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     `uvm_info(report_id,$sformatf("Starting of _%s_",phase.get_name()),UVM_LOW)
     `uvm_info(report_id,$sformatf("Ending of _%s_",phase.get_name()),UVM_LOW)
   endfunction:build_phase


   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     `uvm_info(report_id,$sformatf("Starting of _%s_",phase.get_name()),UVM_LOW)
     `uvm_info(report_id,$sformatf("Ending of _%s_",phase.get_name()),UVM_LOW)
   endfunction:connect_phase

 endclass:cdn_message_bus_sequencer
`endif //CDN_MESSAGE_BUS_SEQUENCER_SV
