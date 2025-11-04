interface cdn_dp_debug_interface#(parameter PD_WIDTH = 8) ();

    bit serdes_tx_valid;
    logic [tb_param::SERDES_WIDTH-1:0] pd_data;

    bit symbol_lock;
    bit [31:0] symbol_locked_data;

endinterface

