//-----------------------------------------------------------------------------
//    This confidential and proprietary HDL soft description of a Hardware
//    component may be used only as authorized by a licensing agreement from
//    Cadence. In the event of publication, the following notice 
//    is applicable:
//
//                       (C) COPYRIGHT 2013 Cadence
//                         ALL RIGHTS RESERVED
//
//     The entire notice above must be reproduced on all authorized
//     copies of this code.
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//
// Filename        : sd_serializer.sv
// Version         : $Revision: $
// Date / Time     : $Date: $
// 
// Author          : 
// Abstract        : 
//                   
//                   
//-----------------------------------------------------------------------------
`timescale 1ps/100fs

module sd_deserializer_lock
  (
   input [2:0]      gen_mode,
   input            rx_p,
   input            rx_m,
   input            enable,
   output reg       clk_out, 
   output reg [15:0] dout,           // 16-bit for 32-bit upstream, 10-bit for 20-bit upstream
   output reg       dvalid 
   );

   real             clk_period = 100;

   reg              sample_clk_gen;

   reg [10:0]       shift_reg_20bit;  // 11-bit for 20-bit mode (10-bit + 1 new bit)
   reg [16:0]       shift_reg_32bit;  // 17-bit for 32-bit mode (16-bit + 1 new bit)
   
   event            start_sample_clk;
   event            stop_sample_clk;
   event            new_gen_mode;

   logic [4:0] bit_comma_cnt;       // 5-bit counter sufficient for max 15
   logic       eios_detected = 0;
   logic       comma_found = 0;
   logic       data_to_z   = 0;
   logic       data_to_cmn = 0;
   
   // TODO: Add logic to determine interface mode based on gen_mode
   logic       is_32bit_mode;        // Will be set based on gen_mode analysis

   // Comma patterns
   parameter [9:0]  COMMA_20BIT_1 = 10'h17C;
   parameter [9:0]  COMMA_20BIT_2 = 10'h283;
   parameter [15:0] COMMA_32BIT   = 16'hF7F7;    // 16-bit comma for 32-bit upstream

   initial begin
      clk_out       = 0;
      dout          = 0;
      dvalid        = 0;
      bit_comma_cnt = 9;    // Default to 20-bit mode
      -> new_gen_mode;
   end

   always@(gen_mode) begin
      -> new_gen_mode;
   end

   always@(new_gen_mode) begin
      case(gen_mode)
         UHBR20   : clk_period = 50;    // 3'b000 UHBR20 (20.00 Gbps)
         UHBR13P5 : clk_period = 74;    // 3'b001 UHBR13.5 (13.50 Gbps)
         UHBR10   : clk_period = 100;   // 3'b010 UHBR10 (10.00 Gbps)
         HBR3     : clk_period = 123;   // 3'b011 HBR3 (8.10 Gbps)
         HBR2     : clk_period = 185;   // 3'b100 HBR2 (5.40 Gbps)
         HBR      : clk_period = 370;   // 3'b101 HBR (2.70 Gbps)
         RBR      : clk_period = 617;   // 3'b110 RBR (1.62 Gbps)
         default: clk_period = 100;  // fallback
      endcase

      // Determine interface mode based on gen_mode values
      // gen_mode <= 010: 10-bit comma mode (20-bit upstream)
      // gen_mode > 010:  16-bit comma mode (32-bit upstream)
      is_32bit_mode = (gen_mode > UHBR10) ? 1'b0 : 1'b1;
      
   end

   assign sample_clk = sample_clk_gen;
   
   // Initialize bit counter based on interface mode
   always@(new_gen_mode) begin
      // Set counter based on gen_mode determination
      if (is_32bit_mode == 0) begin
         bit_comma_cnt = 9;  // 20-bit mode (10-bit word - 1)
      end else begin
         bit_comma_cnt = 15; // 32-bit mode (16-bit word - 1)
      end
      comma_found = 0;
   end
   
   // with the master condition in the while loop, had to add #0
   // or it would not work even though master is tied off in the instantiation
   initial begin
      while (1) begin
    // do not change clock on change to high-z. The high-z change is
    // asynchronous to the serial data bit change
         @(rx_p);
         if (!data_to_z && !data_to_cmn) begin
            -> stop_sample_clk;
            #1;
            -> start_sample_clk;
         end
      end
   end

   always@(start_sample_clk) begin
      fork : sample_clk_gen_fork
         begin
            while (1)
              begin
                 #(clk_period/2.0);
                 sample_clk_gen = 1'b1;
                 #(10);
                 sample_clk_gen = 1'b0;
                 #(clk_period/2.0 - 10);
              end
         end
         
         begin
            @(stop_sample_clk);
            sample_clk_gen = 1'b0;
            disable sample_clk_gen_fork;
         end
      join
      
   end


   always@(posedge sample_clk) begin
      if(!data_to_cmn && !data_to_z) begin
            if (is_32bit_mode == 0) begin
               // 20-bit mode: use 11-bit shift register (new bit at MSB)
               if(rx_p === rx_m && rx_p !== 1'bz) begin
                  shift_reg_20bit <= {1'bx, shift_reg_20bit[10:1]};
               end
               else begin
                  shift_reg_20bit <= {rx_p, shift_reg_20bit[10:1]};
               end
            end
            else begin
               // 32-bit mode: use 17-bit shift register (new bit at MSB)
               if(rx_p === rx_m && rx_p !== 1'bz) begin
                  shift_reg_32bit <= {1'bx, shift_reg_32bit[16:1]};
               end
               else begin
                  shift_reg_32bit <= {rx_p, shift_reg_32bit[16:1]};
               end
            end
      end

      // Comma detection logic
      if (is_32bit_mode == 0) begin
         // 20-bit mode: check for 10-bit comma patterns
         if (((shift_reg_20bit[9:0] === COMMA_20BIT_1) || (shift_reg_20bit[9:0] === COMMA_20BIT_2)) && (bit_comma_cnt == 9)) begin
            comma_found   <= 1;
            bit_comma_cnt <= 0;
            dout[9:0]     <= shift_reg_20bit[9:0];
            dout[15:10]   <= 6'b0;  // Clear upper bits in 20-bit mode
            dvalid        <= 1;
         end
         else begin
            if(shift_reg_20bit[0] === 1'bz || shift_reg_20bit[0] === 1'bx) begin
               dvalid  <= 0;
               bit_comma_cnt <= 9;
               comma_found   <= 0;
               clk_out <= 0;
            end
            else if(comma_found) begin
               if(bit_comma_cnt == 9) begin
                  bit_comma_cnt <= 0;
                  dout[9:0]     <= shift_reg_20bit[9:0];
                  dout[15:10]   <= 6'b0;
               end 
               else begin
                  bit_comma_cnt <= bit_comma_cnt + 1;
               end
               
               if(bit_comma_cnt == 0 && (shift_reg_20bit[8] !== 1'bx)) begin
                  clk_out <= 1;
               end
               else if(bit_comma_cnt == 5) begin
                  clk_out <= 0;
               end
            end
         end
      end
      else begin
         // 32-bit mode: check for 16-bit comma pattern (16'hF7F7)
         if ((shift_reg_32bit[15:0] === COMMA_32BIT) && (bit_comma_cnt == 15)) begin
            comma_found   <= 1;
            bit_comma_cnt <= 0;
            dout          <= shift_reg_32bit[15:0];  // Output 16 bits
            dvalid        <= 1;
         end
         else begin
            if(shift_reg_32bit[0] === 1'bz || shift_reg_32bit[0] === 1'bx) begin
               dvalid  <= 0;
               bit_comma_cnt <= 15;
               comma_found   <= 0;
               clk_out <= 0;
            end
            else if(comma_found) begin
               if(bit_comma_cnt == 15) begin
                  bit_comma_cnt <= 0;
                  dout          <= shift_reg_32bit[15:0];  // Output 16 bits
               end 
               else begin
                  bit_comma_cnt <= bit_comma_cnt + 1;
               end
               
               if(bit_comma_cnt == 0 && (shift_reg_32bit[14] !== 1'bx)) begin
                  clk_out <= 1;
               end
               else if(bit_comma_cnt == 8) begin  // Clock transition at middle of 16-bit word
                  clk_out <= 0;
               end
            end
         end
      end
   end
   
endmodule : sd_deserializer_lock

