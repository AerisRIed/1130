//------------------------------------------------------------------------------
//
//                   Copyright (c) 2016
//                   Cadence Design Systems, Inc.
//                   All rights reserved.
//
//  This work may not be copied, modified, re-published, uploaded, executed, or
//  distributed in any way, in any medium, whether in whole or in part, without
//  prior written permission from Cadence Design Systems, Inc.
//------------------------------------------------------------------------------
//
//   Module Name    : cdnsdru_usb4_message_bus_link_eval_stat_regs_v4
//
//   Author         : Dongdong Wang
//
//   Date           : July 23, 2025
//
//   Limitations    :
//
//   Notes          : Based on cdnsdru_pcie_message_bus_io_recal_v4 authored by Thomas Faison
//---------------------------------------------------------------------------------
//   Description    :	Handle interface for IORecal function
//			Manage signals between PHY and MB registers:
//			   * Accept signal from PHY to make recal request
//			   * When recal request comes from MAC send recal signal to PHY
//			   * When PHY completes recal trigger RecalDone transmission to MAC
//
//---------------------------------------------------------------------------------

module cdnsdru_usb4_message_bus_io_recal_v4 (

input			pipe_mac2phy_clk,		// PHY: MB Clock based on PIPE interface data width --> 500MHz (32-bit) or 1GHz (16-bit)
input			pipe_mac2phy_rstn,		// PHY: MB Reset. Active Low
input			mb_enable,			// PHY: MB Enable when PCIe Gen4 and P0 state

input			cdb_reset,			// PHY CDB: Soft Reset for entire MB block including all sub-blocks
input			cdb_ctrl_reset,		        // PHY CDB: Soft Reset for entire MB Controller

input			p2m_recal_req,  	        // PHY: Trigger to request recal request (to MB)
input			phy_recal_done,  	        // PHY: Recal done indication (to MB)

input			rx_m2p_recal_req,  	        // Gen reg ctrl: MAC has requested recal (via MB register)


input			phyiorecalreq_sent,  	        // Gen reg ctrl: request has been sent over MB
input			iorecaldone_sent,  	        // Gen reg ctrl: done has been sent over MB

input [1:0] 		prio_tx_writes_done_ior,


output reg 		m2p_recal_req,		        // PHY: Tell PHY to start recal (from MB/MAC)
output reg 		phyiorecalreq_tx_write,	        // Gen reg ctrl: Trigger to request recal (towards MAC)
output reg 		iorecaldone_tx_write	        // Gen reg ctrl: Trigger to send recal_done (towards MAC)

);
/*
 Expected flow for the IORecal-related signals:
 
 1. PHY triggers recovery (PHY interface)
 2. MB performs TX of MAC RX Control0[0]
 3. MAC makes IORecal request (MB sees RX of PHY RX Control1[1])
 4. MB informs PHY of request
 5. PHY does IO recal
 6. PHY indicates IO recal done
 7. MB performs TX of MAC RX Status0[1]
 
 Algorithm for this block:
 -- Get req from PHY/Create trigger (using p2m_recal_req)
 -- Assert phyiorecalreq_tx_write
 -- When write made (phyiorecalreq_sent), deassert phyiorecalreq_tx_write
 -- When RX received (rx_m2p_recal_req), assert m2p_recal_req
 -- Wait for phy_recal_done/create trigger
 -- assert iorecaldone_tx_write to generate TX
 -- when iorecaldone_sent deassert
*/

//--------------------------------------------------------------------
// Local variables
//--------------------------------------------------------------------

reg 		p2m_recal_req_d1;
reg 	[2:0]	p2m_recal_req_next_state;
reg 	[2:0] 	p2m_recal_req_state;
reg 	[2:0]	m2p_recal_req_next_state;
reg 	[2:0] 	m2p_recal_req_state;
reg 		m2p_recal_req_comb;

wire 		posedge_p2m_recal_req;
wire    	ctrl_soft_reset;

//--------------------------------------------------------------------
// FSM Parameters
//--------------------------------------------------------------------

   localparam P2M_REQ_IDLE	= 3'b000;
   localparam P2M_REQ_WR_START	= 3'b001;
   localparam P2M_REQ_WR	= 3'b010;

   localparam M2P_RCAL_IDLE = 3'b000;
   localparam M2P_RCAL_START = 3'b001;
   localparam M2P_RCAL_WAIT = 3'b010;
   localparam P2M_RCAL_WAIT1 = 3'b011;
   localparam P2M_RCAL_WAIT2 = 3'b100;

//--------------------------------------------------------------------
// Resets
//--------------------------------------------------------------------

   assign ctrl_soft_reset = (~mb_enable | cdb_reset | cdb_ctrl_reset);

//--------------------------------------------------------------------
// Update state machine state
//
// Generate trigger for PHY-to-MAC Recal request from the rising edge
// of the recal-request register bit (written by the MAC to the PHY)
//--------------------------------------------------------------------

   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  begin
	     p2m_recal_req_d1 <= 1'b0;
	     p2m_recal_req_state <= P2M_REQ_IDLE;
	     m2p_recal_req_state <= M2P_RCAL_IDLE;
	     m2p_recal_req <= 1'b0;
	  end
	else if (ctrl_soft_reset)
	  begin
	     p2m_recal_req_d1 <= 1'b0;
	     p2m_recal_req_state <= P2M_REQ_IDLE;
	     m2p_recal_req_state <= M2P_RCAL_IDLE;
	     m2p_recal_req <= 1'b0;
	  end
	else
	  begin
	     p2m_recal_req_d1 <= p2m_recal_req;
	     p2m_recal_req_state <= p2m_recal_req_next_state;
	     m2p_recal_req_state <= m2p_recal_req_next_state;
	     m2p_recal_req <= m2p_recal_req_comb;
	  end
     end

   assign posedge_p2m_recal_req = p2m_recal_req & ~p2m_recal_req_d1;

//--------------------------------------------------------------------
// FSM for PHY-to-MAC recal req
// When PHY gives the trigger for the rcal request we will request a
// write to the MAC. Once the write is sent we will go back to the IDLE
// state
//--------------------------------------------------------------------

   always @*
     begin
	p2m_recal_req_next_state = 3'h0;

	case (p2m_recal_req_state)

	  //Start cycle based on eval bit being written
	  P2M_REQ_IDLE:
	    begin
	       phyiorecalreq_tx_write = 1'b0;
	       if (posedge_p2m_recal_req)
		  p2m_recal_req_next_state = P2M_REQ_WR_START;
	       else
		  p2m_recal_req_next_state = P2M_REQ_IDLE;
	    end

	  // Set write-request bit for the reg controller. Stay in this state
	  // until we are told that the write has begun.
	  P2M_REQ_WR_START:
	    begin
	       phyiorecalreq_tx_write = 1'b1;
	       if (phyiorecalreq_sent)
		 begin
		    p2m_recal_req_next_state = P2M_REQ_WR;
		 end
	       else
		 begin
		    p2m_recal_req_next_state = P2M_REQ_WR_START;
		 end
	    end

	  // Keep the write request on untilTX tells us that the write is complete.
	  P2M_REQ_WR:
	    begin
	       phyiorecalreq_tx_write = 1'b1;
	       if (prio_tx_writes_done_ior[0])
		 begin
		    p2m_recal_req_next_state = P2M_REQ_IDLE;
		 end
	       else
		 begin
		    p2m_recal_req_next_state = P2M_REQ_WR;
		 end
	    end

	  default:
	    begin
	       phyiorecalreq_tx_write = 1'b0;
	       p2m_recal_req_next_state = P2M_REQ_IDLE;
	    end
	endcase

     end

//--------------------------------------------------------------------
// MAC-to-PHY IORecal request
// The reg controller will inform us when the PHY RX sees the IORecal
// request bit go high. We need to convert that to a signal that the
// PHY can use.
//--------------------------------------------------------------------

   always @*
     begin
	m2p_recal_req_next_state = 3'h0;

	case (m2p_recal_req_state)

	  //Start cycle when PHY RX gets 1-cycle recal req bit
	  M2P_RCAL_IDLE:
	    begin
	       m2p_recal_req_comb = 1'b0;
	       iorecaldone_tx_write = 1'b0;
	       if (rx_m2p_recal_req)
		  m2p_recal_req_next_state = M2P_RCAL_START;
	       else
		  m2p_recal_req_next_state = M2P_RCAL_IDLE;
	    end

	  // Tell the PHY that the MAC is requesting a recal
	  M2P_RCAL_START:
	    begin
	       iorecaldone_tx_write = 1'b0;
	       m2p_recal_req_comb = 1'b1;
	       m2p_recal_req_next_state = M2P_RCAL_WAIT;
	    end

	  // Wait until the PHY has finished the recal
	  M2P_RCAL_WAIT:
	    begin
	       iorecaldone_tx_write = 1'b0;
	       if (phy_recal_done)
		 begin
		    m2p_recal_req_comb = 1'b0;
		    m2p_recal_req_next_state = P2M_RCAL_WAIT1;
		 end
	       else
		 begin
		    m2p_recal_req_comb = 1'b1;
		    m2p_recal_req_next_state = M2P_RCAL_WAIT;
		 end
	    end

	  // Now make a write request to send recal status to the MAC
	  P2M_RCAL_WAIT1:
	    begin
	       m2p_recal_req_comb = 1'b0;
	       iorecaldone_tx_write = 1'b1;
	       if (iorecaldone_sent)
		 begin
		    m2p_recal_req_next_state = P2M_RCAL_WAIT2;
		 end
	       else
		 begin
		    m2p_recal_req_next_state = P2M_RCAL_WAIT1;
		 end
	    end

	  // Keep the write request on until TX tells us that the write is complete.
	  P2M_RCAL_WAIT2:
	    begin
	       m2p_recal_req_comb = 1'b0;
	       iorecaldone_tx_write = 1'b1;
	       if (prio_tx_writes_done_ior[1])
		 begin
		    m2p_recal_req_next_state = M2P_RCAL_IDLE;
		 end
	       else
		 begin
		    m2p_recal_req_next_state = P2M_RCAL_WAIT2;
		 end
	    end

	  default:
	    begin
	       iorecaldone_tx_write = 1'b0;
	       m2p_recal_req_comb = 1'b0;
	       m2p_recal_req_next_state = M2P_RCAL_IDLE;
	    end
	endcase

     end


endmodule

