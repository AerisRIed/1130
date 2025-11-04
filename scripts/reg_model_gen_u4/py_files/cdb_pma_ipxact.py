import cdb_ipxact
import xml.etree.ElementTree as eTree


def gen_phy_ipxact_map(proj_params, reg_list, max_lanes=1, v2=False, post_pend='', filter_options_string='', byte_addressing=False):
    # Write the PMA's IPXACT Tables
    for rng_key in proj_params.adr_blk_dict:
        write_ipxact_map(proj_params, rng_key, proj_params.adr_blk_dict, reg_list, max_lanes, v2, post_pend, filter_options_string, byte_addressing)

    # Write the PHY's IPXACT Tables
    if proj_params.phy_xml_is_ipxact:
        write_phy_ipxact_map(phy_ipxact, proj_params, max_lanes)


def write_ipxact_map(proj_params, rng_key, adr_blk_dict, reg_list, max_lanes=1, v2=False, post_pend='', filter_options_string='', byte_addressing=False):
    bname1 = 'cdns_lib'
    bname2 = rng_key;
    bname = 'sd3101_t4_registers'
    bname3 = 'sd3101_phy_registers'
    #if rng_key == 'pma_cmn_registers':
    #    ofile = open(proj_params.dest_file+'pma_'+proj_params.ln_cfg+'_cmn_registers'+filter_options_string+'.xml', 'w')
    #else:
    ofile = open(proj_params.dest_file+rng_key+filter_options_string+'.xml', 'w')
    #ro_ofile = open(proj_params.dest_file+rng_key+'_read_only_regs'+filter_options_string+'.txt', 'w')

    phy_ipxact = cdb_ipxact.cdb_ipxact(ofile, v2, post_pend)
    phy_ipxact.open_component(bname1, bname2)
    phy_ipxact.open_memory_map(bname)

    base            = adr_blk_dict[rng_key]['base']
    rng             = adr_blk_dict[rng_key]['rng']
    offset          = 0
    #print('debug base',base,'rng',rng)
    try:
        addr_offset = proj_params.addr_offset
    except:
        addr_offset = 4

    try:
        width = proj_params.reg_width
        if width == 32:
            #base *= addr_offset 
            #rng  = rng * addr_offset + addr_offset - 1 
            width = 32
            addressUnitBits = '8'
    except AttributeError:
        width           = 32
        addressUnitBits = '16'
    # Update the Addressing and Ranges
    if byte_addressing:
        base *= 4
        rng  *= 4 + 3
        width = 32
        addressUnitBits = '8'
    #for reg in reg_list:
    #    print(int(reg.address),base,rng,base+rng)
    ipxact_reg_list = [reg for reg in reg_list if (int(reg.address) >= base) and (int(reg.address) <= (base+rng))]
    #print ('debug',len(ipxact_reg_list)) 
    #ro_ofile.write("<'\n")
    #ro_ofile.write('extend '+proj_params.sve+' { \n')
    #ro_ofile.write('   '+bname+'_ignore_list : list of string;\n')
    #ro_ofile.write('     keep '+bname+'_ignore_list == {')

    if len(ipxact_reg_list):
        phy_ipxact.open_address_block(bname3, base, rng, offset, width)
        for reg in ipxact_reg_list:
            phy_ipxact.write_register(reg, width)
            #for fld in reg.fields :
            #    if fld.access_type in ['read-only', 'read-clear'] :
            #        ro_ofile.write('\n            \"'+fld.name+'\";')
        phy_ipxact.close_address_block()

    #ro_ofile.write('\n   };\n')
    #ro_ofile.write('};\n')
    #ro_ofile.write("'>\n")

    phy_ipxact.close_memory_map(addressUnitBits)
    phy_ipxact.close_component()
    #ro_ofile.close()
    ofile.close()


def write_phy_ipxact_map(phy_ipxact, proj_params, max_lanes=1):
    if proj_params.phy_xml_is_ipxact:
        for input_file in proj_params.phy_xml_list:
            in_adr_blk = False
            ifile = open(input_file, 'r')
            lines = ifile.readlines()
            for line in lines:
                if in_adr_blk:
                    tline = line.rstrip()
                    phy_ipxact.write(tline)

                if line.find("addressBlock") != -1:
                    if not in_adr_blk:
                        tline = line.rstrip()
                        phy_ipxact.write(tline)
                    in_adr_blk = in_adr_blk.__invert__()



def write_all_addr_blks(proj_params, reg_list, max_lanes=1, v2=False, post_pend='', filter_options_string='', byte_addressing=False):
    bname = proj_params.mem_library
    ofile_name = proj_params.dest_file+'full_addr_map'+filter_options_string+'.xml'
    print(ofile_name)
    ofile = open(ofile_name, 'w')
    ro_ofile = open(proj_params.dest_file+'full_addr_map'+'_read_only_regs'+filter_options_string+'.txt', 'w')

    phy_ipxact = cdb_ipxact.cdb_ipxact(ofile, v2, post_pend)
    phy_ipxact.open_component(bname, bname)
    phy_ipxact.open_memory_map(bname)

    try:
        width = proj_params.reg_width
        if width == 16:
            width = 16
            addressUnitBits = '8'
    except AttributeError:
        width           = 16
        addressUnitBits = '16'

    for rng_key in sorted(proj_params.adr_blk_dict):
        base            = proj_params.adr_blk_dict[rng_key]['base']
        rng             = proj_params.adr_blk_dict[rng_key]['rng']

        if 'offset' in list(proj_params.adr_blk_dict[rng_key].keys()):
            offset = proj_params.adr_blk_dict[rng_key]['offset']
        else:
            offset = 0

        ipxact_reg_list = [reg for reg in reg_list if (int(reg.address) >= base) and (int(reg.address) <= (base+rng))]
        
        ro_ofile.write("<'\n")
        ro_ofile.write('extend '+proj_params.sve+' { \n')
        ro_ofile.write('   '+bname+'_ignore_list : list of string;\n')
        ro_ofile.write('     keep '+bname+'_ignore_list == {')

        if len(ipxact_reg_list):
            phy_ipxact.open_address_block(bname, base, rng, offset, width)
            for reg in ipxact_reg_list:
                phy_ipxact.write_register(reg, width)
                for fld in reg.fields :
                    if fld.access_type in ['read-only', 'read-clear'] :
                        ro_ofile.write('\n            \"'+fld.name+'\";')
            phy_ipxact.close_address_block()

    
    ro_ofile.write('\n   };\n')
    ro_ofile.write('};\n')
    ro_ofile.write("'>\n")

    phy_ipxact.close_memory_map(addressUnitBits)
    phy_ipxact.close_component()
    ro_ofile.close()
    ofile.close()



def write_full_map(proj_params, reg_list, max_lanes=1, v2=False, post_pend='', filter_options_string='', byte_addressing=False):
    bname = proj_params.mem_library+'_phy'
    ofile_name = proj_params.dest_file+'full_map'+filter_options_string+'.xml'
    print(ofile_name)
    ofile = open(ofile_name, 'w')
    ro_ofile = open(proj_params.dest_file+'full_map'+'_read_only_regs'+filter_options_string+'.txt', 'w')

    phy_ipxact = cdb_ipxact.cdb_ipxact(ofile, v2, post_pend)
    phy_ipxact.open_component(bname, bname)
    phy_ipxact.open_memory_map(bname)

    base            = 0 
    offset          = 0
    try:
        width = proj_params.reg_width
        if width == 16:
            width = 16
            rng             = 0x3ffff
            addressUnitBits = '8'
    except AttributeError:
        width           = 16
        rng             = 0xffff
        addressUnitBits = '16'


    # Update the Addressing and Ranges
    if byte_addressing:
        rng   = 0x3ffff
        width = 16
        addressUnitBits = '8'
    ipxact_reg_list = reg_list 
    
    ro_ofile.write("<'\n")
    ro_ofile.write('extend '+proj_params.sve+' { \n')
    ro_ofile.write('   '+bname+'_ignore_list : list of string;\n')
    ro_ofile.write('     keep '+bname+'_ignore_list == {')

    if len(ipxact_reg_list):
        phy_ipxact.open_address_block('full_map', base, rng, offset, width)
        for reg in ipxact_reg_list:
            phy_ipxact.write_register(reg, width)
            for fld in reg.fields :
                if fld.access_type in ['read-only', 'read-clear'] :
                    ro_ofile.write('\n            \"'+fld.name+'\";')
        phy_ipxact.close_address_block()

    ro_ofile.write('\n   };\n')
    ro_ofile.write('};\n')
    ro_ofile.write("'>\n")

    phy_ipxact.close_memory_map(addressUnitBits)
    phy_ipxact.close_component()
    ro_ofile.close()
    ofile.close()
