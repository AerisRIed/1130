//
// Template for UVM-compliant configuration class
//

`ifndef CDN_U4_PCIE_CONFIG__SV
`define CDN_U4_PCIE_CONFIG__SV

class cdn_u4_pcie_config extends cdn_phy_config_base; 

   //---------------------------------
   // Member config and interface
   //---------------------------------
   int byte_num_in_block = 16;
   bit SerdesArch = 0;

   //gen_speed_t      gen_speed;
   rand data_width_t     data_width;
   //rand lane_num_t       lane_num;

   rand bit polarity_invert[tb_param :: PCIE_LANE_NUM];  //1:invert 0:normal
   rand bit scramble_en;
   rand bit big_endian;
   rand int skp_insert_period_gen12_nonl0;
   rand int skp_insert_period_gen12_l0;
   rand int skp_insert_period_gen34_nonl0;
   rand int skp_insert_period_gen34_l0;
   rand int sync_com_num;
   rand int eieos_transmit_interval;
   rand bit[22:0] lfsr23_initial;
   //rand bit gen2_eieos_last_symbol_scramble_en;

   // ToDo: Add other environment configuration varaibles

//   constraint speed_c {
//	 soft gen_speed == GEN1_SPEED;
//	}
   constraint data_width_c {
     soft data_width == DATA_WIDTH_32;
   }
   //constraint lane_num_c {
   //  soft lane_num == LANE_NUM_1;
   //}
   constraint port_mode_c {
     soft port_mode inside {HOST,DEVICE};
   }
   constraint parity_invert_c {
     //soft polarity_invert == 0;
   }
   constraint scramble_en_c {
     soft scramble_en == 1;
	 //scramble_en == 0 -> gen2_eieos_last_symbol_scramble_en == 0;
	 //gen2_eieos_last_symbol_scramble_en == 0;
   }
   constraint big_endian_c {
     soft big_endian == 0;
   }
   constraint skp_invert_c {
     skp_insert_period_gen12_nonl0 dist {[16:50]:=1,[51:154-1]:=1,154:=2}; //max=154 symbol
     skp_insert_period_gen12_l0 dist {1180:=1,[1181:1538+4096+28-1]:=1,1538+4096+28:=2}; //MAX_PAYLOAD_LENGTH=4096symbol  overhead=28symbol
     skp_insert_period_gen34_nonl0 dist {[1:20]:=1,[21:38-1]:=1,38:=2}; // max=38 blocks
     skp_insert_period_gen34_l0 dist {370:=1,[371:375+256-1]:=1,375+256:=2};  //[370:375] blocks, MAX_PAYLOAD_LENGTH=4096BYTE = 256 BLOCKS
   }
   constraint sync_com_num_c {
	 soft sync_com_num == 3;
	}
   constraint eieos_transmit_interval_c {
	 soft eieos_transmit_interval dist {20:=1,[21:31]:=1,32:=3,[33:50]:=1};
	}
   constraint lfsr23_initial_c {
	 lfsr23_initial inside {23'h1DBFBC,23'h0607BB,23'h1EC760,23'h18C0DB,23'h010F12,23'h19CFC9,23'h0277CE,23'h1BB807};
	}
   // ToDo: Add constraint blocks to prevent error injection

   `uvm_object_utils_begin(cdn_u4_pcie_config)
      //`uvm_field_enum(gen_speed_t,gen_speed,UVM_ALL_ON) 
      `uvm_field_enum(data_width_t,data_width,UVM_ALL_ON) 
      //`uvm_field_enum(lane_num_t,lane_num,UVM_ALL_ON) 
	  `uvm_field_sarray_int(polarity_invert, 				UVM_PRINT)
	  `uvm_field_int(scramble_en, 					UVM_PRINT)
	  `uvm_field_int(byte_num_in_block, 			UVM_PRINT)
	  `uvm_field_int(big_endian, 					UVM_PRINT)
	  `uvm_field_int(SerdesArch, 					UVM_PRINT)
	  `uvm_field_int(skp_insert_period_gen12_nonl0, UVM_PRINT)
	  `uvm_field_int(skp_insert_period_gen12_l0, 	UVM_PRINT)
	  `uvm_field_int(skp_insert_period_gen34_nonl0, UVM_PRINT)
	  `uvm_field_int(skp_insert_period_gen34_l0, 	UVM_PRINT)
	  `uvm_field_int(sync_com_num, 	UVM_PRINT)
	  `uvm_field_int(eieos_transmit_interval, 	UVM_PRINT)
	  `uvm_field_int(lfsr23_initial, 	UVM_PRINT)

      // ToDo: add properties using macros here

   `uvm_object_utils_end

   extern function new(string name = "");
  
endclass: cdn_u4_pcie_config

function cdn_u4_pcie_config::new(string name = "");
   //string arg_value[$];
   //uvm_cmdline_processor clp;
   super.new(name);

   //clp = uvm_cmdline_processor::get_inst();
   //if (clp.get_arg_values("+PCIE_SPEED=", arg_value)) begin
   //   case(arg_value[0])
   //   "PCIE_GEN1":  this.gen_speed = GEN1_SPEED;
   //   "PCIE_GEN2":  this.gen_speed = GEN2_SPEED;
   //   "PCIE_GEN3":  this.gen_speed = GEN3_SPEED;
   //   "PCIE_GEN4":  this.gen_speed = GEN4_SPEED;
   //   default: `uvm_fatal("", "speed is invalid")
   //   endcase
   //   `uvm_info("", $sformatf("speed is set to %s", arg_value[0]), UVM_LOW);
   //end else begin
   //  `uvm_fatal("", "speed is not set")
   //end
endfunction: new

`endif // CDN_U4_PCIE_CONFIG__SV
