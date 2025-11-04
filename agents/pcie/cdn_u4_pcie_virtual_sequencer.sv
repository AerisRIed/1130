class cdn_u4_pcie_virtual_sequencer extends uvm_sequencer;
   `uvm_component_utils(cdn_u4_pcie_virtual_sequencer)
     
   cdn_u4_pcie_sequencer   host_sequencer;
   cdn_u4_pcie_sequencer   devc_sequencer;
   cdn_phy_virtual_sequencer_base   base_vsqr;

   function new (string name,
                 uvm_component parent);
   super.new(name,parent);
   endfunction:new 

endclass
