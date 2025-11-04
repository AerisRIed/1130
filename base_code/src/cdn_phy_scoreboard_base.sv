//
// Template for UVM Scoreboard

`ifndef CDN_PHY_SCOREBOARD_BASE__SV
`define CDN_PHY_SCOREBOARD_BASE__SV


class cdn_phy_scoreboard_base extends uvm_scoreboard;
   cdn_phy_tb_config           tb_cfg;
   cdn_phy_dut_config          dut_cfg;

   //uvm_analysis_export #(cdn_phy_transaction_base) before_export, after_export;
   //uvm_in_order_class_comparator #(cdn_phy_transaction_base) comparator;

   `uvm_component_utils(cdn_phy_scoreboard_base)
	extern function new(string name = "cdn_phy_scoreboard_base",
                    uvm_component parent = null); 
	extern virtual function void build_phase (uvm_phase phase);
	extern virtual function void connect_phase (uvm_phase phase);
	extern virtual task main_phase(uvm_phase phase);
	extern virtual function void report_phase(uvm_phase phase);

endclass: cdn_phy_scoreboard_base


function cdn_phy_scoreboard_base::new(string name = "cdn_phy_scoreboard_base",
                 uvm_component parent);
   super.new(name,parent);
endfunction: new

function void cdn_phy_scoreboard_base::build_phase(uvm_phase phase);
    super.build_phase(phase);
	if (!uvm_config_db#(cdn_phy_tb_config)::get(this, "", "tb_cfg", tb_cfg)) begin
     `uvm_fatal(get_type_name(), "tb_cfg not get")
    end
    if (!uvm_config_db#(cdn_phy_dut_config)::get(this, "", "dut_cfg", dut_cfg)) begin
     `uvm_fatal(get_type_name(), "dut_cfg not get")
    end
    //before_export = new("before_export", this);
    //after_export  = new("after_export", this);
    //comparator    = new("comparator", this);
endfunction:build_phase

function void cdn_phy_scoreboard_base::connect_phase(uvm_phase phase);
    //before_export.connect(comparator.before_export);
    //after_export.connect(comparator.after_export);
endfunction:connect_phase

task cdn_phy_scoreboard_base::main_phase(uvm_phase phase);
    super.main_phase(phase);
    //phase.raise_objection(this,"scbd..");
	//comparator.run();
    //phase.drop_objection(this);
endtask: main_phase 

function void cdn_phy_scoreboard_base::report_phase(uvm_phase phase);
    super.report_phase(phase);
    //`uvm_info("SBRPT", $psprintf("Matches = %0d, Mismatches = %0d",
    //           comparator.m_matches, comparator.m_mismatches),
    //           UVM_MEDIUM);
endfunction:report_phase

`endif // CDN_PHY_SCOREBOARD_BASE__SV
