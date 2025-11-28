`ifndef VS_ALG_ERR_RX_TEST_SV
  `define VS_ALG_ERR_RX_TEST_SV

class vs_alg_err_rx_test extends cfs_algn_test_base;
  `uvm_component_utils(vs_alg_err_rx_test)

  vs_alg_legal_config_random_vseqs reg_config_seq;
  vs_alg_illegal_rx_random_vseqs rx_illegal_seq;
  vs_alg_status_read_vseqs status_rd_seq;
  int unsigned no_of_reg_trans = 5;
  int unsigned no_of_rx_trans = 15;
  int unsigned n_dropped_trans = 0;
  
  function new(string name = "vs_alg_err_rx_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this, "TEST_DONE");
    #50;
    
    repeat(no_of_reg_trans)
    begin
      reg_config_seq = vs_alg_legal_config_random_vseqs::type_id::create("reg_config_seq");

      reg_config_seq.start(env.virtual_sequencer);
      repeat(no_of_rx_trans)
      begin
        rx_illegal_seq = vs_alg_illegal_rx_random_vseqs::type_id::create("rx_illegal_seq");

        rx_illegal_seq.start(env.virtual_sequencer);
      end
    end

    n_dropped_trans = env.model.reg_block.STATUS.CNT_DROP.get_mirrored_value();
    
    if(n_dropped_trans !== no_of_reg_trans*no_of_rx_trans)
      `uvm_error("TEST_ISSUE",$sformatf("DRIVING %0d ILLEGAL RX_ TRANSACTIONS..... BUT CNT DROP IS INCREMENTED TO %0d", no_of_reg_trans*no_of_rx_trans, n_dropped_trans))
    
    status_rd_seq = vs_alg_status_read_vseqs::type_id::create("status_rd_seq");
    status_rd_seq.start(env.virtual_sequencer);
 
    phase.phase_done.set_drain_time(this,500);
    phase.drop_objection(this, "TEST_DONE");
  endtask

  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    $display("*****TOTAL NUMBER OF RX TRANSACTIONS DROPPED : %0d*****",n_dropped_trans);
    $display("***** OVERALL FUNCTIONAL COVERAGE : %0.2f%% *****",$get_coverage());
  endfunction
endclass

`endif
