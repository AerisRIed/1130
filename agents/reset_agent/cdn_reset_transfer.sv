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
//   Filename:           cdn_reset_transfer.sv
//   Module Name:        cdn_reset_transfer.sv
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
// This file defines the basic transfer item for the cdn_reset OVC.
//----------------------------------------------------------------------------

`ifndef CDN_RESET_TRANSFER_SV
`define CDN_RESET_TRANSFER_SV

typedef struct {rand bit reset_en; rand int reset_time;} reset_t;

class cdn_reset_transfer extends uvm_sequence_item;

    //------------------------------------------------------------------------
    // CONTROL MEMBER VARIABLES.
    //------------------------------------------------------------------------

    // Reset Duration in clock cycles.
	rand reset_t pipe_reset;
	rand reset_t phy_reset;
	rand reset_t apb_reset;
	rand reset_t uc_reset;
	rand reset_t jtag_reset;

    //------------------------------------------------------------------------
    // CONSTRAINT BLOCKS.
    //------------------------------------------------------------------------

    constraint reset_duration_c {
        pipe_reset.reset_time inside {[100:1000]};
        phy_reset.reset_time inside {[100:1000]};
        apb_reset.reset_time inside {[100:1000]};
        uc_reset.reset_time inside {[100:1000]};
        jtag_reset.reset_time inside {[100:1000]};
    }

    //------------------------------------------------------------------------
    // UVM AUTOMATION MACROS.
    //------------------------------------------------------------------------

    // The field marcos are required for packing/unpacking and checking.
    `uvm_object_utils_begin(cdn_reset_transfer)
        //`uvm_field_int(pipe_reset,UVM_ALL_ON)
        //`uvm_field_int(phy_reset,UVM_ALL_ON)
        //`uvm_field_int(apb_reset,UVM_ALL_ON)
        //`uvm_field_int(uc_reset,UVM_ALL_ON)
        //`uvm_field_int(jtag_reset,UVM_ALL_ON)
    `uvm_object_utils_end

    //------------------------------------------------------------------------
    // STATUS MEMBER VARIABLES.
    //------------------------------------------------------------------------

    // The monitor should update this member variable with the simulation time
    // value when this packet is observed.
    // This is useful for checking DUT latencies.
    //------------------------------------------------------------------------
    // EXTEND OR OVERRIDE BASE METHODS
    //------------------------------------------------------------------------
    function new (string name = "cdn_reset_transfer_inst");
        super.new(name);
    endfunction : new
    
endclass : cdn_reset_transfer

`endif

//----------------------------------------------------------------------------
// End of file
//----------------------------------------------------------------------------
