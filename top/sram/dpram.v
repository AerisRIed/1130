module dpram #(
parameter ADDR_WIDTH = 14,
          DATA_WIDTH = 32
) (
input                         clk,
input  [ADDR_WIDTH-1:0]       address0,
input  [DATA_WIDTH-1:0]       data_in0,
input                         enable0,
input                         write0,
input  [(DATA_WIDTH/8)-1:0]   byte_en0,
output reg [DATA_WIDTH-1:0]   data_out0,
input  [ADDR_WIDTH-1:0]       address1,
input  [DATA_WIDTH-1:0]       data_in1,
input                         enable1,
input                         write1,
input  [(DATA_WIDTH/8)-1:0]   byte_en1,
output reg [DATA_WIDTH-1:0]   data_out1
);

reg [DATA_WIDTH-1:0] mem [0:(32767+2048*3)];

always @(posedge clk) begin
    if (!write0 && !enable0) begin
        if (!byte_en0[3]) begin
            mem[address0][DATA_WIDTH-1:24] <= data_in0[DATA_WIDTH-1:24];
        end
        if (!byte_en0[2]) begin
            mem[address0][23:16] <= data_in0[23:16];
        end
        if (!byte_en0[1]) begin
            mem[address0][15:8] <= data_in0[15:8];
        end
        if (!byte_en0[0]) begin
            mem[address0][7:0] <= data_in0[7:0];
        end
    end
    if (!enable0) begin
        data_out0 <= mem[address0];
    end
end

always @(posedge clk) begin
    if (!write1 && !enable1) begin
        if (!byte_en1[3]) begin
            mem[address1][DATA_WIDTH-1:24] <= data_in1[DATA_WIDTH-1:24];
        end
        if (!byte_en1[2]) begin
            mem[address1][23:16] <= data_in1[23:16];
        end
        if (!byte_en1[1]) begin
            mem[address1][15:8] <= data_in1[15:8];
        end
        if (!byte_en1[0]) begin
            mem[address1][7:0] <= data_in1[7:0];
        end
    end
    if (!enable1) begin
        data_out1 <= mem[address1];
    end
end

//-----------------------------------------------------------------------------
// Backdoor mem intialization methods
//-----------------------------------------------------------------------------
string               ihex_file;
string               dhex_file;
reg                  load_mem_en;
reg                  init_mem_en;
reg [DATA_WIDTH-1:0] init_mem_value;
wire                 mem_lock;
integer              i;
reg [2:0]            iram_addr_base = 4;

// lock mem access while playing with it
//assign mem_lock = init_mem && load_mem_en;

// Add check to prevent against incorrect accesses


//-----------------------------------------------------------------------------
// Load FW from file to mem array
//-----------------------------------------------------------------------------
initial 
begin
   ihex_file = "${PHY_VERIF_AREA}/sve/tests/fw/phy_speedup.ihex";
   dhex_file = "${PHY_VERIF_AREA}/sve/tests/fw/phy_speedup.dhex";
   load_mem_en = 0;
   init_mem_en = 0;
   init_mem_value = 0;
end

always @(load_mem_en) begin
   if (load_mem_en == 1) begin
      load_fw_to_mem;
   end
end

task load_fw_to_mem; 
begin
   $readmemh(dhex_file, mem,0,8191);
   $readmemh(ihex_file, mem,2048*iram_addr_base);
end
endtask


//-----------------------------------------------------------------------------
// Initialize mem array to value
//-----------------------------------------------------------------------------

always @(init_mem_en) begin
   if (init_mem_en == 1) begin
      init_mem_to_value;
   end
end

task init_mem_to_value; 
begin
   for (i=0; i<16384; i=i+1) begin
      mem[i] = init_mem_value;
   end
end
endtask

//-----------------------------------------------------------------------------
// Debug address space
//-----------------------------------------------------------------------------
wire [DATA_WIDTH-1:0] debug_0;
wire [DATA_WIDTH-1:0] debug_1;
wire [DATA_WIDTH-1:0] debug_2;
wire [DATA_WIDTH-1:0] debug_3;

assign debug_0 = mem[0];
assign debug_1 = mem[1];
assign debug_2 = mem[2];
assign debug_3 = mem[3];

endmodule

