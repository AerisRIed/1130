typedef enum bit[5:0]{
    MB_TX_IDLE                  = 0,
	MB_TX_CYCLE1_B              = 1,
    MB_TX_CYCLE2_B              = 2,
    MB_TX_CYCLE3_B              = 3,
    MB_TX_CYCLE1                = 4,
    MB_TX_CYCLE2                = 5,
    MB_TX_CYCLE3                = 6,
    MB_TX_CYCLE1_ACK            = 7,
	MB_TX_READ_CYCLE1			= 8,
	MB_TX_READ_CYCLE2			= 9,
	MB_TX_DELAY                 = 10,
	MB_TX_WAIT_ACK				= 11
} tx_state_t;

typedef enum bit[5:0]{
    MB_RX_IDLE                  = 0,
    MB_RX_CYCLE1                = 1,
    MB_RX_CYCLE2                = 2,
    MB_RX_WRITE_COMPLETE        = 3
} rx_state_t;

typedef enum bit [3:0] {
	NOP							= 0,
	WRITE_UNCOMMITTED			= 1,
	WRITE_COMMITTED				= 2,
	READ						= 3,
	READ_COMPLETION				= 4,
	WRITE_ACK					= 5	
} message_bus_cmd_t;
