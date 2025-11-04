
//
// Template for UVM-compliant testcase

`ifndef CDN_ALT_MODE_PHY_TEST_BASE_SV
`define CDN_ALT_MODE_PHY_TEST_BASE_SV

class cdn_alt_mode_phy_test_base extends uvm_test;

  `uvm_component_utils(cdn_alt_mode_phy_test_base)

  //---------------------------------
  // Multi tests
  //---------------------------------

  cdn_u4_dp_test_base dp_test;
  cdn_u4_usb32_test_base usb32_test;
  uvm_cmdline_processor clp;
  string arg_values[$];
  string alt_dp_test;
  string alt_u32_test;
  clk_cfg_t    dp_clk_cfg;
  clk_cfg_t    usb32_clk_cfg;

  //---------------------------------------------
  // Member apb & jtag & regmodel components
  //---------------------------------------------

  // ---------------- host ---------------- //
  cdnApbUvmMasterAgent         apb_mst_agent;
  cdnApbUvmConfig              apb_mst_cfg;
  cdn_usb_phy_top_regmodel     regmodel_phy; 
  
  u4_apb_reg_adapter           reg2apb;
  uvm_reg_predictor#(denaliCdn_apbTransaction) reg_predict;
  
  cdn_jtag_agent               jtag_agent;
  jtag_reg_adapter             reg2jtag;
  
  cdn_jtag_1687_agent          host_1687_jtag_agent;
  jtag_1687_reg_adapter        host_1687_reg2jtag; 
  
  // ---------------- device ---------------- //
  cdnApbUvmMasterAgent         device_apb_mst_agent;
  cdnApbUvmConfig              device_apb_mst_cfg;
  cdn_usb_phy_top_regmodel     device_regmodel_phy; 
  
  u4_apb_reg_adapter           device_reg2apb;
  uvm_reg_predictor#(denaliCdn_apbTransaction) device_reg_predict;
  
  cdn_jtag_agent               device_jtag_agent;
  jtag_reg_adapter             device_reg2jtag; 
  
  cdn_jtag_1687_agent          device_1687_jtag_agent;
  jtag_1687_reg_adapter        device_1687_reg2jtag; 


  //---------------------------------------------
  // UVM functions and tasks
  //---------------------------------------------
  extern function new(string name, uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);

  //---------------------------------------------
  // User functions and tasks
  //---------------------------------------------
  extern virtual function void create_in_build();
  extern virtual function void config_db_set();

endclass : cdn_alt_mode_phy_test_base

function cdn_alt_mode_phy_test_base::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void cdn_alt_mode_phy_test_base::build_phase(uvm_phase phase);
  uvm_factory factory = uvm_factory::get();
  uvm_component dp_test;
  uvm_component usb32_test;
  clp = uvm_cmdline_processor::get_inst();
  if (clp.get_arg_values("+DP_TESTNAME=", arg_values)) begin
    $sscanf(arg_values[0], "%s", alt_dp_test);
      `uvm_info("cdn_alt_mode_phy_test_base", $sformatf("DP TESTNAME is %s for ALT MODE", alt_dp_test), UVM_LOW);
  end
  else begin
      `uvm_fatal("cdn_alt_mode_phy_test_base", "DP testname not set in ALT mode")
  end
  if (clp.get_arg_values("+USB32_TESTNAME=", arg_values)) begin
     $sscanf(arg_values[0], "%s", alt_u32_test);
     `uvm_info("cdn_alt_mode_phy_test_base", $sformatf("USB32 TESTNAME is %s for ALT MODE", alt_u32_test), UVM_LOW);
  end
  else begin
    `uvm_fatal("cdn_alt_mode_cdn_phy_test_base", "USB32 testname not set in ALT mode")
  end
  dp_test= uvm_factory::get().create_component_by_name(alt_dp_test,get_full_name(),"dp_test",this);
  usb32_test= uvm_factory::get().create_component_by_name(alt_u32_test,get_full_name(),"usb32_test",this);

  dp_clk_cfg = clk_cfg_t::type_id::create("dp_clk_cfg");
  usb32_clk_cfg = clk_cfg_t::type_id::create("usb32_clk_cfg");

  dp_clk_cfg.set_default_jitter(CLK_JITTER_DEFAULT_EN);
  dp_clk_cfg.set_seqr_name("dp_clk_sqr");
  usb32_clk_cfg.set_default_jitter(CLK_JITTER_DEFAULT_EN);
  usb32_clk_cfg.set_seqr_name("usb32_clk_sqr");

  // set alt_mode values
  uvm_config_db#(std_mode_t)::set(null,"uvm_test_top.usb32_test","alt_mode",USB32_MODE);
  uvm_config_db#(std_mode_t)::set(null,"uvm_test_top.dp_test","alt_mode",DP_MODE);

  // set clk cfg
  uvm_config_db#(clk_cfg_t)::set(null,"uvm_test_top.usb32_test.*","clk_cfg_t",usb32_clk_cfg);
  uvm_config_db#(clk_cfg_t)::set(null,"uvm_test_top.dp_test.*","clk_cfg_t",dp_clk_cfg);
  uvm_config_db#(bit)::set(null, "uvm_test_top.*", "include_coverage", 1);

  create_in_build();
  config_db_set();
endfunction

function void cdn_alt_mode_phy_test_base::create_in_build();

  //----------------------------------------------------------------------------
  // APB agent
  //----------------------------------------------------------------------------
  apb_mst_agent = cdnApbUvmMasterAgent::type_id::create("apb_mst_agent", this);
  apb_mst_cfg = cdnApbUvmConfig::type_id::create("apb_mst_cfg",this);
  reg2apb  = u4_apb_reg_adapter::type_id::create("reg2apb");
  reg_predict = uvm_reg_predictor#(denaliCdn_apbTransaction)::type_id::create("reg_predict", this);

  device_apb_mst_agent = cdnApbUvmMasterAgent::type_id::create("device_apb_mst_agent", this);
  device_apb_mst_cfg = cdnApbUvmConfig::type_id::create("device_apb_mst_cfg",this);
  device_reg2apb  = u4_apb_reg_adapter::type_id::create("device_reg2apb");
  device_reg_predict = uvm_reg_predictor#(denaliCdn_apbTransaction)::type_id::create("device_reg_predict", this);

  apb_mst_cfg.is_active = UVM_ACTIVE;
  apb_mst_cfg.DeviceType = CDN_APB_CFG_MASTER;
  apb_mst_cfg.number_of_slaves = 1;
  apb_mst_cfg.reset_signals_sim_start = 1;
  apb_mst_cfg.verbosity = CDN_APB_CFG_MESSAGEVERBOSITY_LOW;
  apb_mst_cfg.check_prdata_for_x_and_z = 1;
  apb_mst_cfg.data_width = 'd32;
  apb_mst_cfg.addr_width = 'd18;
  apb_mst_cfg.addToAddressSegments('h0000, 'h3ffff , 0);

  uvm_config_object::set(this,"apb_mst_agent","cfg", apb_mst_cfg);

  device_apb_mst_cfg.is_active = UVM_ACTIVE;
  device_apb_mst_cfg.DeviceType = CDN_APB_CFG_MASTER;
  device_apb_mst_cfg.number_of_slaves = 1;
  device_apb_mst_cfg.reset_signals_sim_start = 1;
  device_apb_mst_cfg.verbosity = CDN_APB_CFG_MESSAGEVERBOSITY_LOW;
  device_apb_mst_cfg.check_prdata_for_x_and_z = 1;
  device_apb_mst_cfg.data_width = 'd32;
  device_apb_mst_cfg.addr_width = 'd18;
  device_apb_mst_cfg.addToAddressSegments('h0000, 'h3ffff , 0);

  uvm_config_object::set(this,"device_apb_mst_agent","cfg", device_apb_mst_cfg);

  //----------------------------------------------------------------------------
  // JTAG agent
  //----------------------------------------------------------------------------
  jtag_agent = cdn_jtag_agent::type_id::create("jtag_agent", this);
  reg2jtag   = jtag_reg_adapter::type_id::create("reg2jtag");

  device_jtag_agent = cdn_jtag_agent::type_id::create("device_jtag_agent", this);
  device_reg2jtag   = jtag_reg_adapter::type_id::create("device_reg2jtag");

  host_1687_jtag_agent = cdn_jtag_1687_agent::type_id::create("host_1687_jtag_agent", this);
  host_1687_reg2jtag   = jtag_1687_reg_adapter::type_id::create("host_1687_reg2jtag");

  device_1687_jtag_agent = cdn_jtag_1687_agent::type_id::create("device_1687_jtag_agent", this);
  device_1687_reg2jtag   = jtag_1687_reg_adapter::type_id::create("device_1687_reg2jtag");

  //----------------------------------------------------------------------------
  // regmodel 
  //----------------------------------------------------------------------------
  regmodel_phy = cdn_usb_phy_top_regmodel::type_id::create("regmodel_phy",this);
  device_regmodel_phy = cdn_usb_phy_top_regmodel::type_id::create("device_regmodel_phy",this);

  regmodel_phy.build();
  regmodel_phy.set_coverage(UVM_CVR_ALL);
  regmodel_phy.lock_model();
  regmodel_phy.reset();
  regmodel_phy.default_map.reset("HARD");
  reg2apb.set_model(regmodel_phy);

  device_regmodel_phy.build();
  device_regmodel_phy.set_coverage(UVM_CVR_ALL);
  device_regmodel_phy.lock_model();
  device_regmodel_phy.reset();
  device_regmodel_phy.default_map.reset("HARD");
  device_reg2apb.set_model(device_regmodel_phy);

endfunction

function void cdn_alt_mode_phy_test_base::config_db_set();

  //----------------------------------------------------------------------------
  // APB agent
  //----------------------------------------------------------------------------
  uvm_config_db#(cdnApbUvmMasterAgent)::set(null,"uvm_test_top.*","apb_mst_agent",apb_mst_agent);
  uvm_config_db#(cdnApbUvmConfig)::set(null,"uvm_test_top.*","apb_mst_cfg",apb_mst_cfg);
  uvm_config_db#(u4_apb_reg_adapter)::set(null,"uvm_test_top.*","reg2apb",reg2apb);
  uvm_config_db#(uvm_reg_predictor#(denaliCdn_apbTransaction))::set(null,"uvm_test_top.*","reg_predict",reg_predict);

  uvm_config_db#(cdnApbUvmMasterAgent)::set(null,"uvm_test_top.*","device_apb_mst_agent",device_apb_mst_agent);
  uvm_config_db#(cdnApbUvmConfig)::set(null,"uvm_test_top.*","device_apb_mst_cfg",device_apb_mst_cfg);
  uvm_config_db#(u4_apb_reg_adapter)::set(null,"uvm_test_top.*","device_reg2apb",device_reg2apb);
  uvm_config_db#(uvm_reg_predictor#(denaliCdn_apbTransaction))::set(null,"uvm_test_top.*","device_reg_predict",device_reg_predict);

  //----------------------------------------------------------------------------
  // JTAG agent
  //----------------------------------------------------------------------------
  uvm_config_db#(cdn_jtag_agent)::set(null,"uvm_test_top.*","jtag_agent",jtag_agent);
  uvm_config_db#(jtag_reg_adapter)::set(null,"uvm_test_top.*","reg2jtag",reg2jtag);
  uvm_config_db#(cdn_jtag_agent)::set(null,"uvm_test_top.*","device_jtag_agent",device_jtag_agent);
  uvm_config_db#(jtag_reg_adapter)::set(null,"uvm_test_top.*","device_reg2jtag",device_reg2jtag);
  uvm_config_db#(cdn_jtag_1687_agent)::set(null,"uvm_test_top.*","host_1687_jtag_agent",host_1687_jtag_agent);
  uvm_config_db#(jtag_1687_reg_adapter)::set(null,"uvm_test_top.*","host_1687_reg2jtag",host_1687_reg2jtag);
  uvm_config_db#(cdn_jtag_1687_agent)::set(null,"uvm_test_top.*","device_1687_jtag_agent",device_1687_jtag_agent);
  uvm_config_db#(jtag_1687_reg_adapter)::set(null,"uvm_test_top.*","device_1687_reg2jtag",device_1687_reg2jtag);

  //----------------------------------------------------------------------------
  // regmodel 
  //----------------------------------------------------------------------------
  uvm_config_db#(cdn_usb_phy_top_regmodel)::set(null,"uvm_test_top.*","regmodel_phy",regmodel_phy);
  uvm_config_db#(cdn_usb_phy_top_regmodel)::set(null,"uvm_test_top.*","device_regmodel_phy",device_regmodel_phy);

endfunction

`endif //TEST__SV

