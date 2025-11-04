//--------------------------------------------------------
//*******************************************************
class cdn_u4_usb4_ltssm_instruction extends cdn_phy_transaction_base;

    // Member
    rand int direct_state_transition;
    rand lane_ltssm_state_type_enum next_ltssm_state;
    rand int direct_substate_transition;
    rand lane_ltssm_substate_type_enum next_ltssm_substate;
    rand bit cl1_entry_req;
    rand bit cl2_entry_req;
    rand bit cl0s_entry_req;
    rand bit low_power_exit_req;
    rand bit overwrite_req;
    cdn_u4_usb4_symbol_pattern    symbol_pattern;
     
    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_object_param_utils_begin(cdn_u4_usb4_ltssm_instruction)
        `uvm_field_int(direct_state_transition,    UVM_PRINT | UVM_COPY)  
        `uvm_field_enum(lane_ltssm_state_type_enum ,next_ltssm_state,           UVM_PRINT | UVM_COPY)  
        `uvm_field_int(direct_substate_transition,    UVM_PRINT | UVM_COPY)  
        `uvm_field_enum(lane_ltssm_substate_type_enum ,next_ltssm_substate,           UVM_PRINT | UVM_COPY)  
        `uvm_field_int(cl1_entry_req,               UVM_PRINT | UVM_COPY)  
        `uvm_field_int(cl2_entry_req,               UVM_PRINT | UVM_COPY)  
        `uvm_field_int(cl0s_entry_req,               UVM_PRINT | UVM_COPY)  
        `uvm_field_int(low_power_exit_req,         UVM_PRINT | UVM_COPY)  
        `uvm_field_int(overwrite_req,         UVM_PRINT | UVM_COPY)  
      `uvm_object_utils_end

    //--------------------------------------
    // Construnctor
    //--------------------------------------
    function new(string name="cdn_u4_usb4_ltssm_instruction");
        super.new(name);
        symbol_pattern = new();
    endfunction : new

    //---------------------------------------
    // Methods 
    //---------------------------------------
//------------------------------------------
// do_copy
//------------------------------------------
function void do_copy (uvm_object rhs);
    cdn_u4_usb4_ltssm_instruction m_rhs;
    super.do_copy(rhs);

    $cast(m_rhs, rhs);
    direct_state_transition     = m_rhs.direct_state_transition;
    direct_substate_transition  = m_rhs.direct_substate_transition;
    next_ltssm_state            = m_rhs.next_ltssm_state;
    next_ltssm_substate         = m_rhs.next_ltssm_substate;
    overwrite_req               = m_rhs.overwrite_req;
    symbol_pattern              = m_rhs.symbol_pattern;
endfunction : do_copy

//------------------------------------------
// do_copy
//------------------------------------------
function void reset_value ();
    cl1_entry_req   = 0;
    cl2_entry_req   = 0;
    cl0s_entry_req   = 0;
    low_power_exit_req   = 0;
    overwrite_req   = 0;
endfunction : reset_value
endclass
