class active_slave_usb4_tc_noc_pam3_sub_sys_config extends cdnApbUvmConfig;

   `uvm_object_utils(active_slave_usb4_tc_noc_pam3_sub_sys_config)

   function new(string name = "active_slave_usb4_tc_noc_pam3_sub_sys_config");
      super.new(name);
   endfunction : new

   virtual function void setFieldsValues();
      set_use_apb_amba4_extension(1);
      set_number_of_slaves(1);
      set_DeviceType(CDN_APB_CFG_SLAVE);
      set_idle_mode_optimization(CDN_APB_CFG_IDLE_MODE_OPTIMIZATION_OPTIMIZED_CB);
      set_is_active(UVM_ACTIVE);
      set_use_apb_ver_d_extension(1);

   endfunction: setFieldsValues

endclass : active_slave_usb4_tc_noc_pam3_sub_sys_config
