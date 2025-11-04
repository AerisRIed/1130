
class cdn_u4_usb32_ltssm_operation extends uvm_component;

  //------------------------------------------
  // Data Members 
  //------------------------------------------	
    bit start_send_lfps;
    bit start_send_scd1;
    bit start_send_scd2;
    bit start_send_lbpm_config;
    bit start_send_lbpm_ready;
    bit start_send_tseq;
    bit wait_phystatus;
    bit start_send_ts1;
    bit start_send_ts2;
    bit start_send_idle_packet;
    bit start_send_ei;
    bit start_send_lfps_wake;	
    int detect_over_limit_count;
    
    cdn_u4_usb32_ltssm_control     m_ltssm_ctrl;
	cdn_u4_usb32_symbol_pattern    symbol_pattern;
	cdn_u4_usb32_symbol_pattern    symbol_pattern_copy;
	cdn_u4_usb32_symbol_pattern    symbol_pattern_pre;
	
    cdn_u4_usb32_symbol_pattern    overwrite_symbol_pattern;
	cdn_u4_usb32_symbol_pattern    overwrite_symbol_pattern_pre;

  //------------------------------------------
  // Port
  // Model will receive data in on this port 
  //------------------------------------------
  uvm_analysis_port#(cdn_u4_usb32_symbol_pattern)   sym_gen_stim_ap;

  //-------------------------------------------
  //handle
  //-------------------------------------------
  cdn_u4_usb32_config                    m_cfg;
  cdn_phy_vif_t                          m_vif[tb_param::USB32_LANE_NUM];
  cdn_u4_usb32_port_status               port_status;

  //-------------------------------------------
  // Methods
  //-------------------------------------------
  extern function      new(string name = "cdn_u4_usb32_ltssm_operation", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task          run_phase(uvm_phase phase);

  // APIs
  extern task          configure_pipe();
  extern task          disabled_operation();
  extern task          polling_operation();
  extern task          polling_substate_op();
  extern task          recovery_operation();
  extern task          inactive_operation();
  extern task          rxdetect_operation();
  extern task          u0_operation();
  extern task          u1_operation();
  extern task          u2_operation();
  extern task          u3_operation();
  extern task          u1_exit_operation();
  extern task          u2_exit_operation();
  extern task          u3_exit_operation();
  extern task          loopback_exit_operation();
  extern task          hot_reset_operation();
  extern task          loopback_operation();
  extern task          loopback_brst_operation();
  extern task          compliance_operation();
  extern function void reset_local_variables();
  extern task          detect_over_limit_monitor();
  extern task          receiver_termination();



  `uvm_component_utils(cdn_u4_usb32_ltssm_operation)

endclass : cdn_u4_usb32_ltssm_operation

function cdn_u4_usb32_ltssm_operation::new(string name = "cdn_u4_usb32_ltssm_operation", uvm_component parent);
	super.new(name, parent);/*{{{*/
endfunction : new/*}}}*/

function void cdn_u4_usb32_ltssm_operation::build_phase(uvm_phase phase);
/*{{{*/
	super.build_phase(phase);

  	sym_gen_stim_ap = new("sym_gen_stim_ap", this);
	symbol_pattern = new("symbol_pattern");
	symbol_pattern_copy= new("symbol_pattern_copy");

	symbol_pattern_pre = new("symbol_pattern_pre");
	overwrite_symbol_pattern_pre = new("overwrite_symbol_pattern_pre");

endfunction : build_phase/*}}}*/

function void cdn_u4_usb32_ltssm_operation::connect_phase(uvm_phase phase);
/*{{{*/
	super.connect_phase(phase);
    `uvm_info(get_full_name(),$sformatf("size is %d",sym_gen_stim_ap.size()),UVM_LOW);
    m_cfg = this.m_cfg;
endfunction : build_phase/*}}}*/

task cdn_u4_usb32_ltssm_operation::run_phase(uvm_phase phase);
/*{{{*/
    int idle_index;
    int u0_index;
	forever begin
		@(posedge m_vif[0].pclk);
		reset_local_variables(); // When lane adapter state transition
		fork
			begin
				case(port_status.usb32_ltssm_state)
					SS_INACTIVE:     inactive_operation();
					RX_DETECT:       rxdetect_operation();
					SS_DISABLE:      disabled_operation();
					POLLING:         polling_operation();
					U0:              u0_operation();
					U1:              u1_operation();
					U2:              u2_operation();
					U3:              u3_operation();
					U1_EXIT:         u1_exit_operation();
					U2_EXIT:         u2_exit_operation();
					U3_EXIT:         u3_exit_operation();
					HOT_RESET:       hot_reset_operation();
					LOOPBACK_EXIT:   loopback_exit_operation();
					LOOPBACK_RST:    loopback_brst_operation();
					LOOPBACK_M:      loopback_operation();
					LOOPBACK_S:      loopback_operation();
					RECOVERY:        recovery_operation();
					COMPLIANCE:      compliance_operation();//TODO important!
				endcase
			end
		join
		
        if(port_status.usb32_ltssm_state == OVERWRITE) begin
		    overwrite_symbol_pattern= m_ltssm_ctrl.ltssm_instruction_local.symbol_pattern;
            if(!overwrite_symbol_pattern_pre.compare(overwrite_symbol_pattern))begin
		    `uvm_info(get_name(), $psprintf("sent the symbol gen obj = %s", overwrite_symbol_pattern.sprint()), UVM_LOW);
			sym_gen_stim_ap.write(overwrite_symbol_pattern);
			overwrite_symbol_pattern_pre.copy(overwrite_symbol_pattern); 
            end
        end else if(symbol_pattern.random_packet_gen_en)begin
            if(u0_index ==0) begin
			symbol_pattern.randomize();
            symbol_pattern.gen_data();
            symbol_pattern_copy =new();
            symbol_pattern_copy.do_copy(symbol_pattern);
		    `uvm_info(get_name(), $psprintf("sent the symbol gen obj = %s", symbol_pattern_copy.sprint()), UVM_LOW);
            sym_gen_stim_ap.write(symbol_pattern_copy);
            end
            u0_index ++;
            if(u0_index == 4) u0_index = 0;
        end else begin
            if(!symbol_pattern_pre.compare(symbol_pattern))begin
			symbol_pattern_pre.copy(symbol_pattern); 
			symbol_pattern.randomize();
            symbol_pattern.gen_data();
		    `uvm_info(get_name(), $psprintf("sent the symbol gen obj = %s", symbol_pattern.sprint()), UVM_LOW);
            sym_gen_stim_ap.write(symbol_pattern);
		    end
        end
	end
endtask : run_phase/*}}}*/

//---------------------------------------------------------
// Task to do normal operation in polling state
task cdn_u4_usb32_ltssm_operation::polling_operation();
/*{{{*/
    foreach(m_vif[i]) begin
        m_vif[i].pipe_intf.PowerDown = P0_STATE;
    end
    `ifndef DUT_BYPASS
    if(~wait_phystatus && m_cfg.port_mode == HOST) begin
        @ (posedge m_vif[0].pipe_intf.PhyStatus);
    end
    wait_phystatus = 1;
    `endif
    polling_substate_op();
endtask : polling_operation/*}}}*/

//------------------------------------------------------
// Task to do normal operation in training substate
task cdn_u4_usb32_ltssm_operation::polling_substate_op();/*{{{*/

	case(port_status.usb32_ltssm_substate)
        POLLING_LFPS:
        begin
            if(m_cfg.usb32_gen_speed==GEN1_SPEED&& !start_send_lfps) begin
                symbol_pattern.clear_obj();
                symbol_pattern.lfps_gen_en = 1;
                start_send_lfps = 1;
            end else if(m_cfg.usb32_gen_speed==GEN2_SPEED&& !start_send_scd1)begin
                symbol_pattern.clear_obj();
                symbol_pattern.lfps_gen_en= 1;
                start_send_scd1 = 1;
                if(m_vif[0].usb32_debug_intf.lfps_received_count >= 16 && !m_vif[0].usb32_debug_intf.tPollingLFPSTimeout_flag && !start_send_lfps)begin//speed down
                    symbol_pattern.clear_obj(); // TODO
                    symbol_pattern.lfps_gen_en = 1;
                    start_send_lfps = 1;
                end
            end
        end
        POLLING_LFPSPLUS:
        begin
            if(m_cfg.usb32_gen_speed==GEN2_SPEED&& !start_send_scd2)begin
                symbol_pattern.clear_obj();
                symbol_pattern.scd2_gen_en = 1;
                start_send_scd2 = 1;
            end
        end
        POLLING_PORTMATCH:
        begin
            if(!start_send_lbpm_config)begin
                symbol_pattern.clear_obj();
                symbol_pattern.lbpm_config_gen_en= 1;
                start_send_lbpm_config= 1;
            end
        end
       POLLING_PORTCONFIG:
       begin
           if(!start_send_lbpm_ready)begin
               symbol_pattern.clear_obj();
               symbol_pattern.lbpm_ready_gen_en= 1;
               start_send_lbpm_ready= 1;
           end
       end
       POLLING_RXEQ:
       begin
           if(!start_send_tseq)begin
               symbol_pattern.clear_obj();
               symbol_pattern.tseq_gen_en= 1;
               start_send_tseq= 1;
           end
       end
       POLLING_ACTIVE:
       begin
           if(!start_send_ts1)begin
               symbol_pattern.clear_obj();
               symbol_pattern.ts1_gen_en= 1;
               start_send_ts1= 1;
           end
       end
       POLLING_CONFIGURATION:
       begin
           if(!start_send_ts2)begin
               symbol_pattern.clear_obj();
               symbol_pattern.ts2_gen_en= 1;
               start_send_ts2= 1;
           end
       end
       POLLING_IDLE:
       begin
           if(!start_send_idle_packet)begin
               symbol_pattern.clear_obj();
               symbol_pattern.idle_packet_gen_en= 1;
               start_send_idle_packet= 1;
           end
       end
       //IDLE:
       //begin
       //end
	endcase
endtask : polling_substate_op/*}}}*/


//-------------------------------------------------------------
task cdn_u4_usb32_ltssm_operation::disabled_operation();
/*{{{*/
foreach(m_vif[i]) begin
    m_vif[i].usb32_debug_intf.detect_over_limit =0 ;
end
    #10us; //simulate the power on timing
foreach(m_vif[i]) begin
    m_vif[i].usb32_debug_intf.PowerOn_Reset = 1;
end
endtask : disabled_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb32_ltssm_operation::rxdetect_operation();
/*{{{*/
        m_vif[0].pipe_intf.RXTermination = 1; //termination is present
    fork
        detect_over_limit_monitor();
        receiver_termination();
    join
endtask : rxdetect_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb32_ltssm_operation::configure_pipe();
/*{{{*/
    //wait reset//
foreach(m_vif[i]) begin
    m_vif[i].pipe_intf.PHYmode = USB;
    m_vif[i].pipe_intf.Width = 2;
    if(m_cfg.usb32_gen_speed==GEN1_SPEED) begin
        m_vif[i].usb32_debug_intf.usb32_speed_state_ascii = $sformatf("USB32 GEN1");
        m_vif[i].pipe_intf.PCLKRate = 0; //125Mhz
        m_vif[i].pipe_intf.Rate = 0;
    end else begin
        m_vif[i].usb32_debug_intf.usb32_speed_state_ascii = $sformatf("USB32 GEN2");
        m_vif[i].pipe_intf.PCLKRate = 2; //312.5Mhz
        m_vif[i].pipe_intf.Rate = 1;
    end
    m_vif[i].pipe_intf.PowerDown = P1_STATE;
    
    m_vif[i].pipe_intf.PowerDown = P1_STATE;
    
    m_vif[i].usb32_debug_intf.initial_done = 1;
end
endtask : configure_pipe/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb32_ltssm_operation::inactive_operation();
/*{{{*/
    //wait reset//
    configure_pipe(); //will move it to reset phase
endtask : disabled_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb32_ltssm_operation::recovery_operation();
/*{{{*/	
    polling_substate_op();
endtask : recovery_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb32_ltssm_operation::hot_reset_operation();
/*{{{*/
endtask : hot_reset_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb32_ltssm_operation::loopback_operation();
/*{{{*/    
    if(!start_send_ts1)begin
       symbol_pattern.clear_obj();
       symbol_pattern.loopback_test_pattern_en= 1;
       start_send_ts1= 1;
    end
endtask : loopback_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb32_ltssm_operation::loopback_brst_operation();
/*{{{*/    
    if(!start_send_ts1)begin
       symbol_pattern.clear_obj();
       symbol_pattern.loopback_brst= 1;
       start_send_ts1= 1;
    end
endtask : loopback_brst_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb32_ltssm_operation::compliance_operation();
/*{{{*/
endtask : compliance_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb32_ltssm_operation::u1_operation();
/*{{{*/
    if(!start_send_ei)begin
        symbol_pattern.clear_obj();
        symbol_pattern.electric_idle_en= 1;
        start_send_ei= 1;
    end
endtask : u1_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb32_ltssm_operation::u2_operation();
/*{{{*/    
    if(!start_send_ei)begin
        symbol_pattern.clear_obj();
        symbol_pattern.electric_idle_en= 1;
        start_send_ei= 1;
    end
endtask : u2_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb32_ltssm_operation::u3_operation();
/*{{{*/    
    if(!start_send_ei)begin
        symbol_pattern.clear_obj();
        symbol_pattern.electric_idle_en= 1;
        start_send_ei= 1;
    end
endtask : u3_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb32_ltssm_operation::loopback_exit_operation();
/*{{{*/ 
    if(!start_send_lfps_wake)begin
        symbol_pattern.clear_obj();
        symbol_pattern.loopback_exit_gen_en= 1;
        start_send_lfps_wake= 1;
    end
endtask : ux_exit_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb32_ltssm_operation::u1_exit_operation();
/*{{{*/ 
    if(!start_send_lfps_wake)begin
        symbol_pattern.clear_obj();
        symbol_pattern.u1_exit_gen_en= 1;
        start_send_lfps_wake= 1;
    end
endtask : ux_exit_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb32_ltssm_operation::u2_exit_operation();
/*{{{*/ 
    if(!start_send_lfps_wake)begin
        symbol_pattern.clear_obj();
        symbol_pattern.u2_exit_gen_en= 1;
        start_send_lfps_wake= 1;
    end
endtask : ux_exit_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb32_ltssm_operation::u3_exit_operation();
/*{{{*/ 
    if(!start_send_lfps_wake)begin
        symbol_pattern.clear_obj();
        symbol_pattern.u3_exit_gen_en= 1;
        start_send_lfps_wake= 1;
    end
endtask : ux_exit_operation/*}}}*/

//-------------------------------------------------------------
task cdn_u4_usb32_ltssm_operation::u0_operation();
/*{{{*/               
    symbol_pattern.clear_obj();
    symbol_pattern.random_packet_gen_en= 1;
endtask : u0_operation/*}}}*/

//------------------------------------------------------------------
// Function to reset all local variables
function void cdn_u4_usb32_ltssm_operation::reset_local_variables();
/*{{{*/
	if((port_status.usb32_ltssm_state != port_status.nxt_usb32_ltssm_state))begin
	`uvm_info(get_name(), $psprintf("Reset local variables to control results output"), UVM_LOW);
     start_send_lfps                =0;
     start_send_scd1                =0;
     start_send_scd2                =0;
     start_send_lbpm_config         =0;
     start_send_lbpm_ready          =0;
     start_send_tseq                =0;
     start_send_ts1                 =0;
     start_send_ts2                 =0;
     start_send_idle_packet         =0;
     start_send_ei                  =0;
     start_send_lfps_wake           =0;
    end

endfunction : reset_local_variables/*}}}*/


task cdn_u4_usb32_ltssm_operation::detect_over_limit_monitor();
    if(m_vif[0].usb32_debug_intf.Far_end_Rx_Detected == 0)begin
         fork
            begin
                #30us;
                ->m_vif[0].usb32_debug_intf.rx_detected_event;
            end
            begin
                @m_vif[0].usb32_debug_intf.rx_detected_event;
                if(m_vif[0].usb32_debug_intf.Far_end_Rx_Detected == 1) begin
                    detect_over_limit_count = 0;
                    m_vif[0].usb32_debug_intf.detect_over_limit = 0;
                end else begin
                   detect_over_limit_count++;
                end
                if(detect_over_limit_count==3) begin
                    detect_over_limit_count = 0;
                    m_vif[0].usb32_debug_intf.detect_over_limit =1 ;
                end
            end
         join

    end 
endtask

task cdn_u4_usb32_ltssm_operation::receiver_termination();
    m_vif[0].pipe_intf.TxDetectRx = 1; //do rx detect
    //wait(m_vif[0].pipe_intf.PhyStatus == 1 && m_vif[0].pipe_intf.RxStatus== 3'b011);
    //m_vif[0].Far_end_Rx_Detected = 1;
    @(posedge m_vif[0].pclk);
    m_vif[0].pipe_intf.TxDetectRx = 0; //do rx detect
endtask

