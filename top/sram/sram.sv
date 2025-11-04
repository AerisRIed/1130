module sram 
  #(ADDR_WIDTH = 14,
    DATA_WIDTH = 32,
    USE_CHEX_FILE = 0) 
   (input                       clk,
    input [ADDR_WIDTH-1:0]      address,
    input [DATA_WIDTH-1:0]      data_in,
    input                       enable,
    input                       write,
    input [(DATA_WIDTH/8)-1:0]  byte_en,
    output reg [DATA_WIDTH-1:0] data_out);

   reg [DATA_WIDTH-1:0]         mem [0:(32767+2048*3)];

   always @(posedge clk) begin
      if (!write && !enable) begin
         if (!byte_en[3]) begin
            mem[address][DATA_WIDTH-1:24] <= data_in[DATA_WIDTH-1:24];
         end
         if (!byte_en[2]) begin
            mem[address][23:16] <= data_in[23:16];
         end
         if (!byte_en[1]) begin
            mem[address][15:8] <= data_in[15:8];
         end
         if (!byte_en[0]) begin
            mem[address][7:0] <= data_in[7:0];
         end
      end
      if (!enable) begin
         data_out <= mem[address];
      end
   end


   //-----------------------------------------------------------------------------
   // Backdoor mem intialization methods
   //-----------------------------------------------------------------------------
   string               chex_file;
   string               ihex_file;
   string               dhex_file;
   reg                  load_mem_en;
   reg                  init_mem_en;
   reg [DATA_WIDTH-1:0] init_mem_value;
   wire                 mem_lock;
   int                  i;
   reg [2:0]            iram_addr_base = 4;


   //-----------------------------------------------------------------------------
   // Load FW from file to mem array
   //-----------------------------------------------------------------------------
   generate
      if (USE_CHEX_FILE) begin
         initial chex_file = "$PHY_VERIF_AREA/firmware/phy_top_main.chex";
      end
      else begin
         initial ihex_file = "$PHY_VERIF_AREA/firmware/phy_top_main.ihex";
         initial dhex_file = "$PHY_VERIF_AREA/firmware/phy_top_main.dhex";
      end
   endgenerate

   initial begin
      load_mem_en = 0;
      init_mem_en = 0;
      init_mem_value = 0;
   end

   always @(load_mem_en) begin
      if (load_mem_en == 1) begin
         tg1.load_fw_to_mem;
      end
   end
   
   // lock mem access while playing with it
   //assign mem_lock = init_mem && load_mem_en;

   // Add check to prevent against incorrect accesses

   generate
      if (USE_CHEX_FILE) begin: tg1
         task load_fw_to_mem(); 
            $display( "Load firmware Start!  %s",chex_file);
            $readmemh(chex_file, mem,0, 16383);
            $display( "Load firmware to mem done!");
         endtask
      end
      else begin: tg1
         task load_fw_to_mem(); 
            $readmemh(dhex_file, mem,0,2048*iram_addr_base-1);
            $readmemh(ihex_file, mem,2048*iram_addr_base, 16383);
         endtask
      end
   endgenerate

   
   //-----------------------------------------------------------------------------
   // Used for ECC generation
   //-----------------------------------------------------------------------------
   generate
      if (USE_CHEX_FILE) begin: tg2
         task write_fw_to_mem(); 
            $writememh(chex_file, mem,0, 16383);
         endtask
      end
      else begin: tg2
         task write_fw_to_mem(); 
            $writememh(dhex_file, mem,0,8191);
            $writememh(ihex_file, mem,2048*iram_addr_base, 16383);
         endtask
      end
   endgenerate

   //-----------------------------------------------------------------------------
   // Initialize mem array to value
   //-----------------------------------------------------------------------------

   always @(init_mem_en) begin
      if (init_mem_en == 1) begin
         init_mem_to_value;
      end
   end

   task init_mem_to_value(); 
      for (i=0; i<16384; i=i+1) begin
         mem[i] = init_mem_value;
      end
   endtask

endmodule

