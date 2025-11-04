
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
// Filename        : sram_initialize.v
// Version         : $Revision: $
// Date / Time     : $Date: $
//
// Author          : Dave Masters
// Abstract        : This block is used to initialize all of the sram to
//                   zero before loading the iram and dram image.
//                   This can allow sparse loading of only non zero values
//                   and shorten load timing of image.
//
//                   For further details on this, one should read the Whistler
//                   PHY specification, and the respective block level
//                   specifications for the sub blocks instantiated in this
//                   module.
//
//-----------------------------------------------------------------------------

module sram_initialize (
input              clk,
input              reset_n,
output reg  [14:0] addr,
output             en,
output             wr,
output      [31:0] wdata,

input              sram_init,
output             sram_init_done
);

reg  [1:0] sram_sm_current_state;
reg  [1:0] sram_sm_next_state;

localparam [1:0]
           SRAM_SM_IDLE  = 2'b00,
           SRAM_SM_WR    = 2'b01,
           SRAM_SM_DONE  = 2'b10;

always @(negedge reset_n or posedge clk) begin
   if (!reset_n) begin
      sram_sm_current_state <= SRAM_SM_IDLE;
   end
   else begin
      sram_sm_current_state <= sram_sm_next_state;
   end
end

always @(*) begin
    sram_sm_next_state = sram_sm_current_state;

    case (sram_sm_current_state)
        SRAM_SM_IDLE : begin
            if (sram_init == 1'b1) begin
                sram_sm_next_state = SRAM_SM_WR;
            end
        end
        SRAM_SM_WR : begin
            if (addr == 15'h7FFF) begin
                sram_sm_next_state = SRAM_SM_DONE; 
            end
            else begin
                sram_sm_next_state = SRAM_SM_WR; 
            end
        end
        SRAM_SM_DONE : begin
            if (sram_init == 1'b1) begin
                sram_sm_next_state = SRAM_SM_DONE; 
            end
            else begin
                sram_sm_next_state = SRAM_SM_IDLE; 
            end 
        end
    endcase
end

assign en             = sram_sm_current_state[0];
assign sram_init_done = sram_sm_current_state[1];
assign wr             = 1'b1;
assign wdata          = 32'd0;

always @(negedge reset_n or posedge clk) begin
   if (!reset_n) begin
      addr   <= 15'd0;
   end
   else begin
      if (sram_sm_current_state == SRAM_SM_IDLE) begin
          addr   <= 15'd0;
      end
      else if (addr == 15'h7FFF) begin
          addr <= addr;
      end
      else if (sram_sm_current_state == SRAM_SM_WR) begin
         addr  <= addr + 1'd1;
      end
   end
end


endmodule

