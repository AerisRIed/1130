//
// Template for UVM-compliant sequencer class
//


`ifndef CDN_U4_DP_SEQUENCER__SV
`define CDN_U4_DP_SEQUENCER__SV


typedef class cdn_u4_dp_transaction;

class cdn_u4_dp_sequencer extends cdn_phy_sequencer_base # (cdn_u4_dp_transaction);

   //---------------------------------
   // Member config
   //---------------------------------
   cdn_u4_dp_config  m_cfg;

   `uvm_component_utils(cdn_u4_dp_sequencer)

   //---------------------------------
   // UVM functions and tasks
   //---------------------------------
   extern function new(string name = "cdn_u4_dp_sequencer", uvm_component parent); 
   extern virtual function void build_phase(uvm_phase phase);

endclass:cdn_u4_dp_sequencer

function cdn_u4_dp_sequencer::new(string name = "cdn_u4_dp_sequencer", uvm_component parent);
   super.new(name, parent);
endfunction: new

function void cdn_u4_dp_sequencer::build_phase(uvm_phase phase);
   super.build_phase(phase);
   // get configs
   if (!uvm_config_db#(cdn_u4_dp_config)::get(this, "", "m_cfg", m_cfg)) begin
     `uvm_fatal(get_type_name(), "m_cfg not set")
   end
endfunction: build_phase

`endif // CDN_U4_DP_SEQUENCER__SV
