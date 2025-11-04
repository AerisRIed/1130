`ifndef PARAM_LIB__SVH
`define PARAM_LIB__SVH
//NOTE:just a demo from torrent
    parameter pipe_USB_P0  = 2'b00;
    parameter pipe_USB_P1  = 2'b01;
    parameter pipe_USB_P2  = 2'b10;
    parameter pipe_USB_P3  = 2'b11;
    parameter DUT_HOST     = 1'b0;
    parameter DUT_DEVICE   = 1'b1;

    parameter UHBR20       = 3'b000; //(20Gbps   )
    parameter UHBR13P5     = 3'b001; //(13.5Gbps )
    parameter UHBR10       = 3'b010; //(10Gbps   )
    parameter HBR3         = 3'b011; //(8.100Gbps)
    parameter HBR2         = 3'b100; //(5.400Gpbs)
    parameter HBR          = 3'b101; //(2.700Gbps)
    parameter RBR          = 3'b110; //(1.620Gbps)

    parameter DP_IDLE       = 6'b000000;
    parameter DP_A0         = 6'b000001;
    parameter DP_A1         = 6'b000010;
    parameter DP_A2         = 6'b000100;
    parameter DP_A3         = 6'b001000;
    parameter DP_A4         = 6'b010000;
    parameter DP_A5         = 6'b100000;
`endif