//------------------------------------------------------------------------------
// Copyright (c) 2021 Cadence Design Systems, Inc.
//
// The information herein (Cadence IP) contains confidential and proprietary
// information of Cadence Design Systems, Inc. Cadence IP may not be modified,
// copied, reproduced, distributed, or disclosed to third parties in any manner,
// medium, or form, in whole or in part, without the prior written consent of
// Cadence Design Systems Inc. Cadence IP is for use by Cadence Design Systems,
// Inc. customers only. Cadence Design Systems, Inc. reserves the right to make
// changes to Cadence IP at any time and without notice.
//------------------------------------------------------------------------------
//
//   Filename:           cdn_reset_driver.sv
//   Module Name:        cdn_reset_driver.sv
//
//   Release Revision:   1.0
//
//   Product Type:       Configurable
//   IP Type:            Soft IP
//   IP Family:          Storage
//   Technology:         N/A
//   Protocol:           ONFi5.0
//   Architecture:       PHY
//
//------------------------------------------------------------------------------
// Description :
// This file defines the driver (BFM) for the cdn_reset UVC.
//----------------------------------------------------------------------------

`ifndef CDN_RESET_DRIVER_SV
`define CDN_RESET_DRIVER_SV

class cdn_reset_driver extends uvm_driver #(cdn_reset_transfer);

    //------------------------------------------------------------------------
    // INTERFACE.
    //------------------------------------------------------------------------

    // The virtual interface used to drive and view HDL signals.
	cdn_phy_vif_t  				pipe_agt_if; // for pipe reset
    virtual cdn_reset_if 		phy_rst_if; // only for phy reset
	int 						lane_id;
    cdn_reset_config 			m_cfg;
    //------------------------------------------------------------------------
    // CONTROL SWITCHES
    //------------------------------------------------------------------------
    
    //------------------------------------------------------------------------
    // UVM AUTOMATION MACROS.
    //------------------------------------------------------------------------

    // The component utils marco provides base virtual methods like 
    // get_type_name and create.
    `uvm_component_utils_begin(cdn_reset_driver)
	  `uvm_field_int(lane_id,             	UVM_ALL_ON)
    `uvm_component_utils_end

    //------------------------------------------------------------------------
    // EXTEND OR OVERRIDE BASE METHODS
    //------------------------------------------------------------------------

    // Extend the new method
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // Extend build_phase to attach the virtual interface
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(cdn_reset_config)::get(this, "", "m_cfg", m_cfg))
		`uvm_fatal("","reset driver cannot get reset_config")
      if(!uvm_config_db#(virtual cdn_reset_if)::get(this, "", "phy_reset_if", phy_rst_if))
		`uvm_fatal("","reset driver cannot get phy_reset_if")
	  if(!uvm_config_db#(cdn_phy_vif_t)::get(this, "", "m_drv_if", pipe_agt_if)) 
		`uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".reset_if"})
    endfunction: build_phase

    //------------------------------------------------------------------------
    // DEFINE TASKS
    //------------------------------------------------------------------------

    // The run_phase task for this class will be started automatically during
    // the run phase
    virtual task run_phase(uvm_phase phase);

        if (!m_cfg.reset_random_control) begin 
		  forever begin 
			seq_item_port.get_next_item(req);
			uvm_report_info(get_type_name(), $sformatf("lane[%0d] Asserting reset.",lane_id), UVM_LOW);
			fork
			if (req.pipe_reset.reset_en) begin
			  if (m_cfg.dp_enable) pipe_agt_if.pipe_intf.dp_reset_n = 1'b0;
			  else  pipe_agt_if.pipe_intf.Reset = 1'b0;
		      repeat(req.pipe_reset.reset_time) #1ns;
			  if (m_cfg.dp_enable) pipe_agt_if.pipe_intf.dp_reset_n = 1'b1;
			  else  pipe_agt_if.pipe_intf.Reset = 1'b1;
			end 
			if (this.lane_id == 0 && req.apb_reset.reset_en == 1) begin 
			  `uvm_info("","now assert apb_reset",UVM_LOW);
			  phy_rst_if.apb_reset = 1'b0;
		      repeat(req.apb_reset.reset_time) #1ns;
			  phy_rst_if.apb_reset = 1'b1;
			  `uvm_info("","now deassert apb_reset",UVM_LOW);
			end
			if (this.lane_id == 0 && req.uc_reset.reset_en == 1) begin 
			  phy_rst_if.uc_reset = 1'b0;
		      repeat(req.uc_reset.reset_time) #1ns;
			  phy_rst_if.uc_reset = 1'b1;
			end
			if (this.lane_id == 0 && req.jtag_reset.reset_en == 1) begin 
			  phy_rst_if.jtag_reset = 1'b0;
		      repeat(req.jtag_reset.reset_time) #1ns;
			  phy_rst_if.jtag_reset = 1'b1;
			end
			if (this.lane_id == 0 && req.phy_reset.reset_en == 1) begin 
			  phy_rst_if.phy_reset = 1'b0;
			  repeat(req.phy_reset.reset_time) #1ns; 
			  phy_rst_if.phy_reset = 1'b1;
			end
			join
            uvm_report_info(get_type_name(), $sformatf("lane[%0d] Asserting reset.",lane_id), UVM_LOW);
			seq_item_port.item_done();
		  end
		end
		else begin 
		  fork
		  forever begin 
			if (m_cfg.dp_enable) pipe_agt_if.pipe_intf.dp_reset_n = 1'b0;
			else  pipe_agt_if.pipe_intf.Reset = 1'b0;
		    repeat($urandom_range(100,1000)) #1ns;
			if (m_cfg.dp_enable) pipe_agt_if.pipe_intf.dp_reset_n = 1'b1;
			else  pipe_agt_if.pipe_intf.Reset = 1'b1;
		    repeat($urandom_range(100,1000)) #1us;
		  end
		  forever begin 
			phy_rst_if.phy_reset = 1'b0;
			repeat($urandom_range(100,1000)) #1ns; 
			phy_rst_if.phy_reset = 1'b1;
		    repeat($urandom_range(100,1000)) #1us;
		  end
		  forever begin 
			phy_rst_if.uc_reset = 1'b0;
			repeat($urandom_range(100,1000)) #1ns; 
			phy_rst_if.uc_reset = 1'b1;
		    repeat($urandom_range(100,1000)) #1us;
		  end
		  join
		end
    endtask : run_phase

endclass : cdn_reset_driver

`endif

//----------------------------------------------------------------------------
// End of file
//----------------------------------------------------------------------------
