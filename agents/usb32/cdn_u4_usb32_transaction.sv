//
// Template for UVM-compliant transaction descriptor

`ifndef cdn_u4_usb32_transaction__SV
`define cdn_u4_usb32_transaction__SV


class cdn_u4_usb32_transaction extends cdn_phy_transaction_base;

    bit[8:0] host_rxdata_buf_lane0[];
    bit[8:0] host_rxdata_buf_lane1[];
    bit[8:0] devc_rxdata_buf_lane0[];
    bit[8:0] devc_rxdata_buf_lane1[];
    bit[8:0] host_txdata_buf_lane0[];
    bit[8:0] host_txdata_buf_lane1[];
    bit[8:0] devc_txdata_buf_lane0[];
    bit[8:0] devc_txdata_buf_lane1[];

   // ToDo: Add constraint blocks to prevent error injection
   // ToDo: Add relevant class properties to define all transactions
   // ToDo: Modify/add symbolic transaction identifiers to match

   `uvm_object_utils_begin(cdn_u4_usb32_transaction) 

      // ToDo: add properties using macros here
        `uvm_field_array_int(host_rxdata_buf_lane0,      UVM_PRINT | UVM_COPY)  
        `uvm_field_array_int(host_rxdata_buf_lane1,      UVM_PRINT | UVM_COPY)  
        `uvm_field_array_int(devc_rxdata_buf_lane0,      UVM_PRINT | UVM_COPY)  
        `uvm_field_array_int(devc_rxdata_buf_lane1,      UVM_PRINT | UVM_COPY)  
        `uvm_field_array_int(host_txdata_buf_lane0,      UVM_PRINT | UVM_COPY)  
        `uvm_field_array_int(host_txdata_buf_lane1,      UVM_PRINT | UVM_COPY)  
        `uvm_field_array_int(devc_txdata_buf_lane0,      UVM_PRINT | UVM_COPY)  
        `uvm_field_array_int(devc_txdata_buf_lane1,      UVM_PRINT | UVM_COPY)  
   `uvm_object_utils_end
 
   extern function new(string name = "Trans");
   extern virtual function void do_copy(uvm_object rhs);

endclass: cdn_u4_usb32_transaction


function cdn_u4_usb32_transaction::new(string name = "Trans");
   super.new(name);
    host_rxdata_buf_lane0 = new[16];
    host_rxdata_buf_lane1 = new[16];
    devc_txdata_buf_lane0 = new[16];
    devc_txdata_buf_lane1 = new[16];
    host_txdata_buf_lane0 = new[16];
    host_txdata_buf_lane1 = new[16];
    devc_rxdata_buf_lane0 = new[16];
    devc_rxdata_buf_lane1 = new[16];
    
endfunction: new

//------------------------------------------
// do_copy
//------------------------------------------
function void cdn_u4_usb32_transaction::do_copy (uvm_object rhs);
    cdn_u4_usb32_transaction m_rhs;
    super.do_copy(rhs);

    $cast(m_rhs, rhs);
    host_rxdata_buf_lane0  = m_rhs.host_rxdata_buf_lane0;
    host_rxdata_buf_lane1  = m_rhs.host_rxdata_buf_lane1;
    devc_rxdata_buf_lane0  = m_rhs.devc_rxdata_buf_lane0;
    devc_rxdata_buf_lane1  = m_rhs.devc_rxdata_buf_lane1;
    host_txdata_buf_lane0  = m_rhs.host_txdata_buf_lane0;
    host_txdata_buf_lane1  = m_rhs.host_txdata_buf_lane1;
    devc_txdata_buf_lane0  = m_rhs.devc_txdata_buf_lane0;
    devc_txdata_buf_lane1  = m_rhs.devc_txdata_buf_lane1;
 endfunction : do_copy

`endif // cdn_u4_usb32_transaction__SV

