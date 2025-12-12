`ifndef VS_ALG_TX_ERR_VSEQS_SV
  `define VS_ALG_TX_ERR_VSEQS_SV

class vs_alg_tx_err_vseqs extends cfs_algn_virtual_sequence_base;
  `uvm_object_utils(vs_alg_tx_err_vseqs)

  cfs_md_sequence_simple_slave seq;

  function new(string name = "vs_alg_tx_err_vseqs");
    super.new(name);
  endfunction

  task body();
    cfs_md_item_mon item_mon;
    p_sequencer.md_tx_sequencer.pending_items.get(item_mon);

    seq = cfs_md_sequence_simple_slave::type_id::create("seq");
    seq.set_sequencer(p_sequencer.md_tx_sequencer);
    
    assert(seq.randomize() with {seq.item.response == CFS_MD_ERR;}) else
      `uvm_error("TX_ERR_SEQ","RANDOMIZATION FAILED")
		
		seq.start(p_sequencer.md_tx_sequencer);
  endtask
endclass

`endif
