`ifndef CDN_JTAG_1687_AGENT_SV
`define CDN_JTAG_1687_AGENT_SV
 //File name    :: cdn_jtag_agent.sv
 //class name   :: cdn_jtag_agent
 //Description  :: This component mainly used to hold cdn_jtag_sequencer,cdn_jtag_driver,cdn_jtag_monitor components
 class cdn_jtag_1687_agent extends uvm_agent;
  //Factory registration
  `uvm_component_utils(cdn_jtag_1687_agent)

  //report id
  string report_id = "CDN_JTAG_1687_AGENT_C";

  //dfi interface
  virtual cdn_jtag_1687_interface jtag_1687_vif;


  //sub-components
  cdn_jtag_1687_sequencer jtag_1687_sqr;
  cdn_jtag_1687_driver    jtag_1687_drv;

  //New constructor 
  function new(string name="cdn_jtag_1687_agent",uvm_component parent);
   super.new(name,parent);
   `uvm_info(report_id,"Inside of class",UVM_DEBUG)
  endfunction:new


  //Method      :: function 
  //Name        :: Build_phase
  //Args        :: phase
  //Return type :: void
  //Description :: Build_phase mainly used to build sub-components and tlm ports
  function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   `uvm_info(report_id,$sformatf("Starting of _%s_",phase.get_name()),UVM_LOW)
   
    jtag_1687_sqr  = cdn_jtag_1687_sequencer::type_id::create("jtag_1687_sqr",this);  //Creates jtag sequencer component
    jtag_1687_drv  = cdn_jtag_1687_driver::type_id::create("jtag_1687_drv",this);     //Creates jtag driver component

   `uvm_info(report_id,$sformatf("Ending of _%s_",phase.get_name()),UVM_LOW)
  endfunction:build_phase

  //Method      :: Function
  //Name        :: Connect_phase
  //Args        :: phase
  //Return type :: void
  //Description :: Connect_phase used to get the configuration class and conenct the tlm ports
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

   `uvm_info(report_id,$sformatf("Starting of _%s_",phase.get_name()),UVM_LOW)

   //Connection of driver seq item pull port to sequencer pull export
   jtag_1687_drv.seq_item_port.connect(jtag_1687_sqr.seq_item_export); 

   `uvm_info(report_id,$sformatf("Ending of _%s_",phase.get_name()),UVM_LOW)
  endfunction:connect_phase

 
 endclass:cdn_jtag_1687_agent

`endif //CDN_JTAG_1687_AGENT_SV

