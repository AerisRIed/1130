import cdb_ipxact
import copy


def gen_complete_reg_list(proj_params, reg_list, phy_reg_list, max_lanes=1):
    complete_reg_list = []

    #Expand all of the lane based PMA registers
    for rng_key in proj_params.adr_blk_dict:
        my_max_lanes = 0
        if 'replicate' in rng_key:
            if rng_key['replicate']:
                my_max_lanes = max_lanes
        else:
            if rng_key.find("cmn") == -1 :
                my_max_lanes = max_lanes

        print("RNG KEY: "+rng_key+"  MAX LANES: "+str(my_max_lanes))
        complete_reg_list += replicate_registers(rng_key, proj_params.adr_blk_dict, reg_list, my_max_lanes)

    complete_reg_list = sorted(complete_reg_list, key=lambda cdb_reg:cdb_reg.address)
    return complete_reg_list


def replicate_registers(rng_key, adr_blk_dict, reg_list, max_lanes=1):

    base = adr_blk_dict[rng_key]['base']
    rng = adr_blk_dict[rng_key]['rng']
    if 'rep_offset' in adr_blk_dict[rng_key]:
        iter_offset = adr_blk_dict[rng_key]['rep_offset']
    else:
        iter_offset = adr_blk_dict[rng_key]['rng']
    ipxact_reg_list = [reg for reg in reg_list if (int(reg.address) >= base) and (int(reg.address) <= (base+rng))]

    done = False
    ln_num = '_ln0'
    iter = 0

    my_reg_list = []

    if len(ipxact_reg_list):
        while not done:
            for reg in ipxact_reg_list:
                my_reg = copy.deepcopy(reg)
                #Only change names for items that are "lane" based
                if max_lanes > 1:
                    new_mnemonic = my_reg.mnemonic+ln_num
                    my_reg.address  = my_reg.address+iter*iter_offset
                    for field in my_reg.fields:
                        field.name = field.name.replace(my_reg.mnemonic, new_mnemonic)
                    my_reg.mnemonic = new_mnemonic 
                my_reg_list.append(my_reg)
            iter += 1
            ln_num = '_ln'+str(iter)
            done = iter >= max_lanes
    return my_reg_list
