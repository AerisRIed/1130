`ifndef CDN_PCIE_PHY_ENV__SV
`define CDN_PCIE_PHY_ENV__SV

class cdn_u4_pcie_env extends cdn_phy_env_base;
   //cdn_phy_scoreboard_base sb;
   //ral_block_cdn_phy regmodel;
   //reg_seq ral_sequence; 
   cdn_phy_tb_config tb_cfg;
   cdn_phy_dut_config dut_cfg;
   cdn_phy_dut_config device_dut_cfg;
   cdn_u4_pcie_agent host_agent;
   cdn_u4_pcie_agent device_agent;
   cdn_u4_pcie_scoreboard pcie_scb[tb_param :: PCIE_LANE_NUM];
   //cdn_phy_cov cov;
   
   //ral_adapter reg2host;
   //cdn_phy_monitor_base_2cov_connect mon2cov;

	cdn_u4_pcie_virtual_sequencer pcie_vsqr;

    `uvm_component_utils(cdn_u4_pcie_env)

   extern function new(string name="cdn_u4_pcie_env", uvm_component parent=null);
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern function void start_of_simulation_phase(uvm_phase phase);
   extern virtual task reset_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   extern virtual function void report_phase(uvm_phase phase);
   extern virtual task shutdown_phase(uvm_phase phase);

endclass: cdn_u4_pcie_env

function cdn_u4_pcie_env::new(string name= "cdn_u4_pcie_env",uvm_component parent=null);
   super.new(name,parent);
endfunction:new

function void cdn_u4_pcie_env::build_phase(uvm_phase phase);
   super.build_phase(phase);
   host_agent = cdn_u4_pcie_agent::type_id::create("host_agent",this); 
   device_agent = cdn_u4_pcie_agent::type_id::create("device_agent",this);
   if (!uvm_config_db#(cdn_phy_tb_config)::get(this,"","tb_cfg",tb_cfg))
	 `uvm_fatal("","driver cannot get tb_cfg! please check.")
   // dut cfg
   if (!uvm_config_db#(cdn_phy_dut_config)::get(this,"","dut_cfg",dut_cfg))
     `uvm_fatal("","env cannot get dut_cfg! please check.")
   if (!uvm_config_db#(cdn_phy_dut_config)::get(this,"","device_dut_cfg",device_dut_cfg))
     `uvm_fatal("","env cannot get device_dut_cfg! please check.")

   for(int i = 0; i < dut_cfg.pcie_lane_num; i++ ) begin
	 pcie_scb[i] = cdn_u4_pcie_scoreboard::type_id::create($psprintf("pcie_scb[%0d]",i), this);
	 `uvm_info("build phase", $psprintf("pcie_scb[%0d] created!",i),UVM_LOW);
   end
   //ToDo: Register other components,callbacks and TLM ports if added by user  
	
   //for(int i = 0 ; i < tb_param :: PCIE_LANE_NUM ; i++)
      pcie_vsqr  = cdn_u4_pcie_virtual_sequencer::type_id::create($psprintf("pcie_vsqr"), this);
   // ToDo: To enable backdoor access specify the HDL path
   // ToDo: Register any required callbacks
endfunction: build_phase

function void cdn_u4_pcie_env::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
   //Connecting the monitor's analysis ports with cdn_phy_scoreboard_base's expected analysis exports.
   //for(int i = 0 ; i < tb_param :: PCIE_LANE_NUM ; i++) begin
	pcie_vsqr.host_sequencer = host_agent.pcie_sqr;
    pcie_vsqr.devc_sequencer = device_agent.pcie_sqr;
    pcie_vsqr.base_vsqr 	 = this.vsqr; // env_base
 	host_agent.m_cfg.port_mode = HOST;
    device_agent.m_cfg.port_mode = DEVICE;
    for(int i = 0; i < dut_cfg.pcie_lane_num; i++ ) begin
      host_agent.pcie_drv[i].cdn_u4_pcie_trans_port.connect(pcie_scb[i].host_drv_exp);
      device_agent.pcie_drv[i].cdn_u4_pcie_trans_port.connect(pcie_scb[i].device_drv_exp);
      host_agent.pcie_mon[i].mon_serdes_analysis_port.connect(pcie_scb[i].host_mon_ser);
      device_agent.pcie_mon[i].mon_serdes_analysis_port.connect(pcie_scb[i].device_mon_ser);
	  host_agent.pcie_mon[i].mon_pipe_analysis_port.connect(pcie_scb[i].host_mon_pipe);
      device_agent.pcie_mon[i].mon_pipe_analysis_port.connect(pcie_scb[i].device_mon_pipe);
    end
   //end
endfunction: connect_phase

function void cdn_u4_pcie_env::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);

   //ToDo : Implement this phase here 
endfunction: start_of_simulation_phase


task cdn_u4_pcie_env::reset_phase(uvm_phase phase);
   super.reset_phase(phase);
   //ToDo: Reset DUT
endtask:reset_phase

task cdn_u4_pcie_env::configure_phase (uvm_phase phase);
   super.configure_phase(phase);
    device_agent.m_cfg.lfsr23_initial = host_agent.m_cfg.lfsr23_initial;
endtask:configure_phase

task cdn_u4_pcie_env::run_phase(uvm_phase phase);
   super.run_phase(phase);
   //ToDo: Run your simulation here
endtask:run_phase

function void cdn_u4_pcie_env::report_phase(uvm_phase phase);
   super.report_phase(phase);
   //ToDo: Implement this phase here
endfunction:report_phase

task cdn_u4_pcie_env::shutdown_phase(uvm_phase phase);
   super.shutdown_phase(phase);
   //ToDo: Implement this phase here
endtask:shutdown_phase

`endif // cdn_u4_pcie_env__SV

