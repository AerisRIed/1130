class usb4_cl1_entry_host_request_sequence extends usb4_base_sequence;
  
    cdn_u4_usb4_instruction_sequence host_seq; 
    cdn_u4_usb4_instruction_sequence device_seq; 
    //facyory
    `uvm_object_utils(usb4_cl1_entry_host_request_sequence)
    `uvm_declare_p_sequencer(cdn_u4_usb4_virtual_sequencer)
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "usb4_cl1_entry_host_request_sequence");
        super.new(name);
    endfunction : new

    extern task body();
    extern task host_cl1_entry_req();
    extern task device_cl1_entry_req();
endclass

task usb4_cl1_entry_host_request_sequence::host_cl1_entry_req();
        host_seq = new("host_seq");
        //host_seq.ltssm_instruction.u2_entry_req = 1;
        host_seq.start(p_sequencer.host_sequencer);
endtask
    
task usb4_cl1_entry_host_request_sequence::device_cl1_entry_req();
        device_seq = new("host_seq");
        //device_seq.ltssm_instruction.u2_entry_req = 1;
        device_seq.start(p_sequencer.device_sequencer);
endtask

task usb4_cl1_entry_host_request_sequence::body();
/*{{{*/
fork
    begin
        host_cl1_entry_req();
    end
    
    begin
        #p_sequencer.host_sequencer.timer_cfg.decode_latency;
        device_cl1_entry_req();
    end
join
endtask : body /*}}}*/
