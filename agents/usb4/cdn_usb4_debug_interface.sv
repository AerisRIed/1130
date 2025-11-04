interface cdn_usb4_debug_interface#(parameter PD_WIDTH = 8) ();
    reg[(9*30):1]         ltssm_state_ascii;
    reg[(9*30):1]         next_ltssm_state_ascii;
    reg[(9*30):1]         ltssm_substate_ascii;
    reg[(9*30):1]         next_ltssm_substate_ascii;
    
    reg[(9*30):1]         usb4_speed_state_ascii;
    reg[(9*30):1]         symbol_type_ascii;

    reg[(9*30):1]         pipe_archi_ascii = $sformatf("Serdes");
    
    bit initial_done;
    bit tx_rx_enable;
    bit symbol_lock;
    bit serdes_tx_valid;
    bit cl1_exit_detected;
    bit cl2_exit_detected;
    bit cl0s_exit_detected;
    bit low_power_exit_detected;
    logic [tb_param::SERDES_WIDTH-1:0] pd_data;
    logic lfps_transmitter_en   =0;
    
    logic cl1_entry_detected;
    logic cl2_entry_detected;
    logic cl0s_entry_detected;
    
    int ts1_sent_count;
    int ts2_sent_count;
    int slos1_sent_count;
    int slos2_sent_count;
    
    int slos1_received_count;
    int slos2_received_count;
    int ts1_received_count;
    int ts2_received_count;    

    int os_count;
    int os_index;
    bit [22:0] cur_lfsr;
    int block_count;
    int byte_index;

endinterface

