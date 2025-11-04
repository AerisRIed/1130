//top_connection
//
wire host_tx0p,host_tx1p;
wire host_tx0n,host_tx1n;
wire host_tx2p,host_tx3p;
wire host_tx2n,host_tx3n;
wire host_rx0p,host_rx1p;
wire host_rx0n,host_rx1n;

wire devc_tx0p,devc_tx1p;
wire devc_tx0n,devc_tx1n;
wire devc_rx0p,devc_rx1p;
wire devc_rx0n,devc_rx1n;
wire devc_rx2p,devc_rx3p;
wire devc_rx2n,devc_rx3n;

bit pn_swap = 0; //PN sawp
bit flip    = 0; //lane reversal

initial begin
    if($test$plusargs("FLIP_MODE")) begin
        flip = 1;
        `uvm_info("[CONNECTION CONFIG]",$psprintf("\033[1;42m FLIP_MODE set by macros is 1 \033[0m" ),UVM_LOW);
    end else begin
        flip    = $urandom_range(0,1);
        `uvm_info("[CONNECTION CONFIG]",$psprintf("\033[1;42m FLIP_MODE random is %b \033[0m" ,  flip),UVM_LOW);
    end
    uvm_config_db#(bit)::set(null,"*", "flip_mode", flip);
end

initial begin
    if($test$plusargs("PN_SWAP")) begin
        pn_swap = 1;
        `uvm_info("[CONNECTION CONFIG]",$psprintf("\033[1;42m PN_SWAP set by macros is 1 \033[0m"),UVM_LOW);
    end else begin
        pn_swap = $urandom_range(0,0);//TODO
        `uvm_info("[CONNECTION CONFIG]",$psprintf("\033[1;42m PN_SWAP random is %b \033[0m" , pn_swap ),UVM_LOW);
    end
    uvm_config_db#(bit)::set(null,"*", "pn_swap", pn_swap);
end

`ifdef DP // 
assign devc_rx0p = ~flip ? (~pn_swap ? host_tx0p : host_tx0n) : (~pn_swap ? host_tx3p : host_tx3n);
assign devc_rx0n = ~flip ? (~pn_swap ? host_tx0n : host_tx0p) : (~pn_swap ? host_tx3n : host_tx3p);
assign devc_rx1p = ~flip ? (~pn_swap ? host_tx1p : host_tx1n) : (~pn_swap ? host_tx2p : host_tx2n);
assign devc_rx1n = ~flip ? (~pn_swap ? host_tx1n : host_tx1p) : (~pn_swap ? host_tx2n : host_tx2p);
assign devc_rx2p = ~flip ? (~pn_swap ? host_tx2p : host_tx2n) : (~pn_swap ? host_tx1p : host_tx1n);
assign devc_rx2n = ~flip ? (~pn_swap ? host_tx2n : host_tx2p) : (~pn_swap ? host_tx1n : host_tx1p);
assign devc_rx3p = ~flip ? (~pn_swap ? host_tx3p : host_tx3n) : (~pn_swap ? host_tx0p : host_tx0n);
assign devc_rx3n = ~flip ? (~pn_swap ? host_tx3n : host_tx3p) : (~pn_swap ? host_tx0n : host_tx0p);
`elsif ALT_MODE
assign host_rx0p = ~pn_swap ? devc_tx0p : devc_tx0n;
assign host_rx0n = ~pn_swap ? devc_tx0n : devc_tx0p;
assign devc_rx0p = ~pn_swap ? host_tx0p : host_tx0n;
assign devc_rx0n = ~pn_swap ? host_tx0n : host_tx0p;
assign devc_rx2p = ~pn_swap ? host_tx2p : host_tx2n;
assign devc_rx2n = ~pn_swap ? host_tx2n : host_tx2p;
assign devc_rx3p = ~pn_swap ? host_tx3p : host_tx3n;
assign devc_rx3n = ~pn_swap ? host_tx3n : host_tx3p;
`else
assign host_rx0p = ~flip ? (~pn_swap ? devc_tx0p : devc_tx0n) : (~pn_swap ? devc_tx1p : devc_tx1n);
assign host_rx0n = ~flip ? (~pn_swap ? devc_tx0n : devc_tx0p) : (~pn_swap ? devc_tx1n : devc_tx1p);
assign host_rx1p = ~flip ? (~pn_swap ? devc_tx1p : devc_tx1n) : (~pn_swap ? devc_tx0p : devc_tx0n);
assign host_rx1n = ~flip ? (~pn_swap ? devc_tx1n : devc_tx1p) : (~pn_swap ? devc_tx0n : devc_tx0p);
assign devc_rx0p = ~flip ? (~pn_swap ? host_tx0p : host_tx0n) : (~pn_swap ? host_tx1p : host_tx1n);
assign devc_rx0n = ~flip ? (~pn_swap ? host_tx0n : host_tx0p) : (~pn_swap ? host_tx1n : host_tx1p);
assign devc_rx1p = ~flip ? (~pn_swap ? host_tx1p : host_tx1n) : (~pn_swap ? host_tx0p : host_tx0n);
assign devc_rx1n = ~flip ? (~pn_swap ? host_tx1n : host_tx1p) : (~pn_swap ? host_tx0n : host_tx0p);
`endif

`ifdef DUT_BYPASS
`ifdef USB32
//--------------------------TX------------------------------//
assign host_tx0p = `USB32_HOST_LANE0.serdes_tx.serial_p;
assign host_tx0n = `USB32_HOST_LANE0.serdes_tx.serial_n;
assign host_tx1p = `USB32_HOST_LANE1.serdes_tx.serial_p;
assign host_tx1n = `USB32_HOST_LANE1.serdes_tx.serial_n;

assign devc_tx0p = `USB32_DEVC_LANE0.serdes_tx.serial_p;
assign devc_tx0n = `USB32_DEVC_LANE0.serdes_tx.serial_n;
assign devc_tx1p = `USB32_DEVC_LANE1.serdes_tx.serial_p;
assign devc_tx1n = `USB32_DEVC_LANE1.serdes_tx.serial_n;
assign `USB32_DEVC_LANE0.pclk = clk_io.drv_clk_gen[0]; // TODO
assign `USB32_DEVC_LANE1.pclk = clk_io.drv_clk_gen[0]; // TODO
assign `USB32_HOST_LANE0.pclk = clk_io.drv_clk_gen[0]; // TODO
assign `USB32_HOST_LANE1.pclk = clk_io.drv_clk_gen[0]; // TODO
//----------------------------------------------------------//
//--------------------------RX------------------------------//
assign `USB32_HOST_LANE0.serdes_rx.serial_p  = host_rx0p;
assign `USB32_HOST_LANE0.serdes_rx.serial_n  = host_rx0n;
assign `USB32_HOST_LANE1.serdes_rx.serial_p  = host_rx1p;
assign `USB32_HOST_LANE1.serdes_rx.serial_n  = host_rx1n;

assign `USB32_DEVC_LANE0.serdes_rx.serial_p  = devc_rx0p;
assign `USB32_DEVC_LANE0.serdes_rx.serial_n  = devc_rx0n;
assign `USB32_DEVC_LANE1.serdes_rx.serial_p  = devc_rx1p;
assign `USB32_DEVC_LANE1.serdes_rx.serial_n  = devc_rx1n;
`elsif USB4
//--------------------------TX------------------------------//
assign host_tx0p = `USB4_HOST_LANE0.serdes_tx.serial_p;
assign host_tx0n = `USB4_HOST_LANE0.serdes_tx.serial_n;
assign host_tx1p = `USB4_HOST_LANE1.serdes_tx.serial_p;
assign host_tx1n = `USB4_HOST_LANE1.serdes_tx.serial_n;

assign devc_tx0p = `USB4_DEVC_LANE0.serdes_tx.serial_p;
assign devc_tx0n = `USB4_DEVC_LANE0.serdes_tx.serial_n;
assign devc_tx1p = `USB4_DEVC_LANE1.serdes_tx.serial_p;
assign devc_tx1n = `USB4_DEVC_LANE1.serdes_tx.serial_n;
//----------------------------------------------------------//
//--------------------------RX------------------------------//
assign `USB4_HOST_LANE0.serdes_rx.serial_p  = host_rx0p;
assign `USB4_HOST_LANE0.serdes_rx.serial_n  = host_rx0n;
assign `USB4_HOST_LANE1.serdes_rx.serial_p  = host_rx1p;
assign `USB4_HOST_LANE1.serdes_rx.serial_n  = host_rx1n;

assign `USB4_DEVC_LANE0.serdes_rx.serial_p  = devc_rx0p;
assign `USB4_DEVC_LANE0.serdes_rx.serial_n  = devc_rx0n;
assign `USB4_DEVC_LANE1.serdes_rx.serial_p  = devc_rx1p;
assign `USB4_DEVC_LANE1.serdes_rx.serial_n  = devc_rx1n;
assign `USB4_DEVC_LANE0.pclk = clk_io.drv_clk_gen[0]; // TODO
assign `USB4_DEVC_LANE1.pclk = clk_io.drv_clk_gen[0]; // TODO
assign `USB4_HOST_LANE0.pclk = clk_io.drv_clk_gen[0]; // TODO
assign `USB4_HOST_LANE1.pclk = clk_io.drv_clk_gen[0]; // TODO
//----------------------------------------------------------//
`elsif PCIE
//--------------------------TX------------------------------//
assign host_tx0p = `PCIE_HOST_LANE0.serdes_tx.serial_p;
assign host_tx0n = `PCIE_HOST_LANE0.serdes_tx.serial_n;
assign devc_tx0p = `PCIE_DEVC_LANE0.serdes_tx.serial_p;
assign devc_tx0n = `PCIE_DEVC_LANE0.serdes_tx.serial_n;

if (PCIE_LANE_NUM == 2) begin
  assign host_tx1p = `PCIE_HOST_LANE1.serdes_tx.serial_p;
  assign host_tx1n = `PCIE_HOST_LANE1.serdes_tx.serial_n;
  assign devc_tx1p = `PCIE_DEVC_LANE1.serdes_tx.serial_p;
  assign devc_tx1n = `PCIE_DEVC_LANE1.serdes_tx.serial_n;
end
//----------------------------------------------------------//
//--------------------------RX------------------------------//
assign `PCIE_HOST_LANE0.serdes_rx.serial_p  = host_rx0p;
assign `PCIE_HOST_LANE0.serdes_rx.serial_n  = host_rx0n;
assign `PCIE_DEVC_LANE0.serdes_rx.serial_p  = devc_rx0p;
assign `PCIE_DEVC_LANE0.serdes_rx.serial_n  = devc_rx0n;

if (PCIE_LANE_NUM == 2) begin
  assign `PCIE_HOST_LANE1.serdes_rx.serial_p  = host_rx1p;
  assign `PCIE_HOST_LANE1.serdes_rx.serial_n  = host_rx1n;
  assign `PCIE_DEVC_LANE1.serdes_rx.serial_p  = devc_rx1p;
  assign `PCIE_DEVC_LANE1.serdes_rx.serial_n  = devc_rx1n;
end
assign `PCIE_DEVC_LANE0.pclk = clk_io.drv_clk_gen[0]; // TODO
assign `PCIE_DEVC_LANE1.pclk = clk_io.drv_clk_gen[0]; // TODO
assign `PCIE_HOST_LANE0.pclk = clk_io.drv_clk_gen[0]; // TODO
assign `PCIE_HOST_LANE1.pclk = clk_io.drv_clk_gen[0]; // TODO
//----------------------------------------------------------//
`elsif DP
//--------------------------TX------------------------------//
assign host_tx0p = `DP_HOST_LANE0.serdes_tx.serial_p;
assign host_tx0n = `DP_HOST_LANE0.serdes_tx.serial_n;
assign host_tx1p = `DP_HOST_LANE1.serdes_tx.serial_p;
assign host_tx1n = `DP_HOST_LANE1.serdes_tx.serial_n;
assign host_tx2p = `DP_HOST_LANE2.serdes_tx.serial_p;
assign host_tx2n = `DP_HOST_LANE2.serdes_tx.serial_n;
assign host_tx3p = `DP_HOST_LANE3.serdes_tx.serial_p;
assign host_tx3n = `DP_HOST_LANE3.serdes_tx.serial_n;
//----------------------------------------------------------//
//--------------------------RX------------------------------//
assign `DP_DEVC_LANE0.serdes_rx.serial_p = devc_rx0p;
assign `DP_DEVC_LANE0.serdes_rx.serial_n = devc_rx0n;
assign `DP_DEVC_LANE1.serdes_rx.serial_p = devc_rx1p;
assign `DP_DEVC_LANE1.serdes_rx.serial_n = devc_rx1n;
assign `DP_DEVC_LANE2.serdes_rx.serial_p = devc_rx2p;
assign `DP_DEVC_LANE2.serdes_rx.serial_n = devc_rx2n;
assign `DP_DEVC_LANE3.serdes_rx.serial_p = devc_rx3p;
assign `DP_DEVC_LANE3.serdes_rx.serial_n = devc_rx3n;
//----------------------------------------------------------//
`endif

`else
// *******************************
// dut related pins and connections
// *******************************
`ifdef CDNS_PHY_PWR_AWARE

// *******************************
// Power pins
// *******************************
wire                           agnd       = 1'b0;
wire                           avdd_clk   = 1'b1;
wire                           avdd_h     = 1'b1;
wire                           avdd       = 1'b1;
wire                           avdd_tx0   = 1'b1;
wire                           avdd_tx1   = 1'b1;
wire                           avdd_tx2   = 1'b1;
wire                           avdd_tx3   = 1'b1;
wire                           avdd_rx    = 1'b1;
wire                           cmn_aonvdd = 1'b1;

`endif

// *******************************
// External pins (bumps)
// *******************************
wire                             tx_p_ln_0;
wire                             tx_m_ln_0;

wire                             rx_p_ln_1;
wire                             rx_m_ln_1;

wire                             rx_p_ln_2;
wire                             rx_m_ln_2;

wire                             tx_p_ln_3;
wire                             tx_m_ln_3;

wire                             cmn_rext;

`ifndef MP_PHY_NO_ATB
wire                             pma_atb_core_0;
wire                             pma_atb_core_1;
`endif

// *******************************
// uC related interface
// *******************************

logic                             phy_uc_init_complete;
logic                             phy_error_interrupt;

// *******************************
// PHY interface
// *******************************
logic                             typec_conn_dir;

logic                             phy_interrupt_usb;
logic                             phy_interrupt_dp;

logic [3:0]                       phy_mode;
logic                             pipe_32bit_en=1; //TODO

logic                             phy_l00_ctlr_interrupt_in;
logic                             phy_l01_ctlr_interrupt_in;

// *******************************
// Original PIPE interface
// For USB3 or PCIe1/2/3/4
// *******************************
logic                             pipe4_clk;
logic                             pipe4_reset_n;
logic                             pipe4_rate;
logic [1:0]                       pipe4_powerdown;
logic                             pipe4_eb_mode;
//input                            pipe4_width, //Reserved for 16-bit data width.

// *******************************
// Original PIPE - Lane0 Signals
// *******************************
logic                             pipe4_l00_phy_status;
logic [31:0]                      pipe4_l00_rx_data;
logic [3:0]                       pipe4_l00_rx_data_k;
logic [3:0]                       pipe4_l00_rx_sync_header;
logic                             pipe4_l00_rx_start_block;
logic                             pipe4_l00_rx_data_valid;
logic                             pipe4_l00_rx_valid;
logic [2:0]                       pipe4_l00_rx_status;
logic                             pipe4_l00_rx_elec_idle;

logic                             pipe4_l00_rx_polarity;
logic                             pipe4_l00_rx_termination;
logic                             pipe4_l00_rx_eq_training;

logic [31:0]                      pipe4_l00_tx_data;
logic [3:0]                       pipe4_l00_tx_data_k;
logic [3:0]                       pipe4_l00_tx_sync_header;
logic                             pipe4_l00_tx_start_block;
logic                             pipe4_l00_tx_data_valid;
logic                             pipe4_l00_tx_det_rx_lpbk;
logic                             pipe4_l00_tx_elec_idle;
logic                             pipe4_l00_tx_ones_zeros;
logic                             pipe4_l00_tx_128b_enc_byp;
logic [1:0]                       pipe4_l00_tx_deemph;

// *******************************
// Original PIPE - Lane1 Signals
// *******************************
logic                             pipe4_l01_phy_status;
logic [31:0]                      pipe4_l01_rx_data;
logic [3:0]                       pipe4_l01_rx_data_k;
logic [3:0]                       pipe4_l01_rx_sync_header;
logic                             pipe4_l01_rx_start_block;
logic                             pipe4_l01_rx_data_valid;
logic                             pipe4_l01_rx_valid;
logic [2:0]                       pipe4_l01_rx_status;
logic                             pipe4_l01_rx_elec_idle;

logic                             pipe4_l01_rx_polarity;
logic                             pipe4_l01_rx_termination;
logic                             pipe4_l01_rx_eq_training;

logic [31:0]                      pipe4_l01_tx_data;
logic [3:0]                       pipe4_l01_tx_data_k;
logic [3:0]                       pipe4_l01_tx_sync_header;
logic                             pipe4_l01_tx_start_block;
logic                             pipe4_l01_tx_data_valid;
logic                             pipe4_l01_tx_det_rx_lpbk;
logic                             pipe4_l01_tx_elec_idle;
logic                             pipe4_l01_tx_ones_zeros;
logic                             pipe4_l01_tx_128b_enc_byp;
logic [1:0]                       pipe4_l01_tx_deemph;

// *******************************
// Serdes PIPE interface
// For USB4
// *******************************
logic                             pipe7_clk_max;
logic                             pipe7_clk_max_req;
logic                             pipe7_clk_max_ack;

logic                             pipe7_pll0_en; //For USB4 Serdes Arch only
logic                             pipe7_pll0_ok; //For USB4 Serdes Arch only

logic                             pipe7_reset_n;
//input  [1:0]                     pipe7_tx_width, // Support 40bit only
//input  [1:0]                     pipe7_rx_width, // Support 40bit only

// *******************************
// Serdes PIPE - Lane0 Signals
// *******************************
logic                             pipe7_l00_clk;
logic                             pipe7_clk_div=0;
logic [1:0]                       pipe7_l00_rate;

logic                             pipe7_l00_phy_status;
logic                             pipe7_l00_rx_clk;
logic [39:0]                      pipe7_l00_rx_data;
logic                             pipe7_l00_rx_valid;
logic                             pipe7_l00_rx_standby_status;
logic                             pipe7_l00_rx_elec_idle;

logic                             pipe7_l00_rx_termination;
logic                             pipe7_l00_rx_standby;

logic [2:0]                       pipe7_l00_powerdown;
logic [39:0]                      pipe7_l00_tx_data;
logic                             pipe7_l00_tx_data_valid;
logic                             pipe7_l00_tx_det_rx_lpbk;
logic                             pipe7_l00_tx_elec_idle;

logic [7:0]                       pipe7_l00_m2p_messagebus;
logic [7:0]                       pipe7_l00_p2m_messagebus;

//TODO
//input         pipe_l00_rx_elec_idle_det_dis,

// *******************************
// Serdes PIPE - Lane1 Signals
// *******************************
logic                             pipe7_l01_clk;
logic [1:0]                       pipe7_l01_rate;

logic                             pipe7_l01_phy_status;
logic                             pipe7_l01_rx_clk;
logic [39:0]                      pipe7_l01_rx_data;
logic                             pipe7_l01_rx_valid;
logic                             pipe7_l01_rx_standby_status;
logic                             pipe7_l01_rx_elec_idle;

logic                             pipe7_l01_rx_termination;
logic                             pipe7_l01_rx_standby;

logic [2:0]                       pipe7_l01_powerdown;
logic [39:0]                      pipe7_l01_tx_data;
logic                             pipe7_l01_tx_data_valid;
logic                             pipe7_l01_tx_det_rx_lpbk;
logic                             pipe7_l01_tx_elec_idle;

logic [7:0]                       pipe7_l01_m2p_messagebus;
logic [7:0]                       pipe7_l01_p2m_messagebus;

// *******************************
// Raw interface - Link Signals
// *******************************
logic                             pma_cmn_ready;
logic                             pma_xcvr_pllclk_en_ack;
logic [5:0]                       pma_xcvr_power_state_ack;
logic                             pma_cmn_avdd_pwrgood;

logic                             pma_xcvr_pllclk_en;
logic [5:0]                       pma_xcvr_power_state_req;
logic [2:0]                       pma_xcvr_data_width;

logic                             dp_reset_n;
logic                             pma_tx_td_clk;

logic                             pma_tx_lfps_en;   //New added for Mac to transmit LFPS
logic                             pma_tx_lfps_mode; //New added for Mac to transmit LFPS


// *******************************
// Raw interface - Lane0 Signals
// *******************************
logic                             pma_tx_elec_idle_ln_0;
logic [31:0]                      pma_tx_td_ln_0;

// *******************************
// Raw interface - Lane1 Signals
// *******************************
logic                             pma_tx_elec_idle_ln_1;
logic [31:0]                      pma_tx_td_ln_1;

// *******************************
// Raw interface - Lane2 Signals
// *******************************
logic                             pma_tx_elec_idle_ln_2;
logic [31:0]                      pma_tx_td_ln_2;

// *******************************
// Raw interface - Lane3 Signals
// *******************************
logic                             pma_tx_elec_idle_ln_3;
logic [31:0]                      pma_tx_td_ln_3;

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

logic                             usb_datart_clk;
logic                             usb_fullrt_clk;
logic                             dp_datart_clk;
logic                             dp_fullrt_clk;

logic                             pma_cmn_refclk0_int;
logic                             pma_cmn_refclk1_int;
logic [1:0]                       pma_cmn_refclk_dig_div;
logic                             pma_cmn_refclk_dig_sel;
logic [1:0]                       pma_cmn_pll0_refclk_sel;
logic [1:0]                       pma_cmn_pll1_refclk_sel;


assign typec_conn_dir = flip ? 1 : 0;


//------------------------------------------------------------------------
// B2B PHY DEVICE
//------------------------------------------------------------------------

// *******************************
// dut related pins and connections
// *******************************
`ifdef CDNS_PHY_PWR_AWARE

// *******************************
// Power pins
// *******************************
wire                           device_agnd       = 1'b0;
wire                           device_avdd_clk   = 1'b1;
wire                           device_avdd_h     = 1'b1;
wire                           device_avdd       = 1'b1;
wire                           device_avdd_tx0   = 1'b1;
wire                           device_avdd_tx1   = 1'b1;
wire                           device_avdd_tx2   = 1'b1;
wire                           device_avdd_tx3   = 1'b1;
wire                           device_avdd_rx    = 1'b1;
wire                           device_cmn_aonvdd = 1'b1;

`endif

// *******************************
// External pins (bumps)
// *******************************
wire                             device_tx_p_ln_0;
wire                             device_tx_m_ln_0;

wire                             device_rx_p_ln_1;
wire                             device_rx_m_ln_1;

wire                             device_rx_p_ln_2;
wire                             device_rx_m_ln_2;

wire                             device_tx_p_ln_3;
wire                             device_tx_m_ln_3;

wire                             device_cmn_rext;

`ifndef MP_PHY_NO_ATB
wire                             device_pma_atb_core_0;
wire                             device_pma_atb_core_1;
`endif

// *******************************
// uC related interface
// *******************************

logic                             device_phy_uc_init_complete;
logic                             device_phy_error_interrupt;

// *******************************
// PHY interface
// *******************************
logic                             device_typec_conn_dir;

logic                             device_phy_interrupt_usb;
logic                             device_phy_interrupt_dp;

logic [3:0]                       device_phy_mode;
logic                             device_pipe_32bit_en=1; //TODO

logic                             device_phy_l00_ctlr_interrupt_in;
logic                             device_phy_l01_ctlr_interrupt_in;

// *******************************
// Original PIPE interface
// For USB3 or PCIe1/2/3/4
// *******************************
logic                             device_pipe4_clk;
logic                             device_pipe4_reset_n;
logic                             device_pipe4_rate;
logic [1:0]                       device_pipe4_powerdown;
logic                             device_pipe4_eb_mode;
//input                            pipe4_width, //Reserved for 16-bit data width.

// *******************************
// Original PIPE - Lane0 Signals
// *******************************
logic                             device_pipe4_l00_phy_status;
logic [31:0]                      device_pipe4_l00_rx_data;
logic [3:0]                       device_pipe4_l00_rx_data_k;
logic [3:0]                       device_pipe4_l00_rx_sync_header;
logic                             device_pipe4_l00_rx_start_block;
logic                             device_pipe4_l00_rx_data_valid;
logic                             device_pipe4_l00_rx_valid;
logic [2:0]                       device_pipe4_l00_rx_status;
logic                             device_pipe4_l00_rx_elec_idle;

logic                             device_pipe4_l00_rx_polarity;
logic                             device_pipe4_l00_rx_termination;
logic                             device_pipe4_l00_rx_eq_training;

logic [31:0]                      device_pipe4_l00_tx_data;
logic [3:0]                       device_pipe4_l00_tx_data_k;
logic [3:0]                       device_pipe4_l00_tx_sync_header;
logic                             device_pipe4_l00_tx_start_block;
logic                             device_pipe4_l00_tx_data_valid;
logic                             device_pipe4_l00_tx_det_rx_lpbk;
logic                             device_pipe4_l00_tx_elec_idle;
logic                             device_pipe4_l00_tx_ones_zeros;
logic                             device_pipe4_l00_tx_128b_enc_byp;
logic [1:0]                       device_pipe4_l00_tx_deemph;

// *******************************
// Original PIPE - Lane1 Signals
// *******************************
logic                             device_pipe4_l01_phy_status;
logic [31:0]                      device_pipe4_l01_rx_data;
logic [3:0]                       device_pipe4_l01_rx_data_k;
logic [3:0]                       device_pipe4_l01_rx_sync_header;
logic                             device_pipe4_l01_rx_start_block;
logic                             device_pipe4_l01_rx_data_valid;
logic                             device_pipe4_l01_rx_valid;
logic [2:0]                       device_pipe4_l01_rx_status;
logic                             device_pipe4_l01_rx_elec_idle;
                                         
logic                             device_pipe4_l01_rx_polarity;
logic                             device_pipe4_l01_rx_termination;
logic                             device_pipe4_l01_rx_eq_training;
                                         
logic [31:0]                      device_pipe4_l01_tx_data;
logic [3:0]                       device_pipe4_l01_tx_data_k;
logic [3:0]                       device_pipe4_l01_tx_sync_header;
logic                             device_pipe4_l01_tx_start_block;
logic                             device_pipe4_l01_tx_data_valid;
logic                             device_pipe4_l01_tx_det_rx_lpbk;
logic                             device_pipe4_l01_tx_elec_idle;
logic                             device_pipe4_l01_tx_ones_zeros;
logic                             device_pipe4_l01_tx_128b_enc_byp;
logic [1:0]                       device_pipe4_l01_tx_deemph;

// *******************************
// Serdes PIPE interface
// For USB4
// *******************************
logic                             device_pipe7_clk_max;
logic                             device_pipe7_clk_max_req;
logic                             device_pipe7_clk_max_ack;

logic                             device_pipe7_pll0_en; //For USB4 Serdes Arch only
logic                             device_pipe7_pll0_ok; //For USB4 Serdes Arch only

logic                             device_pipe7_reset_n;
//input  [1:0]                     pipe7_tx_width, // Support 40bit only
//input  [1:0]                     pipe7_rx_width, // Support 40bit only

// *******************************
// Serdes PIPE - Lane0 Signals
// *******************************
logic                             device_pipe7_l00_clk;
logic                             device_pipe7_clk_div=0;
logic [1:0]                       device_pipe7_l00_rate;

logic                             device_pipe7_l00_phy_status;
logic                             device_pipe7_l00_rx_clk;
logic [39:0]                      device_pipe7_l00_rx_data;
logic                             device_pipe7_l00_rx_valid;
logic                             device_pipe7_l00_rx_standby_status;
logic                             device_pipe7_l00_rx_elec_idle;

logic                             device_pipe7_l00_rx_termination;
logic                             device_pipe7_l00_rx_standby;

logic [2:0]                       device_pipe7_l00_powerdown;
logic [39:0]                      device_pipe7_l00_tx_data;
logic                             device_pipe7_l00_tx_data_valid;
logic                             device_pipe7_l00_tx_det_rx_lpbk;
logic                             device_pipe7_l00_tx_elec_idle;

logic [7:0]                       device_pipe7_l00_m2p_messagebus;
logic [7:0]                       device_pipe7_l00_p2m_messagebus;

//TODO
//input         pipe_l00_rx_elec_idle_det_dis,

// *******************************
// Serdes PIPE - Lane1 Signals
// *******************************
logic                             device_pipe7_l01_clk;
logic [1:0]                       device_pipe7_l01_rate;

logic                             device_pipe7_l01_phy_status;
logic                             device_pipe7_l01_rx_clk;
logic [39:0]                      device_pipe7_l01_rx_data;
logic                             device_pipe7_l01_rx_valid;
logic                             device_pipe7_l01_rx_standby_status;
logic                             device_pipe7_l01_rx_elec_idle;
                                         
logic                             device_pipe7_l01_rx_termination;
logic                             device_pipe7_l01_rx_standby;
                                         
logic [2:0]                       device_pipe7_l01_powerdown;
logic [39:0]                      device_pipe7_l01_tx_data;
logic                             device_pipe7_l01_tx_data_valid;
logic                             device_pipe7_l01_tx_det_rx_lpbk;
logic                             device_pipe7_l01_tx_elec_idle;
                                         
logic [7:0]                       device_pipe7_l01_m2p_messagebus;
logic [7:0]                       device_pipe7_l01_p2m_messagebus;

// *******************************
// Raw interface - Link Signals
// *******************************
logic                             device_pma_cmn_ready;
logic                             device_pma_xcvr_pllclk_en_ack;
logic [5:0]                       device_pma_xcvr_power_state_ack;
logic                             device_pma_cmn_avdd_pwrgood;

logic                             device_pma_xcvr_pllclk_en;
logic [5:0]                       device_pma_xcvr_power_state_req;
logic [2:0]                       device_pma_xcvr_data_width;

logic                             device_dp_reset_n;
logic                             device_pma_tx_td_clk;

logic                             device_pma_tx_lfps_en;   //New added for Mac to transmit LFPS
logic                             device_pma_tx_lfps_mode; //New added for Mac to transmit LFPS


// *******************************
// Raw interface - Lane0 Signals
// *******************************
logic                             device_pma_tx_elec_idle_ln_0;
logic [31:0]                      device_pma_tx_td_ln_0;

// *******************************
// Raw interface - Lane1 Signals
// *******************************
logic                             device_pma_tx_elec_idle_ln_1;
logic [31:0]                      device_pma_tx_td_ln_1;

// *******************************
// Raw interface - Lane2 Signals
// *******************************
logic                             device_pma_tx_elec_idle_ln_2;
logic [31:0]                      device_pma_tx_td_ln_2;

// *******************************
// Raw interface - Lane3 Signals
// *******************************
logic                             device_pma_tx_elec_idle_ln_3;
logic [31:0]                      device_pma_tx_td_ln_3;

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

logic                             device_usb_datart_clk;
logic                             device_usb_fullrt_clk;
logic                             device_dp_datart_clk;
logic                             device_dp_fullrt_clk;

logic                             device_pma_cmn_refclk0_int;
logic                             device_pma_cmn_refclk1_int;
logic [1:0]                       device_pma_cmn_refclk_dig_div;
logic                             device_pma_cmn_refclk_dig_sel;
logic [1:0]                       device_pma_cmn_pll0_refclk_sel;
logic [1:0]                       device_pma_cmn_pll1_refclk_sel;


//assign device_typec_conn_dir = flip ? 1 : 0; // TODO, to be confirmed whether only the host phy is flipped.
assign device_typec_conn_dir = 0;


//------------------------------------------------------------------------
// External pins (bumps) CONNECTIONS
//------------------------------------------------------------------------
`ifdef DP
assign host_tx2p = tx_p_ln_0;
assign host_tx2n = tx_m_ln_0;
assign host_tx3p = rx_p_ln_1;
assign host_tx3n = rx_m_ln_1;
assign host_tx0p = rx_p_ln_2;
assign host_tx0n = rx_m_ln_2;
assign host_tx1p = tx_p_ln_3;
assign host_tx1n = tx_m_ln_3;
`elsif ALT_MODE
assign rx_p_ln_1 = host_rx0p; 
assign rx_m_ln_1 = host_rx0n; 
assign host_tx0p = tx_p_ln_0;
assign host_tx0n = tx_m_ln_0;
assign host_tx2p = rx_p_ln_2;
assign host_tx2n = rx_m_ln_2;
assign host_tx3p = tx_p_ln_3;
assign host_tx3n = tx_m_ln_3;
`else
assign rx_p_ln_1 = host_rx0p; 
assign rx_m_ln_1 = host_rx0n; 
assign rx_p_ln_2 = host_rx1p; 
assign rx_m_ln_2 = host_rx1n; 
assign host_tx0p = tx_p_ln_0;
assign host_tx0n = tx_m_ln_0;
assign host_tx1p = tx_p_ln_3;
assign host_tx1n = tx_m_ln_3;
`endif
//assign cmn_rext = ; // TODO

//------------------------------------------------------------------------
// USB32 CONNECTIONS
//------------------------------------------------------------------------
`ifdef USB32
// PHY interface
assign phy_mode       = `USB32_HOST_LANE0.pipe_intf.phy_mode;

// B2B/Single PHY Serial Connections
`ifdef B2B_MODE
assign devc_tx0p = device_tx_p_ln_0;
assign devc_tx0n = device_tx_m_ln_0;
assign devc_tx1p = device_tx_p_ln_3;
assign devc_tx1n = device_tx_m_ln_3;
assign device_rx_p_ln_1 = devc_rx0p;
assign device_rx_m_ln_1 = devc_rx0n;
assign device_rx_p_ln_2 = devc_rx1p;
assign device_rx_m_ln_2 = devc_rx1n;
`else
assign devc_tx0p = `USB32_DEVC_LANE0.serdes_tx.serial_p;
assign devc_tx0n = `USB32_DEVC_LANE0.serdes_tx.serial_n;
assign devc_tx1p = `USB32_DEVC_LANE1.serdes_tx.serial_p;
assign devc_tx1n = `USB32_DEVC_LANE1.serdes_tx.serial_n;
assign `USB32_DEVC_LANE0.serdes_rx.serial_p  = devc_rx0p;
assign `USB32_DEVC_LANE0.serdes_rx.serial_n  = devc_rx0n;
assign `USB32_DEVC_LANE1.serdes_rx.serial_p  = devc_rx1p;
assign `USB32_DEVC_LANE1.serdes_rx.serial_n  = devc_rx1n;
`endif

// Original PIPE interface, For USB3 or PCIe1/2/3/4
assign `USB32_HOST_LANE0.pclk = pipe4_clk; // TODO
assign `USB32_HOST_LANE1.pclk = pipe4_clk; // TODO
`ifndef B2B_MODE
assign `USB32_DEVC_LANE0.pclk = clk_io.drv_clk_gen[0]; // TODO
assign `USB32_DEVC_LANE1.pclk = clk_io.drv_clk_gen[0]; // TODO
`endif
assign pipe4_reset_n   = `USB32_HOST_LANE0.pipe_intf.Reset;
assign pipe4_rate      = `USB32_HOST_LANE0.pipe_intf.Rate[0];
assign pipe4_powerdown = `USB32_HOST_LANE0.pipe_intf.PowerDown[1:0];
assign pipe4_eb_mode   = `USB32_HOST_LANE0.pipe_intf.pipe4_eb_mode;

// Original PIPE - Lane0 Signals
assign pipe4_l00_rx_polarity     = `USB32_HOST_LANE0.pipe_intf.pipe4_rx_polarity;
assign pipe4_l00_rx_eq_training  = `USB32_HOST_LANE0.pipe_intf.pipe4_rx_eq_training;
assign pipe4_l00_rx_termination  = `USB32_HOST_LANE0.pipe_intf.RXTermination;
assign pipe4_l00_tx_data         = `USB32_HOST_LANE0.pipe_intf.TxData;
assign pipe4_l00_tx_data_k       = `USB32_HOST_LANE0.pipe_intf.TxDataK;  
assign pipe4_l00_tx_sync_header  = `USB32_HOST_LANE0.pipe_intf.TxSyncHeader;
assign pipe4_l00_tx_start_block  = `USB32_HOST_LANE0.pipe_intf.TxStartBlock;
assign pipe4_l00_tx_data_valid   = `USB32_HOST_LANE0.pipe_intf.TxDataValid;
assign pipe4_l00_tx_det_rx_lpbk  = `USB32_HOST_LANE0.pipe_intf.TxDetectRx;
assign pipe4_l00_tx_elec_idle    = `USB32_HOST_LANE0.pipe_intf.TxElecIdle;
assign pipe4_l00_tx_ones_zeros   = `USB32_HOST_LANE0.pipe_intf.pipe4_tx_ones_zeros;
assign pipe4_l00_tx_128b_enc_byp = `USB32_HOST_LANE0.pipe_intf.pipe4_tx_128b_enc_byp;
assign pipe4_l00_tx_deemph       = `USB32_HOST_LANE0.pipe_intf.pipe4_tx_deemph;

assign `USB32_HOST_LANE0.pipe_intf.PhyStatus     = pipe4_l00_phy_status;
assign `USB32_HOST_LANE0.pipe_intf.RxData        = pipe4_l00_rx_data;
assign `USB32_HOST_LANE0.pipe_intf.RxDataK       = pipe4_l00_rx_data_k;
assign `USB32_HOST_LANE0.pipe_intf.RxSyncHeader  = pipe4_l00_rx_sync_header;
assign `USB32_HOST_LANE0.pipe_intf.RxStartBlock  = pipe4_l00_rx_start_block;
assign `USB32_HOST_LANE0.pipe_intf.RxDataValid   = pipe4_l00_rx_data_valid;
assign `USB32_HOST_LANE0.pipe_intf.RxValid       = pipe4_l00_rx_valid;
assign `USB32_HOST_LANE0.pipe_intf.RxStatus      = pipe4_l00_rx_status;
assign `USB32_HOST_LANE0.pipe_intf.RxElecIdle    = pipe4_l00_rx_elec_idle;

// Original PIPE - Lane1 Signals
assign pipe4_l01_rx_polarity     = `USB32_HOST_LANE1.pipe_intf.pipe4_rx_polarity;
assign pipe4_l01_rx_eq_training  = `USB32_HOST_LANE1.pipe_intf.pipe4_rx_eq_training;
assign pipe4_l01_rx_termination  = `USB32_HOST_LANE1.pipe_intf.RXTermination;
assign pipe4_l01_tx_data         = `USB32_HOST_LANE1.pipe_intf.TxData;  
assign pipe4_l01_tx_data_k       = `USB32_HOST_LANE1.pipe_intf.TxDataK;  
assign pipe4_l01_tx_sync_header  = `USB32_HOST_LANE1.pipe_intf.TxSyncHeader;  
assign pipe4_l01_tx_start_block  = `USB32_HOST_LANE1.pipe_intf.TxStartBlock;  
assign pipe4_l01_tx_data_valid   = `USB32_HOST_LANE1.pipe_intf.TxDataValid;  
assign pipe4_l01_tx_det_rx_lpbk  = `USB32_HOST_LANE1.pipe_intf.TxDetectRx;
assign pipe4_l01_tx_elec_idle    = `USB32_HOST_LANE1.pipe_intf.TxElecIdle;  
assign pipe4_l01_tx_ones_zeros   = `USB32_HOST_LANE1.pipe_intf.pipe4_tx_ones_zeros;
assign pipe4_l01_tx_128b_enc_byp = `USB32_HOST_LANE1.pipe_intf.pipe4_tx_128b_enc_byp;
assign pipe4_l01_tx_deemph       = `USB32_HOST_LANE1.pipe_intf.pipe4_tx_deemph;

assign `USB32_HOST_LANE1.pipe_intf.PhyStatus     = pipe4_l01_phy_status;
assign `USB32_HOST_LANE1.pipe_intf.RxData        = pipe4_l01_rx_data;
assign `USB32_HOST_LANE1.pipe_intf.RxDataK       = pipe4_l01_rx_data_k;
assign `USB32_HOST_LANE1.pipe_intf.RxSyncHeader  = pipe4_l01_rx_sync_header;
assign `USB32_HOST_LANE1.pipe_intf.RxStartBlock  = pipe4_l01_rx_start_block;
assign `USB32_HOST_LANE1.pipe_intf.RxDataValid   = pipe4_l01_rx_data_valid;
assign `USB32_HOST_LANE1.pipe_intf.RxValid       = pipe4_l01_rx_valid;
assign `USB32_HOST_LANE1.pipe_intf.RxStatus      = pipe4_l01_rx_status;
assign `USB32_HOST_LANE1.pipe_intf.RxElecIdle    = pipe4_l01_rx_elec_idle;

// PHY/PMA Interface & PMA Clocks
assign pma_cmn_refclk_dig_div  = `USB32_HOST_LANE0.pipe_intf.pma_cmn_refclk_dig_div ;
assign pma_cmn_refclk_dig_sel  = `USB32_HOST_LANE0.pipe_intf.pma_cmn_refclk_dig_sel ;
assign pma_cmn_pll0_refclk_sel = `USB32_HOST_LANE0.pipe_intf.pma_cmn_pll0_refclk_sel;
assign pma_cmn_pll1_refclk_sel = `USB32_HOST_LANE0.pipe_intf.pma_cmn_pll1_refclk_sel;

// SPACE PINS, Note! assign these pins to init_intf
assign pipe7_reset_n             = `USB32_HOST_LANE0.init_intf.Reset;
assign pipe7_clk_max_req         = `USB32_HOST_LANE0.init_intf.pipe7_clk_max_req;
assign pipe7_pll0_en             = `USB32_HOST_LANE0.init_intf.pipe7_pll0_en;

assign pipe7_l00_clk             = 0;
assign pipe7_l00_m2p_messagebus  = `USB32_HOST_LANE0.init_intf.M2P_MessageBus;
assign pipe7_l00_rate            = `USB32_HOST_LANE0.init_intf.Rate[1:0];
assign pipe7_l00_rx_termination  = `USB32_HOST_LANE0.init_intf.RXTermination;
assign pipe7_l00_rx_standby      = `USB32_HOST_LANE0.init_intf.RxStandby;
assign pipe7_l00_powerdown       = `USB32_HOST_LANE0.init_intf.PowerDown[2:0];
assign pipe7_l00_tx_data         = `USB32_HOST_LANE0.init_intf.TxData;
assign pipe7_l00_tx_data_valid   = `USB32_HOST_LANE0.init_intf.TxDataValid;
assign pipe7_l00_tx_det_rx_lpbk  = `USB32_HOST_LANE0.init_intf.TxDetectRx;
assign pipe7_l00_tx_elec_idle    = `USB32_HOST_LANE0.init_intf.TxElecIdle;

assign pipe7_l01_clk             = 0;
assign pipe7_l01_m2p_messagebus  = `USB32_HOST_LANE1.init_intf.M2P_MessageBus; 
assign pipe7_l01_rate            = `USB32_HOST_LANE1.init_intf.Rate[1:0];
assign pipe7_l01_rx_termination  = `USB32_HOST_LANE1.init_intf.RXTermination;
assign pipe7_l01_rx_standby      = `USB32_HOST_LANE1.init_intf.RxStandby;
assign pipe7_l01_powerdown       = `USB32_HOST_LANE1.init_intf.PowerDown[2:0];
assign pipe7_l01_tx_data         = `USB32_HOST_LANE1.init_intf.TxData;
assign pipe7_l01_tx_data_valid   = `USB32_HOST_LANE1.init_intf.TxDataValid;
assign pipe7_l01_tx_det_rx_lpbk  = `USB32_HOST_LANE1.init_intf.TxDetectRx;
assign pipe7_l01_tx_elec_idle    = `USB32_HOST_LANE1.init_intf.TxElecIdle;

assign dp_reset_n                = `USB32_HOST_LANE0.init_intf.dp_reset_n;
assign pma_xcvr_pllclk_en        = `USB32_HOST_LANE0.init_intf.pma_xcvr_pllclk_en;
assign pma_xcvr_power_state_req  = `USB32_HOST_LANE0.init_intf.pma_xcvr_power_state_req;
assign pma_xcvr_data_width       = `USB32_HOST_LANE0.init_intf.pma_xcvr_data_width;
assign pma_tx_td_clk             = `USB32_HOST_LANE0.init_intf.pma_tx_td_clk;
assign pma_tx_lfps_en            = `USB32_HOST_LANE0.init_intf.pma_tx_lfps_en;
assign pma_tx_lfps_mode          = `USB32_HOST_LANE0.init_intf.pma_tx_lfps_mode;
assign pma_tx_elec_idle_ln_0     = `USB32_HOST_LANE0.init_intf.pma_tx_elec_idle_ln;
assign pma_tx_td_ln_0            = `USB32_HOST_LANE0.init_intf.pma_tx_td_ln;
assign pma_tx_elec_idle_ln_1     = `USB32_HOST_LANE1.init_intf.pma_tx_elec_idle_ln;
assign pma_tx_td_ln_1            = `USB32_HOST_LANE1.init_intf.pma_tx_td_ln;
assign pma_tx_elec_idle_ln_2     = `USB32_HOST_LANE0.init_intf.pma_tx_elec_idle_ln;
assign pma_tx_td_ln_2            = `USB32_HOST_LANE0.init_intf.pma_tx_td_ln;
assign pma_tx_elec_idle_ln_3     = `USB32_HOST_LANE1.init_intf.pma_tx_elec_idle_ln;
assign pma_tx_td_ln_3            = `USB32_HOST_LANE1.init_intf.pma_tx_td_ln;

//------------------------------------------------------------------------
// USB4 CONNECTIONS
//------------------------------------------------------------------------
`elsif USB4
// PHY interface
assign phy_mode       = `USB4_HOST_LANE0.pipe_intf.phy_mode;

// B2B/Single PHY Serial Connections
`ifdef B2B_MODE
assign devc_tx0p = device_tx_p_ln_0;
assign devc_tx0n = device_tx_m_ln_0;
assign devc_tx1p = device_tx_p_ln_3;
assign devc_tx1n = device_tx_m_ln_3;
assign device_rx_p_ln_1 = devc_rx0p;
assign device_rx_m_ln_1 = devc_rx0n;
assign device_rx_p_ln_2 = devc_rx1p;
assign device_rx_m_ln_2 = devc_rx1n;
`else
assign devc_tx0p = `USB4_DEVC_LANE0.serdes_tx.serial_p;
assign devc_tx0n = `USB4_DEVC_LANE0.serdes_tx.serial_n;
assign devc_tx1p = `USB4_DEVC_LANE1.serdes_tx.serial_p;
assign devc_tx1n = `USB4_DEVC_LANE1.serdes_tx.serial_n;
assign `USB4_DEVC_LANE0.serdes_rx.serial_p  = devc_rx0p;
assign `USB4_DEVC_LANE0.serdes_rx.serial_n  = devc_rx0n;
assign `USB4_DEVC_LANE1.serdes_rx.serial_p  = devc_rx1p;
assign `USB4_DEVC_LANE1.serdes_rx.serial_n  = devc_rx1n;
`endif

// Serdes PIPE interface, For USB4
assign `USB4_HOST_LANE0.pipe_intf.pipe7_clk_max = pipe7_clk_max;
assign pipe7_clk_max_req = `USB4_HOST_LANE0.pipe_intf.pipe7_clk_max_req;
assign `USB4_HOST_LANE0.pipe_intf.pipe7_clk_max_ack = pipe7_clk_max_ack;
assign pipe7_pll0_en = `USB4_HOST_LANE0.pipe_intf.pipe7_pll0_en;
assign `USB4_HOST_LANE0.pipe_intf.pipe7_pll0_ok = pipe7_pll0_ok;
assign pipe7_reset_n = `USB4_HOST_LANE0.pipe_intf.Reset;

always @(posedge pipe7_clk_max) begin
        pipe7_clk_div <= ~pipe7_clk_div;
end

assign pipe7_l00_clk = `USB4_HOST_LANE0.pipe_intf.Rate ? pipe7_clk_max : pipe7_clk_div;
assign pipe7_l01_clk = `USB4_HOST_LANE1.pipe_intf.Rate ? pipe7_clk_max : pipe7_clk_div;

assign `USB4_HOST_LANE0.pclk = pipe7_l00_clk;
assign `USB4_HOST_LANE1.pclk = pipe7_l01_clk;
`ifndef B2B_MODE
assign `USB4_DEVC_LANE0.pclk = clk_io.drv_clk_gen[0];
assign `USB4_DEVC_LANE1.pclk = clk_io.drv_clk_gen[0];
`endif

// Serdes PIPE - Lane0 Signals
//assign pipe7_l00_clk  = `USB4_HOST_LANE0.pclk;
assign pipe7_l00_rate = `USB4_HOST_LANE0.pipe_intf.Rate[1:0];

assign `USB4_HOST_LANE0.pipe_intf.PhyStatus       = pipe7_l00_phy_status;
assign `USB4_HOST_LANE0.pipe_intf.RxCLK           = pipe7_l00_rx_clk;
assign `USB4_HOST_LANE0.pipe_intf.RxData          = pipe7_l00_rx_data;
assign `USB4_HOST_LANE0.pipe_intf.RxValid         = pipe7_l00_rx_valid;
assign `USB4_HOST_LANE0.pipe_intf.RxStandbyStatus = pipe7_l00_rx_standby_status;
assign `USB4_HOST_LANE0.pipe_intf.RxElecIdle      = pipe7_l00_rx_elec_idle;

assign pipe7_l00_rx_termination  = `USB4_HOST_LANE0.pipe_intf.RXTermination;
assign pipe7_l00_rx_standby      = `USB4_HOST_LANE0.pipe_intf.RxStandby;
assign pipe7_l00_powerdown       = `USB4_HOST_LANE0.pipe_intf.PowerDown[2:0];
assign pipe7_l00_tx_data         = `USB4_HOST_LANE0.pipe_intf.TxData;
assign pipe7_l00_tx_data_valid   = `USB4_HOST_LANE0.pipe_intf.TxDataValid;
assign pipe7_l00_tx_det_rx_lpbk  = `USB4_HOST_LANE0.pipe_intf.TxDetectRx;
assign pipe7_l00_tx_elec_idle    = `USB4_HOST_LANE0.pipe_intf.TxElecIdle;
assign pipe7_l00_m2p_messagebus  = `USB4_HOST_LANE0.pipe_intf.M2P_MessageBus; 
assign `USB4_HOST_LANE0.pipe_intf.P2M_MessageBus= pipe7_l00_p2m_messagebus; 

// Serdes PIPE - Lane1 Signals
//assign pipe7_l01_clk  = `USB4_HOST_LANE1.pclk;
assign pipe7_l01_rate = `USB4_HOST_LANE1.pipe_intf.Rate[1:0];

assign `USB4_HOST_LANE1.pipe_intf.PhyStatus       = pipe7_l01_phy_status;
assign `USB4_HOST_LANE1.pipe_intf.RxCLK           = pipe7_l01_rx_clk;
assign `USB4_HOST_LANE1.pipe_intf.RxData          = pipe7_l01_rx_data;
assign `USB4_HOST_LANE1.pipe_intf.RxValid         = pipe7_l01_rx_valid;
assign `USB4_HOST_LANE1.pipe_intf.RxStandbyStatus = pipe7_l01_rx_standby_status;
assign `USB4_HOST_LANE1.pipe_intf.RxElecIdle      = pipe7_l01_rx_elec_idle;

assign pipe7_l01_rx_termination  = `USB4_HOST_LANE1.pipe_intf.RXTermination;
assign pipe7_l01_rx_standby      = `USB4_HOST_LANE1.pipe_intf.RxStandby;
assign pipe7_l01_powerdown       = `USB4_HOST_LANE1.pipe_intf.PowerDown[2:0];
assign pipe7_l01_tx_data         = `USB4_HOST_LANE1.pipe_intf.TxData;
assign pipe7_l01_tx_data_valid   = `USB4_HOST_LANE1.pipe_intf.TxDataValid;
assign pipe7_l01_tx_det_rx_lpbk  = `USB4_HOST_LANE1.pipe_intf.TxDetectRx;
assign pipe7_l01_tx_elec_idle    = `USB4_HOST_LANE1.pipe_intf.TxElecIdle;
assign pipe7_l01_m2p_messagebus  = `USB4_HOST_LANE1.pipe_intf.M2P_MessageBus;
assign `USB4_HOST_LANE1.pipe_intf.P2M_MessageBus = pipe7_l01_p2m_messagebus; 

// PHY/PMA Interface & PMA Clocks
assign pma_cmn_refclk_dig_div  = `USB4_HOST_LANE0.pipe_intf.pma_cmn_refclk_dig_div ;
assign pma_cmn_refclk_dig_sel  = `USB4_HOST_LANE0.pipe_intf.pma_cmn_refclk_dig_sel ;
assign pma_cmn_pll0_refclk_sel = `USB4_HOST_LANE0.pipe_intf.pma_cmn_pll0_refclk_sel;
assign pma_cmn_pll1_refclk_sel = `USB4_HOST_LANE0.pipe_intf.pma_cmn_pll1_refclk_sel;

// SPACE PINS, Note! assign these pins to init_intf
assign pipe4_reset_n             = `USB4_HOST_LANE0.init_intf.Reset;
assign pipe4_rate                = `USB4_HOST_LANE0.init_intf.Rate[0];
assign pipe4_powerdown           = `USB4_HOST_LANE0.init_intf.PowerDown[1:0];
assign pipe4_eb_mode             = `USB4_HOST_LANE0.init_intf.pipe4_eb_mode;

assign pipe4_l00_rx_polarity     = `USB4_HOST_LANE0.init_intf.pipe4_rx_polarity;
assign pipe4_l00_rx_eq_training  = `USB4_HOST_LANE0.init_intf.pipe4_rx_eq_training;
assign pipe4_l00_rx_termination  = `USB4_HOST_LANE0.init_intf.RXTermination;
assign pipe4_l00_tx_data         = `USB4_HOST_LANE0.init_intf.TxData;
assign pipe4_l00_tx_data_k       = `USB4_HOST_LANE0.init_intf.TxDataK;  
assign pipe4_l00_tx_sync_header  = `USB4_HOST_LANE0.init_intf.TxSyncHeader;
assign pipe4_l00_tx_start_block  = `USB4_HOST_LANE0.init_intf.TxStartBlock;
assign pipe4_l00_tx_data_valid   = `USB4_HOST_LANE0.init_intf.TxDataValid;
assign pipe4_l00_tx_det_rx_lpbk  = `USB4_HOST_LANE0.init_intf.TxDetectRx;
assign pipe4_l00_tx_elec_idle    = `USB4_HOST_LANE0.init_intf.TxElecIdle;
assign pipe4_l00_tx_ones_zeros   = `USB4_HOST_LANE0.init_intf.pipe4_tx_ones_zeros;
assign pipe4_l00_tx_128b_enc_byp = `USB4_HOST_LANE0.init_intf.pipe4_tx_128b_enc_byp;
assign pipe4_l00_tx_deemph       = `USB4_HOST_LANE0.init_intf.pipe4_tx_deemph;

assign pipe4_l01_rx_polarity     = `USB4_HOST_LANE1.init_intf.pipe4_rx_polarity;
assign pipe4_l01_rx_eq_training  = `USB4_HOST_LANE1.init_intf.pipe4_rx_eq_training;
assign pipe4_l01_rx_termination  = `USB4_HOST_LANE1.init_intf.RXTermination;
assign pipe4_l01_tx_data         = `USB4_HOST_LANE1.init_intf.TxData;  
assign pipe4_l01_tx_data_k       = `USB4_HOST_LANE1.init_intf.TxDataK;  
assign pipe4_l01_tx_sync_header  = `USB4_HOST_LANE1.init_intf.TxSyncHeader;  
assign pipe4_l01_tx_start_block  = `USB4_HOST_LANE1.init_intf.TxStartBlock;  
assign pipe4_l01_tx_data_valid   = `USB4_HOST_LANE1.init_intf.TxDataValid;  
assign pipe4_l01_tx_det_rx_lpbk  = `USB4_HOST_LANE1.init_intf.TxDetectRx;
assign pipe4_l01_tx_elec_idle    = `USB4_HOST_LANE1.init_intf.TxElecIdle;  
assign pipe4_l01_tx_ones_zeros   = `USB4_HOST_LANE1.init_intf.pipe4_tx_ones_zeros;
assign pipe4_l01_tx_128b_enc_byp = `USB4_HOST_LANE1.init_intf.pipe4_tx_128b_enc_byp;
assign pipe4_l01_tx_deemph       = `USB4_HOST_LANE1.init_intf.pipe4_tx_deemph;

assign dp_reset_n                = `USB4_HOST_LANE0.init_intf.dp_reset_n;
assign pma_xcvr_pllclk_en        = `USB4_HOST_LANE0.init_intf.pma_xcvr_pllclk_en;
assign pma_xcvr_power_state_req  = `USB4_HOST_LANE0.init_intf.pma_xcvr_power_state_req;
assign pma_xcvr_data_width       = `USB4_HOST_LANE0.init_intf.pma_xcvr_data_width;
assign pma_tx_td_clk             = `USB4_HOST_LANE0.init_intf.pma_tx_td_clk;
assign pma_tx_lfps_en            = `USB4_HOST_LANE0.init_intf.pma_tx_lfps_en;
assign pma_tx_lfps_mode          = `USB4_HOST_LANE0.init_intf.pma_tx_lfps_mode;
assign pma_tx_elec_idle_ln_0     = `USB4_HOST_LANE0.init_intf.pma_tx_elec_idle_ln;
assign pma_tx_td_ln_0            = `USB4_HOST_LANE0.init_intf.pma_tx_td_ln;
assign pma_tx_elec_idle_ln_1     = `USB4_HOST_LANE1.init_intf.pma_tx_elec_idle_ln;
assign pma_tx_td_ln_1            = `USB4_HOST_LANE1.init_intf.pma_tx_td_ln;
assign pma_tx_elec_idle_ln_2     = `USB4_HOST_LANE0.init_intf.pma_tx_elec_idle_ln;
assign pma_tx_td_ln_2            = `USB4_HOST_LANE0.init_intf.pma_tx_td_ln;
assign pma_tx_elec_idle_ln_3     = `USB4_HOST_LANE1.init_intf.pma_tx_elec_idle_ln;
assign pma_tx_td_ln_3            = `USB4_HOST_LANE1.init_intf.pma_tx_td_ln;

//------------------------------------------------------------------------
// PCIE CONNECTIONS
//------------------------------------------------------------------------
`elsif PCIE
// PHY interface
assign phy_mode       = `PCIE_HOST_LANE0.pipe_intf.phy_mode;

// B2B/Single PHY Serial Connections
`ifdef B2B_MODE
assign devc_tx0p = device_tx_p_ln_0;
assign devc_tx0n = device_tx_m_ln_0;
assign devc_tx1p = device_tx_p_ln_3;
assign devc_tx1n = device_tx_m_ln_3;
assign device_rx_p_ln_1 = devc_rx0p;
assign device_rx_m_ln_1 = devc_rx0n;
assign device_rx_p_ln_2 = devc_rx1p;
assign device_rx_m_ln_2 = devc_rx1n;
`else
assign devc_tx0p = `PCIE_DEVC_LANE0.serdes_tx.serial_p;
assign devc_tx0n = `PCIE_DEVC_LANE0.serdes_tx.serial_n;
assign devc_tx1p = `PCIE_DEVC_LANE1.serdes_tx.serial_p;
assign devc_tx1n = `PCIE_DEVC_LANE1.serdes_tx.serial_n;
assign `PCIE_DEVC_LANE0.serdes_rx.serial_p  = devc_rx0p;
assign `PCIE_DEVC_LANE0.serdes_rx.serial_n  = devc_rx0n;
assign `PCIE_DEVC_LANE1.serdes_rx.serial_p  = devc_rx1p;
assign `PCIE_DEVC_LANE1.serdes_rx.serial_n  = devc_rx1n;
`endif

// Original PIPE interface, For USB3 or PCIe1/2/3/4
//assign `PCIE_HOST_LANE0.pclk = pipe4_clk; // TODO
assign pipe4_reset_n   = `PCIE_HOST_LANE0.pipe_intf.Reset;
assign pipe4_rate      = `PCIE_HOST_LANE0.pipe_intf.Rate[0];
assign pipe4_powerdown = `PCIE_HOST_LANE0.pipe_intf.PowerDown[1:0];
assign pipe4_eb_mode   = `PCIE_HOST_LANE0.pipe_intf.pipe4_eb_mode;

// Original PIPE - Lane0 Signals
assign pipe4_l00_rx_polarity     = `PCIE_HOST_LANE0.pipe_intf.pipe4_rx_polarity;
assign pipe4_l00_rx_eq_training  = `PCIE_HOST_LANE0.pipe_intf.pipe4_rx_eq_training;
assign pipe4_l00_rx_termination  = `PCIE_HOST_LANE0.pipe_intf.RXTermination;
assign pipe4_l00_tx_data         = `PCIE_HOST_LANE0.pipe_intf.TxData;
assign pipe4_l00_tx_data_k       = `PCIE_HOST_LANE0.pipe_intf.TxDataK;  
assign pipe4_l00_tx_sync_header  = `PCIE_HOST_LANE0.pipe_intf.TxSyncHeader;
assign pipe4_l00_tx_start_block  = `PCIE_HOST_LANE0.pipe_intf.TxStartBlock;
assign pipe4_l00_tx_data_valid   = `PCIE_HOST_LANE0.pipe_intf.TxDataValid;
assign pipe4_l00_tx_det_rx_lpbk  = `PCIE_HOST_LANE0.pipe_intf.TxDetectRx;
assign pipe4_l00_tx_elec_idle    = `PCIE_HOST_LANE0.pipe_intf.TxElecIdle;
assign pipe4_l00_tx_ones_zeros   = `PCIE_HOST_LANE0.pipe_intf.pipe4_tx_ones_zeros;
assign pipe4_l00_tx_128b_enc_byp = `PCIE_HOST_LANE0.pipe_intf.pipe4_tx_128b_enc_byp;
assign pipe4_l00_tx_deemph       = `PCIE_HOST_LANE0.pipe_intf.pipe4_tx_deemph;

assign `PCIE_HOST_LANE0.pipe_intf.PhyStatus     = pipe4_l00_phy_status;
assign `PCIE_HOST_LANE0.pipe_intf.RxData        = pipe4_l00_rx_data;
assign `PCIE_HOST_LANE0.pipe_intf.RxDataK       = pipe4_l00_rx_data_k;
assign `PCIE_HOST_LANE0.pipe_intf.RxSyncHeader  = pipe4_l00_rx_sync_header;
assign `PCIE_HOST_LANE0.pipe_intf.RxStartBlock  = pipe4_l00_rx_start_block;
assign `PCIE_HOST_LANE0.pipe_intf.RxDataValid   = pipe4_l00_rx_data_valid;
assign `PCIE_HOST_LANE0.pipe_intf.RxValid       = pipe4_l00_rx_valid;
assign `PCIE_HOST_LANE0.pipe_intf.RxStatus      = pipe4_l00_rx_status;
assign `PCIE_HOST_LANE0.pipe_intf.RxElecIdle    = pipe4_l00_rx_elec_idle;

// Original PIPE - Lane1 Signals
assign pipe4_l01_rx_polarity    = `PCIE_HOST_LANE1.pipe_intf.pipe4_rx_polarity;
assign pipe4_l01_rx_eq_training = `PCIE_HOST_LANE1.pipe_intf.pipe4_rx_eq_training;
assign pipe4_l01_rx_termination = `PCIE_HOST_LANE1.pipe_intf.RXTermination;
assign pipe4_l01_tx_data        = `PCIE_HOST_LANE1.pipe_intf.TxData;  
assign pipe4_l01_tx_data_k      = `PCIE_HOST_LANE1.pipe_intf.TxDataK;  
assign pipe4_l01_tx_sync_header = `PCIE_HOST_LANE1.pipe_intf.TxSyncHeader;  
assign pipe4_l01_tx_start_block = `PCIE_HOST_LANE1.pipe_intf.TxStartBlock;  
assign pipe4_l01_tx_data_valid  = `PCIE_HOST_LANE1.pipe_intf.TxDataValid;  
assign pipe4_l01_tx_det_rx_lpbk = `PCIE_HOST_LANE1.pipe_intf.TxDetectRx;
assign pipe4_l01_tx_elec_idle   = `PCIE_HOST_LANE1.pipe_intf.TxElecIdle;  
assign pipe4_l01_tx_ones_zeros   = `PCIE_HOST_LANE1.pipe_intf.pipe4_tx_ones_zeros;
assign pipe4_l01_tx_128b_enc_byp = `PCIE_HOST_LANE1.pipe_intf.pipe4_tx_128b_enc_byp;
assign pipe4_l01_tx_deemph       = `PCIE_HOST_LANE1.pipe_intf.pipe4_tx_deemph;

assign `PCIE_HOST_LANE1.pipe_intf.PhyStatus     = pipe4_l01_phy_status;
assign `PCIE_HOST_LANE1.pipe_intf.RxData        = pipe4_l01_rx_data;
assign `PCIE_HOST_LANE1.pipe_intf.RxDataK       = pipe4_l01_rx_data_k;
assign `PCIE_HOST_LANE1.pipe_intf.RxSyncHeader  = pipe4_l01_rx_sync_header;
assign `PCIE_HOST_LANE1.pipe_intf.RxStartBlock  = pipe4_l01_rx_start_block;
assign `PCIE_HOST_LANE1.pipe_intf.RxDataValid   = pipe4_l01_rx_data_valid;
assign `PCIE_HOST_LANE1.pipe_intf.RxValid       = pipe4_l01_rx_valid;
assign `PCIE_HOST_LANE1.pipe_intf.RxStatus      = pipe4_l01_rx_status;
assign `PCIE_HOST_LANE1.pipe_intf.RxElecIdle    = pipe4_l01_rx_elec_idle;

// PHY/PMA Interface & PMA Clocks
assign pma_cmn_refclk_dig_div  = `PCIE_HOST_LANE0.pipe_intf.pma_cmn_refclk_dig_div ;
assign pma_cmn_refclk_dig_sel  = `PCIE_HOST_LANE0.pipe_intf.pma_cmn_refclk_dig_sel ;
assign pma_cmn_pll0_refclk_sel = `PCIE_HOST_LANE0.pipe_intf.pma_cmn_pll0_refclk_sel;
assign pma_cmn_pll1_refclk_sel = `PCIE_HOST_LANE0.pipe_intf.pma_cmn_pll1_refclk_sel;

// SPACE PINS, Note! assign these pins to init_intf
assign pipe7_reset_n             = `PCIE_HOST_LANE0.init_intf.Reset;
assign pipe7_clk_max_req         = `PCIE_HOST_LANE0.init_intf.pipe7_clk_max_req;
assign pipe7_pll0_en             = `PCIE_HOST_LANE0.init_intf.pipe7_pll0_en;

assign pipe7_l00_clk             = 0;
assign pipe7_l00_m2p_messagebus  = `PCIE_HOST_LANE0.init_intf.M2P_MessageBus;
assign pipe7_l00_rate            = `PCIE_HOST_LANE0.init_intf.Rate[1:0];
assign pipe7_l00_rx_termination  = `PCIE_HOST_LANE0.init_intf.RXTermination;
assign pipe7_l00_rx_standby      = `PCIE_HOST_LANE0.init_intf.RxStandby;
assign pipe7_l00_powerdown       = `PCIE_HOST_LANE0.init_intf.PowerDown[2:0];
assign pipe7_l00_tx_data         = `PCIE_HOST_LANE0.init_intf.TxData;
assign pipe7_l00_tx_data_valid   = `PCIE_HOST_LANE0.init_intf.TxDataValid;
assign pipe7_l00_tx_det_rx_lpbk  = `PCIE_HOST_LANE0.init_intf.TxDetectRx;
assign pipe7_l00_tx_elec_idle    = `PCIE_HOST_LANE0.init_intf.TxElecIdle;

assign pipe7_l01_clk             = 0;
assign pipe7_l01_m2p_messagebus  = `PCIE_HOST_LANE1.init_intf.M2P_MessageBus; 
assign pipe7_l01_rate            = `PCIE_HOST_LANE1.init_intf.Rate[1:0];
assign pipe7_l01_rx_termination  = `PCIE_HOST_LANE1.init_intf.RXTermination;
assign pipe7_l01_rx_standby      = `PCIE_HOST_LANE1.init_intf.RxStandby;
assign pipe7_l01_powerdown       = `PCIE_HOST_LANE1.init_intf.PowerDown[2:0];
assign pipe7_l01_tx_data         = `PCIE_HOST_LANE1.init_intf.TxData;
assign pipe7_l01_tx_data_valid   = `PCIE_HOST_LANE1.init_intf.TxDataValid;
assign pipe7_l01_tx_det_rx_lpbk  = `PCIE_HOST_LANE1.init_intf.TxDetectRx;
assign pipe7_l01_tx_elec_idle    = `PCIE_HOST_LANE1.init_intf.TxElecIdle;

assign dp_reset_n                = `PCIE_HOST_LANE0.init_intf.dp_reset_n;
assign pma_xcvr_pllclk_en        = `PCIE_HOST_LANE0.init_intf.pma_xcvr_pllclk_en;
assign pma_xcvr_power_state_req  = `PCIE_HOST_LANE0.init_intf.pma_xcvr_power_state_req;
assign pma_xcvr_data_width       = `PCIE_HOST_LANE0.init_intf.pma_xcvr_data_width;
assign pma_tx_td_clk             = `PCIE_HOST_LANE0.init_intf.pma_tx_td_clk;
assign pma_tx_lfps_en            = `PCIE_HOST_LANE0.init_intf.pma_tx_lfps_en;
assign pma_tx_lfps_mode          = `PCIE_HOST_LANE0.init_intf.pma_tx_lfps_mode;
assign pma_tx_elec_idle_ln_0     = `PCIE_HOST_LANE0.init_intf.pma_tx_elec_idle_ln;
assign pma_tx_td_ln_0            = `PCIE_HOST_LANE0.init_intf.pma_tx_td_ln;
assign pma_tx_elec_idle_ln_1     = `PCIE_HOST_LANE1.init_intf.pma_tx_elec_idle_ln;
assign pma_tx_td_ln_1            = `PCIE_HOST_LANE1.init_intf.pma_tx_td_ln;
assign pma_tx_elec_idle_ln_2     = `PCIE_HOST_LANE0.init_intf.pma_tx_elec_idle_ln;
assign pma_tx_td_ln_2            = `PCIE_HOST_LANE0.init_intf.pma_tx_td_ln;
assign pma_tx_elec_idle_ln_3     = `PCIE_HOST_LANE1.init_intf.pma_tx_elec_idle_ln;
assign pma_tx_td_ln_3            = `PCIE_HOST_LANE1.init_intf.pma_tx_td_ln;

//------------------------------------------------------------------------
// DP CONNECTIONS
//------------------------------------------------------------------------
`elsif DP
// PHY interface
assign phy_mode       = `DP_HOST_LANE0.pipe_intf.phy_mode;

// B2B/Single PHY Serial Connections
`ifdef B2B_MODE
assign device_tx_p_ln_0 = devc_rx0p;
assign device_tx_m_ln_0 = devc_rx0n;
assign device_rx_p_ln_1 = devc_rx1p;
assign device_rx_m_ln_1 = devc_rx1n;
assign device_rx_p_ln_2 = devc_rx2p;
assign device_rx_m_ln_2 = devc_rx2n;
assign device_tx_p_ln_3 = devc_rx3p;
assign device_tx_m_ln_3 = devc_rx3n;
`else
assign `DP_DEVC_LANE0.serdes_rx.serial_p = devc_rx0p;
assign `DP_DEVC_LANE0.serdes_rx.serial_n = devc_rx0n;
assign `DP_DEVC_LANE1.serdes_rx.serial_p = devc_rx1p;
assign `DP_DEVC_LANE1.serdes_rx.serial_n = devc_rx1n;
assign `DP_DEVC_LANE2.serdes_rx.serial_p = devc_rx2p;
assign `DP_DEVC_LANE2.serdes_rx.serial_n = devc_rx2n;
assign `DP_DEVC_LANE3.serdes_rx.serial_p = devc_rx3p;
assign `DP_DEVC_LANE3.serdes_rx.serial_n = devc_rx3n;
`endif

// Raw interface - Link Signals
assign `DP_HOST_LANE0.pipe_intf.pma_cmn_ready            = pma_cmn_ready;
assign `DP_HOST_LANE0.pipe_intf.pma_xcvr_pllclk_en_ack   = pma_xcvr_pllclk_en_ack;
assign `DP_HOST_LANE0.pipe_intf.pma_xcvr_power_state_ack = pma_xcvr_power_state_ack;
//assign `DP_HOST_LANE0.pipe_intf. = pma_cmn_avdd_pwrgood; // TODO
assign pma_xcvr_pllclk_en       = `DP_HOST_LANE0.pipe_intf.pma_xcvr_pllclk_en;
assign pma_xcvr_power_state_req = `DP_HOST_LANE0.pipe_intf.pma_xcvr_power_state_req;
assign pma_xcvr_data_width      = `DP_HOST_LANE0.pipe_intf.pma_xcvr_data_width;
assign dp_reset_n               = `DP_HOST_LANE0.pipe_intf.dp_reset_n;
assign pma_tx_td_clk            = `DP_HOST_LANE0.pipe_intf.pma_tx_td_clk;
assign pma_tx_lfps_en           = `DP_HOST_LANE0.pipe_intf.pma_tx_lfps_en;
assign pma_tx_lfps_mode         = `DP_HOST_LANE0.pipe_intf.pma_tx_lfps_mode;
// Raw interface - Lane0 Signals
assign pma_tx_elec_idle_ln_0 = `DP_HOST_LANE0.pipe_intf.pma_tx_elec_idle_ln;
assign pma_tx_td_ln_0        = `DP_HOST_LANE0.pipe_intf.pma_tx_td_ln;
// Raw interface - Lane1 Signals
assign pma_tx_elec_idle_ln_1 = `DP_HOST_LANE1.pipe_intf.pma_tx_elec_idle_ln;
assign pma_tx_td_ln_1        = `DP_HOST_LANE1.pipe_intf.pma_tx_td_ln;
// Raw interface - Lane2 Signals
assign pma_tx_elec_idle_ln_2 = `DP_HOST_LANE2.pipe_intf.pma_tx_elec_idle_ln;
assign pma_tx_td_ln_2        = `DP_HOST_LANE2.pipe_intf.pma_tx_td_ln;
// Raw interface - Lane3 Signals
assign pma_tx_elec_idle_ln_3 = `DP_HOST_LANE3.pipe_intf.pma_tx_elec_idle_ln;
assign pma_tx_td_ln_3        = `DP_HOST_LANE3.pipe_intf.pma_tx_td_ln;

// PHY/PMA Interface & PMA Clocks
assign pma_cmn_refclk_dig_div  = `DP_HOST_LANE0.pipe_intf.pma_cmn_refclk_dig_div ;
assign pma_cmn_refclk_dig_sel  = `DP_HOST_LANE0.pipe_intf.pma_cmn_refclk_dig_sel ;
assign pma_cmn_pll0_refclk_sel = `DP_HOST_LANE0.pipe_intf.pma_cmn_pll0_refclk_sel;
assign pma_cmn_pll1_refclk_sel = `DP_HOST_LANE0.pipe_intf.pma_cmn_pll1_refclk_sel;

// SPACE PINS, Note! assign these pins to init_intf
assign pipe7_reset_n             = `DP_HOST_LANE0.init_intf.Reset;
assign pipe7_clk_max_req         = `DP_HOST_LANE0.init_intf.pipe7_clk_max_req;
assign pipe7_pll0_en             = `DP_HOST_LANE0.init_intf.pipe7_pll0_en;

assign pipe7_l00_clk             = 0;
assign pipe7_l00_m2p_messagebus  = `DP_HOST_LANE0.init_intf.M2P_MessageBus;
assign pipe7_l00_rate            = `DP_HOST_LANE0.init_intf.Rate[1:0];
assign pipe7_l00_rx_termination  = `DP_HOST_LANE0.init_intf.RXTermination;
assign pipe7_l00_rx_standby      = `DP_HOST_LANE0.init_intf.RxStandby;
assign pipe7_l00_powerdown       = `DP_HOST_LANE0.init_intf.PowerDown[2:0];
assign pipe7_l00_tx_data         = `DP_HOST_LANE0.init_intf.TxData;
assign pipe7_l00_tx_data_valid   = `DP_HOST_LANE0.init_intf.TxDataValid;
assign pipe7_l00_tx_det_rx_lpbk  = `DP_HOST_LANE0.init_intf.TxDetectRx;
assign pipe7_l00_tx_elec_idle    = `DP_HOST_LANE0.init_intf.TxElecIdle;

assign pipe7_l01_clk             = 0;
assign pipe7_l01_m2p_messagebus  = `DP_HOST_LANE1.init_intf.M2P_MessageBus;
assign pipe7_l01_rate            = `DP_HOST_LANE1.init_intf.Rate[1:0];
assign pipe7_l01_rx_termination  = `DP_HOST_LANE1.init_intf.RXTermination;
assign pipe7_l01_rx_standby      = `DP_HOST_LANE1.init_intf.RxStandby;
assign pipe7_l01_powerdown       = `DP_HOST_LANE1.init_intf.PowerDown[2:0];
assign pipe7_l01_tx_data         = `DP_HOST_LANE1.init_intf.TxData;
assign pipe7_l01_tx_data_valid   = `DP_HOST_LANE1.init_intf.TxDataValid;
assign pipe7_l01_tx_det_rx_lpbk  = `DP_HOST_LANE1.init_intf.TxDetectRx;
assign pipe7_l01_tx_elec_idle    = `DP_HOST_LANE1.init_intf.TxElecIdle;

assign pipe4_reset_n             = `DP_HOST_LANE0.init_intf.Reset;
assign pipe4_rate                = `DP_HOST_LANE0.init_intf.Rate[0];
assign pipe4_powerdown           = `DP_HOST_LANE0.init_intf.PowerDown[1:0];
assign pipe4_eb_mode             = `DP_HOST_LANE0.init_intf.pipe4_eb_mode;

assign pipe4_l00_rx_polarity     = `DP_HOST_LANE0.init_intf.pipe4_rx_polarity;
assign pipe4_l00_rx_eq_training  = `DP_HOST_LANE0.init_intf.pipe4_rx_eq_training;
assign pipe4_l00_rx_termination  = `DP_HOST_LANE0.init_intf.RXTermination;
assign pipe4_l00_tx_data         = `DP_HOST_LANE0.init_intf.TxData;
assign pipe4_l00_tx_data_k       = `DP_HOST_LANE0.init_intf.TxDataK;  
assign pipe4_l00_tx_sync_header  = `DP_HOST_LANE0.init_intf.TxSyncHeader;
assign pipe4_l00_tx_start_block  = `DP_HOST_LANE0.init_intf.TxStartBlock;
assign pipe4_l00_tx_data_valid   = `DP_HOST_LANE0.init_intf.TxDataValid;
assign pipe4_l00_tx_det_rx_lpbk  = `DP_HOST_LANE0.init_intf.TxDetectRx;
assign pipe4_l00_tx_elec_idle    = `DP_HOST_LANE0.init_intf.TxElecIdle;
assign pipe4_l00_tx_ones_zeros   = `DP_HOST_LANE0.init_intf.pipe4_tx_ones_zeros;
assign pipe4_l00_tx_128b_enc_byp = `DP_HOST_LANE0.init_intf.pipe4_tx_128b_enc_byp;
assign pipe4_l00_tx_deemph       = `DP_HOST_LANE0.init_intf.pipe4_tx_deemph;

assign pipe4_l01_rx_polarity     = `DP_HOST_LANE1.init_intf.pipe4_rx_polarity;
assign pipe4_l01_rx_eq_training  = `DP_HOST_LANE1.init_intf.pipe4_rx_eq_training;
assign pipe4_l01_rx_termination  = `DP_HOST_LANE1.init_intf.RXTermination;
assign pipe4_l01_tx_data         = `DP_HOST_LANE1.init_intf.TxData;  
assign pipe4_l01_tx_data_k       = `DP_HOST_LANE1.init_intf.TxDataK;  
assign pipe4_l01_tx_sync_header  = `DP_HOST_LANE1.init_intf.TxSyncHeader;  
assign pipe4_l01_tx_start_block  = `DP_HOST_LANE1.init_intf.TxStartBlock;  
assign pipe4_l01_tx_data_valid   = `DP_HOST_LANE1.init_intf.TxDataValid;  
assign pipe4_l01_tx_det_rx_lpbk  = `DP_HOST_LANE1.init_intf.TxDetectRx;
assign pipe4_l01_tx_elec_idle    = `DP_HOST_LANE1.init_intf.TxElecIdle;  
assign pipe4_l01_tx_ones_zeros   = `DP_HOST_LANE1.init_intf.pipe4_tx_ones_zeros;
assign pipe4_l01_tx_128b_enc_byp = `DP_HOST_LANE1.init_intf.pipe4_tx_128b_enc_byp;
assign pipe4_l01_tx_deemph       = `DP_HOST_LANE1.init_intf.pipe4_tx_deemph;

//------------------------------------------------------------------------
// ALT_MODE CONNECTIONS
//------------------------------------------------------------------------
`elsif ALT_MODE
//---------------------------------- USB32 --------------------------------------//
// B2B/Single PHY Serial Connections
`ifdef B2B_MODE
assign devc_tx0p = device_tx_p_ln_0;
assign devc_tx0n = device_tx_m_ln_0;
assign device_rx_p_ln_1 = devc_rx0p;
assign device_rx_m_ln_1 = devc_rx0n;
`else
assign devc_tx0p = `USB32_DEVC_LANE0.serdes_tx.serial_p;
assign devc_tx0n = `USB32_DEVC_LANE0.serdes_tx.serial_n;
assign `USB32_DEVC_LANE0.serdes_rx.serial_p  = devc_rx0p;
assign `USB32_DEVC_LANE0.serdes_rx.serial_n  = devc_rx0n;
`endif

// Original PIPE interface, For USB3 or PCIe1/2/3/4
//assign `USB32_HOST_LANE0.pclk = pipe4_clk; // TODO
assign pipe4_reset_n   = `USB32_HOST_LANE0.pipe_intf.Reset;
assign pipe4_rate      = `USB32_HOST_LANE0.pipe_intf.Rate[0];
assign pipe4_powerdown = `USB32_HOST_LANE0.pipe_intf.PowerDown[1:0];
assign pipe4_eb_mode   = `USB32_HOST_LANE0.pipe_intf.pipe4_eb_mode;

// Original PIPE - Lane0 Signals
assign pipe4_l00_rx_polarity     = `USB32_HOST_LANE0.pipe_intf.pipe4_rx_polarity;
assign pipe4_l00_rx_eq_training  = `USB32_HOST_LANE0.pipe_intf.pipe4_rx_eq_training;
assign pipe4_l00_rx_termination  = `USB32_HOST_LANE0.pipe_intf.RXTermination;
assign pipe4_l00_tx_data         = `USB32_HOST_LANE0.pipe_intf.TxData;
assign pipe4_l00_tx_data_k       = `USB32_HOST_LANE0.pipe_intf.TxDataK;  
assign pipe4_l00_tx_sync_header  = `USB32_HOST_LANE0.pipe_intf.TxSyncHeader;
assign pipe4_l00_tx_start_block  = `USB32_HOST_LANE0.pipe_intf.TxStartBlock;
assign pipe4_l00_tx_data_valid   = `USB32_HOST_LANE0.pipe_intf.TxDataValid;
assign pipe4_l00_tx_det_rx_lpbk  = `USB32_HOST_LANE0.pipe_intf.TxDetectRx;
assign pipe4_l00_tx_elec_idle    = `USB32_HOST_LANE0.pipe_intf.TxElecIdle;
assign pipe4_l00_tx_ones_zeros   = `USB32_HOST_LANE0.pipe_intf.pipe4_tx_ones_zeros;
assign pipe4_l00_tx_128b_enc_byp = `USB32_HOST_LANE0.pipe_intf.pipe4_tx_128b_enc_byp;
assign pipe4_l00_tx_deemph       = `USB32_HOST_LANE0.pipe_intf.pipe4_tx_deemph;

assign `USB32_HOST_LANE0.pipe_intf.PhyStatus     = pipe4_l00_phy_status;
assign `USB32_HOST_LANE0.pipe_intf.RxData        = pipe4_l00_rx_data;
assign `USB32_HOST_LANE0.pipe_intf.RxDataK       = pipe4_l00_rx_data_k;
assign `USB32_HOST_LANE0.pipe_intf.RxSyncHeader  = pipe4_l00_rx_sync_header;
assign `USB32_HOST_LANE0.pipe_intf.RxStartBlock  = pipe4_l00_rx_start_block;
assign `USB32_HOST_LANE0.pipe_intf.RxDataValid   = pipe4_l00_rx_data_valid;
assign `USB32_HOST_LANE0.pipe_intf.RxValid       = pipe4_l00_rx_valid;
assign `USB32_HOST_LANE0.pipe_intf.RxStatus      = pipe4_l00_rx_status;
assign `USB32_HOST_LANE0.pipe_intf.RxElecIdle    = pipe4_l00_rx_elec_idle;

//---------------------------------- DP --------------------------------------//
// B2B/Single PHY Serial Connections
`ifdef B2B_MODE
assign device_rx_p_ln_2 = devc_rx2p;
assign device_rx_m_ln_2 = devc_rx2n;
assign device_tx_p_ln_3 = devc_rx3p;
assign device_tx_m_ln_3 = devc_rx3n;
`else
assign `DP_DEVC_LANE0.serdes_rx.serial_p = devc_rx2p;
assign `DP_DEVC_LANE0.serdes_rx.serial_n = devc_rx2n;
assign `DP_DEVC_LANE1.serdes_rx.serial_p = devc_rx3p;
assign `DP_DEVC_LANE1.serdes_rx.serial_n = devc_rx3n;
`endif
// Raw interface - Link Signals
assign `DP_HOST_LANE0.pipe_intf.pma_cmn_ready            = pma_cmn_ready;
assign `DP_HOST_LANE0.pipe_intf.pma_xcvr_pllclk_en_ack   = pma_xcvr_pllclk_en_ack;
assign `DP_HOST_LANE0.pipe_intf.pma_xcvr_power_state_ack = pma_xcvr_power_state_ack;
//assign `DP_HOST_LANE0.pipe_intf. = pma_cmn_avdd_pwrgood; // TODO
assign pma_xcvr_pllclk_en       = `DP_HOST_LANE0.pipe_intf.pma_xcvr_pllclk_en;
assign pma_xcvr_power_state_req = `DP_HOST_LANE0.pipe_intf.pma_xcvr_power_state_req;
assign pma_xcvr_data_width      = `DP_HOST_LANE0.pipe_intf.pma_xcvr_data_width;
assign dp_reset_n               = `DP_HOST_LANE0.pipe_intf.dp_reset_n;
assign pma_tx_td_clk            = `DP_HOST_LANE0.pipe_intf.pma_tx_td_clk;
assign pma_tx_lfps_en           = `DP_HOST_LANE0.pipe_intf.pma_tx_lfps_en;
assign pma_tx_lfps_mode         = `DP_HOST_LANE0.pipe_intf.pma_tx_lfps_mode;
// Raw interface - Lane0 Signals
assign pma_tx_elec_idle_ln_0 = `DP_HOST_LANE0.pipe_intf.pma_tx_elec_idle_ln;
assign pma_tx_td_ln_0        = `DP_HOST_LANE0.pipe_intf.pma_tx_td_ln;
// Raw interface - Lane1 Signals
assign pma_tx_elec_idle_ln_1 = `DP_HOST_LANE1.pipe_intf.pma_tx_elec_idle_ln;
assign pma_tx_td_ln_1        = `DP_HOST_LANE1.pipe_intf.pma_tx_td_ln;

//---------------------------------- COMMON --------------------------------------//
// PHY interface
assign phy_mode       = `USB32_HOST_LANE0.pipe_intf.phy_mode;

// PHY/PMA Interface & PMA Clocks
assign pma_cmn_refclk_dig_div  = `USB32_HOST_LANE0.pipe_intf.pma_cmn_refclk_dig_div ;
assign pma_cmn_refclk_dig_sel  = `USB32_HOST_LANE0.pipe_intf.pma_cmn_refclk_dig_sel ;
assign pma_cmn_pll0_refclk_sel = `USB32_HOST_LANE0.pipe_intf.pma_cmn_pll0_refclk_sel;
assign pma_cmn_pll1_refclk_sel = `USB32_HOST_LANE0.pipe_intf.pma_cmn_pll1_refclk_sel;


// SPACE PINS, Note! assign these pins to init_intf
assign pipe7_reset_n             = `USB32_HOST_LANE0.init_intf.Reset;
assign pipe7_clk_max_req         = `USB32_HOST_LANE0.init_intf.pipe7_clk_max_req;
assign pipe7_pll0_en             = `USB32_HOST_LANE0.init_intf.pipe7_pll0_en;

assign pipe7_l00_clk             = 0;
assign pipe7_l00_m2p_messagebus  = `USB32_HOST_LANE0.init_intf.M2P_MessageBus;
assign pipe7_l00_rate            = `USB32_HOST_LANE0.init_intf.Rate[1:0];
assign pipe7_l00_rx_termination  = `USB32_HOST_LANE0.init_intf.RXTermination;
assign pipe7_l00_rx_standby      = `USB32_HOST_LANE0.init_intf.RxStandby;
assign pipe7_l00_powerdown       = `USB32_HOST_LANE0.init_intf.PowerDown[2:0];
assign pipe7_l00_tx_data         = `USB32_HOST_LANE0.init_intf.TxData;
assign pipe7_l00_tx_data_valid   = `USB32_HOST_LANE0.init_intf.TxDataValid;
assign pipe7_l00_tx_det_rx_lpbk  = `USB32_HOST_LANE0.init_intf.TxDetectRx;
assign pipe7_l00_tx_elec_idle    = `USB32_HOST_LANE0.init_intf.TxElecIdle;

assign pipe7_l01_clk             = 0;
assign pipe7_l01_m2p_messagebus  = `USB32_HOST_LANE0.init_intf.M2P_MessageBus;
assign pipe7_l01_rate            = `USB32_HOST_LANE0.init_intf.Rate[1:0];
assign pipe7_l01_rx_termination  = `USB32_HOST_LANE0.init_intf.RXTermination;
assign pipe7_l01_rx_standby      = `USB32_HOST_LANE0.init_intf.RxStandby;
assign pipe7_l01_powerdown       = `USB32_HOST_LANE0.init_intf.PowerDown[2:0];
assign pipe7_l01_tx_data         = `USB32_HOST_LANE0.init_intf.TxData;
assign pipe7_l01_tx_data_valid   = `USB32_HOST_LANE0.init_intf.TxDataValid;
assign pipe7_l01_tx_det_rx_lpbk  = `USB32_HOST_LANE0.init_intf.TxDetectRx;
assign pipe7_l01_tx_elec_idle    = `USB32_HOST_LANE0.init_intf.TxElecIdle;

assign pipe4_l01_rx_polarity     = `USB32_HOST_LANE0.init_intf.pipe4_rx_polarity;
assign pipe4_l01_rx_eq_training  = `USB32_HOST_LANE0.init_intf.pipe4_rx_eq_training;
assign pipe4_l01_rx_termination  = `USB32_HOST_LANE0.init_intf.RXTermination;
assign pipe4_l01_tx_data         = `USB32_HOST_LANE0.init_intf.TxData;  
assign pipe4_l01_tx_data_k       = `USB32_HOST_LANE0.init_intf.TxDataK;  
assign pipe4_l01_tx_sync_header  = `USB32_HOST_LANE0.init_intf.TxSyncHeader;  
assign pipe4_l01_tx_start_block  = `USB32_HOST_LANE0.init_intf.TxStartBlock;  
assign pipe4_l01_tx_data_valid   = `USB32_HOST_LANE0.init_intf.TxDataValid;  
assign pipe4_l01_tx_det_rx_lpbk  = `USB32_HOST_LANE0.init_intf.TxDetectRx;
assign pipe4_l01_tx_elec_idle    = `USB32_HOST_LANE0.init_intf.TxElecIdle;  
assign pipe4_l01_tx_ones_zeros   = `USB32_HOST_LANE0.init_intf.pipe4_tx_ones_zeros;
assign pipe4_l01_tx_128b_enc_byp = `USB32_HOST_LANE0.init_intf.pipe4_tx_128b_enc_byp;
assign pipe4_l01_tx_deemph       = `USB32_HOST_LANE0.init_intf.pipe4_tx_deemph;

assign pma_tx_elec_idle_ln_2     = `USB32_HOST_LANE0.init_intf.pma_tx_elec_idle_ln;
assign pma_tx_td_ln_2            = `USB32_HOST_LANE0.init_intf.pma_tx_td_ln;
assign pma_tx_elec_idle_ln_3     = `USB32_HOST_LANE0.init_intf.pma_tx_elec_idle_ln;
assign pma_tx_td_ln_3            = `USB32_HOST_LANE0.init_intf.pma_tx_td_ln;

`endif


//------------------------------------------------------------------------
// B2B PHY DEVICE
//------------------------------------------------------------------------
`ifdef B2B_MODE
//------------------------------------------------------------------------
// USB32 CONNECTIONS
//------------------------------------------------------------------------
`ifdef USB32
// PHY interface
assign device_phy_mode       = `USB32_DEVC_LANE0.pipe_intf.phy_mode;

// Original PIPE interface, For USB3 or PCIe1/2/3/4
assign `USB32_DEVC_LANE0.pclk = device_pipe4_clk; // TODO
assign `USB32_DEVC_LANE1.pclk = device_pipe4_clk; // TODO
//assign `USB32_DEVC_LANE0.pclk = clk_io.drv_clk_gen[0]; // TODO
//assign `USB32_DEVC_LANE1.pclk = clk_io.drv_clk_gen[0]; // TODO
assign device_pipe4_reset_n   = `USB32_DEVC_LANE0.pipe_intf.Reset;
assign device_pipe4_rate      = `USB32_DEVC_LANE0.pipe_intf.Rate[0];
assign device_pipe4_powerdown = `USB32_DEVC_LANE0.pipe_intf.PowerDown[1:0];
assign device_pipe4_eb_mode   = `USB32_DEVC_LANE0.pipe_intf.pipe4_eb_mode;

// Original PIPE - Lane0 Signals
assign device_pipe4_l00_rx_polarity     = `USB32_DEVC_LANE0.pipe_intf.pipe4_rx_polarity;
assign device_pipe4_l00_rx_eq_training  = `USB32_DEVC_LANE0.pipe_intf.pipe4_rx_eq_training;
assign device_pipe4_l00_rx_termination  = `USB32_DEVC_LANE0.pipe_intf.RXTermination;
assign device_pipe4_l00_tx_data         = `USB32_DEVC_LANE0.pipe_intf.TxData;
assign device_pipe4_l00_tx_data_k       = `USB32_DEVC_LANE0.pipe_intf.TxDataK;  
assign device_pipe4_l00_tx_sync_header  = `USB32_DEVC_LANE0.pipe_intf.TxSyncHeader;
assign device_pipe4_l00_tx_start_block  = `USB32_DEVC_LANE0.pipe_intf.TxStartBlock;
assign device_pipe4_l00_tx_data_valid   = `USB32_DEVC_LANE0.pipe_intf.TxDataValid;
assign device_pipe4_l00_tx_det_rx_lpbk  = `USB32_DEVC_LANE0.pipe_intf.TxDetectRx;
assign device_pipe4_l00_tx_elec_idle    = `USB32_DEVC_LANE0.pipe_intf.TxElecIdle;
assign device_pipe4_l00_tx_ones_zeros   = `USB32_DEVC_LANE0.pipe_intf.pipe4_tx_ones_zeros;
assign device_pipe4_l00_tx_128b_enc_byp = `USB32_DEVC_LANE0.pipe_intf.pipe4_tx_128b_enc_byp;
assign device_pipe4_l00_tx_deemph       = `USB32_DEVC_LANE0.pipe_intf.pipe4_tx_deemph;

assign `USB32_DEVC_LANE0.pipe_intf.PhyStatus     = device_pipe4_l00_phy_status;
assign `USB32_DEVC_LANE0.pipe_intf.RxData        = device_pipe4_l00_rx_data;
assign `USB32_DEVC_LANE0.pipe_intf.RxDataK       = device_pipe4_l00_rx_data_k;
assign `USB32_DEVC_LANE0.pipe_intf.RxSyncHeader  = device_pipe4_l00_rx_sync_header;
assign `USB32_DEVC_LANE0.pipe_intf.RxStartBlock  = device_pipe4_l00_rx_start_block;
assign `USB32_DEVC_LANE0.pipe_intf.RxDataValid   = device_pipe4_l00_rx_data_valid;
assign `USB32_DEVC_LANE0.pipe_intf.RxValid       = device_pipe4_l00_rx_valid;
assign `USB32_DEVC_LANE0.pipe_intf.RxStatus      = device_pipe4_l00_rx_status;
assign `USB32_DEVC_LANE0.pipe_intf.RxElecIdle    = device_pipe4_l00_rx_elec_idle;

// Original PIPE - Lane1 Signals
assign device_pipe4_l01_rx_polarity     = `USB32_DEVC_LANE1.pipe_intf.pipe4_rx_polarity;
assign device_pipe4_l01_rx_eq_training  = `USB32_DEVC_LANE1.pipe_intf.pipe4_rx_eq_training;
assign device_pipe4_l01_rx_termination  = `USB32_DEVC_LANE1.pipe_intf.RXTermination;
assign device_pipe4_l01_tx_data         = `USB32_DEVC_LANE1.pipe_intf.TxData;  
assign device_pipe4_l01_tx_data_k       = `USB32_DEVC_LANE1.pipe_intf.TxDataK;  
assign device_pipe4_l01_tx_sync_header  = `USB32_DEVC_LANE1.pipe_intf.TxSyncHeader;  
assign device_pipe4_l01_tx_start_block  = `USB32_DEVC_LANE1.pipe_intf.TxStartBlock;  
assign device_pipe4_l01_tx_data_valid   = `USB32_DEVC_LANE1.pipe_intf.TxDataValid;  
assign device_pipe4_l01_tx_det_rx_lpbk  = `USB32_DEVC_LANE1.pipe_intf.TxDetectRx;
assign device_pipe4_l01_tx_elec_idle    = `USB32_DEVC_LANE1.pipe_intf.TxElecIdle;  
assign device_pipe4_l01_tx_ones_zeros   = `USB32_DEVC_LANE1.pipe_intf.pipe4_tx_ones_zeros;
assign device_pipe4_l01_tx_128b_enc_byp = `USB32_DEVC_LANE1.pipe_intf.pipe4_tx_128b_enc_byp;
assign device_pipe4_l01_tx_deemph       = `USB32_DEVC_LANE1.pipe_intf.pipe4_tx_deemph;

assign `USB32_DEVC_LANE1.pipe_intf.PhyStatus     = device_pipe4_l01_phy_status;
assign `USB32_DEVC_LANE1.pipe_intf.RxData        = device_pipe4_l01_rx_data;
assign `USB32_DEVC_LANE1.pipe_intf.RxDataK       = device_pipe4_l01_rx_data_k;
assign `USB32_DEVC_LANE1.pipe_intf.RxSyncHeader  = device_pipe4_l01_rx_sync_header;
assign `USB32_DEVC_LANE1.pipe_intf.RxStartBlock  = device_pipe4_l01_rx_start_block;
assign `USB32_DEVC_LANE1.pipe_intf.RxDataValid   = device_pipe4_l01_rx_data_valid;
assign `USB32_DEVC_LANE1.pipe_intf.RxValid       = device_pipe4_l01_rx_valid;
assign `USB32_DEVC_LANE1.pipe_intf.RxStatus      = device_pipe4_l01_rx_status;
assign `USB32_DEVC_LANE1.pipe_intf.RxElecIdle    = device_pipe4_l01_rx_elec_idle;

// PHY/PMA Interface & PMA Clocks
assign device_pma_cmn_refclk_dig_div  = `USB32_DEVC_LANE0.pipe_intf.pma_cmn_refclk_dig_div ;
assign device_pma_cmn_refclk_dig_sel  = `USB32_DEVC_LANE0.pipe_intf.pma_cmn_refclk_dig_sel ;
assign device_pma_cmn_pll0_refclk_sel = `USB32_DEVC_LANE0.pipe_intf.pma_cmn_pll0_refclk_sel;
assign device_pma_cmn_pll1_refclk_sel = `USB32_DEVC_LANE0.pipe_intf.pma_cmn_pll1_refclk_sel;

// SPACE PINS, Note! assign these pins to init_intf
assign device_pipe7_reset_n             = `USB32_DEVC_LANE0.init_intf.Reset;
assign device_pipe7_clk_max_req         = `USB32_DEVC_LANE0.init_intf.pipe7_clk_max_req;
assign device_pipe7_pll0_en             = `USB32_DEVC_LANE0.init_intf.pipe7_pll0_en;

assign device_pipe7_l00_clk             = 0;
assign device_pipe7_l00_m2p_messagebus  = `USB32_DEVC_LANE0.init_intf.M2P_MessageBus;
assign device_pipe7_l00_rate            = `USB32_DEVC_LANE0.init_intf.Rate[1:0];
assign device_pipe7_l00_rx_termination  = `USB32_DEVC_LANE0.init_intf.RXTermination;
assign device_pipe7_l00_rx_standby      = `USB32_DEVC_LANE0.init_intf.RxStandby;
assign device_pipe7_l00_powerdown       = `USB32_DEVC_LANE0.init_intf.PowerDown[2:0];
assign device_pipe7_l00_tx_data         = `USB32_DEVC_LANE0.init_intf.TxData;
assign device_pipe7_l00_tx_data_valid   = `USB32_DEVC_LANE0.init_intf.TxDataValid;
assign device_pipe7_l00_tx_det_rx_lpbk  = `USB32_DEVC_LANE0.init_intf.TxDetectRx;
assign device_pipe7_l00_tx_elec_idle    = `USB32_DEVC_LANE0.init_intf.TxElecIdle;

assign device_pipe7_l01_clk             = 0;
assign device_pipe7_l01_m2p_messagebus  = `USB32_DEVC_LANE1.init_intf.M2P_MessageBus;
assign device_pipe7_l01_rate            = `USB32_DEVC_LANE1.init_intf.Rate[1:0];
assign device_pipe7_l01_rx_termination  = `USB32_DEVC_LANE1.init_intf.RXTermination;
assign device_pipe7_l01_rx_standby      = `USB32_DEVC_LANE1.init_intf.RxStandby;
assign device_pipe7_l01_powerdown       = `USB32_DEVC_LANE1.init_intf.PowerDown[2:0];
assign device_pipe7_l01_tx_data         = `USB32_DEVC_LANE1.init_intf.TxData;
assign device_pipe7_l01_tx_data_valid   = `USB32_DEVC_LANE1.init_intf.TxDataValid;
assign device_pipe7_l01_tx_det_rx_lpbk  = `USB32_DEVC_LANE1.init_intf.TxDetectRx;
assign device_pipe7_l01_tx_elec_idle    = `USB32_DEVC_LANE1.init_intf.TxElecIdle;

assign device_dp_reset_n                = `USB32_DEVC_LANE0.init_intf.dp_reset_n;
assign device_pma_xcvr_pllclk_en        = `USB32_DEVC_LANE0.init_intf.pma_xcvr_pllclk_en;
assign device_pma_xcvr_power_state_req  = `USB32_DEVC_LANE0.init_intf.pma_xcvr_power_state_req;
assign device_pma_xcvr_data_width       = `USB32_DEVC_LANE0.init_intf.pma_xcvr_data_width;
assign device_pma_tx_td_clk             = `USB32_DEVC_LANE0.init_intf.pma_tx_td_clk;
assign device_pma_tx_lfps_en            = `USB32_DEVC_LANE0.init_intf.pma_tx_lfps_en;
assign device_pma_tx_lfps_mode          = `USB32_DEVC_LANE0.init_intf.pma_tx_lfps_mode;
assign device_pma_tx_elec_idle_ln_0     = `USB32_DEVC_LANE0.init_intf.pma_tx_elec_idle_ln;
assign device_pma_tx_td_ln_0            = `USB32_DEVC_LANE0.init_intf.pma_tx_td_ln;
assign device_pma_tx_elec_idle_ln_1     = `USB32_DEVC_LANE1.init_intf.pma_tx_elec_idle_ln;
assign device_pma_tx_td_ln_1            = `USB32_DEVC_LANE1.init_intf.pma_tx_td_ln;
assign device_pma_tx_elec_idle_ln_2     = `USB32_DEVC_LANE0.init_intf.pma_tx_elec_idle_ln;
assign device_pma_tx_td_ln_2            = `USB32_DEVC_LANE0.init_intf.pma_tx_td_ln;
assign device_pma_tx_elec_idle_ln_3     = `USB32_DEVC_LANE1.init_intf.pma_tx_elec_idle_ln;
assign device_pma_tx_td_ln_3            = `USB32_DEVC_LANE1.init_intf.pma_tx_td_ln;

//------------------------------------------------------------------------
// USB4 CONNECTIONS
//------------------------------------------------------------------------
`elsif USB4
// PHY interface
assign device_phy_mode       = `USB4_DEVC_LANE0.pipe_intf.phy_mode;

// Serdes PIPE interface, For USB4
assign `USB4_DEVC_LANE0.pipe_intf.pipe7_clk_max = device_pipe7_clk_max;
assign device_pipe7_clk_max_req = `USB4_DEVC_LANE0.pipe_intf.pipe7_clk_max_req;
assign `USB4_DEVC_LANE0.pipe_intf.pipe7_clk_max_ack = device_pipe7_clk_max_ack;
assign device_pipe7_pll0_en = `USB4_DEVC_LANE0.pipe_intf.pipe7_pll0_en;
assign `USB4_DEVC_LANE0.pipe_intf.pipe7_pll0_ok = device_pipe7_pll0_ok;
assign device_pipe7_reset_n = `USB4_DEVC_LANE0.pipe_intf.Reset;

always @(posedge device_pipe7_clk_max) begin
        device_pipe7_clk_div <= ~device_pipe7_clk_div;
end

assign device_pipe7_l00_clk = `USB4_DEVC_LANE0.pipe_intf.Rate ? device_pipe7_clk_max : device_pipe7_clk_div;
assign device_pipe7_l01_clk = `USB4_DEVC_LANE1.pipe_intf.Rate ? device_pipe7_clk_max : device_pipe7_clk_div;

assign `USB4_DEVC_LANE0.pclk = device_pipe7_l00_clk;
assign `USB4_DEVC_LANE1.pclk = device_pipe7_l01_clk;
//assign `USB4_DEVC_LANE0.pclk = clk_io.drv_clk_gen[0];
//assign `USB4_DEVC_LANE1.pclk = clk_io.drv_clk_gen[0];

// Serdes PIPE - Lane0 Signals
//assign pipe7_l00_clk  = `USB4_DEVC_LANE0.pclk;
assign device_pipe7_l00_rate = `USB4_DEVC_LANE0.pipe_intf.Rate[1:0];

assign `USB4_DEVC_LANE0.pipe_intf.PhyStatus       = device_pipe7_l00_phy_status;
assign `USB4_DEVC_LANE0.pipe_intf.RxCLK           = device_pipe7_l00_rx_clk;
assign `USB4_DEVC_LANE0.pipe_intf.RxData          = device_pipe7_l00_rx_data;
assign `USB4_DEVC_LANE0.pipe_intf.RxValid         = device_pipe7_l00_rx_valid;
assign `USB4_DEVC_LANE0.pipe_intf.RxStandbyStatus = device_pipe7_l00_rx_standby_status;
assign `USB4_DEVC_LANE0.pipe_intf.RxElecIdle      = device_pipe7_l00_rx_elec_idle;

assign device_pipe7_l00_rx_termination  = `USB4_DEVC_LANE0.pipe_intf.RXTermination;
assign device_pipe7_l00_rx_standby      = `USB4_DEVC_LANE0.pipe_intf.RxStandby;
assign device_pipe7_l00_powerdown       = `USB4_DEVC_LANE0.pipe_intf.PowerDown[2:0];
assign device_pipe7_l00_tx_data         = `USB4_DEVC_LANE0.pipe_intf.TxData;
assign device_pipe7_l00_tx_data_valid   = `USB4_DEVC_LANE0.pipe_intf.TxDataValid;
assign device_pipe7_l00_tx_det_rx_lpbk  = `USB4_DEVC_LANE0.pipe_intf.TxDetectRx;
assign device_pipe7_l00_tx_elec_idle    = `USB4_DEVC_LANE0.pipe_intf.TxElecIdle;
assign device_pipe7_l00_m2p_messagebus  = `USB4_DEVC_LANE0.pipe_intf.M2P_MessageBus; 
assign `USB4_DEVC_LANE0.pipe_intf.P2M_MessageBus= device_pipe7_l00_p2m_messagebus; 

// Serdes PIPE - Lane1 Signals
//assign pipe7_l01_clk  = `USB4_DEVC_LANE1.pclk;
assign device_pipe7_l01_rate = `USB4_DEVC_LANE1.pipe_intf.Rate[1:0];

assign `USB4_DEVC_LANE1.pipe_intf.PhyStatus       = device_pipe7_l01_phy_status;
assign `USB4_DEVC_LANE1.pipe_intf.RxCLK           = device_pipe7_l01_rx_clk;
assign `USB4_DEVC_LANE1.pipe_intf.RxData          = device_pipe7_l01_rx_data;
assign `USB4_DEVC_LANE1.pipe_intf.RxValid         = device_pipe7_l01_rx_valid;
assign `USB4_DEVC_LANE1.pipe_intf.RxStandbyStatus = device_pipe7_l01_rx_standby_status;
assign `USB4_DEVC_LANE1.pipe_intf.RxElecIdle      = device_pipe7_l01_rx_elec_idle;

assign device_pipe7_l01_rx_termination  = `USB4_DEVC_LANE1.pipe_intf.RXTermination;
assign device_pipe7_l01_rx_standby      = `USB4_DEVC_LANE1.pipe_intf.RxStandby;
assign device_pipe7_l01_powerdown       = `USB4_DEVC_LANE1.pipe_intf.PowerDown[2:0];
assign device_pipe7_l01_tx_data         = `USB4_DEVC_LANE1.pipe_intf.TxData;
assign device_pipe7_l01_tx_data_valid   = `USB4_DEVC_LANE1.pipe_intf.TxDataValid;
assign device_pipe7_l01_tx_det_rx_lpbk  = `USB4_DEVC_LANE1.pipe_intf.TxDetectRx;
assign device_pipe7_l01_tx_elec_idle    = `USB4_DEVC_LANE1.pipe_intf.TxElecIdle;
assign device_pipe7_l01_m2p_messagebus  = `USB4_DEVC_LANE1.pipe_intf.M2P_MessageBus;
assign `USB4_DEVC_LANE1.pipe_intf.P2M_MessageBus = device_pipe7_l01_p2m_messagebus; 

// PHY/PMA Interface & PMA Clocks
assign device_pma_cmn_refclk_dig_div  = `USB4_DEVC_LANE0.pipe_intf.pma_cmn_refclk_dig_div ;
assign device_pma_cmn_refclk_dig_sel  = `USB4_DEVC_LANE0.pipe_intf.pma_cmn_refclk_dig_sel ;
assign device_pma_cmn_pll0_refclk_sel = `USB4_DEVC_LANE0.pipe_intf.pma_cmn_pll0_refclk_sel;
assign device_pma_cmn_pll1_refclk_sel = `USB4_DEVC_LANE0.pipe_intf.pma_cmn_pll1_refclk_sel;

// SPACE PINS, Note! assign these pins to init_intf
assign device_pipe4_reset_n             = `USB4_DEVC_LANE0.init_intf.Reset;
assign device_pipe4_rate                = `USB4_DEVC_LANE0.init_intf.Rate[0];
assign device_pipe4_powerdown           = `USB4_DEVC_LANE0.init_intf.PowerDown[1:0];
assign device_pipe4_eb_mode             = `USB4_DEVC_LANE0.init_intf.pipe4_eb_mode;

assign device_pipe4_l00_rx_polarity     = `USB4_DEVC_LANE0.init_intf.pipe4_rx_polarity;
assign device_pipe4_l00_rx_eq_training  = `USB4_DEVC_LANE0.init_intf.pipe4_rx_eq_training;
assign device_pipe4_l00_rx_termination  = `USB4_DEVC_LANE0.init_intf.RXTermination;
assign device_pipe4_l00_tx_data         = `USB4_DEVC_LANE0.init_intf.TxData;
assign device_pipe4_l00_tx_data_k       = `USB4_DEVC_LANE0.init_intf.TxDataK;  
assign device_pipe4_l00_tx_sync_header  = `USB4_DEVC_LANE0.init_intf.TxSyncHeader;
assign device_pipe4_l00_tx_start_block  = `USB4_DEVC_LANE0.init_intf.TxStartBlock;
assign device_pipe4_l00_tx_data_valid   = `USB4_DEVC_LANE0.init_intf.TxDataValid;
assign device_pipe4_l00_tx_det_rx_lpbk  = `USB4_DEVC_LANE0.init_intf.TxDetectRx;
assign device_pipe4_l00_tx_elec_idle    = `USB4_DEVC_LANE0.init_intf.TxElecIdle;
assign device_pipe4_l00_tx_ones_zeros   = `USB4_DEVC_LANE0.init_intf.pipe4_tx_ones_zeros;
assign device_pipe4_l00_tx_128b_enc_byp = `USB4_DEVC_LANE0.init_intf.pipe4_tx_128b_enc_byp;
assign device_pipe4_l00_tx_deemph       = `USB4_DEVC_LANE0.init_intf.pipe4_tx_deemph;

assign device_pipe4_l01_rx_polarity     = `USB4_DEVC_LANE1.init_intf.pipe4_rx_polarity;
assign device_pipe4_l01_rx_eq_training  = `USB4_DEVC_LANE1.init_intf.pipe4_rx_eq_training;
assign device_pipe4_l01_rx_termination  = `USB4_DEVC_LANE1.init_intf.RXTermination;
assign device_pipe4_l01_tx_data         = `USB4_DEVC_LANE1.init_intf.TxData;  
assign device_pipe4_l01_tx_data_k       = `USB4_DEVC_LANE1.init_intf.TxDataK;  
assign device_pipe4_l01_tx_sync_header  = `USB4_DEVC_LANE1.init_intf.TxSyncHeader;  
assign device_pipe4_l01_tx_start_block  = `USB4_DEVC_LANE1.init_intf.TxStartBlock;  
assign device_pipe4_l01_tx_data_valid   = `USB4_DEVC_LANE1.init_intf.TxDataValid;  
assign device_pipe4_l01_tx_det_rx_lpbk  = `USB4_DEVC_LANE1.init_intf.TxDetectRx;
assign device_pipe4_l01_tx_elec_idle    = `USB4_DEVC_LANE1.init_intf.TxElecIdle;  
assign device_pipe4_l01_tx_ones_zeros   = `USB4_DEVC_LANE1.init_intf.pipe4_tx_ones_zeros;
assign device_pipe4_l01_tx_128b_enc_byp = `USB4_DEVC_LANE1.init_intf.pipe4_tx_128b_enc_byp;
assign device_pipe4_l01_tx_deemph       = `USB4_DEVC_LANE1.init_intf.pipe4_tx_deemph;

assign device_dp_reset_n                = `USB4_DEVC_LANE0.init_intf.dp_reset_n;
assign device_pma_xcvr_pllclk_en        = `USB4_DEVC_LANE0.init_intf.pma_xcvr_pllclk_en;
assign device_pma_xcvr_power_state_req  = `USB4_DEVC_LANE0.init_intf.pma_xcvr_power_state_req;
assign device_pma_xcvr_data_width       = `USB4_DEVC_LANE0.init_intf.pma_xcvr_data_width;
assign device_pma_tx_td_clk             = `USB4_DEVC_LANE0.init_intf.pma_tx_td_clk;
assign device_pma_tx_lfps_en            = `USB4_DEVC_LANE0.init_intf.pma_tx_lfps_en;
assign device_pma_tx_lfps_mode          = `USB4_DEVC_LANE0.init_intf.pma_tx_lfps_mode;
assign device_pma_tx_elec_idle_ln_0     = `USB4_DEVC_LANE0.init_intf.pma_tx_elec_idle_ln;
assign device_pma_tx_td_ln_0            = `USB4_DEVC_LANE0.init_intf.pma_tx_td_ln;
assign device_pma_tx_elec_idle_ln_1     = `USB4_DEVC_LANE1.init_intf.pma_tx_elec_idle_ln;
assign device_pma_tx_td_ln_1            = `USB4_DEVC_LANE1.init_intf.pma_tx_td_ln;
assign device_pma_tx_elec_idle_ln_2     = `USB4_DEVC_LANE0.init_intf.pma_tx_elec_idle_ln;
assign device_pma_tx_td_ln_2            = `USB4_DEVC_LANE0.init_intf.pma_tx_td_ln;
assign device_pma_tx_elec_idle_ln_3     = `USB4_DEVC_LANE1.init_intf.pma_tx_elec_idle_ln;
assign device_pma_tx_td_ln_3            = `USB4_DEVC_LANE1.init_intf.pma_tx_td_ln;

//------------------------------------------------------------------------
// PCIE CONNECTIONS
//------------------------------------------------------------------------
`elsif PCIE
// PHY interface
assign device_phy_mode       = `PCIE_DEVC_LANE0.pipe_intf.phy_mode;

// Original PIPE interface, For USB3 or PCIe1/2/3/4
//assign `PCIE_DEVC_LANE0.pclk = pipe4_clk; // TODO
assign device_pipe4_reset_n   = `PCIE_DEVC_LANE0.pipe_intf.Reset;
assign device_pipe4_rate      = `PCIE_DEVC_LANE0.pipe_intf.Rate[0];
assign device_pipe4_powerdown = `PCIE_DEVC_LANE0.pipe_intf.PowerDown[1:0];
assign device_pipe4_eb_mode   = `PCIE_DEVC_LANE0.pipe_intf.pipe4_eb_mode;

// Original PIPE - Lane0 Signals
assign device_pipe4_l00_rx_polarity     = `PCIE_DEVC_LANE0.pipe_intf.pipe4_rx_polarity;
assign device_pipe4_l00_rx_eq_training  = `PCIE_DEVC_LANE0.pipe_intf.pipe4_rx_eq_training;
assign device_pipe4_l00_rx_termination  = `PCIE_DEVC_LANE0.pipe_intf.RXTermination;
assign device_pipe4_l00_tx_data         = `PCIE_DEVC_LANE0.pipe_intf.TxData;
assign device_pipe4_l00_tx_data_k       = `PCIE_DEVC_LANE0.pipe_intf.TxDataK;  
assign device_pipe4_l00_tx_sync_header  = `PCIE_DEVC_LANE0.pipe_intf.TxSyncHeader;
assign device_pipe4_l00_tx_start_block  = `PCIE_DEVC_LANE0.pipe_intf.TxStartBlock;
assign device_pipe4_l00_tx_data_valid   = `PCIE_DEVC_LANE0.pipe_intf.TxDataValid;
assign device_pipe4_l00_tx_det_rx_lpbk  = `PCIE_DEVC_LANE0.pipe_intf.TxDetectRx;
assign device_pipe4_l00_tx_elec_idle    = `PCIE_DEVC_LANE0.pipe_intf.TxElecIdle;
assign device_pipe4_l00_tx_ones_zeros   = `PCIE_DEVC_LANE0.pipe_intf.pipe4_tx_ones_zeros;
assign device_pipe4_l00_tx_128b_enc_byp = `PCIE_DEVC_LANE0.pipe_intf.pipe4_tx_128b_enc_byp;
assign device_pipe4_l00_tx_deemph       = `PCIE_DEVC_LANE0.pipe_intf.pipe4_tx_deemph;

assign `PCIE_DEVC_LANE0.pipe_intf.PhyStatus     = device_pipe4_l00_phy_status;
assign `PCIE_DEVC_LANE0.pipe_intf.RxData        = device_pipe4_l00_rx_data;
assign `PCIE_DEVC_LANE0.pipe_intf.RxDataK       = device_pipe4_l00_rx_data_k;
assign `PCIE_DEVC_LANE0.pipe_intf.RxSyncHeader  = device_pipe4_l00_rx_sync_header;
assign `PCIE_DEVC_LANE0.pipe_intf.RxStartBlock  = device_pipe4_l00_rx_start_block;
assign `PCIE_DEVC_LANE0.pipe_intf.RxDataValid   = device_pipe4_l00_rx_data_valid;
assign `PCIE_DEVC_LANE0.pipe_intf.RxValid       = device_pipe4_l00_rx_valid;
assign `PCIE_DEVC_LANE0.pipe_intf.RxStatus      = device_pipe4_l00_rx_status;
assign `PCIE_DEVC_LANE0.pipe_intf.RxElecIdle    = device_pipe4_l00_rx_elec_idle;

// Original PIPE - Lane1 Signals
assign device_pipe4_l01_rx_polarity    = `PCIE_DEVC_LANE1.pipe_intf.pipe4_rx_polarity;
assign device_pipe4_l01_rx_eq_training = `PCIE_DEVC_LANE1.pipe_intf.pipe4_rx_eq_training;
assign device_pipe4_l01_rx_termination = `PCIE_DEVC_LANE1.pipe_intf.RXTermination;
assign device_pipe4_l01_tx_data        = `PCIE_DEVC_LANE1.pipe_intf.TxData;  
assign device_pipe4_l01_tx_data_k      = `PCIE_DEVC_LANE1.pipe_intf.TxDataK;  
assign device_pipe4_l01_tx_sync_header = `PCIE_DEVC_LANE1.pipe_intf.TxSyncHeader;  
assign device_pipe4_l01_tx_start_block = `PCIE_DEVC_LANE1.pipe_intf.TxStartBlock;  
assign device_pipe4_l01_tx_data_valid  = `PCIE_DEVC_LANE1.pipe_intf.TxDataValid;  
assign device_pipe4_l01_tx_det_rx_lpbk = `PCIE_DEVC_LANE1.pipe_intf.TxDetectRx;
assign device_pipe4_l01_tx_elec_idle   = `PCIE_DEVC_LANE1.pipe_intf.TxElecIdle;  
assign device_pipe4_l01_tx_ones_zeros   = `PCIE_DEVC_LANE1.pipe_intf.pipe4_tx_ones_zeros;
assign device_pipe4_l01_tx_128b_enc_byp = `PCIE_DEVC_LANE1.pipe_intf.pipe4_tx_128b_enc_byp;
assign device_pipe4_l01_tx_deemph       = `PCIE_DEVC_LANE1.pipe_intf.pipe4_tx_deemph;

assign `PCIE_DEVC_LANE1.pipe_intf.PhyStatus     = device_pipe4_l01_phy_status;
assign `PCIE_DEVC_LANE1.pipe_intf.RxData        = device_pipe4_l01_rx_data;
assign `PCIE_DEVC_LANE1.pipe_intf.RxDataK       = device_pipe4_l01_rx_data_k;
assign `PCIE_DEVC_LANE1.pipe_intf.RxSyncHeader  = device_pipe4_l01_rx_sync_header;
assign `PCIE_DEVC_LANE1.pipe_intf.RxStartBlock  = device_pipe4_l01_rx_start_block;
assign `PCIE_DEVC_LANE1.pipe_intf.RxDataValid   = device_pipe4_l01_rx_data_valid;
assign `PCIE_DEVC_LANE1.pipe_intf.RxValid       = device_pipe4_l01_rx_valid;
assign `PCIE_DEVC_LANE1.pipe_intf.RxStatus      = device_pipe4_l01_rx_status;
assign `PCIE_DEVC_LANE1.pipe_intf.RxElecIdle    = device_pipe4_l01_rx_elec_idle;

// PHY/PMA Interface & PMA Clocks
assign device_pma_cmn_refclk_dig_div  = `PCIE_DEVC_LANE0.pipe_intf.pma_cmn_refclk_dig_div ;
assign device_pma_cmn_refclk_dig_sel  = `PCIE_DEVC_LANE0.pipe_intf.pma_cmn_refclk_dig_sel ;
assign device_pma_cmn_pll0_refclk_sel = `PCIE_DEVC_LANE0.pipe_intf.pma_cmn_pll0_refclk_sel;
assign device_pma_cmn_pll1_refclk_sel = `PCIE_DEVC_LANE0.pipe_intf.pma_cmn_pll1_refclk_sel;

// SPACE PINS, Note! assign these pins to init_intf
assign device_pipe7_reset_n             = `PCIE_DEVC_LANE0.init_intf.Reset;
assign device_pipe7_clk_max_req         = `PCIE_DEVC_LANE0.init_intf.pipe7_clk_max_req;
assign device_pipe7_pll0_en             = `PCIE_DEVC_LANE0.init_intf.pipe7_pll0_en;

assign device_pipe7_l00_clk             = 0;
assign device_pipe7_l00_m2p_messagebus  = `PCIE_DEVC_LANE0.init_intf.M2P_MessageBus;
assign device_pipe7_l00_rate            = `PCIE_DEVC_LANE0.init_intf.Rate[1:0];
assign device_pipe7_l00_rx_termination  = `PCIE_DEVC_LANE0.init_intf.RXTermination;
assign device_pipe7_l00_rx_standby      = `PCIE_DEVC_LANE0.init_intf.RxStandby;
assign device_pipe7_l00_powerdown       = `PCIE_DEVC_LANE0.init_intf.PowerDown[2:0];
assign device_pipe7_l00_tx_data         = `PCIE_DEVC_LANE0.init_intf.TxData;
assign device_pipe7_l00_tx_data_valid   = `PCIE_DEVC_LANE0.init_intf.TxDataValid;
assign device_pipe7_l00_tx_det_rx_lpbk  = `PCIE_DEVC_LANE0.init_intf.TxDetectRx;
assign device_pipe7_l00_tx_elec_idle    = `PCIE_DEVC_LANE0.init_intf.TxElecIdle;

assign device_pipe7_l01_clk             = 0;
assign device_pipe7_l01_m2p_messagebus  = `PCIE_DEVC_LANE1.init_intf.M2P_MessageBus;
assign device_pipe7_l01_rate            = `PCIE_DEVC_LANE1.init_intf.Rate[1:0];
assign device_pipe7_l01_rx_termination  = `PCIE_DEVC_LANE1.init_intf.RXTermination;
assign device_pipe7_l01_rx_standby      = `PCIE_DEVC_LANE1.init_intf.RxStandby;
assign device_pipe7_l01_powerdown       = `PCIE_DEVC_LANE1.init_intf.PowerDown[2:0];
assign device_pipe7_l01_tx_data         = `PCIE_DEVC_LANE1.init_intf.TxData;
assign device_pipe7_l01_tx_data_valid   = `PCIE_DEVC_LANE1.init_intf.TxDataValid;
assign device_pipe7_l01_tx_det_rx_lpbk  = `PCIE_DEVC_LANE1.init_intf.TxDetectRx;
assign device_pipe7_l01_tx_elec_idle    = `PCIE_DEVC_LANE1.init_intf.TxElecIdle;

assign device_dp_reset_n                = `PCIE_DEVC_LANE0.init_intf.dp_reset_n;
assign device_pma_xcvr_pllclk_en        = `PCIE_DEVC_LANE0.init_intf.pma_xcvr_pllclk_en;
assign device_pma_xcvr_power_state_req  = `PCIE_DEVC_LANE0.init_intf.pma_xcvr_power_state_req;
assign device_pma_xcvr_data_width       = `PCIE_DEVC_LANE0.init_intf.pma_xcvr_data_width;
assign device_pma_tx_td_clk             = `PCIE_DEVC_LANE0.init_intf.pma_tx_td_clk;
assign device_pma_tx_lfps_en            = `PCIE_DEVC_LANE0.init_intf.pma_tx_lfps_en;
assign device_pma_tx_lfps_mode          = `PCIE_DEVC_LANE0.init_intf.pma_tx_lfps_mode;
assign device_pma_tx_elec_idle_ln_0     = `PCIE_DEVC_LANE0.init_intf.pma_tx_elec_idle_ln;
assign device_pma_tx_td_ln_0            = `PCIE_DEVC_LANE0.init_intf.pma_tx_td_ln;
assign device_pma_tx_elec_idle_ln_1     = `PCIE_DEVC_LANE1.init_intf.pma_tx_elec_idle_ln;
assign device_pma_tx_td_ln_1            = `PCIE_DEVC_LANE1.init_intf.pma_tx_td_ln;
assign device_pma_tx_elec_idle_ln_2     = `PCIE_DEVC_LANE0.init_intf.pma_tx_elec_idle_ln;
assign device_pma_tx_td_ln_2            = `PCIE_DEVC_LANE0.init_intf.pma_tx_td_ln;
assign device_pma_tx_elec_idle_ln_3     = `PCIE_DEVC_LANE1.init_intf.pma_tx_elec_idle_ln;
assign device_pma_tx_td_ln_3            = `PCIE_DEVC_LANE1.init_intf.pma_tx_td_ln;

//------------------------------------------------------------------------
// DP CONNECTIONS
//------------------------------------------------------------------------
`elsif DP
// PHY interface
assign device_phy_mode       = `DP_DEVC_LANE0.pipe_intf.phy_mode;

// Raw interface - Link Signals
assign `DP_DEVC_LANE0.pipe_intf.pma_cmn_ready            = device_pma_cmn_ready;
assign `DP_DEVC_LANE0.pipe_intf.pma_xcvr_pllclk_en_ack   = device_pma_xcvr_pllclk_en_ack;
assign `DP_DEVC_LANE0.pipe_intf.pma_xcvr_power_state_ack = device_pma_xcvr_power_state_ack;
//assign `DP_DEVC_LANE0.pipe_intf. = pma_cmn_avdd_pwrgood; // TODO
assign device_pma_xcvr_pllclk_en       = `DP_DEVC_LANE0.pipe_intf.pma_xcvr_pllclk_en;
assign device_pma_xcvr_power_state_req = `DP_DEVC_LANE0.pipe_intf.pma_xcvr_power_state_req;
assign device_pma_xcvr_data_width      = `DP_DEVC_LANE0.pipe_intf.pma_xcvr_data_width;
assign device_dp_reset_n               = `DP_DEVC_LANE0.pipe_intf.dp_reset_n;
assign device_pma_tx_td_clk            = `DP_DEVC_LANE0.pipe_intf.pma_tx_td_clk;
assign device_pma_tx_lfps_en           = `DP_DEVC_LANE0.pipe_intf.pma_tx_lfps_en;
assign device_pma_tx_lfps_mode         = `DP_DEVC_LANE0.pipe_intf.pma_tx_lfps_mode;
// Raw interface - Lane0 Signals
assign device_pma_tx_elec_idle_ln_0 = `DP_DEVC_LANE0.pipe_intf.pma_tx_elec_idle_ln;
assign device_pma_tx_td_ln_0        = `DP_DEVC_LANE0.pipe_intf.pma_tx_td_ln;
// Raw interface - Lane1 Signals
assign device_pma_tx_elec_idle_ln_1 = `DP_DEVC_LANE1.pipe_intf.pma_tx_elec_idle_ln;
assign device_pma_tx_td_ln_1        = `DP_DEVC_LANE1.pipe_intf.pma_tx_td_ln;
// Raw interface - Lane2 Signals
assign device_pma_tx_elec_idle_ln_2 = `DP_DEVC_LANE2.pipe_intf.pma_tx_elec_idle_ln;
assign device_pma_tx_td_ln_2        = `DP_DEVC_LANE2.pipe_intf.pma_tx_td_ln;
// Raw interface - Lane3 Signals
assign device_pma_tx_elec_idle_ln_3 = `DP_DEVC_LANE3.pipe_intf.pma_tx_elec_idle_ln;
assign device_pma_tx_td_ln_3        = `DP_DEVC_LANE3.pipe_intf.pma_tx_td_ln;

// PHY/PMA Interface & PMA Clocks
assign device_pma_cmn_refclk_dig_div  = `DP_DEVC_LANE0.pipe_intf.pma_cmn_refclk_dig_div ;
assign device_pma_cmn_refclk_dig_sel  = `DP_DEVC_LANE0.pipe_intf.pma_cmn_refclk_dig_sel ;
assign device_pma_cmn_pll0_refclk_sel = `DP_DEVC_LANE0.pipe_intf.pma_cmn_pll0_refclk_sel;
assign device_pma_cmn_pll1_refclk_sel = `DP_DEVC_LANE0.pipe_intf.pma_cmn_pll1_refclk_sel;

// SPACE PINS, Note! assign these pins to init_intf
assign device_pipe7_reset_n             = `DP_DEVC_LANE0.init_intf.Reset;
assign device_pipe7_clk_max_req         = `DP_DEVC_LANE0.init_intf.pipe7_clk_max_req;
assign device_pipe7_pll0_en             = `DP_DEVC_LANE0.init_intf.pipe7_pll0_en;

assign device_pipe7_l00_clk             = 0;
assign device_pipe7_l00_m2p_messagebus  = `DP_DEVC_LANE0.init_intf.M2P_MessageBus;
assign device_pipe7_l00_rate            = `DP_DEVC_LANE0.init_intf.Rate[1:0];
assign device_pipe7_l00_rx_termination  = `DP_DEVC_LANE0.init_intf.RXTermination;
assign device_pipe7_l00_rx_standby      = `DP_DEVC_LANE0.init_intf.RxStandby;
assign device_pipe7_l00_powerdown       = `DP_DEVC_LANE0.init_intf.PowerDown[2:0];
assign device_pipe7_l00_tx_data         = `DP_DEVC_LANE0.init_intf.TxData;
assign device_pipe7_l00_tx_data_valid   = `DP_DEVC_LANE0.init_intf.TxDataValid;
assign device_pipe7_l00_tx_det_rx_lpbk  = `DP_DEVC_LANE0.init_intf.TxDetectRx;
assign device_pipe7_l00_tx_elec_idle    = `DP_DEVC_LANE0.init_intf.TxElecIdle;

assign device_pipe7_l01_clk             = 0;
assign device_pipe7_l01_m2p_messagebus  = `DP_DEVC_LANE1.init_intf.M2P_MessageBus;
assign device_pipe7_l01_rate            = `DP_DEVC_LANE1.init_intf.Rate[1:0];
assign device_pipe7_l01_rx_termination  = `DP_DEVC_LANE1.init_intf.RXTermination;
assign device_pipe7_l01_rx_standby      = `DP_DEVC_LANE1.init_intf.RxStandby;
assign device_pipe7_l01_powerdown       = `DP_DEVC_LANE1.init_intf.PowerDown[2:0];
assign device_pipe7_l01_tx_data         = `DP_DEVC_LANE1.init_intf.TxData;
assign device_pipe7_l01_tx_data_valid   = `DP_DEVC_LANE1.init_intf.TxDataValid;
assign device_pipe7_l01_tx_det_rx_lpbk  = `DP_DEVC_LANE1.init_intf.TxDetectRx;
assign device_pipe7_l01_tx_elec_idle    = `DP_DEVC_LANE1.init_intf.TxElecIdle;

assign device_pipe4_reset_n             = `DP_DEVC_LANE0.init_intf.Reset;
assign device_pipe4_rate                = `DP_DEVC_LANE0.init_intf.Rate[0];
assign device_pipe4_powerdown           = `DP_DEVC_LANE0.init_intf.PowerDown[1:0];
assign device_pipe4_eb_mode             = `DP_DEVC_LANE0.init_intf.pipe4_eb_mode;

assign device_pipe4_l00_rx_polarity     = `DP_DEVC_LANE0.init_intf.pipe4_rx_polarity;
assign device_pipe4_l00_rx_eq_training  = `DP_DEVC_LANE0.init_intf.pipe4_rx_eq_training;
assign device_pipe4_l00_rx_termination  = `DP_DEVC_LANE0.init_intf.RXTermination;
assign device_pipe4_l00_tx_data         = `DP_DEVC_LANE0.init_intf.TxData;
assign device_pipe4_l00_tx_data_k       = `DP_DEVC_LANE0.init_intf.TxDataK;  
assign device_pipe4_l00_tx_sync_header  = `DP_DEVC_LANE0.init_intf.TxSyncHeader;
assign device_pipe4_l00_tx_start_block  = `DP_DEVC_LANE0.init_intf.TxStartBlock;
assign device_pipe4_l00_tx_data_valid   = `DP_DEVC_LANE0.init_intf.TxDataValid;
assign device_pipe4_l00_tx_det_rx_lpbk  = `DP_DEVC_LANE0.init_intf.TxDetectRx;
assign device_pipe4_l00_tx_elec_idle    = `DP_DEVC_LANE0.init_intf.TxElecIdle;
assign device_pipe4_l00_tx_ones_zeros   = `DP_DEVC_LANE0.init_intf.pipe4_tx_ones_zeros;
assign device_pipe4_l00_tx_128b_enc_byp = `DP_DEVC_LANE0.init_intf.pipe4_tx_128b_enc_byp;
assign device_pipe4_l00_tx_deemph       = `DP_DEVC_LANE0.init_intf.pipe4_tx_deemph;

assign device_pipe4_l01_rx_polarity     = `DP_DEVC_LANE1.init_intf.pipe4_rx_polarity;
assign device_pipe4_l01_rx_eq_training  = `DP_DEVC_LANE1.init_intf.pipe4_rx_eq_training;
assign device_pipe4_l01_rx_termination  = `DP_DEVC_LANE1.init_intf.RXTermination;
assign device_pipe4_l01_tx_data         = `DP_DEVC_LANE1.init_intf.TxData;  
assign device_pipe4_l01_tx_data_k       = `DP_DEVC_LANE1.init_intf.TxDataK;  
assign device_pipe4_l01_tx_sync_header  = `DP_DEVC_LANE1.init_intf.TxSyncHeader;  
assign device_pipe4_l01_tx_start_block  = `DP_DEVC_LANE1.init_intf.TxStartBlock;  
assign device_pipe4_l01_tx_data_valid   = `DP_DEVC_LANE1.init_intf.TxDataValid;  
assign device_pipe4_l01_tx_det_rx_lpbk  = `DP_DEVC_LANE1.init_intf.TxDetectRx;
assign device_pipe4_l01_tx_elec_idle    = `DP_DEVC_LANE1.init_intf.TxElecIdle;  
assign device_pipe4_l01_tx_ones_zeros   = `DP_DEVC_LANE1.init_intf.pipe4_tx_ones_zeros;
assign device_pipe4_l01_tx_128b_enc_byp = `DP_DEVC_LANE1.init_intf.pipe4_tx_128b_enc_byp;
assign device_pipe4_l01_tx_deemph       = `DP_DEVC_LANE1.init_intf.pipe4_tx_deemph;

//------------------------------------------------------------------------
// ALT_MODE CONNECTIONS
//------------------------------------------------------------------------
`elsif ALT_MODE
//---------------------------------- USB32 --------------------------------------//
// Original PIPE interface, For USB3 or PCIe1/2/3/4
//assign `USB32_DEVC_LANE0.pclk = pipe4_clk; // TODO
assign device_pipe4_reset_n   = `USB32_DEVC_LANE0.pipe_intf.Reset;
assign device_pipe4_rate      = `USB32_DEVC_LANE0.pipe_intf.Rate[0];
assign device_pipe4_powerdown = `USB32_DEVC_LANE0.pipe_intf.PowerDown[1:0];
assign device_pipe4_eb_mode   = `USB32_DEVC_LANE0.pipe_intf.pipe4_eb_mode;

// Original PIPE - Lane0 Signals
assign device_pipe4_l00_rx_polarity     = `USB32_DEVC_LANE0.pipe_intf.pipe4_rx_polarity;
assign device_pipe4_l00_rx_eq_training  = `USB32_DEVC_LANE0.pipe_intf.pipe4_rx_eq_training;
assign device_pipe4_l00_rx_termination  = `USB32_DEVC_LANE0.pipe_intf.RXTermination;
assign device_pipe4_l00_tx_data         = `USB32_DEVC_LANE0.pipe_intf.TxData;
assign device_pipe4_l00_tx_data_k       = `USB32_DEVC_LANE0.pipe_intf.TxDataK;  
assign device_pipe4_l00_tx_sync_header  = `USB32_DEVC_LANE0.pipe_intf.TxSyncHeader;
assign device_pipe4_l00_tx_start_block  = `USB32_DEVC_LANE0.pipe_intf.TxStartBlock;
assign device_pipe4_l00_tx_data_valid   = `USB32_DEVC_LANE0.pipe_intf.TxDataValid;
assign device_pipe4_l00_tx_det_rx_lpbk  = `USB32_DEVC_LANE0.pipe_intf.TxDetectRx;
assign device_pipe4_l00_tx_elec_idle    = `USB32_DEVC_LANE0.pipe_intf.TxElecIdle;
assign device_pipe4_l00_tx_ones_zeros   = `USB32_DEVC_LANE0.pipe_intf.pipe4_tx_ones_zeros;
assign device_pipe4_l00_tx_128b_enc_byp = `USB32_DEVC_LANE0.pipe_intf.pipe4_tx_128b_enc_byp;
assign device_pipe4_l00_tx_deemph       = `USB32_DEVC_LANE0.pipe_intf.pipe4_tx_deemph;

assign `USB32_DEVC_LANE0.pipe_intf.PhyStatus     = device_pipe4_l00_phy_status;
assign `USB32_DEVC_LANE0.pipe_intf.RxData        = device_pipe4_l00_rx_data;
assign `USB32_DEVC_LANE0.pipe_intf.RxDataK       = device_pipe4_l00_rx_data_k;
assign `USB32_DEVC_LANE0.pipe_intf.RxSyncHeader  = device_pipe4_l00_rx_sync_header;
assign `USB32_DEVC_LANE0.pipe_intf.RxStartBlock  = device_pipe4_l00_rx_start_block;
assign `USB32_DEVC_LANE0.pipe_intf.RxDataValid   = device_pipe4_l00_rx_data_valid;
assign `USB32_DEVC_LANE0.pipe_intf.RxValid       = device_pipe4_l00_rx_valid;
assign `USB32_DEVC_LANE0.pipe_intf.RxStatus      = device_pipe4_l00_rx_status;
assign `USB32_DEVC_LANE0.pipe_intf.RxElecIdle    = device_pipe4_l00_rx_elec_idle;

//---------------------------------- DP --------------------------------------//
// Raw interface - Link Signals
assign `DP_DEVC_LANE0.pipe_intf.pma_cmn_ready            = device_pma_cmn_ready;
assign `DP_DEVC_LANE0.pipe_intf.pma_xcvr_pllclk_en_ack   = device_pma_xcvr_pllclk_en_ack;
assign `DP_DEVC_LANE0.pipe_intf.pma_xcvr_power_state_ack = device_pma_xcvr_power_state_ack;
//assign `DP_DEVC_LANE0.pipe_intf. = pma_cmn_avdd_pwrgood; // TODO
assign device_pma_xcvr_pllclk_en       = `DP_DEVC_LANE0.pipe_intf.pma_xcvr_pllclk_en;
assign device_pma_xcvr_power_state_req = `DP_DEVC_LANE0.pipe_intf.pma_xcvr_power_state_req;
assign device_pma_xcvr_data_width      = `DP_DEVC_LANE0.pipe_intf.pma_xcvr_data_width;
assign device_dp_reset_n               = `DP_DEVC_LANE0.pipe_intf.dp_reset_n;
assign device_pma_tx_td_clk            = `DP_DEVC_LANE0.pipe_intf.pma_tx_td_clk;
assign device_pma_tx_lfps_en           = `DP_DEVC_LANE0.pipe_intf.pma_tx_lfps_en;
assign device_pma_tx_lfps_mode         = `DP_DEVC_LANE0.pipe_intf.pma_tx_lfps_mode;
// Raw interface - Lane0 Signals
assign device_pma_tx_elec_idle_ln_0 = `DP_DEVC_LANE0.pipe_intf.pma_tx_elec_idle_ln;
assign device_pma_tx_td_ln_0        = `DP_DEVC_LANE0.pipe_intf.pma_tx_td_ln;
// Raw interface - Lane1 Signals
assign device_pma_tx_elec_idle_ln_1 = `DP_DEVC_LANE1.pipe_intf.pma_tx_elec_idle_ln;
assign device_pma_tx_td_ln_1        = `DP_DEVC_LANE1.pipe_intf.pma_tx_td_ln;

//---------------------------------- COMMON --------------------------------------//
// PHY interface
assign device_phy_mode       = `USB32_DEVC_LANE0.pipe_intf.phy_mode;

// PHY/PMA Interface & PMA Clocks
assign device_pma_cmn_refclk_dig_div  = `USB32_DEVC_LANE0.pipe_intf.pma_cmn_refclk_dig_div ;
assign device_pma_cmn_refclk_dig_sel  = `USB32_DEVC_LANE0.pipe_intf.pma_cmn_refclk_dig_sel ;
assign device_pma_cmn_pll0_refclk_sel = `USB32_DEVC_LANE0.pipe_intf.pma_cmn_pll0_refclk_sel;
assign device_pma_cmn_pll1_refclk_sel = `USB32_DEVC_LANE0.pipe_intf.pma_cmn_pll1_refclk_sel;


// SPACE PINS, Note! assign these pins to init_intf
assign device_pipe7_reset_n             = `USB32_DEVC_LANE0.init_intf.Reset;
assign device_pipe7_clk_max_req         = `USB32_DEVC_LANE0.init_intf.pipe7_clk_max_req;
assign device_pipe7_pll0_en             = `USB32_DEVC_LANE0.init_intf.pipe7_pll0_en;

assign device_pipe7_l00_clk             = 0;
assign device_pipe7_l00_m2p_messagebus  = `USB32_DEVC_LANE0.init_intf.M2P_MessageBus;
assign device_pipe7_l00_rate            = `USB32_DEVC_LANE0.init_intf.Rate[1:0];
assign device_pipe7_l00_rx_termination  = `USB32_DEVC_LANE0.init_intf.RXTermination;
assign device_pipe7_l00_rx_standby      = `USB32_DEVC_LANE0.init_intf.RxStandby;
assign device_pipe7_l00_powerdown       = `USB32_DEVC_LANE0.init_intf.PowerDown[2:0];
assign device_pipe7_l00_tx_data         = `USB32_DEVC_LANE0.init_intf.TxData;
assign device_pipe7_l00_tx_data_valid   = `USB32_DEVC_LANE0.init_intf.TxDataValid;
assign device_pipe7_l00_tx_det_rx_lpbk  = `USB32_DEVC_LANE0.init_intf.TxDetectRx;
assign device_pipe7_l00_tx_elec_idle    = `USB32_DEVC_LANE0.init_intf.TxElecIdle;

assign device_pipe7_l01_clk             = 0;
assign device_pipe7_l01_m2p_messagebus  = `USB32_DEVC_LANE0.init_intf.M2P_MessageBus;
assign device_pipe7_l01_rate            = `USB32_DEVC_LANE0.init_intf.Rate[1:0];
assign device_pipe7_l01_rx_termination  = `USB32_DEVC_LANE0.init_intf.RXTermination;
assign device_pipe7_l01_rx_standby      = `USB32_DEVC_LANE0.init_intf.RxStandby;
assign device_pipe7_l01_powerdown       = `USB32_DEVC_LANE0.init_intf.PowerDown[2:0];
assign device_pipe7_l01_tx_data         = `USB32_DEVC_LANE0.init_intf.TxData;
assign device_pipe7_l01_tx_data_valid   = `USB32_DEVC_LANE0.init_intf.TxDataValid;
assign device_pipe7_l01_tx_det_rx_lpbk  = `USB32_DEVC_LANE0.init_intf.TxDetectRx;
assign device_pipe7_l01_tx_elec_idle    = `USB32_DEVC_LANE0.init_intf.TxElecIdle;

assign device_pipe4_l01_rx_polarity     = `USB32_DEVC_LANE0.init_intf.pipe4_rx_polarity;
assign device_pipe4_l01_rx_eq_training  = `USB32_DEVC_LANE0.init_intf.pipe4_rx_eq_training;
assign device_pipe4_l01_rx_termination  = `USB32_DEVC_LANE0.init_intf.RXTermination;
assign device_pipe4_l01_tx_data         = `USB32_DEVC_LANE0.init_intf.TxData;  
assign device_pipe4_l01_tx_data_k       = `USB32_DEVC_LANE0.init_intf.TxDataK;  
assign device_pipe4_l01_tx_sync_header  = `USB32_DEVC_LANE0.init_intf.TxSyncHeader;  
assign device_pipe4_l01_tx_start_block  = `USB32_DEVC_LANE0.init_intf.TxStartBlock;  
assign device_pipe4_l01_tx_data_valid   = `USB32_DEVC_LANE0.init_intf.TxDataValid;  
assign device_pipe4_l01_tx_det_rx_lpbk  = `USB32_DEVC_LANE0.init_intf.TxDetectRx;
assign device_pipe4_l01_tx_elec_idle    = `USB32_DEVC_LANE0.init_intf.TxElecIdle;  
assign device_pipe4_l01_tx_ones_zeros   = `USB32_DEVC_LANE0.init_intf.pipe4_tx_ones_zeros;
assign device_pipe4_l01_tx_128b_enc_byp = `USB32_DEVC_LANE0.init_intf.pipe4_tx_128b_enc_byp;
assign device_pipe4_l01_tx_deemph       = `USB32_DEVC_LANE0.init_intf.pipe4_tx_deemph;

assign device_pma_tx_elec_idle_ln_2     = `USB32_DEVC_LANE0.init_intf.pma_tx_elec_idle_ln;
assign device_pma_tx_td_ln_2            = `USB32_DEVC_LANE0.init_intf.pma_tx_td_ln;
assign device_pma_tx_elec_idle_ln_3     = `USB32_DEVC_LANE0.init_intf.pma_tx_elec_idle_ln;
assign device_pma_tx_td_ln_3            = `USB32_DEVC_LANE0.init_intf.pma_tx_td_ln;

`endif
`endif


`include"top_dut_wrapper.sv"

`endif
