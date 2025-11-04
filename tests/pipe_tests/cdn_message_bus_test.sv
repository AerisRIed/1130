//
// Template for UVM-compliant testcase
//   Architecture:       PHY
//
//------------------------------------------------------------------------------
// Description: 
// This file defines the agent for the cdn_meassage_bus UVC.
//----------------------------------------------------------------------------
`ifndef CDN_MESSAGE_BUS_TEST_SV
`define CDN_MESSAGE_BUS_TEST_SV

class cdn_message_bus_test extends cdn_u4_usb4_test_base;

  `uvm_component_utils(cdn_message_bus_test)

    //cdn_message_bus_agent message_bus_agt;
	//cdn_u4_usb4_env usb4_env;
	cdn_message_bus_sequence message_bus_seq;
    string report_id = "CDN_MESSAGE_BUS_TEST_C";
  function new(string name="cdn_message_bus_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(report_id,$sformatf("Starting of _%s_",phase.get_name()),UVM_LOW)
   // usb4_env = cdn_u4_usb4_env::type_id::create("usb4_env", this);
	message_bus_seq = cdn_message_bus_sequence::type_id::create("message_bus_seq",this);
	`uvm_info(report_id,$sformatf("Ending of _%s_",phase.get_name()),UVM_LOW)
  endfunction


virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
  endfunction
// The run task for this class will be started automatically during the
    // run phase
    virtual task dyn_main_phase();
        super.dyn_main_phase();
        uvm_report_info(get_type_name(),"Starting the test run task", UVM_LOW);
		//phase.raise_objection(this);
		message_bus_seq.start(usb4_env.message_bus_agt.message_bus_sqr[0]);
		message_bus_seq.start(usb4_env.message_bus_agt.message_bus_sqr[1]);
	    //phase.drop_objection(this);
    endtask : dyn_main_phase

endclass : cdn_message_bus_test

`endif //TEST__SV

