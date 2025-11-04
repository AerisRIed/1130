
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
// Filename        : apb2sram.v
// Version         : $Revision: $
// Date / Time     : $Date: $
//
// Author          : Dave Masters
// Abstract        : This block is used to convert the ARM AMBA APB interface to
//                   a SRAM interface. The SRAM is assumed to perform writes
//                   immediately and return reads on next clock cycle.
//                   Word addressing is used.
//
//                   For further details on this, one should read the Whistler
//                   PHY specification, and the respective block level
//                   specifications for the sub blocks instantiated in this
//                   module.
//
//-----------------------------------------------------------------------------

module apb2sram (
input              clk,
input              reset_n,
output reg  [14:0] addr,
output             en,
output reg         wr,
output reg  [31:0] wdata,
input       [31:0] rdata,

output reg  [31:0] prdata,
output             pready,
input       [15:0] paddr,
input       [31:0] pwdata,
input              psel,
input              penable,
input              pwrite
);

reg  [2:0] apb_sm_current_state;
reg  [2:0] apb_sm_next_state;

localparam [2:0]
           APB_SM_IDLE    = 3'b000,
           APB_SM_RD      = 3'b010,
           APB_SM_RD_DONE = 3'b110,
           APB_SM_WR      = 3'b011,
           APB_SM_READY   = 3'b001,
           APB_SM_WAIT    = 3'b100;

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
            if (psel == 1'b1 && penable == 1'b1 && pwrite == 1'b0) begin
                apb_sm_next_state = APB_SM_RD;
            end
            else if (psel == 1'b1 && penable == 1'b1 && pwrite == 1'b1) begin
                apb_sm_next_state = APB_SM_WR;
            end
        end
        APB_SM_RD : begin
            apb_sm_next_state = APB_SM_RD_DONE; 
        end
        APB_SM_RD_DONE : begin
            apb_sm_next_state = APB_SM_READY; 
        end
        APB_SM_WR : begin
            apb_sm_next_state = APB_SM_WAIT; 
        end
        APB_SM_READY : begin
            apb_sm_next_state = APB_SM_WAIT; 
        end
        APB_SM_WAIT : begin
            if (penable == 1'b1) begin
                apb_sm_next_state = APB_SM_WAIT; 
            end
            else begin
                apb_sm_next_state = APB_SM_IDLE; 
            end 
        end
    endcase
end

assign en     = (apb_sm_current_state == APB_SM_RD) || (apb_sm_current_state == APB_SM_WR);
assign pready = apb_sm_current_state[0];

always @(negedge reset_n or posedge clk) begin
   if (!reset_n) begin
      addr   <= 15'd0;
      wdata  <= 32'd0;
      wr     <= 1'b0;
   end
   else begin
      if ((apb_sm_current_state == APB_SM_IDLE) && (psel == 1'b1 )) begin
         addr  <= paddr[14:0];
         wdata <= pwdata;
         wr    <= pwrite;
      end
   end
end

always @(negedge reset_n or posedge clk) begin
   if (!reset_n) begin
       prdata <= 32'b0;
   end
   else if (apb_sm_current_state == APB_SM_RD_DONE) begin
       prdata <= rdata;
   end
   else begin
       prdata <= 32'd0;
   end
end


endmodule

