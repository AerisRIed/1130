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
//   Filename:           cdn_reset_pkg.sv
//   Module Name:        cdn_reset_pkg.sv
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
// This file is the top level file which imports all of the components of the
// UVC and declares them as a package.
//----------------------------------------------------------------------------

`ifndef CDN_RESET_PKG_SV
`define CDN_RESET_PKG_SV

`timescale 1ns / 1fs
package cdn_reset_pkg;

    //------------------------------------------------------------------------
    // IMPORT UVM PACKAGE
    //------------------------------------------------------------------------
    // UVM class library compiled in a package
    import uvm_pkg::*;
	import tb_param::*;

	typedef virtual cdn_phy_interface_base#(
        .PD_WIDTH(tb_param::PD_WIDTH)
    ) cdn_phy_vif_t;
     
    typedef enum {
        USB32      = 0,
        DP         = 1
    } alt_mode_t;

    // Bring in the rest of the library (macros)
    `include "uvm_macros.svh"

    //------------------------------------------------------------------------
    // Import the files which comprise this OVC
    //------------------------------------------------------------------------
    //`include "cdn_reset_defines.svh"
    `include "cdn_reset_config.sv"
    `include "cdn_reset_transfer.sv"
    //`include "cdn_reset_monitor.sv"
    `include "cdn_reset_sequencer.sv"
    `include "cdn_reset_sequence_lib.sv"
    `include "cdn_reset_driver.sv"
    `include "cdn_reset_agent.sv"
    //`include "cdn_reset_env.sv"

endpackage : cdn_reset_pkg

`endif
//----------------------------------------------------------------------------
// End of file
//----------------------------------------------------------------------------
