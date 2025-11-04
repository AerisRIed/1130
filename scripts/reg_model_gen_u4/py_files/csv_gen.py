class csv_gen(object):
    """ Container Class for CDB CONST File Creation """

    def __init__(self, ofile):
        self.ofile = ofile
        self.tab = "    "
        self.tab2 = self.tab+self.tab
        self.tab3 = self.tab+self.tab2
        self.tab4 = self.tab+self.tab3
        self.tab5 = self.tab+self.tab4

    def write_header(self):
        self.write("# ADDRESS, RESET, MNEMONIC, ACCESS TYPE, NAME, OWNER")

    def write(self, text):
        self.ofile.write(text+"\n")

    def write_register(self, register, width=16):
        line  = "0x"+"{0:04x}".format(register.address)
        line += ", "
        line += "0x"+"{0:04x}".format(register.reset_value)
        line += ", "
        line += register.mnemonic.upper()
        line += ", RW, "
        line += register.name+", "
        self.write(line)
        for fld in register.fields:
            if fld.access_type in ["RO", "R/O", "read-only"]:
                access_type = "RO"
            elif fld.access_type in ["RW", "R/W", "read-write"]:
                access_type = "RW"
            elif fld.access_type in ["WO", "W/O", "write-only"]:
                access_type = "WO"
            elif fld.access_type in ["WC", "W/C", "write-only"]:
                access_type = "WC"
            elif fld.access_type in ["W", "W", "write-only"]:
                access_type = "WO"
            elif fld.access_type in ["RC", "R/C", "read-clear"]:
                access_type = "RC"

            line = ",,"+fld.name+", "+access_type+",,"
            self.write(line)
            
