interface sd_serializer #(parameter PD_WIDTH = 8)
  (
   input 	    clk,
   input [PD_WIDTH-1:0] 	    tx_data,
   input [5:0] 	    tx_valid_bits,
   input [5:0] 	    serializer_shift,
   input 	    load_reg_in,
   input 	    mstr,
   output reg [PD_WIDTH-1:0] mon_data, // parallel data, loaded from shift reg
   output reg [5:0] mon_valid_bits, // valid bits of parallel data
   output wire 	    load_reg_out,
   //output reg 	    Txp,
   //output reg 	    Txn,
   output reg 	    serial_out,
   output reg 	    sdp,
   output reg 	    sdn
   );
 
 
   // indicates to send new data
   event 	    tx_data_req;
   event 	    mon_data_vld;
   bit              mon_data_vld_clk; // toggles simultaneously to event 
 
   // storage for data and valid bits
   reg [PD_WIDTH-1:0] 	    tx_data_reg = 'bx;
   bit [5:0] 	    bit_cnt; // Default to 10 to startup correctly
   bit 		    load_regs;
   bit 		    load_regs_int;
 
   // for deserializing the serial_out data
   reg [5:0] 	    mon_bit_cnt = 'd10;
   reg [5:0] 	    mon_bit_cnt_d;        // bit_cnt delayed by 1 clk
   reg [PD_WIDTH:0] 	    mon_shift_reg;
   reg [2*PD_WIDTH-1:0] 	    serial_buffer;
 
   reg 		    prev_serial_out;
   wire 	    serial_data;
   
   // delay registers
   reg 		    serial_data_d1=0;
   reg 		    serial_data_d2=0;
   reg 		    serial_data_d3=0;
   reg 		    serial_data_d4=0;
   reg 		    serial_data_d5=0;
   reg 		    serial_data_d6=0;
   reg 		    serial_data_d7=0;
   reg 		    serial_data_d8=0;
   reg 		    serial_data_d9=0;
   reg 		    serial_data_d10=0;
   reg 		    serial_data_d11=0;
   reg 		    serial_data_d12=0;
   reg 		    serial_data_d13=0;
   reg 		    serial_data_d14=0;
   reg 		    serial_data_d15=0;
   
   // select shifted serial data
   always_comb begin
 
      case (serializer_shift)
	0:  serial_out = serial_data;
	1:  serial_out = serial_data_d1;
	2:  serial_out = serial_data_d2;
	3:  serial_out = serial_data_d3;
	4:  serial_out = serial_data_d4;
	5:  serial_out = serial_data_d5;
	6:  serial_out = serial_data_d6;
	7:  serial_out = serial_data_d7;
	8:  serial_out = serial_data_d8;
	9:  serial_out = serial_data_d9;
	10: serial_out = serial_data_d10;
	11: serial_out = serial_data_d11;
	12: serial_out = serial_data_d12;
	13: serial_out = serial_data_d13;
	14: serial_out = serial_data_d14;
	15: serial_out = serial_data_d15;
      endcase
      
   end
    //assign Txp =  serial_out;
    //assign Txn = ~serial_out;
   // delay data for shifting
   always @(posedge clk) begin
 
      serial_data_d1  <= serial_data;
      serial_data_d2  <= serial_data_d1;
      serial_data_d3  <= serial_data_d2;
      serial_data_d4  <= serial_data_d3;
      serial_data_d5  <= serial_data_d4;
      serial_data_d6  <= serial_data_d5;
      serial_data_d7  <= serial_data_d6;
      serial_data_d8  <= serial_data_d7;
      serial_data_d9  <= serial_data_d8;
      serial_data_d10 <= serial_data_d9;
      serial_data_d11 <= serial_data_d10;
      serial_data_d12 <= serial_data_d11;
      serial_data_d13 <= serial_data_d12;
      serial_data_d14 <= serial_data_d13;
      serial_data_d15 <= serial_data_d14;
   end
   
   
   // bit_cnt starts at 0
   always @(posedge clk) begin
       if(load_reg_in)begin
        bit_cnt++;
       end
      // load_regs_int = 0;
 
      if (bit_cnt == tx_valid_bits) begin
	 load_regs_int = 1;
 
      end
   end
 
  
   assign load_regs    = mstr ? load_regs_int : load_reg_in;
   assign load_reg_out = load_regs;
 
   
   // request new data
   always @(posedge load_regs) begin
      -> tx_data_req;
      bit_cnt = 0;
 
      // mandatory to avoid just having a long 2-cycle pulse on load_res_int
      @(negedge clk);
      load_regs_int = 0;
   end
 
   // serialize the data
   assign serial_data = (bit_cnt >= tx_valid_bits) ? tx_data[tx_valid_bits-1] :
                                                     tx_data[bit_cnt];
 
   
   // ************************************************************
   // Serialize the serial_out
   //
   // This could be used for a monitor rather than connecting
   // a monitor to the tx_data. Any shifts would affect
   // this data
   // ************************************************************
 
   always@(posedge clk) begin
 
      if (((serial_out === 1'b0 || serial_out === 1'b1) && prev_serial_out === 1'bz) ||
	  ((prev_serial_out === 1'b0 || prev_serial_out === 1'b1) && serial_out === 1'bz) ||
	  mon_bit_cnt == 10) begin
	 
	 mon_bit_cnt <= 1;
      end
      else begin
	 mon_bit_cnt <= mon_bit_cnt + 1;
      end
      
   end
 
   always@(posedge clk) begin
      
      mon_bit_cnt_d   <= mon_bit_cnt;
      prev_serial_out <= serial_out;
 
      mon_shift_reg[9:0] <= mon_shift_reg[10:1];
      mon_shift_reg[10]  <= serial_out;
      serial_buffer[18:0] <= serial_buffer[19:1];
      serial_buffer[19]   <= serial_out;
 
      // update the holding registers
      if (mon_bit_cnt == 1) begin
	 mon_data       <= mon_shift_reg[9:0];
	 mon_valid_bits <= mon_bit_cnt_d;
	 -> mon_data_vld;
         mon_data_vld_clk = ~mon_data_vld_clk;
      end
      
   end
   
endinterface : sd_serializer
