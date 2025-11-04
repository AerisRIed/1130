//--------------------------------------------------------
//*******************************************************
class cdn_u4_pcie_ltssm_instruction extends uvm_sequence_item;
    // Member
    bit direct_state_transition;
    lane_ltssm_state_type_enum next_ltssm_state;
    //rand int direct_substate_transition;
    //rand lane_ltssm_substate_type_enum next_ltssm_substate;
    bit hot_reset_req;
    bit[1:0] l0s_entry_req;
    bit l0s_exit_req;
    bit l1_entry_req;
    bit l2_entry_req;
    bit l1_exit_req;
    bit l2_exit_req;
    bit loopback_req;
    bit speed_change_req;
    bit overwrite_req;
    cdn_u4_pcie_symbol_pattern    symbol_pattern;
     
    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_object_param_utils_begin(cdn_u4_pcie_ltssm_instruction)
        `uvm_field_int(direct_state_transition,    UVM_ALL_ON)  
        `uvm_field_enum(lane_ltssm_state_type_enum ,next_ltssm_state,           UVM_ALL_ON)  
        //`uvm_field_int(direct_substate_transition,    UVM_ALL_ON)  
        //`uvm_field_enum(lane_ltssm_substate_type_enum ,next_ltssm_substate,           UVM_ALL_ON)  
        `uvm_field_int(hot_reset_req,             UVM_ALL_ON)  
        `uvm_field_int(l0s_entry_req,             UVM_ALL_ON)  
        `uvm_field_int(l0s_exit_req,              UVM_ALL_ON)  
        `uvm_field_int(l1_entry_req,              UVM_ALL_ON)  
        `uvm_field_int(l2_entry_req,              UVM_ALL_ON)  
        `uvm_field_int(l1_exit_req,               UVM_ALL_ON)  
        `uvm_field_int(l2_exit_req,               UVM_ALL_ON)  
        `uvm_field_int(speed_change_req,          UVM_ALL_ON)  
        `uvm_field_int(loopback_req,        	  UVM_ALL_ON)  
        `uvm_field_int(overwrite_req,             UVM_ALL_ON)  
      `uvm_object_utils_end

    //--------------------------------------
    // Construnctor
    //--------------------------------------
    function new(string name="cdn_u4_pcie_ltssm_instruction");
        super.new(name);
        symbol_pattern = new();
    endfunction : new

    //---------------------------------------
    // Methods 
    //---------------------------------------
//------------------------------------------
// do_copy
//------------------------------------------
//function void do_copy (uvm_object rhs);
//    cdn_u4_pcie_ltssm_instruction m_rhs;
//    super.do_copy(rhs);
//
//    $cast(m_rhs, rhs);
//    direct_state_transition     = m_rhs.direct_state_transition;
//	next_ltssm_state 			= m_rhs.next_ltssm_state;
//	hot_reset_req 			    = m_rhs.hot_reset_req;
//	l0s_entry_req 			    = m_rhs.l0s_entry_req;
//	l1_entry_req 			    = m_rhs.l1_entry_req;
//	l2_entry_req 			    = m_rhs.l2_entry_req;
//	l1_exit_req 			    = m_rhs.l1_exit_req;
//	l2_exit_req 			    = m_rhs.l2_exit_req;
//	loopback_req 			    = m_rhs.loopback_req;
//	speed_change_req 			= m_rhs.speed_change_req;
//    //direct_substate_transition  = m_rhs.direct_substate_transition;
//    //next_ltssm_state            = m_rhs.next_ltssm_state;
//    //next_ltssm_substate         = m_rhs.next_ltssm_substate;
//    overwrite_req               = m_rhs.overwrite_req;
//    symbol_pattern              = m_rhs.symbol_pattern;
//endfunction : do_copy

endclass
