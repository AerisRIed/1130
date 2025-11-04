#################################################
# Generate ECC (Error Correction Code) for data
# Created by zming
# 2025-10-10
# Updated: 2025-10-13
# Algorithm: DesignWare Legacy ECC (NOT standard Hamming!)
# Matches: CW_ecc_legacy_width32_chkbits7_synd_sel1.v
# python3 verif/scripts/fm_scripts/gen_ecc.py 
#                verif/firmware/phy_top_main.chex 
#                verif/firmware/phy_top_main_ecc.chex
#################################################

import os
import sys

def generate_designware_legacy_ecc(data_bytes):
    """
    为32位数据生成DesignWare Legacy ECC (7位校验码)
    
    ⚠️ 重要: 这不是标准Hamming码!
    - 使用Synopsys DesignWare专有算法
    - syn[2] 和 syn[3] 需要取反
    - 覆盖位分布是定制优化的
    
    匹配 RTL 模块: CW_ecc_legacy_width32_chkbits7_synd_sel1
    
    Args:
        data_bytes: 4字节数据 (32位)
    
    Returns:
        7位ECC校验码 (0-127)
    """
    if len(data_bytes) != 4:
        raise ValueError("DesignWare ECC requires exactly 4 bytes (32 bits)")
    
    # 组合32位数据 (大端序)
    data_32 = (data_bytes[0] << 24) | (data_bytes[1] << 16) | \
              (data_bytes[2] << 8) | data_bytes[3]
    
    # 位数组 (LSB first: bit[0] to bit[31])
    bits = [(data_32 >> i) & 1 for i in range(32)]
    
    # syn[0]: 覆盖位 0,4,6,7,8,9,11,14,17,18,19,21,26,28,29,31
    syn0 = bits[0] ^ bits[4] ^ bits[6] ^ bits[7] ^ bits[8] ^ bits[9] ^ \
           bits[11] ^ bits[14] ^ bits[17] ^ bits[18] ^ bits[19] ^ bits[21] ^ \
           bits[26] ^ bits[28] ^ bits[29] ^ bits[31]
    
    # syn[1]: 覆盖位 0,1,2,4,6,8,10,12,16,17,18,20,22,24,26,28
    syn1 = bits[0] ^ bits[1] ^ bits[2] ^ bits[4] ^ bits[6] ^ bits[8] ^ \
           bits[10] ^ bits[12] ^ bits[16] ^ bits[17] ^ bits[18] ^ bits[20] ^ \
           bits[22] ^ bits[24] ^ bits[26] ^ bits[28]
    
    # syn[2]: 覆盖位 0,3,4,7,9,10,13,15,16,19,20,23,25,26,29,31 (需要取反!)
    tmp2 = bits[0] ^ bits[3] ^ bits[4] ^ bits[7] ^ bits[9] ^ bits[10] ^ \
           bits[13] ^ bits[15] ^ bits[16] ^ bits[19] ^ bits[20] ^ bits[23] ^ \
           bits[25] ^ bits[26] ^ bits[29] ^ bits[31]
    syn2 = 1 ^ tmp2  # NOT operation (对应 RTL: not RC_i_1024)
    
    # syn[3]: 覆盖位 0,1,5,6,7,11,12,13,16,17,21,22,23,27,28,29 (需要取反!)
    tmp3 = bits[0] ^ bits[1] ^ bits[5] ^ bits[6] ^ bits[7] ^ bits[11] ^ \
        bits[12] ^ bits[13] ^ bits[16] ^ bits[17] ^ bits[21] ^ bits[22] ^ \
        bits[23] ^ bits[27] ^ bits[28] ^ bits[29]
    syn3 = 1 ^ tmp3  # NOT operation (对应 RTL: not RC_i_1025)
    
    # syn[4]: 覆盖位 2,3,4,5,6,7,14,15,18,19,20,21,22,23,30,31
    syn4 = bits[2] ^ bits[3] ^ bits[4] ^ bits[5] ^ bits[6] ^ bits[7] ^ \
        bits[14] ^ bits[15] ^ bits[18] ^ bits[19] ^ bits[20] ^ bits[21] ^ \
        bits[22] ^ bits[23] ^ bits[30] ^ bits[31]
    
    # syn[5]: 覆盖位 8,9,10,11,12,13,14,15,24,25,26,27,28,29,30,31
    syn5 = bits[8] ^ bits[9] ^ bits[10] ^ bits[11] ^ bits[12] ^ bits[13] ^ \
        bits[14] ^ bits[15] ^ bits[24] ^ bits[25] ^ bits[26] ^ bits[27] ^ \
        bits[28] ^ bits[29] ^ bits[30] ^ bits[31]
    
    # syn[6]: 覆盖位 0,1,2,3,4,5,6,7,24,25,26,27,28,29,30,31 (全局奇偶)
    syn6 = bits[0] ^ bits[1] ^ bits[2] ^ bits[3] ^ bits[4] ^ bits[5] ^ \
           bits[6] ^ bits[7] ^ bits[24] ^ bits[25] ^ bits[26] ^ bits[27] ^ \
           bits[28] ^ bits[29] ^ bits[30] ^ bits[31]
    
    # 组合7位ECC [6:0]
    ecc_7bit = (syn6 << 6) | (syn5 << 5) | (syn4 << 4) | (syn3 << 3) | \
               (syn2 << 2) | (syn1 << 1) | syn0
    
    return ecc_7bit


def self_test():
    """
    自测试: 验证DesignWare Legacy ECC算法
    
    使用已知的测试向量验证算法正确性
    """
    print("\n" + "="*70)
    print("DesignWare Legacy ECC Self-Test")
    print("="*70)
    print("Testing against known RTL simulation results...")
    print()
    
    test_vectors = [ 
        (0x20250616, 0x29, "Example 2 (Standard Output)"),
        (0x01000000, 0x6E, "Single Bit Test (bit[24])"),
        (0x00000000, 0x0C, "All Zeros (calculate)"),
    ]
    
    all_passed = True
    for data, expected_ecc, description in test_vectors:
        data_bytes = data.to_bytes(4, byteorder='big')
        calculated_ecc = generate_designware_legacy_ecc(data_bytes)
        
        if expected_ecc is not None:
            status = "✓ PASS" if calculated_ecc == expected_ecc else "✗ FAIL"
            if calculated_ecc != expected_ecc:
                all_passed = False
        else:
            status = "ℹ INFO"
            
        print(f"{status} | {description}")
        print(f"       Data: 0x{data:08X} ({data:032b})")
        if expected_ecc is not None:
            print(f"       Expected ECC: 0x{expected_ecc:02X} ({expected_ecc:07b})")
        print(f"       Calculated ECC: 0x{calculated_ecc:02X} ({calculated_ecc:07b})")
        
        if expected_ecc is not None and calculated_ecc != expected_ecc:
            print(f"       ❌ MISMATCH!")
        print()
    
    print("="*70)
    if all_passed:
        print("✓ All tests PASSED! DesignWare Legacy ECC algorithm is correct.")
        print("  You can proceed to generate ECC files.")
    else:
        print("✗ Some tests FAILED! Please check the algorithm implementation.")
        print("  DO NOT use generated ECC files until this is fixed!")
    print("="*70 + "\n")
    
    return all_passed


def generate_line_ecc(line_data):
    """
    为单行数据生成DesignWare Legacy ECC校验码
    
    处理任意长度的行数据,每4字节生成1字节(7位)ECC
    """
    ecc_line = bytearray()
    for i in range(0, len(line_data), 4):
        if i + 3 < len(line_data):
            byte_block = line_data[i:i+4]
        else:
            # 处理不足4字节的剩余数据 (补零)
            remaining = line_data[i:]
            byte_block = remaining + bytes(4 - len(remaining))
        
        # 使用DesignWare Legacy算法
        dw_ecc = generate_designware_legacy_ecc(byte_block)
        ecc_line.append(dw_ecc)
    return bytes(ecc_line)


def generate_ecc(data):
    """
    生成DesignWare Legacy ECC校验码 - 逐块处理
    
    每4字节数据生成7位ECC校验码
    """
    print("Starting DesignWare Legacy ECC calculation...")
    ecc = bytearray()
    
    for i in range(0, len(data), 4):
        if i + 3 < len(data):
            byte_block = data[i:i+4]
            dw_ecc = generate_designware_legacy_ecc(byte_block)
            ecc.append(dw_ecc)
        else:
            # 处理不足4字节的剩余数据
            remaining = data[i:]
            padded = remaining + bytes(4 - len(remaining))
            dw_ecc = generate_designware_legacy_ecc(padded)
            ecc.append(dw_ecc)
        
        # 显示进度
        if (i // 4) % 100 == 0:
            progress = (i / len(data)) * 100
            print(f"  DesignWare ECC progress: {progress:.1f}% - Block {i//4}")
    
    print("DesignWare Legacy ECC calculation completed.")
    return bytes(ecc)


def process_cmd():
    """
    主处理函数: 读取输入文件,生成ECC,输出39位数据
    """
    # 首先运行自测试
    print("Running self-test before processing files...")
    if not self_test():
        print("\n⚠️  WARNING: Self-test failed!")
        print("The algorithm may not match the RTL implementation.")
        response = input("Continue anyway? (yes/no): ")
        if response.lower() != 'yes':
            print("Aborted by user.")
            sys.exit(1)
        print("Proceeding despite self-test failure...\n")
    
    # 检查命令行参数数量
    if len(sys.argv) != 3:
        print("\n" + "="*70)
        print("DesignWare Legacy ECC Generator")
        print("="*70)
        print("Usage: python gen_ecc.py <input_file> <output_file>")
        print()
        print("Algorithm: DesignWare Legacy ECC (Synopsys Proprietary)")
        print("           ⚠️  NOT standard Hamming Code!")
        print()
        print("Output: 39-bit data (7-bit ECC + 32-bit original) in hex format")
        print("        Format: (ecc_7bit << 32) | data_32bit")
        print()
        print("RTL Module: CW_ecc_legacy_width32_chkbits7_synd_sel1")
        print("="*70)
        sys.exit(1)

    # 获取输入文件名和输出文件名
    input_file = sys.argv[1]
    output_file = sys.argv[2]

    # 检查输入文件是否存在
    if not os.path.isfile(input_file):
        print(f"Error: Input file '{input_file}' does not exist.")
        sys.exit(1)

    # 显示处理信息
    print("\n" + "="*70)
    print("DesignWare Legacy ECC Generator - Processing Configuration")
    print("="*70)
    print(f"  Input file:  {input_file}")
    print(f"  Output file: {output_file}")
    print(f"  Algorithm:   DesignWare Legacy ECC (Synopsys Proprietary)")
    print(f"               ⚠️  NOT standard Hamming Code!")
    print(f"  Key features:")
    print(f"    - syn[2] and syn[3] use NOT operation")
    print(f"    - Custom bit coverage distribution")
    print(f"    - Optimized for hardware implementation")
    print(f"  Output format: 39-bit hex (7-bit ECC + 32-bit data)")
    print(f"  RTL Module:    CW_ecc_legacy_width32_chkbits7_synd_sel1")
    print("="*70 + "\n")

    # 逐行读取输入文件并生成ECC
    print(f"Step 1: Reading input file and generating ECC...")
    encoded_lines = []  # 存储每行编码后的数据
    line_count = 0
    
    with open(input_file, 'r') as f:
        for line in f:
            line = line.strip()  # 去掉换行符和空白符
            if not line:
                continue
                
            line_count += 1
            
            # 将十六进制字符串转换为字节数据
            try:
                line_data = bytes.fromhex(line)
            except ValueError:
                print(f"  Warning: Invalid hex data at line {line_count}: {line}")
                continue
            
            # 为当前行生成DesignWare Legacy ECC编码
            if len(line_data) > 0:
                line_ecc = generate_line_ecc(line_data)
                encoded_lines.append((line_data, line_ecc))
                
                # 显示处理进度
                if line_count % 100 == 0:
                    print(f"  Processed line {line_count}: {len(line_data)} bytes data, {len(line_ecc)} bytes ECC")
            else:
                # 空行也需要处理
                encoded_lines.append((line_data, b''))
    
    # 显示读取和编码完成的信息
    print(f"\nStep 2: Line-by-line processing completed")
    print(f"  Total lines processed: {line_count}")
    total_data_size = sum(len(line_data) for line_data, _ in encoded_lines)
    total_ecc_size = sum(len(line_ecc) for _, line_ecc in encoded_lines)
    print(f"  Total data size: {total_data_size} bytes ({total_data_size//4} words)")
    print(f"  Total ECC size: {total_ecc_size} bytes")

    # 逐行写入输出文件 (输出39位数据：7位ECC + 32位原始数据)
    print(f"\nStep 3: Writing 39-bit data to output file...")
    print(f"  Format: (ecc_7bit << 32) | data_32bit")
    
    with open(output_file, 'w') as f:
        lines_written = 0
        for line_data, line_ecc in encoded_lines:
            if len(line_data) == 4 and len(line_ecc) >= 1:  # 确保是完整的32位数据
                # 获取32位数据
                data_32bit = int.from_bytes(line_data, byteorder='big')
                # 获取7位ECC
                ecc_7bit = line_ecc[0]
                
                # 组合成39位数据 (7位ECC置于高位 + 32位原始数据)
                # 这样存储: [38:32]=ecc, [31:0]=data
                combined_39bit = (ecc_7bit << 32) | data_32bit
                
                # 转换为10个十六进制字符 (39位需要40位对齐，即10个hex字符)
                combined_hex = f"{combined_39bit:010X}"
                f.write(combined_hex + '\n')
                
                lines_written += 1
                
                # 显示写入进度和示例
                if lines_written <= 3 or lines_written % 1000 == 0:
                    print(f"  Line {lines_written:5d}: ECC=0x{ecc_7bit:02X}, Data=0x{data_32bit:08X} => 0x{combined_hex}")
            else:
                print(f"  Warning: Skipping line with {len(line_data)} bytes data, {len(line_ecc)} bytes ECC")
    
    print(f"\n  Total lines written: {lines_written}")

    # 生成详细报告
    print("\n" + "="*70)
    print("DesignWare Legacy ECC Generation Report")
    print("="*70)
    print(f"  Input file:         {input_file}")
    print(f"  Output file:        {output_file}")
    print(f"  Total lines:        {line_count}")
    print(f"  Lines written:      {lines_written}")
    print(f"  Input data size:    {total_data_size} bytes ({total_data_size//4} words)")
    print(f"  ECC algorithm:      DesignWare Legacy (32-bit data + 7-bit ECC)")
    print(f"  ECC size:           {total_ecc_size} bytes")
    print(f"  Output format:      39-bit data (7-bit ECC + 32-bit original)")
    print(f"  Storage format:     (ecc << 32) | data")
    
    # 计算ECC开销
    overhead_ratio = (total_ecc_size / total_data_size) * 100 if total_data_size > 0 else 0
    print(f"  ECC overhead:       {overhead_ratio:.2f}%")
    
    # 显示关键信息
    print(f"\n  ⚠️  Important Notes:")
    print(f"    - This uses DesignWare Legacy ECC, NOT standard Hamming!")
    print(f"    - syn[2] and syn[3] include NOT operation")
    print(f"    - Must match RTL: CW_ecc_legacy_width32_chkbits7_synd_sel1")
    print(f"    - Verify with RTL simulation before using in production")
    
    print("="*70)
    print("✓ DesignWare Legacy ECC generation completed successfully!")
    print("="*70 + "\n")


if __name__ == "__main__":
    process_cmd()
