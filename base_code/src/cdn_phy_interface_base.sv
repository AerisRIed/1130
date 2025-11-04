//
// Template for UVM-compliant interface
//

`ifndef CDN_PHY_INTERFACE_BASE__SV
`define CDN_PHY_INTERFACE_BASE__SV

interface cdn_phy_interface_base #(parameter PD_WIDTH = 8)(input bit clk,input bit rst,input bit alt_mode_usb32);
    logic pclk ; 
    //assign pclk = clk;
    serdes_if#(.PD_WIDTH(tb_param::SERDES_WIDTH)) serdes_tx();   //SV serdes model , each lane has two serdes_io , tx and rx  
    serdes_if#(.PD_WIDTH(tb_param::SERDES_WIDTH)) serdes_rx();   //SV serdes model , each lane has two serdes_io , tx and rx  

`ifdef USB32
    cdn_usb32_debug_interface#(.PD_WIDTH(PD_WIDTH))   usb32_debug_intf();
    assign #1 serdes_tx.pd_in       = usb32_debug_intf.pd_data;
    assign serdes_tx.pd_valid_in    = usb32_debug_intf.serdes_tx_valid;
`elsif USB4
    cdn_usb4_debug_interface#(.PD_WIDTH(PD_WIDTH))    usb4_debug_intf();
    assign #1 serdes_tx.pd_in       = usb4_debug_intf.pd_data;
    assign serdes_tx.pd_valid_in    = usb4_debug_intf.serdes_tx_valid;
`elsif PCIE
    cdn_pcie_debug_interface#(.PD_WIDTH(PD_WIDTH))    pcie_debug_intf();
    assign #1 serdes_tx.pd_in       = pcie_debug_intf.pd_data;
    assign serdes_tx.pd_valid_in    = pcie_debug_intf.serdes_tx_valid;
`elsif DP
    cdn_dp_debug_interface#(.PD_WIDTH(PD_WIDTH))      dp_debug_intf();
    assign #1 serdes_tx.pd_in       = dp_debug_intf.pd_data;
    assign serdes_tx.pd_valid_in    = dp_debug_intf.serdes_tx_valid;
`else
    cdn_dp_debug_interface#(.PD_WIDTH(PD_WIDTH))      dp_debug_intf();
    cdn_usb32_debug_interface#(.PD_WIDTH(PD_WIDTH))   usb32_debug_intf();
    assign #1 serdes_tx.pd_in       = alt_mode_usb32 ? usb32_debug_intf.pd_data : dp_debug_intf.pd_data;
    assign serdes_tx.pd_valid_in    = alt_mode_usb32 ? usb32_debug_intf.serdes_tx_valid : dp_debug_intf.serdes_tx_valid;
`endif
    cdn_phy_pipe_interface#(.PIPE_PD_WIDTH(PD_WIDTH)) pipe_intf();
    cdn_phy_pipe_interface#(.PIPE_PD_WIDTH(PD_WIDTH)) init_intf(); // only used to initialize the value of space pins 
    cdn_phy_status_interface                          status_intf();
	cdn_message_bus_debug_interface message_bus_debug_if();
    //------------------------------RTL serdes model------------------//
    //sd_serializer#(.PD_WIDTH(PD_WIDTH)) serdes_intf(sd_clk,debug_intf.pd_data,32,0,debug_intf.serdes_tx_valid,1);
    //sd_deserializer_lock de_serdes_intf();
    //assign de_serdes_intf.input_sample_clk = sd_sample_clk;
    //assign de_serdes_intf.use_input_sample_clk = 0;
    //assign de_serdes_intf.gen_mode = 4'd1;
    //assign de_serdes_intf.protocol = 8'd1;
    //assign de_serdes_intf.rx_p = serdes_intf.serial_out;
    //assign de_serdes_intf.rx_m = ~serdes_intf.serial_out;
    //assign de_serdes_intf.align_bypass =0;
    //assign de_serdes_intf.use_v0_5_eieos=0;            // SER-7099, if set, GEN4 v.07 EIEOS pattern is used 
    //                                            // Otherwise GEN4 v.05 EIEOS pattern is used
    //assign de_serdes_intf.ccix_edr = 0;         // 0 CCIX Not enable;  1 CCIX Extended Data Rate is enabled over PCIe
    //assign de_serdes_intf.ccix_esm_0=0;      // 0=8G,  1=16G
    //assign de_serdes_intf.ccix_esm_1=0;     // 0=20G, 1=25G
    
    assign serdes_tx.pd_clk_in      = clk;
    assign serdes_tx.en             = 1;
    assign serdes_tx.is_tx          = 1;  //Tx
    
    assign serdes_rx.en             = 1;
    assign serdes_rx.is_tx          = 0;  //Rx
    
    //----------------------------- DP clk and rst ------------------//
    assign pipe_intf.pma_tx_td_clk  = clk;
    
endinterface: cdn_phy_interface_base

`include"cdn_usb32_debug_interface.sv"
interface cdn_phy_pipe_interface#(parameter PIPE_PD_WIDTH = 8) ();
    logic TxElecIdle;
    
   // PIPE interface signals - begin

  // Common for SerDes and Original PIPE - Data related
   logic [PIPE_PD_WIDTH-1:0]                TxData; // 
   logic [PIPE_PD_WIDTH-1:0]                TxData2; // DisplayPort Tx, USB4
   logic                                    TxDataValid;// 
   logic [PIPE_PD_WIDTH-1:0]                RxData; // 
   logic [PIPE_PD_WIDTH-1:0]                RxData2; // DisplayPort Tx, USB4
   // Common for SerDes and Original PIPE - Command related
   logic [3:0]                              PHYmode; // 
   logic                                    DP_mode_Tx_Rx;// DisplayPort
   logic                                    SerDesArch;// 
   logic                                    SRISEnable;// PCIe
   logic                                    TxDetectRx;// 
   logic                                    TxDetectRx2;// USB4, DisplayPort Tx
  // logic [3:0]                            TxElecIdle; // 
   logic                                    TxElecIdle2; // USB4, DisplayPort Tx
   logic                                    Reset;// 
   logic [3:0]                              PowerDown; // 
   logic [1:0]                              ShortChannelPowerControl; // PCIe
   logic                                    RxEIDetectDisable;// 
   logic                                    RxEIDetectDisable2;// USB4
   logic                                    TxCommonmodeDisable;// PCIe
   logic                                    DeepPMReq;// 
   logic                                    Restore;// 
   logic [3:0]                              Rate;// 
   logic [2:0]                              Width; // 
   logic [4:0]                              PCLKRate; // 
   logic                                    RXTermination; // 
   logic                                    RxStandby; // 
   logic                                    RxStandby2; // USB4
   logic                                    RefClkRequired; // PCIe
   logic                                    RxStandbyStatus; // 
   logic                                    RxStandbyStatus2; // USB4
   // Common for SerDes and Original PIPE - Status related
   logic                                    PclkChangeAck; // 
   logic                                    AsyncPowerChangeAck; // PCIe
   logic                                    RxValid; // 
   logic                                    RxValid2; // DisplayPort Rx, USB4
   logic                                    PhyStatus; //
   logic                                    RxElecIdle; //
   logic                                    RxElecIdle2; // USB4
   logic [2:0]                              RxStatus; //
   logic                                    PowerPresent; // USB
   logic                                    PclkChangeOk; // 
   logic                                    DeepPMAck; //
   // Common for SerDes and Original PIPE - Message Bus related
   logic [7:0]                              M2P_MessageBus; //
   logic [7:0]                              P2M_MessageBus; // 
   
   // SerDes Architecture Only - Data related
   logic                                    RxCLK; //
   logic                                    RxCLK2; // DisplayPort Rx
   // SerDes Architecture Only - Command related
   logic [2:0]                              RxWidth; //
   // SerDes Architecture Only - MacCLK Lane related
   
   // Original PIPE Only - Data related
   logic [PIPE_PD_WIDTH/8-1:0]              TxDataK; //
   logic                                    TxStartBlock; // PCIe and USB
   logic [PIPE_PD_WIDTH/8-1:0]              RxDataK; // 
   logic                                    RxDataValid; // PCIe, USB
   logic                                    RxStartBlock; // PCIe, USB
   // Original PIPE Only - Command related
   logic                                    TxCompliance; // PCIe
   logic [3:0]                              TxSyncHeader; // PCIe and USB
   logic [3:0]                              RxSyncHeader; // PCIe and USB
   
   // External Signals – Common for SerDes and Original PIPE
   logic                                    CLK; // 
   logic                                    PCLK; //
   logic                                    MaxPCLK; //
   logic [1:0]                              DataBusWidth; //

   // PIPE interface signals - end

   // DP interface signals - begin

   logic                                    dp_reset_n;
   logic                                    pma_cmn_ready;
   logic                                    pma_xcvr_pllclk_en;
   logic                                    pma_xcvr_pllclk_en_ack;
   logic [5:0]                              pma_xcvr_power_state_req;
   logic [5:0]                              pma_xcvr_power_state_ack;
   logic                                    pma_tx_td_clk;
   logic [31:0]                             pma_tx_td_ln; // pma_tx_td_ln_{3:0}
   logic [2:0]                              pma_xcvr_data_width;
   logic                                    pma_tx_elec_idle_ln; // pma_tx_elec_idle_ln_{3:0}
   logic                                    pma_tx_lfps_mode;
   logic                                    pma_tx_lfps_en;

   // DP interface signals - end

   // PIPE7 interface signals - begin

   logic                                    pipe7_clk_max;
   logic                                    pipe7_clk_max_req;
   logic                                    pipe7_clk_max_ack;
   logic                                    pipe7_pll0_en;
   logic                                    pipe7_pll0_ok;

   // PIPE7 interface signals - end

   // PIPE4 interface signals - begin

   logic                                    pipe4_eb_mode;
   logic                                    pipe4_rx_polarity;
   logic                                    pipe4_rx_eq_training;
   logic                                    pipe4_tx_ones_zeros;
   logic                                    pipe4_tx_128b_enc_byp;
   logic [1:0]                              pipe4_tx_deemph;

   // PIPE4 interface signals - end

   // PHY/PMA interface signals - begin

   logic                                    phy_uc_init_complete;
   logic                                    phy_error_interrupt;
   logic                                    typec_conn_dir;
   logic                                    phy_interrupt_usb;
   logic                                    phy_interrupt_dp;
   logic [3:0]                              phy_mode;
   logic                                    phy_l00_ctlr_interrupt_in;
   logic                                    phy_l01_ctlr_interrupt_in;

   logic [1:0]                              pma_cmn_refclk_dig_div;
   logic                                    pma_cmn_refclk_dig_sel;
   logic [1:0]                              pma_cmn_pll0_refclk_sel;
   logic [1:0]                              pma_cmn_pll1_refclk_sel;

   // PHY/PMA interface signals - end

endinterface

interface cdn_phy_serdes_interface;
   logic sdp; 
   logic sdn; 
   logic                                    TXP;// PCIe, USB, DisplayPort Tx, and USB4
   logic                                    TXN;// PCIe, USB, DisplayPort Tx, and USB4
   logic                                    TX2P;// DisplayPort Tx, USB4
   logic                                    TX2N;// DisplayPort Tx, USB4
   logic                                    RXP;// PCIe, USB, DisplayPort Tx, and USB4
   logic                                    RXN;// PCIe, USB, DisplayPort Tx, and USB4
   logic                                    RX2P;// DisplayPort Tx, USB4
   logic                                    RX2N;// DisplayPort Tx, USB4
endinterface

interface cdn_phy_status_interface ();
   bit                                                               link_trg_en;
   cdn_phy_package::dp_link_trg_t                                    link_trg_stage;
   cdn_phy_package::dp_link_tps_t                                    link_trg_tps;
   cdn_phy_package::dp_bit_rate_t                                    data_rate;
endinterface

interface cdn_phy_design_interface();
    logic phy_uc_init_complete;
endinterface


interface cdn_message_bus_debug_interface ();
import cdn_message_bus_pkg::*;

tx_state_t        tx_state;
rx_state_t        rx_state;
//bit pclk;
//bit reset;
bit [7:0]m2p_message_bus;
bit [7:0]p2m_message_bus;

message_bus_cmd_t cmd_out;
bit [7:0]data_out;
bit [11:0]addr_out;
message_bus_cmd_t cmd_in;
bit [7:0]data_in;
bit [11:0]addr_in;
bit wait_ack_en;
bit write_ack_en;
endinterface
`endif // CDN_PHY_INTERFACE_BASE__SV
