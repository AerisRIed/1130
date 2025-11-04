class cdn_u4_usb4_port_status extends uvm_object;
    //---------------------------------------
    // Member
    //---------------------------------------
	lane_ltssm_state_type_enum    usb4_ltssm_state;
	lane_ltssm_state_type_enum    nxt_usb4_ltssm_state;
	lane_ltssm_substate_type_enum usb4_ltssm_substate;
	lane_ltssm_substate_type_enum nxt_usb4_ltssm_substate;
    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_object_param_utils(cdn_u4_usb4_port_status)
     
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "cdn_u4_usb4_port_status");
        super.new(name);
    endfunction : new
    function void update_ltssm_state(input lane_ltssm_state_type_enum i_cur_ltssm_st, input lane_ltssm_state_type_enum i_nxt_ltssm_st);
        usb4_ltssm_state= i_cur_ltssm_st;
        nxt_usb4_ltssm_state= i_nxt_ltssm_st;
    endfunction
    
    function void update_ltssm_substate(input lane_ltssm_substate_type_enum i_cur_ltssm_subst, input lane_ltssm_substate_type_enum i_nxt_ltssm_subst);
        usb4_ltssm_substate= i_cur_ltssm_subst;
        nxt_usb4_ltssm_substate= i_nxt_ltssm_subst;
    endfunction

endclass
