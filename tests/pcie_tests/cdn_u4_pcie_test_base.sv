
//
// Template for UVM-compliant testcase

`ifndef cdn_u4_pcie_test_base__SV
`define cdn_u4_pcie_test_base__SV

class cdn_u4_pcie_test_base extends cdn_phy_test_base;

  `uvm_component_utils(cdn_u4_pcie_test_base)

  cdn_u4_pcie_env pcie_env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
    pcie_env = cdn_u4_pcie_env::type_id::create("pcie_env", this);
	//for(int i = 0; i < tb_param :: PCIE_LANE_NUM; i++ ) begin
      uvm_config_db#(uvm_object_wrapper)::set(this,$psprintf("pcie_env.pcie_vsqr.main_phase"),"default_sequence",cdn_u4_pcie_base_sequence::type_id::get());
    //end
  endfunction

  virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
  endfunction
  
  virtual task dyn_main_phase();
	 real pclk_freq;
     //`uvm_info(get_name(),$sformatf("tb_cfg print as following:\n%s",this.pcie_env.host_agent.pcie_drv.tb_cfg.sprint()),UVM_LOW)
     `uvm_info(get_name(), $psprintf("\033[1;42m main Please check waveform \033[0m "), UVM_LOW)
	 case(dut_cfg.pcie_gen_speed)
	   GEN1_SPEED: pclk_freq = 62.5;
	   GEN2_SPEED: pclk_freq = 125.0;
	   GEN3_SPEED: pclk_freq = 250.0;
	   GEN4_SPEED: pclk_freq = 500.0;
	 endcase
     m_clk_seq.t_clk_para= '{clk_index : 0 , clk_en : 1, clk_frequency_MHz : pclk_freq, clk_duty_cycle : 0.5 ,set_ini_period_rand :1};
     m_clk_seq.set_one_clk_config();
     m_clk_seq.start(m_clk_sqr);
     #20us;
     pcie_env.host_agent.pipe_agt_if[0].debug_intf.Far_end_Rx_Detected = 1;
     pcie_env.host_agent.pipe_agt_if[0].debug_intf.Far_end_Rx_Absent = 0;
     pcie_env.device_agent.pipe_agt_if[0].debug_intf.Far_end_Rx_Detected = 1;
     pcie_env.device_agent.pipe_agt_if[0].debug_intf.Far_end_Rx_Absent = 0;
     if (dut_cfg.pcie_lane_num == 2) begin
     	 pcie_env.host_agent.pipe_agt_if[1].debug_intf.Far_end_Rx_Detected = 1;
         pcie_env.host_agent.pipe_agt_if[1].debug_intf.Far_end_Rx_Absent = 0;
     	 pcie_env.device_agent.pipe_agt_if[1].debug_intf.Far_end_Rx_Detected = 1;
         pcie_env.device_agent.pipe_agt_if[1].debug_intf.Far_end_Rx_Absent = 0;
     end
     #500us;
      `uvm_info(get_name(), $psprintf("\033[1;42m Please check waveform \033[0m "), UVM_LOW)
  endtask

endclass : cdn_u4_pcie_test_base

`endif //TEST__SV

