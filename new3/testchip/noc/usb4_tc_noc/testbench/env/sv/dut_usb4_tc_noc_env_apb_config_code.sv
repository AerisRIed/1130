function void dut_usb4_tc_noc_env_vip_container::apb_config_code();

   if (env_cfg.disable_apb_mstr_active == 0) begin
      void'(apb_mstr.active_master.setCallback(DENALI_CDN_APB_CB_ResetEnded));

      void'(apb_mstr.active_master.setCallback(DENALI_CDN_APB_CB_MonTransferEnded));
   end

   if (env_cfg.disable_apb_mstr_passive == 0) begin
      void'(apb_mstr.passive_slave.setCallback(DENALI_CDN_APB_CB_ResetEnded));
   end

   if (env_cfg.disable_cdb_active == 0) begin
      void'(cdb.active_master.setCallback(DENALI_CDN_APB_CB_ResetEnded));

      void'(cdb.active_master.setCallback(DENALI_CDN_APB_CB_MonTransferEnded));
   end

   if (env_cfg.disable_cdb_passive == 0) begin
      void'(cdb.passive_slave.setCallback(DENALI_CDN_APB_CB_ResetEnded));
   end

   if (env_cfg.disable_cmn_cdb_active == 0) begin
      void'(cmn_cdb.active_slave.setCallback(DENALI_CDN_APB_CB_ResetEnded));
   end

   if (env_cfg.disable_cmn_cdb_passive == 0) begin
      void'(cmn_cdb.passive_master.setCallback(DENALI_CDN_APB_CB_ResetEnded));
   end

   if (env_cfg.disable_tc_reg_active == 0) begin
      void'(tc_reg.active_slave.setCallback(DENALI_CDN_APB_CB_ResetEnded));
   end

   if (env_cfg.disable_tc_reg_passive == 0) begin
      void'(tc_reg.passive_master.setCallback(DENALI_CDN_APB_CB_ResetEnded));
   end

   if (env_cfg.disable_usb_sub_sys_active == 0) begin
      void'(usb_sub_sys.active_slave.setCallback(DENALI_CDN_APB_CB_ResetEnded));
   end

   if (env_cfg.disable_usb_sub_sys_passive == 0) begin
      void'(usb_sub_sys.passive_master.setCallback(DENALI_CDN_APB_CB_ResetEnded));
   end

   if (env_cfg.disable_pam3_sub_sys_active == 0) begin
      void'(pam3_sub_sys.active_slave.setCallback(DENALI_CDN_APB_CB_ResetEnded));
   end

   if (env_cfg.disable_pam3_sub_sys_passive == 0) begin
      void'(pam3_sub_sys.passive_master.setCallback(DENALI_CDN_APB_CB_ResetEnded));
   end

   if (env_cfg.disable_apb_tgt_active == 0) begin
      void'(apb_tgt.active_slave.setCallback(DENALI_CDN_APB_CB_ResetEnded));
   end

   if (env_cfg.disable_apb_tgt_passive == 0) begin
      void'(apb_tgt.passive_master.setCallback(DENALI_CDN_APB_CB_ResetEnded));
   end

   if (env_cfg.disable_xcvr_ln_0_active == 0) begin
      void'(xcvr_ln_0.active_slave.setCallback(DENALI_CDN_APB_CB_ResetEnded));
   end

   if (env_cfg.disable_xcvr_ln_0_passive == 0) begin
      void'(xcvr_ln_0.passive_master.setCallback(DENALI_CDN_APB_CB_ResetEnded));
   end


endfunction : apb_config_code
