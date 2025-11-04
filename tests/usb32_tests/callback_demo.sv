class cdn_callback extends uvm_callback;
    
    `uvm_object_utils(cdn_callback)

    function new(string name = "cdn_callback");
        super.new(name);
    endfunction
    bit enable_callback;
    extern function void pre_usb32_symbol_pattern(cdn_u4_usb32_symbol_pattern symbol_pattern,ref bit drop);
    extern function void pre_usb32_loopback_data(cdn_u4_usb32_transmitter_transaction tx_ctx,ref bit drop);
    extern function void pre_usb32_gen1_TxData(cdn_u4_usb32_transmitter_transaction tx_ctx,ref bit drop);
    extern function void pre_usb32_gen1_skp_symbol(cdn_u4_usb32_transmitter_transaction tx_ctx,ref bit drop);
    extern function [9:0]pre_usb32_10bit(cdn_u4_usb32_symbol_pattern symbol_pattern,bit[9:0]bit_10bdata, ref bit drop);
    extern function void set_callback_en(input bit en);
endclass

function void cdn_callback::set_callback_en(input bit en);
    enable_callback = en;
endfunction

function void cdn_callback::pre_usb32_symbol_pattern(cdn_u4_usb32_symbol_pattern symbol_pattern, ref bit drop);
    if(enable_callback && symbol_pattern.idle_packet_gen_en) begin
       //    symbol_pattern.bit_10bdata = 10'h3ff;
       // foreach(symbol_pattern.data_q[i]) begin
       //     symbol_pattern.data_q[i] = 8'b01010101;
       //     //`uvm_info(get_name(), $psprintf("symbol_pattern.data_q is %h",symbol_pattern.data_q[i]), UVM_LOW);
       // end
    end
endfunction

function void cdn_callback::pre_usb32_loopback_data(cdn_u4_usb32_transmitter_transaction tx_ctx,ref bit drop);
    //if(enable_callback &&tx_ctx.BERT== 8'h7c&&tx_ctx.is_k_code == 1) begin
    //   //`uvm_info(get_name(), $psprintf("\033[1;42m calback enabled and BERC will change to COM \033[0m "), UVM_LOW)
    //       tx_ctx.BERT= 8'hBC;
    //end
endfunction

function void cdn_callback::pre_usb32_gen1_TxData(cdn_u4_usb32_transmitter_transaction tx_ctx,ref bit drop);
    //if(enable_callback &&(tx_ctx.TxData[7:0]== 8'hBC)) begin
    //   //`uvm_info(get_name(), $psprintf("\033[1;42m calback enabled and BERC will change to COM \033[0m "), UVM_LOW)
    //       tx_ctx.TxData[7:0]= 8'h88;
    //end
endfunction

function void cdn_callback::pre_usb32_gen1_skp_symbol(cdn_u4_usb32_transmitter_transaction tx_ctx, ref bit drop);
    //if(enable_callback && symbol_pattern.idle_packet_gen_en) begin
    //        bit_10bdata = 10'h3ff;
    //        //`uvm_info(get_name(), $psprintf("symbol_pattern.data_q is %h",symbol_pattern.data_q[i]), UVM_LOW);
    //end
endfunction
    
function [9:0] cdn_callback::pre_usb32_10bit(cdn_u4_usb32_symbol_pattern symbol_pattern,bit[9:0]bit_10bdata, ref bit drop);
    //if(enable_callback && symbol_pattern.idle_packet_gen_en) begin
    //        bit_10bdata = 10'h3ff;
    //        //`uvm_info(get_name(), $psprintf("symbol_pattern.data_q is %h",symbol_pattern.data_q[i]), UVM_LOW);
    //end
endfunction
