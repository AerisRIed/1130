package USB32_LINK;
typedef enum {
	U32_GEN1,
    U32_GEN2
}speed_type_enum;

typedef enum {
    COMPLIANCE,
    SS_INACTIVE,
    RX_DETECT,
    OVERWRITE,
    SS_DISABLE,
    POLLING,
    U0,
    U1,
    U2,
    U3,
    LOOPBACK_M,
    LOOPBACK_S,
    LOOPBACK_EXIT,
    LOOPBACK_RST,
    HOT_RESET,
    U1_EXIT,
    U2_EXIT,
    U3_EXIT,
    RECOVERY
} lane_ltssm_state_type_enum;

typedef enum {
    IDLE,
    eSS_Disabled_Default,
    eSS_Disabled_Error,
    eSS_Inactive_Quiet,
    eSS_Disconnect_Detect,
    RX_DETECT_Reset,
    RX_DETECT_Active,
    POLLING_LFPS,
    POLLING_LFPSPLUS,
    POLLING_PORTMATCH,
    POLLING_PORTCONFIG,
    POLLING_RXEQ,
    POLLING_ACTIVE,
    POLLING_CONFIGURATION,
    POLLING_IDLE
}lane_ltssm_substate_type_enum;
endpackage

