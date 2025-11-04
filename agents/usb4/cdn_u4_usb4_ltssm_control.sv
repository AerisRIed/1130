class cdn_u4_usb4_ltssm_control extends uvm_component;

  //------------------------------------------
  // Data Members 
  //------------------------------------------	
  cdn_u4_usb4_ltssm_instruction ltssm_instruction_local;
  cdn_u4_usb4_symbol_pattern    symbol_pattern;

  //------------------------------------------
  // Model will receive data in on this port 
  //------------------------------------------
  uvm_seq_item_pull_port #(cdn_u4_usb4_ltssm_instruction,cdn_u4_usb4_ltssm_instruction) ltssm_instruction_port;

  //-------------------------------------------
  // Model will transmit data out on this port
  //-------------------------------------------
  cdn_u4_usb4_ltssm_instruction          ltssm_instruction;
  cdn_u4_usb4_config                     m_cfg;
  cdn_phy_vif_t                          m_vif[2];//TODO lane num
  cdn_u4_usb4_port_status                port_status;
  
  // 
  lane_ltssm_state_type_enum              cur_ltssm_st;
  lane_ltssm_state_type_enum              nxt_ltssm_st;
  lane_ltssm_substate_type_enum           cur_ltssm_subst;
  lane_ltssm_substate_type_enum           nxt_ltssm_subst;
	
    bit ts1_sent_match;
    bit ts1_received_match;
    bit ts2_sent_match;
    bit ts2_received_match;
	//-----------------
	//seq item
	bit         cl1_entry_req;
	bit         cl2_entry_req;
	bit         cl0s_entry_req;
	bit         cl1_exit_req;
	bit         cl2_exit_req;
	bit         cl0s_exit_req;
	bit         pipe_reset_req;
	lane_ltssm_state_type_enum   next_direct_ltssm_state;
  //------------------------------------------
  // Methods 
  //------------------------------------------
  
  // Standard UVM Methods 
  extern function      new   (string name= "cdn_u4_usb4_ltssm_control", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task          run_phase  (uvm_phase phase);
  
  // APIs 
  extern task          get_ltssm_instruction();
  extern task          process_item(cdn_u4_usb4_ltssm_instruction ltssm_instruction);
  extern task          reset_item();

  extern task          lane_ltssm_state_machine();
  extern task          training_substate_machine();
  extern task          reset_substate_to_idle();
  extern function void update_states_on_interface();

  extern task          reset_value();

  // UVM Macros 
  `uvm_component_utils(cdn_u4_usb4_ltssm_control)

endclass : cdn_u4_usb4_ltssm_control

function cdn_u4_usb4_ltssm_control::new(string name = "cdn_u4_usb4_ltssm_control", uvm_component parent);
	// Super constructor/*{{{*/
	super.new(name, parent);
endfunction : new /*}}}*/

function void cdn_u4_usb4_ltssm_control::build_phase(uvm_phase phase);
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


function void cdn_u4_usb4_ltssm_control::connect_phase(uvm_phase phase);
/*{{{*/
	//link_service_export_ep.connect(link_service_fifo.analysis_export);

endfunction : connect_phase/*}}}*/

task cdn_u4_usb4_ltssm_control::run_phase(uvm_phase phase);
/*{{{*/
	fork
		lane_ltssm_state_machine();
		get_ltssm_instruction();
	join
endtask : run_phase/*}}}*/

task cdn_u4_usb4_ltssm_control::get_ltssm_instruction();
	forever begin /*{{{*/
		ltssm_instruction_port.get_next_item(ltssm_instruction);
        ltssm_instruction.sprint();
		process_item(ltssm_instruction);
		ltssm_instruction_port.item_done();
	end
endtask : get_ltssm_instruction/*}}}*/

//----------------------------------------------------------
// Task to process link service seq item, update the item to local variable
task cdn_u4_usb4_ltssm_control::process_item(cdn_u4_usb4_ltssm_instruction ltssm_instruction);
/*{{{*/
	ltssm_instruction_local.copy(ltssm_instruction); 

endtask : process_item/*}}}*/

task cdn_u4_usb4_ltssm_control::reset_item();
/*{{{*/
	ltssm_instruction_local.reset_value(); 

endtask : reset_item/*}}}*/
//----------------------------------------------------------
// link server sequence.
task cdn_u4_usb4_ltssm_control::lane_ltssm_state_machine();
/*{{{*/
	forever begin

		@(posedge m_vif[0].pclk);
		
		if(cur_ltssm_st != nxt_ltssm_st)begin
            cur_ltssm_subst = USB4_LINK::IDLE;
			if(nxt_ltssm_st == CL1|| nxt_ltssm_st == CL2 || nxt_ltssm_st == CL0S)begin
			end else begin
			end
			`uvm_info($psprintf("%s",nxt_ltssm_st.name()), $psprintf(" Lane ltssm state is %s", nxt_ltssm_st.name()), UVM_LOW);
		reset_item();
        end
		cur_ltssm_st = nxt_ltssm_st;
		//update_states_on_interface();
	    //port_status.update_ltssm_state(cur_ltssm_st, nxt_ltssm_st);

	    if(~m_vif[0].usb4_debug_intf.tx_rx_enable)begin //TODO from rtl need to add later
		    nxt_ltssm_st = CLD;
        end //TODO need to consider #Preset 
		
        if(ltssm_instruction_local.overwrite_req) begin
 		    nxt_ltssm_st = OVERWRITE;
       
        end else begin
        
            case(cur_ltssm_st)
		    	CLD:
		    	begin
		    		reset_substate_to_idle();

		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		end else if(m_vif[0].usb4_debug_intf.tx_rx_enable)begin 
		    			nxt_ltssm_st = TRAINING;
		    		end  
		    	end
		    	

		    	TRAINING:
		    	begin
		    		training_substate_machine();

		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		//end else if(ltssm_instruction_local.disconnect_req )begin
		    		//	nxt_ltssm_st = CLD;
		    		end
		    	end
                
		    	CL0:
		    	begin
		    		reset_substate_to_idle();
		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		//end else if(ltssm_instruction_local.disconnect_req)begin
		    		//	nxt_ltssm_st = CLD;
		    		end else if(ltssm_instruction_local.cl1_entry_req )begin //TODO From Status
		    			nxt_ltssm_st = CL1;
		    		end else if(ltssm_instruction_local.cl2_entry_req )begin
		    			nxt_ltssm_st = CL2;
		    		end else if(ltssm_instruction_local.cl0s_entry_req)begin
		    			nxt_ltssm_st = CL0S;
		    		end
                end

		    	CL1:
		    	begin
		    		reset_substate_to_idle();

		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    	    end else if(ltssm_instruction_local.low_power_exit_req || m_vif[0].usb4_debug_intf.low_power_exit_detected|| m_vif[0].usb4_debug_intf.cl1_exit_detected)begin//TODO
		    			nxt_ltssm_st = CL1_EXIT;
                        m_vif[0].usb4_debug_intf.cl1_exit_detected = 0;
                    end
		    	end
		    	CL2:
		    	begin
		    		reset_substate_to_idle();

		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    	    end else if(ltssm_instruction_local.low_power_exit_req || m_vif[0].usb4_debug_intf.low_power_exit_detected|| m_vif[0].usb4_debug_intf.cl2_exit_detected)begin//TODO
		    			nxt_ltssm_st = CL2_EXIT;
                        m_vif[0].usb4_debug_intf.cl2_exit_detected = 0;
                    end
		    	end
		    	CL0S:
		    	begin
		    		reset_substate_to_idle();

		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    	    end else if(ltssm_instruction_local.low_power_exit_req || m_vif[0].usb4_debug_intf.low_power_exit_detected|| m_vif[0].usb4_debug_intf.cl0s_exit_detected)begin//TODO
		    			nxt_ltssm_st = CL0S_EXIT;
                        m_vif[0].usb4_debug_intf.cl0s_exit_detected = 0;
                    end
		    	end
                CL1_EXIT,CL2_EXIT,CL0S_EXIT:
                begin
		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    	    end else if( m_vif[0].usb4_debug_intf.low_power_exit_detected )begin//TODO
		    			nxt_ltssm_st = TRAINING;
                    end
		    	end
		    endcase 

		    if(ltssm_instruction_local.direct_state_transition)begin
		    	ltssm_instruction_local.direct_state_transition = 0;
		    end
        end

		update_states_on_interface();
	    port_status.update_ltssm_state(cur_ltssm_st, nxt_ltssm_st);

end
endtask : lane_ltssm_state_machine/*}}}*/

//--------------------------------------------------------
// Task to control POLLING substate machine. This task is only called at POLLING state.
// In POLLING state. substate is only can be POLLING substate
task cdn_u4_usb4_ltssm_control::training_substate_machine();
/*{{{*/
    if(cur_ltssm_subst!= nxt_ltssm_subst)begin
    	`uvm_info($psprintf("%s",nxt_ltssm_st.name()), $psprintf(" Lane ltssm substate is %s", nxt_ltssm_subst.name()), UVM_LOW);
    end
	cur_ltssm_subst = nxt_ltssm_subst;
	port_status.update_ltssm_substate(cur_ltssm_subst,nxt_ltssm_subst);

	//set the default initial substate
	if(cur_ltssm_subst == USB4_LINK::IDLE)begin
        if(cur_ltssm_st == TRAINING) begin
		    cur_ltssm_subst = LOCK1;
		    nxt_ltssm_subst = LOCK1;
        end else begin
		    cur_ltssm_subst = USB4_LINK::IDLE;
		    nxt_ltssm_subst = USB4_LINK::IDLE;
        end
	end

	case(cur_ltssm_subst)

		LOCK1:
        begin	
            if(ltssm_instruction_local.direct_substate_transition)begin //TODO need to set as config to speed up
					nxt_ltssm_subst= ltssm_instruction_local.next_ltssm_substate;
            end else if(( m_vif[0].usb4_debug_intf.slos1_sent_count>=2&& m_vif[1].usb4_debug_intf.slos1_sent_count>=2)&&(( m_vif[0].usb4_debug_intf.slos1_received_count>=2&& m_vif[1].usb4_debug_intf.slos1_received_count>=2)||( m_vif[0].usb4_debug_intf.slos2_received_count>=2&& m_vif[1].usb4_debug_intf.slos2_received_count>=2)))begin
				nxt_ltssm_subst = LOCK2;
			end
        end
		
		
        LOCK2:
        begin	
            if(ltssm_instruction_local.direct_substate_transition)begin //TODO need to set as config to speed up
					nxt_ltssm_subst= ltssm_instruction_local.next_ltssm_substate;
            end else if(( m_vif[0].usb4_debug_intf.slos2_sent_count>=2&& m_vif[1].usb4_debug_intf.slos2_sent_count>=2)&&( m_vif[0].usb4_debug_intf.slos2_received_count>=2&& m_vif[1].usb4_debug_intf.slos2_received_count>=2))begin
				nxt_ltssm_subst = TS1;
			end
        end
		
        TS1:
		begin
            if(m_cfg.usb4_gen_speed==GEN2_SPEED&&m_vif[0].usb4_debug_intf.ts1_sent_count>=TS1_SENT_NUM_GEN2&& m_vif[1].usb4_debug_intf.ts1_sent_count>=TS1_SENT_NUM_GEN2)begin
                ts1_sent_match =1 ;
            end
            if(m_cfg.usb4_gen_speed==GEN3_SPEED&&m_vif[0].usb4_debug_intf.ts1_sent_count>=TS1_SENT_NUM_GEN3&& m_vif[1].usb4_debug_intf.ts1_sent_count>=TS1_SENT_NUM_GEN3)begin
                ts1_sent_match =1 ;
            end
            if(m_vif[0].usb4_debug_intf.ts1_received_count>=2&& m_vif[1].usb4_debug_intf.ts1_received_count>=2)begin
                ts1_received_match =1 ;
            end
            if(ltssm_instruction_local.direct_substate_transition)begin
					nxt_ltssm_subst= ltssm_instruction_local.next_ltssm_substate;
            end else if(ts1_sent_match && ts1_received_match)begin
				nxt_ltssm_subst = TS2;
                ts1_sent_match = 0;
                ts1_received_match= 0;
            end
        end
		
        TS2:
		begin
            if(m_cfg.usb4_gen_speed==GEN2_SPEED&&m_vif[0].usb4_debug_intf.ts2_sent_count>=TS2_SENT_NUM_GEN2&& m_vif[1].usb4_debug_intf.ts2_sent_count>=TS2_SENT_NUM_GEN2) begin
                ts2_sent_match =1 ;
            end
            if(m_cfg.usb4_gen_speed==GEN3_SPEED&&m_vif[0].usb4_debug_intf.ts2_sent_count>=TS2_SENT_NUM_GEN3&& m_vif[1].usb4_debug_intf.ts2_sent_count>=TS2_SENT_NUM_GEN3) begin
                ts2_sent_match =1 ;
            end
            if(m_vif[0].usb4_debug_intf.ts2_received_count>=2&& m_vif[1].usb4_debug_intf.ts2_received_count>=2)begin
                ts2_received_match =1 ;
            end
            if(ltssm_instruction_local.direct_substate_transition)begin
				nxt_ltssm_subst= ltssm_instruction_local.next_ltssm_substate;
            end else if(ts2_sent_match && ts2_received_match)begin
		    	nxt_ltssm_st =CL0;
				nxt_ltssm_subst = USB4_LINK::IDLE;
                ts2_sent_match = 0;
                ts2_received_match= 0;
			end
        end
		
		default: //TODO need to add error state
		begin
			nxt_ltssm_subst = USB4_LINK::IDLE;
		end
	endcase

endtask : polling_substate_machine/*}}}*/


//---------------------------------------------------------
task cdn_u4_usb4_ltssm_control::reset_substate_to_idle();
	cur_ltssm_subst = USB4_LINK::IDLE;/*{{{*/
	nxt_ltssm_subst = USB4_LINK::IDLE;
endtask : reset_substate_to_idle/*}}}*/

//----------------------------------------------------------
// Task to reset value when enter SS_INACTIVE state
task cdn_u4_usb4_ltssm_control::reset_value();
/*{{{*/
	cur_ltssm_st            = USB4_LINK::IDLE;
	nxt_ltssm_st            = USB4_LINK::IDLE;
	cur_ltssm_subst         = USB4_LINK::IDLE;
	nxt_ltssm_subst         = USB4_LINK::IDLE;


endtask : reset_value/*}}}*/

//----------------------------------------------------------
// function to update states on debug interface
function void cdn_u4_usb4_ltssm_control::update_states_on_interface();
foreach(m_vif[i])begin //TODO need add default
    case(cur_ltssm_st)/*{{{*/
        CLD:              m_vif[i].usb4_debug_intf.ltssm_state_ascii = $sformatf("CLD"); //TODO
        Disabled:         m_vif[i].usb4_debug_intf.ltssm_state_ascii = $sformatf("Disabled"); //TODO
        TRAINING:         m_vif[i].usb4_debug_intf.ltssm_state_ascii = $sformatf("TRAINING"); //TODO
        CL0:              m_vif[i].usb4_debug_intf.ltssm_state_ascii = $sformatf("CL0");
        CL1:              m_vif[i].usb4_debug_intf.ltssm_state_ascii = $sformatf("CL1");
        CL2:              m_vif[i].usb4_debug_intf.ltssm_state_ascii = $sformatf("CL2");
        CL0S:             m_vif[i].usb4_debug_intf.ltssm_state_ascii = $sformatf("CL0S");
        CL1_EXIT:         m_vif[i].usb4_debug_intf.ltssm_state_ascii = $sformatf("CL1_EXIT");
        CL2_EXIT:         m_vif[i].usb4_debug_intf.ltssm_state_ascii = $sformatf("CL2_EXIT");
        CL0S_EXIT:        m_vif[i].usb4_debug_intf.ltssm_state_ascii = $sformatf("CL0S_EXIT");
        OVERWRITE:        m_vif[i].usb4_debug_intf.ltssm_state_ascii = $sformatf("OVERWRITE");
	endcase 

	case(nxt_ltssm_st)
        CLD:              m_vif[i].usb4_debug_intf.next_ltssm_state_ascii = $sformatf("CLD"); //TODO
        Disabled:         m_vif[i].usb4_debug_intf.next_ltssm_state_ascii = $sformatf("Disabled"); //TODO
        TRAINING:         m_vif[i].usb4_debug_intf.next_ltssm_state_ascii = $sformatf("TRAINING"); //TODO
        CL0:              m_vif[i].usb4_debug_intf.next_ltssm_state_ascii = $sformatf("CL0");
        CL1:              m_vif[i].usb4_debug_intf.next_ltssm_state_ascii = $sformatf("CL1");
        CL2:              m_vif[i].usb4_debug_intf.next_ltssm_state_ascii = $sformatf("CL2");
        CL0S:             m_vif[i].usb4_debug_intf.next_ltssm_state_ascii = $sformatf("CL0S");
        CL1_EXIT:         m_vif[i].usb4_debug_intf.next_ltssm_state_ascii = $sformatf("CL1_EXIT");
        CL2_EXIT:         m_vif[i].usb4_debug_intf.next_ltssm_state_ascii = $sformatf("CL2_EXIT");
        CL0S_EXIT:        m_vif[i].usb4_debug_intf.next_ltssm_state_ascii = $sformatf("CL0S_EXIT");
        OVERWRITE:        m_vif[i].usb4_debug_intf.next_ltssm_state_ascii = $sformatf("OVERWRITE");
	endcase

	case(cur_ltssm_subst)
        USB4_LINK::IDLE:                m_vif[i].usb4_debug_intf.ltssm_substate_ascii = $sformatf("IDLE");
        USB4_LINK::LOCK1:               m_vif[i].usb4_debug_intf.ltssm_substate_ascii = $sformatf("LOCK1");
        USB4_LINK::LOCK2:               m_vif[i].usb4_debug_intf.ltssm_substate_ascii = $sformatf("LOCK2");
        USB4_LINK::TS1:                 m_vif[i].usb4_debug_intf.ltssm_substate_ascii = $sformatf("TS1");
        USB4_LINK::TS2:                 m_vif[i].usb4_debug_intf.ltssm_substate_ascii = $sformatf("TS2");
	endcase 

	case(nxt_ltssm_subst)
        USB4_LINK::IDLE:                m_vif[i].usb4_debug_intf.next_ltssm_substate_ascii = $sformatf("IDLE");
        USB4_LINK::LOCK1:               m_vif[i].usb4_debug_intf.next_ltssm_substate_ascii = $sformatf("LOCK1");
        USB4_LINK::LOCK2:               m_vif[i].usb4_debug_intf.next_ltssm_substate_ascii = $sformatf("LOCK2");
        USB4_LINK::TS1:                 m_vif[i].usb4_debug_intf.next_ltssm_substate_ascii = $sformatf("TS1");
        USB4_LINK::TS1:                 m_vif[i].usb4_debug_intf.next_ltssm_substate_ascii = $sformatf("TS2");
    endcase
end

endfunction : update_states_on_interface/*}}}*/


