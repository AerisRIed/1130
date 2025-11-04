//
// Template for UVM-compliant physical-level monitor
//

`ifndef CDN_PHY_MONITOR_BASE__SV
`define CDN_PHY_MONITOR_BASE__SV


typedef class cdn_phy_transaction_base;
typedef class cdn_phy_monitor_base;

class cdn_phy_monitor_base_callbacks extends uvm_callback;

   // ToDo: Add additional relevant callbacks
   // ToDo: Use a task if callbacks can be blocking


   // Called at start of observed transaction
   virtual function void pre_trans(cdn_phy_monitor_base xactor,
                                   cdn_phy_transaction_base tr);
   endfunction: pre_trans


   // Called before acknowledging a transaction
   virtual function pre_ack(cdn_phy_monitor_base xactor,
                            cdn_phy_transaction_base tr);
   endfunction: pre_ack
   

   // Called at end of observed transaction
   virtual function void post_trans(cdn_phy_monitor_base xactor,
                                    cdn_phy_transaction_base tr);
   endfunction: post_trans

   
   // Callback method post_cb_trans can be used for coverage
   virtual task post_cb_trans(cdn_phy_monitor_base xactor,
                              cdn_phy_transaction_base tr);
   endtask: post_cb_trans

endclass: cdn_phy_monitor_base_callbacks

   

class cdn_phy_monitor_base extends uvm_monitor;

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

   //---------------------------------
   // TLM port
   //---------------------------------
   uvm_analysis_port #(cdn_phy_transaction_base) mon_analysis_port;  //TLM analysis port

   `uvm_register_cb(cdn_phy_monitor_base,cdn_phy_monitor_base_callbacks);

   //---------------------------------------
   // Factory 
   //---------------------------------------
   `uvm_component_utils_begin(cdn_phy_monitor_base)
      // ToDo: Add uvm monitor member if any class property added later through field macros

   `uvm_component_utils_end
      // ToDo: Add required short hand override method

   //---------------------------------
   // UVM functions and tasks
   //---------------------------------
   extern function new(string name = "cdn_phy_monitor_base",uvm_component parent);
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void end_of_elaboration_phase(uvm_phase phase);
   extern virtual function void start_of_simulation_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern virtual task reset_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   extern virtual function [7:0] scramble_lfsr16(input [7:0] data_in,input bit [15:0] lfsr,output bit[15:0] next_lfsr, input bit scramble_en=1,input bit advance_scramble=1);
   extern virtual function [7:0] scramble_lfsr23(input [7:0] data_in,input bit [22:0] lfsr,output bit[22:0] next_lfsr, input bit scramble_en=1);
   extern virtual function [8:0] datatrans_10b8b(input bit[9:0] data_10b);
   extern virtual function [31:0] big_endian_transfer_byte(input bit en,input bit[31:0] data_in,input int width);//big_endian transfer, can trans to LSB first

   //---------------------------------
   // User functions and tasks
   //---------------------------------
   //extern protected virtual task tx_monitor();

endclass: cdn_phy_monitor_base


function cdn_phy_monitor_base::new(string name = "cdn_phy_monitor_base",uvm_component parent);
   super.new(name, parent);
   //mon_analysis_port = new ("mon_analysis_port",this);
endfunction: new

function void cdn_phy_monitor_base::build_phase(uvm_phase phase);
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
   if (!uvm_config_db#(cdn_phy_vif_t)::get(this, "", "m_mon_if", m_vif)) begin
     `uvm_fatal(get_type_name(), "m_vif not set")
   end
endfunction: build_phase

function void cdn_phy_monitor_base::connect_phase(uvm_phase phase);
   super.connect_phase(phase);

endfunction: connect_phase

function void cdn_phy_monitor_base::end_of_elaboration_phase(uvm_phase phase);
   super.end_of_elaboration_phase(phase); 
   //ToDo: Implement this phase here

endfunction: end_of_elaboration_phase


function void cdn_phy_monitor_base::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);
   //ToDo: Implement this phase here

endfunction: start_of_simulation_phase


task cdn_phy_monitor_base::reset_phase(uvm_phase phase);
   super.reset_phase(phase);
   // ToDo: Implement reset here

endtask: reset_phase


task cdn_phy_monitor_base::configure_phase(uvm_phase phase);
   super.configure_phase(phase);
   //ToDo: Configure your component here
endtask:configure_phase


task cdn_phy_monitor_base::run_phase(uvm_phase phase);
   super.run_phase(phase);
  // phase.raise_objection(this,""); //Raise/drop objections in sequence file
   fork
      //tx_monitor();
   join
  // phase.drop_objection(this);

endtask: run_phase

function [8:0] cdn_phy_monitor_base::datatrans_10b8b(input bit [9:0] data_10b);
    bit[7:0] data_8b;
    bit K_code;
    data_10b = big_endian_transfer_byte(1,data_10b,10);
        case(data_10b)//D_code
            /*{{{*/
            10'b100111_0100 , 10'b011000_1011 :  begin data_8b = 8'b000_00000; K_code = 0; end
            10'b011101_0100 , 10'b100010_1011 :  begin data_8b = 8'b000_00001; K_code = 0; end
            10'b101101_0100 , 10'b010010_1011 :  begin data_8b = 8'b000_00010; K_code = 0; end
            10'b110001_1011 , 10'b110001_0100 :  begin data_8b = 8'b000_00011; K_code = 0; end
            10'b110101_0100 , 10'b001010_1011 :  begin data_8b = 8'b000_00100; K_code = 0; end
            10'b101001_1011 , 10'b101001_0100 :  begin data_8b = 8'b000_00101; K_code = 0; end
            10'b011001_1011 , 10'b011001_0100 :  begin data_8b = 8'b000_00110; K_code = 0; end
            10'b111000_1011 , 10'b000111_0100 :  begin data_8b = 8'b000_00111; K_code = 0; end
            10'b111001_0100 , 10'b000110_1011 :  begin data_8b = 8'b000_01000; K_code = 0; end
            10'b100101_1011 , 10'b100101_0100 :  begin data_8b = 8'b000_01001; K_code = 0; end
            10'b010101_1011 , 10'b010101_0100 :  begin data_8b = 8'b000_01010; K_code = 0; end
            10'b110100_1011 , 10'b110100_0100 :  begin data_8b = 8'b000_01011; K_code = 0; end
            10'b001101_1011 , 10'b001101_0100 :  begin data_8b = 8'b000_01100; K_code = 0; end
            10'b101100_1011 , 10'b101100_0100 :  begin data_8b = 8'b000_01101; K_code = 0; end
            10'b011100_1011 , 10'b011100_0100 :  begin data_8b = 8'b000_01110; K_code = 0; end
            10'b010111_0100 , 10'b101000_1011 :  begin data_8b = 8'b000_01111; K_code = 0; end
            10'b011011_0100 , 10'b100100_1011 :  begin data_8b = 8'b000_10000; K_code = 0; end
            10'b100011_1011 , 10'b100011_0100 :  begin data_8b = 8'b000_10001; K_code = 0; end
            10'b010011_1011 , 10'b010011_0100 :  begin data_8b = 8'b000_10010; K_code = 0; end
            10'b110010_1011 , 10'b110010_0100 :  begin data_8b = 8'b000_10011; K_code = 0; end
            10'b001011_1011 , 10'b001011_0100 :  begin data_8b = 8'b000_10100; K_code = 0; end
            10'b101010_1011 , 10'b101010_0100 :  begin data_8b = 8'b000_10101; K_code = 0; end
            10'b011010_1011 , 10'b011010_0100 :  begin data_8b = 8'b000_10110; K_code = 0; end
            10'b111010_0100 , 10'b000101_1011 :  begin data_8b = 8'b000_10111; K_code = 0; end
            10'b110011_0100 , 10'b001100_1011 :  begin data_8b = 8'b000_11000; K_code = 0; end
            10'b100110_1011 , 10'b100110_0100 :  begin data_8b = 8'b000_11001; K_code = 0; end
            10'b010110_1011 , 10'b010110_0100 :  begin data_8b = 8'b000_11010; K_code = 0; end
            10'b110110_0100 , 10'b001001_1011 :  begin data_8b = 8'b000_11011; K_code = 0; end
            10'b001110_1011 , 10'b001110_0100 :  begin data_8b = 8'b000_11100; K_code = 0; end
            10'b101110_0100 , 10'b010001_1011 :  begin data_8b = 8'b000_11101; K_code = 0; end
            10'b011110_0100 , 10'b100001_1011 :  begin data_8b = 8'b000_11110; K_code = 0; end
            10'b101011_0100 , 10'b010100_1011 :  begin data_8b = 8'b000_11111; K_code = 0; end
            10'b100111_1001 , 10'b011000_1001 :  begin data_8b = 8'b001_00000; K_code = 0; end
            10'b011101_1001 , 10'b100010_1001 :  begin data_8b = 8'b001_00001; K_code = 0; end
            10'b101101_1001 , 10'b010010_1001 :  begin data_8b = 8'b001_00010; K_code = 0; end
            10'b110001_1001 , 10'b110001_1001 :  begin data_8b = 8'b001_00011; K_code = 0; end
            10'b110101_1001 , 10'b001010_1001 :  begin data_8b = 8'b001_00100; K_code = 0; end
            10'b101001_1001 , 10'b101001_1001 :  begin data_8b = 8'b001_00101; K_code = 0; end
            10'b011001_1001 , 10'b011001_1001 :  begin data_8b = 8'b001_00110; K_code = 0; end
            10'b111000_1001 , 10'b000111_1001 :  begin data_8b = 8'b001_00111; K_code = 0; end
            10'b111001_1001 , 10'b000110_1001 :  begin data_8b = 8'b001_01000; K_code = 0; end
            10'b100101_1001 , 10'b100101_1001 :  begin data_8b = 8'b001_01001; K_code = 0; end
            10'b010101_1001 , 10'b010101_1001 :  begin data_8b = 8'b001_01010; K_code = 0; end
            10'b110100_1001 , 10'b110100_1001 :  begin data_8b = 8'b001_01011; K_code = 0; end
            10'b001101_1001 , 10'b001101_1001 :  begin data_8b = 8'b001_01100; K_code = 0; end
            10'b101100_1001 , 10'b101100_1001 :  begin data_8b = 8'b001_01101; K_code = 0; end
            10'b011100_1001 , 10'b011100_1001 :  begin data_8b = 8'b001_01110; K_code = 0; end
            10'b010111_1001 , 10'b101000_1001 :  begin data_8b = 8'b001_01111; K_code = 0; end
            10'b011011_1001 , 10'b100100_1001 :  begin data_8b = 8'b001_10000; K_code = 0; end
            10'b100011_1001 , 10'b100011_1001 :  begin data_8b = 8'b001_10001; K_code = 0; end
            10'b010011_1001 , 10'b010011_1001 :  begin data_8b = 8'b001_10010; K_code = 0; end
            10'b110010_1001 , 10'b110010_1001 :  begin data_8b = 8'b001_10011; K_code = 0; end
            10'b001011_1001 , 10'b001011_1001 :  begin data_8b = 8'b001_10100; K_code = 0; end
            10'b101010_1001 , 10'b101010_1001 :  begin data_8b = 8'b001_10101; K_code = 0; end
            10'b011010_1001 , 10'b011010_1001 :  begin data_8b = 8'b001_10110; K_code = 0; end
            10'b111010_1001 , 10'b000101_1001 :  begin data_8b = 8'b001_10111; K_code = 0; end
            10'b110011_1001 , 10'b001100_1001 :  begin data_8b = 8'b001_11000; K_code = 0; end
            10'b100110_1001 , 10'b100110_1001 :  begin data_8b = 8'b001_11001; K_code = 0; end
            10'b010110_1001 , 10'b010110_1001 :  begin data_8b = 8'b001_11010; K_code = 0; end
            10'b110110_1001 , 10'b001001_1001 :  begin data_8b = 8'b001_11011; K_code = 0; end
            10'b001110_1001 , 10'b001110_1001 :  begin data_8b = 8'b001_11100; K_code = 0; end
            10'b101110_1001 , 10'b010001_1001 :  begin data_8b = 8'b001_11101; K_code = 0; end
            10'b011110_1001 , 10'b100001_1001 :  begin data_8b = 8'b001_11110; K_code = 0; end
            10'b101011_1001 , 10'b010100_1001 :  begin data_8b = 8'b001_11111; K_code = 0; end
            10'b100111_0101 , 10'b011000_0101 :  begin data_8b = 8'b010_00000; K_code = 0; end
            10'b011101_0101 , 10'b100010_0101 :  begin data_8b = 8'b010_00001; K_code = 0; end
            10'b101101_0101 , 10'b010010_0101 :  begin data_8b = 8'b010_00010; K_code = 0; end
            10'b110001_0101 , 10'b110001_0101 :  begin data_8b = 8'b010_00011; K_code = 0; end
            10'b110101_0101 , 10'b001010_0101 :  begin data_8b = 8'b010_00100; K_code = 0; end
            10'b101001_0101 , 10'b101001_0101 :  begin data_8b = 8'b010_00101; K_code = 0; end
            10'b011001_0101 , 10'b011001_0101 :  begin data_8b = 8'b010_00110; K_code = 0; end
            10'b111000_0101 , 10'b000111_0101 :  begin data_8b = 8'b010_00111; K_code = 0; end
            10'b111001_0101 , 10'b000110_0101 :  begin data_8b = 8'b010_01000; K_code = 0; end
            10'b100101_0101 , 10'b100101_0101 :  begin data_8b = 8'b010_01001; K_code = 0; end
            10'b010101_0101 , 10'b010101_0101 :  begin data_8b = 8'b010_01010; K_code = 0; end
            10'b110100_0101 , 10'b110100_0101 :  begin data_8b = 8'b010_01011; K_code = 0; end
            10'b001101_0101 , 10'b001101_0101 :  begin data_8b = 8'b010_01100; K_code = 0; end
            10'b101100_0101 , 10'b101100_0101 :  begin data_8b = 8'b010_01101; K_code = 0; end
            10'b011100_0101 , 10'b011100_0101 :  begin data_8b = 8'b010_01110; K_code = 0; end
            10'b010111_0101 , 10'b101000_0101 :  begin data_8b = 8'b010_01111; K_code = 0; end
            10'b011011_0101 , 10'b100100_0101 :  begin data_8b = 8'b010_10000; K_code = 0; end
            10'b100011_0101 , 10'b100011_0101 :  begin data_8b = 8'b010_10001; K_code = 0; end
            10'b010011_0101 , 10'b010011_0101 :  begin data_8b = 8'b010_10010; K_code = 0; end
            10'b110010_0101 , 10'b110010_0101 :  begin data_8b = 8'b010_10011; K_code = 0; end
            10'b001011_0101 , 10'b001011_0101 :  begin data_8b = 8'b010_10100; K_code = 0; end
            10'b101010_0101 , 10'b101010_0101 :  begin data_8b = 8'b010_10101; K_code = 0; end
            10'b011010_0101 , 10'b011010_0101 :  begin data_8b = 8'b010_10110; K_code = 0; end
            10'b111010_0101 , 10'b000101_0101 :  begin data_8b = 8'b010_10111; K_code = 0; end
            10'b110011_0101 , 10'b001100_0101 :  begin data_8b = 8'b010_11000; K_code = 0; end
            10'b100110_0101 , 10'b100110_0101 :  begin data_8b = 8'b010_11001; K_code = 0; end
            10'b010110_0101 , 10'b010110_0101 :  begin data_8b = 8'b010_11010; K_code = 0; end
            10'b110110_0101 , 10'b001001_0101 :  begin data_8b = 8'b010_11011; K_code = 0; end
            10'b001110_0101 , 10'b001110_0101 :  begin data_8b = 8'b010_11100; K_code = 0; end
            10'b101110_0101 , 10'b010001_0101 :  begin data_8b = 8'b010_11101; K_code = 0; end
            10'b011110_0101 , 10'b100001_0101 :  begin data_8b = 8'b010_11110; K_code = 0; end
            10'b101011_0101 , 10'b010100_0101 :  begin data_8b = 8'b010_11111; K_code = 0; end
            10'b100111_0011 , 10'b011000_1100 :  begin data_8b = 8'b011_00000; K_code = 0; end
            10'b011101_0011 , 10'b100010_1100 :  begin data_8b = 8'b011_00001; K_code = 0; end
            10'b101101_0011 , 10'b010010_1100 :  begin data_8b = 8'b011_00010; K_code = 0; end
            10'b110001_1100 , 10'b110001_0011 :  begin data_8b = 8'b011_00011; K_code = 0; end
            10'b110101_0011 , 10'b001010_1100 :  begin data_8b = 8'b011_00100; K_code = 0; end
            10'b101001_1100 , 10'b101001_0011 :  begin data_8b = 8'b011_00101; K_code = 0; end
            10'b011001_1100 , 10'b011001_0011 :  begin data_8b = 8'b011_00110; K_code = 0; end
            10'b111000_1100 , 10'b000111_0011 :  begin data_8b = 8'b011_00111; K_code = 0; end
            10'b111001_0011 , 10'b000110_1100 :  begin data_8b = 8'b011_01000; K_code = 0; end
            10'b100101_1100 , 10'b100101_0011 :  begin data_8b = 8'b011_01001; K_code = 0; end
            10'b010101_1100 , 10'b010101_0011 :  begin data_8b = 8'b011_01010; K_code = 0; end
            10'b110100_1100 , 10'b110100_0011 :  begin data_8b = 8'b011_01011; K_code = 0; end
            10'b001101_1100 , 10'b001101_0011 :  begin data_8b = 8'b011_01100; K_code = 0; end
            10'b101100_1100 , 10'b101100_0011 :  begin data_8b = 8'b011_01101; K_code = 0; end
            10'b011100_1100 , 10'b011100_0011 :  begin data_8b = 8'b011_01110; K_code = 0; end
            10'b010111_0011 , 10'b101000_1100 :  begin data_8b = 8'b011_01111; K_code = 0; end
            10'b011011_0011 , 10'b100100_1100 :  begin data_8b = 8'b011_10000; K_code = 0; end
            10'b100011_1100 , 10'b100011_0011 :  begin data_8b = 8'b011_10001; K_code = 0; end
            10'b010011_1100 , 10'b010011_0011 :  begin data_8b = 8'b011_10010; K_code = 0; end
            10'b110010_1100 , 10'b110010_0011 :  begin data_8b = 8'b011_10011; K_code = 0; end
            10'b001011_1100 , 10'b001011_0011 :  begin data_8b = 8'b011_10100; K_code = 0; end
            10'b101010_1100 , 10'b101010_0011 :  begin data_8b = 8'b011_10101; K_code = 0; end
            10'b011010_1100 , 10'b011010_0011 :  begin data_8b = 8'b011_10110; K_code = 0; end
            10'b111010_0011 , 10'b000101_1100 :  begin data_8b = 8'b011_10111; K_code = 0; end
            10'b110011_0011 , 10'b001100_1100 :  begin data_8b = 8'b011_11000; K_code = 0; end
            10'b100110_1100 , 10'b100110_0011 :  begin data_8b = 8'b011_11001; K_code = 0; end
            10'b010110_1100 , 10'b010110_0011 :  begin data_8b = 8'b011_11010; K_code = 0; end
            10'b110110_0011 , 10'b001001_1100 :  begin data_8b = 8'b011_11011; K_code = 0; end
            10'b001110_1100 , 10'b001110_0011 :  begin data_8b = 8'b011_11100; K_code = 0; end
            10'b101110_0011 , 10'b010001_1100 :  begin data_8b = 8'b011_11101; K_code = 0; end
            10'b011110_0011 , 10'b100001_1100 :  begin data_8b = 8'b011_11110; K_code = 0; end
            10'b101011_0011 , 10'b010100_1100 :  begin data_8b = 8'b011_11111; K_code = 0; end
            10'b100111_0010 , 10'b011000_1101 :  begin data_8b = 8'b100_00000; K_code = 0; end
            10'b011101_0010 , 10'b100010_1101 :  begin data_8b = 8'b100_00001; K_code = 0; end
            10'b101101_0010 , 10'b010010_1101 :  begin data_8b = 8'b100_00010; K_code = 0; end
            10'b110001_1101 , 10'b110001_0010 :  begin data_8b = 8'b100_00011; K_code = 0; end
            10'b110101_0010 , 10'b001010_1101 :  begin data_8b = 8'b100_00100; K_code = 0; end
            10'b101001_1101 , 10'b101001_0010 :  begin data_8b = 8'b100_00101; K_code = 0; end
            10'b011001_1101 , 10'b011001_0010 :  begin data_8b = 8'b100_00110; K_code = 0; end
            10'b111000_1101 , 10'b000111_0010 :  begin data_8b = 8'b100_00111; K_code = 0; end
            10'b111001_0010 , 10'b000110_1101 :  begin data_8b = 8'b100_01000; K_code = 0; end
            10'b100101_1101 , 10'b100101_0010 :  begin data_8b = 8'b100_01001; K_code = 0; end
            10'b010101_1101 , 10'b010101_0010 :  begin data_8b = 8'b100_01010; K_code = 0; end
            10'b110100_1101 , 10'b110100_0010 :  begin data_8b = 8'b100_01011; K_code = 0; end
            10'b001101_1101 , 10'b001101_0010 :  begin data_8b = 8'b100_01100; K_code = 0; end
            10'b101100_1101 , 10'b101100_0010 :  begin data_8b = 8'b100_01101; K_code = 0; end
            10'b011100_1101 , 10'b011100_0010 :  begin data_8b = 8'b100_01110; K_code = 0; end
            10'b010111_0010 , 10'b101000_1101 :  begin data_8b = 8'b100_01111; K_code = 0; end
            10'b011011_0010 , 10'b100100_1101 :  begin data_8b = 8'b100_10000; K_code = 0; end
            10'b100011_1101 , 10'b100011_0010 :  begin data_8b = 8'b100_10001; K_code = 0; end
            10'b010011_1101 , 10'b010011_0010 :  begin data_8b = 8'b100_10010; K_code = 0; end
            10'b110010_1101 , 10'b110010_0010 :  begin data_8b = 8'b100_10011; K_code = 0; end
            10'b001011_1101 , 10'b001011_0010 :  begin data_8b = 8'b100_10100; K_code = 0; end
            10'b101010_1101 , 10'b101010_0010 :  begin data_8b = 8'b100_10101; K_code = 0; end
            10'b011010_1101 , 10'b011010_0010 :  begin data_8b = 8'b100_10110; K_code = 0; end
            10'b111010_0010 , 10'b000101_1101 :  begin data_8b = 8'b100_10111; K_code = 0; end
            10'b110011_0010 , 10'b001100_1101 :  begin data_8b = 8'b100_11000; K_code = 0; end
            10'b100110_1101 , 10'b100110_0010 :  begin data_8b = 8'b100_11001; K_code = 0; end
            10'b010110_1101 , 10'b010110_0010 :  begin data_8b = 8'b100_11010; K_code = 0; end
            10'b110110_0010 , 10'b001001_1101 :  begin data_8b = 8'b100_11011; K_code = 0; end
            10'b001110_1101 , 10'b001110_0010 :  begin data_8b = 8'b100_11100; K_code = 0; end
            10'b101110_0010 , 10'b010001_1101 :  begin data_8b = 8'b100_11101; K_code = 0; end
            10'b011110_0010 , 10'b100001_1101 :  begin data_8b = 8'b100_11110; K_code = 0; end
            10'b101011_0010 , 10'b010100_1101 :  begin data_8b = 8'b100_11111; K_code = 0; end
            10'b100111_1010 , 10'b011000_1010 :  begin data_8b = 8'b101_00000; K_code = 0; end
            10'b011101_1010 , 10'b100010_1010 :  begin data_8b = 8'b101_00001; K_code = 0; end
            10'b101101_1010 , 10'b010010_1010 :  begin data_8b = 8'b101_00010; K_code = 0; end
            10'b110001_1010 , 10'b110001_1010 :  begin data_8b = 8'b101_00011; K_code = 0; end
            10'b110101_1010 , 10'b001010_1010 :  begin data_8b = 8'b101_00100; K_code = 0; end
            10'b101001_1010 , 10'b101001_1010 :  begin data_8b = 8'b101_00101; K_code = 0; end
            10'b011001_1010 , 10'b011001_1010 :  begin data_8b = 8'b101_00110; K_code = 0; end
            10'b111000_1010 , 10'b000111_1010 :  begin data_8b = 8'b101_00111; K_code = 0; end
            10'b111001_1010 , 10'b000110_1010 :  begin data_8b = 8'b101_01000; K_code = 0; end
            10'b100101_1010 , 10'b100101_1010 :  begin data_8b = 8'b101_01001; K_code = 0; end
            10'b010101_1010 , 10'b010101_1010 :  begin data_8b = 8'b101_01010; K_code = 0; end
            10'b110100_1010 , 10'b110100_1010 :  begin data_8b = 8'b101_01011; K_code = 0; end
            10'b001101_1010 , 10'b001101_1010 :  begin data_8b = 8'b101_01100; K_code = 0; end
            10'b101100_1010 , 10'b101100_1010 :  begin data_8b = 8'b101_01101; K_code = 0; end
            10'b011100_1010 , 10'b011100_1010 :  begin data_8b = 8'b101_01110; K_code = 0; end
            10'b010111_1010 , 10'b101000_1010 :  begin data_8b = 8'b101_01111; K_code = 0; end
            10'b011011_1010 , 10'b100100_1010 :  begin data_8b = 8'b101_10000; K_code = 0; end
            10'b100011_1010 , 10'b100011_1010 :  begin data_8b = 8'b101_10001; K_code = 0; end
            10'b010011_1010 , 10'b010011_1010 :  begin data_8b = 8'b101_10010; K_code = 0; end
            10'b110010_1010 , 10'b110010_1010 :  begin data_8b = 8'b101_10011; K_code = 0; end
            10'b001011_1010 , 10'b001011_1010 :  begin data_8b = 8'b101_10100; K_code = 0; end
            10'b101010_1010 , 10'b101010_1010 :  begin data_8b = 8'b101_10101; K_code = 0; end
            10'b011010_1010 , 10'b011010_1010 :  begin data_8b = 8'b101_10110; K_code = 0; end
            10'b111010_1010 , 10'b000101_1010 :  begin data_8b = 8'b101_10111; K_code = 0; end
            10'b110011_1010 , 10'b001100_1010 :  begin data_8b = 8'b101_11000; K_code = 0; end
            10'b100110_1010 , 10'b100110_1010 :  begin data_8b = 8'b101_11001; K_code = 0; end
            10'b010110_1010 , 10'b010110_1010 :  begin data_8b = 8'b101_11010; K_code = 0; end
            10'b110110_1010 , 10'b001001_1010 :  begin data_8b = 8'b101_11011; K_code = 0; end
            10'b001110_1010 , 10'b001110_1010 :  begin data_8b = 8'b101_11100; K_code = 0; end
            10'b101110_1010 , 10'b010001_1010 :  begin data_8b = 8'b101_11101; K_code = 0; end
            10'b011110_1010 , 10'b100001_1010 :  begin data_8b = 8'b101_11110; K_code = 0; end
            10'b101011_1010 , 10'b010100_1010 :  begin data_8b = 8'b101_11111; K_code = 0; end
            10'b100111_0110 , 10'b011000_0110 :  begin data_8b = 8'b110_00000; K_code = 0; end
            10'b011101_0110 , 10'b100010_0110 :  begin data_8b = 8'b110_00001; K_code = 0; end
            10'b101101_0110 , 10'b010010_0110 :  begin data_8b = 8'b110_00010; K_code = 0; end
            10'b110001_0110 , 10'b110001_0110 :  begin data_8b = 8'b110_00011; K_code = 0; end
            10'b110101_0110 , 10'b001010_0110 :  begin data_8b = 8'b110_00100; K_code = 0; end
            10'b101001_0110 , 10'b101001_0110 :  begin data_8b = 8'b110_00101; K_code = 0; end
            10'b011001_0110 , 10'b011001_0110 :  begin data_8b = 8'b110_00110; K_code = 0; end
            10'b111000_0110 , 10'b000111_0110 :  begin data_8b = 8'b110_00111; K_code = 0; end
            10'b111001_0110 , 10'b000110_0110 :  begin data_8b = 8'b110_01000; K_code = 0; end
            10'b100101_0110 , 10'b100101_0110 :  begin data_8b = 8'b110_01001; K_code = 0; end
            10'b010101_0110 , 10'b010101_0110 :  begin data_8b = 8'b110_01010; K_code = 0; end
            10'b110100_0110 , 10'b110100_0110 :  begin data_8b = 8'b110_01011; K_code = 0; end
            10'b001101_0110 , 10'b001101_0110 :  begin data_8b = 8'b110_01100; K_code = 0; end
            10'b101100_0110 , 10'b101100_0110 :  begin data_8b = 8'b110_01101; K_code = 0; end
            10'b011100_0110 , 10'b011100_0110 :  begin data_8b = 8'b110_01110; K_code = 0; end
            10'b010111_0110 , 10'b101000_0110 :  begin data_8b = 8'b110_01111; K_code = 0; end
            10'b011011_0110 , 10'b100100_0110 :  begin data_8b = 8'b110_10000; K_code = 0; end
            10'b100011_0110 , 10'b100011_0110 :  begin data_8b = 8'b110_10001; K_code = 0; end
            10'b010011_0110 , 10'b010011_0110 :  begin data_8b = 8'b110_10010; K_code = 0; end
            10'b110010_0110 , 10'b110010_0110 :  begin data_8b = 8'b110_10011; K_code = 0; end
            10'b001011_0110 , 10'b001011_0110 :  begin data_8b = 8'b110_10100; K_code = 0; end
            10'b101010_0110 , 10'b101010_0110 :  begin data_8b = 8'b110_10101; K_code = 0; end
            10'b011010_0110 , 10'b011010_0110 :  begin data_8b = 8'b110_10110; K_code = 0; end
            10'b111010_0110 , 10'b000101_0110 :  begin data_8b = 8'b110_10111; K_code = 0; end
            10'b110011_0110 , 10'b001100_0110 :  begin data_8b = 8'b110_11000; K_code = 0; end
            10'b100110_0110 , 10'b100110_0110 :  begin data_8b = 8'b110_11001; K_code = 0; end
            10'b010110_0110 , 10'b010110_0110 :  begin data_8b = 8'b110_11010; K_code = 0; end
            10'b110110_0110 , 10'b001001_0110 :  begin data_8b = 8'b110_11011; K_code = 0; end
            10'b001110_0110 , 10'b001110_0110 :  begin data_8b = 8'b110_11100; K_code = 0; end
            10'b101110_0110 , 10'b010001_0110 :  begin data_8b = 8'b110_11101; K_code = 0; end
            10'b011110_0110 , 10'b100001_0110 :  begin data_8b = 8'b110_11110; K_code = 0; end
            10'b101011_0110 , 10'b010100_0110 :  begin data_8b = 8'b110_11111; K_code = 0; end
            10'b100111_0001 , 10'b011000_1110 :  begin data_8b = 8'b111_00000; K_code = 0; end
            10'b011101_0001 , 10'b100010_1110 :  begin data_8b = 8'b111_00001; K_code = 0; end
            10'b101101_0001 , 10'b010010_1110 :  begin data_8b = 8'b111_00010; K_code = 0; end
            10'b110001_1110 , 10'b110001_0001 :  begin data_8b = 8'b111_00011; K_code = 0; end
            10'b110101_0001 , 10'b001010_1110 :  begin data_8b = 8'b111_00100; K_code = 0; end
            10'b101001_1110 , 10'b101001_0001 :  begin data_8b = 8'b111_00101; K_code = 0; end
            10'b011001_1110 , 10'b011001_0001 :  begin data_8b = 8'b111_00110; K_code = 0; end
            10'b111000_1110 , 10'b000111_0001 :  begin data_8b = 8'b111_00111; K_code = 0; end
            10'b111001_0001 , 10'b000110_1110 :  begin data_8b = 8'b111_01000; K_code = 0; end
            10'b100101_1110 , 10'b100101_0001 :  begin data_8b = 8'b111_01001; K_code = 0; end
            10'b010101_1110 , 10'b010101_0001 :  begin data_8b = 8'b111_01010; K_code = 0; end
            10'b110100_1110 , 10'b110100_1000 :  begin data_8b = 8'b111_01011; K_code = 0; end
            10'b001101_1110 , 10'b001101_0001 :  begin data_8b = 8'b111_01100; K_code = 0; end
            10'b101100_1110 , 10'b101100_1000 :  begin data_8b = 8'b111_01101; K_code = 0; end
            10'b011100_1110 , 10'b011100_1000 :  begin data_8b = 8'b111_01110; K_code = 0; end
            10'b010111_0001 , 10'b101000_1110 :  begin data_8b = 8'b111_01111; K_code = 0; end
            10'b011011_0001 , 10'b100100_1110 :  begin data_8b = 8'b111_10000; K_code = 0; end
            10'b100011_0111 , 10'b100011_0001 :  begin data_8b = 8'b111_10001; K_code = 0; end
            10'b010011_0111 , 10'b010011_0001 :  begin data_8b = 8'b111_10010; K_code = 0; end
            10'b110010_1110 , 10'b110010_0001 :  begin data_8b = 8'b111_10011; K_code = 0; end
            10'b001011_0111 , 10'b001011_0001 :  begin data_8b = 8'b111_10100; K_code = 0; end
            10'b101010_1110 , 10'b101010_0001 :  begin data_8b = 8'b111_10101; K_code = 0; end
            10'b011010_1110 , 10'b011010_0001 :  begin data_8b = 8'b111_10110; K_code = 0; end
            10'b111010_0001 , 10'b000101_1110 :  begin data_8b = 8'b111_10111; K_code = 0; end
            10'b110011_0001 , 10'b001100_1110 :  begin data_8b = 8'b111_11000; K_code = 0; end
            10'b100110_1110 , 10'b100110_0001 :  begin data_8b = 8'b111_11001; K_code = 0; end
            10'b010110_1110 , 10'b010110_0001 :  begin data_8b = 8'b111_11010; K_code = 0; end
            10'b110110_0001 , 10'b001001_1110 :  begin data_8b = 8'b111_11011; K_code = 0; end
            10'b001110_1110 , 10'b001110_0001 :  begin data_8b = 8'b111_11100; K_code = 0; end
            10'b101110_0001 , 10'b010001_1110 :  begin data_8b = 8'b111_11101; K_code = 0; end
            10'b011110_0001 , 10'b100001_1110 :  begin data_8b = 8'b111_11110; K_code = 0; end
            10'b101011_0001 , 10'b010100_1110 :  begin data_8b = 8'b111_11111; K_code = 0; end
       //Kcode 
            10'b001111_0100 , 10'b110000_1011 :  begin data_8b = 8'b000_11100; K_code = 1; end         
            10'b001111_1001 , 10'b110000_0110 :  begin data_8b = 8'b001_11100; K_code = 1; end         
            10'b001111_0101 , 10'b110000_1010 :  begin data_8b = 8'b010_11100; K_code = 1; end         
            10'b001111_0011 , 10'b110000_1100 :  begin data_8b = 8'b011_11100; K_code = 1; end         
            10'b001111_0010 , 10'b110000_1101 :  begin data_8b = 8'b100_11100; K_code = 1; end         
            10'b001111_1010 , 10'b110000_0101 :  begin data_8b = 8'b101_11100; K_code = 1; end         
            10'b001111_0110 , 10'b110000_1001 :  begin data_8b = 8'b110_11100; K_code = 1; end         
            10'b001111_1000 , 10'b110000_0111 :  begin data_8b = 8'b111_11100; K_code = 1; end         
            10'b111010_1000 , 10'b000101_0111 :  begin data_8b = 8'b111_10111; K_code = 1; end         
            10'b110110_1000 , 10'b001001_0111 :  begin data_8b = 8'b111_11011; K_code = 1; end         
            10'b101110_1000 , 10'b010001_0111 :  begin data_8b = 8'b111_11101; K_code = 1; end         
            10'b011110_1000 , 10'b100001_0111 :  begin data_8b = 8'b111_11110; K_code = 1; end         
            default : //error
                begin 
                data_8b = 8'b100_11100; //SUB K28.4
                K_code  = 1;
                `uvm_error(get_name(), $psprintf("[8B10B ERROR] No such 10B data exists, please check!!!, DATA 10B is %b",data_10b))
                end
            /*}}}*/
        endcase
     return ({K_code,data_8b});
endfunction

function [7:0] cdn_phy_monitor_base::scramble_lfsr16(input [7:0] data_in,input bit [15:0] lfsr,output bit[15:0] next_lfsr,input bit scramble_en=1,input bit advance_scramble=1);
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
function  [7:0] cdn_phy_monitor_base::scramble_lfsr23(
    input [7:0] data_in,
    input bit [22:0] lfsr,
    output bit[22:0] next_lfsr,
    input bit scramble_en = 1
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

function [31:0] cdn_phy_monitor_base::big_endian_transfer_byte(input bit en,input bit[31:0] data_in,input int width);
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

`endif // CDN_PHY_MONITOR_BASE__SV
