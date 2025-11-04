
//-----------------------------------------------------------------------------
//    This confidential and proprietary HDL soft description of a Hardware
//    component may be used only as authorized by a licensing agreement from
//    Cadence. In the event of publication,the following notice
//    is applicable:
//
//                       (C) COPYRIGHT 2019 Cadence
//                         ALL RIGHTS RESERVED
//
//     The entire notice above must be reproduced on all authorized
//     copies of this code.
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//
// Filename        : idram_arb.v
// Version         : $Revision: $
// Date / Time     : $Date: $
//
// Author          : Dave Masters
// Abstract        : This block is an arbiter of the SRAM between the Harvard
//                   architected IRAM and DRAM bus of xtensa to share
//                   a single unified SRAM
//
//                   For further details on this, one should read the Whistler
//                   PHY specification, and the respective block level
//                   specifications for the sub blocks instantiated in this
//                   module.
//
//-----------------------------------------------------------------------------

module idram_arb (
input         clk,
input         reset_n,
output [16:2] idram_addr,
output  [3:0] idram_byteen,
input  [31:0] idram_data,
output        idram_en,
output        idram_wr,
output [31:0] idram_wrdata,
input  [16:2] dram_addr,
output        dram_busy,
input   [3:0] dram_byteen,
output [31:0] dram_data,
input         dram_en,
input         dram_wr,
input  [31:0] dram_wrdata,
input  [16:2] iram_addr,
output        iram_busy,
output [31:0] iram_data,
input         iram_en,
input         iram_wr,
input  [31:0] iram_wrdata
);

reg  dram_en_d;
reg  iram_en_d;

// Fixed arbiter.  dram highest priority
assign arb_sel = (dram_en) ? 1'b1 : 1'b0;

assign idram_addr   = (arb_sel) ? dram_addr   : iram_addr;
assign idram_byteen = (arb_sel) ? dram_byteen : 4'hF;
assign idram_en     = (arb_sel) ? dram_en     : iram_en;
assign idram_wr     = (arb_sel) ? dram_wr     : iram_wr;
assign idram_wrdata = (arb_sel) ? dram_wrdata : iram_wrdata;   

assign dram_data = idram_data;
assign iram_data = idram_data;

assign dram_busy = 1'b0;
assign iram_busy = dram_en_d && iram_en_d;

always @(negedge reset_n or posedge clk) begin
   if (!reset_n) begin
      dram_en_d <= 1'b0;
      iram_en_d <= 1'b0;
   end
   else begin
      dram_en_d <= dram_en;
      iram_en_d <= iram_en;
   end
end


endmodule

