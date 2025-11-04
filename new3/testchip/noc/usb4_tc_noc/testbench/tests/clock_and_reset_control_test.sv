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
   
class clock_and_reset_control_test extends dut_usb4_tc_noc_tb_base_test;

  virtual function void build_phase(uvm_phase phase);

     super.build_phase(phase);

     uvm_config_db#(uvm_object_wrapper)::set(this,
                                             "tb.vseqr.run_phase",
                                             "default_sequence",
                                             clock_and_reset_control_vseq_test::type_id::get());
  endfunction


  `uvm_component_utils(clock_and_reset_control_test)

  function new(string name="clock_and_reset_control_test", uvm_component parent=null);
      super.new(name,parent);
  endfunction

endclass : clock_and_reset_control_test


