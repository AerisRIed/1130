//
// Template for UVM-compliant configuration class
//

`ifndef CDN_PHY_TB_CONFIG__SV
`define CDN_PHY_TB_CONFIG__SV

class cdn_phy_tb_config extends uvm_object; 

   // Define test configuration parameters (e.g. how long to run)
   rand int            run_sim_timeout; // unit is 1ms 
   bit                 b2b_dut;
   bit                 random_interval;
   assert_flag_t       assert_flag;
   bit                 data_error_inject;
   compare_flag_t      compare_flag;
   bit                 jtag_use_flag;
   bit                 fw_writes_pg; // 1: fw write pg 0: tb write pg
   bit                 load_fw_via_apb;  // 1: front-door  0: back door
   std_mode_t          std_mode;
   component_type_enum port_mode;
   bit 				   reset_random_control;
   //rand int 		   lane_num;
   // ToDo: Add other environment configuration varaibles

   // speedup configure flag
   rand speedup_config_t speedup_cfg;

   // Constraints
   constraint c_run_sim_timeout {
      soft run_sim_timeout == 10;
   }

   constraint c_jtag_use {
      soft jtag_use_flag == 0 ;
   }

   constraint c_uc_laod_fw {
      soft load_fw_via_apb   == 0;
   }
   
   constraint c_fw_wr_pg {
      soft fw_writes_pg == 0;
   }


   // TODO  speedup cfg --  PMA cal register
   constraint c_speedup_cfg {
      soft  speedup_cfg == SPEEDUP_CONFIG_DISABLE;
   }


   // ToDo: Add constraint blocks to prevent error injection

   `uvm_object_utils_begin(cdn_phy_tb_config)
      `uvm_field_int(run_sim_timeout,UVM_ALL_ON) 
      `uvm_field_int(b2b_dut,UVM_ALL_ON) 
      `uvm_field_int(random_interval,UVM_ALL_ON) 
      `uvm_field_enum(assert_flag_t,assert_flag,UVM_ALL_ON) 
      `uvm_field_int(data_error_inject,UVM_ALL_ON) 
      `uvm_field_enum(compare_flag_t,compare_flag,UVM_ALL_ON)  
      `uvm_field_enum(std_mode_t,std_mode,UVM_ALL_ON)
      `uvm_field_int(reset_random_control,UVM_ALL_ON)
      //`uvm_field_int(lane_num,UVM_ALL_ON)
      `uvm_field_enum(component_type_enum,port_mode,UVM_ALL_ON) 
      `uvm_field_int(jtag_use_flag,UVM_ALL_ON)
      `uvm_field_int(load_fw_via_apb,UVM_ALL_ON)
      `uvm_field_int(fw_writes_pg,UVM_ALL_ON)
      `uvm_field_enum(speedup_config_t,speedup_cfg,UVM_ALL_ON)
      // ToDo: add properties using macros here

   `uvm_object_utils_end

   extern function new(string name = "");
  
endclass: cdn_phy_tb_config

function cdn_phy_tb_config::new(string name = "");
   super.new(name);

`ifdef B2B_MODE
   b2b_dut = 1;
`else
   b2b_dut = 0;
`endif
endfunction: new


`endif // CDN_PHY_TB_CONFIG__SV
