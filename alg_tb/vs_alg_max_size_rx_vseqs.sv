`ifndef VS_ALG_MAX_SIZE_RX_VSEQS_SV
  `define VS_ALG_MAX_SIZE_RX_VSEQS_SV

class vs_alg_max_size_rx_vseqs extends cfs_algn_virtual_sequence_base;
   `uvm_object_utils(vs_alg_max_size_rx_vseqs)
  
  rand vs_alg_master_rx_seq seq;
	int unsigned alg_data_width;
  
  function new(string name = "vs_alg_max_size_rx_vseqs");
    super.new(name);
    seq = vs_alg_master_rx_seq::type_id::create("seq");

    seq.item.data_default.constraint_mode(0);
    seq.item.offset_default.constraint_mode(0); 
    alg_data_width = 32;
  endfunction

  task body();
    seq.set_sequencer(p_sequencer.md_rx_sequencer);

    assert(seq.randomize() with {
            item.data.size == 4;
            item.offset == 0;
            }) else 
            `uvm_error("RX_SEQ","RANDOMIZATION FAILED")

    seq.start(p_sequencer.md_rx_sequencer);
  endtask
endclass

`endif
