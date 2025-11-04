package USB4_LINK;
typedef enum {
	U4_GEN2,
    U4_GEN3
}speed_type_enum;

typedef enum {
    CLD,
    TRAINING,
    CL1,
    CL2,
    CL1_EXIT,
    CL2_EXIT,
    CL0S_EXIT,
    CL0,
    CL0S,
    Disabled,
    OVERWRITE
} lane_ltssm_state_type_enum;

typedef enum {
    IDLE,
    TS1,
    TS2,
    LOCK1,
    LOCK2,
    CL0S_TX,
    CL0S_RX
}lane_ltssm_substate_type_enum;
endpackage


