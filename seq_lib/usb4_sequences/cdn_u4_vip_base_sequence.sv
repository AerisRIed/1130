class cdn_u4_vip_base_sequence extends cdnUsb4UvmUserVirtualSequenceBase;

  cdnUsb4UvmPcieMwrMrdSeq pcieSeq ;
  cdnUsb4UvmUsbEnumerateSeq usbSeq ;
  cdnUsb4UvmUserDpBasicSeq dpSeq ;
  int devNullPortNum = 0 ;
  int hostNullPortNum = 0 ;
  int psvNullPortNum = 0 ;
  int devDpAdpPortNum = 0;
  int hostDpAdpPortNum = 0;
  integer bypassPairing = 1;
  integer bypassCMHandshake = 1;
  bit enableSideband = 0;
  

  // ***************************************************************
  // UVM registration macros
  // ***************************************************************
  `uvm_object_utils_begin(cdn_u4_vip_base_sequence)
    `uvm_field_object(pcieSeq, UVM_ALL_ON)
    `uvm_field_object(usbSeq, UVM_ALL_ON)
    `uvm_field_object(dpSeq, UVM_ALL_ON)
  `uvm_object_utils_end
  `uvm_declare_p_sequencer(cdnUsb4UvmUserVirtualSequencer)

  // ***************************************************************
  // Method : new
  // Desc.  : Call the constructor of the parent class and set all
  //          the required overrides
  // ***************************************************************
  function new(string name = "cdn_u4_vip_base_sequence");
    super.new(name);
  endfunction : new

  // ***************************************************************
  // Method : pre_start
  // Desc.  : Set seq vars before body()
  // ***************************************************************
  virtual task pre_start();
    super.pre_start() ;
    devDpAdpPortNum = usb4Dev._internal_dpOutAdpPortNums[0] ;
    hostDpAdpPortNum = usb4Host._internal_dpInAdpPortNums[0] ;
    usb4Host.setDpAdapterCtrlReg(hostDpAdpPortNum, bypassPairing, bypassCMHandshake);
    usb4Dev.setDpAdapterCtrlReg(devDpAdpPortNum, bypassPairing, bypassCMHandshake);
    usb4Psv.setDpAdapterCtrlReg(enableDevDut ? devDpAdpPortNum : hostDpAdpPortNum, bypassPairing, bypassCMHandshake);
  endtask : pre_start

  // ***************************************************************
  // Method : body
  // Desc.  : procedural code for the sequence implementation
  // ***************************************************************
  virtual task body();
  bit isGen4 = usb4Psv.isGen4;

   // `ifdef CDN_USB4_PIPEPHY_EN
  `ifdef CDN_USB4_UVM_CONFIG 
    if (uvm_config_db#(bit)::exists(null, "*", "enableSideband")) void'(uvm_config_db#(bit)::get(null, "*", "enableSideband", enableSideband));
  `else
    enableSideband = (!usb4Host.BypassSidebandLink && !usb4Dev.BypassSidebandLink);
  `endif
    uvm_top.set_timeout(enableSideband ? 350us : 200us) ; // Test timeout
    if (enableSideband) begin
      usb4Host.setSidebandFrequency(1000); 
      usb4Dev.setSidebandFrequency(1000); 
      usb4Psv.setSidebandFrequency(1000);
    end
  
    `ifdef CDN_USB4_PIPEPHY_EN
    if (usb4Host.phyMode)
       reset_assert_deassert();
    `endif

    usb4Dev.setVerbosity(DENALI_USB4_VERBOSITY_None, DENALI_USB4_MSG_OUTPUT_Both) ;
    usb4Host.setVerbosity(DENALI_USB4_VERBOSITY_None, DENALI_USB4_MSG_OUTPUT_Both) ;
    
    devNullPortNum = usb4Dev.getStartingPortNum(denaliUsb4PortTypeT'(DENALI_USB4_PORT_TYPE_USB4)) ;
    hostNullPortNum = usb4Host.getStartingPortNum(denaliUsb4PortTypeT'(DENALI_USB4_PORT_TYPE_USB4)) ;
    psvNullPortNum = usb4Psv.getStartingPortNum(denaliUsb4PortTypeT'(DENALI_USB4_PORT_TYPE_USB4)) ;
    `uvm_info(get_type_name(), "## Multi-Protocol end to end Virtual seq starts ##", UVM_LOW);
    `uvm_info(get_type_name(), $sformatf("## Multi-Protocol Virtual seq - Sideband : %s ##", enableSideband ? "Enabled" : "Disabled"), UVM_LOW);
    fork
       begin
          fork
            begin
              `uvm_info(get_type_name(), $sformatf("## Port %0d Waiting for CL0 ##",psvNullPortNum), UVM_LOW);  
              `CDN_VIP_WAIT(enableSideband ? 300us : (isGen4 ? 10us : 2us), usb4Psv.waitForPortHsLaneFsmState(psvNullPortNum, DENALI_USB4_LL_HS_STATE_CL0)) ; 
              `uvm_info(get_type_name(), $sformatf("## Port %0d Reached CL0 ##",psvNullPortNum), UVM_LOW);  
            end
            begin
              `uvm_info(get_type_name(), $sformatf("## Port %0d Waiting for CL0 ##",psvNullPortNum+1), UVM_LOW);  
              `CDN_VIP_WAIT(enableSideband ? 300us : (isGen4 ? 10us : 2us), usb4Psv.waitForPortHsLaneFsmState(psvNullPortNum+1, DENALI_USB4_LL_HS_STATE_CL0)) ; 
              `uvm_info(get_type_name(), $sformatf("## Port %0d Reached CL0 ##",psvNullPortNum+1), UVM_LOW);  
            end
          join
        
          if (!isGen4) begin 
             `uvm_info(get_type_name(), $sformatf("# Setting the Lane Bonding Config for passive agent #"), UVM_LOW);  
             fork
             begin 
                `uvm_info(get_type_name(), $sformatf("## Port %0d Waiting for bonding ##",psvNullPortNum), UVM_LOW);
                `CDN_VIP_WAIT(2us, usb4Psv.waitForBonding(psvNullPortNum, 1));
             end
             begin
                `uvm_info(get_type_name(), $sformatf("## Port %0d Waiting for bonding ##",psvNullPortNum+1), UVM_LOW);
                `CDN_VIP_WAIT(2us, usb4Psv.waitForBonding(psvNullPortNum+1, 1));
              end
             join
          end
       end
       begin
         `uvm_do_on_with(nullPortTrainingSeq, usb4DevSeqr, { 
          portNum == devNullPortNum ;
          local::enableSideband == enableSideband;
         })
       end
       begin
         `uvm_do_on_with(nullPortTrainingSeq, usb4HostSeqr, { 
          portNum == hostNullPortNum ; 
          local::enableSideband == enableSideband;
         })
       end
    join

    `uvm_info(get_type_name(), "## Multi-Protocol seq finished USB4 NULL port training  ##", UVM_LOW);
    fork
      begin
        `uvm_do(dpSeq)
      end
      begin
        `uvm_do(usbSeq)
      end
      begin
        `uvm_do_with(pcieSeq, {waitFactor == 4 ; } )
      end
    join

    if (usb4Host.phyMode)
       gracefullTestEnd(); // wait for SBs to drain

  endtask : body

endclass
