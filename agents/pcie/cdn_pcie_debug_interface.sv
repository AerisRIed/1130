typedef enum {
	IDL,
	RANDOM
} data_type_enum;

interface cdn_pcie_debug_interface#(parameter PD_WIDTH=8);
    reg[(9*30):1]	       ltssm_state_ascii;
    reg[(9*30):1]          next_ltssm_state_ascii;
    //reg[(9*30):1]         ltssm_substate_ascii;
    //reg[(9*30):1]         next_ltssm_substate_ascii;
    
    reg[(9*30):1]         pcie_speed_state_ascii;
    reg[(9*30):1]         symbol_type_ascii;

    reg[(9*30):1]         pipe_archi_ascii = $sformatf("Serdes");
	logic [tb_param::SERDES_WIDTH-1:0] pd_data;
	bit   serdes_tx_valid;
    bit running_disparity;
    logic Far_end_Rx_Absent     =0;   //used for RxDetect
    logic Far_end_Rx_Detected   =0; //used for RxDetect
	bit   tRxdetectTimeout_flag;
	bit   tPollingTS1Timeout_flag;
	bit   tPollingCFGTimeout_flag;
	bit   tConfigTS1Timeout_flag;
	bit   tConfigTS2Timeout_flag;
	bit   tConfigIdleTimeout_flag;
	bit   tL0s_Fts_Timeout_flag;
	bit   tRcvrLockTimeout_flag;
	bit   tRcvrCfgTimeout_flag;
	bit   tRcvrIdleTimeout_flag;
    logic rx_polarity_invert_done;
    logic speed_change_done;
    logic eq_done;
	int   eieos_sent_count;
    int   eieos_received_cnt;
	int   ts1_sent_count;
    int   ts1_received_count;
	int   ts1_with_compliance_bit_received_count;
	int   ts1_with_eq_received_count;
    int   ts2_sent_count;
    int   ts2_received_count;
	int   ts2_with_speed_change_sent_count;
	int   ts2_with_speed_change_received_count;
    int   ts1_sent_count_after_received_eight;
    int   ts2_sent_count_after_received_eight;
    int   idle_packet_sent_count;
    int   idle_packet_received_count;
    int   idle_packet_sent_count_after_received_one;
    int   eios_received_cnt;
    int   fts_received_cnt;
    int   skp_received_cnt;
	logic L0s_entry_detected;
	logic L0s_exit_detected;
    logic L1_entry_detected;
    logic L1_exit_detected;
    logic L2_entry_detected;
    logic eios_detected;
    logic beacon_detected;
    logic electrical_idle_exit_detected;

	// driver set 
	typedef struct {
		bit rxdetect 		;
        bit ts1 			;
        bit ts2 			;
        bit fts 			;
        int n_fts 			;
        bit polarity_invert ;
        bit compliance 		;
        bit data_en 		;
        data_type_enum data_type 		;
        bit l0s 			;
        bit l1 				;
        bit l1_exit 		;
        bit l2 				;
        bit beacon 			;
        bit rate 			;
        bit eq_en 			;
        bit speed_change 	;
        bit scramble_en		;
		bit skp_insert;
		bit[2:0] skp_start_byte_idx;
		bit[2:0] data_start_byte_idx;
		int symbol_time_cnt;
		int block_cnt;
  		int skp_block_cnt;
		int block_byte_cnt;
		int skp_cnt;
		int ts_transmit_cnt;
		int skp_insert_period_gen12_nonl0;
		int skp_insert_period_gen12_l0;
		int skp_insert_period_gen34_nonl0;
		int skp_insert_period_gen34_l0;
  		int eieos_insert_period;
	    bit[31:0] txdata_unsrc;
        bit[63:0] lfsr16; //16*4
        bit[91:0] lfsr23; //23*4
	} driver_set_t;

	driver_set_t  driver_set;

	// monitor set
	typedef struct {
	    bit lock_flag;
	    int sync_idx1;
	    int sync_idx2;
	    int sync_idx3;
	    int sync_idx;
		bit[63:0] lfsr16;
		bit[91:0] lfsr23;
		bit[3:0] serdes_rxdata_10b_valid;
		bit[39:0] serdes_rxdata_10b;
		bit[3:0] serdes_rx_kcode;
		bit[31:0] serdes_rxdata_8b;
		bit[31:0] serdes_rxdata_des;
		bit[1:0] serdes_rx_block_head;
		bit[127:0] serdes_rx_block_data;
		bit[3:0] serdes_rx_block_valid;
		bit[127:0] serdes_rx_block_des;
		bit[31:0] pipe_rxdata_des; 
        bit[127:0] pipe_rx_block_data;
        bit[127:0] pipe_rx_block_des;
	} monitor_set_t;

	monitor_set_t mon_set;
    
    //int lbpm_config_sent_count;
    //int lbpm_ready_sent_count;
    //int lbpm_ready_sent_count_after_received_two;
    //logic eight_consecutive_idle_received;
    //int tseq_os_received_count;
    //int Idle_packet_received_count;

    //int lfps_received_count;
    //int scd1_received_count;
    //int scd2_received_count;
    //
    //int lbpm_config_sent_count_after_received_two;
    //bit skp_period;
    //int os_count;
    //int os_index;
    //int skp_count;
    //bit [15:0] cur_lfsr;
    //bit [22:0] cur_lfsr_gen2;
    //int block_count;

 function void reset();
    //Far_end_Rx_Absent = 0;
    //Far_end_Rx_Detected = 0;
	tRxdetectTimeout_flag = 0;
	tPollingTS1Timeout_flag = 0;
	tPollingCFGTimeout_flag = 0;
	tConfigTS1Timeout_flag = 0;
	tConfigTS2Timeout_flag = 0;
	tConfigIdleTimeout_flag = 0;
	tL0s_Fts_Timeout_flag = 0;
	tRcvrLockTimeout_flag = 0;
	tRcvrCfgTimeout_flag = 0;
	tRcvrIdleTimeout_flag = 0;
    rx_polarity_invert_done = 0;
    speed_change_done = 0;
    eq_done = 0;
	ts1_sent_count = 0;
    ts1_received_count = 0;
	ts1_with_compliance_bit_received_count = 0;
	ts1_with_eq_received_count = 0;
    ts2_sent_count = 0;
    ts2_received_count = 0;
	ts2_with_speed_change_sent_count = 0;
	ts2_with_speed_change_received_count = 0;
    ts1_sent_count_after_received_eight = 0;
    ts2_sent_count_after_received_eight = 0;
    idle_packet_sent_count = 0;
    idle_packet_received_count = 0;
    idle_packet_sent_count_after_received_one = 0;
	fts_received_cnt = 0;
	L0s_entry_detected = 0;
	L0s_exit_detected = 0;
    L1_entry_detected = 0;
    L1_exit_detected = 0;
    L2_entry_detected = 0;
    eios_detected = 0;
    beacon_detected = 0;
    electrical_idle_exit_detected = 0;
  endfunction

endinterface

