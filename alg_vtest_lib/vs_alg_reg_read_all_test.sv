`ifndef VS_ALG_REG_READ_ALL_TEST_SV
  `define VS_ALG_REG_READ_ALL_TEST_SV

class vs_alg_reg_read_all_test extends cfs_algn_test_base;
  `uvm_component_utils(vs_alg_reg_read_all_test)

  vs_alg_reg_read_vseqs reg_read_seq;
  rand vs_alg_master_rx_seq rx_seq;

  function new(string name = "vs_alg_reg_read_all_test", uvm_component parent = null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    env.agent_config.set_stuck_threshold(5000);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this, "TEST_DONE");
    #50;

    repeat(16)
    begin
      rx_seq = vs_alg_master_rx_seq::type_id::create("rx_seq");
      
      assert(rx_seq.randomize()) else
        `uvm_error("RX_SEQ","RANDOMIZATION FAILED")
      rx_seq.start(env.md_rx_agent.sequencer);

      #50;
      reg_read_seq = vs_alg_reg_read_vseqs::type_id::create("reg_read_seq");
      reg_read_seq.block = env.model.reg_block;
      reg_read_seq.reg_read(env.virtual_sequencer,"STATUS");
    end

    phase.phase_done.set_drain_time(this,500);
    phase.drop_objection(this, "TEST_DONE");
  endtask
endclass

`endif
