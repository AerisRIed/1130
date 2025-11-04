//
// Template for UVM-compliant testcase

`ifndef CDN_USB_PHY_REG_TRY_TEST__SV
`define CDN_USB_PHY_REG_TRY_TEST__SV

class cdn_usb_phy_reg_try_test extends cdn_phy_test_base;

  `uvm_component_utils(cdn_usb_phy_reg_try_test)

  //---------------------------------
  // Member components
  //---------------------------------
   cdn_phy_env_base   base_env;

  //---------------------------------
  // Member seqs
  //---------------------------------
  cdn_usb_phy_reg_seq   reg_seq;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    base_env = cdn_phy_env_base::type_id::create("base_env", this);
    reg_seq = cdn_usb_phy_reg_seq::type_id::create("reg_seq");
    dut_cfg.reg_interface_sel = APB;
  endfunction

 virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);

    `uvm_info(get_type_name(),$sformatf("Start test, %s",get_type_name() ),UVM_LOW);


    reg_seq.start(base_env.vsqr);

    #10us;

    `uvm_info(get_type_name(),$sformatf("End test, %s",get_type_name() ),UVM_LOW); 
    phase.drop_objection(this);
  endtask

endclass : cdn_usb_phy_reg_try_test

`endif // CDN_U4_DP_TEST_BASE__SV


