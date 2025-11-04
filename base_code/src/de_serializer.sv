//-----------------------------------------------------------------------------
//    This confidential and proprietary HDL soft description of a Hardware
//    component may be used only as authorized by a licensing agreement from
//    Cadence. In the event of publication, the following notice
//    is applicable:
//
//                   (C) COPYRIGHT 2013-2015 Cadence
//                         ALL RIGHTS RESERVED
//
//     The entire notice above must be reproduced on all authorized
//     copies of this code.
//-----------------------------------------------------------------------------
// File URL       : $URL: http://chsvn:25001/svn/sim_digital/uvc_libs/sd_serial_lane_v2_ivc/branches/SIERRA7NM_2016_2911/hdl/sd_deserializer_lock.sv $
// Version        : $Revision: 5322 $
// Last Changed   : $LastChangedBy: afortin $
//                : $LastChangedDate: 2017-09-27 20:49:12 -0400 (Wed, 27 Sep 2017) $
//-----------------------------------------------------------------------------
`timescale 1ps/100fs

interface sd_deserializer_lock(
   input [3:0]      gen_mode,
   input [7:0]      protocol,
   input            align_bypass,
   input            rx_p,
   input            rx_m,
   input            input_sample_clk,
   input            use_input_sample_clk,
   input            use_v0_5_eieos,             // SER-7099, if set, GEN4 v.07 EIEOS pattern is used 
                                                // Otherwise GEN4 v.05 EIEOS pattern is used
   input            ccix_edr,         // 0 CCIX Not enable;  1 CCIX Extended Data Rate is enabled over PCIe
   input            ccix_esm_0,       // 0=8G,  1=16G
   input            ccix_esm_1,       // 0=20G, 1=25G
			    
   output reg       data_z,
   output reg       data_cmn,
   output [3:0]     valid_bits_p,
   output [3:0]     valid_bits_m,
   output reg [9:0] dout,
   output reg       clk_out,
   output reg       dvalid
   );

   // {GEN_MODE, PROTOCOL}
   parameter [11:0] PCIe_GEN1 = 12'h0_00;
   parameter [11:0] PCIe_GEN2 = 12'h1_00;
   parameter [11:0] PCIe_GEN3 = 12'h2_00;
   parameter [11:0] PCIe_GEN4 = 12'h3_00;

   parameter [11:0] USB3_GEN1 = 12'h0_01;
   parameter [11:0] USB3_GEN2 = 12'h1_01;

   parameter [11:0] SATA_GEN1 = 12'h0_02;
   parameter [11:0] SATA_GEN2 = 12'h1_02;
   parameter [11:0] SATA_GEN3 = 12'h2_02;

   parameter [11:0] KR10G     = 12'h0_04;

   parameter [11:0] GE1       = 12'h0_14;
   parameter [11:0] XAUI      = 12'h0_10;
   parameter [11:0] RXAUI     = 12'h0_0C;

   parameter [11:0] DP_RBR    = 12'h0_05;
   parameter [11:0] DP_HBR    = 12'h1_05;
   parameter [11:0] DP_HBR2   = 12'h2_05;
   parameter [11:0] HDMI     = 12'h0_09;

   parameter [11:0] eDP_RATE1   = 12'h3_05;
   parameter [11:0] eDP_RATE2   = 12'h4_05;
   parameter [11:0] eDP_RATE3   = 12'h5_05;
   parameter [11:0] eDP_RATE4   = 12'h6_05;
   parameter [11:0] eDP_RATE5   = 12'h7_05;
   parameter [11:0] eDP_RATE6   = 12'h8_05;
   parameter [11:0] eDP_RATE7   = 12'h9_05;
   parameter [11:0] HDMI_RATE  = 12'hB_05;

   // Bit time
   real           clk_period = 200;
   real           period_candidate;
   real           clk_period_avg;
   real           clk_period_min, clk_period_max;
   real           eios_timestamp = 0;
   real           serial_cmn_timestamp = 0;

   // Events
   event          start_sample_clk;
   event          stop_sample_clk;
   event          data_vld;
   event          new_gen_mode;

   event          serial_status_e;
   event          eios_detected_e;
   event          eieos_detected_e;
   event          com_or_eieos_detected_e;
   event          clr_lock_e;

   // Internal signals
   logic [15:0]   bit_cnt          = 9;
   logic [15:0]   bit_sel          = 9;
   logic          eios_detected    = 0;
   logic          eios_detected_14sym = 0; // 14-symbol EIOS Minimum symbols required to be transmitted if last EIOS
   logic          eios_detected_15sym = 0; // 15-symbol EIOS
   logic          eios_detected_16sym = 0; // 16-symbol EIOS 16 symbols must be transmitted if not last EIOS
   logic          block_found      = 0;
   logic          data_to_z        = 0;
   logic          data_to_cmn      = 0;

   logic          serial_x         = 0;
   logic          serial_z         = 0;
   logic          serial_cmn       = 1;
   logic          serial_data      = 0;
   logic          prev_serial_x    = 0;
   logic          prev_serial_z    = 0;
   logic          prev_serial_cmn  = 1;
   logic          prev_serial_data = 0;


   logic          sample_clk_gen   = 0;
   logic [3:0]    dvalid_bits      = 10;
   logic          rx_m_active;
   logic [132:0]  shift_reg;
   logic [160:0]  block_shift_reg;
   logic [15:0]   shift_sel;

   logic [11:0]   gen_mode_protocol;

   logic [3:0]    usb3_1_header   = 0;
   logic [15:0]   block_boundary  = 131;
  
   // TODO: check
   logic [9:0]    dout_d1         = 0;
   logic [15:0]   skp_bit_cnt     = 0;
   byte           skp_sym_cnt     = 0;
   logic          skp_in_control  = 0;
   logic          skp_enable      = 0;
   bit            skp_end_ctl, skp_end_ctl_last;
   event          skp_end_detected_e;

   // Raw interface support
   logic          use_raw_mode = 0;
   logic          encoder_bypass_mode = 1;


   bit            beacon_pending;
   event          beacon_detected;
   event          becon_gone_way;


   // CCIX stuff
   real 	  ccix_esm_0_period = 62.5;  // 16 G
   real 	  ccix_esm_1_period = 50.0;  // 20 G

   always@(*) begin
      ccix_esm_0_period = (ccix_esm_0) ? 62.5    : 125 ;
      ccix_esm_1_period = (ccix_esm_1) ? 40      :  50 ;
   end
   
   
   
   // Basic Assignments
   assign gen_mode_protocol = {gen_mode, protocol};
   assign sample_clk = use_input_sample_clk === 1'b1 ? input_sample_clk : sample_clk_gen;

   assign valid_bits_p = dvalid_bits;
   assign valid_bits_m = dvalid_bits;


   // Initialize the internal / external signals
   initial begin
      clk_out          = 0;
      dout             = 0;
      dout_d1          = 0;
      dvalid           = 0;
      dvalid_bits      = 10;
      sample_clk_gen   = 0;

      #1ns;
      serial_x         = rx_p === 1'bx;
      serial_z         = rx_p === 1'bz;
      serial_cmn       = !(serial_x || serial_z) && (rx_p === rx_m);
      serial_data      = !(serial_x || serial_z || serial_cmn);

      prev_serial_x    = serial_x;
      prev_serial_z    = serial_z;
      prev_serial_cmn  = serial_cmn;
      prev_serial_data = serial_data;

      -> new_gen_mode;
   end

   // with the master condition in the while loop, had to add #0
   // or it would not work even though master is tied off in the instantiation
   realtime t_last_trans;
   initial begin
      #1ns;
      while (1) begin
         // do not change clock on change to high-z. The high-z change is
         // asynchronous to the serial data bit change
         @(rx_p);

         if (serial_data) begin
            // realign sample clk edge with data
            -> stop_sample_clk;
            // avoid simultaneous start/stop screwing threads
            -> start_sample_clk;
         end
         else begin
            -> stop_sample_clk;
            -> start_sample_clk; // adding this to keep generation the clock even in IDLE 
                                 // When going in IDLE the tx drv model has a random value in tx_p and tx_m 
                                 // this may result in a difference in to lanes shift registers, we could either 
                                 // 1- keep stopping the clock but reset the shift register or 
                                 // 2- keep running the clocks even in idle and shift z an x in the shisft register
                                 // second option seemed simpler...
            data_z   = rx_p === 1'bz;
            data_cmn = (rx_p !== 1'bz) && (rx_p === rx_m);
            // If not Data Valid then push the correct status into the shift reg
            if(!dvalid) begin
              if(data_z) begin
                shift_reg[0] = 1'bz;
              end
              if(data_cmn) begin
                shift_reg[0] = 1'bx;
              end
            end
         end

         period_candidate = $realtime - t_last_trans; // delay between 2 consecutive transitions : is period if 1UI, discarted if >1UI
         
         if (period_candidate inside {[clk_period_min:clk_period_max]}) begin
            clk_period_avg = 0.99 * clk_period_avg + 0.01 * period_candidate; // period measured is added to average for more accurate freerunning clk
         end
         t_last_trans = $realtime;
    
         #1ps;
         `ifdef CDN_WREAL_ENABLE
            #10ps;
         `endif
         set_serial_status();
      end
   end

   // Fix for DP mode where com_or_eieos_detected_e event was not triggering for few data transfer cases.
   always @(serial_data)
   begin
      if(serial_data == 0)
      begin
         case(gen_mode_protocol)
           DP_RBR    : clr_lock();
           DP_HBR    : clr_lock();
           DP_HBR2   : clr_lock();
           eDP_RATE1 : clr_lock();
           eDP_RATE2 : clr_lock();
           eDP_RATE3 : clr_lock();
           eDP_RATE4 : clr_lock();
           eDP_RATE5 : clr_lock();
           eDP_RATE6 : clr_lock();
           eDP_RATE7 : clr_lock();
           HDMI_RATE : clr_lock();
         endcase

         `ifdef MP_128B_PATH
            `ifndef CDN_WREAL_ENABLE
               clr_lock();
            `endif
         `endif
      end
   end

   // On a protol or gen_mode update drive new_gen_mode
   always@(gen_mode_protocol) begin
      set_clk_period();
      set_bit_cnt();
      set_shift_sel();

      dvalid_bits = 10;

      -> stop_sample_clk;
      #1;
   end

   always@(new_gen_mode) begin
      set_clk_period();
      set_bit_cnt();
      set_shift_sel();

      dvalid_bits = 10;

      -> stop_sample_clk;
      #1;
   end

   // Only run on the posedge of rx_m_active
   //  IE first rx_m precedes first rx_p transaction
   always@(posedge rx_m_active) begin
      -> start_sample_clk;
      #1ps;
      `ifdef CDN_WREAL_ENABLE
         #10ps;
      `endif
      set_serial_status();
   end

   // Respond to data_z change - this is done if RX_P
   //  ends on a no change
   always@(posedge data_z) begin
      -> start_sample_clk;
      #1ps;
      `ifdef CDN_WREAL_ENABLE
         #10ps;
      `endif
      set_serial_status();
   end

   // Respond to data_cmn change - this is done if RX_P
   //  ends on a no change
   always@(posedge data_cmn) begin
      -> start_sample_clk;
      #1ps;
      `ifdef CDN_WREAL_ENABLE
         #10ps;
      `endif
      set_serial_status();
   end

   always@(start_sample_clk) begin
      #(clk_period_avg/2); // align rising edge in the middle of the UI

      fork
         begin: freerunning_thread
            forever begin
               sample_clk_gen = 1'b1;
               #(10); // 10ps
               sample_clk_gen = 1'b0;
               #(clk_period_avg - 10);
            end
         end
      join_none;
   end

   always@(stop_sample_clk) begin
      sample_clk_gen = 1'b0;
      disable freerunning_thread;
   end

   // Event to clear the block/comma lock
   always@(clr_lock_e) begin
      clr_lock();
   end

   initial begin
      data_z   = 1'b1;
      data_cmn = 1'b0;
   end

   always@(*) begin
      data_z   = shift_reg[0] === 1'bz;
      data_cmn = shift_reg[0] === 1'bx;
   end

   //rx_m_active only is allowed if rx_p isn't already active
   //  This covers the case when rx_m goes high to indicate a 0 before
   //  rx_p has transitioned
   assign rx_m_active = !serial_data && rx_m;


   assign serial_cmn_no_delay = rx_p === rx_m;

   //------------------------------------------------------------------
   //  Tasks for common-mode detection
   //------------------------------------------------------------------

   always @(posedge serial_cmn_no_delay) begin
      serial_cmn_timestamp = $time;
   end


   //------------------------------------------------------------------
   //  Tasks for deserialization
   //------------------------------------------------------------------

   // Lose comma/block lock on clr_lock command
   task clr_lock;
      begin
         dvalid          = 0;
         dvalid_bits     = 0;
         block_found     = 0;
         clk_out         = 0;
         for(int i = 1; i < 160; i = i + 1) begin
            if(i < 132) begin
               shift_reg[i]    = 1'bx;
            end
            block_shift_reg[i] = 1'bx;
         end
         if ((rx_p === rx_m) || (rx_p === 1'bz)) begin
            -> stop_sample_clk;
            -> start_sample_clk; // adding this to keep generation the clock even in IDLE 
                                 // See previous similar comment
         end

         set_bit_cnt();
      end
   endtask

   task set_clk_period();
      begin
         case(gen_mode_protocol)
            PCIe_GEN1 : clk_period = 400;
            PCIe_GEN2 : clk_period = 200;
            PCIe_GEN3 : clk_period = 125;
            PCIe_GEN4 : clk_period = 62.5;
            USB3_GEN1 : clk_period = 200;
            USB3_GEN2 : clk_period = 100;
            SATA_GEN1 : clk_period = 666.666;
            SATA_GEN2 : clk_period = 333.333;
            SATA_GEN3 : clk_period = 166.667;
            KR10G     : clk_period = 96.97;
            GE1       : clk_period = 800;
            XAUI      : clk_period = 320;
            RXAUI     : clk_period = 160;
            DP_RBR    : clk_period = 617.284;
            DP_HBR    : clk_period = 370.370;
            DP_HBR2   : clk_period = 185.185;
            HDMI      : clk_period = 166.667;
            eDP_RATE1 : clk_period = 617.284;
            eDP_RATE2 : clk_period = 462.963;
            eDP_RATE3 : clk_period = 411.523;
            eDP_RATE4 : clk_period = 370.370;
            eDP_RATE5 : clk_period = 308.642;
            eDP_RATE6 : clk_period = 231.481;
            eDP_RATE7 : clk_period = 185.185;
            `ifdef HDMI_RATE1 
               HDMI_RATE: clk_period = 2000;
            `endif
            `ifdef HDMI_RATE2 
               HDMI_RATE: clk_period = 1000;
            `endif
            `ifdef HDMI_RATE3 
               HDMI_RATE: clk_period = 166.667;
            `endif
            `ifdef HDMI_RATE4 
               HDMI_RATE: clk_period = 4210.526;
            `endif
            `ifdef HDMI_RATE5 
               HDMI_RATE: clk_period = 2105.263;
            `endif
            `ifdef HDMI_RATE6 
               HDMI_RATE: clk_period = 1052.632;
            `endif
            `ifdef HDMI_RATE7 
               HDMI_RATE: clk_period = 1307.19;
            `endif
            `ifdef HDMI_RATE8 
               HDMI_RATE: clk_period = 917.431;
            `endif
            `ifdef HDMI_RATE9 
               HDMI_RATE: clk_period = 458.716;
            `endif
            `ifdef HDMI_RATE10 
               HDMI_RATE: clk_period = 229.358;
            `endif
            `ifdef HDMI_RATE11 
               HDMI_RATE: clk_period = 578.035;
            `endif
            `ifdef HDMI_RATE12 
               HDMI_RATE: clk_period = 289.017;
            `endif
            `ifdef HDMI_RATE13 
               HDMI_RATE: clk_period = 372.44;
            `endif
            `ifdef HDMI_RATE14 
               HDMI_RATE: clk_period = 186.22;
            `endif
            `ifdef HDMI_RATE15 
               HDMI_RATE: clk_period = 187.529;
            `endif
            `ifdef HDMI_RATE16 
               HDMI_RATE: clk_period = 176.289;
            `endif
            default   : clk_period = 1000;
         endcase // case (gen_mode_protocol)

	 // CCIX
	 if (ccix_edr == 1 && gen_mode_protocol == PCIe_GEN3) begin
	    clk_period = ccix_esm_0_period;
	 end
	 if (ccix_edr == 1 && gen_mode_protocol == PCIe_GEN4) begin
	    clk_period = ccix_esm_1_period;	    
	 end
	 
	 
         clk_period_min = clk_period * 0.5;
         clk_period_max = clk_period * 1.5;
         clk_period_avg = clk_period;
      end
   endtask

   task set_bit_cnt();
      begin
         if (use_raw_mode) begin
            bit_cnt = 9;
            return;
         end
         case(gen_mode_protocol)
            PCIe_GEN1 : bit_cnt = 9;
            PCIe_GEN2 : bit_cnt = 9;
            PCIe_GEN3 : bit_cnt = 129;
            PCIe_GEN4 : bit_cnt = 129;
            USB3_GEN1 : bit_cnt = 9;
            USB3_GEN2 : bit_cnt = 131;
            SATA_GEN1 : bit_cnt = 9;
            SATA_GEN2 : bit_cnt = 9;
            SATA_GEN3 : bit_cnt = 9;
            KR10G     : bit_cnt = 9;
            GE1       : bit_cnt = 9;
            XAUI      : bit_cnt = 9;
            RXAUI     : bit_cnt = 9;
            DP_RBR    : bit_cnt = 9;
            DP_HBR    : bit_cnt = 9;
            DP_HBR2   : bit_cnt = 9;
            HDMI      : bit_cnt = 9;
            eDP_RATE1 : bit_cnt = 9;
            eDP_RATE2 : bit_cnt = 9;
            eDP_RATE3 : bit_cnt = 9;
            eDP_RATE4 : bit_cnt = 9;
            eDP_RATE5 : bit_cnt = 9;
            eDP_RATE6 : bit_cnt = 9;
            eDP_RATE7 : bit_cnt = 9;
            HDMI_RATE : bit_cnt = 9;
            default   : bit_cnt = 9;
         endcase
      end
   endtask

   task set_shift_sel();
      begin
         if (use_raw_mode) begin
            shift_sel = 10;
            return;
         end
         case(gen_mode_protocol)
           PCIe_GEN1 : shift_sel = 10;
           PCIe_GEN2 : shift_sel = 10;
           PCIe_GEN3 : shift_sel = 130;
           PCIe_GEN4 : shift_sel = 130;
           USB3_GEN1 : shift_sel = 10;
           USB3_GEN2 : shift_sel = 132;
           SATA_GEN1 : shift_sel = 40; // ALIGNp is composed of 4 8b/10b symbols
           SATA_GEN2 : shift_sel = 40; // ALIGNp is composed of 4 8b/10b symbols
           SATA_GEN3 : shift_sel = 40; // ALIGNp is composed of 4 8b/10b symbols
           DP_RBR    : shift_sel = 10;
           DP_HBR    : shift_sel = 10;
           DP_HBR2   : shift_sel = 10;
           KR10G     : shift_sel = 10;
           GE1       : shift_sel = 10;
           XAUI      : shift_sel = 10;
           RXAUI     : shift_sel = 10;
           eDP_RATE1 : shift_sel = 10;
           eDP_RATE2 : shift_sel = 10;
           eDP_RATE3 : shift_sel = 10;
           eDP_RATE4 : shift_sel = 10;
           eDP_RATE5 : shift_sel = 10;
           eDP_RATE6 : shift_sel = 10;
           eDP_RATE7 : shift_sel = 10;
           HDMI_RATE : shift_sel = 10;
           default   : shift_sel = 10;
         endcase
      end
   endtask

   task set_serial_status();
      begin
         serial_x    = rx_p === 1'bx;
         serial_z    = rx_p === 1'bz;
         serial_cmn  = !(serial_x || serial_z) && (rx_p === rx_m);
         serial_data = !(serial_x || serial_z || serial_cmn);

         if( (prev_serial_data != serial_data) |
             (prev_serial_cmn  != serial_cmn)  |
             (prev_serial_z    != serial_z)  |
             (prev_serial_x    != serial_x) ) begin
            #1ps;
            -> serial_status_e;
         end

         prev_serial_x    = serial_x;
         prev_serial_z    = serial_z;
         prev_serial_cmn  = serial_cmn;
         prev_serial_data = serial_data;
      end
   endtask

   task capture_raw_data_10b();
      begin
         // Word found every 10 clocks
         if(bit_cnt == 9) begin
            bit_cnt     = 0;
            dout        = shift_reg[9:0];
            dvalid_bits = 10;
            -> data_vld;
         end
         else begin
            bit_cnt = bit_cnt + 1;
         end

         // Toggle the clock on 0 count
         if(bit_cnt == 0 && (shift_reg[8] !== 1'bx)) begin
            clk_out = 1;
         end
         // Toggle the clock on 5 count
         else if(bit_cnt == 5) begin
            clk_out = 0;
         end
      end
   endtask

   task capture_raw_data_130b();
      begin
      end
   endtask
   task capture_raw_data_132b();
      begin
      end
   endtask


   task comma_alignment();
      begin
         // COMMA Found
         if(block_found || align_bypass === 1'b1) begin
            // Word found every 10 clocks
            if(bit_cnt == 9) begin
               bit_cnt     = 0;
               dout        = shift_reg[9:0];
               dvalid_bits = 10;
               -> data_vld;
            end
            else begin
               bit_cnt = bit_cnt + 1;
            end

            // Toggle the clock on 0 count
            if(bit_cnt == 0 && (shift_reg[8] !== 1'bx)) begin
               clk_out = 1;
            end
            // Toggle the clock on 5 count
            else if(bit_cnt == 5) begin
               clk_out = 0;
            end

            // Stop the process if LFPS is detected
            if(gen_mode_protocol inside {USB3_GEN1, PCIe_GEN1, PCIe_GEN2}) begin
               if(block_shift_reg[39:0] === 40'h00_0000_0000 ||
                  block_shift_reg[39:0] === 40'hFF_FFFF_FFFF) begin
                  clr_lock();
               end
            end
            else if(gen_mode_protocol inside {USB3_GEN2, PCIe_GEN3, PCIe_GEN4}) begin
               if(block_shift_reg[131:52] === 80'h00_0000_0000_00_0000_0000 ||
                  block_shift_reg[131:52] === 80'hFF_FFFF_FFFF_FF_FFFF_FFFF) begin
                  clr_lock();
               end
            end

            if(gen_mode_protocol == PCIe_GEN1) begin
               if (((block_shift_reg[39:30] === 10'h33C) || (block_shift_reg[39:30] === 10'h0C3)) &&  // IDL K28.3
                   ((block_shift_reg[29:20] === 10'h33C) || (block_shift_reg[29:20] === 10'h0C3)) &&  // IDL K28.3
                   ((block_shift_reg[19:10] === 10'h33C) || (block_shift_reg[19:10] === 10'h0C3)) &&  // IDL K28.3
                   ((block_shift_reg[ 9: 0] === 10'h17C) || (block_shift_reg[ 9: 0] === 10'h283))     // COMMA K28.5
                   ) begin
                  eios_detected  = 1'b1;
                  eios_timestamp = $time;
               end else begin
                  eios_detected  = 1'b0;
               end
            end

            if(gen_mode_protocol == PCIe_GEN2) begin
               // EIOS
               if (((block_shift_reg[159:150] === 10'h33C) || (block_shift_reg[159:150] === 10'h0C3)) &&  // IDL K28.3
                   ((block_shift_reg[149:140] === 10'h33C) || (block_shift_reg[149:140] === 10'h0C3)) &&  // IDL K28.3
                   ((block_shift_reg[139:130] === 10'h33C) || (block_shift_reg[139:130] === 10'h0C3)) &&  // IDL K28.3
                   ((block_shift_reg[129:120] === 10'h17C) || (block_shift_reg[129:120] === 10'h283))     // COMMA K28.5
                   ) begin
                  eios_detected  = 1'b1;
                  eios_timestamp = $time;
               end else begin
                  eios_detected  = 1'b0;
               end
               // EIEOS
               if (((block_shift_reg[159:150] === 10'h2AA) || (block_shift_reg[159:150] === 10'h155)) &&  // TS1 D10.2
                   ((block_shift_reg[149:140] === 10'h383) || (block_shift_reg[149:140] === 10'h07C)) &&  // EIE K28.7
                   ((block_shift_reg[139:130] === 10'h383) || (block_shift_reg[139:130] === 10'h07C)) &&  // EIE K28.7
                   ((block_shift_reg[129:120] === 10'h383) || (block_shift_reg[129:120] === 10'h07C)) &&  // EIE K28.7
                   ((block_shift_reg[119:110] === 10'h383) || (block_shift_reg[119:110] === 10'h07C)) &&  // EIE K28.7
                   ((block_shift_reg[109:100] === 10'h383) || (block_shift_reg[109:100] === 10'h07C)) &&  // EIE K28.7
                   ((block_shift_reg[ 99: 90] === 10'h383) || (block_shift_reg[ 99: 90] === 10'h07C)) &&  // EIE K28.7
                   ((block_shift_reg[ 89: 80] === 10'h383) || (block_shift_reg[ 89: 80] === 10'h07C)) &&  // EIE K28.7
                   ((block_shift_reg[ 79: 70] === 10'h383) || (block_shift_reg[ 79: 70] === 10'h07C)) &&  // EIE K28.7
                   ((block_shift_reg[ 69: 60] === 10'h383) || (block_shift_reg[ 69: 60] === 10'h07C)) &&  // EIE K28.7
                   ((block_shift_reg[ 59: 50] === 10'h383) || (block_shift_reg[ 59: 50] === 10'h07C)) &&  // EIE K28.7
                   ((block_shift_reg[ 49: 40] === 10'h383) || (block_shift_reg[ 49: 40] === 10'h07C)) &&  // EIE K28.7
                   ((block_shift_reg[ 39: 30] === 10'h383) || (block_shift_reg[ 39: 30] === 10'h07C)) &&  // EIE K28.7
                   ((block_shift_reg[ 29: 20] === 10'h383) || (block_shift_reg[ 29: 20] === 10'h07C)) &&  // EIE K28.7
                   ((block_shift_reg[ 19: 10] === 10'h383) || (block_shift_reg[ 19: 10] === 10'h07C)) &&  // EIE K28.7
                   ((block_shift_reg[  9:  0] === 10'h17C) || (block_shift_reg[  9:  0] === 10'h283))     // COMMA K28.5
                   ) begin
                  -> eieos_detected_e;
                  -> com_or_eieos_detected_e;
               end
            end
         end

         // SATA ALIGNp detect
         else if (gen_mode_protocol inside {SATA_GEN1,SATA_GEN2,SATA_GEN3}) begin
            if ((shift_reg[39:0] === {10'h0E4, 10'h2AA, 10'h2AA, 10'h17C} || 
                 shift_reg[39:0] === {10'h31B, 10'h2AA, 10'h2AA, 10'h283}) && (bit_cnt == 9)) begin // COMMA K28.5
               
               block_found = 1;
               bit_cnt     = 0;
               dout        = shift_reg[9:0];
               dvalid      = 1;
               dvalid_bits = 10;
               -> data_vld;
               -> com_or_eieos_detected_e;
            end
         end

         // COMMA Detect
         else if(((shift_reg[9:0] === 'h17C) || (shift_reg[9:0] === 'h283)) && (bit_cnt == 9)) begin // COMMA K28.5
            
            block_found = 1;
            bit_cnt     = 0;
            dout        = shift_reg[9:0];
            dvalid      = 1;
            dvalid_bits = 10;
            -> data_vld;
            -> com_or_eieos_detected_e;
         end
      end
   endtask


   task block_alignment_128_130();
      begin
         // Once the block is found then the following needs to be controlled
         //  1: Toggle the clock on 0, 1, cnt%8==0 and cnt%8==3
         // This process is NOT using a shift architecture.  This is because of
         //  the amount of latency that this would enter into the system.
         if(block_found) begin
            if(bit_cnt < 2) begin
               shift_sel = bit_cnt;
            end else begin
               shift_sel = (bit_cnt - 2) % 8;
            end
            shift_reg[shift_sel] = rx_p;


            if(shift_sel == 0) begin
               clk_out = 1;
            end
            else if(shift_sel == 1) begin
               clk_out = 0;
            end
            else if(shift_sel == 3) begin
               clk_out = 0;
            end

            if(bit_cnt == 1) begin
               dout        = shift_reg[1:0];
               dvalid_bits = 2;
               dvalid      = 1;
               -> data_vld;
            end
            else if((bit_cnt-2)%8==7) begin
               dout        = shift_reg[7:0];
               dvalid_bits = 8;
               -> data_vld;
            end


            if(bit_cnt == 129) begin
               bit_cnt = 0;
            end else begin
               bit_cnt += 1;
            end

            if (block_shift_reg[129:16]  === 114'h2_6666_6666_6666_6666_6666_6666_6666) begin // EIOS detect : at least 14 8'h66 symbols must be transmitted
               eios_detected  = 1'b1;
               eios_detected_14sym  = 1'b1;
               if (block_shift_reg[129:8]  === 122'h2_6666_6666_6666_6666_6666_6666_6666_66) begin
                  eios_detected_15sym  = 1'b1;
                  if (block_shift_reg[129:0]  === 130'h2_6666_6666_6666_6666_6666_6666_6666_6666) begin
                     eios_detected_16sym  = 1'b1;
                  end
               end
               eios_timestamp = $time;
            end
            else begin
               eios_detected  = 1'b0;
               eios_detected_14sym = 0;
               eios_detected_15sym = 0;
               eios_detected_16sym = 0;
            end
         end
         else begin
            bit_cnt   = 129;
            shift_sel = 129;
            shift_reg[128:0] = shift_reg[129:1];
            shift_reg[129]   = rx_p;

            if (gen_mode_protocol == PCIe_GEN3) begin
               if (shift_reg[129:2]  === 128'hFF00_FF00_FF00_FF00_FF00_FF00_FF00_FF00) begin // EIEOS detect
                  if (shift_reg[1:0] === 2'b01) begin
                     block_found  = 1;
                     shift_sel    = 0;
                     bit_cnt      = 0;
                     -> eieos_detected_e;
                     -> com_or_eieos_detected_e;
                  end
               end
            end
            if (gen_mode_protocol == PCIe_GEN4) begin
               if (use_v0_5_eieos === 1'b0 && shift_reg[129:2]  === 128'hFFFF_0000_FFFF_0000_FFFF_0000_FFFF_0000 ||
                   use_v0_5_eieos === 1'b1 && shift_reg[129:2]  === 128'hFF00_FF00_FF00_FF00_FF00_FF00_FF00_FF00 ) begin // EIEOS detect
                  if (shift_reg[1:0] === 2'b01) begin
                     block_found  = 1;
                     shift_sel    = 0;
                     bit_cnt      = 0;
                     -> eieos_detected_e;
                     -> com_or_eieos_detected_e;
                  end
               end
            end
         end
      end
   endtask

   task block_alignment_128_132();
      begin
         // Once the block is found then the following needs to be controlled
         //  1: Toggle the clock on 0, 2, cnt-2%8==0 and cnt-2%8==3
         // This process is NOT using a shift architecture.  This is because of
         //  the amount of latency that this would enter into the system.
         if(encoder_bypass_mode == 1'b0) begin
            if(block_found) begin
               if(bit_cnt < 4) begin
                  shift_sel = bit_cnt;
               end else begin
                  shift_sel = (bit_cnt - 4) % 8;
               end
               shift_reg[shift_sel] = rx_p;

               if(shift_sel == 0) begin
                  clk_out = 1;
               end
               else if(shift_sel == 2) begin
                  clk_out = 0;
               end
               else if(shift_sel == 3) begin
                  clk_out = 0;
               end

               if(bit_cnt == 3) begin
                  dout        = shift_reg[3:0];
                  dvalid_bits = 4;
                  dvalid      = 1;
                  -> data_vld;
               end
               else if((bit_cnt-4)%8==7) begin
                  dout        = shift_reg[7:0];
                  dvalid_bits = 8;
                  -> data_vld;
               end


               if(bit_cnt == block_boundary) begin
                  bit_cnt = 0;
               end else begin
                  bit_cnt += 1;
               end

               if (block_shift_reg[131:18]  === 114'h2_6666_6666_6666_6666_6666_6666_6666) begin // EIOS detect
                  eios_detected  = 1'b1;
                  eios_timestamp = $time;
               end
               else begin
                  eios_detected  = 1'b0;
               end
            end
            else begin
               bit_cnt   = 131;
               shift_sel = 132;
               shift_reg[131:0] = shift_reg[132:1];
               if (shift_reg[131:4]   === 128'hFF00_FF00_FF00_FF00_FF00_FF00_FF00_FF00) begin // EIEOS detect
                  if ((shift_reg[3:0] === 4'b0011) || (shift_reg[3:0] === 4'b1100)) begin
                     block_found = 1;
                     shift_sel   = 0;
                     bit_cnt     = 1;
                     -> eieos_detected_e;
                     -> com_or_eieos_detected_e;
                  end
               end
               shift_reg[shift_sel]   = rx_p;
            end
         end
         else begin
            if(block_found) begin
               shift_sel = (bit_cnt) % 8;
               shift_reg[shift_sel] = rx_p;

               if(shift_sel == 0) begin
                  clk_out = 1;
               end
               else if(shift_sel == 2) begin
                  clk_out = 0;
               end
               else if(shift_sel == 3) begin
                  clk_out = 0;
               end

               if((bit_cnt)%8==7) begin
                  dout        = shift_reg[7:0];
                  dvalid_bits = 8;
                  -> data_vld;
               end


               if(bit_cnt == 127) begin
                  bit_cnt = 0;
               end else begin
                  bit_cnt += 1;
               end

               if (block_shift_reg[131:18]  === 114'h2_6666_6666_6666_6666_6666_6666_6666) begin // EIOS detect
                  eios_detected  = 1'b1;
                  eios_timestamp = $time;
               end
               else begin
                  eios_detected  = 1'b0;
               end
            end
            else begin
               bit_cnt   = 127;
               shift_sel = 127;
               shift_reg[126:0] = shift_reg[127:1];
               shift_reg[127]   = rx_p;
               if (shift_reg[127:0]   === 128'hFF00_FF00_FF00_FF00_FF00_FF00_FF00_FF00) begin // EIEOS detect
                  block_found = 1;
                  shift_sel   = 0;
                  bit_cnt     = 0;
                  -> eieos_detected_e;
                  -> com_or_eieos_detected_e;
               end        
            end
         end
      end
   endtask

   always@(negedge sample_clk) begin
      if(gen_mode_protocol == USB3_GEN2 && valid_bits_m == 4'h4 && block_found == 1'b1 && encoder_bypass_mode == 1'b0) begin
         if(dout == 10'h00C || dout == 10'h003) begin
            usb3_1_header = dout;
            if(block_boundary != 131) begin
               block_boundary = 131;
            end
         end
         else begin
            $display($time," %m ######## valid_bits_m = ",valid_bits_m," ######## dout = ",dout," ######## ");
            clr_lock();
         end
      end
      else if(gen_mode_protocol == USB3_GEN2 && valid_bits_m == 4'h8 && block_found == 1'b1 && usb3_1_header == 4'hC && dout == 10'h0CC && bit_cnt == 12) begin
         block_boundary = 500; 
      end
      else if(gen_mode_protocol == USB3_GEN2 && valid_bits_m == 4'h8 && block_found == 1'b1 && usb3_1_header == 4'hC && dout == 10'h033 && block_boundary == 500) begin
         block_boundary = bit_cnt + 23;
      end

      //Clear if in 12X shift mode
      if(block_found) begin
         if((shift_reg[0] === 1'bz) || (shift_reg[0] === 1'bx) || (data_z && (rx_p === 1'bz))) begin
            clr_lock();
         end
      end
   end


   // Detect when a SKIP symbol is removed; and act accordingly
   always@(negedge sample_clk) begin

      if (gen_mode_protocol == PCIe_GEN3 || gen_mode_protocol == PCIe_GEN4) begin

         // Detect a control
         if (dout[1:0] == 2'h1 && valid_bits_m == 4'h2 && skp_enable == 1) begin
            skp_in_control = 1;
         end
         else if (dout[1:0] != 10'h1 && valid_bits_m == 4'h2) begin
            skp_in_control = 0;
         end
 
         // Detect a SKP by counting 'AA' received in control word
         if (skp_in_control == 1 && dout == 10'hAA) begin
            skp_bit_cnt += 1;

            // reset bit_cnt during SKPOS longer than 130b to avoid wraparound that would unalign bit_cnt
            // NOTE: bit_cnt is related to serial rx_p/m so it is 8 bits in advance on dout
            if (bit_cnt == 122 && skp_bit_cnt >= 4*8) begin
               bit_cnt = 2; // realign here for SKPOS longer than 130b - to mimic end of block
            end
         end

         // Recenter the shift register for a SKP ADD/DROP
         else if (skp_in_control == 1 && dout_d1 == 10'hAA && (dout == 10'hE1 || (gen_mode_protocol == PCIe_GEN4 && dout == 10'h78))) begin
            if (dout == 10'hE1) begin
               skp_end_ctl = 0;
            end else if (dout == 10'h78) begin
               skp_end_ctl = 1;
            end
            skp_sym_cnt = skp_bit_cnt/8;
            -> skp_end_detected_e;
            skp_end_ctl_last <= skp_end_ctl;
            
            if (skp_bit_cnt >= 4*8) begin
               bit_cnt = 106; // realign here for SKPOS shorter than 130b - to mimic end of block
            end
         end

         else begin
            skp_bit_cnt = 0;
            skp_sym_cnt = 0;
         end
         

         // Delayed version of dout to detect AA E1 pattern
         dout_d1 <= dout;

      end
   end

   always@(posedge sample_clk) begin
      // 8b/10b protocol always shift
      // 128b/13Xb protocols only shift when not locked when locked the bit
      //  is positioned in the correct position for latency reasons
      if (use_raw_mode) begin
         shift_reg[9:0] = shift_reg[10:1];
      end
      else begin
         case(gen_mode_protocol)
            PCIe_GEN1: shift_reg[9:0] = shift_reg[10:1];
            PCIe_GEN2: shift_reg[9:0] = shift_reg[10:1];
            USB3_GEN1: shift_reg[9:0] = shift_reg[10:1];
            SATA_GEN1: shift_reg[39:0] = shift_reg[40:1];
            SATA_GEN2: shift_reg[39:0] = shift_reg[40:1];
            SATA_GEN3: shift_reg[39:0] = shift_reg[40:1];
            DP_RBR   : shift_reg[9:0] = shift_reg[10:1];
            DP_HBR   : shift_reg[9:0] = shift_reg[10:1];
            DP_HBR2  : shift_reg[9:0] = shift_reg[10:1];
            KR10G    : shift_reg[9:0] = shift_reg[10:1];
            GE1      : shift_reg[9:0] = shift_reg[10:1];
            XAUI     : shift_reg[9:0] = shift_reg[10:1];
            RXAUI    : shift_reg[9:0] = shift_reg[10:1];
            eDP_RATE1: shift_reg[9:0] = shift_reg[10:1];
            eDP_RATE2: shift_reg[9:0] = shift_reg[10:1];
            eDP_RATE3: shift_reg[9:0] = shift_reg[10:1];
            eDP_RATE4: shift_reg[9:0] = shift_reg[10:1];
            eDP_RATE5: shift_reg[9:0] = shift_reg[10:1];
            eDP_RATE6: shift_reg[9:0] = shift_reg[10:1];
            eDP_RATE7: shift_reg[9:0] = shift_reg[10:1];
            HDMI_RATE: shift_reg[9:0] = shift_reg[10:1];
         endcase
      end
      
      // Clear Lock on :
      //  Z or X getting through shift reg
      //  Data Z state
      if((shift_reg[0] === 1'bz) || (shift_reg[0] === 1'bx) || (data_z && (rx_p === 1'bz))) begin
         if(block_found) begin
            clr_lock();
         end

         // Shift the 128 to 13X protocols
         //  This is done because once in block lock the global shift no longer
         //  is used
         if (use_raw_mode) begin
            // Do nothing
         end
         else begin
            case(gen_mode_protocol)
               PCIe_GEN3: begin
                  shift_reg[129:0] = shift_reg[130:1];
                  shift_reg[130]   = rx_p;
               end
               PCIe_GEN4: begin
                  shift_reg[129:0] = shift_reg[130:1];
                  shift_reg[130]   = rx_p;
               end
               USB3_GEN2: begin
                  if(encoder_bypass_mode) begin
                     shift_reg[126:0] = shift_reg[127:1];
                     shift_reg[127]   = rx_p;
                  end
                  else begin
                     shift_reg[131:0] = shift_reg[132:1];
                     shift_reg[132]   = rx_p;
                  end
               end
            endcase
         end
      end
      else begin
         if (use_raw_mode) begin
            comma_alignment();
         end
         else begin
            case(gen_mode_protocol)
               PCIe_GEN1: comma_alignment();
               PCIe_GEN2: comma_alignment();
               PCIe_GEN3: block_alignment_128_130();
               PCIe_GEN4: block_alignment_128_130();
               USB3_GEN1: comma_alignment();
               USB3_GEN2: block_alignment_128_132();
               SATA_GEN1: comma_alignment();
               SATA_GEN2: comma_alignment();
               SATA_GEN3: comma_alignment();
               DP_RBR   : comma_alignment();
               DP_HBR   : comma_alignment();
               DP_HBR2  : comma_alignment();
               KR10G:     comma_alignment();
               GE1:       comma_alignment();
               XAUI:      comma_alignment();
               RXAUI:     comma_alignment();
               eDP_RATE1: comma_alignment();
               eDP_RATE2: comma_alignment();
               eDP_RATE3: comma_alignment();
               eDP_RATE4: comma_alignment();
               eDP_RATE5: comma_alignment();
               eDP_RATE6: comma_alignment();
               eDP_RATE7: comma_alignment();
               HDMI_RATE: comma_alignment();
            endcase
         end
      end

      if(rx_p === 1'bz && rx_m === 1'bz) begin
         shift_reg[shift_sel] = 1'bz;

         for(int i = 0; i < 161; i++) begin
            block_shift_reg[i] = 1'bz;
         end
      end
      else if(rx_p === rx_m) begin
         shift_reg[shift_sel] = 1'bx;

         for(int i = 0; i < 161; i++) begin
            block_shift_reg[i] = 1'bx;
         end
      end
      else begin
         if (use_raw_mode) begin
            shift_reg[shift_sel] = rx_p;
         end
         else begin
            case(gen_mode_protocol)
               USB3_GEN1 : begin
                  shift_reg[shift_sel]  = rx_p;
                  block_shift_reg[39:0] = block_shift_reg[40:1];
                  block_shift_reg[40]   = rx_p;
               end
               USB3_GEN2 : begin
                  block_shift_reg[130:0] = block_shift_reg[131:1];
                  block_shift_reg[131]   = rx_p;
               end
               PCIe_GEN1 : begin
                  shift_reg[shift_sel] = rx_p;
                  block_shift_reg[39:0] = block_shift_reg[40:1];  // For EIOS Detection
                  block_shift_reg[40]   = rx_p;
               end
               PCIe_GEN2 : begin
                  shift_reg[shift_sel] = rx_p;
                  block_shift_reg[159:0] = block_shift_reg[160:1];  // For EIOS/EIEOS Detection
                  block_shift_reg[160]   = rx_p;
               end
               PCIe_GEN3 : begin
                  block_shift_reg[128:0] = block_shift_reg[129:1];
                  block_shift_reg[129]   = rx_p;
               end
               PCIe_GEN4 : begin
                  block_shift_reg[128:0] = block_shift_reg[129:1];
                  block_shift_reg[129]   = rx_p;
               end
               SATA_GEN1 : begin
                  shift_reg[shift_sel] = rx_p;
               end
               SATA_GEN2 : begin
                  shift_reg[shift_sel] = rx_p;
               end
               SATA_GEN3 : begin
                  shift_reg[shift_sel] = rx_p;
               end
               DP_RBR : begin
                  shift_reg[shift_sel] = rx_p;
               end
               DP_HBR : begin
                  shift_reg[shift_sel] = rx_p;
               end
               DP_HBR2 : begin
                  shift_reg[shift_sel] = rx_p;
               end
               KR10G : begin
                  shift_reg[shift_sel] = rx_p;
               end
               GE1   : begin
                  shift_reg[shift_sel] = rx_p;              
               end
               XAUI  : begin
                  shift_reg[shift_sel] = rx_p;              
               end
               RXAUI  : begin
                  shift_reg[shift_sel] = rx_p;              
               end
               eDP_RATE1 : begin
                  shift_reg[shift_sel] = rx_p;
               end
               eDP_RATE2 : begin
                  shift_reg[shift_sel] = rx_p;
               end
               eDP_RATE3 : begin
                  shift_reg[shift_sel] = rx_p;
               end
               eDP_RATE4 : begin
                  shift_reg[shift_sel] = rx_p;
               end
               eDP_RATE5 : begin
                  shift_reg[shift_sel] = rx_p;
               end
               eDP_RATE6 : begin
                  shift_reg[shift_sel] = rx_p;
               end
               eDP_RATE7 : begin
                  shift_reg[shift_sel] = rx_p;
               end
               HDMI_RATE : begin
                  shift_reg[shift_sel] = rx_p;
               end
            endcase
         end
      end
   end

   // Instantiate a 10b symbol debug interface for helping wave debug
   /*
   sd_10b_sym_debug_if debug_if(.input_clk  (clk_out),
                                .input_sym  (dout   ),
                                .input_valid(dvalid ));
   */
   // First attempt at detecting a beacon (thanks Matt for the idea)
   // Assume we have a beacon when:
   //   a) Block is NOT found
   //   2) On rising edge of shift_reg[0] shift_reg[10:1] are all one
   //   3) On the following falling edge of shift_reg[0] shift_reg[10:1] are all zeros
   
   always @(posedge shift_reg[0]) beacon_pending = ((block_found == 0) && (shift_reg[10:1] == 1023));
   always @(negedge shift_reg[0]) begin
      if ((beacon_pending == 1) && (block_found == 0) && (shift_reg[10:1] == 0)) -> beacon_detected;
   end //always @(negedge shift_reg[0])
   always @(negedge beacon_pending) begin
       -> becon_gone_way;
   end
   // if we have "beacon pending", but input gone X, notify the e code that we are out of bacon
   always @ (sample_clk) 
      if ((shift_reg[0] === 'x) && (beacon_pending == 1)) beacon_pending = 0;
  

   logic eios_chk_en;

   initial begin
   `ifdef CDN_DISABLE_EIOS_CHK
      eios_chk_en = 0;
   `else
      eios_chk_en = 1;
   `endif
   end

   event eios_time_check_e;

   function bit within_8ns(time check_time);
      return (($time - check_time) <= 8ns);
   endfunction

   // 
   // Coverage
   //
   
   // EIOS_to_CMN_MODE_Z_CHK: Verify that EIOS is processed and is within 8ns
   property EIOS_to_CMN_MODE_Z_CHK;
      @(eios_time_check_e) eios_chk_en |-> within_8ns(eios_timestamp);
   endproperty
   EIOS_to_CMN_MODE_Z_CHK_a : assert property(EIOS_to_CMN_MODE_Z_CHK) else $error("EIOS is processed and is within 8ns");
   
   // EIOS_to_CMN_MODE_Z_CHK has been triggered for all 4 GENs
   covergroup PCIe_EIOS_to_CMN_MODE_Z_CHK_cg @(eios_time_check_e);
      PCIe_gen_mode_c: coverpoint gen_mode_protocol iff(eios_chk_en) {
         bins PCIe_GEN1 = {PCIe_GEN1};
         bins PCIe_GEN2 = {PCIe_GEN2};
         bins PCIe_GEN3 = {PCIe_GEN3};
         bins PCIe_GEN4 = {PCIe_GEN4};
      }        
   endgroup
   PCIe_EIOS_to_CMN_MODE_Z_CHK_cg PCIe_EIOS_to_CMN_MODE_Z_CHK_cg_i = new;

   // EIEOS is transmitted with both PCIe v0.5 and v0.7 formats in GEN4
   covergroup PCIe_v0_5_v0_7_cg @(eieos_detected_e);
      PCIe_eieos_v0_5_v0_7_c: coverpoint use_v0_5_eieos iff(gen_mode_protocol == PCIe_GEN4) {
         bins eieos_v0_5 = {1};
         bins eieos_v0_7 = {0};
      }
   endgroup
   PCIe_v0_5_v0_7_cg PCIe_v0_5_v0_7_cg_i = new;

   covergroup SKP_OS_cg @(skp_end_detected_e);
      option.name = "cg for SKP_OS";
      option.per_instance = 1;

      // cover for GEN3/GEN4 only
      gen_c: coverpoint gen_mode_protocol {
         bins PCIe_GEN3 = {PCIe_GEN3};
         bins PCIe_GEN4 = {PCIe_GEN4};
      }
      
      // Standard or Control SKP_OS detected - terminating with SKP_END or SKP_END_CTL
      skp_end_ctl_c: coverpoint skp_end_ctl;
      skp_end_ctl_last_c: coverpoint skp_end_ctl_last;

      // SKP_OS lengths
      skp_sym_cnt_c: coverpoint skp_sym_cnt {
         bins skp_sym_cnt[] = {4,8,12,16,20};
      }

      // SKP_END in both GEN3/GEN4, SKP_END_CTL only in GEN4
      cross_skp_end_ctl_gen_c: cross skp_end_ctl_c, gen_c {
         ignore_bins ignore_b = binsof(skp_end_ctl_c) intersect {1} && binsof(gen_c) intersect{PCIe_GEN3};
      }

      // SKP_END and SKP_END_CTL with all possible SKP_OS lengths
      cross_skp_end_ctl_skp_sym_cnt_c: cross skp_end_ctl_c, skp_sym_cnt_c;

      // SKP_END and SKP_END_CTL alternating
      cross_skp_end_skp_end_ctl_alternating_c: cross skp_end_ctl_c, skp_end_ctl_last_c {
         ignore_bins ignore_b = cross_skp_end_skp_end_ctl_alternating_c with (skp_end_ctl_c == skp_end_ctl_last_c);
      }	 
   
   endgroup
   SKP_OS_cg SKP_OS_cg_i = new;

   
   logic   eios_detected_latch = 0;

   always@(*) begin
      if(eios_detected === 1'b1) begin
         eios_detected_latch = 1;
      end
   end

   always@(*) begin
      if(eios_detected_latch && !serial_data) begin
         -> eios_time_check_e;
         eios_detected_latch = 0;
         eios_detected       = 0;
      end
   end

endinterface : sd_deserializer_lock
