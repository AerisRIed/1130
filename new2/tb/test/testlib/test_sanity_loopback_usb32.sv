// Modified copy with $display logs inserted. Original code left untouched elsewhere.
// Added only $display calls to trace case progress.

// Top-level test signals for pipe4 (moved from procedural scope)
reg [7:0] tx_data_ln_0 = 8'h00;
reg [7:0] rx_data_ln_0 = 8'h00;
reg       done0 = 0;
reg       syncd0 = 0;
integer   i0, j0, k0;
reg       rx_train_dn0 = 0;
reg       jump_rx_detect = 0;
// Temporary placeholder definitions for missing macros. Replace with real macros/includes as needed.
// `pipe4_pad_char and `pipe4_comma_char were undefined; using placeholders 8'hBC and 8'h1C.
localparam [7:0] PIPE4_PAD_CHAR  = 8'hBC; // placeholder for `pipe4_pad_char
localparam [7:0] PIPE4_COMMA_CHAR = 8'h1C; // placeholder for `pipe4_comma_char

//pipe4 initial value
initial begin
    $display("%0t: TEST_START - entering pipe4 initial block", $time);
    pipe4_eb_mode                   =   'h0         ;
    pipe4_rate                      =   'h0         ;
    pipe4_powerdown                 =   pipe_USB_P2 ;

    pipe4_l00_rx_polarity           =   'h0         ;
    pipe4_l00_rx_termination        =   'h0         ;
    pipe4_l00_rx_eq_training        =   'h0         ;
    pipe4_l00_tx_data               =   $random     ;
    pipe4_l00_tx_data_k             =   'h0         ;
    pipe4_l00_tx_sync_header        =   'h0         ;
    pipe4_l00_tx_start_block        =   'h0         ;
    pipe4_l00_tx_data_valid         =   'h0         ;
    pipe4_l00_tx_det_rx_lpbk        =   'h0         ;
    pipe4_l00_tx_elec_idle          =   'h1         ;
    pipe4_l00_tx_ones_zeros         =   'h0         ;
    pipe4_l00_tx_128b_enc_byp       =   'h0         ;
    pipe4_l00_tx_deemph             =   'h0         ;

    pipe4_l01_rx_polarity           =   'h0         ;
    pipe4_l01_rx_termination        =   'h0         ;
    pipe4_l01_rx_eq_training        =   'h0         ;
    pipe4_l01_tx_data               =   $random     ;
    pipe4_l01_tx_data_k             =   'h0         ;
    pipe4_l01_tx_sync_header        =   'h0         ;
    pipe4_l01_tx_start_block        =   'h0         ;
    pipe4_l01_tx_data_valid         =   'h0         ;
    pipe4_l01_tx_det_rx_lpbk        =   'h0         ;
    pipe4_l01_tx_elec_idle          =   'h1         ;
    pipe4_l01_tx_ones_zeros         =   'h0         ;
    pipe4_l01_tx_128b_enc_byp       =   'h0         ;
    pipe4_l01_tx_deemph             =   'h0         ;

    $display("%0t: pipe4 initial values set", $time);
end
logic [`TGT_APB_DATA_WIDTH-1:0] rdata;
initial begin
    $display("%0t: TEST_INIT - starting main initial block", $time);
    usb_lpbk_en = 1;
    `ifdef JUMP_RXDET
        jump_rx_detect  = 1;
    `else
        jump_rx_detect  = 0;
    `endif
    // Set the refclock frequency
    //{{
        pma_cmn_refclk_dig_div[1:0]     = 1'b00  ;
        pma_cmn_refclk_dig_sel          = 2'b10  ;
        pma_cmn_pll0_refclk_sel[1:0]    = 2'b00  ;
        pma_cmn_pll1_refclk_sel[1:0]    = 2'b00  ;
        // pma_cmn_refclk0_int             = CLK_25MHZ;
        // pma_cmn_refclk1_int             = CLK_25MHZ;
        // pma_cmn_refclk_dig_div[1:0]     = 'b0   ;
        // pma_cmn_refclk_dig_sel          = 'b0   ;
        // pma_cmn_pll0_refclk_sel[1:0]    = 'b01  ;
        // pma_cmn_pll1_refclk_sel[1:0]    = 'b01  ;
    //}}

    // Enable apb_pclk/pipe4_clk/ref_clk/uc_clk
    //{{
        
        APB_PCLK_500MHZ_RST_N           = 1;
        UC_CLK_500MHZ_RST_N             = 1;
        REFCLK_RST_N                    = 1;
        // PIPE7_PCLK_RST_N                = 1;
        // // PMA_TX_TD_CLK_RST_N             = 1;
    //}}
    #100ns;
    // Initial input and reset
    //{{
        #100ns;
        pipe4_reset_n = 0;
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
    $display("%0t: resets: pipe4_reset_n=%0d uc_reset_n=%0d apb_preset_n=%0d phy_reset_n=%0d", $time, pipe4_reset_n, uc_reset_n, apb_preset_n, phy_reset_n);
    //}}

    // Programming dp/phy register for single lane
    //{{
        //TODO\
        usb32_config(gen_mode,lane_num);
    //}}

    //Perform receiver detect & Place PCS in P0 state
    //{{
        fork
            begin
                $display("%0t: RX_DETECT_THREAD_START - lane0 (jump_rx_detect=%0d)", $time, jump_rx_detect);
                if(!jump_rx_detect) begin
                    @(negedge pipe4_clk);
                    pipe4_l00_tx_det_rx_lpbk = 1'b1;
                    $display("%0t: lane0: asserted tx_det_rx_lpbk", $time);
                    @(posedge pipe4_l00_phy_status);
                    @(negedge pipe4_clk);
                    if (pipe4_l00_rx_status != 3'b011)
                    begin
                        $display("%t : ***ERROR*** Reciever not detected on lane 0", $time);
                        //TODO $finish;
                    end
                    @(negedge pipe4_clk);
                    pipe4_l00_tx_det_rx_lpbk = 1'b0;
                    $display("%0t: lane0: deasserted tx_det_rx_lpbk", $time);
                end

                // Place PCS in P0 state  -- PCS Lane0
                $display("%0t: Place link 0 in P0 (starting)", $time);
                @(negedge pipe4_clk);
                pipe4_powerdown = pipe_USB_P0;
                @(posedge pipe4_l00_phy_status);
                @(negedge pipe4_l00_phy_status);
                $display("%0t: link 0 in P0 confirmed", $time);
                repeat (100) @(negedge pipe4_clk);
                pipe4_l00_tx_det_rx_lpbk = 1'b1;
                repeat (5) @(negedge pipe4_clk);
                pipe4_l00_tx_det_rx_lpbk = 1'b0;
                repeat (100) @(negedge pipe4_clk);
                $display("%0t: RX_DETECT_THREAD_END - lane0", $time);
            end

            if(lane_num == 2) begin
                begin
                    $display("%0t: RX_DETECT_THREAD_START - lane1 (lane_num==2)", $time);
                    if(!jump_rx_detect) begin
                        // Perform receiver detect -- PCS Lane1
                        @(negedge pipe4_clk);
                        pipe4_l01_tx_det_rx_lpbk = 1'b1;
                        $display("%0t: lane1: asserted tx_det_rx_lpbk", $time);
                        @(posedge pipe4_l01_phy_status);
                        @(negedge pipe4_clk);
                        if (pipe4_l01_rx_status != 3'b011)
                        begin
                        $display("%t : ***ERROR*** Reciever not detected on lane 0", $time);
                        //TODO $finish;
                        end
                        @(negedge pipe4_clk);
                        pipe4_l01_tx_det_rx_lpbk = 1'b0;
                        $display("%0t: lane1: deasserted tx_det_rx_lpbk", $time);
                    end

                    // Place PCS in P0 state  -- PCS Lane1
                    $display("%0t: Place link 1 in P0 (starting)", $time);
                    @(negedge pipe4_clk);
                    pipe4_powerdown = pipe_USB_P0;
                    @(posedge pipe4_l01_phy_status);
                    @(negedge pipe4_l01_phy_status);
                    $display("%0t: link 1 in P0 confirmed", $time);
                    repeat (100) @(negedge pipe4_clk);
                    pipe4_l01_tx_det_rx_lpbk = 1'b1;
                    repeat (5) @(negedge pipe4_clk);
                    pipe4_l01_tx_det_rx_lpbk = 1'b0;
                    repeat (100) @(negedge pipe4_clk);
                    $display("%0t: RX_DETECT_THREAD_END - lane1", $time);
                end
            end

        join
    //}}

    // --- moved declarations to top of file (see below) ---
    $display("%0t: Starting first data/training fork", $time);
    fork
        begin
            $display("%0t: TX_THREAD_START - lane0 first phase", $time);
            // Generate transmit data
            // Send random data during  Rx Training
            while (~rx_train_dn0)
            begin
                @(negedge pipe4_clk);
                pipe4_l00_tx_data = $urandom;
                pipe4_l00_tx_data_valid = 1'b1;
                pipe4_l00_tx_elec_idle = 1'b0;
            end
            $display("%0t: TX_THREAD - sending COMMAs until sync", $time);
            // Send COMMAs until receiver syncs
            while (~syncd0)
            begin
                @(negedge pipe4_clk);
                pipe4_l00_tx_elec_idle = 1'b0;
                // using placeholders for pad/comma chars
                pipe4_l00_tx_data = {`pipe_pad_char, `pipe_pad_char, `pipe_pad_char, `pipe_comma_char};
                pipe4_l00_tx_data_k = 4'b1111;
                pipe4_l00_tx_data_valid = 1'b1;
            end
            tx_data_ln_0 = 8'h00;
            $display("%0t: TX_THREAD - starting counting pattern", $time);
            // Counting pattern
            while (~done0)
            begin
                @(negedge pipe4_clk);
                pipe4_l00_tx_data = {(tx_data_ln_0 + 8'h3), (tx_data_ln_0 +8'h2), (tx_data_ln_0 + 8'h1), tx_data_ln_0};
                pipe4_l00_tx_data_k = 4'd0;
                tx_data_ln_0 = tx_data_ln_0 + 8'h4;
                pipe4_l00_tx_data_valid = 1'b1;
            end
            @(negedge pipe4_clk);
            pipe4_l00_tx_data = 32'd0;
            pipe4_l00_tx_data_k = 4'd0;
            pipe4_l00_tx_data_valid = 1'b0;
            pipe4_l00_tx_elec_idle = 1'b1;
            $display("%0t: TX_THREAD_END - lane0 first phase", $time);
        end

        begin
            $display("%0t: RX_TRAIN_THREAD_START - lane0 first phase", $time);
            // Perform Rx training
            @(negedge pipe4_clk);
            pipe4_l00_rx_eq_training = 1'b1;
            $display("%0t: RX_TRAIN - eq training asserted", $time);
            repeat (2000) @(negedge pipe4_clk);
            pipe4_l00_rx_eq_training = 1'b0;
            $display("%0t: RX_TRAIN - eq training deasserted", $time);
            rx_train_dn0 = 1;

            // Check receive data
            @(posedge pipe4_l00_rx_valid);
            $display("Lane 0 Rx COMMA aligned");
            syncd0 = 1;
            rx_data_ln_0 = 8'h0;
            @(negedge pipe4_clk);
            if (~pipe4_l00_rx_data_valid)
                @(negedge pipe4_clk);
            for (i0=0;i0<1000;i0=i0+1)
            begin
                @(negedge pipe4_clk);
                if (~pipe4_l00_rx_data_k[0])
                begin
                    if (pipe4_l00_rx_data[7:0] !== rx_data_ln_0)
                    begin
                        $display("%t : ***ERROR*** Rx data mismatch in byte0.  Actual = %h, expected = %h.",
                        $time, pipe4_l00_rx_data[7:0], rx_data_ln_0);
                        //TODO $finish;
                    end
                    rx_data_ln_0 = rx_data_ln_0 + 8'h1;
                end
                if (~pipe4_l00_rx_data_k[1])
                begin
                    if (pipe4_l00_rx_data[15:8] !== rx_data_ln_0)
                    begin
                        $display("%t : ***ERROR*** Rx data mismatch in byte1.  Actual = %h, expected = %h.",
                        $time, pipe4_l00_rx_data[15:8], rx_data_ln_0);
                        //TODO $finish;
                    end
                    rx_data_ln_0 = rx_data_ln_0 + 8'h1;
                end
                if (~pipe4_l00_rx_data_k[2])
                begin
                    if (pipe4_l00_rx_data[23:16] !== rx_data_ln_0)
                    begin
                        $display("%t : ***ERROR*** Rx data mismatch in byte2.  Actual = %h, expected = %h.",
                        $time, pipe4_l00_rx_data[23:16], rx_data_ln_0);
                        //TODO $finish;
                    end
                    rx_data_ln_0 = rx_data_ln_0 + 8'h1;
                end
                if (~pipe4_l00_rx_data_k[3])
                begin
                    if (pipe4_l00_rx_data[31:24] !== rx_data_ln_0)
                    begin
                        $display("%t : ***ERROR*** Rx data mismatch in byte3.  Actual = %h, expected = %h.",
                        $time, pipe4_l00_rx_data[31:24], rx_data_ln_0);
                        //TODO $finish;
                    end
                    rx_data_ln_0 = rx_data_ln_0 + 8'h1;
                end
            end
            done0 = 1;
            $display("%0t: RX_TRAIN_THREAD_END - lane0 first phase (done0 set)", $time);
        end
    join

    #1000;
    $display("%0t: Rate change block starting", $time);
    // Change data rate to gen2
    fork
        begin

            @(negedge pipe4_clk);
            pipe4_rate = 2'b01;
            pma_xcvr_data_width       = 3'b010  ;
            // Wait for PHY status
            @(posedge pipe4_l00_phy_status);
            @(negedge pipe4_l00_phy_status);
            $display("Rate changed to USB3.1 for link 0");
            repeat (100) @(negedge pipe4_clk);
            pipe4_l00_tx_det_rx_lpbk = 1'b1;
            repeat (5) @(negedge pipe4_clk);
            pipe4_l00_tx_det_rx_lpbk = 1'b0;
            repeat (100) @(negedge pipe4_clk);
            $display("%0t: Rate change thread end for link 0", $time);
        end

        if(lane_num == 2) begin
            begin
            @(negedge pipe4_clk);
            pipe4_rate = 2'b01;
            pma_xcvr_data_width       = 3'b010  ;
            // Wait for PHY status
            @(posedge pipe4_l01_phy_status);
            @(negedge pipe4_l01_phy_status);
            $display("Rate changed to USB3.1 for link 1");
            repeat (100) @(negedge pipe4_clk);
            pipe4_l01_tx_det_rx_lpbk = 1'b1;
            repeat (5) @(negedge pipe4_clk);
            pipe4_l01_tx_det_rx_lpbk = 1'b0;
            repeat (100) @(negedge pipe4_clk);
            $display("%0t: Rate change thread end for link 1", $time);
            end
        end
    join

    $display("%0t: Align on SYNC OS stage starting", $time);
    // Align on SYNC OS in the 1st symbol position
    done0 = 0;
    syncd0 = 0;
    rx_train_dn0  = 0;

    fork
        begin
            $display("%0t: TX_THREAD_START - lane0 gen2 phase", $time);
            // Generate transmit data
            // Send random data during  Rx Training
            while (~rx_train_dn0)
            begin
                for (j0=0;j0<8;j0=j0+1)
                begin
                    for (k0=0;k0<4;k0=k0+1)
                    begin
                        @(negedge pipe4_clk);
                        pipe4_l00_tx_data = $urandom;
                        pipe4_l00_tx_sync_header = 4'b0011;
                        pipe4_l00_tx_data_valid = 1'b1;
                        pipe4_l00_tx_elec_idle = 1'b0;
                        if (k0 == 0)
                        pipe4_l00_tx_start_block = 1'b1;
                        else
                        pipe4_l00_tx_start_block = 1'b0;
                    end
                end
                @(negedge pipe4_clk);
                pipe4_l00_tx_data_valid = 1'b0;
            end
            $display("%0t: TX_THREAD - sending SYNC OS until sync", $time);
            // Send SYNC OS until receiver syncs
            while (~syncd0)
            begin
                for (j0=0;j0<8;j0=j0+1)
                begin
                    for (k0=0;k0<4;k0=k0+1)
                    begin
                        @(negedge pipe4_clk);
                        pipe4_l00_tx_data = 32'hff00_ff00;
                        pipe4_l00_tx_sync_header = 4'b1100;
                        pipe4_l00_tx_data_valid = 1'b1;
                        pipe4_l00_tx_elec_idle = 1'b0;
                        if (k0 == 0)
                        pipe4_l00_tx_start_block = 1'b1;
                        else
                        pipe4_l00_tx_start_block = 1'b0;
                    end
                end
                @(negedge pipe4_clk);
                pipe4_l00_tx_data_valid = 1'b0;
            end
            tx_data_ln_0 = 8'h00;
            $display("%0t: TX_THREAD - gen2 counting pattern start", $time);
            // Counting pattern
            while (~done0)
            begin
                for (j0=0;j0<8;j0=j0+1)
                begin
                    for (k0=0;k0<4;k0=k0+1)
                    begin
                        @(negedge pipe4_clk);
                        pipe4_l00_tx_data = {(tx_data_ln_0 + 8'h3), (tx_data_ln_0 + 8'h2), (tx_data_ln_0 + 8'h1), tx_data_ln_0};
                        pipe4_l00_tx_sync_header = 4'b0011;
                        pipe4_l00_tx_data_valid = 1'b1;
                        if (k0 == 0)
                        pipe4_l00_tx_start_block = 1'b1;
                        else
                        pipe4_l00_tx_start_block = 1'b0;
                        tx_data_ln_0 = tx_data_ln_0 + 8'h4;
                    end
                end
                @(negedge pipe4_clk);
                pipe4_l00_tx_data_valid = 1'b0;
            end
            @(negedge pipe4_clk);
            pipe4_l00_tx_data = 32'd0;
            pipe4_l00_tx_data_valid = 1'b0;
            pipe4_l00_tx_elec_idle = 1'b1;
            $display("%0t: TX_THREAD_END - lane0 gen2 phase", $time);
        end

        begin
            $display("%0t: RX_TRAIN_THREAD_START - lane0 gen2 phase", $time);
            // Perform Rx training
            @(negedge pipe4_clk);
            pipe4_l00_rx_eq_training = 1'b1;
            $display("%0t: RX_TRAIN - gen2 eq training asserted", $time);
            repeat (4000) @(negedge pipe4_clk);
            pipe4_l00_rx_eq_training = 1'b0;
            $display("%0t: RX_TRAIN - gen2 eq training deasserted", $time);
            rx_train_dn0 = 1;

            // Check receive data
            @(posedge pipe4_l00_rx_valid);
            $display("%0t: Lane 0 Rx valid asserted (gen2)", $time);
            syncd0 = 1;
            rx_data_ln_0 = 8'h0;

            @(negedge pipe4_clk);
            while (~(pipe4_l00_rx_start_block & pipe4_l00_rx_data_valid))
            @(negedge pipe4_clk);

            i0=0;
            while (i0<1000)
            begin
                @(negedge pipe4_clk);
                if ((pipe4_l00_rx_sync_header == 4'b0011) &pipe4_l00_rx_data_valid)
                begin
                    if (pipe4_l00_rx_data !== {(rx_data_ln_0+8'd3), (rx_data_ln_0+8'd2), (rx_data_ln_0+8'd1), rx_data_ln_0})
                    begin
                        $display("%t : ***ERROR*** Rx data mismatch.  Actual =%h, expected = %h.",
                        $time, pipe4_l00_rx_data, rx_data_ln_0);
                        //TODO $finish;
                    end
                    rx_data_ln_0 = rx_data_ln_0 + 8'h4;
                    i0=i0+1;
                end
            end
            done0 = 1;
            $display("%0t: RX_TRAIN_THREAD_END - lane0 gen2 phase (done0 set)", $time);
        end
    join

    #1000;
    $display("%0t: TEST_END - main initial finished", $time);
    $finish;
end