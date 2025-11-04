`ifndef UPF_SUPPLY__SV
`define UPF_SUPPLY__SV
`ifdef CDNS_PMA_UPF_ENABLED
    //NOTE just a demo from torrent
    integer result;
    initial begin
            result = $supply_on("i_dut.u_pma.tx_avdd_ln_0",       0.75);
            result = $supply_on("i_dut.u_pma.tx_avdd_ln_1",       0.75);
            result = $supply_on("i_dut.u_pma.rx_avdd_ln_1",       0.75);
            result = $supply_on("i_dut.u_pma.xcvr_avdd_clk_ln_1", 0.75);
            result = $supply_on("i_dut.u_pma.tx_avdd_ln_2",       0.75);
            result = $supply_on("i_dut.u_pma.rx_avdd_ln_2",       0.75);
            result = $supply_on("i_dut.u_pma.xcvr_avdd_clk_ln_2", 0.75);
            result = $supply_on("i_dut.u_pma.tx_avdd_ln_3",       0.75);
            result = $supply_on("i_dut.u_pma.cmn_avdd",           0.75);
            result = $supply_on("i_dut.u_pma.cmn_avdd_clk",       0.75);
            result = $supply_on("i_dut.u_pma.cmn_avdd_h",         0.75);
            result = $supply_on("i_dut.u_pma.gnd",                0.0);
    end
`endif
  
`endif