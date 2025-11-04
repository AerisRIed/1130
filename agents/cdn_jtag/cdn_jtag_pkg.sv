`ifndef CDN_JTAG_PACKAGE
`define CND_JTAG_PACKAGE

package cdn_jtag_pkg;

import uvm_pkg::*;
  `include "uvm_macros.svh"
  `ifdef JTAG_ADDR_REG_SIZE
  parameter JTAG_ADDR_REG_SIZE = `JTAG_ADDR_REG_SIZE;
  `else
  parameter JTAG_ADDR_REG_SIZE = 14;
  `endif
  `ifdef JTAG_DATA_REG_SIZE
  parameter JTAG_DATA_REG_SIZE = `JTAG_DATA_REG_SIZE;
  `else
  parameter JTAG_DATA_REG_SIZE = 32;
  `endif
  parameter  JTAG_RDWR_CTRL_SIZE    = 8'd3;
  parameter  JTAG_CLK_CTRL_SIZE     = 8'd2;


  parameter  JTAG_INSTR_SIZE        = 32'd4;       // JTAG I/F Instruction Register Size
  parameter  JTAG_TESTMODE_REG_SIZE = 32'd46;
  parameter  JTAG_CLK_CTRL_INSTR    = 4'h5;   // JTAG I/F Load Address Instruction
  parameter  JTAG_LOAD_ADDR_INSTR   = 4'h6;   // JTAG I/F Load Address Instruction
  parameter  JTAG_LOAD_DATA_INSTR   = 4'h7;   // JTAG I/F Load Data Instruction
  parameter  JTAG_RD_DATA_INSTR     = 4'h8;   // JTAG I/F Read dataInstruction
  parameter  JTAG_RDWR_CTRL_INSTR   = 4'h9;   // JTAG I/F Read/Write COntrol Instruction

  parameter  JTAG_RD_CTRL_START    = 16'h2;
  parameter  JTAG_WR_CTRL_START    = 16'h6;
  parameter  JTAG_WR_CTRL_STOP     = 16'h0;


  parameter  PHY_JTAG_CLK_CTRL_REG = 16'h5;
  parameter  PHY_JTAG_ADDR_REG     = 16'h6;
  parameter  PHY_JTAG_APB_ACCESS_REG  = 16'h9;
  parameter  PHY_JTAG_DATA_REG = 32'h16;
  parameter  PHY_JTAG_DATA_RD_REG = 32'h17;

  parameter JTAG_ADDR_WIDTH = JTAG_ADDR_REG_SIZE;
  parameter JTAG_DATA_WIDTH = JTAG_DATA_REG_SIZE;
  parameter JTAG_WIDTH = 64;
  typedef enum {JTAG_READ = 0, JTAG_WRITE = 1} jtag_op_t;
  typedef bit[JTAG_ADDR_WIDTH-1:0] jtag_addr_t;
  typedef bit[JTAG_DATA_WIDTH-1:0] jtag_data_t;
  
  `include "cdn_jtag_trans.sv"
  //`include "cdn_jtag_interface.sv"
  `include "cdn_jtag_driver.sv"
  `include "cdn_jtag_sequencer.sv"
  `include "cdn_jtag_agent.sv"
endpackage
`endif
