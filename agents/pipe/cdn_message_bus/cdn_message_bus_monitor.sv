
`ifndef CDN_MESSAGE_BUS_MONITOR
`define CDN_MESSAGE_BUS_MONITOR

class cdn_message_bus_monitor extends uvm_monitor;


bit checks_enable = 1;
rx_state_t rx_state;
message_bus_cmd_t cmd_out;
bit [7:0]p2m_message_bus;
bit [7:0]data_out;
bit [3:0] addr_high;
bit [7:0] addr_low;
bit [11:0]addr_out;
realtime t1_time;
realtime t2_time;
realtime t3_time;
bit write_ack_en='d0;
bit read_complete_en;
parameter WAIT_ACK_TIME=60_000_000; //response write ack in 60ns 6 cycle(write committed is 3 cycle)
parameter ACK_TIME_OUT =300_000_000;//wait ack time timeout
parameter POSTED_TO_POSTED_TIME=60_000_000; //posted to posted time (phy write ack to mac write comitted time delay)
string report_id = "CDN_MESSAGE_BUS_MONITOR_C";
cdn_message_bus_transaction  trans_to_mon;
cdn_message_bus_transaction  trans_queue[$];

//facory registration
`uvm_component_utils_begin(cdn_message_bus_monitor)
        `uvm_field_int(checks_enable, UVM_ALL_ON)
		`uvm_field_enum(rx_state_t,rx_state, UVM_ALL_ON)
		`uvm_field_enum(message_bus_cmd_t,cmd_out, UVM_ALL_ON)
        `uvm_field_int(p2m_message_bus, UVM_ALL_ON)
		`uvm_field_int(data_out, UVM_ALL_ON)
		`uvm_field_int(addr_out, UVM_ALL_ON)
`uvm_component_utils_end

// Analysis port for the transfer to driver.
    uvm_analysis_port #(cdn_message_bus_transaction) mon_trans_ap;
// blocking port for receive from  driver
	uvm_blocking_get_port #(cdn_message_bus_transaction)drv_trans_imp;

// interface
   cdn_phy_vif_t               m_vif; 

//New constructor 
  function new(string name = "cdn_message_bus_monitor",uvm_component parent);
   super.new(name,parent);
   `uvm_info(report_id,"Inside of class",UVM_DEBUG)
  endfunction:new

// Extend the build_phase method to create the monitor and driver.
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	`uvm_info(report_id,$sformatf("Starting of _%s_",phase.get_name()),UVM_LOW)
    mon_trans_ap = new("mon_trans_ap",this);
	drv_trans_imp =new("drv_trans_imp",this);
    if(!uvm_config_db#(cdn_phy_vif_t)::get(this, "", "m_mon_if", m_vif))
         `uvm_fatal(get_type_name(), "m_vif not set")
	`uvm_info(report_id,$sformatf("Ending of _%s_",phase.get_name()),UVM_LOW)
  endfunction : build_phase

virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
	uvm_report_info(get_type_name(),"Starting the monitor run task", UVM_LOW);
			fork
				rx_cmd_decode_task();   //decode the cmd from the phy
				receive_drv_task();     // receive driver write_committed transaction
			join
  endtask

//this task check the status from the phy
virtual task receive_drv_task();
	while(1)begin
		drv_trans_imp.get(trans_to_mon);
		trans_to_mon.print();
		if(trans_to_mon.cmd==WRITE_COMMITTED)begin      //no write ack timeout 
			t1_time=$realtime;
			while(1)begin
				#1ns;
				if(write_ack_en=='d1) break;
				else if($realtime - t1_time >(ACK_TIME_OUT*1fs))
				`uvm_fatal(get_type_name(),$sformatf("wait write ack timeout,time is %t,t1_time is %t",$realtime,t1_time));
			end
		end else if(trans_to_mon.cmd==READ)begin        //no read complete timeout
			t3_time=$realtime;
			while(1)begin
				#1ns;
				if(read_complete_en=='d1) break;
				else if($realtime - t3_time >(ACK_TIME_OUT*1fs))
				`uvm_fatal(get_type_name(),$sformatf("wait read complete timeout,time is %t",$realtime));
			end
		end
		
	end
endtask
  //waves::cdn_phy_tb_top.usb4_interface[0].usb4_host_if.pipe_intf.P2M_MessageBus
 // This task decode rx cmd from phy
virtual task rx_cmd_decode_task(/*input bit [7:0] p2m_message_bus, output [3:0]cmd_out, output [11:0]addr_out, output [7:0] data_out */);
    cdn_message_bus_transaction  message_bus_trans;
    message_bus_trans=cdn_message_bus_transaction::type_id::create("message_bus_trans",this);
if(m_vif== null)begin
`uvm_fatal(get_type_name(), "m_vif  is null ,not get")
end
	while(1)begin
		@(posedge m_vif.pclk )begin
			m_vif.message_bus_debug_if.rx_state=rx_state;
			p2m_message_bus=m_vif.pipe_intf.P2M_MessageBus;
		    m_vif.message_bus_debug_if.p2m_message_bus=m_vif.pipe_intf.P2M_MessageBus;
			if(~(m_vif.pipe_intf.Reset))begin
				rx_state=MB_RX_IDLE;
				p2m_message_bus='d0;
				write_ack_en='d0;
				read_complete_en='d0;
			end else begin
				case(rx_state)
					MB_RX_IDLE: begin
						if(p2m_message_bus[7:4]=='b0000)begin						//decode nop
							cmd_out=NOP;			
							rx_state=MB_RX_IDLE;
						end else if(p2m_message_bus[7:4]=='b0001)begin			    //decode wirte uncommitted
							cmd_out=WRITE_UNCOMMITTED;
							addr_high=p2m_message_bus[3:0];
							rx_state=MB_RX_CYCLE1;
						end else if (p2m_message_bus[7:4]=='b0010)begin				//decode write committed
							cmd_out=WRITE_COMMITTED;
							addr_high=p2m_message_bus[3:0];
							rx_state=MB_RX_CYCLE1;		
						end	else if (p2m_message_bus[7:4]=='b0011)begin			    //decode read(not use)
							cmd_out=READ;
							addr_high=p2m_message_bus[3:0];
							rx_state=MB_RX_CYCLE1;
						end	else if (p2m_message_bus[7:4]=='b0100)begin			    //decode read complete 
							cmd_out=READ_COMPLETION;
							read_complete_en='d1;
							assert_read_complete_latency: assert (($realtime-t3_time)<=(WAIT_ACK_TIME * 1fs))   //response read complete in 60ns 6 cycle(write committed is 3 cycle)
	    	   				 else `uvm_error(get_type_name(),$sformatf("read_complete response is ERROR,$realtime is %t,t3_time is %t",$realtime,t3_time));
							rx_state=MB_RX_CYCLE2;
						end	else if (p2m_message_bus[7:4]=='b0101)begin			    //decode write ack
							cmd_out=WRITE_ACK;
							write_ack_en='d1;	
							assert_write_ack_latency: assert (($realtime-t1_time)<=(WAIT_ACK_TIME * 1fs))   //response write ack in 60ns 6 cycle(write committed is 3 cycle)
	    	   				 else `uvm_error(get_type_name(),$sformatf("write_ack response is ERROR,$realtime is %t,t1_time is %t",$realtime,t1_time));
							rx_state=MB_RX_WRITE_COMPLETE;
						end else begin				
							rx_state=MB_RX_IDLE;
						end
					
    				end
					MB_RX_CYCLE1:begin
						addr_out={addr_high[3:0],p2m_message_bus[7:0]};
						rx_state=MB_RX_CYCLE2;
					end
					MB_RX_CYCLE2:begin
						if(addr_out==`PHY_RX_MRGN_CTRL_0)begin
							assert_pos2pos_write_latency: assert (($realtime-t2_time)< (POSTED_TO_POSTED_TIME * 1fs))   //response write ack in 60ns 6 cycle(write committed is 3 cycle)
	    	   				 else `uvm_error(get_type_name(),$sformatf("posted to posted write response is ERROR,$realtime is %t,t2_time is %t",$realtime,t2_time));
						end
						data_out[7:0]=p2m_message_bus[7:0];
						read_complete_en='d0;
						rx_state=MB_RX_IDLE;
					end
					MB_RX_WRITE_COMPLETE:begin
						cmd_out=NOP;
						write_ack_en='d0;
						t2_time=$realtime;
						rx_state=MB_RX_IDLE;
					end
				endcase
			end
        m_vif.message_bus_debug_if.cmd_out=cmd_out;
		m_vif.message_bus_debug_if.addr_out=addr_out;
		m_vif.message_bus_debug_if.data_out=data_out;
		m_vif.message_bus_debug_if.write_ack_en=write_ack_en;
		if(((cmd_out==WRITE_COMMITTED) & (rx_state==MB_RX_CYCLE2)) | (cmd_out==WRITE_ACK))begin
		$display("cmd_out is %s,addr_out is %h,data_out is %h",cmd_out.name(),addr_out,data_out);
		            // write port
					message_bus_trans.cmd=cmd_out;
					message_bus_trans.addr=addr_out;
					message_bus_trans.data=data_out;
					message_bus_trans.back2back_en='d0;
			        mon_trans_ap.write(message_bus_trans);
					message_bus_trans.print();
		end			
		end
	end
endtask : rx_cmd_decode_task

endclass:cdn_message_bus_monitor

`endif
