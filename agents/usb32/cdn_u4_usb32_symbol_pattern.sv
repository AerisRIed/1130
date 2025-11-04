class cdn_u4_usb32_symbol_pattern extends uvm_object;

    //---------------------------------------
    // Member
    //---------------------------------------
    cdn_u4_usb32_config   m_cfg;
    
    int PD_WIDTH = tb_param :: PD_WIDTH;
    bit electric_idle_en;
    bit loopback_test_pattern_en;
    bit loopback_exit_gen_en;
    bit loopback_brst;
    bit u1_exit_gen_en;
    bit u2_exit_gen_en;
    bit u3_exit_gen_en;
    bit warmreset_gen_en;
    bit lfps_gen_en;
    bit scd1_gen_en;
    bit scd2_gen_en;
    bit lbpm_config_gen_en;
    bit lbpm_ready_gen_en;
    bit tseq_gen_en;
    bit ts1_gen_en;
    bit ts2_gen_en;
    bit idle_packet_gen_en;
    bit random_packet_gen_en;
    bit scramble_en;
    //cdn_u4_usb32_order_set_enum os_type;
    int symbol_count;
    bit[0:0] is_k_code[];
    bit[7:0] data_q[]; 
    bit[7:0] random_packet_symbol; 
    bit running_disparity; 
    bit[7:0] SKP_GEN1 = 8'h3C; 
    bit[7:0] SKP_GEN2     = 8'hcc; 
    bit[7:0] SKP_GEN2_END = 8'h33; 
    bit[3:0] DATA_BLOCK_HEADER = 4'b0011;
    bit[3:0] CTRL_BLOCK_HEADER = 4'b1100;
    bit [9:0]bit_10bdata;
    rand bit[7:0] r_Kdata_u0;

    constraint r_Kdata {r_Kdata_u0 inside{  8'b000_11100,
                                            //8'b001_11100, //SKP
                                            8'b010_11100,
                                            8'b011_11100,
                                            //8'b100_11100,  //sub
                                            8'b101_11100,    
                                            8'b110_11100,    
                                            8'b111_11100,    
                                            8'b111_10111,    
                                            8'b111_11011,    
                                            8'b111_11101,    
                                            8'b111_11110 };}
    
    parameter longint TSEQ_GEN1[32] ={ 
          8'hBC,                         //0 K28.5  COM (Comma) 
          8'hFF,                         //1 D31.7  FFh
          8'h17,                         //2 D23.0  17h
          8'hC0,                         //3 D0.6   C0h
          8'h14,                         //4 D20.0  14h
          8'hB2,                         //5 D18.5  B2h
          8'hE7,                         //6 D7.7   E7h
          8'h02,                         //7 D2.0   02h
          8'h82,                         //8 D2.4   82h
          8'h72,                         //9 D18.3  72h
          8'h6E,                         //10 D14.3 6Eh
          8'h28,                         //11 D8.1  28h
          8'hA6,                         //12 D6.5  A6h
          8'hBE,                         //13 D30.5 BEh
          8'h6D,                         //14 D13.3 6Dh
          8'hBF,                         //15 D31.5 BFh
          8'h4A,8'h4A,8'h4A,8'h4A,8'h4A,8'h4A,8'h4A,8'h4A,
          8'h4A,8'h4A,8'h4A,8'h4A,8'h4A,8'h4A,8'h4A,8'h4A//16-31 D10.2 4Ah
    };
    
    bit[7:0] link_configuration ;
    parameter longint TS1_GEN1[16] ={
          8'hBC,                         //0 K28.5  COM (Comma) 
          8'hBC,                         //0 K28.5  COM (Comma) 
          8'hBC,                         //0 K28.5  COM (Comma) 
          8'hBC,                         //0 K28.5  COM (Comma) 
          8'h00,                         //1 D0.0
          8'h00,                         //link function
          8'h4A,8'h4A,8'h4A,8'h4A,8'h4A,8'h4A,8'h4A,8'h4A,8'h4A,8'h4A//6-15 D10.2 4Ah
     };
    parameter longint TS2_GEN1[16] ={           
          8'hBC,                         //0 K28.5  COM (Comma) 
          8'hBC,                         //0 K28.5  COM (Comma) 
          8'hBC,                         //0 K28.5  COM (Comma) 
          8'hBC,                         //0 K28.5  COM (Comma) 
          8'h00,                         //1 D0.0
          8'h00,                         //link function
          8'h45,8'h45,8'h45,8'h45,8'h45,8'h45,8'h45,8'h45,8'h45,8'h45//6-15 D10.2 4Ah
       };
          
    
    parameter longint TSEQ_GEN2[16] ={ 
          8'h87,            //TSEQ ID
          8'h87,            //TSEQ ID
          8'h87,            //TSEQ ID
          8'h87,            //TSEQ ID
          8'h00,            
          8'h00,            
          8'h87,8'h87,8'h87,8'h87,8'h87,8'h87,8'h87,8'h87,//TSEQ ID
          8'h87,8'h87      //14-15 TSEQ ID / DC balance(no need to support in current testbench)
    };
    parameter longint TS1_GEN2[16] ={ 
          8'h1E,            //TS1 ID
          8'h1E,            //TS1 ID
          8'h1E,            //TS1 ID
          8'h1E,            //TS1 ID
          8'h00,            //reserved 
          8'h00,            //link function(no need to support)//TODO 
          8'h1E,8'h1E,8'h1E,8'h1E,8'h1E,8'h1E,8'h1E,8'h1E,//TS1 ID
          8'h1E,8'h1E       //14-15 TS1 ID / DC balance(no need to support in current testbench)
    };
    parameter longint TS2_GEN2[16] ={ 
          8'h2D,            //TS2 ID
          8'h2D,            //TS2 ID
          8'h2D,            //TS2 ID
          8'h2D,            //TS2 ID
          8'h00,            //reserved 
          8'h00,            //link function(no need to support) 
          8'h2D,8'h2D,8'h12D,8'h2D,8'h2D,8'h2D,8'h2D,8'h2D,//TS2 ID
          8'h2D,8'h2D       //14-15 TS2 ID / DC balance(no need to support in current testbench)
    };
    parameter longint SYNC_GEN2[16] ={ 
          8'h00,8'hff,8'h00,8'hff,
          8'h00,8'hff,8'h00,8'hff,
          8'h00,8'hff,8'h00,8'hff,
          8'h00,8'hff,8'h00,8'hff
    };
       
    //---------------------------------------
    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_object_param_utils_begin(cdn_u4_usb32_symbol_pattern)
        `uvm_field_int(lfps_gen_en,             UVM_PRINT | UVM_COPY)  
        `uvm_field_int(loopback_test_pattern_en,UVM_PRINT | UVM_COPY)  
        `uvm_field_int(tseq_gen_en,             UVM_PRINT | UVM_COPY)  
        `uvm_field_int(ts1_gen_en,              UVM_PRINT | UVM_COPY)  
        `uvm_field_int(ts2_gen_en,              UVM_PRINT | UVM_COPY)  
        `uvm_field_int(loopback_exit_gen_en,    UVM_PRINT | UVM_COPY)  
        `uvm_field_int(u1_exit_gen_en,          UVM_PRINT | UVM_COPY)  
        `uvm_field_int(u2_exit_gen_en,          UVM_PRINT | UVM_COPY)  
        `uvm_field_int(u3_exit_gen_en,          UVM_PRINT | UVM_COPY)  
        `uvm_field_int(idle_packet_gen_en,      UVM_PRINT | UVM_COPY)  
        `uvm_field_int(electric_idle_en,        UVM_PRINT | UVM_COPY)  
        `uvm_field_int(random_packet_gen_en,    UVM_PRINT | UVM_COPY)  
        `uvm_field_int(bit_10bdata,             UVM_PRINT | UVM_COPY)  
        `uvm_field_int(symbol_count,            UVM_PRINT | UVM_COPY)  
        `uvm_field_int(link_configuration,      UVM_PRINT | UVM_COPY)  
        `uvm_field_array_int(is_k_code,         UVM_PRINT | UVM_COPY)  
        `uvm_field_array_int(data_q,            UVM_PRINT | UVM_COPY)  
    `uvm_object_utils_end
     
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "cdn_u4_usb32_symbol_pattern");
        super.new(name);
    endfunction : new

    extern function void clear_obj();
    extern function void gen_data();
    extern virtual function void do_copy(uvm_object rhs);

endclass

function void cdn_u4_usb32_symbol_pattern :: gen_data();
    if(tseq_gen_en ) begin
        if(m_cfg.usb32_gen_speed==GEN1_SPEED) begin
            symbol_count = 32;
            is_k_code.delete;
            is_k_code=new[symbol_count];
            data_q.delete();
            data_q=new[32];
            foreach(data_q[i]) begin
                data_q[i]=TSEQ_GEN1[i];
            end
            is_k_code[0] = 1;
        end else begin
            symbol_count = 16;
            data_q.delete();
            data_q=new[16];
            foreach(data_q[i]) begin
                data_q[i]=TSEQ_GEN2[i];
            end
        end
    end else if (ts1_gen_en) begin
        symbol_count = 16;
        is_k_code.delete;
        is_k_code=new[symbol_count];
        data_q.delete;
        data_q=new[16];
        is_k_code.delete;
        is_k_code=new[symbol_count];
        if(m_cfg.usb32_gen_speed==GEN1_SPEED) begin
            is_k_code[0] = 1;
            is_k_code[1] = 1;
            is_k_code[2] = 1;
            is_k_code[3] = 1;
            foreach(TS1_GEN1[i]) begin
                data_q[i]=TS1_GEN1[i];
            end
            if(m_cfg.loopback_enable) begin
                data_q[5][2] = 1;
            end
        end else begin
            foreach(TS1_GEN2[i]) begin
                data_q[i]=TS1_GEN2[i];
            end
        end
    end else if (ts2_gen_en) begin
        symbol_count = 16;
        is_k_code.delete;
        is_k_code=new[symbol_count];
        data_q.delete;
        data_q=new[16];
        if(m_cfg.usb32_gen_speed==GEN1_SPEED) begin
            is_k_code[0] = 1;
            is_k_code[1] = 1;
            is_k_code[2] = 1;
            is_k_code[3] = 1;
            foreach(TS2_GEN1[i]) begin
                data_q[i]=TS2_GEN1[i];
            end
            if(m_cfg.loopback_enable) begin
                data_q[5][2] = 1;
            end
        end else begin
            foreach(TS2_GEN2[i]) begin
                data_q[i]=TS2_GEN2[i];
            end
        end
    end else if (idle_packet_gen_en) begin
        symbol_count = 16;
        data_q.delete;
        data_q=new[symbol_count];
        is_k_code.delete;
        is_k_code=new[symbol_count];
        foreach(is_k_code[i]) begin
            is_k_code[i]=0;
        end
        if(m_cfg.usb32_gen_speed==GEN1_SPEED) begin
            foreach(data_q[i]) begin
                data_q[i]=IDLE_SYMBOL_GEN1;
            end
        end else begin
            foreach(data_q[i]) begin
                data_q[i]=IDLE_SYMBOL_GEN2;
            end
        end
    end else if (random_packet_gen_en && m_cfg.usb32_gen_speed==GEN1_SPEED) begin //8b/10b
        symbol_count = 16;//for 32 bit width
        data_q.delete;
        is_k_code.delete;
        data_q=new[symbol_count];
        is_k_code=new[symbol_count];
        for(int i = 0;i<data_q.size;i++) begin
            randcase
                0:     is_k_code[i] = 1;
                1000:     is_k_code[i] = 0;
            endcase
            if(is_k_code[i] == 1) begin
                random_packet_symbol = r_Kdata_u0;
            end else begin
                random_packet_symbol = $urandom();
            end
            data_q[i] = random_packet_symbol;
        end
    end else if (random_packet_gen_en && m_cfg.usb32_gen_speed==GEN2_SPEED) begin //128/132
        data_q.delete;
        symbol_count = 16;
        data_q=new[16];
        for(int i = 0;i<data_q.size;i++) begin
            random_packet_symbol = $urandom();
            data_q[i] = random_packet_symbol;
        end
    end else if (loopback_test_pattern_en&& m_cfg.usb32_gen_speed==GEN2_SPEED&& m_cfg.loopback_enable) begin  // LOOPBACK MASTER 128/132
        data_q.delete;
        symbol_count = 16;
        data_q=new[16];
        for(int i = 0;i<data_q.size;i++) begin
            data_q[i] = 0;
        end
    end else if (loopback_test_pattern_en&& m_cfg.usb32_gen_speed==GEN1_SPEED&& m_cfg.loopback_enable) begin  // LOOPBACK MASTER 8b/10b
        symbol_count = 16; //  2brst + 65535 bdata + 4 berc
        data_q.delete;
        is_k_code.delete;
        data_q=new[65541];
        is_k_code=new[65541];
        for(int i = 0;i<data_q.size;i++) begin
            data_q[i] = 0;
            is_k_code[i] =0;
        end
        data_q[0]     = COM;
        data_q[1]     = BRST;
        data_q[65540] = BERC;
        data_q[65539] = BERC;
        data_q[65538] = BERC;
        data_q[65537] = BERC;
        is_k_code[0]     =1; 
        is_k_code[1]     =1;
        is_k_code[65540] =1;
        is_k_code[65539] =1;
        is_k_code[65538] =1;
        is_k_code[65537] =1;
    end else if(electric_idle_en)begin
        data_q.delete;
        is_k_code.delete;
    end
endfunction

function void cdn_u4_usb32_symbol_pattern :: clear_obj();
    data_q.delete;
    bit_10bdata             = 0;
    loopback_brst           = 0;
    electric_idle_en        = 0;
    loopback_exit_gen_en    = 0;
    u1_exit_gen_en          = 0;
    u2_exit_gen_en          = 0;
    u3_exit_gen_en          = 0;
    warmreset_gen_en        = 0;
    lfps_gen_en             = 0;
    scd1_gen_en             = 0;
    scd2_gen_en             = 0;
    lbpm_config_gen_en      = 0;
    lbpm_ready_gen_en       = 0;
    tseq_gen_en             = 0;
    ts1_gen_en              = 0;
    ts2_gen_en              = 0;
    idle_packet_gen_en      = 0;
    random_packet_gen_en    = 0;
    scramble_en             = 0;
    symbol_count            = 0;
    loopback_test_pattern_en= 0;
endfunction

//------------------------------------------
// do_copy
//------------------------------------------
function void cdn_u4_usb32_symbol_pattern::do_copy (uvm_object rhs);
    cdn_u4_usb32_symbol_pattern m_rhs;
    super.do_copy(rhs);

    $cast(m_rhs, rhs);
    r_Kdata_u0                = m_rhs.r_Kdata_u0;
    m_cfg                     = m_rhs.m_cfg;
    lfps_gen_en               = m_rhs.lfps_gen_en;
    tseq_gen_en               = m_rhs.tseq_gen_en;
    ts1_gen_en                = m_rhs.ts1_gen_en;
    ts2_gen_en                = m_rhs.ts2_gen_en;
    idle_packet_gen_en        = m_rhs.idle_packet_gen_en;
    electric_idle_en          = m_rhs.electric_idle_en;
    random_packet_gen_en      = m_rhs.random_packet_gen_en;
    is_k_code                 = m_rhs.is_k_code;
    data_q                    = m_rhs.data_q;
    symbol_count              = m_rhs.symbol_count;
    loopback_exit_gen_en      = m_rhs.loopback_exit_gen_en;
    u1_exit_gen_en            = m_rhs.u1_exit_gen_en;
    u2_exit_gen_en            = m_rhs.u2_exit_gen_en;
    u3_exit_gen_en            = m_rhs.u3_exit_gen_en;
    link_configuration        = m_rhs.link_configuration;
    loopback_brst             = m_rhs.loopback_brst;
    loopback_test_pattern_en  = m_rhs.loopback_test_pattern_en;
endfunction : do_copy

class cdn_u4_usb32_shared_obj extends uvm_object;
    //---------------------------------------
    // Constructor
    //---------------------------------------
   rand int skp_num_gen1x2;
   constraint r_skp {skp_num_gen1x2 inside{2,4,6,8,10};}
    
   function new (string name = "cdn_u4_usb32_shared_obj");
        super.new(name);
    endfunction : new
endclass

