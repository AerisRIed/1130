//pipe7 initial value
initial begin
    pipe7_pll0_en                   =   'h0         ;
    pipe7_clk_max_req               =   'h0         ;
    pipe7_l00_tx_elec_idle          =   'h1         ;
    pipe7_l00_tx_det_rx_lpbk        =   'h0         ;
    pipe7_l00_tx_data_valid         =   'h1         ;
    pipe7_l00_tx_data[39:0]         =   $random     ;
    pipe7_l00_rx_termination        =   'h0         ;
    pipe7_l00_rx_standby            =   'h0         ;
    pipe7_l00_rate[1:0]             =   'h0         ;
    pipe7_l00_powerdown             =   pipe_USB_P2 ;
    pipe7_l00_m2p_messagebus[7:0]   =   'h0         ;
    
    pipe7_l01_tx_elec_idle          =   'h1         ;
    pipe7_l01_tx_det_rx_lpbk        =   'h0         ;
    pipe7_l01_tx_data_valid         =   'h1         ;
    pipe7_l01_tx_data[39:0]         =   $random     ;
    pipe7_l01_rx_termination        =   'h0         ;
    pipe7_l01_rx_standby            =   'h0         ;
    pipe7_l01_rate[1:0]             =   'h0         ;
    pipe7_l01_powerdown             =   pipe_USB_P2 ;
    pipe7_l01_m2p_messagebus[7:0]   =   'h0         ;
end

// Set the refclock frequency choose the clk
        logic [`TGT_APB_DATA_WIDTH-1:0] rdata;

// -------- lane 0 --------
        bit        rx_train_dn0 = 0;
        bit [7:0]  rx_data_chk0;
        bit        start_check0 = 0;
        bit        done0 = 0;
        bit [7:0]  tx_data_tmp0;
        int        cycle_cnt0;
        
// -------- lane 1 --------
        bit        rx_train_dn1 = 0;
        bit [7:0]  rx_data_chk1;
        bit        start_check1 = 0;
        bit        done1 = 0;
        bit [7:0]  tx_data_tmp1;
        int        cycle_cnt1;
        int        rx_data0,rx_data1;
initial begin
    $display("%0t: test_sanity_loopback_usb4_x1 begin", $time);
    `ifndef DISABLE_WAVES
        $shm_open("waveform_rtl.shm");
        $shm_probe("AS");
    `endif
    usb_lpbk_en = 1;
    #10ns;
    // Set the refclock frequency
    //{{
        pma_cmn_refclk_dig_div[1:0]     = 1'b00  ;
        pma_cmn_refclk_dig_sel          = 2'b10  ;
        pma_cmn_pll0_refclk_sel[1:0]    = 2'b00  ;
        pma_cmn_pll1_refclk_sel[1:0]    = 2'b00  ;
    //}}
    #100ns;
    // Enable apb_pclk/pipe_clk/ref_clk/uc_clk
    //{{
        APB_PCLK_500MHZ_RST_N           = 1;
        UC_CLK_500MHZ_RST_N             = 1;
        REFCLK_RST_N                    = 1;
        // PIPE7_PCLK_RST_N                = 1;
        // PMA_TX_TD_CLK_RST_N             = 1;
    //}}
    #100ns;
    // Initial input and reset
    //{{
        #100ns;
        pipe7_reset_n = 0;
        uc_reset_n    = 0;
        apb_preset_n  = 0;
        phy_reset_n   = 0;

        #100ns;
        // `ifdef UC_EN
            uc_reset_n    = 1;
        // `endif
        apb_preset_n  = 1;
        #100ns;
    $display("%0t: apb_preset_n released", $time);
    //}}

    // Programming usb4 register in PMA & Type-c mux
    //{{
    //TODO
        // apb_read_reg(18'b11_0_0_0000_0000_1001_00,DUT_HOST,rdata);
        // $display("rdata = %h", rdata);
        usb4_config(gen_mode,lane_num);
    //}}
    
    // Perform rx detect   (p2) and Place PCS in p0  (p0):
    //{{
        fork
            begin
                // @(negedge pipe7_l00_clk);
                // pipe7_l00_tx_det_rx_lpbk = 1'b1;
                // @(posedge pipe7_l00_phy_status);
                // @(negedge pipe7_l00_clk);
                // if (pipe7_l00_rx_status != 3'b011)
                // begin
                // $display("%t : ***ERROR*** Reciever not detected on lane 0", $time);
                // $finish;
                // end
                // @(negedge pipe7_l00_clk);
                // pipe7_l00_tx_det_rx_lpbk = 1'b0;

                // Place PCS in P0 state  -- PCS Lane0
                $display("%0t: Place link 0 in P0", $time);
                @(negedge pipe7_l00_clk);
                pipe7_l00_powerdown = pipe_USB_P0;
                @(posedge pipe7_l00_phy_status);
                @(negedge pipe7_l00_phy_status);
                $display("%0t: link 0 in P0", $time);
                // repeat (100) @(negedge pipe7_clk);
                // pipe7_l00_tx_det_rx_lpbk = 1'b1;
                // repeat (5) @(negedge pipe7_clk);
                // pipe7_l00_tx_det_rx_lpbk = 1'b0;
                // repeat (100) @(negedge pipe7_clk);
            end
            
            begin
                if(lane_num == 2) begin
                // @(negedge pipe7_l01_clk);
                // pipe7_l01_tx_det_rx_lpbk = 1'b1;
                // @(posedge pipe7_l01_phy_status);
                // @(negedge pipe7_l01_clk);
                // if (pipe7_l01_rx_status != 3'b011)
                //    begin
                //    $display("%t : ***ERROR*** Reciever not detected on lane 0", $time);
                //    $finish;
                //    end
                // @(negedge pipe7_l01_clk);
                // pipe7_l01_tx_det_rx_lpbk = 1'b0;

                // Place PCS in P0 state  -- PCS Lane0
                $display("%0t: Place link 1 in P0", $time);
                @(negedge pipe7_l01_clk);
                pipe7_l01_powerdown = pipe_USB_P0;
                @(posedge pipe7_l01_phy_status);
                @(negedge pipe7_l01_phy_status);
                $display("%0t: link 1 in P0", $time);
                // repeat (100) @(negedge pipe7_clk);
                // pipe7_l01_tx_det_rx_lpbk = 1'b1;
                // repeat (5) @(negedge pipe7_clk);
                // pipe7_l01_tx_det_rx_lpbk = 1'b0;
                // repeat (100) @(negedge pipe7_clk);
                end
            end
        join
    $display("%0t: Place PCS in p0 end", $time);
    //}}
    
    // LFPS transmitting & LFPS detecting (TODO:if needed? move to the bottom)
    //{{
    // fork 
    //     begin//lane00
    //         // t1: Notify PHY that MAC intends to transmit LFPS
    //         pipe7_l00_tx_elec_idle = 1'b1;
    //         pipe7_l00_tx_det_rx_lpbk = 1'b1;
    //         repeat (10) @(negedge pipe7_l00_clk); // Wait for PHY to prepare for LFPS
            
    //         // t2: Start transmitting LFPS pattern
    //         pipe7_l00_tx_elec_idle = 1'b0;
    //         repeat (100) begin
    //             @(negedge pipe7_l00_clk);
    //             pipe7_l00_tx_data = 32'hAA_AAAA; // Example LFPS toggling pattern
    //         end
            
    //         // t3: Notify PHY that LFPS transmission is ending
    //         pipe7_l00_tx_elec_idle = 1'b1;
    //         pipe7_l00_tx_det_rx_lpbk = 1'b0;
    //         repeat (10) @(negedge pipe7_l00_clk); // Allow PHY to transition back to idle
    //     end
    //     begin//lane 01
    //         if(lane_num == 2) begin
    //             // t1: Notify PHY that MAC intends to transmit LFPS on lane 1
    //             pipe7_l01_tx_elec_idle = 1'b1;
    //             pipe7_l01_tx_det_rx_lpbk = 1'b1;
    //             repeat (10) @(negedge pipe7_l01_clk); // Wait for PHY to prepare for LFPS
                
    //             // t2: Start transmitting LFPS pattern
    //             pipe7_l01_tx_elec_idle = 1'b0;
    //             repeat (100) begin
    //                 @(negedge pipe7_l01_clk);
    //                 pipe7_l01_tx_data = 32'hAA_AAAA; // Example LFPS toggling pattern
    //             end
                
    //             // t3: Notify PHY that LFPS transmission is ending
    //             pipe7_l01_tx_elec_idle = 1'b1;
    //             pipe7_l01_tx_det_rx_lpbk = 1'b0;
    //             repeat (10) @(negedge pipe7_l01_clk); // Allow PHY to transition back to idle
    //         end
    //     end
    // join
    //}}
    
    // Wait for PHY assert  RxValid 和 TxReady        
    //{{
    fork    
        begin//lane 00
            wait(pipe7_l00_rx_valid == 1);
            $display("%0t: link 0 rx_valid raise", $time);
        end
        
        begin//lane 01
            if(lane_num == 2) begin
                wait(pipe7_l01_rx_valid == 1);
                $display("%0t: link 1 rx_valid raise", $time);
            end
        end
    join
    $display("%0t: link 0/1 rx_valid raise", $time);
    //}}
    // begin
    

    // 1st Rx training & traffic
    fork
        //lane 0 Receiver logic
        begin
            $display("%0t: enter mb_wr_cmt", $time);
            // Initiate Rx training (simulation)
            mb_wr_cmt('h4,1,0); // TODO: How to determine when training is complete?
            $display("%0t: exit mb_wr_cmt", $time);
            rx_train_dn0 = 1;
            $display("%0t: rx_train_dn0 = 1", $time);
            rx_data_chk0 = 8'h0;

            // Wait until transmitter indicates active (tx_elec_idle == 0) before starting checks
            $display("%0t: Waiting for pipe7_l00_tx_elec_idle deassert", $time);
            while (pipe7_l00_rx_elec_idle) begin
                @(negedge pipe7_l00_rx_clk);
            end
            $display("%0t: pipe7_l00_rx_elec_idle deasserted, starting RX data check", $time);

            for (int j0 = 0; j0 < 2000; j0++) begin
                @(negedge pipe7_l00_rx_clk);
                if (dp0_locked == 1) begin
                    $display("%t : Start lane0 sequence detected.", $time);
                    break;
                end
            end
            if(dp0_locked) begin
                for (int i0 = 0; i0 < 1000; i0++) begin
                    @(negedge dp0_clk);
                    if(dp0_valid) begin
                        if (dp0_dout[7:0] !== rx_data_chk0) begin
                            $display("%t : ***ERROR*** Rx data mismatch byte 0. Actual = %h, expected = %h.",
                                    $time, dp0_dout[7:0], rx_data_chk0);
                            $finish;
                        end
                        if (dp0_dout[15:8] !== (rx_data_chk0 + 8'h1)) begin
                            $display("%t : ***ERROR*** Rx data mismatch byte 1. Actual = %h, expected = %h.",
                                    $time, dp0_dout[15:8], rx_data_chk0 + 8'h1);
                            $finish;
                        end
                        if (dp0_dout[23:16] !== (rx_data_chk0 + 8'h2)) begin
                            $display("%t : ***ERROR*** Rx data mismatch byte 2. Actual = %h, expected = %h.",
                                    $time, dp0_dout[23:16], rx_data_chk0 + 8'h2);
                            $finish;
                        end
                        if (dp0_dout[31:24] !== (rx_data_chk0 + 8'h3)) begin
                            $display("%t : ***ERROR*** Rx data mismatch byte 3. Actual = %h, expected = %h.",
                                    $time, dp0_dout[31:24], rx_data_chk0 + 8'h3);
                            $finish;
                        end
                        rx_data_chk0 = rx_data_chk0 + 8'h4;
                    end
                end
            end
            else begin
                $display("dp0_locked == 0");
            end
            done0 = 1;
        end

        //lane 0 Transmitter logic
        begin
            $display("%0t: enter Transmitter logic", $time);
            cycle_cnt0 = 0;
            tx_data_tmp0 = 8'h00;
            $display("%0t: begin while (~rx_train_dn0)", $time);
            // while (~rx_train_dn0) begin//TODO
            for(int j0=0;j0<1000;j0++) begin
                $display("%0t: in while (~rx_train_dn0)", $time);
                @(negedge pipe7_l00_clk);
                // pipe7_l00_tx_data_valid = 1'b1;
                pipe7_l00_tx_data = {2'h0,8'h55,2'h0,8'h55,2'h0,8'h55,2'h0,8'h55};
                // $display("tx_data0 = %0h",{pipe7_l00_tx_data[37:30],pipe7_l00_tx_data[27:20],pipe7_l00_tx_data[17:10],pipe7_l00_tx_data[7:0]});
                pipe7_l00_tx_elec_idle = 1'b0;
                cycle_cnt0++;
                if (cycle_cnt0 ==1000 ) begin
                    pipe7_l00_tx_data = {2'h0,8'hDE,2'h0,8'hAD,2'h0,8'hBE,2'h0,8'hEF};
                    // $display("tx_data0 = %0h",{pipe7_l00_tx_data[37:30],pipe7_l00_tx_data[27:20],pipe7_l00_tx_data[17:10],pipe7_l00_tx_data[7:0]});
                end
            end
            $display("%0t: exit while (~rx_train_dn0)", $time);
            while (~done0) begin
                @(negedge pipe7_l00_clk);
                pipe7_l00_tx_elec_idle = 1'b0;
                // pipe7_l00_tx_data_valid = 1'b1;
                pipe7_l00_tx_data = {
                    2'b00, (tx_data_tmp0 + 8'h3),
                    2'b00, (tx_data_tmp0 + 8'h2),
                    2'b00, (tx_data_tmp0 + 8'h1),
                    2'b00,  tx_data_tmp0
                };
                // $display("tx_data0 = %0h",{pipe7_l00_tx_data[37:30],pipe7_l00_tx_data[27:20],pipe7_l00_tx_data[17:10],pipe7_l00_tx_data[7:0]});
                tx_data_tmp0 = tx_data_tmp0 + 8'h4;
            end

            @(negedge pipe7_l00_clk);
            pipe7_l00_tx_data = 32'd0;
            // pipe7_l00_tx_data_valid = 1'b0;
            pipe7_l00_tx_elec_idle = 1'b1;
        end

        // lane 1 Receiver logic
        begin
            if(lane_num ==2) begin
                $display("%0t: enter mb_wr_cmt", $time);
                // Initiate Rx training (simulation)
                mb_wr_cmt('h4,1,1); // TODO: How to determine when training is complete?
                $display("%0t: exit mb_wr_cmt", $time);
                rx_train_dn1 = 1;
                $display("%0t: rx_train_dn1 = 1", $time);
                rx_data_chk1 = 8'h0;

                // Wait until transmitter indicates active (tx_elec_idle == 0) before starting checks
                $display("%0t: Waiting for pipe7_l01_tx_elec_idle deassert", $time);
                while (pipe7_l01_rx_elec_idle) begin
                    @(negedge pipe7_l01_rx_clk);
                end
                $display("%0t: pipe7_l01_rx_elec_idle deasserted, starting RX data check", $time);

                for (int j1 = 0; j1 < 2000; j1++) begin
                    @(negedge pipe7_l01_rx_clk);
                    if (dp1_locked == 1) begin
                        $display("%t : Start lane1 sequence detected.", $time);
                        break;
                    end
                end
                if(dp1_locked) begin
                    for (int i1 = 0; i1 < 1000; i1++) begin
                        @(negedge dp1_clk);
                        if(dp1_valid) begin
                            if (dp1_dout[7:0] !== rx_data_chk1) begin
                                $display("%t : ***ERROR*** Rx data mismatch byte 0. Actual = %h, expected = %h.",
                                        $time, dp1_dout[7:0], rx_data_chk1);
                                $finish;
                            end
                            if (dp1_dout[15:8] !== (rx_data_chk1 + 8'h1)) begin
                                $display("%t : ***ERROR*** Rx data mismatch byte 1. Actual = %h, expected = %h.",
                                        $time, dp1_dout[15:8], rx_data_chk1 + 8'h1);
                                $finish;
                            end
                            if (dp1_dout[23:16] !== (rx_data_chk1 + 8'h2)) begin
                                $display("%t : ***ERROR*** Rx data mismatch byte 2. Actual = %h, expected = %h.",
                                        $time, dp1_dout[23:16], rx_data_chk1 + 8'h2);
                                $finish;
                            end
                            if (dp1_dout[31:24] !== (rx_data_chk1 + 8'h3)) begin
                                $display("%t : ***ERROR*** Rx data mismatch byte 3. Actual = %h, expected = %h.",
                                        $time, dp1_dout[31:24], rx_data_chk1 + 8'h3);
                                $finish;
                            end
                            rx_data_chk1 = rx_data_chk1 + 8'h4;
                        end
                    end
                end
                else begin
                    $display("dp1_locked == 0");
                end
                done1 = 1;
            end
        end

        //lane 1 Transmitter logic
        begin
            if(lane_num ==2) begin
                $display("%0t: enter Transmitter logic", $time);
                cycle_cnt1 = 0;
                tx_data_tmp1 = 8'h00;
                $display("%0t: begin while (~rx_train_dn1)", $time);
                // while (~rx_train_dn1) begin//TODO
                for(int j1=0;j1<1000;j1++) begin
                    $display("%0t: in while (~rx_train_dn1)", $time);
                    @(negedge pipe7_l01_clk);
                    // pipe7_l01_tx_data_valid = 1'b1;
                    pipe7_l01_tx_data = {2'h0,8'h55,2'h0,8'h55,2'h0,8'h55,2'h0,8'h55};
                    // $display("tx_data1 = %0h",{pipe7_l01_tx_data[37:30],pipe7_l01_tx_data[27:20],pipe7_l01_tx_data[17:10],pipe7_l01_tx_data[7:0]});
                    pipe7_l01_tx_elec_idle = 1'b0;
                    cycle_cnt1++;
                    if (cycle_cnt1 ==1000 ) begin
                        pipe7_l01_tx_data = {2'h0,8'hDE,2'h0,8'hAD,2'h0,8'hBE,2'h0,8'hEF};
                        // $display("tx_data1 = %0h",{pipe7_l01_tx_data[37:30],pipe7_l01_tx_data[27:20],pipe7_l01_tx_data[17:10],pipe7_l01_tx_data[7:0]});
                    end
                end
                $display("%0t: exit while (~rx_train_dn1)", $time);
                while (~done1) begin
                    @(negedge pipe7_l01_clk);
                    pipe7_l01_tx_elec_idle = 1'b0;
                    // pipe7_l01_tx_data_valid = 1'b1;
                    pipe7_l01_tx_data = {
                        2'b00, (tx_data_tmp1 + 8'h3),
                        2'b00, (tx_data_tmp1 + 8'h2),
                        2'b00, (tx_data_tmp1 + 8'h1),
                        2'b00,  tx_data_tmp1
                    };
                    // $display("tx_data1 = %0h",{pipe7_l01_tx_data[37:30],pipe7_l01_tx_data[27:20],pipe7_l01_tx_data[17:10],pipe7_l01_tx_data[7:0]});
                    tx_data_tmp1 = tx_data_tmp1 + 8'h4;
                end

                @(negedge pipe7_l01_clk);
                pipe7_l01_tx_data = 32'd0;
                // pipe7_l01_tx_data_valid = 1'b0;
                pipe7_l01_tx_elec_idle = 1'b1;
            end
        end
    join
    // end
        $display("%0t: \nTestcase Complete\n",$time);
        $finish;
end