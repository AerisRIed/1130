class fschar_gen(object):
    """ Container Class for CDB CONST File Creation """

    def __init__(self, ofile):
        self.ofile = ofile
        self.tab = "    "
        self.tab2 = self.tab+self.tab
        self.tab3 = self.tab+self.tab2
        self.tab4 = self.tab+self.tab3
        self.tab5 = self.tab+self.tab4

    def write(self, text):
        self.ofile.write(text+"\n")

    def write_header(self):
        self.write("# ADDRESS, RESET, MNEMONIC, NAME")

    def write_line_0(self):
        line = "DEVICE NAME,PG REVISION,,Return to Summary,,,<end>"
        self.write(line)

    def write_line_1(self):
        line = "Torrent TC,PG1, , , , ,"
        self.write(line)

    def write_line_2(self):
        line = "Register Name,Register Address,Register bit,Description FastChar,Value,Default"
        self.write(line)

    def write_end_line(self):
        line = "<end>"
        self.write(line)

    def write_single_bit_field(self, line, field, register, default=""):
        field_name = register.mnemonic+"_"+field.end_bit+"_"+field.start_bit
        line += "<"+field.end_bit+">,"
        line += field_name+"_low,0,"+default
        self.write(line)
        new_line  = " , , ,"
        new_line += field_name+"_high,1,"
        self.write(new_line)

    def write_multi_bit_field(self, line, field, register, default=""):
        field_name = register.mnemonic+"_"+field.end_bit+"_"+field.start_bit
        tmp_value  = ""

        line += "<"+field.end_bit+":"+field.start_bit+">,"
        line += field_name+"<"+field.end_bit+":"+field.start_bit+">,"
        for i in range(field.width): 
            tmp_value += "0"

    def write_single_bit_field(self, line, field, register, default=""):
        field_name = register.mnemonic+"_"+field.end_bit
        line += "<"+field.end_bit+">,"
        line += field_name+"_low,0,"+default
        self.write(line)
        new_line  = " , , ,"
        new_line += field_name+"_high,1,"
        self.write(new_line)

    def write_multi_bit_field(self, line, field, register, default=""):
        field_name = register.mnemonic+"_"+field.end_bit+"_"+field.start_bit
        tmp_value  = ""

        line += "<"+field.end_bit+":"+field.start_bit+">,"
        line += field_name+","
        for i in range(field.width): 
            tmp_value += "0"
        line += tmp_value+","+default
        self.write(line)

    def write_register(self, register, width=16):
        myFields = register.fields
        default = "{0:016b}".format(register.reset_value)

        line  = register.mnemonic.upper()
        line += ","
        line += "{0:016b}".format(register.address)+","
        for field in myFields:
            if field.width != 1:
                self.write_multi_bit_field(line, field, register, default)
            else:
                self.write_single_bit_field(line, field, register, default)
            line    = " , ,"
            default = ""
