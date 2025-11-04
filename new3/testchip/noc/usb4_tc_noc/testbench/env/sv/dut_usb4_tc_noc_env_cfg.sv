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


class dut_usb4_tc_noc_env_cfg extends uvm_object;

   bit disable_scoreboards = 0;
   bit disable_apb_mstr_active = 0;
   bit disable_apb_mstr_passive = 0;
   bit disable_cdb_active = 0;
   bit disable_cdb_passive = 0;
   bit disable_cmn_cdb_active = 0;
   bit disable_cmn_cdb_passive = 0;
   bit disable_tc_reg_active = 0;
   bit disable_tc_reg_passive = 0;
   bit disable_usb_sub_sys_active = 0;
   bit disable_usb_sub_sys_passive = 0;
   bit disable_pam3_sub_sys_active = 0;
   bit disable_pam3_sub_sys_passive = 0;
   bit disable_apb_tgt_active = 0;
   bit disable_apb_tgt_passive = 0;
   bit disable_xcvr_ln_0_active = 0;
   bit disable_xcvr_ln_0_passive = 0;

   `uvm_object_utils_begin(dut_usb4_tc_noc_env_cfg)
      `uvm_field_int(disable_scoreboards, UVM_DEFAULT | UVM_UNSIGNED) 
      `uvm_field_int(disable_apb_mstr_active, UVM_ALL_ON)
      `uvm_field_int(disable_apb_mstr_passive, UVM_ALL_ON)
      `uvm_field_int(disable_cdb_active, UVM_ALL_ON)
      `uvm_field_int(disable_cdb_passive, UVM_ALL_ON)
      `uvm_field_int(disable_cmn_cdb_active, UVM_ALL_ON)
      `uvm_field_int(disable_cmn_cdb_passive, UVM_ALL_ON)
      `uvm_field_int(disable_tc_reg_active, UVM_ALL_ON)
      `uvm_field_int(disable_tc_reg_passive, UVM_ALL_ON)
      `uvm_field_int(disable_usb_sub_sys_active, UVM_ALL_ON)
      `uvm_field_int(disable_usb_sub_sys_passive, UVM_ALL_ON)
      `uvm_field_int(disable_pam3_sub_sys_active, UVM_ALL_ON)
      `uvm_field_int(disable_pam3_sub_sys_passive, UVM_ALL_ON)
      `uvm_field_int(disable_apb_tgt_active, UVM_ALL_ON)
      `uvm_field_int(disable_apb_tgt_passive, UVM_ALL_ON)
      `uvm_field_int(disable_xcvr_ln_0_active, UVM_ALL_ON)
      `uvm_field_int(disable_xcvr_ln_0_passive, UVM_ALL_ON)
   `uvm_object_utils_end


   function new(string name="dut_usb4_tc_noc_env_cfg");
      super.new(name);
   endfunction

endclass

