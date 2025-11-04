`ifndef REG_OP_TASK__SV
`define REG_OP_TASK__SV
    // ------------------------------------------------------------------
    // APB connection for future BTB mode use
    // ------------------------------------------------------------------
        logic apb_pwrite[2];
        logic [`TGT_APB_ADDR_WIDTH-1:0] apb_paddr[2];
        logic [`TGT_APB_DATA_WIDTH-1:0] apb_pwdata[2];
        logic [`TGT_APB_DATA_WIDTH-1:0] apb_prdata[2];
        logic apb_psel[2];
        logic apb_penable[2];
        // logic apb_preset_n[2];
        logic apb_pready[2];

        assign #0.5 apb_tgt_psel          = apb_psel[DUT_HOST];
        assign #0.5 apb_tgt_penable       = apb_penable[DUT_HOST];
        assign #0.5 apb_tgt_pwrite        = apb_pwrite[DUT_HOST];
        assign #0.5 apb_tgt_paddr         = apb_paddr[DUT_HOST];
        assign #0.5 apb_tgt_pwdata        = apb_pwdata[DUT_HOST];
        assign apb_prdata[DUT_HOST]   = apb_tgt_prdata;
        assign apb_pready[DUT_HOST]   = apb_tgt_pready;
        `ifdef BTB //TODO for future BTB mode
            assign #0.5 apb_psel_device        = apb_psel[DUT_DEVICE];
            assign #0.5 apb_penable_device     = apb_penable[DUT_DEVICE];
            assign #0.5 apb_pwrite_device      = apb_pwrite[DUT_DEVICE];
            assign #0.5 apb_paddr_device       = apb_paddr[DUT_DEVICE];
            assign #0.5 apb_pwdata_device      = apb_pwdata[DUT_DEVICE];
            assign apb_prdata[DUT_DEVICE] = apb_prdata_device;
            assign apb_pready[DUT_DEVICE] = apb_pready_device;
        `endif
    // ------------------------------------------------------------------
    // Task:        wait_cycle_apb
    // Description: waits for posedge of apb clk based on dut
    // Inputs:      dut_inst - host dut or device dut
    // Outputs:
    // ------------------------------------------------------------------
    task wait_cycle_apb;
        input  dut_inst;
    
        begin
            case (dut_inst)
                DUT_HOST:    @(posedge u_dut.apb_pclk);
                `ifdef BTB //TODO for future BTB mode
                    // DUT_DEVICE:  @(posedge cdns_eusb2v2_phy_top_device.APB_PCLK);
                `endif
                default:     @(posedge u_dut.apb_pclk);
            endcase
        end
    endtask

    // ------------------------------------------------------------------
    // Function    : return_dut_string
    // Description : returns string of the DUT
    // ------------------------------------------------------------------
        function string return_dut_string;
            input  dut_inst;
        
            begin
            case (dut_inst)
                DUT_HOST:    return_dut_string = "DUT_HOST";
                `ifdef BTB //TODO for future BTB mode
                // DUT_DEVICE:  return_dut_string = "DUT_DEVICE";
                `endif
                default:     return_dut_string = "DEAD_BEEF";
            endcase
            end
        endfunction  // return_dut_string
    // ------------------------------------------------------------------
    // Task:    apb_write_reg
    // Inputs:  addr      - Address of register
    //          data      - Data to be written
    //          dut_inst  - host dut or device dut
    // ------------------------------------------------------------------
    task automatic apb_write_reg;
    input [`TGT_APB_ADDR_WIDTH-1:0] addr;
    input [`TGT_APB_DATA_WIDTH-1:0] data;
    input dut_inst;

    int timeout_count = 0;
    int   timeout_max = 30;

    begin
        wait_cycle_apb(dut_inst);    
        apb_pwrite[dut_inst] <= 1;
        apb_psel[dut_inst]   <= 1;
        apb_paddr[dut_inst]  <= addr;
        apb_pwdata[dut_inst] <= data;

        wait_cycle_apb(dut_inst);
        apb_penable[dut_inst] <= 1;

        wait_cycle_apb(dut_inst);
        while ((apb_pready[dut_inst] !== 1) && (timeout_count < timeout_max)) begin
            wait_cycle_apb(dut_inst);
            timeout_count++;
        end

        if (timeout_count >= timeout_max) begin
        $error("%0t: APB PREADY timeout", $time);
        end

        wait_cycle_apb(dut_inst); // optional idle cycle
        apb_pwrite[dut_inst]  <= 0;
        apb_psel[dut_inst]    <= 0;
        apb_penable[dut_inst] <= 0;

        $display("%0t: APB WRITE to %s addr:%0h, sent value of: %0h", 
                $time, return_dut_string(dut_inst), addr, data);
    end
    endtask

    
    // ------------------------------------------------------------------
    // Task:     apb_read_reg
    // Inputs:   addr      - Address of register
    //           dut_inst  - host dut or device dut
    // Outputs:  read_data - data read from the register
    // ------------------------------------------------------------------
    task automatic apb_read_reg;
        input [`TGT_APB_ADDR_WIDTH-1:0] addr;
        input  dut_inst;
        output [`TGT_APB_DATA_WIDTH-1:0] read_data;
        int   timeout_count = 0;
        int   timeout_max = 30;
        begin
        wait_cycle_apb(dut_inst);
    
        apb_pwrite[dut_inst] <= 0;
        apb_psel[dut_inst]   <= 1;
        apb_paddr[dut_inst]  <= addr;
    
        wait_cycle_apb(dut_inst);
    
        apb_penable[dut_inst] <= 1;
    
        wait_cycle_apb(dut_inst);
    
        // while (!apb_pready[dut_inst]) begin
        //   wait_cycle_apb(dut_inst);
        // end
        // $display("apb_pready[dut_inst] = %d",apb_pready[dut_inst]);
        while ((apb_pready[dut_inst]!==1) && (timeout_count < timeout_max)) begin
            // $display("apb_pready[dut_inst] !==1");
            wait_cycle_apb(dut_inst);
            timeout_count ++;
        end
    
        if((timeout_count >= timeout_max))begin
            $error("%0t: APB PREADY timeout",$time);
        end
    
        read_data = apb_prdata[dut_inst];
        apb_psel[dut_inst]    <= 0;
        apb_penable[dut_inst] <= 0;
    
        $display("%0t: APB READ from %s addr:%0h, returned value of: %0h", $time, return_dut_string(
                dut_inst), addr, read_data);
        end
    endtask
    
    // ------------------------------------------------------------------
    // Task:     apb_read_reg_compare
    // Inputs:   addr         - Address of register
    //           dut_inst     - host dut or device dut
    //           compare_data - data to compare read against
    // ------------------------------------------------------------------
    task automatic apb_read_reg_compare;
        input [`TGT_APB_ADDR_WIDTH-1:0] addr;
        input  dut_inst;
        input [`TGT_APB_DATA_WIDTH-1:0] compare_data;
    
        reg [`TGT_APB_DATA_WIDTH-1:0] read_data;
        int   timeout_count = 0;
        int   timeout_max   = 30;
        int   num_errors    = 0;
        begin
        wait_cycle_apb(dut_inst);
    
        apb_pwrite[dut_inst] <= 0;
        apb_psel[dut_inst]   <= 1;
        apb_paddr[dut_inst]  <= addr;
    
        wait_cycle_apb(dut_inst);
    
        apb_penable[dut_inst] <= 1;
    
        wait_cycle_apb(dut_inst);
    
        //    while (!apb_pready[dut_inst]) begin
        //      wait_cycle_apb(dut_inst);
        //    end
        while (!apb_pready[dut_inst] && timeout_count < timeout_max) begin
            wait_cycle_apb(dut_inst);
            timeout_count ++;
        end
    
        if(timeout_count > timeout_max)begin
            $error( "%0t: APB PREADY timeout",$time);
        end
    
        read_data = apb_prdata[dut_inst];
        apb_psel[dut_inst]    <= 0;
        apb_penable[dut_inst] <= 0;
    
        //Make sure apb matches what was supposed to be compared with
        $display("%0t: APB READ from %s addr:%0h, returned value of: %0h", $time, return_dut_string(
                dut_inst), addr, read_data);
        if (read_data != compare_data) begin
            $error(
                "%0t: ERROR APB READ from %s addr:%0h, returned value of: %0h, and not correct value of: %0h",
                $time, return_dut_string(dut_inst), addr, read_data, compare_data);
            num_errors = num_errors + 1;
        end
        end
    endtask
    
    // ------------------------------------------------------------------
    // Task:     apb_read_reg_compare
    // Inputs:   addr         - Address of register
    //           dut_inst     - host dut or device dut
    //           compare_data - data to compare read against
    // ------------------------------------------------------------------
    task automatic apb_read_reg_compare_with_mask;
        input [`TGT_APB_ADDR_WIDTH-1:0] addr;
        input  dut_inst;
        input [`TGT_APB_DATA_WIDTH-1:0] compare_data;
        input [`TGT_APB_DATA_WIDTH-1:0] compare_mask;
    
        reg [`TGT_APB_DATA_WIDTH-1:0] read_data;
        int   timeout_count = 0;
        int   timeout_max = 30;
        int   num_errors    = 0;
        begin
        wait_cycle_apb(dut_inst);
    
        apb_pwrite[dut_inst] <= 0;
        apb_psel[dut_inst]   <= 1;
        apb_paddr[dut_inst]  <= addr;
    
        wait_cycle_apb(dut_inst);
    
        apb_penable[dut_inst] <= 1;
    
        wait_cycle_apb(dut_inst);
    
    
        while (!apb_pready[dut_inst] && timeout_count < timeout_max) begin
            wait_cycle_apb(dut_inst);
            timeout_count ++;
        end
    
        if(timeout_count > timeout_max)begin
            $error( "%0t: APB PREADY timeout",$time);
        end
    
        read_data = apb_prdata[dut_inst];
        apb_psel[dut_inst]    <= 0;
        apb_penable[dut_inst] <= 0;
    
        //Make sure apb matches what was supposed to be compared with
        $display("%0t: APB READ from %s addr:%0h, returned value of: %0h", $time, return_dut_string(
                dut_inst), addr, read_data);
        if ((read_data & compare_mask)!= (compare_data & compare_mask)) begin
            $error(
                "%0t: ERROR APB READ from %s addr:%0h, returned value of: %0h, and not correct value of: %0h",
                $time, return_dut_string(dut_inst), addr, (read_data & compare_mask), (compare_data & compare_mask));
            num_errors = num_errors + 1;
        end
        end
    endtask
    
    
    // ------------------------------------------------------------------
    // Task        : apb_write_read_reg_compare
    // Description : Will write reg, read reg then compare with what was written
    // Inputs      :  addr     - Address of register
    //                data     - data to write to reg
    //                dut_inst - host dut or device dut
    // ------------------------------------------------------------------
    task automatic apb_write_read_reg_compare;
        input [`TGT_APB_ADDR_WIDTH-1:0] addr;
        input [`TGT_APB_DATA_WIDTH-1:0] data;
        input  dut_inst;
    
        begin
        apb_write_reg(addr, data, dut_inst);   
        apb_read_reg_compare(addr, dut_inst, data);
        end
    endtask
    
    
    // ------------------------------------------------------------------
    // Task        : apb_write_read_reg_compare_readonly
    // Description : Will write reg, read reg which is include readonly regs then compare with what was written
    // Inputs      :  addr     - Address of register
    //                data     - data to write to reg
    //                dut_inst - host dut or device dut
    // ------------------------------------------------------------------
    task automatic apb_write_read_reg_compare_readonly;
        input [`TGT_APB_ADDR_WIDTH-1:0] addr;
        input [`TGT_APB_DATA_WIDTH-1:0] data;
        input  dut_inst;
        input [`TGT_APB_DATA_WIDTH-1:0] data_readonly;
    
        begin
        apb_write_reg(addr, data, dut_inst);   
        apb_read_reg_compare(addr, dut_inst, data_readonly);
        end
    endtask
    
    
    // ------------------------------------------------------------------
    // Task:    apb_write_field
    // Inputs:  addr      - Address of register
    //          bitOffset - BitOffset of field
    //          bitWidth  - BitWidth  of field
    //          data      - Data to be written
    //          dut_type  - host dut or device dut
    // ------------------------------------------------------------------
    task apb_write_field (
        input [`TGT_APB_ADDR_WIDTH-1:0] addr,
        input [7:0]                bitOffset,
        input [7:0]                bitWidth,
        input [`TGT_APB_DATA_WIDTH-1:0] data,
        input  dut_type);
    
        bit [`TGT_APB_DATA_WIDTH-1:0] rdata;
        apb_read_reg(addr, dut_type, rdata);
        //rdata[bitOffset+:bitWidth] = data[0+:bitWidth];
        for(int i = 0; i < bitWidth; i++) begin
        rdata[(bitOffset+i)+:1] = data[(0+i)+:1];
        end
        apb_write_reg(addr, rdata, dut_type);
    
    endtask
    
    // ------------------------------------------------------------------
    // Task:     apb_read_field
    // Inputs:   addr      - Address of register
    //           bitOffset - BitOffset of field
    //           bitWidth  - BitWidth  of field
    //           dut_type  - host dut or device dut
    // Outputs:  read_data - data read from the field
    // ------------------------------------------------------------------
    task apb_read_field(
        input [`TGT_APB_ADDR_WIDTH-1:0] addr,
        input [7:0]                bitOffset,
        input [7:0]                bitWidth,
        input                      dut_type,
        output [`TGT_APB_DATA_WIDTH-1:0] read_data);
    
        bit [`TGT_APB_DATA_WIDTH-1:0] rdata;
        bit [`TGT_APB_DATA_WIDTH-1:0] rdata_file = 32'h0;
        apb_read_reg(addr, dut_type, rdata);
        //read_data[0+:bitWidth] = rdata[bitOffset+:bitWidth];
        for(int i = 0; i < bitWidth; i++) begin
        read_data[(0+i)+:1] = rdata[(bitOffset+i)+:1];
        rdata_file[(0+i)+:1] = rdata[(bitOffset+i)+:1];
        end
    endtask

    // ------------------------------------------------------------------
    // Task:    mb_wr_uncmt
    // Description:   message_bus_write_uncommitted
    // Inputs:  addr      - Address of register
    //          wdata     - Data to be written
    //          lane      - Laen to be written
    // ------------------------------------------------------------------
    task mb_wr_uncmt(
        // input cmd,
        input[11:0] addr,
        input[7:0]  wdata,
        input       lane);  

        logic[3:0] delay;
        delay = $urandom_range('b1111, 0);
        if(lane == 0) begin
            @(negedge pipe7_clk_max);
                pipe7_l00_m2p_messagebus[7:0] = {4'b0010,addr[11:8]};
            @(negedge pipe7_clk_max);
                pipe7_l00_m2p_messagebus[7:0] = addr[7:0];
            @(negedge pipe7_clk_max);
                pipe7_l00_m2p_messagebus[7:0] = wdata[7:0];
            repeat(delay)   begin
                @(negedge pipe7_clk_max);
            end
            pipe7_l00_m2p_messagebus[7:0] = 0;
        end
        else if(lane == 1 ) begin
            @(negedge pipe7_clk_max);
                pipe7_l01_m2p_messagebus[7:0] = {4'b0010,addr[11:8]};
            @(negedge pipe7_clk_max);
                pipe7_l01_m2p_messagebus[7:0] = addr[7:0];
            @(negedge pipe7_clk_max);
                pipe7_l01_m2p_messagebus[7:0] = wdata[7:0];
            repeat(delay)   begin
                @(negedge pipe7_clk_max);
            end
            pipe7_l01_m2p_messagebus[7:0] = 0;
        end
        else begin
            $error("Missing of lane sel");
        end
    endtask
    // ------------------------------------------------------------------
    // Task:    mb_wr_cmt
    // Description:   message_bus_write_committed
    // Inputs:  addr      - Address of register
    //          wdata     - Data to be written
    //          lane      - Laen to be written
    // ------------------------------------------------------------------
    task mb_wr_cmt(
        // input cmd,
        input[11:0] addr,
        input[7:0]  wdata,
        input       lane);  

        logic[3:0]  delay;
        logic       wr_ack;
        int repeat_cnt;

        delay   = $urandom_range('b1111, 0);
        wr_ack  = 0;
        if(lane == 0) begin
            @(negedge pipe7_clk_max);
                pipe7_l00_m2p_messagebus[7:0] = {4'b0010,addr[11:8]};
            @(negedge pipe7_clk_max);
                pipe7_l00_m2p_messagebus[7:0] = addr[7:0];
            @(negedge pipe7_clk_max);
                pipe7_l00_m2p_messagebus[7:0] = wdata[7:0];
            // repeat(delay)   begin
            //     @(negedge pipe7_clk_max);
            // end
            @(negedge pipe7_clk_max);
            pipe7_l00_m2p_messagebus[7:0] = 0;

            for (int i = 0; i < 100; i++) begin
                @(posedge pipe7_clk_max);
                if (pipe7_l00_p2m_messagebus == 8'b0101_0000) begin
                    break;
                end
                repeat_cnt = i;
            end
            if (repeat_cnt == 100) begin
                $error("[Error]: write_ack not recived within 100 cycle in lane00");
            end
        end
        else if(lane == 1 ) begin
            @(negedge pipe7_clk_max);
                pipe7_l01_m2p_messagebus[7:0] = {4'b0010,addr[11:8]};
            @(negedge pipe7_clk_max);
                pipe7_l01_m2p_messagebus[7:0] = addr[7:0];
            @(negedge pipe7_clk_max);
                pipe7_l01_m2p_messagebus[7:0] = wdata[7:0];
            // repeat(delay)   begin
            //     @(negedge pipe7_clk_max);
            // end
                @(negedge pipe7_clk_max);
            pipe7_l01_m2p_messagebus[7:0] = 0;

            for (int i = 0; i < 100; i++) begin
                @(posedge pipe7_clk_max);
                if (pipe7_l01_p2m_messagebus == 8'b0101_0000) begin
                    break;
                end
                repeat_cnt = i;
            end
            if (repeat_cnt == 100) begin
                $error("[Error]: write_ack not recived within 100 cycle in lane01");
            end
        end
        else begin
            $display("Missing of lane sel");
        end
    endtask
    // ------------------------------------------------------------------
    // Task:    mb_rd
    // Description:   message_bus_read
    // Inputs:  addr      - Address of register
    //          rdata     - Data to be readed
    //          lane      - Laen to be readed
    // ------------------------------------------------------------------
    task mb_rd(
        input[11:0]     addr,
        input           lane,
        output[7:0]     rdata);
        logic[3:0]  delay;
        delay   = $urandom_range('b1111, 0);
        if(lane == 0) begin
            @(negedge pipe7_clk_max);
                pipe7_l00_m2p_messagebus[7:0] = {4'b0011,addr[11:8]};
            @(negedge pipe7_clk_max);
                pipe7_l00_m2p_messagebus[7:0] = addr[7:0];
            // repeat(delay)   begin
            //     @(negedge pipe7_clk_max);
            // end
                @(negedge pipe7_clk_max);
            pipe7_l00_m2p_messagebus[7:0] = 0;

            for (int i = 0; i < 100; i++) begin
                @(posedge pipe7_clk_max);
                if (pipe7_l00_p2m_messagebus == 8'b010_0000) begin
                    break;
                end
            end
            @(posedge pipe7_clk_max);
                rdata = pipe7_l00_p2m_messagebus;
        end
        else if(lane == 1 ) begin
            @(negedge pipe7_clk_max);
                pipe7_l01_m2p_messagebus[7:0] = {4'b0011,addr[11:8]};
            @(negedge pipe7_clk_max);
                pipe7_l01_m2p_messagebus[7:0] = addr[7:0];
            // repeat(delay)   begin
            //     @(negedge pipe7_clk_max);
            // end
                @(negedge pipe7_clk_max);
            pipe7_l01_m2p_messagebus[7:0] = 0;

            for (int i = 0; i < 100; i++) begin
                @(posedge pipe7_clk_max);
                if (pipe7_l01_p2m_messagebus == 8'b010_0000) begin
                    break;
                end
            end
            @(posedge pipe7_clk_max);
                rdata = pipe7_l01_p2m_messagebus;
        end
        else begin
            $error("Missing of lane sel");
        end
    endtask
`endif