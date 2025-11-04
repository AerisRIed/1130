`include "cdnVipMacros.svh"
//`ifndef CDN_USB4_UVM_USER_TYPES_SVH
//`define CDN_USB4_UVM_USER_TYPES_SVH
//`define CDN_USB4_UVM_TEST(className, sequenceName, trCount) 

class cdn_u4_usb4_vip_test_base extends cdn_phy_test_base; 

  // *************************************************************** \
  // Use the UVM registration macro for this class.  \
  // *************************************************************** \
  `uvm_component_utils(cdn_u4_usb4_vip_test_base) 
  cdnUsb4UvmUserSve         sve;
  cdn_u4_vip_base_sequence  base_seq;
  // *************************************************************** \
  // Method : new \
  // Desc.  : Call the constructor of the parent class. \
  // *************************************************************** \
  function new(string name, uvm_component parent); 
    super.new(name, parent); 
  endfunction : new 

  // *************************************************************** \
  // Method : build_phase \
  // Desc.  : set the sequenceName/count to the given parameters \
  // *************************************************************** \
  virtual function void build_phase(uvm_phase phase); 
    super.build_phase(phase);
    // set the correct sequence, etc. \
   // uvm_config_db #(uvm_object_wrapper)::set(this, 
   //                                          "sve.virSeqr.run_phase", 
   //                                          "default_sequence", 
   //                                          cdn_u4_usb4_vip_test_base::type_id::get()); 
    sve = cdnUsb4UvmUserSve::type_id::create("sve", this);
    base_seq = cdn_u4_vip_base_sequence::type_id::create("base_seq", this);
    uvm_config_db #(int)::set(this, 
                              "sve.virSeqr", 
                              "count", 
                              1); 

    // Call the corresponding method in the parent class \
    //super.build_phase(phase); 

  endfunction : build_phase 

  virtual function void connect_phase(uvm_phase phase);
        //super.connect_phase(phase);
  endfunction

task configure_phase (uvm_phase phase);
  //ToDo: Configure components here
endtask:configure_phase

 virtual task dyn_main_phase();
		`uvm_info(get_name(), $psprintf("\033[1;42m usb4_base_vip_test start \033[0m "), UVM_LOW)
				base_seq.start(sve.virSeqr);
	   `uvm_info(get_name(), $psprintf(" bring_up seq finish"), UVM_LOW)

    endtask

endclass :  cdn_u4_usb4_vip_test_base

