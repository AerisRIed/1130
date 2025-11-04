package cdn_u4_dp_package;
`include "uvm_macros.svh"
import uvm_pkg::*;

import tb_param::*;
import clk_if_pkg::*;
import clk_pkg::*;
import serdes_pkg::*;
import cdn_phy_package::*;
    `include"cdn_u4_dp_config.sv"
    `include"cdn_u4_dp_transaction.sv"
    `include"cdn_u4_dp_driver.sv"
    `include"cdn_u4_dp_monitor.sv"
    `include"cdn_u4_dp_sequencer.sv"
    `include"cdn_u4_dp_virtual_sequencer.sv"
    `include"cdn_u4_dp_agent.sv"
    `include"cdn_u4_dp_scoreboard.sv"
    `include"cdn_u4_dp_env.sv"
endpackage
