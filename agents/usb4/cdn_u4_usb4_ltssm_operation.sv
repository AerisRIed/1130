class cdn_u4_usb4_ltssm_operation extends uvm_component;

  //------------------------------------------
  // Data Members 
  //------------------------------------------	
    bit start_send_lfps;
    bit start_send_slos1;
    bit start_send_slos2;
    bit start_send_ts1;
    bit start_send_ts2;
    bit start_send_ei;
    bit start_send_idle_packet;
    bit start_send_lfps_wake;	
    
    cdn_u4_usb4_ltssm_control     m_ltssm_ctrl;
	cdn_u4_usb4_symbol_pattern    symbol_pattern;
	cdn_u4_usb4_symbol_pattern    symbol_pattern_pre;
	
    cdn_u4_usb4_symbol_pattern    overwrite_symbol_pattern;
	cdn_u4_usb4_symbol_pattern    overwrite_symbol_pattern_pre;

  //------------------------------------------
  // Port
  // Model will receive data in on this port 
  //------------------------------------------
  uvm_analysis_port#(cdn_u4_usb4_symbol_pattern)   sym_gen_stim_ap;

  //-------------------------------------------
  //handle
  //-------------------------------------------
  cdn_u4_usb4_config                    m_cfg;
  cdn_phy_vif_t                         m_vif[2];
  cdn_u4_usb4_port_status               port_status;

  //-------------------------------------------
  // Methods
  //-------------------------------------------
  extern function      new(string name = "cdn_u4_usb4_ltssm_operation", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task          run_phase(uvm_phase phase);

  // APIs
  extern task          configure_pipe();
  extern task          training_substate_op();
  extern task          training_operation();
  extern task          cl0_operation();
  extern task          cld_operation();
  extern task          cl1_operation();
  extern task          cl2_operation();
  extern task          cl0s_operation();
  extern task          cl1_exit_operation();
  extern task          cl2_exit_operation();
  extern task          cl0s_exit_operation();
  extern function void reset_local_variables();



  `uvm_component_utils(cdn_u4_usb4_ltssm_operation)

endclass : cdn_u4_usb4_ltssm_operation

function cdn_u4_usb4_ltssm_operation::new(string name = "cdn_u4_usb4_ltssm_operation", uvm_component parent);
	super.new(name, parent);/*{{{*/
endfunction : new/*}}}*/

function void cdn_u4_usb4_ltssm_operation::build_phase(uvm_phase phase);
/*{{{*/
	super.build_phase(phase);

  	sym_gen_stim_ap = new("sym_gen_stim_ap", this);

	symbol_pattern = new("symbol_pattern");

	symbol_pattern_pre = new("symbol_pattern_pre");
	overwrite_symbol_pattern_pre = new("overwrite_symbol_pattern_pre");

endfunction : build_phase/*}}}*/

function void cdn_u4_usb4_ltssm_operation::connect_phase(uvm_phase phase);
/*{{{*/
	super.connect_phase(phase);
    m_cfg = this.m_cfg;
endfunction : build_phase/*}}}*/

task cdn_u4_usb4_ltssm_operation::run_phase(uvm_phase phase);
/*{{{*/
	forever begin
		@(posedge m_vif[0].pclk);
		reset_local_variables(); // When lane adapter state transition
		fork
			begin
				case(port_status.usb4_ltssm_state)
					CLD:              cld_operation();
					CL0:              cl0_operation();
					CL1:              cl1_operation();
					CL2:              cl2_operation();
					CL0S:             cl0s_operation();
					CL1_EXIT:         cl1_exit_operation();
					CL2_EXIT:         cl2_exit_operation();
					CL0S_EXIT:        cl0s_exit_operation();
					//Disabled:         disable_operation();//
					TRAINING:         training_operation();//
				endcase
			end
		join
		
        if(port_status.usb4_ltssm_state == OVERWRITE) begin
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
	end
endtask : run_phase/*}}}*/

//---------------------------------------------------------
// Task to do normal operation in tranining state
task cdn_u4_usb4_ltssm_operation::training_operation();
/*{{{*/
	training_substate_op();

endtask : training_operation/*}}}*/

//------------------------------------------------------
// Task to do normal operation in training substate
task cdn_u4_usb4_ltssm_operation::training_substate_op();/*{{{*/

	case(port_status.usb4_ltssm_substate)
       LOCK1:
       begin
           if(!start_send_slos1)begin
               symbol_pattern.clear_obj();
               symbol_pattern.slos1_gen_en= 1;
               start_send_slos1= 1;
           end
       end
       LOCK2:
       begin
           if(!start_send_slos2)begin
               symbol_pattern.clear_obj();
               symbol_pattern.slos2_gen_en= 1;
               start_send_slos2= 1;
           end
       end
       TS1:
       begin
           if(!start_send_ts1)begin
               symbol_pattern.clear_obj();
               symbol_pattern.ts1_gen_en= 1;
               start_send_ts1= 1;
           end
       end
       TS2:
       begin
           if(!start_send_ts2)begin
               symbol_pattern.clear_obj();
               symbol_pattern.ts2_gen_en= 1;
               start_send_ts2= 1;
           end
       end
       //IDLE:
       //begin
       //end
	endcase
endtask : training_substate_op/*}}}*/


//-------------------------------------------------------------
task cdn_u4_usb4_ltssm_operation::cl1_operation();
/*{{{*/
    if(!start_send_ei)begin
        symbol_pattern.clear_obj();
        symbol_pattern.electric_idle_en= 1;
        start_send_ei= 1;
    end
endtask : u1_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb4_ltssm_operation::cl2_operation();
/*{{{*/    
    if(!start_send_ei)begin
        symbol_pattern.clear_obj();
        symbol_pattern.electric_idle_en= 1;
        start_send_ei= 1;
    end
endtask : u2_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb4_ltssm_operation::cl0s_operation();
/*{{{*/    
    if(!start_send_ei)begin
        symbol_pattern.clear_obj();
        symbol_pattern.electric_idle_en= 1;
        start_send_ei= 1;
    end
endtask : u3_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb4_ltssm_operation::cl1_exit_operation();
/*{{{*/ 
    if(!start_send_lfps_wake)begin
        symbol_pattern.clear_obj();
        symbol_pattern.cl1_exit_gen_en= 1;
        start_send_lfps_wake= 1;
    end
endtask : cl1_exit_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb4_ltssm_operation::cl2_exit_operation();
/*{{{*/ 
    if(!start_send_lfps_wake)begin
        symbol_pattern.clear_obj();
        symbol_pattern.cl2_exit_gen_en= 1;
        start_send_lfps_wake= 1;
    end
endtask : cl2_exit_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb4_ltssm_operation::cl0s_exit_operation();
/*{{{*/ 
    if(!start_send_lfps_wake)begin
        symbol_pattern.clear_obj();
        symbol_pattern.cl0s_exit_gen_en= 1;
        start_send_lfps_wake= 1;
    end
endtask : cl0s_exit_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb4_ltssm_operation::cl0_operation();
/*{{{*/               
    symbol_pattern.clear_obj();
    symbol_pattern.random_packet_gen_en= 1;
endtask : cl0_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb4_ltssm_operation::configure_pipe();
/*{{{*/
    //wait reset//
    m_vif[0].pipe_intf.SerDesArch= 1;
    m_vif[1].pipe_intf.SerDesArch= 1;
    m_vif[0].pipe_intf.TxDataValid= 1;
    m_vif[1].pipe_intf.TxDataValid= 1;
    m_vif[0].pipe_intf.TxElecIdle= 1;
    m_vif[1].pipe_intf.TxElecIdle= 1;
    m_vif[0].pipe_intf.PHYmode = USB4;
    m_vif[1].pipe_intf.PHYmode = USB4;
    m_vif[0].pipe_intf.Width = 2;
    m_vif[1].pipe_intf.Width = 2;
    if(m_cfg.usb4_gen_speed==GEN2_SPEED) begin
        m_vif[0].usb4_debug_intf.usb4_speed_state_ascii = $sformatf("USB4 GEN2");
        m_vif[1].usb4_debug_intf.usb4_speed_state_ascii = $sformatf("USB4 GEN2"); 
        m_vif[0].pipe_intf.Rate = 0;
        m_vif[1].pipe_intf.Rate = 0;
    end else begin
        m_vif[0].usb4_debug_intf.usb4_speed_state_ascii = $sformatf("USB4 GEN3");
        m_vif[1].usb4_debug_intf.usb4_speed_state_ascii = $sformatf("USB4 GEN3"); 
        m_vif[0].pipe_intf.Rate = 1;
        m_vif[1].pipe_intf.Rate = 1;
    end
    m_vif[0].pipe_intf.PowerDown = P1_STATE;
    m_vif[1].pipe_intf.PowerDown = P1_STATE;
    
    m_vif[0].pipe_intf.PowerDown = P1_STATE;
    m_vif[1].pipe_intf.PowerDown = P1_STATE;
    m_vif[0].pipe_intf.PowerDown = P1_STATE;
    m_vif[1].pipe_intf.PowerDown = P1_STATE;
    m_vif[0].usb4_debug_intf.initial_done = 1;
    m_vif[1].usb4_debug_intf.initial_done = 1;
endtask : configure_pipe/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb4_ltssm_operation::cld_operation();
/*{{{*/ 
    configure_pipe();
    wait(m_vif[0].usb4_debug_intf.tx_rx_enable == 1);        
    m_vif[0].pipe_intf.PowerDown = P0_STATE;
    m_vif[1].pipe_intf.PowerDown = P0_STATE;
    `ifndef DUT_BYPASS
    if(m_cfg.port_mode ==HOST) begin
        fork
            @ (posedge m_vif[0].pipe_intf.PhyStatus);      
            @ (posedge m_vif[1].pipe_intf.PhyStatus);      
        join
    end
`endif
endtask : cld_operation/*}}}*/
//------------------------------------------------------------------
// Function to reset all local variables
function void cdn_u4_usb4_ltssm_operation::reset_local_variables();
/*{{{*/
	if((port_status.usb4_ltssm_state != port_status.nxt_usb4_ltssm_state))begin
	`uvm_info(get_name(), $psprintf("Reset local variables to control results output"), UVM_LOW);
     start_send_lfps                =0;
     start_send_slos1               =0;
     start_send_ts1                 =0;
     start_send_ts2                 =0;
     start_send_idle_packet         =0;
     start_send_ei                  =0;
     start_send_lfps_wake           =0;
    end

endfunction : reset_local_variables/*}}}*/




