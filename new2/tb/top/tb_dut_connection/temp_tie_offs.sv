`ifndef TEMP_TIE_OFFS__SV
`define TEMP_TIE_OFFS__SV
//basic initial value from tie-off table
    initial begin
        `ifdef CDNS_PMA_PWR_AWARE
        agnd                       = 0;
        avdd_clk                   = 1;
        avdd_h                     = 1;
        avdd                       = 1;
        avdd_tx0                   = 1;
        avdd_tx1                   = 1;
        avdd_tx2                   = 1;
        avdd_tx3                   = 1;
        avdd_rx                    = 1;
        cmn_aonvdd                 = 1;
        `endif
        sram_rd_data_top           = 0;
        sram_rd_data_ln_01         = 0;
        sram_rd_data_ln_23         = 0;
        `ifdef CDN_UCTLR_DUAL_PORT_RAM  
        iram_rd_data_top           = 0;
        iram_rd_data_ln_01         = 0;
        iram_rd_data_ln_23         = 0;
        `endif
        tap_tck                    = 0;
        tap_tms                    = 0;
        tap_trst_n                 = 0;
        tap_tdi                    = 0;
        uc_top_tap_tck             = 0;
        uc_top_tap_tms             = 0;
        uc_top_tap_trst_n          = 0;
        uc_top_tap_tdi             = 0;
        uc_l01_tap_tck             = 0;
        uc_l01_tap_tms             = 0;
        uc_l01_tap_trst_n          = 0;
        uc_l01_tap_tdi             = 0;
        uc_l23_tap_tck             = 0;
        uc_l23_tap_tms             = 0;
        uc_l23_tap_trst_n          = 0;
        uc_l23_tap_tdi             = 0;
        ieee1687_interface_en      = 0;
        ieee1687_si                = 0;
        ieee1687_capture_en        = 0;
        ieee1687_shift_en          = 0;
        ieee1687_update_en         = 0;
        ieee1687_sel               = 0;
        ieee1687_rstn              = 0;
        ieee1687_tck               = 0;
        phy_l00_ctlr_interrupt_in  = 0;
        phy_l01_ctlr_interrupt_in  = 0;
        iddq_en                    = 0;
        scanmode                   = 0;
        scanen                     = 0;
        scanen_cg                  = 0;
        cmn_scan_pll_ats           = 0;
    end

//apb initial value
    initial begin
        apb_penable[DUT_HOST] = 1'b0;     // 初始未使能传输
        apb_psel[DUT_HOST]    = 1'b0;     // 初始未选中外设
        apb_pwrite[DUT_HOST]  = 1'b0;     // 默认是读操作
        apb_paddr[DUT_HOST]   = 18'h0;    // 地址清零
        apb_pwdata[DUT_HOST]  = 32'h0;    // 写数据清零 
    end
`endif