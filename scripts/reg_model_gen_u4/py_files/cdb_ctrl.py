class cdb_ctrl(object):
    """Class that describes the registers/overrides 
       reg_width  - number of bits wide the register is 
       addr_wdith - number of bits wide the register address is 
       addr_map_dict - dictionary 
    """
    def __init__(self, reg_width, addr_width, addr_map_dict, addr_offset):
        self.reg_width     = reg_width
        self.addr_width    = addr_width
        self.addr_map_dict = addr_map_dict
        self.addr_offset   = addr_offset
