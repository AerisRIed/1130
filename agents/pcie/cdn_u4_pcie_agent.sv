//********************************************************
//* Cadence.
//*
//*Author                   : chao.huang 
//*Email                    : chaoh@cadence.com
//*Filename                 : cdn_u4_pcie_agent.sv
//*Description  :                                         
//
//
//--------------------------------------------------------
//* Date	          Modified By		   Reason
//2025-06-13 03:14
//
//--------------------------------------------------------
//*******************************************************
class cdn_u4_pcie_agent extends cdn_phy_agent_base;

    //------------------------------------
    // Member                             
    //------------------------------------
    cdn_u4_pcie_sequencer 	pcie_sqr;
    cdn_u4_pcie_driver 		pcie_drv[tb_param :: PCIE_LANE_NUM];
    cdn_u4_pcie_monitor 	pcie_mon[tb_param :: PCIE_LANE_NUM];
	//cdn_u4_pcie_port_configuration      pcie_cfg;
    cdn_u4_pcie_config  m_cfg;
	cdn_u4_pcie_ltssm_control           pcie_ltssm_control;
    cdn_u4_pcie_ltssm_operation         pcie_ltssm_operation;
	cdn_u4_pcie_port_status             port_status;

	serdes_tx_model                     m_serdes_tx[tb_param :: PCIE_LANE_NUM];
    serdes_rx_model                     m_serdes_rx[tb_param :: PCIE_LANE_NUM];
    serdes_cfg                          m_serdes_cfg;
    cdn_phy_tb_config 			    	tb_cfg;
    cdn_phy_dut_config            dut_cfg;
    cdn_phy_dut_config            device_dut_cfg;


    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_component_utils(cdn_u4_pcie_agent)
     
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "cdn_u4_pcie_agent", uvm_component parent);
        super.new(name,parent);
    endfunction : new

    //------------------------------------
    // Methods 
    //------------------------------------
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task configure_phase(uvm_phase phase);
	  //extern function void get_pcie_speed_cfg();

endclass : cdn_u4_pcie_agent


/////////////////////////////////////////
// Function : build_phase
//   uvm build_phase
/////////////////////////////////////////
function void cdn_u4_pcie_agent::build_phase(uvm_phase phase);
/*{{{*/
    super.build_phase(phase);  // get pipe_agt_if
	  port_status = new("port_status");
      m_cfg     = cdn_u4_pcie_config::type_id::create("m_cfg");
	  assert(m_cfg.randomize());
	  //get_pcie_speed_cfg();
      m_serdes_cfg = serdes_cfg::type_id::create("m_serdes_cfg",this);
	  pcie_ltssm_operation = cdn_u4_pcie_ltssm_operation::type_id::create($psprintf("pcie_ltssm_operation"), this);
      pcie_ltssm_control = cdn_u4_pcie_ltssm_control::type_id::create($psprintf("pcie_ltssm_control"), this);
      pcie_sqr = cdn_u4_pcie_sequencer::type_id::create($psprintf("pcie_sqr"), this);
	  // tb_cfg
	  if (!uvm_config_db#(cdn_phy_tb_config)::get(this,"","tb_cfg",tb_cfg))
	 	`uvm_fatal("","agent cannot get tb_cfg! please check.")
    // dut cfg
    if (!uvm_config_db#(cdn_phy_dut_config)::get(this,"","dut_cfg",dut_cfg))
	 	`uvm_fatal("","agent cannot get dut_cfg! please check.")
    if (!uvm_config_db#(cdn_phy_dut_config)::get(this,"","device_dut_cfg",device_dut_cfg))
	 	`uvm_fatal("","agent cannot get device_dut_cfg! please check.")
    // serdes width
	  case(dut_cfg.pcie_gen_speed)
	    GEN1_SPEED: m_serdes_cfg.set_default(0.4ns,40,PAM2);
	    GEN2_SPEED: m_serdes_cfg.set_default(0.2ns,40,PAM2);
	    GEN3_SPEED: m_serdes_cfg.set_default(0.125ns,32,PAM2);
	    GEN4_SPEED: m_serdes_cfg.set_default(0.0625ns,32,PAM2);
	  endcase
	  //creat handle
      if (is_active == UVM_ACTIVE) begin
        for(int i = 0; i < dut_cfg.pcie_lane_num; i++ ) begin
            pcie_mon[i] = cdn_u4_pcie_monitor::type_id::create($psprintf("pcie_mon[%0d]",i), this);
            pcie_drv[i] = cdn_u4_pcie_driver::type_id::create($psprintf("pcie_drv[%0d]",i), this);
            m_serdes_tx[i] = serdes_tx_model::type_id::create($psprintf("m_serdes_tx[%0d]",i),this);
            m_serdes_rx[i] = serdes_rx_model::type_id::create($psprintf("m_serdes_rx[%0d]",i),this);
            `uvm_info("build phase", $psprintf("pcie_mon[%0d] created!",i),UVM_LOW);
            `uvm_info("build phase", $psprintf("pcie_drv[%0d] created!",i),UVM_LOW);
        end
      end
      for(int i = 0; i < dut_cfg.pcie_lane_num; i++ ) begin //set interface
          `uvm_info("build phase", $psprintf("set interface to drv and mon"),UVM_LOW);
          uvm_config_db# (cdn_phy_vif_t)::set(this,$psprintf("pcie_drv[%0d]",i),"m_drv_if",pipe_agt_if[i]);
          uvm_config_db# (cdn_phy_vif_t)::set(this,$psprintf("pcie_mon[%0d]",i),"m_mon_if",pipe_agt_if[i]);
      end
	// set pcie cfg
   uvm_config_db#(cdn_u4_pcie_config)::set(this,"*","m_cfg",m_cfg);
endfunction : build_phase /*}}}*/
/////////////////////////////////////////
// Function : connect_phase
//   uvm connect_phase
/////////////////////////////////////////
function void cdn_u4_pcie_agent::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   if (is_active == UVM_ACTIVE) begin
     pcie_ltssm_operation.m_vif                 = this.pipe_agt_if[0];
     pcie_ltssm_operation.m_ltssm_ctrl          = this.pcie_ltssm_control;
     pcie_ltssm_operation.port_status           = this.port_status;
     pcie_ltssm_control.port_status             = this.port_status;
     pcie_ltssm_control.ltssm_instruction_port.connect(pcie_sqr.seq_item_export);
     for(int i = 0; i < dut_cfg.pcie_lane_num; i++ ) begin
      pcie_drv[i].m_vif                             = this.pipe_agt_if[i];
      pcie_ltssm_control.m_vif[i]                   = this.pipe_agt_if[i];
      pcie_mon[i].port_status           			= this.port_status;
      pcie_ltssm_operation.sym_gen_stim_ap.connect(pcie_drv[i].cdn_u4_pcie_symbol_export_ep);
	  `uvm_info(get_name(),"connect phase excute!",UVM_LOW);
     end
	 for(int i = 0; i < dut_cfg.pcie_lane_num; i++) begin
        m_serdes_tx[i].m_vif = pipe_agt_if[i].serdes_tx;
        m_serdes_tx[i].m_cfg = m_serdes_cfg;
        m_serdes_rx[i].m_vif = pipe_agt_if[i].serdes_rx;
        m_serdes_rx[i].m_cfg = m_serdes_cfg;
     end
   end
endfunction


task cdn_u4_pcie_agent::configure_phase(uvm_phase phase);
   super.configure_phase(phase);
   `uvm_info(get_type_name(),$sformatf("pcie_cfg print as following:\n%s",this.m_cfg.sprint()),UVM_LOW)
endtask

//function void cdn_u4_pcie_agent::get_pcie_speed_cfg();
//  string arg_value[$];
//  uvm_cmdline_processor clp;
//
//  clp = uvm_cmdline_processor::get_inst();
//  if (clp.get_arg_values("+PCIE_SPEED=", arg_value)) begin
//     case(arg_value[0])
//     "PCIE_GEN1":  m_cfg.gen_speed = GEN1_SPEED;
//     "PCIE_GEN2":  m_cfg.gen_speed = GEN2_SPEED;
//     "PCIE_GEN3":  m_cfg.gen_speed = GEN3_SPEED;
//     "PCIE_GEN4":  m_cfg.gen_speed = GEN4_SPEED;
//     default: `uvm_fatal("", "speed is invalid")
//     endcase
//     `uvm_info("", $sformatf("speed is set to %s", arg_value[0]), UVM_LOW);
//  end else begin
//    `uvm_fatal("", "speed is not set")
//  end
//endfunction
