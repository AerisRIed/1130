//
// Template for UVM-compliant configuration class
//

`ifndef CDN_U4_DP_CONFIG__SV
`define CDN_U4_DP_CONFIG__SV

class cdn_u4_dp_config extends cdn_phy_config_base; 

   //---------------------------------
   // Member config and interface
   //---------------------------------
   rand dp_bit_rate_t    data_rate;
   rand data_width_t     data_width;
   rand lane_num_t       lane_num;

   real                  dp_pclk;

   // ToDo: Add other environment configuration varaibles

   constraint data_width_c {
     soft data_width == DATA_WIDTH_8;
   }
   constraint lane_num_c {
     soft lane_num == LANE_NUM_4;
   }
   // ToDo: Add constraint blocks to prevent error injection

   `uvm_object_utils_begin(cdn_u4_dp_config)
      `uvm_field_enum(dp_bit_rate_t,data_rate,UVM_ALL_ON) 
      `uvm_field_enum(data_width_t,data_width,UVM_ALL_ON) 
      `uvm_field_enum(lane_num_t,lane_num,UVM_ALL_ON) 

      // ToDo: add properties using macros here

   `uvm_object_utils_end

   //---------------------------------
   // Functions and tasks
   //---------------------------------
   extern function new(string name = "");
   extern function void set_dp_pclk(dp_bit_rate_t data_rate);

endclass: cdn_u4_dp_config

function cdn_u4_dp_config::new(string name = "");
   super.new(name);
endfunction: new

function void cdn_u4_dp_config::set_dp_pclk(dp_bit_rate_t data_rate);
  case(data_rate)
    DP_RBR : begin
      dp_pclk = CLK_81M;
    end
    DP_HBR :   begin
      dp_pclk = CLK_135M;
    end
    DP_HBR2 :   begin
      dp_pclk = CLK_270M;
    end
    DP_HBR3 :  begin
      dp_pclk = CLK_405M;
    end
    DP_UHBR10 :  begin
      dp_pclk = CLK_312_5M;
    end
    DP_UHBR13P5 :  begin
      dp_pclk = CLK_421_875M;
    end
    DP_UHBR20 :  begin
      dp_pclk = CLK_625M;
    end
    default : begin
      `uvm_error(get_type_name(),"set_dp_pclk error: unknown dp data_rate")
    end
  endcase
endfunction // set_dp_pclk

`endif // CDN_U4_DP_CONFIG__SV
