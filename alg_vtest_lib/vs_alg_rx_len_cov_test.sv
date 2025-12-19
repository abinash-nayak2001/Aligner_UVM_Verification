`ifndef VS_ALG_RX_LEN_COV_TEST_SV
  `define VS_ALG_RX_LEN_COV_TEST_SV

class vs_alg_rx_len_cov_test extends cfs_algn_test_base;
  `uvm_component_utils(vs_alg_rx_len_cov_test)

  vs_alg_max_size_rx_vseqs msize_rx_seq;
  vs_alg_rx_len_large_vseqs rx_large_seq;
  vs_alg_ctrl_size_write_vseqs ctrl_size_wseq;
  
  int unsigned n_bytes_in_buffer = 0;

  function new(string name = "vs_alg_rx_len_cov_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this, "TEST_DONE");
    #50;

    ctrl_size_wseq = vs_alg_ctrl_size_write_vseqs::type_id::create("crtl_size_wseq");
    ctrl_size_wseq.write_size(env.virtual_sequencer,3'h4);

    n_bytes_in_buffer = 0;
    repeat(18)
    begin
      msize_rx_seq = vs_alg_max_size_rx_vseqs::type_id::create("msize_rx_seq");
      msize_rx_seq.start(env.virtual_sequencer);
      n_bytes_in_buffer = n_bytes_in_buffer + 4;
    end

    repeat(20)
    begin
      rx_large_seq = vs_alg_rx_len_large_vseqs::type_id::create("rx_large_seq");
      rx_large_seq.start(env.virtual_sequencer);
    end
       
    phase.phase_done.set_drain_time(this,500);
    phase.drop_objection(this, "TEST_DONE");
  endtask
endclass

`endif
// Configure register with size4 and try
