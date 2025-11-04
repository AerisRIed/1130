`ifndef CDN_JTAG_TRAN
`define CDN_JTAG_TRAN

class cdn_jtag_trans extends uvm_sequence_item;

  rand jtag_op_t   op;
  rand jtag_addr_t addr;
  rand jtag_data_t data;
  string  report_id = "CDN_JTAG_TRANS_C";
//Factory registration
  `uvm_object_utils_begin(cdn_jtag_trans)
    `uvm_field_enum(jtag_op_t, op, UVM_ALL_ON)
    `uvm_field_int(addr, UVM_ALL_ON)
    `uvm_field_int(data, UVM_ALL_ON)
  `uvm_object_utils_end

  //new constructor
  function new(string name="cdn_utmi_trans_base");
    super.new(name);
    `uvm_info(report_id,"New constructor",UVM_DEBUG)
  endfunction:new
endclass

`endif
