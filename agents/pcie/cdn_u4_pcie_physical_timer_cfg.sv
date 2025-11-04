class cdn_u4_pcie_physical_timer_cfg extends uvm_object;
    //---------------------------------------
	time t_Rxdetect_Wait_Max = 30us;
    // Member
    time t_Period = $urandom_range(20ns,100ns);
    time t_PeriodSSP = $urandom_range(20ns,80ns);
    int t_LFPS_Duty_cycle = $urandom_range(10,30);
    time t_Burst_Polling = $urandom_range(0.6us,1.4us);
    time t_Repeat_Polling = $urandom_range(6us,14us);
    //---------------------------------------
    // Factory
    //---------------------------------------
    `uvm_object_param_utils_begin(cdn_u4_pcie_physical_timer_cfg)
    `uvm_object_utils_end

    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "cdn_u4_pcie_physical_timer_cfg");
      super.new(name);
    endfunction : new
endclass 
