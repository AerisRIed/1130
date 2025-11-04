#-------------------------------------------------------------------------------------------------
#-   This confidential and proprietary HVL soft description of a Hardware Verification Component 
#-   may be used only as authorized by a licensing agreement from Cadence Design Systems, Inc.. 
#-   In the event of publication, the following notice is applicable:
#-
#-                    (C) COPYRIGHT 2015 Cadence Design Systems, Inc.
#-                                ALL RIGHTS RESERVED
#-
#-    The entire notice above must be reproduced on all authorized copies of this code.
#-------------------------------------------------------------------------------------------------
#- File URL       : $URL:$
#- Version        : $Revision:$
#- Orignal Author : Louis-Pierre Lafrance
#- Last Changed   : $LastChangedBy: $
#-                : $LastChangedDate:  $
#-------------------------------------------------------------------------------------------------
#- Description    :
#-   
#------------------------------------------------------------------------------------
import os
import sys
import re
import time

#tech = sys.argv[1]
orinal_file = sys.argv[1]
#orinal_file2 = sys.argv[3]
#orinal_file3 = sys.argv[4]

#time.sleep(30);

# 提取文件名并动态生成reg_db名称
def extract_reg_db_name(filename):
    # 从文件路径中提取文件名（去掉路径）
    basename = os.path.basename(filename)
    # 去掉文件扩展名
    name_without_ext = os.path.splitext(basename)[0]
    
    # 使用正则表达式匹配新的模式：cdn_phy_xxx_regs_rdb
    # 匹配cdn_开头，然后捕获中间部分，最后以_regs_rdb结尾
    match = re.match(r'cdn_(.+)_regs_rdb', name_without_ext)
    if match:
        # 提取cdn_后面的部分，例如从"cdn_phy_pcs_cmn_regs_rdb"中提取"phy_pcs_cmn"
        extracted_part = match.group(1)
        return f"{extracted_part}_registers"
    else:
        # 如果不匹配模式，返回默认值
        return "cdn_eusb2v2_reg_db"

# 提取文件名并动态生成包名
def extract_pkg_name(filename):
    # 从文件路径中提取文件名（去掉路径）
    basename = os.path.basename(filename)
    # 去掉文件扩展名
    name_without_ext = os.path.splitext(basename)[0]
    
    # 情况1：匹配cdn_phy_xxx_regs_rdb格式
    match1 = re.match(r'cdn_(.+)_regs_rdb', name_without_ext)
    if match1:
        # 提取cdn_后面的部分，例如从"cdn_phy_pcs_cmn_regs_rdb"中提取"phy_pcs_cmn"
        extracted_part = match1.group(1)
        return f"cdns_uvmreg_utils_pkg_{extracted_part}_registers"
    
    # 情况2：匹配cdns_uvmreg_utils_pkg_xxx_registers格式
    match2 = re.match(r'cdns_uvmreg_utils_pkg_(.+)_registers', name_without_ext)
    if match2:
        # 提取中间的部分，例如从"cdns_uvmreg_utils_pkg_phy_pcs_cmn_registers"中提取"phy_pcs_cmn"
        extracted_part = match2.group(1)
        return f"cdns_uvmreg_utils_pkg_{extracted_part}_registers"
    
    # 情况3：直接是cdns_uvmreg_utils_pkg
    if name_without_ext == 'cdns_uvmreg_utils_pkg':
        return "cdns_uvmreg_utils_pkg"
    
    # 如果都不匹配，返回默认值
    return "cdns_uvmreg_utils_pkg"

# 生成动态的替换字符串
reg_db_name = extract_reg_db_name(orinal_file)
print(reg_db_name)
need_sub = 'get_reg_config({\"' + reg_db_name + '\", config_path});'
print(need_sub)
sub_s= 'CDNS_UVMREG_CONFIG_DATA_DIR $PHY_VERIF_AREA/reg_model/reg_model_cdn_usb_phy_top_reg/uvmreg'

# 生成动态的包名替换字符串
pkg_name = extract_pkg_name(orinal_file)
print(f"Package name: {pkg_name}")

# 添加函数来处理cdns_uvmreg_utils_pkg文件的特殊处理
def handle_uvmreg_utils_pkg(file_path):
    with open(file_path, 'r') as f:
        lines = f.readlines()
    
    modified_lines = []
    endpackage_found = False
    
    for line in lines:
        if 'endpackage' in line and not endpackage_found:
            modified_lines.append(line)
            endpackage_found = True
            break  # 找到endpackage后停止添加后续行
        else:
            modified_lines.append(line)
    
    # 写回文件
    with open(file_path, 'w') as f:
        f.writelines(modified_lines)
    
    if endpackage_found:
        print(f"已删除 {file_path} 中 endpackage 后的所有内容")
    else:
        print(f"警告: 在 {file_path} 中未找到 endpackage")

# 添加函数来处理include语句的插入
def insert_includes_in_file(file_path):
    with open(file_path, 'r') as f:
        lines = f.readlines()
    
    # 首先检查include语句是否已经存在
    cdn_regmodel_task_exists = False
    cdn_regmodel_task_member_exists = False
    
    for line in lines:
        if '`include "cdn_regmodel_task.sv"' in line:
            cdn_regmodel_task_exists = True
        if '`include "cdn_regmodel_task_member.sv"' in line:
            cdn_regmodel_task_member_exists = True
    
    # 如果两个include语句都已经存在，直接返回，不需要修改
    if cdn_regmodel_task_exists and cdn_regmodel_task_member_exists:
        print(f"Include语句已存在于 {file_path}，跳过插入")
        return
    
    modified_lines = []
    found_cdns_lib_version = False
    endclass_inserted = False
    void_build_inserted = False
    
    for i, line in enumerate(lines):
        # 检查是否找到cdns_lib_version_1685_2009字段
        if 'cdns_lib_version_1685_2009' in line:
            found_cdns_lib_version = True
        
        # 如果已经找到cdns_lib_version字段，开始查找插入点
        if found_cdns_lib_version:
            # 查找下一个endclass并在上一行插入include "cdn_regmodel_task.sv"
            if 'endclass' in line and not endclass_inserted and not cdn_regmodel_task_exists:
                modified_lines.append('`include "cdn_regmodel_task.sv"\n')
                endclass_inserted = True
                print(f"已在 {file_path} 中插入 cdn_regmodel_task.sv include语句")
            
            # 查找下一个void build并在上一行插入include "cdn_regmodel_task_member.sv"
            if 'void build' in line and not void_build_inserted and not cdn_regmodel_task_member_exists:
                modified_lines.append('`include "cdn_regmodel_task_member.sv"\n')
                void_build_inserted = True
                print(f"已在 {file_path} 中插入 cdn_regmodel_task_member.sv include语句")
        
        modified_lines.append(line)
    
    # 写回文件
    with open(file_path, 'w') as f:
        f.writelines(modified_lines)

# 检查是否是cdns_uvmreg_utils_pkg文件
basename = os.path.basename(orinal_file)
name_without_ext = os.path.splitext(basename)[0]
is_uvmreg_utils_pkg = (name_without_ext == 'cdns_uvmreg_utils_pkg')

# 首先进行原有的替换操作
fp = open(orinal_file,'r+')  
lines = open(orinal_file).readlines()
fp.seek(0)  # 重置文件指针到开始
fp.truncate()  # 清空文件内容
for s in lines:
	fp.write( s.replace(need_sub,f'get_reg_config("{reg_db_name}.sd3101_t4_registers_sd3101_phy_registers");').replace('CDNS_UVMREG_CONFIG_DATA_DIR .',sub_s).replace('cdns_uvmreg_utils_pkg', pkg_name))   
fp.close()  

# 根据文件类型进行不同的处理
if is_uvmreg_utils_pkg:
    # 如果是cdns_uvmreg_utils_pkg文件，删除endpackage后的内容
    handle_uvmreg_utils_pkg(orinal_file)
else:
    # 其他文件进行include语句的插入
    insert_includes_in_file(orinal_file)
