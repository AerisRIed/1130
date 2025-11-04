//
// Template for UVM-compliant configuration class
//

`ifndef CDN_PHY_DUT_CONFIG__SV
`define CDN_PHY_DUT_CONFIG__SV

class cdn_phy_dut_config extends uvm_object; 

   // Define common configuration parameters
   rand refclk_mode_t           ref_clk_mode;
   rand refclk_mode_t           ref_clk1_mode;
   rand clk_jitter_t            clk_jitter_cfg;
   
   real ref_clk = CLK_100M;                 //19.2M/24M/100M
   real ref_clk1 = CLK_100M;                //19.2M/24M/100M/156.25M
   rand real apb_clk = CLK_200M;            //typical 200M, support up to 400M
   rand real jtag_tck_clk = CLK_100M;       //JTAG TCK 4M~100M
   rand real ijtag1687_tck_clk = CLK_100M;  //iJTAG1687 TCK 4M~100M
   rand real uc_clk = CLK_500M;             //support up to 500M

   reg_interface_t              reg_interface_sel; //reg interface    

   rand flip_flag_t             flip_flag;
   rand init_value_t            init_value_type;

   // Define usb4 configuration parameters
   rand gen_speed_t      usb4_gen_speed;
   rand lane_num_t       usb4_lane_num;

   // Define usb32 configuration parameters
   rand gen_speed_t      usb32_gen_speed;
   rand lane_num_t       usb32_lane_num;

   // Define pcie configuration parameters
   rand gen_speed_t      pcie_gen_speed;
   rand lane_num_t       pcie_lane_num;

   // Define dp configuration parameters
   rand dp_bit_rate_t    dp_data_rate;
   rand lane_num_t       dp_lane_num;
   rand vswing_level_t   dp_vswing_level;
   rand preemph_level_t  dp_preemph_level;
   rand bit flip;
   rand bit pn_swap;

   rand refclk_mode_t           pll0_ref_clk_mode;
   rand refclk_mode_t           pll1_ref_clk_mode;
   rand bit              refclk_dig_sel; // 0 - pma_cmn_refclk0_int, 1 - pma_cmn_refclk1_int
   rand bit [1:0]        refclk_dig_div; // 2’b00 - Divide by 1 (set for reference clock in 19.2MHz or 24MHz)
                                         // 2’b01 - Divide by 2 (Reserved)
                                         // 2’b10 - Divide by 4 (set for 100 MHz reference clock)
                                         // 2’b11 - Divide by 8 (Reserved)
   rand bit [1:0]        pll0_refclk_sel; // 00 = pma_cmn_refclk0_int, 01 = pma_cmn_refclk1_int
   rand bit [1:0]        pll1_refclk_sel; // 00 = pma_cmn_refclk0_int, 01 = pma_cmn_refclk1_int, 10 = from pll0 output

   // ssc enable flag
   rand ssc_flag_t ssc_mode;

   // only valid in alt mode
   std_mode_t            std_mode;
   std_mode_t            alt_mode;
   
  `ifdef CDN_MPPHY_UC_ECC_EN
    string uc_ecc_enable = "YES";
  `else
    string uc_ecc_enable = "NO";
  `endif 


   // Constraints for common variables
   constraint c_ref_clk_mode {
     // TODO waiting for clock design to be determined
     //ref_clk_mode inside {REFCLK_19_2M, REFCLK_24M, REFCLK_100M};
     //(pll1_refclk_sel == 2'b00) -> ref_clk_mode == REFCLK_100M;
     ref_clk_mode == REFCLK_100M;
   }
   constraint c_ref_clk1_mode {
     ref_clk1_mode == REFCLK_100M;
   }
   constraint c_clk_jitter_cfg {
     soft clk_jitter_cfg.jitter_en == 0;
   }
   //30M, 40M, 50M, 100M, 200M, 400M
   constraint c_apb_clk {
     apb_clk  dist { CLK_1M   :=5,
                     CLK_10M  :=5,
                     CLK_30M  :=10,
                     CLK_40M  :=10,
                     CLK_50M  :=10,
                     CLK_100M :=20,
                     CLK_200M :=20,
                     CLK_400M :=20};
   }
   //1M, 2.5M, 4M, 5M, 10M, 20M, 30M, 100M, 200M
   constraint c_jtag_tck {
     jtag_tck_clk  dist { CLK_1M   :=30,
                          CLK_2_5M :=30,
                          CLK_4M   :=20,
                          CLK_5M   :=20,
                          CLK_10M  :=20,
                          CLK_20M  :=5,
                          CLK_30M  :=5,
                          CLK_100M :=5,
                          CLK_200M :=5};
   }

   //1M, 2.5M, 4M, 5M, 10M, 20M, 30M, 100M, 200M
   constraint c_ijtag1687_tck {
     ijtag1687_tck_clk  dist { CLK_1M   :=30,
                               CLK_2_5M :=30,
                               CLK_4M   :=20,
                               CLK_5M   :=20,
                               CLK_10M  :=20,
                               CLK_20M  :=5,
                               CLK_30M  :=5,
                               CLK_100M :=5,
                               CLK_200M :=5};
   }
   //100M, 200M, 400M, 500M
   constraint c_uc_clk {
     //uc_clk  dist {  CLK_100M :=20,
     //                CLK_200M :=20,
     //                CLK_400M :=20,
     //                CLK_500M :=20};
     soft uc_clk == CLK_500M;
   }

   // Constraints for usb4 variables
   constraint c_usb4_gen_speed {
     usb4_gen_speed inside {GEN2_SPEED, GEN3_SPEED};
   }

   constraint c_usb4_lane_num {
     usb4_lane_num inside {LANE_NUM_1, LANE_NUM_2};
   }

   // Constraints for usb32 variables
   constraint c_usb32_gen_speed {
     usb32_gen_speed inside {GEN1_SPEED, GEN2_SPEED};
   }

   constraint c_usb32_lane_num {
     if(std_mode != ALT_MODE) {
       usb32_lane_num inside {LANE_NUM_1, LANE_NUM_2};
     } else {
       usb32_lane_num inside {LANE_NUM_1};
     }
   }

   // Constraints for pcie variables
   constraint c_pcie_gen_speed {
     pcie_gen_speed inside {GEN1_SPEED, GEN2_SPEED, GEN3_SPEED, GEN4_SPEED};
   }

   constraint c_pcie_lane_num {
     pcie_lane_num inside {LANE_NUM_1, LANE_NUM_2};
   }

   // Constraints for dp variables
   constraint c_dp_lane_num {
     if(std_mode != ALT_MODE) {
       dp_lane_num inside {LANE_NUM_1, LANE_NUM_2, LANE_NUM_4};
     } else {
       dp_lane_num inside {LANE_NUM_1, LANE_NUM_2};
     }
   }

   // Constraints for flip_flag
   constraint c_flip_flag {
     soft flip_flag == POSITIVE;
   }

   // Constraints for init_value_type
   constraint c_init_value_type {
     soft init_value_type == ALL_0;
   }

   // Constraints for ref clk pins
   constraint c_refclk_dig_div {
     if(refclk_dig_sel == 0) {
       (ref_clk_mode == REFCLK_19_2M || ref_clk_mode == REFCLK_24M) -> refclk_dig_div == 2'b00;
       (ref_clk_mode == REFCLK_100M)                                -> refclk_dig_div == 2'b10;
     } else {
       (ref_clk1_mode == REFCLK_100M) -> refclk_dig_div == 2'b10;
     }
   }

   constraint c_pll0_refclk_sel {
     pll0_refclk_sel inside {2'b00, 2'b01};
   }

   constraint c_pll1_refclk_sel {
    //pll1_refclk_sel inside {2'b00, 2'b01, 2'b10}; //TODO 10 = from pll0 output, PG cfg not ready for this select
     pll1_refclk_sel inside {2'b00, 2'b01};
   }

   constraint c_pll0_ref_clk_mode {
     (pll0_refclk_sel == 2'b00) -> pll0_ref_clk_mode == ref_clk_mode;
     (pll0_refclk_sel == 2'b01) -> pll0_ref_clk_mode == ref_clk1_mode;
   }

   constraint c_pll1_ref_clk_mode {
     (pll1_refclk_sel == 2'b00) -> pll1_ref_clk_mode == ref_clk_mode;
     (pll1_refclk_sel == 2'b01) -> pll1_ref_clk_mode == ref_clk1_mode;
     (pll1_refclk_sel == 2'b10) -> pll1_ref_clk_mode == ref_clk_mode;
   }

   
   `uvm_object_utils_begin(cdn_phy_dut_config)
      `uvm_field_enum(refclk_mode_t,ref_clk_mode,UVM_ALL_ON) 
      `uvm_field_enum(refclk_mode_t,ref_clk1_mode,UVM_ALL_ON) 
      `uvm_field_int(clk_jitter_cfg.jitter_en,UVM_ALL_ON) 
      `uvm_field_real(ref_clk,UVM_ALL_ON)
      `uvm_field_real(ref_clk1,UVM_ALL_ON)
      `uvm_field_real(apb_clk,UVM_ALL_ON)
      `uvm_field_real(jtag_tck_clk,UVM_ALL_ON)
      `uvm_field_real(ijtag1687_tck_clk,UVM_ALL_ON)
      `uvm_field_real(uc_clk,UVM_ALL_ON)
      `uvm_field_enum(reg_interface_t,reg_interface_sel,UVM_ALL_ON)
      `uvm_field_enum(flip_flag_t,flip_flag,UVM_ALL_ON)
      `uvm_field_enum(init_value_t,init_value_type,UVM_ALL_ON)
      `uvm_field_enum(gen_speed_t,usb4_gen_speed,UVM_ALL_ON)
      `uvm_field_enum(lane_num_t,usb4_lane_num,UVM_ALL_ON)
      `uvm_field_enum(gen_speed_t,usb32_gen_speed,UVM_ALL_ON)
      `uvm_field_enum(lane_num_t,usb32_lane_num,UVM_ALL_ON)
      `uvm_field_enum(gen_speed_t,pcie_gen_speed,UVM_ALL_ON)
      `uvm_field_enum(lane_num_t,pcie_lane_num,UVM_ALL_ON)
      `uvm_field_enum(dp_bit_rate_t,dp_data_rate,UVM_ALL_ON)
      `uvm_field_enum(lane_num_t,dp_lane_num,UVM_ALL_ON)
      `uvm_field_enum(vswing_level_t,dp_vswing_level,UVM_ALL_ON)
      `uvm_field_enum(preemph_level_t,dp_preemph_level,UVM_ALL_ON)
      `uvm_field_enum(ssc_flag_t,ssc_mode,UVM_ALL_ON)
      `uvm_field_enum(std_mode_t,std_mode,UVM_ALL_ON)
      `uvm_field_enum(std_mode_t,alt_mode,UVM_ALL_ON)
      `uvm_field_int(refclk_dig_sel,UVM_ALL_ON)
      `uvm_field_int(refclk_dig_div,UVM_ALL_ON)
      `uvm_field_int(pll0_refclk_sel,UVM_ALL_ON)
      `uvm_field_int(pll1_refclk_sel,UVM_ALL_ON)
      `uvm_field_enum(refclk_mode_t,pll0_ref_clk_mode,UVM_ALL_ON) 
      `uvm_field_enum(refclk_mode_t,pll1_ref_clk_mode,UVM_ALL_ON)

      // ToDo: add properties using macros here

   `uvm_object_utils_end

   // Functions and tasks
   extern function new(string name = "");
   extern function void set_ref_clk(refclk_mode_t ref_clk_mode, refclk_mode_t ref_clk1_mode);
   extern function void get_cmd_args_cfg();
  
endclass: cdn_phy_dut_config

function cdn_phy_dut_config::new(string name = "");
   super.new(name);
   reg_interface_sel = APB;
endfunction: new

function void cdn_phy_dut_config::set_ref_clk(refclk_mode_t ref_clk_mode, refclk_mode_t ref_clk1_mode);
  case(ref_clk_mode)
    REFCLK_19_2M : begin
      ref_clk = CLK_19_2M;
    end
    REFCLK_24M :   begin
      ref_clk = CLK_24M;
    end
    REFCLK_100M :  begin
      ref_clk = CLK_100M;
    end
    default : begin
      ref_clk = CLK_19_2M;
      `uvm_error(get_type_name(),"set_ref_clk0 error: invalid ref clk mode")
    end
  endcase

  case(ref_clk1_mode)
    //REFCLK_19_2M : begin
    //  ref_clk1 = CLK_19_2M;
    //end
    //REFCLK_24M :   begin
    //  ref_clk1 = CLK_24M;
    //end
    REFCLK_100M :  begin
      ref_clk1 = CLK_100M;
    end
    //REFCLK_156_25M :  begin
    //  ref_clk1 = CLK_156_25M;
    //end
    default : begin
      ref_clk1 = CLK_100M;
      `uvm_error(get_type_name(),"set_ref_clk1 error: invalid ref clk mode")
    end
  endcase
endfunction // set_ref_clk

function void cdn_phy_dut_config::get_cmd_args_cfg();
  uvm_cmdline_processor clp;
  string arg_values[$];
  
  if (!uvm_config_db#(bit)::get(null, "", "flip_mode", flip)) begin
    `uvm_fatal(get_type_name(), "flip not get")
  end
  if (!uvm_config_db#(bit)::get(null, "", "pn_swap", pn_swap)) begin
    `uvm_fatal(get_type_name(), "pn_swap not get")
  end
  
  if(flip)  
      flip_flag = NEGATIVE;
  else
      flip_flag = POSITIVE;

  clp = uvm_cmdline_processor::get_inst();

  // get usb4 speed
  if (clp.get_arg_values("+USB4_SPEED=", arg_values)) begin
    foreach(arg_values[i]) begin
      case(arg_values[i])
      "USB4_GEN2": usb4_gen_speed = GEN2_SPEED;
      "USB4_GEN3": usb4_gen_speed = GEN3_SPEED;
      default: begin
        `uvm_fatal(get_full_name(), "USB4 speed is invalid")
      end
      endcase
      `uvm_info(get_full_name(), $sformatf("USB4 speed is set to %s", arg_values[i]), UVM_LOW);
    end
  end else begin
    `uvm_info(get_full_name(), $sformatf("USB4 speed is randomized to %s", usb4_gen_speed.name()), UVM_LOW);
  end

  // get usb32 speed
  if (clp.get_arg_values("+USB32_SPEED=", arg_values)) begin
    foreach(arg_values[i]) begin
      case(arg_values[i])
      "USB32_GEN1": usb32_gen_speed = GEN1_SPEED;
      "USB32_GEN2": usb32_gen_speed = GEN2_SPEED;
      default: begin
        `uvm_fatal(get_full_name(), "USB32 speed is invalid")
      end
      endcase
      `uvm_info(get_full_name(), $sformatf("USB32 speed is set to %s", arg_values[i]), UVM_LOW);
    end
  end else begin
    `uvm_info(get_full_name(), $sformatf("USB32 speed is randomized to %s", usb32_gen_speed.name()), UVM_LOW);
  end

  // get pcie speed
  if (clp.get_arg_values("+PCIE_SPEED=", arg_values)) begin
    foreach(arg_values[i]) begin
      case(arg_values[i])
      "PCIE_GEN1": pcie_gen_speed = GEN1_SPEED;
      "PCIE_GEN2": pcie_gen_speed = GEN2_SPEED;
      "PCIE_GEN3": pcie_gen_speed = GEN3_SPEED;
      "PCIE_GEN4": pcie_gen_speed = GEN4_SPEED;
      default: begin
        `uvm_fatal(get_full_name(), "PCIE speed is invalid")
      end
      endcase
      `uvm_info(get_full_name(), $sformatf("PCIE speed is set to %s", arg_values[i]), UVM_LOW);
    end
  end else begin
    `uvm_info(get_full_name(), $sformatf("PCIE speed is randomized to %s", pcie_gen_speed.name()), UVM_LOW);
  end

  // get dp speed
  if (clp.get_arg_values("+DP_SPEED=", arg_values)) begin
    foreach(arg_values[i]) begin
      case(arg_values[i])
      "RBR":      dp_data_rate = DP_RBR;
      "HBR":      dp_data_rate = DP_HBR;
      "HBR2":     dp_data_rate = DP_HBR2;
      "HBR3":     dp_data_rate = DP_HBR3;
      "UHBR10":   dp_data_rate = DP_UHBR10;
      "UHBR13P5": dp_data_rate = DP_UHBR13P5;
      "UHBR20":   dp_data_rate = DP_UHBR20;
      default: begin
        `uvm_fatal(get_full_name(), "DP speed is invalid")
      end
      endcase
      `uvm_info(get_full_name(), $sformatf("DP speed is set to %s", arg_values[i]), UVM_LOW);
    end
  end else begin
    `uvm_info(get_full_name(), $sformatf("DP speed is randomized to %s", dp_data_rate.name()), UVM_LOW);
  end
endfunction: get_cmd_args_cfg


`endif // CDN_PHY_DUT_CONFIG__SV
