class ecov_gen:
    def __init__(self):
        self.ofile = []
        self.sp2 = "  "
        self.sp3 = "   "
        self.tab = self.sp2
        self.tab2 = self.sp3+self.tab
        self.tab3 = self.sp3+self.tab2 


    def write(self, text):
        self.ofile.write(text+"\n")


    def write_register_cov_file(self, proj_params, reg_list):
       # Parse each PMA address block for registers
       for rng_key in proj_params.pma_adr_blk_dict:
           self.parse_registers(proj_params, proj_params.pma_adr_blk_dict,rng_key ,reg_list)
       # Parse each PHY address block for registers
       for rng_key in proj_params.adr_blk_dict:
           self.parse_registers(proj_params, proj_params.adr_blk_dict,rng_key ,reg_list) 


    def parse_registers(self, proj_params, adr_blk_dict, rng_key, reg_list ):
        # Get all registers contained in from that address block
        base = adr_blk_dict[rng_key]['base']
        rng = adr_blk_dict[rng_key]['rng']
        this_reg_list = [reg for reg in reg_list if (int(reg.address) >= base) and (int(reg.address) <= (base+rng))]
        # open file
        self.ofile = open(proj_params.dest_file+rng_key+'_coverage.e', 'w')
        # header
        self.write("<'")
        self.write('unit %s_%s_coverage like uvm_monitor {\n' %(proj_params.mem_library,rng_key))
        self.write('%s p_reg_file: %s vr_ad_reg_file;\n' %(self.tab, rng_key.upper()))
        self.write('%s event cov_reg_e;\n' %(self.tab))
        self.write('%s cover cov_reg_e is{\n' %(self.tab))
        # write all register for this address block
        for reg in this_reg_list:
           self.write_register(reg)
        # footer
        self.write('%s};' %(self.tab))
        self.write("};")
        self.write("'>")
        #close file
        self.ofile.close()


    def write_register(self, register):
        self.write('\n%s --' %(self.tab2))
        self.write('%s -- Coverage for %s, %s' %(self.tab2, register.mnemonic.upper(), register.name))
        self.write('%s --' %(self.tab2))        
        for fld in register.fields:
            if fld.width == 1:
                self.write('%s item %-40s : bit = p_reg_file.%s.%s;\n' %(self.tab2, fld.name, register.mnemonic, fld.name)) 
            else:
                self.write('%s item %-40s : uint(bits:%s) = p_reg_file.%s.%s using ranges={' %(self.tab2,fld.name,str(fld.width),register.mnemonic, fld.name ))
                min_val = "0"
                max_val = str(2**fld.width-1)
                mid_val_low = str(2**fld.width/2-1)
                mid_val_high = str(2**fld.width/2)
                self.write('%54s range([%s], "Min val", UNDEF, 1);'%("", min_val))
                self.write('%54s range([%s], "Max val", UNDEF, 1);'%("", max_val))
                self.write('%54s range([%s..%s], "Low vals", UNDEF, 4);'%("", min_val, mid_val_low))
                self.write('%54s range([%s..%s], "Hihg vals", UNDEF, 4);'%("", mid_val_high, max_val))
                self.write('%54s};\n'% (""))
