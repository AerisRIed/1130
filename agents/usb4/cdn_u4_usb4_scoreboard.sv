
class cdn_u4_usb4_scoreboard extends cdn_phy_scoreboard_base;

   //---------------------------------
   // Member config and interface
   //---------------------------------
   `uvm_component_utils_begin(cdn_u4_usb4_scoreboard)
      // ToDo: Add uvm monitor member if any class property added later through field macros

   `uvm_component_utils_end
    uvm_analysis_export #(cdn_u4_usb4_transaction)   drv2scb_export_ep_host;
    uvm_tlm_analysis_fifo #(cdn_u4_usb4_transaction) drv2scb_fifo_host; //imp
    uvm_analysis_export #(cdn_u4_usb4_transaction)   drv2scb_export_ep_devc;
    uvm_tlm_analysis_fifo #(cdn_u4_usb4_transaction) drv2scb_fifo_devc; //imp
    int lane_id;
    uvm_analysis_export #(cdn_u4_usb4_transaction)   mon2scb_export_ep_host;
    uvm_tlm_analysis_fifo #(cdn_u4_usb4_transaction) mon2scb_fifo_host; //imp
    uvm_analysis_export #(cdn_u4_usb4_transaction)   mon2scb_export_ep_devc;
    uvm_tlm_analysis_fifo #(cdn_u4_usb4_transaction) mon2scb_fifo_devc; //imp
    cdn_u4_usb4_transaction host_rx_trans;
    cdn_u4_usb4_transaction host_tx_trans;
    cdn_u4_usb4_transaction devc_rx_trans;
    cdn_u4_usb4_transaction devc_tx_trans;
    cdn_u4_usb4_transaction host_rx_trans_q[$];
    cdn_u4_usb4_transaction host_tx_trans_q[$];
    cdn_u4_usb4_transaction devc_rx_trans_q[$];
    cdn_u4_usb4_transaction devc_tx_trans_q[$];
   
   
   extern function new (string name= "cdn_u4_usb4_scoreboard", uvm_component parent);
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   extern virtual task check_data(input cdn_u4_usb4_transaction rx_trans,input cdn_u4_usb4_transaction tx_trans);

endclass: cdn_u4_usb4_scoreboard


function cdn_u4_usb4_scoreboard::new(string name = "cdn_u4_usb4_scoreboard",uvm_component parent);
   super.new(name, parent);
endfunction: new

function void cdn_u4_usb4_scoreboard::build_phase(uvm_phase phase);
   super.build_phase(phase);
	drv2scb_export_ep_host= new("drv2scb_export_ep_host",this);
    drv2scb_fifo_host = new("drv2scb_fifo_host",this);
	drv2scb_export_ep_devc= new("drv2scb_export_ep_devc",this);
    drv2scb_fifo_devc = new("drv2scb_fifo_devc",this);
	mon2scb_export_ep_host= new("mon2scb_export_ep_host",this);
	mon2scb_export_ep_devc= new("mon2scb_export_ep_devc",this);
    mon2scb_fifo_host = new("mon2scb_fifo_host",this);
    mon2scb_fifo_devc = new("mon2scb_fifo_devc",this);

endfunction: build_phase

function void cdn_u4_usb4_scoreboard::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   drv2scb_export_ep_host.connect(drv2scb_fifo_host.analysis_export);/*{{{*/
   drv2scb_export_ep_devc.connect(drv2scb_fifo_devc.analysis_export);/*{{{*/
   mon2scb_export_ep_host.connect(mon2scb_fifo_host.analysis_export);/*{{{*/
   mon2scb_export_ep_devc.connect(mon2scb_fifo_devc.analysis_export);/*{{{*/
endfunction: connect_phase

task cdn_u4_usb4_scoreboard::configure_phase(uvm_phase phase);
   super.configure_phase(phase);
endtask: configure_phase

task cdn_u4_usb4_scoreboard::run_phase(uvm_phase phase);
fork
    ///host rx devc tx ///
    forever begin //rx data 
        cdn_u4_usb4_transaction host_rx_trans_copy;
        mon2scb_fifo_host.get(host_rx_trans);
        host_rx_trans_copy= new();
        host_rx_trans_copy.do_copy(host_rx_trans);
        host_rx_trans_q.push_back(host_rx_trans_copy);
        wait(host_rx_trans_q.size > 0 && devc_tx_trans_q.size > 0) begin
        check_data(host_rx_trans_q[0],devc_tx_trans_q[0]);
  
        host_rx_trans_q.pop_front;
        devc_tx_trans_q.pop_front;
        end
    end
    forever begin //tx data //TODO
        cdn_u4_usb4_transaction devc_tx_trans_copy;
        drv2scb_fifo_devc.get(devc_tx_trans);
        devc_tx_trans_copy = new();
        devc_tx_trans_copy.do_copy(devc_tx_trans);
        devc_tx_trans_q.push_back(devc_tx_trans_copy);
    end
    
    ///devc rx host tx ///
    forever begin //rx data 
        cdn_u4_usb4_transaction devc_rx_trans_copy;
        mon2scb_fifo_devc.get(devc_rx_trans);
        devc_rx_trans_copy = new();
        devc_rx_trans_copy.do_copy(devc_rx_trans);
        devc_rx_trans_q.push_back(devc_rx_trans_copy);
        wait(devc_rx_trans_q.size > 0 && host_tx_trans_q.size > 0) begin
            check_data(devc_rx_trans_q[0],host_tx_trans_q[0]);
        end
        devc_rx_trans_q.pop_front;
        host_tx_trans_q.pop_front;
    end
    forever begin //tx data //TODO
        cdn_u4_usb4_transaction host_tx_trans_copy;
        drv2scb_fifo_host.get(host_tx_trans);
        host_tx_trans_copy = new();
        host_tx_trans_copy.do_copy(host_tx_trans);
        host_tx_trans_q.push_back(host_tx_trans_copy);
    end
join_none
endtask: run_phase

task cdn_u4_usb4_scoreboard::check_data(input cdn_u4_usb4_transaction rx_trans,input cdn_u4_usb4_transaction tx_trans);
    if(lane_id == 0) begin
            if(rx_trans.host_rxdata_buf_lane0!==tx_trans.devc_txdata_buf_lane0) begin
                foreach(rx_trans.host_rxdata_buf_lane0[i]) begin
                    if(rx_trans.host_rxdata_buf_lane0[i]!==tx_trans.devc_txdata_buf_lane0[i]) begin
                    `uvm_error(get_name(),$psprintf("[HOST RX LANE0 DATA CHECK ERROR]host rx[%d] is %h, while devc tx[%d] is %h",i,rx_trans.host_rxdata_buf_lane0[i],i,tx_trans.devc_txdata_buf_lane0[i]));
                    end
                end
                //`uvm_info(get_name(), $psprintf("tx_trans = %s", tx_trans.sprint()), UVM_LOW);
                //`uvm_info(get_name(), $psprintf("rx_trans = %s", rx_trans.sprint()), UVM_LOW);
            end
    end else begin
            if(rx_trans.host_rxdata_buf_lane1!==tx_trans.devc_txdata_buf_lane1) begin
                foreach(rx_trans.host_rxdata_buf_lane1[i]) begin
                    if(rx_trans.host_rxdata_buf_lane1[i]!==tx_trans.devc_txdata_buf_lane1[i]) begin
                    `uvm_error(get_name(),$psprintf("[HOST RX LANE1 DATA CHECK ERROR]host rx[%d] is %h, while devc tx[%d] is %h",i,rx_trans.host_rxdata_buf_lane1[i],i,tx_trans.devc_txdata_buf_lane1[i]));
                    end
                end
                //`uvm_info(get_name(), $psprintf("tx_trans = %s", tx_trans.sprint()), UVM_LOW);
                //`uvm_info(get_name(), $psprintf("rx_trans = %s", rx_trans.sprint()), UVM_LOW);
            end
    end
    if(lane_id == 0) begin
            if(rx_trans.devc_rxdata_buf_lane0!==tx_trans.host_txdata_buf_lane0) begin
                foreach(rx_trans.devc_rxdata_buf_lane0[i]) begin
                    if(rx_trans.devc_rxdata_buf_lane0[i]!==tx_trans.host_txdata_buf_lane0[i]) begin
                    `uvm_error(get_name(),$psprintf("[DEVC RX LANE0 DATA CHECK ERROR]host rx[%d] is %h, while devc tx[%d] is %h",i,rx_trans.host_rxdata_buf_lane0[i],i,tx_trans.devc_txdata_buf_lane0[i]));
                    end
                end
                //`uvm_info(get_name(), $psprintf("tx_trans = %s", tx_trans.sprint()), UVM_LOW);
                //`uvm_info(get_name(), $psprintf("rx_trans = %s", rx_trans.sprint()), UVM_LOW);
            end
    end else begin
            if(rx_trans.devc_rxdata_buf_lane1!==tx_trans.host_txdata_buf_lane1) begin
                foreach(rx_trans.devc_rxdata_buf_lane1[i]) begin
                    if(rx_trans.devc_rxdata_buf_lane1[i]!==tx_trans.host_txdata_buf_lane1[i]) begin
                    `uvm_error(get_name(),$psprintf("[DEVC RX LANE1 DATA CHECK ERROR]host rx[%d] is %h, while devc tx[%d] is %h",i,rx_trans.host_rxdata_buf_lane1[i],i,tx_trans.devc_txdata_buf_lane1[i]));
                    end
                end
                //`uvm_info(get_name(), $psprintf("tx_trans = %s", tx_trans.sprint()), UVM_LOW);
                //`uvm_info(get_name(), $psprintf("rx_trans = %s", rx_trans.sprint()), UVM_LOW);
            end
    end
endtask
