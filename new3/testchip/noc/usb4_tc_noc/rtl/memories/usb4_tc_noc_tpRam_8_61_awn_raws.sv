// Copyright (c) 2013-2025 by Cadence Design Systems Inc.  ALL RIGHTS RESERVED.
// These coded instructions, statements, and computer programs are the copyrighted
// works and confidential proprietary information of Cadence Design Systems Inc.
// They may not be modified, copied, reproduced, distributed, or disclosed to
// third parties in any manner, medium, or form, in whole or in part, without the
// prior written consent of Cadence Design Systems Inc.

module usb4_tc_noc_tpRam_8_61_awn_raws (
  // tpRamIf
  input  wire            clk,
  input  wire            rst_n,
  input  wire            wen,
  input  wire      [2:0] waddr,
  input  wire     [60:0] wdata,
  input  wire            ren,
  input  wire      [2:0] raddr,
  output logic    [60:0] rdata
);

wire     [60:0] store_nxt;                                                      // Create a scalar version of nxt_store
logic    [60:0] store [7:0];
// Interface parameters
// Port that is providing memory
//
// Two Port RAM
// (One read port, one write port)
//
// The name of the module is formatted such that in ends with the string:
// *_wordCount_bitWidth_[resetType][writeMask][persistMode]_[clockMode]
//
// The [resetType] is only needed when reset is needed and is set to one of the following:
// a - asynch reset
// s - sync reset
//
// The [writeMask] will be set to one of the following:
// b - bit writable
// w - word (row) writable
//
// The [persistMode] will be set to one of the following:
// p - Read data (Q) persists after a read operation, until the next read
// n - Read data (Q) does not persist after a read operation
//
// The [clockMode] will be set to one of the following:
// rws  - Synchronous read and write using a single clock
// rsws - Synchronous read and write using separate read and write clocks
// raws - Synchronous write with asynchronous read
//
// *NOTE* This RAM is assumed to present valid rdata only when ren is asserted (asynchronous to write
// clock). It is OK to always present valid rdata based on the current value of raddr, and to
// ignore the ren signal. This model assumes that it is safe to read the storage array and that
// a write will not occur near a read of the same flop due to external safeguards.
//
`ifdef USB4_TC_NOC_TPRAM_8_61_AWN_RAWS
// Instantiate the memory hard macro cell by removing the placeholder(s) below.
// The word "placeholder" cannot be used anywhere in the name of your memory instance.
// Note that there might be more ports on the memory hard macro then there are ports
// available for connection as defined above; follow your memory vendor's recommendation
// on how to tie off unused ports. All input ports must be tied off to get formal
// verification to work properly.
  vendor_memory_hard_macro placeholder_usb4_tc_noc_tpram_8_61_awn_raws ();
`else

// Flop Based Model
//
// *NOTE* This model may be used for simulation or synthesis
//
// As it is implemented with flops, this model requires a reset. When converting to a RAM, the
// reset signal(s) can be ignored. No code behaviorally relies on the SRAM contents being initialized
// to a specific value by this module.
//
always_ff @(posedge clk, negedge rst_n)
begin
  if (!rst_n)
    begin
      store[0] <= #1ps {61{1'b0}};
      store[1] <= #1ps {61{1'b0}};
      store[2] <= #1ps {61{1'b0}};
      store[3] <= #1ps {61{1'b0}};
      store[4] <= #1ps {61{1'b0}};
      store[5] <= #1ps {61{1'b0}};
      store[6] <= #1ps {61{1'b0}};
      store[7] <= #1ps {61{1'b0}};
    end
  else if (wen)
    begin
      assert property (waddr==waddr) else $error("ERROR usb4_tc_noc_link0_lt_g2l_f1_fifo_fifoBuf_usb4_tc_noc_tpRam_8_61_awn_raws : %0t : Z or X in address on write",$time);
      assert property (waddr<8) else $error("ERROR usb4_tc_noc_link0_lt_g2l_f1_fifo_fifoBuf_usb4_tc_noc_tpRam_8_61_awn_raws : %0t : Address out of range on write",$time);
      store[waddr] <= #1ps store_nxt;
    end
end

// Write Logic
assign store_nxt = wdata;
// Read Logic
// Async read. Just combinatorially assign rdata based on ren
assign rdata = (ren) ? store[raddr] : {61{1'b1}};
`endif
endmodule

