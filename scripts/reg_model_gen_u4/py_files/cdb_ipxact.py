class cdb_ipxact(object):
    """Container Class for IPXACT Creation"""

    def __init__(self, ofile, v2=False, post_pend=''):
        self.use_v2 = True
        self.post_pend = post_pend 
        self.ofile  = ofile
        self.tab = "    "
        self.tab2 = self.tab+self.tab
        self.tab3 = self.tab+self.tab2
        self.tab4 = self.tab+self.tab3
        self.tab5 = self.tab+self.tab4
        self.tab6 = self.tab+self.tab5
        self.base_address = 0x0
        
    def write(self, text):
        self.ofile.write(text+"\n")

#    def open_component_v1(self, library, name):
#        self.write("<?xml version=\"1.0\"?>")
#        self.write("<spirit:component xmlns:spirit=\"http://www.spiritconsortium.org/XMLSchema/SPIRIT/1685-2009\"")
#        self.write("    xmlns:vendorExtensions=\"$VR_AD/utils/ipxact/schema\"")
#        self.write("    xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"")
#        self.write("    xsi:schemaLocation=\"$VR_AD/utils/ipxact/schema")
#        self.write("    $VR_AD/utils/ipxact/schema/vrad_VendorExtensions.xsd")
#        self.write("    http://www.spiritconsortium.org/XMLSchema/SPIRIT/1685-2009")
#        self.write("    http://www.spiritconsortium.org/XMLSchema/SPIRIT/1685-2009/index.xsd\">")
#        self.write(self.tab+"<!-- REQUIRED HEADER INFO - DOES NOT END UP IN ANY GENERATED SV FILES -->")
#        self.write(self.tab+"<spirit:vendor>Cadence_Design_Systems</spirit:vendor>")
#        self.write(self.tab+"<spirit:library>"+library+"</spirit:library>")
#        self.write(self.tab+"<spirit:name>"+name+"</spirit:name>")
#        self.write(self.tab+"<spirit:version>1685-2009</spirit:version>")
#        self.write(self.tab+"<!-- START OF REGISTER MODEL DEFINITION -->")
#        self.write(self.tab+"<spirit:memoryMaps>")

    def open_component_v2(self, library, name):
        self.write("<?xml version=\"1.0\"?>")
        self.write('<spirit:component xmlns:spirit="http://www.spiritconsortium.org/XMLSchema/SPIRIT/1685-2009"')
        self.write('                  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"')
        self.write('                  xmlns:cadence="http://www.cadence.com/SPIRIT/1685-2009/vendorExtensions"')
        self.write('                  xsi:schemaLocation="http://www.cadence.com/SPIRIT/1685-2009/vendorExtensions') 
        self.write('                                      http://www.cadence.com/SPIRIT/1685-2009/vendorExtensions/cadenceSpiritVendorExtensions.xsd')
        self.write('                                      http://www.spiritconsortium.org/XMLSchema/SPIRIT/1685-2009') 
        self.write('                                      http://www.accellera.org/images/xmlschema/spirit/1685-2009/index.xsd">')
        self.write(self.tab+"<!-- REQUIRED HEADER INFO - DOES NOT END UP IN ANY GENERATED SV FILES -->")
        self.write(self.tab+"<spirit:vendor>cadence</spirit:vendor>")
        self.write(self.tab+"<spirit:library>"+library+"</spirit:library>")
        self.write(self.tab+"<spirit:name>"+name+"</spirit:name>")
        self.write(self.tab+"<spirit:version>1685-2009</spirit:version>")
        self.write(self.tab+"<!-- START OF REGISTER MODEL DEFINITION -->")
        self.write(self.tab+"<spirit:memoryMaps>")

    def open_component(self, library, name):
        #if self.use_v2:
        self.open_component_v2(library, name)
        #else:
        #    self.open_component_v1(library, name)

    def close_component(self):
        self.write(self.tab+"</spirit:memoryMaps>")
        self.write("</spirit:component>")

    def open_memory_map(self, name):
        self.write(self.tab2+"<spirit:memoryMap>")
        self.write(self.tab2+"<spirit:name>"+name+"</spirit:name>")

    def close_memory_map(self, address_width=16):
        self.write(self.tab3+"<spirit:addressUnitBits>"+address_width+"</spirit:addressUnitBits>")
        self.write(self.tab2+"</spirit:memoryMap>")

    def open_address_block(self, name, base_address, adr_range, offset, width=16):
        self.write(self.tab2+"<spirit:addressBlock>")
        self.write(self.tab3+"<!-- REGISTER FILE -->")
        self.write(self.tab3+"<spirit:name>"+name+"</spirit:name>")
        self.write(self.tab3+"<spirit:baseAddress>"+hex(base_address+offset)+"</spirit:baseAddress>")
        self.write(self.tab3+"<spirit:range>"+hex(adr_range)+"</spirit:range>")
        self.write(self.tab3+"<spirit:width>"+str(width)+"</spirit:width>")
        self.base_address = base_address

    def close_address_block(self):
        self.write(self.tab2+"</spirit:addressBlock>")

    def write_field(self, field):
        description = field.description.replace('(&)', '')
        self.write(self.tab4+"<spirit:field>")
        self.write(self.tab5+"<spirit:name>"+field.name+"</spirit:name>")
        self.write(self.tab5+"<spirit:description>"+description+"</spirit:description>")
        self.write(self.tab5+"<spirit:bitOffset>"+field.start_bit+"</spirit:bitOffset>")
        self.write(self.tab5+"<spirit:bitWidth>"+str(field.width)+"</spirit:bitWidth>")
        if field.access_type == 'write-read-clear':
            self.write(self.tab5+"<spirit:access>read-write</spirit:access>")
            self.write(self.tab5+"<spirit:readAction>clear</spirit:readAction>")
            self.write(self.tab5+"<spirit:vendorExtensions>")
            self.write(self.tab6+"<vendorExtensions:access_policy>RC</vendorExtensions:access_policy>")
            self.write(self.tab5+"</spirit:vendorExtensions>")
        if field.access_type == 'write-set':
            self.write(self.tab5+"<spirit:access>write-only</spirit:access>")
            self.write(self.tab5+"<spirit:modifiedWriteValue>set</spirit:modifiedWriteValue>")
            self.write(self.tab5+"<spirit:vendorExtensions>")
            self.write(self.tab6+"<vendorExtensions:access_policy>WS</vendorExtensions:access_policy>")
            self.write(self.tab5+"</spirit:vendorExtensions>")
        if field.access_type == 'read-write-clear':
            self.write(self.tab5+"<spirit:access>read-write</spirit:access>")
            self.write(self.tab5+"<spirit:modifiedWriteValue>oneToClear</spirit:modifiedWriteValue>")
            self.write(self.tab5+"<spirit:vendorExtensions>")
            self.write(self.tab6+"<vendorExtensions:access_policy>RWCLR</vendorExtensions:access_policy>")
            self.write(self.tab5+"</spirit:vendorExtensions>")
        if field.access_type == 'write-clear':
            self.write(self.tab5+"<spirit:access>write-only</spirit:access>")
            self.write(self.tab5+"<spirit:modifiedWriteValue>clear</spirit:modifiedWriteValue>")
            self.write(self.tab5+"<spirit:vendorExtensions>")
            self.write(self.tab6+"<vendorExtensions:access_policy>WC</vendorExtensions:access_policy>")
            self.write(self.tab5+"</spirit:vendorExtensions>")
        elif field.access_type != 'read-clear':
            if field.access_type == 'read-only':	
                if field.name.count("iso_ctrl_reg") > 0 :		
                	self.write(self.tab5+"<spirit:volatile>true</spirit:volatile>")
                if field.name.count("phy_pma_sec_override") > 0 :		
                	self.write(self.tab5+"<spirit:volatile>true</spirit:volatile>")
            self.write(self.tab5+"<spirit:access>"+field.access_type+"</spirit:access>")
        else:
            self.write(self.tab5+"<spirit:access>read-only</spirit:access>")
            self.write(self.tab5+"<spirit:readAction>clear</spirit:readAction>")
            self.write(self.tab5+"<spirit:vendorExtensions>")
            self.write(self.tab6+"<vendorExtensions:access_policy>RC</vendorExtensions:access_policy>")
            self.write(self.tab5+"</spirit:vendorExtensions>")
        self.write(self.tab4+"</spirit:field>")


    def write_field_cov_ext(self, field):
        self.write(self.tab4+"<!-- FIELD VENDOR EXTENSIONS -->")
        self.write(self.tab4+"<spirit:vendorExtensions>")
        self.write(self.tab5+"<cadence:extensions>")
        if field.access_type == 'read-only':
            self.write(self.tab6+'<cadence:collectCoverage cadence:accessMode="READ"/>')
        elif field.access_type == 'read-clear':
            self.write(self.tab6+'<cadence:collectCoverage cadence:accessMode="READ"/>')
        self.write(self.tab5+"</cadence:extensions>")
        self.write(self.tab4+"</spirit:vendorExtensions>")

    def write_field_v2(self, field):
        description = field.description.replace("(&)", "")
        self.write(self.tab4+"<spirit:field>")
        self.write(self.tab5+"<spirit:name>"+field.name+"</spirit:name>")
        self.write(self.tab5+"<spirit:description>"+description+"</spirit:description>")
        self.write(self.tab5+"<spirit:bitOffset>"+field.start_bit+"</spirit:bitOffset>")
        self.write(self.tab5+"<spirit:bitWidth>"+str(field.width)+"</spirit:bitWidth>")
        # RW1C
        if field.access_type == 'read-write1-clear':
            self.write(self.tab5+"<spirit:volatile>true</spirit:volatile>")
            self.write(self.tab5+"<spirit:access>read-write</spirit:access>")
            self.write(self.tab5+"<spirit:modifiedWriteValue>oneToClear</spirit:modifiedWriteValue>")
        # W1S
        elif field.access_type == 'write1-set':
            self.write(self.tab5+"<spirit:access>read-write</spirit:access>")
            self.write(self.tab5+"<spirit:modifiedWriteValue>oneToSet</spirit:modifiedWriteValue>")
        # W1C
        elif field.access_type == 'write1-clear':
            self.write(self.tab5+"<spirit:access>read-write</spirit:access>")
            self.write(self.tab5+"<spirit:modifiedWriteValue>oneToClear</spirit:modifiedWriteValue>")
        # WRC    
        elif field.access_type == 'write-read-clear':
            self.write(self.tab5+"<spirit:access>read-write</spirit:access>")
            self.write(self.tab5+"<spirit:readAction>clear</spirit:readAction>")
        elif field.access_type != 'read-clear':
            if field.access_type == 'read-only':
                if field.name.count("iso_ctrl_reg") > 0 :	
                	self.write(self.tab5+"<spirit:volatile>true</spirit:volatile>")
                if field.name.count("phy_pma_sec_override") > 0 :	
                	self.write(self.tab5+"<spirit:volatile>true</spirit:volatile>")
            self.write(self.tab5+"<spirit:access>"+field.access_type+"</spirit:access>")
        else:
            self.write(self.tab5+"<spirit:access>read-only</spirit:access>")
            self.write(self.tab5+"<spirit:readAction>clear</spirit:readAction>")
        #FIXMEself.write_field_cov_ext(field)
        self.write(self.tab4+"</spirit:field>")

    def write_vendor_extensions(self, register):
        self.write(self.tab4+"<!-- REGISTER VENDOR EXTENSIONS -->")
        self.write(self.tab4+"<spirit:vendorExtensions>")
        self.write(self.tab5+"<vendorExtensions:collect_coverage>cov</vendorExtensions:collect_coverage>")
        self.write(self.tab4+"</spirit:vendorExtensions>")

    def write_register_hdr(self, register, width=16):
        base_address = self.base_address
        reset_str    = "%x" % register.reset_mask
        name         = register.name.replace('(&)', '')
        self.write(self.tab3+"<!-- "+name+" -->")
        self.write(self.tab3+"<spirit:register>")
        self.write(self.tab4+"<spirit:name>"+register.mnemonic+self.post_pend+"</spirit:name>")
        self.write(self.tab4+"<spirit:description>"+name+"</spirit:description>")
        self.write(self.tab4+"<spirit:addressOffset>"+hex(register.address-base_address)+"</spirit:addressOffset>")
        self.write(self.tab4+"<spirit:size>"+str(width)+"</spirit:size>")
        self.write(self.tab4+"<spirit:access>read-write</spirit:access>")
        self.write(self.tab4+"<spirit:reset>")
        if register.reset_value == "0xXXXX":
            self.write(self.tab5+"<spirit:value>"+register.reset_value+"</spirit:value>")
        else:
            # remove L for long types
            rst_val = hex(register.reset_value).replace('L','')
            self.write(self.tab5+"<spirit:value>"+rst_val+"</spirit:value>")
        self.write(self.tab5+"<spirit:mask>0x"+reset_str+"</spirit:mask>")
        self.write(self.tab4+"</spirit:reset>")
        self.write(self.tab4+"<!-- FIELDS -->")

    def write_register_tail(self, register, width=16):
        self.write(self.tab3+"</spirit:register>")

    def write_register(self, register, width=16):
        base_address = self.base_address
        self.write_register_hdr(register, width)
        for fld in register.fields:
            if self.use_v2:
                self.write_field_v2(fld)
            else:
                self.write_field(fld)
        if not self.use_v2:
            #FIXMEself.write_vendor_extensions(register)
            pass
        self.write_register_tail(register, width)
