//********************************************************
//* Cadence.
//*
//*Author                   : chao.huang 
//*Email                    : chaoh@cadence.com
//*Filename                 : cdn_u4_dp_agent.sv
//*Description  :                                         
//
//
//--------------------------------------------------------
//* Date	          Modified By		   Reason
//2025-06-13 03:14
//
//--------------------------------------------------------
//*******************************************************
class cdn_u4_dp_agent extends cdn_phy_agent_base;

    //------------------------------------
    // Member component                            
    //------------------------------------
    cdn_u4_dp_sequencer   dp_sqr[tb_param :: DP_LANE_NUM];
    cdn_u4_dp_driver      dp_drv[tb_param :: DP_LANE_NUM];
    cdn_u4_dp_monitor     dp_mon[tb_param :: DP_LANE_NUM];

    serdes_tx_model       m_serdes_tx[tb_param :: DP_LANE_NUM];
    serdes_rx_model       m_serdes_rx[tb_param :: DP_LANE_NUM];
    serdes_cfg            m_serdes_cfg;  
    //---------------------------------
    // Member config and interface
    //---------------------------------
    cdn_u4_dp_config      m_cfg;

    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_component_utils(cdn_u4_dp_agent)
     
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "cdn_u4_dp_agent", uvm_component parent);
        super.new(name,parent);
    endfunction : new

    //------------------------------------
    // UVM Methods 
    //------------------------------------
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);

    //---------------------------------------------
    // User functions and tasks
    //---------------------------------------------
    extern virtual function void randomize_config();
    extern virtual function void get_dp_speed_cfg();
    extern virtual function void set_dp_clk();

endclass : cdn_u4_dp_agent


/////////////////////////////////////////
// Function : build_phase
//   uvm build_phase
/////////////////////////////////////////
function void cdn_u4_dp_agent::build_phase(uvm_phase phase);
/*{{{*/
   super.build_phase(phase);
   m_cfg     = cdn_u4_dp_config::type_id::create("m_cfg");
   m_serdes_cfg = serdes_cfg::type_id::create("m_serdes_cfg",this);
   //randomize_config();
   //get_dp_speed_cfg();
   //set_dp_clk();
   if (is_active == UVM_ACTIVE) begin //creat handle
     for(int i = 0; i < tb_param :: DP_LANE_NUM; i++ ) begin
       dp_mon[i] = cdn_u4_dp_monitor::type_id::create($psprintf("dp_mon[%0d]",i), this);
       dp_sqr[i] = cdn_u4_dp_sequencer::type_id::create($psprintf("dp_sqr[%0d]",i), this);
       dp_drv[i] = cdn_u4_dp_driver::type_id::create($psprintf("dp_drv[%0d]",i), this);
       m_serdes_tx[i] = serdes_tx_model::type_id::create($psprintf("m_serdes_tx[%0d]",i),this);
       m_serdes_rx[i] = serdes_rx_model::type_id::create($psprintf("m_serdes_rx[%0d]",i),this);
       `uvm_info(get_full_name(), $psprintf("dp_mon[%0d] created!",i),UVM_LOW);
       `uvm_info(get_full_name(), $psprintf("dp_sqr[%0d] created!",i),UVM_LOW);
       `uvm_info(get_full_name(), $psprintf("dp_drv[%0d] created!",i),UVM_LOW);
     end
   end
   for(int i = 0; i < tb_param :: DP_LANE_NUM; i++ ) begin //set interface
     `uvm_info(get_full_name(), $psprintf("dp_drv[%0d] set interface",i),UVM_LOW);
     `uvm_info(get_full_name(), $psprintf("dp_mon[%0d] set interface",i),UVM_LOW);
     uvm_config_db# (cdn_phy_vif_t)::set(this,$psprintf("dp_drv[%0d]",i),"m_drv_if",pipe_agt_if[i]);
     uvm_config_db# (cdn_phy_vif_t)::set(this,$psprintf("dp_mon[%0d]",i),"m_mon_if",pipe_agt_if[i]);
   end
   // set m_cfg
   m_cfg.m_bfm = pipe_agt_if[0];
   uvm_config_db#(cdn_u4_dp_config)::set(this,"*","m_cfg",m_cfg);
endfunction : build_phase /*}}}*/
/////////////////////////////////////////
// Function : connect_phase
//   uvm connect_phase
/////////////////////////////////////////
function void cdn_u4_dp_agent::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   if (is_active == UVM_ACTIVE) begin
     for(int i = 0; i < tb_param :: DP_LANE_NUM; i++ ) begin
       dp_drv[i].seq_item_port.connect(dp_sqr[i].seq_item_export);
     end

	 foreach(m_serdes_tx[i]) begin
        m_serdes_tx[i].m_vif = pipe_agt_if[i].serdes_tx;
        m_serdes_tx[i].m_cfg = m_serdes_cfg;
        m_serdes_rx[i].m_vif = pipe_agt_if[i].serdes_rx;
        m_serdes_rx[i].m_cfg = m_serdes_cfg;
     end
   end
endfunction

function void cdn_u4_dp_agent::randomize_config();
  assert(m_cfg.randomize());
endfunction

function void cdn_u4_dp_agent::get_dp_speed_cfg();
  uvm_cmdline_processor clp;
  string arg_values[$];
  
  // get dp speed
  clp = uvm_cmdline_processor::get_inst();
  if (clp.get_arg_values("+DP_SPEED=", arg_values)) begin
    foreach(arg_values[i]) begin
      case(arg_values[i])
      "RBR":      m_cfg.data_rate = DP_RBR;
      "HBR":      m_cfg.data_rate = DP_HBR;
      "HBR2":     m_cfg.data_rate = DP_HBR2;
      "HBR3":     m_cfg.data_rate = DP_HBR3;
      "UHBR10":   m_cfg.data_rate = DP_UHBR10;
      "UHBR13P5": m_cfg.data_rate = DP_UHBR13P5;
      "UHBR20":   m_cfg.data_rate = DP_UHBR20;
      default: begin
        `uvm_fatal(get_full_name(), "DP speed is invalid")
      end
      endcase
      `uvm_info(get_full_name(), $sformatf("DP speed is set to %s", arg_values[i]), UVM_LOW);
    end
  end else begin
    `uvm_info(get_full_name(), $sformatf("DP speed is randomized to %s", m_cfg.data_rate.name()), UVM_LOW);
  end
endfunction

function void cdn_u4_dp_agent::set_dp_clk();
  real dp_serial_period;
  m_cfg.set_dp_pclk(m_cfg.data_rate);
  case(m_cfg.data_rate)
    DP_RBR,
    DP_HBR,
    DP_HBR2,
    DP_HBR3: begin
      dp_serial_period = 1000.0/(m_cfg.dp_pclk*20.0);
      m_serdes_cfg.set_default(dp_serial_period, 20, PAM2);
    end
    DP_UHBR10,
    DP_UHBR13P5,
    DP_UHBR20: begin
      dp_serial_period = 1000.0/(m_cfg.dp_pclk*32.0);
      m_serdes_cfg.set_default(dp_serial_period, 32, PAM2);
    end
    default : begin
      `uvm_error(get_type_name(),"set_dp_clk error: unknown dp data_rate")
    end
  endcase
endfunction


