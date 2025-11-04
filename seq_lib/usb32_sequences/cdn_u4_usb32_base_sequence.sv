class cdn_u4_usb32_base_sequence extends uvm_sequence_base;
  
   //pipe seq
   `uvm_object_utils(cdn_u4_usb32_base_sequence)
    `uvm_declare_p_sequencer(cdn_u4_usb32_virtual_sequencer)
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "cdn_u4_usb32_base_sequence");
        super.new(name);
        set_automatic_phase_objection(1);
    endfunction : new
    extern virtual task body();
endclass

task cdn_u4_usb32_base_sequence::body();
/*{{{*/
  wait(p_sequencer.host_sequencer.port_status.usb32_ltssm_state == USB32_LINK::U0 && p_sequencer.device_sequencer.port_status.usb32_ltssm_state == USB32_LINK::U0);
   #10us; //need random delay 
endtask : body /*}}}*/
