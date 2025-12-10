`ifndef VS_ALG_RX_FIFO_EMPTY_STKY1_TEST_SV
  `define VS_ALG_RX_FIFO_EMPTY_STKY1_TEST_SV

class vs_alg_rx_fifo_empty_stky1_test extends vs_alg_rx_fifo_empty_stky0_test;
  `uvm_component_utils(vs_alg_rx_fifo_empty_stky1_test)

  vs_alg_reg_read_vseqs reg_read_seq;
  vs_alg_irq_irqen_write_vseqs irqen_write_seq;
  vs_alg_irq_irqen_write_vseqs irq_write_seq;
  vs_alg_legal_rx_random_vseqs rx_seq;

  function new(string name = "vs_alg_rx_fifo_empty_stky1_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    $display("\n*****COMPLETED vs_alg_rx_fifo_empty_stky0_test..... NOW RUNNING vs_alg_rx_fifo_empty_stky1_test..... *****\n");
    
    phase.raise_objection(this, "TEST_DONE");

    repeat(10)
    begin
      rx_seq = vs_alg_legal_rx_random_vseqs::type_id::create("rx_seq");
      rx_seq.start(env.virtual_sequencer);
    end
    
    reg_read_seq = vs_alg_reg_read_vseqs::type_id::create("reg_read_seq");
    irq_write_seq = vs_alg_irq_irqen_write_vseqs::type_id::create("irqen_write_seq");
    reg_read_seq.block = env.model.reg_block;
    irq_write_seq.block = env.model.reg_block;

    #50;
    // Checking if IRQ.RX_FIFO_EMPTY remains 1 even if STATUS.RX_LVL != 0
    reg_read_seq.reg_read(env.virtual_sequencer,"STATUS","RX_LVL");
    reg_read_seq.reg_read(env.virtual_sequencer,"IRQ","RX_FIFO_EMPTY");


    // Checking the value of IRQ.RX_FIFO_EMPTY after reseting it
    irq_write_seq.irq_write(env.virtual_sequencer,"RX_FIFO_EMPTY",1'b1);
    reg_read_seq.reg_read(env.virtual_sequencer,"IRQ","RX_FIFO_EMPTY");

    phase.phase_done.set_drain_time(this,500);
    phase.drop_objection(this, "TEST_DONE");
  endtask

  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
  endfunction
endclass

`endif
