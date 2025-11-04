//*******************************************************
class cdn_u4_usb32_instruction_sequence extends uvm_sequence#(cdn_u4_usb32_ltssm_instruction) ;
    cdn_u4_usb32_ltssm_instruction ltssm_instruction;
    cdn_u4_usb32_symbol_pattern    symbol_pattern;

    // Factory 
    //---------------------------------------
    `uvm_object_param_utils(cdn_u4_usb32_instruction_sequence)
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "cdn_u4_usb32_instruction_sequence");
        super.new(name);
        ltssm_instruction= cdn_u4_usb32_ltssm_instruction::type_id::create("ltssm_instruction");
        symbol_pattern= cdn_u4_usb32_symbol_pattern::type_id::create("symbol_pattern");
    endfunction : new

    extern task body();
endclass

task cdn_u4_usb32_instruction_sequence::body();
/*{{{*/
   start_item(ltssm_instruction);
   finish_item(ltssm_instruction);
endtask : body /*}}}*/

