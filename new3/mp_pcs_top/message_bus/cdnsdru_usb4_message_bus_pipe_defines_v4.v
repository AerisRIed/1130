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
//   Module Name    : cdnsdru_pcie_message_bus_pipe_defines_v4
//
//   Filename       : cdnsdru_pcie_message_bus_pipe_defines_v4.v
//
//   Author         : Thomas Faison
//
//   Date           : 30 November 2020
//
//   Limitations    :
//
//---------------------------------------------------------------------------------
//   Description    :	PCIe Message Bus Defines
//			This module contains the defines for the protocol implemented
//			by the message bus
//---------------------------------------------------------------------------------

//--------------------------------------------------------------------
// 		Message Bus Commands
//--------------------------------------------------------------------

`define MB_NOP			4'b0000
`define MB_WRITE_UNCOMMITTED	4'b0001
`define MB_WRITE_COMMITTED	4'b0010
`define MB_READ			4'b0011
`define MB_READ_COMPLETION	4'b0100
`define MB_WRITE_ACK		4'b0101

//--------------------------------------------------------------------
// 		Message Bus Address
//--------------------------------------------------------------------

`ifndef PAIR_1
 `define PAIR_OFFSET		12'h000
`else
 `define PAIR_OFFSET		12'h200
`endif

`define PHY_RX_MRGN_CTRL_0	12'h000 + `PAIR_OFFSET
`define PHY_RX_MRGN_CTRL_1	12'h001 + `PAIR_OFFSET
`define PHY_EL_BUF_CTRL		12'h002 + `PAIR_OFFSET
`define PHY_RX_CTRL_0		12'h003 + `PAIR_OFFSET
`define PHY_RX_CTRL_1		12'h004 + `PAIR_OFFSET
`define PHY_RX_CTRL_2		12'h005 + `PAIR_OFFSET
`define PHY_RX_CTRL_3		12'h006 + `PAIR_OFFSET
`define PHY_EL_BUF_LOC_UP_FRQ	12'h007 + `PAIR_OFFSET
`define PHY_RX_CTRL_4		12'h008 + `PAIR_OFFSET

`define PHY_TX_CTRL_0		12'h400 + `PAIR_OFFSET
`define PHY_TX_CTRL_1		12'h401 + `PAIR_OFFSET
`define PHY_TX_CTRL_2		12'h402 + `PAIR_OFFSET
`define PHY_TX_CTRL_3		12'h403 + `PAIR_OFFSET
`define PHY_TX_CTRL_4		12'h404 + `PAIR_OFFSET
`define PHY_TX_CTRL_5		12'h405 + `PAIR_OFFSET
`define PHY_TX_CTRL_6		12'h406 + `PAIR_OFFSET
`define PHY_TX_CTRL_7		12'h407 + `PAIR_OFFSET
`define PHY_TX_CTRL_8		12'h408 + `PAIR_OFFSET
`define PHY_TX_CTRL_9		12'h409 + `PAIR_OFFSET

`define PHY_CMN_CTRL_0       	12'h800 + `PAIR_OFFSET
`define PHY_NEL_CTRL_0       	12'h801 + `PAIR_OFFSET

`define MAC_RX_MRGN_STAT_0	12'h000 + `PAIR_OFFSET
`define MAC_RX_MRGN_STAT_1	12'h001 + `PAIR_OFFSET
`define MAC_RX_MRGN_STAT_2	12'h002 + `PAIR_OFFSET
`define MAC_EL_BUF_STAT      	12'h003 + `PAIR_OFFSET
`define MAC_EL_BUF_LOC      	12'h004 + `PAIR_OFFSET
`define MAC_RX_STAT_0      	12'h005 + `PAIR_OFFSET
`define MAC_RX_CTRL_0      	12'h006 + `PAIR_OFFSET
`define MAC_LINK_EVAL_STAT_0  	12'h00A + `PAIR_OFFSET
`define MAC_LINK_EVAL_STAT_1  	12'h00B + `PAIR_OFFSET
`define MAC_RX_STAT_4      	12'h00C + `PAIR_OFFSET
`define MAC_RX_STAT_5      	12'h00D + `PAIR_OFFSET
`define MAC_LINK_EVAL_STAT_2  	12'h00E + `PAIR_OFFSET
`define MAC_LINK_EVAL_STAT_3  	12'h00F + `PAIR_OFFSET

`define MAC_TX_STAT_0      	12'h400 + `PAIR_OFFSET
`define MAC_TX_STAT_1      	12'h401 + `PAIR_OFFSET
`define MAC_TX_STAT_2      	12'h402 + `PAIR_OFFSET
`define MAC_TX_STAT_3      	12'h403 + `PAIR_OFFSET
`define MAC_TX_STAT_4      	12'h404 + `PAIR_OFFSET
`define MAC_TX_STAT_5      	12'h405 + `PAIR_OFFSET
`define MAC_TX_STAT_6      	12'h406 + `PAIR_OFFSET
`define MAC_TX_STAT_7      	12'h407 + `PAIR_OFFSET
`define MAC_TX_STAT_8      	12'h408 + `PAIR_OFFSET
`define MAC_TX_STAT_9      	12'h409 + `PAIR_OFFSET

//--------------------------------------------------------------------
// PMA Margining Direction Parameters
//--------------------------------------------------------------------

`define PMA_MRGN_DIR_NORTH 	2'b00 
`define PMA_MRGN_DIR_EAST 	2'b01 
`define PMA_MRGN_DIR_SOUTH 	2'b11
`define PMA_MRGN_DIR_WEST 	2'b10 

