class usb32_u1_exit_host_request_sequence extends usb32_base_sequence;
  
    cdn_u4_usb32_instruction_sequence host_seq; 
    cdn_u4_usb32_instruction_sequence device_seq; 
    //facyory
    `uvm_object_utils(usb32_u1_exit_host_request_sequence)
    `uvm_declare_p_sequencer(cdn_u4_usb32_virtual_sequencer)
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "usb32_u1_exit_host_request_sequence");
        super.new(name);
    endfunction : new

    extern task body();
    extern task host_u1_exit_req();
endclass

task usb32_u1_exit_host_request_sequence::host_u1_exit_req();
        host_seq = new("host_seq");
        host_seq.ltssm_instruction.loopback_exit_req= 1;
        host_seq.start(p_sequencer.host_sequencer);
endtask
    
task usb32_u1_exit_host_request_sequence::body();
/*{{{*/
    host_u1_exit_req();
endtask : body /*}}}*/
