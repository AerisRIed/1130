class usb4_base_sequence extends uvm_sequence;
  
   //facyory
   `uvm_object_utils(usb4_base_sequence)
   `uvm_declare_p_sequencer(cdn_u4_usb4_virtual_sequencer)
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "usb4_base_sequence");
        super.new(name);
    endfunction : new

    extern task body();
endclass

task usb4_base_sequence::body();
/*{{{*/
endtask : body /*}}}*/

