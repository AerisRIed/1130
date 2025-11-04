/* ------------------------------------------------------------------------------
--
-- CADENCE Copyright (c) 2025
-- Cadence Design Systems, Inc.
-- All rights reserved.
--
-- 
-- This work may not be copied, modified, re-published, uploaded, executed, or
-- distributed in any way, in any medium, whether in whole or in part, without
-- prior written permission from Cadence Design Systems, Inc.
--------------------------------------------------------------------------------- */

`include "uvm_macros.svh"


package dut_usb4_tc_noc_tb_test_pkg;

   // Utility packages
   import uvm_pkg::*;
   import cdn_stg_pkg::*;

   // VIP packages
   import DenaliSvMem::*;
   // SVD VIP packages
   import DenaliSvSvd::*;
   import cdnSvdUvm::*;

   `ifdef STG_ENABLE_UR
      // Unified Recorder
      import CdnURec::*;
   `endif // STG_ENABLE_UR

   // cdn_ace VIP package(s)
   import DenaliSvCdn_apb::*;
   import cdnApbUvm::*;
   
   // Testbench packages
   import dut_usb4_tc_noc_env_pkg::*;
   
`include "dut_usb4_tc_noc_tb_base_test.sv"
`include "dut_usb4_tc_noc_tb_tests.sv"

// User extensions file must be `included last
`include "dut_usb4_tc_noc_tb_test_pkg_usr.sv"

endpackage

