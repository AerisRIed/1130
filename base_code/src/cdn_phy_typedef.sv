
parameter CLK_1M        = 1.0;
parameter CLK_1_5M      = 1.5;
parameter CLK_2_5M      = 2.5;
parameter CLK_4M        = 4.0;
parameter CLK_5M        = 5.0;
parameter CLK_10M       = 10.0;
parameter CLK_12M       = 12.0;
parameter CLK_19_2M     = 19.2; 
parameter CLK_20M       = 20.0; 
parameter CLK_24M       = 24.0; 
parameter CLK_30M       = 30.0; 
parameter CLK_38_4M     = 38.4; 
parameter CLK_40M       = 40.0; 
parameter CLK_48M       = 48.0; 
parameter CLK_50M       = 50.0; 
parameter CLK_60M       = 60.0;
parameter CLK_62_5M     = 62.5; 
parameter CLK_75M       = 75.0; 
parameter CLK_80M       = 80.0; 
parameter CLK_81M       = 81.0; 
parameter CLK_90M       = 90.0; 
parameter CLK_96M       = 96.0; 
parameter CLK_100M      = 100.0; 
parameter CLK_105M      = 105.0; 
parameter CLK_120M      = 120.0; 
parameter CLK_125M      = 125.0; 
parameter CLK_135M      = 135.0; 
parameter CLK_150M      = 150.0; 
parameter CLK_156_25M   = 156.25; 
parameter CLK_180M      = 180.0;
parameter CLK_200M      = 200.0;
parameter CLK_210M      = 210.0; 
parameter CLK_240M      = 240.0; 
parameter CLK_250M      = 250.0; 
parameter CLK_270M      = 270.0; 
parameter CLK_300M      = 300.0; 
parameter CLK_312_5M    = 312.5; 
parameter CLK_400M      = 400.0;
parameter CLK_405M      = 405.0; 
parameter CLK_421_875M  = 421.875; 
parameter CLK_480M      = 480.0; 
parameter CLK_500M      = 500.0; 
parameter CLK_625M      = 625.0; 
parameter CLK_914M      = 914.0; 
parameter CLK_960M      = 960.0; 
parameter CLK_1440M     = 1440.0; 
parameter CLK_1920M     = 1920.0; 
parameter CLK_2400M     = 2400.0; 
parameter CLK_2880M     = 2880.0; 
parameter CLK_3360M     = 3360.0; 
parameter CLK_3840M     = 3840.0; 
parameter CLK_4320M     = 4320.0; 
parameter CLK_4800M     = 4800.0; 

typedef enum {
    CMP_ON  = 1, 
    CMP_OFF = 0
} compare_flag_t;

typedef enum {
    AST_ON  = 1, 
    AST_OFF = 0
} assert_flag_t;

typedef enum {
    POSITIVE = 0, 
    NEGATIVE = 1
} flip_flag_t;

typedef enum {
	SSC_DISABLE = 0,
	SSC_ENABLE  = 1
} ssc_flag_t;

typedef enum bit[1:0] {
	HOST,
	DEVICE,
	RETIMER 
}component_type_enum;


typedef enum bit[3:0]{
    USB4_MODE       = 4'h0,
    USB32_MODE      = 4'h1,
    PCIE_MODE       = 4'h2,
    DP_MODE         = 4'h3,
    ALT_MODE        = 4'h4
} std_mode_t;

typedef enum bit[3:0]{
    GEN1_SPEED        = 4'h0,
    GEN2_SPEED        = 4'h1,
    GEN3_SPEED        = 4'h2,
    GEN4_SPEED        = 4'h3
} gen_speed_t;

typedef enum bit[3:0]{
    DP_RBR         = 4'h0,
    DP_HBR         = 4'h1,
    DP_HBR2        = 4'h2,
    DP_HBR3        = 4'h3,
    DP_UHBR10      = 4'h4,
    DP_UHBR13P5    = 4'h5,
    DP_UHBR20      = 4'h6
} dp_bit_rate_t;

typedef union packed{
    gen_speed_t gen_speed;
    dp_bit_rate_t dp_rate;
} phy_rate_union_t;

typedef enum bit[1:0] {
    DATA_WIDTH_8   = 2'h0, 
    DATA_WIDTH_16  = 2'h1, 
    DATA_WIDTH_32  = 2'h2
} data_width_t;

typedef enum bit[3:0]{
    LANE_NUM_1        = 4'h1,
    LANE_NUM_2        = 4'h2,
    LANE_NUM_4        = 4'h4
} lane_num_t;

typedef enum bit[2:0]{
    LINK_TRG_NONE            = 3'h0, // both 8b10b and 128b132b
    LINK_TRG_CR              = 3'h1, // 8b10b only
    LINK_TRG_EQ              = 3'h2, // 8b10b only
    LINK_TRG_128B132B_EQ     = 3'h3, // 128b132b only
    LINK_TRG_128B132B_CDS    = 3'h4, // 128b132b only
    LINK_TRG_DONE            = 3'h5  // both 8b10b and 128b132b
} dp_link_trg_t;

typedef enum bit[3:0]{
    LINK_DATA_RANDOM           = 4'h0,
    LINK_TPS1                  = 4'h1,
    LINK_TPS2                  = 4'h2,
    LINK_TPS3                  = 4'h3,
    LINK_TPS4                  = 4'h4,
    LINK_128B132B_TPS1         = 4'h5,
    LINK_128B132B_TPS2_START   = 4'h6,
    LINK_128B132B_TPS2         = 4'h7,
    LINK_IDLE_PATTERN          = 4'h8,
    LINK_128B132B_IDLE_PATTERN = 4'h9,
    LINK_LFPS                  = 4'ha
} dp_link_tps_t;

typedef enum bit[1:0]{
    VSWING_LEVEL_0        = 2'h0,
    VSWING_LEVEL_1        = 2'h1,
    VSWING_LEVEL_2        = 2'h2,
    VSWING_LEVEL_3        = 2'h3
} vswing_level_t;

typedef enum bit[1:0]{
    PREEMPH_LEVEL_0        = 2'h0,
    PREEMPH_LEVEL_1        = 2'h1,
    PREEMPH_LEVEL_2        = 2'h2,
    PREEMPH_LEVEL_3        = 2'h3
} preemph_level_t;


typedef enum bit[2:0] {
    REFCLK_19_2M    = 3'b000, 
    REFCLK_24M      = 3'b001, 
    //REFCLK_48M      = 3'b010, 
    REFCLK_100M     = 3'b011
    //REFCLK_156_25M  = 3'b100
} refclk_mode_t;

typedef enum bit [3:0] {
    VCO_5_4G  = 4'd0,
    VCO_6_48G = 4'd1,
    VCO_6_75G = 4'd2,
    VCO_8_1G  = 4'd3,
    VCO_10G   = 4'd5,
    UNUSED       = 4'd6
} vco_clk_t;
typedef enum bit [3:0] {
    PIPE_CLK_250M = 4'd0,
    PIPE_CLK_125M = 4'd1,
    PIPE_CLK_625M = 4'd2,
    PIPE_CLK_312_5M  = 4'd3,
    NULL = 4'd4
} pipe_clk_t;
typedef enum bit [3:0] {
    PMA_LANE_0 = 4'd0,
    PMA_LANE_1 = 4'd1,
    PMA_LANE_2 = 4'd2,
    PMA_LANE_3  = 4'd3
} physical_lane_t;


//type for reg interface select
typedef enum bit[1:0] { 
    APB  = 2'h0, 
    JTAG = 2'h1,
    JTAG_1687 = 2'h2
} reg_interface_t;

typedef struct{ // TBD
  rand bit                             jitter_en;
  //rand bit                             ppm_sign;  //1:pos 0:neg
  //rand bit[PPM_OFFSET_WIDTH-1:0]       ppm_offset;
  //rand bit[CLK_PHASE_SHIFT_WIDTH-1:0]  phase_shift;
  //rand bit[CLK_PHASE_SHIFT_WIDTH-1:0]  clk_amp;
  //rand bit[CLK_FS_WIDTH-1 :0]          clk_fs;
  //bit[CLK_JITTER_MULTI_WIDTH-1 :0]     jitter_multi;
} clk_jitter_t;

//typedef enum bit[5:0]{ // TBD
//    IDLE                  = 0,
//    CLD                   = 1,
//    TRAINING              = 2,
//    CL0                   = 3,
//    LANE_BONDING          = 4,
//    CL0S                  = 5,
//    CL1                   = 6,
//    CL2                   = 7
//} operation_t;

typedef enum bit[5:0]{ // TBD
    DP_IDLE                  = 0,
    DP_DATA                  = 1,
    DP_POWER_IDLE_ENTRY      = 2,
    DP_A0_ENTRY              = 3,
    DP_A1_ENTRY              = 4,
    DP_A2_ENTRY              = 5,
    DP_A3_ENTRY              = 6,
    DP_A4_ENTRY              = 7,
    DP_A5_ENTRY              = 8,
    DP_DATA_WIDTH_CHANGE     = 9,
    XCVR_PLLCLK_EN           = 10
} dp_operation_t;

typedef bit [DATA_WIDTH-1:0] data_t;
typedef data_t pdata_q_t[$];
typedef data_t pdata_a_t[];

typedef enum bit[1:0] { // TBD
    DATA_SYMBOL           = 'b01,
    ORDERED_SET_SYMBOL    = 'b10
} symbol_sync_t;

//typedef enum bit[7:0] { // TBD
//    DATA             = 0,
//    SLOS1            = 1,
//    SLOS2            = 2,
//    TS1              = 3,
//    TS2              = 4,
//    CL_WAKE1_X       = 5,
//    CL_WAKE2_X       = 6,
//    TSNOS            = 7,
//    DESKEW           = 8,
//    CL1_REQ          = 9,
//    CL2_REQ          = 10,
//    CL0S_ACK         = 11,
//    CL1_ACK          = 12,
//    CL2_ACK          = 13,
//    CL_NACK          = 14,
//    CL_OFF           = 15
//} packet_type_t;

typedef enum bit[7:0]{ // TBD
    NO_ERROR          = 0,
    SYNC_MISSING      = 1
} insert_error_type_t;


typedef enum bit {  
    SPEEDUP_CONFIG_DISABLE = 0,
    SPEEDUP_CONFIG_ENABLE =  1
} speedup_config_t;

typedef enum bit[2:0]{
    ALL_0         = 3'h0,
    ALL_1         = 3'h1,
    ALL_X         = 3'h2,
    RANDOM_0_1    = 3'h3,
    RANDOM_0_X    = 3'h4,
    RANDOM_1_X    = 3'h5,
    RANDOM_0_1_X  = 3'h6
} init_value_t;
