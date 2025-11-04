interface serdes_if #(
        parameter PD_WIDTH = 20
        ) (
            //serdes_rx 
            output reg [PD_WIDTH-1:0] rx_pd_out,    // lsb is the first input data
            output reg                rx_pd_clk_out,
            output reg                rx_pd_valid_out,
            
            output reg                receive_lfps,
            output reg                sigdet,
            output reg                last_lfps_received,
            
            //serdes_tx
            input  [PD_WIDTH-1:0] pd_in, // lsb is the first output data
            input                 pd_clk_in,
            input                 pd_valid_in,
            input                 lfps_in, 
            input                 transmit_lfps,
            input                 lfps_transmit_en,
            input                 ssc_en,
            input                 ssc_clk,
            
            input                 use_ref_clk,
            
        inout     logic      serial_p,  //inout for asymmetric
        inout     logic      serial_n,  //inout for asymmetric
        inout     s_lfps_clk        ,
        input                     en,
        //input                     fw,
        input                  is_tx
        );
        
        reg [PD_WIDTH-1:0] pd_out=0;    
        reg                pd_clk_out;
        reg                pd_valid_out;
        bit[1:0] debug_bit_buf;
        
        assign rx_pd_out        =   is_tx   ?   'bz             :   pd_out ; 
        assign rx_pd_clk_out    =   is_tx   ?   1'bz            :   pd_clk_out; 
        assign rx_pd_valid_out  =   is_tx   ?   1'bz            :   pd_valid_out ; 
        
         
        // internal use
        bit [PD_WIDTH-1:0] bit_buf;
        bit                no_data;
        int bit_cnt=0;

        reg tx_clk = 0;
        //  To avoid lvalue of a net under inout net
        reg     serial_txp = 0;
        reg     serial_txn = 0;
        reg lfps_clk;
        assign serial_p =  is_tx ? serial_txp : 'bz;
        assign serial_n =  is_tx ? serial_txn : 'bz;
        assign s_lfps_clk = ~is_tx ? lfps_clk : 'bz;
        
        
        real debug_tx_sd; 
        real debug_rx_sd; 
        bit [PD_WIDTH-1:0] output_buf;
        bit [PD_WIDTH-1:0] debug_output_buf;
        
endinterface : serdes_if


