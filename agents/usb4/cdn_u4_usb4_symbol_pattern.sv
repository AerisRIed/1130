class cdn_u4_usb4_symbol_pattern extends uvm_object;

    //---------------------------------------
    // Member
    //---------------------------------------
    cdn_u4_usb4_config   m_cfg;
    
    int PD_WIDTH = tb_param :: PD_WIDTH;
    bit electric_idle_en;
    bit cl1_exit_gen_en;
    bit cl2_exit_gen_en;
    bit cl0s_exit_gen_en;
    bit lfps_gen_en;
    bit slos1_gen_en;
    bit slos2_gen_en;
    bit ts1_gen_en;
    bit ts2_gen_en;
    bit random_packet_gen_en;
    bit scramble_en;
    //cdn_u4_usb4_order_set_enum os_type;
    int symbol_count;
    int os_number;
    bit[7:0] data_q[]; 
    bit[7:0] random_packet_symbol; 
    bit[3:0] DATA_BLOCK_HEADER_128 = 4'b0101;
    bit[3:0] CTRL_BLOCK_HEADER_128 = 4'b1010;
    bit[1:0] DATA_BLOCK_HEADER_64 = 2'b01;
    bit[1:0] CTRL_BLOCK_HEADER_64 = 2'b10;
    parameter bit[2:0] LaneBondingTarget = 1;
    parameter bit[7:0] LaneNumber = 2;
    parameter bit[5:0] TS1ID = 6'b100110;
    parameter bit[5:0] TS2ID = 6'b011001;
    parameter bit[9:0] SCR= 10'b0011110010;
    parameter bit[63:0] TS1 ={5'b0,LaneBondingTarget,LaneNumber,19'b0,LaneBondingTarget,10'b0,TS1ID,SCR}; 
    parameter bit[63:0] TS2 ={5'b0,LaneBondingTarget,LaneNumber,19'b0,LaneBondingTarget,10'b0,TS2ID,SCR}; 
    
    parameter longint SLOS1_6664[32] ={ 
    /*{{{*/
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101,
        //64'b01010101010101010101010101010101_01010101010101010101010101010101
        64'b0100000000101000000100010000101010100100000001101000001110010001,
        64'b1011101011101010001010000101000100100010101101010000110000100111,
        64'b1001011100111001011110111001001010111011000010101110010000101110,
        64'b1001001010011011000111101110110010101011110000001001100001011111,
        64'b0010010001110110101101011000110001110111101101010010110000110011,
        64'b1001111110111100001010011001000111111010110000100011100101011011,
        64'b1000011010110011100011111011011000101101110100110101001111000011,
        64'b1001100110111111111010000000100100000101101000100110010101111110,
        64'b0001000011001010011111000111000110110110111011011010101101100000,
        64'b1101110001110101101101000110110010111011110010101001110000011101,
        64'b1000110101110111000101010110100000011001000011111010011000100111,
        64'b1101011100010001011010101001100000011111000011000110011110111111,
        64'b0010100001110001001101101011110110001001011101011001010001111000,
        64'b1011001101001111110011100001111011001100101111111100100000011101,
        64'b0000110100100111001101110111110101010001000000101010000100000100,
        64'b1010001011000101001110100011101001011010011001100111111111110000,
        64'b0000011000000011110000011001100011111111011000000101110000100101,
        64'b1001011001111001111100111100011110011011001111101111100010100011,
        64'b0100010111001010010111000110010110111110011010001111100101100011,
        64'b1001110110111101011010010001100110101111111000100000110101000111,
        64'b0000101101100100110111101111010010100100110001101111101110100010,
        64'b1010010100000110001000111101010110010000011110100011001001011111,
        64'b0110010001011110101001001000011011010011101100111010111110100010,
        64'b0010010101010110000000011100000011011000011101110011010101111100,
        64'b0001000110001010111101000010010010010110110110011011011111101101,
        64'b0000101100100100111101101110010110101110011000101111110100100001,
        64'b0011010010111100110010011111110111000001010110001000011101010011,
        64'b0100001111001001100111011111110101000001000010001010010101000110,
        64'b0000101111000100100110101101111000110100110111001111010111100100,
        64'b0100111010101110100000101001000100011010101011100000001011000001,
        64'b0011100010111011010010101100110000111111100110000011111100011000,
        64'b0110111100111010011110100111001001110111011101010101010000000000
   };/*}}}*/
    parameter longint SLOS2_6664[32] ={ 
    /*{{{*/
        64'b1011111111010111111011101111010101011011111110010111110001101110,
        64'b0100010100010101110101111010111011011101010010101111001111011000,
        64'b0110100011000110100001000110110101000100111101010001101111010001,
        64'b0110110101100100111000010001001101010100001111110110011110100000,
        64'b1101101110001001010010100111001110001000010010101101001111001100,
        64'b0110000001000011110101100110111000000101001111011100011010100100,
        64'b0111100101001100011100000100100111010010001011001010110000111100,
        64'b0110011001000000000101111111011011111010010111011001101010000001,
        64'b1110111100110101100000111000111001001001000100100101010010011111,
        64'b0010001110001010010010111001001101000100001101010110001111100010,
        64'b0111001010001000111010101001011111100110111100000101100111011000,
        64'b0010100011101110100101010110011111100000111100111001100001000000,
        64'b1101011110001110110010010100001001110110100010100110101110000111,
        64'b0100110010110000001100011110000100110011010000000011011111100010,
        64'b1111001011011000110010001000001010101110111111010101111011111011,
        64'b0101110100111010110001011100010110100101100110011000000000001111,
        64'b1111100111111100001111100110011100000000100111111010001111011010,
        64'b0110100110000110000011000011100001100100110000010000011101011100,
        64'b1011101000110101101000111001101001000001100101110000011010011100,
        64'b0110001001000010100101101110011001010000000111011111001010111000,
        64'b1111010010011011001000010000101101011011001110010000010001011101,
        64'b0101101011111001110111000010101001101111100001011100110110100000,
        64'b1001101110100001010110110111100100101100010011000101000001011101,
        64'b1101101010101001111111100011111100100111100010001100101010000011,
        64'b1110111001110101000010111101101101101001001001100100100000010010,
        64'b1111010011011011000010010001101001010001100111010000001011011110,
        64'b1100101101000011001101100000001000111110101001110111100010101100,
        64'b1011110000110110011000100000001010111110111101110101101010111001,
        64'b1111010000111011011001010010000111001011001000110000101000011011,
        64'b1011000101010001011111010110111011100101010100011111110100111110,
        64'b1100011101000100101101010011001111000000011001111100000011100111,
        64'b1001000011000101100001011000110110001000100010101010101111111111
        };/*}}}*/
      
    //---------------------------------------
    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_object_param_utils_begin(cdn_u4_usb4_symbol_pattern)
        `uvm_field_int(lfps_gen_en,             UVM_PRINT | UVM_COPY)  
        `uvm_field_int(slos1_gen_en,             UVM_PRINT | UVM_COPY)  
        `uvm_field_int(slos2_gen_en,             UVM_PRINT | UVM_COPY)  
        `uvm_field_int(ts1_gen_en,              UVM_PRINT | UVM_COPY)  
        `uvm_field_int(ts2_gen_en,              UVM_PRINT | UVM_COPY)  
        `uvm_field_int(cl1_exit_gen_en,          UVM_PRINT | UVM_COPY)  
        `uvm_field_int(cl2_exit_gen_en,          UVM_PRINT | UVM_COPY)  
        `uvm_field_int(cl0s_exit_gen_en,          UVM_PRINT | UVM_COPY)  
        `uvm_field_int(electric_idle_en,        UVM_PRINT | UVM_COPY)  
        `uvm_field_int(random_packet_gen_en,    UVM_PRINT | UVM_COPY)  
        `uvm_field_int(symbol_count,            UVM_PRINT | UVM_COPY)  
        `uvm_field_int(os_number,            UVM_PRINT | UVM_COPY)  
        `uvm_field_array_int(data_q,            UVM_PRINT | UVM_COPY)  
    `uvm_object_utils_end

    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "cdn_u4_usb4_symbol_pattern");
        super.new(name);
    endfunction : new

    extern function void clear_obj();
    extern function void gen_data();
    extern function [31:0] big_endian_transfer_byte(input bit en,input bit[31:0] data_in,input int width);
    extern virtual function void do_copy(uvm_object rhs);

endclass

function void cdn_u4_usb4_symbol_pattern :: gen_data();
    if(slos1_gen_en ) begin
        if(m_cfg.usb4_gen_speed==GEN2_SPEED&&m_cfg.fec_off) begin // 6466
            symbol_count = 8; //one block has 8 symbol_count
            os_number = 32*8; 
            data_q.delete();
            data_q=new[32*8];
            for(int j = 0; j<=31 ;j++) begin
                for(int i = 0; i<=7 ;i++) begin
                    data_q[8*j+i]=SLOS1_6664[j][63-8*i -: 8];
                end
            end
            foreach(data_q[i]) begin
                data_q[i] = big_endian_transfer_byte(1,data_q[i],8);
            end
        end else begin //128132
            symbol_count = 16; //one block has 16 symbol_count
            os_number = 16*16; 
            data_q.delete();
            data_q=new[16*16];
            for(int j = 0; j<=31 ;j++) begin
                for(int i = 0; i<=7 ;i++) begin
                    data_q[8*j+i]=SLOS1_6664[j][63-8*i -: 8];
                end
            end
            foreach(data_q[i]) begin
                data_q[i] = big_endian_transfer_byte(1,data_q[i],8);
            end
        end
    end else if(slos2_gen_en ) begin
        if(m_cfg.usb4_gen_speed==GEN2_SPEED&&m_cfg.fec_off) begin // 6466
            symbol_count = 8; //one block has 8 symbol_count
            os_number = 32*8; 
            data_q.delete();
            data_q=new[32*8];
            for(int j = 0; j<=31 ;j++) begin
                for(int i = 0; i<=7 ;i++) begin
                    data_q[8*j+i]=SLOS2_6664[j][63-8*i -: 8];
                end
            end
            foreach(data_q[i]) begin
                data_q[i] = big_endian_transfer_byte(1,data_q[i],8);
            end
        end else begin //128132
            symbol_count = 16; //one block has 16 symbol_count
            os_number = 16*16; 
            data_q.delete();
            data_q=new[16*16];
            for(int j = 0; j<=31 ;j++) begin
                for(int i = 0; i<=7 ;i++) begin
                    data_q[8*j+i]=SLOS2_6664[j][63-8*i -: 8];
                end
            end
            foreach(data_q[i]) begin
                data_q[i] = big_endian_transfer_byte(1,data_q[i],8);
            end
        end
    end else if (ts1_gen_en) begin
        if(m_cfg.usb4_gen_speed==GEN2_SPEED&&m_cfg.fec_off) begin // 6466
            symbol_count = 8; //one block has 8 symbol_count
            os_number = 8; 
            data_q.delete();
            data_q=new[8];
            for(int i = 0; i<=7 ;i++) begin
                data_q[i]=TS1[63-8*i -: 8];
            end
            foreach(data_q[i]) begin
                data_q[i] = big_endian_transfer_byte(1,data_q[i],8);
            end
        end else begin //128132
            symbol_count = 16; //one block has 16 symbol_count
            os_number = 16; 
            data_q.delete();
            data_q=new[16];
            for(int i = 0; i<=7 ;i++) begin
                data_q[i]=TS1[63-8*i -: 8];
            end
            for(int i = 0; i<=7 ;i++) begin
                data_q[8+i]=TS1[63-8*i -: 8];
            end
            foreach(data_q[i]) begin
                data_q[i] = big_endian_transfer_byte(1,data_q[i],8);
            end
        end
    end else if (ts2_gen_en) begin
        if(m_cfg.usb4_gen_speed==GEN2_SPEED&&m_cfg.fec_off) begin // 6466
            symbol_count = 8; //one block has 8 symbol_count
            os_number = 8; 
            data_q.delete();
            data_q=new[8];
            for(int i = 0; i<=7 ;i++) begin
                data_q[i]=TS2[63-8*i -: 8];
            end
            foreach(data_q[i]) begin
                data_q[i] = big_endian_transfer_byte(1,data_q[i],8);
            end
        end else begin //128132
            symbol_count = 16; //one block has 16 symbol_count
            os_number = 16; 
            data_q.delete();
            data_q=new[16];
            for(int i = 0; i<=7 ;i++) begin
                data_q[i]=TS2[63-8*i -: 8];
            end
            for(int i = 0; i<=7 ;i++) begin
                data_q[8+i]=TS2[63-8*i -: 8];
            end
            foreach(data_q[i]) begin
                data_q[i] = big_endian_transfer_byte(1,data_q[i],8);
            end
        end
    end else if (random_packet_gen_en && m_cfg.usb4_gen_speed==GEN2_SPEED&& m_cfg.fec_off) begin 
        data_q.delete;
        symbol_count = 8;
        os_number = 8; 
        data_q=new[8];
        for(int i = 0;i<data_q.size;i++) begin
            random_packet_symbol = $urandom();
            data_q[i] = random_packet_symbol;
        end
    end else if (random_packet_gen_en ) begin 
        data_q.delete;
        symbol_count = 16;
        os_number = 16; 
        data_q=new[16];
        for(int i = 0;i<data_q.size;i++) begin
            random_packet_symbol = $urandom();
            data_q[i] = random_packet_symbol;
        end
    end else if (electric_idle_en)begin
        data_q.delete;
    end
endfunction

function void cdn_u4_usb4_symbol_pattern :: clear_obj();
    data_q.delete;
    electric_idle_en        = 0;
    cl1_exit_gen_en         = 0;
    cl2_exit_gen_en         = 0;
    cl0s_exit_gen_en        = 0;
    lfps_gen_en             = 0;
    slos1_gen_en            = 0;
    slos2_gen_en            = 0;
    ts1_gen_en              = 0;
    ts2_gen_en              = 0;
    random_packet_gen_en    = 0;
    scramble_en             = 0;
    symbol_count            = 0;
    os_number               = 0;
endfunction

//------------------------------------------
// do_copy
//------------------------------------------
function void cdn_u4_usb4_symbol_pattern::do_copy (uvm_object rhs);
    cdn_u4_usb4_symbol_pattern m_rhs;
    super.do_copy(rhs);

    $cast(m_rhs, rhs);
    m_cfg                     = m_rhs.m_cfg;
    lfps_gen_en               = m_rhs.lfps_gen_en;
    slos1_gen_en              = m_rhs.slos1_gen_en;
    slos2_gen_en              = m_rhs.slos2_gen_en;
    ts1_gen_en                = m_rhs.ts1_gen_en;
    ts2_gen_en                = m_rhs.ts2_gen_en;
    electric_idle_en          = m_rhs.electric_idle_en;
    random_packet_gen_en      = m_rhs.random_packet_gen_en;
    data_q                    = m_rhs.data_q;
    symbol_count              = m_rhs.symbol_count;
    os_number                 = m_rhs.os_number;
    cl1_exit_gen_en            = m_rhs.cl1_exit_gen_en;
    cl2_exit_gen_en            = m_rhs.cl2_exit_gen_en;
    cl0s_exit_gen_en            = m_rhs.cl0s_exit_gen_en;
endfunction : do_copy


function [31:0] cdn_u4_usb4_symbol_pattern::big_endian_transfer_byte(input bit en,input bit[31:0] data_in,input int width);
/*{{{*/
    bit [31:0] result;
    if(en) begin
        data_in= {<<{data_in}};
        for(int i =0; i<width ; i++) begin
            result[width-i-1] = data_in[31-i];  
        end
        return result;
    end else begin
        return data_in;
    end
/*}}}*/
endfunction:big_endian_transfer_byte


