
`ifndef CDN_USB32_PHY_ENV__SV
`define CDN_USB32_PHY_ENV__SV
class cdn_u4_usb32_env extends cdn_phy_env_base;
  // cdn_phy_scoreboard_base sb;
  // ral_block_cdn_phy regmodel;
  // reg_seq ral_sequence; 
   cdn_u4_usb32_agent host_agent;
   cdn_u4_usb32_agent device_agent;
   cdn_u4_usb32_scoreboard usb32_scb[tb_param :: USB32_LANE_NUM];
  // cdn_phy_cov cov;
  // 
  // ral_adapter reg2host;
  // cdn_phy_monitor_base_2cov_connect mon2cov;
  //  
   cdn_phy_cov cov;
   
   ral_adapter reg2host;
   cdn_phy_monitor_base_2cov_connect mon2cov;
    
   cdn_u4_usb32_virtual_sequencer usb32_vsqr;

   //---------------------------------
   // Factory
   //---------------------------------
   `uvm_component_utils(cdn_u4_usb32_env)

   //---------------------------------
   // UVM functions and tasks
   //---------------------------------
   extern function new(string name="cdn_u4_usb32_env", uvm_component parent=null);
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern function void start_of_simulation_phase(uvm_phase phase);
   extern virtual task reset_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   extern virtual function void report_phase(uvm_phase phase);
   extern virtual task shutdown_phase(uvm_phase phase);

endclass: cdn_u4_usb32_env

function cdn_u4_usb32_env::new(string name= "cdn_u4_usb32_env",uvm_component parent=null);
   super.new(name,parent);
endfunction:new

function void cdn_u4_usb32_env::build_phase(uvm_phase phase);
   super.build_phase(phase);
   host_agent = cdn_u4_usb32_agent::type_id::create("host_agent",this); 
   device_agent = cdn_u4_usb32_agent::type_id::create("device_agent",this);


 
  // m_clk_agent = clk_agent::type_id::create("m_clk_agent", this);
  //
 
   //ToDo: Register other components,callbacks and TLM ports if added by user  


   //for(int i = 0 ; i < tb_param :: USB32_LANE_NUM ; i++) begin
    usb32_vsqr  = cdn_u4_usb32_virtual_sequencer::type_id::create($psprintf("usb32_vsqr"), this);
    for(int i = 0 ; i < tb_param :: USB32_LANE_NUM ; i++) begin
        usb32_scb[i] = cdn_u4_usb32_scoreboard::type_id::create($psprintf("usb32_scb[%0d]",i), this);
        usb32_scb[i].lane_id = i;
    end
    //end
   // ToDo: To enable backdoor access specify the HDL path
   // ToDo: Register any required callbacks
    //make sure the speed of each component is the same

endfunction: build_phase

function void cdn_u4_usb32_env::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   //Connecting the monitor's analysis ports with cdn_phy_scoreboard_base's expected analysis exports.
        usb32_vsqr.host_sequencer              =  host_agent.usb32_sqr;
        usb32_vsqr.device_sequencer            =  device_agent.usb32_sqr;
        usb32_vsqr.host_sequencer.timer_cfg    =  host_agent.timer_cfg; 
        usb32_vsqr.device_sequencer.timer_cfg  =  device_agent.timer_cfg; 
     for(int i = 0; i < tb_param :: USB32_LANE_NUM ; i++ ) begin
       host_agent.usb32_drv[i].drv2scb_stim_ap_host.connect(usb32_scb[i].drv2scb_export_ep_host);
       device_agent.usb32_drv[i].drv2scb_stim_ap_devc.connect(usb32_scb[i].drv2scb_export_ep_devc);

       host_agent.usb32_mon[i].mon2scb_stim_ap_host.connect(usb32_scb[i].mon2scb_export_ep_host);
       device_agent.usb32_mon[i].mon2scb_stim_ap_devc.connect(usb32_scb[i].mon2scb_export_ep_devc);
    end

endfunction: connect_phase

function void cdn_u4_usb32_env::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);
    host_agent.usb32_cfg.port_mode = HOST;
    device_agent.usb32_cfg.port_mode = DEVICE;
   //ToDo : Implement this phase here 
endfunction: start_of_simulation_phase


task cdn_u4_usb32_env::reset_phase(uvm_phase phase);
   super.reset_phase(phase);
   //ToDo: Reset DUT
endtask:reset_phase

task cdn_u4_usb32_env::configure_phase (uvm_phase phase);
   super.configure_phase(phase);
   //ToDo: Configure components here
endtask:configure_phase

task cdn_u4_usb32_env::run_phase(uvm_phase phase);
   super.run_phase(phase);
   //ToDo: Run your simulation here
endtask:run_phase

function void cdn_u4_usb32_env::report_phase(uvm_phase phase);
   super.report_phase(phase);
   //ToDo: Implement this phase here
endfunction:report_phase

task cdn_u4_usb32_env::shutdown_phase(uvm_phase phase);
   super.shutdown_phase(phase);
   //ToDo: Implement this phase here
endtask:shutdown_phase
`endif // cdn_u4_usb32_env__SV

