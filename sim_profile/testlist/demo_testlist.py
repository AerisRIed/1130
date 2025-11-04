import wrun_testlist_env
from wrun_testlist_env import test_def
common_args = ' '
test_def(
    testname    = "usb32_demo_test",
    build  = "usb32_demo_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN2 ' + common_args,
    pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB4_SANITY, DATARATE_2500M"
)