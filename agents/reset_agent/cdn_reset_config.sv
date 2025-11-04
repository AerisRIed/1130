//
// Template for UVM-compliant configuration class
//

`ifndef CDN_RESET_CONFIG__SV
`define CDN_RESET_CONFIG__SV

class cdn_reset_config extends uvm_object; 

   //---------------------------------
   // Member config and interface
   //---------------------------------
   //int lane_num;
   bit dp_enable;
   bit reset_random_control;

   `uvm_object_utils_begin(cdn_reset_config)
	  //`uvm_field_int(lane_num, 	UVM_PRINT)
	  `uvm_field_int(dp_enable, UVM_PRINT)
	  `uvm_field_int(reset_random_control, UVM_PRINT)
   `uvm_object_utils_end

   extern function new(string name = "");
  
endclass: cdn_reset_config

function cdn_reset_config::new(string name = "");
   super.new(name);
endfunction: new

`endif // CDN_RESET_CONFIG__SV
