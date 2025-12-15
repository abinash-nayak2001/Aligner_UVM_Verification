`ifndef VS_ALG_TX_LEN_LARGE_VSEQS_SV
  `define VS_ALG_TX_LEN_LARGE_VSEQS_SV

class vs_alg_tx_len_large_vseqs extends cfs_algn_virtual_sequence_base;
   `uvm_object_utils(vs_alg_tx_len_large_vseqs)

  cfs_md_sequence_simple_slave seq;

  function new(string name = "vs_alg_tx_len_large_vseqs");
    super.new(name);
  endfunction

  task body();
    cfs_md_item_mon item_mon;
    p_sequencer.md_tx_sequencer.pending_items.get(item_mon);

    seq = cfs_md_sequence_simple_slave::type_id::create("seq");
    seq.set_sequencer(p_sequencer.md_tx_sequencer);

    seq.item.length_default.constraint_mode(0);
    
    assert(seq.randomize() with {seq.item.length inside {[4:11]};}) else
      `uvm_error("TX_ERR_SEQ","RANDOMIZATION FAILED")
		
		seq.start(p_sequencer.md_tx_sequencer);
  endtask

endclass

`endif
