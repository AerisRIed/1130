//
// Template for UVM-compliant transaction descriptor


`ifndef CDN_PHY_TRANSACTION_BASE__SV
`define CDN_PHY_TRANSACTION_BASE__SV


class cdn_phy_transaction_base extends uvm_sequence_item;

   // Main variables:

   // DP Parameters
   parameter int DP_TPS1[4] = { 
         10'h2AA,                         //0 D10.2  
         10'h2AA,                         //1 D10.2  
         10'h2AA,                         //2 D10.2  
         10'h2AA                          //3 D10.2  
   };
   parameter int DP_TPS2[10] = { 
         10'h17C,                         //0 K28.5-
         10'h18B,                         //1 D11.6
         10'h283,                         //2 K28.5+
         10'h18B,                         //3 D11.6
         10'h2AA,10'h2AA,10'h2AA,10'h2AA,10'h2AA,10'h2AA //4-9 D10.2
   };
   parameter int DP_TPS3[34] = { 
         10'h17C,                         //0 K28.5-
         10'h283,                         //1 K28.5+
         10'h17C,                         //2 K28.5-
         10'h283,                         //3 K28.5+
         10'h2AA,10'h2AA,10'h2AA,10'h2AA,10'h2AA,10'h2AA,10'h2AA,10'h2AA, //4-11 D10.2-
         10'h17C,                         //12 K28.5-
         10'h283,                         //13 K28.5+
         10'h31E,10'h0E1,10'h31E,10'h0E1,10'h31E,10'h0E1,10'h31E,10'h0E1, //14-21 D30.3-,D30.3+
         10'h31E,10'h0E1,10'h31E,10'h0E1,10'h31E,10'h0E1,10'h31E,10'h0E1, //22-29 D30.3-,D30.3+
         10'h31E,10'h0E1,10'h31E,10'h0E1 //30-33 D30.3-,D30.3+
   };
   parameter int DP_TPS4[252] = { 
         10'h0BC,                         //0 K28.0-
         10'h17C,                         //1 K28.5-
         10'h283,                         //2 K28.5+
         10'h0BC,                         //3 K28.0-
         10'h235,10'h097,10'h1B9,10'h0B4,10'h172,10'h1C7,10'h352,10'h2D2,
         10'h332,10'h30E,10'h258,10'h166,10'h15E,10'h30D,10'h14A,10'h2CD,
         10'h161,10'h2B9,10'h178,10'h226,10'h26C,10'h193,10'h22D,10'h172,
         10'h347,10'h352,10'h0E8,10'h26A,10'h18D,10'h274,10'h15E,10'h1C6,
         10'h178,10'h2A2,10'h26B,10'h171,10'h2E4,10'h151,10'h15D,10'h252,
         10'h1B4,10'h2A5,10'h09D,10'h193,10'h197,10'h22A,10'h0D6,10'h1CE,
         10'h26C,10'h19A,10'h09A,10'h1DA,10'h258,10'h24D,10'h256,10'h25B,
         10'h25A,10'h08E,10'h33A,10'h338,10'h185,10'h366,10'h2AC,10'h266,
         10'h193,10'h229,10'h25A,10'h18D,10'h247,10'h0D6,10'h276,10'h21C,
         10'h2F4,10'h10B,10'h363,10'h1A1,10'h193,10'h366,10'h2B2,10'h216,
         10'h2BA,10'h2D8,10'h2C6,10'h115,10'h1AB,10'h32A,10'h326,10'h232,
         10'h135,10'h36C,10'h151,10'h255,10'h22D,10'h2AE,10'h185,10'h247,
         10'h0F4,10'h2B9,10'h0E1,10'h11E,10'h165,10'h2B3,10'h1E1,10'h2D4,
         10'h0A9,10'h339,10'h358,10'h169,10'h231,10'h34B,10'h0C5,10'h32D,
         10'h368,10'h2A3,10'h29C,10'h04D,10'h2A7,10'h259,10'h24A,10'h1B4,
         10'h29A,10'h1D5,10'h08E,10'h153,10'h187,10'h363,10'h2E2,10'h2E4,
         10'h10B,10'h34D,10'h10E,10'h29C,10'h253,10'h133,10'h317,10'h14E,
         10'h24D,10'h16C,10'h08B,10'h25E,10'h19A,10'h08B,10'h2AD,10'h31A,
         10'h31C,10'h1B1,10'h185,10'h167,10'h09C,10'h372,10'h04E,10'h2AE,
         10'h192,10'h275,10'h24C,10'h0DA,10'h34D,10'h329,10'h234,10'h0AE,
         10'h19A,10'h271,10'h0F2,10'h1A5,10'h179,10'h1A8,10'h2D3,10'h08E,
         10'h19C,10'h17A,10'h154,10'h295,10'h1C7,10'h1C9,10'h332,10'h096,
         10'h327,10'h195,10'h24C,10'h12B,10'h19D,10'h346,10'h18D,10'h34C,
         10'h2E1,10'h1AA,10'h249,10'h299,10'h2AC,10'h0D5,10'h09B,10'h317,
         10'h271,10'h1A5,10'h04D,10'h1BA,10'h131,10'h32B,10'h30E,10'h262,
         10'h21E,10'h227,10'h269,10'h0AB,10'h1BA,10'h32C,10'h21C,10'h1AB,
         10'h08B,10'h29E,10'h19A,10'h0D2,10'h15A,10'h29B,10'h14B,10'h18A,
         10'h299,10'h157,10'h0E2,10'h257,10'h2A1,10'h1E3,10'h09A,10'h1A6,
         10'h127,10'h374,10'h215,10'h2BA,10'h10B,10'h1A7,10'h296,10'h18B,
         10'h193,10'h349,10'h292,10'h0E3,10'h0AB,10'h2EA,10'h174,10'h1E8,
         10'h2D4,10'h351,10'h146,10'h0AE,10'h2E3,10'h2A9,10'h338,10'h04E  //4-251 248 00hs after data symbol scrambling and 8b/10b DP coding
   };
   // TODO
   parameter int DP_128B132B_TPS1[] = { 
         32'hAAAA_AAAA,
         32'hAAAA_AAAA,
         32'hAAAA_AAAA,
         32'hAAAA_AAAA
   };
   parameter int DP_128B132B_TPS2_START[] = { 
         32'h33CC_CCCC,
         32'hEA1D_BFBC,
         32'hAB89_3E84,
         32'h203C_3A4D  // 0s with scrambled. Seed value is 0x1DBFBC
   };
   parameter int DP_128B132B_TPS2[] = { 
         32'hBBDD41FD, 32'h5CE5DEE8, 32'h5FBB8073, 32'hE984C7E6,
         32'h7C3F762D, 32'h7DDFA443, 32'h3A996FC5, 32'h68A2B34B,
         32'h0F8A14CF, 32'h0823E926, 32'h8A9BC206, 32'hF242CB31,
         32'hDDDA20B5, 32'hAB4357EF, 32'h52F43F38, 32'hA3B463BB,
         32'hFCE327DF, 32'h5E0A9B26, 32'hA809D98F, 32'h7BFD2AC7,
         32'h9963B8A9, 32'h33F81630, 32'h520DD05C, 32'h9B7F513D,
         32'h256F8EC5, 32'hADED04C9, 32'hE9194CFD, 32'h4BA3E56F,
         32'hED925B1A, 32'h449048B0, 32'h9AA02E0E, 32'h958A9ACE,
         32'h216D07AB, 32'h62078045, 32'h3AB107C6, 32'hA1F89F40,
         32'h10B30F47, 32'h0423D30D, 32'h49DCDCBC, 32'h6C101C58,
         32'hA9CA12A2, 32'hAE056986, 32'h685CFDB6, 32'hA439B567,
         32'h3B054A19, 32'h3381E18E, 32'hB1779CCC, 32'h16F88155,
         32'hADBA7556, 32'hE8D587C5, 32'h9F7BD85B, 32'hBF6F932B,
         32'hC03BB74B, 32'h5D79EE95, 32'h0FA23FEB, 32'hE6A89D04,
         32'hE33440EB, 32'h78D3D579, 32'hB407E1CF, 32'hF13F4980,
         32'h9128079C, 32'h0647D41A, 32'h284E8520, 32'h75FCAFD0,
         32'hC8ED3BC9, 32'h0DB73848, 32'hDAF3D027, 32'hF970EF84,
         32'hCFF79D9C, 32'h76CEB2F6, 32'hAC7F8091, 32'h75886A01,
         32'h024812DE, 32'hF4E50BE5, 32'h7665E968, 32'h02144487,
         32'h8226D165, 32'hD9C71DC1, 32'hAB41C898, 32'h23DC4E22,
         32'hFA2D9A58, 32'hC5484C02, 32'h5FE9DAA3, 32'h012203B7,
         32'hAA056A3E, 32'hDDA4E57D, 32'h9FD9D55E, 32'h6925055E,
         32'hED6E323C, 32'hCCE61FB7, 32'hCF40313B, 32'h9A697983,
         32'h50F8E4ED, 32'h34492E92, 32'hEF6C768F, 32'h81E61140,
         32'hF9AB68FA, 32'hC05928B7, 32'h72F809AF, 32'hB1D44D9D,
         32'h3CBE72A2, 32'h70DFECFB, 32'h696DD57A, 32'h28700FA2,
         32'h0B6FCA43, 32'hAFAF2473, 32'hF8657F92, 32'h42783CB0,
         32'h0F0AA118, 32'h8A45FDD8, 32'h501E2C7C, 32'h87F25AE0,
         32'hC89C059F, 32'h4D311B10, 32'h0B29BBE3, 32'hAD036DD4,
         32'hC8FAD5D4, 32'h253B1174, 32'h78D2B181, 32'h1AE603F8,
         32'h3E5010B3, 32'h0E5D0F19, 32'h42EDF80D, 32'hD4C8EDC0,
         32'hAB788BE7, 32'hFF933A0C, 32'h62F0B360, 32'hFF562EB7,
         32'h2B86A7AE, 32'hE0196F99, 32'h9C0BC588, 32'h8395BB6D,
         32'h97644073, 32'h0D0263FC, 32'h76D8E8DB, 32'h495B4EBC,
         32'h32AC2BDA, 32'h74C8C437, 32'h9C6A0CF6, 32'h2A0AA592,
         32'h316A05DD, 32'h7F481AAF, 32'hB1141A0D, 32'hAD06EB96,
         32'h7847B055, 32'hA957A75B, 32'h84D6CD23, 32'h2A6375CC,
         32'h584071CC, 32'hAF719DE3, 32'h159B288D, 32'hF57D742F,
         32'h61F7BBAE, 32'hC0B56671, 32'h70DE6629, 32'hB98A058C,
         32'h1F0758FC, 32'h1C091308, 32'h50F1E4F0, 32'h6083C985,
         32'hF2D00318, 32'hCCB795AB, 32'hEE5ABCFD, 32'hB9066082,
         32'h55FD7BE0, 32'h901B754E, 32'h9355F7BE, 32'hDA065736,
         32'h5BCA6D55, 32'h7FB3F953, 32'hBC6F049E, 32'h71EF5B44,
         32'h3EF95214, 32'h9EBC0A47, 32'h01F78840, 32'h3BCEC1C4,
         32'hA00AB69E, 32'h8B5CD573, 32'h24A93821, 32'hBD94FD95,
         32'hDD836341, 32'h29A5B5E1, 32'h2DC69D95, 32'h7A178575,
         32'h1A84B747, 32'h07A42D33, 32'hD388D8AD, 32'h9B5BAAC0,
         32'h0378CD05, 32'h92D50E18, 32'hD59CD02A, 32'h8DBD9F8C,
         32'hF88667C7, 32'h6D959837, 32'h63D12FA3, 32'hBDD7F1FC,
         32'h1AAE90FB, 32'hDC9F7504, 32'hBF424388, 32'hA493C926,
         32'h1C5E3411, 32'h7DD69ABC, 32'h731CBF35, 32'hA76CB1FF,
         32'hC0AB73FA, 32'h79A4779E, 32'h4FDECD31, 32'hB803BF10,
         32'h638660DE, 32'hA1540D23, 32'h1C04DAEC, 32'h0C125EEB,
         32'h5D9FF6CC, 32'hDF504EBF, 32'hEB32975A, 32'h258078AB,
         32'h57D3A04B, 32'h01273D59, 32'h4855880A, 32'h6E9716BB,
         32'hEC8F02E4, 32'h6AE38654, 32'hBF39864C, 32'h6F169E44,
         32'h46CE8A92, 32'hC22AFF5F, 32'h26A94EE8, 32'hD86BE890,
         32'h3C7F546B, 32'h44BC7AA5, 32'h1F4B0206, 32'hF6EF2BB3,
         32'hC14EE2BF, 32'hE62C31E2, 32'h0A320C3F, 32'hA89C0893,
         32'hAB058B42, 32'h098F1C77, 32'h1DA55EF5, 32'h9522FFB6,
         32'h38BCB8EB, 32'h98E4305E, 32'hCC530724, 32'h44BA51EE,
         32'h5CD441DE, 32'h2B3276C8, 32'h9CD58793, 32'h1B5733EE,
         32'h69A8D460, 32'h6A3CF631, 32'hA5F1598C, 32'h99F218E0,
         32'hB9C46D0C, 32'hDD1E7BB5, 32'h5AA17BAC, 32'hE17782E7,
         32'h88ECB473, 32'h9F9E53E9, 32'h81F0F3C1, 32'h4E622162,
         32'hB8222C85, 32'h8B2A745E, 32'hEA18BFB0, 32'h5496EB57,
         32'h417DBEA8, 32'h4AFB7599, 32'h3955175D, 32'hB1F67301,
         32'h2730407B, 32'h6A22B53C, 32'h8060FD4F, 32'hA8E19BD9,
         32'h1981F036, 32'h2A2611C9, 32'hFB239987, 32'hF1009918,
         32'h5C15B7DF, 32'h7C18E5B0, 32'hC09929A1, 32'hCFAB25EF,
         32'h7E0B5AB7, 32'hFBC57A55, 32'h54CE37D0, 32'h1846610D,
         32'hB36F528B, 32'h7640766D, 32'h8AE2E570, 32'h72718287,
         32'h7A378993, 32'h29F59E6C, 32'hCA4E1A1F, 32'h0DAC6EE8,
         32'h0B474C6A, 32'h18F33AB9, 32'h1F446A77, 32'hC66BD755,
         32'h77B95336, 32'h7077F446, 32'h4A2205F4, 32'h767751FF,
         32'hF96C0D1C, 32'h86017FA2, 32'hCC36BF0F, 32'hB7E195A8,
         32'hE5250B47, 32'hB6FB6DCF, 32'h582E568D, 32'h79C8CFA8,
         32'hE84FEE60, 32'h1C4E801E, 32'hB31EFF32, 32'h725E083A,
         32'h07C46E9F, 32'hAAF016A4, 32'h0A22B830, 32'h66546D1D,
         32'hAA473C4D, 32'hA927C317, 32'h77FE3BAB, 32'hE6A43018,
         32'h113618C7, 32'h8AA0B303, 32'h06F2A4ED, 32'h92106766,
         32'hA674AB2A, 32'h361630E4, 32'h4BEAC25C, 32'hC2F5D9BC,
         32'h108A245C, 32'hE9C825B0, 32'hC434C923, 32'hD33FE7E5,
         32'h33643CBA, 32'hA3034952, 32'h5FE65CF8, 32'h4FA0CD90,
         32'hE4EAD5DA, 32'hC3ECF117, 32'h643D3001, 32'hD3AE82C5,
         32'hD12BAFFD, 32'hB7AB4914, 32'h158B1ACC, 32'h7417A1F3,
         32'h8D983E6B, 32'h6D3FF1D7, 32'h4FB0BCF6, 32'h4251582F,
         32'h5915EDB7, 32'h4F2683C4, 32'h465A87DA, 32'hEEDE3B58,
         32'h4675F6EC, 32'hE61103C8, 32'h8CB9A2A8, 32'h2FBE2E9C,
         32'h7E988BA3, 32'h7ED742B2, 32'h7A5C6BB7, 32'h6820F18F,
         32'hCD60F3B8, 32'h9E0AC218, 32'h43B1A102, 32'h0826FC8B,
         32'h7EBEFA88, 32'h22D29D35, 32'hAD2C4A64, 32'hECDE5830,
         32'h28B00EB4, 32'hB63CE603, 32'h60703359, 32'h3F1E7765,
         32'h6669E79B, 32'h7E21156F, 32'h115AA0F1, 32'h2D319052,
         32'hA2BF9BE3, 32'h4288F88A, 32'h757EAE33, 32'h2DD68497,
         32'h333C3C3C, 32'hED088A13, 32'h95489740, 32'hA98E07FE  // 0s with scrambled. Seed value is 0x1DBFBC
   };
   parameter int DP_IDLE_PATTERN[4] = { 
         10'h17C,                         //0 K28.5-
         10'h0C3,                         //1 K28.3+
         10'h33C,                         //2 K28.3-
         10'h283                          //3 K28.5+
   };
  // parameter int DP_128B132B_IDLE_PATTERN[] = { 
  // };

  // rand operation_t          operation; // operation type,
  //                                                  // including power state transition, 
  //                                                  // change Signaling Rate, PCLK Rate, or Data Bus Width,
  //                                                  // transmitter Margining, transmit LFPS,
  //                                                  // send Message Bus, Reset, and so on.
  // rand bit                  insert_error_en; // whether insert error
  // rand insert_error_type_t  insert_error_type; // insert error type
  // rand packet_type_t        packet_type; // Transport Layer Packets, Ordered Sets
  // rand int                  packet_size; // data packet size
  // rand data_packet_t        data_packet; // data packet content, contains sync, payload, etc
  //                                                         // including Transport Layer Packets,
  //                                                         // SLOS1, SLOS2, TS1, TS2, and so on
  // // Timing Parameters:
  // rand bit                  timing_param_ovrd; // timing parameters override
  // rand timing_param_t       timing_param; // user can specify timing parameters or not

   // ToDo: Add constraint blocks to prevent error injection
   // ToDo: Add relevant class properties to define all transactions
   // ToDo: Modify/add symbolic transaction identifiers to match

   `uvm_object_utils_begin(cdn_phy_transaction_base) 

      // ToDo: add properties using macros here
     // `uvm_field_enum(operation_t,operation,UVM_ALL_ON)
     // `uvm_field_int(insert_error_en,UVM_ALL_ON)
     // `uvm_field_enum(insert_error_type_t,insert_error_type,UVM_ALL_ON)
     // `uvm_field_enum(packet_type_t,packet_type,UVM_ALL_ON)
     // `uvm_field_int(packet_size,UVM_ALL_ON)
     // `uvm_field_object(data_packet,UVM_ALL_ON)
     // `uvm_field_int(timing_param_ovrd,UVM_ALL_ON)
     // `uvm_field_object(timing_param,UVM_ALL_ON)
   
   `uvm_object_utils_end
 
   // constraints for transaction
  // constraint c_insert_error_en {
  //    // ToDo: Define constraint to make descriptor valid
  //    soft insert_error_en == 0;
  // }

   // UVM functions and tasks:
   extern function new(string name = "Trans");
   // User functions and tasks:

endclass: cdn_phy_transaction_base


function cdn_phy_transaction_base::new(string name = "Trans");
   super.new(name);
  // data_packet  = data_packet_t::type_id::create("data_packet"); 
  // timing_param = timing_param_t::type_id::create("timing_param"); 
endfunction: new


`endif // CDN_PHY_TRANSACTION_BASE__SV
