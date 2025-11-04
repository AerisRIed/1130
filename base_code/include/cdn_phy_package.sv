//
// Template for UVM-compliant verification environment
//
package cdn_phy_package;


`include "uvm_macros.svh"
import uvm_pkg::*;
import tb_param::*;
import clk_if_pkg::*;
import clk_pkg::*;
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
import cdn_reset_pkg::*;

typedef virtual cdn_phy_interface_base#(
        .PD_WIDTH(tb_param::PD_WIDTH)
    )cdn_phy_vif_t;

//`include "host_device_src.incl"
`include "cdn_phy_params.sv" 
`include "cdn_phy_defines.sv"
`include "cdn_phy_typedef.sv"
`include "cdn_phy_base_item.sv"
`include "cdn_phy_dut_config.sv"
`include "cdn_phy_tb_config.sv"
`include "cdn_phy_config_base.sv"
`include "cdn_phy_monitor_base.sv" 
`include "cdn_phy_sequencer_base.sv" 
`include "cdn_phy_virtual_sequencer_base.sv"
`include "cdn_phy_transaction_base.sv" 
`include "cdn_phy_driver_base.sv" 
`include "cdn_phy_agent_base.sv" 

//`include "cdn_phy_pwr_rate_ctrl_base.sv"

`include "cdn_phy_sequence_library.sv" 


`include "cdn_phy_scoreboard_base.sv"

`include "cdn_phy_cov.sv"

`include "mon_2cov.sv"


`include "ral_single.sv"
`include "ral_cdn_phy.sv"
`include "cdn_phy_env_base.sv"
// ToDo: Add additional required `include directives

endpackage
