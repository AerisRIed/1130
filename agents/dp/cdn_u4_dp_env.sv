`ifndef CDN_DP_PHY_ENV__SV
`define CDN_DP_PHY_ENV__SV

class cdn_u4_dp_env extends cdn_phy_env_base;

   //---------------------------------
   // Member components
   //---------------------------------
   cdn_u4_dp_agent             host_agent;
   cdn_u4_dp_agent             device_agent;

   cdn_u4_dp_scoreboard        dp_scb[tb_param :: DP_LANE_NUM];
   cdn_u4_dp_virtual_sequencer dp_vsqr;

   //---------------------------------
   // Factory
   //---------------------------------
   `uvm_component_utils(cdn_u4_dp_env)

   //---------------------------------
   // UVM functions and tasks
   //---------------------------------
   extern function new(string name="cdn_u4_dp_env", uvm_component parent=null);
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern function void start_of_simulation_phase(uvm_phase phase);
   extern virtual task reset_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   extern virtual function void report_phase(uvm_phase phase);
   extern virtual task shutdown_phase(uvm_phase phase);

endclass: cdn_u4_dp_env

function cdn_u4_dp_env::new(string name= "cdn_u4_dp_env",uvm_component parent=null);
   super.new(name,parent);
endfunction:new

function void cdn_u4_dp_env::build_phase(uvm_phase phase);
   super.build_phase(phase);

   host_agent = cdn_u4_dp_agent::type_id::create("host_agent",this); 
   device_agent = cdn_u4_dp_agent::type_id::create("device_agent",this);

   for(int i = 0 ; i < tb_param::DP_LANE_NUM ; i++) begin
     dp_scb[i] = cdn_u4_dp_scoreboard::type_id::create($psprintf("dp_scb[%0d]",i), this);
   end

   dp_vsqr  = cdn_u4_dp_virtual_sequencer::type_id::create("dp_vsqr", this);

endfunction: build_phase

function void cdn_u4_dp_env::connect_phase(uvm_phase phase);
   super.connect_phase(phase);

   // agent configs
   host_agent.m_cfg.port_mode = HOST;
   device_agent.m_cfg.port_mode = DEVICE;

   // agent & scb connection
   for(int i = 0 ; i < tb_param :: DP_LANE_NUM ; i++) begin
     host_agent.dp_mon[i].mon_raw_txdata_ap.connect(dp_scb[i].mon_raw_txdata_imp);
     device_agent.dp_mon[i].mon_ser_rxdata_ap.connect(dp_scb[i].mon_ser_rxdata_imp);
   end
   for(int i = 0 ; i < tb_param::DP_LANE_NUM ; i++) begin
     dp_vsqr.host_sequencer[i] = host_agent.dp_sqr[i];
     dp_vsqr.device_sequencer[i] = device_agent.dp_sqr[i];
   end
   dp_vsqr.host_cfg = host_agent.m_cfg;
   dp_vsqr.device_cfg = device_agent.m_cfg;

endfunction: connect_phase

function void cdn_u4_dp_env::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);

   //ToDo : Implement this phase here 
endfunction: start_of_simulation_phase


task cdn_u4_dp_env::reset_phase(uvm_phase phase);
   super.reset_phase(phase);
   //ToDo: Reset DUT
endtask:reset_phase

task cdn_u4_dp_env::configure_phase (uvm_phase phase);
   super.configure_phase(phase);
   //ToDo: Configure components here
endtask:configure_phase

task cdn_u4_dp_env::run_phase(uvm_phase phase);
   super.run_phase(phase);
   //ToDo: Run your simulation here
endtask:run_phase

function void cdn_u4_dp_env::report_phase(uvm_phase phase);
   super.report_phase(phase);
   //ToDo: Implement this phase here
endfunction:report_phase

task cdn_u4_dp_env::shutdown_phase(uvm_phase phase);
   super.shutdown_phase(phase);
   //ToDo: Implement this phase here
endtask:shutdown_phase
`endif // cdn_u4_dp_env__SV

