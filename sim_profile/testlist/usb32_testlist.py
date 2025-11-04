import wrun_testlist_env
from wrun_testlist_env import test_def
common_args = ' '
test_def(
    testname    = "u32_gen1_bringup_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN1 ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP"
)

test_def(
    testname    = "u32_gen2_bringup_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN2 ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP"
)

test_def(
    testname    = "u32_gen1_bringup_ref100_sscno_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN1 +REFCLK=REF100 +SSCFLAG=SSCNO ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP"
)

test_def(
    testname    = "u32_gen2_bringup_ref100_sscno_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN2 +REFCLK=REF100 +SSCFLAG=SSCNO ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP"
)


test_def(
    testname    = "u32_gen1_bringup_ref192_sscno_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN1 +REFCLK=REF192 +SSCFLAG=SSCNO ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP,NOUSE"
)

test_def(
    testname    = "u32_gen2_bringup_ref192_sscno_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN2 +REFCLK=REF192 +SSCFLAG=SSCNO ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP,NOUSE"
)

test_def(
    testname    = "u32_gen1_bringup_ref24_sscno_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN1 +REFCLK=REF24 +SSCFLAG=SSCNO ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP,NOUSE"
)

test_def(
    testname    = "u32_gen2_bringup_ref24_sscno_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN2 +REFCLK=REF24 +SSCFLAG=SSCNO ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP,NOUSE"
)


test_def(
    testname    = "u32_gen1_bringup_ref192_sscen_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN1 +REFCLK=REF192 +SSCFLAG=SSCEN ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP,NOUSE"
)

test_def(
    testname    = "u32_gen2_bringup_ref192_sscen_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN2 +REFCLK=REF192 +SSCFLAG=SSCEN ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP,NOUSE"
)

test_def(
    testname    = "u32_gen1_bringup_ref24_sscen_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN1 +REFCLK=REF24 +SSCFLAG=SSCEN ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP,NOUSE"
)

test_def(
    testname    = "u32_gen2_bringup_ref24_sscen_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN2 +REFCLK=REF24 +SSCFLAG=SSCEN ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP,NOUSE"
)

test_def(
    testname    = "u32_gen1_bringup_flip1_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN1 +REFCLK=REF100 +SSCFLAG=SSCNO +FLIP_MODE ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP,FLIP"
)

test_def(
    testname    = "u32_gen2_bringup_flip1_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN2 +REFCLK=REF100 +SSCFLAG=SSCNO +FLIP_MODE ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP,FLIP"
)

test_def(
    testname    = "u32_gen1_bringup_flip0_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN1 +REFCLK=REF100 +SSCFLAG=SSCNO +NON_FLIP_MODE ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP,FLIP"
)

test_def(
    testname    = "u32_gen2_bringup_flip0_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN2 +REFCLK=REF100 +SSCFLAG=SSCNO +NON_FLIP_MODE ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP,FLIP"
)


test_def(
    testname    = "u32_gen1_bringup_ref100_sscno_1lane_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN1 +REFCLK=REF100 +SSCFLAG=SSCNO +LANECFG=1LANE ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP,CORNER,LANECFG"
)

test_def(
    testname    = "u32_gen2_bringup_ref100_sscno_1lane_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN2 +REFCLK=REF100 +SSCFLAG=SSCNO +LANECFG=1LANE ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP,CORNER,LANECFG"
)


test_def(
    testname    = "u32_gen1_bringup_ref100_sscno_2lane_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN1 +REFCLK=REF100 +SSCFLAG=SSCNO +LANECFG=2LANE ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP,CORNER,LANECFG"
)

test_def(
    testname    = "u32_gen2_bringup_ref100_sscno_2lane_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN2 +REFCLK=REF100 +SSCFLAG=SSCNO +LANECFG=2LANE ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP,CORNER,LANECFG"
)

test_def(
    testname    = "u32_gen1_bringup_ref100_sscen_2lane_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN1 +REFCLK=REF100 +SSCFLAG=SSCEN +LANECFG=2LANE ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP,SSCEN"
)

test_def(
    testname    = "u32_gen2_bringup_ref100_sscen_2lane_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN2 +REFCLK=REF100 +SSCFLAG=SSCEN +LANECFG=2LANE ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP,SSCEN"
)

test_def(
    testname    = "u32_gen1_bringup_ref100_sscen_1lane_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN1 +REFCLK=REF100 +SSCFLAG=SSCEN +LANECFG=1LANE ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP,SSCEN"
)

test_def(
    testname    = "u32_gen2_bringup_ref100_sscen_1lane_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN2 +REFCLK=REF100 +SSCFLAG=SSCEN +LANECFG=1LANE ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,BRINGUP,SSCEN"
)

test_def(
    testname    = "u32_gen1_lowpowerU1_ref100_sscno_2lane_test",
    build  = "usb32_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb32_lowpower_base_test +UVM_VSEQ_NAME=cdn_u4_usb32_lowpower_base_sequence +STANDARD=USB32 +USB32_SPEED=USB32_GEN1 +REFCLK=REF100 +SSCFLAG=SSCNO +LANECFG=2LANE ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB32,JUNQIANG,LOWPOWERU1,LANE2"
)






