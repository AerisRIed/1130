class cdn_u4_pcie_ltssm_control extends uvm_component;

  //------------------------------------------
  // Data Members 
  //------------------------------------------	
  cdn_u4_pcie_ltssm_instruction ltssm_instruction_local;

  //------------------------------------------
  // Model will receive data in on this port 
  //------------------------------------------
  uvm_seq_item_pull_port #(cdn_u4_pcie_ltssm_instruction,cdn_u4_pcie_ltssm_instruction) ltssm_instruction_port;

  //-------------------------------------------
  // Model will transmit data out on this port
  //-------------------------------------------
  cdn_u4_pcie_ltssm_instruction          ltssm_instruction;
  cdn_u4_pcie_config         			 m_cfg;
  cdn_phy_vif_t                 		 m_vif[tb_param :: PCIE_LANE_NUM];
  cdn_u4_pcie_port_status                port_status;
  cdn_phy_tb_config 			    	 tb_cfg;
  cdn_phy_dut_config 			    	 dut_cfg;
  cdn_phy_dut_config            		 device_dut_cfg;
  int lane_num_in_cur_link;
  
  // 
  lane_ltssm_state_type_enum              cur_ltssm_st;
  lane_ltssm_state_type_enum              nxt_ltssm_st;
  //lane_ltssm_substate_type_enum           cur_ltssm_subst;
  //lane_ltssm_substate_type_enum           nxt_ltssm_subst;
	

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

  //------------------------------------------
  // Methods 
  //------------------------------------------
  
  // Standard UVM Methods 
  extern function      new   (string name= "cdn_u4_pcie_ltssm_control", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task          run_phase  (uvm_phase phase);
  
  // APIs 
  extern task          get_ltssm_instruction();
  //extern task          process_item(cdn_u4_pcie_ltssm_instruction ltssm_instruction);

  extern task          lane_ltssm_state_machine();
  //extern task          polling_substate_machine();
  //extern task          reset_substate_to_idle();
  extern function void update_states_on_interface();
  extern function void reset_pcie_debug_intf_count();

  extern task          reset_value();
  //extern task          detect_over_limit_monitor();
  extern task 		   wait_rx_detect_interval();
  extern task 		   wait_rx_detect_time();
  extern function bit check_ltssm_transition_cond(string state_trans);

  // UVM Macros 
  `uvm_component_utils(cdn_u4_pcie_ltssm_control)

endclass : cdn_u4_pcie_ltssm_control

function cdn_u4_pcie_ltssm_control::new(string name = "cdn_u4_pcie_ltssm_control", uvm_component parent);
	// Super constructor/*{{{*/
	super.new(name, parent);
endfunction : new /*}}}*/

function void cdn_u4_pcie_ltssm_control::build_phase(uvm_phase phase);
  // Super builder/*{{{*/
  // -------------
  super.build_phase(phase);
  // tb_cfg
  if (!uvm_config_db#(cdn_phy_tb_config)::get(this,"","tb_cfg",tb_cfg))
	`uvm_fatal("","ltssm control cannot get tb_cfg! please check.")
  // dut cfg
  if (!uvm_config_db#(cdn_phy_dut_config)::get(this,"","dut_cfg",dut_cfg))
    `uvm_fatal("","ltssm control cannot get dut_cfg! please check.")
  if (!uvm_config_db#(cdn_phy_dut_config)::get(this,"","device_dut_cfg",device_dut_cfg))
    `uvm_fatal("","ltssm control cannot get device_dut_cfg! please check.")
  lane_num_in_cur_link = dut_cfg.pcie_lane_num;
  `uvm_info("",$sformatf("lane_num_in_cur_link=%0d",lane_num_in_cur_link),UVM_LOW)
  ltssm_instruction_port    = new("ltssm_instruction_port", this);
  ltssm_instruction_local = new("ltssm_instruction_local");
  reset_value();  // initial state
endfunction : build_phase/*}}}*/


function void cdn_u4_pcie_ltssm_control::connect_phase(uvm_phase phase);
  if (!uvm_config_db#(cdn_u4_pcie_config)::get(this,"","m_cfg",m_cfg))
	 `uvm_fatal("","ltssm control cannot get m_cfg! please check.")
endfunction : connect_phase/*}}}*/

task cdn_u4_pcie_ltssm_control::run_phase(uvm_phase phase);
/*{{{*/
	fork
		lane_ltssm_state_machine();
		get_ltssm_instruction();
	join
endtask : run_phase/*}}}*/

task cdn_u4_pcie_ltssm_control::get_ltssm_instruction();
	forever begin /*{{{*/
		ltssm_instruction_port.get_next_item(ltssm_instruction);
		$cast(ltssm_instruction_local,ltssm_instruction.clone());
		`uvm_info(get_name(),$sformatf("now get a new ltssm_instruction: %0s",ltssm_instruction_local.sprint()),UVM_LOW);
		//process_item(ltssm_instruction);
		ltssm_instruction_port.item_done();
	end
endtask : get_ltssm_instruction/*}}}*/

////----------------------------------------------------------
//// Task to process link service seq item, update the item to local variable
//task cdn_u4_pcie_ltssm_control::process_item(cdn_u4_pcie_ltssm_instruction ltssm_instruction);
///*{{{*/
//	ltssm_instruction_local.copy(ltssm_instruction); 
//
//endtask : process_item/*}}}*/

//----------------------------------------------------------
// link server sequence.
task cdn_u4_pcie_ltssm_control::lane_ltssm_state_machine();
	realtime rx_detect_wait_start;

	forever begin

		@(posedge m_vif[0].pclk);

		reset_pcie_debug_intf_count();
		update_states_on_interface();
		if (cur_ltssm_st != nxt_ltssm_st && nxt_ltssm_st == PCIE_LINK::DETECT_QUIET) rx_detect_wait_start = $realtime;
		cur_ltssm_st = nxt_ltssm_st;

        if(ltssm_instruction_local.overwrite_req) begin
 		    nxt_ltssm_st = PCIE_LINK::OVERWRITE;
        end else begin
        
            case(cur_ltssm_st)
		    	PCIE_LINK::DETECT_QUIET:
                begin
					//wait_rx_detect_interval(); // 12ms in spec
					if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		end else if ($realtime - rx_detect_wait_start > 12us) begin 
		    			nxt_ltssm_st = PCIE_LINK::DETECT_ACTIVE;
		    		end
		    	end

				PCIE_LINK::DETECT_ACTIVE:
                begin
					//wait_rx_detect_time();  // implementation specific
		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		end else if(check_ltssm_transition_cond("DETECT_ACTIVE_2_POLLING_ACTIVE"))begin //termenation detected
		    			nxt_ltssm_st = PCIE_LINK::POLLING_ACTIVE;
		    		end else if(check_ltssm_transition_cond("DETECT_ACTIVE_2_DETECT_QUIET")) begin
						nxt_ltssm_st = PCIE_LINK::DETECT_QUIET;
					end
		    	end

		    	PCIE_LINK::POLLING_ACTIVE:
		    	begin
		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		end else if (check_ltssm_transition_cond("POLLING_ACTIVE_2_POLLING_CONFIG")) begin
					  	nxt_ltssm_st = PCIE_LINK::POLLING_CONFIG;
					end else if (m_vif[0].pcie_debug_intf.tPollingTS1Timeout_flag && m_vif[0].pcie_debug_intf.ts1_with_compliance_bit_received_count >= POLLING_RECEIVE_TS1_NUM_MIN) begin
						nxt_ltssm_st = PCIE_LINK::COMPLIANCE;
					end
				end

				PCIE_LINK::POLLING_CONFIG:
		    	begin
		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		end else if (check_ltssm_transition_cond("POLLING_CONFIG_2_CONFIGURATION_WAIT")) begin
					  	nxt_ltssm_st = PCIE_LINK::CONFIGURATION_WAIT;
					end else if (check_ltssm_transition_cond("POLLING_CONFIG_2_DETECT_QUIET")) begin
						nxt_ltssm_st = PCIE_LINK::DETECT_QUIET;
					end
				end

				PCIE_LINK::CONFIGURATION_WAIT:
		    	begin
		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		end else if (check_ltssm_transition_cond("CONFIGURATION_WAIT_2_CONFIGURATION_COMPLETE")) begin
					  	nxt_ltssm_st = PCIE_LINK::CONFIGURATION_COMPLETE;
					end if (check_ltssm_transition_cond("CONFIGURATION_WAIT_2_DETECT_QUIET")) begin
						nxt_ltssm_st = PCIE_LINK::DETECT_QUIET;
					end
				end

				PCIE_LINK::CONFIGURATION_COMPLETE:
		    	begin
		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		end else if (check_ltssm_transition_cond("CONFIGURATION_COMPLETE_2_CONFIGURATION_IDLE")) begin
					  	nxt_ltssm_st = PCIE_LINK::CONFIGURATION_IDLE;
					end if (check_ltssm_transition_cond("CONFIGURATION_COMPLETE_2_DETECT_QUIET")) begin
						nxt_ltssm_st = PCIE_LINK::DETECT_QUIET;
					end
				end

			    PCIE_LINK::CONFIGURATION_IDLE:
		    	begin
		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		end else if (check_ltssm_transition_cond("CONFIGURATION_IDLE_2_L0")) begin
					  	nxt_ltssm_st = PCIE_LINK::L0;
					end else if (check_ltssm_transition_cond("CONFIGURATION_IDLE_2_DETECT_QUIET")) begin
						nxt_ltssm_st = PCIE_LINK::DETECT_QUIET;
					end
				end
					
		    	PCIE_LINK::L0:
		    	begin
		    		if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		end else if(ltssm_instruction_local.hot_reset_req)begin
		    			nxt_ltssm_st = PCIE_LINK::DETECT_QUIET;
		    		end else if(ltssm_instruction_local.l0s_entry_req > 0 || check_ltssm_transition_cond("L0_2_L0S_ENTRY"))begin
		    			nxt_ltssm_st = PCIE_LINK::L0S_ENTRY;
					end else if(ltssm_instruction_local.l1_entry_req)begin
		    			nxt_ltssm_st = PCIE_LINK::L1_ENTRY;
		    		end else if(ltssm_instruction_local.l2_entry_req)begin
		    			nxt_ltssm_st = PCIE_LINK::L2_ENTRY;
		    		end else if(ltssm_instruction_local.speed_change_req || check_ltssm_transition_cond("L0_2_RECOVERY_LOCK"))begin
		    			nxt_ltssm_st = PCIE_LINK::RECOVERY_LOCK;
		    		end 
                end

				PCIE_LINK::RECOVERY_LOCK:
				begin
					if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		end else if (check_ltssm_transition_cond("RECOVERY_LOCK_2_RECOVERY_CFG"))begin
		    			nxt_ltssm_st = PCIE_LINK::RECOVERY_CFG;
					end else if (check_ltssm_transition_cond("RECOVERY_LOCK_2_RECOVERY_EQ")) begin
						nxt_ltssm_st = PCIE_LINK::RECOVERY_EQ;
		    		end else if (check_ltssm_transition_cond("RECOVERY_LOCK_2_DETECT_QUIET")) begin
						nxt_ltssm_st = PCIE_LINK::DETECT_QUIET;
					end
				end

				PCIE_LINK::RECOVERY_CFG:
				begin
					if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		end else if(check_ltssm_transition_cond("RECOVERY_CFG_2_RECOVERY_SPEED")) begin
		    			nxt_ltssm_st = PCIE_LINK::RECOVERY_SPEED;
					end else if (check_ltssm_transition_cond("RECOVERY_CFG_2_RECOVERY_IDLE")) begin
						nxt_ltssm_st = PCIE_LINK::RECOVERY_IDLE;
		    		end else if (check_ltssm_transition_cond("RECOVERY_CFG_2_DETECT_QUIET")) begin
						nxt_ltssm_st = PCIE_LINK::DETECT_QUIET;
					end
				end

				PCIE_LINK::RECOVERY_SPEED:
				begin
					if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		end else if (check_ltssm_transition_cond("RECOVERY_SPEED_2_RECOVERY_LOCK")) begin
						nxt_ltssm_st = PCIE_LINK::RECOVERY_LOCK;
					end
				end

				PCIE_LINK::RECOVERY_EQ:
				begin
					if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		end else if (check_ltssm_transition_cond("RECOVERY_EQ_2_RECOVERY_LOCK")) begin
						nxt_ltssm_st = PCIE_LINK::RECOVERY_LOCK;
					end
				end

				PCIE_LINK::RECOVERY_IDLE:
				begin
					if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
		    		end else if (check_ltssm_transition_cond("RECOVERY_IDLE_2_DETECT_QUIET")) begin
						nxt_ltssm_st = PCIE_LINK::L0;
					end else if (m_vif[0].pcie_debug_intf.tRcvrIdleTimeout_flag) begin
						nxt_ltssm_st = PCIE_LINK::DETECT_QUIET;
					end
				end

				PCIE_LINK::L0S_ENTRY:
				begin
					if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
					end else if (check_ltssm_transition_cond("L0S_ENTRY_2_L0S_IDLE")) begin
						nxt_ltssm_st = PCIE_LINK::L0S_IDLE;
					end
				end

				PCIE_LINK::L0S_IDLE:
				begin
					if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
					end else if (ltssm_instruction_local.l0s_exit_req) begin
						nxt_ltssm_st = PCIE_LINK::L0S_FTS;
					end
				end

				PCIE_LINK::L0S_FTS:
				begin
					if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
					end else if (check_ltssm_transition_cond("L0S_FTS_2_L0")) begin
						nxt_ltssm_st = L0;
					end else if (m_vif[0].pcie_debug_intf.tL0s_Fts_Timeout_flag) begin
						nxt_ltssm_st = PCIE_LINK::RECOVERY_LOCK;
					end
				end

				PCIE_LINK::L1_ENTRY:
				begin
					if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
					end else if (check_ltssm_transition_cond("L1_ENTRY_2_L1_IDLE")) begin
						nxt_ltssm_st = PCIE_LINK::L1_IDLE;
					end
				end

				PCIE_LINK::L1_IDLE:
				begin
					if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
					end else if (ltssm_instruction_local.l1_exit_req) begin
						nxt_ltssm_st = PCIE_LINK::L1_EXIT;
					end
				end

				PCIE_LINK::L1_EXIT:
				begin
					if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
					end else if (check_ltssm_transition_cond("L1_EXIT_2_RECOVERY_LOCK")) begin
						nxt_ltssm_st = PCIE_LINK::RECOVERY_LOCK;
					end 
				end

				PCIE_LINK::L2_ENTRY:
				begin
					if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
					end else if (check_ltssm_transition_cond("L2_ENTRY_2_L2_IDLE")) begin
						nxt_ltssm_st = PCIE_LINK::L2_IDLE;
					end
				end

				PCIE_LINK::L2_IDLE:
				begin
					if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
					end else if (m_cfg.port_mode == DEVICE && ltssm_instruction_local.l2_exit_req) begin
						nxt_ltssm_st = PCIE_LINK::L2_TRANSMIT_WAKE;
					end else if (m_cfg.port_mode == HOST && check_ltssm_transition_cond("L2_IDLE_2_DETECT_QUIET")) begin
						nxt_ltssm_st = PCIE_LINK::DETECT_QUIET;
					end
				end

				PCIE_LINK::L2_TRANSMIT_WAKE:
				begin
					if(ltssm_instruction_local.direct_state_transition)begin
		    			nxt_ltssm_st = ltssm_instruction_local.next_ltssm_state;
					end else if (check_ltssm_transition_cond("L2_TRANSMIT_WAKE_2_DETECT_QUIET")) begin
						nxt_ltssm_st = PCIE_LINK::DETECT_QUIET;
					end 
				end

		    endcase 

			if(check_ltssm_transition_cond("RX_DETECT_LOSS"))begin //TODO from rtl need to add later
		      nxt_ltssm_st = PCIE_LINK::DETECT_QUIET;
            end

		    if(ltssm_instruction_local.direct_state_transition)begin
		    	ltssm_instruction_local.direct_state_transition = 0;
		    end
        end
		update_states_on_interface();
		// update prot_status.pcie_ltssm_state
	    port_status.update_ltssm_state(cur_ltssm_st, nxt_ltssm_st,ltssm_instruction_local.l0s_entry_req); 


end
endtask : lane_ltssm_state_machine/*}}}*/

////---------------------------------------------------------
//task cdn_u4_pcie_ltssm_control::reset_substate_to_idle();
//	cur_ltssm_subst = IDLE;/*{{{*/
//	nxt_ltssm_subst = IDLE;
//endtask : reset_substate_to_idle/*}}}*/

//----------------------------------------------------------
// Task to reset value when enter SS_INACTIVE state
task cdn_u4_pcie_ltssm_control::reset_value();
/*{{{*/
	cur_ltssm_st            = PCIE_LINK::DETECT_QUIET;
	nxt_ltssm_st            = PCIE_LINK::DETECT_QUIET;
	//cur_ltssm_subst         = eSS_Inactive_Quiet;
	//nxt_ltssm_subst         = eSS_Inactive_Quiet;


endtask : reset_value/*}}}*/

//----------------------------------------------------------
// function to update states on debug interface
function void cdn_u4_pcie_ltssm_control::update_states_on_interface();
  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	case(cur_ltssm_st)/*{{{*/
        PCIE_LINK::DETECT_QUIET:        	  m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("DETECT_QUIET"); 
        PCIE_LINK::DETECT_ACTIVE:        	  m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("DETECT_ACTIVE"); 
        PCIE_LINK::POLLING_ACTIVE:           m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("POLLING_ACTIVE"); 
        PCIE_LINK::POLLING_CONFIG:           m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("POLLING_CONFIG"); 
        PCIE_LINK::CONFIGURATION_WAIT:    	  m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("CONFIGURATION_WAIT"); 
        PCIE_LINK::CONFIGURATION_COMPLETE:   m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("CONFIGURATION_COMPLETE"); 
        PCIE_LINK::CONFIGURATION_IDLE:    	  m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("CONFIGURATION_IDLE"); 
        PCIE_LINK::L0:               		  m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("L0");
        PCIE_LINK::L0S_ENTRY:                m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("L0S_ENTRY");
        PCIE_LINK::L0S_IDLE:              	  m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("L0S_IDLE");
        PCIE_LINK::L0S_FTS:              	  m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("L0S_FTS");
        PCIE_LINK::L1_ENTRY:                 m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("L1_ENTRY");
        PCIE_LINK::L1_IDLE:               	  m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("L1_IDLE");
        PCIE_LINK::L1_EXIT:               	  m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("L1_EXIT");
        PCIE_LINK::L2_ENTRY:                 m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("L2_ENTRY");
        PCIE_LINK::L2_IDLE:               	  m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("L2_IDLE");
        PCIE_LINK::L2_TRANSMIT_WAKE:         m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("L2_TRANSMIT_WAKE");
        PCIE_LINK::LOOPBACK:         		  m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("LOOPBACK");
        PCIE_LINK::RECOVERY_LOCK:        	  m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("RECOVERY_LOCK");
        PCIE_LINK::RECOVERY_CFG:         	  m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("RECOVERY_CFG");
        PCIE_LINK::RECOVERY_SPEED:       	  m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("RECOVERY_SPEED");
        PCIE_LINK::RECOVERY_EQ:       		  m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("RECOVERY_EQ");
        PCIE_LINK::RECOVERY_IDLE:       	  m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("RECOVERY_IDLE");
        PCIE_LINK::COMPLIANCE:       m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("COMPLIANCE");
		PCIE_LINK::OVERWRITE:        m_vif[i].pcie_debug_intf.ltssm_state_ascii = $sformatf("OVERWRITE");
	
	endcase 

	case(nxt_ltssm_st)
		PCIE_LINK::DETECT_QUIET:        	  m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("DETECT_QUIET"); 
        PCIE_LINK::DETECT_ACTIVE:        	  m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("DETECT_ACTIVE"); 
        PCIE_LINK::POLLING_ACTIVE:           m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("POLLING_ACTIVE"); 
        PCIE_LINK::POLLING_CONFIG:           m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("POLLING_CONFIG"); 
        PCIE_LINK::CONFIGURATION_WAIT:    	  m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("CONFIGURATION_WAIT"); 
        PCIE_LINK::CONFIGURATION_COMPLETE:   m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("CONFIGURATION_COMPLETE"); 
        PCIE_LINK::CONFIGURATION_IDLE:    	  m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("CONFIGURATION_IDLE"); 
        PCIE_LINK::L0:               		  m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("L0");
        PCIE_LINK::L0S_ENTRY:                m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("L0S_ENTRY");
        PCIE_LINK::L0S_IDLE:              	  m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("L0S_IDLE");
        PCIE_LINK::L0S_FTS:              	  m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("L0S_FTS");
        PCIE_LINK::L1_ENTRY:                 m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("L1_ENTRY");
        PCIE_LINK::L1_IDLE:               	  m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("L1_IDLE");
        PCIE_LINK::L1_EXIT:               	  m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("L1_EXIT");
        PCIE_LINK::L2_ENTRY:                 m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("L2_ENTRY");
        PCIE_LINK::L2_IDLE:               	  m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("L2_IDLE");
        PCIE_LINK::L2_TRANSMIT_WAKE:         m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("L2_TRANSMIT_WAKE");
        PCIE_LINK::LOOPBACK:         		  m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("LOOPBACK");
        PCIE_LINK::RECOVERY_LOCK:        	  m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("RECOVERY_LOCK");
        PCIE_LINK::RECOVERY_CFG:         	  m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("RECOVERY_CFG");
        PCIE_LINK::RECOVERY_SPEED:       	  m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("RECOVERY_SPEED");
        PCIE_LINK::RECOVERY_EQ:       		  m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("RECOVERY_EQ");
        PCIE_LINK::RECOVERY_IDLE:       	  m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("RECOVERY_IDLE");
        PCIE_LINK::COMPLIANCE:       		  m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("COMPLIANCE");
		PCIE_LINK::OVERWRITE:        		  m_vif[i].pcie_debug_intf.next_ltssm_state_ascii = $sformatf("OVERWRITE");

	endcase
  end

endfunction : update_states_on_interface/*}}}*/

task cdn_u4_pcie_ltssm_control::wait_rx_detect_interval();
  #120ns;
endtask
//-------------------------------------------------------------

task cdn_u4_pcie_ltssm_control::wait_rx_detect_time();   // TODO
  #30us;
endtask
//-------------------------------------------------------------

function void cdn_u4_pcie_ltssm_control:: reset_pcie_debug_intf_count();
	if (cur_ltssm_st != nxt_ltssm_st) 
      for(int i=0;i<lane_num_in_cur_link;i++) m_vif[i].pcie_debug_intf.reset();
endfunction

function bit cdn_u4_pcie_ltssm_control::check_ltssm_transition_cond(string state_trans);
  int cond_cnt;

  case(state_trans)
	"DETECT_ACTIVE_2_POLLING_ACTIVE":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.Far_end_Rx_Detected)
	      cond_cnt ++;
	  end
	  if (cond_cnt == lane_num_in_cur_link) return 1;
	  else 									return 0;
	end
	"DETECT_ACTIVE_2_DETECT_QUIET":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.tRxdetectTimeout_flag)
	      cond_cnt ++;
	  end
	  if (cond_cnt > 0) 					return 1;
	  else 									return 0;
	end
    "POLLING_ACTIVE_2_POLLING_CONFIG":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.ts1_sent_count >= POLLING_TRANSMIT_TS1_NUM_MIN && m_vif[i].pcie_debug_intf.ts1_received_count >= POLLING_RECEIVE_TS1_NUM_MIN)
	      cond_cnt ++;
	  end
	  if (cond_cnt == lane_num_in_cur_link) return 1;
	  else 									return 0;
	end
	"POLLING_CONFIG_2_CONFIGURATION_WAIT":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.ts2_sent_count >= POLLING_TRANSMIT_TS2_NUM_MIN && m_vif[i].pcie_debug_intf.ts2_received_count >= POLLING_RECEIVE_TS2_NUM_MIN)
	      cond_cnt ++;
	  end
	  if (cond_cnt > 0) return 1;
	  else 				return 0;
	end
	"POLLING_CONFIG_2_DETECT_QUIET":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.tPollingCFGTimeout_flag)
	      cond_cnt ++;
	  end
	  if (cond_cnt > lane_num_in_cur_link) return 1;
	  else 								   return 0;
	end
	"CONFIGURATION_WAIT_2_CONFIGURATION_COMPLETE":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.ts1_sent_count >= CONFIGURATION_TRANSMIT_TS1_NUM_MIN && m_vif[i].pcie_debug_intf.ts1_received_count >= CONFIGURATION_RECEIVE_TS1_NUM_MIN)
	      cond_cnt ++;
	  end
	  if (cond_cnt == lane_num_in_cur_link) return 1;
	  else 				 				    return 0;
	end
	"CONFIGURATION_WAIT_2_DETECT_QUIET":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.tConfigTS1Timeout_flag)
	      cond_cnt ++;
	  end
	  if (cond_cnt> 0) 						return 1;
	  else 				 				    return 0;
	end
	"CONFIGURATION_COMPLETE_2_CONFIGURATION_IDLE":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.ts2_sent_count >= CONFIGURATION_TRANSMIT_TS2_NUM_MIN && m_vif[i].pcie_debug_intf.ts2_received_count >= CONFIGURATION_RECEIVE_TS2_NUM_MIN)
	      cond_cnt ++;
	  end
	  if (cond_cnt == lane_num_in_cur_link) return 1;
	  else 				 				    return 0;
	end
	"CONFIGURATION_COMPLETE_2_DETECT_QUIET":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.tConfigTS2Timeout_flag)
	      cond_cnt ++;
	  end
	  if (cond_cnt > 0) 					return 1;
	  else 				 				    return 0;
	end
	"CONFIGURATION_IDLE_2_L0":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.idle_packet_sent_count >= CONFIGURATION_TRANSMIT_IDL_NUM_MIN && m_vif[i].pcie_debug_intf.idle_packet_received_count >= CONFIGURATION_RECEIVE_IDL_NUM_MIN)
	      cond_cnt ++;
	  end
	  if (cond_cnt == lane_num_in_cur_link) return 1;
	  else 				 				    return 0;
	end
	"CONFIGURATION_IDLE_2_DETECT_QUIET":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.tConfigIdleTimeout_flag)
	      cond_cnt ++;
	  end
	  if (cond_cnt > 0) 					return 1;
	  else 				 				    return 0;
	end
	"L0_2_L0S_ENTRY":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.eios_detected)
	      cond_cnt ++;
	  end
	  if (cond_cnt > 0) 					return 1;
	  else 				 				    return 0;
	end
	"L0_2_RECOVERY_LOCK":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.ts1_received_count >= 1)
	      cond_cnt ++;
	  end
	  if (cond_cnt > 0) 					return 1;
	  else 				 				    return 0;
	end
	"RECOVERY_LOCK_2_RECOVERY_CFG":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.ts1_received_count >= RECOVERY_LOCK_RECEIVE_TS1_NUM_MIN)
	      cond_cnt ++;
	  end
	  if (cond_cnt == lane_num_in_cur_link) 	return 1;
	  else 				 				    return 0;
	end
	"RECOVERY_LOCK_2_RECOVERY_EQ":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.ts1_with_eq_received_count >= RECOVERY_LOCK_RECEIVE_TS1_NUM_MIN)
	      cond_cnt ++;
	  end
	  if (cond_cnt == lane_num_in_cur_link) 	return 1;
	  else 				 				    return 0;
	end
	"RECOVERY_LOCK_2_DETECT_QUIET":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.tRcvrLockTimeout_flag)
	      cond_cnt ++;
	  end
	  if (cond_cnt > 0) 					return 1;
	  else 				 				    return 0;
	end
	"RECOVERY_CFG_2_RECOVERY_SPEED":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if ((!dut_cfg.pcie_gen_speed[1] && m_vif[i].pcie_debug_intf.ts2_with_speed_change_sent_count >= RECOVERY_CFG_GEN1_2_TRANSMIT_TS2_NUM_MIN && m_vif[i].pcie_debug_intf.ts2_with_speed_change_received_count >= RECOVERY_CFG_RECEIVE_TS2_NUM_MIN) ||
			(dut_cfg.pcie_gen_speed[1] && m_vif[i].pcie_debug_intf.ts2_with_speed_change_sent_count >= RECOVERY_CFG_GEN3_4_TRANSMIT_TS2_NUM_MIN && m_vif[i].pcie_debug_intf.ts2_with_speed_change_received_count >= RECOVERY_CFG_RECEIVE_TS2_NUM_MIN))
	      cond_cnt ++;
	  end
	  if (cond_cnt > 0) 					return 1;
	  else 				 				    return 0;
	end
	"RECOVERY_CFG_2_RECOVERY_IDLE":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.ts2_sent_count >= RECOVERY_CFG_TRANSMIT_TS2_NUM_MIN && m_vif[i].pcie_debug_intf.ts2_received_count >= RECOVERY_CFG_RECEIVE_TS2_NUM_MIN)
	      cond_cnt ++;
	  end
	  if (cond_cnt == lane_num_in_cur_link) return 1;
	  else 				 				    return 0;
	end
	"RECOVERY_CFG_2_DETECT_QUIET":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.tRcvrCfgTimeout_flag)
	      cond_cnt ++;
	  end
	  if (cond_cnt > 0) 					return 1;
	  else 				 				    return 0;
	end
	"RECOVERY_SPEED_2_RECOVERY_LOCK":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.speed_change_done)
	      cond_cnt ++;
	  end
	  if (cond_cnt == lane_num_in_cur_link) return 1;
	  else 				 				    return 0;
	end
	"RECOVERY_EQ_2_RECOVERY_LOCK":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.ts1_sent_count >= RECOVERY_EQ_TRANSMIT_TS1_NUM_MIN && m_vif[i].pcie_debug_intf.ts1_received_count >= RECOVERY_EQ_RECEIVE_TS1_NUM_MIN && m_vif[i].pcie_debug_intf.eq_done)
	      cond_cnt ++;
	  end
	  if (cond_cnt == lane_num_in_cur_link) return 1;
	  else 				 				    return 0;
	end
	"RECOVERY_IDLE_2_DETECT_QUIET":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.idle_packet_sent_count >= RECOVERY_IDLE_TRANSMIT_IDL_NUM_MIN && m_vif[i].pcie_debug_intf.idle_packet_received_count >= RECOVERY_IDLE_RECEIVE_IDL_NUM_MIN)
	      cond_cnt ++;
	  end
	  if (cond_cnt == lane_num_in_cur_link) return 1;
	  else 				 				    return 0;
	end
	"L0S_ENTRY_2_L0S_IDLE":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.L0s_entry_detected)
	      cond_cnt ++;
	  end
	  if (cond_cnt == lane_num_in_cur_link) return 1;
	  else 				 				    return 0;
	end
	"L0S_FTS_2_L0":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.L0s_exit_detected)
	      cond_cnt ++;
	  end
	  if (cond_cnt == lane_num_in_cur_link) return 1;
	  else 				 				    return 0;
	end
	"L1_ENTRY_2_L1_IDLE":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.L1_entry_detected)
	      cond_cnt ++;
	  end
	  if (cond_cnt == lane_num_in_cur_link) return 1;
	  else 				 				    return 0;
	end
	"L1_EXIT_2_RECOVERY_LOCK":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.L1_exit_detected)
	      cond_cnt ++;
	  end
	  if (cond_cnt == lane_num_in_cur_link) return 1;
	  else 				 				    return 0;
	end
	"L2_ENTRY_2_L2_IDLE":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.L2_entry_detected)
	      cond_cnt ++;
	  end
	  if (cond_cnt == lane_num_in_cur_link) return 1;
	  else 				 				    return 0;
	end
	"L2_IDLE_2_DETECT_QUIET":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.beacon_detected)
	      cond_cnt ++;
	  end
	  if (cond_cnt > 0)		 				return 1;
	  else 				 				    return 0;
	end
	"L2_TRANSMIT_WAKE_2_DETECT_QUIET":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.electrical_idle_exit_detected)
	      cond_cnt ++;
	  end
	  if (cond_cnt > 0)		 				return 1;
	  else 				 				    return 0;
	end
	"RX_DETECT_LOSS":
	begin 
	  for(int i=0;i<lane_num_in_cur_link;i++) begin 
	    if (m_vif[i].pcie_debug_intf.Far_end_Rx_Absent)
	      cond_cnt ++;
	  end
	  if (cond_cnt > 0)		 				return 1;
	  else 				 				    return 0;
	end
  endcase
endfunction
