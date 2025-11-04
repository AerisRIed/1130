`ifndef CDN_U4_USB32_TEST_BASE__SV
`define CDN_U4_USB32_TEST_BASE__SV
class cdn_u4_usb32_test_base extends cdn_phy_test_base;

    `uvm_component_utils(cdn_u4_usb32_test_base)
    cdn_u4_usb32_env usb32_env;
    cdn_callback m_callback;
    `ifndef DUT_BYPASS
//start_up
    cdn_phy_bring_up_seq bringup_seq;
    cdn_reset_sequence  reset_seq_phy;
    cdn_reset_sequence  reset_seq_pipe[tb_param::USB32_LANE_NUM];
//---
    `endif
    extern virtual task configure_phase(uvm_phase phase);
    extern virtual function void reconfig_dut_cfg();
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
    extern virtual task dyn_main_phase();
    extern virtual function void dyn_build_phase();
    extern virtual task start_up();
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

endclass : cdn_u4_usb32_test_base

task cdn_u4_usb32_test_base::configure_phase (uvm_phase phase);
   super.configure_phase(phase);
   //ToDo: Configure components here
endtask:configure_phase

function void cdn_u4_usb32_test_base::dyn_build_phase();
    uvm_config_db#(uvm_object_wrapper)::set(this,$psprintf("usb32_env.usb32_vsqr.main_phase"),"default_sequence",cdn_u4_usb32_base_sequence::type_id::get());
endfunction
  
function void  cdn_u4_usb32_test_base::build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_name(), $psprintf("\033[1;42m build Please check waveform \033[0m "), UVM_LOW)
    m_callback= cdn_callback::type_id::create("m_callback", this);
    usb32_env = cdn_u4_usb32_env::type_id::create("usb32_env", this);
    `ifndef DUT_BYPASS
    //startup_seq
    bringup_seq=cdn_phy_bring_up_seq::type_id::create("bringup_seq",this);
    reset_seq_phy = cdn_reset_sequence::type_id::create("reset_seq_phy", this);
    for(int i = 0 ;i< dut_cfg.usb32_lane_num;i++) begin
        reset_seq_pipe[i] = cdn_reset_sequence::type_id::create($psprintf("reset_seq_pipe[%0d]",i), this);
    end   
    `endif
    dyn_build_phase();

    // yzy add
   // if (tb_cfg.std_mode == ALT_MODE) begin 
   //   usb32_env.alt_mode = USB32_MODE;
   // end
endfunction

function void cdn_u4_usb32_test_base::reconfig_dut_cfg();
     uvm_cmdline_processor clp;
     string arg_values[$];
//cfgrefclk
     clp = uvm_cmdline_processor::get_inst();
     if (clp.get_arg_values("+REFCLK=",arg_values))begin
       foreach (arg_values[i])begin
         case(arg_values[i])
         "REF100":dut_cfg.ref_clk_mode = REFCLK_100M;
         "REF192":dut_cfg.ref_clk_mode = REFCLK_19_2M;
         "REF24" :dut_cfg.ref_clk_mode = REFCLK_24M;
         default:begin
         `uvm_info(get_name(), $psprintf("refclk random yes!!!"), UVM_LOW) 
         end
         endcase
       end
     end          
     //dut_cfg.ref_clk_mode = REFCLK_100M;
//cfg ssc
     if (clp.get_arg_values("+SSCFLAG=",arg_values))begin
       foreach (arg_values[i])begin
         case(arg_values[i])
         "SSCNO":dut_cfg.ssc_mode = SSC_DISABLE;
         "SSCEN":dut_cfg.ssc_mode = SSC_ENABLE;         
         default:begin
         `uvm_info(get_name(), $psprintf("SSC random yes!!!"), UVM_LOW) 
         end
         endcase
       end
     end      
	 //dut_cfg.ssc_mode     = SSC_DISABLE;
//cfg lane_num
      if (clp.get_arg_values("+LANECFG=",arg_values))begin
       foreach (arg_values[i])begin
         case(arg_values[i])
         "1LANE":dut_cfg.usb32_lane_num = 'd1;
         "2LANE":dut_cfg.usb32_lane_num = 'd2;         
         default:begin
         `uvm_info(get_name(), $psprintf("lane_num random yes!!!"), UVM_LOW) 
         end
         endcase
       end
     end      
//       dut_cfg.usb32_lane_num='d2;
//    dut_cfg.usb32_gen_speed=GEN1_SPEED;
endfunction

function void cdn_u4_usb32_test_base::connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      usb32_env.host_agent.usb32_cfg.usb32_gen_speed = dut_cfg.usb32_gen_speed ; 
      usb32_env.device_agent.usb32_cfg.usb32_gen_speed = dut_cfg.usb32_gen_speed ; 
      usb32_env.host_agent.usb32_cfg.flip= dut_cfg.flip; 
      usb32_env.device_agent.usb32_cfg.flip= dut_cfg.flip; 
      usb32_env.host_agent.usb32_cfg.lane_num= dut_cfg.usb32_lane_num; 
      usb32_env.device_agent.usb32_cfg.lane_num= dut_cfg.usb32_lane_num; 

      uvm_callbacks#(cdn_u4_usb32_driver,cdn_callback)::add(usb32_env.host_agent.usb32_drv[0],m_callback);
      uvm_callbacks#(cdn_u4_usb32_driver,cdn_callback)::add(usb32_env.host_agent.usb32_drv[1],m_callback);
      uvm_callbacks#(cdn_u4_usb32_driver,cdn_callback)::add(usb32_env.device_agent.usb32_drv[0],m_callback);
      uvm_callbacks#(cdn_u4_usb32_driver,cdn_callback)::add(usb32_env.device_agent.usb32_drv[1],m_callback);
endfunction
  
task  cdn_u4_usb32_test_base::dyn_main_phase();     
     `uvm_info(get_name(), $psprintf("\033[1;42m main Please check waveform \033[0m "), UVM_LOW)
     usb32_env.host_agent.usb32_cfg.loopback_enable = 0;
     if(dut_cfg.usb32_gen_speed == GEN2_SPEED) begin
      usb32_env.host_agent.pipe_agt_if[0].pipe_intf.Rate= 1;
     end
     `ifndef DUT_BYPASS
     start_up();
     for(int i = 0 ;i< dut_cfg.usb32_lane_num;i++) begin 
       wait(usb32_env.host_agent.pipe_agt_if[i].pipe_intf.PhyStatus=='d0);
     end 
      `uvm_info(get_name(), $psprintf("greater again!!!"), UVM_LOW)  //timeedga     
    `endif
     for(int i = 0 ;i< dut_cfg.usb32_lane_num;i++) begin
       usb32_env.host_agent.pipe_agt_if[i].usb32_debug_intf.Far_end_Rx_Absent = 1;
       usb32_env.device_agent.pipe_agt_if[i].usb32_debug_intf.Far_end_Rx_Absent = 1;
     end
     //usb32_env.host_agent.pipe_agt_if[1].usb32_debug_intf.Far_end_Rx_Absent = 1;
     //usb32_env.device_agent.pipe_agt_if[1].usb32_debug_intf.Far_end_Rx_Absent = 1;
     #10us;
     for(int i = 0 ;i< dut_cfg.usb32_lane_num;i++) begin 
       usb32_env.host_agent.pipe_agt_if[i].usb32_debug_intf.Far_end_Rx_Absent = 0;
       usb32_env.device_agent.pipe_agt_if[i].usb32_debug_intf.Far_end_Rx_Absent = 0;
     //usb32_env.host_agent.pipe_agt_if[1].usb32_debug_intf.Far_end_Rx_Absent = 0;
     //usb32_env.device_agent.pipe_agt_if[1].usb32_debug_intf.Far_end_Rx_Absent = 0;
       usb32_env.host_agent.pipe_agt_if[i].usb32_debug_intf.Far_end_Rx_Detected = 1;
       usb32_env.device_agent.pipe_agt_if[i].usb32_debug_intf.Far_end_Rx_Detected = 1;
     //usb32_env.host_agent.pipe_agt_if[1].usb32_debug_intf.Far_end_Rx_Detected = 1;
     //usb32_env.device_agent.pipe_agt_if[1].usb32_debug_intf.Far_end_Rx_Detected = 1;
     end
//callback demo       
     //wait(usb32_env.host_agent.port_status.usb32_ltssm_substate == USB32_LINK::POLLING_ACTIVE|| usb32_env.device_agent.port_status.usb32_ltssm_substate == USB32_LINK::POLLING_ACTIVE);
     //`uvm_info(get_name(), $psprintf("\033[1;42m callback enable \033[0m "), UVM_LOW)
     //m_callback.set_callback_en(1);
     ////#200us;
     ////m_callback.set_callback_en(0);
     //   `uvm_info(get_name(), $psprintf("\033[1;42m Please check waveform \033[0m "), UVM_LOW)
endtask

task cdn_u4_usb32_test_base::start_up(); 
`ifndef DUT_BYPASS
    fork
       begin
           bringup_seq.start(usb32_env.vsqr);
           `uvm_info(get_name(), $psprintf(" bringup seq finish"), UVM_LOW)
             reset_seq_phy.phy_reset_en = 1;
           repeat($urandom_range(100,1000)) #1ns;
           fork
              reset_seq_phy.start(usb32_env.vsqr.m_reset_sqr[0]);
              `uvm_info(get_name(), $psprintf(" phyreset seq finish"), UVM_LOW)
           join
       end
       begin
           //wait(usb32_env.host_agent.pipe_agt_if[0].usb32_debug_intf.initial_done=='d1); //for Rate change debug TODO
           for(int i = 0 ;i< dut_cfg.usb32_lane_num;i++) begin
               reset_seq_pipe[i].pipe_reset_en = 1;
           end
           repeat($urandom_range(100,1000)) #1ns;
           for(int i = 0 ;i< dut_cfg.usb32_lane_num;i++) begin
              reset_seq_pipe[i].start(usb32_env.vsqr.m_reset_sqr[i]);
           end
              `uvm_info(get_name(), $psprintf(" pipereset seq finish"), UVM_LOW)
       end    
   join
 for(int i = 0 ;i< dut_cfg.usb32_lane_num;i++) begin
   wait(usb32_env.host_agent.pipe_agt_if[i].pipe_intf.PhyStatus=='d0);
 end
  `uvm_info(get_name(), $psprintf("greater again!!!"), UVM_LOW) 
  
 `endif
endtask 

`endif // CDN_U4_USB32_TEST_BASE__SV

