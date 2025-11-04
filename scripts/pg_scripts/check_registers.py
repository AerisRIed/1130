import re
import os
import xml.etree.ElementTree as ET
from pathlib import Path
from typing import Set, List
from collections import defaultdict

def extract_register_names(sv_file: str) -> Set[str]:
    """从 SystemVerilog 文件中提取寄存器名"""
    register_names = set()
    
    # 正则表达式匹配 write_dut_register("register_name", value)
    pattern = r'write_dut_register\("([^"]+)"'
    
    try:
        with open(sv_file, 'r', encoding='utf-8') as f:
            content = f.read()
            matches = re.findall(pattern, content)
            register_names.update(matches)
    except Exception as e:
        print(f"读取文件错误: {e}")
        return set()
    
    return register_names

def search_register_in_xml(xml_file: str, register_name: str) -> bool:
    """在 XML 文件中搜索寄存器名"""
    try:
        tree = ET.parse(xml_file)
        root = tree.getroot()
        
        # 转换为字符串进行搜索
        xml_content = ET.tostring(root, encoding='unicode')
        
        # 搜索寄存器名（不区分大小写）
        return register_name.lower() in xml_content.lower()
    except Exception as e:
        # 忽略解析错误，继续处理
        return False

def find_xml_files(directory: str) -> List[str]:
    """查找目录下所有的 XML 文件"""
    xml_files = []
    try:
        for root, dirs, files in os.walk(directory):
            for file in files:
                if file.endswith('.xml'):
                    xml_files.append(os.path.join(root, file))
    except Exception as e:
        print(f"查找 XML 文件错误: {e}")
    
    return xml_files

def main():
    # 文件路径配置
    sv_file = r"c:\zming\cdn_project\Timberwolf_USB4_T4GP\verif\scripts\pg_scripts\cdn_phy_bring_up_task.sv"
    xml_directory = r"c:\zming\cdn_project\Timberwolf_USB4_T4GP\verif\reg_model\ipxact"
    
    print("=" * 80)
    print("寄存器查找工具")
    print("=" * 80)
    
    # 1. 提取寄存器名
    print(f"\n正在从 {sv_file} 提取寄存器名...")
    register_names = extract_register_names(sv_file)
    print(f"找到 {len(register_names)} 个唯一的寄存器")
    
    # 2. 查找所有 XML 文件
    print(f"\n正在查找 {xml_directory} 目录下的 XML 文件...")
    xml_files = find_xml_files(xml_directory)
    print(f"找到 {len(xml_files)} 个 XML 文件")
    
    if not xml_files:
        print(f"错误: 在 {xml_directory} 目录下没有找到 XML 文件")
        return
    
    # 3. 检查每个寄存器
    print(f"\n开始检查寄存器...")
    print("=" * 80)
    
    not_found_registers = []
    found_count = 0
    register_details = defaultdict(list)
    
    for idx, reg_name in enumerate(sorted(register_names), 1):
        found = False
        found_in_files = []
        
        # 在所有 XML 文件中搜索
        for xml_file in xml_files:
            if search_register_in_xml(xml_file, reg_name):
                found = True
                found_in_files.append(os.path.basename(xml_file))
        
        if found:
            found_count += 1
            register_details[reg_name] = found_in_files
            print(f"[{idx}/{len(register_names)}] ✓ {reg_name} - 找到 (在 {len(found_in_files)} 个文件中)")
        else:
            not_found_registers.append(reg_name)
            print(f"[{idx}/{len(register_names)}] ✗ {reg_name} - 未找到")
    
    # 4. 汇总报告
    print("\n" + "=" * 80)
    print("检查完成 - 汇总报告")
    print("=" * 80)
    print(f"总寄存器数: {len(register_names)}")
    print(f"找到的寄存器: {found_count}")
    print(f"未找到的寄存器: {len(not_found_registers)}")
    if len(register_names) > 0:
        print(f"覆盖率: {found_count/len(register_names)*100:.2f}%")
    
    if not_found_registers:
        print("\n未找到的寄存器列表:")
        print("-" * 80)
        for reg in sorted(not_found_registers):
            print(f"  ✗ {reg}")
    else:
        print("\n✓ 所有寄存器都已找到!")
    
    # 5. 保存详细报告到文件
    report_file = "register_check_report.txt"
    with open(report_file, 'w', encoding='utf-8') as f:
        f.write("寄存器检查详细报告\n")
        f.write("=" * 80 + "\n\n")
        f.write(f"总寄存器数: {len(register_names)}\n")
        f.write(f"找到的寄存器: {found_count}\n")
        f.write(f"未找到的寄存器: {len(not_found_registers)}\n")
        if len(register_names) > 0:
            f.write(f"覆盖率: {found_count/len(register_names)*100:.2f}%\n\n")
        
        f.write("找到的寄存器详情:\n")
        f.write("-" * 80 + "\n")
        for reg_name in sorted(register_details.keys()):
            f.write(f"\n{reg_name}:\n")
            for xml_file in register_details[reg_name]:
                f.write(f"  - {xml_file}\n")
        
        if not_found_registers:
            f.write("\n\n未找到的寄存器:\n")
            f.write("-" * 80 + "\n")
            for reg in sorted(not_found_registers):
                f.write(f"  - {reg}\n")
    
    print(f"\n详细报告已保存到: {report_file}")

if __name__ == "__main__":
    main()
