

module testchip_clkrst (
//DDR clock
input [3:0]            param_ddr_cal_cal_clk_div_sel,
input [3:0]            param_ddr_pclk_div_sel,
input                  param_ddr_rx_pclk_en,
  
output                 ddr_cal_cal_clk,
output                 ddr_pclk,
output                 ddr_rx_pclk,
// Scan
input                  scanmode,
input                  scanen,
input                  scanen_cg,
//Clock
input                  noc_clk,
input                  uc_clk,
input                  cdb_pclk,
input                  cmn_refclk0_int,
input                  cmn_refclk1_int,
//Reset
input                  tc_reset_n,
input                  noc_reset_n,

input                  param_phy_ss_reset_n,
input                  param_pam3_ss_reset_n,
input                  param_ddrio_ctrl_reset_n,
input                  param_test_clk_ctrl_reset_n,

output                 phy_ss_reset_n,
output                 pam3_ss_reset_n,
output                 ddrio_ctrl_reset_n,
output                 test_clk_ctrl_reset_n,

output                 ddrio_ctrl_reset_n_sync, //@noc_clk
output                 ddr_pclk_reset_n_sync, //@ddr_pclk
// Test Clock
input                  test_clk_phy,
input                  test_clk_pam3,
input [3:0]            param_test_clk_sel,
input                  param_test_clk_en,
output                 test_clk,    
//PHY Ref Clock
`ifdef CDNS_PMA_PWR_AWARE 
input                  avdd,
input                  avdd_h,
input                  gnd, 
`endif
//TC REF CLK AUX 0
//Analog Inputs	
input                  tcauxda_0_ref_clk_p,
input                  tcauxda_0_ref_clk_m,
//Digital Inputs       
input                  tcauxda_0_bg_start_hyst_dis,
input    [1:0]         tcauxda_0_bg_start_adj,
input                  tcauxda_0_bg_en,
input                  tcauxda_0_bias_en,
input    [1:0]         tcauxda_0_bias_cur_adj,
input    [5:0]         tcauxda_0_irext_trim,
input                  tcauxda_0_pll_refclk_enable,
input                  tcauxda_0_ref_clk_int,
input                  tcauxda_0_pll_refclk_sel,
input                  tcauxda_0_ref_clk0_ac_byp,
input                  tcauxda_0_ref_clk0_dig_buf_en,
input                  tcauxda_0_ref_clk0_dig_hyst_inc,
input    [1:0]         tcauxda_0_ref_clk0_filt_ctrl,
input                  tcauxda_0_ref_clk0_pll_buf_en,
input                  tcauxda_0_ref_clk0_term_en,
//Digital Outputs      
output                 tcauxda_0_refclk_dig,
output                 tcauxda_0_pll_refclk_out,
//TC REF CLK AUX 1
//Analog Inputs	
input                  tcauxda_1_ref_clk_p,
input                  tcauxda_1_ref_clk_m,
//Digital Inputs       
input                  tcauxda_1_bg_start_hyst_dis,
input    [1:0]         tcauxda_1_bg_start_adj,
input                  tcauxda_1_bg_en,
input                  tcauxda_1_bias_en,
input    [1:0]         tcauxda_1_bias_cur_adj,
input    [5:0]         tcauxda_1_irext_trim,
input                  tcauxda_1_pll_refclk_enable,
input                  tcauxda_1_ref_clk_int,
input                  tcauxda_1_pll_refclk_sel,
input                  tcauxda_1_ref_clk0_ac_byp,
input                  tcauxda_1_ref_clk0_dig_buf_en,
input                  tcauxda_1_ref_clk0_dig_hyst_inc,
input    [1:0]         tcauxda_1_ref_clk0_filt_ctrl,
input                  tcauxda_1_ref_clk0_pll_buf_en,
input                  tcauxda_1_ref_clk0_term_en,
//Digital Outputs      
output                 tcauxda_1_refclk_dig,
output                 tcauxda_1_pll_refclk_out
);

//****************************************************
// DDR Clock
//****************************************************

//------------------------------------------------------------------------------
// Clock divider for DDR CAL_CLK
//------------------------------------------------------------------------------
phy_clock_div_prog #(.DIV_CTRL_WIDTH(4)) u_ddr_cal_clk_div (
  .clock_div_sel        (param_ddr_cal_cal_clk_div_sel),
  .clock_in             (noc_clk),
  .clock_div_out        (ddr_cal_cal_clk),
  .reset_in_n           (ddrio_ctrl_reset_n),
  .reset_out_n          (/* unconnected */),
  .upstream_reset_in_n  (1'b1),
  .scan_reset_in_n      (tc_reset_n),
  .scan_mode_en_in      (scanmode)
);

//------------------------------------------------------------------------------
// Clock divider for DDR PCLK
//------------------------------------------------------------------------------
phy_clock_div_prog #(.DIV_CTRL_WIDTH(4)) u_ddr_pclk_div (
  .clock_div_sel        (param_ddr_pclk_div_sel),
  .clock_in             (noc_clk),
  .clock_div_out        (ddr_pclk),
  .reset_in_n           (ddrio_ctrl_reset_n),
  .reset_out_n          (ddr_pclk_reset_n_sync),
  .upstream_reset_in_n  (1'b1),
  .scan_reset_in_n      (tc_reset_n),
  .scan_mode_en_in      (scanmode)
);

// ddr_rx_pclk is a free-running gray-coded counter
always @(posedge noc_clk or negedge ddrio_ctrl_reset_n_sync)
begin
if (!ddrio_ctrl_reset_n_sync)
   begin
   ddr_rx_pclk <= 3'd0;
   end
else
   begin
   if (param_ddr_rx_pclk_en)
      begin
      case (ddr_rx_pclk)
      3'b000 : ddr_rx_pclk <= 3'b001;
      3'b001 : ddr_rx_pclk <= 3'b011;
      3'b011 : ddr_rx_pclk <= 3'b010;
      3'b010 : ddr_rx_pclk <= 3'b110;
      3'b110 : ddr_rx_pclk <= 3'b111;
      3'b111 : ddr_rx_pclk <= 3'b101;
      3'b101 : ddr_rx_pclk <= 3'b100;
      3'b100 : ddr_rx_pclk <= 3'b000;
      endcase
      end
   else
      begin
      ddr_rx_pclk <= 3'd0;
      end
   end
end

//****************************************************
// Ref Clock
//****************************************************

ref_clk_buffer u_ref_clk_buffer_0(/*autoinst*/
        //Supplies
        .avdd                             (avdd                                 ), //input
        .avdd_h                           (avdd_h                               ), //input
        .gnd                              (gnd                                  ), //input
        //Analog Inputs	
        .tcauxda_ref_clk_p                (tcauxda_0_ref_clk_p                  ), //input
        .tcauxda_ref_clk_m                (tcauxda_0_ref_clk_m                  ), //input
        //Digital Inputs       
        .tcauxda_bg_start_hyst_dis        (tcauxda_0_bg_start_hyst_dis          ), //input
        .tcauxda_bg_start_adj             (tcauxda_0_bg_start_adj[1:0]          ), //input
        .tcauxda_bg_en                    (tcauxda_0_bg_en                      ), //input
        .tcauxda_bias_en                  (tcauxda_0_bias_en                    ), //input
        .tcauxda_bias_cur_adj             (tcauxda_0_bias_cur_adj[1:0]          ), //input
        .tcauxda_irext_trim               (tcauxda_0_irext_trim[5:0]            ), //input
        .tcauxda_pll_refclk_enable        (tcauxda_0_pll_refclk_enable          ), //input
        .tcauxda_ref_clk_int              (tcauxda_0_ref_clk_int                ), //input
        .tcauxda_pll_refclk_sel           (tcauxda_0_pll_refclk_sel             ), //input
        .tcauxda_ref_clk0_ac_byp          (tcauxda_0_ref_clk0_ac_byp            ), //input
        .tcauxda_ref_clk0_dig_buf_en      (tcauxda_0_ref_clk0_dig_buf_en        ), //input
        .tcauxda_ref_clk0_dig_hyst_inc    (tcauxda_0_ref_clk0_dig_hyst_inc      ), //input
        .tcauxda_ref_clk0_filt_ctrl       (tcauxda_0_ref_clk0_filt_ctrl[1:0]    ), //input
        .tcauxda_ref_clk0_pll_buf_en      (tcauxda_0_ref_clk0_pll_buf_en        ), //input
        .tcauxda_ref_clk0_term_en         (tcauxda_0_ref_clk0_term_en           ), //input
        //Digital Outputs      
        .tcauxda_refclk_dig               (tcauxda_0_refclk_dig                 ), //output
        .tcauxda_pll_refclk_out           (tcauxda_0_pll_refclk_out             )  //output
    );

ref_clk_buffer u_ref_clk_buffer_1(/*autoinst*/
        //Supplies
        .avdd                             (avdd                                 ), //input
        .avdd_h                           (avdd_h                               ), //input
        .gnd                              (gnd                                  ), //input
        //Analog Inputs	
        .tcauxda_ref_clk_p                (tcauxda_1_ref_clk_p                  ), //input
        .tcauxda_ref_clk_m                (tcauxda_1_ref_clk_m                  ), //input
        //Digital Inputs       
        .tcauxda_bg_start_hyst_dis        (tcauxda_1_bg_start_hyst_dis          ), //input
        .tcauxda_bg_start_adj             (tcauxda_1_bg_start_adj[1:0]          ), //input
        .tcauxda_bg_en                    (tcauxda_1_bg_en                      ), //input
        .tcauxda_bias_en                  (tcauxda_1_bias_en                    ), //input
        .tcauxda_bias_cur_adj             (tcauxda_1_bias_cur_adj[1:0]          ), //input
        .tcauxda_irext_trim               (tcauxda_1_irext_trim[5:0]            ), //input
        .tcauxda_pll_refclk_enable        (tcauxda_1_pll_refclk_enable          ), //input
        .tcauxda_ref_clk_int              (tcauxda_1_ref_clk_int                ), //input
        .tcauxda_pll_refclk_sel           (tcauxda_1_pll_refclk_sel             ), //input
        .tcauxda_ref_clk0_ac_byp          (tcauxda_1_ref_clk0_ac_byp            ), //input
        .tcauxda_ref_clk0_dig_buf_en      (tcauxda_1_ref_clk0_dig_buf_en        ), //input
        .tcauxda_ref_clk0_dig_hyst_inc    (tcauxda_1_ref_clk0_dig_hyst_inc      ), //input
        .tcauxda_ref_clk0_filt_ctrl       (tcauxda_1_ref_clk0_filt_ctrl[1:0]    ), //input
        .tcauxda_ref_clk0_pll_buf_en      (tcauxda_1_ref_clk0_pll_buf_en        ), //input
        .tcauxda_ref_clk0_term_en         (tcauxda_1_ref_clk0_term_en           ), //input
        //Digital Outputs      
        .tcauxda_refclk_dig               (tcauxda_1_refclk_dig                 ), //output
        .tcauxda_pll_refclk_out           (tcauxda_1_pll_refclk_out             )  //output
    );

//***********************************************
//Test Clock
//***********************************************
testchip_testclk u_testchip_testclk(/*autoinst*/
        .scanen                      (scanen                      ), //input
        .reset_n                     (test_clk_ctrl_reset_n       ), //input
        // Test Clock
        .noc_clk                     (noc_clk                     ), //input
        .uc_clk                      (uc_clk                      ), //input
        .cdb_pclk                    (cdb_pclk                    ), //input
        .cmn_refclk0_int             (cmn_refclk0_int             ), //input
        .cmn_refclk1_int             (cmn_refclk1_int             ), //input
        .tcauxda_0_pll_refclk_out    (tcauxda_0_pll_refclk_out    ), //input
        .tcauxda_1_pll_refclk_out    (tcauxda_1_pll_refclk_out    ), //input
        .test_clk_phy                (test_clk_phy                ), //input
        .test_clk_pam3               (test_clk_pam3               ), //input
        .test_clk_sel                (param_test_clk_sel[3:0]     ), //input
        .test_clk_en                 (param_test_clk_en           ), //input
        .test_clk                    (test_clk                    )  //output
    );

//***********************************************
//Reset
//***********************************************

assign phy_ss_reset_n        = tc_reset_n && param_phy_ss_reset_n; 
assign pam3_ss_reset_n       = tc_reset_n && param_pam3_ss_reset_n; 
assign ddrio_ctrl_reset_n    = tc_reset_n && param_ddrio_ctrl_reset_n; 
assign test_clk_ctrl_reset_n = tc_reset_n && param_test_clk_ctrl_reset_n; 
 
phy_reset_sync u_phy_reset_sync_test_clk_ctrl_reset_n (/*autoinst*/
        .sync_clock_in          (noc_clk                        ), //input
        .reset_in_n             (test_clk_ctrl_reset_n          ), //input
        .reset_out_n            (test_clk_ctrl_reset_n_sync     ), //output
        .upstream_reset_in_n    (1'b1                           ), //input
        .scan_mode_en_in        (scanmode                       ), //input
        .scan_reset_in_n        (tc_reset_n                     )  //input
    );
 
phy_reset_sync u_phy_reset_sync_ddrio_ctrl_reset_n (/*autoinst*/
        .sync_clock_in          (noc_clk                        ), //input
        .reset_in_n             (ddrio_ctrl_reset_n             ), //input
        .reset_out_n            (ddrio_ctrl_reset_n_sync        ), //output
        .upstream_reset_in_n    (1'b1                           ), //input
        .scan_mode_en_in        (scanmode                       ), //input
        .scan_reset_in_n        (tc_reset_n                     )  //input
    );

endmodule

// Local Variables:
// verilog-library-directories:(".")
// verilog-library-directories:("./phy_subsystem")
// verilog-library-directories:("./pam3_subsystem")
// verilog-library-directories:("./noc/usb4_tc_noc/rtl/noc")
// verilog-library-directories:("../../reuse/rtl_phy_misc_components")
// End:

