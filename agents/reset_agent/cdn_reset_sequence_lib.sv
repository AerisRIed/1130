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
//   Filename:           cdn_reset_sequence_lib.sv
//   Module Name:        cdn_reset_sequence_lib.sv
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
// This file contains default sequences for the cdn_reset UVC.
//----------------------------------------------------------------------------

//----------------------------------------------------------------------------
// SEQUENCE NAME: random_reset_stream_seq
//----------------------------------------------------------------------------
// DESCRIPTION:
// This sequence emulates a stream of legal resets. With the ability to
// change the reset duration. 
//----------------------------------------------------------------------------
class cdn_reset_sequence extends uvm_sequence #(cdn_reset_pkg::cdn_reset_transfer);

    //------------------------------------------------------------------------
    // CONTROL MEMBER VARIABLES
    //------------------------------------------------------------------------
	rand bit pipe_reset_en;
    rand bit phy_reset_en;
    rand bit apb_reset_en;
    rand bit uc_reset_en;
    rand bit jtag_reset_en;
    //------------------------------------------------------------------------
    // EXTEND OR OVERRIDE BASE METHODS
    //------------------------------------------------------------------------
	constraint pipe_reset_c {soft pipe_reset_en == 0;}
	constraint phy_reset_c  {soft phy_reset_en == 0;}
	constraint apb_reset_c  {soft apb_reset_en == 0;}
	constraint uc_reset_c   {soft uc_reset_en == 0;}
	constraint jtag_reset_c {soft jtag_reset_en == 0;}
    // Extend the new method and register the sequence name
    function new(string name="cdn_reset_sequence");
        super.new(name);
    endfunction

    //------------------------------------------------------------------------
    // UVM AUTOMATION MACROS.
    //------------------------------------------------------------------------
    `uvm_object_utils_begin(cdn_reset_sequence)
        //`uvm_field_int(reset_gap_random, UVM_ALL_ON)
    `uvm_object_utils_end
    //`uvm_declare_p_sequencer(cdn_reset_pkg::cdn_reset_sequencer)
    
    //------------------------------------------------------------------------
    // SEQUENCE PRE BODY TCM
    //------------------------------------------------------------------------
    virtual task pre_body();
       //uvm_test_done.raise_objection(this);
    endtask : pre_body

    //------------------------------------------------------------------------
    // SEQUENCE BODY TCM
    //------------------------------------------------------------------------
    virtual task body();
		`uvm_info("","enter reset_seq body",UVM_LOW);
        `uvm_do_with(req, {pipe_reset.reset_en == pipe_reset_en;
						   phy_reset.reset_en == phy_reset_en;
						   apb_reset.reset_en == apb_reset_en;
						   uc_reset.reset_en == uc_reset_en;
						   jtag_reset.reset_en == jtag_reset_en;}) 
    endtask

    //------------------------------------------------------------------------
    // SEQUENCE POST BODY TCM
    //------------------------------------------------------------------------
    virtual task post_body();
       //uvm_test_done.drop_objection(this);
    endtask : post_body    

endclass : cdn_reset_sequence

//----------------------------------------------------------------------------
// End of file
//----------------------------------------------------------------------------
