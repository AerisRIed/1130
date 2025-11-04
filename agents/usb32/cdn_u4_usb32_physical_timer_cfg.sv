class cdn_u4_usb32_physical_timer_cfg extends uvm_object;
    //---------------------------------------
    // Member
    int speed_up_ratio;
    time t_Period              = $urandom_range(20ns,100ns);
    time t_PeriodSSP           = $urandom_range(20ns,80ns);
    int t_LFPS_Duty_cycle      = $urandom_range(40,40);
    time t_Burst_Polling       = $urandom_range(0.6us,1.4us);
    time t_Repeat_Polling      = $urandom_range(6us,14us);
    time decode_latency        = $urandom_range(6us,14us);
    
    time T_u1_exit_t11_t10_min = 0.3us;
    time T_u1_exit_t12_t11_min = 0.6us;
    time T_u1_exit_t13_t11_min = 0.9us;
    time T_u1_exit_t11_t10_max = 2us;
    time T_u1_exit_t12_t11_max = 2us;
    time T_u1_exit_t13_t11_max = 1.2us;
    time T_u1_exit_t11_t10 = $urandom_range(T_u1_exit_t11_t10_min,T_u1_exit_t11_t10_max);
    time T_u1_exit_t12_t11 = $urandom_range(T_u1_exit_t12_t11_min,T_u1_exit_t12_t11_max);
    time T_u1_exit_t13_t11 = $urandom_range(T_u1_exit_t13_t11_min,T_u1_exit_t13_t11_max);
    
    time T_u2_exit_t11_t10_min = 0.3us;
    time T_u2_exit_t12_t11_min = 0.6us;
    time T_u2_exit_t13_t11_min = 80us;
    time T_u2_exit_t11_t10_max = 2ms/10;
    time T_u2_exit_t12_t11_max = 2ms/10;
    time T_u2_exit_t13_t11_max = 2ms/10;
    time T_u2_exit_t11_t10 = $urandom_range(T_u2_exit_t11_t10_min,T_u2_exit_t11_t10_max);
    time T_u2_exit_t12_t11 = $urandom_range(T_u2_exit_t12_t11_min,T_u2_exit_t12_t11_max);
    time T_u2_exit_t13_t11 = $urandom_range(T_u2_exit_t13_t11_min,T_u2_exit_t13_t11_max);
    
    time T_u3_exit_t11_t10_min = 0.3us;
    time T_u3_exit_t12_t11_min = 0.6us;
    time T_u3_exit_t13_t11_min = 80us;
    time T_u3_exit_t11_t10_max = 10ms/50;
    time T_u3_exit_t12_t11_max = 10ms/50;
    time T_u3_exit_t13_t11_max = 10ms/50;
    time T_u3_exit_t11_t10 = $urandom_range(T_u3_exit_t11_t10_min,T_u3_exit_t11_t10_max);
    time T_u3_exit_t12_t11 = $urandom_range(T_u3_exit_t12_t11_min,T_u3_exit_t12_t11_max);
    time T_u3_exit_t13_t11 = $urandom_range(T_u3_exit_t13_t11_min,T_u3_exit_t13_t11_max);
    //---------------------------------------
    // Factory
    //---------------------------------------
    `uvm_object_param_utils_begin(cdn_u4_usb32_physical_timer_cfg)
    `uvm_object_utils_end

    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "cdn_u4_usb32_physical_timer_cfg");
      super.new(name);
    endfunction : new
endclass 
