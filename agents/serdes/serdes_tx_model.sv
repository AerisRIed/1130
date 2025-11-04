class serdes_tx_model extends uvm_component;
    //---------------------------------------
    // Member
    //---------------------------------------
    serdes_vif     m_vif;
    serdes_cfg     m_cfg;  
    //must get handle from other
    // local variable
    
    //int            bit_cnt;
    int            bit_next_cnt = 1;
    bit            first_time_stamp;
    real           old_time, now_time, diff_time;
    bit [tb_param::SERDES_WIDTH-1:0] pd_buf[$]; 
    event catch;
    // used to buf data
    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_component_utils(serdes_tx_model)
    
    
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "serdes_tx_model", uvm_component parent);
        super.new(name,parent);
    endfunction : new
    
    
    //---------------------------------------
    // Methods 
    //---------------------------------------
    function void build_phase(uvm_phase phase); 
        super.build_phase(phase);
        //if(!uvm_config_db#(serdes_vif)::get(this, "", "m_vif", m_vif))
        //`uvm_info(get_name(), "No interface set for : serdes_vif", UVM_NONE);
        `uvm_info(get_full_name(), "tx model", UVM_NONE);
    endfunction : build_phase
    
    function void init_bus();
        if( TX_SD_IDLE_MODE[1] !=0 ) begin
            m_vif.serial_txp = 'bz;
            m_vif.serial_txn = 'bz;
        end else begin 
            m_vif.serial_txp =  TX_SD_IDLE_MODE[0];
            m_vif.serial_txn = ~TX_SD_IDLE_MODE[0];
        end
    endfunction : init_bus
    
    task map_pd_2_sd();
        case(m_cfg.m_pam_type)
            PAM2: 
            begin
                if( m_vif.output_buf[m_vif.bit_cnt]==0)
                m_vif.serial_txp = 0;
                if( m_vif.output_buf[m_vif.bit_cnt]==1)
                m_vif.serial_txp = 1;
                m_vif.bit_cnt =m_vif.bit_cnt+1;
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
    endtask    
    
    task run_phase(uvm_phase phase);
        bit  see_edge;
        real used_period;
        real half_period;
        
        //if(m_vif.is_tx) begin
        super.run_phase(phase);
        init_bus();
        forever begin 
            wait(m_vif.is_tx==1);
            if(!m_vif.is_tx) 
            begin
                $display("tx is over!");
                break;
            end
            wait(m_vif.en & (m_vif.pd_valid_in != 0 | m_vif.transmit_lfps));
            `uvm_info(get_full_name(), "SERDES tx start working", UVM_LOW);
            
            m_vif.bit_cnt = 0;
            first_time_stamp = 1;
            
            wait(m_vif.pd_valid_in==1); 
            
            // do something first cycle
            @(posedge m_vif.pd_clk_in);
            pd_buf.push_back(m_vif.pd_in);
            old_time =  $realtime;
            
            fork 
                begin 
                    // grab data, grab pd_clk_in period
                    forever begin
                        if(!m_vif.is_tx) 
                        begin
                            break;
                        end
                        //m_vif.pd_buf = m_vif.pd;
                        @(posedge m_vif.pd_clk_in);//ssc inside
                        
                        //m_vif.pd_buf = m_vif.pd;
                        pd_buf.push_back(m_vif.pd_in);
                        // recoverd clk mode
                        now_time = $realtime;
                        if( first_time_stamp !=0)
                        first_time_stamp = 0;
                        else begin
                            diff_time = now_time-old_time;
                            used_period = diff_time/(m_cfg.valid_bits);
                        end
                        old_time = now_time;
                    end
                end
                
                begin 
                    // output data
                    wait( pd_buf.size() >= 2*PD_BUF_DEEP );
                    #m_cfg.latency; //TODO
                    //#1;
                    forever begin //TODO need to judge if 0
                        half_period = used_period/2;
                        fork
                            begin
                                #used_period;
                            end
                            begin
                                m_vif.tx_clk = 1;
                                #half_period;
                                m_vif.tx_clk = 0;
                                #half_period;
                            end
                        join_any
					    disable fork;
                        if( m_vif.bit_cnt==0 ) begin
                            m_vif.output_buf = pd_buf.pop_front(); 
							m_vif.debug_output_buf = m_vif.output_buf;
                        end
                        if(~m_vif.pd_valid_in) begin
                            m_vif.serial_txp    = 'bz;
                            m_vif.serial_txn    = 'bz;
                            m_vif.bit_cnt = 0;
                            break;
                        end else begin
                            map_pd_2_sd();
                            m_vif.serial_txn = ~m_vif.serial_txp;
                        end
                        if( m_vif.bit_cnt==m_cfg.valid_bits ) begin
                            m_vif.bit_cnt = 0;
                        end
                    end
                end
                
                begin 
                    wait((m_vif.en & m_vif.pd_valid_in) == 0);
                    pd_buf.delete;
                end
                
            join_any
            
            wait(m_vif.bit_cnt==0);
            disable fork; 
            init_bus();
        end
        
        //end
    endtask : run_phase
    
endclass : serdes_tx_model
