
//
// Template for UVM-compliant testcase

`ifndef cdn_u4_usb4_test_base__SV
`define cdn_u4_usb4_test_base__SV

class cdn_u4_usb4_test_base extends cdn_phy_test_base;

  `uvm_component_utils(cdn_u4_usb4_test_base)

  cdn_u4_usb4_env usb4_env;
  `ifndef DUT_BYPASS
  cdn_phy_bring_up_seq bring_up_seq;
  cdn_reset_sequence  reset_seq;
  cdn_reset_sequence  pipe7_reset_seq;
  virtual cdn_phy_design_interface phy_design_if;
  `endif
 // cdn_phy_vif_t   usb4_env.host_agent.pipe_agt_if[0];
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

function void reconfig_dut_cfg();
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

    //dut_cfg.ref_clk_mode = REFCLK_24M;
	//dut_cfg.ssc_mode     = SSC_DISABLE;
    dut_cfg.usb4_lane_num='d2;
endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
        `uvm_info(get_name(), $psprintf("\033[1;42m build Please check waveform \033[0m "), UVM_LOW)
        usb4_env = cdn_u4_usb4_env::type_id::create("usb4_env", this);
		`ifndef DUT_BYPASS
        if(!uvm_config_db#(virtual cdn_phy_design_interface )::get(null, " ", "phy_design_if", phy_design_if)) begin
        	`uvm_fatal(get_name(), "phy design interface don't get correctly!")
    	end 
        bring_up_seq = cdn_phy_bring_up_seq::type_id::create("bring_up_seq", this);
		reset_seq = cdn_reset_sequence::type_id::create("reset_seq", this);
		pipe7_reset_seq = cdn_reset_sequence::type_id::create("pipe7_reset_seq", this);
        `endif
        
        //uvm_config_db#(uvm_object_wrapper)::set(this,$psprintf("usb4_env.usb4_vsqr.main_phase"),"default_sequence",cdn_u4_usb4_base_sequence::type_id::get());
  endfunction

  virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    	usb4_env.host_agent.usb4_cfg.usb4_gen_speed = dut_cfg.usb4_gen_speed ; 
    	usb4_env.device_agent.usb4_cfg.usb4_gen_speed = dut_cfg.usb4_gen_speed ; 
    	usb4_env.host_agent.usb4_cfg.flip= dut_cfg.flip; 
    	usb4_env.device_agent.usb4_cfg.flip= dut_cfg.flip; 
        //uvm_callbacks#(cdn_u4_usb4_driver,cdn_callback)::add(usb4_env.host_agent.usb4_drv[0],m_callback);
        //uvm_callbacks#(cdn_u4_usb4_driver,cdn_callback)::add(usb4_env.host_agent.usb4_drv[1],m_callback);
        //uvm_callbacks#(cdn_u4_usb4_driver,cdn_callback)::add(usb4_env.device_agent.usb4_drv[0],m_callback);
        //uvm_callbacks#(cdn_u4_usb4_driver,cdn_callback)::add(usb4_env.device_agent.usb4_drv[1],m_callback);
  endfunction
  
  virtual task dyn_main_phase();
		`uvm_info(get_name(), $psprintf("\033[1;42m usb4_base_test start \033[0m "), UVM_LOW)
    `ifndef DUT_BYPASS		
       `uvm_info(get_name(), $psprintf(" bring_up seq start"), UVM_LOW)
		fork
			begin
				repeat($urandom_range(100,1000)) #1ns;
				bring_up_seq.start(usb4_env.vsqr);
			end
			begin
				repeat($urandom_range(100,1000)) #1ns;
            	wait(usb4_env.host_agent.pipe_agt_if[0].usb4_debug_intf.initial_done=='d1);//for Rate change debug TODO
                pipe7_reset_seq. pipe_reset_en= 1;                       //pipe_reset_en == pipe7_reset_n 
				pipe7_reset_seq.start(usb4_env.vsqr.m_reset_sqr[0]);
			end
			begin
				repeat($urandom_range(100,1000)) #1ns;
				wait(phy_design_if.phy_uc_init_complete=='d1);
				reset_seq. phy_reset_en = 1;                       //pipe_reset_en == pipe7_reset_n 
				reset_seq.start(usb4_env.vsqr.m_reset_sqr[0]);
			end
			begin
				repeat($urandom_range(100,1000)) #1ns;
				wait_phy_ready_task();
			end
		join
	   `uvm_info(get_name(), $psprintf(" bring_up seq finish"), UVM_LOW)
   `endif
//callback demo       
       usb4_env.host_agent.pipe_agt_if[0].usb4_debug_intf.tx_rx_enable= 1;
       usb4_env.device_agent.pipe_agt_if[0].usb4_debug_intf.tx_rx_enable= 1;
     wait(usb4_env.host_agent.port_status.usb4_ltssm_state == USB4_LINK::CL0&&usb4_env.device_agent.port_status.usb4_ltssm_state == USB4_LINK::CL0);
       #10us;

        `uvm_info(get_name(), $psprintf("\033[1;42m sub4_base_test finish \033[0m "), UVM_LOW)
    endtask

	task wait_phy_ready_task();
    `ifndef DUT_BYPASS
        `uvm_info(get_name(), $psprintf("wait_phy_ready_task start "), UVM_LOW)
		wait(phy_design_if.phy_uc_init_complete=='d1);

		usb4_env.host_agent.pipe_agt_if[0].pipe_intf.pipe7_pll0_en = 1'b0;
		repeat($urandom_range(100,1000)) #1ns; 
		usb4_env.host_agent.pipe_agt_if[0].pipe_intf.pipe7_pll0_en = 1'b1;
		repeat($urandom_range(100,1000)) #1us;

		usb4_pll_ok_drive();

		wait (usb4_env.host_agent.pipe_agt_if[0].pipe_intf.pipe7_pll0_ok=='d1);
		usb4_env.host_agent.pipe_agt_if[0].pipe_intf.pipe7_clk_max_req = 1'b0;
		repeat($urandom_range(100,1000)) #1ns; 
		usb4_env.host_agent.pipe_agt_if[0].pipe_intf.pipe7_clk_max_req = 1'b1;
		repeat($urandom_range(100,1000)) #1us;

		wait(usb4_env.host_agent.pipe_agt_if[0].pipe_intf.pipe7_clk_max_ack=='d1);
		wait(usb4_env.host_agent.pipe_agt_if[0].pipe_intf.PhyStatus=='d0 & usb4_env.host_agent.pipe_agt_if[1].pipe_intf.PhyStatus=='d0);
        
	    `uvm_info(get_name(), $psprintf("wait_phy_ready_task finish "), UVM_LOW)
    `endif
	endtask


task usb4_pll_ok_drive();
`ifndef DUT_BYPASS
    time pll_ready_timeout = 2ms;
    bit [31:0] rdata =32'h0; 
    bit [31:0] mask = 32'h0089;
    if (tb_cfg.fw_writes_pg) begin
      `uvm_info(get_name(),"Wait PLL0 Ready...",UVM_LOW)
    end else begin
      fork 
        begin
          `uvm_info (get_name, "Polling PHY_PMA_CMN_CTRL_STS register, Wait PLL0 ready...",UVM_LOW)
          while(rdata != mask) begin
            usb4_env.vsqr.regmodel.phy_pma_cmn_reg_block.read_dut_register("phy_pma_cmn_ctrl_sts",rdata);
            rdata =  rdata & mask;
            #20us; // avoid too many read trans
          end 
          `uvm_info (get_name, "PLL0 Ready Done Done Done...",UVM_LOW)
        end 
        begin
          // timeout 
          #pll_ready_timeout;
          `uvm_fatal(get_name,$psprintf("Wait PLL0 Ready timeout: %0t ms", pll_ready_timeout))
        end 
      join_any
	  disable fork;
      // write pll ok
      usb4_env.vsqr.regmodel.phy_pcs_cmn_reg_block.write_dut_field("phy_ctrl_set_5",1'b1);
      `uvm_info(get_name,"PG write PLL0 ok, please check phy top pin pipe7_pll_ok...",UVM_LOW)
    end 
`endif
endtask
	
endclass : cdn_u4_usb4_test_base

`endif //TEST__SV

