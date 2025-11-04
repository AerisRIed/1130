`ifndef CDN_JTAG_1687_DRIVER_SV
`define CDN_JTAG_1687_DRIVER_SV
class cdn_jtag_1687_driver extends uvm_driver#(cdn_jtag_1687_trans);

  `uvm_component_utils(cdn_jtag_1687_driver)

  //transaction
  cdn_jtag_1687_trans jtag_1687_trans;

//  cdn_jtag_config_base jtag_config;
 
  bit[JTAG_DATA_REG_SIZE-1:0] jtag_1687_out;
  string report_id = "CDN_JTAG_1687_DRIVER";

  virtual cdn_jtag_1687_interface jtag_1687_vif;

  function new(string name = "cdn_jtag_1687_driver",uvm_component parent);
   super.new(name,parent);
   `uvm_info(report_id,"Inside of class",UVM_DEBUG)
  endfunction:new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(report_id,$sformatf("Starting of _%s_",phase.get_name()),UVM_LOW)

     if(!uvm_config_db#(virtual cdn_jtag_1687_interface)::get(this, "", "jtag_1687_if", jtag_1687_vif))
      `uvm_fatal(report_id, $sformatf("Virtual interface jtag_1687_vif must be set for driver!"));

    `uvm_info(report_id,$sformatf("Ending of _%s_",phase.get_name()),UVM_LOW)
  endfunction:build_phase

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    initial_drive();
    `uvm_info(report_id,$sformatf("Starting of _%s_",phase.get_name()),UVM_LOW)
    forever begin
      seq_item_port.get_next_item(req);
      //`uvm_info(report_id,"Packet at driver level",UVM_LOW)
       req.print();
      //`uvm_info(report_id,$sformatf("Started driving UTMI transaction"),UVM_LOW)
      if (!$cast(jtag_1687_trans,req)) `uvm_fatal(report_id, "jtag_1687_trans failed to cast req!");
      drive_operation(jtag_1687_trans);
      void'($cast(rsp,req.clone()));
      rsp.set_id_info(req);
      if (jtag_1687_trans.op == READ_1687) rsp.data = jtag_1687_out;
      seq_item_port.item_done(rsp);//sending response back to sequence level
    end 
    `uvm_info(report_id,$sformatf("Ending of _%s_",phase.get_name()),UVM_LOW)
  endtask:run_phase

  virtual task initial_drive();
   

  endtask

  virtual task drive_operation(cdn_jtag_1687_trans trans);
    if (jtag_1687_vif.trst != 1)begin
      jtag_reset_idle();
      jtag_cfg_clk();
    end
    case (trans.op)
      WRITE_1687  : jtag_phy_reg_write(trans.addr, trans.data);
      READ_1687   : jtag_phy_reg_read(trans.addr, jtag_1687_out);
      default: begin `uvm_fatal(report_id, $sformatf("Unrecogized operation %p", trans.op)) end
    endcase
  endtask
 
  //------------------------------------------------------------------------
  // JTAG write regs 
  //------------------------------------------------------------------------

  task jtag_cfg_clk();
    jtag_write_ir(JTAG_CLK_CTRL_INSTR);
    jtag_write_dr_32('h3, JTAG_CLK_CTRL_SIZE); 
  endtask//jtag_cfg_clk

  task jtag_phy_reg_write(input bit[JTAG_ADDR_WIDTH-1:0] addr, input bit[JTAG_DATA_WIDTH-1:0] data);
  reg    [31:0] datareg;
     jtag_write_ir(JTAG_LOAD_ADDR_INSTR);
     jtag_write_dr_32(addr, JTAG_ADDR_REG_SIZE); 

     jtag_write_ir(JTAG_LOAD_DATA_INSTR);
     jtag_write_dr_32(data, JTAG_DATA_REG_SIZE);     

     jtag_write_ir(JTAG_RDWR_CTRL_INSTR);         
     jtag_write_dr_32(JTAG_WR_CTRL_START, JTAG_RDWR_CTRL_SIZE);

     jtag_write_ir(JTAG_RDWR_CTRL_INSTR);
     jtag_read_dr_32(datareg, JTAG_RDWR_CTRL_SIZE);
     // Wait for bus cycle bit to go high
     while (datareg[0] !== 1'b1)
     begin
       jtag_write_ir(JTAG_RDWR_CTRL_INSTR);
       jtag_read_dr_32(datareg, JTAG_RDWR_CTRL_SIZE);
     end

     jtag_write_ir(JTAG_RDWR_CTRL_INSTR);         
     jtag_write_dr_32(JTAG_WR_CTRL_STOP, JTAG_RDWR_CTRL_SIZE);

  endtask//jtag_phy_reg_write


  task jtag_phy_reg_read(input bit[JTAG_ADDR_WIDTH-1:0] addr, output bit[JTAG_DATA_WIDTH-1:0] data);
  reg    [31:0] datareg;
  begin 
      jtag_write_ir(JTAG_LOAD_ADDR_INSTR);
      jtag_write_dr_32(addr, JTAG_ADDR_REG_SIZE);

      jtag_write_ir(JTAG_RDWR_CTRL_INSTR);
      jtag_write_dr_32(JTAG_RD_CTRL_START, JTAG_RDWR_CTRL_SIZE);

      jtag_write_ir(JTAG_RDWR_CTRL_INSTR);
      jtag_read_dr_32(datareg, JTAG_RDWR_CTRL_SIZE);
      // Wait for bus cycle bit to go high
      while (datareg[0] !== 1'b1)
      begin
         jtag_write_ir(JTAG_RDWR_CTRL_INSTR);
         jtag_read_dr_32(datareg, JTAG_RDWR_CTRL_SIZE);
      end
      
      jtag_write_ir(JTAG_RD_DATA_INSTR);
      jtag_read_dr_32(data, JTAG_DATA_REG_SIZE);

      jtag_write_ir(JTAG_RDWR_CTRL_INSTR);         
      jtag_write_dr_32(JTAG_WR_CTRL_STOP, JTAG_RDWR_CTRL_SIZE);
  end
  endtask//jtag_phy_reg_read


  task jtag_write_ir (input [3:0]  ir_reg_addr);
  begin
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(0,0);
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(1,0);          // Select DR Scan
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(1,0);          // Select IR Scan
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(0,0);          // Capture IR
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(0,0);          // Shift IR
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(0,ir_reg_addr[0]);          // Shift IR
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(0,ir_reg_addr[1]);          // Shift IR
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(0,ir_reg_addr[2]);          // Shift IR
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(1,ir_reg_addr[3]);          // Exit IR
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(1,0);          // Update IR State
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(0,0);          // Back to IDLE State
  end
  endtask//jtag_write_ir


  task jtag_write_dr_32 (input [31:0]  dr_reg_addr, input [7:0] width);
  reg [4:0] databit;
  begin
     jtag_tms_tdi(0,0);
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(1,0);          // Select DR Scan
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(0,0);          // Capture DR Scan
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(0,0);          // Shift DR Scan
     for (databit = 0 ; databit < (width - 1)  ; databit = databit + 1 )
     begin
        @(negedge jtag_1687_vif.tck)
        jtag_tms_tdi(0,dr_reg_addr[databit]);       // Shift DR
     end
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(1,dr_reg_addr[(width - 1)]);          // Exit 1 DR State
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(1,0);          // Update DR State
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(0,0);          // Back to IDLE State
  end
  endtask//jtag_write_dr_32



  task jtag_read_dr_32 (output [31:0] dr_reg_data, input [7:0] width);
  reg [4:0] databit;
  begin
     jtag_tms_tdi(0,0);
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(1,0);          // Select DR Scan
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(0,0);          // Capture DR Scan
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(0,0);          // Shift DR Scan
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(0,0);          // Shift DR Scan
     for (databit = 0 ; databit < (width-1)  ; databit = databit + 1 )
     begin
        @(negedge jtag_1687_vif.tck)
        jtag_tms_tdi(0,jtag_1687_vif.tdo);       // Shift DR
        dr_reg_data[databit] = jtag_1687_vif.tdo;
     end
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(1,jtag_1687_vif.tdo);          // Exit 1 DR State
     dr_reg_data[(width - 1)] = jtag_1687_vif.tdo;
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(1,jtag_1687_vif.tdo);          // Update DR State
     @(negedge jtag_1687_vif.tck)
     jtag_tms_tdi(0,jtag_1687_vif.tdo);          // Back to IDLE State
  end
  endtask//jtag_read_dr_32


  task jtag_tms_tdi (input bit shiftdr, input bit capturedr);
        jtag_1687_vif.shiftdr = shiftdr;
        jtag_1687_vif.capturedr = capturedr;
  endtask //jtag_tms_tdi


  task jtag_reset_idle ();
    jtag_1687_vif.trst = 1'b1;
    repeat (8)
    begin
      @( negedge jtag_1687_vif.tck)
      jtag_tms_tdi(1, 0);
    end
  endtask //jtag_reset_idle

endclass:cdn_jtag_1687_driver

`endif
