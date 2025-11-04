// UVM_REG Adaptor class

class jtag_reg_adapter extends uvm_reg_adapter;
	`uvm_object_utils(jtag_reg_adapter)
  
  function new(string name = "jtag_reg_adapter");
    super.new(name);
    provides_responses=1; // driver provides separate response items 
  endfunction

  virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    cdn_jtag_trans jtag = cdn_jtag_trans::type_id::create("jtag");
    jtag.op = (rw.kind == UVM_READ) ? JTAG_READ : JTAG_WRITE;
    jtag.addr = rw.addr; //reg address becomes the first address of the transfer
    jtag.data = rw.data;//{rw.data[7:0],rw.data[15:8],rw.data[23:16],rw.data[31:24]};
    //jtag.PortNum = 0;
    if (rw.kind == UVM_WRITE) begin
      `uvm_info(get_type_name(), $sformatf( "REG_DEBUG :: REG2BUS Completed WRITE at Address = %0h, Data = %0h", rw.addr, rw.data), UVM_LOW)
    end
    if (rw.kind == UVM_READ) 
      `uvm_info(get_type_name(), $sformatf( "REG_DEBUG :: REG2BUS Completed READ at Address = %0h", rw.addr), UVM_LOW)
    return jtag;
  endfunction

  virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
    cdn_jtag_trans jtag;
    if (!$cast(jtag,bus_item)) begin
      `uvm_fatal("NOT_JTAG_TYPE", "Provided bus_item is not of the correct type")
      return;
    end
    jtag.print();
    rw.kind = (jtag.op == JTAG_READ) ? UVM_READ : UVM_WRITE;
    rw.addr = jtag.addr;
    rw.data = jtag.data;
    if (rw.kind == UVM_WRITE) begin 
      `uvm_info(get_type_name(), $sformatf( "REG_DEBUG :: BUS2REG Completed WRITE at Address = %0h, Data = %0h", rw.addr, rw.data ), UVM_LOW)
    end
    if (rw.kind == UVM_READ) begin
      `uvm_info(get_type_name(), $sformatf( "REG_DEBUG :: BUS2REG Completed READ at Address = %0h, Data = %0h", rw.addr, rw.data ), UVM_LOW)
    end
    rw.status = UVM_IS_OK;
  endfunction

endclass
