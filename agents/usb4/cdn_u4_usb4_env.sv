`ifndef CDN_USB4_PHY_ENV__SV
`define CDN_USB4_PHY_ENV__SV
class cdn_u4_usb4_env extends cdn_phy_env_base;
  // cdn_phy_scoreboard_base sb;
  // ral_block_cdn_phy regmodel;
  // reg_seq ral_sequence; 
   cdn_u4_usb4_agent host_agent;
   cdn_u4_usb4_agent device_agent;
   cdn_message_bus_agent message_bus_agt;
   cdn_u4_usb4_scoreboard usb4_scb[tb_param :: USB4_LANE_NUM];
  // cdn_phy_cov cov;
  // 
  // ral_adapter reg2host;
  // cdn_phy_monitor_base_2cov_connect mon2cov;
  //  
   cdn_phy_cov cov;
   
   ral_adapter reg2host;
   cdn_phy_monitor_base_2cov_connect mon2cov;
    
   cdn_u4_usb4_virtual_sequencer usb4_vsqr;

   //---------------------------------
   // Factory
   //---------------------------------
   `uvm_component_utils(cdn_u4_usb4_env)

   //---------------------------------
   // UVM functions and tasks
   //---------------------------------
   extern function new(string name="cdn_u4_usb4_env", uvm_component parent=null);
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern function void start_of_simulation_phase(uvm_phase phase);
   extern virtual task reset_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   extern virtual function void report_phase(uvm_phase phase);
   extern virtual task shutdown_phase(uvm_phase phase);

endclass: cdn_u4_usb4_env

function cdn_u4_usb4_env::new(string name= "cdn_u4_usb4_env",uvm_component parent=null);
   super.new(name,parent);
endfunction:new

function void cdn_u4_usb4_env::build_phase(uvm_phase phase);
   super.build_phase(phase);
   host_agent = cdn_u4_usb4_agent::type_id::create("host_agent",this); 
   device_agent = cdn_u4_usb4_agent::type_id::create("device_agent",this);
   message_bus_agt = cdn_message_bus_agent::type_id::create("message_bus_agt", this);

 
  // m_clk_agent = clk_agent::type_id::create("m_clk_agent", this);
  //
    for(int i = 0 ; i < tb_param :: USB4_LANE_NUM ; i++) begin
        usb4_scb[i] = cdn_u4_usb4_scoreboard::type_id::create($psprintf("usb4_scb[%0d]",i), this);
        usb4_scb[i].lane_id = i;
    end
 
   //ToDo: Register other components,callbacks and TLM ports if added by user  


   //for(int i = 0 ; i < tb_param :: USB4_LANE_NUM ; i++) begin
    usb4_vsqr  = cdn_u4_usb4_virtual_sequencer::type_id::create($psprintf("usb4_vsqr"), this);
   //end
   // ToDo: To enable backdoor access specify the HDL path
   // ToDo: Register any required callbacks
endfunction: build_phase

function void cdn_u4_usb4_env::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   //Connecting the monitor's analysis ports with cdn_phy_scoreboard_base's expected analysis exports.
        usb4_vsqr.host_sequencer              =  host_agent.usb4_sqr;
        usb4_vsqr.device_sequencer            =  device_agent.usb4_sqr;
        usb4_vsqr.host_sequencer.timer_cfg    =  host_agent.timer_cfg; 
        usb4_vsqr.device_sequencer.timer_cfg  =  device_agent.timer_cfg;
     for(int i = 0; i < tb_param :: USB4_LANE_NUM ; i++ ) begin
       host_agent.usb4_drv[i].drv2scb_stim_ap_host.connect(usb4_scb[i].drv2scb_export_ep_host);
       device_agent.usb4_drv[i].drv2scb_stim_ap_devc.connect(usb4_scb[i].drv2scb_export_ep_devc);

       host_agent.usb4_mon[i].mon2scb_stim_ap_host.connect(usb4_scb[i].mon2scb_export_ep_host);
       device_agent.usb4_mon[i].mon2scb_stim_ap_devc.connect(usb4_scb[i].mon2scb_export_ep_devc);
    end

endfunction: connect_phase

function void cdn_u4_usb4_env::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);
    host_agent.usb4_cfg.port_mode = HOST;
    device_agent.usb4_cfg.port_mode = DEVICE;

   //ToDo : Implement this phase here 
endfunction: start_of_simulation_phase


task cdn_u4_usb4_env::reset_phase(uvm_phase phase);
   super.reset_phase(phase);
   //ToDo: Reset DUT
endtask:reset_phase

task cdn_u4_usb4_env::configure_phase (uvm_phase phase);
   super.configure_phase(phase);
   //ToDo: Configure components here
endtask:configure_phase

task cdn_u4_usb4_env::run_phase(uvm_phase phase);
   super.run_phase(phase);
   //ToDo: Run your simulation here
endtask:run_phase

function void cdn_u4_usb4_env::report_phase(uvm_phase phase);
   super.report_phase(phase);
   //ToDo: Implement this phase here
endfunction:report_phase

task cdn_u4_usb4_env::shutdown_phase(uvm_phase phase);
   super.shutdown_phase(phase);
   //ToDo: Implement this phase here
endtask:shutdown_phase
`endif // cdn_u4_usb4_env__SV

