class cdb_reg(object):
    """Generic Register Class
       mnemnonic - Register Mnemonic referenced by Software
       name - Name of the register - description
       address - base address of the register
       fields - list of fields
    """
    def __init__(self, name, reg_width, mnemonic, address, addr_offset):
        self.name = name
        self.mnemonic = mnemonic
        self.address = address
        self.fields = []
        self.reset_value = 0x0
        self.reset_mask = 0x0
        self.update_mask = 0x0
        self.compare_mask = 0x0
        self.error = False
        self.reg_width = reg_width

        if reg_width == 32:
            self.address    *= addr_offset
            self.last_bit    = 32
            self.random_mask = 0xffffffff
        else:
            self.last_bit = 16
            self.random_mask = 0xffff

    def print_reg(self):
        print(self.mnemonic)
        print(self.name)
        print(self.address)
        for field in self.fields:
            print(field.name)

    def convert_to_byte_addressing(self):
        self.address    *= 4
        self.last_bit    = 32
        self.random_mask = 0xffffffff

        byte_field = cdb_field(self.mnemonic+'_31_16', 'read-only', '31', '16', 0x0, 'Reserved')
        self.add_field0(byte_field, {})


    def set_address(self, address):
        self.address = address

    def set_mnenonic(self, mnemonic):
        tmp_mnemonic  = mnemonic.replace(' ', '')
        self.mnemonic = tmp_mnemonic

    def invertd(x) :
        v = ~int(x,16) & 0xffff
        return hex(v)

    def update_reg_masks(self, new_field):
        """ Update the register's mask functions when a new field is added """
        if new_field.access_type in ["RW", "R/W", "RO", "R/O"]:
            self.compare_mask = self.process_mask(self.compare_mask, new_field.end_bit, new_field.start_bit)
        if new_field.access_type in ["RW", "R/W", "WO", "W/O"]:
            self.update_mask = self.process_mask(self.update_mask, new_field.end_bit, new_field.start_bit)
        self.reset_mask = self.process_mask(self.reset_mask, new_field.end_bit, new_field.start_bit)

    def update_reset_value(self, new_field, override_dict):
        """ Update the register's reset_value when a new field is added """
        if self.mnemonic in override_dict :
            self.reset_value = override_dict[self.mnemonic]
        elif self.reset_value != "0xXXXX":
            if new_field.reset_value == "0xXXXX":
                self.reset_value = "0xXXXX"
            else:
                self.reset_value |= int(new_field.reset_value) << int(new_field.start_bit)

    def update_access_type(self, new_field):
        """ Covert from non-ipxact access type to ipxact access type """
        if new_field.access_type in ["RO", "R/O", "read-only"]:
            access_type = "read-only"
        elif new_field.access_type in ["RW", "R/W", "read-write"]:
            access_type = "read-write"
        elif new_field.access_type in ["WO", "W/O", "write-only"]:
            access_type = "write-only"
        elif new_field.access_type in ["W", "W", "write-only"]:
            access_type = "write-only"
        elif new_field.access_type in ["WC", "W/C", "write-clear"]:
            access_type = "write-clear"
        elif new_field.access_type in ["RC", "R/C", "read-clear"]:
            access_type = "read-clear"
        elif new_field.access_type in ["WRC", "WR/C", "write-read-clear"]:
            access_type = "write-read-clear"
        elif new_field.access_type in ["W1C", "W1/C", "write1-clear"]:
            access_type = "write1-clear"
        elif new_field.access_type in ["RW1C", "R/W1C", "read-write1-clear"]:
            access_type = "read-write1-clear"
        elif new_field.access_type in ["WS", "W/S", "write-set"]:
            access_type = "write-set"
        elif new_field.access_type in ["W1S", "W1/S", "write1-set", "RW1S", "R/W1S"]:
            access_type = "write1-set"
        elif new_field.access_type in ["RW1S", "RW1/S", "write1-set"]:
            access_type = "write1-set"
        else:
            print(self.mnemonic+" has an unsupported access type :: "+new_field.access_type)
            exit(1)
        return access_type


    def add_field(self, new_field, override_dict):
        """ Add the field to the register and modify the """
        #TEMP FIX for 32bit and only 16 bits specified
        #if (self.last_bit == self.reg_width) and (int(new_field.end_bit)+1 == 16):
        #   self.last_bit = 16
        #   byte_field = cdb_field(self.mnemonic+'_31_16', 'read-only', '31', '16', 0x0, 'Reserved')
        #   self.fields.append(byte_field)
           
        self.update_reg_masks(new_field)
        self.update_reset_value(new_field, override_dict)
        new_field.access_type = self.update_access_type(new_field)
        self.fields.append(new_field)

        # Check to make sure that the end_bit is the last bit specified for the register
        if (int(new_field.end_bit)+1) != self.last_bit:
            print("*E :: "+self.mnemonic+" has incorrectly specified bit-range")
            print("*E :: "+self.mnemonic+" Last Bit Specified : "+str(self.last_bit))
            for fld in self.fields:
                print("*E :: "+fld.name+" End   Bit Specified : "+str(fld.end_bit))
                print("*E :: "+fld.name+" Start Bit Specified : "+str(fld.start_bit))
            self.print_reg()
            self.last_bit = int(new_field.start_bit)
            self.error = True
            exit(-1)
        else:
            self.last_bit = int(new_field.start_bit)


    def add_field0(self, new_field, override_dict):
        """ Add the field to the register and modify the """
        self.update_reg_masks(new_field)
        self.update_reset_value(new_field, override_dict)
        new_field.access_type = self.update_access_type(new_field)
        self.fields.insert(0, new_field)

        # Check to make sure that the end_bit is the last bit specified for the register
        if (int(new_field.end_bit)+1) != self.last_bit:
            print("*E :: "+self.mnemonic+" has incorrectly specified bit-range")
            print("*E :: "+self.mnemonic+" Last Bit Specified : "+str(self.last_bit))
            for fld in self.fields:
                print("*E :: "+fld.name+" End   Bit Specified : "+str(fld.end_bit))
                print("*E :: "+fld.name+" Start Bit Specified : "+str(fld.start_bit))
            self.last_bit = int(new_field.start_bit)
            self.error = True
        else:
            self.last_bit = int(new_field.start_bit)

    def process_mask(self, mask, end_bit, start_bit):
        """ Generic function to update the mask when """
        new_mask = mask
        bit = int(start_bit)
        end_bit_p_1 = int(end_bit) + 1
        for shift in range(end_bit_p_1-bit):
            new_mask |= (1 << bit)
            bit += 1
        return new_mask

    def get_compare_mask(self):
        """ Returns the STRING version of the compare mask"""
        return str(self.compare_mask)

    def get_update_mask(self):
        """ Returns the STRING version of the update mask """
        return str(self.update_mask)

    def get_random_mask(self):
        """ Returns the STRING version of the random mask """
        return str(self.invertd(self.compare_mask | self.random_mask))


    def filter_fields(self, filter_char):
        """ Iterate through """
        need_reset_update = False
        for field in self.fields:
            update_reset = field.filter(filter_char)
            if update_reset:
                need_reset_update = True
        if need_reset_update:
            self.reset_value = 0x0
            for field in self.fields:
                self.update_reset_value(field, {})
        

class cdb_field(object):
    """Generic Field Class
    name - field mnemonic
    access_type - RW, RO, WO
    end_bit - upper bit of the field bit vector
    start_bit - lower bit of the field bit vector
    value - current value of the field (generally the reset value)
    """
    def __init__(self, name, access, end, start, rst_val, description):
        self.name = name
        self.access_type = access
        self.end_bit = end
        self.start_bit = start
        self.reset_value = rst_val
        self.description = description
        self.width = int(end) - int(start) + 1

    def filter(self, filter_char):
        """Filter the Field if the (filter_char) is in the description of the field.  If it is then:
        reset value == 0
        access_type == read-only
        description == RESERVED"""
        was_filtered = False
        if self.description.find('('+filter_char+')') != -1:
            self.access_type = 'read-only'
            self.description = 'Reserved'
            self.reset_value = 0x0000
            was_filtered = True
        return was_filtered
