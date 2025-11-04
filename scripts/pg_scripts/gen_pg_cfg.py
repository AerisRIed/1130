#------------------------------------------------------------------------------------------------
#-   This confidential and proprietary HVL soft description of a Hardware Verification Component 
#-   may be used only as authorized by a licensing agreement from Cadence Design Systems, Inc.. 
#-   In the event of publication, the following notice is applicable:
#-
#-                    (C) COPYRIGHT 2025 Cadence Design Systems, Inc.
#-                                ALL RIGHTS RESERVED
#-
#-    The entire notice above must be reproduced on all authorized copies of this code.
#-------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------
#- Description     : Script that parses the PG CSV files and generates SV code
#-                   Support PCIE, USB3, USB4, USB3+DP protocol 
#- run this scripts: python3 xxx.py -c filename.csv  #signal file generate sv code 
#-                   python3 xxx.py -a               #all csv file will generate sv code in work path
#-
#- Author          :zming
#-------------------------------------------------------------------------------------------------

import os
import csv
import re
import optparse
import sys

def get_protocol_refclk(prot,refclk,rate,csv_filename,pll_ssc):

    # get prot and rate
    name_without_ext = os.path.splitext(csv_filename)[0]
    parts = name_without_ext.split('_')
    #print(parts)
    if any(item in parts for item in ['USB4']):
        prot = 'USB4'
    elif any(item in parts for item in ['USB']) and (not any(item in parts for item in ['DP'])): 
        prot = 'USB'
        if any(item in parts for item in ['GEN1']):
            rate = 'GEN1'
        elif any(item in parts for item in ['GEN2']):
            rate = 'GEN2'
        else:
            print("[ERROR] - CSV filename can not search the correct rate")
    elif any(item in parts for item in ['USB']) and any(item in parts for item in ['DP']):
        prot = 'USB_TCAM_DP'
        if any(item in parts for item in ['GEN1']):
            rate = 'GEN1'
        elif any(item in parts for item in ['GEN2']):
            rate = 'GEN2'
        else:
            print("[ERROR] - CSV filename can not search the correct rate")
    elif any(item in parts for item in ['DP']):
        prot = 'DP'  
    elif any(item in parts for item in ['PCIE']): 
        prot = 'PCIE'
    else:
        print("[ERROR] - CSV filename can not search the correct protocol")
        sys.exit(1)
    
    # get refclk
    for item in refclk_list:
        #print(item)
        if re.search(item, csv_filename) is not None:
            refclk = item
            break
    if refclk == '':
        print("[ERROR] - CSV filename can not search the correct refclk")
        sys.exit(1)
    # get ssc
    p0rc_idx, p1rc_idx = get_p0rc_p1rc_indices(parts)
    if parts[p0rc_idx+2] == 'ss': 
        pll_ssc["PLL0"] = 'Enable_ssc'
    if parts[p1rc_idx+2] == 'ss': 
        pll_ssc["PLL1"] = 'Enable_ssc'

    return prot,refclk,rate,pll_ssc

# get ssc index
def get_p0rc_p1rc_indices(parts):
    p0rc_index = parts.index('p0rc')
    #print(f"p0rc index: {p0rc_index}")
    p1rc_index = parts.index('p1rc')
    #print(f"p1rc index: {p1rc_index}")
    return p0rc_index, p1rc_index

# get the configure
def get_csv_config (prot,refclk,csv_filename):
    pattern = fr"{re.escape(prot[:3])}.*{re.escape(refclk)}"
    match = re.search(pattern, csv_filename)
    return match.group()

# open csv and get the register information
def open_csv_get_reg(csv_filename):
    """Open CSV file with fallback encoding support to avoid UnicodeDecodeError.
    Try encodings in order: utf-8 -> gbk -> gb18030 -> latin-1.
    """
    file_path =  csv_filename
    encodings_try = ['utf-8', 'gbk', 'gb18030', 'latin-1']
    last_err = None
    for enc in encodings_try:
        try:
            with open(file_path, 'r', encoding=enc, newline='') as csvfile:
                csvreader = csv.reader(csvfile, delimiter=',')
                data = list(csvreader)
                print(f"[INFO] - CSV using encoding {enc}")
                return data
        except UnicodeDecodeError as e:
            last_err = e
            continue
        except FileNotFoundError:
            print(f"[ERROR] - File not found: {file_path}")
            sys.exit(1)
    print(f"[ERROR] - Cannot parse file with common encodings: {file_path}, last error: {last_err}")
    sys.exit(1)

def get_wr_cmd_flag(filename):
    if 'phy_pcs_cmn' in filename:
        return 'phy_pcs_cmn'
    elif 'phy_pcs_lane' in filename:
        return 'phy_pcs_lane'
    elif 'phy_pma_cmn' in filename:
        return 'phy_pma_cmn'
    elif 'phy_pma_lane' in filename:
        return 'phy_pma_lane'
    elif 'pma_10_cmn' in filename:
        return 'pma_cmn'
    elif 'pma_rx_lane' in filename:
        return 'pma_rx_lane'
    elif 'pma_tx_lane' in filename:
        return 'pma_tx_lane'
    else:
        print("[Error] - can not find reg in the xml!")
        exit(1)

def search_reg_xml(reg):
    reg_low = reg.lower()
    reg_low = reg_low.strip() # delete the reg string space 2025.9.1
    for dirpath, dirnames, filenames in os.walk(xml_path):
        for filename in filenames:
            file_path = os.path.join(dirpath,filename)
            try:
                with open(file_path, 'r', encoding='utf-8') as f:
                    for line in f:
                        if reg_low in line:
                            #print(f'Found in: {file_path}')
                            cmd = get_wr_cmd_flag(filename)
                            return cmd
            except Exception as e:
                print(f'Cannot read {file_path}: {e}')

def wr_reg_ln(wreg_cmd, reg, val):
    if (wreg_cmd == ''):
        wreg_cmd = search_reg_xml(reg)
        #print(wreg_cmd)
    return regmodel_path  +'write_dut_register("'+reg.lower() +  '",' + val + ");"

def wr_reg_cmn(wreg_cmd, reg, val):
    if (wreg_cmd == ''):
        wreg_cmd = search_reg_xml(reg)
        #print(wreg_cmd)
    return regmodel_path + 'write_dut_register("'+reg.lower() +  '",' + val + ");"

def wr_usb_sv_file(file,phy_cmd_ln1,phy_cmd_ln2,tx_lanes_cmd,rx_lanes_cmd):
    file.write('  if (lane_num == 4\'d1) begin'+'\n')
    for item in phy_cmd_ln1:
        file.write('    '+item+'\n')
    file.write('    if(flip_flag == 1) begin'+'\n')
    for item in tx_lanes_cmd:
        file.write('      '+item.replace('[0]','[0]')+'\n')
    for item in rx_lanes_cmd:
        file.write('      '+item.replace('[1]','[1]')+'\n')
    file.write('    end else begin'+'\n')
    for item in tx_lanes_cmd:
        file.write('      '+item+'\n')
    for item in rx_lanes_cmd:
        file.write('      '+item+'\n')
    file.write('    end'+'\n')         
    file.write('  end\n')
    file.write('  else if (lane_num == 4\'d2) begin'+'\n')
    for item in phy_cmd_ln2:
        file.write('    '+item+'\n')
    for item in tx_lanes_cmd:
        file.write('    '+item+'\n')
    for item in rx_lanes_cmd:
        file.write('    '+item+'\n')
    for item in rx_lanes_cmd:
        file.write('    '+item.replace('[1]','[2]')+'\n') 
    for item in tx_lanes_cmd:
        file.write('    '+item.replace('[0]','[3]')+'\n')


def dp_dict_sv_file(target_lanes,lane_num,tx_de_dict, tx_coef_dict,file):
    sl =[0,0,0,0,1,1,1,2,2,3]
    de =[0,1,2,3,0,1,2,0,1,0]
    #target_lanes = [2,3,0,1]
    for i in range(10):
        file.write('      if(swing == 2\'d'+str(sl[i]) +' && '+ 'de_emphasis == 2\'d'+str(de[i])+') begin'+'\n')
        for j in range(lane_num):
            for item in tx_de_dict['tx_de'+str(de[i])+'_cmd']:
                file.write('      '+item.replace('[0]','['+str(target_lanes[j])+']')+'\n')
            for item in tx_coef_dict['SL_DE_CFG_'+str(sl[i])+str(de[i])]:
                file.write('      '+item.replace('[0]','['+str(target_lanes[j])+']')+'\n')
        file.write('      end'+'\n')


def wr_dp_sv_file(target_lanes,tx_de_dict,tx_coef_dict,file,dp_lanes_cmd,phy_cmd_ln1,phy_cmd_ln2,phy_cmd_ln4):
    #for item in tx_deemphasis_swing_cmd:
        #file.write('   '+item+'\n')
    file.write('  if (dp_lane_num == 4\'d1) begin'+'\n')
    for item in phy_cmd_ln1:
        file.write('    '+item+'\n')
    file.write('    if(flip_flag == 1) begin'+'\n')
    for item in dp_lanes_cmd:
        file.write('      '+item.replace('[0]','['+str(target_lanes['flip'][0])+']')+'\n')
    dp_dict_sv_file(target_lanes['flip'],1,tx_de_dict,tx_coef_dict,file)
    file.write('    end else begin'+'\n')
    for item in dp_lanes_cmd:
        file.write('      '+item.replace('[0]','['+str(target_lanes['normal'][0])+']')+'\n')
    #for item in tx_de_dict['tx_de0_cmd']:
    #    file.write('    '+item+'\n')
    dp_dict_sv_file(target_lanes['normal'],1,tx_de_dict,tx_coef_dict,file)
    file.write('    end'+'\n')
    #file.write('  end\n')
    file.write('  end else if (dp_lane_num == 4\'d2) begin'+'\n')
    for item in phy_cmd_ln2:
        file.write('    '+item+'\n')
    file.write('    if(flip_flag == 1\'b1) begin'+'\n')
    for item in dp_lanes_cmd:
        file.write('      '+item.replace('[0]','['+str(target_lanes['flip'][0])+']')+'\n') 
    for item in dp_lanes_cmd:
        file.write('      '+item.replace('[0]','['+str(target_lanes['flip'][1])+']')+'\n')    
    dp_dict_sv_file(target_lanes['flip'],2,tx_de_dict,tx_coef_dict,file)
    file.write('    end else begin'+'\n')
    for item in dp_lanes_cmd:
        file.write('      '+item.replace('[0]','['+str(target_lanes['normal'][0])+']')+'\n')
    for item in dp_lanes_cmd:
        file.write('      '+item.replace('[0]','['+str(target_lanes['normal'][1])+']')+'\n')
    dp_dict_sv_file(target_lanes['normal'],2,tx_de_dict,tx_coef_dict,file)
    file.write('    end'+'\n')
    file.write('  end else if (dp_lane_num == 4\'d4) begin'+'\n')
    for item in phy_cmd_ln4:
        file.write('    '+item+'\n')
    for item in dp_lanes_cmd:
        file.write('    '+item.replace('[0]','[2]')+'\n')
    for item in dp_lanes_cmd:
        file.write('    '+item.replace('[0]','[3]')+'\n')
    for item in dp_lanes_cmd:
        file.write('    '+item +'\n')
    for item in dp_lanes_cmd:
        file.write('    '+item.replace('[0]','[1]')+'\n')
    dp_dict_sv_file(target_lanes['normal'],4,tx_de_dict,tx_coef_dict,file)
    #file.write('  end\n')

def wr_usb_dp_sv_file(target_lanes,tx_de_dict,tx_coef_dict,file,dp_lanes,phy_cmd_ln1,phy_cmd_ln2,tx_lanes_cmd,rx_lanes_cmd):
    for item in tx_lanes_cmd:
        file.write('  '+item+'\n')
    for item in rx_lanes_cmd:
        file.write('  '+item+'\n')
    file.write('  if (dp_lane_num == 4\'d1) begin'+'\n')
    for item in phy_cmd_ln1: # mode1
        file.write('    '+item+'\n')
    file.write('    if(flip_flag == 1\'b1) begin'+'\n')
    for item in dp_lanes:
        file.write('      '+item.replace('[0]','['+str(target_lanes['flip'][0])+']')+'\n')
    dp_dict_sv_file(target_lanes['flip'],1,tx_de_dict,tx_coef_dict,file)
    file.write('    end else begin'+'\n')
    for item in dp_lanes:
        file.write('      '+item.replace('[0]','['+str(target_lanes['normal'][0])+']')+'\n')
    dp_dict_sv_file(target_lanes['normal'],1,tx_de_dict,tx_coef_dict,file)
    file.write('    end\n')
    file.write('  end else if (dp_lane_num == 4\'d2) begin'+'\n')
    for item in phy_cmd_ln2: # mode2
        file.write('    '+item+'\n')
    file.write('    if(flip_flag == 1\'b1) begin'+'\n')
    for item in dp_lanes:
        file.write('      '+item.replace('[0]','['+str(target_lanes['flip'][0])+']')+'\n')
    for item in dp_lanes:
        file.write('      '+item.replace('[0]','['+str(target_lanes['flip'][1])+']')+'\n')
    dp_dict_sv_file(target_lanes['flip'],2,tx_de_dict,tx_coef_dict,file)
    file.write('    end else begin'+'\n')
    for item in dp_lanes:
        file.write('      '+item.replace('[0]','['+str(target_lanes['normal'][0])+']')+'\n')
    for item in dp_lanes:
        file.write('      '+item.replace('[0]','['+str(target_lanes['normal'][1])+']')+'\n')
    dp_dict_sv_file(target_lanes['normal'],2,tx_de_dict,tx_coef_dict,file)
    file.write('    end\n')

def write_to_sv_file(pll_ssc,tx_de_dict,tx_coef_dict,cmn_cmd,dp_lanes_cmd,tx_lanes_cmd,rx_lanes_cmd,all_lanes_cmd,phy_cmd,phy_cmd_ln1,phy_cmd_ln2,phy_cmd_ln4,csv_cfg,prot):
    target_lanes = {
        'normal': [2, 3, 0, 1],
        'flip': [2, 3, 0, 1]
    }
    with open (file_name,'a') as file:
        ex_string = 'cdn_phy_bring_up_seq::'
        if(prot == 'USB' or prot == 'USB4'): 
            task_temp_start = 'task'+' '+ex_string+'write_'+csv_cfg.lower()+'_pll0_'+pll_ssc['PLL0']+'_pll1_'+pll_ssc['PLL1']+'_pg_reg'+'(int lane_num, string IO_USB_TCAM, bit flip_flag);\n'
        elif(prot == 'USB_TCAM_DP'):
            task_temp_start = 'task'+' '+ex_string+'write_'+csv_cfg.lower()+'_pll0_'+pll_ssc['PLL0']+'_pll1_'+pll_ssc['PLL1']+'_pg_reg'+'(string IO_USB_TCAM, int dp_lane_num, int de_emphasis, int swing, bit flip_flag);\n'
        else:
            task_temp_start = 'task'+' '+ex_string+'write_'+csv_cfg.lower()+'_pll0_'+pll_ssc['PLL0']+'_pll1_'+pll_ssc['PLL1']+'_pg_reg'+'(int dp_lane_num, int de_emphasis, int swing, bit flip_flag);\n'
        task_temp_end   = 'endtask\n'
        file.write(task_temp_start)
        for item in cmn_cmd:
            file.write('  '+item+'\n')
        if(prot == 'DP'):
            wr_dp_sv_file(target_lanes,tx_de_dict,tx_coef_dict,file,tx_lanes_cmd,phy_cmd_ln1,phy_cmd_ln2,phy_cmd_ln4)
        elif(prot == 'USB_TCAM_DP'):
            wr_usb_dp_sv_file(target_lanes,tx_de_dict,tx_coef_dict,file,dp_lanes_cmd,phy_cmd_ln1,phy_cmd_ln2,tx_lanes_cmd,rx_lanes_cmd)
        else: 
            wr_usb_sv_file(file,phy_cmd_ln1,phy_cmd_ln2,tx_lanes_cmd,rx_lanes_cmd) 
        file.write('  end else begin\n    `uvm_fatal("PG_CFG", "Wrong lane_num")\n  end \n')
        for item in phy_cmd:
            file.write('  '+item+'\n')
        if(prot == 'DP' or prot == 'USB_DP'):
            for item in dp_lanes_cmd:
                file.write('  '+item+'\n')
        file.write(task_temp_end)

# generate cmd
def gen_reg_cmn_cmd(cmd,reg,val,comments):
    if (nocomment == False):
        cmd.extend(comments) 
    if((wr_rst_val or ('RST VAL' not in val))):
        cmd.append(wr_reg_cmn('',reg,val))

def gen_reg_lanes_cmd (cmd,reg,val,comments):
    if (nocomment == False):
        cmd.extend(comments)  
    if((wr_rst_val or ('RST VAL' not in val))):
        cmd.append(wr_reg_ln('',reg,val))



def gen_ln_reg_cmd(lane_index,cmd,reg,val,comments):
    if (nocomment == False):
        cmd.extend(comments)  
    if((wr_rst_val or ('RST VAL' not in val))):
        cmd.append(wr_ln_reg_cmd(lane_index,'',reg,val))

def wr_ln_reg_cmd(lane_index,wreg_cmd, reg, val):
    if (wreg_cmd == ''):
        wreg_cmd = search_reg_xml(reg)
        #print(wreg_cmd)
    if reg.startswith('TX'):
        return regmodel_path +'pma_tx_lane_reg_block'+'[' + str(lane_index) + ']'+'.write_dut_register("'+reg.lower() +  '",' + val + ');'
    elif reg.startswith('DRV_DIAG'):
        return regmodel_path + 'pma_tx_lane_reg_block'+'[' + str(lane_index) + ']'+'.write_dut_register("'+reg.lower() +  '",' + val + ');'
    elif reg.startswith('XCVR'):
        return regmodel_path + 'pma_tx_lane_reg_block'+'[' + str(lane_index) + ']'+'.write_dut_register("'+reg.lower() +  '",' + val + ');'
    elif reg.startswith('RX'):
        return regmodel_path + 'pma_rx_lane_reg_block'+'[' + str(lane_index) + ']'+'.write_dut_register("'+reg.lower() +  '",' + val + ');'
    elif reg.startswith('PHY'):
        return regmodel_path + 'phy_pcs_lane_reg_block'+'[' + str(lane_index) + ']'+'.write_dut_register("'+reg.lower() +  '",' + val + ');'
    else:
        print("[Error]")
        exit(1)    

def gen_cmn_reg_cmd(cmd,reg,val,comments):
    if (nocomment == False):
        cmd.extend(comments)  
    if((wr_rst_val or ('RST VAL' not in val))):
        cmd.append(wr_cmn_reg_cmd('',reg,val))

def wr_cmn_reg_cmd(wreg_cmd, reg, val):
    if (wreg_cmd == ''):
        wreg_cmd = search_reg_xml(reg)
        #print(wreg_cmd)
    if reg.startswith('CMN'):
        return regmodel_path + 'pma_cmn_reg_block'+'.write_dut_register("'+reg.lower() +  '",' + val + ');'
    elif reg.startswith('PHY_PMA_LANE_MAP'): # special for PHY_PMA_LANE_MAP-> PHY PCS COMMON FIELD
        return regmodel_path + 'phy_pcs_cmn_reg_block'+'.write_dut_register("'+reg.lower() +  '",' + val + ');'
    elif reg.startswith('PHY_PMA'):
        return regmodel_path + 'phy_pma_cmn_reg_block'+'.write_dut_register("'+reg.lower() +  '",' + val + ');'
    elif reg.startswith('PHY') and 'PMA' not in reg:
        return regmodel_path + 'phy_pcs_cmn_reg_block'+'.write_dut_register("'+reg.lower() +  '",' + val + ');'
    else:
        print("[Error]")
        exit(1)

def expression_calc(lane_num,expression,eval_context,cmd,reg,val,comments):
    LANE_CFG_USB_TCAM = lane_num
    eval_context['LANE_CFG_USB_TCAM'] = LANE_CFG_USB_TCAM  # Update the context dictionary
    #print(lane_num) 
    if eval(expression, {"__builtins__": {}}, eval_context):
        gen_cmn_reg_cmd(cmd,reg,val,comments)  

def expression_cal_deemphasis(DE_DP,lane_index,expression,eval_context,cmd,reg,val,comments):
    eval_context['DE_DP'] = DE_DP
    if eval(expression, {"__builtins__": {}}, eval_context):
        gen_ln_reg_cmd(lane_index,cmd,reg,val,comments)

def expression_cal_deemphasis_swing(SL_DP,DE_DP,lane_index,expression,eval_context,cmd,reg,val,comments):
    eval_context['SL_DP'] = SL_DP
    eval_context['DE_DP'] = DE_DP
    if eval(expression, {"__builtins__": {}}, eval_context):
        gen_ln_reg_cmd(lane_index,cmd,reg,val,comments)


def lanes_reg_cmd_proc(tx_lanes_cmd,rx_lanes_cmd,m0,row,comments,expression,eval_context,tx_de_dict,tx_coef_dict): 
    if('TX' in row[1]): 
        #special for usb IO voltage--> less than 1.1v or greater than 1.2v
        if '11V' in row[1] and 'RST VAL' not in row[3]:
            tx_lanes_cmd.append('if (IO_USB_TCAM == "VOLT_1P1V") begin')
            gen_ln_reg_cmd(0,tx_lanes_cmd,m0.group(2),row[3],comments)
            tx_lanes_cmd[-1] = '  '+ tx_lanes_cmd[-1] +'\n    end'
            #print(tx_lanes_cmd)
        elif '12V' in row[1] and 'RST VAL' not in row[3]:
            tx_lanes_cmd.append('if (IO_USB_TCAM == "VOLT_1P2V") begin')
            gen_ln_reg_cmd(0,tx_lanes_cmd,m0.group(2),row[3],comments)
            tx_lanes_cmd[-1] = '  '+ tx_lanes_cmd[-1] +'\n    end'
        else:
            gen_ln_reg_cmd(0,tx_lanes_cmd,m0.group(2),row[3],comments)
    if('RX' in row[1]):
        #rx_lanes_regs.append(m0.group(2))
        gen_ln_reg_cmd(1,rx_lanes_cmd,m0.group(2),row[3],comments)
    if('TRUE' in row[1]):
        gen_ln_reg_cmd(0,tx_lanes_cmd,m0.group(2),row[3],comments)
        gen_ln_reg_cmd(1,rx_lanes_cmd,m0.group(2),row[3],comments)
    #print(row[1]) 
    if('DE_DP' in row[1]):
        if ('SL_DP' not in row[1]):
            #print(tx_de_dict['tx_de0_cmd'])
            expression_cal_deemphasis(0,0,expression,eval_context,tx_de_dict['tx_de0_cmd'],m0.group(2),row[3],comments)
            expression_cal_deemphasis(1,0,expression,eval_context,tx_de_dict['tx_de1_cmd'],m0.group(2),row[3],comments)
            expression_cal_deemphasis(2,0,expression,eval_context,tx_de_dict['tx_de2_cmd'],m0.group(2),row[3],comments)
            expression_cal_deemphasis(3,0,expression,eval_context,tx_de_dict['tx_de3_cmd'],m0.group(2),row[3],comments)
            #print(tx_de_dict['tx_de0_cmd'])
        if('SL_DP' in row[1]):
            expression_cal_deemphasis_swing(0,0,0,expression,eval_context,tx_coef_dict['SL_DE_CFG_00'],m0.group(2),row[3],comments)
            expression_cal_deemphasis_swing(0,1,0,expression,eval_context,tx_coef_dict['SL_DE_CFG_01'],m0.group(2),row[3],comments)
            expression_cal_deemphasis_swing(0,2,0,expression,eval_context,tx_coef_dict['SL_DE_CFG_02'],m0.group(2),row[3],comments)
            expression_cal_deemphasis_swing(0,3,0,expression,eval_context,tx_coef_dict['SL_DE_CFG_03'],m0.group(2),row[3],comments)
            expression_cal_deemphasis_swing(1,0,0,expression,eval_context,tx_coef_dict['SL_DE_CFG_10'],m0.group(2),row[3],comments)
            expression_cal_deemphasis_swing(1,1,0,expression,eval_context,tx_coef_dict['SL_DE_CFG_11'],m0.group(2),row[3],comments)
            expression_cal_deemphasis_swing(1,2,0,expression,eval_context,tx_coef_dict['SL_DE_CFG_12'],m0.group(2),row[3],comments)
            expression_cal_deemphasis_swing(2,0,0,expression,eval_context,tx_coef_dict['SL_DE_CFG_20'],m0.group(2),row[3],comments)
            expression_cal_deemphasis_swing(2,1,0,expression,eval_context,tx_coef_dict['SL_DE_CFG_21'],m0.group(2),row[3],comments)
            expression_cal_deemphasis_swing(3,0,0,expression,eval_context,tx_coef_dict['SL_DE_CFG_30'],m0.group(2),row[3],comments)

# generate the sv code
def gen_sv_code(csvreader,prot,mult_prot,csv_cfg,pll_ssc):   
    #for row in csvreader: 
        #print('----'.join(row))
    cmn_cmd = []
    ln_cmd  = []
    all_lanes_cmd =[]
    dp_lanes_cmd = []
    dp_lanes_unuse_cmd = []
    usb_tcam_lanes_cmd =[]
    phy_cmd = []
    phy_cmd_ln1 = []
    phy_cmd_ln2 = []
    phy_cmd_ln4 = [] # special for dp 4 lanes
    tx_lanes_cmd = []
    rx_lanes_cmd = []
    tx_de0_cmd = []
    tx_de1_cmd = []
    tx_de2_cmd = []
    tx_de3_cmd = []
    # When True, we skip commands in the CSV --> this can be because they are for pins
    skip_cmds    = False
    # Accumulation of all comments until a command
    comments = []
    #phy_regs = []
    #usb_tcam_lanes_regs = []
    #cmn_regs = []
    #all_lanes_regs = []
    #dp_lanes_regs = []
    #tx_lanes_regs = []
    #rx_lanes_regs = []
    LANE_CFG_USB_TCAM = '' 
    DE_DP = ''
    SL_DP = ''
    # Define all possible lane configuration values for eval()
    eval_context = {
        'DE_DP': DE_DP,
        'SL_DP': SL_DP,
        'USB1': "USB1",
        'USB2': "USB2", 
        'DP1': "DP1",
        'DP2': "DP2",
        'DP4': "DP4",
        'USB1DP1': "USB1DP1",
        'USB1DP2': "USB1DP2",
        'LANE_CFG_USB_TCAM': LANE_CFG_USB_TCAM
    }
    tx_de_dict = {"tx_de0_cmd":[],"tx_de1_cmd":[],"tx_de2_cmd":[],"tx_de3_cmd":[]}
    tx_coef_dict = {"SL_DE_CFG_00":[], "SL_DE_CFG_01":[], "SL_DE_CFG_02":[], "SL_DE_CFG_03":[],
                    "SL_DE_CFG_10":[], "SL_DE_CFG_11":[], "SL_DE_CFG_12":[], 
                    "SL_DE_CFG_20":[],  "SL_DE_CFG_21":[],  
                    "SL_DE_CFG_30":[]
                    }
    for row in csvreader:
        # parse row
        if len(row) > 0:
            #print(row[1])
        # parse what type of command it is
            m0 = re.match(r"([^:]*):\s*(.*)", row[0])
        else:
            m0  = None
        # Deal with Notes
        if (m0 != None):
            skip_cmds = False
            if ( 'Note' in m0.group(1) ):
                if ('pin' in m0.group(2)):
                    skip_cmds = True
                else:
                    skip_cmds = False
                if (skip_cmds == False):
                    comments.append('//' + m0.group(2) + row[1])
                # Deal with PHY / PMA
            #print(repr(row[1]))
            #print('group1'+repr(m0.group(1)))
            #print('group2'+repr(m0.group(2)))
            #print(skip_cmds)
            if (m0.group(1) in ["PMA_REG", "PHY_REG"] and len(row)>3 and skip_cmds == False):
                #print(row[1])
                
                #--------------------------------------------------
                #  mode0 -protocol 1 lanes --> USB1 / DP1 / USB1DP1
                #  mode1 -protocol 2 lanes --> USB2 / DP2 / USB1DP2
                #  mode2 -protocol 4 lanes --> DP4
                #--------------------------------------------------

                mode0 = f"{prot}1"
                mode1 = f"{prot}2"
                if (prot == 'USB'):
                    #if rate == 'GEN1':
                        #prot_lanes = ['USB_TCAM_GEN1']
                    #if rate == 'GEN2':
                    prot_lanes = ['USB_TCAM_GEN1','USB_TCAM_GEN2']
                elif (prot == 'DP'):
                    prot_lanes = ['DP LANES']
                    mode2 = f"{prot}4" # special for dp 4 lane
                elif (prot == 'USB4'):
                    mode0 = 'USB1'
                    mode1 = 'USB2'
                    prot_lanes = ['USB4_TCAM LANES']
                elif (prot == 'PCIE'):
                    prot_lanes = ['PCIE LANES']
                elif (prot == 'USB_TCAM_DP'):
                    prot_lanes = ['USB_TCAM_GEN1 LANES','USB_TCAM_GEN2 LANES','DP LANES']
                    mode0 = 'USB1DP1'
                    mode1 = 'USB1DP2'
                else:
                    print("[ERROR] - Wrong protocol! MUST be USB, DP, USB4 or PCIE")
                    sys.exit(1)
                #print(repr(row[2]))
                row[3] = re.sub(r'^0x',"'h",row[3])
                # expression replace
                expression = row[1]
                expression = expression.replace('||',' or ')
                expression = expression.replace('&&',' and ')
                expression = expression.replace('!','not ')

                if('CMN' in row [2] or 'ALL LANES' in row[2] or any(lane in row[2] for lane in prot_lanes) or 'PHY' in row[2]):
                    #print(mode0)
                    #print(row[1])
                    if ('PHY' in row[2] and ('USB_TCAM' in row[1] or 'TRUE' in row[1])): 
                        #print('PHY')
                        #print(row[1])
                        if('USB_TCAM' in row[1]):
                            # cal lane_num = 1
                            expression_calc(mode0,expression,eval_context,phy_cmd_ln1,m0.group(2),row[3],comments)

                            # cal lane_num = 2
                            expression_calc(mode1,expression,eval_context,phy_cmd_ln2,m0.group(2),row[3],comments)
                            
                            # cal lane_num = 4
                            if prot == 'DP':              
                                expression_calc(mode2,expression,eval_context,phy_cmd_ln4,m0.group(2),row[3],comments) 

                        if ('TRUE' in row[1]):
                            reg = m0.group(2)
                            val = row[3] 
                            gen_cmn_reg_cmd(cmn_cmd,reg,val,comments) 

                    if( any(lane in row[2] for lane in prot_lanes) and ('LANE_USB_TCAM' in row[1] or 'TRUE' in row[1] or 'DE_DP' in row[1])):
                        if (prot == 'USB_TCAM_DP'):
                            if 'USB_TCAM' in row[2]:
                                lanes_reg_cmd_proc(tx_lanes_cmd,rx_lanes_cmd,m0,row,comments,expression,eval_context,tx_de_dict,tx_coef_dict)
                            if 'DP LANES' in row[2]:
                                lanes_reg_cmd_proc(dp_lanes_cmd,dp_lanes_unuse_cmd,m0,row,comments,expression,eval_context,tx_de_dict,tx_coef_dict)
                        else:
                            lanes_reg_cmd_proc(tx_lanes_cmd,rx_lanes_cmd,m0,row,comments,expression,eval_context,tx_de_dict,tx_coef_dict)

                    if( 'CMN' in row[2]):
                        if (row[1]  == 'TRUE' ):
                            #cmn_regs.append(m0.group(2))
                            gen_cmn_reg_cmd(cmn_cmd,m0.group(2),row[3],comments)  
                    if( 'ALL LANES' in row[2]):
                        if (row[1]  == 'TRUE' ):
                            #all_lanes_regs.append(m0.group(2))
                            gen_ln_reg_cmd(0,tx_lanes_cmd,m0.group(2),row[3],comments) 
                            gen_ln_reg_cmd(1,rx_lanes_cmd,m0.group(2),row[3],comments)          
                
                comments = [] 
    # -------------------------------debug
   # for item in cmn_cmd:
   #      print (item)
   # for item in ln_cmd:
   #     print (item)
    #--------------------------------debug
    write_to_sv_file(pll_ssc,tx_de_dict,tx_coef_dict,cmn_cmd,dp_lanes_cmd,tx_lanes_cmd,rx_lanes_cmd,all_lanes_cmd,phy_cmd,phy_cmd_ln1,phy_cmd_ln2,phy_cmd_ln4,csv_cfg,prot)
    #print("[INFO] - write complete!")
    #print(tx_coef_dict)
   # print(cmn_cmd)
   # print(phy_cmd)
   # print(phy_cmd_ln1)
   # print(phy_cmd_ln2)
   # print(dp_lanes_cmd)
   # print(all_lanes_cmd)
   # print(usb_tcam_lanes_cmd)
   # print(tx_lanes_regs)
   # print(rx_lanes_regs)
   # print(tx_de_dict['tx_de0_cmd'])
   # print(tx_de_dict['tx_de1_cmd'])
   # print(tx_de_dict['tx_de2_cmd'])
   # print(tx_de_dict['tx_de3_cmd'])

# from the csv filename get info
def get_csv_file_info(csv_filename):    
    prot = None
    refclk = None
    rate = None
    mult_prot = []
    pll_ssc = {"PLL0": 'None_ssc', "PLL1": 'None_ssc'}
    prot,refclk,rate,pll_ssc = get_protocol_refclk(prot,refclk,rate,csv_filename,pll_ssc)
    #debug
    print("[INFO] - "+"Protocol:"+ prot)
    print("[INFO] - "+"Refclk:"+ refclk)
    if prot  == 'USB' or prot == 'USB_TCAM_DP':
        print("[INFO] - "+"Rate:"+ rate)
    print("[INFO] - "+"PLL0_SSC:"+ pll_ssc["PLL0"])
    print("[INFO] - "+"PLL1_SSC:"+ pll_ssc["PLL1"])
    csv_cfg = get_csv_config(prot,refclk,csv_filename)
    #debug
    print("[INFO] - CSV CFG: "+csv_cfg)
    # open csv
    return prot,mult_prot,csv_cfg,pll_ssc

def process_info_gen_sv(csv_filename):
    print("---"*30)
    print("[INFO] - " + csv_filename)
    prot,mult_prot,csv_cfg,pll_ssc = get_csv_file_info(csv_filename)
    csvreader =open_csv_get_reg(csv_filename)
    gen_sv_code(csvreader,prot,mult_prot,csv_cfg,pll_ssc)

def get_extern_file(original_sv_file,extern_file_name):
    if not os.path.exists(original_sv_file):
        print(f"[WARNING] - Original SV file not found: {original_sv_file}")
        return
    lines_with_task = []
    with open(original_sv_file, 'r', encoding='utf-8') as f:
        for line in f:
            if 'task' in line and 'endtask' not in line:
                lines_with_task.append(line.strip())
    #print(lines_with_task)

    lst_extern = [s.replace("task cdn_phy_bring_up_seq::", "extern task ") for s in lines_with_task]

    #print(lst_extern)
    with open (extern_file_name,'w') as file :
        for item in lst_extern:
            file.write(item+'\n')


if __name__ == '__main__':

    #csvfile_path = 'C:/my_dv_file/USB4/'
    task_file_path = './'
    csvfile_path = './pg_csv/'
    file_name = "cdn_phy_bring_up_task.sv"
    extern_file_name = 'cdn_phy_pg_task_extern_define.sv'
    # regmodel path
    regmodel_path = 'p_sequencer.regmodel.'
    # seq_class
    seq_class = 'cdn_phy_bring_up_seq::'
    # xml path
    xml_path = './xml'
    # command options
    parser = optparse.OptionParser()
    parser.add_option("-c", "--csv", type="str",dest= "csv_filename",help="Specify CSV filename")
    parser.add_option("-n",  "--nocomment",      action="store_true", dest="nocomment",  default=False, help="Don't add comments in generated sv code") 
    parser.add_option("-r",  "--reset_val_write",action="store_true", dest="wr_rst_val", default=False, help="Add writes to reset values in sv code") 
    parser.add_option("-a",  "--all",action="store_true", dest="load_all_csvfile", default=False, help="gen all csv pg file task in current path")
    (opts,args) = parser.parse_args()
    nocomment  = opts.nocomment
    wr_rst_val = opts.wr_rst_val
    load_all_csvfile = opts.load_all_csvfile
    
    #get protocol and refclk from the csv

    #protocol_list = ['PCIE','USB','USB4','DP','USB_TCAM_GEN1_DP','USB_TCAM_GEN2_DP']
    refclk_list   = ['19p2','24p0','100p0']
    #rate_list      = ['GEN1','GEN2']
    all_csv_file = []
    # clear the file
    with open (task_file_path+file_name,'w') as file:
        pass
    if opts.csv_filename is None :
        if load_all_csvfile:
            excluded = {"backup", ".git", "__pycache__"}
            #all_csv_file = [f for f in os.listdir(csvfile_path) if f.endswith('.csv')]
            for dirpath, dirnames, filenames in os.walk(csvfile_path):
                dirnames[:] = [d for d in dirnames if d not in excluded]
                for name in filenames:
                    if name.lower().endswith(".csv"):
                        all_csv_file.append(os.path.join(dirpath, name))
            if not all_csv_file:
                print("[ERROR] - NO CSV file in current path")
                sys.exit(1)
            for index,csv_filename in enumerate(all_csv_file):
                process_info_gen_sv(csv_filename)
                print("[INFO] - Writing "+str(index+1) +'/'+ str(len(all_csv_file)))
        else:
            print("[ERROR] - please give the correct -csv *.csv options")
            sys.exit(1)
    else :
        csv_filename = opts.csv_filename
        process_info_gen_sv(csv_filename)
    get_extern_file(file_name,extern_file_name)






    




