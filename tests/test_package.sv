package test_package;
`include "uvm_macros.svh"
    timeunit 1ns;
    timeprecision 1fs;
import uvm_pkg::*;
import tb_param::*;
import clk_if_pkg::*;
import clk_pkg::*;
import cdn_reset_pkg::*;
// Include the VIP UVM base classes
//  import cdnAxiUvm::*;
//  import cdnOcpUvm::*;
// Import the DDVAPI CDN_AXI SV interface and the generic Mem interface
import DenaliSvCdn_apb::*;
import DenaliSvMem::*;
// Include the VIP UVM base classes
import cdnApbUvm::*;
//import cdn_usb4_phy_top_reg_pkg::*; // TODO
// Import the cdn usb4 UVC Package
//import math_pkg::*; // TODO
import cdn_jtag_pkg::*;
import cdn_jtag_1687_pkg::*;
import serdes_pkg::*;
import cdn_phy_package::*;

`ifdef DENALI_USB4_VIP
  import cdnUsb4Uvm::*;
  import DenaliSvPipephy::*;
  import cdnPipephyUvm::*;
  `include "cdnUsb4UvmUserTop.sv"
  `include"cdn_u4_vip_sequence_lib.sv"
`endif 

//sequence//
    `include "cdn_phy_test_base.sv"  //ToDo: Change this name to the testcase file-name
`ifndef DUT_BYPASS
    `include"cdn_phy_bring_up_seq_lib.sv"
    `include"cdn_phy_bring_up_test_lib.sv" 
`endif
`ifdef USB32
    import cdn_u4_usb32_package::*;
    `include"cdn_u4_usb32_sequence_lib.sv"
    `include"cdn_u4_usb32_testcase_lib.sv"
`elsif USB4
    import cdn_u4_usb4_package::*;
    `include"cdn_u4_usb4_testcase_lib.sv"
	import cdn_message_bus_pkg::*;
	`include"cdn_message_bus_sequence_lib.sv"
    `include"cdn_pipe_message_bus_testcase_lib.sv"

`elsif PCIE
    import cdn_u4_pcie_package::*;
    `include"cdn_u4_pcie_sequence_lib.sv"
    `include"cdn_u4_pcie_testcase_lib.sv"
`elsif DP
    import cdn_u4_dp_package::*;
    `include"cdn_u4_dp_sequence_lib.sv"
    `include"cdn_u4_dp_testcase_lib.sv"
`elsif ALT_MODE
     import cdn_u4_usb32_package::*;
     import cdn_u4_dp_package::*;
    `include"cdn_u4_usb32_sequence_lib.sv"
    `include"cdn_u4_usb32_testcase_lib.sv"
    `include"cdn_u4_dp_sequence_lib.sv"
    `include"cdn_u4_dp_testcase_lib.sv"
    `include"cdn_alt_mode_phy_testcase_lib.sv"
`endif
    //`include"cdn_alt_mode_phy_testcase_lib.sv"
`ifndef DUT_BYPASS
    `include"cdn_usb_phy_reg_seq_lib.sv"
    `include"cdn_usb_phy_reg_test_lib.sv"
`endif
endpackage
