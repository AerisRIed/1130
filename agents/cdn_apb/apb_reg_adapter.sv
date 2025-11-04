// UVM_REG Adaptor class

class apb_reg_adapter extends uvm_reg_adapter;
	`uvm_object_utils(apb_reg_adapter)

	integer data_size;
	function new(string name = "apb_reg_adapter");
	  super.new(name);
	  provides_responses=1; // driver provides separate response items 
	endfunction

	virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
		denaliCdn_apbTransaction apb = denaliCdn_apbTransaction::type_id::create("apb");
		apb.Direction = (rw.kind == UVM_READ) ? DENALI_CDN_APB_DIRECTION_READ : DENALI_CDN_APB_DIRECTION_WRITE;
		apb.Addr= rw.addr; //reg address becomes the first address of the transfer
		apb.Data = rw.data;//{rw.data[7:0],rw.data[15:8],rw.data[23:16],rw.data[31:24]};
        apb.PortNum = 0;
		apb.Callback = DENALI_CDN_APB_CB_TOTAL;
      	if (rw.kind == UVM_WRITE) begin
      	 	`uvm_info(get_type_name(), $sformatf( "REG_DEBUG :: REG2BUS Completed WRITE at Address = %0h with Data = %0h", rw.addr,rw.data), UVM_LOW)
		end
      	if (rw.kind == UVM_READ) 
      	 	`uvm_info(get_type_name(), $sformatf( "REG_DEBUG :: REG2BUS Completed READ at Address = %0h", rw.addr), UVM_LOW)
      	 	
		return apb;
	endfunction

	virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
		denaliCdn_apbTransaction apb = denaliCdn_apbTransaction::type_id::create("apb");
		if (!$cast(apb,bus_item)) begin
			`uvm_fatal("NOT_APB_TYPE", "Provided bus_item is not of the correct type")
			return;
		end
		rw.kind = (apb.Direction == DENALI_CDN_APB_DIRECTION_READ) ? UVM_READ : UVM_WRITE;
		rw.addr = apb.Addr;
		rw.data = apb.Data;
      	if (rw.kind == UVM_READ) begin
          if ((|apb.DataXMask) || (|apb.DataZMask)) 
      	    `uvm_error(get_type_name(), $sformatf( "REG_DEBUG :: BUS2REG READ Data has X/Z state in Address = %0h with DataXMask = %0h, DataZMask = %0h",rw.addr,apb.DataXMask,apb.DataZMask))
      	  else
            `uvm_info(get_type_name(), $sformatf( "REG_DEBUG :: BUS2REG Completed READ with Data = %0h", rw.data), UVM_LOW)
		end
		rw.status = UVM_IS_OK;
	endfunction

endclass
