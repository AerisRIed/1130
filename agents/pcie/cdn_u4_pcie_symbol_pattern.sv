class cdn_u4_pcie_symbol_pattern extends uvm_object;

    //---------------------------------------
    // Member
    //---------------------------------------
    cdn_u4_pcie_config  m_cfg;
	cdn_phy_tb_config 	tb_cfg;
	cdn_phy_dut_config  dut_cfg;
    
    int PD_WIDTH = tb_param :: PD_WIDTH;
	bit rxdetect;
	bit ts1;
	bit ts2;
	bit fts;
	int n_fts;
	bit polarity_invert;
	bit compliance;
	bit data_en;
	data_type_enum data_type;
	bit l0s;
	bit l1;
	bit l1_exit;
	bit l2;
	bit beacon;
	bit rate;
	bit eq_en;
	bit speed_change;
    bit scramble_en;
	bit eieos;
    bit      is_k_code[$];
    bit[7:0] data_q[$]; 
    bit[7:0] data_scr_q[$]; 
    bit[7:0] skp_data_q[$]; 
    bit[7:0] data_pattern; 
    
    parameter bit[1:0] DATA_BLOCK_HEADER = 2'b10;
    parameter bit[1:0] CTRL_BLOCK_HEADER = 2'b01;

    bit[7:0] SKP_OS_GEN12[4] = '{
		COM_K, 	//8'hBC
		SKP_K,	//8'h1C
		SKP_K, 	
		SKP_K	
	};

    bit[7:0] EI_OS_GEN12[4] = '{
		COM_K, 	
		IDL_K,	//8'h7C
		IDL_K, 	
		IDL_K	
	};

	bit[7:0] EI_OS_GEN34[16] = '{
		EIOS_START,  //'h66
		EIOS_START,
		EIOS_START,
		EIOS_START,
		EIOS_START,
		EIOS_START,
		EIOS_START,
		EIOS_START,
		EIOS_START,
		EIOS_START,
		EIOS_START,
		EIOS_START,
		EIOS_START,
		EIOS_START,
		EIOS_START,
		EIOS_START
	};

	bit[7:0] FTS_OS_GEN12[4] = '{
		COM_K, 	
		FTS_K,	 //8'h3C
		FTS_K, 	 
		FTS_K	 
	};

	bit[7:0] FTS_OS_GEN34[16] = '{
		FTS_START, 	//'h55
		8'h47,	 
		8'h4E, 	 
		8'hC7,
		8'hCC,
		8'hC6,
		8'hC9,
		8'h25,
		8'h6E,
		8'hEC,
		8'h88,
		8'h7F,
		8'h80,
		8'h8D,
		8'h8B,
		8'h8E 
	};

	parameter bit[7:0] EIE_OS_GEN2[16] = '{
		COM_K,  
		EIE_K,	//8'hFC
		EIE_K,
		EIE_K,
		EIE_K,
		EIE_K,
		EIE_K,
		EIE_K,
		EIE_K,
		EIE_K,
		EIE_K,
		EIE_K,
		EIE_K,
		EIE_K,
		EIE_K,
		TS1_ID  //8'h4A
	};

	parameter bit[7:0] EIE_OS_GEN3[16] = '{
	    8'h0,
		8'hFF,
	    8'h0,	
		8'hFF,
	    8'h0,
		8'hFF,
		8'h0,
		8'hFF,
	    8'h0,
		8'hFF,
		8'h0,
		8'hFF,
	    8'h0,
		8'hFF,
		8'h0,
		8'hFF
	};

	parameter bit[7:0] EIE_OS_GEN4[16] = '{
	    8'h0,
	    8'h0,
		8'hFF,
		8'hFF,
		8'h0,
	    8'h0,
		8'hFF,
		8'hFF,
		8'h0,
	    8'h0,
		8'hFF,
		8'hFF,
		8'h0,
	    8'h0,
		8'hFF,
		8'hFF
	};

	parameter bit[7:0] SDS_OS_GEN4[16] = '{
	    8'hE1,
	    8'h55,
		8'h55,
		8'h55,
		8'h55,
	    8'h55,
		8'h55,
		8'h55,
		8'h55,
	    8'h55,
		8'h55,
		8'h55,
		8'h55,
	    8'h55,
		8'h55,
		8'h55
	};
    
   //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_object_param_utils_begin(cdn_u4_pcie_symbol_pattern)
        `uvm_field_int(rxdetect,             	UVM_ALL_ON)  
        `uvm_field_int(ts1,             		UVM_ALL_ON)  
        `uvm_field_int(ts2,              		UVM_ALL_ON)  
        `uvm_field_int(fts,              		UVM_ALL_ON)  
        `uvm_field_int(n_fts,    				UVM_ALL_ON)  
        `uvm_field_int(polarity_invert,    		UVM_ALL_ON)  
        `uvm_field_int(compliance,    			UVM_ALL_ON)  
        `uvm_field_int(data_en,    				UVM_ALL_ON)  
        `uvm_field_enum(data_type_enum,data_type,    			UVM_ALL_ON)  
        `uvm_field_int(l0s,    					UVM_ALL_ON)  
        `uvm_field_int(l1,    					UVM_ALL_ON)  
        `uvm_field_int(l1_exit,    				UVM_ALL_ON)  
        `uvm_field_int(l2,    					UVM_ALL_ON)  
        `uvm_field_int(beacon,    				UVM_ALL_ON)  
        `uvm_field_int(rate,    				UVM_ALL_ON)  
        `uvm_field_int(eq_en,    				UVM_ALL_ON)  
        `uvm_field_int(speed_change,    		UVM_ALL_ON)  
        `uvm_field_int(scramble_en,    			UVM_ALL_ON)  
    `uvm_object_utils_end
     
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "cdn_u4_pcie_symbol_pattern");
        super.new(name);
	    m_cfg = new();
		tb_cfg = new();
    endfunction : new

    extern function void clear_obj();
    extern function void print_data(bit[7:0] data_q[], string name);
    //extern function void gen_skp(skp_type_gen34_enum skp_type_e=STANDARD_SKP, int gen_num=1);
    extern function void gen_skp(int gen_num=1);
    extern function void gen_data();
    extern function void gen_ts1();
    extern function void gen_ts2();
    extern function void gen_eieos();
    extern function bit compare_eieos(bit[127:0] data);
    //extern virtual function void do_copy(uvm_object rhs);

endclass

function void cdn_u4_pcie_symbol_pattern::gen_eieos();
	this.eieos = 1;
	data_q.delete();
	case(dut_cfg.pcie_gen_speed)
	  GEN2_SPEED: 
		begin
		  is_k_code.delete();
		  for(int i=0;i<15;i++) is_k_code.push_back(1);
	      is_k_code.push_back(0);
		  for(int i=0;i<16;i++) data_q.push_back(EIE_OS_GEN2[i]);
		end
	  GEN3_SPEED: for(int i=0;i<16;i++) data_q.push_back(EIE_OS_GEN3[i]);
	  GEN4_SPEED: for(int i=0;i<16;i++) data_q.push_back(EIE_OS_GEN4[i]);
	  default: `uvm_fatal("","GEN1 does not use eieos os!")
	endcase
	if (is_k_code.size != data_q.size) `uvm_error("","is_k_code.size is not equal with data_q")
endfunction

function void cdn_u4_pcie_symbol_pattern :: gen_skp(int gen_num=1);
	int skp_id_num;

	this.eieos = 0;
	if (m_cfg.port_mode == tb_cfg.port_mode || tb_cfg.b2b_dut == 1) skp_id_num = 3; // transmitered SKP is 16 symbols
	else skp_id_num = $urandom_range(1,5); 	// received SKP is 8~24 symbols
	repeat(gen_num) begin
	  skp_data_q.delete();
	  if (dut_cfg.pcie_gen_speed[1]) begin //gen3/gen4
	    for(int i=0;i<4*skp_id_num;i++) skp_data_q.push_back(8'hAA);
		randcase
	      1:skp_data_q.push_back(8'hE1);
	      1:skp_data_q.push_back(8'h78);
		endcase
	    //if (skp_type_e == STANDARD_SKP) skp_data_q.push_back(8'hE1);
	    //else 							skp_data_q.push_back(8'h78);
	    for(int i=4*skp_id_num+1;i<4*skp_id_num+4;i++) skp_data_q.push_back($random);
	  end else begin 				  //gen1/gen2
	    skp_data_q.push_back(COM_K); // COM
	    for(int i=0;i<skp_id_num;i++) skp_data_q.push_back(SKP_K); //SKP
	  end
	end
	// print ts1
	print_data(skp_data_q, "SKP");
	
endfunction

function void cdn_u4_pcie_symbol_pattern :: gen_ts1();

	this.eieos = 0;
	data_q.delete;
	is_k_code.delete();
	for(int i=0;i<16;i++) data_q.push_back($random);
	for(int i=0;i<16;i++) is_k_code.push_back(0);
	// start symbol
	data_q[0] = (!dut_cfg.pcie_gen_speed[1]) ? COM_K : 8'h1E;
	is_k_code[0] = 1;
	// PAD or not
	data_q[1] = $urandom_range(0,1) ? PAD_K : data_q[1]; // PAD=8'hF7
	if (data_q[1] == PAD_K) is_k_code[1] = 1;
	data_q[2] = $urandom_range(0,1) ? PAD_K : data_q[2];
	if (data_q[2] == PAD_K) is_k_code[2] = 1;
	// speed_change
	data_q[4][7] = speed_change ? 1'b1 : 1'b0;
	// compliance
	data_q[5][4] = compliance ? 1'b1 : 1'b0;
	// eq
	data_q[6][7] = eq_en ? 1'b1 : 1'b0;
	// TS1 Id 
	if (!dut_cfg.pcie_gen_speed[1]) begin
	  for(int i=7;i<16;i++) data_q[i] = 8'h4A;
	end 
	// print ts1
	if (is_k_code.size != data_q.size) `uvm_error("","is_k_code.size is not equal with data_q")
	print_data(data_q, "TS1");
endfunction

function void cdn_u4_pcie_symbol_pattern :: gen_ts2();

	this.eieos = 0;
	data_q.delete;
	is_k_code.delete();
	for(int i=0;i<16;i++) data_q.push_back($random);
	for(int i=0;i<16;i++) is_k_code.push_back(0);
	// start symbol
	data_q[0] = (!dut_cfg.pcie_gen_speed[1]) ? COM_K : 8'h2D;
	is_k_code[0] = 1;
	// PAD or not
	data_q[1] = $urandom_range(0,1) ? PAD_K : data_q[1];
	if (data_q[1] == PAD_K) is_k_code[1] = 1;
	data_q[2] = $urandom_range(0,1) ? PAD_K : data_q[2];
	if (data_q[2] == PAD_K) is_k_code[2] = 1;
	// speed_change
	data_q[4][7] = speed_change ? 1'b1 : 1'b0;
	// eq
	data_q[6][7] = eq_en ? 1'b1 : 1'b0;
	// TS2 Id 
	if (!dut_cfg.pcie_gen_speed[1]) begin
	  for(int i=7;i<16;i++) data_q[i] = 8'h45;
	end 
	// print ts2
	if (is_k_code.size != data_q.size) `uvm_error("","is_k_code.size is not equal with data_q")
	print_data(data_q, "TS2");
endfunction

function void cdn_u4_pcie_symbol_pattern :: gen_data();
	bit[7:0] rand_data;

    if (!dut_cfg.pcie_gen_speed[1]) begin //8b/10b
        data_q.delete;
        is_k_code.delete;
        for(int i=0;i<4;i++) begin
          if (data_type == RANDOM) begin 
		    randcase
              1:     is_k_code.push_back(1);
              500:  is_k_code.push_back(0);
            endcase
		    if (is_k_code[$] == 1) std::randomize(rand_data) with {rand_data inside {IDL_K,FTS_K,EIE_K,PAD_K,STP_K,SDP_K,END_K,EDB_K,K28_4,K28_6};};// do not send COM and SKP in L0 random data
		    else rand_data = $random;
		    data_q.push_back(rand_data);
		  end
          else if (data_type == PCIE_LINK::IDL) begin 
		    is_k_code.push_back(0);
			data_q.push_back(0);
		  end
        end
	    if (is_k_code.size != data_q.size) `uvm_error("","is_k_code.size is not equal with data_q")
    end else begin //128/130
        data_q.delete;
        for(int i = 0;i<4;i++) begin
			if (data_type == RANDOM) data_q.push_back($random);
            else if (data_type == PCIE_LINK::IDL) data_q.push_back(0);
        end
    end
endfunction

function void cdn_u4_pcie_symbol_pattern :: print_data(bit[7:0] data_q[$], string name);
	string print_s;

	if (data_q.size == 0) begin 
	  `uvm_error(get_type_name(),"data_q is empty! please check")
	end
	else begin 
	  foreach(data_q[i]) print_s = {print_s, $sformatf("'h%2h ",data_q[i])};
	  `uvm_info("SYMBOL PATTERN",$sformatf("generate %0s: %0s",name,print_s),UVM_LOW);
	end
endfunction

function void cdn_u4_pcie_symbol_pattern :: clear_obj();
    data_q.delete;
	rxdetect 		= 0;
	ts1 			= 0;
	ts2 			= 0;
	fts 			= 0;
	n_fts 			= 0;
	polarity_invert = 0;
	compliance 		= 0;
	data_en 		= 0;
	data_type 		= RANDOM;
	l0s 			= 0;
	l1 				= 0;
	l1_exit 		= 0;
	l2 				= 0;
	beacon 			= 0;
	rate 			= 0;
	eq_en 			= 0;
	compliance 		= 0;
   // scramble_en     = 0;
	speed_change 	= 0;
endfunction

function bit cdn_u4_pcie_symbol_pattern ::compare_eieos(bit[127:0] data);
  bit[127:0] exp;
  case(dut_cfg.pcie_gen_speed)
  GEN2_SPEED: exp = {>>{this.EIE_OS_GEN2}};
  GEN3_SPEED: exp = {>>{this.EIE_OS_GEN3}};
  GEN4_SPEED: exp = {>>{this.EIE_OS_GEN4}};
  default: `uvm_fatal("","EIEOS is not uesed in gen1!")
  endcase
  //`uvm_info("",$sformatf("exp=%128b",exp),UVM_LOW);
  if (data == exp) return 1;
  else 	return 0;
endfunction

//------------------------------------------
// do_copy
//------------------------------------------
//function void cdn_u4_pcie_symbol_pattern::do_copy (uvm_object rhs);
//    cdn_u4_pcie_symbol_pattern m_rhs;
//    super.do_copy(rhs);
//
//    $cast(m_rhs, rhs);
//    m_cfg                     = m_rhs.m_cfg;
//    lfps_gen_en               = m_rhs.lfps_gen_en;
//    tseq_gen_en               = m_rhs.tseq_gen_en;
//    ts1_gen_en                = m_rhs.ts1_gen_en;
//    ts2_gen_en                = m_rhs.ts2_gen_en;
//    random_packet_gen_en      = m_rhs.random_packet_gen_en;
//    is_k_code                 = m_rhs.is_k_code;
//    data_q                    = m_rhs.data_q;
//    symbol_count              = m_rhs.symbol_count;
//endfunction : do_copy



