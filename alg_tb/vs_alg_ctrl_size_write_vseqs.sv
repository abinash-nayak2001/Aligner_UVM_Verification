`ifndef VS_ALG_CTRL_SIZE_WRITE_VSEQS_SV
  `define VS_ALG_CTRL_SIZE_WRITE_VSEQS_SV

class vs_alg_ctrl_size_write_vseqs extends cfs_algn_virtual_sequence_base;
  `uvm_object_utils(vs_alg_ctrl_size_write_vseqs)

  cfs_algn_reg_block block;
  bit [2:0]size_val;

  function new(string name = "vs_alg_ctrl_size_write_vseqs");
    super.new(name);
  endfunction

  virtual task body();
    uvm_status_e status;
		block = p_sequencer.model.reg_block;

    assert(block.CTRL.randomize() with {SIZE.value == size_val;}) else
			`uvm_error("REG_SEQ","RANDOMIZATION FAILED")
			
		block.CTRL.update(status);

    `uvm_info("SIZE_WRITE_SEQ",$sformatf("DES VALUE OF CTRL : %0h",block.CTRL.get()),UVM_HIGH)
		`uvm_info("SIZE_WRITE_SEQ",$sformatf("MIR VALUE OF CTRL : %0h",block.CTRL.get_mirrored_value()),UVM_HIGH)
  endtask

  virtual task write_size(input uvm_sequencer_base vseqr = null, input bit [2:0]s_val = 3'h0);
    if(s_val == 0)
      `uvm_error("WRITE_SIZE","Trying to write an illegal value of CTRL.SIZE")
    else
      size_val = s_val;

    this.start(vseqr);
  endtask
endclass

`endif
