//------------------------------------------------------------------------------
//
//   Filename:           cdn_message_bus_interface.sv
//   Module Name:        cdn_message_bus_interface
//
//   Release Revision:   1.0
//
//   Product Type:       Configurable
//   Protocol:           PIPE
//   Architecture:       PHY
//
//------------------------------------------------------------------------------
// Description: 
// This file defines the agent for the cdn_meassage_bus UVC.
//----------------------------------------------------------------------------

`ifndef CDN_MESSAGE_BUS_INTERFACE
`define CDN_MESSAGE_BUS_INTERFACE

interface cdn_message_bus_interface (input pclk);
import cdn_message_bus_pkg::*;

tx_state_t        tx_state;
rx_state_t        rx_state;
bit pclk;
bit reset;
bit [7:0]m2p_message_bus;
bit [7:0]p2m_message_bus;

message_bus_cmd_t cmd_out;
bit [7:0]data_out;
bit [11:0]addr_out;
message_bus_cmd_t cmd_in;
bit [7:0]data_in;
bit [11:0]addr_in;
bit wait_ack_en;
/*
initial begin
/////test write_ack//////////////////////
#375ns;
@(posedge pclk)
p2m_message_bus='b0101_0000;
@(posedge pclk)
p2m_message_bus='b0000_0000;
#100ns;
/////test write_committed/uncommitted//////////////////////
#1fs;
@(posedge pclk)
p2m_message_bus='b0001_0001;
@(posedge pclk)
p2m_message_bus='b0000_0001;
@(posedge pclk)
p2m_message_bus='b0000_1111;
//@(posedge pclk)
//p2m_message_bus='b0000_0000;
//@(posedge pclk)
//p2m_message_bus='b0000_0000;
@(posedge pclk)
p2m_message_bus='b0001_0011;
@(posedge pclk)
p2m_message_bus='b0000_0011;
@(posedge pclk)
p2m_message_bus='b0001_1111;
//@(posedge pclk)
//p2m_message_bus='b0000_0000;
@(posedge pclk)
p2m_message_bus='b0010_0111;
@(posedge pclk)
p2m_message_bus='b0000_1111;
@(posedge pclk)
p2m_message_bus='b0011_1111;
@(posedge pclk)
p2m_message_bus='b0000_0000;
/////test write_complete//////////////////////
#470ns;
#1fs;
@(posedge pclk)
p2m_message_bus='b0100_0000;
@(posedge pclk)
p2m_message_bus='b0011_1111;
@(posedge pclk)
p2m_message_bus='b0000_0000;



end
*/
endinterface:cdn_message_bus_interface

`endif
