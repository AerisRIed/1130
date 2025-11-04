`define VALID_WIDTH 20
initial begin
    pma_tx_lfps_en                  = 0;
    pma_tx_lfps_mode                = 0;
    pma_tx_elec_idle_ln_0           = 1;
    pma_tx_td_ln_0                  = $random;
    pma_tx_elec_idle_ln_1           = 1;
    pma_tx_td_ln_1                  = $random;
    pma_tx_elec_idle_ln_2           = 1;
    pma_tx_td_ln_2                  = $random;
    pma_tx_elec_idle_ln_3           = 1;
    pma_tx_td_ln_3                  = $random;
end
reg usb_done;
// Lane0
bit dp_syncd0 = 0;
event dp_done0;
reg dp_done0_flag = 0;
reg [15:0] dp_tx_data_ln_0;
reg [15:0] dp_rx_data_ln_0;

// Lane1
bit dp_syncd1 = 0;
event dp_done1;
reg dp_done1_flag = 0;
reg [15:0] dp_tx_data_ln_1;
reg [15:0] dp_rx_data_ln_1;

// Lane2
bit dp_syncd2 = 0;
event dp_done2;
reg dp_done2_flag = 0;
reg [15:0] dp_tx_data_ln_2;
reg [15:0] dp_rx_data_ln_2;

// Lane3
bit dp_syncd3 = 0;
event dp_done3;
reg dp_done3_flag = 0;
reg [15:0] dp_tx_data_ln_3;
reg [15:0] dp_rx_data_ln_3;

//raw serdes initial value
initial begin
    pma_xcvr_pllclk_en = 0;
    pma_xcvr_power_state_req = DP_A0;
    $display("test_sanity_loopback_usb4_x1 begin");
    `ifndef DISABLE_WAVES
        $shm_open("waveform_rtl.shm");
        $shm_probe("AS");
    `endif
    usb_lpbk_en = 0;
    ds_gen_mode_ln_0 = gen_mode;
    ds_gen_mode_ln_1 = gen_mode;
    ds_gen_mode_ln_2 = gen_mode;
    ds_gen_mode_ln_3 = gen_mode;

    #100ns;
    // Enable apb_pclk/pipe_clk/ref_clk/uc_clk
    //{{
        APB_PCLK_500MHZ_RST_N           = 1;
        UC_CLK_500MHZ_RST_N             = 1;
        REFCLK_RST_N                    = 1;
        // PIPE7_PCLK_RST_N                = 1;
        // // PMA_TX_TD_CLK_RST_N             = 1;
    //}}
    // Initial input and reset
    //{{
        #100ns;
        uc_reset_n    = 0;
        apb_preset_n  = 0;
        phy_reset_n   = 0;
        dp_reset_n    = 0;
        #100ns;
        // `ifdef UC_EN
            uc_reset_n    = 1;
        // `endif
        apb_preset_n  = 1;
        #100ns;
        $display("apb_preset_n released");
    //}}

    #100ns;
    dp_config(gen_mode,lane_num);
    // Lane enable switches: 1 = enabled, 0 = disabled
    tb_top.pma_xcvr_power_state_req = DP_A0 ;
    wait(tb_top.pma_xcvr_power_state_ack == DP_A0) ;
    $display("pma_xcvr_power_state_req == DP_A0");
    // tb_top.u_dut.u_mp_pma.xcvr_link_reset_n_ln_0
    // tb_top.u_dut.u_mp_pma.xcvr_link_reset_n_ln_1
    // tb_top.u_dut.u_mp_pma.xcvr_link_reset_n_ln_2
    // tb_top.u_dut.u_mp_pma.xcvr_link_reset_n_ln_3

    dp_lane_enable_0 = 1;
    if(lane_num > 1) begin
        dp_lane_enable_1 = 1;
    end
    if(lane_num > 2) begin
        dp_lane_enable_2 = 1;
        dp_lane_enable_3 = 1;
    end

    // // **********************************************
    // // Disable USB link
    // // **********************************************
    // // Assert reset to USB link
    // pipe_reset_n = 1'b0;
    // pipe_powerdown = pipe_USB_P2;

    // Disable PLL0
    // apb_write(`PHY_PMA_PLL_CTRL, 16'h0002);

    #1000;

    // **********************************************
    // Re-enable USB link Gen 2
    // **********************************************

    // // Re-enable PLL0
    // apb_write(`PHY_PMA_PLL_CTRL, 16'h0003);

    // // Wait for PLL0 ready
    // apb_read(`PHY_PMA_CMN_CTRL2, apb_read_data);
    // while (~apb_read_data[0])
    //   begin
    //   apb_read(`PHY_PMA_CMN_CTRL2, apb_read_data);
    //   end

    // $display("PLL0 Re-enabled\n");

    // // De-assert reset to USB link at Gen 2
    // pipe_rate = 2'b01;
    // pipe_reset_n = 1'b1;

    // // Wait for PCS ready
    // @(negedge pipe_l00_phy_status);
    // $display("USB: Link Enabled\n");
    // @(negedge pipe_clk);
    // pipe_l00_rx_termination = 1'b1;
    // @(negedge pipe_clk);

    // $display("USB: Place Link in P0 State\n");
    // @(negedge pipe_clk);
    // pipe_powerdown = pipe_USB_P0;
    // @(posedge pipe_l00_phy_status);
    // @(negedge pipe_l00_phy_status);
    // $display("USB: Link in P0 State\n");
fork
    begin : lane0_tx
        if (!dp_lane_enable_0) disable lane0_tx;
        ds_enable_ln_0    = 1;
        ds_gen_mode_ln_0  = gen_mode;

        while (!dp_syncd0)  begin
        @(negedge dp_datart_clk);
        pma_tx_elec_idle_ln_0 = 1'b0;
        pma_tx_td_ln_0[`VALID_WIDTH - 1:0] = {2{`comma_10b_pos}};
        end
        // Counting pattern
        // 等待 Lane0 接收端同步完成
        dp_tx_data_ln_0[`VALID_WIDTH/2 - 1:0] = 0;
        while (!dp_done0_flag) begin
            @(negedge dp_datart_clk);
            pma_tx_td_ln_0[`VALID_WIDTH - 1:0] = {dp_tx_data_ln_0[`VALID_WIDTH/2 - 1:0]+1, dp_tx_data_ln_0[`VALID_WIDTH/2 - 1:0]};
            dp_tx_data_ln_0[`VALID_WIDTH/2 - 1:0] += 2;
        end
        @(negedge dp_datart_clk);
        pma_tx_elec_idle_ln_0 = 1;
        pma_tx_td_ln_0[`VALID_WIDTH - 1:0]        = 0;
    end

    begin : lane0_rx
        if (!dp_lane_enable_0) disable lane0_rx;
        @(posedge ds_dvalid_ln_0);
        $display("DP: PHY Lane0: De-serializer sync'd to Tx data");
        dp_syncd0 = 1;
        while (ds_data_ln_0[`VALID_WIDTH/2 - 1:0] == {`comma_10b_pos})
            @(negedge ds_clk_ln_0);
        dp_rx_data_ln_0[`VALID_WIDTH/2 - 1:0] = 1;
        for(int i0=0;i0<1000;i0++) begin
            @(negedge ds_clk_ln_0);
            if (ds_data_ln_0[`VALID_WIDTH/2 - 1:0] !== dp_rx_data_ln_0[`VALID_WIDTH/2 - 1:0]) begin
                $display("%t : ***ERROR*** Rx data mismatch for DP PHY lane 0. Actual=%h, Expected=%h",
                        $time, ds_data_ln_0[`VALID_WIDTH/2 - 1:0], dp_rx_data_ln_0[`VALID_WIDTH/2 - 1:0]);
                $finish;
            end
            dp_rx_data_ln_0[`VALID_WIDTH/2 - 1:0]++;
        end
        dp_done0_flag = 1;
    end
    begin : lane1_tx
        if (!dp_lane_enable_1) disable lane1_tx;
        ds_enable_ln_1    = 1;
        ds_gen_mode_ln_1  = gen_mode;
    
        while (!dp_syncd1) begin
            @(negedge dp_datart_clk);
            pma_tx_elec_idle_ln_1 = 1'b0;
            pma_tx_td_ln_1[`VALID_WIDTH - 1:0]        = {2{`comma_10b_pos}};
        end
        dp_tx_data_ln_1[`VALID_WIDTH/2 - 1:0] = 16'd0;
        while (!dp_done1_flag) begin
            @(negedge dp_datart_clk);
            pma_tx_td_ln_1[`VALID_WIDTH - 1:0] = {dp_tx_data_ln_1[`VALID_WIDTH/2 - 1:0] + 16'd1, dp_tx_data_ln_1[`VALID_WIDTH/2 - 1:0]};
            dp_tx_data_ln_1[`VALID_WIDTH/2 - 1:0] += 16'd2;
        end
    
        @(negedge dp_datart_clk);
        pma_tx_elec_idle_ln_1 = 1'b1;
        pma_tx_td_ln_1[`VALID_WIDTH - 1:0]        = 16'd0;
    end
    
    begin : lane1_rx
        if (!dp_lane_enable_1) disable lane1_rx;
        @(posedge ds_dvalid_ln_1);
        $display("DP: PHY Lane1: De-serializer sync'd to Tx data");
        dp_syncd1 = 1;
    
        while (ds_data_ln_1[`VALID_WIDTH/2 - 1:0] == {`comma_10b_pos})
            @(negedge ds_clk_ln_1);
    
        dp_rx_data_ln_1[`VALID_WIDTH/2 - 1:0] = 16'd1;
        for(int i1=0;i1<1000;i1++) begin
            @(negedge ds_clk_ln_1);
            if (ds_data_ln_1[`VALID_WIDTH/2 - 1:0] !== dp_rx_data_ln_1[`VALID_WIDTH/2 - 1:0]) begin
                $display("%t : ***ERROR*** Rx data mismatch for DP PHY lane 1. Actual=%h, Expected=%h",
                         $time, ds_data_ln_1[`VALID_WIDTH/2 - 1:0], dp_rx_data_ln_1[`VALID_WIDTH/2 - 1:0]);
                $finish;
            end
            dp_rx_data_ln_1[`VALID_WIDTH/2 - 1:0] += 16'd1;
        end
    
        dp_done1_flag = 1;
    end
    begin : lane2_tx
        if (!dp_lane_enable_2) disable lane2_tx;
        ds_enable_ln_2    = 1;
        ds_gen_mode_ln_2  = gen_mode;
    
        while (!dp_syncd2) begin
            @(negedge dp_datart_clk);
            pma_tx_elec_idle_ln_2 = 1'b0;
            pma_tx_td_ln_2[`VALID_WIDTH - 1:0]        = {2{`comma_10b_pos}};
        end
        dp_tx_data_ln_2[`VALID_WIDTH/2 - 1:0] = 16'd0;
        while (!dp_done2_flag) begin
            @(negedge dp_datart_clk);
            pma_tx_td_ln_2[`VALID_WIDTH - 1:0] = {dp_tx_data_ln_2[`VALID_WIDTH/2 - 1:0] + 16'd1, dp_tx_data_ln_2[`VALID_WIDTH/2 - 1:0]};
            dp_tx_data_ln_2[`VALID_WIDTH/2 - 1:0] += 16'd2;
        end
    
        @(negedge dp_datart_clk);
        pma_tx_elec_idle_ln_2 = 1'b1;
        pma_tx_td_ln_2[`VALID_WIDTH - 1:0]        = 16'd0;
    end
    
    begin : lane2_rx
        if (!dp_lane_enable_2) disable lane2_rx;
        @(posedge ds_dvalid_ln_2);
        $display("DP: PHY Lane2: De-serializer sync'd to Tx data");
        dp_syncd2 = 1;
    
        while (ds_data_ln_2[`VALID_WIDTH/2 - 1:0] == {`comma_10b_pos})
            @(negedge ds_clk_ln_2);
    
        dp_rx_data_ln_2[`VALID_WIDTH/2 - 1:0] = 16'd1;
        for(int i2=0;i2<1000;i2++) begin
            @(negedge ds_clk_ln_2);
            if (ds_data_ln_2[`VALID_WIDTH/2 - 1:0] !== dp_rx_data_ln_2[`VALID_WIDTH/2 - 1:0]) begin
                $display("%t : ***ERROR*** Rx data mismatch for DP PHY lane 2. Actual=%h, Expected=%h",
                         $time, ds_data_ln_2[`VALID_WIDTH/2 - 1:0], dp_rx_data_ln_2[`VALID_WIDTH/2 - 1:0]);
                $finish;
            end
            dp_rx_data_ln_2[`VALID_WIDTH/2 - 1:0] += 16'd1;
        end
    
        dp_done2_flag = 1;
    end

    begin : lane3_tx
        if (!dp_lane_enable_3) disable lane3_tx;
        ds_enable_ln_3    = 1;
        ds_gen_mode_ln_3  = gen_mode;
    
        while (!dp_syncd3) begin
            @(negedge dp_datart_clk);
            pma_tx_elec_idle_ln_3 = 1'b0;
            pma_tx_td_ln_3[`VALID_WIDTH - 1:0]        = {2{`comma_10b_pos}};
        end

        dp_tx_data_ln_3[`VALID_WIDTH/2 - 1:0] = 16'd0;
        while (!dp_done3_flag) begin
            @(negedge dp_datart_clk);
            pma_tx_td_ln_3[`VALID_WIDTH - 1:0] = {dp_tx_data_ln_3[`VALID_WIDTH/2 - 1:0] + 16'd1, dp_tx_data_ln_3[`VALID_WIDTH/2 - 1:0]};
            dp_tx_data_ln_3[`VALID_WIDTH/2 - 1:0] += 16'd2;
        end
    
        @(negedge dp_datart_clk);
        pma_tx_elec_idle_ln_3 = 1'b1;
        pma_tx_td_ln_3[`VALID_WIDTH - 1:0]        = 16'd0;
    end
    
    begin : lane3_rx
        if (!dp_lane_enable_3) disable lane3_rx;
        @(posedge ds_dvalid_ln_3);
        $display("DP: PHY Lane3: De-serializer sync'd to Tx data");
        dp_syncd3 = 1;
    
        while (ds_data_ln_3[`VALID_WIDTH/2 - 1:0] == {`comma_10b_pos})
            @(negedge ds_clk_ln_3);
    
        dp_rx_data_ln_3[`VALID_WIDTH/2 - 1:0] = 16'd1;
        for(int i3=0;i3<1000;i3++) begin
            @(negedge ds_clk_ln_3);
            if (ds_data_ln_3[`VALID_WIDTH/2 - 1:0] !== dp_rx_data_ln_3[`VALID_WIDTH/2 - 1:0]) begin
                $display("%t : ***ERROR*** Rx data mismatch for DP PHY lane 3. Actual=%h, Expected=%h",
                         $time, ds_data_ln_3[`VALID_WIDTH/2 - 1:0], dp_rx_data_ln_3[`VALID_WIDTH/2 - 1:0]);
                $finish;
            end
            dp_rx_data_ln_3[`VALID_WIDTH/2 - 1:0] += 16'd1;
        end
    
        dp_done3_flag = 1;
    end
    
join
    $display("%0t: \nTestcase Complete\n",$time);
    $finish;
end
