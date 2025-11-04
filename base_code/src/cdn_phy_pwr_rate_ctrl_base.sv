`ifndef CDN_PHY_PWR_RATE_CTRL_BASE_SV
`define CDN_PHY_PWR_RATE_CTRL_BASE_SV

class cdn_phy_pwr_rate_ctrl_base extends uvm_component;


    typedef enum logic [2:0] {START,USB4_EN,USB3_EN,DP_EN,ENTER_CMN_SUSPEND} state_t;

    cdn_phy_tb_config tb_cfg;
    cdn_phy_dut_config dut_cfg;
    cdn_phy_dut_config device_dut_cfg;
    cdn_phy_virtual_sequencer_base vsqr;

    state_t current_state,next_state;
    bit usb4_cmn_suspend;
    bit usb3_cmn_suspend;
    bit dp_cmn_suspend;
    
    string report_id = "cdn_phy_pwr_rate_ctrl_base";

    `uvm_component_utils_begin(cdn_phy_pwr_rate_ctrl_base)
    `uvm_component_utils_end

    extern function new(string name = "cdn_phy_pwr_rate_ctrl_base", uvm_component parent = null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);

endclass

function cdn_phy_pwr_rate_ctrl_base::new(string name = "cdn_phy_pwr_rate_ctrl_base", uvm_component parent = null);
    super.new(name,parent);
endfunction

function void cdn_phy_pwr_rate_ctrl_base::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(cdn_phy_tb_config)::get(this, "", "tb_cfg", tb_cfg)) begin
        `uvm_fatal(report_id, "tb cfg not get correctlly!")
    end 
    if(!uvm_config_db#(cdn_phy_dut_config)::get(this, "", "dut_cfg", dut_cfg)) begin
        `uvm_fatal(report_id, "tb cfg not get correctlly!")
    end 
    if(!uvm_config_db#(cdn_phy_dut_config)::get(this, "", "device_dut_cfg", device_dut_cfg)) begin
        `uvm_fatal(report_id, "tb cfg not get correctlly!")
    end 
    vsqr = cdn_phy_virtual_sequencer_base::type_id::create("vsqr", this);
endfunction


task cdn_phy_pwr_rate_ctrl_base::main_phase(uvm_phase phase );
    `uvm_info (report_id,"Start to excute phy_pwr_rate_ctrl_component",UVM_LOW)
    while (1) begin
      
        
    end 
endtask

// *************************************** register task ***********************************************************************/

// read cmn
task cdn_phy_pwr_rate_ctrl_base::read_register_cmn(input string reg_name,input int bit_location, output bit rdata);
    `uvm_info(report_id,$psprintf("read %s_%0d, waiting this bit to be asserted ...",reg_name,bit_location),UVM_LOW)
    vsqr.regmodel.phy_pma_cmn_reg_block.read_dut_field($psprintf("%s_%0d",reg_name,bit_location),rdata);
endtask 

//read ln
task cdn_phy_pwr_rate_ctrl_base::read_register_ln(input string reg_name,input int bit_location, input int lane_id,output bit rdata);
    `uvm_info(report_id,$psprintf("read %s_%0d, waiting this bit to be asserted ...",reg_name,bit_location),UVM_LOW)
    vsqr.regmodel.phy_pcs_lane_reg_block[lane_id].read_dut_field($psprintf("%s_%0d",reg_name,bit_location),rdata);
endtask 

//polling cmn
task cdn_phy_pwr_rate_ctrl_base::polling_register_cmn(string cmn_part,input string reg_name,input int bit_location, input bit exp_value);
    `uvm_info(report_id,$psprintf("polling %s_%0d, waiting this bit to be asserted ...",reg_name,bit_location),UVM_LOW)
    time timeout = 1ms;
    bit [63:0] rdata;
    fork
    begin
    while(!(rdata[bit_location] == exp_value)) begin
        if (cmn_part == "phy_pcs_cmn") begin
            vsqr.regmodel.phy_pcs_cmn_reg_block.read_dut_field($psprintf("%s_%0d",reg_name,bit_location),rdata);
        end else if (cmn_part == "phy_pma_cmn")begin
            vsqr.regmodel.phy_pma_cmn_reg_block.read_dut_field($psprintf("%s_%0d",reg_name,bit_location),rdata);
        end else if (cmn_part == "pma_cmn") begin
            vsqr.regmodel.pma_cmn_reg_block.read_dut_field($psprintf("%s_%0d",reg_name,bit_location),rdata);
        end else begin
            `uvm_fatal(report_id, "please give the cmn_part correctly!")
        end 
    end
    `uvm_info(report_id,$psprintf("polling %s_%0d, waiting this bit to be asserted Done Done Done ...",reg_name,bit_location),UVM_LOW) 
    end 
    begin
        #timeout;
        `uvm_info(report_id,$psprintf("polling %s_%0d, waiting this bit to be asserted timeout ...",reg_name,bit_location),UVM_LOW)
    end 
    join_any
    disable fork;
endtask 

// polling lane
task cdn_phy_pwr_rate_ctrl_base::polling_register_ln(input string reg_name,input int bit_location, input int lane_id, output bit rdata);
    `uvm_info(report_id,$psprintf("polling %s_%0d, waiting this bit to be asserted ...",reg_name,bit_location),UVM_LOW)
    time timeout = 1ms;
    bit [63:0] rdata = 'd0;
    fork
    begin
    while(!rdata[bit_location]) begin
        vsqr.regmodel.phy_pcs_lane_reg_block[lane_id].read_dut_field($psprintf("%s_%0d",reg_name,bit_location),rdata);
    end
    `uvm_info(report_id,$psprintf("polling %s_%0d, waiting this bit to be asserted Done Done Done ...",reg_name,bit_location),UVM_LOW) 
    end 
    begin
        #timeout;
        `uvm_info(report_id,$psprintf("polling %s_%0d, waiting this bit to be asserted timeout ...",reg_name,bit_location),UVM_LOW)
    end 
    join_any
    disable fork;
endtask 

// write cmn 
task cdn_phy_pwr_rate_ctrl_base::write_register_cmn(string cmn_part, input string reg_name,input int bit_location,input bit wr_value);
    `uvm_info(report_id,$psprintf("Writing %s_%0d, waiting this bit to be writed ...",reg_name,bit_location),UVM_LOW)
    if (cmn_part == "phy_pcs_cmn") begin
        vsqr.regmodel.phy_pcs_cmn_reg_block.read_dut_field($psprintf("%s_%0d",reg_name,bit_location),wr_value);
    end else if (cmn_part == "phy_pma_cmn")begin
        vsqr.regmodel.phy_pma_cmn_reg_block.read_dut_field($psprintf("%s_%0d",reg_name,bit_location),wr_value);
    end else if (cmn_part == "pma_cmn") begin
        vsqr.regmodel.pma_cmn_reg_block.read_dut_field($psprintf("%s_%0d",reg_name,bit_location),wr_value);
    end else begin
        `uvm_fatal(report_id, "please give the cmn_part correctly!")
    end 
endtask

// write ln
task cdn_phy_pwr_rate_ctrl_base::write_register_ln(input string reg_name,input int bit_location, input int lane_id ,input wr_value);
    `uvm_info(report_id,$psprintf("Writing %s_%0d, waiting this bit to be writed ...",reg_name,bit_location),UVM_LOW)
    vsqr.regmodel.phy_pcs_lane_reg_block[lane_id].write_dut_field($psprintf("%s_%0d",reg_name,bit_location),wr_value);
endtask 

/*********************************************************************************************************************************/

task cdn_phy_pwr_rate_ctrl_base::cmn_power_off_fsm();
    bit rdata;
    current_state = next_state;
    case (current_state)
        START: begin 
            next_state = USB4_EN;
        end
        USB4_EN: begin  
            if (tb_cfg.std_mode == USB4_MODE) begin
                // -- read the pll en fall interrupt -> power off
                read_register_cmn("phy_uc_cmn_int_sts",7,rdata);
                if (rdata == 1'b1) begin
                    // -- write 1 to clear pipe7 pll ok
                    write_register_cmn("phy_ctrl",5,'b1);
                    // -- write 1 to clear the pll en fall interrupt
                    write_register_cmn("phy_uc_cmn_int_sts",7,1'b1);
                    usb4_cmn_suspend = 1'b1;
                end 
            end else begin
                usb4_cmn_suspend =1'b1;
            end 
            next_state = USB3_EN;
        end
        USB3_EN: begin
            if(tb_cfg.std_mode == USB32_MODE) begin
                // -- read ln0 cmn suspend req rise interrupt
                read_register_ln("phy_uc_pcs_int_sts2",0,'d0,rdata);
                if(rdata == 1'b1) begin
                    // -- write 1 to clear the cmn_suspend_req_rise interrupt
                    write_register_ln("phy_uc_pcs_int_sts2",0,1'b1);
                    // -- write 1 to set ln 0 /1 cmn suspend ack to 1 
                    write_register_ln("phy_pipe_ln_ctrl_sts",25,0,1'b1); // ln0
                    write_register_ln("phy_pipe_ln_ctrl_sts",25,1,1'b1); // ln1
                    usb3_cmn_suspend = 1'b1;
                end 
            end else begin
                usb3_cmn_suspend = 1'b1;
            end 
            next_state = DP_EN;
        end
        DP_EN: begin
            if(tb_cfg.std_mode == DP_MODE) begin
                // -- read pma xcvr power state ack rise interrupt, --->   read ln1 
                read_register_ln("phy_uc_pma_int_sts1",9,'d0, rdata);
                if (rdata == 1'b1) begin
                    // -- polling pma xcvr pllclk en ack == 0, if ack not equal 0, this polling task will timeout
                    polling_register_cmn("phy_pcs_cmn","phy_iso_cmn_ctrl1_reg",31,0);
                    // -- clear pma xcvr power state ack rise interrupt  write 1 -> clear 
                    write_register_ln("phy_uc_pma_int_sts1",9,'d0,1'b1)
                    dp_cmn_suspend = 1'b1;
                end 
            end 
            // alt_mode
            if(tb_cfg.std_mode == ALT_MODE) begin
                 // -- read pma xcvr power state ack rise interrupt,  ---> read ln2
                read_register_ln("phy_uc_pma_int_sts1",9,'d2, rdata);
                if (rdata == 1'b1) begin
                    // -- polling pma xcvr pllclk en ack == 0, if ack not equal 0, this polling task will timeout
                    polling_register_cmn("phy_pcs_cmn","phy_iso_cmn_ctrl1_reg",31,0);
                    // -- clear pma xcvr power state ack rise interrupt  write 1 -> clear 
                    write_register_ln("phy_uc_pma_int_sts1",9,'d2,1'b1)
                    dp_cmn_suspend = 1'b1;
                end 
            end 
            // -- judge dp,usb3 and usb4 all go to suspend already.
            if (usb4_cmn_suspend && usb3_cmn_suspend && dp_cmn_suspend) begin
                next_state = ENTER_CMN_SUSPEND;
            end else begin
                next_state = START;
            end 
        end
        ENTER_CMN_SUSPEND : begin
            enter_cmn_suspend_op();
            next_state = START;
        end 
    endcase
endtask

// enter cmn suspend fsm

//alt mode TODO
task cdn_phy_pwr_rate_ctrl_base::enter_cmn_suspend_op();
    if(tb_cfg.std_mode == USB32_MODE || tb_cfg.std_mode == USB4_MODE ) begin
        // -- write 1 to set pll0 suspend request
        write_register_cmn("phy_pma_cmn","phy_pma_cmn_ctrl_sts",'d4,1'b1);
        // -- polling pll0 suspend ack rise interrupt
        polling_register_cmn("phy_pma_cmn","phy_uc_cmn_int_sts",'d16,1'b1);
        // -- write 1 to clear interrupt
        write_register_cmn("phy_pma_cmn","phy_uc_cmn_int_sts",'d16,1'b1)
    end 

    if (tb_cfg.std_mode == DP_MODE) begin
        // -- write 1 to set pll1 suspend request
        write_register_cmn("phy_pma_cmn","phy_pma_cmn_ctrl_sts",'d12,1'b1);
        // -- polling pll1 suspend ack rise interrupt
        polling_register_cmn("phy_pma_cmn","phy_uc_cmn_int_sts",'d22,1'b1);
        // -- write 1 to clear interrupt
        write_register_cmn("phy_pma_cmn","phy_uc_cmn_int_sts",'d22,1'b1);
    end 

    // -- write 1 to set pma macro suspend req 
    write_register_cmn("phy_pma_cmn","phy_pma_cmn_ctrl_sts",'d19,1'b1);
    // -- polling pma macro suspend ack rise interrupt
    polling_register_cmn("phy_pma_cmn","phy_uc_cmn_int_sts",'d4,1'b1);
    // -- write 1 to clear pma macro suspend ack rise  interrupt
    write_register_cmn("phy_pma_cmn","phy_uc_cmn_int_sts",'d4,1'b1);
end 








`endif 