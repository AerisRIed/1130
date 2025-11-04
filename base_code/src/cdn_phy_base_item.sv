//
// Template for UVM-compliant configuration class
//

`ifndef CDN_PHY_BASE_ITEM__SV
`define CDN_PHY_BASE_ITEM__SV

class timing_param_t extends uvm_object; 

   // Define test timing parameters
   rand real           tDisconnectTx; // min: 50ms, max: --
   rand real           tDisconnectRx; // min: 14us, max: 1000us
   rand real           tConnectRx; // min: 25us, max: --
   rand real           tCmdResponse; // min: --, max: 50ms
   rand real           tATTimeout; // min:100ms, max: --
   rand real           tRTTimeout; // min:100ms, max: --
   rand real           tLTPhase4; // min:25ms, max: --
   rand real           tTxFFEResponse; // min: --, max:2ms
   rand real           tWake; // min:1 Bit time, max:9 Bit time
   rand real           tDisabled; // min:10ms, max: --
   rand real           tTrainingError; // min: --, max:500us
   rand real           tTrainingAbort1; // min:1sec, max: --
   rand real           tTrainingAbort2; // min:100ms, max: --
   rand real           tLaneParams; // min: (Lane Initialization – 1 Recovery Flow - 0) ms, max:5ms
   rand real           tPollTXFFE; // min:1ms, max:5ms
   rand real           tGen4TS1; // min: --, max:400ms
   rand real           tGen4TS2; // min: --, max:200ms
   rand real           tBonding; // min:40us, max:100us
   rand real           tCLxIdleRx; // min:130ns, max: --
   rand real           tCLxRetry; // min:1.5us, max: --
   rand real           tCLxRequest; // min: --, max: 14 (Host Router) us, 2(Device Router) us
   rand real           tCLxResponse; // min: --, max:800ns
   rand real           tCLxSetup; // min: --, max:200us
   rand real           tCLxAccept; // min:500us, max: --
   rand real           tTxOff; // min: --, max: 100 (Gen 2/3) ns, 150 (Gen 4) ns
   rand real           tEnterLFPS1; // min:400ns, max:500ns
   rand real           tEnterLFPS2; // min: 2500 (Gen 2/3) ns, 400 (Gen 4) ns, max: 5000 (Gen 2/3) ns, 500 (Gen 4) ns
   rand real           tEnterLFPS4; // min:1700ns, max:2000ns
   rand real           tEnterLFPS5; // min:2500ns, max:3000ns
   rand real           tTimeInCL0; // min:500ns, max: --
   rand real           tLFPSDuration; // min: --, max:2560ns
   rand real           tStopLFPS1; // min: --, max:150us
   rand real           tStopLFPS2; // min: --, max:2us
   rand real           tCL0sSwitch; // min:500us, max: --
   rand real           tWarmUpCL0s; // min: --, max:50us
   rand real           tWarmUpCL1; // min: --, max:10us
   rand real           tWarmUpCL2; // min: --, max:100us
   rand real           tRxLock; // min: --, max: 50 (Gen 2/3) us, 30 (Gen 4) us
   rand real           tWakeResponse; // min: --, max: 7 (Host Router) us, 1 (Device Router) us
   rand real           tTrainingTransition; // min: --, max: 7 (Host Router) us, 1 (Device Router) us
   rand real           tActivateSSC; // min: --, max: 1000 (Transition to Training from CLd) us, 10 (Otherwise)us
   rand real           tSSCActivated; // min:2us, max: 1000 (Transition to Training from CLd) us, 5 (Otherwise)us
   rand real           tSymbolLock; // min: --, max:1us
   rand real           tLRoffResponse; // min: --, max:20ms
   rand real           tTS2Timeout; // min:9us, max: --
   rand real           tActivateNewTx; // min:1ms, max: --
   rand real           tSetSR; // min: --, max:50ms
   rand real           tLocalSBAccess; // min: --, max:50ms
   rand real           tRemoteSBAccess; // min: --, max:150ms
   rand real           tSwitchAck; // min:1ms, max:10ms
   rand real           tRecoveryAbort; // min: --, max:10ms
   rand real           tRecoveryResponse; // min: --, max:200us
   rand real           tRecoveryTxOff; // min: --, max:150us
   rand real           tRecoveryRxOff; // min: --, max:50us
   rand real           tScramblerSampleRate; // min:2ms, max:10ms
   rand real           tScramblerReSyncMessage; // min: --, max:0.5ms

   // ToDo: Add other environment configuration varaibles

   constraint c_timing_param {
      soft tDisconnectTx >= 50;
      soft tDisconnectRx inside {[14:1000]};
   }
   // ToDo: Add constraint blocks to prevent error injection

   `uvm_object_utils_begin(timing_param_t)
      `uvm_field_real(tDisconnectTx           ,UVM_ALL_ON) 
      `uvm_field_real(tDisconnectRx           ,UVM_ALL_ON)
      `uvm_field_real(tConnectRx              ,UVM_ALL_ON)
      `uvm_field_real(tCmdResponse            ,UVM_ALL_ON)
      `uvm_field_real(tATTimeout              ,UVM_ALL_ON)
      `uvm_field_real(tRTTimeout              ,UVM_ALL_ON)
      `uvm_field_real(tLTPhase4               ,UVM_ALL_ON)
      `uvm_field_real(tTxFFEResponse          ,UVM_ALL_ON)
      `uvm_field_real(tWake                   ,UVM_ALL_ON)
      `uvm_field_real(tDisabled               ,UVM_ALL_ON)
      `uvm_field_real(tTrainingError          ,UVM_ALL_ON)
      `uvm_field_real(tTrainingAbort1         ,UVM_ALL_ON)
      `uvm_field_real(tTrainingAbort2         ,UVM_ALL_ON)
      `uvm_field_real(tLaneParams             ,UVM_ALL_ON)
      `uvm_field_real(tPollTXFFE              ,UVM_ALL_ON)
      `uvm_field_real(tGen4TS1                ,UVM_ALL_ON)
      `uvm_field_real(tGen4TS2                ,UVM_ALL_ON)
      `uvm_field_real(tBonding                ,UVM_ALL_ON)
      `uvm_field_real(tCLxIdleRx              ,UVM_ALL_ON)
      `uvm_field_real(tCLxRetry               ,UVM_ALL_ON)
      `uvm_field_real(tCLxRequest             ,UVM_ALL_ON)
      `uvm_field_real(tCLxResponse            ,UVM_ALL_ON)
      `uvm_field_real(tCLxSetup               ,UVM_ALL_ON)
      `uvm_field_real(tCLxAccept              ,UVM_ALL_ON)
      `uvm_field_real(tTxOff                  ,UVM_ALL_ON)
      `uvm_field_real(tEnterLFPS1             ,UVM_ALL_ON)
      `uvm_field_real(tEnterLFPS2             ,UVM_ALL_ON)
      `uvm_field_real(tEnterLFPS4             ,UVM_ALL_ON)
      `uvm_field_real(tEnterLFPS5             ,UVM_ALL_ON)
      `uvm_field_real(tTimeInCL0              ,UVM_ALL_ON)
      `uvm_field_real(tLFPSDuration           ,UVM_ALL_ON)
      `uvm_field_real(tStopLFPS1              ,UVM_ALL_ON)
      `uvm_field_real(tStopLFPS2              ,UVM_ALL_ON)
      `uvm_field_real(tCL0sSwitch             ,UVM_ALL_ON)
      `uvm_field_real(tWarmUpCL0s             ,UVM_ALL_ON)
      `uvm_field_real(tWarmUpCL1              ,UVM_ALL_ON)
      `uvm_field_real(tWarmUpCL2              ,UVM_ALL_ON)
      `uvm_field_real(tRxLock                 ,UVM_ALL_ON)
      `uvm_field_real(tWakeResponse           ,UVM_ALL_ON)
      `uvm_field_real(tTrainingTransition     ,UVM_ALL_ON)
      `uvm_field_real(tActivateSSC            ,UVM_ALL_ON)
      `uvm_field_real(tSSCActivated           ,UVM_ALL_ON)
      `uvm_field_real(tSymbolLock             ,UVM_ALL_ON)
      `uvm_field_real(tLRoffResponse          ,UVM_ALL_ON)
      `uvm_field_real(tTS2Timeout             ,UVM_ALL_ON)
      `uvm_field_real(tActivateNewTx          ,UVM_ALL_ON)
      `uvm_field_real(tSetSR                  ,UVM_ALL_ON)
      `uvm_field_real(tLocalSBAccess          ,UVM_ALL_ON)
      `uvm_field_real(tRemoteSBAccess         ,UVM_ALL_ON)
      `uvm_field_real(tSwitchAck              ,UVM_ALL_ON)
      `uvm_field_real(tRecoveryAbort          ,UVM_ALL_ON)
      `uvm_field_real(tRecoveryResponse       ,UVM_ALL_ON)
      `uvm_field_real(tRecoveryTxOff          ,UVM_ALL_ON)
      `uvm_field_real(tRecoveryRxOff          ,UVM_ALL_ON)
      `uvm_field_real(tScramblerSampleRate    ,UVM_ALL_ON)
      `uvm_field_real(tScramblerReSyncMessage ,UVM_ALL_ON)

      // ToDo: add properties using macros here

   `uvm_object_utils_end

   function new(string name = "timing_param_t");
      super.new(name);
   endfunction: new

endclass: timing_param_t


class data_packet_t extends uvm_object;
  rand symbol_sync_t  symbol_sync;
  rand pdata_a_t      datas;

  string report_id = get_type_name();

  `uvm_object_utils_begin(data_packet_t)
    `uvm_field_enum(symbol_sync_t, symbol_sync, UVM_ALL_ON)
    `uvm_field_array_int(datas, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name="data_packet_t");
    super.new(name);
  endfunction:new

endclass: data_packet_t


`endif // CDN_PHY_BASE_ITEM__SV

