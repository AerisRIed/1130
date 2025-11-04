class cdn_u4_usb4_virtual_sequencer extends cdn_phy_virtual_sequencer_base;

   `uvm_component_utils(cdn_u4_usb4_virtual_sequencer)
     
   cdn_u4_usb4_sequencer   host_sequencer;
   cdn_u4_usb4_sequencer   device_sequencer;
   cdn_u4_usb4_physical_timer_cfg timer_cfg;
   function new (string name,
                 uvm_component parent);
   super.new(name,parent);
   endfunction:new 

endclass
