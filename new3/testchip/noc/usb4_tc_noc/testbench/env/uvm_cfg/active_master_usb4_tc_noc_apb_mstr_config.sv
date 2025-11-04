class active_master_usb4_tc_noc_apb_mstr_config extends cdnApbUvmConfig;

   `uvm_object_utils(active_master_usb4_tc_noc_apb_mstr_config)

   function new(string name = "active_master_usb4_tc_noc_apb_mstr_config");
      super.new(name);
   endfunction : new

   virtual function void setFieldsValues();
      set_use_apb_amba4_extension(1);
      set_number_of_slaves(1);
      set_idle_mode_optimization(CDN_APB_CFG_IDLE_MODE_OPTIMIZATION_OPTIMIZED_CB);
      set_is_active(UVM_ACTIVE);
      set_DeviceType(CDN_APB_CFG_MASTER);
      set_use_apb_ver_d_extension(1);

   endfunction: setFieldsValues

endclass : active_master_usb4_tc_noc_apb_mstr_config
