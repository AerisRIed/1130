// UVM_REG Adaptor class

class jtag_1687_reg_adapter extends uvm_reg_adapter;
	`uvm_object_utils(jtag_1687_reg_adapter)
  
  function new(string name = "jtag_1687_reg_adapter");
    super.new(name);
    provides_responses=1; // driver provides separate response items 
  endfunction

  virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    cdn_jtag_1687_trans jtag_1687 = cdn_jtag_1687_trans::type_id::create("jtag_1687");
    jtag_1687.op = (rw.kind == UVM_READ) ? READ_1687 : WRITE_1687;
    jtag_1687.addr = rw.addr; //reg address becomes the first address of the transfer
    jtag_1687.data = rw.data;//{rw.data[7:0],rw.data[15:8],rw.data[23:16],rw.data[31:24]};
    //jtag.PortNum = 0;
    if (rw.kind == UVM_WRITE) begin
      `uvm_info(get_type_name(), $sformatf( "REG_DEBUG :: REG2BUS Completed WRITE at Address = %0h, Data = %0h", rw.addr, rw.data), UVM_LOW)
    end
    if (rw.kind == UVM_READ) 
      `uvm_info(get_type_name(), $sformatf( "REG_DEBUG :: REG2BUS Completed READ at Address = %0h", rw.addr), UVM_LOW)
    return jtag_1687;
  endfunction

  virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
    cdn_jtag_1687_trans jtag_1687;
    if (!$cast(jtag_1687,bus_item)) begin
      `uvm_fatal("NOT_JTAG_TYPE", "Provided bus_item is not of the correct type")
      return;
    end
    jtag_1687.print();
    rw.kind = (jtag_1687.op == READ_1687) ? UVM_READ : UVM_WRITE;
    rw.addr = jtag_1687.addr;
    rw.data = jtag_1687.data;
    if (rw.kind == UVM_WRITE) begin 
      `uvm_info(get_type_name(), $sformatf( "REG_DEBUG :: BUS2REG Completed WRITE at Address = %0h, Data = %0h", rw.addr, rw.data ), UVM_LOW)
    end
    if (rw.kind == UVM_READ) begin
      `uvm_info(get_type_name(), $sformatf( "REG_DEBUG :: BUS2REG Completed READ at Address = %0h, Data = %0h", rw.addr, rw.data ), UVM_LOW)
    end
    rw.status = UVM_IS_OK;
  endfunction

endclass
