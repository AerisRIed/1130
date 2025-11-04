class usb32_base_sequence extends uvm_sequence;
  
   //facyory
   `uvm_object_utils(usb32_base_sequence)
   `uvm_declare_p_sequencer(cdn_u4_usb32_virtual_sequencer)
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "usb32_base_sequence");
        super.new(name);
    endfunction : new

    extern task body();
endclass

task usb32_base_sequence::body();
/*{{{*/
endtask : body /*}}}*/

