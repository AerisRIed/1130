package tb_param;
   `define DUT_SRAM_PATH "cdn_phy_tb_top.u_sram_wrap"
   `define FIRMWARE_PATH "$PHY_VERIF_AREA/firmware/"
   `define SERDES_WIDTH 8
   `define PCLK 125
   `define APB_DELAY #1
    
   parameter NUM_CLK_EN = 16;
   // 0:PCLK, 1:SSC PCLK,  2:ref clk,  3:apb clk,  4:jtag clk,  5:ijtag 1687 clk,  6:uc_clk,  7:ref clk1. Host
   // 8:PCLK, 9:SSC PCLK, 10:ref clk, 11:apb clk, 12:jtag clk, 13:ijtag 1687 clk, 14:uc_clk, 15:ref clk1. Device

   parameter APB_ADDR_WIDTH = 18; 
   parameter APB_DATA_WIDTH = 32;

   parameter PD_WIDTH = `PD_WIDTH;    //for PIPE_PD_WIDTH, Serdes: 10 20 40...  Original: 8,16,32..
   parameter SYMBOL_WIDTH = 8; //Serdes is 10, Original is 8
   parameter SERDES_WIDTH = 40; //gen1 is 40 gen2 is 32 
   parameter PCLK = `PCLK; //gen1 is 125 gen2 is 312.5 
   
   parameter USB4_LANE_NUM = 2;
   parameter PCIE_LANE_NUM = 2;
   parameter LANE_NUM = 2;
   parameter MAX_LANE_NUM = 4;
   `ifndef ALT_MODE 
   parameter USB32_LANE_NUM = 2;
   parameter DP_LANE_NUM = 4;
   `else
   parameter USB32_LANE_NUM = 1;
   parameter DP_LANE_NUM = 2;
   `endif
/*{{{*/
`define GEN_INTERFACE(PROTOCOL_NAME_CAPITAL,PROTOCOL_NAME) \
genvar i; \
generate \
   for(i = 0; i< tb_param::``PROTOCOL_NAME_CAPITAL``_LANE_NUM; i++) begin  : ``PROTOCOL_NAME``_interface \
       cdn_phy_interface_base #(.PD_WIDTH(tb_param::PD_WIDTH)) ``PROTOCOL_NAME``_host_if(clk_io.drv_clk_gen[0],rst); \
       cdn_phy_interface_base #(.PD_WIDTH(tb_param::PD_WIDTH)) ``PROTOCOL_NAME``_devc_if(clk_io.drv_clk_gen[0],rst); \
        initial begin \
          uvm_config_db #(cdn_phy_vif_t)::set(null,`"uvm_test_top.``PROTOCOL_NAME``_env.host_agent`",$psprintf(`"m_agt_if[%0d]`",i),cdn_phy_tb_top.``PROTOCOL_NAME``_interface[i].``PROTOCOL_NAME``_host_if); \
		  uvm_config_db #(cdn_phy_vif_t)::set(null,`"uvm_test_top.``PROTOCOL_NAME``_env.message_bus_agt`",$psprintf(`"m_agt_if[%0d]`",i),cdn_phy_tb_top.``PROTOCOL_NAME``_interface[i].``PROTOCOL_NAME``_host_if); \
		  uvm_config_db #(cdn_phy_vif_t)::set(null,`"uvm_test_top.``PROTOCOL_NAME``_env.reset_agent`",$psprintf(`"m_agt_if[%0d]`",i),cdn_phy_tb_top.``PROTOCOL_NAME``_interface[i].``PROTOCOL_NAME``_host_if); \
          uvm_config_db #(cdn_phy_vif_t)::set(null,`"uvm_test_top.``PROTOCOL_NAME``_env.device_agent`",$psprintf(`"m_agt_if[%0d]`",i),cdn_phy_tb_top.``PROTOCOL_NAME``_interface[i].``PROTOCOL_NAME``_devc_if); \
          uvm_config_db #(cdn_phy_vif_t)::set(null,`"uvm_test_top.``PROTOCOL_NAME``_env.device_reset_agent`",$psprintf(`"m_agt_if[%0d]`",i),cdn_phy_tb_top.``PROTOCOL_NAME``_interface[i].``PROTOCOL_NAME``_devc_if); \
        end \
   end \
endgenerate \
initial begin \
  uvm_config_db#(virtual interface cdnApb3MasterInterface#(.NUM_OF_SLAVES(1),.ADDRESS_WIDTH(18),.DATA_WIDTH(32)))::set(null,`"uvm_test_top.``PROTOCOL_NAME``_env.apb_mst_agent*`", `"vif`", apb_mst_if.master); \
  uvm_config_db#(virtual cdn_jtag_interface)::set(null,`"uvm_test_top.``PROTOCOL_NAME``_env.jtag_agent.jtag_drv`", `"jtag_if`", jtag_if); \
  uvm_config_db#(virtual cdn_jtag_1687_interface)::set(null,`"uvm_test_top.``PROTOCOL_NAME``_env.host_1687_jtag_agent.jtag_1687_drv`", `"jtag_1687_if`", host_1687_jtag_if); \
  uvm_config_db#(virtual interface cdnApb3MasterInterface#(.NUM_OF_SLAVES(1),.ADDRESS_WIDTH(18),.DATA_WIDTH(32)))::set(null,`"uvm_test_top.``PROTOCOL_NAME``_env.device_apb_mst_agent*`", `"vif`", device_apb_mst_if.master); \
  uvm_config_db#(virtual cdn_jtag_interface)::set(null,`"uvm_test_top.``PROTOCOL_NAME``_env.device_jtag_agent.jtag_drv`", `"jtag_if`", device_jtag_if); \
  uvm_config_db#(virtual cdn_jtag_1687_interface)::set(null,`"uvm_test_top.``PROTOCOL_NAME``_env.device_1687_jtag_agent.jtag_1687_drv`", `"jtag_1687_if`", device_1687_jtag_if); \
end

`define GEN_DOUBLE_INTERFACE(PROTOCOL_NAME_CAPITAL,PROTOCOL_NAME,PROTOCOL_NAME_CAPITAL_1,PROTOCOL_NAME_1) \
genvar i; \
generate \
   for(i = 0; i< tb_param::``PROTOCOL_NAME_CAPITAL``_LANE_NUM; i++) begin  : ``PROTOCOL_NAME``_interface \
       cdn_phy_interface_base #(.PD_WIDTH(tb_param::PD_WIDTH)) ``PROTOCOL_NAME``_host_if(clk_io.drv_clk_gen[0],rst,1); \
       cdn_phy_interface_base #(.PD_WIDTH(tb_param::PD_WIDTH)) ``PROTOCOL_NAME``_devc_if(clk_io.drv_clk_gen[0],rst,1); \
        initial begin \
          uvm_config_db #(cdn_phy_vif_t)::set(null,`"uvm_test_top.``PROTOCOL_NAME``_test.``PROTOCOL_NAME``_env.host_agent`",$psprintf(`"``PROTOCOL_NAME``_if[%0d]`",i),cdn_phy_tb_top.``PROTOCOL_NAME``_interface[i].``PROTOCOL_NAME``_host_if); \
		  uvm_config_db #(cdn_phy_vif_t)::set(null,`"uvm_test_top.``PROTOCOL_NAME``_test.``PROTOCOL_NAME``_env.reset_agent`",$psprintf(`"``PROTOCOL_NAME``_if[%0d]`",i),cdn_phy_tb_top.``PROTOCOL_NAME``_interface[i].``PROTOCOL_NAME``_host_if); \
          uvm_config_db #(cdn_phy_vif_t)::set(null,`"uvm_test_top.``PROTOCOL_NAME``_test.``PROTOCOL_NAME``_env.device_agent`",$psprintf(`"``PROTOCOL_NAME``_if[%0d]`",i),cdn_phy_tb_top.``PROTOCOL_NAME``_interface[i].``PROTOCOL_NAME``_devc_if); \
          uvm_config_db #(cdn_phy_vif_t)::set(null,`"uvm_test_top.``PROTOCOL_NAME``_test.``PROTOCOL_NAME``_env.device_reset_agent`",$psprintf(`"``PROTOCOL_NAME``_if[%0d]`",i),cdn_phy_tb_top.``PROTOCOL_NAME``_interface[i].``PROTOCOL_NAME``_devc_if); \
        end \
   end \
endgenerate \
genvar j; \
generate \
   for(j = 0; j< tb_param::``PROTOCOL_NAME_CAPITAL_1``_LANE_NUM; j++) begin  : ``PROTOCOL_NAME_1``_interface \
       cdn_phy_interface_base #(.PD_WIDTH(tb_param::PD_WIDTH)) ``PROTOCOL_NAME_1``_host_if(clk_io.drv_clk_gen[1],rst); \
       cdn_phy_interface_base #(.PD_WIDTH(tb_param::PD_WIDTH)) ``PROTOCOL_NAME_1``_devc_if(clk_io.drv_clk_gen[1],rst); \
        initial begin \
          uvm_config_db #(cdn_phy_vif_t)::set(null,`"uvm_test_top.``PROTOCOL_NAME_1``_test.``PROTOCOL_NAME_1``_env.host_agent`",$psprintf(`"``PROTOCOL_NAME_1``_if[%0d]`",j),cdn_phy_tb_top.``PROTOCOL_NAME_1``_interface[j].``PROTOCOL_NAME_1``_host_if); \
          uvm_config_db #(cdn_phy_vif_t)::set(null,`"uvm_test_top.``PROTOCOL_NAME_1``_test.``PROTOCOL_NAME_1``_env.reset_agent`",$psprintf(`"``PROTOCOL_NAME_1``_if[%0d]`",j),cdn_phy_tb_top.``PROTOCOL_NAME_1``_interface[j].``PROTOCOL_NAME_1``_host_if); \
          uvm_config_db #(cdn_phy_vif_t)::set(null,`"uvm_test_top.``PROTOCOL_NAME_1``_test.``PROTOCOL_NAME_1``_env.device_agent`",$psprintf(`"``PROTOCOL_NAME_1``_if[%0d]`",j),cdn_phy_tb_top.``PROTOCOL_NAME_1``_interface[j].``PROTOCOL_NAME_1``_devc_if); \
          uvm_config_db #(cdn_phy_vif_t)::set(null,`"uvm_test_top.``PROTOCOL_NAME_1``_test.``PROTOCOL_NAME_1``_env.device_reset_agent`",$psprintf(`"``PROTOCOL_NAME_1``_if[%0d]`",j),cdn_phy_tb_top.``PROTOCOL_NAME_1``_interface[j].``PROTOCOL_NAME_1``_devc_if); \
        end \
   end \
endgenerate \
initial begin \
  uvm_config_db#(virtual interface cdnApb3MasterInterface#(.NUM_OF_SLAVES(1),.ADDRESS_WIDTH(18),.DATA_WIDTH(32)))::set(null,`"uvm_test_top.``PROTOCOL_NAME``_test.``PROTOCOL_NAME``_env.apb_mst_agent*`", `"vif`", apb_mst_if.master); \
  uvm_config_db#(virtual cdn_jtag_interface)::set(null,`"uvm_test_top.``PROTOCOL_NAME``_test.``PROTOCOL_NAME``_env.jtag_agent.jtag_drv`", `"jtag_if`", jtag_if); \
  uvm_config_db#(virtual cdn_jtag_1687_interface)::set(null,`"uvm_test_top.``PROTOCOL_NAME``_test.``PROTOCOL_NAME``_env.host_1687_jtag_agent.jtag_1687_drv`", `"jtag_1687_if`", host_1687_jtag_if); \
  uvm_config_db#(virtual interface cdnApb3MasterInterface#(.NUM_OF_SLAVES(1),.ADDRESS_WIDTH(18),.DATA_WIDTH(32)))::set(null,`"uvm_test_top.``PROTOCOL_NAME``_test.``PROTOCOL_NAME``_env.device_apb_mst_agent*`", `"vif`", device_apb_mst_if.master); \
  uvm_config_db#(virtual cdn_jtag_interface)::set(null,`"uvm_test_top.``PROTOCOL_NAME``_test.``PROTOCOL_NAME``_env.device_jtag_agent.jtag_drv`", `"jtag_if`", device_jtag_if); \
  uvm_config_db#(virtual cdn_jtag_1687_interface)::set(null,`"uvm_test_top.``PROTOCOL_NAME``_test.``PROTOCOL_NAME``_env.device_1687_jtag_agent.jtag_1687_drv`", `"jtag_1687_if`", device_1687_jtag_if); \
end \
initial begin \
  uvm_config_db#(virtual interface cdnApb3MasterInterface#(.NUM_OF_SLAVES(1),.ADDRESS_WIDTH(18),.DATA_WIDTH(32)))::set(null,`"uvm_test_top.``PROTOCOL_NAME_1``_test.``PROTOCOL_NAME_1``_env.apb_mst_agent*`", `"vif`", apb_mst_if.master); \
  uvm_config_db#(virtual cdn_jtag_interface)::set(null,`"uvm_test_top.``PROTOCOL_NAME_1``_test.``PROTOCOL_NAME_1``_env.jtag_agent.jtag_drv`", `"jtag_if`", jtag_if); \
  uvm_config_db#(virtual cdn_jtag_1687_interface)::set(null,`"uvm_test_top.``PROTOCOL_NAME_1``_test.``PROTOCOL_NAME_1``_env.host_1687_jtag_agent.jtag_1687_drv`", `"jtag_1687_if`", host_1687_jtag_if); \
  uvm_config_db#(virtual interface cdnApb3MasterInterface#(.NUM_OF_SLAVES(1),.ADDRESS_WIDTH(18),.DATA_WIDTH(32)))::set(null,`"uvm_test_top.``PROTOCOL_NAME_1``_test.``PROTOCOL_NAME_1``_env.device_apb_mst_agent*`", `"vif`", device_apb_mst_if.master); \
  uvm_config_db#(virtual cdn_jtag_interface)::set(null,`"uvm_test_top.``PROTOCOL_NAME_1``_test.``PROTOCOL_NAME_1``_env.device_jtag_agent.jtag_drv`", `"jtag_if`", device_jtag_if); \
  uvm_config_db#(virtual cdn_jtag_1687_interface)::set(null,`"uvm_test_top.``PROTOCOL_NAME_1``_test.``PROTOCOL_NAME_1``_env.device_1687_jtag_agent.jtag_1687_drv`", `"jtag_1687_if`", device_1687_jtag_if); \
end
/*}}}*/

`ifdef USB32
`define  USB32_HOST_LANE0 usb32_interface[0].usb32_host_if 
`define  USB32_HOST_LANE1 usb32_interface[1].usb32_host_if 
`define  USB32_DEVC_LANE0 usb32_interface[0].usb32_devc_if 
`define  USB32_DEVC_LANE1 usb32_interface[1].usb32_devc_if 
`elsif USB4
`define  USB4_HOST_LANE0 usb4_interface[0].usb4_host_if 
`define  USB4_HOST_LANE1 usb4_interface[1].usb4_host_if 
`define  USB4_DEVC_LANE0 usb4_interface[0].usb4_devc_if 
`define  USB4_DEVC_LANE1 usb4_interface[1].usb4_devc_if
`elsif PCIE
`define  PCIE_HOST_LANE0 pcie_interface[0].pcie_host_if 
`define  PCIE_HOST_LANE1 pcie_interface[1].pcie_host_if 
`define  PCIE_DEVC_LANE0 pcie_interface[0].pcie_devc_if 
`define  PCIE_DEVC_LANE1 pcie_interface[1].pcie_devc_if
`elsif DP
`define  DP_HOST_LANE0 dp_interface[0].dp_host_if
`define  DP_HOST_LANE1 dp_interface[1].dp_host_if
`define  DP_HOST_LANE2 dp_interface[2].dp_host_if
`define  DP_HOST_LANE3 dp_interface[3].dp_host_if
`define  DP_DEVC_LANE0 dp_interface[0].dp_devc_if
`define  DP_DEVC_LANE1 dp_interface[1].dp_devc_if
`define  DP_DEVC_LANE2 dp_interface[2].dp_devc_if
`define  DP_DEVC_LANE3 dp_interface[3].dp_devc_if
`elsif ALT_MODE
`define  USB32_HOST_LANE0 usb32_interface[0].usb32_host_if 
`define  USB32_DEVC_LANE0 usb32_interface[0].usb32_devc_if 
`define  DP_HOST_LANE0 dp_interface[0].dp_host_if
`define  DP_HOST_LANE1 dp_interface[1].dp_host_if
`define  DP_DEVC_LANE0 dp_interface[0].dp_devc_if
`define  DP_DEVC_LANE1 dp_interface[1].dp_devc_if
`endif

//can need other define like mult link or ALT mode
endpackage : tb_param

