`ifndef VS_ALG_STATUS_READ_VSEQS_SV
  `define VS_ALG_STATUS_READ_VSEQS_SV

class vs_alg_status_read_vseqs extends cfs_algn_virtual_sequence_base;
  `uvm_object_utils(vs_alg_status_read_vseqs)
	
	cfs_algn_reg_block block;
	
	function new(string name = "vs_alg_status_read_vseqs");
		super.new(name);
	endfunction

  virtual task body();
    uvm_reg_data_t rd_data;
    uvm_status_e status;
    block = p_sequencer.model.reg_block;

    block.STATUS.read(status, rd_data);

    `uvm_info("STATUS_REG",$sformatf("DATA READ FROM STATUS REG : %0h", block.STATUS.get_mirrored_value()),UVM_LOW)
  endtask

endclass

`endif
