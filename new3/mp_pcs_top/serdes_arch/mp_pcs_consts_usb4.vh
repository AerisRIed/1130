//------------------------------------------------------------------------------
//  $Id$
//------------------------------------------------------------------------------
//                                     
//            CADENCE                    Copyright (c) 2014
//                                       Cadence Design Systems, Inc.
//            SoCR                       All rights reserved.
//
//  This work may not be copied, modified, re-published, uploaded, executed, or
//  distributed in any way, in any medium, whether in whole or in part, without
//  prior written permission from Cadence Design Systems, Inc.
//------------------------------------------------------------------------------
//                                     
//   Author         : Dongdong Wang
//
//   Date           : July 23, 2025
//
//   Limitations    : 
//
//------------------------------------------------------------------------------
//   Description    : Defines which are constant across physical configurations.
//
//------------------------------------------------------------------------------

`ifndef INCLUDE_USB4PCS_CONSTANTS
  `define INCLUDE_USB4PCS_CONSTANTS
   
  //------------------------------------------------------------------------------
  // PMA configuration for mode encoding
  //------------------------------------------------------------------------------
  `define pipe_pma_usb4_gen2_width          3'b010
  `define pipe_pma_usb4_gen3_width          3'b010
  `define pipe_pma_usb4_gen4_width          3'b010

  `define pipe_pma_usb4_gen2_width_16b      3'b001
  `define pipe_pma_usb4_gen3_width_16b      3'b001

  `define pipe_pma_usb4_gen2_standard_mode  3'b000
  `define pipe_pma_usb4_gen3_standard_mode  3'b001
  `define pipe_pma_usb4_gen4_standard_mode  3'b010


`endif
