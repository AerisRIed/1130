`ifndef CDN_PHY_BRING_UP_SEQ_SV
`define CDN_PHY_BRING_UP_SEQ_SV

class cdn_phy_bring_up_seq extends cdn_phy_base_sequence;
    cdn_phy_dut_config dut_cfg;
    cdn_phy_dut_config device_dut_cfg;
    cdn_phy_tb_config  tb_cfg;
    cdn_reset_sequence  reset_seq;
    virtual cdn_reset_if phy_reset_if;
    virtual cdn_reset_if device_phy_reset_if;
    bit [3:0] lane_num;
    virtual cdn_phy_design_interface phy_design_if;
    string report_id = "cdn_phy_bring_up_seq";
    string pam_lane_index[2] = {"01","23"};
    localparam mem_depth = 1 << (`SRAM_DEPTH+1);
    logic [`SRAM_WIDTH:0] mem_data[mem_depth];

    `uvm_object_utils(cdn_phy_bring_up_seq)
    `uvm_declare_p_sequencer(cdn_phy_virtual_sequencer_base)

    function new(string name = "cdn_phy_bring_up_seq");
        super.new(name);
    endfunction

    // python scripts auto generate,please do not modified.
    `include "cdn_phy_pg_task_extern_define.sv"
    extern virtual task sram_init_reg_cfg(string location,int i);
    extern virtual task cal_firmware_percentage(int i);
    extern virtual task wr_sram_frontdoor_top(string sram_inst_path,string filename,string location);
    extern virtual task wr_sram_frontdoor_ln(string sram_inst_path,string filename,string location,int i);
    extern virtual task check_hex_file_exists(string hex_filepath);
    extern virtual task wr_sram_backdoor(string sram_inst_path,string filename);
    extern virtual task wr_speedup_config_reg();
    extern virtual task cfg_info_display(string prot,gen_speed_t rate);
    extern virtual task cfg_dp_info_display(dp_bit_rate_t dp_rate);
    extern virtual task usb4_pll_ok_drive();
    extern virtual task get_current_lane_num();
    extern virtual task wr_cmn_speedup_cfg();
    extern virtual task wr_rx_speedup_cfg(int i);
    extern virtual task wr_tx_speedup_cfg(int i);
    
    //  pg task call
    extern virtual task usb4_19p2_pg_wr_task();
    extern virtual task usb4_24p0_pg_wr_task();
    extern virtual task usb4_100p0_pg_wr_task();
    extern virtual task usb32_19p2_gen1_pg_wr_task();
    extern virtual task usb32_24p0_gen1_pg_wr_task();
    extern virtual task usb32_100p0_gen1_pg_wr_task();
    extern virtual task usb32_19p2_gen2_pg_wr_task();
    extern virtual task usb32_24p0_gen2_pg_wr_task();
    extern virtual task usb32_100p0_gen2_pg_wr_task();
    
    // Handling SSC flag
    extern virtual task proc_usb4_19p2mhz_ssc();
    extern virtual task proc_usb4_24mhz_ssc();
    extern virtual task proc_usb4_100mhz_ssc();
    extern virtual task proc_usb32_100mhz_ssc();
    extern virtual task proc_usb32_24mhz_ssc();
    extern virtual task proc_usb32_19p2mhz_ssc();
    extern virtual task proc_dp_24mhz_ssc();
    extern virtual task proc_dp_19p2mhz_ssc();
    extern virtual task proc_dp_100mhz_ssc();
    extern virtual task proc_pcie_19p2mhz_ssc();
    extern virtual task proc_pcie_24mhz_ssc();
    extern virtual task proc_pcie_100mhz_ssc();
    extern virtual task proc_alt_mode_19p2mhz_ssc();
    extern virtual task proc_alt_mode_24mhz_ssc();
    extern virtual task proc_alt_mode_100mhz_ssc();
    
    // protocol main task
    extern virtual task proc_alt_mode_cmn_pg();
    extern virtual task proc_usb32_pg();
    extern virtual task proc_usb4_pg();
    extern virtual task proc_dp_pg();
    extern virtual task proc_alt_mode_pg(); 
    extern virtual task proc_pcie_pg();  

    extern virtual task run_pg_cfg();
    extern virtual task pre_body();
    extern virtual task body();

endclass


task cdn_phy_bring_up_seq::pre_body();
    if(!uvm_config_db#(cdn_phy_dut_config)::get(null,  get_full_name() , "dut_cfg", dut_cfg)) begin
        `uvm_fatal(report_id, "dut_cfg don't get correctly!")
    end
    if(!uvm_config_db#(cdn_phy_dut_config)::get(null, get_full_name(), "device_dut_cfg", device_dut_cfg)) begin
        `uvm_fatal(report_id, "device_dut_cfg don't get correctly!")
    end
    if(!uvm_config_db#(cdn_phy_tb_config)::get(null, get_full_name(), "tb_cfg", tb_cfg)) begin
        `uvm_fatal(report_id, "tb_cfg don't get correctly!")
    end 
    if(!uvm_config_db#(virtual cdn_phy_design_interface )::get(null, get_full_name(), "phy_design_if", phy_design_if)) begin
        `uvm_fatal(report_id, "phy design interface don't get correctly!")
    end 
    if (tb_cfg.std_mode == ALT_MODE) begin
        if(!uvm_config_db#(virtual cdn_reset_if )::get(null, get_full_name(), "phy_reset_if", phy_reset_if)) begin
            `uvm_fatal(report_id, "phy design interface don't get correctly!")
        end 
        if(!uvm_config_db#(virtual cdn_reset_if )::get(null, get_full_name(), "device_phy_reset_if", device_phy_reset_if)) begin
            `uvm_fatal(report_id, "phy design interface don't get correctly!")
        end 
    end 
endtask

task cdn_phy_bring_up_seq::body(); 
    `uvm_info(report_id, "Start of the bring up body!", UVM_LOW)
    get_current_lane_num();

    if (tb_cfg.std_mode != ALT_MODE || (tb_cfg.std_mode == ALT_MODE && dut_cfg.alt_mode == USB32_MODE)) begin
        // Step1  release tap trst 
        if (tb_cfg.jtag_use_flag) begin
            `uvm_info (report_id,"Start Release tap trst...",UVM_LOW) 
	        `uvm_do_on_with(reset_seq, p_sequencer.m_reset_sqr[0], {jtag_reset_en ==1;})
        end else begin
            `uvm_info (report_id,"TAP not used, Skip tap trst...",UVM_LOW)   
        end 

        // Step2  release uc reset
	    `uvm_info (report_id,"Start Release uc reset ...",UVM_LOW)
	    `uvm_do_on_with(reset_seq, p_sequencer.m_reset_sqr[0], {uc_reset_en ==1;})
        `uvm_info (report_id,"Release uc reset Done Done Done...",UVM_LOW)
        // Step3  release apb reset
	    `uvm_info (report_id,"Start Release apb reset ...",UVM_LOW)
        `uvm_do_on_with(reset_seq, p_sequencer.m_reset_sqr[0], {apb_reset_en ==1;})
	    `uvm_info (report_id,"Release uc reset / apb reset release Done Done Done...",UVM_LOW)
    end 
	// Step4 load Firmware to sram
    if (tb_cfg.fw_writes_pg) begin
        if (tb_cfg.std_mode != ALT_MODE || (tb_cfg.std_mode == ALT_MODE && dut_cfg.alt_mode == USB32_MODE)) begin
            `uvm_info(report_id, "Cfg Timberwolf via Firmware, uCtrl enable",UVM_LOW)
            `uvm_info(report_id, $psprintf("TestBench SRAM Size (depth * width) is %0d * %0d bit = %0d K",mem_depth,`SRAM_WIDTH+1,((mem_depth*(`SRAM_WIDTH+1))/(8*1024))), UVM_LOW)
            // --- wr firware to uc sram
            if(tb_cfg.load_fw_via_apb) begin
                `uvm_info(report_id,"Start to write firmware via apb ...",UVM_LOW)
            // --- frontdoor wr firware 

                // write top task 
                wr_sram_frontdoor_top({`DUT_SRAM_PATH,".u_sram_cmn."},"phy_top_main.chex","top");

                //write ln task
                `ifndef CDN_MPPHY_LANE_UC_RMV
                    for (int i =0; i < lane_num;i++) begin
                        wr_sram_frontdoor_ln($psprintf("%s.u_sram_ln_%s",`DUT_SRAM_PATH,pam_lane_index[i]),"phy_ln.chex","ln",i);
                    end
                `endif

                 `uvm_info(report_id,"Write firmware via apb Done Done Done ...",UVM_LOW)
            end else begin
            // --- sram initial
                sram_init_reg_cfg("top", 0);
                `ifndef CDN_MPPHY_LANE_UC_RMV
                    for (int i =0; i < lane_num;i++) begin
                        sram_init_reg_cfg("ln",i);
                    end
                `endif
            // --- backdoor wr firware 
                `uvm_info(report_id,"Start to write firmware via backdoor ...",UVM_LOW)
                `ifdef CDN_MPPHY_UC_ECC_EN
                    wr_sram_backdoor({`DUT_SRAM_PATH,".u_sram_cmn"},"phy_top_main_ecc.chex");
                `else 
                    wr_sram_backdoor({`DUT_SRAM_PATH,".u_sram_cmn"},"phy_top_main.chex");
                `endif 
                for (int i =0; i < lane_num;i++) begin
                    `ifdef CDN_MPPHY_UC_ECC_EN
                        wr_sram_backdoor($psprintf("%s.u_sram_ln_%s",`DUT_SRAM_PATH,pam_lane_index[i]),"phy_ln_ecc.chex");
                    `else 
                        wr_sram_backdoor($psprintf("%s.u_sram_ln_%s",`DUT_SRAM_PATH,pam_lane_index[i]),"phy_ln.chex");
                    `endif 
                end 
                `uvm_info(report_id,"Write firmware via backdoor Done Done Done ...",UVM_LOW)
            end 

            // --- enable top level uc  
            p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_field("uc_top_ctrl_0",1'b0);
        end 
    end else begin
        // wait apb reset de-assertion for alt mode -dp
        if (tb_cfg.std_mode == ALT_MODE && dut_cfg.alt_mode == DP_MODE) begin
            wait(phy_reset_if.apb_reset);
            #1ns;
        end 
        // call pg task
        `uvm_info(report_id, "Cfg Timberwolf via testbench PG reg task, uCtrl disable",UVM_LOW)
        
        run_pg_cfg();

        if (tb_cfg.std_mode == ALT_MODE)
            `uvm_info(report_id, $psprintf("%p - PG configure bring up register Done Done Done ...", dut_cfg.alt_mode),UVM_LOW)
        else
            `uvm_info(report_id, $psprintf("%p - PG configure bring up register Done Done Done ...", dut_cfg.std_mode),UVM_LOW)

        // write speedup registers after pg cfg 
        `uvm_info (report_id, $psprintf("Enable/Disable Speedup configure: %p ",tb_cfg.speedup_cfg),UVM_LOW)
        if(tb_cfg.speedup_cfg == SPEEDUP_CONFIG_ENABLE) begin
           `uvm_info(report_id,"Start to write speedup register!",UVM_LOW)
            wr_speedup_config_reg();
           `uvm_info(report_id,"Write speedup register Done Done Done ...",UVM_LOW)
        end
    
        if (tb_cfg.std_mode != ALT_MODE || (tb_cfg.std_mode == ALT_MODE && dut_cfg.alt_mode == USB32_MODE)) begin
        // --- write uc complete register 
            `uvm_info (report_id, "Start Wait UC initial Complete ...",UVM_LOW)
            p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_field("phy_ctrl_set_0",1'b1);
        end
        
    end 

    // --- wait uc cfg complete 
    if (tb_cfg.std_mode != ALT_MODE || (tb_cfg.std_mode == ALT_MODE && dut_cfg.alt_mode == USB32_MODE)) begin
        fork
            begin
                wait (phy_design_if.phy_uc_init_complete);
                `uvm_info (report_id, "UC initial Complete Done Done Done ...",UVM_LOW)
            end 
            begin
                #1ms;
                `uvm_fatal(report_id," UC initial Complete timeout ...")
            end 
        join_any
        disable fork;
    end
endtask

// python scripts auto generate,please do not modified.
`include "cdn_phy_bring_up_task.sv"


// check if hex file exists
task cdn_phy_bring_up_seq::check_hex_file_exists(string hex_filepath);
    int file_handle;
    file_handle = $fopen(hex_filepath, "r");
    if (file_handle != 0) begin
        $fclose(file_handle);
    end else begin
        `uvm_fatal(report_id,$psprintf("hex file can not find: %s",hex_filepath))
    end
endtask


//cal percentage
task cdn_phy_bring_up_seq::cal_firmware_percentage(int i);
    case(i)
        $floor(mem_depth*0.1): begin `uvm_info(report_id, "Writing firmware 10% ......." ,UVM_LOW) end
        $floor(mem_depth*0.2): begin `uvm_info(report_id, "Writing firmware 20% ......." ,UVM_LOW) end
        $floor(mem_depth*0.3): begin `uvm_info(report_id, "Writing firmware 30% ......." ,UVM_LOW) end
        $floor(mem_depth*0.4): begin `uvm_info(report_id, "Writing firmware 40% ......." ,UVM_LOW) end
        $floor(mem_depth*0.5): begin `uvm_info(report_id, "Writing firmware 50% ......." ,UVM_LOW) end
        $floor(mem_depth*0.6): begin `uvm_info(report_id, "Writing firmware 60% ......." ,UVM_LOW) end
        $floor(mem_depth*0.7): begin `uvm_info(report_id, "Writing firmware 70% ......." ,UVM_LOW) end
        $floor(mem_depth*0.8): begin `uvm_info(report_id, "Writing firmware 80% ......." ,UVM_LOW) end
        $floor(mem_depth*0.9): begin `uvm_info(report_id, "Writing firmware 90% ......." ,UVM_LOW) end
        $floor(mem_depth*1): begin `uvm_info(report_id,   "Writing firmware 100%......." ,UVM_LOW) end
    endcase 
endtask

// sram initial task
task cdn_phy_bring_up_seq::sram_init_reg_cfg(string location, int i);
    bit sram_init_complete;

    //-- wait uc_ctrl[9] to 1 , clear uc_ctrl[8] to 0
    if (location == "top") begin
        //-- set uc_ctrl[8] to 1  to initial all SRAM address
        p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_field($psprintf("uc_%s_ctrl_8",location),1'b1);
        while (!sram_init_complete) begin
            p_sequencer.regmodel.phy_pcs_cmn_reg_block.read_dut_field($psprintf("uc_%s_ctrl_9",location),sram_init_complete);
        end
        p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_field($psprintf("uc_%s_ctrl_8",location),1'b0);
    end else if(location == "ln") begin
        //-- set uc_ctrl[8] to 1  to initial all SRAM address
        p_sequencer.regmodel.phy_pcs_lane_reg_block[i].write_dut_field($psprintf("uc_%s_ctrl_8",location),1'b1);
        while (!sram_init_complete) begin
            p_sequencer.regmodel.phy_pcs_lane_reg_block[i].read_dut_field($psprintf("uc_%s_ctrl_9",location),sram_init_complete);
        end
        p_sequencer.regmodel.phy_pcs_lane_reg_block[i].write_dut_field($psprintf("uc_%s_ctrl_8",location),1'b0);
    end else  begin
        `uvm_fatal(report_id,"please give the correct location top/ln");
    end 
endtask


// sram frontdoor write top task
task cdn_phy_bring_up_seq::wr_sram_frontdoor_top(string sram_inst_path,string filename,string location);  
    string hex_filepath = {`FIRMWARE_PATH,filename};
    check_hex_file_exists(hex_filepath);

    //--1 read hexfile
    $readmemh(hex_filepath,mem_data,0,mem_depth-1);
    //--2 initial sram
    sram_init_reg_cfg(location, 0);

    //--3 write uc_apb_slv_addr && write firmware word to uc_apb_slv_acess
    //-- write 
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register($psprintf("uc_%s_sram_addr",location),16'h0);

    foreach(mem_data[i]) begin
        cal_firmware_percentage(i);
        if (mem_data[i] !== 'hxxxxxxxx) begin 
            p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register($psprintf("uc_%s_sram_access",location),mem_data[i]);
        end else  begin
            `uvm_fatal(report_id, "Hex data [%0d] is X state")
        end 
    end 
endtask


// sram frontdoor write ln task
task cdn_phy_bring_up_seq::wr_sram_frontdoor_ln(string sram_inst_path,string filename,string location,int i);
    string hex_filepath = {`FIRMWARE_PATH,filename};
    check_hex_file_exists(hex_filepath);

    //--1 read hexfile
    $readmemh(hex_filepath,mem_data,0,mem_depth-1);
    //--2 initial sram
    sram_init_reg_cfg(location,i);

    //--3 write uc_apb_slv_addr && write firmware word to uc_apb_slv_acess
    //-- write 
    p_sequencer.regmodel.phy_pcs_lane_reg_block[i].write_dut_register($psprintf("uc_%s_sram_addr",location),16'h0);

    foreach(mem_data[k]) begin
        cal_firmware_percentage(k);
        if (mem_data[k] !== 'hxxxxxxxx) begin 
            p_sequencer.regmodel.phy_pcs_lane_reg_block[i].write_dut_register($psprintf("uc_%s_sram_access",location),mem_data[k]);
        end else  begin
            `uvm_fatal(report_id, "Hex data [%0d] is X state")
        end 
    end 
endtask

// sram backdoor write task
task cdn_phy_bring_up_seq::wr_sram_backdoor(string sram_inst_path,string filename);
    string mem_path;
    bit status;
    string hex_filepath = {`FIRMWARE_PATH,filename};
    check_hex_file_exists(hex_filepath);
    // read hex file
    $readmemh(hex_filepath, mem_data,0, mem_depth-1);
    foreach(mem_data[i]) begin
        if (mem_data[i] !== 32'hxxxxxxxx) begin 
            mem_path = $sformatf("%s.mem[%0d]",sram_inst_path, i);
            status = uvm_hdl_deposit(mem_path, mem_data[i]);
            if (status == 0) begin
                `uvm_error(get_type_name(), 
                          $sformatf("can not set memory path: %s", mem_path))
            end else begin
                `uvm_info(get_type_name(), 
                         $sformatf("setting %s = 0x%08h", mem_path, mem_data[i]), 
                         UVM_DEBUG)
            end
        end else  begin
            `uvm_fatal(report_id, "Hex data [%0d] is X state")
        end 
    end
endtask

// speedup config
task cdn_phy_bring_up_seq::wr_speedup_config_reg();
    // write cmn speedup register
    wr_cmn_speedup_cfg();
    if(tb_cfg.std_mode == DP_MODE) begin
        case ({dut_cfg.flip_flag,lane_num})
            5'b0_0001: begin wr_tx_speedup_cfg(2); end 
            5'b0_0010: begin wr_tx_speedup_cfg(2); wr_tx_speedup_cfg(3); end 
            5'b0_0100: begin wr_tx_speedup_cfg(2); wr_tx_speedup_cfg(3); wr_tx_speedup_cfg(0); wr_tx_speedup_cfg(1);  end 
            5'b1_0001: begin wr_tx_speedup_cfg(1); end
            5'b1_0010: begin wr_tx_speedup_cfg(1); wr_tx_speedup_cfg(0); end
            5'b1_0100: begin wr_tx_speedup_cfg(1); wr_tx_speedup_cfg(0); wr_tx_speedup_cfg(3); wr_tx_speedup_cfg(2);  end 
            default:   begin `uvm_fatal(report_id,"Please give the right lane number"); end 
        endcase
    end else if (tb_cfg.std_mode == ALT_MODE) begin 
        case({dut_cfg.flip_flag,lane_num})
            5'b0_0001: begin wr_tx_speedup_cfg(0); wr_rx_speedup_cfg(1); wr_tx_speedup_cfg(2); end             
            5'b0_0010: begin wr_tx_speedup_cfg(0); wr_rx_speedup_cfg(1); wr_tx_speedup_cfg(2); wr_tx_speedup_cfg(3); end            
            5'b1_0001: begin wr_tx_speedup_cfg(3); wr_rx_speedup_cfg(2); wr_tx_speedup_cfg(1); end
            5'b1_0010: begin wr_tx_speedup_cfg(3); wr_rx_speedup_cfg(2); wr_tx_speedup_cfg(1); wr_tx_speedup_cfg(0); end
            default:   begin `uvm_fatal(report_id,"Please give the right lane number"); end 
        endcase  
    end
    else begin 
        case ({dut_cfg.flip_flag,lane_num})
            5'b0_0001: begin  wr_tx_speedup_cfg(0); wr_rx_speedup_cfg(1);   end
            5'b0_0010: begin  wr_tx_speedup_cfg(0); wr_rx_speedup_cfg(1); wr_tx_speedup_cfg(3); wr_rx_speedup_cfg(2); end
            5'b1_0001: begin  wr_tx_speedup_cfg(3); wr_rx_speedup_cfg(2);   end
            5'b1_0010: begin  wr_tx_speedup_cfg(3); wr_rx_speedup_cfg(2); wr_tx_speedup_cfg(0); wr_rx_speedup_cfg(1); end
            default:   begin `uvm_fatal(report_id,"Please give the right lane number"); end 
        endcase
    end   
endtask

// usb4 sv replace fw behavior
task cdn_phy_bring_up_seq::usb4_pll_ok_drive();
    time pll_ready_timeout = 2ms;
    bit [31:0] rdata =32'h0; 
    bit [31:0] mask = 32'h0089;
    if (tb_cfg.fw_writes_pg) begin
      `uvm_info(report_id,"Wait PLL0 Ready...",UVM_LOW)
    end else begin
      fork 
        begin
          `uvm_info (report_id, "Polling PHY_PMA_CMN_CTRL_STS register, Wait PLL0 ready...",UVM_LOW)
          while(rdata != mask) begin
            p_sequencer.regmodel.phy_pma_cmn_reg_block.read_dut_register("phy_pma_cmn_ctrl_sts",rdata);
            rdata =  rdata & mask;
            #20us; // avoid too many read trans
          end 
          `uvm_info (report_id, "PLL0 Ready Done Done Done...",UVM_LOW)
        end 
        begin
          // timeout 
          #pll_ready_timeout;
          `uvm_fatal(report_id,$psprintf("Wait PLL0 Ready timeout: %0t ms", pll_ready_timeout))
        end 
      join_any
      disable fork;
      // write pll ok
      p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_field("phy_ctrl_set_5",1'b1);
      `uvm_info(report_id,"PG write PLL0 ok, please check phy top pin pipe7_pll_ok...",UVM_LOW)
    end 
endtask

task cdn_phy_bring_up_seq::get_current_lane_num();
    case (tb_cfg.std_mode)
        USB32_MODE: lane_num = dut_cfg.usb32_lane_num; 
        USB4_MODE:  lane_num = dut_cfg.usb4_lane_num;
        DP_MODE:    lane_num = dut_cfg.dp_lane_num;
        ALT_MODE:   lane_num = dut_cfg.dp_lane_num;
        PCIE_MODE:  lane_num = dut_cfg.pcie_lane_num;
        default: begin `uvm_fatal(report_id,"Protocol not correctly!"); end
    endcase
endtask

task cdn_phy_bring_up_seq::wr_cmn_speedup_cfg();
    p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_ovrd", 'h8000);
    p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ibcal_ovrd", 'h8000);
    p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_ovrd", 'h8012);
    p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_varcal_ovrd", 'h8012);
    p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_lock_refcnt_start", 'h0001);
    p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_lock_pllcnt_start", 'h0001);
    p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_lock_pllcnt_thr", 'h0FFF);
    p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpucal_ovrd", 'h8000);
    p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpdcal_ovrd", 'h8000);
    p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_rxcal_ovrd", 'h8000);
    p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_sd_cal_ovrd", 'h8001);
endtask

task cdn_phy_bring_up_seq::wr_tx_speedup_cfg(int i);
    p_sequencer.regmodel.pma_tx_lane_reg_block[i].write_dut_register("tx_duty_cycle_cal_ovrd", 'h8000);
endtask

task cdn_phy_bring_up_seq::wr_rx_speedup_cfg(int i);
    p_sequencer.regmodel.pma_rx_lane_reg_block[i].write_dut_register("rx_ctlecal0_ovrd", 'h8000);
    p_sequencer.regmodel.pma_rx_lane_reg_block[i].write_dut_register("rx_ctlecal1_ovrd", 'h8000);
    p_sequencer.regmodel.pma_rx_lane_reg_block[i].write_dut_register("rx_sdcal0_ovrd", 'h8000);
    p_sequencer.regmodel.pma_rx_lane_reg_block[i].write_dut_register("rx_sdcal1_ovrd", 'h8000);
    p_sequencer.regmodel.pma_rx_lane_reg_block[i].write_dut_register("rx_slc_ipp_ovrd", 'h8080);
    p_sequencer.regmodel.pma_rx_lane_reg_block[i].write_dut_register("rx_slc_ipm_ovrd", 'h8080);
    p_sequencer.regmodel.pma_rx_lane_reg_block[i].write_dut_register("rx_slc_qpp_ovrd", 'h8080);
    p_sequencer.regmodel.pma_rx_lane_reg_block[i].write_dut_register("rx_slc_qpm_ovrd", 'h8080);
    p_sequencer.regmodel.pma_rx_lane_reg_block[i].write_dut_register("rx_slc_epp_ovrd", 'h8080);
    p_sequencer.regmodel.pma_rx_lane_reg_block[i].write_dut_register("rx_slc_epm_ovrd", 'h8080);
    p_sequencer.regmodel.pma_rx_lane_reg_block[i].write_dut_register("rx_qcccal_ovrd", 'h8000);
endtask

// pg main task
task cdn_phy_bring_up_seq::run_pg_cfg();
    case(tb_cfg.std_mode)
        USB32_MODE: proc_usb32_pg();
        USB4_MODE:  proc_usb4_pg();
        DP_MODE:    proc_dp_pg();
        ALT_MODE:   begin  proc_alt_mode_pg(); proc_alt_mode_cmn_pg(); end 
        PCIE_MODE:  proc_pcie_pg();
        default: begin `uvm_fatal(report_id,"Protocol not correctly!"); end
    endcase
endtask 

task cdn_phy_bring_up_seq::proc_usb32_pg();
    case(dut_cfg.ref_clk_mode)
        REFCLK_19_2M: proc_usb32_19p2mhz_ssc();
        REFCLK_24M:   proc_usb32_24mhz_ssc();
        REFCLK_100M:  proc_usb32_100mhz_ssc();
        default: begin `uvm_fatal(report_id,"Refclk not correctly!"); end
    endcase
endtask

task cdn_phy_bring_up_seq::proc_usb4_pg();
    case(dut_cfg.ref_clk_mode)
        REFCLK_19_2M: proc_usb4_19p2mhz_ssc();
        REFCLK_24M:   proc_usb4_24mhz_ssc();
        REFCLK_100M:  proc_usb4_100mhz_ssc();
        default: begin `uvm_fatal(report_id,"Refclk not correctly!") end 
	endcase
endtask

task cdn_phy_bring_up_seq::proc_dp_pg();
    case(dut_cfg.ref_clk_mode)
        REFCLK_19_2M: proc_dp_19p2mhz_ssc();
        REFCLK_24M:   proc_dp_24mhz_ssc();
        REFCLK_100M:  proc_dp_100mhz_ssc();
        default: begin `uvm_fatal(report_id,"Refclk not correctly!"); end 
    endcase
endtask

task cdn_phy_bring_up_seq::proc_alt_mode_pg();
    case(dut_cfg.alt_mode)
        USB32_MODE: begin  proc_usb32_pg(); end 
        DP_MODE:    begin  proc_dp_pg(); end 
        default: begin `uvm_fatal(report_id,"Alt mode not set correctly!"); end 
    endcase
endtask

// process alt mode cmn reg 
task cdn_phy_bring_up_seq::proc_alt_mode_cmn_pg();
	p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h5100);
	//dp task will clear pll0 enable and pll0 rst_n, need add pll enable/rst_n set additionlly 
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8081); 
	
	// dp task will diasable pll0, need add pll0 cfg additionlly
	p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h6060001);
    p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog1_clk_ctrl_m0",'h4040001);
    case(dut_cfg.dp_lane_num)
        'd1: begin  
                p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h0102);
             end 
        'd2: begin  
                p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h0100); 
             end
        default : begin  `uvm_fatal(report_id,"At alt mode, DP lane number must set 1 or 2 ")  end 
    endcase 
endtask

task cdn_phy_bring_up_seq::proc_pcie_pg();
    case(dut_cfg.ref_clk_mode)
        REFCLK_19_2M: proc_pcie_19p2mhz_ssc();
        REFCLK_24M:   proc_pcie_24mhz_ssc();
        REFCLK_100M:  proc_pcie_100mhz_ssc();
        default: begin `uvm_fatal(report_id,"Refclk not correctly!"); end 
    endcase
endtask


task cdn_phy_bring_up_seq::cfg_info_display(string prot,gen_speed_t rate);
    int lane_number;
    case (tb_cfg.std_mode)
        USB32_MODE: lane_number = dut_cfg.usb32_lane_num;
        USB4_MODE:  lane_number = dut_cfg.usb4_lane_num;
        DP_MODE:    lane_number = dut_cfg.dp_lane_num;
        PCIE_MODE:  ;
        ALT_MODE:   lane_number = dut_cfg.usb32_lane_num;
    endcase
    `uvm_info (report_id,$psprintf("start to PG cfg, Protocol: %s, Lane num: %0d, Refclk: %p, RATE: %p, SSC: %p, flipped_plug: %p",prot,lane_number,dut_cfg.ref_clk_mode,rate,dut_cfg.ssc_mode,dut_cfg.flip_flag),UVM_LOW)
endtask

task cdn_phy_bring_up_seq::cfg_dp_info_display(dp_bit_rate_t dp_rate);
    `uvm_info (report_id,$psprintf("start to PG cfg, Protocol: DP, Lane num: %0d, Refclk: %p, RATE: %p, SSC: %p, flipped_plug: %p",dut_cfg.dp_lane_num,dut_cfg.ref_clk_mode,dp_rate,dut_cfg.ssc_mode,dut_cfg.flip_flag),UVM_LOW)
endtask


/******************  alt mode   TODO********************/
task cdn_phy_bring_up_seq::proc_alt_mode_19p2mhz_ssc();
    // cfg_info_display("ALT_MODE",dut_cfg.alt_mode_gen_speed);
    // case(dut_cfg.alt_mode_gen_speed)
    //     GEN1_SPEED:alt_mode_19p2_gen1_pg_wr_task();
    //     GEN2_SPEED:alt_mode_19p2_gen2_pg_wr_task();
    // endcase
endtask
task cdn_phy_bring_up_seq::proc_alt_mode_24mhz_ssc();
    // cfg_info_display("ALT_MODE",dut_cfg.alt_mode_gen_speed);
    // case(dut_cfg.alt_mode_gen_speed)
    //     GEN1_SPEED:alt_mode_24p0_gen1_pg_wr_task();
    //     GEN2_SPEED:alt_mode_24p0_gen2_pg_wr_task();
    // endcase
endtask
task cdn_phy_bring_up_seq::proc_alt_mode_100mhz_ssc();
    // cfg_info_display("ALT_MODE",dut_cfg.alt_mode_gen_speed);
    // case(dut_cfg.alt_mode_gen_speed)
    //     GEN1_SPEED:alt_mode_100p0_gen1_pg_wr_task();
    //     GEN2_SPEED:alt_mode_100p0_gen2_pg_wr_task();
    // endcase
endtask


/******************* pcie part TODO*******************/
task cdn_phy_bring_up_seq::proc_pcie_19p2mhz_ssc();
   // cfg_info_display("PCIE",dut_cfg.pcie_gen_speed);
   // case(dut_cfg.pcie_gen_speed)
   //     GEN1_SPEED:pcie_19p2_gen1_pg_wr_task();
   //     GEN2_SPEED:pcie_19p2_gen2_pg_wr_task();
   // endcase
endtask
task cdn_phy_bring_up_seq::proc_pcie_24mhz_ssc();
   // cfg_info_display("PCIE",dut_cfg.pcie_gen_speed);
   // case(dut_cfg.pcie_gen_speed)
   //     GEN1_SPEED:pcie_24p0_gen1_pg_wr_task();
   //     GEN2_SPEED:pcie_24p0_gen2_pg_wr_task();
   // endcase
endtask
task cdn_phy_bring_up_seq::proc_pcie_100mhz_ssc();
   // cfg_info_display("PCIE",dut_cfg.pcie_gen_speed);
   // case(dut_cfg.pcie_gen_speed)
   //     GEN1_SPEED:pcie_100p0_gen1_pg_wr_task();
   //     GEN2_SPEED:pcie_100p0_gen2_pg_wr_task();
   // endcase
endtask


/*******************  usb32 part *****************/

//  usb32 19p2 task
task cdn_phy_bring_up_seq::usb32_19p2_gen1_pg_wr_task();
    if(dut_cfg.ssc_mode)
        write_usb_tcam_gen1_none_int_19p2_pll0_Enable_ssc_pll1_None_ssc_pg_reg(dut_cfg.usb32_lane_num,"",dut_cfg.flip_flag);
    else 
        write_usb_tcam_gen1_none_int_19p2_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.usb32_lane_num,"",dut_cfg.flip_flag);
endtask

task cdn_phy_bring_up_seq::usb32_19p2_gen2_pg_wr_task();
    if(dut_cfg.ssc_mode)
        write_usb_tcam_gen2_none_int_19p2_pll0_Enable_ssc_pll1_None_ssc_pg_reg(dut_cfg.usb32_lane_num,"",dut_cfg.flip_flag);
    else 
        write_usb_tcam_gen2_none_int_19p2_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.usb32_lane_num,"",dut_cfg.flip_flag);
endtask

// usb32 24MHZ task
task cdn_phy_bring_up_seq::usb32_24p0_gen1_pg_wr_task();
    if(dut_cfg.ssc_mode)
        write_usb_tcam_gen1_none_int_24p0_pll0_Enable_ssc_pll1_None_ssc_pg_reg(dut_cfg.usb32_lane_num,"",dut_cfg.flip_flag);
    else 
        write_usb_tcam_gen1_none_int_24p0_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.usb32_lane_num,"",dut_cfg.flip_flag);
endtask

task cdn_phy_bring_up_seq::usb32_24p0_gen2_pg_wr_task();
    if(dut_cfg.ssc_mode)
        write_usb_tcam_gen2_none_int_24p0_pll0_Enable_ssc_pll1_None_ssc_pg_reg(dut_cfg.usb32_lane_num,"",dut_cfg.flip_flag);
    else 
        write_usb_tcam_gen2_none_int_24p0_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.usb32_lane_num,"",dut_cfg.flip_flag);
endtask
//usb32 100MHZ task
task cdn_phy_bring_up_seq::usb32_100p0_gen1_pg_wr_task();
    if(dut_cfg.ssc_mode)
        write_usb_tcam_gen1_none_int_100p0_pll0_Enable_ssc_pll1_None_ssc_pg_reg(dut_cfg.usb32_lane_num,"",dut_cfg.flip_flag);
    else 
        write_usb_tcam_gen1_none_int_100p0_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.usb32_lane_num,"",dut_cfg.flip_flag);
endtask

task cdn_phy_bring_up_seq::usb32_100p0_gen2_pg_wr_task();
    if(dut_cfg.ssc_mode)
        write_usb_tcam_gen2_none_int_100p0_pll0_Enable_ssc_pll1_None_ssc_pg_reg(dut_cfg.usb32_lane_num,"",dut_cfg.flip_flag);
    else 
        write_usb_tcam_gen2_none_int_100p0_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.usb32_lane_num,"",dut_cfg.flip_flag);
endtask

task cdn_phy_bring_up_seq::proc_usb32_19p2mhz_ssc();
    cfg_info_display("USB32",dut_cfg.usb32_gen_speed);
    case(dut_cfg.usb32_gen_speed)
        GEN1_SPEED:usb32_19p2_gen1_pg_wr_task();
        GEN2_SPEED:usb32_19p2_gen2_pg_wr_task();
    endcase
endtask
task cdn_phy_bring_up_seq::proc_usb32_24mhz_ssc();
    cfg_info_display("USB32",dut_cfg.usb32_gen_speed);
    case(dut_cfg.usb32_gen_speed)
        GEN1_SPEED:usb32_24p0_gen1_pg_wr_task();
        GEN2_SPEED:usb32_24p0_gen2_pg_wr_task();
    endcase
endtask
task cdn_phy_bring_up_seq::proc_usb32_100mhz_ssc();
    cfg_info_display("USB32",dut_cfg.usb32_gen_speed);
    case(dut_cfg.usb32_gen_speed)
        GEN1_SPEED:usb32_100p0_gen1_pg_wr_task();
        GEN2_SPEED:usb32_100p0_gen2_pg_wr_task();
    endcase
endtask

/*************************   usb4 part   ***************************/

// usb4 19.2MZH task
task cdn_phy_bring_up_seq::usb4_19p2_pg_wr_task();
    if(dut_cfg.ssc_mode)
        write_usb4_tcam_none_int_19p2_pll0_Enable_ssc_pll1_None_ssc_pg_reg(dut_cfg.usb4_lane_num,"",dut_cfg.flip_flag);
    else 
        write_usb4_tcam_none_int_19p2_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.usb4_lane_num,"",dut_cfg.flip_flag);
endtask
// usb4 24MHZ task
task cdn_phy_bring_up_seq::usb4_24p0_pg_wr_task();
    if(dut_cfg.ssc_mode)
        write_usb4_tcam_none_int_24p0_pll0_Enable_ssc_pll1_None_ssc_pg_reg(dut_cfg.usb4_lane_num,"",dut_cfg.flip_flag);
    else 
        write_usb4_tcam_none_int_24p0_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.usb4_lane_num,"",dut_cfg.flip_flag);
endtask
// usb4 100MHZ task
task cdn_phy_bring_up_seq::usb4_100p0_pg_wr_task();
    if(dut_cfg.ssc_mode)
        write_usb4_tcam_none_int_100p0_pll0_Enable_ssc_pll1_None_ssc_pg_reg(dut_cfg.usb4_lane_num,"",dut_cfg.flip_flag);
    else 
        write_usb4_tcam_none_int_100p0_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.usb4_lane_num,"",dut_cfg.flip_flag);
endtask

task cdn_phy_bring_up_seq::proc_usb4_19p2mhz_ssc();
    cfg_info_display("USB4",dut_cfg.usb4_gen_speed);
    case(dut_cfg.usb4_gen_speed)
        GEN2_SPEED: usb4_19p2_pg_wr_task();
        GEN3_SPEED: usb4_19p2_pg_wr_task();
        GEN4_SPEED: usb4_19p2_pg_wr_task();
    endcase
endtask
task cdn_phy_bring_up_seq::proc_usb4_24mhz_ssc();
    cfg_info_display("USB4",dut_cfg.usb4_gen_speed);
    case(dut_cfg.usb4_gen_speed)
        GEN2_SPEED: usb4_24p0_pg_wr_task(); 
        GEN3_SPEED: usb4_24p0_pg_wr_task(); 
        GEN4_SPEED: usb4_24p0_pg_wr_task(); 
    endcase
endtask
task cdn_phy_bring_up_seq::proc_usb4_100mhz_ssc();
    cfg_info_display("USB4",dut_cfg.usb4_gen_speed);
    case(dut_cfg.usb4_gen_speed)
        GEN2_SPEED: usb4_100p0_pg_wr_task();
        GEN3_SPEED: usb4_100p0_pg_wr_task();
        GEN4_SPEED: usb4_100p0_pg_wr_task();
    endcase
endtask


/*********************** dp part *********************/


// dp 19.2 MHZ
task cdn_phy_bring_up_seq::proc_dp_19p2mhz_ssc();
    cfg_dp_info_display(dut_cfg.dp_data_rate);
    /*case(dut_cfg.dp_data_rate)
        DP_RBR: 	begin 
                    	if(dut_cfg.ssc_mode)  
                        	write_dp_1p62_none_int_19p2_pll0_Enable_ssc_pll1_Enable_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag); 
                        else  
                        	write_dp_1p62_none_int_19p2_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
                	end 
        DP_HBR: 	begin 
                    	if(dut_cfg.ssc_mode)  
                        	write_dp_2p7_none_int_19p2_pll0_Enable_ssc_pll1_Enable_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag); 
                    	else  
                        	write_dp_2p7_none_int_19p2_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
                	end
        DP_HBR2:    begin 
                        if(dut_cfg.ssc_mode)  
                            write_dp_5p4_none_int_19p2_pll0_Enable_ssc_pll1_Enable_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag); 
                        else  
                            write_dp_5p4_none_int_19p2_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
					end
        DP_HBR3:    begin    
						if(dut_cfg.ssc_mode)  
                            write_dp_8p1_none_int_19p2_pll0_Enable_ssc_pll1_Enable_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag); 
                        else  
                            write_dp_8p1_none_int_19p2_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
                    end
        DP_UHBR10:  begin 
                        if(dut_cfg.ssc_mode)  
                            write_dp_10p0_none_int_19p2_pll0_Enable_ssc_pll1_Enable_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag); 
                        else  
                            write_dp_10p0_none_int_19p2_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
                    end
        DP_UHBR13P5:begin 
                        if(dut_cfg.ssc_mode)  
                            write_dp_13p5_none_int_19p2_pll0_Enable_ssc_pll1_Enable_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag); 
                        else  
                            write_dp_13p5_none_int_19p2_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
                    end
        DP_UHBR20:begin 
                    if(dut_cfg.ssc_mode)  
                        write_dp_20p0_none_int_19p2_pll0_Enable_ssc_pll1_Enable_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag); 
                    else  
                        write_dp_20p0_none_int_19p2_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
                  end
    endcase*/
endtask

// DP 24MZH 

task cdn_phy_bring_up_seq::proc_dp_24mhz_ssc();
    cfg_dp_info_display(dut_cfg.dp_data_rate);
    /*case(dut_cfg.dp_data_rate)
        DP_RBR: begin 
                    if(dut_cfg.ssc_mode)  
                        write_dp_1p62_none_int_24p0_pll0_Enable_ssc_pll1_Enable_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag); 
                    else  
                        write_dp_1p62_none_int_24p0_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
                end 
        DP_HBR: begin 
                    if(dut_cfg.ssc_mode)  
                        write_dp_2p7_none_int_24p0_pll0_Enable_ssc_pll1_Enable_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag); 
                    else  
                        write_dp_2p7_none_int_24p0_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
                end
        DP_HBR2:    begin 
                        if(dut_cfg.ssc_mode)  
                            write_dp_5p4_none_int_24p0_pll0_Enable_ssc_pll1_Enable_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag); 
                        else  
                            write_dp_5p4_none_int_24p0_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
					end
        DP_HBR3:    begin
						if(dut_cfg.ssc_mode)  
                            write_dp_8p1_none_int_24p0_pll0_Enable_ssc_pll1_Enable_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag); 
                        else  
                            write_dp_8p1_none_int_24p0_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
                    end
        DP_UHBR10:  begin 
                        if(dut_cfg.ssc_mode)  
                            write_dp_10p0_none_int_24p0_pll0_Enable_ssc_pll1_Enable_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag); 
                        else  
                            write_dp_10p0_none_int_24p0_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
                    end
        DP_UHBR13P5:begin 
                        if(dut_cfg.ssc_mode)  
                            write_dp_13p5_none_int_24p0_pll0_Enable_ssc_pll1_Enable_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag); 
                        else  
                            write_dp_13p5_none_int_24p0_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
                    end
        DP_UHBR20:  begin 
                    	if(dut_cfg.ssc_mode)  
                        	write_dp_20p0_none_int_24p0_pll0_Enable_ssc_pll1_Enable_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag); 
                    	else  
                        	write_dp_20p0_none_int_24p0_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
                    end
    endcase*/
endtask

//DP 100MHZ
task cdn_phy_bring_up_seq::proc_dp_100mhz_ssc();
    cfg_dp_info_display(dut_cfg.dp_data_rate);
    case(dut_cfg.dp_data_rate)
        DP_RBR: begin 
                    if(dut_cfg.ssc_mode)  
                        write_dp_1p62_none_int_100p0_pll0_None_ssc_pll1_Enable_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag); 
                    else  
                        write_dp_1p62_none_int_100p0_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
                end 
        DP_HBR: begin 
                    if(dut_cfg.ssc_mode)  
                        write_dp_2p7_none_int_100p0_pll0_None_ssc_pll1_Enable_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag); 
                    else  
                        write_dp_2p7_none_int_100p0_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
                end
        DP_HBR2:    begin 
                        if(dut_cfg.ssc_mode)  
                            write_dp_5p4_none_int_100p0_pll0_None_ssc_pll1_Enable_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag); 
                        else  
                            write_dp_5p4_none_int_100p0_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
                    end
        DP_HBR3:    begin 
                        if(dut_cfg.ssc_mode)  
                            write_dp_8p1_none_int_100p0_pll0_None_ssc_pll1_Enable_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag); 
                        else  
                            write_dp_8p1_none_int_100p0_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
                    end
        DP_UHBR10:  begin 
                        if(dut_cfg.ssc_mode)  
                            write_dp_10_none_int_100p0_pll0_None_ssc_pll1_Enable_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag); 
                        else  
                            write_dp_10_none_int_100p0_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
                    end
        DP_UHBR13P5:begin 
                        if(dut_cfg.ssc_mode)  
                            write_dp_13p5_none_int_100p0_pll0_None_ssc_pll1_Enable_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
						else  
                            write_dp_13p5_none_int_100p0_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
                    end
        DP_UHBR20:begin 
                    if(dut_cfg.ssc_mode)  
                        write_dp_20_none_int_100p0_pll0_None_ssc_pll1_Enable_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag); 
                    else  
                        write_dp_20_none_int_100p0_pll0_None_ssc_pll1_None_ssc_pg_reg(dut_cfg.dp_lane_num,dut_cfg.dp_preemph_level,dut_cfg.dp_vswing_level,dut_cfg.flip_flag);
                    end
    endcase
endtask

`endif
