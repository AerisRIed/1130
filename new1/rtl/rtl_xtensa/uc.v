
//-----------------------------------------------------------------------------
//    This confidential and proprietary HDL soft description of a Hardware
//    component may be used only as authorized by a licensing agreement from
//    Cadence. In the event of publication, the following notice
//    is applicable:
//
//                       (C) COPYRIGHT 2025 Cadence
//                         ALL RIGHTS RESERVED
//
//     The entire notice above must be reproduced on all authorized
//     copies of this code.
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//
// Filename        : uc.v
//
// Author          : Can Chen
// Abstract        : This is the micro controller module which instances the
//                   xtensa and apb support modules
//
//-----------------------------------------------------------------------------

module uc #(
parameter PROCESSOR_ID = 16'hC0DE
) (
input         clk,
input         reset_n,
input         scanmode,
input         scanen_cg,
input         apb_preset_n,

input         binterrupt,
input         runstall,  
output        pwaitmode,
input   [3:0] ln_id,  // for top uc set to 0

output        apb_psel,
output        apb_penable,
output [15:0] apb_paddr,
output        apb_pwrite,
output [31:0] apb_pwdata,
input  [31:0] apb_prdata,
input         apb_pready,
input         apb_perror,

input         s_apb_psel,
input         s_apb_penable,
input  [15:0] s_apb_paddr,
input         s_apb_pwrite,
input  [31:0] s_apb_pwdata,
output [31:0] s_apb_prdata,
output        s_apb_pready,
output        s_apb_perror,

output [16:2] dram_addr,
output [3:0]  dram_byteen,
`ifdef CDN_MPPHY_UC_ECC_EN // @RELEASE@
input  [38:0] dram_data,
output [38:0] dram_wrdata,
`else // @RELEASE@
input  [31:0] dram_data,
output [31:0] dram_wrdata,
`endif // @RELEASE@
output        dram_en,
output        dram_wr,
`ifdef CDN_UCTLR_DUAL_PORT_RAM // @RELEASE@
output [16:2] iram_addr,
`ifdef CDN_MPPHY_UC_ECC_EN // @RELEASE@
input  [38:0] iram_data,
output [38:0] iram_wrdata,
`else // @RELEASE@
input  [31:0] iram_data,
output [31:0] iram_wrdata,
`endif // @RELEASE@
output        iram_en,
output        iram_wr,
`endif // @RELEASE@
output        iram_loadstore,
// output        doubleexceptionerror,
output        pfatalerror,
output [31:0] pfaultinfo,
output        pfaultinfovalid,
              
`ifdef CDN_MPPHY_UC_ECC_EN // @RELEASE@
input         enable_ecc_correction,
output        ecc_err_detected_dram,
output        ecc_err_multiple_dram,
`ifdef CDN_UCTLR_DUAL_PORT_RAM // @RELEASE@
output        ecc_err_detected_iram,
output        ecc_err_multiple_iram,
`endif // @RELEASE@
`endif // @RELEASE@

//new added debug IO
input         DReset,                 
output        softBReset,             
output        DebugMode,              
input         OCDHaltOnReset,         
output        XOCDMode,               
input         JTCK,                   
input         JTDI,                   
output        JTDO,                   
output        JTDOEn,                 
input         JTMS,                   
input         JTRST,                  
input         DBGEN,                  
input         NIDEN,                  
input  [31:0] PADDR,                  
input         PBCLK,                  
input         PBCLKEN,               
input         PENABLE,                
output [31:0] PRDATA,                 
output        PREADY,                 
input         PRESETn,                
input         PSEL,                   
output        PSLVERR,                
input  [31:0] PWDATA,                 
input         PWRITE,                 
input         SPIDEN,                 
input         SPNIDEN,                

input  [2:0]  iram_base_addr,
input         sram_init,
output        sram_init_done
);

wire   [16:2] sram_addr;
wire          sram_en;
wire          sram_wr;
wire   [31:0] sram_wrdata;
wire   [16:2] sram_apb_addr;
wire   [31:0] sram_apb_data;
wire          sram_apb_en;
wire          sram_apb_wr;
wire   [31:0] sram_apb_wrdata;
wire   [16:2] sram_init_addr;
wire          sram_init_en;
wire          sram_init_wr;
wire   [31:0] sram_init_wrdata;
`ifndef CDN_UCTLR_DUAL_PORT_RAM // @RELEASE@
wire   [16:2] idram_addr;
wire   [3:0]  idram_byteen;
wire   [31:0] idram_data;
wire          idram_en;
wire          idram_wr;
wire   [31:0] idram_wrdata;

wire          DRam0Busy0;
`endif // @RELEASE@

`ifdef CDN_MPPHY_UC_ECC_EN // @RELEASE@
wire   [31:0] dram_wrdata_pre_ecc;
wire   [38:0] dram_data_pre_ecc;
wire   [31:0] dram_data_post_ecc;
`ifdef CDN_UCTLR_DUAL_PORT_RAM // @RELEASE@
wire   [31:0] iram_wrdata_pre_ecc;
wire   [31:0] iram_data_post_ecc;
`endif // @RELEASE@
`endif // @RELEASE@

wire   [16:2] DRam0Addr0;
wire   [3:0]  DRam0ByteEn0;
wire   [31:0] DRam0Data0;
wire          DRam0En0;
wire          DRam0Wr0;
wire   [31:0] DRam0WrData0;
wire   [17:2] DRam1Addr0;
wire   [17:2] adjusted_dram1addr0;
wire   [3:0]  DRam1ByteEn0;
wire   [31:0] DRam1Data0;
wire          DRam1Busy0;
wire          DRam1En0;
wire          DRam1Wr0;
wire   [31:0] DRam1WrData0;
wire   [16:2] IRam0Addr;
wire   [16:2] iram0addr_plus_bar;
`ifndef CDN_UCTLR_DUAL_PORT_RAM // @RELEASE@
wire          IRam0Busy;
wire   [31:0] IRam0Data;
wire          IRam0En;
wire          IRam0Wr;
wire   [31:0] IRam0WrData;
`else  // @RELEASE@
wire          iram_enable;
wire          iram_write;
`endif // @RELEASE@

wire          reset_n_sync_clk;
wire          reset_sync_clk;
wire          tmode;
wire          tmodeclkgateoverride;
wire          breset;
wire   [15:0] prid;
wire          init_ram;

// Internal reset control signals
wire          BResetProc_logic;
wire          BResetProc_synchronized;
wire          myBResetProc;

assign myBResetProc = breset;

assign init_ram = runstall;

assign tmode = scanmode;
assign tmodeclkgateoverride = scanen_cg;
assign breset = reset_sync_clk;
assign prid   = PROCESSOR_ID;

phy_reset_sync #(
    .NUM_FLOPS (2)
) u_breset_sync_clk (
    .sync_clock_in       (clk),
    .reset_in_n          (reset_n),
    .reset_out_n         (reset_n_sync_clk),
    .upstream_reset_in_n (1'b1),
    .scan_mode_en_in     (scanmode),
    .scan_reset_in_n     (apb_preset_n)
);

assign reset_sync_clk = !reset_n_sync_clk;

// Processor Reset - asynchronous case
Xm_serdes_128id0256d1_fusaxtreset_tmode_async_synchronizer3 creset(BResetProc_synchronized, BResetProc_logic, scanmode, myBResetProc, clk);

Xm_serdes_128id0256d1_fusaXttop xttop (
   .DRam00CLK                (),
   .DRam0Addr0               (DRam0Addr0),
`ifdef CDN_UCTLR_DUAL_PORT_RAM // @RELEASE@
   .DRam0Busy0               (1'b0),
`else // @RELEASE@
   .DRam0Busy0               (DRam0Busy0),
`endif // @RELEASE@
   .DRam0ByteEn0             (DRam0ByteEn0),
   .DRam0Data0               (DRam0Data0),
   .DRam0En0                 (DRam0En0),
   .DRam0Wr0                 (DRam0Wr0),
   .DRam0WrData0             (DRam0WrData0),
   .DRam10CLK                (),
   .DRam1Addr0               (DRam1Addr0),
   .DRam1Busy0               (DRam1Busy0),
   .DRam1ByteEn0             (DRam1ByteEn0),
   .DRam1Data0               (DRam1Data0),
   .DRam1En0                 (DRam1En0),
   .DRam1Wr0                 (DRam1Wr0),
   .DRam1WrData0             (DRam1WrData0),
   .IRam0Addr                (IRam0Addr),
`ifdef CDN_UCTLR_DUAL_PORT_RAM // @RELEASE@
   .IRam0Busy                (1'b0),
   .IRam0En                  (iram_enable),
   .IRam0Wr                  (iram_write),
   .IRam0CLK                 (),
`ifdef CDN_MPPHY_UC_ECC_EN // @RELEASE@
   .IRam0WrData              (iram_wrdata_pre_ecc),
   .IRam0Data                (iram_data_post_ecc),
`else // @RELEASE@
   .IRam0WrData              (iram_wrdata),
   .IRam0Data                (iram_data),
`endif // @RELEASE@
`else // @RELEASE@
   .IRam0Busy                (IRam0Busy),
   .IRam0Data                (IRam0Data),
   .IRam0En                  (IRam0En),
   .IRam0CLK                 (),
   .IRam0Wr                  (IRam0Wr),
   .IRam0WrData              (IRam0WrData),
`endif // @RELEASE@
   .IRam0LoadStore           (iram_loadstore),
   .BInterrupt               (binterrupt),
   .PWaitMode                (pwaitmode),
   .PRID                     (prid),
   .RunStall                 (runstall),
   .TMode                    (tmode),
   .TModeClkGateOverride     (tmodeclkgateoverride),
//   .DoubleExceptionError     (doubleexceptionerror),
   .PFatalError              (pfatalerror),
   .PFaultInfo               (pfaultinfo),
   .PFaultInfoValid          (pfaultinfovalid),
   .CLK                      (clk),
   .BReset                   (breset),
   // new added 
   .BResetProc_logic         (BResetProc_logic),
   .BResetProc_synchronized  (BResetProc_synchronized),
   .DReset                   (DReset),
   .softBReset               (softBReset),
   .DebugMode                (DebugMode),
   .OCDHaltOnReset           (OCDHaltOnReset),
   .XOCDMode                 (XOCDMode),
   .JTCK                     (JTCK),
   .JTDI                     (JTDI), 
   .JTDO                     (JTDO),
   .JTDOEn                   (JTDOEn),
   .JTMS                     (JTMS),
   .JTRST                    (JTRST),
   .DBGEN                    (DBGEN),
   .NIDEN                    (NIDEN),
   .PADDR                    (PADDR),
   .PBCLK                    (PBCLK),
   .PBCLKEN                  (PBCLKEN),
   .PENABLE                  (PENABLE),
   .PRDATA                   (PRDATA),
   .PREADY                   (PREADY),
   .PRESETn                  (PRESETn),
   .PSEL                     (PSEL),
   .PSLVERR                  (PSLVERR),
   .PWDATA                   (PWDATA),   
   .PWRITE                   (PWRITE),
   .SPIDEN                   (SPIDEN),
   .SPNIDEN                  (SPNIDEN)


);

// iram_base_addr is an offset from 0 into the SRAM memory.
// if it is set to 3'b100 we get iram at 64K bytes which is the default.
// the value needs to be set consistent with dram and iram linker sizes.
// iram0addr_plus_bar should never overflow or base adddress and linker
// are not setup correctly.
assign iram0addr_plus_bar[16:14] = IRam0Addr[16:14] + iram_base_addr;
assign iram0addr_plus_bar[13:2]  = IRam0Addr[13:2];

`ifndef CDN_UCTLR_DUAL_PORT_RAM // @RELEASE@
idram_arb u_idram_arb (
   .clk                      (clk),
   .reset_n                  (reset_n_sync_clk),
   .idram_addr               (idram_addr),
   .idram_byteen             (idram_byteen),
   .idram_data               (idram_data),
   .idram_en                 (idram_en),
   .idram_wr                 (idram_wr),
   .idram_wrdata             (idram_wrdata),
   .dram_addr                (DRam0Addr0),
   .dram_busy                (DRam0Busy0),
   .dram_byteen              (DRam0ByteEn0),
   .dram_data                (DRam0Data0),
   .dram_en                  (DRam0En0),
   .dram_wr                  (DRam0Wr0),
   .dram_wrdata              (DRam0WrData0),
   .iram_addr                (iram0addr_plus_bar),
   .iram_busy                (IRam0Busy),
   .iram_data                (IRam0Data),
   .iram_en                  (IRam0En),
   .iram_wr                  (IRam0Wr),
   .iram_wrdata              (IRam0WrData)
);
`endif // @RELEASE@

apb2sram u_apb2sram (
    .clk      (clk),
    .reset_n  (apb_preset_n),
    .addr     (sram_apb_addr),
    .en       (sram_apb_en),
    .wr       (sram_apb_wr),
    .wdata    (sram_apb_wrdata),
    .rdata    (sram_apb_data),
    .prdata   (s_apb_prdata),
    .pready   (s_apb_pready),
    .paddr    (s_apb_paddr),
    .pwdata   (s_apb_pwdata),
    .psel     (s_apb_psel),
    .penable  (s_apb_penable),
    .pwrite   (s_apb_pwrite)
);

assign s_apb_perror = 1'b0;

// This is the mux to allow external apb to read and write dual port SRAM during startup
`ifdef CDN_UCTLR_DUAL_PORT_RAM // @RELEASE@
assign dram_addr   = (init_ram) ? sram_addr   : DRam0Addr0;
assign dram_en     = (init_ram) ? !sram_en    : !DRam0En0;
assign dram_byteen = (init_ram) ? 4'b0000     : ~DRam0ByteEn0;
`ifdef CDN_MPPHY_UC_ECC_EN // @RELEASE@
assign dram_wrdata_pre_ecc = (init_ram) ? sram_wrdata : DRam0WrData0;
assign dram_data_pre_ecc  = dram_data;
`else // @RELEASE@
assign dram_wrdata = (init_ram) ? sram_wrdata : DRam0WrData0;
assign DRam0Data0  = dram_data;
`endif // @RELEASE@
assign dram_wr     = (init_ram) ? !sram_wr    : !DRam0Wr0;
`else // @RELEASE@

assign dram_addr   = (init_ram) ? sram_addr   : idram_addr;
assign dram_en     = (init_ram) ? !sram_en    : !idram_en;
assign dram_byteen = (init_ram) ? 4'b0000     : ~idram_byteen;
`ifdef CDN_MPPHY_UC_ECC_EN // @RELEASE@
assign dram_wrdata_pre_ecc = (init_ram) ? sram_wrdata : idram_wrdata;
assign dram_data_pre_ecc  = dram_data;
`else // @RELEASE@
assign dram_wrdata = (init_ram) ? sram_wrdata : idram_wrdata;
assign idram_data  = dram_data;
`endif // @RELEASE@
assign dram_wr     = (init_ram) ? !sram_wr    : !idram_wr;
`endif // @RELEASE@

`ifdef CDN_MPPHY_UC_ECC_EN // @RELEASE@
   assign sram_apb_data   = (init_ram) ? dram_data_post_ecc[31:0]   : {32{1'b0}};
`else // @RELEASE@
   assign sram_apb_data   = (init_ram) ? dram_data   : {32{1'b0}};
`endif // @RELEASE@

`ifdef CDN_UCTLR_DUAL_PORT_RAM // @RELEASE@
assign iram_en     = !iram_enable;
assign iram_wr     = !iram_write;
assign iram_addr   = iram0addr_plus_bar;
`endif // @RELEASE@

// Since the ln uc can only access itself, we need to write the software as for lane 0
// and then adjust the address that is seen on the apb bus to account for which lane 
// the uc is attached to.  Also, note PMA and PCS use different bits in the address
// to select which lane so this is a dynamic adjustment based on if it is a access to PCS
// or PMA.

assign adjusted_dram1addr0 = (DRam1Addr0[17:16] == 2'b11) 
                           ? (DRam1Addr0 | (ln_id << 8))
                           : (DRam1Addr0 | (ln_id << 9));

dram2apb u_dram2apb (
    .clk      (clk),
    .reset_n  (reset_n_sync_clk),
    .addr     (adjusted_dram1addr0),
    .en       (DRam1En0),
    .wr       (DRam1Wr0),
    .wdata    (DRam1WrData0),
    .busy     (DRam1Busy0),
    .rdata    (DRam1Data0),
    .prdata   (apb_prdata),
    .pready   (apb_pready),
    .paddr    (apb_paddr),
    .pwdata   (apb_pwdata),
    .psel     (apb_psel),
    .penable  (apb_penable),
    .pwrite   (apb_pwrite)
);


// The processor must be stalled in order to use sram_initialize.
// This will be the condition when init_ram is asserted
sram_initialize u_sram_init (
    .clk              (clk),
    .reset_n          (reset_n_sync_clk),
    .addr             (sram_init_addr),
    .en               (sram_init_en),
    .wr               (sram_init_wr),
    .wdata            (sram_init_wrdata),
    .sram_init        (sram_init),
    .sram_init_done   (sram_init_done)
);

assign sram_addr   = sram_init ? sram_init_addr   : sram_apb_addr;
assign sram_en     = sram_init ? sram_init_en     : sram_apb_en;
assign sram_wrdata = sram_init ? sram_init_wrdata : sram_apb_wrdata;
assign sram_wr     = sram_init ? sram_init_wr     : sram_apb_wr;


`ifdef CDN_MPPHY_UC_ECC_EN // @RELEASE@
// ECC unit for data write
// Data writes limited to full word write
ecc #(
    .synd_sel (1)
) u_ecc_wr (
    .datain     (dram_wrdata_pre_ecc),
    .gen        (1'b1),
    .correct_n  (1'b0),
    .chkin      (7'd0),
    .err_detect (/*UNUSED*/),
    .err_multpl (/*UNUSED*/),
    .dataout    (dram_wrdata[31:0]),
    .chkout     (dram_wrdata[38:32])
);

// ECC unit for data read
ecc #(
    .synd_sel (0)
) u_ecc_rd (
    .datain     (dram_data_pre_ecc[31:0]),
    .gen        (1'b0),
    .correct_n  (~enable_ecc_correction),
    .chkin      (dram_data_pre_ecc[38:32]),
    .err_detect (ecc_err_detected_dram),
    .err_multpl (ecc_err_multiple_dram),
    .dataout    (dram_data_post_ecc[31:0]),
    .chkout     (/*UNUSED*/)
);

`ifndef CDN_UCTLR_DUAL_PORT_RAM // @RELEASE@
    assign idram_data[31:0] = dram_data_post_ecc[31:0];
`else // @RELEASE@
    assign DRam0Data0[31:0] = dram_data_post_ecc[31:0];
`endif // @RELEASE@

// if dual port there are 2 additional ecc blocks for the instruction ram
`ifdef CDN_UCTLR_DUAL_PORT_RAM // @RELEASE@
// ECC unit for instruction write
// Data writes limited to full word write
ecc #(
    .synd_sel (1)
) u_ecc_iwr (
    .datain     (iram_wrdata_pre_ecc),
    .gen        (1'b1),
    .correct_n  (1'b0),
    .chkin      (7'd0),
    .err_detect (/*UNUSED*/),
    .err_multpl (/*UNUSED*/),
    .dataout    (iram_wrdata[31:0]),
    .chkout     (iram_wrdata[38:32])
);

// ECC unit for instruction read
ecc #(
    .synd_sel (0)
) u_ecc_ird (
    .datain     (iram_data[31:0]),
    .gen        (1'b0),
    .correct_n  (~enable_ecc_correction),
    .chkin      (iram_data[38:32]),
    .err_detect (ecc_err_detected_iram),
    .err_multpl (ecc_err_multiple_iram),
    .dataout    (iram_data_post_ecc[31:0]),
    .chkout     (/*UNUSED*/)
);

`endif // @RELEASE@

`endif // @RELEASE@
// endif CDN_MPPHY_UC_ECC_EN


endmodule

