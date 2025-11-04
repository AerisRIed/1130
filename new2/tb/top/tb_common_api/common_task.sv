`ifndef COMMON_TASK__SV
`define COMMON_TASK__SV
    //TB common task

    //PCIE commmon task

    //U32 common task
    task usb32_config;
        input int gen_mode;
        input int lane_num;

        int rdata;
        begin
        tb_top.pma_cmn_refclk_dig_sel    = 1'b0    ;      // PHY_PIN: pma_cmn_refclk_dig_sel 1'b0
        tb_top.pma_cmn_refclk_dig_div    = 2'b10   ;      // PHY_PIN: pma_cmn_refclk_dig_div 2'b10
        tb_top.pma_cmn_pll0_refclk_sel   = 2'b00   ;      // PHY_PIN: pma_cmn_pll0_refclk_sel 2'b00
        tb_top.pma_cmn_pll1_refclk_sel   = 2'b00   ;      // PHY_PIN: pma_cmn_pll1_refclk_sel 2'b00
        if(gen_mode == 1)
            tb_top.pma_xcvr_data_width       = 3'b101  ;      // PMA_PIN: xcvr_data_width 3'b010
        else if(gen_mode ==2 )
            tb_top.pma_xcvr_data_width       = 3'b010  ;      // PMA_PIN: xcvr_data_width 3'b010
        tb_top.phy_mode                  = 4'b0001 ;
        tb_top.typec_conn_dir            = 1'b0    ;
            if(gen_mode == 1) begin
                tb_top.pipe4_rate = 0;
            end
            else if (gen_mode == 2 ) begin
                tb_top.pipe4_rate = 1;
            end
        #100ns;
        `ifndef UC_EN
            apb_write_reg('h30000+'h60,'h0000,DUT_HOST);      // PHY_REG: PHY_PMA_LANE_MAP 0x0000
            if(lane_num == 1) begin
                apb_write_reg('h30064        ,'h0100, DUT_HOST);// PHY_REG: PHY_LANE_OFF_CTRL 0x0100 (LANE_CFG_USB_TCAM == USB1) || (LANE_CFG_USB_TCAM == USB1DP2)
            end
            // apb_write_reg('h30064        ,'h0102, DUT_HOST);// PHY_REG: PHY_LANE_OFF_CTRL 0x0102 (LANE_CFG_USB_TCAM == USB1) || (LANE_CFG_USB_TCAM == USB1DP2)
            apb_write_reg('h00000+'h350  ,'h0004, DUT_HOST);// PMA_REG: CMN_PLL1_DSM_DIAG                 
            apb_write_reg('h00000+'h340  ,'h0040, DUT_HOST);// PMA_REG: CMN_PLL1_INTDIV                   
            apb_write_reg('h00000+'h344  ,'hCCCD, DUT_HOST);// PMA_REG: CMN_PLL1_FRACDIVL                 
            apb_write_reg('h00000+'h348  ,'h0002, DUT_HOST);// PMA_REG: CMN_PLL1_FRACDIVH                 
            apb_write_reg('h00000+'h34c  ,'h002C, DUT_HOST);// PMA_REG: CMN_PLL1_HIGH_THR    

            apb_write_reg('h00000+'h354,'h1C,DUT_HOST);      // PMA_REG: CMN_PLL1_DSM_FBH_OVRD 0x001C
            apb_write_reg('h00000+'h358,'h4 ,DUT_HOST);      // PMA_REG: CMN_PLL1_DSM_FBL_OVRD 0x0004
            apb_write_reg('h00000+'h698  ,'h6060001, DUT_HOST);// PMA_REG: CMN_PDIAG_PLL0_PROG0_CLK_CTRL_M0
            apb_write_reg('h00000+'h69c  ,'h4040001, DUT_HOST);// PMA_REG: CMN_PDIAG_PLL0_PROG1_CLK_CTRL_M0

            apb_write_reg('h10000+'h21c,'h106,DUT_HOST);      // PMA_REG: lane0 XCVR_DIAG_HSCLK_DIV 0x0013
            apb_write_reg('h10800+'h21c,'h106,DUT_HOST);      // PMA_REG: lane1 XCVR_DIAG_HSCLK_DIV 0x0013
            if(lane_num == 2) begin
                apb_write_reg('h11000+'h21c,'h106,DUT_HOST);      // PMA_REG: lane2 XCVR_DIAG_HSCLK_DIV 0x0013
                apb_write_reg('h11800+'h21c,'h106,DUT_HOST);      // PMA_REG: lane3 XCVR_DIAG_HSCLK_DIV 0x0013
            end

            apb_write_reg('h10000+'h228  ,'h0001, DUT_HOST);// PMA_REG: XCVR_DIAG_BIDI_CTRL               
            apb_write_reg('h10800+'h228  ,'h0001, DUT_HOST);// PMA_REG: XCVR_DIAG_BIDI_CTRL               
            apb_write_reg('h11000+'h228  ,'h0001, DUT_HOST);// PMA_REG: XCVR_DIAG_BIDI_CTRL               
            apb_write_reg('h11800+'h228  ,'h0001, DUT_HOST);// PMA_REG: XCVR_DIAG_BIDI_CTRL    
            apb_write_reg('h10000+'h214,'h51,DUT_HOST);      // PMA_REG: lane0 XCVR_DIAG_PLLDRC_CTRL 0x0011 //TODO
            apb_write_reg('h10800+'h214,'h51,DUT_HOST);      // PMA_REG: lane1 XCVR_DIAG_PLLDRC_CTRL 0x0011 //TODO
            if(lane_num == 2) begin
                apb_write_reg('h11000+'h214,'h51,DUT_HOST);      // PMA_REG: lane2 XCVR_DIAG_PLLDRC_CTRL 0x0011 // TODO
                apb_write_reg('h11800+'h214,'h51,DUT_HOST);      // PMA_REG: lane3 XCVR_DIAG_PLLDRC_CTRL 0x0011 // TODO
            end
            if((gen_mode ==1)||(gen_mode == 2)) begin
                $display("set usb4 to gen2 rate");
                // apb_write_reg('h20000+'h7d4,'h0d00,DUT_HOST);      // PMA_REG: lane0 RX_DIAG_XCVR_RATE_SEL 0x0010
                apb_write_reg('h20800+'h7d4,'h0400,DUT_HOST);      // PMA_REG: lane1 RX_DIAG_XCVR_RATE_SEL 0x0010
                apb_write_reg('h21000+'h7d4,'h0400,DUT_HOST);      // PMA_REG: lane2 RX_DIAG_XCVR_RATE_SEL 0x0010
                // apb_write_reg('h21800+'h7d4,'h0d00,DUT_HOST);      // PMA_REG: lane3 RX_DIAG_XCVR_RATE_SEL 0x0010
            end//UC_EN
            //TODO
        `endif

                // Enable auto speedup configuration or release phy_reset
            //{{TODO
                `ifdef CDN_SIM_SPEEDUP
                    $display("Initiating Auto Speedup Configuration in PHY");
                    // apb_write_reg('h0000+'h184,'h8000,DUT_HOST);// CMN_BGCAL_OVRD               addr=0x184     value=0x8000
                    // apb_write_reg('h0000+'h1c4,'h8000,DUT_HOST);// CMN_IBCAL_OVRD               addr=0x1c4     value=0x8000
                    // apb_write_reg('h0000+'h20c,'h8012,DUT_HOST);// CMN_PLL0_VCOCAL_OVRD         addr=0x20c     value=0x8012
                    // apb_write_reg('h0000+'h28c,'h8012,DUT_HOST);// CMN_PLL0_VARCAL_OVRD         addr=0x28c     value=0x8012
                    // apb_write_reg('h0000+'h270,'h0001,DUT_HOST);// CMN_PLL0_LOCK_REFCNT_START   addr=0x270     value=0x0001
                    // apb_write_reg('h0000+'h278,'h0001,DUT_HOST);// CMN_PLL0_LOCK_PLLCNT_START   addr=0x278     value=0x0001
                    // apb_write_reg('h0000+'h27c,'h0FFF,DUT_HOST);// CMN_PLL0_LOCK_PLLCNT_THR     addr=0x27c     value=0x0FFF
                    // apb_write_reg('h0000+'h404,'h8000,DUT_HOST);// CMN_TXPUCAL_OVRD             addr=0x404     value=0x8000
                    // apb_write_reg('h0000+'h424,'h8000,DUT_HOST);// CMN_TXPDCAL_OVRD             addr=0x424     value=0x8000
                    // apb_write_reg('h0000+'h444,'h8000,DUT_HOST);// CMN_RXCAL_OVRD               addr=0x444     value=0x8000
                    // apb_write_reg('h0000+'h48c,'h8001,DUT_HOST);// CMN_SD_CAL_OVRD              addr=0x48c     value=0x8001
                    $display("PHY Auto Speedup Configuration Completed");
                    tb_top.phy_reset_n = 1'b1;
                    $display("phy_reset_n released");
                `else
                    $display("DIS CDN_SIM_SPEEDUP");
                    #1000;
                    tb_top.phy_reset_n = 1'b1;
                    $display("phy_reset_n released");
                `endif
            //}}
    // Wait for PCS ready
    //{{
        tb_top.pipe4_reset_n = 1;
        fork
            begin
            @(negedge pipe4_l00_phy_status);
            $display("lane 0 enabled");
            @(negedge pipe4_clk);
            pipe4_l00_rx_termination = 1'b1;
            end

            if(lane_num == 2) begin
            @(negedge pipe4_l01_phy_status);
            $display("lane 1 enabled");
            @(negedge pipe4_clk);
            pipe4_l01_rx_termination = 1'b1;
            end

        join
    //}}
        end
    endtask

    //DP common task
    task dp_config;
        input int gen_mode;
        input int lane_num;

        int   rdata;
        int   wdata;
        tb_top.pma_cmn_refclk_dig_sel       = 1'b0;
        tb_top.pma_cmn_refclk_dig_div       = 2'b10;
        tb_top.pma_cmn_pll0_refclk_sel      = 2'b00;
        tb_top.pma_cmn_pll1_refclk_sel      = 2'b00;
        tb_top.phy_mode                     = 4'b0110; //DP Only.
        // tb_top.phy_mode                     = 4'b0101 //USB3 & DP.
        if(gen_mode >UHBR10) begin
            tb_top.pma_xcvr_data_width          = 3'b101; //RATE_DP_TCAM == RHBR
        end 
        else begin
            tb_top.pma_xcvr_data_width          = 3'b010; //RATE_DP_TCAM == UHBR
        end
        apb_write_reg('h30060        ,'h51D9, DUT_HOST);// PHY_REG: PHY_PMA_LANE_MAP              
        if(lane_num==1)    
            apb_write_reg('h30064        ,'h000E, DUT_HOST);// PHY_REG: PHY_LANE_OFF_CTRL     // (LANE_CFG_USB_TCAM == DP1)   
        else if(lane_num==2)
            apb_write_reg('h30064        ,'h000C, DUT_HOST);// PHY_REG: PHY_LANE_OFF_CTRL     // (LANE_CFG_USB_TCAM == DP2)   
        
        apb_read_reg('h3800C        ,  DUT_HOST, rdata );
        wdata = rdata | 'h81;
        wdata[28] = 0;
        wdata[8]  = 0;
        apb_write_reg('h3800C        ,  wdata, DUT_HOST);// PHY_REG: PHY_PMA_CMN_CTRL_STS_CLR     
        apb_read_reg('h38008        ,  DUT_HOST, rdata );
        wdata = rdata | 'h8100;
        apb_write_reg('h38008        , wdata, DUT_HOST );// PHY_REG: PHY_PMA_CMN_CTRL_STS   
        // PHY_REG: PHY_PMA_CMN_CTRL_STS 0x8000
        // PHY_REG: PHY_PMA_CMN_CTRL_STS_CLR 0x0081        
        apb_write_reg('h00000+'h350  ,'h0004, DUT_HOST);// PMA_REG: CMN_PLL1_DSM_DIAG    
        
        if(gen_mode == RBR)   begin
            apb_write_reg('h00000+'h340  ,'h0040, DUT_HOST);// PMA_REG: CMN_PLL1_INTDIV     
            apb_write_reg('h00000+'h344  ,'hCCCD, DUT_HOST);// PMA_REG: CMN_PLL1_FRACDIVL          
        end 
        else if(gen_mode == UHBR13P5) begin
            apb_write_reg('h00000+'h340  ,'h0043, DUT_HOST);// PMA_REG: CMN_PLL1_INTDIV   
            apb_write_reg('h00000+'h344  ,'h8000, DUT_HOST);// PMA_REG: CMN_PLL1_FRACDIVL                 
        end
        
        apb_write_reg('h00000+'h348  ,'h0002, DUT_HOST);// PMA_REG: CMN_PLL1_FRACDIVH             
        
        if(gen_mode == RBR)   begin
            apb_write_reg('h00000+'h34c  ,'h002C, DUT_HOST);// PMA_REG: CMN_PLL1_HIGH_THR   
        end 
        else if(gen_mode == UHBR13P5) begin
            apb_write_reg('h00000+'h34c  ,'h002E, DUT_HOST);// PMA_REG: CMN_PLL1_HIGH_THR   
        end
        
        apb_write_reg('h00000+'h698  ,'h0000, DUT_HOST);// PMA_REG: CMN_PDIAG_PLL0_PROG0_CLK_CTRL_M0  
            apb_write_reg('h00000+'h69c  ,'h0001, DUT_HOST);// PMA_REG: CMN_PDIAG_PLL0_PROG1_CLK_CTRL_M0
        
        if(gen_mode == RBR)   begin
            apb_write_reg('h00000+'h720  ,'h24240001, DUT_HOST);// PMA_REG: CMN_PDIAG_PLL1_PROG0_CLK_CTRL_M0 
            apb_write_reg('h00000+'h724  ,'h24240001, DUT_HOST);// PMA_REG: CMN_PDIAG_PLL1_PROG1_CLK_CTRL_M0 
        end 
        else if(gen_mode == UHBR13P5) begin
            apb_write_reg('h00000+'h720  ,'h4040001, DUT_HOST);// PMA_REG: CMN_PDIAG_PLL1_PROG0_CLK_CTRL_M0 
        
            apb_write_reg('h00000+'h724  ,'h4040001, DUT_HOST);// PMA_REG: CMN_PDIAG_PLL1_PROG1_CLK_CTRL_M0 
        end
        
        if(gen_mode == RBR)   begin
            apb_write_reg('h00000+'h718  ,'h0004, DUT_HOST);// PMA_REG: CMN_PLL1_POST_DIV_M0    
        end 
        // if(gen_mode == UHBR13P5) begin
            apb_write_reg('h10000+'h218  ,'h0001, DUT_HOST);// PMA_REG: XCVR_DIAG_HSCLK_SEL               
            apb_write_reg('h10800+'h218  ,'h0001, DUT_HOST);// PMA_REG: XCVR_DIAG_HSCLK_SEL               
            apb_write_reg('h11000+'h218  ,'h0001, DUT_HOST);// PMA_REG: XCVR_DIAG_HSCLK_SEL               
            apb_write_reg('h11800+'h218  ,'h0001, DUT_HOST);// PMA_REG: XCVR_DIAG_HSCLK_SEL     
        // end 
        if(gen_mode == RBR)   begin
        apb_write_reg('h10000+'h21c  ,'h0101, DUT_HOST);// PMA_REG: XCVR_DIAG_HSCLK_DIV               
        apb_write_reg('h10800+'h21c  ,'h0101, DUT_HOST);// PMA_REG: XCVR_DIAG_HSCLK_DIV               
        apb_write_reg('h11000+'h21c  ,'h0101, DUT_HOST);// PMA_REG: XCVR_DIAG_HSCLK_DIV               
        apb_write_reg('h11800+'h21c  ,'h0101, DUT_HOST);// PMA_REG: XCVR_DIAG_HSCLK_DIV    
        end 
        else if(gen_mode == UHBR13P5) begin
        apb_write_reg('h10000+'h21c  ,'h0100, DUT_HOST);// PMA_REG: XCVR_DIAG_HSCLK_DIV               
        apb_write_reg('h10800+'h21c  ,'h0100, DUT_HOST);// PMA_REG: XCVR_DIAG_HSCLK_DIV               
        apb_write_reg('h11000+'h21c  ,'h0100, DUT_HOST);// PMA_REG: XCVR_DIAG_HSCLK_DIV               
        apb_write_reg('h11800+'h21c  ,'h0100, DUT_HOST);// PMA_REG: XCVR_DIAG_HSCLK_DIV    
        end 
                    
        apb_write_reg('h10000+'h214  ,'h0008, DUT_HOST);// PMA_REG: XCVR_DIAG_PLLDRC_CTRL             
        apb_write_reg('h10800+'h214  ,'h0008, DUT_HOST);// PMA_REG: XCVR_DIAG_PLLDRC_CTRL             
        apb_write_reg('h11000+'h214  ,'h0008, DUT_HOST);// PMA_REG: XCVR_DIAG_PLLDRC_CTRL             
        apb_write_reg('h11800+'h214  ,'h0008, DUT_HOST);// PMA_REG: XCVR_DIAG_PLLDRC_CTRL             
        apb_write_reg('h10000+'h228  ,'h0001, DUT_HOST);// PMA_REG: XCVR_DIAG_BIDI_CTRL               
        apb_write_reg('h10800+'h228  ,'h0001, DUT_HOST);// PMA_REG: XCVR_DIAG_BIDI_CTRL               
        apb_write_reg('h11000+'h228  ,'h0001, DUT_HOST);// PMA_REG: XCVR_DIAG_BIDI_CTRL               
        apb_write_reg('h11800+'h228  ,'h0001, DUT_HOST);// PMA_REG: XCVR_DIAG_BIDI_CTRL    
        //TODO TEST
        apb_write_reg('h20800 + 'h0000,'h0, DUT_HOST);// add by jinran      
        apb_write_reg('h20800 + 'h0010,'h0, DUT_HOST);// add by jinran      
        apb_write_reg('h20800 + 'h0020,'h0, DUT_HOST);// add by jinran      
        apb_write_reg('h20800 + 'h0030,'h0, DUT_HOST);// add by jinran      
        apb_write_reg('h20800 + 'h0040,'h0, DUT_HOST);// add by jinran      
        apb_write_reg('h20800 + 'h0050,'h0, DUT_HOST);// add by jinran      
        apb_write_reg('h20800 + 'h0060,'h0, DUT_HOST);// add by jinran      
        apb_write_reg('h20800 + 'h0070,'h0, DUT_HOST);// add by jinran      

        apb_write_reg('h21000 + 'h0000,'h0, DUT_HOST);// add by jinran      
        apb_write_reg('h21000 + 'h0010,'h0, DUT_HOST);// add by jinran      
        apb_write_reg('h21000 + 'h0020,'h0, DUT_HOST);// add by jinran      
        apb_write_reg('h21000 + 'h0030,'h0, DUT_HOST);// add by jinran      
        apb_write_reg('h21000 + 'h0040,'h0, DUT_HOST);// add by jinran      
        apb_write_reg('h21000 + 'h0050,'h0, DUT_HOST);// add by jinran      
        apb_write_reg('h21000 + 'h0060,'h0, DUT_HOST);// add by jinran      
        apb_write_reg('h21000 + 'h0070,'h0, DUT_HOST);// add by jinran      

    // Release dp_reset_n
    //{{TODO
        tb_top.dp_reset_n = 1;
        #10ns;
        tb_top.pma_xcvr_pllclk_en = 1;
    //}}
    
    // Enable auto speedup configuration or release phy_reset
    //{{TODO
        `ifdef CDN_SIM_SPEEDUP
            $display("Initiating Auto Speedup Configuration in PHY");
            //TODO
            $display("PHY Auto Speedup Configuration Completed");
            tb_top.phy_reset_n = 1'b1;
            $display("phy_reset_n released");
        `else
            $display("DIS CDN_SIM_SPEEDUP");
            #1000;
            tb_top.phy_reset_n = 1'b1;
            $display("phy_reset_n released");
        `endif
    //}}

    // Wait poma_cmn_ready and Release dp4_reset_n
    //{{
        @(posedge tb_top.pma_cmn_ready );
        $display("pma_cmn_ready released");
        @(posedge tb_top.pma_xcvr_pllclk_en_ack );
        $display("pma_xcvr_pllclk_en_ack released");
        #150ns;//min 100ns;
    //}}
    
    //place pma xcvr to A2
    //{{
        tb_top.pma_xcvr_power_state_req = DP_A2 ;
        wait(tb_top.pma_xcvr_power_state_ack == DP_A2) ;
        $display("pma_xcvr_power_state_req == DP_A2");
    //}}

    endtask

    //usb4 common task
    task usb4_config;
        input int gen_mode;
        input int lane_num;

        int rdata;
        begin
        tb_top.pma_cmn_refclk_dig_sel    = 1'b0    ;      // PHY_PIN: pma_cmn_refclk_dig_sel 1'b0
        tb_top.pma_cmn_refclk_dig_div    = 2'b10   ;      // PHY_PIN: pma_cmn_refclk_dig_div 2'b10
        tb_top.pma_cmn_pll0_refclk_sel   = 2'b00   ;      // PHY_PIN: pma_cmn_pll0_refclk_sel 2'b00
        tb_top.pma_cmn_pll1_refclk_sel   = 2'b00   ;      // PHY_PIN: pma_cmn_pll1_refclk_sel 2'b00
        tb_top.pma_xcvr_data_width       = 3'b010  ;      // PMA_PIN: xcvr_data_width 3'b010
        tb_top.phy_mode                  = 4'b0111 ;
        tb_top.typec_conn_dir            = 1'b0    ;
        if(gen_mode == 2) begin
            tb_top.pipe7_l00_rate = 0;
            tb_top.pipe7_l01_rate = 0;
        end
        else if (gen_mode == 3 ) begin
            tb_top.pipe7_l00_rate = 1;
            tb_top.pipe7_l01_rate = 1;
        end
        #100ns;
        `ifndef UC_EN
            if(lane_num == 1) begin
                apb_write_reg('h30064        ,'h0100, DUT_HOST);// PHY_REG: PHY_LANE_OFF_CTRL 0x0100 (LANE_CFG_USB_TCAM == USB1)
            end
            apb_write_reg('h30000+'h60,'h0000,DUT_HOST);      // PHY_REG: PHY_PMA_LANE_MAP 0x5100

            apb_write_reg('h10000+'h21c,'h101,DUT_HOST);      // PMA_REG: lane0 XCVR_DIAG_HSCLK_DIV 0x0011
            apb_write_reg('h10800+'h21c,'h101,DUT_HOST);      // PMA_REG: lane1 XCVR_DIAG_HSCLK_DIV 0x0011
            if(lane_num == 2) begin
                apb_write_reg('h11000+'h21c,'h101,DUT_HOST);      // PMA_REG: lane2 XCVR_DIAG_HSCLK_DIV 0x0011
                apb_write_reg('h11800+'h21c,'h101,DUT_HOST);      // PMA_REG: lane3 XCVR_DIAG_HSCLK_DIV 0x0011
            end

            apb_write_reg('h10000+'h214,'h1,DUT_HOST);      // PMA_REG: lane0 XCVR_DIAG_PLLDRC_CTRL 0x0001
            apb_write_reg('h10800+'h214,'h1,DUT_HOST);      // PMA_REG: lane1 XCVR_DIAG_PLLDRC_CTRL 0x0001
            if(lane_num == 2) begin
                apb_write_reg('h11000+'h214,'h1,DUT_HOST);      // PMA_REG: lane2 XCVR_DIAG_PLLDRC_CTRL 0x0001
                apb_write_reg('h11800+'h214,'h1,DUT_HOST);      // PMA_REG: lane3 XCVR_DIAG_PLLDRC_CTRL 0x0001
            end

            apb_write_reg('h10000+'h228  ,'h0001, DUT_HOST);// PMA_REG: XCVR_DIAG_BIDI_CTRL               
            apb_write_reg('h10800+'h228  ,'h0001, DUT_HOST);// PMA_REG: XCVR_DIAG_BIDI_CTRL               
            apb_write_reg('h11000+'h228  ,'h0001, DUT_HOST);// PMA_REG: XCVR_DIAG_BIDI_CTRL               
            apb_write_reg('h11800+'h228  ,'h0001, DUT_HOST);// PMA_REG: XCVR_DIAG_BIDI_CTRL    

            apb_write_reg('h00000+'h354,'h1C,DUT_HOST);      // PMA_REG: CMN_PLL1_DSM_FBH_OVRD 0x001C
            apb_write_reg('h00000+'h358,'h4 ,DUT_HOST);      // PMA_REG: CMN_PLL1_DSM_FBL_OVRD 0x0004
            // apb_write_reg('h00000+'h278,'hc7,DUT_HOST);      // PMA_REG: CMN_PLL0_LOCK_PLLCNT_START 0x00C7
            apb_write_reg('h00000+'h620,'h0 ,DUT_HOST);      // PMA_REG: CMN_PDIAG_PLL1_PROG0_CLK_CTRL_M0 0

            // apb_write_reg();      // PMA_REG: CMN_CDIAG_XCVRC_PWRI_OVRD 0x8200
            // if(gen_mode ==2) begin
            //     $display("set usb4 to gen2 rate");
            //     // apb_write_reg('h20000+'h7d4,'h0010,DUT_HOST);      // PMA_REG: lane0 RX_DIAG_XCVR_RATE_SEL 0x0010
            //     apb_write_reg('h20800+'h7d4,'h0010,DUT_HOST);      // PMA_REG: lane1 RX_DIAG_XCVR_RATE_SEL 0x0010
            //     apb_write_reg('h21000+'h7d4,'h0010,DUT_HOST);      // PMA_REG: lane2 RX_DIAG_XCVR_RATE_SEL 0x0010
            //     // apb_write_reg('h21800+'h7d4,'h0010,DUT_HOST);      // PMA_REG: lane3 RX_DIAG_XCVR_RATE_SEL 0x0010
            // end
            // else if(gen_mode == 3) begin
            //     $display("set usb4 to gen3 rate");
            //     // apb_write_reg('h20000+'h7d4,'h0030,DUT_HOST);      // PMA_REG: lane0 RX_DIAG_XCVR_RATE_SEL 0x0030
            //     apb_write_reg('h20800+'h7d4,'h0030,DUT_HOST);      // PMA_REG: lane1 RX_DIAG_XCVR_RATE_SEL 0x0030
            //     apb_write_reg('h21000+'h7d4,'h0030,DUT_HOST);      // PMA_REG: lane2 RX_DIAG_XCVR_RATE_SEL 0x0030
            //     // apb_write_reg('h21800+'h7d4,'h0030,DUT_HOST);      // PMA_REG: lane3 RX_DIAG_XCVR_RATE_SEL 0x0030
            // end
        `else//UC_EN
            //TODO
        `endif

                            // Enable auto speedup configuration or release phy_reset
            //{{TODO
                `ifdef CDN_SIM_SPEEDUP
                    $display("Initiating Auto Speedup Configuration in PHY");
                    apb_write_reg('h0000+'h184,'h8000,DUT_HOST);// CMN_BGCAL_OVRD               addr=0x184     value=0x8000
                    apb_write_reg('h0000+'h1c4,'h8000,DUT_HOST);// CMN_IBCAL_OVRD               addr=0x1c4     value=0x8000
                    apb_write_reg('h0000+'h20c,'h8012,DUT_HOST);// CMN_PLL0_VCOCAL_OVRD         addr=0x20c     value=0x8012
                    apb_write_reg('h0000+'h28c,'h8012,DUT_HOST);// CMN_PLL0_VARCAL_OVRD         addr=0x28c     value=0x8012
                    apb_write_reg('h0000+'h270,'h0001,DUT_HOST);// CMN_PLL0_LOCK_REFCNT_START   addr=0x270     value=0x0001
                    apb_write_reg('h0000+'h278,'h0001,DUT_HOST);// CMN_PLL0_LOCK_PLLCNT_START   addr=0x278     value=0x0001
                    apb_write_reg('h0000+'h27c,'h0FFF,DUT_HOST);// CMN_PLL0_LOCK_PLLCNT_THR     addr=0x27c     value=0x0FFF
                    apb_write_reg('h0000+'h404,'h8000,DUT_HOST);// CMN_TXPUCAL_OVRD             addr=0x404     value=0x8000
                    apb_write_reg('h0000+'h424,'h8000,DUT_HOST);// CMN_TXPDCAL_OVRD             addr=0x424     value=0x8000
                    apb_write_reg('h0000+'h444,'h8000,DUT_HOST);// CMN_RXCAL_OVRD               addr=0x444     value=0x8000
                    apb_write_reg('h0000+'h48c,'h8001,DUT_HOST);// CMN_SD_CAL_OVRD              addr=0x48c     value=0x8001
                    $display("PHY Auto Speedup Configuration Completed");
                    tb_top.phy_reset_n = 1'b1;
                    $display("phy_reset_n released");
                `else
                    $display("DIS CDN_SIM_SPEEDUP");
                    #1000;
                    tb_top.phy_reset_n = 1'b1;
                    $display("phy_reset_n released");
                `endif
            //}}
            
            // Wait for PCS ready   (p2)
            //{{
                tb_top.pipe7_reset_n = 1;
                #20ns;
                tb_top.pipe7_pll0_en = 1;
                rdata = 0;
                while(!rdata) begin
                    #100us;
                    apb_read_field('h38008,3,1,DUT_HOST,rdata);
                end
                apb_write_field('h3002c,5,1,1,DUT_HOST);
                #10ns;
                // wait(tb_top.pipe7_pll0_ok==1);
                #20ns;
                tb_top.pipe7_clk_max_req = 1;
                @(posedge tb_top.pipe7_clk_max_ack);
                fork
                    begin
                        @(negedge tb_top.pipe7_l00_phy_status);
                        $display("lane 0 enabled");
                        @(negedge tb_top.pipe7_l00_clk);
                        tb_top.pipe7_l00_rx_termination = 1'b1;
                    end
                    if(lane_num == 2) begin
                      @(negedge tb_top.pipe7_l01_phy_status);
                      $display("lane 1 enabled");
                      @(negedge tb_top.pipe7_l01_clk);
                      tb_top.pipe7_l01_rx_termination = 1'b1;
                    end
                join
            //}}
        end
    endtask

`endif