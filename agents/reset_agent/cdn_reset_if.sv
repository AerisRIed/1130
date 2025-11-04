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
//   Filename:           cdn_reset_if.sv
//   Module Name:        cdn_reset_if.sv
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
// This file defines the basic interface for the cdn_reset UVC.
//----------------------------------------------------------------------------

interface cdn_reset_if();

    //------------------------------------------------------------------------
    // CONTROL MEMBER VARIABLES.
    //------------------------------------------------------------------------
	logic phy_reset = 1'b0;
	logic apb_reset = 1'b0;
	logic uc_reset  = 1'b0;
 	logic jtag_reset = 1'b0;

    //------------------------------------------------------------------------
    // INTERFACE SIGNALS.
    //------------------------------------------------------------------------



endinterface : cdn_reset_if

//----------------------------------------------------------------------------
// End of file
//----------------------------------------------------------------------------
