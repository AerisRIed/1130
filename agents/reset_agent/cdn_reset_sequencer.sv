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
//   Filename:           cdn_reset_sequencer.sv
//   Module Name:        cdn_reset_sequencer.sv
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
// This file creates an UVM compliant sequencer.
//----------------------------------------------------------------------------

`ifndef CDN_RESET_SEQUENCER_SV
`define CDN_RESET_SEQUENCER_SV

class cdn_reset_sequencer extends uvm_sequencer #(cdn_reset_transfer);

    //------------------------------------------------------------------------
    // UVM AUTOMATION MACROS.
    //------------------------------------------------------------------------
    `uvm_component_utils(cdn_reset_sequencer)

    //------------------------------------------------------------------------
    // EXTEND OR OVERRIDE BASE METHODS
    //------------------------------------------------------------------------

    // Extend the new method and register the transfer item.
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

endclass : cdn_reset_sequencer

`endif

//----------------------------------------------------------------------------
// End of file
//----------------------------------------------------------------------------
