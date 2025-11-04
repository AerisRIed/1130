//
// Template for UVM-compliant verification environment
//

`ifndef CDN_PHY_ENV_BASE__SV
`define CDN_PHY_ENV_BASE__SV

`include "cdn_usb_phy_top_regmodel.sv"
//Including all the required component files here
`include "apb_master_agent.sv"
`include "apb_reg_adapter.sv"
`include "u4_apb_reg_adapter.sv"
`include "jtag_reg_adapter.sv"
`include "jtag_1687_reg_adapter.sv"
`include "cdn_phy_virtual_sequencer_base.sv"

class cdn_phy_env_base extends uvm_env;

   //---------------------------------------------
   // Member configs
   //---------------------------------------------
   cdn_phy_tb_config        tb_cfg;
   cdn_phy_dut_config       dut_cfg;
   cdn_phy_dut_config       device_dut_cfg;

   //---------------------------------------------
   // Member clk components
   //---------------------------------------------
   clk_agent                m_clk_agent;
   cdn_phy_virtual_sequencer_base   vsqr; 
   //---------------------------------------------
   // Member apb & jtag & regmodel components
   //---------------------------------------------

   // ---------------- host ---------------- //
   cdnApbUvmMasterAgent         apb_mst_agent;
   cdnApbUvmConfig              apb_mst_cfg;
   cdn_usb_phy_top_regmodel   regmodel_phy; 
   cdn_reset_agent 	 			reset_agent;
   
   u4_apb_reg_adapter              reg2apb;
   uvm_reg_predictor#(denaliCdn_apbTransaction) reg_predict;
   
   cdn_jtag_agent               jtag_agent;
   jtag_reg_adapter             reg2jtag;
   
   cdn_jtag_1687_agent          host_1687_jtag_agent;
   jtag_1687_reg_adapter        host_1687_reg2jtag; 
   
   // ---------------- device ---------------- //
   cdnApbUvmMasterAgent         device_apb_mst_agent;
   cdnApbUvmConfig              device_apb_mst_cfg;
   cdn_usb_phy_top_regmodel    device_regmodel_phy; 
   cdn_reset_agent 	 			device_reset_agent;
   
   u4_apb_reg_adapter              device_reg2apb;
   uvm_reg_predictor#(denaliCdn_apbTransaction) device_reg_predict;
   
   cdn_jtag_agent               device_jtag_agent;
   jtag_reg_adapter             device_reg2jtag; 
   
   cdn_jtag_1687_agent          device_1687_jtag_agent;
   jtag_1687_reg_adapter        device_1687_reg2jtag; 

   //  yzy add
  // std_mode_t                    alt_mode;

  // pwr rate ctrl component 

  //cdn_phy_pwr_rate_ctrl_base phy_pwr_rate_ctrl_comp;
  `uvm_component_utils(cdn_phy_env_base)

   //---------------------------------
   // UVM functions and tasks
   //---------------------------------
   extern function new(string name="cdn_phy_env_base", uvm_component parent=null);
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern function void start_of_simulation_phase(uvm_phase phase);
   extern virtual task reset_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   extern virtual function void report_phase(uvm_phase phase);
   extern virtual task shutdown_phase(uvm_phase phase);

   //---------------------------------
   // User functions and tasks
   //---------------------------------
   extern virtual function void build_by_std();
   extern virtual function void connect_by_std();
   
endclass: cdn_phy_env_base

function cdn_phy_env_base::new(string name= "cdn_phy_env_base",uvm_component parent=null);
   super.new(name,parent);
endfunction:new

function void cdn_phy_env_base::build_phase(uvm_phase phase);
   super.build_phase(phase);

   //----------------------------------------------------------------------------
   // get configs
   //----------------------------------------------------------------------------
   if (!uvm_config_db#(cdn_phy_tb_config)::get(this, "", "tb_cfg", tb_cfg)) begin
     `uvm_fatal(get_type_name(), "tb_cfg not set")
   end
   if (!uvm_config_db#(cdn_phy_dut_config)::get(this, "", "dut_cfg", dut_cfg)) begin
     `uvm_fatal(get_type_name(), "dut_cfg not set")
   end
   if (!uvm_config_db#(cdn_phy_dut_config)::get(this, "", "device_dut_cfg", device_dut_cfg)) begin
     `uvm_fatal(get_type_name(), "device_dut_cfg not set")
   end
   `ifndef DUT_BYPASS
   //----------------------------------------------------------------------------
   // APB agent
   //----------------------------------------------------------------------------
   if(tb_cfg.std_mode == ALT_MODE) begin
     uvm_config_db#(cdnApbUvmMasterAgent)::get(this, "","apb_mst_agent",apb_mst_agent);
     uvm_config_db#(cdnApbUvmConfig)::get(this, "","apb_mst_cfg",apb_mst_cfg);
     uvm_config_db#(u4_apb_reg_adapter)::get(this, "","reg2apb",reg2apb);
     uvm_config_db#(uvm_reg_predictor#(denaliCdn_apbTransaction))::get(this, "","reg_predict",reg_predict);
     
     uvm_config_db#(cdnApbUvmMasterAgent)::get(this, "","device_apb_mst_agent",device_apb_mst_agent);
     uvm_config_db#(cdnApbUvmConfig)::get(this, "","device_apb_mst_cfg",device_apb_mst_cfg);
     uvm_config_db#(u4_apb_reg_adapter)::get(this, "","device_reg2apb",device_reg2apb);
     uvm_config_db#(uvm_reg_predictor#(denaliCdn_apbTransaction))::get(this, "","device_reg_predict",device_reg_predict);
   end else begin
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
   end

   //----------------------------------------------------------------------------
   // JTAG agent
   //----------------------------------------------------------------------------
   if(tb_cfg.std_mode == ALT_MODE) begin
     uvm_config_db#(cdn_jtag_agent)::get(this, "","jtag_agent",jtag_agent);
     uvm_config_db#(jtag_reg_adapter)::get(this, "","reg2jtag",reg2jtag);
     uvm_config_db#(cdn_jtag_agent)::get(this, "","device_jtag_agent",device_jtag_agent);
     uvm_config_db#(jtag_reg_adapter)::get(this, "","device_reg2jtag",device_reg2jtag);
     uvm_config_db#(cdn_jtag_1687_agent)::get(this, "","host_1687_jtag_agent",host_1687_jtag_agent);
     uvm_config_db#(jtag_1687_reg_adapter)::get(this, "","host_1687_reg2jtag",host_1687_reg2jtag);
     uvm_config_db#(cdn_jtag_1687_agent)::get(this, "","device_1687_jtag_agent",device_1687_jtag_agent);
     uvm_config_db#(jtag_1687_reg_adapter)::get(this, "","device_1687_reg2jtag",device_1687_reg2jtag);
   end else begin
     jtag_agent = cdn_jtag_agent::type_id::create("jtag_agent", this);
     reg2jtag   = jtag_reg_adapter::type_id::create("reg2jtag");
     
     device_jtag_agent = cdn_jtag_agent::type_id::create("device_jtag_agent", this);
     device_reg2jtag   = jtag_reg_adapter::type_id::create("device_reg2jtag");
     
     host_1687_jtag_agent = cdn_jtag_1687_agent::type_id::create("host_1687_jtag_agent", this);
     host_1687_reg2jtag   = jtag_1687_reg_adapter::type_id::create("host_1687_reg2jtag");
     
     device_1687_jtag_agent = cdn_jtag_1687_agent::type_id::create("device_1687_jtag_agent", this);
     device_1687_reg2jtag   = jtag_1687_reg_adapter::type_id::create("device_1687_reg2jtag");
   end

   //----------------------------------------------------------------------------
   // regmodel TODO
   //----------------------------------------------------------------------------
   if(tb_cfg.std_mode == ALT_MODE) begin
     uvm_config_db#(cdn_usb_phy_top_regmodel)::get(this, "","regmodel_phy",regmodel_phy);
     uvm_config_db#(cdn_usb_phy_top_regmodel)::get(this, "","device_regmodel_phy",device_regmodel_phy);
   end else begin
     regmodel_phy = cdn_usb_phy_top_regmodel::type_id::create("regmodel_phy",this);
     device_regmodel_phy = cdn_usb_phy_top_regmodel::type_id::create("device_regmodel_phy",this);

     regmodel_phy.build();
     regmodel_phy.set_coverage(UVM_CVR_ALL);
     regmodel_phy.lock_model();
     regmodel_phy.reset();
     regmodel_phy.default_map.reset("HARD");
     reg2apb.set_model(regmodel_phy);
     //
     device_regmodel_phy.build();
     device_regmodel_phy.set_coverage(UVM_CVR_ALL);
     device_regmodel_phy.lock_model();
     device_regmodel_phy.reset();
     device_regmodel_phy.default_map.reset("HARD");
     device_reg2apb.set_model(device_regmodel_phy);
   end

   //----------------------------------------------------------------------------
   // reset agent
   //----------------------------------------------------------------------------
   reset_agent = cdn_reset_agent::type_id::create("reset_agent", this);
   device_reset_agent = cdn_reset_agent::type_id::create("device_reset_agent", this);
   if(tb_cfg.std_mode == ALT_MODE) begin
     if (dut_cfg.alt_mode == DP_MODE) begin 
       reset_agent.alt_mode = DP; 
       device_reset_agent.alt_mode = DP; 
       reset_agent.m_cfg.dp_enable = 1;
       device_reset_agent.m_cfg.dp_enable = 1;
     end else if (dut_cfg.alt_mode == USB32_MODE) begin 
       reset_agent.alt_mode = USB32; 
       device_reset_agent.alt_mode = USB32; 
       reset_agent.m_cfg.dp_enable = 0;
       device_reset_agent.m_cfg.dp_enable = 0;
     end
   end else begin
     reset_agent.m_cfg.dp_enable = (tb_cfg.std_mode == DP_MODE) ? 1 : 0;
     device_reset_agent.m_cfg.dp_enable = (tb_cfg.std_mode == DP_MODE) ? 1 : 0;
   end
   `endif

   //----------------------------------------------------------------------------
   // Virtual sequencer
   //----------------------------------------------------------------------------
   vsqr = cdn_phy_virtual_sequencer_base::type_id::create("vsqr", this);
 
   //----------------------------------------------------------------------------
   // Clock agent
   //----------------------------------------------------------------------------
   m_clk_agent = clk_agent::type_id::create("m_clk_agent", this);
   //----------------------------------------------------------------------------
   // User functions
   //----------------------------------------------------------------------------
   build_by_std();

   //phy_pwr_rate_ctrl_comp = cdn_phy_pwr_rate_ctrl_base::type_id::create("phy_pwr_rate_ctrl_comp", this);

endfunction: build_phase

function void cdn_phy_env_base::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   `ifndef DUT_BYPASS
   //----------------------------------------------------------------------------
   // connect vsqrs TODO
   //----------------------------------------------------------------------------
      vsqr.m_jtag_vsqr = jtag_agent.jtag_sqr;
      vsqr.m_1687_jtag_vsqr = host_1687_jtag_agent.jtag_1687_sqr;
      vsqr.m_device_jtag_vsqr = device_jtag_agent.jtag_sqr;
      vsqr.m_device_1687_jtag_vsqr = device_1687_jtag_agent.jtag_1687_sqr;
	  for(int i=0;i<tb_param::MAX_LANE_NUM;i++) begin
	    vsqr.m_reset_sqr[i] = reset_agent.sequencer[i];
	    vsqr.m_device_reset_sqr[i] = device_reset_agent.sequencer[i];
	  end
   //----------------------------------------------------------------------------
   // connect regmodel TODO
   //----------------------------------------------------------------------------
     vsqr.regmodel = this.regmodel_phy;
     vsqr.device_regmodel = this.device_regmodel_phy;
   if(dut_cfg.reg_interface_sel == APB) begin
    regmodel_phy.default_map.set_sequencer(apb_mst_agent.sequencer,reg2apb);
   end
   else if(dut_cfg.reg_interface_sel == JTAG) begin
    regmodel_phy.default_map.set_sequencer(jtag_agent.jtag_sqr,reg2jtag);
   end
   else if(dut_cfg.reg_interface_sel == JTAG_1687) begin
    regmodel_phy.default_map.set_sequencer(host_1687_jtag_agent.jtag_1687_sqr,host_1687_reg2jtag);
   end

   regmodel_phy.default_map.set_auto_predict(1);

   if(device_dut_cfg.reg_interface_sel == APB) begin
    device_regmodel_phy.default_map.set_sequencer(device_apb_mst_agent.sequencer,device_reg2apb);
   end
   else if(device_dut_cfg.reg_interface_sel == JTAG) begin
    device_regmodel_phy.default_map.set_sequencer(device_jtag_agent.jtag_sqr,device_reg2jtag);
   end
   else if(device_dut_cfg.reg_interface_sel == JTAG_1687) begin
    device_regmodel_phy.default_map.set_sequencer(device_1687_jtag_agent.jtag_1687_sqr,device_1687_reg2jtag);
   end

   device_regmodel_phy.default_map.set_auto_predict(1);

   //----------------------------------------------------------------------------
   // User functions
   //----------------------------------------------------------------------------
   connect_by_std();

   //phy_pwr_rate_ctrl_comp.vsqr = this.vsqr;
    `endif
endfunction: connect_phase

function void cdn_phy_env_base::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);
   `ifdef UVM_VERSION_1_0
   //uvm_top.print_topology();  
   //factory.print();          
   `endif
   
   `ifdef UVM_VERSION_1_1
	//uvm_root::get().print_topology(); 
    //uvm_factory::get().print();      
   `endif

   `ifdef UVM_POST_VERSION_1_1
	//uvm_root::get().print_topology(); 
    //uvm_factory::get().print();      
   `endif

   //ToDo : Implement this phase here 
endfunction: start_of_simulation_phase


task cdn_phy_env_base::reset_phase(uvm_phase phase);
   super.reset_phase(phase);
   //ToDo: Reset DUT
endtask:reset_phase

task cdn_phy_env_base::configure_phase (uvm_phase phase);
   super.configure_phase(phase);
endtask:configure_phase

task cdn_phy_env_base::run_phase(uvm_phase phase);
   super.run_phase(phase);
   //ToDo: Run your simulation here
endtask:run_phase

function void cdn_phy_env_base::report_phase(uvm_phase phase);
   super.report_phase(phase);
   //ToDo: Implement this phase here
endfunction:report_phase

task cdn_phy_env_base::shutdown_phase(uvm_phase phase);
   super.shutdown_phase(phase);
   //ToDo: Implement this phase here
endtask:shutdown_phase


function void cdn_phy_env_base::build_by_std();
  //if(tb_cfg.std_mode.usb4_enable == 1) begin
  //  for(int i = 0 ; i < tb_param::USB4_LANE_NUM ; i++) begin
  //   // m_vsqr[i]  = cdn_phy_virtual_sequencer_base::type_id::create($sformatf("m_vsqr[%0d]",i), this);
  //  end
  //end else if(tb_cfg.std_mode.usb32_enable == 1) begin
  //  for(int i = 0 ; i < tb_param::USB32_LANE_NUM ; i++) begin
  //   // m_vsqr[i]  = cdn_phy_virtual_sequencer_base::type_id::create($sformatf("m_vsqr[%0d]",i), this);
  //  end
  //end else if(tb_cfg.std_mode.dp_enable == 1) begin
  //  for(int i = 0 ; i < tb_param::DP_LANE_NUM ; i++) begin
  //   // m_vsqr[i]  = cdn_phy_virtual_sequencer_base::type_id::create($sformatf("m_vsqr[%0d]",i), this);
  //  end
  //end else if(tb_cfg.std_mode.pcie_enable == 1) begin
  //  for(int i = 0 ; i < tb_param::PCIE_LANE_NUM ; i++) begin
  //   // m_vsqr[i]  = cdn_phy_virtual_sequencer_base::type_id::create($sformatf("m_vsqr[%0d]",i), this);
  //  end
  //end
endfunction: build_by_std

function void cdn_phy_env_base::connect_by_std();
endfunction: connect_by_std

`endif // CDN_PHY_ENV_BASE__SV

