`ifndef VS_ALG_ILLEGAL_RX_RANDOM_VSEQS_SV
  `define VS_ALG_ILLEGAL_RX_RANDOM_VSEQS_SV

class vs_alg_illegal_rx_random_vseqs extends cfs_algn_virtual_sequence_base;
  `uvm_object_utils(vs_alg_illegal_rx_random_vseqs)
  
  rand vs_alg_master_rx_seq seq;
	int unsigned alg_data_width;
  
  function new(string name = "vs_alg_illegal_rx_random_vseqs");
    super.new(name);
    seq = vs_alg_master_rx_seq::type_id::create("seq");

    seq.item.data_default.constraint_mode(0);
    seq.item.offset_default.constraint_mode(0); 
    alg_data_width = 32;
  endfunction

  task body();
    seq.set_sequencer(p_sequencer.md_rx_sequencer);

    assert(seq.randomize() with {
            item.offset inside {[0:3]};
            ((alg_data_width/8)+item.offset)%item.data.size() != 0;
            item.offset + item.data.size() <= alg_data_width/8;
            item.data.size() dist {0:=2, [1:4]:=10};
            }) else 
            `uvm_error("RX_SEQ","RANDOMIZATION FAILED")

    seq.start(p_sequencer.md_rx_sequencer);
  endtask
endclass

`endif
