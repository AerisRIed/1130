class cdn_u4_pcie_port_configuration extends uvm_object;
    //---------------------------------------
    // Member
	component_type_enum port_mode;
    bit pcie_gen1 = 1;
    bit pcie_gen2 = 0;
    bit pcie_gen3 = 0;
    bit pcie_gen4 = 0;
	bit polarity_invert = 0;
	bit scramble_en;
	int byte_num_in_block = 16;
    bit big_endian;
    bit SerdesArch = 0;
    int skp_insert_period_gen12_nonl0 = 154;
    int skp_insert_period_gen12_l0 = 1180;
    int skp_insert_period_gen34_nonl0 = 38;
    int skp_insert_period_gen34_l0 = 370;
    int block_rst_num = 4;
    //---------------------------------------
    // Factory
    //---------------------------------------
    `uvm_object_param_utils_begin(cdn_u4_pcie_port_configuration)
	  `uvm_field_int(pcie_gen1, 					UVM_PRINT)
	  `uvm_field_int(pcie_gen2, 					UVM_PRINT)
	  `uvm_field_int(pcie_gen3, 					UVM_PRINT)
	  `uvm_field_int(pcie_gen4, 					UVM_PRINT)
	  `uvm_field_int(polarity_invert, 				UVM_PRINT)
	  `uvm_field_int(scramble_en, 					UVM_PRINT)
	  `uvm_field_int(byte_num_in_block, 			UVM_PRINT)
	  `uvm_field_int(big_endian, 					UVM_PRINT)
	  `uvm_field_int(SerdesArch, 					UVM_PRINT)
	  `uvm_field_int(skp_insert_period_gen12_nonl0, UVM_PRINT)
	  `uvm_field_int(skp_insert_period_gen12_l0, 	UVM_PRINT)
	  `uvm_field_int(skp_insert_period_gen34_nonl0, UVM_PRINT)
	  `uvm_field_int(skp_insert_period_gen34_l0, 	UVM_PRINT)
    `uvm_object_utils_end

    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "cdn_u4_pcie_port_configuration");
      super.new(name);
    endfunction : new
endclass 
