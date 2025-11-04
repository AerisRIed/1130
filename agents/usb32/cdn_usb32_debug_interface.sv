interface cdn_usb32_debug_interface#(parameter PD_WIDTH = 8) ();
    reg[(9*30):1]         ltssm_state_ascii;
    reg[(9*30):1]         next_ltssm_state_ascii;
    reg[(9*30):1]         ltssm_substate_ascii;
    reg[(9*30):1]         next_ltssm_substate_ascii;
    
    reg[(9*30):1]         usb32_speed_state_ascii;
    reg[(9*30):1]         symbol_type_ascii;

    reg[(9*30):1]         pipe_archi_ascii = $sformatf("Serdes");
    bit [3:0]running_disparity;
    bit initial_done;
    bit skp_detected;
    bit sync_period;
    bit symbol_lock;
    bit serdes_tx_valid;
    bit u1_exit_detected;
    bit u2_exit_detected;
    bit u3_exit_detected;
    bit loopback_exit_detected;  
    bit low_power_exit_detected;
    logic [tb_param::SERDES_WIDTH-1:0] pd_data;
    logic lfps_transmitter_en   =0;
    logic Far_end_Rx_Absent     =0;   //used for RxDetect
    logic Far_end_Rx_Detected   =0; //used for RxDetect
    logic detect_over_limit;   //used for RxDetect
    logic PowerOn_Reset;       //used for RxDetect
    event rx_detected_event; 
    logic tPollingLFPSTimeout_flag;          //LFPS handshake timeout;
    logic first_tPollingLFPSTimeout_flag;    //LFPS first handshake timeout to Compliance;
    logic tPollingSCDLFPSTimeout_flag;
    logic low_power_exit_handshake_timeout_flag;    
    logic tPollingLBPMLFPSTimeout_flag;    
    int cPollingTimeout_flag;    
    logic tPollingActiveTimeout_flag ; 
    logic U1_entry_detected;
    logic U2_entry_detected;
    logic U3_entry_detected;
    logic loopback_detected;    //Rx
    logic hot_reset_detected;   //Rx
    logic sixteen_idle_symbol_sent_after_one_received;  
    int symbol_count_Y;
    int tseq_os_sent_count;
    int ts1_os_sent_count;
    int ts2_os_sent_count;
    int ts1_os_sent_count_after_received_eight;
    int ts2_os_sent_count_after_received_eight;
    int Idle_packet_sent_count;
    int Idle_packet_sent_count_after_received_one;
    int lfps_sent_count;
    int scd1_sent_count;
    int scd2_sent_count;
    int lfps_sent_count_after_recieved_one;
    int scd1_sent_count_after_lfps_recieved_two;
    int scd1_sent_count_after_scd1_received_one;
    int scd1_sent_count_after_scd2_received_one;
    int scd2_sent_count_after_scd2_received_one;
    
    int lbpm_config_sent_count;
    int lbpm_ready_sent_count;
    int lbpm_ready_sent_count_after_received_two;
    logic eight_consecutive_idle_received;
    int tseq_os_received_count;
    int ts1_os_received_count;
    int ts2_os_received_count;    
    int Idle_packet_received_count;
    int loopback_test_pattern_received_count;
    int bdat_received_count;
    int lfps_received_count;
    int scd1_received_count;
    int scd2_received_count;
    
    int lbpm_config_sent_count_after_received_two;
    bit skp_period;
    event e_skp_period;
    int index_in_one_clk;
    int skp_sent_num;
    int os_count;
    int os_index;
    int skp_count;
    bit [15:0] cur_lfsr;
    bit [22:0] cur_lfsr_gen2;
    int block_count;
    int byte_index;
    bit [39:0]loopback_data_gen1[$];
    bit [31:0]loopback_data_gen2[$];
    bit [31:0]data_before_scramble;
    bit [255:0]received_data;

endinterface

