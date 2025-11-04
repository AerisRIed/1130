//
// Template for Top module
//
`ifndef CDN_PHY_TB_TOP__SV
`define CDN_PHY_TB_TOP__SV



//----------------------------------------------------------------------------
// Required timescale for sequence delays.
//----------------------------------------------------------------------------
`timescale 1ns / 1fs

//----------------------------------------------------------------------------
// Required modules, interfaces and packages
//----------------------------------------------------------------------------
`include "cdnApbUvmDefines.sv"
`include "cdnApbMacros.sv"
//`include "math_pkg.sv" // TODO
//`include "cdn_jtag_pkg.sv" // comment out, otherwise reporting errors
//`include "cdn_jtag_1687_pkg.sv" // comment out, otherwise reporting errors
`include "cdn_jtag_interface.sv"
`include "cdn_jtag_1687_interface.sv"
//`include "cdns_uvmreg_utils_pkg.sv" // TODO
//`include "cdn_usb4_phy_top_regs_rdb.sv" // TODO
//`include "cdn_apb_req_ack_module.sv" // TODO
`include "cdn_reset_if.sv"
`include "host_device_intfs.incl"
//----------------------------------------------------------------------------
// Import Packages
//----------------------------------------------------------------------------
// Import UVM Package
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

//  import cdnUsb4Uvm::*;
//  import DenaliSvMem::*;
//  import DenaliSvPipephy::*;
//  import cdnPipephyUvm::*;
//
//`include "cdnUsb4UvmUserTop.sv"
// ToDo: Import the cdn phy Package

//----------------------------------------------------------------------------
// Add the test library
//----------------------------------------------------------------------------
import test_package::*;

//----------------------------------------------------------------------------
// Create the testbench.
//----------------------------------------------------------------------------

module cdn_phy_tb_top();
   logic clk;
   logic rst;
   logic sva_clk;


   // Clock Generation
   parameter sim_cycle = 10;
   
   // Reset Delay Parameter
   parameter rst_delay = 50;

   always 
      begin
         #(sim_cycle/2) clk = ~clk;
      end


   //SVA Clock Generation
   parameter sva_cycle = 1ns;

   always 
      begin
         #(sva_cycle/2) sva_clk = ~sva_clk;
      end

//------------------------------------------------------------------------
// Interfaces
//------------------------------------------------------------------------

  logic        uc_clk; 
  logic        uc_reset_n; 

/*--------------------------------APB_Interface------------------------*/

  logic        ref_clk0; 
  logic        ref_clk1; 
  logic        sys_rst_n; 
  logic        apb_pclk; 
  logic        apb_rst_n;                   
  wire [APB_DATA_WIDTH-1:0]  apb_prdata;
  wire         apb_pready;
  wire         apb_pslverr;
  
  logic        apb_penable;
  logic        apb_psel;
  logic        apb_pwrite;
  logic [APB_ADDR_WIDTH-1:0] apb_paddr;
  logic [APB_DATA_WIDTH-1:0] apb_pwdata;

  logic        temp_apb_penable=0;
  logic        temp_apb_psel=0;
  logic        temp_apb_pwrite=0;
  logic [APB_ADDR_WIDTH-1:0] temp_apb_paddr=0;
  logic [APB_DATA_WIDTH-1:0] temp_apb_pwdata=0;

  
  cdnApb3Interface #(.NUM_OF_SLAVES(1),.ADDRESS_WIDTH(18),.DATA_WIDTH(32)) apb_mst_if (.clk(apb_pclk),.resetn(apb_rst_n));
  
  assign apb_mst_if.master.prdata = apb_prdata;
  assign apb_mst_if.master.pslverr = apb_pslverr;
  assign apb_mst_if.master.pready = apb_pready;

//  always @ (posedge apb_pclk)
//  begin
//    apb_paddr   <= `APB_DELAY apb_mst_if.master.paddr;
//    apb_penable <= `APB_DELAY apb_mst_if.master.penable;
//    apb_pwrite  <= `APB_DELAY apb_mst_if.master.pwrite;
//    apb_pwdata  <= `APB_DELAY apb_mst_if.master.pwdata;
//    apb_psel    <= `APB_DELAY apb_mst_if.master.psel0;
//  end

    assign `APB_DELAY apb_paddr   = apb_mst_if.master.paddr;
    assign `APB_DELAY apb_penable = apb_mst_if.master.penable;
    assign `APB_DELAY apb_pwrite  = apb_mst_if.master.pwrite;
    assign `APB_DELAY apb_pwdata  = apb_mst_if.master.pwdata;
    assign `APB_DELAY apb_psel    = apb_mst_if.master.psel0;

  logic apb_psel_sync =0;
  
  always @ (negedge apb_pclk) 
  begin
    apb_psel_sync = apb_psel;
  end

/*--------------------------------Reset_Interface------------------------*/
  logic phy_reset_n;

  cdn_reset_if phy_reset_if();
  assign phy_reset_n = phy_reset_if.phy_reset;
  assign apb_rst_n   = phy_reset_if.apb_reset;
  assign uc_reset_n  = phy_reset_if.uc_reset;
/*--------------------------------Clock_Interface------------------------*/
/*
  wire ref_clk_vld;
  cdn_clock_if clock_if();
  assign ref_clk_vld = utmi_a_if.ref_clk_vld;
  assign apb_pclk = clock_if.apb_clk;
  assign utmi_a_if.ref_clk_orig = clock_if.ref_clk;
  assign ref_clk = (ref_clk_vld == 1'b0) ? 0 : clock_if.ref_clk;
  assign utmi_a_if.ref_clk = ref_clk;
  //assign utmi_clk = clock_if.utmi_clk;
  assign rx_multi_clk = clock_if.rx_bit_multi_clk;
  assign tx_multi_clk = clock_if.tx_bit_multi_clk;
*/

  wire ref_clk_vld=1; // TODO
  assign apb_pclk = clk_io.drv_clk_gen[3]; // apb_clk
  assign ref_clk0 = (ref_clk_vld == 1'b0) ? 0 : clk_io.drv_clk_gen[2]; // ref_clk0
  assign ref_clk1 = (ref_clk_vld == 1'b0) ? 0 : clk_io.drv_clk_gen[7]; // ref_clk1

  assign uc_clk = clk_io.drv_clk_gen[6]; // uc_clk

/*--------------------------------JTAG Interface------------------------*/

  logic host_1687_en = 0;
  logic phy_jtag_tck;
  logic phy_jtag_tms;
  logic phy_jtag_tdi;
  logic phy_jtag_tdo;
  logic phy_jtag_trst ;
  logic phy_jtag_tdo_oe;

  cdn_jtag_interface jtag_if(phy_jtag_tck);

  assign phy_jtag_tck    = clk_io.drv_clk_gen[4]; // jtag_tck_clk
  assign phy_jtag_tdi    = jtag_if.tdi;
  assign phy_jtag_tms    = jtag_if.tms;
  assign phy_jtag_trst   = host_1687_en? host_1687_jtag_if.trst : jtag_if.trst;
  assign jtag_if.tdo     = phy_jtag_tdo;
  assign jtag_if.tdo_oe  = phy_jtag_tdo_oe;


/*--------------------------------JTAG 1687 Interface------------------------*/

  //logic phy_jtag_tck_1687;
  //logic phy_jtag_tms_1687;
  //logic phy_jtag_tdi_1687;
  //logic phy_jtag_tdo_1687;
  //logic phy_jtag_trst_1687 ;
  //logic phy_jtag_tdo_oe_1687;

  wire jtag_tdo_1687;
  wire jtag_clockdr_1687;
  wire jtag_shiftdr_1687;
  wire jtag_updatedr_1687;
  wire jtag_capturedr_1687;   
  wire jtag_instruction_decode_instr_1_1687;
  wire jtag_instruction_decode_instr_2_1687;  
  wire jtag_instruction_decode_instr_3_1687;  
  wire jtag_instruction_decode_instr_4_1687;  
  wire jtag_instruction_decode_instr_5_1687; 

  cdn_jtag_1687_interface host_1687_jtag_if(clk_io.drv_clk_gen[4]); // jtag_tck_clk

  assign jtag_clockdr_1687    = host_1687_jtag_if.clockdr;
  assign jtag_shiftdr_1687    = host_1687_jtag_if.shiftdr;
  assign jtag_capturedr_1687  = host_1687_jtag_if.capturedr;
  assign jtag_updatedr_1687   = host_1687_jtag_if.updatedr;
  assign jtag_instruction_decode_instr_1_1687 = host_1687_jtag_if.instruction_decode_instr_1;
  assign jtag_instruction_decode_instr_2_1687 = host_1687_jtag_if.instruction_decode_instr_2;
  assign jtag_instruction_decode_instr_3_1687 = host_1687_jtag_if.instruction_decode_instr_3;
  assign jtag_instruction_decode_instr_4_1687 = host_1687_jtag_if.instruction_decode_instr_4;
  assign jtag_instruction_decode_instr_5_1687 = host_1687_jtag_if.instruction_decode_instr_5;
  assign host_1687_jtag_if.tdo  = jtag_tdo_1687;


  //assign phy_jtag_tck_1687    = clock_if.jtag_tck_clk;
  //assign phy_jtag_tdi_1687    = host_1687_jtag_if.tdi;
  //assign phy_jtag_tms_1687    = host_1687_jtag_if.tms;
  //assign phy_jtag_trst_1687   = host_1687_jtag_if.trst;
  //assign host_1687_jtag_if.tdo     = phy_jtag_tdo_1687;
  //assign host_1687_jtag_if.tdo_oe  = phy_jtag_tdo_oe_1687;

 //tap_complex_trans u_tap_1687_trans(
 //  .tap_tdi                                         (phy_jtag_tdi_1687    ),
 //  .tap_tck                                         (phy_jtag_tck_1687    ),
 //  .tap_tms                                         (phy_jtag_tms_1687    ),
 //  .tap_trst_n                                      (phy_jtag_trst_1687   ),
 //  .tap_tdo                                         (phy_jtag_tdo_1687    ),
 //  .tap_tdoen                                       (phy_jtag_tdo_oe_1687 ),

 //  .IEEE1687_EN                                     (host_1687_en         ),

 //  .JTAG_TDO_1687                                   (jtag_tdo_1687        ),
 //  .JTAG_CLOCKDR_1687                               (jtag_clockdr_1687    ),
 //  .JTAG_SHIFTDR_1687                               (jtag_shiftdr_1687    ),
 //  .JTAG_UPDATEDR_1687                              (jtag_updatedr_1687   ),
 //  .JTAG_CAPTUREDR_STATE_1687                       (jtag_capture_1687    ),   
 //  .JTAG_INSTRUCTION_DECODE_CUSTOM_INSTR_1_1687     (jtag_instruction_decode_instr_1_1687),
 //  .JTAG_INSTRUCTION_DECODE_CUSTOM_INSTR_2_1687     (jtag_instruction_decode_instr_2_1687),  
 //  .JTAG_INSTRUCTION_DECODE_CUSTOM_INSTR_3_1687     (jtag_instruction_decode_instr_3_1687),  
 //  .JTAG_INSTRUCTION_DECODE_CUSTOM_INSTR_4_1687     (jtag_instruction_decode_instr_4_1687),  
 //  .JTAG_INSTRUCTION_DECODE_CUSTOM_INSTR_5_1687     (jtag_instruction_decode_instr_5_1687) 
 //);

//------------------------------------------------------------------------
// Device Interfaces
//------------------------------------------------------------------------

  logic        uc_clk_device; 
  logic        uc_reset_n_device; 

/*--------------------------------APB_Interface------------------------*/

  logic        ref_clk0_device; 
  logic        ref_clk1_device; 
  logic        sys_rst_n_device; 
  logic        apb_pclk_device; 
  logic        apb_rst_n_device;                   
  wire [APB_DATA_WIDTH-1:0]  apb_prdata_device;
  wire         apb_pready_device;
  wire         apb_pslverr_device;
  
  logic        apb_penable_device;
  logic        apb_psel_device;
  logic        apb_pwrite_device;
  logic [APB_ADDR_WIDTH-1:0] apb_paddr_device;
  logic [APB_DATA_WIDTH-1:0] apb_pwdata_device;

  logic        temp_apb_penable_device=0;
  logic        temp_apb_psel_device=0;
  logic        temp_apb_pwrite_device=0;
  logic [APB_ADDR_WIDTH-1:0] temp_apb_paddr_device=0;
  logic [APB_DATA_WIDTH-1:0] temp_apb_pwdata_device=0;
  
  cdnApb3Interface #(.NUM_OF_SLAVES(1),.ADDRESS_WIDTH(18),.DATA_WIDTH(32)) device_apb_mst_if (.clk(apb_pclk_device),.resetn(apb_rst_n_device));
  
  assign device_apb_mst_if.master.prdata  = apb_prdata_device;
  assign device_apb_mst_if.master.pslverr = apb_pslverr_device;
  assign device_apb_mst_if.master.pready  = apb_pready_device;

//  always @ (posedge apb_pclk_device)
//  begin
//    apb_paddr_device   <= `APB_DELAY device_apb_mst_if.master.paddr;
//    apb_penable_device <= `APB_DELAY device_apb_mst_if.master.penable;
//    apb_pwrite_device  <= `APB_DELAY device_apb_mst_if.master.pwrite;
//    apb_pwdata_device  <= `APB_DELAY device_apb_mst_if.master.pwdata;
//    apb_psel_device    <= `APB_DELAY device_apb_mst_if.master.psel0;
//  end

    assign `APB_DELAY apb_paddr_device   = device_apb_mst_if.master.paddr;
    assign `APB_DELAY apb_penable_device = device_apb_mst_if.master.penable;
    assign `APB_DELAY apb_pwrite_device  = device_apb_mst_if.master.pwrite;
    assign `APB_DELAY apb_pwdata_device  = device_apb_mst_if.master.pwdata;
    assign `APB_DELAY apb_psel_device    = device_apb_mst_if.master.psel0;


  logic apb_psel_device_sync =0;
  
  always @ (negedge apb_pclk_device) 
  begin
    apb_psel_device_sync = apb_psel_device;
  end

/*--------------------------------Reset_Interface------------------------*/
  logic 	device_phy_reset_n;

  cdn_reset_if 		device_phy_reset_if();
  assign device_phy_reset_n = device_phy_reset_if.phy_reset;
  assign apb_rst_n_device   = device_phy_reset_if.apb_reset;
  assign uc_reset_n_device  = device_phy_reset_if.uc_reset;




/*--------------------------------Clock_Interface------------------------*/
/*
  wire ref_clk_dev_vld;
  assign utmi_b_if.ref_clk_orig = device_clock_if.ref_clk;
  assign utmi_b_if.ref_clk = ref_clk_device;
  assign ref_clk_dev_vld = utmi_b_if.ref_clk_vld;
  assign apb_pclk_device = device_clock_if.apb_clk;
  assign ref_clk_device = (ref_clk_dev_vld == 0) ? 0 : device_clock_if.ref_clk;
*/
  wire ref_clk_dev_vld=1; // TODO
  assign apb_pclk_device = clk_io.drv_clk_gen[11]; // apb_clk
  assign ref_clk0_device = (ref_clk_dev_vld == 0) ? 0 : clk_io.drv_clk_gen[10]; // ref_clk0_device
  assign ref_clk1_device = (ref_clk_dev_vld == 0) ? 0 : clk_io.drv_clk_gen[15]; // ref_clk1_device

  assign uc_clk_device = clk_io.drv_clk_gen[14]; // uc_clk_device

/*--------------------------------JTAG Interface------------------------*/

  logic device_1687_en = 0;
  logic phy_jtag_tck_device;
  logic phy_jtag_tms_device;
  logic phy_jtag_tdi_device;
  logic phy_jtag_tdo_device;
  logic phy_jtag_trst_device;
  logic phy_jtag_tdo_oe_device;

  cdn_jtag_interface device_jtag_if(phy_jtag_tck_device);

  assign phy_jtag_tck_device    = clk_io.drv_clk_gen[12]; // jtag_tck_clk
  assign phy_jtag_tdi_device    = device_jtag_if.tdi;
  assign phy_jtag_tms_device    = device_jtag_if.tms;
  assign phy_jtag_trst_device   = device_1687_en ? device_1687_jtag_if.trst : device_jtag_if.trst;
  assign device_jtag_if.tdo     = phy_jtag_tdo_device;
  assign device_jtag_if.tdo_oe  = phy_jtag_tdo_oe_device;


/*--------------------------------JTAG 1687 Interface------------------------*/

  wire jtag_tdo_1687_device;
  wire jtag_clockdr_1687_device;
  wire jtag_shiftdr_1687_device;
  wire jtag_updatedr_1687_device;
  wire jtag_capturedr_1687_device;   
  wire jtag_instruction_decode_instr_1_1687_device;
  wire jtag_instruction_decode_instr_2_1687_device;  
  wire jtag_instruction_decode_instr_3_1687_device;  
  wire jtag_instruction_decode_instr_4_1687_device;  
  wire jtag_instruction_decode_instr_5_1687_device; 

  cdn_jtag_1687_interface device_1687_jtag_if(clk_io.drv_clk_gen[12]); // jtag_tck_clk

  assign jtag_clockdr_1687_device    = device_1687_jtag_if.clockdr;
  assign jtag_shiftdr_1687_device    = device_1687_jtag_if.shiftdr;
  assign jtag_capturedr_1687_device  = device_1687_jtag_if.capturedr;
  assign jtag_updatedr_1687_device   = device_1687_jtag_if.updatedr;
  assign jtag_instruction_decode_instr_1_1687_device = device_1687_jtag_if.instruction_decode_instr_1;
  assign jtag_instruction_decode_instr_2_1687_device = device_1687_jtag_if.instruction_decode_instr_2;
  assign jtag_instruction_decode_instr_3_1687_device = device_1687_jtag_if.instruction_decode_instr_3;
  assign jtag_instruction_decode_instr_4_1687_device = device_1687_jtag_if.instruction_decode_instr_4;
  assign jtag_instruction_decode_instr_5_1687_device = device_1687_jtag_if.instruction_decode_instr_5;
  assign device_1687_jtag_if.tdo  = jtag_tdo_1687_device;


  //logic phy_jtag_tck_1687_device;
  //logic phy_jtag_tms_1687_device;
  //logic phy_jtag_tdi_1687_device;
  //logic phy_jtag_tdo_1687_device;
  //logic phy_jtag_trst_1687_device ;
  //logic phy_jtag_tdo_oe_1687_device;


  //assign phy_jtag_tck_1687_device    = clock_if.jtag_tck_clk;
  //assign phy_jtag_tdi_1687_device    = device_1687_jtag_if.tdi;
  //assign phy_jtag_tms_1687_device    = device_1687_jtag_if.tms;
  //assign phy_jtag_trst_1687_device   = device_1687_jtag_if.trst;
  //assign device_1687_jtag_if.tdo     = phy_jtag_tdo_1687_device;
  //assign device_1687_jtag_if.tdo_oe  = phy_jtag_tdo_oe_1687_device;

  //tap_complex_trans u_tap_1687_trans_device(
  // .tap_tdi                                         (phy_jtag_tdi_1687_device    ),
  // .tap_tck                                         (phy_jtag_tck_1687_device    ),
  // .tap_tms                                         (phy_jtag_tms_1687_device    ),
  // .tap_trst_n                                      (phy_jtag_trst_1687_device   ),
  // .tap_tdo                                         (phy_jtag_tdo_1687_device    ),
  // .tap_tdoen                                       (phy_jtag_tdo_oe_1687_device ),

  // .IEEE1687_EN                                     (device_1687_en              ),
  // .JTAG_TDO_1687                                   (jtag_tdo_1687_device        ),
  // .JTAG_CLOCKDR_1687                               (jtag_clockdr_1687_device    ),
  // .JTAG_SHIFTDR_1687                               (jtag_shiftdr_1687_device    ),
  // .JTAG_UPDATEDR_1687                              (jtag_updatedr_1687_device   ),
  // .JTAG_CAPTUREDR_STATE_1687                       (jtag_capture_1687_device    ),   
  // .JTAG_INSTRUCTION_DECODE_CUSTOM_INSTR_1_1687     (jtag_instruction_decode_instr_1_1687_device),
  // .JTAG_INSTRUCTION_DECODE_CUSTOM_INSTR_2_1687     (jtag_instruction_decode_instr_2_1687_device),  
  // .JTAG_INSTRUCTION_DECODE_CUSTOM_INSTR_3_1687     (jtag_instruction_decode_instr_3_1687_device),  
  // .JTAG_INSTRUCTION_DECODE_CUSTOM_INSTR_4_1687     (jtag_instruction_decode_instr_4_1687_device),  
  // .JTAG_INSTRUCTION_DECODE_CUSTOM_INSTR_5_1687     (jtag_instruction_decode_instr_5_1687_device) 
  //);

/*------------------------------------------------------------------------*/


   // Pipe and serial interface
   typedef virtual cdn_phy_interface_base#(
       .PD_WIDTH(tb_param::PD_WIDTH)
   )cdn_phy_vif_t;

   clk_if #(.NUM_CLK_EN(tb_param::NUM_CLK_EN)) clk_io(); 

//-----------------------------------------------------------------------------
// sram wrapper instance - size 16kb*32/39bit
// 1 top uc + 2* lane_uc
// SRAM MACRO:
//  CDN_UCTLR_DUAL_PORT_RAM  -- default sram is a single port, not defined this. 
//  CDN_MPPHY_LANE_UC_RMV    -- only PHY Top uc, not defined in this version.
//  CDN_MPPHY_UC_ECC_EN      -- define this enable sram ecc function,
//                              extends data width to 39bit

// Defines the highest order address bit for SRAMs
//   For IP, 13:0 for 16k deep SRAM
//   For newer TCs, 14:0 for 32k deep SRAM
//   Currently, 16K deep SRAM.
//----------------------------------------------------------------------------

/**************** top sram interface*************/

// Dual-port & signal-port 
logic                 sram_clk_top;
logic                 sram_ceb_top;
logic                 sram_web_top;
logic [3:0]           sram_bweb_top;
logic [`SRAM_DEPTH:0] sram_addr_top;
logic [`SRAM_WIDTH:0] sram_wr_data_top;
logic [`SRAM_WIDTH:0] sram_rd_data_top;
// Dual-port  only 
`ifdef CDN_UCTLR_DUAL_PORT_RAM
logic                 iram_ceb_top;
logic                 iram_web_top;
logic [`SRAM_DEPTH:0] iram_addr_top;
logic [`SRAM_WIDTH:0] iram_wr_data_top;
logic [`SRAM_WIDTH:0] iram_rd_data_top;
`endif 

logic                 sram_pwrdwn_top;
/***************** lane sram interface**************/



`define SRAM_LANE_INTERFACE(LN) \
  logic                  sram_clk_ln_``LN``; \
  logic                  sram_ceb_ln_``LN``; \
  logic                  sram_web_ln_``LN``; \
  logic [3:0]            sram_bweb_ln_``LN``; \
  logic [`SRAM_DEPTH:0]  sram_addr_ln_``LN``; \
  logic [`SRAM_WIDTH:0]  sram_wr_data_ln_``LN``; \
  logic [`SRAM_WIDTH:0]  sram_rd_data_ln_``LN``; \
 `ifdef CDN_UCTLR_DUAL_PORT_RAM\
  logic                  iram_ceb_ln_``LN``; \
  logic                  iram_web_ln_``LN``; \
  logic [`SRAM_DEPTH:0]  iram_addr_ln_``LN``; \
  logic [`SRAM_WIDTH:0]  iram_wr_data_ln_``LN``; \
  logic [`SRAM_WIDTH:0]  iram_rd_data_ln_``LN``; \
 `endif\
  logic                  sram_pwrdwn_ln_``LN``; \

`ifndef CDN_MPPHY_LANE_UC_RMV

`SRAM_LANE_INTERFACE(01)
`SRAM_LANE_INTERFACE(23)

`endif

sram_wrapper  u_sram_wrap();


//Generate interface defined by tb_param
   // ToDo: Include Dut instance here
   `ifdef USB4
        `GEN_INTERFACE(USB4,usb4)
   `elsif USB32
        `GEN_INTERFACE(USB32,usb32)
   `elsif DP  
        `GEN_INTERFACE(DP,dp)
   `elsif PCIE  
        `GEN_INTERFACE(PCIE,pcie)
   `elsif ALT_MODE  
        `GEN_DOUBLE_INTERFACE(USB32,usb32,DP,dp)
    `endif
	`include"top_connection.sv" 
`ifdef DENALI_USB4_VIP
    `include"top_vip_connection.sv"
`endif
//Instantiate the lfps check module for debugging --zzx
//when the DUT is ready, using bind file to bind
/*
lfps_tx_chk chk_lfps_tx (
    .phy_reset_n(~rst),
    .phy_mode('h1),
    .phy_rate('h0),
    .pma_refclk(clk),
    .tx_td_clk(),
    .pipe_clk(),
    .pipe_tx_ones_zeros('h0),
    .pipe_powerdown('h0),
    .pipe_powerdown_pcs('h0),
    .pipe_tx_det_rx_lpbk(usb32_interface[0].usb32_host_if.debug_intf.lfps_transmitter_en),
    .pipe_tx_elec_idle(usb32_interface[0].usb32_host_if.debug_intf.lfps_transmitter_en),
    .pipe_tx_data_valid(),
    .pipe_phy_status(),
    .tx_m(host_tx0p),
    .tx_p(host_tx0n)
);
*/
`ifndef DUT_BYPASS
   //Driver reset depending on rst_delay
   initial
      begin
      //for uc reset issue when enable XPROP
      //force cdn_phy_tb_top.cdns_usb_phy_top.uc_top_soft_reset_n = 1'b0;
      //force cdn_phy_tb_top.cdns_usb_phy_top.uc_ln_soft_reset_n_ln_01 = 1'b0;
      //force cdn_phy_tb_top.cdns_usb_phy_top.uc_ln_soft_reset_n_ln_23 = 1'b0;
         clk = 0;
         sva_clk = 0;
         rst = 0;
      #1 rst = 1;
         repeat (rst_delay) @(clk);
         rst = 1'b0;
         @(clk);
      end
`endif
   // timeformat for print
   initial begin
	 $timeformat(-9,6,"ns",10);
   end

   // ToDo: Include all other test list here
   initial begin
      run_test();
   end
   initial begin
     // clk inf
     uvm_config_db#(clk_vif_t)::set(uvm_root::get(), "*", "m_vif", clk_io);
   end

/*-------------------------- phy design interface------------------------*/
`ifndef DUT_BYPASS
   cdn_phy_design_interface phy_design_if();
   assign phy_design_if.phy_uc_init_complete = phy_uc_init_complete;

//--------------------------------------------------------
// uvm_config_db sets
//--------------------------------------------------------
   initial begin
    // // clk  inf
     uvm_config_db#(clk_vif_t)::set(uvm_root::get(), "*", "m_vif", clk_io);

    // phy design intf
    uvm_config_db#(virtual cdn_phy_design_interface)::set(null,"*","phy_design_if", phy_design_if);
 
	 // reset inf for host
	 uvm_config_db#(virtual cdn_reset_if)::set(null,"*env.reset_agent", "phy_reset_if", phy_reset_if);
	 // reset inf for device
	 uvm_config_db#(virtual cdn_reset_if)::set(null,"*env.device_reset_agent", "phy_reset_if", device_phy_reset_if);

   	 // reset inf for host
	 uvm_config_db#(virtual cdn_reset_if)::set(null,"uvm_test_top.*_test.*_env.vsqr.*", "phy_reset_if", phy_reset_if);
	 // reset inf for device
	 uvm_config_db#(virtual cdn_reset_if)::set(null,"uvm_test_top.*_test.*_env.vsqr.*", "device_phy_reset_if", device_phy_reset_if);
     // APB interface configuration for host side
     uvm_config_db#(virtual interface cdnApb3MasterInterface#(.NUM_OF_SLAVES(1),.ADDRESS_WIDTH(18),.DATA_WIDTH(32)))::set(null,"uvm_test_top.*apb_mst_agent*", "vif", apb_mst_if.master);
     
     // APB interface configuration for device side  
     uvm_config_db#(virtual interface cdnApb3MasterInterface#(.NUM_OF_SLAVES(1),.ADDRESS_WIDTH(18),.DATA_WIDTH(32)))::set(null,"uvm_test_top.*device_apb_mst_agent*", "vif", device_apb_mst_if.master);
     
     // JTAG interface configuration for host side
     uvm_config_db#(virtual cdn_jtag_interface)::set(null,"uvm_test_top.*jtag_agent.jtag_drv", "jtag_if", jtag_if);
     uvm_config_db#(virtual cdn_jtag_1687_interface)::set(null,"uvm_test_top.*host_1687_jtag_agent.jtag_1687_drv", "jtag_1687_if", host_1687_jtag_if);
     
     // JTAG interface configuration for device side
     uvm_config_db#(virtual cdn_jtag_interface)::set(null,"uvm_test_top.*device_jtag_agent.jtag_drv", "jtag_if", device_jtag_if);
     uvm_config_db#(virtual cdn_jtag_1687_interface)::set(null,"uvm_test_top.*device_1687_jtag_agent.jtag_1687_drv", "jtag_1687_if", device_1687_jtag_if);
   end

`endif

endmodule: cdn_phy_tb_top

`endif // CDN_PHY_TB_TOP__SV
