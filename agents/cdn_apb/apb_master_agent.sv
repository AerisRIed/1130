class cdnApbUvmMasterAgent extends cdnApbUvmAgent;

  `uvm_component_utils_begin(cdnApbUvmMasterAgent)        
  `uvm_component_utils_end
    
 `cdnApbDeclareVif(virtual interface cdnApb3MasterInterface#(.ADDRESS_WIDTH(18),.DATA_WIDTH(32),.NUM_OF_SLAVES(1)))
 
  // ***************************************************************
  // Method : new
  // Desc.  : Call the constructor of the parent class.
  // ***************************************************************
  function new (string name = "cdnApbUvmMasterAgent", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new      

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
  endfunction : end_of_elaboration_phase  

endclass : cdnApbUvmMasterAgent

