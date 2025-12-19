`ifndef VS_ALG_RX_LEN_LARGE_VSEQS_SV
  `define VS_ALG_RX_LEN_LARGE_VSEQS_SV

class vs_alg_rx_len_large_vseqs extends cfs_algn_virtual_sequence_base;
  `uvm_object_utils(vs_alg_rx_len_large_vseqs)

  vs_alg_imm_delay_rx_seq imm_rx_seq;
  vs_alg_tx_length_vseqs tx_seq;

  function new(string name = "vs_alg_rx_len_large_vseqs");
    super.new(name);
  endfunction

  task body();
    fork
      begin
        imm_rx_seq = vs_alg_imm_delay_rx_seq::type_id::create("imm_rx_seq");
        imm_rx_seq.start(p_sequencer.md_rx_sequencer);
      end

      begin
        tx_seq = vs_alg_tx_length_vseqs::type_id::create("tx_seq");
        tx_seq.start(p_sequencer);
      end
    join
  endtask

endclass

`endif
