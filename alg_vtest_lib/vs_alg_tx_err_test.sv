`ifndef VS_ALG_TX_ERR_TEST_SV
  `define VS_ALG_TX_ERR_TEST_SV

class vs_alg_tx_err_test extends cfs_algn_test_base;
  `uvm_component_utils(vs_alg_tx_err_test)

  vs_alg_max_size_rx_vseqs msize_rx_seq;
  vs_alg_tx_err_vseqs tx_err_seq;
  int unsigned n_rx_seq = 1;

  function new(string name = "vs_alg_tx_err_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this, "TEST_DONE");
    #50;
    

    fork
      begin
        repeat(n_rx_seq)
        begin
          msize_rx_seq = vs_alg_max_size_rx_vseqs::type_id::create("msize_rx_seq");
          msize_rx_seq.start(env.virtual_sequencer);
        end
      end

      begin
        repeat(n_rx_seq*4)
        begin
          tx_err_seq = vs_alg_tx_err_vseqs::type_id::create("tx_err_seq");
          tx_err_seq.start(env.virtual_sequencer);
        end
      end

    join

    phase.phase_done.set_drain_time(this,500);
    phase.drop_objection(this, "TEST_DONE");
  endtask
endclass

`endif
