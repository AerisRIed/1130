
module testchip_tap2apb #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32) (
   //Top level TAP pins
   input                               tap_tdi,      //From TAP MUX
   input                               tap_tck,      //From TAP MUX
   input                               tap_tms,      //From TAP MUX
   input                               tap_trst_n,   //From TAP MUX
   output                              tap_tdo,      //To TAP MUX
   output                              tap_tdoen,    //To TAP MUX /* unconnected */
   // Top level NoC interface.
   input                               noc_clk,      //From Pad/IO
   input                               noc_reset_n,  //From Pad/IO
   // CDB interface to NoC.
   output                              cdb_pclk,     //Async NoC
   output                              cdb_preset_n,
   output                              cdb_psel,
   output                              cdb_penable,
   output     [31:0]                   cdb_paddr,
   output                              cdb_pwrite,
   output     [31:0]                   cdb_pwdata,
   input      [31:0]                   cdb_prdata,
   input                               cdb_pready,
   // Scan
   input                               scanmode,
   input                               scanen,
   input                               scanen_cg
);
//----------------------------------------------------------------------
// APB interface controlled by the TAP.
//----------------------------------------------------------------------
// Asynchronous APB interface.
wire                              async_apb_pclk;
//wire                              async_apb_preset_n;
wire                              async_apb_req;
wire     [31:0]                   async_apb_paddr;
wire                              async_apb_pwrite;
wire     [31:0]                   async_apb_pwdata;
wire     [31:0]                   async_apb_prdata;
wire                              async_apb_ack;

wire                              diag_apb_preset_n;
wire                              macro_isolation_mode_en;

//------------------------------------------------------------------------------
// Instantiate the TAP controller and APB_wrapper
// The tap will be used to generated traffic on the various APB interface
// The tap translates JTAG access into async APB traffic 
// The APB wrapper decodes the async APB addresses and generate control 
// signals for the various slaves.
//------------------------------------------------------------------------------
tap_complex #(.ADDR_WIDTH(32), .DATA_WIDTH(32)) u_tap_complex (
  //Top level TAP pins
  .tap_tdi                                 (tap_tdi),
  .tap_tck                                 (tap_tck),
  .tap_tms                                 (tap_tms), 
  .tap_trst_n                              (tap_trst_n), 
  .tap_tdo                                 (tap_tdo), 
  .tap_tdoen                               (tap_tdoen),
  .tx_bscan_tdo                            (1'b0),
  .rx_bscan_tdi                            (/* unconnected */),
  .rx_bscan_clockdr                        (/* unconnected */),
  .tx_bscan_clockdr                        (/* unconnected */),
  .rx_bscan_shiftdr                        (/* unconnected */),
  .tx_bscan_shiftdr                        (/* unconnected */),
  .tx_bscan_updatedr                       (/* unconnected */),
  .tx_bscan_mode_c                         (/* unconnected */),
  .tx_bscan_ac                             (/* unconnected */),
  .rx_bscan_ac                             (/* unconnected */),
  .rx_bscan_pc                             (/* unconnected */),
  .tx_bscan_acpulse                        (/* unconnected */),
  .tx_bscan_highz                          (/* unconnected */),
  .async_apb_prdata                        (async_apb_prdata),
  .async_apb_ack                           (async_apb_ack),
  .async_apb_req                           (async_apb_req), 
  .async_apb_paddr                         (async_apb_paddr), 
  .async_apb_pwrite                        (async_apb_pwrite),
  .async_apb_pwdata                        (async_apb_pwdata),
  .diag_apb_preset_n                       (diag_apb_preset_n),    
  .macro_isolation_mode_sel                (/* unconnected */),
  .macro_isolation_mode_en                 (macro_isolation_mode_en),
  .scanmode                                (scanmode),
  .scanen                                  (scanen),
  .scanen_cg                               (scanen_cg),
  .JTAG_INSTRUCTION_DECODE_CUSTOM_INSTR_1  (/* unconnected */),
  .JTAG_INSTRUCTION_DECODE_CUSTOM_INSTR_2  (/* unconnected */),
  .JTAG_INSTRUCTION_DECODE_CUSTOM_INSTR_3  (/* unconnected */),
  .JTAG_INSTRUCTION_DECODE_CUSTOM_INSTR_4  (/* unconnected */),
  .JTAG_INSTRUCTION_DECODE_CUSTOM_INSTR_5  (/* unconnected */),
  .JTAG_INSTRUCTION_DECODE_CUSTOM_INSTR_6  (/* unconnected */),
  .JTAG_INSTRUCTION_DECODE_CUSTOM_INSTR_7  (/* unconnected */),
  .JTAG_INSTRUCTION_DECODE_CUSTOM_INSTR_8  (/* unconnected */),
  .JTAG_INSTRUCTION_DECODE_CUSTOM_INSTR_9  (/* unconnected */),
  .JTAG_INSTRUCTION_DECODE_CUSTOM_INSTR_10 (/* unconnected */)
);

apb_testchip_wrapper   u_apb_testchip_wrapper  (   
  .iso_mode_en                            (macro_isolation_mode_en),
  .apb_pclk                               (noc_clk),
  .apb_preset_n                           (noc_reset_n),
  .apb_psel                               (1'b0),
  .apb_penable                            (1'b0),
  .apb_paddr                              (32'd0),
  .apb_pwrite                             (1'b0),
  .apb_pwdata                             (32'd0),
  .apb_prdata                             (/* unconnected */),
  .apb_pready                             (/* unconnected */),
  .async_apb_pclk                         (tap_tck),
  .async_apb_preset_n                     (diag_apb_preset_n),
  .async_apb_req                          (async_apb_req),
  .async_apb_paddr                        (async_apb_paddr),
  .async_apb_pwrite                       (async_apb_pwrite),
  .async_apb_pwdata                       (async_apb_pwdata),
  .async_apb_prdata                       (async_apb_prdata),
  .async_apb_ack                          (async_apb_ack),
  .cdb_pclk                               (cdb_pclk),
  .cdb_preset_n                           (cdb_preset_n),
  .cdb_psel                               (cdb_psel),
  .cdb_penable                            (cdb_penable),
  .cdb_paddr                              (cdb_paddr),
  .cdb_pwrite                             (cdb_pwrite),
  .cdb_pwdata                             (cdb_pwdata),
  .cdb_prdata                             (cdb_prdata),
  .cdb_pready                             (cdb_pready),
  .scanclk_pclk                           (noc_clk),
  .scanmode_pclk                          (scanmode)
);

endmodule

///projects/sd3101_t4gp_fe/users/zwliu/whistler_5nm/design/phy/trunk/rtl/testchip/apb_testchip_wrapper.v
///projects/sd3101_t4gp_fe/users/zwliu/whistler_5nm/design/phy/trunk/reuse/rtl_tap/tap_complex.v
///projects/sd3101_t4gp_fe/users/zwliu/whistler_5nm/design/phy/trunk/rtl/testchip_5nm/whistler_5nm_testchip.v

