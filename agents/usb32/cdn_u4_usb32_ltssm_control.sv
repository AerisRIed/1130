
class cdn_u4_usb32_ltssm_control extends uvm_component;

  //------------------------------------------
  // Data Members 
  //------------------------------------------	
  cdn_u4_usb32_ltssm_instruction ltssm_instruction_local;
  cdn_u4_usb32_symbol_pattern    symbol_pattern;

  //------------------------------------------
  // Model will receive data in on this port 
  //------------------------------------------
  uvm_seq_item_pull_port #(cdn_u4_usb32_ltssm_instruction,cdn_u4_usb32_ltssm_instruction) ltssm_instruction_port;

  //-------------------------------------------
  // Model will transmit data out on this port
  //-------------------------------------------
  cdn_u4_usb32_ltssm_instruction          ltssm_instruction;
  cdn_u4_usb32_config                     m_cfg;
  cdn_phy_vif_t                           m_vif[tb_param::USB32_LANE_NUM];
  cdn_u4_usb32_port_status                port_status;
  
  // 
  lane_ltssm_state_type_enum              cur_ltssm_st;
  lane_ltssm_state_type_enum              nxt_ltssm_st;
  lane_ltssm_substate_type_enum           cur_ltssm_subst;
  lane_ltssm_substate_type_enum           nxt_ltssm_subst;
	

	//-----------------
	//seq item
	bit         u1_entry_req;
	bit         u2_entry_req;
	bit         u3_entry_req;
	bit         u1_exit_req;
	bit         u2_exit_req;
	bit         u3_exit_req;
	bit         warm_reset_req;
	bit         recovery_req;
	bit         pipe_reset_req;
	lane_ltssm_state_type_enum   next_direct_ltssm_state;
    int detect_over_limit_count;
    int ts2_os_received_full_lane0;
    int ts2_os_received_full_lane1;
    int idle_packet_received_full_lane0;
    int idle_packet_received_full_lane1;
    int ts2_os_sent_full_lane0;
    int ts2_os_sent_full_lane1;
  //------------------------------------------
  // Methods 
  //------------------------------------------
  
  // Standard UVM Methods 
  extern function      new   (string name= "cdn_u4_usb32_ltssm_control", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task          run_phase  (uvm_phase phase);
  
  // APIs 
  extern task          get_ltssm_instruction();
  extern task          process_item(cdn_u4_usb32_ltssm_instruction ltssm_instruction);
  extern task          reset_item();

  extern task          lane_ltssm_state_machine();
  extern task          polling_substate_machine();
  extern task          reset_substate_to_idle();
  extern function void update_states_on_interface();

  extern task          reset_value();
  extern task          detect_over_limit_monitor();

  // UVM Macros 
  `uvm_component_utils(cdn_u4_usb32_ltssm_control)

endclass : cdn_u4_usb32_ltssm_control

function cdn_u4_usb32_ltssm_control::new(string name = "cdn_u4_usb32_ltssm_control", uvm_component parent);
	// Super constructor/*{{{*/
	super.new(name, parent);
endfunction : new /*}}}*/

function void cdn_u4_usb32_ltssm_control::build_phase(uvm_phase phase);
  // Super builder/*{{{*/
  // -------------
  super.build_phase(phase);
  ltssm_instruction_port    = new("ltssm_instruction_port", this);
  ltssm_instruction_local = new("ltssm_instruction_local");
  //port_status= new("port_status");

  // Get configuration
  // -----------------

  // Get Interface from container
  // -----------------
    reset_value();
endfunction : build_phase/*}}}*/


function void cdn_u4_usb32_ltssm_control::connect_phase(uvm_phase phase);
/*{{{*/
	//link_service_export_ep.connect(link_service_fifo.analysis_export);

endfunction : connect_phase/*}}}*/

task cdn_u4_usb32_ltssm_control::run_phase(uvm_phase phase);
/*{{{*/
	fork
		lane_ltssm_state_machine();
		get_ltssm_instruction();
	join
endtask : run_phase/*}}}*/

task cdn_u4_usb32_ltssm_control::get_ltssm_instruction();
	forever begin /*{{{*/
		ltssm_instruction_port.get_next_item(ltssm_instruction);
        ltssm_instruction.sprint();
		process_item(ltssm_instruction);
		ltssm_instruction_port.item_done();
	end
endtask : get_ltssm_instruction/*}}}*/

//----------------------------------------------------------
// Task to process link service seq item, update the item to local variable
task cdn_u4_usb32_ltssm_control::process_item(cdn_u4_usb32_ltssm_instruction ltssm_instruction);
/*{{{*/
	ltssm_instruction_local.copy(ltssm_instruction); 

endtask : process_item/*}}}*/

task cdn_u4_usb32_ltssm_control::reset_item();
/*{{{*/
	ltssm_instruction_local.reset_value(); 

endtask : reset_item/*}}}*/
//----------------------------------------------------------
// link server sequence.
task cdn_u4_usb32_ltssm_control::lane_ltssm_state_machine();
/*{{{*/
	forever begin

		@(posedge m_vif[0].pclk);
		
		if(cur_ltssm_st != nxt_ltssm_st)begin
            cur_ltssm_subst = USB32_LINK::IDLE;
			if(nxt_ltssm_st == U1 || nxt_ltssm_st == U2 || nxt_ltssm_st == U3)begin
			end else begin
			end
			`uvm_info($psprintf("%s",nxt_ltssm_st.name()), $psprintf(" Lane ltssm state is %s", nxt_ltssm_st.name()), UVM_LOW);
		reset_item();
        end
		update_states_on_interface();
        port_status.update_ltssm_state(cur_ltssm_st, nxt_ltssm_st);
		cur_ltssm_st = nxt_ltssm_st;

	    if(m_vif[0].usb32_debug_intf.Far_end_Rx_Absent)begin //TODO from rtl need to add later
		    nxt_ltssm_st = RX_DETECT;
        end //TODO need to consider #Preset 
		
        if(ltssm_instruction_local.overwrite_req) begin
 		    nxt_ltssm_st = OVERWRITE;
       
        end else begin
        
            case(cur_ltssm_st)
		    	SS_INACTIVE:
		    	begin
		    		reset_substate_to_idle();

		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		end else if(m_vif[0].usb32_debug_intf.Far_end_Rx_Absent)begin //TODO From rtl like FLAG or interface
		    			nxt_ltssm_st = RX_DETECT;
		    		end else if(ltssm_instruction_local.warm_reset_req)begin 
		    			nxt_ltssm_st = RX_DETECT;
		    		end  
		    	end
		    	
		    	RX_DETECT:
                begin
		    		reset_substate_to_idle();
		    		//detect_over_limit_monitor();//TODO give this to operation
                    
		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		end else if(m_vif[0].usb32_debug_intf.detect_over_limit)begin //TODO From rtl need to add one check point 
		    			nxt_ltssm_st = SS_DISABLE;
                    end else if(m_vif[0].usb32_debug_intf.Far_end_Rx_Detected & !m_vif[0].usb32_debug_intf.Far_end_Rx_Absent)begin //termenation detected
		    			nxt_ltssm_st = POLLING;
		    		end  
		    	end

		    	SS_DISABLE:
                begin
		    		reset_substate_to_idle();

		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
                    end else if(m_vif[0].usb32_debug_intf.PowerOn_Reset)begin//TODO
                        nxt_ltssm_st = RX_DETECT;
		    		end  
		    	end

		    	POLLING,RECOVERY:
		    	begin
		    		polling_substate_machine();

		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		end else if(ltssm_instruction_local.warm_reset_req || (m_vif[0].usb32_debug_intf.tPollingLFPSTimeout_flag || m_vif[0].usb32_debug_intf.tPollingLBPMLFPSTimeout_flag)&& m_vif[0].usb32_debug_intf.cPollingTimeout_flag !==2)begin
		    			nxt_ltssm_st = RX_DETECT;
		    		end else if((m_vif[0].usb32_debug_intf.tPollingLFPSTimeout_flag || m_vif[0].usb32_debug_intf.tPollingLBPMLFPSTimeout_flag)&& m_vif[0].usb32_debug_intf.cPollingTimeout_flag ==2)begin
		    			nxt_ltssm_st =SS_INACTIVE;
		    		end else if(m_vif[0].usb32_debug_intf.first_tPollingLFPSTimeout_flag)begin//TODO
		    			nxt_ltssm_st = COMPLIANCE;
		            end else if(nxt_ltssm_subst == USB32_LINK::IDLE && m_cfg.loopback_enable)begin//TODO
		    			nxt_ltssm_st = LOOPBACK_M;
		            end else if((nxt_ltssm_subst == USB32_LINK::IDLE)&&(m_vif[0].usb32_debug_intf.loopback_detected))begin//TODO
		    			nxt_ltssm_st = LOOPBACK_S;
		    		end else if(m_vif[0].usb32_debug_intf.Idle_packet_received_count >=8 && m_vif[0].usb32_debug_intf.Idle_packet_sent_count_after_received_one>= 16 && m_vif[m_cfg.lane_num-1].usb32_debug_intf.Idle_packet_received_count >=8 && m_vif[m_cfg.lane_num-1].usb32_debug_intf.Idle_packet_sent_count_after_received_one>= 16)begin//TODO
		    			nxt_ltssm_st = U0;
		    		end
		    	end
                LOOPBACK_M,LOOPBACK_S:
                begin
		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		end else if(ltssm_instruction_local.loopback_brst_req)begin
		    			nxt_ltssm_st = LOOPBACK_RST;
                        m_vif[0].usb32_debug_intf.loopback_exit_detected =0;
		    		end else if(ltssm_instruction_local.loopback_exit_req||m_vif[0].usb32_debug_intf.loopback_exit_detected)begin
		    			nxt_ltssm_st = LOOPBACK_EXIT;
                        m_vif[0].usb32_debug_intf.loopback_exit_detected =0;
                    end
                end
                LOOPBACK_RST:
                begin
		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
                    end else begin
		    			nxt_ltssm_st = LOOPBACK_M;
                    end
                end
                LOOPBACK_EXIT:
                begin
		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		end else if(m_vif[0].usb32_debug_intf.low_power_exit_detected)begin
		    			nxt_ltssm_st = RX_DETECT;
                    end
                end
		    	U0:
		    	begin
		    		reset_substate_to_idle();
		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		end else if(ltssm_instruction_local.warm_reset_req )begin
		    			nxt_ltssm_st = RX_DETECT;
		    		end else if(ltssm_instruction_local.u1_entry_req || m_vif[0].usb32_debug_intf.U1_entry_detected)begin //TODO From Status
		    			nxt_ltssm_st = U1;
		    		end else if(ltssm_instruction_local.u2_entry_req || m_vif[0].usb32_debug_intf.U2_entry_detected)begin
		    			nxt_ltssm_st = U2;
		    		end else if(ltssm_instruction_local.u3_entry_req || m_vif[0].usb32_debug_intf.U3_entry_detected)begin
		    			nxt_ltssm_st = U3;
		    		end else if(ltssm_instruction_local.recovery_req)begin
		    			nxt_ltssm_st = RECOVERY;
		    		end
                end

		    	U1:
		    	begin
		    		reset_substate_to_idle();

		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    	    end else if(ltssm_instruction_local.low_power_exit_req || m_vif[0].usb32_debug_intf.low_power_exit_detected|| m_vif[0].usb32_debug_intf.u1_exit_detected)begin//TODO
		    			nxt_ltssm_st = U1_EXIT;
                        m_vif[0].usb32_debug_intf.u1_exit_detected = 0;
		    		end else if(ltssm_instruction_local.warm_reset_req )begin
		    			nxt_ltssm_st = RX_DETECT;
		    		end else if(m_vif[0].usb32_debug_intf.low_power_exit_handshake_timeout_flag )begin //TODO
		    			nxt_ltssm_st = SS_INACTIVE;
                    end
		    	end
		    	U2:
		    	begin
		    		reset_substate_to_idle();

		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    	    end else if(ltssm_instruction_local.low_power_exit_req || m_vif[0].usb32_debug_intf.low_power_exit_detected|| m_vif[0].usb32_debug_intf.u2_exit_detected)begin//TODO
		    			nxt_ltssm_st = U2_EXIT;
                        m_vif[0].usb32_debug_intf.u2_exit_detected = 0;
		    		end else if(ltssm_instruction_local.warm_reset_req )begin
		    			nxt_ltssm_st = RX_DETECT;
		    		end else if(m_vif[0].usb32_debug_intf.low_power_exit_handshake_timeout_flag )begin //TODO
		    			nxt_ltssm_st = SS_INACTIVE;
                    end
		    	end
		    	U3:
		    	begin
		    		reset_substate_to_idle();

		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    	    end else if(ltssm_instruction_local.low_power_exit_req || m_vif[0].usb32_debug_intf.low_power_exit_detected|| m_vif[0].usb32_debug_intf.u3_exit_detected)begin//TODO
		    			nxt_ltssm_st = U3_EXIT;
                        m_vif[0].usb32_debug_intf.u3_exit_detected = 0;
		    		end else if(ltssm_instruction_local.warm_reset_req )begin
		    			nxt_ltssm_st = RX_DETECT;
		    		end else if(m_vif[0].usb32_debug_intf.low_power_exit_handshake_timeout_flag )begin //TODO
		    			nxt_ltssm_st = SS_INACTIVE;
                    end
		    	end
                U1_EXIT,U2_EXIT,U3_EXIT:
                begin
		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    	    end else if( m_vif[0].usb32_debug_intf.low_power_exit_detected )begin//TODO
		    			nxt_ltssm_st = RECOVERY;
                    end
		    	end
		    endcase 

		    if(ltssm_instruction_local.direct_state_transition)begin
		    	ltssm_instruction_local.direct_state_transition = 0;
		    end
        end

		//update_states_on_interface();
	    //port_status.update_ltssm_state(cur_ltssm_st, nxt_ltssm_st);

end
endtask : lane_ltssm_state_machine/*}}}*/

//--------------------------------------------------------
// Task to control POLLING substate machine. This task is only called at POLLING state.
// In POLLING state. substate is only can be POLLING substate
task cdn_u4_usb32_ltssm_control::polling_substate_machine();
/*{{{*/
    if(cur_ltssm_subst!= nxt_ltssm_subst)begin
    	`uvm_info($psprintf("%s",nxt_ltssm_st.name()), $psprintf(" Lane ltssm substate is %s", nxt_ltssm_subst.name()), UVM_LOW);
    end
	cur_ltssm_subst = nxt_ltssm_subst;
	port_status.update_ltssm_substate(cur_ltssm_subst,nxt_ltssm_subst);

	//set the default initial substate
	if(cur_ltssm_subst == USB32_LINK::IDLE)begin
        if(cur_ltssm_st == POLLING) begin
		    cur_ltssm_subst = POLLING_LFPS;
		    nxt_ltssm_subst = POLLING_LFPS;
        end else begin
		    cur_ltssm_subst = POLLING_ACTIVE;
		    nxt_ltssm_subst = POLLING_ACTIVE;
        end
	end

	case(cur_ltssm_subst)

		POLLING_LFPS:
		begin
			if(ltssm_instruction_local.direct_substate_transition)begin
					nxt_ltssm_subst= ltssm_instruction_local.next_ltssm_substate;
            //end else if(m_cfg.usb32_gen_speed==GEN1_SPEED && m_vif.usb32_debug_intf.lfps_sent_count >=16 && m_vif.usb32_debug_intf.lfps_received_count >=2 && m_vif.usb32_debug_intf.lfps_sent_count_after_recieved_one >=4)begin //SS handshake
            end else if(m_cfg.usb32_gen_speed==GEN1_SPEED && m_vif[0].usb32_debug_intf.lfps_sent_count >=16)begin //SS handshake
				nxt_ltssm_subst = POLLING_RXEQ;
            end else if(m_cfg.usb32_gen_speed==GEN2_SPEED && m_vif[0].usb32_debug_intf.lfps_sent_count >=16)begin //TODO
				nxt_ltssm_subst = POLLING_RXEQ;
			end else if(m_cfg.usb32_gen_speed==GEN2_SPEED&& m_vif[0].usb32_debug_intf.scd1_received_count ==0 
                && m_vif[0].usb32_debug_intf.scd2_received_count ==0 && m_vif[0].usb32_debug_intf.scd1_sent_count >=4 && (m_vif[0].usb32_debug_intf.scd1_sent_count_after_lfps_recieved_two >=1 || m_vif[0].usb32_debug_intf.lfps_sent_count_after_recieved_one >=4) && (m_vif[0].usb32_debug_intf.tPollingSCDLFPSTimeout_flag|| m_vif[0].usb32_debug_intf.lfps_sent_count >=16))begin //SSP hand shake with SS
				nxt_ltssm_subst = POLLING_RXEQ;
			end else if(m_cfg.usb32_gen_speed==GEN2_SPEED&& (m_vif[0].usb32_debug_intf.scd1_sent_count_after_scd1_received_one >=2 || m_vif[0].usb32_debug_intf.scd1_sent_count_after_scd2_received_one >=2))begin //SSP handshake
				nxt_ltssm_subst = POLLING_LFPSPLUS;
			end
		end	
		
        POLLING_LFPSPLUS:
		begin
			if(ltssm_instruction_local.direct_substate_transition)begin
					nxt_ltssm_subst= ltssm_instruction_local.next_ltssm_substate;
            end else if(m_vif[0].usb32_debug_intf.scd2_sent_count_after_scd2_received_one >= 2)begin //SSP
				nxt_ltssm_subst = POLLING_PORTMATCH;
            end else if(m_vif[0].usb32_debug_intf.tPollingSCDLFPSTimeout_flag || (m_vif[0].usb32_debug_intf.lfps_sent_count>=20 && m_vif[0].usb32_debug_intf.scd2_received_count==0) )begin //SSP to SS 
				nxt_ltssm_subst = POLLING_RXEQ;
            end
		end	
		
        POLLING_PORTMATCH:
		begin
			if(ltssm_instruction_local.direct_substate_transition)begin
					nxt_ltssm_subst= ltssm_instruction_local.next_ltssm_substate;
            end else if(m_vif[0].usb32_debug_intf.lbpm_config_sent_count_after_received_two>= 4)begin
				nxt_ltssm_subst = POLLING_PORTCONFIG;
            end else if(m_vif[0].usb32_debug_intf.tPollingLBPMLFPSTimeout_flag)begin 
				nxt_ltssm_subst = USB32_LINK::IDLE;
            end
        end
		
        POLLING_PORTCONFIG:
		begin
			if(ltssm_instruction_local.direct_substate_transition)begin
					nxt_ltssm_subst= ltssm_instruction_local.next_ltssm_substate;
            end else if(m_vif[0].usb32_debug_intf.lbpm_ready_sent_count_after_received_two>= 4)begin
				nxt_ltssm_subst = POLLING_RXEQ;
            end else if(m_vif[0].usb32_debug_intf.tPollingLBPMLFPSTimeout_flag)begin 
				nxt_ltssm_subst = USB32_LINK::IDLE;
			end
        end
		
        POLLING_RXEQ:
        begin	
            if(ltssm_instruction_local.direct_substate_transition)begin //TODO need to set as config to speed up
					nxt_ltssm_subst= ltssm_instruction_local.next_ltssm_substate;
            end else if((m_cfg.usb32_gen_speed==GEN1_SPEED&& m_vif[0].usb32_debug_intf.tseq_os_sent_count==TSEQ_NUM_GEN1&& m_vif[m_cfg.lane_num-1].usb32_debug_intf.tseq_os_sent_count==TSEQ_NUM_GEN1)||(m_cfg.usb32_gen_speed==GEN2_SPEED && m_vif[0].usb32_debug_intf.tseq_os_sent_count==TSEQ_NUM_GEN2&& m_vif[m_cfg.lane_num -1].usb32_debug_intf.tseq_os_sent_count==TSEQ_NUM_GEN2))begin
				nxt_ltssm_subst = POLLING_ACTIVE;
			end
        end
		
        POLLING_ACTIVE:
		begin
			if(ltssm_instruction_local.direct_substate_transition)begin
					nxt_ltssm_subst= ltssm_instruction_local.next_ltssm_substate;
            end else if(m_vif[0].usb32_debug_intf.tPollingActiveTimeout_flag)begin
				nxt_ltssm_subst = USB32_LINK::IDLE;
			end else if((m_vif[0].usb32_debug_intf.ts1_os_received_count >=8||m_vif[0].usb32_debug_intf.ts2_os_received_count >=8) && (m_vif[m_cfg.lane_num-1].usb32_debug_intf.ts1_os_received_count >=8||m_vif[m_cfg.lane_num-1].usb32_debug_intf.ts2_os_received_count >=8))begin
				nxt_ltssm_subst = POLLING_CONFIGURATION;
			end
        end
		
        POLLING_CONFIGURATION:
		begin
            if(m_vif[0].usb32_debug_intf.ts2_os_received_count >= 8) begin
                ts2_os_received_full_lane0 = 1; 
            end
            if(m_vif[m_cfg.lane_num-1].usb32_debug_intf.ts2_os_received_count >= 8) begin
                ts2_os_received_full_lane1 = 1; 
            end
            if(m_vif[0].usb32_debug_intf.ts2_os_sent_count>=16 )begin
                ts2_os_sent_full_lane0=1;
            end
            if(m_vif[m_cfg.lane_num-1].usb32_debug_intf.ts2_os_sent_count>=16 )begin
                ts2_os_sent_full_lane1=1;
            end
            if(ltssm_instruction_local.direct_substate_transition)begin
				nxt_ltssm_subst= ltssm_instruction_local.next_ltssm_substate;
            end else if(m_vif[0].usb32_debug_intf.tPollingActiveTimeout_flag)begin
				nxt_ltssm_subst = USB32_LINK::IDLE;
            end else if( ts2_os_sent_full_lane0&& ts2_os_sent_full_lane1&&ts2_os_received_full_lane0&&ts2_os_received_full_lane1)begin
				nxt_ltssm_subst = POLLING_IDLE;
                ts2_os_sent_full_lane0=0;
                ts2_os_sent_full_lane1=0;
                ts2_os_received_full_lane0 = 0;
                ts2_os_received_full_lane1 = 0;
			end
        end
		
        POLLING_IDLE:
        begin
            if(m_vif[0].usb32_debug_intf.Idle_packet_received_count >= 1 ) begin
                idle_packet_received_full_lane0 = 1;
            end
            if(m_vif[m_cfg.lane_num-1].usb32_debug_intf.Idle_packet_received_count >= 1) begin
                idle_packet_received_full_lane1 = 1;
            end
			if(ltssm_instruction_local.direct_substate_transition)begin
				nxt_ltssm_subst= ltssm_instruction_local.next_ltssm_substate;
            end else if(m_vif[0].usb32_debug_intf.loopback_detected || m_cfg.loopback_enable )begin//TODO
				nxt_ltssm_subst = USB32_LINK::IDLE;
            end else if(idle_packet_received_full_lane0 &&idle_packet_received_full_lane1 && m_vif[0].usb32_debug_intf.Idle_packet_sent_count  >= 4&& m_vif[m_cfg.lane_num-1].usb32_debug_intf.Idle_packet_sent_count  >= 4)begin // two lane
			    nxt_ltssm_subst = USB32_LINK::IDLE;
		        nxt_ltssm_st = U0;
                idle_packet_received_full_lane0= 0;
                idle_packet_received_full_lane1= 0;
			end
        end
	
		
		default: //TODO need to add error state
		begin
			nxt_ltssm_subst = USB32_LINK::IDLE;
		end
	endcase

endtask : polling_substate_machine/*}}}*/


//---------------------------------------------------------
task cdn_u4_usb32_ltssm_control::reset_substate_to_idle();
	cur_ltssm_subst = USB32_LINK::IDLE;/*{{{*/
	nxt_ltssm_subst = USB32_LINK::IDLE;
endtask : reset_substate_to_idle/*}}}*/

//----------------------------------------------------------
// Task to reset value when enter SS_INACTIVE state
task cdn_u4_usb32_ltssm_control::reset_value();
/*{{{*/
	cur_ltssm_st            = SS_INACTIVE;
	nxt_ltssm_st            = SS_INACTIVE;
	cur_ltssm_subst         = eSS_Inactive_Quiet;
	nxt_ltssm_subst         = eSS_Inactive_Quiet;


endtask : reset_value/*}}}*/

//----------------------------------------------------------
// function to update states on debug interface
function void cdn_u4_usb32_ltssm_control::update_states_on_interface();
foreach(m_vif[i])begin //TODO need add default
    case(cur_ltssm_st)/*{{{*/
		SS_INACTIVE:      m_vif[i].usb32_debug_intf.ltssm_state_ascii = $sformatf("SS_INACTIVE"); //TODO
        RX_DETECT:        m_vif[i].usb32_debug_intf.ltssm_state_ascii = $sformatf("RX_DETECT"); //TODO
        SS_DISABLE:       m_vif[i].usb32_debug_intf.ltssm_state_ascii = $sformatf("SS_DISABLE"); //TODO
        POLLING:          m_vif[i].usb32_debug_intf.ltssm_state_ascii = $sformatf("POLLING"); //TODO
        U0:               m_vif[i].usb32_debug_intf.ltssm_state_ascii = $sformatf("U0");
        U1:               m_vif[i].usb32_debug_intf.ltssm_state_ascii = $sformatf("U1");
        U2:               m_vif[i].usb32_debug_intf.ltssm_state_ascii = $sformatf("U2");
        U3:               m_vif[i].usb32_debug_intf.ltssm_state_ascii = $sformatf("U3");
        U1_EXIT:          m_vif[i].usb32_debug_intf.ltssm_state_ascii = $sformatf("U1_EXIT");
        U2_EXIT:          m_vif[i].usb32_debug_intf.ltssm_state_ascii = $sformatf("U2_EXIT");
        U3_EXIT:          m_vif[i].usb32_debug_intf.ltssm_state_ascii = $sformatf("U3_EXIT");
        LOOPBACK_M:       m_vif[i].usb32_debug_intf.ltssm_state_ascii = $sformatf("LOOPBACK_M");
        LOOPBACK_S:       m_vif[i].usb32_debug_intf.ltssm_state_ascii = $sformatf("LOOPBACK_S");
        LOOPBACK_EXIT:    m_vif[i].usb32_debug_intf.ltssm_state_ascii = $sformatf("LOOPBACK_EXIT");
        HOT_RESET:        m_vif[i].usb32_debug_intf.ltssm_state_ascii = $sformatf("HOT_RESET");
        RECOVERY:         m_vif[i].usb32_debug_intf.ltssm_state_ascii = $sformatf("RECOVERY");
        COMPLIANCE:       m_vif[i].usb32_debug_intf.ltssm_state_ascii = $sformatf("COMPLIANCE");
        OVERWRITE:        m_vif[i].usb32_debug_intf.ltssm_state_ascii = $sformatf("OVERWRITE");
        LOOPBACK_RST:     m_vif[i].usb32_debug_intf.ltssm_state_ascii = $sformatf("LOOPBACK_RST");
	endcase 

	case(nxt_ltssm_st)
		SS_INACTIVE:      m_vif[i].usb32_debug_intf.next_ltssm_state_ascii = $sformatf("SS_INACTIVE");//TODO
        RX_DETECT:        m_vif[i].usb32_debug_intf.next_ltssm_state_ascii = $sformatf("RX_DETECT"); //TODO
        SS_DISABLE:       m_vif[i].usb32_debug_intf.next_ltssm_state_ascii = $sformatf("SS_DISABLE"); //TODO
        POLLING:          m_vif[i].usb32_debug_intf.next_ltssm_state_ascii = $sformatf("POLLING"); //TODO
        U0:               m_vif[i].usb32_debug_intf.next_ltssm_state_ascii = $sformatf("U0");
        U1:               m_vif[i].usb32_debug_intf.next_ltssm_state_ascii = $sformatf("U1");
        U2:               m_vif[i].usb32_debug_intf.next_ltssm_state_ascii = $sformatf("U2");
        U3:               m_vif[i].usb32_debug_intf.next_ltssm_state_ascii = $sformatf("U3");
        U1_EXIT:          m_vif[i].usb32_debug_intf.next_ltssm_state_ascii = $sformatf("U1_EXIT");
        U2_EXIT:          m_vif[i].usb32_debug_intf.next_ltssm_state_ascii = $sformatf("U2_EXIT");
        U3_EXIT:          m_vif[i].usb32_debug_intf.next_ltssm_state_ascii = $sformatf("U3_EXIT");
        LOOPBACK_M:       m_vif[i].usb32_debug_intf.next_ltssm_state_ascii = $sformatf("LOOPBACK_M");
        LOOPBACK_S:       m_vif[i].usb32_debug_intf.next_ltssm_state_ascii = $sformatf("LOOPBACK_S");
        LOOPBACK_EXIT:    m_vif[i].usb32_debug_intf.next_ltssm_state_ascii = $sformatf("LOOPBACK_EXIT");
        HOT_RESET:        m_vif[i].usb32_debug_intf.next_ltssm_state_ascii = $sformatf("HOT_RESET");
        RECOVERY:         m_vif[i].usb32_debug_intf.next_ltssm_state_ascii = $sformatf("RECOVERY");
        COMPLIANCE:       m_vif[i].usb32_debug_intf.next_ltssm_state_ascii = $sformatf("COMPLIANCE");
        OVERWRITE:        m_vif[i].usb32_debug_intf.next_ltssm_state_ascii = $sformatf("OVERWRITE");
        LOOPBACK_RST:     m_vif[i].usb32_debug_intf.next_ltssm_state_ascii = $sformatf("LOOPBACK_RST");
	endcase
	case(cur_ltssm_subst)
        USB32_LINK::IDLE:               m_vif[i].usb32_debug_intf.ltssm_substate_ascii = $sformatf("USB32_LINK::IDLE");
        eSS_Disabled_Default:           m_vif[i].usb32_debug_intf.ltssm_substate_ascii = $sformatf("eSS_Disabled_Default");
        eSS_Disabled_Error:             m_vif[i].usb32_debug_intf.ltssm_substate_ascii = $sformatf("eSS_Disabled_Error"); 
        eSS_Inactive_Quiet:             m_vif[i].usb32_debug_intf.ltssm_substate_ascii = $sformatf("eSS_Inactive_Quiet"); 
        eSS_Disconnect_Detect:          m_vif[i].usb32_debug_intf.ltssm_substate_ascii = $sformatf("eSS_Disconnect_Detect"); 
        RX_DETECT_Reset:                m_vif[i].usb32_debug_intf.ltssm_substate_ascii = $sformatf("RX_DETECT_Reset");
        RX_DETECT_Active:               m_vif[i].usb32_debug_intf.ltssm_substate_ascii = $sformatf("RX_DETECT_Active");
        POLLING_LFPS:                   m_vif[i].usb32_debug_intf.ltssm_substate_ascii = $sformatf("POLLING_LFPS");
        POLLING_LFPSPLUS:               m_vif[i].usb32_debug_intf.ltssm_substate_ascii = $sformatf("POLLING_LFPSPLUS");
        POLLING_PORTMATCH:              m_vif[i].usb32_debug_intf.ltssm_substate_ascii = $sformatf("POLLING_PORTMATCH");
        POLLING_PORTCONFIG:             m_vif[i].usb32_debug_intf.ltssm_substate_ascii = $sformatf("POLLING_PORTCONFIG");
        POLLING_RXEQ:                   m_vif[i].usb32_debug_intf.ltssm_substate_ascii = $sformatf("POLLING_RXEQ");
        POLLING_ACTIVE:                 m_vif[i].usb32_debug_intf.ltssm_substate_ascii = $sformatf("POLLING_ACTIVE");
        POLLING_CONFIGURATION:          m_vif[i].usb32_debug_intf.ltssm_substate_ascii = $sformatf("POLLING_CONFIGURATION");
        POLLING_IDLE:                   m_vif[i].usb32_debug_intf.ltssm_substate_ascii = $sformatf("POLLING_IDLE");

	endcase 

	case(nxt_ltssm_subst)
        USB32_LINK::IDLE:               m_vif[i].usb32_debug_intf.next_ltssm_substate_ascii = $sformatf("USB32_LINK::IDLE");
        eSS_Disabled_Default:           m_vif[i].usb32_debug_intf.next_ltssm_substate_ascii = $sformatf("eSS_Disabled_Default");
        eSS_Disabled_Error:             m_vif[i].usb32_debug_intf.next_ltssm_substate_ascii = $sformatf("eSS_Disabled_Error"); 
        eSS_Inactive_Quiet:             m_vif[i].usb32_debug_intf.next_ltssm_substate_ascii = $sformatf("eSS_Inactive_Quiet"); 
        eSS_Disconnect_Detect:          m_vif[i].usb32_debug_intf.next_ltssm_substate_ascii = $sformatf("eSS_Disconnect_Detect"); 
        RX_DETECT_Reset:                m_vif[i].usb32_debug_intf.next_ltssm_substate_ascii = $sformatf("RX_DETECT_Reset");
        RX_DETECT_Active:               m_vif[i].usb32_debug_intf.next_ltssm_substate_ascii = $sformatf("RX_DETECT_Active");
        POLLING_LFPS:                   m_vif[i].usb32_debug_intf.next_ltssm_substate_ascii = $sformatf("POLLING_LFPS");
        POLLING_LFPSPLUS:               m_vif[i].usb32_debug_intf.next_ltssm_substate_ascii = $sformatf("POLLING_LFPSPLUS");
        POLLING_PORTMATCH:              m_vif[i].usb32_debug_intf.next_ltssm_substate_ascii = $sformatf("POLLING_PORTMATCH");
        POLLING_PORTCONFIG:             m_vif[i].usb32_debug_intf.next_ltssm_substate_ascii = $sformatf("POLLING_PORTCONFIG");
        POLLING_RXEQ:                   m_vif[i].usb32_debug_intf.next_ltssm_substate_ascii = $sformatf("POLLING_RXEQ");
        POLLING_ACTIVE:                 m_vif[i].usb32_debug_intf.next_ltssm_substate_ascii = $sformatf("POLLING_ACTIVE");
        POLLING_CONFIGURATION:          m_vif[i].usb32_debug_intf.next_ltssm_substate_ascii = $sformatf("POLLING_CONFIGURATION");
        POLLING_IDLE:                   m_vif[i].usb32_debug_intf.next_ltssm_substate_ascii = $sformatf("POLLING_IDLE");
    endcase
end

endfunction : update_states_on_interface/*}}}*/

task cdn_u4_usb32_ltssm_control::detect_over_limit_monitor();
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

