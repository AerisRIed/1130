package PCIE_LINK;

//typedef enum bit[1:0] {
//	PCIE_GEN1,
//    PCIE_GEN2,
//    PCIE_GEN3,
//    PCIE_GEN4
//}speed_type_enum;

typedef enum {
    DETECT_QUIET,
    DETECT_ACTIVE,
	POLLING_ACTIVE,
	POLLING_CONFIG,
	CONFIGURATION_WAIT,
	CONFIGURATION_COMPLETE,
	CONFIGURATION_IDLE,
    COMPLIANCE,
	L0,
	RECOVERY_LOCK,
	RECOVERY_CFG,
	RECOVERY_SPEED,
	RECOVERY_EQ,
	RECOVERY_IDLE,
	L0S_ENTRY,
	L0S_IDLE,
	L0S_FTS,
	L1_ENTRY,
	L1_IDLE,
	L1_EXIT,
	L2_ENTRY,
	L2_IDLE,
	L2_TRANSMIT_WAKE,
    LOOPBACK,
	OVERWRITE
} lane_ltssm_state_type_enum;

//typedef enum {
//	RX_DETECTION,
//	RX_POLARITY_INVERSION,
//	TS1,
//	TS2,
//	DATA,
//	ELECTRICAL_IDLE,
//	ENTER_L1,
//	ENTER_L2,
//	EXIT_L1,
//	EXIT_L2,
//	SET_DE-EMPHASIS,
//	BEACON
//} operation_type_enum;

typedef enum {
	IDL,
	RANDOM
} data_type_enum;

typedef enum bit {
	STANDARD_SKP,
	CONTROL_SKP
} skp_type_gen34_enum;

typedef enum bit {
	PATTERN,
	SKP
} pattern_state_enum;


typedef enum int {
    EIOS,
	FTSOS,
	SKPOS,
	EIEOS,
	TSOS,
	SDSOS,
	NULL   //data block
} ordered_set_enum;

endpackage
