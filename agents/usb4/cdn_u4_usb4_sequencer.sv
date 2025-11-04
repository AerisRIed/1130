//
// Template for UVM-compliant sequencer class
//


`ifndef CDN_USB4_PHY_SEQUENCER__SV
`define CDN_USB4_PHY_SEQUENCER__SV


class cdn_u4_usb4_sequencer extends cdn_phy_sequencer_base # (cdn_u4_usb4_ltssm_instruction);

   `uvm_component_utils(cdn_u4_usb4_sequencer)
   
   cdn_u4_usb4_symbol_pattern symbol_pattern;
   cdn_u4_usb4_port_status port_status;
   cdn_u4_usb4_physical_timer_cfg timer_cfg;
   
   function new (string name,
                 uvm_component parent);
   super.new(name,parent);
   symbol_pattern= new("symbol_pattern");
   endfunction:new 
endclass:cdn_u4_usb4_sequencer

`endif // CDN_PHY_SEQUENCER_BASE__SV
