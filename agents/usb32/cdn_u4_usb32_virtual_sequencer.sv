class cdn_u4_usb32_virtual_sequencer extends cdn_phy_virtual_sequencer_base;

   `uvm_component_utils(cdn_u4_usb32_virtual_sequencer)
     
   cdn_u4_usb32_sequencer   host_sequencer;
   cdn_u4_usb32_sequencer   device_sequencer;
   cdn_u4_usb32_physical_timer_cfg timer_cfg;
   function new (string name,
                 uvm_component parent);
   super.new(name,parent);
   endfunction:new 

endclass
