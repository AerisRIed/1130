import cdb_parse
import cdb_const
import cdb_pma_ipxact
import csv_gen
import ecov_gen
import fschar_gen
import parameter_gen
import c_gen
import cdb_single_reg_list
import cdb_sd0200_fixes
import cdb_ctrl
import rstruct_gen
import optparse
import os
import sys


def filter_reg(filter_options, reg):
    """
    Return TRUE if the register name doesn't have a filter_option in it.
    Filter the fields of the register if the register shouldn't be removed.
    """
    remove_reg = False
    for filter_char in filter_options:
        if reg.name.find('('+filter_char+')') != -1:
            remove_reg = True

    if not remove_reg:
        for filter_char in filter_options:
            reg.filter_fields(filter_char)

    return remove_reg


if __name__ == '__main__':
    cmd_parser = optparse.OptionParser()
    cmd_parser.add_option("-a", "--ascending_sort", type="int", dest="ascending_sort")
    cmd_parser.add_option("-b", "--byte_addressing", type="int", dest="byte_addressing")
    cmd_parser.add_option("-c", "--csv", type="int", dest="gen_csv")
    cmd_parser.add_option("-d", "--debug", type="int", dest="debug")
    cmd_parser.add_option("-e", "--ecov", type="int", dest="gen_ecov")
    cmd_parser.add_option("-f", "--fschar", type="int", dest="fschar")
    cmd_parser.add_option("-g", "--gen_param", type="int", dest="gen_param")
    cmd_parser.add_option("-l", "--left_lns", type="int", dest="left_lanes")
    cmd_parser.add_option("-m", "--max_lanes", type="int", dest="max_lanes")
    cmd_parser.add_option("-o", "--register_options", type="str", dest="register_options")
    cmd_parser.add_option("-p", "--report", type="int", dest="report")
    cmd_parser.add_option("-r", "--right_lns", type="int", dest="right_lanes")
    cmd_parser.add_option("-s", "--sd", type="str", dest="proj")
    cmd_parser.add_option("-v", "--version", type="int", dest="version")
    cmd_parser.add_option("-u", "--full_addr_map", type="int", dest="full_addr_map")
    cmd_parser.add_option("-y", "--full_map", type="int", dest="full_map")
    cmd_parser.add_option("-z", "--post_pend", type="str", dest="post_pend")

    broken_file = open('SCRIPT_BROKEN', 'w')
    broken_file.write('\n')
    broken_file.close()

    (opts, args) = cmd_parser.parse_args()

    if opts.right_lanes is None:
        rght_lns = 0
    else:
        rght_lns = opts.right_lanes

    if opts.version is None:
        v2 = False 
    else:
        v2 = (opts.version == 2) 

    if opts.max_lanes is None:
        max_lanes = 1 
    else:
        max_lanes = opts.max_lanes

    if opts.debug is None:
        dbg = 0
    else:
        dbg = opts.debug 

    if opts.left_lanes is None:
        lft_lns = 0
    else:
        lft_lns = opts.left_lanes

    if opts.report is None:
        pma_reg_report = 0
    else:
        pma_reg_report = opts.report

    if opts.ascending_sort is None:
        asc_sort = True
    else:
        asc_sort = opts.ascending_sort

    if opts.proj is None:
        print("No Project Num Specified\n")
        cmd_parser.print_help()
        exit(-1)
    else:
        sd = opts.proj

    if opts.gen_csv is None:
        gen_csv = 0
    else:
        gen_csv = 1

    if opts.gen_ecov is None:
        gen_ecov = 0
    else:
        gen_ecov = 1

    if opts.gen_param is None:
        gen_param = 0
    else:
        gen_param = 1

    if opts.fschar is None:
        gen_fschar = 0
    else:
        gen_fschar = 1

    if opts.full_map is None:
        full_map = 0
    else:
        full_map = 1

    if opts.full_addr_map is None:
        full_addr_map = 0
    else:
        full_addr_map = 1

    if opts.post_pend is None:
        post_pend = ''
    else:
        post_pend = opts.post_pend

    if opts.byte_addressing is None:
        byte_addressing = False
    else:
        byte_addressing = (opts.byte_addressing == 1)

    # Parse the filter options - by default if there are no options filtered then all options are present
    if opts.register_options is None:
        filter_regs = False
        filter_options_str = ''
    else:
        filter_regs = True
        # @ - PIPE Registers
        # & - RAW IF Registers
        # % - 10G KR Registers
        # # - PIPE Margining Registers
        filter_options = ['@', '&', '%', '#', '!']
        filter_options_str = '_'
        for x in opts.register_options:
            if filter_options.__contains__(x):
                filter_options.remove(x)
        if opts.register_options.__contains__('@'):
           filter_options_str += 'P'
        if opts.register_options.__contains__('&'):
            filter_options_str += 'R'
        if opts.register_options.__contains__('%'):
            filter_options_str += 'E'
        if opts.register_options.__contains__('#'):
            filter_options_str += 'M'
        if opts.register_options.__contains__('!'):
            filter_options_str += 'X'
        if filter_options_str == "_":
            filter_options_str = ''
            filter_regs = False
        print(filter_options)
        print(filter_regs)

    if byte_addressing:
        filter_options_str += '_BA'

    phy_reg_list = []

    # try:
    param_file = "projects/sd"+sd+"/sd"+sd+"_proj_params"
    sys.path.append('projects/sd'+sd+'/proj_params')
    mod = __import__('sd'+sd+'_proj_params')
    proj_params_class = getattr(mod, "sd"+sd+"_proj_params")
    print('Wencheng'+param_file)
    proj_params = proj_params_class(lft_lns, rght_lns)
    #print(proj_params)
    print('source file:',proj_params.src_files)
    #print(proj_params.override_dict)
    #print(proj_params.phy_xml_is_ipxact)
    #print('1')
    #print(proj_params.adr_blk_dict)
    print('dst file:',proj_params.dest_file)
    # except:
    #    print "SD0"+sd+" Specified : No Proj Params File Found for SD0"+sd
    #    exit(-1)

    if (rght_lns | lft_lns) == 0:
        print("Right Lanes + Left Lanes == 0 - Not a Valid Configuration\n")
        cmd_parser.print_help()
        exit(-1)

    try:
        reg_width = proj_params.reg_width
    except:
        reg_width = 32

    try:
        addr_width = proj_params.addr_width
    except:
        addr_width = 16

    try:
        adr_map_dict = proj_params.adr_map_dict
    except:
        adr_map_dict = {}

    try:
        addr_offset = proj_params.addr_offset
    except:
        addr_offset = 4

    cdb_params = cdb_ctrl.cdb_ctrl(reg_width, addr_width, adr_map_dict, addr_offset)

    reg_list = []
    if proj_params.src_files != {}:
        for src_file in proj_params.src_files:
            reg_list += cdb_parse.parse_fm_xml(src_file, proj_params.override_dict, dbg, cdb_params, asc_sort)

    # Filter the Registers if enabled via user options
    if filter_regs:
        new_reg_list = []
        for reg in reg_list:
            # Determine if the register should be filtered and filter the fields of the new register
            remove_reg_from_reg_list = filter_reg(filter_options, reg)
            if not remove_reg_from_reg_list:
                new_reg_list.append(reg)
        reg_list = new_reg_list

    #create the complete list of registers for a full map or fschar
    num_lns = rght_lns + lft_lns
    complete_reg_list = cdb_single_reg_list.gen_complete_reg_list(proj_params, reg_list, phy_reg_list, num_lns)

    # SD200 Fix - needed because the SD0200 has special repeat characters in its XML
    if sd == "200" and reg_list != []:
        reg_list = cdb_sd0200_fixes.sd0200_reg_list_fix(reg_list)

    if pma_reg_report == 1:
        pass

    all_good = True
    for reg in reg_list:
        if dbg == 1:
            print(reg.print_reg())
        if reg.error:
            if all_good:
                print("PMA/PHY_REG_LIST had an ERROR:")
                all_good = False
            print(reg.mnemonic)

    if not all_good:
        exit(-1)
        
    if byte_addressing:
        for reg in reg_list:
            reg.convert_to_byte_addressing()
        for rc in complete_reg_list:
            rc.convert_to_byte_addressing()

   
    cdb_pma_ipxact.gen_phy_ipxact_map(proj_params, reg_list, max_lanes, v2, post_pend, filter_options_str, byte_addressing)
    
    print("Wrote "+proj_params.dest_file+"* files")

######below is no use for ipxact ---- wencheng########
#    # try:
#    if proj_params.const_gen:
#       ofile_reg = open(proj_params.const_file, 'w')
#       reg_const = cdb_const.cdb_const(ofile_reg)
#       reg_const.write_header(addr_width)
#
#       for reg in reg_list:
#                reg_const.write_register(reg,reg_width,addr_width)
#                ofile_reg.write("\n")
#       ofile_reg.close()
#       print("Wrote "+proj_params.const_file)
#    # except:
#    #    print "Verilog Constants File Generation Failed"
#    #    exit(-1)
#
#    # try:
#    if gen_param == 1:
#       ofile_param_name = proj_params.dest_file+"phy_reg_params.v"
#
#       ofile_param = open(ofile_param_name, 'w')
#       param       = parameter_gen.parameter_gen(ofile_param)
#       param.write_header()
#       for reg in reg_list:
#           param.write_register(reg,reg_width)
#       ofile_param.close()
#       print("Wrote "+ofile_param_name)
#       
#       ofile_c_name = proj_params.dest_file+"phy_c_params.c"
#
#       ofile_c = open(ofile_c_name, 'w')
#       c       = c_gen.c_gen(ofile_c)
#       c.write_header()
#       for reg in reg_list:
#           c.write_register(reg)
#       ofile_c.close()
#       print("Wrote "+ofile_c_name)
#
#       ofile_sv_name = proj_params.dest_file+"reg_pkg.svh"
#       ofile_sv = open(ofile_sv_name, 'w')
#       sv      = rstruct_gen.rstruct_gen(ofile_sv)
#       sv.write_rstruct_file(reg_list)
#       ofile_sv.close()
#       print("Wrote "+ofile_sv_name)
#    # except:
#    #    print "Verilog Params File Generation Failed"
#    #    exit(-1)
#
#    try:
#      if gen_csv == 1:
#          print("CSV File Generation starting")
#          ofile_csv_name = proj_params.dest_file+"phy_regs.csv"
#
#          ofile_csv = open(ofile_csv_name, 'w')
#          csv     = csv_gen.csv_gen(ofile_csv)
#          csv.write_header()
#          for regs in reg_list:
#              csv.write_register(reg)
#          print("Wrote "+ofile_csv_name)
#    except:
#      print("CSV File Generation Failed")
#      exit(-1)
#
#    try:
#        if gen_ecov == 1:
#            print("Specman/e Coverage File Generation starting")
#            ecov = ecov_gen.ecov_gen()
#            ecov.write_register_cov_file(proj_params, reg_list, phy_reg_list)
#            print("Specman/e Coverage File Generation done")
#    except:
#        print("Specman/e Coverage File Generation Failed")
#        exit(-1)
# 
#    try:
#        if gen_fschar == 1:
#            ofile_csv_name = proj_params.dest_file+"phy_fschar.csv"
#            ofile_csv = open(ofile_csv_name, 'w')
#            fschar     = fschar_gen.fschar_gen(ofile_csv)
#            fschar.write_line_0()
#            fschar.write_line_1()
#            fschar.write_line_2()
#
#        # for regs in [reg_list, phy_reg_list]:
#            for reg in complete_reg_list:
#                fschar.write_register(reg)
#            fschar.write_end_line()
#            print("Wrote "+ofile_csv_name)
#    except:
#        print("FSCHAR File Generation Failed")
#        exit(-1)
# 
#    if full_map == 1:
#        cdb_pma_ipxact.write_full_map(proj_params, complete_reg_list, max_lanes, v2, post_pend, filter_options_str, byte_addressing)
#
#    if full_addr_map == 1:
#        cdb_pma_ipxact.write_all_addr_blks(proj_params, reg_list, max_lanes, v2, post_pend, filter_options_str, byte_addressing)
#
#    #except:
#    #    print "Full Map Generation Failed"
#    #    exit(-1)
#
#    os.remove('SCRIPT_BROKEN')
