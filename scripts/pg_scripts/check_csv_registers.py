import csv
import os
import xml.etree.ElementTree as ET
from pathlib import Path
from typing import Set, List, Dict, Tuple
from collections import defaultdict
import re

def extract_register_names_from_csv(csv_file: str) -> Dict[str, str]:
    """从 CSV 文件中提取寄存器名及其类型
    返回: {register_name_lowercase: register_type}
    """
    register_info = {}
    
    try:
        with open(csv_file, 'r', encoding='utf-8') as f:
            for line in f:
                # 匹配格式: PMA_REG: REGISTER_NAME 或 PCS_REG: REGISTER_NAME 或 PHY_REG: REGISTER_NAME
                match = re.match(r'^(PMA_REG|PCS_REG|PHY_REG):\s*([^,]+)', line)
                if match:
                    reg_type = match.group(1)
                    reg_name = match.group(2).strip()
                    # 转换为小写作为key，但保存原始类型
                    register_info[reg_name.lower()] = reg_type
    except Exception as e:
        print(f"  警告: 读取文件 {os.path.basename(csv_file)} 时出错: {e}")
        return {}
    
    return register_info

def find_csv_files(directory: str) -> List[str]:
    """查找目录下所有的 CSV 文件"""
    csv_files = []
    try:
        for root, dirs, files in os.walk(directory):
            for file in files:
                if file.endswith('.csv'):
                    csv_files.append(os.path.join(root, file))
    except Exception as e:
        print(f"查找 CSV 文件错误: {e}")
    
    return csv_files

def search_register_in_xml(xml_file: str, register_name: str) -> bool:
    """在 XML 文件中搜索寄存器名（不区分大小写）"""
    try:
        tree = ET.parse(xml_file)
        root = tree.getroot()
        
        # 转换为字符串进行搜索
        xml_content = ET.tostring(root, encoding='unicode').lower()
        
        # 搜索寄存器名（已转换为小写）
        return register_name.lower() in xml_content
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
    csv_directory = r"c:\zming\cdn_project\Timberwolf_USB4_T4GP\verif\scripts\pg_scripts\pg_csv"
    xml_directory = r"c:\zming\cdn_project\Timberwolf_USB4_T4GP\verif\reg_model\ipxact"
    
    print("=" * 80)
    print("CSV 寄存器查找工具")
    print("=" * 80)
    
    # 1. 查找所有 CSV 文件
    print(f"\n正在查找 {csv_directory} 目录下的 CSV 文件...")
    csv_files = find_csv_files(csv_directory)
    print(f"找到 {len(csv_files)} 个 CSV 文件")
    
    if not csv_files:
        print(f"错误: 在 {csv_directory} 目录下没有找到 CSV 文件")
        return
    
    # 2. 从所有 CSV 文件中提取寄存器名
    print(f"\n正在从 CSV 文件中提取寄存器名...")
    all_registers = set()
    csv_register_map = defaultdict(list)  # 记录每个寄存器来自哪些CSV文件
    register_type_map = {}  # 记录每个寄存器的类型 (PMA_REG/PCS_REG/PHY_REG)
    
    for csv_file in csv_files:
        csv_name = os.path.basename(csv_file)
        register_info = extract_register_names_from_csv(csv_file)
        print(f"  {csv_name}: {len(register_info)} 个寄存器")
        all_registers.update(register_info.keys())
        
        # 记录寄存器来源和类型
        for reg, reg_type in register_info.items():
            csv_register_map[reg].append(csv_name)
            # 如果同一个寄存器有多种类型，保存第一个遇到的类型
            if reg not in register_type_map:
                register_type_map[reg] = reg_type
    
    print(f"\n总共提取到 {len(all_registers)} 个唯一的寄存器（已转换为小写）")
    
    # 3. 查找所有 XML 文件
    print(f"\n正在查找 {xml_directory} 目录下的 XML 文件...")
    xml_files = find_xml_files(xml_directory)
    print(f"找到 {len(xml_files)} 个 XML 文件:")
    for xml_file in xml_files:
        print(f"  - {os.path.basename(xml_file)}")
    
    if not xml_files:
        print(f"错误: 在 {xml_directory} 目录下没有找到 XML 文件")
        return
    
    # 4. 检查每个寄存器
    print(f"\n开始检查寄存器...")
    print("=" * 80)
    
    not_found_registers = []
    found_count = 0
    register_details = defaultdict(list)
    
    for idx, reg_name in enumerate(sorted(all_registers), 1):
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
            print(f"[{idx}/{len(all_registers)}] ✓ {reg_name} - 找到 (在 {len(found_in_files)} 个 XML 文件中)")
        else:
            not_found_registers.append(reg_name)
            print(f"[{idx}/{len(all_registers)}] ✗ {reg_name} - 未找到")
    
    # 5. 汇总报告
    print("\n" + "=" * 80)
    print("检查完成 - 汇总报告")
    print("=" * 80)
    print(f"总寄存器数: {len(all_registers)}")
    print(f"找到的寄存器: {found_count}")
    print(f"未找到的寄存器: {len(not_found_registers)}")
    if len(all_registers) > 0:
        print(f"覆盖率: {found_count/len(all_registers)*100:.2f}%")
    
    if not_found_registers:
        print(f"\n未找到的寄存器列表 (共 {len(not_found_registers)} 个):")
        print("-" * 80)
        for reg in sorted(not_found_registers):
            print(f"  ✗ {reg}")
            # 显示该寄存器来自哪些CSV文件
            source_csvs = csv_register_map[reg]
            if len(source_csvs) <= 3:
                print(f"     来源: {', '.join(source_csvs)}")
            else:
                print(f"     来源: {len(source_csvs)} 个 CSV 文件")
        
        # 汇总显示所有未找到的寄存器名字
        print("\n" + "=" * 80)
        print("未找到的寄存器名字汇总")
        print("=" * 80)
        print("\n以下寄存器在 XML 文件中未找到：\n")
        for idx, reg in enumerate(sorted(not_found_registers), 1):
            reg_type = register_type_map.get(reg, "UNKNOWN")
            print(f"{idx:3d}. {reg} ({reg_type})")
        
        # 逐个显示未找到的寄存器详细信息
        print("\n" + "=" * 80)
        print("未找到的寄存器详细信息")
        print("=" * 80)
        for idx, reg in enumerate(sorted(not_found_registers), 1):
            reg_type = register_type_map.get(reg, "UNKNOWN")
            print(f"\n[{idx}/{len(not_found_registers)}] 寄存器名: {reg} ({reg_type})")
            print("-" * 80)
            source_csvs = csv_register_map[reg]
            print(f"来源 CSV 文件数量: {len(source_csvs)}")
            print(f"来源 CSV 文件列表:")
            for csv_name in sorted(source_csvs):
                print(f"  - {csv_name}")
    else:
        print("\n✓ 所有寄存器都已找到!")
    
    # 6. 保存详细报告到文件
    report_file = "csv_register_check_report.txt"
    with open(report_file, 'w', encoding='utf-8') as f:
        f.write("CSV 寄存器检查详细报告\n")
        f.write("=" * 80 + "\n\n")
        f.write(f"CSV 文件数量: {len(csv_files)}\n")
        f.write(f"总寄存器数: {len(all_registers)}\n")
        f.write(f"找到的寄存器: {found_count}\n")
        f.write(f"未找到的寄存器: {len(not_found_registers)}\n")
        if len(all_registers) > 0:
            f.write(f"覆盖率: {found_count/len(all_registers)*100:.2f}%\n\n")
        
        f.write("\nCSV 文件列表:\n")
        f.write("-" * 80 + "\n")
        for csv_file in csv_files:
            f.write(f"  - {os.path.basename(csv_file)}\n")
        
        f.write("\n\nXML 文件列表:\n")
        f.write("-" * 80 + "\n")
        for xml_file in xml_files:
            f.write(f"  - {os.path.basename(xml_file)}\n")
        
        # 添加未找到的寄存器汇总
        if not_found_registers:
            f.write("\n\n" + "=" * 80 + "\n")
            f.write("未找到的寄存器名字汇总\n")
            f.write("=" * 80 + "\n\n")
            f.write("以下寄存器在 XML 文件中未找到：\n\n")
            for idx, reg in enumerate(sorted(not_found_registers), 1):
                reg_type = register_type_map.get(reg, "UNKNOWN")
                f.write(f"{idx:3d}. {reg} ({reg_type})\n")
        
        f.write("\n\n找到的寄存器详情:\n")
        f.write("-" * 80 + "\n")
        for reg_name in sorted(register_details.keys()):
            f.write(f"\n{reg_name}:\n")
            f.write(f"  来源 CSV: {', '.join(csv_register_map[reg_name][:3])}")
            if len(csv_register_map[reg_name]) > 3:
                f.write(f" ... (共 {len(csv_register_map[reg_name])} 个)")
            f.write(f"\n")
            f.write(f"  找到于 XML: {', '.join(register_details[reg_name])}\n")
        
        if not_found_registers:
            f.write("\n\n未找到的寄存器详情:\n")
            f.write("=" * 80 + "\n")
            for reg in sorted(not_found_registers):
                reg_type = register_type_map.get(reg, "UNKNOWN")
                f.write(f"\n{reg} ({reg_type}):\n")
                source_csvs = csv_register_map[reg]
                f.write(f"  来源 CSV 文件:\n")
                for csv_name in source_csvs:
                    f.write(f"    - {csv_name}\n")
    
    print(f"\n详细报告已保存到: {report_file}")

if __name__ == "__main__":
    main()
