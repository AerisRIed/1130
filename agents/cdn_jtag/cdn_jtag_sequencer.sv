// Description:
// This file contains the detailed description of the cdn_jtag_sequencer
// UVC env.
//----------------------------------------------------------------------------
`ifndef CDN_JTAG_SEQUENCER_SV
`define CDN_JTAG_SEQUENCER_SV

 //File name    :: cdn_jtag_sequencer.sv
 //Class name   :: cdn_jtag_sequencer
 //Description  :: This Component mainly used for jtag sequencer
 class cdn_jtag_sequencer extends uvm_sequencer#(cdn_jtag_trans);
   //facory registration
   `uvm_component_utils(cdn_jtag_sequencer)

//   cdn_jtag_config jtag_cfg;

   //debug interface

    //report id
    string report_id = "CDN_JTAG_SEQUENCER_C";

    //New constructor 
    function new(string name = "cdn_jtag_sequencer",uvm_component parent);
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

 endclass:cdn_jtag_sequencer
`endif //CDN_JTAG_SEQUENCER_SV
