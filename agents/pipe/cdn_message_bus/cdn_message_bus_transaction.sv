`ifndef CDN_MESSAGE_BUS_TRANSACTION
`define CDN_MESSAGE_BUS_TRANSACTION

class cdn_message_bus_transaction extends uvm_sequence_item;

  rand message_bus_cmd_t   cmd;
  rand bit [11:0] addr;
  rand bit [7:0]  data;
  rand bit        back2back_en;
  string  report_id = "CDN_MESSAGE_BUS_TRANSACTION_C";
//Factory registration
  `uvm_object_utils_begin(cdn_message_bus_transaction)
    `uvm_field_enum(message_bus_cmd_t,cmd, UVM_ALL_ON)
    `uvm_field_int(addr, UVM_ALL_ON)
    `uvm_field_int(data, UVM_ALL_ON)
	`uvm_field_int(back2back_en, UVM_ALL_ON)

  `uvm_object_utils_end

  //new constructor
  function new(string name="cdn_message_bus_transaction");
    super.new(name);
    `uvm_info(report_id,"New constructor",UVM_DEBUG)
  endfunction:new
endclass

`endif
