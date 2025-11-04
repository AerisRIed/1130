
//
// Template for UVM-compliant testcase

`ifndef CDN_PHY_BRING_UP_TEST_BASE__SV
`define CDN_PHY_BRING_UP_TEST_BASE__SV

class cdn_phy_bring_up_test_base extends cdn_phy_test_base;

  cdn_phy_env_base   base_env;

  string report_id = "cdn_phy_bring_up_test_base";

  `uvm_component_utils(cdn_phy_bring_up_test_base)
 
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    base_env = cdn_phy_env_base::type_id::create("base_env",this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
  endfunction
  
  virtual task configure_phase (uvm_phase phase);
    super.configure_phase(phase);
  endtask:configure_phase

  

endclass : cdn_phy_bring_up_test_base

`endif //TEST__SV

