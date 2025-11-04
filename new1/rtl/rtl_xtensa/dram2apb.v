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
// Filename        : dram2apb.v
// Version         : $Revision: $
// Date / Time     : $Date: $
//
// Author          : Dave Masters
// Abstract        : This block is used to convert the Xtensa dram interface to
//                   ARM AMBA APB interface so a seperate PIF or AHB/AXI interface
//                   is not needed.  This will save logic in the Xtensa.
//                   Busy does not insert wait states in Xtensa, but cancels the
//                   transaction so special logic is needed to convert dram to apb.
//
//                   For further details on this, one should read the Whistler
//                   PHY specification, and the respective block level
//                   specifications for the sub blocks instantiated in this
//                   module.
//
//-----------------------------------------------------------------------------

module dram2apb (
input         clk,
input         reset_n,
input  [15:0] addr,
input         en,
input         wr,
input  [31:0] wdata,
output        busy,
output reg [31:0] rdata,

input  [31:0] prdata,
input         pready,
output reg [15:0] paddr,
output reg [31:0] pwdata,
output        psel,
output        penable,
output reg        pwrite
);

reg  [2:0] apb_sm_current_state;
reg  [2:0] apb_sm_next_state;
reg        en_d;

localparam [2:0]
           APB_SM_IDLE = 3'b000,
           APB_SM_LOAD = 3'b001,
           APB_SM_SEL  = 3'b100,
           APB_SM_EN   = 3'b110,
           APB_SM_WAIT = 3'b111;

always @(negedge reset_n or posedge clk) begin
   if (!reset_n) begin
      apb_sm_current_state <= APB_SM_IDLE;
   end
   else begin
      apb_sm_current_state <= apb_sm_next_state;
   end
end

always @(*) begin
    apb_sm_next_state = apb_sm_current_state;

    case (apb_sm_current_state)
        APB_SM_IDLE : begin
            if (en == 1'b1) begin
                apb_sm_next_state = APB_SM_SEL;
            end
        end
        APB_SM_SEL : begin
            apb_sm_next_state = APB_SM_EN;
        end
        APB_SM_EN : begin
            if (pready == 1'b0) begin
                apb_sm_next_state = APB_SM_WAIT; 
            end
            // if current transaction is a write then it is finished and it is ok to proceed to new transaction
            // busy should go low
            // if current transaction is a read and the input transaction changed to write or addr was changed while in
            // at the last cycle of doing the apb access, start the new transaction without droping busy.
            // For a read the addr must be the same at the start and when it is finished to be valid data.
            // We don't want addr change during read to ever happen as it may be a destuctive read we just lost.
            else if (en == 1'b1) begin
                if ((paddr != addr) || (pwrite != wr) || (pwrite == 1'b1)) begin
                    apb_sm_next_state = APB_SM_SEL; 
                end
                else begin
                    apb_sm_next_state = APB_SM_IDLE;
                end
            end
            else if (pwrite == 1'b1) begin
                apb_sm_next_state = APB_SM_IDLE;
            end
            else begin
                apb_sm_next_state = APB_SM_LOAD;
            end
        end
        APB_SM_WAIT : begin
            if (pready == 1'b0) begin
                apb_sm_next_state = APB_SM_WAIT; 
            end
            // same comment as state above.
            else if (en == 1'b1) begin
                if ((paddr != addr) || (pwrite != wr) || (pwrite == 1'b1)) begin
                    apb_sm_next_state = APB_SM_SEL; 
                end
                else begin
                    apb_sm_next_state = APB_SM_IDLE;
                end
            end
            else if (pwrite == 1'b1) begin
                apb_sm_next_state = APB_SM_IDLE;
            end
            else begin
                apb_sm_next_state = APB_SM_LOAD;
            end
        end
        APB_SM_LOAD : begin
            if (en == 1'b1) begin
                if ((paddr != addr) || (pwrite != wr)) begin
                    apb_sm_next_state = APB_SM_SEL; 
                end
                else begin
                    apb_sm_next_state = APB_SM_IDLE;
                end
            end
            else begin
                apb_sm_next_state = APB_SM_LOAD;
            end
        end
    endcase
end

assign psel    = apb_sm_current_state[2];
assign penable = apb_sm_current_state[1];
// do not assert busy if this is a write and no other apb access is in flight
// writes are not speculative from xtensa and we will execute immediately
// do not use inputs from xtensa to make busy or there will be a combo loop
assign busy    = apb_sm_current_state[2] && en_d && !((apb_sm_current_state == APB_SM_SEL) && pwrite);

always @(negedge reset_n or posedge clk) begin
   if (!reset_n) begin
       en_d <= 1'b0;
   end
   else begin
       en_d <= en;
   end
end

always @(negedge reset_n or posedge clk) begin
   if (!reset_n) begin
      paddr   <= 16'd0;
      pwdata  <= 32'd0;
      pwrite  <= 1'b0;
   end
   else begin
      if ((apb_sm_next_state == APB_SM_SEL) && (en == 1'b1 )) begin
         paddr  <= addr;
         pwdata <= wdata;
         pwrite <= wr;
      end
   end
end

always @(negedge reset_n or posedge clk) begin
   if (!reset_n) begin
       rdata <= 32'b0;
   end
   else if (!pwrite && penable && pready) begin
       rdata <= prdata;
   end
end


endmodule

