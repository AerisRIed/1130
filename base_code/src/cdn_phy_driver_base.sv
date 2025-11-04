//
// Template for UVM-compliant physical-level transactor
//

`ifndef CDN_PHY_DRIVER_BASE__SV
`define CDN_PHY_DRIVER_BASE__SV

typedef class cdn_phy_transaction_base;
typedef class cdn_phy_driver_base;

class cdn_phy_driver_base_callbacks extends uvm_callback;

   // ToDo: Add additional relevant callbacks
   // ToDo: Use "task" if callbacks cannot be blocking

   // Called before a transaction is executed
   virtual task pre_tx( cdn_phy_driver_base xactor,
                        cdn_phy_transaction_base tr);
                                   
     // ToDo: Add relevant code

   endtask: pre_tx


   // Called after a transaction has been executed
   virtual task post_tx( cdn_phy_driver_base xactor,
                         cdn_phy_transaction_base tr);
     // ToDo: Add relevant code

   endtask: post_tx

endclass: cdn_phy_driver_base_callbacks


class cdn_phy_driver_base # (type T=cdn_phy_transaction_base) extends uvm_driver #(T);

   //---------------------------------
   // Member configs
   //---------------------------------
   cdn_phy_tb_config           tb_cfg;
   cdn_phy_dut_config          dut_cfg;
   cdn_phy_dut_config          device_dut_cfg;

   //---------------------------------
   // Member interface
   //---------------------------------
   cdn_phy_vif_t               m_vif;

   `uvm_register_cb(cdn_phy_driver_base,cdn_phy_driver_base_callbacks); 
   
   //---------------------------------------
   // Factory 
   //---------------------------------------
   `uvm_component_param_utils_begin(cdn_phy_driver_base#(T))
   // ToDo: Add uvm driver member
   `uvm_component_utils_end
   // ToDo: Add required short hand override method

   //---------------------------------
   // UVM functions and tasks
   //---------------------------------
   extern function new(string name = "cdn_phy_driver_base",
                       uvm_component parent = null); 
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void end_of_elaboration_phase(uvm_phase phase);
   extern virtual function void start_of_simulation_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern virtual task reset_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);

   //---------------------------------
   // User functions and tasks
   //---------------------------------
  // extern protected virtual task send(cdn_phy_transaction_base tr); 
  // extern protected virtual task tx_driver();
   
   extern function [7:0] scramble_lfsr16(input [7:0] data_in,input bit [15:0] lfsr,output bit[15:0] next_lfsr, input bit scramble_en=1,input bit advance_scramble =1);//can used in DP/USB/PCIE
   extern function [7:0] scramble_lfsr23(input [7:0] data_in,input bit [22:0] lfsr,output bit[22:0] next_lfsr, input bit scramble_en=1);//can used in DP/USB/PCIE
   extern function [9:0]datatrans_8b10b(input bit [7:0] data_8b, input bit rd, input bit K_code,output bit o_rd);//can used in DP/USB/PCIE
   extern function [31:0] big_endian_transfer_byte(input bit en,input bit[31:0] data_in,input int width);//data big endian transfer
   extern function bit[7:0] gf_mult(bit[7:0] a, bit[7:0] b);//use for USB4/DP/PCIe FEC_ENCODE
   extern function void rs_fec_encode(input bit[7:0] data_in[194],output bit[7:0] data_out[198]);//use for USB4/DP/PCIe FEC_ENCODE
   extern virtual task set_refclk_pins();
   extern virtual task set_phy_mode_pins(); 
   extern virtual task set_data_width_pins(); 
   extern virtual task set_pins_init_value(); 
   extern virtual function logic [63:0] get_init_value();

endclass: cdn_phy_driver_base


function cdn_phy_driver_base::new(string name = "cdn_phy_driver_base", uvm_component parent = null);
   super.new(name, parent);
endfunction: new

function void cdn_phy_driver_base::build_phase(uvm_phase phase);
   super.build_phase(phase);
   // get configs
   if (!uvm_config_db#(cdn_phy_tb_config)::get(this, "", "tb_cfg", tb_cfg)) begin
     `uvm_fatal(get_type_name(), "tb_cfg not set")
   end
   if (!uvm_config_db#(cdn_phy_dut_config)::get(this, "", "dut_cfg", dut_cfg)) begin
     `uvm_fatal(get_type_name(), "dut_cfg not set")
   end
   if (!uvm_config_db#(cdn_phy_dut_config)::get(this, "", "device_dut_cfg", device_dut_cfg)) begin
     `uvm_fatal(get_type_name(), "device_dut_cfg not set")
   end
   // get vif
   if (!uvm_config_db#(cdn_phy_vif_t)::get(this, "", "m_drv_if", m_vif)) begin
     `uvm_fatal(get_type_name(), "m_vif not set")
   end
endfunction: build_phase

function void cdn_phy_driver_base::connect_phase(uvm_phase phase);
   super.connect_phase(phase);

endfunction: connect_phase

function void cdn_phy_driver_base::end_of_elaboration_phase(uvm_phase phase);
   super.end_of_elaboration_phase(phase);
   if (m_vif == null)
       `uvm_fatal("NO_CONN", "Virtual port not connected to the actual interface instance");   

endfunction: end_of_elaboration_phase

function void cdn_phy_driver_base::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);
   //ToDo: Implement this phase here
endfunction: start_of_simulation_phase

 
task cdn_phy_driver_base::reset_phase(uvm_phase phase);
   super.reset_phase(phase);
   // ToDo: Reset output signals
endtask: reset_phase

task cdn_phy_driver_base::configure_phase(uvm_phase phase);
   super.configure_phase(phase);
   //ToDo: Configure your component here
   set_refclk_pins();
   set_phy_mode_pins();
   set_data_width_pins();
   set_pins_init_value();
endtask:configure_phase


task cdn_phy_driver_base::run_phase(uvm_phase phase);
   super.run_phase(phase);
   // phase.raise_objection(this,""); //Raise/drop objections in sequence file
   // phase.drop_objection(this);
endtask: run_phase


//task cdn_phy_driver_base::tx_driver();
// forever begin
//      cdn_phy_transaction_base tr;
//      // ToDo: Set output signals to their idle state
//      `uvm_info("cdn_phy_DRIVER", "Starting transaction...",UVM_LOW)
//      seq_item_port.get_next_item(tr);
//      //case (tr.kind) 
//      //   cdn_phy_transaction_base::READ: begin
//      //      // ToDo: Implement READ transaction
//      //
//      //   end
//      //   cdn_phy_transaction_base::WRITE: begin
//      //      // ToDo: Implement READ transaction
//      //
//      //   end
//      //endcase
//	  `uvm_do_callbacks(cdn_phy_driver_base,cdn_phy_driver_base_callbacks,
//                    pre_tx(this, tr))
//      send(tr); 
//      seq_item_port.item_done();
//      `uvm_info("cdn_phy_DRIVER", "Completed transaction...",UVM_LOW)
//      `uvm_info("cdn_phy_DRIVER", tr.sprint(),UVM_HIGH)
//      `uvm_do_callbacks(cdn_phy_driver_base,cdn_phy_driver_base_callbacks,
//                    post_tx(this, tr))
//
//   end
//endtask : tx_driver

//task cdn_phy_driver_base::send(cdn_phy_transaction_base tr);
//   // ToDo: Drive signal on interface
//  
//endtask: send

function [31:0] cdn_phy_driver_base::big_endian_transfer_byte(input bit en,input bit[31:0] data_in,input int width);
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

function [7:0] cdn_phy_driver_base::scramble_lfsr16(input [7:0] data_in,input bit [15:0] lfsr,output bit[15:0] next_lfsr,input bit scramble_en=1,input bit advance_scramble=1);
    /*{{{*/
    // Polynomial: x^16 + x^5 + x^4 + x^3 + 1
    // Taps: bit positions 15 (MSB), 4, 3, 2
    bit [7:0] scrambled;
    bit [15:0] input_lfsr = lfsr;
    for (int i = 0; i < 8; i++) begin
        for(int j = 0; j < 16; j++) begin
            if(j==0) begin
                next_lfsr[j] = lfsr[15];
            end else if(j==5)begin
                next_lfsr[5] = lfsr[4] ^ lfsr[15];
            end else if(j==4)begin
                next_lfsr[4] = lfsr[3] ^ lfsr[15];
            end else if(j==3)begin
                next_lfsr[3] = lfsr[2] ^ lfsr[15];
            end else begin
                next_lfsr[j] = lfsr[j-1];
            end
        end
        // Scramble: XOR input data with MSB of LFSR
        if (scramble_en) scrambled[i] = data_in[i] ^ lfsr[15];
		else 			 scrambled[i] = data_in[i];
        lfsr = next_lfsr;
    end
    if(~advance_scramble) begin
        next_lfsr = input_lfsr;
    end
        return scrambled;
    /*}}}*/
endfunction

//f G(X) = X^23 + X^21 + X^16 + X^8 + X^5 + X^2 + 1.
function  [7:0] cdn_phy_driver_base::scramble_lfsr23(
    input [7:0] data_in,
    input bit [22:0] lfsr,
    output bit[22:0] next_lfsr,
	input bit 	scramble_en=1
);
/*{{{*/
// Polynomial: X^23 + X^21 + X^16 + X^8 + X^5 + X^2 + 1.
    // Taps: bit positions 22 (MSB), 15, 7, 4 , 1
    bit [7:0] scrambled;
    for (int i = 0; i < 8; i++) begin
        for(int j = 0; j < 23; j++) begin
            if(j==0) begin
                next_lfsr[j] = lfsr[22];
            end else if(j==21)begin
                next_lfsr[21] = lfsr[20] ^ lfsr[22];
            end else if(j==16)begin
                next_lfsr[16] = lfsr[15] ^ lfsr[22];
            end else if(j==8)begin
                next_lfsr[8] = lfsr[7] ^ lfsr[22];
            end else if(j==5)begin
                next_lfsr[5] = lfsr[4] ^ lfsr[22];
            end else if(j==2)begin
                next_lfsr[2] = lfsr[1] ^ lfsr[22];
            end else begin
                next_lfsr[j] = lfsr[j-1];
            end
        end
        // Scramble: XOR input data with MSB of LFSR
        if (scramble_en) scrambled[i] = data_in[i] ^ lfsr[22];
		else 			 scrambled[i] = data_in[i];
        lfsr = next_lfsr;
    end
        return scrambled;
/*}}}*/
endfunction

function [9:0] cdn_phy_driver_base::datatrans_8b10b(input bit [7:0] data_8b, input bit rd, input bit K_code,output bit o_rd);
/*{{{*/
    bit[9:0] data_10b;
    if(~K_code) begin
        case(data_8b)//D_code
            8'b000_00000: data_10b = (rd == 0) ?  10'b100111_0100 : 10'b011000_1011 ;
            8'b000_00001: data_10b = (rd == 0) ?  10'b011101_0100 : 10'b100010_1011 ;
            8'b000_00010: data_10b = (rd == 0) ?  10'b101101_0100 : 10'b010010_1011 ;
            8'b000_00011: data_10b = (rd == 0) ?  10'b110001_1011 : 10'b110001_0100 ;
            8'b000_00100: data_10b = (rd == 0) ?  10'b110101_0100 : 10'b001010_1011 ;
            8'b000_00101: data_10b = (rd == 0) ?  10'b101001_1011 : 10'b101001_0100 ;
            8'b000_00110: data_10b = (rd == 0) ?  10'b011001_1011 : 10'b011001_0100 ;
            8'b000_00111: data_10b = (rd == 0) ?  10'b111000_1011 : 10'b000111_0100 ;
            8'b000_01000: data_10b = (rd == 0) ?  10'b111001_0100 : 10'b000110_1011 ;
            8'b000_01001: data_10b = (rd == 0) ?  10'b100101_1011 : 10'b100101_0100 ;
            8'b000_01010: data_10b = (rd == 0) ?  10'b010101_1011 : 10'b010101_0100 ;
            8'b000_01011: data_10b = (rd == 0) ?  10'b110100_1011 : 10'b110100_0100 ;
            8'b000_01100: data_10b = (rd == 0) ?  10'b001101_1011 : 10'b001101_0100 ;
            8'b000_01101: data_10b = (rd == 0) ?  10'b101100_1011 : 10'b101100_0100 ;
            8'b000_01110: data_10b = (rd == 0) ?  10'b011100_1011 : 10'b011100_0100 ;
            8'b000_01111: data_10b = (rd == 0) ?  10'b010111_0100 : 10'b101000_1011 ;
            8'b000_10000: data_10b = (rd == 0) ?  10'b011011_0100 : 10'b100100_1011 ;
            8'b000_10001: data_10b = (rd == 0) ?  10'b100011_1011 : 10'b100011_0100 ;
            8'b000_10010: data_10b = (rd == 0) ?  10'b010011_1011 : 10'b010011_0100 ;
            8'b000_10011: data_10b = (rd == 0) ?  10'b110010_1011 : 10'b110010_0100 ;
            8'b000_10100: data_10b = (rd == 0) ?  10'b001011_1011 : 10'b001011_0100 ;
            8'b000_10101: data_10b = (rd == 0) ?  10'b101010_1011 : 10'b101010_0100 ;
            8'b000_10110: data_10b = (rd == 0) ?  10'b011010_1011 : 10'b011010_0100 ;
            8'b000_10111: data_10b = (rd == 0) ?  10'b111010_0100 : 10'b000101_1011 ;
            8'b000_11000: data_10b = (rd == 0) ?  10'b110011_0100 : 10'b001100_1011 ;
            8'b000_11001: data_10b = (rd == 0) ?  10'b100110_1011 : 10'b100110_0100 ;
            8'b000_11010: data_10b = (rd == 0) ?  10'b010110_1011 : 10'b010110_0100 ;
            8'b000_11011: data_10b = (rd == 0) ?  10'b110110_0100 : 10'b001001_1011 ;
            8'b000_11100: data_10b = (rd == 0) ?  10'b001110_1011 : 10'b001110_0100 ;
            8'b000_11101: data_10b = (rd == 0) ?  10'b101110_0100 : 10'b010001_1011 ;
            8'b000_11110: data_10b = (rd == 0) ?  10'b011110_0100 : 10'b100001_1011 ;
            8'b000_11111: data_10b = (rd == 0) ?  10'b101011_0100 : 10'b010100_1011 ;
            8'b001_00000: data_10b = (rd == 0) ?  10'b100111_1001 : 10'b011000_1001 ;
            8'b001_00001: data_10b = (rd == 0) ?  10'b011101_1001 : 10'b100010_1001 ;
            8'b001_00010: data_10b = (rd == 0) ?  10'b101101_1001 : 10'b010010_1001 ;
            8'b001_00011: data_10b = (rd == 0) ?  10'b110001_1001 : 10'b110001_1001 ;
            8'b001_00100: data_10b = (rd == 0) ?  10'b110101_1001 : 10'b001010_1001 ;
            8'b001_00101: data_10b = (rd == 0) ?  10'b101001_1001 : 10'b101001_1001 ;
            8'b001_00110: data_10b = (rd == 0) ?  10'b011001_1001 : 10'b011001_1001 ;
            8'b001_00111: data_10b = (rd == 0) ?  10'b111000_1001 : 10'b000111_1001 ;
            8'b001_01000: data_10b = (rd == 0) ?  10'b111001_1001 : 10'b000110_1001 ;
            8'b001_01001: data_10b = (rd == 0) ?  10'b100101_1001 : 10'b100101_1001 ;
            8'b001_01010: data_10b = (rd == 0) ?  10'b010101_1001 : 10'b010101_1001 ;
            8'b001_01011: data_10b = (rd == 0) ?  10'b110100_1001 : 10'b110100_1001 ;
            8'b001_01100: data_10b = (rd == 0) ?  10'b001101_1001 : 10'b001101_1001 ;
            8'b001_01101: data_10b = (rd == 0) ?  10'b101100_1001 : 10'b101100_1001 ;
            8'b001_01110: data_10b = (rd == 0) ?  10'b011100_1001 : 10'b011100_1001 ;
            8'b001_01111: data_10b = (rd == 0) ?  10'b010111_1001 : 10'b101000_1001 ;
            8'b001_10000: data_10b = (rd == 0) ?  10'b011011_1001 : 10'b100100_1001 ;
            8'b001_10001: data_10b = (rd == 0) ?  10'b100011_1001 : 10'b100011_1001 ;
            8'b001_10010: data_10b = (rd == 0) ?  10'b010011_1001 : 10'b010011_1001 ;
            8'b001_10011: data_10b = (rd == 0) ?  10'b110010_1001 : 10'b110010_1001 ;
            8'b001_10100: data_10b = (rd == 0) ?  10'b001011_1001 : 10'b001011_1001 ;
            8'b001_10101: data_10b = (rd == 0) ?  10'b101010_1001 : 10'b101010_1001 ;
            8'b001_10110: data_10b = (rd == 0) ?  10'b011010_1001 : 10'b011010_1001 ;
            8'b001_10111: data_10b = (rd == 0) ?  10'b111010_1001 : 10'b000101_1001 ;
            8'b001_11000: data_10b = (rd == 0) ?  10'b110011_1001 : 10'b001100_1001 ;
            8'b001_11001: data_10b = (rd == 0) ?  10'b100110_1001 : 10'b100110_1001 ;
            8'b001_11010: data_10b = (rd == 0) ?  10'b010110_1001 : 10'b010110_1001 ;
            8'b001_11011: data_10b = (rd == 0) ?  10'b110110_1001 : 10'b001001_1001 ;
            8'b001_11100: data_10b = (rd == 0) ?  10'b001110_1001 : 10'b001110_1001 ;
            8'b001_11101: data_10b = (rd == 0) ?  10'b101110_1001 : 10'b010001_1001 ;
            8'b001_11110: data_10b = (rd == 0) ?  10'b011110_1001 : 10'b100001_1001 ;
            8'b001_11111: data_10b = (rd == 0) ?  10'b101011_1001 : 10'b010100_1001 ;
            8'b010_00000: data_10b = (rd == 0) ?  10'b100111_0101 : 10'b011000_0101 ;
            8'b010_00001: data_10b = (rd == 0) ?  10'b011101_0101 : 10'b100010_0101 ;
            8'b010_00010: data_10b = (rd == 0) ?  10'b101101_0101 : 10'b010010_0101 ;
            8'b010_00011: data_10b = (rd == 0) ?  10'b110001_0101 : 10'b110001_0101 ;
            8'b010_00100: data_10b = (rd == 0) ?  10'b110101_0101 : 10'b001010_0101 ;
            8'b010_00101: data_10b = (rd == 0) ?  10'b101001_0101 : 10'b101001_0101 ;
            8'b010_00110: data_10b = (rd == 0) ?  10'b011001_0101 : 10'b011001_0101 ;
            8'b010_00111: data_10b = (rd == 0) ?  10'b111000_0101 : 10'b000111_0101 ;
            8'b010_01000: data_10b = (rd == 0) ?  10'b111001_0101 : 10'b000110_0101 ;
            8'b010_01001: data_10b = (rd == 0) ?  10'b100101_0101 : 10'b100101_0101 ;
            8'b010_01010: data_10b = (rd == 0) ?  10'b010101_0101 : 10'b010101_0101 ;
            8'b010_01011: data_10b = (rd == 0) ?  10'b110100_0101 : 10'b110100_0101 ;
            8'b010_01100: data_10b = (rd == 0) ?  10'b001101_0101 : 10'b001101_0101 ;
            8'b010_01101: data_10b = (rd == 0) ?  10'b101100_0101 : 10'b101100_0101 ;
            8'b010_01110: data_10b = (rd == 0) ?  10'b011100_0101 : 10'b011100_0101 ;
            8'b010_01111: data_10b = (rd == 0) ?  10'b010111_0101 : 10'b101000_0101 ;
            8'b010_10000: data_10b = (rd == 0) ?  10'b011011_0101 : 10'b100100_0101 ;
            8'b010_10001: data_10b = (rd == 0) ?  10'b100011_0101 : 10'b100011_0101 ;
            8'b010_10010: data_10b = (rd == 0) ?  10'b010011_0101 : 10'b010011_0101 ;
            8'b010_10011: data_10b = (rd == 0) ?  10'b110010_0101 : 10'b110010_0101 ;
            8'b010_10100: data_10b = (rd == 0) ?  10'b001011_0101 : 10'b001011_0101 ;
            8'b010_10101: data_10b = (rd == 0) ?  10'b101010_0101 : 10'b101010_0101 ;
            8'b010_10110: data_10b = (rd == 0) ?  10'b011010_0101 : 10'b011010_0101 ;
            8'b010_10111: data_10b = (rd == 0) ?  10'b111010_0101 : 10'b000101_0101 ;
            8'b010_11000: data_10b = (rd == 0) ?  10'b110011_0101 : 10'b001100_0101 ;
            8'b010_11001: data_10b = (rd == 0) ?  10'b100110_0101 : 10'b100110_0101 ;
            8'b010_11010: data_10b = (rd == 0) ?  10'b010110_0101 : 10'b010110_0101 ;
            8'b010_11011: data_10b = (rd == 0) ?  10'b110110_0101 : 10'b001001_0101 ;
            8'b010_11100: data_10b = (rd == 0) ?  10'b001110_0101 : 10'b001110_0101 ;
            8'b010_11101: data_10b = (rd == 0) ?  10'b101110_0101 : 10'b010001_0101 ;
            8'b010_11110: data_10b = (rd == 0) ?  10'b011110_0101 : 10'b100001_0101 ;
            8'b010_11111: data_10b = (rd == 0) ?  10'b101011_0101 : 10'b010100_0101 ;
            8'b011_00000: data_10b = (rd == 0) ?  10'b100111_0011 : 10'b011000_1100 ;
            8'b011_00001: data_10b = (rd == 0) ?  10'b011101_0011 : 10'b100010_1100 ;
            8'b011_00010: data_10b = (rd == 0) ?  10'b101101_0011 : 10'b010010_1100 ;
            8'b011_00011: data_10b = (rd == 0) ?  10'b110001_1100 : 10'b110001_0011 ;
            8'b011_00100: data_10b = (rd == 0) ?  10'b110101_0011 : 10'b001010_1100 ;
            8'b011_00101: data_10b = (rd == 0) ?  10'b101001_1100 : 10'b101001_0011 ;
            8'b011_00110: data_10b = (rd == 0) ?  10'b011001_1100 : 10'b011001_0011 ;
            8'b011_00111: data_10b = (rd == 0) ?  10'b111000_1100 : 10'b000111_0011 ;
            8'b011_01000: data_10b = (rd == 0) ?  10'b111001_0011 : 10'b000110_1100 ;
            8'b011_01001: data_10b = (rd == 0) ?  10'b100101_1100 : 10'b100101_0011 ;
            8'b011_01010: data_10b = (rd == 0) ?  10'b010101_1100 : 10'b010101_0011 ;
            8'b011_01011: data_10b = (rd == 0) ?  10'b110100_1100 : 10'b110100_0011 ;
            8'b011_01100: data_10b = (rd == 0) ?  10'b001101_1100 : 10'b001101_0011 ;
            8'b011_01101: data_10b = (rd == 0) ?  10'b101100_1100 : 10'b101100_0011 ;
            8'b011_01110: data_10b = (rd == 0) ?  10'b011100_1100 : 10'b011100_0011 ;
            8'b011_01111: data_10b = (rd == 0) ?  10'b010111_0011 : 10'b101000_1100 ;
            8'b011_10000: data_10b = (rd == 0) ?  10'b011011_0011 : 10'b100100_1100 ;
            8'b011_10001: data_10b = (rd == 0) ?  10'b100011_1100 : 10'b100011_0011 ;
            8'b011_10010: data_10b = (rd == 0) ?  10'b010011_1100 : 10'b010011_0011 ;
            8'b011_10011: data_10b = (rd == 0) ?  10'b110010_1100 : 10'b110010_0011 ;
            8'b011_10100: data_10b = (rd == 0) ?  10'b001011_1100 : 10'b001011_0011 ;
            8'b011_10101: data_10b = (rd == 0) ?  10'b101010_1100 : 10'b101010_0011 ;
            8'b011_10110: data_10b = (rd == 0) ?  10'b011010_1100 : 10'b011010_0011 ;
            8'b011_10111: data_10b = (rd == 0) ?  10'b111010_0011 : 10'b000101_1100 ;
            8'b011_11000: data_10b = (rd == 0) ?  10'b110011_0011 : 10'b001100_1100 ;
            8'b011_11001: data_10b = (rd == 0) ?  10'b100110_1100 : 10'b100110_0011 ;
            8'b011_11010: data_10b = (rd == 0) ?  10'b010110_1100 : 10'b010110_0011 ;
            8'b011_11011: data_10b = (rd == 0) ?  10'b110110_0011 : 10'b001001_1100 ;
            8'b011_11100: data_10b = (rd == 0) ?  10'b001110_1100 : 10'b001110_0011 ;
            8'b011_11101: data_10b = (rd == 0) ?  10'b101110_0011 : 10'b010001_1100 ;
            8'b011_11110: data_10b = (rd == 0) ?  10'b011110_0011 : 10'b100001_1100 ;
            8'b011_11111: data_10b = (rd == 0) ?  10'b101011_0011 : 10'b010100_1100 ;
            8'b100_00000: data_10b = (rd == 0) ?  10'b100111_0010 : 10'b011000_1101 ;
            8'b100_00001: data_10b = (rd == 0) ?  10'b011101_0010 : 10'b100010_1101 ;
            8'b100_00010: data_10b = (rd == 0) ?  10'b101101_0010 : 10'b010010_1101 ;
            8'b100_00011: data_10b = (rd == 0) ?  10'b110001_1101 : 10'b110001_0010 ;
            8'b100_00100: data_10b = (rd == 0) ?  10'b110101_0010 : 10'b001010_1101 ;
            8'b100_00101: data_10b = (rd == 0) ?  10'b101001_1101 : 10'b101001_0010 ;
            8'b100_00110: data_10b = (rd == 0) ?  10'b011001_1101 : 10'b011001_0010 ;
            8'b100_00111: data_10b = (rd == 0) ?  10'b111000_1101 : 10'b000111_0010 ;
            8'b100_01000: data_10b = (rd == 0) ?  10'b111001_0010 : 10'b000110_1101 ;
            8'b100_01001: data_10b = (rd == 0) ?  10'b100101_1101 : 10'b100101_0010 ;
            8'b100_01010: data_10b = (rd == 0) ?  10'b010101_1101 : 10'b010101_0010 ;
            8'b100_01011: data_10b = (rd == 0) ?  10'b110100_1101 : 10'b110100_0010 ;
            8'b100_01100: data_10b = (rd == 0) ?  10'b001101_1101 : 10'b001101_0010 ;
            8'b100_01101: data_10b = (rd == 0) ?  10'b101100_1101 : 10'b101100_0010 ;
            8'b100_01110: data_10b = (rd == 0) ?  10'b011100_1101 : 10'b011100_0010 ;
            8'b100_01111: data_10b = (rd == 0) ?  10'b010111_0010 : 10'b101000_1101 ;
            8'b100_10000: data_10b = (rd == 0) ?  10'b011011_0010 : 10'b100100_1101 ;
            8'b100_10001: data_10b = (rd == 0) ?  10'b100011_1101 : 10'b100011_0010 ;
            8'b100_10010: data_10b = (rd == 0) ?  10'b010011_1101 : 10'b010011_0010 ;
            8'b100_10011: data_10b = (rd == 0) ?  10'b110010_1101 : 10'b110010_0010 ;
            8'b100_10100: data_10b = (rd == 0) ?  10'b001011_1101 : 10'b001011_0010 ;
            8'b100_10101: data_10b = (rd == 0) ?  10'b101010_1101 : 10'b101010_0010 ;
            8'b100_10110: data_10b = (rd == 0) ?  10'b011010_1101 : 10'b011010_0010 ;
            8'b100_10111: data_10b = (rd == 0) ?  10'b111010_0010 : 10'b000101_1101 ;
            8'b100_11000: data_10b = (rd == 0) ?  10'b110011_0010 : 10'b001100_1101 ;
            8'b100_11001: data_10b = (rd == 0) ?  10'b100110_1101 : 10'b100110_0010 ;
            8'b100_11010: data_10b = (rd == 0) ?  10'b010110_1101 : 10'b010110_0010 ;
            8'b100_11011: data_10b = (rd == 0) ?  10'b110110_0010 : 10'b001001_1101 ;
            8'b100_11100: data_10b = (rd == 0) ?  10'b001110_1101 : 10'b001110_0010 ;
            8'b100_11101: data_10b = (rd == 0) ?  10'b101110_0010 : 10'b010001_1101 ;
            8'b100_11110: data_10b = (rd == 0) ?  10'b011110_0010 : 10'b100001_1101 ;
            8'b100_11111: data_10b = (rd == 0) ?  10'b101011_0010 : 10'b010100_1101 ;
            8'b101_00000: data_10b = (rd == 0) ?  10'b100111_1010 : 10'b011000_1010 ;
            8'b101_00001: data_10b = (rd == 0) ?  10'b011101_1010 : 10'b100010_1010 ;
            8'b101_00010: data_10b = (rd == 0) ?  10'b101101_1010 : 10'b010010_1010 ;
            8'b101_00011: data_10b = (rd == 0) ?  10'b110001_1010 : 10'b110001_1010 ;
            8'b101_00100: data_10b = (rd == 0) ?  10'b110101_1010 : 10'b001010_1010 ;
            8'b101_00101: data_10b = (rd == 0) ?  10'b101001_1010 : 10'b101001_1010 ;
            8'b101_00110: data_10b = (rd == 0) ?  10'b011001_1010 : 10'b011001_1010 ;
            8'b101_00111: data_10b = (rd == 0) ?  10'b111000_1010 : 10'b000111_1010 ;
            8'b101_01000: data_10b = (rd == 0) ?  10'b111001_1010 : 10'b000110_1010 ;
            8'b101_01001: data_10b = (rd == 0) ?  10'b100101_1010 : 10'b100101_1010 ;
            8'b101_01010: data_10b = (rd == 0) ?  10'b010101_1010 : 10'b010101_1010 ;
            8'b101_01011: data_10b = (rd == 0) ?  10'b110100_1010 : 10'b110100_1010 ;
            8'b101_01100: data_10b = (rd == 0) ?  10'b001101_1010 : 10'b001101_1010 ;
            8'b101_01101: data_10b = (rd == 0) ?  10'b101100_1010 : 10'b101100_1010 ;
            8'b101_01110: data_10b = (rd == 0) ?  10'b011100_1010 : 10'b011100_1010 ;
            8'b101_01111: data_10b = (rd == 0) ?  10'b010111_1010 : 10'b101000_1010 ;
            8'b101_10000: data_10b = (rd == 0) ?  10'b011011_1010 : 10'b100100_1010 ;
            8'b101_10001: data_10b = (rd == 0) ?  10'b100011_1010 : 10'b100011_1010 ;
            8'b101_10010: data_10b = (rd == 0) ?  10'b010011_1010 : 10'b010011_1010 ;
            8'b101_10011: data_10b = (rd == 0) ?  10'b110010_1010 : 10'b110010_1010 ;
            8'b101_10100: data_10b = (rd == 0) ?  10'b001011_1010 : 10'b001011_1010 ;
            8'b101_10101: data_10b = (rd == 0) ?  10'b101010_1010 : 10'b101010_1010 ;
            8'b101_10110: data_10b = (rd == 0) ?  10'b011010_1010 : 10'b011010_1010 ;
            8'b101_10111: data_10b = (rd == 0) ?  10'b111010_1010 : 10'b000101_1010 ;
            8'b101_11000: data_10b = (rd == 0) ?  10'b110011_1010 : 10'b001100_1010 ;
            8'b101_11001: data_10b = (rd == 0) ?  10'b100110_1010 : 10'b100110_1010 ;
            8'b101_11010: data_10b = (rd == 0) ?  10'b010110_1010 : 10'b010110_1010 ;
            8'b101_11011: data_10b = (rd == 0) ?  10'b110110_1010 : 10'b001001_1010 ;
            8'b101_11100: data_10b = (rd == 0) ?  10'b001110_1010 : 10'b001110_1010 ;
            8'b101_11101: data_10b = (rd == 0) ?  10'b101110_1010 : 10'b010001_1010 ;
            8'b101_11110: data_10b = (rd == 0) ?  10'b011110_1010 : 10'b100001_1010 ;
            8'b101_11111: data_10b = (rd == 0) ?  10'b101011_1010 : 10'b010100_1010 ;
            8'b110_00000: data_10b = (rd == 0) ?  10'b100111_0110 : 10'b011000_0110 ;
            8'b110_00001: data_10b = (rd == 0) ?  10'b011101_0110 : 10'b100010_0110 ;
            8'b110_00010: data_10b = (rd == 0) ?  10'b101101_0110 : 10'b010010_0110 ;
            8'b110_00011: data_10b = (rd == 0) ?  10'b110001_0110 : 10'b110001_0110 ;
            8'b110_00100: data_10b = (rd == 0) ?  10'b110101_0110 : 10'b001010_0110 ;
            8'b110_00101: data_10b = (rd == 0) ?  10'b101001_0110 : 10'b101001_0110 ;
            8'b110_00110: data_10b = (rd == 0) ?  10'b011001_0110 : 10'b011001_0110 ;
            8'b110_00111: data_10b = (rd == 0) ?  10'b111000_0110 : 10'b000111_0110 ;
            8'b110_01000: data_10b = (rd == 0) ?  10'b111001_0110 : 10'b000110_0110 ;
            8'b110_01001: data_10b = (rd == 0) ?  10'b100101_0110 : 10'b100101_0110 ;
            8'b110_01010: data_10b = (rd == 0) ?  10'b010101_0110 : 10'b010101_0110 ;
            8'b110_01011: data_10b = (rd == 0) ?  10'b110100_0110 : 10'b110100_0110 ;
            8'b110_01100: data_10b = (rd == 0) ?  10'b001101_0110 : 10'b001101_0110 ;
            8'b110_01101: data_10b = (rd == 0) ?  10'b101100_0110 : 10'b101100_0110 ;
            8'b110_01110: data_10b = (rd == 0) ?  10'b011100_0110 : 10'b011100_0110 ;
            8'b110_01111: data_10b = (rd == 0) ?  10'b010111_0110 : 10'b101000_0110 ;
            8'b110_10000: data_10b = (rd == 0) ?  10'b011011_0110 : 10'b100100_0110 ;
            8'b110_10001: data_10b = (rd == 0) ?  10'b100011_0110 : 10'b100011_0110 ;
            8'b110_10010: data_10b = (rd == 0) ?  10'b010011_0110 : 10'b010011_0110 ;
            8'b110_10011: data_10b = (rd == 0) ?  10'b110010_0110 : 10'b110010_0110 ;
            8'b110_10100: data_10b = (rd == 0) ?  10'b001011_0110 : 10'b001011_0110 ;
            8'b110_10101: data_10b = (rd == 0) ?  10'b101010_0110 : 10'b101010_0110 ;
            8'b110_10110: data_10b = (rd == 0) ?  10'b011010_0110 : 10'b011010_0110 ;
            8'b110_10111: data_10b = (rd == 0) ?  10'b111010_0110 : 10'b000101_0110 ;
            8'b110_11000: data_10b = (rd == 0) ?  10'b110011_0110 : 10'b001100_0110 ;
            8'b110_11001: data_10b = (rd == 0) ?  10'b100110_0110 : 10'b100110_0110 ;
            8'b110_11010: data_10b = (rd == 0) ?  10'b010110_0110 : 10'b010110_0110 ;
            8'b110_11011: data_10b = (rd == 0) ?  10'b110110_0110 : 10'b001001_0110 ;
            8'b110_11100: data_10b = (rd == 0) ?  10'b001110_0110 : 10'b001110_0110 ;
            8'b110_11101: data_10b = (rd == 0) ?  10'b101110_0110 : 10'b010001_0110 ;
            8'b110_11110: data_10b = (rd == 0) ?  10'b011110_0110 : 10'b100001_0110 ;
            8'b110_11111: data_10b = (rd == 0) ?  10'b101011_0110 : 10'b010100_0110 ;
            8'b111_00000: data_10b = (rd == 0) ?  10'b100111_0001 : 10'b011000_1110 ;
            8'b111_00001: data_10b = (rd == 0) ?  10'b011101_0001 : 10'b100010_1110 ;
            8'b111_00010: data_10b = (rd == 0) ?  10'b101101_0001 : 10'b010010_1110 ;
            8'b111_00011: data_10b = (rd == 0) ?  10'b110001_1110 : 10'b110001_0001 ;
            8'b111_00100: data_10b = (rd == 0) ?  10'b110101_0001 : 10'b001010_1110 ;
            8'b111_00101: data_10b = (rd == 0) ?  10'b101001_1110 : 10'b101001_0001 ;
            8'b111_00110: data_10b = (rd == 0) ?  10'b011001_1110 : 10'b011001_0001 ;
            8'b111_00111: data_10b = (rd == 0) ?  10'b111000_1110 : 10'b000111_0001 ;
            8'b111_01000: data_10b = (rd == 0) ?  10'b111001_0001 : 10'b000110_1110 ;
            8'b111_01001: data_10b = (rd == 0) ?  10'b100101_1110 : 10'b100101_0001 ;
            8'b111_01010: data_10b = (rd == 0) ?  10'b010101_1110 : 10'b010101_0001 ;
            8'b111_01011: data_10b = (rd == 0) ?  10'b110100_1110 : 10'b110100_1000 ;
            8'b111_01100: data_10b = (rd == 0) ?  10'b001101_1110 : 10'b001101_0001 ;
            8'b111_01101: data_10b = (rd == 0) ?  10'b101100_1110 : 10'b101100_1000 ;
            8'b111_01110: data_10b = (rd == 0) ?  10'b011100_1110 : 10'b011100_1000 ;
            8'b111_01111: data_10b = (rd == 0) ?  10'b010111_0001 : 10'b101000_1110 ;
            8'b111_10000: data_10b = (rd == 0) ?  10'b011011_0001 : 10'b100100_1110 ;
            8'b111_10001: data_10b = (rd == 0) ?  10'b100011_0111 : 10'b100011_0001 ;
            8'b111_10010: data_10b = (rd == 0) ?  10'b010011_0111 : 10'b010011_0001 ;
            8'b111_10011: data_10b = (rd == 0) ?  10'b110010_1110 : 10'b110010_0001 ;
            8'b111_10100: data_10b = (rd == 0) ?  10'b001011_0111 : 10'b001011_0001 ;
            8'b111_10101: data_10b = (rd == 0) ?  10'b101010_1110 : 10'b101010_0001 ;
            8'b111_10110: data_10b = (rd == 0) ?  10'b011010_1110 : 10'b011010_0001 ;
            8'b111_10111: data_10b = (rd == 0) ?  10'b111010_0001 : 10'b000101_1110 ;
            8'b111_11000: data_10b = (rd == 0) ?  10'b110011_0001 : 10'b001100_1110 ;
            8'b111_11001: data_10b = (rd == 0) ?  10'b100110_1110 : 10'b100110_0001 ;
            8'b111_11010: data_10b = (rd == 0) ?  10'b010110_1110 : 10'b010110_0001 ;
            8'b111_11011: data_10b = (rd == 0) ?  10'b110110_0001 : 10'b001001_1110 ;
            8'b111_11100: data_10b = (rd == 0) ?  10'b001110_1110 : 10'b001110_0001 ;
            8'b111_11101: data_10b = (rd == 0) ?  10'b101110_0001 : 10'b010001_1110 ;
            8'b111_11110: data_10b = (rd == 0) ?  10'b011110_0001 : 10'b100001_1110 ;
            8'b111_11111: data_10b = (rd == 0) ?  10'b101011_0001 : 10'b010100_1110 ;
        endcase
    end else begin
        case(data_8b)//K_code
            8'b000_11100: data_10b = (rd == 0) ? 10'b001111_0100 : 10'b110000_1011 ;
            8'b001_11100: data_10b = (rd == 0) ? 10'b001111_1001 : 10'b110000_0110 ;
            8'b010_11100: data_10b = (rd == 0) ? 10'b001111_0101 : 10'b110000_1010 ;
            8'b011_11100: data_10b = (rd == 0) ? 10'b001111_0011 : 10'b110000_1100 ;
            8'b100_11100: data_10b = (rd == 0) ? 10'b001111_0010 : 10'b110000_1101 ;
            8'b101_11100: data_10b = (rd == 0) ? 10'b001111_1010 : 10'b110000_0101 ;
            8'b110_11100: data_10b = (rd == 0) ? 10'b001111_0110 : 10'b110000_1001 ;
            8'b111_11100: data_10b = (rd == 0) ? 10'b001111_1000 : 10'b110000_0111 ;
            8'b111_10111: data_10b = (rd == 0) ? 10'b111010_1000 : 10'b000101_0111 ;
            8'b111_11011: data_10b = (rd == 0) ? 10'b110110_1000 : 10'b001001_0111 ;
            8'b111_11101: data_10b = (rd == 0) ? 10'b101110_1000 : 10'b010001_0111 ;
            8'b111_11110: data_10b = (rd == 0) ? 10'b011110_1000 : 10'b100001_0111 ; 
        default:
         begin
            data_10b= (rd == 0) ? 10'b001111_0010: 10'b110000_1101;
            `uvm_error(get_name(),$psprintf("NO SUCH K CODE!!PLEASE CHECK!!"))

         end
        endcase
    end
    data_10b = big_endian_transfer_byte(1,data_10b,10);
    if($countones(data_10b)==5) begin
        o_rd = rd;
    end else begin
        o_rd = ~rd;
    end
    return data_10b ;
/*}}}*/
endfunction

// GF(2^8) 乘法函数 (使用对数表)
function bit[7:0] cdn_phy_driver_base::gf_mult(bit[7:0] a, bit[7:0] b);
   // 寄存器初始化 (存储中间校验值)
    int idx_a ; 
    int idx_b ;
    int idx_sum ; // 模255运算
    int ex_value ; 
 
    // 预计算 GF(2^8) 乘法表
    bit[7:0] exp_table[256], log_table[256];
    
    // 初始化指数表 exp_table[i] = α^i
    exp_table[0] = 1; //a^0 = 1
    for (int i = 1; i < 256; i++) begin
        exp_table[i] = exp_table[i-1] << 1; // 乘以α (左移1位)
        if (exp_table[i-1] & 8'h80) begin   // 检查高位溢出
            exp_table[i] ^= 8'h1D; // 异或本原多项式 (0x1D)
        end
    end
    exp_table[255] = 1; // α^255 = 1
       //for(int i = 0; i< 256; i++) begin
       // `uvm_info(get_name(), $psprintf("exp table print exp[%0d] is %0d",i,exp_table[i]), UVM_LOW)
       // end
 
    // 初始化对数表 log_table[α^i] = i
    for (int i = 0; i < 256; i++) log_table[i] = 0; // 初始化0
    for (int i = 0; i < 256; i++) begin
        //ex_value = exp_table[i];
        log_table[exp_table[i]] = i;
    end
       //for(int i = 0; i< 256; i++) begin
       // `uvm_info(get_name(), $psprintf("log table print log[%0d] is %0d",i,log_table[i]), UVM_LOW)
       // end
 
        if (a == 0 || b == 0) return 0;
        idx_a = log_table[a];
        idx_b = log_table[b];
        idx_sum = (idx_a + idx_b) % 255; // 模255运算
        
        return exp_table[idx_sum];
endfunction
 

function void cdn_phy_driver_base::rs_fec_encode(
    input  bit[7:0] data_in[194],  // 输入数据 (194 bytes)
    output bit[7:0] data_out[198]  // 输出数据 (194 bytes data + 4 bytes parity)
);
    // GF(2^8) 本原多项式: x^8 + x^4 + x^3 + x^2 + 1 (0x11D)
    // 生成多项式: x^4 + 15x^3 + 54x^2 + 120x + 64
    // 系数常量定义
    localparam byte G4 = 1;  // x^4 系数
    localparam byte G3 = 15; // x^3 系数
    localparam byte G2 = 54; // x^2 系数
    localparam byte G1 = 120; // x 系数
    localparam byte G0 = 64;  // 常数项系数
 
    // 寄存器初始化 (存储中间校验值)
    bit[7:0] r0 = 0, r1 = 0, r2 = 0, r3 = 0;
    bit[7:0] feedback;
 
 
    // 编码核心逻辑
    for (int i = 0; i < 194; i++) begin
        feedback = data_in[i] ^ r0;  // 反馈值计算
        $display("feedback is %d",feedback); 
        // 更新寄存器 (多项式除法步骤)
        r0 = r1 ^ gf_mult(feedback, G3);
        r1 = r2 ^ gf_mult(feedback, G2);
        r2 = r3 ^ gf_mult(feedback, G1);
        r3 = gf_mult(feedback, G0);
    end
 
    // 输出构建: 原始数据 + 校验字节
    foreach (data_in[i]) data_out[i] = data_in[i]; // 前194字节
    data_out[194] = r0; // 校验字节0 (x^3 系数)
    data_out[195] = r1; // 校验字节1 (x^2 系数)
    data_out[196] = r2; // 校验字节2 (x 系数)
    data_out[197] = r3; // 校验字节3 (常数项)
endfunction

task cdn_phy_driver_base::set_refclk_pins();
   // TODO base on protocal, and ref clk
   m_vif.pipe_intf.pma_cmn_refclk_dig_sel  = dut_cfg.refclk_dig_sel ;
   m_vif.pipe_intf.pma_cmn_refclk_dig_div  = dut_cfg.refclk_dig_div ;
   m_vif.pipe_intf.pma_cmn_pll0_refclk_sel = dut_cfg.pll0_refclk_sel;
   m_vif.pipe_intf.pma_cmn_pll1_refclk_sel = dut_cfg.pll1_refclk_sel;
endtask: set_refclk_pins

task cdn_phy_driver_base::set_phy_mode_pins();
   case(tb_cfg.std_mode)
     USB4_MODE: begin
       m_vif.pipe_intf.phy_mode = 4'b0111;
     end
     USB32_MODE: begin
       m_vif.pipe_intf.phy_mode = 4'b0001;
     end
     PCIE_MODE: begin
       // To be opened in future
     end
     DP_MODE: begin
       m_vif.pipe_intf.phy_mode = 4'b0110;
     end
     ALT_MODE: begin
       m_vif.pipe_intf.phy_mode = 4'b0101;
     end
     default: begin
       `uvm_fatal(get_full_name(), $sformatf("Invalid std_mode %s", tb_cfg.std_mode.name()))
     end
   endcase

   if(dut_cfg.flip_flag == POSITIVE) begin
     m_vif.pipe_intf.typec_conn_dir = 0;
   end else if(dut_cfg.flip_flag == NEGATIVE) begin
     m_vif.pipe_intf.typec_conn_dir = 1;
   end else begin
     `uvm_fatal(get_full_name(), $sformatf("Invalid flip_flag %s", dut_cfg.flip_flag.name()))
   end
endtask: set_phy_mode_pins

task cdn_phy_driver_base::set_data_width_pins();
   if(tb_cfg.std_mode == DP_MODE || tb_cfg.std_mode == ALT_MODE) begin
     if(dut_cfg.dp_data_rate inside {DP_RBR,DP_HBR,DP_HBR2,DP_HBR3}) begin
       m_vif.pipe_intf.pma_xcvr_data_width = 3'b101;
     end else if (dut_cfg.dp_data_rate inside {DP_UHBR10,DP_UHBR13P5,DP_UHBR20}) begin
       m_vif.pipe_intf.pma_xcvr_data_width = 3'b010;
     end else begin
       m_vif.pipe_intf.pma_xcvr_data_width = 3'b000;
       `uvm_fatal(get_full_name(), " The dp rate does not meet the constraints!")
     end
   end else begin
     m_vif.pipe_intf.pma_xcvr_data_width = 3'b000;
   end
endtask: set_data_width_pins

task cdn_phy_driver_base::set_pins_init_value();
   case(tb_cfg.std_mode)
     USB4_MODE: begin
       // used pins
       m_vif.pipe_intf.Reset             = 0;
       m_vif.pipe_intf.pipe7_clk_max_req = get_init_value();
       m_vif.pipe_intf.pipe7_pll0_en     = get_init_value();
	   m_vif.pipe_intf.M2P_MessageBus    = get_init_value();
       m_vif.pipe_intf.Rate              = get_init_value();
       m_vif.pipe_intf.RXTermination     = get_init_value();
       m_vif.pipe_intf.RxStandby         = get_init_value();
       m_vif.pipe_intf.PowerDown         = get_init_value();
       m_vif.pipe_intf.TxData            = get_init_value();
       m_vif.pipe_intf.TxDataValid       = get_init_value();
       m_vif.pipe_intf.TxDetectRx        = get_init_value();
       m_vif.pipe_intf.TxElecIdle        = get_init_value();
       // space pins
       m_vif.init_intf.Reset                 = 0;
       m_vif.init_intf.Rate                  = get_init_value();
       m_vif.init_intf.PowerDown             = get_init_value();
       m_vif.init_intf.pipe4_eb_mode         = get_init_value();
       m_vif.init_intf.pipe4_rx_polarity     = get_init_value();
       m_vif.init_intf.pipe4_rx_eq_training  = get_init_value();
       m_vif.init_intf.RXTermination         = get_init_value();
       m_vif.init_intf.TxData                = get_init_value();
       m_vif.init_intf.TxDataK               = get_init_value();
       m_vif.init_intf.TxSyncHeader          = get_init_value();
       m_vif.init_intf.TxStartBlock          = get_init_value();
       m_vif.init_intf.TxDataValid           = get_init_value();
       m_vif.init_intf.TxDetectRx            = get_init_value();
       m_vif.init_intf.TxElecIdle            = get_init_value();
       m_vif.init_intf.pipe4_tx_ones_zeros   = get_init_value();
       m_vif.init_intf.pipe4_tx_128b_enc_byp = get_init_value();
       m_vif.init_intf.pipe4_tx_deemph       = get_init_value();

       m_vif.init_intf.dp_reset_n               = 0;
       m_vif.init_intf.pma_xcvr_pllclk_en       = get_init_value();
       m_vif.init_intf.pma_xcvr_power_state_req = get_init_value();
       m_vif.init_intf.pma_xcvr_data_width      = get_init_value();
       m_vif.init_intf.pma_tx_td_clk            = get_init_value();
       m_vif.init_intf.pma_tx_lfps_en           = get_init_value();
       m_vif.init_intf.pma_tx_lfps_mode         = get_init_value();
       m_vif.init_intf.pma_tx_elec_idle_ln      = get_init_value();
       m_vif.init_intf.pma_tx_td_ln             = get_init_value();
     end
     USB32_MODE: begin
       // used pins
       m_vif.pipe_intf.Reset                 = 0;
       m_vif.pipe_intf.Rate                  = get_init_value();
       m_vif.pipe_intf.PowerDown             = get_init_value();
       m_vif.pipe_intf.pipe4_eb_mode         = get_init_value();
       m_vif.pipe_intf.pipe4_rx_polarity     = get_init_value();
       m_vif.pipe_intf.pipe4_rx_eq_training  = get_init_value();
       m_vif.pipe_intf.RXTermination         = get_init_value();
       m_vif.pipe_intf.TxData                = get_init_value();
       m_vif.pipe_intf.TxDataK               = get_init_value();
       m_vif.pipe_intf.TxSyncHeader          = get_init_value();
       m_vif.pipe_intf.TxStartBlock          = get_init_value();
       m_vif.pipe_intf.TxDataValid           = get_init_value();
       m_vif.pipe_intf.TxDetectRx            = get_init_value();
       m_vif.pipe_intf.TxElecIdle            = get_init_value();
       m_vif.pipe_intf.pipe4_tx_ones_zeros   = get_init_value();
       m_vif.pipe_intf.pipe4_tx_128b_enc_byp = get_init_value();
       m_vif.pipe_intf.pipe4_tx_deemph       = get_init_value();
       // space pins
       m_vif.init_intf.Reset             = 0;
       m_vif.init_intf.pipe7_clk_max_req = get_init_value();
       m_vif.init_intf.pipe7_pll0_en     = get_init_value();
	   m_vif.init_intf.M2P_MessageBus    = get_init_value();
       m_vif.init_intf.Rate              = get_init_value();
       m_vif.init_intf.RXTermination     = get_init_value();
       m_vif.init_intf.RxStandby         = get_init_value();
       m_vif.init_intf.PowerDown         = get_init_value();
       m_vif.init_intf.TxData            = get_init_value();
       m_vif.init_intf.TxDataValid       = get_init_value();
       m_vif.init_intf.TxDetectRx        = get_init_value();
       m_vif.init_intf.TxElecIdle        = get_init_value();

       m_vif.init_intf.dp_reset_n               = 0;
       m_vif.init_intf.pma_xcvr_pllclk_en       = get_init_value();
       m_vif.init_intf.pma_xcvr_power_state_req = get_init_value();
       m_vif.init_intf.pma_xcvr_data_width      = get_init_value();
       m_vif.init_intf.pma_tx_td_clk            = get_init_value();
       m_vif.init_intf.pma_tx_lfps_en           = get_init_value();
       m_vif.init_intf.pma_tx_lfps_mode         = get_init_value();
       m_vif.init_intf.pma_tx_elec_idle_ln      = get_init_value();
       m_vif.init_intf.pma_tx_td_ln             = get_init_value();
     end
     PCIE_MODE: begin
       // used pins
       m_vif.pipe_intf.Reset                 = 0;
       m_vif.pipe_intf.Rate                  = get_init_value();
       m_vif.pipe_intf.PowerDown             = get_init_value();
       m_vif.pipe_intf.pipe4_eb_mode         = get_init_value();
       m_vif.pipe_intf.pipe4_rx_polarity     = get_init_value();
       m_vif.pipe_intf.pipe4_rx_eq_training  = get_init_value();
       m_vif.pipe_intf.RXTermination         = get_init_value();
       m_vif.pipe_intf.TxData                = get_init_value();
       m_vif.pipe_intf.TxDataK               = get_init_value();
       m_vif.pipe_intf.TxSyncHeader          = get_init_value();
       m_vif.pipe_intf.TxStartBlock          = get_init_value();
       m_vif.pipe_intf.TxDataValid           = get_init_value();
       m_vif.pipe_intf.TxDetectRx            = get_init_value();
       m_vif.pipe_intf.TxElecIdle            = get_init_value();
       m_vif.pipe_intf.pipe4_tx_ones_zeros   = get_init_value();
       m_vif.pipe_intf.pipe4_tx_128b_enc_byp = get_init_value();
       m_vif.pipe_intf.pipe4_tx_deemph       = get_init_value();
       // space pins
       m_vif.init_intf.Reset             = 0;
       m_vif.init_intf.pipe7_clk_max_req = get_init_value();
       m_vif.init_intf.pipe7_pll0_en     = get_init_value();
       m_vif.init_intf.Rate              = get_init_value();
       m_vif.init_intf.RXTermination     = get_init_value();
       m_vif.init_intf.RxStandby         = get_init_value();
       m_vif.init_intf.PowerDown         = get_init_value();
       m_vif.init_intf.TxData            = get_init_value();
       m_vif.init_intf.TxDataValid       = get_init_value();
       m_vif.init_intf.TxDetectRx        = get_init_value();
       m_vif.init_intf.TxElecIdle        = get_init_value();

       m_vif.init_intf.dp_reset_n               = 0;
       m_vif.init_intf.pma_xcvr_pllclk_en       = get_init_value();
       m_vif.init_intf.pma_xcvr_power_state_req = get_init_value();
       m_vif.init_intf.pma_xcvr_data_width      = get_init_value();
       m_vif.init_intf.pma_tx_td_clk            = get_init_value();
       m_vif.init_intf.pma_tx_lfps_en           = get_init_value();
       m_vif.init_intf.pma_tx_lfps_mode         = get_init_value();
       m_vif.init_intf.pma_tx_elec_idle_ln      = get_init_value();
       m_vif.init_intf.pma_tx_td_ln             = get_init_value();
     end
     DP_MODE: begin
       // used pins
       m_vif.pipe_intf.dp_reset_n               = 0;
       m_vif.pipe_intf.pma_xcvr_pllclk_en       = get_init_value();
       m_vif.pipe_intf.pma_xcvr_power_state_req = get_init_value();
       //m_vif.pipe_intf.pma_xcvr_data_width      = get_init_value();
       m_vif.pipe_intf.pma_tx_td_clk            = get_init_value();
       m_vif.pipe_intf.pma_tx_lfps_en           = get_init_value();
       m_vif.pipe_intf.pma_tx_lfps_mode         = get_init_value();
       m_vif.pipe_intf.pma_tx_elec_idle_ln      = 1; //get_init_value();
       m_vif.pipe_intf.pma_tx_td_ln             = get_init_value();
       // space pins
       m_vif.init_intf.Reset             = 0;
       m_vif.init_intf.pipe7_clk_max_req = get_init_value();
       m_vif.init_intf.pipe7_pll0_en     = get_init_value();
	   m_vif.init_intf.M2P_MessageBus    = get_init_value();
       m_vif.init_intf.Rate              = get_init_value();
       m_vif.init_intf.RXTermination     = get_init_value();
       m_vif.init_intf.RxStandby         = get_init_value();
       m_vif.init_intf.PowerDown         = get_init_value();
       m_vif.init_intf.TxData            = get_init_value();
       m_vif.init_intf.TxDataValid       = get_init_value();
       m_vif.init_intf.TxDetectRx        = get_init_value();
       m_vif.init_intf.TxElecIdle        = get_init_value();

       m_vif.init_intf.Rate                  = get_init_value();
       m_vif.init_intf.PowerDown             = get_init_value();
       m_vif.init_intf.pipe4_eb_mode         = get_init_value();
       m_vif.init_intf.pipe4_rx_polarity     = get_init_value();
       m_vif.init_intf.pipe4_rx_eq_training  = get_init_value();
       m_vif.init_intf.RXTermination         = get_init_value();
       m_vif.init_intf.TxData                = get_init_value();
       m_vif.init_intf.TxDataK               = get_init_value();
       m_vif.init_intf.TxSyncHeader          = get_init_value();
       m_vif.init_intf.TxStartBlock          = get_init_value();
       m_vif.init_intf.TxDataValid           = get_init_value();
       m_vif.init_intf.TxDetectRx            = get_init_value();
       m_vif.init_intf.TxElecIdle            = get_init_value();
       m_vif.init_intf.pipe4_tx_ones_zeros   = get_init_value();
       m_vif.init_intf.pipe4_tx_128b_enc_byp = get_init_value();
       m_vif.init_intf.pipe4_tx_deemph       = get_init_value();
     end
     ALT_MODE: begin
       // used pins
       m_vif.pipe_intf.Reset                 = 0;
       m_vif.pipe_intf.dp_reset_n            = 0;
       m_vif.pipe_intf.Rate                  = get_init_value();
       m_vif.pipe_intf.PowerDown             = get_init_value();
       m_vif.pipe_intf.pipe4_eb_mode         = get_init_value();
       m_vif.pipe_intf.pipe4_rx_polarity     = get_init_value();
       m_vif.pipe_intf.pipe4_rx_eq_training  = get_init_value();
       m_vif.pipe_intf.RXTermination         = get_init_value();
       m_vif.pipe_intf.TxData                = get_init_value();
       m_vif.pipe_intf.TxDataK               = get_init_value();
       m_vif.pipe_intf.TxSyncHeader          = get_init_value();
       m_vif.pipe_intf.TxStartBlock          = get_init_value();
       m_vif.pipe_intf.TxDataValid           = get_init_value();
       m_vif.pipe_intf.TxDetectRx            = get_init_value();
       m_vif.pipe_intf.TxElecIdle            = get_init_value();
       m_vif.pipe_intf.pipe4_tx_ones_zeros   = get_init_value();
       m_vif.pipe_intf.pipe4_tx_128b_enc_byp = get_init_value();
       m_vif.pipe_intf.pipe4_tx_deemph       = get_init_value();

       m_vif.pipe_intf.pma_xcvr_pllclk_en       = get_init_value();
       m_vif.pipe_intf.pma_xcvr_power_state_req = get_init_value();
       //m_vif.pipe_intf.pma_xcvr_data_width      = get_init_value();
       m_vif.pipe_intf.pma_tx_td_clk            = get_init_value();
       m_vif.pipe_intf.pma_tx_lfps_en           = get_init_value();
       m_vif.pipe_intf.pma_tx_lfps_mode         = get_init_value();
       m_vif.pipe_intf.pma_tx_elec_idle_ln      = 1; //get_init_value();
       m_vif.pipe_intf.pma_tx_td_ln             = get_init_value();
       // space pins
       m_vif.init_intf.Reset             = 0;
       m_vif.init_intf.pipe7_clk_max_req = get_init_value();
       m_vif.init_intf.pipe7_pll0_en     = get_init_value();
	   m_vif.init_intf.M2P_MessageBus    = get_init_value();
       m_vif.init_intf.Rate              = get_init_value();
       m_vif.init_intf.RXTermination     = get_init_value();
       m_vif.init_intf.RxStandby         = get_init_value();
       m_vif.init_intf.PowerDown         = get_init_value();
       m_vif.init_intf.TxData            = get_init_value();
       m_vif.init_intf.TxDataValid       = get_init_value();
       m_vif.init_intf.TxDetectRx        = get_init_value();
       m_vif.init_intf.TxElecIdle        = get_init_value();

       m_vif.init_intf.pipe4_rx_polarity     = get_init_value();
       m_vif.init_intf.pipe4_rx_eq_training  = get_init_value();
       m_vif.init_intf.RXTermination         = get_init_value();
       m_vif.init_intf.TxData                = get_init_value();
       m_vif.init_intf.TxDataK               = get_init_value();
       m_vif.init_intf.TxSyncHeader          = get_init_value();
       m_vif.init_intf.TxStartBlock          = get_init_value();
       m_vif.init_intf.TxDataValid           = get_init_value();
       m_vif.init_intf.TxDetectRx            = get_init_value();
       m_vif.init_intf.TxElecIdle            = get_init_value();
       m_vif.init_intf.pipe4_tx_ones_zeros   = get_init_value();
       m_vif.init_intf.pipe4_tx_128b_enc_byp = get_init_value();
       m_vif.init_intf.pipe4_tx_deemph       = get_init_value();

       m_vif.init_intf.pma_tx_elec_idle_ln      = get_init_value();
       m_vif.init_intf.pma_tx_td_ln             = get_init_value();
     end
     default: begin
       `uvm_fatal(get_full_name(), $sformatf("Invalid std_mode %s", tb_cfg.std_mode.name()))
     end
   endcase
endtask: set_pins_init_value

function logic [63:0] cdn_phy_driver_base::get_init_value();
   logic [63:0] init_value;
   bit [1:0]    random_index;
   case(dut_cfg.init_value_type)
     ALL_0: begin
       init_value = 64'h0000_0000_0000_0000;
     end
     ALL_1: begin
       init_value = 64'hFFFF_FFFF_FFFF_FFFF;
     end
     ALL_X: begin
       init_value = 64'hXXXX_XXXX_XXXX_XXXX;
     end
     RANDOM_0_1: begin
       random_index = $urandom_range(0,1);
       case(random_index)
         0: begin
           init_value = 64'h0000_0000_0000_0000;
         end
         1: begin
           init_value = 64'hFFFF_FFFF_FFFF_FFFF;
         end
         default: begin
           `uvm_fatal(get_full_name(), $sformatf("init_value_type %s: Invalid random_index %0d", dut_cfg.init_value_type.name(), random_index))
         end
       endcase
     end
     RANDOM_0_X: begin
       random_index = $urandom_range(0,1);
       case(random_index)
         0: begin
           init_value = 64'h0000_0000_0000_0000;
         end
         1: begin
           init_value = 64'hXXXX_XXXX_XXXX_XXXX;
         end
         default: begin
           `uvm_fatal(get_full_name(), $sformatf("init_value_type %s: Invalid random_index %0d", dut_cfg.init_value_type.name(), random_index))
         end
       endcase

     end
     RANDOM_1_X: begin
       random_index = $urandom_range(0,1);
       case(random_index)
         0: begin
           init_value = 64'hFFFF_FFFF_FFFF_FFFF;
         end
         1: begin
           init_value = 64'hXXXX_XXXX_XXXX_XXXX;
         end
         default: begin
           `uvm_fatal(get_full_name(), $sformatf("init_value_type %s: Invalid random_index %0d", dut_cfg.init_value_type.name(), random_index))
         end
       endcase
     end
     RANDOM_0_1_X: begin
       random_index = $urandom_range(0,2);
       case(random_index)
         0: begin
           init_value = 64'h0000_0000_0000_0000;
         end
         1: begin
           init_value = 64'hFFFF_FFFF_FFFF_FFFF;
         end
         2: begin
           init_value = 64'hXXXX_XXXX_XXXX_XXXX;
         end
         default: begin
           `uvm_fatal(get_full_name(), $sformatf("init_value_type %s: Invalid random_index %0d", dut_cfg.init_value_type.name(), random_index))
         end
       endcase
     end
     default: begin
       `uvm_fatal(get_full_name(), $sformatf("Invalid init_value_type %s", dut_cfg.init_value_type.name()))
     end
   endcase

   return init_value;
endfunction: get_init_value


`endif // CDN_PHY_DRIVER_BASE__SV


