import copy

def sd0200_reg_list_fix(reg_list):
    for reg in reg_list:
        if reg.mnemonic == 'tx_hydc_emph_trval_##':
            for fld in reg.fields:
                fld.name = fld.name.replace("_##", "")
            for i in range(64):
                new_reg = reg if(i==63) else copy.deepcopy(reg)
                new_reg.mnemonic = new_reg.mnemonic.replace("##", str(i))
                new_reg.address  = new_reg.address+i
                if i == 0 : new_reg.reset_value  = 0b0000000
                if i == 1 : new_reg.reset_value  = 0b0000010
                if i == 2 : new_reg.reset_value  = 0b0000100
                if i == 3 : new_reg.reset_value  = 0b0000110
                if i == 4 : new_reg.reset_value  = 0b0001001
                if i == 5 : new_reg.reset_value  = 0b0001011
                if i == 6 : new_reg.reset_value  = 0b0001110
                if i == 7 : new_reg.reset_value  = 0b0010010
                if i == 8 : new_reg.reset_value  = 0b0010110
                if i == 9 : new_reg.reset_value  = 0b0011010
                if i == 10 : new_reg.reset_value = 0b0011101
                if i == 11 : new_reg.reset_value = 0b0100001
                if i == 12 : new_reg.reset_value = 0b0100100
                if i == 13 : new_reg.reset_value = 0b0100111
                if i == 14 : new_reg.reset_value = 0b0101011
                if i == 15 : new_reg.reset_value = 0b0101110
                if i == 16 : new_reg.reset_value = 0b0110010
                if i == 17 : new_reg.reset_value = 0b0110101
                if i == 18 : new_reg.reset_value = 0b0111001
                if i == 19 : new_reg.reset_value = 0b0111100
                if i == 20 : new_reg.reset_value = 0b1000000
                if i == 21 : new_reg.reset_value = 0b1000011
                if i == 22 : new_reg.reset_value = 0b1000111
                if i == 23 : new_reg.reset_value = 0b1001011
                if i == 24 : new_reg.reset_value = 0b1001111
                if i == 25 : new_reg.reset_value = 0b1010011
                if i == 26 : new_reg.reset_value = 0b1010111
                if i == 27 : new_reg.reset_value = 0b1011011
                if i == 28 : new_reg.reset_value = 0b1011111
                if i == 29 : new_reg.reset_value = 0b1100011
                if i == 30 : new_reg.reset_value = 0b1100111
                if i == 31 : new_reg.reset_value = 0b1101011
                if i == 32 : new_reg.reset_value = 0b1101111
                if i == 33 : new_reg.reset_value = 0b1110011
                if i == 34 : new_reg.reset_value = 0b1110111
                if i == 35 : new_reg.reset_value = 0b1111011
                if i == 36 : new_reg.reset_value = 0b1111111
                if i == 37 : new_reg.reset_value = 0b1111111
                if i == 38 : new_reg.reset_value = 0b1111111
                if i == 39 : new_reg.reset_value = 0b1111111
                if i == 40 : new_reg.reset_value = 0b1111111
                if i == 41 : new_reg.reset_value = 0b1111111
                if i == 42 : new_reg.reset_value = 0b1111111
                if i == 43 : new_reg.reset_value = 0b1111111
                if i == 44 : new_reg.reset_value = 0b1111111
                if i == 45 : new_reg.reset_value = 0b1111111
                if i == 46 : new_reg.reset_value = 0b1111111
                if i == 47 : new_reg.reset_value = 0b1111111
                if i == 48 : new_reg.reset_value = 0b1111111
                if i == 49 : new_reg.reset_value = 0b1111111
                if i == 50 : new_reg.reset_value = 0b1111111
                if i == 51 : new_reg.reset_value = 0b1111111
                if i == 52 : new_reg.reset_value = 0b1111111
                if i == 53 : new_reg.reset_value = 0b1111111
                if i == 54 : new_reg.reset_value = 0b1111111
                if i == 55 : new_reg.reset_value = 0b1111111
                if i == 56 : new_reg.reset_value = 0b1111111
                if i == 57 : new_reg.reset_value = 0b1111111
                if i == 58 : new_reg.reset_value = 0b1111111
                if i == 59 : new_reg.reset_value = 0b1111111
                if i == 60 : new_reg.reset_value = 0b1111111
                if i == 61 : new_reg.reset_value = 0b1111111
                if i == 62 : new_reg.reset_value = 0b1111111
                if i == 63 : new_reg.reset_value = 0b1111111

                if i < 63  : reg_list.append(new_reg)

        if reg.mnemonic == 'tx_hydc_pres_preval_##':
            for fld in reg.fields:
                fld.name = fld.name.replace("_##", "")
            for i in range(11):
                new_reg = reg if(i==10) else copy.deepcopy(reg)
                new_reg.mnemonic = new_reg.mnemonic.replace("##", str(i))
                new_reg.address = new_reg.address+i
                if i == 0 : new_reg.reset_value = 0
                if i == 1 : new_reg.reset_value = 0
                if i == 2 : new_reg.reset_value = 0
                if i == 3 : new_reg.reset_value = 0
                if i == 4 : new_reg.reset_value = 0
                if i == 5 : new_reg.reset_value = 6 
                if i == 6 : new_reg.reset_value = 7 
                if i == 7 : new_reg.reset_value = 6
                if i == 8 : new_reg.reset_value = 7
                if i == 9 : new_reg.reset_value = 9
                if i == 10 : new_reg.reset_value = 0
                if i < 10  : reg_list.append(new_reg)

        if reg.mnemonic == 'tx_hydc_calc_preval_##':
            for fld in reg.fields:
                fld.name = fld.name.replace("_##", "")
            for i in range(4):
                new_reg = reg if(i==3) else copy.deepcopy(reg)
                new_reg.mnemonic = new_reg.mnemonic.replace("##", str(i))
                new_reg.address = new_reg.address+i
                if i == 0 : new_reg.reset_value = 0
                if i == 1 : new_reg.reset_value = 0
                if i == 2 : new_reg.reset_value = 0
                if i == 3 : new_reg.reset_value = 0
                if i < 3  : reg_list.append(new_reg)

        if reg.mnemonic == 'tx_hydc_pres_mainval_##':
            for fld in reg.fields:
                fld.name = fld.name.replace("_##", "")
                #print fld.name
            for i in range(11):
                new_reg = reg if(i==10) else copy.deepcopy(reg)
                new_reg.mnemonic = new_reg.mnemonic.replace("##", str(i))
                new_reg.address = new_reg.address+i
                if i == 0 : new_reg.reset_value = 42 
                if i == 1 : new_reg.reset_value = 47 
                if i == 2 : new_reg.reset_value = 45
                if i == 3 : new_reg.reset_value = 49
                if i == 4 : new_reg.reset_value = 56
                if i == 5 : new_reg.reset_value = 50 
                if i == 6 : new_reg.reset_value = 49 
                if i == 7 : new_reg.reset_value = 39
                if i == 8 : new_reg.reset_value = 42
                if i == 9 : new_reg.reset_value = 47
                if i == 10 : new_reg.reset_value = 37
                if i < 10  : reg_list.append(new_reg)

        if reg.mnemonic == 'tx_hydc_calc_mainval_##':
            for fld in reg.fields:
                fld.name = fld.name.replace("_##", "")
            for i in range(4):
                new_reg = reg if(i==3) else copy.deepcopy(reg)
                new_reg.mnemonic = new_reg.mnemonic.replace("##", str(i))
                new_reg.address = new_reg.address+i
                if i == 0 : new_reg.reset_value = 42
                if i == 1 : new_reg.reset_value = 47
                if i == 2 : new_reg.reset_value = 56
                if i == 3 : new_reg.reset_value = 56
                if i < 3  : reg_list.append(new_reg)

        if reg.mnemonic == 'tx_hydc_pres_postval_##':
            for fld in reg.fields:
                fld.name = fld.name.replace("_##", "")
            for i in range(11):
                new_reg = reg if(i==10) else copy.deepcopy(reg)
                new_reg.mnemonic = new_reg.mnemonic.replace("##", str(i))
                new_reg.address = new_reg.address+i
                if i == 0 : new_reg.reset_value = 14 
                if i == 1 : new_reg.reset_value = 9 
                if i == 2 : new_reg.reset_value = 11
                if i == 3 : new_reg.reset_value = 7
                if i == 4 : new_reg.reset_value = 0
                if i == 5 : new_reg.reset_value = 0 
                if i == 6 : new_reg.reset_value = 0 
                if i == 7 : new_reg.reset_value = 11
                if i == 8 : new_reg.reset_value = 7
                if i == 9 : new_reg.reset_value = 0
                if i == 10 : new_reg.reset_value = 19
                if i < 10  : reg_list.append(new_reg)

        if reg.mnemonic == 'tx_hydc_calc_postval_##':
            for fld in reg.fields:
                fld.name = fld.name.replace("_##", "")
            for i in range(4):
                new_reg = reg if(i==3) else copy.deepcopy(reg)
                new_reg.mnemonic = new_reg.mnemonic.replace("##", str(i))
                new_reg.address = new_reg.address+i
                if i == 0 : new_reg.reset_value = 14
                if i == 1 : new_reg.reset_value = 9
                if i == 2 : new_reg.reset_value = 0
                if i == 3 : new_reg.reset_value = 0
                if i < 3  : reg_list.append(new_reg)

        return reg_list

