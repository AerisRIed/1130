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

   
class custom_reset_and_configure_dut_event_test extends dut_usb4_tc_noc_tb_base_test;

  virtual function void build_phase(uvm_phase phase);

     super.build_phase(phase);

     uvm_config_db#(uvm_object_wrapper)::set(this,
                                             "tb.vseqr.run_phase",
                                             "default_sequence",
                                             custom_reset_and_configure_dut_event_vseq_test::type_id::get());
  endfunction

  `uvm_component_utils(custom_reset_and_configure_dut_event_test)

  function new(string name="custom_reset_and_configure_dut_event_test", uvm_component parent=null);
      super.new(name,parent);
  endfunction

endclass : custom_reset_and_configure_dut_event_test

