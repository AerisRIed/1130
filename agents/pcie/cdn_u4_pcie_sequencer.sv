//
// Template for UVM-compliant sequencer class
//


`ifndef CDN_PCIE_PHY_SEQUENCER__SV
`define CDN_PCIE_PHY_SEQUENCER__SV


class cdn_u4_pcie_sequencer extends uvm_sequencer# (cdn_u4_pcie_ltssm_instruction);

   `uvm_component_utils(cdn_u4_pcie_sequencer)

   //---------------------------------
   // UVM functions and tasks
   //---------------------------------
   extern function new(string name = "cdn_u4_pcie_sequencer", uvm_component parent); 
   extern virtual function void build_phase(uvm_phase phase);

endclass:cdn_u4_pcie_sequencer

function cdn_u4_pcie_sequencer::new(string name = "cdn_u4_pcie_sequencer", uvm_component parent);
   super.new(name, parent);
endfunction: new

function void cdn_u4_pcie_sequencer::build_phase(uvm_phase phase);
   super.build_phase(phase);
endfunction: build_phase

`endif // CDN_PHY_SEQUENCER_BASE__SV
