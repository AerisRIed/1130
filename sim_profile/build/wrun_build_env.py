import os
import sys
# sim_ctrl/build
current_dir = os.path.dirname(os.path.abspath(__file__))

# sim_ctrl father cidr
sim_ctrl_parent = os.path.dirname(os.path.dirname(current_dir))

# core common path
common_path = os.getenv("WRUN_DIR")  # my acture common dir
# print(common_path)
# add common path into sys.path
if common_path not in sys.path:
    sys.path.insert(0, common_path)

import wrun_core
import pickle
from wrun_core import pre_deal_build_path

# all_inherit_builds_opt = {}
initial_build = ''
common_args = ' xrun   -timescale 1ns/1ps   -l comp.log   +access+rwc   -sysv_ext +.v   -vlog_ext +.vh   -define UVM_NO_DEPRECATED     -assert   -notimingchecks   -64bit   -licqueue   -top cdn_phy_tb_top    +vwdb+shm2vwdb=1     -lwdgen -createdebugdb -c -clean -f all.f  '#TODO add common xrun option :-f ../top/tb_filelist.f
common_args_added = ' '
common_args_added += ' -message '
common_args_added += ' -xfile $PHY_VERIF_AREA/sim_profile/config/xfile.txt -xverbose -xlog xlog.log '
common_args_added += ' -mindelays '
common_args_added += ' +pulse_r/0 '
common_args_added += ' +pulse_e/0 '
common_args_added += ' +pulse_int_r/0 '
common_args_added += ' +pulse_int_e/0 '
common_args_added += ' +transport_path_delays '
common_args_added += ' -xminitial x '
common_args_added += ' -fsmdebug '
common_args_added += ' -noprimupdate '
common_args_added += ' -unbuffered '

common_args_added += ' -uvmhome ${UVM_HOME}'
common_args_added += ' -cdn_vip_root ${CDN_VIP_ROOT} '
common_args_added += ' -define DENALI_UVM '
common_args_added += ' -loadvpi ${DENALI}/verilog/libcdnsv.so:cdnsvVIP:export '
common_args_added += ' -define CDN_APB_USING_CLOCKING_BLOCK '
common_args_added += ' -define CDN_AUTO_TEST '

common_rtl = ' ' #common rtl filelist


def build_def(inherit_build='', build_name='', comp_args='', tb_fl='',dut_fl = '' ,pre_build=''):
    all_fl_list=[]
    if os.getenv('RUN_MODE') == 'DEAL_INHERIT_BUILD':
        #print("IN DEAL_INHERIT_BUILD")
        wrun_core.pre_deal_build_var_pkl_gen(inherit_build=inherit_build, build=build_name)
    elif os.getenv('RUN_MODE') == 'MAIN':
        # expand filelist in pre_build phase
        if inherit_build != '':
            comp_args_tmp, tb_fl , dut_fl= deal_inherit_build(inherit_build, build_name, comp_args, tb_fl , dut_fl)

      #   pre_build += 'cat ' + tb_fl + dut_fl + ' > all.f ' + ' & ;'  + 'echo hello_build ;'
        # print(dut_fl)
        # print(tb_fl.split())#debug
        all_fl_list.extend(dut_fl.split())
        all_fl_list.extend(tb_fl.split())
        # print(all_fl_list)#debug
        pre_build += ': > all.f\n'
        for fl in all_fl_list:
            # print(fl)
            pre_build += 'echo ' + ' -f ' + fl + ' >> all.f \n'
        # pre_build += '\necho PRE_BUILD_common'
        # del comp_args
        comp_args_tmp = common_args + common_args_added
        comp_args_tmp += comp_args
        # deal nowarn
        with open(os.path.expandvars('${PHY_VERIF_AREA}/sim_profile/config/nowarn_list'), "r", encoding="utf-8") as f:
            lines = f.readlines()
            if lines:
                for line in lines:
                    comp_args_tmp += f" -nowarn {line.strip()} "
        
        wrun_core.deal_build(inherit_build=inherit_build, build=build_name, comp_args=comp_args_tmp, pre_build=pre_build)


def deal_inherit_build(inherit_build, build_name, comp_args, tb_fl, dut_fl):
    return comp_args, tb_fl , dut_fl##TODO:add inherit build function
