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

class dut_usb4_tc_noc_tb_base_test extends uvm_test;

  dut_usb4_tc_noc_env_base tb;


  virtual function void build_phase(uvm_phase phase);

    dut_usb4_tc_noc_env_cfg env_cfg;
    if ($test$plusargs("STG_DISABLE_SCOREBOARDS")) begin
      if (!uvm_config_db#(dut_usb4_tc_noc_env_cfg)::get(this,"tb","env_cfg", env_cfg)) begin
        env_cfg = dut_usb4_tc_noc_env_cfg::type_id::create("env_cfg");
      end
      env_cfg.disable_scoreboards = 1;
      uvm_config_db#(dut_usb4_tc_noc_env_cfg)::set(this,"tb","env_cfg", env_cfg);
    end
    if ($test$plusargs("STG_DISABLE_ACTIVE_AGENTS")) begin
      if (!uvm_config_db#(dut_usb4_tc_noc_env_cfg)::get(this,"tb","env_cfg", env_cfg)) begin
        env_cfg = dut_usb4_tc_noc_env_cfg::type_id::create("env_cfg");
      end
      env_cfg.disable_apb_mstr_active = 1;
      env_cfg.disable_cdb_active = 1;
      env_cfg.disable_cmn_cdb_active = 1;
      env_cfg.disable_tc_reg_active = 1;
      env_cfg.disable_usb_sub_sys_active = 1;
      env_cfg.disable_pam3_sub_sys_active = 1;
      env_cfg.disable_apb_tgt_active = 1;
      env_cfg.disable_xcvr_ln_0_active = 1;
      uvm_config_db#(dut_usb4_tc_noc_env_cfg)::set(this,"tb","env_cfg", env_cfg);
    end
    if ($test$plusargs("STG_DISABLE_PASSIVE_AGENTS")) begin
      if (!uvm_config_db#(dut_usb4_tc_noc_env_cfg)::get(this,"tb","env_cfg", env_cfg)) begin
        env_cfg = dut_usb4_tc_noc_env_cfg::type_id::create("env_cfg");
      end
      env_cfg.disable_apb_mstr_passive = 1;
      env_cfg.disable_cdb_passive = 1;
      env_cfg.disable_cmn_cdb_passive = 1;
      env_cfg.disable_tc_reg_passive = 1;
      env_cfg.disable_usb_sub_sys_passive = 1;
      env_cfg.disable_pam3_sub_sys_passive = 1;
      env_cfg.disable_apb_tgt_passive = 1;
      env_cfg.disable_xcvr_ln_0_passive = 1;
      uvm_config_db#(dut_usb4_tc_noc_env_cfg)::set(this,"tb","env_cfg", env_cfg);
    end

    super.build_phase(phase);

    tb = dut_usb4_tc_noc_env_base::type_id::create("tb", this);
  endfunction : build_phase


  `uvm_component_utils(dut_usb4_tc_noc_tb_base_test)


  function new(string name="dut_usb4_tc_noc_tb_base_test", uvm_component parent=null);
     super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);

    // Set a drain time for the environment
    `ifndef SIM_DRAIN_TIME
      `define SIM_DRAIN_TIME 9000
    `endif
    uvm_objection phase_done = phase.get_objection();
    phase_done.set_drain_time(this, `SIM_DRAIN_TIME);

  endtask

virtual function void end_of_elaboration_phase(uvm_phase phase); 
tb.all_vips.apb_mstr.passive_slave.monitor.set_report_severity_id_override(UVM_FATAL,"CDN_AXI_FATAL_ERR_VR_AXI235_WRITE_BURST_MAPPED_ADDRESS_AND_DECERR",UVM_WARNING); 
tb.all_vips.apb_mstr.passive_slave.monitor.set_report_severity_id_override(UVM_FATAL,"CDN_AXI_FATAL_ERR_VR_AXI231_READ_TRANSFER_MAPPED_ADDRESS_AND_DECERR",UVM_WARNING); 
tb.all_vips.cdb.passive_slave.monitor.set_report_severity_id_override(UVM_FATAL,"CDN_AXI_FATAL_ERR_VR_AXI235_WRITE_BURST_MAPPED_ADDRESS_AND_DECERR",UVM_WARNING); 
tb.all_vips.cdb.passive_slave.monitor.set_report_severity_id_override(UVM_FATAL,"CDN_AXI_FATAL_ERR_VR_AXI231_READ_TRANSFER_MAPPED_ADDRESS_AND_DECERR",UVM_WARNING); 
      if($test$plusargs("allow_illegals")) begin
tb.all_scoreboards.scoreboard.monitor.set_report_severity_id_override(UVM_ERROR,"DENALI_SVD_ERR_050_RESPONSE_MISMATCH",UVM_WARNING); 
      end; 
endfunction :end_of_elaboration_phase
endclass
