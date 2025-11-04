class cdn_u4_pcie_ltssm_operation extends uvm_component;

  //------------------------------------------
  // Data Members 
  //------------------------------------------	
    bit start_rxdetect;
    bit start_polarity_invert;
    bit start_compliance;
    bit start_ts1;
    bit start_ts2;
    bit start_data;
    bit start_lp;
	bit start_beacon;
	bit start_rate;
	bit start_eq;
	
    cdn_u4_pcie_ltssm_control     m_ltssm_ctrl;
	cdn_u4_pcie_symbol_pattern    symbol_pattern;
	cdn_u4_pcie_symbol_pattern    symbol_pattern_pre;
	
    cdn_u4_pcie_symbol_pattern    overwrite_symbol_pattern;
	cdn_u4_pcie_symbol_pattern    overwrite_symbol_pattern_pre;

  //------------------------------------------
  // Port
  // Model will receive data in on this port 
  //------------------------------------------
  uvm_analysis_port#(cdn_u4_pcie_symbol_pattern)   sym_gen_stim_ap;

  //-------------------------------------------
  //handle
  //-------------------------------------------
  cdn_u4_pcie_config        		     m_cfg;
  cdn_phy_vif_t                          m_vif;
  cdn_u4_pcie_port_status               port_status;

  //-------------------------------------------
  // Methods
  //-------------------------------------------
  extern function      new(string name = "cdn_u4_pcie_ltssm_operation", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task          run_phase(uvm_phase phase);

  // APIs
  extern task          rxdetect_operation(); 
  extern task          polling_active_operation(); 
  extern task          polling_config_operation(); 
  extern task          configuration_wait_operation(); 
  extern task          configuration_complete_operation(); 
  extern task          configuration_idle_operation(); 
  extern task          l0_operation(); 
  extern task          l0s_entry_operation(); 
  extern task          l0s_operation(); 
  extern task          l0s_fts_operation();
  extern task          l1_entry_operation(); 
  extern task          l1_operation(); 
  extern task          l1_exit_operation(); 
  extern task          l2_entry_operation(); 
  extern task          l2_operation(); 
  extern task          l2_transmit_wake_operation(); 
  extern task          rcvr_lock_operation(); 
  extern task          rcvr_cfg_operation(); 
  extern task          rcvr_speed_operation(); 
  extern task          rcvr_eq_operation(); 
  extern task          rcvr_idle_operation(); 
  extern task          loopback_operation();
  extern task          compliance_operation();
  extern function void reset_local_variables();



  `uvm_component_utils(cdn_u4_pcie_ltssm_operation)

endclass : cdn_u4_pcie_ltssm_operation

function cdn_u4_pcie_ltssm_operation::new(string name = "cdn_u4_pcie_ltssm_operation", uvm_component parent);
	super.new(name, parent);/*{{{*/
endfunction : new/*}}}*/

function void cdn_u4_pcie_ltssm_operation::build_phase(uvm_phase phase);
/*{{{*/
	super.build_phase(phase);

  	sym_gen_stim_ap = new("sym_gen_stim_ap", this);

	symbol_pattern = new("symbol_pattern");

	symbol_pattern_pre = new("symbol_pattern_pre");
	overwrite_symbol_pattern_pre = new("overwrite_symbol_pattern_pre");

endfunction : build_phase/*}}}*/

function void cdn_u4_pcie_ltssm_operation::connect_phase(uvm_phase phase);
/*{{{*/
	super.connect_phase(phase);
    if (!uvm_config_db#(cdn_u4_pcie_config)::get(this,"","m_cfg",m_cfg))
	 `uvm_fatal("","operation cannot get m_cfg! please check.")

	this.symbol_pattern.m_cfg = this.m_cfg;
endfunction : connect_phase/*}}}*/

task cdn_u4_pcie_ltssm_operation::run_phase(uvm_phase phase);
/*{{{*/
	forever begin
		@(posedge m_vif.pclk);
		case(port_status.pcie_ltssm_state)
			PCIE_LINK::DETECT_ACTIVE:   rxdetect_operation();
			PCIE_LINK::POLLING_ACTIVE:  polling_active_operation();
			PCIE_LINK::POLLING_CONFIG:  polling_config_operation();
			PCIE_LINK::CONFIGURATION_WAIT:   	  configuration_wait_operation();
			PCIE_LINK::CONFIGURATION_COMPLETE:   configuration_complete_operation();
			PCIE_LINK::CONFIGURATION_IDLE:   	  configuration_idle_operation();
			PCIE_LINK::L0:              l0_operation();
			PCIE_LINK::L0S_ENTRY:       l0s_entry_operation();
			PCIE_LINK::L0S_IDLE:        l0s_operation();
			PCIE_LINK::L0S_FTS:         l0s_fts_operation();
			PCIE_LINK::L1_ENTRY:        l1_entry_operation();
			PCIE_LINK::L1_IDLE:         l1_operation();
			PCIE_LINK::L1_EXIT:         l1_exit_operation();
			PCIE_LINK::L2_ENTRY:        l2_entry_operation();
			PCIE_LINK::L2_IDLE:         l2_operation();
			PCIE_LINK::L2_TRANSMIT_WAKE:         l2_transmit_wake_operation();
			//PCIE_LINK::HOT_RESET:       hot_reset_operation();
			PCIE_LINK::LOOPBACK:        loopback_operation();
			PCIE_LINK::RECOVERY_LOCK:   rcvr_lock_operation();
			PCIE_LINK::RECOVERY_CFG:    rcvr_cfg_operation();
			PCIE_LINK::RECOVERY_SPEED:  rcvr_speed_operation();
			PCIE_LINK::RECOVERY_EQ:     rcvr_eq_operation();
			PCIE_LINK::RECOVERY_IDLE:   rcvr_idle_operation();
			PCIE_LINK::COMPLIANCE:      compliance_operation();//TODO important!
		endcase
		
        if(port_status.pcie_ltssm_state == PCIE_LINK::OVERWRITE) begin
		    overwrite_symbol_pattern= m_ltssm_ctrl.ltssm_instruction_local.symbol_pattern;
            if(!overwrite_symbol_pattern_pre.compare(overwrite_symbol_pattern))begin
		      `uvm_info(get_name(), $psprintf("sent the symbol gen obj = %s", overwrite_symbol_pattern.sprint()), UVM_LOW);
			  sym_gen_stim_ap.write(overwrite_symbol_pattern);
			  overwrite_symbol_pattern_pre.copy(overwrite_symbol_pattern); 
            end
        end else begin
            if(!symbol_pattern_pre.compare(symbol_pattern))begin
		      `uvm_info(get_name(), $psprintf("sent the symbol gen obj = %s", symbol_pattern.sprint()), UVM_LOW);
			  sym_gen_stim_ap.write(symbol_pattern);
			  symbol_pattern_pre.copy(symbol_pattern); 
		    end
        end
	
 
		reset_local_variables(); // When lane adapter state transition
	end
endtask : run_phase/*}}}*/

/////////////operation /////////////////////
//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::rxdetect_operation();
	if (!start_rxdetect) begin
	  symbol_pattern.clear_obj();
	  symbol_pattern.rxdetect = 1;
	  start_rxdetect = 1;
	end
endtask : rxdetect_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::polling_active_operation();
	if (!start_ts1) begin
	  symbol_pattern.clear_obj();
	  symbol_pattern.ts1 = 1;
	  start_ts1 = 1;
	end
endtask : polling_active_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::polling_config_operation();
	if (!start_polarity_invert) begin
	  symbol_pattern.clear_obj();
	  symbol_pattern.ts2 = 1;
	  //if (m_cfg.polarity_invert) symbol_pattern.polarity_invert = 1;
	  start_polarity_invert = 1;
	end
endtask : polling_config_operation/*}}}*/

//------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::compliance_operation();
	if (!start_compliance) begin
      symbol_pattern.clear_obj();
	  symbol_pattern.compliance = 1; // compliance pattern or modified compliance pattern
	  start_compliance = 1;
	end
endtask : compliance_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::configuration_wait_operation();
	if (!start_ts1) begin
	  symbol_pattern.clear_obj();
	  symbol_pattern.ts1 = 1;
	  start_ts1 = 1;
	end
endtask : configuration_wait_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::configuration_complete_operation();
	if (!start_ts2) begin
	  symbol_pattern.clear_obj();
	  symbol_pattern.ts2 = 1;
	  start_ts2 = 1;
	end
endtask : configuration_complete_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::configuration_idle_operation();
	if (!start_data) begin
	  symbol_pattern.clear_obj();
	  symbol_pattern.data_en = 1;
	  symbol_pattern.data_type = PCIE_LINK::IDL;
	  //symbol_pattern.scramble_en = m_cfg.scramble_en;
	  symbol_pattern.scramble_en = $urandom_range(0,1);
	  start_data = 1;
	end
endtask : configuration_idle_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::loopback_operation();
/*{{{*/
endtask : loopback_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::l0s_entry_operation();
	if (port_status.transmitter_l0s) begin	 // transmitter l0s
	  if (!start_lp) begin
	    symbol_pattern.clear_obj();
	    symbol_pattern.l0s = 1;
		start_lp = 1;
	  end
	end
endtask : l0s_entry_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::l0s_operation();
	if (!port_status.transmitter_l0s) begin	 // receiver l0s
	  if (!start_data) begin
	    symbol_pattern.clear_obj();
	    symbol_pattern.data_en = 1;
	    symbol_pattern.data_type = RANDOM;
		start_data = 1;
	  end
	end
endtask : l0s_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::l0s_fts_operation();
	if (port_status.transmitter_l0s) begin	 // transmitter l0s
	  if (!start_lp) begin
	    symbol_pattern.clear_obj();
	    symbol_pattern.fts = 1;
	    symbol_pattern.n_fts = 32; // TODO
		start_lp = 1;
	  end
	end
endtask : l0s_fts_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::l1_entry_operation();
	if (!start_lp) begin
	  symbol_pattern.clear_obj();
	  symbol_pattern.l1 = 1;
	  start_lp = 1;
	end
endtask : l1_entry_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::l1_operation();
	symbol_pattern.clear_obj();
endtask : l1_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::l1_exit_operation();
	if (!start_lp) begin
	  symbol_pattern.clear_obj();
	  symbol_pattern.l1_exit = 1;
	  start_lp = 1;
	end
endtask : l1_exit_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::l2_entry_operation();
	if (!start_lp) begin
	  symbol_pattern.clear_obj();
	  symbol_pattern.l2 = 1;
	  start_lp = 1;
	end
endtask : l2_entry_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::l2_operation();
	symbol_pattern.clear_obj();
endtask : l2_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::l2_transmit_wake_operation();
	if (!start_beacon) begin
	  symbol_pattern.clear_obj();
	  symbol_pattern.beacon = 1;
	  start_beacon = 1;
	end
endtask : l2_transmit_wake_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::l0_operation();
	if (!start_data) begin              
      symbol_pattern.clear_obj();
      symbol_pattern.data_en= 1;
      symbol_pattern.data_type= RANDOM;
	  start_data = 1;
	end
endtask : l0_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::rcvr_lock_operation();
	if (!start_ts1) begin              
      symbol_pattern.clear_obj();
      symbol_pattern.ts1= 1;
	  start_ts1 = 1;
	end
endtask : rcvr_lock_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::rcvr_cfg_operation();
	if (!start_ts2) begin              
      symbol_pattern.clear_obj();
      symbol_pattern.ts2= 1;
	  start_ts2 = 1;
	end
endtask : rcvr_cfg_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::rcvr_speed_operation();
	if (!start_rate) begin              
      symbol_pattern.clear_obj();
      symbol_pattern.rate= 1;
	  start_rate = 1;
	end
endtask : rcvr_speed_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::rcvr_eq_operation();
	if (!start_eq) begin              
      symbol_pattern.clear_obj();
      symbol_pattern.eq_en= 1;
	  start_eq = 1;
	end
endtask : rcvr_eq_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_pcie_ltssm_operation::rcvr_idle_operation();
	if (!start_data) begin              
      symbol_pattern.clear_obj();
      symbol_pattern.data_en= 1;
      symbol_pattern.data_type= IDL;
	  start_data = 1;
	end
endtask : rcvr_idle_operation/*}}}*/

//------------------------------------------------------------------
// Function to reset all local variables
function void cdn_u4_pcie_ltssm_operation::reset_local_variables();
/*{{{*/
	if((port_status.pcie_ltssm_state != port_status.nxt_pcie_ltssm_state))begin
	  `uvm_info(get_name(), $psprintf("Reset local variables to control results output"), UVM_LOW);
       start_ts1                 =0;
       start_ts2                 =0;
       start_data 	             =0;
       start_lp   	             =0;
	   start_rxdetect			 =0;
       start_polarity_invert	 =0;
       start_compliance 		 =0;
       start_beacon 			 =0;
       start_rate 			     =0;
       start_eq 			   	 =0;
    end

endfunction : reset_local_variables/*}}}*/




