interface cdn_jtag_interface(input tck);

logic tms = 1;//KDTSER-2831
logic tdi = 0;
logic tdo;
logic trst = 0;
logic tdo_oe;
endinterface
