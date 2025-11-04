
`ifndef CDN_U4_DP_START_UP_SEQUENCE_SV
`define CDN_U4_DP_START_UP_SEQUENCE_SV

class cdn_u4_dp_start_up_sequence extends  cdn_u4_dp_virtual_sequence ;
  

    cdn_reset_sequence    reset_seq;

   `uvm_object_utils(cdn_u4_dp_start_up_sequence)
   `uvm_declare_p_sequencer(cdn_u4_dp_virtual_sequencer)

   //---------------------------------------
   // Constructor
   //---------------------------------------
   function new (string name = "cdn_u4_dp_start_up_sequence");
       super.new(name);
   endfunction : new

   extern virtual task body();
endclass



task cdn_u4_dp_start_up_sequence::body();

   cdn_u4_dp_transaction     trans[tb_param::DP_LANE_NUM];
   reset_seq = new();

   `uvm_info(get_full_name(), $sformatf("This Is DP Start Up Sequence!"), UVM_LOW);


//   #100ns;
//   `uvm_info(get_full_name(), $sformatf("Release phy reset / dp reset release random..."), UVM_LOW);
//	`uvm_do_on_with(reset_seq, p_sequencer.m_reset_sqr[0], {phy_reset_en ==1; pipe_reset_en==1;})
//   `uvm_info(get_full_name(), $sformatf("Release phy reset / dp reset release random Done"), UVM_LOW);
//
  `uvm_info(get_full_name(), $sformatf("SET TXONLY"), UVM_LOW)
   p_sequencer.base_vsqr.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0);
   p_sequencer.base_vsqr.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_psc_a0",'h0);
  `uvm_info(get_full_name(), $sformatf("SET TXONLY DOWN"), UVM_LOW)

//step2: release reset
  #100ns;
   `uvm_info(get_full_name(), $sformatf("Release phy reset / dp reset release random..."), UVM_LOW);
   if(p_sequencer.tb_cfg.std_mode == ALT_MODE) begin
     `uvm_do_on_with(reset_seq, p_sequencer.base_vsqr.m_reset_sqr[0], {pipe_reset_en==1;})
   end else begin
     `uvm_do_on_with(reset_seq, p_sequencer.base_vsqr.m_reset_sqr[0], {phy_reset_en ==1; pipe_reset_en==1;})
   end
   `uvm_info(get_full_name(), $sformatf("Release phy reset / dp reset release random Done"), UVM_LOW);

   #100ns;
     `uvm_do_on_with(trans[0], p_sequencer.host_sequencer[0],{operation==XCVR_PLLCLK_EN;})
   #200ns;
     `uvm_do_on_with(trans[0], p_sequencer.host_sequencer[0],{operation==DP_A2_ENTRY;})
   #200ns;
//     `uvm_do_on_with(trans[0], p_sequencer.host_sequencer[0],{operation==DP_POWER_IDLE_ENTRY;})
     `uvm_do_on_with(trans[0], p_sequencer.host_sequencer[0],{operation==DP_A0_ENTRY;})
   #200ns;
//     `uvm_do_on_with(trans[0], p_sequencer.host_sequencer[0],{operation==DP_A2_ENTRY;})

   if(p_sequencer.dut_cfg.dp_data_rate inside {DP_RBR,DP_HBR,DP_HBR2,DP_HBR3}) begin
     fork
       `uvm_info(get_full_name(), $sformatf("Send Data "), UVM_LOW);
       begin
         `uvm_do_on_with(trans[0], p_sequencer.host_sequencer[0],{operation==DP_DATA;packet_type==LINK_TPS2;})
         `uvm_do_on_with(trans[0], p_sequencer.host_sequencer[0],{operation==DP_IDLE;})
       end
       begin
         `uvm_do_on_with(trans[1], p_sequencer.host_sequencer[1],{operation==DP_DATA;packet_type==LINK_TPS2;})
         `uvm_do_on_with(trans[1], p_sequencer.host_sequencer[1],{operation==DP_IDLE;})
       end
       if(p_sequencer.tb_cfg.std_mode != ALT_MODE) begin
         `uvm_do_on_with(trans[2], p_sequencer.host_sequencer[2],{operation==DP_DATA;packet_type==LINK_TPS2;})
         `uvm_do_on_with(trans[2], p_sequencer.host_sequencer[2],{operation==DP_IDLE;})
       end
       if(p_sequencer.tb_cfg.std_mode != ALT_MODE) begin
         `uvm_do_on_with(trans[3], p_sequencer.host_sequencer[3],{operation==DP_DATA;packet_type==LINK_TPS2;})
         `uvm_do_on_with(trans[3], p_sequencer.host_sequencer[3],{operation==DP_IDLE;})
       end
     join
   end else if(p_sequencer.dut_cfg.dp_data_rate inside {DP_UHBR10,DP_UHBR13P5,DP_UHBR20}) begin
     fork
       `uvm_info(get_full_name(), $sformatf("Send Data "), UVM_LOW);
       begin
         `uvm_do_on_with(trans[0], p_sequencer.host_sequencer[0],{operation==DP_DATA;packet_type==LINK_128B132B_TPS1;})
         `uvm_do_on_with(trans[0], p_sequencer.host_sequencer[0],{operation==DP_DATA;packet_type==LINK_128B132B_TPS2_START;})
         //`uvm_do_on_with(trans[0], p_sequencer.host_sequencer[0],{operation==DP_DATA;packet_type==LINK_128B132B_TPS2;})
         `uvm_do_on_with(trans[0], p_sequencer.host_sequencer[0],{operation==DP_IDLE;})
       end
       begin
         `uvm_do_on_with(trans[1], p_sequencer.host_sequencer[1],{operation==DP_DATA;packet_type==LINK_128B132B_TPS1;})
         `uvm_do_on_with(trans[1], p_sequencer.host_sequencer[1],{operation==DP_DATA;packet_type==LINK_128B132B_TPS2_START;})
         //`uvm_do_on_with(trans[1], p_sequencer.host_sequencer[1],{operation==DP_DATA;packet_type==LINK_128B132B_TPS2;})
         `uvm_do_on_with(trans[1], p_sequencer.host_sequencer[1],{operation==DP_IDLE;})
       end
       if(p_sequencer.tb_cfg.std_mode != ALT_MODE) begin
         `uvm_do_on_with(trans[2], p_sequencer.host_sequencer[2],{operation==DP_DATA;packet_type==LINK_128B132B_TPS1;})
         `uvm_do_on_with(trans[2], p_sequencer.host_sequencer[2],{operation==DP_DATA;packet_type==LINK_128B132B_TPS2_START;})
         //`uvm_do_on_with(trans[2], p_sequencer.host_sequencer[2],{operation==DP_DATA;packet_type==LINK_128B132B_TPS2;})
         `uvm_do_on_with(trans[2], p_sequencer.host_sequencer[2],{operation==DP_IDLE;})
       end
       if(p_sequencer.tb_cfg.std_mode != ALT_MODE) begin
         `uvm_do_on_with(trans[3], p_sequencer.host_sequencer[3],{operation==DP_DATA;packet_type==LINK_128B132B_TPS1;})
         `uvm_do_on_with(trans[3], p_sequencer.host_sequencer[3],{operation==DP_DATA;packet_type==LINK_128B132B_TPS2_START;})
         //`uvm_do_on_with(trans[3], p_sequencer.host_sequencer[3],{operation==DP_DATA;packet_type==LINK_128B132B_TPS2;})
         `uvm_do_on_with(trans[3], p_sequencer.host_sequencer[3],{operation==DP_IDLE;})
       end
     join
   end

   #100;

endtask : body


`endif // CDN_U4_DP_VIRTUAL_SEQUENCE__SV

