//********************************************************
//Author:junqiang data:2025/10/23
//--------------------------------------------------------
//*******************************************************
`ifndef CDN_U4_USB32_LOWPOWER_BASE_SEQUENCE__SV
`define CDN_U4_USB32_LOWPOWER_BASE_SEQUENCE__SV
class cdn_u4_usb32_lowpower_base_sequence extends cdn_u4_usb32_base_sequence;
    `uvm_object_utils(cdn_u4_usb32_lowpower_base_sequence)
    cdn_u4_usb32_instruction_sequence host_seq;
    cdn_u4_usb32_instruction_sequence device_seq;        
       bit[3:0]repeat_time; 
       bit[2:0]lowpower_id;
       bit which_first;
    
  //  `uvm_declare_p_sequencer(cdn_u4_usb32_virtual_sequencer)
  function new(string name="cdn_u4_usb32_lowerpower_base_sequence");
    super.new(name);
  endfunction
    extern virtual function bit[2:0] get_lowpower_id();//rand U1 U2 U3 in base sequence ,give specific value in specific case        
    extern virtual function bit [3:0] get_repeat_time();//rand in base, give specific value in specific case
    extern function bit get_which_first();//should be rand in everywhere
    extern virtual task body(); 
    extern virtual task lowpower_entry_req(input bit[2:0] lowpower_id, input bit which_first);
    extern virtual task wait_both_entry_lowpower(input bit[2:0] lowpower_id);
    extern virtual task lowepower_exit_req(input bit which_first);   
endclass

function bit[2:0] cdn_u4_usb32_lowpower_base_sequence::get_lowpower_id();
    get_lowpower_id = $urandom_range(1,3);
endfunction

function bit [3:0] cdn_u4_usb32_lowpower_base_sequence::get_repeat_time();
    get_repeat_time = $urandom_range(4,8);
endfunction 

function bit cdn_u4_usb32_lowpower_base_sequence::get_which_first();
    get_which_first = $urandom_range(0,1);
endfunction 
task cdn_u4_usb32_lowpower_base_sequence::body();
wait(p_sequencer.host_sequencer.port_status.usb32_ltssm_state == USB32_LINK::U0 && p_sequencer.device_sequencer.port_status.usb32_ltssm_state == USB32_LINK::U0);
    #10us; //todo:need random delay 
       repeat_time = get_repeat_time();//rand repeat
       for(int i=0;  i<repeat_time;i++) begin 
           lowpower_id = get_lowpower_id(); //1:U1 2:U2 3:U3
           which_first = get_which_first(); //0:host first 1:device first
           lowpower_entry_req(lowpower_id,which_first);
           wait_both_entry_lowpower(lowpower_id); //wait both entry lowpower
           which_first = get_which_first(); //0:host first 1:device first
           lowepower_exit_req(which_first);
           wait(p_sequencer.host_sequencer.port_status.usb32_ltssm_state == USB32_LINK::U0 && p_sequencer.device_sequencer.port_status.usb32_ltssm_state == USB32_LINK::U0);               
       end    
endtask

task cdn_u4_usb32_lowpower_base_sequence::lowpower_entry_req(input bit[2:0] lowpower_id, input bit which_first);
    `uvm_info(get_full_name(),$sformatf("lowpower entry of U%0d host0_device1:%0d started now",lowpower_id,which_first),UVM_LOW)
  case({lowpower_id,which_first})
    {3'b001,1'b0} :begin
            fork
                begin
                    host_seq = new("host_seq");
                    host_seq.ltssm_instruction.u1_entry_req = 1;
                    host_seq.start(p_sequencer.host_sequencer);
                end
                
                begin
                    #p_sequencer.host_sequencer.timer_cfg.decode_latency;
                    device_seq = new("host_seq");
                    device_seq.ltssm_instruction.u1_entry_req = 1;
                    device_seq.start(p_sequencer.device_sequencer);
                end
            join
    end
    {3'b010,1'b0} :begin            
            fork
                begin
                    host_seq = new("host_seq");
                    host_seq.ltssm_instruction.u2_entry_req = 1;
                    host_seq.start(p_sequencer.host_sequencer);
                end

                begin
                    #p_sequencer.host_sequencer.timer_cfg.decode_latency;
                    device_seq = new("host_seq");
                    device_seq.ltssm_instruction.u2_entry_req = 1;
                    device_seq.start(p_sequencer.device_sequencer);
                end
            join
    end
    {3'b011,1'b0} :begin
            fork
                begin
                    host_seq = new("host_seq");
                    host_seq.ltssm_instruction.u3_entry_req = 1;
                    host_seq.start(p_sequencer.host_sequencer);
                end

                begin
                    #p_sequencer.host_sequencer.timer_cfg.decode_latency;
                    device_seq = new("host_seq");
                    device_seq.ltssm_instruction.u3_entry_req = 1;
                    device_seq.start(p_sequencer.device_sequencer);
                end
            join
    end
    {3'b001,1'b1} :begin
            fork
                begin
                    #p_sequencer.host_sequencer.timer_cfg.decode_latency;
                    host_seq = new("host_seq");
                    host_seq.ltssm_instruction.u1_entry_req = 1;
                    host_seq.start(p_sequencer.host_sequencer);
                end
                begin
                    device_seq = new("host_seq");
                    device_seq.ltssm_instruction.u1_entry_req = 1;
                    device_seq.start(p_sequencer.device_sequencer);
                end
            join
    end
    {3'b010,1'b1} :begin
        fork
            begin
                #p_sequencer.host_sequencer.timer_cfg.decode_latency;
                host_seq = new("host_seq");
                host_seq.ltssm_instruction.u2_entry_req = 1;
                host_seq.start(p_sequencer.host_sequencer);
            end
            begin
                device_seq = new("host_seq");
                device_seq.ltssm_instruction.u2_entry_req = 1;
                device_seq.start(p_sequencer.device_sequencer);
            end
        join             
    end
    {3'b011,1'b1} :begin        
        fork
            begin
                #p_sequencer.host_sequencer.timer_cfg.decode_latency;
                host_seq = new("host_seq");
                host_seq.ltssm_instruction.u3_entry_req = 1;
                host_seq.start(p_sequencer.host_sequencer);
            end
            begin
                device_seq = new("host_seq");
                device_seq.ltssm_instruction.u3_entry_req = 1;
                device_seq.start(p_sequencer.device_sequencer);
            end
        join  
    end
    default:  `uvm_error(get_full_name(),$sformatf("entry wong set lowpower_id=%0d,which_first=%0d",lowpower_id,which_first)) 
  endcase
endtask

task cdn_u4_usb32_lowpower_base_sequence::wait_both_entry_lowpower(input bit[2:0] lowpower_id);  
  case(lowpower_id)
    3'b001 :begin
        fork
            begin:ENTRYU1
                wait(p_sequencer.host_sequencer.port_status.usb32_ltssm_state == USB32_LINK::U1 && p_sequencer.device_sequencer.port_status.usb32_ltssm_state == USB32_LINK::U1);
                `uvm_info(get_full_name(),$sformatf("entry U%0d succeed",lowpower_id),UVM_LOW)
            end
            begin:OUTU1
                #20us;
                `uvm_fatal(get_full_name(),$sformatf("entry U%0d timeout",lowpower_id))
            end
        join_any
        disable OUTU1;
    end
    3'b010 :begin
        fork
            begin:ENTRYU2
                wait(p_sequencer.host_sequencer.port_status.usb32_ltssm_state == USB32_LINK::U2 && p_sequencer.device_sequencer.port_status.usb32_ltssm_state == USB32_LINK::U2);
                `uvm_info(get_full_name(),$sformatf("entry U%0d succeed",lowpower_id),UVM_LOW)
            end
            begin:OUTU2
                #20us;
                `uvm_fatal(get_full_name(),$sformatf("entry U%0d timeout",lowpower_id))
            end
        join_any
        disable OUTU2;       
    end
    3'b011 :begin
        fork
            begin:ENTRYU3
                wait(p_sequencer.host_sequencer.port_status.usb32_ltssm_state == USB32_LINK::U3 && p_sequencer.device_sequencer.port_status.usb32_ltssm_state == USB32_LINK::U3);
                `uvm_info(get_full_name(),$sformatf("entry U%0d succeed",lowpower_id),UVM_LOW)
            end
            begin :OUTU3
                #20us;
                `uvm_fatal(get_full_name(),$sformatf("entry U%0d timeout",lowpower_id))
            end
        join_any
        disable OUTU3;  
    end  
    default:  `uvm_error(get_full_name(),$sformatf(" wong set lowpower_id=%0d",lowpower_id)) 
  endcase
endtask

task cdn_u4_usb32_lowpower_base_sequence::lowepower_exit_req(input bit which_first);
  case(which_first)
    1'b0 :begin
            fork
                begin
                    host_seq = new("host_seq");
                    host_seq.ltssm_instruction.low_power_exit_req = 1;
                    host_seq.start(p_sequencer.host_sequencer);
                end

                begin
                    #p_sequencer.host_sequencer.timer_cfg.decode_latency;
                    device_seq = new("host_seq");
                    device_seq.ltssm_instruction.low_power_exit_req= 1;
                    device_seq.start(p_sequencer.device_sequencer);
                end
            join
    end
    1'b1 :begin            
            fork
                begin
                    #p_sequencer.host_sequencer.timer_cfg.decode_latency;
                    host_seq = new("host_seq");
                    host_seq.ltssm_instruction.low_power_exit_req = 1;
                    host_seq.start(p_sequencer.host_sequencer);
                end

                begin
                    device_seq = new("host_seq");
                    device_seq.ltssm_instruction.low_power_exit_req = 1;
                    device_seq.start(p_sequencer.device_sequencer);
                end
            join
    end
    default:  `uvm_error(get_full_name(),$sformatf("exit wong which_first=%0d",which_first)) 
  endcase
endtask   
`endif
