//-----------------------------------------------------------------------------
//    This confidential and proprietary HDL soft description of a Hardware
//    component may be used only as authorized by a licensing agreement from
//    Cadence Design Foundry. In the event of publication, the following 
//    notice is applicable:
//
//               (C) COPYRIGHT 2005 Cadence Design Foundry
//                         ALL RIGHTS RESERVED
//
//     The entire notice above must be reproduced on all authorized
//     copies of this code.
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//
// Module         : lfps_monitor_serial_tx
// Author         : afortin
// Created        : Jan 20, 2015
// Abstract       : Connects to TX serial (egress) ports of PHY to detect any
//                  LFPS messages in USB3 rev1.
//
// Notes          : Connect directly to tx_m/tx_p in parallel with any other 
//                  TB module.
// 
// $Id:  $
//----------------------------------------------------------------------------
//
//----------------------------------------------------------------------------

`timescale 1ps/1ps // MUST have timescale 1ps/1ps for monitor

`ifndef TB
 `define TB cdn_phy_tb_top
`endif

  
// instantiate this monitor in tb_top at the TX egress side
module lfps_tx_chk
  (input       phy_reset_n,
   input [3:0] phy_mode,
   input [1:0] phy_rate,
   input       pma_refclk,
   input       tx_td_clk,
   input       pipe_clk,
   input       pipe_tx_ones_zeros,
   input [1:0] pipe_powerdown,
   input [1:0] pipe_powerdown_pcs,
   input       pipe_tx_det_rx_lpbk,
   input       pipe_tx_elec_idle,
   input       pipe_tx_data_valid,
   input       pipe_phy_status,
   input       tx_m, 
   input       tx_p);

   // set proper values to those parameters in instantiation
   parameter  START_AUTOMATICALLY = 1; // set to 0 to avoid starting monitor automatically upon startup
   parameter  PCS_VERSION = 0; // set to 1 when needed, so far only 2 versions are supported, 1 and default

   // internal parameters - do not modifynn
   localparam TOLERANCE_DISTORTION = 7ns; // 4ns distortion + 1 cycle (2ns) for uneven random metastability
   localparam TOLERANCE_DISTORTION_P3 = 105ns; // at 2 cycles of ref_clk consider 19.2MHz is 104.166ns
   localparam USB3 = 1;
   localparam DP   = 6;
   localparam USB4 = 7;
   localparam GEN1 = 0;
   localparam GEN2 = 1;
   localparam P0 = 0;
   localparam P1 = 1;
   localparam P2 = 2;
   localparam P3 = 3;

   // control knobs - use them to control module from TB
   bit  active = 0;   // set to 0/1 to activate/deactivate all module
   bit  error_en = 1; // set to 0 to disable all errors while keeping LFPS detector running
   //bit    speedup = 0;


   // spec-related variables (refer to spec USB3.1 rev1, tables 6-28 and 6-29)
   realtime tPeriod_min = 19.75ns; // 20ns with some tolerance for gates;
   realtime tPeriod_max = 100.25ns; // 100ns with some tolerance for gates;

   real     duty_cycle_min = 39;
   real     duty_cycle_max = 60;


   realtime tPeriod_min_exp    = 20ns ;
   realtime tPeriod_max_exp    = 100ns ;
   real     duty_cycle_min_exp = 39 ; //should set to 40ns after the DUT ready
   real     duty_cycle_max_exp = 60 ;

//numbers of the LFPS cycles
   int lfps_cycles_num;
   int lfps_cycles_num_min_exp ;

//duration of  electrical idle constraint for DP
   realtime tSilence_min_exp    = 80ns ;
   realtime tSilence_max_exp    = 180ns ;

//Period of time in which electrical-idle shall be set after the LFPS sequence for USB4
   realtime tPredata_min_exp    = 80ns ;
   realtime tPredata_max_exp    = 120ns ;

//The expected period and duty of each protocol  
   always @(posedge phy_reset_n or phy_mode or phy_rate) begin
     if (phy_mode == USB3 ) begin
       if(phy_rate == GEN1) begin
         tPeriod_max_exp = 100ns;
       end 
       else begin
         tPeriod_max_exp = 80ns;      
       end
       lfps_cycles_num_min_exp = 2;
     end
     else if (phy_mode == DP ) begin
         tPeriod_max_exp = 80ns;
         duty_cycle_min_exp = 45 ;  
         duty_cycle_max_exp = 55 ; 
         lfps_cycles_num_min_exp=16;        
     end
     else if (phy_mode == USB4 ) begin
         tPeriod_max_exp = 80ns;
         duty_cycle_min_exp = 45 ;
         duty_cycle_max_exp = 55 ;         
         lfps_cycles_num_min_exp=16;        
     end
   end

//pipe lfps start latency
   realtime lfps_start_latency;
   realtime lfps_start_latency_min_exp;
   realtime lfps_start_latency_max_exp;
   always @(posedge phy_reset_n or pipe_powerdown) begin
     if (pipe_powerdown == P3 ) begin  //base on the previous assert, need to be confirm
       lfps_start_latency_min_exp = 2ns;
       lfps_start_latency_max_exp = 500ns;
     end
     else begin
       lfps_start_latency_min_exp = 2ns;
       lfps_start_latency_max_exp = 56ns;
     end
   end




/* -----\/----- EXCLUDED -----\/-----
   struct {
      realtime tBurst_min = 0.6us;
      realtime tBurst_max = 1.4us;
      realtime tRepeat_min = 6us;
      realtime tRepeat_max = 14us;
   } polling;
   
   struct {
      realtime tBurst_min = 40ns;
      realtime tBurst_max = 200ns;
      realtime tRepeat_min = 160ms;
      realtime tRepeat_max = 240ms;
      realtime tRepeat_min_speedup = 16us;
      realtime tRepeat_max_speedup = 24us;
   } ping;

   struct {
      realtime tburst_min = 80ms;
      realtime tburst_max = 120ms;
      realtime tburst_min_speedup = 80us;
      realtime tburst_max_speedup = 120us;
   } treset;

   struct {
      realtime tburst_min = 600ns;
      realtime tburst_max = 2ms;
      realtime tburst_min_speedup = 600ns;
      realtime tburst_max_speedup = 200us;
   } u1_exit;

   struct {
      realtime tburst_min = 80us;
      realtime tburst_max = 2ms;
      realtime tburst_min_speedup = 80us;
      realtime tburst_max_speedup = 200us;
   } u2_loopback_exit;
   
   struct {
      realtime tburst_min = 80us;
      realtime tburst_max = 10ms;
      realtime tburst_min_speedup = 80ns;
      realtime tburst_max_speedup = 100us;
   } u3_wakeup;
 -----/\----- EXCLUDED -----/\----- */
   
   // internal variables
   realtime t_transition, t_rising_last, t_start_lfps, t_start_electrical_idle;
   realtime duration_high, duration_lfps, duration_electrical_idle;
   realtime period, period_temp;   
   real     duty_cycle;
   bit      first_rising = 1;
   bit      period_valid, duty_cycle_valid;
   enum     {inactive, other, electrical_idle, detect, lfps_stable} state = inactive;
   bit      pipe_lfps_nodeltacycles, pipe_lfps_noglitch,pipe_lfps_noglitch_v1;
   bit      active_i;
   // same as state but single bit to ease Specman control
   bit      state_other, state_electrical_idle, state_detect, state_lfps_stable; 

   event    active_initial_e; // used to activate the monitor automatically from start
   //event   timeout_lfps_e; // timeout event when tx_m/m are killed during LFPS
   event    lfps_period_event;
   
   //---------------------------------------------
   // control activation/deactivation of monitor
   //---------------------------------------------
   generate 
      if (START_AUTOMATICALLY) begin: start_g
         // automatically activate monitor on startup
         initial begin
            #1; // wait 1ps so that event is catched
            -> active_initial_e;
            active = 1;
         end
      end
   endgenerate

   // gate the internal active to ignore compliance patterns generated by pipe_tx_ones_zeros that 
   // are similar to LFPS burst and to ignore when not in USB
   bit tx_ones_zeros_ongoing;
   always@(posedge pipe_tx_ones_zeros) begin
      if(pipe_powerdown == P0) begin
         // keep tx_ones_zeros_ongoing asserted for the few remaining cycles after pipe_tx_ones_zeros is deasserted to avoid detecting LFPS
         tx_ones_zeros_ongoing = 1;
      end
   end
   assign active_i = active && !(pipe_tx_ones_zeros && pipe_powerdown == P0) && phy_mode == USB3;
   
   always@(posedge active_i or active_initial_e) begin
      state = other;
      
      while (active_i) begin

         fork : LFPS_detect_f
            begin
               // active_i is disabled - stop all threads
               @(negedge active_i);
               state = inactive;
            end

/* -----\/----- EXCLUDED -----\/-----
             begin
             // stop LFPS detection when TX output is dead
             @(timeout_lfps_e); 
             state = other;
       end
 -----/\----- EXCLUDED -----/\----- */
            
            begin
               // any transition on tx
               @(tx_m or tx_p);
               t_transition = $realtime;

/* -----\/----- EXCLUDED -----\/-----
                // start timeout in case no more transition are detected on tx_m/m
                disable timeout_lfps_f; // kill previous timeout  
                fork : timeout_lfps_f
                begin
                #110e3; // timeout is 110 ns; just a bit more than max period for LFPS
                -> timeout_lfps_e;
        end
          join_none : timeout_lfps_f; // run timeout in background   
 -----/\----- EXCLUDED -----/\----- */

               
               // initialize some variables
               period_valid = 0;
               duty_cycle_valid = 0;


               // electrical idle
//               if ((tx_m === 1'b0 && tx_p === 1'b0) || (tx_m === 1'bx && tx_p === 1'bx)) begin
               if ((tx_m === 1'b0 && tx_p === 1'b0) || (tx_m === 1'bz && tx_p === 1'bz)) begin
                  if (state == lfps_stable) 
                    duration_lfps = t_transition - t_start_lfps;

                  else if (tx_ones_zeros_ongoing)
                    // terminate a tx_ones_zeros once in electrical idle only
                    tx_ones_zeros_ongoing = 0;
                  
                  state = electrical_idle;
                  t_start_electrical_idle = t_transition;
                  duration_electrical_idle = 0;
               end

               else if (!tx_ones_zeros_ongoing) begin

                  // ending electrical idle state - calculate duration
                  if (state == electrical_idle) begin
                     duration_electrical_idle = t_transition - t_start_electrical_idle;
                  end 
                  
                  // LFPS burst 
                  if (tx_m != tx_p) begin
                     // tx_m = 0 with tx_p = 1 or vice-versa, no x or z allowed
                     // NOTE: for previous boolean expression, tx_m or tx_p being x or z will cause comparison 
                     // to return x or z. Then 0, x or z will all give FALSE. Only 1 will give TRUE.

                     // initializing when entering detect state
                     if (state != lfps_stable && state != detect) begin
                        first_rising = 1;
                        duration_lfps = 0;
                        duration_high = 0;
                        period = 0;
                        period_temp = 0;
                        duty_cycle = 0;
                        #1; // wait 1ps to avoid processing glitches occuring there
                     end

                     // rising edge (for period calculation)
                     if (tx_m) begin

                        // default to detect - to be overriden below when proper LFPS detected
                        state = detect;
                        
                        if (!first_rising) begin
                           period_temp = t_transition - t_rising_last;

                           // inside lfps_stable so now default to other unless LFPS period and duty-cycle specs are met
                           // going in detect state while in lfps_stable makes no sense and screws duration_lfps calculation
                           //state = other;  commented out this line to match LFPS monitor in Sierra
                           
                           // check period and duty-cycle are valid (otherwise enter detect state)
                           if (period_temp inside {[tPeriod_min:tPeriod_max]}) begin
                              period_valid = 1;
                              period = period_temp;

                              // check duty-cycle
                              duty_cycle = duration_high / period * 100;
                              if (duty_cycle inside {[duty_cycle_min:duty_cycle_max]}) begin
                                 duty_cycle_valid = 1;
                                 state = lfps_stable;
                               -> lfps_period_event ;
                              end
                           end
                        end
                        
                        else begin
                           first_rising = 0;
                        end
                        
                        // use last transition in detect state to calcultate LFPS duration
                        if (state == detect) begin
                           t_start_lfps = t_transition; 
                        end

                        t_rising_last = t_transition;
                     end
                     
                     // falling edge (for duty-cycle calculation)
                     else if (!first_rising)
                       duration_high = t_transition - t_rising_last;

                     duration_lfps = t_transition - t_start_lfps;
                  end
                  
                  // no possible LFPS message ongoing (typically tx_m = 1, tx_n = 1 or combinations with x/z)
                  else begin
                     // ending LFPS stable state - calculate duration
                     if (state == lfps_stable) 
                       duration_lfps = t_transition - t_start_lfps;

                     state = other;
                  end
               end 
            end

         join_any : LFPS_detect_f;
         disable fork; // kill all threads when not active
         
      end
   end // always@ (posedge active)

   // single-bit signals to mimic state. Might be easier to track from external Specman TB
   assign state_inactive        = (state == inactive)        ? 1:0;
   assign state_other           = (state == other)           ? 1:0;
   assign state_detect          = (state == detect)          ? 1:0;
   assign state_lfps_stable     = (state == lfps_stable)     ? 1:0;
   assign state_electrical_idle = (state == electrical_idle) ? 1:0;


   //---------------------------------------------
   // power state monitor
   // NOTE: LFPS does not follow latencies and distortion constraints when changing to/from P3.
   //       Detect transitions to and from P3 since that changes the latency and increases 
   //       distortion that fails checker. Anyways, P3 transitions are not supported officially.
   //---------------------------------------------
   bit P3_transition_ongoing;
   bit P3_transition_detected;
   always@(pipe_powerdown) begin
//      if ($changed(pipe_powerdown, @(negedge `TB.sva_clk))) begin // must specify clocking event here!
//	 if (pipe_powerdown == P3 || $past(pipe_powerdown) == P3) begin
     if (pipe_powerdown == P3 || $past(pipe_powerdown,1,,@(posedge `TB.sva_clk)) == P3) begin
        P3_transition_ongoing = 1;
	    P3_transition_detected = 1;
	    @(negedge pipe_phy_status);
	    P3_transition_ongoing = 0;
//	 end
      end
   end

   always@(posedge pipe_lfps_noglitch) begin
      // reinit to no P3 transition detected for current LFPS ongoing
      if (!P3_transition_ongoing) begin
	 P3_transition_detected = 0;
      end
   end
   
//   bit still_transmitting_in_P3;
//   always @(pipe_powerdown)begin
//      if ($past(pipe_powerdown) == P3 and state == lfps_stable )begin
//         still_transmitting_in_P3 = 1;
//         #105;
//         still_transmitting_in_P3 = 0;
//      end
//   end
   

/* -----\/----- EXCLUDED -----\/-----
   bit P3_transition_detecting; // used to avoid cancelling a P3 transition just detected upon entering LPFS
   always@(negedge pipe_clk) begin
      if ($changed(pipe_powerdown, @(negedge pipe_clk))) begin // must specify clocking event here!
	 if (pipe_powerdown == P3) begin
	    P3_transition_detecting = 1;
	    repeat(2) @(pipe_clk);
	    P3_transition_detected = 1;
	 end

	 else if ($past(pipe_powerdown) == P3) begin
	    P3_transition_detecting = 1;
	    repeat(6) @(pipe_clk);
	    P3_transition_detected = 1;
	 end
	 P3_transition_detecting = 0;
      end
   end
   
   always@(posedge pipe_lfps_noglitch) begin
      // reinit to no P3 transition detected for current LFPS ongoing
      if (!P3_transition_detecting) begin
	 P3_transition_detected = 0;
      end
   end

   // disable assertions during first cycles of pipe_clk when it restarts upon leaving P3
   shortint cnt_pipe_clk;
   bit      pipe_clk_restarting;
   always@(posedge pipe_clk) begin
      pipe_clk_restarting = 0;
      if (pipe_powerdown == P3) begin
         cnt_pipe_clk <= 0;
      end
      else if (cnt_pipe_clk < 10) begin
         cnt_pipe_clk++;
         pipe_clk_restarting = 1;
      end
   end
 -----/\----- EXCLUDED -----/\----- */

   //---------------------------------------------
   // general settings for assertions/coverage
   //---------------------------------------------
   default clocking master_clk @(negedge (`TB.sva_clk));
   endclocking
   
   default disable iff (phy_reset_n !== 1'b1 || !error_en || !active_i || P3_transition_ongoing);

   function realtime abs_realtime (realtime num); 
      abs_realtime = (num <0) ? -num : num;
   endfunction // abs_realtime
   

   //---------------------------------------------
   // assertions/coverage
   //---------------------------------------------

   // PIPE LFPS control regardless of power state
   bit pipe_lfps;
   assign pipe_lfps = (pipe_powerdown == P0) ? (pipe_tx_det_rx_lpbk && pipe_tx_elec_idle) : (!pipe_tx_elec_idle);

   // inertial delay to suppress glitches that may be present on pipe_lfps on P0 power state transitions
   always @(pipe_lfps) begin
      #1 pipe_lfps_nodeltacycles = pipe_lfps && !tx_ones_zeros_ongoing; // filter delta-cycle with 1ps delay
   end
   
`ifdef GATE_LEVEL
   always @(pipe_lfps_nodeltacycles) begin
      #1000 pipe_lfps_noglitch = pipe_lfps_nodeltacycles; // filter glitches caused by propagation delays in gatesim
   end
`else
   assign pipe_lfps_noglitch = pipe_lfps_nodeltacycles;
`endif

   // add resync delays if present in PCS version (no resync in v0, resync in v1)
   bit pipe_lfps_clean; // signal used by internal logic after all resync (v1 only)

   generate
      if (PCS_VERSION == 1) begin: pcs_g1
         // PCS v1 where resync has been added on PIPE LFPS controls

         always@(pipe_lfps_noglitch) begin
            if (pipe_powerdown == P3) begin
	       // P3: PIPE control signals resync on refclk(x4)
	       repeat(2)@(posedge pma_refclk);
	       if ($changed(pipe_powerdown,@(posedge pma_refclk)))
	         // when pipe_powerdown changes the cycle after a change of PIPE LFPS commands, resync takes an additional cycle to complete
	         @(posedge pma_refclk);
	       repeat(3)@(posedge pma_refclk);
            end
            else begin
	       // P0/P1/P2: PIPE control signals are sampled on pipe_clk(x1), then resync on tx_td_clk(x2)
	       @(posedge pipe_clk);
	       repeat(2)@(posedge tx_td_clk);
            end
            pipe_lfps_clean = pipe_lfps_noglitch;
         end

         // PIPE LFPS latency caused by PCS 
         property pipe_lfps_start_p3_p;
            @(posedge pma_refclk)
              pipe_powerdown_pcs == P3 && $rose(pipe_lfps_noglitch_v1) |-> ##[13:27] $rose(pipe_lfps_clean);
         endproperty
         pipe_lfps_start_p3_a: assert property(pipe_lfps_start_p3_p);
         pipe_lfps_start_p3_c: cover  property(pipe_lfps_start_p3_p);

         property pipe_lfps_stop_p3_p;
            @(posedge pma_refclk)
              pipe_powerdown_pcs == P3 && $fell(pipe_lfps_noglitch_v1) |-> ##[13:27] $fell(pipe_lfps_clean);
         endproperty
         pipe_lfps_stop_p3_a: assert property(pipe_lfps_stop_p3_p);
         pipe_lfps_stop_p3_c: cover  property(pipe_lfps_stop_p3_p);

         property pipe_lfps_start_p0p1p2_p;
            @(posedge tx_td_clk)
              pipe_powerdown_pcs != P3 && $rose(pipe_lfps_noglitch_v1) |-> $rose(pipe_lfps_clean);
         endproperty
         pipe_lfps_start_p0p1p2_a: assert property(pipe_lfps_start_p0p1p2_p);
         pipe_lfps_start_p0p1p2_c: cover  property(pipe_lfps_start_p0p1p2_p);

         property pipe_lfps_stop_p0p1p2_p;
            @(posedge tx_td_clk)
              pipe_powerdown_pcs != P3 && $fell(pipe_lfps_noglitch_v1) |-> $fell(pipe_lfps_clean);
         endproperty
         pipe_lfps_stop_p0p1p2_a: assert property(pipe_lfps_stop_p0p1p2_p);
         pipe_lfps_stop_p0p1p2_c: cover  property(pipe_lfps_stop_p0p1p2_p);

         // PIPE powerdown latency caused by PCS
         property pipe_powerdown_pcs_p;
            @(posedge pma_refclk)
              $changed(pipe_powerdown) |-> ##[9:34] $changed(pipe_powerdown_pcs);
         endproperty
         pipe_powerdown_pcs_a: assert property(pipe_powerdown_pcs_p);
         pipe_powerdown_pcs_c: cover  property(pipe_powerdown_pcs_p);

      end 
      else begin
         // PCS v0 where no resyc of PIPE LFPS controls was done
         assign pipe_lfps_clean = pipe_lfps_noglitch;
      end // block: pcs_g1
   endgenerate
   
   // measure durations
   realtime pipe_lfps_start, duration_pipe_lfps;
   always @(pipe_lfps_clean) begin
      if (pipe_lfps_clean) begin
         pipe_lfps_start = $realtime;
         duration_pipe_lfps = 0ns;
      end 
      else begin
         duration_pipe_lfps = $realtime - pipe_lfps_start;
      end
   end

    //measure pipe lfps start latency
    always @(posedge state_lfps_stable) begin
        lfps_start_latency = t_start_lfps - pipe_lfps_start;
    end


   // signal asserted while the min 2-cycle LFPS is ongoing
   bit lfps_2_cycles_ongoing;
   always@(posedge pipe_lfps_clean) begin
      lfps_2_cycles_ongoing = 1;

      while (state != lfps_stable) begin
         @(state); #1; // wait 1ps after each event to avoid glitches
      end
      
      @(tx_m); #1;
      @(tx_m or tx_p); #1;

      lfps_2_cycles_ongoing = 0;
   end
 

//LFPS period assertion
   property lfps_period_p;
     @(`TB.sva_clk)
       ($past(state) == lfps_stable) && (state == electrical_idle) |-> ##2 ( period inside {[tPeriod_min_exp : tPeriod_max_exp]}) ;
   endproperty
   lfps_period_a: assert property(lfps_period_p);
   lfps_period_c: cover  property(lfps_period_p);


//LFPS duty assertion
   property lfps_duty_p;
     @(`TB.sva_clk)
       ($past(state) == lfps_stable) && (state == electrical_idle) |-> ##2 (duty_cycle inside {[duty_cycle_min_exp : duty_cycle_max_exp]}) ;
   endproperty
   lfps_duty_a: assert property(lfps_duty_p);
   lfps_duty_c: cover  property(lfps_duty_p);


/* Enable this assertion after DUT is ready
// LFPS start latency
   property pipe_lfps_start_latency_p;
     @(`TB.sva_clk)
       ($past(state) == lfps_stable) && (state == electrical_idle) |-> ##2 (lfps_start_latency inside {[lfps_start_latency_min_exp :lfps_start_latency_max_exp ]}) ;
   endproperty
   pipe_lfps_start_latency_a: assert property(pipe_lfps_start_latency_p);
   pipe_lfps_start_latency_c: cover  property(pipe_lfps_start_latency_p);
*/

  
//numbers of LFPS cycles
// 2 complete LFPS cycles at least
    always @(posedge state_electrical_idle) begin
     lfps_cycles_num = int'($floor(duration_lfps / period)); //Round down 10/3=3
    end


   property lfps_cycles_num_p;
     @(`TB.sva_clk)
       ($past(state) == lfps_stable) && (state == electrical_idle) |-> ##2 (lfps_cycles_num >= lfps_cycles_num_min_exp) ;
   endproperty
   lfps_cycles_num_a: assert property( lfps_cycles_num_p);
   lfps_cycles_num_c: cover  property( lfps_cycles_num_p);


//cover DP silence constraint
   property dp_tsilence_constraint_p;
     @(`TB.sva_clk)
       ($past(state) == electrical_idle) && (state == detect) && (phy_mode == DP) |-> ##2 (duration_electrical_idle inside {[tSilence_min_exp : tSilence_max_exp]}) ;
   endproperty
   dp_tsilence_constraint_a: assert property(dp_tsilence_constraint_p );
   dp_tsilence_constraint_c: cover  property(dp_tsilence_constraint_p );

//cover USB4 predata constraint
   property u4_tpredata_constraint_p;
     @(`TB.sva_clk)
       ($past(state) == electrical_idle) && (state == detect) && (phy_mode == USB4) |-> ##2 (duration_electrical_idle inside {[tPeriod_min_exp : tPeriod_max_exp]}) ;
   endproperty
    u4_tpredata_constraint_a: assert property(u4_tpredata_constraint_p );
    u4_tpredata_constraint_c: cover  property(u4_tpredata_constraint_p );

//  hink unreasonable and give it up --zzx 
  /* 
   // a long LFPS stopping must be preceded by end of LPFS PIPE command
   property lfps_stable_p;
      (state == lfps_stable) [*2:$] ##1 $changed(state) |-> !pipe_lfps_clean || !$past(pipe_lfps_clean,1) || !$past(pipe_lfps_clean,2);
   endproperty
   lfps_stable_a: assert property(lfps_stable_p); 
   property lfps_stable_gen2_p;
      (state == lfps_stable) && (phy_rate == GEN2) [*2:$] ##1 $changed(state) |-> !pipe_lfps_clean || !$past(pipe_lfps_clean,1) || !$past(pipe_lfps_clean,2);
   endproperty
   lfps_stable_gen2_a: assert property(lfps_stable_gen2_p); 

   // electrical idle (or data) occurs long after 2 LFPS cycles have completed
   property elec_idle_start_p1;
      $fell(pipe_lfps_clean) && !lfps_2_cycles_ongoing && (pipe_powerdown != P3)|-> ##[1:27] state != lfps_stable;
   endproperty
   elec_idle_start_a1: assert property(elec_idle_start_p1);      
   elec_idle_start_c1: cover  property(elec_idle_start_p1);      

   // electrical idle (or data) occurs during the 2 LFPS cycles are ongoing in P0 P1 P2
   property elec_idle_start_p2;
      $fell(pipe_lfps_clean) && lfps_2_cycles_ongoing ##[1:83] !lfps_2_cycles_ongoing && (pipe_powerdown != P3) && !pipe_lfps_clean |-> ##[1:27] state != lfps_stable;
   endproperty
   elec_idle_start_a2: assert property(elec_idle_start_p2);      
   elec_idle_start_c2: cover  property(elec_idle_start_p2);      
   // electrical idle (or data) occurs during the 2 LFPS cycles are ongoing in P3
   property elec_idle_start_p3;
      $fell(pipe_lfps_clean) && lfps_2_cycles_ongoing ##[1:83] !lfps_2_cycles_ongoing && (pipe_powerdown == P3) |-> ##[1:250] state != lfps_stable;
   endproperty
   elec_idle_start_a3: assert property(elec_idle_start_p3);      

   // data is starting within less than 20ns after LFPS complete
   // JLH - the verification environment cannot drive tx_det_rx_lpbk and tx_elec_idle low in the same cycle
   //       to terminate the LFPS. Thus it will be diffult to always meet the 20ns. Increasing to 24ns.
   property delay_lfps_to_data_p;
      @(`TB.sva_clk)
        $past(state) == lfps_stable && state == electrical_idle && pipe_tx_data_valid && !pipe_tx_elec_idle |-> ##[0:24] state == detect;
   endproperty
   delay_lfps_to_data_a: assert property(delay_lfps_to_data_p);
   delay_lfps_to_data_c: cover  property(delay_lfps_to_data_p);

//not have tx_elec_idle & tx_det_rx_lpbk signals,temporarily comment out this assertion --- zzx 20250902
/*    
   always@(negedge state_lfps_stable) begin

      // discard distortion check when P3 transition occured during LFPS ending, do not discard for PCS v1
      if (!(PCS_VERSION != 1 && P3_transition_detected)) begin
         #1; // settle time for duration counters
         if (duration_pipe_lfps < 110ns) begin
            if(pipe_powerdown != P3) begin
              if (active_i) begin // Disabling checker as required data for checker is not updated properly while active_i is low. 
                distortion_polling_allowed_a: assert #0
//                  (((duration_lfps) > 32ns) && ((duration_lfps) < 130ns));
//KDTSER-1434: The distortion_polling can be relaxed to 131ns to fix HLM's inaccuracy
                  (((duration_lfps) > 32ns) && ((duration_lfps) < 131ns));
              end
            end
         end
         else if (duration_pipe_lfps > (2*period)) begin // ignore cases where PIPE LFPS command is shorted than min 2-cycle TX LFPS
            if(pipe_powerdown != P3) begin
              if (active_i) begin // Disabling checker as required data for checker is not updated properly while active_i is low. 
                distortion_allowed_a: assert #0
                  (abs_realtime(duration_lfps - duration_pipe_lfps) <= TOLERANCE_DISTORTION);
              end
            end
            else begin
               distortion_allowed_p3_a: assert #0 (abs_realtime(duration_lfps - duration_pipe_lfps) <= TOLERANCE_DISTORTION_P3);
            end
         end
      end
   end

*/

/* Think unreasonable and give it up --zzx
   // LFPS to data transition covered
   property lfps_data_transition_p;
      $fell(pipe_lfps_clean) && state == lfps_stable |-> ##[2:20] state == detect;
   endproperty
   lfps_data_transition_c: cover property(lfps_data_transition_p);

   // data to LFPS transition covered
   property data_lfps_transition_p;
      $rose(pipe_lfps_clean) && state == detect |-> ##[40:54] state == lfps_stable;
   endproperty
   data_lfps_transition_c: cover property(data_lfps_transition_p);
   

*/
   covergroup lfps_states_cg @(negedge pma_refclk);
      option.name = "cg for TX LFPS";
      option.per_instance = 1;

      lfps_gen2_c: coverpoint phy_rate {
          bins Gen2 = {GEN2};
      }

      power_state_c: coverpoint pipe_powerdown {
         bins state_b[] = {[0:3]};                        
      }

      tx_state_c: coverpoint state {
         bins lfps_b[] = {lfps_stable,electrical_idle};
      }  

      // ensure to cover all combinations of LFPS/elec_idle vs power states
      cross_tx_state_power_state_c: cross tx_state_c, power_state_c;

      // ensure to cover start and stop of LFPS
      tx_state_trans_c: coverpoint state {
         bins trans_lfps_stop_b = (lfps_stable => electrical_idle);
         bins trans_lfps_start_b = (detect => lfps_stable);
      }

      // ensure to cover all combinations of LFPS <=> elec_idle transitions vs power states
      cross_tx_state_trans_power_state_c: cross tx_state_trans_c, power_state_c;

      // ensure to cover all valid power states transitions (P0, P1, P2 and P3) during LFPS
      power_state_trans_lfps_c: coverpoint pipe_powerdown {
         bins trans_b[] = (0,1,2,3 => 0,1,2,3) iff(state == lfps_stable);
         ignore_bins ignore_trans_b = (0 => 3),(1 => 3),(2 => 1,3),(3 => 0,1,2);
      }

      // ensure to cover min LFPS duration and all message durations
      duration_pipe_lfps_c: coverpoint $rtoi(duration_pipe_lfps/1ns) iff(state == lfps_stable) {
         bins min_b = {[40:43]}; // scale numbers to current timescale
         bins more_b = {[44:120_000_000]};
      }

      // ensure to have minimum duration LFPS in all power states
      cross_duration_pipe_lfps_power_state_c: cross duration_pipe_lfps_c, power_state_c;

      ping_c: coverpoint $rtoi(duration_lfps/1ns) iff(state == electrical_idle) {
         bins ping_b = {[40:200]}; // scale numbers to current timescale
      }
      ping_gen2_c : cross ping_c, lfps_gen2_c;

      // ensure to have ping LFPS in all valid power states
      cross_ping_power_state_c: cross ping_c, power_state_c {
         bins state_b = binsof(power_state_c) intersect {[0:1]};
      }

      polling_c: coverpoint $rtoi(duration_lfps/1ns) iff(state == electrical_idle) {
         bins polling_b = {[600:1400]}; // scale numbers to current timescale
      }
      polling_gen2_c : cross polling_c, lfps_gen2_c;

      // ensure to have polling LFPS in all valid power states
      cross_polling_power_state_c: cross polling_c, power_state_c {
         bins state_b = binsof(power_state_c) intersect {0};
      }

      tburst_c: coverpoint $rtoi(duration_lfps/1ns) iff(state == electrical_idle) {
          bins t40ns_200ns = {[40:200]};
          bins t201ns_1400ns = {[201:1400]};
          bins t1401ns_1ms = {[1401:1_000_000]};
      }

      tburst_gen2_c : cross tburst_c, lfps_gen2_c;

      treset_c: coverpoint $rtoi(duration_lfps/1ns) iff(state == electrical_idle) {
         bins treset_b = {[8_000:12_000]}; // scale numbers to current timescale -- changed bins for LFPS WARM reset 
      }
      treset_gen2_c : cross treset_c, lfps_gen2_c;

      // ensure to have treset LFPS in all valid power states
      cross_treset_power_state_c: cross treset_c, power_state_c;

      u1_exit_c: coverpoint $rtoi(duration_lfps/1ns) iff(state == electrical_idle) {
         bins u1_exit_b = {[300:2_000_000]}; // scale numbers to current timescale
      }
      u1_exit_gen2_c : cross u1_exit_c, lfps_gen2_c;

      // ensure to have U1_exit LFPS in all valid power states
      cross_u1_exit_power_state_c: cross u1_exit_c, power_state_c {
         bins state_b = binsof(power_state_c) intersect {0,2,3};
      }

      u2_lb_exit_c: coverpoint $rtoi(duration_lfps/1ns) {
         bins u2_lb_exit_b = {[80_000:2_000_000]}; // scale numbers to current timescale
      }
      u2_lb_exit_gen2_c : cross u2_lb_exit_c, lfps_gen2_c;

      // ensure to have U2_loopback_exit LFPS in all valid power states
      cross_u2_lb_exit_power_state_c: cross u2_lb_exit_c, power_state_c {
         bins state_b = binsof(power_state_c) intersect {1,3};
      }

      u3_wakeup_c: coverpoint $rtoi(duration_lfps/1ns) iff(state == electrical_idle) {
         bins u3_wakeup_b = {[80_000:10_000_000]}; // scale numbers to current timescale
      }
      u3_wakeup_gen2_c : cross u3_wakeup_c, lfps_gen2_c;

      // ensure to have U3_wakeup LFPS in all valid power states
      cross_u3_wakeup_power_state_c: cross u3_wakeup_c, power_state_c {
         bins state_b = binsof(power_state_c) intersect {0,1,2};
      }
      
      duration_electrical_idle_c: coverpoint $rtoi(duration_electrical_idle/1ns) iff(state == lfps_stable) {
         bins ping_b = {[1_000:2_000]}; // scale numbers to current timescale
         bins polling_b = {[6_000:14_000]}; // scale numbers to current timescale
      }
      
   endgroup // lfps_states_cg
   lfps_states_cg lfps_states_cg_i = new;



////////////////////////////////////////////////////////////////////////////////
////////////////////////////TX_ONES_ZEROS COVERAGE//////////////////////////////
   enum     {tx_inactive, tx_other, tx_electrical_idle, tx_detect, tx_ones_zeros_stable} state_tx = tx_inactive;
   assign active_tx_i = active && (pipe_tx_ones_zeros && pipe_powerdown == P0) && phy_mode == USB3;
   realtime duration_ones, duration_zeros;
   bit tx_first_rising, tx_first_falling;
   realtime tx_transition, tx_rising_last,tx_falling_last;
   reg [3:0] tx_cont;
   realtime tx_ones_zeros_tPeriod_min = 5ns; // 5ns with some tolerance for gates;
   realtime tx_ones_zeros_tPeriod_max = 500ns; // 500ns with some tolerance for gates;
   
   initial begin
   tx_cont = 0;
   end

   always@(posedge active_tx_i ) begin
      state_tx = tx_other;
      tx_cont = 0;
      while (active_tx_i) begin

         fork : Tx_ONES_ZEROS_detect_f
            begin
               // active_tx_i is disabled - stop all threads
               @(negedge active_tx_i);
               state_tx = tx_inactive;
            end

            
            begin
               // any transition on tx
               @(tx_m or tx_p);
               tx_transition = $realtime;
               if (tx_cont <= 5) //to make sure duration calculations are valid for ones and zeros
                  tx_cont = tx_cont + 1;
               // electrical idle
               if ((tx_m === 1'b0 && tx_p === 1'b0) || (tx_m === 1'bx && tx_m === 1'bx)) begin
                 
                  state_tx = tx_electrical_idle;
               end

                  // Tx ones zeros 
                  if (tx_m != tx_p) begin
                     // tx_m = 0 with tx_p = 1 or vice-versa, no x or z allowed
                     // NOTE: for previous boolean expression, tx_m or tx_p being x or z will cause comparison 
                     // to return x or z. Then 0, x or z will all give FALSE. Only 1 will give TRUE.

                     // initializing when entering detect state
                     if (state_tx != tx_ones_zeros_stable && state_tx != tx_detect) begin
                        tx_first_rising = 1;
                        tx_first_falling = 1;
                        duration_ones = 0;
                        duration_zeros = 0;
                        #1; // wait 1ps to avoid processing glitches occuring there
                     end

                     // rising edge (for tx Ones)
                     if (tx_m) begin

                        // default to detect - to be overriden below when proper tx_ones_zeros detected
                        state_tx = tx_detect;
                        if (!tx_first_falling) begin
                           duration_zeros = tx_transition - tx_falling_last;
                           // check duration for ones and zeros are valid (otherwise enter detect state)
                           if (duration_zeros inside {[tx_ones_zeros_tPeriod_min:tx_ones_zeros_tPeriod_max]}) begin
                              state_tx = tx_ones_zeros_stable ;
                           end
                        end
                        
                        if (tx_first_rising) begin
                           tx_first_rising = 0;
                        end
                        
                        tx_rising_last = tx_transition;
                     end
                     // falling edge (for tx Zeros)
                     else begin
                        
                        state_tx = tx_detect;
                        
                        if (!tx_first_rising) begin
                           duration_ones = tx_transition - tx_rising_last;
                           // check duration for ones and zeros are valid (otherwise enter detect state)
                           if (duration_ones inside {[tx_ones_zeros_tPeriod_min:tx_ones_zeros_tPeriod_max]}) begin
                              state_tx = tx_ones_zeros_stable ;
                           end
                        end

                        if (tx_first_falling) begin
                            tx_first_falling = 0;
                         end
                        
                        tx_falling_last = tx_transition;
 
                        if (tx_first_rising == 0 && tx_first_falling == 0 && tx_cont > 5 && active_tx_i) begin
                            //check duration_zeros is equal to duration_ones are same
                           tx_ones_zreos_distortion : assert #0 (abs_realtime(duration_ones - duration_zeros) <= 5ps);
                        end
                  end
               end 
            end

         join_any : Tx_ONES_ZEROS_detect_f;
         disable fork; // kill all threads when not active
         
      end
   end // always@ (posedge active_tx_i)

   // coverage for tx_ones_zeros
   property tx_ones_zeros_p;
   disable iff (phy_reset_n !== 1'b1  || !active_tx_i) $rose(pipe_tx_ones_zeros) && (pipe_powerdown == P0) && phy_mode == USB3 |-> ##[1:250] state_tx == detect ##[9:54] (state_tx == tx_ones_zeros_stable);
   endproperty
   
   tx_ones_zeros_c : cover property(tx_ones_zeros_p);

endmodule   
