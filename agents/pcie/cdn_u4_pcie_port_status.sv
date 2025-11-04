class cdn_u4_pcie_port_status extends uvm_object;
    //---------------------------------------
    // Member
    //---------------------------------------
	lane_ltssm_state_type_enum    pcie_ltssm_state;
	lane_ltssm_state_type_enum    nxt_pcie_ltssm_state;
	bit 						  transmitter_l0s;
	bit 						  receiver_l0s;
	//speed_type_enum 			  cur_speed;
	//lane_ltssm_substate_type_enum pcie_ltssm_substate;
	//lane_ltssm_substate_type_enum nxt_pcie_ltssm_substate;
    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_object_param_utils(cdn_u4_pcie_port_status)
     
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "cdn_u4_pcie_port_status");
        super.new(name);
    endfunction : new

    function void update_ltssm_state(input lane_ltssm_state_type_enum i_cur_ltssm_st, input lane_ltssm_state_type_enum i_nxt_ltssm_st, input bit[1:0] l0s_state);
        pcie_ltssm_state= i_cur_ltssm_st;
        nxt_pcie_ltssm_state= i_nxt_ltssm_st;
		if (pcie_ltssm_state == L0S_ENTRY) begin
		  transmitter_l0s = l0s_state[0];
		  receiver_l0s    = l0s_state[1];
		end
    endfunction
    
    //function void update_ltssm_substate(input lane_ltssm_substate_type_enum i_cur_ltssm_subst, input lane_ltssm_substate_type_enum i_nxt_ltssm_subst);
    //    pcie_ltssm_substate= i_cur_ltssm_subst;
    //    nxt_pcie_ltssm_substate= i_nxt_ltssm_subst;
    //endfunction

endclass
