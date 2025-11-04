//
// Template for UVM-compliant testcase

`ifndef TEST__SV
`define TEST__SV

class cdn_phy_test_base extends uvm_test;

  //---------------------------------------------
  // Member configs
  //---------------------------------------------
  cdn_phy_tb_config   tb_cfg;
  cdn_phy_dut_config  dut_cfg;
  cdn_phy_dut_config  device_dut_cfg;

  `uvm_component_utils(cdn_phy_test_base)

  //---------------------------------------------
  // Member clk components
  //---------------------------------------------
  clk_sqr_t           m_clk_sqr;
  clk_seq_t           m_clk_seq;
  
  //---------------------------------------------
  // UVM functions and tasks
  //---------------------------------------------
  extern function new(string name, uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual task configure_phase(uvm_phase phase);
  extern virtual task main_phase(uvm_phase phase);

  //---------------------------------------------
  // User functions and tasks
  //---------------------------------------------
  extern virtual task dyn_main_phase();
  extern virtual function void get_cmd_args();
  extern virtual function void reconfig_dut_cfg();
  extern virtual function void set_type_override();
  extern virtual function void randomise_config();
  extern virtual function void set_clks();
  extern virtual function void report_phy_cfg();
  extern virtual function void print_cfgs();
  extern virtual task gen_pclk();
  extern virtual task gen_ref_clk();
  extern virtual task gen_ref_clk1();
  extern virtual task gen_apb_clk();
  extern virtual task gen_jtag_clk();
  extern virtual task gen_ijtag1687_clk();
  extern virtual task gen_uc_clk();
  extern virtual task gen_clks();

endclass : cdn_phy_test_base

function cdn_phy_test_base::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void cdn_phy_test_base::build_phase(uvm_phase phase);
  super.build_phase(phase);
  uvm_root::get().set_timeout(20ms);//TB timeout
  // create configs
  tb_cfg = cdn_phy_tb_config::type_id::create("tb_cfg");
  dut_cfg = cdn_phy_dut_config::type_id::create("dut_cfg");
  device_dut_cfg = cdn_phy_dut_config::type_id::create("device_dut_cfg");

  // get cmdline args
  get_cmd_args();

  // set component type override
  //set_type_override();

  // clk sequence
  m_clk_seq = clk_seq_t::type_id::create("m_clk_seq");

  // get alt_mode value
  dut_cfg.std_mode = tb_cfg.std_mode;
  device_dut_cfg.std_mode = tb_cfg.std_mode;
  if(tb_cfg.std_mode == ALT_MODE) begin
    if (!uvm_config_db#(std_mode_t)::get(this, "", "alt_mode", dut_cfg.alt_mode)) begin
      `uvm_fatal(get_type_name(), "dut_cfg alt_mode value not set")
    end
    if (!uvm_config_db#(std_mode_t)::get(this, "", "alt_mode", device_dut_cfg.alt_mode)) begin
      `uvm_fatal(get_type_name(), "device_dut_cfg alt_mode value not set")
    end
  end

  // set config
  uvm_config_db#(cdn_phy_tb_config)::set(this,"*","tb_cfg",tb_cfg);
  uvm_config_db#(cdn_phy_dut_config)::set(this,"*","dut_cfg",dut_cfg);
  uvm_config_db#(cdn_phy_dut_config)::set(this,"*","device_dut_cfg",device_dut_cfg);

  uvm_reg::include_coverage("*",UVM_CVR_ALL);
  // random config
  randomise_config();
  reconfig_dut_cfg();
  // set clks
  set_clks();
endfunction

function void cdn_phy_test_base::reconfig_dut_cfg();
     uvm_cmdline_processor clp;
     string arg_values[$];
     clp = uvm_cmdline_processor::get_inst();
     if (clp.get_arg_values("+REFCLK=",arg_values))begin
       foreach (arg_values[i])begin
         case(arg_values[i])
         "REF100":dut_cfg.ref_clk_mode = REFCLK_100M;
         "REF19P2":dut_cfg.ref_clk_mode = REFCLK_19_2M;
         "REF24" :dut_cfg.ref_clk_mode = REFCLK_24M;
         default:begin
         `uvm_info(get_name(), $psprintf("refclk random yes!!!"), UVM_LOW) 
         end
         endcase
       end
     end      
//     dut_cfg.ref_clk_mode = REFCLK_100M;
//cfg ssc
     if (clp.get_arg_values("+SSCFLAG=",arg_values))begin
       foreach (arg_values[i])begin
         case(arg_values[i])
         "SSCNO":dut_cfg.ssc_mode     = SSC_DISABLE;
         "SSCEN":dut_cfg.ssc_mode     = SSC_ENABLE;
         default:begin
         `uvm_info(get_name(), $psprintf("ssc random yes!!!"), UVM_LOW) 
         end
         endcase
       end
     end       

     if(tb_cfg.b2b_dut == 1) begin
       //cfg device refclk
       if (clp.get_arg_values("+DEV_REFCLK=",arg_values))begin
         foreach (arg_values[i])begin
           case(arg_values[i])
           "REF100":  device_dut_cfg.ref_clk_mode = REFCLK_100M;
           "REF19P2": device_dut_cfg.ref_clk_mode = REFCLK_19_2M;
           "REF24" :  device_dut_cfg.ref_clk_mode = REFCLK_24M;
           default:begin
           `uvm_info(get_name(), $psprintf("refclk random yes!!!"), UVM_LOW) 
           end
           endcase
         end
       end      
       //cfg device ssc
       if (clp.get_arg_values("+DEV_SSCFLAG=",arg_values))begin
         foreach (arg_values[i])begin
           case(arg_values[i])
           "SSCNO": device_dut_cfg.ssc_mode = SSC_DISABLE;
           "SSCEN": device_dut_cfg.ssc_mode = SSC_ENABLE;
           default:begin
           `uvm_info(get_name(), $psprintf("ssc random yes!!!"), UVM_LOW) 
           end
           endcase
         end
       end       
     end
endfunction

function void cdn_phy_test_base::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if(tb_cfg.std_mode == ALT_MODE) begin
    if(dut_cfg.alt_mode == USB32_MODE) begin
      if(!uvm_config_db#(clk_sqr_t)::get(this, "*", "usb32_clk_sqr", m_clk_sqr)) begin
        `uvm_fatal(get_name(),"NULL clock sequencer ");
      end
    end else if(dut_cfg.alt_mode == DP_MODE) begin
      if(!uvm_config_db#(clk_sqr_t)::get(this, "*", "dp_clk_sqr", m_clk_sqr)) begin
        `uvm_fatal(get_name(),"NULL clock sequencer ");
      end
    end else begin
      `uvm_fatal(get_full_name(), $sformatf("dut_cfg.alt_mode: %s is invalid for ALT_MODE", dut_cfg.alt_mode.name()))
    end
  end else begin
    if(!uvm_config_db#(clk_sqr_t)::get(this, "*", "m_clk_sqr", m_clk_sqr)) begin
      `uvm_fatal(get_name(),"NULL clock sequencer ");
    end
  end
endfunction

task cdn_phy_test_base::configure_phase (uvm_phase phase);
  super.configure_phase(phase);
  //ToDo: Configure components here
  print_cfgs();
  gen_clks();
endtask:configure_phase

task cdn_phy_test_base::main_phase(uvm_phase phase);
  phase.raise_objection(this);
  super.main_phase(phase);
  dyn_main_phase();
  phase.drop_objection(this);  
endtask

task cdn_phy_test_base::dyn_main_phase();
endtask


function void cdn_phy_test_base::get_cmd_args();
  uvm_cmdline_processor clp;
  string arg_values[$];
  
  // get standard mode
  clp = uvm_cmdline_processor::get_inst();
  if (clp.get_arg_values("+STANDARD=", arg_values)) begin
    foreach(arg_values[i]) begin
      case(arg_values[i])
      "USB4":  tb_cfg.std_mode = USB4_MODE;
      "USB32": tb_cfg.std_mode = USB32_MODE;
      "DP":    tb_cfg.std_mode = DP_MODE;
      "PCIE":  tb_cfg.std_mode = PCIE_MODE;
      "ALT":   tb_cfg.std_mode = ALT_MODE;
      default: begin
        `uvm_fatal("cdn_phy_test_base", "Standard is invalid")
      end
      endcase
      `uvm_info("cdn_phy_test_base", $sformatf("Standard is set to %s", arg_values[i]), UVM_LOW);
    end
  end else begin
    `uvm_fatal("cdn_phy_test_base", "Standard is not set")
  end

  if (clp.get_arg_values("+PORT_MODE=", arg_values)) begin
    foreach(arg_values[i]) begin
      case(arg_values[i])
      "HOST":  tb_cfg.port_mode = HOST;
      "DEVICE": tb_cfg.port_mode = DEVICE;
      "RETIMER":tb_cfg.port_mode = RETIMER;    
      default: begin
        `uvm_fatal("cdn_phy_test_base", "Standard is invalid")
      end
      endcase
      `uvm_info("cdn_phy_test_base", $sformatf("dut port mode is set to %s", arg_values[i]), UVM_LOW);
    end
  end

endfunction

function void cdn_phy_test_base::randomise_config();
  uvm_cmdline_processor clp;
  string arg_values[$];

  assert(tb_cfg.randomize());
  assert(dut_cfg.randomize());
  assert(device_dut_cfg.randomize());

  clp = uvm_cmdline_processor::get_inst();
  // get lane num
  if (clp.get_arg_values("+PCIE_LANE_NUM=", arg_values)) begin
  	$sscanf(arg_values[0], "%d", dut_cfg.pcie_lane_num);
      `uvm_info("cdn_phy_test_base", $sformatf("pcie lane num is set to %d", dut_cfg.pcie_lane_num), UVM_LOW);
  end
  if (clp.get_arg_values("+USB32_LANE_NUM=", arg_values)) begin
  	$sscanf(arg_values[0], "%d", dut_cfg.usb32_lane_num);
      `uvm_info("cdn_phy_test_base", $sformatf("usb32 lane num is set to %d", dut_cfg.usb32_lane_num), UVM_LOW);
  end
  if (clp.get_arg_values("+USB4_LANE_NUM=", arg_values)) begin
  	$sscanf(arg_values[0], "%d", dut_cfg.usb4_lane_num);
      `uvm_info("cdn_phy_test_base", $sformatf("usb4 lane num is set to %d", dut_cfg.usb4_lane_num), UVM_LOW);
  end
  if (clp.get_arg_values("+DP_LANE_NUM=", arg_values)) begin
  	$sscanf(arg_values[0], "%d", dut_cfg.dp_lane_num);
      `uvm_info("cdn_phy_test_base", $sformatf("dp lane num is set to %d", dut_cfg.dp_lane_num), UVM_LOW);
  end
  if(tb_cfg.b2b_dut == 1) begin
    if (clp.get_arg_values("+PCIE_LANE_NUM=", arg_values)) begin
    	$sscanf(arg_values[0], "%d", device_dut_cfg.pcie_lane_num);
        `uvm_info("cdn_phy_test_base", $sformatf("pcie lane num is set to %d", device_dut_cfg.pcie_lane_num), UVM_LOW);
    end
    if (clp.get_arg_values("+USB32_LANE_NUM=", arg_values)) begin
    	$sscanf(arg_values[0], "%d", device_dut_cfg.usb32_lane_num);
        `uvm_info("cdn_phy_test_base", $sformatf("usb32 lane num is set to %d", device_dut_cfg.usb32_lane_num), UVM_LOW);
    end
    if (clp.get_arg_values("+USB4_LANE_NUM=", arg_values)) begin
    	$sscanf(arg_values[0], "%d", device_dut_cfg.usb4_lane_num);
        `uvm_info("cdn_phy_test_base", $sformatf("usb4 lane num is set to %d", device_dut_cfg.usb4_lane_num), UVM_LOW);
    end
    if (clp.get_arg_values("+DP_LANE_NUM=", arg_values)) begin
    	$sscanf(arg_values[0], "%d", device_dut_cfg.dp_lane_num);
        `uvm_info("cdn_phy_test_base", $sformatf("dp lane num is set to %d", device_dut_cfg.dp_lane_num), UVM_LOW);
    end
  end

  //get fw cfg from cmd
  if(clp.get_arg_values("+FW_FRONTDOOR=", arg_values)) begin
    case(arg_values[0])
      "YES": begin  tb_cfg.fw_writes_pg = 1'b1;  tb_cfg.load_fw_via_apb =1'b1;  end
      "NO" : begin  tb_cfg.fw_writes_pg = 1'b1;  tb_cfg.load_fw_via_apb =1'b0;   end
      default : `uvm_fatal("", "firmware write cmd is invalid")
    endcase  
    `uvm_info("", $sformatf("firmware loading configure via cmd arg FW_FRONTDOOR= %s", arg_values[0]), UVM_LOW);
  end

  // get speedup cfg from cmd
  if(clp.get_arg_values("+SIM_SPEEDUP=", arg_values)) begin
    case(arg_values[0])
      "YES": begin  tb_cfg.speedup_cfg = SPEEDUP_CONFIG_ENABLE;  end
      "NO" : begin  tb_cfg.speedup_cfg = SPEEDUP_CONFIG_DISABLE;  end
      default : `uvm_fatal("", "sim speedup cmd is invalid")
    endcase  
    `uvm_info("", $sformatf("sim speedup configure via cmd arg SIM_SPEEDUP= %s", arg_values[0]), UVM_LOW);
  end


  // get cmd args if exist
  dut_cfg.get_cmd_args_cfg();
  device_dut_cfg.get_cmd_args_cfg();
endfunction

function void cdn_phy_test_base::set_clks();

  dut_cfg.set_ref_clk(dut_cfg.ref_clk_mode, dut_cfg.ref_clk1_mode);
  device_dut_cfg.set_ref_clk(device_dut_cfg.ref_clk_mode, device_dut_cfg.ref_clk1_mode);

  //if(dut_cfg.reg_interface_sel == JTAG_1687)
  //  `TB_TOP.host_1687_en = 1'b1;
  //if(device_dut_cfg.reg_interface_sel == JTAG_1687)
  //  `TB_TOP.device_1687_en = 1'b1;

endfunction 

function void cdn_phy_test_base::print_cfgs();
  report_phy_cfg();
  `uvm_info(get_type_name(),$psprintf("TOP CFG: \n%s", tb_cfg.sprint()), UVM_LOW)
  `uvm_info(get_type_name(),$psprintf("DUT CFG: \n%s", dut_cfg.sprint()), UVM_LOW)

  if(tb_cfg.b2b_dut) begin
    `uvm_info(get_type_name(),$psprintf("DEVICE DUT CFG: \n%s", device_dut_cfg.sprint()), UVM_LOW)
  end
endfunction 


function void cdn_phy_test_base::report_phy_cfg();
    string fw_enable;
    string fm_load_type;
    vco_clk_t pll0_vco_clk,pll1_vco_clk;
    pipe_clk_t pipe_clk;
    lane_num_t   prot1_phy_lane_num;
    lane_num_t   prot2_phy_lane_num;
    phy_rate_union_t   prot1_phy_rate;
    phy_rate_union_t   prot2_phy_rate;
    std_mode_t   phy_prot1;
    std_mode_t   phy_prot2;
    physical_lane_t phy_pma_lane_map[4];
    real dp_pclk;


    case(dut_cfg.dp_data_rate)
      DP_RBR : begin
        dp_pclk = CLK_81M;
      end
      DP_HBR :   begin
        dp_pclk = CLK_135M;
      end
      DP_HBR2 :   begin
        dp_pclk = CLK_270M;
      end
      DP_HBR3 :  begin
        dp_pclk = CLK_405M;
      end
      DP_UHBR10 :  begin
        dp_pclk = CLK_312_5M;
      end
      DP_UHBR13P5 :  begin
        dp_pclk = CLK_421_875M;
      end
      DP_UHBR20 :  begin
        dp_pclk = CLK_625M;
      end
      default : begin
        `uvm_error(get_type_name(),"set_dp_pclk error: unknown dp data_rate")
      end
    endcase

    case(dut_cfg.std_mode)
      USB32_MODE: begin 
                  prot1_phy_lane_num = dut_cfg.usb32_lane_num; 
                  prot1_phy_rate.gen_speed = dut_cfg.usb32_gen_speed;
                  phy_prot1= USB32_MODE; 
                  pll0_vco_clk = VCO_10G; 
                  pll1_vco_clk = UNUSED;
                  if (dut_cfg.usb32_gen_speed == GEN1_SPEED) begin
                    pipe_clk = PIPE_CLK_125M; //TODO
                  end else  if (dut_cfg.usb32_gen_speed == GEN2_SPEED) begin
                    pipe_clk = PIPE_CLK_312_5M; //TODO
                  end else begin
                    `uvm_fatal(get_full_name(),"error rate")
                  end 
      end
      USB4_MODE: begin 
                  prot1_phy_lane_num = dut_cfg.usb4_lane_num; 
                  prot1_phy_rate.gen_speed = dut_cfg.usb4_gen_speed;
                  phy_prot1= USB4_MODE; 
                  pll0_vco_clk = VCO_10G; 
                  pll1_vco_clk = UNUSED;
                  if (dut_cfg.usb4_gen_speed == GEN2_SPEED) begin
                    pipe_clk = PIPE_CLK_312_5M; 
                  end else  if (dut_cfg.usb4_gen_speed == GEN3_SPEED) begin
                    pipe_clk = PIPE_CLK_625M; 
                  end else begin
                    `uvm_fatal(get_full_name(),"error rate")
                  end 
      end
      DP_MODE: begin 
                  prot1_phy_lane_num = dut_cfg.dp_lane_num; 
                  prot1_phy_rate.dp_rate = dut_cfg.dp_data_rate;
                  phy_prot1= DP_MODE; 
                  pipe_clk = NULL;
                  if (dut_cfg.dp_data_rate == DP_RBR) begin
                    pll0_vco_clk = UNUSED;
                    pll1_vco_clk = VCO_6_48G;
                  end
                  else if (dut_cfg.dp_data_rate == DP_HBR || dut_cfg.dp_data_rate == DP_HBR2) begin
                    pll0_vco_clk = UNUSED;
                    pll1_vco_clk = VCO_5_4G;
                  end
                  else if (dut_cfg.dp_data_rate == DP_HBR3) begin
                    pll0_vco_clk = UNUSED;
                    pll1_vco_clk = VCO_8_1G;
                  end
                  else if (dut_cfg.dp_data_rate == DP_UHBR10 || dut_cfg.dp_data_rate == DP_UHBR20) begin
                    pll0_vco_clk = UNUSED;
                    pll1_vco_clk = VCO_10G;
                  end
                  else if (dut_cfg.dp_data_rate == DP_UHBR13P5) begin
                    pll0_vco_clk = UNUSED;
                    pll1_vco_clk = VCO_6_75G;
                  end
                  else begin
                    `uvm_fatal(get_full_name(),"error rate")
                  end
      end
      ALT_MODE: begin 
                prot1_phy_lane_num = dut_cfg.usb32_lane_num;  prot2_phy_lane_num = dut_cfg.dp_lane_num;
                prot1_phy_rate.gen_speed = dut_cfg.usb32_gen_speed;   prot2_phy_rate.dp_rate = dut_cfg.dp_data_rate;
                phy_prot1= USB32_MODE;                        phy_prot2= DP_MODE;
                if (dut_cfg.usb32_gen_speed == GEN1_SPEED) begin
                  pipe_clk = PIPE_CLK_125M; 
                end else  if (dut_cfg.usb32_gen_speed == GEN2_SPEED) begin
                  pipe_clk = PIPE_CLK_312_5M; 
                end else begin
                  `uvm_fatal(get_full_name(),"error rate")
                end 
                pll0_vco_clk = VCO_10G;
                if (dut_cfg.dp_data_rate == DP_RBR) begin
                  pll1_vco_clk = VCO_6_48G;
                end
                else if (dut_cfg.dp_data_rate == DP_HBR || dut_cfg.dp_data_rate == DP_HBR2) begin
                  pll1_vco_clk = VCO_5_4G;
                end
                else if (dut_cfg.dp_data_rate == DP_HBR3) begin
                  pll1_vco_clk = VCO_8_1G;
                end
                else if (dut_cfg.dp_data_rate == DP_UHBR10 || dut_cfg.dp_data_rate == DP_UHBR20) begin
                  pll1_vco_clk = VCO_10G;
                end
                else if (dut_cfg.dp_data_rate == DP_UHBR13P5) begin
                  pll1_vco_clk = VCO_6_75G;
                end
                else begin
                  `uvm_fatal(get_full_name(),"error rate")
                end
      end
    endcase

    if(tb_cfg.fw_writes_pg == 1)  fw_enable = "YES"; else fw_enable = "NO";
    if(tb_cfg.load_fw_via_apb == 1) fm_load_type = "APB (Front-door)"; else fm_load_type = "Back-door";
    case ({dut_cfg.flip_flag,dut_cfg.std_mode})
      5'b0_0000: phy_pma_lane_map = '{PMA_LANE_0, PMA_LANE_1, PMA_LANE_3, PMA_LANE_2};
      5'b0_0001: phy_pma_lane_map = '{PMA_LANE_0, PMA_LANE_1, PMA_LANE_3, PMA_LANE_2};
      5'b0_0011: phy_pma_lane_map = '{PMA_LANE_2, PMA_LANE_3, PMA_LANE_0, PMA_LANE_1};
      5'b0_0100: phy_pma_lane_map = '{PMA_LANE_0, PMA_LANE_1, PMA_LANE_2, PMA_LANE_3};
      5'b1_0000: phy_pma_lane_map = '{PMA_LANE_3, PMA_LANE_2, PMA_LANE_0, PMA_LANE_1};
      5'b1_0001: phy_pma_lane_map = '{PMA_LANE_3, PMA_LANE_2, PMA_LANE_0, PMA_LANE_1};
      5'b1_0011: phy_pma_lane_map = '{PMA_LANE_1, PMA_LANE_0, PMA_LANE_3, PMA_LANE_2};
      5'b1_0100: phy_pma_lane_map = '{PMA_LANE_3, PMA_LANE_2, PMA_LANE_1, PMA_LANE_0};
    endcase

    $display("\n");
    $display("*******************************************************************************************");
    $display("   Report the Current PHY configuration (phycfg) Begin ");
    $display("*******************************************************************************************\n"); 

    $display("[ Clock  Setting ]"); 
    $display("==================================");
    if(phy_prot1 != DP_MODE) begin
      $display("PLL0:");
      $display("----------------------------------------------------------------------------------------------------------------------------------");
      $display("| Refclk (MHz) | VCO Clock pll0(GHz) |   Target PIPE clock(MHz)   |  SSC Setting  | PPM Setting | Jitter Setting |   Data_width  |");
      $display("----------------------------------------------------------------------------------------------------------------------------------");
      $display("| %-12s | %-19s | %-26s | %-13s | %-11s | %-14s | %-13s |",dut_cfg.ref_clk_mode.name(),pll0_vco_clk.name(),pipe_clk.name(),dut_cfg.ssc_mode.name(),"TODO","TODO","TODO");
      $display("----------------------------------------------------------------------------------------------------------------------------------\n");
    end 
    else   begin
      $display("PLL1:");
      $display("----------------------------------------------------------------------------------------------------------------------------------");
      $display("| Refclk (MHz) | VCO Clock pll1(GHz) | Target DP_tx_td clock(MHz) |  SSC Setting  | PPM Setting | Jitter Setting |   Data_width  |");
      $display("----------------------------------------------------------------------------------------------------------------------------------");
      $display("| %-12s | %-19s | %-26f | %-13s | %-11s | %-14s | %-13s |",dut_cfg.ref_clk_mode.name(),pll1_vco_clk.name(),dp_pclk,dut_cfg.ssc_mode.name(),"TODO","TODO","TODO");
      $display("----------------------------------------------------------------------------------------------------------------------------------\n");
    end 

    if(dut_cfg.std_mode == ALT_MODE) begin
      $display("PLL1:");
      $display("----------------------------------------------------------------------------------------------------------------------------------");
      $display("| Refclk (MHz) | VCO Clock pll1(GHz) | Target DP_tx_td clock(MHz) |  SSC Setting  | PPM Setting | Jitter Setting |   Data_width  |");
      $display("----------------------------------------------------------------------------------------------------------------------------------");
      $display("| %-12s | %-19s | %-26f | %-13s | %-11s | %-14s | %-13s |",dut_cfg.ref_clk_mode.name(),pll1_vco_clk.name(),dp_pclk,dut_cfg.ssc_mode.name(),"TODO","TODO","TODO");
      $display("----------------------------------------------------------------------------------------------------------------------------------\n");
    end 

    $display("[ Firmware and Sim speedup Seting ]"); 
    $display("==================================");
    $display(" Load Firmware Enable                 : %0s",fw_enable);
    $display(" Load Firmware method                 : %0s",fm_load_type);
    $display(" uC ECC Enable                        : %s",dut_cfg.uc_ecc_enable);
    $display(" Sim speedup                          : %0s",tb_cfg.speedup_cfg.name()); 
    $display("\n"); 
    $display("[ Lane Setting ]"); 
    $display("==================================");
    $display("------------------------------------------------------------------------------------------------------------------------------------------------");
    $display("|  Protocol  |   Flip flag   | Lane_number  |logic lane id | physical PMA lane map-TX |physical PMA lane map-RX |  Init Rate  | Init PowerDown |"); 
    $display("------------------------------------------------------------------------------------------------------------------------------------------------");
 
    for(int i =0 ; i< prot1_phy_lane_num; i++) begin
      if (i == 0) begin
        if (dut_cfg.std_mode == USB32_MODE || dut_cfg.std_mode == USB4_MODE ||(dut_cfg.std_mode == ALT_MODE) )
          $display("| %-10s | %-13s | %-12d | %-12d | %-24s | %-23s | %-11s | %-14s |",phy_prot1.name(),dut_cfg.flip_flag.name(),int'(prot1_phy_lane_num),i,phy_pma_lane_map[i*2].name(),phy_pma_lane_map[i*2+1].name(),prot1_phy_rate.gen_speed.name(),"TODO");
        else if(dut_cfg.std_mode == DP_MODE)
          $display("| %-10s | %-13s | %-12d | %-12d | %-24s | %-23s | %-11s | %-14s |",phy_prot1.name(),dut_cfg.flip_flag.name(),int'(prot1_phy_lane_num),i,phy_pma_lane_map[i].name(),"n/a",prot1_phy_rate.dp_rate.name(),"TODO");
      end 
      else begin
        if (dut_cfg.std_mode == USB32_MODE || dut_cfg.std_mode == USB4_MODE ||(dut_cfg.std_mode == ALT_MODE && tb_cfg.std_mode == USB32_MODE) )
          $display("| %-10s | %-13s | %-12s | %-12d | %-24s | %-23s | %-11s | %-14s |"," "," "," ",i,phy_pma_lane_map[i*2].name(),phy_pma_lane_map[i*2+1].name(),prot1_phy_rate.gen_speed.name(),"TODO");
        else if(dut_cfg.std_mode == DP_MODE)
          $display("| %-10s | %-13s | %-12s | %-12d | %-24s | %-23s | %-11s | %-14s |"," "," "," ",i,phy_pma_lane_map[i].name(),"n/a",prot1_phy_rate.dp_rate.name(),"TODO");
      end 
    end 

    if (dut_cfg.std_mode == ALT_MODE) begin
      for(int i =0 ; i< prot2_phy_lane_num; i++) begin
        if (i < 1)
          $display("| %-10s | %-13s | %-12d | %-12d | %-24s | %-23s | %-11s | %-14s |",phy_prot2.name(),dut_cfg.flip_flag.name(),int'(prot2_phy_lane_num),i,phy_pma_lane_map[2+i].name(),"n/a",prot2_phy_rate.dp_rate.name(),"TODO");
        else  
          $display("| %-10s | %-13s | %-12s | %-12d | %-24s | %-23s | %-11s | %-14s |"," "," ", " ",i,phy_pma_lane_map[2+i].name(),"n/a",prot2_phy_rate.dp_rate.name(),"TODO");
      end 
    end
    $display("------------------------------------------------------------------------------------------------------------------------------------------------");

    $display("\n");
    $display("*******************************************************************************************");
    $display("   Report the Current PHY configuration(phycfg) End ");
    $display("*******************************************************************************************\n"); 
endfunction



task cdn_phy_test_base::gen_pclk();
  real pclk;
  real pclk1;
  real device_pclk;
  real device_pclk1;

  if(tb_cfg.std_mode == USB32_MODE) begin
    case(dut_cfg.usb32_gen_speed)
    GEN1_SPEED:  pclk = CLK_125M;
    GEN2_SPEED:  pclk = CLK_312_5M;
    default: begin 
                `uvm_fatal("USB32", "pclk is invalid")
             end
    endcase
  end else if(tb_cfg.std_mode == USB4_MODE) begin
    case(dut_cfg.usb4_gen_speed)
    GEN2_SPEED:  pclk = CLK_312_5M;
    GEN3_SPEED:  pclk = CLK_625M;
    default: begin
                `uvm_fatal("USB4", "pclk is invalid")
             end
    endcase
  end else if(tb_cfg.std_mode == DP_MODE) begin
    case(dut_cfg.dp_data_rate)
      DP_RBR : begin
        pclk = CLK_81M;
      end
      DP_HBR :   begin
        pclk = CLK_135M;
      end
      DP_HBR2 :   begin
        pclk = CLK_270M;
      end
      DP_HBR3 :  begin
        pclk = CLK_405M;
      end
      DP_UHBR10 :  begin
        pclk = CLK_312_5M;
      end
      DP_UHBR13P5 :  begin
        pclk = CLK_421_875M;
      end
      DP_UHBR20 :  begin
        pclk = CLK_625M;
      end
      default : begin
        `uvm_fatal("DP", "pclk is invalid")
      end
    endcase
  end else if(tb_cfg.std_mode == PCIE_MODE) begin
    // TODO
  end else if(tb_cfg.std_mode == ALT_MODE) begin
    if(dut_cfg.alt_mode == USB32_MODE) begin
      case(dut_cfg.usb32_gen_speed)
      GEN1_SPEED:  pclk = CLK_125M;
      GEN2_SPEED:  pclk = CLK_312_5M;
      default: begin 
                  `uvm_fatal("USB32", "pclk is invalid")
               end
      endcase
    end else if(dut_cfg.alt_mode == DP_MODE) begin
      case(dut_cfg.dp_data_rate)
        DP_RBR : begin
          pclk1 = CLK_81M;
        end
        DP_HBR :   begin
          pclk1 = CLK_135M;
        end
        DP_HBR2 :   begin
          pclk1 = CLK_270M;
        end
        DP_HBR3 :  begin
          pclk1 = CLK_405M;
        end
        DP_UHBR10 :  begin
          pclk1 = CLK_312_5M;
        end
        DP_UHBR13P5 :  begin
          pclk1 = CLK_421_875M;
        end
        DP_UHBR20 :  begin
          pclk1 = CLK_625M;
        end
        default : begin
          `uvm_fatal("DP", "pclk is invalid")
        end
      endcase
    end else begin
      `uvm_fatal(get_full_name(), $sformatf("dut_cfg.alt_mode: %s is invalid for ALT_MODE", dut_cfg.alt_mode.name()))
    end
  end

  if(tb_cfg.b2b_dut == 1) begin
    if(tb_cfg.std_mode == USB32_MODE) begin
      case(device_dut_cfg.usb32_gen_speed)
      GEN1_SPEED:  device_pclk = CLK_125M;
      GEN2_SPEED:  device_pclk = CLK_312_5M;
      default: begin 
                  `uvm_fatal("USB32", "device_pclk is invalid")
               end
      endcase
    end else if(tb_cfg.std_mode == USB4_MODE) begin
      case(device_dut_cfg.usb4_gen_speed)
      GEN2_SPEED:  device_pclk = CLK_312_5M;
      GEN3_SPEED:  device_pclk = CLK_625M;
      default: begin
                  `uvm_fatal("USB4", "device_pclk is invalid")
               end
      endcase
    end else if(tb_cfg.std_mode == DP_MODE) begin
      case(device_dut_cfg.dp_data_rate)
        DP_RBR : begin
          device_pclk = CLK_81M;
        end
        DP_HBR :   begin
          device_pclk = CLK_135M;
        end
        DP_HBR2 :   begin
          device_pclk = CLK_270M;
        end
        DP_HBR3 :  begin
          device_pclk = CLK_405M;
        end
        DP_UHBR10 :  begin
          device_pclk = CLK_312_5M;
        end
        DP_UHBR13P5 :  begin
          device_pclk = CLK_421_875M;
        end
        DP_UHBR20 :  begin
          device_pclk = CLK_625M;
        end
        default : begin
          `uvm_fatal("DP", "device_pclk is invalid")
        end
      endcase
    end else if(tb_cfg.std_mode == PCIE_MODE) begin
      // TODO
    end else if(tb_cfg.std_mode == ALT_MODE) begin
      if(device_dut_cfg.alt_mode == USB32_MODE) begin
        case(device_dut_cfg.usb32_gen_speed)
        GEN1_SPEED:  device_pclk = CLK_125M;
        GEN2_SPEED:  device_pclk = CLK_312_5M;
        default: begin 
                    `uvm_fatal("USB32", "device_pclk is invalid")
                 end
        endcase
      end else if(device_dut_cfg.alt_mode == DP_MODE) begin
        case(device_dut_cfg.dp_data_rate)
          DP_RBR : begin
            device_pclk1 = CLK_81M;
          end
          DP_HBR :   begin
            device_pclk1 = CLK_135M;
          end
          DP_HBR2 :   begin
            device_pclk1 = CLK_270M;
          end
          DP_HBR3 :  begin
            device_pclk1 = CLK_405M;
          end
          DP_UHBR10 :  begin
            device_pclk1 = CLK_312_5M;
          end
          DP_UHBR13P5 :  begin
            device_pclk1 = CLK_421_875M;
          end
          DP_UHBR20 :  begin
            device_pclk1 = CLK_625M;
          end
          default : begin
            `uvm_fatal("DP", "device_pclk is invalid")
          end
        endcase
      end else begin
        `uvm_fatal(get_full_name(), $sformatf("device_dut_cfg.alt_mode: %s is invalid for ALT_MODE", device_dut_cfg.alt_mode.name()))
      end
    end
  end

  if((tb_cfg.std_mode != ALT_MODE) || (tb_cfg.std_mode == ALT_MODE && dut_cfg.alt_mode == USB32_MODE)) begin
    m_clk_seq.t_clk_para= '{clk_index : 0, clk_en : 1, clk_frequency_MHz : pclk, clk_duty_cycle : 0.5, set_ini_period_rand :1};//USB32 GEN1
    m_clk_seq.set_one_clk_config();
  end
 // m_clk_seq.t_ssc_clk_para = '{clk_index:1 ,clk_en:1,clk_frequency_MHz:800,start_freq_Mhz:797.8,set_ini_period_rand:1,delta_frequency_MHz:4,delta_time :1fs,accuracy_count:3,clk_ssc_en:1};
 // m_clk_seq.set_one_ssc_clk_config();
  if(tb_cfg.std_mode == ALT_MODE && dut_cfg.alt_mode == DP_MODE) begin
    m_clk_seq.t_clk_para= '{clk_index : 1, clk_en : 1, clk_frequency_MHz : pclk1, clk_duty_cycle : 0.5, set_ini_period_rand :1};//DP
    m_clk_seq.set_one_clk_config();
  end

  if(tb_cfg.b2b_dut) begin
    if((tb_cfg.std_mode != ALT_MODE) || (tb_cfg.std_mode == ALT_MODE && device_dut_cfg.alt_mode == USB32_MODE)) begin
      m_clk_seq.t_clk_para= '{clk_index : 8, clk_en : 1, clk_frequency_MHz : device_pclk, clk_duty_cycle : 0.5, set_ini_period_rand :1};//USB32 GEN1
      m_clk_seq.set_one_clk_config();
    end
    if(tb_cfg.std_mode == ALT_MODE && device_dut_cfg.alt_mode == DP_MODE) begin
      m_clk_seq.t_clk_para= '{clk_index : 9, clk_en : 1, clk_frequency_MHz : device_pclk1, clk_duty_cycle : 0.5, set_ini_period_rand :1};//DP
      m_clk_seq.set_one_clk_config();
    end
  end
endtask

task cdn_phy_test_base::gen_ref_clk();
  m_clk_seq.t_clk_para= '{clk_index : 2, clk_en : 1, clk_frequency_MHz : dut_cfg.ref_clk, clk_duty_cycle : 0.5, set_ini_period_rand :1};
  m_clk_seq.set_one_clk_config();
  //m_clk_seq.start(m_clk_sqr);
  if(tb_cfg.b2b_dut) begin
    m_clk_seq.t_clk_para= '{clk_index : 10, clk_en : 1, clk_frequency_MHz : device_dut_cfg.ref_clk, clk_duty_cycle : 0.5, set_ini_period_rand :1};
    m_clk_seq.set_one_clk_config();
    //m_clk_seq.start(m_clk_sqr);
  end
endtask

task cdn_phy_test_base::gen_ref_clk1();
  m_clk_seq.t_clk_para= '{clk_index : 7, clk_en : 1, clk_frequency_MHz : dut_cfg.ref_clk1, clk_duty_cycle : 0.5, set_ini_period_rand :1};
  m_clk_seq.set_one_clk_config();
  //m_clk_seq.start(m_clk_sqr);
  if(tb_cfg.b2b_dut) begin
    m_clk_seq.t_clk_para= '{clk_index : 15, clk_en : 1, clk_frequency_MHz : device_dut_cfg.ref_clk1, clk_duty_cycle : 0.5, set_ini_period_rand :1};
    m_clk_seq.set_one_clk_config();
    //m_clk_seq.start(m_clk_sqr);
  end
endtask

task cdn_phy_test_base::gen_apb_clk();
  m_clk_seq.t_clk_para= '{clk_index : 3, clk_en : 1, clk_frequency_MHz : dut_cfg.apb_clk, clk_duty_cycle : 0.5, set_ini_period_rand :0};
  m_clk_seq.set_one_clk_config();
  //m_clk_seq.start(m_clk_sqr);
  if(tb_cfg.b2b_dut) begin
    m_clk_seq.t_clk_para= '{clk_index : 11, clk_en : 1, clk_frequency_MHz : device_dut_cfg.apb_clk, clk_duty_cycle : 0.5, set_ini_period_rand :0};
    m_clk_seq.set_one_clk_config();
    //m_clk_seq.start(m_clk_sqr);
  end
endtask

task cdn_phy_test_base::gen_jtag_clk();
  m_clk_seq.t_clk_para= '{clk_index : 4, clk_en : 1, clk_frequency_MHz : dut_cfg.jtag_tck_clk, clk_duty_cycle : 0.5, set_ini_period_rand :0};
  m_clk_seq.set_one_clk_config();
  //m_clk_seq.start(m_clk_sqr);
  if(tb_cfg.b2b_dut) begin
    m_clk_seq.t_clk_para= '{clk_index : 12, clk_en : 1, clk_frequency_MHz : device_dut_cfg.jtag_tck_clk, clk_duty_cycle : 0.5, set_ini_period_rand :0};
    m_clk_seq.set_one_clk_config();
    //m_clk_seq.start(m_clk_sqr);
  end
endtask

task cdn_phy_test_base::gen_ijtag1687_clk();
  m_clk_seq.t_clk_para= '{clk_index : 5, clk_en : 1, clk_frequency_MHz : dut_cfg.ijtag1687_tck_clk, clk_duty_cycle : 0.5, set_ini_period_rand :0};
  m_clk_seq.set_one_clk_config();
  //m_clk_seq.start(m_clk_sqr);
  if(tb_cfg.b2b_dut) begin
    m_clk_seq.t_clk_para= '{clk_index : 13, clk_en : 1, clk_frequency_MHz : device_dut_cfg.ijtag1687_tck_clk, clk_duty_cycle : 0.5, set_ini_period_rand :0};
    m_clk_seq.set_one_clk_config();
    //m_clk_seq.start(m_clk_sqr);
  end
endtask

task cdn_phy_test_base::gen_uc_clk();
  m_clk_seq.t_clk_para= '{clk_index : 6, clk_en : 1, clk_frequency_MHz : dut_cfg.uc_clk, clk_duty_cycle : 0.5, set_ini_period_rand :0};
  m_clk_seq.set_one_clk_config();
  //m_clk_seq.start(m_clk_sqr);
  if(tb_cfg.b2b_dut) begin
    m_clk_seq.t_clk_para= '{clk_index : 14, clk_en : 1, clk_frequency_MHz : device_dut_cfg.uc_clk, clk_duty_cycle : 0.5, set_ini_period_rand :0};
    m_clk_seq.set_one_clk_config();
    //m_clk_seq.start(m_clk_sqr);
  end
endtask

task cdn_phy_test_base::gen_clks();
  gen_pclk();
  `ifndef DUT_BYPASS
  if(!(tb_cfg.std_mode == ALT_MODE && dut_cfg.alt_mode == DP_MODE)) begin
    gen_ref_clk();
    gen_ref_clk1();
    gen_apb_clk();
    gen_jtag_clk();
    gen_ijtag1687_clk();
    gen_uc_clk();
  end
  `endif
  m_clk_seq.start(m_clk_sqr);
endtask

function void cdn_phy_test_base::set_type_override();
/*
    // set type override
    if(tb_cfg.std_mode.usb4_enable == 1) begin
      //set_inst_override_by_type("this", cdn_phy_env_base::get_type(), cdn_u4_usb4_env::get_type());
      //set_inst_override_by_type("this", cdn_phy_agent_base::get_type(), cdn_u4_usb4_agent::get_type());
      //set_inst_override_by_type("this", cdn_phy_driver_base::get_type(), cdn_u4_usb4_driver::get_type());
      //set_inst_override_by_type("this", cdn_phy_monitor_base::get_type(), cdn_u4_usb4_monitor::get_type());
      //set_inst_override_by_type("this", cdn_phy_sequencer_base::get_type(), cdn_u4_usb4_sequencer::get_type());
      //set_inst_override_by_type("this", cdn_phy_virtual_sequencer_base::get_type(), cdn_u4_usb4_virtual_sequencer::get_type());
      //set_inst_override_by_type("this", cdn_phy_config_base::get_type(), cdn_u4_usb4_config::get_type());
      set_inst_override_by_type("this", cdn_phy_transaction_base::get_type(), cdn_u4_usb4_transaction::get_type());
    end else if(tb_cfg.std_mode.usb32_enable == 1) begin
      set_inst_override_by_type("this", cdn_phy_env_base::get_type(), cdn_u4_usb32_env::get_type());
      set_inst_override_by_type("this", cdn_phy_agent_base::get_type(), cdn_u4_usb32_agent::get_type());
      set_inst_override_by_type("this", cdn_phy_driver_base::get_type(), cdn_u4_usb32_driver::get_type());
      set_inst_override_by_type("this", cdn_phy_monitor_base::get_type(), cdn_u4_usb32_monitor::get_type());
      set_inst_override_by_type("this", cdn_phy_sequencer_base::get_type(), cdn_u4_usb32_sequencer::get_type());
      set_inst_override_by_type("this", cdn_phy_virtual_sequencer_base::get_type(), cdn_u4_usb32_virtual_sequencer::get_type());
      set_inst_override_by_type("this", cdn_phy_config_base::get_type(), cdn_u4_usb32_config::get_type());
      //set_inst_override_by_type("this", cdn_phy_transaction_base::get_type(), cdn_u4_usb32_transaction::get_type());
      set_inst_override_by_type("this", cdn_phy_transaction_base::get_type(), cdn_u4_usb32_ltssm_instruction::get_type());
    end else if(tb_cfg.std_mode.dp_enable == 1) begin
      set_inst_override_by_type("this", cdn_phy_env_base::get_type(), cdn_u4_dp_env::get_type());
      set_inst_override_by_type("this", cdn_phy_agent_base::get_type(), cdn_u4_dp_agent::get_type());
      set_inst_override_by_type("this", cdn_phy_driver_base::get_type(), cdn_u4_dp_driver::get_type());
      set_inst_override_by_type("this", cdn_phy_monitor_base::get_type(), cdn_u4_dp_monitor::get_type());
      set_inst_override_by_type("this", cdn_phy_sequencer_base::get_type(), cdn_u4_dp_sequencer::get_type());
      set_inst_override_by_type("this", cdn_phy_virtual_sequencer_base::get_type(), cdn_u4_dp_virtual_sequencer::get_type());
      set_inst_override_by_type("this", cdn_phy_config_base::get_type(), cdn_u4_dp_config::get_type());
      set_inst_override_by_type("this", cdn_phy_transaction_base::get_type(), cdn_u4_dp_transaction::get_type());
    end else if(tb_cfg.std_mode.pcie_enable == 1) begin
      set_inst_override_by_type("this", cdn_phy_env_base::get_type(), cdn_u4_pcie_env::get_type());
      set_inst_override_by_type("this", cdn_phy_agent_base::get_type(), cdn_u4_pcie_agent::get_type());
      set_inst_override_by_type("this", cdn_phy_driver_base::get_type(), cdn_u4_pcie_driver::get_type());
      set_inst_override_by_type("this", cdn_phy_monitor_base::get_type(), cdn_u4_pcie_monitor::get_type());
      set_inst_override_by_type("this", cdn_phy_sequencer_base::get_type(), cdn_u4_pcie_sequencer::get_type());
      //set_inst_/projects/sd3101_t4gp_fe/users/nawang/usb4_git/Timberwolf_USB4_T4GP/verif/work/u32_run_gen2/testlist.usb32_testlist/u32_gen2_bringup_testoverride_by_type("this", cdn_phy_virtual_sequencer_base::get_type(), cdn_u4_pcie_virtual_sequencer::get_type());
      //set_inst_override_by_type("this", cdn_phy_config_base::get_type(), cdn_u4_pcie_config::get_type());
      set_inst_override_by_type("this", cdn_phy_transaction_base::get_type(), cdn_u4_pcie_transaction::get_type());
    end
*/
endfunction

`endif //TEST__SV

