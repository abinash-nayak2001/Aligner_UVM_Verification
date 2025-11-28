`ifndef VS_ALG_CLR_REG_VSEQS_SV
  `define VS_ALG_CLR_REG_VSEQS_SV

class vs_alg_clr_reg_vseqs extends cfs_algn_virtual_sequence_base;
  `uvm_object_utils(vs_alg_clr_reg_vseqs)
	
	cfs_algn_reg_block block;
	
	function new(string name = "vs_alg_clr_reg_vseqs");
		super.new(name);
	endfunction
	
	virtual task body();
		uvm_status_e status;
		block = p_sequencer.model.reg_block;
		
		assert(block.CTRL.randomize() with {CLR.value == 1;}) else
			`uvm_error("REG_SEQ","RANDOMIZATION FAILED")
			
		block.CTRL.update(status);
		
		`uvm_info("REG_BLOCK",$sformatf("DES VALUE OF CTRL : %0h",block.CTRL.get()),UVM_HIGH)
		`uvm_info("REG_BLOCK",$sformatf("MIR VALUE OF CTRL : %0h",block.CTRL.get_mirrored_value()),UVM_HIGH)
	endtask
endclass

`endif
