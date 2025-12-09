`ifndef VS_ALG_RX_FIFO_EMPTY_STKY0_TEST_SV
  `define VS_ALG_RX_FIFO_EMPTY_STKY0_TEST_SV

class vs_alg_rx_fifo_empty_stky0_test extends cfs_algn_test_base;
  `uvm_component_utils(vs_alg_rx_fifo_empty_stky0_test)

  vs_alg_reg_read_vseqs reg_read_seq;
  vs_alg_irq_irqen_write_vseqs irqen_write_seq;
  vs_alg_irq_irqen_write_vseqs irq_write_seq;
  vs_alg_legal_rx_random_vseqs rx_seq;

  function new(string name = "vs_alg_rx_fifo_empty_stky0_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this, "TEST_DONE");
    #50;

    irqen_write_seq = vs_alg_irq_irqen_write_vseqs::type_id::create("irqen_write_seq");
    irq_write_seq = vs_alg_irq_irqen_write_vseqs::type_id::create("irq_write_seq");
    reg_read_seq = vs_alg_reg_read_vseqs::type_id::create("reg_read_seq");
    rx_seq = vs_alg_legal_rx_random_vseqs::type_id::create("rx_seq");
    irqen_write_seq.block = env.model.reg_block;
    irq_write_seq.block = env.model.reg_block;
    reg_read_seq.block = env.model.reg_block;

    irqen_write_seq.irqen_write(env.virtual_sequencer,"RX_FIFO_EMPTY","ENABLE"); // Enabling IRQ.RX_FIFO_EMPTY
    rx_seq.start(env.virtual_sequencer);
    
    #50;
    reg_read_seq.reg_read(env.virtual_sequencer,"IRQ");
    irq_write_seq.irq_write(env.virtual_sequencer,"RX_FIFO_EMPTY",1'b1);

    // Checking if IRQ.RX_FIFO_EMPTY sets immediately after clearing it when
    // STATUS.RX_LVL = 0
    reg_read_seq.reg_read(env.virtual_sequencer,"STATUS","RX_LVL");
    reg_read_seq.reg_read(env.virtual_sequencer,"IRQ","RX_FIFO_EMPTY");

    phase.phase_done.set_drain_time(this,500);
    phase.drop_objection(this, "TEST_DONE");
  endtask

  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    $display("***** OVERALL FUNCTIONAL COVERAGE : %0.2f%% *****",$get_coverage());
  endfunction
endclass

`endif
