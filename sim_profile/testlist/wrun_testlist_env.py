import os
import sys
# sim_ctrl/testlist directory
current_dir = os.path.dirname(os.path.abspath(__file__))

# sim_ctrl parent directory (two levels up from current_dir)
sim_ctrl_parent = os.path.dirname(os.path.dirname(current_dir))

# core common path (absolute path to where wrun_core.py is located)
common_path = os.getenv("WRUN_DIR")  # replace with your actual common dir

# Add the common path into sys.path if it's not already there
if common_path not in sys.path:
    sys.path.insert(0, common_path)

import wrun_core

# core_list = ['cm3', 'ap_cpu', 'sme', 'cr8']
# common_opts ='echo common_opts;\n'#TODO './build/simv -timescale=1ns/1ps +notimingcheck -l simv.log  -ucli -i job.tcl'

common_opts = ' xrun -R -xmlibdirname ./build/xcelium.d/ -l sim.log -sysv_ext +.v -vlog_ext +.vh -uvm -uvmhome ${UVM_HOME} -define UVM_NO_DEPRECATED   -assert  -notimingchecks -64bit -licqueue  +access+rwc  -clean -input job.tcl  ' #+UVM_TESTNAME=cdn_u4_usb32_test_base +STANDARD=USB32 +USB32_SPEED=USB32_GEN2   #for dump : +vwdb+shm2vwdb=1 -debug_opts verisium_pp
common_opts_added      = ' '
common_opts_added     += ' -simlogsize 500 '
common_opts_added     += ' -errormax   300 '
common_opts_added     += ' -noprimupdate '
common_opts_added     += ' -run -exit '
common_opts_added     += ' -xmsimargs -loadrun ${CDN_VIP_LIB_PATH}/libcdnvipcuvm.so '
common_opts_added     += ' -xmsimargs -loadrun ${CDN_VIP_LIB_PATH}/libPsif.so '

def test_def(testname='', build='', sim_args='', pre_sim='', tag='', repeat=None):
    # pre_sim += 'echo hello_sim;'

    sim_args_tmp = common_opts  + common_opts_added
    sim_args_tmp += sim_args

    wrun_core.deal_testcase(testname=testname, build=build, sim_args=sim_args_tmp, pre_sim=pre_sim, tag=tag, repeat=repeat)
