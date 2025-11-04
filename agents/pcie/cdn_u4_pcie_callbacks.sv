// pre symbol_pattern peocess can be uesd for err injection
class cdn_callback extends uvm_callback;
	// some variable define
	bit cb_en;
	// process
	virtual function void  pre_symbol_pattern_process(cdn_u4_pcie_symbol_pattern symbol_pattern);
    endfunction
endclass
