//
// Template for UVM-compliant transaction descriptor


`ifndef CDN_U4_DP_TRANSACTION__SV
`define CDN_U4_DP_TRANSACTION__SV


class cdn_u4_dp_transaction extends cdn_phy_transaction_base;

   // Main variables:
   rand dp_operation_t       operation; // operation type,
   rand dp_link_tps_t        packet_type; // data packet type, tps or random data
   rand int                  packet_size; // data packet size, byte
   rand data_packet_t        data_packet; // data packet content

   constraint packet_size_c {
     soft packet_type == LINK_DATA_RANDOM   -> packet_size inside {[1:10000]}; // TODO
     soft packet_type == LINK_TPS1          -> packet_size == 4;
     soft packet_type == LINK_TPS2          -> packet_size == 10;
     soft packet_type == LINK_TPS3          -> packet_size == 34;
     soft packet_type == LINK_TPS4          -> packet_size == 252;
     soft packet_type == LINK_128B132B_TPS1 -> packet_size == 4;
     soft packet_type == LINK_128B132B_TPS2_START   -> packet_size == 4;
     soft packet_type == LINK_128B132B_TPS2         -> packet_size == 384;
     soft packet_type == LINK_IDLE_PATTERN          -> packet_size == 4;
     soft packet_type == LINK_128B132B_IDLE_PATTERN -> packet_size == 4; // TODO
     soft packet_type == LINK_LFPS                  -> packet_size == 4; // TODO
   }

   constraint data_packet_c {
     soft data_packet.datas.size() == packet_size; 
   }

   `uvm_object_utils_begin(cdn_u4_dp_transaction) 

      // ToDo: add properties using macros here
      `uvm_field_enum(dp_operation_t,operation,UVM_ALL_ON)
      `uvm_field_enum(dp_link_tps_t,packet_type,UVM_ALL_ON)
      `uvm_field_int(packet_size,UVM_ALL_ON)
      `uvm_field_object(data_packet,UVM_ALL_ON)
   `uvm_object_utils_end
 
   extern function new(string name = "cdn_u4_dp_transaction");
   extern function void post_randomize();
   extern virtual function void get_data();

endclass: cdn_u4_dp_transaction


function cdn_u4_dp_transaction::new(string name = "cdn_u4_dp_transaction");
   super.new(name);
   data_packet  = data_packet_t::type_id::create("data_packet"); 
endfunction: new

function void cdn_u4_dp_transaction::post_randomize();
  // get data_packet datas
  get_data();
endfunction: post_randomize

function void cdn_u4_dp_transaction::get_data();
  
  // get data_packet datas
  case(packet_type)
    LINK_DATA_RANDOM:begin
      for(int i=0; i<packet_size; i++) begin
        data_packet.datas[i] = $urandom_range(0, 32'hFFFF_FFFF);
      end
    end
    LINK_TPS1:begin
      for(int i=0; i<packet_size; i++) begin
        data_packet.datas[i] = DP_TPS1[i];
      end
    end
    LINK_TPS2:begin
      for(int i=0; i<packet_size; i++) begin
        data_packet.datas[i] = DP_TPS2[i];
      end
    end
    LINK_TPS3:begin
      for(int i=0; i<packet_size; i++) begin
        data_packet.datas[i] = DP_TPS3[i];
      end
    end
    LINK_TPS4:begin
      for(int i=0; i<packet_size; i++) begin
        data_packet.datas[i] = DP_TPS4[i];
      end
    end
    LINK_128B132B_TPS1:begin
      for(int i=0; i<packet_size; i++) begin
        data_packet.datas[i] = DP_128B132B_TPS1[i];
      end
    end
    LINK_128B132B_TPS2_START:begin
      for(int i=0; i<packet_size; i++) begin
        data_packet.datas[i] = DP_128B132B_TPS2_START[i];
      end
    end
    LINK_128B132B_TPS2:begin
      for(int i=0; i<packet_size; i++) begin
        data_packet.datas[i] = DP_128B132B_TPS2[i];
      end
    end
    LINK_IDLE_PATTERN:begin
      for(int i=0; i<packet_size; i++) begin
        data_packet.datas[i] = DP_IDLE_PATTERN[i];
      end
    end
    LINK_128B132B_IDLE_PATTERN:begin // TODO
    end
    default:begin
    end
  endcase

endfunction: get_data

`endif // CDN_U4_DP_TRANSACTION__SV

