`ifndef VS_ALG_MAX_DROP_STKY1_REG_TEST_SV
  `define VS_ALG_MAX_DROP_STKY1_REG_TEST_SV 

class vs_alg_max_drop_stky1_reg_test extends vs_alg_max_drop_stky0_reg_test;
  `uvm_component_utils(vs_alg_max_drop_stky1_reg_test)

  function new(string name = "vs_alg_max_drop_stky1_reg_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    $display("\n*****COMPLETED vs_alg_max_drop_stky0_reg_test..... NOW RUNNING vs_alg_max_drop_stky1_reg_test..... *****\n");

    phase.raise_objection(this, "TEST_DONE");

    // CLearing STATUS.CNT_DROP
    clr_reg_seq.start(env.virtual_sequencer);

    // Checking Sticky1 behavior of IRQ.MAX_DROP
    reg_read_seq.reg_read(env.virtual_sequencer,"STATUS","CNT_DROP");
    reg_read_seq.reg_read(env.virtual_sequencer,"IRQ","MAX_DROP");

    // Setting IRQ.MAX_DROP
    irq_write_seq.irq_write(env.virtual_sequencer,"MAX_DROP",1'b1);
    
    phase.phase_done.set_drain_time(this,500);
    phase.drop_objection(this, "TEST_DONE");
  endtask
endclass

`endif
