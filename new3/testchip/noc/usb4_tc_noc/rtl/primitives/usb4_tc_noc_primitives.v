
// Copyright (c) 2013-2025 by Cadence Design Systems Inc.  ALL RIGHTS RESERVED.
// These coded instructions, statements, and computer programs are the copyrighted
// works and confidential proprietary information of Cadence Design Systems Inc.
// They may not be modified, copied, reproduced, distributed, or disclosed to
// third parties in any manner, medium, or form, in whole or in part, without the
// prior written consent of Cadence Design Systems Inc.

`define NOC_SEQ_DELAY #1ps

//
// Synchronizer List N = 1, 2, 3
//
// Asynchronous Clear
// usb4_tc_noc_xtascsynch<N>( xtout, xtin, clrb, clk )
//
// Non-Clearing
// usb4_tc_noc_xtsynch<N>( xtout, xtin, clk )
//

//
// Clock Gating
//
// Clock Gate without TMode
// usb4_tc_noc_xtgated_clock(xtout, xten, xtclk);
//
// Clock Gate with TMode
// usb4_tc_noc_xtgated_tmode_clock(xtout, xtmode, xten, xtclk);
//


//
// Reset Synchronization
//

// 1 Stage (half) async

module usb4_tc_noc_xtreset_n_tmode_async_synchronizer1(xtfreset, xtlreset, xtmode, xtreset, xtclk);
output xtfreset, xtlreset;
input xtmode, xtreset, xtclk;
   wire fresetb;
   usb4_tc_noc_xtascsynch1 asyncreset_synch(fresetb,1'b1,xtreset,xtclk);
   assign xtfreset = xtmode ? xtreset : fresetb;
   assign xtlreset = fresetb;
endmodule

module usb4_tc_noc_xtreset_n_async_synchronizer1(xtfreset, xtlreset, xtreset, xtclk);
output xtfreset, xtlreset;
input xtreset, xtclk;
   wire fresetb;
   usb4_tc_noc_xtascsynch1 asyncreset_synch(fresetb,1'b1,xtreset,xtclk);
   assign xtfreset = fresetb;
   assign xtlreset = fresetb;
endmodule

// 3 Stage async

module usb4_tc_noc_xtreset_n_tmode_async_synchronizer3(xtfreset, xtlreset, xtmode, xtreset, xtclk);
output xtfreset, xtlreset;
input xtmode, xtreset, xtclk;
   wire fresetb;
   usb4_tc_noc_xtascsynch3 asyncreset_synch(fresetb,1'b1,xtreset,xtclk);
   assign xtfreset = xtmode ? xtreset : fresetb;
   assign xtlreset = fresetb;
endmodule

module usb4_tc_noc_xtreset_n_async_synchronizer3(xtfreset, xtlreset, xtreset, xtclk);
output xtfreset, xtlreset;
input xtreset, xtclk;
   wire fresetb;
   usb4_tc_noc_xtascsynch3 asyncreset_synch(fresetb,1'b1,xtreset,xtclk);
   assign xtfreset = fresetb;
   assign xtlreset = fresetb;
endmodule

//
// Async Clear Synchronizers
//

module usb4_tc_noc_xtascflop(xtout, xtin, clrb, clk);       // async clear
   parameter size = 32; // vhdl generic

   output [size-1:0] xtout;
   input [size-1:0]  xtin;
   input             clrb;
   input             clk;
   reg [size-1:0]    tmp;

   // synopsys async_set_reset "clrb"
   // cadence async_set_reset "clrb"

   assign xtout = tmp;
   always @(posedge clk or negedge clrb) begin
      if (!clrb) tmp <= `NOC_SEQ_DELAY {size{1'b0}};
      else tmp <= `NOC_SEQ_DELAY xtin;
   end
endmodule // usb4_tc_noc_xtascflop

module usb4_tc_noc_xtascsynch1(xtout, xtin, clrb, clk);
output xtout;
input xtin;
input clrb;
input clk;
    wire t0;
    usb4_tc_noc_xtascflop #(1) i0(t0, xtin, clrb, clk);
    assign xtout = t0;
endmodule

module usb4_tc_noc_xtascsynch2(xtout, xtin, clrb, clk);
output xtout;
input xtin;
input clrb;
input clk;
    wire t0;
    usb4_tc_noc_xtascflop #(1) i0(t0, xtin, clrb, clk);
    wire t1;
    usb4_tc_noc_xtascflop #(1) i1(t1, t0, clrb, clk);
    assign xtout = t1;
endmodule

module usb4_tc_noc_xtascsynch3(xtout, xtin, clrb, clk);
output xtout;
input xtin;
input clrb;
input clk;
    wire t0;
    usb4_tc_noc_xtascflop #(1) i0(t0, xtin, clrb, clk);
    wire t1;
    usb4_tc_noc_xtascflop #(1) i1(t1, t0, clrb, clk);
    wire t2;
    usb4_tc_noc_xtascflop #(1) i2(t2, t1, clrb, clk);
    assign xtout = t2;
endmodule

//
// Non-clearing Synchronizers
//

module usb4_tc_noc_xtflop(xtout, xtin, clk);
   parameter size = 32; // vhdl generic

   output [size-1:0] xtout;
   input [size-1:0]  xtin;
   input             clk;
   reg [size-1:0]    tmp;
   assign xtout = tmp;
   always @(posedge clk) begin
         tmp <= `NOC_SEQ_DELAY xtin;
   end
endmodule

module usb4_tc_noc_xtsynch1(xtout, xtin, clk);
output xtout;
input xtin;
input clk;
    wire t0;
    usb4_tc_noc_xtflop #(1) i0(t0, xtin, clk);
    assign xtout = t0;
endmodule

module usb4_tc_noc_xtsynch2(xtout, xtin, clk);
output xtout;
input xtin;
input clk;
    wire t0;
    usb4_tc_noc_xtflop #(1) i0(t0, xtin, clk);
    wire t1;
    usb4_tc_noc_xtflop #(1) i1(t1, t0, clk);
    assign xtout = t1;
endmodule

module usb4_tc_noc_xtsynch3(xtout, xtin, clk);
output xtout;
input xtin;
input clk;
    wire t0;
    usb4_tc_noc_xtflop #(1) i0(t0, xtin, clk);
    wire t1;
    usb4_tc_noc_xtflop #(1) i1(t1, t0, clk);
    wire t2;
    usb4_tc_noc_xtflop #(1) i2(t2, t1, clk);
    assign xtout = t2;
endmodule

//
// Clock Gating
//

module usb4_tc_noc_xtclock_gate_nlatch(xtout,xtin,en);
 output xtout;
 input xtin;
 input en;

 reg xtout;

 always @(en or xtin) begin
  if (~en) begin
   xtout <= `NOC_SEQ_DELAY xtin;
  end
 end
endmodule // usb4_tc_noc_xtclock_gate_nlatch

module usb4_tc_noc_xtclock_gate_and(xtout,xtclk,xten);
   output xtout;
   input  xtclk;
   input  xten;
 assign xtout = (xten & xtclk);
endmodule // usb4_tc_noc_xtclock_gate_and

module usb4_tc_noc_xtgated_clock(xtout, xten, xtclk);
output xtout;
input xten, xtclk;

    // IMPORTANT NOTE: Do not edit this file. You cannot remove clock gating
    // from the design by changing this primitive. Consult the Tensilica
    // Technical Support website for further information on the removal
    // of clock gating.

    wire temp;
    usb4_tc_noc_xtclock_gate_nlatch i0(temp, xten, xtclk);
    usb4_tc_noc_xtclock_gate_and i1(xtout, xtclk, temp);
endmodule

module usb4_tc_noc_xtgated_tmode_clock(xtout, xtmode, xten, xtclk);
output xtout;
input xtmode, xten, xtclk;

    // IMPORTANT NOTE: Do not edit this file. You cannot remove clock gating
    // from the design by changing this primitive. Consult the Tensilica
    // Technical Support website for further information on the removal
    // of clock gating.

    wire en = xtmode | xten;
    usb4_tc_noc_xtgated_clock i0(xtout, en, xtclk);
endmodule
