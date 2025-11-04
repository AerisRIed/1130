/**********************************************************
* File Name: mp_pcs_top.sv
* Author: DongdongWang
* mail: dwang@cadence.com
* Created Time: Thu 17 Jul 2025 03:47:49 AM CST
**********************************************************/

// Below define must to defined:
//   MP_128B_PATH        --- 
//   MP_128B_PATH_32_BIT ---
// For TimberWolf, below defines must be defined:
//   MP_USB              ---
//   MP_USB3_2           --- 
// For TimberWolf, below defines must not be defined:  
//   MP_PCIE             ---
//   MP_SATA             --- 

module mp_pcs_top #(

)(
    //-------------------- common interface for message bus & original PIPE & SERDES PIPE --------------------//
    input               psm_clk                        , // Power state machine clock
    input               psm_rst_n                      , // Asynchronous reset    
    input               rx_rd_clk                      , // PMA recovered clock (500MHz)
    input               rx_rst_n                       , // Asynchronous reset
    input               ref_clk                        , // Slow frequency reference clock
    input               ref_rst_n                      , // Asynchronous reset

    input               phy_mode_usb3_en               , // from pcs_iso_cmn
    input               phy_mode_usb4_en               , // from pcs_iso_cmn
    //input               phy_mode_dp_en                 , // from pcs_iso_cmn

    input               pipe_32bit_en                  ,

    input			    scanmode                       , // PHY scan mode signal
    input               scanen_cg                      ,    

    //-------------------- message bus -------------------- //
    input			    mb_mac2phy_clk                 , // PHY MB MAC2PHY Clock: Based on PIPE interface data width --> 500MHz (32-bit) or 1GHz (16-bit)
    input			    mb_mac2phy_rstn                , // PHY MB MAC2PHY Reset: Active Low
    
    input			    mb_phy2mac_clk                 , // PHY MB PHY2MAC Clock: Based on PIPE interface data width --> 500MHz (32-bit) or 1GHz (16-bit)
    input			    mb_phy2mac_rstn                , // PHY MB PHY2MAC Reset: Active Low

    //M2P and P2M data busses
    input		[7:0]	mb_pipe_rx_data                , // PHY MB Receive data bus
    output		[7:0]	mb_pipe_tx_data                , // PHY MB Transmit data bus
    input			    mb_pipe_tx_disable             , // PHY MB disable
    
    input			    mb_cdb_reset                   , // PHY CDB: Soft Reset for entire MB block including all sub-blocks
    input			    mb_cdb_rx_reset                , // PHY CDB: Soft Reset for PIPE interface receive logic (mb_pipe_rx_ctrl.v)
    input			    mb_cdb_tx_reset                , // PHY CDB: Soft Reset for PIPE interface transmit logic (mb_pipe_tx_ctrl.v)
    input			    mb_cdb_pma_reset               , // PHY CDB: Soft Reset for PMA interface transmit/receive logics (lm_pma_txrx_ctrl.v)
    input			    mb_cdb_ctrl_reset              , // PHY CDB: Soft Reset for master co-ordintation controller logics (lm_phy_ctrl.v)
    input		[3:0]	mb_lm_cdb_pma_wait             , // PHY CDB: Static. Programmable wait time for between rx_mrgn_offset loading and rx_mrgn_req assertion
    input		[5:0]	mb_lm_cdb_sample_3logn         , // PHY CDB: Static. Programmable Rx margining sample count
    input		[7:0]	mb_lm_cdb_sample_max           , // PHY CDB: Static. Programmable Rx margining sample count max value (Default: 8'd127)
    input		[7:0]	mb_lm_cdb_sample_threshold     , // PHY CDB: Static. Programmable Rx margining sample count threshold (Default: 8'd129)
    input		[7:0]	mb_lm_cdb_pma_direction        , // PHY CDB: Static. Programmable margin direction to handle PIPE and PMA encodings for margin direction
    input		[5:0]	mb_lm_cdb_error_max            , // PHY CDB: Static. Programmable Rx margining error count max value (Default: 6'd63)
    input		[5:0]	mb_lm_cdb_error_threshold      , // PHY CDB: Static. Programmable Rx margining error count threshold (Default: 6'd63)
    input		[5:0]	mb_lm_cdb_timing_offset        , // PHY CDB: Static. Programmable Max timing offset value supported by PMA
    input		[6:0]	mb_lm_cdb_voltage_offset       , // PHY CDB: Static. Programmable Max voltage offset value supported by PMA
    input               mb_cdb_rx_eq_eval_sel          , // PHY CDB: Static. direction change or figure of merit selection(0 = dir change and 1 = FoM)
    output	    		mb_lm_cdb_smplcnt_saturated    , // PHY CDB: Sample Count Saturated
    output	    		mb_lm_cdb_errcnt_saturated     , // PHY CDB: Error Count Saturated    
    output	    		mb_cdb_invalid_addr_uncom      , // PHY CDB: Invalid address detected during MAC uncommitted write
    output 	    		mb_cdb_invalid_addr_com        , // PHY CDB: Invalid address detected during MAC committed write
    
    // IO Recal interface with PHY
    input			    mb_p2m_recal_req               , // From PCS ISO CTRL, uc will take over this function
    input			    mb_phy_recal_done              , // From PCS ISO CTRL
    output			    mb_m2p_recal_req               , // To PCS ISO CTRL
    
    output              mb_nelb_enable                 ,
    output      [2:0]   mb_nelb_position               , 

    `ifdef LM_DEP_OPTION
    input               mb_lm_dep                      , // PHY CDB: Static. select destructive margining
    `endif

    //-------------------- mp_pcs_lane_v3 -------------------- //
    // Clock and Reset    
    input             pipe4_clk_out                  , // PIPE interface clock (for PIPE outputs)
    input             pipe4_out_rst_n                , // Reset for pipe_clk_out
    input             pipe4_clk_in                   , // PIPE interface clock (for PIPE inputs)
    input             pipe4_in_rst_n                 , // Reset for pipe_clk_in

    input             tx_datart_clk                  , // Transmit data rate clock (500MHz)
    input             tx_datart_rst_n                , // Asynchronous reset
    input             rx_datart_clk                  , // Receive data rate clock (500MHz)
    input             rx_datart_rst_n                , // Asynchronous reset

    // Control and Status
    input             pipe4_phy_link_cfg             , // 1 = master lane, 0 = slave lane    
    input             pipe4_lane_dis                 , // Disable lanes, from pcs iso ctrl cmn
    output            pipe4_lane_off                 , // Lane disable
    
    output            pipe4_clk_en                   , // Clock gating enable, to phy top clk_rst
    
    input             pipe4_usb_lpbkslv_ec_disable   , // (USB) NO EC insert into BCNT OS, from pcs iso ctrl cmn register
    output [7:0]      pipe4_usb_lpbkslv_ec           , // (USB) Current loopback error count, to pcs iso ctrl ln register
    
    // L1 substate interface
    input             pipe4_phy_ent_l1_x             , // Request to enter L1 sub-state, from MAC
    output            pipe4_phy_ack_l1_x             , // L1.x state. to MAC

    // Control of Rx electrical idle during L1.x and upon exit
    input             pipe4_pcs_l1_x_exit_reset_n    , // From phy top clk rst
    input             pipe4_l1_x_exit_gate_ext       , // From phy top power control
    
    //`ifdef MP_SRC_SYNC_PCLK
    //input             pipe4_fifo_wr_en_adj           , // from adjacent/master lane
    //input             pipe4_fifo_rd_en_adj           ,
    //output            pipe4_fifo_wr_en               , // to adjacent/salve lane
    //output            pipe4_fifo_rd_en               ,
    //`endif
    
    input             pipe4_smpl_pt_adj              , // from adjacent/master lane
    output            pipe4_smpl_pt                  , // to adjacent/salve lane
    
    // PIPE interface
    input             pipe4_eb_mode                   , // Elastic buffer mode, 0 = nominally half full; 1 = nominally empty
    input             pipe4_phy_pcie_l1_ss_sel        , // 0 = sideband, 1 = PIPE
    
    input [2:0]       pipe4_powerdown                 , // Powerdown request
    input             pipe4_tx_det_rx_lpbk            , // Receiver detect or loopback
    input             pipe4_tx_ones_zeros             , // USB CP7/CP8 transmit generation
    input [1:0]       pipe4_rate                      ,
    output            pipe4_phy_status                , // PHY Status handshake
    input [31:0]      pipe4_tx_data                   , // Data to transmit
    input [3:0]       pipe4_tx_data_k                 , // Data is control
    input             pipe4_tx_elec_idle              , // Transmit elec idle
    input             pipe4_tx_comp                   , // TX compliance mode, neg disp
    input             pipe4_tx_data_valid             , // Gen3 data valid indicator
    input [3:0]       pipe4_tx_sync_header            , // PCI3/USB3.1 sync header
    input             pipe4_tx_start_block            , // Gen3 start of data block
    
    `ifdef MP_128B_PATH 
    `ifdef MP_USB
    input             pipe4_tx_128b_enc_byp           , // Bypass 128b/13xb encoding, from MAC
    `endif
    `ifdef MP_PCIE
    input  [17:0]     pipe4_tx_deemph                 , // Transmitter de-emphasis
    input             pipe4_tx_get_local_preset_coef  , // Gen3 request preset coeff. strobe
    input  [4:0]      pipe4_tx_local_preset_index     , // Gen3 index for get preset coeff. request
    output            pipe4_tx_local_tx_coef_valid    , // Gen3 valid strobe for get preset coeff. request
    output [17:0]     pipe4_tx_local_tx_preset_coef   , // Gen3 preset coeff.
    output [5:0]      pipe4_tx_local_fs               , // Local FS value for PHY
    output [5:0]      pipe4_tx_local_lf               , // Local LF value for PHY
    `else
    input [17:0]      pipe4_tx_deemph                 , // Transmitter de-emphasis
    `endif
    `else
    input [1:0]       pipe4_tx_deemph                 , // Transmitter de-emphasis
    `endif
    
    input             pipe4_rx_polarity               , // Invert bit polarity
    output [31:0]     pipe4_rx_data                   , // Decoded RX data
    output [3:0]      pipe4_rx_data_k                 , // Data/Control indicator
    output            pipe4_rx_valid                  , // Symbol locked and data valid
    output [2:0]      pipe4_rx_status                 , // Receive status
    output            pipe4_rx_elec_idle              , // Used to indicate signal
    output [3:0]      pipe4_rx_sync_header            , // Gen3 Data/Control 
    output            pipe4_rx_start_block            , // Gen3 start block
    output            pipe4_rx_data_valid             , // Gen3 data valid flag
    
    `ifdef MP_128B_PATH 
    `ifdef MP_PCIE
    output [5:0]      pipe4_rx_link_eval_fb_dir_change, // Link evaluation feedback direction change
    input             pipe4_rx_invalid_request        , // Invalid equalization evaluation request
    input             pipe4_rx_eq_eval                , // Rx equalization evaluation request
    `endif
    `endif
    
    input             pipe4_rx_eq_training            , // USB receive equalization training
    input             pipe4_rx_termination            , // USB only
    
    output            pipe4_pma_in_pd_ref             , // PMA is powered down, to pcs iso ctrl ln
    
    output            pipe4_clk_div_override          , // Override PIPE clock divide when high, to phy top clk/rst
    
    // PCS configuration inputs
    // These should be set up before reset is released.
    input [3:0]       pipe4_cfg_usb_ss_lfps_stretch        , // PHY CDB: Static. Programmable
    input [4:0]       pipe4_cfg_usb_ssplus_lfps_stretch    , // PHY CDB: Static. Programmable
    
    `ifdef MP_128B_PATH 
    input             pipe4_cfg_pcie_gen4                  , // PCIe Gen3 v0.5 backwards compatibility mode
    
    `ifdef MP_PCIE
    input             pipe4_cfg_pcs_eq_cpl_mask            , // PHY CDB: Static. 
    `endif
    `ifdef MP_USB
    input             pipe4_cfg_usb_err_cor_disable        , // PHY CDB: Static. Only used when USB is enabled
    `endif
    
    `ifdef MP_USB3_2
    // USB3.2 Gen 2 Tx deemphasis coefficient multipliers
    input      [7:0]  pipe4_cfg_usb_gen2_pre0              ,
    input      [7:0]  pipe4_cfg_usb_gen2_pre1              ,
    input      [7:0]  pipe4_cfg_usb_gen2_pre2              ,
    input      [7:0]  pipe4_cfg_usb_gen2_pre3              ,
    input      [7:0]  pipe4_cfg_usb_gen2_post0             ,
    input      [7:0]  pipe4_cfg_usb_gen2_post1             ,
    input      [7:0]  pipe4_cfg_usb_gen2_post2             ,
    input      [7:0]  pipe4_cfg_usb_gen2_post3             ,
    `endif
    `endif
    
    input             pipe4_cfg_pcs_tx_elec_idle_pre_rel   ,
    input             pipe4_cfg_pcs_cal_realign            ,
    input [3:0]       pipe4_cfg_pcs_cal_unlock_cnt         ,
    input             pipe4_cfg_pcs_eios_clr_cal           ,
    input             pipe4_cfg_pcs_128b_eios_clr_cal      ,
    input             pipe4_cfg_pcs_128b_ignore_sigdet     ,
    input             pipe4_cfg_pcs_8b10b_ignore_sigdet    ,
    input [1:0]       pipe4_cfg_pcs_sigdet_del             ,
    input [11:0]      pipe4_cfg_pcs_com_full_lock_cnt      ,
    input [7:0]       pipe4_cfg_pcs_com_lock_cnt           ,
    input [7:0]       pipe4_cfg_pcs_com_fast_lock_cnt      ,
    input [7:0]       pipe4_cfg_pcs_eie_full_lock_cnt      ,
    input [3:0]       pipe4_cfg_pcs_eie_lock_cnt           ,
    input [3:0]       pipe4_cfg_pcs_eie_fast_lock_cnt      ,
    input             pipe4_cfg_pcs_eios_cyc_err_msk       ,
    input [15:0]      pipex_cfg_pcs_rcv_det_cnt_load       , // for both pipe4 & pipe7
    input [5:0]       pipe4_cfg_l1_x_exit_fast_cnt         ,
    input             pipe4_cfg_usb_eb_realign_en          ,
    input             pipe4_cfg_usb_pipe3_skip_comp_en     ,
    
    //-------------------- mp_pcs_lane_v6 -------------------- //
    // Clock and Reset    
    input             pipe7_clk               ,
    input             pipe7_rst_n             , // Reset for pipe_clk_out

    output            pipe7_clk_en            , // Clock gating enable, to mp_phy_whistler_prw_clkrst
    
    input             pipe7_data_path_override, // from pcs_iso_ctrl_ln_plw
    
    //input             pipe7_iso_mode_en       , // from mp_phy_whistler_pma_pd_iso_bfr
    output            pipe7_ln_pma_a5_en      , // high means PMA is in A5 state. To phy_pwrst_aggr
    
    // PIPE interface
    `ifdef CDN_PIPE_DEEPPM_INC
    input             pipe7_restore_n         , // PIPE restore
    `endif
    input  [1:0]      pipe7_rate              , // PIPE rate request
    input  [2:0]      pipe7_powerdown         , // Powerdown request
    //output            pipe7_pclk_change_ok    , // USB4 doesn't support pclk change
    //input             pipe7_pclk_change_ack   ,
    output wire       pipe7_phy_status        , // PHY Status handshake
    
    //input             pipe7_tx_det_rx_lpbk    , // Receiver detect, unused
    input  [39:0]     pipe7_tx_data           , // Data to transmit
    input  [3:0]      pipe7_tx_elec_idle      , // Transmit elec idle, only bit 0 used
    input             pipe7_tx_data_valid     , // Transmit data valid (used for data metering)

    output [39:0]     pipe7_rx_data           , // Decoded RX data
    output            pipe7_rx_valid          , // Symbol locked and data valid
    //output [2:0]      pipe7_rx_status         , // Receive status
    output            pipe7_rx_elec_idle      , // Used to indicate signal
    input             pipe7_rx_termination    ,
    input             pipe7_rx_standby        , 
    output            pipe7_rx_standby_status ,

    input             pipe7_xcvr_pll_clk_en_ack_low  , // Asserted when Xcvr datart clock running aggregated, from phy_port_lane_aggr_or in phy top
    input             pipe7_tx_local_fs_lf_valid     , // from pcs_iso_ctrl_ln_plw
    output            pipe7_rx_eq_in_progress        , // to pcs_iso_ctrl_ln_plw(Interrupt set vector)
    input		      pipe7_rx_eq_training_cmpl_stb  , // Single cycle strobe to initiate a write to MAC Rx Status0 register (bit 0),from pcs_iso_ctrl_ln_plw
    output            pipe4_pma_cmn_suspend_req      , // Request to suspend PMA, connect to PHY top common power control
    input             pipe4_pma_cmn_suspend_ack      , // PMA suspended, connect to PHY top common power control
    output            pipe4_pma_cmn_refclk_disable   , // Gate reference clocks, connect to PHY top common power control
    input             pipe4_pma_cmn_refclk_active    , // Indicates whether RefClk running, connect to PHY top common power control

    //-------------------- PMA interface --------------------//
    input             pma_pll_ready                  , // CMN startup complete
    input  [5:0]      pma_power_state_ack            , // PMA power change ack
    output [5:0]      pma_power_state_req            , // Request PMA power change
    output [2:0]      pma_cmn_data_width             , // PMA interface width
    output [2:0]      pma_cmn_standard_mode          , // Interface standard
    output            pma_xcvr_pll_clk_en            , // Xcvr datart clock enable
    input             pma_xcvr_pll_clk_en_ack        , // Asserted when Xcvr datart clock running

    input  [31:0]     pma_rd                         , // Receive data from PMA
    output [31:0]     pma_td                         , // Transmit data to PMA

    output            pma_rcv_detect                 , // Initiate receiver detection
    input             pma_rcv_detect_done            , // PMA completed receiver det
    input             pma_rcv_detected               , // PMA detected receiver
    input             pma_rx_sigdetect               , // PMA detected signal
    input             pma_rx_lfps_detect             , // (USB) PMA detected LFPS
    input             pma_rx_beacon_det              , // PMA detected beacon, connect to pma_rx_sigdetect
    output            pma_tx_elec_idle_en            , // Set TX output to Idle
    output            pma_tx_lfps_mode               , // 0-PHY transmit LFPS; 1-MAC transmit LFPS
    output            pma_tx_lfps_en                 , // Enable LFPS burst 
    output            pma_tx_beacon_en               , // Set TX output beacon
    output            pma_rx_term                    , // RX termination enable

    input [5:0]       pma_tx_local_fs                ,
    input [5:0]       pma_tx_local_lf                ,
    input [7:0]       pipe7_rx_link_eval_fb_fom      , // from pma_iso_ctrl_ln(register, may be update by uC)
    input [5:0]       pma_rx_link_eval_fb_dir_change ,
    input             pma_tx_local_tx_coef_valid     , // pcs_iso_ctrl_ln
    input [17:0]      pma_tx_local_tx_preset_coef    , // pcs_iso_ctrl_ln
    input             pma_rx_eq_eval_status          , // pcs_iso_ctrl_ln
    input             pma_rx_eq_eval_complete        , // pcs_iso_ctrl_ln
    output            pma_tx_swing                   , // pcs iso ctrl ln
    output [2:0]      pma_tx_margin                  , // pcs iso ctrl ln
    output            pma_tx_swgmgn_strobe           , // pcs_iso_ctrl_ln 
    output            pma_rx_eq_training             ,
    output            pma_tx_get_local_preset_coef   , // pcs_iso_ctrl_ln
    output [5:0]      pma_tx_local_preset_index      , // pcs_iso_ctrl_ln
    output            pma_rx_invalid_request         ,
    output            pma_rx_eq_eval                 ,
    output            pma_tx_deemph_strobe           , // pcs iso ctrl ln 
    output [17:0]     pma_tx_deemphasis              , // pcs iso ctrl ln / pma iso ctrl ln
    output			  pma_rx_mrgn_req                , // Receiver Margin Request     : pma_iso_ctrl_ln, uc will take over these function  
    output	[1:0]	  pma_rx_mrgn_dir                , // Receiver Margin Direction   : pma_iso_ctrl_ln   
    output	[6:0]	  pma_rx_mrgn_offset             , // Receiver Margin Offset      : pma_iso_ctrl_ln 
    input		      pma_rx_mrgn_valid              , // Receiver Margin Valid       : pma_iso_ctrl_ln 
    input	[5:0]	  pma_rx_mrgn_errcnt               // Receiver Margin Error Count : pma_iso_ctrl_ln 

);

logic        mp_pcs_config ; // 0 - original PIPE; 1 - serdes PIPE. decode from PHY top PHY_MODE
logic [1:0]  pipe4_phy_mode; 
//logic [1:0]  pipe7_phy_mode; // unused because serdes mode only support USB4 

logic [5 :0] original_pma_power_state_req;
logic [2 :0] original_pma_data_width;
logic [2 :0] original_pma_standard_mode;
logic        original_pma_xcvr_pll_clk_en;
logic [31:0] original_pma_td;
logic        original_pma_rx_term;
logic        original_pma_tx_elec_idle;
logic        original_rx_eq_training;
logic        original_tx_get_local_preset_coef;
logic [3 :0] original_tx_local_preset_index;
logic        original_rx_invalid_request;
logic        original_rx_eq_eval;
logic [17:0] original_tx_deemph;
logic [17:0] original_tx_deemph_r1;
logic        original_tx_deemph_strobe;

logic [5 :0] serdes_pma_power_state_req;
logic [2 :0] serdes_pma_data_width;
logic [2 :0] serdes_pma_standard_mode;
logic        serdes_pma_xcvr_pll_clk_en;
logic [31:0] serdes_pma_td;
logic        serdes_pma_rx_term;
logic        serdes_pma_tx_elec_idle;

logic        mb_rx_eq_training;
logic        mb_tx_get_local_preset_coef_int;
logic        mb_tx_get_local_preset_coef;
logic [5 :0] mb_tx_local_preset_index_int;
logic [3 :0] mb_tx_local_preset_index;
logic        mb_rx_invalid_request_int;
logic        mb_rx_invalid_request;
logic        mb_rx_eq_eval_int;
logic        mb_rx_eq_eval;
logic [17:0] mb_tx_deemph;
logic        mb_tx_deemph_strobe;


logic        rx_eq_eval_complete;
logic [5 :0] rx_link_eval_fb_dir_change;
logic [7 :0] rx_link_eval_fb_fom;
logic [17:0] tx_local_tx_preset_coef;
logic        tx_local_tx_coef_valid;

//--- phy mode decode ---//
//*** below phy mode decode logic is only for TimberWolf, may need update for other Wolfs ***//
assign mp_pcs_config = phy_mode_usb4_en == 1'b1 ? 1'b1 : 1'b0;

assign pipe4_phy_mode = phy_mode_usb3_en ? 2'b01 : // USB3.2
                                           2'b00 ; // PCIe, for timberwolf, PCIe is unsupported, so if USB3.2 is not used, original pipe clock should be gated.

//--- MUX on PMA interface ---//
// For training related signals, mcu will take over the whole process using registers to control PMA
// But all these signals are still connected to PMA as backup way.
// power control MUX
assign pma_power_state_req = {6{~mp_pcs_config}} & original_pma_power_state_req |
                             {6{ mp_pcs_config}} & serdes_pma_power_state_req;

assign pma_cmn_data_width = {3{~mp_pcs_config}} & original_pma_data_width |
                            {3{ mp_pcs_config}} & serdes_pma_data_width;

assign pma_cmn_standard_mode = {3{~mp_pcs_config}} & original_pma_standard_mode |
                               {3{ mp_pcs_config}} & serdes_pma_standard_mode;

assign pma_xcvr_pll_clk_en = ~mp_pcs_config & original_pma_xcvr_pll_clk_en |
                              mp_pcs_config & serdes_pma_xcvr_pll_clk_en;

// data path MUX
assign pma_td = {32{~mp_pcs_config}} & original_pma_td |
                {32{ mp_pcs_config}} & serdes_pma_td;

assign pma_rx_term = ~mp_pcs_config & original_pma_rx_term |
                      mp_pcs_config & serdes_pma_rx_term;

assign pma_tx_elec_idle_en = ~mp_pcs_config & original_pma_tx_elec_idle |
                              mp_pcs_config & serdes_pma_tx_elec_idle;
// training MUX
assign pma_rx_eq_training = ~mp_pcs_config & original_rx_eq_training |
                             mp_pcs_config & mb_rx_eq_training;

assign pma_tx_get_local_preset_coef = ~mp_pcs_config & original_tx_get_local_preset_coef |
                                       mp_pcs_config & mb_tx_get_local_preset_coef;

assign pma_tx_local_preset_index = {6{~mp_pcs_config}} & {2'b0, original_tx_local_preset_index} |
                                   {6{ mp_pcs_config}} & {2'b0, mb_tx_local_preset_index};

assign pma_rx_invalid_request = ~mp_pcs_config & original_rx_invalid_request |
                                 mp_pcs_config & mb_rx_invalid_request;

assign pma_rx_eq_eval = ~mp_pcs_config & original_rx_eq_eval |
                         mp_pcs_config & mb_rx_eq_eval;

assign pma_tx_deemphasis = {18{~mp_pcs_config}} & original_tx_deemph |
                           {18{ mp_pcs_config}} & mb_tx_deemph;

assign pma_tx_deemph_strobe = ~mp_pcs_config & original_tx_deemph_strobe |
                               mp_pcs_config & mb_tx_deemph_strobe;

//--- MUX on PIPE interface ---//
logic [5:0] tx_local_fs;
logic [5:0] tx_local_lf;

logic [3:0] mb_pipe_rate ;
//logic       mb_phy_status;

//logic       mb_pcs_pipe_clk_en;

logic       tx_lfps_select;

assign mb_pipe_rate = {4{~mp_pcs_config}} & {2'b0, pipe4_rate} |
                      {4{ mp_pcs_config}} & {2'b0, pipe7_rate};

//assign mb_phy_status = ~mp_pcs_config & pipe4_phy_status |
//                        mp_pcs_config & pipe7_phy_status;

//assign mb_pcs_pipe_clk_en = ~mp_pcs_config & pipe4_clk_en |
//                             mp_pcs_config & pipe7_clk_en;
 
assign pma_tx_lfps_mode = mp_pcs_config ? tx_lfps_select : 1'b0; // for original pipe, use phy to transmit lfps

cdnsdru_usb4_message_bus_top_v4 message_bus ( /*autoinst*/
        .mb_mac2phy_clk                       (mb_mac2phy_clk                            ), //input //INST_NEW
        .mb_mac2phy_rstn                      (mb_mac2phy_rstn                           ), //input
        .mb_phy2mac_clk                       (mb_phy2mac_clk                            ), //input
        .mb_phy2mac_rstn                      (mb_phy2mac_rstn                           ), //input
        .scanmode                             (scanmode                                  ), //input
        .rx_signal_detect                     (pma_rx_sigdetect                          ), //input
        .rx_mrgn_valid                        (pma_rx_mrgn_valid                         ), //input
        .rx_mrgn_errcnt                       (pma_rx_mrgn_errcnt[5:0]                   ), //input
        .mb_cdb_reset                         (mb_cdb_reset                              ), //input
        .mb_cdb_rx_reset                      (mb_cdb_rx_reset                           ), //input
        .mb_cdb_tx_reset                      (mb_cdb_tx_reset                           ), //input
        .mb_cdb_pma_reset                     (mb_cdb_pma_reset                          ), //input
        .mb_cdb_ctrl_reset                    (mb_cdb_ctrl_reset                         ), //input
        .lm_cdb_pma_wait                      (mb_lm_cdb_pma_wait[3:0]                   ), //input
        .lm_cdb_sample_3logn                  (mb_lm_cdb_sample_3logn[5:0]               ), //input
        .lm_cdb_sample_max                    (mb_lm_cdb_sample_max[7:0]                 ), //input
        .lm_cdb_sample_threshold              (mb_lm_cdb_sample_threshold[7:0]           ), //input
        .lm_cdb_pma_direction                 (mb_lm_cdb_pma_direction[7:0]              ), //input
        .lm_cdb_error_max                     (mb_lm_cdb_error_max[5:0]                  ), //input
        .lm_cdb_error_threshold               (mb_lm_cdb_error_threshold[5:0]            ), //input
        .lm_cdb_timing_offset                 (mb_lm_cdb_timing_offset[5:0]              ), //input
        .lm_cdb_voltage_offset                (mb_lm_cdb_voltage_offset[6:0]             ), //input
        .rx_eq_training_cmpl_stb              (pipe7_rx_eq_training_cmpl_stb             ), //input
        // Elastic buffer control/status
        .lm_eb_sts_upd                        (1'b0                                      ), //input, unused for serdes pipe
        .lm_eb_sts                            (8'b0                                      ), //input, unused for serdes pipe
        .lm_eb_ctrl_upd                       (/*floating*/                              ), //output, unused for serdes pipe
        .lm_eb_ctrl                           (/*floating*/                              ), //output, , unused for serdes pipe
        `ifdef LM_DEP_OPTION
        .lm_dep                               (mb_lm_dep                                 ), //input
        `endif
        .mb_cdb_invalid_addr_uncom            (mb_cdb_invalid_addr_uncom                 ), //output
        .mb_cdb_invalid_addr_com              (mb_cdb_invalid_addr_com                   ), //output
        .lm_cdb_smplcnt_saturated             (mb_lm_cdb_smplcnt_saturated               ), //output
        .lm_cdb_errcnt_saturated              (mb_lm_cdb_errcnt_saturated                ), //output
        .rx_mrgn_req                          (pma_rx_mrgn_req                           ), //output
        .rx_mrgn_dir                          (pma_rx_mrgn_dir[1:0]                      ), //output
        .rx_mrgn_offset                       (pma_rx_mrgn_offset[6:0]                   ), //output
        // IO Recal interface with PHY
        .p2m_recal_req                        (mb_p2m_recal_req                          ), //input
        .phy_recal_done                       (mb_phy_recal_done                         ), //input
        .m2p_recal_req                        (mb_m2p_recal_req                          ), //output
        `ifdef PAM4_RESTRICTED_LEVELS
        .PAM4RestrictedLevels                 (/*floating*/                              ), //output
        `endif
        .NELBEnable                           (mb_nelb_enable                            ), //output
        .NELBPosition                         (mb_nelb_position[2:0]                     ), //output
        //Output signals that replace pre-PIPE5 wires
        .rx_polarity                          (/*floating*/                              ), //output, original pipe get from legacy; serdes pipe doesn't use it
        .tx_deemph                            (mb_tx_deemph[17:0]                        ), //output
        .tx_deemph_cx                         (/*floating*/                              ), //output, for USB4 Gen4
        .tx_deemph_strobe                     (mb_tx_deemph_strobe                       ), //output, for USB4 Gen4
        .tx_local_preset_index                (mb_tx_local_preset_index_int[5:0]         ), //output
        .tx_get_local_preset_coef             (mb_tx_get_local_preset_coef_int           ), //output
        .rx_eq_training                       (mb_rx_eq_training                         ), //output
        .rx_invalid_request                   (mb_rx_invalid_request_int                 ), //output
        .rx_eq_in_progress                    (pipe7_rx_eq_in_progress                   ), //output
        .rx_eq_eval                           (mb_rx_eq_eval_int                         ), //output
        //.tx_pattern                           (                                          ), //output, SATA only
        .tx_ones_zeros                        (/*floating*/                              ), //output
        //.tx_fs_g67                            (/*floating*/                              ), //output
        //.tx_lf_g67                            (/*floating*/                              ), //output
        //.tx_fs_legacy                         (/*floating*/                              ), //output
        //.tx_lf_legacy                         (/*floating*/                              ), //output
        .tx_swing                             (pma_tx_swing                              ), //output
        .tx_margin                            (pma_tx_margin[2:0]                        ), //output
        .tx_swgmgn_strobe                     (pma_tx_swgmgn_strobe                      ), //output
        .tx_128b_enc_byp                      (/*floating*/                              ), //output
        .tx_lfps_select                       (tx_lfps_select                            ), //output
        .eb_mode                              (/*floating*/                              ), //output
        //Inputs to collect pre-PIPE5 wires onto message bus
        //.pcs_pipe_lnn_clk_out_en              (mb_pcs_pipe_clk_en                        ), //input
        .pcs_pipe_lnn_clk_out_en              (1'b1                                      ), //input
        .local_fs_g67                         (6'b0                                      ), //input
        .local_lf_g67                         (6'b0                                      ), //input
        .local_fs_legacy                      (tx_local_fs[5:0]                          ), //input
        .local_lf_legacy                      (tx_local_lf[5:0]                          ), //input
        .tx_coef_valid                        (tx_local_tx_coef_valid                    ), //input
        .tx_local_fs_lf_valid                 (pipe7_tx_local_fs_lf_valid                ), //input
        .tx_preset_coef_legacy                (tx_local_tx_preset_coef[17:0]             ), //input
        .tx_preset_coef_g67                   (24'b0                                     ), //input
        .rx_eq_eval_sel                       (mb_cdb_rx_eq_eval_sel                     ), //input
        .rx_link_eval_fb_dir_change_g67       (12'b0                                     ), //input
        .rx_link_eval_fb_dir_change_legacy    (rx_link_eval_fb_dir_change[5:0]           ), //input
        .rx_link_eval_fb_fom                  (rx_link_eval_fb_fom[7:0]                  ), //input
        .pipe_rate                            (mb_pipe_rate[3:0]                         ), //input
        .phy_status                           (rx_eq_eval_complete                       ), //input
        //M2P and P2M data busses
        .mb_pipe_rx_data                      (mb_pipe_rx_data[7:0]                      ), //input
        .mb_pipe_tx_data                      (mb_pipe_tx_data[7:0]                      ), //output
        .mb_pipe_tx_disable                   (mb_pipe_tx_disable                        )  //input
); // message_bus

pcie_pipe_4_eq_wrap_v3 u_eq_wrap (
   .pipe_clk_in                       (mb_mac2phy_clk                         ), // input
   .pipe_in_rst_n                     (mb_mac2phy_rstn                        ), // input
   .pipe_clk_out                      (mb_mac2phy_clk                         ), // input
   .pipe_out_rst_n                    (mb_mac2phy_rstn                        ), // input
   .eq_cpl_mask                       (1'b0                                   ), // input
   .fslf_smpl_trig                    (1'b0                                   ), // input
   .phy_status                        (rx_eq_eval_complete                    ), // output
   .pipe_rate_pwr_chg_stb             (1'b0                                   ), // input
   .pipe_getlocalpresetcoeff          (mb_tx_get_local_preset_coef_int        ), // input
   .pipe_localpresetindex             (mb_tx_local_preset_index_int           ), // input
   .pipe_localtxcoeffvalid            (tx_local_tx_coef_valid                 ), // output
   .pipe_localtxpresetcoeff           (tx_local_tx_preset_coef                ), // output
   .pipe_localfs                      (                                       ), // output
   .pipe_locallf                      (                                       ), // output
   .pma_tx_getlocalpresetcoeff        (mb_tx_get_local_preset_coef            ), // output
   .pma_tx_localpresetindex           (mb_tx_local_preset_index               ), // output
   .pma_tx_localtxcoeffvalid          (pma_tx_local_tx_coef_valid             ), // input
   .pma_tx_localtxpresetcoeff         (pma_tx_local_tx_preset_coef            ), // input
   .pma_tx_local_fs                   (6'd0                                   ), // input
   .pma_tx_local_lf                   (6'd0                                   ), // input
   .pipe_rxeqeval                     (mb_rx_eq_eval_int                      ), // input
   .pipe_invalidrequest               (mb_rx_invalid_request_int              ), // input
   .pipe_linkevaldirchange            (rx_link_eval_fb_dir_change             ), // output
   .pipe_linkevalfom                  (rx_link_eval_fb_fom                    ), // output
   .pma_rx_eqeval                     (mb_rx_eq_eval                          ), // output
   .pma_rx_eqevalstatus               (pma_rx_eq_eval_status                  ), // input 
   .pma_rx_eqevalcomplete             (pma_rx_eq_eval_complete                ), // input 
   .pma_rx_linkevaldirchange          (pma_rx_link_eval_fb_dir_change         ), // input 
   .pma_rx_linkevalfom                (pipe7_rx_link_eval_fb_fom              ), // input
   .pma_rx_invalidrequest             (mb_rx_invalid_request                  )  // output
   );

logic pipe4_rate_chg_cmn_suspend_override;
logic pipe4_pma_cmn_refclk_disable_int;

assign pipe4_rate_chg_cmn_suspend_override = phy_mode_usb3_en; // Do not suspend commom for USB3

assign pipe4_pma_cmn_refclk_disable = phy_mode_usb3_en == 1'b1 ? 1'b0 : pipe4_pma_cmn_refclk_disable_int;

mp_pcs_lane_v3 mp_pcs_original ( /*autoinst*/
        // Clock and Reset    
        .pipe_clk_out                                 (pipe4_clk_out                                ), //input
        .pipe_out_rst_n                               (pipe4_out_rst_n                              ), //input
        .pipe_clk_in                                  (pipe4_clk_in                                 ), //input
        .pipe_in_rst_n                                (pipe4_in_rst_n                               ), //input
        .psm_clk                                      (psm_clk                                      ), //input
        .psm_rst_n                                    (psm_rst_n                                    ), //input
        .tx_datart_clk                                (tx_datart_clk                                ), //input
        .tx_datart_rst_n                              (tx_datart_rst_n                              ), //input
        .rx_datart_clk                                (rx_datart_clk                                ), //input
        .rx_datart_rst_n                              (rx_datart_rst_n                              ), //input
        .rx_rd_clk                                    (rx_rd_clk                                    ), //input
        .rx_rst_n                                     (rx_rst_n                                     ), //input
        .ref_clk                                      (ref_clk                                      ), //input
        .ref_rst_n                                    (ref_rst_n                                    ), //input
        // Control and Status
        .lane_dis                                     (pipe4_lane_dis                               ), //input
        .lane_off                                     (pipe4_lane_off                               ), //output
        .scanmode                                     (scanmode                                     ), //input
        .scanen_cg                                    (scanen_cg                                    ), //input
        .pipe_32bit_en                                (pipe_32bit_en                                ), //input, always choose 32bit PIPE data width
        .pipe_clk_en                                  (pipe4_clk_en                                 ), //output
        .usb_lpbkslv_ec_disable                       (pipe4_usb_lpbkslv_ec_disable                 ), //input
        .usb_lpbkslv_ec                               (pipe4_usb_lpbkslv_ec[7:0]                    ), //output
        // L1 substate interface
        .phy_ent_l1_x                                 (pipe4_phy_ent_l1_x                           ), //input
        .phy_ack_l1_x                                 (pipe4_phy_ack_l1_x                           ), //output
        // PMA interface
        //pma_cmn_ready = cmn_ready & pll_ready in torrent.
        //In whistler, pma_cmn_ready is split into two signal: cmn_ready and pll_ready 
        .pma_cmn_ready                                (pma_pll_ready                                ), //input 
        .pma_rcv_detect                               (pma_rcv_detect                               ), //output
        .pma_power_state_ack                          (pma_power_state_ack[5:0]                     ), //input
        .pma_power_state_req                          (original_pma_power_state_req[5:0]            ), //output
        .pma_cmn_suspend_req                          (pipe4_pma_cmn_suspend_req                    ), //output
        .pma_cmn_suspend_ack                          (pipe4_pma_cmn_suspend_ack                    ), //input
        .pma_cmn_refclk_disable                       (pipe4_pma_cmn_refclk_disable_int             ), //output
        .pma_cmn_refclk_active                        (pipe4_pma_cmn_refclk_active                  ), //input
        .pma_cmn_data_width                           (original_pma_data_width[2:0]                 ), //output
        .pma_cmn_standard_mode                        (original_pma_standard_mode[2:0]              ), //output
        .pma_xcvr_pll_clk_en                          (original_pma_xcvr_pll_clk_en                 ), //output
        .pma_xcvr_pll_clk_en_ack                      (pma_xcvr_pll_clk_en_ack                      ), //input
        // Control of Rx electrical idle during L1.x and upon exit
        .pcs_l1_x_exit_reset_n                        (pipe4_pcs_l1_x_exit_reset_n                  ), //input
        .l1_x_exit_gate_ext                           (pipe4_l1_x_exit_gate_ext                     ), //input
        .pma_rd                                       (pma_rd[31:0]                                 ), //input
        .pma_rcv_detect_done                          (pma_rcv_detect_done                          ), //input
        .pma_rcv_detected                             (pma_rcv_detected                             ), //input
        .pma_rx_sigdetect                             (pma_rx_sigdetect                             ), //input
        .pma_rx_lfps_detect                           (pma_rx_lfps_detect                           ), //input
        .pma_rx_beacon_det                            (pma_rx_beacon_det                            ), //input
        .pma_td                                       (original_pma_td[31:0]                        ), //output
        .pma_tx_elec_idle_en                          (original_pma_tx_elec_idle                    ), //output
        .pma_tx_lfps_en                               (pma_tx_lfps_en                               ), //output
        .pma_tx_beacon_en                             (pma_tx_beacon_en                             ), //output
        .pma_rx_term                                  (original_pma_rx_term                         ), //output
        .phy_link_cfg                                 (pipe4_phy_link_cfg                           ), //input
        `ifdef MP_SRC_SYNC_PCLK
        // Source synchronous PIPE clock mode - FIFO enable signals from
        //   adjacent lane.  Slave lanes use master lane's enable signals
        //   to maintain lane to lane Tx skew
        .pipe_fifo_wr_en_adj                          (pipe4_fifo_wr_en_adj                         ), //input
        .pipe_fifo_rd_en_adj                          (pipe4_fifo_rd_en_adj                         ), //input
        .pipe_fifo_wr_en                              (pipe4_fifo_wr_en                             ), //output
        .pipe_fifo_rd_en                              (pipe4_fifo_rd_en                             ), //output
        `endif
        // Use the same pipe_smpl_pt across all lanes of multi-lane link
        .pipe_smpl_pt_adj                             (pipe4_smpl_pt_adj                            ), //input
        .pipe_smpl_pt                                 (pipe4_smpl_pt                                ), //output
        `ifdef MP_128B_PATH 
        .pma_tx_local_fs                              (pma_tx_local_fs[5:0]                         ), //input
        `ifdef MP_PCIE
        .pma_tx_deemphasis                            (original_tx_deemph[17:0]                     ), //output
        .pma_tx_get_local_preset_coef                 (original_tx_get_local_preset_coef            ), //output
        .pma_tx_local_preset_index                    (original_tx_local_preset_index[3:0]          ), //output
        .pma_tx_local_tx_coef_valid                   (pma_tx_local_tx_coef_valid                   ), //input
        .pma_tx_local_tx_preset_coef                  (pma_tx_local_tx_preset_coef[17:0]            ), //input
        .pma_tx_local_lf                              (pma_tx_local_lf[5:0]                         ), //input
        .pma_rx_eq_eval                               (original_rx_eq_eval                          ), //output
        .pma_rx_eq_eval_status                        (pma_rx_eq_eval_status                        ), //input
        .pma_rx_eq_eval_complete                      (pma_rx_eq_eval_complete                      ), //input
        .pma_rx_link_eval_fb_dir_change               (pma_rx_link_eval_fb_dir_change[5:0]          ), //input
        .pma_rx_invalid_request                       (original_rx_invalid_request                  ), //output
        `else
        .pma_tx_deemphasis                            (original_tx_deemph[17:0]                     ), //output
        `endif
        `else
        .pma_tx_deemphasis                            (original_tx_deemph[1:0]                      ), //output
        `endif
        .pma_rx_eq_training                           (original_rx_eq_training                      ), //output
        // PIPE interface
        .phy_pcie_l1_ss_sel                           (pipe4_phy_pcie_l1_ss_sel                     ), //input
        .pipe_phy_mode                                (pipe4_phy_mode[1:0]                          ), //input
        .pipe_eb_mode                                 (pipe4_eb_mode                                ), //input
        .pipe_rate                                    (pipe4_rate[1:0]                              ), //input
        .pipe_powerdown                               (pipe4_powerdown[2:0]                         ), //input
        .pipe_tx_det_rx_lpbk                          (pipe4_tx_det_rx_lpbk                         ), //input
        .pipe_tx_ones_zeros                           (pipe4_tx_ones_zeros                          ), //input
        .pipe_tx_pattern                              (2'b0                                         ), //input
        .pipe_phy_status                              (pipe4_phy_status                             ), //output
        .pipe_tx_data                                 (pipe4_tx_data[31:0]                          ), //input
        .pipe_tx_data_k                               (pipe4_tx_data_k[3:0]                         ), //input
        .pipe_tx_elec_idle                            (pipe4_tx_elec_idle                           ), //input
        .pipe_tx_comp                                 (pipe4_tx_comp                                ), //input
        .pipe_tx_data_valid                           (pipe4_tx_data_valid                          ), //input
        .pipe_tx_sync_header                          (pipe4_tx_sync_header[3:0]                    ), //input
        .pipe_tx_start_block                          (pipe4_tx_start_block                         ), //input
        `ifdef MP_128B_PATH 
        `ifdef MP_USB
        .pipe_tx_128b_enc_byp                         (pipe4_tx_128b_enc_byp                        ), //input
        `endif
        `ifdef MP_PCIE
        .pipe_tx_deemph                               (pipe4_tx_deemph[17:0]                        ), //input
        .pipe_tx_get_local_preset_coef                (pipe4_tx_get_local_preset_coef               ), //input
        .pipe_tx_local_preset_index                   (pipe4_tx_local_preset_index[4:0]             ), //input
        .pipe_tx_local_tx_coef_valid                  (pipe4_tx_local_tx_coef_valid                 ), //output
        .pipe_tx_local_tx_preset_coef                 (pipe4_tx_local_tx_preset_coef[17:0]          ), //output
        .pipe_tx_local_fs                             (pipe4_tx_local_fs[5:0]                       ), //output
        .pipe_tx_local_lf                             (pipe4_tx_local_lf[5:0]                       ), //output
        `else
        .pipe_tx_deemph                               (pipe4_tx_deemph[17:0]                        ), //input
        `endif
        `else
        .pipe_tx_deemph                               (pipe4_tx_deemph[1:0]                         ), //input
        `endif
        .pipe_rx_polarity                             (pipe4_rx_polarity                            ), //input
        .pipe_rx_data                                 (pipe4_rx_data[31:0]                          ), //output
        .pipe_rx_data_k                               (pipe4_rx_data_k[3:0]                         ), //output
        .pipe_rx_valid                                (pipe4_rx_valid                               ), //output
        .pipe_rx_status                               (pipe4_rx_status[2:0]                         ), //output
        .pipe_align_detect                            (/*floating*/                                 ), //output, SATA only
        .pipe_rx_elec_idle                            (pipe4_rx_elec_idle                           ), //output
        .pipe_rx_sync_header                          (pipe4_rx_sync_header[3:0]                    ), //output
        .pipe_rx_start_block                          (pipe4_rx_start_block                         ), //output
        .pipe_rx_data_valid                           (pipe4_rx_data_valid                          ), //output
        `ifdef MP_128B_PATH 
        `ifdef MP_PCIE
        .pipe_rx_link_eval_fb_dir_change              (pipe4_rx_link_eval_fb_dir_change[5:0]        ), //output
        .pipe_rx_invalid_request                      (pipe4_rx_invalid_request                     ), //input
        .pipe_rx_eq_eval                              (pipe4_rx_eq_eval                             ), //input
        `endif
        `endif
        .pipe_rx_eq_training                          (pipe4_rx_eq_training                         ), //input
        .pipe_rx_termination                          (pipe4_rx_termination                         ), //input
        //`ifdef MP_MPHY
        //.mphy_mode_en                                 (mphy_mode_en                                 ), //input
        //.mphy_cfg_1mhz_clk                            (mphy_cfg_1mhz_clk                            ), //input
        //.mphy_tx_32bit_en                             (mphy_tx_32bit_en                             ), //input
        //.mphy_rx_32bit_en                             (mphy_rx_32bit_en                             ), //input
        ////RMMI interface
        //.mphy_cfgclk                                  (mphy_cfgclk                                  ), //input
        ////
        ////RMMI-RX
        ////
        //.mphy_rx_symbolclk                            (mphy_rx_symbolclk                            ), //output
        //.mphy_rx_symbol                               (mphy_rx_symbol[39:0]                         ), //output
        //.mphy_rx_datanctrl                            (mphy_rx_datanctrl[3:0]                       ), //output
        //.mphy_rx_symbolerr                            (mphy_rx_symbolerr[3:0]                       ), //output
        //.mphy_rx_phydordy                             (mphy_rx_phydordy[3:0]                        ), //output
        //.mphy_rx_burst                                (mphy_rx_burst                                ), //output
        //.mphy_rx_lccrddet                             (mphy_rx_lccrddet                             ), //output
        //.mphy_rx_linereset                            (mphy_rx_linereset                            ), //output
        //.mphy_rx_hibern8exit_type1                    (mphy_rx_hibern8exit_type1                    ), //output
        //.mphy_rx_cfgrdyn                              (mphy_rx_cfgrdyn                              ), //output
        //.mphy_rx_attrrdval                            (mphy_rx_attrrdval[7:0]                       ), //output
        //.mphy_rx_cfgenbl                              (mphy_rx_cfgenbl                              ), //input
        //.mphy_rx_cfgupdt                              (mphy_rx_cfgupdt                              ), //input
        //.mphy_rx_attrid                               (mphy_rx_attrid[7:0]                          ), //input
        //.mphy_rx_attrenb                              (mphy_rx_attrenb                              ), //input
        //.mphy_rx_attrwrval                            (mphy_rx_attrwrval[7:0]                       ), //input
        //.mphy_rx_attrwrn                              (mphy_rx_attrwrn                              ), //input
        //.mphy_rx_tm_access_en                         (mphy_rx_tm_access_en                         ), //input
        //.mphy_rx_pwmnsys                              (mphy_rx_pwmnsys                              ), //input
        //.mphy_rx_enter_exitn_hibern8                  (mphy_rx_enter_exitn_hibern8                  ), //input
        ////
        ////RMMI-TX
        ////
        //.mphy_tx_cfgrdyn                              (mphy_tx_cfgrdyn                              ), //output
        //.mphy_tx_attrrdval                            (mphy_tx_attrrdval[7:0]                       ), //output
        //.mphy_tx_savestate_status_n                   (mphy_tx_savestate_status_n                   ), //output
        //.mphy_tx_phydirdy                             (mphy_tx_phydirdy                             ), //output
        //.mphy_tx_symbolclk                            (mphy_tx_symbolclk                            ), //input
        //.mphy_tx_symbol                               (mphy_tx_symbol[39:0]                         ), //input
        //.mphy_tx_datanctrl                            (mphy_tx_datanctrl[3:0]                       ), //input
        //.mphy_tx_protdordy                            (mphy_tx_protdordy[3:0]                       ), //input
        //.mphy_tx_cfgenbl                              (mphy_tx_cfgenbl                              ), //input
        //.mphy_tx_cfgupdt                              (mphy_tx_cfgupdt                              ), //input
        //.mphy_tx_attrid                               (mphy_tx_attrid[7:0]                          ), //input
        //.mphy_tx_attrenb                              (mphy_tx_attrenb                              ), //input
        //.mphy_tx_attrwrval                            (mphy_tx_attrwrval[7:0]                       ), //input
        //.mphy_tx_attrwrn                              (mphy_tx_attrwrn                              ), //input
        //.mphy_tx_linereset                            (mphy_tx_linereset                            ), //input
        //.mphy_tx_burst                                (mphy_tx_burst                                ), //input
        //.mphy_tx_controlled_acttimer                  (mphy_tx_controlled_acttimer                  ), //input
        //.mphy_tx_tm_access_en                         (mphy_tx_tm_access_en                         ), //input
        //.mphy_tx_pwmnsys                              (mphy_tx_pwmnsys                              ), //input
        //.mphy_tx_enter_exitn_hibern8                  (mphy_tx_enter_exitn_hibern8                  ), //input
        //// Additional PHY Inputs specific to MPHY - TX.
        //.mphy_tx_cfgclk_rst_n                         (mphy_tx_cfgclk_rst_n                         ), //input
        //// Additional PMA Outputs specific to MPHY -TX.
        //.pma_mphy_tx_ls_serialiser_en                 (pma_mphy_tx_ls_serialiser_en                 ), //output
        //.pma_mphy_tx_pwm_enc_en                       (pma_mphy_tx_pwm_enc_en[1:0]                  ), //output
        //.pma_mphy_tx_hslsn                            (pma_mphy_tx_hslsn                            ), //output
        //.pma_mphy_tx_hs_driver_sel                    (pma_mphy_tx_hs_driver_sel                    ), //output
        //.pma_mphy_tx_ls_burst                         (pma_mphy_tx_ls_burst                         ), //output
        //.pma_mphy_tx_hs_slewrate                      (pma_mphy_tx_hs_slewrate[7:0]                 ), //output
        //.pma_mphy_tx_swap_polarity                    (pma_mphy_tx_swap_polarity                    ), //output
        //.pma_mphy_tx_enable_sa_mode                   (pma_mphy_tx_enable_sa_mode                   ), //output
        //.pma_mphy_tx_hs_unterminated_line_drive_en    (pma_mphy_tx_hs_unterminated_line_drive_en    ), //output
        //.pma_mphy_tx_pwmnsys                          (pma_mphy_tx_pwmnsys                          ), //output
        //.pma_mphy_drive_linereset_difp                (pma_mphy_drive_linereset_difp                ), //output
        //.pma_mphy_drive_linereset_difn                (pma_mphy_drive_linereset_difn                ), //output
        //.pma_mphy_tx_hs_equalizer_setting             (pma_mphy_tx_hs_equalizer_setting[2:0]        ), //output
        //// Additional PMA Outputs specific to MPHY-RX.
        //.pma_mphy_rx_rst_gf_mux                       (pma_mphy_rx_rst_gf_mux                       ), //output
        //.pma_rx_power_state_req                       (pma_rx_power_state_req[5:0]                  ), //output
        //.pma_mphy_rx_exit_to_sleep                    (pma_mphy_rx_exit_to_sleep                    ), //output
        //.pma_mphy_rx_exit_to_stall                    (pma_mphy_rx_exit_to_stall                    ), //output
        //.pma_mphy_rx_enter_hb8_after_burst            (pma_mphy_rx_enter_hb8_after_burst            ), //output
        //.pma_mphy_rx_burst_active                     (pma_mphy_rx_burst_active                     ), //output
        //.pma_mphy_rx_pd_sq_force                      (pma_mphy_rx_pd_sq_force                      ), //output
        //.pma_mphy_rx_first_hb8_ext_req                (pma_mphy_rx_first_hb8_ext_req                ), //output
        //.pma_mphy_rx_termination_en                   (pma_mphy_rx_termination_en                   ), //output
        //.pma_mphy_rx_hslsn                            (pma_mphy_rx_hslsn                            ), //output
        //.pma_mphy_rx_sync_almost_complete             (pma_mphy_rx_sync_almost_complete             ), //output
        //// Additional PMA Inputs specific to MPHY-RX.
        //.pma_mphy_rx_squelch                          (pma_mphy_rx_squelch                          ), //input
        //.pma_mphy_rx_linereset_det                    (pma_mphy_rx_linereset_det                    ), //input
        //.pma_mphy_rx_exit_pwm_to_sleep                (pma_mphy_rx_exit_pwm_to_sleep                ), //input
        //.pma_rx_power_state_ack                       (pma_rx_power_state_ack[5:0]                  ), //input
        //.pma_mphy_rx_ls_preamp                        (pma_mphy_rx_ls_preamp                        ), //input
        //// Towards PHY
        //.mphy_rx_cfgclk_rst_n                         (mphy_rx_cfgclk_rst_n                         ), //input
        //.mphy_rx_symbolclk_in                         (mphy_rx_symbolclk_in                         ), //input
        //.psm_rst_rx_n                                 (psm_rst_rx_n                                 ), //input
        //.phy_mphy_rx_prot_cg_en                       (phy_mphy_rx_prot_cg_en                       ), //output
        //.phy_mphy_rx_divider_cg_en                    (phy_mphy_rx_divider_cg_en                    ), //output
        //.mphy_rx_resetb_sym_state_psc                 (mphy_rx_resetb_sym_state_psc                 ), //output
        //.mphy_rx_symb_divider_reset_n_psc             (mphy_rx_symb_divider_reset_n_psc             ), //output
        //.mphy_rx_cfgclk_hib_rstb_psc                  (mphy_rx_cfgclk_hib_rstb_psc                  ), //output
        //.mphy_rx_sq_rstb_psc                          (mphy_rx_sq_rstb_psc                          ), //output
        //.mphy_rx_burst_hib_resetb_psc                 (mphy_rx_burst_hib_resetb_psc                 ), //output
        //.mphy_rx_resetb_sym_state_sc                  (mphy_rx_resetb_sym_state_sc                  ), //input
        //.mphy_rx_cfgclk_hib_rstb_sc                   (mphy_rx_cfgclk_hib_rstb_sc                   ), //input
        //.mphy_rx_cfgclk_dis_hib_rstb_sc               (mphy_rx_cfgclk_dis_hib_rstb_sc               ), //input
        //.mphy_rx_sq_rstb_sc                           (mphy_rx_sq_rstb_sc                           ), //input
        //.mphy_rx_burst_hib_resetb_sc                  (mphy_rx_burst_hib_resetb_sc                  ), //input
        //// MPHY Testmodes
        //.mphy_tx_tm_hibern8_ctrl_sel                  (mphy_tx_tm_hibern8_ctrl_sel                  ), //input
        //.mphy_tx_tm_read_shadow                       (mphy_tx_tm_read_shadow                       ), //input
        //.mphy_tx_tm_sm_status                         (mphy_tx_tm_sm_status[3:0]                    ), //input
        //.mphy_tx_tm_send_msb_first                    (mphy_tx_tm_send_msb_first                    ), //input
        //.mphy_tx_tm_dither_en                         (mphy_tx_tm_dither_en                         ), //input
        //.mphy_rx_tm_read_shadow                       (mphy_rx_tm_read_shadow                       ), //input
        //.mphy_rx_tm_sm_status                         (mphy_rx_tm_sm_status[3:0]                    ), //input
        //.mphy_rx_tm_bypass_ohc                        (mphy_rx_tm_bypass_ohc                        ), //input
        //.mphy_rx_tm_force_cfg_state                   (mphy_rx_tm_force_cfg_state                   ), //input
        //.mphy_rx_tm_cfg_state                         (mphy_rx_tm_cfg_state[4:0]                    ), //input
        //.mphy_rx_tm_force_squelch_detect              (mphy_rx_tm_force_squelch_detect              ), //input
        //.mphy_rx_tm_squelch_detect                    (mphy_rx_tm_squelch_detect                    ), //input
        //.mphy_rx_tm_hibern8_ctrl_sel                  (mphy_rx_tm_hibern8_ctrl_sel                  ), //input
        //.mphy_rx_tm_bypass_difn_detect                (mphy_rx_tm_bypass_difn_detect                ), //input
        //.mphy_rx_tm_force_sym_state                   (mphy_rx_tm_force_sym_state                   ), //input
        //.mphy_rx_tm_sym_state                         (mphy_rx_tm_sym_state[4:0]                    ), //input
        //`endif
        // SATA sideband signals
        .sata_multi_rate_detect_en                    (1'b0                                         ), //input
        .sata_align_rate_det                          (/*floating*/                                 ), //output
        .sata_holdp_rcv                               (/*floating*/                                 ), //output
        .pma_in_pd_ref                                (pipe4_pma_in_pd_ref                          ), //output
        .rate_chg_pipe_reset_n                        (/*floating*/                                 ), //output
        .pipe_clk_div_override                        (pipe4_clk_div_override                       ), //output
        // USB LFPS configuration to ensure PMA tx_lfps_en asserted for at least 1 RefClk cycle
        .cfg_usb_ss_lfps_stretch                      (pipe4_cfg_usb_ss_lfps_stretch[3:0]           ), //input
        .cfg_usb_ssplus_lfps_stretch                  (pipe4_cfg_usb_ssplus_lfps_stretch[4:0]       ), //input
        // PCS configuration inputs
        // These should be set up before reset is released.
        `ifdef MP_128B_PATH 
        .pcie_gen4_cfg                                (pipe4_cfg_pcie_gen4                          ), //input
        .ccix_en                                      (1'b0                                         ), //input
        .ccix_esm0_sel                                (1'b0                                         ), //input
        `ifdef MP_PCIE
        .pcs_eq_cpl_mask                              (pipe4_cfg_pcs_eq_cpl_mask                    ), //input
        `endif
        `ifdef MP_USB
        .usb_err_cor_disable                          (pipe4_cfg_usb_err_cor_disable                ), //input
        `endif
        `ifdef CDN_MPPHY_RX_VALID_OVRD_CFG // @RELEASE@
        .pcs_rx_valid_ovrd_en                         (1'b0                                         ), //input
        `endif // @RELEASE@
        `ifdef MP_USB3_2
        // USB3.2 Gen 2 Tx deemphasis coefficient multipliers
        .cfg_usb_gen2_pre0                            (pipe4_cfg_usb_gen2_pre0[7:0]                 ), //input
        .cfg_usb_gen2_pre1                            (pipe4_cfg_usb_gen2_pre1[7:0]                 ), //input
        .cfg_usb_gen2_pre2                            (pipe4_cfg_usb_gen2_pre2[7:0]                 ), //input
        .cfg_usb_gen2_pre3                            (pipe4_cfg_usb_gen2_pre3[7:0]                 ), //input
        .cfg_usb_gen2_post0                           (pipe4_cfg_usb_gen2_post0[7:0]                ), //input
        .cfg_usb_gen2_post1                           (pipe4_cfg_usb_gen2_post1[7:0]                ), //input
        .cfg_usb_gen2_post2                           (pipe4_cfg_usb_gen2_post2[7:0]                ), //input
        .cfg_usb_gen2_post3                           (pipe4_cfg_usb_gen2_post3[7:0]                ), //input
        `endif
        `endif
        .rate_chg_cmn_suspend_override                (pipe4_rate_chg_cmn_suspend_override          ), //input
        .pcs_tx_elec_idle_pre_rel                     (pipe4_cfg_pcs_tx_elec_idle_pre_rel           ), //input
        .pcs_cal_realign                              (pipe4_cfg_pcs_cal_realign                    ), //input
        .pcs_cal_unlock_cnt                           (pipe4_cfg_pcs_cal_unlock_cnt[3:0]            ), //input
        .pcs_eios_clr_cal                             (pipe4_cfg_pcs_eios_clr_cal                   ), //input
        .pcs_128b_eios_clr_cal                        (pipe4_cfg_pcs_128b_eios_clr_cal              ), //input
        .pcs_128b_ignore_sigdet                       (pipe4_cfg_pcs_128b_ignore_sigdet             ), //input
        .pcs_8b10b_ignore_sigdet                      (pipe4_cfg_pcs_8b10b_ignore_sigdet            ), //input
        .pcs_sigdet_del                               (pipe4_cfg_pcs_sigdet_del[1:0]                ), //input
        .pcs_com_full_lock_cnt                        (pipe4_cfg_pcs_com_full_lock_cnt[11:0]        ), //input
        .pcs_com_lock_cnt                             (pipe4_cfg_pcs_com_lock_cnt[7:0]              ), //input
        .pcs_com_fast_lock_cnt                        (pipe4_cfg_pcs_com_fast_lock_cnt[7:0]         ), //input
        .pcs_eie_full_lock_cnt                        (pipe4_cfg_pcs_eie_full_lock_cnt[7:0]         ), //input
        .pcs_eie_lock_cnt                             (pipe4_cfg_pcs_eie_lock_cnt[3:0]              ), //input
        .pcs_eie_fast_lock_cnt                        (pipe4_cfg_pcs_eie_fast_lock_cnt[3:0]         ), //input
        .pcs_eios_cyc_err_msk                         (pipe4_cfg_pcs_eios_cyc_err_msk               ), //input
        .pcs_rcv_det_cnt_load                         (pipex_cfg_pcs_rcv_det_cnt_load[15:0]         ), //input
        .cfg_l1_x_exit_fast_cnt                       (pipe4_cfg_l1_x_exit_fast_cnt[5:0]            ), //input
        .cfg_usb_eb_realign_en                        (pipe4_cfg_usb_eb_realign_en                  ), //input
        .cfg_usb_pipe3_skip_comp_en                   (pipe4_cfg_usb_pipe3_skip_comp_en             )  //input
); // mp_pcs_original


always_ff @(posedge pipe4_clk_in or negedge pipe4_in_rst_n) begin
    if (~pipe4_in_rst_n) begin
        original_tx_deemph_r1 <= 18'b0;
        original_tx_deemph_strobe <= 1'b0;
    end else begin
        original_tx_deemph_r1 <= original_tx_deemph;

        if (original_tx_deemph != original_tx_deemph_r1) 
            original_tx_deemph_strobe <= 1'b1;
        else 
            original_tx_deemph_strobe <= 1'b0;
    end
end

`ifndef MP_PCIE
assign original_rx_eq_eval = 1'b0;
assign original_rx_invalid_request = 1'b0;
assign original_tx_local_preset_index = 4'b0;
assign original_tx_get_local_preset_coef = 1'b0;
`endif

`ifndef MP_128B_PATH
assign original_tx_deemph[17:2] = 16'b0;
`endif


mp_pcs_lane_pipe6_var_pclk_usb4 mp_pcs_serdes ( /*autoinst*/
        // Clock and Reset    
        .pipe_clk                       (pipe7_clk                      ), //input
        .pipe_rst_n                     (pipe7_rst_n                    ), //input
        .psm_clk                        (psm_clk                        ), //input
        .psm_rst_n                      (psm_rst_n                      ), //input
        .rx_rd_clk                      (rx_rd_clk                      ), //input
        .rx_rst_n                       (rx_rst_n                       ), //input
        //.ref_clk                        (ref_clk                        ), //input
        //.ref_rst_n                      (ref_rst_n                      ), //input
        .scan_mode                      (scanmode                       ), //input
        .pipe_data_path_override        (pipe7_data_path_override       ), //input
        //.pcs_rcv_det_cnt_load           (pipex_cfg_pcs_rcv_det_cnt_load[15:0] ), //input
        .ln_l0p_en                      (pipe7_ln_pma_a5_en             ), //output
        .pipe_clk_en                    (pipe7_clk_en                   ), //output
        //.iso_mode_en                    (pipe7_iso_mode_en              ), //input
        // PMA interface
        .pma_pll_ready                  (pma_pll_ready                  ), //input
        //.pma_rcv_detect                 (                               ), //output, not used for USB4 type-c
        .pma_power_state_ack            (pma_power_state_ack[5:0]       ), //input
        .pma_power_state_req            (serdes_pma_power_state_req[5:0]), //output
        .pma_data_width                 (serdes_pma_data_width[2:0]     ), //output
        .pma_standard_mode              (serdes_pma_standard_mode[2:0]  ), //output
        .pma_xcvr_pll_clk_en            (serdes_pma_xcvr_pll_clk_en     ), //output
        .pma_xcvr_pll_clk_en_ack        (pma_xcvr_pll_clk_en_ack        ), //input
        .pma_xcvr_pll_clk_en_ack_low    (pipe7_xcvr_pll_clk_en_ack_low  ), //input
        //.pma_rcv_detect_done            (pma_rcv_detect_done            ), //input, not used for USB4 type-c
        //.pma_rcv_detected               (pma_rcv_detected               ), //input, not used for USB4 type-c
        .pma_rx_sigdetect               (pma_rx_sigdetect               ), //input
        .pma_rd                         (pma_rd[31:0]                   ), //input
        .pma_rx_term                    (serdes_pma_rx_term             ), //output
        .pma_td                         (serdes_pma_td[31:0]            ), //output
        .pma_tx_elec_idle               (serdes_pma_tx_elec_idle        ), //output
        .pma_tx_local_fs                (pma_tx_local_fs[5:0]           ), //input
        .pma_tx_local_lf                (pma_tx_local_lf[5:0]           ), //input
        // PIPE interface
        `ifdef CDN_PIPE_DEEPPM_INC
        .pipe_restore_n                 (pipe7_restore_n                 ), //input
        `endif
        .rx_eq_eval_complete            (rx_eq_eval_complete             ), // input
        .pipe_rate                      (pipe7_rate[1:0]                 ), //input
        .pipe_powerdown                 (pipe7_powerdown[2:0]            ), //input
        //.pipe_pclk_change_ok            (pipe7_pclk_change_ok            ), //output
        //.pipe_pclk_change_ack           (pipe7_pclk_change_ack           ), //input
        //.pipe_tx_det_rx_lpbk            (pipe7_tx_det_rx_lpbk            ), //input
        .pipe_phy_status                (pipe7_phy_status                ), //output
        .pipe_32bit_en                  (pipe_32bit_en                   ), //input
        .pipe_tx_data                   (pipe7_tx_data[39:0]             ), //input
        .pipe_tx_elec_idle              (pipe7_tx_elec_idle[3:0]         ), //input
        .pipe_tx_data_valid             (pipe7_tx_data_valid             ), //input
        .pipe_tx_local_fs               (tx_local_fs[5:0]                ), //output
        .pipe_tx_local_lf               (tx_local_lf[5:0]                ), //output
        .pipe_rx_data                   (pipe7_rx_data[39:0]             ), //output
        .pipe_rx_valid                  (pipe7_rx_valid                  ), //output
        //.pipe_rx_status                 (pipe7_rx_status[2:0]            ), //output
        .pipe_rx_elec_idle              (pipe7_rx_elec_idle              ), //output
        .pipe_rx_termination            (pipe7_rx_termination            ), //input
        .pipe_rx_standby                (pipe7_rx_standby                ),
        .pipe_rx_standby_status         (pipe7_rx_standby_status         )
); // mp_pcs_serdes

`ifdef MP_128B_PATH_32_BIT
  localparam PMA_32BIT_EN = 1'b1;
`else
  localparam PMA_32BIT_EN = 1'b0;
`endif 

initial begin
    if (pipe_32bit_en == 1'b0 & PMA_32BIT_EN == 1'b1 & phy_mode_usb3_en == 1'b1) begin
        $fatal("mp_pcs_top: static configuration error: for original pipe, when pipe_32bit_en is low, MP_128B_PATH_32_BIT must not be set!");
    end
end
 
endmodule

// Local Variables:
// verilog-library-directories:("." "./MessageBus/hdl_src/" "./PIPE/trunk/")
// End:
