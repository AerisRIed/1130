//--------------------------------------------------------
//*******************************************************
class cdn_u4_usb32_ltssm_instruction extends cdn_phy_transaction_base;

    // Member
    rand int direct_state_transition;
    rand lane_ltssm_state_type_enum next_ltssm_state;
    rand int direct_substate_transition;
    rand lane_ltssm_substate_type_enum next_ltssm_substate;
    rand bit warm_reset_req;
    rand bit loopback_req;
    rand bit loopback_brst_req;
    rand bit hot_reset_req;
    rand bit u1_entry_req;
    rand bit u2_entry_req;
    rand bit u3_entry_req;
    rand bit recovery_req;
    rand bit low_power_exit_req;
    rand bit loopback_exit_req;
    rand bit overwrite_req;
    cdn_u4_usb32_symbol_pattern    symbol_pattern;
     
    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_object_param_utils_begin(cdn_u4_usb32_ltssm_instruction)
        `uvm_field_int(direct_state_transition,    UVM_PRINT | UVM_COPY)  
        `uvm_field_enum(lane_ltssm_state_type_enum ,next_ltssm_state,           UVM_PRINT | UVM_COPY)  
        `uvm_field_int(direct_substate_transition,    UVM_PRINT | UVM_COPY)  
        `uvm_field_enum(lane_ltssm_substate_type_enum ,next_ltssm_substate,           UVM_PRINT | UVM_COPY)  
        `uvm_field_int(warm_reset_req,             UVM_PRINT | UVM_COPY)  
        `uvm_field_int(loopback_req,               UVM_PRINT | UVM_COPY)  
        `uvm_field_int(hot_reset_req,              UVM_PRINT | UVM_COPY)  
        `uvm_field_int(u1_entry_req,               UVM_PRINT | UVM_COPY)  
        `uvm_field_int(u2_entry_req,               UVM_PRINT | UVM_COPY)  
        `uvm_field_int(u3_entry_req,               UVM_PRINT | UVM_COPY)  
        `uvm_field_int(recovery_req,               UVM_PRINT | UVM_COPY)  
        `uvm_field_int(low_power_exit_req,         UVM_PRINT | UVM_COPY)  
        `uvm_field_int(loopback_exit_req,         UVM_PRINT | UVM_COPY)  
        `uvm_field_int(loopback_brst_req,         UVM_PRINT | UVM_COPY)  
        `uvm_field_int(overwrite_req,         UVM_PRINT | UVM_COPY)  
      `uvm_object_utils_end

    //--------------------------------------
    // Construnctor
    //--------------------------------------
    function new(string name="cdn_u4_usb32_ltssm_instruction");
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
    cdn_u4_usb32_ltssm_instruction m_rhs;
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
    warm_reset_req   = 0;
    loopback_req   = 0;
    hot_reset_req   = 0;
    u1_entry_req   = 0;
    u2_entry_req   = 0;
    u3_entry_req   = 0;
    recovery_req   = 0;
    low_power_exit_req   = 0;
    loopback_exit_req   = 0;
    loopback_brst_req   = 0;
    overwrite_req   = 0;
endfunction : reset_value
endclass
