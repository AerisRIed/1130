/********************************************************************************************
#        Copyright (c) 2008-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
********************************************************************************************/


/*
//*******************************************************************************************
// usb4_tc_noc_xtreset_n_tmode_async_synchronizer1 - Reset Half Synchronizer with Test Mode Port
//   xtfreset   - output flop reset
//   xtlreset   - output logic reset
//   xtmode     - input test mode port (active high)
//   xtreset    - input raw reset (active low)
//   xtclk      - input clock port
//
module usb4_tc_noc_xtreset_n_tmode_async_synchronizer1(xtfreset, xtlreset, xtmode, xtreset, xtclk);
output xtfreset, xtlreset;
input xtmode, xtreset, xtclk;
//
// Instantiate the alternate implementation here
//
endmodule
*/

/*
//*******************************************************************************************
// usb4_tc_noc_xtreset_n_async_synchronizer1 - Reset Half Synchronizer
//   xtfreset   - output flop reset
//   xtlreset   - output logic reset
//   xtreset    - input raw reset (active low)
//   xtclk      - input clock port
//
module usb4_tc_noc_xtreset_n_async_synchronizer1(xtfreset, xtlreset, xtreset, xtclk);
output xtfreset, xtlreset;
input xtreset, xtclk;
//
// Instantiate the alternate implementation here
//
endmodule
*/

/*
//*******************************************************************************************
// usb4_tc_noc_xtreset_n_tmode_async_synchronizer3 - Reset 3-Stage Synchronizer with Test Mode Port
//   xtfreset   - output flop reset
//   xtlreset   - output logic reset
//   xtmode     - input test mode port (active high)
//   xtreset    - input raw reset (active low)
//   xtclk      - input clock port
//
module usb4_tc_noc_xtreset_n_tmode_async_synchronizer3(xtfreset, xtlreset, xtmode, xtreset, xtclk);
output xtfreset, xtlreset;
input xtmode, xtreset, xtclk;
//
// Instantiate the alternate implementation here
//
endmodule
*/

/*
//*******************************************************************************************
// usb4_tc_noc_xtreset_n_async_synchronizer3 - Reset 3-Stage Synchronizer
//   xtfreset   - output flop reset
//   xtlreset   - output logic reset
//   xtreset    - input raw reset (active low)
//   xtclk      - input clock port
//
module usb4_tc_noc_xtreset_n_async_synchronizer3(xtfreset, xtlreset, xtreset, xtclk);
output xtfreset, xtlreset;
input xtreset, xtclk;
//
// Instantiate the alternate implementation here
//
endmodule
*/

/*
//*******************************************************************************************
// usb4_tc_noc_xtascsynch1 - Single Stage Asynch Clear Synchronizer
//   xtout      - output
//   xtin       - input
//   clrb       - input clear bar (active low)
//   xtclk      - input clock port
//
module usb4_tc_noc_xtascsynch1(xtout, xtin, clrb, clk);
output xtout;
input xtin, clrb, clk;
//
// Instantiate the alternate implementation here
//
endmodule
*/

/*
//*******************************************************************************************
// usb4_tc_noc_xtascsynch2 - Two Stage Asynch Clear Synchronizer
//   xtout      - output
//   xtin       - input
//   clrb       - input clear bar (active low)
//   xtclk      - input clock port
//
module usb4_tc_noc_xtascsynch2(xtout, xtin, clrb, clk);
output xtout;
input xtin, clrb, clk;
//
// Instantiate the alternate implementation here
//
endmodule
*/

/*
//*******************************************************************************************
// usb4_tc_noc_xtascsynch3 - Three Stage Asynch Clear Synchronizer
//   xtout      - output
//   xtin       - input
//   clrb       - input clear bar (active low)
//   xtclk      - input clock port
//
module usb4_tc_noc_xtascsynch3(xtout, xtin, clrb, clk);
output xtout;
input xtin, clrb, clk;
//
// Instantiate the alternate implementation here
//
endmodule
*/

/*
//*******************************************************************************************
// usb4_tc_noc_xtsynch1 - Single Stage Non-Clearing Synchronizer
//   xtout      - output
//   xtin       - input
//   xtclk      - input clock port
//
module usb4_tc_noc_xtsynch1(xtout, xtin, clk);
output xtout;
input xtin, clk;
//
// Instantiate the alternate implementation here
//
endmodule
*/

/*
//*******************************************************************************************
// usb4_tc_noc_xtsynch2 - Two Stage Non-Clearing Synchronizer
//   xtout      - output
//   xtin       - input
//   xtclk      - input clock port
//
module usb4_tc_noc_xtsynch2(xtout, xtin, clk);
output xtout;
input xtin, clk;
//
// Instantiate the alternate implementation here
//
endmodule
*/

/*
//*******************************************************************************************
// usb4_tc_noc_xtsynch3 - Three Stage Non-Clearing Synchronizer
//   xtout      - output
//   xtin       - input
//   xtclk      - input clock port
//
module usb4_tc_noc_xtsynch3(xtout, xtin, clk);
output xtout;
input xtin, clk;
//
// Instantiate the alternate implementation here
//
endmodule
*/

/*
//*******************************************************************************************
// usb4_tc_noc_xtgated_clock - Clock Gating Cell
//   xtout  - output gated clock port
//   xten   - enable port
//   xtclk  - input clock port
//
module usb4_tc_noc_xtgated_clock ( xtout, xten, xtclk );
output xtout;
input xten, xtclk;
//
// Instantiate the alternate implementation here
//
endmodule
*/

/*
//*******************************************************************************************
// usb4_tc_noc_xtgated_tmode_clock - Clock Gating Cell with Test Mode Port
//   xtout  - output gated clock port
//   xtmode - test mode port (active high)
//   xten   - enable port
//   xtclk  - input clock port
//
module usb4_tc_noc_xtgated_tmode_clock ( xtout, xtmode, xten, xtclk);
output xtout;
input xtmode, xten, xtclk;
//
// Instantiate the alternate implementation here
//
endmodule
*/
