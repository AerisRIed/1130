//---------------------------------------------------------------------------
// DUT INSTANCE AND CONNECTIONS
// --------------------------------------------------------------------------
`MP_PHY_TOP_NAME cdns_usb_phy_top(

`ifdef CDNS_PHY_PWR_AWARE 

// *******************************
// Power pins
// *******************************
   .agnd                (agnd                ),     // input                        
   .avdd_clk            (avdd_clk            ),     // input                        
   .avdd_h              (avdd_h              ),     // input                        
   .avdd                (avdd                ),     // input                        
   .avdd_tx0            (avdd_tx0            ),     // input                        
   .avdd_tx1            (avdd_tx1            ),     // input                        
   .avdd_tx2            (avdd_tx2            ),     // input                        
   .avdd_tx3            (avdd_tx3            ),     // input                        
   .avdd_rx             (avdd_rx             ),     // input                        
   .cmn_aonvdd          (cmn_aonvdd          ),     // input                        

`endif // @RELEASE@

// *******************************
// External pins (bumps)
// *******************************
   .tx_p_ln_0                (tx_p_ln_0                 ),    // output                          
   .tx_m_ln_0                (tx_m_ln_0                 ),    // output                          
                                        
   .rx_p_ln_1                (rx_p_ln_1                 ),    // inout                           
   .rx_m_ln_1                (rx_m_ln_1                 ),    // inout                           
                                        
   .rx_p_ln_2                (rx_p_ln_2                 ),    // inout                           
   .rx_m_ln_2                (rx_m_ln_2                 ),    // inout                           
                                        
   .tx_p_ln_3                (tx_p_ln_3                 ),    // output                          
   .tx_m_ln_3                (tx_m_ln_3                 ),    // output                          
                                        
   .cmn_rext                 (cmn_rext                  ),     // inout                           

`ifndef MP_PHY_NO_ATB
   .pma_atb_core_0                (                ), // inout                           
   .pma_atb_core_1                (                ), // inout                           
`endif

// *******************************
// External SRAM interface for uC
// *******************************
//   .sram_clk_top                 (sram_clk_top    ),  // output                           
//   .sram_ceb_top                 (sram_ceb_top    ),  // output                           
//   .sram_web_top                 (sram_web_top    ),  // output                           
//   .sram_bweb_top                (sram_bweb_top   ),  // output [3:0]                     
//   .sram_addr_top                (sram_addr_top   ),  // output [`SRAM_DEPTH:0]           
//   .sram_wr_data_top             (sram_wr_data_top),  // output [`SRAM_WIDTH:0]           
//   .sram_rd_data_top             (sram_rd_data_top),  // input  [`SRAM_WIDTH:0]           
//`ifdef CDN_UCTLR_DUAL_PORT_RAM                        
//   .iram_addr_top                (iram_addr_top   ),  // output [`SRAM_DEPTH:0]          
//   .iram_rd_data_top             (iram_rd_data_top),  // input  [`SRAM_WIDTH:0]          
//   .iram_ceb_top                 (iram_ceb_top    ),  // output                          
//   .iram_web_top                 (iram_web_top    ),  // output                          
//   .iram_wr_data_top             (iram_wr_data_top),  // output [`SRAM_WIDTH:0]          
//`endif                                                
//   .sram_pwrdwn_top              (sram_pwrdwn_top ),  // output                          
//
//`ifndef CDN_MPPHY_LANE_UC_RMV
//
//   .sram_clk_ln_01                (sram_clk_ln_00    ),  // output                          
//   .sram_ceb_ln_01                (sram_ceb_ln_00    ),  // output                          
//   .sram_web_ln_01                (sram_web_ln_00    ),  // output                          
//   .sram_bweb_ln_01               (sram_bweb_ln_00   ),  // output [3:0]                    
//   .sram_addr_ln_01               (sram_addr_ln_00   ),  // output [`SRAM_DEPTH:0]          
//   .sram_wr_data_ln_01            (sram_wr_data_ln_00),  // output [`SRAM_WIDTH:0]          
//   .sram_rd_data_ln_01            (sram_rd_data_ln_00),  // input  [`SRAM_WIDTH:0]          
//`ifdef CDN_UCTLR_DUAL_PORT_RAM                        
//   .iram_addr_ln_01               (iram_addr_ln_00   ),  // output [`SRAM_DEPTH:0]          
//   .iram_rd_data_ln_01            (iram_rd_data_ln_00),  // input  [`SRAM_WIDTH:0]          
//   .iram_ceb_ln_01                (iram_ceb_ln_00    ),  // output                          
//   .iram_web_ln_01                (iram_web_ln_00    ),  // output                          
//   .iram_wr_data_ln_01            (iram_wr_data_ln_00),  // output [`SRAM_WIDTH:0]          
//`endif                                                
//   .sram_pwrdwn_ln_01             (sram_pwrdwn_ln_00 ),  // output                          
//                        
//   .sram_clk_ln_23                (sram_clk_ln_01    ),  // output                          
//   .sram_ceb_ln_23                (sram_ceb_ln_01    ),  // output                          
//   .sram_web_ln_23                (sram_web_ln_01    ),  // output                          
//   .sram_bweb_ln_23               (sram_bweb_ln_01   ),  // output [3:0]                    
//   .sram_addr_ln_23               (sram_addr_ln_01   ),  // output [`SRAM_DEPTH:0]          
//   .sram_wr_data_ln_23            (sram_wr_data_ln_01),  // output [`SRAM_WIDTH:0]          
//   .sram_rd_data_ln_23            (sram_rd_data_ln_01),  // input  [`SRAM_WIDTH:0]          
//`ifdef CDN_UCTLR_DUAL_PORT_RAM                          
//   .iram_addr_ln_23               (iram_addr_ln_01   ),  // output [`SRAM_DEPTH:0]          
//   .iram_rd_data_ln_23            (iram_rd_data_ln_01),  // input  [`SRAM_WIDTH:0]          
//   .iram_ceb_ln_23                (iram_ceb_ln_01    ),  // output                          
//   .iram_web_ln_23                (iram_web_ln_01    ),  // output                          
//   .iram_wr_data_ln_23            (iram_wr_data_ln_01),  // output [`SRAM_WIDTH:0]          
//`endif                                                  
//   .sram_pwrdwn_ln_23             (sram_pwrdwn_ln_01 ),  // output                          
//
//`endif
.*,
// *******************************
// External APB target interface
// *******************************
   .apb_pclk                      (apb_pclk                    ),  // input                           
   .apb_preset_n                  (apb_rst_n                   ),  // input                           
   .apb_tgt_penable               (apb_penable                 ),  // input                           
   .apb_tgt_psel                  (apb_psel                    ),  // input                           
   .apb_tgt_pwrite                (apb_pwrite                  ),  // input                           
   .apb_tgt_paddr                 (apb_paddr                   ),  // input  [17:0]                   
   .apb_tgt_pwdata                (apb_pwdata                  ),  // input  [31:0]                   
   .apb_tgt_prdata                (apb_prdata                  ),  // output [31:0]                   
   .apb_tgt_pready                (apb_pready                  ),  // output                          
   .apb_tgt_perr                  (apb_pslverr                 ),  // output                          

// *******************************
// External APB master interface
// *******************************
   .apb_mstr_penable              (                ),  // output                          
   .apb_mstr_psel                 (                ),  // output                          
   .apb_mstr_pwrite               (                ),  // output                          
   .apb_mstr_paddr                (                ),  // output [31:0]                   
   .apb_mstr_pwdata               (                ),  // output [31:0]                   
   .apb_mstr_prdata               (  'h0           ),  // input  [31:0]                   
   .apb_mstr_pready               (  'h0           ),  // input                           
   .apb_mstr_perr                 (  'h0           ),  // input                           

// *******************************
// uC related interface
// *******************************
//TODO: Double confirm: if we need uc_clk_ext feature. What's the purpose of this?
   .uc_clk                        (uc_clk                     ),  // input                           
   .uc_reset_n                    (uc_reset_n                 ),  // input                           
                          
   .phy_uc_init_complete          (phy_uc_init_complete       ),  // output                          
   .phy_error_interrupt           (                ),  // output                          

// *******************************
// PHY interface
// *******************************
   .phy_reset_n                   (phy_reset_n                ),  // input                           
   .typec_conn_dir                (typec_conn_dir  ),  // input                           
   .phy_interrupt_usb             (                ),  // output                          
   .phy_interrupt_dp              (                ),  // output                          
                                                      
   .phy_mode                      (phy_mode                   ),  // input  [3:0]                    
   .pipe_32bit_en                 (pipe_32bit_en              ),  // input                      
                                                      
   .phy_l00_ctlr_interrupt_in     ( 'h0            ),  // input                           
   .phy_l01_ctlr_interrupt_in     ( 'h0            ),  // input                           

// *******************************
// Original PIPE interface
// For USB3 or PCIe1/2/3/4
// *******************************
   .pipe4_clk                     (pipe4_clk                       ),  // output                          
   .pipe4_reset_n                 (pipe4_reset_n                   ),  // input                           
   .pipe4_rate                    (pipe4_rate                      ),  // input                           
   .pipe4_powerdown               (pipe4_powerdown                 ),  // input  [1:0]                    
   .pipe4_eb_mode                 (pipe4_eb_mode                   ),  // input                           
//input                            pipe4_width, //Reserved for 16-bit data width.

// *******************************
// Original PIPE - Lane0 Signals
// *******************************
   .pipe4_l00_phy_status          (pipe4_l00_phy_status                      ),  // output                          
   .pipe4_l00_rx_data             (pipe4_l00_rx_data                         ),  // output [31:0]                   
   .pipe4_l00_rx_data_k           (pipe4_l00_rx_data_k                       ),  // output [3:0]                    
   .pipe4_l00_rx_sync_header      (pipe4_l00_rx_sync_header                  ),  // output [3:0]                    
   .pipe4_l00_rx_start_block      (pipe4_l00_rx_start_block                  ),  // output                          
   .pipe4_l00_rx_data_valid       (pipe4_l00_rx_data_valid                   ),  // output                          
   .pipe4_l00_rx_valid            (pipe4_l00_rx_valid                        ),  // output                          
   .pipe4_l00_rx_status           (pipe4_l00_rx_status                       ),  // output [2:0]                    
   .pipe4_l00_rx_elec_idle        (pipe4_l00_rx_elec_idle                    ),  // output                          
                                                                                
   .pipe4_l00_rx_polarity         (pipe4_l00_rx_polarity                     ),  // input                           
   .pipe4_l00_rx_termination      (pipe4_l00_rx_termination                  ),  // input                           
   .pipe4_l00_rx_eq_training      (pipe4_l00_rx_eq_training                  ),  // input                           
                                                                                
   .pipe4_l00_tx_data             (pipe4_l00_tx_data                         ),  // input  [31:0]                   
   .pipe4_l00_tx_data_k           (pipe4_l00_tx_data_k                       ),  // input  [3:0]                    
   .pipe4_l00_tx_sync_header      (pipe4_l00_tx_sync_header                  ),  // input  [3:0]                    
   .pipe4_l00_tx_start_block      (pipe4_l00_tx_start_block                  ),  // input                           
   .pipe4_l00_tx_data_valid       (pipe4_l00_tx_data_valid                   ),  // input                           
   .pipe4_l00_tx_det_rx_lpbk      (pipe4_l00_tx_det_rx_lpbk                  ),  // input                           
   .pipe4_l00_tx_elec_idle        (pipe4_l00_tx_elec_idle                    ),  // input                           
   .pipe4_l00_tx_ones_zeros       (pipe4_l00_tx_ones_zeros                   ),  // input                           
   .pipe4_l00_tx_128b_enc_byp     (pipe4_l00_tx_128b_enc_byp                 ),  // input                           
   .pipe4_l00_tx_deemph           (pipe4_l00_tx_deemph                       ),  // input  [1:0]                    

// *******************************
// Original PIPE - Lane1 Signals
// *******************************
   .pipe4_l01_phy_status          (pipe4_l01_phy_status                      ),  // output                          
   .pipe4_l01_rx_data             (pipe4_l01_rx_data                         ),  // output [31:0]                   
   .pipe4_l01_rx_data_k           (pipe4_l01_rx_data_k                       ),  // output [3:0]                    
   .pipe4_l01_rx_sync_header      (pipe4_l01_rx_sync_header                  ),  // output [3:0]                    
   .pipe4_l01_rx_start_block      (pipe4_l01_rx_start_block                  ),  // output                          
   .pipe4_l01_rx_data_valid       (pipe4_l01_rx_data_valid                   ),  // output                          
   .pipe4_l01_rx_valid            (pipe4_l01_rx_valid                        ),  // output                          
   .pipe4_l01_rx_status           (pipe4_l01_rx_status                       ),  // output [2:0]                    
   .pipe4_l01_rx_elec_idle        (pipe4_l01_rx_elec_idle                    ),  // output                          
                                                                                
   .pipe4_l01_rx_polarity         (pipe4_l01_rx_polarity                     ),  // input                           
   .pipe4_l01_rx_termination      (pipe4_l01_rx_termination                  ),  // input                           
   .pipe4_l01_rx_eq_training      (pipe4_l01_rx_eq_training                  ),  // input                           
                                                                                
   .pipe4_l01_tx_data             (pipe4_l01_tx_data                         ),  // input  [31:0]                   
   .pipe4_l01_tx_data_k           (pipe4_l01_tx_data_k                       ),  // input  [3:0]                    
   .pipe4_l01_tx_sync_header      (pipe4_l01_tx_sync_header                  ),  // input  [3:0]                    
   .pipe4_l01_tx_start_block      (pipe4_l01_tx_start_block                  ),  // input                           
   .pipe4_l01_tx_data_valid       (pipe4_l01_tx_data_valid                   ),  // input                           
   .pipe4_l01_tx_det_rx_lpbk      (pipe4_l01_tx_det_rx_lpbk                  ),  // input                           
   .pipe4_l01_tx_elec_idle        (pipe4_l01_tx_elec_idle                    ),  // input                           
   .pipe4_l01_tx_ones_zeros       (pipe4_l01_tx_ones_zeros                   ),  // input                           
   .pipe4_l01_tx_128b_enc_byp     (pipe4_l01_tx_128b_enc_byp                 ),  // input                           
   .pipe4_l01_tx_deemph           (pipe4_l01_tx_deemph                       ),  // input  [1:0]                    

// *******************************
// Serdes PIPE interface
// For USB4
// *******************************
   .pipe7_clk_max                 (pipe7_clk_max                     ),  // output                          
   .pipe7_clk_max_req             (pipe7_clk_max_req                 ),  // input                           
   .pipe7_clk_max_ack             (pipe7_clk_max_ack                 ),  // output                          
                                                     
   .pipe7_pll0_en                 (pipe7_pll0_en                     ),  // input     For USB4 Serdes Arch only
   .pipe7_pll0_ok                 (pipe7_pll0_ok                     ),  // output    For USB4 Serdes Arch only
                                                     
   .pipe7_reset_n                 (pipe7_reset_n                     ),  // input                           
//input  [1:0]                     pipe7_tx_width, // Support 40bit only
//input  [1:0]                     pipe7_rx_width, // Support 40bit only

// *******************************
// Serdes PIPE - Lane0 Signals
// *******************************
   .pipe7_l00_clk                 (pipe7_l00_clk                               ),  // input                           
   .pipe7_l00_rate                (pipe7_l00_rate                              ),  // input  [1:0]                    
                                                                                  
   .pipe7_l00_phy_status          (pipe7_l00_phy_status                        ),  // output                          
   .pipe7_l00_rx_clk              (pipe7_l00_rx_clk                            ),  // output                          
   .pipe7_l00_rx_data             (pipe7_l00_rx_data                           ),  // output [39:0]                   
   .pipe7_l00_rx_valid            (pipe7_l00_rx_valid                          ),  // output                          
   .pipe7_l00_rx_standby_status   (pipe7_l00_rx_standby_status                 ),  // output                          
   .pipe7_l00_rx_elec_idle        (pipe7_l00_rx_elec_idle                      ),  // output                          
                                                                                  
   .pipe7_l00_rx_termination      (pipe7_l00_rx_termination                    ),  // input                           
   .pipe7_l00_rx_standby          (pipe7_l00_rx_standby                        ),  // input                           
                                                                                  
   .pipe7_l00_powerdown           (pipe7_l00_powerdown                         ),  // input  [2:0]                    
   .pipe7_l00_tx_data             (pipe7_l00_tx_data                           ),  // input  [39:0]                   
   .pipe7_l00_tx_data_valid       (pipe7_l00_tx_data_valid                     ),  // input                           
   .pipe7_l00_tx_det_rx_lpbk      (pipe7_l00_tx_det_rx_lpbk                    ),  // input                           
   .pipe7_l00_tx_elec_idle        (pipe7_l00_tx_elec_idle                      ),  // input                           
                                                                                  
   .pipe7_l00_m2p_messagebus      (pipe7_l00_m2p_messagebus                    ),  // input  [7:0]                    
   .pipe7_l00_p2m_messagebus      (pipe7_l00_p2m_messagebus                    ),  // output [7:0]                    

//TODO
//input         pipe_l00_rx_elec_idle_det_dis,

// *******************************
// Serdes PIPE - Lane1 Signals
// *******************************
   .pipe7_l01_clk                 (pipe7_l01_clk                               ),  // input                           
   .pipe7_l01_rate                (pipe7_l01_rate                              ),  // input  [1:0]                    
                                                                                  
   .pipe7_l01_phy_status          (pipe7_l01_phy_status                        ),  // output                          
   .pipe7_l01_rx_clk              (pipe7_l01_rx_clk                            ),  // output                          
   .pipe7_l01_rx_data             (pipe7_l01_rx_data                           ),  // output [39:0]                   
   .pipe7_l01_rx_valid            (pipe7_l01_rx_valid                          ),  // output                          
   .pipe7_l01_rx_standby_status   (pipe7_l01_rx_standby_status                 ),  // output                          
   .pipe7_l01_rx_elec_idle        (pipe7_l01_rx_elec_idle                      ),  // output                          
                                                                                  
   .pipe7_l01_rx_termination      (pipe7_l01_rx_termination                    ),  // input                           
   .pipe7_l01_rx_standby          (pipe7_l01_rx_standby                        ),  // input                           
                                                                                  
   .pipe7_l01_powerdown           (pipe7_l01_powerdown                         ),  // input  [2:0]                    
   .pipe7_l01_tx_data             (pipe7_l01_tx_data                           ),  // input  [39:0]                   
   .pipe7_l01_tx_data_valid       (pipe7_l01_tx_data_valid                     ),  // input                           
   .pipe7_l01_tx_det_rx_lpbk      (pipe7_l01_tx_det_rx_lpbk                    ),  // input                           
   .pipe7_l01_tx_elec_idle        (pipe7_l01_tx_elec_idle                      ),  // input                           
                                                                                 
   .pipe7_l01_m2p_messagebus      (pipe7_l01_m2p_messagebus                    ),  // input  [7:0]                    
   .pipe7_l01_p2m_messagebus      (pipe7_l01_p2m_messagebus                    ),  // output [7:0]                    

// *******************************
// Raw interface - Link Signals
// *******************************
   .pma_cmn_ready                (pma_cmn_ready                            ),  // output                          
   .pma_xcvr_pllclk_en_ack       (pma_xcvr_pllclk_en_ack                   ),  // output                          
   .pma_xcvr_power_state_ack     (pma_xcvr_power_state_ack                 ),  // output [5:0]                    
   .pma_cmn_avdd_pwrgood         (pma_cmn_avdd_pwrgood                     ),  // output                          
                                                                              
   .pma_xcvr_pllclk_en           (pma_xcvr_pllclk_en                       ),  // input                           
   .pma_xcvr_power_state_req     (pma_xcvr_power_state_req                 ),  // input  [5:0]                    
   .pma_xcvr_data_width          (pma_xcvr_data_width                      ),  // input  [2:0]                    
                                                                              
   .dp_reset_n                   (dp_reset_n                               ),  // input                           
   .pma_tx_td_clk                (pma_tx_td_clk                            ),  // input                           
                                                           
   .pma_tx_lfps_en               (pma_tx_lfps_en                           ),  // input  //New added for Mac to transmit LFPS
   .pma_tx_lfps_mode             (pma_tx_lfps_mode                         ),  // input  //New added for Mac to transmit LFPS


// *******************************
// Raw interface - Lane0 Signals
// *******************************
   .pma_tx_elec_idle_ln_0         (pma_tx_elec_idle_ln_0                 ),  // input                           
   .pma_tx_td_ln_0                (pma_tx_td_ln_0                        ),  // input  [31:0]                   

// *******************************
// Raw interface - Lane1 Signals
// *******************************
   .pma_tx_elec_idle_ln_1         (pma_tx_elec_idle_ln_1                 ),  // input                           
   .pma_tx_td_ln_1                (pma_tx_td_ln_1                        ),  // input  [31:0]                   

// *******************************
// Raw interface - Lane2 Signals
// *******************************
   .pma_tx_elec_idle_ln_2         (pma_tx_elec_idle_ln_2                 ),  // input                           
   .pma_tx_td_ln_2                (pma_tx_td_ln_2                        ),  // input  [31:0]                   

// *******************************
// Raw interface - Lane3 Signals
// *******************************
   .pma_tx_elec_idle_ln_3         (pma_tx_elec_idle_ln_3                 ),  // input                           
   .pma_tx_td_ln_3                (pma_tx_td_ln_3                        ),  // input  [31:0]                   

// *******************************
// PHY/PMA Interface & PMA Clocks
// *******************************
// External reference clock active detection
//input       pma_cmn_ext_refclk0_detected_en,
//output      pma_cmn_ext_refclk0_detected,
//output      pma_cmn_ext_refclk0_detected_valid,
//input       pma_cmn_ext_refclk1_detected_en,
//output      pma_cmn_ext_refclk1_detected,
//output      pma_cmn_ext_refclk1_detected_valid,

   .usb_datart_clk                (                ),  // output                          
   .usb_fullrt_clk                (                ),  // output                          
   .dp_datart_clk                 (                ),  // output                          
   .dp_fullrt_clk                 (                ),  // output                          
                            
   .pma_cmn_refclk0_int           (ref_clk0                 ),  // input                           
   .pma_cmn_refclk1_int           (ref_clk1                 ),  // input                           
   .pma_cmn_refclk_dig_div        (pma_cmn_refclk_dig_div                  ),  // input  [1:0]                    
   .pma_cmn_refclk_dig_sel        (pma_cmn_refclk_dig_sel                  ),  // input                           
   .pma_cmn_pll0_refclk_sel       (pma_cmn_pll0_refclk_sel                 ),  // input  [1:0]                    
   .pma_cmn_pll1_refclk_sel       (pma_cmn_pll1_refclk_sel                 ),  // input  [1:0]                    

// *******************************
// Digital Test Bus
// *******************************
`ifndef CDN_MPPHY_RMV_DTB // @RELEASE@
   .dtb_data                      (                ),  // output [31:0]                   
   .dtb_clk                       (                ),  // output                          
`endif // @RELEASE@

// *******************************
// TAP interface
// *******************************
   .tap_tck                       ( 'h0 ),//phy_jtag_tck                    ),  // input                           
   .tap_tms                       ( 'h0 ),//phy_jtag_tms                    ),  // input                           
   .tap_trst_n                    ( 'h0 ),//phy_jtag_trst                   ),  // input                           
   .tap_tdi                       ( 'h0 ),//phy_jtag_tdi                    ),  // input                           
   .tap_tdo                       (phy_jtag_tdo                    ),  // output                          
   .tap_tdoen                     (phy_jtag_tdo_oe                 ),  // output                          

`ifdef CDN_TESTCHIP_UC_DBGR
//uC debugger Tap interfaces
   .uc_top_tap_tck                (                ),  // input                           
   .uc_top_tap_tms                (                ),  // input                           
   .uc_top_tap_trst_n             (                ),  // input                           
   .uc_top_tap_tdi                (                ),  // input                           
   .uc_top_tap_tdo                (                ),  // output                          
   .uc_top_tap_tdoen              (                ),  // output                          

`ifndef CDN_MPPHY_LANE_UC_RMV
   .uc_l01_tap_tck                (                ),  // input                           
   .uc_l01_tap_tms                (                ),  // input                           
   .uc_l01_tap_trst_n             (                ),  // input                           
   .uc_l01_tap_tdi                (                ),  // input                           
   .uc_l01_tap_tdo                (                ),  // output                          
   .uc_l01_tap_tdoen              (                ),  // output                          

   .uc_l23_tap_tck                (                ),  // input                           
   .uc_l23_tap_tms                (                ),  // input                           
   .uc_l23_tap_trst_n             (                ),  // input                           
   .uc_l23_tap_tdi                (                ),  // input                           
   .uc_l23_tap_tdo                (                ),  // output                          
   .uc_l23_tap_tdoen              (                ),  // output                          
`endif

`endif

// *******************************
// IEEE1687 interface
// *******************************

   .ieee1687_interface_en         ( 'h0 ),//host_1687_en                       ),  // input                           
   .ieee1687_so                   (jtag_tdo_1687                      ),  // output                          
   .ieee1687_si                   ( 'h0 ),//jtag_clockdr_1687                  ),  // input                           
   .ieee1687_capture_en           ( 'h0 ),//jtag_shiftdr_1687                  ),  // input                           
   .ieee1687_shift_en             ( 'h0 ),//jtag_updatedr_1687                 ),  // input                           
   .ieee1687_update_en            ( 'h0 ),//jtag_capture_1687                  ),  // input                           
   .ieee1687_sel                  (1'b0                               ),  // input                           
   .ieee1687_rstn                 (1'b0                               ),  // input                           
   .ieee1687_tck                  (1'b0 ),//phy_jtag_tck                       ),  // input                           

// *******************************
// Digital scan interface
// *******************************
   .iddq_en                           ( 'h0            ),  // input                           
                                                         
   .scanmode                          ( 'h0            ),  // input                           
   .scanen                            ( 'h0            ),  // input                           
   .scanen_cg                         ( 'h0            ),  // input                           
   .cmn_scan_pll_ats                  ( 'h0            ),  // input                           
   .cmn_scanclk_pll0_prog0_ats_out    (                ),  // output                          
   .cmn_scanclk_pll0_prog1_ats_out    (                ),  // output                          
   .cmn_scanclk_pll1_prog0_ats_out    (                ),  // output                          
   .cmn_scanclk_pll1_prog1_ats_out    (                ),  // output                          
   .cmn_scanclk_psmclk                (                ),  // input                           
   .cmn_scanclk_refclk                (                ),  // input                           
   .cmn_scanclk_serclk                (                ),  // input                           
   .cmn_scanclk_pllclk                (                ),  // input                           
   .scanclk_pipeclk                   (                ),  // input                           

// *******************************
// PHY soft scan chains
// *******************************
   .phy_scanin                        (                ),  // input   `PHY_SCAN_IN_WIDTH      
   .phy_scanout                       (                ),  // output  `PHY_SCAN_OUT_WIDTH     

// *******************************
// PMA Scan chains.
// *******************************
   .pma_cmn_scanin                    (                ),  // input   `PMA_CMN_SCAN_IN_WIDTH  
   .pma_cmn_scanout                   (                ),  // output  `PMA_CMN_SCAN_OUT_WIDTH 
                                                          
   .xcvr_scanclk_serclk_ln_0          (                ),  // input                           
   .xcvr_scanclk_pllclk_ln_0          (                ),  // input                           
   .pma_xcvr_scanin_ln_0              (                ),  // input   `PMA_XCVR_SCAN_IN_WIDTH 
   .pma_xcvr_scanout_ln_0             (                ),  // output  `PMA_XCVR_SCAN_OUT_WIDTH
                                                          
   .xcvr_scanclk_serclk_ln_1          (                ),  // input                           
   .xcvr_scanclk_pllclk_ln_1          (                ),  // input                           
   .pma_xcvr_scanin_ln_1              (                ),  // input   `PMA_XCVR_SCAN_IN_WIDTH 
   .pma_xcvr_scanout_ln_1             (                ),  // output  `PMA_XCVR_SCAN_OUT_WIDTH
                                                          
   .xcvr_scanclk_serclk_ln_2          (                ),  // input                           
   .xcvr_scanclk_pllclk_ln_2          (                ),  // input                           
   .pma_xcvr_scanin_ln_2              (                ),  // input   `PMA_XCVR_SCAN_IN_WIDTH 
   .pma_xcvr_scanout_ln_2             (                ),  // output  `PMA_XCVR_SCAN_OUT_WIDTH
                                                          
   .xcvr_scanclk_serclk_ln_3          (                ),  // input                           
   .xcvr_scanclk_pllclk_ln_3          (                ),  // input                           
   .pma_xcvr_scanin_ln_3              (                ),  // input   `PMA_XCVR_SCAN_IN_WIDTH 
   .pma_xcvr_scanout_ln_3             (                ),  // output  `PMA_XCVR_SCAN_OUT_WIDTH

// *****************************************
// External Boundary Scan Control Interface
// *****************************************
   .bscan_ext_select                  ( 'h0            ),  // input                           
   .bscan_ext_shiftdr                 ( 'h0            ),  // input                           
   .bscan_ext_clockdr                 (                ),  // input                           
   .tx_bscan_ext_updatedr             (                ),  // input                           
   .tx_bscan_ext_mode_c               ( 'h0            ),  // input                           
   .tx_bscan_ext_ac                   ( 'h0            ),  // input                           
   .tx_bscan_ext_acpulse              (                ),  // input                           
   .tx_bscan_ext_tdo                  (                ),  // output                          
   .rx_bscan_ext_pc                   (                ),  // input                           
   .rx_bscan_ext_ac                   ( 'h0            ),  // input                           
   .rx_bscan_ext_tdi                  (                ),  // input                           

// *****************************************
// Internal Boundary Scan Control Interface
// *****************************************
   .xcvr_bscan_mode_en                ( 'h0            )   // input                           

);


`ifdef B2B_MODE
//------------------------------------------------------------------------
// B2B PHY DEVICE
//------------------------------------------------------------------------
`MP_PHY_TOP_NAME cdns_usb_phy_top_device(

`ifdef CDNS_PHY_PWR_AWARE 

// *******************************
// Power pins
// *******************************
   .agnd                (device_agnd                ),     // input                        
   .avdd_clk            (device_avdd_clk            ),     // input                        
   .avdd_h              (device_avdd_h              ),     // input                        
   .avdd                (device_avdd                ),     // input                        
   .avdd_tx0            (device_avdd_tx0            ),     // input                        
   .avdd_tx1            (device_avdd_tx1            ),     // input                        
   .avdd_tx2            (device_avdd_tx2            ),     // input                        
   .avdd_tx3            (device_avdd_tx3            ),     // input                        
   .avdd_rx             (device_avdd_rx             ),     // input                        
   .cmn_aonvdd          (device_cmn_aonvdd          ),     // input                        

`endif // @RELEASE@

// *******************************
// External pins (bumps)
// *******************************
   .tx_p_ln_0                (device_tx_p_ln_0                 ),    // output                          
   .tx_m_ln_0                (device_tx_m_ln_0                 ),    // output                          
                                        
   .rx_p_ln_1                (device_rx_p_ln_1                 ),    // inout                           
   .rx_m_ln_1                (device_rx_m_ln_1                 ),    // inout                           
                                        
   .rx_p_ln_2                (device_rx_p_ln_2                 ),    // inout                           
   .rx_m_ln_2                (device_rx_m_ln_2                 ),    // inout                           
                                        
   .tx_p_ln_3                (device_tx_p_ln_3                 ),    // output                          
   .tx_m_ln_3                (device_tx_m_ln_3                 ),    // output                          
                                        
   .cmn_rext                 (device_cmn_rext                  ),     // inout                           

`ifndef MP_PHY_NO_ATB
   .pma_atb_core_0                (                ), // inout                           
   .pma_atb_core_1                (                ), // inout                           
`endif

// *******************************
// External SRAM interface for uC
// *******************************
//   .sram_clk_top                 (sram_clk_top    ),  // output                           
//   .sram_ceb_top                 (sram_ceb_top    ),  // output                           
//   .sram_web_top                 (sram_web_top    ),  // output                           
//   .sram_bweb_top                (sram_bweb_top   ),  // output [3:0]                     
//   .sram_addr_top                (sram_addr_top   ),  // output [`SRAM_DEPTH:0]           
//   .sram_wr_data_top             (sram_wr_data_top),  // output [`SRAM_WIDTH:0]           
//   .sram_rd_data_top             (sram_rd_data_top),  // input  [`SRAM_WIDTH:0]           
//`ifdef CDN_UCTLR_DUAL_PORT_RAM                        
//   .iram_addr_top                (iram_addr_top   ),  // output [`SRAM_DEPTH:0]          
//   .iram_rd_data_top             (iram_rd_data_top),  // input  [`SRAM_WIDTH:0]          
//   .iram_ceb_top                 (iram_ceb_top    ),  // output                          
//   .iram_web_top                 (iram_web_top    ),  // output                          
//   .iram_wr_data_top             (iram_wr_data_top),  // output [`SRAM_WIDTH:0]          
//`endif                                                
//   .sram_pwrdwn_top              (sram_pwrdwn_top ),  // output                          
//
//`ifndef CDN_MPPHY_LANE_UC_RMV
//
//   .sram_clk_ln_01                (sram_clk_ln_00    ),  // output                          
//   .sram_ceb_ln_01                (sram_ceb_ln_00    ),  // output                          
//   .sram_web_ln_01                (sram_web_ln_00    ),  // output                          
//   .sram_bweb_ln_01               (sram_bweb_ln_00   ),  // output [3:0]                    
//   .sram_addr_ln_01               (sram_addr_ln_00   ),  // output [`SRAM_DEPTH:0]          
//   .sram_wr_data_ln_01            (sram_wr_data_ln_00),  // output [`SRAM_WIDTH:0]          
//   .sram_rd_data_ln_01            (sram_rd_data_ln_00),  // input  [`SRAM_WIDTH:0]          
//`ifdef CDN_UCTLR_DUAL_PORT_RAM                        
//   .iram_addr_ln_01               (iram_addr_ln_00   ),  // output [`SRAM_DEPTH:0]          
//   .iram_rd_data_ln_01            (iram_rd_data_ln_00),  // input  [`SRAM_WIDTH:0]          
//   .iram_ceb_ln_01                (iram_ceb_ln_00    ),  // output                          
//   .iram_web_ln_01                (iram_web_ln_00    ),  // output                          
//   .iram_wr_data_ln_01            (iram_wr_data_ln_00),  // output [`SRAM_WIDTH:0]          
//`endif                                                
//   .sram_pwrdwn_ln_01             (sram_pwrdwn_ln_00 ),  // output                          
//                        
//   .sram_clk_ln_23                (sram_clk_ln_01    ),  // output                          
//   .sram_ceb_ln_23                (sram_ceb_ln_01    ),  // output                          
//   .sram_web_ln_23                (sram_web_ln_01    ),  // output                          
//   .sram_bweb_ln_23               (sram_bweb_ln_01   ),  // output [3:0]                    
//   .sram_addr_ln_23               (sram_addr_ln_01   ),  // output [`SRAM_DEPTH:0]          
//   .sram_wr_data_ln_23            (sram_wr_data_ln_01),  // output [`SRAM_WIDTH:0]          
//   .sram_rd_data_ln_23            (sram_rd_data_ln_01),  // input  [`SRAM_WIDTH:0]          
//`ifdef CDN_UCTLR_DUAL_PORT_RAM                          
//   .iram_addr_ln_23               (iram_addr_ln_01   ),  // output [`SRAM_DEPTH:0]          
//   .iram_rd_data_ln_23            (iram_rd_data_ln_01),  // input  [`SRAM_WIDTH:0]          
//   .iram_ceb_ln_23                (iram_ceb_ln_01    ),  // output                          
//   .iram_web_ln_23                (iram_web_ln_01    ),  // output                          
//   .iram_wr_data_ln_23            (iram_wr_data_ln_01),  // output [`SRAM_WIDTH:0]          
//`endif                                                  
//   .sram_pwrdwn_ln_23             (sram_pwrdwn_ln_01 ),  // output                          
//
//`endif
.*,
// *******************************
// External APB target interface
// *******************************
   .apb_pclk                      (apb_pclk_device                    ),  // input                           
   .apb_preset_n                  (apb_rst_n_device                   ),  // input                           
   .apb_tgt_penable               (apb_penable_device                 ),  // input                           
   .apb_tgt_psel                  (apb_psel_device                    ),  // input                           
   .apb_tgt_pwrite                (apb_pwrite_device                  ),  // input                           
   .apb_tgt_paddr                 (apb_paddr_device                   ),  // input  [17:0]                   
   .apb_tgt_pwdata                (apb_pwdata_device                  ),  // input  [31:0]                   
   .apb_tgt_prdata                (apb_prdata_device                  ),  // output [31:0]                   
   .apb_tgt_pready                (apb_pready_device                  ),  // output                          
   .apb_tgt_perr                  (apb_pslverr_device                 ),  // output                          

// *******************************
// External APB master interface
// *******************************
   .apb_mstr_penable              (                ),  // output                          
   .apb_mstr_psel                 (                ),  // output                          
   .apb_mstr_pwrite               (                ),  // output                          
   .apb_mstr_paddr                (                ),  // output [31:0]                   
   .apb_mstr_pwdata               (                ),  // output [31:0]                   
   .apb_mstr_prdata               (  'h0           ),  // input  [31:0]                   
   .apb_mstr_pready               (  'h0           ),  // input                           
   .apb_mstr_perr                 (  'h0           ),  // input                           

// *******************************
// uC related interface
// *******************************
//TODO: Double confirm: if we need uc_clk_ext feature. What's the purpose of this?
   .uc_clk                        (uc_clk_device                     ),  // input                           
   .uc_reset_n                    (uc_reset_n_device                 ),  // input                           
                          
   .phy_uc_init_complete          (device_phy_uc_init_complete       ),  // output                          
   .phy_error_interrupt           (                ),  // output                          

// *******************************
// PHY interface
// *******************************
   .phy_reset_n                   (device_phy_reset_n                ),  // input                           
   .typec_conn_dir                (device_typec_conn_dir  ),  // input                           
   .phy_interrupt_usb             (                ),  // output                          
   .phy_interrupt_dp              (                ),  // output                          
                                                      
   .phy_mode                      (device_phy_mode                   ),  // input  [3:0]                    
   .pipe_32bit_en                 (device_pipe_32bit_en              ),  // input                      
                                                      
   .phy_l00_ctlr_interrupt_in     ( 'h0            ),  // input                           
   .phy_l01_ctlr_interrupt_in     ( 'h0            ),  // input                           

// *******************************
// Original PIPE interface
// For USB3 or PCIe1/2/3/4
// *******************************
   .pipe4_clk                     (device_pipe4_clk                       ),  // output                          
   .pipe4_reset_n                 (device_pipe4_reset_n                   ),  // input                           
   .pipe4_rate                    (device_pipe4_rate                      ),  // input                           
   .pipe4_powerdown               (device_pipe4_powerdown                 ),  // input  [1:0]                    
   .pipe4_eb_mode                 (device_pipe4_eb_mode                   ),  // input                           
//input                            pipe4_width, //Reserved for 16-bit data width.

// *******************************
// Original PIPE - Lane0 Signals
// *******************************
   .pipe4_l00_phy_status          (device_pipe4_l00_phy_status                      ),  // output                          
   .pipe4_l00_rx_data             (device_pipe4_l00_rx_data                         ),  // output [31:0]                   
   .pipe4_l00_rx_data_k           (device_pipe4_l00_rx_data_k                       ),  // output [3:0]                    
   .pipe4_l00_rx_sync_header      (device_pipe4_l00_rx_sync_header                  ),  // output [3:0]                    
   .pipe4_l00_rx_start_block      (device_pipe4_l00_rx_start_block                  ),  // output                          
   .pipe4_l00_rx_data_valid       (device_pipe4_l00_rx_data_valid                   ),  // output                          
   .pipe4_l00_rx_valid            (device_pipe4_l00_rx_valid                        ),  // output                          
   .pipe4_l00_rx_status           (device_pipe4_l00_rx_status                       ),  // output [2:0]                    
   .pipe4_l00_rx_elec_idle        (device_pipe4_l00_rx_elec_idle                    ),  // output                          
                                                                                
   .pipe4_l00_rx_polarity         (device_pipe4_l00_rx_polarity                     ),  // input                           
   .pipe4_l00_rx_termination      (device_pipe4_l00_rx_termination                  ),  // input                           
   .pipe4_l00_rx_eq_training      (device_pipe4_l00_rx_eq_training                  ),  // input                           
                                                                                
   .pipe4_l00_tx_data             (device_pipe4_l00_tx_data                         ),  // input  [31:0]                   
   .pipe4_l00_tx_data_k           (device_pipe4_l00_tx_data_k                       ),  // input  [3:0]                    
   .pipe4_l00_tx_sync_header      (device_pipe4_l00_tx_sync_header                  ),  // input  [3:0]                    
   .pipe4_l00_tx_start_block      (device_pipe4_l00_tx_start_block                  ),  // input                           
   .pipe4_l00_tx_data_valid       (device_pipe4_l00_tx_data_valid                   ),  // input                           
   .pipe4_l00_tx_det_rx_lpbk      (device_pipe4_l00_tx_det_rx_lpbk                  ),  // input                           
   .pipe4_l00_tx_elec_idle        (device_pipe4_l00_tx_elec_idle                    ),  // input                           
   .pipe4_l00_tx_ones_zeros       (device_pipe4_l00_tx_ones_zeros                   ),  // input                           
   .pipe4_l00_tx_128b_enc_byp     (device_pipe4_l00_tx_128b_enc_byp                 ),  // input                           
   .pipe4_l00_tx_deemph           (device_pipe4_l00_tx_deemph                       ),  // input  [1:0]                    

// *******************************
// Original PIPE - Lane1 Signals
// *******************************
   .pipe4_l01_phy_status          (device_pipe4_l01_phy_status                      ),  // output                          
   .pipe4_l01_rx_data             (device_pipe4_l01_rx_data                         ),  // output [31:0]                   
   .pipe4_l01_rx_data_k           (device_pipe4_l01_rx_data_k                       ),  // output [3:0]                    
   .pipe4_l01_rx_sync_header      (device_pipe4_l01_rx_sync_header                  ),  // output [3:0]                    
   .pipe4_l01_rx_start_block      (device_pipe4_l01_rx_start_block                  ),  // output                          
   .pipe4_l01_rx_data_valid       (device_pipe4_l01_rx_data_valid                   ),  // output                          
   .pipe4_l01_rx_valid            (device_pipe4_l01_rx_valid                        ),  // output                          
   .pipe4_l01_rx_status           (device_pipe4_l01_rx_status                       ),  // output [2:0]                    
   .pipe4_l01_rx_elec_idle        (device_pipe4_l01_rx_elec_idle                    ),  // output                          
                                                                                       
   .pipe4_l01_rx_polarity         (device_pipe4_l01_rx_polarity                     ),  // input                           
   .pipe4_l01_rx_termination      (device_pipe4_l01_rx_termination                  ),  // input                           
   .pipe4_l01_rx_eq_training      (device_pipe4_l01_rx_eq_training                  ),  // input                           
                                                                                       
   .pipe4_l01_tx_data             (device_pipe4_l01_tx_data                         ),  // input  [31:0]                   
   .pipe4_l01_tx_data_k           (device_pipe4_l01_tx_data_k                       ),  // input  [3:0]                    
   .pipe4_l01_tx_sync_header      (device_pipe4_l01_tx_sync_header                  ),  // input  [3:0]                    
   .pipe4_l01_tx_start_block      (device_pipe4_l01_tx_start_block                  ),  // input                           
   .pipe4_l01_tx_data_valid       (device_pipe4_l01_tx_data_valid                   ),  // input                           
   .pipe4_l01_tx_det_rx_lpbk      (device_pipe4_l01_tx_det_rx_lpbk                  ),  // input                           
   .pipe4_l01_tx_elec_idle        (device_pipe4_l01_tx_elec_idle                    ),  // input                           
   .pipe4_l01_tx_ones_zeros       (device_pipe4_l01_tx_ones_zeros                   ),  // input                           
   .pipe4_l01_tx_128b_enc_byp     (device_pipe4_l01_tx_128b_enc_byp                 ),  // input                           
   .pipe4_l01_tx_deemph           (device_pipe4_l01_tx_deemph                       ),  // input  [1:0]                    

// *******************************
// Serdes PIPE interface
// For USB4
// *******************************
   .pipe7_clk_max                 (device_pipe7_clk_max                     ),  // output                          
   .pipe7_clk_max_req             (device_pipe7_clk_max_req                 ),  // input                           
   .pipe7_clk_max_ack             (device_pipe7_clk_max_ack                 ),  // output                          
                                                     
   .pipe7_pll0_en                 (device_pipe7_pll0_en                     ),  // input     For USB4 Serdes Arch only
   .pipe7_pll0_ok                 (device_pipe7_pll0_ok                     ),  // output    For USB4 Serdes Arch only
                                                     
   .pipe7_reset_n                 (device_pipe7_reset_n                     ),  // input                           
//input  [1:0]                     pipe7_tx_width, // Support 40bit only
//input  [1:0]                     pipe7_rx_width, // Support 40bit only

// *******************************
// Serdes PIPE - Lane0 Signals
// *******************************
   .pipe7_l00_clk                 (device_pipe7_l00_clk                               ),  // input                           
   .pipe7_l00_rate                (device_pipe7_l00_rate                              ),  // input  [1:0]                    
                                                                                  
   .pipe7_l00_phy_status          (device_pipe7_l00_phy_status                        ),  // output                          
   .pipe7_l00_rx_clk              (device_pipe7_l00_rx_clk                            ),  // output                          
   .pipe7_l00_rx_data             (device_pipe7_l00_rx_data                           ),  // output [39:0]                   
   .pipe7_l00_rx_valid            (device_pipe7_l00_rx_valid                          ),  // output                          
   .pipe7_l00_rx_standby_status   (device_pipe7_l00_rx_standby_status                 ),  // output                          
   .pipe7_l00_rx_elec_idle        (device_pipe7_l00_rx_elec_idle                      ),  // output                          
                                                                                  
   .pipe7_l00_rx_termination      (device_pipe7_l00_rx_termination                    ),  // input                           
   .pipe7_l00_rx_standby          (device_pipe7_l00_rx_standby                        ),  // input                           
                                                                                  
   .pipe7_l00_powerdown           (device_pipe7_l00_powerdown                         ),  // input  [2:0]                    
   .pipe7_l00_tx_data             (device_pipe7_l00_tx_data                           ),  // input  [39:0]                   
   .pipe7_l00_tx_data_valid       (device_pipe7_l00_tx_data_valid                     ),  // input                           
   .pipe7_l00_tx_det_rx_lpbk      (device_pipe7_l00_tx_det_rx_lpbk                    ),  // input                           
   .pipe7_l00_tx_elec_idle        (device_pipe7_l00_tx_elec_idle                      ),  // input                           
                                                                                  
   .pipe7_l00_m2p_messagebus      (device_pipe7_l00_m2p_messagebus                    ),  // input  [7:0]                    
   .pipe7_l00_p2m_messagebus      (device_pipe7_l00_p2m_messagebus                    ),  // output [7:0]                    

//TODO
//input         pipe_l00_rx_elec_idle_det_dis,

// *******************************
// Serdes PIPE - Lane1 Signals
// *******************************
   .pipe7_l01_clk                 (device_pipe7_l01_clk                               ),  // input                           
   .pipe7_l01_rate                (device_pipe7_l01_rate                              ),  // input  [1:0]                    
                                                                                         
   .pipe7_l01_phy_status          (device_pipe7_l01_phy_status                        ),  // output                          
   .pipe7_l01_rx_clk              (device_pipe7_l01_rx_clk                            ),  // output                          
   .pipe7_l01_rx_data             (device_pipe7_l01_rx_data                           ),  // output [39:0]                   
   .pipe7_l01_rx_valid            (device_pipe7_l01_rx_valid                          ),  // output                          
   .pipe7_l01_rx_standby_status   (device_pipe7_l01_rx_standby_status                 ),  // output                          
   .pipe7_l01_rx_elec_idle        (device_pipe7_l01_rx_elec_idle                      ),  // output                          
                                                                                         
   .pipe7_l01_rx_termination      (device_pipe7_l01_rx_termination                    ),  // input                           
   .pipe7_l01_rx_standby          (device_pipe7_l01_rx_standby                        ),  // input                           
                                                                                         
   .pipe7_l01_powerdown           (device_pipe7_l01_powerdown                         ),  // input  [2:0]                    
   .pipe7_l01_tx_data             (device_pipe7_l01_tx_data                           ),  // input  [39:0]                   
   .pipe7_l01_tx_data_valid       (device_pipe7_l01_tx_data_valid                     ),  // input                           
   .pipe7_l01_tx_det_rx_lpbk      (device_pipe7_l01_tx_det_rx_lpbk                    ),  // input                           
   .pipe7_l01_tx_elec_idle        (device_pipe7_l01_tx_elec_idle                      ),  // input                           
                                                                                        
   .pipe7_l01_m2p_messagebus      (device_pipe7_l01_m2p_messagebus                    ),  // input  [7:0]                    
   .pipe7_l01_p2m_messagebus      (device_pipe7_l01_p2m_messagebus                    ),  // output [7:0]                    

// *******************************
// Raw interface - Link Signals
// *******************************
   .pma_cmn_ready                (device_pma_cmn_ready                            ),  // output                          
   .pma_xcvr_pllclk_en_ack       (device_pma_xcvr_pllclk_en_ack                   ),  // output                          
   .pma_xcvr_power_state_ack     (device_pma_xcvr_power_state_ack                 ),  // output [5:0]                    
   .pma_cmn_avdd_pwrgood         (device_pma_cmn_avdd_pwrgood                     ),  // output                          
                                                                              
   .pma_xcvr_pllclk_en           (device_pma_xcvr_pllclk_en                       ),  // input                           
   .pma_xcvr_power_state_req     (device_pma_xcvr_power_state_req                 ),  // input  [5:0]                    
   .pma_xcvr_data_width          (device_pma_xcvr_data_width                      ),  // input  [2:0]                    
                                                                              
   .dp_reset_n                   (device_dp_reset_n                               ),  // input                           
   .pma_tx_td_clk                (device_pma_tx_td_clk                            ),  // input                           
                                                           
   .pma_tx_lfps_en               (device_pma_tx_lfps_en                           ),  // input  //New added for Mac to transmit LFPS
   .pma_tx_lfps_mode             (device_pma_tx_lfps_mode                         ),  // input  //New added for Mac to transmit LFPS


// *******************************
// Raw interface - Lane0 Signals
// *******************************
   .pma_tx_elec_idle_ln_0         (device_pma_tx_elec_idle_ln_0                 ),  // input                           
   .pma_tx_td_ln_0                (device_pma_tx_td_ln_0                        ),  // input  [31:0]                   

// *******************************
// Raw interface - Lane1 Signals
// *******************************
   .pma_tx_elec_idle_ln_1         (device_pma_tx_elec_idle_ln_1                 ),  // input                           
   .pma_tx_td_ln_1                (device_pma_tx_td_ln_1                        ),  // input  [31:0]                   

// *******************************
// Raw interface - Lane2 Signals
// *******************************
   .pma_tx_elec_idle_ln_2         (device_pma_tx_elec_idle_ln_2                 ),  // input                           
   .pma_tx_td_ln_2                (device_pma_tx_td_ln_2                        ),  // input  [31:0]                   

// *******************************
// Raw interface - Lane3 Signals
// *******************************
   .pma_tx_elec_idle_ln_3         (device_pma_tx_elec_idle_ln_3                 ),  // input                           
   .pma_tx_td_ln_3                (device_pma_tx_td_ln_3                        ),  // input  [31:0]                   

// *******************************
// PHY/PMA Interface & PMA Clocks
// *******************************
// External reference clock active detection
//input       pma_cmn_ext_refclk0_detected_en,
//output      pma_cmn_ext_refclk0_detected,
//output      pma_cmn_ext_refclk0_detected_valid,
//input       pma_cmn_ext_refclk1_detected_en,
//output      pma_cmn_ext_refclk1_detected,
//output      pma_cmn_ext_refclk1_detected_valid,

   .usb_datart_clk                (                ),  // output                          
   .usb_fullrt_clk                (                ),  // output                          
   .dp_datart_clk                 (                ),  // output                          
   .dp_fullrt_clk                 (                ),  // output                          
                            
   .pma_cmn_refclk0_int           (ref_clk0_device                 ),  // input                           
   .pma_cmn_refclk1_int           (ref_clk1_device                 ),  // input                           
   .pma_cmn_refclk_dig_div        (device_pma_cmn_refclk_dig_div                  ),  // input  [1:0]                    
   .pma_cmn_refclk_dig_sel        (device_pma_cmn_refclk_dig_sel                  ),  // input                           
   .pma_cmn_pll0_refclk_sel       (device_pma_cmn_pll0_refclk_sel                 ),  // input  [1:0]                    
   .pma_cmn_pll1_refclk_sel       (device_pma_cmn_pll1_refclk_sel                 ),  // input  [1:0]                    

// *******************************
// Digital Test Bus
// *******************************
`ifndef CDN_MPPHY_RMV_DTB // @RELEASE@
   .dtb_data                      (                ),  // output [31:0]                   
   .dtb_clk                       (                ),  // output                          
`endif // @RELEASE@

// *******************************
// TAP interface
// *******************************
   .tap_tck                       ( 'h0 ),//phy_jtag_tck                    ),  // input                           
   .tap_tms                       ( 'h0 ),//phy_jtag_tms                    ),  // input                           
   .tap_trst_n                    ( 'h0 ),//phy_jtag_trst                   ),  // input                           
   .tap_tdi                       ( 'h0 ),//phy_jtag_tdi                    ),  // input                           
   .tap_tdo                       (phy_jtag_tdo_device                    ),  // output                          
   .tap_tdoen                     (phy_jtag_tdo_oe_device                 ),  // output                          

`ifdef CDN_TESTCHIP_UC_DBGR
//uC debugger Tap interfaces
   .uc_top_tap_tck                (                ),  // input                           
   .uc_top_tap_tms                (                ),  // input                           
   .uc_top_tap_trst_n             (                ),  // input                           
   .uc_top_tap_tdi                (                ),  // input                           
   .uc_top_tap_tdo                (                ),  // output                          
   .uc_top_tap_tdoen              (                ),  // output                          

`ifndef CDN_MPPHY_LANE_UC_RMV
   .uc_l01_tap_tck                (                ),  // input                           
   .uc_l01_tap_tms                (                ),  // input                           
   .uc_l01_tap_trst_n             (                ),  // input                           
   .uc_l01_tap_tdi                (                ),  // input                           
   .uc_l01_tap_tdo                (                ),  // output                          
   .uc_l01_tap_tdoen              (                ),  // output                          

   .uc_l23_tap_tck                (                ),  // input                           
   .uc_l23_tap_tms                (                ),  // input                           
   .uc_l23_tap_trst_n             (                ),  // input                           
   .uc_l23_tap_tdi                (                ),  // input                           
   .uc_l23_tap_tdo                (                ),  // output                          
   .uc_l23_tap_tdoen              (                ),  // output                          
`endif

`endif

// *******************************
// IEEE1687 interface
// *******************************

   .ieee1687_interface_en         ( 'h0 ),//host_1687_en                       ),  // input                           
   .ieee1687_so                   (jtag_tdo_1687_device                      ),  // output                          
   .ieee1687_si                   ( 'h0 ),//jtag_clockdr_1687                  ),  // input                           
   .ieee1687_capture_en           ( 'h0 ),//jtag_shiftdr_1687                  ),  // input                           
   .ieee1687_shift_en             ( 'h0 ),//jtag_updatedr_1687                 ),  // input                           
   .ieee1687_update_en            ( 'h0 ),//jtag_capture_1687                  ),  // input                           
   .ieee1687_sel                  (1'b0                               ),  // input                           
   .ieee1687_rstn                 (1'b0                               ),  // input                           
   .ieee1687_tck                  (1'b0 ),//phy_jtag_tck                       ),  // input                           

// *******************************
// Digital scan interface
// *******************************
   .iddq_en                           ( 'h0            ),  // input                           
                                                         
   .scanmode                          ( 'h0            ),  // input                           
   .scanen                            ( 'h0            ),  // input                           
   .scanen_cg                         ( 'h0            ),  // input                           
   .cmn_scan_pll_ats                  ( 'h0            ),  // input                           
   .cmn_scanclk_pll0_prog0_ats_out    (                ),  // output                          
   .cmn_scanclk_pll0_prog1_ats_out    (                ),  // output                          
   .cmn_scanclk_pll1_prog0_ats_out    (                ),  // output                          
   .cmn_scanclk_pll1_prog1_ats_out    (                ),  // output                          
   .cmn_scanclk_psmclk                (                ),  // input                           
   .cmn_scanclk_refclk                (                ),  // input                           
   .cmn_scanclk_serclk                (                ),  // input                           
   .cmn_scanclk_pllclk                (                ),  // input                           
   .scanclk_pipeclk                   (                ),  // input                           

// *******************************
// PHY soft scan chains
// *******************************
   .phy_scanin                        (                ),  // input   `PHY_SCAN_IN_WIDTH      
   .phy_scanout                       (                ),  // output  `PHY_SCAN_OUT_WIDTH     

// *******************************
// PMA Scan chains.
// *******************************
   .pma_cmn_scanin                    (                ),  // input   `PMA_CMN_SCAN_IN_WIDTH  
   .pma_cmn_scanout                   (                ),  // output  `PMA_CMN_SCAN_OUT_WIDTH 
                                                          
   .xcvr_scanclk_serclk_ln_0          (                ),  // input                           
   .xcvr_scanclk_pllclk_ln_0          (                ),  // input                           
   .pma_xcvr_scanin_ln_0              (                ),  // input   `PMA_XCVR_SCAN_IN_WIDTH 
   .pma_xcvr_scanout_ln_0             (                ),  // output  `PMA_XCVR_SCAN_OUT_WIDTH
                                                          
   .xcvr_scanclk_serclk_ln_1          (                ),  // input                           
   .xcvr_scanclk_pllclk_ln_1          (                ),  // input                           
   .pma_xcvr_scanin_ln_1              (                ),  // input   `PMA_XCVR_SCAN_IN_WIDTH 
   .pma_xcvr_scanout_ln_1             (                ),  // output  `PMA_XCVR_SCAN_OUT_WIDTH
                                                          
   .xcvr_scanclk_serclk_ln_2          (                ),  // input                           
   .xcvr_scanclk_pllclk_ln_2          (                ),  // input                           
   .pma_xcvr_scanin_ln_2              (                ),  // input   `PMA_XCVR_SCAN_IN_WIDTH 
   .pma_xcvr_scanout_ln_2             (                ),  // output  `PMA_XCVR_SCAN_OUT_WIDTH
                                                          
   .xcvr_scanclk_serclk_ln_3          (                ),  // input                           
   .xcvr_scanclk_pllclk_ln_3          (                ),  // input                           
   .pma_xcvr_scanin_ln_3              (                ),  // input   `PMA_XCVR_SCAN_IN_WIDTH 
   .pma_xcvr_scanout_ln_3             (                ),  // output  `PMA_XCVR_SCAN_OUT_WIDTH

// *****************************************
// External Boundary Scan Control Interface
// *****************************************
   .bscan_ext_select                  ( 'h0            ),  // input                           
   .bscan_ext_shiftdr                 ( 'h0            ),  // input                           
   .bscan_ext_clockdr                 (                ),  // input                           
   .tx_bscan_ext_updatedr             (                ),  // input                           
   .tx_bscan_ext_mode_c               ( 'h0            ),  // input                           
   .tx_bscan_ext_ac                   ( 'h0            ),  // input                           
   .tx_bscan_ext_acpulse              (                ),  // input                           
   .tx_bscan_ext_tdo                  (                ),  // output                          
   .rx_bscan_ext_pc                   (                ),  // input                           
   .rx_bscan_ext_ac                   ( 'h0            ),  // input                           
   .rx_bscan_ext_tdi                  (                ),  // input                           

// *****************************************
// Internal Boundary Scan Control Interface
// *****************************************
   .xcvr_bscan_mode_en                ( 'h0            )   // input                           

);

`endif
