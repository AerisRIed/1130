function void dut_usb4_tc_noc_env_vip_container::apb_build_code();

   active_master_usb4_tc_noc_apb_mstr_config active_master_usb4_tc_noc_apb_mstr_cfg;
   passive_slave_usb4_tc_noc_apb_mstr_config passive_slave_usb4_tc_noc_apb_mstr_cfg;
   active_master_usb4_tc_noc_cdb_config active_master_usb4_tc_noc_cdb_cfg;
   passive_slave_usb4_tc_noc_cdb_config passive_slave_usb4_tc_noc_cdb_cfg;
   active_slave_usb4_tc_noc_cmn_cdb_config active_slave_usb4_tc_noc_cmn_cdb_cfg;
   passive_master_usb4_tc_noc_cmn_cdb_config passive_master_usb4_tc_noc_cmn_cdb_cfg;
   active_slave_usb4_tc_noc_tc_reg_config active_slave_usb4_tc_noc_tc_reg_cfg;
   passive_master_usb4_tc_noc_tc_reg_config passive_master_usb4_tc_noc_tc_reg_cfg;
   active_slave_usb4_tc_noc_usb_sub_sys_config active_slave_usb4_tc_noc_usb_sub_sys_cfg;
   passive_master_usb4_tc_noc_usb_sub_sys_config passive_master_usb4_tc_noc_usb_sub_sys_cfg;
   active_slave_usb4_tc_noc_pam3_sub_sys_config active_slave_usb4_tc_noc_pam3_sub_sys_cfg;
   passive_master_usb4_tc_noc_pam3_sub_sys_config passive_master_usb4_tc_noc_pam3_sub_sys_cfg;
   active_slave_usb4_tc_noc_apb_tgt_config active_slave_usb4_tc_noc_apb_tgt_cfg;
   passive_master_usb4_tc_noc_apb_tgt_config passive_master_usb4_tc_noc_apb_tgt_cfg;
   active_slave_usb4_tc_noc_xcvr_ln_0_config active_slave_usb4_tc_noc_xcvr_ln_0_cfg;
   passive_master_usb4_tc_noc_xcvr_ln_0_config passive_master_usb4_tc_noc_xcvr_ln_0_cfg;
   
   
   apb_mstr = cdn_stg_apb_basic_env_port::type_id::create( "apb_mstr",this);

   if (env_cfg.disable_apb_mstr_active == 0) begin
      apb_mstr.has_active_master = 1;
      active_master_usb4_tc_noc_apb_mstr_cfg = active_master_usb4_tc_noc_apb_mstr_config::type_id::create("active_master_usb4_tc_noc_apb_mstr_cfg",this);
      uvm_config_object::set(this,"apb_mstr.active_master","cfg",active_master_usb4_tc_noc_apb_mstr_cfg);
      uvm_config_string::set(this,"apb_mstr.active_master", "hdlPath", {vip_wrapper_modules_path, ".dut_usb4_tc_noc_apb_mstr.activeMaster"});
      if (!$test$plusargs("STG_DISABLE_VIP_COVERAGE")) begin
         uvm_config_int::set(this,"apb_mstr.active_master.monitor", "coverageEnable", 0);
      end
   end

   if (env_cfg.disable_apb_mstr_passive == 0) begin
      apb_mstr.has_passive_slave = 1;
      passive_slave_usb4_tc_noc_apb_mstr_cfg = passive_slave_usb4_tc_noc_apb_mstr_config::type_id::create("passive_slave_usb4_tc_noc_apb_mstr_cfg",this);
      uvm_config_object::set(this,"apb_mstr.passive_slave","cfg",passive_slave_usb4_tc_noc_apb_mstr_cfg);
      uvm_config_string::set(this,"apb_mstr.passive_slave", "hdlPath", {vip_wrapper_modules_path, ".dut_usb4_tc_noc_apb_mstr.passiveSlave"});
      if (!$test$plusargs("STG_DISABLE_VIP_COVERAGE")) begin
         uvm_config_int::set(this,"apb_mstr.passive_slave.monitor", "coverageEnable", 1);
      end
   end else begin
      `uvm_warning("PASSIVE_AGENT_DISABLED", "apb_mstr.passive_slave is disabled");
   end
   
   
   cdb = cdn_stg_apb_basic_env_port::type_id::create( "cdb",this);

   if (env_cfg.disable_cdb_active == 0) begin
      cdb.has_active_master = 1;
      active_master_usb4_tc_noc_cdb_cfg = active_master_usb4_tc_noc_cdb_config::type_id::create("active_master_usb4_tc_noc_cdb_cfg",this);
      uvm_config_object::set(this,"cdb.active_master","cfg",active_master_usb4_tc_noc_cdb_cfg);
      uvm_config_string::set(this,"cdb.active_master", "hdlPath", {vip_wrapper_modules_path, ".dut_usb4_tc_noc_cdb.activeMaster"});
      if (!$test$plusargs("STG_DISABLE_VIP_COVERAGE")) begin
         uvm_config_int::set(this,"cdb.active_master.monitor", "coverageEnable", 0);
      end
   end

   if (env_cfg.disable_cdb_passive == 0) begin
      cdb.has_passive_slave = 1;
      passive_slave_usb4_tc_noc_cdb_cfg = passive_slave_usb4_tc_noc_cdb_config::type_id::create("passive_slave_usb4_tc_noc_cdb_cfg",this);
      uvm_config_object::set(this,"cdb.passive_slave","cfg",passive_slave_usb4_tc_noc_cdb_cfg);
      uvm_config_string::set(this,"cdb.passive_slave", "hdlPath", {vip_wrapper_modules_path, ".dut_usb4_tc_noc_cdb.passiveSlave"});
      if (!$test$plusargs("STG_DISABLE_VIP_COVERAGE")) begin
         uvm_config_int::set(this,"cdb.passive_slave.monitor", "coverageEnable", 1);
      end
   end else begin
      `uvm_warning("PASSIVE_AGENT_DISABLED", "cdb.passive_slave is disabled");
   end
   
   
   cmn_cdb = cdn_stg_apb_basic_env_port::type_id::create( "cmn_cdb",this);

   if (env_cfg.disable_cmn_cdb_active == 0) begin
      cmn_cdb.has_active_slave = 1;
      active_slave_usb4_tc_noc_cmn_cdb_cfg = active_slave_usb4_tc_noc_cmn_cdb_config::type_id::create("active_slave_usb4_tc_noc_cmn_cdb_cfg",this);
      uvm_config_object::set(this,"cmn_cdb.active_slave","cfg",active_slave_usb4_tc_noc_cmn_cdb_cfg);
      uvm_config_string::set(this,"cmn_cdb.active_slave", "hdlPath", {vip_wrapper_modules_path, ".dut_usb4_tc_noc_cmn_cdb.activeSlave"});
      if (!$test$plusargs("STG_DISABLE_VIP_COVERAGE")) begin
         uvm_config_int::set(this,"cmn_cdb.active_slave.monitor", "coverageEnable", 0);
      end
   end

   if (env_cfg.disable_cmn_cdb_passive == 0) begin
      cmn_cdb.has_passive_master = 1;
      passive_master_usb4_tc_noc_cmn_cdb_cfg = passive_master_usb4_tc_noc_cmn_cdb_config::type_id::create("passive_master_usb4_tc_noc_cmn_cdb_cfg",this);
      uvm_config_object::set(this,"cmn_cdb.passive_master","cfg",passive_master_usb4_tc_noc_cmn_cdb_cfg);
      uvm_config_string::set(this,"cmn_cdb.passive_master", "hdlPath", {vip_wrapper_modules_path, ".dut_usb4_tc_noc_cmn_cdb.passiveMaster"});
      if (!$test$plusargs("STG_DISABLE_VIP_COVERAGE")) begin
         uvm_config_int::set(this,"cmn_cdb.passive_master.monitor", "coverageEnable", 1);
      end
   end else begin
      `uvm_warning("PASSIVE_AGENT_DISABLED", "cmn_cdb.passive_master is disabled");
   end
   
   
   tc_reg = cdn_stg_apb_basic_env_port::type_id::create( "tc_reg",this);

   if (env_cfg.disable_tc_reg_active == 0) begin
      tc_reg.has_active_slave = 1;
      active_slave_usb4_tc_noc_tc_reg_cfg = active_slave_usb4_tc_noc_tc_reg_config::type_id::create("active_slave_usb4_tc_noc_tc_reg_cfg",this);
      uvm_config_object::set(this,"tc_reg.active_slave","cfg",active_slave_usb4_tc_noc_tc_reg_cfg);
      uvm_config_string::set(this,"tc_reg.active_slave", "hdlPath", {vip_wrapper_modules_path, ".dut_usb4_tc_noc_tc_reg.activeSlave"});
      if (!$test$plusargs("STG_DISABLE_VIP_COVERAGE")) begin
         uvm_config_int::set(this,"tc_reg.active_slave.monitor", "coverageEnable", 0);
      end
   end

   if (env_cfg.disable_tc_reg_passive == 0) begin
      tc_reg.has_passive_master = 1;
      passive_master_usb4_tc_noc_tc_reg_cfg = passive_master_usb4_tc_noc_tc_reg_config::type_id::create("passive_master_usb4_tc_noc_tc_reg_cfg",this);
      uvm_config_object::set(this,"tc_reg.passive_master","cfg",passive_master_usb4_tc_noc_tc_reg_cfg);
      uvm_config_string::set(this,"tc_reg.passive_master", "hdlPath", {vip_wrapper_modules_path, ".dut_usb4_tc_noc_tc_reg.passiveMaster"});
      if (!$test$plusargs("STG_DISABLE_VIP_COVERAGE")) begin
         uvm_config_int::set(this,"tc_reg.passive_master.monitor", "coverageEnable", 1);
      end
   end else begin
      `uvm_warning("PASSIVE_AGENT_DISABLED", "tc_reg.passive_master is disabled");
   end
   
   
   usb_sub_sys = cdn_stg_apb_basic_env_port::type_id::create( "usb_sub_sys",this);

   if (env_cfg.disable_usb_sub_sys_active == 0) begin
      usb_sub_sys.has_active_slave = 1;
      active_slave_usb4_tc_noc_usb_sub_sys_cfg = active_slave_usb4_tc_noc_usb_sub_sys_config::type_id::create("active_slave_usb4_tc_noc_usb_sub_sys_cfg",this);
      uvm_config_object::set(this,"usb_sub_sys.active_slave","cfg",active_slave_usb4_tc_noc_usb_sub_sys_cfg);
      uvm_config_string::set(this,"usb_sub_sys.active_slave", "hdlPath", {vip_wrapper_modules_path, ".dut_usb4_tc_noc_usb_sub_sys.activeSlave"});
      if (!$test$plusargs("STG_DISABLE_VIP_COVERAGE")) begin
         uvm_config_int::set(this,"usb_sub_sys.active_slave.monitor", "coverageEnable", 0);
      end
   end

   if (env_cfg.disable_usb_sub_sys_passive == 0) begin
      usb_sub_sys.has_passive_master = 1;
      passive_master_usb4_tc_noc_usb_sub_sys_cfg = passive_master_usb4_tc_noc_usb_sub_sys_config::type_id::create("passive_master_usb4_tc_noc_usb_sub_sys_cfg",this);
      uvm_config_object::set(this,"usb_sub_sys.passive_master","cfg",passive_master_usb4_tc_noc_usb_sub_sys_cfg);
      uvm_config_string::set(this,"usb_sub_sys.passive_master", "hdlPath", {vip_wrapper_modules_path, ".dut_usb4_tc_noc_usb_sub_sys.passiveMaster"});
      if (!$test$plusargs("STG_DISABLE_VIP_COVERAGE")) begin
         uvm_config_int::set(this,"usb_sub_sys.passive_master.monitor", "coverageEnable", 1);
      end
   end else begin
      `uvm_warning("PASSIVE_AGENT_DISABLED", "usb_sub_sys.passive_master is disabled");
   end
   
   
   pam3_sub_sys = cdn_stg_apb_basic_env_port::type_id::create( "pam3_sub_sys",this);

   if (env_cfg.disable_pam3_sub_sys_active == 0) begin
      pam3_sub_sys.has_active_slave = 1;
      active_slave_usb4_tc_noc_pam3_sub_sys_cfg = active_slave_usb4_tc_noc_pam3_sub_sys_config::type_id::create("active_slave_usb4_tc_noc_pam3_sub_sys_cfg",this);
      uvm_config_object::set(this,"pam3_sub_sys.active_slave","cfg",active_slave_usb4_tc_noc_pam3_sub_sys_cfg);
      uvm_config_string::set(this,"pam3_sub_sys.active_slave", "hdlPath", {vip_wrapper_modules_path, ".dut_usb4_tc_noc_pam3_sub_sys.activeSlave"});
      if (!$test$plusargs("STG_DISABLE_VIP_COVERAGE")) begin
         uvm_config_int::set(this,"pam3_sub_sys.active_slave.monitor", "coverageEnable", 0);
      end
   end

   if (env_cfg.disable_pam3_sub_sys_passive == 0) begin
      pam3_sub_sys.has_passive_master = 1;
      passive_master_usb4_tc_noc_pam3_sub_sys_cfg = passive_master_usb4_tc_noc_pam3_sub_sys_config::type_id::create("passive_master_usb4_tc_noc_pam3_sub_sys_cfg",this);
      uvm_config_object::set(this,"pam3_sub_sys.passive_master","cfg",passive_master_usb4_tc_noc_pam3_sub_sys_cfg);
      uvm_config_string::set(this,"pam3_sub_sys.passive_master", "hdlPath", {vip_wrapper_modules_path, ".dut_usb4_tc_noc_pam3_sub_sys.passiveMaster"});
      if (!$test$plusargs("STG_DISABLE_VIP_COVERAGE")) begin
         uvm_config_int::set(this,"pam3_sub_sys.passive_master.monitor", "coverageEnable", 1);
      end
   end else begin
      `uvm_warning("PASSIVE_AGENT_DISABLED", "pam3_sub_sys.passive_master is disabled");
   end
   
   
   apb_tgt = cdn_stg_apb_basic_env_port::type_id::create( "apb_tgt",this);

   if (env_cfg.disable_apb_tgt_active == 0) begin
      apb_tgt.has_active_slave = 1;
      active_slave_usb4_tc_noc_apb_tgt_cfg = active_slave_usb4_tc_noc_apb_tgt_config::type_id::create("active_slave_usb4_tc_noc_apb_tgt_cfg",this);
      uvm_config_object::set(this,"apb_tgt.active_slave","cfg",active_slave_usb4_tc_noc_apb_tgt_cfg);
      uvm_config_string::set(this,"apb_tgt.active_slave", "hdlPath", {vip_wrapper_modules_path, ".dut_usb4_tc_noc_apb_tgt.activeSlave"});
      if (!$test$plusargs("STG_DISABLE_VIP_COVERAGE")) begin
         uvm_config_int::set(this,"apb_tgt.active_slave.monitor", "coverageEnable", 0);
      end
   end

   if (env_cfg.disable_apb_tgt_passive == 0) begin
      apb_tgt.has_passive_master = 1;
      passive_master_usb4_tc_noc_apb_tgt_cfg = passive_master_usb4_tc_noc_apb_tgt_config::type_id::create("passive_master_usb4_tc_noc_apb_tgt_cfg",this);
      uvm_config_object::set(this,"apb_tgt.passive_master","cfg",passive_master_usb4_tc_noc_apb_tgt_cfg);
      uvm_config_string::set(this,"apb_tgt.passive_master", "hdlPath", {vip_wrapper_modules_path, ".dut_usb4_tc_noc_apb_tgt.passiveMaster"});
      if (!$test$plusargs("STG_DISABLE_VIP_COVERAGE")) begin
         uvm_config_int::set(this,"apb_tgt.passive_master.monitor", "coverageEnable", 1);
      end
   end else begin
      `uvm_warning("PASSIVE_AGENT_DISABLED", "apb_tgt.passive_master is disabled");
   end
   
   
   xcvr_ln_0 = cdn_stg_apb_basic_env_port::type_id::create( "xcvr_ln_0",this);

   if (env_cfg.disable_xcvr_ln_0_active == 0) begin
      xcvr_ln_0.has_active_slave = 1;
      active_slave_usb4_tc_noc_xcvr_ln_0_cfg = active_slave_usb4_tc_noc_xcvr_ln_0_config::type_id::create("active_slave_usb4_tc_noc_xcvr_ln_0_cfg",this);
      uvm_config_object::set(this,"xcvr_ln_0.active_slave","cfg",active_slave_usb4_tc_noc_xcvr_ln_0_cfg);
      uvm_config_string::set(this,"xcvr_ln_0.active_slave", "hdlPath", {vip_wrapper_modules_path, ".dut_usb4_tc_noc_xcvr_ln_0.activeSlave"});
      if (!$test$plusargs("STG_DISABLE_VIP_COVERAGE")) begin
         uvm_config_int::set(this,"xcvr_ln_0.active_slave.monitor", "coverageEnable", 0);
      end
   end

   if (env_cfg.disable_xcvr_ln_0_passive == 0) begin
      xcvr_ln_0.has_passive_master = 1;
      passive_master_usb4_tc_noc_xcvr_ln_0_cfg = passive_master_usb4_tc_noc_xcvr_ln_0_config::type_id::create("passive_master_usb4_tc_noc_xcvr_ln_0_cfg",this);
      uvm_config_object::set(this,"xcvr_ln_0.passive_master","cfg",passive_master_usb4_tc_noc_xcvr_ln_0_cfg);
      uvm_config_string::set(this,"xcvr_ln_0.passive_master", "hdlPath", {vip_wrapper_modules_path, ".dut_usb4_tc_noc_xcvr_ln_0.passiveMaster"});
      if (!$test$plusargs("STG_DISABLE_VIP_COVERAGE")) begin
         uvm_config_int::set(this,"xcvr_ln_0.passive_master.monitor", "coverageEnable", 1);
      end
   end else begin
      `uvm_warning("PASSIVE_AGENT_DISABLED", "xcvr_ln_0.passive_master is disabled");
   end

endfunction : apb_build_code
