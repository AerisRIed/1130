package cdn_u4_usb4_package;
`include "uvm_macros.svh"
import uvm_pkg::*;
timeunit 1ns;
timeprecision 1fs;

import tb_param::*;
import clk_if_pkg::*;
import clk_pkg::*;
import serdes_pkg::*;
import USB4_LINK::*;
 import cdn_message_bus_pkg::*;  
parameter int TS1_SENT_NUM_GEN2 = 32;
parameter int TS2_SENT_NUM_GEN2 = 16;
parameter int TS1_SENT_NUM_GEN3 = 16;
parameter int TS2_SENT_NUM_GEN3 = 8;
parameter bit[3:0] P0_STATE = 4'b0000;
parameter bit[3:0] P1_STATE = 4'b0001;
parameter bit[3:0] P2_STATE = 4'b0010;
parameter bit[3:0] P3_STATE = 4'b0011;
parameter bit[3:0] USB4 = 7;
parameter bit[22:0] LFSR_LANE0= 23'h1DBFBC;
parameter bit[22:0] LFSR_LANE1= 23'h0607BB;


typedef virtual cdn_phy_interface_base#(
        .PD_WIDTH(tb_param::PD_WIDTH)
    ) cdn_phy_vif_t;

import cdn_phy_package::*;
    `include"cdn_u4_usb4_transaction.sv" //not used
    `include"cdn_u4_usb4_scoreboard.sv" //not used
    //`include"cdn_u4_usb4_port_types.sv"
    `include"cdn_u4_usb4_config.sv"
    `include"cdn_u4_usb4_symbol_pattern.sv"
    `include"cdn_u4_usb4_ltssm_instruction.sv"
    `include"cdn_u4_usb4_port_status.sv"
    //`include"cdn_u4_usb4_instruction_sequence.sv"
    `include"cdn_u4_usb4_physical_timer_cfg.sv"
    `include"cdn_u4_usb4_ltssm_control.sv"
    `include"cdn_u4_usb4_ltssm_operation.sv"
    `include"cdn_u4_usb4_driver.sv"
    `include"cdn_u4_usb4_sequencer.sv"
    `include"cdn_u4_usb4_virtual_sequencer.sv"
    `include"cdn_u4_usb4_instruction_sequence.sv"
    `include"cdn_u4_usb4_monitor.sv"
    `include"cdn_u4_usb4_agent.sv"
    `include"cdn_u4_usb4_env.sv"
    `include"usb4_sequence_item_lib.sv"
   
endpackage
