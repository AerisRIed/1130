`timescale 1fs/1fs

`ifdef DENALI_UVM
  // ****************************************************************
  // Import the UVM package and the complete USB4 Example package
  // Include the VIP UVM base classes as well as the user classes
  // ****************************************************************
  import uvm_pkg::*;
  import cdnUsb4Uvm::*;
  import DenaliSvMem::*;
  import DenaliSvPipephy::*;
  import cdnPipephyUvm::*;

  `include "cdnUsb4UvmUserTop.sv"
  
`endif

`timescale 1ps/1fs
// GEN3 Clock Periods 
`define USB4_LOW_CLK_PERIOD_L 24.0
`define USB4_HIGH_CLK_PERIOD_L 24.6
`define USB4_LOW_CLK_PERIOD_R 25.0
//`define USB4_HIGH_CLK_PERIOD_R 25.251
`define USB4_HIGH_CLK_PERIOD_R 25.0

`ifndef USB4_RETIMER_CNT
   `define USB4_RETIMER_CNT 1
`endif

  // Import the DDVAPI USB4 SV interface and the generic Mem interface
  reg refClk = 1'b0;
  reg TxPClk[2] = '{0,0};
  wire referenceClk;
  wire lnA_txDm ;
  wire lnA_rxDm ;
  wire lnA_txDp ;
  wire lnA_rxDp ;
  wire lnB_txDm ;
  wire lnB_rxDm ;
  wire lnB_txDp ;
  wire lnB_rxDp ;
  bit PERST_ = 1 ;

  `define NO_OF_PIPE_INSTANCE 2

  reg Clk;
  int cnt;
  int dataWidth;
  reg isRounded = 1; 
  reg [1:0] isGen3 = 1; 
  event finish_event;

  wire PhyDutTxDp[`NO_OF_PIPE_INSTANCE];
  wire PhyDutTx2Dp[`NO_OF_PIPE_INSTANCE];
  wire PhyDutTxDn[`NO_OF_PIPE_INSTANCE];
  wire PhyDutTx2Dn[`NO_OF_PIPE_INSTANCE];
  wire SerialXceiverTxDp[`NO_OF_PIPE_INSTANCE];
  wire SerialXceiverTx2Dp[`NO_OF_PIPE_INSTANCE];
  wire SerialXceiverTxDn[`NO_OF_PIPE_INSTANCE];
  wire SerialXceiverTx2Dn[`NO_OF_PIPE_INSTANCE];
  reg SerialXceiverTxSClk[`NO_OF_PIPE_INSTANCE];
  reg PhyDutSerialTxSClk[`NO_OF_PIPE_INSTANCE];
  wire [79:0] PipeXceiverTxData[`NO_OF_PIPE_INSTANCE];
  wire PipeXceiverTxDataValid[`NO_OF_PIPE_INSTANCE];
  wire [79:0] PipeDutRxData[`NO_OF_PIPE_INSTANCE];
  wire  Reset[`NO_OF_PIPE_INSTANCE];
  wire SerDesArch[`NO_OF_PIPE_INSTANCE];
  wire TxDetectRx[`NO_OF_PIPE_INSTANCE];
  wire [3:0] TxElecIdle[`NO_OF_PIPE_INSTANCE];
  wire [3:0] PowerDown[`NO_OF_PIPE_INSTANCE];
  wire [2:0] PCLKRate[`NO_OF_PIPE_INSTANCE];
  wire RxStandby[`NO_OF_PIPE_INSTANCE];
  wire RxStandbyStatus[`NO_OF_PIPE_INSTANCE];
  wire PhyStatus[`NO_OF_PIPE_INSTANCE];
  logic DelayedPhyStatus[`NO_OF_PIPE_INSTANCE];
  wire RxElecIdle[`NO_OF_PIPE_INSTANCE];
  wire [7:0] M2P_MessageBus[`NO_OF_PIPE_INSTANCE];
  wire [7:0] P2M_MessageBus[`NO_OF_PIPE_INSTANCE];
  wire RxClk[`NO_OF_PIPE_INSTANCE];
  bit RxClk1[`NO_OF_PIPE_INSTANCE];
  reg Pclk[`NO_OF_PIPE_INSTANCE];
  wire [3:0] SerialRate[`NO_OF_PIPE_INSTANCE];
  wire [3:0] Rate[`NO_OF_PIPE_INSTANCE];
  wire [1:0] Width[`NO_OF_PIPE_INSTANCE];
  wire [3:0] SerialPHYMode[`NO_OF_PIPE_INSTANCE];
  wire [3:0] PHYMode[`NO_OF_PIPE_INSTANCE];
  reg LocalElecIdle[`NO_OF_PIPE_INSTANCE];
  wire x8x10[`NO_OF_PIPE_INSTANCE];
  reg PipeNBitTxClk[`NO_OF_PIPE_INSTANCE];
  reg PipeNBitRxClk[`NO_OF_PIPE_INSTANCE];
  reg SerialNBitTxClk[`NO_OF_PIPE_INSTANCE];
  reg SerialNBitRxClk[`NO_OF_PIPE_INSTANCE];
  wire RxValid[`NO_OF_PIPE_INSTANCE];
  wire BlockAlignControl[`NO_OF_PIPE_INSTANCE];
  wire PClkM2P[`NO_OF_PIPE_INSTANCE];
  wire PClkP2M[`NO_OF_PIPE_INSTANCE];
  wire MaxPClk[`NO_OF_PIPE_INSTANCE];
  wire DbgDutTxBitClk[`NO_OF_PIPE_INSTANCE];
  wire DbgDutMonTxBitClk[`NO_OF_PIPE_INSTANCE];
  wire DbgSerialTxBitClk[`NO_OF_PIPE_INSTANCE];
  wire DbgDutRxBitClk[`NO_OF_PIPE_INSTANCE];
  wire DbgDutMonRxBitClk[`NO_OF_PIPE_INSTANCE];
  wire DbgSerialRxBitClk[`NO_OF_PIPE_INSTANCE];
  reg  ChangedPhyStatusOrdered = 1'b0;
  wire [2:0] DutRxStatus[`NO_OF_PIPE_INSTANCE];
  wire RxEIDetectDisable[`NO_OF_PIPE_INSTANCE];
  wire RxTermination[`NO_OF_PIPE_INSTANCE];
  wire DeepPMReq[`NO_OF_PIPE_INSTANCE];
  wire DeepPMAck[`NO_OF_PIPE_INSTANCE];
  wire Restore[`NO_OF_PIPE_INSTANCE];
  int clkOnPeriod [`NO_OF_PIPE_INSTANCE];
  int rxClkdutyCycle ;

  // For GEN2 multiply the GEN3 clock periods by 2 
  initial begin
     fork 
	begin
	   uvm_config_db#(int)::wait_modified(null, "*", "isRounded");
	   void' ( uvm_config_db#(int)::get(null,"*", "isRounded", isRounded));
	end
	begin
	   uvm_config_db#(int)::wait_modified(null, "*", "isGen3");
	   void' ( uvm_config_db#(int)::get(null,"*", "isGen3", isGen3));
	end
     join
  end

  always 
  begin
     #( isRounded ? ( isGen3 ? `USB4_LOW_CLK_PERIOD_R : (`USB4_LOW_CLK_PERIOD_R*2))
     : ( isGen3 ? `USB4_LOW_CLK_PERIOD_L : (`USB4_LOW_CLK_PERIOD_L*2) )) refClk = 0;
     #( isRounded ? ( isGen3 ? `USB4_HIGH_CLK_PERIOD_R : (`USB4_HIGH_CLK_PERIOD_R*2))
     : ( isGen3 ? `USB4_HIGH_CLK_PERIOD_L : (`USB4_HIGH_CLK_PERIOD_L*2) )) refClk = 1;
  end
  
  assign referenceClk = !refClk;

  initial
  begin
     Clk = 1'b0;
  end
   
  always @(posedge refClk) begin
   dataWidth = ( (2 ** Width[0]) * (x8x10[0] ? 8 : 10) );
   cnt = cnt + 1;
   if(cnt == (dataWidth/2)) begin
     TxPClk[0] = ~TxPClk[0];
     cnt = 0;
   end  
  end

  always  begin 
    #25ps Clk = ~Clk;
  end

  defparam dutHost.HAS_EMBEDDED_USB_HOST = 1 ;
  defparam dutHost.NOF_DP_SOURCES = 1 ;
  usb4PipephyActHostSuperWrapper
  dutHost
  (  
    // Lane A ports
	.pipeA_TxData              (PipeXceiverTxData[0]),
	.pipeA_TxDataValid         (PipeXceiverTxDataValid[0]),
	.pipeA_RxData              (PipeDutRxData[0]),     
	.pipeA_PHYMode             (PHYMode[0]),
	.pipeA_SerDesArch          (SerDesArch[0]),
	.pipeA_TxDetectRx          (TxDetectRx[0]),
	.pipeA_TxElecIdle          (TxElecIdle[0]),
	.pipeA_Reset               (Reset[0]),  
	.pipeA_PowerDown           (PowerDown[0]),
	.pipeA_Rate                (Rate[0]),
	.pipeA_Width               (Width[0]),
	.pipeA_RxStandby           (RxStandby[0]),
	.pipeA_RxStandbyStatus     (RxStandbyStatus[0]),
	.pipeA_RxValid             (RxValid[0]),
	.pipeA_PhyStatus           (PhyStatus[0]),
	.pipeA_RxElecIdle          (RxElecIdle[0]),
	.pipeA_RxStatus            (DutRxStatus[0]),
	.pipeA_M2P_MessageBus      (M2P_MessageBus[0]),
	.pipeA_P2M_MessageBus      (P2M_MessageBus[0]),
	.pipeA_RxClk               (RxClk[0]),
	.pipeA_RxWidth             (),
	.pipeA_PClk_Mac2Phy        (PClkM2P[0]),
	.pipeA_Max_PClk            (MaxPClk[0]),
	.pipeA_TxParallelClk       (TxPClk[0]),
	.pipeA_CtrlrIntegTxClk     (),
	.pipeA_CtrlrIntegRxClk     (),
	.pipeA_Multiple8_10        (x8x10[0]),
	.pipeA_BlockAlignControl   (BlockAlignControl[0]),

    // Lane B ports
	.pipeB_TxData              (PipeXceiverTxData[1]),
	.pipeB_TxDataValid         (PipeXceiverTxDataValid[1]),
	.pipeB_RxData              (PipeDutRxData[1]),     
	.pipeB_PHYMode             (PHYMode[1]),
	.pipeB_SerDesArch          (SerDesArch[1]),
	.pipeB_TxDetectRx          (TxDetectRx[1]),
	.pipeB_TxElecIdle          (TxElecIdle[1]),
	.pipeB_Reset               (Reset[1]),  
	.pipeB_PowerDown           (PowerDown[1]),
	.pipeB_Rate                (Rate[1]),
	.pipeB_Width               (Width[1]),
	.pipeB_RxStandby           (RxStandby[1]),
	.pipeB_RxStandbyStatus     (RxStandbyStatus[1]),
	.pipeB_RxValid             (RxValid[1]),
	.pipeB_PhyStatus           (PhyStatus[1]),
	.pipeB_RxElecIdle          (RxElecIdle[1]),
	.pipeB_RxStatus            (DutRxStatus[1]),
	.pipeB_M2P_MessageBus      (M2P_MessageBus[1]),
	.pipeB_P2M_MessageBus      (P2M_MessageBus[1]),
	.pipeB_RxClk               (RxClk[1]),
	.pipeB_RxWidth             (),
	.pipeB_PClk_Mac2Phy        (PClkM2P[1]),
	.pipeB_Max_PClk            (MaxPClk[1]),
	.pipeB_TxParallelClk       (TxPClk[0]),
	.pipeB_CtrlrIntegTxClk     (),
	.pipeB_CtrlrIntegRxClk     (),
	.pipeB_Multiple8_10        (x8x10[1]),
	.pipeB_BlockAlignControl   (BlockAlignControl[1]),
    
	// Lane C ports
        .lnC_LsTx     (dutHostLnC_LsTx),
        .lnC_LsRx     (dutHostLnC_LsRx),
    
	.PciePerst_   (PERST_) 
  );

  defparam psvHost.HAS_EMBEDDED_USB_HOST = 1 ;
  defparam psvHost.NOF_DP_SOURCES = 1 ;
  usb4PipephyPsvHostSuperWrapper
  psvHost
  (  
    // Lane A ports
	.pipeA_TxData              (PipeXceiverTxData[0]),
	.pipeA_TxDataValid         (PipeXceiverTxDataValid[0]),
	.pipeA_RxData              (PipeDutRxData[0]),     
	.pipeA_PHYMode             (PHYMode[0]),
	.pipeA_SerDesArch          (SerDesArch[0]),
	.pipeA_TxDetectRx          (TxDetectRx[0]),
	.pipeA_TxElecIdle          (TxElecIdle[0]),
	.pipeA_Reset               (Reset[0]),  
	.pipeA_PowerDown           (PowerDown[0]),
	.pipeA_Rate                (Rate[0]),
	.pipeA_Width               (Width[0]),
	.pipeA_RxStandby           (RxStandby[0]),
	.pipeA_RxStandbyStatus     (RxStandbyStatus[0]),
	.pipeA_RxValid             (RxValid[0]),
	.pipeA_PhyStatus           (PhyStatus[0]),
	.pipeA_RxElecIdle          (RxElecIdle[0]),
	.pipeA_RxStatus            (DutRxStatus[0]),
	.pipeA_M2P_MessageBus      (M2P_MessageBus[0]),
	.pipeA_P2M_MessageBus      (P2M_MessageBus[0]),
	.pipeA_RxClk               (RxClk[0]),
	.pipeA_RxWidth             (),
	.pipeA_PClk_Mac2Phy        (PClkM2P[0]),
	.pipeA_Max_PClk            (MaxPClk[0]),
	.pipeA_TxParallelClk       (TxPClk[0]),
	.pipeA_CtrlrIntegTxClk     (),
	.pipeA_CtrlrIntegRxClk     (),
	.pipeA_Multiple8_10        (x8x10[0]),
	.pipeA_BlockAlignControl   (BlockAlignControl[0]),

    // Lane B ports
	.pipeB_TxData              (PipeXceiverTxData[1]),
	.pipeB_TxDataValid         (PipeXceiverTxDataValid[1]),
	.pipeB_RxData              (PipeDutRxData[1]),     
	.pipeB_PHYMode             (PHYMode[1]),
	.pipeB_SerDesArch          (SerDesArch[1]),
	.pipeB_TxDetectRx          (TxDetectRx[1]),
	.pipeB_TxElecIdle          (TxElecIdle[1]),
	.pipeB_Reset               (Reset[1]),  
	.pipeB_PowerDown           (PowerDown[1]),
	.pipeB_Rate                (Rate[1]),
	.pipeB_Width               (Width[1]),
	.pipeB_RxStandby           (RxStandby[1]),
	.pipeB_RxStandbyStatus     (RxStandbyStatus[1]),
	.pipeB_RxValid             (RxValid[1]),
	.pipeB_PhyStatus           (PhyStatus[1]),
	.pipeB_RxElecIdle          (RxElecIdle[1]),
	.pipeB_RxStatus            (DutRxStatus[1]),
	.pipeB_M2P_MessageBus      (M2P_MessageBus[1]),
	.pipeB_P2M_MessageBus      (P2M_MessageBus[1]),
	.pipeB_RxClk               (RxClk[1]),
	.pipeB_RxWidth             (),
	.pipeB_PClk_Mac2Phy        (PClkM2P[1]),
	.pipeB_Max_PClk            (MaxPClk[1]),
	.pipeB_TxParallelClk       (TxPClk[0]),
	.pipeB_CtrlrIntegTxClk     (),
	.pipeB_CtrlrIntegRxClk     (),
	.pipeB_Multiple8_10        (x8x10[1]),
	.pipeB_BlockAlignControl   (BlockAlignControl[1]),
    
	// Lane C ports
        .lnC_LsTx     (dutHostLnC_LsTx),
        .lnC_LsRx     (dutHostLnC_LsRx),
    
	.PciePerst_   (PERST_) 
  );

  usb4PipephyActDevSuperWrapper
  phyDut (
        .pipeA_TxData(PipeXceiverTxData[0]), 
        .pipeA_TxDataValid(PipeXceiverTxDataValid[0]),
        .pipeA_TxDp(dutHostLnA_txDp),  // Connection update
        .pipeA_TxDn(dutHostLnA_txDm),  // Connection update
        .pipeA_RxDp(dutHostLnA_rxDp),  // Connection update
        .pipeA_RxDn(dutHostLnA_rxDm),  // Connection update
        .pipeA_RxData(PipeDutRxData[0]),
        .pipeA_PHYMode(PHYMode[0]),
        .pipeA_SerDesArch(SerDesArch[0]),
        .pipeA_TxDetectRx(TxDetectRx[0]),
        .pipeA_TxElecIdle(TxElecIdle[0]),
        .pipeA_Reset(Reset[0]),
        .pipeA_PowerDown(PowerDown[0]),
        .pipeA_Rate(Rate[0]),
        .pipeA_Width(Width[0]),
        .pipeA_RxStandby(RxStandby[0]),
        .pipeA_RxStandbyStatus(RxStandbyStatus[0]),
        .pipeA_RxValid(RxValid[0]),
        .pipeA_PhyStatus(PhyStatus[0]),
        .pipeA_RxElecIdle(RxElecIdle[0]),
        .pipeA_RxStatus(DutRxStatus[0]),
        .pipeA_M2P_MessageBus(M2P_MessageBus[0]),
        .pipeA_P2M_MessageBus(P2M_MessageBus[0]),
        .pipeA_RxClk(RxClk[0]),
        .pipeA_RxWidth(Width[0]),
        .pipeA_PClk_Mac2Phy(PClkM2P[0]),
        .pipeA_RefClk(Clk),
        .pipeA_Max_PClk(MaxPClk[0]),
        .pipeA_TxBitClk(refClk),  // Connection update
        .pipeA_RxBitClk(refClk),  // Connection update
        .pipeA_TxParallelClk(TxPClk[0]),
        .pipeA_DbgTxBitClk(DbgDutTxBitClk[0]),
        .pipeA_DbgRxBitClk(DbgDutRxBitClk[0]),
        .pipeA_BlockAlignControl(BlockAlignControl[0]),

        .pipeB_TxData(PipeXceiverTxData[1]), 
        .pipeB_TxDataValid(PipeXceiverTxDataValid[1]),
        .pipeB_TxDp(dutHostLnB_txDp),  // Connection update
        .pipeB_TxDn(dutHostLnB_txDm),  // Connection update
        .pipeB_RxDp(dutHostLnB_rxDp),  // Connection update
        .pipeB_RxDn(dutHostLnB_rxDm),  // Connection update
        .pipeB_RxData(PipeDutRxData[1]),
        .pipeB_PHYMode(PHYMode[1]),
        .pipeB_SerDesArch(SerDesArch[1]),
        .pipeB_TxDetectRx(TxDetectRx[1]),
        .pipeB_TxElecIdle(TxElecIdle[1]),
        .pipeB_Reset(Reset[1]),
        .pipeB_PowerDown(PowerDown[1]),
        .pipeB_Rate(Rate[1]),
        .pipeB_Width(Width[1]),
        .pipeB_RxStandby(RxStandby[1]),
        .pipeB_RxStandbyStatus(RxStandbyStatus[1]),
        .pipeB_RxValid(RxValid[1]),
        .pipeB_PhyStatus(PhyStatus[1]),
        .pipeB_RxElecIdle(RxElecIdle[1]),
        .pipeB_RxStatus(DutRxStatus[1]),
        .pipeB_M2P_MessageBus(M2P_MessageBus[1]),
        .pipeB_P2M_MessageBus(P2M_MessageBus[1]),
        .pipeB_RxClk(RxClk[1]),
        .pipeB_RxWidth(Width[1]),
        .pipeB_PClk_Mac2Phy(PClkM2P[1]),
        .pipeB_RefClk(Clk),
        .pipeB_Max_PClk(MaxPClk[1]),
        .pipeB_TxBitClk(refClk),  // Connection update
        .pipeB_RxBitClk(refClk),  // Connection update
        .pipeB_TxParallelClk(TxPClk[0]),
        .pipeB_DbgTxBitClk(DbgDutTxBitClk[1]),
        .pipeB_DbgRxBitClk(DbgDutRxBitClk[1]),
        .pipeB_BlockAlignControl(BlockAlignControl[1])
  );

  



   defparam actDev.HAS_EMBEDDED_USB_DEV = 1 ;
   defparam actDev.NOF_DP_SINKS = 1 ;
  usb4ActDevSuperWrapper 
  actDev
  (  // Lane A ports
        .lnA_txDp     (dutHostLnA_rxDp),
        .lnA_txDm     (dutHostLnA_rxDm),
        .lnA_rxDp     (dutHostLnA_txDp),
        .lnA_rxDm     (dutHostLnA_txDm),
        .lnA_inTxClk  (refClk),
        .lnA_inRxClk  (refClk),
        .lnA_txSync   (),
        
        // Lane B ports
        .lnB_txDp     (dutHostLnB_rxDp),
        .lnB_txDm     (dutHostLnB_rxDm),
        .lnB_rxDp     (dutHostLnB_txDp),
        .lnB_rxDm     (dutHostLnB_txDm),
        .lnB_inTxClk  (refClk),
        .lnB_inRxClk  (refClk),
        .lnB_txSync   ( ),
        .lnC_LsTx     (dutHostLnC_LsRx   ),
        .lnC_LsRx     (dutHostLnC_LsTx   )
  ) ;
  
`ifdef DENALI_UVM
  // ****************************************************************
  // Call the global UVM run_test task.  This starts the entire UVM
  // test & environment.
  // ****************************************************************
  initial begin
    void'(uvm_config_db#(bit)::   set(null, "*","enableSideband", 0));
    void'(uvm_config_db#(bit)::   set(null, "*","enablePipeMode", 1));
    void'(uvm_config_db#(string)::set(null, "*","PipeIntf", "32_BIT"));
    void' (uvm_config_db#(bit)::   set(null, "*","enableHia", 1));
    // To enable Gen2
    //void' ( uvm_config_db#(denaliUsb4SpeedModeT)::   set(null, "*","setCurrentSpeed", DENALI_USB4_SPEED_MODE_GEN2) );
    void' ( uvm_config_db#(int)::   set(null,"*", "isRounded", 1) );
    // Only Used for xcelium
    //$shm_open("waves.shm");
    //$shm_probe(top,"AC");
    //run_test();
  end
`endif
