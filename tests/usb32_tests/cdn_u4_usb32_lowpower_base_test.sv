`ifndef  USB32_LOWPOWER_BASE_TEST_SV
`define  USB32_LOWPOWER_BASE_TEST_SV
class  cdn_u4_usb32_lowpower_base_test extends cdn_u4_usb32_test_base;
`uvm_component_utils(cdn_u4_usb32_lowpower_base_test)
extern virtual function void dyn_build_phase();
extern virtual function void connect_phase(uvm_phase phase); 
extern virtual function uvm_sequence_base GetDefSeq(string name);
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
endclass

function void cdn_u4_usb32_lowpower_base_test::dyn_build_phase();
 //   string vseq_name="";
 //   $value$plusargs("UVM_VSEQ_NAME=%S",vseq_name);
 //   uvm_config_db#(uvm_sequence_base)::set(this,$psprint("usb32_env.usb32_vsqr.main_phase"),"default_sequence",GetDefSeq(name));
endfunction

function void cdn_u4_usb32_lowpower_base_test::connect_phase(uvm_phase phase); 
    string vseq_name="";
    super.connect_phase(phase);
    $value$plusargs("UVM_VSEQ_NAME=%s",vseq_name);
    uvm_config_db#(uvm_sequence_base)::set(this,$psprintf("usb32_env.usb32_vsqr.main_phase"),"default_sequence",GetDefSeq(vseq_name));
endfunction

function uvm_sequence_base cdn_u4_usb32_lowpower_base_test::GetDefSeq(string name);
   $cast(GetDefSeq,create_object(name));
   if(!GetDefSeq) begin
       `uvm_fatal(get_name(),$sformatf("can not find seq_name:%s",name))
   end
endfunction
`endif
//uvm_config_db#(uvm_object_wrapper)::set(this,$psprintf("usb32_env.usb32_vsqr.main_phase"),"default_sequence",cdn_u4_usb32_base_sequence::type_id::get());
