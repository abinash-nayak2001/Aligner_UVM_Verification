`ifndef VS_ALG_ERR_REG_TEST_SV
  `define VS_ALG_ERR_REG_TEST_SV

class vs_alg_err_reg_test extends cfs_algn_test_base;
  `uvm_component_utils(vs_alg_err_reg_test)
  
  vs_alg_no_addr_vseqs no_addr_seq;
  vs_alg_no_acc_vseqs no_acc_seq;
  vs_alg_illegal_config_vseqs illegal_config_seq;
  int unsigned n_bytes_in_buffer = 0;
  int unsigned n_no_addr_seq = 15;
  int unsigned n_no_acc_seq = 5;
  int unsigned n_illegal_config_seq = 30;
  int unsigned alg_data_width = 32;

  function new(string name = "vs_alg_err_reg_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    env.apb_agent.sequencer.set_arbitration(SEQ_ARB_RANDOM);
  endfunction

  task run_phase(uvm_phase phase);
  	phase.raise_objection(this, "TEST_DONE");
  	#50;
  	
  	no_addr_seq = vs_alg_no_addr_vseqs::type_id::create("no_addr_seq");
  	no_acc_seq = vs_alg_no_acc_vseqs::type_id::create("no_acc_seq");
  	illegal_config_seq = vs_alg_illegal_config_vseqs::type_id::create("illegal_config_seq");
  	illegal_config_seq.alg_data_width = this.alg_data_width;

    fork
      begin
        repeat(n_no_addr_seq)
          no_addr_seq.start(env.virtual_sequencer);
      end
      begin
        repeat(n_no_acc_seq)
          no_acc_seq.start(env.virtual_sequencer);
      end
      begin
        repeat(n_illegal_config_seq)
          illegal_config_seq.start(env.virtual_sequencer);
      end
    join
  	
  	phase.phase_done.set_drain_time(this,500);
	phase.drop_objection(this, "TEST_DONE");
  endtask

  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    $display("*****NUMBER OF BYTES LEFT IN ALIGNER WHICH ARE NOT TAKEN OUT AFTER TEST_DONE : %0d*****", n_bytes_in_buffer);
    $display("***** OVERALL FUNCTIONAL COVERAGE : %0.2f%% *****",$get_coverage());
  endfunction

endclass

`endif
