//------------------------------------------------------------------------------
//
//   Filename:           cdn_message_bus_driver.sv
//   Module Name:        cdn_message_bus_driver
//
//   Release Revision:   1.0
//
//   Product Type:       Configurable
//   Protocol:           PIPE
//   Architecture:       PHY
//
//------------------------------------------------------------------------------
// Description: 
// This file defines the agent for the cdn_meassage_bus UVC.
//----------------------------------------------------------------------------
`ifndef CDN_MESSAGE_BUS_DRIVER_SV
`define CDN_MESSAGE_BUS_DRIVER_SV
//`uvm_analysis_imp_decl(_mon2drv_trans)
class cdn_message_bus_driver extends uvm_driver #(cdn_message_bus_transaction);
	// transaction
	cdn_message_bus_transaction  message_bus_trans;
	cdn_message_bus_transaction  trans_to_mon;
	cdn_message_bus_transaction  trans_queue[$];	
    // interface
   // virtual interface cdn_message_bus_debug_interface  message_bus_debug_if;
	cdn_phy_vif_t               m_vif;
	tx_state_t tx_state;
	rand bit [3:0]delay_value;
	bit wait_ack_en;
    string report_id = "CDN_MESSAGE_BUS_DRIVER_C";

    // Analysis port for transfer to monitor
    uvm_analysis_port #(cdn_message_bus_transaction) drv_trans_ap;
    // blocking port for receive from  monitor
	uvm_blocking_get_port#(cdn_message_bus_transaction)mon_trans_imp;

    //facory registration
    `uvm_component_utils_begin(cdn_message_bus_driver)
     	`uvm_field_enum(tx_state_t,tx_state, UVM_ALL_ON)
    	`uvm_field_int(delay_value, UVM_ALL_ON)
    	`uvm_field_int(wait_ack_en, UVM_ALL_ON)
    `uvm_component_utils_end
   
    // Extend the new method
    function new(string name = "cdn_message_bus_driver", uvm_component parent);
        super.new(name, parent);
		std::randomize(delay_value) with {delay_value <'d5;
										  delay_value >= 'd0;};
		`uvm_info(report_id,$sformatf("test delay_value is %d",delay_value),UVM_LOW)
    endfunction : new
   
    // Extend build_phase to attach the virtual interface
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
		`uvm_info(report_id,$sformatf("Starting of _%s_",phase.get_name()),UVM_LOW)
       if(!uvm_config_db#(cdn_phy_vif_t)::get(this, "", "m_drv_if", m_vif))
         `uvm_fatal(get_type_name(), "m_vif not set")
		 drv_trans_ap =new("drv_trans_ap",this);
         mon_trans_imp=new("mon_trans_imp",this);
		 trans_to_mon =cdn_message_bus_transaction::type_id::create("trans_to_mon",this);
		`uvm_info(report_id,$sformatf("Ending of _%s_",phase.get_name()),UVM_LOW)
    endfunction: build_phase

    //------------------------------------------------------------------------
    // DEFINE TASKS
    //------------------------------------------------------------------------

    // The run task for this class will be started automatically during the run phase
    virtual task run_phase(uvm_phase phase);

        uvm_report_info(get_type_name(),"Starting the driver run task", UVM_LOW);
		fork 
		while(1)begin                          //get sequencer transaction
			seq_item_port.get_next_item(req);
            req.print();	
			trans_queue.push_back(req);
			seq_item_port.item_done(rsp);
		end
		while(1)begin                          //get monitor transaction
			mon_trans_imp.get(message_bus_trans);
			message_bus_trans.print();
			if(message_bus_trans.cmd==WRITE_COMMITTED)begin
				message_bus_trans.cmd=WRITE_ACK;
				message_bus_trans.addr='d0;
				message_bus_trans.data='d0;
				message_bus_trans.back2back_en='d0;
				trans_queue.push_back(message_bus_trans);
			end else if(message_bus_trans.cmd==WRITE_ACK)begin
				wait_ack_en='d1;
				m_vif.message_bus_debug_if.wait_ack_en=wait_ack_en;
			end	
		end
        drive_tx_cmd_task(trans_queue);        //driver cmd to dut

		join
		uvm_report_info(get_type_name(),"Ending the driver run task", UVM_LOW);
    endtask : run_phase


    // This task drive tx cmd to phy from mac
    virtual task drive_tx_cmd_task (ref cdn_message_bus_transaction trans_queue[$] );
		message_bus_cmd_t cmd_in;
		bit [11:0]addr_in;
		bit [7:0] data_in;
		bit       back2back_en;
		bit [7:0] m2p_message_bus;
		while(1)begin
		@(posedge m_vif.pclk )begin
	 		m_vif.message_bus_debug_if.tx_state=tx_state;
			if(~(m_vif.pipe_intf.Reset))begin
				tx_state=MB_TX_IDLE;
				m2p_message_bus='d0;
			end else if(trans_queue.size()!='d0)begin
			cmd_in=	trans_queue[0].cmd;
			addr_in=trans_queue[0].addr;
			data_in=trans_queue[0].data;
			back2back_en=trans_queue[0].back2back_en;
			//$display("cmd_in is %s,addr_in is %d,data_in is %d,time is ",cmd_in.name(),addr_in,data_in,$realtime);
			case(tx_state)
				MB_TX_IDLE: begin
					if((back2back_en=='d1) &((cmd_in==WRITE_UNCOMMITTED) | (cmd_in==WRITE_COMMITTED)))begin				        //write uncommitted/committed cmd req ,max is 5 cmd req
						tx_state=MB_TX_CYCLE1_B;
					end else if((back2back_en=='d0) &(cmd_in==WRITE_UNCOMMITTED) | (cmd_in==WRITE_COMMITTED))begin				//write uncommitted/committed cmd req ,max is 5 cmd req
						tx_state=MB_TX_CYCLE1;
					end else if(cmd_in==WRITE_ACK)begin				   								                            //write ack cmd
						random_delay();				   								                            
						tx_state=MB_TX_CYCLE1_ACK;
					end else if(cmd_in==READ)begin													                            //read cmd
						tx_state=MB_TX_READ_CYCLE1;
					end else begin
						tx_state=MB_TX_IDLE;
					end		
    			end
		    	MB_TX_CYCLE1_B:begin
		    		m2p_message_bus[3:0]=addr_in[11:8];
		    		m2p_message_bus[7:4]=cmd_in[3:0];
		    		tx_state=MB_TX_CYCLE2_B;
		    	end
		    	MB_TX_CYCLE2_B:begin
		    		m2p_message_bus[7:0]=addr_in[7:0];
		    		tx_state=MB_TX_CYCLE3_B;
		    	end
		    	MB_TX_CYCLE3_B:begin
		    		m2p_message_bus[7:0]=data_in[7:0];
					if(cmd_in==WRITE_COMMITTED)begin
						tx_state=MB_TX_WAIT_ACK;
					end else begin
						trans_queue.pop_front();
						tx_state=MB_TX_CYCLE1_B;
					end
		    	end
				MB_TX_CYCLE1:begin
		    		m2p_message_bus[3:0]=addr_in[11:8];
		    		m2p_message_bus[7:4]=cmd_in[3:0];
		    		tx_state=MB_TX_CYCLE2;
		    	end
		    	MB_TX_CYCLE2:begin
		    		m2p_message_bus[7:0]=addr_in[7:0];
		    		tx_state=MB_TX_CYCLE3;
		    	end
		    	MB_TX_CYCLE3:begin
		    		m2p_message_bus[7:0]=data_in[7:0];
		    		tx_state=MB_TX_DELAY;
		    	end
				MB_TX_DELAY:begin
					random_delay();
		    		m2p_message_bus[7:0]='d0;
					if(cmd_in[3:0]==WRITE_COMMITTED)begin
						tx_state=MB_TX_WAIT_ACK;
					end else begin
						trans_queue.pop_front();
		    			tx_state=MB_TX_IDLE;
					end
		    	end
		    	MB_TX_CYCLE1_ACK:begin
		    		m2p_message_bus[3:0]=4'd0;
		    		m2p_message_bus[7:4]=cmd_in[3:0];
					trans_queue.pop_front();
		    		tx_state=MB_TX_IDLE;
		    	end
				MB_TX_READ_CYCLE1:begin
					m2p_message_bus[3:0]=addr_in[11:8];
		    		m2p_message_bus[7:4]=cmd_in[3:0];
					tx_state=MB_TX_READ_CYCLE2;
				end
				MB_TX_READ_CYCLE2:begin
					m2p_message_bus[7:0]=addr_in[7:0];
					trans_queue.pop_front();
					tx_state=MB_TX_IDLE;
				end
				MB_TX_WAIT_ACK:begin
					if(wait_ack_en=='d1)begin
						trans_queue.pop_front();
						tx_state=MB_TX_IDLE;
						wait_ack_en='d0;
					end else begin
						tx_state=MB_TX_WAIT_ACK;
					end
				end
            endcase
		    end else begin
				m2p_message_bus[7:0]=8'd0;
			end
        m_vif.message_bus_debug_if.cmd_in=cmd_in;
		m_vif.message_bus_debug_if.addr_in=addr_in;
		m_vif.message_bus_debug_if.data_in=data_in;
        m_vif.message_bus_debug_if.wait_ack_en=wait_ack_en;

		end
		if((cmd_in==WRITE_COMMITTED & (tx_state==MB_TX_CYCLE3 | tx_state==MB_TX_CYCLE3_B)) | (cmd_in==READ & tx_state==MB_TX_READ_CYCLE2))begin
		    // write port
			trans_to_mon.cmd=cmd_in;
			trans_to_mon.addr=addr_in;
			trans_to_mon.data=data_in;
			trans_to_mon.back2back_en='d0;
			//$display("cmd_in is %s,addr_in is %h,data_in is %h",cmd_in.name(),addr_in,data_in);
	        drv_trans_ap.write(trans_to_mon);
		end			

    	m_vif.message_bus_debug_if.m2p_message_bus=m2p_message_bus;
		m_vif.pipe_intf.M2P_MessageBus=m2p_message_bus;
		
		end
    endtask : drive_tx_cmd_task

virtual task random_delay();
	repeat(delay_value)begin
		@(posedge m_vif.pclk);
	end
endtask

endclass : cdn_message_bus_driver

`endif // MESSAGE_BUS_DRIVE_SVH

//----------------------------------------------------------------------------
// End of file
//----------------------------------------------------------------------------
