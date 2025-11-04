//typedef class cdn_message_bus_transaction;

class cdn_message_bus_sequence extends uvm_sequence ;
  
   cdn_message_bus_transaction message_bus_trans; 
   `uvm_object_utils(cdn_message_bus_sequence)
string  report_id = "CDN_MESSAGE_BUS_SEQUENCE_C";
    function new (string name = "cdn_message_bus_sequence");
        super.new(name);
    endfunction : new

    task body();
uvm_report_info(get_type_name(),"Starting the seq body task", UVM_LOW);
////*******************************write_uncommitted/write_committed*************////
$display("write  cmd start,time is ",$realtime);
//`uvm_do_with(message_bus_trans,
//						{cmd  == WRITE_UNCOMMITTED;
//						 addr ==`PHY_RX_MRGN_CTRL_0;
//						 data =='h3;
//						 back2back_en  =='h1;	})
//`uvm_do_with(message_bus_trans,
//						{cmd  == WRITE_UNCOMMITTED;
//						 addr ==`PHY_RX_MRGN_CTRL_1;
//						 data =='h5;
//						 back2back_en  =='h1;	})
`uvm_do_with(message_bus_trans,
						{cmd  == cdn_message_bus_pkg::WRITE_COMMITTED;
						 addr == 'h4;
						 data =='h3;
						 back2back_en  =='h1;	})
////************************read*************************************************////
#1000ns;
$display("read cmd start,time is ",$realtime);
`uvm_do_with(message_bus_trans,
						{cmd  == cdn_message_bus_pkg::READ;
						 addr == 'h4;          })
//message_bus_trans.print();
#500ns;
uvm_report_info(get_type_name(),"Ending the seq body task", UVM_LOW);
    endtask : body
endclass

