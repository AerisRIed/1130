package cdn_u4_pcie_package;
`include "uvm_macros.svh"
import uvm_pkg::*;
timeunit 1ns;
timeprecision 1fs;

import tb_param::*;
import clk_if_pkg::*;
import clk_pkg::*;
import serdes_pkg::*;
import cdn_phy_package::*;
import PCIE_LINK::*;

typedef virtual cdn_phy_interface_base#(
        .PD_WIDTH(tb_param::PD_WIDTH)
    ) cdn_phy_vif_t;

    `include"cdn_u4_pcie_transaction.sv"  
	`include"cdn_u4_pcie_params.sv"
	//`include"cdn_u4_pcie_port_types.sv"
	//`include"cdn_u4_pcie_port_configuration.sv"
	`include"cdn_u4_pcie_config.sv"
	`include"cdn_u4_pcie_symbol_pattern.sv"
	`include"cdn_u4_pcie_port_status.sv"
	`include"cdn_u4_pcie_ltssm_instruction.sv"
    `include"cdn_u4_pcie_instruction_sequence.sv"
    `include"cdn_u4_pcie_physical_timer_cfg.sv"
	`include"cdn_u4_pcie_ltssm_control.sv"
	`include"cdn_u4_pcie_ltssm_operation.sv"
	`include"cdn_u4_pcie_callbacks.sv"
    `include"cdn_u4_pcie_driver.sv"
    `include"cdn_u4_pcie_monitor.sv"
    `include"cdn_u4_pcie_sequencer.sv"
	`include"cdn_u4_pcie_virtual_sequencer.sv"
    `include"cdn_u4_pcie_agent.sv"
    `include"cdn_u4_pcie_scoreboard.sv"
    `include"cdn_u4_pcie_env.sv"
endpackage
