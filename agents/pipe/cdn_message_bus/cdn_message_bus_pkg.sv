`ifndef CDN_MESSAGE_BUS_PKG_SV
`define CDN_MESSAGE_BUS_PKG_SV
  
package cdn_message_bus_pkg;

    //------------------------------------------------------------------------
    // IMPORT UVM PACKAGE
    //------------------------------------------------------------------------
    // UVM class library compiled in a package
    import uvm_pkg::*;
    import tb_param::*;
    import clk_if_pkg::*;
    import clk_pkg::*;
    import cdn_phy_package::*;
    // Bring in the rest of the library (macros)
    `include "uvm_macros.svh"

    //------------------------------------------------------------------------
    // Import the files which comprise this UVC
    //------------------------------------------------------------------------

typedef virtual cdn_phy_interface_base#(
        .PD_WIDTH(tb_param::PD_WIDTH)
    ) cdn_phy_vif_t;

	`include "cdn_message_bus_define.sv"
	`include "cdn_message_bus_typedef.sv"
    `include "cdn_message_bus_transaction.sv"
    `include "cdn_message_bus_driver.sv"
	`include "cdn_message_bus_monitor.sv"
    `include "cdn_message_bus_sequencer.sv"
    `include "cdn_message_bus_agent.sv"
	
	


endpackage : cdn_message_bus_pkg

`endif
//----------------------------------------------------------------------------
// End of file
//----------------------------------------------------------------------------
