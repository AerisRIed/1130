   // Get the shadow register value. This is actually the "desired" value, not the "mirrored" value...
  virtual function uvm_reg_data_t read_shadow_register(string regname);
    uvm_reg            reg_handle;

    reg_handle = get_reg_by_name(regname);
    if (reg_handle == null) begin
      `uvm_error(get_type_name(), $psprintf("read_shadow_register: Unknown register [%s]", regname))
      return(`UVM_REG_DATA_WIDTH'h0);
    end
    else begin
      return(reg_handle.get());
    end
  endfunction // read_shadow_register

   // Set the desired field value. This is actually the "desired" value, not the "mirrored" value,
  // and will not update DUT until update() is called
  virtual task set_field(string fieldname, uvm_reg_data_t value);
    uvm_reg_field      field_handle;

    //reg_access_mbx.get(reg_access_mbx_value);

    field_handle = get_field_by_name(fieldname);
    if (field_handle == null) begin
      `uvm_error(get_type_name(), $psprintf("set_field: Unknown field [%s]", fieldname))
    end
    else if (value >= 2**(field_handle.get_n_bits())) begin
      `uvm_error(get_type_name(), $psprintf("set_field for field [%s]: Value 0x%0h higher than maximum allowed value 0x%0h", fieldname, value, (2**field_handle.get_n_bits()-1)))
    end    
    else begin
      field_handle.set(value);
    end
    pending_update = 1;

    //void'(reg_access_mbx.try_put(1));

  endtask // set_field

   virtual task read_dut_register(input string regname, output uvm_reg_data_t rdata, input bit concurrent=0);
    uvm_status_e       status;

    //if (!concurrent) reg_access_mbx.get(reg_access_mbx_value);

    if (di_control_write) begin
      wait (di_control_write==0);
    end

    read_reg_by_name(status, regname, rdata);

    if (status != UVM_IS_OK) begin
      `uvm_error(get_type_name(), $psprintf("read_dut_register: Register read failed on [%s] (may contain Xs)", regname))
    end

    //if (!concurrent) void'(reg_access_mbx.try_put(1));

  endtask // read_dut_register

  // Returns an error if it fails - if you don't want this use the function directly!
  virtual task write_dut_register(string regname, uvm_reg_data_t wdata);
    uvm_status_e       status;
    `uvm_info(get_type_name(), $psprintf("start write reg by name"),UVM_DEBUG)

    //reg_access_mbx.get(reg_access_mbx_value);
    //`uvm_info(get_type_name(), $psprintf("get reg_access_mbx_value %d",reg_access_mbx_value),UVM_LOW)

    if (regname == "di_control") begin
      di_control_write = 1;
      if (try_read_in_progress) begin
        wait (try_read_in_progress==0);
      end
    end
    `uvm_info(get_type_name(), $psprintf("start write reg"),UVM_DEBUG)
    write_reg_by_name(status, regname, wdata);
    `uvm_info(get_type_name(), $psprintf("complete write reg"),UVM_DEBUG)

    if (status != UVM_IS_OK) begin
      `uvm_error(get_type_name(), $psprintf("write_dut_register: Register write failed on [%s] (may contain Xs)", regname))
    end

    if (regname == "di_control") begin
      di_control_write = 0;
    end

    //void'(reg_access_mbx.try_put(1));

  endtask // write_dut_register
  
  virtual task write_dut_field(string fieldname, uvm_reg_data_t value);
   uvm_reg_field target_field;
   uvm_status_e status;
   uvm_reg target_reg;
   uvm_reg_block regmodel;
   uvm_reg_data_t current_mirror;
   uvm_reg_data_t new_value;
   bit is_write =1 ;
//   // 1. Retrieve top-level register model 
//   if (!uvm_config_db#(uvm_reg_block)::get(null, "", "regmodel_eusb2v2_tc", regmodel)) begin
//       `uvm_error("REG_ACCESS", "Register model not found in config DB")
//       return;
//   end
   target_field = get_field_by_name(fieldname);
    if (target_field == null) begin
      `uvm_error(get_type_name(), $psprintf("set_field: Unknown field [%s]", fieldname))
      return;
    end
    
//   // 2. Locate register field by name within the block
//   if (!regmodel.get_field_by_name(fieldname, target_field)) begin
//       `uvm_error("REG_ACCESS", $sformatf("Field '%s' not found in register model", fieldname))
//       return;
//   end
   // 3. Get parent register of the target field
   target_reg = target_field.get_parent();
   if (target_reg == null) begin
       `uvm_error("REG_ACCESS", $sformatf("Parent register for field '%s' is null", fieldname))
       return;
   end
   current_mirror = target_reg.get_mirrored_value();
   // 3. Modify field value
   target_field.set(value);                // update mirror vaule
   new_value = target_reg.get();
   // 4. Execute frontdoor access operation
   if (is_write) begin
       // Write operation: Update desired value and drive to DUT via physical bus
       target_reg.write(.status(status), .value(new_value), .path(UVM_FRONTDOOR));
       `uvm_info("REG_ACCESS", $sformatf("Write field '%s': value=0x%0h, status=%s",
                fieldname, value, status.name()), UVM_DEBUG)
   end else begin
       // Read operation: Capture hardware value via bus and update mirror
       target_reg.read(.status(status), .value(value), .path(UVM_FRONTDOOR));
       `uvm_info("REG_ACCESS", $sformatf("Read field '%s': value=0x%0h, status=%s",
                fieldname, value, status.name()), UVM_MEDIUM)
   end
  endtask // write_dut_field


  virtual task write_dut_addr(uvm_reg_addr_t addr, uvm_reg_data_t value);
   uvm_reg_field target_field;
   uvm_status_e status;
   uvm_reg target_reg;
   uvm_reg_block regmodel;
   uvm_reg_data_t current_mirror;
   uvm_reg_data_t new_value;
   bit is_write =1 ;

   // 3. Get parent register of the target field
   target_reg = default_map.get_reg_by_offset(addr);
   if (target_reg == null) begin
       `uvm_info("REG_ACCESS", $sformatf("Parent register for addr '%h' is null", addr),UVM_HIGH)
       return;
   end

   // 4. Execute frontdoor access operation
   if (is_write) begin
       // Write operation: Update desired value and drive to DUT via physical bus
       target_reg.write(.status(status), .value(value), .path(UVM_FRONTDOOR));
       `uvm_info("REG_ACCESS", $sformatf("Write  addr %h: value=0x%0h, status=%s",
                addr, value, status.name()), UVM_DEBUG)
   end else begin
       // Read operation: Capture hardware value via bus and update mirror
       target_reg.read(.status(status), .value(value), .path(UVM_FRONTDOOR));
       `uvm_info("REG_ACCESS", $sformatf("Read addr %h : value=0x%0h, status=%s",
                addr, value, status.name()), UVM_MEDIUM)
   end
  endtask // write_dut_addr



  virtual task read_dut_addr(uvm_reg_addr_t addr, uvm_reg_data_t value);
   uvm_reg_field target_field;
   uvm_status_e status;
   uvm_reg target_reg;
   uvm_reg_block regmodel;
   uvm_reg_data_t current_mirror;
   uvm_reg_data_t new_value;
   bit is_write =0 ;

   // 3. Get parent register of the target field
   target_reg = default_map.get_reg_by_offset(addr);
   if (target_reg == null) begin
       `uvm_info("REG_ACCESS", $sformatf("Parent register for field '%h' is null", addr),UVM_HIGH)
       return;
   end

   // 4. Execute frontdoor access operation
   if (is_write) begin
       // Write operation: Update desired value and drive to DUT via physical bus
       target_reg.write(.status(status), .value(value), .path(UVM_FRONTDOOR));
       `uvm_info("REG_ACCESS", $sformatf("Write addr %h : value=0x%0h, status=%s",
                addr, value, status.name()), UVM_DEBUG)
   end else begin
       // Read operation: Capture hardware value via bus and update mirror
       target_reg.read(.status(status), .value(value), .path(UVM_FRONTDOOR));
       `uvm_info("REG_ACCESS", $sformatf("Read addr %h: value=0x%0h, status=%s",
                addr, value, status.name()), UVM_DEBUG)
   end
  endtask // read_dut_addr

  // virtual task write_dut_field(string fieldname, uvm_reg_data_t value);
  //  uvm_reg_field      field_handle;
  //  uvm_status_e       status;
  //  //reg_access_mbx.get(reg_access_mbx_value);
  //  uvm_reg_addr_t reg_addr;
  //  field_handle = get_field_by_name(fieldname);
  //  if (field_handle == null) begin
  //    `uvm_error(get_type_name(), $psprintf("write_field: Unknown field [%s]", fieldname))
  //  end
  //  else if (value >= 2**(field_handle.get_n_bits())) begin
  //    `uvm_error(get_type_name(), $psprintf("write_field for field [%s]: Value 0x%0h higher than maximum allowed value 0x%0h", fieldname, value, (2**field_handle.get_n_bits()-1)))
  //  end    
  //  else begin
  //    this.update(status);
  //    set_field(fieldname,value);
  //    this.update(status);

  //  end

  //endtask // write_dut_field

 virtual task read_dut_field(input string fieldname, output uvm_reg_data_t rdata, input bit concurrent=0);
    uvm_status_e       status;
    uvm_reg_field      field_handle;
    bit[7:0]	       lsb_pos;
    bit[7:0]	       fld_width;
    bit[31:0]          mask;	
    //if (!concurrent) reg_access_mbx.get(reg_access_mbx_value);
    field_handle = get_field_by_name(fieldname);
    if (field_handle == null) begin
      `uvm_error(get_type_name(), $psprintf("set_field: Unknown field [%s]", fieldname))
    end
    else begin
    //this.update(status);
    field_handle.get_parent().read(status,rdata);//reg_block.read
    lsb_pos = field_handle.get_lsb_pos();
    fld_width = field_handle.get_n_bits();
    `uvm_info(get_type_name(), $psprintf("lsb_pos = %0h",lsb_pos), UVM_DEBUG)
    `uvm_info(get_type_name(), $psprintf("fld_width = %0h",fld_width), UVM_DEBUG)
    mask = ((2**fld_width)-1) << lsb_pos;//2^fld_width-1
    rdata = (rdata & mask) >> lsb_pos;
    `uvm_info(get_type_name(), $psprintf("Value of register field %s is = %0h",fieldname,rdata), UVM_LOW)
    end

    if (status != UVM_IS_OK) begin
      `uvm_error(get_type_name(), $psprintf("read_dut_field: Register read failed on [%s] (may contain Xs)", fieldname))
    end

    //if (!concurrent) void'(reg_access_mbx.try_put(1));

  endtask // read_dut_field

  virtual function void disable_register_compare(uvm_reg register);
    uvm_reg_field       fields[$];

    register.get_fields(fields);
    foreach (fields[i]) begin
      fields[i].set_compare(UVM_NO_CHECK);
    end
  endfunction // disable_register_compare

   //This function used to disable the whole register compare 
  virtual function void disable_register_compare_by_name(string regname);

    uvm_reg_field       fields[$];
    uvm_reg             register;
    register = get_reg_by_name(regname);
    if(register == null) 
    `uvm_error(get_type_name(), $psprintf("disable_register_compare_by_name: Unknown regname [%s]", regname))
    register.get_fields(fields);
    foreach (fields[i]) begin
      fields[i].set_compare(UVM_NO_CHECK);
    end


  endfunction//disable_register_compare

   //This function used to enable the whole register compare 
  virtual function void enable_register_compare_by_name(string regname);

    uvm_reg_field       fields[$];
    uvm_reg             register;
    register = get_reg_by_name(regname);
    if(register == null) 
    `uvm_error(get_type_name(), $psprintf("enable_register_compare_by_name: Unknown regname [%s]", regname))
    register.get_fields(fields);
    foreach (fields[i]) begin
      fields[i].set_compare(UVM_CHECK);
    end


  endfunction//disable_register_compare


  // This function disables compare on a single field
  virtual function void disable_field_compare_by_name(string fieldname);
    uvm_reg_field      field_handle;

    field_handle = get_field_by_name(fieldname);
    if (field_handle == null) begin
      `uvm_error(get_type_name(), $psprintf("disable_field_compare_by_name: Unknown field [%s]", fieldname))
    end
    else begin
      field_handle.set_compare(UVM_NO_CHECK);
    end
  endfunction // disable_field_compare_by_name

    // This function enable compare on all fields of a register
  virtual function void enable_register_compare(uvm_reg register);
    uvm_reg_field       fields[$];

    register.get_fields(fields);
    foreach (fields[i]) begin
      fields[i].set_compare(UVM_CHECK);
    end
  endfunction // enable_register_compare

  // This function enable compare on a single field
  virtual function void enable_field_compare_by_name(string fieldname);
    uvm_reg_field      field_handle;

    field_handle = get_field_by_name(fieldname);
    if (field_handle == null) begin
      `uvm_error(get_type_name(), $psprintf("enable_field_compare_by_name: Unknown field [%s]", fieldname))
    end
    else begin
      field_handle.set_compare(UVM_CHECK);
    end
  endfunction // enable_field_compare_by_name

  virtual task update_registers();
    uvm_status_e status;
    uvm_reg reg_list[$];
    //reg_access_mbx.get(reg_access_mbx_value);

    // We have to update di_control register first
    // to have stable value of di_type field (FLASHPL-6057)
    this.get_registers(reg_list, UVM_HIER);
    for (int i=0; i<reg_list.size(); i++) begin
      if (reg_list[i].get_name() == "di_control" && reg_list[i].needs_update()) begin
        di_control_write = 1;
        if (try_read_in_progress) begin
          wait (try_read_in_progress==0);
        end
        reg_list[i].update(status);
        if (status != UVM_IS_OK) begin
          `uvm_fatal(get_type_name(), $psprintf("Problem programming registers via UVMREG"))
        end
        di_control_write = 0;
      end
    end
    if (concurrent_reg) begin
      update_regblock_concurrent();
    end
    else begin
      this.update(status);
      if (status != UVM_IS_OK) begin
        `uvm_fatal(get_type_name(), $psprintf("Problem programming registers via UVMREG"))
      end
    end

    //void'(reg_access_mbx.try_put(1));
    pending_update = 0;

  endtask // update_registers

  virtual function void set_dut_register(string regname, uvm_reg_data_t wdata);
    uvm_reg set_reg;
    set_reg = get_reg_by_name(regname);
    set_reg.set(wdata);
  endfunction // set_dut_register

  virtual function uvm_reg_data_t read_shadow_field(string fieldname);
    uvm_reg_field      field_handle;

    field_handle = get_field_by_name(fieldname);
    if (field_handle == null) begin
      `uvm_error(get_type_name(), $psprintf("read_shadow_field: Unknown field [%s]", fieldname))
      return(`UVM_REG_DATA_WIDTH'h0);
    end
    else begin
      return(field_handle.get());
    end
  endfunction // read_shadow_field

  virtual task automatic update_regblock_concurrent();
    uvm_reg reg_list[$];

    fork
      begin
        this.get_registers(reg_list, UVM_HIER);
        for (int i=0; i<reg_list.size(); i++) begin
          fork
            int index = i;
            begin
              uvm_status_e status;
              uvm_reg rg = reg_list[index];
              if (rg.needs_update()) begin
                rg.update(status);
                if (status != UVM_IS_OK && status != UVM_HAS_X) begin
                  `uvm_error("RegModel", $sformatf("Register \"%s\" could not be updated",
                                                    rg.get_full_name()));
                end
              end
            end
          join_none
        end
        wait fork;
      end
    join

  endtask


