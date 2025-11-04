//
// Template for UVM-compliant physical-level transactor
//

`ifndef CDN_U4_DP_DRIVER__SV
`define CDN_U4_DP_DRIVER__SV

//typedef class cdn_u4_dp_transaction;
typedef class cdn_u4_dp_driver;

class cdn_u4_dp_driver extends cdn_phy_driver_base # (cdn_u4_dp_transaction);

   //---------------------------------
   // Member config and interface
   //---------------------------------
   cdn_u4_dp_config  m_cfg;

   //---------------------------------
   // Member variables
   //---------------------------------
   bit               data_tran_done = 0;

   //`uvm_register_cb(cdn_u4_dp_driver,cdn_u4_dp_driver_callbacks); 

   //---------------------------------------
   // Factory 
   //---------------------------------------
   `uvm_component_param_utils_begin(cdn_u4_dp_driver)
   // ToDo: Add uvm driver member
   `uvm_component_utils_end
   // ToDo: Add required short hand override method

   //---------------------------------
   // UVM functions and tasks
   //---------------------------------
   extern function new(string name = "cdn_u4_dp_driver",
                       uvm_component parent = null); 
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void end_of_elaboration_phase(uvm_phase phase);
   extern virtual function void start_of_simulation_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern virtual task reset_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);

   //---------------------------------
   // User functions and tasks
   //---------------------------------
   //extern protected virtual task send(cdn_u4_dp_transaction tr); 
   //extern protected virtual task tx_driver();
   extern protected virtual task drive_link_data();
   extern protected virtual task drive_operation();
   extern protected virtual task send_data(cdn_u4_dp_transaction tr); 
   extern protected virtual task reset_data(); 
   extern protected virtual task power_state_change(bit [5:0] power_state); 
   extern protected virtual task pll_clk_en(); 

endclass: cdn_u4_dp_driver


function cdn_u4_dp_driver::new(string name = "cdn_u4_dp_driver", uvm_component parent = null);
   super.new(name, parent);
endfunction: new

function void cdn_u4_dp_driver::build_phase(uvm_phase phase);
   super.build_phase(phase);
   // get configs
   if (!uvm_config_db#(cdn_u4_dp_config)::get(this, "", "m_cfg", m_cfg)) begin
     `uvm_fatal(get_type_name(), "m_cfg not set")
   end
endfunction: build_phase

function void cdn_u4_dp_driver::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
endfunction: connect_phase

function void cdn_u4_dp_driver::end_of_elaboration_phase(uvm_phase phase);
   super.end_of_elaboration_phase(phase);
endfunction: end_of_elaboration_phase

function void cdn_u4_dp_driver::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);
   //ToDo: Implement this phase here
endfunction: start_of_simulation_phase

 
task cdn_u4_dp_driver::reset_phase(uvm_phase phase);
   super.reset_phase(phase);
   // ToDo: Reset output signals
endtask: reset_phase

task cdn_u4_dp_driver::configure_phase(uvm_phase phase);
   super.configure_phase(phase);
   //ToDo: Configure your component here
endtask:configure_phase


task cdn_u4_dp_driver::run_phase(uvm_phase phase);
   super.run_phase(phase);
   // phase.raise_objection(this,""); //Raise/drop objections in sequence file
   fork 
     begin
       drive_link_data();
     end
     begin
       drive_operation();
     end
      //tx_driver();
   join
   // phase.drop_objection(this);
endtask: run_phase


task cdn_u4_dp_driver::drive_link_data();
  cdn_u4_dp_transaction tr;
  tr = new("tr");
  forever begin
      wait(m_cfg.m_bfm.status_intf.link_trg_en);
      case(m_cfg.m_bfm.status_intf.link_trg_stage)
        LINK_TRG_NONE: begin
          reset_data();
        end
        LINK_TRG_CR: begin
          case(m_cfg.m_bfm.status_intf.link_trg_tps)
            LINK_TPS1: begin
              assert(tr.randomize() with {packet_type == LINK_TPS1;});
            end
            default: begin
              `uvm_error(get_full_name(), $sformatf("%s does not support %s", m_cfg.m_bfm.status_intf.link_trg_stage.name, m_cfg.m_bfm.status_intf.link_trg_tps.name))
            end
          endcase
          send_data(tr);
        end
        LINK_TRG_EQ: begin
          case(m_cfg.m_bfm.status_intf.link_trg_tps)
            LINK_TPS2: begin
              assert(tr.randomize() with {packet_type == LINK_TPS2;});
            end
            LINK_TPS3: begin
              assert(tr.randomize() with {packet_type == LINK_TPS3;});
            end
            LINK_TPS4: begin
              assert(tr.randomize() with {packet_type == LINK_TPS4;});
            end
            default: begin
              `uvm_error(get_full_name(), $sformatf("%s does not support %s", m_cfg.m_bfm.status_intf.link_trg_stage.name, m_cfg.m_bfm.status_intf.link_trg_tps.name))
            end
          endcase
          send_data(tr);
        end
        LINK_TRG_128B132B_EQ: begin
          case(m_cfg.m_bfm.status_intf.link_trg_tps)
            LINK_128B132B_TPS1: begin
              assert(tr.randomize() with {packet_type == LINK_128B132B_TPS1;});
            end
            default: begin
              `uvm_error(get_full_name(), $sformatf("%s does not support %s", m_cfg.m_bfm.status_intf.link_trg_stage.name, m_cfg.m_bfm.status_intf.link_trg_tps.name))
            end
          endcase
          send_data(tr);
        end
        LINK_TRG_128B132B_CDS: begin
          case(m_cfg.m_bfm.status_intf.link_trg_tps)
            LINK_128B132B_TPS2_START: begin
              assert(tr.randomize() with {packet_type == LINK_128B132B_TPS2_START;});
            end
            LINK_128B132B_TPS2: begin
              assert(tr.randomize() with {packet_type == LINK_128B132B_TPS2;});
            end
            default: begin
              `uvm_error(get_full_name(), $sformatf("%s does not support %s", m_cfg.m_bfm.status_intf.link_trg_stage.name, m_cfg.m_bfm.status_intf.link_trg_tps.name))
            end
          endcase
          send_data(tr);
        end
        LINK_TRG_DONE: begin
          case(m_cfg.m_bfm.status_intf.link_trg_tps)
            LINK_IDLE_PATTERN: begin
              assert(tr.randomize() with {packet_type == LINK_IDLE_PATTERN;});
            end
            LINK_128B132B_IDLE_PATTERN: begin
              assert(tr.randomize() with {packet_type == LINK_128B132B_IDLE_PATTERN;});
            end
            default: begin
              `uvm_error(get_full_name(), $sformatf("%s does not support %s", m_cfg.m_bfm.status_intf.link_trg_stage.name, m_cfg.m_bfm.status_intf.link_trg_tps.name))
            end
          endcase
          send_data(tr);
        end
        default: begin
          reset_data();
        end
      endcase
  end
endtask : drive_link_data

task cdn_u4_dp_driver::drive_operation();
  forever begin
    // ToDo: Set output signals to their idle state
    `uvm_info(get_full_name(), "Starting transaction...",UVM_LOW)
    seq_item_port.get_next_item(req);
    case(req.operation)
      DP_IDLE: begin
        `uvm_info(get_full_name(), "sending idle transaction!", UVM_LOW);
        if(m_cfg.m_bfm.status_intf.link_trg_en == 0) begin
          reset_data();
        end else begin
          `uvm_error(get_full_name(), $sformatf("should not send idle transaction when m_cfg.m_bfm.status_intf.link_trg_en is %0d!", m_cfg.m_bfm.status_intf.link_trg_en))
        end
      end
      DP_DATA: begin
        `uvm_info(get_full_name(), "sending data transaction!", UVM_LOW);
        if(m_cfg.m_bfm.status_intf.link_trg_en == 0) begin
          send_data(req);
        end else begin
          `uvm_error(get_full_name(), $sformatf("should not send data transaction when m_cfg.m_bfm.status_intf.link_trg_en is %0d!", m_cfg.m_bfm.status_intf.link_trg_en))
        end
      end
      DP_POWER_IDLE_ENTRY: begin
        power_state_change(POWER_IDLE);
      end
      DP_A0_ENTRY: begin
        power_state_change(POWER_A0);
      end
      DP_A1_ENTRY: begin
        power_state_change(POWER_A1);
      end
      DP_A2_ENTRY: begin
        power_state_change(POWER_A2);
      end
      DP_A3_ENTRY: begin
        power_state_change(POWER_A3);
      end
      DP_A4_ENTRY: begin
        power_state_change(POWER_A4);
      end
      DP_A5_ENTRY: begin
        power_state_change(POWER_A5);
      end
      DP_DATA_WIDTH_CHANGE: begin
      end
      XCVR_PLLCLK_EN: begin
        pll_clk_en;
      end
      default: begin
        `uvm_fatal(get_full_name(), $sformatf("transaction does not support operation %s", req.operation.name))
      end
    endcase
    //send(req); 
    seq_item_port.item_done();
    `uvm_info(get_full_name(), "Completed transaction...",UVM_LOW)
    `uvm_info(get_full_name(), req.sprint(), UVM_LOW) //UVM_HIGH
  end
endtask : drive_operation

task cdn_u4_dp_driver::send_data(cdn_u4_dp_transaction tr);
  //@(posedge m_vif.pipe_intf.pma_tx_td_clk);
  if(tr != null && tr.data_packet.datas.size() > 0) begin
  `uvm_info(get_full_name(), $sformatf("send_data: datas.size=%0d date_rates=%0x", 
              tr.data_packet.datas.size(), m_cfg.data_rate), UVM_LOW)
    if(m_cfg.data_rate inside {DP_RBR,DP_HBR,DP_HBR2,DP_HBR3}) begin // TODO, base on data rate
      for(int i=0; i<tr.data_packet.datas.size(); i=i+2) begin
        @(posedge m_vif.pipe_intf.pma_tx_td_clk);
        m_vif.pipe_intf.pma_tx_td_ln[19:0] = {tr.data_packet.datas[i+1][9:0],tr.data_packet.datas[i][9:0]};
        m_vif.pipe_intf.pma_tx_elec_idle_ln = 1'b0; // active low
        m_vif.dp_debug_intf.pd_data = m_vif.pipe_intf.pma_tx_td_ln[19:0];
        m_vif.dp_debug_intf.serdes_tx_valid = 1;
      end
    end
    else if (m_cfg.data_rate inside {DP_UHBR10,DP_UHBR13P5,DP_UHBR20}) begin
      for(int i=0; i<tr.data_packet.datas.size(); i=i+1) begin
        @(posedge m_vif.pipe_intf.pma_tx_td_clk);
        m_vif.pipe_intf.pma_tx_td_ln[31:0] = tr.data_packet.datas[i][31:0];
        m_vif.pipe_intf.pma_tx_elec_idle_ln = 1'b0; // active low
        m_vif.dp_debug_intf.pd_data = m_vif.pipe_intf.pma_tx_td_ln[31:0];
        m_vif.dp_debug_intf.serdes_tx_valid = 1;
        `uvm_info(get_full_name(), $sformatf("send %0d data the data is %0d ",i,tr.data_packet.datas[i][31:0]), UVM_LOW) 
      end
    end
    else begin
    `uvm_fatal(get_full_name(), " The dp rate does not meet the constraints!")
    end
  end else begin
    `uvm_fatal(get_full_name(), "cdn_u4_dp_transaction tr is null or data_packet size is 0!")
  end

endtask : send_data

task cdn_u4_dp_driver::reset_data();
  @(posedge m_vif.pipe_intf.pma_tx_td_clk);
  m_vif.pipe_intf.pma_tx_td_ln[31:0] = 32'h0;
  m_vif.pipe_intf.pma_tx_elec_idle_ln = 1'b1;
  m_vif.dp_debug_intf.pd_data = 32'h0;
  m_vif.dp_debug_intf.serdes_tx_valid = 0;
endtask : reset_data

task cdn_u4_dp_driver::power_state_change(bit [5:0] power_state);
  @(posedge m_vif.pipe_intf.pma_tx_td_clk);
  m_vif.pipe_intf.pma_xcvr_power_state_req = power_state;
  wait (m_vif.pipe_intf.pma_xcvr_power_state_ack == power_state); // --zzx wait dut ready
  `uvm_info(get_full_name(), $sformatf("PMA power state change to %0x", power_state), UVM_LOW)
endtask : power_state_change


task cdn_u4_dp_driver::pll_clk_en();
  @(posedge m_vif.pipe_intf.pma_tx_td_clk);
  m_vif.pipe_intf.pma_xcvr_pllclk_en = 1'b1;
  wait (m_vif.pipe_intf.pma_cmn_ready == 1'b1); //--zzx wait dut ready
  wait (m_vif.pipe_intf.pma_xcvr_pllclk_en_ack == 1'b1);// --zzx wait dut ready
    `uvm_info(get_full_name(), " XCVR PLL Clock Enable", UVM_LOW)
endtask : pll_clk_en

/*
task cdn_u4_dp_driver::tx_driver();
 forever begin
      cdn_u4_dp_transaction tr;
     // cdn_phy_transaction_base  tr;
      // ToDo: Set output signals to their idle state
      `uvm_info("cdn_phy_DRIVER", "Starting transaction...",UVM_LOW)
      seq_item_port.get_next_item(tr);
      //case (tr.kind) 
      //   cdn_u4_dp_transaction::READ: begin
      //      // ToDo: Implement READ transaction
      //
      //   end
      //   cdn_u4_dp_transaction::WRITE: begin
      //      // ToDo: Implement READ transaction
      //
      //   end
      //endcase
      send(tr); 
      seq_item_port.item_done();
      `uvm_info("cdn_phy_DRIVER", "Completed transaction...",UVM_LOW)
      `uvm_info("cdn_phy_DRIVER", tr.sprint(),UVM_HIGH)

   end
endtask : tx_driver
*/

/*
task cdn_u4_dp_driver::send(cdn_u4_dp_transaction tr);

   // ToDo: Drive signal on interface
  
endtask: send
*/

`endif // CDN_U4_DP_DRIVER__SV


