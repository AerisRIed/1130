class cdn_u4_usb32_config extends cdn_phy_config_base;
    //---------------------------------------
    // Member
    gen_speed_t  usb32_gen_speed;
    lane_num_t   usb32_lane_num;
    bit big_endian;
    bit SerdesArch = 0;
    int skp_insert_num_gen1 = 354;
    int skp_insert_period_gen2 = 42;
    int block_rst_num = 4;
    real usb32_pclk;
    `ifdef ALT_MODE
    bit lane1_disable;
    `else
    bit lane1_disable = 1;
    `endif
    int lane_num;
    bit disable_sramble;
    bit loopback_enable ;
    bit flip ;
    //---------------------------------------
    // Factory
    //---------------------------------------
    `uvm_object_param_utils_begin(cdn_u4_usb32_config)
    `uvm_object_utils_end

    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "cdn_u4_usb32_config");
      super.new(name);
      if(lane_num == 1) lane1_disable = 1;
      // get standard mode
    endfunction : new
endclass 
