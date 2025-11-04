import wrun_testlist_env
from wrun_testlist_env import test_def
common_args = ' '
test_def(
    testname    = "usb4_message_test",
    build  = "usb4_base_build",
   #  sim_args    = " +UVM_TESTNAME=cdn_usb4_sanity_test +DATARATE=2500M ",
    sim_args = ' +UVM_TESTNAME=cdn_message_bus_test +STANDARD=USB4 +SSCFLAG=SSCNO ' + common_args,
    #pre_sim  = "ln -s config.vh $prj_path/xxx/xxx/xx/a.vh",
    # confg_name = "",
    tag      = "USB4,MESSAGE,XUAN"
)

#####100M refclk test###########
test_def(
    testname    = "usb4_gen2_base_test",
    build  = "usb4_base_build",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb4_test_base +STANDARD=USB4  +USB4_SPEED=USB4_GEN2 +REFCLK=REF100 +FLIP_MODE +SSCFLAG=SSCEN' + common_args,
    tag      = "USB4,DATA_PATH,XUAN"
)
test_def(
    testname    = "usb4_gen3_base_test",
    build  = "usb4_base_build",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb4_test_base +STANDARD=USB4  +USB4_SPEED=USB4_GEN3 +REFCLK=REF100 +FLIP_MODE +SSCFLAG=SSCNO' + common_args,
    tag      = "USB4,DATA_PATH,XUAN"
)


#####24M refclk test###########
test_def(
    testname    = "usb4_gen2_base_test_24M",
    build  = "usb4_base_build",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb4_test_base +STANDARD=USB4  +USB4_SPEED=USB4_GEN2 +REFCLK=REF24 +FLIP_MODE +SSCFLAG=SSCEN' + common_args,
    tag      = "USB4,DATA_PATH,XUAN"
)
test_def(
    testname    = "usb4_gen3_base_test_24M",
    build  = "usb4_base_build",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb4_test_base +STANDARD=USB4  +USB4_SPEED=USB4_GEN3 +REFCLK=REF24 +FLIP_MODE +SSCFLAG=SSCEN' + common_args,
    tag      = "USB4,DATA_PATH,XUAN"
)

test_def(
    testname    = "usb4_gen2_base_test_24M_flip_mode",
    build  = "usb4_base_build",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb4_test_base +STANDARD=USB4  +USB4_SPEED=USB4_GEN2 +REFCLK=REF24 +FLIP_MODE +SSCFLAG=SSCNO' + common_args,
    tag      = "USB4,DATA_PATH,XUAN"
)
test_def(
    testname    = "usb4_gen3_base_test_24M_flip_mode",
    build  = "usb4_base_build",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb4_test_base +STANDARD=USB4  +USB4_SPEED=USB4_GEN3 +REFCLK=REF24 +FLIP_MODE +SSCFLAG=SSCNO' + common_args,
    tag      = "USB4,DATA_PATH,XUAN"
)

test_def(
    testname    = "usb4_gen2_base_test_24M_ssc_mode",
    build  = "usb4_base_build",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb4_test_base +STANDARD=USB4  +USB4_SPEED=USB4_GEN2 +REFCLK=REF24 +SSCFLAG=SSCEN' + common_args,
    tag      = "USB4,DATA_PATH,XUAN"
)
test_def(
    testname    = "usb4_gen3_base_test_24M_ssc_mode",
    build  = "usb4_base_build",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb4_test_base +STANDARD=USB4  +USB4_SPEED=USB4_GEN3 +REFCLK=REF24 +SSCFLAG=SSCEN' + common_args,
    tag      = "USB4,DATA_PATH,XUAN"
)


#####19p2 refclk test###########
test_def(
    testname    = "usb4_gen2_base_test_19p2M",
    build  = "usb4_base_build",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb4_test_base +STANDARD=USB4  +USB4_SPEED=USB4_GEN2 +REFCLK=REF19P2 +FLIP_MODE +SSCFLAG=SSCNO' + common_args,
    tag      = "USB4,DATA_PATH,XUAN"
)
test_def(
    testname    = "usb4_gen3_base_test_19p2M",
    build  = "usb4_base_build",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb4_test_base +STANDARD=USB4  +USB4_SPEED=USB4_GEN3 +REFCLK=REF19P2 +FLIP_MODE +SSCFLAG=SSCNO' + common_args,
    tag      = "USB4,DATA_PATH,XUAN"
)

#test_def(
#    testname    = "usb4_gen2_base_test_24M_flip_mode",
#    build  = "usb4_base_build",
#    sim_args = ' +UVM_TESTNAME=cdn_u4_usb4_test_base +STANDARD=USB4  +USB4_SPEED=USB4_GEN2 +REFCLK=REF24 +FLIP_MODE +SSCFLAG=SSCNO' + common_args,
#    tag      = "USB4,DATA_PATH,XUAN"
#)
#test_def(
#    testname    = "usb4_gen3_base_test_24M_flip_mode",
#    build  = "usb4_base_build",
#    sim_args = ' +UVM_TESTNAME=cdn_u4_usb4_test_base +STANDARD=USB4  +USB4_SPEED=USB4_GEN3 +REFCLK=REF24 +FLIP_MODE +SSCFLAG=SSCNO' + common_args,
#    tag      = "USB4,DATA_PATH,XUAN"
#)
#
#test_def(
#    testname    = "usb4_gen2_base_test_24M_ssc_mode",
#    build  = "usb4_base_build",
#    sim_args = ' +UVM_TESTNAME=cdn_u4_usb4_test_base +STANDARD=USB4  +USB4_SPEED=USB4_GEN2 +REFCLK=REF24 +SSCFLAG=SSCEN' + common_args,
#    tag      = "USB4,DATA_PATH,XUAN"
#)
#test_def(
#    testname    = "usb4_gen3_base_test_24M_ssc_mode",
#    build  = "usb4_base_build",
#    sim_args = ' +UVM_TESTNAME=cdn_u4_usb4_test_base +STANDARD=USB4  +USB4_SPEED=USB4_GEN3 +REFCLK=REF24 +SSCFLAG=SSCEN' + common_args,
#    tag      = "USB4,DATA_PATH,XUAN"
#)
#

test_def(
    testname    = "usb4_gen2_base_mlm_test",
    build  = "usb4_base_mlm_build",
    sim_args = ' +UVM_TESTNAME=cdn_u4_usb4_test_base +STANDARD=USB4  +USB4_SPEED=USB4_GEN2 +REFCLK=REF100 +FLIP_MODE +SSCFLAG=SSCNO' + common_args,
    tag      = "USB4,DATA_PATH,XUAN,MLM"
)


test_def(
    testname    = "usb4_vip_base_test",
    build  = "usb4_vip_build",
    sim_args = ' -write_metrics -covoverwrite \
	-sv_lib ${CDN_VIP_LIB_PATH}/64bit/libcdnvipcuvm.so \
	+UVM_TESTNAME=cdnUsb4UvmUserMultiProtTest' + common_args,
    pre_sim  = "cp -rf ${PHY_VERIF_AREA}/u4_vip/examples/multiProtocol/uvmConfigPipeExamplePhyDut/.denalirc ./;",
    tag      = "USB4,VIP,XUAN"
)

test_def(
    testname    = "usb4_vip_tb_base_test",
    build  = "usb4_vip_tb_build",
    sim_args = ' -write_metrics -covoverwrite \
	-sv_lib ${CDN_VIP_LIB_PATH}/64bit/libcdnvipcuvm.so \
	+UVM_TESTNAME=cdn_u4_usb4_vip_test_base +STANDARD=USB4  +USB4_SPEED=USB4_GEN2 +REFCLK=REF100 +FLIP_MODE +SSCFLAG=SSCNO' + common_args,
    pre_sim  = "cp -rf ${PHY_VERIF_AREA}/u4_vip/examples/multiProtocol/uvmConfigPipeExamplePhyDut/.denalirc ./;",
    tag      = "USB4,VIP,XUAN,TB"
)

test_def(
    testname    = "usb4_vip_lowpower_cl2_test",
    build  = "usb4_vip_build",
    sim_args = ' -write_metrics -covoverwrite \
	-sv_lib ${CDN_VIP_LIB_PATH}/64bit/libcdnvipcuvm.so \
	+UVM_TESTNAME=cdnUsb4UvmUserLowPowerCl2Test' + common_args,
    pre_sim  = "cp -rf /projects/sd3101_n4p/users/xuanzhang/Timberwolf_USB4_T4GP/verif/u4_vip/examples/multiProtocol/uvmConfigPipeExamplePhyDut/.denalirc ./;",
    tag      = "USB4,VIP,XUAN"
)

