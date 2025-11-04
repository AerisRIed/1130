class cdn_u4_usb4_config extends cdn_phy_config_base;
    //---------------------------------------
    // Member
    gen_speed_t  usb4_gen_speed;
    bit flip;
    bit fec_off =1;
    bit big_endian;
    bit SerdesArch = 1;
    int block_rst_num = 4;
    real usb4_pclk;
    bit disable_sramble;
    //---------------------------------------
    // Factory
    //---------------------------------------
    `uvm_object_param_utils_begin(cdn_u4_usb4_config)
    `uvm_object_utils_end

    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "cdn_u4_usb4_config");
      super.new(name);
      // get standard mode
    endfunction : new
endclass 
