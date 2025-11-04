`ifndef CDN_USB_PHY_REG_SEQ__SV
`define CDN_USB_PHY_REG_SEQ__SV

class cdn_usb_phy_reg_seq extends cdn_phy_base_sequence;
  


   `uvm_object_utils(cdn_usb_phy_reg_seq)
   `uvm_declare_p_sequencer(cdn_phy_virtual_sequencer_base)

   //---------------------------------------
   // Constructor
   //---------------------------------------
   function new (string name = "cdn_usb_phy_reg_seq");
       super.new(name);
   endfunction : new

   extern virtual task pre_body();
   extern virtual task body();

endclass

task cdn_usb_phy_reg_seq::pre_body();
  // get cfg
  //cfg = p_sequencer.m_cfg;
endtask:pre_body

task cdn_usb_phy_reg_seq::body();

   `uvm_info(get_full_name(), $sformatf("This is reg try seq !"), UVM_LOW);
   #10ns;
   // Note: Direct hierarchical access to top-level signals removed
   // These should be controlled through proper UVM interface or config
   #10ns;
   // Reset removed - should be handled by test environment
   #1us;
   
   p_sequencer.regmodel.pma_rx_lane_reg_block[0].write_dut_register("rx_diag_xcvr_rate_sel",'h1);
   p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h1);
   p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_diag_xcvr_rate_sel",'h1);
   p_sequencer.regmodel.pma_rx_lane_reg_block[3].write_dut_register("rx_diag_xcvr_rate_sel",'h1);
   p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h1);
   p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h1);
   p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h1);
   p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h1);
   p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h1);
   p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h1);
   p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h1);
   p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h1);
   p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_fbh_ovrd",'h1);
   p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_fbl_ovrd",'h1);
   p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog0_clk_ctrl_m0",'h1);
   p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h1);
   //p_sequencer.regmodel.phy_pma_lane_reg_block[1].write_dut_register("pcs_tx3_timer_ipg_reg",'h2);
   //p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("pcs_tx2_timer_ipg_reg",'h2);

endtask : body

`endif // CDN_USB_PHY_REG_SEQ__SV

