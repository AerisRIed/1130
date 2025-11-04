
//
// Template for UVM-compliant testcase

`ifndef CDN_U4_DP_TEST_BASE__SV
`define CDN_U4_DP_TEST_BASE__SV

class cdn_u4_dp_test_base extends cdn_phy_test_base;

  `uvm_component_utils(cdn_u4_dp_test_base)

  //---------------------------------
  // Member component
  //---------------------------------
  cdn_u4_dp_env dp_env;

  cdn_phy_bring_up_seq bring_up_seq;
  cdn_u4_dp_start_up_sequence  start_up_seq;

  //---------------------------------
  // Member seqs
  //---------------------------------
  cdn_u4_dp_virtual_sequence   dp_vseq;

  //---------------------------------------------
  // UVM functions and tasks
  //---------------------------------------------
  extern function new(string name, uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual task configure_phase(uvm_phase phase);
  extern virtual task main_phase(uvm_phase phase);

  //---------------------------------------------
  // User functions and tasks
  //---------------------------------------------
  extern virtual task gen_dp_pclk();
  extern virtual function void randomize_agent_config();

endclass : cdn_u4_dp_test_base


function cdn_u4_dp_test_base::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void cdn_u4_dp_test_base::build_phase(uvm_phase phase);
  super.build_phase(phase);

  dp_env = cdn_u4_dp_env::type_id::create("dp_env", this);
  bring_up_seq = cdn_phy_bring_up_seq::type_id::create("bring_up_seq", this);
  start_up_seq = cdn_u4_dp_start_up_sequence::type_id::create("start_up_seq");

  // random config
//  randomise_config();


//  dut_cfg.ref_clk_mode = REFCLK_100M;
//  dut_cfg.ssc_mode     = SSC_DISABLE;
//  dut_cfg.ssc_mode     = SSC_ENABLE;
//  dut_cfg.dp_data_rate = DP_RBR;
 // for(int i = 0; i < tb_param::DP_LANE_NUM; i++ ) begin
 //   uvm_config_db #(uvm_object_wrapper)::set(this, $sformatf("dp_env.dp_vsqr[%0d].host_sequencer.main_phase", i), "default_sequence", cdn_u4_dp_base_sequence::type_id::get()); 
 // end

  // set clks
  set_clks();

  dp_vseq = cdn_u4_dp_virtual_sequence::type_id::create("dp_vseq");

   // yzy add
 // if (tb_cfg.std_mode == ALT_MODE) begin 
 //   dp_env.alt_mode = DP_MODE;
 // end
  

endfunction

function void cdn_u4_dp_test_base::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  dp_env.dp_vsqr.base_vsqr = dp_env.vsqr;
  dp_env.dp_vsqr.m_clk_sqr = m_clk_sqr;
endfunction

task cdn_u4_dp_test_base::configure_phase(uvm_phase phase);
  super.configure_phase(phase);
  // random host/device agents config
  randomize_agent_config();
  //gen_dp_pclk();
endtask:configure_phase

task cdn_u4_dp_test_base::main_phase(uvm_phase phase);
  super.main_phase(phase);
//  uvm_hdl_force("cdn_phy_tb_top.cdns_usb_phy_top.phy_mode[3:0]",4'b0110); //only dp 
//  uvm_hdl_force("cdn_phy_tb_top.cdns_usb_phy_top.typec_conn_dir", 1'b0);
//  `uvm_info(get_type_name(),$sformatf("Start test 1111, %s",get_type_name() ),UVM_LOW);
  phase.raise_objection(this);

  `uvm_info(get_type_name(),$sformatf("Start test, %s",get_type_name() ),UVM_LOW);



//phy bring up operation
//step1:config register
  //if(tb_cfg.std_mode != ALT_MODE) begin
    bring_up_seq.start(dp_env.dp_vsqr.base_vsqr); 
  //end

 #50ns;
//step2 release reset -> pll_clk_en -> A2->AO
 start_up_seq.start(dp_env.dp_vsqr);

#50ns;
//  dp_vseq.start(dp_env.dp_vsqr); //mac link training operation
//  #100ns;
//  #10us;

//  `uvm_info(get_type_name(),$sformatf("End test, %s",get_type_name() ),UVM_LOW); 
  phase.drop_objection(this);
endtask

task cdn_u4_dp_test_base::gen_dp_pclk();
  m_clk_seq.t_clk_para = '{clk_index : 0 , clk_en : 1, clk_frequency_MHz : dp_env.host_agent.m_cfg.dp_pclk, clk_duty_cycle : 0.5 ,set_ini_period_rand :1};
  m_clk_seq.set_one_clk_config();
  m_clk_seq.start(dp_env.dp_vsqr.m_clk_sqr);
endtask

function void cdn_u4_dp_test_base::randomize_agent_config();
  assert(dp_env.host_agent.m_cfg.randomize() with {data_rate == dut_cfg.dp_data_rate;});
  assert(dp_env.device_agent.m_cfg.randomize() with {data_rate == dut_cfg.dp_data_rate;});
  dp_env.host_agent.get_dp_speed_cfg();
  dp_env.host_agent.set_dp_clk();
  dp_env.device_agent.get_dp_speed_cfg();
  dp_env.device_agent.set_dp_clk();
endfunction

`endif // CDN_U4_DP_TEST_BASE__SV

