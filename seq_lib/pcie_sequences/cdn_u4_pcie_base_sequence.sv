class cdn_u4_pcie_base_sequence extends uvm_sequence;
  
   cdn_u4_pcie_instruction_sequence host_seq; 
   cdn_u4_pcie_instruction_sequence devc_seq; 
   cdn_reset_sequence  reset_seq;
   //pipe seq
   `uvm_object_utils(cdn_u4_pcie_base_sequence)
    `uvm_declare_p_sequencer(cdn_u4_pcie_virtual_sequencer)
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "cdn_u4_pcie_base_sequence");
        super.new(name);
    endfunction : new

    extern task body();
endclass

task cdn_u4_pcie_base_sequence::body();
/*{{{*/
	#10us;
   `uvm_info(get_full_name(), $psprintf("This is base sequence!!!!!!!!!!!!!!"),UVM_LOW);
	reset_seq = new();
	//reset_seq.pipe_reset_en = 1;
	`uvm_do_on_with(reset_seq, p_sequencer.base_vsqr.m_reset_sqr[0], {pipe_reset_en ==1;})
fork
//begin
//    #50us;
//    host_seq = new("host_seq");
//    host_seq.ltssm_instruction.direct_state_transition = 1;
//    host_seq.ltssm_instruction.next_ltssm_state = PCIE_LINK::POLLING_ACTIVE;
//    host_seq.start(p_sequencer.host_sequencer);
//    #100us;
//    host_seq.ltssm_instruction.direct_state_transition = 1;
//    host_seq.ltssm_instruction.next_ltssm_state = PCIE_LINK::POLLING_CONFIG;
//    host_seq.start(p_sequencer.host_sequencer);
//    #100us;
//    host_seq.ltssm_instruction.direct_state_transition = 1;
//    host_seq.ltssm_instruction.next_ltssm_state = PCIE_LINK::CONFIGURATION_WAIT;
//    host_seq.start(p_sequencer.host_sequencer);
//    #100us;
//    host_seq.ltssm_instruction.direct_state_transition = 1;
//    host_seq.ltssm_instruction.next_ltssm_state = PCIE_LINK::CONFIGURATION_COMPLETE;
//    host_seq.start(p_sequencer.host_sequencer);
//	#100us;
//    host_seq.ltssm_instruction.direct_state_transition = 1;
//    host_seq.ltssm_instruction.next_ltssm_state = PCIE_LINK::CONFIGURATION_IDLE;
//    #10us;
//    host_seq.ltssm_instruction.direct_state_transition = 1;
//    host_seq.ltssm_instruction.next_ltssm_state = PCIE_LINK::L0;
//    host_seq.start(p_sequencer.host_sequencer);
//end
//begin
//    #50us;
//    devc_seq = new("devc_seq");
//    devc_seq.ltssm_instruction.direct_state_transition = 1;
//    devc_seq.ltssm_instruction.next_ltssm_state = PCIE_LINK::POLLING_ACTIVE;
//    devc_seq.start(p_sequencer.devc_sequencer);
//    #100us;
//    devc_seq.ltssm_instruction.direct_state_transition = 1;
//    devc_seq.ltssm_instruction.next_ltssm_state = PCIE_LINK::POLLING_CONFIG;
//    devc_seq.start(p_sequencer.devc_sequencer);
//    #100us;
//    devc_seq.ltssm_instruction.direct_state_transition = 1;
//    devc_seq.ltssm_instruction.next_ltssm_state = PCIE_LINK::CONFIGURATION_WAIT;
//    devc_seq.start(p_sequencer.devc_sequencer);
//    #100us;
//    devc_seq.ltssm_instruction.direct_state_transition = 1;
//    devc_seq.ltssm_instruction.next_ltssm_state = PCIE_LINK::CONFIGURATION_COMPLETE;
//    devc_seq.start(p_sequencer.devc_sequencer);
//	#100us;
//    devc_seq.ltssm_instruction.direct_state_transition = 1;
//    devc_seq.ltssm_instruction.next_ltssm_state = PCIE_LINK::CONFIGURATION_IDLE;
//    #10us;
//    devc_seq.ltssm_instruction.direct_state_transition = 1;
//    devc_seq.ltssm_instruction.next_ltssm_state = PCIE_LINK::L0;
//    devc_seq.start(p_sequencer.devc_sequencer);
//end 
join
    #100us;
endtask : body /*}}}*/
