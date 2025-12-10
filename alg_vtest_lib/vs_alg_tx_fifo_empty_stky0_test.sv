`ifndef VS_ALG_TX_FIFO_EMPTY_STKY0_TEST_SV
  `define VS_ALG_TX_FIFO_EMPTY_STKY0_TEST_SV

class vs_alg_tx_fifo_empty_stky0_test extends cfs_algn_test_base;
  `uvm_component_utils(vs_alg_tx_fifo_empty_stky0_test)

  vs_alg_irq_irqen_write_vseqs irqen_write_seq;
  vs_alg_irq_irqen_write_vseqs irq_write_seq;
  vs_alg_reg_read_vseqs reg_read_seq;
  vs_alg_legal_rx_random_vseqs rx_seq;
  vs_alg_empty_tx_vseqs tx_seq;
  int unsigned n_bytes_in_buffer = 0;

  function new(string name = "vs_alg_tx_fifo_empty_stky0_test", uvm_component parent = null);
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
    irqen_write_seq.block = env.model.reg_block;
    irq_write_seq.block = env.model.reg_block;
    reg_read_seq.block = env.model.reg_block;

    irqen_write_seq.irqen_write(env.virtual_sequencer,"TX_FIFO_EMPTY","ENABLE"); // Enabling IRQEN.TX_FIFO_EMPTY

    rx_seq = vs_alg_legal_rx_random_vseqs::type_id::create("rx_seq");
    tx_seq = vs_alg_empty_tx_vseqs::type_id::create("tx_seq");

    n_bytes_in_buffer = 0;
    fork
      begin
        rx_seq.start(env.virtual_sequencer);
        n_bytes_in_buffer = n_bytes_in_buffer + rx_seq.seq.item.data.size();;
      end

      begin
       	do begin
          tx_seq = vs_alg_empty_tx_vseqs::type_id::create("tx_seq");
          tx_seq.start(env.virtual_sequencer);
          n_bytes_in_buffer = n_bytes_in_buffer - env.model.reg_block.CTRL.SIZE.get_mirrored_value();
        end while(n_bytes_in_buffer != 0);
      end
    join

    #50;
    reg_read_seq.reg_read(env.virtual_sequencer,"IRQ","TX_FIFO_EMPTY");
    irq_write_seq.irq_write(env.virtual_sequencer,"TX_FIFO_EMPTY",1'b1);

    // Checking if IRQ.TX_FIFO_EMPTY sets immediately after clearing it when
    // STATUS.RX_LVL = 0
    reg_read_seq.reg_read(env.virtual_sequencer,"STATUS","TX_LVL");
    reg_read_seq.reg_read(env.virtual_sequencer,"IRQ","TX_FIFO_EMPTY");

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
