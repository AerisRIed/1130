
class serdes_rx_model extends uvm_component;
    
    //---------------------------------------
    // Member
    //---------------------------------------
    serdes_vif     m_vif;
    serdes_cfg     m_cfg;  //must get handle from other
    bit first_delay;
    
    // local variable
    //int            bit_cnt;
    real           old_time, now_time, diff_time, last_diff_time;
    bit [1:0]      bit_buf;
    int lfps_cnt;
    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_component_utils(serdes_rx_model)
    
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "serdes_rx_model", uvm_component parent);
        super.new(name,parent);
    endfunction : new
    
    //---------------------------------------
    // Methods 
    //---------------------------------------
    function void build_phase(uvm_phase phase); 
        super.build_phase(phase);
        //if(!uvm_config_db#(serdes_vif)::get(this, "", "m_vif", m_vif))
        //`uvm_info(get_name(), "No interface set for : serdes_vif", UVM_NONE);
    endfunction : build_phase
    
    function void init_bus();
        m_vif.pd_out = 'b0;
        m_vif.pd_clk_out = 'b0;
        m_vif.pd_valid_out = 'b0;
        m_vif.no_data = 'b1;
        m_vif.receive_lfps = 'b0;
        m_vif.sigdet = 'b0;
		m_vif.last_lfps_received = 'b0;
        m_vif.lfps_clk = 'b0;
		m_vif.bit_cnt = 0;
    endfunction : init_bus
    
    task receiving_lfps();
		`uvm_info(get_name(), "11111", UVM_LOW);
        @(m_vif.serial_p); // edge is here
		`uvm_info(get_name(), "2222", UVM_LOW);
        old_time = $realtime;
        forever begin
            fork
                begin
                    @(m_vif.serial_p); // edge is here
                end
                begin
                    #LFPS_MAX_PERIOD;
                end
            join_any
            disable fork;
            now_time = $realtime;
            diff_time = now_time-old_time;
            old_time = now_time;
            if( (m_vif.serial_p===1'bz))begin
                m_vif.sigdet = 'b0; 
                //break;
            end
            //if( (m_vif.serial_p===1'bz) && (m_vif.receive_lfps==1)&&diff_time > LFPS_MAX_PERIOD) begin
            //    m_vif.receive_lfps = 'b0; 
            //    m_vif.last_lfps_received= 'b1;
            //end else 
            else if(diff_time < LFPS_MIN_PERIOD || diff_time > LFPS_MAX_PERIOD ) begin 
                m_vif.receive_lfps = 'b0;                     
                break;
            end else begin
                m_vif.lfps_clk = m_vif.serial_p;
                if(m_vif.serial_p!==1'bz) begin 
                    m_vif.receive_lfps = 'b1;
                    m_vif.sigdet = 'b1; 
                    m_vif.last_lfps_received= 'b0;
                end
                if(m_vif.serial_p == 1 && m_vif.serial_n == 0) begin
                    m_vif.pd_out = 64'haaaa_aaaa_aaaa_aaaa;
                end else if(m_vif.serial_p == 0 && m_vif.serial_n == 1) begin
                    m_vif.pd_out = 64'h0;
                end
            end
            last_diff_time = diff_time;
        end

        m_vif.receive_lfps = 'b0;
        m_vif.lfps_clk = 'b0;
    endtask : receiving_lfps
    
    function  map_sd_2_pd();
        case(m_cfg.m_pam_type)
            PAM2:
            begin
                m_vif.bit_buf[m_vif.bit_cnt] = m_vif.serial_p;
                m_vif.bit_cnt++;
            end
            PAM3:
            begin
            //will add later for PAM3
            end
            PAM4:
            begin
            //will add later for PAM4
            end
        endcase
    endfunction
    
    
    task run_phase(uvm_phase phase);
        bit see_edge;
        //if(!m_vif.is_tx) begin
        super.run_phase(phase);
        
        init_bus();
        #1;
        forever begin 
            wait(m_vif.is_tx==0);
            if(m_vif.is_tx) break;
            wait(m_vif.en );
            //`uvm_info(get_full_name(), "SERDES start working", UVM_LOW);
            m_vif.no_data = 'b0;
            
            if( LFPS_DET_EN ) receiving_lfps(); //need to add later TODO
            //if( LFPS_DET_EN & m_vif.serial_p === 1'b0 ) continue;
            
            @(m_vif.serial_p or m_vif.serial_n); // edge is here
            m_vif.sigdet = 'b1; 
            m_vif.bit_cnt = 0;
            forever begin
                if(m_vif.is_tx) break;
                
                if(m_vif.serial_p === 1'bz || m_vif.serial_n === 1'bz  || m_vif.serial_p === m_vif.serial_n) begin
                    m_vif.pd_valid_out = 0;
                    m_vif.sigdet = 'b0; 
                    break;
                end
                    map_sd_2_pd();
                if( m_vif.bit_cnt==m_cfg.valid_bits) begin
                    m_vif.pd_out = m_vif.bit_buf;
                    m_vif.pd_valid_out = 1;
                    m_vif.pd_clk_out = ~m_vif.pd_clk_out;
                    m_vif.bit_cnt = 0;
                    m_vif.bit_buf = 0;
                    if( ALL_0_1_DIS_EN & (m_vif.pd_out == 'b0|m_vif.pd_out == 'b1))begin
						m_vif.pd_valid_out = 0;
						`uvm_info(get_name(), "break the serdes rx model", UVM_LOW);
                	    break;
					end
                end else if(m_vif.bit_cnt==m_cfg.half_valid_bits) begin
                    m_vif.pd_clk_out = ~m_vif.pd_clk_out;
                end else if(m_vif.serial_p === 'bz) begin
                    m_vif.pd_valid_out = 0;
                    break;                
                end

                
                see_edge = 0;
                fork
                  begin // one bit time go
                        #m_cfg.period;
                        //#4fs;
                        #m_cfg.over_period;
                        see_edge = 0;
                  end
                  begin // new edge find
                      #0;
                      @(m_vif.serial_p or m_vif.serial_n);
                        #1fs;
                      see_edge = 1;
                  end
                join_any
                disable fork; 
                

            end
            
            if(EN_GIVE_ONE_MORE_CLK_AFTER_EI) begin
                m_vif.no_data = 'b1;
                repeat(2) begin
                    while(m_vif.bit_cnt<m_cfg.valid_bits) begin
                        m_vif.bit_cnt++;
                        if( m_vif.bit_cnt==m_cfg.half_valid_bits ) begin
                            m_vif.pd_clk_out = ~m_vif.pd_clk_out;
                        end
                        #m_cfg.period;
                    end
                    m_vif.pd_clk_out = ~m_vif.pd_clk_out;
                    m_vif.pd_out = m_vif.bit_buf;
                    m_vif.bit_cnt = 0;
                end
                m_vif.pd_valid_out = 0;
                while(m_vif.bit_cnt<m_cfg.valid_bits) begin
                    m_vif.bit_cnt++;
                    if( m_vif.bit_cnt==m_cfg.half_valid_bits ) begin
                        m_vif.pd_clk_out = ~m_vif.pd_clk_out;
                    end
                    #m_cfg.period;
                end
                m_vif.pd_clk_out = ~m_vif.pd_clk_out;
                m_vif.pd_out = m_vif.bit_buf;
                m_vif.bit_cnt = 0;
            end
            
            init_bus();
        end
        //end
    endtask : run_phase
    
endclass : serdes_rx_model
