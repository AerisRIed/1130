
package cdn_u4_usb32_package;
`include "uvm_macros.svh"
import uvm_pkg::*;
timeunit 1ns;
timeprecision 1fs;

import tb_param::*;
import clk_if_pkg::*;
import clk_pkg::*;
import serdes_pkg::*;
import USB32_LINK::*;
   
parameter int TSEQ_NUM_GEN1 = 2000;
parameter int TSEQ_NUM_GEN2 = 2000;
parameter bit[7:0] IDLE_SYMBOL_GEN1 = 8'h00;
parameter bit[7:0] IDLE_SYMBOL_GEN2 = 8'h5A;
parameter bit[3:0] P0_STATE = 4'b0000;
parameter bit[3:0] P1_STATE = 4'b0001;
parameter bit[3:0] P2_STATE = 4'b0010;
parameter bit[3:0] P3_STATE = 4'b0011;
parameter bit[7:0] SUB  = 8'h9c;
parameter bit[7:0] COM  = 8'hbc;
parameter bit[7:0] BRST = 8'hfc;
parameter bit[7:0] BERC = 8'h7c;
parameter bit[7:0] SKP_GEN1 = 8'h3C; 
parameter bit[7:0] SKP_GEN2     = 8'h33; 
parameter bit[7:0] SKP_GEN2_END = 8'hcc; 
parameter bit[3:0] DATA_BLOCK_HEADER = 4'b0011;//TODO may be check 
parameter bit[3:0] CTRL_BLOCK_HEADER = 4'b1100;
parameter bit[131:0] SYNC = {4'b0011,128'h00ff_00ff_00ff_00ff_00ff_00ff_00ff_00ff};
parameter bit[3:0] USB = 1; 
parameter bit[15:0] LFSR_LANE0 = 16'hFFFF; 
//parameter bit[15:0] LFSR_LANE1 = 16'hFFFF; 
parameter bit[15:0] LFSR_LANE1 = 16'h8000; 
parameter bit[22:0] LFSR_GEN2_LANE0 = 23'h1DBFBC; 
parameter bit[22:0] LFSR_GEN2_LANE1 = 23'h0607BB; 


typedef virtual cdn_phy_interface_base#(
        .PD_WIDTH(tb_param::PD_WIDTH)
    ) cdn_phy_vif_t;

import cdn_phy_package::*;
    `include"cdn_u4_usb32_transaction.sv" //
    `include"cdn_u4_usb32_scoreboard.sv" //
    //`include"cdn_u4_usb32_port_types.sv"
    `include"cdn_u4_usb32_config.sv"
    `include"cdn_u4_usb32_transmitter_transaction.sv"
    `include"cdn_u4_usb32_symbol_pattern.sv"
    `include"callback_demo.sv" //not used
    `include"cdn_u4_usb32_ltssm_instruction.sv"
    `include"cdn_u4_usb32_port_status.sv"
    //`include"cdn_u4_usb32_instruction_sequence.sv"
    `include"cdn_u4_usb32_physical_timer_cfg.sv"
    `include"cdn_u4_usb32_ltssm_control.sv"
    `include"cdn_u4_usb32_ltssm_operation.sv"
    `include"cdn_u4_usb32_driver.sv"
    `include"cdn_u4_usb32_sequencer.sv"
    `include"cdn_u4_usb32_virtual_sequencer.sv"
    `include"cdn_u4_usb32_instruction_sequence.sv"
    `include"cdn_u4_usb32_monitor.sv"
    `include"cdn_u4_usb32_agent.sv"
    `include"cdn_u4_usb32_env.sv"
    `include"usb32_sequence_item_lib.sv"
endpackage
