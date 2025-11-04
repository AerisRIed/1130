`ifndef DUT_CONNECT__SV
`define DUT_CONNECT__SV
//------------------------------------------------------------------
// DUT connection
// Note: use the same portname of dut
//------------------------------------------------------------------
    // ======================================================
    // 1) Signal declarations (module inputs as reg; outputs/inouts as wire)
    // ======================================================

    `ifdef CDNS_PHY_PWR_AWARE
    reg  agnd;
    reg  avdd_clk;
    reg  avdd_h;
    reg  avdd;
    reg  avdd_tx0;
    reg  avdd_tx1;
    reg  avdd_tx2;
    reg  avdd_tx3;
    reg  avdd_rx;
    reg  cmn_aonvdd;
    `endif

    wire tx_p_ln_0;
    wire tx_m_ln_0;
    tri rx_p_ln_1;
    tri rx_m_ln_1;
    tri rx_p_ln_2;
    tri rx_m_ln_2;
    wire tx_p_ln_3;
    wire tx_m_ln_3;
    wire cmn_rext;

    `ifndef MP_PHY_NO_ATB
    wire pma_atb_core_0;
    wire pma_atb_core_1;
    `endif

    // External SRAM (TOP)
    wire                       sram_clk_top;
    wire                       sram_ceb_top;
    wire                       sram_web_top;
    wire [3:0]                 sram_bweb_top;
    wire [`SRAM_DEPTH:0]       sram_addr_top;
    wire [`SRAM_WIDTH:0]       sram_wr_data_top;
    reg  [`SRAM_WIDTH:0]       sram_rd_data_top;
    `ifdef CDN_UCTLR_DUAL_PORT_RAM
    wire [`SRAM_DEPTH:0]       iram_addr_top;
    reg  [`SRAM_WIDTH:0]       iram_rd_data_top;
    wire                       iram_ceb_top;
    wire                       iram_web_top;
    wire [`SRAM_WIDTH:0]       iram_wr_data_top;
    `endif
    wire                       sram_pwrdwn_top;

    `ifndef CDN_MPPHY_LANE_UC_RMV
    // External SRAM (LANE 01)
    wire                       sram_clk_ln_01;
    wire                       sram_ceb_ln_01;
    wire                       sram_web_ln_01;
    wire [3:0]                 sram_bweb_ln_01;
    wire [`SRAM_DEPTH:0]       sram_addr_ln_01;
    wire [`SRAM_WIDTH:0]       sram_wr_data_ln_01;
    reg  [`SRAM_WIDTH:0]       sram_rd_data_ln_01;
    `ifdef CDN_UCTLR_DUAL_PORT_RAM
    wire [`SRAM_DEPTH:0]       iram_addr_ln_01;
    reg  [`SRAM_WIDTH:0]       iram_rd_data_ln_01;
    wire                       iram_ceb_ln_01;
    wire                       iram_web_ln_01;
    wire [`SRAM_WIDTH:0]       iram_wr_data_ln_01;
    `endif
    wire                       sram_pwrdwn_ln_01;

    // External SRAM (LANE 23)
    wire                       sram_clk_ln_23;
    wire                       sram_ceb_ln_23;
    wire                       sram_web_ln_23;
    wire [3:0]                 sram_bweb_ln_23;
    wire [`SRAM_DEPTH:0]       sram_addr_ln_23;
    wire [`SRAM_WIDTH:0]       sram_wr_data_ln_23;
    reg  [`SRAM_WIDTH:0]       sram_rd_data_ln_23;
    `ifdef CDN_UCTLR_DUAL_PORT_RAM
    wire [`SRAM_DEPTH:0]       iram_addr_ln_23;
    reg  [`SRAM_WIDTH:0]       iram_rd_data_ln_23;
    wire                       iram_ceb_ln_23;
    wire                       iram_web_ln_23;
    wire [`SRAM_WIDTH:0]       iram_wr_data_ln_23;
    `endif
    wire                       sram_pwrdwn_ln_23;
    `endif

    // APB target interface
    reg                        apb_pclk;
    reg                        apb_preset_n;
    reg                        apb_tgt_penable;
    reg                        apb_tgt_psel;
    reg                        apb_tgt_pwrite;
    reg  [17:0]                apb_tgt_paddr;
    reg  [31:0]                apb_tgt_pwdata;
    wire [31:0]                apb_tgt_prdata;
    wire                       apb_tgt_pready;
    wire                       apb_tgt_perr;

    // APB master interface
    wire                       apb_mstr_penable;
    wire                       apb_mstr_psel;
    wire                       apb_mstr_pwrite;
    wire [31:0]                apb_mstr_paddr;
    wire [31:0]                apb_mstr_pwdata;
    reg  [31:0]                apb_mstr_prdata;
    reg                        apb_mstr_pready;
    reg                        apb_mstr_perr;

    // uC related
    reg                        uc_clk;
    reg                        uc_reset_n;
    wire                       phy_uc_init_complete;
    wire                       phy_error_interrupt;

    // PHY interface
    reg                        phy_reset_n;
    reg                        typec_conn_dir;
    wire                       phy_interrupt_usb;
    wire                       phy_interrupt_dp;
    reg  [3:0]                 phy_mode;
    reg                        phy_l00_ctlr_interrupt_in;
    reg                        phy_l01_ctlr_interrupt_in;

    // Original PIPE interface
    wire                       pipe4_clk;
    reg                        pipe4_reset_n;
    reg                        pipe4_rate;
    reg  [1:0]                 pipe4_powerdown;
    reg                        pipe4_eb_mode;

    // PIPE Lane0
    wire                       pipe4_l00_phy_status;
    wire [31:0]                pipe4_l00_rx_data;
    wire [3:0]                 pipe4_l00_rx_data_k;
    wire [3:0]                 pipe4_l00_rx_sync_header;
    wire                       pipe4_l00_rx_start_block;
    wire                       pipe4_l00_rx_data_valid;
    wire                       pipe4_l00_rx_valid;
    wire [2:0]                 pipe4_l00_rx_status;
    wire                       pipe4_l00_rx_elec_idle;

    reg                        pipe4_l00_rx_polarity;
    reg                        pipe4_l00_rx_termination;
    reg                        pipe4_l00_rx_eq_training;
    reg  [31:0]                pipe4_l00_tx_data;
    reg  [3:0]                 pipe4_l00_tx_data_k;
    reg  [3:0]                 pipe4_l00_tx_sync_header;
    reg                        pipe4_l00_tx_start_block;
    reg                        pipe4_l00_tx_data_valid;
    reg                        pipe4_l00_tx_det_rx_lpbk;
    reg                        pipe4_l00_tx_elec_idle;
    reg                        pipe4_l00_tx_ones_zeros;
    reg                        pipe4_l00_tx_128b_enc_byp;
    reg  [1:0]                 pipe4_l00_tx_deemph;

    // PIPE Lane1
    wire                       pipe4_l01_phy_status;
    wire [31:0]                pipe4_l01_rx_data;
    wire [3:0]                 pipe4_l01_rx_data_k;
    wire [3:0]                 pipe4_l01_rx_sync_header;
    wire                       pipe4_l01_rx_start_block;
    wire                       pipe4_l01_rx_data_valid;
    wire                       pipe4_l01_rx_valid;
    wire [2:0]                 pipe4_l01_rx_status;
    wire                       pipe4_l01_rx_elec_idle;

    reg                        pipe4_l01_rx_polarity;
    reg                        pipe4_l01_rx_termination;
    reg                        pipe4_l01_rx_eq_training;
    reg  [31:0]                pipe4_l01_tx_data;
    reg  [3:0]                 pipe4_l01_tx_data_k;
    reg  [3:0]                 pipe4_l01_tx_sync_header;
    reg                        pipe4_l01_tx_start_block;
    reg                        pipe4_l01_tx_data_valid;
    reg                        pipe4_l01_tx_det_rx_lpbk;
    reg                        pipe4_l01_tx_elec_idle;
    reg                        pipe4_l01_tx_ones_zeros;
    reg                        pipe4_l01_tx_128b_enc_byp;
    reg  [1:0]                 pipe4_l01_tx_deemph;

    // Serdes PIPE (USB4)
    wire                       pipe7_clk_max;
    reg                        pipe7_clk_max_req;
    wire                       pipe7_clk_max_ack;
    reg                        pipe7_pll0_en;
    wire                       pipe7_pll0_ok;
    reg                        pipe7_reset_n;

    // Serdes Lane0
    reg                        pipe7_l00_clk;
    reg  [1:0]                 pipe7_l00_rate;
    wire                       pipe7_l00_phy_status;
    wire                       pipe7_l00_rx_clk;
    wire [39:0]                pipe7_l00_rx_data;
    wire                       pipe7_l00_rx_valid;
    wire                       pipe7_l00_rx_standby_status;
    wire                       pipe7_l00_rx_elec_idle;
    reg                        pipe7_l00_rx_termination;
    reg                        pipe7_l00_rx_standby;
    reg  [2:0]                 pipe7_l00_powerdown;
    reg  [39:0]                pipe7_l00_tx_data;
    reg                        pipe7_l00_tx_data_valid;
    reg                        pipe7_l00_tx_det_rx_lpbk;
    reg                        pipe7_l00_tx_elec_idle;
    reg  [7:0]                 pipe7_l00_m2p_messagebus;
    wire [7:0]                 pipe7_l00_p2m_messagebus;

    // Serdes Lane1
    reg                        pipe7_l01_clk;
    reg  [1:0]                 pipe7_l01_rate;
    wire                       pipe7_l01_phy_status;
    wire                       pipe7_l01_rx_clk;
    wire [39:0]                pipe7_l01_rx_data;
    wire                       pipe7_l01_rx_valid;
    wire                       pipe7_l01_rx_standby_status;
    wire                       pipe7_l01_rx_elec_idle;
    reg                        pipe7_l01_rx_termination;
    reg                        pipe7_l01_rx_standby;
    reg  [2:0]                 pipe7_l01_powerdown;
    reg  [39:0]                pipe7_l01_tx_data;
    reg                        pipe7_l01_tx_data_valid;
    reg                        pipe7_l01_tx_det_rx_lpbk;
    reg                        pipe7_l01_tx_elec_idle;
    reg  [7:0]                 pipe7_l01_m2p_messagebus;
    wire [7:0]                 pipe7_l01_p2m_messagebus;

    // Raw interface / link
    wire                       pma_cmn_ready;
    wire                       pma_xcvr_pllclk_en_ack;
    wire [5:0]                 pma_xcvr_power_state_ack;
    wire                       pma_cmn_avdd_pwrgood;
    reg                        pma_xcvr_pllclk_en;
    reg  [5:0]                 pma_xcvr_power_state_req;
    reg  [2:0]                 pma_xcvr_data_width;
    reg                        dp_reset_n;
    reg                        pma_tx_td_clk;
    reg                        pma_tx_lfps_en;
    reg                        pma_tx_lfps_mode;

    // Raw TX lanes 0..3
    reg                        pma_tx_elec_idle_ln_0;
    reg  [31:0]                pma_tx_td_ln_0;
    reg                        pma_tx_elec_idle_ln_1;
    reg  [31:0]                pma_tx_td_ln_1;
    reg                        pma_tx_elec_idle_ln_2;
    reg  [31:0]                pma_tx_td_ln_2;
    reg                        pma_tx_elec_idle_ln_3;
    reg  [31:0]                pma_tx_td_ln_3;

    // Generated clocks / reference outputs
    wire                       usb_datart_clk;
    wire                       usb_fullrt_clk;
    wire                       dp_datart_clk;
    wire                       dp_fullrt_clk;
    reg                        pma_cmn_refclk0_int;
    reg                        pma_cmn_refclk1_int;
    reg  [1:0]                 pma_cmn_refclk_dig_div;
    reg                        pma_cmn_refclk_dig_sel;
    reg  [1:0]                 pma_cmn_pll0_refclk_sel;
    reg  [1:0]                 pma_cmn_pll1_refclk_sel;

    // Digital test bus
    `ifndef CDN_MPPHY_RMV_DTB
    wire [31:0]                dtb_data;
    wire                       dtb_clk;
    `endif

    // TAP (JTAG)
    reg                        tap_tck;
    reg                        tap_tms;
    reg                        tap_trst_n;
    reg                        tap_tdi;
    wire                       tap_tdo;
    wire                       tap_tdoen;

    `ifdef CDN_TESTCHIP_UC_DBGR
    // uC top TAP
    reg                        uc_top_tap_tck;
    reg                        uc_top_tap_tms;
    reg                        uc_top_tap_trst_n;
    reg                        uc_top_tap_tdi;
    wire                       uc_top_tap_tdo;
    wire                       uc_top_tap_tdoen;

    `ifndef CDN_MPPHY_LANE_UC_RMV
    // Lane uC TAP 01
    reg                        uc_l01_tap_tck;
    reg                        uc_l01_tap_tms;
    reg                        uc_l01_tap_trst_n;
    reg                        uc_l01_tap_tdi;
    wire                       uc_l01_tap_tdo;
    wire                       uc_l01_tap_tdoen;
    // Lane uC TAP 23
    reg                        uc_l23_tap_tck;
    reg                        uc_l23_tap_tms;
    reg                        uc_l23_tap_trst_n;
    reg                        uc_l23_tap_tdi;
    wire                       uc_l23_tap_tdo;
    wire                       uc_l23_tap_tdoen;
    `endif
    `endif

    // IEEE1687 (IJTAG)
    reg                        ieee1687_interface_en;
    wire                       ieee1687_so;
    reg                        ieee1687_si;
    reg                        ieee1687_capture_en;
    reg                        ieee1687_shift_en;
    reg                        ieee1687_update_en;
    reg                        ieee1687_sel;
    reg                        ieee1687_rstn;
    reg                        ieee1687_tck;

    // Scan control
    reg                        iddq_en;
    reg                        scanmode;
    reg                        scanen;
    reg                        scanen_cg;
    reg                        cmn_scan_pll_ats;
    wire                       cmn_scanclk_pll0_prog0_ats_out;
    wire                       cmn_scanclk_pll0_prog1_ats_out;
    wire                       cmn_scanclk_pll1_prog0_ats_out;
    wire                       cmn_scanclk_pll1_prog1_ats_out;
    reg                        cmn_scanclk_psmclk;
    reg                        cmn_scanclk_refclk;
    reg                        cmn_scanclk_serclk;
    reg                        cmn_scanclk_pllclk;
    reg                        scanclk_pipeclk;

    // PHY scan chains
    reg  `PHY_SCAN_IN_WIDTH    phy_scanin;
    wire `PHY_SCAN_OUT_WIDTH   phy_scanout;

    // PMA common scan
    reg  `PMA_CMN_SCAN_IN_WIDTH  pma_cmn_scanin;
    wire `PMA_CMN_SCAN_OUT_WIDTH pma_cmn_scanout;

    // PMA per-lane scan
    reg                        xcvr_scanclk_serclk_ln_0;
    reg                        xcvr_scanclk_pllclk_ln_0;
    reg  `PMA_XCVR_SCAN_IN_WIDTH  pma_xcvr_scanin_ln_0;
    wire `PMA_XCVR_SCAN_OUT_WIDTH pma_xcvr_scanout_ln_0;

    reg                        xcvr_scanclk_serclk_ln_1;
    reg                        xcvr_scanclk_pllclk_ln_1;
    reg  `PMA_XCVR_SCAN_IN_WIDTH  pma_xcvr_scanin_ln_1;
    wire `PMA_XCVR_SCAN_OUT_WIDTH pma_xcvr_scanout_ln_1;

    reg                        xcvr_scanclk_serclk_ln_2;
    reg                        xcvr_scanclk_pllclk_ln_2;
    reg  `PMA_XCVR_SCAN_IN_WIDTH  pma_xcvr_scanin_ln_2;
    wire `PMA_XCVR_SCAN_OUT_WIDTH pma_xcvr_scanout_ln_2;

    reg                        xcvr_scanclk_serclk_ln_3;
    reg                        xcvr_scanclk_pllclk_ln_3;
    reg  `PMA_XCVR_SCAN_IN_WIDTH  pma_xcvr_scanin_ln_3;
    wire `PMA_XCVR_SCAN_OUT_WIDTH pma_xcvr_scanout_ln_3;

    // External boundary scan
    reg                              bscan_ext_select;
    reg                              bscan_ext_shiftdr;
    reg                              bscan_ext_clockdr;
    reg                              tx_bscan_ext_updatedr;
    reg                              tx_bscan_ext_mode_c;
    reg                              tx_bscan_ext_ac;
    reg                              tx_bscan_ext_acpulse;
    wire                             tx_bscan_ext_tdo;
    reg                              rx_bscan_ext_pc;
    reg                              rx_bscan_ext_ac;
    reg                              rx_bscan_ext_tdi;

    // Internal boundary scan enable
    reg                        xcvr_bscan_mode_en;

    // ======================================================
    // 2) DUT instantiation
    // ======================================================
    `MP_PHY_TOP_NAME u_dut (
    `ifdef CDNS_PHY_PWR_AWARE
    .agnd(agnd),
    .avdd_clk(avdd_clk),
    .avdd_h(avdd_h),
    .avdd(avdd),
    .avdd_tx0(avdd_tx0),
    .avdd_tx1(avdd_tx1),
    .avdd_tx2(avdd_tx2),
    .avdd_tx3(avdd_tx3),
    .avdd_rx(avdd_rx),
    .cmn_aonvdd(cmn_aonvdd),
    `endif
    .tx_p_ln_0(tx_p_ln_0),
    .tx_m_ln_0(tx_m_ln_0),
    .rx_p_ln_1(rx_p_ln_1),
    .rx_m_ln_1(rx_m_ln_1),
    .rx_p_ln_2(rx_p_ln_2),
    .rx_m_ln_2(rx_m_ln_2),
    .tx_p_ln_3(tx_p_ln_3),
    .tx_m_ln_3(tx_m_ln_3),
    .cmn_rext(cmn_rext),
    `ifndef MP_PHY_NO_ATB
    .pma_atb_core_0(pma_atb_core_0),
    .pma_atb_core_1(pma_atb_core_1),
    `endif
    .sram_clk_top(sram_clk_top),
    .sram_ceb_top(sram_ceb_top),
    .sram_web_top(sram_web_top),
    .sram_bweb_top(sram_bweb_top),
    .sram_addr_top(sram_addr_top),
    .sram_wr_data_top(sram_wr_data_top),
    .sram_rd_data_top(sram_rd_data_top),
    `ifdef CDN_UCTLR_DUAL_PORT_RAM
    .iram_addr_top(iram_addr_top),
    .iram_rd_data_top(iram_rd_data_top),
    .iram_ceb_top(iram_ceb_top),
    .iram_web_top(iram_web_top),
    .iram_wr_data_top(iram_wr_data_top),
    `endif
    .sram_pwrdwn_top(sram_pwrdwn_top),
    `ifndef CDN_MPPHY_LANE_UC_RMV
    .sram_clk_ln_01(sram_clk_ln_01),
    .sram_ceb_ln_01(sram_ceb_ln_01),
    .sram_web_ln_01(sram_web_ln_01),
    .sram_bweb_ln_01(sram_bweb_ln_01),
    .sram_addr_ln_01(sram_addr_ln_01),
    .sram_wr_data_ln_01(sram_wr_data_ln_01),
    .sram_rd_data_ln_01(sram_rd_data_ln_01),
    `ifdef CDN_UCTLR_DUAL_PORT_RAM
    .iram_addr_ln_01(iram_addr_ln_01),
    .iram_rd_data_ln_01(iram_rd_data_ln_01),
    .iram_ceb_ln_01(iram_ceb_ln_01),
    .iram_web_ln_01(iram_web_ln_01),
    .iram_wr_data_ln_01(iram_wr_data_ln_01),
    `endif
    .sram_pwrdwn_ln_01(sram_pwrdwn_ln_01),
    .sram_clk_ln_23(sram_clk_ln_23),
    .sram_ceb_ln_23(sram_ceb_ln_23),
    .sram_web_ln_23(sram_web_ln_23),
    .sram_bweb_ln_23(sram_bweb_ln_23),
    .sram_addr_ln_23(sram_addr_ln_23),
    .sram_wr_data_ln_23(sram_wr_data_ln_23),
    .sram_rd_data_ln_23(sram_rd_data_ln_23),
    `ifdef CDN_UCTLR_DUAL_PORT_RAM
    .iram_addr_ln_23(iram_addr_ln_23),
    .iram_rd_data_ln_23(iram_rd_data_ln_23),
    .iram_ceb_ln_23(iram_ceb_ln_23),
    .iram_web_ln_23(iram_web_ln_23),
    .iram_wr_data_ln_23(iram_wr_data_ln_23),
    `endif
    .sram_pwrdwn_ln_23(sram_pwrdwn_ln_23),
    `endif
    .apb_pclk(apb_pclk),
    .apb_preset_n(apb_preset_n),
    .apb_tgt_penable(apb_tgt_penable),
    .apb_tgt_psel(apb_tgt_psel),
    .apb_tgt_pwrite(apb_tgt_pwrite),
    .apb_tgt_paddr(apb_tgt_paddr),
    .apb_tgt_pwdata(apb_tgt_pwdata),
    .apb_tgt_prdata(apb_tgt_prdata),
    .apb_tgt_pready(apb_tgt_pready),
    .apb_tgt_perr(apb_tgt_perr),
    .apb_mstr_penable(apb_mstr_penable),
    .apb_mstr_psel(apb_mstr_psel),
    .apb_mstr_pwrite(apb_mstr_pwrite),
    .apb_mstr_paddr(apb_mstr_paddr),
    .apb_mstr_pwdata(apb_mstr_pwdata),
    .apb_mstr_prdata(apb_mstr_prdata),
    .apb_mstr_pready(apb_mstr_pready),
    .apb_mstr_perr(apb_mstr_perr),
    .uc_clk(uc_clk),
    .uc_reset_n(uc_reset_n),
    .phy_uc_init_complete(phy_uc_init_complete),
    .phy_error_interrupt(phy_error_interrupt),
    .phy_reset_n(phy_reset_n),
    .typec_conn_dir(typec_conn_dir),
    .phy_interrupt_usb(phy_interrupt_usb),
    .phy_interrupt_dp(phy_interrupt_dp),
    .phy_mode(phy_mode),
    .phy_l00_ctlr_interrupt_in(phy_l00_ctlr_interrupt_in),
    .phy_l01_ctlr_interrupt_in(phy_l01_ctlr_interrupt_in),
    .pipe4_clk(pipe4_clk),
    .pipe4_reset_n(pipe4_reset_n),
    .pipe4_rate(pipe4_rate),
    .pipe4_powerdown(pipe4_powerdown),
    .pipe4_eb_mode(pipe4_eb_mode),
    .pipe4_l00_phy_status(pipe4_l00_phy_status),
    .pipe4_l00_rx_data(pipe4_l00_rx_data),
    .pipe4_l00_rx_data_k(pipe4_l00_rx_data_k),
    .pipe4_l00_rx_sync_header(pipe4_l00_rx_sync_header),
    .pipe4_l00_rx_start_block(pipe4_l00_rx_start_block),
    .pipe4_l00_rx_data_valid(pipe4_l00_rx_data_valid),
    .pipe4_l00_rx_valid(pipe4_l00_rx_valid),
    .pipe4_l00_rx_status(pipe4_l00_rx_status),
    .pipe4_l00_rx_elec_idle(pipe4_l00_rx_elec_idle),
    .pipe4_l00_rx_polarity(pipe4_l00_rx_polarity),
    .pipe4_l00_rx_termination(pipe4_l00_rx_termination),
    .pipe4_l00_rx_eq_training(pipe4_l00_rx_eq_training),
    .pipe4_l00_tx_data(pipe4_l00_tx_data),
    .pipe4_l00_tx_data_k(pipe4_l00_tx_data_k),
    .pipe4_l00_tx_sync_header(pipe4_l00_tx_sync_header),
    .pipe4_l00_tx_start_block(pipe4_l00_tx_start_block),
    .pipe4_l00_tx_data_valid(pipe4_l00_tx_data_valid),
    .pipe4_l00_tx_det_rx_lpbk(pipe4_l00_tx_det_rx_lpbk),
    .pipe4_l00_tx_elec_idle(pipe4_l00_tx_elec_idle),
    .pipe4_l00_tx_ones_zeros(pipe4_l00_tx_ones_zeros),
    .pipe4_l00_tx_128b_enc_byp(pipe4_l00_tx_128b_enc_byp),
    .pipe4_l00_tx_deemph(pipe4_l00_tx_deemph),
    .pipe4_l01_phy_status(pipe4_l01_phy_status),
    .pipe4_l01_rx_data(pipe4_l01_rx_data),
    .pipe4_l01_rx_data_k(pipe4_l01_rx_data_k),
    .pipe4_l01_rx_sync_header(pipe4_l01_rx_sync_header),
    .pipe4_l01_rx_start_block(pipe4_l01_rx_start_block),
    .pipe4_l01_rx_data_valid(pipe4_l01_rx_data_valid),
    .pipe4_l01_rx_valid(pipe4_l01_rx_valid),
    .pipe4_l01_rx_status(pipe4_l01_rx_status),
    .pipe4_l01_rx_elec_idle(pipe4_l01_rx_elec_idle),
    .pipe4_l01_rx_polarity(pipe4_l01_rx_polarity),
    .pipe4_l01_rx_termination(pipe4_l01_rx_termination),
    .pipe4_l01_rx_eq_training(pipe4_l01_rx_eq_training),
    .pipe4_l01_tx_data(pipe4_l01_tx_data),
    .pipe4_l01_tx_data_k(pipe4_l01_tx_data_k),
    .pipe4_l01_tx_sync_header(pipe4_l01_tx_sync_header),
    .pipe4_l01_tx_start_block(pipe4_l01_tx_start_block),
    .pipe4_l01_tx_data_valid(pipe4_l01_tx_data_valid),
    .pipe4_l01_tx_det_rx_lpbk(pipe4_l01_tx_det_rx_lpbk),
    .pipe4_l01_tx_elec_idle(pipe4_l01_tx_elec_idle),
    .pipe4_l01_tx_ones_zeros(pipe4_l01_tx_ones_zeros),
    .pipe4_l01_tx_128b_enc_byp(pipe4_l01_tx_128b_enc_byp),
    .pipe4_l01_tx_deemph(pipe4_l01_tx_deemph),
    .pipe7_clk_max(pipe7_clk_max),
    .pipe7_clk_max_req(pipe7_clk_max_req),
    .pipe7_clk_max_ack(pipe7_clk_max_ack),
    .pipe7_pll0_en(pipe7_pll0_en),
    .pipe7_pll0_ok(pipe7_pll0_ok),
    .pipe7_reset_n(pipe7_reset_n),
    .pipe7_l00_clk(pipe7_l00_clk),
    .pipe7_l00_rate(pipe7_l00_rate),
    .pipe7_l00_phy_status(pipe7_l00_phy_status),
    .pipe7_l00_rx_clk(pipe7_l00_rx_clk),
    .pipe7_l00_rx_data(pipe7_l00_rx_data),
    .pipe7_l00_rx_valid(pipe7_l00_rx_valid),
    .pipe7_l00_rx_standby_status(pipe7_l00_rx_standby_status),
    .pipe7_l00_rx_elec_idle(pipe7_l00_rx_elec_idle),
    .pipe7_l00_rx_termination(pipe7_l00_rx_termination),
    .pipe7_l00_rx_standby(pipe7_l00_rx_standby),
    .pipe7_l00_powerdown(pipe7_l00_powerdown),
    .pipe7_l00_tx_data(pipe7_l00_tx_data),
    .pipe7_l00_tx_data_valid(pipe7_l00_tx_data_valid),
    .pipe7_l00_tx_det_rx_lpbk(pipe7_l00_tx_det_rx_lpbk),
    .pipe7_l00_tx_elec_idle(pipe7_l00_tx_elec_idle),
    .pipe7_l00_m2p_messagebus(pipe7_l00_m2p_messagebus),
    .pipe7_l00_p2m_messagebus(pipe7_l00_p2m_messagebus),
    .pipe7_l01_clk(pipe7_l01_clk),
    .pipe7_l01_rate(pipe7_l01_rate),
    .pipe7_l01_phy_status(pipe7_l01_phy_status),
    .pipe7_l01_rx_clk(pipe7_l01_rx_clk),
    .pipe7_l01_rx_data(pipe7_l01_rx_data),
    .pipe7_l01_rx_valid(pipe7_l01_rx_valid),
    .pipe7_l01_rx_standby_status(pipe7_l01_rx_standby_status),
    .pipe7_l01_rx_elec_idle(pipe7_l01_rx_elec_idle),
    .pipe7_l01_rx_termination(pipe7_l01_rx_termination),
    .pipe7_l01_rx_standby(pipe7_l01_rx_standby),
    .pipe7_l01_powerdown(pipe7_l01_powerdown),
    .pipe7_l01_tx_data(pipe7_l01_tx_data),
    .pipe7_l01_tx_data_valid(pipe7_l01_tx_data_valid),
    .pipe7_l01_tx_det_rx_lpbk(pipe7_l01_tx_det_rx_lpbk),
    .pipe7_l01_tx_elec_idle(pipe7_l01_tx_elec_idle),
    .pipe7_l01_m2p_messagebus(pipe7_l01_m2p_messagebus),
    .pipe7_l01_p2m_messagebus(pipe7_l01_p2m_messagebus),
    .pma_cmn_ready(pma_cmn_ready),
    .pma_xcvr_pllclk_en_ack(pma_xcvr_pllclk_en_ack),
    .pma_xcvr_power_state_ack(pma_xcvr_power_state_ack),
    .pma_cmn_avdd_pwrgood(pma_cmn_avdd_pwrgood),
    .pma_xcvr_pllclk_en(pma_xcvr_pllclk_en),
    .pma_xcvr_power_state_req(pma_xcvr_power_state_req),
    .pma_xcvr_data_width(pma_xcvr_data_width),
    .dp_reset_n(dp_reset_n),
    .pma_tx_td_clk(pma_tx_td_clk),
    .pma_tx_lfps_en(pma_tx_lfps_en),
    .pma_tx_lfps_mode(pma_tx_lfps_mode),
    .pma_tx_elec_idle_ln_0(pma_tx_elec_idle_ln_0),
    .pma_tx_td_ln_0(pma_tx_td_ln_0),
    .pma_tx_elec_idle_ln_1(pma_tx_elec_idle_ln_1),
    .pma_tx_td_ln_1(pma_tx_td_ln_1),
    .pma_tx_elec_idle_ln_2(pma_tx_elec_idle_ln_2),
    .pma_tx_td_ln_2(pma_tx_td_ln_2),
    .pma_tx_elec_idle_ln_3(pma_tx_elec_idle_ln_3),
    .pma_tx_td_ln_3(pma_tx_td_ln_3),
    .usb_datart_clk(usb_datart_clk),
    .usb_fullrt_clk(usb_fullrt_clk),
    .dp_datart_clk(dp_datart_clk),
    .dp_fullrt_clk(dp_fullrt_clk),
    .pma_cmn_refclk0_int(pma_cmn_refclk0_int),
    .pma_cmn_refclk1_int(pma_cmn_refclk1_int),
    .pma_cmn_refclk_dig_div(pma_cmn_refclk_dig_div),
    .pma_cmn_refclk_dig_sel(pma_cmn_refclk_dig_sel),
    .pma_cmn_pll0_refclk_sel(pma_cmn_pll0_refclk_sel),
    .pma_cmn_pll1_refclk_sel(pma_cmn_pll1_refclk_sel),
    `ifndef CDN_MPPHY_RMV_DTB
    .dtb_data(dtb_data),
    .dtb_clk(dtb_clk),
    `endif
    .tap_tck(tap_tck),
    .tap_tms(tap_tms),
    .tap_trst_n(tap_trst_n),
    .tap_tdi(tap_tdi),
    .tap_tdo(tap_tdo),
    .tap_tdoen(tap_tdoen),
    `ifdef CDN_TESTCHIP_UC_DBGR
    .uc_top_tap_tck(uc_top_tap_tck),
    .uc_top_tap_tms(uc_top_tap_tms),
    .uc_top_tap_trst_n(uc_top_tap_trst_n),
    .uc_top_tap_tdi(uc_top_tap_tdi),
    .uc_top_tap_tdo(uc_top_tap_tdo),
    .uc_top_tap_tdoen(uc_top_tap_tdoen),
    `ifndef CDN_MPPHY_LANE_UC_RMV
    .uc_l01_tap_tck(uc_l01_tap_tck),
    .uc_l01_tap_tms(uc_l01_tap_tms),
    .uc_l01_tap_trst_n(uc_l01_tap_trst_n),
    .uc_l01_tap_tdi(uc_l01_tap_tdi),
    .uc_l01_tap_tdo(uc_l01_tap_tdo),
    .uc_l01_tap_tdoen(uc_l01_tap_tdoen),
    .uc_l23_tap_tck(uc_l23_tap_tck),
    .uc_l23_tap_tms(uc_l23_tap_tms),
    .uc_l23_tap_trst_n(uc_l23_tap_trst_n),
    .uc_l23_tap_tdi(uc_l23_tap_tdi),
    .uc_l23_tap_tdo(uc_l23_tap_tdo),
    .uc_l23_tap_tdoen(uc_l23_tap_tdoen),
    `endif
    `endif
    .ieee1687_interface_en(ieee1687_interface_en),
    .ieee1687_so(ieee1687_so),
    .ieee1687_si(ieee1687_si),
    .ieee1687_capture_en(ieee1687_capture_en),
    .ieee1687_shift_en(ieee1687_shift_en),
    .ieee1687_update_en(ieee1687_update_en),
    .ieee1687_sel(ieee1687_sel),
    .ieee1687_rstn(ieee1687_rstn),
    .ieee1687_tck(ieee1687_tck),
    .iddq_en(iddq_en),
    .scanmode(scanmode),
    .scanen(scanen),
    .scanen_cg(scanen_cg),
    .cmn_scan_pll_ats(cmn_scan_pll_ats),
    .cmn_scanclk_pll0_prog0_ats_out(cmn_scanclk_pll0_prog0_ats_out),
    .cmn_scanclk_pll0_prog1_ats_out(cmn_scanclk_pll0_prog1_ats_out),
    .cmn_scanclk_pll1_prog0_ats_out(cmn_scanclk_pll1_prog0_ats_out),
    .cmn_scanclk_pll1_prog1_ats_out(cmn_scanclk_pll1_prog1_ats_out),
    .cmn_scanclk_psmclk(cmn_scanclk_psmclk),
    .cmn_scanclk_refclk(cmn_scanclk_refclk),
    .cmn_scanclk_serclk(cmn_scanclk_serclk),
    .cmn_scanclk_pllclk(cmn_scanclk_pllclk),
    .scanclk_pipeclk(scanclk_pipeclk),
    .phy_scanin(phy_scanin),
    .phy_scanout(phy_scanout),
    .pma_cmn_scanin(pma_cmn_scanin),
    .pma_cmn_scanout(pma_cmn_scanout),
    .xcvr_scanclk_serclk_ln_0(xcvr_scanclk_serclk_ln_0),
    .xcvr_scanclk_pllclk_ln_0(xcvr_scanclk_pllclk_ln_0),
    .pma_xcvr_scanin_ln_0(pma_xcvr_scanin_ln_0),
    .pma_xcvr_scanout_ln_0(pma_xcvr_scanout_ln_0),
    .xcvr_scanclk_serclk_ln_1(xcvr_scanclk_serclk_ln_1),
    .xcvr_scanclk_pllclk_ln_1(xcvr_scanclk_pllclk_ln_1),
    .pma_xcvr_scanin_ln_1(pma_xcvr_scanin_ln_1),
    .pma_xcvr_scanout_ln_1(pma_xcvr_scanout_ln_1),
    .xcvr_scanclk_serclk_ln_2(xcvr_scanclk_serclk_ln_2),
    .xcvr_scanclk_pllclk_ln_2(xcvr_scanclk_pllclk_ln_2),
    .pma_xcvr_scanin_ln_2(pma_xcvr_scanin_ln_2),
    .pma_xcvr_scanout_ln_2(pma_xcvr_scanout_ln_2),
    .xcvr_scanclk_serclk_ln_3(xcvr_scanclk_serclk_ln_3),
    .xcvr_scanclk_pllclk_ln_3(xcvr_scanclk_pllclk_ln_3),
    .pma_xcvr_scanin_ln_3(pma_xcvr_scanin_ln_3),
    .pma_xcvr_scanout_ln_3(pma_xcvr_scanout_ln_3),
    .bscan_ext_select(scan_ext_select),
    .bscan_ext_shiftdr(scan_ext_shiftdr),
    .bscan_ext_clockdr(scan_ext_clockdr),
    .tx_bscan_ext_updatedr(x_bscan_ext_updatedr),
    .tx_bscan_ext_mode_c(x_bscan_ext_mode_c),
    .tx_bscan_ext_ac(x_bscan_ext_ac),
    .tx_bscan_ext_acpulse(x_bscan_ext_acpulse),
    .tx_bscan_ext_tdo(x_bscan_ext_tdo),
    .rx_bscan_ext_pc(x_bscan_ext_pc),
    .rx_bscan_ext_ac(x_bscan_ext_ac),
    .rx_bscan_ext_tdi(x_bscan_ext_tdi),
    .xcvr_bscan_mode_en(xcvr_bscan_mode_en)
    );
//------------------------------------------------------------------
// clock gen
// Use a clock generator module to generate a clock for the testbench.
// User can add clock here for testcase
// source code ref to ../tb_common_moudle/clock_generator.sv
//------------------------------------------------------------------
    logic APB_PCLK_500MHZ;
    real APB_PCLK_500MHZ_PERIOD = 2.0;
    logic APB_PCLK_500MHZ_RST_N = 1'b0;
    clock_generator #(.DUTY_CYCLE(0.5), .JITTER(0), .SKEW(0)) 
    u_APB_PCLK_500MHZ (
        .clk(APB_PCLK_500MHZ),
        .rst_n(APB_PCLK_500MHZ_RST_N),
        .PERIOD(APB_PCLK_500MHZ_PERIOD)
    );
    
    logic UC_CLK_500MHZ;
    real UC_CLK_500MHZ_PERIOD = 2.0;
    logic UC_CLK_500MHZ_RST_N = 1'b0;
    clock_generator #(.DUTY_CYCLE(0.5), .JITTER(0), .SKEW(0)) 
    u_UC_CLK_500MHZ (
        .clk(UC_CLK_500MHZ),
        .rst_n(UC_CLK_500MHZ_RST_N),
        .PERIOD(UC_CLK_500MHZ_PERIOD)
    );
    
    logic REFCLK;
    real REFCLK_PERIOD = 10.0;
    logic REFCLK_RST_N = 1'b0;
    clock_generator #(.DUTY_CYCLE(0.5), .JITTER(0), .SKEW(0)) 
    u_REFCLK (
        .clk(REFCLK),
        .rst_n(REFCLK_RST_N),
        .PERIOD(REFCLK_PERIOD)
    );
    
    // logic PIPE7_PCLK;
    // real PIPE7_PCLK_PERIOD = 3.2;
    // logic PIPE7_PCLK_RST_N = 1'b0;
    // clock_generator #(.DUTY_CYCLE(0.5), .JITTER(0), .SKEW(0)) 
    // u_PIPE7_PCLK (
    //     .clk(PIPE7_PCLK),
    //     .rst_n(PIPE7_PCLK_RST_N),
    //     .PERIOD(PIPE7_PCLK_PERIOD)
    // );

    // logic PMA_TX_TD_CLK;
    // real PMA_TX_TD_CLK_PERIOD = 3.2;
    // logic PMA_TX_TD_CLK_RST_N = 1'b0;
    // clock_generator #(.DUTY_CYCLE(0.5), .JITTER(0), .SKEW(0)) 
    // u_PMA_TX_TD_CLK (
    //     .clk(PMA_TX_TD_CLK),
    //     .rst_n(PMA_TX_TD_CLK_RST_N),
    //     .PERIOD(PMA_TX_TD_CLK_PERIOD)
    // );

    // assign pipe7_l00_clk                   = PIPE7_PCLK;
    assign apb_pclk                        = APB_PCLK_500MHZ;
    assign pma_cmn_refclk0_int             = REFCLK;
    assign pma_cmn_refclk1_int             = REFCLK;
    assign uc_clk                          = UC_CLK_500MHZ;
    assign pma_tx_td_clk                   = dp_datart_clk;
//-----------------------------------------------------------------
// common config
    `ifdef X1_LANE       int     lane_num = 1;
    `elsif X2_LANE       int     lane_num = 2;
    `elsif X4_LANE       int     lane_num = 4;
    `else                int     lane_num = 1;
    `endif
    
    `ifdef  GEN1        int     gen_mode = 1        ;
    `elsif  GEN2        int     gen_mode = 2        ;
    `elsif  GEN3        int     gen_mode = 3        ;
    `elsif  UHBR20      int     gen_mode = UHBR20   ;
    `elsif  UHBR13P5    int     gen_mode = UHBR13P5 ;
    `elsif  UHBR10      int     gen_mode = UHBR10   ;
    `elsif  HBR3        int     gen_mode = HBR3     ;
    `elsif  HBR2        int     gen_mode = HBR2     ;
    `elsif  HBR         int     gen_mode = HBR      ;
    `elsif  RBR         int     gen_mode = RBR      ;
    `else               int     gen_mode = 1        ;
    `endif

    
//-
//------------------------------------------------------------------
// USB32/USB4 loopback connection
// basic : lane0: tx0 -> rx1
//         lane1: tx3 -> rx2
//
// flip :  lane0: tx3 -> rx2
//         lane1: tx0 -> rx1
//------------------------------------------------------------------
    logic usb_lpbk_en;
    `ifndef DP_ONLY
        assign rx_p_ln_1   = usb_lpbk_en? tx_p_ln_0 : 'bz;
        assign rx_m_ln_1   = usb_lpbk_en? tx_m_ln_0 : 'bz;
        assign rx_p_ln_2   = usb_lpbk_en? tx_p_ln_3 : 'bz;
        assign rx_m_ln_2   = usb_lpbk_en? tx_m_ln_3 : 'bz;
    `endif
//------------------------------------------------------------------

//------------------------------------------------------------------
// USB32/USB4 loopback connection
// basic : lane0: tx0 -> rx1
//         lane1: tx3 -> rx2
//
// flip :  lane0: tx3 -> rx2
//         lane1: tx0 -> rx1
//------------------------------------------------------------------
    logic pipe7_clk_max_div2;
    clk_div2_noreset u_pipe7_l00_div2(pipe7_clk_max,pipe7_clk_max_div2);
    assign pipe7_l00_clk = (gen_mode == 3)? pipe7_clk_max : pipe7_clk_max_div2;
    assign pipe7_l01_clk = (gen_mode == 3)? pipe7_clk_max : pipe7_clk_max_div2;
//------------------------------------------------------------------
//------------------------------------------------------------------
// DP chcker (sd_deserializer) for four raw serdes lane
//------------------------------------------------------------------
    //------------------------------------------------------------------
    // gen_mode to DP protocol mapping
    //------------------------------------------------------------------
    // ds_gen_mode_ln_x:    3'b000 → RBR      → 1.62 Gbps  → clk_period = 617.28 ps
    // ds_gen_mode_ln_x:    3'b001 → HBR      → 2.70 Gbps  → clk_period = 370.37 ps
    // ds_gen_mode_ln_x:    3'b010 → HBR2     → 5.40 Gbps  → clk_period = 185.19 ps
    // ds_gen_mode_ln_x:    3'b011 → HBR3     → 8.10 Gbps  → clk_period = 123.46 ps
    // ds_gen_mode_ln_x:    3'b100 → UHBR10   → 10.00 Gbps → clk_period = 100.00 ps
    // ds_gen_mode_ln_x:    3'b101 → UHBR13.5 → 13.50 Gbps → clk_period = 74.07  ps
    // ds_gen_mode_ln_x:    3'b110 → UHBR20   → 20.00 Gbps → clk_period = 50.00  ps
//------------------------------------------------------------------
    reg	         ds_enable_ln_0    , ds_enable_ln_1    , ds_enable_ln_2    , ds_enable_ln_3;
    reg	         int_ds_enable_ln_0, int_ds_enable_ln_1, int_ds_enable_ln_2, int_ds_enable_ln_3;
    
    reg   [2:0]  ds_gen_mode_ln_0    , ds_gen_mode_ln_1    , ds_gen_mode_ln_2    , ds_gen_mode_ln_3;
    reg   [2:0]  int_ds_gen_mode_ln_0, int_ds_gen_mode_ln_1, int_ds_gen_mode_ln_2, int_ds_gen_mode_ln_3;
    
    reg	         ds_clk_ln_0    , ds_clk_ln_1   , ds_clk_ln_2     , ds_clk_ln_3;
    wire	     int_ds_clk_ln_0, int_ds_clk_ln_1, int_ds_clk_ln_2, int_ds_clk_ln_3;
    
    reg [15:0]    ds_data_ln_0    , ds_data_ln_1    , ds_data_ln_2    , ds_data_ln_3;
    wire [15:0]   int_ds_data_ln_0, int_ds_data_ln_1, int_ds_data_ln_2, int_ds_data_ln_3;
    
    reg          ds_dvalid_ln_0    , ds_dvalid_ln_1    , ds_dvalid_ln_2    , ds_dvalid_ln_3;
    wire         int_ds_dvalid_ln_0, int_ds_dvalid_ln_1, int_ds_dvalid_ln_2, int_ds_dvalid_ln_3;

// Lane enable switches: 1 = enabled, 0 = disabled
    bit dp_lane_enable_0 = 0;
    bit dp_lane_enable_1 = 0;
    bit dp_lane_enable_2 = 0;
    bit dp_lane_enable_3 = 0;

    // 定义宏：参数是 lane 索引
    sd_deserializer_lock i_deserializer_ln_0 (
        .gen_mode (ds_gen_mode_ln_0),
        .rx_p     (tx_p_ln_0),
        .rx_m     (tx_m_ln_0),
        .enable   (int_ds_enable_ln_0),
        .clk_out  (int_ds_clk_ln_0),
        .dout     (int_ds_data_ln_0),
        .dvalid   (int_ds_dvalid_ln_0)
    );

    sd_deserializer_lock i_deserializer_ln_1 (
        .gen_mode (ds_gen_mode_ln_1),
        .rx_p     (rx_p_ln_1),
        .rx_m     (rx_m_ln_1),
        .enable   (int_ds_enable_ln_1),
        .clk_out  (int_ds_clk_ln_1),
        .dout     (int_ds_data_ln_1),
        .dvalid   (int_ds_dvalid_ln_1) 
    );

    sd_deserializer_lock i_deserializer_ln_2 (
        .gen_mode (ds_gen_mode_ln_2),
        .rx_p     (rx_p_ln_2),
        .rx_m     (rx_m_ln_2),
        .enable   (int_ds_enable_ln_2),
        .clk_out  (int_ds_clk_ln_2),
        .dout     (int_ds_data_ln_2),
        .dvalid   (int_ds_dvalid_ln_2) 
    );
    
    sd_deserializer_lock i_deserializer_ln_3 (
        .gen_mode (ds_gen_mode_ln_3),
        .rx_p     (tx_p_ln_3),
        .rx_m     (tx_m_ln_3),
        .enable   (int_ds_enable_ln_3),
        .clk_out  (int_ds_clk_ln_3),
        .dout     (int_ds_data_ln_3),
        .dvalid   (int_ds_dvalid_ln_3) 
    );
//------------------------------------------------------------------
// DP Checkers Physical to Logical mapping
//------------------------------------------------------------------
// Raw serdes Lane0 --> xcvr lane0 Tx Only
// Raw serdes Lane1 --> xcvr lane0 Tx/Rx     
// Raw serdes Lane2 --> xcvr lane0 Tx/Rx     
// Raw serdes Lane3 --> xcvr lane0 Tx Only
//------------------------------------------------------------------

    // Inputs to the De-Serializer
    always @* begin
        // Simplified mapping: one-to-one lane assignment with enable control
        int_ds_enable_ln_0 = dp_lane_enable_0 ? ds_enable_ln_0 : 1'b0;
        int_ds_enable_ln_1 = dp_lane_enable_1 ? ds_enable_ln_1 : 1'b0;
        int_ds_enable_ln_2 = dp_lane_enable_2 ? ds_enable_ln_2 : 1'b0;
        int_ds_enable_ln_3 = dp_lane_enable_3 ? ds_enable_ln_3 : 1'b0;

        // TODO [Reserved for future  mapping logic]
        // if (xxx) begin
        //     ...
        // end
    end

    //------------------------------------------------------------------
    // DP Checkers Logical to Physical mapping
    // Logical TB Lanes = Physical DES Lanes
    //------------------------------------------------------------------

    // Outputs from the De-Serializer
    always @* begin
        // Simplified mapping: one-to-one lane assignment with enable control
        ds_clk_ln_0    = dp_lane_enable_0 ? int_ds_clk_ln_0    : 1'b0;
        ds_clk_ln_1    = dp_lane_enable_1 ? int_ds_clk_ln_1    : 1'b0;
        ds_clk_ln_2    = dp_lane_enable_2 ? int_ds_clk_ln_2    : 1'b0;
        ds_clk_ln_3    = dp_lane_enable_3 ? int_ds_clk_ln_3    : 1'b0;

        ds_data_ln_0   = dp_lane_enable_0 ? int_ds_data_ln_0   : 32'd0;
        ds_data_ln_1   = dp_lane_enable_1 ? int_ds_data_ln_1   : 32'd0;
        ds_data_ln_2   = dp_lane_enable_2 ? int_ds_data_ln_2   : 32'd0;
        ds_data_ln_3   = dp_lane_enable_3 ? int_ds_data_ln_3   : 32'd0;

        ds_dvalid_ln_0 = dp_lane_enable_0 ? int_ds_dvalid_ln_0 : 1'b0;
        ds_dvalid_ln_1 = dp_lane_enable_1 ? int_ds_dvalid_ln_1 : 1'b0;
        ds_dvalid_ln_2 = dp_lane_enable_2 ? int_ds_dvalid_ln_2 : 1'b0;
        ds_dvalid_ln_3 = dp_lane_enable_3 ? int_ds_dvalid_ln_3 : 1'b0;

        // TODO [Reserved for future  mapping logic]
        // if (xxx) begin
        //     ...
        // end
    end

    reg         dp0_clk       ;
    reg         dp0_rst_n     ; 
    reg         dp0_enable    ;
    reg         dp0_din_valid ;
    reg  [31:0] dp0_din       ;
    wire [31:0] dp0_dout      ;
    wire        dp0_valid     ;
    wire        dp0_locked    ;
    wire        dp0_dout_clk  ;
    decode_parallel_lock i_decode_parallel_lock0 (
        .clk       (dp0_clk      ),//input  logic       
        .rst_n     (dp0_rst_n    ),//input  logic       
        .enable    (dp0_enable   ),//input  logic       
        .din_valid (dp0_din_valid),//input  logic       
        .din       (dp0_din      ),//input  logic [31:0]
        .dout      (dp0_dout     ),//output logic [31:0]
        .valid     (dp0_valid    ),//output logic       
        .locked    (dp0_locked   )//,//output logic     
        // .dout_clk  (dp0_dout_clk ) //output logic      
    );
    assign dp0_clk       = pipe7_l00_rx_clk          ;
    assign dp0_rst_n     = pipe7_reset_n          ;
    assign dp0_enable    = 1                      ;
    assign dp0_din_valid = pipe7_l00_rx_elec_idle ;
    assign dp0_din       = {pipe7_l00_rx_data[37:30],pipe7_l00_rx_data[27:20],pipe7_l00_rx_data[17:10],pipe7_l00_rx_data[7:0]}      ;

    reg         dp1_clk       ;
    reg         dp1_rst_n     ;
    reg         dp1_enable    ;
    reg         dp1_din_valid ;
    reg  [31:0] dp1_din       ;
    wire [31:0] dp1_dout      ;
    wire        dp1_valid     ;
    wire        dp1_locked    ;
    wire        dp1_dout_clk  ;
    decode_parallel_lock i_decode_parallel_lock1 (
        .clk       (dp1_clk      ),//input  logic       
        .rst_n     (dp1_rst_n    ),//input  logic       
        .enable    (dp1_enable   ),//input  logic       
        .din_valid (dp1_din_valid),//input  logic       
        .din       (dp1_din      ),//input  logic [31:0]
        .dout      (dp1_dout     ),//output logic [31:0]
        .valid     (dp1_valid    ),//output logic       
        .locked    (dp1_locked   )//,//output logic       
        // .dout_clk  (dp1_dout_clk ) //output logic       
    );

    assign dp1_clk       = pipe7_l01_rx_clk          ;
    assign dp1_rst_n     = pipe7_reset_n          ;
    assign dp1_enable    = 1                      ;
    assign dp1_din_valid = pipe7_l01_rx_elec_idle ;
    assign dp1_din       = {pipe7_l01_rx_data[37:30],pipe7_l01_rx_data[27:20],pipe7_l01_rx_data[17:10],pipe7_l01_rx_data[7:0]}      ;

`endif