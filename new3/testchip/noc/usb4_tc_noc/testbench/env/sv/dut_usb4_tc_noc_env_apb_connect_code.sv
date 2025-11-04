function void dut_usb4_tc_noc_env_base::apb_connect_code();
   if (env_cfg.disable_apb_mstr_active == 0) begin
      routing_model.set_port_agent_and_seqr("apb_mstr" , //port name
         1, // is_ext_agent
         all_vips.apb_mstr.active_master,
         all_vips.apb_mstr.active_master.sequencer );
   end

   if (env_cfg.disable_apb_mstr_passive == 0) begin
      routing_model.set_port_agent_and_seqr("apb_mstr" , //port name
         0, // is_ext_agent
         all_vips.apb_mstr.passive_slave,
         all_vips.apb_mstr.passive_slave.sequencer );
   end

   if (env_cfg.disable_cdb_active == 0) begin
      routing_model.set_port_agent_and_seqr("cdb" , //port name
         1, // is_ext_agent
         all_vips.cdb.active_master,
         all_vips.cdb.active_master.sequencer );
   end

   if (env_cfg.disable_cdb_passive == 0) begin
      routing_model.set_port_agent_and_seqr("cdb" , //port name
         0, // is_ext_agent
         all_vips.cdb.passive_slave,
         all_vips.cdb.passive_slave.sequencer );
   end

   if (env_cfg.disable_cmn_cdb_active == 0) begin
      routing_model.set_port_agent_and_seqr("cmn_cdb" , //port name
         1, // is_ext_agent
         all_vips.cmn_cdb.active_slave,
         all_vips.cmn_cdb.active_slave.sequencer );
   end

   if (env_cfg.disable_cmn_cdb_passive == 0) begin
      routing_model.set_port_agent_and_seqr("cmn_cdb" , //port name
         0, // is_ext_agent
         all_vips.cmn_cdb.passive_master,
         all_vips.cmn_cdb.passive_master.sequencer );
   end

   if (env_cfg.disable_tc_reg_active == 0) begin
      routing_model.set_port_agent_and_seqr("tc_reg" , //port name
         1, // is_ext_agent
         all_vips.tc_reg.active_slave,
         all_vips.tc_reg.active_slave.sequencer );
   end

   if (env_cfg.disable_tc_reg_passive == 0) begin
      routing_model.set_port_agent_and_seqr("tc_reg" , //port name
         0, // is_ext_agent
         all_vips.tc_reg.passive_master,
         all_vips.tc_reg.passive_master.sequencer );
   end

   if (env_cfg.disable_usb_sub_sys_active == 0) begin
      routing_model.set_port_agent_and_seqr("usb_sub_sys" , //port name
         1, // is_ext_agent
         all_vips.usb_sub_sys.active_slave,
         all_vips.usb_sub_sys.active_slave.sequencer );
   end

   if (env_cfg.disable_usb_sub_sys_passive == 0) begin
      routing_model.set_port_agent_and_seqr("usb_sub_sys" , //port name
         0, // is_ext_agent
         all_vips.usb_sub_sys.passive_master,
         all_vips.usb_sub_sys.passive_master.sequencer );
   end

   if (env_cfg.disable_pam3_sub_sys_active == 0) begin
      routing_model.set_port_agent_and_seqr("pam3_sub_sys" , //port name
         1, // is_ext_agent
         all_vips.pam3_sub_sys.active_slave,
         all_vips.pam3_sub_sys.active_slave.sequencer );
   end

   if (env_cfg.disable_pam3_sub_sys_passive == 0) begin
      routing_model.set_port_agent_and_seqr("pam3_sub_sys" , //port name
         0, // is_ext_agent
         all_vips.pam3_sub_sys.passive_master,
         all_vips.pam3_sub_sys.passive_master.sequencer );
   end

   if (env_cfg.disable_apb_tgt_active == 0) begin
      routing_model.set_port_agent_and_seqr("apb_tgt" , //port name
         1, // is_ext_agent
         all_vips.apb_tgt.active_slave,
         all_vips.apb_tgt.active_slave.sequencer );
   end

   if (env_cfg.disable_apb_tgt_passive == 0) begin
      routing_model.set_port_agent_and_seqr("apb_tgt" , //port name
         0, // is_ext_agent
         all_vips.apb_tgt.passive_master,
         all_vips.apb_tgt.passive_master.sequencer );
   end

   if (env_cfg.disable_xcvr_ln_0_active == 0) begin
      routing_model.set_port_agent_and_seqr("xcvr_ln_0" , //port name
         1, // is_ext_agent
         all_vips.xcvr_ln_0.active_slave,
         all_vips.xcvr_ln_0.active_slave.sequencer );
   end

   if (env_cfg.disable_xcvr_ln_0_passive == 0) begin
      routing_model.set_port_agent_and_seqr("xcvr_ln_0" , //port name
         0, // is_ext_agent
         all_vips.xcvr_ln_0.passive_master,
         all_vips.xcvr_ln_0.passive_master.sequencer );
   end

endfunction : apb_connect_code
