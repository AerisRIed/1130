class cdn_u4_usb32_transmitter_transaction extends uvm_object;

    //---------------------------------------
    // Member will include all member that driver include, use for callback and other 
    //---------------------------------------
    bit [7:0]  data_8b;
    bit [9:0]  data_10b;
    bit [7:0]  BERT;
    bit [15:0] cur_lfsr;
    bit is_k_code;
    bit [31:0] TxData;
    bit [3:0]  TxDataK;
    
    
    bit [7:0] skp_symbol_gen1;
    //---------------------------------------
    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_object_param_utils_begin(cdn_u4_usb32_transmitter_transaction)
    `uvm_object_utils_end
     
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "cdn_u4_usb32_transmitter_transaction");
        super.new(name);
    endfunction : new

    extern function void clear_obj();
    extern virtual function void do_copy(uvm_object rhs);

endclass

function void cdn_u4_usb32_transmitter_transaction :: clear_obj();
endfunction

//------------------------------------------
// do_copy
//------------------------------------------
function void cdn_u4_usb32_transmitter_transaction::do_copy (uvm_object rhs);
    cdn_u4_usb32_transmitter_transaction m_rhs;
    super.do_copy(rhs);

    $cast(m_rhs, rhs);
endfunction : do_copy



