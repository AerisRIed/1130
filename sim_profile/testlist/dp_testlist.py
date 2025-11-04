import wrun_testlist_env
from wrun_testlist_env import test_def
common_args = ' '

test_def(
    testname    = "dp_rbr_100_no_ssc",
    build  = "dp_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_dp_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_dp_test_base +STANDARD=DP  +DP_SPEED=RBR +DP_LANE_NUM=4 +define+SERDES_WIDTH=32 +SSCFLAG=SSCNO +REFCLK=REF100' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "DP,DATA_PATH,RBR 100M"
)

test_def(
    testname    = "dp_hbr_100_no_ssc",
    build  = "dp_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_dp_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_dp_test_base +STANDARD=DP  +DP_SPEED=HBR +DP_LANE_NUM=4 +define+SERDES_WIDTH=32 +SSCFLAG=SSCNO +REFCLK=REF100' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "DP,DATA_PATH,HBR 100M"
)

test_def(
    testname    = "dp_hbr2_100_no_ssc",
    build  = "dp_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_dp_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_dp_test_base +STANDARD=DP  +DP_SPEED=HBR2 +DP_LANE_NUM=4 +define+SERDES_WIDTH=32 +SSCFLAG=SSCNO +REFCLK=REF100' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "DP,DATA_PATH,HBR2 100M"
)

test_def(
    testname    = "dp_hbr3_100_no_ssc",
    build  = "dp_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_dp_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_dp_test_base +STANDARD=DP  +DP_SPEED=HBR3 +DP_LANE_NUM=4 +define+SERDES_WIDTH=32 +SSCFLAG=SSCNO +REFCLK=REF100' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "DP,DATA_PATH,HBR3 100M"
)

test_def(
    testname    = "dp_uhbr10_100_no_ssc",
    build  = "dp_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_dp_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_dp_test_base +STANDARD=DP  +DP_SPEED=UHBR10 +DP_LANE_NUM=4 +define+SERDES_WIDTH=32 +SSCFLAG=SSCNO +REFCLK=REF100' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "DP,DATA_PATH,UHBR10 100M"
)


test_def(
    testname    = "dp_uhbr13p5_100_no_ssc",
    build  = "dp_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_dp_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_dp_test_base +STANDARD=DP  +DP_SPEED=UHBR13P5 +DP_LANE_NUM=4 +define+SERDES_WIDTH=32 +SSCFLAG=SSCNO +REFCLK=REF100' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "DP,DATA_PATH,UHBR13P5 100M"
)

test_def(
    testname    = "dp_uhbr20_100_no_ssc",
    build  = "dp_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_dp_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_dp_test_base +STANDARD=DP  +DP_SPEED=UHBR20 +DP_LANE_NUM=4 +define+SERDES_WIDTH=32 +SSCFLAG=SSCNO +REFCLK=REF100' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "DP,DATA_PATH,UHBR20 100M"
)

