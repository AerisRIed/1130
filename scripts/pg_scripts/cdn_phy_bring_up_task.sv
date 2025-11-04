task cdn_phy_bring_up_seq::write_dp_1p62_none_int_100p0_pll0_None_ssc_pll1_None_ssc_pg_reg(int dp_lane_num, int de_emphasis, int swing, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_intdiv",'h0040);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivl",'hCCCD);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_high_thr",'h002C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h0000);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog0_clk_ctrl_m0",'h24240001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog1_clk_ctrl_m0",'h24240001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_post_div_m0",'h0004);
  if (dp_lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000E);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd2) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000C);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1'b1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd4) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_dp_1p62_none_int_100p0_pll0_None_ssc_pll1_Enable_ssc_pg_reg(int dp_lane_num, int de_emphasis, int swing, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_intdiv",'h0040);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivl",'hCCCD);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_high_thr",'h002C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_ss_ctrl1",'h00A40D01);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_ss_ctrl2",'h0000007B);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h0000);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog0_clk_ctrl_m0",'h24240001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog1_clk_ctrl_m0",'h24240001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_post_div_m0",'h0004);
  if (dp_lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000E);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd2) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000C);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1'b1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd4) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_dp_10_none_int_100p0_pll0_None_ssc_pll1_None_ssc_pg_reg(int dp_lane_num, int de_emphasis, int swing, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h0000);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog0_clk_ctrl_m0",'hC0C0001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog1_clk_ctrl_m0",'hC0C0001);
  if (dp_lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000E);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd2) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000C);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1'b1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd4) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_dp_13p5_none_int_100p0_pll0_None_ssc_pll1_None_ssc_pg_reg(int dp_lane_num, int de_emphasis, int swing, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_intdiv",'h0043);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivl",'h8000);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_high_thr",'h002E);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h0000);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog0_clk_ctrl_m0",'h4040001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog1_clk_ctrl_m0",'h4040001);
  if (dp_lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000E);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd2) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000C);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1'b1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd4) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0100);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0100);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0100);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0100);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_dp_20_none_int_100p0_pll0_None_ssc_pll1_None_ssc_pg_reg(int dp_lane_num, int de_emphasis, int swing, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h0000);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog0_clk_ctrl_m0",'h4040001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog1_clk_ctrl_m0",'h4040001);
  if (dp_lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000E);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd2) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000C);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1'b1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd4) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0100);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0100);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0100);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0100);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_dp_2p7_none_int_100p0_pll0_None_ssc_pll1_None_ssc_pg_reg(int dp_lane_num, int de_emphasis, int swing, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_fbh_ovrd",'h0022);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_fbl_ovrd",'h000C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h0000);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog0_clk_ctrl_m0",'h10100001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog1_clk_ctrl_m0",'h10100001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_post_div_m0",'h0002);
  if (dp_lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000E);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd2) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000C);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1'b1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd4) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_dp_5p4_none_int_100p0_pll0_None_ssc_pll1_None_ssc_pg_reg(int dp_lane_num, int de_emphasis, int swing, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_fbh_ovrd",'h0022);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_fbl_ovrd",'h000C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h0000);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog0_clk_ctrl_m0",'h6060001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog1_clk_ctrl_m0",'h6060001);
  if (dp_lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000E);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd2) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000C);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1'b1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd4) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_dp_8p1_none_int_100p0_pll0_None_ssc_pll1_None_ssc_pg_reg(int dp_lane_num, int de_emphasis, int swing, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_fbh_ovrd",'h0034);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_fbl_ovrd",'h0015);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h0000);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog0_clk_ctrl_m0",'h6060001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog1_clk_ctrl_m0",'h6060001);
  if (dp_lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000E);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd2) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000C);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1'b1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd4) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_dp_2p7_none_int_100p0_pll0_None_ssc_pll1_Enable_ssc_pg_reg(int dp_lane_num, int de_emphasis, int swing, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_intdiv",'h0036);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_high_thr",'h0024);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_ss_ctrl1",'h00CD1301);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_ss_ctrl2",'h00000052);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h0000);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog0_clk_ctrl_m0",'h10100001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog1_clk_ctrl_m0",'h10100001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_post_div_m0",'h0002);
  if (dp_lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000E);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd2) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000C);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1'b1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd4) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_dp_10_none_int_100p0_pll0_None_ssc_pll1_Enable_ssc_pg_reg(int dp_lane_num, int de_emphasis, int swing, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_intdiv",'h0064);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_high_thr",'h0044);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_ss_ctrl1",'h011B0E01);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_ss_ctrl2",'h0000006E);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h0000);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog0_clk_ctrl_m0",'hC0C0001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog1_clk_ctrl_m0",'hC0C0001);
  if (dp_lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000E);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd2) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000C);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1'b1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd4) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_dp_13p5_none_int_100p0_pll0_None_ssc_pll1_Enable_ssc_pg_reg(int dp_lane_num, int de_emphasis, int swing, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_intdiv",'h0043);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivl",'h8000);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_high_thr",'h002E);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_ss_ctrl1",'h00CC0F01);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_ss_ctrl2",'h00000067);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h0000);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog0_clk_ctrl_m0",'h4040001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog1_clk_ctrl_m0",'h4040001);
  if (dp_lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000E);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd2) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000C);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1'b1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd4) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0100);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0100);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0100);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0100);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_dp_20_none_int_100p0_pll0_None_ssc_pll1_Enable_ssc_pg_reg(int dp_lane_num, int de_emphasis, int swing, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_intdiv",'h0064);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_high_thr",'h0044);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_ss_ctrl1",'h011B0E01);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_ss_ctrl2",'h0000006E);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h0000);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog0_clk_ctrl_m0",'h4040001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog1_clk_ctrl_m0",'h4040001);
  if (dp_lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000E);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd2) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000C);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1'b1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0100);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd4) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0100);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0100);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0100);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0100);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_dp_5p4_none_int_100p0_pll0_None_ssc_pll1_Enable_ssc_pg_reg(int dp_lane_num, int de_emphasis, int swing, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_intdiv",'h0036);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_high_thr",'h0024);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_ss_ctrl1",'h00CD1301);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_ss_ctrl2",'h00000052);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h0000);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog0_clk_ctrl_m0",'h6060001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog1_clk_ctrl_m0",'h6060001);
  if (dp_lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000E);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd2) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000C);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1'b1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd4) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_dp_8p1_none_int_100p0_pll0_None_ssc_pll1_Enable_ssc_pg_reg(int dp_lane_num, int de_emphasis, int swing, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_intdiv",'h0051);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_high_thr",'h0036);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_ss_ctrl1",'h00CD0D01);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_ss_ctrl2",'h0000007B);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h0000);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog0_clk_ctrl_m0",'h6060001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll1_prog1_clk_ctrl_m0",'h6060001);
  if (dp_lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000E);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd2) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h000C);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    if(flip_flag == 1'b1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
      p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
    end
  end else if (dp_lane_num == 4'd4) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_pma_lane_map",'h51D9);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts",'h8000);
    p_sequencer.regmodel.phy_pma_cmn_reg_block.write_dut_register("phy_pma_cmn_ctrl_sts_clr",'h0081);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_sel",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0008);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      if(swing == 2'd0 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd0 && de_emphasis == 2'd3) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd1 && de_emphasis == 2'd2) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd0) begin
      end
      if(swing == 2'd2 && de_emphasis == 2'd1) begin
      end
      if(swing == 2'd3 && de_emphasis == 2'd0) begin
      end
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_usb_tcam_gen1_none_int_100p0_pll0_None_ssc_pll1_None_ssc_pg_reg(int lane_num, string IO_USB_TCAM, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_fbh_ovrd",'h001C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_fbl_ovrd",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h6060001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog1_clk_ctrl_m0",'h4040001);
  if (lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h0100);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end
  end
  else if (lane_num == 4'd2) begin
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_usb_tcam_gen2_none_int_24p0_pll0_None_ssc_pll1_None_ssc_pg_reg(int lane_num, string IO_USB_TCAM, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ssm_tmr_1",'h00010018);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_1",'h00180001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_2",'h0001003C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_3",'h000100F0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_1",'h00180001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_2",'h0001003C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_3",'h000100F0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_init_tmr",'h00000078);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_iter_tmr",'h00000082);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ibcal_init_tmr",'h0000001A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpucal_init_tmr",'h0000001F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpdcal_init_tmr",'h0000001F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_rxcal_init_tmr",'h000002D2);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_sd_cal_pllcnt_start",'h00000137);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_intdiv",'h01A0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_intdiv",'h014D);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivl",'hAAAB);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivl",'h5555);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_high_thr",'h0116);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_high_thr",'h00E0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_init_tmr",'h00F0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_iter_tmr",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_reftim_start",'h02F8);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_pllcnt_start",'h02F8);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h6060001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog1_clk_ctrl_m0",'h4040001);
  if (lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h0100);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end
  end
  else if (lane_num == 4'd2) begin
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_usb_tcam_gen2_none_int_100p0_pll0_None_ssc_pll1_None_ssc_pg_reg(int lane_num, string IO_USB_TCAM, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_fbh_ovrd",'h001C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_fbl_ovrd",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h6060001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog1_clk_ctrl_m0",'h4040001);
  if (lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h0100);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end
  end
  else if (lane_num == 4'd2) begin
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_usb_tcam_gen1_none_int_100p0_pll0_Enable_ssc_pll1_None_ssc_pg_reg(int lane_num, string IO_USB_TCAM, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_fbh_ovrd",'h001C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_fbl_ovrd",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_intdiv",'h0064);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_high_thr",'h0044);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_ss_ctrl1",'h011B0E01);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_ss_ctrl2",'h0000006E);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_reftim_start",'h0C5E);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_pllcnt_start",'h0C56);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_lock_pllcnt_thr",'h0005);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h6060001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog1_clk_ctrl_m0",'h4040001);
  if (lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h0100);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end
  end
  else if (lane_num == 4'd2) begin
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_usb_tcam_gen1_none_int_19p2_pll0_None_ssc_pll1_None_ssc_pg_reg(int lane_num, string IO_USB_TCAM, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ssm_tmr_1",'h00010014);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_1",'h00140001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_2",'h00010030);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_3",'h000100C0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_1",'h00140001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_2",'h00010030);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_3",'h000100C0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_init_tmr",'h00000060);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_iter_tmr",'h0000006A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ibcal_init_tmr",'h00000016);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ibcal_iter_tmr",'h00000016);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpucal_init_tmr",'h0000001A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpucal_iter_tmr",'h0000000F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpdcal_init_tmr",'h0000001A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpdcal_iter_tmr",'h0000000F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_rxcal_init_tmr",'h00000242);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_rxcal_iter_tmr",'h0000000F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_sd_cal_reftim_start",'h0000000B);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_sd_cal_pllcnt_start",'h00000137);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_intdiv",'h0104);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_intdiv",'h01A0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivl",'h6AAB);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivl",'hAAAB);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_high_thr",'h00AE);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_high_thr",'h0116);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_init_tmr",'h00C0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_iter_tmr",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_reftim_start",'h0260);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_pllcnt_start",'h0260);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h6060001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog1_clk_ctrl_m0",'h4040001);
  if (lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h0100);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end
  end
  else if (lane_num == 4'd2) begin
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_usb_tcam_gen1_none_int_19p2_pll0_Enable_ssc_pll1_None_ssc_pg_reg(int lane_num, string IO_USB_TCAM, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ssm_tmr_1",'h00010014);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_1",'h00140001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_2",'h00010030);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_3",'h000100C0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_1",'h00140001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_2",'h00010030);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_3",'h000100C0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_init_tmr",'h00000060);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_iter_tmr",'h0000006A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ibcal_init_tmr",'h00000016);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ibcal_iter_tmr",'h00000016);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpucal_init_tmr",'h0000001A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpucal_iter_tmr",'h0000000F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpdcal_init_tmr",'h0000001A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpdcal_iter_tmr",'h0000000F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_rxcal_init_tmr",'h00000242);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_rxcal_iter_tmr",'h0000000F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_sd_cal_reftim_start",'h0000000B);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_sd_cal_pllcnt_start",'h00000137);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_intdiv",'h0104);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_intdiv",'h01A0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivl",'h6AAB);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivl",'hAAAB);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_high_thr",'h00AE);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_high_thr",'h0116);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_ss_ctrl1",'h03040301);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_ss_ctrl2",'h00000069);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_init_tmr",'h00C0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_iter_tmr",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_reftim_start",'h0260);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_pllcnt_start",'h025E);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_lock_pllcnt_thr",'h0005);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h6060001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog1_clk_ctrl_m0",'h4040001);
  if (lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h0100);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end
  end
  else if (lane_num == 4'd2) begin
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_usb_tcam_gen1_none_int_24p0_pll0_None_ssc_pll1_None_ssc_pg_reg(int lane_num, string IO_USB_TCAM, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ssm_tmr_1",'h00010018);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_1",'h00180001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_2",'h0001003C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_3",'h000100F0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_1",'h00180001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_2",'h0001003C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_3",'h000100F0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_init_tmr",'h00000078);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_iter_tmr",'h00000082);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ibcal_init_tmr",'h0000001A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpucal_init_tmr",'h0000001F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpdcal_init_tmr",'h0000001F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_rxcal_init_tmr",'h000002D2);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_sd_cal_pllcnt_start",'h00000137);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_intdiv",'h01A0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_intdiv",'h014D);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivl",'hAAAB);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivl",'h5555);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_high_thr",'h0116);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_high_thr",'h00E0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_init_tmr",'h00F0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_iter_tmr",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_reftim_start",'h02F8);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_pllcnt_start",'h02F8);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h6060001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog1_clk_ctrl_m0",'h4040001);
  if (lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h0100);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end
  end
  else if (lane_num == 4'd2) begin
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_usb_tcam_gen1_none_int_24p0_pll0_Enable_ssc_pll1_None_ssc_pg_reg(int lane_num, string IO_USB_TCAM, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ssm_tmr_1",'h00010018);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_1",'h00180001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_2",'h0001003C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_3",'h000100F0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_1",'h00180001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_2",'h0001003C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_3",'h000100F0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_init_tmr",'h00000078);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_iter_tmr",'h00000082);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ibcal_init_tmr",'h0000001A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpucal_init_tmr",'h0000001F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpdcal_init_tmr",'h0000001F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_rxcal_init_tmr",'h000002D2);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_sd_cal_pllcnt_start",'h00000137);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_intdiv",'h01A0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_intdiv",'h014D);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivl",'hAAAB);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivl",'h5555);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_high_thr",'h0116);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_high_thr",'h00E0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_ss_ctrl1",'h04160301);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_ss_ctrl2",'h0000007C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_init_tmr",'h00F0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_iter_tmr",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_reftim_start",'h02F8);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_pllcnt_start",'h02F6);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_lock_pllcnt_thr",'h0005);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h6060001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog1_clk_ctrl_m0",'h4040001);
  if (lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h0100);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end
  end
  else if (lane_num == 4'd2) begin
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_usb_tcam_gen2_none_int_100p0_pll0_Enable_ssc_pll1_None_ssc_pg_reg(int lane_num, string IO_USB_TCAM, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_fbh_ovrd",'h001C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_fbl_ovrd",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_intdiv",'h0064);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_high_thr",'h0044);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_ss_ctrl1",'h011B0E01);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_ss_ctrl2",'h0000006E);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_reftim_start",'h0C5E);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_pllcnt_start",'h0C56);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_lock_pllcnt_thr",'h0005);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h6060001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog1_clk_ctrl_m0",'h4040001);
  if (lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h0100);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end
  end
  else if (lane_num == 4'd2) begin
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_usb_tcam_gen2_none_int_19p2_pll0_None_ssc_pll1_None_ssc_pg_reg(int lane_num, string IO_USB_TCAM, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ssm_tmr_1",'h00010014);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_1",'h00140001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_2",'h00010030);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_3",'h000100C0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_1",'h00140001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_2",'h00010030);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_3",'h000100C0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_init_tmr",'h00000060);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_iter_tmr",'h0000006A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ibcal_init_tmr",'h00000016);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ibcal_iter_tmr",'h00000016);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpucal_init_tmr",'h0000001A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpucal_iter_tmr",'h0000000F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpdcal_init_tmr",'h0000001A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpdcal_iter_tmr",'h0000000F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_rxcal_init_tmr",'h00000242);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_rxcal_iter_tmr",'h0000000F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_sd_cal_reftim_start",'h0000000B);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_sd_cal_pllcnt_start",'h00000137);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_intdiv",'h0104);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_intdiv",'h01A0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivl",'h6AAB);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivl",'hAAAB);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_high_thr",'h00AE);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_high_thr",'h0116);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_init_tmr",'h00C0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_iter_tmr",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_reftim_start",'h0260);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_pllcnt_start",'h0260);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h6060001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog1_clk_ctrl_m0",'h4040001);
  if (lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h0100);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end
  end
  else if (lane_num == 4'd2) begin
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_usb_tcam_gen2_none_int_19p2_pll0_Enable_ssc_pll1_None_ssc_pg_reg(int lane_num, string IO_USB_TCAM, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ssm_tmr_1",'h00010014);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_1",'h00140001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_2",'h00010030);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_3",'h000100C0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_1",'h00140001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_2",'h00010030);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_3",'h000100C0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_init_tmr",'h00000060);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_iter_tmr",'h0000006A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ibcal_init_tmr",'h00000016);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ibcal_iter_tmr",'h00000016);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpucal_init_tmr",'h0000001A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpucal_iter_tmr",'h0000000F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpdcal_init_tmr",'h0000001A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpdcal_iter_tmr",'h0000000F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_rxcal_init_tmr",'h00000242);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_rxcal_iter_tmr",'h0000000F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_sd_cal_reftim_start",'h0000000B);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_sd_cal_pllcnt_start",'h00000137);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_intdiv",'h0104);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_intdiv",'h01A0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivl",'h6AAB);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivl",'hAAAB);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_high_thr",'h00AE);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_high_thr",'h0116);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_ss_ctrl1",'h03040301);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_ss_ctrl2",'h00000069);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_init_tmr",'h00C0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_iter_tmr",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_reftim_start",'h0260);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_pllcnt_start",'h025E);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_lock_pllcnt_thr",'h0005);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h6060001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog1_clk_ctrl_m0",'h4040001);
  if (lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h0100);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end
  end
  else if (lane_num == 4'd2) begin
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_usb_tcam_gen2_none_int_24p0_pll0_Enable_ssc_pll1_None_ssc_pg_reg(int lane_num, string IO_USB_TCAM, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ssm_tmr_1",'h00010018);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_1",'h00180001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_2",'h0001003C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_3",'h000100F0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_1",'h00180001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_2",'h0001003C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_3",'h000100F0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_init_tmr",'h00000078);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_iter_tmr",'h00000082);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ibcal_init_tmr",'h0000001A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpucal_init_tmr",'h0000001F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpdcal_init_tmr",'h0000001F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_rxcal_init_tmr",'h000002D2);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_sd_cal_pllcnt_start",'h00000137);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_intdiv",'h01A0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_intdiv",'h014D);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivl",'hAAAB);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivl",'h5555);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_high_thr",'h0116);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_high_thr",'h00E0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_ss_ctrl1",'h04160301);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_ss_ctrl2",'h0000007C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_init_tmr",'h00F0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_iter_tmr",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_reftim_start",'h02F8);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_pllcnt_start",'h02F6);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_lock_pllcnt_thr",'h0005);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog0_clk_ctrl_m0",'h6060001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pdiag_pll0_prog1_clk_ctrl_m0",'h4040001);
  if (lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h0100);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    end
  end
  else if (lane_num == 4'd2) begin
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_diag_xcvr_rate_sel",'h0400);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0106);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0051);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_usb4_tcam_none_int_100p0_pll0_None_ssc_pll1_None_ssc_pg_reg(int lane_num, string IO_USB_TCAM, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_fbh_ovrd",'h001C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_fbl_ovrd",'h0004);
  if (lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h0100);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    end
  end
  else if (lane_num == 4'd2) begin
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_usb4_tcam_none_int_100p0_pll0_Enable_ssc_pll1_None_ssc_pg_reg(int lane_num, string IO_USB_TCAM, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_fbh_ovrd",'h001C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_fbl_ovrd",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_intdiv",'h0064);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_high_thr",'h0044);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_ss_ctrl1",'h011B0E01);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_ss_ctrl2",'h0000006E);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_reftim_start",'h0C5E);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_pllcnt_start",'h0C56);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_lock_pllcnt_thr",'h0005);
  if (lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h0100);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    end
  end
  else if (lane_num == 4'd2) begin
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_usb4_tcam_none_int_19p2_pll0_None_ssc_pll1_None_ssc_pg_reg(int lane_num, string IO_USB_TCAM, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ssm_tmr_1",'h00010014);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_1",'h00140001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_2",'h00010030);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_3",'h000100C0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_1",'h00140001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_2",'h00010030);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_3",'h000100C0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_init_tmr",'h00000060);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_iter_tmr",'h0000006A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ibcal_init_tmr",'h00000016);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ibcal_iter_tmr",'h00000016);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpucal_init_tmr",'h0000001A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpucal_iter_tmr",'h0000000F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpdcal_init_tmr",'h0000001A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpdcal_iter_tmr",'h0000000F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_rxcal_init_tmr",'h00000242);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_rxcal_iter_tmr",'h0000000F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_sd_cal_reftim_start",'h0000000B);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_sd_cal_pllcnt_start",'h00000137);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_intdiv",'h0104);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_intdiv",'h01A0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivl",'h6AAB);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivl",'hAAAB);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_high_thr",'h00AE);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_high_thr",'h0116);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_init_tmr",'h00C0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_iter_tmr",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_reftim_start",'h0260);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_pllcnt_start",'h0260);
  if (lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h0100);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    end
  end
  else if (lane_num == 4'd2) begin
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_usb4_tcam_none_int_19p2_pll0_Enable_ssc_pll1_None_ssc_pg_reg(int lane_num, string IO_USB_TCAM, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ssm_tmr_1",'h00010014);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_1",'h00140001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_2",'h00010030);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_3",'h000100C0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_1",'h00140001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_2",'h00010030);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_3",'h000100C0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_init_tmr",'h00000060);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_iter_tmr",'h0000006A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ibcal_init_tmr",'h00000016);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ibcal_iter_tmr",'h00000016);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpucal_init_tmr",'h0000001A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpucal_iter_tmr",'h0000000F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpdcal_init_tmr",'h0000001A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpdcal_iter_tmr",'h0000000F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_rxcal_init_tmr",'h00000242);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_rxcal_iter_tmr",'h0000000F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_sd_cal_reftim_start",'h0000000B);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_sd_cal_pllcnt_start",'h00000137);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_intdiv",'h0104);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_intdiv",'h01A0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivl",'h6AAB);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivl",'hAAAB);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_high_thr",'h00AE);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_high_thr",'h0116);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_ss_ctrl1",'h03040301);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_ss_ctrl2",'h00000069);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_init_tmr",'h00C0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_iter_tmr",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_reftim_start",'h0260);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_pllcnt_start",'h025E);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_lock_pllcnt_thr",'h0005);
  if (lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h0100);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    end
  end
  else if (lane_num == 4'd2) begin
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_rcvdet_st_tmr",'h00000780);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_usb4_tcam_none_int_24p0_pll0_None_ssc_pll1_None_ssc_pg_reg(int lane_num, string IO_USB_TCAM, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ssm_tmr_1",'h00010018);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_1",'h00180001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_2",'h0001003C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_3",'h000100F0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_1",'h00180001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_2",'h0001003C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_3",'h000100F0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_init_tmr",'h00000078);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_iter_tmr",'h00000082);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ibcal_init_tmr",'h0000001A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpucal_init_tmr",'h0000001F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpdcal_init_tmr",'h0000001F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_rxcal_init_tmr",'h000002D2);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_sd_cal_pllcnt_start",'h00000137);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_intdiv",'h01A0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_intdiv",'h014D);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivl",'hAAAB);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivl",'h5555);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_high_thr",'h0116);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_high_thr",'h00E0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_init_tmr",'h00F0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_iter_tmr",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_reftim_start",'h02F8);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_pllcnt_start",'h02F8);
  if (lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h0100);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    end
  end
  else if (lane_num == 4'd2) begin
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
task cdn_phy_bring_up_seq::write_usb4_tcam_none_int_24p0_pll0_Enable_ssc_pll1_None_ssc_pg_reg(int lane_num, string IO_USB_TCAM, bit flip_flag);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ssm_tmr_1",'h00010018);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_1",'h00180001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_2",'h0001003C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm0_tmr_3",'h000100F0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_1",'h00180001);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_2",'h0001003C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pllsm1_tmr_3",'h000100F0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_init_tmr",'h00000078);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_bgcal_iter_tmr",'h00000082);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_ibcal_init_tmr",'h0000001A);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpucal_init_tmr",'h0000001F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_txpdcal_init_tmr",'h0000001F);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_rxcal_init_tmr",'h000002D2);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_sd_cal_pllcnt_start",'h00000137);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_dsm_diag",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_intdiv",'h01A0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_intdiv",'h014D);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivl",'hAAAB);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivl",'h5555);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_fracdivh",'h0002);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_high_thr",'h0116);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll1_high_thr",'h00E0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_ss_ctrl1",'h04160301);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_ss_ctrl2",'h0000007C);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_init_tmr",'h00F0);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_iter_tmr",'h0004);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_reftim_start",'h02F8);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_vcocal_pllcnt_start",'h02F6);
  p_sequencer.regmodel.pma_cmn_reg_block.write_dut_register("cmn_pll0_lock_pllcnt_thr",'h0005);
  if (lane_num == 4'd1) begin
    p_sequencer.regmodel.phy_pcs_cmn_reg_block.write_dut_register("phy_lane_off_ctl",'h0100);
    if(flip_flag == 1) begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    end else begin
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
      p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
      p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
      p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    end
  end
  else if (lane_num == 4'd2) begin
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[0].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[1].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_rx_lane_reg_block[1].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[2].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_rx_lane_reg_block[2].write_dut_register("rx_psc_a0",'h0E1F);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_rcvdet_st_tmr",'h00000960);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_hsclk_div",'h0101);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_plldrc_ctrl",'h0001);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("tx_psc_a0",'h03FF);
    p_sequencer.regmodel.pma_tx_lane_reg_block[3].write_dut_register("xcvr_diag_bidi_ctrl",'h0001);
  end else begin
    `uvm_fatal("PG_CFG", "Wrong lane_num")
  end 
endtask
