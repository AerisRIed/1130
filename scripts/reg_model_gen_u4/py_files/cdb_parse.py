import xml.etree.ElementTree as eTree
import re
import cdb_reg
import logging
import os
from datetime import datetime

# 配置日志
def setup_logger(log_file_path=None):
    """设置日志配置，输出到文件和控制台"""
    if log_file_path is None:
        # 默认在当前目录创建带时间戳的日志文件
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        log_file_path = f"cdb_parse_{timestamp}.log"
    
    # 创建logger
    logger = logging.getLogger('cdb_parse')
    logger.setLevel(logging.DEBUG)
    
    # 如果logger已经有handlers，先清除
    if logger.handlers:
        logger.handlers.clear()
    
    # 创建文件处理器
    file_handler = logging.FileHandler(log_file_path, mode='w', encoding='utf-8')
    file_handler.setLevel(logging.DEBUG)
    
    # 创建控制台处理器
    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.INFO)
    
    # 创建格式器
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    file_handler.setFormatter(formatter)
    console_handler.setFormatter(formatter)
    
    # 添加处理器到logger
    logger.addHandler(file_handler)
    #logger.addHandler(console_handler)
    
    return logger

# 全局logger实例
logger = setup_logger()

def set_log_file(log_file_path):
    """设置自定义日志文件路径"""
    global logger
    logger = setup_logger(log_file_path)

def cleanup_cell_type(row, in_fld_row):
    """Changes CellBody-Signals and CellBody-Regs-Name to CellBody-Regs to keep
        the XML Schema the same for all registers

       Will be talking to the designer to see if we can clean this up
    """
    regs_name_cells = row.iter('CellBody-Signals')

    for cell_name in regs_name_cells:
        cell_name.tag = 'entry'
    #regs_name_cells = row.getiterator('CellBody-Regs-bullet-1List')
    #for cell_name in regs_name_cells:
        #cell_name.tag = 'CellBody-Regs'
    #regs_name_cells = row.getiterator('b')
    #for cell_name in regs_name_cells:
    #    cell_name.tag = 'entry'


def get_cell_addr(cell, a_map_dict):
    """Construct the Register Address: Schema calls for 3 children of cell:
       Child[0] : UPPER Address (CMN/LANE, SUBMODULE)
       Child[1] : Lower Address
    """
    elements = cell.getchildren()
    logger.debug(f'elements len: {len(elements)}')
    for element in elements:
        element.text = find_text_recursive(element)
        if element.text:
            # 处理所有类型的换行符和特殊字符
            element.text = element.text.replace('\n', '')
            element.text = element.text.replace('\x0a', '')  # 修复语法：\xa -> \x0a
            element.text = element.text.replace('\r', '')   # 处理回车符
            element.text = element.text.replace('\t', '')   # 处理制表符
            element.text = element.text.replace('\x0b', '') # 处理垂直制表符
            element.text = element.text.replace('\x0c', '') # 处理换页符
            logger.debug(f'element text: {element.text}')
    reg_addr_top = ''
    reg_addr_bottom = ''
    
    if len(elements) > 1:
        if elements[-1].text:
            reg_addr_bottom = elements[-1].text
        else:
            reg_addr_bottom = elements[-2].text if len(elements) > 2 else ''
        reg_addr_top = elements[0].text if elements[0].text else ''
    elif len(elements) == 1:
        reg_addr_bottom = elements[0].text if elements[0].text else ''
        reg_addr_bottom = reg_addr_bottom.replace(u'\u2019', "'")
        reg_addr_bottom = re.sub(r"\d*'b","",reg_addr_bottom)
        reg_addr_top = ''
    elif len(elements) == 0:
        reg_addr_top = cell.text
    else:
        reg_addr_bottom = ''
        try:
            if hasattr(cell, '_children') and cell._children:
                reg_addr_top = cell._children[-1].tail
                if reg_addr_top:
                    # 处理所有特殊字符
                    reg_addr_top = reg_addr_top.replace('\n', '')
                    reg_addr_top = reg_addr_top.replace('\x0a', '')  # 修复语法：\xa -> \x0a
                    reg_addr_top = reg_addr_top.replace('\r', '')
                    reg_addr_top = reg_addr_top.replace('\t', '')
                    reg_addr_top = reg_addr_top.replace(u'\u2019', "'")
                    reg_addr_top = re.sub(r"\d*'b","",reg_addr_top)
                else:
                    reg_addr_top = ''
            else:
                reg_addr_top = ''
        except:
            reg_addr_top = ''

        #Process a HEX Address
        if reg_addr_top and reg_addr_top.find("0x") != -1:
            reg_addr_top = reg_addr_top.replace("0x", "")
            reg_addr_top = reg_addr_top.replace("_",  "")
            try:
                reg_addr_top = bin(int(reg_addr_top, 16))
                reg_addr_top = str(reg_addr_top)
                reg_addr_top = reg_addr_top.replace("0b", "")
            except ValueError:
                reg_addr_top = ''
        #Process Verilog HEX Address
        elif reg_addr_top and reg_addr_top.find("'h") != -1:
            try:
                reg_addr_top = re.sub(r"\d*'h","",reg_addr_top) 
                reg_addr_top = bin(int(reg_addr_top, 16))
                reg_addr_top = str(reg_addr_top)
                reg_addr_top = reg_addr_top.replace("0b", "")
            except ValueError:
                reg_addr_top = ''
        #Process Verilog Binary Address
        elif reg_addr_top and reg_addr_top.find("16'b") != -1:
            reg_addr_top = reg_addr_top.replace("16'b", "")

    # 清理 reg_addr_bottom
    if reg_addr_bottom:
        if a_map_dict != {}:
            for key, offset in a_map_dict.items():
                reg_addr_bottom = reg_addr_bottom.replace(key, offset)
                
        reg_addr_bottom = reg_addr_bottom.replace('m', '0')
        reg_addr_bottom = reg_addr_bottom.replace('n', '0')
        reg_addr_bottom = reg_addr_bottom.replace('l', '0')
        reg_addr_bottom = reg_addr_bottom.replace(' : ', '')
        reg_addr_bottom = reg_addr_bottom.replace(':', '')
        reg_addr_bottom = reg_addr_bottom.replace(' ', '')
        reg_addr_bottom = reg_addr_bottom.replace('_', '')
        # 移除所有非二进制字符和特殊字符
        reg_addr_bottom = reg_addr_bottom.replace('\x0a', '')  # 修复语法：\xa -> \x0a
        reg_addr_bottom = reg_addr_bottom.replace('\n', '')
        reg_addr_bottom = reg_addr_bottom.replace('\r', '')
        reg_addr_bottom = reg_addr_bottom.replace('\t', '')

    # 清理 reg_addr_top  
    if reg_addr_top:
        #Handle SD0200 Documentation Anomally of 00000 - 11111 (32 addresses)
        reg_addr_top = reg_addr_top.replace("- 11111", "")
        reg_addr_top = reg_addr_top.replace("- 01010", "")
        reg_addr_top = reg_addr_top.replace("- 11010", "")
        reg_addr_top = reg_addr_top.replace("- 01111", "")

        if a_map_dict != {}:
            for key, offset in a_map_dict.items():
                reg_addr_top = reg_addr_top.replace(key, offset)

        reg_addr_top = reg_addr_top.replace('m', '0')
        reg_addr_top = reg_addr_top.replace('n', '0')
        reg_addr_top = reg_addr_top.replace('l', '0')
        reg_addr_top = reg_addr_top.replace(' : ', '')
        reg_addr_top = reg_addr_top.replace(':', '')
        reg_addr_top = reg_addr_top.replace('_', '')
        reg_addr_top = reg_addr_top.replace(' ', '')
        # 移除所有非二进制字符和特殊字符
        reg_addr_top = reg_addr_top.replace('\x0a', '')  # 修复语法：\xa -> \x0a
        reg_addr_top = reg_addr_top.replace('\n', '')
        reg_addr_top = reg_addr_top.replace('\r', '')
        reg_addr_top = reg_addr_top.replace('\t', '')

    # 最终清理：确保只包含0和1
    def clean_binary_string(s):
        if not s:
            return ''
        # 移除所有非0和1的字符
        cleaned = re.sub(r'[^01]', '', s)
        return cleaned

    reg_addr_top = clean_binary_string(reg_addr_top)
    reg_addr_bottom = clean_binary_string(reg_addr_bottom)

    # 拼接地址
    reg_addr = reg_addr_top + reg_addr_bottom
    logger.debug(f'reg addr: {reg_addr}')
    # 如果最终地址为空或不是有效的二进制字符串，返回默认值
    if not reg_addr or not re.match(r'^[01]+$', reg_addr):
        reg_addr = '0'
    
    return reg_addr


def get_cell_text(cell):
    try:
        first_child = cell[0].text.strip()
    except: 
        first_child = cell.text.strip()
    first_child = first_child.replace('\n', '')
    first_child = ' '.join(first_child.split())
    return first_child

def get_child_text(child, replace_nl = False):
    text = ''
    if child.text != None :
        text += child.text
    if child.tail != None :
        text += child.tail
    if replace_nl :
        text.replace('\n', '')
    return text

def get_cell_child0_text(cell):
    try:
        first_child = cell[-1].text.strip()
    except: 
        first_child = cell.text.strip()
        first_child.replace('\n', '')
    return first_child


def find_text_recursive(element):
    """递归查找元素及其子元素中的文本内容"""
    # 首先检查当前元素的text
    if element.text and element.text.strip():
        return element.text.strip()
    
    # 如果当前元素没有text，递归检查所有子元素
    for child in element:
        found_text = find_text_recursive(child)
        if found_text:
            return found_text
    
    return None

def get_cell_child_text(cell):
    first_child = ""  # 初始化默认值
    
    # 如果cell有子元素，递归查找文本
    if len(cell):
        for ce in cell:
            found_text = find_text_recursive(ce)
            if found_text:
                first_child = found_text
                logger.debug(f'Found text in recursive search: {first_child}')
                break  # 找到第一个有文本内容的元素就退出
    elif cell.text:
        first_child = cell.text.strip() 
    else:
        first_child = ""
    
    # 清理换行符
    if first_child:
        first_child = first_child.replace('\n', '')
    
    return first_child

def get_cell_childX_text(cell, childX):
    return cell._children[childnum].tail.replace('\n', '')

def get_cell_child_last_text(cell):
    return cell.tail.replace('\n', '')

def is_fld_row(cells, in_flds):
    return in_flds == 1 and len(cells) >= 4


def process_register_name(cell, register_list, reg_width, addr_offset, dbg):
    if len(cell) > 1:
        register_name = get_cell_text(cell[1])
    else:
        register_name = get_cell_text(cell)
    if dbg:
        logger.info(f'Register name: {register_name}')
    register = cdb_reg.cdb_reg(register_name, reg_width, '', '', addr_offset)
    register_list.append(register)


def process_register_address(cell, register_list, addr_ovrd):
    first_child = ""  # 初始化默认值
    if len(cell):
        for ce1 in cell:
            found_text = find_text_recursive(ce1)
            if found_text:
               first_child = found_text
               #logger.debug(f'reg test:{first_child}')
               break  # 找到第一个有文本的子元素就退出
    elif cell.text:
        first_child = cell.text.strip() 
    else:
        first_child = ""
    
    # 清理换行符
    if first_child:
        first_child = first_child.replace('\n', '')
    
    logger.debug(f'register address text: {first_child}')
    address = get_cell_addr(cell, addr_ovrd)
    # 确保地址是有效的二进制字符串
    if not address or not re.match(r'^[01]+$', address):
        address = '0'
    try:
        address = int(address, 2)
    except ValueError:
        logger.warning("Invalid binary address, defaulting to 0")
        address = 0
    
    for reg in register_list:
        if reg.address == address:
            logger.error("Register Address Appears Twice in the File")
            logger.error(f"Address: {hex(address)}")
            logger.error(f"Existing register: {reg.mnemonic}")
            logger.error(f"New register: {register_list[-1].mnemonic}")
            exit(-1)
    register_list[-1].set_address(address)


def process_register_mnemonic(cell, register_list, dbg):
    mnemonic = get_cell_text(cell)
    mnemonic = mnemonic.replace(' ', '')
    mnemonic = mnemonic.lower()
    for reg in register_list:
        if reg.mnemonic == mnemonic:
            logger.error("Register Mnemonic Appears Twice in the File")
            logger.error(f"Existing mnemonic: {reg.mnemonic}")
            logger.error(f"New mnemonic: {mnemonic}")
            exit(-1)
    if dbg == 1: 
        logger.info(f'Mnemonic: {mnemonic}')
    register_list[-1].mnemonic = mnemonic.lower()


def process_field_row(cells, mnemonic):
    name = mnemonic
    bits = get_cell_child0_text(cells[0])
    #logger.debug(f'bits: {bits}')
    access_type = get_cell_child0_text(cells[1])
    #logger.debug(f'access: {access_type}')
    rst_val = get_cell_child0_text(cells[2])
    #logger.debug(f'rst: {rst_val}')
    description = get_cell_child0_text(cells[3])
    #logger.debug(f'description: {description}')
    rep_nl = False

    rst_val = rst_val.replace('_', '')
    rst_val = rst_val.replace(' ', '')
    rst_val = rst_val.replace(u'\u2019', "'")
    
    description = description.replace('\n', '', 1)
    description = description.replace(u'\u2019', "'")
    description = re.sub('<', 'X', description) 
    description = re.sub('>', 'X', description) 
    description = description.encode('ascii', 'ignore').decode('ascii')

    if rst_val == '':
        rst_val = 0
    elif rst_val.find('TBD') != -1:
        rst_val = 0
    elif rst_val.find("X") != -1:
        rst_val =  0
    elif rst_val.find("x") != -1:
        rst_val =  0
    elif rst_val.find("M") != -1:
        rst_val =  0
    elif rst_val.find("m") != -1:
        rst_val =  0
    elif rst_val.find("'h") != -1:
        posit = rst_val.find("'h")
        rst_val = int(rst_val[posit+2:], 16)
    elif rst_val.find("'x") != -1:
        posit = rst_val.find("'x")
        rst_val = int(rst_val[posit+2:], 16)
    elif rst_val.find("'d") != -1:
        posit = rst_val.find("'d")
        rst_val = int(rst_val[posit+2:])
    elif rst_val.find("'b") != -1:
        posit = rst_val.find("'b")
        rst_val = int(rst_val[posit+2:], 2)

    access_type = access_type.replace('/', '')

    bits = bits.replace(' ', '')
    semi_loc = bits.find(':')
    if bits.find(':') != -1:
        end_bit = bits[:semi_loc]
        start_bit = bits[semi_loc + 1:]
        name = name + '_' + end_bit + '_' + start_bit
    else:
        name = name + '_' + bits
        end_bit = bits
        start_bit = bits
    
    if description == "Reserved" and access_type not in ['R', 'RO'] and name.find("cya") == -1:
        logger.warning("Reserved Field with a NON-RO access type")
        logger.warning(f"Field name: {name}")
        
    fld = cdb_reg.cdb_field(name, access_type, end_bit, start_bit, rst_val, description)
    return fld


def process_row(cells, in_flds, register_list, override_dict, c_params, dbg):
    reg_width     = c_params.reg_width
    addr_map_dict = c_params.addr_map_dict
    addr_offset   = 0
    
    in_fld = in_flds
    cell_text = get_cell_child_text(cells[0])
    logger.debug(f'Process row cell text: {cell_text}')
    if is_fld_row(cells, in_flds):
        new_fld = process_field_row(cells, register_list[-1].mnemonic)
        register_list[-1].add_field(new_fld, override_dict)

    if cell_text.find('Register Name') != -1:
        process_register_name(cells[1], register_list, reg_width, addr_offset, dbg)
        in_fld = 0

    if cell_text.find('Register Address') != -1:
        process_register_address(cells[1], register_list, addr_map_dict)
        in_fld = 0

    if cell_text.find('Register Mnemonic') != -1:
        process_register_mnemonic(cells[1], register_list, dbg)
        in_fld = 0

    if cell_text.find('Bits') != -1:
        in_fld = 1
    return in_fld, register_list


def parse_fm_xml(input_file, override_dict, dbg, cdb_params, sort=False):
    logger.info(f"Starting to parse XML file: {input_file}")
    ifile = open(input_file, 'r')
    tree = eTree.parse(ifile)
    ifile.close()

    # Get all the tables in the XML File
    sections = tree.getiterator('section')

    reg_list = []
    in_fld_row = 0

    # Loop through all of the tables
    for section in sections:
        tables = section.getiterator('table')
        for table in tables:
            rows = table.getiterator('row')
            in_fld_row = 0
            for row in rows:
                cleanup_cell_type(row, in_fld_row)
                cells = list(row.getiterator('entry'))  # 转换为列表以支持len()操作
                
                # 打印所有cells下的子元素text内容
                #def extract_all_text(element, level=0):
                #    """递归提取元素及其所有子元素的文本内容"""
                #    indent = "  " * level
                #    texts = []
                #    
                #    if element.text:
                #        texts.append(f"{indent}direct_text: '{element.text}'")
                #        
                #    if element.tail:
                #        texts.append(f"{indent}tail_text: '{element.tail}'")
                #    
                #    for child_idx, child in enumerate(element):
                #        texts.append(f"{indent}Child[{child_idx}] tag: {child.tag}")
                #        child_texts = extract_all_text(child, level + 1)
                #        texts.extend(child_texts)
                #    
                #    return texts
                #
                #logger.debug(f"=== Row contains {len(cells)} cells ===")
                #for cell_idx, cell in enumerate(cells):
                #    logger.debug(f"Cell[{cell_idx}] direct text: '{cell.text}'")
                #    if len(cell) > 0:
                #        logger.debug(f"Cell[{cell_idx}] has {len(cell)} child elements:")
                #        for child_idx, child in enumerate(cell):
                #            logger.debug(f"  Child[{child_idx}] tag: {child.tag}, text: '{child.text}', tail: '{child.tail}'")
                #            # 递归提取更深层的文本
                #            if len(child) > 0:
                #                all_texts = extract_all_text(child, 2)
                #                for text_info in all_texts:
                #                    logger.debug(f"    {text_info}")
                #    else:
                #        logger.debug(f"Cell[{cell_idx}] has no child elements")
                #        
                #    # 提取cell的所有文本内容（包括深层嵌套）
                #    def get_all_text_content(elem):
                #        """获取元素的所有文本内容，包括子元素"""
                #        text_parts = []
                #        if elem.text:
                #            text_parts.append(elem.text.strip())
                #        for child in elem:
                #            child_text = get_all_text_content(child)
                #            if child_text:
                #                text_parts.append(child_text)
                #            if child.tail:
                #                text_parts.append(child.tail.strip())
                #        return ' '.join(text_parts).strip()
                #    
                #    full_text = get_all_text_content(cell)
                #    if full_text:
                #        logger.debug(f"Cell[{cell_idx}] FULL TEXT CONTENT: '{full_text}'")
                #
                #logger.debug("=== End of cell details ===")
                
                for cell in cells:
                        if len(cell):
                        #first_child = cell[0]
                            for ce in cell:
                                first_txt = ce
                                #logger.debug(f'cells1 text: {ce.text}')
                        else:
                            first_txt = cell
                            #logger.debug(f'cells text: {cell.text}')
                if len(cells):
                    in_fld_row, reg_list = process_row(cells, in_fld_row, reg_list, override_dict, cdb_params, 1)

    if sort:
        reg_list = sorted(reg_list, key=lambda cdb_reg:cdb_reg.address)
    
    logger.info(f"Parsing completed. Found {len(reg_list)} registers.")
    return reg_list
