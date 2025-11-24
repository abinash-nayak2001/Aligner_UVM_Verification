`ifndef VS_ALG_ILLEGAL_CONFIG_VSEQS_SV
  `define VS_ALG_ILLEGAL_CONFIG_VSEQS_SV

class vs_alg_illegal_config_vseqs extends cfs_algn_virtual_sequence_base;
  `uvm_object_utils(vs_alg_illegal_config_vseqs)

  cfs_algn_reg_block block;
  int unsigned alg_data_width = 32;

  function new(string name = "vs_alg_illegal_config_vseqs");
    super.new(name);
  endfunction

  task body();
    uvm_status_e status;
    int unsigned reg_value_before_trans;
		block = p_sequencer.model.reg_block;
    
    block.CTRL.legal_size.constraint_mode(0);
    block.CTRL.legal_size_offset.constraint_mode(0);

    assert(block.CTRL.randomize() with {
            ((alg_data_width / 8) + OFFSET.value) % SIZE.value != 0;
            SIZE.value dist {0:=2, [1:7]:=10};
            }) else
			`uvm_error("REG_SEQ","RANDOMIZATION FAILED")
    
    reg_value_before_trans = block.CTRL.get_mirrored_value();
    block.CTRL.update(status);
    if(reg_value_before_trans !== block.CTRL.get_mirrored_value())
      `uvm_fatal("REG_SEQ","DUT REGISTER HAS BEEN UPDATED..... IT SHOULD NOT BE AS THE TRANSACTION IS ILLEGAL")
  endtask

endclass

`endif
